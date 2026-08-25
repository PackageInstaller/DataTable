__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "同調率，即調查員、守密人與自己搭檔的喚醒體的精神同調程度。\n同調率越高，調查員、守密人與喚醒體的了解越深，關係越密切，信任越牢固。"
  },
  LoadingTips_17466_LoadingTips = {
    Text = "密境中，情感、思緒、思維、執念等都可能具有可觀測的投影。這些投影一般是虛幻的物品，是精神維度對現實維度個體的感官的欺騙。"
  },
  LoadingTips_17467_LoadingTips = {
    Text = "靈知轉印器是一種內置在調查員、守密人手提箱中的特殊儀器，可以將意識精神轉印成僅通過融蝕觀察設備查看的高維卡牌：指令卡。"
  },
  LoadingTips_17468_LoadingTips = {
    Text = "融蝕裂隙一經生成，無法縮小，無法終止。\n尋常手段無法對融蝕裂隙產生影響，但銀鑰匙可以在一定程度上壓制甚至“關閉”裂隙。"
  },
  LoadingTips_17469_LoadingTips = {
    Text = "大部分受融蝕侵蝕個體，思維亦會受到干擾，會出現偏執、強迫症、亢奮等精神異常，且伴隨記憶力減退。"
  },
  LoadingTips_17470_LoadingTips = {
    Text = "融蝕侵蝕會發生在包括人類、動物、植物等有機生物體上，也會出現在礦物、金屬等無機物上。\n目前尚未發現能夠免疫融蝕現象的物質。"
  },
  LoadingTips_17471_LoadingTips = {
    Text = "絕大多數人類無法通過肉眼觀測融蝕現象。"
  },
  LoadingTips_17472_LoadingTips = {
    Text = "依照異變的不同，可將融蝕體大致分為不同類型。其中最常見的為協作型融蝕體，干涉型融蝕體及複合型融蝕體。"
  },
  LoadingTips_17473_LoadingTips = {
    Text = "融蝕現象出現在物質上時的表現，體現為單個或數個類倒三角形狀的小型開洞。\n這些開洞的尺寸約在3mm～1cm之間，隨著融蝕的進展，融蝕痕會逐漸擴大。"
  },
  LoadingTips_17474_LoadingTips = {
    Text = "融蝕是物質出現的一種特殊消解、溶解的現象，具有區域性特徵。"
  },
  LoadingTips_17475_LoadingTips = {
    Text = "融蝕現象發展到一定階段後，有一定機率從融蝕痕中生出贅生物。\n它們可能是額外的肢體、觸手，也可能是齒輪、金屬……"
  },
  LoadingTips_17476_LoadingTips = {
    Text = "融蝕漿具有憎水性，不透水也難溶於水，黏度中等且具有一定延展性。\n數百年前，莽撞的人類曾試圖將它當作工業和藝術的原料。"
  },
  LoadingTips_17477_LoadingTips = {
    Text = "「歡迎來到穀倉——這裡擁有最多的檔案櫃，和最少的葬禮。」\nCMT檔案和記錄局因其諧音性質，又被審查會的人戲稱為「穀倉」。"
  },
  LoadingTips_17478_LoadingTips = {
    Text = "雕塑家協會的成員有時會自稱「皮格馬利翁」，他們的組織標誌亦是一把刻刀。"
  },
  LoadingTips_17479_LoadingTips = {
    Text = "融蝕不為世俗所認知，但在某些隱秘的結社中，人們堅信融蝕並非災難，而是神明的賜福。"
  },
  LoadingTips_17480_LoadingTips = {
    Text = "直徑超過5米，且仍有擴大可能性的巨大融蝕痕，被稱為融蝕裂隙。\n裂隙的核心被稱為「災厄」。"
  },
  LoadingTips_17481_LoadingTips = {
    Text = "應急靈知體能直接作用於喚醒體的精神，激發喚醒體的潛力，暫態恢復喚醒體的狀態。唯一的缺點就是其高昂的造價。"
  },
  LoadingTips_17482_LoadingTips = {
    Text = "外勤任務瞬息萬變，具有很強的不可控性。\n針對這種情況，彌薩格大學為外勤人員提供了一些緊急裝置，以最大可能保障他們的安全。"
  },
  LoadingTips_17483_LoadingTips = {
    Text = "調查員、守密人調查的一般都不是普通的現實事件，而是涉及融蝕、融蝕體等與精神維度有著極大聯繫的特殊事件。"
  },
  LoadingTips_17484_LoadingTips = {
    Text = "在有融蝕現象的區域，精神維度的投影更加清晰，密境也更容易被觀測到，但也更多變和危險。"
  },
  LoadingTips_17485_LoadingTips = {
    Text = "依照不同的特質，喚醒體大致被分為深海、血肉、超維及混沌四個界域。"
  },
  LoadingTips_17486_LoadingTips = {
    Text = "鑰塚儀式後，調查員和守密人需與所搭檔的喚醒體進行一次有教師監督的外勤任務，以確保具備日後獨立執行外勤任務的能力。"
  },
  LoadingTips_17487_LoadingTips = {
    Text = "密斯底亞審查會（簡稱CMT）是由各國政府共同建立，卻又獨立於政府存在的，由普通人類構成的隱秘組織。\n它是融蝕現象的第一發現者、第一回應者，\n也是普通人類對抗融蝕的第一戰線。"
  },
  LoadingTips_17488_LoadingTips = {
    Text = "同一界域中的不同喚醒體能夠更好地配合彼此，不同界域之間可能存在一定的排斥。\n僅有混沌界域不存在此現象。"
  },
  LoadingTips_17489_LoadingTips = {
    Text = "銀芯一般以兩種形態存在在現實世界中：銀芯源液，及斜方六面體銀芯。"
  },
  LoadingTips_17490_LoadingTips = {
    Text = "諾斯指數是測量精神碎片在銀芯中的穩定性的數值。\n數值越高的喚醒體，失控的可能性越低，失控後可能造成的傷亡也越少。"
  },
  LoadingTips_17491_LoadingTips = {
    Text = "一把銀鑰匙的誕生需要經過一系列複雜的工序，最後會刻上唯一的編號。\n銀鑰匙嚴禁交易、嚴禁轉贈，無主時將由彌薩格回收。"
  },
  LoadingTips_17492_LoadingTips = {
    Text = "禁忌的典籍鎖在圖書館書架最高處，只有具備權限的人才能查閱。"
  },
  LoadingTips_17493_LoadingTips = {
    Text = "依照《密斯底亞協議》中的相關條款，彌薩格大學會向密斯底亞協議審查會提供銀芯科技的相關支持，以便共同抵禦融蝕，應對危機。"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "每個個體在消解時，能析出的銀芯的量不同。\n精神力越強的個體，在被融蝕消解後能析出的銀芯越多，反之則越少。"
  },
  LoadingTips_17495_LoadingTips = {
    Text = "銀芯科技中具有代表性的物品有：融蝕觀察設備，彌薩格大學通訊器，銀鑰匙等。\n其中最特殊也是最珍貴的是銀鑰匙。"
  },
  LoadingTips_17496_LoadingTips = {
    Text = "喚醒儀式中，調查員、守密人會使用銀鑰匙增強銀芯與精神維度的聯繫。\n利用這一聯繫，調查員、守密人能抓取遊蕩在精神維度中的精神碎片，並將其固定在銀芯之中。"
  },
  LoadingTips_17497_LoadingTips = {
    Text = "喚醒體由銀芯強行從精神維度抓取精神碎片並固定而來，而精神碎片受到精神維度的影響。因此，所有喚醒體被喚醒後都天然處於癲狂狀態，直到有調查員、守密人與其建立連結。"
  },
  LoadingTips_17498_LoadingTips = {
    Text = "彌薩格大學，建立於洪積187年10月16日，是一所致力於研究融蝕、對抗融蝕的高等學府。"
  },
  LoadingTips_17499_LoadingTips = {
    Text = "彌薩格大學前身，彌薩格學院，於洪積90年10月16日，由華德·菲力浦斯及另兩位創始人一同建立。"
  },
  LoadingTips_17500_LoadingTips = {
    Text = "持有銀鑰匙的調查員、守密人可以順利通過校外迷霧，與已連結的喚醒體一同進入校園。"
  },
  LoadingTips_17501_LoadingTips = {
    Text = "315年前，一場浩大的災難席捲全球。\n人們以災難發生的這一年為元年，開啟了一個新的紀年——洪積。"
  },
  LoadingTips_17502_LoadingTips = {
    Text = "「願銀鑰指引前路。」\n彌薩格大學成員們的常用祝語，蘊含了彌薩格人一往無前的信念。"
  },
  LoadingTips_17503_LoadingTips = {
    Text = "「誓以劍刃刺穿黑暗。」\n密斯底亞協議審查會成員的常用祝語，蘊含了審查會成員與融蝕抗爭的堅定決心。"
  },
  LoadingTips_17504_LoadingTips = {
    Text = "那些相較於一般調查員擁有更多能力、能夠連結更多喚醒體的特殊人才，會被授予守密人稱號。\n迄今為止，能以守密人之名行走於世間的寥寥無幾。"
  },
  LoadingTips_17505_LoadingTips = {
    Text = "通常而言，一名調查員同時只能連結一位喚醒體。但也不排除有特殊案例。"
  },
  LoadingTips_17506_LoadingTips = {
    Text = "沒有外勤任務時，調查員、守密人與其搭檔喚醒體會在彌薩格大學內休養生息。\n他們都需要上課、參加考試，以及完成冗長的課餘作業。"
  },
  LoadingTips_17507_LoadingTips = {
    Text = "所有喚醒體的喚醒都需要符合《密斯底亞協議》的相關規定，喚醒後也需要進行登記。"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "嚴格意義上來說，喚醒體也是銀芯科技的一種。"
  },
  LoadingTips_36756_LoadingTips = {
    Text = "依照裂隙的類型不同，一個裂隙可能具有一個或多個被稱為「災厄」的核心。"
  },
  LoadingTips_36757_LoadingTips = {
    Text = "彌薩格在《調查員精神構成與其潛力》的理論基礎上發展、完善並訂製了一系列篩選流程，以盡可能多地在不驚動普羅大眾的前提下發掘潛在調查員。"
  },
  LoadingTips_36758_LoadingTips = {
    Text = "每個人的精神不同，每個守密人的特殊能力也不盡相同。\n目前已知的能力有：共用記憶、共用情感、感知情緒等。"
  },
  LoadingTips_36759_LoadingTips = {
    Text = "315年前，一場大洪水席捲了世界。秩序崩潰，城市傾塌，海底的高山驟然隆起，形成新的陸地。"
  },
  LoadingTips_36760_LoadingTips = {
    Text = "雷歐坊，雷歐王國的通用貨幣。市面上還流通著以緬、片什為主的輔幣。1雷歐坊等於10緬，1緬等於10片什。"
  },
  LoadingTips_36761_LoadingTips = {
    Text = "借助儀器和銀芯的幫助暫時獨立出來的，不受其他精神影響，也不受現實維度影響的特殊空間，被稱為人工密境（Artificial Domain）。"
  },
  LoadingTips_36762_LoadingTips = {
    Text = "通過電梯，可以抵達彌薩格地下空間。\n除了倫蒂尼恩最大的L-01號裂隙“黑池”外，這裡還有各類限制區域，需要一定安全等級才能進入。"
  },
  LoadingTips_36763_LoadingTips = {
    Text = "由於銀鑰匙與精神維度之間存在一定關聯，在靠近精神異常的個體時，銀鑰匙可能會產生特殊反應。"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "密契，即使用特殊方法記錄到含有銀芯的材料上的神秘符文。\n不同密契能夠提供的助力不同，同一系列的密契可以帶來更多的助力。"
  },
  LoadingTips_36765_LoadingTips = {
    Text = "融蝕漿是一種從融蝕痕中溢出的黑色黏液。\n和融蝕現象本身一樣，不借助特殊器械，普通人無法直接對其進行觀測。"
  },
  LoadingTips_36766_LoadingTips = {
    Text = "某些融蝕體死後會化作的黑色粉末，被稱為融蝕粉塵。"
  },
  LoadingTips_36767_LoadingTips = {
    Text = "雷歐王國位於亞特蘭大洋東側，與康斯坦聯邦、常青聯盟接壤。\n王國面積不大，但國力強盛，是洪積後最早完成重建的國家之一。"
  },
  LoadingTips_36768_LoadingTips = {
    Text = "亞格羅共和國位於亞特蘭大洋西側，四面環海，腹地遼闊。\n亞格羅共和國工業與金融業十分發達，其金融中心城市弗萊徹更是無數人嚮往的繁華之地。"
  },
  LoadingTips_36769_LoadingTips = {
    Text = "密境中，情感、思緒、思維、執念等都可能具有可觀測的投影。\n這些投影一般不可觸碰，或者一觸即散，是精神維度對現實維度個體的感官的欺騙。"
  },
  LoadingTips_36770_LoadingTips = {
    Text = "康斯坦聯邦位於東勞拉西亞大陸，是一個由數個小國組合而成的聯邦。在聯邦中，藝術是所有人一致的追求。"
  },
  LoadingTips_36771_LoadingTips = {
    Text = "一些特殊的投影能被靈知轉印器捕捉，並附著在指令卡上，使喚醒體獲得增益。這些投影被稱為刻印（Orison）。"
  },
  LoadingTips_36772_LoadingTips = {
    Text = "根據融蝕裂隙的大小，大致可以將融蝕裂隙分為6類：C,B,A,S,SS,SSS。"
  },
  LoadingTips_36773_LoadingTips = {
    Text = "雕塑家協會，一個沉迷於罪惡的人體實驗的極端組織。由彌薩格的叛徒羅伯特·羅森塔爾一手創辦。"
  },
  LoadingTips_36774_LoadingTips = {
    Text = "蹈海者，一個以彌利亞姆為首的古老宗教組織。\n他們苦心經營，隻為復活他們唯一的神王。"
  },
  LoadingTips_36775_LoadingTips = {
    Text = "不同區域的密境在調查時能收集到的事物也不同，即使是看似相同的事物，也可能具有非常不同的本質。"
  },
  LoadingTips_36776_LoadingTips = {
    Text = "密境（Domain）是介於精神維度和現實維度之間的特殊維度，是人類能夠肉身進入的最接近精神維度的空間。"
  },
  LoadingTips_36777_LoadingTips = {
    Text = "彌薩格大學是絕對中立的第三方，校內大小事宜皆由校長及各管理層人員共同商議決定，不受任何組織約束。"
  },
  LoadingTips_36778_LoadingTips = {
    Text = "融蝕裂隙的存在不需要依託具有實體的物件，天空、海洋等都是融蝕裂隙可能出現的場所。"
  },
  LoadingTips_36779_LoadingTips = {
    Text = "提燈教會，一個隱秘而邪惡的宗教組織。似乎與雕塑家協會和蹈海者有很深的聯繫。"
  },
  LoadingTips_36780_LoadingTips = {
    Text = "密斯底亞協議審查會是個非常龐大的組織。\n除了雷歐王國，它在亞格羅共和國、康斯坦聯邦乃至勒姆瓦希帝國都設有分部。"
  }
})
return Text_LoadingTips
