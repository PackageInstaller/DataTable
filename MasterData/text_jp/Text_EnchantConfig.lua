__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "使用後に[Arg1]回効果を発動し、これを<DepleteIconKeywords:除外>する。<RippleKeywords:余波>：カードを2枚引く。"
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:深海の反響>"
  },
  EnchantConfig_18169_Desc = {
    Text = "使用した時、[Arg1]点の行動力を獲得する。"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:策謀>"
  },
  EnchantConfig_18170_Desc = {
    Text = "発射後、[Arg1]スタックの<RetaliateIconKeywords:カウンター>を獲得し、すべての敵に[Arg2]％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:上位反撃>"
  },
  EnchantConfig_18171_Desc = {
    Text = "使用した時、追加で[Arg1]回発動し、[Arg2]点の黒印を獲得する、<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:上位エコー>"
  },
  EnchantConfig_18172_Desc = {
    Text = "使用した時、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力量>を減少させる。"
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:衰弱>"
  },
  EnchantConfig_18173_Desc = {
    Text = "使用した時、<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。"
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:上位好血>"
  },
  EnchantConfig_18174_Desc = {
    Text = "使用後、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:上位易傷>"
  },
  EnchantConfig_18175_Desc = {
    Text = "使用した時、触腕1本に[Arg1]回攻撃させる。"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:上位統御>"
  },
  EnchantConfig_18176_Desc = {
    Text = "使用した時、触腕1本に[Arg1]回攻撃させる。"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:統御>"
  },
  EnchantConfig_18177_Desc = {
    Text = "使用した時、カードを[Arg1]枚引く。"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:上位神技>"
  },
  EnchantConfig_18178_Desc = {
    Text = "戦闘開始後、[Arg1]枚の一時コピーを山札に加えてシャッフルする。元のカードとミラーカードはともに<RetainIconKeywords:保留>を獲得する。"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:上位鏡像>"
  },
  EnchantConfig_18179_Desc = {
    Text = "使用した時、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:上位剛力>"
  },
  EnchantConfig_18180_Desc = {
    Text = "使用した時、所属する覚醒体が[Arg1]点の狂気を獲得する。"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:上位狂化>"
  },
  EnchantConfig_18181_Desc = {
    Text = "発射後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、すべての敵の<IntoxicationIconKeywords:毒>を[Arg2]％発動する。"
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:上位毒素>"
  },
  EnchantConfig_18182_Desc = {
    Text = "使用した時、<DerivativeCardKeywords_4:「閃き」>を[Arg1]枚ドローパイルにシャッフルして入れる。「閃き–演算力を1獲得する。カードを1枚引く、<RetainIconKeywords:保留>、<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:啓示>"
  },
  EnchantConfig_18183_Desc = {
    Text = "使用後、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:易傷>"
  },
  EnchantConfig_18184_Desc = {
    Text = "使用した時、[Arg1]点のシールドを獲得する。"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:上位鉄壁>"
  },
  EnchantConfig_18185_Desc = {
    Text = "発射後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、すべての敵の<IntoxicationIconKeywords:毒>を[Arg2]％発動する。"
  },
  EnchantConfig_18186_Desc = {
    Text = "戦闘開始後、[Arg1]枚の一時コピーを山札に加えてシャッフルする。元のカードとミラーカードはともに<RetainIconKeywords:保留>を獲得する。"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:鏡像>"
  },
  EnchantConfig_18187_Desc = {
    Text = "使用した時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、刻印カードもこの<PowerIconKeywords:力>の効果を受ける。"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:上位爆発>"
  },
  EnchantConfig_18188_Desc = {
    Text = "使用した時、カードを[Arg1]枚引く。"
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:神技>"
  },
  EnchantConfig_18189_Desc = {
    Text = "使用した時、<DerivativeCardKeywords_4:「閃き」>を[Arg1]枚ドローパイルにシャッフルして入れる。「閃き–演算力を1獲得する。カードを1枚引く、<RetainIconKeywords:保留>、<DepleteIconKeywords:消耗>。」"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:上位啓示>"
  },
  EnchantConfig_18190_Desc = {
    Text = "使用した時、すべての敵に[Arg1]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:上位倦怠>"
  },
  EnchantConfig_18191_Desc = {
    Text = "使用した時、<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。"
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:好血>"
  },
  EnchantConfig_18192_Desc = {
    Text = "使用した時、すべての敵に[Arg1]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:倦怠>"
  },
  EnchantConfig_18193_Desc = {
    Text = "使用した時、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力量>を減少させる。"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:上位衰弱>"
  },
  EnchantConfig_18194_Desc = {
    Text = "使用した時、カードの[Arg1]枚のコピーを一時的な<DimensionalSpaceIconKeywords:超次元空間>に加える。"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:上位転送>"
  },
  EnchantConfig_18195_Desc = {
    Text = "使用した時、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:剛力>"
  },
  EnchantConfig_18196_Desc = {
    Text = "使用した時、[Arg1]点のシールドを獲得する。"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:鉄壁>"
  },
  EnchantConfig_18197_Desc = {
    Text = "使用した時、[Arg1]点の行動力を獲得する。"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:上位策謀>"
  },
  EnchantConfig_18198_Desc = {
    Text = "使用した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:上位触媒>"
  },
  EnchantConfig_18199_Desc = {
    Text = "発射後、[Arg1]スタックの<RetaliateIconKeywords:カウンター>を獲得し、すべての敵に[Arg2]％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:反撃>"
  },
  EnchantConfig_18200_Desc = {
    Text = "使用した時、追加で[Arg1]回発動し、[Arg2]点の黒印を獲得する、<DepleteIconKeywords:消耗>、<GuyouKeywords:固有>。"
  },
  EnchantConfig_18201_Desc = {
    Text = "使用した時、所属する覚醒体が[Arg1]点の狂気を獲得する。"
  },
  EnchantConfig_18202_Desc = {
    Text = "使用した時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、刻印カードもこの<PowerIconKeywords:力>の効果を受ける。"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:爆発>"
  },
  EnchantConfig_18203_Desc = {
    Text = "使用した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:触媒>"
  },
  EnchantConfig_18204_Desc = {
    Text = "使用した時、カードの[Arg1]枚のコピーを一時的な<DimensionalSpaceIconKeywords:超次元空間>に加える。"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:転送>"
  },
  EnchantConfig_48006_Desc = {
    Text = "毎ターン初めて使用した時、2回発動する。"
  },
  EnchantConfig_48007_Desc = {
    Text = "毎ターン初めて使用した時、3回発動する。"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:上位合奏>"
  },
  EnchantConfig_49108_Desc = {
    Text = "<RetainIconKeywords:保持>を獲得、ターン終了時に手札にある場合、<RetainIconKeywords:保持>と<DepleteIconKeywords:除外>を付与した未強化コピーを1枚獲得する。"
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:生出>"
  },
  EnchantConfig_59530_Desc = {
    Text = "この覚醒体以外のすべてのカードを捨て、ランダムな非覚醒体のカードを5枚獲得。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:歓喜の理>"
  },
  EnchantConfig_59531_Desc = {
    Text = "カードを2枚引き、それらの行動力消費を刻印カードの行動力と同じだけ減少する。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:知識の理>"
  },
  EnchantConfig_59532_Desc = {
    Text = "<RetainIconKeywords:保持>と<DepleteIconKeywords:除外>を付与した未強化コピーを3枚獲得。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:繁殖の理>"
  },
  EnchantConfig_67415_Desc = {
    Text = "この覚醒体以外のすべてのカードを捨て、ランダムな非覚醒体のカードを5枚獲得。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:上位歓喜の理>"
  },
  EnchantConfig_67416_Desc = {
    Text = "カードを4枚引き、それらの行動力消費を刻印カードの行動力と同じだけ減少する。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:上位知識の理>"
  },
  EnchantConfig_67417_Desc = {
    Text = "<RetainIconKeywords:保持>と<DepleteIconKeywords:除外>を付与した未強化コピーを3枚獲得し、その行動力消費を-1する。各戦闘で1回のみ発動可能。"
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:上位繁殖の理>"
  }
})
return Text_EnchantConfig
