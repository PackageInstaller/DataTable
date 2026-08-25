__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "戰鬥開始後獲得 1 層「<MindWall:心靈壁壘>」，3 回合後將其轉化為「<BarrierCrash:壁壘崩解>」。"
  },
  RelicConfig_100300_Desc = {
    Text = "戰鬥開始後獲得 1 層「<MindWall:心靈壁壘>」，3 回合後將其轉化為「<BarrierCrash:壁壘崩解>」。"
  },
  RelicConfig_100300_Name = {
    Text = "心靈剖析"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "仔細看清楚你的心，不要做出錯誤的選擇。"
  },
  RelicConfig_100399_BattleDesc = {
    Text = "觸發 <DevouredIconKeywords:吞噬>效果後，其他喚醒體獲得 [Arg1] 點狂氣，每回合僅能生效 1 次。"
  },
  RelicConfig_100399_Desc = {
    Text = "觸發 <DevouredIconKeywords:吞噬>效果後，其他喚醒體獲得 [Arg1] 點狂氣，每回合僅能生效 1 次。"
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:創構的金色夢鄉+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "蛻變之日即是你的死期。"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_100400_Desc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:創構的恩賜之血+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "它甘甜醇美，散發著薔薇花香。"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_100401_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:創構的鏽蝕鋼鋸+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "解剖醫生一生都看不到美麗的女人，只有一麻袋骨頭、因疾病發炎的神經、肌肉和組織。"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100402_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:創構的春之祭>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "在夜的歡笑聲中，獨木舟的剪影在湖面上自如地滑動。"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_100404_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:創構的重鎖>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "厚實而且堅固的鎖，如果沒有鑰匙，想必很難開啟。\n當然，這對某個神偷來說不值一提。"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100405_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:創構的惡童>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "脫胎於純粹的惡，即使這並非它所願。"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "觸發 <DevouredIconKeywords:吞噬>效果後，其他喚醒體獲得 [Arg1] 點狂氣，每回合僅能生效 1 次。"
  },
  RelicConfig_100406_Desc = {
    Text = "觸發 <DevouredIconKeywords:吞噬>效果後，其他喚醒體獲得 [Arg1] 點狂氣，每回合僅能生效 1 次。"
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:創構的金色夢鄉>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "蛻變之日即是你的死期。"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_100407_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:創構的纏絲瑪瑙>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "應該只是普通的瑪瑙紋路。大概。"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_100408_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:創構的重鎖+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "厚實而且堅固的鎖，如果沒有鑰匙，想必很難開啟。\n當然，這對某個神偷來說不值一提。"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100409_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:創構的惡童+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "脫胎於純粹的惡，即使這並非它所願。"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_100410_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:創構的纏絲瑪瑙+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "應該只是普通的瑪瑙紋路。大概。"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100411_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:創構的春之祭+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "在夜的歡笑聲中，獨木舟的剪影在湖面上自如地滑動。"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_100412_Desc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:創構的恩賜之血>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "它甘甜醇美，散發著薔薇花香。"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_100413_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:創構的鏽蝕鋼鋸>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "解剖醫生一生都看不到美麗的女人，只有一麻袋骨頭、因疾病發炎的神經、肌肉和組織。"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100539_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:創構的染血鵝卵石>"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100540_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:創構的染血鵝卵石+>"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116382_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116382_Name = {
    Text = "銹蝕鑰匙"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116383_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116383_Name = {
    Text = "銹蝕鑰匙"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116384_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_116384_Name = {
    Text = "銹蝕鑰匙"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "手牌上限 +1 。\n回合開始時，若未完成所有儀式，獲得最大生命 10% 的 <SacrificeKeyWord:獻祭>。將 1 張「<DerivativeCardKeywords_119:敬獻神明>」置入手中，至多持有 1 張。"
  },
  RelicConfig_119371_Desc = {
    Text = "手牌上限 +1 。\n回合開始時，若未完成所有儀式，獲得最大生命 10% 的 <SacrificeKeyWord:獻祭>。將 1 張「<DerivativeCardKeywords_119:敬獻神明>」置入手中，至多持有 1 張。"
  },
  RelicConfig_119371_Name = {
    Text = "黃銅香爐"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "「仿照利莫里亞工藝打造了這枚香爐，願它能助您夜夜安寢。彌利亞姆留。」"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "手牌上限+[Arg1]。回合開始時、將 [Arg2] 張「<PVPDerivativeCardKeywords_11:不平等交換>」置入手牌。"
  },
  RelicConfig_120372_Desc = {
    Text = "手牌上限+[Arg1]。回合開始時、將 [Arg2] 張「<PVPDerivativeCardKeywords_11:不平等交換>」置入手牌。"
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:萬花筒>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "打出的前 [Arg1] 張「<PVPWeaponKeywords:命輪>」算力消耗-5/-3/-1/+1，抽 1 張牌。"
  },
  RelicConfig_120373_Desc = {
    Text = "打出的前 [Arg1] 張「<PVPWeaponKeywords:命輪>」算力消耗-5/-3/-1/+1，抽 1 張牌。"
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:彌薩格徽章>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "免疫傷害"
  },
  RelicConfig_121214_Desc = {
    Text = "免疫傷害"
  },
  RelicConfig_121214_Name = {
    Text = "無敵測試造物"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "造成的最終傷害提高 250%，每造成 1 次傷害降低 50%， 並使造成的護盾提高 10%，至多觸發 5 次，每回合開始後重置。"
  },
  RelicConfig_121689_Desc = {
    Text = "造成的最終傷害提高 250%，每造成 1 次傷害降低 50%， 並使造成的護盾提高 10%，至多觸發 5 次，每回合開始後重置。"
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 誕臨」>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "戰鬥開始，選擇 3 張卡牌使它們獲得「<RippleKeywords:餘波>：抽一張牌，獲得 [Arg3] 點臨時<PowerIconKeywords:力量>」。回合開始時抽取 2 張附帶<RippleKeywords:餘波>的卡牌，所有<RippleKeywords:餘波>效果額外觸發一次，在觸發 10 次<RippleKeywords:餘波>後，將 1 張<DerivativeCardKeywords_1:遺影迴響>置入手中。"
  },
  RelicConfig_121690_Desc = {
    Text = "戰鬥開始，選擇 3 張卡牌使它們獲得「<RippleKeywords:餘波>：抽一張牌，獲得 [Arg3] 點臨時<PowerIconKeywords:力量>」。回合開始時抽取 2 張附帶<RippleKeywords:餘波>的卡牌，所有<RippleKeywords:餘波>效果額外觸發一次，在觸發 10 次<RippleKeywords:餘波>後，將 1 張<DerivativeCardKeywords_1:遺影迴響>置入手中。"
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 瘋狂」>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "所有喚醒體狂氣爆發最終傷害提升 100%、每次喚醒體在釋放狂氣爆發後、獲得其 500% 基礎狂氣的銀鑰能量、所有喚醒體基礎狂氣降低 20 點、最多降低 5 次。"
  },
  RelicConfig_121691_Desc = {
    Text = "所有喚醒體狂氣爆發最終傷害提升 100%、每次喚醒體在釋放狂氣爆發後、獲得其 500% 基礎狂氣的銀鑰能量、所有喚醒體基礎狂氣降低 20 點、最多降低 5 次。"
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 恐懼」>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "所有喚醒體造成的<RetaliateIconKeywords:反擊>、<IntoxicationIconKeywords: 中毒>、護盾和生命回復提高 50%。回合結束時，獲得當前護盾 500%的臨時<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_121692_Desc = {
    Text = "所有喚醒體造成的<RetaliateIconKeywords:反擊>、<IntoxicationIconKeywords: 中毒>、護盾和生命回復提高 50%。回合結束時，獲得當前護盾 500%的臨時<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 邪信」>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "手牌上限 +5 。回合開始時抽 2 張牌，獲取 2 點算力。每次重置牌庫時，獲得 [Arg3] 點<PowerIconKeywords:力量>與 [Arg4] 點臨時<AlertIconKeywords:戒備>，生成狂氣最高喚醒體每種非衍生指令卡各 1 張並置入抽牌堆，使它們的算力消耗降低 1 點。"
  },
  RelicConfig_121693_Desc = {
    Text = "手牌上限 +5 。回合開始時抽 2 張牌，獲取 2 點算力。每次重置牌庫時，獲得 [Arg3] 點<PowerIconKeywords:力量>與 [Arg4] 點臨時<AlertIconKeywords:戒備>，生成狂氣最高喚醒體每種非衍生指令卡各 1 張並置入抽牌堆，使它們的算力消耗降低 1 點。"
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 刺骨」>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 25 點狂氣並將一張<DerivativeCardKeywords_4:靈感>置入手牌。每釋放 4 次「狂氣爆發」後，解除所有喚醒體的<Seal:封印>狀態，並使所有喚醒體獲得 50 點狂氣。"
  },
  RelicConfig_121694_Desc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 25 點狂氣並將一張<DerivativeCardKeywords_4:靈感>置入手牌。每釋放 4 次「狂氣爆發」後，解除所有喚醒體的<Seal:封印>狀態，並使所有喚醒體獲得 50 點狂氣。"
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 詭譎」>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "戰鬥開始時，獲得 [Arg4] 點<PowerIconKeywords:力量>，銀鑰能量存儲上限+100％。每點算力消耗時獲得的銀鑰能量提高 100%，使用銀鑰覺醒或釋放鑰令後，獲得等同於當前<PowerIconKeywords:力量> 20%的臨時<PowerIconKeywords:力量>並使所有喚醒體獲得 20 點狂氣。"
  },
  RelicConfig_121695_Desc = {
    Text = "戰鬥開始時，獲得 [Arg4] 點<PowerIconKeywords:力量>，銀鑰能量存儲上限+100％。每點算力消耗時獲得的銀鑰能量提高 100%，使用銀鑰覺醒或釋放鑰令後，獲得等同於當前<PowerIconKeywords:力量> 20%的臨時<PowerIconKeywords:力量>並使所有喚醒體獲得 20 點狂氣。"
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:「純銀的歸途· 悲泣」>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "戰鬥開始後、將 [Arg1] 張「<PVPDerivativeCardKeywords_25:茜爾維婭的紅茶>」置入手牌。"
  },
  RelicConfig_122625_Desc = {
    Text = "戰鬥開始後、將 [Arg1] 張「<PVPDerivativeCardKeywords_25:茜爾維婭的紅茶>」置入手牌。"
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:錫蘭紅茶>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "在每輪抽牌堆裡置入 [Arg1] 張「<PVPDerivativeCardKeywords_14:現實模仿>」、所屬者為隨機喚醒體。"
  },
  RelicConfig_122626_Desc = {
    Text = "在每輪抽牌堆裡置入 [Arg1] 張「<PVPDerivativeCardKeywords_14:現實模仿>」、所屬者為隨機喚醒體。"
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:魔術手套>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "每回合首個打出的「技能」傷害、治療與護盾提高 [Arg1]% 。"
  },
  RelicConfig_122627_Desc = {
    Text = "每回合首個打出的「技能」傷害、治療與護盾提高 [Arg1]% 。"
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:紅寶石胸針>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "回合結束後，額外獲得 <Energy:[Arg1]> 狂氣。"
  },
  RelicConfig_122628_Desc = {
    Text = "回合結束後，額外獲得 <Energy:[Arg1]> 狂氣。"
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:噩夢表像>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "抽牌堆裡會有雙倍的喚醒體卡牌。打出卡牌後，手牌數在本回合首次小於 [Arg1] 則抽 [Arg2] 牌。"
  },
  RelicConfig_122629_Desc = {
    Text = "抽牌堆裡會有雙倍的喚醒體卡牌。打出卡牌後，手牌數在本回合首次小於 [Arg1] 則抽 [Arg2] 牌。"
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:快樂唱片>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "手牌上限+[Arg1]。在每輪抽牌堆內置入 [Arg2] 張「<PVPDerivativeCardKeywords_13:不朽的葬儀>」。"
  },
  RelicConfig_122630_Desc = {
    Text = "手牌上限+[Arg1]。在每輪抽牌堆內置入 [Arg2] 張「<PVPDerivativeCardKeywords_13:不朽的葬儀>」。"
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:遺落的祭祀刀>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "回合開始時抽 [Arg1] 張算力消耗 -1 的「打擊」。釋放狂氣爆發後生成 [Arg2] 張具有<DepleteIconKeywords:消耗>、<PrepareKeypvewords:預備1>和<RetainIconKeywords:保留>的對應喚醒體的「打擊」。\n在 1 回合內每打出 [Arg3] 張「打擊」，獲得 [Arg4] 點臨時<PowerIconKeywords:力量>；打出 [Arg5] 張「打擊」後抽 [Arg6] 張牌並獲得 [Arg7] 點算力；打出 [Arg8] 張「打擊」後所有喚醒體獲得 [Arg9] 點狂氣。"
  },
  RelicConfig_122768_Desc = {
    Text = "回合開始時抽 [Arg1] 張算力消耗 -1 的「打擊」。釋放狂氣爆發後生成 [Arg2] 張具有<DepleteIconKeywords:消耗>、<PrepareKeypvewords:預備1>和<RetainIconKeywords:保留>的對應喚醒體的「打擊」。\n在 1 回合內每打出 [Arg3] 張「打擊」，獲得 [Arg4] 點臨時<PowerIconKeywords:力量>；打出 [Arg5] 張「打擊」後抽 [Arg6] 張牌並獲得 [Arg7] 點算力；打出 [Arg8] 張「打擊」後所有喚醒體獲得 [Arg9] 點狂氣。"
  },
  RelicConfig_122768_Name = {
    Text = "彼世回聲"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "異世迷霧中夾雜的回音，通往扭曲、癲狂和不可質疑的真實。"
  },
  RelicConfig_123724_BattleDesc = {
    Text = "回合開始時茉夏獲得 [Arg1] 點狂氣，生成 1 張茉夏算力消耗為 0 的臨時「打擊」。每次觸發「戲劇性邂逅」使「閃耀☆龍捲風」本場戰鬥造成的基礎傷害和打擊傷害提高效果提高 [Arg2]％。"
  },
  RelicConfig_123724_Desc = {
    Text = "回合開始時茉夏獲得 [Arg1] 點狂氣，生成 1 張茉夏算力消耗為 0 的臨時「打擊」。每次觸發「戲劇性邂逅」使「閃耀☆龍捲風」本場戰鬥造成的基礎傷害和打擊傷害提高效果提高 [Arg2]％。"
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:維度影像·茉夏>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "所有喚醒體每回合首次打出指令卡時，獲得 [Arg1] 點狂氣。1 回合內累計打出 4 張歸屬於不同喚醒體的指令卡後，向所有敵人施加 [Arg2]% 我方最大生命值的<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_125488_Desc = {
    Text = "所有喚醒體每回合首次打出指令卡時，獲得 [Arg1] 點狂氣。1 回合內累計打出 4 張歸屬於不同喚醒體的指令卡後，向所有敵人施加 [Arg2]% 我方最大生命值的<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_125488_Name = {
    Text = "姨娘的派頭"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "回合開始時徐獲得 [Arg1] 狂氣並對所有敵人施加 1 層<WitherKeywords:痴醉>。每回合打出的首張徐的指令卡必定觸發「共鳴」效果。"
  },
  RelicConfig_125489_Desc = {
    Text = "回合開始時徐獲得 [Arg1] 狂氣並對所有敵人施加 1 層<WitherKeywords:痴醉>。每回合打出的首張徐的指令卡必定觸發「共鳴」效果。"
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:維度影像·徐>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "手牌上限 +3。記錄每回合打出的前 3 張非衍生指令卡，並在 3 回合後的回合開始時將其算力消耗 -1 並具有<DepleteIconKeywords:消耗>的複製加入手牌。"
  },
  RelicConfig_126673_Desc = {
    Text = "手牌上限 +3。記錄每回合打出的前 3 張非衍生指令卡，並在 3 回合後的回合開始時將其算力消耗 -1 並具有<DepleteIconKeywords:消耗>的複製加入手牌。"
  },
  RelicConfig_126673_Name = {
    Text = "命運紡輪"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "命運流轉，亙古不息。"
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提升效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<OrangeQuality:維度贈禮>：探索開始時、隨機獲得 1 個維度影像造物、手牌上限提高 2 。\n<OrangeQuality:受祝儀式>：戰勝第一、第二階段的首領獎勵變更為隨機受祝造物 3 選 1。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命值。\n<RedQuality:暈眩徵兆>：戰鬥開始時、所有喚醒體當前狂氣與銀鑰能量降低 50%。\n<RedQuality:永夜長廊>：探索開始時、所有喚醒體的基礎狂氣與銀鑰能量上限提高 50%"
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提升效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<OrangeQuality:維度贈禮>：探索開始時、隨機獲得 1 個維度影像造物、手牌上限提高 2 。\n<OrangeQuality:受祝儀式>：戰勝第一、第二階段的首領獎勵變更為隨機受祝造物 3 選 1。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命值。\n<RedQuality:暈眩徵兆>：戰鬥開始時、所有喚醒體當前狂氣與銀鑰能量降低 50%。\n<RedQuality:永夜長廊>：探索開始時、所有喚醒體的基礎狂氣與銀鑰能量上限提高 50%"
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:小「N」的混亂相機>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "完蛋啦！相機徹底壞了！咦？怎麼還能工作？等等！這些限制都是什麼啊？！"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提高效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命值。"
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提高效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命值。"
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:小「N」的完整相機>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "別看了、這就是相機！嶄新出廠、童叟無欺。"
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提升效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<OrangeQuality:維度贈禮>：探索開始時、隨機獲得 1 個維度影像造物、手牌上限提高 1 。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命。\n<RedQuality:暈眩徵兆>：戰鬥開始時、所有喚醒體當前狂氣與銀鑰能量降低 50%。"
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:黃金調和>：「算力調和」帶來的算力提升效果最大為 1 點、每擁有 1% 傷害強效則使得靈識研究深度效果提高 1%。\n<OrangeQuality:維度贈禮>：探索開始時、隨機獲得 1 個維度影像造物、手牌上限提高 1 。\n<RedQuality:長途倦意>：戰鬥中所有生命回覆效果降低 50%、「褪色遺骨」選擇「安葬」時變更為回覆 25％ 最大生命。\n<RedQuality:暈眩徵兆>：戰鬥開始時、所有喚醒體當前狂氣與銀鑰能量降低 50%。"
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:小「N」的破舊相機>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "完了！相機被打壞了！讓我修一下看看……開機了！但是怎麼感覺怪怪的……"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "回合開始時莫絲獲得 [Arg1] 狂氣。每回合首次打出的「蓄力！」或「裝填」生效 2 次。"
  },
  RelicConfig_131079_Desc = {
    Text = "回合開始時莫絲獲得 [Arg1] 狂氣。每回合首次打出的「蓄力！」或「裝填」生效 2 次。"
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:維度影像·莫絲>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "前 3 回合開始時、每回合觸發 1 次「海獺困境」。第 5 回合開始時移除所有「海獺困境」的負面效果並獲得「<DerivativeCardKeywords_135:二世衝擊！>」。"
  },
  RelicConfig_131080_Desc = {
    Text = "前 3 回合開始時、每回合觸發 1 次「海獺困境」。第 5 回合開始時移除所有「海獺困境」的負面效果並獲得「<DerivativeCardKeywords_135:二世衝擊！>」。"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "莫絲女士強硬地說這就是造物。\n「壞人、咬他！」"
  },
  RelicConfig_131178_BattleDesc = {
    Text = "戰鬥開始時將一張「<DerivativeCardKeywords_134:禁忌真相>」洗入牌庫。每回合抽牌數 +[Arg1]。打出指令卡後分別對手牌、抽牌堆和棄牌堆中的隨機 [Arg2] 張不帶有<ErosionColorInkKeywords:認知錯亂>的指令卡附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  RelicConfig_131178_Desc = {
    Text = "戰鬥開始時將一張「<DerivativeCardKeywords_134:禁忌真相>」洗入牌庫。每回合抽牌數 +[Arg1]。打出指令卡後分別對手牌、抽牌堆和棄牌堆中的隨機 [Arg2] 張不帶有<ErosionColorInkKeywords:認知錯亂>的指令卡附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  RelicConfig_131178_Name = {
    Text = "奧涯手記"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "記載內容包含七十個梅森質數。"
  },
  RelicConfig_132540_BattleDesc = {
    Text = "免疫傷害"
  },
  RelicConfig_132540_Name = {
    Text = "集合測試造物"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "暴擊率提高 15%。回合開始時若生命低於 25%([Arg1])，當回合內暴擊率額外提高 30%。"
  },
  RelicConfig_13740_Desc = {
    Text = "暴擊率提高 15%。回合開始時若生命低於 25%，當回合內暴擊率額外提高 30%。"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:秘典星象儀>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "宇宙的奧妙。"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "暴擊傷害提高 15%。對有護盾的敵方造成的傷害必然暴擊。"
  },
  RelicConfig_13741_Desc = {
    Text = "暴擊傷害提高 15%。對有護盾的敵方造成的傷害必然暴擊。"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:美學原理>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "蠟像師：醫生的幫手，殯儀業者的恩客，墓蟲的供養者。"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "暴擊傷害+50%。每造成的第三次攻擊必然暴擊。"
  },
  RelicConfig_13742_Desc = {
    Text = "暴擊傷害+50%。每造成的第三次攻擊必然暴擊。"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:時靈擺「冥想」>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "回合開始時狂氣最低的喚醒體獲得 15 狂氣。連續 2 次打出比上一張算力消耗更低的卡牌時，狂氣最低的喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13743_Desc = {
    Text = "回合開始時狂氣最低的喚醒體獲得 15 狂氣。連續 2 次打出比上一張算力消耗更低的卡牌時，狂氣最低的喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:阿爾卡納遺物>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "命運的終焉。"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "回合開始後，狂氣最低的喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13744_Desc = {
    Text = "回合開始後，狂氣最低的喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:桂葉袖扣>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "印刻了桂葉花紋的銀質袖扣。\n它做工精緻，閃閃發亮，曾經承載了兩個孩子的友誼。"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "界域推薦加成效果提升為 50%，關卡開始時你的幸運刻印率翻倍。"
  },
  RelicConfig_13745_Desc = {
    Text = "界域推薦加成效果提升為 50%，關卡開始時你的幸運刻印率翻倍。"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:時靈擺「酣眠」>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "免疫 1 次死亡，觸發後立刻回復 10% 生命，觸發 3 次後永久失效。"
  },
  RelicConfig_13747_Desc = {
    Text = "免疫 1 次死亡，觸發後立刻回復 10% 生命，觸發 3 次後永久失效。"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆應急食品☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "萬不得已之下，也還是別吃這個。"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "戰鬥開始時，使你所有當前算力消耗為 1 的卡牌在本場戰鬥內傷害提高 [Arg1] 點，護盾提高 [Arg2] 點。"
  },
  RelicConfig_13748_Desc = {
    Text = "戰鬥開始時，使你所有當前算力消耗為 1 的卡牌在本場戰鬥內傷害提高 [Arg1] 點，護盾提高 [Arg2] 點。"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:純真瑪麗>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "邏輯就像雞尾酒，攝入太多就失去它的益處了。"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "每 4 回合使所有敵人本回合受到的主動和觸腕傷害翻倍、但在該回合中釋放狂氣爆發後、封印所有喚醒體 1 回合。"
  },
  RelicConfig_13749_Desc = {
    Text = "每 4 回合使所有敵人本回合受到的主動和觸腕傷害翻倍、但在該回合中釋放狂氣爆發後、封印所有喚醒體 1 回合。"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "神聖的一部分。\n縱然與軀幹分離，其足跡也已遍佈四海。"
  },
  RelicConfig_13750_BattleDesc = {
    Text = "回合結束時，若沒有護盾，獲得 1 層免疫一次傷害的<ParcloseIconKeywords:屏障>。每場戰鬥只生效 1 次。"
  },
  RelicConfig_13750_Desc = {
    Text = "回合結束時，若沒有護盾，獲得 1 層免疫一次傷害的<ParcloseIconKeywords:屏障>。每場戰鬥只生效 1 次。"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆鎮痛藥片☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "效果沒有那麼一勞永逸。"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "暴擊率提高 25%，每回合首次造成的傷害翻倍。"
  },
  RelicConfig_13751_Desc = {
    Text = "暴擊率提高 25%，每回合首次造成的傷害翻倍。"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:時靈擺「深化」>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "回合開始時回復 [Arg1] 生命。如果生命低於 50% ，回復生命變為 [Arg2]。"
  },
  RelicConfig_13752_Desc = {
    Text = "回合開始時回復 [Arg1] 生命。如果生命低於 50% ，回復生命變為 [Arg2]。"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:恩賜之血>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "它甘甜醇美，散發著薔薇花香。"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "這是個沒有效果的任務造物"
  },
  RelicConfig_13753_Desc = {
    Text = "這是個沒有效果的任務造物"
  },
  RelicConfig_13753_Name = {
    Text = "任務造物測試"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "需要補充內容的造物"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "你每造成的第 5 次傷害必定暴擊。"
  },
  RelicConfig_13754_Desc = {
    Text = "你每造成的第 5 次傷害必定暴擊。"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:視力矯正器>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "曾有人透過它，找到了真相。"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "回合開始時，<DimensionalSpaceIconKeywords:超維空間>每有 1 張卡牌，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，若本回合為超維回合，則獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13755_Desc = {
    Text = "回合開始時，<DimensionalSpaceIconKeywords:超維空間>每有 1 張卡牌，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，若本回合為超維回合，則獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:三棱鏡>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "「光由七種色彩構成。」"
  },
  RelicConfig_13756_BattleDesc = {
    Text = "拾取時失去所有其他造物，隨機獲得 2 個黃金造物。"
  },
  RelicConfig_13756_Desc = {
    Text = "拾取時失去所有其他造物，隨機獲得 2 個黃金造物。"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆逆向觀賞☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "在奇異的紀元中，花朵才是人類的第一觀賞者。\n不要動彈，祂們更偏愛安靜的展品。"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "你每打出的第 8 張指令卡會生效 2 次。"
  },
  RelicConfig_13757_Desc = {
    Text = "你每打出的第 8 張指令卡會生效 2 次。"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "遊走於繁星之間。"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "拾取後使最大生命提高 [Arg1] 點，受到攻擊時獲得的狂氣提高 2 點。"
  },
  RelicConfig_13758_Desc = {
    Text = "拾取後使最大生命提高 [Arg1] 點，受到攻擊時獲得的狂氣提高 2 點。"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "有人說這是魔鬼的血，但是，嘿，先試試看吧！"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "釋放狂氣爆發時，敵人每將要造成 1 次傷害，就對其施加 [Arg1] 層<IntoxicationIconKeywords:中毒>"
  },
  RelicConfig_13759_Desc = {
    Text = "釋放狂氣爆發時，敵人每將要造成 1 次傷害，就對其施加 [Arg1] 層<IntoxicationIconKeywords:中毒>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆鐳射頜骨☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "陳列在某個收藏家俬人展廳內的遺骨。\n收藏家醉心於那美麗的螢光，日夜欣賞，最終枯死，最終成為了它的同類。"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "最大算力提高 1 。連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 1 算力。"
  },
  RelicConfig_13760_Desc = {
    Text = "最大算力提高 1 。連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 1 算力。"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:阿爾卡納記錄>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "命運的走勢。"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 3 張，獲得 2 算力。"
  },
  RelicConfig_13761_Desc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 3 張，獲得 2 算力。"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:彌薩格徽章>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "彌薩格大學分發給調查員的徽章。它不僅象徵了佩戴者的身分，還是一個可以進行遠端通訊的工具。"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "打出「防禦」時，獲得[Arg1]點<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13762_Desc = {
    Text = "打出「防禦」時，獲得[Arg1]點<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13762_Name = {
    Text = "異化刺蕁麻背心"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "無法分辨沾染的液體。"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "戰鬥開始時，獲得 [Arg1] 點護盾。回合開始時如果擁有護盾，該回合中護盾和治療強效+ 50%。"
  },
  RelicConfig_13763_Desc = {
    Text = "戰鬥開始時，獲得 [Arg1] 點護盾。回合開始時如果擁有護盾，該回合中護盾和治療強效+ 50%。"
  },
  RelicConfig_13763_Name = {
    Text = "異化花園守護者"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "拾取時永久獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13764_Desc = {
    Text = "拾取時永久獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:紅寶石胸針>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "隱約滲出鮮紅。"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "拾取時選擇一張卡牌，將兩個三選一強化效果賦予其上。（注：類似千面幻象捏卡）"
  },
  RelicConfig_13766_Desc = {
    Text = "拾取時選擇一張卡牌，將兩個三選一強化效果賦予其上。（注：類似千面幻象捏卡）"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆名家打字機☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "有傳言，真正寫出傳世之作的，其實是打字機。"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "拾取時獲得 3 選 1 隨機高級刻印，將其賦予對應卡牌。"
  },
  RelicConfig_13767_Desc = {
    Text = "拾取時獲得 3 選 1 隨機高級刻印，將其賦予對應卡牌。"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:萊茵德紙草書>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "下面請聽題：10個僧侶分6只麵包，請問他們各得多少？"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "最大算力提高 2。打出「打擊」或「防禦」後，對應喚醒體獲得 5 狂氣。釋放狂氣爆發後，獲得 1 張對應喚醒體附帶消耗虛無的「打擊」，釋放鑰令後，隨機獲得 1 張附帶消耗虛無的「防禦」。"
  },
  RelicConfig_13768_Desc = {
    Text = "最大算力提高 2。打出「打擊」或「防禦」後，對應喚醒體獲得 5 狂氣。釋放狂氣爆發後，獲得 1 張對應喚醒體附帶消耗虛無的「打擊」，釋放鑰令後，隨機獲得 1 張附帶消耗虛無的「防禦」。"
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:時靈擺「羽翼」>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "回合開始時<EmbryoFusionIconKeywords:胚胎融合>+30。你的所有<DevouredIconKeywords:吞噬>效果均變為<UnlimitedDevouredIconKeywords:無限吞噬>。"
  },
  RelicConfig_13769_Desc = {
    Text = "回合開始時<EmbryoFusionIconKeywords:胚胎融合>+30。你的所有<DevouredIconKeywords:吞噬>效果均變為<UnlimitedDevouredIconKeywords:無限吞噬>。"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:蠕動的臍帶>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "纏繞脖頸。"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "回合開始時獲得 [Arg1] 護盾，每經過 1 回合就使該護盾值提高 [Arg2]。"
  },
  RelicConfig_13770_Desc = {
    Text = "回合開始時獲得 [Arg1] 護盾，每經過 1 回合就使該護盾值提高 [Arg2]。"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:守護之手>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "祈福的手，堅定的拳。"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "所有喚醒體銀鑰充能提高 30。釋放鑰令後，將 3 張<DerivativeCardKeywords_4:「靈感」>洗入你的牌庫。"
  },
  RelicConfig_13771_Desc = {
    Text = "所有喚醒體銀鑰充能提高 30。釋放鑰令後，將 3 張<DerivativeCardKeywords_4:「靈感」>洗入你的牌庫。"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:時靈擺「淺眠」>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "戰鬥結束後，額外獲得 75 黑印和 1 張症狀卡。"
  },
  RelicConfig_13772_Desc = {
    Text = "戰鬥結束後，額外獲得 75 黑印和 1 張症狀卡。"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "每造成 1 次主動傷害，對自身施加 [Arg1] 層<BleedingIconKeywords:出血>，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。每擊殺 1 次敵人，驅散自身<BleedingIconKeywords:出血>狀態。"
  },
  RelicConfig_13773_Desc = {
    Text = "每造成 1 次主動傷害，對自身施加 [Arg1] 層<BleedingIconKeywords:出血>，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。每擊殺 1 次敵人，驅散自身<BleedingIconKeywords:出血>狀態。"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:蟲群意識>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "纏繞、共生、集群；恐懼、未知、控制。"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "打出 1 張實際算力消耗為 3 的卡牌時，抽 1 張牌並獲得 2 算力；打出 1 張實際算力消耗為 4 或以上的卡牌時，其他手牌算力消耗降低 1。"
  },
  RelicConfig_13774_Desc = {
    Text = "打出 1 張實際算力消耗為 3 的卡牌時，抽 1 張牌並獲得 2 算力；打出 1 張實際算力消耗為 4 或以上的卡牌時，其他手牌算力消耗降低 1。"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:時靈擺「眼」>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "拾取時選擇一張指令卡，使其獲得「固有」、「保留」和「打出後抽 1 張牌」。"
  },
  RelicConfig_13775_Desc = {
    Text = "拾取時選擇一張指令卡，使其獲得「固有」、「保留」和「打出後抽 1 張牌」。"
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:檔案夾>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "噓，這是隻屬於你我的秘密交易。"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "戰鬥開始後，獲得 1 條觸腕。"
  },
  RelicConfig_13776_Desc = {
    Text = "戰鬥開始後，獲得 1 條觸腕。"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:小黃螺>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "這只小黃螺出身高貴，有著完美的、無可挑剔的來源。"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "奇數回合結束時，若有剩餘算力，下回合額外抽 2 張牌；偶數回合結束時，若有剩餘手牌，下回合額外獲得 2 算力。"
  },
  RelicConfig_13777_Desc = {
    Text = "奇數回合結束時，若有剩餘算力，下回合額外抽 2 張牌；偶數回合結束時，若有剩餘手牌，下回合額外獲得 2 算力。"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:日月輪盤>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "猜一猜，是黑還是白？"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，<TentacleInjurieIconKeywords:觸腕傷害>提高 [Arg1] 。"
  },
  RelicConfig_13778_Desc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，<TentacleInjurieIconKeywords:觸腕傷害> 提高 [Arg1] 。"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:海眷歌謠>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "據說織紋螺等不可食用動物吸收了海洋大約80%的營養。"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "回合開始時抽 1 張牌，回合結束時可以選擇保留 1 張手牌。"
  },
  RelicConfig_13779_Desc = {
    Text = "回合開始時抽 1 張牌，回合結束時可以選擇保留 1 張手牌。"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:先知的許願燈>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "回應你的願望。"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "每次釋放狂氣爆發，獲得 1 張<DerivativeCardKeywords_7:「毒性侵染」>，若手牌中擁有 3 張<DerivativeCardKeywords_7:「毒性侵染」>則合成一張觸發<IntoxicationIconKeywords:中毒>的 <DerivativeCardKeywords_8:「毒性發作」>。"
  },
  RelicConfig_13780_Desc = {
    Text = "每次釋放狂氣爆發，獲得 1 張<DerivativeCardKeywords_7:「毒性侵染」>，若手牌中擁有 3 張<DerivativeCardKeywords_7:「毒性侵染」>則合成一張觸發<IntoxicationIconKeywords:中毒>的 <DerivativeCardKeywords_8:「毒性發作」>。"
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:異種喉舌>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "祂不是惡魔，但祂確實會傳遞人世之外的低語。"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "每消耗 1 個黑印，所有喚醒體獲得 1 點狂氣。"
  },
  RelicConfig_13781_Desc = {
    Text = "每消耗 1 個黑印，所有喚醒體獲得 1 點狂氣。"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "免疫傷害"
  },
  RelicConfig_13782_Desc = {
    Text = "免疫傷害"
  },
  RelicConfig_13782_Name = {
    Text = "測試造物"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "每回合打出第 3 張卡牌後，將 1 張<DerivativeCardKeywords_4:「靈感」>置入棄牌堆。每回合打出第 6 張卡牌後，從棄牌堆中將 1 張<DerivativeCardKeywords_4:「靈感」>置入手牌。"
  },
  RelicConfig_13783_Desc = {
    Text = "每回合打出第 3 張卡牌後，將 1 張<DerivativeCardKeywords_4:「靈感」>置入棄牌堆。每回合打出第 6 張卡牌後，從棄牌堆中將 1 張<DerivativeCardKeywords_4:「靈感」>置入手牌。"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "劃破黑夜的流星。"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "回合開始時每有 1 名敵人就獲得 1 算力。主動傷害擊殺敵人時，對其他敵人造成等同於過量傷害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_13784_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 1 算力。主動傷害擊殺敵人時，對其他敵人造成等同於過量傷害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "專為折磨你的耳朵而生。"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "回合結束時<EmbryoFusionIconKeywords:胚胎融合> +15，若手牌中有<DerivativeCardKeywords_2:「胚胎」>，回復 [Arg1] 生命。"
  },
  RelicConfig_13785_Desc = {
    Text = "回合結束時<EmbryoFusionIconKeywords:胚胎融合> +15，若手牌中有<DerivativeCardKeywords_2:「胚胎」>，回復 [Arg1] 生命。"
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:瘟疫診斷書>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "瘟疫——大自然無意識煩躁的偶然表現。"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13786_Desc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:重鎖>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "厚實而且堅固的鎖，如果沒有鑰匙，想必很難開啟。\n當然，這對某個神偷來說不值一提。"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "回合開始時對隨機一名敵人造成 [Arg1] 點<FixedDamage:純粹傷害>。在本場戰鬥內打出 7 次「打擊」後，傷害值變為 [Arg2]，打出 21 次「打擊」後，立刻對全體敵人造成 [Arg3] 點<FixedDamage:純粹傷害>。"
  },
  RelicConfig_13787_Desc = {
    Text = "回合開始時對隨機一名敵人造成 [Arg1] 點<FixedDamage:純粹傷害>。在本場戰鬥內打出 7 次「打擊」後，傷害值變為 [Arg2]，打出 21 次「打擊」後，立刻對全體敵人造成 [Arg3] 點<FixedDamage:純粹傷害>。"
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:老舊拼圖>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "曾經鑲嵌在沉重畫框中的藝術品，從展出的那天起便缺了一塊。"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "觸腕上限減少 2 條。回合結束時額外使所有觸腕攻擊 1 次。"
  },
  RelicConfig_13788_Desc = {
    Text = "觸腕上限減少 2 條。回合結束時額外使所有觸腕攻擊 1 次。"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:苦痛聖腕>"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "每次牌庫重置，獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13789_Desc = {
    Text = "每次牌庫重置，獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:哭泣煙斗>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "這究竟是仇恨的產物，還是復仇的結果？"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "每次地圖移動會獲得 10 個黑印，但地圖移動帶來的精神壓力將提高 10 點。"
  },
  RelicConfig_13790_Desc = {
    Text = "每次地圖移動會獲得 10 個黑印，但地圖移動帶來的精神壓力將提高 10 點。"
  },
  RelicConfig_13790_Name = {Text = "無底袋"},
  RelicConfig_13791_BattleDesc = {
    Text = "拾取該造物時選擇一張指令卡，將一張它的複製加入牌庫。"
  },
  RelicConfig_13791_Desc = {
    Text = "拾取該造物時選擇一張指令卡，將一張它的複製加入牌庫。"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:須臾的火>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "搖曳的光，微弱的希望。"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "每當你損失生命，<EmbryoFusionIconKeywords:胚胎融合>+10。若生命低於 50% 時效果翻倍。"
  },
  RelicConfig_13792_Desc = {
    Text = "每當你損失生命，<EmbryoFusionIconKeywords:胚胎融合>+10。若生命低於 50% 時效果翻倍。"
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:銹蝕鋼鋸>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "解剖醫生一生都看不到美麗的女人，只有一麻袋骨頭、因疾病發炎的神經、肌肉和組織。"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "拾取時隊伍黑印掉落變為原始值的 150%。回復生命後，所有喚醒體獲得 3 點狂氣；失去生命後，獲得 [Arg1] 點<PowerIconKeywords:力量>和觸腕傷害，每回合合計最多生效 5 次。"
  },
  RelicConfig_13793_Desc = {
    Text = "拾取時隊伍黑印掉落變為原始值的 150%。回復生命後，所有喚醒體獲得 3 點狂氣；失去生命後，獲得 [Arg1] 點<PowerIconKeywords:力量>和觸腕傷害，每回合合計最多生效 5 次。"
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:時靈擺「月亮」>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "回合結束後所有喚醒體獲得 5 狂氣。每剩餘 1 點算力，所有喚醒體就額外獲得 3 狂氣。"
  },
  RelicConfig_13794_Desc = {
    Text = "回合結束後所有喚醒體獲得 5 狂氣。每剩餘 1 點算力，所有喚醒體就額外獲得 3 狂氣。"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:原型電池>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "可擕式的希望。"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "抽搐也是活性的一種。"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "戰鬥結束時，生命值剩餘50%以下時，升級為一個白銀造物"
  },
  RelicConfig_13796_Desc = {
    Text = "戰鬥結束時，生命值剩餘50%以下時，升級為一個白銀造物。"
  },
  RelicConfig_13796_Name = {
    Text = "破舊的筆記本2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "一本破舊的日記本，內頁中塞滿了夾頁，粗看至少包含艾爾沃斯地圖、實驗記錄、佈滿三角融蝕痕的信箋。\n筆記前段的內容字跡工整端正，後續卻逐步潦草凌亂。"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "打出3張打擊卡後，升級為一個黃金造物"
  },
  RelicConfig_13797_Desc = {
    Text = "打出3張打擊卡後，升級為一個黃金造物。"
  },
  RelicConfig_13797_Name = {
    Text = "破舊的筆記本1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "一本破舊的日記本，內頁中塞滿了夾頁，粗看至少包含艾爾沃斯地圖、實驗記錄、佈滿三角融蝕痕的信箋。\n筆記前段的內容字跡工整端正，後續卻逐步潦草凌亂。"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "戰鬥開始時，你的所有症狀卡獲得<NothingnessIconKeywords:虛無>，卡組中每有 1 張症狀卡就獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13798_Desc = {
    Text = "戰鬥開始時，你的所有症狀卡獲得<NothingnessIconKeywords:虛無>，卡組中每有 1 張症狀卡就獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:哈福德靈藥>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "成分不明的藥物。\n據說著名提琴家埃裡克對其青睞有加。"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "戰鬥首回合開始時，將<DerivativeCardKeywords_1:「遺影迴響」>加入手中；第 2 回合將<DerivativeCardKeywords_41:「銀鑰共鳴」>加入手中；第 3 回合將<DerivativeCardKeywords_39:「過往回聲」>加入手中。"
  },
  RelicConfig_13799_Desc = {
    Text = "戰鬥首回合開始時，將<DerivativeCardKeywords_1:「遺影迴響」>加入手中；第 2 回合將<DerivativeCardKeywords_41:「銀鑰共鳴」>加入手中；第 3 回合將<DerivativeCardKeywords_39:「過往回聲」>加入手中。"
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:時靈擺「群星」>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "回合開始時，將 1 張<DerivativeCardKeywords_6:「陽傘」>加入手中，打出 6 張卡牌後，使手牌中所有的<DerivativeCardKeywords_6:「陽傘」><AlertIconKeywords:戒備>提高 [Arg2]。"
  },
  RelicConfig_13800_Desc = {
    Text = "回合開始時，將 1 張<DerivativeCardKeywords_6:「陽傘」>加入手中，打出 6 張卡牌後，使手牌中所有的<DerivativeCardKeywords_6:「陽傘」><AlertIconKeywords:戒備>提高 [Arg2]。"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:旅行陽傘>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "在無光之地綻放。"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "常規戰鬥中所有敵人的生命提升 30%，戰鬥勝利時額外獲得 25 個黑印。"
  },
  RelicConfig_13801_Desc = {
    Text = "常規戰鬥中所有敵人的生命提升 30%，戰鬥勝利時額外獲得 25 個黑印。"
  },
  RelicConfig_13801_Name = {
    Text = "殘破戰旗"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "拾取時最大生命提高 [Arg1] 點。若拾取時生命低於 25%，最大生命提高變為 [Arg2] 點。"
  },
  RelicConfig_13802_Desc = {
    Text = "拾取時最大生命提高 [Arg1] 點。若拾取時生命低於 25%，最大生命提高變為 [Arg2] 點。"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:錫蘭紅茶>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "健康飲食，從你我做起。"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "每 3 個回合獲得 3 條臨時觸腕。"
  },
  RelicConfig_13803_Desc = {
    Text = "每 3 個回合獲得 3 條臨時觸腕。"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:潛水頭盔>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "夢想是星辰大海！"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "回合結束時獲得 [Arg1] 點護盾。若你的護盾為 0 或 3 的倍數，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13804_Desc = {
    Text = "回合結束時獲得 [Arg1] 點護盾。若你的護盾為 0 或 3 的倍數，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:求救信號>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "他沒有等到救援。"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "抽到症狀卡時獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。你每擁有 1 個詛咒造物，暴擊率和暴擊傷害就提高 10%。"
  },
  RelicConfig_13806_Desc = {
    Text = "抽到症狀卡時獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。你每擁有 1 個詛咒造物，暴擊率和暴擊傷害就提高 10%。"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:深淵通信>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "荒無人煙的郊外，孤獨的電話亭中鈴聲響起。\n「暗……嘶……無邊的……嘶嘶……黑暗……」"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "戰鬥開始時<EmbryoFusionIconKeywords:胚胎融合> +50。每存在一名至少擁有 50 點狂氣的喚醒體，額外生效 1 次"
  },
  RelicConfig_13807_Desc = {
    Text = "戰鬥開始時<EmbryoFusionIconKeywords:胚胎融合> +50。每存在一名至少擁有 50 點狂氣的喚醒體，額外生效 1 次。"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:親愛的寶貝>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "木匠為妻子做了個栩栩如生的木偶，它將代替他們的兒子，在她腹中沉睡。"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "釋放狂氣爆發後，將一張對應喚醒體的隨機卡牌置入手中，該卡牌獲得<DepleteIconKeywords:消耗>與<NothingnessIconKeywords:虛無>。戰鬥結束後，回復 [Arg1] 點生命。"
  },
  RelicConfig_13808_Desc = {
    Text = "釋放狂氣爆發後，將一張對應喚醒體的隨機卡牌置入手中，該卡牌獲得<DepleteIconKeywords:消耗>與<NothingnessIconKeywords:虛無>。戰鬥結束後，回復 [Arg1] 點生命。"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:醫生手提箱>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "象徵醫生身分的手提箱，十分沉重。\n打開它的，未必是真的醫生。"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "所有造物價格降低 20。"
  },
  RelicConfig_13809_Desc = {
    Text = "所有造物價格降低 20。"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:伶牙俐齒>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "能說會道的不止商人，亦有虔信者。"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "每第 3 次打出「打擊」後，對全體敵方造成 [Arg1] 點<FixedDamage:純粹傷害>，對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13811_Desc = {
    Text = "每第 3 次打出「打擊」後，對全體敵方造成 [Arg1] 點<FixedDamage:純粹傷害>，對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:銹蝕柳葉刀>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "不適宜用於割開活體。"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "拾取時最大生命提高 100%，回合開始時，失去 [Arg1] 點生命。"
  },
  RelicConfig_13812_Desc = {
    Text = "拾取時最大生命提高 100%，回合開始時，失去 [Arg1] 點生命。"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆長生者血肉☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "「海洋生物慣於斷臂求生。」"
  },
  RelicConfig_13813_BattleDesc = {
    Text = "戰鬥開始後精英敵人和首領敵人的當前生命降低 20%。"
  },
  RelicConfig_13813_Desc = {
    Text = "戰鬥開始後精英敵人和首領敵人的當前生命降低 20%。"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆舊船錨☆>"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "回合結束時手中每有 1 張未打出的卡牌，就使所有喚醒體獲得 2 狂氣。"
  },
  RelicConfig_13814_Desc = {
    Text = "回合結束時手中每有 1 張未打出的卡牌，就使所有喚醒體獲得 2 狂氣。"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "不再象徵公正。"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "拾取後選擇一張卡牌，使其算力消耗永久變為 1。"
  },
  RelicConfig_13815_Desc = {
    Text = "拾取後選擇一張卡牌，使其算力消耗永久變為 1。"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆精製義眼☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "一隻不再純潔的眼球。"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "戰鬥開始時，所有敵人獲得 [Arg1] 點<RetaliateIconKeywords:反擊>。每當造成傷害時，狂氣最低的喚醒體獲得 6 點狂氣。"
  },
  RelicConfig_13816_Desc = {
    Text = "戰鬥開始時，所有敵人獲得 [Arg1] 點<RetaliateIconKeywords:反擊>。每當造成傷害時，狂氣最低的喚醒體獲得 6 點狂氣。"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆哀嚎搖鈴☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "叮鈴，叮鈴，孩子在哭鬧；\n叮鈴，叮鈴，孩子在尖叫。\n叮鈴，叮鈴，孩子在哀嚎；\n叮鈴，叮鈴，它餓了，你知道。"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "每打出 6 張指令卡後，<TentacleInjurieIconKeywords:觸腕傷害> +[Arg1]。"
  },
  RelicConfig_13817_Desc = {
    Text = "每打出 6 張指令卡後，<TentacleInjurieIconKeywords:觸腕傷害> +[Arg1]。"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:裂頭蚴>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "只要我們的大腦仍是個謎，那麼裡面長滿觸腕也沒什麼好大驚小怪的。"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "暴擊率提高 50%，但戰鬥開始時<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  RelicConfig_13818_Desc = {
    Text = "暴擊率提高 50%，但戰鬥開始時<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:古怪鉤爪>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "難以辨識的物種。"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "打出 1 張算力消耗為 3 或以上的卡牌時，抽 1 張牌並獲得 1 點算力。"
  },
  RelicConfig_13819_Desc = {
    Text = "打出 1 張算力消耗為 3 或以上的卡牌時，抽 1 張牌並獲得 1 點算力。"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "已無人記得她的美。"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "每當獲得症狀卡後，使最大生命提高 [Arg1] 點。"
  },
  RelicConfig_13820_Desc = {
    Text = "每當獲得症狀卡後，使最大生命提高 [Arg1] 點。"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆乳香製劑☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "「甜美誘人的香氣。」"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "釋放狂氣爆發後，抽 1 張牌。若生命低於 25%，額外抽 1 張牌。"
  },
  RelicConfig_13821_Desc = {
    Text = "釋放狂氣爆發後，抽 1 張牌。若生命低於 25%，額外抽 1 張牌。"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:求知讀書輪>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "閱讀時請注意安全。"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "每回合造成主動傷害時，提高 [Arg1] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>，最多堆疊 3 次。層數滿時生成 1 條無視觸腕上限的臨時觸腕。"
  },
  RelicConfig_13822_Desc = {
    Text = "每回合造成主動傷害時，提高 [Arg1] 點臨時<TentacleInjurieIconKeywords:觸腕傷害> ，最多堆疊 3 次。層數滿時生成 1 條無視觸腕上限的臨時觸腕。"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:螺湮的歡愉>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "長眠之主，候汝入夢。"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "你每打出的第 [Arg1] 張指令卡會生效 2 次，打出後回到手中。"
  },
  RelicConfig_13823_Desc = {
    Text = "你每打出的第 [Arg1] 張指令卡會生效 2 次，打出後回到手中。"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "遊走於繁星之間。"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "每回合開始時<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上時，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  RelicConfig_13824_Desc = {
    Text = "每回合開始時<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上時，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:人魚淚珠>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "不要將它放入水中。"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "每消耗 10 個黑印，回復 [Arg1] 點生命。"
  },
  RelicConfig_13825_Desc = {
    Text = "每消耗 10 個黑印，回復 1% 生命。"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "每使用一張「增益卡」/ 「症狀卡」/「狀態卡」，狂氣最低的喚醒體獲得 10 狂氣。"
  },
  RelicConfig_13826_Desc = {
    Text = "每使用一張「增益卡」/ 「症狀卡」/「狀態卡」，狂氣最低的喚醒體獲得 10 狂氣。"
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:異鄉郵票夾>"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "拾取後獲得 75 黑印。選擇 1 個造物，使其變化為 1 個隨機詛咒造物。"
  },
  RelicConfig_13827_Desc = {
    Text = "拾取後獲得 75 黑印。選擇 1 個造物，使其變化為 1 個隨機詛咒造物。"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:詛咒石碑>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "撫摸時聽見了深海的呼喚。"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "每回合首次打出指令卡進入棄牌堆後，將算力消耗降低 1 的該卡牌臨時複製洗入抽牌堆。"
  },
  RelicConfig_13828_Desc = {
    Text = "每回合首次打出指令卡進入棄牌堆後，將算力消耗降低 1 的該卡牌臨時複製洗入抽牌堆。"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:失聲唱機>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "他的聲音消失在了風中。"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_13829_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  RelicConfig_13829_Name = {
    Text = "銹蝕鑰匙"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "造成生命回復時也會獲得 [Arg1] 點護盾。第 3 回合開始後獲得 [Arg2] 點<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13830_Desc = {
    Text = "造成生命回復時也會獲得 [Arg1] 點護盾。第 3 回合開始後獲得 [Arg2] 點<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:蝴蝶標本>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "至今，他也被誰深深地喜愛著。"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "每當一張指令卡進入<DimensionalSpaceIconKeywords:超維空間>後，使對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13831_Desc = {
    Text = "每當一張指令卡進入<DimensionalSpaceIconKeywords:超維空間>後，使對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:時間之蟲>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "一塊同時存在於鐘錶店與昆蟲博物館的懷錶。\n洪積元年開始後，被納入大學館藏。"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "進入超維回合後解除自身<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>狀態，並<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 3 回合，本回合所有喚醒體最終傷害提高 15%。"
  },
  RelicConfig_13832_Desc = {
    Text = "進入超維回合後解除自身<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>狀態，並<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 3 回合，本回合所有喚醒體最終傷害提高 15%。"
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:超弦懷錶>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "「哎呀，懷錶停了。」"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "每造成 1 次傷害，對目標施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13833_Desc = {
    Text = "每造成 1 次傷害，對目標施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆蒙塵縫紉機☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "一位慈祥的母親，縫補心臟上的傷。"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "每第 5 次獲得護盾時，同時獲得<RetaliateIconKeywords:反擊>，反擊值等於獲得護盾的 [Arg1]%。"
  },
  RelicConfig_13834_Desc = {
    Text = "每第 5 次獲得護盾時，同時獲得<RetaliateIconKeywords:反擊>，反擊值等於獲得護盾的 [Arg1]%。"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:先賢斷章>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "「人類何其愚蠢，只因陳腐，便會盲信。」"
  },
  RelicConfig_13835_BattleDesc = {
    Text = "回合開始時抽 1 張牌。"
  },
  RelicConfig_13835_Desc = {
    Text = "回合開始時抽 1 張牌。"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:定向羅盤>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "指示的並非方向，僅是磁場。"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "戰鬥開始時，隨機將<DerivativeCardKeywords_3:「驚厥」>和<DerivativeCardKeywords_4:「靈感」>置入<DimensionalSpaceIconKeywords:超維空間>直至達到上限。進入超維回合後，獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13836_Desc = {
    Text = "戰鬥開始時，隨機將<DerivativeCardKeywords_3:「驚厥」>和<DerivativeCardKeywords_4:「靈感」>置入<DimensionalSpaceIconKeywords:超維空間>直至達到上限。進入超維回合後，獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "不同於無常的命運，群星自有運行法則。"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "拾取時獲得 100% <DeathResistanceIconKeywords:死亡抵抗>（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。觸發<DeathResistanceIconKeywords:死亡抵抗>後，本場戰鬥每回合開始時回復 [Arg1] 點生命。"
  },
  RelicConfig_13837_Desc = {
    Text = "拾取時獲得 100% <DeathResistanceIconKeywords:死亡抵抗>（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。觸發<DeathResistanceIconKeywords:死亡抵抗>後，本場戰鬥每回合開始時回復 [Arg1] 點生命。"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "探險者必備的好東西。過度依賴它的話，它就會成為你的一部分。"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "這是個沒有效果的任務造物2"
  },
  RelicConfig_13838_Desc = {
    Text = "這是個沒有效果的任務造物2"
  },
  RelicConfig_13838_Name = {
    Text = "任務造物測試2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "需要補充內容的造物"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "打出手牌中最後 1 張牌時，抽 2 張牌。每回合最多觸發 2 次。"
  },
  RelicConfig_13839_Desc = {
    Text = "打出手牌中最後 1 張牌時，抽 2 張牌。每回合最多觸發 2 次。"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆魔術手套☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "「別害怕，這只是魔術。」"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "每 3 回合對所有敵人添加 1 層<WeaknessIconKeywords:虛弱>。對<WeaknessIconKeywords:虛弱>敵人造成傷害後獲得  [Arg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  RelicConfig_13840_Desc = {
    Text = "每 3 回合對所有敵人添加 1 層<WeaknessIconKeywords:虛弱>。對<WeaknessIconKeywords:虛弱>敵人造成傷害後獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:惡童>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "脫胎於純粹的惡，即使這並非它所願。"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "所有「打擊」造成的暴擊傷害提高 20%。戰鬥開始時，將 1 張<DerivativeCardKeywords_40:「美麗瞬間 」>加入手中。"
  },
  RelicConfig_13841_Desc = {
    Text = "所有「打擊」造成的暴擊傷害提高 20%。戰鬥開始時，將 1 張<DerivativeCardKeywords_40:「美麗瞬間 」>加入手中。"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:美麗瞬間>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "將須臾的美保存至永遠。"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "免疫一次未觸發死亡抵抗的致命傷害，回復 [Arg1] 生命並使該造物永久失效。"
  },
  RelicConfig_13842_Desc = {
    Text = "免疫一次未觸發死亡抵抗的致命傷害，回復 [Arg1] 生命並使該造物永久失效。"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "你造成<WeaknessIconKeywords:虛弱>時，獲得 [Arg1] 點護盾；造成<VulnerabilityIconKeywords:易傷>時，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。若在 1 回合內觸發了這兩個效果，額外獲得 [Arg1] 點護盾和 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13844_Desc = {
    Text = "你造成<WeaknessIconKeywords:虛弱>時，獲得 [Arg1] 點護盾；造成<VulnerabilityIconKeywords:易傷>時，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。若在 1 回合內觸發了這兩個效果，額外獲得 [Arg1] 點護盾和 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:沉重畫框>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "一位精神錯亂的藝術家留下的最後作品，據說能從其中看到他驚恐的面容。"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "耗盡最後 1 點算力時，獲得 2 算力。每回合最多觸發 2 次。"
  },
  RelicConfig_13845_Desc = {
    Text = "耗盡最後 1 點算力時，獲得 2 算力。每回合最多觸發 2 次。"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆銀白差分機☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "「它改變了歷史。」"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "每當你失去生命，就獲得 [Arg1] 點<PowerIconKeywords:力量>，每場戰鬥最多堆疊 10 次。層數滿時，回復已損失生命值 25% 的生命。"
  },
  RelicConfig_13846_Desc = {
    Text = "每當你失去生命，就獲得 [Arg1] 點<PowerIconKeywords:力量>，每場戰鬥最多堆疊 10 次。層數滿時，回復已損失生命值 25% 的生命。"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:無上榮寵>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "優雅、神秘的黑色短毛貓，據說在某個遠方的沙漠國度被視作神明的化身。可那位神祇的名諱，如今已無人知曉。\n被崇拜，被敬仰，被遺忘，或許是為神明的宿命。"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 20%，擊殺敵人後擊殺者獲得 20 狂氣。"
  },
  RelicConfig_13847_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 20%，擊殺敵人後擊殺者獲得 20 狂氣。"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:祭司權杖>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "不被許可的虔誠。"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "拾取時隊伍界域精通變為原始值的 150%。每回合打出第 5 張指令卡後，所有喚醒體獲得 20 狂氣。"
  },
  RelicConfig_13848_Desc = {
    Text = "拾取時隊伍界域精通變為原始值的 150%。每回合打出第 5 張指令卡後，所有喚醒體獲得 20 狂氣。"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:時靈擺「不潔」>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "每回合造成第 3 次傷害後，獲得 [Arg1] 點護盾。每回合造成第 6 次傷害後，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13849_Desc = {
    Text = "每回合造成第 3 次傷害後，獲得 [Arg1] 點護盾。每回合造成第 6 次傷害後，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "看來，他也沒能逃出去。"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "每進行 1 次<DevouredIconKeywords:吞噬>，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13851_Desc = {
    Text = "每進行 1 次<DevouredIconKeywords:吞噬>，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "殺人越貨撓癢癢的絕佳工具。"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "拾取時選擇一名喚醒體將其覺醒，其覺醒卡算力消耗永久降低 1。"
  },
  RelicConfig_13852_Desc = {
    Text = "拾取時選擇一名喚醒體將其覺醒，其覺醒卡算力消耗永久降低 1。"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:彩蛋時間>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "縱享歡樂，但不可食用。"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "每當造成傷害時獲得 [Arg1] 點臨時<RetaliateIconKeywords:反擊>，每回合最多觸發 5 次，第 5 次觸發時將一張 <DerivativeCardKeywords_4:「靈感」> 置入抽牌堆。"
  },
  RelicConfig_13853_Desc = {
    Text = "每當造成傷害時獲得 [Arg1] 點臨時<RetaliateIconKeywords:反擊>，每回合最多觸發 5 次，第 5 次觸發時將一張 <DerivativeCardKeywords_4:「靈感」> 置入抽牌堆。"
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:遺落的祭祀刀>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "刃面彎曲的匕首，常用於祭祀儀式。"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "回合開始時抽 2 張牌，獲得 2 點算力。每當你抽到 1 張指令卡或靈知覺醒時，隨機變化其算力消耗。（0-4）"
  },
  RelicConfig_13854_Desc = {
    Text = "回合開始時抽 2 張牌，獲得 2 點算力。每當你抽到 1 張指令卡或靈知覺醒時，隨機變化其算力消耗。（0-4）"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:詭術禮帽>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "歡迎來到卡茜亞小姐的仙境馬戲團！小心些，不要隨便觸碰魔術道具哦。要是一不小心被咬傷，那可就糟糕了。\n畢竟，它上一次嘗到血的滋味，造成的後果可是很恐怖的。\n\n禮帽眨了眨眼睛，彷彿隨時會破繭而出。"
  },
  RelicConfig_13855_BattleDesc = {
    Text = "回合開始和每回合回復生命時獲得 [Arg1] 點<RetaliateIconKeywords:反擊>，每回合最多獲得 3 次反擊。達到上限時，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13855_Desc = {
    Text = "回合開始和每回合回復生命時獲得 [Arg1] 點<RetaliateIconKeywords:反擊>，每回合最多獲得 3 次反擊。達到上限時，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:小音樂盒>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "德克斯特的宅邸中有許多藏品，在被摔壞前，小音樂盒曾是德克斯特小小姐最喜歡的玩具。\n時光荏苒，當德克斯特小姐再次找到她時，她齒輪鬆弛、音樂變調，卻仍未停止旋轉。"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "暴擊傷害提高 15%。「打擊」暴擊率提高 40%。"
  },
  RelicConfig_13856_Desc = {
    Text = "暴擊傷害提高 15%。「打擊」暴擊率提高 40%。"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:白鴉喙>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "在它面前沒有秘密。"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點<RetaliateIconKeywords:反擊>。若本場戰鬥內第 6 次觸發，則使你的<RetaliateIconKeywords:反擊>翻倍。"
  },
  RelicConfig_13857_Desc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點<RetaliateIconKeywords:反擊>。若本場戰鬥內第 6 次觸發，則使你的<RetaliateIconKeywords:反擊>翻倍。"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆六分儀☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "為你指引的，僅有歧途。"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "每回合額外抽 1 張牌，獲得 1 點算力。"
  },
  RelicConfig_13858_Desc = {
    Text = "每回合額外抽 1 張牌，獲得 1 點算力。"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆美好回憶☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "有人永遠留在了那個夏天。"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "回合開始時抽 1 張牌。戰鬥開始時，將 1 張<DerivativeCardKeywords_4:「靈感」>洗入你的牌庫。每通過 1 場戰鬥都會使洗入的<DerivativeCardKeywords_4:「靈感」>提高 1，最多 3 次。"
  },
  RelicConfig_13859_Desc = {
    Text = "回合開始時抽 1 張牌。戰鬥開始時，將 1 張<DerivativeCardKeywords_4:「靈感」>洗入你的牌庫。每通過 1 場戰鬥都會使洗入的<DerivativeCardKeywords_4:「靈感」>提高 1，最多 3 次。"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:普拉斯諾鏡>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "光與影的戲法。"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "每當連續打出同一個喚醒體的牌，該喚醒體獲得 8 狂氣。"
  },
  RelicConfig_13860_Desc = {
    Text = "每當連續打出同一個喚醒體的牌，該喚醒體獲得 8 狂氣。"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:精密計時器>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "人類有史以來最邪惡的發明之一。"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "拾取時選擇一張喚醒體的卡牌，使其算力消耗降低 1，並將其視為「打擊」。"
  },
  RelicConfig_13861_Desc = {
    Text = "拾取時選擇一張喚醒體的卡牌，使其算力消耗降低 1，並將其視為「打擊」。"
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:偶然謬誤>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "笑個痛快！"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "拾取後永久失去 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_13862_Desc = {
    Text = "拾取後永久失去 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:七鰓鰻之吻>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "想要一個深深的吻嗎？要你命的那種。"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "每場戰鬥的首個回合，獲得 3 點算力。"
  },
  RelicConfig_13863_Desc = {
    Text = "每場戰鬥的首個回合，獲得 3 點算力。"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:懷錶鏡>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "記憶凝固在往昔的時間，深埋於黑色之底。"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "每回合第一次打出指令卡後，將對應喚醒體的一張「打擊」置入手中，賦予其<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13864_Desc = {
    Text = "每回合第一次打出指令卡後，將對應喚醒體的一張「打擊」置入手中，賦予其<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:新式輪軸>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "從鄉村騎向都市，從災難走向復興。"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "每回合第一次打出指令卡後，將對應喚醒體的一張「防禦」置入手中並附加<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13865_Desc = {
    Text = "每回合第一次打出指令卡後，將對應喚醒體的一張「防禦」置入手中並附加<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:寂靜序曲>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "著名小提琴家埃裡克·艾克施坦因的提琴。\n如今，它已不可再奏響。"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "每 3 回合對所有敵人添加 1 層<VulnerabilityIconKeywords:易傷>。對<VulnerabilityIconKeywords:易傷>敵人造成傷害後，使其失去 [Arg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  RelicConfig_13866_Desc = {
    Text = "每 3 回合對所有敵人添加 1 層<VulnerabilityIconKeywords:易傷>。對<VulnerabilityIconKeywords:易傷>敵人造成傷害後，使其失去 [Arg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "在夜的歡笑聲中，獨木舟的剪影在湖面上自如地滑動。"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "手牌上限提高 3，但每回合抽牌數降低 1。回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_13867_Desc = {
    Text = "手牌上限提高 3，但每回合抽牌數降低 1。回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:意識銘刻>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "古老的部落堅信，在死者的頭顱上篆刻特殊符號，能夠將他的靈魂留下，獲得永遠的陪伴。"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "每釋放 4 次狂氣爆發後，所有手牌算力消耗降低 1。"
  },
  RelicConfig_13868_Desc = {
    Text = "每釋放 4 次狂氣爆發後，所有手牌算力消耗降低 1。"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆逃生平面圖☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "「登船後，請首先找到離艙室最近的安全出口。」"
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每造成 1 次主動傷害，臨時觸腕傷害 + [Arg1] ，每造成 1 次觸腕傷害，獲得 [Arg2] 點護盾。每回合最多生效 6 次。"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每造成 1 次主動傷害，臨時觸腕傷害 + [Arg1] ，每造成 1 次觸腕傷害，獲得 [Arg2] 點護盾。每回合最多生效 6 次。"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:時靈擺「夢魘」>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "每消耗 1 點算力，使對應的喚醒體獲得 2 點狂氣。"
  },
  RelicConfig_13870_Desc = {
    Text = "每消耗 1 點算力，使對應的喚醒體獲得 2 點狂氣。"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:銀色方扣緞帶>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "曾經出現在案發現場的緞帶，被外力撕扯成了兩截。\n其中一截曾從高空中飄下，落在女孩的掌心。"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。拾取時最大生命降低 30%。"
  },
  RelicConfig_13871_Desc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。拾取時最大生命降低 30%。"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:噩夢表像>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "小心，放縱的深眠會在你不知道的時候吞噬一切。"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "打出「<ExaltIconKeywords:靈知覺醒>」後，移除所有敵人的護盾。"
  },
  RelicConfig_13873_Desc = {
    Text = "打出「<ExaltIconKeywords:靈知覺醒>」後，移除所有敵人的護盾。"
  },
  RelicConfig_13873_Name = {
    Text = "黑色鏡面"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "奇數回合中，剩餘手牌數量為 0 時，抽 2 張牌；偶數回合中，剩餘算力為 0 時，獲得 2 點算力。"
  },
  RelicConfig_13874_Desc = {
    Text = "奇數回合中，剩餘手牌數量為 0 時，抽 2 張牌；偶數回合中，剩餘算力為 0 時，獲得 2 點算力。"
  },
  RelicConfig_13874_Name = {
    Text = "異化黃金嚮導"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "打出「打擊」與「防禦」後，對應喚醒體獲得 35 狂氣。但是它們的算力消耗+1。"
  },
  RelicConfig_13875_Desc = {
    Text = "打出「打擊」與「防禦」後，對應喚醒體獲得 35 狂氣。但是它們的算力消耗+1。"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:殘缺面孔>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "誰的面容，充滿驚恐，被凝固在時光之中。"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "每回合獲得第 2 次護盾後，獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。每回合獲得第 4 次護盾後，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13877_Desc = {
    Text = "每回合獲得第 2 次護盾後，獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。每回合獲得第 4 次護盾後，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:知無不言>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "它傳遞了無數主動或被動說出的秘密。"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "每打出的第 6 張指令卡使其從棄牌堆回到手中。"
  },
  RelicConfig_13878_Desc = {
    Text = "每打出的第 6 張指令卡使其從棄牌堆回到手中。"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:在夕光裡>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "一起來拍照吧！體驗一把面對真實的痛感。"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "每釋放 5 次狂氣爆發後，使釋放狂氣爆發的喚醒體獲得 100 狂氣。"
  },
  RelicConfig_13879_Desc = {
    Text = "每釋放 5 次狂氣爆發後，使釋放狂氣爆發的喚醒體獲得 100 狂氣。"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "承載著希望、祝福與愛。"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "造成主動傷害時獲得 [Arg1] 點護盾。回復生命時，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13880_Desc = {
    Text = "造成主動傷害時獲得 [Arg1] 點護盾。回復生命時，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:我們的家>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "他們之前在一起，之後也會永遠在一起。他們是相親相愛的一家人。"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "奇數回合開始時，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。偶數回合開始時，獲得 [Arg2] 點臨時<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13881_Desc = {
    Text = "奇數回合開始時，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。偶數回合開始時，獲得 [Arg2] 點臨時<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:雙生人偶>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "雙生是舊時代的禮物，是留給未來的寓言。"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "每回合打出第一張指令卡的對應喚醒體，在回合結束時獲得 20 狂氣，若同時擁有造物「奉獻精神」，使其他喚醒體也獲得 5 狂氣。"
  },
  RelicConfig_13882_Desc = {
    Text = "每回合打出第一張指令卡的對應喚醒體，在回合結束時獲得 20 狂氣，若同時擁有造物「奉獻精神」，使其他喚醒體也獲得 5 狂氣。"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:母親造像>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "「給你，什麼都可以給你，求求你，放過他。」"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "每當一名喚醒體進行過 1 次<DevouredIconKeywords:吞噬>，其他喚醒體獲得 10 狂氣。"
  },
  RelicConfig_13883_Desc = {
    Text = "每當一名喚醒體進行過 1 次<DevouredIconKeywords:吞噬>，其他喚醒體獲得 10 狂氣。"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:金色夢鄉>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "蛻變之日即是你的死期。"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "「打擊」對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13884_Desc = {
    Text = "「打擊」對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:神經毒素>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "提取，淬煉。"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "戰鬥開始時，將 1 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中，若為首領戰，額外獲得 1 張<DerivativeCardKeywords_1:「遺影迴響」>。"
  },
  RelicConfig_13885_Desc = {
    Text = "戰鬥開始時，將 1 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中，若為首領戰，額外獲得 1 張<DerivativeCardKeywords_1:「遺影迴響」>。"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:通訊設備>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "期待或恐懼它發出清脆鈴聲的瞬間。"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "每次重置牌庫時，將 2 張<DerivativeCardKeywords_5:「漁叉」>和 1 張<DerivativeCardKeywords_6:「陽傘」>加入手牌。"
  },
  RelicConfig_13886_Desc = {
    Text = "每次重置牌庫時，將 2 張<DerivativeCardKeywords_5:「漁叉」>和 1 張<DerivativeCardKeywords_6:「陽傘」>加入手牌。"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "它本應裝載精緻，而不是死亡。"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "回合開始時，將 1 張<DerivativeCardKeywords_5:「漁叉」>加入手中。釋放狂氣爆發後，使手牌中所有的<DerivativeCardKeywords_5:「漁叉」><PowerIconKeywords:力量>提高 [Arg2]。"
  },
  RelicConfig_13887_Desc = {
    Text = "回合開始時，將 1 張<DerivativeCardKeywords_5:「漁叉」>加入手中。釋放狂氣爆發後，使手牌中所有的<DerivativeCardKeywords_5:「漁叉」><PowerIconKeywords:力量>提高 [Arg2]。"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:漁叉>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "無論怎麼看都很普通。"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] 點護盾。在本場戰鬥內打出 7 次「防禦」後，立刻獲得 [Arg2] 點護盾。在本場戰鬥內打出 21 次「防禦」後，獲得 1 層臨時屏障。"
  },
  RelicConfig_13888_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 點護盾。在本場戰鬥內打出 7 次「防禦」後，立刻獲得 [Arg2] 點護盾。在本場戰鬥內打出 21 次「防禦」後，獲得 1 層臨時屏障。"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:普特尼晨報>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "您最貼心的馬桶伴侶。"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "進入超維回合後，獲得 3 點算力。"
  },
  RelicConfig_13889_Desc = {
    Text = "進入超維回合後，獲得 3 點算力。"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:輝光沙漏>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "一份可計量的時間。"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "戰鬥開始時，對所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，若為首領戰，額外施加 2 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  RelicConfig_13890_Desc = {
    Text = "戰鬥開始時，對所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，若為首領戰，額外施加 2 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:變色拘束服>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "不止有時間能使織物變色，恐懼與痛苦亦能。"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "每回合打出的第 1 張指令卡若觸發了躍遷效果，抽 1 張牌，否則獲得 1 點算力。若為超維回合，同時具有以上 2 個效果。"
  },
  RelicConfig_13891_Desc = {
    Text = "每回合打出的第 1 張指令卡若觸發了躍遷效果，抽 1 張牌，否則獲得 1 點算力。若為超維回合，同時具有以上 2 個效果。"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:躍遷裝置>"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "獲得一個任務。完成任務後，獲得獎勵。【任務事件佔位】"
  },
  RelicConfig_13892_Desc = {
    Text = "獲得一個任務。完成任務後，獲得獎勵。【任務事件佔位】"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:破舊的日記本>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "一本破舊的日記本，內頁中塞滿了夾頁，粗看至少包含艾爾沃斯地圖、實驗記錄、佈滿三角融蝕痕的信箋。\n筆記前段的內容字跡工整端正，後續卻逐步潦草凌亂。"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "每第 4 次獲得護盾值時，回復等同於該次護盾值 50%的生命。"
  },
  RelicConfig_13893_Desc = {
    Text = "每第 4 次獲得護盾值時，回復等同於該次護盾值 50%的生命。"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "除開美人魚，哨聲還能吹來颶風、臭皮靴和一百天沒洗澡的老水手。"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "若上回合打出的卡牌數量小於等於 4，本回合打出的第一張卡牌生效 2 次。"
  },
  RelicConfig_13894_Desc = {
    Text = "若上回合打出的卡牌數量小於等於 4，本回合打出的第一張卡牌生效 2 次。"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆噩夢魂燈☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "引入幻夢。"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "每當你失去生命時，狂氣最低的喚醒體獲得 10 狂氣。每當你失去 5 次生命時，回復 20% 已損失生命。"
  },
  RelicConfig_13895_Desc = {
    Text = "每當你失去生命時，狂氣最低的喚醒體獲得 10 狂氣。每當你失去 5 次生命時，回復 20% 已損失生命。"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:時靈擺「解析」>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "最大算力提高 2。每次重置牌庫時將 1 張<DerivativeCardKeywords_9:「蹣跚」>加入抽牌堆。"
  },
  RelicConfig_13896_Desc = {
    Text = "最大算力提高 2。每次重置牌庫時將 1 張<DerivativeCardKeywords_9:「蹣跚」>加入抽牌堆。"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:黑燭>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "燃燒清醒，墮入虛妄。"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "「<ExaltIconKeywords:靈知覺醒>」在回合結束時保留。"
  },
  RelicConfig_13897_Desc = {
    Text = "「<ExaltIconKeywords:靈知覺醒>」在回合結束時保留。"
  },
  RelicConfig_13897_Name = {
    Text = "白色鏡面"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "每有 1 個喚醒體已覺醒就使<ProficientInRealmsIconKeywords:界域精通>提高 35。打出「<ExaltIconKeywords:靈知覺醒>」後，隨機獲得 2 張該喚醒體的指令卡並附加「消耗」。"
  },
  RelicConfig_13898_Desc = {
    Text = "每有 1 個喚醒體已覺醒就使<ProficientInRealmsIconKeywords:界域精通>提高 35。打出「<ExaltIconKeywords:靈知覺醒>」後，隨機獲得 2 張該喚醒體的指令卡並附加「消耗」。"
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:祂的神諭>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "祂說，不要懼怕。"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "回合開始時<ProficientInRealmsIconKeywords:界域精通>提高 50。當不處於負面狀態時，<ProficientInRealmsIconKeywords:界域精通>提高變為 150。"
  },
  RelicConfig_13899_Desc = {
    Text = "回合開始時<ProficientInRealmsIconKeywords:界域精通>提高 50。當不處於負面狀態時，<ProficientInRealmsIconKeywords:界域精通>提高變為 150。"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "一捧令人感到些許懷念的銀芯。"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "使用「狂氣爆發」後，所有手牌算力消耗 -1。"
  },
  RelicConfig_13900_Desc = {
    Text = "使用「狂氣爆發」後，所有手牌的算力消耗 -1。"
  },
  RelicConfig_13900_Name = {
    Text = "異化文明之光"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "每打出 1 張指令卡就獲得 [Arg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。若你<DeathResistanceIconKeywords:死亡抵抗>大於等於 100%，改為獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13901_Desc = {
    Text = "每打出 1 張指令卡就獲得 [Arg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。若你<DeathResistanceIconKeywords:死亡抵抗>大於等於 100%，改為獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:怪蛇殘蛻>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "自殘蛻中重生。"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "回合開始後，獲得 [Arg2] 點護盾。回合結束後，對隨機敵人造成等同於當前護盾值 [Arg1]% 的<FixedDamage:純粹傷害>，首領戰傷害效果翻倍。"
  },
  RelicConfig_13902_Desc = {
    Text = "回合開始後，獲得 [Arg2] 點護盾。回合結束後，對隨機敵人造成等同於當前護盾值 [Arg1]% 的<FixedDamage:純粹傷害>，首領戰傷害效果翻倍。"
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:黃金嚮導>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "迷失方向的時候打開它吧，但要小心——它的日冕不可見到日光。"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "隱藏怪物意圖。每回合獲得 1 點算力，抽 1 張牌。"
  },
  RelicConfig_13904_Desc = {
    Text = "隱藏怪物意圖。每回合獲得 1 點算力，抽 1 張牌。"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:蠱惑風鈴>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "叮鈴鈴，叮鈴鈴。"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg2] 層<RetaliateIconKeywords:反擊>，打出「防禦」獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13905_Desc = {
    Text = "戰鬥開始後，獲得 [Arg2] 層<RetaliateIconKeywords:反擊>，打出「防禦」獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:刺蕁麻背心>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "無法分辨沾染的液體。"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "這是個沒有效果的周替造物4"
  },
  RelicConfig_13906_Desc = {
    Text = "這是個沒有效果的周替造物4"
  },
  RelicConfig_13906_Name = {
    Text = "日常挑戰周替造物4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 3 張，抽 2 張牌。"
  },
  RelicConfig_13907_Desc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 3 張，抽 2 張牌。"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:嶄新的錢包>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "印刻了彌薩格大學校徽的皮質錢包。\n裡面現在空空如也，什麼也沒有。"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "使用「狂氣爆發」後，所屬喚醒體獲得[Arg1]點狂氣。"
  },
  RelicConfig_13908_Desc = {
    Text = "使用「狂氣爆發」後，所屬喚醒體獲得[Arg1]點狂氣。"
  },
  RelicConfig_13908_Name = {
    Text = "異化無名之神的面紗"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "釋放狂氣爆發後，失去 8% 當前生命，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13909_Desc = {
    Text = "釋放狂氣爆發後，失去 8% 當前生命，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:厄運儀式鳥>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "乾癟的屍體發出了鳴叫聲。"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "釋放狂氣爆發後，對應喚醒體獲得 10 狂氣，獲得 [Arg1] 點護盾。"
  },
  RelicConfig_13910_Desc = {
    Text = "釋放狂氣爆發後，對應喚醒體獲得 10 狂氣，獲得 [Arg1] 點護盾。"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:無名之神的面紗>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "不可直視神。"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "每回合打出最後一張指令卡的對應喚醒體，在回合結束時獲得 20 狂氣，若同時擁有造物「母親造像」，使其他喚醒體也獲得 5 狂氣。"
  },
  RelicConfig_13911_Desc = {
    Text = "每回合打出最後一張指令卡的對應喚醒體，在回合結束時獲得 20 狂氣，若同時擁有造物「母親造像」，使其他喚醒體也獲得 5 狂氣。"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:奉獻精神>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "「給你，什麼都可以給你，求求你，饒過我。」"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "回合結束時，每有 1 張剩餘手牌，下回合開始時獲得 1 點算力。"
  },
  RelicConfig_13912_Desc = {
    Text = "回合結束時，每有 1 張剩餘手牌，下回合開始時獲得 1 點算力。"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:時靈擺「演繹」>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "回合開始時若生命大於 [Arg1]，失去 [Arg1] 點生命，當回合內獲得 [Arg2] 點<PowerIconKeywords:力量>和 [Arg3] 點<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13913_Desc = {
    Text = "回合開始時若生命大於 [Arg1]，失去 [Arg1] 點生命，當回合內獲得 [Arg2] 點<PowerIconKeywords:力量>和 [Arg3] 點<AlertIconKeywords:戒備>。"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:救濟之肢>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "神聖的一部分。\n縱然與軀幹分離，仍能感受到其上的溫暖。"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "「打擊」獲得 2 點算力，隨機棄 1 張牌；「防禦」抽 2 張牌，失去 1 點算力。每回合最多觸發 3 次。"
  },
  RelicConfig_13914_Desc = {
    Text = "「打擊」獲得 2 點算力，隨機棄 1 張牌；「防禦」抽 2 張牌，失去 1 點算力。每回合最多觸發 3 次。"
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:快樂唱片>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "錄下了著名小提琴家最後的演出的唱片。\n自那以後，它能帶來火焰。"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "界域推薦加成效果提升為 50%，關卡開始時你的<ProficientInRealmsIconKeywords:界域精通>翻倍。"
  },
  RelicConfig_13915_Desc = {
    Text = "界域推薦加成效果提升為 50%，關卡開始時你的<ProficientInRealmsIconKeywords:界域精通>翻倍。"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:時靈擺「入夢」>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "釋放狂氣爆發後、下一張打出的指令卡生效 2 次。"
  },
  RelicConfig_13916_Desc = {
    Text = "釋放狂氣爆發後、下一張打出的指令卡生效 2 次。"
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:時靈擺「潛遊」>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "若敵人的意圖為攻擊，造成傷害後使其 <PowerIconKeywords:力量>臨時降低 [Arg1] 點，否則附加等同於 25% 傷害的<BleedingIconKeywords:出血>，每回合最多觸發 6 次。"
  },
  RelicConfig_13917_Desc = {
    Text = "若敵人的意圖為攻擊，造成傷害後使其 <PowerIconKeywords:力量>臨時降低 [Arg1] 點，否則附加等同於 25% 傷害的<BleedingIconKeywords:出血>，每回合最多觸發 6 次。"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:異形之心>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "兩顆相依相偎的「心臟」。"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "每次造成傷害時，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，最多堆疊 3 次。層數滿時效果翻倍。"
  },
  RelicConfig_13918_Desc = {
    Text = "每次造成傷害時，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，最多堆疊 3 次。層數滿時效果翻倍。"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:纏絲瑪瑙>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "應該只是普通的瑪瑙紋路。大概。"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 50。拾取時選擇一個造物，將其更換為隨機造物。"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 50。拾取時選擇一個造物，將其更換為隨機造物。"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:萬花筒>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "所思所見皆為幻象。"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "造成的虛弱效果提高 5%。施加<WeaknessIconKeywords:虛弱>時，臨時偷取目標 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13920_Desc = {
    Text = "造成的虛弱效果提高 5%。施加<WeaknessIconKeywords:虛弱>時，臨時偷取目標 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "模糊的照片承載了模糊的記憶，亦或者——正是記憶的殘缺，才造就了照片的褪色。"
  },
  RelicConfig_13921_BattleDesc = {
    Text = "拾取時選擇 2 張指令卡牌刪除，獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13921_Desc = {
    Text = "拾取時選擇 2 張指令卡牌刪除，獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:黑星燃燒之燼>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "餘火未熄。"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "每回合釋放狂氣爆發 2 次後，所有喚醒體獲得 8 點狂氣，釋放 3 次後，所有喚醒體再獲得 8 點狂氣。"
  },
  RelicConfig_13922_Desc = {
    Text = "每回合釋放狂氣爆發 2 次後，所有喚醒體獲得 8 點狂氣，釋放 3 次後，所有喚醒體再獲得 8 點狂氣。"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:被遺忘者之血>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "日漸消融。"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點護盾。回合開始時每有 3 點剩餘護盾，獲得 1 點臨時<PowerIconKeywords:力量>和觸腕傷害。"
  },
  RelicConfig_13923_Desc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點護盾。回合開始時每有 3 點剩餘護盾，獲得 1 點臨時<PowerIconKeywords:力量>和觸腕傷害。"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:時靈擺「隱秘」>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "每當觸發<TransitionIconKeywords:躍遷>效果時，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13924_Desc = {
    Text = "每當觸發<TransitionIconKeywords:躍遷>效果時，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:空間偏折儀>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "躍入虛空。"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "回合開始時抽 1 張牌。連續 2 次打出和上一張卡牌算力相同的牌時，額外抽 1 張牌，每回合最多生效 3 次。"
  },
  RelicConfig_13925_Desc = {
    Text = "回合開始時抽 1 張牌。連續 2 次打出和上一張卡牌算力相同的牌時，額外抽 1 張牌，每回合最多生效 3 次。"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:萬象靈知秘儀>"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "戰鬥開始時，卡組中每擁有 1 個刻印，獲得 [Arg1] 點<PowerIconKeywords:力量>，每擁有 1 個造物，回復 [Arg2] 點生命。"
  },
  RelicConfig_13926_Desc = {
    Text = "戰鬥開始時，卡組中每擁有 1 個刻印，獲得 [Arg1] 點<PowerIconKeywords:力量>，每擁有 1 個造物，回復 [Arg2] 點生命。"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆商會勳章☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "「戴上它，你就是倫蒂尼恩商會的成員之一了。」"
  },
  RelicConfig_13927_BattleDesc = {
    Text = "拾取時刪除 1 張症狀卡。將 1 個隨機刻印升級為高級刻印。"
  },
  RelicConfig_13927_Desc = {
    Text = "拾取時刪除 1 張症狀卡。將 1 個隨機刻印升級為高級刻印。"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:幸運兔腳>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "對兔子來說，可就不那麼幸運了。"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "暴擊率提高 15%。每打出 1 張牌，臨時暴擊率提高 5%。"
  },
  RelicConfig_13928_Desc = {
    Text = "暴擊率提高 15%。每打出 1 張牌，臨時暴擊率提高 5%。"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:孟菲斯儀式鏡>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "「你在其中窺見了什麼？」"
  },
  RelicConfig_13929_BattleDesc = {
    Text = "每當你失去生命，就獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。若為單個回合內的第 3 次觸發，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13929_Desc = {
    Text = "每當你失去生命，就獲得 [Arg1] 層<RetaliateIconKeywords:反擊>。若為單個回合內的第 3 次觸發，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:故人的懷錶>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "肩負著懷念與感傷，向未知前進。"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "回合結束時每有 1 張手牌，對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13930_Desc = {
    Text = "回合結束時每有 1 張手牌，對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:可疑的藥膏>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "某種自製的外傷藥膏，請不要在沒有醫生指導的情況下使用。"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "拾取時獲得 [Arg1] <PowerIconKeywords:力量>。每當有<DerivativeCardKeywords_2:「胚胎」>被融合，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13931_Desc = {
    Text = "拾取時獲得 [Arg1] <PowerIconKeywords:力量>。每當有<DerivativeCardKeywords_2:「胚胎」>被融合，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:染血鵝卵石>"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "每第 3 次打出「防禦」後，獲得 [Arg1] 點護盾，對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13932_Desc = {
    Text = "每第 3 次打出「防禦」後，獲得 [Arg1] 點護盾，對應喚醒體獲得 15 狂氣。"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:緘默手套>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "它們曾沾染無數鮮血、眼淚和黴菌。"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "這是個沒有效果的周替造物6"
  },
  RelicConfig_13933_Desc = {
    Text = "這是個沒有效果的周替造物6"
  },
  RelicConfig_13933_Name = {
    Text = "日常挑戰周替造物6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "這是個沒有效果的周替造物5"
  },
  RelicConfig_13934_Desc = {
    Text = "這是個沒有效果的周替造物5"
  },
  RelicConfig_13934_Name = {
    Text = "日常挑戰周替造物5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "暴擊率提高 10%。每回合首次暴擊後使暴擊率額外提高 20%，每回合造成第 3 次暴擊後使暴擊傷害額外提高 50%。"
  },
  RelicConfig_13935_Desc = {
    Text = "暴擊率提高 10%。每回合首次暴擊後使暴擊率額外提高 20%，每回合造成第 3 次暴擊後使暴擊傷害額外提高 50%。"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:節日祝福>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "它理應為相愛之人帶來祝福。"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "這是個沒有效果的周替造物3"
  },
  RelicConfig_13936_Desc = {
    Text = "這是個沒有效果的周替造物3"
  },
  RelicConfig_13936_Name = {
    Text = "日常挑戰周替造物3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "這是個沒有效果的周替造物2"
  },
  RelicConfig_13937_Desc = {
    Text = "這是個沒有效果的周替造物2"
  },
  RelicConfig_13937_Name = {
    Text = "日常挑戰周替造物2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "這是個沒有效果的周替造物1"
  },
  RelicConfig_13938_Desc = {
    Text = "這是個沒有效果的周替造物1"
  },
  RelicConfig_13938_Name = {
    Text = "日常挑戰周替造物1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "第 3 回合開始時，本場戰鬥暴擊率 +15%，將 1 張<DerivativeCardKeywords_39:「過往回聲」>加入手中。"
  },
  RelicConfig_13939_Desc = {
    Text = "第 3 回合開始時，本場戰鬥暴擊率 +15%，將 1 張<DerivativeCardKeywords_39:「過往回聲」>加入手中。"
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:過往的貢物>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "曾被進獻之物。"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "當你擁有護盾時，該造物提供 [Arg1] 點臨時<PowerIconKeywords:力量>。在你的護盾高於當前生命時，額外提供 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13940_Desc = {
    Text = "當你擁有護盾時，該造物提供 [Arg1] 點臨時<PowerIconKeywords:力量>。在你的護盾高於當前生命時，額外提供 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:鴿羽扇>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "精緻、昂貴，只是不那麼實用。"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "「打擊」回復 [Arg1] 點生命，減少自身 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13941_Desc = {
    Text = "「打擊」回復 [Arg1] 點生命，減少自身 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:止血鉗>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "「快、快把它給我！」"
  },
  RelicConfig_13942_BattleDesc = {
    Text = "每有 1 條觸腕，回合結束時獲得 [Arg1] 點護盾，若觸腕處於靜海姿態，該效果額外獲得 50% 護盾。"
  },
  RelicConfig_13942_Desc = {
    Text = "每有 1 條觸腕，回合結束時獲得 [Arg1] 點護盾，若觸腕處於靜海姿態，該效果額外獲得 50% 護盾。"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:無名附肢>"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "回合開始時沙耶獲得 [Arg1] 狂氣。沙耶狂氣爆發每消耗 100 點狂氣，使隨機 1 張生成的「技能」額外生效 1 次。"
  },
  RelicConfig_139929_Desc = {
    Text = "回合開始時沙耶獲得 [Arg1] 狂氣。沙耶狂氣爆發每消耗 100 點狂氣，使隨機 1 張生成的「技能」額外生效 1 次。"
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:維度影像·沙耶>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:背水>：回合開始時每損失 1% 最大生命，臨時最終傷害提高 5%，若上回合觸發過死亡抵抗，該效果翻倍。 \n<RedQuality:至高>：所有敵人最大生命提高 300%。"
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:背水>：回合開始時每損失 1% 最大生命，臨時最終傷害提高 5%，若上回合觸發過死亡抵抗，該效果翻倍。 \n<RedQuality:至高>：所有敵人最大生命提高 300%。"
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:維度靈擺–死戰>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:增殖>：每回合每名喚醒體首次打出「技能」時，生成其 2 張臨時原始複製。打出算力消耗為 0 或 1 的指令卡時所有喚醒體獲得 5 點狂氣。\n<RedQuality:堡壘>：打出原始算力消耗大於等於 3 的卡牌時，所有敵人獲得 20% 最大生命的護盾。"
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:增殖>：每回合每名喚醒體首次打出「技能」時，生成其 2 張臨時原始複製。打出算力消耗為 0 或 1 的指令卡時所有喚醒體獲得 5 點狂氣。\n<RedQuality:堡壘>：打出原始算力消耗大於等於 3 的卡牌時，所有敵人獲得 20% 最大生命的護盾。"
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:維度靈擺–警戒>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:回生>：獲得的護盾和回復效果提高 25%。回復生命或獲得護盾時，每造成 1% 最大生命的回復或護盾效果，獲得 10% 臨時傷害強效。\n<RedQuality:低語>：每回合獲得等同於最大生命 10% 的力量降低效果。"
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:回生>：獲得的護盾和回復效果提高 25%。回復生命或獲得護盾時，每造成 1% 最大生命的回復或護盾效果，獲得 10% 臨時傷害強效。\n<RedQuality:低語>：每回合獲得等同於最大生命 10% 的力量降低效果。"
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:維度靈擺–威嚇>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:破曉>：所有喚醒體基礎狂氣降低30點。每回合首次釋放的狂氣爆發最終傷害提高200%，護盾、生命回復提高 100%。每釋放 5 次狂氣爆發後，選擇 1 名喚醒體覺醒，並刷新狂氣爆發增幅效果。\n<RedQuality:枯竭>：基礎銀鑰能量提高200%"
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:破曉>：所有喚醒體基礎狂氣降低30點。每回合首次釋放的狂氣爆發最終傷害提高200%，護盾、生命回復提高 100%。每釋放 5 次狂氣爆發後，選擇 1 名喚醒體覺醒，並刷新狂氣爆發增幅效果。\n<RedQuality:枯竭>：基礎銀鑰能量提高200%"
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:維度靈擺–詭咒>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:覺醒>：每回合首次釋放狂氣爆發後，重置該喚醒體狂氣爆發冷卻並使其獲得 50 狂氣，生成其算力消耗為 0 的所有「技能」的臨時複製。\n<RedQuality:封印>：每回合首次釋放狂氣爆發後，封印其他喚醒體。"
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:覺醒>：每回合首次釋放狂氣爆發後，重置該喚醒體狂氣爆發冷卻並使其獲得 50 狂氣，生成其算力消耗為 0 的所有「技能」的臨時複製。\n<RedQuality:封印>：每回合首次釋放狂氣爆發後，封印其他喚醒體。"
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:維度靈擺–決鬥>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:回響>：回合開始後抽 3 張抽牌堆中算力最高的指令卡，每回合首次打出的指令卡生效 2 次。\n<RedQuality:暈眩>：打出指令卡後棄掉所有算力消耗不低於它的其他指令卡。"
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:回響>：回合開始後抽 3 張抽牌堆中算力最高的指令卡，每回合首次打出的指令卡生效 2 次。\n<RedQuality:暈眩>：打出指令卡後棄掉所有算力消耗不低於它的其他指令卡。"
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:維度靈擺–惑亂>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:偉力>：所有喚醒體造成的<PowerIconKeywords:力量>提高 50%，每造成 1 次傷害獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。\n<RedQuality:無形>：戰鬥開始時，所有敵人獲得 50 層<ParcloseIconKeywords:屏障>。"
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:偉力>：所有喚醒體造成的<PowerIconKeywords:力量>提高 50%，每造成 1 次傷害獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。\n<RedQuality:無形>：戰鬥開始時，所有敵人獲得 50 層<ParcloseIconKeywords:屏障>。"
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:維度靈擺–潛匿>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "手牌上限 +1。戰鬥開始時生成 1 張「<DerivativeCardKeywords_148:驭魇>」置入手中。打出喚醒體的「基礎打擊」時，「<DerivativeCardKeywords_148:驭魇>」算力消耗 -1，對所有敵人造成 [Arg1] 點侵蝕。打出喚醒體的「基礎防禦」時 ，獲得  [Arg2] 點力量，下次打出「<DerivativeCardKeywords_148:驭魇>」的最終傷害效果和力量提高 [Arg3]%。"
  },
  RelicConfig_140840_Desc = {
    Text = "手牌上限 +1。戰鬥開始時生成 1 張「<DerivativeCardKeywords_148:驭魇>」置入手中。打出喚醒體的「基礎打擊」時，「<DerivativeCardKeywords_148:驭魇>」算力消耗 -1，對所有敵人造成 [Arg1] 點侵蝕。打出喚醒體的「基礎防禦」時 ，獲得  [Arg2] 點力量，下次打出「<DerivativeCardKeywords_148:驭魇>」的最終傷害效果和力量提高 [Arg3]%。"
  },
  RelicConfig_140840_Name = {
    Text = "徒勞者的掙扎"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "徒勞者恐懼變化，恐懼事物超出掌控，在最深層的地方，他歇斯底里地恐懼著失去。\n 他一次次地吹響哨子，想要通過哨音控制所有，但他沒能留住任何東西。"
  },
  RelicConfig_143665_BattleDesc = {
    Text = "回合開始時龐托斯獲得 [Arg1] 狂氣。拾取後下場戰鬥開始時，生成 3 張永久「囚魘」。打出「囚魘」時龐托斯獲得 3 點狂氣。"
  },
  RelicConfig_143665_Desc = {
    Text = "回合開始時龐托斯獲得 [Arg1] 狂氣。拾取後下場戰鬥開始時，生成 3 張永久「囚魘」。打出「囚魘」時龐托斯獲得 3 點狂氣。"
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:維度影像·龐托斯>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "回合開始時蝕滅·蘿坦獲得 [Arg1] 點狂氣，「斷界之劍」使下回合開始時釋放「冥刃追滅」追擊：對所有敵人造成 400％ 蝕滅·蘿坦攻擊力的傷害，該傷害享受本次「斷界之劍」通過「巨劍·鯨落」獲得的傷害加成，視為「打擊」。"
  },
  RelicConfig_145438_Desc = {
    Text = "回合開始時蝕滅·蘿坦獲得 [Arg1] 點狂氣，「斷界之劍」使下回合開始時釋放「冥刃追滅」追擊：對所有敵人造成 400％ 蝕滅·蘿坦攻擊力的傷害，該傷害享受本次「斷界之劍」通過「巨劍·鯨落」獲得的傷害加成，視為「打擊」。"
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:維度影像·蝕滅·蘿坦>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "手牌上限 +1。戰鬥開始時或打出「<DerivativeCardKeywords_157:劍之骨>」後將 1 張「<DerivativeCardKeywords_155:狂之骨>」置入手中，將1 張「<DerivativeCardKeywords_156:傷之骨>」洗入抽牌堆。若一回合中同時打出「<DerivativeCardKeywords_155:狂之骨>」和「<DerivativeCardKeywords_156:傷之骨>」，將這兩張牌合成為「<DerivativeCardKeywords_157:劍之骨>」置入手中。"
  },
  RelicConfig_146128_Desc = {
    Text = "手牌上限 +1。戰鬥開始時或打出「<DerivativeCardKeywords_157:劍之骨>」後將 1 張「<DerivativeCardKeywords_155:狂之骨>」置入手中，將1 張「<DerivativeCardKeywords_156:傷之骨>」洗入抽牌堆。若一回合中同時打出「<DerivativeCardKeywords_155:狂之骨>」和「<DerivativeCardKeywords_156:傷之骨>」，將這兩張牌合成為「<DerivativeCardKeywords_157:劍之骨>」置入手中。"
  },
  RelicConfig_146128_Name = {
    Text = "鯨骸之鎧"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "利維坦的骸骨庇佑著祂所選定之人，所向披靡，不死不滅。"
  },
  RelicConfig_147547_BattleDesc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_147547_Desc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:維度影像·卡茜亞>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "算力上限和每回合抽牌數 +1。回合開始時<FaxianKeywords:發現> 3 個「<Caroboo_Tips:皇家瑪麗巧克力>」並選擇其一。其中只有 1 個為真實：選中真實則獲得其正面效果並驅散自身隨機 1 種負面狀態；選中虛假則承受其負面效果並使下一次<FaxianKeywords:發現>時真實選項 +1、效果翻倍，選中真實後重置。"
  },
  RelicConfig_147665_Desc = {
    Text = "算力上限和每回合抽牌數 +1。回合開始時<FaxianKeywords:發現> 3 個「<Caroboo_Tips:皇家瑪麗巧克力>」並選擇其一。其中只有 1 個為真實：選中真實則獲得其正面效果並驅散自身隨機 1 種負面狀態；選中虛假則承受其負面效果並使下一次<FaxianKeywords:發現>時真實選項 +1、效果翻倍，選中真實後重置。"
  },
  RelicConfig_147665_Name = {
    Text = "皇家瑪麗巧克力"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "甜美而貴重……嗎？"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "回合開始時負誓·奧吉爾獲得 [Arg1] 點狂氣，「暗湧」不再減少抽牌數。"
  },
  RelicConfig_148525_Desc = {
    Text = "回合開始時負誓·奧吉爾獲得 [Arg1] 點狂氣，「暗湧」不再減少抽牌數。"
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:維度影像·負誓·奧吉爾>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "當前環境視為「冰域」。\n終北大陸：抽牌階段後對手中算力最高的 2 張未凍結的指令卡施加 1 層<SlowIconKeywords:遲緩>、<RetainIconKeywords:保留>。當任意指令卡擁有至少 3 層<SlowIconKeywords:遲緩>時，移除其<SlowIconKeywords:遲緩>和本場戰鬥施加的<RetainIconKeywords:保留>並將其「凍結」，附加 25 層<TempPowerKeywords2:強化>。"
  },
  RelicConfig_149665_Desc = {
    Text = "當前環境視為「冰域」。\n終北大陸：抽牌階段後對手中算力最高的 2 張未凍結的指令卡施加 1 層<SlowIconKeywords:遲緩>、<RetainIconKeywords:保留>。當任意指令卡擁有至少 3 層<SlowIconKeywords:遲緩>時，移除其<SlowIconKeywords:遲緩>和本場戰鬥施加的<RetainIconKeywords:保留>並將其「凍結」，附加 25 層<TempPowerKeywords2:強化>。"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "它並非帶來寒冷。\n它只是提醒大地，冬天從未離去。"
  },
  RelicConfig_20164_BattleDesc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，最多 5 層，層數滿時獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_20164_Desc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，最多 5 層，層數滿時獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:時靈擺「未眠」>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "拾取時覺醒所有喚醒體。打出<ExaltIconKeywords:靈知覺醒>後，隨機獲得 2 張該喚醒體的指令卡並附加「消耗」和「虛無」。"
  },
  RelicConfig_20165_Desc = {
    Text = "拾取時覺醒所有喚醒體。打出<ExaltIconKeywords:靈知覺醒>後，隨機獲得 2 張該喚醒體的指令卡並附加「消耗」和「虛無」。"
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:祂的神諭+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "祂說，不要懼怕。"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。將每回合打出的第 1 張牌重新置入手中。超維回合開始時，當回合手牌上限 +5 並複製你的手牌。"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。將每回合打出的第 1 張牌從棄牌堆重新置入手中。超維回合開始時，當回合手牌上限 +5 並複製你的手牌，複製的牌添加<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:時靈擺「竊夢」>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "回合結束時若有剩餘算力，下回合額外抽 2 張牌；若有剩餘手牌，下回合額外獲得 2 點算力。"
  },
  RelicConfig_20167_Desc = {
    Text = "回合結束時若有剩餘算力，下回合額外抽 2 張牌；若有剩餘手牌，下回合額外獲得 2 點算力。"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:日月輪盤+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "猜一猜，是黑還是白？"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "觸腕上限 +2。釋放狂氣爆發後，觸腕傷害 +[Arg1]。若一回合中釋放過 3 次狂氣爆發，則激發所有觸腕一次。"
  },
  RelicConfig_20168_Desc = {
    Text = "觸腕上限 +2。釋放狂氣爆發後，觸腕傷害 +[Arg1]。若一回合中釋放過 3 次狂氣爆發，則激發所有觸腕一次。"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:時靈擺「淺眠」>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 張牌<EmbryoFusionIconKeywords:胚胎融合> +10，生命低於 25% 時提高為 20，每回合最多生效 10 次。"
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 張牌<EmbryoFusionIconKeywords:胚胎融合> +10，生命低於 25% 時提高為 20，每回合最多生效 10 次。"
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:時靈擺「湧動」>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "戰鬥開始時，所有喚醒體獲得 50 點狂氣。將 2 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_20170_Desc = {
    Text = "戰鬥開始時，所有喚醒體獲得 50 點狂氣。將 2 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:通訊設備+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "期待或恐懼它發出清脆鈴聲的瞬間。"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "拾取時隨機獲得 1 個白銀造物、1 個黃金造物、1 個詛咒造物。"
  },
  RelicConfig_20171_Desc = {
    Text = "拾取時隨機獲得 1 個白銀造物、1 個黃金造物、1 個詛咒造物。"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:逆向觀賞+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "在奇異的紀元中，花朵才是人類的第一觀賞者。\n不要動彈，祂們更偏愛安靜的展品。"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "每回合打出的指令卡達到 3 張時獲得 1 張<DerivativeCardKeywords_4:「靈感」>，達到 6 張時再獲得 1 張<DerivativeCardKeywords_4:「靈感」>，達到 10 張後，下個回合開始時可從牌庫中任選 2 張卡置入手牌。"
  },
  RelicConfig_20172_Desc = {
    Text = "每回合打出的指令卡達到 3 張時獲得 1 張<DerivativeCardKeywords_4:「靈感」>，達到 6 張時再獲得 1 張<DerivativeCardKeywords_4:「靈感」>，達到 10 張後，下個回合開始時可從牌庫中任選 2 張卡置入手牌。"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:時靈擺「迴響」>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 50%，擊殺敵人後擊殺者獲得 100 狂氣。"
  },
  RelicConfig_20173_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 50%，擊殺敵人後擊殺者獲得 100 狂氣。"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:祭司權杖+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "不被許可的虔誠。"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "拾取後隊伍傷害強效變為原始值的 150%。回合開始後，對隨機敵人造成 [Arg1] 點<FixedDamage:純粹傷害>，本場戰鬥中每釋放 1 次鑰令，傷害 +[Arg2] ，該傷害提高享受隊伍傷害強效加成。"
  },
  RelicConfig_20174_Desc = {
    Text = "拾取後隊伍傷害強效變為原始值的 150%。回合開始後，對隨機敵人造成 [Arg1] 點<FixedDamage:純粹傷害>，本場戰鬥中每釋放 1 次鑰令，傷害 +[Arg2] ，該傷害提高享受隊伍傷害強效加成。"
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:時靈擺「迷失」>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "造成的<WeaknessIconKeywords:虛弱>效果提高 8%，<VulnerabilityIconKeywords:易傷>效果提高 25%。施加<WeaknessIconKeywords:虛弱>或<VulnerabilityIconKeywords:易傷>時，臨時偷取目標 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_20175_Desc = {
    Text = "造成的<WeaknessIconKeywords:虛弱>效果提高 8%，<VulnerabilityIconKeywords:易傷>效果提高 25%。施加<WeaknessIconKeywords:虛弱>或<VulnerabilityIconKeywords:易傷>時，臨時偷取目標 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "模糊的照片承載了模糊的記憶，亦或者——正是記憶的殘缺，才造就了照片的褪色。"
  },
  RelicConfig_20176_BattleDesc = {
    Text = "回合開始時每有 1 名敵人就獲得 2 算力。主動傷害擊殺敵人時，對其他敵人造成雙倍過量傷害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_20176_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 2 算力。主動傷害擊殺敵人時，對其他敵人造成雙倍過量傷害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "專為折磨你的耳朵而生。"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "拾取後死亡抵抗翻倍。造成傷害後，還會對目標施加等同於傷害 50% 的<BleedingIconKeywords:出血>。每觸發 1 次死亡抵抗，全體敵人的出血立刻觸發 1 次。"
  },
  RelicConfig_20177_Desc = {
    Text = "拾取後死亡抵抗翻倍。造成傷害後，還會對目標施加等同於傷害 50% 的<BleedingIconKeywords:出血>。每觸發 1 次死亡抵抗，全體敵人的出血立刻觸發 1 次。"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:時靈擺「復甦」>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "每造成 1 次主動傷害就獲得 3 點狂氣，並對目標施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_20178_Desc = {
    Text = "每造成 1 次主動傷害就獲得 3 點狂氣，並對目標施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:蒙塵縫紉機+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "一位慈祥的母親，縫補心臟上的傷。"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "「打擊」獲得 3 點算力，隨機棄 1 張牌；「防禦」抽 3 張牌，失去 1 點算力。"
  },
  RelicConfig_21906_Desc = {
    Text = "「打擊」獲得 3 點算力，隨機棄 1 張牌；「防禦」抽 3 張牌，失去 1 點算力。"
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:快樂唱片+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "錄下了著名小提琴家最後的演出的唱片。\n自那以後，它能帶來火焰。"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "每觸發 1 次吞噬，獲得 30 點<EmbryoFusionIconKeywords:胚胎融合>和 [Arg1] 點<PowerIconKeywords:力量>。若 1 回合中第 2 次觸發，獲得 1 點算力，抽 1 張牌，若 1 回合中第 3 次觸發，獲得 2 點算力，抽 2 張牌。"
  },
  RelicConfig_23688_Desc = {
    Text = "每觸發 1 次吞噬，獲得 30 點<EmbryoFusionIconKeywords:胚胎融合>和 [Arg1] 點<PowerIconKeywords:力量>。若 1 回合中第 2 次觸發，獲得 1 點算力，抽 1 張牌，若 1 回合中第 3 次觸發，獲得 2 點算力，抽 2 張牌。"
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:時靈擺「回噬」>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "拾取後所有喚醒體獲得 30 點狂氣。每釋放 1 次狂氣爆發增加 1 點計數。釋放鑰令後，獲得  [Arg1] 點臨時戒備、 [Arg2] 點臨時<PowerIconKeywords:力量>和所有喚醒體獲得 6 點狂氣，消耗所有計數，每點計數額外生效 1 次。"
  },
  RelicConfig_23689_Desc = {
    Text = "拾取後所有喚醒體獲得 30 點狂氣。每釋放 1 次狂氣爆發增加 1 點計數。釋放鑰令後，獲得  [Arg1] 點臨時戒備、 [Arg2] 點臨時<PowerIconKeywords:力量>和所有喚醒體獲得 6 點狂氣，消耗所有計數，每點計數額外生效 1 次。"
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:時靈擺「蓄力」>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "每額外獲得的 1 點算力或額外抽的 1 張牌，偷取所有敵人 [Arg1] 點<PowerIconKeywords:力量>，獲得 4% 臨時暴擊率，精英或首領戰效果翻倍。超維回合開始後，獲得 [Arg2] 點<PowerIconKeywords:力量>，暴擊傷害 +15%。"
  },
  RelicConfig_23690_Desc = {
    Text = "每額外獲得的 1 點算力或額外抽的 1 張牌，偷取所有敵人 [Arg1] 點<PowerIconKeywords:力量>，獲得 4% 臨時暴擊率，精英或首領戰效果翻倍。超維回合開始後，獲得 [Arg2] 點<PowerIconKeywords:力量>，暴擊傷害 +15%。"
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:時靈擺「間隙」>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "每造成 5 次傷害，回復 [Arg1] 點生命。每失去 1 次生命 ，觸腕傷害 +[Arg2]，若失去生命超過 [Arg3] 點，激發所有觸腕 1 次。"
  },
  RelicConfig_23691_Desc = {
    Text = "每造成 5 次傷害，回復 [Arg1] 點生命。每失去 1 次生命 ，觸腕傷害 +[Arg2]，若失去生命超過 10% 最大生命，激發所有觸腕 1 次。"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:時靈擺「潮湧」>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>和 [Arg2] 點臨時觸腕傷害，每回合最多觸發 12 次。若 1 回合內造成了 4 次傷害，對全體敵人施加 1 層易傷並獲得 [Arg3] 點護盾，若造成了 8 次傷害，對全體敵人施加 1 層虛弱並回復 [Arg3] 點生命。"
  },
  RelicConfig_35135_Desc = {
    Text = "每造成 1 次傷害，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>和 [Arg2] 點臨時觸腕傷害，每回合最多觸發 12 次。若 1 回合內造成了 4 次傷害，對全體敵人施加 1 層易傷並獲得 [Arg3] 點護盾，若造成了 8 次傷害，對全體敵人施加 1 層虛弱並回復 [Arg3] 點生命。"
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:時靈擺「入迷」>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "「打擊」的傷害和「防禦」獲得的護盾提高 30%，若 1 回合中打出了 4 張或以上的「打擊」和「防禦」，下個回合開始時，抽 2 張牌，獲得 1 點算力。"
  },
  RelicConfig_35136_Desc = {
    Text = "「打擊」的傷害和「防禦」獲得的護盾提高 30%，若 1 回合中打出了 4 張或以上的「打擊」和「防禦」，下個回合開始時，抽 2 張牌，獲得 1 點算力。"
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:時靈擺「執拗」>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "每打出 1 張卡牌，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>並回復 [Arg2] 點生命，造成主動傷害後移除 [Arg2] 點該造物獲得的<PowerIconKeywords:力量>。喚醒體每擊殺一個敵人，獲得 30 點狂氣。"
  },
  RelicConfig_35137_Desc = {
    Text = "每打出 1 張卡牌，獲得 [Arg1] 點臨時<PowerIconKeywords:力量>並回復 [Arg2] 點生命，造成主動傷害後移除 [Arg2] 點該造物獲得的<PowerIconKeywords:力量>。喚醒體每擊殺一個敵人，獲得 30 點狂氣。"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:時靈擺「積蓄」>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "釋放狂氣爆發後，對隨機敵人施加 [Arg1] 點中毒，每打出 1 張指令卡，獲得 [Arg2] 點臨時反擊。每 4 個回合結束時，對所有敵人造成等同於敵人中毒層數和自身反擊層數總和的傷害。"
  },
  RelicConfig_35138_Desc = {
    Text = "釋放狂氣爆發後，對隨機敵人施加 [Arg1] 點中毒，每打出 1 張指令卡，獲得 [Arg2] 點臨時反擊。每 4 個回合結束時，對所有敵人造成等同於敵人中毒層數和自身反擊層數總和的傷害。"
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:時靈擺「蔓延」>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "拾取後隊伍傷害強效增加 30%。每造成的第 4 次傷害必定暴擊，且暴擊傷害提高 50%，若該次傷害造成了擊殺，獲得 5 點黑印。"
  },
  RelicConfig_35139_Desc = {
    Text = "拾取後隊伍傷害強效增加 30%。每造成的第 4 次傷害必定暴擊，且暴擊傷害提高 50%，若該次傷害造成了擊殺，獲得 5 點黑印。"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:時靈擺「終結」>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "釋放狂氣爆發後抽 1 張牌。每棄掉 1 張卡牌，所有喚醒體獲得 3 點狂氣，每回合最多 15 點。"
  },
  RelicConfig_36823_Desc = {
    Text = "釋放狂氣爆發後抽 1 張牌。每棄掉 1 張卡牌，所有喚醒體獲得 3 點狂氣，每回合最多 15 點。"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:時靈擺「往來」>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "每次消耗算力時，抽 1 張牌，每回合至多生效 5 次。每當牌庫重置時，獲得 2 點算力。"
  },
  RelicConfig_36824_Desc = {
    Text = "每次消耗算力時，抽 1 張牌，每回合至多生效 5 次。每當牌庫重置時，獲得 2 點算力。"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:時靈擺「不眠」>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "每造成 4 次傷害，將 1 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆，每回合最多觸發 3 次。釋放狂氣爆發後，打出並消耗牌庫中所有的<DerivativeCardKeywords_4:「靈感」>。"
  },
  RelicConfig_39302_Desc = {
    Text = "每造成 4 次傷害，將 1 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆，每回合最多觸發 3 次。釋放狂氣爆發後，打出並消耗牌庫中所有的<DerivativeCardKeywords_4:「靈感」>。"
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:時靈擺「迷夢」>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "當前算力為奇數時，視為額外擁有 [Arg2] 點臨時戒備。當前算力為偶數時，視為額外擁有 [Arg1] 點臨時<PowerIconKeywords:力量>和 [Arg3] 點臨時觸腕傷害。每擁有 1 個黃金造物，該造物效果提高 50%，每擁有 1 個詛咒造物，提高 80%。"
  },
  RelicConfig_39303_Desc = {
    Text = "當前算力為奇數時，視為額外擁有 [Arg2] 點臨時戒備。當前算力為偶數時，視為額外擁有 [Arg1] 點臨時<PowerIconKeywords:力量>和 [Arg3] 點臨時觸腕傷害。每擁有 1 個黃金造物，該造物效果提高 50%，每擁有 1 個詛咒造物，提高 80%。"
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:時靈擺「驚夢」>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "每回合開始時所有喚醒體獲得 20 狂氣。拾取時最大生命降低 50%。"
  },
  RelicConfig_44192_Desc = {
    Text = "每回合開始時所有喚醒體獲得 20 狂氣。拾取時最大生命降低 50%。"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:負罪·噩夢表像>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "放縱的深眠即是欲望，會在你不知道的時候吞噬一切。"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 3 倍。"
  },
  RelicConfig_44300_Desc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 3 倍。"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:受祝·噩夢表像>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "無需恐懼，無需彷徨。這不過是轉瞬即逝的夢，父神的光依舊照耀在你身上。"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "戰鬥結束後，獲得 100 黑印和 2 張症狀卡。"
  },
  RelicConfig_44592_Desc = {
    Text = "戰鬥結束後，獲得 100 黑印和 2 張症狀卡。"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:負罪·翠玉拓印>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "遠古的罪孽鐫刻於此。"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "拾取時變形為 1 個除自身以外的隨機負罪造物，獲得 75 黑印。"
  },
  RelicConfig_44593_Desc = {
    Text = "拾取時變形為 1 個除自身以外的隨機負罪造物，獲得 75 黑印。"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:負罪·詛咒石碑>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "聽，有誰在裡面呼喚。"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "每 2 回合使所有敵人受到的主動和觸腕傷害翻倍、但在該回合中每釋放 1 次狂氣爆發、封印所有喚醒體 1 回合、自身易傷。"
  },
  RelicConfig_44594_Desc = {
    Text = "每 2 回合使所有敵人受到的主動和觸腕傷害翻倍、但在該回合中每釋放 1 次狂氣爆發、封印所有喚醒體 1 回合、自身易傷。"
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:負罪·行道之骸>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "神聖的一部分。\n與軀幹分離後，它已經被罪孽滲透。"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "每造成 1 次主動傷害，對自身施加 [Arg1] 層<BleedingIconKeywords:出血>，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44597_Desc = {
    Text = "每造成 1 次主動傷害，對自身施加 [Arg1] 層<BleedingIconKeywords:出血>，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:負罪·蟲群意識>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "纏繞、共生、集群；恐懼、未知、控制。"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "釋放狂氣爆發後，失去 12% 當前生命，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_44598_Desc = {
    Text = "釋放狂氣爆發後，失去 12% 當前生命，偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:負罪·厄運儀式鳥>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "因貪婪而死的可憐生靈，用乾癟的胸腔發出刺耳的控訴。"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "手牌上限提高 5，戰鬥開始時抽 6 張牌。回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌，但每回合抽牌數降低 2。"
  },
  RelicConfig_44603_Desc = {
    Text = "手牌上限提高 5，戰鬥開始時抽 6 張牌。回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌，但每回合抽牌數降低 2。"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:負罪·意識銘刻>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "貪婪者以他人為物，在他人的痛苦中攫取自己的享樂。"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "拾取後永久失去 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_44608_Desc = {
    Text = "拾取後永久失去 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:負罪·七鰓鰻之吻>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "它的吻會讓你沉淪——當然，沉淪的也可能是你自身。"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "最大算力提高 3。每次重置牌庫時將 2 張<DerivativeCardKeywords_9:「蹣跚」>加入抽牌堆。"
  },
  RelicConfig_44609_Desc = {
    Text = "最大算力提高 3。每次重置牌庫時將 2 張<DerivativeCardKeywords_9:「蹣跚」>加入抽牌堆。"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:負罪·黑燭>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "燃燒理智，墮入癲狂。"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "暴擊率和暴擊傷害提高 50%，每回合開始時，<FragileIconKeywords:脆弱>自身 1 回合。"
  },
  RelicConfig_44610_Desc = {
    Text = "暴擊率和暴擊傷害提高 50%，每回合開始時，<FragileIconKeywords:脆弱>自身 1 回合。"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:負罪·古怪鉤爪>"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "最大算力提高 4，每次重置牌庫時將 4 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆。"
  },
  RelicConfig_44654_Desc = {
    Text = "最大算力提高 4，每次重置牌庫時將 4 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆。"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:受祝·黑燭>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "燃燒欲望，獲得救贖。"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "造物上限+[Arg1]，「融痕」中刷新次數+1。戰鬥結束後，獲得 125 黑印，拾取時可以選擇最多 6 張症狀卡刪除。"
  },
  RelicConfig_44656_Desc = {
    Text = "造物上限+[Arg1]，「融痕」中刷新次數+1。戰鬥結束後，獲得 125 黑印，拾取時可以選擇最多 6 張症狀卡刪除。"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "父神的救贖抹去了傷痛。"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點臨時力量，並偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_44658_Desc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點臨時力量，並偷取所有敵人 [Arg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:受祝·厄運儀式鳥>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "寬恕的光籠罩在貪婪的殘骸上，死去的飛鳥得以唱出最後的歌謠。"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "每造成 1 次主動傷害，回復 [Arg1] 生命，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44659_Desc = {
    Text = "每造成 1 次主動傷害，回復 [Arg1] 生命，對傷害目標施加 [Arg2] 層<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:受祝·蟲群意識>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "纏繞、共生、集群；團結、並存、庇護。"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "手牌上限提高 5，戰鬥開始時補充手牌至上限。回合開始時額外抽 1 張牌，回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_44660_Desc = {
    Text = "手牌上限提高 5，戰鬥開始時補充手牌至上限。回合開始時額外抽 1 張牌，回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:受祝·意識銘刻>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "貪婪者將自己的過錯銘刻在心，並潛心為自己的過去贖罪。"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "每 2 回合使所有敵人受到的主動和觸腕傷害翻倍、在本回合每釋放 1 次狂氣爆發、隨機驅散 1 種負面狀態。"
  },
  RelicConfig_44662_Desc = {
    Text = "每 2 回合使所有敵人受到的主動和觸腕傷害翻倍、在本回合每釋放 1 次狂氣爆發、隨機驅散 1 種負面狀態。"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "神聖的一部分。\n縱然與軀幹分離，其足跡也已遍佈四海。"
  },
  RelicConfig_44663_BattleDesc = {
    Text = "暴擊率提高 50%，暴擊傷害提高 100%。"
  },
  RelicConfig_44663_Desc = {
    Text = "暴擊率提高 50%，暴擊傷害提高 100%。"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:受祝·古怪鉤爪>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "一切欲望已經放下。"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "拾取後永久獲得 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_44664_Desc = {
    Text = "拾取後永久獲得 [Arg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:受祝·七鰓鰻之吻>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "拒絕這沉淪的吻吧，父神的懷抱比一切黑暗溫暖。"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "「打擊」和 「防禦」額外獲得 50 點銀鑰能量。每當你打出 1 張算力消耗為 2 或以上的卡牌，抽 1 張算力消耗為 1 的牌並使其算力消耗變為 0，每回合最多生效 3 次。"
  },
  RelicConfig_47444_Desc = {
    Text = "「打擊」和 「防禦」額外獲得 50 點銀鑰能量。每當你打出 1 張算力消耗為 2 或以上的卡牌，抽 1 張算力消耗為 1 的牌並使其算力消耗變為 0，每回合最多生效 3 次。"
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:時靈擺「雙生」>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "戰鬥開始時將所有喚醒體的<ExaltIconKeywords:靈知覺醒>洗入牌庫。第 6 回合開始後，泰旖絲會每回合提供戰鬥支援。"
  },
  RelicConfig_50338_Desc = {
    Text = "戰鬥開始時將所有喚醒體的<ExaltIconKeywords:靈知覺醒>洗入牌庫。第 6 回合開始後，泰旖絲會每回合提供戰鬥支援。"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:時靈擺「情迷」>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "祂說，不要懼怕。"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "拾取後選擇一張卡牌，使其算力消耗永久變為 1。"
  },
  RelicConfig_50385_Desc = {
    Text = "拾取後選擇一張卡牌，使其算力消耗永久變為 1。"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "失去了沙漠中最珍貴的水，她的眼瞳已然枯竭。"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "戰鬥首回合開始時，將<DerivativeCardKeywords_46:「朊朊病毒」>加入手中；第 3 回合將<DerivativeCardKeywords_49:「無饜打擊」>加入手中；觸發死亡抵抗後，將<DerivativeCardKeywords_52:「復甦之繭」>加入手中。"
  },
  RelicConfig_50487_Desc = {
    Text = "戰鬥首回合開始時，將<DerivativeCardKeywords_46:「朊朊病毒」>加入手中；第 3 回合將<DerivativeCardKeywords_49:「無饜打擊」>加入手中；觸發死亡抵抗後，將<DerivativeCardKeywords_52:「復甦之繭」>加入手中。"
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:時靈擺「賜福」>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "回合結束時：狂氣最低的喚醒體獲得 35 點狂氣。若剩餘生命≥50％，獲得 [Arg1] 點<PowerIconKeywords:力量>。若剩餘生命＜50％，恢復 [Arg2] 點生命。"
  },
  RelicConfig_50488_Desc = {
    Text = "回合結束時：狂氣最低的喚醒體獲得 35 點狂氣。若當前生命不低於 50%，獲得 [Arg1] 點<PowerIconKeywords:力量>。若當前生命低於 50%，恢復 [Arg2] 點生命。"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:時靈擺「均衡」>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "暴擊率、暴傷提高100%。每造成 1 次傷害，所有喚醒體暴擊、暴傷降低 10%，至多降低 50%。每造成 1 次傷害，本回合造成的中毒和反擊提高 10%，最大提高至 50%。"
  },
  RelicConfig_50489_Desc = {
    Text = "暴擊率、暴擊傷害提高100%。每造成 1 次傷害/觸腕傷害，本回合：所有喚醒體暴擊暴傷降低 10%，至多降低 50%。造成的中毒和反擊提高 10%，至多提高 50%。"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:時靈擺「移湧」>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "每打出一張與上一張所屬喚醒體不同的指令卡，其所屬喚醒體獲得 3 點狂氣，並積攢 1 層「活性」。積攢 10 層時將所有「活性」清空，將所有喚醒體各一張算力消耗減1且具備「消耗」的隨機指令卡置入手中，每回合最多生效 1 次。"
  },
  RelicConfig_51686_Desc = {
    Text = "每打出一張與上一張所屬喚醒體不同的指令卡，其所屬喚醒體獲得 3 點狂氣，並積攢 1 層「活性」。積攢 10 層時將所有「活性」清空，將所有喚醒體各一張算力消耗減1且具備「消耗」的隨機指令卡置入手中，每回合最多生效 1 次。"
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:時靈擺「衍化」>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "非「打擊」「防禦」的指令卡打出後，若此卡牌不為衍生卡，對應喚醒體獲得 15 點狂氣，每回合最多觸發 5 次。每回合第 1 次觸發時，還會將打出的卡牌其移回手中。"
  },
  RelicConfig_51687_Desc = {
    Text = "非「打擊」「防禦」的指令卡打出後，若此卡牌不為衍生卡，對應喚醒體獲得 15 點狂氣，每回合最多觸發 5 次。每回合第 1 次觸發時，還會將打出的卡牌移回手中。"
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:時靈擺「投射」>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "拾取時，對所有指令卡添加「保留」。回合結束時，若手牌數大於等於5，隨機3張手牌算力消耗降低1，否則抽3張牌。"
  },
  RelicConfig_51688_Desc = {
    Text = "拾取時，對所有指令卡添加「保留」。回合結束時，若手牌數大於等於5，隨機3張手牌算力消耗降低1，否則抽3張牌。"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:時靈擺「溫床」>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "戰鬥開始時，將 3 張隨機症狀卡置入牌庫。回合開始時，抽 1 張牌。每打出 1 張症狀卡，獲得 2 點算力。每棄掉 1 張症狀卡，所有喚醒體獲得 5 點狂氣，每回合最多累計觸發 5 次。"
  },
  RelicConfig_51689_Desc = {
    Text = "戰鬥開始時，將 3 張隨機症狀卡置入牌庫。回合開始時，抽 1 張牌。每打出 1 張症狀卡，獲得 2 點算力。每棄掉 1 張症狀卡，所有喚醒體獲得 5 點狂氣，每回合最多累計觸發 5 次。"
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:時靈擺「疫症」>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "模擬戰標準造物7件套"
  },
  RelicConfig_55847_Desc = {
    Text = "模擬戰標準造物7件套"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆模擬戰造物☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "在奇異的紀元中，花朵才是人類的第一觀賞者。\n不要動彈，祂們更偏愛安靜的展品。"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，隨機將 1 張「意象」置入牌庫。"
  },
  RelicConfig_55874_Desc = {
    Text = "戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，隨機將 1 張「意象」置入牌庫。"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:奧爾拉的筆與墨>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "遠古的罪孽鐫刻於此。"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "手牌上限 +2，回合開始時，抽 1 張牌。戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，選擇將 1 張「意象」置入牌庫。"
  },
  RelicConfig_56355_Desc = {
    Text = "手牌上限 +2，回合開始時，抽 1 張牌。戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，選擇將 1 張「意象」置入牌庫。"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:奧爾拉的筆與墨>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "遠古的罪孽鐫刻於此。"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，選擇將 1 張「意象」置入牌庫。"
  },
  RelicConfig_56356_Desc = {
    Text = "戰鬥結束後獲得 [Arg1] 層「筆墨」，「筆墨」達到 2 層後消耗，選擇將 1 張「意象」置入牌庫。"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:奧爾拉的筆與墨>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "遠古的罪孽鐫刻於此。"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "初始擁有 2 層神母權能，第三個回合後，每個回合開始時可選擇消耗神母權能獲得不同效果或者回復神母權能。若受到致死傷害，則復活並消耗所有神母權能，每層回復 10% 生命，僅可生效 1 次。"
  },
  RelicConfig_57667_Desc = {
    Text = "初始擁有 2 層神母權能，第三個回合後，每個回合開始時可選擇消耗神母權能獲得不同效果或者回復神母權能。若受到致死傷害，則復活並消耗所有神母權能，每層回復 10% 生命，僅可生效 1 次。"
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:神母的庇護>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "所有喚醒體的暴擊率提高 15%。萊克和骰子的隨機效果最終結果提高 1。"
  },
  RelicConfig_57732_Desc = {
    Text = "所有喚醒體的暴擊率提高 15%。萊克和骰子的隨機效果最終結果提高 1。"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:高檔幸運風衣>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "它將豎起一道厚厚的障壁，將風雨和黴運擋在外面。"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "回合開始以及觸發萊克或骰子的隨機效果時，獲得 100 點銀鑰能量和 4% 暴擊傷害，最多獲得 50% 暴擊傷害，戰鬥結束時移除。"
  },
  RelicConfig_57733_Desc = {
    Text = "回合開始以及觸發萊克或骰子的隨機效果時，獲得 100 點銀鑰能量和 4% 暴擊傷害，最多獲得 50% 暴擊傷害，戰鬥結束時移除。"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:精緻大嘴紐扣>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "大嘴紐扣喜愛一切圓圓的事物，例如月亮、籌碼和新鮮的眼球。\n會在月圓之夜口吐黑霧，原因不明。"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "每當釋放鑰令，將 1 張「閃耀偏方骰子」置入手中。"
  },
  RelicConfig_57734_Desc = {
    Text = "每當釋放鑰令，將 1 張「閃耀偏方骰子」置入手中。"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:閃耀偏方骰子>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "閃閃發光的不僅是外表，還有堅韌不拔的內心。\n凝視它超過五秒鐘，你將招來@2。"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "回合開始以及觸發萊克或骰子的隨機效果時，獲得 50 點銀鑰能量和 2% 暴擊傷害，最多獲得 30% 暴擊傷害，戰鬥結束時移除。"
  },
  RelicConfig_57735_Desc = {
    Text = "回合開始以及觸發萊克或骰子的隨機效果時，獲得 50 點銀鑰能量和 2% 暴擊傷害，最多獲得 30% 暴擊傷害，戰鬥結束時移除。"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:大嘴紐扣>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "大嘴紐扣喜愛一切圓圓的事物，例如月亮、籌碼和新鮮的眼球。\n會在月圓之夜口吐黑霧，原因不明。"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "每當釋放鑰令，將 1 張「偏方骰子」置入手中。"
  },
  RelicConfig_57736_Desc = {
    Text = "每當釋放鑰令，將 1 張「偏方骰子」置入手中。"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "閃閃發光的不僅是外表，還有堅韌不拔的內心。\n凝視它超過五秒鐘，你將招來@2。"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "所有喚醒體的暴擊率提高 10%。所有萊克和骰子的隨機效果不會出現最低值。"
  },
  RelicConfig_57737_Desc = {
    Text = "所有喚醒體的暴擊率提高 10%。所有萊克和骰子的隨機效果不會出現最低值。"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:幸運風衣>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "它將豎起一道厚厚的障壁，將風雨和黴運擋在外面。"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「紅寶石胸針、纏絲瑪瑙、求救信號、厄運儀式鳥、時靈擺·入迷」。"
  },
  RelicConfig_57791_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「紅寶石胸針、纏絲瑪瑙、求救信號、厄運儀式鳥、時靈擺·入迷」。"
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「漁叉、異鄉郵票夾、阿爾卡納記錄、意識銘刻、時靈擺·積蓄」。"
  },
  RelicConfig_57792_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「漁叉、異鄉郵票夾、阿爾卡納記錄、意識銘刻、時靈擺·積蓄」。"
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「鐳射頜骨、可疑的藥膏、蒙塵縫紉機、異種喉舌、時靈擺·移湧」。"
  },
  RelicConfig_57793_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「鐳射頜骨、可疑的藥膏、蒙塵縫紉機、異種喉舌、時靈擺·移湧」。"
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「刺蕁麻背心、故人的懷錶、先賢斷章、救濟之肢、時靈擺·蔓延」。"
  },
  RelicConfig_57794_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「刺蕁麻背心、故人的懷錶、先賢斷章、救濟之肢、時靈擺·蔓延」。"
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「銹蝕柳葉刀、止血鉗、老舊拼圖、蟲群意識、時靈擺·雙生」。"
  },
  RelicConfig_57795_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「銹蝕柳葉刀、止血鉗、老舊拼圖、蟲群意識、時靈擺·雙生」。"
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「精密計時器、桂葉袖扣、無名之神的面紗、噩夢表像、時靈擺·均衡」。"
  },
  RelicConfig_57796_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「精密計時器、桂葉袖扣、無名之神的面紗、噩夢表像、時靈擺·均衡」。"
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「嶄新的錢包、彌薩格徽章、群星之酒、七鰓鰻之吻、時靈擺·眼」。"
  },
  RelicConfig_57797_Desc = {
    Text = "造物上限 +1。戰鬥開始後的前五個回合，每個回合開始時將獲得一個造物，有「嶄新的錢包、彌薩格徽章、群星之酒、七鰓鰻之吻、時靈擺·眼」。"
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:時靈擺「沉船秘寶」>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "傳說利莫里亞陷落於這片海域。 誰能忍住不去探尋沉船寶藏的秘密？"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「銹蝕柳葉刀、新式輪軸、我們的家、古怪鉤爪、時靈擺·入迷」。"
  },
  RelicConfig_58872_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「銹蝕柳葉刀、新式輪軸、我們的家、古怪鉤爪、時靈擺·入迷」。"
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:時靈擺「秘寶α」>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「甜蜜墨水、失聲唱機、群星之酒、詭術禮帽、時靈擺·移湧」。"
  },
  RelicConfig_58873_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「甜蜜墨水、失聲唱機、群星之酒、詭術禮帽、時靈擺·移湧」。"
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:時靈擺「秘寶β」>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "回合開始後獲得 1 張「萊克的幸運骰子」，骰子投出的點數 +1。回合開始時與每次投骰子後所有喚醒體獲得 4% 暴擊傷害，最多獲得 100%。"
  },
  RelicConfig_59118_Desc = {
    Text = "回合開始後獲得 1 張「萊克的幸運骰子」，骰子投出的點數 +1。回合開始時與每次投骰子後所有喚醒體獲得 4% 暴擊傷害，最多獲得 100%。"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:時靈擺「混沌饋贈」>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "遠古的罪孽鐫刻於此。"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "模擬戰標準造物7件套"
  },
  RelicConfig_59687_Desc = {
    Text = "模擬戰標準造物7件套"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆模擬戰造物☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "在奇異的紀元中，花朵才是人類的第一觀賞者。\n不要動彈，祂們更偏愛安靜的展品。"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "最大算力提高 1，回合開始時額外抽 1 張牌，將獲得 1 張「協樂的交響」。連續 3 次打出的指令卡算力相同時，所有喚醒體獲得 20 點狂氣，回合開始時和觸發後重置次數。"
  },
  RelicConfig_60723_Desc = {
    Text = "最大算力提高 1，回合開始時額外抽 1 張牌，將獲得 1 張「協樂的交響」。連續 3 次打出的指令卡算力相同時，所有喚醒體獲得 20 點狂氣，回合開始時和觸發後重置次數。"
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:樂團指揮棒>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "纖細的指揮棒，卻擁有比撬棍更強大的力量。\n\n指揮音符、指揮靈魂、指揮命運。"
  },
  RelicConfig_60724_BattleDesc = {
    Text = "戰鬥開始時，將獲得「易傷」刻印和「爆發」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60724_Desc = {
    Text = "戰鬥開始時，將獲得「易傷」刻印和「爆發」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60725_BattleDesc = {
    Text = "戰鬥開始時，將獲得「狂氣」刻印和「催化」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60725_Desc = {
    Text = "戰鬥開始時，將獲得「狂氣」刻印和「催化」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60726_BattleDesc = {
    Text = "戰鬥開始時，將獲得「虛弱」刻印和「籌算」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60726_Desc = {
    Text = "戰鬥開始時，將獲得「虛弱」刻印和「籌算」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60727_BattleDesc = {
    Text = "戰鬥開始時，將獲得「鐵壁」刻印和「妙手」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60727_Desc = {
    Text = "戰鬥開始時，將獲得「鐵壁」刻印和「妙手」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60728_BattleDesc = {
    Text = "戰鬥開始時，將獲得「孕育」刻印和「回聲」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60728_Desc = {
    Text = "戰鬥開始時，將獲得「孕育」刻印和「回聲」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60729_BattleDesc = {
    Text = "戰鬥開始時，將獲得「妙手」刻印和「靈感」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60729_Desc = {
    Text = "戰鬥開始時，將獲得「妙手」刻印和「靈感」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60730_BattleDesc = {
    Text = "戰鬥開始時，將獲得「蠻力」刻印和「衰竭」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60730_Desc = {
    Text = "戰鬥開始時，將獲得「蠻力」刻印和「衰竭」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60731_BattleDesc = {
    Text = "戰鬥開始時，將獲得 2 個「合奏」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60731_Desc = {
    Text = "戰鬥開始時，將獲得 2 個「合奏」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_60732_BattleDesc = {
    Text = "戰鬥開始時，將獲得「籌算」刻印和「鏡像」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60732_Desc = {
    Text = "戰鬥開始時，將獲得「籌算」刻印和「鏡像」刻印以及其高級刻印，選擇刻印在卡牌上。"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:時靈擺「校長寄語」>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_65376_BattleDesc = {
    Text = "初始擁有 [Arg1] 科考團人數。戰鬥開始時，將 5 張<DerivativeCardKeywords_73:猜疑>置入牌庫中中。"
  },
  RelicConfig_65376_Desc = {
    Text = "初始擁有 [Arg1] 科考團人數。戰鬥開始時，將 5 張<DerivativeCardKeywords_73:猜疑>置入牌庫中。"
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:科考團>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "彌薩格創始人的寄語縈繞在你的耳邊。\n\n願銀鑰指引前路，彌薩格的守密人。"
  },
  RelicConfig_65406_BattleDesc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_71:「閃耀的人性光輝」>。\n<D05EX_Relic:你的一切努力都是值得的，你幾乎保全了科考隊伍，倖存的人們真心實意地感激著你。>"
  },
  RelicConfig_65406_Desc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_71:「閃耀的人性光輝」>。\n<D05EX_Relic:你的一切努力都是值得的，你幾乎保全了科考隊伍，倖存的人們真心實意地感激著你。>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:救難勳章·鉑金>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "你的一切努力都是值得的，你幾乎保全了科考隊伍，倖存的人們真心實意地感激著你。"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_72:「璀璨的人性光輝」>。\n<D05EX_Relic:你創造了不可思議的奇蹟，所有人在災難過後全部存活，你是人們心中偉大的英雄，關於你的傳說或許就要流傳在雪山四周。>"
  },
  RelicConfig_65407_Desc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_72:「璀璨的人性光輝」>。\n<D05EX_Relic:你創造了不可思議的奇蹟，所有人在災難過後全部存活，你是人們心中偉大的英雄，關於你的傳說或許就要流傳在雪山四周。>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:救難勳章·鑽石>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "你創造了不可思議的奇蹟，所有人在災難過後全部存活，你是人們心中偉大的英雄，關於你的傳說或許就要流傳在雪山四周。"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_68:「暗淡的人性光輝」>。\n<D05EX_Relic:為了走出雪山，你選擇了效益優先的策略，並注視著人們一個個死去，倖存者看待你的目光中恐懼大於感激。>"
  },
  RelicConfig_65408_Desc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_68:「暗淡的人性光輝」>。\n<D05EX_Relic:為了走出雪山，你選擇了效益優先的策略，並注視著人們一個個死去，倖存者看待你的目光中恐懼大於感激。>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:救難勳章·青銅>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "為了走出雪山，你選擇了效益優先的策略，並注視著人們一個個死去，倖存者看待你的目光中恐懼大於感激。"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_69:「微明的人性光輝」>。\n<D05EX_Relic:你或許努力過了，雖然有一半的人死去，你至少救下了另一半，畢竟犧牲總是難免的。>"
  },
  RelicConfig_65409_Desc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_69:「微明的人性光輝」>。\n<D05EX_Relic:你或許努力過了，雖然有一半的人死去，你至少救下了另一半，畢竟犧牲總是難免的。>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:救難勳章·白銀>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "你或許努力過了，雖然有一半的人死去，你至少救下了另一半，畢竟犧牲總是難免的。"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_70:「人性光輝」>。\n<D05EX_Relic:你拯救了大半的人，將人們原本悲劇的命運改寫，你已經盡力了，不是嗎？>"
  },
  RelicConfig_65410_Desc = {
    Text = "回合開始時，獲得 [Arg1] 張<DerivativeCardKeywords_70:「人性光輝」>。\n<D05EX_Relic:你拯救了大半的人，將人們原本悲劇的命運改寫，你已經盡力了，不是嗎？>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:救難勳章·黃金>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "你拯救了大半的人，將人們原本悲劇的命運改寫，你已經盡力了，不是嗎？"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "戰鬥開始時洗入 3 張隨機「症狀」，打出「症狀」時獲得 [Arg1] 點力量。\n<D05EX_Relic:在你的幫助下，科考團無人生還，你冷漠地為自己謀取到了最大的利益，但這一切真的值得嗎？>"
  },
  RelicConfig_65456_Desc = {
    Text = "戰鬥開始時洗入 3 張隨機「症狀」，打出「症狀」時獲得 [Arg1] 點力量。\n<D05EX_Relic:在你的幫助下，科考團無人生還，你冷漠地為自己謀取到了最大的利益，但這一切真的值得嗎？>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:獨行者之徽>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "在你的幫助下，科考團無人生還，你為自己謀取到了最大的利益，但這一切真的值得嗎？"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「通訊設備、春之祭、祭司權杖、厄運儀式鳥、時靈擺·投射」。"
  },
  RelicConfig_65569_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「通訊設備、春之祭、祭司權杖、厄運儀式鳥、時靈擺·投射」。"
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:時靈擺「秘寶δ」>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「彌薩格徽章、醫生手提箱、原型電池、意識銘刻、時靈擺·衍化」。"
  },
  RelicConfig_65570_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「彌薩格徽章、醫生手提箱、原型電池、意識銘刻、時靈擺·衍化」。"
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:時靈擺「秘寶γ」>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「普特尼晨報、美學原理、群氓之歌、殘缺面孔、時靈擺·往來」。"
  },
  RelicConfig_66515_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。接下來 5 個回合，每回合開始時將獲得一個造物，有「普特尼晨報、美學原理、群氓之歌、殘缺面孔、時靈擺·往來」。"
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:時靈擺「秘寶ε」>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_66518_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:時靈擺「祈願β」>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_66519_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:時靈擺「祈願α」>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 1.5 倍。"
  },
  RelicConfig_67690_Desc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 1.5 倍。"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:受祝·噩夢表像β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "無需恐懼，無需彷徨。這不過是轉瞬即逝的夢，父神的光依舊照耀在你身上。"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "拾取時，獲得 3 點算力。"
  },
  RelicConfig_67788_Desc = {
    Text = "拾取時，獲得 3 點算力。"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:懷錶鏡>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "記憶凝固在往昔的時間，深埋於黑色之底。"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "拾取時，將 1 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_67789_Desc = {
    Text = "拾取時，將 1 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:通訊設備>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "期待或恐懼它發出清脆鈴聲的瞬間。"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "所有「打擊」造成的暴擊傷害提高 20%。拾取時，將 1 張<DerivativeCardKeywords_40:「美麗瞬間 」>加入手中。"
  },
  RelicConfig_67790_Desc = {
    Text = "所有「打擊」造成的暴擊傷害提高 20%。拾取時，將 1 張<DerivativeCardKeywords_40:「美麗瞬間 」>加入手中。"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:美麗瞬間>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "將須臾的美保存至永遠。"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "拾取時，對所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  RelicConfig_67791_Desc = {
    Text = "拾取時，對所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:變色拘束服>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "不止有時間能使織物變色，恐懼與痛苦亦能。"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "戰鬥開始時，所有喚醒體獲得 50 點狂氣。將 2 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_67793_Desc = {
    Text = "拾取時，所有喚醒體獲得 50 點狂氣，將 2 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:通訊設備+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "期待或恐懼它發出清脆鈴聲的瞬間。"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "手牌上限提高 5，戰鬥開始時補充手牌至上限。回合開始時額外抽 1 張牌，回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_67794_Desc = {
    Text = "手牌上限提高 5，戰鬥開始時補充手牌至上限。回合開始時額外抽 1 張牌，回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:受祝·意識銘刻β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "貪婪者將自己的過錯銘刻在心，並潛心為自己的過去贖罪。"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67818_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:「萬象門扉ε」>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67819_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:「萬象門扉ζ」>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67820_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:「萬象門扉θ」>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67821_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:「萬象門扉γ」>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67822_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:「萬象門扉α」>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67823_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:「萬象門扉η」>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67824_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:「萬象門扉δ」>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67825_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:「萬象門扉β」>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67826_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。回合開始時，隨機發現一個「造物」或「支援」，共發現五次。"
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:「萬象門扉ι」>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_84:「追憶微光-未完的蠟像」>置入手中，複製所有抽牌堆的卡牌。每回合額外抽 5 張牌，獲得 5 點算力。打出「打擊」或「防禦」後，獲得 [Arg1] 點護盾。"
  },
  RelicConfig_68651_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_84:「追憶微光-未完的蠟像」>置入手中，複製所有抽牌堆的卡牌。每回合額外抽 5 張牌，獲得 5 點算力。打出「打擊」或「防禦」後，獲得 [Arg1] 點護盾。"
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:「純銀之芯· 恐懼」>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_85:「追憶微光-畸變之心」>置入手中。回合開始時，能夠選擇任意張手牌丟棄，抽等量的牌。奇數回合獲得 [Arg1] 點臨時力量，將「<DerivativeCardKeywords_97:不竭戰意β」>置入手中。偶數回合獲得 [Arg2] 點臨時戒備，將<DerivativeCardKeywords_98:「躲藏β」>置入手中。"
  },
  RelicConfig_68652_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_85:「追憶微光-畸變之心」>置入手中。回合開始時，能夠選擇任意張手牌丟棄，抽等量的牌。奇數回合獲得 [Arg1] 點臨時力量，將「<DerivativeCardKeywords_97:不竭戰意β」>置入手中。偶數回合獲得 [Arg2] 點臨時戒備，將<DerivativeCardKeywords_98:「躲藏β」>置入手中。"
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:「純銀之芯· 刺骨」>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_83:「追憶微光-天真的回禮」>置入手中。所有喚醒體每回合能額外釋放 1 次狂氣爆發，釋放狂氣爆發後降低敵方 [Arg2] 點力量。回合開始時，所有喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_68653_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_83:「追憶微光-天真的回禮」>置入手中。所有喚醒體每回合能額外釋放 1 次狂氣爆發，釋放狂氣爆發後降低敵方 [Arg2] 點力量。回合開始時，所有喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:「純銀之芯· 悲泣」>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_88:「追憶微光-烏托邦帷幕」>置入手中，隊伍手牌上限+2，銀鑰能量存儲上限+100％。釋放鑰令後，所有喚醒體臨時暴擊率和暴擊傷害+ [Arg1] %，獲得 20％ 最大生命的護盾，抽牌直到手牌達到上限。"
  },
  RelicConfig_68654_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_88:「追憶微光-烏托邦帷幕」>置入手中，隊伍手牌上限+2，銀鑰能量存儲上限+100％。釋放鑰令後，所有喚醒體臨時暴擊率和暴擊傷害+ [Arg1] %，獲得 20％ 最大生命的護盾，抽牌直到手牌達到上限。"
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:「純銀之芯· 瘋狂」>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_89:「追憶微光-豐穰之核」>置入手中。回合結束時，保留剩餘算力且不再棄置手牌。每造成 1 次主動傷害，就獲得 [Arg1] 點臨時力量和 [Arg2] 點護盾。"
  },
  RelicConfig_68655_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_89:「追憶微光-豐穰之核」>置入手中。回合結束時，保留剩餘算力且不再棄置手牌。每造成 1 次主動傷害，就獲得 [Arg1] 點臨時力量和 [Arg2] 點護盾。"
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:「純銀之芯· 誕臨」>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_86:「追憶微光-蜂蜜甜酒」>置入手中，所有喚醒體暴擊傷害變為 1.5 倍。回合結束時未釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。若打出卡牌數小於 [Arg2] ，下回合抽 2 張牌，獲得 2 點算力。"
  },
  RelicConfig_68656_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_86:「追憶微光-蜂蜜甜酒」>置入手中，所有喚醒體暴擊傷害變為 1.5 倍。回合結束時未釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。若打出卡牌數小於 [Arg2] ，下回合抽 2 張牌，獲得 2 點算力。"
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:「純銀之芯· 詭譎」>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_87:「追憶微光—代行者的裁決」>置入手中，隊伍傷害強效翻倍。玩家造成的虛弱效果由 25% 提高為 50%，每回合結束時獲得最大生命值 [Arg1]％ 的護盾並對所有敵人造成等同於自身 [Arg2] 倍護盾的<FixedDamage:純粹傷害>。"
  },
  RelicConfig_68657_Desc = {
    Text = "戰鬥開始時覺醒所有喚醒體，將<DerivativeCardKeywords_87:「追憶微光—代行者的裁決」>置入手中，隊伍傷害強效翻倍。玩家造成的虛弱效果由 25% 提高為 50%，每回合結束時獲得最大生命值 [Arg1]％ 的護盾並對所有敵人造成等同於自身 [Arg2] 倍護盾的<FixedDamage:純粹傷害>。"
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:「純銀之芯· 邪信」>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "塔薇造成的傷害、治療、護盾提高 50％。戰鬥開始時塔薇獲得 120 點狂氣。"
  },
  RelicConfig_68886_Desc = {
    Text = "塔薇造成的傷害、護盾、生命回復提高 50％。戰鬥開始時塔薇獲得 120 點狂氣。"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "自門扉而出，祂踏上唯一正確的道路。"
  },
  RelicConfig_69319_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69319_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:時靈擺「祈願ε」>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69320_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:時靈擺「祈願γ」>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69321_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，發現一個造物，共發現五次。"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:時靈擺「祈願δ」>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "回合開始時，積攢 1 點「深淵源能」，選擇「沉眠」或「甦醒」。沉眠：額外積攢 1 點「深淵源能」。甦醒：消耗 1/5/10 點「深淵源能」，獲得圖魯的援助。消耗的「深淵源能」越多，圖魯的援助效果越強。"
  },
  RelicConfig_70042_Desc = {
    Text = "回合開始時，積攢 1 點「深淵源能」，選擇「沉眠」或「甦醒」。沉眠：額外積攢 1 點「深淵源能」。甦醒：消耗 1/5/10 點「深淵源能」，獲得圖魯的援助。消耗的「深淵源能」越多，圖魯的援助效果越強。"
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:神王的權能>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "戰鬥開始時，將所有喚醒體的「靈知覺醒」洗入抽牌堆。"
  },
  RelicConfig_70084_Desc = {
    Text = "戰鬥開始時，將所有喚醒體的「靈知覺醒」洗入抽牌堆。"
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:靈知覺醒>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。"
  },
  RelicConfig_70700_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。"
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:哭泣煙斗>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "這究竟是仇恨的產物，還是復仇的結果？"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "回合開始時所有喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70701_Desc = {
    Text = "回合開始時所有喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:原型電池>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "可擕式的希望。"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70702_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:重鎖+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "厚實而且堅固的鎖，如果沒有鑰匙，想必很難開啟。\n當然，這對某個神偷來說不值一提。"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "「打擊」額外造成 1 次 [Arg1]% 喚醒體攻擊力的傷害，每回合至多觸發 3 次。"
  },
  RelicConfig_70703_Desc = {
    Text = "「打擊」額外造成 1 次 [Arg1]% 喚醒體攻擊力的傷害，每回合至多觸發 3 次。"
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:銹蝕柳葉刀>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "不適宜用於割開活體。"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70704_Desc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:可疑的藥膏+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "某種自製的外傷藥膏，請不要在沒有醫生指導的情況下使用。"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "「打擊」施加造成傷害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 點。"
  },
  RelicConfig_70705_Desc = {
    Text = "「打擊」施加造成傷害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 點。"
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:異種喉舌+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "祂不是惡魔，但祂確實會傳遞人世之外的低語。"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自動獲得量提高 [Arg1]%。"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自動獲得量提高 [Arg1]%。"
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:瘟疫診斷書>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "瘟疫——大自然無意識煩躁的偶然表現。"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 [Arg1] 狂氣和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70707_Desc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 [Arg1] 狂氣和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:桂葉袖扣+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "印刻了桂葉花紋的銀質袖扣。\n它做工精緻，閃閃發亮，曾經承載了兩個孩子的友誼。"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<IntoxicationIconKeywords:中毒>與造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70708_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<IntoxicationIconKeywords:中毒>與造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:蒙塵縫紉機+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "一位慈祥的母親，縫補心臟上的傷。"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "進入超維回合後，第一張打出的非衍生指令卡額外生效 [Arg1] 次。"
  },
  RelicConfig_70709_Desc = {
    Text = "進入超維回合後，第一張打出的非衍生指令卡額外生效 [Arg1] 次。"
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:輝光沙漏>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "一份可計量的時間。"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <RetaliateIconKeywords:反擊>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70711_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <RetaliateIconKeywords:反擊>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:先賢斷章+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "「人類何其愚蠢，只因陳腐，便會盲信。」"
  },
  RelicConfig_70712_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70712_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:我們的家>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "他們之前在一起，之後也會永遠在一起。他們是相親相愛的一家人。"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_70713_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:銹蝕鋼鋸>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "解剖醫生一生都看不到美麗的女人，只有一麻袋骨頭、因疾病發炎的神經、肌肉和組織。"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<RetaliateIconKeywords:反擊>與造物造成的<RetaliateIconKeywords:反擊>提高 [Arg2]%。"
  },
  RelicConfig_70714_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<RetaliateIconKeywords:反擊>與造物造成的<RetaliateIconKeywords:反擊>提高 [Arg2]%。"
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:知無不言>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "它傳遞了無數主動或被動說出的秘密。"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "使用銀鑰覺醒後抽 [Arg1] 張牌並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70715_Desc = {
    Text = "使用銀鑰覺醒後抽 [Arg1] 張牌並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:嶄新的錢包+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "印刻了彌薩格大學校徽的皮質錢包。\n裡面現在空空如也，什麼也沒有。"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "回合開始時抽 [Arg1] 張牌。"
  },
  RelicConfig_70717_Desc = {
    Text = "回合開始時抽 [Arg1] 張牌。"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:定向羅盤+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "指示的並非方向，僅是磁場。"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "釋放「狂氣爆發」後，使所有敵人受到 [Arg1] 點<FixedDamage:純粹傷害>，並觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70718_Desc = {
    Text = "釋放「狂氣爆發」後，使所有敵人受到 1 次 [Arg2]% 我方最大生命值的<FixedDamage:純粹傷害>，並觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:鐳射頜骨>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "陳列在某個收藏家俬人展廳內的遺骨。\n收藏家醉心於那美麗的螢光，日夜欣賞，最終枯死，最終成為了它的同類。"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "回合開始時所有喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70719_Desc = {
    Text = "回合開始時所有喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:原型電池+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "可擕式的希望。"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70720_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:無上榮寵>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "優雅、神秘的黑色短毛貓，據說在某個遠方的沙漠國度被視作神明的化身。可那位神祇的名諱，如今已無人知曉。\n被崇拜，被敬仰，被遺忘，或許是為神明的宿命。"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "在一回合釋放 4 次「狂氣爆發」後，獲得 [Arg1] 算力，3 回合冷卻。"
  },
  RelicConfig_70721_Desc = {
    Text = "在一回合釋放 4 次「狂氣爆發」後，獲得 [Arg1] 算力，3 回合冷卻。"
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:銀白差分機>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "「它改變了歷史。」"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70722_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:我們的家+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "他們之前在一起，之後也會永遠在一起。他們是相親相愛的一家人。"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 [Arg1] <RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70723_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 [Arg1] <RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:阿爾卡納記錄+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "命運的走勢。"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70724_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:紅寶石胸針+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "隱約滲出鮮紅。"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70725_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:惡童+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "脫胎於純粹的惡，即使這並非它所願。"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "湮滅獲得 [Arg1] 護盾，3 回合冷卻。"
  },
  RelicConfig_70726_Desc = {
    Text = "湮滅獲得 [Arg1] 護盾，3 回合冷卻。"
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:超弦懷錶>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "「哎呀，懷錶停了。」"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_70727_Desc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:恩賜之血+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "它甘甜醇美，散發著薔薇花香。"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "使用靜海姿態令所有敵人失去 [Arg1] 點臨時<ExhaustionIconKeywords:力量>，3 回合冷卻。"
  },
  RelicConfig_70728_Desc = {
    Text = "使用靜海姿態令所有敵人失去 [Arg1] 點臨時<ExhaustionIconKeywords:力量>，3 回合冷卻。"
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:無名附肢+>"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70730_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:紅寶石胸針>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "隱約滲出鮮紅。"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "受到敵人攻擊時使其受到 [Arg1] 點<FixedDamage:純粹傷害>，這個傷害享受 [Arg2]%<RetaliateIconKeywords:反擊>加成，每個敵人每回合最多觸發 1 次。"
  },
  RelicConfig_70731_Desc = {
    Text = "受到敵人攻擊時使其受到 [Arg3]% 我方最大生命值的<FixedDamage:純粹傷害>，這個傷害享受 [Arg2]%<RetaliateIconKeywords:反擊>加成，每個敵人每回合最多觸發 1 次。"
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:遺落的祭祀刀+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "刃面彎曲的匕首，常用於祭祀儀式。"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "進入超維回合後，第一張打出的非衍生指令卡額外生效 [Arg1] 次。"
  },
  RelicConfig_70732_Desc = {
    Text = "進入超維回合後，第一張打出的非衍生指令卡額外生效 [Arg1] 次。"
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:輝光沙漏+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "一份可計量的時間。"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自動獲得量提高 [Arg1]%。"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自動獲得量提高 [Arg1]%。"
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:瘟疫診斷書+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "瘟疫——大自然無意識煩躁的偶然表現。"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "使用銀鑰覺醒後使所有喚醒體造成的基礎傷害提高 [Arg1]%並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70734_Desc = {
    Text = "使用銀鑰覺醒後使所有喚醒體造成的基礎傷害提高 [Arg1]%並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:秘典星象儀>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "宇宙的奧妙。"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多觸發 3 次。"
  },
  RelicConfig_70735_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多觸發 3 次。"
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:阿爾卡納遺物+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "命運的終焉。"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "使用靜海姿態令所有敵人失去 [Arg1] 點臨時<ExhaustionIconKeywords:力量>，3 回合冷卻。"
  },
  RelicConfig_70736_Desc = {
    Text = "使用靜海姿態令所有敵人失去 [Arg1] 點臨時<ExhaustionIconKeywords:力量>，3 回合冷卻。"
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:無名附肢>"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "打出卡牌後，若手牌數小於等於 [Arg1] ，抽 [Arg2] 張牌，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_70737_Desc = {
    Text = "打出卡牌後，若手牌數小於等於 [Arg1] ，抽 [Arg2] 張牌，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:魔術手套>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "「別害怕，這只是魔術。」"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_70738_Desc = {
    Text = "回合結束時回復 [Heal:Arg1] 生命。"
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:恩賜之血>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "它甘甜醇美，散發著薔薇花香。"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 護盾和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70739_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 護盾和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:蝴蝶標本>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "至今，他也被誰深深地喜愛著。"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "使用銀鑰覺醒後使所有喚醒體造成的基礎傷害提高 [Arg1]%並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70740_Desc = {
    Text = "使用銀鑰覺醒後使所有喚醒體造成的基礎傷害提高 [Arg1]%並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:秘典星象儀+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "宇宙的奧妙。"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "抽搐也是活性的一種。"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "戰鬥開始時，觸腕上限+[Arg1]，獲得 [Arg2] 條觸腕。"
  },
  RelicConfig_70742_Desc = {
    Text = "戰鬥開始時，觸腕上限+[Arg1]，獲得 [Arg2] 條觸腕。"
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:海眷歌謠>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "據說織紋螺等不可食用動物吸收了海洋大約80%的營養。"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70743_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:金色夢鄉>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "蛻變之日即是你的死期。"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "打出非衍生指令卡後，將算力消耗降低 2 的該卡牌 [Arg1]  張臨時複製洗入抽牌堆，3 回合冷卻。"
  },
  RelicConfig_70744_Desc = {
    Text = "打出非衍生指令卡後，將算力消耗降低 2 的該卡牌 [Arg1]  張臨時複製洗入抽牌堆，3 回合冷卻。"
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:失聲唱機+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "他的聲音消失在了風中。"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] <RetaliateIconKeywords:反擊>，首領戰效果翻倍。"
  },
  RelicConfig_70745_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <RetaliateIconKeywords:反擊>，首領戰效果翻倍。"
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:刺蕁麻背心+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "無法分辨沾染的液體。"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70746_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:無上榮寵+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "優雅、神秘的黑色短毛貓，據說在某個遠方的沙漠國度被視作神明的化身。可那位神祇的名諱，如今已無人知曉。\n被崇拜，被敬仰，被遺忘，或許是為神明的宿命。"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "打出卡牌後，若手牌數小於等於 [Arg1] ，抽 [Arg2] 張牌，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_70747_Desc = {
    Text = "打出卡牌後，若手牌數小於等於 [Arg1] ，抽 [Arg2] 張牌，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:魔術手套+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "「別害怕，這只是魔術。」"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 護盾和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70748_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 護盾和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:蝴蝶標本+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "至今，他也被誰深深地喜愛著。"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "每當一張卡進入超維空間時，若這張卡與其他超維空間的卡牌歸屬者不同，則將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  RelicConfig_70749_Desc = {
    Text = "每當一張卡進入超維空間時，若這張卡與其他超維空間的卡牌歸屬者不同，則將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "不同於無常的命運，群星自有運行法則。"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 [Arg1] <RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70750_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 [Arg1] <RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:阿爾卡納記錄>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "命運的走勢。"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 算力和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70751_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 算力和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:彌薩格徽章>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "彌薩格大學分發給調查員的徽章。它不僅象徵了佩戴者的身分，還是一個可以進行遠端通訊的工具。"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <RetaliateIconKeywords:反擊>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70752_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] <RetaliateIconKeywords:反擊>和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:先賢斷章>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "「人類何其愚蠢，只因陳腐，便會盲信。」"
  },
  RelicConfig_70753_BattleDesc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70753_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "在夜的歡笑聲中，獨木舟的剪影在湖面上自如地滑動。"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70754_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:染血鵝卵石>"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_70755_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:纏絲瑪瑙+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "應該只是普通的瑪瑙紋路。大概。"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 算力和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70756_Desc = {
    Text = "使用銀鑰覺醒後獲得 [Arg1] 算力和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:彌薩格徽章+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "彌薩格大學分發給調查員的徽章。它不僅象徵了佩戴者的身分，還是一個可以進行遠端通訊的工具。"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "使用怒濤姿態立即激發所有觸腕攻擊敵人 [Arg1] 次，3 回合冷卻。"
  },
  RelicConfig_70757_Desc = {
    Text = "使用怒濤姿態立即激發所有觸腕攻擊敵人 [Arg1] 次，3 回合冷卻。"
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:螺湮的歡愉>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "長眠之主，候汝入夢。"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多觸發 3 次。"
  },
  RelicConfig_70758_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多觸發 3 次。"
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:阿爾卡納遺物>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "命運的終焉。"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70759_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:惡童>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "脫胎於純粹的惡，即使這並非它所願。"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "戰鬥開始時對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首領戰效果翻倍。"
  },
  RelicConfig_70760_Desc = {
    Text = "戰鬥開始時對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首領戰效果翻倍。"
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:神經毒素>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "提取，淬煉。"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70761_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>，首領戰效果翻倍。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "在夜的歡笑聲中，獨木舟的剪影在湖面上自如地滑動。"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "在一回合釋放 4 次「狂氣爆發」後，獲得 [Arg1] 算力，3 回合冷卻。"
  },
  RelicConfig_70762_Desc = {
    Text = "在一回合釋放 4 次「狂氣爆發」後，獲得 [Arg1] 算力，3 回合冷卻。"
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:銀白差分機+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "「它改變了歷史。」"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70763_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:重鎖>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "厚實而且堅固的鎖，如果沒有鑰匙，想必很難開啟。\n當然，這對某個神偷來說不值一提。"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "受到敵人攻擊時使其受到 [Arg1] 點<FixedDamage:純粹傷害>，這個傷害享受 [Arg2]%<RetaliateIconKeywords:反擊>加成，每個敵人每回合最多觸發 1 次。"
  },
  RelicConfig_70764_Desc = {
    Text = "受到敵人攻擊時使其受到 [Arg3]% 我方最大生命值的<FixedDamage:純粹傷害>，這個傷害享受 [Arg2]%<RetaliateIconKeywords:反擊>加成，每個敵人每回合最多觸發 1 次。"
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:遺落的祭祀刀>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "刃面彎曲的匕首，常用於祭祀儀式。"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_70765_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:纏絲瑪瑙>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "應該只是普通的瑪瑙紋路。大概。"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1]  護盾。"
  },
  RelicConfig_70766_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1]  護盾。"
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:守護之手>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "祈福的手，堅定的拳。"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "湮滅使狂氣最低的喚醒體獲得 [Arg1] 狂氣，3 回合冷卻。"
  },
  RelicConfig_70767_Desc = {
    Text = "湮滅使狂氣最低的喚醒體獲得 [Arg1] 狂氣，3 回合冷卻。"
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:時間之蟲>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "一塊同時存在於鐘錶店與昆蟲博物館的懷錶。\n洪積元年開始後，被納入大學館藏。"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<RetaliateIconKeywords:反擊>與造物造成的<RetaliateIconKeywords:反擊>提高 [Arg2]%。"
  },
  RelicConfig_70768_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<RetaliateIconKeywords:反擊>與造物造成的<RetaliateIconKeywords:反擊>提高 [Arg2]%。"
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:知無不言+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "它傳遞了無數主動或被動說出的秘密。"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70769_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:染血鵝卵石+>"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "回合開始時抽 [Arg1] 張牌。"
  },
  RelicConfig_70770_Desc = {
    Text = "回合開始時抽 [Arg1] 張牌。"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:定向羅盤>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "指示的並非方向，僅是磁場。"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "「打擊」額外造成 2 次 [Arg1]% 喚醒體攻擊力的傷害，每回合至多觸發 3 次。"
  },
  RelicConfig_70771_Desc = {
    Text = "「打擊」額外造成 2 次 [Arg1]% 喚醒體攻擊力的傷害，每回合至多觸發 3 次。"
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:銹蝕柳葉刀+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "不適宜用於割開活體。"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "使用銀鑰覺醒後抽 [Arg1] 張牌並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70772_Desc = {
    Text = "使用銀鑰覺醒後抽 [Arg1] 張牌並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:嶄新的錢包>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "印刻了彌薩格大學校徽的皮質錢包。\n裡面現在空空如也，什麼也沒有。"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "每回合前五次造成的傷害提高 [Arg1]%。"
  },
  RelicConfig_70774_Desc = {
    Text = "每回合前五次造成的傷害提高 [Arg1]%。"
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:視力矯正器>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "曾有人透過它，找到了真相。"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] <RetaliateIconKeywords:反擊>，首領戰效果翻倍。"
  },
  RelicConfig_70776_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <RetaliateIconKeywords:反擊>，首領戰效果翻倍。"
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:刺蕁麻背心>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "無法分辨沾染的液體。"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "在一回合內打出 4 張歸屬於不同喚醒體的指令卡後，所有喚醒體獲得 [Arg1]  狂氣，3 回合冷卻。"
  },
  RelicConfig_70777_Desc = {
    Text = "在一回合內打出 4 張歸屬於不同喚醒體的指令卡後，所有喚醒體獲得 [Arg1]  狂氣，3 回合冷卻。"
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:無名之神的面紗>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "不可直視神。"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "戰鬥開始時對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首領戰效果翻倍。"
  },
  RelicConfig_70778_Desc = {
    Text = "戰鬥開始時對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首領戰效果翻倍。"
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:神經毒素+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "提取，淬煉。"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70779_Desc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 [Arg1] <IntoxicationIconKeywords:中毒>並獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:可疑的藥膏>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "某種自製的外傷藥膏，請不要在沒有醫生指導的情況下使用。"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "「打擊」施加造成傷害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 點。"
  },
  RelicConfig_70780_Desc = {
    Text = "「打擊」施加造成傷害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 點。"
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:異種喉舌>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "祂不是惡魔，但祂確實會傳遞人世之外的低語。"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1]  護盾。"
  },
  RelicConfig_70781_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 [Arg1]  護盾。"
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:守護之手+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "祈福的手，堅定的拳。"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_70782_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:銹蝕鋼鋸+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "解剖醫生一生都看不到美麗的女人，只有一麻袋骨頭、因疾病發炎的神經、肌肉和組織。"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "每回合前五次造成的傷害提高 [Arg1]%。"
  },
  RelicConfig_70783_Desc = {
    Text = "每回合前五次造成的傷害提高 [Arg1]%。"
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:視力矯正器+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "曾有人透過它，找到了真相。"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "每當一張卡進入超維空間時，若這張卡與其他超維空間的卡牌歸屬者不同，則將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  RelicConfig_70784_Desc = {
    Text = "每當一張卡進入超維空間時，若這張卡與其他超維空間的卡牌歸屬者不同，則將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "不同於無常的命運，群星自有運行法則。"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "在一回合內打出 4 張歸屬於不同喚醒體的指令卡後，所有喚醒體獲得 [Arg1]  狂氣，3 回合冷卻。"
  },
  RelicConfig_70785_Desc = {
    Text = "在一回合內打出 4 張歸屬於不同喚醒體的指令卡後，所有喚醒體獲得 [Arg1]  狂氣，3 回合冷卻。"
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:無名之神的面紗+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "不可直視神。"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "回合結束時，如果處於潮湧姿態，獲得 [Arg1] <TentacleInjurieIconKeywords:觸腕傷害>，3 回合冷卻。"
  },
  RelicConfig_70786_Desc = {
    Text = "回合結束時，如果處於潮湧姿態，獲得 [Arg1] <TentacleInjurieIconKeywords:觸腕傷害>，3 回合冷卻。"
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:裂頭蚴>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "只要我們的大腦仍是個謎，那麼裡面長滿觸腕也沒什麼好大驚小怪的。"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。"
  },
  RelicConfig_70787_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。"
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:哭泣煙斗+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "這究竟是仇恨的產物，還是復仇的結果？"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 [Arg1] 狂氣和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70788_Desc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 [Arg1] 狂氣和 [Arg2] 銀鑰能量。"
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:桂葉袖扣>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "印刻了桂葉花紋的銀質袖扣。\n它做工精緻，閃閃發亮，曾經承載了兩個孩子的友誼。"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<IntoxicationIconKeywords:中毒>與造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70789_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有喚醒體造成的<IntoxicationIconKeywords:中毒>與造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:蒙塵縫紉機>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "一位慈祥的母親，縫補心臟上的傷。"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "湮滅使狂氣最低的喚醒體獲得 [Arg1] 狂氣，3 回合冷卻。"
  },
  RelicConfig_70790_Desc = {
    Text = "湮滅使狂氣最低的喚醒體獲得 [Arg1] 狂氣，3 回合冷卻。"
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:時間之蟲+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "一塊同時存在於鐘錶店與昆蟲博物館的懷錶。\n洪積元年開始後，被納入大學館藏。"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "戰鬥開始時，觸腕上限+[Arg1]，獲得 [Arg2] 條觸腕。"
  },
  RelicConfig_70791_Desc = {
    Text = "戰鬥開始時，觸腕上限+[Arg1]，獲得 [Arg2] 條觸腕。"
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:海眷歌謠+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "據說織紋螺等不可食用動物吸收了海洋大約80%的營養。"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "回合結束時，如果處於潮湧姿態，獲得 [Arg1] <TentacleInjurieIconKeywords:觸腕傷害>，3 回合冷卻。"
  },
  RelicConfig_70792_Desc = {
    Text = "回合結束時，如果處於潮湧姿態，獲得 [Arg1] <TentacleInjurieIconKeywords:觸腕傷害>，3 回合冷卻。"
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:裂頭蚴+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "只要我們的大腦仍是個謎，那麼裡面長滿觸腕也沒什麼好大驚小怪的。"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70793_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:金色夢鄉+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "蛻變之日即是你的死期。"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "湮滅獲得 [Arg1] 護盾，3 回合冷卻。"
  },
  RelicConfig_70794_Desc = {
    Text = "湮滅獲得 [Arg1] 護盾，3 回合冷卻。"
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:超弦懷錶+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "「哎呀，懷錶停了。」"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "打出非衍生指令卡後，將算力消耗降低 2 的該卡牌 [Arg1]  張臨時複製洗入抽牌堆，3 回合冷卻。"
  },
  RelicConfig_70795_Desc = {
    Text = "打出非衍生指令卡後，將算力消耗降低 2 的該卡牌 [Arg1]  張臨時複製洗入抽牌堆，3 回合冷卻。"
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:失聲唱機>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "他的聲音消失在了風中。"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "釋放「狂氣爆發」後，使所有敵人受到 [Arg1] 點<FixedDamage:純粹傷害>，並觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70796_Desc = {
    Text = "釋放「狂氣爆發」後，使所有敵人受到 1 次 [Arg2]% 我方最大生命值的<FixedDamage:純粹傷害>，並觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:鐳射頜骨+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "陳列在某個收藏家俬人展廳內的遺骨。\n收藏家醉心於那美麗的螢光，日夜欣賞，最終枯死，最終成為了它的同類。"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "抽搐也是活性的一種。"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "使用怒濤姿態立即激發所有觸腕攻擊敵人 [Arg1] 次，3 回合冷卻。"
  },
  RelicConfig_70798_Desc = {
    Text = "使用怒濤姿態立即激發所有觸腕攻擊敵人 [Arg1] 次，3 回合冷卻。"
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:螺湮的歡愉+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "長眠之主，候汝入夢。"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "防禦獲得 [Arg1] 臨時<RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70799_Desc = {
    Text = "防禦獲得 [Arg1] 臨時<RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:故人的懷錶+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "肩負著懷念與感傷，向未知前進。"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "防禦獲得 [Arg1] 臨時<RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70800_Desc = {
    Text = "防禦獲得 [Arg1] 臨時<RetaliateIconKeywords:反擊>，每回合至多觸發 3 次。"
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:故人的懷錶>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "肩負著懷念與感傷，向未知前進。"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，從 2 個造物中選擇 1 個獲得，持續 5 個奇數回合。"
  },
  RelicConfig_70986_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，從 2 個造物中選擇 1 個獲得，持續 5 個奇數回合。"
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:時靈擺「祈願η」>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，從 2 個造物中選擇 1 個獲得，持續 5 個奇數回合。"
  },
  RelicConfig_70987_Desc = {
    Text = "戰鬥開始時，算力上限+1，覺醒所有喚醒體。奇數回合開始時，從 2 個造物中選擇 1 個獲得，持續 5 個奇數回合。"
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:時靈擺「祈願ζ」>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "回合開始時環行·拉蒙娜獲得 [Arg1] 狂氣。每回合首次觸發「回環」時，獲得 [Arg2] 點銀鑰能量和 [Arg3] 層「負熵」。"
  },
  RelicConfig_71195_Desc = {
    Text = "回合開始時環行·拉蒙娜獲得 [Arg1] 狂氣。每回合首次觸發「回環」時，獲得 [Arg2] 點銀鑰能量和 [Arg3] 層「負熵」。"
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:維度影像·環行·拉蒙娜>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "回合開始時蘿坦獲得 [Arg1] 狂氣。每回合首次打出蘿坦的「防禦」後，將 [Arg2] 張附加消耗與虛無的「桀驁之刃」置入手中。"
  },
  RelicConfig_71196_Desc = {
    Text = "回合開始時蘿坦獲得 [Arg1] 狂氣。每回合首次打出蘿坦的「防禦」後，將 [Arg2] 張附加消耗與虛無的「桀驁之刃」置入手中。"
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:維度影像·蘿坦>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "回合開始時拉蒙娜獲得 [Arg1] 狂氣。每第 [Arg2] 張打出拉蒙娜的指令卡時，該指令卡額外生效 1 次並獲得 [Arg3] 點銀鑰能量。"
  },
  RelicConfig_71197_Desc = {
    Text = "回合開始時拉蒙娜獲得 [Arg1] 狂氣。每第 [Arg2] 張打出拉蒙娜的指令卡時，該指令卡額外生效 1 次並獲得 [Arg3] 點銀鑰能量。"
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:維度影像·拉蒙娜>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "回合開始時雷婭獲得 [Arg1] 狂氣。每當失去生命後獲得 [Arg2] 點力量，每場戰鬥最多疊加 [Arg3] 次。疊加 [Arg3] 次後，「苦痛與歡愉」基礎算力消耗降低 2，傷害次數提高 1。"
  },
  RelicConfig_71230_Desc = {
    Text = "回合開始時雷婭獲得 [Arg1] 狂氣。每當失去生命後獲得 [Arg2] 點力量，每場戰鬥最多疊加 [Arg3] 次。疊加 [Arg3] 次後，「苦痛與歡愉」基礎算力消耗降低 2，傷害次數提高 1。"
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:維度影像·雷婭>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "回合開始時奧瑞塔獲得 [Arg1] 狂氣。「腺體分裂」傷害次數提高 [Arg2]，打出奧瑞塔的「防禦」後將 1 張「腺體分裂」置入手中。"
  },
  RelicConfig_71231_Desc = {
    Text = "回合開始時奧瑞塔獲得 [Arg1] 狂氣。「腺體分裂」傷害次數提高 [Arg2]，打出奧瑞塔的「防禦」後將 1 張「腺體分裂」置入手中。"
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:維度影像·奧瑞塔>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "回合開始時汀克特獲得 [Arg1] 狂氣。汀克特的指令卡觸發躍遷後將其返回手中並使其打出前算力消耗 -1，每回合最多生效 [Arg2] 次。"
  },
  RelicConfig_71232_Desc = {
    Text = "回合開始時汀克特獲得 [Arg1] 狂氣。汀克特的指令卡觸發躍遷後將其返回手中並使其打出前算力消耗 -1，每回合最多生效 [Arg2] 次。"
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:維度影像·汀克特>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "回合開始時諾締拉獲得 [Arg1] 狂氣。釋放諾諦拉的「狂氣爆發」後獲得等同於當前護盾 [Arg2]% 的反擊和延遲護盾，每回合最多觸發 1 次。"
  },
  RelicConfig_71233_Desc = {
    Text = "回合開始時諾締拉獲得 [Arg1] 狂氣。釋放諾締拉的「狂氣爆發」後獲得等同於當前護盾 [Arg2]% 的反擊和延遲護盾，每回合最多觸發 1 次。"
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:維度影像·諾締拉>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "回合開始時熔燬·朵爾獲得 [Arg1] 狂氣。熔燬朵爾釋放狂氣爆發後，每消耗 [Arg2] 點狂氣其他喚醒體就獲得 1 點狂氣。"
  },
  RelicConfig_71234_Desc = {
    Text = "回合開始時熔毀·朵爾獲得 [Arg1] 狂氣。熔毀·朵爾釋放狂氣爆發後，每消耗 [Arg2] 點狂氣其他喚醒體就獲得 1 點狂氣。"
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:維度影像·熔燬·朵爾>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "回合開始時希洛獲得 [Arg1] 狂氣。每當有 1 張牌被棄掉，都會使希洛獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_71235_Desc = {
    Text = "回合開始時希洛獲得 [Arg1] 狂氣。每當有 1 張牌被棄掉，都會使希洛獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:維度影像·希洛>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "回合開始時達芙黛爾獲得 [Arg1] 狂氣和 1 張「靈感」。「異質潮汐」獲得的力量提高 [Arg2]%，每次打出在本場探索中額外永久提高 [Arg3]%，最大提高 [Arg4]%。"
  },
  RelicConfig_71236_Desc = {
    Text = "回合開始時達芙黛爾獲得 [Arg1] 狂氣和 1 張「靈感」。「異質潮汐」獲得的力量提高 [Arg2]%，每次打出在本場探索中額外永久提高 [Arg3]%，最大提高 [Arg4]%。"
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:維度影像·達芙黛爾>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "回合開始時旺達獲得 [Arg1] 狂氣並獲得 [Arg2] 層「夢引」。若當前為超維回合額外將 1 張臨時的「脊刺鎖鏈」和「迷途之守」置入手中，並使旺達下一張指令卡生效 2 次。"
  },
  RelicConfig_71237_Desc = {
    Text = "回合開始時旺達獲得 [Arg1] 狂氣並獲得 [Arg2] 層「夢引」。若當前為超維回合額外將 1 張臨時的「脊刺鎖鏈」和「迷途之守」置入手中，並使旺達下一張指令卡生效 2 次。"
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:維度影像·旺達>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "回合開始時阿格里帕獲得 [Arg1] 狂氣。「不耐的施捨」還會使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_71238_Desc = {
    Text = "回合開始時阿格里帕獲得 [Arg1] 狂氣。「不耐的施捨」還會使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:維度影像·阿格里帕>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "回合開始時「24」獲得 [Arg1] 狂氣。回合開始時「24」若處於「抑鬱人格」則額外獲得 [Arg2] 狂氣，若處於「躁狂人格」則使「24」臨時暴擊率和臨時暴擊傷害提高 [Arg2]%。"
  },
  RelicConfig_71239_Desc = {
    Text = "回合開始時「24」獲得 [Arg1] 狂氣。回合開始時「24」若處於「抑鬱人格」則額外獲得 [Arg2] 狂氣，若處於「躁狂人格」則使「24」臨時暴擊率和臨時暴擊傷害提高 [Arg2]%。"
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:維度影像·「24」>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "回合開始時莉茲獲得 [Arg1] 狂氣。「告死之舞」棄掉的卡牌額外生效 1 次，3 回合冷卻。"
  },
  RelicConfig_71240_Desc = {
    Text = "回合開始時莉茲獲得 [Arg1] 狂氣。「告死之舞」棄掉的卡牌額外生效 1 次，3 回合冷卻。"
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:維度影像·莉茲>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "回合開始時血鏈希洛獲得 [Arg1] 狂氣。血鏈·希洛主動傷害附加 [Arg2]% 出血，擊殺敵人後對其他敵人造成等同於過量傷害的出血。"
  },
  RelicConfig_71241_Desc = {
    Text = "回合開始時血鏈·希洛獲得 [Arg1] 狂氣。血鏈·希洛主動傷害附加 [Arg2]% 出血，擊殺敵人後對其他敵人造成等同於過量傷害的出血。"
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:維度影像·血鏈·希洛>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "回合開始時希萊斯特獲得 [Arg1] 狂氣。回合結束前，手牌中每有 1 張希萊斯特的指令卡，就會讓 1 條觸腕攻擊敵人，並回覆 [Heal:Arg2] 點生命。"
  },
  RelicConfig_71242_Desc = {
    Text = "回合開始時希萊斯特獲得 [Arg1] 狂氣。回合結束前，手牌中每有 1 張希萊斯特的指令卡，就會讓 1 條觸腕攻擊敵人，並回覆 [Heal:Arg2] 點生命。"
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:維度影像·希萊斯特>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_71243_Desc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:維度影像·卡茜亞>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "回合開始時索蕾爾獲得 [Arg1] 狂氣。索蕾爾每造成 1 次傷害胚胎融合 +[Arg2]，每回合最多生效 [Arg3] 次。生效 10 次後使索蕾爾本場戰鬥最終傷害 + [Arg4]%。"
  },
  RelicConfig_71244_Desc = {
    Text = "回合開始時索蕾爾獲得 [Arg1] 狂氣。索蕾爾每造成 1 次傷害胚胎融合 +[Arg2]，每回合最多生效 [Arg3] 次。生效 10 次後使索蕾爾本場戰鬥最終傷害 + [Arg4]%。"
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:維度影像·索蕾爾>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "回合開始時奧吉爾獲得 [Arg1] 狂氣。每回合首次打出奧吉爾的「穿刺之槍」或「打擊」後，使奧吉爾本回合內造成的護盾和力量提高 [Arg2]%。"
  },
  RelicConfig_71245_Desc = {
    Text = "回合開始時奧吉爾獲得 [Arg1] 狂氣。每回合首次打出奧吉爾的「穿刺之槍」或「打擊」後，使奧吉爾本回合內造成的護盾和力量提高 [Arg2]%。"
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:維度影像·奧吉爾>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "回合開始時艾爾瓦獲得 [Arg1] 狂氣。艾爾瓦在 1 回合內打出第 [Arg2] 張「防禦」時，將一張消耗的「心眼利刃」置入手中；打出第 [Arg3] 張「打擊」時，將 1 張消耗的「臨戰體勢」置入手中。"
  },
  RelicConfig_71246_Desc = {
    Text = "回合開始時艾爾瓦獲得 [Arg1] 狂氣。艾爾瓦在 1 回合內打出第 [Arg2] 張「防禦」時，將一張消耗的「心眼利刃」置入手中；打出第 [Arg3] 張「打擊」時，將 1 張消耗的「臨戰體勢」置入手中。"
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:維度影像·艾爾瓦>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "回合開始時詹金獲得 [Arg1] 狂氣，最終傷害+ [Arg2]%。「布朗出動」的基礎傷害和造成的傷害成長提高 [Arg3]%。"
  },
  RelicConfig_71247_Desc = {
    Text = "回合開始時詹金獲得 [Arg1] 狂氣，最終傷害+ [Arg2]%。「布朗出動」的基礎傷害和造成的傷害成長提高 [Arg3]%。"
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:維度影像·詹金>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "回合開始時朵爾獲得 [Arg1] 狂氣。戰鬥開始後使朵爾的「等價交換」算力消耗變為 0，打出後下回合額外抽 [Arg2] 張牌。"
  },
  RelicConfig_71248_Desc = {
    Text = "回合開始時朵爾獲得 [Arg1] 狂氣。戰鬥開始後使朵爾的「等價交換」算力消耗變為 0，打出後下回合額外抽 [Arg2] 張牌。"
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:維度影像·朵爾>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "回合開始時萊克獲得 [Arg1] 狂氣。每回合首次骰子必定投出最大值。"
  },
  RelicConfig_71249_Desc = {
    Text = "回合開始時萊克獲得 [Arg1] 狂氣。每回合首次骰子必定投出最大值。"
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:維度影像·萊克>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "回合開始時彌利亞姆獲得 [Arg1] 狂氣，並將 1 張「聖禮」置入手中。"
  },
  RelicConfig_71250_Desc = {
    Text = "回合開始時彌利亞姆獲得 [Arg1] 狂氣，並將 1 張「聖禮」置入手中。"
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:維度影像·彌利亞姆>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "回合開始時溫柯爾獲得 [Arg1] 狂氣。每當其他喚醒體釋放狂氣爆發就會使溫柯爾獲得 [Arg2] 點狂氣，並使手中的「精神重建」算力消耗降低 [Arg3]。"
  },
  RelicConfig_71251_Desc = {
    Text = "回合開始時溫柯爾獲得 [Arg1] 狂氣。每當其他喚醒體釋放狂氣爆發就會使溫柯爾獲得 [Arg2] 點狂氣，並使手中的「精神重建」算力消耗降低 [Arg3]。"
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:維度影像·溫柯爾>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "回合開始時圖魯獲得 [Arg1] 狂氣。圖魯的基礎狂氣降低 [Arg2] 點、釋放狂氣爆發後立刻生成 [Arg3] 條臨時觸腕。"
  },
  RelicConfig_71252_Desc = {
    Text = "回合開始時圖魯獲得 [Arg1] 狂氣。圖魯的基礎狂氣降低 [Arg2] 點、釋放狂氣爆發後立刻生成 [Arg3] 條臨時觸腕。"
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:維度影像·圖魯>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "回合開始時菲茵特獲得 [Arg1] 狂氣。菲茵特造成的護盾、反擊、生命回復提高 [Arg2]%，每當觸發死亡抵抗使這個效果在本場探索中提高 [Arg3]%，最多生效 [Arg4] 次。"
  },
  RelicConfig_71253_Desc = {
    Text = "回合開始時菲茵特獲得 [Arg1] 狂氣。菲茵特造成的護盾、反擊、生命回復提高 [Arg2]%，每當觸發死亡抵抗使這個效果在本場探索中提高 [Arg3]%，最多生效 [Arg4] 次。"
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:維度影像·菲茵特>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "回合開始時塔薇獲得 [Arg1] 狂氣。若一回合內打出了 [Arg2] 張塔薇的指令卡，將 1 張<DerivativeCardKeywords_67:「銀鑰曦光」>置入手中，冷卻 [Arg3] 回合。"
  },
  RelicConfig_71254_Desc = {
    Text = "回合開始時塔薇獲得 [Arg1] 狂氣。若一回合內打出了 [Arg2] 張塔薇的指令卡，將 1 張<DerivativeCardKeywords_67:「銀鑰曦光」>置入手中，冷卻 [Arg3] 回合。"
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:維度影像·塔薇>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "回合開始時哈姆林獲得 [Arg1] 狂氣。「靈魂序曲」基礎算力消耗降低 [Arg2]，基礎傷害次數提高 [Arg3]。"
  },
  RelicConfig_71255_Desc = {
    Text = "回合開始時哈姆林獲得 [Arg1] 狂氣。「靈魂序曲」基礎算力消耗降低 [Arg2]，基礎傷害次數提高 [Arg3]。"
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:維度影像·哈姆林>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "回合開始時奧爾拉獲得 [Arg1] 狂氣。戰鬥開始時獲得所有情緒的隱喻各 [Arg2] 層，「隱喻」效果提高 50%。"
  },
  RelicConfig_71256_Desc = {
    Text = "回合開始時奧爾拉獲得 [Arg1] 狂氣。戰鬥開始時獲得所有情緒的隱喻各 [Arg2] 層，「隱喻」效果提高 50%。"
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:維度影像·奧爾拉>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "回合開始時墨菲獲得 [Arg1] 狂氣。墨菲的「打擊」和「防禦」能夠將 [Arg2]% 的「獻祭」轉化為臨時觸腕傷害，但每回合最多生效 1 次。"
  },
  RelicConfig_71257_Desc = {
    Text = "回合開始時墨菲獲得 [Arg1] 狂氣。墨菲的「打擊」和「防禦」能夠將 [Arg2]% 的「獻祭」轉化為臨時觸腕傷害，但每回合最多生效 1 次。"
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:維度影像·墨菲>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "回合開始時尤烏哈希獲得 [Arg1] 狂氣。尤烏哈希的基礎狂氣降低 [Arg2] 點、每次釋放狂氣爆發額外降低 5 點、每回合能夠釋放 [Arg3] 次狂氣爆發。"
  },
  RelicConfig_71258_Desc = {
    Text = "回合開始時尤烏哈希獲得 [Arg1] 狂氣。尤烏哈希的基礎狂氣降低 [Arg2] 點、每次釋放狂氣爆發額外降低 5 點、每回合能夠釋放 [Arg3] 次狂氣爆發。"
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:維度影像·尤烏哈希>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "回合開始時艾繼絲獲得 [Arg1] 狂氣。艾繼絲對具有易傷的敵人造成傷害時還會偷取其 [Arg2] 點臨時力量，每回合最多生效 [Arg3] 次。"
  },
  RelicConfig_71259_Desc = {
    Text = "回合開始時艾繼絲獲得 [Arg1] 狂氣。艾繼絲對具有易傷的敵人造成傷害時還會偷取其 [Arg2] 點臨時力量，每回合最多生效 [Arg3] 次。"
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:維度影像·艾繼絲>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "回合開始時泰旖絲獲得 [Arg1] 狂氣。泰旖絲在 1 回合內打出 [Arg2] 張指令卡後，獲得一張「聖潔之子」和 [Arg3] 點臨時力量，[Arg4] 回合冷卻。"
  },
  RelicConfig_71260_Desc = {
    Text = "回合開始時泰旖絲獲得 [Arg1] 狂氣。泰旖絲在 1 回合內打出 [Arg2] 張指令卡後，獲得一張「聖潔之子」和 [Arg3] 點臨時力量，[Arg4] 回合冷卻。"
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:維度影像·泰旖絲>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "回合開始時法洛思獲得 [Arg1] 狂氣。每造成 2 次觸腕傷害，就使法洛思本場戰鬥造成的中毒和護盾提高 [Arg2]%，最大為 50%。"
  },
  RelicConfig_71261_Desc = {
    Text = "回合開始時法洛思獲得 [Arg1] 狂氣。每造成 2 次觸腕傷害，就使法洛思本場戰鬥造成的中毒和護盾提高 [Arg2]%，最大為 50%。"
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:維度影像·法洛思>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "回合開始時潘狄婭獲得 [Arg1] 狂氣。潘狄婭釋放狂氣爆發後，獲得等同於 [Arg2]% 臨時反擊的永久反擊。"
  },
  RelicConfig_71262_Desc = {
    Text = "回合開始時潘狄婭獲得 [Arg1] 狂氣。潘狄婭釋放狂氣爆發後，獲得等同於 [Arg2]% 臨時反擊的永久反擊。"
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:維度影像·潘狄婭>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "回合開始時莉莉獲得 [Arg1] 狂氣。莉莉忍耐上限提高 100%，釋放「淤泥上的不滅之花」或「報償打擊」時，回復「忍耐」層數 8% 的生命。"
  },
  RelicConfig_71263_Desc = {
    Text = "回合開始時莉莉獲得 [Arg1] 狂氣。莉莉忍耐上限提高 100%，釋放「淤泥上的不滅之花」或「報償打擊」時，回復「忍耐」層數 8% 的生命。"
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:維度影像·莉莉>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "回合開始時珈倫獲得 [Arg1] 狂氣。打出「靜默守望」會返還雙倍消耗的算力，冷卻 [Arg2] 回合。"
  },
  RelicConfig_71264_Desc = {
    Text = "回合開始時珈倫獲得 [Arg1] 狂氣。打出「靜默守望」會返還雙倍消耗的算力，冷卻 [Arg2] 回合。"
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:維度影像·珈倫>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "回合開始時薩爾瓦多獲得 [Arg1] 狂氣。每次積攢猩紅熔爐時還會獲得積攢量 [Arg2]% 的力量。薩爾瓦多的「打擊」與「應消之苦」額外享受 [Arg3] 倍力量加成。"
  },
  RelicConfig_71265_Desc = {
    Text = "回合開始時薩爾瓦多獲得 [Arg1] 狂氣。每次積攢猩紅熔爐時還會獲得積攢量 [Arg2]% 的力量。薩爾瓦多的「打擊」與「應消之苦」額外享受 [Arg3] 倍力量加成。"
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:維度影像·薩爾瓦多>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "回合開始時凱刻斯獲得 [Arg1] 狂氣。凱刻斯獲得護盾時回復 [Arg2]% 護盾量的生命。"
  },
  RelicConfig_71266_Desc = {
    Text = "回合開始時凱刻斯獲得 [Arg1] 狂氣。凱刻斯獲得護盾時回復 [Arg2]% 護盾量的生命。"
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:維度影像·凱刻斯>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "回合開始時寧菲亞獲得 [Arg1] 狂氣。打出寧菲亞的 「打擊」後使「寧菲亞」本場戰鬥造成的中毒提高 [Arg2]%，打出寧菲亞的 「防禦」後觸發所有敵人 [Arg3]% 中毒。每回合最多各生效 1 次。"
  },
  RelicConfig_71267_Desc = {
    Text = "回合開始時寧菲亞獲得 [Arg1] 狂氣。打出寧菲亞的 「打擊」後使「寧菲亞」本場戰鬥造成的中毒提高 [Arg2]%，打出寧菲亞的 「防禦」後觸發所有敵人 [Arg3]% 中毒。每回合最多各生效 1 次。"
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:維度影像·寧菲亞>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "回合開始時艾瑞卡獲得 [Arg1] 狂氣。艾瑞卡在 1 回合內打出 [Arg2] 張指令卡後，獲得 2 點算力並使本場戰鬥「電磁爆破」享受的力量和戒備加成提高 1 倍。"
  },
  RelicConfig_71268_Desc = {
    Text = "回合開始時艾瑞卡獲得 [Arg1] 狂氣。艾瑞卡在 1 回合內打出 [Arg2] 張指令卡後，獲得 2 點算力並使本場戰鬥「電磁爆破」享受的力量和戒備加成提高 1 倍。"
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:維度影像·艾瑞卡>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "回合開始時戈利亞獲得 [Arg1] 狂氣。若戈利亞 1 回合內造成了 [Arg2] 次傷害，戈利亞造成的傷害本場戰鬥中額外享受 1 倍力量加成，3 回合冷卻。"
  },
  RelicConfig_71269_Desc = {
    Text = "回合開始時戈利亞獲得 [Arg1] 狂氣。若戈利亞 1 回合內造成了 [Arg2] 次傷害，戈利亞造成的傷害本場戰鬥中額外享受 1 倍力量加成，3 回合冷卻。"
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:維度影像·戈利亞>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "回合開始時珊獲得 [Arg1] 狂氣。戰鬥開始時對珊的所有指令卡賦予保留、預備 1、獲得 [Arg2] 點護盾。"
  },
  RelicConfig_71270_Desc = {
    Text = "回合開始時珊獲得 [Arg1] 狂氣。戰鬥開始時對珊的所有指令卡賦予保留、預備 1、獲得 [Arg2] 點護盾。"
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:維度影像·珊>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "偶數回合開始時，將 1 張<DerivativeCardKeywords_105:「無盡銀芯寶庫」>置入手中。"
  },
  RelicConfig_71662_Desc = {
    Text = "偶數回合開始時，將 1 張<DerivativeCardKeywords_105:「無盡銀芯寶庫」>置入手中。"
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:貓的寶藏>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "手牌上限+1。回合開始時若當前未進行研究，選擇一項未進行過的研究，完成研究後獲得熔燬·朵爾的對應研究成果。完成 3 個研究時，將「虛無終結」置入手中，該造物失效。"
  },
  RelicConfig_72226_Desc = {
    Text = "手牌上限+1。回合開始時若當前未進行研究，選擇一項未進行過的研究，完成研究後獲得熔燬·朵爾的對應研究成果。完成 3 個研究時，將「虛無終結」置入手中，該造物失效。"
  },
  RelicConfig_72226_Name = {
    Text = "終末科研手稿"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "手牌上限+1。 回合開始時獲得一張自訂的「禁忌的交易」，打出「禁忌的交易」後下回合可再次觸發。 持有「禁忌的交易」時打出不同類型的「指令卡」會升級其中的對應效果。"
  },
  RelicConfig_74832_Desc = {
    Text = "手牌上限+1。 回合開始時獲得一張自訂的「禁忌的交易」，打出「禁忌的交易」後下回合可再次觸發。 持有「禁忌的交易」時打出不同類型的「指令卡」會升級其中的對應效果。"
  },
  RelicConfig_74832_Name = {
    Text = "千面邀請函"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "信函上文字不斷變化，始終化為無法拒絕的渴求。"
  },
  RelicConfig_78664_BattleDesc = {
    Text = "在單回合內打出 4 張歸屬於不同喚醒體的指令卡後，使所有喚醒體本回合造成的最終傷害提高 [Arg1]%，並失去 [Arg2] 點狂氣，每回合最多生效 1 次。"
  },
  RelicConfig_78664_Desc = {
    Text = "在單回合內打出 4 張歸屬於不同喚醒體的指令卡後，使所有喚醒體本回合造成的最終傷害提高 [Arg1]%，並失去 [Arg2] 點狂氣，每回合最多生效 1 次。"
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:古怪鉤爪>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "難以辨識的物種。"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "回合開始時少抽 [Arg1] 張牌 。每打出 1 張實際算力消耗大於等於 [Arg2] 的牌獲得 1 點算力，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_78665_Desc = {
    Text = "回合開始時少抽 [Arg1] 張牌 。每打出 1 張實際算力消耗大於等於 [Arg2] 的牌獲得 1 點算力，每回合最多觸發 [Arg3] 次。"
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:哀嚎搖鈴>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "叮鈴，叮鈴，孩子在哭鬧；\n叮鈴，叮鈴，孩子在尖叫。\n叮鈴，叮鈴，孩子在哀嚎；\n叮鈴，叮鈴，它餓了，你知道。"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "回合開始時獲得 [Arg1] 點反擊。在一回合內釋放 [Arg2] 次狂氣爆發後，移除自身 [Arg3]% 永久反擊，獲得 [Arg4]% 移除量的臨時反擊，[Arg5] 回合冷卻。"
  },
  RelicConfig_78666_Desc = {
    Text = "回合開始時獲得 [Arg1] 點反擊。在一回合內釋放 [Arg2] 次狂氣爆發後，移除自身 [Arg3]% 永久反擊，獲得 [Arg4]% 移除量的臨時反擊，[Arg5] 回合冷卻。"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "神聖的一部分。\n縱然與軀幹分離，其足跡也已遍佈四海。"
  },
  RelicConfig_78667_BattleDesc = {
    Text = "抽牌階段後額外抽 [Arg1] 張牌，並選擇 [Arg2] 張手牌棄掉。"
  },
  RelicConfig_78667_Desc = {
    Text = "抽牌階段後額外抽 [Arg1] 張牌，並選擇 [Arg2] 張手牌棄掉。"
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:詭術禮帽>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "歡迎來到卡茜亞小姐的仙境馬戲團！小心些，不要隨便觸碰魔術道具哦。要是一不小心被咬傷，那可就糟糕了。\n畢竟，它上一次嘗到血的滋味，造成的後果可是很恐怖的。\n\n禮帽眨了眨眼睛，彷彿隨時會破繭而出。"
  },
  RelicConfig_78668_BattleDesc = {
    Text = "使用銀鑰覺醒後，選擇對應喚醒體的 [Arg1] 張非衍生指令卡將其消耗，並把 [Arg2] 張附加消耗的原始複製分別置入抽牌堆、手牌堆和棄牌堆。"
  },
  RelicConfig_78668_Desc = {
    Text = "使用銀鑰覺醒後，選擇對應喚醒體的 [Arg1] 張非衍生指令卡將其消耗，並把 [Arg2] 張附加消耗的原始複製分別置入抽牌堆、手牌堆和棄牌堆。"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] 點力量。回合開始每有 [Arg2] 點永久力量獲得 [Arg3] 點臨時力量，最多獲得 [Arg4] 點臨時力量，並在回合結束時失去由該造物獲得臨時力量一半的護盾。"
  },
  RelicConfig_78669_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 點力量。回合開始每有 [Arg2] 點永久力量獲得 [Arg3] 點臨時力量，最多獲得 [Arg4] 點臨時力量，並在回合結束時失去由該造物獲得臨時力量一半的護盾。"
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:厄運儀式鳥>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "乾癟的屍體發出了鳴叫聲。"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "所有喚醒體的基礎傷害提高 [Arg1]%，每次重置牌庫額外提高 [Arg2]%，但將 1 張「蹣跚」置入手中，提高值最多為 [Arg3]%。"
  },
  RelicConfig_78670_Desc = {
    Text = "所有喚醒體的基礎傷害提高 [Arg1]%，每次重置牌庫額外提高 [Arg2]%，但將 1 張「蹣跚」置入手中，提高值最多為 [Arg3]%。"
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:黑燭>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "燃燒清醒，墮入虛妄。"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "回合開始時胚胎融合+ [Arg1]，你的「胚胎」會在回合結束時被棄掉。"
  },
  RelicConfig_78671_Desc = {
    Text = "回合開始時胚胎融合+ [Arg1]，你的「胚胎」會在回合結束時被棄掉。"
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:蠕動的臍帶>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "纏繞脖頸。"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "回合開始時，受到 [Arg2] 層中毒，超維空間每有 1 個空位獲得 [Arg1] 點力量。"
  },
  RelicConfig_78672_Desc = {
    Text = "回合開始時，受到 [Arg2] 層中毒，超維空間每有 1 個空位獲得 [Arg1] 點力量。"
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:蟲群意識>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "纏繞、共生、集群；恐懼、未知、控制。"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "銀鑰覺醒後額外消耗 [Arg1] 點銀鑰能量，使獲得的靈知覺醒卡算力消耗變為 0，打出後使對應喚醒體額外獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_78673_Desc = {
    Text = "銀鑰覺醒後額外消耗 [Arg1] 點銀鑰能量，使獲得的靈知覺醒卡算力消耗變為 0，打出後使對應喚醒體額外獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:意識銘刻>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "古老的部落堅信，在死者的頭顱上篆刻特殊符號，能夠將他的靈魂留下，獲得永遠的陪伴。"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "戰鬥開始時對所有敵人造成 [Arg1] 點中毒。回合開始時移除敵人 [Arg2]% 的中毒，對其施加 [Arg3]% 移除量的出血。"
  },
  RelicConfig_78674_Desc = {
    Text = "戰鬥開始時對所有敵人造成 [Arg1] 點中毒。回合開始時移除敵人 [Arg2]% 的中毒，對其施加 [Arg3]% 移除量的出血。"
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:救濟之肢>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "神聖的一部分。\n縱然與軀幹分離，仍能感受到其上的溫暖。"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "回合開始時若有超過 [Arg1] 條的永久觸腕，失去 [Arg2] 條觸腕獲得 [Arg3] 條臨時觸腕，否則獲得 [Arg4] 條永久觸腕。"
  },
  RelicConfig_78675_Desc = {
    Text = "回合開始時若有超過 [Arg1] 條的永久觸腕，失去 [Arg2] 條觸腕獲得 [Arg3] 條臨時觸腕，否則獲得 [Arg4] 條永久觸腕。"
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:苦痛聖腕>"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "手牌上限+ 2，抽牌數 +2。「清明之憶」起始為 5 層，打出帶有標記的卡牌會使「清明之憶」發生變化。「清明之憶」低於 5 時每低 1 點最終傷害 +10%，護盾和生命回復降低 5%；「清明之憶」高於 5 時每高 1 點護盾和生命回復提高 5%，最終傷害 -10%。"
  },
  RelicConfig_79408_Desc = {
    Text = "手牌上限+ 2，抽牌數 +2。「清明之憶」起始為 5 層，打出帶有標記的卡牌會使「清明之憶」發生變化。「清明之憶」低於 5 時每低 1 點最終傷害 +10%，護盾和生命回復降低 5%；「清明之憶」高於 5 時每高 1 點護盾和生命回復提高 5%，最終傷害 -10%。"
  },
  RelicConfig_79408_Name = {
    Text = "「記憶」與「夢」"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "「來，聽我說。」\n「讓我將你的記憶與夢。」\n「製作成無比美味的甜點。」"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "回合開始時克萊門汀獲得 [Arg1] 狂氣。克萊門汀所有指令卡傷害、護盾、生命回復、獲得狂氣、獲得銀鑰能量的效果次數提高 1。"
  },
  RelicConfig_80340_Desc = {
    Text = "回合開始時克萊門汀獲得 [Arg1] 狂氣。克萊門汀所有指令卡傷害、護盾、生命回復、獲得狂氣、獲得銀鑰能量的效果次數提高 1。"
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:維度影像·克萊門汀>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "探索開始時造物上限+1，「深海」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「深海」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83509_Desc = {
    Text = "探索開始時造物上限+1，「深海」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「深海」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:「深海指輪」>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "深淵溟海中的沉睡者，開始向世界展示被遺忘的權威。"
  },
  RelicConfig_83510_BattleDesc = {
    Text = "探索開始時造物上限+1，「血肉」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「血肉」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83510_Desc = {
    Text = "探索開始時造物上限+1，「血肉」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「血肉」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:「血肉指輪」>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "從未苦弱，已然飛昇。"
  },
  RelicConfig_83511_BattleDesc = {
    Text = "探索開始時造物上限+1，「超維」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「超維」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83511_Desc = {
    Text = "探索開始時造物上限+1，「超維」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「超維」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:「超維指輪」>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "無盡維度疊加而至，此刻「我」已無限完整。"
  },
  RelicConfig_83512_BattleDesc = {
    Text = "探索開始時造物上限+1，「混沌」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「混沌」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83512_Desc = {
    Text = "探索開始時造物上限+1，「混沌」界域喚醒體獲得其「維度影像」。隊伍中每有 1 名「混沌」界域喚醒體，造物上限+1。"
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:「混沌指輪」>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "混沌無形，混沌無質，混沌已融於萬物之中。"
  },
  RelicConfig_83606_BattleDesc = {
    Text = "手牌上限+ 1 。回合開始時若沒有「引航者的抉擇」，將其置入手中。\n每當首領失去初始最大生命的 10% 時，獲得 1 層「揚帆」，上限 10 層，「揚帆」能夠提升「破浪啟航」的效果。\n每當自身失去初始最大生命的 10% 時，獲得 1 層「泊錨」，上限 10 層，「泊錨」能夠提升「攏岸暫息」的效果。"
  },
  RelicConfig_83606_Desc = {
    Text = "手牌上限+ 1 。回合開始時若沒有「引航者的抉擇」，將其置入手中。\n每當首領失去初始最大生命的 10% 時，獲得 1 層「揚帆」，上限 10 層，「揚帆」能夠提升「破浪啟航」的效果。\n每當自身失去初始最大生命的 10% 時，獲得 1 層「泊錨」，上限 10 層，「泊錨」能夠提升「攏岸暫息」的效果。"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "閃爍的雷光將指引前進的方向。"
  },
  RelicConfig_84112_BattleDesc = {
    Text = "回合開始時阿格里帕獲得 [Arg1] 狂氣。「不耐的施捨」還會使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_84112_Desc = {
    Text = "回合開始時阿格里帕獲得 [Arg1] 狂氣。「不耐的施捨」還會使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:維度影像·阿格里帕>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "回合開始時卡拉布獲得 [Arg1] 狂氣。卡拉布每次<FaxianKeywords:發現> <DerivativeCardKeywords_152:「賜福」>時出現 1 個額外選項，狂氣爆發造成等量傷害的<Corrosion:侵蝕>。"
  },
  RelicConfig_84113_Desc = {
    Text = "回合開始時卡拉布獲得 [Arg1] 狂氣。卡拉布每次<FaxianKeywords:發現> <DerivativeCardKeywords_152:「賜福」>時出現 1 個額外選項，狂氣爆發造成等量傷害的<Corrosion:侵蝕>。"
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:維度影像·卡拉布>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "回合開始時皮克曼獲得 [Arg1] 狂氣。每獲得 1 層「創意」，隨機使 1 張手牌本回合算力消耗降低 1，皮克曼消耗「創意」時額外使所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_84114_Desc = {
    Text = "回合開始時皮克曼獲得 [Arg1] 狂氣。每獲得 1 層「創意」，隨機使 1 張手牌本回合算力消耗降低 1，皮克曼消耗「創意」時額外使所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:維度影像·皮克曼>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "回合開始時艾瑞卡獲得 [Arg1] 狂氣。艾瑞卡在 1 回合內打出 [Arg2] 張指令卡後，獲得 2 點算力並使本場戰鬥「電磁爆破」享受的力量和戒備加成提高 1 倍。"
  },
  RelicConfig_84116_Desc = {
    Text = "回合開始時艾瑞卡獲得 [Arg1] 狂氣。艾瑞卡在 1 回合內打出 [Arg2] 張指令卡後，獲得 2 點算力並使本場戰鬥「電磁爆破」享受的力量和戒備加成提高 1 倍。"
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:維度影像·艾瑞卡>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "回合開始時誕妄·墨菲獲得 [Arg1] 狂氣。「螺湮圓舞」每第 3 次釋放生效 3 次。"
  },
  RelicConfig_84117_Desc = {
    Text = "回合開始時誕妄·墨菲獲得 [Arg1] 狂氣。「螺湮圓舞」每第 3 次釋放生效 3 次。"
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:維度影像·誕妄·墨菲>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_84118_Desc = {
    Text = "回合開始時卡茜亞獲得 [Arg1] 狂氣。每抽 1 張牌就使卡茜亞獲得 [Arg2] 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 [Arg3] 點力量。"
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:維度影像·卡茜亞>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "回合開始時墨菲獲得 [Arg1] 狂氣。墨菲的「打擊」和「防禦」能夠將 [Arg2]% 的「獻祭」轉化為臨時觸腕傷害，但每回合最多生效 1 次。"
  },
  RelicConfig_84119_Desc = {
    Text = "回合開始時墨菲獲得 [Arg1] 狂氣。墨菲的「打擊」和「防禦」能夠將 [Arg2]% 的「獻祭」轉化為臨時觸腕傷害，但每回合最多生效 1 次。"
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:維度影像·墨菲>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "回合開始時阿拉克涅獲得 [Arg1] 狂氣。「打擊」和「防禦」立即釋放 1 次「無盡線縷」追擊，每回合最多各生效 1 次。"
  },
  RelicConfig_84121_Desc = {
    Text = "回合開始時阿拉克涅獲得 [Arg1] 狂氣。「打擊」和「防禦」立即釋放 1 次「無盡線縷」追擊，每回合最多各生效 1 次。"
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:維度影像·阿拉克涅>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "回合開始時圖魯獲得 [Arg1] 狂氣。圖魯的狂氣消耗降低 [Arg2] 點，釋放狂氣爆發後立刻生成 [Arg3] 條臨時觸腕。"
  },
  RelicConfig_84122_Desc = {
    Text = "回合開始時圖魯獲得 [Arg1] 狂氣。圖魯的狂氣消耗降低 [Arg2] 點，釋放狂氣爆發後立刻生成 [Arg3] 條臨時觸腕。"
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:維度影像·圖魯>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "回合開始時波呂克斯獲得 [Arg1] 狂氣。戰鬥開始時獲得 1 張「聖心」，「聖心」因第 3 次打出消耗時易傷所有敵人，並造成 2 次傷害。"
  },
  RelicConfig_84123_Desc = {
    Text = "回合開始時波呂克斯獲得 [Arg1] 狂氣。戰鬥開始時獲得 1 張「聖心」，「聖心」因第 3 次打出消耗時易傷所有敵人，並造成 2 次傷害。"
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:維度影像·波呂克斯>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "回合開始時哈姆林獲得 [Arg1] 狂氣。「靈魂序曲」算力消耗降低 [Arg2]，基礎傷害次數提高 [Arg3]。"
  },
  RelicConfig_84124_Desc = {
    Text = "回合開始時哈姆林獲得 [Arg1] 狂氣。「靈魂序曲」算力消耗降低 [Arg2]，基礎傷害次數提高 [Arg3]。"
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:維度影像·哈姆林>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "回合開始時凱蒂古拉獲得 [Arg1] 點狂氣。累計消耗 10 層「活焰」後，立刻抽 1 張凱蒂古拉的指令卡併為其賦予 3 層「活焰」，本回合不再累計層數。"
  },
  RelicConfig_84125_Desc = {
    Text = "回合開始時凱蒂古拉獲得 [Arg1] 點狂氣。累計消耗 10 層「活焰」後，立刻抽 1 張凱蒂古拉的指令卡併為其賦予 3 層「活焰」，本回合不再累計層數。"
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:維度影像·凱蒂古拉>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "回合開始時卡斯托爾獲得 [Arg1] 狂氣。戰鬥開始時將 2 張「黑羽」置入手中，每回合首次打出「黑羽」後獲得 [Arg2] 點臨時力量。"
  },
  RelicConfig_84126_Desc = {
    Text = "回合開始時卡斯托爾獲得 [Arg1] 狂氣。戰鬥開始時將 2 張「黑羽」置入手中，每回合首次打出「黑羽」後獲得 [Arg2] 點臨時力量。"
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:維度影像·卡斯托爾>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "回合開始時克珀珊特獲得 [Arg1] 狂氣，獲得 1 條臨時觸腕。每當觸發死亡抵抗時克珀珊特獲得 [Arg2] 點狂氣，將 1 張算力消耗為 0 且附加消耗的「懲戒雷霆」置入手中。"
  },
  RelicConfig_84127_Desc = {
    Text = "回合開始時克珀珊特獲得 [Arg1] 狂氣，獲得 1 條臨時觸腕。每當觸發死亡抵抗時克珀珊特獲得 [Arg2] 點狂氣，將 1 張算力消耗為 0 且附加消耗的「懲戒雷霆」置入手中。"
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:維度影像·克珀珊特>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "算力上限提高 1 ，每回合抽牌數提高 1 ，戰鬥開始時獲得 [Arg1] 層「宿命牢籠」計數。\n每層「宿命牢籠」使所有喚醒體產生的狂氣降低 [Arg2]% ，每次釋放狂氣爆發時，減少 1 層「宿命牢籠」。所有「宿命牢籠」被移除之後，所有喚醒體獲得 [Arg3] 點狂氣，獲得「不屈之心」：所有喚醒體產生的狂氣提高 [Arg4]%，每回合能夠釋放 2 次狂氣爆發。"
  },
  RelicConfig_89252_Desc = {
    Text = "算力上限提高 1 ，每回合抽牌數提高 1 ，戰鬥開始時獲得 [Arg1] 層「宿命牢籠」計數。\n每層「宿命牢籠」使所有喚醒體產生的狂氣降低 [Arg2]% ，每次釋放狂氣爆發時，減少 1 層「宿命牢籠」。所有「宿命牢籠」被移除之後，所有喚醒體獲得 [Arg3] 點狂氣，獲得「不屈之心」：所有喚醒體產生的狂氣提高 [Arg4]%，每回合能夠釋放 2 次狂氣爆發。"
  },
  RelicConfig_89252_Name = {
    Text = "受詛的羽毛"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "如今，這片羽毛再也不能於天空上翱翔。"
  },
  RelicConfig_89645_BattleDesc = {
    Text = "手牌上限 +2 ，釋放狂氣爆發後臨時最終傷害提高 10% 。\n卡牌進入超維空間後，手中 1 個「胚胎」轉化為「聖潔之子」。\n每生成 1 個「胚胎」，超維空間一張隨機卡牌算力消耗降低 1。"
  },
  RelicConfig_89645_Desc = {
    Text = "手牌上限 +2 ，釋放狂氣爆發後臨時最終傷害提高 10% 。\n卡牌進入超維空間後，手中 1 個「胚胎」轉化為「聖潔之子」。\n每生成 1 個「胚胎」，超維空間一張隨機卡牌算力消耗降低 1。"
  },
  RelicConfig_89645_Name = {
    Text = "超弦腐血製劑"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "回合開始時獲得 250 點銀鑰能量。\n使用銀鑰覺醒後，將 1 張<DerivativeCardKeywords_129:「銀鑰微光」>置入手中。\n每回合開始時發現 1 張喚醒體的支援。"
  },
  RelicConfig_89646_Desc = {
    Text = "回合開始時獲得 250 點銀鑰能量。\n使用銀鑰覺醒後，將 1 張<DerivativeCardKeywords_129:「銀鑰微光」>置入手中。\n每回合開始時發現 1 張喚醒體的支援。"
  },
  RelicConfig_89646_Name = {
    Text = "統合衍化製劑"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "每回合第 1 張指令卡額外生效 1 次。\n湮滅時生成 1 條觸腕。\n切換觸腕為「怒濤」姿態後，本回合下 1 張指令卡的躍遷效果必定發動並將其 2 張原始複製置入超維空間，3 回合冷卻。"
  },
  RelicConfig_89647_Desc = {
    Text = "每回合第 1 張指令卡額外生效 1 次。\n湮滅時生成 1 條觸腕。\n切換觸腕為「怒濤」姿態後，本回合下 1 張指令卡的躍遷效果必定發動並將其 2 張原始複製置入超維空間，3 回合冷卻。"
  },
  RelicConfig_89647_Name = {
    Text = "超弦海淵製劑"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "界域精通提高 200 點。\n消耗猩紅熔爐時，提高消耗量 15% 的觸腕傷害。\n每次觸腕攻擊時，積累 [Arg3] 點猩紅熔爐。"
  },
  RelicConfig_89648_Desc = {
    Text = "界域精通提高 200 點。\n消耗猩紅熔爐時，提高消耗量 15% 的觸腕傷害。\n每次觸腕攻擊時，積累 [Arg3] 點猩紅熔爐。"
  },
  RelicConfig_89648_Name = {
    Text = "腐血海淵製劑"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "回合開始時，雙方獲得一層<Kuangre:狂熱>，每層<Kuangre:狂熱>使造成的主動和觸腕傷害附帶 10% 傷害等量的<BleedingIconKeywords:出血>。\n每造成首領生命 20% 的傷害就使所有喚醒體獲得 10 狂氣。\n戰鬥開始時將<DerivativeCardKeywords_108:「子嗣激勵」>與<DerivativeCardKeywords_109:「子嗣庇佑」>洗入抽牌堆。"
  },
  RelicConfig_91096_Desc = {
    Text = "回合開始時，雙方獲得一層<Kuangre:狂熱>，每層<Kuangre:狂熱>使造成的主動和觸腕傷害附帶 10% 傷害等量的<BleedingIconKeywords:出血>。\n每造成首領生命 20% 的傷害就使所有喚醒體獲得 10 狂氣。\n戰鬥開始時將<DerivativeCardKeywords_108:「子嗣激勵」>與<DerivativeCardKeywords_109:「子嗣庇佑」>洗入抽牌堆。"
  },
  RelicConfig_91096_Name = {
    Text = "蒼白之卵"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "蒼白之子即將誕生時的鼓動。\n小心，它們馬上就要來了。"
  },
  RelicConfig_94695_BattleDesc = {
    Text = "喚醒體被擊殺後，其他友方獲得 [Arg1] <StrongEffectKeywords:強效>，該效果每個喚醒體僅能觸發一次。"
  },
  RelicConfig_94695_Desc = {
    Text = "喚醒體被擊殺後，其他友方獲得 [Arg1] <StrongEffectKeywords:強效>，該效果每個喚醒體僅能觸發一次。"
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:黑星燃燒之燼>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "戰鬥開始後，將 [Arg1] 張「<PVPDerivativeCardKeywords_21:蝕骨的擁抱>」置入手牌。"
  },
  RelicConfig_94696_Desc = {
    Text = "戰鬥開始後，將 [Arg1] 張「<PVPDerivativeCardKeywords_21:蝕骨的擁抱>」置入手牌。"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "回合結束時，丟棄所有手牌，並抽取相應數量的牌。"
  },
  RelicConfig_94697_Desc = {
    Text = "回合結束時，丟棄所有手牌，並抽取相應數量的牌。"
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:蠱惑風鈴>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "戰鬥開始後，在抽牌堆內置入 [Arg1] 張「<PVPDerivativeCardKeywords_22:後發制人>」和「<PVPDerivativeCardKeywords_23:腦中之音>」。"
  },
  RelicConfig_94698_Desc = {
    Text = "戰鬥開始後，在抽牌堆內置入 [Arg1] 張「<PVPDerivativeCardKeywords_22:後發制人>」和「<PVPDerivativeCardKeywords_23:腦中之音>」。"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "手牌上限+1。\n回合開始時若沒有<DerivativeCardKeywords_111:「靈魂吞噬」>將其置入手中。若「饜足」達到 10 則將其轉化為<DerivativeCardKeywords_112:「記憶共鳴」>。"
  },
  RelicConfig_95975_Desc = {
    Text = "手牌上限+1。\n回合開始時若沒有「靈魂吞噬」將其置入手中。若「饜足」達到 10 則將其轉化為「記憶共鳴」。"
  },
  RelicConfig_95975_Name = {
    Text = "骸骨杯盞"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "「血月高升，群骸當舉杯共飲。」"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "回合開始時杜勒賽因獲得 [Arg1] 狂氣和 [Arg2] 點力量。杜勒賽因食用「殘骸」時，獲得 20％ 永久力量的臨時力量。"
  },
  RelicConfig_95976_Desc = {
    Text = "回合開始時杜勒賽因獲得 [Arg1] 狂氣和 [Arg2] 點力量。杜勒賽因食用「殘骸」時，獲得 20％ 永久力量的臨時力量。"
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:維度影像·杜勒賽因>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "回合開始時使手中 1 張指令卡獲得「<BurningKeywords2:燃燒>」並積攢 1 層「<Heat:深暗之焰>」。「<Heat:深暗之焰>」達到 3 層後，將一張「<Overload:無盡的爆炎>」置入手中。"
  },
  RelicConfig_96652_Desc = {
    Text = "回合開始時使手中 1 張指令卡獲得「<BurningKeywords2:燃燒>」並積攢 1 層「<Heat:深暗之焰>」。「<Heat:深暗之焰>」達到 3 層後，將一張「<Overload:無盡的爆炎>」置入手中。"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "漆黑的火焰將貫徹她的意志，將一切焚燒殆盡。"
  },
  RelicConfig_97344_BattleDesc = {
    Text = "失去最後 1 張手牌時抽 2 張牌並獲得 [Arg1] 點銀鑰能量。每次重置牌庫後觸腕傷害提高 [Arg2] 點。"
  },
  RelicConfig_97344_Desc = {
    Text = "失去最後 1 張手牌時抽 2 張牌並獲得 [Arg1] 點銀鑰能量。每次重置牌庫後觸腕傷害提高 [Arg2] 點。"
  },
  RelicConfig_97344_Name = {
    Text = "彌薩格奪冠金盃"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "今日，我們將忘記恐懼，忘記沉痛，只享受狂歡。"
  },
  RelicConfig_97345_BattleDesc = {
    Text = "每打出 3 張指令卡，獲得 1 點算力並抽 1 張牌。每造成 1 次主動傷害就使臨時最終傷害提高 2%，最大為 50%。"
  },
  RelicConfig_97345_Desc = {
    Text = "每打出 3 張指令卡，獲得 1 點算力並抽 1 張牌。每造成 1 次主動傷害就使臨時最終傷害提高 2%，最大為 50%。"
  },
  RelicConfig_97345_Name = {
    Text = "彌薩格奪冠金盃"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "今日，我們將忘記恐懼，忘記沉痛，只享受狂歡。"
  },
  RelicConfig_97346_BattleDesc = {
    Text = "所有喚醒體暴擊率提高 30%，奇數回合開始時，所有敵人失去 25% 當前生命。自身生命值比例低於敵人時，造成的最終傷害提高 50%；自身生命值比例高於敵人時，釋放狂氣爆發後獲得 35 點狂氣。"
  },
  RelicConfig_97346_Desc = {
    Text = "所有喚醒體暴擊率提高 30%，奇數回合開始時，所有敵人失去 25% 當前生命。自身生命值比例低於敵人時，造成的最終傷害提高 50%；自身生命值比例高於敵人時，釋放狂氣爆發後獲得 35 點狂氣。"
  },
  RelicConfig_97346_Name = {
    Text = "彌薩格奪冠金盃"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "今日，我們將忘記恐懼，忘記沉痛，只享受狂歡。"
  },
  RelicConfig_97347_BattleDesc = {
    Text = "最大算力提高 2 點，未消耗的算力可保留至下回合，若保留超過 2 點算力，下回合開始時所有喚醒體獲得 20 點狂氣；若保留超過 4 點算力，下回合造成的基礎傷害提高 100%。"
  },
  RelicConfig_97347_Desc = {
    Text = "最大算力提高 2 點，未消耗的算力可保留至下回合，若保留超過 2 點算力，下回合開始時所有喚醒體獲得 20 點狂氣；若保留超過 4 點算力，下回合造成的基礎傷害提高 100%。"
  },
  RelicConfig_97347_Name = {
    Text = "彌薩格奪冠金盃"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "今日，我們將忘記恐懼，忘記沉痛，只享受狂歡。"
  },
  RelicConfig_98274_BattleDesc = {
    Text = "手牌上限 +1，戰鬥開始時獲得「<DerivativeCardKeywords_116:調色盤>」。\n回合開始時獲得 1 個「<PrimaryColor:原色>」並隨機使 2 張指令卡獲得「<ColorInkKeywords:認知失調>」，打出「<ColorInkKeywords:認知失調>」牌後按順序獲得 1 個「<PrimaryColor:原色>」。\n「<PrimaryColor:原色>」 打出後會被記錄到「<DerivativeCardKeywords_116:調色盤>」上，若「<DerivativeCardKeywords_116:調色盤>」上存在 2 種不同的「<PrimaryColor:原色>」，會帶來持續增益效果。\n若調色盤上存在 3 種不同的「<PrimaryColor:原色>」，立刻使所有敵人失去 5％ 最大生命，並清空「<DerivativeCardKeywords_116:調色盤>」。"
  },
  RelicConfig_98274_Desc = {
    Text = "手牌上限 +1，戰鬥開始時獲得「<DerivativeCardKeywords_116:調色盤>」。\n回合開始時獲得 1 個「<PrimaryColor:原色>」並隨機使 2 張指令卡獲得「<ColorInkKeywords:認知失調>」，打出「<ColorInkKeywords:認知失調>」牌後按順序獲得 1 個「<PrimaryColor:原色>」。\n「<PrimaryColor:原色>」 打出後會被記錄到「<DerivativeCardKeywords_116:調色盤>」上，若「<DerivativeCardKeywords_116:調色盤>」上存在 2 種不同的「<PrimaryColor:原色>」，會帶來持續增益效果。\n若調色盤上存在 3 種不同的「<PrimaryColor:原色>」，立刻使所有敵人失去 5％ 最大生命，並清空「<DerivativeCardKeywords_116:調色盤>」。"
  },
  RelicConfig_98274_Name = {
    Text = "異象調色盤"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "在異象中，我們將見證「藝術」的誕生。"
  },
  RelicConfig_98367_BattleDesc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  RelicConfig_98367_Desc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:怪蛇殘蛻>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "自殘蛻中重生。"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 [Arg1]% 臨時傷害強效。"
  },
  RelicConfig_98368_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 [Arg1]% 臨時傷害強效。"
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:萬花筒+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "所思所見皆為幻象。"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "使用銀鑰覺醒後使手中算力最高的 [Arg1] 張卡牌在下次打出前獲得保留和預備，獲得 [Arg2] 點銀鑰能量。"
  },
  RelicConfig_98369_Desc = {
    Text = "使用銀鑰覺醒後使手中算力最高的 [Arg1] 張卡牌在下次打出前獲得保留和預備，獲得 [Arg2] 點銀鑰能量。"
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:異鄉郵票夾>"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層虛弱和易傷。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98370_Desc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:空間偏折儀>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "躍入虛空。"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_98371_Desc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "不再象徵公正。"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張<DerivativeCardKeywords_129:「銀鑰微光」>置入手牌。"
  },
  RelicConfig_98372_Desc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張<DerivativeCardKeywords_129:「銀鑰微光」>置入手牌。"
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:在夕光裡>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "一起來拍照吧！體驗一把面對真實的痛感。"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "釋放「狂氣爆發」獲得 [Arg1] 銀鑰能量。"
  },
  RelicConfig_98373_Desc = {
    Text = "釋放「狂氣爆發」獲得 [Arg1] 銀鑰能量。"
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:美麗瞬間+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "將須臾的美保存至永遠。"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層中毒，並獲得 [Arg2] 層反擊。"
  },
  RelicConfig_98374_Desc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，並獲得 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:先知的許願燈+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "回應你的願望。"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張<DerivativeCardKeywords_67:「銀鑰曦光」>置入手牌。"
  },
  RelicConfig_98375_Desc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張<DerivativeCardKeywords_67:「銀鑰曦光」>置入手牌。"
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:在夕光裡+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "一起來拍照吧！體驗一把面對真實的痛感。"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  RelicConfig_98376_Desc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:怪蛇殘蛻+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "自殘蛻中重生。"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98377_Desc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:三棱鏡>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "「光由七種色彩構成。」"
  },
  RelicConfig_98378_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。受到傷害後獲得 [Arg2] 反擊，每回合最多觸發 3 次。"
  },
  RelicConfig_98378_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。受到傷害後獲得 [Arg2] <RetaliateIconKeywords:反擊>，每回合最多觸發 3 次。"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "看來，他也沒能逃出去。"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  RelicConfig_98379_Desc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:潛水頭盔>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "夢想是星辰大海！"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98380_Desc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:過往的貢物>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "曾被進獻之物。"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "使用銀鑰覺醒後回覆 [Heal:Arg1] 生命、獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_98381_Desc = {
    Text = "使用銀鑰覺醒後回覆 [Heal:Arg1] 生命、獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:旅行陽傘>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "在無光之地綻放。"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇數回合開始時抽 [Arg2] 張牌，偶數回合開始時獲得 [Arg2] 點算力。"
  },
  RelicConfig_98382_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇數回合開始時抽 [Arg2] 張牌，偶數回合開始時獲得 [Arg2] 點算力。"
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:日月輪盤+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "猜一猜，是黑還是白？"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  RelicConfig_98383_Desc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:小黃螺+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "這只小黃螺出身高貴，有著完美的、無可挑剔的來源。"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  RelicConfig_98384_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:被遺忘者之血>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "日漸消融。"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層中毒，並獲得 [Arg2] 層反擊。"
  },
  RelicConfig_98385_Desc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，並獲得 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:先知的許願燈>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "回應你的願望。"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "回合開始時若生命低於 50%，臨時傷害強效 +[Arg1]%，若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  RelicConfig_98386_Desc = {
    Text = "回合開始時若生命低於 50%，臨時傷害強效 +[Arg1]%，若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:醫生手提箱>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "象徵醫生身分的手提箱，十分沉重。\n打開它的，未必是真的醫生。"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層虛弱和易傷。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98387_Desc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:空間偏折儀+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "躍入虛空。"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98388_Desc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:過往的貢物+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "曾被進獻之物。"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇數回合開始時抽 [Arg2] 張牌，偶數回合開始時獲得 [Arg2] 點算力。"
  },
  RelicConfig_98389_Desc = {
    Text = "戰鬥開始後，獲得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇數回合開始時抽 [Arg2] 張牌，偶數回合開始時獲得 [Arg2] 點算力。"
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:日月輪盤>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "猜一猜，是黑還是白？"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時力量 ，每回合最多觸發 15 次。"
  },
  RelicConfig_98390_Desc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時<PowerIconKeywords:力量> ，每回合最多觸發 15 次。"
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:寂靜序曲>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "著名小提琴家埃裡克·艾克施坦因的提琴。\n如今，它已不可再奏響。"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg2]%，生命越低則效果越強。"
  },
  RelicConfig_98391_Desc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg1]%，生命越低則效果越強。"
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:哈福德靈藥>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "成分不明的藥物。\n據說著名提琴家埃裡克對其青睞有加。"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg2]%，生命越低則效果越強。"
  },
  RelicConfig_98392_Desc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg1]%，生命越低則效果越強。"
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:哈福德靈藥+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "成分不明的藥物。\n據說著名提琴家埃裡克對其青睞有加。"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98393_Desc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:伶牙俐齒>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "能說會道的不止商人，亦有虔信者。"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  RelicConfig_98394_Desc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:幸運兔腳>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "對兔子來說，可就不那麼幸運了。"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。造成主動傷害後對所有敵人造成 [Arg2] 中毒，每回合最多觸發 5 次。"
  },
  RelicConfig_98395_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。造成主動傷害後對所有敵人造成 [Arg2] <IntoxicationIconKeywords:中毒>，每回合最多觸發 5 次。"
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:祭司權杖+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "不被許可的虔誠。"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 [Arg1]% 臨時傷害強效。"
  },
  RelicConfig_98396_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 [Arg1]% 臨時傷害強效。"
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:萬花筒>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "所思所見皆為幻象。"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_98397_Desc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:精密計時器+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "人類有史以來最邪惡的發明之一。"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "戰鬥開始時使所有敵人失去 [Arg1] 臨時<ExhaustionIconKeywords:力量>。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98398_Desc = {
    Text = "戰鬥開始時使所有敵人失去 [Arg1] 臨時<ExhaustionIconKeywords:力量>。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "殺人越貨撓癢癢的絕佳工具。"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_98399_Desc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:精密計時器>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "人類有史以來最邪惡的發明之一。"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時力量 ，每回合最多觸發 15 次。"
  },
  RelicConfig_98400_Desc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時<PowerIconKeywords:力量> ，每回合最多觸發 15 次。"
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:寂靜序曲+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "著名小提琴家埃裡克·艾克施坦因的提琴。\n如今，它已不可再奏響。"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每回合首次獲得反擊後，獲得 [Arg2] 算力。"
  },
  RelicConfig_98401_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每回合首次獲得<RetaliateIconKeywords:反擊>後，獲得 [Arg2] 算力。"
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:普特尼晨報+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "您最貼心的馬桶伴侶。"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  RelicConfig_98402_Desc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:潛水頭盔+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "夢想是星辰大海！"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] 力量。每打出一張帶有 「消耗」 的牌就獲得 [Arg2] 臨時力量，每回合最多觸發 10 次。"
  },
  RelicConfig_98403_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。每打出一張帶有 「消耗」 的牌就獲得 [Arg2] 臨時<PowerIconKeywords:力量>，每回合最多觸發 10 次。"
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:小音樂盒+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "德克斯特的宅邸中有許多藏品，在被摔壞前，小音樂盒曾是德克斯特小小姐最喜歡的玩具。\n時光荏苒，當德克斯特小姐再次找到她時，她齒輪鬆弛、音樂變調，卻仍未停止旋轉。"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "釋放「狂氣爆發」獲得 [Arg1] 銀鑰能量。"
  },
  RelicConfig_98404_Desc = {
    Text = "釋放「狂氣爆發」獲得 [Arg1] 銀鑰能量。"
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:美麗瞬間>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "將須臾的美保存至永遠。"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98405_Desc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:伶牙俐齒+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "能說會道的不止商人，亦有虔信者。"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  RelicConfig_98406_Desc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:親愛的寶貝+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "木匠為妻子做了個栩栩如生的木偶，它將代替他們的兒子，在她腹中沉睡。"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  RelicConfig_98407_Desc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:幸運兔腳+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "對兔子來說，可就不那麼幸運了。"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_98408_Desc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:彩蛋時間>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "縱享歡樂，但不可食用。"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "戰鬥開始時使所有敵人失去 [Arg1] 臨時<ExhaustionIconKeywords:力量>。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98409_Desc = {
    Text = "戰鬥開始時使所有敵人失去 [Arg1] 臨時<ExhaustionIconKeywords:力量>。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "殺人越貨撓癢癢的絕佳工具。"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  RelicConfig_98410_Desc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:親愛的寶貝>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "木匠為妻子做了個栩栩如生的木偶，它將代替他們的兒子，在她腹中沉睡。"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "回合開始時，若銀鑰能量大於 [Arg1] ，則消耗 [Arg1] 點銀鑰能量將 1 張<DerivativeCardKeywords_115:「高級靈感」>置入手中。"
  },
  RelicConfig_98411_Desc = {
    Text = "回合開始時，若銀鑰能量大於 [Arg1] ，則消耗 [Arg1] 點銀鑰能量將 1 張<DerivativeCardKeywords_115:「高級靈感」>置入手中。"
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:噩夢表像>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "小心，放縱的深眠會在你不知道的時候吞噬一切。"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "每釋放 5 次「狂氣爆發」，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  RelicConfig_98412_Desc = {
    Text = "每釋放 5 次「狂氣爆發」，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "遊走於繁星之間。"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。受到傷害後獲得 [Arg2] 反擊，每回合最多觸發 3 次。"
  },
  RelicConfig_98413_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。受到傷害後獲得 [Arg2] <RetaliateIconKeywords:反擊>，每回合最多觸發 3 次。"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "看來，他也沒能逃出去。"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  RelicConfig_98414_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:被遺忘者之血+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "日漸消融。"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "使用銀鑰覺醒後回覆 [Heal:Arg1] 生命、獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_98415_Desc = {
    Text = "使用銀鑰覺醒後回覆 [Heal:Arg1] 生命、獲得 [Arg2] 銀鑰能量。"
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:旅行陽傘+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "在無光之地綻放。"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每回合首次獲得反擊後，獲得 [Arg2] 算力。"
  },
  RelicConfig_98416_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每回合首次獲得<RetaliateIconKeywords:反擊>後，獲得 [Arg2] 算力。"
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:普特尼晨報>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "您最貼心的馬桶伴侶。"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_98417_Desc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:彩蛋時間+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "縱享歡樂，但不可食用。"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次施加中毒後，抽 [Arg2] 張牌。"
  },
  RelicConfig_98418_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次施加<IntoxicationIconKeywords:中毒>後，抽 [Arg2] 張牌。"
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:萊茵德紙草書+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "下面請聽題：10個僧侶分6只麵包，請問他們各得多少？"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "每釋放 5 次「狂氣爆發」，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  RelicConfig_98419_Desc = {
    Text = "每釋放 5 次「狂氣爆發」，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "遊走於繁星之間。"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98420_Desc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:三棱鏡+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "「光由七種色彩構成。」"
  },
  RelicConfig_98421_BattleDesc = {
    Text = "使用銀鑰覺醒後使手中算力最高的 [Arg1] 張卡牌在下次打出前獲得保留和預備，獲得 [Arg2] 點銀鑰能量。"
  },
  RelicConfig_98421_Desc = {
    Text = "使用銀鑰覺醒後使手中算力最高的 [Arg1] 張卡牌在下次打出前獲得保留和預備，獲得 [Arg2] 點銀鑰能量。"
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:異鄉郵票夾+>"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_98422_Desc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "不再象徵公正。"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。造成主動傷害後對所有敵人造成 [Arg2] 中毒，每回合最多觸發 5 次。"
  },
  RelicConfig_98423_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。造成主動傷害後對所有敵人造成 [Arg2] <IntoxicationIconKeywords:中毒>，每回合最多觸發 5 次。"
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:祭司權杖>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "不被許可的虔誠。"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次施加中毒後，抽 [Arg2] 張牌。"
  },
  RelicConfig_98424_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次施加<IntoxicationIconKeywords:中毒>後，抽 [Arg2] 張牌。"
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:萊茵德紙草書>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "下面請聽題：10個僧侶分6只麵包，請問他們各得多少？"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "戰鬥開始時獲得 [Arg1] 力量。每打出一張帶有 「消耗」 的牌就獲得 [Arg2] 臨時力量，每回合最多觸發 10 次。"
  },
  RelicConfig_98425_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] <PowerIconKeywords:力量>。每打出一張帶有 「消耗」 的牌就獲得 [Arg2] 臨時<PowerIconKeywords:力量>，每回合最多觸發 10 次。"
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:小音樂盒>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "德克斯特的宅邸中有許多藏品，在被摔壞前，小音樂盒曾是德克斯特小小姐最喜歡的玩具。\n時光荏苒，當德克斯特小姐再次找到她時，她齒輪鬆弛、音樂變調，卻仍未停止旋轉。"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  RelicConfig_98426_Desc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:小黃螺>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "這只小黃螺出身高貴，有著完美的、無可挑剔的來源。"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "回合開始時若生命低於 50%，臨時傷害強效 +[Arg1]%，若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  RelicConfig_98427_Desc = {
    Text = "回合開始時若生命低於 50%，臨時傷害強效 +[Arg1]%，若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:醫生手提箱+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "象徵醫生身分的手提箱，十分沉重。\n打開它的，未必是真的醫生。"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "戰鬥開始後，獲得 5 層「<LostWay:迷失>」，每打出 3 張指令卡後減少 1 層。\n所有「<LostWay:迷失>」被移除後，所有喚醒體獲得 100 點狂氣，每打出 3 張指令卡後回復 [Arg1] 點生命，對前排敵方施加敵方最大生命 1% 的<Corrosion:侵蝕>。"
  },
  RelicConfig_98891_Desc = {
    Text = "戰鬥開始後，獲得 5 層「<LostWay:迷失>」，每打出 3 張指令卡後減少 1 層。\n所有「<LostWay:迷失>」被移除後，所有喚醒體獲得 100 點狂氣，每打出 3 張指令卡後回復 [Arg1] 點生命，對前排敵方施加敵方最大生命 1% 的<Corrosion:侵蝕>。"
  },
  RelicConfig_98891_Name = {
    Text = "救世聖燈"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "縱使經歷暗淡，救世的提燈終將於死亡中再度長明。"
  }
})
return Text_RelicConfig
