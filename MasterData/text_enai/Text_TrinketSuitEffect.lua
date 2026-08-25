__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "April Tribute"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Crit. DMG +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: At turn start, if the enemies' total HP is above 75%, the wielder's Temporary Crit. Rate and Crit. DMG increase by 35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Circular Poem (Unfinished)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "At the start of even turns, reduce the Arithmetica Cost of a random card in hand by 1."
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Returnal Line"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Realm Mastery +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: At the start of next battle, gain STR equal to 12% of the wielder's ATK. If the current Realm is Aequor, the effect changes to \"At turn start, there is a (50 + 0.25 * team's Realm Mastery)% chance to gain 1 stack of Tentacle Gathering. Multiple stacks can be gained if the probability exceeds 100%, and the chance doubles in Boss Battles.\""
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Cursed Rabbit"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Realm Mastery +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "The wielder's Shield and HP Recovery increase by 12%."
  },
  TrinketSuitEffect_18339_Name = {Text = "Paradox"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Keyflare Regen Level +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Team Unique>: Increases the wielder's Base Aliemus by 20. Increases Crit. Rate, Crit. DMG, Shield, and HP Recovery of the wielder's Command Cards by 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Organic Form"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Sigil Yield +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>. At the start of exploration, reduce up to 100% Death Resistance. For each 1% reduced, increase the wielder's Aliemus by 0.15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Crimson Pulse"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Crit. DMG +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "After releasing Posse, the wielder gains 30% Temporary Crit. Rate."
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Standard Covenant SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "Damage, Healing, and Shield generated the wielder are increased by 15%."
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Standard Covenant R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "Damage, Healing, and Shield generated the wielder are increased by 15%."
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Deus Ex Machina"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Realm Mastery +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "Gain 1 Arithmetica in the first turn of each battle, and gain an additional 1 Arithmetica every 4 turns during boss battles."
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Photosynthesis Rite"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "DMG Amplification +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "Team Unique. When the wielder's Command Card enters Ultra Space, Embryo Fusion +25%~50%, the lower the current HP, the higher the Embryo Fusion gained."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Re-evolution"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Aliemus Regen Level +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Team Unique>: Gain 35 Aliemus at the start of exploration. After using Exalt in this battle, gain 2 Aliemus at turn end. This effect can stack up to 3 times."
  },
  TrinketSuitEffect_18347_Name = {Text = "Life Drain"},
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Keyflare Regen Level +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: At turn end, gain Keyflare equal to 200% of the equipping character's Keyflare Regen. If the current Realm is \"Caro,\" the effect changes to increase Embryo Fusion by +1% for every 5 Keyflare Regen."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Dream of Medicine"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "DMG Amplification +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Team Unique>: Lose 8 Black Sigils after the battle ends. At the start of the battle, shuffle an original copy of each of the wielder's innate Command Cards (except for Strike and Defense) into the Draw Pile."
  },
  TrinketSuitEffect_18349_Name = {Text = "Sweet Slug"},
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Death Resistance +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "Team Unique. If \"Annihilation\" is unleashed and the Tentacle Stance is switched within 1 turn, the wielder's Shield, Healing, and Final DMG +25% this turn, with a 3-turn cooldown."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Theater Cat (Unfinished)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "The wielder's attacks are guaranteed to critically hit enemies with more than 75% HP."
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Ring of Chamber 36"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Aliemus Regen Level +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>. Keyflare cap and Posse Keyflare cost +200. Exalt Crit. Rate, Crit. DMG, Shield, and HP Recovery +30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Twisted Twins: White"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Even-numbered turn starts: Add the wielder's \"Defense\" with <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust> to your hand."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Scarlet Embrace"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Crit. Rate +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "the wielder gains 35 Keyflare when dealing Damage, or 70 Keyflare for Crit. DMG. This effect can trigger up to 3 times per turn."
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Standard Covenant SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "Damage, Healing, and Shield generated the wielder are increased by 15%."
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Unstained Chronicle"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Keyflare Regen Level +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: After using Posse, recover HP equal to 12% of the wielder's CON, increasing with the percentage of lost HP, up to 24% of the wielder's CON."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Steppenwolf"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "DMG Amplification +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "Wielder's Base DMG dealt is increased by 20%, and the <IntoxicationIconKeywords:Poison> and <RetaliateIconKeywords:Counter> they deal are increased by 10%."
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Feast from Afar"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Sigil Yield +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "At the start of the exploration, gain 10 Black Sigils. The wielder's \"Defense\" increases Shield by 60%."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Twisted Twins: Black"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Crit. Rate +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "At the start of odd turns, add the wielder's \"Strike\" with <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust> to your hand."
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Chrysalis of the Maiden"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Crit. Rate +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "Team Unique. The wielder gains 8% Temporary Crit. DMG for each Tentacle after consuming an Embryo for the first time each turn, up to 80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Burial Ground's Sighs"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Death Resistance +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "At the start of the level, <DeathResistanceIconKeywords:Death Resistance> increases by 25%. After triggering Death Resistance, the wielder gains 50 Aliemus."
  },
  TrinketSuitEffect_99234_Name = {Text = "Humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Suggested Translation"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Suggested Translation"
  },
  TrinketSuitEffect_99235_Name = {Text = "Ascension"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Suggested Translation"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Suggested Translation"
  },
  TrinketSuitEffect_99236_Name = {Text = "Styx"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Suggested Translation"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Suggested Translation"
  }
})
return Text_TrinketSuitEffect
