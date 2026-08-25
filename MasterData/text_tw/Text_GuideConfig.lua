__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "不遠的前方，矗立著一個<RedQuality:銀色六翼巨物>，散發出令人目眩的光輝"
  },
  GuideConfig_11_Content_1 = {
    Text = "我們可以直面祂……或者清理完這裡流竄的怪物，尋找聯絡點。到你做決定的時候了，守密人。"
  },
  GuideConfig_12_Content_1 = {
    Text = "按住指令卡，向上拖動，即可發出指令"
  },
  GuideConfig_13_Content_1 = {
    Text = "敵人將要攻擊造成致命傷害。輸出防禦指令吧，守密人！"
  },
  GuideConfig_14_Content_1 = {
    Text = "反復釋放女王之劍能使攻勢變得迅猛。要試試用這一招終結對手嗎？"
  },
  GuideConfig_15_Content_1 = {
    Text = "執行攻擊指令會獲得狂氣，狂氣充盈時即可釋放強力的狂氣爆發。"
  },
  GuideConfig_1_Content_1 = {
    Text = "守密人，現在可以向前探索。"
  },
  GuideConfig_2_Content_1 = {
    Text = "是彌薩格的聯絡點，用銀鑰共鳴可以恢復生命，這正是我們需要的。"
  },
  GuideConfig_34_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有指令卡可打出。完成教學後可自由發揮。"
  },
  GuideConfig_35_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有指令卡可打出。完成教學後可自由發揮。"
  },
  GuideConfig_36_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有指令卡可打出。完成教學後可自由發揮。"
  },
  GuideConfig_37_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有指令卡可打出。完成教學後可自由發揮。"
  },
  GuideConfig_38_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有狂氣爆發可使用。完成教學後可自由發揮。"
  },
  GuideConfig_39_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有狂氣爆發可使用。完成教學後可自由發揮。"
  },
  GuideConfig_3_Content_1 = {
    Text = "儘快擊敗<RedQuality:暴走的鯨躍>吧，我不想再目睹剛才那樣的悲劇了。"
  },
  GuideConfig_40_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有狂氣爆發可使用。完成教學後可自由發揮。"
  },
  GuideConfig_41_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有狂氣爆發可使用。完成教學後可自由發揮。"
  },
  GuideConfig_42_Content_1 = {
    Text = "當前處於戰鬥教學階段，還有鑰令可使用。完成教學後可自由發揮。"
  },
  GuideConfig_47_Content_1 = {
    Text = "混沌界域與銀鑰有強烈的共鳴，每回合能夠獲得 250 點銀鑰能量，幫助你更快速地釋放鑰令。若隊伍中沒有其他界域的喚醒體還會在進入關卡的時候獲得一個白銀造物，利用造物的幫助戰勝敵人吧。"
  },
  GuideConfig_49_Content_1 = {
    Text = "深海界域在戰鬥開始時會生成 1 條觸腕，觸腕在每個回合結束時會攻擊前排敵人。深海喚醒體們能夠為觸腕提供各類增幅，可以通過觸腕圖標下方數值了解當前的觸腕傷害。"
  },
  GuideConfig_4_Content_1 = {
    Text = "黑印可以獻祭給密境的<Yellow:融痕>，獲得各類<Yellow:造物>，對戰鬥大有助益。"
  },
  GuideConfig_55_Content_1 = {
    Text = "血肉界域每回合都會積攢胚胎融合和猩紅熔爐，生命越低積攢效率越高。胚胎融合度達到上限時會生成一張胚胎置入手牌中。胚胎能夠直接使用，讓對應喚醒體獲得狂氣和臨時暴擊率；也能夠被血肉界域喚醒體通過狂氣爆發吞噬，觸發額外效果。"
  },
  GuideConfig_57_Content_1 = {
    Text = "使用「猩紅熔爐」回復生命來應對攻擊吧！"
  },
  GuideConfig_58_Content_1 = {
    Text = "血肉界域喚醒體釋放狂氣爆發時，可以吞噬手中的胚胎，強化狂氣爆發效果。釋放萬古之眸，觸發吞噬吧！"
  },
  GuideConfig_5_Content_1 = {
    Text = "發現<Yellow:融痕>了，投入積攢的黑印吧。"
  },
  GuideConfig_60_Content_1 = {
    Text = "超維界域中，每回合打出的首張指令卡的臨時複製會進入超維空間。當超維空間達到上限時，可以進入一個新回合。在新回合中不會抽牌而是將超維空間的卡牌置入手中。"
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "超維界域"
  },
  GuideConfig_6_Content_1 = {
    Text = "這就是<Yellow:造物>，源自密境之物，你很快就能感知到它的力量。可惜，造物離開密境就會消散。"
  },
  GuideConfig_7_Content_1 = {
    Text = "前方似乎有突發<Yellow:事件>，去看看吧。說不定能夠獲得意料之外的強化……雖然有時伴隨著代價。"
  },
  GuideConfig_8_Content_1 = {
    Text = "前方似乎仍有敵人。"
  },
  GuideConfig_9_Content_1 = {
    Text = "這是一個單向通道,應該通向地下大廳,走吧,完成我們的使命"
  }
})
return Text_GuideConfig
