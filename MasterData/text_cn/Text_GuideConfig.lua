__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "不远的前方，矗立着一个<RedQuality:银色六翼巨物>，散发出令人目眩的光辉"
  },
  GuideConfig_11_Content_1 = {
    Text = "我们可以直面祂……或者清理完这里流窜的怪物，寻找联络点。到你做决定的时候了，守密人。"
  },
  GuideConfig_12_Content_1 = {
    Text = "按住指令卡，向上拖动，即可发出指令"
  },
  GuideConfig_13_Content_1 = {
    Text = "敌人将要攻击造成致命伤害。输出防御指令吧，守密人！"
  },
  GuideConfig_14_Content_1 = {
    Text = "反复释放女王之剑能使攻势变得迅猛。要试试用这一招终结对手吗？"
  },
  GuideConfig_15_Content_1 = {
    Text = "执行攻击指令会获得狂气，狂气充盈时即可释放强力的狂气爆发。"
  },
  GuideConfig_1_Content_1 = {
    Text = "守密人，现在可以向前探索。"
  },
  GuideConfig_2_Content_1 = {
    Text = "是弥萨格的联络点，用银钥共鸣可以恢复生命，这正是我们需要的。"
  },
  GuideConfig_34_Content_1 = {
    Text = "当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。"
  },
  GuideConfig_35_Content_1 = {
    Text = "当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。"
  },
  GuideConfig_36_Content_1 = {
    Text = "当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。"
  },
  GuideConfig_37_Content_1 = {
    Text = "当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。"
  },
  GuideConfig_38_Content_1 = {
    Text = "当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。"
  },
  GuideConfig_39_Content_1 = {
    Text = "当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。"
  },
  GuideConfig_3_Content_1 = {
    Text = "尽快击败<RedQuality:暴走的鲸跃>吧，我不想再目睹刚才那样的悲剧了。"
  },
  GuideConfig_40_Content_1 = {
    Text = "当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。"
  },
  GuideConfig_41_Content_1 = {
    Text = "当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。"
  },
  GuideConfig_42_Content_1 = {
    Text = "当前处于战斗教学阶段，还有钥令可使用。完成教学后可自由发挥。"
  },
  GuideConfig_47_Content_1 = {
    Text = "混沌界域与银钥有强烈的共鸣，每回合能够获得 250 点银钥能量，帮助你更快速地释放钥令。若队伍中没有其他界域的唤醒体还会在进入关卡的时候获得一个白银造物，利用造物的帮助战胜敌人吧。"
  },
  GuideConfig_47_TipsTitle_1 = {
    Text = "混沌界域"
  },
  GuideConfig_49_Content_1 = {
    Text = "深海界域在战斗开始时会生成 1 条触腕，触腕在每个回合结束时会攻击前排敌人。深海唤醒体们能够为触腕提供各类增幅，可以通过触腕图标下方数值了解当前的触腕伤害。"
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "深海界域"
  },
  GuideConfig_4_Content_1 = {
    Text = "黑印可以献祭给密境的<Yellow:融痕>，获得各类<Yellow:造物>，对战斗大有助益。"
  },
  GuideConfig_55_Content_1 = {
    Text = "血肉界域每回合都会积攒胚胎融合和猩红熔炉，生命越低积攒效率越高。胚胎融合度达到上限时会生成一张胚胎置入手牌中。胚胎能够直接使用，让对应唤醒体获得狂气和临时暴击率；也能够被血肉界域唤醒体通过狂气爆发吞噬，触发额外效果。"
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "血肉界域"
  },
  GuideConfig_57_Content_1 = {
    Text = "使用「猩红熔炉」回复生命来应对攻击吧！"
  },
  GuideConfig_58_Content_1 = {
    Text = "血肉界域唤醒体释放狂气爆发时，可以吞噬手中的胚胎，强化狂气爆发效果。释放万古之眸，触发吞噬吧！"
  },
  GuideConfig_5_Content_1 = {
    Text = "发现<Yellow:融痕>了，投入积攒的黑印吧。"
  },
  GuideConfig_60_Content_1 = {
    Text = "超维界域中，每回合打出的首张指令卡的临时复制会进入超维空间。当超维空间达到上限时，可以进入一个新回合。在新回合中不会抽牌而是将超维空间的卡牌置入手中。"
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "超维界域"
  },
  GuideConfig_6_Content_1 = {
    Text = "这就是<Yellow:造物>，源自密境之物，你很快就能感知到它的力量。可惜，造物离开密境就会消散。"
  },
  GuideConfig_7_Content_1 = {
    Text = "前方似乎有突发<Yellow:事件>，去看看吧。说不定能够获得意料之外的强化……虽然有时伴随着代价。"
  },
  GuideConfig_8_Content_1 = {
    Text = "前方似乎仍有敌人。"
  },
  GuideConfig_9_Content_1 = {
    Text = "这是一个单向通道,应该通向地下大厅,走吧,完成我们的使命"
  }
})
return Text_GuideConfig
