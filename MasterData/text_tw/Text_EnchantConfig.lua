__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "打出後額外生效 [Arg1] 次，<DepleteIconKeywords:消耗>。<RippleKeywords:餘波>：抽 2 張牌。"
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:淵海回聲>"
  },
  EnchantConfig_18169_Desc = {
    Text = "打出後獲得 [Arg1] 點算力。"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:籌算>"
  },
  EnchantConfig_18170_Desc = {
    Text = "打出後獲得 [Arg1] 層<RetaliateIconKeywords:反擊>，對所有敵人觸發 [Arg2]% <RetaliateIconKeywords:反擊>。"
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:高級尖刺>"
  },
  EnchantConfig_18171_Desc = {
    Text = "打出後額外生效 [Arg1] 次，獲得 [Arg2] 點黑印，<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:高級回聲>"
  },
  EnchantConfig_18172_Desc = {
    Text = "打出後使所有敵人失去 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18173_Desc = {
    Text = "打出後 <EmbryoFusionIconKeywords:胚胎融合>  +[Arg1]。"
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:高級嗜血>"
  },
  EnchantConfig_18174_Desc = {
    Text = "打出後<VulnerabilityIconKeywords:易傷>所有敵人 [Arg1] 回合。"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:高級易傷>"
  },
  EnchantConfig_18175_Desc = {
    Text = "打出後使 1 條觸腕攻擊 [Arg1] 次。"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:高級統御>"
  },
  EnchantConfig_18176_Desc = {
    Text = "打出後使 1 條觸腕攻擊 [Arg1] 次。"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:統御>"
  },
  EnchantConfig_18177_Desc = {
    Text = "打出後抽 [Arg1] 張牌。"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:高級妙手>"
  },
  EnchantConfig_18178_Desc = {
    Text = "戰鬥開始後將 [Arg1] 張臨時複製洗入抽牌堆，原始卡牌和鏡像卡牌均獲得<RetainIconKeywords:保留>。"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:高級鏡像>"
  },
  EnchantConfig_18179_Desc = {
    Text = "打出後獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:高級蠻力>"
  },
  EnchantConfig_18180_Desc = {
    Text = "打出後所屬喚醒體獲得 [Arg1] 點狂氣。"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:高級狂化>"
  },
  EnchantConfig_18181_Desc = {
    Text = "打出後對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，使所有敵人觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:高級毒素>"
  },
  EnchantConfig_18182_Desc = {
    Text = "打出後將 [Arg1] 張 <DerivativeCardKeywords_4:「靈感」> 洗入抽牌堆。「靈感-獲得 1 算力。抽 1 張牌，<RetainIconKeywords:保留>，<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:靈感>"
  },
  EnchantConfig_18183_Desc = {
    Text = "打出後<VulnerabilityIconKeywords:易傷>所有敵人 [Arg1] 回合。"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:易傷>"
  },
  EnchantConfig_18184_Desc = {
    Text = "打出後獲得 [Arg1] 點護盾。"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:高級鐵壁>"
  },
  EnchantConfig_18185_Desc = {
    Text = "打出後對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，使所有敵人觸發 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  EnchantConfig_18186_Desc = {
    Text = "戰鬥開始後將 [Arg1] 張臨時複製洗入抽牌堆，原始卡牌和鏡像卡牌均獲得<RetainIconKeywords:保留>。"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:鏡像>"
  },
  EnchantConfig_18187_Desc = {
    Text = "打出後獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，刻印卡牌也能受到該<PowerIconKeywords:力量>加成。"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:高級爆發>"
  },
  EnchantConfig_18188_Desc = {
    Text = "打出後抽 [Arg1] 張牌。"
  },
  EnchantConfig_18189_Desc = {
    Text = "打出後將 [Arg1] 張 <DerivativeCardKeywords_4:「靈感」> 洗入抽牌堆。「靈感-獲得 1 算力。抽 1 張牌，<RetainIconKeywords:保留>，<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:高級靈感>"
  },
  EnchantConfig_18190_Desc = {
    Text = "打出後<WeaknessIconKeywords:虛弱>所有敵人 [Arg1] 回合。"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:高級虛弱>"
  },
  EnchantConfig_18191_Desc = {
    Text = "打出後 <EmbryoFusionIconKeywords:胚胎融合>  +[Arg1]。"
  },
  EnchantConfig_18192_Desc = {
    Text = "打出後<WeaknessIconKeywords:虛弱>所有敵人 [Arg1] 回合。"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:虛弱>"
  },
  EnchantConfig_18193_Desc = {
    Text = "打出後使所有敵人失去 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:高級衰竭>"
  },
  EnchantConfig_18194_Desc = {
    Text = "打出後將卡牌的 [Arg1] 張複製加入臨時<DimensionalSpaceIconKeywords:超維空間>。"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:高級折躍>"
  },
  EnchantConfig_18195_Desc = {
    Text = "打出後獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:蠻力>"
  },
  EnchantConfig_18196_Desc = {
    Text = "打出後獲得 [Arg1] 點護盾。"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:鐵壁>"
  },
  EnchantConfig_18197_Desc = {
    Text = "打出後獲得 [Arg1] 點算力。"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:高級籌算>"
  },
  EnchantConfig_18198_Desc = {
    Text = "打出後其他喚醒體獲得 [Arg1] 狂氣。"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:高級催化>"
  },
  EnchantConfig_18199_Desc = {
    Text = "打出後獲得 [Arg1] 層<RetaliateIconKeywords:反擊>，對所有敵人觸發 [Arg2]% <RetaliateIconKeywords:反擊>。"
  },
  EnchantConfig_18200_Desc = {
    Text = "打出後額外生效 [Arg1] 次，獲得 [Arg2] 點黑印，<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:回聲>"
  },
  EnchantConfig_18201_Desc = {
    Text = "打出後所屬喚醒體獲得 [Arg1] 點狂氣。"
  },
  EnchantConfig_18202_Desc = {
    Text = "打出後獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，刻印卡牌也能受到該<PowerIconKeywords:力量>加成。"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:爆發>"
  },
  EnchantConfig_18203_Desc = {
    Text = "打出後其他喚醒體獲得 [Arg1] 狂氣。"
  },
  EnchantConfig_18204_Desc = {
    Text = "打出後將卡牌的 [Arg1] 張複製加入臨時<DimensionalSpaceIconKeywords:超維空間>。"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:折躍>"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:高級合奏>"
  },
  EnchantConfig_49108_Desc = {
    Text = "卡牌獲得<RetainIconKeywords:保留>，回合結束時若在手中，獲得一張附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的 原始複製。"
  },
  EnchantConfig_59530_Desc = {
    Text = "打出後棄掉所有該喚醒體以外的卡牌，獲得 5 張隨機非喚醒體卡牌，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:歡愉之理>"
  },
  EnchantConfig_59531_Desc = {
    Text = "打出後抽 2 張牌，它們算力消耗降低刻印卡牌實際消耗算力，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:智識之理>"
  },
  EnchantConfig_59532_Desc = {
    Text = "打出後獲得 3 張附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始複製，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_67415_Desc = {
    Text = "打出後棄掉所有該喚醒體以外的卡牌，獲得 5 張隨機非喚醒體卡牌，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:高級歡愉之理>"
  },
  EnchantConfig_67416_Desc = {
    Text = "打出後抽 4 張牌，它們算力消耗降低刻印卡牌實際消耗算力，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:高級智識之理>"
  },
  EnchantConfig_67417_Desc = {
    Text = "打出後獲得 3 張算力消耗-1 且附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始複製，每場戰鬥僅生效 1 次。"
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:高級繁育之理>"
  }
})
return Text_EnchantConfig
