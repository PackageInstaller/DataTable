__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = [[
The Forbidden Lore Level (FL) starts equal to the Keeper Level (KL) and governs the strength of all three research depths. It is overridden and set to the average level of Awakeners and Keeper Level if that average is larger than KL.
Somatic Research: <Blue:{s1}>
Dictates how much Team HP is gained for every 100 points of the Awakener's CON stat.
Esoteric Research: <Blue:{s2}>
Dictates the power of STR Generation, Tentacle DMG, Shield, HP Recovery, and STR Reduction effects caused by Relics, Orisons, and Posses.
Occult Research: <Blue:{s3}>
Dictates the strength of Fixed Poison, Fixed Counter, Fixed DMG, and Fixed Bleed effects of Relics, Orisons, and Posses.
]]
  },
  ActorAttrType_121209_Text = {
    Text = "Forbidden Lore"
  },
  ActorAttrType_18103_Text = {Text = "Shield"},
  ActorAttrType_18104_Text = {
    Text = "Strike DMG % Adjust"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Crit. DMG +{s1}"
  },
  ActorAttrType_18105_Text = {Text = "Crit. DMG"},
  ActorAttrType_18106_Text = {
    Text = "Shield Boost"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "ATK+{s1}"},
  ActorAttrType_18107_Text = {Text = "ATK"},
  ActorAttrType_18108_Text = {Text = "CON"},
  ActorAttrType_18109_Text = {
    Text = "Card DMG % Adjust"
  },
  ActorAttrType_18110_Text = {
    Text = "Fragile % Adjust"
  },
  ActorAttrType_18111_Text = {
    Text = "Shield Taken % Adjust"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Defense +{s1}"
  },
  ActorAttrType_18112_Text = {Text = "Defense+"},
  ActorAttrType_18113_AttributeDesc = {
    Text = "Awakener's Aliemus Regen"
  },
  ActorAttrType_18113_Text = {
    Text = "Opening Aliemus"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = [[
The higher the CON, the higher the Max HP of the Awakener.
The higher your Keeper Level, the greater the impact of CON on the Max HP of the Awakener.]]
  },
  ActorAttrType_18114_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18114_Text = {Text = "CON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Aliemus refunded after Exalt"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Aliemus Cost-{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Aliemus Cost-"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = [[
The higher the CON, the higher the Max HP of the Awakener.
The higher your Keeper Level, the stronger the effect of CON on the Max HP of the Awakener.]]
  },
  ActorAttrType_18116_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18116_Text = {Text = "CON+"},
  ActorAttrType_18117_Text = {
    Text = "Tentacle DMG"
  },
  ActorAttrType_18118_Text = {
    Text = "Ultra Slots"
  },
  ActorAttrType_18119_Text = {
    Text = "DMG Taken % Adjust"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "The Awakener's Max Aliemus Limit and Exalt Aliemus Cost are both equal to their Base Aliemus."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Aliemus Limit +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Base Aliemus"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Skill 2 Level"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Skill 2 Level +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Skill 2 Level"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Defense Level"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Defense Level +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Defense Level"
  },
  ActorAttrType_18123_Text = {
    Text = "Hits Count Num Adjust"
  },
  ActorAttrType_18124_Text = {
    Text = "Shield Num Adjust"
  },
  ActorAttrType_18125_Text = {
    Text = "Shield Taken Num Adjust"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = [[
The team's Realm Mastery equals the sum of the Realm Mastery of the Awakeners in the team. Realm Mastery can enhance the team's Realm Legacy effects. If the current team is "Pure Aequor/Pure Caro/Pure Ultra", the effects of Realm Mastery are doubled.
For a team in the <Blue:Chaos> Realm, for every 1 point of Realm Mastery, when releasing a Posse, all Awakeners gain an additional <Blue:0.05> Aliemus.
For a team in the <Blue:Aequor> Realm, for every 1 point of Realm Mastery, after releasing an Exalt, there is a <Blue:0.25%> chance to gain an additional stack of Tentacle Gathering (if probability exceeds 100%, multiple stacks can be obtained). When switching to "Still Sea", the shield gained increases by <Blue:0.01%> of Max HP, and Tentacle attacks triggered by Active DMG in "Raging Waves" increase Tentacle DMG by <Blue:0.02%>.
For a team in the <Blue:Caro> Realm, for every 1 point of Realm Mastery, the first time you trigger Devour each round, you gain Shield of <Blue:0.01%> of Max HP and <Blue:0.005%> of Temporary STR (increases with lost HP, up to 100%).
For a team in the <Blue:Ultra> Realm, for every 1 point of Realm Mastery, at turn start, there is a <Blue:0.125%> chance to gain 1 "Insight" (if probability exceeds 100%, multiple can be obtained).]]
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Realm Mastery +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Realm Mastery"
  },
  ActorAttrType_18127_Text = {Text = "HP"},
  ActorAttrType_18128_AttributeUpText = {Text = "ATK+{s1}"},
  ActorAttrType_18128_Text = {Text = "ATK+"},
  ActorAttrType_18129_AttributeDesc = {
    Text = "The higher the Base DMG Bonus, the more DMG the Awakener deals"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Base DMG +{s1}"
  },
  ActorAttrType_18129_Text = {Text = "Base DMG"},
  ActorAttrType_18130_Text = {Text = "Level"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "Amount of Aliemus automatically recovered at the end of turns"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Aliemus Auto Recovery +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Aliemus Auto Recovery"
  },
  ActorAttrType_18132_Text = {
    Text = "Enlighten Level"
  },
  ActorAttrType_18133_Text = {
    Text = "Aliemus Taken % Adjust"
  },
  ActorAttrType_18134_Text = {
    Text = "Embryo Fusion Limit"
  },
  ActorAttrType_18135_Text = {
    Text = "Current Aliemus"
  },
  ActorAttrType_18136_Text = {
    Text = "DMG Taken Num Adjust"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Increases the Shield generated and HP recovered by Awakeners by percentage"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Shield & Healing Amp. +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Shield & Healing Amp"
  },
  ActorAttrType_18138_Text = {
    Text = "Healing Boost"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Each Arithmetica consumed grants {s1} Keyflare. As this attribute increases, the additional Keyflare gained will gradually decay."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Keyflare Regen +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Keyflare Regen Level"
  },
  ActorAttrType_18140_Text = {
    Text = "Death Res. Count"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Strike Level"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Strike Level +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Strike Level"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Increases all Awakener's \"Base DMG\", stacks of \"Fixed Value Poison\" and \"Fixed Value Counter\", and initial Tentacle DMG by percentage."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "DMG Amplification +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "DMG Amplification"
  },
  ActorAttrType_18143_Text = {
    Text = "Exalt DMG % Adjust"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Chance to resist incoming Critical Hit when attacked by Awakeners"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Crit. Resistance +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Crit. Resistance"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Exalt Level"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Exalt Lv. +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Exalt Level"
  },
  ActorAttrType_18146_Text = {
    Text = "Healing Taken Num Adjust"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Lucky Orison Rate +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Lucky Orison Rate"
  },
  ActorAttrType_18148_Text = {
    Text = "Healing Num Adjust"
  },
  ActorAttrType_18149_Text = {Text = "CON+"},
  ActorAttrType_18150_Text = {
    Text = "Weakness % Adjust"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "Your team's Death Resistance equals the sum of the Death Resistance of all the Awakeners in the team. Upon receiving a fatal blow in battle, there is a chance to trigger Death Resistance and retain 1 point of HP. After triggering, you gain an additional 2  Arithmetica and draw 2 cards in the next turn. Current and subsequent Death Resistance % is then halved until the Investigation ends."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Death Resistance +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Death Resistance"
  },
  ActorAttrType_18152_Text = {
    Text = "Aliemus % Adjust"
  },
  ActorAttrType_18154_Text = {
    Text = "Tentacle Limit"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Increases Black Sigil drops by percentage"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Sigil Yield +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Sigil Yield"
  },
  ActorAttrType_18156_Text = {
    Text = "Aliemus Taken Num Adjust"
  },
  ActorAttrType_18157_Text = {
    Text = "Hidden Intentions"
  },
  ActorAttrType_18158_Text = {
    Text = "DMG Num Adjust"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Crit. Rate +{s1}"
  },
  ActorAttrType_18159_Text = {Text = "Crit. Rate"},
  ActorAttrType_18160_AttributeDesc = {
    Text = "Skill 1 Level"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Skill 1 Level +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Skill 1 Level"
  },
  ActorAttrType_18161_Text = {Text = "Level"},
  ActorAttrType_18162_Text = {Text = "DMG Boost"},
  ActorAttrType_18163_Text = {
    Text = "Tentacle Count"
  },
  ActorAttrType_18164_Text = {
    Text = "Healing Taken % Adjust"
  },
  ActorAttrType_18165_Text = {
    Text = "Max Arithmetica"
  },
  ActorAttrType_18166_Text = {
    Text = "Vulnerable % Adjust"
  },
  ActorAttrType_18167_AttributeUpText = {Text = "DEF+{s1}"},
  ActorAttrType_18167_Text = {Text = "DEF"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Rouse Level"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Rouse Level +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Rouse Level"
  },
  ActorAttrType_21322_Text = {
    Text = "Keyflare Regen"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Regenerate {s1} Aliemus after every Exalt. Extra Aliemus regen bonus reduces as this Attribute grows."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Aliemus Regen Level +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Aliemus Regen Level"
  },
  ActorAttrType_22214_Text = {
    Text = "Aliemus Regen"
  }
})
return Text_ActorAttrType
