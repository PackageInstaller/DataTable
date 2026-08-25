__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerPotency = readonly({
  AwakerPotency_122466_PotencyDesc = {
    Text = "茉夏自身、命輪、密契每擁有 1％ 死亡抵抗就提高 0.15% 暴擊率與暴擊傷害，每次觸發死亡抵抗「霧境旅人」提供的暴擊傷害本場戰鬥提高一倍。"
  },
  AwakerPotency_122466_PotencyName = {
    Text = "霧境旅人"
  },
  AwakerPotency_122471_PotencyDesc = {
    Text = "「人間爆破」生成 1 張上一次打出的其他「打擊」的臨時複製並使其算力消耗 -1。"
  },
  AwakerPotency_122474_PotencyDesc = {
    Text = "「閃耀☆龍捲風」使本回合茉夏傷害次數 +1。"
  },
  AwakerPotency_122474_PotencyName = {
    Text = "劈出一個未來"
  },
  AwakerPotency_122475_PotencyDesc = {
    Text = "傷害次數 +1，本場戰鬥每觸發 1 次「死亡抵抗」額外 +1。使打出的下一張「風暴衝擊」基礎算力消耗變為 0。若為本場戰鬥首次釋放，額外「昏迷」全體敵方。"
  },
  AwakerPotency_122475_PotencyName = {
    Text = "龍捲風世界大崩毀☆！"
  },
  AwakerPotency_122479_PotencyDesc = {
    Text = "靈知覺醒「霧境遺脈」獲得強化，打出時額外生成 1 張臨時「人間爆破」並使這 2 張「人間爆破」的算力消耗變為 0。茉夏的天賦「戲劇性邂逅」每回合觸發次數上限提高為 5。"
  },
  AwakerPotency_122479_PotencyName = {
    Text = "穿透迷霧的自我"
  },
  AwakerPotency_125349_PotencyDesc = {
    Text = "靈知覺醒「不夢鄉之主」獲得強化，「痴醉」上限提高為 15，徐每回合首次打出的指令卡額外生效 1 次。"
  },
  AwakerPotency_125356_PotencyDesc = {
    Text = "「入骨相思」胚胎融合 +15。徐自身、命輪、密契每擁有 1% 傷害強效，「入骨相思」獲得的胚胎融合 +0.2。"
  },
  AwakerPotency_125359_PotencyDesc = {
    Text = "「痴醉」上限由 5 提高為 10。「夜霧下的情誓」使自身下次觸發的「共鳴」效果翻倍。"
  },
  AwakerPotency_125359_PotencyName = {
    Text = "極樂之吻"
  },
  AwakerPotency_125360_PotencyDesc = {
    Text = "胚胎融合 +100。選擇「相許」時施加的「中毒」和「痴醉」變為 3 倍，選擇「奪魄」時每移除 1 層積攢 20％ 體質的猩紅熔爐。"
  },
  AwakerPotency_125361_PotencyDesc = {
    Text = "「打擊」和「防禦」獲得共鳴 3：額外獲得 15 點狂氣。"
  },
  AwakerPotency_125361_PotencyName = {
    Text = "扇與鐮刀"
  },
  AwakerPotency_13057_PotencyDesc = {
    Text = "靈知覺醒「自我封鎖」獲得強化，打出時立即使狂氣最低其他喚醒體獲得 80 點狂氣。"
  },
  AwakerPotency_13057_PotencyName = {
    Text = "離群者說"
  },
  AwakerPotency_13058_PotencyDesc = {
    Text = "「整裝待發」觸發反擊倍率 +50%，釋放後自身免疫脆弱、虛弱、易傷 1 回合。"
  },
  AwakerPotency_13058_PotencyName = {
    Text = "模糊的夢想"
  },
  AwakerPotency_13059_PotencyDesc = {
    Text = "「基礎防禦」抽 1 張牌。每 3 回合，將 1 張附加虛無和消耗的「腺體分裂」加入手中。"
  },
  AwakerPotency_13059_PotencyName = {
    Text = "笑呵呵玩樂"
  },
  AwakerPotency_13060_PotencyDesc = {
    Text = "「等價交換」基礎回復生命和棄牌回復生命效果提高 20%，每棄掉 1 張牌，額外回復生命同時並獲得等量的護盾。"
  },
  AwakerPotency_13060_PotencyName = {
    Text = "逃離死亡"
  },
  AwakerPotency_13063_PotencyDesc = {
    Text = "「基礎打擊」享受 2 倍力量加成，獲得躍遷：獲得 1 點算力。「基礎防禦」獲得等同於攻擊力 [Arg1]% 的力量，獲得躍遷：獲得 1 點算力。"
  },
  AwakerPotency_13063_PotencyName = {
    Text = "無限通道"
  },
  AwakerPotency_13064_PotencyDesc = {
    Text = "使寧菲亞造成的中毒提高 50%、持續 3 回合。"
  },
  AwakerPotency_13064_PotencyName = {
    Text = "永淪深海的葬儀"
  },
  AwakerPotency_13074_PotencyDesc = {
    Text = "使 1 條觸腕攻擊 5 次、獲得 25% 造成傷害的反擊。"
  },
  AwakerPotency_13074_PotencyName = {
    Text = "倔強意志"
  },
  AwakerPotency_13080_PotencyDesc = {
    Text = "「古老的愛撫」獲得的力量提高 50%，「聖血的本能」選擇效果翻倍。"
  },
  AwakerPotency_13080_PotencyName = {
    Text = "隱入林中"
  },
  AwakerPotency_13081_PotencyDesc = {
    Text = "「基礎防禦」使希洛獲得 25% 臨時暴擊率。"
  },
  AwakerPotency_13081_PotencyName = {
    Text = "聖子半身"
  },
  AwakerPotency_13082_PotencyDesc = {
    Text = "「基礎打擊」獲得等同於墨菲攻擊力 [Arg1]% 的觸腕傷害，「基礎防禦」獲得等同於墨菲攻擊力 [Arg2]% 的觸腕傷害。（效果隨「打擊」和「防禦」的等級提升）"
  },
  AwakerPotency_13082_PotencyName = {
    Text = "無法剝離之血"
  },
  AwakerPotency_13083_PotencyDesc = {
    Text = "「通通消失！」每洗入 1 張牌，奇術師獲得 3 點狂氣。"
  },
  AwakerPotency_13083_PotencyName = {Text = "讀心術"},
  AwakerPotency_13084_PotencyDesc = {
    Text = "「失落的藝術」基礎傷害與護盾提高25% ，額外享受 25% 暴擊率與暴擊傷害加成。"
  },
  AwakerPotency_13084_PotencyName = {
    Text = "藝術狂歡"
  },
  AwakerPotency_13085_PotencyDesc = {
    Text = "「隔空取物」獲得「餘波」：將 1 張「靈感」洗入抽牌堆。"
  },
  AwakerPotency_13086_PotencyDesc = {
    Text = "「基礎打擊」的目標每有 1 層易傷狀態，胚胎融合+5，最多 30。"
  },
  AwakerPotency_13086_PotencyName = {
    Text = "目擊證人"
  },
  AwakerPotency_13087_PotencyDesc = {
    Text = "靈知覺醒「翡翠映像」獲得強化，莉茲每造成 3 次傷害還會使莉茲本場戰鬥造成的傷害提高攻擊力的 15%。"
  },
  AwakerPotency_13087_PotencyName = {
    Text = "燃燒的致禮"
  },
  AwakerPotency_130903_PotencyDesc = {
    Text = "「深淵！漩渦！炮！」對生命最高的敵人造成的傷害由雙倍提高為三倍、每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。"
  },
  AwakerPotency_130903_PotencyName = {
    Text = "受縛的衝動"
  },
  AwakerPotency_130904_PotencyDesc = {
    Text = "「渦！流！彈！」還會造成目標最大生命值 0.5% 純粹傷害，釋放「深淵！漩渦！炮！」後界域精通 +50。莫絲自身、命輪、密契每擁有 1 點界域精通，「渦！流！彈！」額外造成目標最大生命值 0.005% 的純粹傷害，釋放「深淵！漩渦！炮！」後界域精通 +0.5。"
  },
  AwakerPotency_130904_PotencyName = {
    Text = "不息的潮湧"
  },
  AwakerPotency_130910_PotencyDesc = {
    Text = "靈知覺醒「漩渦來了」獲得強化，莫絲釋放追擊後下次莫絲狂氣爆發觸腕傷害加成額外提高 50%，並使下次狂氣爆發對生命最高敵人造成 1% 最大生命值的純粹傷害，最多疊加 5 次。"
  },
  AwakerPotency_130910_PotencyName = {
    Text = "砰——！嘣——！轟——！"
  },
  AwakerPotency_130914_PotencyDesc = {
    Text = "莫絲的「打擊」和「防禦」使下次莫絲狂氣爆發暴擊率 +10%，下次「裝填」基礎算力消耗降低 1。"
  },
  AwakerPotency_130914_PotencyName = {
    Text = "轟鳴的深淵"
  },
  AwakerPotency_130916_PotencyDesc = {
    Text = "每犧牲 1 條觸腕提升的暴擊傷害翻倍。接下來釋放的 5 次「漩！流！彈！」生效 2 次。"
  },
  AwakerPotency_130916_PotencyName = {
    Text = "默斯克斯！大！轟！炸"
  },
  AwakerPotency_13093_PotencyDesc = {
    Text = "靈知覺醒「庇佑之力」獲得強化，觸發「不死的極樂鳥」復活時立即獲得希萊斯特攻擊力 150% 的臨時觸腕傷害，首領戰效果翻倍。"
  },
  AwakerPotency_13093_PotencyName = {
    Text = "空想的卡修利亞"
  },
  AwakerPotency_13098_PotencyDesc = {
    Text = "靈知覺醒「紅祭禮」獲得強化，尤烏哈希狂氣爆發最終傷害提高 35％，生命低於 25％ 時效果翻倍。"
  },
  AwakerPotency_13098_PotencyName = {
    Text = "戾狂的讚歌"
  },
  AwakerPotency_13106_PotencyDesc = {
    Text = "靈知覺醒「渴血者」獲得強化，打出雷婭的卡牌後，使下次狂氣爆發得到強化：獲得等同於當前永久力量 10% 的臨時力量，最多堆疊 5 次。"
  },
  AwakerPotency_13106_PotencyName = {
    Text = "不癒的渴求"
  },
  AwakerPotency_13107_PotencyDesc = {
    Text = "「基礎打擊」獲得 50% 傷害的臨時反擊。「基礎防禦」獲得等同於攻擊力 [Arg1]% 的反擊。"
  },
  AwakerPotency_13109_PotencyDesc = {
    Text = "達芙黛爾以任意方式擊殺敵人後，使隊伍在本次關卡中暴擊率永久提高 5%。"
  },
  AwakerPotency_13109_PotencyName = {
    Text = "貪婪灰霧"
  },
  AwakerPotency_13115_PotencyDesc = {
    Text = "「灼燃蠟滴之欲」獲得 20 點狂氣。"
  },
  AwakerPotency_13120_PotencyDesc = {
    Text = "每當進行吞噬時，將「小小願望」從棄牌堆置入手牌，並使其算力消耗變為 0 點。"
  },
  AwakerPotency_13120_PotencyName = {
    Text = "夜空飛鳥"
  },
  AwakerPotency_13123_PotencyDesc = {
    Text = "「逆鱗之護」護盾提高 20%，並獲得保留。"
  },
  AwakerPotency_13123_PotencyName = {
    Text = "鱗刺聚合"
  },
  AwakerPotency_13124_PotencyDesc = {
    Text = "靈知覺醒「復仇預行」獲得強化，戈利亞在怒濤姿態下額外享受 300% 力量加成。"
  },
  AwakerPotency_13124_PotencyName = {
    Text = "暴君的登臨"
  },
  AwakerPotency_13127_PotencyDesc = {
    Text = "「告死之舞」每棄掉 2 張牌就抽 1 張牌。"
  },
  AwakerPotency_13127_PotencyName = {
    Text = "最終黎明"
  },
  AwakerPotency_13129_PotencyDesc = {
    Text = "將附加虛無和消耗的「尖嘯吧、血！」填滿手牌、本回合尤烏哈希傷害次數提高 1。"
  },
  AwakerPotency_13129_PotencyName = {
    Text = "血湧的饋贈"
  },
  AwakerPotency_13136_PotencyDesc = {
    Text = "靈知覺醒「目見母親」獲得強化，泰旖絲的狂氣爆發額外複製 1 張所選卡牌。"
  },
  AwakerPotency_13136_PotencyName = {
    Text = "源生萬物的胎海"
  },
  AwakerPotency_13142_PotencyDesc = {
    Text = "「沸騰吧，血！」基礎傷害提高 33%，生命低於 25% 時，額外造成 2 次傷害。"
  },
  AwakerPotency_13142_PotencyName = {
    Text = "羅馬悲歌"
  },
  AwakerPotency_13144_PotencyDesc = {
    Text = "「基礎打擊」與「能量射線」造成的傷害享受 50% 反擊加成。"
  },
  AwakerPotency_13144_PotencyName = {
    Text = "黑暗恐懼"
  },
  AwakerPotency_13145_PotencyDesc = {
    Text = "靈知覺醒「凝滯詛咒」獲得強化，艾繼絲釋放狂氣爆發後使自身下一張「防禦」生效 3 次，額外使狂氣爆發基礎傷害提高 50%。"
  },
  AwakerPotency_13145_PotencyName = {
    Text = "凝刻的眼淚"
  },
  AwakerPotency_13146_PotencyDesc = {
    Text = "對所有敵人額外追加 1 次 15% 目標最大生命值的純粹傷害。本場戰鬥中「混沌之獸」的基礎傷害提高 100%。"
  },
  AwakerPotency_13146_PotencyName = {
    Text = "直至星球終結"
  },
  AwakerPotency_13152_PotencyDesc = {
    Text = "探索開始時獲得 15 黑印，萊克每有 1% 黑印掉落就使獲得量提高 1%，且會增加「贏家通吃」進度。"
  },
  AwakerPotency_13153_PotencyDesc = {
    Text = "「應選之人」使界域精通提高 20 點，獲得預備 1 和保留。"
  },
  AwakerPotency_13153_PotencyName = {
    Text = "最終降臨"
  },
  AwakerPotency_13157_PotencyDesc = {
    Text = "無需消耗夢引、同時觸發「催眠脈絡」、「深眠反擊」和「喃喃自語的回音」。"
  },
  AwakerPotency_13157_PotencyName = {
    Text = "迷途夢引"
  },
  AwakerPotency_13161_PotencyDesc = {
    Text = "「血鏈·希洛」暴擊傷害 +35%。臨時手牌上限+2。將 1 張「恨意宣洩」和「鮮血鏈條」置入手中、並使它們算力消耗-1。"
  },
  AwakerPotency_13165_PotencyDesc = {
    Text = "「魔術嘉年華」額外抽 1 張牌，抽到症狀或狀態卡也會對隨機敵人造成 1 次傷害。"
  },
  AwakerPotency_13174_PotencyDesc = {
    Text = "靈知覺醒「參數擬合」獲得強化，艾瑞卡每次釋放狂氣爆發後使狂氣爆發享受的力量與戒備加成額外提高 1 倍。"
  },
  AwakerPotency_13174_PotencyName = {
    Text = "終結協議"
  },
  AwakerPotency_13175_PotencyDesc = {
    Text = "「斬首重創」每有 1 條觸腕，就使「斬首重創」的力量加成提高 1 倍。"
  },
  AwakerPotency_13176_PotencyDesc = {
    Text = "靈知覺醒「靈魂瘟疫」獲得強化，每層「終末」提高 8% 隊伍傷害強效，「虛無終結」使所有喚醒體獲得 30% 基礎狂氣。"
  },
  AwakerPotency_13176_PotencyName = {
    Text = "諸世皆沉"
  },
  AwakerPotency_13177_PotencyDesc = {
    Text = "回合結束時，每有 1 張手牌，觸發所有敵人 3% 的中毒，並獲得 3 點狂氣。"
  },
  AwakerPotency_13177_PotencyName = {
    Text = "微弱燭光"
  },
  AwakerPotency_13180_PotencyDesc = {
    Text = "「基礎打擊」使「血鏈·希洛」獲得 15% 臨時暴擊率和暴擊傷害。「基礎防禦」觸發所有敵人 15% 的出血。"
  },
  AwakerPotency_13180_PotencyName = {
    Text = "無盡殺戮"
  },
  AwakerPotency_13181_PotencyDesc = {
    Text = "當前生命低於 50% 時，「黑沼禁域」額外獲得 1 次護盾，造成的中毒翻倍。"
  },
  AwakerPotency_13182_PotencyDesc = {
    Text = "「基礎打擊」獲得等同於 [Arg1]% 攻擊力的反擊。"
  },
  AwakerPotency_13182_PotencyName = {
    Text = "空白的過去"
  },
  AwakerPotency_13185_PotencyDesc = {
    Text = "「恣睢之浪」視為「打擊」，獲得的力量翻倍。"
  },
  AwakerPotency_13185_PotencyName = {
    Text = "昂揚的戰意"
  },
  AwakerPotency_131866_PotencyDesc = {
    Text = "使複製的所有「技能」額外生效 1 次。"
  },
  AwakerPotency_131866_PotencyName = {
    Text = "獨屬於你的樂園"
  },
  AwakerPotency_131868_PotencyDesc = {
    Text = "沙耶的「基礎打擊」、「基礎防禦」額外使胚胎融合 +15，當前生命越低則效果越高，至多提高 100%。"
  },
  AwakerPotency_131868_PotencyName = {
    Text = "你會一直陪著我嗎"
  },
  AwakerPotency_131870_PotencyDesc = {
    Text = "「肉脂爛漫」額外造成目標最大生命值 0.5% 的侵蝕。「沙耶之歌」每消耗 1 層「羽種」，下一次打出「肉脂爛漫」就額外抽 1 張牌。"
  },
  AwakerPotency_131870_PotencyName = {
    Text = "這就是所謂的愛吧"
  },
  AwakerPotency_131872_PotencyDesc = {
    Text = "靈知覺醒「認知改造」獲得強化，使用「猩紅熔爐」後沙耶獲得 50 狂氣和 1 層「羽種」。"
  },
  AwakerPotency_131872_PotencyName = {
    Text = "最後送給你的禮物"
  },
  AwakerPotency_131875_PotencyDesc = {
    Text = "沙耶狂氣爆發基礎護盾提高 5% ，「肉脂爛漫」造成的基礎侵蝕提高 10%。沙耶自身、裝備的命輪與密契每提供 1% 黑印掉落屬性，沙耶狂氣爆發基礎護盾提高 0.25%，「肉脂爛漫」造成的基礎侵蝕額外提高 0.5%。"
  },
  AwakerPotency_131875_PotencyName = {
    Text = "為你變成怪物就好"
  },
  AwakerPotency_13187_PotencyDesc = {
    Text = "獲得的力量提升 100%、所有喚醒體的暴擊率與暴擊傷害提升 10%。"
  },
  AwakerPotency_13187_PotencyName = {
    Text = "蒼白的血吻"
  },
  AwakerPotency_13200_PotencyDesc = {
    Text = "本次狂氣爆發傷害次數變為三倍。之後 5 次打出卡茜亞的指令卡後，獲得攻擊力 10% 的力量。"
  },
  AwakerPotency_13200_PotencyName = {
    Text = "縱情歡笑"
  },
  AwakerPotency_13205_PotencyDesc = {
    Text = "「苦痛於歡愉」基礎傷害提高 100% 且造成穿刺傷害，獲得保留。"
  },
  AwakerPotency_13206_PotencyDesc = {
    Text = "「美的憐憫」每有 1 條觸腕，額外獲得等同於防禦力 [Arg1]% 的護盾。（效果隨「美的憐憫」的等級提升）"
  },
  AwakerPotency_13206_PotencyName = {
    Text = "匍匐於美"
  },
  AwakerPotency_13207_PotencyDesc = {
    Text = "「臨戰體勢」視為「防禦」。"
  },
  AwakerPotency_13207_PotencyName = {
    Text = "固守陣地"
  },
  AwakerPotency_13209_PotencyDesc = {
    Text = "獲得 24 點界域精通、「24」的下一張指令卡生效 3 次。"
  },
  AwakerPotency_13209_PotencyName = {
    Text = "畸變的解剖"
  },
  AwakerPotency_13215_PotencyDesc = {
    Text = "「獻媚者之擁」觸發吞噬時，獲得的力量翻倍。"
  },
  AwakerPotency_13215_PotencyName = {
    Text = "地下室手記"
  },
  AwakerPotency_13218_PotencyDesc = {
    Text = "靈知覺醒「信仰的見證」獲得強化，每翻轉 2 張「聖禮」將一張「神國幻影」置入手中。"
  },
  AwakerPotency_13218_PotencyName = {
    Text = "故國甦生"
  },
  AwakerPotency_13219_PotencyDesc = {
    Text = "「基礎防禦」獲得的護盾提高 25%，獲得與護盾等量的反擊。"
  },
  AwakerPotency_13221_PotencyDesc = {
    Text = "回合開始時獲得 10% 最大生命的忍耐。「淤泥上的不滅之花」和「報償打擊」僅移除一半忍耐。"
  },
  AwakerPotency_13221_PotencyName = {
    Text = "永不遺忘"
  },
  AwakerPotency_13222_PotencyDesc = {
    Text = "靈知覺醒「活屍夢囈」獲得強化，旺達釋放狂氣爆發後自身下 2 張指令卡額外生效 1 次。"
  },
  AwakerPotency_13225_PotencyDesc = {
    Text = "靈知覺醒「絕佳運氣」獲得強化，立即額外獲得或升級 1 次「混沌的遺贈」，並使萊克的所有六面骰變化為八面骰。"
  },
  AwakerPotency_13225_PotencyName = {Text = "大滿貫"},
  AwakerPotency_13226_PotencyDesc = {
    Text = "「豐穰之儀」還會使本次置入手中的原始複製算力消耗 -1。"
  },
  AwakerPotency_13226_PotencyName = {
    Text = "混沌之種"
  },
  AwakerPotency_13227_PotencyDesc = {
    Text = "「受祝骨血」胚胎融合 +15，積攢的猩紅熔爐回復量隨回合數提高，每回合提高等同於體質 [Arg1]%（隨「受祝骨血」等級提高而提高）；「應消之苦」暴擊率提高 25%，獲得「預備1」。"
  },
  AwakerPotency_13227_PotencyName = {
    Text = "創生之語"
  },
  AwakerPotency_13229_PotencyDesc = {
    Text = "「不耐的施捨」使手中算力消耗最高的 1 張卡牌在本回合中算力消耗 -1。"
  },
  AwakerPotency_13231_PotencyDesc = {
    Text = "「狂想詩篇」<VulnerabilityIconKeywords:易傷>全體敵方 1 回合，「哀慟詩篇」<WeaknessIconKeywords:虛弱>全體敵方 1 回合。"
  },
  AwakerPotency_13231_PotencyName = {
    Text = "蜷於烈火"
  },
  AwakerPotency_13233_PotencyDesc = {
    Text = "「攻勢推演」所抽的牌每有 1 點算力消耗，額外獲得 35 點銀鑰充能"
  },
  AwakerPotency_132345_PotencyDesc = {
    Text = "「腺體分裂」和「喧囂海洋」基礎傷害提高 100%，造成穿刺傷害。"
  },
  AwakerPotency_132345_PotencyName = {
    Text = "兩極之啟"
  },
  AwakerPotency_132349_PotencyDesc = {
    Text = "「同伴的力量」額外抽 1 張牌。"
  },
  AwakerPotency_132349_PotencyName = {
    Text = "天元之啟"
  },
  AwakerPotency_132350_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_132355_PotencyDesc = {
    Text = "「基礎防禦」抽 1 張牌。每 3 回合，將 1 張附加虛無和消耗的「腺體分裂」加入手中。"
  },
  AwakerPotency_132355_PotencyName = {
    Text = "三相之啟"
  },
  AwakerPotency_13236_PotencyDesc = {
    Text = "回合開始時回覆等同於朵爾 [Arg1]% 體質的生命、持續 3 回合。（效果隨「理性、真理與現實」的等級提升）"
  },
  AwakerPotency_132378_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_132383_PotencyDesc = {
    Text = "「腺體分裂」和「喧囂海洋」基礎傷害提高 100%，造成穿刺傷害。"
  },
  AwakerPotency_132383_PotencyName = {
    Text = "兩極之啟"
  },
  AwakerPotency_132384_PotencyDesc = {
    Text = "「腺體分裂」和「喧囂海洋」基礎傷害提高 100%，造成穿刺傷害。"
  },
  AwakerPotency_132384_PotencyName = {
    Text = "兩極之啟"
  },
  AwakerPotency_132385_PotencyDesc = {
    Text = "「同伴的力量」額外抽 1 張牌。"
  },
  AwakerPotency_132385_PotencyName = {
    Text = "天元之啟"
  },
  AwakerPotency_132387_PotencyDesc = {
    Text = "「同伴的力量」額外抽 1 張牌。"
  },
  AwakerPotency_132387_PotencyName = {
    Text = "天元之啟"
  },
  AwakerPotency_132389_PotencyDesc = {
    Text = "「同伴的力量」額外抽 1 張牌。"
  },
  AwakerPotency_132389_PotencyName = {
    Text = "天元之啟"
  },
  AwakerPotency_132393_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_132398_PotencyDesc = {
    Text = "「基礎防禦」抽 1 張牌。每 3 回合，將 1 張附加虛無和消耗的「腺體分裂」加入手中。"
  },
  AwakerPotency_132398_PotencyName = {
    Text = "三相之啟"
  },
  AwakerPotency_132404_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_132410_PotencyDesc = {
    Text = "「基礎防禦」抽 1 張牌。每 3 回合，將 1 張附加虛無和消耗的「腺體分裂」加入手中。"
  },
  AwakerPotency_132410_PotencyName = {
    Text = "三相之啟"
  },
  AwakerPotency_132414_PotencyDesc = {
    Text = "「腺體分裂」和「喧囂海洋」基礎傷害提高 100%，造成穿刺傷害。"
  },
  AwakerPotency_132414_PotencyName = {
    Text = "兩極之啟"
  },
  AwakerPotency_132417_PotencyDesc = {
    Text = "「基礎防禦」抽 1 張牌。每 3 回合，將 1 張附加虛無和消耗的「腺體分裂」加入手中。"
  },
  AwakerPotency_132417_PotencyName = {
    Text = "三相之啟"
  },
  AwakerPotency_13243_PotencyDesc = {
    Text = "「自毀改造」選擇「興奮」時對所有敵人施加 1 回合易傷，選擇「詛咒」時對所有敵人施加 1 回合虛弱。"
  },
  AwakerPotency_13243_PotencyName = {
    Text = "北天來客"
  },
  AwakerPotency_13244_PotencyDesc = {
    Text = "「桀驁之刃」視為「打擊」。蘿坦的「打擊」基礎傷害提高 30%。"
  },
  AwakerPotency_13244_PotencyName = {
    Text = "不羈的劍風"
  },
  AwakerPotency_13245_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」額外獲得 5％ 基礎狂氣的狂氣。「虛無終結」的純粹傷害由 25％ 提高為 30％，額外回覆 30％ 已損生命。"
  },
  AwakerPotency_13245_PotencyName = {
    Text = "絕滅使臣"
  },
  AwakerPotency_13246_PotencyDesc = {
    Text = "「終點，真理與深淵之門」和「宿命坍縮」造成的基礎中毒量提高 50%，每擁有 1 層「終末」額外提高 15%，終末層數不再擁有堆疊上限。"
  },
  AwakerPotency_13246_PotencyName = {
    Text = "共振菌絲"
  },
  AwakerPotency_13255_PotencyDesc = {
    Text = "手牌上限+2，回合結束時選擇 1 張手牌獲得保留並使其算力消耗 -1，持續 3 回合。"
  },
  AwakerPotency_13261_PotencyDesc = {
    Text = "回合開始時獲得防禦力 60% 的護盾與 15% 攻擊力的觸腕傷害，生成 2 條臨時觸腕，持續 3 回合。"
  },
  AwakerPotency_13261_PotencyName = {
    Text = "自由誓願"
  },
  AwakerPotency_13271_PotencyDesc = {
    Text = "使索蕾爾接下來 3 張指令卡生效 2 次。本次狂氣爆發每造成 1 次傷害、回合結束時恢復等同於體質 [Arg1]% 點生命。"
  },
  AwakerPotency_13271_PotencyName = {
    Text = "無盡薔薇之慾"
  },
  AwakerPotency_13276_PotencyDesc = {
    Text = "「女王之劍」傷害次數+1，每次造成傷害時，獲得等同於攻擊力 [Arg1]% 的臨時力量。（效果隨「女王之劍」的等級提升）「女王之劍」棄掉後，獲得 300% 等同於拉蒙娜銀鑰充能的銀鑰能量。"
  },
  AwakerPotency_13276_PotencyName = {
    Text = "懵懂的啟程"
  },
  AwakerPotency_13280_PotencyDesc = {
    Text = "「蟾蜍燉菜」的中毒與回復生命效果提高 50%。"
  },
  AwakerPotency_13280_PotencyName = {
    Text = "在糖霜裡"
  },
  AwakerPotency_13283_PotencyDesc = {
    Text = "「電磁爆破」基礎傷害與護盾提升 100%。艾瑞卡的「基礎打擊」額外造成 1 次傷害，「基礎防禦」額外獲得 1 次護盾，持續 3 回合。"
  },
  AwakerPotency_13283_PotencyName = {
    Text = "多重計算"
  },
  AwakerPotency_13287_PotencyDesc = {
    Text = "將 3 張回覆提高 50% 的「純白夢境」置入手中並附加消耗。"
  },
  AwakerPotency_13289_PotencyDesc = {
    Text = "「基礎打擊」獲得：施加 50% 傷害的中毒。「基礎防禦」獲得：觸發所有敵人 25% 的中毒。"
  },
  AwakerPotency_13289_PotencyName = {
    Text = "不朽綠炎"
  },
  AwakerPotency_13291_PotencyDesc = {
    Text = "靈知覺醒「施與受」獲得強化，潘狄婭獲得永久反擊時獲得 3% 等量的力量。"
  },
  AwakerPotency_13291_PotencyName = {
    Text = "疼愛懲戒宣言"
  },
  AwakerPotency_13295_PotencyDesc = {
    Text = "將<DerivativeCardKeywords_43:「奇妙料理」>洗入抽牌堆和棄牌堆各 1 張。"
  },
  AwakerPotency_13295_PotencyName = {
    Text = "豐盛餐點"
  },
  AwakerPotency_13300_PotencyDesc = {
    Text = "靈知覺醒「海祭典儀」獲得強化，打出時立即獲得 2 層「命契」。若回合結束時處於「潮湧」姿態，額外獲得 1 層「命契」。"
  },
  AwakerPotency_13300_PotencyName = {
    Text = "天人感應"
  },
  AwakerPotency_13303_PotencyDesc = {
    Text = "每回合打出第一張詩篇時，奧爾拉獲得 10 點狂氣。「紛華篇章」對應情緒的效果提高由 150% 提高為 250%。"
  },
  AwakerPotency_13303_PotencyName = {
    Text = "花與詩的重逢"
  },
  AwakerPotency_13305_PotencyDesc = {
    Text = "每打出 1 張「靈感」就使達芙黛爾獲得 2 點狂氣，獲得等同於 1% 攻擊力的力量，每回合最多觸發 5 次。"
  },
  AwakerPotency_13305_PotencyName = {
    Text = "原質沉澱"
  },
  AwakerPotency_13306_PotencyDesc = {
    Text = "「破碎沉戟」獲得 [Arg1] 狂氣。（效果隨「破碎沉戟」的等級提升）"
  },
  AwakerPotency_13306_PotencyName = {
    Text = "血脈覺醒"
  },
  AwakerPotency_13307_PotencyDesc = {
    Text = "「永存的幻影」獲得保留，回復效果提高 25%。"
  },
  AwakerPotency_13307_PotencyName = {
    Text = "孤獨桅杆"
  },
  AwakerPotency_13312_PotencyDesc = {
    Text = "「未被滿足之痛」獲得 10 點狂氣。"
  },
  AwakerPotency_13312_PotencyName = {
    Text = "到陽光下"
  },
  AwakerPotency_13314_PotencyDesc = {
    Text = "獲得的護盾提升 200％，使本場戰鬥中「失落的藝術」和「基礎打擊」造成的傷害額外享受 100％ 護盾加成。"
  },
  AwakerPotency_13314_PotencyName = {
    Text = "珊瑚海之約"
  },
  AwakerPotency_13319_PotencyDesc = {
    Text = "「無止境的正義」使艾爾瓦獲得 50％ 臨時暴擊率和暴擊傷害。"
  },
  AwakerPotency_13319_PotencyName = {
    Text = "一切為了公正"
  },
  AwakerPotency_13320_PotencyDesc = {
    Text = "將 1 張附加消耗的「臨戰體勢」與「心眼利刃」置入手中。艾爾瓦本場戰鬥的暴擊傷害 +25%。"
  },
  AwakerPotency_13320_PotencyName = {
    Text = "公義與真理同在"
  },
  AwakerPotency_13322_PotencyDesc = {
    Text = "「精神重建」每棄掉 1 張牌，下回合獲得等同於防禦力 [Arg1]% 的護盾（效果隨「精神重建」的等級提升）。若觸發躍遷立即抽 1 張牌。"
  },
  AwakerPotency_13322_PotencyName = {
    Text = "遺失故土"
  },
  AwakerPotency_13328_PotencyDesc = {
    Text = "靈知覺醒「受造之物」獲得強化，墨菲每回合首次打出的「螺湮逆流」傷害次數和每回合首次打出的「聖女作成」獲得算力翻倍。"
  },
  AwakerPotency_13329_PotencyDesc = {
    Text = "選擇「篡奪」時、置入手中的「巨刃之威」基礎傷害提高 400%、算力消耗變為 0 。選擇「蟄伏」時、不再置入「巨刃之威」、改為將 2 張「斬首重創」置入手中、並使其獲得「消耗」「預備 1」和「保留」。"
  },
  AwakerPotency_13334_PotencyDesc = {
    Text = "釋放鑰令後，拉蒙娜臨時暴擊率提高 50％。「世界演繹法」將 1 張「靈感」洗入抽牌堆。"
  },
  AwakerPotency_13334_PotencyName = {
    Text = "珍貴的羈絆"
  },
  AwakerPotency_13336_PotencyDesc = {
    Text = "「靜默守望」最大可疊加次數提高至 3。"
  },
  AwakerPotency_13336_PotencyName = {
    Text = "女僕守則"
  },
  AwakerPotency_13337_PotencyDesc = {
    Text = "靈知覺醒「戰地卓識」獲得強化，艾爾瓦的指令卡每回合首次造成傷害後獲得防禦力 80% 的護盾。"
  },
  AwakerPotency_13337_PotencyName = {
    Text = "向烏托邦的征伐"
  },
  AwakerPotency_13339_PotencyDesc = {
    Text = "回合結束時墨菲獲得 5 點狂氣。釋放鑰令後，移除 2% 最大生命的「獻祭」。"
  },
  AwakerPotency_13339_PotencyName = {
    Text = "解放與自由之觸"
  },
  AwakerPotency_13341_PotencyDesc = {
    Text = "「綿音漸響」和「星彩極光」獲得暴擊率的同時，也會獲得等量的暴擊傷害。"
  },
  AwakerPotency_13341_PotencyName = {
    Text = "墜入高空"
  },
  AwakerPotency_13343_PotencyDesc = {
    Text = "「奇妙料理」有 50% 機率能夠隨機觸發一個奇妙效果，這些效果包括自身獲得 10 點狂氣，其他友方獲得 5 點狂氣、易傷所有敵人 1 回合，虛弱所有敵人 1 回合、 抽 1 張牌、獲得 200  點銀鑰能量。"
  },
  AwakerPotency_13343_PotencyName = {
    Text = "發酵料理書"
  },
  AwakerPotency_13349_PotencyDesc = {
    Text = "本場戰鬥內忍耐上限提升 100%、獲得等同於最大生命值的忍耐。將 2 張附加消耗的「報償打擊」置入手中。"
  },
  AwakerPotency_13349_PotencyName = {
    Text = "聽從所願"
  },
  AwakerPotency_13353_PotencyDesc = {
    Text = "靈知覺醒「戰欲難平」獲得強化，蘿坦打出「防禦」後本回合下一張「桀驁之刃」生效 2 次。"
  },
  AwakerPotency_13353_PotencyName = {
    Text = "亙古的鯨鳴"
  },
  AwakerPotency_13355_PotencyDesc = {
    Text = "「夜潮洶湧」造成的傷害提高 50%，每回合打出的前 3 張症狀卡，使「夜潮洶湧」在本場戰鬥中的傷害提高等同於攻擊力的 20％。"
  },
  AwakerPotency_13355_PotencyName = {
    Text = "無聲浸潤"
  },
  AwakerPotency_13358_PotencyDesc = {
    Text = "「螺湮逆流」獲得保留。每有 2 條觸腕額外造成 1 次傷害。"
  },
  AwakerPotency_13358_PotencyName = {
    Text = "隱忍的叛逆"
  },
  AwakerPotency_13361_PotencyDesc = {
    Text = "靈知覺醒「湮塞的執念」獲得強化，法洛思打出卡牌後使本回合觸腕造成等同於傷害 5％ 的中毒，最多生效 3 次。"
  },
  AwakerPotency_13361_PotencyName = {
    Text = "終至光輝彼岸"
  },
  AwakerPotency_13362_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使 1 條觸腕攻擊 2 次，但只造成 50％ 傷害。"
  },
  AwakerPotency_13362_PotencyName = {
    Text = "凝固鯨油"
  },
  AwakerPotency_13363_PotencyDesc = {
    Text = "血肉界域每回合自動獲得的胚胎融合提高 50%。「基礎打擊」和 「基礎防禦」獲得等同於攻擊力 3% 的力量。"
  },
  AwakerPotency_13365_PotencyDesc = {
    Text = "「基礎防禦」積攢等同於體質 [Arg1]% 的猩紅熔爐回復量（隨「防禦」等級提高而提高）。本場戰鬥每積攢 2 點猩紅熔爐回復量，就使「基礎打擊」傷害提高 1。"
  },
  AwakerPotency_13368_PotencyDesc = {
    Text = "靈知覺醒「索魂者宣言」獲得強化，血鏈希洛釋放狂氣爆發後，賦予手中每張不同的自身指令卡 50 層<TempPowerKeywords:臨時強化>，回合結束或打出後移除。"
  },
  AwakerPotency_13370_PotencyDesc = {
    Text = "「尖嘯吧，血！」基礎傷害和力量提高 30%。"
  },
  AwakerPotency_13370_PotencyName = {Text = "角鬥士"},
  AwakerPotency_13373_PotencyDesc = {
    Text = "「無止境的正義」抽牌數量 +1。"
  },
  AwakerPotency_13373_PotencyName = {
    Text = "永戰不怠"
  },
  AwakerPotency_13376_PotencyDesc = {
    Text = "靈知覺醒「靈肉兩分」獲得強化，造成的護盾效果提高 50%。朵爾的「打擊」和「防禦」也能觸發獲得護盾效果。"
  },
  AwakerPotency_13376_PotencyName = {
    Text = "重構自我"
  },
  AwakerPotency_13377_PotencyDesc = {
    Text = "對應情緒的效果加成提高為 600%。獲得 3 層萬能「隱喻」：會在下次詩篇躍遷時被視為任意情緒的「隱喻」使用並消耗。"
  },
  AwakerPotency_13377_PotencyName = {
    Text = "墨染成詩"
  },
  AwakerPotency_13381_PotencyDesc = {
    Text = "本次狂氣爆發造成的狂氣翻倍，所有喚醒體造成的中毒、反擊、基礎傷害提高 10％。若當前為首領戰，額外獲得 1 層「終末」。「終末形態」：每消耗 10 點狂氣，額外觸發所有敵人 3％ 的中毒。"
  },
  AwakerPotency_13381_PotencyName = {
    Text = "癲狂感染"
  },
  AwakerPotency_13388_PotencyDesc = {
    Text = "靈知覺醒「凸月之舞」獲得強化，回合結束時若保留了珈倫的指令卡，也會觸發 2 次回復生命和狂氣效果。"
  },
  AwakerPotency_13388_PotencyName = {
    Text = "霧月晚宴"
  },
  AwakerPotency_13392_PotencyDesc = {
    Text = "本場戰鬥每釋放 1 次「布朗出動！」，「鼠群衝擊」的基礎傷害就提高等同於攻擊力 [Arg1]% 的傷害。（效果隨「布朗出動！」的等級提升）"
  },
  AwakerPotency_13392_PotencyName = {
    Text = "紅色緞帶"
  },
  AwakerPotency_13393_PotencyDesc = {
    Text = "「基礎防禦」和「基礎打擊」觸發全體敵方 20％ 中毒。"
  },
  AwakerPotency_13393_PotencyName = {
    Text = "灰燼與頭顱"
  },
  AwakerPotency_13395_PotencyDesc = {
    Text = "靈知覺醒「詩冊序言」獲得強化，發動湮滅後奧爾拉本回合下一張指令卡觸發躍遷效果。每當奧爾拉消耗 3 層或以上隱喻，使當前情緒光環效果臨時提高 35％，無法疊加。"
  },
  AwakerPotency_13395_PotencyName = {
    Text = "餘燼裡的春天"
  },
  AwakerPotency_13406_PotencyDesc = {
    Text = "使所有敵人臨時降低等同於防禦力 [Arg1]% 的力量（隨星之搖籃等級提升而提升）。"
  },
  AwakerPotency_13406_PotencyName = {
    Text = "破繭而生的新芽"
  },
  AwakerPotency_13410_PotencyDesc = {
    Text = "額外獲得 24% 攻擊力的力量和觸腕傷害。之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  AwakerPotency_13419_PotencyDesc = {
    Text = "額外將 2 張「聖禮」置入手中、觸腕上限和觸腕數量 +1。"
  },
  AwakerPotency_13419_PotencyName = {
    Text = "未經他人之苦"
  },
  AwakerPotency_13426_PotencyDesc = {
    Text = "靈知覺醒「不朽威儀」獲得強化，圖魯釋放狂氣爆發後，所有敵人受到的觸腕傷害提高 10%，最多疊加 5 次。"
  },
  AwakerPotency_13427_PotencyDesc = {
    Text = "靈知覺醒「沉逝苦海」獲得強化，回合結束時寧菲亞造成的中毒額外提高 20％。"
  },
  AwakerPotency_13427_PotencyName = {
    Text = "神思歸流"
  },
  AwakerPotency_13430_PotencyDesc = {
    Text = "「無上生祭」使臨時暴擊傷害提高，數值等同於彌利亞姆原始暴擊傷害的 15%。"
  },
  AwakerPotency_13431_PotencyDesc = {
    Text = "靈知覺醒「熵增逆轉」獲得強化，不再限制每回合生效次數。環行·拉蒙娜打出觸發「回環」的卡牌後，獲得 50 點銀鑰能量。"
  },
  AwakerPotency_13431_PotencyName = {
    Text = "無限歸一奇點"
  },
  AwakerPotency_13434_PotencyDesc = {
    Text = "「脊刺鎖鏈」暴擊率提高 25%。「迷途之守」獲得的所有反擊提高 20%。"
  },
  AwakerPotency_13434_PotencyName = {Text = "啟示錄"},
  AwakerPotency_13435_PotencyName = {
    Text = "金蝴蝶回憶"
  },
  AwakerPotency_13436_PotencyDesc = {
    Text = "「基礎打擊」獲得圖魯攻擊力的 [Arg1]% 的臨時力量和臨時觸腕傷害，「基礎防禦」獲得圖魯攻擊力的 [Arg2]%的臨時力量和臨時觸腕傷害（效果隨「打擊」、「防禦」的等級提升）。"
  },
  AwakerPotency_13436_PotencyName = {
    Text = "復甦之觸"
  },
  AwakerPotency_13440_PotencyDesc = {
    Text = "靈知覺醒「騎士熱誠」獲得強化，奧吉爾通過「騎士熱誠」獲得的力量額外提高 50%。在本場戰鬥觸發死亡抵抗後，奧吉爾的狂氣爆發獲得的臨時力量提高為 3 倍。"
  },
  AwakerPotency_13440_PotencyName = {
    Text = "忠誠，誓死不渝"
  },
  AwakerPotency_13441_PotencyDesc = {
    Text = "「機能超載」獲得躍遷：同時具有傷害和護盾 2 個效果。"
  },
  AwakerPotency_13441_PotencyName = {Text = "再啟動"},
  AwakerPotency_13443_PotencyDesc = {
    Text = "「蜜糖色悲慘幻象」基礎傷害翻倍，並獲得等同於攻擊力 [Arg1]% 的反擊。"
  },
  AwakerPotency_13447_PotencyDesc = {
    Text = "靈知覺醒「迎客特權」獲得強化，索蕾爾每造成 1 次傷害使索蕾爾臨時最終傷害 +2%，其他喚醒體 +1%，每回合最多生效 15 次。"
  },
  AwakerPotency_13447_PotencyName = {
    Text = "緋紅盛綻"
  },
  AwakerPotency_13448_PotencyDesc = {
    Text = "靈知覺醒「界外之音」獲得強化，汀克特每回合首次打出「技能」時生成 1 張算力消耗為 0 的臨時「打擊」，該「打擊」的隨機效果變為 2 倍。"
  },
  AwakerPotency_13448_PotencyName = {
    Text = "當殷紅浸透荊棘"
  },
  AwakerPotency_13449_PotencyDesc = {
    Text = "「腐化綠炎」回合結束時若在手牌或超維空間，將會升級為「死滅綠炎」。"
  },
  AwakerPotency_13449_PotencyName = {
    Text = "翠色火種"
  },
  AwakerPotency_13452_PotencyDesc = {
    Text = "靈知覺醒「維度投射」獲得強化，打出時立即生成 1 張算力消耗為 0 的臨時「斷頸一擊」置入超維空間。"
  },
  AwakerPotency_13452_PotencyName = {Text = "死魂靈"},
  AwakerPotency_13453_PotencyDesc = {
    Text = "「強者為尊」在移除所有敵人力量的同時，額外獲得等同於移除量的臨時力量。"
  },
  AwakerPotency_13454_PotencyDesc = {
    Text = "回合結束時回復等同於體質 7.5% 的生命。"
  },
  AwakerPotency_13454_PotencyName = {
    Text = "不被接納之痛"
  },
  AwakerPotency_13460_PotencyDesc = {
    Text = "施加的「降生儀式」提高 5 層。生成 3 張算力消耗為 2 且附加「預備」和「消耗」的「螺湮圓舞」。"
  },
  AwakerPotency_13460_PotencyName = {
    Text = "萬劫輪回的天幕"
  },
  AwakerPotency_13464_PotencyDesc = {
    Text = "「基礎打擊」使希洛獲得 10% 暴擊傷害。"
  },
  AwakerPotency_13464_PotencyName = {
    Text = "斬斷鎖鏈之人"
  },
  AwakerPotency_13465_PotencyDesc = {
    Text = "「薔薇之美」基礎傷害提高 25%，每造成 1 次傷害，臨時暴擊率 +5%。"
  },
  AwakerPotency_13465_PotencyName = {Text = "佳釀"},
  AwakerPotency_13471_PotencyDesc = {
    Text = "提高當前護盾 50% 的效果變為無視護盾上限，觸發反擊倍率提高為 500％。"
  },
  AwakerPotency_13471_PotencyName = {
    Text = "引擎啟動！"
  },
  AwakerPotency_13475_PotencyDesc = {
    Text = "「霧都街童」額外獲得 1 張「布朗出動！」。"
  },
  AwakerPotency_13476_PotencyDesc = {
    Text = "「腺體分裂」和「喧囂海洋」基礎傷害提高 100%，造成穿刺傷害。"
  },
  AwakerPotency_13476_PotencyName = {
    Text = "滑溜溜冒險"
  },
  AwakerPotency_13479_PotencyDesc = {
    Text = "本回合所有喚醒體造成的最終傷害提高 25％。"
  },
  AwakerPotency_13479_PotencyName = {
    Text = "超越萬古的凝視"
  },
  AwakerPotency_13489_PotencyDesc = {
    Text = "<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合、下個釋放的鑰令生效 2 次。"
  },
  AwakerPotency_13489_PotencyName = {
    Text = "無限思維迷宮"
  },
  AwakerPotency_13495_PotencyDesc = {
    Text = "將手牌中所有的「綠炎」與「腐化綠炎」升級為「死滅綠炎」，之後 3 個回合，每回合開始時重複 1 次該效果。"
  },
  AwakerPotency_13495_PotencyName = {
    Text = "死兆降臨"
  },
  AwakerPotency_13502_PotencyDesc = {
    Text = "「海淵之力」選擇「篡奪」時，戈利亞獲得 25% 臨時暴擊率；選擇 「蟄伏」時，戈利亞獲得 25 點狂氣。"
  },
  AwakerPotency_13502_PotencyName = {
    Text = "無盡野望"
  },
  AwakerPotency_13505_PotencyDesc = {
    Text = "「無形遷移」造成的護盾和反擊提高 25%。使選擇的喚醒體本回合釋放 2 次狂氣爆發後才會進入冷卻。"
  },
  AwakerPotency_13505_PotencyName = {
    Text = "死而後生"
  },
  AwakerPotency_13509_PotencyDesc = {
    Text = "臨時手牌上限+2、並將 2 張「不規則形態」置入手中、希洛獲得 25% 暴擊傷害。"
  },
  AwakerPotency_13509_PotencyName = {
    Text = "以血還血"
  },
  AwakerPotency_13516_PotencyDesc = {
    Text = "靈知覺醒「第一哲學」獲得強化，每次生效時額外使拉蒙娜造成的基礎傷害提高 10%。"
  },
  AwakerPotency_13516_PotencyName = {
    Text = "至臻的淬煉"
  },
  AwakerPotency_13517_PotencyDesc = {
    Text = "「封閉創作」立即獲得等同於防禦力 [Arg1]% 的護盾。（效果隨「封閉創作」的等級提升）"
  },
  AwakerPotency_13522_PotencyDesc = {
    Text = "靈知覺醒「調停人格」獲得強化，「24」的指令卡人格效果加成翻倍。「24」釋放狂氣爆發後人格加成翻倍效果本回合失效。"
  },
  AwakerPotency_13523_PotencyDesc = {
    Text = "「基礎防禦」獲得 2 次護盾，並獲得躍遷：額外獲得 1 次狂氣。"
  },
  AwakerPotency_13527_PotencyDesc = {
    Text = "回合結束時圖魯獲得 5 點狂氣。「螺湮重臨」提高 15% 臨時暴擊率。"
  },
  AwakerPotency_13527_PotencyName = {
    Text = "群星歸位"
  },
  AwakerPotency_13530_PotencyDesc = {
    Text = "靈知覺醒「自我增殖」獲得強化，奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 3 次傷害。"
  },
  AwakerPotency_13530_PotencyName = {
    Text = "亮閃閃摯友"
  },
  AwakerPotency_13533_PotencyDesc = {
    Text = "「外域手術」虛弱回合數提高 1，治療量提高 33%。"
  },
  AwakerPotency_13533_PotencyName = {
    Text = "純粹理性"
  },
  AwakerPotency_13536_PotencyDesc = {
    Text = "獲得的護盾提升 200%、奧吉爾造成的傷害次數 +1、持續 3 回合。"
  },
  AwakerPotency_13536_PotencyName = {
    Text = "奉獻決心"
  },
  AwakerPotency_13538_PotencyDesc = {
    Text = "戰鬥開始時，將 1 張「不規則形態」置入手牌。"
  },
  AwakerPotency_13540_PotencyDesc = {
    Text = "靈知覺醒「迷途之旅」獲得強化，每回合中阿格里帕每造成或觸發 1 次中毒，回合結束獲得的護盾就提高 50%，最大 5 層，阿格里帕施加的中毒效果額外提高 50%。"
  },
  AwakerPotency_13540_PotencyName = {
    Text = "永不復還契約"
  },
  AwakerPotency_13544_PotencyDesc = {
    Text = "受到傷害轉化猩紅熔爐回覆量的效果提高 250％，「基礎打擊」與「應消之苦」額外享受 100％ 力量加成。本次探索內猩紅熔爐上限提高最大生命值的 2％，至多提高 10％。"
  },
  AwakerPotency_13544_PotencyName = {
    Text = "創生之祭"
  },
  AwakerPotency_13545_PotencyDesc = {
    Text = "每次觸發死亡抵抗時，對前排敵人觸發 100％ 反擊，本場戰鬥中每次觸發死亡抵抗，就使觸發反擊倍率 +25%。"
  },
  AwakerPotency_13545_PotencyName = {
    Text = "愛之搖籃"
  },
  AwakerPotency_13546_PotencyDesc = {
    Text = "靈知覺醒「復仇宣言」獲得強化，打出時立即使「破鏈一擊」的打擊加成和「綿長恨怨」的基礎傷害提高 50%。"
  },
  AwakerPotency_13546_PotencyName = {
    Text = "最後的審判者"
  },
  AwakerPotency_13555_PotencyDesc = {
    Text = "回合結束時，號令所有觸腕攻擊所有敵人 2 次。"
  },
  AwakerPotency_13555_PotencyName = {
    Text = "應許之日"
  },
  AwakerPotency_13558_PotencyDesc = {
    Text = "「血與沙的讚歌」每次吞噬力量加成額外提高 1 倍。"
  },
  AwakerPotency_13558_PotencyName = {
    Text = "巫師的末路"
  },
  AwakerPotency_13560_PotencyDesc = {
    Text = "靈知覺醒「賜福」獲得強化，「造主的庇佑」和「受祝骨血」積攢的猩紅熔爐提高 25％。「應消之苦」選擇「超度」時每消耗 1％ 最大生命的猩紅熔爐所提高的最終傷害效果從 2％ 提高為 5％。"
  },
  AwakerPotency_13560_PotencyName = {
    Text = "飼世的苦慈"
  },
  AwakerPotency_13561_PotencyDesc = {
    Text = "「基礎防禦」抽 2 張牌，若不是詹金的卡牌則將其丟棄。"
  },
  AwakerPotency_13561_PotencyName = {
    Text = "金蝴蝶回憶"
  },
  AwakerPotency_13562_PotencyDesc = {
    Text = "「蒼白迴旋」基礎傷害提高 50%，打出後使胚胎融合 +20。"
  },
  AwakerPotency_13565_PotencyDesc = {
    Text = "靈知覺醒「忘我之境」獲得強化，珊造成的最終傷害提高 15%，且每有 1 條永久觸腕都會使珊造成的護盾和最終傷害提高 3%。"
  },
  AwakerPotency_13565_PotencyName = {
    Text = "物我兩忘"
  },
  AwakerPotency_13566_PotencyDesc = {
    Text = "「基礎打擊」造成 2 次傷害，獲得 50% 傷害的臨時反擊。"
  },
  AwakerPotency_13566_PotencyName = {
    Text = "雙生之星"
  },
  AwakerPotency_13567_PotencyDesc = {
    Text = "每當使用鑰令時，環行拉蒙娜臨時暴擊率和臨時暴擊傷害 +25%。"
  },
  AwakerPotency_13567_PotencyName = {
    Text = "克萊因旅人"
  },
  AwakerPotency_13568_PotencyDesc = {
    Text = "狂氣爆發「悖論收束」選擇一個任意已解鎖的鑰令替換當前的鑰令，使用鑰令後或戰鬥結束後恢復。"
  },
  AwakerPotency_13568_PotencyName = {
    Text = "莫比烏斯囚徒"
  },
  AwakerPotency_13569_PotencyDesc = {
    Text = "回合結束後獲得 1 層負熵。"
  },
  AwakerPotency_13569_PotencyName = {
    Text = "彭羅斯行者"
  },
  AwakerPotency_13574_PotencyDesc = {
    Text = "使選擇的喚醒體回合開始時獲得 35 點狂氣、持續 3 回合。"
  },
  AwakerPotency_13574_PotencyName = {
    Text = "時空折躍"
  },
  AwakerPotency_13579_PotencyDesc = {
    Text = "靈知覺醒「黏液匯集」獲得強化，狂氣爆發使本回合每受到 1 次攻擊就使下次「報償打擊」消耗忍耐的效果提高 40%，最多疊加 5 層。"
  },
  AwakerPotency_13579_PotencyName = {
    Text = "無慾的百合"
  },
  AwakerPotency_13580_PotencyDesc = {
    Text = "目標每有 1 層易傷狀態，就額外使「石質分解」最終傷害提高 5%，至多提高500%。"
  },
  AwakerPotency_13581_PotencyDesc = {
    Text = "「理性，真理與現實」回復生命 +25%，造成的狂氣對朵爾也生效。"
  },
  AwakerPotency_13581_PotencyName = {
    Text = "超越軀殼"
  },
  AwakerPotency_13582_PotencyDesc = {
    Text = "「機械武裝-放」將 1 張擁有消耗的「基礎打擊」置入手中，「機械武裝-斂」將 1 張擁有消耗的 「基礎防禦」置入手中。"
  },
  AwakerPotency_13583_PotencyDesc = {
    Text = "「電磁爆破」享受額外 1 倍力量和戒備加成。"
  },
  AwakerPotency_13583_PotencyName = {
    Text = "強制回路"
  },
  AwakerPotency_13584_PotencyDesc = {
    Text = "每消耗 1 點黑印，就使「肆意豪賭」的基礎傷害在本次探索中提高 0.5%。萊克的「基礎打擊」和「基礎防禦」若算力不足時可消耗 3 黑印打出並生效 2 次。"
  },
  AwakerPotency_13584_PotencyName = {
    Text = "穩賺不賠"
  },
  AwakerPotency_13585_PotencyDesc = {
    Text = "若當前生命低於 50%，「基礎打擊」造成 2 次傷害，胚胎融合 +10。「基礎防禦」獲得 2 次護盾，胚胎融合 +10。"
  },
  AwakerPotency_13587_PotencyDesc = {
    Text = "靈知覺醒「維修大師」獲得強化，所有喚醒體固定反擊提高 30％。"
  },
  AwakerPotency_13587_PotencyName = {
    Text = "王牌機械師"
  },
  AwakerPotency_13600_PotencyDesc = {
    Text = "額外將「千面幻象」的 2 張複製置入手中、「斷頸一擊」本場戰鬥中基礎傷害提升 50%。"
  },
  AwakerPotency_13600_PotencyName = {
    Text = "幻霧迷煙"
  },
  AwakerPotency_13601_PotencyDesc = {
    Text = "「意外收穫」若暴擊還會使選擇的卡牌算力消耗額外降低 1。「攤牌時刻」每次暴擊萊克都會額外獲得 3 點狂氣。"
  },
  AwakerPotency_13601_PotencyName = {
    Text = "強運加倍"
  },
  AwakerPotency_13603_PotencyDesc = {
    Text = "「同伴的力量」額外抽 1 張牌。"
  },
  AwakerPotency_13603_PotencyName = {
    Text = "噗嚕嚕旅行"
  },
  AwakerPotency_13606_PotencyDesc = {
    Text = "「肆意豪賭」造成 3 次傷害，使抽到的卡牌算力消耗降低 1。"
  },
  AwakerPotency_13616_PotencyDesc = {
    Text = "戰鬥開始時，將 1 張「不規則形態 · 血鏈」置入手牌。「縛身鎖鏈」破除目標護盾並使目標無法獲得護盾，持續 1 回合。"
  },
  AwakerPotency_13616_PotencyName = {
    Text = "餘孽送葬"
  },
  AwakerPotency_13620_PotencyDesc = {
    Text = "造成傷害前對全體敵方施加 1 層「易傷」、獲得等同於攻擊力 [Arg1]% 的反擊。"
  },
  AwakerPotency_13620_PotencyName = {
    Text = "甘之如飴"
  },
  AwakerPotency_13627_PotencyDesc = {
    Text = "釋放「自我的葬儀」後，在本場戰鬥中使「自我的葬儀」施加的中毒層數提高等同於攻擊力 [Arg1]%（效果隨「自我的葬儀」的等級提高）。"
  },
  AwakerPotency_13628_PotencyDesc = {
    Text = "接下來 3 回合內，每回合開始時嘗試將 1 張「胚胎」轉化為「聖潔之子」，如果沒有「胚胎」則<EmbryoFusionIconKeywords:胚胎融合> +100，不受胚胎融合提高效果影響。"
  },
  AwakerPotency_13628_PotencyName = {
    Text = "永續聖骸的傳承"
  },
  AwakerPotency_13637_PotencyDesc = {
    Text = "使隨機 5 張手牌直到回合結束時算力消耗變為 0。"
  },
  AwakerPotency_13637_PotencyName = {
    Text = "縱貫寰宇的音律"
  },
  AwakerPotency_13645_PotencyDesc = {
    Text = "「祭儀」效果提高 30%。每將 1 張「聖禮」轉化為「執妄」，本場戰鬥中彌利亞姆造成的基礎傷害和「向深淵祝禱」造成的基礎中毒提高 15%。"
  },
  AwakerPotency_13645_PotencyName = {
    Text = "泡影幻滅"
  },
  AwakerPotency_13656_PotencyDesc = {
    Text = "「狂熱之海」享受觸腕傷害加成提高為 100%。"
  },
  AwakerPotency_13656_PotencyName = {
    Text = "崎嶇海岸"
  },
  AwakerPotency_13657_PotencyDesc = {
    Text = "「異種共生」獲得的狂氣提高 2 點。處於抑鬱人格時虛弱所有敵人 1 回合，處於躁狂人格時易傷所有敵人 1 回合。"
  },
  AwakerPotency_13657_PotencyName = {Text = "拘束帶"},
  AwakerPotency_13660_PotencyDesc = {
    Text = "「深淵號令」使觸腕攻擊所有敵人，若當前姿態為「靜海」，算力消耗降低 2 。"
  },
  AwakerPotency_13663_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_13673_PotencyDesc = {
    Text = "抽 2 張阿格里帕的非打擊防禦指令卡、使 2 張手中阿格里帕的非打擊防禦指令卡本回合算力消耗 -1。"
  },
  AwakerPotency_13673_PotencyName = {
    Text = "迷宮之主"
  },
  AwakerPotency_13677_PotencyDesc = {
    Text = "回合開始時積攢等同於體質 6% 的猩紅熔爐回復量。狂氣爆發「造主的庇佑」使薩爾瓦多獲得 35% 臨時暴擊傷害。"
  },
  AwakerPotency_13677_PotencyName = {
    Text = "予以救贖"
  },
  AwakerPotency_13678_PotencyDesc = {
    Text = "回合結束時 「24」 獲得 10 點狂氣。 「24」 每次釋放狂氣爆發後，本場戰鬥內這個效果獲得的狂氣提高 1 點。"
  },
  AwakerPotency_13678_PotencyName = {
    Text = "巴甫洛夫行為研究"
  },
  AwakerPotency_13679_PotencyDesc = {
    Text = "升級所有消耗<DreamGuide:夢引>時的效果：「死夢之都」消耗 5 層時額外獲得 15 點狂氣，消耗 10 層時額外造成 5% 傷害降低；「脊刺鎖鏈」降低力量效果翻倍；「迷途之守」額外獲得的反擊量提高 50% 。"
  },
  AwakerPotency_13679_PotencyName = {
    Text = "湖中棲物"
  },
  AwakerPotency_13680_PotencyDesc = {
    Text = "「基礎打擊」造成 2 次傷害，並獲得躍遷：額外造成 1 次傷害。"
  },
  AwakerPotency_13680_PotencyName = {
    Text = "響徹星穹"
  },
  AwakerPotency_13682_PotencyDesc = {
    Text = "靈知覺醒「空間折疊」獲得強化，詹金自身從「空間折疊」和「霧都街童」中獲得 2 倍暴擊傷害效果。"
  },
  AwakerPotency_13682_PotencyName = {
    Text = "自霧中歸來"
  },
  AwakerPotency_13683_PotencyDesc = {
    Text = "靈知覺醒「蛻變之軀」獲得強化，凱刻斯打出卡牌後使 1 條觸腕進行攻擊並獲得 50% 造成傷害的反擊。"
  },
  AwakerPotency_13686_PotencyDesc = {
    Text = "戰鬥結束後額外獲得 5 黑印，該效果受黑印掉落加成。旺達打出卡牌後，獲得 1 層<DreamGuide:夢引>，該效果每回合至多生效 2 次。"
  },
  AwakerPotency_13686_PotencyName = {
    Text = "裘皮與維納斯"
  },
  AwakerPotency_13688_PotencyDesc = {
    Text = "「恨意宣洩」若生命低於 50%，獲得的力量翻倍。「嗜血鏈球」的預備效果變更為預備 2。"
  },
  AwakerPotency_13688_PotencyName = {
    Text = "縱情復仇"
  },
  AwakerPotency_13689_PotencyDesc = {
    Text = "「報償打擊」預備 1 升級為預備 2，基礎傷害和暴擊率提高 20%。"
  },
  AwakerPotency_13694_PotencyDesc = {
    Text = "將 1 張附加<DepleteIconKeywords:消耗>的「超級大集合！」置入手牌。"
  },
  AwakerPotency_13694_PotencyName = {Text = "偷襲！"},
  AwakerPotency_13699_PotencyDesc = {
    Text = "「喪鐘遙鳴」施加的中毒提高 100%，獲得等同於防禦力 [Arg1]% 的護盾（效果隨「喪鐘遙鳴」的等級提高）。"
  },
  AwakerPotency_13699_PotencyName = {
    Text = "海之軀體"
  },
  AwakerPotency_13700_PotencyDesc = {
    Text = "靈知覺醒「演出序幕」獲得強化，所有喚醒體打出「打擊」時都能觸發該效果獲得臨時力量。"
  },
  AwakerPotency_13700_PotencyName = {
    Text = "一千零一場奇蹟"
  },
  AwakerPotency_13703_PotencyDesc = {
    Text = "每擁有 1 條觸腕「誕妄·墨菲」暴擊率 +3%，每擁有 1% 最大生命的「獻祭」或「延遲獻祭」，「誕妄·墨菲」暴擊傷害 +3%。"
  },
  AwakerPotency_13703_PotencyName = {
    Text = "倒懸之孕"
  },
  AwakerPotency_13704_PotencyDesc = {
    Text = "「打擊」或「防禦」抽 1 張「深海聖詠」，每回合最多生效 1 次。"
  },
  AwakerPotency_13704_PotencyName = {
    Text = "瀆神終末"
  },
  AwakerPotency_13706_PotencyDesc = {
    Text = "「螺湮圓舞」觸腕傷害、護盾、最終傷害提高 10%，每擁有 1 點銀鑰充能等級額外提高 0.2%。"
  },
  AwakerPotency_13706_PotencyName = {
    Text = "屈膝者的哀禱"
  },
  AwakerPotency_13711_PotencyDesc = {
    Text = "「高熱區禁入」獲得預備1。"
  },
  AwakerPotency_13713_PotencyDesc = {
    Text = "靈知覺醒「無邊星彩」獲得強化，打出時立即永久偷取所有敵人等同於攻擊力 25％ 的力量。"
  },
  AwakerPotency_13713_PotencyName = {
    Text = "永蕪的枯萎虹彩"
  },
  AwakerPotency_13715_PotencyDesc = {
    Text = "戰鬥開始後，胚胎融合 +25，每次觸發死亡抵抗，胚胎融合 +25。索蕾爾每次造成傷害，使本回合內自身造成傷害提高等同於攻擊力 4%。"
  },
  AwakerPotency_13723_PotencyName = {
    Text = "紅色緞帶"
  },
  AwakerPotency_13724_PotencyDesc = {
    Text = "「不死的極樂鳥」觸發復活後，所有喚醒體獲得 25 點狂氣，並間隔 6 回合後可再次施加復活效果。"
  },
  AwakerPotency_13724_PotencyName = {
    Text = "無喜無悲"
  },
  AwakerPotency_13725_PotencyDesc = {
    Text = "「純白夢境」每保留 1 回合，下次打出時回復生命就額外提高等同於體質的 [Arg1]%（效果隨「純白夢境」的等級提升）。"
  },
  AwakerPotency_13726_PotencyDesc = {
    Text = "獲得 3 層無視上限的負熵、使獲得的複製卡算力消耗變為 0 。"
  },
  AwakerPotency_13726_PotencyName = {
    Text = "伸向舊日的指尖"
  },
  AwakerPotency_13728_PotencyDesc = {
    Text = "「混沌之獸」造成的傷害次數+1 ，額外將 2 張附加消耗與虛無的「基礎打擊」置入手中。"
  },
  AwakerPotency_13728_PotencyName = {
    Text = "久遠的孤寂"
  },
  AwakerPotency_13729_PotencyDesc = {
    Text = "「紛亂切割」基礎傷害提高 33%。處於抑鬱人格時使對應卡牌算力消耗額外降低 1，處於躁狂人格時傷害次數額外提高 1。"
  },
  AwakerPotency_13730_PotencyDesc = {
    Text = "奧爾拉的所有詩篇均獲得保留。"
  },
  AwakerPotency_13730_PotencyName = {
    Text = "囚於暗室"
  },
  AwakerPotency_142824_PotencyDesc = {
    Text = "每回合首次「打擊」和首次「防禦」抽 1 張「囚魘」。「囚魘」獲得「餘波：算力消耗-1」。"
  },
  AwakerPotency_142824_PotencyName = {
    Text = "缺位狂歡"
  },
  AwakerPotency_142829_PotencyDesc = {
    Text = "「獵殺之魘」固定傷害提升 10%，「無休獵宴」基礎力量降低效果提高 5%。龐托斯喚醒體自身、命輪、密契每擁有 1% 暴擊傷害就使「獵殺之魘」固定傷害額外提升 0.2%，「無休獵宴」基礎力量降低效果額外提高 0.1%。"
  },
  AwakerPotency_142829_PotencyName = {
    Text = "向光之餌"
  },
  AwakerPotency_142831_PotencyDesc = {
    Text = "靈知覺醒「沉淵的怒仇」獲得強化，每回合首次「打擊」和首次「防禦」額外獲得 15 點狂氣。獲得「圍獵」所需的「囚魘」數由 3 降低為 2。"
  },
  AwakerPotency_142831_PotencyName = {
    Text = "至深至靜的侵吞"
  },
  AwakerPotency_142833_PotencyDesc = {
    Text = "造成固定傷害變為 3 倍。若造成擊殺額外生成 1 張「囚魘」。使各處「囚魘」算力消耗 -1。"
  },
  AwakerPotency_142833_PotencyName = {
    Text = "另一個厄波揚斯"
  },
  AwakerPotency_142836_PotencyDesc = {
    Text = "「縱魘掠襲」基礎傷害提升 25％，傷害和狂氣效果生效 X+1 次。"
  },
  AwakerPotency_142836_PotencyName = {Text = "空軀殼"},
  AwakerPotency_145364_PotencyDesc = {
    Text = "「基礎打擊」抽取 1 張「短刃·噬」，「基礎防禦」抽取 1 張「長刃·隕」，每回合最多各生效 1 次。"
  },
  AwakerPotency_145364_PotencyName = {
    Text = "不滅戰意"
  },
  AwakerPotency_145368_PotencyDesc = {
    Text = "造成傷害前獲得等同於「巨劍·鯨落」使目標提高傷害值的力量，本次狂氣爆發力量加成翻倍。"
  },
  AwakerPotency_145368_PotencyName = {
    Text = "斬落鯨天之夜"
  },
  AwakerPotency_145374_PotencyDesc = {
    Text = "「斷界之劍」從「巨劍·鯨落」獲得的傷害加成翻倍。每回合首次「蝕滅」不再消耗算力。"
  },
  AwakerPotency_145374_PotencyName = {
    Text = "無冕風暴"
  },
  AwakerPotency_145375_PotencyDesc = {
    Text = "靈知覺醒「亙古歸源」獲得強化，「蝕滅」通過竊取獲得的狂氣、最終傷害加成、最終傷害加成疊加上限提高 50％。"
  },
  AwakerPotency_145375_PotencyName = {
    Text = "萬古孤臨"
  },
  AwakerPotency_145378_PotencyDesc = {
    Text = "蝕滅·蘿坦「打擊」暴擊率 +10％，基礎傷害 +20％。蝕滅·蘿坦喚醒體自身、命輪、密契每有 1％ 黑印掉落，「打擊」暴擊率 +0.5％，基礎傷害 +1％。"
  },
  AwakerPotency_145378_PotencyName = {
    Text = "腐朽遺骸"
  },
  AwakerPotency_147398_PotencyName = {Text = "孤島"},
  AwakerPotency_147403_PotencyName = {
    Text = "超限爆發"
  },
  AwakerPotency_147405_PotencyName = {
    Text = "她的搖籃曲"
  },
  AwakerPotency_148465_PotencyDesc = {
    Text = "「未隕的騎士心」造成的護盾和力量倍率提高 20%，每層「暗涌」使負誓·奧吉爾暴擊傷害提高 10%。\n負誓·奧吉爾喚醒體自身、命輪、密契每有 1% 暴擊率，「未隕的騎士心」造成的護盾和力量倍率額外提高 0.6%，每層「暗涌」使負誓·奧吉爾暴擊傷害額外提高 0.3%。"
  },
  AwakerPotency_148465_PotencyName = {
    Text = "為扞衛佇立"
  },
  AwakerPotency_148466_PotencyDesc = {
    Text = "靈知覺醒「與黑沼共生」獲得強化，「染罪槍鋒」基礎傷害提高 100%，額外享受 200% 力量加成，「防禦」的護盾提高效果變為 100%。"
  },
  AwakerPotency_148466_PotencyName = {
    Text = "誓約，一如往初"
  },
  AwakerPotency_148469_PotencyDesc = {
    Text = "獲得的力量變為 3 倍。"
  },
  AwakerPotency_148469_PotencyName = {
    Text = "以我為壁"
  },
  AwakerPotency_148470_PotencyDesc = {
    Text = "每層「暗涌」使指令卡最終傷害提高效果變為 50%，「未隕的騎士心」每消耗 1 層「暗涌」造成的護盾和力量提高效果變為 50%。"
  },
  AwakerPotency_148470_PotencyName = {
    Text = "為大義殞身"
  },
  AwakerPotency_148474_PotencyDesc = {
    Text = "「打擊」額外生效 1 次。"
  },
  AwakerPotency_148474_PotencyName = {
    Text = "為微光銘記"
  },
  AwakerPotency_21727_PotencyDesc = {
    Text = "「七藝，傳承美德」獲得的護盾和臨時力量提高 20%， 若自身處於脆弱狀態，「七藝，傳承美德」額外獲得 33% 的護盾。"
  },
  AwakerPotency_21727_PotencyName = {
    Text = "憐憫，以助弱小"
  },
  AwakerPotency_21728_PotencyDesc = {
    Text = "「穿刺之槍」易傷回合數 +1，基礎傷害 +100%，力量加成倍數提高 1。"
  },
  AwakerPotency_21728_PotencyName = {
    Text = "誠實，以忠自我"
  },
  AwakerPotency_21738_PotencyDesc = {
    Text = "「不定壁壘」獲得的護盾提高 43%，獲得等同於攻擊力 [Arg1]% 的力量（效果隨「不定壁壘」的等級提高）。"
  },
  AwakerPotency_21738_PotencyName = {
    Text = "犧牲，以全大義"
  },
  AwakerPotency_54161_PotencyDesc = {
    Text = "靈知覺醒「穿越銀鑰之門」獲得強化，塔薇釋放狂氣爆發後其他喚醒體本回合指令卡最終傷害 +15%，還會使下 1 張其他喚醒體指令卡額外生效 1 次。"
  },
  AwakerPotency_54161_PotencyName = {
    Text = "創生真理"
  },
  AwakerPotency_54162_PotencyDesc = {
    Text = "「基礎打擊」和 「基礎防禦」獲得等同於攻擊力 15% 的臨時力量。若其觸發「樂音」效果，獲得的臨時力量翻倍。"
  },
  AwakerPotency_54162_PotencyName = {
    Text = "心靈協奏"
  },
  AwakerPotency_54163_PotencyDesc = {
    Text = "「回環樂音」使賦予的卡牌算力消耗 -2。"
  },
  AwakerPotency_54163_PotencyName = {
    Text = "夢中圓舞"
  },
  AwakerPotency_54164_PotencyDesc = {
    Text = "觸發「樂音」效果或打出 「協樂的交響」後，哈姆林獲得 1% 暴擊率和暴擊傷害。每觸發 10 次，本場戰鬥「靈魂序曲」和「原初的樂音」傷害次數提高 1，最多提高 3 次。"
  },
  AwakerPotency_54169_PotencyDesc = {
    Text = "每次造成傷害會對目標隨機施加 1 種奇妙負面效果、額外選擇 1 張不具有「樂音」的非消耗且非衍生的指令卡添加「回環樂音」。"
  },
  AwakerPotency_54169_PotencyName = {
    Text = "終末的奏鳴"
  },
  AwakerPotency_54174_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使塔薇獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_54175_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_54176_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_54176_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_54179_PotencyDesc = {
    Text = "靈知覺醒「此曲應得稱頌」獲得強化，回合開始時每有 1 張指令卡擁有樂音，哈姆林獲得 5 點狂氣。哈姆林釋放狂氣爆發時每存在 2 張指令卡擁有樂音，傷害次數+1。"
  },
  AwakerPotency_54179_PotencyName = {
    Text = "萬界於此鳴響"
  },
  AwakerPotency_54184_PotencyDesc = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提高 35%，發現的技能卡數量由 5 張改為 10 張並立即獲得 3 算力。"
  },
  AwakerPotency_54184_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_78946_PotencyDesc = {
    Text = "「混沌旗語」虛弱所有敵人 1 回合。每有 1 條觸腕，「領航」護盾、力量、觸腕傷害提高 5%，至多提高 50%。"
  },
  AwakerPotency_78946_PotencyName = {
    Text = "六分儀的測算"
  },
  AwakerPotency_78947_PotencyDesc = {
    Text = "「照徹淵海的引航」易傷所有敵人 1 回合，臨時暴擊傷害提高 30％，本場戰鬥每觸發過 1 次死亡抵抗額外提高 15％。"
  },
  AwakerPotency_78947_PotencyName = {
    Text = "無悔的犧牲"
  },
  AwakerPotency_78948_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」獲得狂氣提高 5 點，獲得「餘波」：下次打出獲得的狂氣提高 5，最多疊加 2 次。"
  },
  AwakerPotency_78948_PotencyName = {
    Text = "北極星的密語"
  },
  AwakerPotency_78949_PotencyDesc = {
    Text = "靈知覺醒「翱翔夙願」獲得強化，卡斯托爾每回合首次打出黑羽時對前排敵人造成等同於天賦「聖羽洗罪」的侵蝕，侵蝕移除時失去的生命由 300% 提高為 500%。"
  },
  AwakerPotency_78949_PotencyName = {
    Text = "滌罪永夜"
  },
  AwakerPotency_78961_PotencyDesc = {
    Text = "靈知覺醒「妖蟲的呼喚」獲得強化，克萊門汀造成的傷害次數 +1，「共感」上限提高為 20。"
  },
  AwakerPotency_78961_PotencyName = {
    Text = "集體無意識空間"
  },
  AwakerPotency_78970_PotencyDesc = {
    Text = "「打擊」和「防禦」造成的基礎傷害、護盾、狂氣提高 50%。"
  },
  AwakerPotency_78972_PotencyDesc = {
    Text = "額外將 3 張「黑羽」置入手中。本回合黑羽保留的護盾提高卡斯托爾防禦力的 10％，每次打出「黑羽」額外對目標施加卡斯托爾攻擊力 160％ 的「侵蝕」。"
  },
  AwakerPotency_78972_PotencyName = {
    Text = "飛躍荊棘海"
  },
  AwakerPotency_78982_PotencyDesc = {
    Text = "靈知覺醒「沉沒於遠海」獲得強化，克珀珊特每回合首張「懲戒雷霆」和「混沌旗語」額外置入 1 張「領航」到手中，「領航」效果提高 50%。"
  },
  AwakerPotency_78982_PotencyName = {
    Text = "不熄、不滅、不燼"
  },
  AwakerPotency_78986_PotencyDesc = {
    Text = "生成手中和超維空間最多 5 張具有「奇點信標」卡牌的臨時原始複製，將其隨機置入抽牌堆和棄牌堆並使其算力消耗變為 0。"
  },
  AwakerPotency_78986_PotencyName = {
    Text = "凌駕命運的悲歌"
  },
  AwakerPotency_78990_PotencyDesc = {
    Text = "手中每有 1 張「黑羽」，「蔽日之羽」打出後獲得 5 點狂氣。\n每打出 1 張「黑羽」，「穿行永夜」本回合算力消耗降低 1 點。"
  },
  AwakerPotency_78990_PotencyName = {
    Text = "不滅不移之志"
  },
  AwakerPotency_78997_PotencyDesc = {
    Text = "「粉雪魔咒」造成的固定傷害提高 30%，並獲得 10 點狂氣。卡拉布喚醒體自身、命輪、密契每擁有1 點界域精通，「粉雪魔咒」造成的固定傷害提高 0.15%，獲得的狂氣提高 0.05 點"
  },
  AwakerPotency_78998_PotencyDesc = {
    Text = "發現 2 組「禮物」不同的「賜福」，每組包含 2 張，選擇 1 組置入手中。 使所有敵人永久降低等同於防禦力 9% 的力量。"
  },
  AwakerPotency_78998_PotencyName = {
    Text = "童話天衣無縫"
  },
  AwakerPotency_79000_PotencyDesc = {
    Text = "獲得克萊門汀攻擊力 50％ 的力量和 300％ 克萊門汀銀鑰充能的銀鑰能量。移除「共感」時，同時觸發「精神創傷」與「恐懼固著」效果。"
  },
  AwakerPotency_79000_PotencyName = {
    Text = "潛意識侵蝕"
  },
  AwakerPotency_79002_PotencyDesc = {
    Text = "本源沉睡之主造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79002_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79013_PotencyDesc = {
    Text = "戰鬥開始時獲得 5 層「共感」。「生命重構治療」基礎傷害提高 20%。"
  },
  AwakerPotency_79013_PotencyName = {
    Text = "叩響心智門扉"
  },
  AwakerPotency_79016_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79016_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79024_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79025_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79025_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79026_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使蘭提戈斯獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79027_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79029_PotencyDesc = {
    Text = "卡拉布狂氣爆發傷害次數 +2。「飽餐」每層提供的生命上限加成效果提高 50%，狂氣爆發基礎傷害與護盾加成效果提高 50%。"
  },
  AwakerPotency_79039_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79039_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79040_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79042_PotencyDesc = {
    Text = "禿鷲造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張目前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79042_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79045_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79046_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使黑法老獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79048_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79048_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79052_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79053_PotencyDesc = {
    Text = "卡拉布每第 7 次打出「打擊」或「防禦」時，獲得 1 層「供奉」並發現 2 張「代價」不同的「賜福」，選擇 1 張置入手中。"
  },
  AwakerPotency_79053_PotencyName = {
    Text = "七重禮拜"
  },
  AwakerPotency_79055_PotencyDesc = {
    Text = "每打出 3 張「黑羽」，獲得 1 點算力並使卡斯托爾本場戰鬥造成的最終傷害提高 10%。"
  },
  AwakerPotency_79055_PotencyName = {
    Text = "遮蓋天幕之翼"
  },
  AwakerPotency_79056_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79056_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79063_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使夏塔克鳥獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79065_PotencyDesc = {
    Text = "獲得 3 條觸腕，棄置的手牌「餘波」效果額外生效 1 次。"
  },
  AwakerPotency_79065_PotencyName = {
    Text = "赴死如歸的天火"
  },
  AwakerPotency_79068_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79071_PotencyDesc = {
    Text = "靈知覺醒「木偶戲場揭幕」獲得強化，釋放「湮滅」後立刻對所有敵人造成等同於 50％「命運裁斷」的純粹傷害傷害，下次狂氣爆發造成的傷害強效和護盾提高 50％。"
  },
  AwakerPotency_79071_PotencyName = {
    Text = "摩伊賴的終章"
  },
  AwakerPotency_79072_PotencyDesc = {
    Text = "蘭提戈斯造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79072_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79086_PotencyDesc = {
    Text = "靈知覺醒「淨世之路」獲得強化，「聖心」因打出而洗入抽牌堆後，該「聖心」本回合算力消耗變為 0 且額外造成 100％ 傷害的出血。"
  },
  AwakerPotency_79086_PotencyName = {
    Text = "聖心長明"
  },
  AwakerPotency_79089_PotencyDesc = {
    Text = "戰鬥開始時賦予凱蒂古拉所有原始指令卡 1 層「活焰」。每獲得 1 層「爆炎」凱蒂古拉本場戰鬥基礎傷害提高 5%。"
  },
  AwakerPotency_79089_PotencyName = {
    Text = "無盡煉獄"
  },
  AwakerPotency_79090_PotencyDesc = {
    Text = "靈知覺醒「業火重燃」獲得強化，凱蒂古拉每層「活焰」的最終傷害和力量效果 +30%。"
  },
  AwakerPotency_79090_PotencyName = {
    Text = "燼滅終局"
  },
  AwakerPotency_79100_PotencyDesc = {
    Text = "夏塔克鳥造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79100_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79103_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使禿鷲獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79118_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79118_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79123_PotencyDesc = {
    Text = "戰鬥開始時，將 1 張「黑羽」置入手中。"
  },
  AwakerPotency_79123_PotencyName = {
    Text = "囚於地底之鳥"
  },
  AwakerPotency_79125_PotencyDesc = {
    Text = "黑法老造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79125_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79131_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使本源沉睡之主獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79132_PotencyDesc = {
    Text = "「生命重構治療」額外獲得 200％ 克萊門汀銀鑰充能的銀鑰能量。每移除 1 層「共感」，使克萊門汀造成的基礎傷害提高 3%。每場戰鬥結束後，使克萊門汀造成的基礎傷害提高 25％。"
  },
  AwakerPotency_79132_PotencyName = {
    Text = "靈魂治癒之旅"
  },
  AwakerPotency_79133_PotencyDesc = {
    Text = "回合結束時獲得 2 層「共感」。「共感」、「精神創傷」、「恐懼固著」的堆疊層數上限提高為 15。"
  },
  AwakerPotency_79133_PotencyName = {
    Text = "你終將痊癒"
  },
  AwakerPotency_79137_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使亞弗戈蒙獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79141_PotencyDesc = {
    Text = "亞弗戈蒙造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張目前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79141_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79143_PotencyDesc = {
    Text = "靈知覺醒「誘人蜜果」獲得強化，使用猩紅熔爐後，使下一次「奇蹟賜福」發現效果每組額外包含 1 張「賜福」。打出「賜福」後，胚胎融合 +10，當前生命越低則效果越高，至多提高 100%。"
  },
  AwakerPotency_79143_PotencyName = {
    Text = "新月高懸中天"
  },
  AwakerPotency_79147_PotencyDesc = {
    Text = "創構的「刻印」升級為「高級刻印」，創構的「白銀造物」升級為「黃金造物」。"
  },
  AwakerPotency_79147_PotencyName = {
    Text = "中心刻繪"
  },
  AwakerPotency_79148_PotencyDesc = {
    Text = "皮克曼消耗「創意」後自身額外獲得 50 點狂氣，本回合皮克曼能夠釋放 2 次狂氣爆發。"
  },
  AwakerPotency_79148_PotencyName = {
    Text = "繆斯的呼喚"
  },
  AwakerPotency_79150_PotencyDesc = {
    Text = "「打擊」或「防禦」抽 1 張出戰喚醒體的「技能」，每回合最多生效 1 次。"
  },
  AwakerPotency_79150_PotencyName = {
    Text = "交叉畫法"
  },
  AwakerPotency_79151_PotencyDesc = {
    Text = "「聖心」因第 3 次打出消耗時，使自身下一張指令卡額外生效 1 次。"
  },
  AwakerPotency_79151_PotencyName = {
    Text = "神啟新約"
  },
  AwakerPotency_79152_PotencyDesc = {
    Text = "每有 1 張手牌，「打擊」與「防禦」額外獲得 1 點狂氣。\n每打出 1 張「聖心」，下次打出的「離垢的審判」算力消耗降低 1 點。"
  },
  AwakerPotency_79153_PotencyDesc = {
    Text = "戰鬥開始時，將 1 張「聖心」置入手中。"
  },
  AwakerPotency_79153_PotencyName = {
    Text = "持燈神使"
  },
  AwakerPotency_79157_PotencyDesc = {
    Text = "「千兆耀斑」具有 3 層「活焰」時，基礎傷害提高 50%。「末路槍聲」具有 3 層「活焰」時，獲得的力量提高凱蒂古拉攻擊力的 3％。"
  },
  AwakerPotency_79164_PotencyDesc = {
    Text = "靈知覺醒「墓園畫室」獲得強化，「繪影摹形」創構的黃金造物持續回合數由 1 回合提高為 2 回合。"
  },
  AwakerPotency_79164_PotencyName = {
    Text = "畫中世界"
  },
  AwakerPotency_79173_PotencyDesc = {
    Text = "本回合內波呂克斯每張指令卡額外享受 50% 「苦痛救贖」效果，額外將 1 張「聖心」置入手中。自身下一張指令卡額外生效 1 次。"
  },
  AwakerPotency_79173_PotencyName = {
    Text = "照徹白夜之光"
  },
  AwakerPotency_79182_PotencyDesc = {
    Text = "獲得 1 層「狂想」並額外「發現」1 次。"
  },
  AwakerPotency_79182_PotencyName = {
    Text = "藝術，即為瘋狂"
  },
  AwakerPotency_79189_PotencyDesc = {
    Text = "額外造成 2 次傷害，改為隨機為手中凱蒂古拉的指令卡分配 5 層「活焰」。"
  },
  AwakerPotency_79189_PotencyName = {
    Text = "融於萬物的真理"
  },
  AwakerPotency_79196_PotencyDesc = {
    Text = "阿拉克涅狂氣爆發造成的臨時傷害強效提高 25%。阿拉克涅喚醒體自身、命輪、密契每擁有 1 點界域精通，造成的臨時傷害強效效果額外提高 0.25%。"
  },
  AwakerPotency_79196_PotencyName = {
    Text = "未來如我所見"
  },
  AwakerPotency_79197_PotencyDesc = {
    Text = "「永恆織造」造成的「命運裁斷」提高 50%。「縛命羅網」獲得「預備」和「保留」。"
  },
  AwakerPotency_79197_PotencyName = {
    Text = "萬物如我所思"
  },
  AwakerPotency_79198_PotencyDesc = {
    Text = "「織命」上限由 3 提高為 5，「無盡線縷」獲得的「奇點稜鏡」翻倍。"
  },
  AwakerPotency_79198_PotencyName = {
    Text = "宿命如我所織"
  },
  AwakerPotency_79220_PotencyDesc = {
    Text = "訓練模式友方校貓造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79220_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79223_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79223_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_79224_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79225_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使訓練模式友方校貓獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79228_PotencyDesc = {
    Text = "訓練模式敵方校貓造成的傷害、護盾、生命回覆臨時提高 35%。改為從 10 張當前界域的技能卡中發現 3 張，並立即獲得 3 算力。"
  },
  AwakerPotency_79228_PotencyName = {
    Text = "無限億萬光輝"
  },
  AwakerPotency_79241_PotencyDesc = {
    Text = "「基礎打擊」和「基礎防禦」使訓練模式敵方校貓獲得 3％ 暴擊率和暴擊傷害，至多 30％。探索中首次觸發死亡抵抗時，將一張「過往回聲」置入手中。"
  },
  AwakerPotency_79242_PotencyDesc = {
    Text = "「萬物歸一」發現的卡牌獲得預備 1。"
  },
  AwakerPotency_79243_PotencyDesc = {
    Text = "「通曉萬物之理」變化的指令卡算力消耗 -1。「縱貫時序之翼」額外將一張「靈感」置入手中。"
  },
  AwakerPotency_79243_PotencyName = {
    Text = "無窮智慧"
  },
  AwakerPotency_95788_PotencyDesc = {
    Text = "自身每損失 1％ 生命，杜勒賽因指令卡造成的基礎傷害、護盾、狂氣提高 1％。"
  },
  AwakerPotency_95788_PotencyName = {
    Text = "幽魂絮語"
  },
  AwakerPotency_95791_PotencyDesc = {
    Text = "本次狂氣爆發暴擊率+25％，基礎傷害提高 50%，最終傷害提高100％。"
  },
  AwakerPotency_95791_PotencyName = {
    Text = "萬靈的饜饗"
  },
  AwakerPotency_95792_PotencyDesc = {
    Text = "「永夜歡宴」基礎傷害提高 300%，打出後會使本回合後續打出的「永夜歡宴」額外享受 100% 力量加成。"
  },
  AwakerPotency_95792_PotencyName = {
    Text = "永夜歡宴"
  },
  AwakerPotency_95796_PotencyDesc = {
    Text = "靈知覺醒「王邸的請柬」獲得強化，打出時立即對所有敵人造成當前生命 20% 的純粹傷害。杜勒賽因每回合首次造成擊殺後，對其他敵人造成的純粹傷害提高為 100% 溢出傷害。"
  },
  AwakerPotency_95796_PotencyName = {
    Text = "冥河無渡"
  },
  AwakerPotency_95800_PotencyDesc = {
    Text = "杜勒賽因自身、裝備的命輪與密契每提供 1% 暴擊傷害，獲得 0.1% 暴擊率。"
  },
  AwakerPotency_95800_PotencyName = {
    Text = "餐前禮儀"
  }
})
return Text_AwakerPotency
