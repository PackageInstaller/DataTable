__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "When played, will take effect [Arg1] additional <plural value=\"[Arg1]\" singular=\"time\" plural=\"times\">, then <DepleteIconKeywords:Exhaust>. <RippleKeywords:Aftershock>: Draw 2 cards."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:Abyss Echo>"
  },
  EnchantConfig_18169_Desc = {
    Text = "When played, gain [Arg1] Arithmetica."
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:Computation>"
  },
  EnchantConfig_18170_Desc = {
    Text = "When played, gain [Arg1] <RetaliateIconKeywords:Counter>, then trigger [Arg2]% <RetaliateIconKeywords:Counter> against all enemies."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:Adv. Spike>"
  },
  EnchantConfig_18171_Desc = {
    Text = "When played, takes effect [Arg1] additional <plural value=\"[Arg1]\" singular=\"time\" plural=\"times\">, and you receive [Arg2] Black Sigils. (This Orison also affixed <DepleteIconKeywords:Exhaust> and <GuyouKeywords:Innate> to the card.)"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:Adv. Echo>"
  },
  EnchantConfig_18172_Desc = {
    Text = "When played, inflict [Arg1] Temp. <ExhaustionIconKeywords:STR▼> on all enemies."
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:Drain>"
  },
  EnchantConfig_18173_Desc = {
    Text = "When played, <EmbryoFusionIconKeywords:Embryo Fusion> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:Adv. Bloodlust>"
  },
  EnchantConfig_18174_Desc = {
    Text = "When played, inflict [Arg1] <plural value=\"[Arg1]\" singular=\"stack\" plural=\"stacks\"> of <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:Adv. Vulnerable>"
  },
  EnchantConfig_18175_Desc = {
    Text = "When played, trigger [Arg1] Tentacle <plural value=\"[Arg1]\" singular=\"attack\" plural=\"attacks\">."
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:Adv. Dominion>"
  },
  EnchantConfig_18176_Desc = {
    Text = "When played, trigger [Arg1] Tentacle <plural value=\"[Arg1]\" singular=\"attack\" plural=\"attacks\">."
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:Dominion>"
  },
  EnchantConfig_18177_Desc = {
    Text = "When played, draw [Arg1] <plural value=\"[Arg1]\" singular=\"card\" plural=\"cards\">."
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:Adv. Finesse>"
  },
  EnchantConfig_18178_Desc = {
    Text = "At the start of each battle, shuffle [Arg1] basic copies of the engraved card into the Draw Pile. Both the engraved card and the copies it creates have <RetainIconKeywords:Retain>."
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:Adv. Mirror>"
  },
  EnchantConfig_18179_Desc = {
    Text = "After being played, gain [Arg1] <PowerIconKeywords:STR>."
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:Adv. Might>"
  },
  EnchantConfig_18180_Desc = {
    Text = "When played, this card's Awakener gains <Energy:[Arg1]> Aliemus."
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:Adv. Berserk>"
  },
  EnchantConfig_18181_Desc = {
    Text = "When played, inflict [Arg1] <IntoxicationIconKeywords:Poison> on all enemies, then trigger [Arg2]% of each enemy's <IntoxicationIconKeywords:Poison>."
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:Adv. Toxin>"
  },
  EnchantConfig_18182_Desc = {
    Text = [[
When played, shuffle [Arg1] <DerivativeCardKeywords_4:"Insight"> into the Draw Pile.
Insight: Gain 1 Arithmetica. Draw 1 card. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Exhaust>.]]
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:Insight>"
  },
  EnchantConfig_18183_Desc = {
    Text = "When played, inflict [Arg1] <plural value=\"[Arg1]\" singular=\"stack\" plural=\"stacks\"> of <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:Vulnerable>"
  },
  EnchantConfig_18184_Desc = {
    Text = "When played, gain <Block:[Arg1]> Shield."
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:Adv. Bastion>"
  },
  EnchantConfig_18185_Desc = {
    Text = "When played, inflict [Arg1] <IntoxicationIconKeywords:Poison> on all enemies, then trigger [Arg2]% of each enemy's <IntoxicationIconKeywords:Poison>."
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:Toxin>"
  },
  EnchantConfig_18186_Desc = {
    Text = "At the start of each battle, shuffle [Arg1] basic copy of the engraved card into the Draw Pile. Both the engraved card and the copy it creates have <RetainIconKeywords:Retain>."
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:Mirror>"
  },
  EnchantConfig_18187_Desc = {
    Text = "When played, first gain [Arg1] Temp. <PowerIconKeywords:STR>, then resolve the card's effects. (Its DMG will benefit from this STR.)"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:Adv. Burst>"
  },
  EnchantConfig_18188_Desc = {
    Text = "When played, draw [Arg1] <plural value=\"[Arg1]\" singular=\"card\" plural=\"cards\">."
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:Finesse>"
  },
  EnchantConfig_18189_Desc = {
    Text = [[
When played, shuffle [Arg1] <DerivativeCardKeywords_4:"Insight"> into the Draw Pile.
Insight: Gain 1 Arithmetica. Draw 1 card. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Exhaust>.]]
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:Adv. Insight>"
  },
  EnchantConfig_18190_Desc = {
    Text = "When played, inflict [Arg1] <plural value=\"[Arg1]\" singular=\"stack\" plural=\"stacks\"> of <WeaknessIconKeywords:Weakness> on all enemies."
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:Adv. Weakness>"
  },
  EnchantConfig_18191_Desc = {
    Text = "When played, <EmbryoFusionIconKeywords:Embryo Fusion> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:Bloodlust>"
  },
  EnchantConfig_18192_Desc = {
    Text = "When played, inflict [Arg1] <plural value=\"[Arg1]\" singular=\"stack\" plural=\"stacks\"> of <WeaknessIconKeywords:Weakness> on all enemies."
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:Weakness>"
  },
  EnchantConfig_18193_Desc = {
    Text = "When played, inflict [Arg1] Temp. <ExhaustionIconKeywords:STR▼> on all enemies."
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:Adv. Drain>"
  },
  EnchantConfig_18194_Desc = {
    Text = "When played, add [Arg1] <plural value=\"[Arg1]\" singular=\"copy\" plural=\"copies\"> of it to Temporary <DimensionalSpaceIconKeywords:Ultra Space> slots."
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:Adv. Warp>"
  },
  EnchantConfig_18195_Desc = {
    Text = "After being played, gain [Arg1] <PowerIconKeywords:STR>."
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:Might>"
  },
  EnchantConfig_18196_Desc = {
    Text = "When played, gain <Block:[Arg1]> Shield."
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:Bastion>"
  },
  EnchantConfig_18197_Desc = {
    Text = "When played, gain [Arg1] Arithmetica."
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:Adv. Computation>"
  },
  EnchantConfig_18198_Desc = {
    Text = "When played, all other Awakeners gain <Energy:[Arg1]> Aliemus."
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:Adv. Catalysis>"
  },
  EnchantConfig_18199_Desc = {
    Text = "When played, gain [Arg1] <RetaliateIconKeywords:Counter>, then trigger [Arg2]% <RetaliateIconKeywords:Counter> against all enemies."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:Spike>"
  },
  EnchantConfig_18200_Desc = {
    Text = "The engraved card gains <DepleteIconKeywords:Exhaust> and <GuyouKeywords:Innate>. When played, takes effect [Arg1] additional <plural value=\"[Arg1]\" singular=\"time\" plural=\"times\">, and you receive [Arg2] Black Sigils."
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:Echo>"
  },
  EnchantConfig_18201_Desc = {
    Text = "When played, this card's Awakener gains <Energy:[Arg1]> Aliemus."
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:Berserk>"
  },
  EnchantConfig_18202_Desc = {
    Text = "When played, first gain [Arg1] Temp. <PowerIconKeywords:STR>, then resolve the card's effects. (Its DMG will benefit from this STR.)"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:Burst>"
  },
  EnchantConfig_18203_Desc = {
    Text = "When played, all other Awakeners gain <Energy:[Arg1]> Aliemus."
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:Catalyst>"
  },
  EnchantConfig_18204_Desc = {
    Text = "When played, add [Arg1] copy of it to a Temporary <DimensionalSpaceIconKeywords:Ultra Space> slot."
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:Warp>"
  },
  EnchantConfig_48006_Desc = {
    Text = "When played for the first time each turn, takes effect 1 additional time."
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:Ensemble>"
  },
  EnchantConfig_48007_Desc = {
    Text = "When played for the first time each turn, takes effect 2 additional times."
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:Adv. Ensemble>"
  },
  EnchantConfig_49108_Desc = {
    Text = "Card Obtained <RetainIconKeywords:Retain>, if in hand at turn end, Obtain a Base Copy with <RetainIconKeywords:Retain> and <DepleteIconKeywords:Exhaust>."
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:Birth>"
  },
  EnchantConfig_59530_Desc = {
    Text = "Play to discard all cards other than the Awakener, and draw 5 random non-Awakener cards. This effect can only be triggered once per battle."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:Lex Volis>"
  },
  EnchantConfig_59531_Desc = {
    Text = "Play to draw 2 cards, their Arithmetica Cost reduces the actual consumption of Orison cards, and it is effective only once per battle."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:Lex Nous>"
  },
  EnchantConfig_59532_Desc = {
    Text = "Play to gain 3 additional Base Copies of <RetainIconKeywords:Retain> and <DepleteIconKeywords:Exhaust>, effective only once per battle."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:Lex Genis>"
  },
  EnchantConfig_67415_Desc = {
    Text = "Play to discard all cards other than the Awakener, and draw 5 random non-Awakener cards. This effect can only be triggered once per battle."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:Adv. Lex Volis>"
  },
  EnchantConfig_67416_Desc = {
    Text = "Play to draw 4 cards; their Arithmetica Cost reduces by the Cost of this card, effective only once per battle."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:Adv. Lex Nous>"
  },
  EnchantConfig_67417_Desc = {
    Text = "Play to gain 3 Arithmetica Cost -1 and attach <RetainIconKeywords:Retain> and <DepleteIconKeywords:Exhaust> as Base Copies, effective only once per battle."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:Adv. Lex Genis>"
  }
})
return Text_EnchantConfig
