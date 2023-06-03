import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:junews/model/colege_model.dart';

import 'package:junews/model/news_model.dart';
import 'package:junews/model/user_model.dart';

class HomeScreenController extends GetxController {
  UserModel user =UserModel(email: "", nameEN: "Rayan Asad", nameAR: "ريان أسعد", collegeEN: "School of Information Technology", collegeAR: "كلية الملك عبدالله الثاني لتكنولوجيا المعلومات", pic: "assets/images/rayan.jfif", uid: "");
 bool isLoading = false;

  Stream<List<CollegeModel>> readCollegesData() {
    colleges.clear();
    return FirebaseFirestore.instance.collection("colleges").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => CollegeModel.fromJson(doc.data()))
            .toList());
  }

  Future readUsersData() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      user.nameEN = value.get("nameEN");
      user.nameAR = value.get("nameAR");
      user.collegeEN = value.get("collegeEN");
      user.collegeAR = value.get("collegeAR");
      user.pic = value.get("pic");
    });
  }

  Stream<List<NewsDataModel>> readNewsData() {
    allNews.clear();
     // readUsersData();
    return FirebaseFirestore.instance.collection("news").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => NewsDataModel.fromJson(doc.data()))
            .toList());
  }

  separateNews() {
    universityNews.clear();
    collegesNews.clear();
    for (int i = 0; i < allNews.length; i++) {
      if (allNews[i].collegeName == "University News") {
        universityNews.add(allNews[i]);
      }
      if (allNews[i].collegeName != "University News") {
        collegesNews.add(allNews[i]);
      }
    }
    print("universityNews${universityNews.length}");
    print("collegesNews${collegesNews.length}");
  }

  separateCollegesNews({required String collegeName}) {
    collegeData.clear();
    for (int i = 0; i < collegesNews.length; i++) {
      if (collegesNews[i].collegeName == collegeName) {
        collegeData.add(collegesNews[i]);
      }
    }
    print("collegeData$collegeData");
  }

  List<CollegeModel> colleges = [];
  List<NewsDataModel> collegesNews = [];

  List<NewsDataModel> allNews = [
    // NewsDataModel(
    //   title:
    //       "Jordanian Universities Conclude Participation In University Expo Qatar ",
    //   titleAR: "الجامعة الأردنية تختمم مشاركتها في معرض اكسبو جامعة قطر",
    //   content:
    //       "The University Expo Qatar concluded in Doha on Monday with the participation of Jordanian public and private universities.\n\n"
    //       "Universities from the United Kingdom, the United States of America, Australia, Switzerland, Malaysia, Germany, Hungary, Turkey, France and the UAE, in addition to Qatar, participated in the event.\n\n"
    //       "The Undersecretary of the Qatari Ministry of Education, Omar Al-Nema,said that the exhibition targeted students in the ninth, tenth, eleventh and twelfth grades in order to prepare them for the future majors that universities provide. (Petra).",
    //   contentAR:
    //       "اختتم معرض جامعة قطر في الدوحة يوم الاثنين بمشاركة جامعات أردنية حكومية وخاصة."
    //       "وشارك في الحدث جامعات من المملكة المتحدة والولايات المتحدة الأمريكية وأستراليا وسويسرا وماليزيا وألمانيا والمجر وتركيا وفرنسا والإمارات ، بالإضافة إلى قطر."
    //       "وقال وكيل وزارة التربية والتعليم القطرية ، عمر النعمة ، إن المعرض استهدف طلبة الصف التاسع والعاشر والحادي عشر والثاني عشر بهدف إعدادهم لتخصصات المستقبل التي تقدمها الجامعات.",
    //   urlImage: "assets/images/junews.png",
    //   collegeName: "University News",
    //   id: 1,
    //   audioFileEN: "assets/audio/1en.mp3",
    //   audioFileAR: "assets/audio/1ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Harvard University Delegation Visits JU",
    //   titleAR: "وفد من جامعة هارفارد يزور الجامعة الأردنية",
    //   content:
    //       "A delegation from Harvard University visited the University of Jordan (UJ) on Sunday to explore opportunities for academic cooperation between the two institutions in various fields, including student and faculty exchange and research collaboration.\n\n"
    //       "JU President Prof.Nadhir Obeidat, highlighted during the meeting with the delegation headed by Harvard President Lawrence Bacow, the university's focus on developing programmes that prioritise student employability as well as skills,knowledge and personal characteristics that prepare graduates for success in their professional lives and enhance scientific research output.The meeting was attended by UJ Board of Trustees Chairman Prof. Adnan Badran;Vice President for Scientific Schools.\n\n"
    //       "Prof. Ashraf Abu Karaki; Director of the International Affairs Unit, Prof. Hadeel Yassin; and Director of the Media, Public Relations and Radio Unit, Dr. Muhammad Wasef.The delegation visited UJ library, toured its facilities,"
    //       " and met with some students at the “American Corner” and engaged in a discussion on environmental pollution, climate change and the role of youth in mitigating their effects.In addition, the delegation visited the Archaeological and Heritage museums on campus.",
    //   contentAR:
    //       "زار وفد من جامعة هارفارد الجامعة الأردنية يوم الأحد لاستكشاف فرص التعاون الأكاديمي بين المؤسستين في مختلف المجالات ، بما في ذلك تبادل الطلاب وأعضاء هيئة التدريس والتعاون البحثي."
    //       "أبرز رئيس الجامعة الأردنية الأستاذ الدكتور نذير عبيدات خلال الاجتماع مع الوفد برئاسة رئيس جامعة هارفارد لورانس باكو تركيز الجامعة على تطوير البرامج التي تعطي الأولوية لتوظيف الطلاب بالإضافة إلى المهارات والمعرفة والخصائص الشخصية التي تعد الخريجين للنجاح في حياتهم المهنية و تعزيز مخرجات البحث العلمي."
    //       "حضر الاجتماع رئيس مجلس أمناء الجامعة الأردنية الأستاذ الدكتور عدنان بدران. نائب رئيس الجامعة للكليات العلمية أ. أشرف أبو كركي. مدير وحدة الشؤون الدولية الاستاذ هديل ياسين؛ ومدير وحدة الإعلام والعلاقات العامة والإذاعة د.محمد واصف."
    //       "وقام الوفد بزيارة مكتبة الجامعة ، وتجول في مرافقها ، والتقى ببعض الطلاب في الركن الأمريكي وشارك في نقاش حول التلوث البيئي وتغير المناخ ودور الشباب في التخفيف من آثارها، كما قام الوفد بزيارة المتاحف الأثرية والتراثية في الحرم الجامعي.",
    //   urlImage: "assets/images/Harvrd.png",
    //   collegeName: "University News",
    //   id: 2,
    //   audioFileEN: "assets/audio/2en.mp3",
    //   audioFileAR: "assets/audio/2ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Deanship of Scientific Research at UJ Holds a Workshop on Scientific Citations and how can a Researcher Achieve International Recognition",
    //   titleAR:
    //       "عمادة البحث العلمي بالجامعة الأردنية تقيم ورشة عمل حول الاستشهادات العلمية وكيف يمكن للباحث تحقيق الاعتراف الدولي",
    //   content:
    //       "On Thursday, March 9, the Deanship of Scientific Research at the University of Jordan held a workshop on “Scientific Citations, and How Can a Researcher Achieve International Recognition?” The workshop was delivered by Prof. Ibrahim Al-Jarrah,Head of the Department of Artificial Intelligence at King Abdullah II College of Information Technology, who is ranked among the most cited researchers in his field worldwide.\n\n"
    //       "A group of faculty members and researchers in addition to postgraduate students from various disciplines participated in the workshop which was designed to build and enhance their research skills and capabilities.\n\n"
    //       "This course comes within a series of training courses held by the Deanship of Scientific Research throughout the year with the aim of developing the capabilities of faculty members and researchers in the field of scientific research.",
    //   contentAR:
    //       " عقدت عمادة البحث العلمي في الجامعة الأردنية يوم الخميس 9 مارس الجاري ورشة عمل بعنوان الاستشهادات العلمية وكيف يمكن للباحث تحقيق الاعتراف الدولي؟ قدم الورشة الأستاذ الدكتور إبراهيم الجراح ، رئيس قسم الذكاء الاصطناعي في كلية الملك عبد الله الثاني لتكنولوجيا المعلومات ، والذي يُصنف من بين الباحثين الأكثر استشهاداً في مجاله على مستوى العالم."
    //       "وشارك في الورشة مجموعة من أعضاء هيئة التدريس والباحثين وطلبة الدراسات العليا من مختلف التخصصات ، والتي صممت لبناء وتعزيز مهاراتهم وقدراتهم البحثية."
    //       "تأتي هذه الدورة ضمن سلسلة الدورات التدريبية التي تعقدها عمادة البحث العلمي على مدار العام بهدف تنمية قدرات أعضاء هيئة التدريس والباحثين في مجال البحث العلمي.",
    //   urlImage: "assets/images/Res.png",
    //   collegeName: "University News",
    //   id: 3,
    //   audioFileEN: "assets/audio/3en.mp3",
    //   audioFileAR: "assets/audio/3ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Who Experts visits JU hospital Within the Patient Safety Friendly Hospital Initiative",
    //   titleAR:
    //       "عدد من الخبراء يزورون مستشفى الجامعة الأردنية ضمن مبادرة المستشفيات الصديقة لسلامة المرضى",
    //   content:
    //       "A team of experts from the World Health Organization concludes its visit to the JU Hospital on Wednesday 21st March, 2022, as part of the Patient Safety Friendly Hospital Initiative.\n\n"
    //       "The visit, which lasted for (3) days, included tours of the most prominent departments and vital units of the hospital, during which a full survey of the hospital was conducted in addition to a review of the policies adopted for patient safety.\n\n"
    //       "In turn, the Director General of the hospital, Prof. Jamal Melhem, said that this visit demonstrated the extent to which the hospital applied quality requirements in terms of patient safety, public safety and infection control policies, noting that the most prominent observations that the team monitored were positive ones, pointing out that JU Hospital is The first hospital to participate in this initiative.\n\n"
    //       "Melhem thanked the hospital staff for their efforts that had a great impact on the development of health care services provided, stressing that the wheel of development does not stop and the hospital will continue to work to remain a leading medical entity for all health sector institutions.",
    //   contentAR:
    //       "يختتم فريق خبراء من منظمة الصحة العالمية زيارته إلى مستشفى الجامعة يوم الأربعاء 21 مارس 2022 ، كجزء من مبادرة المستشفيات الصديقة لسلامة المرضى."
    //       "واشتملت الزيارة التي استمرت (3) أيام ، على جولات لأبرز الأقسام والوحدات الحيوية بالمستشفى ، تم خلالها إجراء مسح كامل للمستشفى بالإضافة إلى استعراض السياسات المتبعة من أجل سلامة المرضى."
    //       "بدوره ، قال مدير عام المستشفى الأستاذ الدكتور جمال ملحم ، إن هذه الزيارة أظهرت مدى تطبيق المستشفى لمتطلبات الجودة من حيث سلامة المرضى والسلامة العامة وسياسات مكافحة العدوى ، مشيرا إلى أن أبرز الملاحظات أن الفريق الذي رصده الفريق كان إيجابياً ، مشيراً إلى أن مستشفى الجامعة هو أول مستشفى يشارك في هذه المبادرة."
    //       "وشكر ملحم العاملين بالمستشفى على جهودهم التي كان لها أثر كبير في تطوير خدمات الرعاية الصحية المقدمة ، مؤكدا أن عجلة التطور لا تتوقف وسيستمر المستشفى في العمل ليظل كيانًا طبيًا رائدًا لجميع مؤسسات القطاع الصحي.",
    //   urlImage: "assets/images/hospital.png",
    //   collegeName: "University News",
    //   id: 4,
    //   audioFileEN: "assets/audio/4en.mp3",
    //   audioFileAR: "assets/audio/4ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "JU President, Chile Ambassador Discuss Exchange Programmes",
    //   titleAR: "رئيس الجامعة الأردنية وسفير تشيلي يناقشان برامج التبادل",
    //   content:
    //       "President of the University of Jordan (UJ) Prof. Nadhir Obeidat and  Ambassador of Chile Jorge Alejandro Tagle Canelo on Tuesday discussed cooperation between the university and Chilean higher education institutions.\n\n"
    //       "The two sides discussed faculty, researcher and student exchanges in Arabic language studies and political science.\n\n"
    //       "Obeidat stressed the importance of building effective strategic partnerships with stakeholders locally, regionally and globally to exchange expertise for the benefit of the university, its students and its academic staff.\n\n"
    //       "For his part, Canelo referred to the possibility of signing a memorandum of understanding with the University of Chile, stressing his desire to establish strong academic cooperation with Jordan.",
    //   contentAR:
    //       "ناقش رئيس الجامعة الأردنية الأستاذ الدكتور نذير عبيدات وسفير تشيلي خورخي أليخاندرو تاغلي كانيلو يوم الثلاثاء التعاون بين الجامعة ومؤسسات التعليم العالي التشيلية."
    //       "وناقش الجانبان تبادل أعضاء هيئة التدريس والباحثين والطلاب في دراسات اللغة العربية والعلوم السياسية."
    //       "وشدد عبيدات على أهمية بناء شراكات استراتيجية فاعلة مع أصحاب المصلحة محلياً وإقليمياً وعالمياً لتبادل الخبرات لصالح الجامعة وطلابها وكادرها الأكاديمي."
    //       "من جهته ، أشار كانيلو إلى إمكانية توقيع مذكرة تفاهم مع جامعة تشيلي ، مؤكداً رغبته في إقامة تعاون أكاديمي قوي مع الأردن.",
    //   urlImage: "assets/images/Chile.png",
    //   collegeName: "University News",
    //   id: 5,
    //   audioFileEN: "assets/audio/5en.mp3",
    //   audioFileAR: "assets/audio/5ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Donation of Books on Japan to the University of Jordan",
    //   titleAR: "منحة كتب يابانية الى الجامعة الأردنية",
    //   content:
    //       "The University of Jordan (UJ) Library on Tuesday received a valuable collection of books in Japanese, English and Arabic of interest to students and scholars in various fields, such as literature, culture, history, Japanese language, as well as politics and economics,as a contribution from Japan Foundation.\n\n"
    //       "In his address during the handing over ceremony, UJ president Prof. Nadhir Obeidat valued the donation aims at providing researchers in Japanese affairs with valuable information, stressing the deep rooted bilateral  relations between the university and the Japanese embassy and partner institutions, based on the profound mutual relations between the two friendly countries.\n\n"
    //       "For his part, the Ambassador of Japan to Jordan, Jiro Okuyama, expressed gratitude for the important role played by the university in the field of teaching the Japanese language, expressing his hope that the books will contribute to enhancing mutual understanding between Japan and Jordan by deepening Jordanian's understanding of Japan; its culture, language and history.\n\n"
    //       "Library Unit Director, Dr. Mujahed Thneibat, pointed out that the library, which houses more than one and a half million books in various fields of knowledge, has been a meeting point for people from across the world for over 60 years,stressing that it serves beyond its traditional role to act as a gateway to knowledge and culture, welcoming more qualitative donations and cooperation between Library and embassy.",
    //   contentAR:
    //       "تلقت مكتبة الجامعة الأردنية يوم الثلاثاء مجموعة قيمة من الكتب باللغات اليابانية والإنجليزية والعربية تهم الطلاب والعلماء في مختلف المجالات ، مثل الأدب والثقافة والتاريخ واللغة اليابانية ، وكذلك السياسة والاقتصاد. كمساهمة من مؤسسة اليابان."
    //       "وثمن رئيس الجامعة الأستاذ الدكتور / نذير عبيدات في خطابه خلال حفل التسليم أن التبرع يهدف إلى تزويد الباحثين في الشئون اليابانية بمعلومات قيمة ، مؤكدا العلاقات الثنائية العميقة الجذور بين الجامعة والسفارة اليابانية والمؤسسات الشريكة انطلاقا من عمقها. العلاقات المتبادلة بين البلدين الصديقين."
    //       "من جانبه ، أعرب سفير اليابان لدى الأردن ، جيرو أوكوياما ، عن امتنانه للدور المهم الذي تقوم به الجامعة في مجال تعليم اللغة اليابانية ، معربًا عن أمله في أن تساهم الكتب في تعزيز التفاهم المتبادل بين اليابان والأردن من خلال تعميق فهم الأردنيين لليابان. ثقافتها ولغتها وتاريخها."
    //       "وأشار مدير وحدة المكتبات الدكتور مجاهد ذنيبات إلى أن المكتبة التي تضم أكثر من مليون ونصف كتاب في مختلف مجالات المعرفة كانت نقطة التقاء للناس من جميع أنحاء العالم لأكثر من 60 عاما ، مؤكدا أنها يتجاوز دوره التقليدي ليكون بمثابة بوابة للمعرفة والثقافة ، ويرحب بالمزيد من التبرعات النوعية والتعاون بين المكتبة والسفارة. ",
    //   urlImage: "assets/images/lib.png",
    //   collegeName: "University News",
    //   id: 6,
    //   audioFileEN: "assets/audio/6en.mp3",
    //   audioFileAR: "assets/audio/6ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The College of Art and Design at UJ hosts a delegation from the Italian University of Palermo to discuss ways to enhance cooperation",
    //   titleAR:
    //       "كلية الفنون والتصميم في الأردنية تستضيف وفدًا من جامعة باليرمو الإيطالية لتباحث سبل تعزيز التعاون ",
    //   content:
    //       "The Faculty of Art and Design at the University of Jordan welcomed Dr. Maria Antonita Malio from the Palermo Academy of Arts at the Italian University of Palermo, as part of the ongoing cooperation between the Faculty and the Academy in various fields.\n\n"
    //       "Malio and the accompanying delegation met with the Dean of the College, Dr. Muhammad Nassar, and faculty members in the Department of Visual Arts, to agree to continue cooperation in the field of exchanging experiences and joint research, in addition to holding workshops, exhibitions and scientific visits for faculty members and students, in addition to their search for ways to open joint programs centered on Artificial intelligence in relation to the arts.\n\n"
    //       "Nassar said that the college seeks to establish partnerships with faculties of art and design in international universities with a prestigious academic reputation, and that its vision is consistent with the university's mission and future aspirations to modernize and develop academic programs, research cooperation and exchange of experiences.\n\n"
    //       "During the meeting, the Vice Dean for Quality Affairs, Dr. Fouad Khasawneh, and the Head of the Visual Arts Department, spoke during the meeting, stressing that the department seeks to benefit from this cooperation by holding joint workshops, developing study plans, and exchanging academic experiences."
    //       "For her part, Malio praised the good reputation of the University of Jordan and the prestigious level it witnessed in the Faculty of Art and Design. Necessary for developing study plans and opening joint programs, specifically those related to artificial intelligence and how to employ it in various arts disciplines.\n"
    //       "In addition, Malio gave a lecture on visual arts in the Mediterranean region, which was attended by college students and faculty members.",
    //   contentAR:
    //       "استقبلت كلية الفنون والتصميم في الجامعة الأردنية الدكتورة ماريا أنتونيتا ماليو من أكاديمية باليرمو للفنون في جامعة باليرمو الإيطالية، وذلك في إطار التعاون المستمر بين الكلية والأكاديمية في مجالات مختلفة."
    //       "والتقت ماليو والوفد المرافق عميد الكلية الدكتور محمد نصار وأعضاء هيئة التدريس في قسم الفنون البصرية، ليتفقا على استمرار التعاون في مجال تبادل الخبرات والأبحاث المشتركة، إضافة إلى عقد ورش العمل والمعارض والزيارات العلمية لأعضاء هيئة التدريس والطلبة، إلى جانب بحثهما لسبل فتح برامج مشتركة تتمحور حول الذكاء الاصطناعي في علاقته بالفنون."
    //       "وقال نصار إنّ الكلية تسعى إلى عقد شراكات مع كليات الفنون والتصميم في الجامعات العالمية ذات السمعة الأكاديمية المرموقة، وأنّ رؤيتها تنسجم مع رسالة الجامعة وتطلعاتها المستقبلية لتحديث وتطوير البرامج الأكاديمية والتعاون البحثي وتبادل الخبرات."
    //       "وتحدث خلال اللقاء نائب العميد لشوؤن الجودة الدكتور فؤاد خصاونة ورئيس قسم الفنون البصرية، مؤكّدين أن القسم يسعى إلى الاستفادة من هذ التعاون بعقد ورش عمل مشتركة وتطوير الخطط الدراسية وتبادل الخبرات الأكاديمية."
    //       "من جانبها أثنت ماليو على السمعة الطيبة التي تتميز بها الجامعة الأردنية، والمستوى المرموق الذي شهدته في كلية الفنون والتصميم، إذ أطرت على مواكبتها لركب التطور والتقدم في المجالات الفنية المختلفة، معبّرة عن رغبتها أن يقود هذا اللقاء إلى استمرار التعاون، وأن يساهم في بحث السبل اللازمة لتطوير الخطط الدراسية وفتح برامج مشتركة، تحديدًا تلك المتعلقة بالذكاء الاصطناعي وكيفية توظيفه في تخصصات الفنون على اختلافها."
    //       "إلى جانب ذلك، قدّمت ماليو محاضرة عن الفنون البصرية في منطقة البحر الأبيض المتوسط، حضرها طلبة الكلية وأعضاء الهيئة التدريسية.",
    //   urlImage: "assets/images/palermo.jpg",
    //   collegeName: "University News",
    //   id: 7,
    //   audioFileEN: "assets/audio/7en.mp3",
    //   audioFileAR: "assets/audio/7ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A scientific day at the Language Center at UJ in celebration of the International Day of the English Language",
    //   titleAR:
    //       "يوم علمي في مركز اللغات في الأردنية احتفاء باليوم العالمي للغة الإنجليزية",
    //   content:
    //       "Deputizing for the President of the University of Jordan, Dr. Nazir Obeidat, his Vice President for Humanities Faculties Affairs, Dr. Salama Al-Naimat, inaugurated the activities of the Scientific Day of the English Language, which is organized by the Language Center at the University today, under the title: “English vs. Arabic: Are They Really that Different?”, which included a number From lectures, activities and student competitions.\n\n"
    //       "Al-Naimat said, in his opening speech for the day that is held to celebrate the International Day of the English Language, that language, any language, is the identity of the nation, with all the meanings of the word, as it is the expression of civilization through its vocabulary and structures.\n\n"
    //       "He noted the importance of the Arabic language as the language of the Holy Qur’an, and the importance of paying attention to learning other languages, stressing the necessity of mastering the Arabic language first, calling on students to master their language as something essential, and then paying attention to learning other languages, stressing the center’s role in emphasizing the importance of the two languages Arabic and English.\n\n"
    //       "For his part, the Director of the Language Center, Dr. Sami Ababneh, said that language is a means of communication between peoples, but in its deeper meaning, it goes beyond this role to be the means by which a person looks at the world, as it reflects the structure of human thinking, which is the storehouse of human experience and heritage, pointing out that the processes Exchange between languages is a natural matter as a result of the convergence of peoples.\n\n"
    //       "Ababneh pointed out that the Arabic language is one of the oldest languages that are still spoken until now, and that English has a wide presence at the present time, stressing that the interest in the relationship between the two languages aims to connect daily living experiences with the language, noting that the Language Center at the university is keen on this type. of the encounter between the two languages.\n\n"
    //       "Assistant Professor of Literature in the Department of English at the University, Dr. Duaa Salama, dealt with the topic of \"acculturation\", that is, the cultural encounter between English and Arabic.\n\n"
    //       "The second session included an introductory workshop for the Fulbright Program, presented by the Program Officer in Jordan, Nasser Malkawi, and a lecture on scholarships offered to students and faculty members from the US Embassy, presented by Erran Williams, the official of the Regional English Language Office at the Embassy.\n\n"
    //       "While the last session discussed \"The Theory of Marking in Language Description and Acquisition\", presented by Professor of Linguistics in the Department of English, Dr. Jihad Hamdan.",
    //   contentAR:
    //       "مندوبًا عن رئيس الجامعة الأردنية الدكتور نذير عبيدات، افتتح نائبه لشؤون الكليات الإنسانية الدكتور سلامة النعيمات، فعاليات اليوم العلمي للغة الإنجليزية الذي ينظمه مركز اللغات في الجامعة اليوم، بعنوان: English vs. Arabic: Are They Really that Different، والذي شمل عددًا من المحاضرات والنشاطات والمسابقات الطلابية."
    //       "وقال النعيمات، في كلمته الافتتاحية لليوم الذي يقام احتفالا باليوم العالمي للغة الإنجليزية، إن اللغة، أي لغة، هي هوية الأمة، بكل ما تحمله الكلمة من معانٍ، فهي المُعبِّر عن الحضارة من خلال مفرداتها وتراكيبها."
    //       "ونوه إلى أهمية اللغة العربية بوصفها لغة القرآن الكريم، وإلى أهمية الاهتمام بتعلم اللغات الأخرى، مؤكدا ضرورة حسن إتقان اللغة العربية أولا، داعيًا الطلبة الى إتقان لغتهم بوصفها شيئًا أساسيًّا، ومن ثم الاهتمام بتعلم اللغات الأخرى، مشدّدًا على دور المركز في التأكيد على أهمية اللغتين العربية والإنجليزية."
    //       "من جهته، قال مدير مركز اللغات الدكتور سامي عبابنة إن اللغة وسيلة التواصل بين الشعوب، لكنها بمعناها الأعمق، تتجاوز هذا الدور لتكون الوسيلة التي ينظر فيها الإنسان إلى العالم، إذ تعكس بنية التفكير الإنساني، وهي مخزون التجربة والتراث الإنساني، لافتًا إلى أن حدوث عمليات تبادل بين اللغات أمر طبيعي نتيجة تقارب الشعوب."
    //       "وأشار عبابنة إلى أن اللغة العربية إحدى أقدم اللغات التي لا تزال محكية حتى الآن، وأن الإنجليزية لها حضور واسع في الوقت الحالي، مؤكدًا أن الاهتمام بالعلاقة بين اللغتين يهدف إلى وصل التجارب المَعيشة يوميًّا باللغة، مشيرا إلى أن مركز اللغات في الجامعة يحرص على هذا النوع من التلاقي بين اللغتين."
    //       "وتناولت الأستاذة المساعدة في الأدب في قسم اللغة الإنجليزية في الجامعة الدكتورة دعاء سلامة موضوع التثاقف، أي اللقاء الثقافي بين الإنجليزية والعربية، حيث عرضت لهذا اللقاء من خلال الحقب التاريخية المختلفة، موضحة أهمية هذا التثاقف، إضافة إلى أهمية اللغة بوصفها نتاجًا ثقافيًّا للمجتمعات."
    //       "وتضمنت الجلسة الثانية ورشة تعريفية لبرنامج فولبرايت قدمها المسؤول عن البرنامج في الأردن ناصر ملكاوي، ومحاضرة عن المنح المقدمة للطلبة وأعضاء الهيئة التدريسية من السفارة الأمريكية قدمها مسؤول المكتب الإقليمي للغة الإنجليزية في السفارة إران ويليامز."
    //       "فيما ناقشت الجلسة الأخيرة نظرية الوسم في وصف اللغة واكتسابها، قدمها أستاذ اللغويات في قسم اللغة الإنجليزية الدكتور جهاد حمدان.",
    //   urlImage: "assets/images/LanguageCenter2.jpg",
    //   collegeName: "University News",
    //   id: 8,
    //   audioFileEN: "assets/audio/8en.mp3",
    //   audioFileAR: "assets/audio/8ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "During his participation in the scientific forum of the Faculty of Educational Sciences.. The President of the University of Jordan calls for the adoption of flipped education to reduce the burdens of the educational process",
    //   titleAR:
    //       "أثناء مشاركته في المنتدى العلمي لكلية العلوم التربوية .. رئيس الجامعة الأردنية يدعو إلى انتهاج التعليم المقلوب للتخفيف من أعباء العمليّة التعليميّة",
    //   content:
    //       "The President of the University of Jordan, Dr. Nazir Obeidat, while attending the scientific forum of the Faculty of Educational Sciences, which came under the auspices of the Chairman of the University’s Board of Trustees, Dr. Adnan Badran, called for the adoption of flipped education in our universities to reduce the burdens of the educational process, describing it as a form of education that appeared in education. Higher education in the early 2000s, and has witnessed rapid growth since the beginning of this decade.\n\n"
    //       "In his speech, in which he asked the audience a number of questions and ideas that clarify the form of education in the future, and the University of Jordan's vision for it in the short and long term, Obeidat added that this form of education allows students to communicate with new materials through self-organized teaching, to use the time dimension. Remedial in experiments concerned with active learning.\n\n"
    //       "He pointed to a number of challenges facing the application of this form of education, including formulating a common definition of flipped learning, the need to produce a set of rigorous empirical research that identifies results related to the effectiveness of this type of education, and the need to establish a global library of open educational resources that support this form. And the need to find and build a global network of individuals and academic communities interested in applying it.\n\n"
    //       "Obeidat touched on the developments that govern university education in the future, pointing out that the rapid change that is taking place in societies causes great pressures, and he also pointed to the pressures imposed on universities in order to provide an environment that takes into account the technological revolution, especially in light of the fourth industrial revolution that We are witnessing it.\n\n"
    //       "Regarding the funding that universities need, Obeidat explained the increase in the cost of face-to-face education and the doubling of the number of students without any consequences associated with an increase in government support, explaining the size of the difficulties facing universities at the moment of making the decision to increase tuition fees.\n\n"
    //       "He also stressed that we have to take change and implement it seriously, as it has become necessary to see fundamental changes in the educational programs and their outputs, and to work to reshape the student as a human being, and to prepare him for the labor market by ensuring that he masters the skills related to his profession and specialization, in addition to his mastery of general vocabulary.\n\n"
    //       "As he talked about the challenges, he also touched on a number of solutions to reduce the cost of education. In addition to the application of flipped education, Obeidat suggested adopting e-learning partially or completely, and reducing the duration of the programs and the number of buildings.\n\n"
    //       "Among other possible solutions, Obeidat touched on resorting to formative assessment instead of high-stakes exams, explaining that most will fail, to some degree, while taking the exams, because they do not measure the extent of our learning, but rather the information that we retained at a specific point in time, giving the example That many hold degrees in subjects they know little about.\n\n"
    //       "Obeidat concluded his speech by wishing the university and the College of Educational Sciences, which worked hard to organize this forum, to achieve their common mission, aiming at the progress and prosperity of the educational system in all its fields, fields and forms.\n\n",
    //   contentAR:
    //       "دعا رئيس الجامعة الأردنيّة الدكتور نذير عبيدات، أثناء حضوره للمنتدى العلمي لكلية العلوم التربوية، والذي جاء برعاية رئيس مجلس أمناء الجامعة الدكتور عدنان بدران، إلى انتهاج التّعليم المقلوب في جامعاتنا للتخفيف من أعباء العمليّة التعليميّة، واصفًا إيّاه بكونِه شكلًا من أشكال التّعليم، ظهر في التّعليم العالي في أوائل العقد الأوّل من القرن الحادي والعشرين، وشهد نموّا سريعا منذ بداية هذا العقد. "
    //       "وفي حديثه، الذي طرح من خلاله على الحضور عددًا من الأسئلة والأفكار التي تستوضح شكل التعليم مُستقبلًا، ورؤية الجامعة الأردنيّة له على المديين القريب والبعيد، أضاف عبيدات أنّ هذا الشكل من التعليم يتيح للطلبة أن يتّصلوا بموادّ جديدة من خلال التّدريس الذّاتيّ المنظّم، ليستخدموا بعدا الوقت المستصلح في تجارب معنيّة بالتّعلّم النّشط."
    //       "وأشار إلى عدد من التحديات التي تواجه تطبيق هذا الشكل من التعليم، ومنها صياغة تعريف مشترك للتّعلّم المقلوب، وضرورة إنتاج مجموعة من الأبحاث التّجريبية الصّارمة التي تحدّد النتائج المتعلقة بفعّالية هذا النوع من التّعليم، والحاجة إلى إنشاء مكتبة عالميّة من الموارد التّعليمية المفتوحة التي تدعم هذا الشكل، والحاجة إلى إيجاد وبناء شبكة عالمية من أفراد ومجتمعات أكاديمية مهتمّة بتطبيقه"
    //       "وعرّج عبيدات على المستجدّات التي تحكم التّعليم الجامعيّ مستقبلًا، مشيرًا إلى أنّ التّغيير السّريع الّذي يحدث  في المجتمعات يتسبّب في إحداث ضغوطات كبيرة، كما لفت إلى  الضّغوطات التي تفرض على الجامعات من أجل توفير بيئة تأخذ بعين الاعتبار الثّورة التّكنولوجيّة، خاصّة في ظلّ الثّورة الصّناعية الرّابعة التي نشهدها"
    //       "وعن التمويل الذي تحتاجه الجامعات، بيّن عبيدات ما لزيادة تكلفة التّعليم الوجاهيّ وتضاعف أعداد الطّلبة دون أن يصاحب ذلك زيادة في الدّعم الحكومي من تبعات، موضّحًا حجم المصاعب التي تواجه الجامعات لحظة اتخاذ القرار في زيادة الرسوم الدراسية."
    //       "وأكّد كذلك، أنّ علينا أن نأخذ التّغيير وتطبيقه بجديّة، حيث بات لزامًا أن نرى تغييرات جوهريّة في البرامج التّعليميّة ومخرجاتها، وأن نعمل على إعادة تشكيل الطّالب بوصفه إنسانا،  وإعداده لسوق العمل بضمان إتقانه للمهارات المتعلّقة بمهنته واختصاصه، إلى جانب إتقانه للمعارات العامّة."
    //       "وكما تحدث عن التحديات، تطرّق كذلك إلى عددٍ من الحلول لتقليل تكلفة التعليم، فإلى جانب تطبيق التعليم المقلوب، اقترح عبيدات اعتماد التّعليم الإلكترونيّ جزئيّا أو كلّيّا، والتقليل من مدّة البرامج، ومن عدد المباني."
    //       "ومن الحلول الممكنة الأخرى، تطرّق عبيدات إلى اللجوء إلى التّقييم التّكوينيّ عوضا عن الامتحانات عالية المخاطر، موضّحًا أنّ المعظم سيفشل، بدرجةٍ ما، أثناء الخضوع للامتحانات، ذلك أنّها لا تقيس مدى تعلّمنا، بل تقيس المعلومات التي احتفظنا بها في مرحلة زمنية محدّدة، ضاربًا المثال بأنّ كثيرين يحملون شهادات في مواضيع لا يعرفون عنها سوى القليل."
    //       "وختم عبيدات كلامه بأن تمنّى للجامعة وكلية العلوم التربوية، التي اجتهدت لتقيم هذا المنتدى، أن تُحقّقا رسالتهما المشتركة، والرامية إلى تقدم وازدهار المنظمومة التعليمية بكافة ميادينها ومجالاتها وأشكالها.",
    //   urlImage: "assets/images/During.jpg",
    //   collegeName: "University News",
    //   id: 9,
    //   audioFileEN: "assets/audio/9en.mp3",
    //   audioFileAR: "assets/audio/9ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The University of Jordan is crowned with the title of the Jordanian Universities Chess Championship / Males",
    //   titleAR:
    //       "الجامعة الأردنية تتوج بلقب بطولة الجامعات الأردنية للشطرنج/ ذكور",
    //   content:
    //       "The University of Jordan was crowned with the title of the Jordanian Universities Chess Championship for males, achieving a remarkable achievement in the world of the mental game.\n\n"
    //       "The tournament was held from May 23 to 24 in the sports activities hall at Al al-Bayt University, where more than 100 players from various Jordanian universities competed.\n\n"
    //       "The competitions witnessed a great performance by the participating teams, but the University of Jordan team had the lion's share in this exciting tournament. Thanks to their strategic skills and great dedication, the University of Jordan players were able to achieve success and crown the title.\n\n"
    //       "The University of Jordan team was represented by: Louay Samir, Muhammad Al-Amad, Yazan Al-Saud, Khattab Masalha, Sivan Krikorian, and the player Louay Samir managed to win the medal for the best player at the second table.\n\n"
    //       "This championship comes as an important addition to the record of sporting victories for the University of Jordan, and reflects its commitment to developing and encouraging sports talents among its students. We warmly congratulate the University of Jordan and the chess team on this wonderful achievement, and we wish them more success in the future.",
    //   contentAR:
    //       "توجت الجامعة الأردنية بلقب بطولة الجامعات الأردنية للشطرنج/ ذكور  محققين إنجازًا رائعًا في عالم اللعبة الذهنية."
    //       "وأقيمت البطولة في الفترة من 23 إلى 24 أيار في صالة النشاطات الرياضية في جامعة آل البيت، حيث تنافس أكثر من 100 لاعب من مختلف الجامعات الأردنية."
    //       "وشهدت المنافسات أداءًا رائعًا من قبل الفرق المشاركة، ولكن كان لفريق الجامعة الأردنية نصيب الأسد في هذه البطولة المثيرة، بفضل مهاراتهم الاستراتيجية وتفانيهم الكبير، تمكن لاعبو الجامعة الأردنية من تحقيق النجاح والتتويج باللقب"
    //       "هذا وقد مثل فريق الجامعة الاردنية كل من: لؤي سمير، محمد العمد، يزن السعود، خطاب مصالحة، سيفان كريكوريان، وتمكن اللاعب لؤي سمير من احراز ميدالية افضل لاعب على الطاولة الثانية"
    //       "وتأتي هذه البطولة كإضافة مهمة إلى سجل الانتصارات الرياضية للجامعة الأردنية، وتعكس التزامها بتطوير وتشجيع المواهب الرياضية بين طلابها. نتوجه بالتهاني الحارة للجامعة الأردنية وفريق الشطرنج على هذا الإنجاز الرائع، ونتمنى لهم المزيد من النجاحات في المستقبل.",
    //   urlImage: "assets/images/crowned.jpg",
    //   collegeName: "University News",
    //   id: 10,
    //   audioFileEN: "assets/audio/10en.mp3",
    //   audioFileAR: "assets/audio/10ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Lecture in \"The Jordanian University\" about the human aspect in dealing with people with Down syndrome",
    //   titleAR:
    //       "محاضرة في الأردنية حول الجانب الإنساني في التعامل مع ذوي متلازمة داون",
    //   content:
    //       "The university and community committee, in cooperation with the Community Health Nursing Division at the College of Nursing at the University of Jordan, organized an educational lecture to shed light on the human aspect of dealing with people with Down syndrome, given the need for this category of support and integration into society.\n\n"
    //       "The lecture hosted an inspiring story in this context. An activist in spreading awareness and providing support about Down Syndrome, and founder of the “Down Syndrome Lovers” page on Facebook, Nasser Al Sheikh Theeb, where he presented his story as a father of a child with Down Syndrome.\n\n"
    //       "During the lecture, Sheikh Theeb talked about a number of negative social phenomena in dealing with this group, to the point of depriving their families of attention, education and integration into society, in addition to the stereotyped image of the society around them, indicating that children with Down syndrome are a blessing from God like other children. They need education to develop their language skills and abilities.\n\n"
    //       "The lecture was attended by fourth-year students in the Community Health Nursing course, and a number of faculty members in the college, considering its subject as one of the most important humanitarian aspects in their specialization, and those interested.",
    //   contentAR:
    //       "نظمت لجنة الجامعة والمجتمع بالتعاون مع شعبة تمريض صحة المجتمع في كلية التمريض في الجامعة الأردنية محاضرة تثقيفية لتسليط الضوء على الجانب الإنساني في التعامل مع ذوي متلازمة داون، نظرًا لما تحتاجه هذه الفئة من الدعم والدمج في المجتمع."
    //       "واستضافت المحاضرة إحدى القصص الملهمة في هذا السياق؛ الناشط في مجال نشر التوعية وتقديم الدعم حول متلازمة داون، ومؤسس صفحة محبي الداون سندروم على الفيس بوك ناصر الشيخ ذيب، حيث عرض لقصته أبًا لطفل مصاب بمتلازمة داون."
    //       "وتحدث الشيخ ذيب خلال المحاضرة، عن عدد من الظواهر الاجتماعية السلبية في التعامل مع هذه الفئة، تصل حدّ حرمان عائلاتهم لهم من الاهتمام والتعليم والاندماج في المجتمع، إضافة إلى الصورة النمطية لدى المجتمع حولهم، مشيرًا إلى أن أطفال متلازمة ﺩﺍﻭﻥ نعمة من الله كغيرهم من الأطفال، إذ يحتاجون ﺇﻟﻰ التربية والتعليم ﻟﺘﻨﻤﻴﺔ مهاراتهم وقدراتهم اللغوية"
    //       "وحضر المحاضرة طلبة السنة الرابعة في مساق تمريض صحة المجتمع، وعدد من أعضاء هيئة التدريس في الكلية، باعتبار موضوعها أحد أهم الجوانب الإنسانية في تخصصهم، والمهتمين",
    //   urlImage: "assets/images/human.jpg",
    //   collegeName: "University News",
    //   id: 11,
    //   audioFileEN: "assets/audio/11en.mp3",
    //   audioFileAR: "assets/audio/11ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Wassef examines the reality of the Jordanian song, its beauty and richness",
    //   titleAR: "واصف يعاين واقع الأغنية الأردنية جماليتها وثراءها",
    //   content:
    //       "Assistant Professor of Music at the University of Jordan, Dr. Muhammad Wasef, said that the Jordanian song is witnessing a relative decline, after it was present in the Arab scene.\n\n"
    //       "This came as part of a dialogue organized by the Ministry of Culture at the University of Jordan today, as part of a series of intellectual and cultural activities that the Ministry has been organizing, under the supervision of Dr. Mazen Asfour.\n\n"
    //       "Wasef attributed the reasons for the absence of the various Jordanian songs to the lack of musical culture among members of society as it should be, and the absence of production companies, in addition to not paying attention to the importance of the musical act and music as a basic human need and right, not a luxury.\n\n"
    //       "And he indicated that the popularity of the one-color Jordanian song greatly limited its presence on the Arab scene, which caused a state of reluctance from it, according to an academic field survey.\n\n"
    //       "Wasef called for the need to enrich the Jordanian music library with various works such as the children's song, the educational song, and the social, religious, spiritual and emotional songs, which simulate the details of the daily life of the Jordanian citizen and reflect his history, present and future aspirations.\n\n"
    //       "Wasef stressed the need for the song to draw the features of a nation that rises above its people on the forearms of its children, and reflects the bright and splendid face of the country and the lives of its members, and meets their hopes and aspirations.\n\n"
    //       "In order to raise the quality of the Jordanian song, Wassef called for the need to include music as a basic part in schools for students of the basic and preparatory stages, which would raise the taste of young people, discover talents, and work on developing, refining and developing them, and thus exporting them to society.\n\n"
    //       "He also demanded that music be present on the official's table, and that he be aware of its importance, noting at the same time that the first decisions of the founding king, Abdullah I, were the formation of the Army Music Ensemble, and the launch of the radio.\n\n"
    //       "He explained that most of the Jordanian singers present on the scene now discovered their talents through the Jordanian Song Festival in its first six sessions, which came at the generous initiative of Their Majesties King Abdullah II and Queen Rania Al-Abdullah, may God protect them.\n\n"
    //       "He pointed out that the Jordanian heritage is full of popular, traditional, folkloric and hymns that express the lives of Jordanians and their seasons of joy, starting with weddings, henna and food, and not ending with harvest seasons and the beginning of sowing and flowers.\n\n"
    //       "Wasef concluded his lecture by saying that we can rely on a solid base and a Jordanian library full of artistic and musical works, which makes it easier to reconsider the reality of the Jordanian song and launch it towards the world.",
    //   contentAR:
    //       "قال الأستاذ المساعد بالموسيقى في الجامعة الأردنية الدكتور محمد واصف إن الأغنية الأردنية تشهد تراجعا نسبيا، بعدما كانت حاضرة في المشهد العربي"
    //       "جاء ذلك ضمن حوارية نظمتها وزارة الثقافة في الجامعة الأردنية اليوم، ضمن سلسلة نشاطات فكرية وثقافية دأبت على تنظيمها الوزارة بإشراف الدكتور مازن عصفور."
    //       "وعزا واصف أسباب غياب الأغنية الأردنية المتنوعة إلى عدم شيوع الثقافة الموسيقية بين أفراد المجتمع كما ينبغي أن تكون، وغياب شركات الإنتاج، إضافة إلى عدم الالتفات إلى أهمية الفعل الموسيقي والموسيقى باعتبارها حاجة وحقًّا إنسانيًّا أساسيًّا لا ترفًأ"
    //       "وبين أن شيوع الأغنية الأردنية ذات اللون الواحد أدى بشكل كبير إلى الحد من تواجدها على الساحة العربية، ما سبب حالة من العزوف عنها وفقا لمسح ميداني أكاديمي."
    //       "وطالب واصف بضرورة إثراء المكتبة الموسيقية الأردنية بالأعمال المتنوعة مثل أغنية الطفل، والأغنية التربوية والأغنية الاجتماعية والدينية والروحانية والعاطفية، التي تحاكي تفاصيل الحياة اليومية للمواطن الأردني وتعكس تاريخه وحاضره وتطلعاته المستقبلية"
    //       "وأكد واصف ضرورة أن ترسم الأغنية ملامح وطن يعلو بناؤع على سواعد أبنائه، وتعكس الوجه المشرق والبهي عن الوطن وحياة أفراده، وتلبي آمالهم وطموحاتهم"
    //       "ومن أجل رفع سوية الأغنية الأردنية، دعا واصف إلى ضرورة إدراج الموسيقى حصّةً أساسيةً في المدارس لطلبة المرحلتين الأساسية والإعدادية، الأمر الذي من شأنه الرقي بذائقة النشء، واكتشاف المواهب، والعمل على تطويرها وصقلها وتنميتها، وبالتالي تصديرها للمجتمع"
    //       "وطالب أيضا بضورة أن تكون الموسيقى حاضرة على طاولة المسؤول، وأن يعي أهميتها مشيرا في الوقت ذاته إلى أن أول قرارات الملك المؤسس عبد الله الأول كان تشكيل فرقة موسيقات الجيش، وتدشين الإذاعة"
    //       "وأوضح أن أغلب المطربين الأردنيين الموجودين على الساحة الآن اكتُشفت مواهبهم من خلال مهرجان الأغنية الأردني بدوراته الستة الأولى، الذي جاء بمبادرة كريمة من صاحبي الجلالة الملك عبد الله الثاني والملكة رانيا العبد الله حفظهما الله"
    //       "وأشار إلى أن التراث الأردني زاخر بالأغاني الشعبية والتراثية والفلكلورية والأهازيج التي تعبر عن حياة الأردنيين ومواسم الفرح لديهم، بدءًا من حفلات الزفاف والحناء والطعام وليس انتهاء بمواسم الحصاد و بدء البذار والزهور"
    //       "واختتم واصف محاضرته قائلا إنه يمكننا الاستناد إلى قاعدة صلبة ومكتبة أردنية زاخرة بالأعمال الفنية والموسيقية، الأمر الذي يسهل إعادة النظر في واقع الأغنية الأردنية والانطلاق بها نحو العالمية",
    //   urlImage: "assets/images/Wassef.jpg",
    //   collegeName: "University News",
    //   id: 12,
    //   audioFileEN: "assets/audio/12en.mp3",
    //   audioFileAR: "assets/audio/12ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "President of the University of Jordan: Universities must work to integrate mental health into education, employment, justice and housing policies",
    //   titleAR:
    //       "رئيس الجامعة الأردنية: على الجامعات العمل على دمج الصحّة العقليّة في سياسات التّعليم والعمل والعدالة والإسكان",
    //   content:
    //       "The President of the University of Jordan, Dr. Nazir Obeidat, confirmed that the first Jordanian conference on mental health “Towards Better Mental Health for All”, which is being held by the Department of Psychology at the Faculty of Arts at the University of Jordan, constitutes the first step towards improving mental health care and psychosocial support.\n\n"
    //       "He indicated, in a speech delivered during his sponsorship of the opening of the conference today, that we still need more than ever before to recognize that access to mental health care and psychosocial support is vital, and a human right, and that we will unite from today and benefit from our collective efforts to ensure our access to new heights.\n\n"
    //       "He said that the conference came to exchange expertise and experiences, and to explore prospects for developing the field of mental health in Jordan, in order to improve mental health care and psychosocial support, noting that the quality of mental health care and psychological and social services is naturally much lower than the quality of other health care services.\n\n"
    //       "Obeidat indicated that there are studies by the World Health Organization confirming that the groups most affected in recent years, especially after the Corona pandemic, with regard to mental health services, were women and youth, specifically those between the ages of 20 and 24.\n\n"
    //       "According to Obeidat, one of the particularly disturbing findings of the survey conducted by the Health Organization is that mental health services were the most affected by the pandemic, especially the most vulnerable groups such as the elderly and children, adding that life-saving services such as emergency psychological services, overdose management and programs Suicide prevention was disrupted at the time, while COVID-19 has simultaneously highlighted gaps in the capacity of health systems to treat mental health conditions, while investment in mental health remains low and stigma remains high.\n\n"
    //       "He said that in times of crisis, when we need more and better quality mental health services, the world is set back because of insufficient investment in this field.\n\n"
    //       "He added that the World Health Organization indicated that there is an opportunity to build back better, by expanding the provision of community mental health services, and integrating mental health into primary health care, as part of countries' efforts to reach universal health coverage.\n\n"
    //       "Obeidat emphasized that this conference must look for ways to address risk factors for mental health, including violence, abuse and neglect; improving early childhood development; Banning pesticides is linked to a fifth of suicides worldwide.\n\n"
    //       "He added that it is necessary to work on building community networks of services that move away from custodial care in psychiatric hospitals, and to integrate mental health services into primary health care, and universities should work to integrate mental health into education, employment, justice, and housing policies.\n\n"
    //       "Obeidat called for finding links between mental health, public health, human rights, and social and economic development, which should lead to real and objective benefits for individuals, societies, and countries everywhere.\n\n"
    //       "He continued by saying that the conference came at a time when we desperately need it and its outputs, which will come in the interest of a group, whose members, families and friends look forward to any opportunity to help, and the various health institutions must play their natural role in formulating these outputs, and provide decision makers with a first step to adhere to it, appreciatively. His hope is that the conference will be an opportunity for a fruitful exchange of experiences and knowledge, and that it will provide a platform for cooperation among the participants.\n\n"
    //       "In turn, the head of the conference, Senior Consultant Psychiatrist Dr. Walid Sarhan, confirmed that the ultimate goal of the conference is to put mental health in its proper place within the health system, by bringing together workers and researchers in this field from various disciplines to work on raising the professional and scientific level in this field.\n\n",
    //   contentAR:
    //       "أكد رئيس الجامعة الأردنية الدكتور نذير عبيدات أن المؤتمر الأردني الأول للصحة النفسية  نحو صحة نفسية أفضل للجميع، الذي يعقده قسم علم النفس في كلية الآداب في الجامعة الأردنية، يشكّل الخطوة الأولى من أجل تحسين الرعاية الصحّيّة العقليّة والدّعم النفسيّ والاجتماعيّ."
    //       "وأشار، في كلمة ألقاها خلال رعايته افتتاح المؤتمر اليوم، إلى أننا ما زلنا بحاجة أكثر من أيّ وقت مضى إلى الاعتراف بأنّ الحصول على الرعاية الصحّيّة العقليّة والدّعم النفسيّ والاجتماعيّ أمر حيويّ، وحقّ من حقوق الإنسان، وأنّنا سنتّحد منذ اليوم ونستفيد من جهودنا الجماعيّة لضمان وصولنا إلى آفاق جديدة."
    //       "وقال إن المؤتمر جاء لتبادل الخبرات والتجارب، واستكشاف آفاق تطوير مجال الصحة النفسية في الأردنّ، من أجل تحسين الرعاية الصحّيّة العقليّة والدّعم النفسيّ والاجتماعيّ، مشيرًا إلى أن جودة رعاية الصحّة العقليّة والخدمات النفسيّة والاجتماعيّة بطبيعة الحال أقلّ بكثير من جودة خدمات الرعاية الصحّيّة الأخرى."
    //       "وبين عبيدات أن هناك دراسات لمنظّمة الصحّة العالميّة تؤكّد أنّ المجموعات الأكثر تضرّرًا في السّنوات الأخيرة، خاصّة بعد جائحة كورونا فيما يتعلّق بخدمات الصحة النفسية كانت النّساء والشّباب، تحديدًا أولئك الّذين تتراوح أعمارهم بين 20 و24 عامًا."
    //       "وحسب عبيدات، فإنّ إحدى النّتائج المقلّقة بشكل خاصّ للدراسة الاستقصائيّة التي أجرتها منظّمة الصحّة، تتمثّل في أنّ خدمات الصحّة العقليّة كانت الأكثر تضرّرًا من الجائحة، خاصّةً الفئات الأكثر ضعفًا مثل كبار السّنّ والأطفال، مضيفًا أنّ الخدمات المنقذة للحياة مثل الخدمات النّفسيّة الطّارئة وإدارة الجرعة الزّائدة وبرامج الوقاية من الانتحار فقد تعطّلت آنذاك، فيما سلّط كوفيد-19 في الوقت نفسه الضّوء على الفجوات في قدرة النّظم الصحّيّة على معالجة حالات الصحّة العقليّة، بينما لا يزال الاستثمار في الصحّة العقليّة منخفضًا، ولا تزال وصمة العار المحيطة بها مرتفعةً."
    //       "وقال إننا نشهد في أوقات الأزمات، وحين نحتاج إلى مزيد من خدمات الصحّة العقليّة ذات الجودة الأفضل، تراجع العالم بسبب عدم كفاية الاستثمار في هذا المجال."
    //       "وأضاف أن منظّمة الصحّة العالميّة أشارت إلى وجود فرصة لإعادة البناء بشكل أفضل، من خلال توسيع نطاق توفير خدمات الصحّة العقليّة المجتمعيّة، ودمج الصحّة العقليّة في الرّعاية الصحّيّة الأوليّة، بوصف ذلك جزءًا من جهود الدّول للوصول إلى تغطية صحيّة شاملة."
    //       "وأكد عبيدات أنّ لا بد على هذا المؤتمرأن يبحث عن طرق لمعالجة عوامل الخطر المسلّطة على الصحّة العقليّة، بما في ذلك العنف وسوء المعاملة والإهمال؛ وتحسين تنمية الطّفولة المبكّرة؛ وحظر المبيدات الحشريّة المرتبطة بخمس حالات الانتحار على مستوى العالم."
    //       "وأكمل بأنّه لا بدّ من العمل على بناء شبكات مجتمعيّة من الخدمات التّي تبتعد عن الرّعاية الاحتجازيّة في مستشفيات الأمراض النّفسيّة، ودمج خدمات الصحّة العقليّة في الرّعاية الصحّيّة الأوليّة، وعلى الجامعات العمل على دمج الصحّة العقليّة في سياسات التّعليم والعمل والعدالة والإسكان."
    //       "وطالب عبيدات بإيجاد الرّوابط بين الصحّة العقليّة والصحّة العامّة وحقوق الإنسان والتّنمية الاجتماعيّة والاقتصاديّة، الأمر الّذي لا بدّ أن يؤدّي إلى تحقيق فوائد حقيقيّة وموضوعيّة للأفراد والمجتمعات والبلدان في كلّ مكان."
    //       "وتابع بالقول إنّ المؤتمر جاء في وقت نحن بأمس الحاجة له ولمخرجاته التّي ستأتي في صالح فئة، يتطلّع أفرادها وعائلاتهم وأصدقاؤهم لأيّ فرصة للمساعدة، كما يجب أن تلعب المؤسّسات الصحّيّة المختلفة دورها الطّبيعيّ في صياغة هذه المخرجات، وأن تقدّم لأصحاب القرار خطوةً أولى للالتزام بها، مدبيًا أمله في أن يشكّل المؤتمر فرصةً للتّبادل المثمر للخبرات والمعرفة، وأن يوفّر منصّةً للتّعاون بين المشاركين."
    //       "بدوره، أكد رئيس المؤتمر مستشار أول الطب النفسي الدكتور وليد سرحان أن الهدف الأسمى من المؤتمر يتمثّل في وضع الصحة النفسية في مكانها المناسب ضمن المنظومة الصحية، وذلك بجمع العاملين والباحثين في هذا المجال من مختلف التخصصات للعمل على رفع المستوى المهني والعلمي في هذا المجال.",
    //   urlImage: "assets/images/integrate.jpg",
    //   collegeName: "University News",
    //   id: 13,
    //   audioFileEN: "assets/audio/13en.mp3",
    //   audioFileAR: "assets/audio/13ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "42% of smokers in Jordan, and electronic cigarettes damage the brain",
    //   titleAR: "42% نسبة المدخنين في الأردن، والسجائر الإلكترونية تتلف الدماغ",
    //   content:
    //       "Today, the Faculty of Pharmacy at the University of Jordan, in cooperation with the King Hussein Cancer Center, organized an educational day to raise awareness of the health risks associated with tobacco use and ways to quit it, as part of the activities of the World No Tobacco Day, which was set by the World Health Organization on May 31 of each year.\n\n"
    //       "The Dean of the College of Pharmacy, Dr. Rula Darwish, said that celebrating World No Tobacco Day constitutes a valuable opportunity to raise awareness together and strive to create a healthy society free from the scourge of smoking, as its dangers do not stop at the health dimension only, but also extend to economic and social dimensions, which requires concerted action. Efforts between various sectors to confront it.\n\n"
    //       "Darwish added that universities have a leading role in health awareness and combating smoking by spreading awareness among young people and urging them to change unhealthy behaviors, while the pharmacist is entrusted, especially with continuous education, providing reliable health information about the dangers of tobacco and the benefits of quitting, and providing appropriate medications and treatment protocols for those wishing to quit smoking.\n\n"
    //       "Rana Al-Ghafri, Head of the Advocacy and Governmental Affairs Department at the King Hussein Cancer Center, said that the center is making every effort to raise awareness, research and treatment in order to reduce the effects of tobacco addiction and encourage quitting through various means.\n\n"
    //       "Al-Ghafri called for the need to show determination and the will to quit smoking, and to review the cessation centers spread throughout the Kingdom to receive the appropriate treatment protocol.\n\n"
    //       "A study prepared by the center, which was distributed in the form of awareness leaflets, revealed that the percentage of smokers in Jordan reached 42%, 9.2% of whom use electronic cigarettes.\n\n"
    //       "The results of the study showed that males start smoking at the age of seventeen, while females start at the age of twenty-four.\n"
    //       "According to the study, the 42% rate is very high and worrisome, as smoking is a major risk factor for cardiovascular and respiratory diseases, and causes more than 20 types of cancer.\n\n"
    //       "With regard to electronic cigarettes, the study showed that using them at a young age leads to damage to the parts of the brain that control attention, learning, mood and emotions.\n\n"
    //       "As for shisha, a regular one-hour session in which users inhale an amount of smoke that is 100–200 times as harmful as smoking a single cigarette.",
    //   contentAR:
    //       "نظمت كلية الصيدلة في الجامعة الأردنية اليوم، بالتعاون مع مركز الحسين للسرطان يوما تثقيفيا للتوعية بالمخاطر الصحية المرتبطة بتعاطي التبغ وسبل الإقلاع عنه، ضمن فعاليات اليوم العالمي للامتناع عن التبغ الذي حددته منظمة الصحة العالمية بـ31 أيار/مايو من كل عام."
    //       "وقالت عميدة كلية الصيدلة الدكتورة رلى درويش إن الاحتفال باليوم العالمي للامتناع عن التبغ يشكل فرصة قيمة لنعزز معا الوعي ولنسعى لخلق مجتمع صحي خال من آفة التدخين، إذ إن مخاطره لا تتوقف عند البعد الصحي فقط، بل تتعداه إلى أبعاد اقتصادية واجتماعية، الأمر الذي يتطلب تضافر الجهود بين مختلف القطاعات لمواجهته."
    //       "وأضافت درويش أن للجامعات دور ريادي في التوعية الصحية ومحاربة التدخين من خلال نشر الوعي بين الشباب والحث على تغيير السلوكيات غير الصحية، فيما يُناط بالصيدلاني خصوصا التثقيف المستمر وتوفير المعلومات الصحية الموثوقة حول مخاطر التبغ وفوائد الإقلاع عنه وتوفير الأدوية والبروتوكولات العلاجية المناسبة للراغبين بالإقلاع عن التدخين"
    //       "وقالت رئيسة قسم كسب التأييد والشؤون الحكومية في مركز الحسين للسرطان رنا الغفري إن المركز يبذل أقصى ما لديه من جهود توعوية وبحثية وعلاجية من أجل الحد من آثار الإدمان على التبغ، والحث على الإقلاع عنه عبر شتى السبل والوسائل."
    //       "ودعت الغفري إلى ضورة التحلي بالعزيمة والإردادة للإقلاع عن التدخين، ومراجعة مراكز الإقلاع المنتشرة في جميع أنحاء المملكة لتلقي البروتوكول العلاجي المناسب."
    //       "فيما كشفت دراسة أعدها المركز، ووُزّعت على شكل منشورات توعوية، أن نسبة المدخنين في الأردن بلغت 42%، 9.2% منهم يستعملون السجائر الإلكترونية"
    //       "وأظهرت نتائج الدراسة أن الذكور يبدأون بالتدخين في في عمر السابعة عشر بين تبدأ الإناث عند عمر الرابعة والعشرين"
    //       "ووفقا للدراسة، تُعدّ نسبة الأـ42% مرتفعة جدا ومقلقة، إذ يشكل التدخين عامل خطر رئيسيٍّ للأمراض القلبية والوعائية وأمراض الجهاز التنفسي، ويتسبّب بما يزيد على 20 نوعا من السرطان"
    //       "وفيما يتعلق بالسجائر الإلكترونية، بينت الدراسة أن استخدامها في عمر الشباب يؤدي إلى الإضرار بأجزاء الدماغ التي تتحكم في الانتباه والتعلم والمزاج والانفعالات"
    //       "أما الأرجيلة فإن جلسة اعتيادية لمدة ساعة واحدة يستنشق فيها المستخدمون كمية من الدخان يُعادل ضررها 100–200 ضعف الضرر الذي يُحدثه تدخين سيجارة واحدة.",
    //   urlImage: "assets/images/smoke.jpg",
    //   collegeName: "University News",
    //   id: 14,
    //   audioFileEN: "assets/audio/14en.mp3",
    //   audioFileAR: "assets/audio/14ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A training course for graduates and students of graduation projects at \"UJ\" on \"Learning Presentation Skills\"",
    //   titleAR:
    //       "دورة تدريبية للخريجين وطلبة مشاريع التخرج في الأردنية حول تعلم مهارات التقديم",
    //   content:
    //       "The National Program for Linking Industry to Academia, \"A Doctor for Each Factory\", in cooperation with Orange, at the University of Jordan, organized today a training course for graduates, graduation project students and other interested parties, on \"Learning Presentation Skills\"."
    //       "The course aims to introduce students to communication skills and methods of obtaining job opportunities, in a way that enhances marketing opportunities for university graduates and students of graduation projects.\n\n"
    //       "The training workshop, presented by Ziad Abu Salem and Yasmine Khawaja from Orange, dealt with communication and presentation skills, and how to present ideas and projects in line with the requirements of the labor market.\n\n"
    //       "It is noteworthy that the “Doctor for Every Factory” program is a project that was established as an idea aimed at strengthening the role of applied scientific research carried out by academic institutions, in service of the national economy and industry, and to enhance the technological component of industrial companies, in an effort to develop them and enhance their competitiveness.",
    //   contentAR:
    //       "نظم البرنامج الوطني لربط الصناعة بالأكاديميا دكتور لكل مصنع، بالتعاون مع شركة أورانج في الجامعة الأردنية اليوم، دورة تدريبية للخريجين وطلبة مشاريع التخرج وغيرهم من المهتمين، حول تعلم مهارات التقديم"
    //       "وتهدف الدورة إلى تعريف الطلبة بمهارات الاتصال وطرق الحصول على فرص العمل، بما يعزز من الفرص التسويقية لخريجي الجامعات وطلبة مشاريع التخرج."
    //       "وتناولت الورشة التدريبية، التي قدمها زياد أبو سالم وياسمين خواجا من شركة أورانج، مهارات التواصل والإلقاء وكيفية عرض الأفكار والمشاريع بما يتواءم مع متطلبات سوق العمل."
    //       "ويُشار إلى أن برنامج دكتور لكل مصنع مشروع أُنشئ بوصفه فكرة تهدف إلى تعزيز دور البحث العلمي التطبيقي الذي تقوم به المؤسسات الأكاديمية، وذلك خدمة للاقتصاد والصناعة الوطنية، ولتعزيز المكون التكنولوجي لدى الشركات الصناعية، سعيًا نحو تطويرها وتعزيز تنافسيتها.",
    //   urlImage: "assets/images/training.jpg",
    //   collegeName: "University News",
    //   id: 15,
    //   audioFileEN: "assets/audio/15en.mp3",
    //   audioFileAR: "assets/audio/15ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Her Highness Princess Basma surprised the participants in the activities of the scientific day of the Faculty of Agriculture at the \"Jordanian University\" by attending the agricultural exhibition",
    //   titleAR:
    //       " سمو الأميرة بسمة تفاجئ المشاركين في فعاليات اليوم العلمي لكلية الزراعة في الأردنية بحضورها للمعرض الزراعي",
    //   content:
    //       "Her Highness Princess Basma bint Talal surprised the participants in the activities of the scientific day of the Faculty of Agriculture at the University of Jordan today by participating in the opening activities of the agricultural exhibition held as part of her celebrations of the golden jubilee of her founding.\n\n"
    //       "It happened that Her Royal Highness was present at the ceremony site after she attended the meeting of the College of Graduate Studies Council in her capacity as chairperson of the council.\n\n"
    //       "Her Royal Highness, accompanied by the President of the University, Dr. Nazir Obeidat, and the Dean of the College, Dr. Safwan Al-Shayyab, toured the exhibition halls, listening to what the participants summarized about their various agricultural products and exhibits.\n\n"
    //       "The participants expressed their happiness at the presence of Her Highness the Princess, which raised their spirits and motivated them to exert more effort and giving in order to preserve the local Jordanian product.\n\n"
    //       "The exhibition included many agricultural products, plants, handicrafts, plant extracts such as oils and perfumes, and other agricultural and productive crops, with the wide participation of agricultural companies, associations and members of the local community.",
    //   contentAR:
    //       "فاجأت سمو الأميرة بسمة بنت طلال المشاركين في فعاليات اليوم العلمي لكلية الزراعة في الجامعة الأردنية اليوم بمشاركتها في فعاليات افتتاح المعرض الزراعي المقام ضمن احتفالاتها باليوبيل الذهبي لتأسيها."
    //       "وتصادف وجود سمو الأميرة في موقع الحفل عقب حضورها اجتماع مجلس كلية الدراسات العليا بصفتها رئيسة المجلس."
    //       "وجالت سمو الأميرة، رفقة رئيس الجامعة الدكتور نذير عبيدات وعميد الكلية الدكتور صفوان الشياب، في أروقة المعرض، مستمعة إلى ما أوجزه المشاركون حول منتجاتهم ومعروضاتهم الزراعية المختلفة"
    //       "وعبر المشاركون عن سعادتهم بحضور سمو الأميرة، الأمر الذي رفع معنوياتهم، وشحذ هممهم لمزيد من البذل والعطاء في سبيل الحفاظ على المنتج المحلي الأردني"
    //       "واشتمل المعرض على عديد من المنتجات الزراعية والنباتات والأشغال اليدوية ومستخلصات النباتات من زيوت وعطور، وغيرها من المحاصيل الزراعية والإنتاجية، وذلك بمشاركة واسعة من الشركات الزراعية والجمعيات وأفراد المجتمع المحلي",
    //   urlImage: "assets/images/princ.jpg",
    //   collegeName: "University News",
    //   id: 16,
    //   audioFileEN: "assets/audio/16en.mp3",
    //   audioFileAR: "assets/audio/16ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Obeidat calls for the development of sustainable agricultural and food systems in the face of climate change and the food security crisis",
    //   titleAR:
    //       " عبيدات يدعو إلى تطوير أنظمة زراعيّة وغذائيّة مستدامة في مواجهة التغير المناخي وأزمة الأمن الغذائي",
    //   content:
    //       "The President of the University of Jordan, Dr. Nazir Obeidat, said that the world needs agriculture capable of providing food by 70% more than what we need today.\n\n"
    //       "This came during a speech he delivered at the opening of the activities of the Scientific Day of the College of Agriculture as part of its celebrations of the golden jubilee of its founding, which was titled \"Traditional and Functional Foods and Their Safety\"."
    //       "Obeidat explained that the food crisis the world is experiencing is a wake-up call, especially since, in less than thirty years, the world will be home to nine billion people, at a time when it is witnessing severe climate change and a scarcity of rain.\n\n"
    //       "Obeidat indicated that the food of millions in Asia will be threatened if the glaciers in the Himalayas melt, while small farmers in Africa, who produce most of the continent's food and depend mostly on rain, will face a decline in crops at a high rate.\n\n"
    //       "And because food security and climate change are deeply intertwined, and considering that land is the basis of life, and that agriculture is the ladder of survival for us and for the generations after us, Obeidat stressed that universities, scientists and experts are required today to cultivate a more capable agriculture that provides food security for the poor and vulnerable.\n\n"
    //       "Obeidat called for the need to work to increase the necessary funding for the development of educational, training and research programs that would develop sustainable agricultural and food systems that can withstand potential shocks, such as the economic crisis and climate change and its repercussions.\n\n"
    //       "In his intervention, the head of the National Diabetes Center, Dr. Kamel Al-Ajlouni, warned of the increasing rates of obesity in Jordan as a result of wrong dietary behaviors, pointing out that Jordan is present in the index of the ten fattest countries in the world, with a rate of 78% of the population.",
    //   contentAR:
    //       "قال رئيس الجامعة الأردنية الدكتور نذير عبيدات إن العالم يحتاج زراعة قادرة على توفير الطّعام بنسبة تزيد 70% عمّا نحتاجه اليوم"
    //       "جاء ذلك خلال كلمة ألقاها في افتتاح فعاليات اليوم العلمي لكلية الزراعة ضمن احتفالاتها باليوبيل الذهبي لتأسيها، والذي جاء بعنوان الأغذية التقليدية والوظيفية وسلامتها"
    //       "وأوضح عبيدات أن أزمة الغذاء التي يعيشها العالم هي دعوة للاستيقاظ، خاصّة وأنّه بعد أقلّ من ثلاثين عاما، سيصير العالم موطنا لتسعة مليار إنسان، في الوقت الذي يشهد تغييرا مناخيّا حادًّا وشحًّا في الأمطار"
    //       "وبَيّن عبيدات أن غذاء الملايين في قارّة آسيا سيصبح مهدّدا إذا ما ذابت الأنهار الجليديّة في جبال الهيمالايا، بينما سيواجه صغار المزارعين في إفريقيا، أولئك الّذين ينتجون معظم طعام القارّة ويعتمدون في الغالب على الأمطار، انخفاضا في المحاصيل بنسبة عالية"
    //       "ولأنّ الأمن الغذائيّ وتغيير المناخ مترابطان بعمق، وباعتبار أنّ الأرض هي أساس الحياة، وأنّ الزّراعة هي سلّم النّجاة لنا وللأجيال من بعدنا، أكد عبيدات أنّ الجامعات والعلماء والخبراء مطالبون اليوم بزراعة أكثر قدرة على توفير الأمن الغذائيّ للفقراء والضّعفاء"
    //       "ودعا عبيدات إلى ضرورة العمل على زيادة التّمويل اللّازم لتطوير البرامج التّعليميّة والتّدريبيّة والبحثيّة الّتي من شأنها تطوير أنظمة زراعيّة وغذائيّة مستدامة يمكنها تحمّل الصّدمات المحتملة، كالأزمة الاقتصاديّة والتّغيير المناخيّ وانعكاساته"
    //       "وفي مداخلته، حذّر رئيس المركز الوطني للسكري الدكتور كامل العجلوني من تعاظم نسب الإصابة بالسمنة في الأردن نتيجة السلوكيات الغذائية الخاطئة، لافتا إلى أن الأردن حاضر ضمن مؤشر الدول العشر الأكثر سمنة في العالم، بنسبة بلغت 78% من أفراد الشعب.",
    //   urlImage: "assets/images/crisis.jpg",
    //   collegeName: "University News",
    //   id: 17,
    //   audioFileEN: "assets/audio/17en.mp3",
    //   audioFileAR: "assets/audio/17ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "To introduce the Sultan Qaboos Award for Culture, Arts and Literature An Omani delegation visits the University of Jordan",
    //   titleAR:
    //       "للتعريف بجائزة السلطان قابوس للثقافة والفنون والآداب وفد عُماني يزور الجامعة الأردنية ",
    //   content:
    //       "The Vice President of the University of Jordan for Humanitarian Faculties Affairs, Dr. Salama Al-Naimat, received in his office today an Omani delegation that included the Chargé d'Affaires of the Sultanate of Oman to the Hashemite Kingdom of Jordan, Counselor Faisal bin Sultan Al-Hosani, and the Director of the Department of Cultural Affairs at the Sultan Qaboos Higher Center for Culture and Arts, Rashid bin Humaid Al-Dughaishi, and the accompanying delegation. for him.\n\n"
    //       "Al-Naimat welcomed the guest delegation, praising the historical extension of the distinguished fraternal relations that link Jordan with the Sultanate of Oman, stressing the university's pride in the students from the Arab countries who are studying at UJ as its ambassadors in their countries.\n\n"
    //       "Al Hosani said that the meeting came with the aim of introducing the Sultan Qaboos Award for Culture, Arts and Literature, its objectives, branches, cultural, artistic and literary fields, its financial value, the mechanism of nomination for it, and encouraging the reasons for participation in it.\n\n"
    //       "In turn, Al-Dughaishi reviewed the objectives of the award represented in supporting the cultural, artistic and literary fields as a way to enhance human civilizational progress, which contributes to the movement of scientific development, enriching the intellectual aspect and instilling the values of originality.\n\n"
    //       "Al-Dughaishi indicated that the award, in its tenth session for the year 2023, was allocated to the fields of media and communication studies, film directing and narration.\n\n"
    //       "It is noteworthy that the tenth session of the Sultan Qaboos Award, for which nominations will be closed on the twenty-seventh of next July, is awarded the Medal of Merit for Culture, Science and Literary Arts, in addition to a sum of money of fifty thousand Omani riyals, while the winners of the appreciation session for Arabs in general are awarded a medal. Sultan Qaboos Foundation for Culture, Science, Arts and Literature, in addition to a sum of money of one hundred thousand Omani riyals, noting that the award itself is awarded alternately every two years, in such a way that one of its sessions is local, provided that the next session is Arabic .\n\n",
    //   contentAR:
    //       "استقبل نائب رئيس الجامعة الأردنية لشؤون الكليات الإنسانية الدكتور سلامة النعيمات، في مكتبه اليوم، وفدًا عُمانيًّا ضم القائم بأعمال سفارة سلطنة عُمان لدى المملكة الأردنية الهاشمية المستشار فيصل بن سلطان الحوسني ومدير دائرة الشؤون الثقافية في مركز السلطان قابوس العالي للثقافة والفنون راشد بن حميد الدغيشي والوفد المرافق له"
    //       "ورحب النعيمات بالوفد الضيف مشيدًا بالامتداد التاريخي للعلاقات الأخوية المتميزة التي تربط الأردن بسلطنة عُمان، مؤكدًا اعتزاز وفخر الجامعة بالطلبة الوافدين من الدول العربية الشقيقة من الدارسين في الأردنية بوصفهم سفراء لها في بلدانهم."
    //       "وقال الحوسني إن اللقاء جاء بهدف التعريف بجائزة السلطان قابوس للثقافة والفنون والآداب وأهدافها وفروعها ومجالاتها الثقافية والفنية والأدبية وقيمتها المالية وآلية الترشح لها، والتشجيع علل المشاركة فيها."
    //       "بدوره، استعرض الدغيشي أهداف الجائزة المتمثلة في دعم المجالات الثقافية والفنية والأدبية باعتبارها سبيلا لتعزيز التقدم الحضاري الإنساني، ما يسهم في حركة التطور العلمي وإثراء الجانب الفكري وغرس قيم الأصالة."
    //       "وبين الدغيشي أن الجائزة، في دورتها العاشرة لعام 2023، خُصّصت لمجالات دراسات الإعلام والاتصال والإخراج السينمائي والرواية."
    //       "ويُشار إلى أن الدورة العاشرة من جائزة السلطان قابوس، التي يُغلق أبواب الترشح لها في السابع والعشرين من تموز المقبل، تمنح وسام الاستحقاق للثقافة والعلوم والفنون الأدبية، إضافة إلى مبلغ مالي قدره خمسون ألف ريال عُماني، في حين يُمنح الفائزون بالدورة التقديرية المُخصّصة للعرب عموما وسام السلطان قابوس للثقافة والعلوم والفنون والآداب، إضافة إلى مبلغ مالي قدره مئة ألف ريال عماني، مع الإشارة إلى أن الجائزة نفسها تُمنح بالتناوب كل سنتين، بشكل تكون فيه إحدى دوراتها محلية، على أن تكون الدورة التالية عربية.",
    //   urlImage: "assets/images/omani.jpg",
    //   collegeName: "University News",
    //   id: 18,
    //   audioFileEN: "assets/audio/18en.mp3",
    //   audioFileAR: "assets/audio/18ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Al-Istiqlal in a symposium of the Center for Documents, Manuscripts and Levantine Studies in \"The University of Jordan\"",
    //   titleAR:
    //       "الاستقلال في ندوة لمركز الوثائق والمخطوطات ودراسات بلاد الشام في الأردنية ",
    //   content:
    //       "Deputizing for the university president, his vice president for humanities affairs, Dr. Salama Al-Naimat, sponsored a symposium organized by the Documentation, Manuscripts and Levantine Studies Center at the university on the occasion of the 77th anniversary of independence, entitled: \"The Jordanian State from Independence to the Royal Modernization Committees\", as part of the center's celebrations of the golden jubilee of its founding.\n\n"
    //       "In his speech, which he delivered at the opening of the symposium on behalf of the university president, Al-Naimat said that what distinguishes our independence, which was linked to the rule of the Hashemites, is the national dimension as an extension of the Great Arab Revolution that was based on the principles of truth and peace without compromising rights and lofty principles.\n\n"
    //       "He added that our educational mission on Independence Day is to teach students their history, familiarize them with its documents, and restore the principles of the Great Arab Revolution to their central place in the political life of the nation.\n\n"
    //       "In her welcoming speech, the Director of the Center, Dr. Nada Al-Rawabdeh, indicated that independence is a great blessing, a great responsibility, and a story of joy, hope, and success. It indicates an outstanding leadership capable of achieving the aspirations of it and its people.\n\n"
    //       "At the outset of the symposium, which was moderated by Dr. Omar Al-Hijjawi, the Director of Military Information, Colonel Mustafa Al-Hiyari, stressed the special relationship between the Arab Army and the Mother of Universities, which dates back in history to 1961, when the story of the establishment of the \"Jordanian University\" began, and the request of the Army Commander at that time Field Marshal Habis al-Majali from the English parliamentary delegation to help establish a university in Jordan.\n\n"
    //       "In this context, al-Hiyari dealt with the military concept of independence, which is concerned with getting rid of foreign influence in all its forms and possessing the freedom of political decision that expresses the will of the people, and the military as a meaning that refers to discipline and sacrifice of the soul for the sake of the country, and the pursuit of the national interest by translating political orientations into a strategy. Military use it to confront threats, he concluded his speech by presenting the chronology of independence.\n\n"
    //       "For his part, the Secretary-General of the Ministry of Communication, Dr. Zaid Al-Nawaisa, presented a new meaning of independence, pointing out that this state, and through a hundred years of its establishment, through the Balfour Declaration and even the Nakba, was standing in the heart of the storm, adding that everyone who bet on the lack of capabilities of this state The state, or being on the brink of the abyss, fell, while its martyrs performed heroics, while persevering in receiving the displaced and refugees and treating them with a humane and moral treatment.\n\n"
    //       "Al-Nawaisa also addressed the paths of political modernization in his capacity as a former member of the Royal Commission for the Modernization of the Political System, which in turn recommended the support of women and youth as the future of Jordan. It is a royal call to formulate the new Jordanian future in its second centenary, which requires everyone to make development efforts and build on them under the Hashemite leadership.",
    //   contentAR:
    //       "مندوبًا عن رئيس الجامعة، رعى نائبه لشؤون الكليات الإنسانية الدكتور سلامة النعيمات، ندوة نظّمها مركز الوثائق والمخطوطات ودراسات بلاد الشام في الجامعة بمناسبة ذكرى الاستقلال الـ77، بعنوان: الدولة الأردنية من الاستقلال إلى لجان التحديث الملكية، وذلك ضمن احتفالات المركز باليوبيل الذهبي على تأسيسه."
    //       "وفي كلمته، التي ألقاها لدى افتتاحه الندوة مندوبًا عن رئيس الجامعة، قال النعيمات إن ما يميز استقلالنا، الذي ارتبط بحكم الهاشميين، هو البعد القومي بوصفه امتدادًا للثورة العربية الكبرى التي استندت إلى مبادئ الحقيقة والسلام دون تفريط بالحقوق والمبادئ السامية."
    //       "وأضاف أن رسالتنا التعليمية في يوم الاستقلال تتمثل في تعليم الطلبة تاريخهم، وتعريفهم بوثائقه، وإعادة مبادىء الثورة العربية الكبرى إلى مكانها المركزي في حياة الأمة السياسية."
    //       "وأشارت مدير المركز الدكتورة ندى الروابدة، في كلمتها الترحيبية، إلى أن الاستقلال نعمة كبيرة ومسؤولية عظمى وحكاية فرح وأمل ونجاح نرى بها وطننا متطورًا حديثًا في كافة  القطاعات، وعلى رأسها العلم، حيث نلمح الأردني مُزوّدًا مُسلّحًا به في كل المحافل التي يحل بها، الأمر الذي يدل على قيادة فذة قادرة على تحقيق الطموحات لها ولشعبها"
    //       "وفي مستهل الندوة، التي أدارها الدكتور عمر الحجاوي، أكد مدير الإعلام العسكري العقيد الركن مصطفى الحياري على العلاقة الخاصة التي تجمع الجيش العربي بأم الجامعات، والتي تعود في التاريخ إلى عام 1961، حين بدأت قصة إنشاء الأردنية، وطلب قائد الجيش في ذلك الوقت المشير حابس المجالي من الوفد البرلماني الإنجليزي المساعدة في إنشاء جامعة في الأردن."
    //       "وفي هذا السياق، تناول الحياري المفهوم العسكري للاستقلال المعنيّ بالتخلص من النفوذ الأجنبي بكافة أشكاله وامتلاك حرية القرار السياسي الذي يعبر عن إرادة الشعب، والعسكرية بوصفها معنًى يشير إلى الانضباطية وبذل الروح في سبيل الوطن، والسعي إلى تحقيق المصلحة الوطنية من خلال ترجمة التوجهات السياسية إلى استراتيجية عسكرية تستخدمها لمواجهة التهديدات، خاتمًا كلامه بعرض التسلسل الزمني للاستقلال."
    //       "من جهته، عرض أمين عام وزارة الاتصال الدكتور زيد النوايسة لمعنى جديد من معاني الاستقلال، مشيرًا إلى أن هذه الدولة، وعبر مئة عام من إنشائها، ومرورًا بوعد بلفور وحتى النكبة، كانت قائمة في قلب العاصفة، مضيفًا أن كل من راهن على قلة إمكانيات هذه الدولة، أو بكونه على حافة الهاوية، سقطوا، فيما قدم شهداؤه البطولات، بينما واظب على استقبال المُهجّرين واللاجئين ومعاملتهم معاملة إنسانية أخلاقية."
    //       "وتناول النوايسة أيضًا مسارات التحديث السياسي بصفته عضوا سابقا في اللجنة الملكية لتحديث المنظومة السياسية، التي بدورها أوصت بدعم المرأة والشباب بوصفهم مستقبلَ الأردن، مؤكدًا أن الطلبة مدعوون إلى الانخراط في العمل السياسي، خاصة مع إقرار تعليمات العمل الحزبي في الجامعات، ةمشيرًا إلى أن هذه المسارات تُعدّ نداءً ملكيًّا لصياغة المستقبل الأردني الجديد في مئويته الثانية، ما يستوجب من الجميع بذل جهود التنمية والبناء عليها في ظل القيادة الهاشمية.",
    //   urlImage: "assets/images/Istiqlal.jpg",
    //   collegeName: "University News",
    //   id: 19,
    //   audioFileEN: "assets/audio/19en.mp3",
    //   audioFileAR: "assets/audio/19ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The French ambassador in Amman lectures students of the French language at the \"UJ\"",
    //   titleAR: "السفير الفرنسي في عمّان يحاضر بطلبة اللغة الفرنسية في الأردنية",
    //   content:
    //       "Within a series of lectures organized by the Department of French Language and Literature at the Faculty of Foreign Languages at the University of Jordan under the title \"Francophonie for Better Professional Integration\", the French Ambassador to Amman, Alexis Lecoeur-Granmaison, lectured the department's students about his experience in the diplomatic corps and learning languages.\n\n"
    //       "Granmison, who learned the Arabic language during his work in the service, presented his experience and career in the French diplomatic corps, and his work as ambassador of the Republic of France in a number of Arab countries, pointing to the funny situations he went through due to the different dialects between them.\n\n"
    //       "During the lecture, which was held in the presence of the Dean of the College, Dr. Nahed Omeish, and moderated by Professor of French Literature at the College, Dr. Isabelle Bernard, he indicated that he was inspired by a lot during his work. By introducing him to the culture, customs, and traditions of the Egyptian, Lebanese, and finally Jordanian peoples, noting the difficulties he faced in learning the language, and he called on the students to be inspired to learn the French language from his experience in learning the Arabic language.\n\n"
    //       "For her part, Omeish emphasized the depth of cooperation between the university and the French embassy, noting that the organization of these lectures aims to provide interactive experiences for students and raise their motivation to learn the language.\n\n"
    //       "The lecture was attended by the Head of the French Language and Literature Department, Dr. Musa Awwad, professors from the department and the college, in addition to the cultural cooperation attaché at the embassy, Billy Troyes.",
    //   contentAR:
    //       "ضمن سلسلة محاضرات ينظمها قسم اللغة الفرنسية وآدابها في كلية اللغات الأجنبية في الجامعة الأردنية تحت عنوان الفرانكوفونية من أجل اندماج مهني أفضل، حاضر السفير الفرنسي في عمّان أليكسي لوكور غرانميزون في طلبة القسم حول تجربته في السلك الدبلوماسي وفي تعلم اللغات"
    //       "وعرض غرانميزون، الذي تعلم اللغة العربية خلال عمله في السلك، لتجربته ومسيرته المهنية في السلك الدبلوماسي الفرنسي، وعمله سفيرًا لجمهورية فرنسا في عدد من الدول العربية، لافتًا إلى المواقف الطريفة التي مر بها بسبب اختلاف اللهجات بينها."
    //       "وأشار خلال المحاضرة، التي عُقدت بحضور عميدة الكلية الدكتورة ناهد عميش وأدارتها أستاذة الأدب الفرنسي في الكلية الدكتورة إيزابيل برنارد، إلى أنه استلهم الكثير خلال عمله؛ بتعرفه على ثقافة وعادات وتقاليد الشعوب المصرية واللبنانية وأخيرا الأردنية، منوهًا إلى الصعوبات التي واجهته في تعلم اللغة، كما دعا الطلبة أن يستلهموا تعلم اللغة الفرنسية من تجربته في تعلم اللغة العربية."
    //       "من جهتها، أكدت عميش عمق علاقات التعاون بين الجامعة والسفارة الفرنسية، مشيرةً إلى أن تنظيم هذه المحاضرات يهدف إلى توفير خبرات تفاعلية للطلبة ورفع دوافعهم لتعلم اللغة."
    //       "وقد حضر المحاضرة رئيس قسم اللغة الفرنسية وآدابها الدكتور موسى عواد وأساتذة من القسم والكلية، إضافة إلى ملحق التعاون الثقافي في السفارة بيلي تروا.",
    //   urlImage: "assets/images/rush.jpg",
    //   collegeName: "University News",
    //   id: 20,
    //   audioFileEN: "assets/audio/20en.mp3",
    //   audioFileAR: "assets/audio/20ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "Geography students visit the memorial for the martyrs of the Battle of Karama",
    //   titleAR: "طلبة قسم الجغرافيا يزورون النصب التذكاري لشهداء معركة الكرامة",
    //   content:
    //       "On Saturday 20/5/2023, students of the Geography Department (Jordan’s Regional Geography) undertook a scientific trip under the supervision of Prof. Dr. Ali Anbar (Deputy Dean for Administrative and Financial Affairs/ Head of the Geography Department), and with the participation of Dr. Miguel Crespo (Professor of Water Resources at the University of Madrid, Spain). ) to the Jordan Valley, and the trip had started its activity by visiting the memorial for the martyrs of the eternal battle of dignity, in which the heroes of our armed forces - the Arab army did the greatest and recognized affliction, and Dr. Anbar gave the students (an eyewitness explanation) to the course of",
    //   contentAR:
    //       "قام طلبة قسم الجغرافيا (مادة جغرافية الأردن الإقليمية) يوم السبت 20/5/2023 ، برحلة علمية بإشراف الأستاذ الدكتور علي عنبر( نائب العميد للشؤون الادارية والمالية/ رئيس قسم الجغرافيا)، و مشاركة الدكتور ميغيل كريسبو ( أستاذ الموارد المائية في جامعة مدريد الاسبانية) إلى وادي الأردن وكانت الرحلة قد استهلت نشاطها بزيارة النصب التذكاري لشهداء معركة الكرامة الخالدة و التي أبلى فيها أبطال قواتنا المسلحة - الجيش العربي  البلاء  الأعظم  و المشهود ، وقدم الدكتور عنبر للطلبة ( شرح شاهد عيان) لمجريات",
    //   urlImage: "assets/images/Geography.jpg",
    //   collegeName: "School of Arts",
    //   id: 21,
    //   audioFileEN: "assets/audio/21en.mp3",
    //   audioFileAR: "assets/audio/21ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Dean of the College of Arts hosts Dr. Muhammad Salih Al-Misfir",
    //   titleAR: "عميد كلية الآداب يستضيف الدكتور محمد صالح المسفر",
    //   content:
    //       "Dean of the Faculty of Arts, Prof. Dr. Muhannad Mobaideen, hosts Dr. Muhammad Salih Al-Misfir and the presence of Prof. Dr. Muhammad Shaheen, Professor of English, as Dr. Muhammad Salih Al-Misfir is visiting Jordan with an official invitation to attend the wedding of the Crown Prince.\n\n"
    //       "Dr. Muhammad Saleh Al-Misfir:\nHe is a professor of political science at Qatar University and one of the thinkers known for their Arab nationalist orientation. He holds a PhD in political science. He wrote dozens of articles on Arab national issues (particularly the issues of Palestine and Iraq) in addition to his defense of the Arabic language",
    //   contentAR:
    //       " عميد كلية الآداب الأستاذ الدكتور مهند مبيضين يستضيف الدكتور محمد صالح المسفر وحضور الأستاذ الدكتور محمد شاهين أستاذ اللغة الانجليزية، حيث أن الدكتور محمد صالح المسفر يزور الأردن بدعوة رسمية لحضور حفل زفاف ولي العهد."
    //       " الدكتور محمد صالح المسفر:"
    //       "هو أستاذ للعلوم السياسية في جامعة قطر وأحد المفكرين المعروفين باتجاههم القومي العربي. حائز على درجة الدكتوراه في العلوم السياسية. كتب عشرات المقالات حول القضايا القومية العربية (وبالأخص قضايا فلسطين والعراق) بالإضافة إلى دفاعه عن اللغة العربية.",
    //   urlImage: "assets/images/Dean.jpeg",
    //   collegeName: "School of Arts",
    //   id: 22,
    //   audioFileEN: "assets/audio/22en.mp3",
    //   audioFileAR: "assets/audio/22ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Lecture entitled \"Community Policy and Planning\"",
    //   titleAR: "محاضرة بعنوان السياسة والتخطيط المجتمعي",
    //   content:
    //       "Part of the interactive lecture \"Social Policy and Planning\" with students of the Department of Social Work given by Dr. Maysoon Daboubi from the Jordanian Hashemite Fund for Human Development in coordination with Dr. Huda Al-Hajjaj.",
    //   contentAR:
    //       "جانب من المحاضرة التفاعلية  السياسة والتخطيط المجتمعي  مع طلبة قسم العمل الاجتماعي التي ألقتها الدكتورة ميسون الدبوبي من الصندوق الأردني الهاشمي للتنمية البشرية بالتنسيق مع الدكتورة هدى الحجاج.",
    //   urlImage: "assets/images/huda.jpeg",
    //   collegeName: "School of Arts",
    //   id: 23,
    //   audioFileEN: "assets/audio/23en.mp3",
    //   audioFileAR: "assets/audio/23ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Celebrations of the College of Arts Independence Day",
    //   titleAR: "احتفالات كلية الآداب بعيد الاستقلال",
    //   content:
    //       "Within the events and activities for the academic year 2022/2023 of the Faculty of Arts, Prof. Dr. Muhannad Mobaideen, Dean of the Faculty of Arts, on behalf of Prof. Dr. Nazir Obeidat, President of the University of Jordan, sponsored a \"free health day\", through the Department of Social Work and in cooperation with the Office of Social Work at the University Hospital of Jordan and the Club Sons of the Great Arab Revolt on the occasion of Independence Day.\n\n"
    //       "where the College, in partnership with the Public Security Directorate / Community Police Department to raise awareness of the dangers of drugs, the Eye Specialist Hospital, provided eye examination services and its parts, the Bio-foot Medical Center for foot examination services, the Nutrition Experts Center to provide nutritional advice, and the Hearing and Speech Clinic in the College Rehabilitation Sciences at the University of Jordan to provide hearing and speech examination services and the Department of Health Care in the Deanship of Student Affairs conducts a heart examination, vital signs and diabetes examination by providing all services and instructions to our children, students of the Faculty of Arts in particular and the University of Jordan in general.",
    //   contentAR:
    //       "ضمن الفعاليات والأنشطة للعام الجامعي 2022/2023 لكلية الآداب قام  الأستاذ الدكتور مهند مبيضين عميد كلية الآداب مندوباً عن الأستاذ الدكتور نذير عبيدات رئيس الجامعة الأردنية برعاية يوم صحي مجاني ، وذلك من خلال قسم العمل الاجتماعي وبالتعاون مع مكتب العمل الاجتماعي في مستشفى الجامعة الأردنية ونادي أبناء الثورة العربية الكبرى بمناسبة يوم الاستقلال، حيث قامت الكلية وبالشراكة مع مديرية الأمن العام / ادارة الشرطة المجتمعية للتوعية بمخاطر المخدرات ومستشفى العيون التخصصي بتقديم خدمات فحص العيون وأجزائها ومركز ال Bio foot Medical   لخدمات فحص القدم ومركز خبراء التغذية لتقديم استشارات غذائية وعيادة السمع والنطق في كلية علوم التأهيل في الجامعة الأردنية لتقديم خدمات فحص السمع والنطق ودائرة الرعاية الصحية في عمادة شؤون الطلبة  بإجراء فحص للقلب والعلامات الحيوية وفحص السكري بتقديم كافة الخدمات والارشادات لأبنائنا طلبة كلية الآداب خاصة والجامعة الاردنية عامة.",
    //   urlImage: "assets/images/Celebrations.jpg",
    //   collegeName: "School of Arts",
    //   id: 24,
    //   audioFileEN: "assets/audio/24en.mp3",
    //   audioFileAR: "assets/audio/24ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The visit of the students of the North and Western Semitic Inscriptions course by Prof. Dr. Khaled Al-Jabour to the Antiquities Museum",
    //   titleAR:
    //       "زيارة طلبة مساق نقوش سامية شمالية وغربية للأستاذ الدكتور خالد الجبور إلى متحف الأثار",
    //   content:
    //       "Under the slogan of museums as an educational environment, and as an extension of the previous cooperation between university professors and the management of the Museums of Antiquities and Folklore, Dr. Moath Al-Faqqa, the curator of the Museum of Antiquities, presented yesterday, Tuesday, 30/5/2023, a lecture for students of the Semitic Northern and Western Inscriptions course taught by Prof. Dr. Khaled Al-Jubbour.\n\n"
    //       "The content talks about the history and location of the Safavid inscriptions, where the students saw artifacts with Safavid inscriptions on them, and they had the opportunity to deal with them, read them and take notes about them. It was also part of the lecture by Mr. Youssef Marian / museum photographer, in which he explained how to take the archaeological picture in general, indicating how to take the picture Regarding the inscriptions and what are the most important auxiliary tools used in photography and the best times to take the picture, this lecture had a great impact on consolidating the concepts among the students because of its combination of theoretical material and practical application.",
    //   contentAR:
    //       "تحت شعار المتاحف بيئة تعليمية، وامتداداً لما كان سابقاً من تعاون مابين اساتذة الجامعة وادارة متحفي الاثار والتراث الشعبي قدم الدكتور معاذ الفقاء امين متحف الاثار، يوم امس الثلاثاء الموافق 2023/5/30 محاضرة لطلبة مساق نقوش سامية شمالية وغربية يدرسها الأستاذ الدكتور خالد الجبور وكان المحتوى يتحدث عن تاريخ ومكان وجود النقوش الصفوية حيث شاهد الطلبة قطع اثرية عليها نقوش صفوية وكانت لهم فرصة في التعامل معها وقراءتها وتدوين الملاحظات عنها، وكما كان جزءٌ من المحاضرة للسيد يوسف مريان / مصور المتحف وضح فيها كيفية التقاط الصورة الاثرية بشكل عام ومبيناً  كيفية التقاط الصورة الخاصة بالنقوش وما هي اهم الادوات المساعدة المستخدمة بالتصوير وتطرق لأفضل الاوقات المناسبة لإلتقاط الصورة، هذا وقد كان للمحاضرة اثر كبير في ترسيخ المفاهيم لدى الطلبة لما امتازت به من جمع بين المادة النظرية والتطبيق العملي.",
    //   urlImage: "assets/images/Museum.jpeg",
    //   collegeName: "School of Archaeology and Tourism",
    //   id: 25,
    //   audioFileEN: "assets/audio/25en.mp3",
    //   audioFileAR: "assets/audio/25ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Visit of the students of the Faculty of Foreign Languages to the Museum of Folklore",
    //   titleAR: "زيارة طلبة كلية اللغات الاجنبية إلى متحف التراث الشعبي",
    //   content:
    //       "Part of the visit of the students of the Faculty of Foreign Languages, and they were received by the Curator of the Folklore Museum / Prof. Tareq Muhairat, accompanied them on a tour of Mathaf, and briefed them on the history of the establishment of the Museum, and the most important heritage holdings in it.",
    //   contentAR:
    //       "جانب من زيارة طلبة كلية اللغات الاجنبية ، وكان باستقبالهم أمين متحف التراث الشعبي/ أ. طارق مهيرات، ورافقهم بجولة في متحف، واطلعهم على تاريخ نشأة متحف ، واهم المقتنيات التراثية الموجودة فيه.",
    //   urlImage: "assets/images/Folklore.jpeg",
    //   collegeName: "School of Archaeology and Tourism",
    //   id: 26,
    //   audioFileEN: "assets/audio/26en.mp3",
    //   audioFileAR: "assets/audio/26ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Department of Antiquities organized a lecture entitled: \"Intangible Heritage in Tourism. The case of the Mythical Park\"",
    //   titleAR:
    //       "نظم قسم الاثار محاضرة بعنوان: Intangible Heritage in Tourism. The case of the Mythical Park",
    //   content:
    //       "The Department of Archeology at the College of Archeology and Tourism, in cooperation and coordination with Prof. Dr. Nabil Ali, organized a lecture entitled:\n"
    //       "\"Intangible Heritage in Tourism. The case of the Mythical Park\""
    //       "Provided by Dr. Katja Virloget of the University of PrimorskaWithin the academic exchange program Erasmus\n.The lecture was attended by members of the teaching and administrative staff and students.",
    //   contentAR:
    //       "نظم  قسم الاثار في كلية الاثار والسياحة وبالتعاون والتنسيق مع الاستاذ الدكتور نبيل علي محاضرة بعنوان:"
    //       "\"Intangible Heritage in Tourism. The case of the Mythical Park\""
    //       "قدمتها الدكتورة Katja Virloget من جامعة Primorska ضمن برنامج التبادل الاكاديمي ايراسموس . وحضر المحاضرة اعضاء الهيئة التدريسيةوالادارية والطلبة.",
    //   urlImage: "assets/images/Park.jpg",
    //   collegeName: "School of Archaeology and Tourism",
    //   id: 27,
    //   audioFileEN: "assets/audio/27en.mp3",
    //   audioFileAR: "assets/audio/27ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "The college museums celebrate the International Museums Day",
    //   titleAR: "احتفالية متاحف الكلية بيوم المتاحف العالمي",
    //   content:
    //       "The International Museum Day Committee at the College of Archeology and Tourism, in cooperation with the Deanship of Student Affairs and the Model University School, and under the auspices of His Excellency Prof. Dr. Nazir Obeidat, President of the University, organized a celebration of the International Museum Day, on Sunday 5/21/2023 in the two museums of the College of Archeology and Tourism, entitled: Museums, Sustainability and quality of life \"University museums are a learning environment across generations\".\n\n"
    //       "The ceremony was presented by a. Hana Bani Atta said: “International Museum Day provides an opportunity for museum professionals to meet the public, alert them to the challenges museums face, and raise public awareness of the role museums play in the development of society. It also encourages dialogue between museum professionals. An advisory committee from the International Council of Museums identifies a topic appointed for this occasion.According to the Council of Museums, the purpose of this occasion is: "
    //       "Provide the opportunity for museum specialists to communicate with the public and alert them to the challenges facing museums if they become - as defined by the Council for Museums - institutions in the service and development of society.\n\n"
    //       "The ceremony began with the royal salutation, and verses from the wise remembrance of the student reciter Omar Al-Kilani from the University School.\n"
    //       "The Dean of the Faculty of Archeology and Tourism, Prof. Mahmoud Erinat, said that this year's celebration was titled \"Museums, Sustainability and Quality of Life\" with the aim of strengthening the relationship between the museum and society, the interaction between culture and nature, understanding the culture of societies and the relationship of peoples with each other, and to realize the true meaning of the comprehensive educational dimensions, and to preserve human memory.\n\n"
    //       "Erinat pointed out that the team of the Antiquities and Heritage Museums at the university achieves the lofty goals sought by the International Council of Museums, with the participation of the local community and educational institutions by activating museum education activities, educational lectures, and helping researchers and scholars to achieve their aspirations.\n\n"
    //       "The representative of the sponsor of the ceremony, His Excellency Professor Dr. Salama Naimat, thanked the organizers of this day, and stressed the need to celebrate the cultural and historical legacy that Jordan carries, and stressed the need for partnership between educational institutions in the country.",
    //   contentAR:
    //       "نظمت لجنة اليوم العالمي للمتاحف في  كلية الأثار والسياحة بالتعاون مع عمادة شؤون الطلبة والمدرسة الجامعة النموذجية ، وتحت رعاية معالي الأستاذ الدكتور نذير عبيدات رئيس الجامعة احتفالية بيوم المتاحف العالمي، يوم الاحد الموافق 21 / 5 / 2023 في متحفي كلية الأثار والسياحة، بعنوان:  المتاحف، الاستدامة وجودة الحياة متاحف الجامعة بيئة تعليمية عبر الأجيال."
    //       " قدمت الاحتفالية أ. هناء بني عطا فقالت:  يوفر اليوم العالمي للمتاحف الفرصة لمحترفي المتاحف لمقابلة الجمهور وتنبيههم إلى التحديات التي تواجهها المتاحف، وزيادة الوعي العام بالدور الذي تلعبه المتاحف في تنمية المجتمع. كما أنه يشجع الحوار بين المتخصصين في المتاحف. وتحدد لجنة استشارية من مجلس المتاحف العالمي موضوعا معينا لهذه المناسبة. وبحسب مجلس المتاحف فإن الغاية من هذه المناسبة هي:"
    //       "إتاحة الفرصة للمختصين بالمتاحف من التواصل مع العامة وتنبههم للتحديات التي تواجه المتاحف إذا ما أصبحت -حسب تعريف المجلس للمتاحف- مؤسسات في خدمة المجتمع وفي تطوره"
    //       "و إبتدا الحفل بالسلام الملكي، وأيات من الذكر الحكيم للمقرئ الطالب عمر الكيلاني من مدرسة الجامعة."
    //       "قال عميد كلية الآثار والسياحة الأستاذ الدكتور محمود عرينات إن الاحتفالية لهذا العام حملت عنوان المتاحف والاستدامة وجودة الحياة بهدف تعزيز العلاقة بين المتحف والمجتمع والتفاعل بين الثقافة والطبيعة وفهم ثقافة المجتمعات وعلاقة الشعوب ببعضها البعض، ولإدراك المعنى الحقيقي للأبعاد التربوية الشمولية، ولحفظ الذاكرة الإنسانية."
    //       "ولفت عرينات إلى أن فريق متحفي الآثار والتراث في الجامعة يحقق الأهداف السامية التي يسعى إليها المجلس الدولي للمتاحف، وذلك بمشاركة المجتمع المحلي والمؤسسات التعليمية عبر تفعيل أنشطة التربية المتحفية والمحاضرات التعليمية ومساعدة الباحثين والدارسين لتحقيق ما يصبون إليه."
    //       "و شكر مندوب راعي الحفل معالي الاستاذ الدكتور سلامة نعيمات القائمين على هذا اليوم، وأكد على ضرورة الاحتفاء بالمورث الحضاري والتاريخي الذي يحمله الاردن، واكد على ضرورة التشاركية بين المؤسسات التعليمية في الوطن.",
    //   urlImage: "assets/images/celebrate.jpeg",
    //   collegeName: "School of Archaeology and Tourism",
    //   id: 28,
    //   audioFileEN: "assets/audio/28en.mp3",
    //   audioFileAR: "assets/audio/28ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "Students of the Chinese language section attended the (Tea for Harmony) event organized by the Chinese Cultural Center in Jordan",
    //   titleAR:
    //       "حضور طلبة شعبة اللغة الصينية فعالية (الشاي من أجل الانسجام) التي نظمها المركز الثقافي الصيني في الأردن",
    //   content:
    //       "The first and fourth year students of the Chinese language division at the University of Jordan, accompanied by the division coordinator, Dr. Liu Guanhua, and teachers Hu Xu Hong, Jinan Ismail, and Shuruq Al-Qawasmi, attended the (Tea for Harmony) event organized by the Chinese Cultural Center in Jordan, Amman, May 25, 2023, to learn about On the Chinese tea culture, in which more than 100 participants, including Jordanian and Chinese officials and local residents, participated.\n\n"
    //       "The school, Janan Ismail, translated Chinese and Arabic for the Chinese Ambassador to Jordan, Chen Quan Dong, and the Jordanian Princess Dana Firas.\n\n"
    //       "Also, tea arts performances of Sichuan Province, southeast China, and other performances were presented, such as a display of ancient traditional clothes, in which fourth-year students from the division Lian Khaled, Lillian Al-Baraisa, Huda Dweik, Yasmine Masalmeh, and Batool Al-Amayreh participated in the show.",
    //   contentAR:
    //       "حضر طلبة السنة الأولى والرابعة من شعبة اللغة الصينية في الجامعة الأردنية برفقة منسقة الشعبة الدكتورة ليو غوان هوا و المدرسون هو شو هونغ و جنان إسماعيل و شروق القواسمي فعالية (الشاي من أجل الانسجام) التي نظمها المركز الثقافي الصيني في الأردن عمان 25 مايو 2023 ،للتعرف على ثقافة الشاي الصينية، والتي شارك فيها أكثر من 100 مشارك بينهم مسؤولون أردنيون وصينيون وسكان محليون ."
    //       "قامت المدرسة جنان إسماعيل  بترجمة اللغة الصينية و العربية للسفير الصيني لدى الأردن تشين تشوان دونغ والاميرة الأردنية دانا فراس."
    //       "كما انه تم تقديم عروض فنون الشاي الخاصة بمقاطعة سيتشوان جنوب شرق الصين وغيرها من العروض مثل عرض الملابس التقليدية القديمة حيث شارك بها طلبة السنة الرابعة من الشعبة ليان خالد، و ليليان البرايسة، و هدى الدويك، و ياسمين مسالمة، و بتول العمايرة.",
    //   urlImage: "assets/images/Chinese.jpeg",
    //   collegeName: "School of Foreign Languages",
    //   id: 29,
    //   audioFileEN: "assets/audio/29en.mp3",
    //   audioFileAR: "assets/audio/29ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Chinese Language Division - The Asian Languages Department holds a volunteer day",
    //   titleAR: "شعبة اللغة الصينية -قسم اللغات الاسيوية يقيم يوما تطوعيا",
    //   content:
    //       "Within the scope of community service, the Asian Languages Division - Chinese Language Department organized a volunteer work day.\n"
    //       "The event included cleaning campaigns for the streets parallel to the University of Jordan, as well as the Foreign Languages Garden.\n"
    //       "The students' community participation, which was supervised by Dr. Youssef Khataibeh, deepened the students' sense of the importance of volunteer work, in addition to contributing to improving the environmental situation.",
    //   contentAR:
    //       "في نطاق الخدمة المجتمعية ، نظمت شعبة اللغات الاسيوية - قسم اللغة الصينية يوم عمل تطوعي ."
    //       "الفعالية شملت حملات نظافة للشوارع الموازية للجامعة الاردنية فضلا عن حديقة اللغات الاجنبية."
    //       "  المشاركة المجتمعية للطلبة والتي اشرف عليها دكتور يوسف خطايبة عمقت الشعور باهمية العمل التطوعي لدى الطلبة الى جانب المساهمة في تحسين الوضع البيئي.",
    //   urlImage: "assets/images/Asian.jpg",
    //   collegeName: "School of Foreign Languages",
    //   id: 30,
    //   audioFileEN: "assets/audio/30en.mp3",
    //   audioFileAR: "assets/audio/30ar.mp3",
    // ),
    //
    // ///here
    // NewsDataModel(
    //   title:
    //       "The Turkish Language Division of the Asian Languages Department organizes a student trip to Ajloun to celebrate Atatürk, Youth and Sports Day",
    //   titleAR:
    //       "شعبة اللغة التركية في قسم اللغات الآسيوية تنظم رحلة طلابية إلى عجلون للاحتفال بعيد أتاتورك والشباب والرياضة",
    //   content:
    //       "The Turkish Language Division, under the supervision of the Division Coordinator and Head of the Department of Asian Languages, Dr. Bagdakul Musa, organized a sports trip on the occasion of Atatürk, Youth and Sports Day, with third and fourth year students from the Turkish Language Division, to Ajloun Governorate on Saturday, May 20.\n\n"
    //       "The trip was organized on the occasion of the May 19 festivities, which are an important national occasion in Turkey to commemorate the memory of its founder, Mustafa Kemal Atatürk, as well as honoring the country's youth and sports.\n\n"
    //       "Dr. Bagdakul Moussa has organized a program full of sporting activities and events.\n\n"
    //       "This trip is an excellent opportunity for students to expand their cultural and linguistic knowledge practically outside the classroom. Students interacted enthusiastically with the activities and events that were organized, which contributed to enhancing team spirit and cooperation among students.",
    //   contentAR:
    //       "قامت شعبة اللغة التركية بإشراف منسقة الشعبة و رئيسة قسم اللغات الآسيوية، الدكتورة بغداكول موسى، بتنظيم رحلة رياضية بمناسبة عيد أتاتورك والشباب والرياضة مع طلاب السنة الثالثة والرابعة من شعبة اللغة التركية، إلى محافظة عجلون يوم السبت الموافق ٢٠ مايو."
    //       "تم تنظيم الرحلة بمناسبة احتفالات 19 مايو، والتي تعتبر مناسبة وطنية مهمة في تركيا للاحتفال بإحياء ذكرى مؤسسها مصطفى كمال أتاتورك، بالإضافة إلى تكريم الشباب والرياضة في البلاد."
    //       "الدكتورة بغداكول موسى قامت بتنظيم برنامج مليء بالأنشطة الرياضية والفعاليات."
    //       "وتعد هذه الرحلة فرصة ممتازة للطلاب لتوسيع معرفتهم الثقافية واللغوية بشكل عملي خارج القاعة الدراسية. تفاعل الطلاب بحماس مع الأنشطة والفعاليات التي تم تنظيمها، مما ساهم في تعزيز روح الفريق والتعاون بين الطلاب.",
    //   urlImage: "assets/images/Turkish.jpeg",
    //   collegeName: "School of Foreign Languages",
    //   id: 31,
    //   audioFileEN: "assets/audio/31en.mp3",
    //   audioFileAR: "assets/audio/31ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Summer Vibes with Asian",
    //   titleAR: "نشاط : Summer Vibes with Asian",
    //   content:
    //       "On Sunday, 5/21, the Asian Languages Team from the Faculty of Foreign Languages at the University of Jordan carried out its activity (Summer Vibes with Asian).\n\n"
    //       "Where it was held in the college yard under the supervision of the Head of the Department of Asian Languages, Dr. Baghda Kol Musa. The activity included many entertainment, cultural and academic activities.",
    //   contentAR:
    //       "Summer Vibes with Asian قام فريق اللغات الآسيوية  ايجن سبايسز  (Asian Spices) من كلية اللغات الأجنبية في الجامعة الأردنية، يوم الاحد الموافق ٢١ / ٥ نشاطه"
    //       "حيثُ أقيم في ساحة  الكلية بإشراف رئيسة قسم اللغات الآسيوية الدكتورة  بغدا كول موسى. وتضمن النشاط  العديد من  الفقرات الترفيهية و الثقافية و الأكاديمية.",
    //   urlImage: "assets/images/Summer.jpeg",
    //   collegeName: "School of Foreign Languages",
    //   id: 32,
    //   audioFileEN: "assets/audio/32en.mp3",
    //   audioFileAR: "assets/audio/32ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The visit of Her Excellency, the Ambassador of the State of Bangladesh, Nahidah Subhan, accompanied by Mr. Shahed Bin Aziz, Chargé d'Affairs, to the Prince Hussein Bin Abdullah II College of International Studies at the University of Jordan.",
    //   titleAR:
    //       "زيارة سعادة سفيرة دولة بنغلادش ناهده سبحان Nahidah Subhan برفقة السيد Shahed Bin Aziz القائم باعمال سعادة السفيرة الى كلية الأمير الحسين بن عبدالله الثاني للدراسات الدولية في الجامعة الأردنية.",
    //   content:
    //       "During her visit to the Prince Hussein Bin Abdullah II College of International Studies at the University of Jordan, Prof. Dr. Faisal Odeh Al-Raffou’, Dean of the Prince Hussein Bin Abdullah II College of International Studies, discussed with Her Excellency Ambassador Nahidah Subhan, about the aspects of cooperation between the two countries, where Prof. Dr. Al-Raffou’ reviewed what The University of Jordan is doing the consolidation of cooperation relations in the scientific and cultural field, and the initiative of the college to open horizons for cooperation between the two countries, Jordan and Bangladesh, such as the exchange of scholarships, students and academic visits.\n\n"
    //       "Professor Al-Rufou' and His Excellency the Ambassador also reviewed all the political, economic and cultural relations that share many aspects of common factors, such as culture and deep-rooted history, in addition to the strong friendship between the leaderships of the two countries, Jordan and Bangladesh.",
    //   contentAR:
    //       "خلال زيارتها لكلية الأمير الحسين بن عبدالله الثاني للدراسات الدولية في الجامعة الأردنية،  تباحث الاستاذ الدكتور فيصل عوده الرفوع/ عميد كلية الأمير الحسين بن عبدالله الثاني للدراسات الدولية، مع سعادة السفيرة Nahidah subhan ، حول اوجه التعاون بين البلدين، حيث قام الاستاذ الدكتور الرفوع باستعراض ما تقوم به الجامعة الأردنية من توطيد لعلاقات التعاون في المجال العلمي والثقافي، وما تبادر به الكلية من فتح آفاق للتعاون بين البلدين، الأردن وبنغلاديش كتبادل البعثات الدراسية والطلبة و الزيارات الأكاديمية."
    //       "كما استعرض الأستاذ الرفوع وسعادة السفيرة كافة العلاقات السياسية والاقتصادية والثقافية اللذين يشتركان في العديد من اوجه العوامل المشتركة،  كالثقافة والتاريخ المتجذر، علاوة على  علاقات الصداقة  المتينة بين قيادتي البلدين، الأردن وبنغلاد",
    //   urlImage: "assets/images/Bangladesh.jpeg",
    //   collegeName: "School of International Studies",
    //   id: 33,
    //   audioFileEN: "assets/audio/33en.mp3",
    //   audioFileAR: "assets/audio/33ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Discuss opportunities for cooperation with the Islamic University of India",
    //   titleAR: "بحث فرص التعاون مع الجامعة الإسلامية في الهند",
    //   content:
    //       "Today, Thursday, the Dean of the Prince Hussein Bin Abdullah II School of International Studies at the University of Jordan, Dr. Faisal Al-Rafu', received Dr. Abdullah Manham, a representative of the Islamic University of India.\n\n"
    //       "The two sides discussed, in the presence of the Director of the International Affairs Unit, Dr. Hadeel Yassin, mechanisms and opportunities for joint cooperation in the academic and cultural fields, and the possibility of exchanging students, researchers and faculty members.\n\n"
    //       "During the meeting, Al-Rufou reviewed the course of the college, its departments, and the academic programs it offers, and pointed out during his speech to the depth of the historical relations that unite the two friendly countries, especially in the higher education sector.\n\n"
    //       "For her part, Al-Yaseen referred to a number of possible cooperation opportunities with the University of Jordan, such as the possibility of cooperation in the field of student exchange to study Arabic, Sharia and postgraduate studies.\n\n"
    //       "In turn, the guest expressed his happiness at visiting the university, praising the prestigious academic reputation it enjoys, and expressing his hope for the consolidation of academic cooperation between the University of Jordan and the Islamic University in the Indian state of Kerala.",
    //   contentAR:
    //       "استقبل عميد كلية الأمير الحسين بن عبد الله الثاني للدراسات الدولية في الجامعة الأردنية الدكتور فيصل الرفوع اليوم الخميس ممثلًا عن الجامعة الإسلامية في الهند الدكتور عبد الله مانهام."
    //       "وبحث الجانبان، بحضور مديرة وحدة الشؤون الدولية الدكتورة هديل ياسين، آليات وفرص التعاون المشترك في المجالات الأكاديمية والثقافية وإمكانية تبادل الطلبة والباحثين وأعضاء هيئة التدريس."
    //       "واستعرض الرفوع خلال اللقاء مسيرة الكلية وأقسامها والبرامج الأكاديمية التي تقدمها، وأشار خلال حديثه إلى عمق العلاقات التاريخية التي تجمع البلدين الصديقين، لا سيما في قطاع التعليم العالي، مرحّبًا بأي تعاون من شأنه إفادة الطرفين، خصوصا في استقبال طلبة العلوم السياسية لدراسة الماجتسير والدكتوراه في الكلية."
    //       "من جهتها، أشارت الياسين إلى عدد من فرص التعاون الممكنة مع الجامعة الأردنية، كإمكانية التعاون في مجال تبادل الطلبة لدراسة اللغة العربية والشريعة والدراسات العليا."
    //       "بدوره، عبر الضيف عن سعادته بزيارة الجامعة، مشيدًا بالسّمعة الأكاديمية المرموقة التي تتمتع بها، ومعربًا عن أمله بتوطيد علاقات التعاون الأكاديمي بين الجامعة الأردنية والجامعة الإسلامية في ولاية كيرالا الهندية.",
    //   urlImage: "assets/images/India.jpeg",
    //   collegeName: "School of International Studies",
    //   id: 34,
    //   audioFileEN: "assets/audio/34en.mp3",
    //   audioFileAR: "assets/audio/34ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The meeting of the Deans Council at the University of Jordan for the first time in the desert",
    //   titleAR: "اجتماع مجلس العمداء في الجامعة الأردنية لأول مرة في  الصحراء",
    //   content:
    //       "In a precedent that is the first of its kind in Jordanian universities, UJ deviated from its official protocols to hold a meeting of its deans' council in a special way in the \"heart of the desert\", on a barren land of 1960 dunums, which is the university's station for dry lands research in the Muwaqqar area, to find out directly about its needs.\n\n"
    //       "The President of the University of Jordan, Dr. Nazir Obeidat, welcomed the princess and all the attendees, pointing out that this meeting is the first for the university in this region, as it has recently seen things differently with regard to some of its decisions that need direct participation with the local community and industrial institutions in all sectors that need to develop.\n\n"
    //       "Obeidat stressed that the presence of all these parties in the meeting is an important factor in coming up with real recommendations that are closer to implementation than if the meeting was held in its traditional way, pointing out in this regard to the importance of the College of Agriculture, which has a large and important role in the development and development of agriculture, not only on a narrow level, but also on An even greater level that includes the whole kingdom.",
    //   contentAR:
    //       " في سابقة هي الأولى من نوعها في الجامعات الأردنية ، خرجت  الأردنية   عن بروتوكولاتها الرسمية لتعقد اجتماع مجلس عمدائها  بصورة خاصة في قلب الصحراء ، فوق أرض بور مساحتها 1960 دونما هي محطة الجامعة لبحوث الاراضي الجافة  في منطقة الموقر للوقوف بشكل مباشر على احتياجاتها."
    //       "ورحّب رئيس الجامعة الأردنية الدكتور نذير عبيدات بالأميرة والحضور كافة، مشيرا إلى أن هذا الاجتماع هو الأول للجامعة في هذه المنطقة، حيث باتت في الآونة الأخيرة تنظر للأمور بشكل مختلف فيما يتعلق ببعض قراراتها التي تحتاج تشاركية مباشرة مع المجتمع المحلي والمؤسسات الصناعية في كافة القطاعات التي تحتاج إلى تطوير."
    //       "وأكّد عبيدات أن وجود جميع هذه الأطراف في الاجتماع عامل مهم للخروج بتوصيات حقيقية أقرب للتنفيذ مما لو عُقد الاجتماع بمنحاه التقليدي، لافتًا في هذا الصدد إلى أهمية كلية الزراعة التي يقع على عاتقها دور كبير ومهم في تطوير وتنمية الزراعة لا على مستوى ضيق وحسب، بل على مستوى أكبر من ذلك يشمل المملكة كلها.",
    //   urlImage: "assets/images/meeting.jpeg",
    //   collegeName: "School of International Studies",
    //   id: 35,
    //   audioFileEN: "assets/audio/35en.mp3",
    //   audioFileAR: "assets/audio/35ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "Visual arts students participate in the Applied Sciences Forum",
    //   titleAR: "طلبة الفنون البصرية يشاركون بملتقى العلوم التطبيقية",
    //   content:
    //       "Within the framework of the College of Art and Design's endeavor to develop the skills of its students, highlight their abilities, and support their interaction with their peers in other universities, students of the Interior Design concentration in the Department of Visual Arts at the college participated in the seventh interior design forum organized by the Applied Science University on Wednesday 5/17/2023.\n\n"
    //       "The students presented a group of models and works related to furniture design, where the participants in the forum expressed their admiration for the distinguished works presented by the college students, which reflect the extent of interest that the College of Art and Design in particular and the University of Jordan in general give to their students.\n\n"
    //       "Dr. Shereen Tablat, who supervised the department's students participating in the forum, said that such forums contribute to motivating students, developing their skills and abilities, and opening new horizons for them to see what their colleagues in other universities offer.\n\n"
    //       "Tablat added that the works presented by students of the Faculty of Arts at the university won the approval and satisfaction of academics and specialists, who praised the educational outputs in the Visual Arts Department of the Faculty of Art and Design.\n\n"
    //       "The students, for their part, were very happy to participate in the forum to present and present their work.\n"
    //       "It is noteworthy that the forum also included a symposium on furniture manufacturing, in which the concerned academics, professionals and manufacturing companies participated.",
    //   contentAR:
    //       " في إطار سعي كلية الفنون والتصميم لتطوير مهارات طلبتها وابراز قدراتهم ودعم تفاعلهم مع اقرانهم في الجامعات الاخرى شارك طلبة تركيز التصميم الداخلي في قسم الفنون البصرية في الكلية في ملتقى التصميم الداخلي السابع الذي نظمته جامعة العلوم التطبيقية يوم الاربعاء 17/5/2023."
    //       "وقام الطلبة بعرض مجموعة من المجسمات والاعمال الخاصة بمادة تصميم الاثاث حيث عبر المشاركون في الملتقى عن اعجابهم بما قدمه طلبة الكلية من اعمال مميزة تعكس مدى الاهتمام الذي توليه كلية الفنون والتصميم بشكل خاص والجامعة الاردنية بشكل عام لطلبتها."
    //       "وقام الطلبة بعرض مجموعة من المجسمات والاعمال الخاصة بمادة تصميم الاثاث حيث عبر المشاركون في الملتقى عن اعجابهم بما قدمه طلبة الكلية من اعمال مميزة تعكس مدى الاهتمام الذي توليه كلية الفنون والتصميم بشكل خاص والجامعة الاردنية بشكل عام لطلبتها."
    //       "واضافت طبلت ان الاعمال التي قدمها طلبة كلية الفنون في الجامعة نالت استحسان ورضى الأكاديميين والمتخصصين الذين اثنوا على مخرجات التعليم في قسم الفنون البصرية في كلية الفنون والتصميم."
    //       "الطلبة من جانبهم أبدوا سعادة غامرة بمشاركتهم في الملتقى لتقديم وعرض اعمالهم."
    //       "يذكر ان الملتقى قد تضمن ايضا ندوة حوارية حول تصنيع الاثاث شارك بها المعنيين من أكاديميين ومهنيين وشركات تصنيع.",
    //   urlImage: "assets/images/Visual.jpg",
    //   collegeName: "School of Arts and Design",
    //   id: 36,
    //   audioFileEN: "assets/audio/36en.mp3",
    //   audioFileAR: "assets/audio/36ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "The cultural day of the College of Arts and Design",
    //   titleAR: "اليوم الثقافي لكلية الفنون والتصميم",
    //   content:
    //       "Today, the Faculty of Art and Design at the University of Jordan launched the Scientific Day activities, coinciding with the nation's celebrations of the 77th Independence Day and the wedding of Crown Prince His Highness Prince Hussein bin Abdullah II, and the university's celebrations of these two occasions.\n\n"
    //       "The President of the University of Jordan, Dr. Nazir Obeidat, said, during his sponsorship of the opening of the activities of the day, which was attended by his deputies, some deans of faculties, faculty members, and a group of students, \"The Faculty of Arts is the most creative and bright, and I hope that this faculty will be up to the responsibility, as it forces us to see the best.\" And to feel what we see of creativity and innovation, as this college frames the relationship of man with man, and his relationship with nature, and it is not possible for us to live without the sense of the visual and the audible, and without the sense of the other, because this life is beautiful, and there is room for creativity and noble human work, \"pointing out that\" we can To be people capable of knowing and feeling all that is beautiful.\n\n"
    //       "Obeidat stressed the importance of the role of the College of Art and Design for the university, pointing out that it prepares the student as a person who is able to live independently and think of all that is beautiful. The forms of art that combine both sides, both audio and visual, are the basis for innovation and creativity, and constitute an important aspect of people's lives.\n\n"
    //       "He added that former creators, such as Da Vinci, Picasso, and others, have preserved their names and immortalized them because of the beautiful works they left behind, stressing that the university graduates are required to be able to bring about change.\n\n"
    //       "In turn, the Dean of the College, Dr. Muhammad Nassar, stated that the college's cultural day coincided with the universities' celebrations of the two occasions dear to the hearts of Jordanians. Commemorating the Independence Day is a national occasion that draws inspiration from the sublime values and noble goals it entails in serving the nation, upholding its status, preserving its identity and components, and defending it in order to promote its renaissance.\n\n"
    //       "He said that the College of Arts and Design is keen to hold many activities during the academic year, to review the achievements of faculty members and students, and from this standpoint, the College's cultural day represents the fruit of their achievements during the second semester of this year.\n\n"
    //       "The cultural day included many lyrical paragraphs and Arabic and Western musical pieces, as well as patriotic songs in celebration of Independence Day, performed by students of musical arts.\n\n"
    //       "Obeidat inaugurated the art exhibition, which dealt with paintings, “graphic art” paintings, and handicrafts of ceramics and sculpture, on which students from the Visual Arts Department of all academic years worked on, in which they gathered their energies and creativity. Scientific day activities throughout the day.",
    //   contentAR:
    //       "انطلقت اليوم في كلية الفنون والتصميم في الجامعة الأردنية أعمال اليوم العلمي، تزامنًا مع احتفالات الوطن بعيد الاستقلال السابع والسبعين وزفاف وليّ العهد سمو الأمير الحسين بن عبد الله الثاني، واحتفالات الجامعة بهاتين المناسبتين."
    //       "وقال رئيس الجامعة الأردنية الدكتور نذير عبيدات، خلال رعايته افتتاح فعاليات اليوم الذي حضره نوابه وبعض من عمداء الكليات وأعضاء الهيئة التدريسية وجمع من الطلبة تُعدّ كلية الفنون الأكثر إبداعًا وإشراقًا، وأتمنى أن تكون هذه الكلية على قدر المسؤولية، إذ إنّها تجبرنا على أن نرى الأفضل، وأن نحس بما نراه من إبداع وابتكار، فهذه الكلية تؤطر لعلاقة الإنسان بالإنسان، وعلاقته بالطبيعة، ولا يمكن لنا أن نعيش دون الإحساس بالمرئي والمسموع، ودون الإحساس بالآخر، فهذه الحياة جميلة، وفيها مجال للإبداع والعمل الإنساني الراقي، لافتًا إلى أنّنا نستطيع أن نكون أُناسًا قادرين على المعرفة والشعور بكل ما هو جميل"
    //       "وأكّد عبيدات على أهميّة دور كلية الفنون والتّصميم للجامعة، مشيرًا إلى أنّها تُعِدُّ الطالب الإنسان القادر على العيش باستقلال، والتفكير بكل ما هو جميل، داعيًا أعضاء هيئة التدريس إلى بذل المزيد لتحفيز طلبة الكلية على الإبداع والابتكار، واصفًا الكلية بكونها فنًّا، إذ إنّ أشكال الفنون التي تجمعها بين جنبيها، السماعية منها والبصرية، هي الأصل في الابتكار والإبداع، وتشكّل جانبًا مهمًّا من حياة الناس."
    //       "وأضاف بأنّ المبدعين السابقين كدافنشي وبيكاسو وغيرهم، حُفظت أسماؤهم وخُلّدت لما تركوه من أعمال جميلة،  مؤكّدًا أنّ المطلوب من خرّيجي الجامعة أن يكونوا قادرين على إحداث التغيير."
    //       "بدوره، بين عميد الكلية الدكتور محمد نصار أنّ اليوم الثقافي للكلية جاء تزامنا مع احتفالات الجامعات بالمناسبتين العزيزتين على قلوب الأردنيين؛ فتخليد ذكرى الاستقلال يُعدّ مناسبة وطنية نستلهم ما تنطوي عليه من قيم سامية وغايات نبيلة خدمةً للوطن وإعلاءً لمكانته وللمحافظة على هويته ومقوماته وللدفاع عنه تعزيزًا لنهضته."
    //       "وقال إنّ كلية الفنون والتصميم تحرص على عقد عديد من النشاطات خلال العام الدراسي، تستعرض إنجازات أعضاء الهيئة التدريسية والطلبة، ومن هذا المنطلق، يُمثّل اليوم الثقافي للكلية ثمرة إنجازاتهم خلال الفصل الدراسي الثاني من هذا العام."
    //       "واشتمل اليوم الثقافي على عديد من الفقرات الغنائية والمعزوفات الموسيقية العربية والغربية، إلى جانب أغانٍ وطنية احتفالًا بعيد الاستقلال أدّاها طلبة الفنون الموسيقية."
    //       "وافتتح عبيدات المعرض الفني، الذي تناول لوحات فنية ولوحات جرافيك آرت ومشغولات يدوية من الخزف والنحت عمل عليها طلبة من قسم الفنون البصرية من كافة السنوات الدراسية جمعوا فيها طاقاتهم وإبداعاتهم، وعرض مسرحي أداه طلبة قسم الفنون المسرحية وحضر جزء منه رئيس الجامعة ونوابه، وتستمر فعاليات اليوم العلمي على مدار هذا اليوم .",
    //   urlImage: "assets/images/Design.jpg",
    //   collegeName: "School of Arts and Design",
    //   id: 37,
    //   audioFileEN: "assets/audio/37en.mp3",
    //   audioFileAR: "assets/audio/37ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Dialogue session directed by Darine Salam",
    //   titleAR: "جلسة حوارية للمخرجه دارين سلام",
    //   content:
    //       "A dialogue session was held in the auditorium of the College of Arts and Design, directed by Darine Salam, with the students of the college, in the presence of the Dean of the College, Professor Dr. Muhammad Nassar, and the Assistant Dean for Student Affairs Fatima Al-Tawalbeh",
    //   contentAR:
    //       "اقيمت في مدرج كلية الفنون والتصميم جلسة حوارية للمخرجه  دارين سلام مع طلبة الكلية بوجود عميد الكلية الاستاذ الدكتور محمد نصار ومساعد العميد لشؤون الطلبة فاطمة الطوالبة",
    //   urlImage: "assets/images/Salam.jpg",
    //   collegeName: "School of Arts and Design",
    //   id: 38,
    //   audioFileEN: "assets/audio/38en.mp3",
    //   audioFileAR: "assets/audio/38ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "Hosting the painter and designer Karim El-Najjar",
    //   titleAR: "اسضافة الرسام و المصمم كريم النجار",
    //   content:
    //       "The College of Arts and Design hosted the painter and designer Karim Al-Najjar : \n who gave a lecture on How to get better as an artist character and environment design, the art industry and how to be an art director.",
    //   contentAR:
    //       "استضافة كلية الفنون والتصميم الرسام  والمصمم كريم النجار الذي قدم محاضرة عن : how to get better as an artist character and environment design, the art industry and how to be an art director.",
    //   urlImage: "assets/images/Karim.jpg",
    //   collegeName: "School of Arts and Design",
    //   id: 39,
    //   audioFileEN: "assets/audio/39en.mp3",
    //   audioFileAR: "assets/audio/39ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Under the supervision of Dr. Ayed Zureikat, students participated in the Yarmouk Conference",
    //   titleAR: "بإشراف د.عايد زريقات مشاركة الطلبة بمؤتمر اليرموك",
    //   content:
    //       "Six students out of seven master's students enrolled in the course of sports psychology taught by Dr. Ayed Zureikat at the Faculty of Sports Sciences / University of Jordan participated in the tenth Yarmouk University conference titled: Sports in light of global developments \"World Cup Qatar 2022 as a model\" where Each student participated in an individual research in the field of applied sports psychology under the guidance and direction of the subject teacher, Dr. Ayed Zureikat",
    //   contentAR:
    //       "  شارك ستة طلاب من أصل سبعة طلاب من طلبة الماجستير المسجلين في مساق علم النفس الرياضي التي يقوم بتدريسها الدكتور عايد زريقات في كلية علوم الرياضة /الجامعة الأردنية بمؤتمر جامعة اليرموك العاشر الموسوم بـــ : الرياضة في ظل التطورات  العالمية مونديال قطر 2022 نموذجا حيث شارك كل طالب في بحث منفرد في مجال علم النفس الرياضي التطبيقي بإرشاد وتوجيه من مدرس المادة الدكتور عايد زريق",
    //   urlImage: "assets/images/Yarmouk.jpeg",
    //   collegeName: "School of Sport Science",
    //   id: 40,
    //   audioFileEN: "assets/audio/40en.mp3",
    //   audioFileAR: "assets/audio/401ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Participation of Prof. Dr. Khetam Ai in the fourth meeting of the Asian Union",
    //   titleAR: "مشاركة أ.د.ختام آي في إجتماع الإتحاد الأسيوي الرابع",
    //   content:
    //       "Representing her country, Jordan, and as an elected member of the Asian Boxing Federation, Prof. Dr. Khitam Musa Aye participated in the fourth meeting of the Asian Boxing Federation, which was held in Thailand / Bangkok 2023",
    //   contentAR:
    //       "ممثلة عن بلدها الأردن وبصفتها عضو منتخ في الإتحاد الأسيوي للملاكمة ، شاركت الأستاذ الدكتورة ختام موسى آي في الإجتماع الرابع للإتحاد الأسيوي للملاكمة والذي أقيم في تايلند / بانكوك 2023",
    //   urlImage: "assets/images/Union.jpeg",
    //   collegeName: "School of Sport Science",
    //   id: 41,
    //   audioFileEN: "assets/audio/41en.mp3",
    //   audioFileAR: "assets/audio/411ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Tree celebration",
    //   titleAR: "الإحتفال بعيد الشجرة",
    //   content:
    //       "Under the auspices of the Dean of the College of Sports Sciences, Prof. Dr. Walid Al-Rahahleh, the college students celebrated Tree Day for the year 2023 at the college site, where they planted trees to confirm their role in preserving and protecting the environment.",
    //   contentAR:
    //       "تحت رعاية عميد كلية علوم الرياضة الأستاذ الدكتور وليد الرحاحلة احتفل طلبة الكلية في موقع الكلية بيوم الشجرة لعام 2023 حيث قاموا بزراعة الأشجار لتأكيد دورهم في المحافظة على البيئة وحمايتها",
    //   urlImage: "assets/images/Tree.jpeg",
    //   collegeName: "School of Sport Science",
    //   id: 42,
    //   audioFileEN: "assets/audio/42en.mp3",
    //   audioFileAR: "assets/audio/421ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The college hosts its graduates and reviews their successful experiences",
    //   titleAR: "الكلية تستضيف خريجيها وتستعرض تجاربهم الناجحة",
    //   content:
    //       "Today, the Faculty of Sports Sciences at the University of Jordan, as part of its endeavor to share the success stories of its graduates, hosted Al-Basha Jihad Qutaishat, the former President of the Military Sports Association and the current Vice President of the Volleyball Association, and Ms. Lana Al-Jaghbir, the former Secretary General of the Olympic Committee. They are graduates of the Faculty of Physical Education at the University of Jordan. Students of the College of Sports Sciences from different academic years shared success stories and challenges",
    //   contentAR:
    //       "استضافت اليوم كلية علوم الرياضة في الجامعة الأردنية ضمن سعيها لمشاركة قصص نجاح خريجيها  كل من الباشا جهاد قطيشات رئيس اتحاد الرياضة العسكرية سابقا ونائب سمو رئيسة اتحاد كرة الطائرة حاليا والسيدة لانا الجغبير الامين العام السابق للجنة الاولمبية وهم من  خريجين كلية التربية الرياضية في  الجامعة الأردنية حيث تم مشاركة طلبة كلية علوم الرياضة من مختلف السنوات الدراسية قصص النجاح والتحديات",
    //   urlImage: "assets/images/exp.png",
    //   collegeName: "School of Sport Science",
    //   id: 43,
    //   audioFileEN: "assets/audio/43en.mp3",
    //   audioFileAR: "assets/audio/431ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "The United Nations lectures at the Faculty of Law",
    //   titleAR: "الأمم المتحدة تحاضر في كلية الحقوق",
    //   content:
    //       "The Faculty of Law hosted the youth affairs specialist at the Office of the United Nations Resident Coordinator in Jordan, Mrs. Susan Al-Helou, during an introductory lecture for students of the international organization course. Mrs. Al-Helou talked about the nature of the work of the United Nations, its organization and its relationship with youth affairs in the states parties. She focused in her speech on the goals of sustainable development and the role of the United Nations in partnership with national authorities to implement the United Nations development activities in Jordan within the framework of strategic planning for cooperation at the national level by implementing the development plan sustainable development for the year 2030 through a human rights-based approach.\n\n"
    //       "The lecture was moderated by Dr. Ghufran Hilal / Assistant Dean for Development, Quality, Student Affairs and Alumni Affairs, and she indicated that the organization of this lecture comes with the aim of linking the theoretical academic aspects of the subject of international regulation with the professional and practical aspects concerned in the law of international organizations in particular and public international law in general.",
    //   contentAR:
    //       " استضافت كلية الحقوق أخصائية الشؤون الشبابية لدى مكتب المنسق المقيم للأمم المتحدة في الأردن /السيدة سوسان الحلو خلال محاضرة تعريفية لطلبة مادة التنظيم الدولي .  تحدثت السيدة الحلو عن طبيعة عمل هيئة الامم المتحدة وتنظيمها وعلاقتها بالشؤون الشبابية في الدول الأطراف .وركزت في حديثها على اهداف التنمية المستدامة ودور الأمم المتحدة بالشراكة مع الجهات الوطنية لتنفيذ أنشطة الأمم المتحدة الإنمائية في الأردن ضمن إطار التخطيط الاستراتيجي للتعاون  على المستوى الوطني  وذلك بتنفيذ خطة التنمية المستدامة لعام 2030 من خلال النهج القائم  على حقوق الانسان "
    //       "أدارت المحاضرة الدكتورة غفران هلال/ مساعد العميد لشؤون التطوير والجودة وشؤون الطلبة والخريجين ، وأشارت الى أن تنظيم هذه المحاضرة ياتي بهدف الربط ما بين الجوانب الأكاديمية النظرية لمادة التنظيم الدولي مع الجوانب المهنية والتطبيقية المعنية  في القانون المنظمات الدولية بشكل خاص والقانون الدولي العام عموماً .",
    //   urlImage: "assets/images/United.jpg",
    //   collegeName: "School of Law",
    //   id: 44,
    //   audioFileEN: "assets/audio/44en.mp3",
    //   audioFileAR: "assets/audio/441ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A delegation from the University of Lucerne from Switzerland visits the Faculty of Law",
    //   titleAR: "وفد من جامعة لوزيرن من سويسرا يزور كلية الحقوق",
    //   content:
    //       "The Faculty of Law received Swiss doctoral students from the University of Lucerne; Tim Cedric Meyer, major in criminal law and philosophy of law, and Nicola Luca Sutter, student of political science.\n\n"
    //       "The doctoral students presented a lecture on the Swiss legal culture, in which the students talked about the structure and work of the legal system, in addition to a brief explanation of the Swiss courts, including the federal courts and judicial councils, and they talked about the judicial hierarchy in Switzerland. The session deepened the students' understanding of the legal framework of Switzerland and provided valuable points of comparison between the Swiss legislative system and the Jordanian legislative system.",
    //   contentAR:
    //       "استقبلت كلية الحقوق طلاب الدكتوراه السويسريين من جامعة لوزيرن؛ تيم سيدريك ماير المتخصص في فلسفة القانون الجنائي وفلسفة القانون ونيكولا لوكا سوتر طالب العلوم السياسة."
    //       " حيث قام طلاب الدكتوراه بعرض محاضرة حول الثقافة القانونية السويسرية والتي تحدث فيها الطلبة  عن هيكل النظام القانوني وعمله و بالاضافة الى شرح موجز للمحاكم السويسرية و من ضمنها المحاكم الفيدرالية والمجالس القضائية وتم حديث عن  التسلسل الهرمي القضائي في سويسرا. عمقت الجلسة فهم الطلبة  للإطار القانوني لسويسرا وقدمت نقاطا قيّمة للمقارنة ما بين النظام التشريعي السويسري والنظام التشريعي الأردني.",
    //   urlImage: "assets/images/Lucerne.jpg",
    //   collegeName: "School of Law",
    //   id: 45,
    //   audioFileEN: "assets/audio/45en.mp3",
    //   audioFileAR: "assets/audio/451ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "In partnership with the Independent Commission for Elections and in cooperation with the I Participate Program, the Center for Women's Studies at UJ holds a panel discussion entitled \"The Reflection of Constitutional Amendments on Young Women's Participation in the Electoral and Party Process\"",
    //   titleAR:
    //       "بالشراكة مع الهيئة المستقلة للانتخاب وبالتعاون مع برنامج أنا أشارك مركز دراسات المرأة في الأردنية يعقد ندوة حوارية بعنوان انعكاس التعديلات الدستورية على مشاركة الشابات في العملية الانتخابية والحزبية",
    //   content:
    //       "The Center for Women's Studies at the University of Jordan held a symposium entitled \"The Reflection of the Constitutional Amendments on the Participation of Young Women in the Electoral and Party Process\", in partnership with the Independent Electoral Commission, and in cooperation with the I Participate Program launched by the Crown Prince Foundation in Jordanian universities.\n\n"
    //       "The Director of the Center, Dr. Magda Omar, indicated that the participation of young women today in the electoral and party process is a continuation of the participation of Jordanian women in political and public life in the first centenary of the establishment of the Jordanian state, pointing out that Jordanian women are still looking forward to increasing their active participation in various fields, which contributes to In building a civil state, a society of efficiency and justice between the sexes, and achieving the desired sustainable development.\n\n"
    //       "And she emphasized that the holding of this symposium, at the University of Jordan, indicates our tireless work so that our university becomes a radiant beacon dedicated to building the human being. culture, behavior and knowledge, which enables it to play a pivotal role in any societal renaissance that we hope to achieve.\n\n"
    //       "In addition, Omar welcomed the participants in this symposium, especially the member of the Board of Commissioners of the Independent Election Commission, Dr. Abeer Dababneh, the assistant to the President of the University of Jordan for Legal Affairs, Dr. Hadeel Al-Zoubi, the head of mission at the Australian Embassy, Representative Jules McGregor, the student at the Faculty of Law and the Age of East, and the audience Students interested in the dialogue seminar.\n\n"
    //       "For her part, Dababneh stressed the importance of the role of women in public life and political life, and her role in change, development and development events, noting that the recent political amendments guaranteed the right of young people to participate through developments in legislation related to political work, and legal guarantees to protect party affiliates.\n\n"
    //       "Dababneh indicated that the Commission established the Women's Empowerment Unit with the aim of empowering, supporting and encouraging them to engage in parties and political work, stressing that this will only be achieved through joint collective action, in light of legislation and a political environment that achieves the vision of the Jordanian state.\n\n"
    //       "In her turn, Al-Zoubi said that the recent constitutional amendments formed a way of life, enabled women to play an active role, and ensured their participation in the decision-making process without restrictions, and their exercise of political life in general and parties in particular.She added that the election and party laws opened the way for women to truly participate in the elections by voting and running, and that this will reflect positively on the reform process in all aspects.\n\n"
    //       "Al-Rishq also delivered a speech in which she said that what is relied upon, in a period full of challenges, is the awareness of youth, pointing to the importance of providing them with the knowledge and skills necessary for political and partisan work in an effective and constructive manner to produce the desired results.",
    //   contentAR:
    //       "عقد مركز دراسات المرأة في الجامعة الأردنيّة ندوة حوارية بعنوان انعكاس التعديلات الدستورية على مشاركة الشابات في العملية الانتخابية والحزبية، بالشراكة مع الهيئة المستقلة للانتخاب، وبالتعاون مع برنامج أنا أشارك الذي أطلقته مؤسسة ولي العهد في الجامعات الأدرنيّة."
    //       "وأشارت مديرة المركز الدكتورة ماجدة عمر إلى أن مشاركة الشابات اليوم في العملية الانتخابية والحزبية تأتي استمرارًا لمشاركة المرأة الأردنية في الحياة السياسية والعامة في المئوية الأولى من تأسيس الدولة الأردنيّة، لافتةً إلى أنّ المرأة الأردنيّة لا تزال تتطلع إلى زيادة المشاركة الفاعلة في مختلف الميادين، بما يسهم في بناء الدولة المدنية، ومجتمع الكفاءة والعدالة بين الجنسيْن، وتحقيق التنمية المستدامة المنشودة."
    //       "وأكّدت أنّ انعقاد هذه الندوة، في الجامعة الأردنية، يؤشّر إلى عملنا الدؤوب كي تكون جامعتنا منارة مشعة تعكف على بناء الإنسان؛ ثقافةً وسلوكًا وعلمًا، ما يخوّلها من النهوض بدور محوريّ في أيّ نهضة مجتمعيّة نأمل في تحقيقها."
    //       "إلى جانب ذلك، رحبت عمر بالمشاركين والمشاركات في هذه الندوة، مخصّصةً عضوة مجلس مفوضي الهيئة المستقلة للانتخاب الدكتورة عبير دبابنة ومساعدة رئيس الجامعة الأردنية للشؤون القانونية الدكتورة هديل الزعبي، ورئيس البعثة في السفارة الأسترالية النائب جول ماك غريغور، والطالبة في كلية الحقوق وسن الرشق، وجمهور الطلبة المهتمين بالندوة الحوارية."
    //       "من جانبها، أكدت دبابنة على أهمية دور المرأة في الحياة العامة والحياة السياسية، ودورها في التغيير والتطوير واحداث التنمية، مشيرة إلى أن التعديلات السياسية الأخيرة ضمنت حق الشباب في المشاركة من خلال التطورات الحادِثة على التشريعات المتعلقة بالعمل السياسي، والضمانات القانونية لحماية المنتسبين للأحزاب."
    //       "وبينت دبابنة أن الهيئة أنشأت وحدة تمكين المرأة بهدف تمكينها ودعمها وتشجيعها على الانخراط في الأحزاب والعمل السياسي، مؤكدة أن ذلك لن يتحقق إلا من خلال عمل جماعي مشترك، في ظل تشريعات وبيئة سياسية تحقق رؤية الدولة الأردنية."
    //       "بدورها، قالت الزعبي إنّ التعديلات الدستورية الأخيرة شكلت نهجَ حياة، ومكنت المرأة من لعب دور فاعل، وضمنت مشاركتها في عملية صنع القرار دون قيود، وممارستها للحياة السياسية بشكل عام والأحزاب بشكل خاص.وأضافت أن قانوني الانتخاب والأحزاب فتحا المجال أمام المرأة للمشاركة الحقيقية في الانتخابات اقتراعًا وترشُّحًا، وأنّ ذلك سينعكس إيجابًا على مسيرة الإصلاح في جميع النواحي."
    //       "كما ألقت الرشق كلمة قالت فيها إنّ ما يُعوّل عليه، في فترة تعجّ بالتحديات، هو وعي الشباب، مشيرةً إلى أهميّة تزويدهم بالمعارف والمهارات اللازمة بالعمل السياسي والحزبي بشكل فاعل وبنّاء للخروج بالنتائج المرجُوّة.",
    //   urlImage: "assets/images/Women.jpg",
    //   collegeName: "School of Law",
    //   id: 46,
    //   audioFileEN: "assets/audio/46en.mp3",
    //   audioFileAR: "assets/audio/461ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Visit the headquarters of the International Committee of the Red Cross",
    //   titleAR: "زيارة المقر اللجنة الدولية للصليب الأحمر",
    //   content:
    //       "Students of the Faculty of Law visited the headquarters of the International Committee of the Red Cross in order to learn more about the role of the International Committee in the development and development of international humanitarian law.\n\n"
    //       "This visit comes within the framework of the college's efforts to link the theoretical aspect of international humanitarian law with the practical aspects of this subject",
    //   contentAR:
    //       "قام طلبة كلية الحقوق بزيارة مقر اللجنة الدولية للصليب الأحمر  وذلك  للتعرف أكثر على دور اللجنة الدولية في تطوير وإنماء القانون الدولي الإنساني ."
    //       "وتأتي هذه الزيارة  ضمن  إطار جهود الكلية  لربط الجانب النظري لمادة القانون الدولي الإنساني مع الجوانب التطبيقية العملية لهذه المادة",
    //   urlImage: "assets/images/Cross.jpg",
    //   collegeName: "School of Law",
    //   id: 47,
    //   audioFileEN: "assets/audio/47en.mp3",
    //   audioFileAR: "assets/audio/471ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "Forum Faculty of Educational Sciences",
    //   titleAR: "منتدى كلية العلوم التربوية",
    //   content:
    //       "Today, the Faculty of Educational Sciences at the University of Jordan held its scientific forum, “Future Prospects for Education in Jordan”, under the auspices of the Chairman of the University’s Board of Trustees, Dr. Adnan Badran, and in the presence of its President, Dr. Nazir Obeidat, a number of vice-presidents, the Dean of the Faculty, Dr. Muhammad Al-Zyoud, as well as the deans of a number of faculties, guests, educators, and members From the teaching and administrative staff and a group of students.\n\n"
    //       "Badran said, in a speech he gave entitled \"Prospects of Jordanian Education in a Changing World\", that we must start intelligently to build the knowledge and digital economy, so that the outputs of the educational system are transformed from groups seeking employment into pioneering outputs that create jobs and occupy others, pointing to the necessity of building smart human capital The rich, through the development of curricula and the development of thinking and creativity skills, through attractive smart schools that are open to cognitive skills, aiming to develop investigation, analysis and problem-solving.\n\n"
    //       "Badran added that the school and the university constitute rich incubators for transforming the outputs of thought and scientific research into creativity and innovation, led by pioneers who enjoy critical thinking from early childhood, employing it through informed curricula and methods of teaching, evaluation and evaluation using modern technologies, developing children's behaviors, trends and ethics in an attractive, integrated and comprehensive study environment. Through dialogue and playing with friends and electronic games aimed at developing intelligence and cognitive skills, as well as practical application.\n\n"
    //       "For his part, Obeidat referred to the subject of flipped learning, which is represented by an educational technique through which students discover how to learn on their own and gain experience in solving difficult problems in a way that enhances cooperation. They also gain their first contact with new materials through organized self-teaching, and later use reclaimed classroom time. For active learning experiences, pointing here to the challenges related to this type of education and the need to solve them.\n\n"
    //       "In a paper he presented entitled \"The University of Jordan: A Future View,\" Obeidat referred to the skills of the twenty-first century, which are represented by cooperation, creativity, critical thinking, and the call to overturn the academic curricula. In the past, stressing that there is no harm in using formative assessment instead of high-stakes exams, referring in this regard to the developments that govern university education in the future and the features of change in its nature.\n\n"
    //       "In turn, Al-Zyoud explained in his paper \"Contemporary Global Trends in Education\" that the college has worked to embody new trends in its programs, study materials, activities and events that are manifested in trends that have become an integral part of the march of universities and education systems at the global level, noting that it is the responsibility of the college to prepare A person endowed with virtues and values, who is well versed in science and knowledge, and skilled in personal skills and specialized, digital, and practical competencies.",
    //   contentAR:
    //       "عقدت كلية العلوم التربوية في الجامعة الأردنية اليوم منتداها العلمي الآفاق المستقبلية للتعليم في الأردن، برعاية رئيس مجلس أمناء الجامعة الدكتور عدنان بدران وحضور رئيسها الدكتور نذير عبيدات وعدد من نواب الرئيس وعميد الكلية الدكتور محمد الزيود، إلى جانب عمداء عدد من الكليات والضيوف والتربويين وأعضاء من الهيئتين التدريسية والإدارية وجمع من الطلبة."
    //       "وقال بدران، في كلمة قدمها بعنوان آفاق التعليم الأردني في عالم متغير، إن علينا الانطلاق بذكاء لبناء الاقتصاد المعرفي والرقمي، بحيث تتحول مخرجات المنظومة التعليمية من جماعات تطلب التوظيف إلى مخرجات ريادية تصنع الوظائف وتشغل الآخرين، لافتًا إلى وجوب بناء رأس المال البشري الذكي الثري، من خلال تطوير المناهج وتنمية مهارات التفكير والإبداع، عبر المدارس الذكية الجاذبة المنفتحة على المهارات المعرفية تهدف إلى تنمية الاستقصاء والتحليل وحل المشكلات."
    //       "وأضاف بدران أن المدرسة والجامعة تشكلان حاضنات ثرية لتحويل مخرجات الفكر والبحث العلمي إلى إبداع وابتكار، يقودها رياديون يتمتعون بفكر ناقد منذ الطفولة المبكرة، يوظفونه من خلال مناهج وطرائق تدريس وتقييم وتقويم مستنيرة باستخدام التقنيات الحديثة، منمّين سلوكيات الطفل واتجاهاته وأخلاقياته في بيئة دراسية جاذبة متكاملة وشاملة عن طريق الحوار واللعب مع الرفاق والألعاب الإلكترونية الهادفة إلى تنمية الذكاء والمهارات المعرفية، إلى جانب التطبيق العملي."
    //       "من جهته، نوه عبيدات إلى موضوع التعليم المقلوب والمتمثل بتقنية تربوية يكتشف الطلاب من خلالها كيفية التعلم بمفردهم واكتساب الخبرة في حل المشاكل الصعبة بطريقة تعزز التعاون، كما يكتسبون فيها أول اتصال لهم بمواد جديدة من خلال التدريس الذاتي المنظم، ليعمدوا لاحقًا إلى استخدام وقت الفصل المستصلح لتجارب التعلم النشط، لافتًا هنا إلى التحديات المتعلقة بهذا النوع من التعليم وضرورة حلها."
    //       "وأشار عبيدات في ورقة قدمها بعنوان الجامعة الأردنية: نظرة مستقبلية إلى مهارات القرن الحادي والعشرين التي تتمثل بالتعاون والإبداع والتفكير النقدي والدعوة إلى قلب المناهج الدراسية، معرّجًا في حديثه على الواقع الافتراضي المعزز الذي سيكون شكل التعليم العالي فيه أكثر فرديةً وتركيزًا على الطالب مما كان عليه في الماضي، مؤكدًا أنه لا ضير مستقبلا من استخدام التقييم التكويني عوضًا عن الامتحانات عالية المخاطر، ومشيرًا في هذا الصدد إلى المستجدات التي تحكم التعليم الجامعي في المستقبل وملامح التغيير في طبيعته."
    //       "بدوره، أوضح الزيود في ورقته الاتجاهات العالمية المعاصرة في التربية والتعليم أن الكلية عملت على تجسيد اتجاهات جديدة في برامجها وموادها الدراسية ونشاطاتها وفعالياتها تتجلى باتجاهات أصبحت جزءًا لا يتجزأ من مسيرة الجامعات وأنظمة التعليم على المستوى العالمي، منوها بأنه يقع على عاتق الكلية أن تعد الإنسان المتحلي بالفضائل والقيم والمتمكن من ناصية العلم والمعرفة والحاذق في المهارات الشخصية والكفايات التخصصية والرقمية والعملية.",
    //   urlImage: "assets/images/Forum.jpg",
    //   collegeName: "School of Educational Sciences",
    //   id: 48,
    //   audioFileEN: "assets/audio/48en.mp3",
    //   audioFileAR: "assets/audio/481ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Forum of the Faculty of Educational Sciences: Teacher preparation programs and Jordanian curricula are implemented in accordance with best practices and prestigious international experiences, with full consideration for the privacy of society",
    //   titleAR:
    //       "منتدى كلية العلوم التربوية: برامج إعداد المعلمين والمناهج الأردنية يتم تنفيذها وفق أفضل الممارسات والتجارب العالمية المرموقة والمراعاة التامة لخصوصية المجتمع",
    //   content:
    //       "Within the activities of the Faculty of Educational Sciences Forum at UJ, which was held under the auspices of the State of Prof. Dr. Adnan Badran, and was attended and participated in its sessions by Prof. Dr. Nazir Obeidat, President of the University of Jordan, Mrs. Rola Saeed, Director of Academic Programs at Queen Rania Academy for Teacher Preparation, indicated during her participation in the forum that the programs The preparation of teachers provided by the Academy relies on the best practices and prestigious international experiences in teacher preparation programs in developed countries, in a manner commensurate with the nature of the Jordanian educational system.\n\n"
    //       "Mrs. Rola presented the most prominent milestones in the march of the Queen Raina Academy for teacher preparation, which began in 2009 in terms of the nature of the programs offered by the academy and the activities and events it holds to serve the Jordanian educational system, whose impact extends to countries in the region and the world through educational resources that are available for free and have educational and professional value. For teachers and workers in the educational field.\n\n"
    //       "Saeed added that the academy offers training and qualification programs for teachers and workers in the educational field with actual scientific simulation of the best international experiences, relying on the best competencies and experts. The academy offers a professional diploma in education and a professional diploma in advanced educational leadership. In general, and teachers in particular. These courses are based on the Academy’s programs in the professional development of teachers and educational leaders in the fields of basic and general detective pedagogy, psychosocial support, innovation, entrepreneurship, and other educational fields. These courses were developed based on the social responsibility of the Academy and its belief in the importance of continuous professional development for teachers. And educators by making these courses available to everyone in a way that suits the learners' time and effort.\n\n"
    //       "Saeed added that the Queen Raina Academy for Teacher Preparation offers professional development programs for in-service teachers, whose focus includes the Arabic language program, the English language program, the mathematics program, the science program, the social studies program, and general teaching methods that cover the classroom management axis, the axis of interactive teaching strategies, and the axis of differentiated teaching. Education technology axis, psychosocial culture and supportive communication axis, and teaching planning axis.\n\n"
    //       "Dr. Sherine Hamed, Executive Director of the National Curriculum Center, participated in the forum, and indicated that the center was established in 2017 in response to the recommendations of the National Strategy for Human Resources Development 2016-2025 with the aim of educational reform and the development of curricula and textbooks for early childhood, basic and secondary education, in line with the Jordanian education philosophy. And its goals, and religious and national constants, and is consistent with the best international best practices.\n\n"
    //       "Hamed added that the Jordanian curricula that have been and are being developed are based on best practices and prestigious international experiences, in a way that is commensurate with the privacy and nature of Jordanian society, in a way that preserves and takes into account our national and religious constants.",
    //   contentAR:
    //       "ضمن فعاليات منتدى كلية العلوم التربوية في الأردنية الذي عقد برعاية دولة الأستاذ الدكتور عدنان بدران وحضره وشارك في جلساته الأستاذ الدكتور نذير عبيدات رئيس الجامعة الأردنية، أشارت السيدة رولا سعيد مدير البرامج الأكاديمية في أكاديمية الملكة رانيا لإعداد المعلمين خلال مشاركتها في المنتدى إلى أن برامج إعداد المعلمين التي قدمتها وتقدمها الأكاديمية تعتمد على أفضل الممارسات والتجارب العالمية المرموقة في برامج إعداد المعلمين في الدول المتقدمة وبما يتناسب وطبيعة النظام التربوية الأردني."
    //       "وعرضت السيدة رولا أبرز المحطات البارزة في مسيرة أكاديمية الملكة رأينا لإعداد المعلمين والتي بدأت في العام 2009 من حيث طبيعة البرامج التي تقدمها الأكاديمية والنشاطات والفعاليات التي تعقدها خدمة للنظام التربوي الأردني والتي يمتد أثرها ليشمل دول المنطقة والعالم من خلال مصادر تعليمية متاحة مجانا وذات قيمة تربوية ومهنية للمعلمين وللعاملين في الميدان التربوي."
    //       "وأضافت سعيد إلى أن الأكاديمية تقدم برامج تدريبية وتأهيلية للمعلمين وللعاملين في الميدان التربوي بمحاكاة فعلية علمية لأفضل التجارب العالمية بالاعتماد على خيرة الكفاءات والخبراء، حيث تقدم الأكاديمية الدبلوم المهني في التعليم والدبلوم المهني في القيادة التعليمية المتقدمة وتقدم مساقات إلكترونية تعليمية متخصصة مجانية تهدف إلى تلبية احتياجات التربويين بشكل عام والمعلمين بشكل خاص وتستند هذه المساقات إلى برامج الأكاديمية في التنمية المهنية للمعلمين والقيادات التربوية في مجالات بيداغوجيا المباحث الأساسية والعامة والدعم النفس اجتماعي والابتكار وريادة الأعمال وغيرها من المجالات التعليمية والتربوية وتم تطوير هذه المساقات انطلاقا من المسؤولية الاجتماعية للأكاديمية وإيمانا منها بأهمية التطوير المهني المستمر للمعلمين والتربويين من خلال إتاحة هذه المساقات للجميع بما يلائم وقت المتعلمين وجهدهم."
    //       "وأضافت سعيد إلى أن أكاديمية الملكة رأينا لإعداد المعلمين تقدم برامج التنمية المهنية للمعلمين أثناء الخدمة والتي من ضمن تركيزاتها برنامج اللغة العربية وبرنامج اللغة الإنجليزية وبرنامج الرياضيات وبرنامج العلوم وبرنامج الدراسات الاجتماعية وطرق التدريس العامة التي تغطي محور الإدارة الصفية، ومحور استراتيجيات التدريس التفاعلية، ومحور التدريس المتمايز، ومحور تكنولوجيا التعليم، ومحور الثقافة النفس- اجتماعية والتواصل الداعم، ومحور التخطيط للتدريس."
    //       "وشاركت الدكتورة شيرين حامد المديرة التنفيذية للمركز الوطني للمناهج في أعمال المنتدى، وأشارت إلى أن المركز تأسس في 2017 استجابة لتوصيات الاستراتيجية الوطنية لتنمية الموارد البشرية 2016 – 2025 بهدف الإصلاح التربوي وتطوير المناهج والكتب المدرسية لمراحل الطفولة المبكرة والتعليم الأساسي والثانوي وبما ينسجم مع فلسفة التربية والتعليم الأردنية وأهدافها، والثوابت الدينية والوطنية، وينسجم مع أفضل الممارسات العالمية الفضلى."
    //       "وأضافت حامد إن المناهج الأردنية التي تم ويتم العمل على تطويرها تعتمد على أفضل الممارسات والتجارب العالمية المرموقة وبما يتناسب وخصوصية وطبيعة المجتمع الأردني وبما يحفظ ويراعي ثوابتنا الوطنية والدينية.",
    //   urlImage: "assets/images/society.jpg",
    //   collegeName: "School of Educational Sciences",
    //   id: 49,
    //   audioFileEN: "assets/audio/49en.mp3",
    //   audioFileAR: "assets/audio/491ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A panel discussion in the College of Educational Sciences on the importance of the Arabic language and the future skills of the Arabic language teacher for non-native speakers",
    //   titleAR:
    //       "ندوة حوارية في كلية العلوم التربوية حول أهمية اللغة العربية والمهارات المستقبلية لمعلم اللغة العربية للناطقين بغيرها",
    //   content:
    //       "The College of Educational Sciences organized a symposium on the importance of the Arabic language and the future skills of the Arabic language teacher for non-native speakers, presented by Prof. Dr. Abdul Rahman Al-Hashemi, in light of his participation in the international conference on developing curricula and teaching methods that was held in the Kingdom of Saudi Arabia.\n\n"
    //       "In his lecture, Dr. Al-Hashemi touched on the importance of the future and building generations, the importance of the Arabic language as an eternal language, and the future skills of the Arabic language teacher for non-native speakers.\n"
    //       "The lecturer presented a picture of the number of participants in the Jeddah conference, the research that was presented in it, and the book of the conference and its recommendations. The symposium included answering many questions posed by the faculty members and students.\n"
    //       "The symposium was attended by the Vice Deans of the Faculty of Educational Sciences, Prof. Dr. Abdel-Karim Al-Haddad, Prof. Dr. Ramzi Haroun, Prof. Sanaria Jabbar, and postgraduate students in the Faculty of Educational Sciences.",
    //   contentAR:
    //       "نظمت كلية العلوم التربوية ندوة حوارية حول أهمية اللغة العربية والمهارات المستقبلية لمعلم اللغة العربية للناطقين بغيرها قدمها الأستاذ الدكتور عبد الرحمن الهاشمي في ضوء مشاركته في مؤتمر تطوير المناهج وطرائق التدريس الدولي الذي عقد في المملكة العربية السعودية."
    //       "وقد تطرق الدكتور الهاشمي في محاضرته إلى أهمية المستقبل وبناء الأجيال، وأهمية اللغة العربية بوصفها لغة خالدة، والمهارات المستقبلية لمعلم اللغة العربية للناطقين بغيرها."
    //       "وقدم الدكتور المحاضر صورة عن عدد المشاركين في مؤتمر جدة، والبحوث التي ألقيت فيه، وكتاب المؤتمر وتوصياته. وتضمنت الندوة الإجابة عن العديد من الأسئلة التي طرحها الحضور من أعضاء هيئة التدريس والطلبة."
    //       "وحضر الندوة نواب عميد كلية العلوم التربوية الأستاذ الدكتور عبد الكريم الحداد والأستاذ الدكتور رمزي هارون والأستاذ الدكتورة سناريا جبار، وطلبة الدراسات العليا في كلية العلوم التربوية.",
    //   urlImage: "assets/images/panel.jpg",
    //   collegeName: "School of Educational Sciences",
    //   id: 50,
    //   audioFileEN: "assets/audio/50en.mp3",
    //   audioFileAR: "assets/audio/501ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Honoring Dr. Omar Al-Aourani from the Faculty of Educational Sciences",
    //   titleAR: "تكريم الدكتور عمر العوراني من كلية العلوم التربوية",
    //   content:
    //       "The administration of the first university schools honored Dr. Omar Al-Awrani from the Counseling and Special Education Department in the College of Educational Sciences for his role in supporting the school’s progress through a lecture he gave to secondary school students in the school. It dealt with effective study skills in terms of the concept of study skills and their obstacles, in addition to effective study strategies and applications used.",
    //   contentAR:
    //       "كرمت ادارة مدارس الجامعة الاولى الدكتور عمر العوراني من قسم الارشاد والتربية الخاصة في كلية العلوم التربوية وذلك لدوره في دعم مسيرة المدرسة من خلال المحاضرة التي قدمها لطلبة المرحلة الثانوية في المدرسة وتناولت المهارات الدراسية الفاعلة من حيث مفهوم المهارات الدراسية ومعيقاتها اضافة الى استراتيجيات الدراسة الفاعلة والتطبيقات المستخدمة.",
    //   urlImage: "assets/images/Omar.jpg",
    //   collegeName: "School of Educational Sciences",
    //   id: 51,
    //   audioFileEN: "assets/audio/51en.mp3",
    //   audioFileAR: "assets/audio/511ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The College of Sharia in the \"UJ\" launches the electronic Quran reciter initiative",
    //   titleAR:
    //       "كلية الشريعة في الأردنية تطلق مبادرة مقرأة القرآن الكريم الإلكترونية",
    //   content:
    //       "Under the auspices of the Vice President of the University of Jordan for Humanitarian Faculties Affairs, Dr. Salama Al-Naimat, the Faculty of Sharia launched today the \"Electronic Quran Recitation\" initiative, in the presence of the Deputy Dean of the Faculty, Dr. Jihad Nuseirat, and a number of members of the teaching and administrative staff and students in the faculty.\n\n"
    //       "Al-Naimat stressed the importance of this initiative concerned with perfecting the recitation of the Holy Qur’an, and the various Qur’anic readings, through direct electronic reading between the reader and the reciter, hoping that it would receive its share of attention and work on developing it in the future.\n\n"
    //       "Nusseirat delivered a welcome speech during the launch ceremony, in which he noted that this initiative is the first of its kind at the level of Jordanian universities, and that Al Maqraa is concerned with teaching, reciting and memorizing the Holy Quran electronically through various electronic means.\n\n"
    //       "For his part, the coordinator of the initiative, Dr. Amjad Saadeh, spoke about the subject of the initiative, introducing Maqraa, its objectives, and the beneficiaries, at the local and international levels.\n\n"
    //       "During the ceremony, applied models of recitation were presented with local participation from the university and the local community, in addition to the international participation of one of the students.",
    //   contentAR:
    //       "تحت رعاية نائب رئيس الجامعة الأردنية لشؤون الكليات الإنسانية الدكتور سلامة النعيمات، أطلقت كلية الشريعة اليوم مبادرة مقرأة القرآن الكريم الإلكترونية، وذلك بحضور نائب عميد الكلية الدكتور جهاد نصيرات وعدد من أعضاء الهيئتين التدريسية والإدارية والطلبة في الكلية."
    //       "وأكد النعيمات على أهمية هذه المبادرة المعنيّة بإتقان تلاوة القرآن الكريم، والقراءات القرآنية المختلفة، عن طريق القراءة الإلكترونية المباشرة بين القارئ والمقرئ، متمنيًا أن تأخذ نصيبها من الاهتمام وأن يُعمل على تطويرها مستقبلا."
    //       "وقدّم نصيرات كلمة ترحيبية خلال حفل الإطلاق، نوّه فيها إلى أن هذه المبادرة الأولى من نوعها على مستوى الجامعات الأردنية، وأنّ المقرأة تُعنى بتعليم القرآن الكريم وتلاوته وتحفيظه إلكترونيًا من خلال الوسائل الإلكترونية المتعددة."
    //       "من جهته، تحدث منسق المبادرة الدكتور أمجد سعادة حول موضوع المبادرة، معرّفًا بالمقرأة وأهدافها والفئات المستفيدة منها على الصعيدين المحلي والدولي."
    //       "كما عُرضت خلال الحفل نماذج تطبيقية للمقرأة بمشاركة محلية من الجامعة والمجتمع المحلي، إلى جانب وجود مشاركة دولية اضطلع بها أحد الطلبة.",
    //   urlImage: "assets/images/Quran.jpg",
    //   collegeName: "School of Sharia",
    //   id: 52,
    //   audioFileEN: "assets/audio/52en.mp3",
    //   audioFileAR: "assets/audio/521ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Obituary student",
    //   titleAR: "نعي طالب علم",
    //   content:
    //       "The Dean of the College of Sharia and members of the teaching and administrative staff mourns the student Abd al-Latif Abd al-Rahman al-Da’i/ a master’s degree student at the College of Sharia/ Department of Jurisprudence and its Fundamentals, and as we count on him with God Almighty, we ask Him, may He be glorified, to have a wide mercy on him, and to replace him with a better home than his home, and to make His grave is a garden from the gardens of Paradise, and to make him in the company of the prophets, the truthful ones, the martyrs, the righteous, and the good of those as a companion.",
    //   contentAR:
    //       "ينعى عميد كلية الشريعة وأعضاء الهيئة التدريسية والإدارية فيها الطالب عبداللطيف عبد الرحمن الدعي/ من طلبة مرحلة الماجستير في كلية الشريعة/ قسم الفقه وأصوله، وإننا إذ نحتسبه عند الله تعالى لنسأله سبحانه أن يرحمه رحمة واسعة، وأن يبدله داراً خيراً من داره، وأن يجعل قبره روضة من رياض الجنة، وأن يجعله في رفقة النبيين والصديقين والشهداء والصالحين وحسن أولئك رفيقا.",
    //   urlImage: "assets/images/student.jpg",
    //   collegeName: "School of Sharia",
    //   id: 53,
    //   audioFileEN: "assets/audio/53en.mp3",
    //   audioFileAR: "assets/audio/531ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "Jordanian Business organizes a scientific visit for its students to the Hikma Pharmaceutical Factory",
    //   titleAR: "اعمال الأردنية تنظم زيارة علمية لطلبتها الى مصنع أدوية الحكمة",
    //   content:
    //       "Students of the Department of Production and Operations Management at the College of Business / University of Jordan participated in a scientific visit to the Hikma Pharmaceutical Factory on Thursday, May 18, 2023, organized by the subject’s teacher, Dr. Rima Waheed Al-Hassan.\n\n"
    //       "Al-Hamka Pharmaceutical Company is one of the leading companies in the field of pharmaceutical manufacturing, as it was established more than 45 years ago in Jordan and works to develop, manufacture and market a wide range of products in the Middle East, North Africa, Europe and all over the United States of America. It has more than 32 factories, 8 research and development centers, and 8,800 employees around the world.\n\n"
    //       "The aim of the visit was to introduce the students to how to manage operations and quality control in the pharmaceutical industries. It included a tour of the Hikma Pharmaceutical Factory, starting from the stage of manufacturing active pharmaceutical ingredients for pharmaceutical chemicals, passing through the processes of manufacturing pharmaceutical pills and capsules, and ending with the stage of drug packaging and storage. The visit also included a discussion on how to ensure the quality of medicine, in addition to the practices used to take into account the treatment requirements and patients' needs. It was also known how to determine the effective production capacity of pharmaceutical manufacturing equipment to ensure the maintenance of product quality, production speed, and the safety of patients and workers, in addition to keeping the products within reach of the individuals who need them.\n\n"
    //       "In turn, the Dean of the College of Business, Prof. Dr. Raed Mosaada Bani Yassin, emphasized the need to organize scientific visits to various institutions and companies to see the practical reality and to keep up with the requirements of the labor market and to introduce students to the reality of practical practices in various business specializations.\n\n"
    //       "The subject teacher and Assistant Dean for Quality Assurance Affairs, Dr. Rima Waheed Al-Hassan, also indicated that the visit is very useful for students from the scientific and practical aspects. As the field of operations and production management is linked to the practical and applied reality, especially since many theories and best practices in the field of theoretical specialization emerged from the business world. Therefore, linking the theoretical content of the subject to the practical one enhances the students' learning experience and enriches their knowledge in the various fields of knowledge.\n\n"
    //       "The Assistant Dean for Student Affairs, Dr. Noura Musa Al-Lawzi, stressed the importance of continuing the college's approach by holding targeted extracurricular activities for college students, and the active participation of students in various activities in the business world to enhance their chances of joining the labor market after graduation.\n\n"
    //       "The visit concluded with an agreement to continue communication between the Faculty of Business at the University of Jordan and the Hikma Pharmaceutical Company, and to provide opportunities for cooperation in research and training fields for students. All thanks and appreciation to Hikma Pharmaceutical Company for hosting and for their continuous cooperation.",
    //   contentAR:
    //       "شارك طلبة مادة ادارة الانتاج و العمليات في  كلية الاعمال  \ الجامعة الاردنية في زيارة علمية الى مصنع أدوية الحكمة يوم الخميس الموفق 18 ايار 2023 و ذلك بتنظيم من مدرسة المادة الدكتورة ريما وحيد الحسن."
    //       "تعد شركة أدوية الحمكة من الشركات الرائدة في مجال التصنيع الدوائي, حيث  تأسست منذ اكثر من 45 عام في الأردن و تعمل على تطوير و تصنيع و تسويق مجموعة واسعة من المنتجات في الشرق الاوسط و شمال افريقيا و اوروبا و جميع انحاء الولايات المتحدة الامريكية. حيث لديها اكثر من 32 مصنعا و 8 مراكز بحث و تطوير و 8800 موظفا حول العالم."
    //       "هدفت الزيارة على تعريف الطلبة على كيفية ادارة العمليات و ضبط الجودة في الصناعات الدوائية. حيث شملت على جولة في مصنع أدوية الحكمة ابتداء من مرحلة تصنيع المكونات الصيدلانية الفعالة للمواد الكميائية الدوائية مرورا بعمليات تصنيع الحبوب الدوائية و الكبسولات و انتهاء بمرحلة التغليف و التخزين الدوائي. كما تضمنت الزيارة نقاش حول كيفية ضمان جودة الدواء بالاضافة الى الممارسات المستخدمة لمراعاة متطلبات العلاج و حاجات المرضى. كما تم التعرف على كيفية تحديد السعة التصنيعية  production capacity الفعالة لمعدات التصنيع الدوائي بما يضمن المحافظة على جودة المنتج وسرعة الانتاج و سلامة المرضى و العاملين بالاضافة الى ابقاء المنتجات في متناول الافراد الذين يحتاجون اليها."
    //       " بدوره أكد عميد كلية الأعمال الأستاذ الدكتور رائد مساعده بني ياسين على ضرورة تنظيم زيارات علمية للمؤسسات و الشركات المختلفة للإطلاع على الواقع العملي ولمواكبة متطلبات سوق العمل و لتعريف الطلبة على واقع الممارسات العملية في تخصصات الاعمال المختلفة."
    //       "كما اشارت مدرسة المادة و مساعد العميد لشؤون ضمان الجودة الدكتورة ريما وحيد الحسن ان الزيارة مفيدة جدا للطلبة من النواحي العلمية و العملية. حيث ان مجال ادارة العمليات و الانتاج مرتبط بالواقع العملي و التطبيقي خصوصا ان العديد من النظريات و الممارسات الفضلى في مجال التخصص النظري انبثقت من عالم الاعمال. لذا ربط محتوى المادة النظري بالعملي يعزز التجربة التعلمية للطلبة و يثري معارفهم في المجالات المعرفية المختلفة."
    //       "اضافت مساعدة عميد الكلية لشؤون الطلبة الدكتورة نوره موسى اللوزي على اهمية استمرار نهج الكلية بعقد الأنشطة اللامنهجية الهادفة لطلبة الكلية، و على مشاركة الطلبة الفاعلة في النشاطات المختلفة في عالم الاعمال لتعزيز فرصهم للالتحاق بسوق العمل بعد التخرج."
    //       "اختتمت الزيارة بالاتفاق على استمرار التواصل بين كلية الاعمال في الجامعة الأردنية و شركة أدوية الحكمة و اتاحة فرص التعاون في المجالات البحثية و التدريبية للطلبة. كل الشكر و التقدير لشركة أدوية الحكمة على الاستضافة و على تعاونهم المستمر.",
    //   urlImage: "assets/images/Hikma.jpg",
    //   collegeName: "School of Business",
    //   id: 54,
    //   audioFileEN: "assets/audio/54en.mp3",
    //   audioFileAR: "assets/audio/541ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The College of Business at UJ organizes a charity campaign entitled \"Winter Clothing\".",
    //   titleAR: "كلية الأعمال في الأردنية تنظم حملة خيرية بعنوان كسوة شتاء.",
    //   content:
    //       "A group of faculty members in the College of Business and a group of student volunteers participated in organizing a charity campaign entitled \"Winter Clothing\". In-kind donations of clothes, shoes, blankets and toys for children were collected and distributed to orphanages, charities and needy families. Bani Yassin emphasized the importance of the role of charitable campaigns in instilling a spirit of compassion and sympathy and increasing charitable works in the college in particular and in the university in general, due to its great role in eradicating poverty by providing assistance to the needy.",
    //   contentAR:
    //       "شارك مجموعة من أعضاء الهيئة التدريسية في كلية الأعمال ومجموعة من الطلبة المتطوعين بتنظيم حملة خيرية بعنوان كسوة شتاء. حيث تم جمع التبرعات العينية من ملابس وأحذية وبطانيات وألعاب للأطفال وتوزيعها على دور الأيتام والجمعيات الخيرية وعلى العائلات المحتاجة.وتعد هذه الحملة حملة خيرية تطوعية غير ربحية هدفها تقديم المساعدات العينية للمحتاجين ومد يد العون للفقراء والحرص على مساعدتهم.بدوره أكد عميد الكلية الأستاذ الدكتور رائد مساعده بني ياسين على أهمية دور الحملات الخيرية في غرس روح التراحم والتعاطف وزيادة الأعمال الخيرية في الكلية بشكل خاص وفي الجامعة بوجه عام لما له دور كبير في القضاء على الفقر من خلال تقديم المساعدات للمحتاجين.",
    //   urlImage: "assets/images/Clothing.jpg",
    //   collegeName: "School of Business",
    //   id: 56,
    //   audioFileEN: "assets/audio/56en.mp3",
    //   audioFileAR: "assets/audio/56ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "UJ's College of Business hosts a delegation from the European Investment Bank Institute (EIB)",
    //   titleAR:
    //       "كلية الأعمال في الأردنية تستضيف وفدًا من معهد البنك الأوروبي للاستثمار (EIB)",
    //   content:
    //       "The Faculty of Business at the University of Jordan hosted a delegation from the European Investment Bank Institute (EIB), in cooperation with the International Program, Alumni and Marketing Unit at the university, as part of a training program on the role of the European Investment Bank in empowering youth through education and capacity building to become leaders of tomorrow who are able to plan and aspire. towards digital transformation.\n\n"
    //       "The program targeted students of the College of Business over two days as part of an intensive training program in which the Bank Institute team, consisting of Flavia Planza, Andre Tenagli and Giuseppe Provenzano, provided students with practical applications on the Bank's business cycle and the financial structure of the European Union related to development, and the Bank's role with the European Union in building programs economic development of developing countries.\n\n"
    //       "In turn, the Dean of the College of Business, Dr. Raed Mosaada Bani Yassin, stressed the importance of hosting this group of experts in their important fields, with the aim of exchanging knowledge and experiences, and enhancing the knowledge and training abilities and skills of students, noting that this type of intensive training programs comes in line with the overall plan Business for development and student empowerment, welcome to more meetings and partnerships with the European Investment Bank Institute (EIB) in all its related programs and courses.\n\n"
    //       "The Director of the International Program, Graduates and Marketing Unit, Dr. Zaid Obeidat, confirmed that these programs are a continuation of the series of intensive training courses held at the University of Jordan with the aim of enhancing students' skills and engaging them in the labor market.\n\n"
    //       "In conclusion, Bani Yassin thanked the trainers for their efforts and sharing of their experiences with the college students, appreciating the role of the International Program, Alumni and Marketing Unit at the University of Jordan in providing these opportunities, hoping that the participants would achieve more progress, success, experiences and knowledge exchange globally with specialists and experts in the field of finance and business. and modern technological applications.",
    //   contentAR:
    //       "استضافت كلية الأعمال في الجامعة الأردنية وفدًا من معهد البنك الأوروبي للاستثمار (EIB)، وذلك بالتعاون مع وحدة البرنامج الدولي والخريجين والتسويق في الجامعة، ضمن برنامج تدريبي عن دور البنك الأوروبي للاستثمار في تمكين الشباب من خلال التعليم وبناء القدرات ليصبحوا قادة للغد قادرين على التخطيط والطموح نحو التحول الرقمي."
    //       "واستهدف البرنامج طلبة كلية الأعمال على مدار يومين ضمن برنامج تدريبي مكثف قام فيه فريق معهد البنك، المكوّن من فلافيا بلانزا وأندريه تيناجلي وجوسيبي بروفنزانو، بتزويد الطلبة بتطبيقات عملية عن دورة أعمال البنك والهيكل المالي للاتحاد الأوروبي المرتبط بالتنمية، ودور البنك مع الاتحاد الأوروبي في بناء برامج التنمية الاقتصادية للدول النامية."
    //       "بدوره، أكّد عميد كلية الأعمال، الدكتور رائد مساعدة بني ياسين، أهمية استضافة هذه الكوكبة من الخبراء في مجالاتهم المهمة، بهدف تبادل المعرفة والخبرات، وتعزيز القدرات والمهارات المعرفية والتدريبية لدى الطلبة، مشيرًا إلى أن هذه النوعية من البرامج التدريبية المكثّفة تأتي انسجامًا مع خطة كلية الأعمال للتطوير وتمكين الطلبة، مرحّبًا بمزيد من اللقاءات والشراكات مع معهد البنك الأوروبي للاستثمار (EIB) في جميع برامجه ودوراته ذات الصلة."
    //       "وأكد مدير وحدة البرنامج الدولي والخريجين والتسويق الدكتور زيد عبيدات أن هذه البرامج تأتي استكمالًا لسلسلة الدورات التدريبية المكثفة المُنعقدة في الجامعة الأردنية بهدف تعزيز مهارات الطلبة وإخراطهم في سوق العمل."
    //       "وفي الختام، شكر بني ياسين المدربين على جهودهم ومشاركتهم لخبراتهم مع طلبة الكلية، مثمّنًا دور وحدة البرنامج الدولي والخريجين والتسويق في الجامعة الأردنية في توفير هذه الفرص، متمنيًا أن يُحقّق المشاركون مزيدًا من التقدم والنجاح والخبرات والمعارف المُتبادلة عالميًّا مع ذوي الاختصاص والخبرة في مجال المال والأعمال والتطبيقات التكنولوجية الحديثة.",
    //   urlImage: "assets/images/EIB.jpg",
    //   collegeName: "School of Business",
    //   id: 57,
    //   audioFileEN: "assets/audio/57en.mp3",
    //   audioFileAR: "assets/audio/571ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The College of Business at \"UJ\" holds a scientific symposium on small and medium-sized enterprises and their role in the growth of the national economy",
    //   titleAR:
    //       "كلية الأعمال في الأردنية تعقد ندوة علمية حول المشاريع الصغيرة والمتوسطة الحجم ودورها بنمو الاقتصاد الوطني",
    //   content:
    //       "The College of Business organized a scientific symposium on small and medium-sized enterprises and their role in the growth of the national economy.\n\n"
    //       "The Dean of the College of Business, Dr. Raed Mosaada Bani Yassin, stressed the importance of establishing projects in the field of entrepreneurship, technological applications and modern e-business, and the contribution of these projects to sustainable development, reducing unemployment, opening job opportunities and networking with the commercial, industrial and service sectors at the local, regional and international levels.\n\n"
    //       "Entrepreneurship expert Mr. Sari Awad, founder of the Australian Education Center, gave a presentation on the factors of success and failure that must be taken into consideration when establishing entrepreneurial projects.\n\n"
    //       "The presentation included an explanation of the main reasons for the success and failure of many international projects in the first years of their work, how to avoid such difficulties, and how to successfully overcome the first five years to ensure the continuity of the project.\n\n"
    //       "The Assistant Dean for Student Affairs, Dr. Noura Musa Al-Lawzi, stated that the college continues its approach based on holding meaningful extracurricular activities for its students, and urging them to actively participate and communicate continuously to participate in meaningful future seminars. The meeting included interventions from faculty members and answers to students and attendees' inquiries.\n\n"
    //       "At the end of the meeting, the Dean of the College thanked the attendees and those in charge of the meeting, welcoming the role of private sector institutions in empowering students and developing their skills by linking the acquired sciences and life skills with practical life and what the labor market requires, especially in the fields of creativity, leadership, innovation and modern technical developments, in addition to the skills of dialogue, acceptance of the other and thinking. Construction critic.",
    //   contentAR:
    //       "نظّمت كلية الأعمال ندوة علمية حول المشاريع الصغيرة والمتوسطة الحجم ودورها بنمو الاقتصاد الوطني."
    //       "وأكد عميد كلية الأعمال الدكتور رائد مساعده بني ياسين على أهمية انشاء المشاريع في مجال ريادة الأعمال والتطبيقات التكنولوجية والأعمال الإلكترونية الحديثة، ولمساهمة تلك المشاريع بالتنمية المستدامة وبالحد من البطالة وفتح فرص العمل والتشبيك مع القطاعات التجارية والصناعية والخدمية على المستوى المحلي والإقليمي والدولي."
    //       "بدوره قدم خبير الأعمال الريادية السيد ساري عوض، مؤسس المركز الاسترالي التعليمي، عرضاً تقديمياً حول عوامل النجاح والإخفاق التي يجب الأخذ بها عند إنشاء المشاريع الريادية."
    //       "وتخلل التقديم شرح الأسباب الرئيسية لنجاح وفشل العديد من المشاريع العالمية في السنوات الأولى من عملهم وكيفية تجنب مثل تلك الصعوبات وكيفية تجاوز أول خمس  سنوات بنجاح لضمان استمرارية المشروع."
    //       "وبينت مساعدة عميد الكلية لشؤون الطلبة الدكتورة نورة موسى اللوزي أن الكليّة مستمرّة في نهجها القائم على عقد أنشطة لامنهجية هادفة لطلبتها، وحثّهم على المشاركة الفاعلة والتواصل الدائم للمشاركة بالندوات المستقبلية الهادفة. وتخلل اللقاء مداخلات من أعضاء الهيئة التدريسية وإجابة على استفسارات الطلبة والحضور."
    //       "وفي نهاية اللقاء شكر عميد الكلية الحضور والقائمين على اللقاء مرحباً بدور مؤسسات القطاع الخاص في تمكين الطلبة ولتطوير مهاراتهم ومن خلال ربط العلوم المكتسبة والمهارات الحياتية بالحياة العملية وما يتطلبه سوق العمل، وخصوصاً بمجالات الإبداع والريادة والابتكار والتطورات التقنية الحديثة، بالإضافة الى مهارات الحوار وتقبل الآخر والتفكير الناقد البناء.",
    //   urlImage: "assets/images/economy.jpg",
    //   collegeName: "School of Business",
    //   id: 58,
    //   audioFileEN: "assets/audio/58en.mp3",
    //   audioFileAR: "assets/audio/581ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The Faculty of Medicine organizes a voluntary medical day in the town of Karama - Jordan Valley",
    //   titleAR: "كلية الطب تنظم يوما طبيا تطوعيا في بلدة الكرامه - غور الأردن",
    //   content:
    //       "As part of the efforts of the Faculty of Medicine in serving the local community, the Faculty of Medicine at the University of Jordan organized a free medical day in the town of Karama in the Jordan Valley on Thursday, 5-1-2023.\n"
    //       "This volunteer day was held with the joint efforts of the Clinical Training Office and student committees in the college in cooperation with a delegation from Weill Cornell University from the State of Qatar.\n"
    //       "This event was held at Al Karama Health Center, and the team included a group of medical students and doctors from the University of Jordan Hospital.\n"
    //       "The event included diagnosing cases and providing medical advice in various medical specialties (paediatrics, internal medicine, urology, ear, nose and throat surgery, general surgery, and ophthalmology).\n"
    //       "In addition to distributing free medicines and conducting blood sugar and pressure checks for patients.\n"
    //       "The participating students also took part in organizing the activities and presenting gifts to the participating children.\n"
    //       "The reviewers from Al-Karama town expressed their thanks and appreciation to the members of the delegation and to the efforts of the Faculty of Medicine at the University of Jordan in cooperation with the local community.",
    //   contentAR:
    //       "ضمن جهود كلية الطب في خدمة المجتمع المحلي نظمت كلية الطب في الجامعة الأردنية يوما طبيا مجانيا  في بلدة الكرامة في غور الأردن يوم الخميس الموافق 5-1-2023."
    //       "وعقد هذا اليوم التطوعي بجهود مشتركه من  مكتب التدريب السريري  ولجان الطلبة في الكلية  بالتعاون مع وفد من  جامعه وايل كورنيل من دولة قطر."
    //       "عقدت هذه الفعالية في مركز صحي الكرامة وضم الفريق مجموعة من طلبة كلية الطب  و أطباء من  مستشفى الجامعة الأردنية."
    //       "اشتملت الفعالية  على تشخيص الحالات وتقديم المشورة الطبية في مختلف التخصصات الطبية  ( طب الأطفال ،الأمراض الباطنية ، جراحة المسالك ، جراحة الأنف والأذن والحنجرة ، الجراحة العامة ،العيون )."
    //       "إضافة الى توزيع الادوية المجانية  واجراء فحص السكر والضغط للمراجعين."
    //       "كما قام المشاركين من الطلبة بالمشاركة في تنظيم سير الفعاليات وتقديم الهدايا للأطفال المشاركين."
    //       "وقد عبر المراجعين من بلدة الكرامة عن شكرهم وتقديرهم   لأعضاء الوفد  ولجهود كلية الطب في الجامعة الأردنية في التعاون  مع  المجتمع المحلي.",
    //   urlImage: "assets/images/Valley.jpg",
    //   collegeName: "School of Medicine",
    //   id: 59,
    //   audioFileEN: "assets/audio/59en.mp3",
    //   audioFileAR: "assets/audio/591ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Doctor obituary",
    //   titleAR: "نعي طبيب",
    //   content:
    //       "With more sadness and sorrow, and with hearts that believe in God’s will and destiny, Professor Dr. President of the University of Jordan mourns, Professor Dr. Dean of the College of Medicine and members of the teaching and administrative staff in the College of Medicine, who is forgiven, God willing, a graduate of the College of Medicine for the year 2020\n\n"
    //       "Dr. Muhannad Alawneh Who passed away on Tuesday morning 1/12/2020\n"
    //       "We ask the Lord Almighty to cover him with the abundance of his mercy and satisfaction and to enter him into his spacious gardens.\n"
    //       "We belong to Allah and to Him we shall return",
    //   contentAR:
    //       "بمزيــــد مـــن الحـــزن والاسى وبقلوب مؤمنه بقضاء الله وقـــدره"
    //       "ينعـــى الاستاذ الدكتور  رئيس الجامعة الاردنية والاستاذ الدكتور عميد كلية الطب  واعضاء الهيئتين التدريسية والادارية في كلية الطب المغفور له بأذن الله تعالى خريج كلية الطب للعام  2020"
    //       "الدكتور مهند العلاونة"
    //       "والذي وافتة المنية صباح يوم الثلاثاء الموافق 1/12/2020"
    //       "سائلين المولى عز وجل أن يتغمده بواسع رحمته و رضوانه و أن يدخله فسيح جنانه ."
    //       "انــا لله وانــــا اليه راجعــــــون",
    //   urlImage: "assets/images/Doctor.jpeg",
    //   collegeName: "School of Medicine",
    //   id: 60,
    //   audioFileEN: "assets/audio/60en.mp3",
    //   audioFileAR: "assets/audio/60ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "Meeting with the Accreditation and Quality Assurance Center",
    //   titleAR: "اجتماع مع مركز الاعتماد وضمان الجوده",
    //   content:
    //       "The College of Rehabilitation Sciences hosted Mrs. Najda Hayajneh, Head of the Planning Division from the Accreditation and Quality Assurance Center, to hold a meeting with members of the teaching and administrative staff and students to discuss the executive plan and its importance in achieving the strategic goals and objectives of the university. To reach the university to development and excellence\n\n"
    //       "On Sunday 4/2 and Wednesday 4/5/2023 in the college.",
    //   contentAR:
    //       "استضافت كليه علوم التأهيل السيده نجده هياجنه رئيس شعبه التخطيط من مركز الاعتماد وضمان الجوده لعقد  اجتماع مع اعضاء الهيئتين التدريسيه والاداريه والطلبه لمناقشه الخطه التنفيذيه واهميتها في تحقيق غايات واهداف الجامعه الاستراتيجيه، كما تم اطلاع الأعضاء على معايير جائزه الجامعه الرسميه المميزه وتم توضيح اهميه ودور جميع الأعضاء للوصول في الجامعه الى التطوير والتميز"
    //       "وذلك يومي الاحد الوافي ٤/٢ والاربعاء الموافق ٤/٥ /٢٠٢٣ في الكليه.",
    //   urlImage: "assets/images/Quality.jpg",
    //   collegeName: "School of Rehabilitation Sciences",
    //   id: 61,
    //   audioFileEN: "assets/audio/61en.mp3",
    //   audioFileAR: "assets/audio/61ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A training workshop for college students entitled \"Therapeutic Relationship and Communication Skills\".",
    //   titleAR:
    //       " ورشة تدريبية لطلبة الكلية بعنوان  العلاقة العلاجية ومهارات التواصل",
    //   content:
    //       "On Tuesday, 3/14/2023, the College of Rehabilitation Sciences held a training workshop for college students entitled \"Therapeutic Relationship and Communication Skills\", presented by Psychiatrist Dr. Ashraf Al-Salihi, and Occupational Therapist Professor Zaid Naji. The workshop included talking about the nature of the therapeutic relationship based on trust between the therapist/technician and the patient. The lecturers also talked about verbal and non-verbal communication skills and their impact on the therapeutic relationship. The lecturers thankfully touched on recommendations about the skills of dealing with others, the most important of which are the members of the medical team.\n\n"
    //       "This workshop comes under the supervision of the Conferences and Seminars Committee in the College of Rehabilitation Sciences, based on the college's vision to provide students with the necessary skills on the academic and personal levels.",
    //   contentAR:
    //       "عقدت كلية علوم التأهيل يوم الثلاثاء الموافق 14/3/2023 ورشة تدريبية لطلبة الكلية بعنوان  العلاقة العلاجية ومهارات التواصل، قدمها أخصائي الطب النفسي الدكتور أشرف الصالحي، والمعالج الوظيفي الأستاذ زيد ناجي. حيث تضمنت الورشة الحديث عن طبيعة العلاقة العلاجية المبنية على الثقة بين المعالج/الفني والمريض، كما وتحدث المحاضرين عن مهارات التواصل اللفظي وغير اللفظي وأثرها على العلاقة العلاجية. وتطرق المحاضرين مشكورين لتوصيات حول مهارات التعامل مع الأخرين ومن أهمهم أعضاء الفريق الطبي."
    //       "وتأتي هذه الورشة تحت إشراف لجنة المؤتمرات والندوات في كلية علوم التأهيل، استنادا إلى رؤية الكلية بتزويد الطلبة بالمهارات الضرورية على المستوى العلمي والشخصي.",
    //   urlImage: "assets/images/entitled.jpg",
    //   collegeName: "School of Rehabilitation Sciences",
    //   id: 62,
    //   audioFileEN: "assets/audio/62en.mp3",
    //   audioFileAR: "assets/audio/62ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Prof. Dr. Dean of Scientific Research and his team meet with all members of the faculty",
    //   titleAR:
    //       "إلتقاء الاستاذ الدكتور عميد البحث العلمي وفريقه بجميع اعضاء الهيئه التدريسيه",
    //   content:
    //       "In the presence of the Dean of the College of Rehabilitation Sciences, Prof. Dr. Kamal Al-Hadidi, the Dean of Scientific Research, Dr. Faleh Al-Sawair, and the Assistant Dean for Research Cooperation, Dr. Aseel Al-Sharari, Head of the External Projects Division, Ms. Reham Dannoun, with faculty members at the Faculty of Rehabilitation Sciences on Wednesday morning 12-21-2022 to talk about research teams and external support opportunities.\n\n"
    //       "The meeting was opened by a. Dr.. The Dean of Scientific Research spoke about the latest developments and achievements of the Deanship with regard to forming and facilitating the work of research teams and the privileges that accrue to a faculty member by joining these teams. And he urged faculty members to form or join different research teams at the university and the need to go to obtain external support for research projects.\n\n"
    //       "Dr. Assistant Dean for Research Cooperation gave a detailed presentation on the research teams, their importance, how they are formed, and the types of support provided by the Deanship of Scientific Research. And she stated that the university and the deanship hoped to form these teams to increase the quantity and quality of scientific production and to link with international research teams that would raise the level of scientific production.\n\n"
    //       "The head of the External Projects Division also gave a detailed presentation on the opportunities to support international research projects, their sources, and how to search for them. The faculty was briefed on the method and type of support provided by the Deanship in the event of a desire to apply for external support",
    //   contentAR:
    //       "بحضور عميد كلية علوم التأهيل الاستاذ الدكتور كمال الحديدي، التقى عميد البحث العلمي الاستاذ الدكتور فالح السواعير، و مساعد العميد للتعاون البحثي د. أسيل الشرايري، و رئيس شعبة المشاريع الخارجية السيدة رهام دنون مع أعضاء الهيئة التدريسية في كلية علوم التأهيل صباح الاربعاء 21-12-2022  للتحدث حول الفرق البحثية و فرص الدعم الخارجي."
    //       "و افتتح اللقاء أ. د. عميد البحث العلمي بالتحدث حول اخر مستجدات  و انجازات العمادة بما يتعلق بتشكيل و تيسير عمل الفرق البحثية و الامتيازات التي تعود على عضو هيئة التدريس من خلال انضمامه لهذه الفرق. و حث اعضاء الهيئة التدريسية على تشكيل الفرق البحثية المختلفة او الانضمام لها في الجامعة و ضرورة التوجه لتحصيل الدعم الخارجي للمشاريع البحثية."
    //       "و قامت الدكتورة مساعد العميد للتعاون البحثي بعرض مفصل عن الفرق البحثية و أهميتها و كيفية تشكيلها وانواع الدعم المقدم من عمادة البحث العلمي. و افادت ان الجامعة و العمادة تأمل بتشكيل هذه الفرق لزيادة كمية و نوعية الانتاج العلمي والربط مع فرق بحثية عالمية والتي من شأنها رفع مستوى الانتاج العلمي."
    //       "كما قامت السيدة رئيس شعبة المشاريع الخارجية بعرض مفصل حول فرص دعم المشاريع البحثية العالمية و مصادرها و كيفية البحث عنها. و اطلعت الهيئة التدريسية على كيفية و نوع الدعم المقدم من العمادة في حال الرغبة بالتقديم لدعم خارجي",
    //   urlImage: "assets/images/members.jpeg",
    //   collegeName: "School of Rehabilitation Sciences",
    //   id: 63,
    //   audioFileEN: "assets/audio/63en.mp3",
    //   audioFileAR: "assets/audio/63ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The second scientific event for the month of May 2023 - The Art and Science of Indirect Adhesive Restoration for Posterior Teeth workshop",
    //   titleAR:
    //       "الفعالية العلمية الثانية لشهر ايار 2023 - ورشة عمل The Art and Science of Indirect Adhesive Restoration for Posterior Teeth",
    //   content:
    //       "The Continuing Medical Education Committee at the Faculty of Dentistry / University of Jordan held the second scientific event for the month of May 2023 on Saturday corresponding to 5/20/2023, a workshop entitled:\n\n"
    //       "The Art and Science of Indirect Adhesive Restoration for Posterior Teeth\n\n"
    //       "Co-presented:\n"
    //       "Dr. Mohamed Rababa\n"
    //       "Dr. Islam Abdel Rahim\n"
    //       "Dr. Ahmed Al-Maaytah",
    //   contentAR:
    //       "عقدت لجنة التعليم الطبي المستمر في كلية طب الأسنان / الجامعة الأردنية الفعالية العلمية الثانية لشهر ايار 2023 يوم السبت الموافق 2023/5/20 وهي ورشة عمل بعنوان:"
    //       "The Art and Science of Indirect Adhesive Restoration for Posterior Teeth"
    //       "شارك في تقديمها :"
    //       "الدكتور محمد الربابعة"
    //       "الدكتورة اسلام عبد الرحيم"
    //       "الدكتور أحمد المعايطة",
    //   urlImage: "assets/images/Teeth.jpg",
    //   collegeName: "School of Dentistry",
    //   id: 64,
    //   audioFileEN: "assets/audio/64en.mp3",
    //   audioFileAR: "assets/audio/64ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The third scientific event for the month of May 2023 - Dr. Muhannad Hatamleh and Dr. Dima Abu Bakr",
    //   titleAR:
    //       "الفعالية العلمية الثالثة لشهر ايار 2023 - د. مهند حتاملة ود. ديما أبو بكر",
    //   content:
    //       "The Continuing Medical Education Committee at the Faculty of Dentistry - University of Jordan held the third scientific event for the month of May 2023 on Tuesday, corresponding to May 23, 2023 in Ahmed Al-Lawzi Amphitheater / King Abdullah II College for Information Technology Building - University of Jordan",
    //   contentAR:
    //       "عقدت لجنة التعليم الطبي المستمر في كلية طب الأسنان – الجامعة الأردنية الفعالية العلمية الثالثة لشهر ايار 2023 يوم الثلاثاء الموافق 23 آيار 2023 في مدرج احمد اللوزي / مبنى كلية الملك عبدالله الثاني لتكنولوجيا المعلومات – الجامعة الأردنية",
    //   urlImage: "assets/images/Dima.jpg",
    //   collegeName: "School of Dentistry",
    //   id: 65,
    //   audioFileEN: "assets/audio/65en.mp3",
    //   audioFileAR: "assets/audio/65ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Hosting Prof. Dr. Marcio da Fonseca",
    //   titleAR: "استضافة الأستاذ الدكتور ماركيو دا فونسيكا",
    //   content:
    //       "The College of Dentistry hosted Professor Dr. Marcio da Fonseca, Consultant Pediatric Dentistry at the University of Illinois, Chicago.\n\n"
    //       "Where he delivered a lecture on Down syndrome for postgraduate students in the Master of Pediatric Dentistry.",
    //   contentAR:
    //       "استضافت كلية طب الأسنان الأستاذ الدكتور ماركيو دا فونسيكا الاستشاري في طب أسنان الأطفال في جامعة الينوي, شيكاغو."
    //       " حيث قام بالقاء محاضرة عن متلازمة داون لطلاب الدراسات العليا في ماجستير طب أسنان الأطفال.",
    //   urlImage: "assets/images/Marcio.jpeg",
    //   collegeName: "School of Dentistry",
    //   id: 66,
    //   audioFileEN: "assets/audio/66en.mp3",
    //   audioFileAR: "assets/audio/66ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "Holding the exam for the second part of the exam (MFD RCSI) in presence",
    //   titleAR: "عقد امتحان الجزء الثاني لامتحان( MFD RCSI ) وجاهياً",
    //   content:
    //       "The College of Dentistry / University of Jordan and the Royal College of Surgeons in Ireland held the second part of the (MFD RCSI) exam on Saturday, 5/6/2023, with a free training day for applicants, on Friday 5/5/2023.\n\n"
    //       "It is worth noting that this exam was held for the first time in person at the Faculty of Dentistry at the University of Jordan after the Corona pandemic, in cooperation with examiners from the Faculties of Dentistry at the University of Jordan and the Jordan University of Science and Technology.",
    //   contentAR:
    //       "عقدت كلية طب الاسنان /  الجامعة الأردنية والكلية الملكية للجراحين في ايرلندا، الجزء الثاني لامتحان( MFD RCSI )  وجاهياً يوم السبت الموافق 6/5/2023  مع يوم تدريبي مجاني للمتقدمين وذلك يوم الجمعة الموافق 5/5/2023."
    //       "والجدير بالذكر ان هذا الامتحان تم عقده لاول مرة وجاهياً في كلية طب الأسنان في الجامعة الاردنية بعد جائحة كورونا وبالتعاون مع ممتحنين من كليتي طب الاسنان في الجامعة الاردنية وجامعة العلوم والتكنولوجيا الأردنية.",
    //   urlImage: "assets/images/MFD.jpg",
    //   collegeName: "School of Dentistry",
    //   id: 67,
    //   audioFileEN: "assets/audio/67en.mp3",
    //   audioFileAR: "assets/audio/67ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Visiting students of a Doctor of Pharmacy",
    //   titleAR: "زيارة طلبة دكتور في الصيدلة",
    //   content:
    //       " group of sixth-year Doctor of Pharmacy students visited Al-Khalidi Hospital to see the preparation of chemotherapy drugs for cancer patients.\n\n"
    //       "This visit was organized by the Student Activities Committee.",
    //   contentAR:
    //       "مجموعة من طلاب دكتور في الصيدلة السنة السادسة بزيارة مستشفى الخالدي للاطلاع على تحضير أدوية العلاج الكيماوي لمرضى السرطان."
    //       "تم تنظيم هذه الزيارة من قبل لجنة الأنشطة الطلابية.",
    //   urlImage: "assets/images/Visitph.jpeg",
    //   collegeName: "School of Pharmacy",
    //   id: 68,
    //   audioFileEN: "assets/audio/68en.mp3",
    //   audioFileAR: "assets/audio/68ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "College of Pharmacy alumni meeting 1991",
    //   titleAR: "ملتقى خريجي كلية صيدلة 1991",
    //   content:
    //       "The Faculty of Pharmacy at the University of Jordan organized a forum for the graduates of the class (1991) to introduce them to the developments and updates that occurred in the faculty and to find ways to communicate with them.\n\n"
    //       "The Dean of the Faculty, Rana Abu Al-Dahab, stated that the Faculty, since its establishment in 1980, has witnessed achievements and developments, and is considered one of the leading centers in the field of pharmaceutical education in Jordan, and enjoys an excellent national and regional reputation in research and innovation.\n\n"
    //       "She added that the organization of the forum came to enhance and maintain communication between the college and its graduates and to know the most important achievements they reached, as a number of these graduates work in the government and private sectors, which supports the education process through the feedback they received in their work.\n\n"
    //       "Abu al-Dahab expressed her pride in the graduates of the college, the ambassadors of their home university in the fields of work.\n\n"
    //       "The forum included a dialogue session in which the graduates talked about their most important practical achievements and made recommendations to the new graduates to facilitate ways of working in the pharmaceutical market sectors.",
    //   contentAR:
    //       "نظَّمت كلية الصيدلة في الجامعة الأردنية ملتقى خريجي دفعة (1991) لتعريفهم بالتطورات والتحديثات التي طرأت على الكلية وإيجاد طرق للتواصل معهم."
    //       "وصرحت عميدة الكلية رنا أبو الذهب إن الكلية منذ تأسيسها عام 1980 شهدت إنجازات وتطورات،  وتعد واحدة من المراكز الرائدة في مجال التعليم الصيدلاني في الأردن، وتتمتع بسمعة وطنية وإقليمية ممتازة في البحث والابتكار."
    //       "  وأضافت أن تنظيم الملتقى جاء تعزيزا وإدامة التواصل بين الكلية وخريجيها ومعرفة أهم الإنجازات التي توصلوا إليها، حيث أن عددا من هؤلاء الخريجين يعملون في القطاعات الحكومية والخاصة، وهو ما يدعم مسيرة التعليم من خلال التغذية الراجعة التي تلقوها في عملهم."
    //       "  وعبّرت أبو الذهب عن فخرها واعتزازها بخريجي الكلية سفراء جامعتهم الأم في ميادين العمل."
    //       "وتضمن الملتقى جلسة حوارية تحدث فيها الخريجون عن أهم انجازتهم العملية وقدموا توصيات للخريجين الجدد لتسهيل سبل العمل في قطاعات السوق الصيدلاني",
    //   urlImage: "assets/images/alumni.jpeg",
    //   collegeName: "School of Pharmacy",
    //   id: 69,
    //   audioFileEN: "assets/audio/69en.mp3",
    //   audioFileAR: "assets/audio/69ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The College of Pharmacy held practical workshops on the use of the NOnmem software for master's students",
    //   titleAR:
    //       "عقدت كلية الصيدلة ورشات عملية على استخدام برمجية NONMEM لطلاب الماجستير",
    //   content:
    //       "For the first time, the College of Pharmacy held several practical workshops aimed at training master's students on the use of the NONMEM software within biopharmaceuticals and pharmacokinetics, under the supervision of Dr. Mariam Hantash Abdel-Galil. This software is one of the leading and important programs in analyzing data related to pharmacokinetics.\n\n"
    //       "These workshops were concluded with a practical and theoretical exam, and Dr. Maryam expressed her satisfaction with the good level of students' performance",
    //   contentAR:
    //       "قامت كلية الصيدلة لأول مرة بعقد عدة ورشات عملية تهدف لتدريب طلاب الماجستيرعلى استخدام برمجية   NONMEM  ضمن مادة الصيدلة الحيوية وحرائك الدواء، تحت إشراف الدكتورة مريم هنطش عبد الجليل. وتعد هذه البرمجية من البرامج الرائدة و المهمة في تحليل البيانات المتعلقة في حركية الدواء"
    //       "وختمت هذه الورشات بإمتحان عملي و نظري ، وأبدت الدكتورة مريم رضاها عن المستوى الجيد لأداء الطلاب.",
    //   urlImage: "assets/images/NOnmem.jpg",
    //   collegeName: "School of Pharmacy",
    //   id: 70,
    //   audioFileEN: "assets/audio/70en.mp3",
    //   audioFileAR: "assets/audio/70ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "Nursing \"Jordanian\" carries out a health, educational, and training activity at McKinsey Nursery",
    //   titleAR:
    //       "تمريض الأردنية تنفذ نشاطًا صحيًّا تثقيفيًّا تدريبيًّا في حضانة ماكينزي",
    //   content:
    //       "Today, the University and Community Committee at the College of Nursing at the University of Jordan carried out a health, educational, and training activity at McKinsey Nursery in Sweileh.\n\n"
    //       "The activity included holding various activities aimed at educating mothers and nursery educators about the mechanism of interaction with stubborn children, presented by the teacher, Jumana Shehadeh, from the Department of Community Health Nursing.\n\n"
    //       "The activity also dealt with training nursery children from the age of three to five years on the correct way to wash and clean hands, and the proper way to take care of dental hygiene, through a training theatrical show that resorted to using cartoon characters, and was performed by a group of fourth-year students in the college, under the supervision of the school, Reem Al-Taie. From the Department of Community Health Nursing.\n\n"
    //       "Mothers and nannies were also trained to perform first aid in cases of stuttering, heart and lung arrest, burns, fractures, and nosebleeds. These were provided by Taghreed Shawashi, the rapporteur of the university and community committee in the school’s clinical nursing department, and the official of the Jordanian Society for Palliative Care, Suleiman Ahmed.\n\n"
    //       "During the activity, an educational lecture was held for mothers and nannies about proper feeding for infants, teething, and how to deal with fever and resulting spasms, delivered by Dr. Umayyah Nassar from the Department of Maternal and Child Health Nursing.",
    //   contentAR:
    //       "نفذت لجنة الجامعة والمجتمع في كلية التمريض في الجامعة الأردينة اليوم نشاطًا صحيًّا تثقيفيًّا تدريبيًّا في حضانة ماكينزي في منطقة صويلح."
    //       "واشتمل النشاط على إقامة فعاليات متنوعة تهدف إلى تثقيف الأمهات ومربيات الحضانة حول آلية التفاعل مع الطفل العنيد، قدمتها المدرسة جمانة شحادة من قسم تمريض صحة المجتمع."
    //       "كما تناول النشاط تدريبَ أطفال الحضانة من عمر ثلاث إلى خمس سنوات على الطريقة الصحيحة لغسل وتنظيف اليدين، والطريقة السليمة للعناية بنظافة الأسنان، من خلال عرض مسرحي تدريبي لجأ إلى استخدام شخصيات كرتونية، وأدته مجموعة من طالبات السنة الرابعة في الكلية، تحت إشراف المدرسة ريم الطائي من قسم تمريض صحة المجتمع."
    //       "كما دُرّبت الأمهات والمربيات على إجراء الإسعافات الأولية في حالات الشردقة، وتوقف القلب والرئتين، والحروق والكسور، والرعاف، قدمتها مقررة لجنة الجامعة والمجتمع في قسم التمريض السريري المدرسة تغريد شواشي، ومسؤول الجمعية الأردنية للرعاية التلطيفية سليمان أحمد."
    //       "وخلال النشاط، عُقدت محاضرة تثقيفية للأمهات والمربيات حول التغذية السليمة للأطفال الرُّضّع، والتسنين، وكيفية التعامل مع الحُمّى والتشجنات الناتجة عنها، ألقاها الدكتور أمية نصار من قسم تمريض صحة الأم والطفل.",
    //   urlImage: "assets/images/McKinsey.jpg",
    //   collegeName: "School Of Nursing",
    //   id: 71,
    //   audioFileEN: "assets/audio/71en.mp3",
    //   audioFileAR: "assets/audio/71ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Faculty of Nursing at \"UJ\" hosts the Secretary General of the Jordanian Nursing Council",
    //   titleAR:
    //       "كلية التمريض في الأردنية تستضيف الأمين العام للمجلس التمريضي الأردني",
    //   content:
    //       "Today, the Faculty of Nursing at the University of Jordan hosted the Secretary-General of the Jordanian Nursing Council, Dr. Hani Al-Nawafleh, and the Director of the Training and Continuing Education Unit in the Council, Bilal Badr Al-Naja.\n\n"
    //       "During their meeting with the students of the intensive clinical training course, Al-Nawafleh and Al-Naja talked about the exam for practicing the nursing profession, the conditions for continuous learning activities, and the renewal of the license to practice the profession.\n\n"
    //       "At the end of the meeting, an extensive discussion took place by the students of the Faculty of Nursing with the speakers about what is related to the profession practice exam and its developments.",
    //   contentAR:
    //       "استضافت كلية التمريض في الجامعة الأردنية اليوم الأمين العام  للمجلس التمريضي الأردني الدكتور هاني النوافلة، ومدير وحدة التدريب والتعليم المستمر في المجلس بلال بدر النجا."
    //       "وتحدث النوافلة والنجا خلال لقائهم طلبة مادة التدريب السريري المكثف عن امتحان مزاولة مهنة التمريض والشروط لنشاطات التعلم المستمر وتجديد ترخيص مزاولة المهنة."
    //       "وفي ختام اللقاء دار نقاش مستفيض من قبل طلبة كلية التمريض مع المتحدثين حول ما يتعلق بامتحان مزاولة المهنه ومستجداته.",
    //   urlImage: "assets/images/Council.jpg",
    //   collegeName: "School Of Nursing",
    //   id: 72,
    //   audioFileEN: "assets/audio/72en.mp3",
    //   audioFileAR: "assets/audio/72ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The Faculty of Nursing at \"UJ\" holds a workshop to discuss research projects for clinical nursing students, with the participation of visiting students from Columbia University, USA",
    //   titleAR:
    //       "كلية التمريض في الأردنيّة تعقد ورشة لمناقشة مشاريع بحثية لطلبة مادة التمريض السريري بمشاركة طلبة زائرين من جامعة كولومبيا الأمريكيّة",
    //   content:
    //       "The Faculty of Nursing at the University of Jordan recently held a workshop to discuss research projects for clinical nursing students, as part of the Master's degree in Clinical Nursing \"Intensive Care\"."
    //       "The workshop was implemented by students of the Faculty of Nursing, with the participation of visiting students from Columbia University through the Columbia University Center domiciled in the capital, Amman, under the supervision of the Dean of the Faculty of Nursing, Dr.\n"
    //       "The workshop aims to integrate visiting students with students of the Faculty of Nursing at the University of Jordan, and work on implementing research projects.",
    //   contentAR:
    //       "عقدت كلية التمريض في الجامعة الأردنية مؤخرا ورشة عمل لمناقشة مشاريع بحثية لطلبة مادة التمريض السريري، وذلك ضمن ماجستير التمريض السريري الرعاية الحثيثة."
    //       "ونفّذ الورشة طلبة كلية التمريض، بمشاركة طلبة زائرين من جامعة كولومبيا عبر مركز جامعة كولومبيا المُوطّن في العاصمة عمّان، وبإشراف عميدة كلية التمريض الدكتورة أريج عثمان، وحضور عدد من أعضاء هيئة التدريس في الكلية، إلى جانب ممثلين من جامعة كولومبيا ومختصّين من مستشفى الجامعة الأردنية."
    //       "وتهدف الورشة إلى دمج الطلبة الزائرون مع طلبة كلية التمريض في الجامعة الأردنية، والعمل على تنفيذ مشاريع بحثية.",
    //   urlImage: "assets/images/USA.jpg",
    //   collegeName: "School Of Nursing",
    //   id: 73,
    //   audioFileEN: "assets/audio/73en.mp3",
    //   audioFileAR: "assets/audio/73ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "A joint research workshop between the College and the College of Medicine",
    //   titleAR: "ورشة بحثية مشتركة بين الكلية وكلية الطب",
    //   content:
    //       "As part of the first work of the research cooperation committee between the College of Medicine and the King Abdullah II College for Information Technology, the first joint workshop between the two colleges was held in Ahmed Al-Lawzi Theater at the King Abdullah II College for Information Technology on Tuesday, 5/23/2023. The workshop was attended by the Dean of the College Medicine Prof. Dr. Yasser Al-Rayyan and Dean of King Abdullah II School of Information Technology Prof. Dr. Saleh Al-Sharayaa, in addition to a large number of faculty members and students in both colleges. It also attracted a large number of interested people from other universities and companies interested in the medical-technological issue.\n\n"
    //       "At the beginning of the workshop, Prof. Dr. Yasser Al-Rayyan stressed the importance of this strategic and vital cooperation and the support of the university administration and the deanships of the two colleges for this integration between the different disciplines to keep pace with the great technical acceleration that we are currently experiencing, which necessitates concerted efforts between the various disciplines to confront the technical and research problems facing the medical sector.\n\n"
    //       "Then the proceedings of the workshop began, which lasted for more than 4 hours, and included two scientific sessions, including a networking session between researchers.\n\n"
    //       "In the first session, Dr. Saif Al-Din Al-Riyalat and Dr. Laila Tutonji from the College of Medicine spoke about the types of medical data that need research and study and about the most important opportunities and challenges facing medical research. Dr. Laith Al-Omari from the King Hussein Cancer Center also spoke about methods of encoding medical data and the most important sources for obtaining medical data open.\n\n"
    //       "Then Dr. Eyad Sultan from the King Hussein Cancer Center made a presentation on the role of modern technologies in supporting the processing of medical data.\n\n"
    //       "In the second session devoted to researchers from the King Abdullah II School of Information Technology, Dr. Magdi Sawalha and Dr. Heba Saadeh spoke about the two topics of using natural language processing techniques in medical research and about applications of computational biology, while Prof. Dr. Ibrahim Al-Jarrah reviewed some research on medical data that he carried out with his group research.\n\n"
    //       "For her part, Dr. Hoda Karajah reviewed the field of digital image processing in medical research, and Dr. Musa Al-Akhras reviewed the detailed steps starting from the idea and obtaining and processing digital images, then extracting the medical characteristics for the diagnosis of glaucoma.\n\n"
    //       "It was agreed to hold a continuous series of specialized workshops between the two colleges to enhance research and technical cooperation and translate these ideas into pioneering products, innovative technical solutions, and research of a distinct medical technical nature that combines the capabilities of both colleges in a way that benefits and distinguishes the university and the country. It was also agreed to form small groups. Focused and clear goals.\n\n"
    //       "At the end of the workshop, a dialogue session was held between the speakers and the audience, and many ideas were put forward and points of view were heard by the attendees, who praised this pioneering initiative.",
    //   contentAR:
    //       "ضمن باكورة أعمال لجنة التعاون البحثي بين كلية الطب وكلية الملك عبد الله الثاني لتكنولوجيا المعلومات تم عقد أولى ورشات العمل المشتركة بين الكليتين وذلك في مسرح أحمد اللوزي في كلية الملك عبد الله الثاني لتكنولوجيا المعلومات يوم الثلاثاء الموافق 23 / 5 / 2023 وقد حضر الورشة عميد كلية الطب الأستاذ الدكتور ياسر الريان وعميد كلية الملك عبدالله الثاني لتكنولوجيا المعلومات الأستاذ الدكتور صالح الشرايعة بالإضافة لعدد كبير من أعضاء هيئة التدريس والطلبة في كلا الكليتين كما استقطبت عددا كبيراً من المهتمين من جامعات أخرى و شركات مهتمة بالشأن الطبي التكنولوجي."
    //       "في بداية ورشة العمل أكد الأستاذ الدكتور ياسر الريان على أهمية هذا التعاون الاستراتيجي والحيوي ودعم إدارة الجامعة وعمادتي الكليتين لهذا التكامل بين التخصصات المختلفة لمواكبة التسارع التقني الكبير الذي نعيشه حاليا مما يحتم تضافر الجهود بين مختلف التخصصات لمواجهة المشكلات التقنية والبحثية التي يواجهها القطاع الطبي."
    //       "ثم بدأت وقائع ورشة العمل التي استمرت أكثر من 4 ساعات اشتملت على جلستين علميتين بينهما جلسة تشبيك بين الباحثين."
    //       "في الجلسة الأولى تحدث الدكتور سيف الدين الريالات والدكتورة ليلى توتونجي من كلية الطب حول أنواع البيانات الطبية التي تحتاج لبحث ودراسة وحول أهم الفرص والتحديات التي تواجه البحث الطبي كما تكلم الدكتور ليث العمري من مركز الحسين للسرطان حول طرق ترميز البيانات الطبية وأهم المصادر للحصول على البيانات الطبية المفتوحة."
    //       "ثم قام الدكتور إياد سلطان من مركز الحسين للسرطان بمداخلة حول دور التقنيات الحديثة في دعم معالجة البيانات الطبية."
    //       "في الجلسة الثانية المخصصة للباحثين من كلية الملك عبد الله الثاني لتكنولوجيا المعلومات تكلم الدكتور مجدي صوالحة والدكتورة هبة سعادة حول موضوعي استخدام تقنيات معالجة اللغات الطبيعية في الأبحاث الطبية وحول تطبيقات البيولوجيا الحسابية فيما استعرض الأستاذ الدكتور إبراهيم الجراح بعض الأبحاث حول البيانات الطبية التي قام بها مع مجموعته البحثية."
    //       "من جهتها قامت الدكتورة هدى كراجه باستعراض مجال معالجة استخدام الصور الرقمية في الأبحاث الطبية واستعرض الدكتور موسى الأخرس الخطوات التفصيلية ابتداءاً من الفكرة والحصول على الصور الرقمية ومعالجتها ثم استخلاص الخصائص الطبية لتشخيص مرض الجلوكوما."
    //       "هذا وتم الاتفاق على عقد سلسلة مستمرة من ورشات العمل المتخصصة بين الكليتين لتعزيز التعاون البحثي والتقني وترجمة هذه الأفكار لمنتجات رائدة وحلول تقنية مبتكرة وأبحاث ذات صبغة تقنية طبية متميزة تدمج بين إمكانيات كلا الكليتين بما يعود بالفائدة والتميز على الجامعة والوطن كما تم الاتفاق على تشكيل مجموعات مصغرة ذات أهداف مركزة وواضحة."
    //       "في نهاية ورشة العمل تم عقد جلسة حوارية بين المتحدثين والحضور وتم طرح أفكار عديدة وسماع وجهات النظر من قبل الحضور الذين أشادوا بهذه المبادرة الرائدة.",
    //   urlImage: "assets/images/joint.jpeg",
    //   collegeName: "School of Information Technology",
    //   id: 74,
    //   audioFileEN: "assets/audio/74en.mp3",
    //   audioFileAR: "assets/audio/74ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Launching the activities of the first scientific day of the Department of Computer Information Systems",
    //   titleAR:
    //       "انطلاق فعاليات اليوم العلمي الأول لقسم أنظمة المعلومات الحاسوبية",
    //   content:
    //       "On Tuesday 9/5/2023, in the Department of Computer Information Systems at the King Abdullah II College for Information Technology at the University of Jordan, the activities of the department's first scientific and technical day were launched.\n\n"
    //       "The Dean of the College, Dr. Saleh Al-Sharaya, said in a speech he delivered that this day came to embody the strong relationship between the academic and industrial sectors, and to present graduation projects for students, as well as to give students an opportunity to get acquainted closely with the needs of the labor market through participating companies and institutions.\n\n"
    //       "Al-Sharaya called on the students to benefit from the expertise provided by these companies, learn about their products, the necessary technologies required by the labor market, and the job opportunities available to them, urging them to attend the dialogue sessions that will contribute to enriching their knowledge.\n\n"
    //       "For his part, the head of the department, Dr. Musa al-Akhras, spoke about the scientific day program and its importance to students, and gave an overview of the computer information systems major, which is one of the most important specializations in information and computer technology, as it combines various computer science disciplines with organizational and administrative fields, and enables students to acquire knowledge and skills. Necessary for the analysis, design, development and operation of information systems, and benefit from them in any of the public or private institutions\n\n."
    //       "The activities of the scientific day included workshops and seminars related to the most important fields studied by the department, and in which the participating entities operate. It also witnessed a presentation of a group of graduation projects that were completed during the last period in the department, in addition to including an exhibition of the most prominent products of the participating companies and institutions.",
    //   contentAR: "",
    //   urlImage: "assets/images/Sharaya.jpg",
    //   collegeName: "School of Information Technology",
    //   id: 75,
    //   audioFileEN: "assets/audio/75en.mp3",
    //   audioFileAR: "assets/audio/75ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "Student Ayham Khamis won the 8Log Omnia Writing Competition",
    //   titleAR: "فوز الطالب أيهم خميس بمسابقة أمنية للكتابة 8Log",
    //   content:
    //       "On Tuesday evening, 9/5/2023, Umniah Telecom announced the names of the winners of the fourth writing competition, The 8Log, for Jordanian university students, during the celebration of its establishment of an Umniah incubator to increase business. The jury chose the 10 best articles for their writers to participate in a training workshop on Saturday, May 6 with “Anwan”, to be given advice and guidance regarding writing articles in general and blogs in particular. Where the first place was won by student Ayham Khamis from the King Abdullah II School of Information Technology at the University of Jordan\n\n"
    //       "It is worth noting that The 8Log from Umniah is the first blog in the Jordanian telecommunications sector to provide specialized content in Arabic with the aim of enriching Arabic content on the Internet and empowering Jordanian youth. The blog provides technical information on many topics of interest to the Jordanian youth, as well as sheds light on innovative Jordanian initiatives and success stories that made their way in the world of entrepreneurship.",
    //   contentAR:
    //       "أعلنت شركة أمنية للاتصالات مساء يوم الثلاثاء 9/5/2023 أسماء الفائزين في مسابقة The 8Log الرابعة للكتابة لطلبة الجامعات الأردنية وذلك خلال احتفالية إقامتها حاضنة أمنية لزيادة الأعمال. قامت لجنة التحكيم باختيار أفضل 10 مقالات لمشاركة كتّابها في ورشة عمل تدريبية يوم السبت 6 أيار مع أنوان، ليتم إعطاؤهم نصائح وإرشادات فيما يتعلق بكتابة المقالات بشكل عام والمدونات بشكل خاص. وبعد انتهاء الورشة قامت اللجنة بتقييم آخر واختيارت الخمسة مقالات المتأهلة للمرحلة النهائية؛ حيث فاز بالمركز الأول، الطالب أيهم خميس من كلية الملك عبدالله الثاني لتكنولوجيا المعلومات في الجامعة الأردنية"
    //       "تجدر الإشارة إلى مدونة The 8Log من أمنية، هي أوّل مدوّنة في قطاع الاتصالات الأردني تقدّم محتوى متخصص باللغة العربية بهدف إثراء المحتوى العربي على الإنترنت وتمكين الشباب الأردني. تقدّم المدونة المعلومة بتقنية في مواضيع عديدة تهم الشاب الأردني، كما وتلقي الضوء على مبادرات أردنية مبتكرة وقصص نجاح شقّت طريقها في عالم ريادة الأعمال.",
    //   urlImage: "assets/images/Ayham.jpg",
    //   collegeName: "School of Information Technology",
    //   id: 76,
    //   audioFileEN: "assets/audio/76en.mp3",
    //   audioFileAR: "assets/audio/76ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "King Abdullah II School of Information Technology holds a lecture on big data and unstructured databases",
    //   titleAR:
    //       "كلية الملك عبدالله الثاني لتكنولوجيا المعلومات تعقد محاضرة عن البيانات الضخمة وقواعد البيانات غير المهيكلة",
    //   content:
    //       "In cooperation with Orange, King Abdullah II College for Information Technology holds a lecture on big data and unstructured databases\n\n"
    //       "Today, the King Abdullah II College of Information Technology at the University of Jordan, represented by the Department of Artificial Intelligence, hosted Eng. Youssef Al-Wishah, the leader of the big data team at Orange for North Africa and the Middle East.\n\n"
    //       "The lecture, which was held, aims to present the most important applications and solutions of big data and unstructured databases, for students of the Unstructured Databases course from the Department of Artificial Intelligence, in the presence of the subject teacher, Dr. Reem Al-Fayez.\n\n"
    //       "This lecture, according to the Dean of the King Abdullah II School for Information Technology, Dr. Saleh Al-Sharaya, aims to activate the participation of experts from the industrial sector in academic subjects, as this matter is considered a gateway through which the student learns how to apply the acquired knowledge and the mechanism of its application in a practical manner in the industrial sector and the labor market.\n\n"
    //       "Al-Wishah reviewed the definition of big data from a practical perspective, examples of unstructured databases, practical examples of how to use it in companies, and others.\n\n"
    //       "The lecture also touched on the best practices for managing big data projects and how to take advantage of the amount of data available to companies, as well as the common challenges in implementing these projects, and how to overcome them.\n\n"
    //       "At the end of the lecture, the Head of the Department of Artificial Intelligence, Dr. Ibrahim Al-Jarrah, expressed his thanks and appreciation for the participation of Eng. Al-Wishah, thanking him for transferring his experiences to the students, and stressing the impact of these lectures in bridging the gap between the academic process and industry, which would help students prepare for the labor market. .\n\n"
    //       "It is noteworthy that the King Abdullah II College of Information Technology, and as part of its strategies compatible with the objectives of the University of Jordan, has established, since the beginning of last year, strong partnerships with specialized local, regional and international companies, in order to provide means of cooperation in the fields of training, holding seminars, knowing the needs of the market and the skills to acquire for students. The College, in an effort to improve the outputs of the educational process in order to meet the strategic needs necessitated by the national and regional requirements.",
    //   contentAR:
    //       "بالتعاون مع شركة اورانج .. كلية الملك عبدالله الثاني لتكنولوجيا المعلومات تعقد محاضرة عن البيانات الضخمة وقواعد البيانات غير المهيكلة"
    //       " استضافت كلية الملك عبد الله الثاني لتكنولوجيا المعلومات في الجامعة الأردنيّة اليوم، ممثلة بقسم الذكاء الاصطناعي، قائد فريق البيانات الضخمة في شركة اورانج لشمال افريقيا والشرق الاوسط، المهندس يوسف الوشاح."
    //       "وتهدف المحاضرة التي تم عقدتها  إلى تقديم أهم التطبيقات وحلول البيانات الضخمة وقواعد البيانات غير المهيكلة، وذلك لطلبة مساق قواعد البيانات غير المهيكلة من قسم الذكاء الاصطناعي، وبحضور مدرسة المادة الدكتورة ريم الفايز."
    //       "وتأتي هذه المحاضرة حسب عميد كلية الملك عبد الله الثاني لتكنولوجيا المعلومات الدكتور صالح الشرايعة لتفعيل مشاركة الخبراء من القطاع الصناعي في المواد الأكاديمية، حيث يعتبر هذا الأمر بوابة يتعرف الطالب من خلالها على كيفية تطبيق المعارف المكتسبة وآليّة تطبيقها بأسلوب عملي في القطاع الصناعي وسوق العمل."
    //       "واستعرض المهندس الوشاح تعريفَ البيانات الضخمة من منظور عملي، وأمثلة على قواعد البيانات الغير مهيكلة، وأمثلة تطبيقية وعملية على كيفية استخدامها في الشركات، وغيرها."
    //       "كما تطرّقت المحاضرة لأفضل الممارسات لإدارة مشاريع البيانات الضخمة وكيفية الاستفاده من كمية البيانات المتوفره لدى الشركات، وايضا تم التطرق للتحديات الشائعة في تنفيذ هذه المشاريع، وكيفية التغلب عليها."
    //       "وفي نهاية المحاضرة، أعرب رئيس قسم الذكاء الاصطناعي الدكتور إبراهيم الجراح عن شكره وتقديره لمشاركة المهندس الوشاح، شاكرًا إيّاه على نقل خبراته إلى الطلبة، ومشدّدًا على أثر هذه المحاضرات في سد الفجوة بين العملية الأكاديمية والصناعة، التي من شأنها أن تساعد الطلبة على الاستعداد لسوق العمل."
    //       "يُذكر أن كلية الملك عبد الله الثاني لتكنولوجيا المعلومات، وضمن استراتيجياتها المتلائمة مع أهداف الجامعة الأردنية، عمدت منذ بداية العام المنصرم على عقد شراكات متينة مع الشّركات المحليّة والإقليميّة والعالميّة المتخصّصة، وذلك لإتاحة سبل التّعاون في مجالات التّدريب وعقد النّدوات ومعرفة حاجات السّوق والمهارات اللّازم إكسابها لطلبة الكليّة، في محاولة لتجويد مخرجات العملية التعليمية تلبية للاحتياجات الاستراتيجيّة التي تقتضيها المتطلبات الوطنيّة والإقليميّة.",
    //   urlImage: "assets/images/databa.jpg",
    //   collegeName: "School of Information Technology",
    //   id: 77,
    //   audioFileEN: "assets/audio/77en.mp3",
    //   audioFileAR: "assets/audio/77ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title:
    //       "The UJ honors 56 inventors among faculty members, researchers, administrators and students",
    //   titleAR:
    //       "الأردنية تكرم 56 مخترعًا من أعضاء الهيئة التدريسية والباحثين والإداريين والطلبة",
    //   content:
    //       " The College of Engineering, represented by its Dean, Prof. Dr. Nasser Al-Hunaiti, congratulates the professors and faculty members for their achievements and inventions, for which they were honored by the University President, Prof. Dr. Nazir Obeidat.\n\n"
    //       "This constellation of inventors includes fourteen academics from the College of Engineering out of fifty-six inventors at the university level and in its various departments. delusion: -\n\n"
    //       "1- Prof. Dr. Mahmoud Battah, Department of Civil Engineering.\n"
    //       "2- Prof. Dr. Laith Tashman, Department of Civil Engineering.\n"
    //       "3- Dr. Rabab Al-Lawzi, Department of Civil Engineering.\n"
    //       "4- Dr. Khaled Al-Omari, Department of Architecture.\n"
    //       "5- Prof. Dr. Mohamed Hawa, Department of Electrical Engineering.\n"
    //       "6- Prof. Dr. Nasser Al-Hunaiti, Department of Mechanical Engineering.\n"
    //       "7- Prof. Dr. Saleh Al-Akour, Department of Mechanical Engineering.\n"
    //       "8- Prof. Dr. Musa Abdullah, Department of Mechanical Engineering.\n"
    //       "9- Prof. Dr. Riyad Al-Shawabkeh, Department of Chemical Engineering.\n"
    //       "10- Prof. Dr. Munawar Al-Tarakieh, Department of Chemical Engineering.\n"
    //       "11- Dr. Muhammad Rasool Al-Qutaishat, Department of Chemical Engineering.\n"
    //       "12- Dr. Yazan Al-Zein, Department of Industrial Engineering.\n"
    //       "13- Prof. Dr. Anas Al-Rabadi, Department of Computer Engineering.\n"
    //       "14- Prof. Dr. Zaer Abu Hammour, Department of Mechatronics Engineering\n",
    //   contentAR:
    //       "تبارك كلية الهندسة متمثلةً بعميدها الاستاذ الدكتور ناصر الحنيطي الى الاساتذة واعضاء الهيئة التدريسية على انجازاتهم واختراعاتهم والتي تم تكريهم عليها من قِبل رئيس الجامعة الاستاذ الدكتور نذير عبيدات."
    //       "تضم هذه الكوكبة من المخترعين أربعة عشر أكاديميا من كلية الهندسة من أصل ستة وخمسون مخترعا على مستوى الجامعة وبمختلف اقسامها؛ وهم: -"
    //       "1- الأستاذ الدكتور محمود بطاح من قسم الهندسة المدنية."
    //       "2- الأستاذ الدكتور ليث طاشمان من قسم الهندسة المدنية."
    //       "3- الدكتورة رباب اللوزي من قسم الهندسة المدنية."
    //       "4- الدكتور خالد العمري من قسم هندسة العمارة."
    //       "5- الأستاذ الدكتور محمد حوا من قسم الهندسة الكهربائية."
    //       "6- الأستاذ الدكتور ناصر الحنيطي من قسم الهندسة الميكانيكية."
    //       "7- الأستاذ الدكتور صالح العكور من قسم الهندسة الميكانيكية."
    //       "8- الأستاذ الدكتور موسى عبد الله من قسم الهندسة الميكانيكية."
    //       "9- الأستاذ الدكتور رياض الشوابكة من قسم الهندسة الكيميائية."
    //       "10- الأستاذ الدكتور منور التراكية من قسم الهندسة الكيميائية."
    //       "11- الدكتور محمد رسول القطيشات من قسم الهندسة الكيميائية."
    //       "12- الدكتور يزن الزين من قسم الهندسة الصناعية."
    //       "13- الأستاذ الدكتور أنس الربضي من قسم هندسة الحاسوب."
    //       "14- الأستاذ الدكتور زائر أبوحمور من قسم هندسة الميكاترونكس.",
    //   urlImage: "assets/images/honors.jpg",
    //   collegeName: "School of Engineering",
    //   id: 78,
    //   audioFileEN: "assets/audio/78en.mp3",
    //   audioFileAR: "assets/audio/78ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A graduation project in Al-Urduniyah Architecture wins the third place in the “Engineers” competition",
    //   titleAR: "مشروع تخرج في عمارة الأردنية يحرز المركز الثالث في المهندسين",
    //   content:
    //       " Architect Bushra Attia, a graduate of the Department of Architecture at the University of Jordan, won third place in the Jordanian Engineers Association competition for architectural graduation projects for the year 2022.\n\n"
    //       "The graduation project supervised by Prof. Dr. Salim Dahabreh was entitled Ecotone.\n\n"
    //       "About her project, Engineer Bushra said: Ecoton is a project that aspires to provide agricultural crops in the capital, Amman, to meet the needs of its residents by employing vertical farming technology, which also contributes to promoting the concept of sustainability and urban agriculture and spreading awareness about it. The project also aims to revitalize unused lands And transforming it into a lung and an outlet in the absence of green spaces in the city.\n\n"
    //       "The graduation project of architect Mohamed Hammad, a graduate of the Department of Architecture, qualified for the final list in the competition, and his project was supervised by Dr. Diala Al-Tarawneh.\n\n"
    //       "The Department of Architecture extends its congratulations to Bushra Attia and Mohamed Hammad and their supervisors for this achievement.\n\n"
    //       "With best wishes for success to all students of the Department of Architecture",
    //   contentAR:
    //       "أحرزت المهندسة المعمارية بشرى عطية خريجة قسم هندسة العمارة في الجامعة الأردنية المركز الثالث في مسابقة نقابة المهندسين الأردنيين لمشاريع التخرج المعمارية لعام 2022"
    //       "مشروع التخرج الذي أشرف عليه الأستاذ الدكتور سليم دحابرة كان بعنوان إيكوتون."
    //       "وعن مشروعها قالت المهندسة بشرى: إيكوتون هو مشروع يطمح إلى توفير المحاصيل الزراعية في العاصمة عمان لتلبية احتياجات سكانها عن طريق توظيف تكنولوجيا الزراعة الرأسية، مما يساهم أيضًا في تعزيز مفهوم والاستدامة والزراعة الحضرية  ونشر الوعي حولها، كما و يهدف المشروع إلى إعادة إحياء الأراضي غير المستغلة و تحويلها إلى رئة و متنفس في ظل غياب المساحات الخضراء في المدينة."
    //       "كما تأهل مشروع التخرج للمهندس المعماري محمد حماد خريج قسم هندسة العمارة للقائمة النهائية في المسابقة وكان مشروعه بإشراف الدكتورة ديالا الطراونة."
    //       "وقسم هندسة العمارة يتقدم بالتهنئة لكل من بشرى عطية ومحمد حماد ومشرفيهم على هذا الإنجاز."
    //       "مع أطيب الأمنيات بالتوفيق لكل طلبة قسم هندسة العمارة",
    //   urlImage: "assets/images/Urduniyah.jpg",
    //   collegeName: "School of Engineering",
    //   id: 79,
    //   audioFileEN: "assets/audio/79en.mp3",
    //   audioFileAR: "assets/audio/79ar.mp3",
    // ),
    // NewsDataModel(
    //   title: "A workshop in architecture in cooperation with European projects",
    //   titleAR: "ورشة عمل في العمارة بالتعاون مع المشاريع الأوروبية",
    //   content:
    //       "The Department of Architecture held a workshop in cooperation with the European Projects Unit at the University of Jordan.\n\n"
    //       "The workshop, which aims to apply sustainable architecture solutions, included a practical application of gray water reuse and the idea of a green wall in residential buildings.\n\n"
    //       "The workshop was attended by Prof. Ahmed Al-Salaymeh, the project manager and a number of engineers from Italy, and the head of the Architectural Engineering Department, Prof. Dr. Nabil Kurdi and a number of faculty members and students.",
    //   contentAR:
    //       "أقام قسم هندسة العمارة  ورشة عمل بالتعاون مع وحدة المشاريع الأوروبية في الجامعة الأردنية"
    //       "ورشة العمل التي تهدف إلى تطبيق حلول العمارة المستدامة، تضمنت تطبيقا عمليا على إعادة استخدام المياه الرمادية  وفكرة الحائط الأخضر في المباني السكنية"
    //       "حضر الورشة أ.د. أحمد السلايمة مدير المشروع وعدد من المهندسين من إيطاليا ورئيس قسم هندسة العمارة أ.د. نبيل الكردي وعدد من أعضاء الهيئة التدريسية والطلبة .",
    //   urlImage: "assets/images/European.jpeg",
    //   collegeName: "School of Engineering",
    //   id: 80,
    //   audioFileEN: "assets/audio/80en.mp3",
    //   audioFileAR: "assets/audio/80ar.mp3",
    // ),
    //
    // NewsDataModel(
    //   title: "Holding a lecture for college students about preparing a CV",
    //   titleAR: "عقد محاضرة لطلبة الكلية حول اعداد السيرة الذاتية",
    //   content:
    //       "The College of Agriculture hosted Eng. Maryam Abu Nahla, who gave a lecture to the college students on how to prepare a CV and what are the basic pillars that should be mentioned in the CV, and indicated the mistakes that should be avoided when preparing the CV.\n",
    //   contentAR:
    //       "قامت كلية الزراعة باستضافة المهندسة مريم ابو نحلة والتي قامت بإعطاء محاضرة لطلبة الكلية حول كيفية اعداد السيرة الذاتية وماهي الركائز الاساسية التي يجب ذكرها في السيرة الذاتية واشارت الى الاخطاء التي يجب تجنبها عند إعداد السيرة الذاتية.",
    //   urlImage: "assets/images/CV.jpeg",
    //   collegeName: "School of Agriculture",
    //   id: 81,
    //   audioFileEN: "assets/audio/81en.mp3",
    //   audioFileAR: "assets/audio/81ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The College of Agriculture holds a practical training day at the Botanical Garden in Shafa Badran",
    //   titleAR:
    //       "كلية الزراعة تقيم يوما تدريبيا عمليا في الحديقة النباتية في شفا بدران",
    //   content:
    //       "As part of the College of Agriculture's celebrations of the golden jubilee of its founding, the Botanical Garden in Shafa Badran of the University of Jordan held a practical training day under the auspices of the Dean of the College, Professor Dr. Safwan Al-Shayyab, and with the coordination of Dr. Munther Al-Tahat, Assistant Dean for Agricultural Stations, and the presence of a number of faculty and administrative staff members, with the participation of field training students. in plant protection.\n\n"
    //       "During which the participants planted a large number of olive trees in the recently reclaimed areas of the botanical garden in order to activate the role of the botanical garden in Shafa Badran in serving the teaching and training process in the future.\n\n"
    //       "At the end of the visit, the students were introduced to a number of insect pests that attack olive and fig trees in the botanical garden.",
    //   contentAR:
    //       "​ضمن إحتفالات كلية الزراعة باليوبيل الذهبي لتأسيسها، أقامت الحديقة النباتية في شفا بدران التابعة للجامعة الأردنية يوما تدريبيا عمليا تحت رعاية عميد الكلية الأستاذ الدكتور صفوان الشياب و بتنسيق من الدكتور منذر الطاهات مساعد العميد للمحطات الزراعية وحضور عدد من أعضاء الهيئة التدريسية والإدارية وبمشاركة طلاب التدريبات الحقلية في وقاية النبات."
    //       "قام خلالها المشاركون بغرس عدد كبير من  أشجار الزيتون في مناطق الحديقة النباتية التي تم استصلاحها مؤخرا وذلك لتفعيل دور الحديقة النباتية في شفا بدران في خدمة العملية التدريسية والتدريبية مستقبلا."
    //       "وفي نهاية الزيارة تم تعريف الطلبة على عدد من الافات الحشرية التي تهاجم اشجار الزيتون والتين في الحديقة النباتية.",
    //   urlImage: "assets/images/Shafa.jpeg",
    //   collegeName: "School of Agriculture",
    //   id: 82,
    //   audioFileEN: "assets/audio/82en.mp3",
    //   audioFileAR: "assets/audio/82ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Specialists visit the college within the international program for academic mobility, Erasmus",
    //   titleAR:
    //       "زيارة مختصين للكلية ضمن البرنامج الدولي للحراك الأكاديمي Erasmus",
    //   content:
    //       "The College of Agriculture hosted two academics from Josip Juraj Strossmayer University of Osijek from Croatia within the International Academic Mobility Program (Erasmus + international credit mobility).\n\n"
    //       "Where several meetings were held with faculty members in the college to exchange advice and experiences, in addition to that, two lectures were held attended by a number of bachelor's and master's students and faculty members from the College of Agriculture in addition to engineers from the private sector. The Seminars Committee in the Horticulture Department Organized by Dr. Alka Turalija, Professor of Landscaping, entitled 'Landscape types in Croatia and EU Legislative in Landscape Protection' at 8:30 am on Monday 05/15/2023, then the Seminars Committee of the Plant Protection Department organized A lecture by Dr. Edita Stefanic, Professor of Herbology, entitled 'Economic threshold in weed management', at 12:30 p.m. on Tuesday 05/16/2023.\n\n"
    //       "The visit and lectures were coordinated by Dr. Kholoud Al-Anabah and d. Malik Al-Ajlouni, in coordination with the International Affairs Unit at the University of Jordan.",
    //   contentAR:
    //       "أستضافت كلية الزراعة أكاديميتان من جامعة Josip Juraj Strossmayer University of Osijek من دولة كرواتيا ضمن البرنامج الدولي للحراك الأكاديمي  (Erasmus + international credit mobility)."
    //       "حيث تم عقد عدة اجتماعات مع أعضاء هيئة التدريس في الكلية لتبادل المشورة و الخبرات، بالإضافة إلى ذلك تم عقد محاضرتين حضرها عدد من طلبة البكالوريوس والماجستير و أعضاء من هيئة التدريس من كلية الزراعة بالإضافة الى مهندسين من القطاع الخاص، و قامت لجنة الندوات في قسم البستنة بتنظيم محاضرة من قِبل الدكتورة Alka Turalija أستاذة تنسيق المواقع بعنوان 'Landscape types in Croatia and EU Legislative in Landscape Protection' وذلك في تمام الساعة 8:30 من صباح يوم الأثنين الموافق 15/05/2023، ثم قامت لجنة الندوات في قسم وقاية النبات بتنظيم محاضرة  للدكتورة Edita Stefanic أستاذة علم الأعشاب بعنوان ‘Economic threshold in weed management’ وذلك في تمام الساعة 12:30 من ظهر يوم الثلاثاء الموافق 16/05/2023."
    //       "قام بتنسيق الزيارة والمحاضرات كل من د. خلود العنانبه و د. مالك العجلوني بالتنسيق مع وحدة الشؤون الدولية في الجامعة الأردنية.",
    //   urlImage: "assets/images/Erasmus.jpeg",
    //   collegeName: "School of Agriculture",
    //   id: 83,
    //   audioFileEN: "assets/audio/83en.mp3",
    //   audioFileAR: "assets/audio/83ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "A lecture on cultivation using alternative pollinators was held in the Plant Protection Department",
    //   titleAR:
    //       "عقد محاضرة الزراعة باستخدام الملقحات البديلة في قسم وقاية النبات",
    //   content:
    //       "The Seminars Committee in the Plant Protection Department, in coordination with Dr. Wissam Obeidat organized a lecture by Dr. Stephanie Christman from the International Center for Agricultural Research in the Dry Areas (ICARDA) entitled: Farming with Alternative Pollinator, at 1:30 pm on Wednesday, 05/17/2023, in the grand amphitheater of the Faculty of Agriculture/University of Jordan. The invitation was public and was attended by students from the bachelor's and master's levels, as well as faculty members from the College of Agriculture.\n",
    //   contentAR:
    //       "قامت لجنة الندوات في قسم وقاية النبات وبالتنسيق مع د. وسام عبيدات بتنظيم محاضرة من قبل الدكتورة ستيفاني كريستمان من المركز الدولي للبحوث الزراعية في المناطق الجافة (إيكاردا) بعنوان: Farming with Alternative Pollinator وذلك في تمام الساعة 1:30 من بعد ظهر يوم الأربعاء الموافق 2023/05/17، في المدرج الكبير في كلية الزراعة/الجامعة الأردنية. الدعوة كانت عامة و حضر بها طلاب من مرحلة البكالوريوس والماجستير و اعضاء هيئة التدريس من كلية الزراعة.",
    //   urlImage: "assets/images/Plant.jpeg",
    //   collegeName: "School of Agriculture",
    //   id: 84,
    //   audioFileEN: "assets/audio/84en.mp3",
    //   audioFileAR: "assets/audio/84ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The French ambassador to Jordan visits the Faculty of Science at the University of Jordan",
    //   titleAR: "السفير الفرنسي في الأردن يزور كلية العلوم في الجامعة الأردنية",
    //   content:
    //       "The Dean of the Faculty of Science at the University of Jordan, Dr. Mahmoud Al-Jaghoub, received today, in the presence of the University Vice President for Scientific Faculties Affairs, Dr. Ashraf Abu Karaki, the Ambassador of the Republic of France to Jordan, Alexis Le Coeur Granmaison, who was accompanied by the cultural attaché, Gilles Rowland, and the attaché for scientific and university cooperation, Billy Troy.\n\n"
    //       "During the meeting, which took place in the presence of a number of faculty members at the college and university, opportunities for scientific and academic cooperation between the University of Jordan and French universities in the fields of postgraduate studies and scientific research, exchange of researchers and students, and conducting joint research were discussed.\n\n"
    //       "During his speech, Abu Karaki appreciated the support provided by the embassy to the university, which indicates the good relations between UJ and the embassy, expressing the university's welcome to expand joint cooperation in the field of scientific research.\n\n"
    //       "In turn, the Dean of the Faculty of Science, Dr. Mahmoud Al-Jaghoub, indicated that the faculty serves approximately 24,000 students at the university, where basic scientific subjects are taught to all students of scientific disciplines, stressing that the faculty welcomes any possible cooperation with its counterparts from French universities.\n\n"
    //       "Professor of Chemistry at the college, Dr. Ramia Al-Baqain, gave a presentation that included information about the college in general and the Department of Chemistry in particular, including past and current international cooperation projects implemented by the department in cooperation with French universities and research institutions.\n\n"
    //       "For his part, the ambassador affirmed the depth of the joint relations, and his country's desire to expand cooperation between higher education institutions in the two friendly countries, praising the efforts of the researchers in the college, and praising Dr. Al-Baqain's scientific and academic excellence.",
    //   contentAR:
    //       "استقبل عميد كلية العلوم في الجامعة الأردنية الدكتور محمود الجاغوب اليوم، بحضور نائب رئيس الجامعة لشؤون الكليات العلمية الدكتور أشرف أبو كركي، سفير جمهورية فرنسا لدى الأردن أليكسي لو كوور غرانميزون الذي رافقه الملحق الثقافي جيليس رولاند والملحق للتعاون العلمي والجامعي بيلي تروي."
    //       "وبُحثت خلال اللقاء، الذي جرى بحضور عدد من أعضاء الهيئة التدريسية في الكلية والجامعة، فرص التعاون العلمي والأكاديمي بين الجامعة الأردنيّة والجامعات الفرنسية في مجالات الدراسات العليا والبحث العلمي وتبادل الباحثين والطلبة وإجراء البحوث المشتركة."
    //       "وثمّن أبو كركي خلال حديثه الدعم الذي تقدمه السفارة للجامعة، الأمر الذي يدل على طيبة العلاقات بين الأردنية والسفارة، مُبديًا ترحيب الجامعة بتوسيع التعاون المشترك في مجال البحث العلمي."
    //       "بدوره، أشار عميد كلية العلوم الدكتور محمود الجاغوب إلى أن الكلية تخدم ما يقارب 24 ألف طالب في الجامعة، حيث تُدرّس المواد العلمية الأساسية لجميع طلبة التخصصات العلمية، مؤكّدًا ترحيب الكلية بأي تعاون ممكن مع نظيراتها من الجامعات الفرنسية."
    //       "وقدّمت أستاذة الكيمياء في الكلية الدكتورة راميا البقاعين عرضًا شمل معلومات حول الكلية بشكل عام وقسم الكيمياء بشكل خاص، بما في ذلك مشاريع التعاون الدولي السابقة والحالية التي ينفذها القسم بالتعاون مع جامعات ومؤسسات بحثية فرنسية."
    //       "من جهته، أكد السفير عمق العلاقات المشتركة، ورغبة بلاده في توسيع التعاون بين مؤسسات التعليم العالي في البلدين الصديقين، مثنيًا على جهود الباحثين في الكلية، ومشيدًا بتميز الدكتورة البقاعين العلمي والأكاديمي.",
    //   urlImage: "assets/images/French.jpeg",
    //   collegeName: "School of Science",
    //   id: 85,
    //   audioFileEN: "assets/audio/85en.mp3",
    //   audioFileAR: "assets/audio/85ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "The deans of the Jordanian University decide to appoint the scientist Omar Yaghi as an honorary professor in the Department of Chemistry at the College of Science",
    //   titleAR:
    //       "عمداء الأردنية يقرر تعيين العالم عمر ياغي أستاذا فخريا في قسم الكيمياء في كلية العلوم",
    //   content:
    //       "The University of Jordan’s Deans’ Council decided to appoint Dr. Omar Yaghi as an honorary professor in the Department of Chemistry at the College of Science, in appreciation of his prestigious scientific achievements, which are of great importance in the world.\n\n"
    //       "This decision of the Council comes within the directions of the University of Jordan to attract distinguished professors and scholars to join it, as emeritus professors, practitioners, or experts, to benefit from their great experience, which will narrow the gap between the academic product and the requirements of the labor market and the local and international community.\n\n"
    //       "Yaghi previously obtained a Ph.D. in chemistry from the University of Illinois at Urbana-Champaign in the United States of America, and has published 352 research papers in specialized international journals to date, and the number of times his scientific research has been cited has reached 178,554, according to the Scopus database.\n\n"
    //       "Yaghi is one of the most influential scientists in the world in the field of chemistry, ranking second in the world according to Thompson Reuters in 2011. He is currently a professor in the Department of Chemistry at the University of California, Berkeley, and is the founding director of the Science Institute. The university's global university, which is concerned with establishing research centers in developing countries and provides research and training opportunities, for newly graduated researchers in particular.\n\n"
    //       "His research work includes the synthesis and structuring of organic and inorganic materials and the study of their chemical properties, in addition to the design and construction of crystalline materials. He is also a pioneer in the manufacture of many new materials, including metal-organic frameworks and covalent organic frameworks. and others. These materials are characterized by very large surface areas, the largest of which is not known to this day, which enables them to store hydrogen and methane gases, in addition to the possibility of using them for water harvesting in the desert.\n\n"
    //       "It is noteworthy that Yaghi was elected a member of the US National Academy of Sciences (2019), the German National Academy of Sciences (2022), and the American Academy of Sciences (2022), and he was honored with many scientific awards, including: the Italian Chemical Society Medal (2004), the Materials Science Research Complex Medal (2007), Royal Society Centenary Prize for Chemistry (2010), King Faisal International Prize for Science (2015), Albert Einstein International Prize for Science.\n",
    //   contentAR:
    //       "قرر مجلس عمداء الجامعة الأردنية تعيين الدكتور عمر ياغي أستاذًا فخريا في قسم الكيمياء في كلية العلوم، وذلك تقديرًا لإنجازاته العلمية المرموقة التي تتميز بأهميتها الكبيرة على مستوى العالم."
    //       "ويأتي قرار المجلس هذا ضمن توجهات الجامعة الأردنية لجذب الأساتذة والعلماء المتميزين لينضموا إليها، بصفتهم أساتذة فخريين أو ممارسين أو خبراء، للاستفادة من تجربتهم الكبيرة التي ستعمل على تضييق الفجوة بين المنتج الأكاديمي ومتطلبات سوق العمل والمجتمع المحلي والدولي."
    //       "وسبق لياغي أن حصل على شهادة الدكتوراه في الكيمياء من جامعة جامعة إلينوي في إربانا-شامبين في الولايات المتحدة الأمريكية، ونشر 352 بحثًا في مجلات عالمية متخصصة حتى هذا التاريخ، وقد وصل عدد مرّات الاستشهاد بأبحاثه العلمية إلى 178554 استشهادًا، حسب قاعدة بيانات سكوبس."
    //       "ويُعدّ ياغي واحدًا من أكثر العلماء المؤثرين على مستوى العالم في مجال الكيمياء، حيث حلّ في المرتبة الثانية على مستوى العالم حسب تصنيف تومسون رويترز (Thompson Reuters) عام 2011، ويعمل حاليًّا أستاذًا في قسم الكيمياء في جامعة كاليفورنيا، بيركلي، وهو المدير المؤسس لمعهد العلوم العالمي في الجامعة، والذي يُعنى بإنشاء مراكز بحثية في الدول النامية ويوفر فرصًا بحثية وتدريبية، للباحثين حديثي التخرج على وجه الخصوص."
    //       "وتشمل أعماله البحثية تركيب وهيكلة المواد العضوية وغير العضوية ودراسة خصائصها الكيميائية، إضافة إلى تصميم وبناء مواد بلورية، كما يُعدّ رائدًا في تصنيع عديد من المواد الجديدة، منها الأطر العضوية المعدنية (Metal-Organic Frameworks)، والأطر العضوية التساهمية (Covalent Organic Frameworks)، وغيرها. وتتميز هذه المواد بمساحات سطحية كبيرة جدا لم يُعرف أكبر منها حتى يومنا هذا، ما يُمكّنها من تخزين غازات الهيدروجين والميثان، إضافة إلى إمكانية استخدامها للحصاد المائي في الصحراء."
    //       "ويُذكر أنّ ياغي انتُخب عضوًا في الأكاديمية الوطنية الأمريكية للعلوم (2019)، والأكاديمية الوطنية الألمانية للعلوم (2022)، والأكاديمية الأمريكية للعلوم (2022)، كما كُرّم بجوائز علمية عديدة، منها: ميدالية المجمع الكيميائي الإيطالي (2004)، ميدالية مجمع بحوث علم المواد (2007)، جائزة الجمعية الملكية المئوية للكيمياء (2010)، جائزة الملك فيصل العالمية للعلوم (2015)، جائزة آلبرت أينشتاين الدولية للعلوم.",
    //   urlImage: "assets/images/Yaghi.jpg",
    //   collegeName: "School of Science",
    //   id: 86,
    //   audioFileEN: "assets/audio/86en.mp3",
    //   audioFileAR: "assets/audio/86ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Charity breakfast for children at the University of Jordan, Faculty of Science",
    //   titleAR: "إفطار خيري للأطفال في الجامعة الأردنية كلية العلوم",
    //   content:
    //       "The Faculty of Science at the University of Jordan, at the initiative of Nashama Al-Ulum, held a charity Ramadan Iftar for a number of children, in the presence of the Dean of the Faculty of Science, Prof. Dr. Mahmoud Al-Jaghoub, in the science yards between the old Chemistry Building and the Geology Building.\n",
    //   contentAR:
    //       "أقامت كلية العلوم في الحامعة الأردنية وبمبادرة من نشامى العلوم إفطار رمضاني خيري لعدد من الاطفال وذلك بحضور عميد كلية العلوم الاستاذ الدكتور محمود الجاغوب في ساحات العلوم بين مبنى الكيمياء القديم ومبنى الجيولوجيا.",
    //   urlImage: "assets/images/children.jpeg",
    //   collegeName: "School of Science",
    //   id: 87,
    //   audioFileEN: "assets/audio/87en.mp3",
    //   audioFileAR: "assets/audio/87ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Announcement for doctors applying for higher specialization programs in medicine for the academic year 2023/2024",
    //   titleAR:
    //       "اعلان للاطباء المتقدمين لبرامج الاختصاص العالي في الطب للعام الجامعي 2023/2024",
    //   content:
    //       "The College of Graduate Studies announces that physicians applying for higher specialization programs in medicine for the academic year 2023/2024, whose names are listed below, must apply for the written admission exam, which is scheduled to be held on Monday, 5/8/2023 at 10:00 am.\n\n"
    //       "The mechanism of conducting the entrance exam for the higher specialization\n\n"
    //       "1- The exam will be held on its scheduled date on Monday 8/5/2023 at exactly ten o’clock in the morning (10:00).\n\n"
    //       "2- You must come half an hour before the exam time\n\n"
    //       "3- Go directly to the examination hall and sit in the designated seat.\n\n"
    //       "4- It is forbidden to gather outside the halls before and after the exam.\n\n"
    //       "5- When entering the exam hall, the cell phone is closed and placed on the table in the hall in front of the seats, and the student takes it at the end of the exam\n\n"
    //       "6- It is forbidden to bring any (electronic device, smart watches, computers, headphones).\n\n",
    //   contentAR:
    //       "تعلن كلية الدراسات العليا على الأطباء المتقدمين لبرامج الاختصاص العالي في الطب للعام الجامعي 2023/2024 المدرجة اسماؤهم ادناه التقدم لامتحان القبول الكتابي والمقرر عقده يوم الأثنين الموافق 8/5/2023 في تمام الساعة 10 صباحاً."
    //       "\nآلية إجراء امتحان القبول للاختصاص العالي"
    //       "1- سيتم عقد الامتحان في موعده المحدد يوم الاثنين الموافق 8/5/2023 في تمام الساعة العاشرة صباحاً (10:00)."
    //       "2- يجب الحضور قبل نصف ساعة من موعد الامتحان."
    //       "3- التوجه مباشرة إلى قاعة الامتحان والجلوس في المقعد المخصص."
    //       "4- يمنع التجمع خارج القاعات قبل وبعد الامتحان."
    //       "5- عند دخول قاعة الامتحان يتم إغلاق الهاتف الخلوي ووضعه على الطاولة الموجودة في القاعة أمام المقاعد ويأخذه الطالب عند نهاية الامتحان."
    //       "6- يمنع إحضار أي (جهاز إلكتروني، الساعات الذكية، الحاسبات، السماعات).",
    //   urlImage: "assets/images/edu.png",
    //   collegeName: "School of Graduate Studies",
    //   id: 88,
    //   audioFileEN: "assets/audio/88en.mp3",
    //   audioFileAR: "assets/audio/88ar.mp3",
    // ),
    // NewsDataModel(
    //   title:
    //       "Announcement for non-Jordanian doctors applying for higher specialization programs in oral and maxillofacial surgery, oral and maxillofacial medicine, and dentistry for people with special needs for the academic year 2023/2024",
    //   titleAR:
    //       "اعلان للاطباء غير الأردنيين المتقدمين لبرامج الاختصاص العالي في جراحة الفم والفكين وطب الفم والفكين وطب الاسنان لذوي الإحتياجات الخاصه للعام الجامعي 2023/2024",
    //   content:
    //       "The Faculty of Postgraduate Studies announces to non-Jordanian doctors applying for the higher specialization programs in Oral and Maxillofacial Surgery and Oral and Maxillofacial Medicine for people with special needs for the academic year 2023/2024, whose names are listed below, to apply for the written admission exam, which is scheduled to be held on Wednesday, 10/5/2023 in the laboratory of the Scientific Halls Complex, and according to the times Next, 10:00-12:00 am for the specialization of oral and maxillofacial medicine and dentistry for people with special needs, and from 1:00 pm-3:00 pm for the specialty of oral and maxillofacial surgery.\n\n"
    //       "Arrive half an hour before the exam time.\n\n"
    //       "Each applicant must bring his own passport with him.\n\n"
    //       "Gathering outside the halls before and after the exam is prohibited.\n\n"
    //       "When entering the exam hall, the cell phone is closed and placed on the table in the hall in front of the seats, and the student takes it at the end of the exam.\n\n"
    //       "It is forbidden to bring any (electronic device, smart watches, computers, headphones).\n\n",
    //   contentAR:
    //       " تعلن كلية الدراسات العليا للاطباء غير الأردنيين المتقدمين لبرنامجي الاختصاص العالي في جراحة الفم والفكين وطب الفم والفكين لذوي الإحتياجات الخاصه للعام الجامعي 2023/2024 المدرجة اسماؤهم ادناه التقدم لامتحان القبول الكتابي والمقرر عقده يوم الأربعاء الموافق 10/5/2023 في مختبر مجمع القاعات العلمية وحسب الأوقات التالية، 10:00-12:00 صباحاً لتخصص طب الفم والفكين وطب الاسنان لذوي الاحتياجات الخاصة، ومن الساعه 1:00 ظهراً-3:00 بعد الظهر لتخصص جراحة الفم والفكين."
    //       "الحضور قبل موعد الامتحان بنصف ساعة."
    //       " على كل متقدم أن يحضر معه جواز السفر الخاص به."
    //       "يمنع التجمع خارج القاعات قبل وبعد الامتحان."
    //       "عند دخول قاعة الامتحان يتم إغلاق الهاتف الخلوي ووضعه على الطاولة الموجودة في القاعة أمام المقاعد ويأخذه الطالب عند نهاية الامتحان."
    //       "يمنع إحضار أي (جهاز إلكتروني، الساعات الذكية، الحاسبات، السماعات).",
    //   urlImage: "assets/images/edu2.png",
    //   collegeName: "School of Graduate Studies",
    //   id: 89,
    //   audioFileEN: "assets/audio/89en.mp3",
    //   audioFileAR: "assets/audio/89ar.mp3",
    // ),
  ];
  List<NewsDataModel> collegeData = [];
  List<NewsDataModel> universityNews = [];
  List<NewsDataModel> notifications = [];
  List<NewsDataModel> savedNews = [];

  onTapSaveNews({required List<NewsDataModel> newsList, required int index}) {
    int newsIndex =
        savedNews.indexWhere((element) => element.id == newsList[index].id);
    if (newsIndex == -1) {
      savedNews.add(newsList[index]);
    } else {
      savedNews.removeAt(newsIndex);
    }

    update();
  }

  isSaveNews({required List<NewsDataModel> newsList, required int index}) {
    int newsIndex =
        savedNews.indexWhere((element) => element.id == newsList[index].id);
    if (newsIndex == -1) {
      return false;
    } else {
      return true;
    }
  }
}
// List<dynamic> colleges = [
//   CollegeModel(name: "School of Arts", nameAR: "كلية الآداب", image: "assets/images/artsCollege.jfif", logo: "assets/images/art.png",),
//   CollegeModel(name: "School of Archaeology and Tourism", nameAR: "كلية الآثار والسياحة", image: "assets/images/archaeologyAndTourismCollege.jfif", logo: "assets/images/tou.png",),
//   CollegeModel(name: "School of Foreign Languages", nameAR: "كلية اللغات الأجنبية", image: "assets/images/foreignLanguagesCollege.jfif", logo: "assets/images/lan.png", ),
//   CollegeModel(name: "School of International Studies", nameAR: "كلية الأمير حسين بن عبدالله الثاني للدراسات الدولية", image: "assets/images/internationalStudiesCollege.jfif", logo: "assets/images/inter.png",),
//   CollegeModel(name: "School of Arts and Design", nameAR: "كلبة الفنون والتصميم", image: "assets/images/artsAndDesignCollege.jfif", logo: "assets/images/des.png", ),
//   CollegeModel(name: "School of Sport Science", nameAR: "كلية علوم الرياضة", image: "assets/images/sportCollege.jfif", logo: "assets/images/spo.png", ),
//   CollegeModel(name: "School of Law", nameAR: "كلية الحقوق", image: "assets/images/lawCollege.jfif", logo: "assets/images/law.png",),
//   CollegeModel(name: "School of Educational Sciences", nameAR: "كلية العلوم التربوية", image: "assets/images/educationalSciencesCollege.jfif", logo: "assets/images/educ.png", ),
//   CollegeModel(name: "School of Sharia", nameAR: "كلية الشريعة", image: "assets/images/shareaCollege.jfif", logo: "assets/images/sharia2.png", ),
//   CollegeModel(name: "School of Business", nameAR: "كلية الأعمال", image: "assets/images/businessCollege.jfif", logo: "assets/images/bu2.png",),
//   CollegeModel(name: "School of Medicine", nameAR: "كلية الطب", image: "assets/images/medicineCollege.jfif", logo: "assets/images/mec.png", ),
//   CollegeModel(name: "School of Rehabilitation Sciences", nameAR: "كلية علوم التأهيل", image: "assets/images/RehabilitationCollege.jfif", logo: "assets/images/rena.png",),
//   CollegeModel(name: "School of Dentistry", nameAR: "كلية طب الأسنان", image: "assets/images/dentistryCollege.jfif", logo: "assets/images/dest.png", ),
//   CollegeModel(name: "School of Pharmacy", nameAR: "كلية الصيدلة", image: "assets/images/pharmacyCollege.jfif", logo: "assets/images/phar.png", ),
//   CollegeModel(name: "School Of Nursing", nameAR: "كلية التمريض", image: "assets/images/nursingCollege.jfif", logo: "assets/images/ners.png", ),
//   CollegeModel(name: "School of Information Technology", nameAR: "كلية الملك عبدالله الثاني لتكنولوجيا المعلومات", image: "assets/images/itCollege.jfif", logo: "assets/images/itlog.png", ),
//   CollegeModel(name: "School of Engineering", nameAR: "كلية الهندسة", image: "assets/images/engCollege.jfif", logo: "assets/images/eng.png", ),
//   CollegeModel(name: "School of Agriculture", nameAR: "كلية الزراعة", image: "assets/images/AgricultureCollege.jfif", logo: "assets/images/ach.png",),
//   CollegeModel(name: "School of Science", nameAR: "كلية العلوم", image: "assets/images/scienceCollege.jfif", logo: "assets/images/sci.png", ),
//   CollegeModel(name: "School of Graduate Studies", nameAR: "كلية الدراسات العليا", image: "assets/images/graduateStudiesCollege.jfif", logo: "assets/images/grad.jfif", ),
// ];

