from flask import Flask, request, jsonify
import torchvision.transforms as transforms
import torchvision
from PIL import Image
import torch
import torch.nn as nn
import torch.nn.functional as F
import werkzeug
import os

app = Flask(__name__)


class AlexNet(nn.Module):
    def __init__(self):
        super(AlexNet, self).__init__()
        self.features = nn.Sequential(
            nn.Conv2d(3, 64, kernel_size=11, stride=4, padding=2),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3, stride=2),
            nn.Conv2d(64, 192, kernel_size=5, padding=2),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3, stride=2),
            nn.Conv2d(192, 384, kernel_size=3, padding=1),
            nn.ReLU(inplace=True),
            nn.Conv2d(384, 256, kernel_size=3, padding=1),
            nn.ReLU(inplace=True),
            nn.Conv2d(256, 256, kernel_size=3, padding=1),
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3, stride=2),
        )
        self.avgpool = nn.AdaptiveAvgPool2d((6, 6))
        self.classifier = nn.Sequential(
            nn.Dropout(),
            nn.Linear(256 * 6 * 6, 4096),
            nn.ReLU(inplace=True),
            nn.Dropout(),
            nn.Linear(4096, 1024),
            nn.ReLU(inplace=True),
            nn.Linear(1024, 7),  # Assuming 7 classes for the output
        )

    def forward(self, x):
        x = self.features(x)
        x = self.avgpool(x)
        x = torch.flatten(x, 1)
        x = self.classifier(x)
        return x


# Load the model
model = AlexNet()
model.load_state_dict(torch.load('backend/model.pth'))
model.eval()

classes = ['akiec', 'bcc', 'bkl', 'df', 'mel', 'nv', 'vasc']

transform = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),

    transforms.Normalize(mean=[0.485, 0.456, 0.406],
                         std=[0.229, 0.224, 0.225]),
])


def predictions(img_path):

    predictions = {'result': []}

    img = Image.open(img_path)
    img = img.convert('RGB')

    input = transform(img)
    input = input.unsqueeze(0)

    with torch.no_grad():
        output = model(input)

    probabilities = F.softmax(output, dim=1)[0]

    num_classes = len(classes)
    top5_probabilities, top5_indices = torch.topk(probabilities, 7)
    top5_probabilities = top5_probabilities.tolist()
    top5_indices = top5_indices.tolist()
    top5_classes = [classes[idx] for idx in top5_indices]

    for i in range(7):
        if (top5_probabilities[i] > 0.1):
            predictions['result'].append(top5_classes[i])

    return predictions



@app.route('/upload', methods=["POST"])
def upload():
    if request.method == "POST":
        imageFile = request.files['image']
        fileName = werkzeug.utils.secure_filename(imageFile.filename)
        imageFile.save("./images" + fileName)

        image_path = "./images" + fileName
        prediction = predictions(image_path)

        os.remove(image_path)

        return jsonify(prediction)


if __name__ == "__main__":
    app.run(debug=True, port=8000)
