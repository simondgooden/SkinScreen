import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiagnosisPage extends StatefulWidget {
  final List<dynamic> conditions;
  final dynamic image;
  const DiagnosisPage(
      {super.key, required this.conditions, required this.image});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  final classes = ['akiec', 'bcc', 'bkl', 'df', 'mel', 'nv', 'vasc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'AI Results',
          style: TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.image.path,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Possible Conditions ',
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Visibility(
                      visible: widget.conditions.contains('akeic'),
                      child: Row(
                        children: [
                          _medicalInfo(
                              'Actinic Keratoses and Intraepithelial Carcinoma',
                              'This category includes precancerous skin lesions (actinic keratoses) and intraepithelial carcinoma (Bowen\'s disease), which are considered early forms of squamous cell carcinoma.'),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('bcc'),
                      child: Column(
                        children: [
                          _medicalInfo('Basal Cell Carcinoma',
                              'Basal cell carcinoma is a common type of skin cancer that arises from the basal cells of the skin\'s outer layer (epidermis).'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('bkl'),
                      child: Column(
                        children: [
                          _medicalInfo('Benign Keratosis-Like Lesions',
                              'Benign keratosis-like lesions encompass a variety of non-cancerous skin conditions such as solar lentigines (sun spots), seborrheic keratoses, and lichen-planus like keratoses.'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('df'),
                      child: Column(
                        children: [
                          _medicalInfo('Dermatofibroma',
                              'Dermatofibroma is a benign skin growth that typically appears as a firm nodule or bump under the skin.'),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('mel'),
                      child: Column(
                        children: [
                          _medicalInfo('Melanoma',
                              'Melanoma is a type of skin cancer that originates in the pigment-producing cells (melanocytes) of the skin and can be potentially life-threatening if not detected and treated early.'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('nv'),
                      child: Column(
                        children: [
                          _medicalInfo('Melanocytic Nevi',
                              'Melanocytic nevi refer to common moles, which are benign growths on the skin composed of melanocytes.'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.conditions.contains('vasc'),
                      child: Column(
                        children: [
                          _medicalInfo('Vascular Lesions',
                              'Vascular lesions include a range of skin abnormalities involving blood vessels, such as angiomas (benign tumors made up of blood vessels), angiokeratomas, pyogenic granulomas, and hemorrhage-related skin conditions.'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _medicalInfo(String condition, String info) {
  return Container(
    width: 361,
    height: 213,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    decoration: ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.63, -0.78),
        end: Alignment(-0.63, 0.78),
        colors: [Color(0xFF283255), Color(0xFF141A30)],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 321,
          height: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        condition,
                        style: TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 320,
                      height: 70,
                      child: Text(
                        info,
                        style: TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff0F67FD),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
