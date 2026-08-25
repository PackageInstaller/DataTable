__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerConfig = readonly({
  AwakerConfig_125346_AwakerIntroduction = {
    Text = "·優雅而妩媚的東方「神明」。當她挪開扇面時、眾生都將痴醉於她致命的魅力。\n·蓋因情欲而催生的歡愉如蝕骨之毒般縈繞、使人甘願在她相許的情誓中走向消融與沉寂。\n·本次關卡中、將攜帶等級 50 級、技能等級5、啟靈3的徐和拉蒙娜出戰。回合開始時將 1 張「高級靈感」和 1 張「胚胎」置入手中、對所有敵人施加 1 層「痴醉」。"
  },
  AwakerConfig_125346_Introduction = {
    Text = "令人痴醉的魅力能夠瓦解敵人的鬥志、滲入全身的蝕骨毒素將在其沉淪之時轟然迸發。"
  },
  AwakerConfig_125346_SummonSlogan = {
    Text = "注視著這令人戰慄的美麗、她「愛」你、祂會永遠、永遠「陪伴」你。"
  },
  AwakerConfig_130226_AwakerIntroduction = {
    Text = "· 當一切被血肉侵蝕，當日常被錯亂顛倒，嘶鳴的雜音中，蒲公英飄落到了這片荒原。\n·伸出手吧，牽住她吧。愛會突破表象，將你與你所愛之人，再次錨定。\n·「沙耶之歌」可以選擇一名友方生成其大量卡牌置入牌庫，觸發「吞噬」或消耗由「生物擬態」生成的「羽種」能夠強化這些複製的卡牌，「肉脂爛漫」能夠快速將這些卡牌抽取置入手中並對敵方施加大量「侵蝕」。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的沙耶和蘿坦出戰，戰鬥開始時沙耶獲得 200 點狂氣、4 層「羽種」、500 點力量。回合開始時，將 1 張「胚胎」置入手中，抽 3 張牌，獲得 3 點算力，所有喚醒體獲得 50 狂氣。"
  },
  AwakerConfig_130226_Introduction = {
    Text = "穿越遙遠群星間的障壁，只有愛，是唯一的、始終的命題。"
  },
  AwakerConfig_130226_SummonSlogan = {
    Text = "當所有蒲公英被吹散的時候，以愛的名義，我們將重逢。"
  },
  AwakerConfig_130226_VoiceActor = {
    Text = "川村みどり"
  },
  AwakerConfig_130384_Name = {
    Text = "撒托古亞"
  },
  AwakerConfig_130384_Title = {
    Text = "撒托古亞"
  },
  AwakerConfig_130901_AwakerIntroduction = {
    Text = "·向往友情的開朗少女、能夠從夥伴的狂氣爆發中得到鼓舞並釋放攻擊協同夥伴追擊敵方。\n·與她纖細身軀極不相稱的駭人巨砲饑渴地吞噬著能量、拘束解除時產生的漩渦將瞬間夷平周圍的一切。\n·本次關卡中、將攜帶等級 50 級、技能等級5、啟靈3的莫絲和拉蒙娜、奧吉爾出戰、戰鬥開始時獲得 200 點觸腕傷害、回合開始時抽 3 張牌、獲得 3 點算力、莫絲以外的喚醒體獲得 50 點狂氣。"
  },
  AwakerConfig_130901_Introduction = {
    Text = "開朗率直的野性少女、手中的重火器集聚漩渦能量後能夠造成巨大的破壞。"
  },
  AwakerConfig_130901_Name = {Text = "莫絲"},
  AwakerConfig_130901_SummonSlogan = {
    Text = "拘束、引導、釋放、毀滅。漩渦將聽從她的指引、讓一切壞人沉溺於深淵。"
  },
  AwakerConfig_130901_Title = {Text = "莫絲"},
  AwakerConfig_130901_Weight = {
    Text = "由於其身體構成特殊、無法計算"
  },
  AwakerConfig_132340_Introduction = {
    Text = "具有奇怪使命的電子幽靈，只有極少的人得見真容。"
  },
  AwakerConfig_132340_Title = {
    Text = "禁忌實驗體"
  },
  AwakerConfig_132374_Introduction = {
    Text = "具有奇怪使命的電子幽靈，只有極少的人得見真容。"
  },
  AwakerConfig_132374_Name = {
    Text = "蒼之壹型"
  },
  AwakerConfig_132374_Title = {
    Text = "禁忌實驗體"
  },
  AwakerConfig_132375_Introduction = {
    Text = "具有奇怪使命的電子幽靈，只有極少的人得見真容。"
  },
  AwakerConfig_132375_Name = {
    Text = "絳之壹型"
  },
  AwakerConfig_132375_Title = {
    Text = "禁忌實驗體"
  },
  AwakerConfig_132376_Introduction = {
    Text = "具有奇怪使命的電子幽靈，只有極少的人得見真容。"
  },
  AwakerConfig_132376_Title = {
    Text = "禁忌實驗體"
  },
  AwakerConfig_141302_AwakerIntroduction = {
    Text = "·統禦不再失卻之地的領主，凡入其眼者，皆化作永世相隨的子民。\n·哨音驟響，傾巢而出的「囚魘」是他趁手的獵具，氣力被奪盡的敵人於環伺中墜入深淵，自此永恆的國度迎來新的一員。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的龐托斯出戰，戰鬥開始時獲得 100 點觸腕傷害，龐托斯獲得 75 點狂氣、3 層「圍獵」。回合開始時，抽 3 張牌，所有喚醒體獲得 20 狂氣。"
  },
  AwakerConfig_141302_Introduction = {
    Text = "深淵令他得以將一切留存，不會再有任何事物，能讓他面對無望的分離。"
  },
  AwakerConfig_141302_Name = {Text = "龐托斯"},
  AwakerConfig_141302_SummonSlogan = {
    Text = "在海洋的盡頭，有一場永無休止的狂歡。"
  },
  AwakerConfig_141302_Title = {Text = "龐托斯"},
  AwakerConfig_141302_VoiceActor = {
    Text = "諏訪部順一"
  },
  AwakerConfig_141302_Weight = {
    Text = "無法測量"
  },
  AwakerConfig_143941_Name = {Text = "太歲"},
  AwakerConfig_143941_Title = {Text = "太歲"},
  AwakerConfig_145363_AwakerIntroduction = {
    Text = "·為戰鬥而生的戰士，越強大的敵人越讓她感到興奮。合璧沉鯨的巨劍，她吞噬一切，征服一切。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的蝕滅·蘿坦和拉蒙娜、奧吉爾出戰。\n·本場戰鬥中守密人最大生命值翻倍。回合開始時將 1 張「靈感」置入手中，所有喚醒體獲得 20 點狂氣。"
  },
  AwakerConfig_145363_Introduction = {
    Text = "為戰鬥而生的戰士，越強大的敵人越讓她感到興奮。合璧沉鯨的巨劍，她吞噬一切，征服一切。"
  },
  AwakerConfig_145363_Name = {
    Text = "蝕滅·蘿坦"
  },
  AwakerConfig_145363_SummonSlogan = {
    Text = "前進，是風暴唯一的方向。 而她，生來就是風暴。"
  },
  AwakerConfig_145363_Title = {
    Text = "蝕滅·蘿坦"
  },
  AwakerConfig_145363_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_147397_Characteristic = {
    Text = "卡牌強化    力量奪取"
  },
  AwakerConfig_147397_VoiceActor = {
    Text = "岡本美歌"
  },
  AwakerConfig_15560_AwakerIntroduction = {
    Text = "·通過靈知覺醒和指令卡可以快速堆疊<RetaliateIconKeywords:反擊>，造成傷害越高，獲得的<RetaliateIconKeywords:反擊>越多。\n·當前<RetaliateIconKeywords:反擊>越高，狂氣爆發造成的群體傷害越高，若只有 1 個敵人，狂氣爆發還可以額外造成 1 次傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的潘狄婭出戰，敵人首回合將獲得強化。"
  },
  AwakerConfig_15560_Characteristic = {
    Text = "反擊敵人    多次傷害"
  },
  AwakerConfig_15560_Introduction = {
    Text = "鞭打對手的同時獲得大量反擊，讓意欲還擊的對手痛不欲生。"
  },
  AwakerConfig_15560_Name = {Text = "潘狄婭"},
  AwakerConfig_15560_SummonSlogan = {
    Text = "不要盲信表像的甜蜜，熱情的皮囊下，說不定藏匿著惡鬼。"
  },
  AwakerConfig_15560_Title = {Text = "潘狄婭"},
  AwakerConfig_15560_VoiceActor = {Text = "橘由紀"},
  AwakerConfig_15562_AwakerIntroduction = {
    Text = "·回合結束時「綠炎」若在手牌或超維空間中，將會升級為<DerivativeCardKeywords_19:「腐化綠炎」>，升級後可以造成更高的傷害和<IntoxicationIconKeywords:中毒>。\n·在面對多段傷害時，通過「誘蛾之火」可以獲得多張「綠炎」。\n·狂氣爆發可以將手牌中所有莉茲的卡牌無需算力釋放，積攢大量綠炎將能造成超高爆發傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「莉茲」出戰，每回合將獲得 7 點<PowerIconKeywords:力量>，15 點狂氣，超維回合開始後還會獲得 100 點狂氣。敵人首回合將獲得強化。"
  },
  AwakerConfig_15562_Characteristic = {
    Text = "中毒爆發    資源循環"
  },
  AwakerConfig_15562_Introduction = {
    Text = "在超維空間或手牌中不斷成長翠色火焰，釋放狂氣爆發將其一併釋放燒盡敵人。"
  },
  AwakerConfig_15562_Name = {Text = "莉茲"},
  AwakerConfig_15562_SummonSlogan = {
    Text = "旋轉的足尖承載了她的夢想，她的追求，以及那一切破滅後，從痛恨與絕望中燃起的青色火焰。"
  },
  AwakerConfig_15562_Title = {Text = "莉茲"},
  AwakerConfig_15562_VoiceActor = {
    Text = "青池優花"
  },
  AwakerConfig_15563_AwakerIntroduction = {
    Text = "·使用卡牌和狂氣爆發來使觸腕獲得爆發成長\n·利用激發觸腕的能力來對敵人造成大量傷害\n·在該關卡中可獲得額外的算力和狂氣"
  },
  AwakerConfig_15563_Characteristic = {
    Text = "觸腕爆發    觸腕成長"
  },
  AwakerConfig_15563_Introduction = {
    Text = "以王者威壓號令觸腕制裁敵人，並以王的血脈迅速激發爆發性的觸腕傷害潛力。"
  },
  AwakerConfig_15563_Name = {Text = "圖魯"},
  AwakerConfig_15563_SummonSlogan = {
    Text = "與常規認知相悖的是，他討厭水。"
  },
  AwakerConfig_15563_Title = {Text = "圖魯"},
  AwakerConfig_15563_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_15564_AwakerIntroduction = {
    Text = "·「巨刃之威」和「斬首重創」擁有高額傷害和多倍<PowerIconKeywords:力量>加成，可對單個和群體敵人造成大量傷害。\n·「斬首重創」攻擊低生命敵人或造成擊殺時還能返還算力消耗。\n·狂氣爆發可選擇篡奪或蟄伏，選擇成長或爆發時機從而打出更多傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的戈利亞出戰。"
  },
  AwakerConfig_15564_Characteristic = {
    Text = "力量爆發    偷取力量"
  },
  AwakerConfig_15564_Introduction = {
    Text = "以巨刃之力揮動重刃斬殺敵人，觸腕傷害和力量都使他變得更加強大。"
  },
  AwakerConfig_15564_Name = {Text = "戈利亞"},
  AwakerConfig_15564_SummonSlogan = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  AwakerConfig_15564_Title = {Text = "戈利亞"},
  AwakerConfig_15565_AwakerIntroduction = {
    Text = "·擁有強大的防護和堆疊<RetaliateIconKeywords:反擊>的能力，靈知覺醒後該能力還能更上一層。\n·當前的護盾越高，狂氣爆發獲得的護盾越多；當前的<RetaliateIconKeywords:反擊>越高，狂氣爆發造成的群體傷害越高。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的諾締拉和朵爾出戰，每回合獲得 10 點狂氣，敵人首回合將獲得強化。"
  },
  AwakerConfig_15565_Characteristic = {
    Text = "防護爆發    回收棄牌"
  },
  AwakerConfig_15565_Introduction = {
    Text = "堅固的螺殼讓隊伍的防護更上一層樓，並用螺殼上的尖刺反擊來犯的對手。"
  },
  AwakerConfig_15565_Name = {Text = "諾締拉"},
  AwakerConfig_15565_SummonSlogan = {
    Text = "只要還能夠冒險，她就能笑著前進。"
  },
  AwakerConfig_15565_Title = {Text = "諾締拉"},
  AwakerConfig_15565_VoiceActor = {
    Text = "國実久留子"
  },
  AwakerConfig_15566_AwakerIntroduction = {
    Text = "·擁有較全面的算力供應、生命回復、觸腕傷害提升的輔助能力。\n·狂氣爆發後，本場戰鬥中受到致死傷害時會復活，每場戰鬥最多觸發 1 次。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的希萊斯特出戰，每回合將獲得 20 點狂氣，敵人首回合獲得強化。"
  },
  AwakerConfig_15566_Characteristic = {
    Text = "臨時觸腕    免疫死亡"
  },
  AwakerConfig_15566_Introduction = {
    Text = "庇佑航行，從死亡的危機中守護友方，並用夢境之力回復友方生命。"
  },
  AwakerConfig_15566_Name = {
    Text = "希萊斯特"
  },
  AwakerConfig_15566_SummonSlogan = {
    Text = "「那艘船，為什麼會沉呢？」"
  },
  AwakerConfig_15566_Title = {
    Text = "希萊斯特"
  },
  AwakerConfig_15567_AwakerIntroduction = {
    Text = "·靈活的使用鎖鏈打擊敵人，能夠在造成傷害的同時施加大量<BleedingIconKeywords:出血>。\n·預先積攢手牌，尋找時機釋放狂氣爆發獲取強力增益，配合<DevouredIconKeywords:吞噬>效果減少自身所有卡牌算力消耗。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的血鏈 · 希洛出戰，初始生命為 40%，回合結束時獲得 50 狂氣與 100 胚胎融合度。"
  },
  AwakerConfig_15567_Characteristic = {
    Text = "連環打擊    打擊卡增幅"
  },
  AwakerConfig_15567_Introduction = {
    Text = "她會使用獨特的技巧連擊敵人，並用出血傷害終結對手。"
  },
  AwakerConfig_15567_Name = {
    Text = "血鏈·希洛"
  },
  AwakerConfig_15567_SummonSlogan = {
    Text = "掙脫鎖鏈之後，她向一切鎖鏈的締造者復仇。"
  },
  AwakerConfig_15567_Title = {
    Text = "血鏈·希洛"
  },
  AwakerConfig_15567_VoiceActor = {
    Text = "國実久留子"
  },
  AwakerConfig_15568_Characteristic = {
    Text = "檢索卡牌    多次傷害"
  },
  AwakerConfig_15568_Introduction = {
    Text = "從過往的指令中獲取力量為她所用，並以命定之劍造成高額單次傷害。"
  },
  AwakerConfig_15568_Name = {
    Text = "環行·拉蒙娜"
  },
  AwakerConfig_15568_Title = {
    Text = "環行·拉蒙娜"
  },
  AwakerConfig_15568_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_15569_Characteristic = {
    Text = "高額群攻    傷害成長"
  },
  AwakerConfig_15569_Introduction = {
    Text = "以連綿不斷的「打擊」造成多次傷害，並喚起終焉巨獸吞噬仇敵。"
  },
  AwakerConfig_15569_Name = {Text = "蘿坦"},
  AwakerConfig_15569_SummonSlogan = {
    Text = "星之巨獸如是說：掀起滔天巨浪吧！讓敵人發出悲鳴吧！"
  },
  AwakerConfig_15569_Title = {Text = "蘿坦"},
  AwakerConfig_15569_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_15570_Characteristic = {
    Text = "驅散虛弱    生命回復"
  },
  AwakerConfig_15570_Introduction = {
    Text = "以其完美的研究成果為其他喚醒體提供狂氣，並回復大量生命。"
  },
  AwakerConfig_15570_Name = {Text = "朵爾"},
  AwakerConfig_15570_SummonSlogan = {
    Text = "她所追尋的，乃是藏於天地間之奧秘。"
  },
  AwakerConfig_15570_Title = {Text = "朵爾"},
  AwakerConfig_15570_VoiceActor = {
    Text = "魚穀佳代"
  },
  AwakerConfig_15571_AwakerIntroduction = {
    Text = "·擁有強大的生命回復和靈活的算力供應能力。\n·「蟾蜍燉菜」和「靜默守望」均擁有<RetainIconKeywords:保留>，每保留一回合將獲得不同的成長。\n·狂氣爆發、「蟾蜍燉菜」、「奇妙料理」均能對所有敵人施加<IntoxicationIconKeywords:中毒>。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的珈倫出戰，敵人首次攻擊將獲得強化。"
  },
  AwakerConfig_15571_Characteristic = {
    Text = "補充算力    抵抗死亡"
  },
  AwakerConfig_15571_Introduction = {
    Text = "為你的隊伍提供大量算力並用料理回復生命，同時用黑暗料理毒殺敵人。"
  },
  AwakerConfig_15571_Name = {Text = "珈倫"},
  AwakerConfig_15571_SummonSlogan = {
    Text = "無論是掃帚還是武器，她都能使得十分優雅。"
  },
  AwakerConfig_15571_Title = {Text = "珈倫"},
  AwakerConfig_15571_VoiceActor = {
    Text = "二宮雪乃"
  },
  AwakerConfig_15572_AwakerIntroduction = {
    Text = "·狂氣爆發可造成群體傷害和抽牌，抽到越多自身指令卡、狀態或症狀卡，造成的傷害次數越多。\n·「通通消失！」可重洗手牌，同時棄掉狀態或症狀卡並獲得狂氣。\n·「隔空取物」取出超維空間的卡牌換來高額傷害與算力資源。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的卡茜亞出戰，首領敵人首次攻擊將獲得強化。"
  },
  AwakerConfig_15572_Characteristic = {
    Text = "補充手牌    臨時力量"
  },
  AwakerConfig_15572_Introduction = {
    Text = "能夠像變魔術一樣抽取或更換大量卡牌，並獲得臨時力量來增強傷害。"
  },
  AwakerConfig_15572_Name = {Text = "卡茜亞"},
  AwakerConfig_15572_SummonSlogan = {
    Text = "變走有形的東西算什麼把戲？她的演出可以竊取靈魂。"
  },
  AwakerConfig_15572_Title = {Text = "卡茜亞"},
  AwakerConfig_15572_VoiceActor = {Text = "七緒凜"},
  AwakerConfig_15573_Characteristic = {
    Text = "多次傷害    穿透防護"
  },
  AwakerConfig_15573_Introduction = {
    Text = "源源不斷分裂腺體進行低算力消耗的攻擊，必要時一氣消耗所有腺體發動總攻。"
  },
  AwakerConfig_15573_Name = {Text = "奧瑞塔"},
  AwakerConfig_15573_SummonSlogan = {
    Text = "「嗯？水母？果凍？」"
  },
  AwakerConfig_15573_Title = {Text = "奧瑞塔"},
  AwakerConfig_15574_AwakerIntroduction = {
    Text = "·靈知覺醒可賦予汀克特的所有指令卡隨機效果，隨機獲得<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>、抽牌、算力、狂氣的能力。\n·狂氣爆發能將五張手牌算力消耗減 1 的同時，還將增幅汀克特的「打擊」基礎傷害。\n·通過積攢力量、「打擊」基礎傷害，打出「打擊」將能造成高額傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「汀克特」出戰，每回合獲得 15 點狂氣，敵人首回合獲得強化。"
  },
  AwakerConfig_15574_Characteristic = {
    Text = "力量奪取    消耗降低"
  },
  AwakerConfig_15574_Introduction = {
    Text = "使用超越時空的歌聲來降低手中大量卡牌的算力消耗，並使隊友的戰鬥意志高漲。"
  },
  AwakerConfig_15574_SummonSlogan = {
    Text = "在金絲的牢籠中，在無形的枷鎖下，夜鶯只是歌唱，只是歌唱。"
  },
  AwakerConfig_15574_VoiceActor = {
    Text = "岡本美歌"
  },
  AwakerConfig_15575_AwakerIntroduction = {
    Text = "·狂氣爆發和靈知覺醒擁有強大的過牌能力，提高隊伍容錯率。\n·「深邃暗流」可使觸腕每次攻擊時都對所有敵人施加<IntoxicationIconKeywords:中毒>，配合驅使觸腕攻擊和「狂熱之海」可一次性給敵人施加大量<IntoxicationIconKeywords:中毒>。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的法洛思出戰，敵人首回合將獲得強化。"
  },
  AwakerConfig_15575_Characteristic = {
    Text = "觸腕生成    補充手牌"
  },
  AwakerConfig_15575_Introduction = {
    Text = "為觸腕附上烈毒來折辱敵人，並以虔誠的信仰讓隊伍獲取卡牌，指明前進道路。"
  },
  AwakerConfig_15575_SummonSlogan = {
    Text = "海底火山的呼吸不再低鳴耳畔，深海幻夢也已經是模糊的圖像。"
  },
  AwakerConfig_15576_AwakerIntroduction = {
    Text = "·擁有獨特的防護能力，將敵人傷害轉變為<SacrificeKeyWord:獻祭>\n·使用卡牌可獲得無視觸腕上限的觸腕數量\n·靈活的透支<SacrificeKeyWord:獻祭>換取防禦能帶來更強大的短期戰力。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「墨菲」出戰。"
  },
  AwakerConfig_15576_Characteristic = {
    Text = "觸腕激發    補充算力"
  },
  AwakerConfig_15576_Introduction = {
    Text = "她能夠承受獻祭來抵抗敵方的高額傷害，並能夠號令觸腕展開總攻。"
  },
  AwakerConfig_15576_SummonSlogan = {
    Text = "把蛋糕和柔軟的床榻奉上，她說不定就能好好聽人說話了。"
  },
  AwakerConfig_15576_VoiceActor = {Text = "大內茜"},
  AwakerConfig_15577_AwakerIntroduction = {
    Text = "·狂氣爆發可以為我方提供永久的死亡抵抗。\n·觸發死亡抵抗後防禦能力和回復能力都將獲得提升。\n·靈知覺醒和指令卡均可以獲得大量反擊和削弱敵人<PowerIconKeywords:力量>，面對多個敵人和多次傷害時具有優勢。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的菲茵特出戰，每回合獲得 30 <EmbryoFusionIconKeywords:胚胎融合>，10 點狂氣，敵人前兩回合將獲得強化。"
  },
  AwakerConfig_15577_Characteristic = {
    Text = "死亡抵抗    奪取力量"
  },
  AwakerConfig_15577_Introduction = {
    Text = "能夠附加高額的死亡抵抗，並吸食對手的力量來抵禦攻擊。"
  },
  AwakerConfig_15577_SummonSlogan = {
    Text = "深愛著夜鶯的劣等品，也會有綻放的一天。"
  },
  AwakerConfig_15577_VoiceActor = {
    Text = "伊藤紗月"
  },
  AwakerConfig_15578_Introduction = {
    Text = "有著高額的暴擊率和暴擊傷害，布朗和鼠群會成為他對抗多名敵人的關鍵助力。"
  },
  AwakerConfig_15579_AwakerIntroduction = {
    Text = "·擁有強大的防護和提供狂氣的能力。\n·狂氣爆發可以使 1 名其他喚醒體獲得較多狂氣，使其可以釋放更多的狂氣爆發，甚至 1 回合連續釋放狂氣爆發。\n·靈知覺醒使得施加護盾時可獲得反擊，面對多段敵人時也擁有反擊能力。\n在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的溫柯爾和蘿坦出戰，試玩戰鬥中將獲得增益，敵人首回合獲得強化。"
  },
  AwakerConfig_15579_Characteristic = {
    Text = "狂氣供給    延遲抽牌"
  },
  AwakerConfig_15579_Introduction = {
    Text = "能夠為其他友方提供狂氣，同時也能夠耗盡手牌凝聚高額護盾。"
  },
  AwakerConfig_15579_Name = {Text = "溫柯爾"},
  AwakerConfig_15579_SummonSlogan = {
    Text = "就連記憶中的黑暗，也會招來那可怖的詛咒。"
  },
  AwakerConfig_15579_Title = {Text = "溫柯爾"},
  AwakerConfig_15579_VoiceActor = {Text = "七緒凜"},
  AwakerConfig_15580_AwakerIntroduction = {
    Text = "·通過指令卡快速對敵人堆疊<IntoxicationIconKeywords:中毒>，使用狂氣爆發觸發敵人的<IntoxicationIconKeywords:中毒>效果，造成大量傷害。\n·「夜潮洶湧」造成的傷害和中毒會隨著打出症狀卡而成長。\n·狂氣爆發施加的中毒會隨著釋放次數提高。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的寧菲亞出戰，戰鬥開始時獲得 3 張症狀卡。"
  },
  AwakerConfig_15580_Characteristic = {
    Text = "觸發中毒    虛弱敵方"
  },
  AwakerConfig_15580_Introduction = {
    Text = "結合海毒和虛弱，在確保自身生存的同時持續折磨對手。"
  },
  AwakerConfig_15580_Name = {Text = "寧菲亞"},
  AwakerConfig_15580_SummonSlogan = {
    Text = "未曾綻放的睡蓮，回歸了海的懷抱。"
  },
  AwakerConfig_15580_Title = {Text = "寧菲亞"},
  AwakerConfig_15580_VoiceActor = {
    Text = "東海林亞祐"
  },
  AwakerConfig_15581_AwakerIntroduction = {
    Text = "·擁有強大的防護能力，生命越低防護越強。\n·越是疼痛越瘋狂，在絕境中擁有一擊必殺的力量。\n在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的莉莉出戰。"
  },
  AwakerConfig_15581_Characteristic = {
    Text = "生命上限    受傷變強"
  },
  AwakerConfig_15581_Introduction = {
    Text = "將承受的痛苦轉化為怒火消滅敵人，或是轉化為生命來幫助友方。"
  },
  AwakerConfig_15581_SummonSlogan = {
    Text = "「媽媽，在哪？」"
  },
  AwakerConfig_15581_VoiceActor = {
    Text = "盛惠裡花"
  },
  AwakerConfig_15582_AwakerIntroduction = {
    Text = "·指令卡擁有獨特的<O07CardKeyWord:祭儀>效果，將會轉化<O07CardKeyWord2:「聖禮」>強化指令卡。\n·使用狂氣爆發不僅可獲得更多的<O07CardKeyWord2:「聖禮」>，還會根據不同的觸腕姿態獲得不同的效果。\n·三張靈知覺醒逐步打出，能力各不相同，最終還可持續獲得強大增益卡「神國幻影」。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的彌利亞姆和奧瑞塔出戰，手牌上限 +2，彌利亞姆初始擁有 35 狂氣，每回合獲得 20 點狂氣。"
  },
  AwakerConfig_15582_Characteristic = {
    Text = "觸腕生成    狂氣支援"
  },
  AwakerConfig_15582_Introduction = {
    Text = "她既能夠使用大祭司的權能號令更多觸腕，也能以祭祀匕首來毒殺敵人。"
  },
  AwakerConfig_15582_Name = {
    Text = "彌利亞姆"
  },
  AwakerConfig_15582_SummonSlogan = {
    Text = "虔誠的信仰最終化作刺向自己的利刃。"
  },
  AwakerConfig_15582_Title = {
    Text = "彌利亞姆"
  },
  AwakerConfig_15583_AwakerIntroduction = {
    Text = "·擁有四種效果各異的詩篇，觸發躍遷時將進入「喜、怒、哀、懼」四種之一的情緒狀態中。\n·每種情緒狀態將對所有喚醒體帶來不同能力的加成，奧爾拉的狂氣爆發額外享受更多的加成。\n·在本次試玩中，將攜帶等級 50 級，技能等級5，啟靈3 的奧爾拉和蘿坦出戰，敵人首回合獲得強化。"
  },
  AwakerConfig_15583_Characteristic = {
    Text = "延遲回復    削弱敵方"
  },
  AwakerConfig_15583_Introduction = {
    Text = "不同的情緒帶來不同的強力增益，並變化其狂氣爆發效果。"
  },
  AwakerConfig_15583_Name = {Text = "奧爾拉"},
  AwakerConfig_15583_SummonSlogan = {
    Text = "當心，她的悲傷可比玫瑰刺棘棘手得多。"
  },
  AwakerConfig_15583_Title = {Text = "奧爾拉"},
  AwakerConfig_15583_VoiceActor = {Text = "橘由紀"},
  AwakerConfig_15584_AwakerIntroduction = {
    Text = "\n·生命越低，傷害和回復越強。\n·提前積攢胚胎，通過無限<DevouredIconKeywords:吞噬>的狂氣爆發來一次性打出大量傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的索蕾爾出戰，初始生命為 40%。"
  },
  AwakerConfig_15584_Characteristic = {
    Text = "多次傷害    生命回復"
  },
  AwakerConfig_15584_Introduction = {
    Text = "以華麗的輪舞造成高額次數的傷害，並以敵人鮮血治癒自身。"
  },
  AwakerConfig_15584_Name = {Text = "索蕾爾"},
  AwakerConfig_15584_SummonSlogan = {
    Text = "端上來吧，那些繡金的華麗禮服；端上來吧，那些異國鳥羽製成的羽扇。端上來吧，只有這樣，才能獲得她的沙龍的邀請。"
  },
  AwakerConfig_15584_Title = {Text = "索蕾爾"},
  AwakerConfig_15585_Characteristic = {
    Text = "驅散脆弱    臨時力量"
  },
  AwakerConfig_15585_Height = {
    Text = "他堅信自己身高五尺"
  },
  AwakerConfig_15585_Introduction = {
    Text = "以無形黏液凝結障壁，並舉起長槍指引隊友發起衝鋒號角。"
  },
  AwakerConfig_15585_Name = {Text = "奧吉爾"},
  AwakerConfig_15585_SummonSlogan = {
    Text = "「我不會再讓任何人受傷。」"
  },
  AwakerConfig_15585_Title = {Text = "奧吉爾"},
  AwakerConfig_15585_VoiceActor = {
    Text = "音羽裡奏"
  },
  AwakerConfig_15586_AwakerIntroduction = {
    Text = "·擁有強大的<RetaliateIconKeywords:反擊>能力和額外觸發躍遷的獨特效果\n·打出卡牌積攢「夢引」，靈活的消耗「夢引」強化自身能力\n·堆疊<RetaliateIconKeywords:反擊>，削弱敵人，利用<RetaliateIconKeywords:反擊>增加傷害\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「旺達」出戰。"
  },
  AwakerConfig_15586_Characteristic = {
    Text = "高額反擊    觸發躍遷"
  },
  AwakerConfig_15586_Introduction = {
    Text = "以周身棘刺疊加大量反擊來擊穿來犯敵人，並且將棘刺揮舞造成傷害。"
  },
  AwakerConfig_15586_Name = {Text = "旺達"},
  AwakerConfig_15586_SummonSlogan = {
    Text = "盲眼奴從莊嚴宣誓，吟誦崇高的律令：靠近她、服從她……然後永遠愛她。"
  },
  AwakerConfig_15586_Title = {Text = "旺達"},
  AwakerConfig_15587_AwakerIntroduction = {
    Text = "·狂氣爆發可以大幅提升本回合中「打擊」造成的傷害。\n·手牌中的「打擊」越多，「破鏈一擊」的傷害越高，享受的<PowerIconKeywords:力量>加成越高，配合狂氣爆發可一次性造成大量傷害。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的希洛出戰，戰鬥開始時獲得 3 張「打擊」，每回合獲得 30 <EmbryoFusionIconKeywords:胚胎融合>，10 點狂氣，6 點<PowerIconKeywords:力量>，敵人首回合將獲得強化。"
  },
  AwakerConfig_15587_Characteristic = {
    Text = "單段高傷    力量成長"
  },
  AwakerConfig_15587_Introduction = {
    Text = "不斷隱忍繼續力量，一擊為敵人帶來終結的復仇者。"
  },
  AwakerConfig_15587_SummonSlogan = {
    Text = "她所渴求的，從來都不是鮮血。"
  },
  AwakerConfig_15587_VoiceActor = {
    Text = "國実久留子"
  },
  AwakerConfig_15588_AwakerIntroduction = {
    Text = "·擁有強大的防護和單體傷害能力，護盾越高，「心眼利刃」造成的傷害越高。\n·靈知覺醒後，艾爾瓦造成的所有傷害都將享受護盾加成。\n·「臨戰體勢」擁有驅散封印能力，狂氣爆發還可以棄掉症狀或狀態卡，額外獲得抽牌。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的艾爾瓦出戰，敵人首回合將獲得強化。"
  },
  AwakerConfig_15588_Characteristic = {
    Text = "對抗塞卡    戒備提升"
  },
  AwakerConfig_15588_Introduction = {
    Text = "久經戰場的戰士擅長堆疊大量護盾，並將護盾轉化為利刃進行攻擊。"
  },
  AwakerConfig_15588_Name = {Text = "艾爾瓦"},
  AwakerConfig_15588_SummonSlogan = {
    Text = "戰場奪去了她的肢體，卻永遠不會磨滅她的靈魂。"
  },
  AwakerConfig_15588_Title = {Text = "艾爾瓦"},
  AwakerConfig_15588_VoiceActor = {
    Text = "二宮雪乃"
  },
  AwakerConfig_15589_AwakerIntroduction = {
    Text = "·身為蹈海者崇敬的神母，她制定新的秩序庇佑著所有臣民，大幅強化深海界域基礎效果。\n·倒錯的命運賦予其無上的權能，能夠將敵人的生命作為進獻神明的祭品，但禁忌的權力往往需要支付高昂的代價……\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「誕妄·墨菲」和「圖魯」出戰。"
  },
  AwakerConfig_15589_Characteristic = {
    Text = "觸腕激發    補充算力"
  },
  AwakerConfig_15589_Introduction = {
    Text = "身為神母的她賜福與庇佑著臣民，無上的權力能夠將敵人的生命轉化為進獻神明的祭品。"
  },
  AwakerConfig_15589_Name = {
    Text = "誕妄·墨菲"
  },
  AwakerConfig_15589_SummonSlogan = {
    Text = "她獻身於神明的誕禮，以骨血兌現永恆的虛妄。"
  },
  AwakerConfig_15589_Title = {
    Text = "誕妄·墨菲"
  },
  AwakerConfig_15590_AwakerIntroduction = {
    Text = "·擁有可成長的傷害手段和強大的組合爆發能力\n·狂氣爆發可以在任何時機創造出完美卡牌\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「達芙黛爾」出戰，每回合額外獲得 10 點狂氣。"
  },
  AwakerConfig_15590_Characteristic = {
    Text = "萬能創造    易傷敵人"
  },
  AwakerConfig_15590_Introduction = {
    Text = "能夠自訂強力的千面幻象，並將其置入超維空間的魔女。"
  },
  AwakerConfig_15590_Name = {
    Text = "達芙黛爾"
  },
  AwakerConfig_15590_SummonSlogan = {
    Text = "她的小店什麼都有，只是——小心她索取的報酬。"
  },
  AwakerConfig_15590_Title = {
    Text = "達芙黛爾"
  },
  AwakerConfig_15590_VoiceActor = {
    Text = "小清水亞美"
  },
  AwakerConfig_15591_Characteristic = {
    Text = "石化控制    易傷敵人"
  },
  AwakerConfig_15591_Introduction = {
    Text = "以凝結之眼石化敵人使其無法行動，並變得易碎。"
  },
  AwakerConfig_15591_Name = {Text = "艾繼絲"},
  AwakerConfig_15591_SummonSlogan = {
    Text = "剝落的石屑，正是她守護珍愛之物的證明。"
  },
  AwakerConfig_15591_Title = {Text = "艾繼絲"},
  AwakerConfig_15592_AwakerIntroduction = {
    Text = "·擁有強大的防護和永久生成觸腕能力，觸腕越多防護能力越強。\n·狂氣爆發可以造成群體傷害，護盾可以提升本次造成的傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的珊出戰，敵人首回合將獲得強化。"
  },
  AwakerConfig_15592_Characteristic = {
    Text = "持續防護    觸腕成長"
  },
  AwakerConfig_15592_Introduction = {
    Text = "持續不斷的雕刻石壁防禦後續攻擊，失落的藝術在護盾越高時傷害就越強。"
  },
  AwakerConfig_15592_SummonSlogan = {
    Text = "除了溫和秀美，銳利而具有攻擊性也是藝術的一部分。"
  },
  AwakerConfig_15592_VoiceActor = {
    Text = "音羽裡奏"
  },
  AwakerConfig_15593_AwakerIntroduction = {
    Text = "「集結鼠群」消耗算力生成<DerivativeCardKeywords_12:「鼠群衝擊」>，消耗算力越多，傷害次數越高，可以通過積攢算力一次打出超高傷害。\n·每次打出「布朗出動！」後，都能使「布朗出動！」和<DerivativeCardKeywords_12:「鼠群衝擊」>傷害獲得提升。\n·狂氣爆發和靈知覺醒可以提升詹金的暴擊率和暴擊傷害，進一步強化詹金的輸出能力。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的詹金出戰，每回合將獲得 1 張<DerivativeCardKeywords_4:「靈感」>，敵人首回合獲得強化。"
  },
  AwakerConfig_15593_Characteristic = {
    Text = "多次傷害    暴擊"
  },
  AwakerConfig_15593_Introduction = {
    Text = "有著高額的暴擊率和暴擊傷害，布朗和鼠群會成為他對抗多名敵人的關鍵助力。"
  },
  AwakerConfig_15593_SummonSlogan = {
    Text = "小看老鼠可是要付出慘痛代價的哦！"
  },
  AwakerConfig_15594_AwakerIntroduction = {
    Text = "·擁有強大的生命回復和堆疊<RetaliateIconKeywords:反擊>的能力，在面對多段傷害的敵人時表現出色。\n·狂氣爆發和「逆鱗之護」可以造成更多的<RetaliateIconKeywords:反擊>傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的凱刻斯出戰，每回合將獲得 10 點狂氣，敵人首回合獲得強化。"
  },
  AwakerConfig_15594_Characteristic = {
    Text = "反擊敵人    觸腕傷害"
  },
  AwakerConfig_15594_Introduction = {
    Text = "張開全身鱗刺，反擊來犯的敵人，並以血脈之力回復自身生命。"
  },
  AwakerConfig_15594_Name = {Text = "凱刻斯"},
  AwakerConfig_15594_SummonSlogan = {
    Text = "鰓痕、鱗片……血脈的證明是他僅剩的信念。"
  },
  AwakerConfig_15594_Title = {Text = "凱刻斯"},
  AwakerConfig_15595_Characteristic = {
    Text = "檢索卡牌    多次傷害"
  },
  AwakerConfig_15595_Introduction = {
    Text = "為你的隊伍提供最需要的卡牌支援，並以逐漸迅疾的劍術刺穿對手。"
  },
  AwakerConfig_15595_SummonSlogan = {
    Text = "觀察，感受，思考。"
  },
  AwakerConfig_15595_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_15596_AwakerIntroduction = {
    Text = "·擁有獨特的複製卡牌能力，複製後的卡牌算力消耗還會降低。\n·靈知覺醒可獲得<DerivativeCardKeywords_10:聖潔之子>，被血肉狂氣爆發吞噬後觸發 2 次吞噬效果，釋放鑰令時還能將<DerivativeCardKeywords_2:「胚胎」>轉換成<DerivativeCardKeywords_10:聖潔之子>。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「泰旖絲」和「拉蒙娜」喚醒體、小小心願鑰令出戰。"
  },
  AwakerConfig_15596_Characteristic = {
    Text = "複製卡牌    狂氣供給"
  },
  AwakerConfig_15596_Introduction = {
    Text = "孕育聖樹之子使吞噬效果多次發動，並以豐穰之儀模仿友方技能。"
  },
  AwakerConfig_15596_Name = {Text = "泰旖絲"},
  AwakerConfig_15596_SummonSlogan = {
    Text = "「成為我的僕從，我的戰士，我的……孩子。」"
  },
  AwakerConfig_15596_Title = {Text = "泰旖絲"},
  AwakerConfig_15596_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_15597_AwakerIntroduction = {
    Text = "·狂氣爆發可以回復較多生命，生命越低回復越多。\n·靈知覺醒後，打出自身指令卡可以提升<EmbryoFusionIconKeywords:胚胎融合>，從而獲得更多的<DerivativeCardKeywords_2:「胚胎」>，為血肉隊伍提供資源支持。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的雷婭出戰。"
  },
  AwakerConfig_15597_Characteristic = {
    Text = "生命回復    力量提升"
  },
  AwakerConfig_15597_Introduction = {
    Text = "將自身的痛楚轉化為力量，在低生命時能夠大量回復。"
  },
  AwakerConfig_15597_Name = {Text = "雷婭"},
  AwakerConfig_15597_SummonSlogan = {
    Text = "「啜飲吧，這甘美的死亡。」"
  },
  AwakerConfig_15597_Title = {Text = "雷婭"},
  AwakerConfig_15597_VoiceActor = {
    Text = "小阪帆夏"
  },
  AwakerConfig_15598_AwakerIntroduction = {
    Text = "·狂氣爆發可以造成高額的群體傷害，同時享受高額的<PowerIconKeywords:力量>加成。\n·當狂氣爆發觸發<DevouredIconKeywords:吞噬>後，本場戰鬥後續釋放的狂氣爆發傷害和<PowerIconKeywords:力量>加成獲得提升。\n·生命越低傷害越高。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的尤烏哈希出戰，每回合獲得 30 <EmbryoFusionIconKeywords:胚胎融合>，敵人前兩回合將獲得強化。"
  },
  AwakerConfig_15598_Characteristic = {
    Text = "狂氣爆發    越戰越勇"
  },
  AwakerConfig_15598_Introduction = {
    Text = "不停戰鬥並不斷變得更強的狂戰士，低生命的時候會更加強大。"
  },
  AwakerConfig_15598_Name = {
    Text = "尤烏哈希"
  },
  AwakerConfig_15598_SummonSlogan = {
    Text = "他不放過任何一個搗碎敵人的機會。"
  },
  AwakerConfig_15598_Title = {
    Text = "尤烏哈希"
  },
  AwakerConfig_15598_VoiceActor = {
    Text = "森田繪音"
  },
  AwakerConfig_15599_AwakerIntroduction = {
    Text = "·擁有獨特的積攢猩紅熔爐能力，能從指令卡、生命、甚至是敵人傷害中積攢猩紅熔爐回復量。\n·能靈活將猩紅熔爐回復量轉化為大量護盾或傷害。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的薩爾瓦多出戰，初始擁有 50% 暴擊率，每回合將獲得 20 點狂氣，但敵人前兩回合將獲得 150 點臨時力量。"
  },
  AwakerConfig_15599_Characteristic = {
    Text = "算力支援    護盾轉輸出"
  },
  AwakerConfig_15599_Introduction = {
    Text = "無盡的仁愛能夠積攢猩紅熔爐，在受傷時給予應急支援。"
  },
  AwakerConfig_15599_Name = {
    Text = "薩爾瓦多"
  },
  AwakerConfig_15599_SummonSlogan = {
    Text = "「引領前路吧，神諭中的救世主，將我們帶往那無苦的未來。」"
  },
  AwakerConfig_15599_Title = {
    Text = "薩爾瓦多"
  },
  AwakerConfig_15600_AwakerIntroduction = {
    Text = "·擁有強大的防護和施加<IntoxicationIconKeywords:中毒>的能力，觸發吞噬可獲得永久攻防成長的能力。\n·「不耐的施捨」擁有使當前<EmbryoFusionIconKeywords:胚胎融合>翻倍的能力。\n·觸發吞噬時，「蒼白迴旋」還可以從棄牌堆回到手牌，一回合可被打出多次。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的阿格里帕出戰，每回合獲得 30 <EmbryoFusionIconKeywords:胚胎融合>，10 點狂氣。"
  },
  AwakerConfig_15600_Characteristic = {
    Text = "戒備成長    中毒連擊"
  },
  AwakerConfig_15600_Introduction = {
    Text = "提供大量胚胎融合的同時，對敵人注入毒素來破壞其神志。"
  },
  AwakerConfig_15600_SummonSlogan = {
    Text = "在她構築的迷宮中，迷失的可不止是方向。"
  },
  AwakerConfig_15601_AwakerIntroduction = {
    Text = "·擁有抑鬱和躁狂兩種姿態，初始為抑鬱姿態，釋放狂氣爆發會切換姿態，不同姿態下卡牌效果不同。\n·狂氣爆發和靈知覺醒在不同界域下，都擁有獨特的效果，狂氣爆發還會根據抑鬱和躁狂姿態觸發不同效果。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的「24」和不同界域隊友出戰。"
  },
  AwakerConfig_15601_Characteristic = {
    Text = "單段高傷    狂氣爆發增幅"
  },
  AwakerConfig_15601_Introduction = {
    Text = "以不同形態適應不同界域的隊伍，在「抑鬱」和「躁狂」人格之間不斷切換的獵手。"
  },
  AwakerConfig_15601_SummonSlogan = {
    Text = "歇斯底里、癔症、神經衰弱、癲癇……總而言之，就是瘋女人。"
  },
  AwakerConfig_15601_VoiceActor = {
    Text = "伊藤紗月"
  },
  AwakerConfig_15602_AwakerIntroduction = {
    Text = "·平時是一名提供可靠支援能力的研究者，能夠在提供大量狂氣的同時強化友方或削弱敵人。\n·在首領戰中她將逐漸驅動毀滅的引擎，積攢「終末」後釋放「虛無終結」造成大量傷害，並變得充滿進攻性直至戰鬥結束。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的熔燬·朵爾和寧菲亞出戰，回合開始時熔燬·朵爾額外獲得 50 點狂氣和 1 層「終末」。"
  },
  AwakerConfig_15602_Characteristic = {
    Text = "生命回復    單段高傷"
  },
  AwakerConfig_15602_Introduction = {
    Text = "在平時能夠為隊伍提供回復和大量狂氣，但首領戰中將驅動毀滅的引擎終結敵人。"
  },
  AwakerConfig_15602_Name = {
    Text = "熔燬·朵爾"
  },
  AwakerConfig_15602_SummonSlogan = {
    Text = "希望只會是讓人更加痛苦的毒藥。只有在徹底、迅速的毀滅中，所有人才能獲得真正的解脫。"
  },
  AwakerConfig_15602_Title = {
    Text = "熔燬·朵爾"
  },
  AwakerConfig_15602_VoiceActor = {
    Text = "魚穀佳代"
  },
  AwakerConfig_15603_Characteristic = {
    Text = "攻防兼備    形態轉換"
  },
  AwakerConfig_15603_Introduction = {
    Text = "能夠短暫性提供爆發力量或戒備，無論是攻擊還是防禦都是好手。"
  },
  AwakerConfig_15603_SummonSlogan = {
    Text = "她是彌薩格最大的資料庫，是最萬能的檢索機。"
  },
  AwakerConfig_15604_AwakerIntroduction = {
    Text = "·狂氣爆發和技能都具有隨機性，運氣越好收益越高。\n·靈知覺醒可獲得或選擇升級「混沌的遺贈」。\n·在本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的萊克和蘿坦出戰，初始萊克擁有 25% 暴擊率加成、所有的「混沌的遺贈」造物與額外一套卡牌，敵人第一回合獲得臨時強化。"
  },
  AwakerConfig_15604_Characteristic = {
    Text = "補充手牌    黑印獲取"
  },
  AwakerConfig_15604_Introduction = {
    Text = "抽取大量卡牌的同時，通過掉落黑印贏取混沌的遺贈造物，使萊克變得更強。"
  },
  AwakerConfig_15604_Name = {Text = "萊克"},
  AwakerConfig_15604_SummonSlogan = {
    Text = "「再賭最後一把如何？這一次，就賭上你我的未來。」"
  },
  AwakerConfig_15604_Title = {Text = "萊克"},
  AwakerConfig_54116_AwakerIntroduction = {
    Text = "·全知的智者，擁有無窮的智慧，嫻熟地掌握所有的技能，在無數種可能性中尋找最佳的道路。\n·既能夠為隊伍提供大量的銀鑰能量，也可以將銀鑰能量轉化為翅翼打擊敵方。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的塔薇和蘿坦出戰，戰鬥開始時獲得 100 狂氣，銀鑰充能提高 50 。"
  },
  AwakerConfig_54116_Gi = {
    Text = "無法估測"
  },
  AwakerConfig_54116_Introduction = {
    Text = "塔薇通曉一切，能夠將一切技能為她所用，並將銀鑰作為資源來進行攻擊。"
  },
  AwakerConfig_54116_SummonSlogan = {
    Text = "穿越窮極之門，世界的終極奧秘將對你敞開。"
  },
  AwakerConfig_54116_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_54117_AwakerIntroduction = {
    Text = "·優雅而靈活的操縱音符，既能夠降低卡牌的算力消耗，也能使其額外觸發多次效果。\n·震顫靈魂的音波攻擊能夠對敵人造成連綿不斷的穿刺傷害，並削弱其戰鬥意志，瓦解敵人的防禦。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3 的哈姆林出戰，每回合額外獲得 35 狂氣。"
  },
  AwakerConfig_54117_Introduction = {
    Text = "用回環樂音造成傷害的同時讓卡牌多次生效，連綿的樂音還能夠創造大量「靈感」。"
  },
  AwakerConfig_54117_SummonSlogan = {
    Text = "所有的音符，都將隨指揮棒的軌跡起舞。"
  },
  AwakerConfig_54117_VoiceActor = {
    Text = "野宮一範"
  },
  AwakerConfig_77911_Name = {Text = "禿鷲"},
  AwakerConfig_77911_Title = {Text = "禿鷲"},
  AwakerConfig_77913_AwakerIntroduction = {
    Text = "·焚盡一切的爆燃之主，漫天活焰裹噬所有試圖阻擋她的敵人。\n·殘留的活焰化為爆炎不斷積存，無法抑制的能量耀斑將在達到閾值後轟然迸發！\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的凱蒂古拉出戰，每回合額外獲得 5 點算力、30 點狂氣、50 點力量。"
  },
  AwakerConfig_77913_Introduction = {
    Text = "以熾熱之火焚燒萬物的烈陽，消耗更多算力可以大幅提升卡牌效果。"
  },
  AwakerConfig_77913_Name = {
    Text = "凱蒂古拉"
  },
  AwakerConfig_77913_SummonSlogan = {
    Text = "她是永不落下的太陽，祂將帶來平等的死亡。"
  },
  AwakerConfig_77913_Title = {
    Text = "凱蒂古拉"
  },
  AwakerConfig_77913_VoiceActor = {
    Text = "鳥羽優好"
  },
  AwakerConfig_77914_Name = {
    Text = "蘭提戈斯"
  },
  AwakerConfig_77914_Title = {
    Text = "蘭提戈斯"
  },
  AwakerConfig_77917_AwakerIntroduction = {
    Text = "·虔誠而尊貴的提燈聖子，純潔的聖心永遠追逐光明。\n·運用聖輝之力週期性強化卡牌效果，運用聖子的權能裁決一切漆黑的罪惡。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的波呂克斯出戰，每回合獲得 50 狂氣和 1 張「靈感」。"
  },
  AwakerConfig_77917_Introduction = {
    Text = "運用聖輝之力週期性強化卡牌效果，運用聖子的權能裁決一切漆黑的罪惡。"
  },
  AwakerConfig_77917_Name = {
    Text = "波呂克斯"
  },
  AwakerConfig_77917_SummonSlogan = {
    Text = "聖心照耀之下，沒有罪人能逃離聖子的審判。"
  },
  AwakerConfig_77917_Title = {
    Text = "波呂克斯"
  },
  AwakerConfig_77918_AwakerIntroduction = {
    Text = "·被命運束縛的編織者，不斷編織使她變得更強，但也會承受更大的代價。\n·透過編織布下名為「命運」的網守護友方並賦予其稜鏡之力，累積的「裁斷」將於關鍵時刻驟然收緊剪除污物。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的阿拉克涅和寧菲亞出戰。\n·本場戰鬥中所有喚醒體施加的中毒提高200%。回合開始時所有喚醒體獲得 30 狂氣，獲得 1 層「織命」，獲得 3 點算力並抽 3 張牌。"
  },
  AwakerConfig_77918_Introduction = {
    Text = "命運的織者，她以絲線編織命運守護紡輪下的安寧，以裁斷之力剪除污物。"
  },
  AwakerConfig_77918_SummonSlogan = {
    Text = "萬千絲線於阿拉克涅的紡輪中匯集。她為木偶編織既定的命運，她為自己編織永恆的囚籠。"
  },
  AwakerConfig_77918_VoiceActor = {
    Text = "大西沙織"
  },
  AwakerConfig_77921_AwakerIntroduction = {
    Text = "·自稱「仙女教母」的嬌小少女，總能窺見他人深藏的心願，因而受到眾多教徒的虔心供奉。\n·她慣於用「賜福」換取信徒的供奉，待供奉積攢充足，便會將其盡數享用，化作滋養自身的力量，恩惠與索取，本就是她的一體兩面。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的卡拉布出戰，戰鬥開始時獲得 300 點力量。回合開始時，將 1 張「胚胎」置入手中，所有喚醒體獲得 20 狂氣。"
  },
  AwakerConfig_77921_Introduction = {
    Text = "仙女饋贈的禮物早已在暗中標好了價格，蒼白的身軀吞噬無數貪婪的冤魂。"
  },
  AwakerConfig_77921_SummonSlogan = {
    Text = "仙女賜福，歡迎供奉！這位恩公，來點什麼價位的？"
  },
  AwakerConfig_77921_VoiceActor = {
    Text = "釘宮理惠"
  },
  AwakerConfig_77922_AwakerIntroduction = {
    Text = "·堅毅的少女，視死如歸的她在面對死亡的威脅時能夠爆發無限的潛力。\n·船隻的領航者，夜空中的冷光，能夠在生成大量觸腕的同時重新構築手牌，配合「餘波」效果為你指引通向勝利的航線。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的克珀珊特出戰，每回合額外抽 2 張牌，獲得 1 條觸腕。"
  },
  AwakerConfig_77922_Introduction = {
    Text = "夜空中的冷光，能夠在生成大量觸腕的同時重新構築手牌，配合「餘波」效果發揮更大的潛力。"
  },
  AwakerConfig_77922_SummonSlogan = {
    Text = "她的責任、她的義務、她的生命都與船隻綁定，除此之外，別無他物。"
  },
  AwakerConfig_77923_AwakerIntroduction = {
    Text = "·不屈的孤嚎鳥，以羽翼吹動狂風護佑我方。\n·掉落的黑色羽翼能夠施加致命的「侵蝕」，使其本回合承受傷害時額外失去大量生命。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的卡斯托爾和詹金出戰。戰鬥開始時獲得 100 點狂氣，每回合獲得 30 點狂氣。"
  },
  AwakerConfig_77923_Introduction = {
    Text = "以羽翼吹動狂風護佑我方，掉落的黑色羽翼能夠施加致命的「侵蝕」使其承受傷害時失去大量生命。"
  },
  AwakerConfig_77923_Name = {
    Text = "卡斯托爾"
  },
  AwakerConfig_77923_SummonSlogan = {
    Text = "他是倔強不屈的飛鳥，如無自由寧願死亡。"
  },
  AwakerConfig_77923_Title = {
    Text = "卡斯托爾"
  },
  AwakerConfig_77924_Name = {
    Text = "夏塔克鳥"
  },
  AwakerConfig_77924_Title = {
    Text = "夏塔克鳥"
  },
  AwakerConfig_77925_AwakerIntroduction = {
    Text = "·溫和而優雅的心理醫師，與患者交流的過程中，能夠逐漸感知對方的情緒積攢「共感」。釋放狂氣爆發後，能夠消耗「共感」操縱其精神狀態，施加恐懼瓦解敵人的戰鬥意志，或植入創傷瞬間摧毀其心防。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的克萊門汀出戰，銀鑰充能提高 50，每回合獲得 20 狂氣。"
  },
  AwakerConfig_77925_Introduction = {
    Text = "積累共感，催眠敵人降低其傷害，或是創傷敵人使敵人受傷提高。"
  },
  AwakerConfig_77925_Name = {
    Text = "克萊門汀"
  },
  AwakerConfig_77925_SummonSlogan = {
    Text = "她掌控著心理諮詢的節奏，救贖或者毀滅，都在她的一念之間。"
  },
  AwakerConfig_77925_Title = {
    Text = "克萊門汀"
  },
  AwakerConfig_77925_VoiceActor = {
    Text = "國実久留子"
  },
  AwakerConfig_77926_AwakerIntroduction = {
    Text = "·熱忱於創作的殘骸繪者，其作品能夠為己方隊伍帶來各種靈性的增益。\n·勾勒線條的同時持續積攢創意，創意積攢至上限時如湧泉般迸發，將這場藝術的盛宴推向癲狂的極致！\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的皮克曼和蘿坦、奧吉爾、朵爾出戰，皮克曼每回合額外獲得 100 點狂氣，其他喚醒體獲得 30 點狂氣。"
  },
  AwakerConfig_77926_Introduction = {
    Text = "根據局勢靈活的創造不同繪卷，大幅強化其它喚醒體的狂氣爆發效果。"
  },
  AwakerConfig_77926_SummonSlogan = {
    Text = "他將用他的畫作，帶你一同見證世界的真相。"
  },
  AwakerConfig_77928_Name = {
    Text = "亞弗戈蒙"
  },
  AwakerConfig_77928_Title = {
    Text = "亞弗戈蒙"
  },
  AwakerConfig_78840_Characteristic = {
    Text = "檢索卡牌    多次傷害"
  },
  AwakerConfig_78840_Name = {
    Text = "熟悉的黑貓"
  },
  AwakerConfig_78840_Title = {
    Text = "彌薩格校貓"
  },
  AwakerConfig_78840_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_78841_Characteristic = {
    Text = "檢索卡牌    多次傷害"
  },
  AwakerConfig_78841_Name = {
    Text = "熟悉的黑貓"
  },
  AwakerConfig_78841_Title = {
    Text = "彌薩格校貓"
  },
  AwakerConfig_78841_VoiceActor = {
    Text = "山本亞衣"
  },
  AwakerConfig_94450_AwakerIntroduction = {
    Text = "·手持戰斧的活潑少女，在戰鬥中則會化身為狂熱的戰士，並能夠在逆境中爆發更強的戰鬥力。\n·與夥伴協同作戰時能夠極大激發茉夏的戰意，其攻勢會隨著打擊的使用而愈發淩厲。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的茉夏出戰，回合開始時獲得 50 狂氣、抽 3 張牌、獲得 3 點算力。"
  },
  AwakerConfig_94450_Gi = {Text = "不穩定"},
  AwakerConfig_94450_Introduction = {
    Text = "手持巨斧的活潑少女，在戰鬥中則會化身為狂熱的戰士，並能夠在逆境中爆發更強戰鬥力。"
  },
  AwakerConfig_94450_SummonSlogan = {
    Text = "霧境中的來客，將於銀與血中，在此世受洗重生。"
  },
  AwakerConfig_94450_VoiceActor = {
    Text = "長谷川育美"
  },
  AwakerConfig_94451_AwakerIntroduction = {
    Text = "·曾是含恨而死的騎士，如今體內仍翻湧著不受控的黑色淤泥，為新尋得的、值得守護之物而戰。\n·隨「暗湧」不斷積攢，傷害越發可觀，自身承受的負擔也愈重；關鍵時刻會將「暗湧」盡數化作守護之力。\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的負誓·奧吉爾出戰，回合開始時抽 3 張牌、獲得 3 點算力，所有喚醒體獲得 20 狂氣。"
  },
  AwakerConfig_94451_Introduction = {
    Text = "曾失去所有的騎士，當一切的罪都被背負，他重新立下守護的誓言。"
  },
  AwakerConfig_94451_Name = {
    Text = "負誓·奧吉爾"
  },
  AwakerConfig_94451_Title = {
    Text = "本源·奧吉爾"
  },
  AwakerConfig_95786_AwakerIntroduction = {
    Text = "·優雅的食者，為痛苦掙扎的靈魂帶來命定之死的解脫。\n·盡情地享用亡者的殘骸吧，食物的養分將化為你磅礴的生命與無窮的能量！\n·本次關卡中，將攜帶等級 50 級，技能等級5，啟靈3的杜勒賽因出戰，本場戰鬥中杜勒賽因造成的傷害必定暴擊。"
  },
  AwakerConfig_95786_Introduction = {
    Text = "優雅的食者，對剩餘生命較低的敵人造成可觀的傷害，享用亡者的殘骸時能夠強化自身並回復生命。"
  },
  AwakerConfig_95786_Name = {
    Text = "杜勒賽因"
  },
  AwakerConfig_95786_SummonSlogan = {
    Text = "他已聽見你的呼喚。他將邀請你，一同享用那魂靈的盛宴。"
  },
  AwakerConfig_95786_Title = {
    Text = "杜勒賽因"
  }
})
return Text_AwakerConfig
