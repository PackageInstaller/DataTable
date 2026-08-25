__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SchoolConfig = readonly({
  SchoolConfig_1_Name = {Text = "Chaos"},
  SchoolConfig_1_SchoolBattleTips_1 = {
    Text = "Silver Key Resonance: At turn end, gain 250 Keyflare. After releasing Posse, all Awakeners gain <BlueQuality:[Arg1]> Aliemus. When releasing the second Posse, it instead releases \"Unforgotten Twilight\": Select one unlocked Posse to release and have it take effect twice, and each unlocked Posse can only be chosen once in this Exploration and the initially carried Posse cannot be selected."
  },
  SchoolConfig_1_SchoolBattleTips_2 = {
    Text = "Primordial Influx: Base Keyflare is increased to 2000, Team DMG Amplification is increased by 50%, and all Awakeners' ATK and DEF are increased by 10%. If the team consists solely of Chaos Awakeners, the DMG Amplification bonus from this effect is doubled. At the start of battle, gain 2000 Keyflare.\n\nConfluent Keys: All Awakeners' Keyflare Regen Levels are set to the team average and no longer decay. Awakeners no longer gain Keyflare from Arithmetica consumed; instead, the first Command Card played by each Awakener per turn grants Keyflare equal to (this Awakener's Keyflare Regen × 3) + 100.\n\nIndivisible Realm: No longer triggers other Realms' Pure Realm, Double Realm Mastery, or Double DMG Amplification effects.\n\nPrimordial Echo: Rouse Cards gain Prepare 1; the currently equipped Posse is automatically unleashed the first time they are played each turn.\n\nMemory Fragments: Posse is replaced with Primordia: Dual Recurrence and Primordia: Triad Revelation, and the carried Posse itself can no longer be unleashed.\n\n-Primordia: Dual Recurrence: Discover 3 Posses from those in hand, then choose 1 to unleash twice.\n-Primordia: Triad Revelation: Discover 3 sets of Posses from those in hand, each set containing 3 different Posses. Choose one set to unleash each Posse within it once, in sequence.\nThe Posses featured in Primordia: Dual Recurrence and Primordia: Triad Revelation are drawn from the eight types of Primordial Memory.\nPrimordia: Dual Recurrence and Primordia: Triad Revelation each count as unleashing only 1 Posse. When their effects would trigger multiple times, only the first Posse to take effect is valid.\n\nPrimordia: Chaos Mastery: Realm Mastery becomes Primordia: Chaos Mastery. Each point of Primordia: Chaos Mastery increases the Posse Potency by 0.05%. Each point of Posse Potency increases Fixed Poison, Fixed Counter, Fixed STR, Fixed Ancient Embers by 2%, and Fixed Shield, Fixed HP Recovery, STR ▼, Crit. Rate, Crit. DMG, DMG Amplification, Realm Mastery, Aliemus Generation, Embryo Fusion, and Keyflare Generation by 1%."
  },
  SchoolConfig_1_SchoolFeature = {
    Text = "When Awakeners of this Realm team up with other Realms, they can enhance the corresponding Realm's related abilities. On the other hand, a full Chaos lineup possesses stronger Silver Key related powers."
  },
  SchoolConfig_1_SchoolTips = {
    Text = "Empowers Keyflare & Posse skills and amplifies the abilities of other Realms."
  },
  SchoolConfig_1_SchoolTipsName = {
    Text = "Cosmic Kaleido"
  },
  SchoolConfig_1_Tips = {
    Text = [[
Silver Key Resonance: At the end of the turn, gain 250 Keyflare. After using a Posse, all Awakeners gain 5 Aliemus. When unleashing the second Posse, instead unleash "Unforgotten Twilight": Choose 1 unlocked Posse to unleash and activate it 2 times. Each unlocked Posse can only be chosen once per exploration, and the initially carried Posse cannot be selected.
Omniscent Relics: If the Keeper's Level reaches 45, Discover 1 Silver Relic at the Start of exploration.
Chaos Mastery: For every 1 point of Realm Mastery the team has, after using a Posse, all Awakeners gain an additional 0.05 Aliemus.
Death Defiance: In any team, if a Chaos Awakener is present, Death Resistance +100%.
Chaos Symbiosis: When mixed with other Realms, "Silver Key Resonance," "Omniscent Relics," and "Chaos Mastery" no longer take effect. The pure Talent effects of other Realms are always triggered, and different Realm Symbiosis effects are gained depending on the Realm.
Aequor Symbiosis: For every 1 Chaos Awakener in the team, base Tentacle DMG increases by 1% of team Max HP. After a Chaos Awakener uses Exalt, at the end of the turn, 1 additional Tentacle is driven to Attack the enemy, and all Aequor Awakeners gain 10 Aliemus.
Caro Symbiosis: After a Chaos Awakener uses Exalt, Embryo Fusion +35.
Ultra Symbiosis: At the Start of combat, for every 1 Chaos Awakener in the team, permanently increase STR by 1% of Max HP and reduce all enemies' STR by 0.5% of their own Max HP, while increasing all Ultra Awakeners' Crit. DMG by 10%.]]
  },
  SchoolConfig_2_Name = {Text = "Caro"},
  SchoolConfig_2_SchoolBattleTips_1 = {
    Text = [[
Embryo Fusion: At turn start, Embryo Fusion +<BlueQuality:[Arg1]>.
Crimson Furnace: At turn start, accumulate <BlueQuality:[Arg9]> Crimson Furnace. After the battle ends, accumulate <BlueQuality:[Arg2]> Crimson Furnace, and if the current Realm is "Pure Caro," the accumulation is doubled, up to <BlueQuality:[Arg3]>. At the end of the battle, for every remaining 1 "Embryo" in hand, additionally accumulate <BlueQuality:[Arg2]> Crimson Furnace.
Embryo Devour: When unleashing Exalt, Caro Awakener will consume an "Embryo" and trigger the Devour effect. After the team's first trigger of "Devour" each turn, gain Shield equal to <BlueQuality:[Arg4]%> Max HP (<BlueQuality:[Arg5]>) and Temporary STR equal to <BlueQuality:[Arg6]%> Max HP (<BlueQuality:[Arg7]>).]]
  },
  SchoolConfig_2_SchoolBattleTips_2 = {
    Text = "Embryo Fusion: At turn start, Embryo Fusion +<BlueQuality:[Arg1]>.\nPropagule Embryo: The first time each Awakener consumes a \"Propagule Embryo\" each turn, they gain <BlueQuality:[Arg4]> stacks of \"Propagation Fiesta\": For each stack owned, the next Exalt this turn by this Awakener has its DMG, Fixed Shield Genaration, Fixed HP Recovery, Fixed STR Generation, STR▼, Tentacle DMG Generation, Fixed Poison, and Fixed Counter final effects increased by 1%.\nCrimson Furnace: At turn start, accumulate <BlueQuality:[Arg2]> Crimson Furnace, up to <BlueQuality:[Arg3]>, with a 3-turn cooldown.\nCrimson Corrosion: After using Crimson Furnace, inflict Corrosion on all enemies equal to 1% of their Max HP. The more Crimson Furnace consumed, the stronger the Corrosion effect, up to +100%. Deals 5× Corrosion effect against \"Empty Shell\" enemies.\nAt the start of exploration, Max HP +10%, team DMG Amplification +50%. All Awakeners gain <BlueQuality:[Arg5]> stacks of \"Propagation Fiesta\" at the start of each turn.\n\"Caro Mastery\": Each point of Realm Mastery increases the \"Propagation Fiesta\" stacks gained from \"Propagation: Caro\" by 0.05%.\nPure Caro: If the team consists solely of Caro or Chaos Awakeners, the Caro Mastery effect and the DMG Amplification provided by the Realm are doubled."
  },
  SchoolConfig_2_SchoolFeature = {
    Text = "Awakeners of this Realm require choosing how to accumulate and utilize Embryos, which can be actively used to provide Aliemus or be Devoured to enhance Exalts."
  },
  SchoolConfig_2_SchoolTips = {
    Text = "Thrives in dire situations with the help of Embryo and Crimson Furnace, turning risks into rewards."
  },
  SchoolConfig_2_SchoolTipsName = {
    Text = "Scarlet Sacrifice"
  },
  SchoolConfig_2_Tips = {
    Text = [[
Embryo Fusion: At the start of the turn, Embryo Fusion +30. The lower the HP, the higher the effect, up to a maximum increase of 100. Upon reaching 100, place 1 "Embryo" into hand. "Embryo" can be used directly to provide 30 Aliemus to one Awakener and gain 10% Temporary Crit. Rate.
Crimson Furnace: At the start of the turn, accumulate Crimson Furnace equal to 3% Max HP. After combat ends, accumulate Crimson Furnace equal to 5% Max HP. Crimson Furnace can be used for HP Recovery, up to 25% Max HP. At the end of combat, for each remaining "Embryo" in hand, accumulate Crimson Furnace equal to 5% Max HP.
Embryo Devour: The Exalt of Caro Awakeners has the "Devour" Effect. When used, it will attempt to consume an "Embryo". If the consumption is successful, the "Devour" Effect is triggered. The first time "Devour" is triggered each turn, the team gains Shield equal to 4% Max HP and Temporary STR equal to 2% Max HP. The lower the HP, the higher the effect, up to a maximum increase of 100%.
Caro Mastery: For every 1 point of Realm Mastery the team has, after the first "Devour" trigger, additionally gain Shield equal to 0.01% Max HP and Temporary STR equal to 0.005% Max HP. The lower the HP, the higher the effect, up to a maximum increase of 100%.
Pure Caro: If the team consists solely of Caro Awakeners, the final value of the Caro Mastery stat is doubled, and the accumulated Crimson Furnace is doubled.]]
  },
  SchoolConfig_3_Name = {Text = "Ultra"},
  SchoolConfig_3_SchoolBattleTips_1 = {
    Text = [[
Dimension Shuttle: After playing the first Command Card each turn, a Fleeting, Basic Copy of it will be put into Ultra Space. This cannot trigger during Ultra Rounds.
Ultra Round: If Ultra Space is full at turn end, an Ultra Round begins. During this extra turn, pull all cards from Ultra Space into hand instead of drawing from the Draw Pile. DMG, Shield, HP Recovery, Keyflare, Aliemus, STR, Poison, Counter, and Bleed effects during Ultra Rounds -25%.
Annihilation: Destroy the leftmost card in Ultra Space, and create 1 "Insight." Annihilation can only be used once per turn.
Ultra Mastery: For each 1 point of Realm Mastery, there is a 0.125% (<BlueQuality:[Arg1]%>) chance at turn start to create 1 "Insight." If the chance exceeds 100%, multiple "Insight" may be created.
Pure Ultra: If the team consists only of Ultra or Chaos Awakeners, the Ultra Mastery effect is doubled, and the team is no longer affected by the stat reduction during Ultra Rounds.]]
  },
  SchoolConfig_3_SchoolBattleTips_2 = {
    Text = "Dimension Shuttle: After playing the first Command Card each turn, a Fleeting, Basic Copy of it will be put into Ultra Space and granted <BlueQuality:[Arg2]> stacks of Singularity Beacon. This cannot trigger during Ultra Rounds. If a card triggers Dimension Shuttle, it also benefits from the effects of Singularity Beacon.\nSingularity Beacon: For each stack, a card's Final DMG, Fixed STR & Tentacle DMG gain, Fixed Poison & Counter each +2%; Final Fixed Shield, Fixed HP Recovery, and STR▼ each +1%. This effect clears when the card is played. Cards with this effect cannot trigger Dimension Shuttle.\nUltra Space: When full, beginning the Ultra Round does not end the turn nor does it start one; discard all non-Retain cards, resolve their Fleeting effects, pull all cards from Ultra Space, and set Arithmetica to 5. This current turn continues as an Ultra Round.\nSingularity Annihilation: Pull the leftmost card out from Ultra Space and into hand. 3 turns cooldown.\nAt the start of investigation, gain +50% DMG Amplification and 15 stacks of Singularity Prism.\nSingularity Prism: All Command Cards' effects increase as though they had this many stacks of Singularity Beacon.\nUltra Mastery: For each 1 point of Realm Mastery, Singularity Beacon stacks from Singularity Prism and Dimension Shuttle increase by 0.05%.\nPure Ultra: If the team consists only of Ultra or Chaos Awakeners, the Ultra Mastery effect and Realm DMG Amplification are doubled."
  },
  SchoolConfig_3_SchoolFeature = {
    Text = "Awakeners of this Realm require careful planning of the Ultra Deck. The first Skill Card played each Turn automatically enters the Ultra Deck. If Ultra Deck is full at the End of a Turn, an extra Turn is triggered and the cards in Ultra Deck are placed into hand."
  },
  SchoolConfig_3_SchoolTips = {
    Text = "Controls the flow of battle through the Ultra Space mechanic by arranging hand cards."
  },
  SchoolConfig_3_SchoolTipsName = {
    Text = "Dimensional Leap"
  },
  SchoolConfig_3_Tips = {
    Text = [[
Dimension Shuttle: After playing the first Command Card each turn, a Fleeting, Basic Copy of it will be put into Ultra Space. This cannot trigger during Ultra Rounds.

Ultra Round: If Ultra Space is full at turn end, an Ultra Round begins. During this extra turn, pull all cards from Ultra Space into hand instead of drawing from the Draw Pile. DMG, Shield, HP Recovery, Keyflare, Aliemus, STR, Poison, Counter, and Bleed effects during Ultra Rounds -25%.

Annihilation: Destroy the leftmost card in Ultra Space, and create 1 "Insight." Annihilation can only be used once per turn.

Ultra Mastery: For each 1 point of Realm Mastery, there is a 0.125% chance at turn start to create 1 "Insight." If the chance exceeds 100%, multiple "Insight" may be created.

Pure Ultra: If the team consists only of Ultra or Chaos Awakeners, the Ultra Mastery effect is doubled, and the team is no longer affected by the stat reduction during Ultra Rounds.]]
  },
  SchoolConfig_4_Name = {Text = "Aequor"},
  SchoolConfig_4_SchoolBattleTips_1 = {
    Text = "Tentacle Stance: At the start of a turn, it is initially in the \"Surging Tides\" stance, in which clicking the Tentacle allows you to switch to \"Tranquil Sea\" stance or \"Raging Waves\" stance. If the turn ends while still in the \"Surging Tides\" stance, a Tentacle is generated at the start of the next turn.\nTentacle Gathering: After Awakeners unleash Exalt, gain 1 stack of Tentacle Gathering, with a <BlueQuality:[Arg5]％> chance of gaining 1 extra stack. At turn end, each stack of Tentacle Gathering drives a Tentacle to attack the front-row enemy, then clears Tentacle Gathering stacks.\nTentacle Crit. Rate: <BlueQuality:[Arg6]%>.\nTentacle Crit. DMG: <BlueQuality:[Arg7]%>.\nTentacle Overflow: When the Permanent Tentacle count exceeds the limit, a Tentacle attacks 3 times, and increases Tentacle Limit by 1. Each time the effect triggers, the number of triggers needed to increase Tentacle Limit rises by 1."
  },
  SchoolConfig_4_SchoolBattleTips_2 = {
    Text = [[
Tentacle Stance: At turn start, it is initially in the "Surging Tides" stance.
In the "Surging Tides" stance, you can click the Tentacle to switch to the "Tranquil Sea" stance or "Raging Waves" stance, each with a cooldown of 3 turns. If the turn ends while still in the "Surging Tides" stance, a Tentacle is generated at the next turn start.
Realm Mastery changed to "Benthos: Aequor Mastery," no longer possessing the Tentacle Gathering effect. Each point of Realm Mastery increases the Shield of "Benthos: Tranquil Sea" by 0.025% Max HP, and increases the Tentacle DMG of "Benthos: Raging Waves" by an additional 0.025%. If the team consists of purely Aequor and Chaos awakeners, the "Benthos: Aequor Mastery" effect doubles.
Tentacle Crit. Rate: <BlueQuality:[Arg3]%>.
Tentacle Crit. DMG: <BlueQuality:[Arg4]%>.
Tentacle Overflow: When the Permanent Tentacle count exceeds the limit, a Tentacle attacks 3 times, and increases Tentacle Limit by 1. Each time the effect triggers, the number of triggers needed to increase Tentacle Limit rises by 1.]]
  },
  SchoolConfig_4_SchoolFeature = {
    Text = "Awakeners of this Realm excel in controlling Tentacles, able to skillfully generate, enhance, and command multiple Tentacles to attack enemies."
  },
  SchoolConfig_4_SchoolTips = {
    Text = "Commands Tentacles that can flexibly switch between stances for different tactical functions."
  },
  SchoolConfig_4_SchoolTipsName = {
    Text = "Touch of the Abyss"
  },
  SchoolConfig_4_Tips = {
    Text = [[
Tentacle Dominion: At battle start, generate 1 Tentacle. The Tentacle will automatically attack front-row enemies at the end of each turn. 
Tentacle Stance is set to the default "Surging Tides" stance at turn start. In Surging Tides stance, 1 Tentacle will be gained at turn end. You can switch the Tentacle Stance once per turn. Switching to "Tranquil Sea" immediately grants Shield equal to 8% of Max HP. Each time the Tentacle attacks, it gains Shield equal to 0.2% of Max HP, but the Tentacle DMG for this turn is reduced to 50%. Switching to "Raging Waves" increases the Tentacle DMG for this turn to 125%. After dealing Active DMG, 1 Tentacle will attack the target enemy, dealing 50% of the Tentacle DMG, but at turn end, 1 Tentacle will be lost. 
Tentacle Gathering: After using Exalt, the Awakener gains 1 stack of Tentacle Gathering. At the end of each turn, for each stack of Tentacle Gathering, 1 Tentacle will attack front-row enemies, then the Tentacle Gathering is cleared. 
Tentacle Critical Hit: Tentacles can score critical hits. The initial Crit. Rate and Crit. DMG are 50% of the total Crit. Rate and Crit. DMG of all Awakeners entering the stage. For each Awakener in the stage that gains 1% Crit. Rate and Crit. DMG, the Tentacle's Crit. Rate and Crit. DMG increase by 0.25%. 
Aequor Mastery: For each point of Realm Mastery in the team, there is a 0.25% chance to gain an additional stack of Tentacle Gathering at turn end (chances exceeding 100% can result in multiple stacks). Switching to "Tranquil Sea" immediately grants Shield that +0.01% of Max HP, and the DMG from Tentacle attacks triggered by Active DMG in "Raging Waves" +0.02%. 
Pure Aequor: If the team consists only of Aequor Awakeners, the effects of Aequor Mastery are doubled, and the number of Tentacles generated At battle start is also doubled.]]
  }
})
return Text_SchoolConfig
