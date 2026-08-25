__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "All Awakeners generate 50% more Aliemus."
  },
  State_100291_Name = {Text = "Confess"},
  State_100292_Name = {Text = "Turn Start"},
  State_100293_Desc = {
    Text = "All Awakeners' Aliemus Generation -50%."
  },
  State_100293_Name = {
    Text = "Shadow Self"
  },
  State_100295_Name = {
    Text = "Damage Listener"
  },
  State_100296_Desc = {
    Text = "At each turn start, all Awakeners gain <Energy:5> Aliemus for each stack."
  },
  State_100296_Name = {
    Text = "The Dark \"Id\""
  },
  State_100297_Desc = {
    Text = "All Awakeners' Aliemus Generation +50%. Gain Shield equal to 20% of Max HP at turn end."
  },
  State_100297_Name = {
    Text = "Mind Barrier"
  },
  State_100298_Desc = {
    Text = "At turn start, lose 10% of current HP and gain [DescArg1] <PowerIconKeywords:STR>. All Awakeners' Aliemus Generation -50%."
  },
  State_100298_Name = {Text = "Crumble"},
  State_100299_Desc = {
    Text = "Exalt Count"
  },
  State_100299_Name = {
    Text = "Exalt Count"
  },
  State_100302_Name = {
    Text = "Exalt Listener"
  },
  State_100307_Desc = {
    Text = "Team Unique: After the wielder unleashes Exalt, they gain 1 stack of \"Collaboration\". The next Exalt of other Awakeners this turn can consume \"Collaboration\", increasing its Crit. Rate by <WeaponEffect_Num:[StateArg1]%>, and the Awakener consuming \"Collaboration\" gains Aliemus equal to <WeaponEffect_Num:[StateArg1]%> the wielder's Aliemus Regen."
  },
  State_100307_WeaponDesc = {
    Text = "After the wielder unleashes Exalt, they gain 1 stack of \"Collaboration.\" The next Exalt of other Awakeners within this turn can consume \"Collaboration,\" increasing its Crit. Rate by <WeaponEffect_Num:[StateArg1]%> and granting <WeaponEffect_Num:[DescArg1]> Aliemus to the Awakener who consumed \"Collaboration.\""
  },
  State_100326_Desc = {
    Text = "At each turn start, all Awakeners gain <Energy:3> Aliemus for each stack of this effect."
  },
  State_100326_Name = {
    Text = "<DarkEgo:The Dark \"Id\">"
  },
  State_100327_Desc = {
    Text = "All Awakeners' Aliemus Generation +50%. Gain Shield equal to 20% of Max HP at turn end."
  },
  State_100327_Name = {
    Text = "<MindWall:Mind Barrier>"
  },
  State_100328_Desc = {
    Text = "All Awakeners generate 50% more Aliemus."
  },
  State_100328_Name = {
    Text = "<TrueConfess:Confess>"
  },
  State_100329_Desc = {
    Text = "All Awakeners' Aliemus Generation -50%. At turn end, gain 1 stack of <DarkEgo:The Dark \"Id\">: At turn start, all Awakeners gain 3 Aliemus."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:Shadow Self>"
  },
  State_100330_Desc = {
    Text = "At turn start, lose 10% of current HP and gain [DescArg1] <PowerIconKeywords:STR>. All Awakeners' Aliemus Generation -50%."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Crumble>"
  },
  State_100527_Desc = {
    Text = "When Pickman triggers the \"Discover\" effect, provide the \"Inspiration!\" option: Consume 1 stack of \"Fantasia,\" choose all \"Discover\" effects, and gain 1 stack of \"Creativity.\""
  },
  State_100527_Name = {Text = "Fantasia"},
  State_100541_Desc = {
    Text = "When Pickman has 10 stacks of \"Creativity\" and uses Exalt, he consumes all \"Creativity\" stacks to gain one stack of \"Fantasia.\" This also grants 15 Aliemus to all teammates. His \"Creativity\" can stack up to 10 and is preserved between battles."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Creativity>"
  },
  State_100542_Desc = {
    Text = "When Pickman triggers the \"Discover\" effect, provide the \"Inspiration!\" option: Consume 1 stack of \"Fantasia,\" choose all \"Discover\" effects, and gain 1 stack of \"Creativity.\""
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Fantasia>"
  },
  State_100544_Name = {Text = "Sweet Slug"},
  State_100544_WeaponDesc = {
    Text = "The wielder's Shield and HP Recovery +6%. If the wielder's Realm Mastery exceeds 50, Shield and HP Recovery further +6%."
  },
  State_100545_Name = {Text = "Sweet Slug"},
  State_100545_WeaponDesc = {
    Text = "The wielder's Shield and HP Recovery +6%. If the wielder's Realm Mastery exceeds 50, Shield and HP Recovery further +6%."
  },
  State_100558_Desc = {
    Text = "The next Exalt by other Awakeners this turn increases the Crit. Rate by [StateArg1]%, and after use, gain [DescArg1] Aliemus."
  },
  State_100558_Name = {
    Text = "Collaboration"
  },
  State_100559_Desc = {
    Text = "Includes the following \"Astral Reign Relics\": Malignant Child, Rite of Spring, Iron Lock, Filigree Agate, Blessed Blood, Rusted Saw, Gilded Reverie, Bloody Pebble."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Painted Relic>"
  },
  State_100562_Desc = {
    Text = "The next [Layer] Command Cards played this turn cost 2 less Arithmetica."
  },
  State_100562_Name = {
    Text = "Truth in Delusion"
  },
  State_100564_Desc = {
    Text = "Includes the following \"Orisons\": Computation, Finesse, Berserk, Catalyst, Might, Bastion, Drain, Insight."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Painted Orison>"
  },
  State_100566_WeaponDesc = {
    Text = "Change Arithmetica Cost before playing"
  },
  State_100617_Desc = {
    Text = "At turn end, Tentacle Limit +1."
  },
  State_100617_Name = {
    Text = "Abyssal Obsession"
  },
  State_100619_Desc = {
    Text = "STR Reduction taken is lessened by 50%."
  },
  State_100619_Name = {
    Text = "Exhaustion Resistance"
  },
  State_100621_Desc = {
    Text = "Each stack reduces your Base DMG by 25% and can guide the direction of navigation afterward."
  },
  State_100621_Name = {
    Text = "Faint Candlelight"
  },
  State_100623_Desc = {
    Text = "Each stack reduces your Base DMG by 30%. After dealing active or Tentacle DMG, your Poison -[DescArg1]."
  },
  State_100623_Name = {
    Text = "Light of the Lost"
  },
  State_100639_Desc = {
    Text = "Tentacle DMG is temporarily reduced by 50%."
  },
  State_100639_Name = {
    Text = "Lost City of Lemuria"
  },
  State_100644_Desc = {
    Text = "Permanently reduce the target's STR and gain the same amount of STR."
  },
  State_100644_Name = {
    Text = "<TouquKeywords:Permanently Steal>"
  },
  State_100647_Desc = {
    Text = "Immune to all damage."
  },
  State_100647_Name = {
    Text = "Immune to all damage."
  },
  State_100694_Desc = {
    Text = "Each stack reduces your Base DMG by 30%. After dealing active or Tentacle DMG, reduce your Poison stacks."
  },
  State_100694_Name = {
    Text = "Light of the Lost"
  },
  State_116342_Desc = {
    Text = "Playing <ErosionColorInkKeywords:Dissoluted Paint> cards grants \"The Painter\" 1 stack of <DecayDye:Phantom Dye>."
  },
  State_116342_Name = {
    Text = "Twisted Palette"
  },
  State_116406_Name = {Text = "Advanced"},
  State_116407_Name = {
    Text = "Empty state"
  },
  State_116858_Desc = {
    Text = "This State uses a Vulnerable multiplier area, pretending to be an independent multiplier area.__「For development use only」"
  },
  State_116858_Name = {
    Text = "If possessing a certain state, damage will be doubled __「For Development Only」"
  },
  State_116859_Desc = {
    Text = "Gain Falter at the start of the next turn."
  },
  State_116859_Name = {
    Text = "Delayed Falter"
  },
  State_116958_Desc = {
    Text = "After playing a card, take damage equal to the stacks count."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Card Lock>"
  },
  State_117154_Desc = {
    Text = "This effect will only take effect on one Awakener in the team."
  },
  State_117154_Name = {
    Text = "<TeamUnique:Team Unique>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Before the wielder's Skill Card is played and at turn end, inflict <Damage:[Damage:StateArg1]> stacks of <PVPCorrosionKeywords:Sin Mark> on the enemy with highest HP and Shield."
  },
  State_117212_Name = {
    Text = "Twisted Knight Ballad"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:When the wielder's Skill Card is played and at turn end, inflict [StateArg1] <PVPfengsuoKeywords:Exalt Lock> on the enemy with the highest Aliemus."
  },
  State_117213_Name = {
    Text = "The Divus' Visage"
  },
  State_117346_Desc = {
    Text = "Pollux inflicts Bleed equal to [Layer]% of the DMG he dealt."
  },
  State_117346_Name = {Text = "Sin Mark"},
  State_117350_Name = {
    Text = "Lightbearer's Herald"
  },
  State_117355_Desc = {
    Text = "The next Pollux Command Card takes effect 2 times."
  },
  State_117355_Name = {
    Text = "Divine Revelation"
  },
  State_117357_Desc = {
    Text = "Team Unique: After resetting stock at \"D-Mark\" and \"Ashen Ruins\", the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_117357_WeaponDesc = {
    Text = "After resetting stock at \"D-Mark\" and \"Ashen Ruins\", the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_117358_Desc = {
    Text = "Each stack grants Pollux's damage a 1% Bleed effect."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Sin Mark>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:Max HP> is reduced by [Layer]. When triggered, take [Layer] Passive DMG, Permanent. When dispelled, target's Max HP will not regenerate."
  },
  State_117744_Name = {Text = "Sin Mark"},
  State_117745_Desc = {
    Text = "Each stack reduces the target's <MaxHPKeywords:Max HP>. When Sin Mark is triggered, target takes Passive DMG equal to the number of stacks. When dispelled, target's Max HP will not regenerate."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Sin Mark>"
  },
  State_117755_Desc = {
    Text = "Cannot perform any actions until turn end."
  },
  State_117755_Name = {Text = "Fainted"},
  State_117756_Desc = {
    Text = "Cannot perform any actions until turn end."
  },
  State_117756_Name = {Text = "Fainted"},
  State_117776_Desc = {
    Text = "In this turn, the next [Layer] Command Cards' Final DMG and Shield Generation +[StateArg1]％."
  },
  State_117776_Name = {Text = "Aflame"},
  State_117777_Desc = {
    Text = "Team Unique: The wielder's cards gain +<WeaponEffect_Num:[StateArg1]%> Base DMG and Crit. DMG. At the start of your turn and after using the wielder's Exalt, gain 1 stack of \"Alight\". When the wielder's Command Card is played, consume 1 stack to increase its Final DMG and Shield by <WeaponEffect_Num:[StateArg2]%>. During an Ultra Round, gain \"Ablaze\" instead (effect doubled)."
  },
  State_117777_WeaponDesc = {
    Text = "The wielder's cards gain +<WeaponEffect_Num:[StateArg1]%> Base DMG and Crit. DMG. At the start of your turn and after using Exalt, gain 1 stack of \"Alight\". When the wielder's Command Card is played, consume 1 stack to increase its Final DMG and Shield by <WeaponEffect_Num:[StateArg2]%>. During an Ultra Round, gain \"Ablaze\" instead (effect doubled)."
  },
  State_117778_Desc = {
    Text = "In this turn, the next [Layer] Command Cards' Final DMG and Shield Generation +[StateArg1]％."
  },
  State_117778_Name = {Text = "Alight"},
  State_117779_Desc = {
    Text = "Team Unique: In the Ultra Round: Gain 3 stacks of \"Alight\". When the wielder plays a Command Card, consume 1 stack to increase its Final DMG and Shield Generation by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117779_WeaponDesc = {
    Text = "In the Ultra Round: Gain 3 stacks of \"Alight\". When the wielder plays a Command Card, consume 1 stack to increase its Final DMG and Shield Generation by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "All of Pollux's Command Cards gain +50% \"Atonement by Pain\" effect. This effect lasts [Layer] turns."
  },
  State_117851_Name = {
    Text = "The Nightbreaker"
  },
  State_117853_Desc = {
    Text = "In this turn, the next [Layer] Pollux Command Cards receive: DMG +[DescArg1], Shield +[DescArg2], and Aliemus +10."
  },
  State_117853_Name = {
    Text = "Atonement by Pain"
  },
  State_117869_Desc = {
    Text = "Each time Exalt is unleashed, it increases the \"Call\" by 1 stack. For each stack of \"Call,\" gain [DescArg1] Strength, up to 5 stacks."
  },
  State_117869_Name = {
    Text = "Seafarer Priestess"
  },
  State_117870_Desc = {
    Text = "When this unit is killed, the killer recovers 20% of lost HP."
  },
  State_117870_Name = {Text = "Sashimi"},
  State_117875_Desc = {
    Text = "If there are empty spaces behind, lose 1 stack after the action and summon 1 \"Fry\" with the \"Sashimi\" state."
  },
  State_117875_Name = {
    Text = "Contract: Fish Frenzy"
  },
  State_117876_Desc = {
    Text = "The effects of <WeaknessIconKeywords:Weakness>, <FragileIconKeywords:Fragile>, and <HeavyInjuryKeywords:Blighten> are increased to 50%."
  },
  State_117876_Name = {
    Text = "Weakness & Fragile & Blighten+"
  },
  State_117880_Desc = {
    Text = "In this battle, \"Swarm Leap\" will trigger an additional time after this."
  },
  State_117880_Name = {
    Text = "School leap additional trigger"
  },
  State_117883_Desc = {
    Text = "At 5 stacks, immediately seal all Awakeners and change the intention to: \"Glory of Lemuria! +\"."
  },
  State_117883_Name = {Text = "Call"},
  State_117885_Desc = {
    Text = "When affected by the STR▼ effect, it will also impose an equal amount of STR▼ effect on the caster."
  },
  State_117885_Name = {
    Text = "Eye for an Eye"
  },
  State_117889_Desc = {
    Text = "Upon entering the battlefield, increase your Max HP by 10% and grant other allies [DescArg1] of <PowerIconKeywords:STR>, causing the HP increase and STR gain effect of <FishLeapWords:Power of Swarm> to trigger an additional time in this battle."
  },
  State_117889_Name = {
    Text = "Power of Swarm"
  },
  State_118112_Desc = {
    Text = "The maximum single hit damage received is [DescArg1] points, and it will be removed when HP is below 50%."
  },
  State_118112_Name = {
    Text = "Pain Threshold I"
  },
  State_118113_Desc = {
    Text = "After losing HP due to receiving Active DMG, gain Shield equal to 15% of the lost HP and <AlertIconKeywords:Temporary Alert> equal to 5% of the lost HP."
  },
  State_118113_Name = {Text = "Mollusca I"},
  State_118114_Desc = {
    Text = "After losing HP due to receiving Active DMG, gain Shield equal to 35% of the lost HP and <AlertIconKeywords: Temporary Alert> equal to 10% of lost HP."
  },
  State_118114_Name = {
    Text = "Mollusca III"
  },
  State_118115_Desc = {
    Text = "If there are empty spaces in front, lose 1 stack after the action and summon 1 \"Seafarer Excrescence\"."
  },
  State_118115_Name = {
    Text = "Contract: Seafarer Excrescence"
  },
  State_118116_Desc = {
    Text = "The maximum single hit damage received is [DescArg1] points, and it will be removed when HP is below 50%."
  },
  State_118116_Name = {
    Text = "Pain Threshold II"
  },
  State_118117_Desc = {
    Text = "The maximum single hit damage received is [DescArg1] points, and it will be removed when HP is below 50%."
  },
  State_118117_Name = {
    Text = "Pain Threshold III"
  },
  State_118118_Desc = {
    Text = "Gain 1 Tentacle with <TentacleInjurieIconKeywords:Tentacle DMG> equal to [TentaclePower:DescArg1] and 5 Tentacle Limit. Gain 1 Tentacle at turn end. Effects that reduce Strength are reduced by 50%."
  },
  State_118118_Name = {
    Text = "Tentacle Gathering"
  },
  State_118119_Desc = {
    Text = "After losing HP due to receiving Active DMG, gain Shield equal to 25% of the lost HP and <AlertIconKeywords: Temporary Alert> equal to 5% of lost HP."
  },
  State_118119_Name = {
    Text = "Mollusca II"
  },
  State_118319_Desc = {
    Text = "The maximum single hit damage received is [DescArg1] points, and it will be removed when HP is below 50%."
  },
  State_118319_Name = {
    Text = "Damage limit of the Abyssal Shield"
  },
  State_118320_Name = {
    Text = "Temporary exhaustion counter measure"
  },
  State_118321_Name = {
    Text = "Exhaustion Countermeasure Counting"
  },
  State_118322_Name = {
    Text = "Summoning markers"
  },
  State_118323_Desc = {
    Text = "Swarm Leap Triggered"
  },
  State_118323_Name = {
    Text = "School leap entry marker"
  },
  State_118324_Desc = {
    Text = "For every 1 Damage dealt, generate 1 Temporary Tentacle."
  },
  State_118324_Name = {
    Text = "Serpent Rain Ritual"
  },
  State_118325_Desc = {
    Text = "When dealing unblocked Damage, shuffle [DescArg1] Suffocation cards into the top of the Draw Pile"
  },
  State_118325_Name = {
    Text = "New World Serpent-head Trembling"
  },
  State_118656_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_118656_Name = {
    Text = "Parastizied Repeatedly"
  },
  State_118657_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_118657_Name = {
    Text = "Parasitized Again"
  },
  State_118659_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_118659_Name = {
    Text = "Parasitized"
  },
  State_118663_Name = {
    Text = "New World Serpent-head Intent Listening"
  },
  State_118669_Name = {
    Text = "New World Serpent-head Initialization"
  },
  State_118670_Desc = {
    Text = "Detecting for signs of drain countermeasure"
  },
  State_118670_Name = {
    Text = "Exhaustion Countermeasure Detection"
  },
  State_118671_Desc = {
    Text = "Detecting player behavior exhibiting drain"
  },
  State_118671_Name = {
    Text = "Exhaustion Countermeasure Monitoring"
  },
  State_118672_Name = {
    Text = "New World Serpent-head Intent Listening Cooldown"
  },
  State_118741_Name = {
    Text = "Clear temporary tentacles"
  },
  State_118743_Name = {
    Text = "Preparatory summon position requires summoning markers"
  },
  State_118759_Name = {
    Text = "Current permanent tentacle count of the monster"
  },
  State_118760_Name = {
    Text = "Permanent tentacle limit of the monster"
  },
  State_118762_Name = {
    Text = "First decay hint"
  },
  State_118763_Name = {
    Text = "First neurotoxin blood hint"
  },
  State_118764_Name = {
    Text = "First curse breath hint"
  },
  State_118766_Name = {
    Text = "Blue-ringed octopus BOSS intends to monitor"
  },
  State_118769_Name = {
    Text = "Silver Core Lantern Hint"
  },
  State_118771_Name = {
    Text = "First probe hint"
  },
  State_118772_Name = {
    Text = "First serpent rend hint"
  },
  State_118935_Name = {
    Text = "Monsters' murphy intends to eavesdrop"
  },
  State_118938_Desc = {
    Text = "Lady of the Depths has Roused, greatly increasing the Shield amount created!"
  },
  State_118938_Name = {
    Text = "Made into Being"
  },
  State_118943_Desc = {
    Text = "Damage taken during your turn is doubled. When you lose HP, you lose an equal amount of stacks. When stacks reach 0, permanently reduce the number of tentacles by 1 and reset stacks, with a minimum of 1 tentacle."
  },
  State_118943_Name = {
    Text = "Deipara's Sacrifice"
  },
  State_118973_Name = {
    Text = "Silent Defiance Management"
  },
  State_119051_Desc = {
    Text = "Triggered at turn end: Take this amount of Passive DMG and remove half the stacks, cannot be dispelled."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Sacrifice>"
  },
  State_119052_Desc = {
    Text = "Gain Sacrifice equal to [Layer]% Active DMG received."
  },
  State_119052_Name = {
    Text = "Birth Ritual"
  },
  State_119053_Desc = {
    Text = "Triggered at turn end: Take [Layer] Passive DMG and remove half the stacks, cannot be dispelled."
  },
  State_119053_Name = {Text = "Sacrifice"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After dealing Active DMG, inflict [StateArg1]% <PVPSacrificeKeyWords:Sacrifice> on the target."
  },
  State_119058_Name = {
    Text = "Uteri Somnia"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", all enemies will gain <PVPSacrificeKeyWords:Sacrifice> equal to [StateArg1]% Active DMG received this turn."
  },
  State_119059_Name = {
    Text = "Blue-Ringed Toxin"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" DMG +[Arg1]%, after any ally play \"Strike\", draw [StateArg3] cards, can trigger a maximum of [StateArg2] times per turn.  (currently triggered [DescArg1] times)."
  },
  State_119060_Name = {
    Text = "Doomsday Rampage"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: All allies' \"Strike\" DMG +[StateArg1]%."
  },
  State_119061_Name = {
    Text = "Light of Intellect"
  },
  State_119063_Desc = {
    Text = "At 5 stacks, change the intention to: \"Glory of Lemuria!\"."
  },
  State_119063_Name = {Text = "Call"},
  State_119075_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_119075_Name = {Text = "Not Roused"},
  State_119076_Desc = {
    Text = "If there are empty positions in the front row, lose 1 stack after acting and randomly summon 1 \"Lemurian Awakener\"."
  },
  State_119076_Name = {
    Text = "Contract: Lemuria"
  },
  State_119077_Desc = {
    Text = "When \"Call\" reaches 5 stacks, immediately seal all Awakeners."
  },
  State_119077_Name = {
    Text = "Miryam Rouse!"
  },
  State_119077_WeaponDesc = {
    Text = "At the start of the next turn, gain Shield equal to the amount of HP lost in the previous turn."
  },
  State_119080_Desc = {
    Text = "When unleashing \"Chaos Memories\" or \"Unforgotten Twilight\", the selected Posse takes effect 1 additional time."
  },
  State_119080_Name = {
    Text = "Ex Oblivione"
  },
  State_119082_Desc = {
    Text = "Each time an Awakener unleashes Exalt, their Base Aliemus +10."
  },
  State_119082_Name = {
    Text = "Aliemus Drain"
  },
  State_119083_Desc = {
    Text = "When an Command Card is taken from Ultra Space, its Arithmetica Cost -1."
  },
  State_119083_Name = {
    Text = "End of the Otherworld"
  },
  State_119084_Desc = {
    Text = "Each time you unleash Posse, the required Keyflare increases by 100."
  },
  State_119084_Name = {
    Text = "Silver Key Shockwave"
  },
  State_119085_Desc = {
    Text = "After using Crimson Furnace, transform 1 Embryo into a Scion of Purity, with a cooldown of 3 turns."
  },
  State_119085_Name = {
    Text = "Crimson Nurturing"
  },
  State_119086_Desc = {
    Text = "Breeding Power is on Cooldown, remaining [Layer] turns."
  },
  State_119086_Name = {
    Text = "Breeding Power CD"
  },
  State_119104_Desc = {
    Text = "Gain [DescArg1] stacks of \"Life Seal\" at turn start."
  },
  State_119104_Name = {
    Text = "Tidal Sacrament"
  },
  State_119105_Desc = {
    Text = "Lose all \"Life Seal\" stacks upon death. Restore 1% Max HP per stack and increase Tentacle DMG by 1%."
  },
  State_119105_Name = {Text = "Life Seal"},
  State_119106_Name = {
    Text = "Monsters' delusional murphy intends to eavesdrop"
  },
  State_119107_Name = {
    Text = "Management of God's Realm Order"
  },
  State_119108_Desc = {
    Text = "When losing HP, each stack inflicts Sacrifice of 1% of lost HP."
  },
  State_119108_Name = {
    Text = "Birth Ritual"
  },
  State_119109_Desc = {
    Text = "When taking damage from sources other than <SacrificeKeyWord:Sacrifice>, lose an equal amount of \"Divine Realm Order\" and gain a <SacrificeKeyWord:Sacrifice> equal to 50% of the damage. If the stacks are at 0, gain 1 stack of \"Life Seal\" and reset the stacks."
  },
  State_119109_Name = {
    Text = "Divine Realm's Order"
  },
  State_119132_Desc = {
    Text = "This turn, \"Strike\" DMG +[Layer]%."
  },
  State_119132_Name = {
    Text = "Strike Enhance"
  },
  State_119134_Name = {
    Text = "First delusional pioneer hint"
  },
  State_119359_Name = {
    Text = "Silver Key Ritual Count"
  },
  State_119362_Name = {
    Text = "Perform the Ritual"
  },
  State_119363_Name = {Text = "Own Card"},
  State_119364_Name = {
    Text = "Madness ritual count"
  },
  State_119365_Desc = {
    Text = "All Awakeners' Healing and Shield Generations are increased by 40%."
  },
  State_119365_Name = {Text = "Composure"},
  State_119366_Desc = {
    Text = "Return to hand after being discarded"
  },
  State_119366_Name = {
    Text = "Return to hand after being discarded"
  },
  State_119367_Name = {
    Text = "Life Ritual count"
  },
  State_119368_Desc = {
    Text = "Gain 500 Keyflare at each turn start."
  },
  State_119368_Name = {
    Text = "Clairvoyance"
  },
  State_119369_Desc = {
    Text = "All Awakeners Aliemus Generation +50%."
  },
  State_119369_Name = {Text = "Authority"},
  State_119370_Name = {Text = "Relic"},
  State_119373_Name = {
    Text = "The enemy is performing a sacrifice"
  },
  State_119567_Name = {
    Text = "Complete the Ritual"
  },
  State_119568_Desc = {
    Text = "Strike DMG +[Layer]."
  },
  State_119568_Name = {
    Text = "Strike Amp."
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Before \"Strike\", \"Skill\", and \"Exalt\", Temporary <StrongEffectKeywords:Amplification> +[StateArg1]. Only triggers once for each type of card per turn."
  },
  State_119583_Name = {
    Text = "We Will Meet Again"
  },
  State_119588_Name = {Text = "Caro CD"},
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Team Unique: After switching Tentacle Stances, using Crimson Furnace, or unleashing \"Annihilation,\" draw the wielder's Command Card ×1; each effect has a cooldown of 3 turns. After the Exploration, all Awakeners in the team gain +<WeaponEffect_Num:[StateArg1]%> Affinity."
  },
  State_119590_WeaponDesc = {
    Text = "After switching Tentacle Stances, using Crimson Furnace, or unleashing \"Annihilation,\" draw the wielder's Command Card ×1; each effect has a cooldown of 3 turns. After the Exploration, all Awakeners in the team gain +<WeaponEffect_Num:[StateArg1]%> Affinity."
  },
  State_119591_Name = {
    Text = "Deep Sea cd"
  },
  State_119741_Desc = {
    Text = "All Awakeners STR Generation -50%."
  },
  State_119741_Name = {
    Text = "Curse: Decline"
  },
  State_119742_Desc = {
    Text = "At each turn start, heal 15% of lost HP."
  },
  State_119742_Name = {
    Text = "Bless: Eternity"
  },
  State_119743_Desc = {
    Text = "All Awakeners HP Recovery -50%."
  },
  State_119743_Name = {
    Text = "Curse: Death"
  },
  State_119744_Desc = {
    Text = "Curse: Death is inactive for 1 turn."
  },
  State_119744_Name = {
    Text = "Immune Curse: Death"
  },
  State_119746_Name = {
    Text = "Number of times Abyssal Lock lost"
  },
  State_119747_Desc = {
    Text = "Will not take DMG for 1 turn."
  },
  State_119747_Name = {
    Text = "Silver Key, Guide Us Forward"
  },
  State_119748_Desc = {
    Text = "Curse: Decline is inactive for 1 turn."
  },
  State_119748_Name = {
    Text = "Immune Curse: Decline"
  },
  State_119749_Desc = {
    Text = "At the start of the Keeper's turn, apply 1 stack of <SlowIconKeywords:Stagnation> to their hand equal to the number of <Abyssallock:Dream Chain> stacks."
  },
  State_119749_Name = {
    Text = "Dream Chain"
  },
  State_119750_Name = {
    Text = "The intention of the heavenly curtain listens"
  },
  State_119751_Name = {
    Text = "The curtain reenacts the release mark"
  },
  State_119752_Desc = {
    Text = "Gain 5% of Max HP as <PowerIconKeywords:STR> at each turn start, with a Temporary Crit. Rate of +25%."
  },
  State_119752_Name = {
    Text = "Bless: Might"
  },
  State_119753_Name = {
    Text = "Dim tidal count of the abyss"
  },
  State_119754_Desc = {
    Text = "All Awakeners Aliemus Generation -50%."
  },
  State_119754_Name = {
    Text = "Curse: Folly"
  },
  State_119755_Name = {
    Text = "Death count"
  },
  State_119756_Desc = {
    Text = "The Curse: Folly is inactive for 1 turn."
  },
  State_119756_Name = {
    Text = "Immune Curse: Folly"
  },
  State_119757_Desc = {
    Text = "At the start of the Keeper's turn, apply 1 stack of <SlowIconKeywords:Stagnation> to their hand equal to the number of <Abyssallock:Dream Chain> stacks. Each time \"Paradise Veil\" is broken by Active DMG, reduce 1 stack and Fully Seal the attacking Awakener for 1 turn."
  },
  State_119757_Name = {
    Text = "Dream Chain"
  },
  State_119758_Desc = {
    Text = "At each turn start, all Awakeners gain 10 Aliemus."
  },
  State_119758_Name = {
    Text = "Bless: Wisdom"
  },
  State_119760_Name = {
    Text = "Death monitoring"
  },
  State_119789_Desc = {
    Text = "At turn start, restore [Layer] HP."
  },
  State_119789_Name = {
    Text = "Blossom of Sludge"
  },
  State_119837_Desc = {
    Text = "The next Command Card Ramona plays this turn takes effect 2 times."
  },
  State_119837_Name = {
    Text = "Hands Rejoined"
  },
  State_119847_Desc = {
    Text = "Change the card's Arithmetica before playing. __ \"For Development Only\""
  },
  State_119847_Name = {
    Text = "Change the card's Arithmetica before playing __ \"For Development Only\""
  },
  State_119928_Desc = {
    Text = "After playing, activates [StateArg1] more times, <DepleteIconKeywords:Exhaust>. <RippleKeywords:Aftershock>: Draw 2 cards."
  },
  State_119928_Name = {
    Text = "<Rune_20:Abyss Echo>"
  },
  State_119958_Desc = {
    Text = "Immediately summon a random \"Swarm\" after death, reducing its \"Migrating Tides\" by 1 stack."
  },
  State_119958_Name = {
    Text = "Migrating Tides"
  },
  State_119959_Desc = {
    Text = "Immediately summon a random \"Brood\" after death, reducing its \"Everlasting Cycle\" by 1 stack."
  },
  State_119959_Name = {
    Text = "Everlasting Cycle"
  },
  State_119960_Desc = {
    Text = "All damage dealt -35%. This state is dispelled when your current HP is above 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Decay>"
  },
  State_120215_Desc = {
    Text = "At the start of the Keeper's turn, apply 1 stack of <SlowIconKeywords:Stagnation> to their hand equal to the number of <Abyssallock:Dream Chain> stacks. Each time \"Paradise Veil\" is broken by Active DMG, reduce 1 stack and Fully Seal the attacking Awakener for 1 turn."
  },
  State_120215_Name = {
    Text = "Abyssal Lock"
  },
  State_120216_Desc = {
    Text = "At the start of the Keeper's turn, apply 1 stack of <SlowIconKeywords:Stagnation> to their hand equal to the number of <Abyssallock:Abyssal Lock> stacks."
  },
  State_120216_Name = {
    Text = "Abyssal Lock"
  },
  State_120218_Name = {
    Text = "Choose Murphy support at the end of the turn"
  },
  State_120222_Name = {
    Text = "Turn Begin: Select Reverse Curse"
  },
  State_120293_Desc = {
    Text = "Recover [Layer] HP at turn end."
  },
  State_120293_Name = {
    Text = "Outcast's Anguish"
  },
  State_120312_Desc = {
    Text = "Immediately summon a random \"Tyrant\" after death, reducing its \"Migrating Tides\" by 1 stack."
  },
  State_120312_Name = {
    Text = "Migrating Tides"
  },
  State_120318_Desc = {
    Text = "For each stack, DMG received this turn +1%."
  },
  State_120318_Name = {
    Text = "<DwmofeiKeywords1:Aetherial Loop>"
  },
  State_120320_Desc = {
    Text = "Each stack increases the next \"Princess of Delusions\" applied \"Birth Ritual\" by 20%, stacking up to 5 stacks. After reaching 5 stacks, the next \"Princess of Delusions\" doubles the damage count."
  },
  State_120320_Name = {Text = "Life Seal"},
  State_120321_Desc = {
    Text = "Each stack inflicts \"Sacrifice\" stacks equal to 1% of DMG received. Stacks up to 75. Removed at turn end."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Birth Ritual>"
  },
  State_120322_Desc = {
    Text = [[
Team Unique: Hand Limit +2. Effects of the same type cannot stack. The wielder's Keyflare Regen and Exalt's Final DMG & Shield Generation +<WeaponEffect_Num:[StateArg1]%>.
Switching to "Tranquil Sea" stance increases the wielder's Aliemus by <WeaponEffect_Num:[StateArg2]>, 3 turns cooldown.
Switching to "Raging Waves" stance inflicts <WeaponEffect_Num:[StateArg3]> stacks of <DwmofeiKeywords:Birth Ritual> on all enemies, 3 turns cooldown.]]
  },
  State_120322_WeaponDesc = {
    Text = [[
Hand Limit +2. Effects of the same type cannot stack. The wielder's Keyflare Regen and Exalt's Final DMG & Shield Generation +<WeaponEffect_Num:[StateArg1]%>.
Switching to "Tranquil Sea" stance increases the wielder's Aliemus by <WeaponEffect_Num:[StateArg2]>, 3 turns cooldown.
Switching to "Raging Waves" stance inflicts <WeaponEffect_Num:[StateArg3]> stacks of <DwmofeiKeywords:Birth Ritual> on all enemies, 3 turns cooldown.]]
  },
  State_120324_Desc = {
    Text = "Suffer [Layer]% Sacrifice when taking DMG, removed at turn end, stacking up to 75 stacks."
  },
  State_120324_Name = {
    Text = "Birth Ritual"
  },
  State_120350_Desc = {Text = "—"},
  State_120350_WeaponDesc = {Text = "—"},
  State_120351_Desc = {
    Text = "[Layer] turns until \"Divine Realm: Tranquil Sea\" is available"
  },
  State_120351_Name = {
    Text = "Divine Realm: Tranquil Sea CD"
  },
  State_120352_Desc = {Text = "—"},
  State_120352_WeaponDesc = {Text = "—"},
  State_120353_Desc = {Text = "—"},
  State_120354_Desc = {
    Text = "[Layer] turns until \"Divine Realm: Raging Waves\" is available"
  },
  State_120354_Name = {
    Text = "Divine Realm: Raging Waves CD"
  },
  State_120357_Desc = {Text = "—"},
  State_120357_WeaponDesc = {Text = "—"},
  State_120362_Desc = {
    Text = "When taking DMG from sources other than <SacrificeKeyWord:Sacrifice>, gain 50% of the Damage as <SacrificeKeyWord:Sacrifice>."
  },
  State_120362_Name = {
    Text = "General monster sacrifice management"
  },
  State_120363_Desc = {
    Text = "Take [Layer] DMG at turn end and reduce Sacrifice stacks by 50%."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_120364_Desc = {
    Text = "Summon \"Seafarer Guard\" upon your death."
  },
  State_120364_Name = {
    Text = "Eternal Faith"
  },
  State_120401_Desc = {
    Text = "Arithmetica Cost -[StateArg5]. Draw [StateArg4] cards after playing it."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Mythag Insignia>"
  },
  State_120450_Name = {
    Text = "Blue-ringed octopus records player’s life"
  },
  State_120462_Desc = {
    Text = "Play it, then this card is permanently removed from the deck for this exploration."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Destroy>"
  },
  State_120900_Name = {
    Text = "Prepare to summon the \"Lemuria Awakener\" count"
  },
  State_120907_Desc = {
    Text = "If a Tentacle attack is blocked, inflict an equal amount of <IntoxicationIconKeywords:Poison>."
  },
  State_120907_Name = {
    Text = "Undercurrent"
  },
  State_120908_Desc = {
    Text = "If a Tentacle attack is blocked, inflict an equal amount of <IntoxicationIconKeywords:Poison>."
  },
  State_120908_Name = {
    Text = "Undercurrent"
  },
  State_120910_Desc = {
    Text = "Arithmetica Cost +[StateArg5]. Draw [StateArg4] cards after playing it."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Mythag Insignia>"
  },
  State_120924_Desc = {
    Text = "Gain Fortress at the start of the next turn."
  },
  State_120924_Name = {
    Text = "Delay Fortress"
  },
  State_120929_Desc = {
    Text = "The card retains, but after being played, it will remove the Pollution and summon 1 \"Seafarer Excrescence\". If there is no space to summon, it will gain 1 stack of \"Prepare Summon: Seafarer Excrescence\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Seafarer Curse>"
  },
  State_120930_Desc = {
    Text = "If there is free space, lose 1 stack after the action and summon 1 \"Seafarer Excrescence.\""
  },
  State_120930_Name = {
    Text = "Contract: Seafarer Excrescence"
  },
  State_120934_Desc = {
    Text = "Each time taking Critical Hit, gain 3% <Baojidikang:Temporary Crit. Resistance>. At each turn start, attach \" <SeastriderCurse:Polluted:Seafarer Curse>\" to 2 Cards."
  },
  State_120934_Name = {
    Text = "Deep Sea Rites"
  },
  State_120941_Desc = {
    Text = "Amplifies the enemy's skills. Enemy loses 1 stack upon taking DMG."
  },
  State_120941_Name = {Text = "Blood Oath"},
  State_121006_Desc = {
    Text = "Team Unique: The wielder's Keyflare Regen, Exalt Final DMG & Shield +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "The wielder's Keyflare Regen, Exalt Final DMG & Shield +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Divine Fetus Protection"
  },
  State_121015_Desc = {
    Text = "Shields will not be cleared at turn start. When you have a shield, you have 50 stacks of <ReinforcePVEKeywords:Fortress>, and <ReinforcePVEKeywords:Fortress> is removed when the shield is broken."
  },
  State_121015_Name = {
    Text = "Divine Fetus Protection"
  },
  State_121151_Desc = {
    Text = "The card retains, but after being played, it will remove the Pollution and summon 1 \"Seafarer Excrescence\". If there is no space to summon, it will gain 1 stack of \"Prepare Summon: Seafarer Excrescence\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Seafarer Curse>"
  },
  State_121210_Name = {
    Text = "Grant all enemies a negative <PVPWonderfulEffectKeywords:Marvelous Effect>, effective 2 times"
  },
  State_121211_Name = {
    Text = "Draw 2 cards, gaining 2 Arithmetica"
  },
  State_121212_Name = {
    Text = "Grant all allies a positive <PVPWonderfulEffectKeywords:Marvelous Effect>, effective 2 times"
  },
  State_121213_Desc = {
    Text = "Immune to all damage."
  },
  State_121213_Name = {
    Text = "Immune to all damage."
  },
  State_121231_Desc = {
    Text = "Each stack grants the next \"Princess of Delusions\" +20% \"Birth Ritual\", up to 5 stacks, at which point the next \"Princess of Delusions\" DMG count doubles."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Life Seal>"
  },
  State_121365_Desc = {
    Text = "Take additional [Layer]% Tentacle DMG."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Retain>: At each turn start, gain 500 Keyflare"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Retain>: All Awakeners' HP Recovery and Shield Generation +40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Retain>: All Awakeners' Aliemus Generation +50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Aftershock>: Draw 1 card and gain [DescArg1] Temporary <PowerIconKeywords:STR>"
  },
  State_121734_Desc = {
    Text = "For each Command Card played, discard one Card with the lowest Arithmetica Cost of the Awakener."
  },
  State_121734_Name = {
    Text = "Flow of Madness"
  },
  State_121735_Desc = {
    Text = "All Command Cards Arithmetica Cost increases by 1. At the end of every 3 turns, add 1 \"Gradually Petrify\" to your hand."
  },
  State_121735_Name = {
    Text = "Flow of Sorrow"
  },
  State_121736_Desc = {
    Text = "At turn end, restore 10% lost HP, remove debuffs from self and buffs from your team."
  },
  State_121736_Name = {
    Text = "Flow of Birth"
  },
  State_121737_Desc = {
    Text = "At the start of the battle, gain 15 stacks of \"Temporary Barrier.\" At turn end, gain 15 stacks of \"Temporary Barrier\" and apply \"Temporary Melt\" to 10 random cards."
  },
  State_121737_Name = {
    Text = "Flow of Scathe"
  },
  State_121738_Desc = {
    Text = "The STR Generation of Awakeners -75%. Whenever HP is lost, gain [DescArg1] Shield and 1 stack of Temporary Fortress."
  },
  State_121738_Name = {
    Text = "Flow of Heresy"
  },
  State_121739_Desc = {
    Text = "All Awakeners' Aliemus Limit is increased by 50%. At the end of each turn, all Awakeners lose 10 Aliemus and restore 3% of their Max HP."
  },
  State_121739_Name = {
    Text = "Flow of Fear"
  },
  State_121740_Desc = {
    Text = "Gain 2 stacks of \"Temporary Chains of Resentment\" at the start of battle and at the end of each turn."
  },
  State_121740_Name = {
    Text = "Flow of Deceit"
  },
  State_121797_Desc = {
    Text = "Each stack reduces the DMG, Healing, and Shield of all Exalt and Skill cards during this fight by 10%. Up to 2 stacks. Cannot dispel."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Spellbound>"
  },
  State_121798_Desc = {
    Text = "\"Command Card,\" \"Exalt\" effects related to DMG, Healing and Shield -[DescArg1]%, cannot be dispelled. Maximum 2 layers."
  },
  State_121798_Name = {Text = "Spellbound"},
  State_121799_Name = {
    Text = "Chapter Four: Lemuria Support Card"
  },
  State_121850_Desc = {
    Text = "Tentacle DMG -80%"
  },
  State_121850_Name = {
    Text = "Goliath: Support"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Aftershock>: Draw 2 cards"
  },
  State_121878_Name = {
    Text = "First Selection of the Reverse Curse Narrative"
  },
  State_122428_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_122428_Name = {Text = "Not Roused"},
  State_122431_Desc = {
    Text = "When Mouchette deals unblocked DMG, gain 2 stacks of <Monster_Fervor:Temporary Fervor>."
  },
  State_122431_Name = {
    Text = "Mist Realm Vestige"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Equip to gain 3 stacks of <PVPReciprocalKeywords:Countdown Moment>."
  },
  State_122441_Name = {
    Text = "New Year Countdown"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Equip to gain <Block:[Block:StateArg1]> Shield and <Energy:[Energy:StateArg1]> Aliemus. At the end of turn, this Wheel of Destiny is automatically unequipped. Next time the Draw Pile is reshuffled, place this WoD into the Draw Pile,and the Aliemus and Shield gained upon equipping \"Dear Papa Noel\" +[StateArg2]."
  },
  State_122442_Name = {
    Text = "Dear Papa Noel"
  },
  State_122443_Desc = {
    Text = "At turn start, stacks count - 1. Once the stacks are exhausted, dispel debuffs from self and gain 100 Aliemus, then regain 3 stacks of Countdown. Changing the Wheel of Destiny will remove the stacks."
  },
  State_122443_Name = {
    Text = "New Year Countdown"
  },
  State_122596_Desc = {
    Text = "Cannot play cards, cannot unleash Exalt."
  },
  State_122596_Name = {
    Text = "<ExclamationPointColour:Sealed>"
  },
  State_122636_Desc = {
    Text = "The first \"Skill\" played each turn has its DMG, Healing, and Shield +[StateArg1]%."
  },
  State_122636_Name = {
    Text = "Crimson Brooch"
  },
  State_122650_Desc = {
    Text = "Relic <OrangeQuality:Arcane Gloves> added this card."
  },
  State_122650_Name = {
    Text = "Strange Card"
  },
  State_122654_Name = {
    Text = "At the start of each turn and after actions end, it will attempt to reset the empty player's deck, if it's not empty, it will not reset.__「For development use only」"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Reunion's Wish>"
  },
  State_122707_Desc = {
    Text = "Considered as the last \"Skill\" played in this turn, with Arithmetica Cost -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Reunion's Wish>"
  },
  State_123109_Desc = {
    Text = "Team Unique: Your first purchase of an \"Orison\" in the \"D-Mark\" store or your first purchase of a discounted item in the \"Ashen Ruins\" has a <WeaponEffect_Num:[StateArg1]%> chance to cost 0 Black Sigils. This can trigger only once per Exploration."
  },
  State_123109_WeaponDesc = {
    Text = "Your first purchase of an \"Orison\" in the \"D-Mark\" store or your first purchase of a discounted item in the \"Ashen Ruins\" has a 70/80/90/100% chance to cost 0 Black Sigils. This can trigger only once per Exploration."
  },
  State_123177_Desc = {
    Text = "Clears at turn start. After reaching 10 stacks, the next time a card is played, Mouchette immediately acts, removing \"Temporary Fervor\" and adding the intention \"Mortal Blast.\""
  },
  State_123177_Name = {
    Text = "Temporary Fervor"
  },
  State_123178_Desc = {
    Text = "The healing effect of <Guaiwusiwangdikang:Death Resistance> is increased by 5 times. For each card played by the enemy, gain 1 stack of <Monster_Fervor:Temporary Fervor>."
  },
  State_123178_Name = {
    Text = "Grumpy Morning"
  },
  State_123243_Desc = {
    Text = "Remove all stacks of this state when killing an enemy. Gain 30 Aliemus for each stack removed, up to a maximum of 2 stacks."
  },
  State_123243_Name = {Text = "Vortex"},
  State_123246_Desc = {
    Text = "Remove all stacks of this state when killing an enemy. Gain 30 Aliemus for each stack removed, up to a maximum of 2 stacks."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Vortex>"
  },
  State_123294_Desc = {
    Text = "This turn, [DescArg1] cards have been drawn through \"Strike\"."
  },
  State_123294_Name = {Text = "Rampagne"},
  State_123507_Desc = {
    Text = "Team Unique: At the start of exploration, add 1 card \"Countdown Moment: 5\" to the deck. \"Countdown Moment: 5\": Draw 1 card after played, shuffle the next \"Countdown Moment\" into the Discard Pile, <DestructionKeywords:Destroy>. \"Countdown Moment: 0\": Draw 3 cards, gain 3 Arithmetica, and have a <WeaponEffect_Num:[StateArg1]%> chance to shuffle \"Countdown Moment: 5\" into the Discard Pile, Retain, Destroy."
  },
  State_123507_WeaponDesc = {
    Text = "At the start of exploration, add 1 card \"Countdown Moment: 5\" to the deck. \"Countdown Moment: 5\": Draw 1 card after played, shuffle the next \"Countdown Moment\" into the Discard Pile, <DestructionKeywords:Destroy>. \"Countdown Moment: 0\": Draw 3 cards, gain 3 Arithmetica, and have a <WeaponEffect_Num:[StateArg1]%> chance to shuffle \"Countdown Moment: 5\" into the Discard Pile, Retain, Destroy."
  },
  State_123520_Desc = {
    Text = "Team Unique: After the first Posse release in each turn, there is a <WeaponEffect_Num:[StateArg1]>% chance to draw 1 \"Strike\" of the wielder's."
  },
  State_123520_WeaponDesc = {
    Text = "After the first release of Posse each turn, there is a <WeaponEffect_Num:[StateArg1]>% chance to draw 1 \"Strike\" of the wielder's."
  },
  State_123521_Desc = {
    Text = "Team Unique: The wielder's Exalt and Pursuit Base DMG +<WeaponEffect_Num:[StateArg1]%>. After playing any Awakener's \"Strike\" this turn, the wielder's \"Strike\" DMG temporarily +<WeaponEffect_Num:[StateArg2]%> of the wielder's ATK. This effect triggers up to 8 times per turn."
  },
  State_123521_WeaponDesc = {
    Text = "The wielder's Exalt and Pursuit Base DMG +<WeaponEffect_Num:[StateArg1]%>. After playing any Awakener's \"Strike\" this turn, the wielder's \"Strike\" DMG temporarily +<WeaponEffect_Num:[DescArg2]>. This effect triggers up to 8 times per turn."
  },
  State_123810_Desc = {
    Text = "Replace the enemy's current intention with \"Unable to Act\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Fainted>"
  },
  State_123812_Desc = {
    Text = "At turn end, Arithmetica Cost decreases."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Prepare>"
  },
  State_123994_Desc = {
    Text = "Unable to Act."
  },
  State_123994_Name = {
    Text = "Quality Nap"
  },
  State_124010_Desc = {
    Text = "At the start of next turn, gain [Layer] Arithmetica."
  },
  State_124010_Name = {
    Text = "Delayed Arithmetica"
  },
  State_124024_Desc = {
    Text = "This turn, [Layer] \"Strike\" cards have been played, triggering [DescArg1] \"Dramatic Encounter\" times."
  },
  State_124024_Name = {
    Text = "Dramatic Encounter"
  },
  State_124034_Desc = {
    Text = "All Awakeners' \"Strike\" DMG +[StateArg1] for [Layer] turns."
  },
  State_124034_Name = {
    Text = "Shining☆Tornado"
  },
  State_124037_Desc = {
    Text = "Mouchette's hits count +1, all Awakeners' \"Strike\" DMG +[StateArg1] for [Layer] turns."
  },
  State_124037_Name = {
    Text = "Shining☆Tornado"
  },
  State_124107_Desc = {
    Text = "Upon the death of \"Starborne Sprout\", become immune to all DMG and Rouse, doubling Max HP and gaining extra Max HP equal to remaining HP. Dispel all debuffs on self."
  },
  State_124107_Name = {Text = "Not roused"},
  State_124108_Name = {
    Text = "Voices from Beyond Count"
  },
  State_124109_Desc = {
    Text = "The <RetaliateIconKeywords:Counter> gained by this unit additionally enjoys a 5% <PowerIconKeywords:STR> bonus. After losing [DescArg1] HP in a single turn, swap positions with \"The Singer\""
  },
  State_124109_Name = {
    Text = "Secondary Swaddle"
  },
  State_124111_Desc = {
    Text = "Death Resistance HP Recovery is increased to 25%. For each Command Card played by the enemy, temporarily <TouquKeywords:Steal> [DescArg1] <PowerIconKeywords:STR>."
  },
  State_124111_Name = {
    Text = "Boundless Starlight"
  },
  State_124112_Desc = {
    Text = "Upon the death of \"The Singer,\" become immune to all DMG and Rouse, doubling Max HP and gaining extra Max HP equal to remaining HP."
  },
  State_124112_Name = {Text = "Not roused"},
  State_124113_Desc = {
    Text = "Opponent will not discard hand cards at turn end. At the end of the turn, inflict 2 stacks of <FragileIconKeywords:Fragile>, <WeaknessIconKeywords:Weakness>, <HeavyInjuryKeywords:Blighten>, and <VulnerabilityIconKeywords:Vulnerable> state in order."
  },
  State_124113_Name = {
    Text = "Voices from Beyond"
  },
  State_124115_Desc = {
    Text = "The effects of <FragileIconKeywords:Fragile> and <WeaknessIconKeywords:Weakness> are increased to 50%. After playing [DescArg1] <SlowIconKeywords:Stagnation> cards, swap positions with \"Starborne Sprout\"."
  },
  State_124115_Name = {
    Text = "Planetary Traveler"
  },
  State_124121_Name = {
    Text = "Planetary Traveler Count"
  },
  State_124122_Name = {
    Text = "Planetary Traveler Player Listener"
  },
  State_124190_Desc = {
    Text = "The <RetaliateIconKeywords:Counter> gained by this unit enjoys an additional 5% <PowerIconKeywords:STR> bonus."
  },
  State_124190_Name = {
    Text = "Secondary swaddle"
  },
  State_124193_Name = {
    Text = "The healing effect of Death Resistance is increased to 25%."
  },
  State_124198_Desc = {
    Text = "The effects of <FragileIconKeywords:Fragile> and <WeaknessIconKeywords:Weakness> are increased to 50%."
  },
  State_124198_Name = {
    Text = "Planetary traveler"
  },
  State_124277_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124277_Name = {
    Text = "Print Value 2"
  },
  State_124278_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124278_Name = {
    Text = "Print Value 4"
  },
  State_124279_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124279_Name = {
    Text = "Print Value 5"
  },
  State_124280_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124280_Name = {
    Text = "Print Value 1"
  },
  State_124282_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124282_Name = {
    Text = "Print Value 7"
  },
  State_124283_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124283_Name = {
    Text = "Print Value 8"
  },
  State_124284_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124284_Name = {
    Text = "Print Value 9"
  },
  State_124285_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124285_Name = {
    Text = "Print Value 10"
  },
  State_124286_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124286_Name = {
    Text = "Print Value 6"
  },
  State_124287_Desc = {
    Text = "Visualization of intermediate values in the execution process."
  },
  State_124287_Name = {
    Text = "Print Value 3"
  },
  State_124736_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124736_Name = {
    Text = "Listener Test 1"
  },
  State_124747_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124747_Name = {
    Text = "Listener Test 2"
  },
  State_124748_Desc = {
    Text = "When the enemy plays cards with <BurningKeywords:Burn>, gain 1 stack of <MonsterExFlameKeywords:Combust>, but temporarily lose [DescArg1] <PowerIconKeywords:STR>."
  },
  State_124748_Name = {
    Text = "Everburning Flame"
  },
  State_124752_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124752_Name = {
    Text = "Listener Test 3"
  },
  State_124753_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124753_Name = {
    Text = "Listener Test 4"
  },
  State_124754_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124754_Name = {
    Text = "Listener Test 5"
  },
  State_124765_Desc = {
    Text = "Crit. Rate increased by [Layer]%."
  },
  State_124765_Name = {Text = "Crit. Rate"},
  State_124766_Desc = {
    Text = "Crit. Rate increased by [Layer]% in this battle."
  },
  State_124766_Name = {Text = "Crit. rate"},
  State_124766_WeaponDesc = {
    Text = "Critical rate increased by [Layer]% in this battle."
  },
  State_124767_Desc = {
    Text = "Crit. DMG increased by [Layer]%."
  },
  State_124767_Name = {Text = "Crit. DMG"},
  State_124811_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124811_Name = {
    Text = "Listener Test 8"
  },
  State_124812_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124812_Name = {
    Text = "Listener Test 7"
  },
  State_124813_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124813_Name = {
    Text = "Listener Test 6"
  },
  State_124826_Desc = {
    Text = "Verify whether parameter 3 of the BEAttachPostAction interface correctly filters or triggers the corresponding trigger."
  },
  State_124826_Name = {
    Text = "Listener Test 9"
  },
  State_124843_Desc = {
    Text = "Verify the listeners of the triggers BSTAfterAttachPostAction and BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Listener Test 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After the wielder plays a skill card, draw [StateArg1] cards, prioritizing cards from other Awakeners. The effect can activate only once per turn."
  },
  State_124886_Name = {
    Text = "Suggested Translation"
  },
  State_124888_Desc = {
    Text = "Transforms into a random enemy \"Skill\" with -1 cost after play."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Prophecy>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", make the next [StateArg1] played \"Skill\" activate 2 times."
  },
  State_124890_Name = {
    Text = "Suggested Translation"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Prophecy>"
  },
  State_124916_Desc = {
    Text = "Lose [DescArg1] HP at turn end. Cannot be dispelled."
  },
  State_124916_Name = {
    Text = "Destined Death"
  },
  State_124917_Desc = {
    Text = "Lose HP equal to its stacks at turn end. Cannot be dispelled."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Destined Death>"
  },
  State_124992_Desc = {
    Text = "Next [DescArg1] \"Skill\" cards take effect 1 additional time."
  },
  State_124992_Name = {Text = "Transcend"},
  State_124993_Desc = {
    Text = "Active DMG dealt or taken is converted into equal <PVPDestinedDeathKeyWords: Destined Death>. Cannot be dispelled."
  },
  State_124993_Name = {
    Text = "Eternal Dimension"
  },
  State_124997_Desc = {
    Text = "DMG dealt is applied as an equal amount of <PVPDestinedDeathKeyWords:Destined Death>; removed at turn end. Cannot be dispelled."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Eternal Dimension>"
  },
  State_125002_Name = {
    Text = "State@General Player Discard Phase Shield Value Listener"
  },
  State_125003_Name = {
    Text = "Shield Value"
  },
  State_125004_Name = {
    Text = "State@General Apply Player Shield Count"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", apply [Arg1] stacks of <PVPLostSoulKeyWords:Spellbound> to the enemy with the highest HP and Shield."
  },
  State_125472_Name = {
    Text = "Magnolia's Lure"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After other allies use \"Exalt\", reduce Arithmetica Cost of the wielder's \"Skill\" in hand by [StateArg1]."
  },
  State_125486_Name = {
    Text = "Vain Regrets"
  },
  State_125925_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_125925_Name = {Text = "Not Roused"},
  State_125926_Name = {
    Text = "State@Monster Tawil Switch Intent Player Listener"
  },
  State_125927_Desc = {
    Text = "After playing [DescArg1] Command Cards, switch the intention to \"Six Wings\"."
  },
  State_125927_Name = {Text = "Four Wings"},
  State_125928_Desc = {
    Text = "After playing a Command Card, seal the corresponding Awakener's Exalt and all Command Cards for 2 turns."
  },
  State_125928_Name = {
    Text = "Pinions of Time"
  },
  State_125929_Desc = {
    Text = "After taking [DescArg1] DMG within a single turn, gain 70 stacks of Temporary <ReinforceColour:Fortress> and 1 stack of <ResentChainsKeywords:Chains of Resentment>."
  },
  State_125929_Name = {
    Text = "Nonexistent Existence"
  },
  State_125933_Desc = {
    Text = "After playing [DescArg1] Command Cards, switch the intention to \"Four Wings\"."
  },
  State_125933_Name = {Text = "Twin Wings"},
  State_125934_Desc = {
    Text = "When consuming Arithmetica, the Keyflare gained is reduced by 50%. After Tawil deals unblocked DMG, put 1 \"<DerivativeCardKeywords_131:Time Paradox EX>\" into hand."
  },
  State_125934_Name = {
    Text = "The Silver Key Gate"
  },
  State_125935_Name = {Text = "Silence"},
  State_125935_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_125937_Desc = {
    Text = "After playing a Command Card, seal the corresponding Awakener's Exalt and all Command Cards for 2 turns."
  },
  State_125937_Name = {
    Text = "Pinions of Time"
  },
  State_125964_Desc = {
    Text = "When consuming Arithmetica, the Keyflare gained is reduced by 50%. After Tawil deals unblocked DMG, put 1 \"<DerivativeCardKeywords_131:Time Paradox EX>\" into hand."
  },
  State_125964_Name = {
    Text = "The Silver Key Gate"
  },
  State_126010_Desc = {
    Text = "Team Unique: The Fixed Poison & Poison Trigger effects caused by the wielder +<WeaponEffect_Num:[StateArg1]%>. Caro Realm's automatic <EmbryoFusionIconKeywords:Embryo Fusion> +<WeaponEffect_Num:[StateArg2]%>. When the wielder first triggers \"Resonance\" each turn, other Awakeners gain <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "The Fixed Poison & Poison Trigger effects caused by the wielder +<WeaponEffect_Num:[StateArg1]%>. Caro Realm's automatic <EmbryoFusionIconKeywords:Embryo Fusion> +<WeaponEffect_Num:[StateArg2]%>. When the wielder fist triggers \"Resonance\" each turn, other Awakeners gain <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126463_Name = {
    Text = "State@Monster Liz Moth-Trapping Fire Damage Listener"
  },
  State_126464_Desc = {
    Text = "Maximum of 10 stacks, each stack increases DMG dealt by Liz by [DescArg1]."
  },
  State_126464_Name = {
    Text = "<GreenWord:Emerald Ember>"
  },
  State_126465_Name = {
    Text = "Monster Liz Intention Listener"
  },
  State_126466_Desc = {
    Text = "The opponent will not discard their hand at the end of their turn. When the intention switches to Green Flames: if there are at least 6 stacks of <MonsterLizVerdantSpark:Emerald Ember>, consume 6 stacks to upgrade the intention to \"Deadly Flames\" that deals <Damage:[Damage:DescArg1]> DMG [AttackTimes:DescArg2] times; if there are at least 3 stacks, consume 3 stacks to upgrade the intention to \"Corrupted Flames\" that deals <Damage:[Damage:DescArg3]> DMG [AttackTimes:DescArg4] times."
  },
  State_126466_Name = {
    Text = "Eternal Flames"
  },
  State_126467_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power, granting the ability to remove negative states for \"Dance to Destruction.\""
  },
  State_126467_Name = {Text = "Not Roused"},
  State_126468_Name = {
    Text = "State@Monster Liz Emerald Reflection Management"
  },
  State_126469_Desc = {
    Text = "For every [DescArg1] HP lost, gain [DescArg2] stack(s) of <MonsterLizVerdantSpark:Emerald Ember>."
  },
  State_126469_Name = {
    Text = "Emerald Reflection"
  },
  State_126470_Name = {
    Text = "State@Monster Liz Hint Count"
  },
  State_126479_Desc = {
    Text = "Maximum of 10 stacks, increases DMG dealt by Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Emerald Ember>"
  },
  State_126540_Desc = {
    Text = "When Resonance is triggered the next [Layer] times, the Resonance effect is doubled."
  },
  State_126540_Name = {
    Text = "Mist-Bound Vow"
  },
  State_126568_Desc = {
    Text = "Each time an Awakener deals Active DMG, command 1 Tentacle to attack the target, dealing [Layer]% Tentacle DMG."
  },
  State_126568_Name = {
    Text = "Raging Waves"
  },
  State_126569_Desc = {
    Text = "Each time Awakeners deal Active DMG, it commands 1 Tentacle to attack the target, dealing 50％ Tentacle DMG."
  },
  State_126569_Name = {
    Text = "Raging Waves"
  },
  State_126643_Desc = {
    Text = "This state MaxLayer=1. Source Awakener: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Limit Level 1"
  },
  State_126644_Desc = {
    Text = [[
After obtaining, clear and reapply [Layer] stacks of Demonstration State. 
 The maximum number of stacks for Demonstration State is 1.]]
  },
  State_126644_Name = {
    Text = "Break the maximum stacks"
  },
  State_126645_Desc = {
    Text = "Ramona's Base DMG increases by [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Sublime Tempering"
  },
  State_126651_Desc = {
    Text = "The listener after unleashing the Pursuit has been satisfied [Layer] times."
  },
  State_126651_Name = {Text = "Counter"},
  State_126652_Desc = {
    Text = "After obtaining it, order the front-row enemy to add a delayed action, playing out their current intention."
  },
  State_126652_Name = {
    Text = "Make the monster pursue"
  },
  State_126653_Desc = {
    Text = "After obtaining, allow the Awakener in position 1 to add a follow-up action to play their Strike card."
  },
  State_126653_Name = {
    Text = "Order the Awakener to Pursue"
  },
  State_126654_Desc = {
    Text = "When the Named Listener is triggered, print the count 1 time."
  },
  State_126654_Name = {
    Text = "Named Listener"
  },
  State_126655_Desc = {
    Text = "After obtaining it, order the Keeper to add a follow-up action and play the skill @Protagonist Skill@Voices in Your Head."
  },
  State_126655_Name = {
    Text = "Order the Keeper to pursue"
  },
  State_126677_Desc = {
    Text = "This turn, the next [Layer] \"Blade of Defiance\" takes effect twice."
  },
  State_126677_Name = {
    Text = "Primal Leviathan"
  },
  State_126678_WeaponDesc = {
    Text = "All Whale Leap DMG instances +1."
  },
  State_126714_Desc = {
    Text = "Aigis's next [Layer] \"Defense\" takes effect 3 times."
  },
  State_126714_Name = {
    Text = "Crystallized Tear"
  },
  State_126714_WeaponDesc = {
    Text = "All Whale Leap damage instances +1."
  },
  State_126715_WeaponDesc = {
    Text = "All Whale Leap damage instances +1."
  },
  State_126776_Desc = {
    Text = "For each stack, Fixed Poison taken +5%, DMG dealt -[DescArg1]%. Stacks up to [DescArg2]."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Spellbound>"
  },
  State_126783_Name = {
    Text = "Temporarily deprecated"
  },
  State_126784_Desc = {
    Text = "Fixed Poison taken +[DescArg1]%, DMG dealt -[DescArg2]%. Stacks up to [DescArg3]."
  },
  State_126784_Name = {Text = "Spellbound"},
  State_126785_Desc = {
    Text = "If other Awakeners have played a total of X Command Cards, trigger follow-up effects after playing this card. The Awakener whom this card belongs to will have their Resonance reset when any of their card is played, or at turn end."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Resonance X>"
  },
  State_126789_Desc = {
    Text = "Inflict 2 stacks of <WitherKeywords:Spellbound> on all enemies."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Betroth>"
  },
  State_126790_Desc = {
    Text = "Remove all enemies' <WitherKeywords:Spellbound>. For each stack removed, deal [DescArg1]% of the target's Max HP as Fixed DMG and trigger 40% Poison."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Enthrall>"
  },
  State_126803_Desc = {
    Text = "The next [DescArg1] Command Cards played will be sent to the future 3 turns ahead."
  },
  State_126803_Name = {
    Text = "(Temporary) Relic Same Name State"
  },
  State_126893_Name = {
    Text = "State@Fate Ultra Pure Identifier"
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Singularity Beacon [DescArg1]>"
  },
  State_126896_Name = {
    Text = "State@Light of Transcendence Card reduces Arithmetica Harmony stacks"
  },
  State_126900_Name = {
    Text = "State@Fate Ultra Dimension Class Initialization 2"
  },
  State_126901_Name = {
    Text = "State@Fate Ultra Dimension Class Initialization 1"
  },
  State_126903_Name = {
    Text = "State@Ultra Space Quasar Marker"
  },
  State_126927_Desc = {
    Text = "Team Unique: The Fixed Poison & Poison Trigger effects caused by the wielder +<WeaponEffect_Num:[StateArg1]%>. The wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus the first time they trigger \"Resonance\" each turn."
  },
  State_126927_WeaponDesc = {
    Text = "The Fixed Poison & Poison Trigger effects caused by the wielder +<WeaponEffect_Num:[StateArg1]%>. The wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus the first time they trigger \"Resonance\" each turn."
  },
  State_127108_Desc = {
    Text = "Inflict 5 stacks of <WitherKeywords:Spellbound> on all enemies."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Betroth>"
  },
  State_127109_Desc = {
    Text = "Remove all enemies' <WitherKeywords:Spellbound>. For each stack removed, accumulate Crimson Furnace equal to 15% CON, deal [DescArg1]% of the target's Max HP as Fixed DMG, and trigger 40% Poison."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Enthrall>"
  },
  State_127176_Desc = {
    Text = "For each stack, Fixed Poison taken +5%, DMG dealt -[DescArg1]%. Stacks up to [DescArg2]."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Spellbound>"
  },
  State_127264_Desc = {
    Text = "When playing this card, the \"Perceiver\" gains 1 stack of <MonsterTimeBeacon:Loop>. If this card is discarded, the \"Perceiver\" loses 1 stack of <MonsterTimeBeacon:Loop>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Sight Unbound>"
  },
  State_127266_Desc = {
    Text = "This Awakener is still Unawakened... It will Rouse when about to be defeated, restore Life, and begin battling in its true form."
  },
  State_127266_Name = {Text = "Not Roused"},
  State_127267_Desc = {
    Text = "At the end of the turn, gain 1 stack of <MonsterTimeBeacon:Loop>."
  },
  State_127267_Name = {
    Text = "Entropy Undone"
  },
  State_127271_Desc = {
    Text = "After releasing Posse, gain 1 stack of <MonsterTimeBeacon:Loop>."
  },
  State_127271_Name = {
    Text = "Mobius Captive"
  },
  State_127272_Desc = {
    Text = "Maximum 3 stacks. When the \"Perceiver\" unleashes intention with 3 stacks of <MonsterTimeBeacon:Loop>, trigger the <MonsterTimeBeacon:Loop> effect, clear <MonsterTimeBeacon:Loop>, and remove negative states."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Loop>"
  },
  State_127275_Desc = {
    Text = "For each stack, Fixed Poison taken +5%, DMG dealt -[DescArg1]%. Stacks up to [DescArg2]."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Spellbound>"
  },
  State_127276_Desc = {
    Text = "When playing this card, the \"Perceiver\" gains 1 stack of <MonsterTimeBeacon:Loop>. If this card is discarded, the \"Perceiver\" loses 1 stack of <MonsterTimeBeacon:Loop>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Sight Unbound>"
  },
  State_127312_Desc = {
    Text = "When the Psyche Surge of the Awakener reaches +12, the \"Absolute Axiom\" is activated, granting unique effects."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Final Rule>"
  },
  State_127705_Desc = {
    Text = "Card was tampered with! Take [Layer] DMG when played."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Sabotage>"
  },
  State_127705_WeaponDesc = {
    Text = "Card takes [StateArg1] damage when played."
  },
  State_127708_Desc = {
    Text = "After the enemy plays a non-Command Card, all allies gain [DescArg1] stack(s) of <PowerIconKeywords:Strength>. Becomes inactive after Ancient Embers is Broken."
  },
  State_127708_Name = {
    Text = "Thread of Darkness"
  },
  State_127709_Name = {
    Text = "Player Status of Black Thread"
  },
  State_127710_Name = {
    Text = "Trigger of Black Thread"
  },
  State_128026_Name = {
    Text = "Player Status of White Thread"
  },
  State_128027_Desc = {
    Text = "After the enemy plays a Command Card, all allies gain [DescArg1] stacks of Temporary <ReinforcePVEKeywords:Fortress>. The Ancient Embers become ineffective after being broken."
  },
  State_128027_Name = {
    Text = "Thread of White"
  },
  State_128028_Desc = {
    Text = "Card was tampered with! Take DMG when played."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Sabotage>"
  },
  State_128028_WeaponDesc = {
    Text = "Card takes [StateArg1] damage when played."
  },
  State_128029_Name = {
    Text = "Trigger of White Thread"
  },
  State_128067_Name = {
    Text = "State@Cold Spider Maid Ashes Listener"
  },
  State_128069_Name = {
    Text = "State@Cold Spider Maid Entwined Hit Detection"
  },
  State_128071_Name = {
    Text = "State@Cold Spider Maid Front Position Requires Summon Marker"
  },
  State_128073_Desc = {
    Text = "Gain [DescArg1] stacks of <ParcloseIconKeywords:Barrier> and [DescArg2] stacks of <Chapter5_Monster_Fervor1:Fervor> after each action ends."
  },
  State_128073_Name = {
    Text = "Fervor of Destiny - White"
  },
  State_128082_Desc = {
    Text = "Play this card to grant Hameln 3 Aliemus."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_128086_Desc = {
    Text = "After the enemy plays a Command Card, gain [DescArg1] stack(s) of <Chapter5_Monster_Fervor1:Fervor>, and swap positions with the ally in the back row after \"Ancient Embers\" is depleted."
  },
  State_128086_Name = {
    Text = "Cycle of White"
  },
  State_128087_Name = {
    Text = "State@Cold Spider Maid Cycle of White Trigger Marker"
  },
  State_128089_Name = {
    Text = "Cycle of White Trigger"
  },
  State_128216_Name = {
    Text = "Player Status of White Cycle"
  },
  State_128245_Desc = {
    Text = "Clear after the start of the turn. After reaching 10 stacks, immediately act the next time a card is played, removing <Chapter5_Monster_Fervor2:Fervor> and switching the intention to inflict <FragileIconKeywords:Fragile> and randomly attach <BrokenCard:Sabotage> \"Thread of Collapse.\""
  },
  State_128245_Name = {
    Text = "Temporary Fervor"
  },
  State_128246_Name = {
    Text = "Player Status of Black Cycle"
  },
  State_128247_Desc = {
    Text = "Upon death, revive with Immune to Damage and 100% HP. Switch intent to \"Destined Fervor\": After each action, gain [DescArg1] <PowerIconKeywords:Strength> and [DescArg2] <Chapter5_Monster_Fervor2:Fervor>."
  },
  State_128247_Name = {
    Text = "Reversed Fate"
  },
  State_128248_Desc = {
    Text = "Clear after the turn starts. After reaching 10 stacks, immediately act the next time a card is played, remove <Chapter5_Monster_Fervor1:Fervor> and switch the intention to \"Web of Bondage,\" which inflicts <WeaknessIconKeywords:Weakness> and randomly Seals Command Cards."
  },
  State_128248_Name = {
    Text = "Temporary Fervor"
  },
  State_128250_Name = {
    Text = "Trigger of Black Cycle"
  },
  State_128251_Desc = {
    Text = "After the enemy plays a Command Card, gain [DescArg1] stack(s) of <Chapter5_Monster_Fervor1:Fervor>, and swap positions with the ally in the back row after \"Ancient Embers\" is depleted."
  },
  State_128251_Name = {
    Text = "Cycle of Darkness"
  },
  State_128253_Desc = {
    Text = "After death, revive with Immunity to DMG and 100% HP. Switch Intention to \"Destined Fervor\": After each action, gain [DescArg1] stack(s) of <ParcloseIconKeywords:Barrier> and [DescArg2] stack(s) of <Chapter5_Monster_Fervor1:Fervor>."
  },
  State_128253_Name = {
    Text = "Reversed Fate"
  },
  State_128257_Desc = {
    Text = "Gain [DescArg1] <PowerIconKeywords:STR> and [DescArg2] stacks of <Chapter5_Monster_Fervor2:Fervor> after each action ends."
  },
  State_128257_Name = {
    Text = "Fervor of Destiny - Black"
  },
  State_128643_Name = {
    Text = "State@Player This Turn Play Symptom Count"
  },
  State_128644_Desc = {
    Text = "Clear at the start of the turn. After reaching 10 stacks, immediately act after the next card is played, removing <Chapter5_Monster_Fervor3:Fervor> and randomly switching the intention."
  },
  State_128644_Name = {
    Text = "Temporary Fervor"
  },
  State_128645_Desc = {
    Text = "The intention will be randomly chosen from four types, but will not repeat. Immediately switch intentions after releasing an Exalt. Gain 1 stack of <Chapter5_Monster_Fervor3:Fervor> after playing a Command Card."
  },
  State_128645_Name = {
    Text = "Omnifex Harmony"
  },
  State_128646_Name = {
    Text = "State@Deranged Fate Disqualified Heavy Blow Play Detection"
  },
  State_128648_Desc = {
    Text = "Until the start of the next turn, gain [DescArg1] Temporary <PowerIconKeywords:STR> each time you play a Command Card."
  },
  State_128648_Name = {
    Text = "Anger Face - Disqualified Heavy Blow"
  },
  State_128692_Desc = {
    Text = "After suffering active damage or Tentacle damage, remove an equivalent amount of \"Old Embers\" and lose 300% of the removal amount in life; when suffering other damage, remove half. The number of \"Old Embers\" resets each round."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Ancient Embers>"
  },
  State_128695_Name = {
    Text = "State@Deranged Fate Intent Marker"
  },
  State_129297_Desc = {
    Text = "At the start of the next [Layer] battles, set all enemies' HP to 1."
  },
  State_129297_Name = {
    Text = "Little N's Help"
  },
  State_129569_Name = {
    Text = "State@Deranged Fate Joy Theater Trigger Marker"
  },
  State_129570_Name = {
    Text = "State@Deranged Fate Fate Whisper Trigger Marker"
  },
  State_129571_Name = {
    Text = "State@Deranged Fate Endless Nullity Trigger Marker"
  },
  State_129612_Desc = {
    Text = "The intention will be randomly chosen from four types, but will not repeat. Immediately switch intentions after releasing an Exalt. Gain 1 stack of <Chapter5_Monster_Fervor3:Fervor> after playing a Command Card."
  },
  State_129612_Name = {
    Text = "Omnifex Harmony"
  },
  State_129625_Desc = {
    Text = "The intention will be randomly chosen from four types, but will not repeat. Immediately switch intentions after releasing an Exalt. Gain 1 stack of <Chapter5_Monster_Fervor3:Fervor> after playing a Command Card. Gain 1 stack of \"Distortion Fusion\" each time the intention is switched."
  },
  State_129625_Name = {
    Text = "Omnifex Harmony"
  },
  State_129643_Desc = {
    Text = "Gain 1 stack each time the intention is switched. When having 10 stacks of \"Distortion Fusion,\" the intention changes to the unchangeable \"Unity of All Faces,\" which deals massive DMG and inflicts debuffs."
  },
  State_129643_Name = {
    Text = "Twisted Melt"
  },
  State_129644_Name = {
    Text = "Twisted Melt Lock Intentions"
  },
  State_129650_Desc = {
    Text = "Team Unique: If the wielder is the Awakener \"Ramona: Timeworn,\" the Affinity gained by other Awakeners upon completing the stage is increased by <WeaponEffect_Num:[StateArg1]%>, but the wielder does not gain any Affinity."
  },
  State_129650_WeaponDesc = {
    Text = "If the equipper is the Awakener \"Ramona\", the affinity gained upon completing a level is increased by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_129744_Desc = {
    Text = "Gain 1 Arithmetica, then draw 1 card"
  },
  State_129744_Name = {
    Text = "Testing in Ultra Space"
  },
  State_129752_Name = {
    Text = "In Ultra Space"
  },
  State_129753_Name = {
    Text = "Ultra Round Start"
  },
  State_129761_Desc = {
    Text = "Modify the interface to return the in-game growth intensity for players, increasing by 1% for each stack."
  },
  State_129761_Name = {
    Text = "In-Game Growth Intensity Adjustment"
  },
  State_129845_Desc = {
    Text = "This Awakener is still Unawakened... It will Rouse when about to be defeated, restore Life, and begin battling in its true form."
  },
  State_129845_Name = {Text = "Not roused"},
  State_129846_Name = {
    Text = "Spatial Tremor Count"
  },
  State_129848_Desc = {
    Text = "Every time [DescArg1] cards leave the Dimensional Rift, grant them [DescArg2] stacks of <BrokenCard:Sabotage>."
  },
  State_129848_Name = {Text = "Future Cut"},
  State_129849_Desc = {
    Text = "Create a copy of the first Command Card played by the enemy each turn and place it into the Dimensional Rift. When the card enters the Dimensional Rift, grant it <DepleteIconKeywords:Exhaust>. The first time a Posse is unleashed each turn, take the leftmost card out and place it on top of the Draw Pile."
  },
  State_129849_Name = {
    Text = "Weaving Fate"
  },
  State_129850_Desc = {
    Text = "For each Command Card in the Dimensional Rift, the player's hand limit decreases by 1. If it is already full, the next time a card is played, the \"Eternal Web\" will act immediately, clearing the Dimensional Rift and adjusting the intent to \"Elegy of Transcending Fate.\""
  },
  State_129850_Name = {
    Text = "Spatial Tremor"
  },
  State_129854_Desc = {
    Text = "For each Command Card in the Dimensional Rift, the player's hand limit decreases by 1. If it is already full, the next time a card is played, the \"Eternal Web\" will act immediately, clearing the Dimensional Rift and adjusting the intent to \"Spinning Wheel of Fate.\""
  },
  State_129854_Name = {
    Text = "Spatial Tremor"
  },
  State_129864_Desc = {
    Text = "Remove 1 layer of \"Drowsiness\" whenever a card is played. At the start of the turn, restore to 12 layers of \"Drowsiness\"."
  },
  State_129864_Name = {Text = "Fury"},
  State_129865_Desc = {
    Text = "This Awakener is still Unawakened... It will Rouse when about to be defeated, restore Life, and begin battling in its true form."
  },
  State_129865_Name = {Text = "Not Roused"},
  State_129872_Desc = {
    Text = "Temporary variable."
  },
  State_129872_Name = {Text = "Counter 1"},
  State_129873_Desc = {
    Text = "Gain [Layer] stacks of State _Counter1_."
  },
  State_129873_Name = {
    Text = "Encapsulation Test 1"
  },
  State_129874_Desc = {
    Text = "Temporary variable."
  },
  State_129874_Name = {
    Text = "Amplifier 1"
  },
  State_130358_Desc = {
    Text = "The next Command Card played takes effect 2 additional times."
  },
  State_130358_Name = {Text = "Marionette"},
  State_130387_Desc = {
    Text = "After \"Marionette\" is Exhausted, the first Command Card played each subsequent turn takes effect 2 additional times. If it is a Boss Battle, all Awakeners gain 50 Aliemus and gain 1000 Keyflare."
  },
  State_130387_Name = {
    Text = "The Funeral of Fate"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Retain>: Gain [DescArg1] Keyflare"
  },
  State_130389_Desc = {
    Text = "When played, grant all Awakeners [DescArg1] Aliemus"
  },
  State_130389_Name = {
    Text = "When played, grant all Awakeners [DescArg1] Aliemus"
  },
  State_130390_Desc = {
    Text = "Arithmetica Limit and Maximum Hand Size increased by 1."
  },
  State_130390_Name = {
    Text = "Redundant Profile"
  },
  State_130391_Desc = {
    Text = "Each time you play 1 \"Symptom Card\", \"Marionette\"'s Arithmetica Cost is reduced by 1."
  },
  State_130391_Name = {
    Text = "Echoes of Filth"
  },
  State_130490_Desc = {
    Text = "The DMG, Shield, Healing, Strength, Drain, Tentacle DMG, fixed Poison, and fixed Counter provided by this card are increased, multiplied independently by 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Singularity Beacon α"
  },
  State_130498_Desc = {
    Text = "The next Command Card played takes effect 2 additional times."
  },
  State_130498_Name = {
    Text = "The Funeral of Fate"
  },
  State_130500_Desc = {
    Text = "Death Resistance +100% in Boss Battle. After triggering \"Death Resistance\", \"Marionette\" will no longer force a Command Card to be played next turn; instead, choose one Command Card from your hand."
  },
  State_130500_Name = {
    Text = "Martyr's Glimpse"
  },
  State_130501_Desc = {
    Text = "The next Command Card's Arithmetica Cost is reduced to 0."
  },
  State_130501_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_130512_Desc = {
    Text = "The next Command Card played takes effect 2 additional times and has its Arithmetica Cost reduced by 2."
  },
  State_130512_Name = {Text = "Marionette"},
  State_130517_Name = {
    Text = "Stakes of Wisdom"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant self <Block:[Block:StateArg1]> Shield and <DelayKeywords:Delay>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_131046_Name = {
    Text = "The Faraway Eden"
  },
  State_131047_Desc = {
    Text = "This turn, the next [Layer] uses of Posse will take effect twice."
  },
  State_131047_Name = {Text = "Dual posse"},
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After playing a \"Skill\" for the first time each turn, deal <Damage:[Damage:Arg1]> DMG to the enemy with the lowest HP and Shield."
  },
  State_131048_Name = {
    Text = "Imprisoned Madness"
  },
  State_131055_Desc = {
    Text = "Draw -1 card each turn. All Awakeners' Shield and health recovery are increased by 20%."
  },
  State_131055_Name = {
    Text = "Chin Scritches"
  },
  State_131056_Desc = {
    Text = "After losing HP, convert an equal amount of Delayed Aliemus into Shield."
  },
  State_131056_Name = {
    Text = "Vortex Shield"
  },
  State_131058_Desc = {
    Text = "All Awakeners' Base Aliemus +10. Gain 1 Arithmetica after unleashing Exalt, and each Awakener can only trigger it once per turn."
  },
  State_131058_Name = {
    Text = "Cheek Nuzzles"
  },
  State_131059_Name = {
    Text = "Vortice Ultimate Upgrade Marker"
  },
  State_131061_Desc = {
    Text = "Silver Key Energy Cap and Key Token Consumption Silver Key Energy +350. The first Key Token takes effect 2 times each turn."
  },
  State_131061_Name = {
    Text = "Feed the Otter"
  },
  State_131064_Desc = {
    Text = "Gain 1 Arithmetica after unleashing Exalt, and each Awakener can only trigger it once per turn."
  },
  State_131064_Name = {
    Text = "Cheek Nuzzles"
  },
  State_131069_Desc = {
    Text = "All Awakeners' Shield Generation and HP Recovery +20%."
  },
  State_131069_Name = {
    Text = "Chin Scritches"
  },
  State_131073_Desc = {
    Text = [[
Team Unique: Gain Aliemus equal to <WeaponEffect_Num:[StateArg1]%> Base Aliemus at the start of battle. The wielder's Exalt Final DMG increases by a percentage equal to <WeaponEffect_Num:[StateArg2]%> of Base Aliemus.
When switching to the "Raging Waves" stance, gain Temporary Realm Mastery equal to <WeaponEffect_Num:[StateArg3]%> of your current Realm Mastery. 3-turn cooldown.]]
  },
  State_131073_WeaponDesc = {
    Text = "Gain [DescArg1] Aliemus at the start of battle. The wielder's Exalt Final DMG +[DescArg2]％.\nWhen switching to the \"Raging Waves\" stance, gain [DescArg3] Temporary Realm Mastery. 3-turn cooldown (Remaining turns: [DescArg4])."
  },
  State_131078_Desc = {
    Text = "The first Posse activation each turn takes effect twice."
  },
  State_131078_Name = {
    Text = "Feed the Otter"
  },
  State_131118_Desc = {
    Text = "Each time you take DMG or lose HP, it cannot exceed 5% of Max HP."
  },
  State_131118_Name = {
    Text = "Cocoon of Fate"
  },
  State_131123_Desc = {
    Text = "Clear at the start of the turn. After reaching 10 stacks, immediately act and switch to the next intent the next time a card is played, removing <Chapter5_Monster_Fervor4:Fervor>."
  },
  State_131123_Name = {
    Text = "Temporary Fervor"
  },
  State_131127_Desc = {
    Text = "A stance bound by Fate. Every time the enemy plays 1 Command Card, Dark Arachne gains 1 stack of \"Temporary Fervor\"."
  },
  State_131127_Name = {
    Text = "Fate's Oath-Bound"
  },
  State_131134_Desc = {
    Text = "After death, Arachne gains [DescArg1] stack(s) of Temporary Fervor."
  },
  State_131134_Name = {
    Text = "Restlessness"
  },
  State_131171_Desc = {
    Text = "A Placement into Ultra Space has already been triggered this turn. Cannot refresh entry count"
  },
  State_131186_Desc = {
    Text = "Takes effect 1 additional time, but suffer [DescArg1] DMG after being played."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Shattered Fate>"
  },
  State_131188_Desc = {
    Text = "Played \"Skills\" enter the \"Dimensional Rift\" and attach \"Fate Fragment\" to all Skills of the same name, which is removed upon leaving the Dimensional Rift. When the Dimensional Rift is full, Dark Arachne acts and clears the Dimensional Rift, then unleashes \"Elapsed Sands of Time\" on the next intent."
  },
  State_131188_Name = {
    Text = "Dimensional Rift"
  },
  State_131191_Name = {
    Text = "Cognitive Impairment"
  },
  State_131242_Desc = {
    Text = "The DMG, Shield, Healing, Strength, Drain, Tentacle DMG, fixed Poison, and fixed Counter provided by this card are increased, multiplicatively calculated as 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Singularity Beacon β"
  },
  State_131258_Desc = {
    Text = "When stacks are cleared, the enemy loses 5% of Max HP, stacks are reset, and the \"Dimensional Rift\" is cleared. Each time stacks are reset, the trigger count increases by 1. After triggering [DescArg1] more times, remove this Effect and the enemy's \"Cocoon of Fate\", causing the enemy to additionally lose 10% of Max HP."
  },
  State_131258_Name = {
    Text = "Fate Disruption"
  },
  State_131261_Desc = {
    Text = "After unleashing a Posse or playing a \"Fate Remnant\" Card, remove 1 stack of \"Fate Disturbance\". When \"Fate Disturbance\" is cleared, the enemy loses 5% of Max HP, stacks are reset, and the \"Dimensional Rift\" is cleared. Each time stacks are reset, the trigger count increases by 1. After triggering 3 times, remove this Effect and the enemy's \"Cocoon of Fate\", causing the enemy to additionally lose 10% of Max HP."
  },
  State_131261_Name = {
    Text = "Arachne's Theater"
  },
  State_131275_Desc = {
    Text = "This card takes effect 1 additional time after being played."
  },
  State_131275_Name = {
    Text = "<DestinyKeywords:Destined>"
  },
  State_131351_Desc = {
    Text = "After other Awakeners unleash Exalt, consume 1 stack, and Vortice unleashes \"Vortex! Shell!\" as a Pursuit."
  },
  State_131351_Name = {
    Text = "Vortex Reload"
  },
  State_131439_Desc = {
    Text = "The next Command Card played takes effect 2 additional times and has its Arithmetica Cost reduced to 0."
  },
  State_131439_Name = {Text = "Marionette"},
  State_131637_Desc = {
    Text = "Immediately summon a random \"Small Leng Spider Swarm\" after death, reducing its \"Swarm Effect\" by 1 stack."
  },
  State_131637_Name = {
    Text = "Cluster Effect"
  },
  State_131638_Desc = {
    Text = "Immediately summon a random \"Small Leng Spider Elite Swarm\" after death, reducing its \"Swarm Effect\" by 1 stack."
  },
  State_131638_Name = {
    Text = "Cluster Effect"
  },
  State_131645_Desc = {
    Text = "Team Unique: When switching to the \"Raging Waves\" stance, gain Temporary Realm Mastery equal to <WeaponEffect_Num:[StateArg1]%> of your current Realm Mastery. 3-turn cooldown."
  },
  State_131645_WeaponDesc = {
    Text = "When switching to the \"Raging Waves\" stance, gain  [DescArg2] Temporary Realm Mastery. 3-turn cooldown (Remaining turns: [DescArg1])."
  },
  State_131657_Desc = {
    Text = "After other Awakeners unleash Exalt, consume 1 stack, and Vortice unleashes \"Vortex! Shell!\" as a Pursuit."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:Vortex Reload>"
  },
  State_131660_Desc = {
    Text = "For each stack, the Aliemus required to unleash Exalt increases by 1."
  },
  State_131660_Name = {
    Text = "Aliemus Cost Num Adjust"
  },
  State_131675_Desc = {
    Text = "This Card has a [StateArg1]% chance to take effect 1 additional time the next time it is played."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Gamble>"
  },
  State_131684_Desc = {
    Text = "The next [Layer] \"Vortex! Shell!\" unleashed trigger 2 times."
  },
  State_131684_Name = {
    Text = "Moskstraumen! BOOM!"
  },
  State_131749_Desc = {
    Text = "Team Unique: After exploration starts, shuffle 1 \"Stakes of Wisdom\" into the Draw Pile. \"Stakes of Wisdom\": Cost 1 Arithmetica. Shuffle all Command Cards in hand randomly into the Draw Pile. Shuffled Command Cards have a <WeaponEffect_Num:[StateArg1]%> chance to take effect 1 additional time when played next, and for each Command Card shuffled in, all Awakeners gain 2 Aliemus. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Exhaust>. <GuyouKeywords:Innate>."
  },
  State_131749_WeaponDesc = {
    Text = "After the exploration starts, shuffle 1 \"Stakes of Wisdom\" into the Draw Pile. \"Stakes of Wisdom\": Cost 1 Arithmetica. Shuffle all Command Cards in hand randomly into the Draw Pile, the shuffled Command Cards have a <WeaponEffect_Num:[StateArg1]%> chance to take effect 1 additional time when played next, and for each Command Card shuffled in, all Awakeners gain 2 Aliemus. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Exhaust>. <GuyouKeywords:Innate>."
  },
  State_131769_Name = {
    Text = "State@Breeding Caro Class Initialization 1"
  },
  State_131770_Name = {
    Text = "State@Breeding Caro Class Initialization 2"
  },
  State_131779_Desc = {
    Text = "Only enters the Discard Pile and resets the count after being used [Layer] times, but \"Orison\" only takes effect the first time it is used."
  },
  State_131779_Name = {
    Text = "Usable [Layer] times"
  },
  State_131789_Desc = {
    Text = "A backup option. Add 1 card with tid [Layer] to your hand."
  },
  State_131789_Name = {
    Text = "Add Specified Card"
  },
  State_131804_Name = {
    Text = "Breeding Caro Mastery"
  },
  State_131807_Name = {
    Text = "State@Breeding Caro Pure Identifier"
  },
  State_131824_Name = {
    Text = "State@Monster Tawil Switch Intent Player Listener"
  },
  State_131846_Desc = {
    Text = "Immediately summon a random \"Small Leng Spider Swarm\" after death, reducing its \"Swarm Effect\" by 1 stack."
  },
  State_131846_Name = {
    Text = "Cluster Effect"
  },
  State_131876_Desc = {
    Text = "Team Unique: The wielder's fixed Poison and triggered Poison Effects are increased by <WeaponEffect_Num:[StateArg1]%>, and the <EmbryoFusionIconKeywords:Embryo Fusion> automatically restored in the Caro Realm is increased by <WeaponEffect_Num:[StateArg2]%>. The first time the wielder triggers \"Resonance\" each turn, other Awakeners gain <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_131876_WeaponDesc = {
    Text = "The wielder's Fixed Poison and Triggered Poison Effects +<WeaponEffect_Num:[StateArg1]%>, and the <EmbryoFusionIconKeywords:Embryo Fusion> automatically restored by the Caro Realm +<WeaponEffect_Num:[StateArg2]%>. The first time the wielder triggers \"Resonance\" each turn, other Awakeners gain <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_131877_Desc = {
    Text = "Team Unique: Fixed Poison and Triggered Poison Effects dealt by the wielder +<WeaponEffect_Num:[StateArg1]%>. The first time the wielder triggers \"Resonance\" each turn, they gain <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_131877_WeaponDesc = {
    Text = "Fixed Poison and Triggered Poison Effects dealt by the wielder +<WeaponEffect_Num:[StateArg1]%>. The wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus the first time they trigger \"Resonance\" each turn."
  },
  State_131908_Name = {
    Text = "Feast of Decay Springboard"
  },
  State_131909_Desc = {
    Text = "Having this State prevents the use of Exalt."
  },
  State_131909_Name = {
    Text = "Permanently Sealed"
  },
  State_132366_Name = {Text = "Pursuit"},
  State_132539_WeaponDesc = {Text = "Test"},
  State_132560_WeaponDesc = {
    Text = "Every [Damage:StateArg2] times Cinderfire deals damage, gain one [Green Flame] that is exhausted."
  },
  State_132564_WeaponDesc = {
    Text = "Every [Damage:StateArg2] times Cinderfire deals damage, gain one [Green Flame] that is exhausted."
  },
  State_132565_WeaponDesc = {
    Text = "Every [Damage:StateArg2] times Cinderfire deals damage, gain one [Green Flame] that is exhausted."
  },
  State_132598_Name = {
    Text = "Abyssal obsession"
  },
  State_132609_Desc = {
    Text = "When the Sculptors apply a shield, [StateArg1] tentacle damage is increased."
  },
  State_132609_Name = {
    Text = "Realm of oblivion"
  },
  State_132609_WeaponDesc = {
    Text = "When the Sculptors apply a shield, [StateArg1] tentacle damage is increased."
  },
  State_133353_Name = {
    Text = "Suggested Translation"
  },
  State_133354_Name = {
    Text = "Suggested Translation"
  },
  State_133369_Name = {
    Text = "The silver key gate"
  },
  State_19507_Desc = {
    Text = "Active DMG and Bleed stacks received +25% until next turn starts, offset by Fortress stacks."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Vulnerable>"
  },
  State_19508_Desc = {
    Text = "At turn end, discard this card."
  },
  State_19508_Name = {
    Text = "<CardKeyWord:Fleeting>"
  },
  State_19509_Desc = {
    Text = "Temporarily change the card's Arithmetica."
  },
  State_19509_Name = {
    Text = "Permanently Change Arithmetica Cost"
  },
  State_19511_Desc = {
    Text = "Upon death, replace hand cards with illusion cards"
  },
  State_19511_Name = {
    Text = "Death triggers the replacement of hand cards with Illusion."
  },
  State_19513_Name = {
    Text = "Apply Deathmatch"
  },
  State_19516_Name = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_19517_Desc = {
    Text = "Gain 1 Aliemus for every 2% HP lost"
  },
  State_19517_Name = {
    Text = "Taking DMG grants Aliemus."
  },
  State_19519_Desc = {
    Text = "After using \"Strike\", consume all stacks. Each stack increases the DMG of this \"Strike\" by 50%, up to 5 stacks. (Currently +[DescArg1]%)"
  },
  State_19519_Name = {Text = "Charge"},
  State_19521_Desc = {
    Text = "Each stack increases all damage dealt in this battle by 1 point and cannot be dispelled."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Strength>"
  },
  State_19522_Name = {
    Text = "Temporarily Change Arithmetica Cost"
  },
  State_19523_Name = {
    Text = "Permanently Change Arithmetica Cost"
  },
  State_19524_Desc = {
    Text = "Before the start of next turn, deal [Layer] passive DMG to the attacker each time you are attacked."
  },
  State_19524_Name = {Text = "Counter"},
  State_19525_Desc = {
    Text = "Remove the Awakener's Shield before the turn starts."
  },
  State_19525_Name = {
    Text = "Remove the character's Shield before the turn starts"
  },
  State_19527_Desc = {
    Text = "Play a non-Strike card before turn end. Arithmetica Cost +1, up to 3 stacks."
  },
  State_19527_Name = {
    Text = "<SlowColour:Stagnation>"
  },
  State_19528_Desc = {
    Text = "A card with powerful effects."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Posse>"
  },
  State_19529_Desc = {
    Text = "Each time you play another card, reduce this card's Arithmetica Cost by 1 for the next play; after playing this card, return it to your hand and increase its Arithmetica Cost by 1, then discard it at turn end."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Phantasm>"
  },
  State_19530_Desc = {
    Text = [[
Opponents must prioritize this unit for attacks and single-target abilities.
On Activation: Self: Removes Stealth. Allies: Removes their Taunt. Enemies: Dispels all enemy Stealth.]]
  },
  State_19530_Name = {
    Text = "<TauntColour:Taunt>"
  },
  State_19532_Desc = {
    Text = "DMG dealt is reduced by [DescArg1]% until turn end, negating buffs when applied."
  },
  State_19532_Name = {Text = "Weakness"},
  State_19533_Desc = {
    Text = "DMG dealt -50% until turn end, negating Enhance when applied."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Weakness>"
  },
  State_19534_Desc = {
    Text = "Active DMG and Bleed stacks taken +[DescArg1]% until next turn starts, offset by Fortress stacks."
  },
  State_19534_Name = {Text = "Vulnerable"},
  State_19535_Desc = {
    Text = [[
Opponents must prioritize this unit for attacks and single-target abilities.
On Activation: Self: Removes current Stealth. Allies: Removes their Taunt. Enemies: Dispels all enemy Stealth.]]
  },
  State_19535_Name = {Text = "Taunt"},
  State_19536_Desc = {
    Text = "At turn end, gain 10 Aliemus"
  },
  State_19536_Name = {
    Text = "Gain Aliemus Trigger at turn end"
  },
  State_19537_Desc = {
    Text = "Before the end of this turn, DMG dealt increases by [DescArg1]%, offset by Weakness."
  },
  State_19537_Name = {Text = "Enhance"},
  State_19538_Desc = {
    Text = [[
Gain 1 stack at the start of turns 8 and 9
Each stack of Fierce Fight reduces shield and life recovery by 50% and decreases the number of stackable barrier stacks by 1
Fierce Fight cannot be dispelled and affects dead Awakeners.]]
  },
  State_19538_Name = {Text = "Deathmatch"},
  State_19540_Name = {
    Text = "Arithmetica Limit"
  },
  State_19541_Desc = {
    Text = "Cannot perform any actions until turn end."
  },
  State_19541_Name = {Text = "Fainted"},
  State_19544_Desc = {
    Text = "After using \"Strike\", consume all stacks. Each stack consumed increases the DMG of this \"Strike\" by 50%, up to 5 stacks."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:Charge>"
  },
  State_19545_Name = {
    Text = "This card is considered \"Strike\""
  },
  State_19546_Desc = {
    Text = "Change the card's Arithmetica before playing."
  },
  State_19546_Name = {
    Text = "Change Arithmetica Cost before playing"
  },
  State_19547_Desc = {
    Text = "At end turn, take [Layer] passive DMG. Permanent."
  },
  State_19547_Name = {Text = "Poison"},
  State_19549_Desc = {
    Text = "Before the start of next turn, active attack DMG received is reduced by 50%, and negates with Vulnerable when applied."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:Fortress>"
  },
  State_19551_Name = {
    Text = "Arithmetica Limit-"
  },
  State_19552_Desc = {
    Text = "Currently have [Layer] Shield. Shield do not exceed Max HP and last for 1 turn."
  },
  State_19552_Name = {Text = "Shield"},
  State_19553_Desc = {
    Text = "Gain \"Strike Last, Strike Best\" after the draw phase"
  },
  State_19553_Name = {
    Text = "Counterattack Trigger"
  },
  State_19554_Name = {
    Text = "Empty State"
  },
  State_19555_Desc = {
    Text = "Every time a Non-Strike Card is played, Arithmetica Cost +[Layer], up to 3 stacks."
  },
  State_19555_Name = {Text = "Stagnation"},
  State_19556_Desc = {
    Text = "At turn end, this card's Arithmetica Cost -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Prepare [Layer] >"
  },
  State_19557_Desc = {
    Text = "Before the start of next turn, active attack DMG received is reduced by [DescArg1]%, and negates with Vulnerable when applied."
  },
  State_19557_Name = {Text = "Fortress"},
  State_19558_Name = {
    Text = "Revive Deck Card Addition Trigger"
  },
  State_19560_Desc = {
    Text = "Cannot use Exalt until turn end."
  },
  State_19560_Name = {Text = "Sealed"},
  State_19561_Name = {
    Text = ", can be used 3 times"
  },
  State_19990_Desc = {
    Text = "At the start of next turn, gain [Layer] Aliemus."
  },
  State_19990_Name = {
    Text = "Delayed Aliemus"
  },
  State_19992_Desc = {
    Text = "When Fainted, a target cannot act until the turn ends. Taking Fainting DMG grants Resistance. If Resistance is active, subsequent Fainting DMG is doubled but the Fainting effect is negated."
  },
  State_19992_Name = {
    Text = "<ComaColour:Fainted>"
  },
  State_19995_Desc = {
    Text = "At turn end, deal passive DMG equal to the number of stacks. Permanent."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Poison>"
  },
  State_19996_Desc = {
    Text = "Before the end of this turn, DMG dealt increases by 25%, offset by Weakness."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Enhance>"
  },
  State_19998_Desc = {
    Text = "Before the next turn starts, each time you are attacked, inflict an equal number of stacks of passive DMG on the attacker."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Counter>"
  },
  State_20012_Desc = {
    Text = "Each remaining Arithmetica allows you to draw 1 card at the start of next turn; each remaining card grants you 1 Arithmetica at the start of next turn."
  },
  State_20012_Name = {
    Text = "Forgotten Prelude"
  },
  State_20012_WeaponDesc = {
    Text = "Each remaining Arithmetica allows you to draw 1 card at the start of next turn; each remaining card in hand grants you 1 Arithmetica at the start of next turn."
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> Increase by 100. Return the first card played each turn to your hand. At the start of an Ultra Round, increase the Hand Limit by 5 and Copy your hand."
  },
  State_20013_Name = {
    Text = "State@Chrono Pendulum Mirror"
  },
  State_20016_Name = {
    Text = "Relic Arcane Gloves"
  },
  State_20017_Desc = {
    Text = "The next Leap effect will definitely trigger."
  },
  State_20017_Name = {Text = "Leap"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> Increase by 100. Return the first card played each turn to your hand. At the start of an Ultra Round, increase the Hand Limit by 5 and Copy your hand."
  },
  State_20021_Name = {
    Text = "State@Chrono Pendulum Mirror"
  },
  State_20023_Desc = {
    Text = "At the start of the battle, shuffle two Aliemus Charge cards into the deck."
  },
  State_20023_Name = {
    Text = "Chaos Stitcher"
  },
  State_20023_WeaponDesc = {
    Text = "At the start of the battle, shuffle two Aliemus Regen cards into the deck."
  },
  State_20024_Desc = {
    Text = "Gain 1 \"Toxic Infusion\" that can apply [Arg1] Poison upon releasing Exaslt. At turn end, for every 3 \"Toxic Infusion\" cards in hand, synthesize 1 \"Toxic Outbreak\" that triggers Poison."
  },
  State_20024_Name = {
    Text = "State@Relic Mutation Tongue"
  },
  State_20026_Desc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand. Will trigger subsequent effects."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Retain>"
  },
  State_20026_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increases 100. Each time a card is played, Embryo Fusion increases 10%, and when HP is below 25%, the increase is 20%. This effect can trigger up to 10 times per turn."
  },
  State_20028_Name = {
    Text = "State@Chrono Pendulum Corruption"
  },
  State_20029_Desc = {
    Text = "Gain 1 \"Toxic Infusion\" that can apply [Arg1] Poison upon releasing Exaslt. At turn end, for every 3 \"Toxic Infusion\" cards in hand, synthesize 1 \"Toxic Outbreak\" that triggers Poison."
  },
  State_20029_Name = {
    Text = "State@Relic Mutation Tongue"
  },
  State_20035_Name = {
    Text = "State@Chrono Pendulum Asleep"
  },
  State_20038_Name = {
    Text = "Chaos Symbiote"
  },
  State_20038_WeaponDesc = {
    Text = "When the team consists of Chaos and other classes, all Awakeners obtain 20 Aliemus at the start of their turn."
  },
  State_20039_Desc = {
    Text = "If kept in hand during discard phase, Exhaust. Won't reappear."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:Fleeting>"
  },
  State_20039_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_20040_Name = {
    Text = "State@Chrono Pendulum Awake Count"
  },
  State_20041_Desc = {
    Text = "At turn start, gain 1 Arithmetica and draw 1 card for each enemy. When an enemy is defeated by Active DMG, deal double the excess DMG as Bleeding to other enemies."
  },
  State_20041_Name = {
    Text = "Mutated Mob Song"
  },
  State_20042_Desc = {
    Text = "Deal 25% more DMG to enemies with debuffs, and gain 20 Aliemus upon killing them."
  },
  State_20044_Desc = {
    Text = "Increases the Weakness effect by 10%. Adds 1 stack of Weakness to all enemies every 3 turns."
  },
  State_20045_Desc = {
    Text = "At the start of next turn, select any 3 cards from your deck and add them to your hand."
  },
  State_20045_Name = {
    Text = "Chrono Pendulum Dances"
  },
  State_20306_Name = {
    Text = "Relic Arcane Gloves"
  },
  State_20419_Desc = {
    Text = "Apply [Arg1] stacks of Poison for each hit. If triggered 25 times during this battle, immediately apply Poison to all enemies."
  },
  State_20425_Desc = {
    Text = "At turn start, gain [Layer] Temporary <PowerIconKeywords:STR> and Shield."
  },
  State_20425_Name = {
    Text = "Bloodthirsty Devourer"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Each turn, the first \"Skill\" consumes [StateArg1] less Arithmetica."
  },
  State_20600_Name = {Text = "Epiphany"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:\"Strike\" DMG + [StateArg1]%. Gain [StateArg2] stacks of <EnergyStorageKeywords:Charge> for each attack received."
  },
  State_20601_Name = {Text = "Gluttony"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" can select a target and apply [StateArg1] stacks of <PVPSlowKeywords:Stagnation>. The effect doubles when triggered on the first target each turn."
  },
  State_20602_Name = {
    Text = "Hand of Oblivion"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant self <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20603_Name = {
    Text = "Aberrant Devour"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" restores <Heal:[Heal:StateArg1]> HP to self."
  },
  State_20604_Name = {Text = "Suction"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped, <ComaKeywords:Fainted> self. Dispel all debuffs of allies before \"Exalt\"."
  },
  State_20605_Name = {
    Text = "Nobleman's Staff"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" grants the wielder <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20606_Name = {Text = "Frenzy"},
  State_20607_Desc = {
    Text = "\"Strike\" targets the enemy with the highest HP and Shield, inflicting <PVPBleedingKeywords:Bleed> stacks equal to [StateArg1]% of DMG dealt."
  },
  State_20607_Name = {
    Text = "Sever and Scar"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After using a \"Skill\" and at turn end, gain <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20608_Name = {Text = "Whisper"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: The Aliemus gained from losing HP is doubled."
  },
  State_20609_Name = {
    Text = "Dream of the Sea"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" DMG increased by [StateArg1]%, After \"Exalt\", grant <PVPPowerIconKeywords:Strength>+ [StateArg2] and increases \"Strike\" DMG by an additional [StateArg3]%, up to 100%."
  },
  State_20610_Name = {
    Text = "Celestial Beast"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\", and at turn end, restores <Heal:[Heal:StateArg1]> HP to the ally with the most lost HP."
  },
  State_20611_Name = {Text = "Hope"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, grant the ally with the lowest Aliemus <Energy:[Energy:StateArg1]> Aliemus and heal the ally with the most lost HP <Heal:[Heal:StateArg2]> HP."
  },
  State_20612_Name = {
    Text = "Merciful Nurturing"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, grant other allies <Block:[Block:StateArg1]> Shield."
  },
  State_20613_Name = {
    Text = "The Land of Nonexistence"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, obtain [StateArg1] Temporary <PVPRetaliateIconKeywords:Counter>."
  },
  State_20614_Name = {
    Text = "Core Meltdown"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: The first \"Strike\" each turn deals an additional [StateArg1] DMG and inflicts the same amount of <PVPMethysisKeywords:Poison>."
  },
  State_20615_Name = {
    Text = "Cursed Binding"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gain <Energy:[Energy:StateArg1]> Aliemus at turn end."
  },
  State_20616_Name = {
    Text = "Spring in Yakutsk"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, gain a <Block:[Block:StateArg1]> Shield."
  },
  State_20617_Name = {Text = "Exile"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Before \"Exalt\", make both sides discard all their hand cards then draw a number of cards equal to the amount discarded +1."
  },
  State_20618_Name = {
    Text = "Happy Magic Show"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gain <Energy:[Energy:StateArg1]> Aliemus when equipped. When an allied Awakener uses Exalt, gain <DelayKeywords:Delay>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Hymn of the Sovereign"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Hand Limit + [StateArg2]. At turn end, gain random copies of [StateArg1] \"Skills\" from hands."
  },
  State_20620_Name = {
    Text = "Moment of Reunion"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Before \"Exalt\", <StrengthenKeywords:Enhance> and <ReinforceKeywords:Fortress> self."
  },
  State_20621_Name = {
    Text = "Grace Through Pain"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, gain <Energy:[Energy:StateArg1]> Aliemus. Consume all remaining Arithmetica, gain <Energy:[Energy:StateArg3]> more Aliemus for every [StateArg2] Arithmetica consumed."
  },
  State_20622_Name = {
    Text = "Shrouded Birth"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", draw [StateArg1] cards."
  },
  State_20623_Name = {Text = "Emerge"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", draw [StateArg1] cards and places [StateArg2] copies into the hand."
  },
  State_20624_Name = {
    Text = "Hour of Fortune"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", <DelayKeywords:Delay>: Restore <Heal:[Heal:StateArg1]> HP to all allied units."
  },
  State_20625_Name = {
    Text = "The Glutton's Tale"
  },
  State_20626_Desc = {
    Text = "<ReinforceKeywords:Wheel of Destiny>: \"Strike\" DMG +[StateArg1]% and <PVPWeaponKeywords:Fortress> self."
  },
  State_20626_Name = {
    Text = "Will Unyielding"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, restore <Heal:[Heal:StateArg1]> HP to all allies."
  },
  State_20627_Name = {Text = "Blessing"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant other allies <Energy:[Energy:StateArg1]> Aliemus. If this grants an ally more Aliemus than they need to activate their Exalt, the wielder gains half of the excess amount."
  },
  State_20628_Name = {
    Text = "Duty's Gravitas"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: The Damage, Healing, and Shielding effects of \"Exalt\" are increased by [StateArg1]%."
  },
  State_20629_Name = {
    Text = "By Rose Alone"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, gain a <Block:[Block:StateArg1]> Shield and <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20630_Name = {
    Text = "Winter's Requiem"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" inflicts <PVPVulnerabilityIconKeywords:Vulnerable> on the target. At turn end, gain [StateArg1] <EnergyStorageKeywords:Charge>."
  },
  State_20631_Name = {
    Text = "Critical Point"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Hand Limit +[StateArg1]."
  },
  State_20632_Name = {
    Text = "Memory Spiral"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When the wielder is actively attacked for the first time each turn, deal [StateArg1] DMG to the attacker, <PVPEntanglementKeywords:Entwined>."
  },
  State_20633_Name = {
    Text = "Pale Descendant"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Damage, Healing, and Shield from \"Strike\", \"Skill\", and \"Exalt\" are increased by [DescArg1]%. <PVPGrowthKeywords:Growth>: [StateArg2]%."
  },
  State_20634_Name = {Text = "Sunfall"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Grant <StrengthenKeywords:Enhance> to all allies before \"Exalt\"."
  },
  State_20635_Name = {
    Text = "Power of the Pious"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, gain a <PVPDerivativeCardKeywords_2:\"Illusion\">. For every two <PVPDerivativeCardKeywords_2:\"Illusion\"> in your hand, merge them into a <PVPDerivativeCardKeywords_12:\"Tiny Wish\">."
  },
  State_20636_Name = {Text = "Aged"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At the end of your turn, Shuffle [StateArg1] <PVPDerivativeCardKeywords_11:\"Unequal Exchange\"> into your Draw Pile."
  },
  State_20637_Name = {
    Text = "Data is Flesh"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, the wielder deals [StateArg1] DMG to the enemy with the highest HP and Shield, <PVPMethysisKeywords:Poison>."
  },
  State_20639_Name = {
    Text = "Gift of Decay"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped and at turn start, deal <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bleeding> DMG to all enemies. For each card in the target's hand, increase <PVPBleedingKeywords:Bleeding> DMG by +[StateArg2]."
  },
  State_20640_Name = {
    Text = "Bloody Feast"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Upon death, grant other allies [StateArg1] stacks of <PVPProtectiveKeywords:Barrier>."
  },
  State_20641_Name = {
    Text = "Analysis of Death"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:In Hand>: Whenever you play a card, this card transforms into a random \"Wheel of Destiny\" with -1 Arithmetica Cost."
  },
  State_20642_Name = {
    Text = "Birth of a Soul"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grants [StateArg1] Arithmetica."
  },
  State_20643_Name = {
    Text = "Memory Syndrome"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped, deal [StateArg2] DMG to self, <PVPEntanglementKeywords:Entwined>. For each fallen ally, <StrongEffectKeywords:Amplification> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "Treasured Rarity"
  },
  State_20645_Name = {
    Text = "Adventurer's Pack"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" DMG increases by [StateArg1]%, and \"Exalt\" heals self for <Heal:[Heal:StateArg2]> HP."
  },
  State_20646_Name = {
    Text = "Lullaby Devoured"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt,\" place [StateArg1] <PVPDerivativeCardKeywords_11:\"Unequal Exchange\"> into your hand."
  },
  State_20647_Name = {
    Text = "Amidst the Downpour"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn start, gains a positive <PVPWonderfulEffectKeywords:Marvelous Effect>. When the enemy uses \"Posse\" for the first time each turn, [StateArg1] \"Magnificent Spectacle\" cards are added to your hand."
  },
  State_20648_Name = {
    Text = "Silent Banquet"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", return the last played \"Skill\" from the previous turn to your hand; its Arithmetica Cost -1. If this type of Effect is triggered multiple times, it traces back further."
  },
  State_20649_Name = {
    Text = "Rewinding Time"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped, inflict <ComaKeywords:Fainted> on self. Dispel all buffs on enemies before \"Exalt\"."
  },
  State_20650_Name = {Text = "Delirium"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, draw [StateArg1] cards."
  },
  State_20651_Name = {Text = "Greed"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", deal [StateArg1] DMG to all enemies, <DisarmKeywords:Paralysis>."
  },
  State_20652_Name = {Text = "Punishment"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" can select a target and deduct <Energy:[Energy:StateArg1]> Aliemus from that target."
  },
  State_20653_Name = {
    Text = "Drifting in Desire"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn start, <PVPSeriousInjuryKeywords:Blighten> yourself. At turn end, <ReinforceKeywords:Fortress> yourself."
  },
  State_20654_Name = {
    Text = "Queen's Edict"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:\"Strike\" DMG + [StateArg1]%, \"Strike\" can select targets."
  },
  State_20655_Name = {Text = "Favor"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Damage, Healing, and Shield effects from \"Skill\" are increased by [StateArg1]%. If there is no <PVPProtectiveKeywords:Barrier> after using \"Skill\", gain 1 stack."
  },
  State_20656_Name = {
    Text = "The Last Verse"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Each turn, when the opponent plays the [StateArg1]th \"Skill\", place a copy with its Arithmetica Cost reduced by [StateArg2] into hand."
  },
  State_20657_Name = {Text = "Insight"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" generates [StateArg1] Arithmetica for each target hit."
  },
  State_20658_Name = {
    Text = "Song of the Bound"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Upon death, <PVPResurrectionKeywords:Revive> at the start of next turn with <Heal:[Heal:StateArg1]> HP and <Block:[Block:StateArg2]> Shield, destroying this \"Wheel of Destiny\"."
  },
  State_20659_Name = {Text = "Vitality"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt,\" all allies gain <Block:[Block:StateArg1]> Shield."
  },
  State_20660_Name = {
    Text = "Mind Barrier"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", deal <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bleeding> DMG to all enemies."
  },
  State_20661_Name = {
    Text = "Path Forsaken"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, deal [StateArg1] * Arithmetica Limit <PVPBleedingKeywords:Bleeding> DMG to the enemy with the lowest HP and Shield."
  },
  State_20662_Name = {
    Text = "Cloaked in the Night"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Dispel own debuffs and gain [StateArg1] stacks of <EnergyStorageKeywords:Charge> before \"Exalt\"."
  },
  State_20663_Name = {
    Text = "Chains Unbound"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\" applies <ReinforceKeywords:Fortress> to self."
  },
  State_20664_Name = {
    Text = "A Knight's Vow"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: If there are no debuffs to dispel, restore <Heal:[Heal:StateArg1]> HP. At turn end, <DelayKeywords:Delay>: Dispel own debuffs."
  },
  State_20665_Name = {
    Text = "Sail of Providence"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant [StateArg1] stacks of <PVPProtectiveKeywords:Barrier> to the ally with the lowest HP and Shield."
  },
  State_20666_Name = {
    Text = "To My Dearest Friend"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: The wielder's first \"Skill\" card played each turn has its DMG increased by [StateArg1]%."
  },
  State_20667_Name = {
    Text = "Blade of the Titan"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When our Awakener dies, deal <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bleeding> DMG to all enemy targets. When the wielder dies, deal additional <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Bleeding> Damage."
  },
  State_20668_Name = {
    Text = "Death of Ms. Coral"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped and at turn start, if there is no <PVPProtectiveKeywords:Barrier>, gain [StateArg1] stacks of <PVPProtectiveKeywords:Barrier>; otherwise, the cost of 1 highest-cost \"Skill\" card in hand -1."
  },
  State_20669_Name = {
    Text = "Tablet of Scriptures"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" inflicts <PVPSeriousInjuryKeywords:Serious Injury>, increasing DMG by [StateArg1]%, but causing the caster to lose half of the inflicted DMG as HP."
  },
  State_20670_Name = {
    Text = "Fin of Sorrow"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", restore <Heal:[Heal:StateArg1]> HP to self."
  },
  State_20671_Name = {
    Text = "Deathless Ascent"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, reduce the Arithmetica Cost of the card with the highest Arithmetica Cost in hand by [StateArg1]. <PrepareKeywords:Prepare>."
  },
  State_20672_Name = {
    Text = "Elevated Focus"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant self <Block:[Block:StateArg1]> Shield, and other allies <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Incalculable Factor"
  },
  State_20696_Name = {
    Text = "State@Fear of Giants"
  },
  State_20723_Desc = {
    Text = "Damage of \"Strike\" increased by [Layer]."
  },
  State_20723_Name = {
    Text = "Fixed DMG of Strike Cards increased"
  },
  State_20724_Desc = {
    Text = "Damage of \"Strike\" reduced by [Layer]."
  },
  State_20724_Name = {
    Text = "Fixed DMG of Strike Cards reduced"
  },
  State_20749_Desc = {
    Text = "Universal Trace Counter."
  },
  State_20758_Desc = {
    Text = "At the start of next turn, draw [Layer] cards."
  },
  State_20758_Name = {
    Text = "Delayed Draw"
  },
  State_20766_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_20802_Desc = {
    Text = "This card cannot be played."
  },
  State_20802_Name = {
    Text = "Cannot Play"
  },
  State_20803_Desc = {
    Text = "This card reduces Arithmetica Cost by 1. After using another card, this card transforms into a random Wheel of Destiny card."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:Birth of a Soul>"
  },
  State_20805_Desc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Retain>"
  },
  State_20806_Desc = {
    Text = "After playing, this card is removed from deck instead of discarded."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Exhaust>"
  },
  State_20820_Desc = {
    Text = "Revive at the start of next turn with [Layer] HP and [Layer] Shield."
  },
  State_20820_Name = {
    Text = "Delay Revival"
  },
  State_20851_Name = {Text = "Grant Card"},
  State_20981_Desc = {
    Text = "\"Crimson\" has been Roused, significantly increasing the DMG dealt."
  },
  State_20981_Name = {
    Text = "Uvhash Rouse!"
  },
  State_20981_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_20982_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_20982_Name = {Text = "Not Roused"},
  State_20988_Desc = {
    Text = "Starting with +80 Aliemus. Gain 20 Aliemus each turn."
  },
  State_20988_Name = {
    Text = "Daffodil: First Encounter"
  },
  State_20989_Desc = {
    Text = "Starting with +80 Aliemus. Gain 2 Arithmetica and 20 Aliemus per turn."
  },
  State_20989_Name = {
    Text = "Tulu: First Encounter"
  },
  State_21306_Desc = {
    Text = "Reset the combo each turn."
  },
  State_21306_Name = {
    Text = "Combo Reset"
  },
  State_21307_Desc = {
    Text = "Each stack increases the attack count by 1. Lose 1 stack per instance of DMG taken, with a minimum of 1 stack remaining, and lose all stacks at turn end."
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "At the start of next turn, gain [Layer] HP"
  },
  State_21342_Name = {
    Text = "Delayed Healing"
  },
  State_21345_Desc = {
    Text = "Before the Divine Descent Ritual starts, death will revive you, remove debuffs, grant immunity to Damage, and restore 30% HP. After the ceremony starts, death fully revives you, removes debuffs and Ritual Fixation, and summons two Kin."
  },
  State_21345_Name = {
    Text = "Ritual Fixation"
  },
  State_21358_Desc = {
    Text = "This player's hand size is unlimited."
  },
  State_21381_Name = {
    Text = "Seal Usage Count"
  },
  State_21385_Desc = {
    Text = "Decrease by 1 stack each time 1 HP is lost. When the number of stacks reduces to 0, the intention shifts to a high-Damage Exalt and removes the Petrify effect."
  },
  State_21385_Name = {
    Text = "Blood Frenzy"
  },
  State_21450_Desc = {
    Text = "At the start of next turn, remove all debuffs on self."
  },
  State_21450_Name = {
    Text = "Delay Purify"
  },
  State_21488_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_21492_Desc = {
    Text = "Damage increases by 50% on a Critical Hit."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Critical Hit>"
  },
  State_21546_Desc = {
    Text = "At the start of next turn, gain [Layer] Shield."
  },
  State_21546_Name = {
    Text = "Delayed Shield"
  },
  State_21547_Desc = {
    Text = "At turn start, retain half of your Shield."
  },
  State_21547_Name = {Text = "Resolute"},
  State_21548_Desc = {
    Text = "At the start of next turn, gain Enhance."
  },
  State_21548_Name = {
    Text = "Delay Enhance"
  },
  State_21580_Desc = {
    Text = "The Skull Hunter is tracking your movements. For each card drawn, the Skull Hunter gains [StateArg1] Temporary STR."
  },
  State_21580_Name = {Text = "Track"},
  State_21587_Name = {
    Text = "This turn, a new random Awakener has been found."
  },
  State_21590_Name = {
    Text = "Number of attempts to find a new Awakener"
  },
  State_21601_Name = {
    Text = "New Awakener Found"
  },
  State_21616_Desc = {
    Text = "After using Exalt, seal all Awakeners for one turn."
  },
  State_21616_Name = {
    Text = "Pathwalker's Remains"
  },
  State_21671_Name = {
    Text = "Deal Area Damage"
  },
  State_21688_Name = {
    Text = ", can be used 1 time"
  },
  State_21689_Name = {
    Text = ", can be used 2 times"
  },
  State_21720_Desc = {
    Text = "Also affects the Awakener behind the target. If none exists, only the target is affected."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Pierce>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After the wielder plays their first \"Skill\" each turn, shuffle a copy of it with Arithmetica Cost - [StateArg1] into the Draw Pile."
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Number of attempts to find a new Awakener"
  },
  State_21745_Name = {
    Text = "New Awakener Found"
  },
  State_21746_Name = {
    Text = "This turn, a new random Awakener has been found."
  },
  State_21747_Desc = {
    Text = "There are [Layer] Awakeners being Hunted, and for each card played by the Hunted Awakeners, \"Rampaging Skull Hunter\" accumulates 1 stack of the Hunting Mark."
  },
  State_21747_Name = {
    Text = "Hunting Ceremony"
  },
  State_21751_Desc = {
    Text = "Draw half the cards with Hunting Marks ([DescArg1]), and increase the number of Hunting Marks on \"Rampaging Skull Hunter\" by 1."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Hunted>"
  },
  State_21754_Desc = {
    Text = "Upon death, dispel all Temporary STR of \"Rampaging Skull Hunter\" and halve the stacks of its \"Hunting Mark\"."
  },
  State_21754_Name = {
    Text = "Temporary Relief"
  },
  State_21765_Desc = {
    Text = [[
Equip "Wheel of Destiny" to an Awakener to activate it.
If one is already equipped, the old Wheel is destroyed.
If the Awakener dies, the Wheel is destroyed.
Equipping to a dead Awakener destroys it, grants 1 Illusion, and refunds the cost.]]
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>"
  },
  State_21785_Name = {
    Text = "Battle Shout"
  },
  State_21787_Name = {
    Text = "Add Battle Shouts"
  },
  State_21826_Name = {
    Text = "\"The Child King begins his speech\""
  },
  State_21829_Name = {
    Text = "Deathrattle Effect"
  },
  State_21838_Name = {
    Text = "Opening Introduction"
  },
  State_21843_Name = {
    Text = "Apply State at the start"
  },
  State_21895_Name = {
    Text = "Opening Declaration"
  },
  State_21905_Desc = {
    Text = "\"Strike\" gains 2 Arithmetica and discards 1 random card; \"Defense\" draws 2 cards and loses 1 Arithmetica."
  },
  State_21928_Name = {Text = "Hint"},
  State_22054_Name = {
    Text = "Opening Declaration"
  },
  State_22055_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_22055_Name = {Text = "Not Roused"},
  State_22067_Desc = {
    Text = "At turn end, make 1 Tentacle attack [Layer] times."
  },
  State_22067_Name = {
    Text = "Tentacle Gathering"
  },
  State_22074_Desc = {
    Text = "Survive until the 7th turn to change intention to Stare, 8th turn or above to change intention to Desecrate"
  },
  State_22134_Desc = {
    Text = "Deal DMG to the target's Shield, HP, and Barrier simultaneously."
  },
  State_22134_Name = {
    Text = "<PVPPierceDamageKeywords:Pierce DMG>"
  },
  State_22157_Desc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into \"Current\" and \"Tide\" with equal HP."
  },
  State_22157_Name = {Text = "Split"},
  State_22204_Desc = {
    Text = "At turn start, gain [Layer]% Temporary Crit. Rate and Temporary Crit. DMG."
  },
  State_22204_Name = {
    Text = "Distant Melody"
  },
  State_22204_WeaponDesc = {
    Text = "until the start of next turn without losing HP, Crit. Rate +[StateArg1]%."
  },
  State_22210_Desc = {
    Text = "Arithmetica Cost +100, cannot use Strike, and cannot gain Aliemus."
  },
  State_22210_Name = {
    Text = "Super Stagnation"
  },
  State_22227_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_22229_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_22230_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_22238_Name = {
    Text = "Player Deathmatch"
  },
  State_22239_Name = {
    Text = "Activate Player Deathmatch"
  },
  State_22249_Desc = {
    Text = "At the start of next turn, draw [Layer] fewer cards."
  },
  State_22249_Name = {
    Text = "Unequal Exchange"
  },
  State_22300_Desc = {
    Text = "This \"Strike\" cannot be played."
  },
  State_22300_Name = {
    Text = "Disarm prevents the playing of Strike cards."
  },
  State_22303_Desc = {
    Text = "Each time you take DMG, a random card in hand gains a Temporary \"Stagnation\" state. After the Shield is broken, the \"Frost Shield\" state will be removed."
  },
  State_22303_Name = {
    Text = "Frost Shield"
  },
  State_22324_Desc = {
    Text = "For each stack, gain 1 additional attack this turn."
  },
  State_22324_Name = {
    Text = "Raging Waves Echo"
  },
  State_22325_Desc = {
    Text = "Each time attacked, gain [StateArg1] Temporary STR."
  },
  State_22325_Name = {
    Text = "Giant's Bloodline"
  },
  State_22326_Desc = {
    Text = "You're the target! After playing, the Seafarer Guard gains 1 stack of Temporary Madness and removes the Mark of Fury from this Command Card."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:Mark of Fury>"
  },
  State_22328_Desc = {
    Text = "Each time a Command Card with \"Mark of Fury\" is used, increase the attack count by 1 for this turn."
  },
  State_22328_Name = {
    Text = "Raging Waves Echo"
  },
  State_22334_Desc = {
    Text = "Each time a \"Strike\" card is played, place [StateArg1] \"Wounds\" on top of the Draw Pile."
  },
  State_22334_Name = {Text = "Trauma"},
  State_22404_Desc = {
    Text = "Shield generated in this battle are increased by [Layer]."
  },
  State_22404_Name = {Text = "Alert"},
  State_22405_Desc = {
    Text = "Increase Shield generation in this battle."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Alert>"
  },
  State_22702_Desc = {
    Text = "The first \"Card\" played each turn triggers an additional Effect."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Ambush>"
  },
  State_22706_Name = {Text = "Raid Mark"},
  State_22707_Desc = {
    Text = "After each turn of playing cards, mark you with an Ambush State."
  },
  State_22707_Name = {
    Text = "Ambush Trigger"
  },
  State_23405_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, gain STR equal to the current Counter stacks, restore HP, and fight with full power."
  },
  State_23405_Name = {Text = "Not Roused"},
  State_23406_Desc = {
    Text = "\"The Abyss Dweller\" gains [StateArg1] stacks of Counter at the end of each turn."
  },
  State_23406_Name = {
    Text = "Caecus Rouse!"
  },
  State_23512_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23514_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23515_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23516_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23517_Name = {
    Text = "Grant the player the BUFF"
  },
  State_23518_Desc = {
    Text = "Applies 2 turns of Vulnerable / Attack 1 more time/ Applies STR▼"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Intent Selection>"
  },
  State_23519_Name = {
    Text = "Intention 2b"
  },
  State_23520_Name = {
    Text = "Intention 2c"
  },
  State_23521_Name = {
    Text = "On discard, Exhaust and all Awakeners' Aliemus -[StateArg1]. Shuffle 5 \"Symptom\" Cards into the Draw Pile."
  },
  State_23522_Name = {
    Text = "On discard, Exhaust and all Awakeners' Aliemus -[StateArg1]."
  },
  State_23524_Name = {
    Text = "Intention 3a"
  },
  State_23525_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_23525_Name = {Text = "Not Roused"},
  State_23526_Name = {
    Text = "Intention 2a"
  },
  State_23527_Name = {
    Text = "Intention 3c"
  },
  State_23528_Name = {
    Text = "Intention 3b"
  },
  State_23529_Desc = {
    Text = "Increase Strength / Deal Extra DMG / Gain Shield"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Intent Selection>"
  },
  State_23530_Desc = {
    Text = "Using \"Thousand Mirage\" requires two intention choices. If discarded, all Awakeners lose 20 Aliemus, and 5 \"Symptom\" cards are shuffled into your Draw Pile."
  },
  State_23530_Name = {
    Text = "Daffodil Rouse!"
  },
  State_23531_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23532_Name = {
    Text = "Grant Thousand Mirage"
  },
  State_23533_Desc = {
    Text = "Inflict Symptom Card / Apply Bleeding / Reduce Aliemus"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Intent Selection>"
  },
  State_23534_Name = {
    Text = "Intention 1a"
  },
  State_23535_Name = {
    Text = "Intention 1c"
  },
  State_23536_Name = {
    Text = "Intention 1b"
  },
  State_23612_Desc = {
    Text = "Decrease by 1 stack each time 1 HP is lost. When the number of stacks reduces to 0, the intention shifts to a high-Damage Exalt and removes the Petrify effect."
  },
  State_23612_Name = {
    Text = "Blood Frenzy: Finale"
  },
  State_23726_Desc = {
    Text = "Prevent the Awakener from dying once before the next turn, up to 1 stack."
  },
  State_23726_Name = {
    Text = "Death Resistance"
  },
  State_23732_Desc = {
    Text = "Until the start of next turn, gain [Layer] stacks of <PainWord:Endure> for each attack received."
  },
  State_23732_Name = {
    Text = "Forbidden Swamp"
  },
  State_23736_Name = {
    Text = "Cards Drawn This Turn"
  },
  State_23737_Name = {
    Text = "Draw Count Record"
  },
  State_23741_Name = {
    Text = "Apply Draw Record"
  },
  State_23744_Desc = {
    Text = "If there are no \"Dead\" on the field, summon 1 \"Dead\" at turn start, and HP will increase with each summon."
  },
  State_23744_Name = {
    Text = "Summon of the Dead"
  },
  State_23747_Name = {Text = "Enhance HP"},
  State_23748_Name = {
    Text = "Summon Count"
  },
  State_23769_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_23769_Name = {Text = "Not Roused"},
  State_23771_Desc = {
    Text = "\"The Sorcerer\" has been Roused. Beware of the clones created by her \"Phantasm\". For each card played by the opponent after her Rouse, Casiah gains 1 stack of \"Phantasm\"."
  },
  State_23771_Name = {
    Text = "Casiah Rouse!"
  },
  State_23771_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_23782_Desc = {
    Text = "After obtaining 10 stacks of Phantasm, clear the \"Phantasm\" stack count and summon 1 phantom in front, with a maximum of 2 phantoms existing. The phantom will carry 3 stacks of <ParcloseIconKeywords:Barrier> when summoned."
  },
  State_23782_Name = {Text = "Phantasm"},
  State_23786_Name = {
    Text = "State@Awakener Casiah Telekinesis"
  },
  State_23787_Name = {
    Text = "State@Awakener Casiah@Telekinesis@Draw Reduction"
  },
  State_23788_Desc = {
    Text = "At the start of turn 3, add 1 card \"Echoes of the Past—Discard all cards, reset current HP and Shield to the state at the end of the previous turn. Retain, Exhaust.\" to your hand."
  },
  State_23791_Name = {
    Text = "Opening Tip"
  },
  State_23823_Name = {Text = "Bomb 1"},
  State_23825_Name = {
    Text = "State@Awakener Casiah@Poof"
  },
  State_23827_Desc = {
    Text = "After playing, lose [DescArg1] Max HP. The great magician gains 1 \"Ego Boost\" stack this turn."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Cheers>"
  },
  State_23828_Desc = {
    Text = "The great magician is now thoroughly enjoying her performance. For each stack of \"Ego Boost\", the Skill effect and STR of her skills are reduced by [DescArg1], up to 5 stacks."
  },
  State_23828_Name = {Text = "Ego Boost"},
  State_23871_Desc = {
    Text = "Increasing Max HP does not recover current HP. Decreasing Max HP still removes excess current HP. Your adjusted Max HP has a minimum of 1 and does not reset upon death."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:Max HP>"
  },
  State_23934_Name = {
    Text = "State@Telekinesis Hand Card Monitor"
  },
  State_23935_Name = {
    Text = "State@Awakener Casiah@Telekinesis Active"
  },
  State_2393_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_2393_Name = {Text = "Not Roused"},
  State_2394_Name = {
    Text = "Scarlet Strength Enlighten Boost"
  },
  State_2395_Name = {
    Text = "Accessory: Banquet of the Distant"
  },
  State_2395_WeaponDesc = {
    Text = "\"Defense\" increases shield by 30%. If the wielder has more than 15% Sigil Yield, \"Defense\" grants an additional 30% shield."
  },
  State_2396_Desc = {
    Text = "Crit. DMG +20%. Guaranteed Critical Hits against Shielded enemies."
  },
  State_2398_Desc = {
    Text = "Taking DMG grants [Layer] Shield, which increases with each hit and restores at turn end."
  },
  State_2398_Name = {
    Text = "Dimensional Barrier"
  },
  State_2398_WeaponDesc = {
    Text = "Active DMG taken is increased by [Layer]. Each time DMG is taken, the Dissolution Wound expands and recovers at the start of the Turn."
  },
  State_2399_Desc = {
    Text = "After restoring HP, all Awakeners gain 3 Aliemus. For every 5th HP restoration, Exalt DMG is increased by [Arg1] for this battle."
  },
  State_2400_Desc = {
    Text = "Increase the Tentacle Limit by 1. When HP is below 50%, increase Tentacle DMG by [StateArg1]."
  },
  State_2400_Name = {
    Text = "Creation Relic of the Past"
  },
  State_2400_WeaponDesc = {
    Text = "Tentacle Limit increased by 1. When HP is below 50%, Tentacle DMG increases by [StateArg1]."
  },
  State_2401_Desc = {
    Text = "Add the top card of the Discard Pile to your hand at turn start."
  },
  State_2402_Desc = {
    Text = "At turn start, gain [Arg1] Temporary STR for each Card in Ultra Space this turn."
  },
  State_2403_Desc = {
    Text = "Shield increased by [Layer] in this battle."
  },
  State_2403_Name = {Text = "Alert"},
  State_2403_WeaponDesc = {
    Text = "Shield Generation increased by [Layer] in this battle."
  },
  State_2404_Desc = {
    Text = "Remove 1 Symptom Card upon pickup. Lucky Orison rate increases by 50%."
  },
  State_2405_Desc = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2405_Name = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2405_WeaponDesc = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2406_Desc = {
    Text = "When you deplete the last 1 Arithmetica, gain 2 Arithmetica. Maximum 2 triggers per turn."
  },
  State_2407_Name = {
    Text = "Observations"
  },
  State_2409_Desc = {
    Text = "This turn, each [Strike] card played reduces Arithmetica Cost by 1."
  },
  State_2409_Name = {
    Text = "Blade of Defiance"
  },
  State_2409_WeaponDesc = {
    Text = "This turn, each played [Strike] card reduces Arithmetica Cost by 1."
  },
  State_2410_Desc = {
    Text = "Cannot act for 1 turn. Petrified enemies can't be Petrified again."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:Petrify>"
  },
  State_2410_WeaponDesc = {
    Text = "Stun the monster for one turn."
  },
  State_2411_Desc = {
    Text = "Inflict [Layer] stacks of Bleed on your team at turn end."
  },
  State_2411_Name = {
    Text = "Blood Lantern"
  },
  State_2411_WeaponDesc = {
    Text = "At turn end, apply [Layer] stacks of Bleed to your team."
  },
  State_2412_Desc = {
    Text = "Double the DMG dealt next turn."
  },
  State_2412_Name = {
    Text = "Surviving Impasse"
  },
  State_2412_WeaponDesc = {
    Text = "Double the DMG dealt next turn."
  },
  State_2413_Desc = {
    Text = "Aliemus gained from Strike and Defense is reduced by [Layer] %."
  },
  State_2413_Name = {Text = "Void"},
  State_2413_WeaponDesc = {
    Text = "Gain [StateArg1]% Aliemus from Strike and Defense."
  },
  State_2415_Desc = {
    Text = "If you took DMG last turn, gain immunity for 1 turn at the start of this turn."
  },
  State_2415_Name = {Text = "Adapt"},
  State_2415_WeaponDesc = {
    Text = "If you took DMG last turn, obtain immunity for 1 turn at the start of this turn."
  },
  State_2416_Desc = {
    Text = "The summoned monsters' HP and DMG are doubled."
  },
  State_2416_Name = {
    Text = "\"Wax Sculpture World\""
  },
  State_2416_WeaponDesc = {
    Text = "The HP and DMG of the monsters it summons are doubled."
  },
  State_24174_Desc = {
    Text = "This Awakener will not have its HP drop below 1 due to Damage."
  },
  State_24174_Name = {
    Text = "Death Immunity"
  },
  State_2418_Desc = {
    Text = "[Exalt] grants 30 Aliemus."
  },
  State_2418_Name = {
    Text = "Veil of the Alienated God"
  },
  State_2418_WeaponDesc = {
    Text = "[Exalt] grants 30 Aliemus."
  },
  State_2419_Name = {
    Text = "Relic White Mirror"
  },
  State_2420_Desc = {
    Text = "This turn, each [Defense] card played reduces Arithmetica Cost by 1."
  },
  State_2420_Name = {
    Text = "Precision Slash"
  },
  State_2420_WeaponDesc = {
    Text = "This turn, each [Defense] card played reduces Arithmetica Cost by 1."
  },
  State_24210_Desc = {
    Text = "This turn, the God King's Tentacle attack targets all enemies"
  },
  State_24210_Name = {
    Text = "Divine Limb: Posse"
  },
  State_24211_Desc = {
    Text = [[

At turn end, deal [DescArg4] instances of [DescArg2] DMG to front-row enemies. If an enemy is killed, the DMG increases by [DescArg3] points, up to 5 times (currently [DescArg6] times).
Each time the Awakener uses Exalt, an additional attack will be triggered this turn.
After the Keeper uses Posse, the attack target for this turn will change to all enemies. If it's a Boss Battle, the DMG dealt by "Divine Limb" will also +[DescArg5] points.]]
  },
  State_24211_Name = {
    Text = "Divine Limb"
  },
  State_24213_Name = {
    Text = "If this card is in your hand, gain 150 Keyflare at turn end."
  },
  State_24214_Desc = {
    Text = "At turn end, deal [DescArg2] DMG to enemies in the front row."
  },
  State_24214_Name = {
    Text = "Divine Limb"
  },
  State_24215_Desc = {
    Text = "At turn end, deal [DescArg2] DMG to front row enemies. If an enemy is killed, increase this DMG by [DescArg3], up to 5 times (currently [DescArg4] times)."
  },
  State_24215_Name = {
    Text = "Divine Limb"
  },
  State_24217_Name = {
    Text = "Dispel self <VulnerabilityIconKeywords:Vulnerable>, <WeaknessIconKeywords:Weakness>, and <FragileIconKeywords:Fragile> states"
  },
  State_24220_Name = {
    Text = "Gain [DescArg1] Shield Points"
  },
  State_24222_Desc = {
    Text = [[
At turn end, deal [DescArg4] instances of [DescArg2] DMG to front-row enemies. If an enemy is killed, the DMG increases by [DescArg3] points, up to 5 times (currently [DescArg5] times).
Each time an Awakener uses Exalt, perform an additional attack this turn.
Each time a Keeper uses Posse this turn, the attack targets all enemies.]]
  },
  State_24222_Name = {
    Text = "Divine Limb"
  },
  State_24223_Desc = {
    Text = [[
At turn end, deal [DescArg2] DMG to the front row enemies. If an enemy is killed, increase this DMG by [DescArg3], up to 5 times (currently [DescArg4] times).
Each time the Keeper uses Posse, change the target of this turn's attacks to all enemies.]]
  },
  State_24223_Name = {
    Text = "Divine Limb"
  },
  State_24224_Desc = {
    Text = [[
After each turn, deal [DescArg4] hits of [DescArg2] DMG to the front row enemies. If an enemy is killed, the DMG increases by [DescArg3] points, up to 5 times (currently [DescArg5] times).
Each time an Awakener Exalts this turn, perform an additional attack.]]
  },
  State_24224_Name = {
    Text = "Divine Limb"
  },
  State_24226_Desc = {
    Text = [[

At turn end, deal [DescArg4] instances of [DescArg2] DMG to the front row enemies. If an enemy is killed, the DMG increases by [DescArg3] points, up to 5 times (currently [DescArg6] times).
Each time the Awakener uses Exalt, an additional attack will be triggered this turn.
In a Boss Battle, each time the Keeper uses Posse, the DMG of the "Divine Limb" increases by [DescArg5] points.]]
  },
  State_24226_Name = {
    Text = "Divine Limb"
  },
  State_24227_Desc = {
    Text = [[

At turn end, deal [DescArg2] DMG to front row enemies. If an enemy is killed, the DMG increases by [DescArg3] points, up to 5 times (currently [DescArg5] times).
After the Keeper uses the Posse, the attack target for this turn will change to all enemies. If it's a Boss Battle, the DMG dealt by the "Divine Limb" will also +[DescArg4] points.]]
  },
  State_24227_Name = {
    Text = "Divine Limb"
  },
  State_2422_Desc = {
    Text = "When played, gain <Block:[StateArg1]> Shield."
  },
  State_2422_Name = {
    Text = "<Rune_6:Bastion>"
  },
  State_24245_Desc = {
    Text = "At turn end, revive all \"Hydra\" kin. Each time a kin dies, reduce by 1 stack; if the stacks reach 0, \"Hydra\" will transform for the final battle."
  },
  State_24245_Name = {
    Text = "Serpent Manipulation"
  },
  State_24246_Desc = {
    Text = "Increase instances of DMG dealt by [Layer]."
  },
  State_24246_Name = {Text = "Madness"},
  State_24247_Desc = {
    Text = "Damage taken is reduced by 90%. If there are no stacks of \"Serpent Manipulation\" at turn start, remove this state."
  },
  State_24247_Name = {
    Text = "Serpentine Barrier"
  },
  State_2425_Desc = {
    Text = "When played, Exhaust. If it is a Command Card, its DMG and Defense will be increased by 2 times."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Dissolve>"
  },
  State_2426_Desc = {
    Text = "The first card you play each turn triggers an additional time, but you can play up to 4 cards per turn."
  },
  State_2427_Name = {
    Text = "State@Silver Key of Illusion: Blood Abyss Heart Counter"
  },
  State_2428_Desc = {
    Text = "The number of <ParcloseIconKeywords:Barriers> from the Flower of Evil increases by [Layer] levels."
  },
  State_2428_Name = {
    Text = "Grievance Barrier"
  },
  State_2428_WeaponDesc = {
    Text = "The quantity of Evil Blossom Barriers has increased by [Layer] stacks."
  },
  State_24292_Name = {
    Text = "Back Row Move Forward"
  },
  State_24293_Name = {
    Text = "Move the Front Row Back"
  },
  State_2429_Desc = {
    Text = "Reduce all DMG dealt by [Layer]%."
  },
  State_2429_Name = {
    Text = "Temporary DMG Reduction"
  },
  State_2429_WeaponDesc = {
    Text = "All DMG dealt is reduced by [Layer]%."
  },
  State_2430_Desc = {
    Text = "At the start of battle, all allies gain 3 stacks of [Waxed Armor]. At turn end, it inflicts [Arg1] stacks of Bleeding on your team."
  },
  State_2430_Name = {
    Text = "\"Wax Gentleman\""
  },
  State_2430_WeaponDesc = {
    Text = "At the start of battle, all allies obtain 3 stacks of [Waxed Armor]. At turn end, it inflicts [Arg1] stacks of Bleed on your team."
  },
  State_2431_Desc = {
    Text = "Team Unique: The wielder's Shield and HP Recovery increase by <WeaponEffect_Num:[StateArg1]%> of their CON. The wielder's Counter dealt +<WeaponEffect_Num:[StateArg3]%>. After playing \"Defense\", gain <WeaponEffect_Num:Counter> equal to <RetaliateIconKeywords:[StateArg4]%> of their DEF. At the start of battle, gain <WeaponEffect_Num:STR> equal to <PowerIconKeywords:[StateArg2]%> of their CON. If the current realm is \"Aequor, \" gain additional Tentacle DMG of the same amount."
  },
  State_2431_WeaponDesc = {
    Text = "The Shield Generation and HP Recovery increase by <WeaponEffect_Num:[DescArg1]>. The wielder's Counter increases by <WeaponEffect_Num:[StateArg3]>. After playing \"Defense,\" gain <WeaponEffect_Num:[Counterattack:DescArg3]> stacks of <RetaliateIconKeywords:Counter>. At the start of battle, gain <WeaponEffect_Num:[Power:DescArg2]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" gain additional Tentacle DMG of the same amount."
  },
  State_2432_Desc = {
    Text = "All DMG taken +50%, remove 1 stack at turn end."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:Vulnerable>"
  },
  State_2432_WeaponDesc = {
    Text = "All DMG taken is increased by 50%."
  },
  State_2433_Desc = {
    Text = "Gain [Layer] STR at the end of each turn."
  },
  State_2433_Name = {Text = "Anger"},
  State_2434_Name = {
    Text = "Accessory: Ring of Room 36"
  },
  State_2434_WeaponDesc = {
    Text = "When the wielder's card is drawn, its Arithmetica randomly changes between 0 and 3."
  },
  State_2435_Desc = {Text = "Event 19_2"},
  State_2435_Name = {Text = "Event 19_2"},
  State_2435_WeaponDesc = {Text = "Event 19_2"},
  State_2436_Desc = {
    Text = "The Strength and Shield gained are reduced by 50% for [Layer] turns."
  },
  State_2436_Name = {
    Text = "Temporary Curse"
  },
  State_2436_WeaponDesc = {
    Text = "Before the end of your turn, immune to buff effects applied to self."
  },
  State_2437_Desc = {Text = "—"},
  State_2437_WeaponDesc = {Text = "—"},
  State_2438_Desc = {
    Text = "State@Relic Silver Differential Engine Count"
  },
  State_2438_Name = {
    Text = "State@Relic Silver Differential Engine Count"
  },
  State_2438_WeaponDesc = {
    Text = "State@Relic Silver Differential Engine Count"
  },
  State_2440_Name = {
    Text = "Draw 1 cards."
  },
  State_2441_Name = {
    Text = "Obtain 1 Arithmetica."
  },
  State_2442_Name = {
    Text = "Inflict <VulnerabilityIconKeywords:Vulnerable> on all enemies for 1 stack"
  },
  State_2443_Name = {
    Text = "Inflict <WeaknessIconKeywords:Weakness> on all enemies for 1 stack"
  },
  State_2444_Name = {
    Text = "Gain <Energy:[DescArg1]> Aliemus"
  },
  State_2445_Name = {
    Text = "other Awakeners gain <Energy:[DescArg1]> Aliemus"
  },
  State_2446_Name = {
    Text = "Add 1 <DerivativeCardKeywords_4:\"Insight\"> to your Draw Pile."
  },
  State_2447_Desc = {
    Text = "Team Unique: The wielder's Command Card Crit. Rate and Crit. DMG, Shield Generation, HP Recovery, Aliemus, and Strength are increased by <WeaponEffect_Num:[StateArg1]%>. If the current realm is \"Ultra\", gain <WeaponEffect_Num:[StateArg2]> Keyflare after releasing \"Annihilation\". After entering the Ultra Round, the next Posse is released twice this turn."
  },
  State_2447_WeaponDesc = {
    Text = "The wielder's Command Card Crit. Rate and Crit. DMG, Shield Generation, HP Recovery, Aliemus, and Strength are increased by <WeaponEffect_Num:[StateArg1]%>. If the current realm is \"Ultra\", gain <WeaponEffect_Num:[StateArg2]> Keyflare after releasing \"Annihilation\". After entering the Ultra Round, the next Posse is released twice this turn."
  },
  State_2448_Desc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Retain>"
  },
  State_2449_Desc = {
    Text = "Gain [Layer] Shield after receiving actual Damage."
  },
  State_2449_Name = {Text = "Buffer"},
  State_2449_WeaponDesc = {
    Text = "Obtain [Layer] Shield after receiving actual Damage."
  },
  State_2450_Desc = {
    Text = "\"Strike\" guarantees a Critical Hit. Crit. DMG increased by 50%."
  },
  State_2451_Desc = {
    Text = "At turn end, other allies gain [Layer] STR."
  },
  State_2451_Name = {
    Text = "\"Flame of Enlightenment\""
  },
  State_2452_Desc = {
    Text = "When played, gain [StateArg1] <PowerIconKeywords:STR> after its effects resolve."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Adv. Might>"
  },
  State_2453_Name = {
    Text = "Accessory: Photosynthesis Ritual"
  },
  State_2453_WeaponDesc = {
    Text = "At the start of the battle, all of the wielder's cards obtain Retain."
  },
  State_2454_Desc = {
    Text = "After playing, this card is removed from deck instead of discarded."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Exhaust>"
  },
  State_2454_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_24556_Name = {
    Text = "State@Grand Magician Houdini@Lucky Audience Cheers Added"
  },
  State_2455_Name = {
    Text = "State @ Blue Flame Dancer Enlighten 7"
  },
  State_24560_Desc = {
    Text = "Each time you use a Posse, Ramona: Timeworn gains a Temporary 25% increase in Crit. Rate and Crit. DMG."
  },
  State_24560_Name = {
    Text = "Klein Bottle Voyager"
  },
  State_24562_Desc = {
    Text = "Gain 1 stack of Negentropy at turn end."
  },
  State_24562_Name = {
    Text = "Penrose Pilgrim"
  },
  State_24564_Desc = {
    Text = "With 3 Negentropy stacks, using Ramona: Timeworn's Command Cards consumes all stacks and triggers the extra Loop effect. (Max 3 stacks)"
  },
  State_24564_Name = {Text = "Negentropy"},
  State_2456_Name = {
    Text = "State @ Blue Flame Dancer Enlighten 15"
  },
  State_2457_Name = {
    Text = "Draw 1 cards."
  },
  State_24584_Name = {
    Text = "State@N's Clone@Whisper1 State Switch"
  },
  State_2458_Name = {
    Text = "State@Accessory Crimson Embrace Effect Count"
  },
  State_24593_Desc = {
    Text = "When the number of stacks is 0, change the intention to \"Black Summoning\". At turn end, it will decrease by 1 stack, with a maximum of 4 stacks."
  },
  State_24593_Name = {Text = "Chaos"},
  State_24595_Desc = {
    Text = "Upon death, immediately reduce \"N\" by 1 stack of \"Chaos\"."
  },
  State_24595_Name = {Text = "Diffuse"},
  State_24596_Desc = {
    Text = "When summoning a clone of \"N\", summon an additional clone for each stack of \"Darkness\"."
  },
  State_24596_Name = {Text = "Darkness"},
  State_2459_Name = {
    Text = "Inflict [Layer] turns of Weakness on all enemies"
  },
  State_2460_Desc = {
    Text = "Team Unique: The wielder's Base DMG, <IntoxicationIconKeywords:Poison>, and <RetaliateIconKeywords:Counter> are increased by <WeaponEffect_Num:[StateArg1]%>. Crit. Rate and Crit. DMG are increased by <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2460_WeaponDesc = {
    Text = "Wielder's Base DMG, <IntoxicationIconKeywords:Poison>, and <RetaliateIconKeywords:Counter> are increased by <WeaponEffect_Num:[StateArg1]%>. Crit. Rate and Crit. DMG are increased by <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2461_Desc = {
    Text = "In this battle, when receiving Fatal DMG, resurrect, recover [Layer] HP, and grant all Awakeners [StateArg1] Aliemus. This effect cannot be dispelled."
  },
  State_2461_Name = {
    Text = "Undying Bird of Paradise"
  },
  State_2463_Desc = {
    Text = "At the start of battle, Embryo Fusion +20%. For each Awakener with maximum Aliemus, Embryo Fusion is increased by an additional +20%."
  },
  State_24640_Desc = {
    Text = "At the start of battle, Embryo Fusion +25%. Each time Death Resistance is triggered, Embryo Fusion +25%. For each instance of DMG Sorel deals this turn, the DMG she deals this turn increases by 3% of her Attack."
  },
  State_24640_Name = {
    Text = "Crown Jewel"
  },
  State_2464_Desc = {
    Text = "Card Arithmetica Increase"
  },
  State_2464_Name = {
    Text = "Permanent Card Arithmetica Increase"
  },
  State_2464_WeaponDesc = {
    Text = "Card Arithmetica Increase"
  },
  State_24654_Desc = {
    Text = "Daffodil permanently increases the team's Crit. Rate by 5% each time she kills an enemy, stacking up to 5 times in this run. (Current stacks: [DescArg1])"
  },
  State_24654_Name = {
    Text = "Mist of greed"
  },
  State_2466_Desc = {
    Text = "Until the start of next turn, each time it takes 1 attack Damage, the Tentacle counterattacks the attacker once. Temporary Tentacle DMG +[Layer]."
  },
  State_2466_Name = {
    Text = "Bloodline of Heresy"
  },
  State_24678_Name = {
    Text = "State@N's Clone@Whisper2 State Switch"
  },
  State_24679_Name = {
    Text = "State@N's Clone 3@Whisper 6 State Switch"
  },
  State_2467_Desc = {
    Text = "State@Prologue Offensive Analysis"
  },
  State_2467_Name = {
    Text = "State@Prologue Offensive Analysis"
  },
  State_2467_WeaponDesc = {
    Text = "State@Prologue Offensive Analysis"
  },
  State_24680_Name = {
    Text = "State@N's Clone 2@Whisper 1 State Switch"
  },
  State_24681_Name = {
    Text = "State@N's Clone@Whisper6 State Switch"
  },
  State_24682_Name = {
    Text = "State@N's Clone 3@Whisper 3 State Switch"
  },
  State_24683_Name = {
    Text = "State@N's Clone 2@Whisper 2 State Switch"
  },
  State_24684_Name = {
    Text = "State@N's Clone@Whisper4 State Switch"
  },
  State_24685_Name = {
    Text = "State@N's Clone@Whispering5 State Switch"
  },
  State_24686_Name = {
    Text = "State@N's Clone 3@Whisper 5 State Switch"
  },
  State_24687_Name = {
    Text = "State@N's Clone 3@Whisper 2 State Switch"
  },
  State_24688_Name = {
    Text = "State@N's Clone 2@Whisper 6 State Switch"
  },
  State_24689_Name = {
    Text = "State@N's Clone 3@Whisper 4 State Switch"
  },
  State_24690_Name = {
    Text = "State@N's Clone 3@Whisper 1 State Switch"
  },
  State_24691_Name = {
    Text = "State Clone@N2@Whisper4 State Switch"
  },
  State_24692_Name = {
    Text = "State@N's Clone 2@Whisper 3 State Switch"
  },
  State_24693_Name = {
    Text = "State@N's Clone@Whisper3 State Switch"
  },
  State_24694_Name = {
    Text = "State@N's Clone 2@Whisper 5 State Switch"
  },
  State_2469_Desc = {
    Text = "Increase DMG dealt by [Layer]%."
  },
  State_2469_Name = {
    Text = "Ultra Round - DMG Boost"
  },
  State_2469_WeaponDesc = {
    Text = "DMG +[Layer]%."
  },
  State_2470_Desc = {
    Text = "Permanently lose [Arg1] Alert when picked up. Active DMG gains a 1x STR bonus."
  },
  State_24719_Desc = {
    Text = "\"@2\" has descended in its true form, with HP x3."
  },
  State_24719_Name = {
    Text = "Fate Reawakens"
  },
  State_24719_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_2471_Desc = {
    Text = "At turn start, reduce my team's Alert by 1."
  },
  State_2471_Name = {Text = "Corrosion"},
  State_2471_WeaponDesc = {
    Text = "At turn start, reduce your team's Alert by 1."
  },
  State_24720_Desc = {
    Text = "This unknown entity still lurks beneath the Black Pool. It will fully awaken and revive upon imminent defeat, ready to fight in its liberated form."
  },
  State_24720_Name = {Text = "Dormancy"},
  State_2472_Desc = {
    Text = "DMG reduces both Shield and HP. Cannot be Immuned."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Pierce DMG>"
  },
  State_2472_WeaponDesc = {
    Text = "Pierce DMG ignores Target Shield, DMG reduction, and block, dealing direct Damage."
  },
  State_24730_Desc = {
    Text = "Temporarily increase Ultra Space, up to 10. During the next Ultra Round, cards in the Temporary Ultra Space will be added to your hand, and the Temporary Ultra Space will be removed."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Temp. Ultra Space>"
  },
  State_24737_Desc = {
    Text = "At turn start, inflict Bleed on the opponent. Each stack of destiny causes [StateArg1] bleeding."
  },
  State_24737_Name = {Text = "Fate"},
  State_24738_Desc = {
    Text = "Each stack of Fate causes [StateArg1] Bleeding DMG when active; playing a Card reduces one stack of Fate."
  },
  State_24738_Name = {Text = "Fate"},
  State_24739_Name = {Text = "Fate"},
  State_2473_Desc = {
    Text = "[Defense] Lose 1 Tentacle, restore [StateArg1] HP. [Strike] Lose [StateArg2] HP, generate 1 Tentacle."
  },
  State_2473_Name = {
    Text = "Relic Immortal Flesh"
  },
  State_2473_WeaponDesc = {
    Text = "[Defense] Lose 1 Tentacle, restore [StateArg1] HP. [Strike] Lose [StateArg2] HP, generate 1 Tentacle."
  },
  State_2474_Desc = {
    Text = "Increase Attack by [Layer]%"
  },
  State_2474_Name = {
    Text = "Increase general Attack by a percentage"
  },
  State_2474_WeaponDesc = {
    Text = "Increase ATK by [Layer]%."
  },
  State_2475_Desc = {
    Text = "Team Unique: The wielder's Active DMG is increased by an amount equal to the wielder's ATK ×<WeaponEffect_Num:[StateArg3]%>. After playing or discarding 1 of the wielder's Command Cards, deal DMG equal to the wielder's ATK ×<WeaponEffect_Num:[StateArg1]%> as <IntoxicationIconKeywords:Poison> to a random enemy once. After the Ultra Round ends, there is a <WeaponEffect_Num:[StateArg2]%> chance to trigger 100% Poison on all enemies."
  },
  State_2475_WeaponDesc = {
    Text = "Wielder's Active DMG is increased by <WeaponEffect_Num:[DescArg2]> points. After playing or discarding 1 Command Card from the wielder, deal <WeaponEffect_Num:[DescArg1]> stacks of <IntoxicationIconKeywords:Poison> to a random enemy. When the Ultra Round ends, there is a <WeaponEffect_Num:[StateArg2]>% chance to trigger [DescArg3]% Poison on all enemies."
  },
  State_2476_Name = {
    Text = "State@Genesis Seer Enlighten 1"
  },
  State_2478_Desc = {
    Text = "The Shield applied by Nautilus is doubled."
  },
  State_2478_Name = {
    Text = "Maintenance expert"
  },
  State_2478_WeaponDesc = {
    Text = "The Shield applied by Nautilus is doubled."
  },
  State_2479_Desc = {
    Text = "Emerald Fire adds one stack with each instance of DMG."
  },
  State_2479_Name = {
    Text = "Emerald Reflection Count"
  },
  State_2479_WeaponDesc = {
    Text = "+1 Stack for each instance of DMG Emerald Fire deals"
  },
  State_2480_Desc = {
    Text = "Gain [StateArg1] Counter when Healing. Abyss Dweller restores 1 HP for each card played."
  },
  State_2480_Name = {
    Text = "Abyss Dweller Metamorphosed Body 1"
  },
  State_2481_Desc = {
    Text = "State@Prologue Reset Deck 0_2_3_1"
  },
  State_2481_Name = {
    Text = "State@Prologue Reset Deck 0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Summon a Dissolution Triangle with equal HP when HP is below 50%."
  },
  State_2482_Name = {Text = "Summon"},
  State_2482_WeaponDesc = {
    Text = "HP below 50% summon 1 Dissolution Triangle with equal HP"
  },
  State_2486_Desc = {
    Text = "At turn start, gain 1 Arithmetica per enemy. When an enemy is defeated by Active DMG, deal excess DMG as Bleeding to other enemies."
  },
  State_24879_Desc = {
    Text = "A thousand years passed, ten thousand years passed, they silently awaited in the eternal darkness. Upon death, reduce \"N\"'s 1 stack of \"Chaos\" and grant \"N\" [DescArg1] Shield and [DescArg2] Strength."
  },
  State_24879_Name = {
    Text = "Phantom Doppelgänger"
  },
  State_2488_Desc = {
    Text = "When you play a Buff Card, Symptom Card, or State Card, the Awakener with the lowest Aliemus gains 10 Aliemus."
  },
  State_2489_Desc = {
    Text = "Crit. Rate +10%. After the first Critical Hit each turn, increase Crit. Rate by an extra 20%. After the 3rd Critical Hit each turn, increase Crit. DMG by an extra 50%."
  },
  State_2490_Desc = {
    Text = "Each stack increases the attack count by 1. Lose 1 stack upon taking DMG, and lose all stacks at the end of turn."
  },
  State_2490_Name = {Text = "Prayer"},
  State_2491_Desc = {
    Text = "Gain a Shield equal to the amount of HP restored when healing."
  },
  State_2491_Name = {
    Text = "Temporary Hardening"
  },
  State_2492_Desc = {
    Text = "Immune to the first Active DMG each turn."
  },
  State_2492_Name = {Text = "Resolute"},
  State_2492_WeaponDesc = {
    Text = "Immune to the first Active DMG each turn."
  },
  State_2493_Desc = {
    Text = "Reduce Active DMG by [Layer]."
  },
  State_2493_Name = {Text = "STR▼"},
  State_2494_Desc = {
    Text = "State@Prologue Aliemus 0_1_4_1"
  },
  State_2494_Name = {
    Text = "State@Prologue Aliemus 0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_4_1"
  },
  State_2495_Desc = {
    Text = "State@Prologue Aliemus 0_1_4_2"
  },
  State_2495_Name = {
    Text = "State@Prologue Aliemus 0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_4_2"
  },
  State_24968_Desc = {
    Text = "At the start of battle, Embryo Fusion +25%. Each time Death Resistance is triggered, Embryo Fusion +25%. For each instance of DMG Sorel deals this turn, the DMG she deals is increased by [DescArg1]."
  },
  State_24968_Name = {
    Text = "Crown Jewel"
  },
  State_2496_Desc = {
    Text = "At turn start, restore [Arg1] HP. If HP is below 50%, restore [Arg2] HP instead."
  },
  State_24976_Desc = {
    Text = "\"Maiden of the Gibbous Moon\" has been Roused. Beware of the harm caused by her special dishes!"
  },
  State_24976_Name = {
    Text = "Karen Rouse!"
  },
  State_24976_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_24977_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_24977_Name = {Text = "Not Roused"},
  State_2497_Desc = {
    Text = "Lily mimics the first Command Card you play each turn. If it's a Strike card, Lily gets +1 attack; if it's a Defense card, Lily gains a Shield worth 10% of her HP; if it's other Command Cards, Lily will get confused and place a pustule here."
  },
  State_2497_Name = {
    Text = "Lily Rouse!"
  },
  State_2497_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_2498_Name = {
    Text = "Cursed Bunny Accessory"
  },
  State_2498_WeaponDesc = {
    Text = "Shield Generation and HP Recovery caused by the wielder is increased by 6%. If the wielder's Realm Mastery is greater than 50, Shield Generation and HP Recovery are additionally increased by 6%."
  },
  State_2499_Name = {
    Text = "Stagnant Curse"
  },
  State_2500_Desc = {
    Text = "Inflict Poison when dealing actual Damage."
  },
  State_2500_Name = {Text = "Toxin"},
  State_2501_Desc = {
    Text = "Team Unique: The team's Max HP increases by 10%. The Healing and Shield provided by the wielder increase by <WeaponEffect_Num:[StateArg3]%>. After playing the wielder's \"Strike\", restore <WeaponEffect_Num:[StateArg1]%> of lost HP. After playing the wielder's \"Defense\", gain Shield equal to <WeaponEffect_Num:[StateArg2]%> of current life. This effect can trigger up to 1 time each per turn."
  },
  State_2501_WeaponDesc = {
    Text = "Team's Max HP +10%. The wielder's Healing and Shield Generation are increased by <WeaponEffect_Num:[StateArg3]%>. After playing the wielder's \"Strike\", restore [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) of lost HP. After playing the wielder's \"Defense\", gain Shield equal to [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) of current HP. This effect triggers up to 1 time each turn."
  },
  State_2502_Desc = {
    Text = "Reduce all DMG dealt by 50%."
  },
  State_2502_Name = {
    Text = "Weakness of Eternal Silence"
  },
  State_2502_WeaponDesc = {
    Text = "All DMG taken is reduced by 50%."
  },
  State_2503_Desc = {
    Text = "Team Unique: The Base DMG dealt by the wielder's cards is increased by <WeaponEffect_Num:[StateArg1]%>. At turn start, there is a <WeaponEffect_Num:[StateArg2]%> chance to generate a random card of the wielder into the hand with added exhaust. If the current realm is \"Caro\", using \"Embryo\" on the wielder increases the Crit. Rate of the wielder's next \"Strike\" card's DMG this turn by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "The Base DMG dealt by the wielder's cards is increased by <WeaponEffect_Num:[StateArg1]%>. At turn start, there is a <WeaponEffect_Num:[StateArg2]%> chance to place 1 random card of the wielder in hand, and add Exhaust to it. If the current realm is \"Caro\", when using \"Embryo\" on the wielder, the Crit. Rate of their next Strike Card's DMG this turn will be increased by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"Strike\" gains 2 Arithmetica and discards 1 random card; \"Defense\" draws 2 cards and loses 1 Arithmetica."
  },
  State_25056_Desc = {
    Text = "Each time Arithmetica is exhausted, Karen gains [Layer] Temporary STR."
  },
  State_25056_Name = {Text = "Well-Fed"},
  State_25057_Desc = {
    Text = "Karen gains [StateArg1] Temporary STR each time Arithmetica is consumed, and 1 stack is removed at turn end."
  },
  State_25057_Name = {Text = "Well-Fed"},
  State_2505_Name = {
    Text = "Accessory: April Praise"
  },
  State_2505_WeaponDesc = {
    Text = "At the start of battle, if the wielder is an Ultra class, increase ATK by 25%."
  },
  State_2507_Desc = {
    Text = "Increases Max HP by 100% when picked up. Lose [Arg1] HP at turn start."
  },
  State_2509_Name = {
    Text = "State@General Realm Mastery"
  },
  State_2511_Desc = {
    Text = "State @ Prologue Keyflare Tutorial"
  },
  State_2511_Name = {
    Text = "State @ Prologue Keyflare Tutorial"
  },
  State_2511_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_2"
  },
  State_2512_Desc = {
    Text = "When you play a card with an Arithmetica Cost of 3 or more, draw 1 card and gain 1 Arithmetica."
  },
  State_2514_Desc = {
    Text = "Shield reduced by [Layer] in this battle."
  },
  State_2514_Name = {
    Text = "Alert Lowered"
  },
  State_2514_WeaponDesc = {
    Text = "Shield Generation reduced by [Layer] in this battle."
  },
  State_2515_Desc = {
    Text = "[Strike] applies [StateArg1] stacks of Poison to all enemies."
  },
  State_2515_Name = {
    Text = "Relic Neurotoxin"
  },
  State_25163_Desc = {
    Text = "He is as elusive as mist."
  },
  State_25163_Name = {
    Text = "Shadows of the Past"
  },
  State_25165_Desc = {
    Text = "Ramona: Timeworn: Unique additional effect of Ramona's Command Card, triggered when there are 3 stacks of Negentropy. The Loop will carry over to the next Battle."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Loop>"
  },
  State_25166_Desc = {
    Text = "With 3 Negentropy stacks, using Ramona: Timeworn's Command Cards consumes all stacks and triggers the extra Loop effect. (Max 3 stacks)"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:Negentropy>"
  },
  State_2516_Desc = {
    Text = "Cannot be played."
  },
  State_2516_Name = {
    Text = "Cannot Play"
  },
  State_2516_WeaponDesc = {
    Text = "The card cannot be played."
  },
  State_25179_Name = {
    Text = "Aliemus Judgment"
  },
  State_2517_Desc = {
    Text = "After your team releases Exalt, we lose Strength for the current turn. Once per turn."
  },
  State_2517_Name = {
    Text = "Fear Aliemus"
  },
  State_25181_Name = {
    Text = "Reincarnation Retain"
  },
  State_2518_Desc = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_2518_Name = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_25194_Desc = {
    Text = "After death, grant \"N\" a Shield of [DescArg1] and [DescArg2] Permanent Strength"
  },
  State_2519_Desc = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_2519_Name = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_1_3"
  },
  State_25204_Name = {
    Text = "State @ N's Clone 2 @ Intention Judgment"
  },
  State_25205_Name = {
    Text = "State @ N's Clone 3 @ Intention Judgment"
  },
  State_25206_Name = {
    Text = "State@N@Add a duplicate check for N"
  },
  State_25207_Name = {
    Text = "State @ N's Clone @ Intention Judgment"
  },
  State_2520_Desc = {
    Text = "State@Prologue Reset Deck 0_1_1_2"
  },
  State_2520_Name = {
    Text = "State@Prologue Reset Deck 0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Helot has been Roused. She will unleash stronger attacks!"
  },
  State_2522_Name = {
    Text = "Helot Rouse"
  },
  State_2523_Desc = {
    Text = "At the start of odd turns, gain [Arg1] Strength this turn. At the start of even turns, gain [Arg2] Alert this turn."
  },
  State_2524_Desc = {
    Text = "At the start of the battle, gain 1 Strength"
  },
  State_2524_Name = {
    Text = "Renowned Far and Wide"
  },
  State_2525_Desc = {
    Text = "Attack count -1, gain [Layer] STR"
  },
  State_2525_Name = {Text = "Debauchery"},
  State_2526_Name = {
    Text = "Gain [Layer] STR"
  },
  State_2527_Name = {
    Text = "Crimson STR Bonus"
  },
  State_2528_Desc = {
    Text = "When you play a card with an actual Arithmetica Cost of 3, draw 1 card and gain 2 Arithmetica."
  },
  State_2529_Desc = {
    Text = "Crit. DMG increases by [Layer]% this turn."
  },
  State_2529_Name = {
    Text = "Temporary Crit. DMG"
  },
  State_2529_WeaponDesc = {
    Text = "Crit. DMG is increased by [Layer]% this turn."
  },
  State_2530_Desc = {
    Text = "Ultra Round Arithmetica = 0"
  },
  State_2530_Name = {Text = "Requiem"},
  State_2530_WeaponDesc = {
    Text = "Ultra Round Arithmetica = 0"
  },
  State_2531_Desc = {
    Text = "Every [Damage:StateArg2] times Emerald Fire deals DMG, gain one [Green Flames] that is exhausted."
  },
  State_2531_Name = {
    Text = "Emerald Reflection"
  },
  State_2531_WeaponDesc = {
    Text = "Every [Damage:StateArg2] times Cinderfire deals DMG, obtain one [Green Flames] with Exhaust."
  },
  State_2532_Name = {
    Text = "Accessory: Scarlet Thrill"
  },
  State_2534_Desc = {
    Text = "State@Prologue Reset Deck 0_1_3_3"
  },
  State_2534_Name = {
    Text = "State@Prologue Reset Deck 0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_3_3"
  },
  State_2535_Desc = {
    Text = "State@Prologue Reset Deck 0_1_3_2"
  },
  State_2535_Name = {
    Text = "State@Prologue Reset Deck 0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_3_2"
  },
  State_2536_Name = {
    Text = "State @ Temporary Strike Card Critical Damage Boost"
  },
  State_2537_Desc = {
    Text = "When a Shield is applied by Blade of Utopia, gain [StateArg2] Temporary Alert."
  },
  State_2537_Name = {
    Text = "Sage of the Battlefield"
  },
  State_2537_WeaponDesc = {
    Text = "When the Blade of Utopia applies a shield, gain [StateArg2] Temporary Alert."
  },
  State_2538_Desc = {
    Text = "When played, gain [StateArg1] <RetaliateIconKeywords:Counter>, then deal True DMG to all enemies equal to [StateArg2]% of your <RetaliateIconKeywords:Counter>."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:Adv. Spike>"
  },
  State_25391_Desc = {
    Text = "One Awakener in the party has been selected as the \"Lucky Audience\", and all cards of that Awakener have the \"Cheer\" effect."
  },
  State_25391_Name = {
    Text = "Lucky Audience"
  },
  State_25392_Desc = {
    Text = "After playing, lose 2% Max HP, The great magician gains 1 \"Ego Boost\" stack this turn."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Cheers>"
  },
  State_25401_Desc = {
    Text = "When this card is in hand, the hand limit increases by 1."
  },
  State_25401_Name = {
    Text = "Ignore Hand Size Limit"
  },
  State_25403_Desc = {
    Text = "Tentacle DMG -50%, gain [Layer] Shield for each Tentacle DMG dealt."
  },
  State_25403_Name = {
    Text = "Abyss Guard"
  },
  State_25405_Desc = {
    Text = "This card will always remain in your hand under any circumstances."
  },
  State_25405_Name = {
    Text = "Permanently Retained"
  },
  State_25406_Desc = {
    Text = "Cannot switch Tentacle Stances for the rest of this turn"
  },
  State_25406_Name = {
    Text = "Aequor Madness: Restriction"
  },
  State_25407_Desc = {
    Text = "Tentacle DMG -25%, Tentacles -1 at Turn End"
  },
  State_25407_Name = {
    Text = "Abyss Madness"
  },
  State_25415_Desc = {
    Text = "After releasing Posse, gain [Layer] Posse Energy."
  },
  State_25415_Name = {
    Text = "Chaos Temporary Keyflare Overflow"
  },
  State_25417_Name = {Text = "Bomb 3"},
  State_25418_Name = {Text = "Bomb 2"},
  State_2542_Name = {
    Text = "Relic Nameless Appendage Count"
  },
  State_2543_Name = {
    Text = "State@Stage2_14Battle8Bubble1"
  },
  State_2544_Desc = {
    Text = "State@Prologue Monster Passive"
  },
  State_2544_Name = {
    Text = "State@Prologue Monster Passive"
  },
  State_2544_WeaponDesc = {
    Text = "State@Prologue Monster Passive"
  },
  State_2545_Desc = {
    Text = "At the start of battle, Embryo Fusion +20%. For each Awakener with maximum Aliemus, Embryo Fusion is increased by an additional +20%."
  },
  State_2547_Desc = {
    Text = "At turn start, add a \"Barbed Trident\" that grants [Arg1] Strength to your hand. After releasing Exalt, increase the Strength of all \"Barbed Trident\" in your hand by [Arg2]."
  },
  State_2548_Desc = {
    Text = "Immune to one death, restores 50 HP after triggering, and permanently disables this Relic."
  },
  State_2548_Name = {
    Text = "Relic Stand-In Doll"
  },
  State_2548_WeaponDesc = {
    Text = "Immune to one death, restores 50 HP after triggering and permanently disables this Relic."
  },
  State_2549_Desc = {
    Text = "Reduce active and Tentacle DMG."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: STR▼>"
  },
  State_2549_WeaponDesc = {
    Text = "Each stack of Drain reduces DMG and Tentacle DMG by 1."
  },
  State_2550_Desc = {
    Text = "When drawn, make yourself Fragile for 1 turn. Upon use, make all enemies Vulnerable for 1 turn. Cannot be sold."
  },
  State_2550_Name = {
    Text = "State Curse Collapse"
  },
  State_2550_WeaponDesc = {
    Text = "When drawn, make yourself Fragile for 1 turn. Upon use, make all enemies Vulnerable for 1 turn. Cannot be sold."
  },
  State_2552_Desc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Retain>"
  },
  State_2552_WeaponDesc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_2553_Desc = {
    Text = "At turn start, gain 1 Arithmetica."
  },
  State_2553_Name = {
    Text = "Relic Arcana Arithmetica"
  },
  State_2553_WeaponDesc = {
    Text = "At turn start, gain 1 Arithmetica."
  },
  State_2556_Desc = {
    Text = "When HP decreases, gain a Shield equal to [Layer]% of the reduced amount."
  },
  State_2556_Name = {
    Text = "Blood Shield"
  },
  State_2556_WeaponDesc = {
    Text = "After HP decreases, obtain a shield equal to [Layer]% of the decreased value."
  },
  State_2557_Desc = {
    Text = "At the start of next turn, gain [Layer] Shield."
  },
  State_2557_Name = {
    Text = "Shield of Pain and Pleasure"
  },
  State_2558_Desc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 2 \"Interference-Type Dissolute\" with equal HP."
  },
  State_2558_Name = {Text = "Split"},
  State_2558_WeaponDesc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 2 \"II-Type Dissoluted Entities\" with equal HP."
  },
  State_2559_Desc = {
    Text = "After each attack, lose [Layer] Temporary STR."
  },
  State_2559_Name = {
    Text = "The Price of Impulsiveness"
  },
  State_2560_Desc = {
    Text = "Gain a [Layer] Shield at the start of next turn."
  },
  State_2560_Name = {
    Text = "Opus of Isolation"
  },
  State_2560_WeaponDesc = {
    Text = "Obtain a [Layer] shield after the start of next turn."
  },
  State_2561_Desc = {
    Text = "Melancholy Talent"
  },
  State_2561_Name = {
    Text = "Melancholy Talent"
  },
  State_2561_WeaponDesc = {
    Text = "Melancholy Talent"
  },
  State_2562_Name = {
    Text = "State@Chapter 3_Resonance 1_Mark"
  },
  State_2563_Desc = {
    Text = "Playing the 10th card increases Tentacle DMG by 2 and makes all Tentacles attack once."
  },
  State_2563_Name = {
    Text = "Relic Barbed Trident"
  },
  State_2563_WeaponDesc = {
    Text = "Playing the 10th card increases Tentacle DMG by 2 and makes all Tentacles attack once."
  },
  State_2564_Desc = {
    Text = "All Shield gained are reduced by [DescArg1]%."
  },
  State_2564_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_2564_WeaponDesc = {
    Text = "All Shield obtained are reduced by 33%."
  },
  State_2565_Name = {
    Text = "Accessory: Scarlet Embrace"
  },
  State_2565_WeaponDesc = {
    Text = "Gain 20 Keyflare when the wielder deals DMG, or 50 Keyflare for a Critical Hit. This effect can trigger up to 3 times per turn."
  },
  State_2566_Desc = {
    Text = "After receiving 3 attacks in one turn, gain 1 stack of Temporary Madness."
  },
  State_2566_Name = {
    Text = "\"Sweet Agony\""
  },
  State_2567_Desc = {
    Text = "Has taken [Layer] Damage; after reaching 3 times, \"Sweet Malevolence\"gains 1 stack of madness for this turn."
  },
  State_2567_Name = {
    Text = "\"Sweet Agony\" Count"
  },
  State_2567_WeaponDesc = {
    Text = "Has taken DMG [Layer] times. Upon reaching 3 times, \"Sweet Demon\" obtains 1 stack of Madness this turn."
  },
  State_2569_Desc = {
    Text = "The recommended Realm bonus effect is increased by 50%, and your Realm Mastery increases by 100 at the start of the level."
  },
  State_2569_Name = {
    Text = "State@Phantasmal Silver Key: Compatibility Separation"
  },
  State_2570_Desc = {
    Text = "When played, draw [StateArg1] card."
  },
  State_2570_Name = {
    Text = "<Rune_3:Finesse>"
  },
  State_2571_Desc = {
    Text = "For every [Chaos] Awakener in the team, all members' Max HP (unfinished), DEF, and ATK increase by 50%."
  },
  State_2571_Name = {
    Text = "Chaos Bonus"
  },
  State_2571_WeaponDesc = {
    Text = "For every [Chaos] Awakener in the team, all members' Max HP (Not completed), Defense, and Attack increase by 50%."
  },
  State_2572_Desc = {
    Text = "When played, increase <EmbryoFusionIconKeywords:Embryo Fusion> by +[StateArg1]%."
  },
  State_2572_Name = {
    Text = "<Rune_12:Bloodlust>"
  },
  State_2573_Desc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when playing a card. When it hits 0, self-destruct, dealing Attack * 2.5 Damage."
  },
  State_2573_Name = {Text = "Bomb"},
  State_2573_WeaponDesc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when you play a card. When it reaches 0, self-destruct, dealing ATK * 2.5 DMG."
  },
  State_2574_Desc = {
    Text = "Crit. DMG +50%. If no Attack is performed this turn, a Critical Hit is guaranteed next turn."
  },
  State_2574_Name = {
    Text = "State@Phantom Silver Key: Rondo"
  },
  State_2575_Desc = {
    Text = "Team Unique: At the start of battle, the wielder's Command Card Crit. Rate + [StateArg1]% for each relic possessed. After using Exalt, roll a 4-sided die; the wielder gains Aliemus and Temporary Crit. DMG equal to <WeaponEffect_Num:[StateArg2]> times the roll result. If the roll is 4 or higher, other Awakeners also gain half."
  },
  State_2575_WeaponDesc = {
    Text = "At the start of the battle, each Relic increases the wielder's Command Card Crit. Rate by [StateArg1]%. After the wielder releases an Exalt, roll a 4-sided die; the wielder gains <WeaponEffect_Num:[StateArg2]> times the dice roll result in Aliemus and Temporary Crit. DMG. If a 4 or higher is rolled, other Awakeners also gain half."
  },
  State_2576_Desc = {
    Text = "Each time a card enters Ultra Space, reduce its Arithmetica Cost by 1."
  },
  State_2577_Desc = {
    Text = "Reduce all DMG dealt by [Layer]%."
  },
  State_2577_Name = {
    Text = "Temporary DMG Reduction"
  },
  State_2577_WeaponDesc = {
    Text = "All DMG+[Layer]%."
  },
  State_2579_Desc = {
    Text = "Increase the number of attacks by [Layer] this turn."
  },
  State_2579_Name = {
    Text = "Temporary Madness"
  },
  State_2580_Desc = {
    Text = "Whenever a Skull Huntress card enters or leaves Ultra Space, gain 1 Arithmetica."
  },
  State_2580_Name = {
    Text = "Dimensional Projection"
  },
  State_2581_Desc = {
    Text = "All Awakeners' Keyflare Regen is increased by 30. After releasing Posse, shuffle 3 <DerivativeCardKeywords_4:\"Insight\"> into your deck."
  },
  State_2581_Name = {
    Text = "State@Chrono Pendulum Insight"
  },
  State_2582_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_2582_Name = {
    Text = "State@Proto Laser Cannon Aliemus"
  },
  State_2583_Desc = {
    Text = "Add a stack to the team each time Active DMG is received."
  },
  State_2583_Name = {
    Text = "State @ Avenger's Great Blade Decapitation Damage Counter"
  },
  State_2583_WeaponDesc = {
    Text = "Add a stack to your team each time Active DMG is received."
  },
  State_2584_Desc = {
    Text = "Gain [Arg1] Strength each time the deck is reshuffled."
  },
  State_2586_Desc = {
    Text = "All Shields obtained -25%, remove 1 stack at turn end."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords:Fragile>"
  },
  State_2586_WeaponDesc = {
    Text = "All Shield obtained are reduced by 25%."
  },
  State_2587_Desc = {
    Text = "Wound DMG doubles. Each time actual DMG is dealt, gain [Layer] Shield."
  },
  State_2587_Name = {
    Text = "\"Heaven-Devouring Maw\""
  },
  State_2587_WeaponDesc = {
    Text = "Wound DMG doubles. Each time actual DMG is dealt, obtain [Layer] shield points."
  },
  State_2588_Desc = {
    Text = "Take [Layer] DMG and remove this state at turn end. When restoring HP, remove bleeding stacks equal to twice the amount restored."
  },
  State_2588_Name = {
    Text = "Permanent<BleedingColour:Bleed>"
  },
  State_2588_WeaponDesc = {
    Text = "At turn end, take [Layer] DMG and remove this state. Each heal reduces the stacks by half."
  },
  State_2589_Name = {
    Text = "Accessory: Twisted Twin Black"
  },
  State_2589_WeaponDesc = {
    Text = "On the start of odd turns, add the wielder's \"Strike\" with Exhaust and Fleeting to your hand."
  },
  State_2590_Desc = {
    Text = "Gain 10 Black Sigils when moving"
  },
  State_2590_Name = {
    Text = "Relic Bottomless Bag"
  },
  State_2590_WeaponDesc = {
    Text = "Gain 10 Black Sigils when moving"
  },
  State_2592_Desc = {
    Text = "For each 1 HP lost, remove 1 stack. When the number of stacks reaches 0, gain a [DescArg1] Shield."
  },
  State_2592_Name = {
    Text = "Dimensional Barrier"
  },
  State_2593_Name = {
    Text = "State@Hymn of Crimson Blood and Sand"
  },
  State_2594_Desc = {
    Text = "Gain a Shield by dealing actual Damage."
  },
  State_2594_Name = {
    Text = "\"Heaven-Devouring Maw\""
  },
  State_2594_WeaponDesc = {
    Text = "Gain a Shield by dealing actual Damage."
  },
  State_2595_Desc = {
    Text = "Gain [StateArg2] Temporary STR for each hit."
  },
  State_2595_Name = {
    Text = "Sage Queen's Sword"
  },
  State_2597_Desc = {
    Text = "At turn start, gain [Layer] Shield."
  },
  State_2597_Name = {
    Text = "Delayed Shield"
  },
  State_2597_WeaponDesc = {
    Text = "At turn start, obtain [Layer] shield points."
  },
  State_2600_Desc = {
    Text = "Whenever you lose HP, the Awakener with the lowest Aliemus gains 10 Aliemus. Whenever you lose HP 5 times, gain 1 stack of Barrier."
  },
  State_2600_Name = {
    Text = "State@Silver Key of Illusion: Heart of the Blood Abyss"
  },
  State_2601_Desc = {
    Text = "Even turns: DMG received reduced by 50%, DMG dealt increased by 33%."
  },
  State_2601_Name = {Text = "Fickle"},
  State_2601_WeaponDesc = {
    Text = "Even turns: DMG received -50%, DMG dealt +33%."
  },
  State_2602_Desc = {
    Text = "You are the target! After playing, Eternal Zealot gains [StateArg1] Temporary STR and removes the Mark of Abyss from this command."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Mark of Abyss>"
  },
  State_2602_WeaponDesc = {
    Text = "After playing the card, the Deep Diver Elite gains [StateArg1] Temporary STR."
  },
  State_2603_Desc = {
    Text = "If \"Embryo\" cards are in hand, consume all to trigger the Devour effect once per Embryo."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Infinite Devour>"
  },
  State_2604_Desc = {
    Text = "Crit. Rate increased by [Layer]% this turn."
  },
  State_2604_Name = {
    Text = "Temporary Crit. Rate"
  },
  State_2604_WeaponDesc = {
    Text = "Crit. Rate increased by [Layer]% this turn."
  },
  State_2605_Desc = {
    Text = "When HP is below 95% ([StateArg1]), it will split into 2 \"Experimental Works\" with equal HP."
  },
  State_2605_Name = {Text = "Split"},
  State_2605_WeaponDesc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_2606_Desc = {
    Text = "When HP is below 90% ([StateArg1]), it will split into 2 \"Experimental Works\" with equal HP."
  },
  State_2606_Name = {Text = "Split"},
  State_2606_WeaponDesc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_2607_Desc = {
    Text = "Restore 5 HP at the end of the battle."
  },
  State_2607_Name = {
    Text = "Maiden of the Gibbous Moon Enlighten 3"
  },
  State_2607_WeaponDesc = {
    Text = "Restore 5 HP at the end of the battle."
  },
  State_2609_Desc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 2 \"Experimental Works\" with equal HP."
  },
  State_2609_Name = {Text = "Split"},
  State_2609_WeaponDesc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_2610_Desc = {
    Text = "When HP is below 70% ([StateArg1]), it will split into 2 \"Experimental Works\" with equal HP."
  },
  State_2610_Name = {Text = "Split"},
  State_2610_WeaponDesc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_2611_Desc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 2 \"Experimental Creations\" with equal HP."
  },
  State_2611_Name = {Text = "Split"},
  State_2611_WeaponDesc = {
    Text = "When HP is below 30% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_2612_Desc = {
    Text = "Ancient Imitator"
  },
  State_2612_Name = {
    Text = "Ancient Imitator"
  },
  State_2612_WeaponDesc = {
    Text = "Ancient Imitator"
  },
  State_2614_Desc = {
    Text = "Team Unique: After playing the wielder's Command Card, there is a <WeaponEffect_Num:[StateArg1]%> chance to return it to your hand from the Discard Pile. This effect can only trigger once per turn."
  },
  State_2614_WeaponDesc = {
    Text = "When playing the wielder's Command Card, there is a <WeaponEffect_Num:[StateArg1]%> chance to return it from the Discard Pile to the hand. This effect activates only once per turn."
  },
  State_2617_Desc = {
    Text = "Draw 2 additional cards at the start of next turn."
  },
  State_2617_Name = {Text = "Mania"},
  State_2619_Desc = {
    Text = "Active DMG dealt is reduced by [Layer] in this battle."
  },
  State_2619_Name = {Text = "STR▼"},
  State_2619_WeaponDesc = {
    Text = "DMG dealt during this battle is reduced by [Layer]."
  },
  State_2620_Desc = {
    Text = "Rusty Lancet Relic"
  },
  State_2623_Desc = {
    Text = "At turn start, gain 1 Arithmetica."
  },
  State_2624_Desc = {
    Text = "When played, inflict [StateArg1] Temp. <ExhaustionIconKeywords:STR▼> on all enemies."
  },
  State_2624_Name = {
    Text = "<Rune_18:Drain>"
  },
  State_2625_Desc = {
    Text = "Your Leap effect triggers twice. Upon entering the Ultra Round, all enemies gain 5 Temporary STR."
  },
  State_2625_Name = {
    Text = "Relic Nightmare Lantern"
  },
  State_2626_Desc = {
    Text = "Tentacle Limit -1. At turn end, make all Tentacles attack 1 additional time."
  },
  State_2627_Name = {
    Text = "Gain [StateArg1] Keyflare"
  },
  State_2627_WeaponDesc = {
    Text = "Cards chosen at the \"Unfinished Wax Sculpture\" node are granted Keyflare."
  },
  State_2628_Desc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node gain the Orison effect"
  },
  State_2628_Name = {
    Text = "State@Chapter Two_Resonance 3"
  },
  State_2628_WeaponDesc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node obtain the Orison effect."
  },
  State_2629_Desc = {
    Text = "Found at the \"Unfinished Wax Sculpture\": Increased range of Cards that can be copied"
  },
  State_2629_Name = {
    Text = "State@Chapter 2_Resonance 2"
  },
  State_2629_WeaponDesc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node and their originals gain the \"Innate\" effect."
  },
  State_2630_Desc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" and their originals gain the \"Retain\" effect"
  },
  State_2630_Name = {
    Text = "Status@Chapter2_Resonance4"
  },
  State_2630_WeaponDesc = {
    Text = "The cards copied at the \"Unfinished Wax Sculpture\" node and their originals gain the \"Retain\" effect."
  },
  State_2631_Desc = {
    Text = "Duplicate a card at the \"Unfinished Wax Sculpture\""
  },
  State_2631_Name = {
    Text = "State@Chapter 2_Resonance 6"
  },
  State_2631_WeaponDesc = {
    Text = "Copy one additional card at the \"Unfinished Wax Sculpture\" node"
  },
  State_2633_Desc = {
    Text = "Each time you are attacked, a [Green Flames] card is added to your hand for [Layer] turns."
  },
  State_2633_Name = {
    Text = "Moth-Trapping Fire"
  },
  State_2633_WeaponDesc = {
    Text = "Each time you are attacked before your next turn, add a [Green Flames] to your hand."
  },
  State_2634_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still Parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_2634_Name = {
    Text = "Parasitized"
  },
  State_2635_Desc = {
    Text = "State@Prologue Offensive Analysis Marker"
  },
  State_2635_Name = {
    Text = "State@Prologue Offensive Analysis Marker"
  },
  State_2635_WeaponDesc = {
    Text = "State@Prologue Offensive Analysis Marker"
  },
  State_2636_Name = {
    Text = "Status@Chapter 4 Resonance@Draw 1 Card Next Turn"
  },
  State_2637_Desc = {
    Text = "At turn start, gain [StateArg1] Arithmetica."
  },
  State_2637_Name = {
    Text = "Relic Vitality Injection"
  },
  State_2637_WeaponDesc = {
    Text = "At turn start, obtain [StateArg1] Arithmetica."
  },
  State_2638_Name = {
    Text = "Gain [Energy:DescArg1] Aliemus"
  },
  State_2639_Desc = {
    Text = "When taking fatal DMG, there is a chance to trigger Death Resistance and survive at 1 HP. Each trigger halves your Death Resistance % and subsequent Death Resistance gains during this exploration."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Death Resistance>"
  },
  State_2640_Name = {
    Text = "General effect repeats once"
  },
  State_2645_Desc = {
    Text = "State@Prologue Monster Passive 1"
  },
  State_2645_Name = {
    Text = "State@Prologue Monster Passive 1"
  },
  State_2645_WeaponDesc = {
    Text = "State@Prologue Monster Passive 1"
  },
  State_2646_Desc = {
    Text = "State@Prologue Monster Passive 2"
  },
  State_2646_Name = {
    Text = "State@Prologue Monster Passive 2"
  },
  State_2646_WeaponDesc = {
    Text = "State@Prologue Monster Passive 2"
  },
  State_2647_Desc = {
    Text = "State@Prologue Monster Passive 3"
  },
  State_2647_Name = {
    Text = "State@Prologue Monster Passive 3"
  },
  State_2647_WeaponDesc = {
    Text = "State@Prologue Monster Passive 3"
  },
  State_2648_Desc = {
    Text = "State @ Prologue Monster Passive 4"
  },
  State_2648_Name = {
    Text = "State @ Prologue Monster Passive 4"
  },
  State_2648_WeaponDesc = {
    Text = "State @ Prologue Monster Passive 4"
  },
  State_2649_Desc = {
    Text = "State@Prologue Monster Passive 5"
  },
  State_2649_Name = {
    Text = "State@Prologue Monster Passive 5"
  },
  State_2649_WeaponDesc = {
    Text = "State@Prologue Monster Passive 5"
  },
  State_2650_Desc = {
    Text = "State @ Prologue Monster Passive 6"
  },
  State_2650_Name = {
    Text = "State @ Prologue Monster Passive 6"
  },
  State_2650_WeaponDesc = {
    Text = "State @ Prologue Monster Passive 6"
  },
  State_2651_Desc = {
    Text = "State@Prologue Monster Passive 7"
  },
  State_2651_Name = {
    Text = "State@Prologue Monster Passive 7"
  },
  State_2651_WeaponDesc = {
    Text = "State@Prologue Monster Passive 7"
  },
  State_2652_Desc = {
    Text = "State@Prologue Monster Passive 8"
  },
  State_2652_Name = {
    Text = "State@Prologue Monster Passive 8"
  },
  State_2652_WeaponDesc = {
    Text = "State@Prologue Monster Passive 8"
  },
  State_2653_Desc = {
    Text = "State@Prologue Monster Passive 9"
  },
  State_2653_Name = {
    Text = "State@Prologue Monster Passive 9"
  },
  State_2653_WeaponDesc = {
    Text = "State@Prologue Monster Passive 9"
  },
  State_2655_Desc = {
    Text = "Heal for an amount equal to unblocked DMG dealt. Removed upon dealing Damage."
  },
  State_2655_Name = {Text = "Life Drain"},
  State_2656_Desc = {
    Text = "Run away at the start of next turn!"
  },
  State_2656_Name = {Text = "Escape"},
  State_2660_Desc = {
    Text = "At the start of the battle, gain Strength, but take 5 more Damage."
  },
  State_2660_Name = {Text = "Last Cry"},
  State_2661_Desc = {
    Text = "At the start of the battle, all enemies lose [Arg1] Strength."
  },
  State_2662_Name = {
    Text = "State@Chapter_3_Test_State"
  },
  State_2663_Desc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_2663_Name = {
    Text = "State Curse Weakened"
  },
  State_2663_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_2666_Name = {
    Text = "Crit. Rate of the Recurrent Dagger"
  },
  State_2667_Desc = {
    Text = "\"Strike\" DMG increased by [Layer]%."
  },
  State_2667_Name = {
    Text = "Damage of Strike Cards increased"
  },
  State_2667_WeaponDesc = {
    Text = "Strike card DMG increased by [Layer]%."
  },
  State_2668_Desc = {
    Text = "Increase Attack by [Layer]%"
  },
  State_2668_Name = {
    Text = "Increase universal permanent attack percentage"
  },
  State_2668_WeaponDesc = {
    Text = "Increase ATK by [Layer]%."
  },
  State_2669_Desc = {
    Text = "Crit. DMG is increased by [Layer]% in this battle."
  },
  State_2669_Name = {Text = "Crit. DMG"},
  State_2670_Desc = {
    Text = "When you inflict Weakness, gain [Arg1] Shield; when you inflict Vulnerability, gain [Arg2] Strength. Triggering both effects in 1 turn grants an additional [Arg1] Shield and [Arg2] Strength."
  },
  State_2671_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_2671_Name = {Text = "Not Roused"},
  State_2672_Desc = {
    Text = "At turn start, apply [Bind] to my team."
  },
  State_2672_Name = {Text = "Bondage"},
  State_2672_WeaponDesc = {
    Text = "At turn start, apply a stack of [Bondage] to your team."
  },
  State_2674_Desc = {
    Text = "Crit. Rate increased by [Layer]% this turn."
  },
  State_2674_Name = {
    Text = "Temporary Crit. Rate"
  },
  State_2676_Name = {
    Text = "Accessory: Scarlet Thrill"
  },
  State_2676_WeaponDesc = {
    Text = "After releasing the Posse, the wielder gains 15% Temporary Crit. Rate. If the wielder's Current Crit. DMG is greater than 80%, they gain an additional 15% Temporary Crit. Rate."
  },
  State_2677_Desc = {
    Text = "The first 3 instances of active/Tentacle DMG per turn are reduced by 75%."
  },
  State_2677_Name = {
    Text = "\"Immortal Remnant\""
  },
  State_2677_WeaponDesc = {
    Text = "The first 3 instances of DMG taken from active/Tentacle attacks each turn are reduced by 75%."
  },
  State_2679_Name = {
    Text = "State@Chapter3_Resonance7_Marker"
  },
  State_2680_Desc = {
    Text = "Crit. Rate increased by 20%. Guaranteed Critical Hit this turn if HP is below 25% at turn start."
  },
  State_2681_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_2681_Name = {Text = "Not Roused"},
  State_2682_Desc = {
    Text = "Shield and Healing Amplification +50%."
  },
  State_2682_Name = {
    Text = "Guardian of the Alienated Garden"
  },
  State_2682_WeaponDesc = {
    Text = "Shield & Healing Amp. increased by 50%."
  },
  State_2683_Desc = {
    Text = "Card that draws state stacks."
  },
  State_2683_Name = {Text = "Draw"},
  State_2684_Desc = {
    Text = "Team Unique: The wielder's \"Strike\" has a <WeaponEffect_Num:[StateArg1]%> chance to gain 1 Arithmetica and trigger 10% <IntoxicationIconKeywords:Poison> on all enemies; if the current Realm is \"Aequor\", triggering this effect causes 1 Tentacle to attack once. This effect only activates once per turn."
  },
  State_2684_WeaponDesc = {
    Text = "The wielder's \"Strike\" has a <WeaponEffect_Num:[StateArg1]%> chance to gain 1 Arithmetica and trigger [DescArg1]% <IntoxicationIconKeywords:Poison> on all enemies. If the current Realm is \"Aequor\", then when this effect is triggered, 1 Tentacle will attack once. This effect can trigger a maximum of 1 time per turn."
  },
  State_2685_Desc = {
    Text = "Immune to Weakness, Frailty, and Vulnerable. Remove 1 stack at turn end."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords:Blessing>"
  },
  State_2685_WeaponDesc = {
    Text = "Immune to debuffs applied to allies this turn."
  },
  State_2686_Desc = {
    Text = "Temporary cards granted during battle."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:State Card>"
  },
  State_2687_Desc = {
    Text = "Crit. Rate increased by 100% this turn"
  },
  State_2687_Name = {
    Text = "Guaranteed Crit."
  },
  State_2687_WeaponDesc = {
    Text = "Crit. Rate + 100% this turn."
  },
  State_2688_Desc = {
    Text = "After playing the 3rd card each turn, place 1 \"Insight\" into the Discard Pile. After playing the 6th card each turn, place 1 \"Insight\" from the Discard Pile into hand."
  },
  State_2689_Desc = {
    Text = "Draw 2 cards at turn start. Increase Ultra card slot capacity by 2."
  },
  State_2689_Name = {
    Text = "Relic Trickster's Hat"
  },
  State_2689_WeaponDesc = {
    Text = "Draw 2 cards at turn start. Ultra card slot capacity is increased by 2."
  },
  State_2690_Desc = {
    Text = "When Virtue Knight plays a card, they gain [StateArg1] Strength."
  },
  State_2690_Name = {
    Text = "Knight's Zeal"
  },
  State_2691_Desc = {
    Text = "Team Unique: After the wielder releases an Exalt, they gain <WeaponEffect_Num:[StateArg1]> Aliemus and <WeaponEffect_Num:[StateArg2]>  Keyflare, repeating once for every 4 cards in hand. If the current Realm is \"Ultra\", after the wielder's Cards enter Ultra space, they gain Temporary STR equal to <WeaponEffect_Num:[StateArg3]%> of the wielder's Attack, triggering up to 2 times per turn."
  },
  State_2691_WeaponDesc = {
    Text = "After the wielder releases Exalt, gain <WeaponEffect_Num:[StateArg1]> Aliemus and <WeaponEffect_Num:[StateArg2]> Keyflare, repeating once for every 4 cards in hand. If the current Realm is \"Ultra\", after the wielder's cards enter Ultra Space, gain <WeaponEffect_Num:[Power:DescArg1]> Temporary STR, triggering a maximum of 2 times per turn."
  },
  State_2693_Desc = {
    Text = "State@Prologue Aliemus 0_1_2 Effect"
  },
  State_2693_Name = {
    Text = "State@Prologue Aliemus 0_1_2 Effect"
  },
  State_2693_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_2 Effect"
  },
  State_2694_Desc = {
    Text = "For each consumed Black Sigil, all Awakeners gain 1 Aliemus"
  },
  State_2694_Name = {
    Text = "Relic Reversal Flower State"
  },
  State_2694_WeaponDesc = {
    Text = "For each consumed Black Sigil, all Awakeners obtain 1 Aliemus."
  },
  State_2695_Desc = {
    Text = "Each time a card of an Awakener enters Ultra Space, the corresponding Awakener gains 15 Aliemus."
  },
  State_2696_Desc = {
    Text = "State@Prologue Aliemus 0_1_2 Active"
  },
  State_2696_Name = {
    Text = "State@Prologue Aliemus 0_1_2 Active"
  },
  State_2696_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_2 Active"
  },
  State_2698_Name = {
    Text = "Gain +1 Arithmetica at the start of next turn."
  },
  State_2699_Name = {
    Text = "Gain +2 Arithmetica at the start of next turn."
  },
  State_2701_Desc = {
    Text = "Lady of the Depths increases [StateArg1] Temporary Tentacle DMG upon gaining a Shield."
  },
  State_2701_Name = {
    Text = "Made Into Being"
  },
  State_2701_WeaponDesc = {
    Text = "Lady of the Depths increases [StateArg1] Temporary Tentacle DMG upon obtaining a shield."
  },
  State_2702_Desc = {
    Text = "Gain 100% Death Resistance upon pickup. After triggering Death Resistance, restore [Arg1] HP at turn start in this battle."
  },
  State_2703_Desc = {
    Text = "The Temporary copy of the first Awakener card played each turn enters a Dimensional Rift, usable for self-protection in times of danger!"
  },
  State_2703_Name = {
    Text = "Dimensional Rift"
  },
  State_2705_Desc = {Text = "—"},
  State_2705_Name = {
    Text = "Vengeance Upon Thee"
  },
  State_2705_WeaponDesc = {Text = "—"},
  State_2706_Desc = {
    Text = "Gradually Petrify Detection"
  },
  State_2706_Name = {
    Text = "Gradually Petrify Detection"
  },
  State_2706_WeaponDesc = {
    Text = "Gradually Petrify Detection"
  },
  State_2707_Desc = {
    Text = "This turn, the Tentacle attacks all enemies."
  },
  State_2707_Name = {
    Text = "Tentacle Full-Scale Attack"
  },
  State_2707_WeaponDesc = {
    Text = "This turn, the Tentacles attack all enemies."
  },
  State_2708_Desc = {
    Text = "Increase the Tentacle Limit by 1. When HP is below 50%, increase Tentacle DMG by [StateArg1]."
  },
  State_2708_Name = {
    Text = "Mutated Relic of the Past"
  },
  State_2708_WeaponDesc = {
    Text = "Tentacle Limit increased by 1. When HP is below 50%, Tentacle DMG increases by [StateArg1]."
  },
  State_2709_Desc = {
    Text = "Relic Rusty Lancet Count"
  },
  State_2710_Desc = {Text = "Imprint"},
  State_2710_Name = {Text = "Imprint"},
  State_2710_WeaponDesc = {Text = "Imprint"},
  State_2711_Desc = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2711_Name = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2711_WeaponDesc = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_2712_Desc = {
    Text = "Increase Shield generation."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:Alert>"
  },
  State_2712_WeaponDesc = {
    Text = "Increases the gained Shield."
  },
  State_2713_Desc = {
    Text = "Vengeance Blade gains Strength each turn."
  },
  State_2713_Name = {
    Text = "Goliath Rouse"
  },
  State_2713_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_2715_Desc = {
    Text = "Shield generation in this stage increases by [Layer]."
  },
  State_2715_Name = {
    Text = "Permanent Alert"
  },
  State_2715_WeaponDesc = {
    Text = "Shield Generation is increased by [Layer] in this stage."
  },
  State_2718_Desc = {
    Text = "Team Unique: At turn end, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus and Keyflare equal to their Keyflare Regen."
  },
  State_2718_WeaponDesc = {
    Text = "At turn end, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus and Keyflare equal to the wielder's Keyflare Regen."
  },
  State_2720_Desc = {
    Text = "After dealing actual Damage, reduce the highest Aliemus Awakener's Aliemus by 10."
  },
  State_2720_Name = {Text = "Fleeting"},
  State_2720_WeaponDesc = {
    Text = "After dealing actual Damage, reduce the highest Aliemus Awakener's Aliemus by 10."
  },
  State_2721_Name = {
    Text = "State@Level2_9Battle5Bubble1"
  },
  State_2722_Desc = {
    Text = "When played, shuffle [StateArg1] <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Adv. Insight>"
  },
  State_2723_Desc = {
    Text = "When played, inflict [StateArg1] turns of <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Adv. Vulnerable>"
  },
  State_2723_WeaponDesc = {
    Text = "When played, inflict [StateArg1] turns of <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  State_2724_Desc = {
    Text = "Increase the number of attacks by 1."
  },
  State_2724_Name = {
    Text = "Phantom Core Counterattack"
  },
  State_2726_Desc = {
    Text = "When played, inflict [StateArg1] <IntoxicationIconKeywords:Poison> on all enemies, then trigger [StateArg2]% of each enemy's <IntoxicationIconKeywords:Poison>."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Adv. Toxin>"
  },
  State_2727_Desc = {
    Text = "When on the verge of death, restore 1 HP and remove this State."
  },
  State_2727_Name = {Text = "Grit"},
  State_2727_WeaponDesc = {
    Text = "When on the verge of death, heal 1 HP and remove this State."
  },
  State_2728_Desc = {
    Text = "At turn start, gain 1 stack of <ParcloseIconKeywords:Barrier> for each other friendly unit."
  },
  State_2728_Name = {
    Text = "Link Barrier"
  },
  State_2728_WeaponDesc = {
    Text = "At turn start, gain Shield equal to [Layer]% of Max HP for each other friendly unit."
  },
  State_2729_Desc = {
    Text = "When triggered, draw a card corresponding to the Awakener."
  },
  State_2729_Name = {
    Text = "Mutated Spatial Deflector Draw"
  },
  State_2729_WeaponDesc = {
    Text = "When triggered, draw a card corresponding to the Awakener."
  },
  State_2730_Desc = {
    Text = "Upon death, Hydra reduces 1 stack of the \"Serpent Manipulation\" state."
  },
  State_2730_Name = {Text = "Kindred"},
  State_2732_Desc = {
    Text = "State@Prologue Aliemus Init 0_2_3"
  },
  State_2732_Name = {
    Text = "State@Prologue Aliemus Init 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "State@Prologue Aliemus Init 0_2_3"
  },
  State_2734_Name = {
    Text = "Draw +1 card at the start of next turn"
  },
  State_2735_Desc = {
    Text = "The first Command Card played each turn or during Ultra Round triggers the following effects."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:Leap>"
  },
  State_2735_WeaponDesc = {
    Text = "If currently in an Ultra Round, Leap effects can be triggered."
  },
  State_2737_Desc = {
    Text = "When your team's deck is reset, gain [Layer] STR."
  },
  State_2737_Name = {
    Text = "Eternal Freeze"
  },
  State_2738_Name = {
    Text = "Enhance Weakness Effect"
  },
  State_2740_Desc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node and their originals have Arithmetica Cost -1 and gain a Symptom Card."
  },
  State_2740_Name = {
    Text = "Status@ChapterTwo_Resonance5_2"
  },
  State_2740_WeaponDesc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node and their originals have an Arithmetica Cost reduced by 1."
  },
  State_2741_Desc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node and their originals have Arithmetica Cost -1 and gain a Symptom Card."
  },
  State_2741_Name = {
    Text = "State @ Chapter Two_Resonance 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "Cards copied at the \"Unfinished Wax Sculpture\" node and their originals have an Arithmetica Cost reduced by 1."
  },
  State_2742_Desc = {
    Text = "For every point of DMG dealt by the Tick-Tock Man, gain [StateArg2] Temporary STR; for every point of Shield, receive [StateArg3] Temporary Alert."
  },
  State_2742_Name = {
    Text = "Parameter Fitting"
  },
  State_2744_Desc = {
    Text = "Each time a card of an Awakener enters Ultra Space, it gains 15 Aliemus."
  },
  State_2744_Name = {
    Text = "Relic Warp Device"
  },
  State_2744_WeaponDesc = {
    Text = "Each time a card of an Awakener enters Ultra Space, it gains 15 Aliemus."
  },
  State_2746_Desc = {
    Text = "Attack count +1, lose [Layer] STR"
  },
  State_2746_Name = {Text = "Anxiety"},
  State_2747_Desc = {
    Text = "When played, increase all other Awakeners' Aliemus by <Energy:[StateArg1]>."
  },
  State_2747_Name = {
    Text = "<Rune_16:Catalyst>"
  },
  State_2748_Desc = {
    Text = "State@Lantern Ceremony"
  },
  State_2748_Name = {
    Text = "State@Lantern Ceremony"
  },
  State_2748_WeaponDesc = {
    Text = "State@Lantern Ceremony"
  },
  State_2749_Desc = {
    Text = "This turn, after dealing Tentacle DMG, apply [Layer] stacks of Poison to the target."
  },
  State_2749_Name = {
    Text = "Deep Currents"
  },
  State_2750_Desc = {
    Text = "Sink with me into the sea..."
  },
  State_2750_Name = {
    Text = "Nymphaea Rouse"
  },
  State_2752_Desc = {
    Text = "When Water Lily deals DMG, gain [StateArg2] Aliemus."
  },
  State_2752_Name = {
    Text = "Drowning in Sorrow"
  },
  State_2752_WeaponDesc = {
    Text = "When Water Lily deals DMG, obtain [StateArg2] Aliemus."
  },
  State_2753_Desc = {
    Text = "If HP is above [Arg1] at turn start, lose [Arg1] HP, gain [Arg2] Strength and [Arg3] Alert for the turn."
  },
  State_2754_Name = {
    Text = "State @ Temporary Strike Card Critical Rate Boost"
  },
  State_2756_Desc = {
    Text = "Each time an Awakener performs a Devour, other Awakeners gain 10 Aliemus."
  },
  State_2756_Name = {
    Text = "Relic Gnosis Device"
  },
  State_2756_WeaponDesc = {
    Text = "Each time an Awakener performs a Devour, other Awakeners gain 10 Aliemus."
  },
  State_2757_Desc = {
    Text = "Gain 2 additional Arithmetica next turn."
  },
  State_2757_Name = {Text = "Paranoia"},
  State_2758_Desc = {
    Text = "All your HP recovery effects are increased by [Arg1], and excess recovery is converted into an equal amount of Shield."
  },
  State_2760_Desc = {
    Text = "Each time an Awakener performs a Devour, other Awakeners gain 10 Aliemus."
  },
  State_2762_Desc = {
    Text = "When played, it takes effect [StateArg1] extra times, and you receive [StateArg2] Black Sigils. (This Orison also affixed <DepleteIconKeywords:Exhaust> and <GuyouKeywords:Innate> to the card.)"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Adv. Echo>"
  },
  State_2762_WeaponDesc = {
    Text = "When played, it takes effect [StateArg1] extra times. (This Orison also affixed <DepleteIconKeywords:Exhaust> to the card.)"
  },
  State_2763_Desc = {
    Text = "Each time the Slumbering Sovereign consumes 1 Arithmetica, increase [StateArg1] Tentacle DMG."
  },
  State_2763_Name = {
    Text = "Immortal Majesty"
  },
  State_2763_WeaponDesc = {
    Text = "Each time the Slumbering Sovereign consumes 1 Arithmetica, increase [StateArg1] Tentacle DMG."
  },
  State_2764_Desc = {
    Text = "Adds [StateArg1] stacks of Bleeding when dealing DMG that is not blocked."
  },
  State_2764_Name = {
    Text = "Malicious Bleeding"
  },
  State_2765_Name = {
    Text = "State@George@Heals upon death"
  },
  State_2767_Name = {
    Text = "State@The Black Sigil and Keyflare Regen Efficiency"
  },
  State_2769_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_2769_Name = {Text = "Not Roused"},
  State_2771_Desc = {
    Text = "Monster Strength"
  },
  State_2771_Name = {
    Text = "Monster Strength"
  },
  State_2772_Name = {
    Text = "State@Stage2_5Battle3Bubble1"
  },
  State_2773_Desc = {
    Text = "At battle start, place 1 \"Fleeting Beauty - Replace all Awakener cards in hand with 'Strike' until turn end. Retain, Exhaust.\" into hand."
  },
  State_2775_Desc = {
    Text = "Draw Count on Return"
  },
  State_2775_Name = {
    Text = "Draw Count Restoration"
  },
  State_2776_Name = {
    Text = "Petrifying Eyes Stagnant Curse Enhanced"
  },
  State_2777_Name = {
    Text = "State@Chapter Three_Empty State"
  },
  State_2778_Desc = {
    Text = "At the start of the battle, gain [Arg1] Shield. After playing 7 \"Defenses\" in this battle, immediately gain [Arg2] Shield."
  },
  State_2779_Desc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 3 \"Interference-Type Dissolute\" with equal HP."
  },
  State_2779_Name = {Text = "Split"},
  State_2779_WeaponDesc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 2 \"II-Type Dissoluted Entities\" with equal HP."
  },
  State_2780_Desc = {
    Text = "When played, recover [StateArg1] Arithmetica."
  },
  State_2780_Name = {
    Text = "<Rune_4:Computation>"
  },
  State_2781_Desc = {
    Text = "Every time you play [Layer] cards, if you don't have a Barrier, add one stack of <ParcloseIconKeywords:Barrier>."
  },
  State_2781_Name = {
    Text = "Recharge Barrier"
  },
  State_2781_WeaponDesc = {
    Text = "Every time your team plays [Layer] cards, the monster refreshes a stack of Barrier."
  },
  State_2784_Desc = {
    Text = "Even outside Ultra Rounds, you can trigger a Leap effect once per turn. Increase Ultra Space capacity by 2."
  },
  State_2785_Desc = {
    Text = "Team Unique: After the wielder plays a card, the wielder gains 1 point of Aliemus. At the start of combat, gain <WeaponEffect_Num:[StateArg1]%> of the wielder's Attack as <PowerIconKeywords:STR>, and if the current Realm is \"Aequor\", additionally gain <WeaponEffect_Num:[StateArg2]%> of <CardKeyWord:Tentacle DMG>. Subsequently, at the start of each following turn, gain <WeaponEffect_Num:[StateArg3]%> of the wielder's Attack as <PowerIconKeywords:STR>, and if the current Realm is \"Aequor\", additionally gain <WeaponEffect_Num:[StateArg4]%> of <CardKeyWord:Tentacle DMG>."
  },
  State_2785_WeaponDesc = {
    Text = "After the wielder plays a card, the wielder gains 1 Aliemus. At the start of battle, gain <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" additionally gain <WeaponEffect_Num:[DescArg2]> <CardKeyWord:Tentacle DMG>. After the start of each subsequent turn, gain <WeaponEffect_Num:[Power:DescArg3]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" additionally gain <WeaponEffect_Num:[DescArg4]> <CardKeyWord:Tentacle DMG>."
  },
  State_2786_Name = {
    Text = "Relic Bloodstained Pebble Count"
  },
  State_2787_Desc = {
    Text = "Restore HP, shuffle 1 [Illusion's End] into the Discard Pile. Permanent, Destroy."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Truth Seeker>"
  },
  State_2787_WeaponDesc = {
    Text = "HP Recovery, shuffle 1 [Illusion's End] into the Discard Pile. Permanent, Destroy."
  },
  State_2788_Desc = {
    Text = "Draw [StateArg1] cards at turn start."
  },
  State_2788_Name = {
    Text = "Relic Prophet's Lamp 1"
  },
  State_2788_WeaponDesc = {
    Text = "Draw [StateArg1] cards at turn start."
  },
  State_2789_Desc = {
    Text = "Card was tampered with by Jenkin! Take [Layer] DMG when played."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Takes [Layer] DMG when played>"
  },
  State_2789_WeaponDesc = {
    Text = "Card takes [StateArg1] DMG when played."
  },
  State_2790_Desc = {
    Text = "At turn end, you can choose to retain [StateArg1] cards in your hand."
  },
  State_2790_Name = {
    Text = "Relic Prophet's Lamp 2"
  },
  State_2790_WeaponDesc = {
    Text = "At the end of your turn, you can choose to retain [StateArg1] cards in your hand."
  },
  State_2792_Desc = {
    Text = "At the start of the battle, all allies gain 3 stacks of [Waxed Armor]. At turn start, shuffle a [Convulsion] into the Draw Pile of your team."
  },
  State_2792_Name = {Text = "\"Wax Lady\""},
  State_2792_WeaponDesc = {
    Text = "At the start of the battle, all allies gain 3 stacks of [Waxed Armor]. At turn start, shuffle a [Convulsion] into your team's Draw Pile."
  },
  State_2793_Desc = {
    Text = "State@Stone Eye's Dying Struggle"
  },
  State_2793_Name = {
    Text = "State@Stone Eye's Dying Struggle"
  },
  State_2793_WeaponDesc = {
    Text = "State@Stone Eye's Dying Struggle"
  },
  State_2796_Desc = {
    Text = "Whenever you lose HP, apply [Arg1] stacks of Poison to all enemies. Increase the Poison value by [Arg2] each turn."
  },
  State_2797_Desc = {
    Text = "At the beginning of the turn, add a \"Parasol\" with [Arg1] Alert obtained this turn to your hand. After playing 6 Cards, increase the Alert of all \"Parasols\" in your hand by [Arg2]."
  },
  State_2798_Desc = {
    Text = "When the Benevolent Priest applies a Shield, reduce the Arithmetica Cost of 1 random card in hand by 1 until it is played."
  },
  State_2798_Name = {
    Text = "All-Father's Compassion"
  },
  State_2798_WeaponDesc = {
    Text = "The Loving High Priest reduces the Arithmetica Cost of 1 random card in your hand by 1 until it is played when applying a Shield."
  },
  State_2799_Desc = {
    Text = "When Moon Jelly deals DMG, triggers [StateArg1] Tentacle attacks on the target."
  },
  State_2799_Name = {
    Text = "Self-Proliferation"
  },
  State_2799_WeaponDesc = {
    Text = "When Hydromedusa deals DMG, it triggers [StateArg1] Tentacle attacks on the target."
  },
  State_2800_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_2800_Name = {
    Text = "State@Prototype Dagger Crit Damage"
  },
  State_2801_Desc = {
    Text = "Increase Deep Dissolution stacks upon taking actual Damage."
  },
  State_2801_Name = {
    Text = "Taking DMG increases Dissolution stacks."
  },
  State_2801_WeaponDesc = {
    Text = "Increase Deep Dissolution stacks upon taking actual Damage"
  },
  State_2802_Desc = {
    Text = "At turn start, gain Temporary STR"
  },
  State_2802_Name = {
    Text = "Gain Temporary STR"
  },
  State_2804_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_2804_Name = {
    Text = "State@Prototype Laser Cannon Crit Damage"
  },
  State_2805_Desc = {
    Text = "At turn end, other allies gain Strength"
  },
  State_2805_Name = {
    Text = "\"Flame of Enlightenment\""
  },
  State_2807_Desc = {
    Text = "At the beginning of the turn, add a \"Parasol\" with [Arg1] Alert obtained this turn to your hand. After playing 6 Cards, increase the Alert of all \"Parasols\" in your hand by [Arg2]."
  },
  State_2808_Desc = {
    Text = "At turn end, generate 1 Embryo Fusion. If there is an Embryo card in hand, recover 15 HP."
  },
  State_2808_Name = {
    Text = "Alienated Hemostat"
  },
  State_2808_WeaponDesc = {
    Text = "At turn end, generate 1 Fusion Level. If there is an Embryo card in hand, recover 15 HP."
  },
  State_2809_Desc = {
    Text = "Permanently lose [Arg1] Strength upon pickup. Heal [Arg2] HP each time you deal Damage, up to 6 times per turn."
  },
  State_2810_Desc = {
    Text = "At turn end, restore [Layer]% of Max HP."
  },
  State_2810_Name = {
    Text = "Self-Healing"
  },
  State_2810_WeaponDesc = {
    Text = "At the end of the monster's turn, restore [Layer]% of max HP"
  },
  State_2811_Desc = {
    Text = "When a Symptom Card is drawn, gain [Arg1] Strength. For each cursed Orison or Cursed Relic owned, Crit. Rate and Crit. DMG increase by 10%."
  },
  State_2812_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_2812_Name = {Text = "Not Roused"},
  State_2813_Desc = {
    Text = "Lose Arithmetica at turn start"
  },
  State_2813_Name = {
    Text = "Miscalculated!"
  },
  State_2814_Desc = {
    Text = "Winning the battle transforms the Orison into a powerful and perilous cursed Orison."
  },
  State_2817_Desc = {
    Text = "Each stack reduces DMG taken by [StateArg1]. Losing 1 stack per Critical Hit."
  },
  State_2817_Name = {
    Text = "Waxed Armor"
  },
  State_2817_WeaponDesc = {
    Text = "Immune to abnormal states, removed upon being critically hit."
  },
  State_2818_Desc = {
    Text = "Splits into Dissolution Triangle A and Dissolution Triangle B."
  },
  State_2818_Name = {Text = "Split"},
  State_2818_WeaponDesc = {
    Text = "Splits into Dissolution Triangle A and Dissolution Triangle B."
  },
  State_2820_Desc = {
    Text = "When played, first gain [StateArg1] Temp. <PowerIconKeywords:STR>, then resolve the card's effects. (Its DMG effects will benefit from this STR.)"
  },
  State_2820_Name = {
    Text = "<Rune_15:Burst>"
  },
  State_2821_Name = {
    Text = "Temporary immunity to Vulnerable"
  },
  State_2823_Desc = {
    Text = "Team Unique: At the start of battle, apply 2 stacks of <VulnerabilityIconKeywords:Vulnerable> to front-row enemies. At turn start, enemies affected by Vulnerable lose Temporary <PowerIconKeywords:STR> equal to the wielder's ATK <WeaponEffect_Num:[StateArg1]%>. If the current Realm is \"Caro\", after the wielder releases \"Exalt\", Embryo Fusion +<WeaponEffect_Num:[StateArg2]%>."
  },
  State_2823_WeaponDesc = {
    Text = "At the start of battle, apply 2 stacks of <VulnerabilityIconKeywords:Vulnerable> to front-row enemies. At turn start, enemies affected by Vulnerable lose <WeaponEffect_Num:[Power:DescArg1]> Temporary <PowerIconKeywords:STR>. If the current realm is \"Caro\", after the wielder releases \"Exalt\", Embryo Fusion increases by +<WeaponEffect_Num:[StateArg2]%>."
  },
  State_2825_Desc = {
    Text = "Monster Ultra Slot Limit"
  },
  State_2825_Name = {
    Text = "Monster Ultra Slot Limit"
  },
  State_2825_WeaponDesc = {
    Text = "Monster Ultra Slot Limit"
  },
  State_2826_Desc = {
    Text = "When 2 cards with lower Arithmetica Cost than the previous one are played consecutively, the Awakener with the lowest Aliemus gains 50 Aliemus."
  },
  State_2826_Name = {
    Text = "Creation Arcana Relic"
  },
  State_2827_Desc = {
    Text = "Number of Hits and DMG Increase."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Upgrade>"
  },
  State_2829_Desc = {
    Text = "Gain [Layer] STR after dealing actual Damage."
  },
  State_2829_Name = {
    Text = "\"Chaotic Persona\""
  },
  State_2830_Desc = {
    Text = "For each [Aequor] class Awakener in the team, the entire team's Max HP (not finished), Defense, and Attack are increased by 50%"
  },
  State_2830_Name = {
    Text = "Aequor Enhancement"
  },
  State_2830_WeaponDesc = {
    Text = "For each [Aequor] class Awakener in the team, the entire team's Max HP (Not completed), Defense, and Attack are increased by 50%."
  },
  State_2831_Desc = {
    Text = "On discard, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_2831_Name = {
    Text = "State Curse Whisper"
  },
  State_2831_WeaponDesc = {
    Text = "When this card is discarded, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_2832_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_2832_Name = {
    Text = "State@Prototype Laser Cannon Resistance"
  },
  State_2833_Desc = {
    Text = "Draw 1 card at turn start. Each card drawn randomly alters its Arithmetica Cost (0-4)."
  },
  State_2834_Desc = {
    Text = "At turn end, generate 1 Embryo Fusion. If there is an Embryo in hand, recover 5 HP."
  },
  State_2834_Name = {
    Text = "Relic Hemostatic Clamp"
  },
  State_2834_WeaponDesc = {
    Text = "At turn end, generate 1 Fusion Level. If there is an Embryo in hand, recover 5 HP."
  },
  State_2835_Desc = {
    Text = "For each Devour, steal [Arg1] Temporary STR from all enemies."
  },
  State_2836_Name = {
    Text = "State@Cursed Blind Obedience"
  },
  State_2837_Name = {
    Text = "State@Cursed Blind Obedience"
  },
  State_2838_Name = {
    Text = "State@Cursed Blind Obedience"
  },
  State_2840_Desc = {
    Text = "Take [Layer] DMG and remove [DescArg1]% of the stacks at turn end. When restoring HP, remove twice the amount of Bleed stacks as the amount healed."
  },
  State_2840_Name = {
    Text = "<BleedingColour:Bleed>"
  },
  State_2840_WeaponDesc = {
    Text = "At turn end, take [Layer] DMG and remove this state. Each heal reduces the stacks by half."
  },
  State_2841_Desc = {
    Text = "Temporarily increase <CardKeyWord:Tentacle DMG>, causing all Tentacles to attack enemies."
  },
  State_2841_Name = {
    Text = "<CardKeyWord:Delirium Surge>"
  },
  State_2841_WeaponDesc = {
    Text = "Temporarily increase <CardKeyWord:Tentacle DMG>, causing all Tentacles to attack enemies."
  },
  State_2842_Desc = {
    Text = "When played, gain [StateArg1] <RetaliateIconKeywords:Counter>, then deal True DMG to all enemies equal to [StateArg2]% of your <RetaliateIconKeywords:Counter>."
  },
  State_2842_Name = {
    Text = "<Rune_9:Spike>"
  },
  State_2843_Desc = {
    Text = "Each time your team plays a card, gain [StateArg1] stacks of Shield for 1 turn."
  },
  State_2843_Name = {
    Text = "Feather Blizzard"
  },
  State_2843_WeaponDesc = {
    Text = "Your team gains [StateArg1] stacks of Shield for each card played. Lasts 1 turn."
  },
  State_2844_Desc = {
    Text = "Gain a Barrier that blocks 1 DMG the first time you lose HP in each battle."
  },
  State_2845_Name = {
    Text = "Accessory: Burial Ground Murmurs"
  },
  State_2845_WeaponDesc = {
    Text = "At the start of the level, Death Resistance increases by 25%. After triggering Death Resistance, the wielder obtains 50 Aliemus."
  },
  State_2846_Desc = {
    Text = "Immune to one death, restores [Arg1] HP after triggering, and permanently disables this Relic."
  },
  State_2847_Desc = {
    Text = "Each time a Hunted Awakener uses a card, 1 Hunting Mark is added, and they draw half the number of cards equal to the current Hunt Mark stack."
  },
  State_2847_Name = {
    Text = "Hunting Ceremony"
  },
  State_2849_Desc = {
    Text = "Each time you lose HP, gain [Arg1] Strength, stacking up to 10 times. At max stacks, restore 25% of the lost HP."
  },
  State_2853_Desc = {
    Text = "Relic Eternal Recliner Count"
  },
  State_2854_Desc = {
    Text = "No Aliemus for Awakeners after death."
  },
  State_2854_Name = {Text = "Selfish"},
  State_2854_WeaponDesc = {
    Text = "No Aliemus for Awakeners after death."
  },
  State_2855_Desc = {
    Text = "\"Strike\" DMG increases by [StateArg1]%, lasting [Layer] turns."
  },
  State_2855_Name = {
    Text = "Surviving Impasse: Strike"
  },
  State_2855_WeaponDesc = {
    Text = "This turn, your Strike Card DMG is boosted by [Layer]%."
  },
  State_2856_Desc = {
    Text = "Team Unique: The wielder's Shield Generation +<WeaponEffect_Num:[StateArg1]%>. When generating Shield, all allies gain Temporary Crit. Rate of <WeaponEffect_Num:[StateArg3]%> and Keyflare from the wielder's Keyflare Regen by <WeaponEffect_Num:[StateArg4]%>, up to 2 times per turn. If the current realm is \"Aequor\", each time a Tentacle attacks, the wielder gains 1 point of Aliemus, up to <WeaponEffect_Num:[StateArg2]> per turn."
  },
  State_2856_WeaponDesc = {
    Text = "The wielder's Shield Generation increases by <WeaponEffect_Num:[StateArg1]％>. When Shield is generated, all allies gain <WeaponEffect_Num:[StateArg3]％> Temporary Crit. Rate and <WeaponEffect_Num:[StateArg4]%> of the wielder's Keyflare Regen as Keyflare, up to 2 times per turn. If the current realm is \"Aequor\", each time a Tentacle attacks, the wielder gains 1 Aliemus, up to <WeaponEffect_Num:[StateArg2]> per turn."
  },
  State_2857_Desc = {
    Text = "All Awakeners gain 10 Aliemus at turn start. Max HP is reduced by 50%."
  },
  State_2858_Name = {
    Text = "Gain 2 extra stacks of Barrier when played"
  },
  State_2859_Desc = {
    Text = "At the start of the battle, this card is fixed in hand."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Innate>"
  },
  State_2860_Desc = {
    Text = "Upon drawing, reduce Max HP by 10%. When used, increase all Awakeners' Crit. DMG by 100% for this turn. Cannot be sold."
  },
  State_2860_Name = {
    Text = "State Curse Dissolution"
  },
  State_2860_WeaponDesc = {
    Text = "Upon drawing, reduce self's Max HP by 10%. After use, increase all Awakeners' Crit. DMG by 100% for this turn. Cannot be sold."
  },
  State_2861_Name = {
    Text = "(Remaining:[Layer])"
  },
  State_2862_Desc = {
    Text = "At turn end, take an additional instance of Poison DMG."
  },
  State_2862_Name = {
    Text = "Physical Weakness"
  },
  State_2863_Desc = {
    Text = "Evolution Layer"
  },
  State_2863_Name = {
    Text = "Evolution Layer"
  },
  State_2863_WeaponDesc = {
    Text = "Evolution Layer"
  },
  State_2864_Desc = {
    Text = "\"24\" has been Roused. Use the final \"Save Me\" to find your chance!"
  },
  State_2864_Name = {
    Text = "\"24\" Rouse!"
  },
  State_2864_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_2865_Desc = {
    Text = "On discard, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_2865_Name = {
    Text = "State Curse Whisper"
  },
  State_2865_WeaponDesc = {
    Text = "When this card is discarded, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_2866_Desc = {
    Text = "Team Unique: Hand Limit +2. At turn end, gain Keyflare equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's Keyflare Regen. Each time a Posse is released, all Awakeners gain <WeaponEffect_Num:[StateArg2]> Aliemus. If the current Realm is \"Caro\", it also increases Embryo Fusion by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2866_WeaponDesc = {
    Text = "Hand limit +2. Gain <WeaponEffect_Num:[DescArg1]> Keyflare at turn end. After each release of the Posse, all Awakeners gain <WeaponEffect_Num:[StateArg2]> Aliemus. If the current Realm is \"Caro\", Embryo Fusion will also increase by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2867_Desc = {
    Text = "Each time a card of an Awakener enters Ultra Space, it gains 15 Aliemus."
  },
  State_2867_Name = {
    Text = "Relic Warp Device"
  },
  State_2867_WeaponDesc = {
    Text = "Each time a card of an Awakener enters Ultra Space, it gains 15 Aliemus."
  },
  State_2868_Desc = {
    Text = "At turn end, for each unplayed card in hand, all Awakeners gain 2 Aliemus."
  },
  State_2871_Desc = {
    Text = "Summon 1 Dissolution Triangle with equal HP when HP is below 50% ([StateArg1])"
  },
  State_2871_Name = {Text = "Summon"},
  State_2871_WeaponDesc = {
    Text = "Summon 1 Dissolution Triangle with equal HP when HP is below 50% ([StateArg1])"
  },
  State_2874_Desc = {
    Text = "When the Awakener is observed by the Skull Hunter, using its card allows drawing 2 extra cards."
  },
  State_2875_Desc = {
    Text = "When played, increase <EmbryoFusionIconKeywords:Embryo Fusion> by +[StateArg1]%."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Adv. Bloodlust>"
  },
  State_2875_WeaponDesc = {
    Text = "When played, increase <EmbryoFusionIconKeywords:Embryo Fusion> by +[StateArg1]%."
  },
  State_2876_Desc = {
    Text = "After the battle, obtain an extra 50 Black Sigils, but develop a random Symptom."
  },
  State_2877_Desc = {
    Text = "Each time Madam in Red deals DMG, she gains [StateArg2] Temporary STR."
  },
  State_2877_Name = {
    Text = "Host Lady's Privilege"
  },
  State_2878_Desc = {
    Text = "Number of attacks increased by 1, but DMG reduced by 25%."
  },
  State_2878_Name = {Text = "Frenzy"},
  State_2878_WeaponDesc = {
    Text = "DMG times increased by 1, but DMG reduced by 25%."
  },
  State_2879_Name = {Text = "Sweet Slug"},
  State_2879_WeaponDesc = {
    Text = "After using \"Annihilation\", if in Tranquil Sea Stance, the wielder's Shield and Healing effects this turn +30%."
  },
  State_2880_Name = {
    Text = "State@Sea Apostle Enlighten 7"
  },
  State_2881_Desc = {
    Text = "Whenever 1 \"Sacrament\" is transformed into \"Obsession\", the Base DMG dealt by Miryam in this battle is increased by 15%."
  },
  State_2881_Name = {
    Text = "Vanity's Collapse"
  },
  State_2883_Desc = {
    Text = "Team Unique: After the wielder deals DMG, there is a <WeaponEffect_Num:[StateArg1]%> chance to draw 1 of their Command Cards and reduce its Arithmetica Cost by 1. This effect activates only once per turn."
  },
  State_2883_WeaponDesc = {
    Text = "After the wielder deals DMG, there is a <WeaponEffect_Num:[StateArg1]%> chance to draw 1 of the wielder's Command Cards and reduce its Arithmetica Cost by 1. This effect only triggers once per turn."
  },
  State_2884_Name = {
    Text = "Deal <PunctureDamagewords:Pierce DMG>. Reduce the Arithmetica Cost of the card with the highest cost in your hand by 1."
  },
  State_2885_Name = {
    Text = "Status: Draw 2 cards at the start of each turn"
  },
  State_2887_Desc = {
    Text = "Team Unique: After the wielder finishes using Exalt, their Crit. DMG is increased by <WeaponEffect_Num:[StateArg1]%> for the rest of this turn. The wielder's cards in hand have a <WeaponEffect_Num:[StateArg2]%> chance to reduce Arithmetica Cost by 1 this turn."
  },
  State_2887_WeaponDesc = {
    Text = "After the wielder uses Exalt, their Crit. DMG is increased by <WeaponEffect_Num:[StateArg1]%> for the rest of this turn. Additionally, there is a <WeaponEffect_Num:[StateArg2]%> chance for all cards held by the wielder to reduce their Arithmetica Cost by 1 point during this turn."
  },
  State_2888_Desc = {
    Text = "If \"Embryo\" is in hand, consume 1 to trigger the Devour effect."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Devour>"
  },
  State_2888_WeaponDesc = {
    Text = "Exhaust embryos in hand, triggering a powerful Devouring effect."
  },
  State_2889_Name = {
    Text = "Choose an Awakener to gain <Energy:[DescArg1]> Aliemus"
  },
  State_2890_Desc = {
    Text = "At the start of the battle, apply 1 stack of Fragile to your team."
  },
  State_2890_Name = {
    Text = "Armor Penetration"
  },
  State_2890_WeaponDesc = {
    Text = "When the battle begins, apply 1 stack of Fragile to your team."
  },
  State_2891_Name = {
    Text = "Aliemus Start Healing Boost"
  },
  State_2892_Desc = {
    Text = "At turn end, restore [Layer] HP."
  },
  State_2892_Name = {
    Text = "Delayed HP Recovery"
  },
  State_2892_WeaponDesc = {
    Text = "Until turn end, heal [Layer] HP for each kill."
  },
  State_2896_Desc = {
    Text = "Increase the number of attacks by [Layer] this turn."
  },
  State_2896_Name = {
    Text = "Temporary Madness"
  },
  State_2897_Desc = {
    Text = "Upon the arrival of Genesis, reduce enemies' Temporary STR."
  },
  State_2897_Name = {
    Text = "Fear Aliemus"
  },
  State_2899_Desc = {
    Text = "If the opponent has 4 or more cards in hand, gain [StateArg1] Shield when taking Damage."
  },
  State_2899_Name = {
    Text = "Serpent Form"
  },
  State_2900_Desc = {
    Text = "DMG dealt is increased by [Layer] in this battle."
  },
  State_2900_Name = {Text = "Strength"},
  State_2900_WeaponDesc = {
    Text = "DMG dealt is increased by [Layer] in this battle."
  },
  State_2901_Desc = {
    Text = "[Exalt] grants 20 Aliemus."
  },
  State_2901_Name = {
    Text = "Relic Veil of the Nameless Deity"
  },
  State_2901_WeaponDesc = {
    Text = "[Exalt] grants 20 Aliemus."
  },
  State_2902_Desc = {
    Text = "Brain in a Vat restores double HP."
  },
  State_2902_Name = {
    Text = "Flesh Detached"
  },
  State_2902_WeaponDesc = {
    Text = "Brain in a Vat restores double HP."
  },
  State_2903_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_2903_Name = {
    Text = "State@Prototype Dagger Crit"
  },
  State_2904_Desc = {
    Text = "Gain 10 Shield after taking actual Damage."
  },
  State_2904_Name = {Text = "Buffer"},
  State_2904_WeaponDesc = {
    Text = "After taking actual Damage, obtain 10 Shield."
  },
  State_2905_Desc = {
    Text = "Team Unique: The shield generated by the wielder's \"Exalt\" is increased by <WeaponEffect_Num:[StateArg2]%>. After the wielder releases \"Exalt\", they obtain Temporary <PowerIconKeywords:STR> equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's DEF. If your team is in a <FragileIconKeywords:Fragile> state, the effect is doubled."
  },
  State_2905_WeaponDesc = {
    Text = "The wielder's \"Exalt\" increases Shield Generation by <WeaponEffect_Num:[StateArg2]%>. After the wielder releases \"Exalt\", they obtain [Power:DescArg1] Temporary <PowerIconKeywords:STR>. If team is in a <FragileIconKeywords:Fragile> state, the effect is doubled."
  },
  State_2906_Desc = {
    Text = "After dealing actual Damage, temporarily reduce your team's Strength by [Layer]."
  },
  State_2906_Name = {
    Text = "Paralysis Shock"
  },
  State_2909_Desc = {
    Text = "Has [Layer] Aliemus. If Aliemus is greater than or equal to 5, the intention becomes \"Twisted Carrion Revel\", and Aliemus will recover upon decrease."
  },
  State_2909_Name = {
    Text = "State@Monster 24 Feast on the Twisted Dead Counter"
  },
  State_2909_WeaponDesc = {
    Text = "Has [Layer] Aliemus. If Aliemus is greater than or equal to 5, the intention becomes \"Twisted Carrion Revel\", and Aliemus will recover upon decrease."
  },
  State_2910_Desc = {
    Text = "Team Unique: At the start of exploration, add one \"Insight\" and the wielder's \"Strike\" to the deck. the wielder's \"Strike\" Base DMG increases by <WeaponEffect_Num:[StateArg1]%>, and after playing, there is a <WeaponEffect_Num:[StateArg2]%> chance to draw 1 card. This effect can trigger a maximum of once per turn. If the current Realm is \"Ultra\" and during the Ultra Round, the \"Strike\" will place 1 \"Insight\" into hand, triggering a maximum of once during that turn."
  },
  State_2910_WeaponDesc = {
    Text = "At the start of the exploration, add a card of \"Insight\" and the wielder's \"Strike\" to the deck. The Base DMG of the wielder's \"Strike\" increases by <WeaponEffect_Num:[StateArg1]%>, and there is a <WeaponEffect_Num:[StateArg2]%> chance to draw 1 card after it is played. This effect can trigger a maximum of 1 time per turn. If the current realm is \"Ultra\" and during the Ultra Round, \"Strike\" will place 1 \"Insight\" into hand, triggering a maximum of 1 time that turn."
  },
  State_2911_Desc = {
    Text = "State@Counter of the Pure White Phantasm World"
  },
  State_2911_Name = {
    Text = "State@Pure White Fantasy World Count"
  },
  State_2911_WeaponDesc = {
    Text = "State@Counter of the Pure White Phantasm World"
  },
  State_2912_Desc = {
    Text = "You are the target! After being played, the Seafarer's Elite Guards gain [StateArg1] Temporary STR and remove the Mark of Abyss."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Mark of Abyss>"
  },
  State_2912_WeaponDesc = {
    Text = "After the card is played, the Deep Diver Bodyguard obtains [StateArg1] Temporary STR."
  },
  State_2913_Desc = {
    Text = "At the start of the battle, become Vulnerable for 3 turns."
  },
  State_2913_Name = {
    Text = "Relic Eerie Hook 2"
  },
  State_2913_WeaponDesc = {
    Text = "Fragile self for 3 turns when the battle begins."
  },
  State_2914_Desc = {
    Text = "When HP is below 50%, intention changes to summon a [Dissolution Triangle] with equal HP."
  },
  State_2914_Name = {Text = "Fission"},
  State_2914_WeaponDesc = {
    Text = "When HP is below 50%, the intention changes to summon a [Dissolution Triangle] with equal HP."
  },
  State_2915_Desc = {
    Text = "Increase the number of DMG instances of \"Chain of Resentment\" by +[Layer]."
  },
  State_2915_Name = {Text = "Hatred"},
  State_2915_WeaponDesc = {
    Text = "Increases the DMG of \"Chain of resentment\" by [Layer] times."
  },
  State_2917_Desc = {
    Text = "At turn end, for each remaining card in hand, gain 1 Arithmetica at the start of next turn."
  },
  State_2917_Name = {
    Text = "State@Phantom Silver Key: Calculation"
  },
  State_2918_Desc = {
    Text = "Reduce DMG taken by 99%. Remove 1 stack after receiving Active DMG, and restore to 3 stacks at turn start."
  },
  State_2918_Name = {
    Text = "\"Immortal Remnant\""
  },
  State_2918_WeaponDesc = {
    Text = "Reduce DMG taken by 99%. Remove 1 stack after taking Active DMG, and restore to 3 stacks at the start of your turn."
  },
  State_2919_Desc = {
    Text = "State@Emerald Jadefire Image Advance"
  },
  State_2919_Name = {
    Text = "State@Emerald Jadefire Image Advance"
  },
  State_2919_WeaponDesc = {
    Text = "State@Emerald Jadefire Image Advance"
  },
  State_2922_Desc = {
    Text = "For every 1 Arithmetica consumed, the corresponding Awakener gains 2 Aliemus."
  },
  State_2923_Desc = {
    Text = "At turn end, increase Strength by [Layer]."
  },
  State_2923_Name = {
    Text = "Divine Descent Ritual"
  },
  State_2923_WeaponDesc = {
    Text = "You obtain [Layer] STR at the end of each turn."
  },
  State_2925_Desc = {
    Text = "Emerald Fire adds one stack with each instance of DMG."
  },
  State_2925_Name = {
    Text = "Emerald Reflection Count"
  },
  State_2925_WeaponDesc = {
    Text = "+1 Stack for each instance of DMG Emerald Fire deals"
  },
  State_2927_Name = {
    Text = "State@Cursed Hallucinations Change"
  },
  State_2929_Desc = {
    Text = "Team Unique: For every instance of DMG dealt by the wielder, there is a <WeaponEffect_Num:[StateArg3]%> chance for the wielder to gain 2% Temporary Crit. DMG. After the wielder releases Exalt, they deal Active DMG 3 times to a random enemy equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's ATK. If the current realm is \"Caro\", for every embryo devoured, Embryo Fusion increases by +<WeaponEffect_Num:[StateArg2]%>."
  },
  State_2929_WeaponDesc = {
    Text = "For every instance of DMG dealt by the wielder, there is a <WeaponEffect_Num:[StateArg3]%> chance for the wielder to gain 2% Temporary Crit. DMG. After the wielder releases Exalt, they deal Active DMG of [DescArg1] to a random enemy three times. If the current realm is \"Caro\", for each embryo the wielder devours, Embryo Fusion will increase by +<WeaponEffect_Num:[StateArg2]%>."
  },
  State_2930_Name = {
    Text = "State@George@Gain Strength upon death"
  },
  State_2931_Desc = {
    Text = "Each time you Devour, steal 4 Temporary STR from all enemies."
  },
  State_2931_Name = {
    Text = "Altered Silkworm Agate"
  },
  State_2933_Name = {
    Text = "Accessory: Twisted Twin White"
  },
  State_2933_WeaponDesc = {
    Text = "At the start of even turns, add the wielder's \"Defense\" with Exhaust and Fleeting to your hand."
  },
  State_2934_Desc = {
    Text = "All DMG taken is increased by [DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:Vulnerable>"
  },
  State_2934_WeaponDesc = {
    Text = "All DMG taken is increased by 50%."
  },
  State_2937_Desc = {
    Text = "Upon gaining a Shield for the 3rd time, also gain an equal amount of Counter."
  },
  State_2938_Desc = {
    Text = "Draw 1 card at the start of your turn, and you may choose to keep 1 card in your hand at the end of your turn."
  },
  State_2939_Name = {
    Text = "Immune to Fragile"
  },
  State_2940_Desc = {
    Text = "Regeneration effect improved."
  },
  State_2940_Name = {
    Text = "Growing Stronger with Aberrant Blood"
  },
  State_2941_Desc = {
    Text = "When played, inflict [StateArg1] <IntoxicationIconKeywords:Poison> on all enemies, then trigger [StateArg2]% of each enemy's <IntoxicationIconKeywords:Poison>."
  },
  State_2941_Name = {
    Text = "<Rune_10:Toxin>"
  },
  State_2942_Desc = {
    Text = "At turn end, restores [Layer]% HP to other allies and removes ongoing Damage."
  },
  State_2942_Name = {
    Text = "Battlefield Medic"
  },
  State_2946_Desc = {
    Text = "Frenzied combo grants an extremely high Shield."
  },
  State_2946_Name = {
    Text = "\"Static Fortress\""
  },
  State_2946_WeaponDesc = {
    Text = "Frenzied combo grants an extremely high Shield."
  },
  State_2947_Name = {Text = "Dissolve 2"},
  State_2948_Desc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_2948_Name = {
    Text = "Change Arithmetica Cost before playing"
  },
  State_2948_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_2949_Name = {
    Text = "Wheel of Destiny Battle: Abandon Orison"
  },
  State_2950_Desc = {
    Text = "At the start of the battle, this card is fixed in hand."
  },
  State_2950_Name = {
    Text = "<CardKeyWord:Innate>"
  },
  State_2951_Desc = {
    Text = "Relic Eternal Recliner"
  },
  State_2952_Desc = {
    Text = "After the turn ends, restore [Layer] HP. Remove 1 stack for every 5 HP lost."
  },
  State_2952_Name = {
    Text = "Regeneration"
  },
  State_2954_Name = {
    Text = "State@2-8Monster24@Save me"
  },
  State_2955_Desc = {
    Text = "All enemies lose HP. Permanent, Destroy."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Illusion's End>"
  },
  State_2955_WeaponDesc = {
    Text = "All enemies lose HP. Permanent, Destroy."
  },
  State_2956_Desc = {
    Text = "Each instance of DMG taken grants all Awakeners [StateArg1] Aliemus."
  },
  State_2956_Name = {
    Text = "Phantasmal Beam"
  },
  State_2956_WeaponDesc = {
    Text = "Each instance of DMG taken grants all Awakeners [StateArg1] Aliemus."
  },
  State_2957_Desc = {
    Text = "After death, summon a [Dissolution Triangle] with 1/3 of your HP in place"
  },
  State_2957_Name = {
    Text = "Dissolution"
  },
  State_2957_WeaponDesc = {
    Text = "After death, summon a [Dissolution Triangle] with 1/3 of your HP at the location."
  },
  State_2960_Desc = {
    Text = "On even turns, gain 2 Arithmetica if your Arithmetica is 0."
  },
  State_2960_Name = {
    Text = "Antique Puzzle"
  },
  State_2960_WeaponDesc = {
    Text = "On even turns, obtain 2 Arithmetica if your Arithmetica is 0."
  },
  State_2961_Desc = {
    Text = "Team Unique: The wielder's <IntoxicationIconKeywords:Poison> effect is increased by <WeaponEffect_Num:[StateArg1]%>. Before the wielder releases an Exalt, they first apply Poison equal to <WeaponEffect_Num:[StateArg2]%> of their ATK to all enemies. After using a Posse, the wielder gains <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_2961_WeaponDesc = {
    Text = "The wielder's <IntoxicationIconKeywords:Poison> DMG is increased by <WeaponEffect_Num:[StateArg1]%>. Before the wielder releases an Exalt, they first inflict <WeaponEffect_Num:[Poison:DescArg1]> stacks of Poison on all enemies. After using the Posse, the wielder gains <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_2962_Desc = {
    Text = "When played, inflict [StateArg1] turn of <WeaknessIconKeywords:Weakness> on all enemies."
  },
  State_2962_Name = {
    Text = "<Rune_2:Weakness>"
  },
  State_2963_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_2964_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_2965_Name = {
    Text = "State@Crescent Maid Enlighten 7"
  },
  State_2967_Desc = {
    Text = "When using Symptom Cards, Pandia's state alternates between \"Restless\" and \"Debauchery\". Restless: +1 attack, reduced strength. Debauchery: -1 attack, increased strength"
  },
  State_2967_Name = {
    Text = "Pandia Rouse!"
  },
  State_2967_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_2968_Name = {
    Text = "State@Stage2_14Battle8Bubble4"
  },
  State_2969_Name = {
    Text = "State@Level2_14Battle8Bubble5"
  },
  State_2970_Desc = {
    Text = "Primordial Offspring"
  },
  State_2970_Name = {
    Text = "Primordial Offspring"
  },
  State_2970_WeaponDesc = {
    Text = "Primordial Offspring"
  },
  State_2971_Desc = {
    Text = "State@Prologue: Reduce HP by Half"
  },
  State_2971_Name = {
    Text = "State@Prologue: Reduce HP by Half"
  },
  State_2971_WeaponDesc = {
    Text = "State@Prologue: Reduce HP by Half"
  },
  State_2972_Name = {
    Text = "State@Level2_14Battle8Bubble2"
  },
  State_2973_Name = {
    Text = "State@Level2_14Battle8Bubble3"
  },
  State_2975_Desc = {
    Text = "The first 5 Leap effects in each battle are triggered an additional time."
  },
  State_2976_Desc = {
    Text = "At turn end, if your Shield is 0 or a multiple of 10, gain [Arg1] Shield. If your HP is a multiple of 10, gain [Arg2] Strength."
  },
  State_2977_Desc = {
    Text = "On odd turns, if you have 0 cards in hand, draw 2 cards."
  },
  State_2977_Name = {
    Text = "Antique Puzzle"
  },
  State_2977_WeaponDesc = {
    Text = "On odd turns, when you have 0 cards in hand, draw 2 cards."
  },
  State_2978_Desc = {
    Text = "Reduces by 1 stack for each point of DMG taken. Switch to Defense mode when the number of stacks reaches 0."
  },
  State_2978_Name = {Text = "Card Count"},
  State_2978_WeaponDesc = {
    Text = "Loses 1 stack for every 1 DMG taken. Switches to Defense mode when stacks reach 0."
  },
  State_2979_Desc = {
    Text = "Team Unique: The wielder's Poison and Shield Generation +<WeaponEffect_Num:[StateArg3]%>. the wielder's \"Strike\" Crit. Rate and Crit. DMG increase by <WeaponEffect_Num:[StateArg1]%>, and gain a Shield equal to <WeaponEffect_Num:[StateArg2]%> of Max HP. The Shield Effect can only activate once per turn."
  },
  State_2979_WeaponDesc = {
    Text = "The wielder's Poison and Shield Generation effects are increased by <WeaponEffect_Num:[StateArg3]%>. The wielder's \"Strike\" Crit. Rate and Crit. DMG are increased by <WeaponEffect_Num:[StateArg1]%>, and they gain Shield equal to [StateArg2]% ([DescArg1]) of Max HP, with the shield effect activating once per turn."
  },
  State_2983_Desc = {
    Text = "If kept in hand during discard phase, Exhaust. Won't reappear."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:Fleeting>"
  },
  State_2983_WeaponDesc = {
    Text = "If it remains in your hand during the discard phase, it will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_2984_Name = {
    Text = "Gain [Block:DescArg1] Shield"
  },
  State_2985_Desc = {
    Text = "Until turn end, each time you deal Damage, recover [Layer] HP at turn end."
  },
  State_2985_Name = {
    Text = "Diamond in the Rough"
  },
  State_2985_WeaponDesc = {
    Text = "Until turn end, restore [Layer] HP each time DMG is dealt."
  },
  State_2987_Desc = {Text = "Event 19_1"},
  State_2987_Name = {Text = "Event 19_1"},
  State_2987_WeaponDesc = {Text = "Event 19_1"},
  State_2988_Desc = {
    Text = "When devouring embryos, they return from the Discard Pile to the hand, and arithmetica becomes zero."
  },
  State_2988_Name = {
    Text = "Malefic Offspring"
  },
  State_2988_WeaponDesc = {
    Text = "When devouring embryos, they return from the Discard Pile to the Hand Deck, and Arithmetica becomes zero."
  },
  State_2989_Desc = {
    Text = "After playing an Awakener card, shuffle a Temporary copy of that card with its cost reduced by 1 into the deck."
  },
  State_2990_Desc = {
    Text = "When played, inflict [StateArg1] Temp. <ExhaustionIconKeywords:STR▼> on all enemies."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Adv. Drain>"
  },
  State_2992_Desc = {
    Text = "After drawing \"Void\", reduce all Awakeners' gained Aliemus by 50% this turn."
  },
  State_2992_Name = {Text = "Void"},
  State_2992_WeaponDesc = {
    Text = "After drawing \"Void\", all Awakeners' obtained Aliemus is reduced by 50% this turn."
  },
  State_2993_Name = {
    Text = "Relic Serpent Skin Shed Count"
  },
  State_2994_Desc = {
    Text = "Tentacle DMG increases by [StateArg1] when Tentacles are overflowing."
  },
  State_2994_Name = {
    Text = "Power of Blessing"
  },
  State_2994_WeaponDesc = {
    Text = "Tentacle DMG +[StateArg1] when Tentacles are overflowing."
  },
  State_2995_Desc = {
    Text = "Each Devour steals [StateArg1] Temporary STR from all enemies."
  },
  State_2995_Name = {
    Text = "Relic Filigree Agate"
  },
  State_2996_Desc = {
    Text = "When played, trigger [StateArg1] Tentacle attack."
  },
  State_2996_Name = {
    Text = "<Rune_11:Dominion>"
  },
  State_2997_Desc = {
    Text = "After dealing the 3rd DMG each turn, gain [Arg1] Shield. After dealing the 6th DMG each turn, gain [Arg2] Strength."
  },
  State_3001_Desc = {
    Text = "Increase the amount of Aliemus gained by 2 when attacked."
  },
  State_3002_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3002_Name = {
    Text = "State@Prototype Laser Cannon Luck"
  },
  State_3003_Desc = {
    Text = "Disappears from your deck after being played."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Exhaust>"
  },
  State_3003_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_3004_Desc = {
    Text = "[Layer] Immune to being inflicted with the Poison state during the turn."
  },
  State_3004_Name = {
    Text = "Immune to Poison"
  },
  State_3008_Desc = {
    Text = "At turn start, add 1 stack of Stagnation to the remaining cards in your hand. Cards with an Arithmetica Cost greater than 5 will turn into stone."
  },
  State_3008_Name = {
    Text = "Aigis Rouse!"
  },
  State_3008_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_3011_Desc = {
    Text = "Team Unique: The Crit. Rate and Crit. DMG of the wielder's \"Exalt\" are increased by <WeaponEffect_Num:[StateArg2]%>. After the wielder releases \"Exalt\", they gain <PowerIconKeywords:STR> equal to their CON <WeaponEffect_Num:[StateArg1]%>. If this Exalt triggers the <CardKeyWord:Devour> effect, they gain additional 1 instance of <PowerIconKeywords:STR>."
  },
  State_3011_WeaponDesc = {
    Text = "The wielder's \"Exalt\" Crit. Rate and Crit. DMG are increased by <WeaponEffect_Num:[StateArg2]%>. After the wielder releases \"Exalt,\" they gain <WeaponEffect_Num:[Power:DescArg1]> Strength. If this Exalt triggers the <CardKeyWord:Devour> Effect, they additionally obtain 1 <PowerIconKeywords:STR>."
  },
  State_3012_Desc = {
    Text = "Useless empty state"
  },
  State_3012_Name = {
    Text = "Useless empty state"
  },
  State_3012_WeaponDesc = {
    Text = "Useless empty state"
  },
  State_3013_Desc = {
    Text = "When Sanguivore Patient enhances Embryo Fusion, gain [StateArg1] Strength."
  },
  State_3013_Name = {Text = "Sanguivore"},
  State_3014_Desc = {
    Text = "If the opponent has 4 or more cards in hand, gain [StateArg1] Shield when taking Damage."
  },
  State_3014_Name = {
    Text = "Serpent Form"
  },
  State_3015_Desc = {
    Text = "State@Wax Armor - Our Team"
  },
  State_3015_Name = {
    Text = "State@Wax Armor - Our Team"
  },
  State_3015_WeaponDesc = {
    Text = "State@Wax Armor - Our Team"
  },
  State_3016_Desc = {
    Text = "The summoned monsters' HP is doubled."
  },
  State_3016_Name = {
    Text = "\"Overflowing Guilt\""
  },
  State_3016_WeaponDesc = {
    Text = "The summoned monsters' HP is doubled."
  },
  State_3017_Name = {
    Text = "State@Cursed Hallucinations"
  },
  State_3018_Desc = {
    Text = "\"Dimensional Hound\" removes 1 stack for each lost HP; when the stacks reach 0, gain a [StateArg1] Shield and regain [StateArg2] Dimensional Barrier."
  },
  State_3018_Name = {
    Text = "Dimensional Barrier"
  },
  State_3019_Desc = {
    Text = "For every 10 consumed Black Sigils, restore 1% of HP"
  },
  State_3019_Name = {
    Text = "Relic Reversal Root State"
  },
  State_3019_WeaponDesc = {
    Text = "Consuming 10 Black Sigils restores 1% HP"
  },
  State_3020_Desc = {
    Text = "If you took DMG last turn, gain immunity for 1 turn at the start of this turn."
  },
  State_3020_Name = {Text = "Adapt"},
  State_3020_WeaponDesc = {
    Text = "If you took DMG last turn, obtain immunity for 1 turn at the start of this turn."
  },
  State_3021_Desc = {
    Text = "At turn start, gain 1 Arithmetica."
  },
  State_3021_Name = {
    Text = "State@Max Arithmetica -2"
  },
  State_3023_Desc = {
    Text = "This turn, each time you are attacked, deal [Layer] DMG to the attacker."
  },
  State_3023_Name = {
    Text = "Temporary Counter"
  },
  State_3023_WeaponDesc = {
    Text = "This turn, each time you are attacked, deal [Layer] DMG to the attacker."
  },
  State_3024_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3024_Name = {
    Text = "State@Prototype Dagger Death Resistance"
  },
  State_3025_Desc = {
    Text = "Each card played increases the Crit. Rate by 10% this turn."
  },
  State_3026_Desc = {
    Text = "At the start of battle, [StateArg1] copies of this card were shuffled into the Draw Pile. (This Orison affixed <RetainIconKeywords:Retain> to the cards.)"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Adv. Mirror>"
  },
  State_3026_WeaponDesc = {
    Text = "At the start of battle, [StateArg1] copies of this card were shuffled into the Draw Pile. (This Orison affixed <RetainIconKeywords:Retain> to the cards.)"
  },
  State_3027_Desc = {
    Text = "After the battle, obtain an extra 50 Black Sigils, but develop a random Symptom."
  },
  State_3028_Name = {
    Text = "State@Turn Start Arithmetica +2"
  },
  State_3029_Desc = {
    Text = "Reduces by 1 stack for each point of DMG taken. Switch to Defense mode when the number of stacks reaches 0."
  },
  State_3029_Name = {Text = "Card Count"},
  State_3029_WeaponDesc = {
    Text = "Loses 1 stack for every 1 DMG taken. Switches to Defense mode when stacks reach 0."
  },
  State_3033_Desc = {
    Text = "When playing 10 cards, gain a barrier that blocks any Damage. If you already have a barrier, restore [Arg1] HP instead."
  },
  State_3034_Desc = {
    Text = "Team Unique: Each time a card of the wielder is played, gain <WeaponEffect_Num:[StateArg1]> Keyflare. This effect can trigger up to 3 times per turn."
  },
  State_3034_WeaponDesc = {
    Text = "For each card played by the wielder, gain <WeaponEffect_Num:[StateArg1]> Keyflare. This effect can trigger up to 3 times per turn."
  },
  State_3035_Desc = {
    Text = "When played, trigger [StateArg1] Tentacle attacks."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Adv. Dominion>"
  },
  State_3035_WeaponDesc = {
    Text = "When played, trigger [StateArg1] Tentacle attacks."
  },
  State_30364_Desc = {
    Text = "When this card is in hand, the hand limit increases by 1."
  },
  State_30364_Name = {
    Text = "Ignore Hand Size Limit"
  },
  State_30369_Desc = {
    Text = "Hand Limit this turn increased by +[Layer]."
  },
  State_30369_Name = {
    Text = "Maximum Hand Size"
  },
  State_3036_Desc = {
    Text = "Increase the effect of Fragile and Weakness from 33% to 50%."
  },
  State_3036_Name = {
    Text = "\"Echoes of Annihilation\""
  },
  State_3036_WeaponDesc = {
    Text = "The effect of Fragile and Weakness is increased from 33% to 50%."
  },
  State_3038_Desc = {
    Text = "Team Unique: After triggering Posse, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3038_WeaponDesc = {
    Text = "After releasing the Posse, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3039_Name = {
    Text = "Gain [DescArg1] Strength"
  },
  State_3040_Desc = {
    Text = "At turn start, apply [Layer] stacks of [Bind] to my team."
  },
  State_3040_Name = {Text = "Bondage"},
  State_3040_WeaponDesc = {
    Text = "At turn start, apply [Layer] stacks of Bondage to your team."
  },
  State_3041_Desc = {
    Text = "Permanently remains in the deck."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Symptom Card>"
  },
  State_3042_Desc = {
    Text = "Gain [Arg1] Strength this turn when dealing Damage, stacking up to 3 times. Double the Effect when fully stacked."
  },
  State_3043_Desc = {
    Text = "Even turns: DMG received reduced by 50%, DMG dealt increased by 33%."
  },
  State_3043_Name = {Text = "Fickle"},
  State_3043_WeaponDesc = {
    Text = "Even turns: DMG received -50%, DMG dealt +33%."
  },
  State_3044_Desc = {
    Text = "On discard, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_3044_Name = {
    Text = "State Curse Destruction"
  },
  State_3044_WeaponDesc = {
    Text = "When this card is discarded, all Awakeners lose 10 Aliemus. Cannot be sold."
  },
  State_3045_Desc = {
    Text = "After Exalt, the corresponding Awakener gains 20 Aliemus."
  },
  State_3046_Desc = {
    Text = "Team Unique: Gain [StateArg1] Black Sigils each time an enemy dies. After the wielder kills an enemy, the wielder's Crit. DMG in this level permanently increases by <WeaponEffect_Num:[StateArg2]%>, stacking up to 5 stacks. Each time the wielder triggers the Leap effect, increase the Final DMG dealt by the wielder this turn by <WeaponEffect_Num:[StateArg3]%>, stacking up to 3 stacks."
  },
  State_3046_WeaponDesc = {
    Text = "Gain [StateArg1] Black Sigil each time an enemy dies. When the wielder kills an enemy, the wielder's Crit. DMG in this encounter permanently increases by <WeaponEffect_Num:[StateArg2]%>, stacking up to 5 stacks. Each time the wielder triggers a Leap effect, the Final DMG dealt by the wielder this turn increases by <WeaponEffect_Num:[StateArg3]%>, stacking up to 3 stacks."
  },
  State_3047_Desc = {
    Text = "Gain [Arg1] Shield at turn start, increasing by [Arg2] every turn."
  },
  State_3048_Desc = {
    Text = "Lotan's Battle Intent never ceases. At the end of each turn, Lotan removes 3 stacks of Weakness and Vulnerable State."
  },
  State_3048_Name = {
    Text = "Lotan Rouse"
  },
  State_3049_Desc = {
    Text = "Increases the number of DMG instances for George's next attack by 1."
  },
  State_3049_Name = {Text = "Resentment"},
  State_3049_WeaponDesc = {
    Text = "Increases the number of DMG instances for George's next attack by 1."
  },
  State_3050_Desc = {
    Text = "At the start of battle, shuffle one [Convulsion] into your Draw Pile."
  },
  State_3050_Name = {Text = "Fear"},
  State_3050_WeaponDesc = {
    Text = "At the start of battle, shuffle one [Convulsion] into your Draw Pile."
  },
  State_3051_Desc = {
    Text = "Shuffle a Cry into the Draw Pile when dealing unblockable Damage."
  },
  State_3051_Name = {
    Text = "Wax-Hot Desire"
  },
  State_3051_WeaponDesc = {
    Text = "Shuffle a \"Cry Out\" card into the Draw Pile after dealing actual Damage."
  },
  State_3054_Name = {
    Text = "State@Cursed Shock"
  },
  State_3055_Desc = {
    Text = "At the start of the battle, apply 1 stack of Fragile to your team."
  },
  State_3055_Name = {Text = "Penetrate"},
  State_3055_WeaponDesc = {
    Text = "When the battle begins, apply 1 stack of Fragile to your team."
  },
  State_3056_Desc = {
    Text = "At turn end, remove 1 stack of Weakness and Vulnerable."
  },
  State_3056_Name = {Text = "Ominous"},
  State_3058_Desc = {
    Text = "For each Tentacle, gain [Arg1] Shield at turn end."
  },
  State_3060_Desc = {
    Text = "Gain [Layer] Shield at the start of next turn."
  },
  State_3060_Name = {
    Text = "Psyche Reforged"
  },
  State_3060_WeaponDesc = {
    Text = "Draw [Layer] cards at the start of next turn."
  },
  State_3063_Desc = {
    Text = "Inflict [Layer] Poison when dealing actual Damage."
  },
  State_3063_Name = {Text = "Toxin"},
  State_3064_Desc = {
    Text = "Take an equal number of DMG stacks before playing the card. Remove at turn end."
  },
  State_3064_Name = {Text = "Bondage"},
  State_3064_WeaponDesc = {
    Text = "Take an equal number of DMG stacks before playing the card. Remove at turn end."
  },
  State_3065_Name = {
    Text = "State@Relic Past Offering 2"
  },
  State_3066_Desc = {
    Text = "The Arithmetica Cost of this Card has been reduced by [Layer] and will be restored at turn end."
  },
  State_3066_Name = {
    Text = "Trickster's Hat"
  },
  State_3067_Desc = {
    Text = "The Arithmetica Cost of this card has increased by [Layer] and will be restored at turn end."
  },
  State_3067_Name = {
    Text = "Trickster's Hat"
  },
  State_3068_Desc = {
    Text = "At turn end, deals [Layer] DMG to the holder."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Poison>"
  },
  State_3068_WeaponDesc = {
    Text = "At turn end, deals [Layer] DMG to the holder"
  },
  State_3069_Name = {
    Text = "Accessory: Deus Ex Machina"
  },
  State_3069_WeaponDesc = {
    Text = "You obtain 1 additional Arithmetica at the start of the first Turn of each Battle."
  },
  State_3070_Desc = {
    Text = "Team Unique: The wielder's \"Strike\" causes the target enemy to lose Temporary <PowerIconKeywords:STR> equal to <WeaponEffect_Num:[StateArg1]%> the wielder's ATK. This effect can trigger a maximum of 3 times per turn."
  },
  State_3070_WeaponDesc = {
    Text = "The wielder's \"Strike\" temporarily reduces the target enemy's <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:STR>. This effect can trigger a maximum of 3 times per turn."
  },
  State_3071_Desc = {
    Text = "Team Unique: After playing the wielder's \"Defense\", gain Temporary <PowerIconKeywords:STR> equal to <WeaponEffect_Num:[StateArg1]%> the wielder's ATK."
  },
  State_3071_WeaponDesc = {
    Text = "After playing the wielder's \"Defense\", gain <WeaponEffect_Num:[Power:DescArg1]> Temporary <PowerIconKeywords:STR>."
  },
  State_3072_Desc = {
    Text = "Team Unique: After killing an enemy, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus and 1% Crit. DMG, effective for the entire exploration."
  },
  State_3072_WeaponDesc = {
    Text = "After killing an enemy, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus and 1% Crit. DMG, effective for the entire exploration."
  },
  State_3073_Desc = {
    Text = "Team Unique: After the wielder uses Exalt, all allies' Crit. Rate + <WeaponEffect_Num:[StateArg1]%> this turn."
  },
  State_3073_WeaponDesc = {
    Text = "After the wielder releases Exalt, all allies' Crit. Rate + <WeaponEffect_Num:[StateArg1]%> this turn."
  },
  State_3074_Desc = {
    Text = "Team Unique: After playing a Symptom card, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus. This effect triggers up to 2 times per turn. After playing a Command Card, the wielder gains 1 Aliemus."
  },
  State_3074_WeaponDesc = {
    Text = "Play a Symptom Card. The wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus. This effect can trigger up to 2 times per turn. When the wielder plays 1 Command Card, they gain 1 Aliemus."
  },
  State_3075_Desc = {
    Text = "Team Unique: After Exalt, gain Shield equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's DEF."
  },
  State_3075_WeaponDesc = {
    Text = "After the wielder releases Exalt, gain <WeaponEffect_Num:[Block:DescArg1]> Shields."
  },
  State_3076_Desc = {
    Text = "Team Unique: After dealing Damage, the wielder's Crit. Rate + <WeaponEffect_Num:[StateArg1]%>. After a critical hit, the Crit. Rate gained from this effect is reset."
  },
  State_3076_WeaponDesc = {
    Text = "After dealing Damage, the wielder's Crit. Rate + <WeaponEffect_Num:[StateArg1]%>. Upon landing a Critical Hit, the obtained Crit. Rate is cleared."
  },
  State_3078_Desc = {
    Text = "This turn, all DMG dealt is guaranteed to be a Critical Hit."
  },
  State_3078_Name = {
    Text = "Temporary Guaranteed Crit"
  },
  State_3078_WeaponDesc = {
    Text = "Crit. Rate + 100% this turn."
  },
  State_3082_Desc = {
    Text = "After Exalt, place a random card corresponding to the Awakener into hand. The card gains Exhaust and Fleeting."
  },
  State_3084_Desc = {
    Text = "When played, add [StateArg1] copies of it to Temporary <DimensionalSpaceIconKeywords:Ultra Space> slots."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Adv. Warp>"
  },
  State_3084_WeaponDesc = {
    Text = "When played, add [StateArg1] copies of it to Temporary <DimensionalSpaceIconKeywords:Ultra Space> slots."
  },
  State_3086_Name = {
    Text = "Draw [Layer] cards"
  },
  State_3087_Desc = {
    Text = "\"Strike\" DMG increased by [Layer]%."
  },
  State_3087_Name = {
    Text = "Attack card DMG temporarily increased"
  },
  State_3087_WeaponDesc = {
    Text = "Strike card DMG increased by [Layer]%."
  },
  State_3088_Desc = {
    Text = "Active DMG received increases by [Layer]. Dissolution wounds expand with each hit and recover at turn start."
  },
  State_3088_Name = {
    Text = "Deep Dissolution"
  },
  State_3088_WeaponDesc = {
    Text = "Active DMG taken is increased by [Layer]. Each time DMG is taken, the Dissolution Wound expands and recovers at the start of the Turn."
  },
  State_3092_Name = {
    Text = "In Boss Battles, all Awakeners gain 30 Aliemus and are released from the Sealed State."
  },
  State_3093_Name = {
    Text = "State@Magician's Mimicry Count"
  },
  State_3094_Desc = {
    Text = "When drawn, make yourself Fragile for 1 turn. Upon use, make all enemies Vulnerable for 1 turn. Cannot be sold."
  },
  State_3094_Name = {
    Text = "State Curse Collapse"
  },
  State_3094_WeaponDesc = {
    Text = "When drawn, make yourself Fragile for 1 turn. Upon use, make all enemies Vulnerable for 1 turn. Cannot be sold."
  },
  State_3095_Desc = {
    Text = "DMG dealt in this stage increased by [Layer]."
  },
  State_3095_Name = {
    Text = "Permanent Strength"
  },
  State_3095_WeaponDesc = {
    Text = "DMG dealt in this stage is increased by [Layer]."
  },
  State_3096_Desc = {
    Text = "There is still a long way to go to convince Lotan."
  },
  State_3096_Name = {
    Text = "Lotan Rouse"
  },
  State_3098_Desc = {
    Text = "Upon pickup, choose a card to permanently reduce its Arithmetica Cost to 1."
  },
  State_3099_Desc = {
    Text = "After releasing an Exalt, gain [Arg1] Strength this turn."
  },
  State_3100_Desc = {
    Text = "At turn start, Death Resistance increases by 10%. When Death Resistance exceeds 100%, gain an additional 30 Realm Mastery."
  },
  State_3104_Desc = {
    Text = "This turn, for each instance of Active DMG received, increase the DMG count of \"Sweet Demon\" by +1."
  },
  State_3104_Name = {
    Text = "Shared Suffering"
  },
  State_3104_WeaponDesc = {
    Text = "This turn, for each time it takes Active DMG, the \"Sweet Demon\" DMG times +1."
  },
  State_3106_Desc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 2 \"Experimental Creations\" with equal HP."
  },
  State_3106_Name = {Text = "Split"},
  State_3106_WeaponDesc = {
    Text = "When HP is below 50% ([StateArg1]), it will split into 3 \"II-Type Dissoluted Entity Wax Sculptures\" with equal HP."
  },
  State_3108_Name = {
    Text = "Accessory: Ring of Verse"
  },
  State_3108_WeaponDesc = {
    Text = "At the start of even turns, obtain 1 Arithmetica."
  },
  State_3109_Name = {
    Text = "State@Chapter 4 Resonance@Arithmetica -1"
  },
  State_3109_WeaponDesc = {
    Text = "\"Innocent Return Gift\" Arithmetica Cost -1"
  },
  State_3110_Name = {
    Text = "State@Chapter 4 Resonance@Arithmetica -1"
  },
  State_3110_WeaponDesc = {
    Text = "\"Innocent Return Gift\" Arithmetica Cost -1"
  },
  State_3111_Desc = {
    Text = "At the start of next turn, convert remaining Shield into 2x HP"
  },
  State_3111_Name = {
    Text = "Eternal Flower"
  },
  State_3112_Desc = {
    Text = "Team Unique: Increases the wielder's Poison DMG by <WeaponEffect_Num:[StateArg3]%>. After using Exalt, restores health equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's CON, plus additional health equal to <WeaponEffect_Num:[StateArg2]%> of the wielder's CON for each remaining Arithmetica."
  },
  State_3112_WeaponDesc = {
    Text = "Increase Poison dealt by <WeaponEffect_Num:[StateArg3]%>. After the wielder performs Exalt, recover <WeaponEffect_Num:[Heal:DescArg1]> HP points, and for each remaining Arithmetica, gain an additional <WeaponEffect_Num:[Heal:DescArg2]> HP points."
  },
  State_3113_Desc = {
    Text = "State@Prologue Aliemus 0_1_4"
  },
  State_3113_Name = {
    Text = "State@Prologue Aliemus 0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_4"
  },
  State_3114_Desc = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3114_Name = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3115_Desc = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3115_Name = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_2"
  },
  State_3116_Name = {
    Text = "State@Prologue Aliemus 0_1_1"
  },
  State_3117_Desc = {
    Text = "Team Unique: The Base DMG of the wielder's \"Strike\" and \"Exalt\" is increased by <WeaponEffect_Num:[StateArg1]%>. After the wielder uses \"Strike\", they gain a 5% Temporary Crit. Rate, stacking up to 3 times per turn. Upon reaching 3 stacks, they gain 15% Temporary Crit. DMG."
  },
  State_3117_WeaponDesc = {
    Text = "The wielder's \"Strike\" and \"Exalt\" Base DMG is increased by <WeaponEffect_Num:[StateArg1]%>. After using \"Strike,\" the wielder gains 5% Temporary Crit. Rate, up to 3 times per turn. Upon reaching 3 stacks, they gain 15% temporary Crit. DMG."
  },
  State_3118_Desc = {
    Text = "At turn start, restore [Layer]% of lost HP."
  },
  State_3118_Name = {
    Text = "The Shelter of the Pilot's Sail"
  },
  State_3120_Desc = {
    Text = "[Defense] Gain [Arg1] Counters."
  },
  State_3121_Desc = {
    Text = "If the enemy's intention is not to attack, deal Active or Tentacle DMG to inflict Bleed equal to half the DMG dealt."
  },
  State_3122_Desc = {
    Text = "Exalt DMG increases by [Layer]% in this exploration."
  },
  State_3122_Name = {
    Text = "Permanently increases Exalt DMG percentage."
  },
  State_3123_Desc = {
    Text = "Team Unique: The wielder's <RetaliateIconKeywords:Counter> is increased by <WeaponEffect_Num:[StateArg3]%>. For each attack received, gain Temporary <PowerIconKeywords:STR> equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's ATK. After the wielder uses Exalt, gain <RetaliateIconKeywords:Counter> equal to <WeaponEffect_Num:[StateArg2]%> of the wielder's ATK."
  },
  State_3123_WeaponDesc = {
    Text = "The wielder's Counter DMG is increased by <WeaponEffect_Num:[StateArg3]%>. For each attack received, gain <WeaponEffect_Num:[Power:DescArg1]> Temporary <PowerIconKeywords:STR>. After the wielder uses Exalt, gain <WeaponEffect_Num:[Counterattack:DescArg2]> Counter."
  },
  State_3124_Desc = {
    Text = "The number of Black Sigils obtained by the Lucky Detective is doubled."
  },
  State_3124_Name = {
    Text = "Exceptional Luck"
  },
  State_3124_WeaponDesc = {
    Text = "The number of Black Sigils obtained by the Lucky Detective is doubled."
  },
  State_3127_Name = {
    Text = "State@Level2_10Battle3Bubble1"
  },
  State_3128_Desc = {
    Text = "All Shield and health recovery by Awakeners increased by [StateArg1]%"
  },
  State_3128_Name = {Text = "Cradle"},
  State_3129_Desc = {
    Text = "Before the start of next turn, trigger [Layer] additional counterattacks and Tentacle counterattacks, dealing 50% DMG."
  },
  State_3129_Name = {
    Text = "Protective Scales"
  },
  State_3130_Desc = {
    Text = "This turn, DMG dealt increases by [Layer]."
  },
  State_3130_Name = {
    Text = "Temporary STR"
  },
  State_3130_WeaponDesc = {
    Text = "This turn, DMG increases by [Layer]."
  },
  State_3135_Desc = {
    Text = "Each stack increases instances of DMG dealt by 1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Madness>"
  },
  State_3136_Name = {Text = "Aliemus"},
  State_3137_Desc = {
    Text = "At the start of the battle, gain 1 Tentacle. Tentacle DMG permanently increases by [Arg1]."
  },
  State_3138_Name = {
    Text = "Accessory Paradox"
  },
  State_3138_WeaponDesc = {
    Text = "After the wielder uses Exalt, allies gain <RetaliateIconKeywords:Counter> based on 100% of the wielder's DEF. It also increases the wielder's current <RetaliateIconKeywords:Counter> by 10%."
  },
  State_3139_Desc = {
    Text = "Upon entering the Ultra Round, remove the Weakness and Fragile states from yourself and apply Weakness and Vulnerable to all enemies for 2 turns."
  },
  State_3140_Desc = {
    Text = "At the start of battle, place \"Phantasm\" in Ultra Space until you have 4 cards in Ultra Space."
  },
  State_3142_Name = {
    Text = "State@24 Enlighten 7 stacks"
  },
  State_3143_Desc = {
    Text = "After dealing actual Damage, your team loses [Layer] Temporary STR."
  },
  State_3143_Name = {Text = "Paralysis"},
  State_3144_Name = {
    Text = "The number of \"Poison\" and \"Bleed\" stacks in your team is halved."
  },
  State_3145_Desc = {
    Text = "Cannot use cards for [Layer] turns."
  },
  State_3145_Name = {
    Text = "Cannot Play Cards"
  },
  State_3146_Desc = {
    Text = "When the Apostle of the Sea plays a card, it generates [StateArg1] Temporary Tentacles that ignore the Tentacle Limit."
  },
  State_3146_Name = {
    Text = "Divine Proxy"
  },
  State_3146_WeaponDesc = {
    Text = "When the Apostle of the Sea plays 1 card, it generates [StateArg1] temporary Tentacles that ignore the Tentacle limit."
  },
  State_3148_Name = {
    Text = "Inflict [Layer] turns of Vulnerable on all enemies"
  },
  State_3149_Desc = {
    Text = "At the start of the next turn, all DMG taken is increased by 50%."
  },
  State_3149_Name = {
    Text = "Delayed Vulnerable"
  },
  State_3149_WeaponDesc = {
    Text = "All DMG taken is increased by 50%."
  },
  State_3150_Desc = {
    Text = "After receiving 3 attacks in one turn, gain 1 stack of Temporary Madness."
  },
  State_3150_Name = {
    Text = "\"Sweet Agony\""
  },
  State_3151_Desc = {
    Text = "Gain [Arg1] Strength permanently upon pickup."
  },
  State_3152_Name = {
    Text = "State@Accessory Re-evolution"
  },
  State_3152_WeaponDesc = {
    Text = "Gain 3 Aliemus at the end of the wielder's turn. Gain an additional 2 Aliemus if the wielder's Aliemus Regen is greater than 10."
  },
  State_3153_Name = {
    Text = "State@Curse Hallucinations Restoration"
  },
  State_3154_Name = {Text = "Crit. Rate"},
  State_3155_Desc = {
    Text = "Recover 10% of the lost HP each turn."
  },
  State_3155_Name = {Text = "Medic"},
  State_3155_WeaponDesc = {
    Text = "Recover 10% of lost HP each turn."
  },
  State_3156_Desc = {
    Text = "The first instance of DMG received each turn is multiplied by five."
  },
  State_3156_Name = {
    Text = "Panic-stricken"
  },
  State_3160_Desc = {
    Text = "At the beginning of the turn, add a \"Parasol\" with [Arg1] Alert obtained this turn to your hand. After playing 6 Cards, increase the Alert of all \"Parasols\" in your hand by [Arg2]."
  },
  State_3161_Desc = {
    Text = "The opponent draws [Layer] fewer cards, but all cards are retained."
  },
  State_3161_WeaponDesc = {
    Text = "Our team's card draw quantity is reduced by [Layer], and all cards gain Retain."
  },
  State_3163_Desc = {
    Text = "After triggering Death Resistance, restore [Layer] HP."
  },
  State_3163_Name = {
    Text = "Cradle of Stars"
  },
  State_3163_WeaponDesc = {
    Text = "Triggers Death Resistance, healing [Layer] HP."
  },
  State_3164_Desc = {Text = "—"},
  State_3164_Name = {
    Text = "Chain of Resentment Count"
  },
  State_3164_WeaponDesc = {Text = "—"},
  State_3165_Name = {
    Text = "The Scuttler Enlighten 3"
  },
  State_3166_Name = {
    Text = "This battle has been triggered."
  },
  State_3168_Desc = {
    Text = "At turn start, increase the attack count for all monsters."
  },
  State_3168_Name = {
    Text = "State @ Avenger's Great Blade Decapitation Damage"
  },
  State_3168_WeaponDesc = {
    Text = "Add an attack count to all monsters at turn start."
  },
  State_3170_Desc = {
    Text = "Inflict Price of Impulsiveness"
  },
  State_3170_Name = {
    Text = "Price of Impulsiveness"
  },
  State_3170_WeaponDesc = {
    Text = "Inflict Price of Impulsiveness"
  },
  State_3171_Name = {
    Text = "State@Stage2_1Battle3Bubble1"
  },
  State_3172_Desc = {
    Text = "Gain [StateArg1] Temporary STR when dealing Damage, stacking up to [StateArg2] times. Double the Effect when fully stacked."
  },
  State_3172_Name = {
    Text = "Relic Bloody Pebble"
  },
  State_3174_Desc = {
    Text = "Max HP reduced by 30%."
  },
  State_3174_Name = {
    Text = "Relic Sextant 2"
  },
  State_3174_WeaponDesc = {
    Text = "Max HP reduced by 30%."
  },
  State_3175_Desc = {
    Text = "All Awakeners gain 10 Aliemus at turn start."
  },
  State_3175_Name = {
    Text = "Relic Sextant 1"
  },
  State_3175_WeaponDesc = {
    Text = "All Awakeners obtain 10 Aliemus at turn start."
  },
  State_3176_Desc = {
    Text = "Prologue: Reset Deck 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Prologue Reset Deck 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Prologue: Reset Deck 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "When \"Vigilance\" reaches 3 stacks, retreat and summon a \"Decoy Wax Sculpture\". Stacks reset at turn start."
  },
  State_3177_Name = {Text = "Vigilance"},
  State_3177_WeaponDesc = {
    Text = "When \"Vigilance\" reaches 3 stacks, retreat and summon a \"Decoy Wax Sculpture\". Stacks are cleared at turn start."
  },
  State_3178_Desc = {
    Text = "Increase a card's Arithmetica Cost."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:Stagnation>"
  },
  State_3178_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_3179_Desc = {
    Text = "At the start of battle, gain 20 Shield. If you have Shield at turn start, Shield and Heal effectiveness increase by 50% that turn."
  },
  State_3179_Name = {
    Text = "Guardian of the Alienated Garden"
  },
  State_3179_WeaponDesc = {
    Text = "Obtain 20 Shield when the battle begins. At turn start, if you have Shield, Shield Generation and Healing Amp. increase by 50% for that turn."
  },
  State_3180_Desc = {
    Text = "Crit. Rate increased by 25%. After restoring HP, there is a chance to restore HP an additional time, with the probability equal to the restorer's Crit. Rate."
  },
  State_3180_Name = {
    Text = "State@Phantom_Silver_Key: Critical_Heal"
  },
  State_3181_Name = {Text = "Crit. Rate"},
  State_3183_Desc = {
    Text = "Crit. DMG increases by [Layer]% this turn."
  },
  State_3183_Name = {
    Text = "Temporary Crit. DMG"
  },
  State_3185_Desc = {
    Text = "Extra stress when moving"
  },
  State_3185_Name = {
    Text = "Relic Bottomless Bag 2"
  },
  State_3185_WeaponDesc = {
    Text = "Extra stress when moving"
  },
  State_3188_Name = {
    Text = "Gain [DescArg1] Strength"
  },
  State_3189_Name = {
    Text = "Monster Delay Strength"
  },
  State_3190_Name = {Text = "Relic Key"},
  State_3193_Desc = {
    Text = "Gain a [Layer] Shield at the start of next turn."
  },
  State_3193_Name = {
    Text = "The Lost Art"
  },
  State_3193_WeaponDesc = {
    Text = "Obtain a [Layer] shield after the start of next turn."
  },
  State_3196_Desc = {
    Text = "When played, recover [StateArg1] Arithmetica."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Adv. Computation>"
  },
  State_3196_WeaponDesc = {
    Text = "When played, recover [StateArg1] Arithmetica."
  },
  State_3197_Desc = {
    Text = "\"Strike\" restores [Arg1] HP and halves your Bleeding and Poison stacks."
  },
  State_3200_Desc = {
    Text = "Team Unique: The wielder's base DMG and Shield increase by <WeaponEffect_Num:[StateArg1]%>. At the start of exploration, add one of the wielder's \"Strike\" and one \"Defense\" to the deck. After the wielder plays \"Defense\", the next \"Strike\"'s Crit. Rate and Crit. DMG increase by 15%. After the wielder plays \"Strike\", the next \"Defense\"'s Shield increases by 15%. Can stack up to 3 times."
  },
  State_3200_WeaponDesc = {
    Text = "The wielder's Base DMG and Shield Generation <WeaponEffect_Num:[StateArg1]%>. At the start of the exploration, add one \"Strike\" and one \"Defense\" of the wielder's to the deck. After the wielder plays \"Defense\", the next \"Strike\" gains +15% Crit. Rate and Crit. DMG. After the wielder plays \"Strike\", the next \"Defense\" generates +15% Shield, stacking up to 3 times."
  },
  State_3201_Desc = {Text = "—"},
  State_3201_Name = {
    Text = "Chain of Resentment"
  },
  State_3201_WeaponDesc = {Text = "—"},
  State_3203_Desc = {
    Text = "Team Unique: The wielder's Shield Generation +<WeaponEffect_Num:[StateArg3]%>; the wielder's \"Defense\" inflicts <WeaponEffect_Num:[StateArg1]%> of <IntoxicationIconKeywords:Poison> on the enemy with the highest HP. If the current realm is \"Caro\", when applying <IntoxicationIconKeywords:Poison>, <EmbryoFusionIconKeywords:Embryo Fusion> increases by <WeaponEffect_Num:[StateArg2]%>. This effect triggers up to 3 times per turn."
  },
  State_3203_WeaponDesc = {
    Text = "The wielder's Shield Generation +<WeaponEffect_Num:[StateArg3]%>. The wielder's \"Defense\" inflicts <WeaponEffect_Num:[Poison:DescArg1]> stacks of <IntoxicationIconKeywords:Poison> on the enemy with the highest HP. If the current Realm is \"Caro\", when inflicting <IntoxicationIconKeywords:Poison>, <EmbryoFusionIconKeywords:Embryo Fusion> increases by <WeaponEffect_Num:[StateArg2]%>. This effect can trigger up to 3 times per turn."
  },
  State_3204_Desc = {
    Text = "When dealing actual Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_3204_Name = {Text = "Laceration"},
  State_3204_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3205_Desc = {
    Text = "Exalt DMG increases by [Layer]% in this battle."
  },
  State_3205_Name = {
    Text = "Exalt DMG Boost"
  },
  State_3206_Desc = {
    Text = "Each card played increases the Crit. Rate by [StateArg1]% this turn, stacking up to [StateArg2] times. When the stacks are full, the effect is doubled."
  },
  State_3206_Name = {
    Text = "Relic Memphis Ritual Mirror"
  },
  State_3206_WeaponDesc = {
    Text = "Each card played increases the Crit. Rate by [StateArg1]% this turn, stacking up to [StateArg2] times. The effect doubles when the stacks are full."
  },
  State_3207_Desc = {
    Text = "For each 1 HP lost, remove 1 stack. When the number of stacks reaches 0, gain a [DescArg1] Shield."
  },
  State_3207_Name = {
    Text = "Dimensional Barrier"
  },
  State_3208_Desc = {
    Text = "Petrified, cannot act. Removed at turn end."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Petrify>"
  },
  State_3209_Name = {
    Text = "Accessory Life Drain"
  },
  State_3209_WeaponDesc = {
    Text = "At the start of battle, if the wielder is of the Caro class, increase ATK by 25%."
  },
  State_3210_Name = {
    Text = "State@Vengeance Blade Enlighten 1"
  },
  State_3211_Desc = {
    Text = "Increase hand limit by 2. Do not discard hand at turn end. Whenever you lose HP, discard 2 random cards."
  },
  State_3212_Desc = {
    Text = "All DMG dealt -25%, remove 1 stack at turn end."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:Weakness>"
  },
  State_3212_WeaponDesc = {
    Text = "All DMG is reduced by 25%."
  },
  State_3213_Desc = {
    Text = "Shield and Healing effects +[Layer]%"
  },
  State_3213_Name = {
    Text = "Temporary Shield and Healing Amplification Effect"
  },
  State_3213_WeaponDesc = {
    Text = "Shield and Healing effects are increased by [Layer]%"
  },
  State_3214_Name = {
    Text = "Draw [Layer] cards"
  },
  State_3216_Desc = {
    Text = "After the battle, obtain an extra 100 Black Sigils, but develop a random Symptom."
  },
  State_3216_Name = {
    Text = "Relic of Good Fortune Ring"
  },
  State_3216_WeaponDesc = {
    Text = "After the battle, obtain an extra 100 Black Sigils, but develop a random Symptom."
  },
  State_3217_Name = {
    Text = "Gain [Layer] Arithmetica"
  },
  State_3220_Desc = {
    Text = "After releasing an Exalt, draw 1 card. If HP is below 25%, draw an additional card."
  },
  State_3223_Desc = {
    Text = "Increases the Weakness effect by 10%. Adds 1 stack of Weakness to all enemies every 3 turns."
  },
  State_3224_Name = {
    Text = "Relic Arcana Archive Arithmetica"
  },
  State_3225_Name = {
    Text = "Skull Reaver"
  },
  State_3226_Desc = {
    Text = "After being played, the card will not enter the Discard Pile and cannot be used again in this battle."
  },
  State_3226_Name = {Text = "Exhaust"},
  State_3226_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_3227_Desc = {
    Text = "All Relic prices reduced by 50%."
  },
  State_3227_Name = {
    Text = "Relic Trade Medal"
  },
  State_3227_WeaponDesc = {
    Text = "All Relic prices are reduced by 50%."
  },
  State_3228_Desc = {
    Text = "At turn start, the Awakener with the lowest Aliemus gains 25 Aliemus."
  },
  State_3228_Name = {
    Text = "Relic Arcana Aliemus"
  },
  State_3228_WeaponDesc = {
    Text = "At turn start, the Awakener with the lowest Aliemus gains 25 Aliemus."
  },
  State_3229_Desc = {
    Text = "Prologue: Reset Deck 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Prologue: Reset Deck 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Prologue: Reset Deck 0_1_1_1"
  },
  State_3230_Name = {
    Text = "State@Gen Delay Arithmetica"
  },
  State_3231_Desc = {
    Text = "Exalt DMG increases by [Layer]% this turn"
  },
  State_3231_Name = {
    Text = "Temporary Exalt DMG % Boost"
  },
  State_3232_Desc = {
    Text = "State@Monster Ultra Slot Trigger"
  },
  State_3232_Name = {
    Text = "State@Monster Ultra Slot Trigger"
  },
  State_3232_WeaponDesc = {
    Text = "State@Monster Ultra Slot Trigger"
  },
  State_3234_Desc = {
    Text = "At the start of the battle, gain 3 Strength, but take 5 more Damage."
  },
  State_3234_Name = {Text = "Last Cry"},
  State_3235_Desc = {
    Text = "At the start of the battle, gain [Layer] STR, but take 5 more Damage."
  },
  State_3235_Name = {Text = "Last Cry"},
  State_3236_Desc = {
    Text = "When played, increase all other Awakeners' Aliemus by <Energy:[StateArg1]>."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Adv. Catalysis>"
  },
  State_3237_Desc = {
    Text = "Gain 3 Tentacles every 3 turns. These Tentacles ignore the Tentacle Limit and will be removed at turn end."
  },
  State_3238_Desc = {
    Text = "At the start of the battle, grant the state where all DMG dealt to monsters is increased."
  },
  State_3238_Name = {
    Text = "At the start of the battle, grant the state where all DMG dealt to monsters is increased."
  },
  State_3238_WeaponDesc = {
    Text = "At the start of the battle, grant the state that increases all DMG dealt to monsters."
  },
  State_3239_Desc = {
    Text = "Increase Attack by [Layer]."
  },
  State_3239_Name = {
    Text = "Increase General Attack"
  },
  State_3239_WeaponDesc = {
    Text = "Increase [Layer] ATK."
  },
  State_3242_Name = {
    Text = "Add 2 <DerivativeCardKeywords_4:\"Insight\"> cards to the Draw Pile."
  },
  State_3243_Desc = {
    Text = "Card Arithmetica Increase"
  },
  State_3243_Name = {
    Text = "Card Arithmetica Increase"
  },
  State_3243_WeaponDesc = {
    Text = "Card Arithmetica Increase"
  },
  State_3244_Desc = {
    Text = "The summoned monsters' HP is doubled."
  },
  State_3244_Name = {
    Text = "\"Overflowing Guilt\""
  },
  State_3244_WeaponDesc = {
    Text = "The summoned monsters' HP is doubled."
  },
  State_3245_Desc = {
    Text = "At the start of the battle, the team's Crit. Rate decreases by 30%, and Crit. DMG increases by 30%."
  },
  State_3245_Name = {Text = "Suppress"},
  State_3245_WeaponDesc = {
    Text = "At the start of the battle, your team's Crit. Rate decreases by 30% and Crit. DMG increases by 30%."
  },
  State_3246_Desc = {
    Text = "At the start of battle, all normal enemies' HP increases by 30%. Upon victory, gain an extra 25 Black Sigils."
  },
  State_3246_Name = {
    Text = "Relic Tattered War Banner"
  },
  State_3246_WeaponDesc = {
    Text = "At the start of battle, all ordinary enemies' HP increases by 30%. Upon battle victory, gain an additional 25 Black Sigils."
  },
  State_3247_Desc = {
    Text = "[Exalt] Reduce the Arithmetica Cost of all cards by 1."
  },
  State_3247_Name = {
    Text = "Mutated Light of Civilization"
  },
  State_3247_WeaponDesc = {
    Text = "[Exalt] Reduces the Arithmetica Cost of all cards in hand by 1."
  },
  State_3248_Name = {
    Text = "When playing another card, reduce its Arithmetica Cost by [StateArg1] points."
  },
  State_3249_Desc = {
    Text = "Other allies gain 1 stack of Madness, which is removed upon the caster's death."
  },
  State_3249_Name = {
    Text = "Restlessness"
  },
  State_3249_WeaponDesc = {
    Text = "Other allies obtain 1 stack of Madness, which is removed upon the caster's death."
  },
  State_3250_Desc = {
    Text = "Once played, it will be permanently removed and will no longer appear in the deck for this stage."
  },
  State_3250_Name = {
    Text = "<CardKeyWord:Destroy>"
  },
  State_3250_WeaponDesc = {
    Text = "Permanently remove it after use."
  },
  State_3251_Desc = {
    Text = "When attacked, immune to DMG and lose 1 stack. Clears at turn end."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:Temporary Barrier>"
  },
  State_3252_Desc = {
    Text = "When applying Shield, Blossom of Sludge Max HP +[StateArg2]."
  },
  State_3252_Name = {
    Text = "Slime Convergence"
  },
  State_3252_WeaponDesc = {
    Text = "Blossom of Sludge increases Max HP by [StateArg2] when applying a shield."
  },
  State_3253_Desc = {
    Text = "Gain [StateArg1] Temporary Alert."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Shield: Mecha>"
  },
  State_3253_WeaponDesc = {
    Text = "Obtain [StateArg1] Temporary Alert"
  },
  State_3256_Name = {
    Text = "State@Cursed Mania"
  },
  State_3259_Desc = {
    Text = "Increase instances of DMG dealt by [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Madness>"
  },
  State_3260_Desc = {
    Text = "When Ultra Space is filled, gain an extra turn. In this turn, draw no card from the Draw Pile; instead, place the cards in Ultra Space into hand."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Ultra Space>"
  },
  State_3260_WeaponDesc = {
    Text = "When Ultra Space reaches its limit, obtain an additional Ultra Round and add all Ultra Space cards to your hand."
  },
  State_3261_Desc = {
    Text = "The DMG of summoned monsters is doubled."
  },
  State_3261_Name = {
    Text = "\"Wax Sculpture Army\""
  },
  State_3261_WeaponDesc = {
    Text = "The DMG of summoned monsters is doubled."
  },
  State_3262_Desc = {
    Text = "State@Wax Coating for Our Team"
  },
  State_3262_Name = {
    Text = "State@Wax Coating for Our Team"
  },
  State_3262_WeaponDesc = {
    Text = "State@Wax Coating for Our Team"
  },
  State_3263_Name = {
    Text = "State@Nautilus Shell Counterattack"
  },
  State_3264_Name = {
    Text = "Guaranteed Crit"
  },
  State_3265_Name = {
    Text = "Removed When Discarded"
  },
  State_3266_Desc = {
    Text = "Strengthened Leap of Necropolis of Dreams"
  },
  State_3266_Name = {
    Text = "State@Death Dream City Strengthen Leap"
  },
  State_3267_Desc = {
    Text = "At the start of battle, gain 5 stacks of [Waxed Armor]."
  },
  State_3267_Name = {
    Text = "\"Wax Gentleman\""
  },
  State_3267_WeaponDesc = {
    Text = "When the battle begins, obtain 5 stacks of [Waxed Armor]."
  },
  State_3268_Desc = {
    Text = "Draw 1 card at turn start. Each card drawn randomly alters its Arithmetica Cost (0-4)."
  },
  State_3268_Name = {
    Text = "Relic Kaleidoscope"
  },
  State_3268_WeaponDesc = {
    Text = "Draw 1 card at the start of your turn. Whenever you draw a card, randomly alter its Arithmetica Cost (0-4)."
  },
  State_3269_Desc = {
    Text = "Gain [Arg1] stacks of Counter when gaining the second Shield each turn. Deal 1 Counter DMG to all enemies upon gaining the 4th Shield each turn."
  },
  State_3270_Name = {
    Text = "State@Chapter Two Resonance Copy"
  },
  State_3271_Desc = {
    Text = "[Strike] Applies [Arg1] stacks of Poison to all enemies."
  },
  State_3272_Desc = {
    Text = "When dealing DMG that is not blocked, heal for 3 times the actual DMG dealt. This effect is removed upon dealing Damage."
  },
  State_3272_Name = {Text = "Life Drain"},
  State_3273_Desc = {
    Text = "Team Unique: After playing the wielder's card, gain a Shield equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's Defense. For each Tentacle, increase the Shield by <WeaponEffect_Num:[StateArg2]%> of the wielder's Defense. This effect triggers only once per turn."
  },
  State_3273_WeaponDesc = {
    Text = "After playing the wielder's card, gain <WeaponEffect_Num:[Block:DescArg1]> Shield. For each Tentacle, increase the Shield by <WeaponEffect_Num:[DescArg2]>. This effect activates only once per turn."
  },
  State_3274_Desc = {
    Text = "Add a stack to the team each time Active DMG is received."
  },
  State_3274_Name = {
    Text = "State@Vengeful Greatblade Decapitation Damage to Our Team Count"
  },
  State_3274_WeaponDesc = {
    Text = "Add a stack to your team each time Active DMG is received."
  },
  State_3277_Desc = {
    Text = "When played, increase this Awakener's Aliemus by <Energy:[StateArg1]>."
  },
  State_3277_Name = {
    Text = "<Rune_5:Berserk>"
  },
  State_3280_Name = {
    Text = "Predetermined Strike"
  },
  State_3281_Desc = {
    Text = "Increase Active DMG dealt."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:STR>"
  },
  State_3281_WeaponDesc = {
    Text = "Increase DMG dealt."
  },
  State_3282_Desc = {
    Text = "Number of Hits and DMG Increase."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Upgrade>"
  },
  State_3282_WeaponDesc = {
    Text = "Increase DMG by one instance"
  },
  State_3283_Desc = {
    Text = "At turn start, restore [StateArg1] HP. If HP is below 50%, restore [StateArg2] HP instead."
  },
  State_3283_Name = {
    Text = "Relic Resin Compound"
  },
  State_3283_WeaponDesc = {
    Text = "At turn start, restore [StateArg1] HP. If HP is below 50%, healing becomes [StateArg2]."
  },
  State_3287_Desc = {
    Text = "At the start of the battle, shuffle 2 \"Insight\" cards into your deck. Each battle victory upgrades this relic, up to 3 times."
  },
  State_3288_Desc = {
    Text = "State@Empty State"
  },
  State_3288_Name = {
    Text = "State@Empty State"
  },
  State_3288_WeaponDesc = {
    Text = "State@Empty State"
  },
  State_3289_Desc = {
    Text = "Each point of DMG taken reduces one stack. At 0 stacks, replace intention with Eternal Flower and use Defense-focused skills."
  },
  State_3289_Name = {
    Text = "Eternal Flower"
  },
  State_3289_WeaponDesc = {
    Text = "Loses 1 stack for every 1 DMG taken. Switches to Defense mode when stacks reach 0."
  },
  State_3290_Desc = {
    Text = "The creature once known as \"Miryam\" fell into extreme paranoia and despair. Shatter her last delusions to end thousands of years of madness."
  },
  State_3290_Name = {Text = "Obsession"},
  State_3291_Desc = {
    Text = "After dealing actual Damage, your team loses 3 Temporary STR."
  },
  State_3291_Name = {Text = "Paralysis"},
  State_3292_Desc = {
    Text = "When unleashing Exalt, each time an enemy is about to deal 1 instance of DMG, apply [Arg1] stacks of Poison to them."
  },
  State_3293_Desc = {
    Text = "DMG dealt in this stage is reduced by [Layer]."
  },
  State_3293_Name = {Text = "STR▼"},
  State_3293_WeaponDesc = {
    Text = "Damage and Tentacle DMG reduction in this stage are reduced by [Layer]."
  },
  State_3294_Name = {
    Text = "State@Cursed Paranoia"
  },
  State_3296_Desc = {
    Text = "Remove it when discarded or played."
  },
  State_3296_Name = {
    Text = "Remove this card when discarded or played."
  },
  State_3296_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3297_Desc = {
    Text = "State@Thorn Queen Qiming_Form"
  },
  State_3297_Name = {
    Text = "State@Thorn Queen Qiming_Form"
  },
  State_3297_WeaponDesc = {
    Text = "State@Thorn Queen Qiming_Form"
  },
  State_3298_Desc = {
    Text = "The next Leap effect this turn is guaranteed to trigger."
  },
  State_3298_Name = {
    Text = "Guaranteed Leap"
  },
  State_3298_WeaponDesc = {
    Text = "The Leap Effect does not require conditions this turn."
  },
  State_3301_Name = {
    Text = "Stellar Wine Count"
  },
  State_3302_Desc = {
    Text = "Apply Eternal Freeze"
  },
  State_3302_Name = {
    Text = "Apply Eternal Freeze"
  },
  State_3302_WeaponDesc = {
    Text = "Apply Eternal Freeze"
  },
  State_3304_Desc = {
    Text = "At the end of each turn, when the corresponding Awakener for the last Command Card is played, gain 15 Aliemus. If also possessing \"Mother Effigy\", grant other Awakeners 5 Aliemus."
  },
  State_3305_Desc = {
    Text = "When played, shuffle [StateArg1] <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile."
  },
  State_3305_Name = {
    Text = "<Rune_17:Insight>"
  },
  State_3307_Name = {
    Text = "(Remaining:[Layer])"
  },
  State_3308_Desc = {
    Text = "At turn start, if more than 2 cards remained in hand during the last turn, gain 2 Arithmetica."
  },
  State_3309_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3309_Name = {
    Text = "State@Prototype Longsword Dead Resistance"
  },
  State_3310_Desc = {
    Text = "When the Migrator applies a Shield, gain [Energy:StateArg2] Aliemus."
  },
  State_3310_Name = {
    Text = "Self-Imprisonment"
  },
  State_3310_WeaponDesc = {
    Text = "When the Migrant applies a shield, obtain [Energy:StateArg2] Aliemus."
  },
  State_3312_Desc = {
    Text = "Each time you restore HP, gain [Arg1] Counter. If your HP is above 75%, gain an additional [Arg2] Counter."
  },
  State_3313_Desc = {
    Text = "At turn start, gain [Arg1] Strength this turn. Lose [Arg2] Strength this turn for each card played."
  },
  State_3314_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3314_Name = {Text = "Not Roused"},
  State_3315_Desc = {
    Text = "After playing the first card each turn, transform 2 random cards in hand into their original versions. They revert at turn end."
  },
  State_3315_Name = {
    Text = "Relic Enthralling Chime"
  },
  State_3316_Desc = {
    Text = "The Shield will be retained at turn end."
  },
  State_3316_Name = {
    Text = "Guardian Barrier"
  },
  State_3316_WeaponDesc = {
    Text = "The Shield will be retained at turn end."
  },
  State_3317_Desc = {
    Text = "Lose all Shield at turn end"
  },
  State_3317_Name = {
    Text = "Shackles: Birth Father"
  },
  State_3318_Name = {
    Text = "State@Thirsting for blood Embrace Devour Marker"
  },
  State_3319_Desc = {
    Text = "Returns to hand upon play. Arithmetica Cost increases by 1."
  },
  State_3319_Name = {
    Text = "<CardKeyWord:Phantasm>"
  },
  State_3323_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3323_Name = {
    Text = "State@Proto Longsword Aliemus"
  },
  State_3324_Desc = {
    Text = "Crit. DMG increases by [Layer]% this turn."
  },
  State_3324_Name = {
    Text = "Temporary Crit. DMG"
  },
  State_3324_WeaponDesc = {
    Text = "Crit. DMG is increased by [Layer]% this turn."
  },
  State_3325_Desc = {
    Text = "Each time you reset the deck, add 2 \"Barbed Trident\" that have gained [Arg1] Strength this turn and 1 \"Parasol\" that has gained [Arg2] Alert this turn to your hand."
  },
  State_3326_Desc = {
    Text = "Immune to the first Active DMG each turn."
  },
  State_3326_Name = {Text = "Resolute"},
  State_3326_WeaponDesc = {
    Text = "Immune to the first Active DMG each turn."
  },
  State_3327_Desc = {
    Text = "Monster's HP before death."
  },
  State_3327_Name = {
    Text = "Monster's HP before death"
  },
  State_3327_WeaponDesc = {
    Text = "Monster's HP before death."
  },
  State_3328_Desc = {
    Text = "In this battle, when receiving Fatal DMG, you will resurrect once and recover [Layer] HP. This effect cannot be dispelled."
  },
  State_3328_Name = {
    Text = "Undying Bird of Paradise"
  },
  State_3329_Desc = {
    Text = "Play 5 cards to get a copy of the leftmost card in your hand, attatched with Exhaust and Fleeting"
  },
  State_3330_Desc = {
    Text = "Card Arithmetica Cost increases by [Layer]. This debuff is removed after the card is played."
  },
  State_3330_Name = {
    Text = "<SlowColour:Stagnation [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Card Arithmetica Cost increases by [Layer]."
  },
  State_3332_Desc = {
    Text = "When attacked, immune to DMG and lose 1 stack."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:Barrier>"
  },
  State_3334_Name = {
    Text = "Inflict [Layer] turns of Vulnerable on all enemies"
  },
  State_3335_Desc = {
    Text = "At the start of the battle, apply 1 stack of Vulnerable to all enemies. \"Stagnant Curse\" increases the effect of Vulnerable on enemies by 25%."
  },
  State_3335_Name = {
    Text = "Stone Eye Enlighten 6"
  },
  State_3336_Name = {
    Text = "State@George@Heals upon death"
  },
  State_3337_Desc = {Text = "—"},
  State_3337_Name = {
    Text = "Vermilion Rite"
  },
  State_3337_WeaponDesc = {Text = "—"},
  State_3339_Desc = {
    Text = "Increase Attack by [Layer]."
  },
  State_3339_Name = {
    Text = "Temporary Attack Boost"
  },
  State_3339_WeaponDesc = {
    Text = "Increase [Layer] ATK."
  },
  State_3340_Desc = {
    Text = "After using Exalt, increase Exalt DMG by [Arg1] for this battle, stacking up to 5 times. When fully stacked, the Awakener who used this Exalt gains 100 Aliemus."
  },
  State_3341_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_1"
  },
  State_3341_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_1"
  },
  State_3342_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_2"
  },
  State_3342_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_2"
  },
  State_3343_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_3"
  },
  State_3343_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_3"
  },
  State_3344_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_4"
  },
  State_3344_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_4"
  },
  State_3345_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3345_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3346_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3346_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_6"
  },
  State_3347_Desc = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3347_Name = {
    Text = "State@Prologue Reset Deck 0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_2_7"
  },
  State_3348_Desc = {
    Text = "When played, draw [StateArg1] cards."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Adv. Finesse>"
  },
  State_3348_WeaponDesc = {
    Text = "When played, draw [StateArg1] cards."
  },
  State_3350_Desc = {
    Text = "After releasing an Exalt, lose 10% of current HP, and steal [Arg1] Strength from all enemies this turn."
  },
  State_3351_Name = {
    Text = "State@After joining the deck"
  },
  State_3352_Name = {
    Text = "Relic Celestial Astrolabe 1"
  },
  State_3354_Name = {
    Text = "Relic Celestial Astrolabe 2"
  },
  State_3356_Name = {
    Text = "End of Turn: Poison by Suffocation"
  },
  State_3357_Desc = {
    Text = "Tentacle DMG +[Layer] after the next turn starts."
  },
  State_3357_Name = {
    Text = "Delay Tentacle DMG"
  },
  State_3358_Desc = {
    Text = "At the start of next turn, gain [Layer] Shield."
  },
  State_3358_Name = {
    Text = "The Lost Art: Shield"
  },
  State_3359_Desc = {
    Text = "Every third card you play will take effect twice."
  },
  State_3359_Name = {
    Text = "Relic Stellar Brew+"
  },
  State_3359_WeaponDesc = {
    Text = "Every third card you play will take effect twice."
  },
  State_3360_Desc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3360_Name = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3362_Desc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3362_Name = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Upon pickup, choose a card and apply two three-choice strengthening effects to it. (Note: similar to Thousand Mirage card crafting)"
  },
  State_3365_Desc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3365_Name = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3366_Desc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3366_Name = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3368_Desc = {
    Text = "If the Arithmetica Cost exceeds 5 before the discard phase, it turns to stone."
  },
  State_3368_Name = {Text = "Petrify"},
  State_3368_WeaponDesc = {
    Text = "Before the discard phase, turn your hand into Stone."
  },
  State_3369_Desc = {
    Text = "All your devouring effects become Infinite Devour."
  },
  State_3369_Name = {
    Text = "Infinite Devour"
  },
  State_3369_WeaponDesc = {
    Text = "All your devouring effects become Infinite Devour."
  },
  State_3370_Desc = {
    Text = "Shield reduced by [Layer] in this stage."
  },
  State_3370_Name = {
    Text = "Permanent Alert-"
  },
  State_3370_WeaponDesc = {
    Text = "Shield Generation reduced by [Layer] in this stage."
  },
  State_3372_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3372_Name = {Text = "Not Roused"},
  State_3373_Desc = {
    Text = "When dealing actual Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_3373_Name = {
    Text = "Suffocation"
  },
  State_3373_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3374_Desc = {
    Text = "After turn end, gain an equal number of stacks of Strength."
  },
  State_3374_Name = {Text = "Anger"},
  State_3375_Desc = {
    Text = "When drawn, double the DMG dealt this turn. When discarded, lose all Shield. Cannot be sold."
  },
  State_3375_Name = {
    Text = "State: Curse, Dissolution, Rage"
  },
  State_3375_WeaponDesc = {
    Text = "When drawn, double the DMG for this turn. When discarded, lose all Shield. Cannot be sold."
  },
  State_3376_Desc = {
    Text = "Exalt DMG increases by [Layer] during this battle."
  },
  State_3376_Name = {
    Text = "Exalt DMG Boost"
  },
  State_3378_Desc = {
    Text = "After triggering an Exalt, the next Card played takes effect twice."
  },
  State_3378_Name = {
    Text = "State@Illusory Silver Key: Burst"
  },
  State_3379_Desc = {
    Text = "When HP is below 50%, the Chain Breaker will go berserk."
  },
  State_3379_Name = {
    Text = "Moment of Vengeance"
  },
  State_3379_WeaponDesc = {
    Text = "When HP is below 50%, the Chainbreaker will go berserk."
  },
  State_3380_Desc = {
    Text = "At the start of battle, shuffle one [Confusion] into your Draw Pile."
  },
  State_3380_Name = {
    Text = "Enchantment"
  },
  State_3380_WeaponDesc = {
    Text = "At the start of battle, shuffle one [Confusion] into your Draw Pile."
  },
  State_3381_Name = {
    Text = "Ultra Dimension Class Initialization"
  },
  State_3382_Desc = {
    Text = "Gain a quest. Complete the quest to receive rewards. [Event Placeholder]"
  },
  State_3383_Name = {
    Text = "Ultra Dimension Class Initialization"
  },
  State_3385_Desc = {
    Text = "Reduce active and Tentacle DMG by 33%."
  },
  State_3385_Name = {
    Text = "Mirror Shield"
  },
  State_3385_WeaponDesc = {
    Text = "Reduces incoming active and Tentacle DMG by 33%."
  },
  State_3386_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3386_Name = {
    Text = "State@Prototype Longsword Crit"
  },
  State_3387_Name = {
    Text = "State@Level2_3Battle3Bubble1"
  },
  State_3388_Desc = {
    Text = "When played, gain [StateArg1] <PowerIconKeywords:STR> after its effects resolve."
  },
  State_3388_Name = {
    Text = "<Rune_14:Might>"
  },
  State_3389_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3389_Name = {Text = "Not Roused"},
  State_3390_Desc = {
    Text = "At the start of the battle, all enemies are inflicted with Weakness and Vulnerable for 1 turn."
  },
  State_3391_Desc = {
    Text = "When this card is in your hand, your other cards take effect 1 more time then Exhaust. Cannot be sold."
  },
  State_3391_Name = {
    Text = "State: Curse, Dissolution, Enchantment"
  },
  State_3391_WeaponDesc = {
    Text = "When this card is in your hand, your other cards activate an additional time and are Exhausted when played. Cannot be sold."
  },
  State_3392_Desc = {
    Text = "Gain [Arg1] Strength when picked up. Each time an \"Embryo\" is fused, gain [Arg2] Strength this turn."
  },
  State_3393_Desc = {
    Text = "At turn start, Embryo Fusion +30%. All your devouring effects become unlimited Devour."
  },
  State_3394_Name = {
    Text = "Add 1 <DerivativeCardKeywords_4:\"Insight\"> to the Draw Pile"
  },
  State_3395_Desc = {
    Text = "Team Unique: The Base DMG of the wielder's \"Strike\" is increased by 25%, and the base shield of \"Defense\" is increased by 25%. When playing the wielder's \"Strike, \" gain Temporary <WeaponEffect_Num:STR> equal to the wielder's ATK <PowerIconKeywords:[StateArg1]%>, and when playing the wielder's \"Defense, \" gain Temporary <WeaponEffect_Num:alert> equal to the wielder's DEF <AlertIconKeywords:[StateArg2]%>. If the current realm is \"Ultra, \" receive a Temporary <PowerIconKeywords:power> and Temporary <AlertIconKeywords:alert> when entering the Ultra Round"
  },
  State_3395_WeaponDesc = {
    Text = "The wielder's \"Strike\" Base DMG is increased by 25%, and the \"Defense\" Base Shield is increased by 25%. When the wielder performs a \"Strike\", they obtain <WeaponEffect_Num:[Power:DescArg1]> Temporary <PowerIconKeywords:STR>. When the wielder performs a \"Defense\", they obtain <WeaponEffect_Num:[DescArg2]> Temporary <AlertIconKeywords:Alert>. If the Current Realm is \"Ultra\", they obtain 1 Temporary <PowerIconKeywords:STR> and 1 Temporary <AlertIconKeywords:Alert> upon entering the Ultra Round."
  },
  State_3397_Desc = {
    Text = "Playing the 10th card increases Tentacle DMG by [Arg1] and makes all Tentacles attack once."
  },
  State_3400_Desc = {
    Text = "Elite and Boss enemies' maximum HP reduced by 20%."
  },
  State_3401_Desc = {
    Text = "When played, it takes effect [StateArg1] extra time, and you receive [StateArg2] Black Sigils. (This Orison also affixed <DepleteIconKeywords:Exhaust> and <GuyouKeywords:Innate> to the card.)"
  },
  State_3401_Name = {
    Text = "<Rune_7:Echo>"
  },
  State_3402_Desc = {
    Text = "\"Iron Pickaxe\" Lusen's heavy strike DMG increased by [Layer]%."
  },
  State_3402_Name = {
    Text = "Increased Heavy Attack Damage"
  },
  State_3402_WeaponDesc = {
    Text = "\"Iron Pickaxe\" Lucen's Heavy Blow DMG +[Layer]%"
  },
  State_3403_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3403_Name = {Text = "Not Roused"},
  State_3405_Name = {
    Text = "All enemies temporarily lose [Power:StateArg1] <PowerIconKeywords:STR>, and their shield gains and <PowerIconKeywords:STR> are reduced by 50% for 1 turn."
  },
  State_3406_Name = {
    Text = "Obtain [StateArg1] <PowerIconKeywords:STR>"
  },
  State_3407_Name = {
    Text = "Choose 1 card from the Draw Pile, add it to your hand, and reduce its Arithmetica Cost by 1."
  },
  State_3408_Name = {
    Text = "Gains <Posse:[DescArg1]>  Keyflare. In this battle, the Base DMG of \"Beheading\" and \"Thousand Mirage\" is increased by 10%."
  },
  State_3409_Name = {
    Text = "Choose an Awakener to gain <Energy:[DescArg1]> Aliemus"
  },
  State_3410_Name = {
    Text = "This card's Crit. Rate and Crit. DMG increase by 50%, dealing Pierce DMG."
  },
  State_3411_Name = {
    Text = "Become Immune to <FragileIconKeywords:Fragile>, <WeaknessIconKeywords:Weakness>, <VulnerabilityIconKeywords:Vulnerable> for 1 turn. Obtain <Block:[Block:StateArg1]> shield."
  },
  State_3412_Desc = {
    Text = "Immune to debuffs. Reduces by 1 stack at the end of each turn or when critically hit."
  },
  State_3412_Name = {
    Text = "Wax Coating"
  },
  State_3412_WeaponDesc = {
    Text = "Each stack reduces incoming DMG by 10%. Loses 1 stack when taking a critical hit."
  },
  State_3415_Desc = {
    Text = "Choose 1 from 3 Corrupted Orisons when picked up. Corrupted Orisons are stronger but exhaust a card when played."
  },
  State_3415_Name = {
    Text = "Relic Jade Imprint"
  },
  State_3415_WeaponDesc = {
    Text = "Choose 1 from 3 Corrupted Orisons when picked up. Corrupted Orisons are stronger than ordinary Orisons, but the card will be Exhausted when played."
  },
  State_3416_Desc = {
    Text = "Team Unique: After the battle starts, gain a counter equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's DEF. After triggering <DeathResistanceIconKeywords:Resistance>, gain up to 2 stacks of \"Cradle\": all friendly units' shield and HP Recovery increase by <WeaponEffect_Num:[StateArg2]%>, removing 1 stack at turn end. If the current realm is \"Caro\", after triggering <DeathResistanceIconKeywords:Resistance>, Embryo Fusion increases by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_3416_WeaponDesc = {
    Text = "At the start of battle, gain <WeaponEffect_Num:[Counterattack:DescArg1]> Counter. Upon triggering <DeathResistanceIconKeywords:Death Resistance>, gain up to 2 stacks of \"Cradle\": all allies' Shield Generation and HP recovery is increased by <WeaponEffect_Num:[StateArg2]%>, removing 1 stack at the end of each turn. If the current realm is \"Caro\", upon triggering <DeathResistanceIconKeywords:Death Resistance>, Embryo Fusion increases by <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_3417_Name = {
    Text = "Immune to Seals"
  },
  State_3418_Desc = {
    Text = "After turn end, lose Temporary STR"
  },
  State_3418_Name = {
    Text = "Delay Drain"
  },
  State_3419_Desc = {
    Text = "Show 3 cards with Advanced or Cursed Orisons upon pickup, choose one to assign its Orison."
  },
  State_3420_Desc = {
    Text = "Each action causes Bleed. Healing can halve the number of Bleed stacks."
  },
  State_3420_Name = {Text = "Bloodstain"},
  State_3420_WeaponDesc = {
    Text = "Each action causes Bleed. Healing can reduce the number of Bleed stacks by half."
  },
  State_3421_Desc = {
    Text = "At turn start, add a \"Barbed Trident\" that grants [Arg1] Strength to your hand. After releasing Exalt, increase the Strength of all \"Barbed Trident\" in your hand by [Arg2]."
  },
  State_3422_Name = {
    Text = "State@Accessory Pure Revelation"
  },
  State_3422_WeaponDesc = {
    Text = "After releasing Posse, heal [DescArg1] HP. If the wielder's Keyflare Regen Level is greater than 20, additionally heal [DescArg1] HP. Similar effects do not stack."
  },
  State_3423_Desc = {
    Text = "Realm Mastery 100 increases DMG and Temporary Tentacle DMG."
  },
  State_3423_Name = {
    Text = "State@Dream Silver Key: Frenzied Slash"
  },
  State_3424_Desc = {
    Text = "At turn start, if you played more than 3 cards last turn, draw 2 cards."
  },
  State_3425_Desc = {
    Text = "When HP drops below 50%([StateArg1]), the intention shifts to \"Surviving Impasse\": removes Fragile, Weakness, and Poison states, inflicting 99 stacks of Weakness and Fragility on your team."
  },
  State_3425_Name = {
    Text = "Moment of Vengeance"
  },
  State_3425_WeaponDesc = {
    Text = "When HP drops below 50%([StateArg1]), the intention shifts to \"Surviving Impasse\": removes Fragile, Weakness, and Poison states, inflicting 99 stacks of Weakness and Fragility on your team."
  },
  State_3428_Desc = {
    Text = "This card increases Exalt DMG by 50% while in hand. Cannot be sold."
  },
  State_3428_Name = {
    Text = "State Curse Destruction 2"
  },
  State_3428_WeaponDesc = {
    Text = "This card increases Exalt DMG by 50% while in hand. Cannot be sold."
  },
  State_3429_Desc = {
    Text = "Each action adds Bleeding; healing removes the Bleeding effect."
  },
  State_3429_Name = {
    Text = "Severe Injury"
  },
  State_3429_WeaponDesc = {
    Text = "Adds Bleed on each action. Heal can remove the Bleed effect."
  },
  State_3430_Desc = {
    Text = "After releasing an Exalt, gain [Arg1] Counter. If this is the 6th time it has been triggered in this battle, double your Counter."
  },
  State_3431_Name = {
    Text = "Immune to Poison"
  },
  State_3432_Desc = {
    Text = "Exhaust it when discarded"
  },
  State_3432_Name = {
    Text = "Exhaust Cost"
  },
  State_3432_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3434_Name = {
    Text = "State @ Generic Vulnerable Modifier"
  },
  State_3436_Desc = {
    Text = "[Layer] Awakeners are being hunted."
  },
  State_3436_Name = {Text = "Hunted"},
  State_3437_Desc = {
    Text = "State@Monster Whale Jump Phantasm Planet Progeny_Beast of Chaos"
  },
  State_3437_Name = {
    Text = "State@Monster Whale Jump Phantasm Planet Progeny_Beast of Chaos"
  },
  State_3437_WeaponDesc = {
    Text = "State@Monster Whale Jump Phantasm Planet Progeny_Beast of Chaos"
  },
  State_3438_Desc = {
    Text = "Gain [StateArg1] Temporary STR."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Sword: Mecha>"
  },
  State_3439_Desc = {
    Text = "At turn end, Tulu gains 5 Aliemus."
  },
  State_3439_Name = {
    Text = "The Stars Are Right"
  },
  State_3441_Desc = {
    Text = "On odd turns, draw 2 cards if you have no cards in hand; on even turns, gain 2 Arithmetica if you have none left."
  },
  State_3441_Name = {
    Text = "Antique Puzzle"
  },
  State_3441_WeaponDesc = {
    Text = "On odd turns, draw 2 cards if you have 0 cards in hand; on even turns, gain 2 Arithmetica if you have 0 Arithmetica left."
  },
  State_3442_Desc = {
    Text = "Permanently lose [Arg1] Strength upon pickup. Heal [Arg2] HP each time you deal Damage, up to 6 times per turn."
  },
  State_3444_Desc = {
    Text = "Draw 1 card at turn start."
  },
  State_3445_Desc = {
    Text = "Increase DEF by [Layer]%"
  },
  State_3445_Name = {
    Text = "Increase Generic Defense Percentage"
  },
  State_3445_WeaponDesc = {
    Text = "Increase DEF by [Layer]%."
  },
  State_3446_Desc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when playing a card. When it hits 0, self-destruct, dealing Attack * 2.5 Damage."
  },
  State_3446_Name = {Text = "Bomb"},
  State_3446_WeaponDesc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when you play a card. When it reaches 0, self-destruct, dealing ATK * 2.5 DMG."
  },
  State_3447_Desc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when playing a card. When it hits 0, self-destruct, dealing Attack * 2.5 Damage."
  },
  State_3447_Name = {Text = "Bomb"},
  State_3447_WeaponDesc = {
    Text = "Gain 5 stacks of [Fuse]. Decrease by 1 when you play a card. When it reaches 0, self-destruct, dealing ATK * 2.5 DMG."
  },
  State_3448_Desc = {
    Text = "At the end of each turn, activate all Tentacles"
  },
  State_3448_Name = {
    Text = "Tentacle Auto-Activation"
  },
  State_3448_WeaponDesc = {
    Text = "At the end of each turn, activate all Tentacles"
  },
  State_3449_Desc = {
    Text = "State@Prologue Aliemus 0_1_1 Active"
  },
  State_3449_Name = {
    Text = "State@Prologue Aliemus 0_1_1 Active"
  },
  State_3449_WeaponDesc = {
    Text = "State@Prologue Aliemus 0_1_1 Active"
  },
  State_3450_Desc = {
    Text = "When attacked, cancel out the DMG and remove 1 stack."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:Barrier>"
  },
  State_3450_WeaponDesc = {
    Text = "Reduce DMG taken by 99%. After taking Damage, lose 1 layer."
  },
  State_3451_Desc = {
    Text = "All Awakeners gain 10 Aliemus upon death."
  },
  State_3451_Name = {
    Text = "Lingering Silver Flakes"
  },
  State_3451_WeaponDesc = {
    Text = "All Awakeners obtain 10 Aliemus upon death."
  },
  State_3452_Desc = {
    Text = "Each time you play a card, take [StateArg1] DMG and remove 1 stack. At turn end, if any stacks remain, hatch a \"Sea Creature\". For every stack, HP increases by 10%."
  },
  State_3452_Name = {
    Text = "Abyssal Erosion"
  },
  State_3453_Name = {
    Text = "State@Revenge Blade Strength Multiplier"
  },
  State_3455_Desc = {
    Text = "State@Prologue Aliemus Init 0_2_3 Effect"
  },
  State_3455_Name = {
    Text = "State@Prologue Aliemus Init 0_2_3 Effect"
  },
  State_3455_WeaponDesc = {
    Text = "State@Prologue Aliemus Init 0_2_3 Effect"
  },
  State_3456_Desc = {
    Text = "[Defense] Gain [StateArg1] Counter."
  },
  State_3456_Name = {
    Text = "Relic Nettle Vest"
  },
  State_3457_Name = {
    Text = "Immune to Vulnerable"
  },
  State_3458_Desc = {
    Text = "Play [Strike] and [Defense]. The corresponding Awakener gains 35 Aliemus, but their Arithmetica Cost increases by 1."
  },
  State_3459_Desc = {
    Text = "Exalt DMG increases by [Layer] during this battle."
  },
  State_3459_Name = {
    Text = "Exalt DMG Boost"
  },
  State_3461_Desc = {
    Text = "Your fifth attack always deals Crit. DMG."
  },
  State_3462_Name = {
    Text = "State@Revenge Greatsword Strength Multiplier 3"
  },
  State_3463_Name = {
    Text = "State@Vengeance Greatsword Strength Multiplier 2"
  },
  State_3464_Desc = {
    Text = "Tentacle Limit increased by 1. If HP is below 50%, Tentacle DMG increases by [Arg1]."
  },
  State_3465_Desc = {
    Text = "This card will be carried into battle and will be effective within the stage."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Permanent>"
  },
  State_3465_WeaponDesc = {
    Text = "This card can be carried out of battle and is effective within the stage."
  },
  State_3466_Desc = {
    Text = "Upon pickup, choose an Awakener to Awaken. The Arithmetica Cost of its Rouse card is permanently reduced by 1."
  },
  State_34671_Desc = {
    Text = "Returns to hand after being played."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Return to Hand>"
  },
  State_34685_Name = {
    Text = "Bomb Player 2"
  },
  State_34689_Desc = {
    Text = "For every 1 point of HP lost, gain 1 stack of <PainWord:Endure>, up to 100% of Max HP. Endure will carry over to the next battle."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:Endure>"
  },
  State_3468_Desc = {
    Text = "State @ Resentment of the Defective"
  },
  State_3468_Name = {
    Text = "State @ Resentment of the Defective"
  },
  State_3468_WeaponDesc = {
    Text = "State @ Resentment of the Defective"
  },
  State_34691_Desc = {
    Text = "For each HP point lost, gain one stack of <PainWord:Endure>. Max [DescArg1] stacks."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:Endure>"
  },
  State_34696_Desc = {
    Text = "This card always remains in your hand and increases your hand limit by +1."
  },
  State_34696_Name = {
    Text = "Permanently Retain and ignore hand limit"
  },
  State_3469_Desc = {
    Text = "Reduce all DMG dealt by [DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Weakness>"
  },
  State_3469_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_3470_Desc = {
    Text = "Apply Gradually Petrify Detection"
  },
  State_3470_Name = {
    Text = "Apply Gradually Petrify Detection"
  },
  State_3470_WeaponDesc = {
    Text = "Apply Gradually Petrify Detection"
  },
  State_3471_Desc = {
    Text = "Each time you play the [StateArg1]th card, it takes effect twice."
  },
  State_3471_Name = {
    Text = "Stellar Wine Count"
  },
  State_3471_WeaponDesc = {
    Text = "Each time you play the [StateArg1]th card, it takes effect twice."
  },
  State_3473_Desc = {
    Text = "When HP drops below 50%, the \"Lantern Pastor\" will pray for \"The Divine's Descent\", going berserk after absorbing all followers."
  },
  State_3473_Name = {
    Text = "Brand of the Wick"
  },
  State_3473_WeaponDesc = {
    Text = "When HP drops below 50%, \"Lantern Pastor\" will pray for \"The Divine's Descent\", and go berserk after absorbing all followers."
  },
  State_3475_Desc = {
    Text = "[Strike] and [Defense] Arithmetica Cost +1."
  },
  State_3475_Name = {
    Text = "Relic Cursed Stele"
  },
  State_3475_WeaponDesc = {
    Text = "[Strike] and [Defense] Arithmetica Cost +1."
  },
  State_3476_Desc = {
    Text = "Whenever you lose HP, Embryo Fusion +10%. If HP is below 50%, this effect doubles."
  },
  State_3477_Desc = {
    Text = "Regains [Layer] HP when attacked; faints and removes this state if DMG exceeds 15% of Max HP."
  },
  State_3477_Name = {
    Text = "Obsidian Maw"
  },
  State_3478_Name = {
    Text = "State@Standard Accessory Covenant"
  },
  State_3479_Desc = {
    Text = "For each consumed Black Sigil, all Awakeners gain 1 Aliemus"
  },
  State_3479_Name = {
    Text = "Relic Reversal Flower"
  },
  State_3479_WeaponDesc = {
    Text = "For each consumed Black Sigil, all Awakeners obtain 1 Aliemus."
  },
  State_3480_Desc = {
    Text = "Until turn end, HP won't drop to 0."
  },
  State_3480_Name = {
    Text = "Diamond in the Rough: Undying"
  },
  State_3480_WeaponDesc = {
    Text = "Until turn end, HP will not drop to 0."
  },
  State_3481_Desc = {
    Text = "At the start of the stage, double your Death Resistance and Orison rates."
  },
  State_3481_Name = {
    Text = "State@Illusory Silver Key: Double Luck"
  },
  State_3482_Desc = {
    Text = "Increase Vulnerable effect by 25%. Every 3 turns, add 1 stack of Vulnerable to all enemies."
  },
  State_3483_Desc = {
    Text = "Each action adds Bleeding; healing removes the Bleeding effect."
  },
  State_3483_Name = {
    Text = "Severe Injury"
  },
  State_3483_WeaponDesc = {
    Text = "Adds Bleed on each action. Heal can remove the Bleed effect."
  },
  State_3484_Desc = {
    Text = "Gain Strength after dealing actual Damage."
  },
  State_3484_Name = {
    Text = "\"Chaotic Persona\""
  },
  State_3485_Desc = {
    Text = "State@Lantern Ceremony Active"
  },
  State_3485_Name = {
    Text = "State@Lantern Ceremony Active"
  },
  State_3485_WeaponDesc = {
    Text = "State@Lantern Ceremony Active"
  },
  State_3486_Name = {
    Text = "Predetermined Strike"
  },
  State_3488_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still Parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_3488_Name = {
    Text = "Repeatedly Parasitized"
  },
  State_3489_Name = {
    Text = "At turn end, if in hand or <DimensionalSpaceIconKeywords:Ultra Space>, upgrade to \"Corrupted Flames\""
  },
  State_3489_WeaponDesc = {
    Text = "Enhance if in hand or in Ultra Space at turn end."
  },
  State_3490_Desc = {
    Text = "Take [StateArg1] DMG and remove 1 stack when playing a card. When stacks reach 0, hatch a weaker \"Sea Creature\". If still Parasitized at turn end, hatch a \"Sea Creature\" with HP based on stacks."
  },
  State_3490_Name = {
    Text = "Parasitized Again"
  },
  State_3492_Desc = {
    Text = "Reduces the team's Strength by [Layer] every even-numbered turn."
  },
  State_3492_Name = {Text = "Unload"},
  State_3495_Desc = {
    Text = "Each action applies [Layer] Bleed."
  },
  State_3495_Name = {
    Text = "Severe Injury"
  },
  State_3495_WeaponDesc = {
    Text = "Each action adds [Layer] Bleed; healing can remove the Bleed effect."
  },
  State_34964_Desc = {
    Text = "At the beginning of the turn, gain 10% Max HP from <PainWord:Endure>."
  },
  State_34964_Name = {
    Text = "Never Forget"
  },
  State_3496_Name = {
    Text = "At turn end, if in hand or <DimensionalSpaceIconKeywords:Ultra Space>, upgrade to \"Deadly Flames\""
  },
  State_3496_WeaponDesc = {
    Text = "Enhance if in hand or in Ultra Space at turn end."
  },
  State_3497_Desc = {
    Text = "When the team is composed of Awakeners of different classes, the team's HP and all Awakeners' Attack and Defense are increased by 200%."
  },
  State_3497_Name = {
    Text = "Mixed Bonus"
  },
  State_3497_WeaponDesc = {
    Text = "When the team consists of Awakeners of different professions, the team's HP and all Awakeners' Attack and Defense increase by 200%."
  },
  State_3499_Desc = {
    Text = "Team Unique: The Aliemus generated by the wielder increases by <WeaponEffect_Num:[StateArg1]%>. The wielder gains <WeaponEffect_Num:[StateArg2]>  Keyflare after releasing Exalt."
  },
  State_3499_WeaponDesc = {
    Text = "The Aliemus generated by the wielder increases <WeaponEffect_Num:[StateArg1]%>. After releasing Exalt, the wielder obtains <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_3502_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3502_Name = {
    Text = "State@Proto Knife Aliemus"
  },
  State_3504_Desc = {
    Text = "Draw [StateArg1] cards at turn start."
  },
  State_3504_Name = {
    Text = "Relic True North Compass"
  },
  State_3504_WeaponDesc = {
    Text = "Draw [StateArg1] cards at turn start."
  },
  State_3507_Name = {
    Text = "Accessory: Organic Form"
  },
  State_3507_WeaponDesc = {
    Text = "After the wielder uses Exalt, their Shield and Healing Amp. are doubled this turn."
  },
  State_3508_Name = {
    Text = "Accessory: Chrysalis of the Maiden"
  },
  State_3508_WeaponDesc = {
    Text = "At the start of battle, if the wielder is a Chaos class, increase ATK by 25%."
  },
  State_3510_Desc = {
    Text = "The Awakener's Shield increases by [Layer]."
  },
  State_3510_Name = {
    Text = "<AlertColour:Alert>"
  },
  State_3511_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3511_Name = {
    Text = "State@Prototype Sword of Fortune"
  },
  State_35120_Desc = {
    Text = "For each attack received, apply [StateArg1] stacks of Poison to the attacker, lasting [Layer] turns."
  },
  State_35120_Name = {
    Text = "Undying Flower Upon Slime"
  },
  State_3512_Name = {
    Text = "Temporary Immunity to Fragile"
  },
  State_3514_Desc = {
    Text = "At turn end, take DMG equal to stacks and remove this state."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:Bleed>"
  },
  State_3514_WeaponDesc = {
    Text = "Take DMG at turn start."
  },
  State_3515_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3515_Name = {Text = "Not Roused"},
  State_3516_Name = {
    Text = "State@Cursed Despondency"
  },
  State_3517_Name = {
    Text = "State Curse Dissolution Fury Damage"
  },
  State_3518_Desc = {
    Text = "Each time The Sorcerer plays a card, they gain [StateArg2] Temporary STR."
  },
  State_3518_Name = {
    Text = "Opening Act"
  },
  State_3519_Desc = {
    Text = "Even outside Ultra Rounds, you can trigger a Leap Effect once per turn."
  },
  State_3519_Name = {
    Text = "Spatial Deflector"
  },
  State_3519_WeaponDesc = {
    Text = "Even outside of Ultra Rounds, you can trigger a Leap Effect once per turn."
  },
  State_3520_Desc = {
    Text = "At the start of the battle, select an Awakener and grant them 50 Aliemus."
  },
  State_3522_Name = {
    Text = "Relic Trident Count"
  },
  State_35238_Desc = {
    Text = "Team Unique: The Shields and Poison caused by the wielder increase by <WeaponEffect_Num:[StateArg1]%>. Each time Resistance is triggered, all Awakeners gain <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate and Crit. DMG."
  },
  State_35238_WeaponDesc = {
    Text = "Increase the wielder's Shield Generation and Poison by <WeaponEffect_Num:[StateArg1]%>. Upon triggering Death Resistance, all Awakeners obtain <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate and Crit. DMG."
  },
  State_3523_Desc = {
    Text = "When played, inflict [StateArg1] turns of <WeaknessIconKeywords:Weakness> on all enemies."
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Adv. Weakness>"
  },
  State_3523_WeaponDesc = {
    Text = "When played, inflict [StateArg1] turns of <WeaknessIconKeywords:Weakness> on all enemies."
  },
  State_3524_Desc = {
    Text = "Damage taken increased by [Layer]."
  },
  State_3524_Name = {
    Text = "Dissolution Wound"
  },
  State_3524_WeaponDesc = {
    Text = "DMG taken increased by [Layer]."
  },
  State_3525_Desc = {
    Text = "Every time my team plays a card, apply 2 stacks of [Bind]."
  },
  State_3525_Name = {
    Text = "\"East District Exclusive\""
  },
  State_3525_WeaponDesc = {
    Text = "Every time your team plays a card, apply 2 stacks of [Bondage] to it."
  },
  State_35264_Desc = {
    Text = "This turn, \"The Sorcerer\" gains 1 stack of Phantasm for each card played."
  },
  State_35264_Name = {
    Text = "Shadow Shift Record"
  },
  State_35277_Name = {
    Text = "Casiah's Magic Defense"
  },
  State_3527_Desc = {
    Text = "At the end of each turn, the corresponding Awakener for the first Command Card gains 15 Aliemus. When you have \"Devoted Heart\", grant other Awakeners 5 Aliemus."
  },
  State_3528_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3528_Name = {
    Text = "State@Proto Laser Cannon Realm"
  },
  State_3529_Desc = {
    Text = "Immune to all Damage. Removed at turn start."
  },
  State_3529_Name = {
    Text = "Immune to Damage"
  },
  State_3530_Desc = {
    Text = "State@Lucky Detective All-in Mark 8"
  },
  State_3530_Name = {
    Text = "State@Lucky Detective All-in Mark 8"
  },
  State_3530_WeaponDesc = {
    Text = "State@Lucky Detective All-in Mark 8"
  },
  State_3531_Desc = {
    Text = "Team Unique: At the start of battle, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus. Each time another Awakeners releases Exalt, the wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus. If the current Realm is \"Aequor\", after the wielder releases Exalt, they gain Tentacle DMG equal to <WeaponEffect_Num:[StateArg3]%> of their Attack."
  },
  State_3531_WeaponDesc = {
    Text = "At the start of the battle, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus. Each time another Awakeners Exalts, the wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus. If the current Realm is \"Aequor\", Tentacle DMG increases by <WeaponEffect_Num:+[DescArg1]> after the wielder Exalts."
  },
  State_3532_Desc = {
    Text = "At turn start, gain [StateArg1] Arithmetica."
  },
  State_3532_Name = {
    Text = "Relic Black Candle 1"
  },
  State_3533_Desc = {
    Text = "Always appears in the starting hand."
  },
  State_3533_Name = {
    Text = "<CardKeyWord:Innate>"
  },
  State_3533_WeaponDesc = {
    Text = "This card is fixed in the hand after the battle begins."
  },
  State_3535_Desc = {
    Text = "Card Arithmetica Cost increases by [Layer]. This debuff will be removed at turn end or after a card is played."
  },
  State_3535_Name = {
    Text = "<SlowColour:Stagnation [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Card Arithmetica Cost increases by [Layer]."
  },
  State_3536_Name = {
    Text = "Can be used upto 3 times in boss battles."
  },
  State_3537_Desc = {
    Text = "Gain an Orison upon obtaining \"Innocent Return Gift.\""
  },
  State_3537_Name = {
    Text = "Status@Chapter1_Resonance4"
  },
  State_3537_WeaponDesc = {
    Text = "Gain an Orison upon obtaining \"Innocent Return Gift.\""
  },
  State_3538_Desc = {
    Text = "\"Innocent Return Gift\" generates more Aliemus"
  },
  State_3538_Name = {
    Text = "State@Chapter One_Resonance1"
  },
  State_3538_WeaponDesc = {
    Text = "\"Innocent Return Gift\" generates more Aliemus"
  },
  State_3539_Desc = {
    Text = "\"Innocent Return Gift\" Arithmetica Cost -1"
  },
  State_3539_Name = {
    Text = "Status@Chapter 1_Resonance 3"
  },
  State_3539_WeaponDesc = {
    Text = "\"Innocent Return Gift\" Arithmetica Cost -1"
  },
  State_3540_Desc = {
    Text = "\"Innocent Return Gift\" can designate a target"
  },
  State_3540_Name = {
    Text = "State@Chapter 1_Resonance 2"
  },
  State_3540_WeaponDesc = {
    Text = "\"Innocent Return Gift\" can designate a target"
  },
  State_3541_Desc = {
    Text = "Koom fell into the trap you set."
  },
  State_3541_Name = {
    Text = "Caught in a Trap"
  },
  State_3542_Desc = {
    Text = "At the start of the battle, gain [Arg1] Strength for each Orison in the deck and restore [Arg2] HP for each Relic."
  },
  State_3543_Name = {
    Text = "Awakener with lowest Aliemus gains [StateArg1] Aliemus"
  },
  State_3545_Name = {
    Text = "Blinding Color Resistance"
  },
  State_3545_WeaponDesc = {
    Text = "Gain [StateArg1]% Death Resistance for each card played. Heal [StateArg2] HP when you gain Death Resistance."
  },
  State_3546_Desc = {
    Text = "Every time my team plays a card, apply [Layer] stacks of [Bind]."
  },
  State_3546_Name = {
    Text = "\"East District Exclusive\""
  },
  State_3546_WeaponDesc = {
    Text = "For every 1 Card your team plays, apply [Layer] stacks of Bondage to it."
  },
  State_3547_Desc = {
    Text = "Every time my team plays a card, apply [Layer] stacks of [Bind]."
  },
  State_3547_Name = {
    Text = "\"East District Exclusive\""
  },
  State_3547_WeaponDesc = {
    Text = "For every 1 Card your team plays, apply [Layer] stacks of Bondage to it."
  },
  State_3548_Desc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3548_Name = {
    Text = "State Curse Weakened"
  },
  State_3548_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_3549_Name = {
    Text = "State Accessory Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "The Base DMG dealt by the wielder increases by 10%. If the wielder's DMG Amplification is greater than 20%, the Base DMG is further increased by 10%."
  },
  State_3551_Desc = {
    Text = "At turn start, if more than [StateArg1] cards remained in hand last turn, gain [StateArg2] Arithmetica."
  },
  State_3551_Name = {
    Text = "Relic Differential Engine"
  },
  State_3551_WeaponDesc = {
    Text = "At turn start, if more than [StateArg1] cards remained in hand last turn, obtain [StateArg2] Arithmetica."
  },
  State_3552_Name = {
    Text = "Gain [Energy:DescArg1] Aliemus"
  },
  State_35539_Desc = {
    Text = "Take double DMG for [Layer] turns."
  },
  State_35539_Name = {
    Text = "Pathwalker's Remains"
  },
  State_3553_Desc = {
    Text = "Crit. Rate increased by 25%. After restoring HP, there is a chance to restore HP an additional time, with the probability equal to the restorer's Crit. Rate."
  },
  State_3553_Name = {
    Text = "State@Phantom_Silver_Key: Critical_Heal"
  },
  State_3554_Desc = {
    Text = "Shield and Healing effects +[Layer]%"
  },
  State_3554_Name = {
    Text = "Shield & Healing Amp"
  },
  State_3554_WeaponDesc = {
    Text = "Shield and Healing effects are increased by [Layer]%"
  },
  State_3555_Desc = {
    Text = "Gain 100% Death Resistance upon pickup. After triggering Death Resistance, restore [Arg1] HP at turn start in this battle."
  },
  State_3556_Desc = {
    Text = "When this relic is picked up, choose a card and add a copy of it to the deck."
  },
  State_3558_Desc = {
    Text = "At turn start, if the number of Black Sigils exceeds 10, exhaust 10 Black Sigils; double the DMG dealt during that turn."
  },
  State_3559_Desc = {
    Text = "Apply 1 Fragile when dealing unblockable Damage."
  },
  State_3559_Name = {Text = "Claw"},
  State_3559_WeaponDesc = {
    Text = "When dealing actual Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_3561_Name = {
    Text = "State@Phantom Silver Key: Slash Counter"
  },
  State_3562_Desc = {
    Text = "After death, the Strength of other allies increases by [Layer]."
  },
  State_3562_Name = {
    Text = "Death Whisper"
  },
  State_35635_Name = {
    Text = "State@Awakener Casiah Telekinesis Activation Allowed"
  },
  State_35636_Name = {
    Text = "Status@Awakener Casiah Add Telekinesis"
  },
  State_3563_Desc = {
    Text = "When dealing unblocked Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_3563_Name = {Text = "Blade"},
  State_3563_WeaponDesc = {
    Text = "When dealing actual Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_35645_Desc = {
    Text = "Draw [Layer] less cards this turn."
  },
  State_35645_Name = {
    Text = "Draw Reduction"
  },
  State_35646_Desc = {
    Text = "Draw [Layer] less cards this turn."
  },
  State_35646_Name = {
    Text = "Draw Reduction"
  },
  State_3564_Desc = {
    Text = "When played, first gain [StateArg1] Temp. <PowerIconKeywords:STR>, then resolve the card's effects. (Its DMG effects will benefit from this STR.)"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Adv. Burst>"
  },
  State_3565_Desc = {
    Text = "When the Sculptors apply a Shield, [StateArg1] Tentacle DMG is increased."
  },
  State_3565_Name = {
    Text = "Realm of Oblivion"
  },
  State_3565_WeaponDesc = {
    Text = "When the Sculptor applies a shield, [StateArg1] Tentacle DMG is increased."
  },
  State_3566_Desc = {
    Text = "At turn start, gain 3 Temporary STR. [Exalt] doubles this Temporary STR, up to 2 stacks."
  },
  State_3566_Name = {
    Text = "Relic Serpent's Husk"
  },
  State_3567_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3567_Name = {
    Text = "State@Proto Laser Cannon Critical Hit"
  },
  State_35684_Desc = {
    Text = "After your team releases Exalt, we lose Strength for the current turn. Once per turn."
  },
  State_35684_Name = {
    Text = "Fear Aliemus"
  },
  State_35685_Desc = {
    Text = "Upon the arrival of Genesis, reduce enemies' Temporary STR."
  },
  State_35685_Name = {
    Text = "Fear Aliemus"
  },
  State_3568_Desc = {
    Text = "When Ramona deals DMG, she gains [StateArg1] Arithmetica."
  },
  State_3568_Name = {
    Text = "First Doctrine"
  },
  State_3568_WeaponDesc = {
    Text = "When Ramona deals DMG, she obtains [StateArg1] Arithmetica."
  },
  State_3570_Name = {
    Text = "Draw +2 cards at the start of next turn"
  },
  State_3571_Name = {
    Text = "Temporary Immunity to Weakness"
  },
  State_3572_Desc = {
    Text = "The DMG of summoned monsters is doubled."
  },
  State_3572_Name = {Text = "Commander"},
  State_3572_WeaponDesc = {
    Text = "The DMG of summoned monsters is doubled."
  },
  State_3573_Desc = {
    Text = "The first instance of DMG received each turn is multiplied by five."
  },
  State_3573_Name = {Text = "Arrogance"},
  State_3573_WeaponDesc = {
    Text = "The first DMG received each turn is doubled."
  },
  State_3574_Desc = {
    Text = "When playing consecutive cards of the same Awakener, that Awakener gains 10 Aliemus."
  },
  State_3575_Desc = {
    Text = "When this card is in your hand, your other cards take effect 1 more time then Exhaust. Cannot be sold."
  },
  State_3575_Name = {
    Text = "State Curse Dissolution Enchantment Void"
  },
  State_3575_WeaponDesc = {
    Text = "When this card is in your hand, your other cards activate an additional time and are Exhausted when played. Cannot be sold."
  },
  State_35768_Name = {
    Text = "Gain 300 Keyflare"
  },
  State_35769_Name = {
    Text = "Obtain 1 Arithmetica."
  },
  State_35770_Name = {
    Text = "Dispel self <IntoxicationIconKeywords:Poison>, Sealed, <SlowIconKeywords:Stagnation> states"
  },
  State_35771_Name = {
    Text = "Gain a Shield equal to [DescArg1]% (<Block:[DescArg2]>) of Max HP."
  },
  State_35772_Name = {
    Text = "Available for [StateArg1] more times in Boss Battles."
  },
  State_35774_Desc = {
    Text = "Before death, call upon Celeste for aid, restoring all Life, Aliemus, and Keyflare."
  },
  State_35774_Name = {
    Text = "Utopian Veil"
  },
  State_3577_Name = {
    Text = "Aliemus Auto-Recovery Boost"
  },
  State_35809_Desc = {
    Text = "DMG dealt is reduced by [StateArg1]%, lasting for [Layer] turns."
  },
  State_35809_Name = {
    Text = "Delusion's Heir"
  },
  State_35809_WeaponDesc = {
    Text = "State@Aequor Lady Tea & Cake"
  },
  State_3580_Desc = {
    Text = "[Layer] Tentacle attacks deal Pierce DMG this turn."
  },
  State_3580_Name = {
    Text = "Pierce Tentacle"
  },
  State_35811_Desc = {
    Text = "When taking Damage, gain half the DMG as <SacrificeKeyWord:Sacrifice> for [Layer] turns."
  },
  State_35811_Name = {
    Text = "Delusion's Heir"
  },
  State_35819_Desc = {
    Text = "At turn end, Murphy gains 5 Aliemus. Upon releasing Posse, remove 2% of Max HP with <SacrificeKeyWord:Sacrifice>."
  },
  State_35819_Name = {
    Text = "Black Tea and Cake"
  },
  State_3581_Desc = {
    Text = "State@Red Lady's Lustful Waltz Counter"
  },
  State_3581_Name = {
    Text = "State@Red Lady's Lustful Waltz Counter"
  },
  State_3582_Desc = {
    Text = "Even outside of Ultra Rounds, you can trigger a Leap effect once per turn. Upon triggering, draw a card corresponding to the Awakener."
  },
  State_3582_Name = {
    Text = "Mutated Spatial Deflector"
  },
  State_3582_WeaponDesc = {
    Text = "Even outside of Ultra Rounds, you can trigger a Leap effect once per turn. When triggered, draw a card corresponding to the Awakener."
  },
  State_3584_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3584_Name = {
    Text = "State@Proto Knife Realm"
  },
  State_35858_Desc = {
    Text = "At turn end, Murphy gains 5 Aliemus. After releasing Posse, deal Tentacle DMG equal to 3% of Murphy's attack."
  },
  State_35858_Name = {
    Text = "Black Tea and Cake"
  },
  State_3585_Desc = {
    Text = "When HP drops below 50%([StateArg1]), the \"Lantern Pastor\" will pray for \"The Divine's Descent\", going berserk after absorbing all followers."
  },
  State_3585_Name = {
    Text = "Brand of the Wick"
  },
  State_3585_WeaponDesc = {
    Text = "When HP drops below 50%([StateArg1]), \"Lantern Pastor\" will pray for \"The Divine's Descent\", and go berserk after absorbing all followers."
  },
  State_3588_Name = {
    Text = "Creation Arcana Relic Arithmetica"
  },
  State_3589_Desc = {
    Text = "When attacked, immune to DMG and lose 1 stack."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:Barrier>"
  },
  State_3591_Desc = {
    Text = "Team Unique: The wielder's <RetaliateIconKeywords:Counter> is increased by <WeaponEffect_Num:[StateArg1]%>. \"Defense\" grants Temporary Counter equal to the wielder's DEF <WeaponEffect_Num:[StateArg2]%>. In Boss Battles, this becomes 3 times the Temporary Counter. After Death Resistance triggers, deals Fixed DMG equal to the wielder's Counter stack count <WeaponEffect_Num:[StateArg3]%> to all enemies."
  },
  State_3591_WeaponDesc = {
    Text = "Wielder's <RetaliateIconKeywords:Counter> is increased by <WeaponEffect_Num:[StateArg1]%>. After using 'Defense', gain <WeaponEffect_Num:[Counterattack:DescArg1]> stacks of Temporary Counter. In Boss Battles, this becomes 3 times the Temporary Counter. After Death Resistance triggers, deal Fixed DMG equal to the character's Counter stack count multiplied by <WeaponEffect_Num:[StateArg3]%> to all enemies."
  },
  State_3592_Desc = {
    Text = "Increases Tentacle DMG."
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Tentacle DMG>"
  },
  State_3592_WeaponDesc = {
    Text = "Increase the amount of DMG dealt by Tentacles."
  },
  State_3593_Desc = {
    Text = "Team Unique: The wielder's <IntoxicationIconKeywords:Poison> inflicted is increased by <WeaponEffect_Num:[StateArg1]%>. \"Strike\" deals DMG equal to <WeaponEffect_Num:[StateArg2]%> of the attacker's ATK as <IntoxicationIconKeywords:Poison>. This effect can trigger a maximum of 3 times per turn."
  },
  State_3593_WeaponDesc = {
    Text = "Wielder's <IntoxicationIconKeywords:Poison> inflicted is increased by <WeaponEffect_Num:[StateArg1]%>. \"Strike\" inflicts <WeaponEffect_Num:[Poison:DescArg1]> stacks of <IntoxicationIconKeywords:Poison> on the target enemy. This effect can trigger a maximum of 3 times per turn."
  },
  State_3595_Desc = {
    Text = "Voices from Beyond"
  },
  State_3595_Name = {
    Text = "Voices from Beyond"
  },
  State_3595_WeaponDesc = {
    Text = "Voices from Beyond"
  },
  State_3596_Name = {
    Text = "Residual Silver"
  },
  State_35970_Desc = {
    Text = "After death, impose 1 turn of <VulnerabilityIconKeywords:Vulnerable> on your team."
  },
  State_35970_Name = {
    Text = "Early Death"
  },
  State_35971_Desc = {
    Text = "Gains a Shield equal to 50% of Max HP upon appearance."
  },
  State_35971_Name = {Text = "Eggshell"},
  State_3597_Name = {
    Text = "Residual Silver"
  },
  State_3598_Name = {
    Text = "Residual Silver"
  },
  State_3599_Desc = {
    Text = "When you play a card with an actual Arithmetica Cost of 4 or more, reduce the Arithmetica Cost of other cards in your hand by 1."
  },
  State_36006_Desc = {
    Text = "Upon death, a \"Child of Slumber\" will spawn in place."
  },
  State_36006_Name = {
    Text = "Incarnation"
  },
  State_3600_Name = {
    Text = "Residual Silver"
  },
  State_36013_Desc = {
    Text = "This status also counts as <SacrificeKeyWord:Sacrifice>, gaining [Layer] stacks of the <SacrificeKeyWord:Sacrifice> state at the start of next turn."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Delayed Sacrifice>"
  },
  State_36014_Desc = {
    Text = "At turn end, take [Layer] DMG and reduce <SacrificeKeyWord:Sacrifice> stacks by 50%."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_3601_Name = {
    Text = "State@Phantom Silver Key: Spin Count"
  },
  State_36022_Desc = {
    Text = "Gain 50% of the DMG taken as <SacrificeKeyWord:Sacrifice> when the DMG is not from <SacrificeKeyWord:Sacrifice>."
  },
  State_36022_Name = {Text = "Tribute"},
  State_36023_Desc = {
    Text = "Upon death, if there are other allies present, a \"Child of Water\" will spawn."
  },
  State_36023_Name = {
    Text = "Incarnation"
  },
  State_36024_Desc = {
    Text = "Upon death, if there are other allies present, a \"Child of Slumber\" will spawn."
  },
  State_36024_Name = {
    Text = "Incarnation"
  },
  State_3603_Name = {
    Text = "In Boss Battles, can be used twice and returns to hand after the first use."
  },
  State_3604_Desc = {
    Text = "When the team is composed of Awakeners of different classes, the team's HP and all Awakeners' Attack and Defense are increased by 200%."
  },
  State_3604_Name = {
    Text = "State @ Mix-and-Match Bonus"
  },
  State_3604_WeaponDesc = {
    Text = "When the team consists of Awakeners of different professions, the team's HP and all Awakeners' Attack and Defense increase by 200%."
  },
  State_3607_Desc = {
    Text = "Grants the Awakener permanent combat boosts. Repeated Rouse uses don't stack."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Rouse>"
  },
  State_3607_WeaponDesc = {
    Text = "After playing Rouse, the Awakener gains a special ability enhancement in this battle. However, playing Rouse multiple times does not stack the effect."
  },
  State_3608_Name = {
    Text = "All allies gain [StateArg1] Aliemus."
  },
  State_36092_Desc = {
    Text = "Upon death, if there are other allies present, a \"Child of Water\" will spawn in place."
  },
  State_36092_Name = {
    Text = "Incarnation"
  },
  State_36093_Desc = {
    Text = "For every 1 HP point lost, reduce by 1 stack. When the number of stacks reaches 0, at the end of the monster's turn, summon 1 \"Child of Water\" and regain [DescArg1] stacks of \"Host of Water\", with a maximum of 4 \"Child of Water\"."
  },
  State_36093_Name = {
    Text = "Host of Water"
  },
  State_36094_Desc = {
    Text = "Lose 1 HP point to reduce 1 stack; when the number of stacks is 0, summon 1 \"Child of Enchantment\" and regain [DescArg1] stacks of \"Coral Host\", with a maximum of 4."
  },
  State_36094_Name = {
    Text = "Host of the Spirit Sense"
  },
  State_3609_Name = {
    Text = "In the Boss Battle, can be used twice and returns to hand after first use, with Arithmetica Cost reduced by 1 for the rest of the turn"
  },
  State_36111_Desc = {
    Text = "Upon death, add 1 \"Coral Hyperplasia\" to your hand."
  },
  State_36111_Name = {
    Text = "Coral Hyperplasia"
  },
  State_3611_Desc = {
    Text = "State@Prologue Monster Passive 12"
  },
  State_3611_Name = {
    Text = "State@Prologue Monster Passive 12"
  },
  State_3611_WeaponDesc = {
    Text = "State@Prologue Monster Passive 12"
  },
  State_36124_Desc = {
    Text = "At turn end, take [Layer] DMG and reduce \"Sacrifice\" stacks by 50%."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Sacrifice>"
  },
  State_3612_Desc = {
    Text = "State@Prologue Monster Passive 13"
  },
  State_3612_Name = {
    Text = "State@Prologue Monster Passive 13"
  },
  State_3612_WeaponDesc = {
    Text = "State@Prologue Monster Passive 13"
  },
  State_36136_Name = {
    Text = "While in hand, take [StateArg1] DMG for each other card played."
  },
  State_3613_Desc = {
    Text = "State@Prologue Monster Passive 10"
  },
  State_3613_Name = {
    Text = "State@Prologue Monster Passive 10"
  },
  State_3613_WeaponDesc = {
    Text = "State@Prologue Monster Passive 10"
  },
  State_3614_Desc = {
    Text = "State@Prologue Monster Passive 11"
  },
  State_3614_Name = {
    Text = "State@Prologue Monster Passive 11"
  },
  State_3614_WeaponDesc = {
    Text = "State@Prologue Monster Passive 11"
  },
  State_36152_Desc = {
    Text = "At turn end, take DMG equal to the number of stacks, then remove 50% of the <SacrificeKeyWord:Sacrifice> stacks. Sacrifice carries over to the next battle."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Sacrifice>"
  },
  State_3615_Desc = {
    Text = "State @ Prologue Monster Passive 16"
  },
  State_3615_Name = {
    Text = "State @ Prologue Monster Passive 16"
  },
  State_3615_WeaponDesc = {
    Text = "State @ Prologue Monster Passive 16"
  },
  State_3616_Desc = {
    Text = "State@Prologue Monster Passive 14"
  },
  State_3616_Name = {
    Text = "State@Prologue Monster Passive 14"
  },
  State_3616_WeaponDesc = {
    Text = "State@Prologue Monster Passive 14"
  },
  State_36173_Name = {
    Text = "Can use [DescArg1] times in Boss Battles."
  },
  State_36174_Name = {
    Text = "([Layer] times remaining)"
  },
  State_3617_Desc = {
    Text = "State@Prologue Monster Passive 15"
  },
  State_3617_Name = {
    Text = "State@Prologue Monster Passive 15"
  },
  State_3617_WeaponDesc = {
    Text = "State@Prologue Monster Passive 15"
  },
  State_36182_Name = {
    Text = "Gain a Shield equal to [DescArg1]% (<Block:[DescArg2]>) of Max HP and restore the same amount of HP; the Shield increases with lost HP."
  },
  State_3618_Desc = {
    Text = "Gain a Shield when taking actual Damage."
  },
  State_3618_Name = {Text = "Buffer"},
  State_3618_WeaponDesc = {
    Text = "Gain a shield when taking actual Damage."
  },
  State_36196_Desc = {
    Text = "Lotan's \"Strike\" DMG increased by 30%."
  },
  State_36196_Name = {
    Text = "Swords Unleashed"
  },
  State_3619_Desc = {
    Text = "State @ Blue Flame Dancer Strike Defense"
  },
  State_3619_Name = {
    Text = "State @ Blue Flame Dancer Strike Defense"
  },
  State_3619_WeaponDesc = {
    Text = "State @ Blue Flame Dancer Strike Defense"
  },
  State_3620_Desc = {
    Text = "Whenever you develop a Symptom, increase Max HP by [Arg1]."
  },
  State_3621_Desc = {
    Text = "For each card played by the Primal Disciple, draw [StateArg1] cards and apply 5% Poison to all enemies."
  },
  State_3621_Name = {
    Text = "Abyssal Obsession"
  },
  State_3621_WeaponDesc = {
    Text = "For every card the Primordial Devoutee plays, draw [StateArg1] cards."
  },
  State_3622_Desc = {
    Text = "Enhance the skill effects of \"Rampaging Skull Hunter\" and \"The Deceased\", gaining [StateArg1] Temporary STR at turn start, and increasing [StateArg1] for each stack of \"Hunting Mark\"."
  },
  State_3622_Name = {
    Text = "Hunting Mark"
  },
  State_36242_Desc = {
    Text = "At the start of the battle, gain [StateArg1] Shield. After losing HP, \"Divine Fetus\" will wake up from its deep sleep and begin to cry."
  },
  State_36242_Name = {
    Text = "Deep Slumber"
  },
  State_3624_Desc = {
    Text = "State@Knower Offensive Analysis Strength Reduction"
  },
  State_3624_Name = {
    Text = "State@Knower Offensive Analysis Strength Reduction"
  },
  State_3625_Desc = {
    Text = "When you have a Shield, the DMG dealt increases by [Arg1]. When your Shield exceeds your current HP, the DMG dealt is further increased by [Arg2]."
  },
  State_36263_Desc = {
    Text = "No longer taking Damage, preparing to release \"Birthing Spore\"."
  },
  State_36263_Name = {Text = "Immune"},
  State_3628_Name = {
    Text = "State@Break Defense After Played"
  },
  State_3629_Name = {
    Text = "Draw 2 cards."
  },
  State_3630_Name = {
    Text = "Inflict 2 stacks of <VulnerabilityIconKeywords:Vulnerable> on all enemies"
  },
  State_36315_Desc = {
    Text = "Gain [Layer] STR at turn end."
  },
  State_36315_Name = {Text = "Blessed"},
  State_3631_Name = {
    Text = "Obtain 2 Arithmetica."
  },
  State_3632_Name = {
    Text = "Gain <Energy:[DescArg1]> Aliemus"
  },
  State_36332_Desc = {
    Text = "At turn start, choose to gain 1 stack of Divine Mother's Power or consume Divine Authority to receive Murphy's help once."
  },
  State_36332_Name = {
    Text = "Divine Mother's Power"
  },
  State_36334_Desc = {
    Text = "Gain 1 Tentacle at the end of each turn."
  },
  State_36334_Name = {
    Text = "The Call of Lemuria"
  },
  State_3633_Name = {
    Text = "Inflict <WeaknessIconKeywords:Weakness> on all enemies for 2 stacks"
  },
  State_36346_Desc = {
    Text = "When HP drops to 0, it will be set to 1 point, no longer taking Damage, prepare to release \"Seed of Birth\"."
  },
  State_36346_Name = {
    Text = "Birthing Spore"
  },
  State_3634_Name = {
    Text = "Add 2 <DerivativeCardKeywords_4:\"Insight\"> to your Draw Pile."
  },
  State_3635_Name = {
    Text = "other Awakeners gain <Energy:[DescArg1]> Aliemus"
  },
  State_36360_Desc = {
    Text = "At turn start, there is a [DescArg1]% chance to gain 1 stack of Tentacle Gathering. If it exceeds 100%, multiple stacks can be gained."
  },
  State_36360_Name = {
    Text = "Returnal Line"
  },
  State_36361_Desc = {
    Text = "Upon appearing, other allies gain [Layer] STR."
  },
  State_36361_Name = {
    Text = "Divine Mutation"
  },
  State_3636_Desc = {
    Text = "State@Relic Enchant Bell Active"
  },
  State_3636_Name = {
    Text = "State@Relic Enchant Bell Active"
  },
  State_3637_Desc = {
    Text = "When your HP is below 25% and you are not dead, instantly recover [Arg1] HP. Permanently disabled after 3 triggers."
  },
  State_3638_Desc = {
    Text = "When attacked, immune to DMG and lose 1 stack."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:Barrier>"
  },
  State_3638_WeaponDesc = {
    Text = "DMG taken is reduced by 99%. Each time DMG is taken, 1 stack is reduced."
  },
  State_3639_Desc = {
    Text = "When Ramona deals DMG, she gains [StateArg1] Arithmetica."
  },
  State_3639_Name = {
    Text = "The Third Philosophy"
  },
  State_3639_WeaponDesc = {
    Text = "When Ramona deals DMG, she obtains [StateArg1] Arithmetica."
  },
  State_3641_Desc = {
    Text = "Select a card at the \"Unfinished Wax Sculpture\" node to reduce its Arithmetica Cost by 1"
  },
  State_3641_Name = {
    Text = "Status@Chapter Two_Resonance_Basic Effect"
  },
  State_3641_WeaponDesc = {
    Text = "Increase the level of copied Cards by +1 at the \"Unfinished Wax Sculpture\" node"
  },
  State_3642_Desc = {
    Text = "Each time you lose HP, gain [Arg1] stacks of Counter. If it's the 3rd activation in a single turn, deal 1 instance of Counter DMG to all enemies."
  },
  State_3645_Name = {
    Text = "Gain [Layer] Arithmetica"
  },
  State_3646_Desc = {
    Text = "HP cannot drop below 1. When receiving Fatal DMG, the intention changes to Surviving Impasse. [Surviving Impasse]: Restore 100% Max HP, double Strength, and Enhance subsequent skills."
  },
  State_3646_Name = {
    Text = "Surviving Impasse"
  },
  State_3647_Name = {
    Text = "Relic Arcana Record Count"
  },
  State_3648_Desc = {
    Text = "Team Unique: The wielder's Healing effect is increased by <WeaponEffect_Num:[StateArg2]%>. At turn start, gain Temporary <PowerIconKeywords:STR> and Shield equal to <WeaponEffect_Num:[StateArg1]%> of the HP lost last turn."
  },
  State_3648_WeaponDesc = {
    Text = "Wielder's HP recovery effect is increased by <WeaponEffect_Num:[StateArg2]%>. At turn start, gain Temporary <PowerIconKeywords:STR> and Shield equal to <WeaponEffect_Num:[StateArg1]%> of the HP lost in the previous turn."
  },
  State_3649_Desc = {
    Text = "For each [Ultra] class Awakener in the team, the entire team's Max HP (not finished), Defense, and Attack are increased by 50%"
  },
  State_3649_Name = {
    Text = "Ultra Bonus"
  },
  State_3649_WeaponDesc = {
    Text = "For each [Ultra] class Awakener in the team, the entire team's Max HP (Not completed), Defense, and Attack are increased by 50%."
  },
  State_3651_Desc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_3651_Name = {
    Text = "Change Arithmetica Cost before playing"
  },
  State_3651_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_3652_Desc = {
    Text = "At turn start, if more than [StateArg1] cards were played last turn, draw [StateArg2] cards."
  },
  State_3652_Name = {
    Text = "Relic Arcane Gloves"
  },
  State_3652_WeaponDesc = {
    Text = "At turn start, if more than [StateArg1] cards were played last turn, draw [StateArg2] cards."
  },
  State_3653_Name = {
    Text = "Relic Tattered Battle Flag 2"
  },
  State_3654_Desc = {
    Text = "Gain [Layer]% Temporary Crit. Rate at turn start."
  },
  State_3654_Name = {
    Text = "Distant Melody"
  },
  State_3654_WeaponDesc = {
    Text = "until the start of next turn without losing HP, Crit. Rate +[StateArg1]%."
  },
  State_3656_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3656_Name = {Text = "Not Roused"},
  State_3658_Desc = {
    Text = "When you play the last card in your hand, draw 2 cards. This effect can trigger up to 2 times per turn."
  },
  State_3659_Name = {
    Text = "State @ Strike Card Critical Rate and Critical Damage Boost"
  },
  State_36613_Name = {
    Text = "State@Accessory Mechanical Deity Counter"
  },
  State_3661_Desc = {
    Text = "Increase Deep Dissolution stacks upon taking actual Damage."
  },
  State_3661_Name = {
    Text = "Taking DMG increases Dissolution stacks."
  },
  State_3661_WeaponDesc = {
    Text = "Increase Deep Dissolution stacks upon taking actual Damage"
  },
  State_3662_Desc = {
    Text = "Crit. DMG is increased by [Layer]% in this battle."
  },
  State_3662_Name = {Text = "Crit. DMG"},
  State_3662_WeaponDesc = {
    Text = "Crit. DMG is increased by [Layer]% in this battle."
  },
  State_36631_Desc = {
    Text = "Each time you release Exalt, gain 1 stack of \"Gestation\". For each stack of Gestation, gain [StateArg1] Strength, up to 5 stacks."
  },
  State_36631_Name = {
    Text = "False Pregnancy Host"
  },
  State_36635_Desc = {
    Text = "Each time you release Exalt, gain 1 stack of \"Gestation\". For each stack of Gestation, gain [StateArg1] Strength, up to 5 stacks."
  },
  State_36635_Name = {
    Text = "Lemuria's Final Descent"
  },
  State_36636_Desc = {
    Text = "When reaching 5 stacks, release \"The Glory of Lemuria!\", causing massive DMG and summoning the kin."
  },
  State_36636_Name = {Text = "Birth"},
  State_36637_Desc = {
    Text = "When reaching 5 stacks, release \"For Lemuria!\", causing massive DMG and summoning the kin."
  },
  State_36637_Name = {Text = "Birth"},
  State_3663_Desc = {
    Text = "After playing a card for the first time each turn, place a \"Strike\" from the corresponding Awakener into hand."
  },
  State_3664_Desc = {
    Text = "Gain 5 Aliemus when played."
  },
  State_3664_Name = {Text = "Memories"},
  State_3664_WeaponDesc = {
    Text = "Gain 5 Aliemus when played."
  },
  State_3665_Desc = {
    Text = "At 100% Embryo Fusion, add 1 \"Embryo\" to your hand."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Embryo Fusion>"
  },
  State_3666_Desc = {
    Text = "Crit. Rate increased by [Layer]%."
  },
  State_3666_Name = {Text = "Crit. Rate"},
  State_3666_WeaponDesc = {
    Text = "Crit. Rate increased by [Layer]%."
  },
  State_36670_Name = {
    Text = "State @ Accessory Re-evolution Count"
  },
  State_36670_WeaponDesc = {
    Text = "Gain 3 Aliemus at the end of the wielder's turn. Gain an additional 2 Aliemus if the wielder's Aliemus Regen is greater than 10."
  },
  State_3667_Desc = {
    Text = "Team Unique: The wielder's <RetaliateIconKeywords:Counter> Generation +<WeaponEffect_Num:[StateArg4]%>. After playing a card, gain <WeaponEffect_Num:Counter> equal to <RetaliateIconKeywords:[StateArg1]%> of the wielder's DEF, up to 2 times per turn. If the card played enters Ultra Space, the wielder also gains <WeaponEffect_Num:[StateArg2]> Aliemus. After releasing Exalt, all enemies lose <WeaponEffect_Num:[StateArg3]%> Temporary STR equal to the wielder's DEF."
  },
  State_3667_WeaponDesc = {
    Text = "Increases <RetaliateIconKeywords:Counter> inflicted by the wielder by <WeaponEffect_Num:[StateArg4]%>. After the wielder plays a card, they gain <WeaponEffect_Num:[Counterattack:DescArg1]> <RetaliateIconKeywords:Counter>, up to 2 times per turn. If the card played enters Ultra Space, they also gain <WeaponEffect_Num:[StateArg2]> Aliemus. After Exalt, all enemies temporarily lose <WeaponEffect_Num:[Power:DescArg2]> Strength."
  },
  State_3668_Desc = {
    Text = "State@Altered Garden Guardian Badge"
  },
  State_3668_Name = {
    Text = "State@Altered Garden Guardian Badge"
  },
  State_3668_WeaponDesc = {
    Text = "State@Altered Garden Guardian Badge"
  },
  State_3669_Desc = {
    Text = "Immune to Weakness, Fragile, and Vulnerable states for [Layer] turns."
  },
  State_3669_Name = {
    Text = "<BlessingColour:Blessing>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Immune to debuffs applied during the turn."
  },
  State_36706_Desc = {
    Text = "Immune to all Damage"
  },
  State_36706_Name = {Text = "Immune"},
  State_3673_Desc = {
    Text = "Choose 2 cards to delete upon pickup, gain [StateArg1] Strength."
  },
  State_3673_Name = {
    Text = "Relic Black Star Ember"
  },
  State_3674_Desc = {
    Text = "At turn end, reduce all Awakeners' Aliemus by 10"
  },
  State_3674_Name = {Text = "Oblivion"},
  State_3674_WeaponDesc = {
    Text = "At turn end, reduce all Awakeners' Aliemus by 10."
  },
  State_3675_Name = {
    Text = "Draw Discarded Card Count +1 × cards"
  },
  State_3676_Desc = {
    Text = "Take [Layer]% less DMG during the opponent's turn."
  },
  State_3676_Name = {Text = "Vigilant"},
  State_3676_WeaponDesc = {
    Text = "Monsters gain [Layer]% DMG reduction during your team's turn."
  },
  State_3677_Desc = {
    Text = "Increase DEF by [Layer]%"
  },
  State_3677_Name = {
    Text = "Temporary Defense Percentage Increase"
  },
  State_3677_WeaponDesc = {
    Text = "Increase DEF by [Layer]%."
  },
  State_36781_Desc = {
    Text = "When Strength is reduced, only 50% of the Strength stacks are reduced."
  },
  State_36781_Name = {
    Text = "Will to Embody Craving"
  },
  State_3678_Name = {
    Text = "State@Event Relic 1"
  },
  State_36797_Desc = {
    Text = "This turn, Tentacle DMG is reduced by [Layer]."
  },
  State_36797_Name = {
    Text = "Tentacle DMG Reduction"
  },
  State_3679_Name = {
    Text = "State@Event Relic 2"
  },
  State_3680_Desc = {
    Text = "Apply [Arg1] stacks of Poison for each hit. If triggered 25 times during this battle, immediately apply Poison to all enemies."
  },
  State_3681_Desc = {
    Text = "When dealing unblocked Damage, leave scars on a random \"Command Card\"."
  },
  State_3681_Name = {
    Text = "Jenkin Rouse!"
  },
  State_3681_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_3682_Desc = {
    Text = "For every 10% HP lost, all Awakeners gain 10 Aliemus, and Tentacle DMG increases upon death."
  },
  State_3682_Name = {
    Text = "Buried Silver"
  },
  State_3682_WeaponDesc = {
    Text = "For every 10% HP lost, all Awakeners gain 10 Aliemus, and Tentacle DMG increases upon death."
  },
  State_3683_Desc = {
    Text = "Team Unique: The healing caused by the wielder's Command Card is increased by <WeaponEffect_Num:[StateArg2]%>. Before the wielder releases \"Exalt, \" other Awakeners gain <WeaponEffect_Num:[StateArg1]> Aliemus. If your team is in a <VulnerabilityIconKeywords:Vulnerable> state, the effect is doubled."
  },
  State_3683_WeaponDesc = {
    Text = "Healing from the wielder's Command Card is increased by <WeaponEffect_Num:[StateArg2]%>. Before the wielder releases Exalt, other Awakeners gain <WeaponEffect_Num:[StateArg1]> Aliemus. If your team is in a <VulnerabilityIconKeywords:Vulnerable> state, the effect is doubled."
  },
  State_3684_Desc = {
    Text = "Each point of DMG taken reduces one stack. At 0 stacks, replace intention with Eternal Flower and use Defense-focused skills."
  },
  State_3684_Name = {
    Text = "Eternal Flower"
  },
  State_3684_WeaponDesc = {
    Text = "Loses 1 stack for every 1 DMG taken. Switches to Defense mode when stacks reach 0."
  },
  State_3685_Desc = {
    Text = "When drawn, lose 1 Arithmetica and draw 1 card."
  },
  State_3685_Name = {Text = "Confusion"},
  State_3685_WeaponDesc = {
    Text = "When drawn, lose 1 Arithmetica and draw 1 card."
  },
  State_3686_Desc = {
    Text = "When drawn, lose 1 Arithmetica and draw 1 card."
  },
  State_3686_Name = {
    Text = "Dimension Sealed"
  },
  State_3686_WeaponDesc = {
    Text = "When drawn, lose 1 Arithmetica and draw 1 card."
  },
  State_36884_Desc = {
    Text = "The Final Vow in this battle can no longer grant a Shield through actively triggering Death Resistance."
  },
  State_36884_Name = {
    Text = "The Final Vow"
  },
  State_3688_Desc = {
    Text = "When you play 2 cards with higher Arithmetica Cost than the previous one, gain 2 Arithmetica."
  },
  State_3688_Name = {
    Text = "Relic Arcana Archive"
  },
  State_3688_WeaponDesc = {
    Text = "When you play 2 cards with a higher Arithmetica Cost than the previous one, obtain 2 Arithmetica."
  },
  State_3689_Desc = {
    Text = "At turn start, increase Realm Mastery by 30. When not in a debuff, Realm Mastery increases by 100."
  },
  State_3692_Desc = {
    Text = "Mysterious cards with a thousand forms. Choose the one you need the most!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:Thousand Mirage>"
  },
  State_3692_WeaponDesc = {
    Text = "Mysterious cards with a thousand forms. Choose the one you need most!"
  },
  State_3693_Desc = {
    Text = "Crit. Rate increased by 25%. After restoring HP, there is a chance to restore HP an additional time, with the probability equal to the restorer's Crit. Rate."
  },
  State_3693_Name = {
    Text = "State@Phantom_Silver_Key: Critical_Heal"
  },
  State_3695_Name = {
    Text = "State@24 Enlighten 7"
  },
  State_3696_Desc = {
    Text = "Gain [Arg1] Alert per hit this turn. Gain 1 Strength for every 3 remaining Shield at turn start."
  },
  State_3697_Desc = {
    Text = "Draw 1 card at turn start. Draw 1 additional card if you play 2 cards with the same Arithmetica Cost consecutively."
  },
  State_3698_Desc = {
    Text = "When played, add [StateArg1] copy of it to a Temporary <DimensionalSpaceIconKeywords:Ultra Space> slot."
  },
  State_3698_Name = {
    Text = "<Rune_13:Warp>"
  },
  State_3699_Name = {
    Text = "Residual Silver"
  },
  State_3700_Desc = {
    Text = "Increase Attack by [Layer]%"
  },
  State_3700_Name = {
    Text = "Temporary Attack Increase Percentage"
  },
  State_3700_WeaponDesc = {
    Text = "Increase ATK by [Layer]%."
  },
  State_3702_Desc = {
    Text = "State @ Generic Max Health Change"
  },
  State_3702_Name = {
    Text = "State @ Generic Max Health Change"
  },
  State_3702_WeaponDesc = {
    Text = "State @ Generic Max Health Change"
  },
  State_3703_Name = {
    Text = "Status@Chapter 4 Resonance@Draw 2 cards next turn"
  },
  State_3704_Desc = {
    Text = "Realm Mastery increased by 30. Upon pickup, choose a Relic and replace it with a random one."
  },
  State_3705_Name = {
    Text = "Aequor Enlighten 3"
  },
  State_3707_Desc = {
    Text = "At the start of battle, [StateArg1] copy of this card was shuffled into the Draw Pile. (This Orison affixed <RetainIconKeywords:Retain> to the cards.)"
  },
  State_3707_Name = {
    Text = "<Rune_8:Mirror>"
  },
  State_3708_Desc = {
    Text = "At the end of even turns, gain 1 Arithmetica for each remaining card at the start of next turn."
  },
  State_3708_Name = {
    Text = "Relic Forgotten Prelude 2"
  },
  State_3708_WeaponDesc = {
    Text = "At the end of even turns, gain 1 Arithmetica for each remaining card in hand at the start of next turn."
  },
  State_3709_Desc = {
    Text = "At the end of odd-numbered turns, each remaining Arithmetica allows you to draw 1 additional card at the start of next turn."
  },
  State_3709_Name = {
    Text = "Relic Forgotten Prelude 1"
  },
  State_3709_WeaponDesc = {
    Text = "At the end of odd-numbered turns, each remaining Arithmetica allows you to draw 1 additional card at the start of next turn."
  },
  State_3711_Desc = {
    Text = "Each action inflicts [Layer] Bleeding"
  },
  State_3711_Name = {Text = "Bloodstain"},
  State_3711_WeaponDesc = {
    Text = "Each action inflicts [Layer] Bleed; healing reduces Bleed stacks by half."
  },
  State_3712_Desc = {
    Text = "After playing the card, it is exhausted. Command Cards provide 3x DMG and defense for 1 turn."
  },
  State_3712_Name = {Text = "Dissolve"},
  State_3714_Desc = {
    Text = "When played, gain <Block:[StateArg1]> Shield."
  },
  State_3714_Name = {
    Text = "<Rune_6_High:Adv. Bastion>"
  },
  State_3714_WeaponDesc = {
    Text = "When played, gain <Block:[StateArg1]> Shield."
  },
  State_3716_Desc = {
    Text = "Crit. Rate increased by [Layer]% in this battle."
  },
  State_3716_Name = {Text = "Crit. Rate"},
  State_3719_Desc = {
    Text = "For each instance of DMG received from an attack, the Tentacle will counter-attack the attacker once, lasting [Layer] turns."
  },
  State_3719_Name = {
    Text = "Bloodline of Heresy"
  },
  State_3720_Desc = {
    Text = "Increase DEF by [Layer]."
  },
  State_3720_Name = {
    Text = "Increase General Defense"
  },
  State_3720_WeaponDesc = {
    Text = "Increase DEF by [Layer]."
  },
  State_3721_Desc = {
    Text = "After playing, this card is removed from deck instead of entering the Discard Pile."
  },
  State_3721_Name = {Text = "Exhaust"},
  State_3721_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_3722_Desc = {
    Text = "Temporarily increase Tentacle DMG by [StateArg1] when dealing Damage, stacking up to 5 times. Generate a Tentacle when fully stacked."
  },
  State_3722_Name = {
    Text = "Relic Hierophant's Staff"
  },
  State_3722_WeaponDesc = {
    Text = "Temporarily increase Tentacle DMG by [StateArg1] when dealing DMG, stacking up to 5 times. Generate 1 Tentacle when fully stacked."
  },
  State_3723_Name = {
    Text = "Relic of the Black Mirror"
  },
  State_3724_Desc = {
    Text = "Lose all other relics upon pickup. Randomly gain 2 Golden Relics."
  },
  State_3726_Name = {
    Text = "Twisted Carrion Revel"
  },
  State_3728_Desc = {
    Text = "At the start of the battle, gain a [Strike] card."
  },
  State_3728_Name = {
    Text = "Whale Leap Enlighten 1"
  },
  State_3728_WeaponDesc = {
    Text = "At the start of the battle, obtain a [Strike]."
  },
  State_3730_Desc = {
    Text = "State@Demon of Sweetness Honey-colored Tragedy"
  },
  State_3730_Name = {
    Text = "State@Demon of Sweetness Honey-colored Tragedy"
  },
  State_3730_WeaponDesc = {
    Text = "State@Demon of Sweetness Honey-colored Tragedy"
  },
  State_3731_Desc = {
    Text = "Every time you purchase at the D-Mark Store, draw 1 extra card and gain 1 Arithmetica each turn during the next battle."
  },
  State_3732_Desc = {
    Text = "Every 3 turns, gain 3 Temporary Tentacles, ignoring the Tentacle Limit."
  },
  State_3732_Name = {
    Text = "Relic Nameless Appendage"
  },
  State_3732_WeaponDesc = {
    Text = "Every 3 turns, obtain 3 temporary Tentacles. These Tentacles ignore the Tentacle Limit."
  },
  State_3733_Desc = {
    Text = "At the end of odd turns, remaining Arithmetica is converted into extra draws for the next turn; at the end of even turns, remaining cards are converted into extra Arithmetica for the next turn."
  },
  State_3735_Name = {
    Text = "The number of \"Poison\" stacks on your team is reduced by half."
  },
  State_3738_Desc = {
    Text = "At turn end, Embryo Fusion +15%. If there is an \"Embryo\" in your hand, restore [Arg1] HP."
  },
  State_3739_Name = {
    Text = "Accessory Organic Form Effect"
  },
  State_3739_WeaponDesc = {
    Text = "After the wielder uses Exalt, their Shield and Healing Amp. are doubled this turn."
  },
  State_3740_Name = {
    Text = "State@Sweet Demon Critical Hit Count"
  },
  State_3741_Desc = {
    Text = "At the start of turn 3, add 1 card \"Echoes of the Past—Discard all cards, reset current HP and Shield to the state at the end of the previous turn. Retain, Exhaust.\" to your hand."
  },
  State_3742_Desc = {
    Text = "When played, inflict [StateArg1] turn of <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  State_3742_Name = {
    Text = "<Rune_1:Vulnerable>"
  },
  State_3743_Desc = {
    Text = "Every 6th card you play will take effect twice."
  },
  State_3743_Name = {
    Text = "Relic Stellar Brew+"
  },
  State_3744_Name = {
    Text = "Relic Memphis Ritual Mirror Count"
  },
  State_3747_Name = {
    Text = "Choose 1 card from the Draw Pile and add it to your hand."
  },
  State_3748_Name = {
    Text = "Increase Crit. Rate by [DescArg1]% and crit. dmg by [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Temporary Crit. Rate +[DescArg1]%. In this battle, the Base DMG of \"Skull Reaver\" and \"Thousand Mirage\" is increased by 5%."
  },
  State_3751_Name = {
    Text = "Obtain [StateArg1] <PowerIconKeywords:STR>"
  },
  State_3752_Name = {
    Text = "Gain <Posse:[DescArg1]> Keyflare. Gain <Block:[Block:StateArg1]> Shield."
  },
  State_3753_Desc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Retain>"
  },
  State_3753_WeaponDesc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_3754_Desc = {
    Text = "When dealing Active DMG, increase Tentacle DMG by [Arg1] for this turn, stacking up to 3 times. Generate 1 Tentacle when fully stacked, which will be removed at turn end."
  },
  State_3755_Desc = {
    Text = "Team Unique: The wielder's Shield Generation +<WeaponEffect_Num:[StateArg1]%>, and HP Recovery +<WeaponEffect_Num:[StateArg1]%>. At the end of odd turns, the wielder's Crit. Rate + <WeaponEffect_Num:[StateArg2]%>, gaining <WeaponEffect_Num:[StateArg3]> Aliemus; at the end of even turns, the wielder's Crit. DMG increases by <WeaponEffect_Num:[StateArg2]%>, gaining <WeaponEffect_Num:[StateArg4]> Keyflare. If the current realm is \"Caro\", the maximum accumulation of the Crimson Furnace is increased by <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "The wielder's Shield Generation increases by <WeaponEffect_Num:[StateArg1]%>, and HP Recovery increases by <WeaponEffect_Num:[StateArg1]%>. At the end of odd turns, the wielder's Crit. Rate + <WeaponEffect_Num:[StateArg2]%>, obtaining <WeaponEffect_Num:[StateArg3]> Aliemus; at the end of even turns, the wielder's Crit. DMG increases by <WeaponEffect_Num:[StateArg2]%>, obtaining <WeaponEffect_Num:[StateArg4]> Keyflare. If the current realm is \"Caro\", the Crimson Furnace cap is increased by <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "Each time your team plays a card, gain [StateArg1] stacks of Shield for 1 turn."
  },
  State_3757_Name = {
    Text = "Feather Blizzard"
  },
  State_3757_WeaponDesc = {
    Text = "Your team gains [StateArg1] stacks of Shield for each card played. Lasts 1 turn."
  },
  State_3759_Name = {Text = "Mecha 1"},
  State_3760_Desc = {
    Text = "If you have at least [StateArg1] Black Sigils, [Exalt] consumes [StateArg1] Black Sigils and makes all enemies Vulnerable and Weak for 1 turn."
  },
  State_3760_Name = {
    Text = "Relic Omen Ritual Bird"
  },
  State_3760_WeaponDesc = {
    Text = "If you have at least [StateArg1] Black Sigils, [Exalt] consumes [StateArg1] Black Sigils and makes all enemies Vulnerable and Weakness for 1 turn."
  },
  State_3761_Desc = {
    Text = "Whenever your team draws 1 Stagger, gain [Layer] STR."
  },
  State_3761_Name = {
    Text = "Lantern Ceremony"
  },
  State_3761_WeaponDesc = {
    Text = "Whenever your team draws 1 Stagger, obtain [Layer] STR."
  },
  State_3763_Desc = {
    Text = "For each hit dealt by The Scuttler this turn, Crit. DMG increases by [StateArg3]%."
  },
  State_3763_Name = {
    Text = "Passage Fold"
  },
  State_3763_WeaponDesc = {
    Text = "For each hit dealt by the Skulker this turn, Crit. DMG increases by [StateArg3]%."
  },
  State_3764_Name = {Text = "Mecha 2"},
  State_3766_Name = {
    Text = "Add Scarlet Strength Multiplier"
  },
  State_3767_Desc = {
    Text = "At turn start, deal [Arg1] DMG to a random enemy. After playing \"Strike\" 7 times in this battle, the DMG dealt will change to [Arg2]."
  },
  State_3768_Desc = {
    Text = "Active DMG always crits and is removed at turn end."
  },
  State_3768_Name = {Text = "(Falter)"},
  State_3768_WeaponDesc = {
    Text = "Active DMG taken will critically hit for sure, and it will be removed at turn end."
  },
  State_3770_Name = {
    Text = "Relic Arcana Count"
  },
  State_3771_Desc = {
    Text = "At the start of the battle, gain 3 Arithmetica."
  },
  State_3772_Desc = {
    Text = "For each hit, Vengeance Blade gains Temporary STR equal to the current Tentacle DMG."
  },
  State_3772_Name = {
    Text = "Preemptive Revenge"
  },
  State_3773_Desc = {
    Text = "At turn end, take DMG equal to stacks."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Poison>"
  },
  State_3773_WeaponDesc = {
    Text = "Take DMG at turn start."
  },
  State_3774_Desc = {
    Text = "Gain 1 \"Toxic Infusion\" that can apply [Arg1] Poison upon releasing Exaslt. At turn end, for every 3 \"Toxic Infusion\" cards in hand, synthesize 1 \"Toxic Outbreak\" that triggers Poison."
  },
  State_3776_Desc = {
    Text = "Every time you receive Active DMG, gain a stack of \"Alertness\". When \"Alertness\" reaches 3 stacks, retreat."
  },
  State_3776_Name = {Text = "Timid Doll"},
  State_3776_WeaponDesc = {
    Text = "Every time you take Active DMG, gain a stack of \"Vigilance\". Retreat when \"Vigilance\" reaches 3 stacks."
  },
  State_3777_Desc = {
    Text = "When played, increase this Awakener's Aliemus by <Energy:[StateArg1]>."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Adv. Berserk>"
  },
  State_3777_WeaponDesc = {
    Text = "When played, increase this Awakener's Aliemus by <Energy:[StateArg1]>."
  },
  State_3778_Desc = {
    Text = "Deal 25% more DMG to enemies with debuffs, and gain 20 Aliemus upon killing them."
  },
  State_3779_Desc = {
    Text = "Tentacle Limit reduced by 2. At turn end, all Tentacles attack once more."
  },
  State_3779_Name = {
    Text = "Relic Sacred Agony"
  },
  State_3779_WeaponDesc = {
    Text = "Reduce the Tentacle limit by 2. At the end of each turn, all Tentacles make an additional attack."
  },
  State_3781_Desc = {
    Text = "At turn start, apply \"Stagnation Curse\" to the top 2 cards of the deck."
  },
  State_3781_Name = {
    Text = "\"Cursed Eye of the Abyss\""
  },
  State_3781_WeaponDesc = {
    Text = "At turn start, apply \"Stagnant Curse\" to the top 2 cards in the deck."
  },
  State_3782_Desc = {
    Text = "Team Unique: At the start of exploration, add one \"Defense\" of the wielder to the deck, increasing the Shield of the wielder's \"Defense\" by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3782_WeaponDesc = {
    Text = "At the start of exploration, add a \"Defense\" card to the deck. The wielder's \"Defense\" shield is increased by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Team Unique: Increases the base Exalt DMG of the wielder by <WeaponEffect_Num:[StateArg1]%>, and increases shield and HP Recovery by <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3783_WeaponDesc = {
    Text = "Increases the wielder's Exalt Base DMG by <WeaponEffect_Num:[StateArg1]%>. Increases Shield Generation and HP Recovery by <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_Desc = {
    Text = "Team Unique: Increase the Base DMG of the wielder's Command Card by <WeaponEffect_Num:[StateArg1]%>, and increase Shield and HP Recovery by <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_WeaponDesc = {
    Text = "The wielder's Command Card Base DMG is increased by <WeaponEffect_Num:[StateArg1]%>, and Shield/HP Recovery is increased by <WeaponEffect_Num:[StateArg2]%.>"
  },
  State_3786_Desc = {
    Text = "You are the target! After playing, all monsters gain [StateArg1] Temporary STR, and the Mark of Abyss of this command is removed."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Mark of Abyss>"
  },
  State_3786_WeaponDesc = {
    Text = "After the card is played, the Deep Diver gains [StateArg1] Temporary STR."
  },
  State_3787_Desc = {
    Text = "Team Unique: After the wielder triggers Exalt, all allies gain <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3787_WeaponDesc = {
    Text = "After the wielder releases Exalt, all allies obtain <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3788_Desc = {
    Text = "Team Unique: At the start of exploration, add one \"Strike\" of the wielder to the deck, increasing the Base DMG of the wielder's \"Strike\" by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3788_WeaponDesc = {
    Text = "At the start of exploration, add a \"Strike\" card to the deck and increase the wielder's \"Strike\" Base DMG by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3790_Desc = {
    Text = "State@Indeterminate Substance Count"
  },
  State_3790_Name = {
    Text = "State@Indeterminate Substance Count"
  },
  State_3790_WeaponDesc = {
    Text = "State@Indeterminate Substance Count"
  },
  State_3791_Desc = {
    Text = "Whenever DMG is dealt, gain [Arg1] Shield, stacking up to 5 times per turn. When fully stacked, place a \"Insight\" into hand."
  },
  State_3792_Desc = {
    Text = "No longer affected by Petrify."
  },
  State_3792_Name = {
    Text = "Petrification Resistance"
  },
  State_3792_WeaponDesc = {
    Text = "No longer petrified, now takes triple DMG"
  },
  State_3793_Desc = {
    Text = "Crit. DMG in this stage is increased by [Layer]%."
  },
  State_3793_Name = {
    Text = "Permanent Crit. DMG"
  },
  State_3793_WeaponDesc = {
    Text = "Crit. DMG is increased by [Layer]% in this stage."
  },
  State_3794_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3794_Name = {
    Text = "State@Prototype Longsword Crit Damage"
  },
  State_3796_Desc = {
    Text = "For every 20% HP lost, all Awakeners gain 10 Aliemus, and Tentacle DMG increases upon death."
  },
  State_3796_Name = {
    Text = "Extracted Silver Grains"
  },
  State_3796_WeaponDesc = {
    Text = "HP decreases by 20%, all Awakeners obtain 10 Aliemus, adds Tentacle DMG upon death"
  },
  State_3797_Desc = {
    Text = "Gain [StateArg1] Temporary STR per DMG taken, removed at turn start."
  },
  State_3797_Name = {
    Text = "Wrath of the Rat Swarm!"
  },
  State_37980_Desc = {
    Text = "Realm Mastery increased by [Layer] in this battle."
  },
  State_37980_Name = {
    Text = "Realm Mastery"
  },
  State_3798_Desc = {
    Text = "Restore HP after dealing actual Damage."
  },
  State_3798_Name = {
    Text = "Vampire Blade"
  },
  State_3798_WeaponDesc = {
    Text = "Restore HP after dealing actual DMG."
  },
  State_3799_Desc = {
    Text = "For each [Caro] class Awakener in the team, the entire team's Max HP (not finished), Defense, and Attack are increased by 50%"
  },
  State_3799_Name = {Text = "Caro Bonus"},
  State_3799_WeaponDesc = {
    Text = "For each [Caro] class Awakener in the team, the entire team's Max HP (Not completed), Defense, and Attack are increased by 50%."
  },
  State_3800_Desc = {
    Text = "Deal DMG to all enemies. <CardKeyWord:Strength> enhances this DMG multiple times."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Blade's Dominion>"
  },
  State_3801_Desc = {
    Text = "Adds [StateArg1] stacks of Bleeding when dealing DMG that is not blocked."
  },
  State_3801_Name = {Text = "Bleeding"},
  State_3802_Desc = {
    Text = "While in hand, each Command Card used becomes a copy with 0 Arithmetica."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Scion of Purity>"
  },
  State_3802_WeaponDesc = {
    Text = "While in hand, using each card creates a copy with 0 Arithmetica."
  },
  State_3803_Desc = {
    Text = "At the start of the battle, all cards with a current Arithmetica Cost of 1 gain +[Arg1] Damage, Shield, and Healing for this battle."
  },
  State_3804_Desc = {
    Text = "Mutated Trident Count"
  },
  State_3804_Name = {
    Text = "Trident Mutation Count"
  },
  State_3804_WeaponDesc = {
    Text = "Mutated Trident Count"
  },
  State_3807_Name = {
    Text = "Dream of Medicine from Accessories"
  },
  State_3807_WeaponDesc = {
    Text = "At the start of the battle, shuffle an additional set of the wielder's cards into the Draw Pile."
  },
  State_3808_Desc = {
    Text = "State@ChangeCurrentLife"
  },
  State_3808_Name = {
    Text = "State@ChangeCurrentLife"
  },
  State_3808_WeaponDesc = {
    Text = "State@ChangeCurrentLife"
  },
  State_3810_Desc = {
    Text = "After death, the Strength of other allies increases."
  },
  State_3810_Name = {
    Text = "Death Whisper"
  },
  State_3811_Desc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3811_Name = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_4_1"
  },
  State_3813_Name = {
    Text = "Immune to Weakness"
  },
  State_3815_Desc = {
    Text = "At turn end, all Awakeners lose [Layer] Aliemus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Void>"
  },
  State_3815_WeaponDesc = {
    Text = "Obtain: Aliemus reduced by [Layer]%."
  },
  State_3817_Desc = {
    Text = "At turn start, inflict [DescArg1] Exhaustion on the opponent."
  },
  State_3817_Name = {
    Text = "Dissipation"
  },
  State_3817_WeaponDesc = {
    Text = "At turn start, your team obtains [DescArg1*Layer*0.01] stacks of Drain."
  },
  State_3818_Name = {
    Text = "State@Enlightened by the Wise 1"
  },
  State_3819_Name = {
    Text = "Chainbreaker Enlighten 1"
  },
  State_3819_WeaponDesc = {
    Text = "Ancient Imitator"
  },
  State_3821_Desc = {
    Text = "At turn start, gain a Shield equal to half of the HP lost last turn."
  },
  State_3821_Name = {
    Text = "Pain and Pleasure"
  },
  State_3821_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_3824_Desc = {
    Text = [[
Team Unique: Exalt Base DMG +[StateArg1]%. At the start of exploration, the wielder enters the Scholar Persona. Using Exalt switches the wielder between the Scholar and Jester Personas.
Scholar: Gain <WeaponEffect_Num:[StateArg2]> Aliemus at turn end.
Jester: Crit. Rate and Crit. DMG +<WeaponEffect_Num:[StateArg3]%> at turn end.]]
  },
  State_3824_WeaponDesc = {
    Text = [[
Wielder's Exalt Base DMG is increased by [StateArg1]%. At the start of exploration, the wielder enters the Scholar Persona. After Exalting, the wielder switches between the Scholar and Jester Personas.
Scholar: At turn end, the wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus.
Clown: At turn end, the wielder's Crit. Rate and Crit. DMG increase by <WeaponEffect_Num:+[StateArg3]%>.]]
  },
  State_3825_Desc = {
    Text = "When attacked, deal DMG equal to the number of Counter stacks to the attacker."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:Counter>"
  },
  State_3825_WeaponDesc = {
    Text = "deals DMG to the attacker each time it is attacked."
  },
  State_3826_Name = {
    Text = "State@Phantom Silver Key: Burst Count"
  },
  State_3827_Desc = {
    Text = "Team Unique: Increases the wielder's HP Recovery by <WeaponEffect_Num:[StateArg1]%>. After releasing Exalt, recover <WeaponEffect_Num:[StateArg2]%> of lost HP at the start of next turn."
  },
  State_3827_WeaponDesc = {
    Text = "Increase the wielder's HP regeneration by <WeaponEffect_Num:[StateArg1]%>. After Exalt, recover <WeaponEffect_Num:[DescArg1]%> of the lost HP at the start of next turn."
  },
  State_3829_Name = {
    Text = "Forgotten Relic 2: The Blood of Oblivion"
  },
  State_3830_Name = {
    Text = "Takes effect 1 additional time"
  },
  State_3831_Name = {
    Text = "Relic Reversal Root"
  },
  State_3832_Desc = {
    Text = "At the start of battle, generate 1 Embryo Fusion. For each Awakener with maximum Aliemus, generate an additional Embryo Fusion."
  },
  State_3832_Name = {
    Text = "Forgotten Relic Blood 1"
  },
  State_3832_WeaponDesc = {
    Text = "At the start of battle, generate 1 Embryo Fusion. For each Awakener with full Aliemus, generate an additional Embryo Fusion."
  },
  State_3834_Desc = {
    Text = "The poison DMG inflicted by Spider of the Labyrinth is doubled."
  },
  State_3834_Name = {
    Text = "Path of the Lost"
  },
  State_3835_Desc = {
    Text = "Crit. DMG increases by [Layer]% this turn."
  },
  State_3835_Name = {
    Text = "Temporary Crit. DMG"
  },
  State_3835_WeaponDesc = {
    Text = "Crit. DMG is increased by [Layer]% this turn."
  },
  State_3836_Desc = {Text = "Test 123"},
  State_3836_Name = {Text = "Test 123"},
  State_3837_Desc = {
    Text = "Team Unique: The wielder's Aliemus Generation +<WeaponEffect_Num:[StateArg1]%>, and Poison +<WeaponEffect_Num:[StateArg2]%>. After the wielder deals DMG, all Awakeners gain a Temporary Crit. DMG increase equal to <WeaponEffect_Num:[StateArg3]%> of the wielder's Crit. DMG, effective up to 1 time per turn. If the current realm is \"Aequor\", at the start of combat, both the Tentacle limit and the number of Tentacles increase by 1."
  },
  State_3837_WeaponDesc = {
    Text = "The wielder's Aliemus increases by <WeaponEffect_Num:[StateArg1]%>, and the inflicted Poison increases by <WeaponEffect_Num:[StateArg2]%>. After the wielder deals DMG, all Awakeners gain Temporary Crit. DMG of <WeaponEffect_Num:[DescArg1]%>, activating a maximum of 1 time per turn. If the current Realm is \"Aequor\", at the start of Battle, both Tentacle Limit and Tentacle Count increase by 1."
  },
  State_3839_Desc = {
    Text = "At the start of battle, gain [Arg1] Strength for each Symptom Card in your deck. All your Symptom Cards gain Fleeting."
  },
  State_3840_Desc = {
    Text = "Every time HP decreases, gains [StateArg1] Alert."
  },
  State_3840_Name = {Text = "Vigilance"},
  State_3842_Desc = {
    Text = "Reduce all DMG dealt by [DescArg1]%."
  },
  State_3842_Name = {Text = "Weakness"},
  State_3842_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_3843_Desc = {
    Text = "Each action applies [Layer] Bleed."
  },
  State_3843_Name = {
    Text = "Severe Injury"
  },
  State_3843_WeaponDesc = {
    Text = "Each action adds [Layer] Bleed; healing can remove the Bleed effect."
  },
  State_3844_Desc = {
    Text = "All Whale Leap DMG instances +1."
  },
  State_3844_Name = {
    Text = "Battle Thirst"
  },
  State_3844_WeaponDesc = {
    Text = "All Whale Leap DMG instances +1."
  },
  State_3845_Desc = {
    Text = "Card Arithmetica-"
  },
  State_3845_Name = {
    Text = "Card Arithmetica Decrease"
  },
  State_3845_WeaponDesc = {
    Text = "Card Arithmetica-"
  },
  State_3846_Name = {
    Text = "Relic Jade Imprint"
  },
  State_3848_Desc = {
    Text = "In this battle, one random Awakener's Exaltation is sealed and cannot be used."
  },
  State_3848_Name = {Text = "Sealed"},
  State_3850_Desc = {
    Text = "For every [StateArg1] cards played, increase Tentacle DMG by [StateArg2] and make all Tentacles attack once."
  },
  State_3850_Name = {
    Text = "Mutated Trident"
  },
  State_3850_WeaponDesc = {
    Text = "Every time you play the [StateArg1]th card, increase Tentacle DMG by [StateArg2] and make all Tentacles attack once."
  },
  State_3851_Name = {
    Text = "Theater Cat Accessory"
  },
  State_3851_WeaponDesc = {
    Text = "All DMG dealt +10% of the wielder's Max HP."
  },
  State_3852_Desc = {
    Text = "Increase the number of bite DMG instances by [Layer]."
  },
  State_3852_Name = {
    Text = "Insistent Bites"
  },
  State_3852_WeaponDesc = {
    Text = "Increase the number of Bite DMG instances by [Layer]."
  },
  State_3853_Desc = {
    Text = "At turn start, randomly transform into a copy of a Command Card in the Draw Pile, with a fixed Arithmetica Cost of 3. Revert at turn end."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Delirium>"
  },
  State_3853_WeaponDesc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_3854_Desc = {
    Text = "Draw 2 cards, but this will attract the attention of the Skull Hunter."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Hunted>"
  },
  State_3855_Name = {Text = "Strength"},
  State_3856_Desc = {
    Text = "State@Prologue Reset Deck 0_1_3_1"
  },
  State_3856_Name = {
    Text = "State@Prologue Reset Deck 0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "State@Prologue Reset Deck 0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Aliemus provided by Breath of Fertility is doubled."
  },
  State_3859_Name = {
    Text = "Ad Matrem Vocatus"
  },
  State_3859_WeaponDesc = {
    Text = "Aliemus provided by Breath of Fertility is doubled."
  },
  State_3860_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3860_Name = {
    Text = "State@Prototype Dagger Luck"
  },
  State_3862_Name = {
    Text = "State@Level2_15Battle4Bubble1"
  },
  State_3863_Desc = {
    Text = "After releasing Exalt 3 times, reduce Arithmetica Cost for all cards in hand by 1."
  },
  State_3865_Desc = {
    Text = "State@ChangeCurrentLife"
  },
  State_3865_Name = {
    Text = "State@General Card Arithmetica Exhaust 0"
  },
  State_3865_WeaponDesc = {
    Text = "Temporarily change the card's Arithmetica"
  },
  State_3866_Desc = {
    Text = "During this turn, the hand limit is increased by [Layer]."
  },
  State_3866_Name = {
    Text = "Hand Limit+"
  },
  State_3867_Name = {
    Text = "Ultra-Class Counter"
  },
  State_3868_Desc = {
    Text = "Increase the Shield generated this turn by [Layer]."
  },
  State_3868_Name = {
    Text = "Temporary Alert"
  },
  State_3868_WeaponDesc = {
    Text = "Shield Generation is increased by [Layer] this turn."
  },
  State_3871_Desc = {
    Text = "At turn start, gain [StateArg1] Temporary STR for each card in Ultra Space."
  },
  State_3871_Name = {
    Text = "Relic Trigon Prism"
  },
  State_3872_Desc = {
    Text = "Taking DMG cancels Temporary STR."
  },
  State_3872_Name = {Text = "(Falter)"},
  State_38730_Desc = {
    Text = "At turn start, there is a [DescArg1]% chance to gain 1 stack of Tentacle Gathering. If it exceeds 100%, multiple stacks can be gained."
  },
  State_38730_Name = {
    Text = "Returnal Line"
  },
  State_38735_Desc = {
    Text = "Reduce DMG dealt by [StateArg1]%, double the number of attacks, and last for [Layer] turns."
  },
  State_38735_Name = {Text = "Murmurs"},
  State_38738_Desc = {
    Text = "Maximum of 10 stacks, carries over to the next battle."
  },
  State_38738_Name = {Text = "Dreamlure"},
  State_3873_Desc = {
    Text = "Realm Mastery increased by [Layer] in this battle."
  },
  State_3873_Name = {
    Text = "Realm Mastery"
  },
  State_3874_Name = {
    Text = "State@Wind Chime Card Restoration"
  },
  State_3876_Desc = {
    Text = "Reduces the team's Strength every even turn."
  },
  State_3876_Name = {
    Text = "\"Hole of Dying Dream\""
  },
  State_3878_Desc = {
    Text = "For every 2 HP lost, gain [Layer] Shield at the start of next turn."
  },
  State_3878_Name = {
    Text = "Pain and Pleasure"
  },
  State_3878_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_3879_Desc = {
    Text = "Max HP increases by [Arg1] when picked up. If HP is below 25% when picked up, the increase in Max HP becomes [Arg2]."
  },
  State_3881_Desc = {
    Text = "State@Monster George devours wax sculpture minion"
  },
  State_3881_Name = {
    Text = "State@Monster George devours wax sculpture minion"
  },
  State_3881_WeaponDesc = {
    Text = "State@Monster George devours wax sculpture minion"
  },
  State_3882_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3882_Name = {Text = "Not Roused"},
  State_3883_Desc = {
    Text = "Crit. Rate + [Layer]% in this stage."
  },
  State_3883_Name = {
    Text = "Permanent Crit. Rate"
  },
  State_3883_WeaponDesc = {
    Text = "Crit. Rate + [Layer]% in this stage."
  },
  State_3884_Desc = {
    Text = "Generate 1 additional Embryo Fusion each turn. All your devouring effects become Infinite Devouring."
  },
  State_3884_Name = {
    Text = "Relic Wriggling Cord"
  },
  State_3884_WeaponDesc = {
    Text = "Generate 1 additional Embryo Fusion each turn. All your devouring effects become Infinite Devour."
  },
  State_3888_Desc = {
    Text = "Cannot unleash Exalt; remove 1 stack at turn end."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Sealed>"
  },
  State_3888_WeaponDesc = {
    Text = "All Awakeners' Exalt is unusable."
  },
  State_3890_Name = {
    Text = "Draw Number of Discards +[DescArg1] × cards"
  },
  State_3891_Name = {
    Text = "Inflict [Layer] turns of Weakness on all enemies"
  },
  State_3892_Desc = {
    Text = "Team Unique: After defeating an enemy, increase Attack by [StateArg1]% and Crit. DMG by [StateArg1]% for this investigation."
  },
  State_3892_Name = {
    Text = "Weapon Cult Zealot"
  },
  State_3892_WeaponDesc = {
    Text = "After defeating an enemy, increase your ATK by [StateArg1]% for this investigation. Increase Crit. DMG by [StateArg1]%."
  },
  State_3893_Desc = {
    Text = "Gain [Arg1] Shield when dealing Damage. Gain [Arg2] Temporary STR when healing HP."
  },
  State_3894_Desc = {
    Text = "Before the discard phase, turn your hand cards into stones."
  },
  State_3894_Name = {Text = "Petrify"},
  State_3894_WeaponDesc = {
    Text = "Before the discard phase, turn your hand into Stone."
  },
  State_3895_Desc = {
    Text = "Crit. Rate increased by [Layer]% this turn."
  },
  State_3895_Name = {
    Text = "Temporary Crit. Rate"
  },
  State_3895_WeaponDesc = {
    Text = "Crit. Rate increased by [Layer]% this turn."
  },
  State_3898_Desc = {
    Text = "Gain [Layer] Shield at the start of next turn."
  },
  State_3898_Name = {
    Text = "Shield of Pain and Pleasure"
  },
  State_3900_Name = {
    Text = "The card is sealed and cannot be played. Discard it to unseal."
  },
  State_3901_Name = {
    Text = "Relic Priest Staff Count"
  },
  State_3902_Desc = {
    Text = "This turn, Active DMG dealt is reduced by [Layer]."
  },
  State_3902_Name = {Text = "STR▼"},
  State_3902_WeaponDesc = {
    Text = "DMG dealt this turn is reduced by [Layer]."
  },
  State_3903_Name = {
    Text = "Gain [Block:DescArg1] Shield"
  },
  State_3904_Desc = {
    Text = "For each point of HP lost, remove 1 stack; when the stacks reach 0, gain [StateArg1] Shield and regain [StateArg2] stacks of Blood Barrier."
  },
  State_3904_Name = {
    Text = "Blood Barrier-Rouse"
  },
  State_3905_Desc = {
    Text = "Deal [Layer] DMG to the attacker when hit."
  },
  State_3905_Name = {Text = "Counter"},
  State_3905_WeaponDesc = {
    Text = "Deals [Layer] DMG to the attacker each time it is attacked."
  },
  State_3906_Name = {
    Text = "Residual Silver"
  },
  State_3907_Name = {
    Text = "Residual Silver"
  },
  State_3908_Desc = {
    Text = "When Brain in a Vat applies healing, draw [Arg2] cards."
  },
  State_3908_Name = {
    Text = "Duality of Illusions"
  },
  State_3908_WeaponDesc = {
    Text = "When Brain in a Vat applies healing, draw [Arg2] cards."
  },
  State_3909_Name = {
    Text = "Residual Silver"
  },
  State_3910_Name = {
    Text = "Residual Silver"
  },
  State_3911_Name = {
    Text = "Residual Silver"
  },
  State_3912_Name = {
    Text = "Residual Silver"
  },
  State_3913_Desc = {
    Text = "Team Unique: The wielder's Shield Generation +<WeaponEffect_Num:[StateArg1]%>. At turn start, retain <WeaponEffect_Num:[StateArg2]%> of the remaining Shield, up to <WeaponEffect_Num:[StateArg3]%> of Max HP."
  },
  State_3913_WeaponDesc = {
    Text = "The wielder's Shield Generation +<WeaponEffect_Num:[StateArg1]%>. At turn start, retain <WeaponEffect_Num:[StateArg2]%> of the remaining Shield, up to <WeaponEffect_Num:[StateArg3]%> of Max HP."
  },
  State_3914_Desc = {
    Text = "After releasing the 2nd Exalt each turn, all Awakeners gain 10 Aliemus. After releasing the 3rd Exalt each turn, reset all Awakeners' Aliemus cooldown and grant an additional 10 Aliemus."
  },
  State_3915_Name = {
    Text = "Residual Silver"
  },
  State_3916_Name = {
    Text = "Residual Silver"
  },
  State_3917_Desc = {
    Text = "Gain Temporary STR next turn"
  },
  State_3917_Name = {Text = "Charge"},
  State_3918_Desc = {
    Text = "At turn start, gain a state where the first DMG received is doubled."
  },
  State_3918_Name = {Text = "Arrogance"},
  State_3918_WeaponDesc = {
    Text = "Obtain the State of doubling the first DMG taken at the Start of each Turn"
  },
  State_3921_Desc = {
    Text = "In this turn, Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Retain>"
  },
  State_3921_WeaponDesc = {
    Text = "Card will not enter the Discard Pile, but instead remains in your hand."
  },
  State_3923_Desc = {
    Text = "Card Arithmetica-"
  },
  State_3923_Name = {
    Text = "Permanent Card Arithmetica Decrease"
  },
  State_3923_WeaponDesc = {
    Text = "Card Arithmetica-"
  },
  State_3925_Name = {
    Text = "State@Chapter 4 Resonance@Our Turn Start Arithmetica 2"
  },
  State_3926_Desc = {
    Text = "\"Feast of the Twisted Dead\" increases DMG by [Layer]."
  },
  State_3926_Name = {Text = "Distortion"},
  State_3926_WeaponDesc = {
    Text = "Increase \"Mania\" Damage."
  },
  State_3927_Desc = {
    Text = "After drawing \"Void\", reduce all Awakeners' gained Aliemus by [Layer]% this turn."
  },
  State_3927_Name = {Text = "Void"},
  State_3927_WeaponDesc = {
    Text = "After drawing \"Void\", all Awakeners' obtained Aliemus is reduced by [Layer]% this turn."
  },
  State_3928_Desc = {
    Text = "When Sweet Demon deals DMG, gain [StateArg2] Counter."
  },
  State_3928_Name = {
    Text = "Give and Take"
  },
  State_3929_Desc = {
    Text = "Gain 50% less Strength and Shield, and remove 1 stack at turn end."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Curse>"
  },
  State_3929_WeaponDesc = {
    Text = "Immune to positive buffs applied to self this turn"
  },
  State_3930_Name = {
    Text = "State@Chapter 4 Resonance@Our Turn Start Arithmetica 1"
  },
  State_3931_Name = {
    Text = "State@Hymn of Crimson Blood and Sand"
  },
  State_3932_Desc = {
    Text = "Grant the card \"Retain\". Each stack of Stagnant Curse increases the card's cost by 1. Remove the Stagnant Curse after playing."
  },
  State_3932_Name = {
    Text = "Stagnant Curse ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Grant the card Retain. Each stack of Stagnant Curse increases the card's cost by 1. Remove the Stagnant Curse after playing."
  },
  State_3933_Desc = {
    Text = "Increase DEF by [Layer]."
  },
  State_3933_Name = {
    Text = "Temporary Defense Increase"
  },
  State_3933_WeaponDesc = {
    Text = "Increase DEF by [Layer]."
  },
  State_3934_Desc = {
    Text = "All Shield obtained are reduced by 50%."
  },
  State_3934_Name = {
    Text = "Fragile Doom"
  },
  State_3934_WeaponDesc = {
    Text = "All Shield obtained are reduced by 50%."
  },
  State_3935_Desc = {
    Text = "Each time your team uses a card, gain 1 stack of \"Observation\". Upon reaching 10 stacks, become stunned."
  },
  State_3935_Name = {
    Text = "Observation"
  },
  State_3936_Desc = {
    Text = "The wielder's Damage, Shield, and Healing +[StateArg1]%. (Temporary)"
  },
  State_3936_Name = {
    Text = "State@Proto Longsword Realm"
  },
  State_3937_Desc = {
    Text = "When Queen of Thorns performs a counterattack, she gains a Shield equal to half the DMG of the counterattack."
  },
  State_3937_Name = {
    Text = "Wall of Corpses"
  },
  State_3938_Name = {
    Text = "Create Wax Sculpture"
  },
  State_3941_Desc = {
    Text = "When devouring Embryos, they return from the Discard Pile to the hand."
  },
  State_3941_Name = {
    Text = "Colorless Spiral"
  },
  State_3941_WeaponDesc = {
    Text = "When devouring an embryo, return from the Discard Pile to the Hand Deck."
  },
  State_3942_Name = {
    Text = "Accessory Returnal Line"
  },
  State_3942_WeaponDesc = {
    Text = "At the start of battle, if the wielder is of the Aequor class, increase ATK by 25%."
  },
  State_3943_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_3943_Name = {Text = "Not Roused"},
  State_3944_Desc = {
    Text = "After the turn ends, all Awakeners gain 5 Aliemus. For each remaining Arithmetica, all Awakeners gain an additional 3 Aliemus."
  },
  State_3945_Desc = {
    Text = "All Relic prices reduced by 50%."
  },
  State_39547_Desc = {
    Text = "After the battle, gain 5 extra Black Sigils. This effect is enhanced by Sigil Yield. After Wanda plays a card, gain 1 stack of Dreamlead. This effect can trigger up to 2 times per turn. Currently, [DescArg1] times remaining."
  },
  State_39547_Name = {
    Text = "Venus and fur"
  },
  State_40483_Name = {
    Text = "Shattered Halberd"
  },
  State_40484_Desc = {
    Text = "When Wanda's skill triggers the Leap effect and there are 5 stacks present, consume 5 stacks to grant an additional effect. The cap for Dreamlure is 10 stacks, which will carry over into the next battle."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Dreamlure>"
  },
  State_41337_Desc = {
    Text = "Recover [Layer] HP at turn end."
  },
  State_41337_Name = {
    Text = "Victory of Roses: Healing"
  },
  State_41340_Desc = {
    Text = "Team Unique: Increases the wielder's Shield and Counter by <WeaponEffect_Num:[StateArg1]%>. When attacked, there is a <WeaponEffect_Num:[StateArg2]%> chance for all Awakeners to gain 1 Aliemus."
  },
  State_41340_WeaponDesc = {
    Text = "Increases the wielder's Shield Generation and Counter by <WeaponEffect_Num:[StateArg1]%>. Whenever attacked, there is a <WeaponEffect_Num:[StateArg2]%> chance for all Awakeners to gain 1 Aliemus."
  },
  State_41342_Name = {
    Text = "Effect Changes"
  },
  State_41344_Name = {
    Text = "Effect Changes"
  },
  State_41360_Desc = {
    Text = "Consume 5 stacks of <DreamGuide:Dreamlure>, Wanda obtains <Energy:[StateArg1]> Aliemus, and gains Temporary <RetaliateIconKeywords:Counter> equal to [StateArg2]% of permanent <RetaliateIconKeywords:Counter>."
  },
  State_41360_Name = {
    Text = "Slumber Counter"
  },
  State_41361_Desc = {
    Text = "Exhaust 10 stacks of<DreamGuide:Dreamlure>, causing all enemies to enter the \"Murmur\" state for 1 turn: DMG reduced by [StateArg3]%, but the number of attacks is doubled."
  },
  State_41361_Name = {
    Text = "Echoes of Whispers"
  },
  State_43818_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_43818_Name = {Text = "Not Roused"},
  State_44398_Desc = {
    Text = "After playing a card for the first time each turn, place a \"Defense\" from the corresponding Awakener into hand."
  },
  State_44484_Name = {
    Text = "Can be used 3 times in Boss Battles."
  },
  State_44485_Name = {
    Text = "(Remaining:[Layer])"
  },
  State_44491_Name = {
    Text = "Disable Effect"
  },
  State_44562_Name = {
    Text = "Disable Effect"
  },
  State_44575_Desc = {
    Text = "The remaining Shield this turn will not be removed and will carry over to the next turn."
  },
  State_44575_Name = {
    Text = "Shield Retain"
  },
  State_44653_Desc = {
    Text = "All Awakeners gain 20 Aliemus at turn start. Max HP is reduced by 50% upon pickup."
  },
  State_44665_Desc = {
    Text = "This turn, the Crit. Rate of \"Strike\" increases by [Layer]%."
  },
  State_44665_Name = {
    Text = "Strike Crit. Rate"
  },
  State_44667_Desc = {
    Text = "\"Strike\" gains [DescArg1] Arithmetica. If the current stance is \"Surge,\" no Arithmetica is gained, but 1 Tentacle is commanded to attack [DescArg2] times."
  },
  State_44667_Name = {
    Text = "Giant's Reign"
  },
  State_44671_Desc = {
    Text = "All Awakeners gain 25 Aliemus at turn start. Max HP x3 upon pickup."
  },
  State_44711_Desc = {
    Text = "Relic Capacity +5, +1 refresh in [D-Mark]. After battle, obtain 125 Black Sigils. When picked up, you can choose to destroy up to 6 Symptom cards."
  },
  State_44713_Desc = {
    Text = "After the battle, obtain an extra 100 Black Sigils, but develop 2 random Symptoms."
  },
  State_44730_Desc = {
    Text = "At turn start, accumulate <Heal:[Heal:StateArg1]> healing from the Crimson Furnace."
  },
  State_44730_Name = {
    Text = "Salvation Bestowal"
  },
  State_44731_Desc = {
    Text = "Pain for pain. Consume all remaining Healing from the Crimson Furnace, each point of Healing increases DMG dealt by 3 (9 during a Boss Battle)."
  },
  State_44731_Name = {Text = "Liberation"},
  State_44732_Desc = {
    Text = "Heal with blood. After dealing DMG, lose 10% of current HP and accumulate an equivalent amount of Healing in the Crimson Furnace."
  },
  State_44732_Name = {Text = "Dedication"},
  State_44739_Desc = {
    Text = "Permanently lose [Arg1] Strength upon pickup. Heal [Arg2] HP each time you deal Damage, up to 6 times per turn."
  },
  State_44741_Desc = {
    Text = "Permanently lose [Arg1] Strength upon pickup. Heal [Arg2] HP each time you deal Damage, up to 6 times per turn."
  },
  State_44742_Desc = {
    Text = "Permanently lose [Arg1] Strength upon pickup. Heal [Arg2] HP each time you deal Damage, up to 6 times per turn."
  },
  State_44743_WeaponDesc = {
    Text = "Fragile self for 3 turns when the battle begins."
  },
  State_44744_WeaponDesc = {
    Text = "Fragile self for 3 turns when the battle begins."
  },
  State_44750_Desc = {
    Text = "At turn start, gain [StateArg1] Arithmetica."
  },
  State_44750_Name = {
    Text = "Relic Black Candle 1"
  },
  State_44751_Desc = {
    Text = "At turn start, gain [StateArg1] Arithmetica."
  },
  State_44751_Name = {
    Text = "Relic Black Candle 1"
  },
  State_44752_Desc = {
    Text = "Whenever \"Sophia\" loses 1 HP point, she loses 1 stack; when the number of stacks reaches 0, replace the intention with \"An Eye for an Eye\" and gain [StateArg2] Shield. The first activation will restore all stacks."
  },
  State_44752_Name = {
    Text = "Buried Impulse"
  },
  State_44762_Desc = {
    Text = "When playing \"Defense,\" shuffle 1 wound into the Draw Pile."
  },
  State_44762_Name = {Text = "Rend"},
  State_44763_Desc = {
    Text = "All Awakeners' Crit. DMG is halved."
  },
  State_44763_Name = {
    Text = "<ExclamationPointColour:Blind>"
  },
  State_44764_Desc = {
    Text = "When you play \"Strike\", shuffle 1 Wound card into your Draw Pile."
  },
  State_44764_Name = {Text = "Trauma"},
  State_44807_Desc = {
    Text = "When about to be defeated for the first time, recover HP and change intention to \"Mirror Judgement\", strengthening oneself. When about to be defeated for the second time, recover HP and change intention to \"Madness Bite\", dealing extremely high single Damage."
  },
  State_44807_Name = {
    Text = "Buried Slaughter"
  },
  State_44819_Desc = {
    Text = "If there is no <ParcloseIconKeywords:Barrier>, gain a Temporary <ParcloseIconKeywords:Barrier> stack. Otherwise, gain 10% Crit. Rate and Crit. DMG."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:All-Father's Protection>"
  },
  State_44828_Desc = {
    Text = "Team Unique: At turn end, the wielder gains [StateArg1] Aliemus. When taking DMG, gain Shield equal to <WeaponEffect_Num:[StateArg2]%> of the DMG at the start of next turn. If the current Realm is Caro, gain Crimson Furnace Healing equal to <WeaponEffect_Num:[StateArg2]%> of the DMG instead."
  },
  State_44828_WeaponDesc = {
    Text = "At turn end, the wielder gains <WeaponEffect_Num:[StateArg1]> Aliemus. When taking DMG, gain Shield equal to <WeaponEffect_Num:[Float:StateArg2]%> of the DMG at the start of next turn. If the current Realm is Caro, gain Crimson Furnace Healing equal to <WeaponEffect_Num:[Float:StateArg2]%> of the DMG instead."
  },
  State_44889_Name = {
    Text = "State@Human-Faced Dog BOSS@End Mirror 1"
  },
  State_44890_Name = {
    Text = "State@Houndman BOSS@Mirror of the End 2"
  },
  State_44891_Name = {
    Text = "State @ Hound BOSS @ Mirror of the End 3"
  },
  State_44903_Desc = {
    Text = "After being attacked, [StateArg1]% of the DMG will be converted into the recovery amount for the Crimson Furnace, lasting for [Layer] turns."
  },
  State_44903_Name = {
    Text = "He Who Protects"
  },
  State_44909_Name = {
    Text = "Exhaustable"
  },
  State_45018_Desc = {
    Text = "You cannot use \"Strike\" before turn end."
  },
  State_45018_Name = {Text = "Paralysis"},
  State_45025_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_45029_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_45032_Desc = {
    Text = "At the end of the next turn, take [Layer] Damage."
  },
  State_45032_Name = {Text = "Bleed"},
  State_45039_Desc = {
    Text = "Until the start of next turn, whenever you take attack Damage, gain a Shield equal to [Layer]% of the DMG at the start of next turn."
  },
  State_45039_Name = {
    Text = "Miracle's Dawn"
  },
  State_45040_Desc = {
    Text = "Until the start of next turn, whenever you take attack Damage, accumulate [Layer]% of the DMG as healing for the Crimson Furnace."
  },
  State_45040_Name = {
    Text = "Miracle's Dawn"
  },
  State_45049_Desc = {
    Text = "Negate the DMG of the next active attack (up to 3 stacks). Each stack of Deathmatch reduces Max Barrier stacks by 1, but does not remove Barriers already obtained."
  },
  State_45049_Name = {Text = "Barrier"},
  State_45050_Desc = {
    Text = "Negate the DMG of the next active attack (up to 3 stacks). Each stack of Deathmatch reduces Max Barrier stacks by 1, but does not remove Barriers already obtained."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barrier>"
  },
  State_45064_Name = {
    Text = "Silent Banquet Counter__「For Development Use Only」"
  },
  State_45069_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_45072_Name = {
    Text = "Sanctification Count"
  },
  State_45073_Desc = {
    Text = "Card Arithmetica-"
  },
  State_45076_Desc = {
    Text = "When applied, dispels Shield and delayed healing on the target. Reduces the effects of healing and Shield received by 50% until turn end"
  },
  State_45076_Name = {Text = "Blighten"},
  State_45137_Desc = {
    Text = "After using Exalt, seal all Awakeners for one turn and gain Vulnerable for one turn."
  },
  State_45137_Name = {
    Text = "Original Sin: Pathwalker's Remains"
  },
  State_45139_Desc = {
    Text = "After using Exalt, randomly dispel 1 debuff."
  },
  State_45139_Name = {
    Text = "Blessed: Pathwalker's Remains"
  },
  State_45148_Desc = {
    Text = "All Awakeners' Crit. DMG is halved."
  },
  State_45148_Name = {
    Text = "<ExclamationPointColour:Blind>"
  },
  State_45166_Desc = {
    Text = "Wheel of Destiny disabled until turn end."
  },
  State_45166_Name = {Text = "Entwined"},
  State_45206_Desc = {
    Text = "Redemption through faith. Consume all remaining restoration from the Crimson Furnace to gain a Shield equal to 150% of the consumed amount. This Shield is unaffected by Shield bonuses or debuffs and ignores Shield limits."
  },
  State_45206_Name = {Text = "Redemption"},
  State_45248_Name = {Text = "Counter"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", grant self <TauntKeywords:Taunt> and <Block:[Block:StateArg1]> Shield."
  },
  State_45328_Name = {Text = "35mm Magic"},
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" can select a target. Before each \"Strike\", <PVPRepelKeywords:Forceback> the target's all dispellable buffs to the Awakener behind them."
  },
  State_45329_Name = {
    Text = "Deep Sea's Call"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:Upon equipping and after \"Strike\", the wielder's Non-Derived \"Skills\" in hand will sequentially change to their other \"Skills\" [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Poetic Bygone Days"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Each time the wielder takes Active DMG, other allies gain <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_45332_Name = {
    Text = "The Gaze of Isarawu"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Hand Limit +[StateArg1], After \"Exalt\", gain <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Kiss of Farewell"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\" changes the next \"Strike\" this turn to hit random targets and additionally attacks [StateArg1] random targets."
  },
  State_45334_Name = {
    Text = "Man in the Mirror"
  },
  State_45345_Desc = {
    Text = "Used to record the number of times the Stage 1 fertility Skill has been used"
  },
  State_45345_Name = {
    Text = "Fertility Marker 1"
  },
  State_45346_Desc = {
    Text = "Used to record the number of times the Stage 2 Fertility Skill was used"
  },
  State_45346_Name = {
    Text = "Fertility Marker 2"
  },
  State_45354_Desc = {
    Text = "This card cannot be played."
  },
  State_45354_Name = {
    Text = "Cannot Play"
  },
  State_45356_Desc = {
    Text = "At turn end, transform into the last played \"Skill\" card with Arithmetica Cost -2. After playing it, \"Truth Behind Grey Mist\" is shuffled into the deck."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Truth Behind Grey Mist>"
  },
  State_45364_Desc = {
    Text = "At the start of next turn, the Awakener gains [Layer] \"Strike\"."
  },
  State_45364_Name = {
    Text = "Delay Gain Strike"
  },
  State_45385_Desc = {
    Text = "All DMG dealt in this battle is reduced by [Layer] and cannot be dispelled. This includes [DescArg1] stacks of Temporary STR reduction, which will be removed at turn end."
  },
  State_45385_Name = {Text = "STR▼"},
  State_45387_Desc = {
    Text = "All DMG dealt +[Layer] in this battle and cannot be dispelled. [DescArg1] stacks of Temporary STR will be removed at turn end."
  },
  State_45387_Name = {Text = "Strength"},
  State_45397_Desc = {
    Text = "At turn start, convert 1 stack of Barrier into Strength."
  },
  State_45397_Name = {
    Text = "Victory of Roses"
  },
  State_45403_Desc = {
    Text = "At the start of next turn, gain [Layer] stacks of Charge."
  },
  State_45403_Name = {
    Text = "Delay Charge"
  },
  State_45407_Desc = {
    Text = "The gained Aliemus and Delayed Aliemus -100%; immediately remove all Delayed Aliemus."
  },
  State_45407_Name = {Text = "Void"},
  State_45656_Desc = {
    Text = "The Mother Tree revives for the third time, activating Fertility Skill 2."
  },
  State_45658_Desc = {
    Text = "The Mother Tree revives for the first time, activating the Fertility Skill."
  },
  State_45661_Desc = {
    Text = "When HP drops to 0, it will be set to 1 point, no longer taking Damage, prepare to release \"Multi-Fusion\"."
  },
  State_45661_Name = {
    Text = "Multi-Fusion"
  },
  State_45715_Desc = {
    Text = "Gain Temporary STR equal to [StateArg1]% of Tentacle DMG."
  },
  State_45715_Name = {Text = "Usurp"},
  State_45716_Desc = {
    Text = "Gain Temporary STR equal to [StateArg1]% of Tentacle DMG. Goliath gains a 25% Temporary Crit. Rate."
  },
  State_45716_Name = {Text = "Usurp"},
  State_45717_Desc = {
    Text = "Increase the Base DMG of \"Blade's Dominion\" and \"Decapitation Damage\" by 25% in this battle. Goliath obtains <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45717_Name = {Text = "Dormancy"},
  State_45718_Desc = {
    Text = "Increase the Base DMG of \"Blade's Dominion\" and \"Decapitation Damage\" by 25% in this battle."
  },
  State_45718_Name = {Text = "Dormancy"},
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "This turn, each time the target takes Active DMG, heal the ally with the most lost HP by [Layer]."
  },
  State_46079_Name = {
    Text = "Guidance of Holy Blood"
  },
  State_46119_Desc = {
    Text = "Next time you are attacked, apply Entwine on the attacker."
  },
  State_46119_Name = {Text = "Maze Trap"},
  State_46124_Desc = {
    Text = "Cannot perform any actions until turn end."
  },
  State_46124_Name = {Text = "Petrify"},
  State_46138_Desc = {
    Text = "Becomes the last \"Skill\" played by the opponent, reducing its cost by -1."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Starborn Mimic>"
  },
  State_46139_Desc = {
    Text = "Gain [Layer] stacks of Charge and inflict [Layer] stacks of Stagnation on the attacker when receiving Active DMG."
  },
  State_46139_Name = {
    Text = "Anomalous Gravity"
  },
  State_46155_Desc = {
    Text = "After using \"Skill\", gain [StateArg1] Charge and lose 1 stack of this status. At turn end, consume all stacks, restoring [StateArg2] HP for each stack."
  },
  State_46155_Name = {
    Text = "Aberrant blood"
  },
  State_46243_Name = {
    Text = "Insight Counter__\"For Development Only\""
  },
  State_46255_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46256_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46322_Desc = {
    Text = "At turn start, gain 30% Embryo Fusion."
  },
  State_46322_Name = {
    Text = "Uvhash Trial"
  },
  State_46323_Desc = {
    Text = "At the start of the Ultra Round, gain 100 Aliemus. At turn start, gain 7 Strength."
  },
  State_46323_Name = {Text = "Liz Trial"},
  State_46324_Desc = {
    Text = "Gain 1 \"Insight\" per turn."
  },
  State_46324_Name = {
    Text = "Jenkin Trial"
  },
  State_46329_Desc = {
    Text = "At the start of the battle, gain 600 Keyflare. Lotan gains 50 Aliemus. After Lotan's Exalt, an additional 44 Aliemus is gained."
  },
  State_46329_Name = {
    Text = "Trial Bonus"
  },
  State_46330_Desc = {
    Text = "At turn start, gain 30% Embryo Fusion, 10 Aliemus, [DescArg1] Strength, and add 3 \"Strike\" to the Draw Pile."
  },
  State_46330_Name = {
    Text = "Helot Trial"
  },
  State_46333_Name = {
    Text = "Leigh Trial"
  },
  State_46334_Desc = {
    Text = "After the 4th turn, gain 100 Aliemus."
  },
  State_46334_Name = {
    Text = "Faros Trial"
  },
  State_46336_Desc = {
    Text = "At turn start, gain 30% Embryo Fusion and 10 Aliemus."
  },
  State_46336_Name = {
    Text = "Agrippa Trial"
  },
  State_46337_Desc = {
    Text = "At turn start, gain 10 Aliemus."
  },
  State_46337_Name = {
    Text = "Caecus Trial"
  },
  State_46338_Desc = {
    Text = "At turn start, gain 30% Embryo Fusion and 10 Aliemus."
  },
  State_46338_Name = {
    Text = "Faint Trial"
  },
  State_46427_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46428_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46429_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46441_Desc = {
    Text = "Immune to all Damage. Removed at turn start."
  },
  State_46441_Name = {
    Text = "Immune to Damage"
  },
  State_46442_Name = {
    Text = "Modification of the card's target type is prohibited."
  },
  State_46500_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_46505_Desc = {
    Text = "This turn, each time the target takes Active DMG, gain [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Pain Conversion"
  },
  State_46508_Desc = {
    Text = "When Fainted, a target cannot act until the turn ends. Taking Fainting DMG grants Resistance. If Resistance is active, subsequent Fainting DMG is doubled but the Fainting effect is negated."
  },
  State_46508_Name = {Text = "Resistance"},
  State_46512_Desc = {
    Text = "Before turn end, this Awakener takes [Layer] DMG for each card played."
  },
  State_46512_Name = {
    Text = "Action Lock"
  },
  State_46513_Desc = {
    Text = "Enhance the next Psalm to grant additional effects. Cannot be dispelled."
  },
  State_46513_Name = {
    Text = "Grieving Ink"
  },
  State_46536_Desc = {
    Text = "If the state parameter 1 is 0, draw a card; otherwise, just float the text"
  },
  State_46536_Name = {Text = "Draw"},
  State_46538_Desc = {
    Text = "At the start of exploration, gain [StateArg1] Aliemus."
  },
  State_46538_Name = {
    Text = "Madness Omen"
  },
  State_47072_Desc = {
    Text = "Crit. Rate of \"Strike\" increased by [Layer]% this turn."
  },
  State_47072_Name = {
    Text = "Strike Critical Hit"
  },
  State_47089_Name = {
    Text = "Test Effect__\"For Development Only\""
  },
  State_47096_Desc = {
    Text = "Each time a \"Insight\" card is played, Daffodil gains [StateArg1] Aliemus and [StateArg2] Strength, triggering a maximum of 5 times per turn. (Currently [DescArg1] times remaining)"
  },
  State_47096_Name = {
    Text = "Essence Sedimentation"
  },
  State_47189_Name = {
    Text = "Switch to Manic Persona. Caro: Depression: <EmbryoFusionIconKeywords:Embryo Fusion> +[StateArg5]%, accumulate [StateArg6] Crimson Furnace Healing"
  },
  State_47199_Name = {
    Text = "Switch to Depressed Persona. Caro: Mania: DMG enjoys 5x <PowerIconKeywords:STR> Buff and inflicts <BleedingIconKeywords:Bleed> equal to 200% DMG dealt on the Target. Obtain [StateArg7] <PowerIconKeywords:STR>"
  },
  State_47204_Name = {
    Text = "Switch to Manic Persona. Chaos: Depression: Gain <Posse:[StateArg1]> Keyflare. The next Posse activation will occur 2 times"
  },
  State_47206_Name = {
    Text = "Switch to Manic Persona. Aequor: Depression: Apply <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> to the target for 2 turns, generate 1 Tentacle, <TentacleInjurieIconKeywords:Tentacle DMG> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Switch to Depressed Persona. Ultra: Mania: Obtain 15% of DMG dealt as <RetaliateIconKeywords:Counter>, then deal an equal amount of <RealDamage:Fixed DMG> to other enemies. For each \"Insight\" card played this turn, increase this DMG by [StateArg9] for the remainder of the turn, up to  [StateArg10] ."
  },
  State_47212_Name = {
    Text = "\"24\" switches between Depressed and Manic Personas. Trigger additional effects based on the current Realm and Persona"
  },
  State_47216_Name = {
    Text = "Switch to Depressed Persona. Aequor: Mania: This attack enjoys a [StateArg4]% <TentacleInjurieIconKeywords:Tentacle DMG> bonus. Inflict 30% of the DMG dealt as <IntoxicationIconKeywords:Poison> on all enemies."
  },
  State_47217_Name = {
    Text = "Switch to Depressed Persona. Chaos: Mania: Deal 3 instances of DMG and increase all DMG dealt by \"24\" by [StateArg2]"
  },
  State_47218_Name = {
    Text = "Switch to Manic Persona. Ultra: Depression: Add 2 \"Insight\" cards to hand, temporarily reduce target's [Power:StateArg8] <PowerIconKeywords:STR>"
  },
  State_47451_Name = {
    Text = "Ryker Posse disables Wheel of Destiny effects"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, discard [StateArg1] cards from other Awakeners; if successful, draw [StateArg2] cards."
  },
  State_47517_Name = {
    Text = "Silver Cod's Determination"
  },
  State_47518_Name = {
    Text = "Counter of the Silver Cod's Resolve __ \"For Development Only\""
  },
  State_47528_Desc = {
    Text = "This turn, \"Strike\" deals half DMG to the Awakener behind the target."
  },
  State_47528_Name = {
    Text = "Starbeast's Afterglow"
  },
  State_47530_Desc = {
    Text = "Considered as the last played \"Skill\" this turn."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Echoed Simulation>"
  },
  State_47557_Desc = {
    Text = [[
Team Unique: The wielder enters the Silver Cod persona after exploration begins. Switch between the Silver Cod and Cat personas after using Exalt.
Silver Cod: Gain <WeaponEffect_Num:[StateArg1]> Keyflare after dealing Damage. Cat: Gain a Temporary Crit. DMG increase of <WeaponEffect_Num:+[StateArg2]%> after dealing Damage. These effects share a maximum of 5 triggers per turn.]]
  },
  State_47557_WeaponDesc = {
    Text = [[
After the start of exploration, the wielder enters Silver Cod Persona. After triggering an Exalt, it switches between Silver Cod Persona and Kitty Persona. 
Silver Cod Persona: After dealing Damage, gain <WeaponEffect_Num:[StateArg1]> Keyflare. Kitty Persona: After dealing Damage, the wielder's Temporary Crit. DMG increases by <WeaponEffect_Num:+[StateArg2]%>. These two effects share a maximum trigger limit of 5 times per turn.]]
  },
  State_47822_Desc = {
    Text = "First \"Paralysis\" application each turn adds 1 stack of \"Entirely Paralyzed\" (undispellable). If the target lacks \"Paralysis\" at turn end, remove \"Entirely Paralyzed\". At 2 stacks, consume all \"Entirely Paralyzed\" and convert the target's \"Strike\" cards into \"Illusion\" cards."
  },
  State_47822_Name = {
    Text = "Entirely Paralyzed"
  },
  State_47825_Desc = {
    Text = "At the start of the turn, the corresponding Skill Effect is triggered."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Delay>"
  },
  State_47826_Desc = {
    Text = [[
When applied, it causes equivalent Damage. If the target is under "Paralysis", the DMG is doubled; otherwise, the target cannot use "Strike" until turn end.
When the first "Paralysis" is obtained in each turn, add 1 stack of undispellable "Totally Paralyzed" to the target. If not under "Paralysis" at turn end, remove "Totally Paralyzed". If "Totally Paralyzed" reaches 2 stacks, remove all "Totally Paralyzed" and discard all "Strikes" of the target, granting an equivalent amount of "Illusion".]]
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Paralysis>"
  },
  State_47827_Desc = {
    Text = "Each stack reduces all damage dealt in this battle by 1 point and cannot be dispelled."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:STR▼>"
  },
  State_47828_Desc = {
    Text = "When this status is inflicted on an enemy, deal the same amount of DMG. If the target is already \"Entwined,\" the DMG dealt is doubled. \"Entwined\" disables the target's equipped Wheel of Destiny until turn end."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Entwined>"
  },
  State_47830_Desc = {
    Text = "When applied, dispels Shield and delayed healing on the target. Reduces the effects of healing and Shield received by 50% until turn end"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Blighten>"
  },
  State_47831_Desc = {
    Text = "When Fainted, a target cannot act until the turn ends. Taking Fainting DMG grants Resistance. If Resistance is active, subsequent Fainting DMG is doubled but the Fainting effect is negated."
  },
  State_47831_Name = {
    Text = "<ComaColour:Petrify>"
  },
  State_47832_Desc = {
    Text = "Including Infected Mice, Electric Mice, and Dementia Mice"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Rat Card>"
  },
  State_47833_Desc = {
    Text = "Including the Dove-Embroidered Kerchief, Reverse Split Magic Box, and Telepathy Microphone."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Wondrous Magic>"
  },
  State_47841_Desc = {
    Text = "The next [Layer] uses of Posse in this battle will take effect twice."
  },
  State_47841_Name = {Text = "Dual Posse"},
  State_47842_Desc = {
    Text = "The gained Aliemus and Delayed Aliemus -100%; immediately remove all Delayed Aliemus."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Void>"
  },
  State_47843_Desc = {
    Text = "Revive the Awakener from the death state and place all its cards into the Draw Pile."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Revival>"
  },
  State_47844_Desc = {
    Text = "Generates a random bewildering effect."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Marvelous Effect>"
  },
  State_47845_Desc = {
    Text = "The card generates an effect while in hand."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:In Hand>"
  },
  State_47873_Desc = {
    Text = "At the end of the next turn, deal DMG equal to the number of stacks."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Bleed>"
  },
  State_47887_Name = {
    Text = "Different effects based on the current team's Realm"
  },
  State_47888_Name = {
    Text = "Caro: For every 1 Arithmetica \"24\" consumes, <EmbryoFusionIconKeywords:Embryo Fusion> +5%, \"24\" gains [StateArg3] <PowerIconKeywords:STR>"
  },
  State_47889_Name = {
    Text = "Aequor: The DMG \"24\" deals enjoys a [StateArg2]% <TentacleInjurieIconKeywords:Tentacle DMG> bonus and inflicts <IntoxicationIconKeywords:Poison> equal to 10% of DMG dealt. \"24\"'s Exalt can trigger [StateArg6]% <IntoxicationIconKeywords:Poison> on enemies."
  },
  State_47892_Name = {
    Text = "Chaos: The Crit. Rate and Crit. DMG of \"24\" +[StateArg4]%. Each time a Posse is used, the Exalt DMG of \"24\" +[StateArg1]"
  },
  State_47894_Name = {
    Text = "Ultra: The DMG \"24\" deals enjoys a [StateArg5]% <RetaliateIconKeywords:Counter> bonus. Shuffle 1 \"Insight\" into the Discard Pile at turn end, Hand Limit +2"
  },
  State_48009_Desc = {
    Text = "The first time it is played each turn, it activates [StateArg1] additional times."
  },
  State_48009_Name = {
    Text = "<Rune_19:Ensemble>"
  },
  State_48010_Desc = {
    Text = "Ensemble Mark"
  },
  State_48010_Name = {
    Text = "Ensemble Mark"
  },
  State_48011_Desc = {
    Text = "The first time it is played each turn, it activates [StateArg1] additional times."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Adv. Ensemble>"
  },
  State_48011_WeaponDesc = {
    Text = "After being played, it takes effect an additional [StateArg1] times. Exhaust."
  },
  State_48012_Desc = {
    Text = "Make the card with the Orison activate 2 times the first time it's played each turn"
  },
  State_48012_Name = {
    Text = "<CardKeyWord:Ensemble>"
  },
  State_48013_Desc = {
    Text = "Make the card with the Orison activate 3 times the first time it is played each turn."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:Adv. Ensemble>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Echoed Simulation>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:Birth of a Soul>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Truth Behind Grey Mist>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Starborn Mimic>"
  },
  State_48099_Desc = {
    Text = "At turn end, \"24\" gains [DescArg1] Aliemus. Each time \"24\" triggers an Exalt, the amount of Aliemus gained from this effect increases by 1."
  },
  State_48099_Name = {
    Text = "Pavlovian Conditioning Study"
  },
  State_48099_WeaponDesc = {
    Text = "Gain 3 Aliemus at the end of the wielder's turn. Gain an additional 2 Aliemus if the wielder's Aliemus Regen is greater than 10."
  },
  State_48100_Name = {
    Text = "State@24 Pavlov Behavior Research Count"
  },
  State_48100_WeaponDesc = {
    Text = "Gain 3 Aliemus at the end of the wielder's turn. Gain an additional 2 Aliemus if the wielder's Aliemus Regen is greater than 10."
  },
  State_48107_Desc = {
    Text = "Damage increases by [StateArg1]% if the first card played each turn is one of your own cards."
  },
  State_48107_Name = {
    Text = "Blade of the Titan"
  },
  State_48108_Desc = {
    Text = "After the wielder plays a \"Skill\" for the first time each turn, they will shuffle a copy of their Arithmetica Cost - [StateArg1] into the Draw Pile."
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48109_Desc = {
    Text = "Each turn, the Arithmetica Cost of the first \"Skill\" played is - [StateArg1]."
  },
  State_48109_Name = {Text = "Epiphany"},
  State_48110_Desc = {
    Text = "\"Skill\" causes the next \"Strike\" this turn to target a random enemy and additionally attack [StateArg1] more random targets."
  },
  State_48110_Name = {
    Text = "Man in the Mirror"
  },
  State_48140_Desc = {
    Text = [[
At the start of the exploration, "24" enters Depressed Persona state.
<School_1:Chaos: Depressed>: Gain <Posse:[StateArg1]> Keyflare. Next Posse takes effect 2 times.
<School_1:Chaos: Manic>: Inflict DMG 3 times, increasing all DMG dealt by "24" by [StateArg2].
<School_2:Aequor: Depressed>: Inflict <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on targets for 2 turns, generating 1 Tentacle with <TentacleInjurieIconKeywords:Tentacle DMG> + [StateArg3].
<School_2:Aequor: Manic>: This instance of DMG enjoys [StateArg4]% <TentacleInjurieIconKeywords:Tentacle DMG> bonus and inflicts <IntoxicationIconKeywords:Poison> for 30% of DMG to all enemies.
<School_3:Caro: Depressed>: <EmbryoFusionIconKeywords:Embryo Fusion> + [StateArg5]%, accumulating [StateArg6] Crimson Furnace Healing.
<School_3:Caro: Manic>: DMG enjoys a 5x <PowerIconKeywords:STR> bonus and inflicts <BleedingIconKeywords:Bleed> for 200% of DMG on the target, gaining [StateArg7] <PowerIconKeywords:STR>.
<School_4:Ultra: Depressed>: Add 2 "Insight" cards to hand, temporarily reducing the target's <PowerIconKeywords:STR> by [StateArg8].
<School_4:Ultra: Manic>: Gain <RetaliateIconKeywords:Counter> equal to 15% of DMG dealt, then inflict the same amount of <RealDamage:Fixed DMG> on other enemies. For each "Insight" played this turn, increase that DMG by [StateArg9], up to [StateArg10].]]
  },
  State_48140_Name = {
    Text = "Realm and Persona Effects"
  },
  State_48141_Desc = {
    Text = [[
<School_1:Chaos>: The Crit. Rate and Crit. DMG of "24" +[StateArg4]%. Each time a Posse is used, the Exalt DMG of "24" +[StateArg1].
<School_2:Aequor>: The DMG "24" deals enjoys a [StateArg2]% <TentacleInjurieIconKeywords:Tentacle DMG> bonus and inflicts <IntoxicationIconKeywords:Poison> equal to 10% of DMG dealt. "24"'s Exalt can trigger 50% <IntoxicationIconKeywords:Poison> on enemies.
<School_3:Caro>: For every 1 Arithmetica "24" consumes, <EmbryoFusionIconKeywords:Embryo Fusion> +5%, "24" gains [StateArg3] <PowerIconKeywords:STR>.
<School_4:Ultra>: The DMG "24" deals enjoys a [StateArg5]% <RetaliateIconKeywords:Counter> DMG Bonus. Shuffle 1 "Insight" into the Discard Pile at turn end, Hand Limit +2.]]
  },
  State_48141_Name = {
    Text = "Realm Effect"
  },
  State_48149_Name = {
    Text = "Card Special Effect Not Available"
  },
  State_48176_Desc = {
    Text = "In this trial, gain 1 Arithmetica each turn; \"24\"for every 1 Arithmetica consumed, gain 30  Keyflare."
  },
  State_48176_Name = {Text = "\"24\" Trial"},
  State_48198_Desc = {
    Text = "In this trial, gain 1 \"Insight\" each turn."
  },
  State_48198_Name = {Text = "\"24\" Trial"},
  State_48199_Desc = {
    Text = "Gain 1 Arithmetica each turn in this demo."
  },
  State_48199_Name = {Text = "\"24\" Trial"},
  State_48247_Desc = {
    Text = "Deals a fixed amount of DMG, unaffected by states such as Strength, Weakness, or Vulnerability."
  },
  State_48247_Name = {
    Text = "<RealDamage:Fixed DMG>"
  },
  State_48589_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, with Max HP +200%, and fight with full power."
  },
  State_48589_Name = {Text = "Not Roused"},
  State_48607_Name = {
    Text = "Reduce the Original Arithmetica of Generic Cards"
  },
  State_48822_Desc = {
    Text = "At the start of turns in the Caro Realm, Embryo Fusion gain increases by 50%."
  },
  State_48822_Name = {
    Text = "Everlasting Cycle"
  },
  State_48923_Desc = {
    Text = "Shadow \"24\" has been Roused. Use the final \"Save Me\" to find your chance!"
  },
  State_48923_Name = {
    Text = "Shadow \"24\" Rouse!"
  },
  State_48923_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_49063_Desc = {
    Text = "Lotan's \"Strike\" DMG increased by 30%."
  },
  State_49063_Name = {
    Text = "Surging Warlust"
  },
  State_49109_Desc = {
    Text = "Cards gain the Retain effect. At turn end, if this card is in hand, gain an original copy of the Command Card with Exhaust."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Birth>"
  },
  State_49109_WeaponDesc = {
    Text = "After being played, it takes effect an additional [StateArg1] times. Exhaust."
  },
  State_49148_Desc = {
    Text = "Upon death, attach \"Mutation 1\" to a card with non-zero Arithmetica Cost. Mutation: Remains after the battle ends. Each stack reduces Arithmetica Cost by 1, but after playing each stack will add 1 random Mutation to your hand (ignoring hand limit), removing all Mutation."
  },
  State_49148_Name = {
    Text = "Aberrant Spawn"
  },
  State_49149_Desc = {
    Text = "Each stack reduces the Arithmetica Cost of cards by 1. After being played, for each stack of Mutation, add a random Distortion card to your hand and remove this state. This state persists after battle."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Mutation [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Permanently remove it after use."
  },
  State_49207_Name = {
    Text = "Gain 100 Keyflare"
  },
  State_49225_Desc = {
    Text = "At turn end, make 1 Tentacle attack [Layer] times."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentacle Gathering>"
  },
  State_49226_Desc = {
    Text = "At turn end, for each card in hand, inflict 3% Poison on all enemies and gain 3 Aliemus."
  },
  State_49226_Name = {
    Text = "Dimmed candle"
  },
  State_49260_Desc = {
    Text = "Restores HP equal to 7.5% of CON at turn end."
  },
  State_49260_Name = {
    Text = "Outcast's Anguish"
  },
  State_49270_Desc = {
    Text = "\"Strike\" DMG increased by [Layer]%."
  },
  State_49270_Name = {
    Text = "Damage of Strike Cards increased"
  },
  State_49270_WeaponDesc = {
    Text = "Strike card DMG increased by [Layer]%."
  },
  State_49278_Desc = {
    Text = "At turn end, restore HP equal to 5% of lost HP. If HP is below 50% ([StateArg1]), gain [StateArg2] Strength."
  },
  State_49278_Name = {
    Text = "Crimson Altar"
  },
  State_49430_Desc = {
    Text = "Damage taken -1% per stack. State clears when allies die."
  },
  State_49430_Name = {
    Text = "<AberrationColour:Conceal>"
  },
  State_49500_Desc = {
    Text = "Each stack increases the attack count by 1. Lose 1 stack upon taking DMG, and lose all stacks at the end of turn."
  },
  State_49500_Name = {Text = "Prayer"},
  State_49524_Desc = {
    Text = "At turn end, restore HP equal to 5% of the lost HP. Each time you draws a State Card or Symptom Card, all \"Nubia\" gain [StateArg1] Temporary STR."
  },
  State_49524_Name = {
    Text = "Crimson Gospel"
  },
  State_49526_Desc = {
    Text = "Upon death, restores [StateArg2] HP and becomes immune to DMG for 1 turn, adjusting Intention to \"Corruption Spread\"."
  },
  State_49526_Name = {Text = "Sow"},
  State_49542_Desc = {
    Text = "Team Unique: After the battle starts, gain STR equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's ATK. If the current realm is \"Aequor\", also increase Tentacle DMG by <WeaponEffect_Num:[StateArg2]%> of the wielder's ATK."
  },
  State_49542_WeaponDesc = {
    Text = "At the start of the battle, gain <WeaponEffect_Num:[Power:DescArg1]> Strength; if the current Realm is \"Aequor,\" also gain <WeaponEffect_Num:[DescArg2]> Tentacle DMG."
  },
  State_49546_Desc = {
    Text = "Always appears with 2 elite guards. They will die when it dies."
  },
  State_49546_Name = {Text = "Formation"},
  State_49547_Desc = {
    Text = "Upon death, Aram Guard Captain gains [StateArg1] Strength and a Shield equal to 50% of Max HP."
  },
  State_49547_Name = {Text = "Loyalty"},
  State_49558_Desc = {
    Text = "Increase Strength by [StateArg1] each turn."
  },
  State_49558_Name = {
    Text = "Blessing of the Sands"
  },
  State_49582_Desc = {
    Text = "Shield remaining at the end of each turn in this battle will not be removed and will remain intact."
  },
  State_49582_Name = {
    Text = "Permanent Shield Retain"
  },
  State_49583_Desc = {
    Text = "At turn end, gain [StateArg1] Shield, boosted by Alert"
  },
  State_49583_Name = {
    Text = "Aram's Shield"
  },
  State_49595_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_49595_Name = {Text = "Not Roused"},
  State_49596_Desc = {
    Text = "\"Blade of Utopia\" has been Roused. She will gain more Shield and Strength."
  },
  State_49596_Name = {
    Text = "Alva Rouse!"
  },
  State_49596_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_49597_Name = {
    Text = "Already Paralyzed This Turn"
  },
  State_49600_Desc = {
    Text = "Apply Weakness to all enemies for 2 turns."
  },
  State_49600_Name = {
    Text = "Blood of Fear"
  },
  State_49601_Desc = {
    Text = "Make all enemies Vulnerable for 2 turns."
  },
  State_49601_Name = {
    Text = "Blood of Decay"
  },
  State_49602_Desc = {
    Text = "Make all enemies vulnerable for 1 turn."
  },
  State_49602_Name = {
    Text = "Blood of Decay"
  },
  State_49603_Desc = {
    Text = "Embryo Fusion +40%."
  },
  State_49603_Name = {
    Text = "Blood of Coition"
  },
  State_49604_Desc = {
    Text = "Embryo Fusion +20%."
  },
  State_49604_Name = {
    Text = "Blood of Coition"
  },
  State_49605_Desc = {
    Text = "Apply Weakness to all enemies for 1 turn."
  },
  State_49605_Name = {
    Text = "Blood of Fear"
  },
  State_49623_Desc = {
    Text = "HP recovery reduced by [DescArg1]%. Removes 1 stack at turn end."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Blighten>"
  },
  State_49623_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_49627_Desc = {
    Text = "Initially has 2 stacks of <ParcloseIconKeywords:Barrier>. Upon death, all \"Nubia\" gain [StateArg1] Strength."
  },
  State_49627_Name = {
    Text = "Blood Surge"
  },
  State_49628_Desc = {
    Text = "Upon death, all \"Nubia\" gain [StateArg1] Strength."
  },
  State_49628_Name = {
    Text = "Bloodline Link"
  },
  State_49638_Desc = {
    Text = "Identify whether it is a monster status of the Black Goat series."
  },
  State_49833_Desc = {
    Text = "At turn end, apply 1 turn of \"Blindness\" state to all enemies. When own Shield is broken, remove the \"Blindness\" state."
  },
  State_49833_Name = {
    Text = "Dust Barrier"
  },
  State_49844_Desc = {
    Text = "Team Unique: Gain <WeaponEffect_Num:[StateArg1]> Keyflare at turn end. Gain <WeaponEffect_Num:[StateArg2]> Keyflare after triggering Death Resistance. Using Emergency Gnosis increases Arithmetica cap by 3 and allows you to draw 3 cards per turn."
  },
  State_49844_WeaponDesc = {
    Text = "Gain <WeaponEffect_Num:[StateArg1]> Keyflare at turn end. Gain <WeaponEffect_Num:[StateArg2]> Keyflare after triggering Death Resistance. Using Emergency Gnosis increases the Arithmetica limit by 3 and allows you to draw 3 more cards per turn."
  },
  State_49877_Desc = {
    Text = "Reduce this card's Arithmetica Cost. After playing, add 1 random Mutation Card per Mutation stack and remove state. State persists post-battle."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Mutation>"
  },
  State_49877_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_49954_Desc = {
    Text = "All Awakener Crit DMG is halved."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords:Blind>"
  },
  State_49954_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_49957_Desc = {
    Text = "When attacked, seal Awakener's Exalt and Command Cards for 1 turn, remove 1 Chains of Resentment stack. Clear at turn end."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Chains of Resentment>"
  },
  State_49957_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_49958_Desc = {
    Text = "When attacked, seals the Awakener's Exalt and all Command Cards for 1 turn, removing 1 stack of Chains of Resentment. Clears at the end of the opponent's turn."
  },
  State_49958_Name = {
    Text = "<ExclamationPointColour:Chains of Resentment>"
  },
  State_49959_Desc = {
    Text = "At turn start, gain 1 stack of <ResentChainsKeywords:Chains of Resentment>."
  },
  State_49959_Name = {
    Text = "Multidimensional Lock"
  },
  State_50010_Desc = {
    Text = "Healing received -25%. Remove 1 stack at turn end."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Blighten>"
  },
  State_50021_Desc = {
    Text = "Team Unique: After the wielder releases Exalt, they gain Strength equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's ATK. If the current Realm is \"Caro\", after releasing Exalt, Embryo Fusion increases by <WeaponEffect_Num:+[StateArg2]%>."
  },
  State_50021_WeaponDesc = {
    Text = "After the wielder releases Exalt, they gain <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:STR>. If the current Realm is \"Blood\", after releasing Exalt, Embryo Fusion increases by <WeaponEffect_Num:+[StateArg2]%>."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Resist 1 death and destroy this \"Wheel of Destiny\", gain [StateArg1] stacks of <PVPProtectiveKeywords:Barrier>. If the wielder is the only surviving ally when it takes effect, gain [StateArg2] random \"Posse\" at the start of next turn."
  },
  State_50302_Name = {
    Text = "Dusk and Dawn"
  },
  State_50323_Desc = {
    Text = "Before the start of next turn, gain [Layer] random Posse cards."
  },
  State_50323_Name = {
    Text = "Delay Posse"
  },
  State_50333_Desc = {
    Text = "At turn end, all Awakeners lose Aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:Void>"
  },
  State_50333_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_50352_Name = {
    Text = "Thais Trial"
  },
  State_50353_Name = {
    Text = "Thais Trial"
  },
  State_50358_Desc = {
    Text = "Damage taken -1% per stack. State clears when allies die."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:Conceal>"
  },
  State_50375_Desc = {
    Text = "These effects include: self gains 10 Aliemus, other allies gain 5 Aliemus, apply 1 stack of Vulnerable to all enemies, apply 1 stack of Weakness to all enemies, draw 1 card, gain 200 Keyflare."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Marveous Effect>"
  },
  State_50389_Desc = {
    Text = "At turn start, place a \"Ryker's Lucky Dice\" into hand."
  },
  State_50389_Name = {
    Text = "Ryker's Support"
  },
  State_50390_Desc = {
    Text = "At turn start, gain [StateArg1] Strength."
  },
  State_50390_Name = {
    Text = "Outstanding Veteran"
  },
  State_50735_Desc = {
    Text = "When about to be defeated for the first time, recover HP and change intention to \"Rending Lament\", dealing extremely high single-target Damage."
  },
  State_50735_Name = {
    Text = "Futile Resolve"
  },
  State_50854_Desc = {
    Text = "At the start of battle, gain [StateArg1] <RetaliateIconKeywords:Counter>. After your turn, gain [StateArg2] shield, this Shield Generations by [StateArg3] each turn."
  },
  State_50854_Name = {
    Text = "Sturdy Bark"
  },
  State_50861_Desc = {
    Text = "No longer taking Damage, preparing to release \"Mother of Million Offsprings\"."
  },
  State_50861_Name = {Text = "Derived"},
  State_50862_Desc = {
    Text = "No longer taking Damage, preparing to release \"Breeding\"."
  },
  State_50862_Name = {Text = "Hatch"},
  State_50863_Desc = {
    Text = "No longer taking Damage, preparing to release \"Wild Tree Sap\"."
  },
  State_50863_Name = {Text = "Immune"},
  State_50864_Desc = {
    Text = "No longer taking Damage, preparing to release \"Tree Resin\"."
  },
  State_50864_Name = {Text = "Immune"},
  State_50891_Desc = {
    Text = "No longer taking Damage, preparing to release \"Multi-Fusion\"."
  },
  State_50891_Name = {Text = "Devour"},
  State_51016_Desc = {
    Text = "The received Poison effect increases to 1000%."
  },
  State_51016_Name = {
    Text = "Withered and Decayed"
  },
  State_51017_Desc = {
    Text = "The received Poison Effect becomes 500%."
  },
  State_51017_Name = {
    Text = "Withered and Decayed"
  },
  State_51607_Desc = {
    Text = "Immune to all Damage. Removed at turn start."
  },
  State_51607_Name = {
    Text = "Immune to Damage"
  },
  State_51695_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_51695_Name = {Text = "Not Roused"},
  State_51696_Desc = {
    Text = "\"Apostle of the Sea\" has been Roused, with stronger resistance to Exalt."
  },
  State_51696_Name = {
    Text = "Miryam Rouse!"
  },
  State_51696_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_51739_Desc = {
    Text = "At turn end, randomly gain 1 \"Divine Realm's Illusion\". Cannot be dispelled."
  },
  State_51739_Name = {
    Text = "The End of Belief"
  },
  State_51740_Desc = {
    Text = "At the start of the battle, place 1 \"Obsession\" into hand."
  },
  State_51740_Name = {
    Text = "Undying Piety"
  },
  State_51741_Desc = {
    Text = "Gain [Layer] Shield at turn start. Cannot be dispelled."
  },
  State_51741_Name = {
    Text = "Iron Resolve"
  },
  State_51742_Desc = {
    Text = "Gain [Layer] Tentacle DMG and Strength at turn start. Cannot be dispelled."
  },
  State_51742_Name = {
    Text = "Revelate Devotion"
  },
  State_51743_Desc = {
    Text = "This turn, each time the Tentacle attacks, it gains the following effects based on the Tentacle Stance: Surging Tides: All Awakener obtain <Energy:[Energy:StateArg1]> Aliemus; Tranquil Sea: Inflict [StateArg2] <IntoxicationIconKeywords:Poison> to all enemies; Raging Waves: Temporary <TentacleInjurieIconKeywords:Tentacle DMG> +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Deipara's Blessing"
  },
  State_51745_Desc = {
    Text = "When the Apostle of the Sea plays a card, it generates [StateArg1] Temporary Tentacles that ignore the Tentacle Limit."
  },
  State_51745_Name = {
    Text = "Divine Proxy"
  },
  State_51745_WeaponDesc = {
    Text = "When the Apostle of the Sea plays 1 card, it generates [StateArg1] temporary Tentacles that ignore the Tentacle limit."
  },
  State_51811_Name = {
    Text = "Healing Effect of the Guiding Sail"
  },
  State_51813_Desc = {
    Text = "At turn end, Arithmetica Cost -[Layer], This effect triggers even if discarded."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:Prepare>"
  },
  State_51820_Desc = {
    Text = "\"Birth\" gains an additional effect: At 5 stacks, instantly summon 1 \"Child of Water\", up to 2 \"Child of Water\"."
  },
  State_51820_Name = {
    Text = "Miryam Awaken"
  },
  State_51822_Desc = {
    Text = "Each time you release Exalt, gain 1 stack of \"Gestation\". For each stack of Gestation, gain [StateArg1] Strength, up to 5 stacks."
  },
  State_51822_Name = {
    Text = "Lemuria's Final Descent"
  },
  State_52068_Desc = {
    Text = "Convert up to 3 \"Sacrament\" in hand into \"Obsession\", gaining different additional effects based on the number of conversions."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Ritual>"
  },
  State_52087_Desc = {
    Text = "\"Undying Bird of Paradise\" can only apply the revival state again after [Layer] turns"
  },
  State_52087_Name = {
    Text = "Revival Cooldown"
  },
  State_52116_Desc = {
    Text = "Before turn end, this Awakener takes [Layer] DMG for each use of Exalt."
  },
  State_52116_Name = {Text = "Exalt Lock"},
  State_52369_Desc = {
    Text = "After playing [DescArg1] Symptom Cards, gain the support card \"Royal Authority\" from Tulu: deal massive DMG and cause the target to faint for 1 turn."
  },
  State_52369_Name = {
    Text = "Divine Return"
  },
  State_53115_Desc = {
    Text = "This turn, the next triggered \"Ritual\" effect of Miryam +50%."
  },
  State_53115_Name = {
    Text = "Pray to the Abyss"
  },
  State_53144_Desc = {
    Text = "Gain <Block:[Block:StateArg1]> Shield at turn start."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Iron Resolve>"
  },
  State_53145_Desc = {
    Text = "At turn start, <PowerIconKeywords:STR> and <TentacleInjurieIconKeywords:Tentacle DMG>+[StateArg2]."
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Revelate Devotion>"
  },
  State_53673_Desc = {
    Text = "You can hold up to 10 Gland Division."
  },
  State_53673_Name = {
    Text = "Gland Division Limit"
  },
  State_53674_Desc = {
    Text = "Hand Limit +2. At turn start, Miryam gains 20 Aliemus."
  },
  State_53674_Name = {
    Text = "Miryam Trial"
  },
  State_53690_Desc = {
    Text = "Idle Effect"
  },
  State_53690_Name = {
    Text = "Idle Effect"
  },
  State_53691_Desc = {
    Text = "Idle Effect"
  },
  State_53691_Name = {
    Text = "Idle Effect"
  },
  State_53692_Desc = {
    Text = "Idle Effect"
  },
  State_53692_Name = {
    Text = "Idle Effect"
  },
  State_53755_Desc = {
    Text = "All Awakener's <PowerIconKeywords:STR> gained, <RetaliateIconKeywords:Counter> gained, and <IntoxicationIconKeywords:Poison> applied increased by +[DescArg1]%. Increase the <PowerIconKeywords:STR> gained by \"Resplendent Chapters\"."
  },
  State_53755_Name = {Text = "Fear"},
  State_53756_Desc = {
    Text = "All Awakeners' Aliemus gained is increased by [DescArg1]%. All Command Cards gain Retain. Unused Arithmetica is retained. Increase the Aliemus granted by \"Resplendent Chapters\"."
  },
  State_53756_Name = {Text = "Happiness"},
  State_53758_Desc = {
    Text = "All Awakeners' final DMG increases by [DescArg1]%. Increase the Crit. Rate and Crit. DMG gained by \"Resplendent Chapters\"."
  },
  State_53758_Name = {Text = "Anger"},
  State_53759_Desc = {
    Text = "All Awakeners' Shield gain and HP Recovery effects, as well as the <PowerIconKeywords:STR> reduction effect applied, are increased by [DescArg1]%. Increase the HP Recovery of \"Resplendent Chapters\"."
  },
  State_53759_Name = {Text = "Grief"},
  State_53772_Name = {
    Text = "Accessory Paradox"
  },
  State_53772_WeaponDesc = {
    Text = "After the wielder uses Exalt, allies gain <RetaliateIconKeywords:Counter> based on 100% of the wielder's DEF. It also increases the wielder's current <RetaliateIconKeywords:Counter> by 10%."
  },
  State_53870_Name = {
    Text = "Accessory: Ring of Room 36"
  },
  State_53870_WeaponDesc = {
    Text = "When the wielder's card is drawn, its Arithmetica randomly changes between 0 and 3."
  },
  State_53981_Name = {
    Text = "Accessory: Adjustment of the Black Sigil in the Dream of Pharmaceuticals"
  },
  State_53981_WeaponDesc = {
    Text = "At the start of the battle, shuffle an additional set of the wielder's cards into the Draw Pile."
  },
  State_54002_Name = {
    Text = "State@Accessory Dream Filter Mark"
  },
  State_54002_WeaponDesc = {
    Text = "After the wielder uses Exalt, allies gain <RetaliateIconKeywords:Counter> based on 100% of the wielder's DEF. It also increases the wielder's current <RetaliateIconKeywords:Counter> by 10%."
  },
  State_54011_Name = {
    Text = "State@Accessory Dream Copy 1 Available"
  },
  State_54011_WeaponDesc = {
    Text = "After the wielder uses Exalt, allies gain <RetaliateIconKeywords:Counter> based on 100% of the wielder's DEF. It also increases the wielder's current <RetaliateIconKeywords:Counter> by 10%."
  },
  State_54012_Name = {
    Text = "State@Accessory Dream Copy 2 Available"
  },
  State_54012_WeaponDesc = {
    Text = "After the wielder uses Exalt, allies gain <RetaliateIconKeywords:Counter> based on 100% of the wielder's DEF. It also increases the wielder's current <RetaliateIconKeywords:Counter> by 10%."
  },
  State_54013_Desc = {
    Text = "This turn, Realm Mastery increases by [Layer]."
  },
  State_54013_Name = {
    Text = "Temporary Realm Mastery"
  },
  State_54014_Desc = {
    Text = "Realm Mastery increased by [Layer]."
  },
  State_54014_Name = {
    Text = "Realm Mastery"
  },
  State_54043_WeaponDesc = {
    Text = "After the wielder uses Exalt, their Shield and Healing Amp. are doubled this turn."
  },
  State_54044_Desc = {
    Text = "Deal double DMG and gain 3 times the Keyflare, but <DepleteIconKeywords:Exhaust> after playing."
  },
  State_54044_Name = {
    Text = "Ode to Tomorrow"
  },
  State_54045_Desc = {
    Text = "Obtain 3 Arithmetica."
  },
  State_54045_Name = {
    Text = "Rebirth Tribunal"
  },
  State_54046_Desc = {
    Text = "At turn start, restore [StateArg1] HP for [Layer] turns."
  },
  State_54046_Name = {
    Text = "Rationality, Truth, and Reality"
  },
  State_54071_Desc = {
    Text = "Ogier's attack count increases by 1, lasting [Layer] turns."
  },
  State_54071_Name = {
    Text = "Seven Arts, Eight Virtues"
  },
  State_54121_Desc = {
    Text = "The Base DMG dealt by \"Beast of Chaos\" increases by [Layer]% in this battle."
  },
  State_54121_Name = {
    Text = "Beast of chaos"
  },
  State_54138_Desc = {
    Text = "Sorel's Command Card played in [Layer] takes effect twice."
  },
  State_54138_Name = {
    Text = "Carousel of Ambition"
  },
  State_54384_Desc = {
    Text = "Make Nymphaea's <IntoxicationIconKeywords:Poison> effect increase by 50%, lasting for [Layer] turns."
  },
  State_54384_Name = {
    Text = "Passage of the Ego"
  },
  State_54416_Desc = {
    Text = "Once Over-Exaltation is unlocked, the Aliemus gauge can be filled twice. Reaching a second full charge upgrades the skill to Over-Exaltation, adding powerful bonus effects. Unleashing a regular Exalt instead will consume 50% of any surplus Aliemus."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:Over-Exaltation>"
  },
  State_54416_WeaponDesc = {
    Text = "Exhaust embryos in hand, triggering a powerful Devouring effect."
  },
  State_54462_Desc = {
    Text = "Arithmetica Cost varies randomly between 1-3. The state is removed after use."
  },
  State_54462_Name = {
    Text = "<ExclamationPointColour:Paint>"
  },
  State_54561_Desc = {
    Text = "Team Unique: Increases the DMG dealt by the wielder by <WeaponEffect_Num:[StateArg1]%> of their Attack. If the current Realm is \"Caro\", each time the Devouring Effect is triggered, it further increases the DMG dealt by the wielder by 3% of their Attack."
  },
  State_54561_WeaponDesc = {
    Text = "The DMG dealt by the wielder is increased by [DescArg1] points. If the current realm is \"Caro\", each time the devouring effect is triggered, the DMG dealt by the wielder is further increased by [DescArg2] points."
  },
  State_54575_Desc = {
    Text = "All card text appears as Dissolution text, Arithmetica Cost randomly changes between 1-3. Removed after play"
  },
  State_54575_Name = {
    Text = "<ExclamationPointColour:Dissoluted Paint>"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After an enemy Awakener dies, gain [StateArg1] <StrongEffectKeywords:Amplification> and draw their highest-cost \"Skill\" card."
  },
  State_54597_Name = {
    Text = "Million Loving Gaze"
  },
  State_54603_Desc = {
    Text = "Painted cards' Arithmetica Cost randomly varies (1–3). State clears once the card is played."
  },
  State_54603_Name = {
    Text = "<ColorInkKeywords:Paint>"
  },
  State_54604_Desc = {
    Text = "Dissoluted Paint makes Arithmetica Cost fluctuate (1–3) and obscures card text. State clears once the card is played."
  },
  State_54604_Name = {
    Text = "<ErosionColorInkKeywords:Dissoluted Paint>"
  },
  State_54704_Desc = {
    Text = "The next Command Card of '24' takes effect 3 times."
  },
  State_54704_Name = {
    Text = "Twisted Carrion Revel"
  },
  State_54798_Desc = {
    Text = "All Awakeners' Shield Generated, HP Recovery, and <PowerIconKeywords:STR> Reduction effect +[StateArg1]%. Increase the HP Recovery of Resplendent Chapters."
  },
  State_54798_Name = {Text = "\"Grief\""},
  State_54799_Desc = {
    Text = "All Awakeners' STR gained, Counter gained, and Poison inflicted +[StateArg1]%. Increase the STR Generation of Resplendent Chapters."
  },
  State_54799_Name = {Text = "\"Fear\""},
  State_54800_Desc = {
    Text = "The Final DMG dealt by all Awakeners is increased by [StateArg1]%. Increase the temporary Crit. Rate and Crit. DMG gained by Resplendent Chapters."
  },
  State_54800_Name = {Text = "\"Anger\""},
  State_55108_Desc = {
    Text = "At turn start, upgrade \"Green Flames\" or \"Corrupted Flames\" in hand to \"Deadly Flames\", lasting [Layer] turns."
  },
  State_55108_Name = {
    Text = "Omen's Descent"
  },
  State_55108_WeaponDesc = {
    Text = "Enhanced if in hand or in Ultra Space at turn start."
  },
  State_55113_Desc = {
    Text = "Horla gains 10 Aliemus after playing the first Psalm card each turn."
  },
  State_55113_Name = {
    Text = "Blossoms and Verses Reunited"
  },
  State_55465_Name = {
    Text = "Consume [Layer] stacks of Metaphor \"Anger\", dealing an additional [DescArg1] instance of DMG"
  },
  State_55466_Name = {
    Text = "Consume [Layer] stacks of Metaphor \"Grief\", restoring <Heal:[Heal:DescArg1]> HP"
  },
  State_55467_Name = {
    Text = "Consume [Layer] stack of metaphor \"Fear\", gain additional [Power:DescArg1] <PowerIconKeywords:STR>"
  },
  State_55469_Name = {
    Text = "Consume [Layer] stacks of the Metaphor \"Happiness\" to grant an additional <Energy:[Energy:DescArg1]> Aliemus"
  },
  State_55470_Name = {
    Text = "Skull Reaver"
  },
  State_55485_Desc = {
    Text = "The next [Layer] cards played by Casiah gain her strength equal to  8% of her ATK."
  },
  State_55485_Name = {
    Text = "Merry Laughter"
  },
  State_55486_Name = {
    Text = "The Over-Exaltation of the City of Dead Dreams exempts Dreamlure consumption."
  },
  State_55487_Desc = {
    Text = "Erica's \"Strike\" additionally deals 2 instances of DMG, and \"Defense\" gains an extra 2 instances of Shield, lasting [Layer] turns."
  },
  State_55487_Name = {
    Text = "Multiple Calculations"
  },
  State_55489_Name = {
    Text = "Space-Time Fold"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Offering>: Grant all enemies a negative <PVPWonderfulEffectKeywords:Marvelous Effect> or grant all allies a positive<PVPWonderfulEffectKeywords:Marvelous Effect> or draw 1 card and gain 1 Arithmetica. The last Offering takes effect 2 times"
  },
  State_55807_Name = {
    Text = "Draw 1 card, gain 1 Arithmetica"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Offering>: Grant all allies a positive <PVPWonderfulEffectKeywords:Marvelous Effect> or draw 1 card and gain 1 Arithmetica. The last Offering takes effect 2 times"
  },
  State_55809_Name = {
    Text = "Apply negative <PVPWonderfulEffectKeywords:Marvelous Effect> to all enemies"
  },
  State_55811_Desc = {
    Text = "Choose one option from the listed ones to take effect."
  },
  State_55811_Name = {
    Text = "<ComaColour:Choice>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Offering>: Give all enemies a negative <PVPWonderfulEffectKeywords:Marvelous Effect> or draw 1 card and gain 1 Arithmetica. The last Offering takes effect 2 times"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Offering>: Grant all enemies a negative <PVPWonderfulEffectKeywords:Marvelous Effect> or grant all allies a positive<PVPWonderfulEffectKeywords:Marvelous Effect>. The last Offering takes effect 2 times"
  },
  State_55816_Name = {
    Text = "Apply positive <PVPWonderfulEffectKeywords:Marvelous Effect> to all allies"
  },
  State_55824_Desc = {
    Text = "Choose one option from the listed ones. After selection, remove the chosen option. If any options remain, place this card into the opponent's hand."
  },
  State_55824_Name = {
    Text = "<ComaColour:Offering>"
  },
  State_55836_Desc = {
    Text = "At turn end, reduce the Arithmetica Cost of Horla's Command Cards in hand by 1."
  },
  State_55836_Name = {
    Text = "Ink-Stained Sonnet"
  },
  State_55839_Desc = {
    Text = "Lose all other relics upon pickup. Randomly gain 2 Golden Relics."
  },
  State_55866_Desc = {
    Text = "Team Unique: At the start of battle, draw 1 Command Card of the wielder and have a <WeaponEffect_Num:[StateArg1]%> chance to reduce its Arithmetica Cost by 1. Each time Resistance is triggered, this effect is repeated once."
  },
  State_55866_WeaponDesc = {
    Text = "At the start of battle, draw 1 Command Card of the wielder and have a <WeaponEffect_Num:[StateArg1]%> chance to reduce its Arithmetica Cost by 1. Each time Death Resistance is triggered, this effect is triggered again."
  },
  State_55992_Desc = {
    Text = "When Arithmetica is insufficient, cards will be marked and exhausted."
  },
  State_55992_Name = {Text = "Ashes"},
  State_55993_Name = {Text = "Ember Mark"},
  State_56018_Desc = {
    Text = "Max HP increases by [Layer]% in this battle."
  },
  State_56018_Name = {
    Text = "Muzus Blessing: Life"
  },
  State_56020_Desc = {
    Text = "In this battle, DMG is increased by [Layer]%."
  },
  State_56020_Name = {
    Text = "Muzus Blessing: Strength"
  },
  State_56030_Desc = {
    Text = "This turn, the Shield and Healing provided by Awakeners +[Layer]%."
  },
  State_56030_Name = {Text = "Snow"},
  State_56031_Desc = {
    Text = "For each instance of DMG dealt this turn, Temporary Crit. Rate +[Layer]%."
  },
  State_56031_Name = {Text = "Butterfly"},
  State_56034_Desc = {
    Text = [[
Each type of "Metaphor" can have a maximum of 3 stacks. Different "Metaphors" will enhance different effects of the Psalms: 
<D06CardKeyWordnu:Snarl Psalm>: Consumes all "Anger" Metaphors, each stack of Metaphor deals an additional 2 instances of DMG. 
<D06CardKeyWordai:Elegy Psalm>: Consumes all "Grief" Metaphors, each stack of Metaphor provides additional HP Recovery. 
<D06CardKeyWordxi:Carol Psalm>: Consumes all "Happiness" Metaphors, each stack of Metaphor grants an additional 10 Aliemus. 
<D06CardKeyWordju:Dirge Psalm>: Consumes all "Fear" Metaphors, each stack of Metaphor grants an additional <PowerIconKeywords:STR>.]]
  },
  State_56034_Name = {Text = "Metaphor"},
  State_56208_Desc = {
    Text = [[
Rain's Dirge: Restore <Heal:[DescArg1]> HP.
Wind's Psalm: Obtain [DescArg2] <PowerIconKeywords:STR>.
Floral Hymn: All Awakeners gain 10 Aliemus.
Moon's Anthem: Temporary Crit. Rate increased by 30%.]]
  },
  State_56208_Name = {
    Text = "Poetry Page"
  },
  State_56330_Desc = {
    Text = "Gain [DescArg1] Shield. If 3 Exalt actions have been performed this turn, this card will activate 1 additional time."
  },
  State_56330_Name = {
    Text = "Advanced Imagery"
  },
  State_56331_Desc = {
    Text = "Choose 1 Command Card from the Draw Pile or Discard Pile and add it to your hand, then reduce its Arithmetica Cost by 2."
  },
  State_56331_Name = {
    Text = "Advanced Imagery"
  },
  State_56332_Desc = {
    Text = "Obtain [DescArg1] Temporary <PowerIconKeywords:STR>. After being played, for each DMG dealt this turn, Temporary Crit. Rate +3%."
  },
  State_56332_Name = {
    Text = "Advanced Imagery"
  },
  State_56333_Desc = {
    Text = "Recover 10% of lost HP. If current HP is below 25%, this card takes effect an additional time."
  },
  State_56333_Name = {
    Text = "Advanced Imagery"
  },
  State_56334_Desc = {
    Text = "The next Posse activates twice."
  },
  State_56334_Name = {
    Text = "Advanced Imagery"
  },
  State_56335_Desc = {
    Text = "Deals <RealDamage:Fixed DMG> equal to 150% Max HP, which enjoys a 10x <PowerIconKeywords:STR> bonus."
  },
  State_56335_Name = {
    Text = "Advanced Imagery"
  },
  State_56336_Desc = {
    Text = "Draw 5 cards."
  },
  State_56336_Name = {
    Text = "Advanced Imagery"
  },
  State_56337_Desc = {
    Text = "Obtain [DescArg1] Temporary <AlertIconKeywords:Alert>. After use, shield and healing for this turn are increased by [DescArg2]%."
  },
  State_56337_Name = {
    Text = "Advanced Imagery"
  },
  State_56338_Desc = {
    Text = "Obtain 3 Arithmetica."
  },
  State_56338_Name = {
    Text = "Advanced Imagery"
  },
  State_56339_Desc = {
    Text = "Dispel a random debuffs. This card activates 3 additional times. Exhaust."
  },
  State_56339_Name = {
    Text = "Advanced Imagery"
  },
  State_56340_Desc = {
    Text = "Inflict <VulnerabilityIconKeywords:Vulnerable> to all enemies for 3 turns. Whenever an enemy dies, put this card from the deck into hand."
  },
  State_56340_Name = {
    Text = "Advanced Imagery"
  },
  State_56341_Desc = {
    Text = "Realm Mastery +25, Temporary Realm Mastery +125."
  },
  State_56341_Name = {
    Text = "Advanced Imagery"
  },
  State_56342_Desc = {
    Text = "All Awakeners gain 15 Aliemus."
  },
  State_56342_Name = {
    Text = "Advanced Imagery"
  },
  State_56343_Desc = {
    Text = "Inflict <WeaknessIconKeywords:Weakness> to all enemies for 3 turns, place 1 copy of this card into the Discard Pile, and attach <DepleteIconKeywords:Exhaust>, <NothingnessIconKeywords:Fleeting>."
  },
  State_56343_Name = {
    Text = "Advanced Imagery"
  },
  State_56361_Desc = {
    Text = "Idle Effect"
  },
  State_56361_Name = {
    Text = "Idle Effect"
  },
  State_56372_Desc = {
    Text = "Upon death, clear the last debuff acquired by you."
  },
  State_56372_Name = {
    Text = "Flowers and Poetry"
  },
  State_56400_Desc = {
    Text = "After \"Strike\", sequentially change this Awakener's Skills in your hand to other Skills: [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Poetic Bygone Days"
  },
  State_56402_Desc = {
    Text = [[
Possessing the metaphor <D06CardKeyWordnu:"Anger"> [DescArg2] stacks: "Snarl Psalm" triggers Leap and deals additional DMG.
Possessing the metaphor <D06CardKeyWordai:"Sorrow"> [DescArg3] stacks: "Elegy Psalm" triggers Leap and restores additional HP.
Possessing the metaphor <D06CardKeyWordxi:"Happiness"> [DescArg1] stacks: "Carol Psalm" triggers Leap and gives additional Aliemus to the selected Awakener.
Possessing the metaphor <D06CardKeyWordju:"Fear"> [DescArg4] stacks: "Dirge Psalm" triggers Leap and gives additional STR.]]
  },
  State_56402_Name = {Text = "Metaphor"},
  State_57165_Desc = {
    Text = "Awakener deals 25% more Damage."
  },
  State_57165_Name = {Text = "Enhance"},
  State_57166_Desc = {
    Text = "Awakener deals 25% more Damage."
  },
  State_57166_Name = {
    Text = "<CardKeyWord:Enhance>"
  },
  State_57170_Desc = {
    Text = "Hand Limit +2. At turn end, choose 1 card in hand to retain and reduce its Arithmetica Cost by 1 for 3 turns."
  },
  State_57170_Name = {
    Text = "Guiding light"
  },
  State_57316_Desc = {
    Text = "At turn start, transform 1 \"Embryo\" into \"Scion of Purity\". If there are no \"Embryos\", place 1 \"Embryo\" into hand. Lasts for [Layer] turns."
  },
  State_57316_Name = {
    Text = "Sacred Relic's Perpetuity"
  },
  State_57317_Desc = {
    Text = "While this Wheel of Destiny is in the deck, you can see the upcoming changes to your skills."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Flowers and Poetry of Bygone Days>"
  },
  State_57324_Desc = {
    Text = "If this Awakener triggers \"Poetic Bygone Days\", this card transforms into <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Poetic Bygone Days"
  },
  State_57325_Desc = {
    Text = "If this Awakener triggers \"Poetic Bygone Days\", this card transforms into <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Poetic Bygone Days"
  },
  State_57326_Desc = {
    Text = "If this Awakener triggers \"Poetic Bygone Days\", this card transforms into <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Poetic Bygone Days"
  },
  State_57335_Name = {
    Text = "This card's DMG gains an additional [DescArg1] times Strength boost."
  },
  State_57356_Name = {
    Text = "State@Abyssal Counter Calculation"
  },
  State_57368_Name = {
    Text = "State@Abyssal Counter Leap"
  },
  State_57413_Name = {
    Text = "Each point of Shield increases this card's DMG by [DescArg1]"
  },
  State_57417_Desc = {
    Text = "Each time Death Resistance is triggered, deal 100% counter Fixed DMG. Each time Death Resistance is triggered in this battle, increase Fixed DMG by 25%"
  },
  State_57417_Name = {
    Text = "Cradle of Love"
  },
  State_57566_Name = {
    Text = "Surviving Impasse"
  },
  State_57587_Desc = {
    Text = "When playing \"Gland Division\", draw 1 card, with [Layer] uses remaining."
  },
  State_57587_Name = {
    Text = "Jellyfish, Assemble!"
  },
  State_57728_Desc = {
    Text = "Uvhash's DMG instances increased by 1"
  },
  State_57728_Name = {
    Text = "Gift of Surging Blood"
  },
  State_57751_Desc = {
    Text = "Team Unique: The Shield generated by the wielder +<WeaponEffect_Num:[StateArg1]%>. After releasing the Posse, all Awakeners gain an additional <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate and Crit. DMG, but incur a sacrifice of 3% of Max HP. If the current Realm is \"Aequor\", releasing the Posse will also increase Tentacle DMG by <WeaponEffect_Num:[StateArg3]%> of the wielder's Attack."
  },
  State_57751_WeaponDesc = {
    Text = "The Shield Generation effects caused by the wielder are increased by <WeaponEffect_Num:[StateArg1]%>. After releasing the Posse, all Awakeners obtain <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate and Crit. DMG, but gain [DescArg1] Sacrifice. If the current realm is \"Aequor\", releasing a Posse also increases Tentacle DMG by [DescArg2]."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gain [StateArg1] stacks of <PVPSleepKeywords:Quality Nap> when equipped."
  },
  State_57753_Name = {
    Text = "Slumber Beneath the Glacier"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After the first \"Exalt\" each turn, gain Temporary <StrongEffectKeywords:Amplification> +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Shepherd's Staff"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, deduct <Energy:[Energy:StateArg1]> Aliemus and gain a <PVPDerivativeCardKeywords_12:\"Tiny Wish\">. If there is not enough Aliemus to deduct, gain <Energy:[Energy:StateArg2]> Aliemus instead."
  },
  State_57767_Name = {
    Text = "Never-Ending Performance"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\" DMG +[StateArg1]%. Recover [StateArg2]% of lost HP after \"Exalt\"."
  },
  State_57768_Name = {
    Text = "Til the Snow Melts"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After the wielder plays a skill card, draw 1 of the wielder's skill cards. The effect can only activate once per turn."
  },
  State_57769_Name = {
    Text = "Gateway of Truth"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Damage, healing, and Shield effects of \"Skill\" +[StateArg1]~[StateArg2]% (currently [DescArg1]%), <PhantomKeywords:Phantasm>."
  },
  State_57770_Name = {
    Text = "Fate Roulette"
  },
  State_57814_Name = {
    Text = "When this marker is present, it indicates that a Wheel of Destiny is being changed. Some logic requires this marker for recognition."
  },
  State_57817_Desc = {
    Text = "Unable to act, stacks -1 at turn end. When stacks are exhausted, <StrongEffectKeywords:Amplification> +5, cannot be dispelled. Changing the Wheel of Destiny will lose the Quality Nap state."
  },
  State_57817_Name = {
    Text = "Quality Nap"
  },
  State_57854_Desc = {
    Text = "At turn start, gain [StateArg1] Shield and [StateArg2] Tentacle DMG, and generate 2 Temporary Tentacles lasting [Layer] turns."
  },
  State_57854_Name = {
    Text = "Oath of Freedom"
  },
  State_57854_WeaponDesc = {
    Text = "State@Aequor Lady Tea & Cake"
  },
  State_57864_Name = {
    Text = "Strength Boost Refresh"
  },
  State_57942_Desc = {
    Text = "Current fusion rate [Layer]%. When it reaches 100%, the enemy will forcibly enter the next phase and unleash more powerful transition skills."
  },
  State_57942_Name = {
    Text = "Fusion Level"
  },
  State_57952_Desc = {
    Text = "When Strength is reduced, only 50% of the Strength stacks are reduced."
  },
  State_57952_Name = {Text = "Deep Dive"},
  State_57953_Desc = {
    Text = "At turn end, generate 1 Tentacle. State is removed upon Awaken."
  },
  State_57953_Name = {Text = "Slumber"},
  State_57955_Desc = {
    Text = "Helot's DMG is increased by [StateArg1]%, lasting for [Layer] turns."
  },
  State_57955_Name = {
    Text = "Surviving Impasse: Damage"
  },
  State_57968_Desc = {
    Text = "Under Juliette's influence, the Twin Fusion gauge increases by 10% at the end of each turn, and 1 \"Mutation\" card is shuffled into the Draw Pile."
  },
  State_57968_Name = {
    Text = "\"Juliette's Song\""
  },
  State_57976_Desc = {
    Text = "\"Child of Darkness\" performs Forced Fusion, dealing Fixed DMG equal to 3 times its current HP to \"Forgotten Beginning\"."
  },
  State_57976_Name = {Text = "Sacrifice"},
  State_58051_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_58051_Name = {Text = "Crit. DMG"},
  State_58052_Desc = {
    Text = "For every 1 point of Black Sigil consumed during exploration, the Base DMG of \"All-In\" increases by 0.5%. (Increased by [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Certain Gain"
  },
  State_58061_Name = {
    Text = "Honest Return"
  },
  State_58063_Desc = {
    Text = "DMG dealt by the Awakener increases by 25% and lasts for [Layer] turns."
  },
  State_58063_Name = {
    Text = "Gaze Out of the Aeons"
  },
  State_58144_Desc = {
    Text = "Crit. Rate + [Layer]% in this stage."
  },
  State_58144_Name = {
    Text = "Permanent Crit. Rate"
  },
  State_58144_WeaponDesc = {
    Text = "Crit. Rate + [Layer]% in this stage."
  },
  State_58259_Desc = {
    Text = "Team Unique: Increases the wielder's Crit. Rate by <WeaponEffect_Num:[StateArg1]%>. Gain <WeaponEffect_Num:[StateArg2]> Black Sigil upon killing an enemy, up to 3 times during exploration. After 3 triggers, the wielder's Crit. Rate permanently increases by <WeaponEffect_Num:[StateArg3]%> for the rest of the exploration."
  },
  State_58259_WeaponDesc = {
    Text = "The wielder's Crit. Rate + <WeaponEffect_Num:[StateArg1]%>. The wielder gains <WeaponEffect_Num:[DescArg2]> Black Sigils after killing an enemy, up to 3 times per exploration ([DescArg1]/3). After 3 triggers, the wielder permanently gains <WeaponEffect_Num:[StateArg3]%> Crit. Rate for the current exploration."
  },
  State_58297_Desc = {
    Text = [[
When Ryker kills an enemy, he gains [DescArg3] Black Sigils, with a maximum of 5 times per exploration. ([DescArg1]/5)
By acquiring 75/150/300 Black Sigils through battle, increase the Relic Capacity by 1. At the end of the battle, select one "Chaotic Legacy" to add to the relic list. (Already acquired [DescArg2] Black Sigils)]]
  },
  State_58297_Name = {
    Text = "Winner Takes All"
  },
  State_58447_Desc = {
    Text = [[
Includes the following three relics:
"Lucky Windcoat": Increases all Awakener Crit. Rates by 10%. All Ryker and dice rolls will never result in the minimum value.
<TentacleInjurieIconKeywords:Upgrade>: The Crit. Rate increase changes to 15%, and the maximum value of random results increases by 1.
"Octahedron Dice": Each time a Posse is activated, add 1 "<C05_yansheng1:Octahedron Dice>" to your hand.
<TentacleInjurieIconKeywords:Upgrade>: Change to add 1 "<C05_yansheng2:Shining Octahedron Dice>" to your hand.
"Big Mouth Button": At turn start and when Ryker or dice's random effect triggers, gain 50 Keyflare and 2% Crit. DMG, up to 30% Crit. DMG.
<TentacleInjurieIconKeywords:Upgrade>: Change to gain 100 Keyflare and 4% Crit. DMG, up to 50% Crit. DMG.]]
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Chaotic Legacy>"
  },
  State_58490_Desc = {
    Text = "When all drowsiness is removed, all Awakeners and Cards will be sealed, and the Intention of \"Slumbering Sovereign\" will be adjusted to \"Monarch's Authority\"."
  },
  State_58490_Name = {Text = "Drowsiness"},
  State_58491_Desc = {
    Text = "Remove 1 stack of \"Drowsiness\" whenever a card is played. At turn start, restore to 12 stacks of \"Drowsiness\"."
  },
  State_58491_Name = {Text = "Fury"},
  State_58492_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_58492_Name = {Text = "Not Roused"},
  State_58493_Desc = {
    Text = "Remove 1 stack of \"Drowsiness\" whenever a card is played. At turn start, restore to 12 stacks of \"Drowsiness\"."
  },
  State_58493_Name = {Text = "Fury"},
  State_58947_Desc = {
    Text = "Crit. Rate + [Layer]% in this stage."
  },
  State_59078_Name = {
    Text = ", can be used 1 time"
  },
  State_59079_Name = {
    Text = ", can be used 2 times"
  },
  State_59080_Name = {
    Text = ", can be used 3 times"
  },
  State_59117_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_59117_Name = {Text = "Crit. DMG"},
  State_59160_Desc = {
    Text = "Each stack increases all damage, healing, and Shield effects dealt by \"Command Cards\" and \"Exalt\" in this battle by 10%, and cannot be dispelled."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:Amplification>"
  },
  State_59161_Desc = {
    Text = "Command Card and Exalt DMG, Healing, Shield +[DescArg1]%, cannot be dispelled."
  },
  State_59161_Name = {
    Text = "Amplification"
  },
  State_59169_Desc = {
    Text = "This card's base Arithmetica Cost will not exceed Arithmetica Limit."
  },
  State_59169_Name = {Text = "Balance"},
  State_59173_Name = {
    Text = "When this marker is present, it indicates ongoing multiple strikes, and multiple strikes will not be triggered again."
  },
  State_59208_Desc = {
    Text = "Each stack reduces all damage, healing, and Shield effects caused by \"Command Cards\" and \"Exalt\" in this battle by 10%, and cannot be dispelled."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Amplification▼>"
  },
  State_59209_Desc = {
    Text = "Command Card and Exalt DMG, Healing, Shield -[DescArg1]%, cannot be dispelled."
  },
  State_59209_Name = {
    Text = "Amplification▼"
  },
  State_59423_Desc = {
    Text = [[
When Ryker kills an enemy, he gains 5 Black Sigils. For every 1% Sigil Yield Ryker has, the amount gained increases by 1%, with a maximum of 5 activations per exploration.
By acquiring 75/150/300 Black Sigils through battle, increase the Relic Capacity by 1. At the end of the battle, choose one "Chaotic Legacy" to add to the relic list.]]
  },
  State_59423_Name = {
    Text = "Winner Takes All"
  },
  State_59424_Desc = {
    Text = "For every 1 point of Black Sigil consumed during exploration, the Base DMG of \"All-In\" increases by 0.5%."
  },
  State_59424_Name = {
    Text = "Certain Gain"
  },
  State_59439_Desc = {
    Text = "This state uses the Vulnerable multiplier, acting as an independent multiplier."
  },
  State_59439_Name = {
    Text = "If you have a certain state, receive double damage"
  },
  State_59519_Name = {
    Text = "Choose 1 Command Card from the Draw Pile or Discard Pile and add it to your hand, setting its Arithmetica Cost to 0."
  },
  State_59520_Desc = {
    Text = "Upon use, draw 2 cards, reducing their Arithmetica Cost by the amount of the Orisoned Card's Arithmetica Cost. Takes effect once per battle."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Lex Nous>"
  },
  State_59521_Name = {
    Text = "Lose 10% of current HP ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Upon use, discard all cards in hand that does not belong to this Awakener. Gain 5 non-Command Cards. Takes effect once per battle."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Lex Volis>"
  },
  State_59525_Name = {
    Text = "Owner of this Command Card gains 50 Aliemus."
  },
  State_59526_Desc = {
    Text = "After playing, gain 3 Base Copies with <RetainIconKeywords:Retain> and <DepleteIconKeywords:Exhaust> attached. Takes effect once per battle."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Lex Genis>"
  },
  State_59534_Name = {
    Text = "When this marker is present, it indicates that this card is prohibited from triggering phantasm."
  },
  State_59560_Name = {
    Text = "Choose a card that has received the Three Aeons' Orisons to add to your hand."
  },
  State_59671_Desc = {
    Text = "All Awakeners deal 15% more Final DMG this turn."
  },
  State_59671_Name = {
    Text = "Hyperstring Pocketwatch"
  },
  State_59678_Desc = {
    Text = "Lose all other relics upon pickup. Randomly gain 2 Golden Relics."
  },
  State_59878_Desc = {
    Text = "At turn end, additionally reduce 1 stack of \"Chaos\" and obtain [StateArg1] <PowerIconKeywords:STR>. Subsequent summoned \"N\" clones have their HP increased by 200%, and dying no longer causes \"N\" to reduce stacks of \"Chaos\" or obtain <PowerIconKeywords:STR>."
  },
  State_59878_Name = {
    Text = "Chaos Arrival"
  },
  State_59991_Name = {
    Text = ", this card consumes up to 5 stacks of <EnergyStorageKeywords:Charge> when played"
  },
  State_59993_Name = {
    Text = "Recover 10% of lost HP ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Gain 1 stack of Temporary Madness with each active Attack received."
  },
  State_60000_Name = {
    Text = "Building Fury"
  },
  State_60028_Desc = {
    Text = "At turn start, the Arithmetica Cost of one random card is set to 3. Upon death, remove this effect, reduce the Arithmetica Cost of the killer's cards by 1 for that turn."
  },
  State_60028_Name = {
    Text = "Delirium Cage"
  },
  State_60044_Name = {
    Text = "\"Consumed after [Layer] uses\""
  },
  State_60083_Desc = {
    Text = "Damage taken this turn is reduced by [Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:Fortress>"
  },
  State_60083_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60085_Desc = {
    Text = "Gain Temporary Fortress at the start of Battle and each turn. The higher your HP, the more stacks gained, up to 50."
  },
  State_60085_Name = {
    Text = "Ultimate Pupation"
  },
  State_60085_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60086_Desc = {
    Text = "Gain Temporary Fortress at the start of Battle and each turn. The higher your HP, the more stacks gained, up to 25."
  },
  State_60086_Name = {Text = "Pupation"},
  State_60086_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60087_Desc = {
    Text = "Blighten effect caused reduces [Layer]% HP Regen."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Blighten Amplification>"
  },
  State_60087_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60088_Desc = {
    Text = "Each stack reduces DMG taken by 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:Fortress>"
  },
  State_60088_WeaponDesc = {
    Text = "All Shield obtained are reduced by 25%."
  },
  State_60089_Desc = {
    Text = "Damage received is reduced by [Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:Fortress>"
  },
  State_60089_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60106_Desc = {
    Text = "At turn start, the Arithmetica Cost of one random hand card changes to 3 and reverts at turn end."
  },
  State_60106_Name = {
    Text = "Delirium Cage"
  },
  State_60112_Desc = {
    Text = "All Awakeners gain 1 point of Aliemus for each Command Card played this turn."
  },
  State_60112_Name = {Text = "Concerto"},
  State_60115_Desc = {
    Text = "After releasing Exalt this turn, the Twin Fusion rate decreases by 3%."
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "This turn's Damage, Poison, and Counter +[Layer]%."
  },
  State_60118_Name = {Text = "Rhapsody"},
  State_60128_Desc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_60128_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_60129_Desc = {
    Text = "The next [Layer] non-Derived Command Cards you play has -2 Arithmetica Cost."
  },
  State_60129_Name = {
    Text = "Descending Scale"
  },
  State_60130_Desc = {
    Text = "The next [Layer] non-Derived Command Card you play has +2 Arithmetica Cost and takes effect 2 times."
  },
  State_60130_Name = {
    Text = "Ascending Scale"
  },
  State_60148_Desc = {
    Text = "At turn end, gain different effects based on the status: Release - Obtain 1 stack of Temporary <MadnessIconKeywords:Madness>. Contain - Obtain 50 stacks of Temporary <ReinforcePVEKeywords:Fortress>."
  },
  State_60148_Name = {
    Text = "Parameter Fitting"
  },
  State_60150_Desc = {
    Text = "Switch between the \"Unleash\" and \"Retract\" modes whenever you uses a Posse. Gain [StateArg1] Temporary STR when switching to Unleash, and gain [StateArg2] Shield when switching to Retract."
  },
  State_60150_Name = {
    Text = "Functional Sensing"
  },
  State_60151_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, restore HP, and fight with full power."
  },
  State_60151_Name = {Text = "Not Roused"},
  State_60154_Desc = {
    Text = "Currently in Retract Mode. Mechanical Armament gains Shield and Alert, with intentions focused on defense."
  },
  State_60154_Name = {
    Text = "Retract: Mecha"
  },
  State_60155_Desc = {
    Text = "Currently in Unleash Mode. Mechanical Armament gains extra STR, with intentions focused on offense."
  },
  State_60155_Name = {
    Text = "Unleash: Mecha"
  },
  State_60167_Desc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_60167_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_60184_Desc = {
    Text = "Each time a card is played, \"Twins of Contradiction\" change their intention."
  },
  State_60184_Name = {Text = "Paradox"},
  State_60187_Desc = {
    Text = "Inflicts 50% Weakness, Fragile, and Blighten states."
  },
  State_60187_Name = {
    Text = "End is the Beginning"
  },
  State_60201_Name = {
    Text = "Monster Delay Strength"
  },
  State_60263_Desc = {
    Text = "The Fragile effect applied is changed to reduce Shield generation by [Layer]%."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Fragile Amplification>"
  },
  State_60264_Desc = {
    Text = "Bleeding effects caused will only be automatically removed by 50% at the end of each turn."
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Hemolysis>"
  },
  State_60265_Desc = {
    Text = "\"Bleeding effect only removes 50% at turn end.\""
  },
  State_60265_Name = {
    Text = "<BleedingColour:Hemolysis>"
  },
  State_60279_Name = {
    Text = "This card will be consumed at turn end."
  },
  State_60284_Desc = {
    Text = "Gain Temporary Fortress at the start of Battle and each turn; the lower your HP, the more stacks gained, up to 50."
  },
  State_60284_Name = {
    Text = "Unbreakable Sword Array"
  },
  State_60284_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60297_Desc = {
    Text = "\"@2\" descends in its true form, HP becomes 3x. Each turn, it questions the Keeper, adding one \"Answer Tawil\" card to the hand."
  },
  State_60297_Name = {
    Text = "Truth Inquiry"
  },
  State_60297_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_60298_Desc = {
    Text = "This unknown entity still lurks beneath the Black Pool. It will fully awaken and revive upon imminent defeat, ready to fight in its liberated form."
  },
  State_60298_Name = {Text = "Dormancy"},
  State_60312_Desc = {
    Text = "Each turn, when the accumulated DMG reaches 10% of HP, gain [Layer] stacks of Temporary \"Fortress\"."
  },
  State_60312_Name = {
    Text = "Dissolution Mist Shield"
  },
  State_60315_Desc = {
    Text = "After releasing Exalt this turn, recover 5% of lost HP ([DescArg1])."
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Gain 1 Arithmetica and draw 1 card, but this card will be Exhausted."
  },
  State_60339_Name = {
    Text = "Gain 1 Arithmetica and draw 1 card after playing this turn, but this card will be exhausted"
  },
  State_60367_Desc = {
    Text = "At turn start, the Arithmetica Cost of one random card is set to 3. Upon death, remove this effect, reduce the Arithmetica Cost of the killer's cards by 1 for that turn."
  },
  State_60367_Name = {
    Text = "Delirium Cage"
  },
  State_60386_Desc = {
    Text = "Effects: Bleed (150% DMG), Poison (75% DMG), apply 1 Weakness, apply 1 Vulnerable, Temp. STR -[DescArg1]."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Marvelous Debuff>"
  },
  State_60404_Desc = {
    Text = "Gain 2 stacks of Temporary reinforcement each time you take 1 Damage."
  },
  State_60404_Name = {
    Text = "Final Transformation"
  },
  State_60408_Desc = {
    Text = "Whenever HP drops to 33% (missing [DescArg1]), this turn will take no DMG and unleash \"Ghostly Bite\"."
  },
  State_60408_Name = {
    Text = "Ghostly Bite"
  },
  State_60409_Desc = {
    Text = "Whenever HP decreases to 66% (missing [DescArg1]), this turn will take no DMG and unleash \"Final Transformation\"."
  },
  State_60409_Name = {
    Text = "Mirror of the End"
  },
  State_60429_Name = {
    Text = "State@Awakener Hameln@Primordial Melody"
  },
  State_60430_Desc = {
    Text = "When playing a card whose actual Arithmetica Cost matches the displayed intention, exhaust it and reduce all enemies' Temporary STR by [DescArg1]."
  },
  State_60430_Name = {
    Text = "Note Command"
  },
  State_60431_Name = {
    Text = "State@Awakener Hameln@Ascent Tone"
  },
  State_60432_Name = {
    Text = "State@Awakener Hameln@Soul Overture"
  },
  State_60433_Name = {
    Text = "State@Awakener Hameln@Descent Tone"
  },
  State_60434_Name = {
    Text = "State@Awakener Hameln@Memories Rondo"
  },
  State_60435_Name = {
    Text = "State@Awakener Hameln@Soul Prelude Counter"
  },
  State_60436_Desc = {
    Text = "When dealing unblocked Damage, shuffle [StateArg1] \"Wound\" into the Draw Pile."
  },
  State_60436_Name = {
    Text = "Soul Overture"
  },
  State_60438_Name = {
    Text = "State@Awakener Hameln@Ascent Tone Monitor"
  },
  State_60439_Name = {
    Text = "State@Awakener Hameln@Descent Tone Monitor"
  },
  State_60440_Name = {
    Text = "State@Awakener Hameln@Soul Prelude Listener"
  },
  State_60441_Name = {
    Text = "State@Awakener Hameln@Memories Rondo Listener"
  },
  State_60442_Name = {
    Text = "State@Awakener Hameln@Primordial Melody Monitor"
  },
  State_60486_Desc = {
    Text = "At the start of battle, all Awakeners' Aliemus is reduced by half."
  },
  State_60486_Name = {
    Text = "Mother God Absorption"
  },
  State_60487_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, with Max HP +200%, and fight with full power."
  },
  State_60487_Name = {Text = "Not Roused"},
  State_60490_Desc = {
    Text = "After death, all Awakeners gain 30 Aliemus."
  },
  State_60490_Name = {
    Text = "Will to Live"
  },
  State_60491_Desc = {
    Text = "Reduce Aliemus caused by all Awakeners by 50%."
  },
  State_60491_Name = {
    Text = "Mother Tree Ceremony"
  },
  State_60493_Desc = {
    Text = "For every [Layer] HP lost, summon a Mimic Awakener. If there are already 2 Mimic Awakeners on the field, increase the Max HP of all Mimic Awakeners by 50%."
  },
  State_60493_Name = {
    Text = "Nourishing Mother"
  },
  State_60500_Desc = {
    Text = "If there is a Mimicry Awakener present, gain 50 stacks of \"Conceal\"."
  },
  State_60500_Name = {
    Text = "Hidden in the Woods"
  },
  State_60511_Desc = {
    Text = "Always in starting hand."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Innate>"
  },
  State_60511_WeaponDesc = {
    Text = "After being played, the card will not go into the Discard Pile and cannot be used again in this battle."
  },
  State_60522_Desc = {
    Text = "Increases Fragile and Blighten effects to 50%."
  },
  State_60522_Name = {
    Text = "Destruction"
  },
  State_60523_Desc = {
    Text = "Each stack increases the attack count by 1. Lose 1 stack upon taking DMG, and lose all stacks at the end of turn."
  },
  State_60523_Name = {Text = "Prayer"},
  State_60524_Desc = {
    Text = "Gain [Layer] stacks of Fortress at the start of battle and at turn start, up to 50 stacks."
  },
  State_60524_Name = {
    Text = "Sanctification"
  },
  State_60524_WeaponDesc = {
    Text = "All DMG dealt is reduced by [DescArg1]%."
  },
  State_60527_Desc = {
    Text = "When played, Exhaust, reduce enemies' Temporary STR."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Choir of Heaven>"
  },
  State_60543_Desc = {
    Text = "At turn end, gain 10 stacks of \"Blood Oath\"; \"Blood Oath\" will remove 1 stack after taking Damage."
  },
  State_60543_Name = {
    Text = "Lampwick Flame"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60562_Desc = {
    Text = "When played, takes effect 2 times and changes to \"Crescendo\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60564_Desc = {
    Text = "When about to be defeated for the first time, recover HP and change intention to \"Final Evolution\", gaining Strength and reinforcement. When about to be defeated for the second time, recover HP and change intention to \"Ghostly Bite\", dealing extremely high single DMG."
  },
  State_60564_Name = {
    Text = "Shadow Fiend"
  },
  State_60567_Desc = {
    Text = "Play this card to grant Hameln 3 Aliemus."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Crescendo>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Crescendo>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_60570_Desc = {
    Text = "Play this card to grant Hameln 3 Aliemus."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60576_Desc = {
    Text = "At turn start, the Arithmetica Cost of one random card is set to 3. Upon death, remove this effect, reduce the Arithmetica Cost of the killer's cards by 1 for that turn."
  },
  State_60576_Name = {
    Text = "Delirium Cage"
  },
  State_60578_Desc = {
    Text = "Revives to 50% HP after Fatal DMG, immune to DMG for 1 turn, intention changes to \"Chrysalis Break\"."
  },
  State_60578_Name = {
    Text = "Chrysalis Break"
  },
  State_60592_Desc = {
    Text = "Team Unique: At the start of exploration, shuffle 1 \"Silver Key Radiance\" with  <DestructionKeywords:\"Destroy\"> into the Draw Pile. After releasing Posse, the wielder's Crit. DMG +<WeaponEffect_Num:[StateArg1]%>. When the wielder deals DMG, gain Keyflare equal to <WeaponEffect_Num:[StateArg2]%> of the wielder's Keyflare Regen and <WeaponEffect_Num:[StateArg3]%> Temporary Crit. Rate, up to 5 times per turn."
  },
  State_60592_WeaponDesc = {
    Text = "At the start of exploration, shuffle 1 \"Silver Key Radiance\" with  <DestructionKeywords:\"Destroy\"> into the Draw Pile. After releasing Posse, the wielder's Crit. DMG +<WeaponEffect_Num:[StateArg1]%>. When the wielder deals DMG, gain  <WeaponEffect_Num:[DescArg1]> Keyflare and <WeaponEffect_Num:[StateArg3]%> Temporary Crit. Rate, up to 5 times per turn."
  },
  State_60594_Desc = {
    Text = "Team Unique: At turn end, the wielder gains 5 Aliemus. After the wielder releases Exalt, the next Command Card played by the wielder this turn increases its Crit. Rate, Crit. DMG, Shield, and health recovery by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "At turn end, the wielder gains 5 Aliemus. After triggering Exalt, the next Command Card played by the wielder this turn increases Crit. Rate, Crit. DMG, Shield, and HP Recovery by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60898_Desc = {
    Text = "When attacked, seals the Awakener's Exalt and all Command Cards for 1 turn, removing 1 stack of Chains of Resentment."
  },
  State_60898_Name = {
    Text = "<ExclamationPointColour:Chains of Resentment>"
  },
  State_60925_Desc = {
    Text = "At turn end, recover 5% of the lost HP. Whenever you draws a Symptom or State Card, all allies gain [Layer] STR."
  },
  State_60925_Name = {
    Text = "Blood Lantern"
  },
  State_60926_Desc = {
    Text = "At turn end, if current HP is below 50%, gain [Layer] STR and [StateArg1] stacks of Barrier."
  },
  State_60926_Name = {
    Text = "Lantern Altar"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Before \"Exalt\", inflict [StateArg1] stacks of <PVPSlowKeywords:Stagnation> on all enemy targets."
  },
  State_60953_Name = {
    Text = "Eternal Requiem"
  },
  State_60962_Desc = {
    Text = "Max HP increases by [Layer]% in this battle."
  },
  State_60962_Name = {Text = "HP Boost"},
  State_60964_Desc = {
    Text = "In this battle, DMG is increased by [Layer]%."
  },
  State_60964_Name = {Text = "DMG Boost"},
  State_61038_Name = {
    Text = "Hameln Trial"
  },
  State_61050_Desc = {
    Text = "After triggering the \"Melody\" effect or playing the \"Symphony of Harmony\", Hameln gains 1% Crit. Rate and Crit. DMG (Currently gained: [DescArg1]%). For every 10 triggers, the number of DMG instances of \"Soul Overture\" and \"Primal Chord\" +1 in this battle, up to 3 times."
  },
  State_61050_Name = {
    Text = "Moonlit Rhapsody"
  },
  State_61051_Desc = {
    Text = "After triggering the \"Melody\" effect or playing the \"Symphony of Harmony\", Hameln gains 1% Crit. Rate and Crit. DMG. For every 10 triggers, the number of DMG instances of \"Soul Overture\" and \"Primal Chord\" +1 in this battle, up to 3 times."
  },
  State_61051_Name = {
    Text = "Moonlit Rhapsody"
  },
  State_61056_Desc = {
    Text = "Gain 100 Temporary STR on the first turn."
  },
  State_61056_Name = {Text = "Fury"},
  State_61084_Desc = {
    Text = "This turn has played [Layer] cards: If Arithmetica Cost is greater than or equal to 3, gain 2 Arithmetica; otherwise draw 2 cards."
  },
  State_61084_Name = {
    Text = "Symphony Fourth"
  },
  State_61085_Desc = {
    Text = "Arithmetica Cost -2, takes effect 2 times, then changes to \"Crescendo\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_61089_Desc = {
    Text = "The next Command Card played will take effect twice."
  },
  State_61089_Name = {
    Text = "Conductor's Baton"
  },
  State_61174_Desc = {
    Text = "Cannot obtain Shield."
  },
  State_61174_Name = {
    Text = "Remnant's Requiem"
  },
  State_61180_Desc = {
    Text = "The Base DMG of Helot: Catena in this battle is increased by [DescArg1]%."
  },
  State_61180_Name = {
    Text = "Blade of Vengeance"
  },
  State_61185_Desc = {
    Text = "Enhances enemy skills. Lose one stack upon taking Damage."
  },
  State_61185_Name = {Text = "Blood Oath"},
  State_62213_Desc = {
    Text = "Change the Weakness effect to reduce DMG dealt by [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Weakness Amplification>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gain [StateArg1] <StrongEffectKeywords:Amplification> when equipped. When the wielder loses HP and their HP is below [StateArg2]%, gain <PVPWeaponKeywords:Fortress> and <StrengthenKeywords:Enhance>."
  },
  State_62309_Name = {
    Text = "Drowning in Crimson"
  },
  State_62317_Desc = {
    Text = "Immune to all types of DMG (Pierce DMG included). Removed at turn start."
  },
  State_62317_Name = {
    Text = "DMG Immunity"
  },
  State_62336_Desc = {
    Text = "After playing 3 cards (with [Layer] cards remaining), draw 1 card and randomly freeze 1 Command Card in hand."
  },
  State_62336_Name = {
    Text = "Winter's Chill"
  },
  State_62337_Desc = {
    Text = "After playing 3 cards (with [Layer] cards remaining), draw 1 card and randomly freeze 1 Command Card in hand."
  },
  State_62337_Name = {
    Text = "Winter's Chill"
  },
  State_62338_Desc = {
    Text = "This card cannot be played, will not be discarded at turn end, and grants the associated Awakener 5 Aliemus. Unfreeze after the Awakener releases Exalt."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Freeze>"
  },
  State_65332_Desc = {
    Text = "After death, all Awakeners gain 30 Aliemus."
  },
  State_65332_Name = {
    Text = "Dissolution"
  },
  State_65342_Desc = {
    Text = "Upon defeat, resurrect with an additional 100% Max HP and unleash \"Bone-Chilling Frost\"."
  },
  State_65342_Name = {Text = "Silence"},
  State_65346_Desc = {
    Text = "On death, freeze 2 Command Cards in the hand."
  },
  State_65346_Name = {Text = "Frostfall"},
  State_65358_Desc = {
    Text = "Team Unique: The wielder's Base DMG increases by <WeaponEffect_Num:[StateArg1]%>. Before Exalt, Temporary hand size +1, draw 1 Command Card. In \"Caro\" realm, triggering devour temporarily increases Crit. DMG by <WeaponEffect_Num:[StateArg1]%>, once per turn"
  },
  State_65358_WeaponDesc = {
    Text = "The wielder's Base DMG is increased by <WeaponEffect_Num:[StateArg1]%>. Before releasing Exalt, the wielder's temporary hand limit increases by 1, and they draw 1 of the wielder's Command Cards. If the current realm is \"Caro\", when the wielder triggers Devour, their Temporary Crit. DMG increases by <WeaponEffect_Num:[StateArg1]%>, with the effect activating once per turn."
  },
  State_65360_Desc = {
    Text = "Team Unique: The wielder's Base DMG increases by <WeaponEffect_Num:[StateArg1]%>. At the start of the battle, the wielder gains 25 stacks of \"Snow\". Playing a card grants 2 Aliemus and removes 1 stack. Once all \"Snow\" stacks are removed, the wielder gains <WeaponEffect_Num:[StateArg2]%> Crit. Rate."
  },
  State_65360_WeaponDesc = {
    Text = "The wielder's Base DMG is increased by <WeaponEffect_Num:[StateArg1]%>. At the start of the battle, the wielder gains 25 stacks of \"Snow\", gaining 2 Aliemus and removing 1 stack after playing a card. After \"Snow\" is completely removed, the wielder gains <WeaponEffect_Num:[StateArg2]%> Crit. Rate (currently [DescArg1] stacks of Snow remaining)."
  },
  State_65362_Desc = {
    Text = "After receiving [StateArg1] instances of Active DMG (remaining: [Layer]), randomly freeze 1 Command Card in hand."
  },
  State_65362_Name = {
    Text = "Frost Return"
  },
  State_65463_Name = {
    Text = "Gain 5 Black Sigil points"
  },
  State_65490_Desc = {
    Text = "At turn end, gain [StateArg1] Frost Shield and [StateArg2] Strength."
  },
  State_65490_Name = {
    Text = "Absolute Zero"
  },
  State_65497_Name = {
    Text = "Helot: Catena Trial"
  },
  State_65553_Desc = {
    Text = "At the end of each turn, gain Strength based on the number of cards left in hand, receiving [Layer] per card."
  },
  State_65553_Name = {
    Text = "Blade of Ice"
  },
  State_65557_Desc = {
    Text = "After receiving Fatal DMG, restore all HP and convert intention into \"Gaze of Deepspace EX\", gaining 80 stacks of Temporary Fortress while removing all debuffs from self and buffs from the player. At turn end, remove 20 stacks of Fortress."
  },
  State_65557_Name = {
    Text = "Primordial Chaos"
  },
  State_65558_Desc = {
    Text = "After receiving Fatal DMG, the intent transforms into \"Gaze of Deepspace\" and gains 80 stacks of Fortress, restoring all HP. It can trigger [DescArg1] times. Once the triggers are depleted, upon receiving Fatal DMG again, 1 HP will be retained, and the intent will change to \"Eyes of Infinite Worlds.\" At turn end, remove 20 stacks of Fortress."
  },
  State_65558_Name = {Text = "Stardust"},
  State_65559_Desc = {
    Text = "Tohuwabohu will reappear after everyone has died."
  },
  State_65559_Name = {
    Text = "\"Ancient Fragments\""
  },
  State_65564_Name = {
    Text = [[

<D05EX_Relic:The research team's suspicion of Helot is growing, and you must come up with a way to calm them down before the enemies find you.>]]
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Ignore the team's suspicion and keep moving forward>]]
  },
  State_65566_Name = {
    Text = [[

<D05EX_Relic:Explain the situation to the Research Team>]]
  },
  State_65567_Name = {
    Text = [[

<D05EX_Relic:Restrict Helot to further protect the team members>]]
  },
  State_65568_Name = {
    Text = [[

<D05EX_Relic:Restrict Helot and utilize the power of other Awakeners to protect all team members>]]
  },
  State_65585_Desc = {
    Text = "After playing this card, it returns to your hand. The Orison is disabled until turn end."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Echo>"
  },
  State_66305_Desc = {
    Text = "At turn end, gain 1 stack of Temporary \"Chains of Resentment\"."
  },
  State_66305_Name = {
    Text = "The Timeless Lock"
  },
  State_66306_Desc = {
    Text = "When attacked, seals the Awakener's Exalt and all Command Cards for 1 turn, removing 1 stack of Chains of Resentment. Removes all at turn start."
  },
  State_66306_Name = {
    Text = "<ExclamationPointColour:Chains of Resentment>"
  },
  State_66308_Desc = {
    Text = "After receiving Fatal DMG, lock HP at 1."
  },
  State_66308_Name = {
    Text = "Primordial Chaos"
  },
  State_66311_Desc = {
    Text = "The memories of the Awakeners emerge from the edges of your mind, taking root and growing. No matter how many times you sever them, no matter how Dissolution overwhelms them, they have never left."
  },
  State_66311_Name = {
    Text = "Shattered Memories"
  },
  State_66313_Desc = {
    Text = "For each Command Card played, discard one card with the lowest Arithmetica Cost from this Awakener."
  },
  State_66313_Name = {
    Text = "Supreme Will's Oppression"
  },
  State_66314_Desc = {
    Text = "Immune to all types of DMG (Pierce DMG included)"
  },
  State_66314_Name = {
    Text = "DMG Immunity"
  },
  State_66317_Desc = {
    Text = "\"The memories of the Awakeners surge from the edges of your mind, taking root and growing within you. No matter how many times you sever them, no matter how many times Dissolution overturns them, they have never truly left. At turn start, restore 1 point to Arithmetica Limit and increase the card limit by 2.\""
  },
  State_66317_Name = {
    Text = "Memory Fragments"
  },
  State_66325_Desc = {
    Text = "\"The memories of the Awakeners surge from the edges of your mind, taking root and growing within you. No matter how many times you sever them, no matter how many times Dissolution overturns them, they have never truly left. At turn start, restore 1 point to Arithmetica Limit and increase the card limit by 2.\""
  },
  State_66325_Name = {
    Text = "Memory Fragments"
  },
  State_66358_Desc = {
    Text = "Upon first triggering Death Resistance in exploration, add \"<DerivativeCardKeywords_39:Echoes of the Past>\" to your hand."
  },
  State_66358_Name = {
    Text = "Nonexistent Existence"
  },
  State_66359_Desc = {
    Text = "Generates random options to choose from."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:Discover>"
  },
  State_66360_Desc = {
    Text = "Crit. Rate increased by [Layer]% in this battle."
  },
  State_66360_Name = {Text = "Crit. Rate"},
  State_66362_Desc = {
    Text = "Crit. DMG is increased by [Layer]% in this battle."
  },
  State_66362_Name = {Text = "Crit. DMG"},
  State_66410_Desc = {
    Text = "\"The next [DescArg1] Command Cards played by Tawil take effect twice.\""
  },
  State_66410_Name = {
    Text = "Omnifex Convergence"
  },
  State_66414_Desc = {
    Text = "While in hand, if the top card of the Draw Pile is a Command Card, it becomes a copy of it."
  },
  State_66414_Name = {
    Text = "Omniscient Verity"
  },
  State_66454_Desc = {
    Text = "Skill card Arithmetica Cost decreases by \"Conceal\" stacks, up to 5 stacks. After taking DMG or playing a skill, 1 stack is removed."
  },
  State_66454_Name = {Text = "Conceal"},
  State_66456_Desc = {
    Text = "Skill card Arithmetica Cost decreases by \"Conceal\" stacks, up to 5 stacks. After taking DMG or playing a skill, 1 stack is removed."
  },
  State_66456_Name = {
    Text = "<YinniColour:Conceal>"
  },
  State_66457_Desc = {
    Text = "At the beginning of your next turn, gain [Layer] Aliemus and strengthen."
  },
  State_66457_Name = {
    Text = "King's Trial"
  },
  State_66465_Desc = {
    Text = "After using Exalt, suffer DMG corresponding to the stack count."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Exalt Lock>"
  },
  State_66522_Desc = {
    Text = "Every 8th card you play takes effect twice."
  },
  State_66522_Name = {
    Text = "Stellar Brew+"
  },
  State_66553_Desc = {
    Text = "After using \"Strike\" and \"Defense\", the corresponding Awakeners gain 35 Aliemus. However, their Arithmetica Cost increases by +1."
  },
  State_66553_Name = {
    Text = "Broken Visage"
  },
  State_66554_Desc = {
    Text = "When picked up, place 1 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  State_66554_Name = {
    Text = "Signal Relay"
  },
  State_66555_Desc = {
    Text = "Max Arithmetica increased by 1."
  },
  State_66555_Name = {
    Text = "Vitality Injection"
  },
  State_66556_Desc = {
    Text = "When playing consecutive cards of the same Awakener, that Awakener gains 8 Aliemus."
  },
  State_66556_Name = {
    Text = "Chronometric Device"
  },
  State_66557_Desc = {
    Text = "Every time you lose HP, gain [DescArg1] <PowerIconKeywords:STR>, stacking up to 10 times per battle. When fully stacked, restore 25% of lost HP."
  },
  State_66557_Name = {
    Text = "Highest Honor"
  },
  State_66558_Desc = {
    Text = "Every 3 turns, add 1 stack of <WeaknessIconKeywords:Weakness> to all enemies. After dealing DMG to an enemy with <WeaknessIconKeywords:Weakness>, gain [DescArg1] Temporary <PowerIconKeywords:STR>, with a maximum of 3 triggers per turn."
  },
  State_66558_Name = {
    Text = "Malignant Child"
  },
  State_66559_Desc = {
    Text = "When you play a card with an Arithmetica Cost of 3 or more, draw 1 card and gain 1 Arithmetica."
  },
  State_66559_Name = {
    Text = "Beauty in Loss"
  },
  State_66560_Desc = {
    Text = "\"Strike\" gains 2 Arithmetica and discards 1 random card; \"Defense\" draws 2 cards and loses 1 Arithmetica. Can be triggered up to 3 times per turn."
  },
  State_66560_Name = {
    Text = "Joyous Record"
  },
  State_66561_Desc = {
    Text = "Every 3 turns, add 1 stack of <VulnerabilityIconKeywords:Vulnerable> to all enemies. After dealing DMG to a <VulnerabilityIconKeywords:Vulnerable> enemy, cause them to lose [DescArg1] Temporary <PowerIconKeywords:STR>, with a maximum of 3 triggers per turn."
  },
  State_66561_Name = {
    Text = "Rite of Spring"
  },
  State_66562_Desc = {
    Text = "Every 4 turns, double the DMG received by all enemies this turn. However, after releasing Exalt in this turn, seal all Awakeners for 1 turn."
  },
  State_66562_Name = {
    Text = "Pathwalker's Remains"
  },
  State_66563_Desc = {
    Text = "At turn start, if you played more than 3 cards last turn, draw 2 cards."
  },
  State_66563_Name = {
    Text = "Brand-New Wallet"
  },
  State_66564_Desc = {
    Text = "Upon picking up, gain 3 Arithmetica."
  },
  State_66564_Name = {
    Text = "Pocketwatch Mirror"
  },
  State_66565_Desc = {
    Text = "When picked up, impose 1 turn of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> to all enemies."
  },
  State_66565_Name = {
    Text = "Shifting Straitjacket"
  },
  State_66566_Desc = {
    Text = "At turn start, <DeathResistanceIconKeywords:Death Resistance> increases by 10% (each time Death Resistance triggers in this level, the gained Death Resistance is halved). When <DeathResistanceIconKeywords:Death Resistance> is above 100%, <ProficientInRealmsIconKeywords:Realm Mastery> increases by 100."
  },
  State_66566_Name = {
    Text = "Siren's Tear"
  },
  State_66703_Desc = {
    Text = "Team Unique: Keyflare Cap +100%. Hand Limit +2, cannot stack with other WoDs with the same effect. Increases the wielder's Keyflare Regen by <WeaponEffect_Num:[StateArg1]%>. After the wielder plays a card, in this turn, the Crit. Rate, Crit. DMG, Shield Generation, Aliemus Generation, and STR Generation of the wielder's Command Cards +<WeaponEffect_Num:[StateArg2]%>, stacking up to 5 times."
  },
  State_66703_WeaponDesc = {
    Text = "Keyflare Cap +100%. Hand Limit +2, cannot stack with other WoDs with the same effect. Increases the wielder's Keyflare Regen by <WeaponEffect_Num:[DescArg2]>. After the wielder plays a card, the Crit. Rate and Crit. DMG, Shield Generation, Aliemus, and Strength of the wielder's Command Cards increase by <WeaponEffect_Num:[StateArg2]%> for this turn, stacking up to 5 stacks (currently [DescArg1] stacks)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped and at turn start, if there is no <PVPProtectiveKeywords:Barrier>, obtain [StateArg1] stacks of <PVPProtectiveKeywords:Barrier>; otherwise gain <StrengthenKeywords:Enhance>."
  },
  State_66722_Name = {
    Text = "Wheel Unseen"
  },
  State_66872_Desc = {
    Text = "The Damage, Shield, and HP recovery provided by Tawil are temporarily increased by [StateArg1]%, lasting [Layer] turns."
  },
  State_66872_Name = {
    Text = "Infinite Radiant Brilliance"
  },
  State_66883_Name = {
    Text = "Gain [Layer] Arithmetica, draw [Layer] cards."
  },
  State_66884_Desc = {
    Text = "At turn end, Arithmetica Cost decreases, and the effect is triggered even if discarded."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:Prepare 1>"
  },
  State_66888_Desc = {
    Text = "Team Unique: Upon releasing Posse, gain <WeaponEffect_Num:[StateArg1]%> of the wielder's ATK as <PowerIconKeywords:STR> and Shield equal to <WeaponEffect_Num:[StateArg2]%> of their DEF. Upon using an Emergency Gnosis, all Awakeners gain <WeaponEffect_Num:[StateArg3]> Aliemus at turn end."
  },
  State_66888_WeaponDesc = {
    Text = "After releasing the Posse, obtain <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:STR> and <WeaponEffect_Num:[Block:DescArg2]> Shield. After using Emergency Gnosis, all Awakeners obtain <WeaponEffect_Num:[StateArg3]> Aliemus at the turn ended."
  },
  State_66893_Desc = {
    Text = "Team Unique: After the start of the battle, gain Keyflare equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's Keyflare Regen. The first Posse issuance in each battle repeats this effect."
  },
  State_66893_WeaponDesc = {
    Text = "After the battle begins, obtain <WeaponEffect_Num:[DescArg1]> Keyflare. After the first time you release a Posse in each battle, this effect triggers again."
  },
  State_66896_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_66900_Desc = {
    Text = "This card's Damage, Healing, and Shield Generation +[StateArg1]%"
  },
  State_66900_Name = {
    Text = "Heart of Silver"
  },
  State_66901_Desc = {
    Text = "Command Card and Exalt DMG, Healing, Shield +[DescArg1]% for 1 turn."
  },
  State_66901_Name = {
    Text = "Temporary Amplification"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When an ally Awakener dies, gain <Block:[Block:StateArg1]> Shield, draw their lowest-cost \"Skill\" card."
  },
  State_66902_Name = {
    Text = "Heart of Silver"
  },
  State_66971_Desc = {
    Text = "When HP drops to 0, set HP to 1, and it won't take any more Damage."
  },
  State_66971_Name = {
    Text = "World Severance"
  },
  State_67234_Desc = {
    Text = "At turn end, summon a \"Brain in a Vat Clone\", lasting [Layer] turns."
  },
  State_67234_Name = {Text = "Separation"},
  State_67235_Desc = {
    Text = "Upon death, restore all HP, Max HP +100%, release \"Soulblight\"."
  },
  State_67235_Name = {Text = "Not Roused"},
  State_67237_Desc = {
    Text = "Upon reaching level 10, the intention changes to \"Illusion's End\": reduces the opponent's maximum HP to 1."
  },
  State_67237_Name = {Text = "Finale"},
  State_67238_Desc = {
    Text = "At turn end, gain 1 stack of \"End\". After receiving Fatal DMG, remove this state, become immune to DMG for 1 turn, restore 15% HP, and gain 10 stacks of \"End\"."
  },
  State_67238_Name = {Text = "Soulblight"},
  State_67240_Desc = {
    Text = "\"Sage\" gains 25 stacks of Temporary <ReinforcePVEKeywords:Fortress> and [Power:StateArg1] Temporary <PowerIconKeywords:STR>, then removes this State."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Inference>"
  },
  State_67241_Desc = {
    Text = "Upon death, restore all HP, Max HP +100%, release \"Knight's Zeal\"."
  },
  State_67241_Name = {Text = "Not Roused"},
  State_67242_Desc = {
    Text = "Upon death, restore all HP, Max HP +100%, release \"Flesh De@1ched\"."
  },
  State_67242_Name = {Text = "Not Roused"},
  State_67243_Desc = {
    Text = "At turn end, summon a \"Brain in a Vat Clone\". When the \"Brain in a Vat\" clone triggers \"Spirit Separation\", it additionally steals 5% of your STR."
  },
  State_67243_Name = {
    Text = "Flesh De@1ched"
  },
  State_67245_Desc = {
    Text = "At turn end, gain [StateArg1] <PowerIconKeywords:STR>."
  },
  State_67245_Name = {
    Text = "Knight's Zeal"
  },
  State_67246_Desc = {
    Text = "Each time your shield is first broken in a turn, lose 25% of your Max HP and gain [Power:DescArg1] <PowerIconKeywords:Temporary STR> and [Layer] stacks of Temporary Fortress. At the start of next turn, regain <Block:[Block:DescArg2]> stacks of Shield. Each time \"Knight's Creed\" is triggered, gain an additional stack of Shield."
  },
  State_67246_Name = {
    Text = "Knight's Faith"
  },
  State_67247_Desc = {
    Text = "At the end of each turn, enemies will be replenished, up to 2 at the same time. When an enemy dies, \"Corrupted Brain\" loses 5% Max HP."
  },
  State_67247_Name = {Text = "Abyss Gate"},
  State_67252_Desc = {
    Text = "When taking Fatal DMG, move to the back row and retain 1 HP, then become immune to all further Damage. <PowerIconKeywords:STR> increases by [DescArg1]. Self-Destruct does not trigger this effect."
  },
  State_67252_Name = {
    Text = "Spirit Separation"
  },
  State_67253_Desc = {
    Text = "After playing [Layer] cards, generate 1 \"Brain in a Vat Clone\" in front, with a maximum of 3 clones existing simultaneously."
  },
  State_67253_Name = {
    Text = "Brain in a Vat"
  },
  State_67255_Desc = {
    Text = "Upon death, restore all HP, Max HP +100%, release \"First Doctrine\"."
  },
  State_67255_Name = {Text = "Not Roused"},
  State_67256_Desc = {
    Text = "After the draw phase, randomly reveal three Command Cards from your hand, choose one to grant the \"Echo\" Orison, and discard the others."
  },
  State_67256_Name = {
    Text = "First Doctrine"
  },
  State_67257_Desc = {
    Text = "After releasing a Posse for the first time each turn, all Awakeners gain 10 Aliemus, but the cost to release a Posse permanently increases by 10%."
  },
  State_67257_Name = {
    Text = "Gradually Breaking Link"
  },
  State_67258_Desc = {
    Text = "At the start of battle, gain <Block:[Block:DescArg1]> stacks of Shield. The Shield will not disappear at turn end."
  },
  State_67258_Name = {
    Text = "Knight's Resolve"
  },
  State_67347_Desc = {
    Text = "While in hand, if the top card of the Draw Pile is a Command Card, it becomes a copy of it with -1 Arithmetica Cost."
  },
  State_67347_Name = {
    Text = "Omniscient Verity"
  },
  State_67353_Desc = {
    Text = "Upon death, the \"Corrupted Brain\" loses 5% Max HP."
  },
  State_67353_Name = {Text = "Meltdown"},
  State_67358_Desc = {
    Text = "Whenever you consume 1 Arithmetica, immediately gain <Block:[Block:StateArg1]> Shield and 3 stacks of Temporary Fortress."
  },
  State_67358_Name = {
    Text = "Unstable Barrier"
  },
  State_67390_Name = {
    Text = "Gain [Layer] Arithmetica"
  },
  State_67392_Name = {
    Text = "Gain [Block:DescArg1] Shield"
  },
  State_67393_Name = {
    Text = "Inflict [Layer] turns of Vulnerable on all enemies"
  },
  State_67394_Name = {
    Text = "Gain [Energy:DescArg1] Aliemus"
  },
  State_67395_Name = {
    Text = "Inflict [Layer] turns of Weakness on all enemies"
  },
  State_67396_Name = {
    Text = "Draw [Layer] cards"
  },
  State_67414_Desc = {
    Text = "Eyes that must not be gazed upon. An aura that must not be defied. Fragments of everything are still merely fragments. Now, face the destined destruction..."
  },
  State_67414_Name = {
    Text = "Face the Myriad of Genesis"
  },
  State_67418_Desc = {
    Text = "Upon use, discard all cards in hand that does not belong to this Awakener. Gain 5 non-Command Cards. Takes effect once per battle."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:Adv. Lex Volis>"
  },
  State_67419_Desc = {
    Text = "Upon use, gain 3 Base Copies with <RetainIconKeywords:Retain> and <DepleteIconKeywords:Exhaust> attached, with -1 Arithmetica Cost. Takes effect once per battle."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:Adv. Lex Genis>"
  },
  State_67420_Desc = {
    Text = "Upon use, draw 4 cards, reducing their Arithmetica Cost by the amount of the Orisoned Card's Arithmetica Cost. Takes effect once per battle."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Adv. Lex Nous>"
  },
  State_67598_Desc = {
    Text = "After releasing Exalt, add a random card corresponding to the Awakener to your hand. The card obtains <DepleteIconKeywords:Exhaust> and <NothingnessIconKeywords:Fleeting>. After the battle ends, restore [DescArg1] HP."
  },
  State_67598_Name = {
    Text = "Doctor's Case"
  },
  State_67599_Desc = {
    Text = "After playing a Command Card that is not \"Strike\" or \"Defense\", the corresponding Awakener gains 15 Aliemus, triggering a maximum of 5 times each turn. The first trigger each turn will also return the played card to the hand."
  },
  State_67599_Name = {
    Text = "Chrono Pendulum: Projection"
  },
  State_67600_Desc = {
    Text = "Max Arithmetica +4. Each time the deck is reset, add 4 <DerivativeCardKeywords_4:\"Insight\"> to the Draw Pile."
  },
  State_67600_Name = {
    Text = "Blessed: Black Candle"
  },
  State_67602_Name = {Text = "Obsolete"},
  State_67603_Desc = {
    Text = "Deal 20% more DMG to enemies with debuffs, and gain 20 Aliemus upon killing them."
  },
  State_67603_Name = {
    Text = "Hierophant's Staff"
  },
  State_67604_Desc = {
    Text = "Each time a Command Card belonging to a different Awakener than the last one played is played, that Awakener gains 3 Aliemus and accumulates 1 stack of \"Vitality\". Upon accumulating 10 stacks, all \"Vitality\" is cleared, and one random Command Card with \"Exhaust\" and Arithmetica Cost reduced by 1 is placed in hand for each Awakener. This effect can activate a maximum of 1 time per turn."
  },
  State_67604_Name = {
    Text = "Chrono Pendulum: Evolution"
  },
  State_67605_Desc = {
    Text = "When you have a shield, this Relic provides [DescArg1] Temporary <PowerIconKeywords:STR>. If your Shield is higher than your Current HP, it provides an additional [DescArg2] Temporary <PowerIconKeywords:STR>."
  },
  State_67605_Name = {
    Text = "Dove Feather Fan"
  },
  State_67606_Desc = {
    Text = "At turn start, obtain 1 Arithmetica for each enemy. When an enemy is killed by Active DMG, inflict <BleedingIconKeywords:Bleed> on other enemies equal to the excess Damage."
  },
  State_67606_Name = {Text = "Mob Song"},
  State_67607_Desc = {
    Text = "After releasing 5 Exalts, the Awakener who released the Exalts gains 100 Aliemus."
  },
  State_67607_Name = {
    Text = "Tiny Cradle"
  },
  State_67608_Name = {Text = "Obsolete"},
  State_67609_Desc = {
    Text = "After releasing Exalt, lose 8% of current HP, steal [DescArg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [DescArg2] Temporary <PowerIconKeywords:STR>."
  },
  State_67609_Name = {
    Text = "Omen Ritual Bird"
  },
  State_67611_Desc = {
    Text = "Every 2 turns, double the DMG all enemies receive, and randomly dispel 1 debuff for each Exalt used this turn."
  },
  State_67611_Name = {
    Text = "Blessed: Pathwalker's Remains"
  },
  State_67612_Desc = {
    Text = "All \"Strike\" Crit. DMG is increased by 20%. Upon picking up, add 1 <DerivativeCardKeywords_40:\"Fleeting Beauty\"> to your hand."
  },
  State_67612_Name = {
    Text = "Fleeting Beauty β"
  },
  State_67614_Desc = {
    Text = "At turn start, all Awakeners gain 25 Aliemus. When picked up, Max HP becomes 1.5 times."
  },
  State_67614_Name = {
    Text = "Blessed: Nightmare Manifest β"
  },
  State_67615_Desc = {
    Text = "Playing the 6th Command Card returns it to your hand from the Discard Pile."
  },
  State_67615_Name = {
    Text = "In Twilight"
  },
  State_67616_Name = {Text = "Obsolete"},
  State_67618_Desc = {
    Text = "At turn start, all Awakeners gain 25 Aliemus. When picked up, Max HP becomes 1.5 times."
  },
  State_67619_Desc = {
    Text = "Hand Limit +5. Upon picking up, fill your hand with cards. At turn start, draw 1 additional card. At turn end, discard all Symptom Cards and State Cards in hand, keep other cards."
  },
  State_67619_Name = {
    Text = "Blessed: Mind Engraving β"
  },
  State_67620_Desc = {
    Text = "After playing the 3rd card each turn, place 1 <DerivativeCardKeywords_4:\"Insight\"> into the Discard Pile. After playing the 6th card each turn, place 1 <DerivativeCardKeywords_4:\"Insight\"> from the Discard Pile into hand."
  },
  State_67620_Name = {
    Text = "Light of Civilization"
  },
  State_67621_Desc = {
    Text = "After releasing Exalt, gain [DescArg1] Temporary STR and steal [DescArg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [DescArg2] Temporary <PowerIconKeywords:STR>."
  },
  State_67621_Name = {
    Text = "Blessed: Omen Ritual Bird"
  },
  State_67622_Desc = {
    Text = "When you deplete the last 1 Arithmetica, gain 2 Arithmetica. Maximum 2 triggers per turn."
  },
  State_67622_Name = {
    Text = "Differential Engine"
  },
  State_67623_Desc = {
    Text = "Permanently gain [DescArg1] <PowerIconKeywords:STR> after picking up. Whenever you deal Damage, heal for [DescArg2] HP, with a maximum of 6 triggers per turn."
  },
  State_67623_Name = {
    Text = "Blessed: Lamprey Kiss"
  },
  State_67624_Name = {Text = "Obsolete"},
  State_67625_Desc = {
    Text = "When a Command Card first enters the Discard Pile each turn, shuffle a Temporary copy of it with Arithmetica Cost reduced by 1 into the Draw Pile."
  },
  State_67625_Name = {
    Text = "Mute Jukebox"
  },
  State_67626_Desc = {
    Text = "Max Arithmetica +1. When you play 2 cards with Arithmetica Costs higher than the previous card in succession, gain 1 Arithmetica."
  },
  State_67626_Name = {
    Text = "Arcana Archive"
  },
  State_67628_Name = {Text = "Obsolete"},
  State_67630_Name = {Text = "Obsolete"},
  State_67631_Desc = {
    Text = "Max Arithmetica +2. Each time the deck is reset, add 1 <DerivativeCardKeywords_9:\"Stagger\"> to the Draw Pile."
  },
  State_67631_Name = {
    Text = "Black Candle"
  },
  State_67632_Name = {Text = "Obsolete"},
  State_67634_Desc = {
    Text = "At turn end, for each unplayed card in hand, all Awakeners gain 2 Aliemus."
  },
  State_67634_Name = {
    Text = "Tilted Scales"
  },
  State_67635_Desc = {
    Text = "When picked up, all Awakeners gain 50 Aliemus, and shuffle 2 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into the Draw Pile."
  },
  State_67635_Name = {
    Text = "Signal Relay +β"
  },
  State_67636_Desc = {
    Text = "Crit. DMG +15%. Guaranteed Critical Hits against Shielded enemies."
  },
  State_67636_Name = {
    Text = "Principles of Aesthetics"
  },
  State_67637_Desc = {
    Text = "At turn start, draw 2 cards and gain 2 Arithmetica. Whenever you draw a Command Card or experience Rouse, randomly alter its Arithmetica Cost. (0-4)"
  },
  State_67637_Name = {
    Text = "Trickster's Hat"
  },
  State_67638_Desc = {
    Text = "Deal 50% more DMG to enemies with debuffs, and gain 100 Aliemus upon killing them."
  },
  State_67638_Name = {
    Text = "Hierophant's Staff +"
  },
  State_67639_Desc = {
    Text = "Crit. Rate increased by 50%, Crit. DMG increased by 100%."
  },
  State_67639_Name = {
    Text = "Blessed: Eerie Hook"
  },
  State_67640_Desc = {
    Text = "Crit. Rate and Crit. DMG +100%. For each instance of DMG/Tentacle DMG dealt this turn, all Awakeners' Crit. Rate and Crit. DMG -10%, up to 50%. Poison and counter DMG +10%, up to 50%."
  },
  State_67640_Name = {
    Text = "Chrono Pendulum: Surge"
  },
  State_67641_Desc = {
    Text = "After releasing Exalt, obtain [DescArg1] Temporary <PowerIconKeywords:STR>."
  },
  State_67641_Name = {Text = "Iron Lock"},
  State_67643_Desc = {
    Text = "Obtain [DescArg1] Shield when dealing Active DMG. Obtain [DescArg2] Temporary <PowerIconKeywords:STR> when recovering HP."
  },
  State_67643_Name = {Text = "Our Home"},
  State_67645_Desc = {
    Text = "Crit. Rate +10%. After the first Critical Hit each turn, increase Crit. Rate by an extra 20%. After the 3rd Critical Hit each turn, increase Crit. DMG by an extra 50%."
  },
  State_67645_Name = {
    Text = "Festive Benediction"
  },
  State_67646_Desc = {
    Text = "At the end of odd turns, if there is remaining Arithmetica, draw 2 extra cards next turn; at the end of even turns, if there are remaining cards, gain 2 extra Arithmetica next turn."
  },
  State_67646_Name = {Text = "Solar Disc"},
  State_67647_Desc = {
    Text = "Every 5th Command Card you play will take effect twice and return to your hand after being played."
  },
  State_67647_Name = {
    Text = "Stellar Brew+"
  },
  State_67649_Desc = {
    Text = "Hide monster intentions. Gain 1 Arithmetica each turn and draw 1 card."
  },
  State_67649_Name = {
    Text = "Enthralling Chime"
  },
  State_67650_Desc = {
    Text = "\"Attack\"and \"Defense\"gain an additional 50 Keyflare. Each time you play a card with an Arithmetica Cost of 2 or more, draw a card with an Arithmetica Cost of 1 and reduce its cost to 0, up to 3 times per turn."
  },
  State_67650_Name = {
    Text = "Chrono Pendulum: Twins"
  },
  State_67651_Desc = {
    Text = "When picked up, the team's Realm Mastery increases to 150% of its base value. After playing the 5th Command Card each turn, all Awakeners gain 20 Aliemus."
  },
  State_67651_Name = {
    Text = "Chrono Pendulum: Unclean"
  },
  State_67653_Desc = {
    Text = "After releasing 2 Exalts each turn, all Awakeners gain 8 Aliemus. After releasing 3 Exalts, all Awakeners gain an additional 8 Aliemus."
  },
  State_67653_Name = {
    Text = "Forsaken Blood"
  },
  State_67654_Name = {Text = "Obsolete"},
  State_67656_Desc = {
    Text = "Crit. Rate increased by 50%, <FragileIconKeywords:Fragile> self for 3 turns."
  },
  State_67656_Name = {Text = "Eerie Hook"},
  State_67657_Desc = {
    Text = "Draw 1 card at turn start. Draw 1 additional card if you play 2 cards with the same Arithmetica Cost consecutively, up to 3 times per turn."
  },
  State_67657_Name = {
    Text = "Gnosis Device"
  },
  State_67658_Desc = {
    Text = "When you play a card with an actual Arithmetica Cost of 3, draw 1 card and gain 2 Arithmetica; when you play a card with an actual Arithmetica Cost of 4 or more, reduce the Arithmetica Cost of other cards in your hand by 1."
  },
  State_67658_Name = {
    Text = "Chrono Pendulum: Eye"
  },
  State_67659_Desc = {
    Text = "At turn start, obtain 2 Arithmetica for each enemy. When an enemy is killed by Active DMG, deal double excess DMG to other enemies as <BleedingIconKeywords:Bleed>."
  },
  State_67659_Name = {Text = "Mob Song +"},
  State_67660_Desc = {
    Text = "Every third time \"Strike\" is played, deal [DescArg1] DMG to all enemies. The corresponding Awakener gains 15 Aliemus."
  },
  State_67660_Name = {
    Text = "Rusty Lancet"
  },
  State_67661_Desc = {
    Text = "Draw 1 card each time Arithmetica is spent, up to 5 times per turn. Gain 2 Arithmetica whenever the deck is reshuffled."
  },
  State_67661_Name = {
    Text = "Chrono Pendulum: Sleepless"
  },
  State_67662_Desc = {
    Text = "When you play a Buff Card, Symptom Card, or State Card, the Awakener with the lowest Aliemus gains 10 Aliemus."
  },
  State_67662_Name = {
    Text = "Foreign Stamp Album"
  },
  State_67665_Desc = {
    Text = "Max Arithmetica increases by 2. After playing \"Strike\" or \"Defense\", the corresponding Awakener gains 5 Aliemus. After releasing Exalt, gain 1 \"Strike\" of the corresponding Awakener with Exhaust and Fleeting attached. After releasing Posse, randomly gain a \"Defense\" with Exhaust and Fleeting."
  },
  State_67665_Name = {
    Text = "Chrono Pendulum: Wings"
  },
  State_67666_Desc = {
    Text = "Each time you deal Damage, gain [DescArg1] Temporary <PowerIconKeywords:STR>, stacking up to 3 times. When fully stacked, the effect is doubled."
  },
  State_67666_Name = {
    Text = "Filigree Agate"
  },
  State_67667_Desc = {
    Text = "After the turn ends, all Awakeners gain 5 Aliemus. For each remaining Arithmetica, all Awakeners gain an additional 3 Aliemus."
  },
  State_67667_Name = {
    Text = "Proto Battery"
  },
  State_67668_Desc = {
    Text = "Crit. DMG increased by 15%. \"Strike\" Crit. Rate increased by 40%."
  },
  State_67668_Name = {
    Text = "Ivory Raven Beak"
  },
  State_67669_Name = {Text = "Obsolete"},
  State_67670_Desc = {
    Text = "After releasing an Exalt, draw 1 card. If HP is below 25%, draw an additional card."
  },
  State_67670_Name = {
    Text = "Knowledge Wheel"
  },
  State_67671_Desc = {
    Text = "For each Active DMG dealt, restore [DescArg1] HP and Inflict [DescArg2] stacks of <BleedingIconKeywords:Bleed> to the DMG target."
  },
  State_67671_Name = {
    Text = "Blessed: Swarm Mind"
  },
  State_67672_Desc = {
    Text = "The <WeaknessIconKeywords:Weakness> effect is increased by 8%, and the <VulnerabilityIconKeywords:Vulnerable> effect is increased by 25%. When applying <WeaknessIconKeywords:Weakness> or <VulnerabilityIconKeywords:Vulnerable>, temporarily steal [DescArg1] <PowerIconKeywords:STR> from the target."
  },
  State_67672_Name = {
    Text = "Faded Photo +"
  },
  State_67673_Desc = {
    Text = "Draw 1 card at turn start."
  },
  State_67673_Name = {
    Text = "True North Compass"
  },
  State_67674_Desc = {
    Text = "Obtain [DescArg2]% <DeathResistanceIconKeywords:Death Resistance> each time you play a Command Card (each trigger of Death Resistance in this level will halve the gained Death Resistance). If your <DeathResistanceIconKeywords:Death Resistance> is greater than or equal to 100%, gain [DescArg1] Temporary Strength instead."
  },
  State_67674_Name = {
    Text = "Serpent's Husk"
  },
  State_67675_Desc = {
    Text = "At turn end, if there is remaining Arithmetica, draw 2 extra cards next turn; if there are remaining cards in hand, gain 2 extra Arithmetica next turn."
  },
  State_67675_Name = {
    Text = "Solar Disc+ +"
  },
  State_67677_Desc = {
    Text = "When you inflict <WeaknessIconKeywords:Weakness>, gain [DescArg1] shield; when you inflict <VulnerabilityIconKeywords:Vulnerable>, gain [DescArg2] temp <PowerIconKeywords:STR>. If both effects are triggered within 1 turn, gain an additional [DescArg1] shield and [DescArg2] temp <PowerIconKeywords:STR>."
  },
  State_67677_Name = {
    Text = "Gilded Frame"
  },
  State_67703_Desc = {
    Text = "At turn start, if more than 3 cards remained in hand during the last turn, gain 2 Arithmetica."
  },
  State_67703_Name = {
    Text = "Mythag Insignia"
  },
  State_67704_Desc = {
    Text = "Upon releasing the Exalt, gain 10 Aliemus for the corresponding Awakener and receive [DescArg1] Shield."
  },
  State_67704_Name = {
    Text = "Veil of the Nameless Deity"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Omniscient Verity>: Restore after use and gain <Energy:[StateArg1]> Aliemus"
  },
  State_67841_WeaponDesc = {
    Text = "Change the card's Arithmetica before playing"
  },
  State_67844_Desc = {
    Text = "After taking Fatal DMG, recover all HP. Can be triggered @1 time. Currently triggered [DescArg1] times."
  },
  State_67844_Name = {
    Text = "Primordial Chaos"
  },
  State_68298_Desc = {
    Text = "After receiving Fatal DMG, convert intention into \"Gaze of Deepspace\" and gain 80 stacks of Temporary Fortress, restoring all HP. Can trigger [DescArg1] times. At turn end, remove 20 stacks of Fortress."
  },
  State_68298_Name = {Text = "Stardust"},
  State_68554_Desc = {
    Text = "Regain all HP after receiving Fatal DMG, and remove this State after all other enemies are dead. Can be triggered @1 time, currently triggered [DescArg1] times."
  },
  State_68554_Name = {
    Text = "Ancient Chaos Debris"
  },
  State_68621_Desc = {
    Text = "At the start of the battle and at the end of each turn, gain 2 stacks of \"Temporary Chains of Resentment\"."
  },
  State_68621_Name = {
    Text = "Flow of Deceit"
  },
  State_68622_Desc = {
    Text = "The Strength effect applied by the Awakener is reduced by 75%. Each time HP is lost, gain [DescArg1] Shield and 1 stack of Temporary Fortress."
  },
  State_68622_Name = {
    Text = "Flow of Heresy"
  },
  State_68623_Desc = {
    Text = "For each Command Card played, discard one card with the lowest Arithmetica Cost from this Awakener."
  },
  State_68623_Name = {
    Text = "Flow of Madness"
  },
  State_68624_Desc = {
    Text = "At turn end, restore 10% of lost HP, and remove its own debuff & your buffs."
  },
  State_68624_Name = {
    Text = "Flow of Birth"
  },
  State_68626_Desc = {
    Text = "The Base Aliemus of all Awakeners increases by 50%. At the end of each turn, deduct 10 Aliemus from all Awakeners and restore 3% of their Max HP."
  },
  State_68626_Name = {
    Text = "Flow of Fear"
  },
  State_68627_Desc = {
    Text = "At the start of the battle, gain 15 stacks of \"Temporary Barrier\". At turn end, gain 15 stacks of \"Temporary Barrier\", applying \"Temporary Dissolve\" to 10 random cards."
  },
  State_68627_Name = {
    Text = "Flow of Scathe"
  },
  State_68632_Desc = {
    Text = "The Arithmetica Cost of all Command Cards increases by 1. At the end of every 3 turns, draw 1 \"Gradually Petrify\" into hand"
  },
  State_68632_Name = {
    Text = "Flow of Sorrow"
  },
  State_68637_Desc = {
    Text = "When losing HP, lose the same amount of stacks. At 0 stacks, grant you 2 stacks of Temporary Barrier, and gain [DescArg1] Shield, [DescArg2] Temporary Fortress and regain [DescArg3] stacks of Dimensional Barrier."
  },
  State_68637_Name = {
    Text = "Dimensional Barrier"
  },
  State_68646_Desc = {
    Text = "Base DMG and Shield value increased by 200%, but will be exhausted after use."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Temporary Melt>"
  },
  State_68680_Desc = {
    Text = "Remove Ancient Debris"
  },
  State_68680_Name = {
    Text = "Remove Ancient Debris"
  },
  State_68704_Desc = {
    Text = "There are still [DescArg1] turns until Tohuwabohu's true Arrival..."
  },
  State_68704_Name = {
    Text = "The Arrival"
  },
  State_68829_Desc = {
    Text = "When attacked, become immune to DMG and reduce by 1 stack. Removed at turn start."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:Temporary Barrier>"
  },
  State_68829_WeaponDesc = {
    Text = "DMG taken is reduced by 99%. Each time DMG is taken, 1 stack is reduced."
  },
  State_70026_Desc = {
    Text = "This card has \"Retain\". Temporarily increases the Crit. Rate of all Awakeners by [StateArg1]% when played, and removes \"Undying Reign\". If the current Realm is Aequor, after removing \"Undying Reign\", gain 1 Arithmetica."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Undying Reign>"
  },
  State_70031_Desc = {
    Text = "Team Unique: At the start of the battle, grant the \"Immortal Dominion\" effect to all Command Cards in the Draw Pile with Arithmetica consumption greater than or equal to 3. This card has the \"Retain\" effect. After being played, all Awakeners temporarily increase their Crit. Rate by <WeaponEffect_Num:[StateArg1]%> and remove \"Immortal Dominion.\" If the current Realm is Aequor, gain 1 Arithmetica after \"Immortal Dominion\" is removed."
  },
  State_70031_WeaponDesc = {
    Text = "At the start of battle, grant all Command Cards in the wielder's Draw Pile with an Arithmetica Cost greater than or equal to 3 the \"Undying Reign\" effect: this card has \"Retain,\" and after playing it, all Awakeners temporarily gain a Crit. Rate increase of <WeaponEffect_Num:[StateArg1]%> and \"Undying Reign\" is removed. If the current realm is Aequor, obtain 1 Arithmetica after \"Undying Reign\" is removed."
  },
  State_70182_Desc = {
    Text = "All Shield gained are reduced by [DescArg1]%."
  },
  State_70182_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_70182_WeaponDesc = {
    Text = "All Shield obtained are reduced by 33%."
  },
  State_70277_Desc = {
    Text = "After being attacked, [StateArg1]% of the DMG will be converted into the recovery amount for the Crimson Furnace, lasting for [Layer] turns."
  },
  State_70277_Name = {
    Text = "Rite of Creation"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, increase the DMG, Healing, and Shield of the wielder's \"Skill\" cards in your hand by [StateArg1]%."
  },
  State_70287_Name = {
    Text = "Blue Stone Throne"
  },
  State_70288_Desc = {
    Text = "The Damage, healing, and Shielding provided by this card are increased by [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Blue Stone Throne"
  },
  State_70313_Desc = {
    Text = "During Boss Battles, at turn start and after \"Doll of Meltdown\" triggers Exalt, gain 1 stack of \"<Zhongmowuqiling:Finale>\". \"Finale\" can stack up to 10 times, and upon reaching 10 stacks, place 1 \"Illusion's End\" card into hand."
  },
  State_70313_Name = {
    Text = "Path of Annihilation"
  },
  State_70318_Desc = {
    Text = "Inflict [StateArg1] turns of <VulnerabilityIconKeywords:Vulnerable> to all enemies, obtain 1 turn of \"Elation\" State: Team DMG Amplification is increased by [StateArg2]%."
  },
  State_70318_Name = {Text = "Elation"},
  State_70322_Desc = {
    Text = "When you have 10 stacks of Finale, place 1 \"Illusion's End\" into hand."
  },
  State_70322_Name = {Text = "Finale"},
  State_70330_Desc = {
    Text = "Gain 1 turn of \"Elation\" state: Team DMG Amplification increased by [StateArg2]%."
  },
  State_70330_Name = {Text = "Elation"},
  State_70346_Desc = {
    Text = "Inflict <WeaknessIconKeywords:Weakness> to all enemies for [StateArg1] turns, and decrease their <PowerIconKeywords:STR> by [Exhaustion:StateArg3] this turn."
  },
  State_70346_Name = {Text = "Curse"},
  State_70347_Desc = {
    Text = "Reduce all enemies' [Exhaustion:StateArg3] <PowerIconKeywords:STR> this turn."
  },
  State_70347_Name = {Text = "Curse"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Upon receiving the first attack each turn, the wielder character inflicts <PVPEmptinessKeywords:Void> on the attacker."
  },
  State_70374_Name = {
    Text = "Manikin of Oblivion"
  },
  State_70443_Desc = {
    Text = "When you have 10 stacks of Finale, place 1 \"Illusion's End\" into hand."
  },
  State_70443_Name = {Text = "Finale"},
  State_70589_Desc = {
    Text = "When playing 2 consecutive cards with lower Arithmetica Cost than the previous, apply 40/80 Poison to all enemies. (Max 5 triggers per turn)"
  },
  State_70590_Desc = {
    Text = "After using Embryo directly for the first time each turn, Active DMG dealt this turn will cause Bleed equivalent to 15/30% of the Damage."
  },
  State_70593_Desc = {
    Text = "After playing a non-Derived Command Card, reduce the Arithmetica Cost of that card by 2 and shuffle 1/2 Temporary copies of it into the Draw Pile. This effect has a cooldown of 3 turns."
  },
  State_70594_Desc = {
    Text = "At turn end, if in the Surging Tides stance, gain 32/64 Tentacle DMG, with a cooldown of 3 turns."
  },
  State_70595_Desc = {
    Text = "At the start of the battle, apply 1280 Poison to all enemies, doubling the effect in Boss Battles."
  },
  State_70598_Desc = {
    Text = "Whenever a card enters Ultra Space, if this card belongs to a different owner than other cards in Ultra Space, place 1/2 of the Inspiration in hand."
  },
  State_70600_Desc = {
    Text = "At turn end, restore 32 HP."
  },
  State_70602_Desc = {
    Text = "Draw 4 cards after Keyflare Rouse."
  },
  State_70603_Desc = {
    Text = "All Awakeners gain 10 Aliemus after Keyflare Rouse."
  },
  State_70605_Desc = {
    Text = "Gain 32 Strength Keyflare Rouse."
  },
  State_70607_Desc = {
    Text = "When you play two consecutive cards with a higher Arithmetica Cost than the previous one, gain 24/48 Counter. This effect can trigger up to 5 times per turn."
  },
  State_70609_Desc = {
    Text = "Gain 96 Shield after Keyflare Rouse."
  },
  State_70611_Desc = {
    Text = "Increase the Base DMG dealt by all Awakeners by 25%/50% after performing a Keyflare Rouse."
  },
  State_70617_Desc = {
    Text = "Increase the DMG of the first five hits dealt each turn by 15%/30%."
  },
  State_70618_Desc = {
    Text = "Draw 1 card at turn start."
  },
  State_70619_Desc = {
    Text = "\"Strike\" inflicts 10%/20% Poison DMG, dealing up to 320/640 points per turn."
  },
  State_70620_Desc = {
    Text = "When attacked by enemies, inflict a Fixed DMG equal to 25%/50% of our Max HP. This DMG enjoys a 100%/200% Counter bonus and can trigger a maximum of once per enemy each turn."
  },
  State_70621_Desc = {
    Text = "Gain 192 Shield after Keyflare Rouse."
  },
  State_70623_Desc = {
    Text = "All Awakeners gain 10 Aliemus at turn start."
  },
  State_70624_Desc = {
    Text = "All Awakeners gain 20 Aliemus after Keyflare Rouse."
  },
  State_70628_Desc = {
    Text = "At turn start, draw 2 cards."
  },
  State_70629_Desc = {
    Text = "On the first Devour each turn, other Awakeners gain 10/20 Aliemus."
  },
  State_70635_Desc = {
    Text = "Gain 416 Counter after Keyflare Rouse."
  },
  State_70636_Desc = {
    Text = "The Crimson Furnace grants 10%/20% of the HP loss amount upon losing a HP."
  },
  State_70637_Desc = {
    Text = "At the beginning of the battle, increase the Tentacle Limit by 1/2 and gain 1/2 of a Tentacle."
  },
  State_70641_Desc = {
    Text = "Gain 160/320 Shield from Annihilation, with a cooldown of 3 turns."
  },
  State_70643_Desc = {
    Text = "At turn start, gain 1 Arithmetica."
  },
  State_70644_Desc = {
    Text = "After unleashing Exalt, gain 16/32 Temporary STR."
  },
  State_70645_Desc = {
    Text = "At turn start, gain 2 Arithmetica."
  },
  State_70647_Desc = {
    Text = "All Awakeners increase Base DMG by 30%."
  },
  State_70648_Desc = {
    Text = "At the start of the battle, apply 640 Poison to all enemies, doubling the effect in Boss Battles."
  },
  State_70656_Desc = {
    Text = "\"Strike\" deals an additional 1/2 instance of DMG equal to 60% of the Awakener's Attack, triggering up to 3 times per turn."
  },
  State_70657_Desc = {
    Text = "At the start of the battle, gain 32 Strength."
  },
  State_70660_Desc = {
    Text = "At the start of the battle, gain 64 Strength."
  },
  State_70661_Desc = {
    Text = "At turn end, restore 64 HP."
  },
  State_70662_Desc = {
    Text = "Gain 2 Arithmetica after Keyflare Rouse."
  },
  State_70664_Desc = {
    Text = "Gain 16 Strength after Keyflare Rouse."
  },
  State_70666_Desc = {
    Text = "At the start of the battle, gain 100/200 Realm Mastery. Base Poison caused by all Awakeners and Poison caused by Relics increase by 10%/20%."
  },
  State_70667_Desc = {
    Text = "Gain 4 Arithmetica after Keyflare Rouse."
  },
  State_70670_Desc = {
    Text = "At the start of the battle, gain 320 Counter. In Boss Battles, the effect is doubled."
  },
  State_70671_Desc = {
    Text = "After entering the Ultra Round, the first non-Derived Command Card played will additionally activate 1/2 times."
  },
  State_70678_Desc = {
    Text = "At the start of the battle, gain 640 Counter. In Boss Battles, the effect is doubled."
  },
  State_70681_Desc = {
    Text = "All Awakeners increase Base DMG by 60%."
  },
  State_70682_Desc = {
    Text = "When the number of cards in hand is less than or equal to 2, draw 1/2 cards. This effect can be triggered up to 2 times per turn."
  },
  State_70683_Desc = {
    Text = "The Awakener with the lowest Aliemus gains 50/100 Aliemus, with a cooldown of 3 turns."
  },
  State_70684_Desc = {
    Text = "At turn start, if HP is below 25%, gain 72/144 Temporary STR."
  },
  State_70685_Desc = {
    Text = "Apply 416 Poison to all enemies after Keyflare Rouse."
  },
  State_70686_Desc = {
    Text = "After unleashing Exalt, all enemies take Fixed DMG equal to 15%/30% of our Max HP and are inflicted with 10%/20% Poison."
  },
  State_70689_Desc = {
    Text = "Apply 832 Poison to all enemies after Keyflare Rouse."
  },
  State_70690_Desc = {
    Text = "At the start of the battle, gain 100/200 Realm Mastery. The base Counter caused by all Awakeners and the Counter caused by Relics increase by 10%/20%."
  },
  State_70691_Desc = {
    Text = "Gain 4/8 Temporary STR each time DMG is dealt, triggering up to 15 times per turn."
  },
  State_70693_Desc = {
    Text = "Embryo Fusion auto-acquisition amount increased by 100%/200%."
  },
  State_70694_Desc = {
    Text = "Draw 2 cards after Keyflare Rouse."
  },
  State_70695_Desc = {
    Text = "At turn start, all Awakeners gain 5 Aliemus."
  },
  State_70696_Desc = {
    Text = "Gain 208 Counter after Keyflare Rouse."
  },
  State_70698_Desc = {
    Text = "Defense gains 200/400 Temporary counters, triggered a maximum of 3 times per turn."
  },
  State_70804_Name = {
    Text = "Life-and-Death Time Limit"
  },
  State_70805_Desc = {
    Text = "At the start of the battle, apply 1/2 stacks of Weakness to all enemies, doubling the effect on Bosses. All Awakeners increase their Base DMG by 15%/30%."
  },
  State_70808_Desc = {
    Text = "In Tranquil Sea Stance, inflict 64/128 Drain on all enemies. 3 turns cooldown."
  },
  State_70809_Desc = {
    Text = "At turn start, if HP is below 25%, gain 100/200 Shield."
  },
  State_70810_Desc = {
    Text = "Activate all Tentacle attacks on enemies immediately using the Anger Wave stance 1/2 times, with a 3-round cooldown."
  },
  State_70812_Desc = {
    Text = "At the start of the battle, apply 1/2 stack of Vulnerable to all enemies, doubling the effect on Bosses. All Awakeners increase their Base DMG by 15%/30%."
  },
  State_70832_Desc = {
    Text = "Team Unique: At the start of the battle, the equipped gains Aliemus equal to <WeaponEffect_Num:[StateArg1]%> of the wielder Aliemus Regen. After the equipped releases Exalt for the first time in each battle, this effect repeats once."
  },
  State_70832_WeaponDesc = {
    Text = "At the start of battle, the wielder gains Exalt equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's Aliemus Regen (<WeaponEffect_Num:[DescArg1]>). After the wielder releases Exalt for the first time in each battle, this effect repeats once."
  },
  State_70835_Desc = {
    Text = "Team Unique: The wielder's Aliemus, Poison, and HP Recovery effects are increased by <WeaponEffect_Num:[StateArg1]%>. After the wielder unleashes Exalt, they gain Aliemus equal to <WeaponEffect_Num:[StateArg2]%> of the Aliemus consumed."
  },
  State_70835_WeaponDesc = {
    Text = "The wielder's Aliemus, Poison, and HP Recovery effects are increased by <WeaponEffect_Num:[StateArg1]%>. After the wielder releases Exalt, obtain an amount of Aliemus equivalent to the Aliemus Cost in this instance multiplied by <WeaponEffect_Num:[StateArg2]>."
  },
  State_70989_Desc = {
    Text = "After using Exalt 4 times in one turn, gain 3/6 Arithmetica, with a cooldown of 3 turns."
  },
  State_71001_Desc = {
    Text = "After playing 4 Command Cards belonging to different Awakeners in one turn, all Awakeners gain 20/40 Aliemus, with a cooldown of 3 turns."
  },
  State_71153_Desc = {
    Text = "At turn start, Caecus gains 15 Aliemus. When Caecus gains a Shield, he regains 50% of the Shield amount as HP."
  },
  State_71154_Desc = {
    Text = "At turn start, Aigis gains 15 Aliemus. When Aigis deals DMG to enemies with Vulnerable, she steals 10 their Temporary STR, with a maximum effect of 5 times per turn."
  },
  State_71155_Desc = {
    Text = "At turn start, Leigh gains 15 Aliemus. Each time she loses HP, she gains 8 Strength, stacking up to 10 times per battle. After stacking 10 times, \"Pain and Pleasure\"has an Arithmetica Cost of 1, increasing its DMG count by 1."
  },
  State_71156_Desc = {
    Text = "At turn start, Agrippa gains 15 Aliemus. \"Reluctant Alms\" will also reduce Agrippa's Arithmetica Cost by 1 for this turn, triggering a maximum of once per turn."
  },
  State_71157_Desc = {
    Text = "At turn start, Sanga gains 15 Aliemus. At the start of the battle, grant all of Sanga's Command Cards Retain and Prepare 1, and gain 24 Shield."
  },
  State_71158_Desc = {
    Text = "At turn start, Doll gains 15 Aliemus. After the battle begins, set the Arithmetica Cost of Doll's \"Equivalent Exchange\" to 0. Once it is played, draw 2 extra cards in the next turn."
  },
  State_71159_Desc = {
    Text = "At turn start, Faros gains 15 Aliemus. For each instance of Tentacle DMG dealt, increase the Poison caused by Faros in this battle by 1%, up to 100%."
  },
  State_71160_Desc = {
    Text = "At the beginning of the turn, \"24\"gains 15 Aliemus. If \"24\"is in the \"Depressed Personality\", it gains an additional 25 Aliemus; if in \"Manic Personality\", it temporarily increases \"24\"'s Crit. Rate and Crit. DMG by 35%."
  },
  State_71161_Desc = {
    Text = "At turn start, Faint gains 15 Aliemus. Each time Death Resistance is triggered, it increases the Shield, Counter, and HP recovery effects caused by Faint during this exploration by 20%, up to 5 times."
  },
  State_71162_Desc = {
    Text = "At turn start, Goliath gains 15 Aliemus. If Goliath deals DMG 3 times within 1 turn, the DMG dealt by Goliath in this battle gains an additional 1x STR bonus, with a 3-turn cooldown."
  },
  State_71163_Desc = {
    Text = "At turn start, Helot: Catena gains 15 Aliemus. Helot: Catena's Active DMG applies an additional 20% Bleeding, and killing an enemy inflicts Bleeding equal to the excess DMG on other enemies."
  },
  State_71164_Desc = {
    Text = "At turn start, Aurita gains 15 Aliemus. The DMG count of \"Gland Division\" increases by 1, and after playing Aurita's \"Defense\", it puts 1 \"Gland Division\" into hand."
  },
  State_71166_Desc = {
    Text = "At turn start, Lily gains 15 Aliemus. Lily's Endure limit increases by 100%, and when using \"Undying Flower Upon Slime\" or \"Strike to Protect\", she restores 8% of HP per stack of \"Endure\"."
  },
  State_71167_Desc = {
    Text = "At turn start, Lotan gains 15 Aliemus. After the first use of Lotan's \"Defense\" each turn, place 2 \"Blade of Defiance\" with Exhaust and Fleeting into hand."
  },
  State_71168_Desc = {
    Text = "At turn start, Pandia gains 15 Aliemus. At turn start, gain 64 Counter. For every 4 non-Temporary Counter, the DMG dealt by \"Pandia\"'s Command Card is increased by 1."
  },
  State_71169_Desc = {
    Text = "At turn start, Helot gains 15 Aliemus. Each time a card is discarded, \"Helot\" gains 5 Aliemus."
  },
  State_71170_Desc = {
    Text = "At turn start, Tawil gains 15 Aliemus. If 6 of Tawil's Command Cards are played in one turn, put 1 \"Silver Key Dawn\" into hand. Cooldown: 3 turns."
  },
  State_71171_Desc = {
    Text = "At turn start, Miryam gains 15 Aliemus and puts 1 \"Sacrament\" into hand."
  },
  State_71172_Desc = {
    Text = "At turn start, Doll: Inferno gains 15 Aliemus. After Doll: Inferno releases Exalt, every 20 Aliemus consumed grants 1 Aliemus to other Awakeners."
  },
  State_71173_Desc = {
    Text = "At turn start, Salvador gains 15 Aliemus. Each time he accumulates Crimson Furnace, he also gains STR equal to 5% the accumulated amount. Salvador's \"Strike\" and \"End of Suffering\" additionally receive a 1x STR bonus."
  },
  State_71175_Desc = {
    Text = "At turn start, Nautila gains 15 Aliemus. After using Nautila's \"Exalt\", she gains Counter equal to 50% of the current Shield, triggered up to 1 time per turn."
  },
  State_71177_Desc = {
    Text = "At turn start, Liz gains 15 Aliemus. Cards discarded by \"Dance to Destruction\" gain an extra effect once, with a cooldown of 3 turns."
  },
  State_71178_Desc = {
    Text = "At turn start, Ramona gains 15 Aliemus. Every 3rd Command Card played by Ramona grants an additional effect 1 time."
  },
  State_71179_Desc = {
    Text = "At turn start, Uvhash gains 15 Aliemus. Uvhash's Exalt Aliemus Cost -10, which further reduces by 5 every time he releases Exalt. He can release Exalt 2 times per turn."
  },
  State_71180_Desc = {
    Text = "At turn start, Alva gains 15 Aliemus. If Alva played 2 \"Defense\" last turn, put a consumed \"Precision Slash\" into their hand; if Alva played 2 \"Strike\", put 1 consumed \"Combat Stance\" into their hand."
  },
  State_71181_Desc = {
    Text = "At turn start, Sorel gains 15 Aliemus. For each instance of DMG dealt, Embryo Fusion increases by 10%, up to 10 times per turn. After reaching 10 activations, Sorel's Crit. DMG is increased by 20% for this battle."
  },
  State_71182_Desc = {
    Text = "At turn start, Hameln gains 15 Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by 1, and the Base DMG count is increased by 1."
  },
  State_71183_Desc = {
    Text = "At turn start, Thais gains 15 Aliemus. After playing 3 Command Cards in one turn, Thais gains 1 \"Scion of Purity\" and 72 Temporary STR, with a cooldown of 3 turns."
  },
  State_71187_Desc = {
    Text = "At turn start, Celeste gains 15 Aliemus. Before turn end, for each Command Card of Celeste in hand, 1 Tentacle attacks an enemy and restores 8 HP."
  },
  State_71188_Desc = {
    Text = "At turn start, Murphy gains 15 Aliemus. Murphy's \"Strike\" and \"Defense\" can convert 25% of the \"Sacrifice\" into Temporary Tentacle DMG, but can only take effect once per turn."
  },
  State_71189_Desc = {
    Text = "At turn start, Nymphaea gains 15 Aliemus. After using Nymphaea's \"Strike\", the Poison dealt by \"Nymphaea\" in this battle increases by 20%. After using Nymphaea's \"Defense\", it triggers 50% Poison to all enemies. Each effect can take effect at most once per turn."
  },
  State_71190_Desc = {
    Text = "At turn start, Ogier gains 15 Aliemus. After the first time Ogier plays \"Piercing Strike\" or \"Strike\" in each turn, the Shield and STR Ogier generates in that turn +50%."
  },
  State_71191_Desc = {
    Text = "At turn start, Ryker gains 15 Aliemus. The result of the first die roll each turn is always 6."
  },
  State_71192_Desc = {
    Text = "At turn start, Ramona-loop gains 15 Aliemus. The first time \"Loop\" is triggered each turn, gain 500  Keyflare and 1 stack of \"Negentropy\"."
  },
  State_71193_Desc = {
    Text = "At turn start, Tulu gains 15 Aliemus. The Aliemus consumption for Tulu is reduced by 10 points, and after releasing Exalt, it instantly generates 2 Temporary Tentacles."
  },
  State_71194_Desc = {
    Text = "At turn start, Karen gains 15 Aliemus. Playing \"Silent Fealty\" will return double the exhausted Arithmetica, with a cooldown of 3 turns."
  },
  State_71271_Desc = {
    Text = "At turn start, Horla gains 15 Aliemus. At battle start, gains 1 stack of \"Metaphor\" for all emotions. The \"Metaphor\" effect +50%."
  },
  State_71272_Desc = {
    Text = "At turn start, Jenkin gains 15 Aliemus, and Final DMG increases by 5%. The Base DMG and DMG growth of \"Get 'em! Brown!\" increase by 200%."
  },
  State_71273_Desc = {
    Text = "At turn start, Daffodil gains 15 Aliemus and 1 \"Insight\". Every time she plays \"Heterogeneous Tide\", the Strength gained during this exploration is permanently increased by 25%, up to 300%."
  },
  State_71274_Desc = {
    Text = "At turn start, Tinct gains 15 Aliemus. When Tinct's Command Card triggers Leap, return it to their hand, with a maximum of 3 activations per turn."
  },
  State_71275_Desc = {
    Text = "At turn start, Wanda gains 15 Aliemus and receives 1 stack of \"Dreamlure\". If it is an Ultra Round, additionally place 1 Temporary \"Spine Needle Chains\" and \"Keeper of the Lost\" into hand."
  },
  State_71276_Desc = {
    Text = "At turn start, Erica gains 15 Aliemus. After playing 3 Command Cards in one turn, Erica gains 1 \"Insight\" and doubles the Strength and Alert bonuses of \"Electromagnetic Blast\" in this battle."
  },
  State_71277_Desc = {
    Text = "At turn start, Casiah gains 15 Aliemus. Drawing 1 card grants Casiah 1 point of Aliemus. When Casiah unleashes Exalt, all enemies lose 32 Strength."
  },
  State_71278_Desc = {
    Text = "At turn start, Winkle gains 15 Aliemus. Each time another Awakeners unleashes Exalt, Winkle gains 5 Aliemus, and the Arithmetica Cost of \"Psyche Reforged\" in hand is reduced by 1."
  },
  State_71279_Desc = {
    Text = "Team DMG Amplification increased by [StateArg1]%, lasting for [Layer] turns."
  },
  State_71279_Name = {Text = "Elation"},
  State_71503_Name = {
    Text = "\"Final Form\": Draw 3 additional cards, gain 3 Arithmetica, trigger [DescArg1]% of all enemies' <IntoxicationIconKeywords:Poison>, increase Doll: Inferno's Aliemus Cap by 50, up to 3 times"
  },
  State_71589_Name = {
    Text = "Trigger 1 Tentacle Attack against the enemy and restore 8."
  },
  State_71605_Name = {
    Text = "Gain [StateArg1] Shield"
  },
  State_71650_Desc = {
    Text = "Upon death, revive and summon different numbers of clones. Surprisingly, it does not gain any Fortress or Immunity effects upon revival. The effect can still be triggered [Layer] times."
  },
  State_71650_Name = {
    Text = "Beast of Countless Dimensions"
  },
  State_71651_Desc = {
    Text = "Each time you lose HP, you lose [StateArg1] Temporary STR. It can still take effect [Layer] times and resets the number of effective times at turn start."
  },
  State_71651_Name = {
    Text = "Gentleman's Top Hat"
  },
  State_71707_Desc = {
    Text = "Each time attacked, recover [StateArg1] HP, lasting for [Layer] turns."
  },
  State_71707_Name = {
    Text = "Caecus: Support"
  },
  State_71708_Desc = {
    Text = "At turn end, for every 1 Card in hand, all Awakeners gain [DescArg1] Aliemus."
  },
  State_71708_Name = {
    Text = "Casiah: Support"
  },
  State_71709_Desc = {
    Text = "At turn end, gain 35 Aliemus, lasting [Layer] turns."
  },
  State_71709_Name = {
    Text = "Winkle: Support"
  },
  State_71711_Desc = {
    Text = "DMG dealt by the Awakener increases by 25% and lasts for [Layer] turns."
  },
  State_71711_Name = {
    Text = "Jenkin: Support"
  },
  State_71712_Desc = {
    Text = "When dealing Damage, trigger 1 Tentacle attack once, lasting for [Layer] turns."
  },
  State_71712_Name = {
    Text = "Aurita: Support"
  },
  State_71712_WeaponDesc = {
    Text = "When Hydromedusa deals DMG, it triggers [StateArg1] Tentacle attacks on the target."
  },
  State_71713_Desc = {
    Text = "Each time \"Devour\" is performed, draw 2 \"Strike\" and reduce their Arithmetica Cost by 1, lasting for [Layer] turns."
  },
  State_71713_Name = {
    Text = "Helot: Support"
  },
  State_71740_Desc = {
    Text = "Gain [Layer] Shield at the start of next turn."
  },
  State_71740_Name = {
    Text = "Leigh: Support Shield"
  },
  State_71741_Desc = {
    Text = "At the start of next turn, gain a Shield equal to the HP lost this turn, lasting for [Layer] turns."
  },
  State_71741_Name = {
    Text = "Leigh: Support"
  },
  State_71741_WeaponDesc = {
    Text = "At the start of next turn, gain Shield equal to the HP lost in the previous turn."
  },
  State_71742_Desc = {
    Text = "\"Strike\" DMG increases by [Layer]%."
  },
  State_71742_Name = {
    Text = "Helot: Support"
  },
  State_71742_WeaponDesc = {
    Text = "This turn, your Strike Card DMG is boosted by [Layer]%."
  },
  State_71837_Desc = {
    Text = "At the start of next turn, gain Vulnerable."
  },
  State_71837_Name = {
    Text = "Delayed Vulnerable"
  },
  State_71839_Desc = {
    Text = "When using \"Awake,\" gain [Layer] Arithmetica. If the current Realm is \"Aequor,\" an additional [Layer] Tentacles are generated temporarily."
  },
  State_71839_Name = {
    Text = "Stellar Protection"
  },
  State_71856_Desc = {
    Text = "Each time you lose HP, you lose [StateArg1] Temporary STR. It can still take effect [Layer] times and resets the number of effective times at turn start."
  },
  State_71856_Name = {
    Text = "Gentleman's Top Hat"
  },
  State_72018_WeaponDesc = {
    Text = "Each time DMG is taken, all Awakeners' Aliemus increases by 1."
  },
  State_72033_Desc = {Text = "—"},
  State_72033_WeaponDesc = {Text = "—"},
  State_72034_Desc = {Text = "—"},
  State_72034_WeaponDesc = {Text = "—"},
  State_72036_Name = {
    Text = "Chaos Class Initialization"
  },
  State_72102_Desc = {
    Text = "The classic gameplay experience of \"Morimens\"."
  },
  State_72102_Name = {
    Text = "Faded Legacy"
  },
  State_72137_Name = {
    Text = "Arithmetica Overflow"
  },
  State_72206_Name = {
    Text = "Research Progress \"[DescArg1]/15\""
  },
  State_72208_Name = {
    Text = "Research Progress \"[DescArg1]/2\""
  },
  State_72212_Name = {
    Text = "Research Progress \"[DescArg1]/10\""
  },
  State_72213_Name = {
    Text = "Research Progress \"[DescArg1]/30\""
  },
  State_72220_Name = {
    Text = "Research Progress \"[DescArg1]/5\""
  },
  State_73518_Desc = {
    Text = "DMG dealt is increased by 100%. The state is removed upon losing HP, but a Shield equal to 50% of Max HP is granted."
  },
  State_73518_Name = {Text = "\"Assassin\""},
  State_73520_Desc = {
    Text = "Upon death, retain 1 point of HP and become immune to all Damage, converting Intention into \"Connection Release\"."
  },
  State_73520_Name = {
    Text = "\"Connector\""
  },
  State_73533_Desc = {
    Text = "No longer discard cards at the end of turns. At the start of the battle, set your hand Limit to 8."
  },
  State_73533_Name = {
    Text = "Hive Resonance"
  },
  State_73535_Desc = {
    Text = "During your turn, DMG taken is reduced by 75%. When Strength is reduced, only 50% of the Strength stacks will be lowered."
  },
  State_73535_Name = {
    Text = "Self-Protection"
  },
  State_73566_Desc = {
    Text = "For each non-Command Card played, gain [Power:StateArg1] <PowerIconKeywords:STR> and <Block:[Block:StateArg2]> shield."
  },
  State_73566_Name = {
    Text = "\"Communicator\""
  },
  State_73567_Desc = {
    Text = "For each non-Command Card played, gain [Power:StateArg1] <PowerIconKeywords:STR> and <Block:[Block:StateArg2]> shield."
  },
  State_73567_Name = {
    Text = "\"Communicator\""
  },
  State_73570_Desc = {
    Text = "For each non-Command Card played, gain [Power:StateArg1] <PowerIconKeywords:STR> and <Block:[Block:StateArg2]> shield."
  },
  State_73570_Name = {
    Text = "\"Communicator\""
  },
  State_73573_Desc = {
    Text = "For each non-Command Card played, gain [Power:StateArg1] <PowerIconKeywords:STR> and <Block:[Block:StateArg2]> shield."
  },
  State_73573_Name = {
    Text = "\"Communicator\""
  },
  State_73649_Desc = {
    Text = "Team DMG Amplification increased by [Layer]%."
  },
  State_73649_Name = {
    Text = "Manikin of Oblivion"
  },
  State_73655_Name = {
    Text = "Organic Form Identifier"
  },
  State_73664_Name = {
    Text = "Accessory Organic Form Effect"
  },
  State_73664_WeaponDesc = {
    Text = "After the wielder uses Exalt, their Shield and Healing Amp. are doubled this turn."
  },
  State_74012_Desc = {
    Text = "Deal [StateArg1]% of all enemies' max HP as <RealDamage:Fixed DMG> (minimum [DescArg1]). After use, \"Doll: Inferno\"'s specific skill changes to \"Finale.\""
  },
  State_74012_Name = {
    Text = "Illusion's End"
  },
  State_74013_Desc = {
    Text = "Deal [StateArg1]% of all enemies' max HP as <RealDamage:Fixed DMG>. This DMG cannot be lower than 500% of the caster's max HP. After use, \"Doll: Inferno\"'s specific skill changes to \"Finale\"."
  },
  State_74013_Name = {
    Text = "Illusion's End"
  },
  State_74014_Desc = {
    Text = "Deal [StateArg1]% of all enemies' Max HP as <RealDamage:Fixed DMG> (this DMG cannot be lower than 500% of your own max HP), restore 30% of lost HP. After use, \"Doll: Inferno\"'s specific skill changes to \"Finale\"."
  },
  State_74014_Name = {
    Text = "Illusion's End"
  },
  State_74015_Desc = {
    Text = "Deal [StateArg1]% of all enemies' max HP as <RealDamage:Fixed DMG> (minimum [DescArg1]), restoring <Heal:[Heal:DescArg2]> points of HP, and after use, \"Doll: Inferno\"'s specific skill changes to \"Finale.\""
  },
  State_74015_Name = {
    Text = "Illusion's End"
  },
  State_74019_Desc = {
    Text = "All Awakeners' Poison, Counter, and Base DMG +[Layer]%."
  },
  State_74019_Name = {
    Text = "Madness Infection"
  },
  State_74142_Desc = {
    Text = "At the start of exploration, CON, ATK and DEF +[StateArg1]%."
  },
  State_74142_Name = {
    Text = "Soulforge Aptitude"
  },
  State_74219_Name = {
    Text = "Returns to your hand after playing"
  },
  State_74273_Desc = {
    Text = "When Helot: Catena deals Active DMG, apply [StateArg1]% Bleeding, lasting for [Layer] turns."
  },
  State_74273_Name = {
    Text = "Sanguine Fetters"
  },
  State_74771_Desc = {
    Text = "The amount of Aliemus required to trigger one Exalt."
  },
  State_74771_Name = {
    Text = "Aliemus Limit"
  },
  State_74788_Desc = {
    Text = [[

Existence Paradox: At the start of the exploration, 75% of Death Resistance is converted into Max HP bonus, with a maximum conversion of 300% Death Resistance, increasing Max HP by up to 10%. Each time Death Resistance is triggered, an additional "Silver Key Gleam" is added to the hand. 
Bottomless Scar: In Boss Battles, for every 100% of the HP limit reached by our side's healing received, the subsequent healing effects are reduced by 25%, but the total Death Resistance increases by 25%, triggering up to 3 times. 
Prismatic Lens: At the start of the turn, if Counter exceeds 750% of the HP limit, the excess stacks are halved, and Permanent Counter can stack up to 2250% of the HP limit; if the enemy is Poisoned exceeding 1000% of the HP limit, the excess stacks are halved, and Poison can stack up to 3000% of the HP limit. For every 4% of the team's DMG Amplification attribute, the total above limits can be increased by 1%. The Awakener's damage bonus from Counter is reduced by 70%, but all Poison and Counter damage dealt is increased by 10%. At the start of the enemy's turn, for each Gnosis activated, gain 25% of the current Permanent Counter as Temporary Counter, and trigger 25% Poison on all enemies. 
Light Cone of Fate: The number of turns for ordinary Monsters to release "Gaze" is changed to 6 turns. All battles have a limit of 15 turns, but at the start of the 15th turn, add a "Light Cone Boundary" to the hand: Max out Keyflare and all Awakeners' Aliemus.]]
  },
  State_74788_Name = {
    Text = "(Temporarily Discard)"
  },
  State_74791_Desc = {
    Text = [[

Arithmetica Harmony: For every Command Card played after the 10th in a turn, gain 1 "Arithmetica Harmony." Each stack increases card cost by 1 Arithmetica, which is then converted into 100% of the Awakener's Keyflare Regen.
Arithmetica Overflow: Removes the turn's cost reduction effect upon playing a card. When current Arithmetica exceeds 12, each excess point is converted to 300% of the team's average Keyflare Regen.
Aliemus Harmony: Effect of increased Aliemus % is halved. Each Exalt raises the Base Aliemus by 10. Gain 200% of the team's average Keyflare Regen at turn end for each Awakener who did not Exalt.]]
  },
  State_74791_Name = {
    Text = "Harmony of the Keyflare"
  },
  State_74809_Name = {
    Text = "\"Final Form\": Draw 3 additional cards, gain 3 Arithmetica, trigger [DescArg1]％ <IntoxicationIconKeywords:Poison> on all enemies, increase the Aliemus Limit of \"Doll: Inferno\" by 50, up to 3 times"
  },
  State_74826_Name = {
    Text = [[

Randomly deal [DescArg1] <RealDamage:Fixed DMG> [DescArg2] times (benefits from <PowerIconKeywords:STR>)]]
  },
  State_74827_Name = {
    Text = [[

Gain +[DescArg1]% Temporary Crit. Rate & Crit. DMG]]
  },
  State_74828_Name = {
    Text = [[

Inflict [DescArg1] <IntoxicationIconKeywords:Poison> on all enemies]]
  },
  State_74829_Name = {
    Text = [[

Deal <RealDamage:Fixed DMG> to all enemies equal to [DescArg1]% of their missing HP]]
  },
  State_74830_Name = {
    Text = [[

Gain [DescArg1] <PowerIconKeywords:STR>]]
  },
  State_74831_Name = {
    Text = [[

Grant all Awakeners <Energy:[DescArg1]> Aliemus]]
  },
  State_74847_Desc = {
    Text = "Team Unique: The Base DMG dealt by the first Command Card used by the wielder each turn is increased by <WeaponEffect_Num:[StateArg1]%>. If they enter the Ultra space, the wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_74847_WeaponDesc = {
    Text = "The Base DMG dealt by the first Command Card used by the wielder each turn is increased by <WeaponEffect_Num:[StateArg1]%>. If they enter the Ultra Space, the wielder gains <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_74879_Name = {
    Text = [[

Gain [DescArg1] Arithmetica]]
  },
  State_74881_Name = {
    Text = [[

Grant a chosen Awakener <Energy:[DescArg1]> Aliemus]]
  },
  State_74882_Name = {
    Text = [[

Gain [DescArg1] <ProficientInRealmsIconKeywords:Realm Mastery>]]
  },
  State_74883_Name = {
    Text = [[

The next [DescArg1] Command Cards played will grant an extra <Posse:[DescArg2]> Keyflare]]
  },
  State_74884_Name = {
    Text = [[

<RetaliateIconKeywords:Counter> gained and <IntoxicationIconKeywords:Poison> & <BleedingIconKeywords:Bleed> inflicted each +[DescArg1]% this turn]]
  },
  State_74885_Name = {
    Text = [[

Grant all Awakeners <Energy:[DescArg1]> Aliemus]]
  },
  State_74887_Name = {
    Text = [[

Gain <Block:[DescArg1]> Shield]]
  },
  State_74888_Name = {
    Text = [[

Increase <DeathResistanceIconKeywords:Death Resistance> by +[DescArg1]%]]
  },
  State_74889_Name = {
    Text = [[

Gain [DescArg1] <RetaliateIconKeywords:Counter>]]
  },
  State_74890_Name = {
    Text = "\nFor each enemy, inflict [DescArg1] Temp. <ExhaustionIconKeywords:STR▼> on them & gain [DescArg1] Temp. <PowerIconKeywords:STR>"
  },
  State_74891_Name = {
    Text = [[

Randomly deal [DescArg1] <RealDamage:Fixed DMG> [DescArg2] times (benefits from <PowerIconKeywords:STR>)]]
  },
  State_74910_Desc = {
    Text = "Team Unique: If the wielder is the Awakener \"Ramona\", the Affinity gained upon completing the stage is increased by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "If the wielder is \"Ramona\", the Affinity gained upon completing a level is increased by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Playing a \"Strike\" Command, \"Defense\" Command, or \"Skill\" Command will enhance Taboo Trade's 1st, 2nd, or 3rd effects respectively."
  },
  State_74932_Name = {
    Text = "Taboo Trade"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn start, apply [StateArg1] stacks of Action Lock to the enemy with the lowest HP and Shield. When the wielder scores a kill, trigger this effect immediately."
  },
  State_74947_Name = {
    Text = "Witch's Wide-brimmed Hat"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After \"Exalt\", the enemy with the highest Aliemus loses [StateArg1] Aliemus and gains <PVPEmptinessKeywords:Void>."
  },
  State_74948_Name = {
    Text = "Hypnotic Pendulum"
  },
  State_76235_Name = {
    Text = "Archive Mark"
  },
  State_76236_Desc = {
    Text = [[

Keyflare Rouse: When Keyflare energy is full, you can additionally choose "Keyflare Rouse" to place the designated Awakener's Rouse card into your hand and grant it "Retain" for this battle. "Keyflare Rouse" can only trigger once per turn and has an independent cooldown from "Posse".
Keyflare Overload: When using "Keyflare Rouse", for each unlocked Rouse Awakener, an additional 100% of the Keyflare energy limit is deducted, which may cause the Keyflare energy to become negative.
Archive Mark: For each Posse the Keeper has, the "Esoteric Research" and "Occult Research" Depths increases by1 1%, up to 50%. All R Wheels of Destiny effects are changed to increase the chance for the wielder's Dimensional Image Relic to appear by 100%.]]
  },
  State_76236_Name = {
    Text = "Radiant Silver Glow"
  },
  State_76277_Desc = {
    Text = "Team Unique: After the Boss Battle starts, consume up to 50 Black Sigils, with each point of Black Sigil consumed granting <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:Death Resistance>. In the Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76277_WeaponDesc = {
    Text = "After the Boss Battle starts, consume up to 50 Black Sigils. For each Black Sigil consumed, gain <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Death Resistance>. In the Astral Reign, the effect changes to \"increase the wielder's Dimensional Image Relic drop rate by 100%.\""
  },
  State_76278_Desc = {
    Text = "Team Unique: Recover <WeaponEffect_Num:[StateArg1]%> of lost HP after walking a new Tile. After using an Emergency Gnosis, increase all Awakeners' Crit. Rate and Crit. DMG by 100%. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76278_WeaponDesc = {
    Text = "Restore [StateArg1]% of lost HP ([DescArg1]) after walking a new Tile. After using an Emergency Gnosis, increase all Awakeners' Crit. Rate and Crit. DMG by 100%. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76279_Desc = {
    Text = "Team Unique: Reduce the cost of Rouse Cards in D-Mark Store by <WeaponEffect_Num:[StateArg1]> Black Sigils. the wielder's Rouse card gains Innate. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76279_WeaponDesc = {
    Text = "The price of Roused Awakeners in the D-Mark Store is reduced by <WeaponEffect_Num:[StateArg1]> Black Sigils. The wielder's Rouse gains an innate effect. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76280_Desc = {
    Text = "Team Unique: Increases the HP Recovery at Rest Areas by <WeaponEffect_Num:[StateArg1]%>. After choosing to recover HP, add 2 \"Insight\" cards to the deck. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76280_WeaponDesc = {
    Text = "The healing amount at the Rest Area is increased by <WeaponEffect_Num:[StateArg1]%>. After choosing HP Recovery, add 2 \"Insight\" cards to the deck. In Astral Reign, the effect is changed to \"Increases the Relic appearance chance of the wielder's Dimensional Image by 100%.\""
  },
  State_76281_Desc = {
    Text = "Team Unique: After each battle ends, the Awakener with the lowest Aliemus gains <WeaponEffect_Num:[StateArg1]> Aliemus. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76281_WeaponDesc = {
    Text = "After the battle ends, the Awakener with the lowest Aliemus gains <WeaponEffect_Num:[Energy:StateArg1]> Aliemus. In Astral Reign, this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76282_Desc = {
    Text = "Team Unique: D-Mark Store refresh attempts +1, refresh cost reduced by <WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76282_WeaponDesc = {
    Text = "D-Mark Store refresh attempts +1, refresh cost -<WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76283_Desc = {
    Text = "Team Unique: The number of Relic Slots becomes 3, with one being a Cursed Relic Slot. Purchasing a Cursed Relic grants <WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76283_WeaponDesc = {
    Text = "The Relic Slots become 3, with one being a Cursed Relic. After purchasing a Cursed Relic, obtain <WeaponEffect_Num:[StateArg1]> Black Sigils. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76284_Desc = {
    Text = "Team Unique: After each stage starts, all Awakeners gain <WeaponEffect_Num:[StateArg1]> Aliemus. At the start of a Boss Battle, draw 2 cards. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76284_WeaponDesc = {
    Text = "After the level starts, all Awakeners gain <WeaponEffect_Num:[Energy:StateArg1]> Aliemus. After the Boss Battle starts, draw 2 cards. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76285_Desc = {
    Text = "Team Unique: After each stage starts, gain <WeaponEffect_Num:[StateArg1]>  Keyflare. At the start of a Boss Battle, gain 2 Arithmetica. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76285_WeaponDesc = {
    Text = "After the level starts, gain <WeaponEffect_Num:[StateArg1]> Keyflare. After the Boss Battle starts, gain 2 Arithmetica. In \"Astral Reign\", the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76286_Desc = {
    Text = "Team Unique: Rest Areas provide an additional option: Destroy up to 3 Symptom cards, obtain <WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76286_WeaponDesc = {
    Text = "Rest Areas provide an additional option: Destroy up to 3 Symptom cards, obtain <WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76287_Desc = {
    Text = "Team Unique: After a normal battle ends, the number of available Orisons becomes 4. Orisons on the wielder's cards has a <WeaponEffect_Num:[StateArg1]%> chance to upgrade to Advanced. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76287_WeaponDesc = {
    Text = "After an ordinary battle ends, the number of available Orisons becomes 4. Orisons on the wielder's cards have a <WeaponEffect_Num:[StateArg1]%> chance to upgrade to Advanced Orisons. In Astral Reign, this effect changes to \"increase the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76288_Desc = {
    Text = "Team Unique: After each battle ends, gain <WeaponEffect_Num:[StateArg1]>  Keyflare. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76288_WeaponDesc = {
    Text = "After the battle ends, obtain <WeaponEffect_Num:[StateArg1]> Keyflare. In Astral Reign, this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76289_Desc = {
    Text = "Team Unique: Vision +1 during exploration, gain <WeaponEffect_Num:[StateArg1]> Black Sigil after the map is fully revealed. At the start of Boss Battles, <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> all enemies for 1 turn. In the Astral Reign, the effect is changed to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76289_WeaponDesc = {
    Text = "Exploration Vision +1, obtain <WeaponEffect_Num:[StateArg1]> Black Sigil after the map is fully revealed. At the start of a Boss Battle, inflict <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies for 1 turn. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76290_Desc = {
    Text = "Team Unique: After a normal battle, you can choose to forgo an Orison and increase Max HP by <WeaponEffect_Num:[StateArg1]%>. Takes effect up to 2 times. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76290_WeaponDesc = {
    Text = "After an ordinary battle, you can choose to give up an Orison and increase Max HP by <WeaponEffect_Num:[DescArg1]>. This effect takes effect up to 2 times. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76291_Desc = {
    Text = "Team Unique: After each stage starts, gain <WeaponEffect_Num:[StateArg1]> Black Sigils. Relic Capacity +2. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76291_WeaponDesc = {
    Text = "After the level starts, obtain <WeaponEffect_Num:[StateArg1]> Black Sigils. Relic Capacity +2. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76292_Desc = {
    Text = "Team Unique: Symptom Cards can be sold for <WeaponEffect_Num:[StateArg1]> Black Sigils. In \"Astral Reign\", this effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\"."
  },
  State_76292_WeaponDesc = {
    Text = "D-Marks can be obtained by selling Symptom Cards at the D-Mark Store for <WeaponEffect_Num:[StateArg1]> Black Sigils. In Astral Reign, the effect changes to \"Increases the chance for the wielder's Dimensional Image Relic to appear by 100%.\""
  },
  State_76321_Name = {
    Text = "Prismatic Lens"
  },
  State_76323_Name = {
    Text = "Aliemus Harmony"
  },
  State_76324_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76325_Desc = {
    Text = "After playing [DescArg1] Command Cards, enter the \"Arithmetica Harmony\" state."
  },
  State_76325_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76326_Name = {
    Text = "Existence Paradox"
  },
  State_76328_Name = {
    Text = "Light Cone of Fate"
  },
  State_76337_Name = {
    Text = "Bottomless Scar"
  },
  State_76338_Desc = {
    Text = "Healing received is reduced by [Layer]%."
  },
  State_76338_Name = {
    Text = "Bottomless Scar"
  },
  State_76433_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76434_Desc = {
    Text = "Each time a Command Card is played, if Arithmetica was extra exhausted due to Arithmetica Harmony, gain an additional 100% of the Awakener's Keyflare Regen Keyflare. This effect is stackable."
  },
  State_76434_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76435_Name = {
    Text = "Prismatic Lens"
  },
  State_76528_Name = {
    Text = "This card is considered \"Strike\""
  },
  State_76529_Desc = {
    Text = "When picked up, choose a card of an Awakener to reduce its Arithmetica Cost by 1. After playing it, draw 1 card and treat it as \"Strike\"."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, randomly assign [StateArg1] cards in the opponent's hand with [StateArg2] stacks of <PVPAcheKeywords:Veiled Anguish>."
  },
  State_76533_Name = {
    Text = "Veiled Anguish"
  },
  State_76553_Desc = {
    Text = "Reduce this Card's Arithmetica Cost by [StateArg1]."
  },
  State_76553_Name = {
    Text = "Million Loving Gaze"
  },
  State_77686_Name = {
    Text = "Semi-Mechanical Form"
  },
  State_77688_Desc = {
    Text = "At the start of the fifth turn or upon impending death, become immune to death and shift the Intention to \"Mechanical Ascension\"."
  },
  State_77688_Name = {
    Text = "The Flesh is Weak"
  },
  State_77690_Desc = {
    Text = "After switching to \"Semi-Mechanical Form\", each stack of Finale grants an additional 10% Max HP. In \"Semi-Mechanical Form\", \"Doll: Inferno\" will unleash more threatening Skills as the number of \"Finale\" stacks increases."
  },
  State_77690_Name = {Text = "Finale"},
  State_77692_Desc = {
    Text = "At turn end, summon 2 Dissolution Monsters, with a maximum of 2 existing simultaneously. When the summoned Dissolution Monsters die, \"Doll: Inferno\" loses 5% of its Max HP."
  },
  State_77692_Name = {Text = "Abyss Gate"},
  State_77693_Desc = {
    Text = "Upon death, \"Doll: Inferno\" loses 5% Max HP."
  },
  State_77693_Name = {Text = "Meltdown"},
  State_78102_Desc = {
    Text = "DMG dealt is reduced by 15%, and DMG taken is increased by 30%, lasting until the end of the Battle."
  },
  State_78102_Name = {
    Text = "Overclock Paralysis"
  },
  State_78694_Desc = {
    Text = "Gain [Arg1] Strength at the start of the battle. At turn start, for each [Arg2] Permanent Strength, gain [Arg3] Temporary STR, up to [Arg4] Temporary STR, and lose half of the Temporary STR gained by that Relic at turn end."
  },
  State_78696_Desc = {
    Text = "After using Keyflare Rouse, select [Arg1] \"Skill\" of the corresponding Awakener to Exhaust, and shuffle [Arg2] copies with Exhaust into the Draw Pile."
  },
  State_78697_Desc = {
    Text = "At turn start, gain [Arg1] STR for every 1 vacant space in Ultra Space, but suffer [Arg2] stacks of Poison."
  },
  State_78698_Desc = {
    Text = "Arithmetica Limit -[Arg1]. Each time you play a card with an Arithmetica Cost of [Arg2] or greater, gain 1 Arithmetica. This effect can trigger up to [Arg3] times per turn."
  },
  State_78699_Desc = {
    Text = "After drawing, draw [Arg1] additional cards, but choose [Arg2] cards from your hand to discard."
  },
  State_78700_Desc = {
    Text = "Increase all Awakeners' Base DMG by [Arg1]%. Each time the deck is reset, an additional [Arg2]% is granted, but a \"Stagger\" card is added to your hand. The maximum increase is [Arg3]%."
  },
  State_78701_Desc = {
    Text = "At turn start, if there are more than [Arg1] Permanent Tentacles, lose [Arg2] Tentacles to gain [Arg3] Temporary Tentacles; otherwise, gain [Arg4] Temporary Tentacles."
  },
  State_78702_Desc = {
    Text = "After using Keyflare Rouse, consume an additional [Arg1] Keyflare, reducing the Arithmetica exhaustion of the received Rouse card to 0. Upon playing, the corresponding Awakener gains an additional [Arg2] Aliemus."
  },
  State_78703_Desc = {
    Text = "At the start of the battle, inflict [Arg1] Poison on all enemies. Before each turn start, remove [Arg2]% of the enemy's Poison and inflict [Arg3]% of the removed amount as Bleeding."
  },
  State_78710_Desc = {
    Text = "For each Command Card played, the corresponding Awakener's Final DMG for that turn increases by [Arg1]%, but they lose [Arg2] Aliemus. This effect can trigger up to [Arg3] times per turn."
  },
  State_78712_Desc = {
    Text = "At turn start, Embryo Fusion level increases by [Arg1]%. Your Embryo will be discarded at turn end."
  },
  State_78713_Desc = {
    Text = "At turn start, gain [Arg1] Counter. After using Exalt [Arg2] times in one turn, remove [Arg3]% of Permanent Counter, and gain [Arg4]% of the removed amount as Temporary Counter. Cooldown: [Arg5] turns."
  },
  State_78781_Desc = {
    Text = "Temporarily reduce target's STR and gain the same amount of Temporary STR."
  },
  State_78781_Name = {
    Text = "<TouquKeywords:Steal>"
  },
  State_79405_Desc = {
    Text = "When played, increases \"Clear Memory\" by 1. Upon reaching 10, lock it for 1 turn and gain 3 \"Insight\" cards, then reset to 5 at the start of next turn."
  },
  State_79405_Name = {Text = "True Past"},
  State_79406_Desc = {
    Text = "When played, reduces \"Clear Memory\" by 1. Upon reaching 0, lock it for 1 turn and all Awakeners gain 30 Aliemus. Then reset to 5 at the start of next turn."
  },
  State_79406_Name = {
    Text = "The Illusion of Vanity"
  },
  State_80052_Desc = {Text = "Test"},
  State_80052_Name = {Text = "Test 123"},
  State_80052_WeaponDesc = {Text = "Test"},
  State_80161_Desc = {
    Text = "Team Unique: The wielder's Exalt Base DMG +<WeaponEffect_Num:[StateArg1]%>, and Keyflare Regen +<WeaponEffect_Num:[StateArg2]>. After entering Ultra Round, all Awakeners obtain <WeaponEffect_Num:[StateArg4]> Aliemus. After releasing \"Annihilation,\" the wielder obtains <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_80161_WeaponDesc = {
    Text = "The wielder's Exalt Base DMG +<WeaponEffect_Num:[StateArg1]%>, and Keyflare Regen +<WeaponEffect_Num:[DescArg1]>. After entering Ultra Round, all Awakeners obtain <WeaponEffect_Num:[StateArg4]> Aliemus. After releasing \"Annihilation,\" the wielder obtains <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_80174_Desc = {
    Text = "Team Unique: Increases the wielder's Keyflare Regen by <WeaponEffect_Num:[StateArg1]%>. At the start of the first battle, apply 1 stack of weakness and vulnerability to all enemies."
  },
  State_80174_WeaponDesc = {
    Text = "Increases the wielder's Keyflare Regen by <WeaponEffect_Num:[DescArg1]>. At the start of the first battle, inflict 1 stack of Weakness and Vulnerable on all enemies."
  },
  State_80207_Desc = {
    Text = [[
If currently not in Ultra Round, the first Command Card played this turn will trigger the following effect:
When a Quasar card is taken out of the Ultra Space, reduce its Arithmetica Cost by 1.]]
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Quasar>"
  },
  State_80328_Desc = {
    Text = "Her emotions, cognition, and everything else are eternally linked to the Hive Will. This effect stacks up to 15. \"Symbiosis\" can be transformed into debuff effects by Clementine's Exalt \"Lifeform Reconstruction.\""
  },
  State_80328_Name = {Text = "Symbiosis"},
  State_80331_Desc = {
    Text = "Under the erosion of the Hive, your weaknesses are fully exposed. DMG taken this turn increased by [DescArg1]％."
  },
  State_80331_Name = {
    Text = "<D13Colour:Psychic Trauma>"
  },
  State_80332_Desc = {
    Text = "Her emotions, cognition, and everything else are eternally linked to the Hive Will. This effect stacks up to 10. \"Symbiosis\" can be transformed into debuff effects by Clementine's Exalt \"Lifeform Reconstruction.\""
  },
  State_80332_Name = {Text = "Symbiosis"},
  State_80335_Desc = {
    Text = "Under the erosion of the Hive, your weaknesses are fully exposed. DMG taken this turn increased by [DescArg1]％."
  },
  State_80335_Name = {
    Text = "<D13Colour:Psychic Trauma>"
  },
  State_80336_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. DMG dealt this turn reduced by [DescArg1]％."
  },
  State_80336_Name = {
    Text = "<D13Colour:Phobic Fixation>"
  },
  State_80338_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. DMG dealt this turn reduced by [DescArg1]％."
  },
  State_80338_Name = {
    Text = "<D13Colour:Phobic Fixation>"
  },
  State_80575_Desc = {
    Text = "After suffering Active DMG or Tentacle DMG, remove an equivalent amount of \"Ancient Embers\" and lose 300% of the removal amount in HP; when suffering other types of Damage, remove half. The number of \"Ancient Embers\" resets each turn."
  },
  State_80575_Name = {
    Text = "Ancient Embers"
  },
  State_80644_Name = {
    Text = "State@Light of Transcendence"
  },
  State_80773_Desc = {
    Text = "When Strength is reduced, only 50% of Strength stacks will be reduced. During your own turn, the passive DMG taken is increased by 100%."
  },
  State_80773_Name = {
    Text = "Extradimentional Antibody"
  },
  State_80774_Desc = {
    Text = "After taking Active DMG or Tentacle DMG, remove an equal amount of \"Ancient Embers\" and lose 300% of the removal amount in HP; when taking other types of Damage, remove half. The stack count of \"Ancient Embers\" resets every turn. After all \"Ancient Embers\" are removed, gain 50 stacks of \"Fortress\"."
  },
  State_80774_Name = {
    Text = "Ancient Embers"
  },
  State_80776_Desc = {
    Text = "Card cannot be played and remains in hand at turn end."
  },
  State_80776_Name = {
    Text = "<BoundKeywords:Binding>"
  },
  State_80776_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_80777_Desc = {
    Text = "At the start of battle, reduce all Awakener's Crit. Rate by 10%. Upon death, other allies gain [DescArg1] Strength and [DescArg2] stacks of \"Ancient Embers\"."
  },
  State_80777_Name = {
    Text = "Hive Empathy: Legacy"
  },
  State_80778_Desc = {
    Text = "After death, other allies gain 1 stack of \"Temporary Madness\"."
  },
  State_80778_Name = {
    Text = "Hive Empathy: Fusion"
  },
  State_80782_Desc = {
    Text = "In this battle, all Awakeners' Crit. Rates -[Layer]％."
  },
  State_80782_Name = {
    Text = "Crit. Rate-"
  },
  State_80783_Desc = {
    Text = "At turn end, gain 1 stack of \"Madness.\""
  },
  State_80783_Name = {
    Text = "Kindred Bond"
  },
  State_80784_Desc = {
    Text = "When HP is below 50%, summon a \"First Variant\" in the back; it can only be triggered once per Battle."
  },
  State_80784_Name = {
    Text = "Hive Empathy: Fission"
  },
  State_80785_Desc = {
    Text = "STR Reduction only takes 50% effect on this enemy. Each time you releases Exalt, gain 1 stack of \"Temporary Madness.\""
  },
  State_80785_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80788_Desc = {
    Text = "STR Reduction only takes 25% effect on this enemy. Each time you releases Exalt, gain 1 stack of \"Temporary Madness.\""
  },
  State_80788_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80789_Desc = {
    Text = "Increase DMG received by 100%, lasting for 1 turn."
  },
  State_80789_Name = {Text = "Dormancy"},
  State_80790_Desc = {
    Text = "After the metamorphosis, each stack of Cosmic Ether will make it perfect..."
  },
  State_80790_Name = {
    Text = "Cosmic Ether"
  },
  State_80792_Desc = {
    Text = "Whenever you releases an Exalt, gain 1 stack of \"Temporary Madness\"."
  },
  State_80792_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80794_Desc = {
    Text = "Cards cannot be played and remain in hand at turn end."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Binding>"
  },
  State_80807_Desc = {
    Text = "When the fifth turn begins or is about to die, remove all other enemies and switch the intention to \"Metamorphosis Moment\"."
  },
  State_80807_Name = {
    Text = "Moment of Transformation"
  },
  State_80809_Desc = {
    Text = "At turn end, cards with Fleeting in hand will be discarded."
  },
  State_80809_Name = {
    Text = "<CardKeyWord:Fleeting>"
  },
  State_80810_Desc = {
    Text = "After suffering Active DMG or Tentacle DMG, remove an equivalent amount of \"Ancient Embers\" and lose 300% of the removal amount in HP; when suffering other types Damage, remove half. The number of \"Ancient Embers\" resets each turn."
  },
  State_80810_Name = {
    Text = "Ancient Embers"
  },
  State_80827_Desc = {
    Text = "For every 15 cards played, replace the current intention with \" Trauma Blow\" (currently remaining [Layer] cards)."
  },
  State_80827_Name = {
    Text = "Wrathful Punishment"
  },
  State_81022_WeaponDesc = {
    Text = "Each time DMG is taken, all Awakeners' Aliemus increases by 1."
  },
  State_81027_Desc = {
    Text = "The owner of this card is \"Insectoid\", Arithmetica Cost -1, Exhaust after played."
  },
  State_81027_Name = {
    Text = "Life Ritual"
  },
  State_81054_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. For each stack, DMG dealt this turn reduces by 3％, stacking up to 15 stacks."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Phobic Fixation>"
  },
  State_81055_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. For each stack, DMG taken this turn increases by 3％, stacking up to 10 stacks."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Psychic Trauma>"
  },
  State_81056_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. For each stack, DMG taken this turn increases by 3％, stacking up to 15 stacks."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Psychic Trauma>"
  },
  State_81057_Desc = {
    Text = "Under the erosion of the Hive, your fears are laid bare. For each stack, DMG dealt this turn reduces by 3％, stacking up to 10 stacks."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Phobic Fixation>"
  },
  State_81058_Desc = {
    Text = "Her emotions, cognition, and everything else are eternally linked to the Hive Will. \"Empathy\" can be transformed into debuff effects by Clementine's Exalt \"Lifeform Reconstruction,\" stacking up to 15 stacks."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Symbiosis>"
  },
  State_81059_Desc = {
    Text = "Her emotions, cognition, and everything else are eternally linked to the Hive Will. \"Symbiosis\" can be transformed into debuff effects by Clementine's Exalt \"Lifeform Reconstruction,\" stacking up to 10 stacks."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Symbiosis>"
  },
  State_81073_Desc = {
    Text = "Immediately restore all HP and gain 80% Temporary Fortress upon receiving Fatal DMG, summoning a \"First Variant\" at the back, can trigger 2 times."
  },
  State_81073_Name = {
    Text = "Hive Empathy: Fission"
  },
  State_81274_Desc = {
    Text = "At turn start, randomly apply \"Dissoluted Paint\" to 2 Command Cards without \"Dissoluted Paint.\""
  },
  State_81274_Name = {
    Text = "Lifeform Reconstruction"
  },
  State_81278_Desc = {
    Text = "After releasing a Posse for the first time each turn, all Awakeners gain 10 Aliemus, but the cost to release a Posse permanently increases by 10%."
  },
  State_81278_Name = {
    Text = "Silver Key Suppression"
  },
  State_81312_Desc = {
    Text = "After taking Fatal DMG, restore all HP and gain 50 stacks of Temporary reinforcement. It can also trigger [Layer] times."
  },
  State_81312_Name = {
    Text = "Cosmic Reincarnation"
  },
  State_81331_Desc = {
    Text = "At turn start, choose 1 Awakener, sealing all their cards and Exalt for 3 turns."
  },
  State_81331_Name = {
    Text = "Consciousness Imprisonment"
  },
  State_81340_Desc = {
    Text = "This card is sealed and cannot be played until [Layer] turns later when the seal is lifted."
  },
  State_81340_Name = {
    Text = "<AberrationColour:Card Seal>"
  },
  State_81341_Desc = {
    Text = "This Awakener's Exalt is sealed and cannot be used until [Layer] turns later when the seal is lifted."
  },
  State_81341_Name = {
    Text = "<AberrationColour:Aliemus Seal>"
  },
  State_81354_Desc = {
    Text = "Takes [DescArg1] DMG when played. If still in hand at turn end, Exhaust."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Burn>"
  },
  State_81356_Desc = {
    Text = "Card burns, takes [DescArg1] DMG when played. If still in hand at turn end, Exhaust."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Burn>"
  },
  State_81356_WeaponDesc = {
    Text = "Each stack of Stagnation increases the Arithmetica Cost of cards by 1."
  },
  State_83587_Desc = {
    Text = "Can enhance the effect when selecting \"Archor Off\", limit 10 stacks."
  },
  State_83587_Name = {Text = "Set Sail"},
  State_83589_Desc = {
    Text = "Can enhance the effect when selecting \"Harbored Rest\", up to 10 stacks."
  },
  State_83589_Name = {Text = "Moored Off"},
  State_83593_Desc = {
    Text = "All Final DMG caused by Awakeners in this turn is increased"
  },
  State_83593_Name = {Text = "Final DMG"},
  State_83596_Desc = {
    Text = "Hand Limit +1. If \"Navigator's Dilemma\" is not in the deck at turn start, add it to your hand. Gain 1 stack of \"Set Sail\" whenever the leader loses 10% of Max HP; gain 1 stack of \"Moored Off\" whenever you lose 10% of Max HP."
  },
  State_83596_Name = {
    Text = "Guidance of Erasmus: \"Set Sail\""
  },
  State_83607_Desc = {
    Text = "Boss cumulative loss of ten percent HP identifier"
  },
  State_83607_Name = {
    Text = "State@Boss cumulative loss ten percent life identifier"
  },
  State_83609_Desc = {
    Text = "Player cumulative loss ten percent HP identifier"
  },
  State_83609_Name = {
    Text = "State@Player cumulative loss ten percent life identifier"
  },
  State_83614_Desc = {
    Text = "10% Player Max HP"
  },
  State_83614_Name = {
    Text = "State@Player ten percent health value"
  },
  State_83615_Desc = {
    Text = "After losing [Layer] HP, gain 1 stack of \"Set Sail\"."
  },
  State_83615_Name = {
    Text = "\"Set Sail\" Progress"
  },
  State_83616_Desc = {
    Text = "After losing [Layer] HP, gain 1 stack of \"Moored Off\"."
  },
  State_83616_Name = {
    Text = "\"Moored Off\" Progress"
  },
  State_83617_Desc = {
    Text = "Boss at 10% health"
  },
  State_83617_Name = {
    Text = "State@Boss ten percent health value"
  },
  State_83618_Desc = {
    Text = "Current HP during testing: [Layer]"
  },
  State_83618_Name = {
    Text = "Current health count of the enemy"
  },
  State_83619_Desc = {
    Text = "Max HP during testing: [Layer]"
  },
  State_83619_Name = {
    Text = "Max health count of the enemy"
  },
  State_83620_Desc = {
    Text = "The current value of parameter 4 multiplied by 100 is [Layer]."
  },
  State_83620_Name = {
    Text = "Parameter Print"
  },
  State_83621_Desc = {
    Text = "Boss ten percent health loss counting midpoint"
  },
  State_83621_Name = {
    Text = "State@Boss ten percent health loss counting middle value"
  },
  State_83622_Desc = {
    Text = "Player ten percent health loss counting middle value"
  },
  State_83622_Name = {
    Text = "State@Player ten percent health loss counting middle value"
  },
  State_83627_Desc = {
    Text = "After losing [DescArg1] HP, gain 1 stack of \"Set Sail\""
  },
  State_83627_Name = {
    Text = "\"Set Sail\" Progress"
  },
  State_83808_Desc = {
    Text = "Triggers the \"Aftershock\" effect when discarded."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Aftershock>"
  },
  State_83811_Desc = {
    Text = "Take additional [Layer]% Tentacle DMG."
  },
  State_83812_Desc = {
    Text = "Take additional [Layer]% Tentacle DMG."
  },
  State_83814_Desc = {
    Text = "Boss at 10% health"
  },
  State_83814_Name = {
    Text = "Boss at ten percent health"
  },
  State_84140_Desc = {
    Text = "[Layer] \"Gland Division\" cards Exhausted through \"Clamorous Ocean\" in this battle."
  },
  State_84140_Name = {
    Text = "Clamorous Ocean"
  },
  State_84184_Name = {
    Text = "Enjoys an additional [Layer]% STR bonus"
  },
  State_84255_Desc = {
    Text = "Team Unique: At the start of battle, gain a Shield equal to <WeaponEffect_Num:[StateArg1]%> of the wielder's DEF. After triggering Death Resistance, trigger this effect again at the start of next turn."
  },
  State_84255_WeaponDesc = {
    Text = "At the start of battle, obtain <WeaponEffect_Num:[Block:DescArg1]> Shield. After triggering Death Resistance, trigger this effect again at the start of next turn."
  },
  State_84257_Desc = {
    Text = "Team Unique: The Shield caused by the wielder's Exalt increases by <WeaponEffect_Num:[StateArg1]%>. After releasing Exalt, all Awakeners' Temporary Crit. DMG increases by <WeaponEffect_Num:[StateArg2]%>, with each Tentacle increasing by 1%. After each exploration, trigger Resistance for the first time, restoring <WeaponEffect_Num:[StateArg3]%> of Max HP at the start of next turn"
  },
  State_84257_WeaponDesc = {
    Text = "The wielder's Exalt generates <WeaponEffect_Num:[StateArg1]%> more Shield. After using Exalt, all Awakeners gain <WeaponEffect_Num:[StateArg2]%> Temporary Crit. DMG, and each Tentacle grants an additional 1%. After triggering Death Resistance for the first time in each Exploration, recover <WeaponEffect_Num:[StateArg3]%> of Max HP at the start of next turn."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, restore HP to the ally that has lost the most HP <Heal:[Heal:StateArg1]>."
  },
  State_84272_Name = {
    Text = "Navigator at Sea"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped and at turn start, if there is no <PVPProtectiveKeywords:Barrier>, gain [StateArg1] stacks of <PVPProtectiveKeywords:Barrier>; otherwise, gain <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_84273_Name = {
    Text = "Flamebound Navigator"
  },
  State_84364_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_84364_Name = {Text = "Crit. DMG"},
  State_84368_Desc = {
    Text = "Remaining [Layer] turns cooldown."
  },
  State_84368_Name = {
    Text = "Sunken in the Profound"
  },
  State_84375_Desc = {
    Text = "At the start of turn, gain [Layer] Shield."
  },
  State_84375_Name = {
    Text = "Navigator at Sea"
  },
  State_84376_Desc = {
    Text = "At the beginning of the turn, heal [Layer] HP."
  },
  State_84376_Name = {
    Text = "Flamebound Navigator"
  },
  State_84399_Desc = {
    Text = "At the end of each turn, increase DMG taken by 5%, and gain 2 stacks of Barrier."
  },
  State_84399_Name = {
    Text = "Sunken in the Profound"
  },
  State_84400_Desc = {
    Text = "At the start of next turn, each barrier is converted into 1 stack of <ReinforcePVEKeywords:Fortress>."
  },
  State_84400_Name = {Text = "\"Pilot\""},
  State_84402_Desc = {
    Text = "Increase DMG taken by [Layer]%."
  },
  State_84402_Name = {
    Text = "Overdraw Strength"
  },
  State_89340_Desc = {
    Text = "Take additional [Layer]% Tentacle DMG."
  },
  State_89340_Name = {
    Text = "Tentacle Vulnerable"
  },
  State_89422_Desc = {
    Text = "All Awakeners generate 100% more Aliemus and can unleash Exalt 2 times per turn."
  },
  State_89422_Name = {
    Text = "\"Unyielding Heart\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Maximum Hand Size + [StateArg2]. Gain [StateArg1] Arithmetica after \"Exalt\"."
  },
  State_89447_Name = {
    Text = "Unbearable Freedom"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, the ally with the lowest HP and Shield will gain [StateArg1] <PVPDerivativeCardKeywords_16:\"Onyx Plume\">."
  },
  State_89448_Name = {
    Text = "Lone Feather"
  },
  State_89554_Name = {
    Text = "Light Cone of Fate"
  },
  State_89555_Desc = {
    Text = "Team Unique: After the wielder releases Exalt, the Base DMG of Exalt is increased by <WeaponEffect_Num:[StateArg1]%>, Shield and HP Recovery are increased by <WeaponEffect_Num:[StateArg2]%>, stacking up to 5 times. After completing exploration, the Affinity gained by the wielder increases by <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "After the wielder releases Exalt, the Base DMG of Exalt is increased by <WeaponEffect_Num:[StateArg1]%>, Shield Generation and HP Recovery are increased by <WeaponEffect_Num:[StateArg2]%>, stacking up to 5 times. After completing exploration, the Affinity obtained by the wielder increases by <WeaponEffect_Num:[StateArg3]>%."
  },
  State_89557_Name = {
    Text = "Prismatic Lens"
  },
  State_89559_Desc = {
    Text = [[

<Blue:Existence Paradox:> At the start of exploration, 75% of Death Resistance is converted into Max HP Bonus, up to a maximum of 300% Death Resistance, increasing Max HP by up to 10%. Each time Death Resistance is triggered, place 1 "Silver Key Gleam" into hand.

<Blue:Bottomless Scar>: In Boss Battle, every time the HP recovered by your team reaches 100% of Max HP, subsequent healing effects are reduced by 25%. This also multiplies the total amount of current Death Resistance by 1.25 (a 25% increase). Triggers a maximum of 3 times.

<Blue:Prismatic Lens>: At the start of the turn: if Counter exceeds 2000% of Max HP, the excess stacks are halved, and Permanent Counter can stack up to 6000% of Max HP; if an enemy's Poison exceeds 3000% of Max HP, the excess stacks are halved, and Poison can stack up to 9000% of Max HP. The DMG increase Awakeners gain from Counter is reduced by 70%, but all Poison and Counter effects dealt increase by 10%. Each time an Awakener is roused: at the end of the turn, gain Temporary Counter equal to 25% of the current Permanent Counter, and at the end of the enemy's turn, trigger an additional 25% Poison on all enemies.

<Blue:Light Cone of Fate>: The number of turns for normal monsters to unleash "Gaze" is changed to 6 turns. At the start of the 15th turn, place 1 "Light Cone Boundary" into hand: gain Keyflare equal to the Keyflare Limit, and all Awakeners gain Aliemus equal to their Aliemus Limit.]]
  },
  State_89559_Name = {
    Text = "Time Distortion"
  },
  State_89567_Desc = {
    Text = "Reduce this Card's Arithmetica Cost by [StateArg1]."
  },
  State_89567_Name = {
    Text = "Annihilated Rebirth"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After the wielder dies, shuffle all \"Skills\" that consume Arithmetica -[StateArg1] into the Draw Pile, with the owner changed to the allied unit with the highest remaining HP."
  },
  State_89568_Name = {
    Text = "Annihilated Rebirth"
  },
  State_89571_Name = {
    Text = "\"Burning Theater\""
  },
  State_89572_Desc = {
    Text = "At turn start, randomly add [DescArg1] cards to the hand deck with the <BurningKeywords:Burn> effect, gaining [DescArg2] Temporary power. Every 2 turns, the number of added burning cards increases by 1, and the gained Temporary power increases by [DescArg3]."
  },
  State_89572_Name = {
    Text = "\"Burning Theater\""
  },
  State_89626_Desc = {
    Text = "After Keyflare Rouse, place 1 card \"Silver Key Gleam\" into hand. After all Awakeners have awakened, discover 1 random Awakeners' Support card at turn start."
  },
  State_89631_Desc = {
    Text = "Extra [Layer] Transitions"
  },
  State_89634_Desc = {Text = "Rouse 4"},
  State_89634_Name = {Text = "Rouse 4"},
  State_89637_Desc = {
    Text = "The first Command Card of each turn will take effect an extra time. Generate 1 Tentacle upon Annilation. After switching the Tentacle to \"Raging Tide\" stance, the Leap effect of 2 Command Cards in this turn must trigger, entering the Ultra Space, with a cooldown of 3 turns."
  },
  State_89640_Desc = {
    Text = "Realm Mastery increased by 200 points. When consuming the Crimson Furnace, Tentacle DMG increased by 15%. Accumulate [Arg3] Crimson Furnace with each Tentacle attack."
  },
  State_89642_Desc = {
    Text = "Hand Limit +2, after Exalt, Temporary Final DMG increases by 10%. After the card enters the Ultra space, 1 \"Embryo\" in hand transforms into \"Scion of Purity\". Each time 1 \"Embryo\" is generated, the cost of a random card in the Ultra Space decreases by 1."
  },
  State_89669_Desc = {
    Text = "Keyflare Rouse 4"
  },
  State_89669_Name = {
    Text = "Keyflare Rouse 4"
  },
  State_89759_Desc = {
    Text = "After releasing the Posse, Ramona gains a Temporary Crit. Rate of 50%."
  },
  State_89759_Name = {
    Text = "Precious Ties"
  },
  State_90023_Name = {
    Text = "State used for configuration of the constant table, temporarily discarded."
  },
  State_90059_Name = {Text = "Corrosion"},
  State_90218_Desc = {
    Text = [[
Team Unique: Hand Limit +2. Effects of the same type cannot stack. The wielder's Base DMG and Shield Generation are increased by <WeaponEffect_Num:[StateArg1]%>.
Obtain <WeaponEffect_Num:[StateArg2]> Aliemus upon entering the Ultra Round.
Release "Annihilation" to grant all Awakeners Temporary Crit. DMG +<WeaponEffect_Num:[StateArg3]%>. This effect has a Cooldown of 3 turns.]]
  },
  State_90218_WeaponDesc = {
    Text = [[
Hand Limit +2. Effects of the same type cannot stack. The wielder's Base DMG and Shield Generation are increased by <WeaponEffect_Num:[StateArg1]%>.
Obtain <WeaponEffect_Num:[StateArg2]> Aliemus upon entering the Ultra Round.
Release "Annihilation" to grant all Awakeners Temporary Crit. DMG +<WeaponEffect_Num:[StateArg3]%>. This effect has a Cooldown of 3 turns.]]
  },
  State_90221_Desc = {
    Text = "Team Unique: The wielder's Shield Generation increases by <WeaponEffect_Num:[StateArg1]%>. Gain Shield equal to <WeaponEffect_Num:[StateArg2]%> of the wielder's DEF at turn end, which increases by 2% of the wielder's DEF per turn."
  },
  State_90221_WeaponDesc = {
    Text = "The wielder's Shield Generation increases by <WeaponEffect_Num:[StateArg1]%>. Gain Shield equal to <WeaponEffect_Num:[Block:DescArg1]> at turn end."
  },
  State_90294_Desc = {
    Text = "When taking Active DMG or Tentacle DMG, remove an equivalent amount of Corrosion stacks and suffer HP loss equal to 300% of the removed stacks. Other types of DMG removes Corrosion stacks at 50% effectiveness."
  },
  State_90294_Name = {
    Text = "<Corrosion:Corrosion>"
  },
  State_90591_Name = {
    Text = "Put [Layer] \"Insight\" cards into your hand"
  },
  State_90594_Name = {
    Text = "with [Layer] Temporary Alert"
  },
  State_90599_Name = {
    Text = "All Awakeners gain [Layer] Aliemus."
  },
  State_90600_Name = {
    Text = "Gain [Layer] Keyflare points"
  },
  State_90601_Name = {
    Text = "([DescArg1] <harmonyKeyWord: \"Seasoning\"> attempts left)"
  },
  State_90603_Name = {
    Text = "Gain [Layer] Temporary STR"
  },
  State_90604_Name = {
    Text = "Restore [Layer] HP, increases with lost HP"
  },
  State_90696_Desc = {
    Text = "Before playing, discover 1 \"Seasoning\" to place in it and trigger its effect, increasing the number of harmonization attempts by 1 in boss battles."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:Seasoning>"
  },
  State_91106_Desc = {
    Text = "Each stack of \"Fervor\" converts 10% of the Active DMG and Tentacle DMG dealt into <BleedingIconKeywords:Bleed> stacks."
  },
  State_91106_Name = {Text = "Fervor"},
  State_91235_Desc = {
    Text = "When taking DMG, reduce an equal number of stacks. When Injury reaches 0, all Awakeners gain 10 Aliemus and reset Injury stacks."
  },
  State_91235_Name = {Text = "Injury"},
  State_91236_Name = {
    Text = "Roma Event Apply Boss HP Count"
  },
  State_91329_Desc = {
    Text = "Reduce this Card's Arithmetica Cost by [StateArg1]."
  },
  State_91329_Name = {
    Text = "Macabre Delicacies"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: At turn end, shuffle [StateArg1] <PVPDerivativeCardKeywords_17:\"Insight\"> into Hand."
  },
  State_91521_Name = {
    Text = "Special Training"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: When equipped and at turn end, the wielder deals <Damage:[Damage:StateArg1]> DMG to the back-row enemy."
  },
  State_91522_Name = {Text = "School Day"},
  State_91676_Desc = {
    Text = "For specific effects, see the basic Strike logic."
  },
  State_91706_Desc = {
    Text = "Gain an equal number of Arithmetica stacks at the start of next turn."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Retain Arithmetica>"
  },
  State_91717_Desc = {
    Text = "Corpses can be eaten by certain Caro Awakener(s) to trigger special effects. You can keep up to 3 Corpses, which is carried over to the next battle."
  },
  State_91717_Name = {Text = "Corpse"},
  State_91759_Desc = {
    Text = "\"Onyx Plume\" can enhance the abilities of \"Divus: The Onyx Plume\"."
  },
  State_91759_Name = {Text = "Onyx Plume"},
  State_91761_Desc = {
    Text = "\"Divus: The Onyx Plume\" retains 50% of the unbroken Shield for the next turn and gains 1 stack of <Guaiwuheiyu:Onyx Plume>. at turn end."
  },
  State_91761_Name = {
    Text = "Skybound Oath"
  },
  State_91797_Desc = {
    Text = "After this card is played and discarded, apply this amount of Shield to the front-row enemies."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Veiled Anguish>"
  },
  State_91799_Desc = {
    Text = "This card applies [Layer] Shield to the frontmost enemy when played."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Veiled Anguish [Layer] >"
  },
  State_91809_Desc = {
    Text = "This card's Arithmetica Cost -[Layer]."
  },
  State_91809_Name = {
    Text = "Elevated Focus"
  },
  State_91819_Desc = {
    Text = "Gains the corresponding enhancement based on the current battle turn."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Growth>"
  },
  State_91827_Desc = {
    Text = "\"Strike\" can select a target. Before \"Strike\", all positive status effects of the target are knocked back to the Awakener behind it."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Deep Sea's Call>"
  },
  State_94410_Name = {
    Text = "Will attempt to reset an empty player deck at turn start and after turn end. A non-empty deck will not reset."
  },
  State_94411_Name = {
    Text = "Will attempt to reset an empty player deck at turn start and after turn end. A non-empty deck will not reset."
  },
  State_94426_Name = {
    Text = "Passive Shield"
  },
  State_94540_Desc = {
    Text = "If there is no other Awakeners behind the target, dispel the target's buffs instead."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Forceback Buffs>"
  },
  State_94600_Desc = {
    Text = "Remove 1 stack and restore 5% of Max HP after receiving Fatal DMG. Each trigger increases the healing amount by 1% for this turn."
  },
  State_94600_Name = {
    Text = "Death Resistance"
  },
  State_94603_Name = {Text = "Ghoul Mark"},
  State_94608_Name = {
    Text = "Death Resistance Trigger Count"
  },
  State_94623_Desc = {
    Text = "Each stack of \"Fervor\" converts 10% of the Active DMG and Tentacle DMG dealt into <BleedingIconKeywords:Bleed> stacks."
  },
  State_94623_Name = {
    Text = "<Kuangre:Fervor>"
  },
  State_94657_Desc = {
    Text = "Trigger corresponding effects when killing or activating the enemy's resurrection effect"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Kill>"
  },
  State_94692_Desc = {
    Text = "Remove 1 stack and restore 5% of Max HP after receiving Fatal DMG. Each trigger increases the healing amount by 1% for this turn."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Death Resistance>"
  },
  State_94693_Desc = {
    Text = "At the start of the turn, if there are other allies present, lose [DescArg1] HP and grant the ally with the highest HP 1 stack of <Guaiwusiwangdikang:Death Resistance> and [DescArg2] <PowerIconKeywords:STR>."
  },
  State_94693_Name = {
    Text = "Carrion Sharing"
  },
  State_94708_Desc = {
    Text = "At the start of the turn, if there are other allies present, lose [DescArg1] HP and grant the ally with the highest HP 1 stack of <Guaiwusiwangdikang:Death Resistance> and [DescArg2] <Duren:Poison Blade>."
  },
  State_94708_Name = {
    Text = "Aequor's Banquet"
  },
  State_94730_Desc = {
    Text = "When dealing unblocked damage, apply [Layer] <IntoxicationIconKeywords:Poison> per stack."
  },
  State_94730_Name = {
    Text = "Poison Blade"
  },
  State_94993_Desc = {
    Text = "Resets the number of Terrifying Tsunamis each turn."
  },
  State_94993_Name = {
    Text = "Furious Waves Count Reset"
  },
  State_94994_Desc = {
    Text = "Each layer adds 1 to the number of attacks, loses 1 layer upon receiving critical damage, with a minimum of 1 layer, and loses all stacks at the end of the round."
  },
  State_94994_Name = {
    Text = "Furious Waves Count"
  },
  State_94995_Desc = {
    Text = "Each time taking Crit. DMG, gain 3% <Baojidikang:Temporary Crit. Resistance>. Each time dealing DMG, apply \"Polluted: Mark of Abyss\" to a random card."
  },
  State_94995_Name = {
    Text = "Deep Sea Rite"
  },
  State_94996_Desc = {
    Text = "When taking DMG, gain an equal number of Temporary STR."
  },
  State_94996_Name = {Text = "Fury"},
  State_94997_Desc = {
    Text = "Each time taking Crit. DMG, gain 5% <Baojidikang:Temporary Crit. Resistance>. Each time dealing DMG, apply \"Polluted: Mark of Abyss\" to a random card."
  },
  State_94997_Name = {
    Text = "Deep Sea Rite"
  },
  State_94998_Desc = {
    Text = "When <Guaiwusiwangdikang:Death Resistance> is triggered, apply <SlowIconKeywords:Stagnation> to a random card in the Draw Pile or Hand."
  },
  State_94998_Name = {
    Text = "Despair Incarnate"
  },
  State_94999_Desc = {
    Text = "Resets the number of Devourer Waves each turn."
  },
  State_94999_Name = {
    Text = "Devouring Waves Count Reset"
  },
  State_95000_Desc = {
    Text = "Gains immunity to negative states."
  },
  State_95000_Name = {
    Text = "Immune to Debuffs"
  },
  State_95001_Desc = {
    Text = "Each layer adds 1 to the number of attacks, loses 1 layer upon receiving critical damage, with a minimum of 1 layer, and loses all stacks at the end of the round."
  },
  State_95001_Name = {
    Text = "Devouring Waves Count"
  },
  State_95002_Desc = {
    Text = "The chance of being critically hit is reduced by [Layer]% this turn."
  },
  State_95002_Name = {
    Text = "Temporary Crit. Resistance"
  },
  State_95002_WeaponDesc = {
    Text = "Critical Hit chance reduced by [Layer]% this turn."
  },
  State_95035_Desc = {
    Text = "When dealing unblocked damage, apply 1 <IntoxicationIconKeywords:Poison> per stack."
  },
  State_95035_Name = {
    Text = "<Duren: Poison Blade>"
  },
  State_95038_Desc = {
    Text = "When taking DMG, gain an equal number of Temporary STR."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Fury>"
  },
  State_95040_Desc = {
    Text = "Record has lost life"
  },
  State_95040_Name = {
    Text = "Record has lost life"
  },
  State_95932_Name = {
    Text = "Drain Ghoul Vigil"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After using \"Exalt\", draw [StateArg1] cards, prioritizing your own \"Skill\" cards, and reduce their Arithmetica Cost by [StateArg2]."
  },
  State_95937_Name = {
    Text = "Macabre Delicacies"
  },
  State_95938_Desc = {
    Text = "For each card removed, gain 1 stack of Fullness, up to 10 stacks."
  },
  State_95938_Name = {Text = "Fullness"},
  State_95943_Desc = {
    Text = "The damage dealt is temporarily reduced by 30%."
  },
  State_95943_Name = {
    Text = "Frontal Interference"
  },
  State_95944_Desc = {
    Text = "Team Unique: The wielder's Base DMG +<WeaponEffect_Num:[StateArg1]%> During this exploration, every time the wielder kills an enemy, their Crit. Rate +2% and Exalt Base DMG +<WeaponEffect_Num:[StateArg2]%>, up to 10 times. If the current Realm is Caro, the wielder gains an extra <WeaponEffect_Num:[StateArg4]> Aliemus when they directly consume Embryo (cooldown 3 turns)."
  },
  State_95944_WeaponDesc = {
    Text = "Team Unique: The wielder's Base DMG +<WeaponEffect_Num:[StateArg1]%> During this exploration, every time the wielder kills an enemy, their Crit. Rate +2% and Exalt Base DMG +<WeaponEffect_Num:[StateArg2]%>, up to 10 times. If the current Realm is Caro, the wielder gains an extra <WeaponEffect_Num:[StateArg4]> Aliemus when they directly consume Embryo (cooldown 3 turns)."
  },
  State_95948_Name = {
    Text = "Siphon Ghoul"
  },
  State_95949_Desc = {
    Text = "After playing, Doresain loses half of the <Guaiwucanhai:Wreckage>."
  },
  State_95949_Name = {
    Text = "Ambush Reserve"
  },
  State_95953_Desc = {
    Text = "The healing effect of Death Resistance is 5x increased."
  },
  State_95953_Name = {
    Text = "Veil of Murmurs"
  },
  State_95954_Name = {
    Text = "Siphon Ghoul: Awakened Edition"
  },
  State_95960_Desc = {
    Text = "\"Corpse\" stacks enhance the effect of \"Corpse Collection\"."
  },
  State_95960_Name = {Text = "Corpse"},
  State_95962_Name = {Text = "Kill Count"},
  State_95964_Desc = {
    Text = "Team Unique: The wielder's Base DMG +<WeaponEffect_Num:[StateArg1]%>. Whenever the wielder kills an enemy, accumulate Crimson Furnace equal to <WeaponEffect_Num:[StateArg2]%> of the wielder's ATK if the current Realm is Caro."
  },
  State_95964_WeaponDesc = {
    Text = "The wielder's Base DMG +<WeaponEffect_Num:[StateArg1]%>%. Whenever the wielder kills an enemy, accumulate Crimson Furnace equal to <WeaponEffect_Num:[DescArg1]>."
  },
  State_95966_Desc = {
    Text = "At the start of the next turn, draw [Layer] cards of this Awakener."
  },
  State_95966_Name = {
    Text = "Cruel Homage"
  },
  State_95967_Desc = {
    Text = "\"Corpse\" stacks enhance the effect of \"Corpse Collection\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Corpse>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gain [StateArg1] <StrongEffectKeywords:Amplification> when equipped. When the wielder kills an enemy, the overflowing DMG transfers to the Awakener behind."
  },
  State_95968_Name = {
    Text = "Kiss of Repose"
  },
  State_96167_Desc = {
    Text = "Cannot be dispelled. After an Awakener is killed, other allies receive [StateArg1] <StrongEffectKeywords:Amplification>."
  },
  State_96167_Name = {
    Text = "Black Star Ember"
  },
  State_96183_Desc = {
    Text = "At turn end, if there are no other allies on the field, switch to self-destruct mode."
  },
  State_96183_Name = {
    Text = "Ghoul Self-Destruct"
  },
  State_96193_Name = {
    Text = "Feast's Overture"
  },
  State_96268_Desc = {
    Text = "At the start of the turn, gain 1 stack of <Guaiwucanhai:Wreckage>"
  },
  State_96268_Name = {
    Text = "Crimson Invite"
  },
  State_96330_Desc = {
    Text = "For every 1% HP lost, the Base DMG, Shield, and Aliemus provided by Doresain's Command Cards increase by 1%."
  },
  State_96330_Name = {
    Text = "Hollow Whispers"
  },
  State_96352_Name = {
    Text = "Initial Ghoul Count"
  },
  State_96354_Name = {
    Text = "Starting Max HP"
  },
  State_96355_Desc = {
    Text = "Critical Hit chance is reduced by [Layer]%."
  },
  State_96355_Name = {
    Text = "Crit. Resistance"
  },
  State_96355_WeaponDesc = {
    Text = "The chance of being critically hit in this battle is reduced by [Layer]%."
  },
  State_96356_Desc = {
    Text = "For every [DescArg1] HP lost, gain [DescArg2] stack(s) of <ReinforcePVEKeywords:Fortress>, up to [DescArg3] stacks. After triggering \"<Guaiwusiwangdikang:Death Resistance>\", the target's max HP increases by [DescArg4]%."
  },
  State_96356_Name = {
    Text = "Elena's Protection"
  },
  State_96357_Desc = {
    Text = "After turn end, gain an equal number of stacks of Strength."
  },
  State_96357_Name = {
    Text = "<Fennu:Anger>"
  },
  State_96358_Desc = {
    Text = "Critical Hit chance reduced by [Layer]%."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Crit. Resistance>"
  },
  State_96412_Name = {
    Text = "Gluttonous Beast Listener"
  },
  State_96416_Desc = {
    Text = "Critical Hit chance is reduced by [Layer]%."
  },
  State_96416_Name = {
    Text = "Crit. Resistance"
  },
  State_96603_Name = {
    Text = "If not played this turn, trigger the \"Harmony\" effect once at the start of the next turn."
  },
  State_96610_Name = {
    Text = "First Death Resistance"
  },
  State_96613_Name = {
    Text = "Listening to the Giant Waves"
  },
  State_96650_Desc = {
    Text = "Each stack increases all Awakener's Crit. Rate by [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Blackened Flame>"
  },
  State_96719_Desc = {
    Text = "When playing cards with <BurningKeywords:Burn> this turn, consume 1 stack of  <Heat:Blackened Flame> to make said card take effect twice. Clear all <Heat:Blackened Flame> at turn end."
  },
  State_96719_Name = {
    Text = "Endless Combustion"
  },
  State_96731_Desc = {
    Text = "No longer gain <Heat:Blackened Flame> when playing cards with <BurningKeywords:Burn> this turn. Instead, consume 1 stack of  <Heat:Blackened Flame> to make said card take effect twice. Clear all <Heat:Blackened Flame> at turn end."
  },
  State_96731_Name = {
    Text = "<Overload:Endless Combustion>"
  },
  State_96732_Desc = {
    Text = "Each stack increases all Awakener's Crit. Rate by [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Blackened Flame>"
  },
  State_96740_Desc = {
    Text = "Active DMG taken +50%. Removed when taking damage or at turn start."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Falter>"
  },
  State_96741_Desc = {
    Text = "After playing, if remaining Arithmetica is greater than [StateArg1], additionally consume [StateArg1] Arithmetica to trigger subsequent effects."
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Arithmetica Overload>"
  },
  State_96742_Name = {
    Text = "Arithmetica overload triggers mark"
  },
  State_96743_Desc = {
    Text = "After playing, if remaining Arithmetica exceeds the Arithmetica Overload required amount, additionally consume Arithmetica to trigger subsequent effects."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Arithmetica Overload>"
  },
  State_96744_Desc = {
    Text = "Active DMG and Bleed stacks taken +50%. Removed when taking DMG or at turn start."
  },
  State_96744_Name = {Text = "Falter"},
  State_96774_Desc = {
    Text = "Each time Crit. DMG is received, gain 3% Temporary Critical Resistance."
  },
  State_96774_Name = {
    Text = "Deep Sea Wraith"
  },
  State_96780_Desc = {
    Text = "The Card is Retained, but when played or discarded, remove Pollution and summon 1 \"Seafarer Excrescence\", up to 2. If there is no space to summon, immediately grant the Puppet of Putrescence [DescArg1] STR and [DescArg2] HP."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Seafarer Frenzy>"
  },
  State_96783_Desc = {
    Text = "Apply \"<Kuangluan:Polluted: Seafarer Frenzy>\" to 2 cards each turn."
  },
  State_96783_Name = {
    Text = "Seafarer Ritual"
  },
  State_96784_Desc = {
    Text = "Can reduce the assault of Puppet of Putrescene, up to 5 stacks."
  },
  State_96784_Name = {Text = "Chaos"},
  State_96808_Desc = {
    Text = "For every [DescArg1] HP lost, gain 15 stacks of \"<ReinforcePVEKeywords:Fortress>\", up to 75 stacks. When broken, remove all stacks and gain 1 stack of \"<Chaos:Chaos>\". If Reformation has not been unleashed, upon receiving Fatal DMG, switch Intention to \"Reformation\" and become Immune to all damage."
  },
  State_96808_Name = {
    Text = "Chimera Puppet"
  },
  State_96809_Name = {
    Text = "Chimera's Puppet Count"
  },
  State_96810_Desc = {
    Text = "DMG dealt -25%."
  },
  State_96810_Name = {
    Text = "Veil of Murmurs"
  },
  State_96813_Name = {
    Text = "Reconstruct Marker"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" gains [StateArg1] Arithmetica, \"Skill\" DMG +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Impending Sun"
  },
  State_97118_Name = {
    Text = "Chimeric Puppet Break"
  },
  State_97119_Desc = {
    Text = "The Card is Retained, but when played or discarded, remove Pollution and summon 1 \"Seafarer Excrescence\", up to 2. If there is no space to summon, the Puppet of Putrescence immediately gains [DescArg1] Strength and [DescArg2] HP."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Seafarer Frenzy>"
  },
  State_97120_Desc = {
    Text = "Protected by the magic circle, damage from all enemies is reduced by 25%."
  },
  State_97120_Name = {
    Text = "Veil of Murmurs"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Skill\" DMG +[StateArg1]%, for each 1 Arithmetica consumed by the wielder, the DMG of \"Exalt\" +[StateArg2]% this turn. (currently +[DescArg1]% in total)."
  },
  State_97131_Name = {
    Text = "Amber-Tinted Death"
  },
  State_97134_Desc = {
    Text = "Final DMG +50%"
  },
  State_97134_Name = {
    Text = "Celina's Chant"
  },
  State_97135_Desc = {
    Text = "Final DMG +25%."
  },
  State_97135_Name = {
    Text = "Celina's Murmur"
  },
  State_97136_Desc = {
    Text = "Final DMG +100%"
  },
  State_97136_Name = {
    Text = "Celina's Aria"
  },
  State_97137_Desc = {
    Text = "Discard and then return to hand."
  },
  State_97137_Name = {
    Text = "Discard and then return to hand"
  },
  State_97137_WeaponDesc = {
    Text = "When drawn, apply Weakness to self for 1 turn. When used, apply Weakness to all enemies for 1 turn. Cannot be sold."
  },
  State_97219_Name = {
    Text = "Queen of thorns"
  },
  State_97251_Desc = {
    Text = [[
Cannot be targeted or prioritized by enemy attacks or single-target abilities.
Automatic Removal: If the unit gains Taunt; If there are no allies remaining; If any enemy gains Taunt.
On Activation: Removes current Stealth and any allies' Taunt.]]
  },
  State_97251_Name = {Text = "Stealth"},
  State_97252_Desc = {
    Text = [[
Cannot be targeted or prioritized by enemy attacks or single-target abilities.
Automatic Removal: If the unit gains Taunt; If there are no allies remaining; If any enemy gains Taunt.
On Activation: Removes current Stealth and any allies' Taunt.]]
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Stealth>"
  },
  State_97742_Desc = {
    Text = "Deal [Layer] damage to the attacker when hit."
  },
  State_97742_Name = {Text = "Counter"},
  State_97743_Desc = {
    Text = "Active DMG dealt increased by [Layer]."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:STR>"
  },
  State_97744_Desc = {
    Text = "Damage received is reduced by [Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:Fortress>"
  },
  State_97744_WeaponDesc = {
    Text = "Reduce all damage dealt by [DescArg1]%."
  },
  State_97938_Desc = {
    Text = "Final DMG increased by [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Winner's Cup"
  },
  State_97939_Desc = {
    Text = "Final DMG dealt is increased by 50%."
  },
  State_97939_Name = {
    Text = "Winner's Cup"
  },
  State_97941_Desc = {
    Text = "Base DMG increased by 100%."
  },
  State_97941_Name = {
    Text = "Winner's Cup"
  },
  State_97942_Desc = {
    Text = "Gain 35 Aliemus after using Exalt."
  },
  State_97942_Name = {
    Text = "Winner's Cup"
  },
  State_97943_Name = {
    Text = "Arithmetica Retain Count"
  },
  State_98055_Desc = {
    Text = "At the end of the round, generate 1 Tentacle. State is removed upon Awaken."
  },
  State_98055_Name = {Text = "Slumber"},
  State_98060_Desc = {
    Text = "This Awakener is still Unawakened... It will Rouse when about to be defeated, restore Life, and begin battling in its true form."
  },
  State_98060_Name = {Text = "Not Roused"},
  State_98068_Desc = {
    Text = "When \"Combust\" reaches 10 stacks, gain 2 Arithmetica and upgrade all \"Solarflare\" to \"Hyperflare\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Combust>"
  },
  State_98139_Desc = {
    Text = "Randomly <BurningKeywords:Burn> 1 card from the opponent's hand at the start of their turn."
  },
  State_98139_Name = {
    Text = "Karmic Embers"
  },
  State_98140_Desc = {
    Text = "After accumulating 10 stacks of <MonsterExFlameKeywords:Combust>, switch intention to the extremely high-damage \"Hyperflare\"!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Combust>"
  },
  State_98147_Desc = {
    Text = "When the enemy plays cards with <BurningKeywords:Burn>, gain 1 stack of <MonsterExFlameKeywords:Combust>, but temporarily lose [DescArg1] <PowerIconKeywords:STR>."
  },
  State_98147_Name = {
    Text = "Everburning Flame"
  },
  State_98148_Desc = {
    Text = "This Awakener is still not Roused... They will Rouse when about to be defeated, discard all remaining hand cards and grant <BurningKeywords:Burn>, restore HP, and fight with full power."
  },
  State_98148_Name = {Text = "Not Roused"},
  State_98302_Desc = {
    Text = "Team Unique: The wielder's Base DMG dealt +<WeaponEffect_Num:[StateArg1]%>, and STR Generation +<WeaponEffect_Num:[StateArg2]%>. After playing the wielder's Command Card, gain Temporary STR equal to <WeaponEffect_Num:[StateArg3]%> of the wielder's ATK, triggering up to 5 times per turn."
  },
  State_98302_WeaponDesc = {
    Text = "The wielder's Base DMG dealt +<WeaponEffect_Num:[StateArg1]%>, and STR generated +<WeaponEffect_Num:[StateArg2]%>. After playing the wielder's Command Card, gain <WeaponEffect_Num:[Power:DescArg1]> Temporary STR, triggering up to 5 times per turn. (currently triggered [DescArg2]/5 times)."
  },
  State_98323_Desc = {
    Text = "The card returns to your hand after being discarded"
  },
  State_98323_Name = {
    Text = "Returns to Hand"
  },
  State_98341_Desc = {
    Text = "Can be mixed with other primary colors to create new colors."
  },
  State_98341_Name = {
    Text = "<Yellow:Color: Yellow>"
  },
  State_98344_Desc = {
    Text = "Can be blended with other primary colors to create new hues."
  },
  State_98344_Name = {
    Text = "<Red:Color: Red>"
  },
  State_98345_Desc = {
    Text = "Can be mixed with other primary colors to create new colors."
  },
  State_98345_Name = {
    Text = "<Blue:Color: Blue>"
  },
  State_98366_Desc = {
    Text = "At turn start, if Keyflare is greater than [Arg1], consume [Arg1] Keyflare to put 1 <DerivativeCardKeywords_115:\"Adv. Insight\"> into your hand."
  },
  State_98435_Desc = {
    Text = "A blend of red and blue. For each instance of active damage dealt, gain <Block:[DescArg1]> Shield."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Vision: Purple>"
  },
  State_98436_Desc = {
    Text = "A blend of red and yellow. After releasing the Exalt, the corresponding Awakener gains <Energy:15> Aliemus."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Vision: Orange>"
  },
  State_98437_Desc = {
    Text = "Final DMG increased by 10%."
  },
  State_98437_Name = {
    Text = "<Red:Color: Red>"
  },
  State_98438_Desc = {
    Text = "A blend of yellow and blue. After playing \"Defense\", restore <Heal:[DescArg1]> HP."
  },
  State_98438_Name = {
    Text = "<GreenWord:Vision: Green>"
  },
  State_98439_Desc = {
    Text = "A blend of yellow and blue. After playing \"Defense\", restore <Heal:[DescArg1]> HP."
  },
  State_98439_Name = {
    Text = "<GreenWord:Vision: Green>"
  },
  State_98440_Desc = {
    Text = "A blend of red and blue. For each instance of active damage dealt, gain <Block:[DescArg1]> Shield."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Vision: Purple>"
  },
  State_98441_Desc = {
    Text = "A blend of red and yellow. After releasing the Exalt, the corresponding Awakener gains <Energy:15> Aliemus."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Vision: Orange>"
  },
  State_98444_Desc = {
    Text = "Team Unique: The wielder's Base DMG is boosted by <WeaponEffect_Num:[StateArg1]%>. After playing 5 Command Cards from the wielder, the wielder gains <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate. This effect can only trigger once per turn."
  },
  State_98444_WeaponDesc = {
    Text = "Base DMG dealt by the wielder is increased by <WeaponEffect_Num:[StateArg1]%>. After playing 5 Command Cards of the wielder, the wielder gains <WeaponEffect_Num:[StateArg2]%> Temporary Crit. Rate, and this effect can only trigger once per turn (currently played [DescArg1]/5 cards)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98474_Desc = {
    Text = "The primary colors that can be mixed to create other colors, consisting of red, yellow, and blue."
  },
  State_98474_Name = {Text = "Color"},
  State_98484_Name = {
    Text = "Drowning in Sorrow"
  },
  State_98485_Desc = {
    Text = "The Final DMG, Shield, Aliemus, and STR granted by this card +[DescArg1]%. Gains \"Retain\". After playing, consume all \"Fiamma\" stacks, and  transfer 1 stack of \"Fiamma\" to another Kathigu-Ra's Command Card in hand."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98486_Desc = {
    Text = "The Final DMG, Shield, Aliemus, and STR granted by this card +[DescArg1]%. Gains \"Retain\". After playing, consume all \"Fiamma\" stacks, and  transfer 1 stack of \"Fiamma\" to another Kathigu-Ra's Command Card in hand."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98487_Desc = {
    Text = "The Final DMG, Shield, Aliemus, and STR granted by this card +[DescArg1]%. Gains \"Retain\". After playing, consume all \"Fiamma\" stacks, and  transfer 1 stack of \"Fiamma\" to another Kathigu-Ra's Command Card in hand."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98488_Desc = {
    Text = "The Final DMG, Shield, Aliemus, and STR granted by this card +30%. Gains \"Retain\". After playing, consume all \"Fiamma\" stacks, and  transfer 1 stack of \"Fiamma\" to another Kathigu-Ra's Command Card in hand."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Fiamma>"
  },
  State_98492_Desc = {
    Text = "At the start of exploration, CON, ATK, and DEF increase by [StateArg1]%."
  },
  State_98492_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98495_Desc = {
    Text = "At the start of exploration, CON, ATK, and DEF increase by [StateArg1]%."
  },
  State_98495_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98507_Desc = {
    Text = "At the start of exploration, CON, ATK, and DEF increase by [StateArg1]%."
  },
  State_98507_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98511_Name = {
    Text = "Obtain Derived Card"
  },
  State_98551_Desc = {
    Text = "At the start of the battle, Realm Mastery +[Arg1]. At the beginning of odd-numbered turns, draw 1 card. At the beginning of even-numbered turns, gain 1 Arithmetica."
  },
  State_98553_Desc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  State_98555_Desc = {
    Text = "At the start of the battle, gain [Arg1]% Amplification. After applying Poison for the first time each turn, draw [Arg2] cards."
  },
  State_98556_Desc = {
    Text = "All Awakeners' base effects for HP healing and Shield are increased by [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  State_98559_Desc = {
    Text = "Gain [Arg1] Temporary STR each time you draw or discard a card, up to [Arg2] Temporary STR."
  },
  State_98560_Desc = {
    Text = "All Awakeners deal increased Base DMG by [Arg1]%. Before unleashing Exalt, temporarily increase the Base DMG dealt by the Awakener unleashing Exalt by [Arg2]%."
  },
  State_98561_Desc = {
    Text = "At the start of the turn, if HP is below 50%, temporarily gain DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  State_98562_Desc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  State_98563_Desc = {
    Text = "At the start of the battle, gain [Arg1] Strength. Gain [Arg2] Temporary STR each time you play a \"Exhaust\" card, up to [Arg3] times."
  },
  State_98564_Desc = {
    Text = "Exalt gains [Arg1] Keyflare, with a maximum of 3 triggers per turn."
  },
  State_98565_Desc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  State_98567_Desc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  State_98568_Desc = {
    Text = "At the start of the battle, gain DMG Amplification +[Arg1]%. After dealing Active DMG, inflict [Arg2] Poison on all enemies, with a maximum of 5 additional triggers per turn."
  },
  State_98569_Desc = {
    Text = "After your first \"Posse\" each turn, apply [Arg1] Poison to all enemies and gain [Arg2] Counter."
  },
  State_98571_Desc = {
    Text = "Restores [Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  State_98572_Desc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  State_98575_Desc = {
    Text = "At the start of the battle, gain DMG Amplification +[Arg1]%. After dealing Active DMG, inflict [Arg2] Poison on all enemies, with a maximum of 5 additional triggers per turn."
  },
  State_98576_Desc = {
    Text = "At the start of battle, apply [Arg1] Weakness and Vulnerable to all enemies. This effect is also triggered after \"Annihilation\", but has a 3 turn cooldown."
  },
  State_98577_Desc = {
    Text = "All Awakeners deal increased Base DMG by [Arg1]%. Before unleashing Exalt, temporarily increase the Base DMG dealt by the Awakener unleashing Exalt by [Arg2]%."
  },
  State_98579_Desc = {
    Text = "At the start of the turn, if HP is below 50%, temporarily gain DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  State_98581_Desc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  State_98582_Desc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 additional time."
  },
  State_98583_Desc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  State_98586_Desc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  State_98587_Desc = {
    Text = "Gain [Arg1] Temporary STR each time you draw or discard a card, up to [Arg2] Temporary STR."
  },
  State_98588_Desc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  State_98589_Desc = {
    Text = "At the start of battle, all enemies temporarily lose [Arg1] Strength. Using the \"Crimson Furnace\" also triggers this effect, but has a 3 turn cooldown."
  },
  State_98590_Desc = {
    Text = "At the start of the battle, gain [Arg1]% Amplification. After applying Poison for the first time each turn, draw [Arg2] cards."
  },
  State_98591_Desc = {
    Text = "After your first \"Posse\" each turn, apply [Arg1] Poison to all enemies and gain [Arg2] Counter."
  },
  State_98596_Desc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  State_98597_Desc = {
    Text = "Restores [Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  State_98598_Desc = {
    Text = "At the start of the battle, gain [Arg1] Strength. Gain [Arg2] Temporary STR each time you play a \"Exhaust\" card, up to [Arg3] times."
  },
  State_98600_Desc = {
    Text = "At the start of battle, all enemies temporarily lose [Arg1] Strength. Using the \"Crimson Furnace\" also triggers this effect, but has a 3 turn cooldown."
  },
  State_98602_Desc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. When obtaining Counter for the first time each turn, gain 1/2 Arithmetica."
  },
  State_98603_Desc = {
    Text = "At the start of the battle, gain DMG Amplification +[Arg1]%. After taking damage, gain [Arg2] Counter, up to 3 times per turn."
  },
  State_98604_Desc = {
    Text = "At the start of the battle, gain DMG Amplification +[Arg1]%. After taking damage, gain [Arg2] Counter, up to 3 times per turn."
  },
  State_98606_Desc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  State_98607_Desc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  State_98608_Desc = {
    Text = "At the start of battle, gain [Arg1]% DMG Amplification. For each different Awakener Command Card played, gain an additional 15/30% Temporary DMG Amplification."
  },
  State_98610_Desc = {
    Text = "After using Keyflare Rouse, the 2/4 cards with the highest Arithmetica in hand gain Retain and Prepare before being played next, and gain 100/200 Keyflare."
  },
  State_98611_Desc = {
    Text = "At the start of the battle, Realm Mastery +[Arg1]. At the beginning of odd-numbered turns, draw 1 card. At the beginning of even-numbered turns, gain 1 Arithmetica."
  },
  State_98612_Desc = {
    Text = "The first \"Posse\" each turn grants Temporary DMG Amplification +[Arg1]%, with stronger effects at lower HP."
  },
  State_98613_Desc = {
    Text = "At the start of battle, gain [Arg1]% DMG Amplification. For each different Awakener Command Card played, gain an additional 15/30% Temporary DMG Amplification."
  },
  State_98614_Desc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 additional time."
  },
  State_98615_Desc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  State_98616_Desc = {
    Text = "All Awakeners' base effects for HP healing and Shield are increased by [Arg1]%."
  },
  State_98617_Desc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  State_98619_Desc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to add a \"Silver Key Gleam\" to your hand."
  },
  State_98621_Desc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to put a \"Silver Key Dawn\" into your hand."
  },
  State_98623_Desc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  State_98624_Desc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  State_98625_Desc = {
    Text = "At the start of battle, apply [Arg1] Weakness and Vulnerable to all enemies. This effect is also triggered after \"Annihilation\", but has a 3 turn cooldown."
  },
  State_98626_Desc = {
    Text = "The first \"Posse\" each turn grants Temporary DMG Amplification +[Arg1]%, with stronger effects at lower HP."
  },
  State_98627_Desc = {
    Text = "Exalt gains [Arg1] Keyflare, with a maximum of 3 triggers per turn."
  },
  State_98628_Desc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  State_98629_Desc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  State_98630_Desc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  State_98632_Desc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. When obtaining Counter for the first time each turn, gain 1/2 Arithmetica."
  },
  State_98686_Desc = {
    Text = "The next [Layer] Non-Derived Command Card takes effect 1 additional time."
  },
  State_98686_Name = {
    Text = "Non-Derived Command Card Dual Wield"
  },
  State_98739_Desc = {
    Text = "When the Intention is converted to Colorless Spiral, increase the number of DMG instances by an amount equal to the stacks of the State, and clear the State after the turn ends. Once reaching 3 stacks, immediately convert the Intention to Colorless Spiral."
  },
  State_98739_Name = {
    Text = "Spider Queen's Kiss"
  },
  State_98742_Desc = {
    Text = "Apply 100% more Poison. Gain <Block:[Block:DescArg1]> Shield at the end of each turn."
  },
  State_98742_Name = {
    Text = "Path of the Lost"
  },
  State_98743_Desc = {
    Text = "After taking [DescArg1] DMG within a turn, gain 75 stacks of Temporary Fortress, convert Intention to \"Impatient Alms\", remove the Petrification effect, and gain 1 stack of \"Spider Queen's Kiss\"."
  },
  State_98743_Name = {
    Text = "The Usurper"
  },
  State_98752_Desc = {
    Text = "Set the card on fire, dealing 5% of Max HP damage upon playing, and if still in hand at turn end, it will be exhausted."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Burn>"
  },
  State_98752_WeaponDesc = {
    Text = "Each stack of Slowness increases the Arithmetica Cost of cards by 1."
  },
  State_98889_Desc = {
    Text = "When a Command Card with <DepleteIconKeywords:Exhaust> is played for the first time each turn, place this card into the Discard Pile."
  },
  State_98889_Name = {
    Text = "Lamp of Salvation"
  },
  State_98912_Desc = {
    Text = "Each stack reduces the Final DMG dealt by all Awakeners by 10%."
  },
  State_98912_Name = {
    Text = "<LostWay:Lost>"
  },
  State_98913_Desc = {
    Text = "Each stack reduces all Awakeners' Shield and HP Recovery by 10%."
  },
  State_98913_Name = {Text = "Lost"},
  State_99007_Desc = {
    Text = "When played, it will not enter the Discard Pile but will be removed from the deck."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Exhaust>"
  },
  State_99007_WeaponDesc = {
    Text = "When played, the card will not enter the Discard Pile and cannot be played again in this battle."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Draw [StateArg1] cards when other allies first use \"Exalt\" each turn."
  },
  State_99053_Name = {
    Text = "Thirsting Brush"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: After using \"Exalt\", randomly place [StateArg1] of your own \"Skill\" cards into your hand and set their Arithmetica Cost to 0."
  },
  State_99055_Name = {
    Text = "Paradoxical Realism"
  },
  State_99056_Desc = {
    Text = "Team Unique: After unleashing a Posse, the wielder's Crit. Rate is temporarily increased by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Unleash the Posse, temporarily increase the wielder's Crit. Rate by <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "The dye \"Painter\" uses. Enhances skill effects. Stacks up to 10."
  },
  State_99134_Name = {
    Text = "Phantasmal Dye"
  },
  State_99137_Name = {
    Text = "Color Ink Count Held by Player"
  },
  State_99139_Name = {
    Text = "Color Ink Play Listener"
  },
  State_99140_Name = {
    Text = "Color Ink Count Held by Player"
  },
  State_99237_Name = {
    Text = "State item Ascension"
  },
  State_99237_WeaponDesc = {
    Text = "The wielder's Base DMG +10%. If the wearer's DMG Amplification exceeds 20%, the Base DMG further + 10%."
  },
  State_99238_Name = {
    Text = "State item Humus"
  },
  State_99238_WeaponDesc = {
    Text = "The wielder's Base DMG +10%. If the wearer's DMG Amplification exceeds 20%, the Base DMG further + 10%."
  },
  State_99239_Name = {
    Text = "State item Styx"
  },
  State_99239_WeaponDesc = {
    Text = "The wielder's Base DMG +10%. If the wearer's DMG Amplification exceeds 20%, the Base DMG further + 10%."
  },
  State_99258_Desc = {
    Text = "Team Unique: After releasing the 2nd Posse in each turn, there is a <WeaponEffect_Num:[StateArg1]%> chance to draw 1 Command Card of the wielder. After playing the 3rd Command Card of the wielder in each turn, gain <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_99258_WeaponDesc = {
    Text = "After releasing the 2nd Posse per turn, there is a <WeaponEffect_Num:[StateArg1]%> chance to draw 1 Command Card of the wielder. After playing the 3rd Command Card of the wielder per turn, gain <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_99294_Desc = {
    Text = "The Aliemus generated by all Awakeners is increased by [DescArg1]%. Arithmetica and Command Cards at turn end can be retained until the next turn. Resplendent Chapters generates more Aliemus."
  },
  State_99294_Name = {
    Text = "\"Happiness\""
  },
  State_99295_Desc = {
    Text = "The Aliemus generated by all Awakeners is increased by [StateArg1]%. Arithmetica and Command Cards at turn end can be retained until the next turn. Resplendent Chapters generates more Aliemus."
  },
  State_99295_Name = {
    Text = "\"Happiness\""
  },
  State_99336_Desc = {
    Text = "The dye \"Painter\" uses. Enhances skill effects. Stacks up to 10."
  },
  State_99336_Name = {
    Text = "<DecayDye:Mirage Dye>"
  },
  State_99533_Name = {
    Text = "Accessory: Chrysalis of the Maiden"
  },
  State_99533_WeaponDesc = {
    Text = "At the start of the battle, if the wielder is of the Chaos Realm, ATK +25%."
  },
  State_99534_Name = {Text = "Sweet Slug"},
  State_99534_WeaponDesc = {
    Text = "The wielder's Shield and HP Recovery +6%. If the wielder's Realm Mastery exceeds 50, Shield and HP Recovery further +6%."
  },
  State_99640_Desc = {
    Text = "If Pickman currently has 10 stacks of Creativity, consume all Creativity after he uses Exalt. All Awakeners gain 15 Aliemus. Gain 1 stack of \"Fantasia\". Pickman can hold up to 10 stacks of Creativity. can carry over to the next battle."
  },
  State_99640_Name = {Text = "Creativity"},
  State_99723_Desc = {
    Text = "Team Unique: The wielder's Aliemus and STR Generation +<WeaponEffect_Num:[StateArg1]%>. After unleashing Exalt, the Final DMG, Shield, and Healing from other Awakeners' Exalts this turn +<WeaponEffect_Num:[StateArg2]%>. If this Exalt triggered \"Devour,\" the wielder gains <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_99723_WeaponDesc = {
    Text = "The Aliemus and Strength generated by the wielder are increased by <WeaponEffect_Num:[StateArg1]%>. After unleashing Exalt, the Final DMG, Shield, and Healing from other Awakeners' Exalts this turn +<WeaponEffect_Num:[StateArg2]%>. If this Exalt triggered \"Devour,\" the wielder gains <WeaponEffect_Num:[StateArg3]> Aliemus."
  }
})
return Text_State
