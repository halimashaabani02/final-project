import 'dart:math';

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizLevel {
  final String description;
  final String icon;
  final List<Question> questions;
  final int passingScore;

  QuizLevel({
    required this.description,
    required this.icon,
    required this.questions,
    required this.passingScore,
  });
}

class QuizData {
  static List<QuizLevel> getLevels() {
    return [
      // Level 1: Ujuzi Msingi wa Afya ya Akili
      QuizLevel(
        description: 'Jaribu ujuzi wako wa msingi wa afya ya akili',
        icon: '🧠',
        passingScore: 5,
        questions: [
          Question(
            question: 'Afya ya akili ni nini?',
            options: [
              'Kutougua maradhi ya akili',
              'Hali kamili ya kiafya, kiakili na kijamii',
              'Kuwa na furaha kila wakati',
              'Kutopata stress kamwe'
            ],
            correctAnswerIndex: 1,
            explanation: 'Afya ya akili ni hali kamili ya kiafya, kiakili na kijamii, si tu ukosefu wa maradhi.',
          ),
          Question(
            question: 'Dalili gani ni za kawaida za wasiwasi?',
            options: [
              'Nguvu zaidi',
              'Moyo unapiga haraka na kutokwa na jasho',
              'Uwezo bora wa kuzingatia',
              'Usingizi mzuri'
            ],
            correctAnswerIndex: 1,
            explanation: 'Moyo unapiga haraka, kutokwa jasho na kutokuwa na utulivu ni dalili za kawaida za wasiwasi.',
          ),
          Question(
            question: 'Stigma katika afya ya akili inamaanisha nini?',
            options: [
              'Aina ya tiba',
              'Mawazo hasi na imani mbaya kuhusu maradhi ya akili',
              'Athari ya dawa',
              'Njia ya kupambana na shida'
            ],
            correctAnswerIndex: 1,
            explanation: 'Stigma ni mawazo hasi, imbi na ubaguzi dhidi ya watu wanaougua maradhi ya akili.',
          ),
          Question(
            question: 'Shughuli gani ni nzuri zaidi kwa afya ya akili?',
            options: [
              'Kutazama TV siku nzima',
              'Mazoezi ya mara kwa mara ya mwili',
              'Kukula chakula kidogo',
              'Kujitenga na watu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Mazoezi ya mara kwa mara hutoa endorphins na huongeza afya ya akili.',
          ),
          Question(
            question: 'Jihadhari na nafsi yako ni nini?',
            options: [
              'Kujilenga mwenyewe',
              'Shughuli za kulinda na kuboresha afya yako',
              'Kutojali mahitaji ya wengine',
              'Shughuli za mwili tu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Jihadhari na nafsi ni shughuli zinazolinda na kuboresha afya yako ya mwili, akili na hisia.',
          ),
          Question(
            question: 'Watu wazima wanahitaji usingizi vya kiasi gani kwa afya ya akili?',
            options: [
              '4-5 masaa',
              '7-9 masaa',
              '10-12 masaa',
              'Usingizi hana athari kwa afya ya akili'
            ],
            correctAnswerIndex: 1,
            explanation: 'Watu wazima wanahitaji usingizi wa 7-9 masaa kwa afya bora ya akili na mwili.',
          ),
          Question(
            question: 'Njia gani ni afya ya kueleza hisia?',
            options: [
              'Kuzificha ndani',
              'Kuzungumza nazo na mtu unaemwamini',
              'Kuzipuuza kabisa',
              'Kueleza hisia chanya tu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kueleza hisia kwa afya ni kuzikubali na kuzungumza nazo na watu unaowaamini.',
          ),
        ],
      ),

      // Level 2: Wasiwasi wa Kijamii na Hofu ya Kuhukumiwa
      QuizLevel(
        description: 'Kuelewa wasiwasi wa kijamii na hofu ya kuhukumiwa',
        icon: '😰',
        passingScore: 7,
        questions: [
          Question(
            question: 'Unapokosea jambo dogo mbele za watu, kawaida unajisikiaje?',
            options: [
              'Najisikia vizuri na kujifunza kosa',
              'Najisikia vibaya sana na kujilaumu',
              'Sitajali kitu',
              'Nakasirikia watu walioniona'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujisikia vibaya na kujilaumu baada ya kosa dogo ni dalili ya kutojiamini na hofu ya kuhukumiwa.',
          ),
          Question(
            question: 'Dalili kuu za wasiwasi wa kijamii ni zipi?',
            options: [
              'Kupenda kukutana na watu wapya',
              'Kuhofu kukosewa na kukosolewa',
              'Kujisikia vizuri katika mikutano',
              'Kutamani kuwa katikati ya umati'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuhofu kukosewa na kukosolewa na watu wengine ni dalili kuu ya wasiwasi wa kijamii.',
          ),
          Question(
            question: 'Unapokuwa na hofu ya kusemwa, nini ni afya kufanya?',
            options: [
              'Kuepuka mikutano yote',
              'Kukubali watu wanaweza kukutoona sawa',
              'Kujaribu kuwa mtu mwingine',
              'Kukasirikia watu wote'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kukubali kuwa watu wanaweza kuwa na maoni tofauti ni njia ya afya ya kushinda hofu ya kuhukumiwa.',
          ),
          Question(
            question: 'Unapokosea kwenye kazi, mawazo gani ni chanya?',
            options: [
              'Nimefeli maisha yangu yote',
              'Hii ni fursa ya kujifunza',
              'Watu watanichukia sasa',
              'Sitafanya jaribu tena kamwe'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuona makosa kama fursa ya kujifunza ni mawazo chanya yanayosaidia ukuaji.',
          ),
          Question(
            question: 'Nini husababisha kujikosoa sana?',
            options: [
              'Kujiamini sana',
              'Kuhofu kukosewa na wengine',
              'Kupenda kujifunza',
              'Kuwa na marafika wengi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujikosoa sana mara nyingi hutokana na hofu ya kukosewa na kukosolewa na wengine.',
          ),
          Question(
            question: 'Kukumbuka makosa ya zamani mara nyingi husababisha nini?',
            options: [
              'Kujifunza na kusonga mbele',
              'Kujisikia vibaya na kujikosoa',
              'Kusahau mambo yote',
              'Kufurahi na maendeleo'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kukumbuka makosa ya zamani bila kujifunza humfanya mtu ajiskie vibaya na kujikosoa.',
          ),
          Question(
            question: 'Nini cha kufanya unapojisikia si mwenye maana?',
            options: [
              'Kukubali hisia hiyo na kujificha',
              'Kukumbuka mafanikio na uwezo wako',
              'Kulinganisha na watu wengine',
              'Kujihukumu zaidi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kukumbuka mafanikio yako na uwezo wako husaidia kupambana na hisia za kutokuwa na maana.',
          ),
        ],
      ),

      // Level 3: Kujilaumu na Hatia
      QuizLevel(
        description: 'Kuelewa mifumo ya kujilaumu na hisia za hatia',
        icon: '😔',
        passingScore: 5,
        questions: [
          Question(
            question: 'Unapokosea, kawaida unajibikiaje?',
            options: [
              'Najibika kiasi na kujifunza',
              'Najijibika kwa kila kitu',
              'Sitajibii kamwe',
              'Nawajibisha watu wengine'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujibika kwa kila kitu hata kile ambacho si kosa lako ni dalili ya kujilaumu kupita kiasi.',
          ),
          Question(
            question: 'Nini kinatofautisha kujibikia na kujilaumu?',
            options: [
              'Hakuna tofauti',
              'Kujibikia ni kufahamu wajumbe wako, kujilaumu ni kumchukia mwenyewe',
              'Kujilaumu ni chanya zaidi',
              'Kujibikia ni kuepuka jukumu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujibikia ni kufahamu wajumbe wako, wakati kujilaumu ni kumchukia mwenyewe kupita kiasi.',
          ),
          Question(
            question: 'Nini husababisha kujiskia na hatia kwa mambo yasiyo kosa lako?',
            options: [
              'Kujiamini sana',
              'Kuhofu kuwa mzito kwa wengine',
              'Kupenda mafanikio',
              'Kuelewa mipaka yako'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuhofu kuwa mzito kwa wengine au kusababisha shida humfanya mtu ajiskie na hatia hata pasipo kosa.',
          ),
          Question(
            question: 'Unapomsikia rafiki yako ana shida, kawaida unafikiria nini?',
            options: [
              'Labda nilisababisha shida hiyo',
              'Naweza kumsaidia vipi',
              'Hii si shida yangu',
              'Anapaswa kujihudumia mwenyewe'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kufikiria ulisababisha kila shida ya wengine ni dalili ya kujihusisha na kujilaumu.',
          ),
          Question(
            question: 'Njia gani nzuri ya kushughulikia hisia za kujihukumu?',
            options: [
              'Kujihukumu zaidi',
              'Kuzungumza na mtu na kujifunza kujisamehe',
              'Kuepuka hisia hizo',
              'Kufanya mambo mabaya zaidi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujifunza kujisamehe na kuzungumza na mtu ni njia ya afya ya kushughulikia kujihukumu.',
          ),
          Question(
            question: 'Unaposoma maoni hasi mtandaoni, kawaida unafikiria nini?',
            options: [
              'Watu wananiambia ukweli',
              'Labda wana matatizo yao',
              'Nitaondoa akaunti yangu',
              'Nitatuma jibu hasi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuelewa kuwa maoni hasi mara nyingi hufunua matatizo ya mtu mwenye maoni husaidia kutoathiriwa.',
          ),
          Question(
            question: 'Nini muhimu kuhusu kusamehe?',
            options: [
              'Kusamehe kunamaanisha kukubaya mabaya',
              'Kusamehe kunasaidia mwenyewe zaidi',
              'Kusamehe ni tu kwa watu wengine',
              'Kusameha ni dhaifu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujisamehe na kusamehe wengine kunasaidia kupunguza mzigo wa kiakili na hisia.',
          ),
        ],
      ),

      // Level 4: Kujifunza na Mindset ya Ukuaji
      QuizLevel(
        description: 'Kukuza mindset ya ukuaji na kujifunza kutoka kwa makosa',
        icon: '🌱',
        passingScore: 7,
        questions: [
          Question(
            question: 'Unapokosea, unajifunza nini?',
            options: [
              'Sitafanya kosa hilo tena',
              'Ninachojifunza ni kuwa si mwenye uwezo',
              'Ninachojifunza ni jinsi ya kufanya vizuri',
              'Kufanya makosa ni mbaya'
            ],
            correctAnswerIndex: 2,
            explanation: 'Kuona makosa kama fursa ya kujifunza jinsi ya kufanya vizuri ni mindset ya ukuaji.',
          ),
          Question(
            question: 'Nini maana ya "nakubali sehemu ya kujifunza"?',
            options: [
              'Kusema sijui kitu',
              'Kukubali kuwa kuna mambo unayohitaji kujifunza',
              'Kukubali kushinda tu',
              'Kukubali kushinda tu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kukubali sehemu ya kujifunza inamaanisha kukubali kuwa kuna uwezo wa kujifunza na kuboresha.',
          ),
          Question(
            question: 'Unaposikia "sitaweza", nini ni mawazo bora?',
            options: [
              'Kukubali na kujisitiri',
              'Kusema "bado sijui lakini nitaajaribu"',
              'Kukasirikia wanaofanikiwa',
              'Kukata tamaa kabisa'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kubadilisha "sitaweza" kuwa "bado sijui lakini nitaajaribu" inaonyesha mindset ya ukuaji.',
          ),
          Question(
            question: 'Nini cha kufanya unaposhindwa?',
            options: [
              'Kukata tamaa',
              'Kuchunguza ulishindwa wapi na kujaribu tena',
              'Kulaumu wengine',
              'Kujificha'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuchunguza sababu za kushindwa na kujaribu upya ni njia ya kujifunza na kufanikiwa.',
          ),
          Question(
            question: 'Nini muhimu kuhusu kujaribu vitu vipya?',
            options: [
              'Kuepuka vitu vigumu',
              'Kujaribu hata kama unaweza kushindwa',
              'Kujaribu tu unacho hakika',
              'Kusubiri wengine kujaribu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujaribu vitu vipya hata kukiwa na uwezekano wa kushindwa husaidia kujifunza na kukuza.',
          ),
          Question(
            question: 'Unapofanya mafanikio, unajisikiaje?',
            options: [
              'Nilifanya hili kwa bahati',
              'Nimefanya kazi ngumu na kufanikiwa',
              'Hii ni mara ya mwisho',
              'Sitafanikiwa tena'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuunganisha mafanikio na kazi ngumu inaongeza kujiamini na kuhamasisha juhudi zaidi.',
          ),
          Question(
            question: 'Nini maana ya mindset ya ukuaji?',
            options: [
              'Kuamini uwezo ni wa kudumu',
              'Kuamini uwezo unaweza kukuza kwa mazoezi',
              'Kuepuka changamoto',
              'Kukubali kushinda tu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Mindset ya ukuaji ni kuamini kuwa uwezo na akili zinaweza kukuza kwa juhudi na mazoezi.',
          ),
        ],
      ),

      // Level 5: Hasira na Chuki
      QuizLevel(
        description: 'Kueleza hasira na kusahau chuki',
        icon: '😡',
        passingScore: 5,
        questions: [
          Question(
            question: 'Unapokasirikia watu waliokukosea, kawaida hufanyaje?',
            options: [
              'Nawasamehe na kusonga mbele',
              'Nawakumbuka na kusikia hasi kila siku',
              'Sitajali kabisa',
              'Nawaongelesha kwa hasi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kukumbuka na kusikia hasi kila siku kuhusu watu waliokukosea husababisha hasira na chuki.',
          ),
          Question(
            question: 'Nini husababisha hasira zaidi?',
            options: [
              'Kuelewa hisia zako',
              'Kuhisi unatendewa vibaya',
              'Kupumzika na kupumua',
              'Kuzungumza na rafiki'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuhisi unatendewa vibaya au kutokubaliwa husababisha hasira kali.',
          ),
          Question(
            question: 'Unaposikia hasira, nini ni njia ya afya ya kuzitumia?',
            options: [
              'Kupiga vitu',
              'Kuchukua pumziko na kujiongolesha',
              'Kuficha hasira ndani',
              'Kumwambia mtu mwingine kwa hasira'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuchukua pumziko na kujiongolesha husaidia kupunguza hasira kwa njia ya afya.',
          ),
          Question(
            question: 'Nini tofauti kati ya hasira na chuki?',
            options: [
              'Hakuna tofauti',
              'Hasira ni muda, chuki ni ndefu',
              'Chuki ni chanya',
              'Hasira ni ndefu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Hasira ni hisia ya muda inayopita, wakati chuki ni hisia ya ndefu inayoendelea.',
          ),
          Question(
            question: 'Nini kinachosaidia kupunguza hasira mara moja?',
            options: [
              'Kunywa kahawa',
              'Kuchukua hewa ya kina',
              'Kukaa kimya',
              'Kutembea mbali na hali hiyo'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kuchukua hewa ya kina mara moja husaidia kupunguza hasira na kupasha mwili utulivu.',
          ),
          Question(
            question: 'Unaposikia mtu amekukosea, nini ni hatari kufanya?',
            options: [
              'Kumwambia kwa utulivu ulichokisikia',
              'Kumshambulia kwa maneno au vitendo',
              'Kumwacha aende',
              'Kumwambia rafiki zake'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kumshambulia kwa maneno au vitendo hupitisha mipaka na kunaweza kuharibu mahusiano.',
          ),
          Question(
            question: 'Nini muhimu kuhusu kusamehe?',
            options: [
              'Kusamehe kunamaanisha ukubaya',
              'Kusamehe kunasaidia mwenyewe zaidi',
              'Kusamehe ni dhaifu',
              'Kusamehe kunamaanisha kukumbuka'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kusameha kunasaidia mwenyewe kwa kupunguza mzigo wa kiakili na hisia hasira.',
          ),
        ],
      ),

      // Level 6: Kujiamini na Thamani ya Nafsi
      QuizLevel(
        description: 'Kujenga kujiamini cha afya na kuelewa thamani ya nafsi',
        icon: '💖',
        passingScore: 7,
        questions: [
          Question(
            question: 'Unapojisikia "mimi sio wa maana", nini ni chanya kufikiria?',
            options: [
              'Kila mtu ana maana yake',
              'Labda si kweli kweli',
              'Wengine wako bora zaidi',
              'Sitawahi kuwa na maana'
            ],
            correctAnswerIndex: 0,
            explanation: 'Kila mtu ana maana yake na thamani yake bila kujali mafanikio au maoni ya wengine.',
          ),
          Question(
            question: 'Nini kinachoongeza kujiamini?',
            options: [
              'Kulinganisha na wengine',
              'Kufanikiwa katika mambo madogo',
              'Kujikosoa kila wakati',
              'Kuepuka changamoto'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kufanikiwa katika mambo madogo na kuyakumbuka husaidia kujenga kujiamini polepole.',
          ),
          Question(
            question: 'Unaposhindwa, nini ni mawazo ya afya?',
            options: [
              'Nimefeli maisha yangu',
              'Hili ni kimoja tu, sijaondoa',
              'Sitaweza kufanikiwa kamwe',
              'Mimi ni mshindi wa kushindwa'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kushindwa kimoja hakumaanishi umefeli maisha yako - kuna fursa nyingi za mbele.',
          ),
          Question(
            question: 'Nini cha kufanya unapojisikia peke yako?',
            options: [
              'Kukubali kuwa peke yako ni sawa',
              'Kutafuta marafiki wa kila aina',
              'Kujificha na kujisikia vibaya',
              'Kulaumu wengine'
            ],
            correctAnswerIndex: 0,
            explanation: 'Kukubali kuwa kuwa peke yako wakati mwingine ni sawa na kujali mwenyewe.',
          ),
          Question(
            question: 'Unaposikia "sitaweza", nini kinaweza kusaidia?',
            options: [
              'Kukumbuka mafanikio ya awali',
              'Kukubali na kukata tamaa',
              'Kulinganisha na wanaoweza',
              'Kujaribu vitu vigumu zaidi'
            ],
            correctAnswerIndex: 0,
            explanation: 'Kukumbuka mafanikio ya awali husaidia kujiamini kuwa unaweza kufanya tena.',
          ),
          Question(
            question: 'Nini maana ya kujiamini?',
            options: [
              'Kuamini kuwa wewe ni bora zaidi',
              'Kuamini katika uwezo wako na thamani yako',
              'Kutojali maoni ya watu wote',
              'Kufanya kila kitu kwa usahihi'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujiamini ni kuamini katika uwezo wako na thamani yako bila kujali ulivyo.',
          ),
          Question(
            question: 'Unapojisikia "mimi si wa kutosha", nini ni ukweli?',
            options: [
              'Wewe ni wa kutosha kama ulivyo',
              'Unahitaji kuboresha zaidi',
              'Wengine wako bora kuliko wewe',
              'Sitawahi kuwa wa kutosha'
            ],
            correctAnswerIndex: 0,
            explanation: 'Wewe ni wa kutosha kama ulivyo, na thamani yako haijuiishi mafanikio au maoni ya wengine.',
          ),
        ],
      ),

      // Level 7: Mahusiano na Mipaka
      QuizLevel(
        description: 'Kuelewa mahusiano mazuri na kuweka mipaka',
        icon: '🤝',
        passingScore: 5,
        questions: [
          Question(
            question: 'Unapokwama na mtu, kawaida unafanyaje?',
            options: [
              'Naeleza hisia zako kwa haki',
              'Naficha na kusubiri apate mabadiliko',
              'Namtukana',
              'Naeleza kwa hasi'
            ],
            correctAnswerIndex: 0,
            explanation: 'Kueleza hisia zako kwa haki na kwa utulivu ni njia ya afya ya mahusiano.',
          ),
          Question(
            question: 'Nini maana ya mipaka ya mahusiano?',
            options: [
              'Kuepuka watu',
              'Mambo unayokubali na usiyokubali',
              'Kuwa na marafiku wachache',
              'Kusema hapana kwa kila kitu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Mipaka ni mambo unayokubali na usiyokubali katika mahusiano yako.',
          ),
          Question(
            question: 'Unaposikia mtu anakitumia vibaya, nini kifanyike?',
            options: [
              'Kumwambia "Hii hairuhusiwi"',
              'Kumvumilia kwa ajili ya amani',
              'Kumrudishia kwa vitendo',
              'Kumwambia rafiki zake'
            ],
            correctAnswerIndex: 0,
            explanation: 'Kumwambia mtu anayekutumia vibaya kwamba hairuhusiwi ni kuweka mipaka ya afya.',
          ),
          Question(
            question: 'Nini cha kufanya unapojisikia mahusiano yako ni ya sumu?',
            options: [
              'Kubali kwa sababu unampenda',
              'Kuchukua hatua ya kuondoka',
              'Kujaribu kumgeuza',
              'Kuficha shida'
            ],
            correctAnswerIndex: 1,
            explanation: 'Mahusiano yanayokuharibu yanahitaji hatua za kulinda, pamoja na kuondoka ikiwa ni lazima.',
          ),
          Question(
            question: 'Nini muhimu kuhusu marafiki?',
            options: [
              'Kuwa na marafiku wengi',
              'Kuwa na marafiku wanaokuheshimu',
              'Marafiku wanaokubali kila kitu',
              'Marafiku wanaokupa kila kitu'
            ],
            correctAnswerIndex: 1,
            explanation: 'Marafiki wazuri wanakuheshimu na kukusaidia kupata maendeleo.',
          ),
          Question(
            question: 'Unaposhindwa kuwasiliana, nini kifanyike?',
            options: [
              'Kukata tamaa na kujificha',
              'Kujaribu njia tofauti za mawasiliano',
              'Kumlaumu mtu mwingine',
              'Kusema huu ni mwisho'
            ],
            correctAnswerIndex: 1,
            explanation: 'Kujaribu njia tofauti za mawasiliano husaidia kupata suluhisho.',
          ),
          Question(
            question: 'Nini maana ya mahusiano yenye afya?',
            options: [
              'Kukubali kila kitu',
              'Kuwa na heshima, mawasiliano mazuri na kusaidiana',
              'Kuwa na mafanikio tu',
              'Kuepuka migogoro yote'
            ],
            correctAnswerIndex: 1,
            explanation: 'Mahusiano yenye afya yanahitaji heshima, mawasiliano mazuri na kusaidiana.',
          ),
        ],
      ),
    ];
  }

  static List<Question> getShuffledQuestions(QuizLevel level) {
    final List<Question> shuffled = List.from(level.questions);
    shuffled.shuffle(Random());
    return shuffled;
  }
}
