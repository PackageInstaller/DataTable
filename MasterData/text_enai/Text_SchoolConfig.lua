__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SchoolConfig = readonly({
  SchoolConfig_1_Name = {Text = "Chaos"},
  SchoolConfig_1_SchoolBattleTips_1 = {
    Text = "Silver Key Resonance: At turn end, gain 250  Keyflare. After releasing Posse, all Awakeners gain <BlueQuality:[Arg1]> Aliemus. When releasing the second Posse, it instead releases \"Unforgotten Twilight\": Select one unlocked Posse to release and have it take effect twice, and each unlocked Posse can only be chosen once in this Exploration and the initially carried Posse cannot be selected."
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
Silver Key Resonance: At the end of turn, gain 250 Keyflare. After using a Posse, all Awakeners gain 5 Aliemus. When "Unforgotten Twilight" is played, select 1 unlocked Posse to trigger it 2 times. Each unlocked Posse can only be selected once per exploration and cannot be chosen if it was initially equipped.
-Omniscent Relics: If Keeper Level reaches 45, discover 1 Silver Relic at the start of exploration.
-Chaos Mastery: For each point of Realm Mastery in the team, after using a Posse, all Awakeners gain an additional 0.05 Aliemus.
-Death Defiance: In any team, if there is a Chaos Awakener, Death Resistance +100%.
-Chaos Symbiosis: When mixed with other Realms, "Silver Key Resonance", "Omniscent Relics", and "Chaos Mastery" no longer take effect. Always trigger the Pure Talent effects and gain different Realm Symbiosis effects based on the Realm.
-Aequor Symbiosis: For each Chaos Awakener in the team, base Tentacle DMG increases by 0.01% of your Max HP. After a Chaos Awakener releases Exalt, at the end of turn, an additional Tentacle attacks the Enemy, and all Aequor Awakeners gain 10 Aliemus.
-Caro Symbiosis:. After a Chaos Awakener uses Exalt, Embryo Fusion +35%.
-Ultra Symbiosis: At the start of battle, for each Chaos Awakener in the team, permanently increase 1% of the Max HP as STR and reduce all Enemies' STR by 0.5% of their own Max HP. Simultaneously, all Ultra Awakeners gain 10% increased Crit. DMG.]]
  },
  SchoolConfig_2_Name = {Text = "Caro"},
  SchoolConfig_2_SchoolBattleTips_1 = {
    Text = "Embryo Fusion: At turn start, Embryo Fusion +[Arg1]％.\nCrimson Furnace: At turn start, accumulate <BlueQuality:[Arg9]> Crimson Furnace. After the battle ends, accumulate <BlueQuality:[Arg2]> Crimson Furnace, and if the current Realm is \"Pure Caro,\" the accumulation is doubled, up to <BlueQuality:[Arg3]>. At the end of the battle, for every remaining 1 \"Embryo\" in hand, additionally accumulate <BlueQuality:[Arg2]> Crimson Furnace.\nEmbryo Devour: When unleashing Exalt, Caro Awakener will consume an \"Embryo\" and trigger the Devour effect. After the team's first trigger of \"Devour\" each turn, gain Shield equal to <BlueQuality:[Arg4]％> Max HP (<BlueQuality:[Arg5]>) and Temporary STR equal to <BlueQuality:[Arg6]％> Max HP (<BlueQuality:[Arg7]>)."
  },
  SchoolConfig_2_SchoolBattleTips_2 = {
    Text = [[
: Embryo Fusion: At turn start, Embryo Fusion +[Arg1]%.
Crimson Furnace: At turn start, accumulate <BlueQuality:[Arg9]> Crimson Furnace. At battle end, for each "Embryo" remaining in hand, accumulate an additional <BlueQuality:[Arg2]> Crimson Furnace.
Embryo Devour: The Exalt of Caro Awakeners consumes "Embryo" and triggers the Devour effect twice.
When Realm Mastery changes to "Breeding : Caro Mastery," lose the "Devour Shield Strength" effect. Each point of Realm Mastery increases the final DMG, Shield, Strength changes, Tentacle DMG, HP Recovery, Fixed Poison, and Fixed Counter effects of Exalt by Awakeners who consumed Embryo this turn by 0.03%. If the team consists of Caro or Chaos Awakeners, the "Breeding : Caro Mastery" effect is doubled.
: After exploration begins, the team's DMG Amplification +50%. If the team consists solely of Caro or Chaos Awakeners, the DMG Amplification gained from this effect is doubled.]]
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
Embryo Fusion: At turn start, Embryo Fusion +30%. The lower your HP, the stronger the effect, with a maximum increase of 100%. When it reaches 100%, add 1 "Embryo" to your hand. "Embryo" can be used directly to grant an Awakener 30 Aliemus and 10% Temporary Crit. Rate.
Crimson Furnace: At turn start, accumulate 3% Max HP into the Furnace. After battle, accumulate 5% of Max HP into the Furnace. Crimson Furnace accumulates up to 25% of Max HP, and can be consumed to restore HP. At the end of battle, for each Embryo remaining in your hand, accumulate an additional 5% of Max HP as Crimson Furnace.
Embryo Devour: The Exalt of Caro Awakeners has the "Devour" effect, which attempts to consume an "Embryo" when used. If consumption is successful, trigger the "Devour" effect. After the first "Devour" effect is triggered each turn, gain 4% of Max HP as a Shield and 2% of Max HP as Temporary STR, the lower the HP, the higher the effect, up to a maximum increase of 100%.
-Caro Mastery: For every 1 point of Realm Mastery in the team, after the first "Devour" effect is triggered, gain an additional 0.01% of Max HP as a Shield and 0.005% of Max HP as Temporary STR, the lower the HP, the higher the effect, up to a maximum increase of 100%.
-Pure Caro: If the team consists only of Caro Awakeners, the final value of Caro Mastery is doubled, and the base accumulation of Crimson Furnace is also doubled.]]
  },
  SchoolConfig_3_Name = {Text = "Ultra"},
  SchoolConfig_3_SchoolFeature = {
    Text = "Awakeners of this Realm require careful planning of the Ultra Deck. The first Skill card played each Turn automatically enters the Ultra Deck. If Ultra Deck is full at the End of a Turn, an extra Turn is triggered and the cards in Ultra Deck are placed into hand."
  },
  SchoolConfig_3_SchoolTips = {
    Text = "Controls the flow of battle through the Ultra Space mechanic by arranging hand cards."
  },
  SchoolConfig_3_SchoolTipsName = {
    Text = "Dimensional Leap"
  },
  SchoolConfig_4_Name = {Text = "Aequor"},
  SchoolConfig_4_SchoolBattleTips_1 = {
    Text = "Tentacle Stance: At the start of a turn, it is initially in the \"Surging Tides\" stance, in which clicking the Tentacle allows you to switch to \"Tranquil Sea\" stance or \"Raging Waves\" stance. If the turn ends while still in the \"Surging Tides\" stance, a Tentacle is generated at the start of the next turn.\nTentacle Gathering: After Awakeners unleash Exalt, gain 1 stack of Tentacle Gathering, with a <BlueQuality:[Arg5]％> chance of gaining 1 extra stack. At turn end, each stack of Tentacle Gathering drives a Tentacle to attack the front-row enemy, then clears Tentacle Gathering stacks.\nTentacle Crit. Rate: <BlueQuality:[Arg6]%>.\nTentacle Crit. DMG: <BlueQuality:[Arg7]%>.\nTentacle Overflow: When the Permanent Tentacle count exceeds the limit, a Tentacle attacks 3 times, and increases Tentacle Limit by 1. Each time the effect triggers, the number of triggers needed to increase Tentacle Limit rises by 1."
  },
  SchoolConfig_4_SchoolBattleTips_2 = {
    Text = [[
Tentacle Stance: At the start of a turn, it is initially in the "Surging Tides" stance.
In the "Surging Tides" stance, you can click the Tentacle to switch to the "Tranquil Sea" stance or "Raging Waves" stance, each with a cooldown of 3 turns. If the turn ends while still in the "Surging Tides" stance, a Tentacle is generated at the start of the next turn.
Realm Mastery changed to "Divine Realm: Aequor Mastery," no longer possessing the Tentacle Gathering effect. Each point of Realm Mastery increases the Shield of "Divine Realm: Tranquil Sea" by 0.025% Max HP, and increases the Tentacle DMG of "Divine Realm: Raging Waves" by an additional 0.025%. If the team consists of purely Aequor and Chaos awakeners, the "Divine Realm: Aequor Mastery" effect doubles.
Tentacle Crit. Rate: <BlueQuality:[Arg3]%>.
Tentacle Crit. DMG: <BlueQuality:[Arg4]%>.
Tentacle Overflow: When the Permanent Tentacle count exceeds the limit, a Tentacle attacks 3 times, and increases Tentacle Limit by 1. Each time the effect triggers, the number of triggers needed to increase Tentacle Limit rises by 1.]]
  },
  SchoolConfig_4_SchoolBattleTips_3 = {
    Text = ": Tentacle Stance: At turn start, the active stance defaults to \"Surging Tides\" stance.\n: In the \"Surging Tides\" stance, click on Tentacles to switch to the \"Tranquil Sea\" stance or the \"Raging Waves\" stance, each with a 3-turn cooldown. If still in \"Surging Tides\" at turn end, generate 1 Tentacle at the start of the next turn.\n: When Realm Mastery changes to \"Divine Realm: Aequor Mastery,\" lose the \"Tentacle Gathering\" effect. Each point of Realm Mastery increases the shield of \"Divine Realm: Tranquil Sea\" by 0.025% of Max HP and additionally increases the Tentacle DMG of \"Divine Realm: Raging Waves\" by 0.025%. If the team consists of Aequor or Chaos Awakeners, the effect of \"Divine Realm: Realm Mastery\" is doubled.\n: Tentacle Crit. Rate: <BlueQuality:[Arg3]％>.\n: Tentacle Crit. Damage: <BlueQuality:[Arg4]％>.\n: Tentacle Overflow: When the number of Permanent Tentacles exceeds the limit, 1 Tentacle attacks 3 times and the Tentacle limit increases by 1. Each time this effect is triggered, the number of times required to increase the Tentacle limit rises by 1."
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
Tentacle Dominion: At the start of battle, generate 1 Tentacle. The Tentacle will automatically attack front-row enemies at the end of each turn. 
Tentacle Stance is set to the default "Surging Tides" stance at turn start. In Surging Tides stance, 1 Tentacle will be gained at turn end. You can switch the Tentacle Stance once per turn. Switching to "Tranquil Sea" immediately grants a shield equal to 8% of Max HP. Each time the Tentacle attacks, it gains a Shield equal to 0.2% of Max HP, but the Tentacle DMG for this turn is reduced to 50%. Switching to "Raging Waves" increases the Tentacle DMG for this turn to 125%. After dealing Active DMG, 1 Tentacle will attack the target enemy, dealing 50% of the Tentacle DMG, but at turn end, 1 Tentacle will be lost. 
Tentacle Gathering: After using Exalt, the Awakener gains 1 stack of Tentacle Gathering. At the end of each turn, for each stack of Tentacle Gathering, 1 Tentacle will attack front-row enemies, then the Tentacle Gathering is cleared. 
Tentacle Critical Hit: Tentacles can score critical hits. The initial Crit. Rate and Crit. DMG are 50% of the total Crit. Rate and Crit. DMG of all Awakeners entering the stage. For each Awakener in the stage that gains 1% Crit. Rate and Crit. DMG, the Tentacle's Crit. Rate and Crit. DMG increase by 0.25%. 
Aequor Mastery: For each point of Realm Mastery in the team, there is a 0.25% chance to gain an additional stack of Tentacle Gathering at turn end (chances exceeding 100% can result in multiple stacks). Switching to "Tranquil Sea" immediately grants a shield that is increased by 0.01% of Max HP, and the DMG from Tentacle attacks triggered by Active DMG in "Raging Waves" is increased by 0.02%. 
Pure Aequor: If the team consists only of Aequor Awakeners, the effects of Aequor Mastery are doubled, and the number of Tentacles generated at the start of battle is also doubled.]]
  }
})
return Text_SchoolConfig
