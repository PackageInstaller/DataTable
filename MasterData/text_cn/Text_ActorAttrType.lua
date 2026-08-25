__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "禁忌学识等级与守密人等级一致，决定下列 3 种研究深度的效果。若编队唤醒体的平均等级大于等于守密人等级，则禁忌学识等级取编队唤醒体平均等级和守密人等级的均值。\n活体研究深度：<Blue:{s1}>\n·决定唤醒体每 100 点体质属性转化为队伍生命值的效果强度。\n物象研究深度：<Blue:{s2}>\n·决定造物、刻印、钥令造成的力量、触腕伤害、护盾、回复生命、力量降低类效果强度。\n灵识研究深度：<Blue:{s3}>\n·决定造物、刻印、钥令造成的固定中毒、固定反击、固定伤害、固定出血类效果强度。\n"
  },
  ActorAttrType_121209_Text = {
    Text = "禁忌学识等级"
  },
  ActorAttrType_18103_Text = {
    Text = "角色护盾"
  },
  ActorAttrType_18104_Text = {
    Text = "打击卡伤害百分比修正"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "暴击伤害+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "暴击伤害"
  },
  ActorAttrType_18106_Text = {
    Text = "护盾提高"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "攻击+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "攻击"},
  ActorAttrType_18108_Text = {Text = "体质"},
  ActorAttrType_18109_Text = {
    Text = "卡牌伤害百分比修正"
  },
  ActorAttrType_18110_Text = {
    Text = "脆弱百分比修正"
  },
  ActorAttrType_18111_Text = {
    Text = "承受护盾百分比修正"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "防御+{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "防御提升"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "唤醒体充能狂气的效率"
  },
  ActorAttrType_18113_Text = {
    Text = "开场狂气"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "体质越高，唤醒体的最大生命就越高。\n守密人调查等级越高，体质对唤醒体的最大生命的影响越强。"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "体质+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "体质"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "唤醒体释放本源降临后，返还的狂气值"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "狂气消耗降低+{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "狂气消耗降低"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "体质越高，唤醒体的最大生命就越高。\n守密人调查等级越高，体质对唤醒体的最大生命的影响越强。"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "体质+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "体质提升"
  },
  ActorAttrType_18117_Text = {
    Text = "触腕伤害"
  },
  ActorAttrType_18118_Text = {
    Text = "超维卡槽数"
  },
  ActorAttrType_18119_Text = {
    Text = "承受伤害百分比修正"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "唤醒体的最大积攒狂气、释放狂气爆发消耗狂气均等于基础狂气。"
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "狂气上限+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "基础狂气"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "技能2等级"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "技能2等级+{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "技能2等级"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "防御等级"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "防御等级+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "防御等级"
  },
  ActorAttrType_18123_Text = {
    Text = "伤害次数固定值修正"
  },
  ActorAttrType_18124_Text = {
    Text = "造成护盾固定值修正"
  },
  ActorAttrType_18125_Text = {
    Text = "承受护盾固定值修正"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "队伍的界域精通等于队伍中唤醒体的界域精通之和。界域精通可以提升队伍的界域天赋效果。若当前队伍为「至纯深海/至纯血肉/至纯超维」，界域精通效果翻倍。\n·<Blue:混沌>界域的队伍每有 1 点界域精通，释放钥令后所有唤醒体额外获得 <Blue:0.05> 点狂气。\n·<Blue:深海>界域的队伍每有 1 点界域精通，释放狂气爆发后有 <Blue:0.25％> 的概率额外获得 1 层触腕集结（概率超过 100% 可获得多层），切换为「静海」时获得的护盾提高 <Blue:0.01％> 最大生命，「怒涛」中因主动伤害触发的触腕攻击提高 <Blue:0.02%> 触腕伤害。\n·<Blue:血肉>界域的队伍每有 1 点界域精通，每回合首次触发吞噬时额外获得最大生命 <Blue:0.01%> 的护盾和 <Blue:0.005%> 的临时力量（随损失生命提高，至多提高 100％）。\n·<Blue:超维>界域的队伍每有 1 点界域精通，回合开始时有 <Blue:0.125%> 的概率获得 1 张「灵感」（概率超过 100% 可获得多张）。"
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "界域精通+{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "界域精通"
  },
  ActorAttrType_18127_Text = {Text = "生命"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "攻击+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "攻击提升"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "基础伤害加成越高，唤醒体造成的伤害越高"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "基础伤害 +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "基础伤害"
  },
  ActorAttrType_18130_Text = {Text = "等级"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "回合结束时，唤醒体自动回复的狂气值（课题模式中，则为唤醒体每次行动后回复的狂气值）"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "狂气自动回复+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "狂气自动回复"
  },
  ActorAttrType_18132_Text = {
    Text = "启灵等级"
  },
  ActorAttrType_18133_Text = {
    Text = "承受狂气百分比修正"
  },
  ActorAttrType_18134_Text = {
    Text = "胚胎融合上限"
  },
  ActorAttrType_18135_Text = {
    Text = "角色当前狂气"
  },
  ActorAttrType_18136_Text = {
    Text = "承受伤害固定值修正"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "唤醒体施加护盾和回复效果时，提升护盾数值和回复数值的比例"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "护盾和治疗强效+{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "护盾和治疗强效"
  },
  ActorAttrType_18138_Text = {
    Text = "治疗提高"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "打出指令卡或灵知觉醒时，每消耗 1 算力获得 {s1} 点银钥能量。随着该属性增加，额外提高的银钥能量会逐渐衰减。"
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "银钥充能+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "银钥充能等级"
  },
  ActorAttrType_18140_Text = {
    Text = "死亡抵抗次数"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "打击等级"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "打击等级+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "打击等级"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "百分比提高所有唤醒体造成的「基础伤害」、施加的「固定值中毒」和「固定值反击」层数、深海界域初始触腕伤害。"
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "伤害强效+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "伤害强效"
  },
  ActorAttrType_18143_Text = {
    Text = "狂气爆发伤害百分比修正"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "唤醒体造成主动伤害时，抵抗暴击的概率"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "暴击抵抗+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "暴击抵抗"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "本源降临等级"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "本源降临等级+{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "本源降临等级"
  },
  ActorAttrType_18146_Text = {
    Text = "承受治疗固定值修正"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "幸运刻印率+{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "幸运刻印率"
  },
  ActorAttrType_18148_Text = {
    Text = "造成治疗固定值修正"
  },
  ActorAttrType_18149_Text = {
    Text = "体质提升"
  },
  ActorAttrType_18150_Text = {
    Text = "虚弱百分比修正"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "队伍的死亡抵抗等于队伍中唤醒体的死亡抵抗之和。\n在战斗中受到致命伤害时，有概率保留 1 点生命，触发后下回合额外获得 2 点算力并抽 2 张牌，当前及后续获得的死亡抵抗减半，持续至调查结束。"
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "死亡抵抗+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "死亡抵抗"
  },
  ActorAttrType_18152_Text = {
    Text = "造成狂气百分比修正"
  },
  ActorAttrType_18154_Text = {
    Text = "触腕上限"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "百分比提高战斗胜利后敌人掉落的黑印。"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "黑印掉落+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "黑印掉落"
  },
  ActorAttrType_18156_Text = {
    Text = "承受狂气固定值修正"
  },
  ActorAttrType_18157_Text = {
    Text = "隐藏意图"
  },
  ActorAttrType_18158_Text = {
    Text = "造成伤害固定值修正"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "暴击率+{s1}"
  },
  ActorAttrType_18159_Text = {Text = "暴击率"},
  ActorAttrType_18160_AttributeDesc = {
    Text = "技能1等级"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "技能1等级+{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "技能1等级"
  },
  ActorAttrType_18161_Text = {Text = "等级"},
  ActorAttrType_18162_Text = {
    Text = "伤害提高"
  },
  ActorAttrType_18163_Text = {
    Text = "触腕数量"
  },
  ActorAttrType_18164_Text = {
    Text = "承受治疗百分比修正"
  },
  ActorAttrType_18165_Text = {
    Text = "最大算力"
  },
  ActorAttrType_18166_Text = {
    Text = "易伤百分比修正"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "防御+{s1}"
  },
  ActorAttrType_18167_Text = {Text = "防御"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "灵知觉醒等级"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "灵知觉醒等级+{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "灵知觉醒等级"
  },
  ActorAttrType_21322_Text = {
    Text = "银钥充能"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "每次释放狂气爆发后获得 {s1} 点狂气。随着该属性增加，额外的加成效果会逐渐衰减。"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "狂气回充等级+{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "狂气回充等级"
  },
  ActorAttrType_22214_Text = {
    Text = "狂气回充"
  }
})
return Text_ActorAttrType