// CollegeModel(name: "School of Arts", nameAR: "كلية الآداب", image: "assets/images/artsCollege.jfif", logo: "assets/images/art.png",),
// CollegeModel(name: "School of Archaeology and Tourism", nameAR: "كلية الآثار والسياحة", image: "assets/images/archaeologyAndTourismCollege.jfif", logo: "assets/images/tou.png",),
// CollegeModel(name: "School of Foreign Languages", nameAR: "كلية اللغات الأجنبية", image: "assets/images/foreignLanguagesCollege.jfif", logo: "assets/images/lan.png", ),
// CollegeModel(name: "School of International Studies", nameAR: "كلية الأمير حسين بن عبدالله الثاني للدراسات الدولية", image: "assets/images/internationalStudiesCollege.jfif", logo: "assets/images/inter.png",),
// CollegeModel(name: "School of Arts and Design", nameAR: "كلبة الفنون والتصميم", image: "assets/images/artsAndDesignCollege.jfif", logo: "assets/images/des.png", ),
// CollegeModel(name: "School of Sport Science", nameAR: "كلية علوم الرياضة", image: "assets/images/sportCollege.jfif", logo: "assets/images/spo.png", ),
// CollegeModel(name: "School of Law", nameAR: "كلية الحقوق", image: "assets/images/lawCollege.jfif", logo: "assets/images/law.png",),
// CollegeModel(name: "School of Educational Sciences", nameAR: "كلية العلوم التربوية", image: "assets/images/educationalSciencesCollege.jfif", logo: "assets/images/educ.png", ),
// CollegeModel(name: "School of Sharia", nameAR: "كلية الشريعة", image: "assets/images/shareaCollege.jfif", logo: "assets/images/sharia2.png", ),
// CollegeModel(name: "School of Business", nameAR: "كلية الأعمال", image: "assets/images/businessCollege.jfif", logo: "assets/images/bu2.png",),
// CollegeModel(name: "School of Medicine", nameAR: "كلية الطب", image: "assets/images/medicineCollege.jfif", logo: "assets/images/mec.png", ),
// CollegeModel(name: "School of Rehabilitation Sciences", nameAR: "كلية علوم التأهيل", image: "assets/images/RehabilitationCollege.jfif", logo: "assets/images/rena.png",),
// CollegeModel(name: "School of Dentistry", nameAR: "كلية طب الأسنان", image: "assets/images/dentistryCollege.jfif", logo: "assets/images/dest.png", ),
// CollegeModel(name: "School of Pharmacy", nameAR: "كلية الصيدلة", image: "assets/images/pharmacyCollege.jfif", logo: "assets/images/phar.png", ),
// CollegeModel(name: "School Of Nursing", nameAR: "كلية التمريض", image: "assets/images/nursingCollege.jfif", logo: "assets/images/ners.png", ),
// CollegeModel(name: "School of Information Technology", nameAR: "كلية الملك عبدالله الثاني لتكنولوجيا المعلومات", image: "assets/images/itCollege.jfif", logo: "assets/images/itlog.png", ),
// CollegeModel(name: "School of Engineering", nameAR: "كلية الهندسة", image: "assets/images/engCollege.jfif", logo: "assets/images/eng.png", ),
// CollegeModel(name: "School of Agriculture", nameAR: "كلية الزراعة", image: "assets/images/AgricultureCollege.jfif", logo: "assets/images/ach.png",),
// CollegeModel(name: "School of Science", nameAR: "كلية العلوم", image: "assets/images/scienceCollege.jfif", logo: "assets/images/sci.png", ),
// CollegeModel(name: "School of Graduate Studies", nameAR: "كلية الدراسات العليا", image: "assets/images/graduateStudiesCollege.jfif", logo: "assets/images/grad.jfif", ),
