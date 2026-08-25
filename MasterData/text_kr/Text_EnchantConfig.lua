__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "사용 후 추가로 [Arg1]번 발동, <DepleteIconKeywords:소모>합니다. <RippleKeywords:여파>:2장의 카드를 뽑습니다."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:심해의 반향>"
  },
  EnchantConfig_18169_Desc = {
    Text = "사용 후 산출력을 [Arg1] 획득합니다."
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:계산>"
  },
  EnchantConfig_18170_Desc = {
    Text = "사용 후 [Arg1] 층 <RetaliateIconKeywords:반격>을 획득하고, 모든 적에게 [Arg2]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:고급 가시>"
  },
  EnchantConfig_18171_Desc = {
    Text = "사용 후 추가로 [Arg1]번 발동하고, 검은 인장을 [Arg2]개 획득합니다.\n<DepleteIconKeywords:소모>, <GuyouKeywords:고유>."
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:고급 반향>"
  },
  EnchantConfig_18172_Desc = {
    Text = "모든 적의 임시 <PowerIconKeywords:힘>이 [Arg1] 감소합니다."
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:쇠약>"
  },
  EnchantConfig_18173_Desc = {
    Text = "사용 후 <EmbryoFusionIconKeywords:배아 융합> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:고급 갈증>"
  },
  EnchantConfig_18174_Desc = {
    Text = "사용 후 모든 적에게 [Arg1]턴 동안 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:고급 취약>"
  },
  EnchantConfig_18175_Desc = {
    Text = "사용 후 촉수 1개가 [Arg1]회 공격합니다."
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:고급 통제>"
  },
  EnchantConfig_18176_Desc = {
    Text = "사용 후 촉수 1개가 [Arg1]회 공격합니다."
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:통제>"
  },
  EnchantConfig_18177_Desc = {
    Text = "사용 후 카드를 [Arg1]장 뽑습니다."
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:고급 묘수>"
  },
  EnchantConfig_18178_Desc = {
    Text = "전투 시작 시, 해당 카드 원본의 복사본 [Arg1]장을 덱에 섞습니다. 원본 카드와 복사된 카드가 모두 <RetainIconKeywords:보존>을 획득합니다."
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:고급 거울>"
  },
  EnchantConfig_18179_Desc = {
    Text = "[Arg1]의 <PowerIconKeywords:힘>을 획득합니다."
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:고급 완력>"
  },
  EnchantConfig_18180_Desc = {
    Text = "사용자가 [Arg1] 광기를 획득합니다."
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:고급 광화>"
  },
  EnchantConfig_18181_Desc = {
    Text = "사용 후 모든 적에게 [Arg1] 층 <IntoxicationIconKeywords:중독>을 부여하고, 모든 적에게 [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:고급 독소>"
  },
  EnchantConfig_18182_Desc = {
    Text = "사용 후 <DerivativeCardKeywords_4:「영감」> 카드 [Arg1]장을 드로우 덱에 추가합니다. (「영감」: 산출력을 1 획득하고, 카드를 1장 뽑습니다. <RetainIconKeywords:보존>, <DepleteIconKeywords:소모>.)"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:영감>"
  },
  EnchantConfig_18183_Desc = {
    Text = "사용 후 모든 적에게 [Arg1]턴 동안 <VulnerabilityIconKeywords:취약>을 부여한다."
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:취약>"
  },
  EnchantConfig_18184_Desc = {
    Text = "[Arg1]의 방어막을 획득합니다."
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:고급 철벽>"
  },
  EnchantConfig_18185_Desc = {
    Text = "사용 후 모든 적에게 [Arg1] 층 <IntoxicationIconKeywords:중독>을 부여하고, 모든 적에게 [Arg2]% <IntoxicationIconKeywords:중독>을 발동합니다."
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:독소>"
  },
  EnchantConfig_18186_Desc = {
    Text = "전투 시작 시, 해당 카드 원본의 복사본 [Arg1]장을 덱에 섞습니다. 원본 카드와 복사된 카드가 모두 <RetainIconKeywords:보존>을 획득합니다."
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:거울>"
  },
  EnchantConfig_18187_Desc = {
    Text = "사용 시 [Arg1]의 임시 힘을 획득합니다. 해당 각인이 부여된 카드에도 이 각인으로 증가한 <PowerIconKeywords:힘>이 적용됩니다."
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:고급 폭발>"
  },
  EnchantConfig_18188_Desc = {
    Text = "사용 후 카드를 [Arg1]장 뽑습니다."
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:묘수>"
  },
  EnchantConfig_18189_Desc = {
    Text = "사용 후 <DerivativeCardKeywords_4:「영감」> 카드 [Arg1]장을 드로우 덱에 추가합니다. (「영감」: 산출력을 1 획득하고, 카드를 1장 뽑습니다. <RetainIconKeywords:보존>, <DepleteIconKeywords:소모>.)"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:고급 영감>"
  },
  EnchantConfig_18190_Desc = {
    Text = "사용 후 모든 적에게 [Arg1]턴 동안 <WeaknessIconKeywords:허약>을 부여합니다."
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:고급 허약>"
  },
  EnchantConfig_18191_Desc = {
    Text = "사용 후 <EmbryoFusionIconKeywords:배아 융합> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:갈증>"
  },
  EnchantConfig_18192_Desc = {
    Text = "사용 후 모든 적에게 [Arg1]턴 동안 <WeaknessIconKeywords:허약>을 부여합니다."
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:허약>"
  },
  EnchantConfig_18193_Desc = {
    Text = "모든 적의 임시 <PowerIconKeywords:힘>이 [Arg1] 감소합니다."
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:고급 쇠약>"
  },
  EnchantConfig_18194_Desc = {
    Text = "사용 후 해당 카드의 복사본 [Arg1]장을 임시 <DimensionalSpaceIconKeywords:초차원 공간>에 추가합니다."
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:고급 도약>"
  },
  EnchantConfig_18195_Desc = {
    Text = "[Arg1]의 <PowerIconKeywords:힘>을 획득합니다."
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:완력>"
  },
  EnchantConfig_18196_Desc = {
    Text = "[Arg1]의 방어막을 획득합니다."
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:철벽>"
  },
  EnchantConfig_18197_Desc = {
    Text = "사용 후 산출력을 [Arg1] 획득합니다."
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:고급 계산>"
  },
  EnchantConfig_18198_Desc = {
    Text = "자신을 제외한 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:고급 촉매>"
  },
  EnchantConfig_18199_Desc = {
    Text = "사용 후 [Arg1] 층 <RetaliateIconKeywords:반격>을 획득하고, 모든 적에게 [Arg2]% <RetaliateIconKeywords:반격>을 발동합니다."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:가시>"
  },
  EnchantConfig_18200_Desc = {
    Text = "사용 후 추가로 [Arg1]번 발동하고, 검은 인장을 [Arg2]개 획득합니다.\n<DepleteIconKeywords:소모>, <GuyouKeywords:고유>."
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:반향>"
  },
  EnchantConfig_18201_Desc = {
    Text = "사용자가 [Arg1] 광기를 획득합니다."
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:광화>"
  },
  EnchantConfig_18202_Desc = {
    Text = "사용 시 [Arg1]의 임시 힘을 획득합니다. 해당 각인이 부여된 카드에도 이 각인으로 증가한 <PowerIconKeywords:힘>이 적용됩니다."
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:폭발>"
  },
  EnchantConfig_18203_Desc = {
    Text = "자신을 제외한 모든 깨어남체가 [Arg1] 광기를 획득합니다."
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:촉매>"
  },
  EnchantConfig_18204_Desc = {
    Text = "사용 후 해당 카드의 복사본 [Arg1]장을 임시 <DimensionalSpaceIconKeywords:초차원 공간>에 추가합니다."
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:도약>"
  },
  EnchantConfig_48006_Desc = {
    Text = "턴마다 한 번, 사용 시 2회 발동합니다."
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:합주>"
  },
  EnchantConfig_48007_Desc = {
    Text = "턴마다 한 번, 사용 시 3회 발동합니다."
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:고급 합주>"
  },
  EnchantConfig_49108_Desc = {
    Text = "해당 카드에 <RetainIconKeywords:보존>이 추가되고, 턴 종료 시 손패에 남아있다면 <RetainIconKeywords:보존>과 <DepleteIconKeywords:소모>가 추가된 해당 카드의 원본 복사본을 손패에 추가합니다."
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:잉태>"
  },
  EnchantConfig_59530_Desc = {
    Text = "사용 후 해당 깨어남체 이외의 모든 카드를 버리고, 무작위 비깨어남체 카드 5장을 획득한다. 매 전투 1회만 발동한다."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:환희의 이치>"
  },
  EnchantConfig_59531_Desc = {
    Text = "사용 후 카드를 2장 뽑고, 각인된 카드의 실타래제 산출력 소비량만큼 뽑은 카드의 산출력 소비를 감소시킵니다. 전투당 1회만 발동합니다."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:지혜의 이치>"
  },
  EnchantConfig_59532_Desc = {
    Text = "사용 후 <RetainIconKeywords:유지>와 <DepleteIconKeywords:소모>가 부여된 원본 복사본 3장을 획득한다. 매 전투 1회만 발동한다."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:번식의 이치>"
  },
  EnchantConfig_67415_Desc = {
    Text = "사용 후 해당 깨어남체 이외의 모든 카드를 버리고, 무작위 비깨어남체 카드 5장을 획득한다. 매 전투 1회만 발동한다."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:고급 환희의 이치>"
  },
  EnchantConfig_67416_Desc = {
    Text = "사용 후 카드를 4장 뽑고, 각인된 카드의 실타래제 산출력 소비량만큼 뽑은 카드의 산출력 소비를 감소시킵니다. 전투당 1회만 발동합니다."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:고급 지혜의 이치>"
  },
  EnchantConfig_67417_Desc = {
    Text = "사용 후 산출력 소비 -1이며 <RetainIconKeywords:보류> 및 <DepleteIconKeywords:소모>가 부여된 원본 복사본 3장을 획득합니다. 전투당 1회만 발동합니다."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:고급 번식의 이치>"
  }
})
return Text_EnchantConfig
