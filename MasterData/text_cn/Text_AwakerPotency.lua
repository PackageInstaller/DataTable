__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerPotency = readonly({
  AwakerPotency_122465_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122466_PotencyDesc = {
    Text = "茉夏自身、命轮、密契每拥有 1％ 死亡抵抗就提高 0.15% 暴击率与暴击伤害，每次触发死亡抵抗「雾境旅人」提供的暴击伤害本场战斗提高一倍。"
  },
  AwakerPotency_122466_PotencyName = {
    Text = "雾境旅人"
  },
  AwakerPotency_122467_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122468_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122469_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122470_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122471_PotencyDesc = {
    Text = "「人间爆破」生成 1 张上一次打出的其他「打击」的临时复制并使其算力消耗 -1。"
  },
  AwakerPotency_122471_PotencyName = {
    Text = "回不去的往昔"
  },
  AwakerPotency_122472_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122473_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122474_PotencyDesc = {
    Text = "「闪耀☆龙卷风」使本回合茉夏伤害次数 +1。"
  },
  AwakerPotency_122474_PotencyName = {
    Text = "劈出一个未来"
  },
  AwakerPotency_122475_PotencyDesc = {
    Text = "伤害次数 +1，本场战斗每触发 1 次「死亡抵抗」额外 +1。使打出的下一张「风暴冲击」基础算力消耗变为 0。若为本场战斗首次释放，额外「昏迷」全体敌方。"
  },
  AwakerPotency_122475_PotencyName = {
    Text = "龙卷风世界大崩毁☆！"
  },
  AwakerPotency_122476_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122477_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122478_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_122479_PotencyDesc = {
    Text = "灵知觉醒「雾境遗脉」获得强化，打出时额外生成 1 张临时「人间爆破」并使这 2 张「人间爆破」的算力消耗变为 0。茉夏的天赋「戏剧性邂逅」每回合触发次数上限提高为 5。"
  },
  AwakerPotency_122479_PotencyName = {
    Text = "穿透迷雾的自我"
  },
  AwakerPotency_125347_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125348_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125349_PotencyDesc = {
    Text = "灵知觉醒「不梦乡之主」获得强化，「痴醉」上限提高为 15，徐每回合首次打出的指令卡额外生效 1 次。"
  },
  AwakerPotency_125349_PotencyName = {Text = "姑妄言"},
  AwakerPotency_125350_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125351_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125352_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125353_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125354_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125355_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125356_PotencyDesc = {
    Text = "「入骨相思」胚胎融合 +15。徐自身、命轮、密契每拥有 1% 伤害强效，「入骨相思」获得的胚胎融合 +0.2。"
  },
  AwakerPotency_125356_PotencyName = {Text = "情冤"},
  AwakerPotency_125357_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125358_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_125359_PotencyDesc = {
    Text = "「痴醉」上限由 5 提高为 10。「夜雾下的情誓」使自身下次触发的「共振」效果翻倍。"
  },
  AwakerPotency_125359_PotencyName = {
    Text = "极乐之吻"
  },
  AwakerPotency_125360_PotencyDesc = {
    Text = "胚胎融合 +100。选择「相许」时施加的「中毒」和「痴醉」变为 3 倍，选择「夺魄」时每移除 1 层积攒 20％ 体质的猩红熔炉。"
  },
  AwakerPotency_125360_PotencyName = {
    Text = "孽海葬情"
  },
  AwakerPotency_125361_PotencyDesc = {
    Text = "「打击」和「防御」获得共振 3：额外获得 15 点狂气。"
  },
  AwakerPotency_125361_PotencyName = {
    Text = "扇与镰刀"
  },
  AwakerPotency_13057_PotencyDesc = {
    Text = "灵知觉醒「自我封锁」获得强化，打出时立即使狂气最低其他唤醒体获得 80 点狂气。"
  },
  AwakerPotency_13057_PotencyName = {
    Text = "离群者说"
  },
  AwakerPotency_13058_PotencyDesc = {
    Text = "「整装待发」触发反击倍率 +50%，释放后自身免疫脆弱、虚弱、易伤 1 回合。"
  },
  AwakerPotency_13058_PotencyName = {
    Text = "模糊的梦想"
  },
  AwakerPotency_13059_PotencyDesc = {
    Text = "「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。"
  },
  AwakerPotency_13059_PotencyName = {
    Text = "笑呵呵玩乐"
  },
  AwakerPotency_13060_PotencyDesc = {
    Text = "「等价交换」基础回复生命和弃牌回复生命效果提高 20%，每弃掉 1 张牌，额外回复生命同时并获得等量的护盾。"
  },
  AwakerPotency_13060_PotencyName = {
    Text = "逃离死亡"
  },
  AwakerPotency_13061_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13062_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13063_PotencyDesc = {
    Text = "「基础打击」享受 2 倍力量加成，获得跃迁：获得 1 点算力。「基础防御」获得等同于攻击力 [Arg1]% 的力量，获得跃迁：获得 1 点算力。"
  },
  AwakerPotency_13063_PotencyName = {
    Text = "无限通道"
  },
  AwakerPotency_13064_PotencyDesc = {
    Text = "使宁菲亚造成的中毒提高 50%，持续 3 回合。"
  },
  AwakerPotency_13064_PotencyName = {
    Text = "永沦深海的葬仪"
  },
  AwakerPotency_13065_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13066_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13067_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13068_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13069_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13070_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13071_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13072_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13073_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13074_PotencyDesc = {
    Text = "使 1 条触腕攻击 5 次，获得 25% 造成伤害的反击。"
  },
  AwakerPotency_13074_PotencyName = {
    Text = "倔强意志"
  },
  AwakerPotency_13075_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13076_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13077_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13078_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13079_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13080_PotencyDesc = {
    Text = "「古老的爱抚」获得的力量提高 50%，「圣血的本能」选择效果翻倍。"
  },
  AwakerPotency_13080_PotencyName = {
    Text = "隐入林中"
  },
  AwakerPotency_13081_PotencyDesc = {
    Text = "「基础防御」使希洛获得 25% 临时暴击率。"
  },
  AwakerPotency_13081_PotencyName = {
    Text = "圣子半身"
  },
  AwakerPotency_13082_PotencyDesc = {
    Text = "「基础打击」获得等同于墨菲攻击力 [Arg1]% 的触腕伤害，「基础防御」获得等同于墨菲攻击力 [Arg2]% 的触腕伤害。（效果随「打击」和「防御」的等级提升）"
  },
  AwakerPotency_13082_PotencyName = {
    Text = "无法剥离之血"
  },
  AwakerPotency_13083_PotencyDesc = {
    Text = "「统统消失！」每洗入 1 张牌，奇术师获得 3 点狂气。"
  },
  AwakerPotency_13083_PotencyName = {Text = "读心术"},
  AwakerPotency_13084_PotencyDesc = {
    Text = "「失落的艺术」基础伤害与护盾提高25% ，额外享受 25% 暴击率与暴击伤害加成。"
  },
  AwakerPotency_13084_PotencyName = {
    Text = "艺术狂欢"
  },
  AwakerPotency_13085_PotencyDesc = {
    Text = "「隔空取物」获得「余波」：将 1 张「灵感」洗入抽牌堆。"
  },
  AwakerPotency_13085_PotencyName = {Text = "模仿犯"},
  AwakerPotency_13086_PotencyDesc = {
    Text = "「基础打击」的目标每有 1 层易伤状态，胚胎融合+5，最多 30。"
  },
  AwakerPotency_13086_PotencyName = {
    Text = "目击证人"
  },
  AwakerPotency_13087_PotencyDesc = {
    Text = "灵知觉醒「翡翠映像」获得强化，莉兹每造成 3 次伤害还会使莉兹本场战斗造成的伤害提高攻击力的 15%。"
  },
  AwakerPotency_13087_PotencyName = {
    Text = "燃烧的致礼"
  },
  AwakerPotency_13088_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13089_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130902_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130903_PotencyDesc = {
    Text = "「深渊！漩涡！炮！」对生命最高敌人造成的伤害由双倍提高为三倍，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。"
  },
  AwakerPotency_130903_PotencyName = {
    Text = "受缚的冲动"
  },
  AwakerPotency_130904_PotencyDesc = {
    Text = "「涡！流！弹！」还会造成目标最大生命 0.5% 纯粹伤害，释放「深渊！漩涡！炮！」后界域精通 +50。莫丝自身、命轮、密契每拥有 1 点界域精通，「涡！流！弹！」额外造成目标最大生命 0.005% 的纯粹伤害，释放「深渊！漩涡！炮！」后界域精通 +0.5。"
  },
  AwakerPotency_130904_PotencyName = {
    Text = "不息的潮涌"
  },
  AwakerPotency_130905_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130906_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130907_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130908_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130909_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13090_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130910_PotencyDesc = {
    Text = "灵知觉醒「漩涡来了！」获得强化，莫丝释放追击后下次莫丝狂气爆发触腕伤害加成额外提高 50%，并使下次狂气爆发对生命最高敌人造成 1% 最大生命的纯粹伤害，最多叠加 5 次。"
  },
  AwakerPotency_130910_PotencyName = {
    Text = "砰——！嘣——！轰——！"
  },
  AwakerPotency_130911_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130912_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130913_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130914_PotencyDesc = {
    Text = "莫丝的「打击」和「防御」使下次莫丝狂气爆发暴击率 +10%，下次「装填！」基础算力消耗降低 1。"
  },
  AwakerPotency_130914_PotencyName = {
    Text = "轰鸣的深渊"
  },
  AwakerPotency_130915_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_130916_PotencyDesc = {
    Text = "每牺牲 1 条触腕提升的暴击伤害翻倍。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  AwakerPotency_130916_PotencyName = {
    Text = "默斯克斯！大！轰！炸！"
  },
  AwakerPotency_13091_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13092_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13093_PotencyDesc = {
    Text = "灵知觉醒「庇佑之力」获得强化，触发「不死的极乐鸟」复活时立即获得希莱斯特攻击力 150% 的临时触腕伤害，首领战效果翻倍。"
  },
  AwakerPotency_13093_PotencyName = {
    Text = "空想的卡修利亚"
  },
  AwakerPotency_13094_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13095_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13096_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13097_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13098_PotencyDesc = {
    Text = "灵知觉醒「红祭礼」获得强化，尤乌哈希狂气爆发最终伤害提高 35%，生命低于 25% 时效果翻倍。"
  },
  AwakerPotency_13098_PotencyName = {
    Text = "戾狂的赞歌"
  },
  AwakerPotency_13099_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13100_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13101_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13102_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13103_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13104_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13105_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13106_PotencyDesc = {
    Text = "灵知觉醒「渴血者」获得强化，打出雷娅的卡牌后，使下次狂气爆发得到强化：获得等同于当前永久力量 10% 的临时力量，最多堆叠 5 次。"
  },
  AwakerPotency_13106_PotencyName = {
    Text = "不愈的渴求"
  },
  AwakerPotency_13107_PotencyDesc = {
    Text = "「基础打击」获得 50% 伤害的临时反击。「基础防御」获得等同于攻击力 [Arg1]% 的反击。"
  },
  AwakerPotency_13107_PotencyName = {
    Text = "享受疼痛"
  },
  AwakerPotency_13108_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13109_PotencyDesc = {
    Text = "达芙黛尔以任意方式击杀敌人后，使队伍在本次关卡中暴击率永久提高 5%。"
  },
  AwakerPotency_13109_PotencyName = {
    Text = "贪婪灰雾"
  },
  AwakerPotency_13110_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13111_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13112_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13113_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13114_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13115_PotencyDesc = {
    Text = "「灼燃蜡滴之欲」获得 20 点狂气。"
  },
  AwakerPotency_13115_PotencyName = {
    Text = "欲火焚身"
  },
  AwakerPotency_13116_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13117_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13118_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13119_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13120_PotencyDesc = {
    Text = "每当进行吞噬时，将「小小愿望」从弃牌堆置入手牌，并使其算力消耗变为 0 点。"
  },
  AwakerPotency_13120_PotencyName = {
    Text = "夜空飞鸟"
  },
  AwakerPotency_13121_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13122_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13123_PotencyDesc = {
    Text = "「逆鳞之护」护盾提高 20%，并获得保留。"
  },
  AwakerPotency_13123_PotencyName = {
    Text = "鳞刺聚合"
  },
  AwakerPotency_13124_PotencyDesc = {
    Text = "灵知觉醒「复仇预行」获得强化，戈利亚在怒涛姿态下额外享受 300% 力量加成。"
  },
  AwakerPotency_13124_PotencyName = {
    Text = "暴君的登临"
  },
  AwakerPotency_13125_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13126_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13127_PotencyDesc = {
    Text = "「告死之舞」每弃掉 2 张牌就抽 1 张牌。"
  },
  AwakerPotency_13127_PotencyName = {
    Text = "最终黎明"
  },
  AwakerPotency_13128_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13129_PotencyDesc = {
    Text = "将附加虚无和消耗的「尖啸吧，血！」填满手牌，本回合尤乌哈希伤害次数提高 1。"
  },
  AwakerPotency_13129_PotencyName = {
    Text = "血涌的馈赠"
  },
  AwakerPotency_13130_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13131_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13132_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13133_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13134_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13135_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13136_PotencyDesc = {
    Text = "灵知觉醒「目见母亲」获得强化，泰旖丝的狂气爆发额外复制 1 张所选卡牌。"
  },
  AwakerPotency_13136_PotencyName = {
    Text = "源生万物的胎海"
  },
  AwakerPotency_13137_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13138_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13139_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13140_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13141_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13142_PotencyDesc = {
    Text = "「沸腾吧，血！」基础伤害提高 33%，生命低于 25% 时，额外造成 2 次伤害。"
  },
  AwakerPotency_13142_PotencyName = {
    Text = "罗马悲歌"
  },
  AwakerPotency_13143_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13144_PotencyDesc = {
    Text = "「基础打击」与「能量射线」造成的伤害享受 50% 反击加成。"
  },
  AwakerPotency_13144_PotencyName = {
    Text = "黑暗恐惧"
  },
  AwakerPotency_13145_PotencyDesc = {
    Text = "灵知觉醒「凝滞诅咒」获得强化，艾继丝释放狂气爆发后使自身下一张「防御」生效 3 次，额外使狂气爆发基础伤害提高 50%。"
  },
  AwakerPotency_13145_PotencyName = {
    Text = "凝刻的眼泪"
  },
  AwakerPotency_13146_PotencyDesc = {
    Text = "对所有敌人额外追加 1 次 15% 目标最大生命的纯粹伤害。本场战斗中「混沌之兽」的基础伤害提高 100%。"
  },
  AwakerPotency_13146_PotencyName = {
    Text = "直至星球终结"
  },
  AwakerPotency_13147_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13148_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13149_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13150_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13151_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13152_PotencyDesc = {
    Text = "探索开始时获得 15 黑印，莱克每有 1% 黑印掉落就使获得量提高 1%，且会增加「赢家通吃」进度。"
  },
  AwakerPotency_13152_PotencyName = {
    Text = "拾金不昧"
  },
  AwakerPotency_13153_PotencyDesc = {
    Text = "「应选之人」使界域精通提高 20 点，获得预备 1 和保留。"
  },
  AwakerPotency_13153_PotencyName = {
    Text = "最终降临"
  },
  AwakerPotency_13154_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13155_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13156_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13157_PotencyDesc = {
    Text = "无需消耗梦引，同时触发「催眠脉络」、「深眠反击」和「呓语回音」。"
  },
  AwakerPotency_13157_PotencyName = {
    Text = "迷途梦引"
  },
  AwakerPotency_13158_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13159_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13160_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13161_PotencyDesc = {
    Text = "「血链·希洛」暴击伤害 +35%。临时手牌上限+2。将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。"
  },
  AwakerPotency_13161_PotencyName = {
    Text = "桎梏仇怨"
  },
  AwakerPotency_13162_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13163_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13164_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13165_PotencyDesc = {
    Text = "「魔术嘉年华」额外抽 1 张牌，抽到症状或状态卡也会对随机敌人造成 1 次伤害。"
  },
  AwakerPotency_13165_PotencyName = {Text = "障眼法"},
  AwakerPotency_13166_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13167_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13168_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13169_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13170_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13171_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13172_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13173_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13174_PotencyDesc = {
    Text = "灵知觉醒「参数拟合」获得强化，艾瑞卡每次释放狂气爆发后使狂气爆发享受的力量与戒备加成额外提高 1 倍。"
  },
  AwakerPotency_13174_PotencyName = {
    Text = "终结协议"
  },
  AwakerPotency_13175_PotencyDesc = {
    Text = "「斩首重创」每有 1 条触腕，就使「斩首重创」的力量加成提高 1 倍。"
  },
  AwakerPotency_13175_PotencyName = {
    Text = "死亦新生"
  },
  AwakerPotency_13176_PotencyDesc = {
    Text = "灵知觉醒「灵魂瘟疫」获得强化，每层「终末」提高 8% 队伍伤害强效，「虚无终结」使所有唤醒体获得 30% 基础狂气。"
  },
  AwakerPotency_13176_PotencyName = {
    Text = "诸世皆沉"
  },
  AwakerPotency_13177_PotencyDesc = {
    Text = "回合结束时，每有 1 张手牌，触发所有敌人 3% 的中毒，并获得 3 点狂气。"
  },
  AwakerPotency_13177_PotencyName = {
    Text = "微弱烛光"
  },
  AwakerPotency_13178_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13179_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13180_PotencyDesc = {
    Text = "「基础打击」使「血链·希洛」获得 15% 临时暴击率和暴击伤害。「基础防御」触发所有敌人 15% 的出血。"
  },
  AwakerPotency_13180_PotencyName = {
    Text = "无尽杀戮"
  },
  AwakerPotency_13181_PotencyDesc = {
    Text = "当前生命低于 50% 时，「黑沼禁域」额外获得 1 次护盾，造成的中毒翻倍。"
  },
  AwakerPotency_13181_PotencyName = {
    Text = "黑色灌溉"
  },
  AwakerPotency_13182_PotencyDesc = {
    Text = "「基础打击」获得等同于 [Arg1]% 攻击力的反击。"
  },
  AwakerPotency_13182_PotencyName = {
    Text = "空白的过去"
  },
  AwakerPotency_13183_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13184_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13185_PotencyDesc = {
    Text = "「恣睢之浪」视为「打击」，获得的力量翻倍。"
  },
  AwakerPotency_13185_PotencyName = {
    Text = "昂扬的战意"
  },
  AwakerPotency_131861_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131862_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131863_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131864_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131865_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131866_PotencyDesc = {
    Text = "使复制的所有「技能」额外生效 1 次。"
  },
  AwakerPotency_131866_PotencyName = {
    Text = "独属于你的乐园"
  },
  AwakerPotency_131867_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131868_PotencyDesc = {
    Text = "沙耶的「基础打击」、「基础防御」额外使胚胎融合 +15，当前生命越低则效果越高，至多提高 100%。"
  },
  AwakerPotency_131868_PotencyName = {
    Text = "你会一直陪着我吗"
  },
  AwakerPotency_131869_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13186_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131870_PotencyDesc = {
    Text = "「肉脂烂漫」额外造成目标最大生命值 0.5% 的侵蚀。「沙耶之歌」每消耗 1 层「羽种」，下一次打出「肉脂烂漫」就额外抽 1 张牌。"
  },
  AwakerPotency_131870_PotencyName = {
    Text = "这就是所谓的爱吧"
  },
  AwakerPotency_131871_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131872_PotencyDesc = {
    Text = "灵知觉醒「认知改造」获得强化，使用「猩红熔炉」后沙耶获得 50 狂气和 1 层「羽种」。"
  },
  AwakerPotency_131872_PotencyName = {
    Text = "最后送给你的礼物"
  },
  AwakerPotency_131873_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131874_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_131875_PotencyDesc = {
    Text = "沙耶狂气爆发基础护盾提高 5% ，「肉脂烂漫」造成的基础侵蚀提高 10%。沙耶自身、装备的命轮与密契每提供 1% 黑印掉落属性，沙耶狂气爆发基础护盾提高 0.25%，「肉脂烂漫」造成的基础侵蚀额外提高 0.5%。"
  },
  AwakerPotency_131875_PotencyName = {
    Text = "为你变成怪物就好"
  },
  AwakerPotency_13187_PotencyDesc = {
    Text = "获得的力量提高 100%，所有唤醒体的暴击率与暴击伤害提高 10%。"
  },
  AwakerPotency_13187_PotencyName = {
    Text = "苍白的血吻"
  },
  AwakerPotency_13188_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13189_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13190_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13191_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13192_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13193_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13194_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13195_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13196_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13197_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13198_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13199_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13200_PotencyDesc = {
    Text = "本次狂气爆发伤害次数变为三倍。之后 5 次打出卡茜亚的指令卡后，获得攻击力 10% 的力量。"
  },
  AwakerPotency_13200_PotencyName = {
    Text = "纵情欢笑"
  },
  AwakerPotency_13201_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13202_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13203_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13204_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13205_PotencyDesc = {
    Text = "「苦痛于欢愉」基础伤害提高 100% 且造成穿刺伤害，获得保留。"
  },
  AwakerPotency_13205_PotencyName = {Text = "初生"},
  AwakerPotency_13206_PotencyDesc = {
    Text = "「美的怜悯」每有 1 条触腕，额外获得等同于防御力 [Arg1]% 的护盾。（效果随「美的怜悯」的等级提升）"
  },
  AwakerPotency_13206_PotencyName = {
    Text = "匍匐于美"
  },
  AwakerPotency_13207_PotencyDesc = {
    Text = "「临战体势」视为「防御」。"
  },
  AwakerPotency_13207_PotencyName = {
    Text = "固守阵地"
  },
  AwakerPotency_13208_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13209_PotencyDesc = {
    Text = "获得 24 点界域精通，「24」的下一张指令卡生效 3 次。"
  },
  AwakerPotency_13209_PotencyName = {
    Text = "畸变的解剖"
  },
  AwakerPotency_13210_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13211_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13212_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13213_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13214_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13215_PotencyDesc = {
    Text = "「献媚者之拥」触发吞噬时，获得的力量翻倍。"
  },
  AwakerPotency_13215_PotencyName = {
    Text = "地下室手记"
  },
  AwakerPotency_13216_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13217_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13218_PotencyDesc = {
    Text = "灵知觉醒「信仰的见证」获得强化，每翻转 2 张「圣礼」将一张「神国幻影」置入手中。"
  },
  AwakerPotency_13218_PotencyName = {
    Text = "故国苏生"
  },
  AwakerPotency_13219_PotencyDesc = {
    Text = "「基础防御」获得的护盾提高 25%，获得与护盾等量的反击。"
  },
  AwakerPotency_13219_PotencyName = {
    Text = "枯萎之歌"
  },
  AwakerPotency_13220_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13221_PotencyDesc = {
    Text = "回合开始时获得 10% 最大生命的忍耐。「淤泥上的不灭之花」和「报偿打击」仅移除一半忍耐。"
  },
  AwakerPotency_13221_PotencyName = {
    Text = "永不遗忘"
  },
  AwakerPotency_13222_PotencyDesc = {
    Text = "灵知觉醒「活尸梦呓」获得强化，旺达释放狂气爆发后自身下 2 张指令卡额外生效 1 次。"
  },
  AwakerPotency_13222_PotencyName = {
    Text = "黑石律令"
  },
  AwakerPotency_13223_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13224_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13225_PotencyDesc = {
    Text = "灵知觉醒「绝佳运气」获得强化，立即额外获得或升级 1 次「混沌的遗赠」，并使莱克的所有六面骰变化为八面骰。"
  },
  AwakerPotency_13225_PotencyName = {Text = "大满贯"},
  AwakerPotency_13226_PotencyDesc = {
    Text = "「丰穰之仪」还会使本次置入手中的原始复制算力消耗 -1。"
  },
  AwakerPotency_13226_PotencyName = {
    Text = "混沌之种"
  },
  AwakerPotency_13227_PotencyDesc = {
    Text = "「受祝骨血」胚胎融合 +15，积攒的猩红熔炉回复量随回合数提高，每回合提高等同于体质 [Arg1]%（随「受祝骨血」等级提高而提高）;「应消之苦」暴击率提高 25%，获得「预备1」。"
  },
  AwakerPotency_13227_PotencyName = {
    Text = "创生之语"
  },
  AwakerPotency_13228_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13229_PotencyDesc = {
    Text = "「不耐的施舍」使手中算力消耗最高的 1 张卡牌在本回合中算力消耗 -1。"
  },
  AwakerPotency_13229_PotencyName = {Text = "僭越者"},
  AwakerPotency_13230_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13231_PotencyDesc = {
    Text = "「狂想诗篇」<VulnerabilityIconKeywords:易伤>全体敌方 1 回合，「哀恸诗篇」<WeaknessIconKeywords:虚弱>全体敌方 1 回合。"
  },
  AwakerPotency_13231_PotencyName = {
    Text = "蜷于烈火"
  },
  AwakerPotency_13232_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13233_PotencyDesc = {
    Text = "「攻势推演」所抽的牌每有 1 点算力消耗，额外获得 35 点银钥充能"
  },
  AwakerPotency_13233_PotencyName = {
    Text = "未知的期待"
  },
  AwakerPotency_132341_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132342_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132343_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132344_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132345_PotencyDesc = {
    Text = "「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。"
  },
  AwakerPotency_132345_PotencyName = {
    Text = "两极之启"
  },
  AwakerPotency_132346_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132347_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132348_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132349_PotencyDesc = {
    Text = "「同伴的力量」额外抽 1 张牌。"
  },
  AwakerPotency_132349_PotencyName = {
    Text = "天元之启"
  },
  AwakerPotency_13234_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132350_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_132351_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132352_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132353_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132354_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132355_PotencyDesc = {
    Text = "「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。"
  },
  AwakerPotency_132355_PotencyName = {
    Text = "三相之启"
  },
  AwakerPotency_13235_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13236_PotencyDesc = {
    Text = "回合开始时回复等同于朵尔 [Arg1]% 体质的生命，持续 3 回合。（效果随「理性，真理与现实」的等级提升）"
  },
  AwakerPotency_13236_PotencyName = {
    Text = "心智分析"
  },
  AwakerPotency_132377_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132378_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_132379_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13237_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132380_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132381_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132382_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132383_PotencyDesc = {
    Text = "「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。"
  },
  AwakerPotency_132383_PotencyName = {
    Text = "两极之启"
  },
  AwakerPotency_132384_PotencyDesc = {
    Text = "「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。"
  },
  AwakerPotency_132384_PotencyName = {
    Text = "两极之启"
  },
  AwakerPotency_132385_PotencyDesc = {
    Text = "「同伴的力量」额外抽 1 张牌。"
  },
  AwakerPotency_132385_PotencyName = {
    Text = "天元之启"
  },
  AwakerPotency_132386_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132387_PotencyDesc = {
    Text = "「同伴的力量」额外抽 1 张牌。"
  },
  AwakerPotency_132387_PotencyName = {
    Text = "天元之启"
  },
  AwakerPotency_132388_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132389_PotencyDesc = {
    Text = "「同伴的力量」额外抽 1 张牌。"
  },
  AwakerPotency_132389_PotencyName = {
    Text = "天元之启"
  },
  AwakerPotency_13238_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132390_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132391_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132392_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132393_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_132394_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132395_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132396_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132397_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132398_PotencyDesc = {
    Text = "「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。"
  },
  AwakerPotency_132398_PotencyName = {
    Text = "三相之启"
  },
  AwakerPotency_132399_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13239_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132400_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132401_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132402_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132403_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132404_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_132405_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132406_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132407_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132408_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132409_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13240_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132410_PotencyDesc = {
    Text = "「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。"
  },
  AwakerPotency_132410_PotencyName = {
    Text = "三相之启"
  },
  AwakerPotency_132411_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132412_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132413_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132414_PotencyDesc = {
    Text = "「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。"
  },
  AwakerPotency_132414_PotencyName = {
    Text = "两极之启"
  },
  AwakerPotency_132415_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132416_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132417_PotencyDesc = {
    Text = "「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。"
  },
  AwakerPotency_132417_PotencyName = {
    Text = "三相之启"
  },
  AwakerPotency_132418_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132419_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13241_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132420_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_132421_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13242_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13243_PotencyDesc = {
    Text = "「自毁改造」选择「兴奋」时对所有敌人施加 1 回合易伤，选择「诅咒」时对所有敌人施加 1 回合虚弱。"
  },
  AwakerPotency_13243_PotencyName = {
    Text = "北天来客"
  },
  AwakerPotency_13244_PotencyDesc = {
    Text = "「桀骜之刃」视为「打击」。萝坦的「打击」基础伤害提高 30%。"
  },
  AwakerPotency_13244_PotencyName = {
    Text = "不羁的剑风"
  },
  AwakerPotency_13245_PotencyDesc = {
    Text = "「基础打击」和「基础防御」额外获得 5％ 基础狂气的狂气。「虚无终结」的纯粹伤害由 25％ 提高为 30％，额外回复 30％ 已损生命。"
  },
  AwakerPotency_13245_PotencyName = {
    Text = "绝灭使臣"
  },
  AwakerPotency_13246_PotencyDesc = {
    Text = "「终点，真理与深渊之门」和「宿命坍缩」造成的基础中毒量提高 50%，每拥有 1 层「终末」额外提高 15%，终末层数不再拥有堆叠上限。"
  },
  AwakerPotency_13246_PotencyName = {
    Text = "共振菌丝"
  },
  AwakerPotency_13247_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13248_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13249_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13250_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13251_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13252_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13253_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13254_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13255_PotencyDesc = {
    Text = "手牌上限+2，回合结束时选择 1 张手牌获得保留并使其算力消耗 -1，持续 3 回合。"
  },
  AwakerPotency_13255_PotencyName = {
    Text = "迷航之光"
  },
  AwakerPotency_13256_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13257_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13258_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13259_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13260_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13261_PotencyDesc = {
    Text = "回合开始时获得防御力 60% 的护盾和 15% 攻击力的触腕伤害，生成 2 条临时触腕，持续 3 回合。"
  },
  AwakerPotency_13261_PotencyName = {
    Text = "自由誓愿"
  },
  AwakerPotency_13262_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13263_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13264_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13265_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13266_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13267_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13268_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13269_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13270_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13271_PotencyDesc = {
    Text = "使索蕾尔接下来 3 张指令卡生效 2 次。本次狂气爆发每造成 1 次伤害，回合结束时回复等同于体质 [Arg1]% 点生命。"
  },
  AwakerPotency_13271_PotencyName = {
    Text = "无尽蔷薇之欲"
  },
  AwakerPotency_13272_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13273_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13274_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13275_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13276_PotencyDesc = {
    Text = "「女王之剑」伤害次数+1，每次造成伤害时，获得等同于攻击力 [Arg1]% 的临时力量。（效果随「女王之剑」的等级提升）「女王之剑」弃掉后，获得 300% 等同于拉蒙娜银钥充能的银钥能量。"
  },
  AwakerPotency_13276_PotencyName = {
    Text = "懵懂的启程"
  },
  AwakerPotency_13277_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13278_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13279_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13280_PotencyDesc = {
    Text = "「蟾蜍炖菜」的中毒与回复生命效果提高 50%。"
  },
  AwakerPotency_13280_PotencyName = {
    Text = "在糖霜里"
  },
  AwakerPotency_13281_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13282_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13283_PotencyDesc = {
    Text = "「电磁爆破」基础伤害和护盾提高 100%。艾瑞卡的「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  AwakerPotency_13283_PotencyName = {
    Text = "多重计算"
  },
  AwakerPotency_13284_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13285_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13286_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13287_PotencyDesc = {
    Text = "将 3 张回复提高 50% 的「纯白梦境」置入手中并附加消耗。"
  },
  AwakerPotency_13287_PotencyName = {
    Text = "神女的守望"
  },
  AwakerPotency_13288_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13289_PotencyDesc = {
    Text = "「基础打击」获得：施加 50% 伤害的中毒。「基础防御」获得：触发所有敌人 25% 的中毒。"
  },
  AwakerPotency_13289_PotencyName = {
    Text = "不朽绿炎"
  },
  AwakerPotency_13290_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13291_PotencyDesc = {
    Text = "灵知觉醒「施与受」获得强化，潘狄娅获得永久反击时获得 3% 等量的力量。"
  },
  AwakerPotency_13291_PotencyName = {
    Text = "疼爱惩戒宣言"
  },
  AwakerPotency_13292_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13293_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13294_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13295_PotencyDesc = {
    Text = "将<DerivativeCardKeywords_43:「奇妙料理」>洗入抽牌堆和弃牌堆各 1 张。"
  },
  AwakerPotency_13295_PotencyName = {
    Text = "丰盛餐点"
  },
  AwakerPotency_13296_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13297_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13298_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13299_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13300_PotencyDesc = {
    Text = "灵知觉醒「海祭典仪」获得强化，打出时立即获得 2 层「命契」。若回合结束时处于「潮涌」姿态，额外获得 1 层「命契」。"
  },
  AwakerPotency_13300_PotencyName = {
    Text = "天人感应"
  },
  AwakerPotency_13301_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13302_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13303_PotencyDesc = {
    Text = "每回合打出第一张诗篇时，奥尔拉获得 10 点狂气。「纷华篇章」对应情绪的效果提高由 150% 提高为 250%。"
  },
  AwakerPotency_13303_PotencyName = {
    Text = "花与诗的重逢"
  },
  AwakerPotency_13304_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13305_PotencyDesc = {
    Text = "每打出 1 张「灵感」就使达芙黛尔获得 2 点狂气，获得等同于 1% 攻击力的力量，每回合最多触发 5 次。"
  },
  AwakerPotency_13305_PotencyName = {
    Text = "原质沉淀"
  },
  AwakerPotency_13306_PotencyDesc = {
    Text = "「破碎沉戟」获得 [Arg1] 狂气。（效果随「破碎沉戟」的等级提升）"
  },
  AwakerPotency_13306_PotencyName = {
    Text = "血脉觉醒"
  },
  AwakerPotency_13307_PotencyDesc = {
    Text = "「永存的幻影」获得保留，回复效果提高 25%。"
  },
  AwakerPotency_13307_PotencyName = {
    Text = "孤独桅杆"
  },
  AwakerPotency_13309_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13310_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13311_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13312_PotencyDesc = {
    Text = "「未被满足之痛」获得 10 点狂气。"
  },
  AwakerPotency_13312_PotencyName = {
    Text = "到阳光下"
  },
  AwakerPotency_13313_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13314_PotencyDesc = {
    Text = "获得的护盾提高 200%，使本场战斗中「失落的艺术」和「基础打击」造成的伤害额外享受 100% 护盾加成。"
  },
  AwakerPotency_13314_PotencyName = {
    Text = "珊瑚海之约"
  },
  AwakerPotency_13315_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13316_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13317_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13318_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13319_PotencyDesc = {
    Text = "「无止境的正义」使艾尔瓦获得 50％ 临时暴击率和暴击伤害。"
  },
  AwakerPotency_13319_PotencyName = {
    Text = "一切为了公正"
  },
  AwakerPotency_13320_PotencyDesc = {
    Text = "将 1 张附加消耗的「临战体势」与「心眼利刃」置入手中。艾尔瓦本场战斗的暴击伤害 +25%。"
  },
  AwakerPotency_13320_PotencyName = {
    Text = "公义与真理同在"
  },
  AwakerPotency_13321_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13322_PotencyDesc = {
    Text = "「精神重建」每弃掉 1 张牌，下回合获得等同于防御力 [Arg1]% 的护盾（效果随「精神重建」的等级提升）。若触发跃迁立即抽 1 张牌。"
  },
  AwakerPotency_13322_PotencyName = {
    Text = "遗失故土"
  },
  AwakerPotency_13323_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13324_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13325_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13326_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13327_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13328_PotencyDesc = {
    Text = "灵知觉醒「受造之物」获得强化，墨菲每回合首次打出的「螺湮逆流」伤害次数和每回合首次打出的「圣女作成」获得算力翻倍。"
  },
  AwakerPotency_13328_PotencyName = {
    Text = "逆命天性"
  },
  AwakerPotency_13329_PotencyDesc = {
    Text = "选择「篡夺」时，置入手中的「巨刃之威」基础伤害提高 400%，算力消耗变为 0 。选择「蛰伏」时，不再置入「巨刃之威」，改为将 2 张「斩首重创」置入手中，并使其获得「消耗」「预备 1」和「保留」。"
  },
  AwakerPotency_13329_PotencyName = {
    Text = "巨人的腕力"
  },
  AwakerPotency_13330_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13331_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13332_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13333_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13334_PotencyDesc = {
    Text = "释放钥令后，拉蒙娜临时暴击率提高 50％。「世界演绎法」将 1 张「灵感」洗入抽牌堆。"
  },
  AwakerPotency_13334_PotencyName = {
    Text = "珍贵的羁绊"
  },
  AwakerPotency_13335_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13336_PotencyDesc = {
    Text = "「静默守望」最大可叠加次数提高至 3。"
  },
  AwakerPotency_13336_PotencyName = {
    Text = "女仆守则"
  },
  AwakerPotency_13337_PotencyDesc = {
    Text = "灵知觉醒「战地卓识」获得强化，艾尔瓦的指令卡每回合首次造成伤害后获得防御力 80% 的护盾。"
  },
  AwakerPotency_13337_PotencyName = {
    Text = "向乌托邦的征伐"
  },
  AwakerPotency_13338_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13339_PotencyDesc = {
    Text = "回合结束时墨菲获得 5 点狂气。释放钥令后，移除 2% 最大生命的「献祭」。"
  },
  AwakerPotency_13339_PotencyName = {
    Text = "解放与自由之触"
  },
  AwakerPotency_13340_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13341_PotencyDesc = {
    Text = "「绵音渐响」和「星彩极光」获得暴击率的同时，也会获得等量的暴击伤害。"
  },
  AwakerPotency_13341_PotencyName = {
    Text = "坠入高空"
  },
  AwakerPotency_13342_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13343_PotencyDesc = {
    Text = "「奇妙料理」有 50% 概率能够随机触发一个奇妙效果，这些效果包括自身获得 10 点狂气，其他友方获得 5 点狂气、易伤所有敌人 1 回合，虚弱所有敌人 1 回合、 抽 1 张牌、获得 200  点银钥能量。"
  },
  AwakerPotency_13343_PotencyName = {
    Text = "发酵料理书"
  },
  AwakerPotency_13344_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13345_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13346_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13347_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13348_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13349_PotencyDesc = {
    Text = "本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。"
  },
  AwakerPotency_13349_PotencyName = {
    Text = "听从所愿"
  },
  AwakerPotency_13350_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13351_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13352_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13353_PotencyDesc = {
    Text = "灵知觉醒「战欲难平」获得强化，萝坦打出「防御」后本回合下一张「桀骜之刃」生效 2 次。"
  },
  AwakerPotency_13353_PotencyName = {
    Text = "亘古的鲸鸣"
  },
  AwakerPotency_13354_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13355_PotencyDesc = {
    Text = "「夜潮汹涌」造成的伤害提高 50%，每回合打出的前 3 张症状卡，使「夜潮汹涌」在本场战斗中的伤害提高等同于攻击力的 20％。"
  },
  AwakerPotency_13355_PotencyName = {
    Text = "无声浸润"
  },
  AwakerPotency_13356_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13357_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13358_PotencyDesc = {
    Text = "「螺湮逆流」获得保留。每有 2 条触腕额外造成 1 次伤害。"
  },
  AwakerPotency_13358_PotencyName = {
    Text = "隐忍的叛逆"
  },
  AwakerPotency_13359_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13360_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13361_PotencyDesc = {
    Text = "灵知觉醒「湮塞的执念」获得强化，法洛思打出卡牌后使本回合触腕造成等同于伤害 5% 的中毒，最多生效 3 次。"
  },
  AwakerPotency_13361_PotencyName = {
    Text = "终至光辉彼岸"
  },
  AwakerPotency_13362_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使 1 条触腕攻击 2 次，但只造成 50％ 伤害。"
  },
  AwakerPotency_13362_PotencyName = {
    Text = "凝固鲸油"
  },
  AwakerPotency_13363_PotencyDesc = {
    Text = "血肉界域每回合自动获得的胚胎融合提高 50%。「基础打击」和 「基础防御」获得等同于攻击力 3% 的力量。"
  },
  AwakerPotency_13363_PotencyName = {
    Text = "生生不息"
  },
  AwakerPotency_13364_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13365_PotencyDesc = {
    Text = "「基础防御」积攒等同于体质 [Arg1]% 的猩红熔炉回复量（随「防御」等级提高而提高）。本场战斗每积攒 2 点猩红熔炉回复量，就使「基础打击」伤害提高 1。"
  },
  AwakerPotency_13365_PotencyName = {
    Text = "代行神意"
  },
  AwakerPotency_13366_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13367_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13368_PotencyDesc = {
    Text = "灵知觉醒「索魂者宣言」获得强化，血链希洛释放狂气爆发后，赋予手中每张不同的自身指令卡 50 层<TempPowerKeywords:临时强化>，回合结束或打出后移除。"
  },
  AwakerPotency_13368_PotencyName = {
    Text = "死律宣告"
  },
  AwakerPotency_13369_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13370_PotencyDesc = {
    Text = "「尖啸吧，血！」基础伤害和力量提高 30%。"
  },
  AwakerPotency_13370_PotencyName = {Text = "角斗士"},
  AwakerPotency_13371_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13372_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13373_PotencyDesc = {
    Text = "「无止境的正义」抽牌数量 +1。"
  },
  AwakerPotency_13373_PotencyName = {
    Text = "永战不怠"
  },
  AwakerPotency_13374_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13375_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13376_PotencyDesc = {
    Text = "灵知觉醒「灵肉两分」获得强化，造成的护盾效果提高 50%。朵尔的「打击」和「防御」也能触发获得护盾效果。"
  },
  AwakerPotency_13376_PotencyName = {
    Text = "重构自我"
  },
  AwakerPotency_13377_PotencyDesc = {
    Text = "对应情绪的效果加成提高为 600%。获得 3 层万能「隐喻」：会在下次诗篇跃迁时被视为任意情绪的「隐喻」使用并消耗。"
  },
  AwakerPotency_13377_PotencyName = {
    Text = "墨染成诗"
  },
  AwakerPotency_13378_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13379_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13380_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13381_PotencyDesc = {
    Text = "本次狂气爆发造成的狂气翻倍，所有唤醒体造成的中毒、反击、基础伤害提高 10％。若当前为首领战，额外获得 1 层「终末」。「终末形态」：每消耗 10 点狂气，额外触发所有敌人 3％ 的中毒。"
  },
  AwakerPotency_13381_PotencyName = {
    Text = "癫狂感染"
  },
  AwakerPotency_13382_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13383_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13384_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13385_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13386_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13387_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13388_PotencyDesc = {
    Text = "灵知觉醒「凸月之舞」获得强化，回合结束时若保留了珈伦的指令卡，也会触发 2 次回复生命和狂气效果。"
  },
  AwakerPotency_13388_PotencyName = {
    Text = "雾月晚宴"
  },
  AwakerPotency_13389_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13390_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13391_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13392_PotencyDesc = {
    Text = "本场战斗每释放 1 次「布朗出动！」，「鼠群冲击」的基础伤害就提高等同于攻击力 [Arg1]% 的伤害。（效果随「布朗出动！」的等级提升）"
  },
  AwakerPotency_13392_PotencyName = {
    Text = "红色缎带"
  },
  AwakerPotency_13393_PotencyDesc = {
    Text = "「基础防御」和「基础打击」触发全体敌方 20％ 中毒。"
  },
  AwakerPotency_13393_PotencyName = {
    Text = "灰烬与头颅"
  },
  AwakerPotency_13394_PotencyName = {
    Text = "黑色溶解"
  },
  AwakerPotency_13395_PotencyDesc = {
    Text = "灵知觉醒「诗册序言」获得强化，发动湮灭后奥尔拉本回合下一张指令卡触发跃迁效果。每当奥尔拉消耗 3 层或以上隐喻，使当前情绪光环效果临时提高 35%，无法叠加。"
  },
  AwakerPotency_13395_PotencyName = {
    Text = "余烬里的春天"
  },
  AwakerPotency_13396_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13397_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13398_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13399_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13400_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13401_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13402_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13403_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13404_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13405_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13406_PotencyDesc = {
    Text = "使所有敌人临时降低等同于防御力 [Arg1]% 的力量（随星之摇篮等级提升而提升）。"
  },
  AwakerPotency_13406_PotencyName = {
    Text = "破茧而生的新芽"
  },
  AwakerPotency_13407_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13408_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13409_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13410_PotencyDesc = {
    Text = "额外获得 24% 攻击力的力量和触腕伤害。之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  AwakerPotency_13410_PotencyName = {
    Text = "水母集合"
  },
  AwakerPotency_13411_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13412_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13413_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13414_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13415_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13417_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13418_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13419_PotencyDesc = {
    Text = "额外将 2 张「圣礼」置入手中，触腕上限和触腕数量 +1。"
  },
  AwakerPotency_13419_PotencyName = {
    Text = "未经他人之苦"
  },
  AwakerPotency_13420_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13421_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13422_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13423_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13424_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13425_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13426_PotencyDesc = {
    Text = "灵知觉醒「不朽威仪」获得强化，图鲁释放狂气爆发后，所有敌人受到的触腕伤害提高 10%，最多叠加 5 次。"
  },
  AwakerPotency_13426_PotencyName = {Text = "孤王"},
  AwakerPotency_13427_PotencyDesc = {
    Text = "灵知觉醒「沉逝苦海」获得强化，回合结束时宁菲亚造成的中毒额外提高 20%。"
  },
  AwakerPotency_13427_PotencyName = {
    Text = "神思归流"
  },
  AwakerPotency_13428_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13429_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13430_PotencyDesc = {
    Text = "「无上生祭」使临时暴击伤害提高，数值等同于弥利亚姆原始暴击伤害的 15%。"
  },
  AwakerPotency_13430_PotencyName = {
    Text = "踽踽苦行"
  },
  AwakerPotency_13431_PotencyDesc = {
    Text = "灵知觉醒「熵增逆转」获得强化，不再限制每回合生效次数。环行·拉蒙娜打出触发「回环」的卡牌后，获得 50 点银钥能量。"
  },
  AwakerPotency_13431_PotencyName = {
    Text = "无限归一奇点"
  },
  AwakerPotency_13432_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13433_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13434_PotencyDesc = {
    Text = "「脊刺锁链」暴击率提高 25%。「迷途之守」获得的所有反击提高 20%。"
  },
  AwakerPotency_13434_PotencyName = {Text = "启示录"},
  AwakerPotency_13435_PotencyName = {
    Text = "金蝴蝶回忆"
  },
  AwakerPotency_13436_PotencyDesc = {
    Text = "「基础打击」获得图鲁攻击力的 [Arg1]% 的临时力量和临时触腕伤害，「基础防御」获得图鲁攻击力的 [Arg2]%的临时力量和临时触腕伤害（效果随「打击」、「防御」的等级提升）。"
  },
  AwakerPotency_13436_PotencyName = {
    Text = "复苏之触"
  },
  AwakerPotency_13438_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13439_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13440_PotencyDesc = {
    Text = "灵知觉醒「骑士热诚」获得强化，奥吉尔通过「骑士热诚」获得的力量额外提高 50%。在本场战斗触发死亡抵抗后，奥吉尔的狂气爆发获得的临时力量提高为 3 倍。"
  },
  AwakerPotency_13440_PotencyName = {
    Text = "忠诚，誓死不渝"
  },
  AwakerPotency_13441_PotencyDesc = {
    Text = "「机能过载」获得跃迁：同时具有伤害和护盾 2 个效果。"
  },
  AwakerPotency_13441_PotencyName = {Text = "再启动"},
  AwakerPotency_13442_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13443_PotencyDesc = {
    Text = "「蜜糖色悲惨幻象」基础伤害翻倍，并获得等同于攻击力 [Arg1]% 的反击。"
  },
  AwakerPotency_13443_PotencyName = {Text = "你不乖"},
  AwakerPotency_13444_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13445_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13446_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13447_PotencyDesc = {
    Text = "灵知觉醒「迎客特权」获得强化，索蕾尔每造成 1 次伤害使索蕾尔临时最终伤害 +2%，其他唤醒体 +1%，每回合最多生效 15 次。"
  },
  AwakerPotency_13447_PotencyName = {
    Text = "绯红盛绽"
  },
  AwakerPotency_13448_PotencyDesc = {
    Text = "灵知觉醒「界外之音」获得强化，汀克特每回合首次打出「技能」时生成 1 张算力消耗为 0 的临时「打击」，该「打击」的随机效果变为 2 倍。"
  },
  AwakerPotency_13448_PotencyName = {
    Text = "当殷红浸透荆棘"
  },
  AwakerPotency_13449_PotencyDesc = {
    Text = "「腐化绿炎」回合结束时若在手牌或超维空间，将会升级为「死灭绿炎」。"
  },
  AwakerPotency_13449_PotencyName = {
    Text = "翠色火种"
  },
  AwakerPotency_13450_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13451_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13452_PotencyDesc = {
    Text = "灵知觉醒「维度投射」获得强化，打出时立即生成 1 张算力消耗为 0 的临时「断颈一击」置入超维空间。"
  },
  AwakerPotency_13452_PotencyName = {Text = "死魂灵"},
  AwakerPotency_13453_PotencyDesc = {
    Text = "「强者为尊」在移除所有敌人力量的同时，额外获得等同于移除量的临时力量。"
  },
  AwakerPotency_13453_PotencyName = {
    Text = "一山二虎"
  },
  AwakerPotency_13454_PotencyDesc = {
    Text = "回合结束时回复等同于体质 7.5% 的生命。"
  },
  AwakerPotency_13454_PotencyName = {
    Text = "不被接纳之痛"
  },
  AwakerPotency_13455_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13456_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13457_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13458_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13459_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13460_PotencyDesc = {
    Text = "施加的「降生仪式」提高 5 层。生成 3 张算力消耗为 2 且附加「预备」和「消耗」的「螺湮圆舞」。"
  },
  AwakerPotency_13460_PotencyName = {
    Text = "万劫轮回的天幕"
  },
  AwakerPotency_13461_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13462_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13463_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13464_PotencyDesc = {
    Text = "「基础打击」使希洛获得 10% 暴击伤害。"
  },
  AwakerPotency_13464_PotencyName = {
    Text = "斩断锁链之人"
  },
  AwakerPotency_13465_PotencyDesc = {
    Text = "「蔷薇之美」基础伤害提高 25%，每造成 1 次伤害，临时暴击率 +5%。"
  },
  AwakerPotency_13465_PotencyName = {Text = "佳酿"},
  AwakerPotency_13466_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13467_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13468_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13469_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13470_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13471_PotencyDesc = {
    Text = "提高当前护盾 50% 的效果变为无视护盾上限，触发反击倍率提高为 500％。"
  },
  AwakerPotency_13471_PotencyName = {
    Text = "引擎启动！"
  },
  AwakerPotency_13472_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13473_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13474_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13475_PotencyDesc = {
    Text = "「雾都街童」额外获得 1 张「布朗出动！」。"
  },
  AwakerPotency_13475_PotencyName = {
    Text = "黑色溶解"
  },
  AwakerPotency_13476_PotencyDesc = {
    Text = "「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。"
  },
  AwakerPotency_13476_PotencyName = {
    Text = "滑溜溜冒险"
  },
  AwakerPotency_13477_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13478_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13479_PotencyDesc = {
    Text = "本回合所有唤醒体造成的最终伤害提高 25%。"
  },
  AwakerPotency_13479_PotencyName = {
    Text = "超越万古的凝视"
  },
  AwakerPotency_13480_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13481_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13482_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13483_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13484_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13485_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13486_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13487_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13488_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13489_PotencyDesc = {
    Text = "<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，下个释放的钥令生效 2 次。"
  },
  AwakerPotency_13489_PotencyName = {
    Text = "无限思维迷宫"
  },
  AwakerPotency_13490_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13491_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13492_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13493_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13494_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13495_PotencyDesc = {
    Text = "将手牌中所有的「绿炎」与「腐化绿炎」升级为「死灭绿炎」，之后 3 个回合，每回合开始时重复 1 次该效果。"
  },
  AwakerPotency_13495_PotencyName = {
    Text = "死兆降临"
  },
  AwakerPotency_13496_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13497_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13498_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13499_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13500_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13501_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13502_PotencyDesc = {
    Text = "「海渊之力」选择「篡夺」时，戈利亚获得 25% 临时暴击率；选择 「蛰伏」时，戈利亚获得 25 点狂气。"
  },
  AwakerPotency_13502_PotencyName = {
    Text = "无尽野望"
  },
  AwakerPotency_13503_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13504_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13505_PotencyDesc = {
    Text = "「无形迁移」造成的护盾和反击提高 25%。使选择的唤醒体本回合释放 2 次狂气爆发后才会进入冷却。"
  },
  AwakerPotency_13505_PotencyName = {
    Text = "死而后生"
  },
  AwakerPotency_13506_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13507_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13508_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13509_PotencyDesc = {
    Text = "临时手牌上限+2，并将 2 张 「不规则形态」置入手中，希洛获得 25% 暴击伤害。"
  },
  AwakerPotency_13509_PotencyName = {
    Text = "以血还血"
  },
  AwakerPotency_13510_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13511_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13512_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13514_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13515_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13516_PotencyDesc = {
    Text = "灵知觉醒「第一哲学」获得强化，每次生效时额外使拉蒙娜造成的基础伤害提高 10%。"
  },
  AwakerPotency_13516_PotencyName = {
    Text = "至臻的淬炼"
  },
  AwakerPotency_13517_PotencyDesc = {
    Text = "「封闭创作」立即获得等同于防御力 [Arg1]% 的护盾。（效果随「封闭创作」的等级提升）"
  },
  AwakerPotency_13517_PotencyName = {
    Text = "如歌的雕琢"
  },
  AwakerPotency_13518_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13519_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13520_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13521_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13522_PotencyDesc = {
    Text = "灵知觉醒「调停人格」获得强化， 「24」的指令卡人格效果加成翻倍。「24」释放狂气爆发后人格加成翻倍效果本回合失效。"
  },
  AwakerPotency_13522_PotencyName = {
    Text = "阿尼姆斯投射"
  },
  AwakerPotency_13523_PotencyDesc = {
    Text = "「基础防御」获得 2 次护盾，并获得跃迁：额外获得 1 次狂气。"
  },
  AwakerPotency_13523_PotencyName = {
    Text = "午夜哀歌"
  },
  AwakerPotency_13524_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13525_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13526_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13527_PotencyDesc = {
    Text = "回合结束时图鲁获得 5 点狂气。「螺湮重临」提高 15% 临时暴击率。"
  },
  AwakerPotency_13527_PotencyName = {
    Text = "群星归位"
  },
  AwakerPotency_13528_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13529_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13530_PotencyDesc = {
    Text = "灵知觉醒「自我增殖」获得强化，奥瑞塔的「打击」变为穿刺伤害，并且额外造成 3 次伤害。"
  },
  AwakerPotency_13530_PotencyName = {
    Text = "亮闪闪挚友"
  },
  AwakerPotency_13531_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13532_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13533_PotencyDesc = {
    Text = "「外域手术」虚弱回合数提高 1，治疗量提高 33%。"
  },
  AwakerPotency_13533_PotencyName = {
    Text = "纯粹理性"
  },
  AwakerPotency_13534_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13535_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13536_PotencyDesc = {
    Text = "获得的护盾提高 200%，奥吉尔造成的伤害次数 +1，持续 3 回合。"
  },
  AwakerPotency_13536_PotencyName = {
    Text = "奉献决心"
  },
  AwakerPotency_13537_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13538_PotencyDesc = {
    Text = "战斗开始时，将 1 张「不规则形态」置入手牌。"
  },
  AwakerPotency_13538_PotencyName = {
    Text = "掌政官之女"
  },
  AwakerPotency_13539_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13540_PotencyDesc = {
    Text = "灵知觉醒「迷途之旅」获得强化，每回合中阿格里帕每造成或触发 1 次中毒，回合结束获得的护盾就提高 50%，最大 5 层，阿格里帕施加的中毒效果额外提高 50%。"
  },
  AwakerPotency_13540_PotencyName = {
    Text = "永不复还契约"
  },
  AwakerPotency_13541_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13542_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13543_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13544_PotencyDesc = {
    Text = "受到伤害转化猩红熔炉回复量的效果提高 250%，「基础打击」与「应消之苦」额外享受 100% 力量加成。本次探索内猩红熔炉上限提高最大生命的 2％，至多提高 10％。"
  },
  AwakerPotency_13544_PotencyName = {
    Text = "创生之祭"
  },
  AwakerPotency_13545_PotencyDesc = {
    Text = "每次触发死亡抵抗时，对前排敌人触发 100％ 反击，本场战斗中每次触发死亡抵抗，就使触发反击倍率 +25%。"
  },
  AwakerPotency_13545_PotencyName = {
    Text = "爱之摇篮"
  },
  AwakerPotency_13546_PotencyDesc = {
    Text = "灵知觉醒「复仇宣言」获得强化，打出时立即使「破链一击」的打击加成和「绵长恨怨」的基础伤害提高 50%。"
  },
  AwakerPotency_13546_PotencyName = {
    Text = "最后的审判者"
  },
  AwakerPotency_13547_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13548_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13549_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13550_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13551_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13552_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13553_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13554_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13555_PotencyDesc = {
    Text = "回合结束时，号令所有触腕攻击所有敌人 2 次。"
  },
  AwakerPotency_13555_PotencyName = {
    Text = "应许之日"
  },
  AwakerPotency_13556_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13557_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13558_PotencyDesc = {
    Text = "「血与沙的赞歌」每次吞噬力量加成额外提高 1 倍。"
  },
  AwakerPotency_13558_PotencyName = {
    Text = "巫师的末路"
  },
  AwakerPotency_13559_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13560_PotencyDesc = {
    Text = "灵知觉醒「赐福」获得强化，「造主的庇佑」和「受祝骨血」积攒的猩红熔炉提高 25%。「应消之苦」选择「超度」时每消耗 1% 最大生命的猩红熔炉所提高的最终伤害效果从 2% 提高为 5%。"
  },
  AwakerPotency_13560_PotencyName = {
    Text = "饲世的苦慈"
  },
  AwakerPotency_13561_PotencyDesc = {
    Text = "「基础防御」抽 2 张牌，若不是詹金的卡牌则将其丢弃。"
  },
  AwakerPotency_13561_PotencyName = {
    Text = "金蝴蝶回忆"
  },
  AwakerPotency_13562_PotencyDesc = {
    Text = "「苍白回旋」基础伤害提高 50%，打出后使胚胎融合 +20。"
  },
  AwakerPotency_13562_PotencyName = {
    Text = "蜘蛛女之吻"
  },
  AwakerPotency_13563_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13564_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13565_PotencyDesc = {
    Text = "灵知觉醒「忘我之境」获得强化，珊造成的最终伤害提高 15%，且每有 1 条永久触腕都会使珊造成的护盾和最终伤害提高 3%。"
  },
  AwakerPotency_13565_PotencyName = {
    Text = "物我两忘"
  },
  AwakerPotency_13566_PotencyDesc = {
    Text = "「基础打击」造成 2 次伤害，获得 50% 伤害的临时反击。"
  },
  AwakerPotency_13566_PotencyName = {
    Text = "双生之星"
  },
  AwakerPotency_13567_PotencyDesc = {
    Text = "每当使用钥令时，环行拉蒙娜临时暴击率和临时暴击伤害 +25%。"
  },
  AwakerPotency_13567_PotencyName = {
    Text = "克莱因旅人"
  },
  AwakerPotency_13568_PotencyDesc = {
    Text = "狂气爆发「悖论收束」选择一个任意已解锁的钥令替换当前的钥令，使用钥令后或战斗结束后恢复。"
  },
  AwakerPotency_13568_PotencyName = {
    Text = "莫比乌斯囚徒"
  },
  AwakerPotency_13569_PotencyDesc = {
    Text = "回合结束后获得 1 层负熵。"
  },
  AwakerPotency_13569_PotencyName = {
    Text = "彭罗斯行者"
  },
  AwakerPotency_13570_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13571_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13572_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13573_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13574_PotencyDesc = {
    Text = "使选择的唤醒体回合开始时获得 35 点狂气，持续 3 回合。"
  },
  AwakerPotency_13574_PotencyName = {
    Text = "时空折跃"
  },
  AwakerPotency_13575_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13576_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13577_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13578_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13579_PotencyDesc = {
    Text = "灵知觉醒「黏液汇集」获得强化，狂气爆发使本回合每受到 1 次攻击就使下次「报偿打击」消耗忍耐的效果提高 40%，最多叠加 5 层。"
  },
  AwakerPotency_13579_PotencyName = {
    Text = "无欲的百合"
  },
  AwakerPotency_13580_PotencyDesc = {
    Text = "目标每有 1 层易伤状态，就额外使「石质分解」最终伤害提高 5%，至多提高500%。"
  },
  AwakerPotency_13580_PotencyName = {
    Text = "糖果甜香"
  },
  AwakerPotency_13581_PotencyDesc = {
    Text = "「理性，真理与现实」回复生命 +25%，造成的狂气对朵尔也生效。"
  },
  AwakerPotency_13581_PotencyName = {
    Text = "超越躯壳"
  },
  AwakerPotency_13582_PotencyDesc = {
    Text = "「机械武装-放」将 1 张拥有消耗的「基础打击」置入手中，「机械武装-敛」将 1 张拥有消耗的 「基础防御」置入手中。"
  },
  AwakerPotency_13582_PotencyName = {
    Text = "自我修正"
  },
  AwakerPotency_13583_PotencyDesc = {
    Text = "「电磁爆破」享受额外 1 倍力量和戒备加成。"
  },
  AwakerPotency_13583_PotencyName = {
    Text = "强制回路"
  },
  AwakerPotency_13584_PotencyDesc = {
    Text = "每消耗 1 点黑印，就使「肆意豪赌」的基础伤害在本次探索中提高 0.5%。莱克的「基础打击」和「基础防御」若算力不足时可消耗 3 黑印打出并生效 2 次。"
  },
  AwakerPotency_13584_PotencyName = {
    Text = "稳赚不赔"
  },
  AwakerPotency_13585_PotencyDesc = {
    Text = "若当前生命低于 50%，「基础打击」造成 2 次伤害，胚胎融合 +10。「基础防御」获得 2 次护盾，胚胎融合 +10。"
  },
  AwakerPotency_13585_PotencyName = {Text = "溪流"},
  AwakerPotency_13586_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13587_PotencyDesc = {
    Text = "灵知觉醒「维修大师」获得强化，所有唤醒体固定反击提高 30%。"
  },
  AwakerPotency_13587_PotencyName = {
    Text = "王牌机械师"
  },
  AwakerPotency_13588_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13589_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13590_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13591_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13592_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13593_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13594_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13595_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13596_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13597_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13598_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13599_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13600_PotencyDesc = {
    Text = "额外将「千面幻象」的 2 张复制置入手中，「断颈一击」本场战斗中基础伤害提高 50%。"
  },
  AwakerPotency_13600_PotencyName = {
    Text = "幻雾迷烟"
  },
  AwakerPotency_13601_PotencyDesc = {
    Text = "「意外收获」若暴击还会使选择的卡牌算力消耗额外降低 1。「摊牌时刻」每次暴击莱克都会额外获得 3 点狂气。"
  },
  AwakerPotency_13601_PotencyName = {
    Text = "强运加倍"
  },
  AwakerPotency_13603_PotencyDesc = {
    Text = "「同伴的力量」额外抽 1 张牌。"
  },
  AwakerPotency_13603_PotencyName = {
    Text = "噗噜噜旅行"
  },
  AwakerPotency_13604_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13605_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13606_PotencyDesc = {
    Text = "「肆意豪赌」造成 3 次伤害，使抽到的卡牌算力消耗降低 1。"
  },
  AwakerPotency_13606_PotencyName = {Text = "Jackpot！"},
  AwakerPotency_13607_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13608_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13609_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13610_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13611_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13612_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13613_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13614_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13615_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13616_PotencyDesc = {
    Text = "战斗开始时，将 1 张「不规则形态 · 血链」置入手牌。「缚身锁链」破除目标护盾并使目标无法获得护盾，持续 1 回合。"
  },
  AwakerPotency_13616_PotencyName = {
    Text = "余孽送葬"
  },
  AwakerPotency_13617_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13618_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13619_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13620_PotencyDesc = {
    Text = "造成伤害前对全体敌方施加 1 层「易伤」，获得等同于攻击力 [Arg1]% 的反击。"
  },
  AwakerPotency_13620_PotencyName = {
    Text = "甘之如饴"
  },
  AwakerPotency_13621_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13622_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13623_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13624_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13625_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13626_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13627_PotencyDesc = {
    Text = "释放「自我的葬仪」后，在本场战斗中使「自我的葬仪」施加的中毒层数提高等同于攻击力 [Arg1]%（效果随「自我的葬仪」的等级提高）。"
  },
  AwakerPotency_13627_PotencyName = {
    Text = "雪浪浮花"
  },
  AwakerPotency_13628_PotencyDesc = {
    Text = "接下来 3 回合内，每回合开始时尝试将 1 张「胚胎」转化为「圣洁之子」，如果没有「胚胎」则<EmbryoFusionIconKeywords:胚胎融合> +100，不受胚胎融合提高效果影响。"
  },
  AwakerPotency_13628_PotencyName = {
    Text = "永续圣骸的传承"
  },
  AwakerPotency_13629_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13630_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13631_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13632_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13633_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13634_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13635_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13636_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13637_PotencyDesc = {
    Text = "使随机 5 张手牌直到回合结束时算力消耗变为 0。"
  },
  AwakerPotency_13637_PotencyName = {
    Text = "纵贯寰宇的音律"
  },
  AwakerPotency_13638_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13639_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13640_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13641_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13642_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13643_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13644_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13645_PotencyDesc = {
    Text = "「祭仪」效果提高 30%。每将 1 张「圣礼」转化为「执妄」，本场战斗中弥利亚姆造成的基础伤害和「向深渊祝祷」造成的基础中毒提高 15%。"
  },
  AwakerPotency_13645_PotencyName = {
    Text = "泡影幻灭"
  },
  AwakerPotency_13646_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13656_PotencyDesc = {
    Text = "「狂热之海」享受触腕伤害加成提高为 100%。"
  },
  AwakerPotency_13656_PotencyName = {
    Text = "崎岖海岸"
  },
  AwakerPotency_13657_PotencyDesc = {
    Text = "「异种共生」获得的狂气提高 2 点。处于抑郁人格时虚弱所有敌人 1 回合，处于躁狂人格时易伤所有敌人 1 回合。"
  },
  AwakerPotency_13657_PotencyName = {Text = "拘束带"},
  AwakerPotency_13658_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13659_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13660_PotencyDesc = {
    Text = "「深渊号令」使触腕攻击所有敌人，若当前姿态为「静海」，算力消耗降低 2 。"
  },
  AwakerPotency_13660_PotencyName = {
    Text = "暗夜呢喃"
  },
  AwakerPotency_13661_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13662_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13663_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_13664_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13665_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13666_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13667_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13668_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13669_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13670_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13671_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13672_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13673_PotencyDesc = {
    Text = "抽 2 张阿格里帕的非打击防御指令卡，使 2 张手中阿格里帕的非打击防御指令卡本回合算力消耗 -1。"
  },
  AwakerPotency_13673_PotencyName = {
    Text = "迷宫之主"
  },
  AwakerPotency_13674_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13675_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13677_PotencyDesc = {
    Text = "回合开始时积攒等同于体质 6% 的猩红熔炉回复量。狂气爆发「造主的庇佑」使萨尔瓦多获得 35% 临时暴击伤害。"
  },
  AwakerPotency_13677_PotencyName = {
    Text = "予以救赎"
  },
  AwakerPotency_13678_PotencyDesc = {
    Text = "回合结束时 「24」 获得 10 点狂气。 「24」 每次释放狂气爆发后，本场战斗内这个效果获得的狂气提高 1 点。"
  },
  AwakerPotency_13678_PotencyName = {
    Text = "巴甫洛夫行为研究"
  },
  AwakerPotency_13679_PotencyDesc = {
    Text = "升级所有消耗<DreamGuide:梦引>时的效果：「死梦之都」消耗 5 层时额外获得 15 点狂气，消耗 10 层时额外造成 5% 伤害降低；「脊刺锁链」降低力量效果翻倍；「迷途之守」额外获得的反击量提高 50% 。"
  },
  AwakerPotency_13679_PotencyName = {
    Text = "湖中栖物"
  },
  AwakerPotency_13680_PotencyDesc = {
    Text = "「基础打击」造成 2 次伤害，并获得跃迁：额外造成 1 次伤害。"
  },
  AwakerPotency_13680_PotencyName = {
    Text = "响彻星穹"
  },
  AwakerPotency_13681_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13682_PotencyDesc = {
    Text = "灵知觉醒「空间折叠」获得强化，詹金自身从「空间折叠」和「雾都街童」中获得 2 倍暴击伤害效果。"
  },
  AwakerPotency_13682_PotencyName = {
    Text = "自雾中归来"
  },
  AwakerPotency_13683_PotencyDesc = {
    Text = "灵知觉醒「蜕变之躯」获得强化，凯刻斯打出卡牌后使 1 条触腕进行攻击并获得 50% 造成伤害的反击。"
  },
  AwakerPotency_13683_PotencyName = {
    Text = "不全者怒潮"
  },
  AwakerPotency_13684_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13685_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13686_PotencyDesc = {
    Text = "战斗结束后额外获得 5 黑印，该效果受黑印掉落加成。旺达打出卡牌后，获得 1 层<DreamGuide:梦引>，该效果每回合至多生效 2 次。"
  },
  AwakerPotency_13686_PotencyName = {
    Text = "裘皮与维纳斯"
  },
  AwakerPotency_13687_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13688_PotencyDesc = {
    Text = "「恨意宣泄」若生命低于 50%，获得的力量翻倍。「嗜血链球」的预备效果变更为预备 2。"
  },
  AwakerPotency_13688_PotencyName = {
    Text = "纵情复仇"
  },
  AwakerPotency_13689_PotencyDesc = {
    Text = "「报偿打击」预备 1 升级为预备 2，基础伤害和暴击率提高 20%。"
  },
  AwakerPotency_13689_PotencyName = {
    Text = "粘稠吞噬"
  },
  AwakerPotency_13690_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13691_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13692_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13693_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13694_PotencyDesc = {
    Text = "将 1 张附加<DepleteIconKeywords:消耗>的「超级大集结！」置入手牌。"
  },
  AwakerPotency_13694_PotencyName = {Text = "偷袭！"},
  AwakerPotency_13695_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13696_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13697_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13698_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13699_PotencyDesc = {
    Text = "「丧钟遥鸣」施加的中毒提高 100%，获得等同于防御力 [Arg1]% 的护盾（效果随「丧钟遥鸣」的等级提高）。"
  },
  AwakerPotency_13699_PotencyName = {
    Text = "海之躯体"
  },
  AwakerPotency_13700_PotencyDesc = {
    Text = "灵知觉醒「演出序幕」获得强化，所有唤醒体打出「打击」时都能触发该效果获得临时力量。"
  },
  AwakerPotency_13700_PotencyName = {
    Text = "一千零一场奇迹"
  },
  AwakerPotency_13701_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13702_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13703_PotencyDesc = {
    Text = "每拥有 1 条触腕「诞妄·墨菲」暴击率 +3%，每拥有 1% 最大生命的「献祭」或「延迟献祭」，「诞妄·墨菲」暴击伤害 +3%。"
  },
  AwakerPotency_13703_PotencyName = {
    Text = "倒悬之孕"
  },
  AwakerPotency_13704_PotencyDesc = {
    Text = "「打击」或「防御」抽 1 张「深海圣咏」，每回合最多生效 1 次。"
  },
  AwakerPotency_13704_PotencyName = {
    Text = "渎神终末"
  },
  AwakerPotency_13705_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13706_PotencyDesc = {
    Text = "「螺湮圆舞」触腕伤害、护盾、最终伤害提高 10%，每拥有 1 点银钥充能等级额外提高 0.2%。"
  },
  AwakerPotency_13706_PotencyName = {
    Text = "屈膝者的哀祷"
  },
  AwakerPotency_13710_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13711_PotencyDesc = {
    Text = "「高热区禁入」获得预备1。"
  },
  AwakerPotency_13711_PotencyName = {
    Text = "缺失的螺母"
  },
  AwakerPotency_13712_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13713_PotencyDesc = {
    Text = "灵知觉醒「无边星彩」获得强化，打出时立即永久偷取所有敌人等同于攻击力 25% 的力量。"
  },
  AwakerPotency_13713_PotencyName = {
    Text = "永芜的枯萎虹彩"
  },
  AwakerPotency_13714_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13715_PotencyDesc = {
    Text = "战斗开始后，胚胎融合 +25，每次触发死亡抵抗，胚胎融合 +25。索蕾尔每次造成伤害，使本回合内自身造成伤害提高等同于攻击力 4%。"
  },
  AwakerPotency_13715_PotencyName = {Text = "明珠"},
  AwakerPotency_13716_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13717_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13718_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13719_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13720_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13721_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13722_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13723_PotencyName = {
    Text = "红色缎带"
  },
  AwakerPotency_13724_PotencyDesc = {
    Text = "「不死的极乐鸟」触发复活后，所有唤醒体获得 25 点狂气，并间隔 6 回合后可再次施加复活效果。"
  },
  AwakerPotency_13724_PotencyName = {
    Text = "无喜无悲"
  },
  AwakerPotency_13725_PotencyDesc = {
    Text = "「纯白梦境」每保留 1 回合，下次打出时回复生命就额外提高等同于体质的 [Arg1]%（效果随「纯白梦境」的等级提升）。"
  },
  AwakerPotency_13725_PotencyName = {
    Text = "先祖的指引"
  },
  AwakerPotency_13726_PotencyDesc = {
    Text = "获得 3 层无视上限的负熵，使获得的复制卡算力消耗变为 0 。"
  },
  AwakerPotency_13726_PotencyName = {
    Text = "伸向旧日的指尖"
  },
  AwakerPotency_13727_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_13728_PotencyDesc = {
    Text = "「混沌之兽」造成的伤害次数+1 ，额外将 2 张附加消耗与虚无的「基础打击」置入手中。"
  },
  AwakerPotency_13728_PotencyName = {
    Text = "久远的孤寂"
  },
  AwakerPotency_13729_PotencyDesc = {
    Text = "「纷乱切割」基础伤害提高 33%。处于抑郁人格时使对应卡牌算力消耗额外降低 1，处于躁狂人格时伤害次数额外提高 1。"
  },
  AwakerPotency_13729_PotencyName = {
    Text = "歇斯底里"
  },
  AwakerPotency_13730_PotencyDesc = {
    Text = "奥尔拉的所有诗篇均获得保留。"
  },
  AwakerPotency_13730_PotencyName = {
    Text = "囚于暗室"
  },
  AwakerPotency_13731_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142823_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142824_PotencyDesc = {
    Text = "每回合首次「打击」和首次「防御」抽 1 张「囚魇」。「囚魇」获得「余波：算力消耗-1」。"
  },
  AwakerPotency_142824_PotencyName = {
    Text = "缺位狂欢"
  },
  AwakerPotency_142825_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142826_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142827_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142828_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142829_PotencyDesc = {
    Text = "「猎杀之魇」固定伤害提高 10%，「无休猎宴」基础力量降低效果提高 5%。庞托斯唤醒体自身、命轮、密契每拥有 1% 暴击伤害就使「猎杀之魇」固定伤害额外提高 0.2%，「无休猎宴」基础力量降低效果额外提高 0.1%。"
  },
  AwakerPotency_142829_PotencyName = {
    Text = "向光之饵"
  },
  AwakerPotency_142830_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142831_PotencyDesc = {
    Text = "灵知觉醒「囚渊的怒仇」获得强化，每回合首次「打击」和首次「防御」额外获得 15 点狂气。获得「围猎」所需的「囚魇」数由 3 降低为 2。"
  },
  AwakerPotency_142831_PotencyName = {
    Text = "至深至静的侵吞"
  },
  AwakerPotency_142832_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142833_PotencyDesc = {
    Text = "造成固定伤害变为 3 倍。若造成击杀额外生成 1 张「囚魇」。使各处「囚魇」算力消耗 -1。"
  },
  AwakerPotency_142833_PotencyName = {
    Text = "另一个厄波扬斯"
  },
  AwakerPotency_142834_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142835_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_142836_PotencyDesc = {
    Text = "「纵魇掠袭」基础伤害提高 25％，伤害和狂气效果生效 X+1 次。"
  },
  AwakerPotency_142836_PotencyName = {Text = "空躯壳"},
  AwakerPotency_142837_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145364_PotencyDesc = {
    Text = "「基础打击」抽取 1 张「短刃·噬」，「基础防御」抽取 1 张「长刃·陨」，每回合最多各生效 1 次。"
  },
  AwakerPotency_145364_PotencyName = {
    Text = "不灭战意"
  },
  AwakerPotency_145365_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145366_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145367_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145368_PotencyDesc = {
    Text = "造成伤害前获得等同于「巨剑·鲸落」使目标提高伤害值的力量，本次狂气爆发力量加成翻倍。"
  },
  AwakerPotency_145368_PotencyName = {
    Text = "斩落鲸天之夜"
  },
  AwakerPotency_145369_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145370_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145371_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145372_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145373_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145374_PotencyDesc = {
    Text = "「断界之剑」从「巨剑·鲸落」获得的伤害加成翻倍。每回合首次「蚀灭」不再消耗算力。"
  },
  AwakerPotency_145374_PotencyName = {
    Text = "无冕风暴"
  },
  AwakerPotency_145375_PotencyDesc = {
    Text = "灵知觉醒「亘古归源」获得强化，「蚀灭」通过偷取获得的狂气、最终伤害加成、最终伤害加成叠加上限提高 50％。"
  },
  AwakerPotency_145375_PotencyName = {
    Text = "万古孤临"
  },
  AwakerPotency_145376_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145377_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_145378_PotencyDesc = {
    Text = "蚀灭·萝坦「打击」暴击率 +10％，基础伤害 +20％。蚀灭·萝坦唤醒体自身、命轮、密契每有 1％ 黑印掉落，「打击」暴击率 +0.5％，基础伤害 +1％。"
  },
  AwakerPotency_145378_PotencyName = {
    Text = "腐朽遗骸"
  },
  AwakerPotency_147398_PotencyName = {Text = "孤岛"},
  AwakerPotency_147399_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147400_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147401_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147402_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147403_PotencyName = {
    Text = "超限爆发"
  },
  AwakerPotency_147404_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147405_PotencyName = {
    Text = "她的摇篮曲"
  },
  AwakerPotency_147406_PotencyName = {
    Text = "等待，等待"
  },
  AwakerPotency_147407_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147408_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147409_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147410_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147411_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_147412_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148460_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148461_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148462_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148463_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148464_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148465_PotencyDesc = {
    Text = "「未陨的骑士心」造成的护盾和力量倍率提高 20%，每层「暗涌」使负誓·奥吉尔暴击伤害提高 10%。\n负誓·奥吉尔唤醒体自身、命轮、密契每有 1% 暴击率，「未陨的骑士心」造成的护盾和力量倍率额外提高 0.6%，每层「暗涌」使负誓·奥吉尔暴击伤害额外提高 0.3%。"
  },
  AwakerPotency_148465_PotencyName = {
    Text = "为扞卫伫立"
  },
  AwakerPotency_148466_PotencyDesc = {
    Text = "灵知觉醒「与黑沼共生」获得强化，「染罪枪锋」基础伤害提高 100%，额外享受 200% 力量加成，「防御」的护盾提高效果变为 100%。"
  },
  AwakerPotency_148466_PotencyName = {
    Text = "誓约，一如往初"
  },
  AwakerPotency_148467_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148468_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148469_PotencyDesc = {
    Text = "获得的力量变为 3 倍。"
  },
  AwakerPotency_148469_PotencyName = {
    Text = "以我为壁"
  },
  AwakerPotency_148470_PotencyDesc = {
    Text = "每层「暗涌」使指令卡最终伤害提高效果变为 50%，「未陨的骑士心」每消耗 1 层「暗涌」造成的护盾和力量提高效果变为 50%。"
  },
  AwakerPotency_148470_PotencyName = {
    Text = "为大义殒身"
  },
  AwakerPotency_148471_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148472_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148473_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_148474_PotencyDesc = {
    Text = "「打击」额外生效 1 次。"
  },
  AwakerPotency_148474_PotencyName = {
    Text = "为微光铭记"
  },
  AwakerPotency_21727_PotencyDesc = {
    Text = "「七艺，传承美德」获得的护盾和临时力量提高 20%， 若自身处于脆弱状态，「七艺，传承美德」额外获得 33% 的护盾。"
  },
  AwakerPotency_21727_PotencyName = {
    Text = "怜悯，以助弱小"
  },
  AwakerPotency_21728_PotencyDesc = {
    Text = "「穿刺之枪」易伤回合数 +1，基础伤害 +100%，力量加成倍数提高 1。"
  },
  AwakerPotency_21728_PotencyName = {
    Text = "诚实，以忠自我"
  },
  AwakerPotency_21738_PotencyDesc = {
    Text = "「不定壁垒」获得的护盾提高 43%，获得等同于攻击力 [Arg1]% 的力量（效果随「不定壁垒」的等级提高）。"
  },
  AwakerPotency_21738_PotencyName = {
    Text = "牺牲，以全大义"
  },
  AwakerPotency_54159_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54160_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54161_PotencyDesc = {
    Text = "灵知觉醒「穿越银钥之门」获得强化，塔薇释放狂气爆发后其他唤醒体本回合指令卡最终伤害 +15%，还会使下 1 张其他唤醒体指令卡额外生效 1 次。"
  },
  AwakerPotency_54161_PotencyName = {
    Text = "创生真理"
  },
  AwakerPotency_54162_PotencyDesc = {
    Text = "「基础打击」和 「基础防御」获得等同于攻击力 15% 的临时力量。若其触发「乐音」效果，获得的临时力量翻倍。"
  },
  AwakerPotency_54162_PotencyName = {
    Text = "心灵协奏"
  },
  AwakerPotency_54163_PotencyDesc = {
    Text = "「回环乐音」使赋予的卡牌算力消耗 -2。"
  },
  AwakerPotency_54163_PotencyName = {
    Text = "梦中圆舞"
  },
  AwakerPotency_54164_PotencyDesc = {
    Text = "触发「乐音」效果或打出 「协乐的交响」后，哈姆林获得 1% 暴击率和暴击伤害。每触发 10 次，本场战斗「灵魂序曲」和「原初的乐音」伤害次数提高 1，最多提高 3 次。"
  },
  AwakerPotency_54164_PotencyName = {
    Text = "月下狂想"
  },
  AwakerPotency_54165_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54166_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54167_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54168_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54169_PotencyDesc = {
    Text = "每次造成伤害会对目标随机施加 1 种奇妙负面效果，额外选择 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「回环乐音」。"
  },
  AwakerPotency_54169_PotencyName = {
    Text = "终末的奏鸣"
  },
  AwakerPotency_54170_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54171_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54172_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54173_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54174_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使塔薇获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_54174_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_54175_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_54175_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_54176_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_54176_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_54177_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54178_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54179_PotencyDesc = {
    Text = "灵知觉醒「此曲应得称颂」获得强化，回合开始时每有 1 张指令卡拥有乐音，哈姆林获得 5 点狂气。哈姆林释放狂气爆发时每存在 2 张指令卡拥有乐音，伤害次数+1。"
  },
  AwakerPotency_54179_PotencyName = {
    Text = "万界于此鸣响"
  },
  AwakerPotency_54180_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54181_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54182_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54183_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54184_PotencyDesc = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 35%，发现的技能卡数量由 5 张改为 10 张并立即获得 3 算力。"
  },
  AwakerPotency_54184_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_54185_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54186_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54187_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_54188_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78946_PotencyDesc = {
    Text = "「混沌旗语」虚弱所有敌人 1 回合。每有 1 条触腕，「领航」护盾、力量、触腕伤害提高 5%，至多提高 50%。"
  },
  AwakerPotency_78946_PotencyName = {
    Text = "六分仪的测算"
  },
  AwakerPotency_78947_PotencyDesc = {
    Text = "「照彻渊海的引航」易伤所有敌人 1 回合，临时暴击伤害提高 30％，本场战斗每触发过 1 次死亡抵抗额外提高 15％。"
  },
  AwakerPotency_78947_PotencyName = {
    Text = "无悔的牺牲"
  },
  AwakerPotency_78948_PotencyDesc = {
    Text = "「基础打击」和「基础防御」获得狂气提高 5 点，获得「余波」：下次打出获得的狂气提高 5，最多叠加 2 次。"
  },
  AwakerPotency_78948_PotencyName = {
    Text = "北极星的密语"
  },
  AwakerPotency_78949_PotencyDesc = {
    Text = "灵知觉醒「翱翔夙愿」获得强化，卡斯托尔每回合首次打出黑羽时对前排敌人造成等同于天赋「圣羽洗罪」的侵蚀，侵蚀移除时失去的生命由 300% 提高为 500%。"
  },
  AwakerPotency_78949_PotencyName = {
    Text = "涤罪永夜"
  },
  AwakerPotency_78950_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78951_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78952_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78954_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78961_PotencyDesc = {
    Text = "灵知觉醒「妖虫的呼唤」获得强化，克莱门汀造成的伤害次数 +1，「共感」上限提高为 20。"
  },
  AwakerPotency_78961_PotencyName = {
    Text = "集体无意识空间"
  },
  AwakerPotency_78962_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78965_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78968_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78970_PotencyDesc = {
    Text = "「打击」和「防御」造成的基础伤害、护盾、狂气提高 50%。"
  },
  AwakerPotency_78970_PotencyName = {
    Text = "不熄之焰"
  },
  AwakerPotency_78971_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78972_PotencyDesc = {
    Text = "额外将 3 张「黑羽」置入手中。本回合黑羽保留的护盾提高卡斯托尔防御力的 10％，每次打出「黑羽」额外对目标施加卡斯托尔攻击力 160％ 的「侵蚀」。"
  },
  AwakerPotency_78972_PotencyName = {
    Text = "飞跃荆棘海"
  },
  AwakerPotency_78975_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78976_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78977_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78981_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78982_PotencyDesc = {
    Text = "灵知觉醒「沉没于远海」获得强化，克珀珊特每回合首张「惩戒雷霆」和「混沌旗语」额外置入 1 张「领航」到手中，「领航」效果提高 50%。"
  },
  AwakerPotency_78982_PotencyName = {
    Text = "不熄、不灭、不烬"
  },
  AwakerPotency_78983_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78984_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78985_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78986_PotencyDesc = {
    Text = "生成手中和超维空间最多 5 张具有「奇点信标」卡牌的临时原始复制，将其随机置入抽牌堆和弃牌堆并使其算力消耗变为 0。"
  },
  AwakerPotency_78986_PotencyName = {
    Text = "凌驾命运的悲歌"
  },
  AwakerPotency_78987_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78988_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78989_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78990_PotencyDesc = {
    Text = "手中每有 1 张「黑羽」，「蔽日之羽」打出后获得 5 点狂气。\n每打出 1 张「黑羽」，「穿行永夜」本回合算力消耗降低 1 点。"
  },
  AwakerPotency_78990_PotencyName = {
    Text = "不灭不移之志"
  },
  AwakerPotency_78991_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78992_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78993_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78994_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78996_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_78997_PotencyDesc = {
    Text = "「粉雪魔咒」造成的固定伤害提高 30%，并获得 10 点狂气。卡拉布唤醒体自身、命轮、密契每拥有1 点界域精通，「粉雪魔咒」造成的固定伤害提高 0.15%，获得的狂气提高 0.05 点"
  },
  AwakerPotency_78997_PotencyName = {
    Text = "秘密修行"
  },
  AwakerPotency_78998_PotencyDesc = {
    Text = "发现 2 组「礼物」不同的「赐福」，每组包含 2 张，选择 1 组置入手中。 使所有敌人永久降低等同于防御力 9% 的力量。"
  },
  AwakerPotency_78998_PotencyName = {
    Text = "童话天衣无缝"
  },
  AwakerPotency_78999_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79000_PotencyDesc = {
    Text = "获得克莱门汀攻击力 50％ 的力量和 300％ 克莱门汀银钥充能的银钥能量。移除「共感」时，同时触发「精神创伤」与「恐惧固着」效果。"
  },
  AwakerPotency_79000_PotencyName = {
    Text = "潜意识侵蚀"
  },
  AwakerPotency_79001_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79002_PotencyDesc = {
    Text = "本源沉睡之主造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79002_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79003_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79004_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79005_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79006_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79007_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79008_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79009_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79010_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79011_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79012_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79013_PotencyDesc = {
    Text = "战斗开始时获得 5 层「共感」。「生命重构治疗」基础伤害提高 20%。"
  },
  AwakerPotency_79013_PotencyName = {
    Text = "叩响心智门扉"
  },
  AwakerPotency_79014_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79016_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79016_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79017_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79019_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79020_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79021_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79024_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79024_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79025_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79025_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79026_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使兰提戈斯获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79026_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79027_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79027_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79028_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79029_PotencyDesc = {
    Text = "卡拉布狂气爆发伤害次数 +2。「饱餐」每层提供的生命上限加成效果提高 50%，狂气爆发基础伤害与护盾加成效果提高 50%。"
  },
  AwakerPotency_79029_PotencyName = {
    Text = "三重宣誓"
  },
  AwakerPotency_79030_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79031_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79033_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79034_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79035_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79039_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79039_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79040_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79040_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79041_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79042_PotencyDesc = {
    Text = "秃鹫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79042_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79043_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79045_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79045_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79046_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使黑法老获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79046_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79047_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79048_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79048_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79049_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79050_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79051_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79052_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79052_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79053_PotencyDesc = {
    Text = "卡拉布每第 7 次打出「打击」或「防御」时，获得 1 层「供奉」并发现 2 张「代价」不同的「赐福」，选择 1 张置入手中。"
  },
  AwakerPotency_79053_PotencyName = {
    Text = "七重礼拜"
  },
  AwakerPotency_79054_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79055_PotencyDesc = {
    Text = "每打出 3 张「黑羽」，获得 1 点算力并使卡斯托尔本场战斗造成的最终伤害提高 10%。"
  },
  AwakerPotency_79055_PotencyName = {
    Text = "遮盖天幕之翼"
  },
  AwakerPotency_79056_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79056_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79058_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79059_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79060_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79061_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79062_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79063_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使夏塔克鸟获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79063_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79064_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79065_PotencyDesc = {
    Text = "获得 3 条触腕，弃置的手牌「余波」效果额外生效 1 次。"
  },
  AwakerPotency_79065_PotencyName = {
    Text = "赴死如归的天火"
  },
  AwakerPotency_79066_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79067_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79068_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79068_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79069_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79070_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79071_PotencyDesc = {
    Text = "灵知觉醒「木偶戏场揭幕」获得强化，释放「湮灭」后立刻对所有敌人造成等同于 50％「命运裁断」的纯粹伤害伤害，下次狂气爆发造成的伤害强效和护盾提高 50％。"
  },
  AwakerPotency_79071_PotencyName = {
    Text = "摩伊赖的终章"
  },
  AwakerPotency_79072_PotencyDesc = {
    Text = "兰提戈斯造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79072_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79073_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79074_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79075_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79076_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79077_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79078_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79079_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79080_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79081_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79082_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79083_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79084_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79085_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79086_PotencyDesc = {
    Text = "灵知觉醒「净世之路」获得强化，「圣心」因打出而洗入抽牌堆后，该「圣心」本回合算力消耗变为 0 且额外造成 100％ 伤害的出血。"
  },
  AwakerPotency_79086_PotencyName = {
    Text = "圣心长明"
  },
  AwakerPotency_79087_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79088_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79089_PotencyDesc = {
    Text = "战斗开始时赋予凯蒂古拉所有原始指令卡 1 层「活焰」。每获得 1 层「爆炎」凯蒂古拉本场战斗基础伤害提高 5%。"
  },
  AwakerPotency_79089_PotencyName = {
    Text = "无尽炼狱"
  },
  AwakerPotency_79090_PotencyDesc = {
    Text = "灵知觉醒「业火重燃」获得强化，凯蒂古拉每层「活焰」的最终伤害和力量效果 +30%。"
  },
  AwakerPotency_79090_PotencyName = {
    Text = "烬灭终局"
  },
  AwakerPotency_79091_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79093_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79096_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79097_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79098_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79099_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79100_PotencyDesc = {
    Text = "夏塔克鸟造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79100_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79101_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79102_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79103_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使秃鹫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79103_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79104_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79105_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79106_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79107_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79108_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79118_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79118_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79119_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79120_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79121_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79122_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79123_PotencyDesc = {
    Text = "战斗开始时，将 1 张「黑羽」置入手中。"
  },
  AwakerPotency_79123_PotencyName = {
    Text = "囚于地底之鸟"
  },
  AwakerPotency_79124_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79125_PotencyDesc = {
    Text = "黑法老造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79125_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79126_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79127_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79128_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79129_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79131_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使本源沉睡之主获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79131_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79132_PotencyDesc = {
    Text = "「生命重构治疗」额外获得 200％ 克莱门汀银钥充能的银钥能量。每移除 1 层「共感」，使克莱门汀造成的基础伤害提高 3%。每场战斗结束后，使克莱门汀造成的基础伤害提高 25％。"
  },
  AwakerPotency_79132_PotencyName = {
    Text = "灵魂治愈之旅"
  },
  AwakerPotency_79133_PotencyDesc = {
    Text = "回合结束时获得 2 层「共感」。「共感」、「精神创伤」、「恐惧固着」的堆叠层数上限提高为 15。"
  },
  AwakerPotency_79133_PotencyName = {
    Text = "你终将痊愈"
  },
  AwakerPotency_79134_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79135_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79136_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79137_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使亚弗戈蒙获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79137_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79138_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79139_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79140_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79141_PotencyDesc = {
    Text = "亚弗戈蒙造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79141_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79142_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79143_PotencyDesc = {
    Text = "灵知觉醒「诱人蜜果」获得强化，使用猩红熔炉后，使下一次「奇迹赐福」发现效果每组额外包含 1 张「赐福」。打出「赐福」后，胚胎融合 +10，当前生命越低则效果越高，至多提高 100%。"
  },
  AwakerPotency_79143_PotencyName = {
    Text = "新月高悬中天"
  },
  AwakerPotency_79144_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79145_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79146_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79147_PotencyDesc = {
    Text = "创构的「刻印」升级为「高级刻印」，创构的「白银造物」升级为「黄金造物」。"
  },
  AwakerPotency_79147_PotencyName = {
    Text = "中心刻绘"
  },
  AwakerPotency_79148_PotencyDesc = {
    Text = "皮克曼消耗「创意」后自身额外获得 50 点狂气，本回合皮克曼能够释放 2 次狂气爆发。"
  },
  AwakerPotency_79148_PotencyName = {
    Text = "缪斯的呼唤"
  },
  AwakerPotency_79149_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79150_PotencyDesc = {
    Text = "「打击」或「防御」抽 1 张出战唤醒体的「技能」，每回合最多生效 1 次。"
  },
  AwakerPotency_79150_PotencyName = {
    Text = "交叉画法"
  },
  AwakerPotency_79151_PotencyDesc = {
    Text = "「圣心」因第 3 次打出消耗时，使自身下一张指令卡额外生效 1 次。"
  },
  AwakerPotency_79151_PotencyName = {
    Text = "神启新约"
  },
  AwakerPotency_79152_PotencyDesc = {
    Text = "每有 1 张手牌，「打击」与「防御」额外获得 1 点狂气。\n每打出 1 张「圣心」，下次打出的「离垢的审判」算力消耗降低 1 点。"
  },
  AwakerPotency_79152_PotencyName = {
    Text = "救世光焰"
  },
  AwakerPotency_79153_PotencyDesc = {
    Text = "战斗开始时，将 1 张「圣心」置入手中。"
  },
  AwakerPotency_79153_PotencyName = {
    Text = "持灯神使"
  },
  AwakerPotency_79154_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79155_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79156_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79157_PotencyDesc = {
    Text = "「千兆耀斑」具有 3 层「活焰」时，基础伤害提高 50%。「末路枪声」具有 3 层「活焰」时，获得的力量提高凯蒂古拉攻击力的 3％。"
  },
  AwakerPotency_79157_PotencyName = {
    Text = "千星熔解"
  },
  AwakerPotency_79161_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79162_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79163_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79164_PotencyDesc = {
    Text = "灵知觉醒「墓园画室」获得强化，「绘影摹形」创构的黄金造物持续回合数由 1 回合提高为 2 回合。"
  },
  AwakerPotency_79164_PotencyName = {
    Text = "画中世界"
  },
  AwakerPotency_79165_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79166_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79167_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79168_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79169_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79170_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79171_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79172_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79173_PotencyDesc = {
    Text = "本回合内波吕克斯每张指令卡额外享受 50% 「苦痛救赎」效果，额外将 1 张「圣心」置入手中。自身下一张指令卡额外生效 1 次。"
  },
  AwakerPotency_79173_PotencyName = {
    Text = "照彻白夜之光"
  },
  AwakerPotency_79174_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79175_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79176_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79177_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79178_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79179_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79180_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79181_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79182_PotencyDesc = {
    Text = "获得 1 层「狂想」并额外「发现」1 次。"
  },
  AwakerPotency_79182_PotencyName = {
    Text = "艺术，即为疯狂"
  },
  AwakerPotency_79183_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79184_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79185_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79186_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79187_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79188_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79189_PotencyDesc = {
    Text = "额外造成 2 次伤害，改为随机为手中凯蒂古拉的指令卡分配 5 层「活焰」。"
  },
  AwakerPotency_79189_PotencyName = {
    Text = "融于万物的真理"
  },
  AwakerPotency_79190_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79191_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79192_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79193_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79194_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79195_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79196_PotencyDesc = {
    Text = "阿拉克涅狂气爆发造成的临时伤害强效提高 25%。阿拉克涅唤醒体自身、命轮、密契每拥有 1 点界域精通，造成的临时伤害强效效果额外提高 0.25%。"
  },
  AwakerPotency_79196_PotencyName = {
    Text = "未来如我所见"
  },
  AwakerPotency_79197_PotencyDesc = {
    Text = "「永恒织造」造成的「命运裁断」提高 50%。「缚命罗网」获得「预备」和「保留」。"
  },
  AwakerPotency_79197_PotencyName = {
    Text = "万物如我所思"
  },
  AwakerPotency_79198_PotencyDesc = {
    Text = "「织命」上限由 3 提高为 5，「无尽线缕」获取的「奇点棱镜」翻倍。"
  },
  AwakerPotency_79198_PotencyName = {
    Text = "宿命如我所织"
  },
  AwakerPotency_79199_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79214_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79215_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79216_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79217_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79218_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79219_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79220_PotencyDesc = {
    Text = "训练模式友方校猫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79220_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79221_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79222_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79223_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79223_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_79224_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79224_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79225_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使训练模式友方校猫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79225_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79226_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79227_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79228_PotencyDesc = {
    Text = "训练模式敌方校猫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。"
  },
  AwakerPotency_79228_PotencyName = {
    Text = "无限亿万光辉"
  },
  AwakerPotency_79229_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79230_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79231_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79232_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79233_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79234_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79235_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79236_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79237_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79238_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79239_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79240_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_79241_PotencyDesc = {
    Text = "「基础打击」和「基础防御」使训练模式敌方校猫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。"
  },
  AwakerPotency_79241_PotencyName = {
    Text = "不存在的存在"
  },
  AwakerPotency_79242_PotencyDesc = {
    Text = "「万物归一」发现的卡牌获得预备 1。"
  },
  AwakerPotency_79242_PotencyName = {
    Text = "全知全能"
  },
  AwakerPotency_79243_PotencyDesc = {
    Text = "「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。"
  },
  AwakerPotency_79243_PotencyName = {
    Text = "无穷智慧"
  },
  AwakerPotency_95787_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95788_PotencyDesc = {
    Text = "自身每损失 1％ 生命，杜勒赛因指令卡造成的基础伤害、护盾、狂气提高 1％。"
  },
  AwakerPotency_95788_PotencyName = {
    Text = "幽魂絮语"
  },
  AwakerPotency_95789_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95790_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95791_PotencyDesc = {
    Text = "本次狂气爆发暴击率+25％，基础伤害提高 50%，最终伤害提高 100％。"
  },
  AwakerPotency_95791_PotencyName = {
    Text = "万灵的餍飨"
  },
  AwakerPotency_95792_PotencyDesc = {
    Text = "「永夜欢宴」基础伤害提高 300%，打出后会使本回合后续打出的「永夜欢宴」额外享受 100% 力量加成。"
  },
  AwakerPotency_95792_PotencyName = {
    Text = "永夜欢宴"
  },
  AwakerPotency_95793_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95794_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95795_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95796_PotencyDesc = {
    Text = "灵知觉醒「王邸的请柬」获得强化，打出时立即对所有敌人造成当前生命 20% 的纯粹伤害。杜勒赛因每回合首次造成击杀后，对其他敌人造成的纯粹伤害提高为 100% 溢出伤害。"
  },
  AwakerPotency_95796_PotencyName = {
    Text = "冥河无渡"
  },
  AwakerPotency_95797_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95798_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95799_PotencyName = {
    Text = "人格深化"
  },
  AwakerPotency_95800_PotencyDesc = {
    Text = "杜勒赛因自身、装备的命轮与密契每提供 1% 暴击伤害，获得 0.1% 暴击率。"
  },
  AwakerPotency_95800_PotencyName = {
    Text = "餐前礼仪"
  },
  AwakerPotency_95801_PotencyName = {
    Text = "人格深化"
  }
})
return Text_AwakerPotency
