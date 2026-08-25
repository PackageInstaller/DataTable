__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "禁忌學識等級與守密人等級一致，決定下列 3 種研究深度的效果。若編隊喚醒體的平均等級大於等於守密人等級，則禁忌學識等級取編隊喚醒體平均等級和守密人等級的均值。\n活體研究深度：<Blue:{s1}>\n·決定喚醒體每 100 點體質屬性轉化為隊伍生命值的效果強度。\n物象研究深度：<Blue:{s2}>\n·決定造物、刻印、鑰令造成的力量、觸腕傷害、護盾、回復生命、力量降低類效果強度。\n靈識研究深度：<Blue:{s3}>\n·決定造物、刻印、鑰令造成的固定中毒、固定反擊、固定傷害、固定出血類效果強度。\n"
  },
  ActorAttrType_121209_Text = {
    Text = "禁忌學識等級"
  },
  ActorAttrType_18103_Text = {
    Text = "角色護盾"
  },
  ActorAttrType_18104_Text = {
    Text = "打擊卡傷害百分比修正"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "暴擊傷害+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "暴擊傷害"
  },
  ActorAttrType_18106_Text = {
    Text = "護盾提高"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "攻擊+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "攻擊"},
  ActorAttrType_18108_Text = {Text = "體質"},
  ActorAttrType_18109_Text = {
    Text = "卡牌傷害百分比修正"
  },
  ActorAttrType_18111_Text = {
    Text = "承受護盾百分比修正"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "防禦+{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "防禦提升"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "喚醒體充能狂氣的效率"
  },
  ActorAttrType_18113_Text = {
    Text = "開場狂氣"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "體質越高，喚醒體的最大生命就越高。\n守秘人調查等級越高，體質對喚醒體的最大生命的影響越強。"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "體質+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "體質"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "喚醒體釋放本源降臨後，返還的狂氣值"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "狂氣消耗降低+{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "狂氣消耗降低"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "體質越高，喚醒體的最大生命就越高。\n守秘人調查等級越高，體質對喚醒體的最大生命的影響越強。"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "體質+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "體質提升"
  },
  ActorAttrType_18117_Text = {
    Text = "觸腕傷害"
  },
  ActorAttrType_18118_Text = {
    Text = "超維卡槽數"
  },
  ActorAttrType_18119_Text = {
    Text = "承受傷害百分比修正"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "喚醒體的最大積攢狂氣、釋放狂氣爆發消耗狂氣均等於基礎狂氣。"
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "狂氣上限+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "基礎狂氣"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "技能2等級"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "技能2等級+{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "技能2等級"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "防禦等級"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "防禦等級+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "防禦等級"
  },
  ActorAttrType_18123_Text = {
    Text = "傷害次數固定值修正"
  },
  ActorAttrType_18124_Text = {
    Text = "造成護盾固定值修正"
  },
  ActorAttrType_18125_Text = {
    Text = "承受護盾固定值修正"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "隊伍的界域精通等於隊伍中喚醒體的界域精通之和。界域精通可以提升隊伍的界域天賦效果。若當前隊伍為「至純深海/至純血肉/至純超維」，界域精通效果翻倍。\n·<Blue:混沌>界域的隊伍每有 1 點界域精通，釋放鑰令後所有喚醒體額外獲得 <Blue:0.05> 點狂氣。\n·<Blue:深海>界域的隊伍每有 1 點界域精通，釋放狂氣爆發後有 <Blue:0.25％> 的機率額外獲得 1 層觸腕集結（機率超過 100% 可獲得多層），切換為「靜海」時獲得的護盾提高 <Blue:0.01％> 最大生命，「怒濤」中因主動傷害觸發的觸腕攻擊提高 <Blue:0.02%> 觸腕傷害。\n·<Blue:血肉>界域的隊伍每有 1 點界域精通，每回合首次觸發吞噬時額外獲得最大生命 <Blue:0.01%> 的護盾和 <Blue:0.005%> 的臨時力量（隨損失生命提高，至多提高 100％）。\n·<Blue:超維>界域的隊伍每有 1 點界域精通，回合開始時有 <Blue:0.125%> 的機率獲得 1 張「靈感」（機率超過 100% 可獲得多張）。"
  },
  ActorAttrType_18128_AttributeUpText = {
    Text = "攻擊+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "攻擊提升"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "基礎傷害加成越高，喚醒體造成的傷害越高"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "基礎傷害 +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "基礎傷害"
  },
  ActorAttrType_18130_Text = {Text = "等級"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "回合結束時，喚醒體自動回復的狂氣值（課題模式中，則為喚醒體每次行動後回復的狂氣值）"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "狂氣自動回復+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "狂氣自動回復"
  },
  ActorAttrType_18132_Text = {
    Text = "啟靈等級"
  },
  ActorAttrType_18133_Text = {
    Text = "承受狂氣百分比修正"
  },
  ActorAttrType_18135_Text = {
    Text = "角色當前狂氣"
  },
  ActorAttrType_18136_Text = {
    Text = "承受傷害固定值修正"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "喚醒體施加護盾和回復效果時，提升護盾數值和回復數值的比例"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "護盾和治療強效+{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "護盾和治療強效"
  },
  ActorAttrType_18138_Text = {
    Text = "治療提高"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "打出指令卡或靈知覺醒時，每消耗 1 算力獲得 {s1} 點銀鑰能量。隨著該屬性增加，額外提高的銀鑰能量會逐漸衰減。"
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "銀鑰充能+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "銀鑰充能等級"
  },
  ActorAttrType_18140_Text = {
    Text = "死亡抵抗次數"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "打擊等級"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "打擊等級+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "打擊等級"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "百分比提高所有喚醒體造成的「基礎傷害」、施加的「固定值中毒」和「固定值反擊」層數、深海界域初始觸腕傷害。"
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "傷害強效+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "傷害強效"
  },
  ActorAttrType_18143_Text = {
    Text = "狂氣爆發傷害百分比修正"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "喚醒體造成主動傷害時，抵抗暴擊的機率"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "暴擊抵抗+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "暴擊抵抗"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "本源降臨等級"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "本源降臨等級+{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "本源降臨等級"
  },
  ActorAttrType_18146_Text = {
    Text = "承受治療固定值修正"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "幸運刻印率+{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "幸運刻印率"
  },
  ActorAttrType_18148_Text = {
    Text = "造成治療固定值修正"
  },
  ActorAttrType_18149_Text = {
    Text = "體質提升"
  },
  ActorAttrType_18150_Text = {
    Text = "虛弱百分比修正"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "隊伍的死亡抵抗等於隊伍中喚醒體的死亡抵抗之和。\n在戰鬥中受到致命傷害時，有機率保留 1 點生命，觸發後下回合額外獲得 2 點算力並抽 2 張牌，當前及後續獲得的死亡抵抗減半，持續至調查結束。"
  },
  ActorAttrType_18152_Text = {
    Text = "造成狂氣百分比修正"
  },
  ActorAttrType_18154_Text = {
    Text = "觸腕上限"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "百分比提高戰鬥勝利後敵人掉落的黑印。"
  },
  ActorAttrType_18156_Text = {
    Text = "承受狂氣固定值修正"
  },
  ActorAttrType_18157_Text = {
    Text = "隱藏意圖"
  },
  ActorAttrType_18158_Text = {
    Text = "造成傷害固定值修正"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "暴擊率+{s1}"
  },
  ActorAttrType_18159_Text = {Text = "暴擊率"},
  ActorAttrType_18160_AttributeDesc = {
    Text = "技能1等級"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "技能1等級+{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "技能1等級"
  },
  ActorAttrType_18161_Text = {Text = "等級"},
  ActorAttrType_18162_Text = {
    Text = "傷害提高"
  },
  ActorAttrType_18163_Text = {
    Text = "觸腕數量"
  },
  ActorAttrType_18164_Text = {
    Text = "承受治療百分比修正"
  },
  ActorAttrType_18166_Text = {
    Text = "易傷百分比修正"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "防禦+{s1}"
  },
  ActorAttrType_18167_Text = {Text = "防禦"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "靈知覺醒等級"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "靈知覺醒等級+{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "靈知覺醒等級"
  },
  ActorAttrType_21322_Text = {
    Text = "銀鑰充能"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "每次釋放狂氣爆發後獲得 {s1} 點狂氣。隨著該屬性增加，額外的加成效果會逐漸衰減。"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "狂氣回充等級+{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "狂氣回充等級"
  },
  ActorAttrType_22214_Text = {
    Text = "狂氣回充"
  }
})
return Text_ActorAttrType
