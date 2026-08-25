__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "打出后额外生效 [Arg1] 次，<DepleteIconKeywords:消耗>。<RippleKeywords:余波>：抽 2 张牌。"
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:渊海回声>"
  },
  EnchantConfig_18169_Desc = {
    Text = "打出后获得 [Arg1] 点算力。"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:筹算>"
  },
  EnchantConfig_18170_Desc = {
    Text = "打出后获得 [Arg1] 层<RetaliateIconKeywords:反击>，对所有敌人触发 [Arg2]% <RetaliateIconKeywords:反击>。"
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:高级尖刺>"
  },
  EnchantConfig_18171_Desc = {
    Text = "打出后额外生效 [Arg1] 次，获得 [Arg2] 点黑印，<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:高级回声>"
  },
  EnchantConfig_18172_Desc = {
    Text = "打出后使所有敌人失去 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:衰竭>"
  },
  EnchantConfig_18173_Desc = {
    Text = "打出后 <EmbryoFusionIconKeywords:胚胎融合>  +[Arg1]。"
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:高级嗜血>"
  },
  EnchantConfig_18174_Desc = {
    Text = "打出后<VulnerabilityIconKeywords:易伤>所有敌人 [Arg1] 回合。"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:高级易伤>"
  },
  EnchantConfig_18175_Desc = {
    Text = "打出后使 1 条触腕攻击 [Arg1] 次。"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:高级统御>"
  },
  EnchantConfig_18176_Desc = {
    Text = "打出后使 1 条触腕攻击 [Arg1] 次。"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:统御>"
  },
  EnchantConfig_18177_Desc = {
    Text = "打出后抽 [Arg1] 张牌。"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:高级妙手>"
  },
  EnchantConfig_18178_Desc = {
    Text = "战斗开始后将 [Arg1] 张临时复制洗入抽牌堆，原始卡牌和镜像卡牌均获得<RetainIconKeywords:保留>。"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:高级镜像>"
  },
  EnchantConfig_18179_Desc = {
    Text = "打出后获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:高级蛮力>"
  },
  EnchantConfig_18180_Desc = {
    Text = "打出后所属唤醒体获得 [Arg1] 点狂气。"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:高级狂化>"
  },
  EnchantConfig_18181_Desc = {
    Text = "打出后对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，使所有敌人触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:高级毒素>"
  },
  EnchantConfig_18182_Desc = {
    Text = "打出后将 [Arg1] 张 <DerivativeCardKeywords_4:「灵感」> 洗入抽牌堆。「灵感-获得 1 算力。抽 1 张牌，<RetainIconKeywords:保留>，<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:灵感>"
  },
  EnchantConfig_18183_Desc = {
    Text = "打出后<VulnerabilityIconKeywords:易伤>所有敌人 [Arg1] 回合。"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:易伤>"
  },
  EnchantConfig_18184_Desc = {
    Text = "打出后获得 [Arg1] 点护盾。"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:高级铁壁>"
  },
  EnchantConfig_18185_Desc = {
    Text = "打出后对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，使所有敌人触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:毒素>"
  },
  EnchantConfig_18186_Desc = {
    Text = "战斗开始后将 [Arg1] 张临时复制洗入抽牌堆，原始卡牌和镜像卡牌均获得<RetainIconKeywords:保留>。"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:镜像>"
  },
  EnchantConfig_18187_Desc = {
    Text = "打出后获得 [Arg1] 点临时<PowerIconKeywords:力量>，刻印卡牌也能受到该<PowerIconKeywords:力量>加成。"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:高级爆发>"
  },
  EnchantConfig_18188_Desc = {
    Text = "打出后抽 [Arg1] 张牌。"
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:妙手>"
  },
  EnchantConfig_18189_Desc = {
    Text = "打出后将 [Arg1] 张 <DerivativeCardKeywords_4:「灵感」> 洗入抽牌堆。「灵感-获得 1 算力。抽 1 张牌，<RetainIconKeywords:保留>，<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:高级灵感>"
  },
  EnchantConfig_18190_Desc = {
    Text = "打出后<WeaknessIconKeywords:虚弱>所有敌人 [Arg1] 回合。"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:高级虚弱>"
  },
  EnchantConfig_18191_Desc = {
    Text = "打出后 <EmbryoFusionIconKeywords:胚胎融合>  +[Arg1]。"
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:嗜血>"
  },
  EnchantConfig_18192_Desc = {
    Text = "打出后<WeaknessIconKeywords:虚弱>所有敌人 [Arg1] 回合。"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:虚弱>"
  },
  EnchantConfig_18193_Desc = {
    Text = "打出后使所有敌人失去 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:高级衰竭>"
  },
  EnchantConfig_18194_Desc = {
    Text = "打出后将卡牌的 [Arg1] 张复制加入临时<DimensionalSpaceIconKeywords:超维空间>。"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:高级折跃>"
  },
  EnchantConfig_18195_Desc = {
    Text = "打出后获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:蛮力>"
  },
  EnchantConfig_18196_Desc = {
    Text = "打出后获得 [Arg1] 点护盾。"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:铁壁>"
  },
  EnchantConfig_18197_Desc = {
    Text = "打出后获得 [Arg1] 点算力。"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:高级筹算>"
  },
  EnchantConfig_18198_Desc = {
    Text = "打出后其他唤醒体获得 [Arg1] 狂气。"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:高级催化>"
  },
  EnchantConfig_18199_Desc = {
    Text = "打出后获得 [Arg1] 层<RetaliateIconKeywords:反击>，对所有敌人触发 [Arg2]% <RetaliateIconKeywords:反击>。"
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:尖刺>"
  },
  EnchantConfig_18200_Desc = {
    Text = "打出后额外生效 [Arg1] 次，获得 [Arg2] 点黑印，<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:回声>"
  },
  EnchantConfig_18201_Desc = {
    Text = "打出后所属唤醒体获得 [Arg1] 点狂气。"
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:狂化>"
  },
  EnchantConfig_18202_Desc = {
    Text = "打出后获得 [Arg1] 点临时<PowerIconKeywords:力量>，刻印卡牌也能受到该<PowerIconKeywords:力量>加成。"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:爆发>"
  },
  EnchantConfig_18203_Desc = {
    Text = "打出后其他唤醒体获得 [Arg1] 狂气。"
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:催化>"
  },
  EnchantConfig_18204_Desc = {
    Text = "打出后将卡牌的 [Arg1] 张复制加入临时<DimensionalSpaceIconKeywords:超维空间>。"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:折跃>"
  },
  EnchantConfig_48006_Desc = {
    Text = "每回合第一次打出生效 2 次。"
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:合奏>"
  },
  EnchantConfig_48007_Desc = {
    Text = "每回合第一次打出生效 3 次。"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:高级合奏>"
  },
  EnchantConfig_49108_Desc = {
    Text = "卡牌获得<RetainIconKeywords:保留>，回合结束时若在手中，获得一张附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的 原始复制。"
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:孕育>"
  },
  EnchantConfig_59530_Desc = {
    Text = "打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。"
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:欢愉之理>"
  },
  EnchantConfig_59531_Desc = {
    Text = "打出后抽 2 张牌，它们算力消耗降低刻印卡牌实际消耗算力，每场战斗仅生效 1 次。"
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:智识之理>"
  },
  EnchantConfig_59532_Desc = {
    Text = "打出后获得 3 张附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始复制，每场战斗仅生效 1 次。"
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:繁育之理>"
  },
  EnchantConfig_67415_Desc = {
    Text = "打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。"
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:高级欢愉之理>"
  },
  EnchantConfig_67416_Desc = {
    Text = "打出后抽 4 张牌，它们算力消耗降低刻印卡牌实际消耗算力，每场战斗仅生效 1 次。"
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:高级智识之理>"
  },
  EnchantConfig_67417_Desc = {
    Text = "打出后获得 3 张算力消耗-1 且附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始复制，每场战斗仅生效 1 次。"
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:高级繁育之理>"
  }
})
return Text_EnchantConfig
