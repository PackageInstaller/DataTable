__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "可在戰鬥中返回經歷過的回合，可返回至戰鬥的前 25 回合中的任意一個回合。"
  },
  Tutorial_120371_Title_1 = {
    Text = "時序逆行"
  },
  Tutorial_124999_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈-輪選模式>中，點擊介面右下角的「開始匹配」進入匹配，無需預組隊伍。"
  },
  Tutorial_124999_Desc_2 = {
    Text = "對戰前系統會隨機選取一個<TutorialHighlight:造物>，在對戰中生效。根據每局的造物效果，在隨機出的有限選項的卡池中輪流選取所需的喚醒體、命輪、鑰令，來構建自己的編隊與對方進行對戰。"
  },
  Tutorial_124999_Desc_3 = {
    Text = "通過點擊兩個喚醒體進行位置互換，以此來調整自己隊伍在對戰中的站位。站位前後按1-4的順序進行排列。"
  },
  Tutorial_124999_Title_1 = {
    Text = "輪選編隊"
  },
  Tutorial_126878_Desc_1 = {
    Text = "部分喚醒體的人格深化達到 +12 時自動獲得「最終法則」效果，每個喚醒體所獲得的效果都有所不同。"
  },
  Tutorial_126878_Desc_2 = {
    Text = "喚醒體的「最終法則」解鎖後，會收到一條相應喚醒體專屬的通訊器訊息，請守密人記得查收。"
  },
  Tutorial_126878_Title_1 = {
    Text = "最終法則"
  },
  Tutorial_126878_Title_2 = {
    Text = "專屬訊息"
  },
  Tutorial_148475_Desc_1 = {
    Text = "喚醒體同調率達到 <TutorialHighlight:Lv20> 後，可獲得專屬 <TutorialHighlight:曜閃>。"
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:曜閃>是你與喚醒體彼此為我的證明。"
  },
  Tutorial_148475_Desc_3 = {
    Text = "現在，該喚醒體的指令卡在戰鬥中將會特別呈現，並可在社交場合向其他守密人展示。"
  },
  Tutorial_148475_Title_1 = {
    Text = "彼此為我"
  },
  Tutorial_17805_Desc_1 = {
    Text = "點擊敵人可以查看它的所有狀態。<TutorialHighlight:警示>狀態需要更加重點關注，它代表敵人的特殊機制，守密人未能順利完成調查的多數原因往往是未關注到敵人的特殊機制。"
  },
  Tutorial_17805_Title_1 = {
    Text = "敵人狀態"
  },
  Tutorial_17806_Desc_1 = {
    Text = "戰勝敵人後可以選擇<TutorialHighlight:刻印>，也可以在<TutorialHighlight:融痕>中花費<TutorialHighlight:黑印>進行購買。<TutorialHighlight:刻印>可以讓指定卡獲得不同的額外效果。每張指定卡最多只能刻印 <TutorialHighlight:1> 次。優先為更經常打出的指令卡進行刻印，可以提升刻印帶來的收益。"
  },
  Tutorial_17807_Desc_1 = {
    Text = "為喚醒體提供多種屬性，若組成<TutorialHighlight:套裝>還會有特殊效果。共有6個部位，不同部位的<TutorialHighlight:主屬性>不同，暴擊率和暴擊傷害會出現在I、II、III部位；狂氣回充等級和銀鑰充能等級會出現在I、IV、V部位；界域精通和黑印掉落會出現在II、IV、VI部位；傷害強效和死亡抵抗會出現在III、V、VI部位。可以透過密契完成度來較為直觀的感受密契與密契套裝的強度。密契完成度可以透過升級與轉錄的方式進行強化。"
  },
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:幻夢深潛>玩法中，每次挑戰關卡會隨機進入一張地圖。挑戰成功後，根據挑戰的關卡難度、強化喚醒體與關卡內評分項獲得相應積分。 每週挑戰會有不同的初始造物與強化喚醒體。"
  },
  Tutorial_17808_Desc_2 = {
    Text = "幻夢深潛通常每 28 天會更新賽季，在賽季內通關一次幻夢深潛即可參與<TutorialHighlight:賽季排行>，賽季結束時將會結算排名，並透過郵箱發送排名獎勵。"
  },
  Tutorial_17808_Desc_3 = {
    Text = "「深潛紀錄」設立有多個目標，達成後可獲得相應獎勵。每次完成「深潛紀錄」目標或深潛挑戰勝利後都可獲得<TutorialHighlight:深潛經驗>。深潛經驗達到一定值時<TutorialHighlight:深潛等級>會提升，可以獲得豐富的獎勵。可以通過介面左下角的「深潛紀錄」與「深潛等級」進行查看。"
  },
  Tutorial_17808_Title_1 = {
    Text = "幻夢深潛"
  },
  Tutorial_17809_Desc_1 = {
    Text = "通過事件、融痕可以獲得<TutorialHighlight:造物>，<TutorialHighlight:造物>可以強化我方隊伍的作戰能力。優秀守密人往往可以根據隊伍的需要，選擇更契合的<TutorialHighlight:造物>。"
  },
  Tutorial_17810_Desc_1 = {
    Text = "驅散迷霧，地圖視野提升 <TutorialHighlight:2> 格，可以利用它做出更好的路線規劃。"
  },
  Tutorial_17810_Title_1 = {Text = "探照燈"},
  Tutorial_17811_Desc_1 = {
    Text = "處於<TutorialHighlight:中毒>狀態的目標在回合結束時，受到等同於<TutorialHighlight:中毒>層數的傷害。<TutorialHighlight:中毒>傷害<TutorialHighlight:無法暴擊>。"
  },
  Tutorial_17812_Desc_1 = {
    Text = "處於<TutorialHighlight:易傷>狀態的目標，受到的傷害提升 50% ，回合結束時自動移除 1 層<TutorialHighlight:易傷>。利用敵人處於<TutorialHighlight:易傷>狀態的時機，對其造成更多傷害。"
  },
  Tutorial_17812_Title_1 = {Text = "易傷"},
  Tutorial_17813_Desc_1 = {
    Text = "「融蝕之墟」、「禁忌纂錄」、「超驗存在」中關卡通關後，該關卡與更低難度的關卡可以進行<TutorialHighlight:重現>。通過<TutorialHighlight:重現>可以快速獲得關卡獎勵。"
  },
  Tutorial_17813_Title_1 = {Text = "重現"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:護盾>可以代替生命承擔傷害，回合結束時<TutorialHighlight:自動移除>所有護盾，護盾的上限等於隊伍的<TutorialHighlight:生命上限>。盡可能地<TutorialHighlight:讓護盾等同於本回合所有敵人的傷害總量>，用最小的代價獲得戰鬥勝利。"
  },
  Tutorial_17814_Title_1 = {Text = "護盾"},
  Tutorial_17815_Desc_1 = {
    Text = "重複獲得喚醒體會將其轉化為<TutorialHighlight:殘片>。消耗<TutorialHighlight:殘片>提升喚醒體啟靈等級，可以使喚醒體的技能獲得額外的特殊能力。喚醒體啟靈等級已滿時再獲得對應殘片，將轉化為<TutorialHighlight:靈魂回溯碎片>。"
  },
  Tutorial_17815_Title_1 = {Text = "殘片"},
  Tutorial_17816_Desc_1 = {
    Text = "算力為<TutorialHighlight:全隊共用>，打出卡牌需要消耗<TutorialHighlight:算力>。算力會在回合開始時<TutorialHighlight:自動恢復至上限>，在回合結束後<TutorialHighlight:自動清空>。為了提升算力利用效率，請儘量<TutorialHighlight:消耗所有算力後再結束回合>。"
  },
  Tutorial_17817_Desc_1 = {
    Text = "戰勝<TutorialHighlight:超驗存在>中的敵人，可以獲得高階的<TutorialHighlight:技能升級素材>，每週可以獲取1次獎勵。各種材料還可以在<TutorialHighlight:冶煉室>進行合成和置換。"
  },
  Tutorial_17817_Title_1 = {
    Text = "超驗存在"
  },
  Tutorial_17818_Desc_1 = {
    Text = "獲得後可在<TutorialHighlight:物資中使用>，能按照預設值快速提升喚醒體等級和技能等級。"
  },
  Tutorial_17818_Title_1 = {
    Text = "靈知增幅器"
  },
  Tutorial_17819_Desc_1 = {
    Text = "當喚醒體狂氣達到 <TutorialHighlight:100> 時可以釋放<TutorialHighlight:狂氣爆發>。不同喚醒體的狂氣爆發效果不同，合理利用可以<TutorialHighlight:事半功倍>。"
  },
  Tutorial_17819_Title_1 = {
    Text = "狂氣爆發"
  },
  Tutorial_17820_Desc_1 = {
    Text = "處於<TutorialHighlight:脆弱>狀態的目標，獲得的護盾降低 25% ，回合結束時自動移除 1 層<TutorialHighlight:脆弱>。若我方隊伍處於<TutorialHighlight:脆弱>狀態，記得在防守前想辦法移除<TutorialHighlight:脆弱>狀態，或者改變策略，在本回合中全力進攻。"
  },
  Tutorial_17821_Desc_1 = {
    Text = "為喚醒體裝備<TutorialHighlight:命輪>，可以提升喚醒體的屬性，還可以獲得特殊能力。"
  },
  Tutorial_17821_Title_1 = {Text = "命輪"},
  Tutorial_17822_Desc_1 = {
    Text = "處於<TutorialHighlight:出血>狀態的目標在回合結束時，受到等同於<TutorialHighlight:出血>層數的傷害然後<TutorialHighlight:移除出血狀態>。\n<TutorialHighlight:回復生命>時移除等同於<TutorialHighlight:回復量 2 倍>的出血層數。出血傷害<TutorialHighlight:無法暴擊>。"
  },
  Tutorial_17823_Desc_1 = {
    Text = "混沌喚醒體可以<TutorialHighlight:突破界域限制>與其他界域的喚醒體編隊，並且會有不同的共生效果。任意隊伍中如果存在混沌喚醒體，可以額外獲得 100% 死亡抵抗。"
  },
  Tutorial_17823_Desc_2 = {
    Text = "相較於其他界域的隊伍，混沌界域隊伍獲得銀鑰能量的速度更快，且釋放第二次鑰令時，能夠在所有鑰令中進行選擇，並且選擇的鑰令會觸發 2 次。因此混沌界域隊伍更依賴與鑰令間的協作，選擇合適的鑰令可以極大增強混沌界域隊伍的實力！"
  },
  Tutorial_17824_Desc_1 = {
    Text = "每擁有 1 點<TutorialHighlight:戒備>，每次獲得護盾時將額外獲得 1 點護盾。"
  },
  Tutorial_17824_Title_1 = {Text = "戒備"},
  Tutorial_17825_Desc_1 = {
    Text = "首次完成調查行動後可以獲得<TutorialHighlight:共鳴啟動材料>，它們可用於啟動強大的<TutorialHighlight:共鳴>，共鳴會在這一章的所有關卡中生效。"
  },
  Tutorial_17825_Title_1 = {Text = "共鳴"},
  Tutorial_17826_Desc_1 = {
    Text = "我方隊伍處於<TutorialHighlight:狂氣封印>狀態時，無法釋放狂氣爆發。在敵人即將造成<TutorialHighlight:狂氣封印>前，可以釋放狂氣爆發避免浪費狂氣。"
  },
  Tutorial_17826_Title_1 = {
    Text = "狂氣封印"
  },
  Tutorial_17827_Desc_1 = {
    Text = "消耗<TutorialHighlight:靈知製劑>可以提升喚醒體等級，喚醒體升級後屬性將會提升。達到等級上限之後需要先進行升格，升格後會提高喚醒體等級上限。"
  },
  Tutorial_17827_Title_1 = {
    Text = "靈知製劑"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:力量>每降低 1 點，每次造成<TutorialHighlight:主動傷害>時將降低 1 點傷害。"
  },
  Tutorial_17829_Desc_1 = {
    Text = "每次受到傷害前，免疫傷害並移除 1 層<TutorialHighlight:屏障>。單次傷害越高，<TutorialHighlight:屏障>帶來的收益越高。"
  },
  Tutorial_17830_Desc_1 = {
    Text = "處於<TutorialHighlight:虛弱>狀態的目標，造成的傷害降低 25% ，回合結束時自動移除 1 層<TutorialHighlight:虛弱>。若我方隊伍處於<TutorialHighlight:虛弱>狀態，記得在進攻前想辦法移除<TutorialHighlight:虛弱>狀態，或者改變策略，在本回合中全力防守。"
  },
  Tutorial_17830_Title_1 = {Text = "虛弱"},
  Tutorial_17831_Desc_1 = {
    Text = "戰勝<TutorialHighlight:禁忌纂錄>中的敵人，可以獲得提升喚醒體能力的<TutorialHighlight:密契>。每通關一章主線會解鎖新的<TutorialHighlight:禁忌纂錄>關卡。密契還可以通過商店進行兌換。"
  },
  Tutorial_17831_Title_1 = {
    Text = "禁忌纂錄"
  },
  Tutorial_17832_Desc_1 = {
    Text = "超維隊伍每回合打出的<TutorialHighlight:第 1 張>指令卡的臨時複製會進入<TutorialHighlight:超維空間>並觸發強大的躍遷效果。當超維空間達到上限時，獲得 1 個額外的<TutorialHighlight:超維回合>，<TutorialHighlight:超維回合能觸發所有躍遷效果>。玩好超維隊伍的基礎秘訣：仔細規劃每回合打出的第 1 張牌。"
  },
  Tutorial_17832_Title_1 = {Text = "超維"},
  Tutorial_17833_Desc_1 = {
    Text = "當我方隊伍生命值耗盡時，可以啟用<TutorialHighlight:應急靈知體>恢復所有狀態。應急靈知體每天自動恢復 <TutorialHighlight:1>個，上限 <TutorialHighlight:5 >個。合理地將應急靈知體應用在<TutorialHighlight:高難戰鬥>中，切勿隨意浪費。"
  },
  Tutorial_17833_Title_1 = {
    Text = "應急靈知體"
  },
  Tutorial_17834_Desc_1 = {
    Text = "仔細搜尋地圖上微微發光的地點，前往調查說不定會有意外收穫。"
  },
  Tutorial_17834_Title_1 = {Text = "析出點"},
  Tutorial_17835_Desc_1 = {
    Text = "代表所有敵人本回合的傷害總量。一條簡單實用的守密人作戰經驗：<TutorialHighlight:盡可能讓護盾等同於敵方傷害總量>。"
  },
  Tutorial_17835_Title_1 = {
    Text = "敵方傷害總量"
  },
  Tutorial_17837_Desc_1 = {
    Text = "血肉隊伍的<TutorialHighlight:胚胎融合>達到上限時將會獲得  1 張<TutorialHighlight:「胚胎」>，釋放狂氣爆發會消耗<TutorialHighlight:「胚胎」>觸發強大<TutorialHighlight:吞噬>效果，因此盡可能地在手牌中有<TutorialHighlight:「胚胎」>時釋放狂氣爆發，否則無法發揮血肉隊伍的最大實力。"
  },
  Tutorial_17837_Desc_2 = {
    Text = "每場戰鬥結束後會積攢5%最大生命的回復量進入猩紅熔爐，若有未使用的<TutorialHighlight:「胚胎」>，每個胚胎也會積攢5%最大生命的回復量進入熔爐。 猩紅熔爐可用於回復我方隊伍的生命，每回合可以轉化熔爐為生命1次。守密人需合理規劃猩紅熔爐的使用時機，從而達到扭轉戰局的效果。"
  },
  Tutorial_17838_Desc_1 = {
    Text = "在聯絡點中，你可以選擇恢復我方隊伍已損失生命的50%，或指定覺醒 1 名喚醒體。當我方隊伍生命較低時，推薦選擇回復生命，否則推薦選擇覺醒喚醒體。"
  },
  Tutorial_17838_Title_1 = {Text = "聯絡處"},
  Tutorial_17839_Desc_1 = {
    Text = "用於消耗黑印強化我方隊伍的場所，一般會提供1欄刻印，1欄白銀造物，1欄黃金造物。如果這裡沒有需要的物品，可以點擊右上角的<TutorialHighlight:刷新>，融痕會提供新的物品。"
  },
  Tutorial_17840_Desc_1 = {
    Text = "強行通過<TutorialHighlight:幻象>將會感染「症狀」。"
  },
  Tutorial_17841_Desc_1 = {
    Text = "通過指令卡可以讓喚醒體獲得<TutorialHighlight:狂氣>，指令卡的技能等級越高，獲得的狂氣越多。"
  },
  Tutorial_17841_Title_1 = {Text = "狂氣"},
  Tutorial_17842_Desc_1 = {
    Text = "戰勝敵人、調查事件可以獲得<TutorialHighlight:黑印>，喚醒體的<TutorialHighlight:黑印掉落>屬性可以提升獲得的黑印數量。"
  },
  Tutorial_17842_Desc_2 = {
    Text = "在融痕中可以消耗<TutorialHighlight:黑印>購買刻印和造物，也可以用來覺醒喚醒體。在最終戰前，請盡可能地花光所有的黑印強化我方隊伍。"
  },
  Tutorial_17843_Desc_1 = {
    Text = "受到攻擊時，對攻擊者造成等同於<TutorialHighlight:反擊>層數的傷害。<TutorialHighlight:反擊>傷害<TutorialHighlight:無法暴擊>。"
  },
  Tutorial_17843_Title_1 = {Text = "反擊"},
  Tutorial_17844_Desc_1 = {
    Text = "每擁有 1 點<TutorialHighlight:力量>，每次造成主動傷害時將額外提升 1 點傷害。"
  },
  Tutorial_17845_Desc_1 = {
    Text = "派遣喚醒體完成研究任務，完成後可以獲得相應的獎勵。派遣喚醒體<TutorialHighlight:總等級>越高，獎勵越豐富，最高按240總等級計算。"
  },
  Tutorial_17847_Desc_1 = {
    Text = "受到致命傷害時，有<TutorialHighlight:等同於死亡抵抗的機率>免疫此傷害並保留 1 點生命，<TutorialHighlight:成功觸發後死亡抵抗減半>。隊伍的死亡抵抗等同於所有喚醒體死亡抵抗之和，提升隊伍死亡抵抗有助於提升戰鬥時的容錯率。"
  },
  Tutorial_17848_Desc_1 = {
    Text = "深海隊伍戰鬥開始時生成 1 條<TutorialHighlight:觸腕>，<TutorialHighlight:觸腕>在回合結束時攻擊前排敵人，可以通過觸腕圖標下方的算式了解當前的觸腕傷害和攻擊次數。部分喚醒體可以提升觸腕數量和觸腕傷害，在回合結束時造成大量的傷害。"
  },
  Tutorial_17850_Desc_1 = {
    Text = "打出手牌需消耗算力，回合結束時所有手牌將進入<TutorialHighlight:棄牌堆>。合理規劃<TutorialHighlight:出牌順序>將是戰鬥勝利的關鍵。"
  },
  Tutorial_17851_Desc_1 = {
    Text = "代表敵人下回合即將要採取的行動，利用<TutorialHighlight:意圖>進行本回合的決策是戰鬥的核心玩法。"
  },
  Tutorial_17851_Title_1 = {
    Text = "敵方意圖"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:技能升級>可以提升喚醒體屬性，強化指令卡的效果。在喚醒體技能介面點擊下一級可以預覽升級後的效果。"
  },
  Tutorial_17852_Desc_2 = {
    Text = "不同界域的喚醒體需要不同的<TutorialHighlight:技能升級素材>。"
  },
  Tutorial_17852_Title_1 = {
    Text = "技能強化"
  },
  Tutorial_20768_Desc_1 = {
    Text = "喚醒體打出指令卡或靈知覺醒消耗算力時可以獲得<TutorialHighlight:銀鑰能量>。喚醒體的<TutorialHighlight:銀鑰充能>屬性可以提升獲得的<TutorialHighlight:銀鑰能量>。"
  },
  Tutorial_20768_Title_1 = {
    Text = "銀鑰能量"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:銹蝕門扉>會阻擋重要的調查路線，嘗試在地圖中搜尋一種稱為<TutorialHighlight:銹蝕鑰匙>的物件，它可以用於開啟<TutorialHighlight:銹蝕門扉>。"
  },
  Tutorial_20769_Title_1 = {
    Text = "銹蝕門扉"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:銹蝕鑰匙>可以開啟阻擋你前進的<TutorialHighlight:銹蝕門扉>。"
  },
  Tutorial_20770_Title_1 = {
    Text = "銹蝕鑰匙"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:無光之境>包含四個界域的系列關卡，通關後可以獲得銀芯、靈知製劑等獎勵，累計星級達到指定要求後還可以額外獲得銀芯、無垢之芯等獎勵"
  },
  Tutorial_20771_Desc_2 = {
    Text = "不同界域的間隙關卡，會對調查隊伍中的喚醒體界域做出要求， <TutorialHighlight:滿足要求>的隊伍才可以進行調查。"
  },
  Tutorial_20771_Title_1 = {
    Text = "無光之境"
  },
  Tutorial_20772_Desc_1 = {
    Text = "當銀鑰能量達到 <TutorialHighlight:1000> 時可以釋放攜帶的<TutorialHighlight:鑰令>。每回合可以釋放 2 次鑰令，但第二次釋放鑰令時會改為從 3 個隨機鑰令中選擇 1 個釋放，且選擇的鑰令在本次探索中無法再次被選擇。在編隊時為我方隊伍選擇合適的鑰令，可以使調查過程更加順利。"
  },
  Tutorial_20772_Title_1 = {Text = "鑰令"},
  Tutorial_20773_Desc_1 = {
    Text = "消耗相同的<TutorialHighlight:命輪>進行疊位，或使用<TutorialHighlight:循環母版>對<TutorialHighlight:SSR命輪>進行疊位，可以提升<TutorialHighlight:命輪>的屬性和特殊能力。疊位1次至3次時，命輪的效果會增強；疊位4次至15次時，命輪的屬性會增強。可以在疊位介面點擊「下一階」按鈕預覽疊位後的變化。\n透過喚醒等途徑獲得已有命輪時，系統將會自動與已有命輪進行疊位，無需守密人單獨操作。"
  },
  Tutorial_20773_Title_1 = {
    Text = "命輪疊位"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:密契升級>可以提升密契的屬性強度，最高升至12級。密契分解可以獲得對應的殘本，在物資中進行材料置換可以獲得<TutorialHighlight:千面印章>。密契升級需消耗<TutorialHighlight:千面印章>，分解已升級的密契也會返還升級消耗的<TutorialHighlight:千面印章>。"
  },
  Tutorial_22247_Title_1 = {
    Text = "密契升級"
  },
  Tutorial_22248_Desc_1 = {
    Text = "通過轉錄可以使<TutorialHighlight:密契>獲得隨機種類和強度的屬性，副詞條屬性與部位無關，可能出現暴擊率、暴擊傷害、狂氣回充等級、銀鑰充能等級、界域精通、黑印掉落、傷害強效、死亡抵抗這8種。在轉錄時，如果想要保留某項屬性，可以選擇<TutorialHighlight:鎖定>，鎖定的屬性在轉錄時將不會發生變化。"
  },
  Tutorial_22248_Title_1 = {
    Text = "密契轉錄"
  },
  Tutorial_23466_Desc_1 = {
    Text = "隨著守密人等級的提升，<TutorialHighlight:造物和刻印的強度>會跟隨提升，喚醒體<TutorialHighlight:每點體質對隊伍生命的影響>也會提升。通過調查行動、幕間演習可以獲取大量的守密人經驗。每消耗1點體力會獲得1點守密人經驗。"
  },
  Tutorial_23466_Title_1 = {
    Text = "守密人等級"
  },
  Tutorial_47538_Desc_1 = {
    Text = "融災禁區是一個難度較高的玩法系統。守密人需要靈活搭配多個挑戰隊伍，盡可能地獲取更多的特訓值，從而獲得更多的獎勵。高警戒難度除了敵方單位變得更強，還會具有各種減益效果。"
  },
  Tutorial_47538_Desc_2 = {
    Text = "在融災禁區中有其獨特的限制法則：同一喚醒體和鑰令、同名命輪無法重複上場，守密人可以根據初始造物、怪物和推薦等級，靈活選擇本次挑戰的隊伍，採用田忌賽馬的策略盡可能獲得更多的特訓值。通過<TutorialHighlight:助戰>方式上陣的喚醒體不受該限制影響。"
  },
  Tutorial_47538_Title_1 = {
    Text = "融災禁區"
  },
  Tutorial_54390_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，戰鬥介面內敵我雙方喚醒體所擁有的<TutorialHighlight:狀態>都會顯示在其生命及狂氣的下方，點擊即可查看具體的效果。"
  },
  Tutorial_54390_Desc_2 = {
    Text = "屬於<TutorialHighlight:正面狀態>的如下（點擊查看詳情）：<TauntKeywords:嘲諷>、<PVPPowerIconKeywords:力量>、<EnergyStorageKeywords:蓄力>、<PVPProtectiveKeywords:屏障>、<PVPRetaliateIconKeywords:反擊>、<ReinforceKeywords:加固>、<StrengthenKeywords:強化>。"
  },
  Tutorial_54390_Desc_3 = {
    Text = "屬於<TutorialHighlight:負面狀態>的如下（點擊查看詳情）：<PVPEntanglementKeywords:纏繞>、<PVPVulnerabilityIconKeywords:易傷>、<PVPSlowKeywords:遲緩>、<ComaKeywords:石化>、<DisarmKeywords:麻痺>、<PVPMethysisKeywords:中毒>、<PVPEmptinessKeywords:空虛>、<PVPBleedingKeywords:出血>、<PVPSeriousInjuryKeywords:重創>、<ComaKeywords:昏迷>。"
  },
  Tutorial_54390_Title_1 = {Text = "狀態"},
  Tutorial_54391_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，有些喚醒體的卡牌會有不同的<TutorialHighlight:詞綴>效果，可以在<TutorialHighlight:收藏>系統中查看或戰鬥中長按卡牌查看。屬於詞綴的有（點擊查看詳情）：<PVPPenetrateKeywords:貫穿>、<PrepareKeywords:預備>、<PVPResurrectionKeywords:復活>、<PVPHoldingKeywords:持有>、<PhantomKeywords:幻影>、<PVPRaidKeywords:突襲>。"
  },
  Tutorial_54391_Title_1 = {Text = "詞綴"},
  Tutorial_54392_Desc_1 = {
    Text = "在一些特殊玩法中會有<TutorialHighlight:賽季>玩法，在賽季期間參與特殊玩法的排行榜即可在賽季結束時根據排行結算獎勵。\n隨著調查行動進度的推進，未來會有更多玩法參與<TutorialHighlight:賽季>玩法。"
  },
  Tutorial_54392_Desc_2 = {
    Text = "每個賽季期間都會有<TutorialHighlight:賽季任務>，完成賽季任務即可領取豐富的獎勵，賽季任務將會在賽季刷新時重置。"
  },
  Tutorial_54392_Title_1 = {Text = "賽季"},
  Tutorial_54393_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，喚醒體陣亡後，手牌中屬於該喚醒體的卡牌會變為<TutorialHighlight:幻象>。將<TutorialHighlight:命輪>裝備給已陣亡喚醒體也獲得1張幻象，同時返還消耗的算力。幻象還可以被特定命輪的效果合成<TutorialHighlight:小小心願>。"
  },
  Tutorial_54394_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，在第1回合時雙方都是3點<TutorialHighlight:算力>及上限，後手會補償一張<TutorialHighlight:後發制人>卡牌。之後每回合開始時，算力上限及回復量都會增長1點直到10點。除自動增長外，也有其他手段可以提高或降低算力上限，算力上限達到10後再增加，則每1點溢出上限會替換為抽1張牌。"
  },
  Tutorial_54395_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，每個喚醒體也有<TutorialHighlight:狂氣>以及<TutorialHighlight:狂氣爆發>。可以通過使用<TutorialHighlight:打擊>卡或特定<TutorialHighlight:技能>卡來獲得狂氣，受到傷害損失生命時也會獲得狂氣（每損失2%生命或等量護盾獲得1點狂氣），狂氣滿100後點擊對應喚醒體即可選擇釋放狂氣爆發。"
  },
  Tutorial_54395_Title_1 = {Text = "狂氣"},
  Tutorial_54396_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，在匹配對戰中完成「對弈紀錄」中的指定目標，可以領取對應的獎勵。該獎勵為一次性獎勵，不隨賽季重置，可以通過介面左下方的「對弈紀錄」進行查看。"
  },
  Tutorial_54396_Title_1 = {
    Text = "對弈紀錄"
  },
  Tutorial_54397_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，介面左側的「收藏」頁籤內可以流覽全部喚醒體、命輪、鑰令的資訊。"
  },
  Tutorial_54398_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，每個喚醒體都有2張<TutorialHighlight:打擊>牌，3張<TutorialHighlight:技能>牌。通常，不同的技能牌會有不同的算力消耗。"
  },
  Tutorial_54399_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，每回合自動抽牌數也是5張，默認<TutorialHighlight:手牌上限>也是10張，可以在戰鬥介面的右下角看到我方當前手牌數及手牌上限數，右上角看到對方的情況。可以通過其他方式來讓每回合抽牌數及手牌上限發生變化。"
  },
  Tutorial_54400_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，不同的喚醒體有不同的<TutorialHighlight:定位>，總共5個。具體分別是<TutorialHighlight:守護>、<TutorialHighlight:鬥爭>、<TutorialHighlight:靈智>、<TutorialHighlight:兇星>、<TutorialHighlight:祝福>。進行<TutorialHighlight:編隊>時需要選出4名不同定位的喚醒體來組成隊伍。"
  },
  Tutorial_54401_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈-預組模式>中，點擊介面右下角的「開始匹配」就會進入到編隊介面。也可以在介面左側的<TutorialHighlight:預組編隊>中提前進行隊伍構築。"
  },
  Tutorial_54401_Desc_2 = {
    Text = "編隊預組支持保存多套，左上角還能編輯隊伍名稱，每支隊伍由4名喚醒體，4件命輪，2件鑰令組成。"
  },
  Tutorial_54401_Title_1 = {
    Text = "預組編隊"
  },
  Tutorial_54705_Desc_1 = {
    Text = "在<TutorialHighlight:相位對弈>模式中，點擊自己的<TutorialHighlight:頭像>，選擇想要發送的<TutorialHighlight:對戰表情>，向你的對手錶達心意吧！"
  },
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:相位對弈>是兩人對抗遊戲，雙方使用各自預組隊伍進行<TutorialHighlight:匹配對戰>，在匹配時會就近匹配旗鼓相當的對手。"
  },
  Tutorial_54706_Desc_2 = {
    Text = "通過對戰可以獲得<TutorialHighlight:預組經驗>與<TutorialHighlight:輪選經驗>，根據獲得的經驗，可以在<TutorialHighlight:預組等級>與<TutorialHighlight:輪選等級>中解鎖<TutorialHighlight:一次性獎勵>！"
  },
  Tutorial_54706_Desc_3 = {
    Text = "每賽季會根據積分排名獲得<TutorialHighlight:頭銜>，賽季結束時將會結算排名，並透過郵箱發送排名獎勵。"
  },
  Tutorial_54706_Title_1 = {
    Text = "對弈簡介"
  },
  Tutorial_74798_Desc_1 = {
    Text = "不同關卡會存在不同的 <TutorialHighlight:關卡篇章> 環境，大幅改變整體規則和造物效果。具體可在各個關卡介面點擊相關頁籤查看。"
  },
  Tutorial_74798_Title_1 = {
    Text = "關卡篇章"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:喚醒體回溯>可以返還喚醒體的各種養成消耗。"
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:養成回溯>將會重置喚醒體的等級、升格、技能、靈知深化狀態，消耗的材料和金券均會全數返還。"
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:啟靈回溯>將會重置喚醒體的啟靈狀態，並重置啟靈帶來的等級上限，消耗的材料會全數返還。"
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:黑池歸還>將會包含「養成回溯」的效果，還會額外將喚醒體本身也重置，變為未解鎖狀態。"
  },
  Tutorial_81370_Title_1 = {
    Text = "喚醒體回溯"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:喚醒體升級>是最快速提升喚醒體屬性的方式之一。消耗<TutorialHighlight:靈知製劑>可以提升喚醒體等級。"
  },
  Tutorial_81371_Desc_2 = {
    Text = "喚醒體達到等級上限之後需要通過<TutorialHighlight:升格>來提升等級上限，不同界域的喚醒體需要不同的<TutorialHighlight:升格素材>。"
  },
  Tutorial_81371_Title_1 = {
    Text = "喚醒體升級"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:啟靈啟動>可以極大的提升喚醒體的指令卡效果。啟靈等級7級可以解鎖<TutorialHighlight:超限爆發>，使喚醒體狂氣爆發時獲得額外效果。啟靈等級11級和15級可以提高5級的喚醒體等級上限"
  },
  Tutorial_81372_Title_1 = {
    Text = "啟靈啟動"
  }
})
return Text_Tutorial
