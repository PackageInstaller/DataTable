__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "At the start of the battle, gain 1 stack of \"<MindWall:Mind Barrier>\", and after 3 turns, convert it to \"<BarrierCrash:Crumble>\"."
  },
  RelicConfig_100300_Desc = {
    Text = "At the start of the battle, gain 1 stack of \"<MindWall:Mind Barrier>\", and after 3 turns, convert it to \"<BarrierCrash:Crumble>\"."
  },
  RelicConfig_100300_Name = {
    Text = "Psyche Analysis"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Look closely at your heart, and do not make the wrong choice."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "After triggering the <DevouredIconKeywords:Devour> effect, other Awakeners gain [Arg1] Aliemus. Triggers once per turn."
  },
  RelicConfig_100399_Desc = {
    Text = "After triggering the <DevouredIconKeywords:Devour> effect, other Awakeners gain [Arg1] Aliemus. Triggers once per turn."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Painted Gilded Reverie+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "The day of transformation will be your doom."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_100400_Desc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Painted Blessed Blood+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "It is sweet and mellow, with a fragrance of roses."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_100401_Desc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Painted Rusted Saw+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "The dissection doctor spends his life never seeing a beautiful woman, only bags of bones, inflamed nerves, muscles, and tissues caused by diseases."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> on all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> on all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Painted Rite of Spring>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Amid the laughter of the night, the silhouette of the canoe glides effortlessly across the lake."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_100404_Desc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Painted Iron Lock>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = [[
A thick and sturdy lock, difficult to open without a key.
Of course, this is nothing for a master thief]]
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Painted Malignant Child>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Born of pure evil, even though it was not its own will."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "After triggering the <DevouredIconKeywords:Devour> effect, other Awakeners gain [Arg1] Aliemus. Triggers once per turn."
  },
  RelicConfig_100406_Desc = {
    Text = "After triggering the <DevouredIconKeywords:Devour> effect, other Awakeners gain [Arg1] Aliemus. Triggers once per turn."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Painted Gilded Reverie>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "The day of transformation will be your doom."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_100407_Desc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Painted Filigree Agate>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "It's probably just ordinary agate patterns. Perhaps."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_100408_Desc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Painted Iron Lock+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = [[
A thick and sturdy lock, difficult to open without a key.
Of course, this is nothing for a master thief]]
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Painted Malignant Child+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Born of pure evil, even though it was not its own will."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_100410_Desc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Painted Filigree Agate+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "It's probably just ordinary agate patterns. Perhaps."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> on all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Upon picking up, inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> on all enemies. The Base DMG dealt by all Awakeners +[Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Painted Rite of Spring+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Amid the laughter of the night, the silhouette of the canoe glides effortlessly across the lake."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_100412_Desc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Painted Blessed Blood>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "It is sweet and mellow, with a fragrance of roses."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_100413_Desc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Painted Rusted Saw>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "The dissection doctor spends his life never seeing a beautiful woman, only bags of bones, inflamed nerves, muscles, and tissues caused by diseases."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_100539_Desc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Painted Bloody Pebble>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "One, Two, Three, Four, Five."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_100540_Desc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Painted Bloody Pebble+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "One, Two, Three, Four, Five."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116382_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116382_Name = {Text = "Rusted Key"},
  RelicConfig_116383_BattleDesc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116383_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116383_Name = {Text = "Rusted Key"},
  RelicConfig_116384_BattleDesc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116384_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_116384_Name = {Text = "Rusted Key"},
  RelicConfig_119371_BattleDesc = {
    Text = [[
Hand Limit +1.
At the start of turn, if not all rituals are completed, suffer <SacrificeKeyWord:Sacrifice> equal to 10% Max HP. Place 1 "<DerivativeCardKeywords_119:Divine Dedication>" into hand, max hold 1.]]
  },
  RelicConfig_119371_Desc = {
    Text = [[
Hand Limit +1.
At the start of turn, if not all rituals are completed, suffer <SacrificeKeyWord:Sacrifice> equal to 10% Max HP. Place 1 "<DerivativeCardKeywords_119:Divine Dedication>" into hand, max hold 1.]]
  },
  RelicConfig_119371_Name = {
    Text = "Brass Censer"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"This incense burner is made imitating the craftsmanship of Lemuria, may it help you sleep peacefully every night. From Miryam.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Hand Limit +[Arg1]. At each turn start, place [Arg2] \"<PVPDerivativeCardKeywords_11:Unequal Exchange>\" into hand."
  },
  RelicConfig_120372_Desc = {
    Text = "Hand Limit +[Arg1]. At each turn start, place [Arg2] \"<PVPDerivativeCardKeywords_11:Unequal Exchange>\" into hand."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Kaleidoscope>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "The first [Arg1] \"<PVPWeaponKeywords:WoD>\" cards' Arithmetica Cost -5/-3/-1/+1, respectively. Draw 1 card after playing WoD cards."
  },
  RelicConfig_120373_Desc = {
    Text = "The first [Arg1] \"<PVPWeaponKeywords:WoD>\" cards' Arithmetica Cost -5/-3/-1/+1, respectively. Draw 1 card after playing WoD cards."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Mythag Insignia>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Immune to damage"
  },
  RelicConfig_121214_Desc = {
    Text = "Immune to damage"
  },
  RelicConfig_121214_Name = {
    Text = "Invincible Test Relic"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Increase Final DMG by 250%. Each time damage is dealt, this bonus is reduced by 50% (up to 5 times), while Shield Generation is increased by 10%. Resets every turn."
  },
  RelicConfig_121689_Desc = {
    Text = "Increase Final DMG by 250%. Each time damage is dealt, this bonus is reduced by 50% (up to 5 times), while Shield Generation is increased by 10%. Resets every turn."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"Argent Return: Birth\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "At the start of the battle, choose 3 cards to grant them \"<RippleKeywords:Aftershock>: Draw a card and gain [Arg3] Temporary <PowerIconKeywords:STR>\". At the start of the turn, draw 2 cards with <RippleKeywords:Aftershock>, all <RippleKeywords:Aftershock> effects trigger an additional time. After triggering <RippleKeywords:Aftershock> 10 times, put 1 <DerivativeCardKeywords_1:Echoes of Lost Shadows> into your hand."
  },
  RelicConfig_121690_Desc = {
    Text = "At the start of the battle, choose 3 cards to grant them \"<RippleKeywords:Aftershock>: Draw a card and gain [Arg3] Temporary <PowerIconKeywords:STR>\". At the start of the turn, draw 2 cards with <RippleKeywords:Aftershock>, all <RippleKeywords:Aftershock> effects trigger an additional time. After triggering <RippleKeywords:Aftershock> 10 times, put 1 <DerivativeCardKeywords_1:Echoes of Lost Shadows> into your hand."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"Argent Return: Madness\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "All Awakeners' Exalt Final DMG +100%. Each time an Awakener uses Exalt, obtain Keyflare equal to 500% of said Awakener's Base Aliemus, and decrease all Awakeners' Base Aliemus by 20, up to 5 times."
  },
  RelicConfig_121691_Desc = {
    Text = "All awakeners' Exalt Final DMG +100%. Each time Exalt is released, obtain Keyflare equal to 500% of the Awakener's Base Aliemus, and decrease all Awakeners' Base Aliemus by 20, up to 5 times."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"Argent Return: Fear\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Effects of <RetaliateIconKeywords:Counter>, <IntoxicationIconKeywords:Poison>, Shield, and HP Recovery generated by all Awakeners are increased by 50%. At the end of the turn, gain Temporary <RetaliateIconKeywords:Counter> equal to 500% of the current Shield."
  },
  RelicConfig_121692_Desc = {
    Text = "Effects of <RetaliateIconKeywords:Counter>, <IntoxicationIconKeywords:Poison>, Shield, and HP Recovery generated by all Awakeners are increased by 50%. At the end of the turn, gain Temporary <RetaliateIconKeywords:Counter> equal to 500% of the current Shield."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"Argent Return: Heresy\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Maximum Hand Size +5. At the start of your turn, draw 2 cards and gain 2 Arithmetica. Each time the deck is reset, gain [Arg3] <PowerIconKeywords:STR> and [Arg4] Temporary <AlertIconKeywords:Alert>, generate 1 of each Non-Derived Command Card for the highest Aliemus Awakener and place them into the Draw Pile, reducing their Arithmetica cost by 1."
  },
  RelicConfig_121693_Desc = {
    Text = "Maximum Hand Size +5. At the start of your turn, draw 2 cards and gain 2 Arithmetica. Each time the deck is reset, gain [Arg3] <PowerIconKeywords:STR> and [Arg4] Temporary <AlertIconKeywords:Alert>, generate 1 of each Non-Derived Command Card for the highest Aliemus Awakener and place them into the Draw Pile, reducing their Arithmetica cost by 1."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"Argent Return: Scathe\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "At the start of each turn, all Awakeners gain 25 Aliemus and draw a <DerivativeCardKeywords_4:Insight> into their Hand. After unleashing \"Exalt\" 4 times, remove the <Seal:Sealed> status from all Awakeners and grant them 50 Aliemus."
  },
  RelicConfig_121694_Desc = {
    Text = "At the start of each turn, all Awakeners gain 25 Aliemus and draw a <DerivativeCardKeywords_4:Insight> into their Hand. After unleashing \"Exalt\" 4 times, remove the <Seal:Sealed> status from all Awakeners and grant them 50 Aliemus."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"Argent Return: Deceit\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "At the start of the battle, gain [Arg4] <PowerIconKeywords:STR>, and increase the Keyflare Cap by 100%. The Keyflare gained per point of Arithmetica consumed is increased by 100%. After using Keyflare Rouse or unleashing Posse, gain Temporary <PowerIconKeywords:STR> equal to 20% of the current <PowerIconKeywords:STR> and grant all Awakeners 20 Aliemus."
  },
  RelicConfig_121695_Desc = {
    Text = "At the start of the battle, gain [Arg4] <PowerIconKeywords:STR>, and increase the Keyflare Cap by 100%. The Keyflare gained per point of Arithmetica consumed is increased by 100%. After using Keyflare Rouse or unleashing Posse, gain Temporary <PowerIconKeywords:STR> equal to 20% of the current <PowerIconKeywords:STR> and grant all Awakeners 20 Aliemus."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"Argent Return: Sorrow\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "At the start of the battle, place [Arg1] \"<PVPDerivativeCardKeywords_25:Sylvia's Red Tea>\" into hand."
  },
  RelicConfig_122625_Desc = {
    Text = "At the start of the battle, place [Arg1] \"<PVPDerivativeCardKeywords_25:Sylvia's Red Tea>\" into hand."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Ceylon Tea>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Shuffle [Arg1] \"<PVPDerivativeCardKeywords_14:Reality Imitation>\" into the Draw Pile each turn, owner being a random Awakener."
  },
  RelicConfig_122626_Desc = {
    Text = "Shuffle [Arg1] \"<PVPDerivativeCardKeywords_14:Reality Imitation>\" into the Draw Pile each turn, owner being a random Awakener."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Arcane Gloves>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "The first \"Skill\" played each turn has its DMG, Healing, and Shield +[Arg1]%."
  },
  RelicConfig_122627_Desc = {
    Text = "The first \"Skill\" played each turn has its DMG, Healing, and Shield +[Arg1]%."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Crimson Brooch>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "At turn end, gain an additional <Energy:[Arg1]> Aliemus."
  },
  RelicConfig_122628_Desc = {
    Text = "At turn end, gain an additional <Energy:[Arg1]> Aliemus."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Nightmare Manifest>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "There will be double the Awakener cards in the Draw Pile. After playing a card, when the number of cards goes under [Arg1] for the first time this turn, draw [Arg2] cards."
  },
  RelicConfig_122629_Desc = {
    Text = "There will be double the Awakener cards in the Draw Pile. After playing a card, when the number of cards goes under [Arg1] for the first time this turn, draw [Arg2] cards."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Joyous Record>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Hand Limit +[Arg1]. Place [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" into the Draw Pile each turn."
  },
  RelicConfig_122630_Desc = {
    Text = "Hand Limit +[Arg1]. Place [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" into the Draw Pile each turn."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Ritual Dagger>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = [[
At turn start, draw [Arg1] "Strike" cards with Arithmetica Cost -1. After releasing Exalt, generate [Arg2] "Strike" cards of the corresponding Awakener with <DepleteIconKeywords:Exhaust>, <PrepareKeypvewords:Prepare 1>, and <RetainIconKeywords:Retain>.
For each [Arg3] "Strike" played within 1 turn, gain [Arg4] Temporary <PowerIconKeywords:STR>; after playing [Arg5] "Strike" cards, draw [Arg6] cards and gain [Arg7] Arithmetica; after playing [Arg8] "Strike" cards, all Awakeners gain [Arg9] Aliemus.]]
  },
  RelicConfig_122768_Desc = {
    Text = [[
At turn start, draw [Arg1] "Strike" cards with Arithmetica Cost -1. After releasing Exalt, generate [Arg2] "Strike" cards of the corresponding Awakener with <DepleteIconKeywords:Exhaust>, <PrepareKeypvewords:Prepare 1>, and <RetainIconKeywords:Retain>.
For each [Arg3] "Strike" played within 1 turn, gain [Arg4] Temporary <PowerIconKeywords:STR>; after playing [Arg5] "Strike" cards, draw [Arg6] cards and gain [Arg7] Arithmetica; after playing [Arg8] "Strike" cards, all Awakeners gain [Arg9] Aliemus.]]
  },
  RelicConfig_122768_Name = {
    Text = "Echoes from Beyond"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Echoes mingling in the mist of another world, leading to distortion, madness, and undeniable reality."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "At the start of the turn, Mouchette gains [Arg1] Aliemus and generates 1 Temporary Strike with an Arithmetica Cost of 0. Each time \"Dramatic Encounter\" is triggered, increase the Base DMG and Strike DMG increase effect of \"Shining☆Tornado\" by [Arg2]％ for this battle."
  },
  RelicConfig_123724_Desc = {
    Text = "At the start of the turn, Mouchette gains [Arg1] Aliemus and generates 1 Temporary Strike with an Arithmetica Cost of 0. Each time \"Dramatic Encounter\" is triggered, increase the Base DMG and Strike DMG increase effect of \"Shining☆Tornado\" by [Arg2]％ for this battle."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Dimensional Image: Mouchette>"
  },
  RelicConfig_123725_BattleDesc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_123725_Desc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_123725_Name = {
    Text = "<OrangeQuality:Dimensional Image: Hameln>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "All Awakeners gain [Arg1] Aliemus the first time they play a Command Card each turn. After playing 4 Command Cards belonging to different Awakeners in one turn, inflict [Arg2]% of your team's Max HP as <IntoxicationIconKeywords:Poison> on all enemies."
  },
  RelicConfig_125488_Desc = {
    Text = "All Awakeners gain [Arg1] Aliemus the first time they play a Command Card each turn. After playing 4 Command Cards belonging to different Awakeners in one turn, inflict [Arg2]% of your team's Max HP as <IntoxicationIconKeywords:Poison> on all enemies."
  },
  RelicConfig_125488_Name = {
    Text = "Concubines' Conceit"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "At turn start, Xu gains [Arg1] Aliemus and inflicts 1 stack of <WitherKeywords:Spellbound> on all enemies. The first Command Card Xu plays each turn will trigger the \"Resonance\" effect."
  },
  RelicConfig_125489_Desc = {
    Text = "At turn start, Xu gains [Arg1] Aliemus and inflicts 1 stack of <WitherKeywords:Spellbound> on all enemies. The first Command Card Xu plays each turn will trigger the \"Resonance\" effect."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Dimensional Image: Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Maximum Hand Size +3. Record the first 3 Non-Derived Command Cards played each turn, and at the start of the turn 3 turns later, reduce their Arithmetica Cost by 1 and add copies with <DepleteIconKeywords:Exhaust> to your hand."
  },
  RelicConfig_126673_Desc = {
    Text = "Maximum Hand Size +3. Record the first 3 Non-Derived Command Cards played each turn, and at the start of the turn 3 turns later, reduce their Arithmetica Cost by 1 and add copies with <DepleteIconKeywords:Exhaust> to your hand."
  },
  RelicConfig_126673_Name = {
    Text = "Unnamed (Arachne Event Relic"
  },
  RelicConfig_129304_BattleDesc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<OrangeQuality:Dimensional Gift>: Gain 1 random Dimensional Image Relic at the start of exploration. Hand Limit +1.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.
<OrangeQuality:Blessed Ritual>: Rewards for defeating Phase 1, 2, and 3 Bosses are replaced with a choice of 3 Blessed Relics. 
<RedQuality:Motion Vertigo>: All Awakeners start battle with 50% less current Aliemus and Keyflare. 
<RedQuality:Evernight Rail>: All Awakeners gain +100% to their Base Aliemus and Keyflare Cap at the start of exploration.]]
  },
  RelicConfig_129304_Desc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<OrangeQuality:Dimensional Gift>: Gain 1 random Dimensional Image Relic at the start of exploration. Hand Limit +1.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.
<OrangeQuality:Blessed Ritual>: Rewards for defeating Phase 1, 2, and 3 Bosses are replaced with a choice of 3 Blessed Relics. 
<RedQuality:Motion Vertigo>: All Awakeners start battle with 50% less current Aliemus and Keyflare. 
<RedQuality:Evernight Rail>: All Awakeners gain +100% to their Base Aliemus and Keyflare Cap at the start of exploration.]]
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Little N's Chaotic Camera>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Oh no! It's completely trashed! Wait... it's still working? But look at all these restrictions!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.]]
  },
  RelicConfig_129305_Desc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.]]
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Little N's Pristine Camera>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Look no further—this is the one! Brand new, factory-fresh, and guaranteed to satisfy."
  },
  RelicConfig_129306_BattleDesc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<OrangeQuality:Dimensional Gift>: Gain 1 random Dimensional Image Relic at the start of exploration. Hand Limit +1.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.
<RedQuality:Motion Vertigo>: All Awakeners start battle with 50% less current Aliemus and Keyflare.]]
  },
  RelicConfig_129306_Desc = {
    Text = [[
<OrangeQuality:Golden Harmony>: "Arithmetica Harmony" now only increases Arithmetica Cost by 1. Each 1% DMG Amplification increases Occult Research Depth by 1%.
<OrangeQuality:Dimensional Gift>: Gain 1 random Dimensional Image Relic at the start of exploration. Hand Limit +1.
<RedQuality:Transit Fatigue>: All HP recovery effects are reduced by 50% in battle. When "Burial" is selected at "Faded Bone," the effect changes to restore 25% Max HP.
<RedQuality:Motion Vertigo>: All Awakeners start battle with 50% less current Aliemus and Keyflare.]]
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Little N's Worn Camera>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "It’s ruined! The camera is broken! Let me see if I can fix... oh, it’s turning on! But why does it feel so strange now?"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "At the start of the turn, Vortice gains [Arg1] Aliemus. The first \"Charge!\" or \"Reload!\" played each turn takes effect twice."
  },
  RelicConfig_131079_Desc = {
    Text = "At turn start, Vortice gains [Arg1] Aliemus. The first \"Charge!\" or \"Reload!\" played each turn takes effect twice."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Dimensional Image: Vortice>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "At the start of the first 3 turns, trigger \"Otter's Dilemma\" once per turn. At the start of the 5th turn, remove all negative effects of \"Otter's Dilemma\" and gain <DerivativeCardKeywords_135:\"Coalsie SMACK!\">."
  },
  RelicConfig_131080_Desc = {
    Text = "At the start of the first 3 turns, trigger \"Otter's Dilemma\" once per turn. At the start of the 5th turn, remove all negative effects of \"Otter's Dilemma\" and gain <DerivativeCardKeywords_135:\"Coalsie SMACK!\">."
  },
  RelicConfig_131080_Name = {Text = "Coalsie II"},
  RelicConfig_131080_StoryDesc = {
    Text = [[
Miss Vortice insists this is a Relic.
"Bad guy! Bite him!"]]
  },
  RelicConfig_131178_BattleDesc = {
    Text = "At the Start of battle, Shuffle a \"<DerivativeCardKeywords_134:Forbidden Truth>\" into the deck. Draw+2 each turn. After playing a Command Card, randomly grant <ErosionColorInkKeywords:Dissoluted Paint> to 2 Command Cards in the opponent's hand."
  },
  RelicConfig_131178_Desc = {
    Text = "At the Start of battle, Shuffle a \"<DerivativeCardKeywords_134:Forbidden Truth>\" into the deck. Draw+2 each turn. After playing a Command Card, randomly grant <ErosionColorInkKeywords:Dissoluted Paint> to 2 Command Cards in the opponent's hand."
  },
  RelicConfig_131178_Name = {
    Text = "Ogai's Notes"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "The record contains 70 Mason prime numbers."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Immune to damage"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Crit. Rate +15%. If HP is below 25% ([Arg1]) at the start of a turn, Crit. Rate further +30% for that turn."
  },
  RelicConfig_13740_Desc = {
    Text = "Crit. Rate +15%. If HP is below 25% at the start of a turn, Crit. Rate further +30% for that turn."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Celestial Astrolabe>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "The wonders of the universe."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Crit. DMG +15%. Guaranteed Critical Hit against enemies with Shield."
  },
  RelicConfig_13741_Desc = {
    Text = "Crit. DMG +15%. Guaranteed Critical Hits against Shielded enemies."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Principles of Aesthetics>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Wax Sculptor: The doctor's assistant, the undertaker's patron, and the provider for the grave worms."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Crit. DMG +50%. Every third attack is guaranteed to be a Critical Hit."
  },
  RelicConfig_13742_Desc = {
    Text = "Crit. DMG +50%. Every third attack is guaranteed to be a Critical Hit."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Meditation\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "At turn start, the Awakener with the lowest Aliemus gains 15 Aliemus. When 2 cards are played consecutively with a lower Arithmetica Cost than the previous card, the Awakener with the lowest Aliemus gains 15 Aliemus."
  },
  RelicConfig_13743_Desc = {
    Text = "At turn start, the Awakener with the lowest Aliemus gains 15 Aliemus. When 2 cards are played consecutively with a lower Arithmetica Cost than the previous card, the Awakener with the lowest Aliemus gains 15 Aliemus."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Arcana Relic>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "The end of fate."
  },
  RelicConfig_13744_BattleDesc = {
    Text = "The Awakener with the lowest Aliemus gains 15 Aliemus after the turn starts."
  },
  RelicConfig_13744_Desc = {
    Text = "The Awakener with the lowest Aliemus gains 15 Aliemus after the turn starts."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Laurel Cufflinks>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = [[
Silver cufflinks engraved with osmanthus leaf patterns.
Finely crafted and gleaming, they once embodied the friendship of two children.]]
  },
  RelicConfig_13745_BattleDesc = {
    Text = "The Recommended Realm's buff effect is increased by 50%, and your Lucky Orison Rate doubles when the level starts."
  },
  RelicConfig_13745_Desc = {
    Text = "The Realm's recommended bonus effect is increased by 50%, and your Lucky Orison Rate doubles at the start of the level."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Deep Slumber\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Immune to death once, instantly recover 10% HP after triggering, permanently disabled after 3 triggers."
  },
  RelicConfig_13747_Desc = {
    Text = "Immune to death once, instantly recover 10% HP after triggering, permanently disabled after 3 triggers."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Ration Pack☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Only eat this as an absolute last resort."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "At the start of the battle, all cards with a current Arithmetica Cost of 1 gain +[Arg1] DMG and +[Arg2] Shield Generation for this battle."
  },
  RelicConfig_13748_Desc = {
    Text = "At the start of the battle, all cards with a current Arithmetica Cost of 1 gain + [Arg1] DMG and +[Arg2] Shield for this battle."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Mary the Pure>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "Logic is like a cocktail; too much of it diminishes its benefits."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Every 4 turns, double the Active and Tentacle DMG all enemies receive in that turn. However, after releasing Exalt in that turn, seal all Awakeners for 1 turn."
  },
  RelicConfig_13749_Desc = {
    Text = "Every 4 turns, double the Active and Tentacle DMG all enemies receive in that turn. However, after releasing Exalt in that turn, seal all Awakeners for 1 turn."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Pathwalker's Remains>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = [[
A sacred part.
Even though it has separated from the body, its footprints have spread across the world.]]
  },
  RelicConfig_13750_BattleDesc = {
    Text = "At turn end, if there is no shield, gain 1 stack of <ParcloseIconKeywords:Barrier> that grants immunity to one instance of DMG. This effect only triggers once per battle."
  },
  RelicConfig_13750_Desc = {
    Text = "At turn end, if there is no shield, gain 1 stack of <ParcloseIconKeywords:Barrier> that immunes one instance of DMG. This effect only triggers once per battle."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Painkillers☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "The effect isn't a one-time solution."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Crit. Rate +25%; double the first DMG dealt each turn."
  },
  RelicConfig_13751_Desc = {
    Text = "Crit. Rate +25%; double the first DMG dealt each turn."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Deepen\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "At turn start, restore [Arg1] HP. If HP is below 50%, restore [Arg2] HP instead."
  },
  RelicConfig_13752_Desc = {
    Text = "At turn start, restore [Arg1] HP. If HP is below 50%, restore [Arg2] HP instead."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Blessed Blood>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "It is sweet and mellow, with a fragrance of roses."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "This is a task Relic with no effect"
  },
  RelicConfig_13753_Desc = {
    Text = "This is a task relic with no effect."
  },
  RelicConfig_13753_Name = {
    Text = "Mission Relic Test"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "A Relic that requires additional content"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Your every 5th attack always deals a Critical Hit."
  },
  RelicConfig_13754_Desc = {
    Text = "Your fifth attack always deals Critical Hit."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Vision Corrector>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Someone once discovered the truth through it."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "At turn start, for each card in <DimensionalSpaceIconKeywords:Ultra Space>, gain [Arg1] Temporary <PowerIconKeywords:STR>. If this turn is an Ultra Round, gain [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13755_Desc = {
    Text = "At turn start, for each card in <DimensionalSpaceIconKeywords:Ultra Space>, gain [Arg1] Temporary <PowerIconKeywords:STR>. If this turn is an Ultra Round, gain [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Trigon Prism>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"The light is composed of seven colors.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Lose all other relics upon pickup. Randomly gain 2 Golden Relics."
  },
  RelicConfig_13756_Desc = {
    Text = "Lose all other relics upon pickup. Randomly gain 2 Golden Relics."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Inverted View☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = [[
In the strange era, flowers are humanity's primary spectators.
Stay still; they prefer quiet exhibits.]]
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Every 8th Command Card you play will take effect twice."
  },
  RelicConfig_13757_Desc = {
    Text = "Every 8th Command Card you play will take effect twice."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Stellar Brew>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Wandering among the stars."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Increases Max HP by [Arg1] when picked up and increases Aliemus gained by 2 when attacked."
  },
  RelicConfig_13758_Desc = {
    Text = "Increases Max HP by [Arg1] when picked up and increases Aliemus gained by 2 points when attacked."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Honeyed Ink>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Some say this is the devil's blood, but hey, give it a try!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "When releasing Exalt, for each instance of DMG dealt by enemies, apply [Arg1] stacks of <IntoxicationIconKeywords:Poison>"
  },
  RelicConfig_13759_Desc = {
    Text = "When releasing Exalt, for each instance of incoming DMG from enemies, Inflict [Arg1] stacks of <IntoxicationIconKeywords:Poison>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Radium Jawbone☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = [[
Displayed in a private collector's showroom.
The collector was captivated by its beautiful fluorescence, admiring it day and night, until he eventually withered away and became one of its kind.]]
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Max Arithmetica +1. When you play 2 cards in succession with a higher Arithmetica Cost than the previous one, gain 1 Arithmetica."
  },
  RelicConfig_13760_Desc = {
    Text = "Max Arithmetica +1. When you play 2 cards with Arithmetica Costs higher than the previous card in succession, gain 1 Arithmetica."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Arcana Archive>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "The flow of fate."
  },
  RelicConfig_13761_BattleDesc = {
    Text = "At turn start, if more than 3 cards remained in hand during the last turn, gain 2 Arithmetica."
  },
  RelicConfig_13761_Desc = {
    Text = "At turn start, if more than 3 cards remained in hand during the last turn, gain 2 Arithmetica."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Mythag Insignia>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Badges distributed to Investigators by Mythag University. They not only symbolize the wearer's identity but also serve as tools for remote communication."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Play \"Defense\" to gain [Arg1] <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13762_Desc = {
    Text = "Play \"Defense\" to gain [Arg1] <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13762_Name = {
    Text = "Mutated Nettle Vest"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Unable to identify the liquid that has been contaminated."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1] Shield. If you have Shield at the start of your turn, Shield and Healing Amp. +50% for that turn."
  },
  RelicConfig_13763_Desc = {
    Text = "At the start of the battle, gain [Arg1] Shield. If you have Shield at the start of your turn, Shield and Healing Amp. are 50% stronger that turn."
  },
  RelicConfig_13763_Name = {
    Text = "Mutated Garden Guardian"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Permanently gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13764_Desc = {
    Text = "Permanently gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Crimson Brooch>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "A hint of fresh red seeps through."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Upon pickup, choose a card and apply two three-choice enhancement effects to it. (Note: similar to Thousand Mirage card crafting)"
  },
  RelicConfig_13766_Desc = {
    Text = "Upon pickup, choose a card and apply two three-choice strengthening effects to it. (Note: similar to Thousand Mirage card crafting)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Classic Typist☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Rumor has it that the true author of the masterpiece is actually the typewriter."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Upon pickup, gain 1 out of 3 random Advanced Orisons and assign it to the corresponding card."
  },
  RelicConfig_13767_Desc = {
    Text = "Upon pickup, choose 1 out of 3 random Adv. Orisons and assign it to the corresponding card."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Rhind Papyrus>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Here is the question: 10 monks share 6 loaves of bread. How much does each monk receive?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Max Arithmetica +2. After playing \"Strike\" or \"Defense\", the corresponding Awakener gains 5 Aliemus. After releasing Exalt, gain this Awakener's \"Strike\" with Exhaust and Fleeting, and after releasing Posse, randomly gain one \"Defense\" with Exhaust and Fleeting."
  },
  RelicConfig_13768_Desc = {
    Text = "Max Arithmetica increases by 2. After playing \"Strike\" or \"Defense\", the corresponding Awakener gains 5 Aliemus. After releasing Exalt, gain 1 \"Strike\" of the corresponding Awakener with Exhaust and Fleeting attached. After releasing Posse, randomly gain a \"Defense\" with Exhaust and Fleeting."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wings\" >"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "At turn start, <EmbryoFusionIconKeywords:Embryo Fusion>+30%. All your <DevouredIconKeywords:Devour> effects become <UnlimitedDevouredIconKeywords:Infinite Devour>."
  },
  RelicConfig_13769_Desc = {
    Text = "At turn start, <EmbryoFusionIconKeywords:Embryo Fusion>+30%. All your <DevouredIconKeywords:Devour> effects become <UnlimitedDevouredIconKeywords:Infinite Devour>."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Wriggling Cord>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Entwined around the neck."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Gain [Arg1] Shield at turn start, increasing by [Arg2] per turn."
  },
  RelicConfig_13770_Desc = {
    Text = "Gain [Arg1] Shield at turn start, increasing by [Arg2] per turn."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Guardian Hand>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "The hand that prays, the fist that remains steadfast."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "All Awakener's Keyflare Regen is increased by 30. After releasing the Posse, shuffle 3 <DerivativeCardKeywords_4:\"Insight\"> into your deck."
  },
  RelicConfig_13771_Desc = {
    Text = "All Awakeners' Keyflare Regen is increased by 30. After releasing Posse, shuffle 3 <DerivativeCardKeywords_4:\"Insight\"> into your deck."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Slumber\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "After the battle, gain an additional 75 Black Sigils and 1 Symptom Card."
  },
  RelicConfig_13772_Desc = {
    Text = "After the battle, gain an extra 75 Black Sigils and 1 Symptom Card."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Jade Imprint>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "This imprint endures for millennia without decay."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "For every 1 instance of Active DMG dealt, inflict [Arg1] stacks of <BleedingIconKeywords:Bleed> on self and [Arg2] stacks of <BleedingIconKeywords:Bleed> on the target. For each enemy killed, dispel the <BleedingIconKeywords:Bleed> state from self."
  },
  RelicConfig_13773_Desc = {
    Text = "For every 1 instance of Active DMG dealt, inflict [Arg1] stacks of <BleedingIconKeywords:Bleed> on self and [Arg2] stacks of <BleedingIconKeywords:Bleed> on the target. For each enemy killed, dispel the <BleedingIconKeywords:Bleed> state from self."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Swarm Mind>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Entwine, Symbiosis, Swarm; Fear, Unknown, Control."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "When you play a card with an actual Arithmetica Cost of 3, draw 1 card and gain 2 Arithmetica; when you play a card with an actual Arithmetica Cost of 4 or more, reduce the Arithmetica Cost of other cards in your hand by 1."
  },
  RelicConfig_13774_Desc = {
    Text = "When you play a card with an actual Arithmetica Cost of 3, draw 1 card and gain 2 Arithmetica; when you play a card with an actual Arithmetica Cost of 4 or more, reduce the Arithmetica Cost of other cards in your hand by 1."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Eye\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "When picked up, choose a Command Card to give it \"Innate,\" \"Retain,\" and \"Draw 1 card after being played.\""
  },
  RelicConfig_13775_Desc = {
    Text = "When picked up, choose a Command Card to give it \"Innate\", \"Retain\", and \"Draw 1 card after being played\"."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Dossier>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Shh, this is a secret deal between you and me."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Gain 1 Tentacle at the start of the battle."
  },
  RelicConfig_13776_Desc = {
    Text = "Gain 1 Tentacle at the start of the battle."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Yellow Snail>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "This little yellow snail hails from a noble background, with a perfect and impeccable origin."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "At the end of odd turns, if there is remaining Arithmetica, draw 2 extra cards next turn; at the end of even turns, if there are remaining cards, gain 2 extra Arithmetica next turn."
  },
  RelicConfig_13777_Desc = {
    Text = "At the end of odd turns, if there is remaining Arithmetica, draw 2 extra cards next turn; at the end of even turns, if there are remaining cards, gain 2 extra Arithmetica next turn."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Solar Disc>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Guess, is it black or white?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Tentacle Limit +1. When HP is below 50%, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13778_Desc = {
    Text = "Tentacle Limit +1. When HP is below 50%, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Chant of the Tides>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "It is said that inedible animals like whelks absorb around 80% of the ocean's nutrients"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Draw 1 card at the start of your turn, and you may choose to keep 1 card in your hand at the end of your turn."
  },
  RelicConfig_13779_Desc = {
    Text = "Draw 1 card at the start of your turn, and you may choose to keep 1 card in your hand at the end of your turn."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Prophet's Lamp>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Grant your wish."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Each time you release an Exalt, gain 1 <DerivativeCardKeywords_7:\"Toxic Infusion\">. If you have 3 <DerivativeCardKeywords_7:\"Toxic Infusion\"> in your hand, synthesize into a <DerivativeCardKeywords_8:\"Toxic Outbreak\"> that triggers <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_13780_Desc = {
    Text = "Each time you release an Exalt, gain 1 <DerivativeCardKeywords_7:\"Toxic Infusion\">. If you have 3 <DerivativeCardKeywords_7:\"Toxic Infusion\"> in your hand, synthesize into a <DerivativeCardKeywords_8:\"Toxic Outbreak\"> that triggers <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Other Tongue>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "It is not a demon, but it indeed conveys whispers from beyond the mortal realm."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "For each Black Sigil consumed, all Awakeners gain 1 Aliemus."
  },
  RelicConfig_13781_Desc = {
    Text = "For each Black Sigil consumed, all Awakeners gain 1 Aliemus."
  },
  RelicConfig_13781_Name = {
    Text = "Reverse Bloom"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Immune to Damage"
  },
  RelicConfig_13782_Desc = {
    Text = "Immune to Damage"
  },
  RelicConfig_13782_Name = {Text = "Test Relic"},
  RelicConfig_13783_BattleDesc = {
    Text = "After playing the 3rd card each turn, place 1 <DerivativeCardKeywords_4:Insight> into the Discard Pile. After playing the 6th card each turn, place 1 <DerivativeCardKeywords_4:Insight> from the Discard Pile into hand."
  },
  RelicConfig_13783_Desc = {
    Text = "After playing the 3rd card each turn, place 1 <DerivativeCardKeywords_4:\"Insight\"> into the Discard Pile. After playing the 6th card each turn, place 1 <DerivativeCardKeywords_4:\"Insight\"> from the Discard Pile into hand."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Light of Civilization>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "A meteor streaking across the night sky."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "At turn start, gain 1 Arithmetica for each enemy. When an enemy is killed by Active DMG, inflict <BleedingIconKeywords:Bleed> on other enemies equal to the excess Damage."
  },
  RelicConfig_13784_Desc = {
    Text = "At turn start, gain 1 Arithmetica for each enemy. When an enemy is killed by Active DMG, inflict <BleedingIconKeywords:Bleed> on other enemies equal to the excess Damage."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Mob Song>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Specifically designed to torment your ears."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "At turn end, <EmbryoFusionIconKeywords:Embryo Fusion> +15%, if you have <DerivativeCardKeywords_2:\"Embryo\"> in hand, restore [Arg1] HP."
  },
  RelicConfig_13785_Desc = {
    Text = "At turn end, <EmbryoFusionIconKeywords:Embryo Fusion> +15%, if you have <DerivativeCardKeywords_2:\"Embryo\"> in hand, restore [Arg1] HP."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Plague Record>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Plague— an unconscious, restless manifestation of nature."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "After releasing Exalt, gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13786_Desc = {
    Text = "After releasing Exalt, Obtain [Arg1] in Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Iron Lock>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = [[
A thick and sturdy lock, difficult to open without a key.
Of course, this is nothing for a master thief]]
  },
  RelicConfig_13787_BattleDesc = {
    Text = "At turn start, deal [Arg1] DMG to a random enemy. After playing \"Strike\" 7 times in this battle, the DMG dealt will change to [Arg2]. After playing \"Strike\" 21 times, instantly deal [Arg3] DMG to all enemies."
  },
  RelicConfig_13787_Desc = {
    Text = "At turn start, deal [Arg1] DMG to a random enemy. After playing \"Strike\" 7 times in this battle, the DMG dealt will change to [Arg2]. After playing \"Strike\" 21 times, instantly deal [Arg3] DMG to all enemies."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Antique Puzzle>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "The artwork, once embedded in the heavy frame, has been missing a piece since the day it was displayed."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Tentacle Limit reduced by 2. At turn end, all Tentacles attack once more."
  },
  RelicConfig_13788_Desc = {
    Text = "Tentacle Limit reduced by 2. At turn end, all Tentacles attack once more."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Sacred Agony>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Embrace the agony."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Each time the deck resets, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13789_Desc = {
    Text = "Each time the deck resets, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Weeping Pipe>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Is this the product of hatred or the result of revenge?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Each map move grants 10 Black Sigils, but increases Stress by 10 points."
  },
  RelicConfig_13790_Desc = {
    Text = "Each map move grants 10 Black Sigils, but increases Stress by 10 points."
  },
  RelicConfig_13790_Name = {
    Text = "Bottomless Bag"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "When this Relic is picked up, choose a Command Card and add a copy of it to the deck."
  },
  RelicConfig_13791_Desc = {
    Text = "When this Relic is picked up, choose a Command Card and add a copy of it to the deck."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Ephemeral Fire>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Flickering light, faint hope."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Every time you lose HP, <EmbryoFusionIconKeywords:Embryo Fusion>+10%. The effect is doubled if your HP is below 50%."
  },
  RelicConfig_13792_Desc = {
    Text = "Every time you lose HP, <EmbryoFusionIconKeywords:Embryo Fusion>+10%. The effect is doubled if your HP is below 50%."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Rusted Saw>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "The dissection doctor spends his life never seeing a beautiful woman, only bags of bones, inflamed nerves, muscles, and tissues caused by diseases."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "When picked up, the team's Sigil Yield becomes 150% of the original value. After HP Recovery, all Awakeners gain 3 Aliemus; after losing HP, gain [Arg1] <PowerIconKeywords:STR> and Tentacle DMG, with a maximum combined effect of 5 times per turn."
  },
  RelicConfig_13793_Desc = {
    Text = "When picked up, the team's Sigil Yield becomes 150% of the original value. After HP Recovery, all Awakeners gain 3 Aliemus, after losing HP, gain [Arg1] <PowerIconKeywords:STR> and Tentacle DMG, with a maximum combined effect of 5 times per turn."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Moon\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "At turn end, all Awakeners gain 5 Aliemus. For every remaining Arithmetica, all Awakeners gain an additional 3 Aliemus."
  },
  RelicConfig_13794_Desc = {
    Text = "After the turn ends, all Awakeners gain 5 Aliemus. For each remaining Arithmetica, all Awakeners gain an additional 3 Aliemus."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Proto Battery>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Portable hope."
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Max Arithmetica increased by 1."
  },
  RelicConfig_13795_Desc = {
    Text = "Max Arithmetica increased by 1."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Vitality Injection>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Twitching is also a form of vitality."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Upgrade to a Silver Relic if HP is below 50% at the end of the battle"
  },
  RelicConfig_13796_Desc = {
    Text = "Upgrade to a Silver Relic if HP is below 50% at the end of the battle"
  },
  RelicConfig_13796_Name = {
    Text = "Tattered Notebook 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = [[
An old diary stuffed with inserts, including maps of Elworth, experiment logs, and letters marked with triangular D-Marks.
The handwriting at the beginning is neat and tidy, but gradually becomes messy and chaotic.]]
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Play 3 Strike Cards to upgrade to a Golden Relic."
  },
  RelicConfig_13797_Desc = {
    Text = "Play 3 Strike Cards to upgrade to a Golden Relic."
  },
  RelicConfig_13797_Name = {
    Text = "Tattered Notebook 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = [[
An old diary stuffed with inserts, including maps of Elworth, experiment logs, and letters marked with triangular D-Marks.
The handwriting at the beginning is neat and tidy, but gradually becomes messy and chaotic.]]
  },
  RelicConfig_13798_BattleDesc = {
    Text = "At the start of battle, all your Symptom Cards gain <NothingnessIconKeywords:Fleeting>, and for each Symptom Card in your deck, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13798_Desc = {
    Text = "At the start of combat, all your Symptom cards gain <NothingnessIconKeywords:Fleeting>, and for each Symptom card in your deck, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Harford's Elixir>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = [[
Medicine of unknown composition.
It is said that the renowned violinist Eric has a particular fondness for it.]]
  },
  RelicConfig_13799_BattleDesc = {
    Text = "At the start of the first battle turn, add <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> to your hand; on the second turn, add <DerivativeCardKeywords_41:\"Silver Key Resonance\"> to your hand; on the third turn, add <DerivativeCardKeywords_39:\"Echoes of the Past\"> to your hand."
  },
  RelicConfig_13799_Desc = {
    Text = "At the start of the first battle turn, add <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> to your hand; on the second turn, add <DerivativeCardKeywords_41:\"Silver Key Resonance\">; on the third turn, add <DerivativeCardKeywords_39:\"Echoes of the Past\">."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Stars\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "At turn start, add 1 <DerivativeCardKeywords_6:\"Parasol\"> to your hand. After playing 6 cards, increase the <AlertIconKeywords:Alert> of all <DerivativeCardKeywords_6:\"Parasol\"> in your hand by [Arg2]."
  },
  RelicConfig_13800_Desc = {
    Text = "At turn start, add 1 <DerivativeCardKeywords_6:\"Parasol\"> to your hand, and after playing 6 cards, increase the <AlertIconKeywords:Alert> of all <DerivativeCardKeywords_6:\"Parasol\"> in your hand by [Arg2]."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Voyager's Parasol>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Bloom in the Lightless Land"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Increase all enemies' HP by 30% in normal battles. Gain an extra 25 Black Sigils upon victory."
  },
  RelicConfig_13801_Desc = {
    Text = "Increase all enemies' HP by 30% in normal battles. Gain an extra 25 Black Sigils upon victory."
  },
  RelicConfig_13801_Name = {
    Text = "Tattered Battle Standard"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Max HP increases by [Arg1] when picked up. If HP is below 25% when picked up, the increase in Max HP becomes [Arg2]."
  },
  RelicConfig_13802_Desc = {
    Text = "Max HP increases by [Arg1] when picked up. If HP is below 25% when picked up, the increase in Max HP becomes [Arg2]."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Ceylon Tea>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Healthy eating starts with you and me."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Gain 3 Temporary Tentacles every 3 turns."
  },
  RelicConfig_13803_Desc = {
    Text = "Gain 3 Temporary Tentacles every 3 turns."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Submersible Helm>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Dreams are the stars and the sea!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Obtain [Arg1] Shield at the end of your turn. If your Shield is 0 or a multiple of 3, gain [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13804_Desc = {
    Text = "Obtain [Arg1] Shield at the end of your turn. If your Shield is 0 or a multiple of 3, gain [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:SOS Signal>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "He didn't wait for the rescue."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> when drawing a Symptom Card. For each Cursed Relic you have, your Crit. Rate and Crit. DMG increase by 10%."
  },
  RelicConfig_13806_Desc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> when drawing a Symptom Card. For each Cursed Relic you have, your Crit. Rate and Crit. DMG increase by 10%."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Abyss Link>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = [[
In the desolate outskirts, a phone rings in the lonely booth.
"Darkness... hiss... endless... hissing... darkness..."]]
  },
  RelicConfig_13807_BattleDesc = {
    Text = "At the start of battle, <EmbryoFusionIconKeywords:Embryo Fusion> +50%. For each Awakener with at least 50 Aliemus, it takes effect 1 additional time."
  },
  RelicConfig_13807_Desc = {
    Text = "At the start of battle, <EmbryoFusionIconKeywords:Embryo Fusion> +50%. For each Awakener with at least 50 Aliemus, it takes effect 1 additional time."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Dearest Babe>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "The carpenter crafted a lifelike puppet for his wife, which would take the place of their son, resting in her womb."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "After releasing Exalt, add a random card corresponding to the Awakener to your hand. The card gains <DepleteIconKeywords:Exhaust> and <NothingnessIconKeywords:Fleeting>. After the battle ends, restore [Arg1] HP."
  },
  RelicConfig_13808_Desc = {
    Text = "After releasing Exalt, add a random card corresponding to the Awakener to your hand. The card gains <DepleteIconKeywords:Exhaust> and <NothingnessIconKeywords:Fleeting>. After the battle ends, restore [Arg1] HP."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Doctor's Case>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = [[
A briefcase symbolizing the identity of a doctor, very heavy. 
Opening it does not guarantee it belongs to a true doctor.]]
  },
  RelicConfig_13809_BattleDesc = {
    Text = "All Relic prices reduced by 20."
  },
  RelicConfig_13809_Desc = {
    Text = "All Relic prices reduced by 20."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Silver Tongue>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Not only merchants are eloquent, but also the devout."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Every 3rd time \"Strike\" is played, deal [Arg1] DMG to all enemies. The corresponding Awakener gains 15 Aliemus."
  },
  RelicConfig_13811_Desc = {
    Text = "Every 3rd time \"Strike\" is played, deal [Arg1] DMG to all enemies. The corresponding Awakener gains 15 Aliemus."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Rusty Lancet>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Not suitable for cutting live tissue."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Increases Max HP by 100% when picked up. Lose [Arg1] HP at turn start."
  },
  RelicConfig_13812_Desc = {
    Text = "Increases Max HP by 100% when picked up. Lose [Arg1] HP at turn start."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Immortal Flesh☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Marine life often sheds limbs to survive.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "At the start of the battle, the current HP of elite and boss enemies is reduced by 20%."
  },
  RelicConfig_13813_Desc = {
    Text = "At the start of the battle, the current HP of Elite and Boss enemies is reduced by 20%."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Ancient Anchor☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Come home, my old sailor."
  },
  RelicConfig_13814_BattleDesc = {
    Text = "At turn end, for each unplayed card in hand, all Awakeners gain 2 Aliemus."
  },
  RelicConfig_13814_Desc = {
    Text = "At turn end, for each unplayed card in hand, all Awakeners gain 2 Aliemus."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Tilted Scales>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "No longer symbolizes justice."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Upon pickup, choose a card to permanently set its Arithmetica Cost to 1."
  },
  RelicConfig_13815_Desc = {
    Text = "Upon pickup, choose a card to permanently reduce its Arithmetica Cost to 1."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Refined Prosthesis☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "An eye that is no longer pure."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "At the start of battle, all enemies gain [Arg1] <RetaliateIconKeywords:Counter>. Whenever DMG is dealt, the Awakener with the lowest Aliemus gains 6 Aliemus."
  },
  RelicConfig_13816_Desc = {
    Text = "At the start of battle, all enemies gain [Arg1] <RetaliateIconKeywords:Counter>. Whenever DMG is dealt, the Awakener with the lowest Aliemus gains 6 Aliemus."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Wailing Bell☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = [[
Ding, ding, the child is crying;
Ding, ding, the child is screaming.
Ding, ding, the child is wailing;
Ding, ding, it's hungry, you know.]]
  },
  RelicConfig_13817_BattleDesc = {
    Text = "For every 6 Command Cards played, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13817_Desc = {
    Text = "For every 6 Command Cards played, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Severed Head Worm>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "As long as our brains remain a mystery, it's no big deal if they're filled with tentacles."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Crit. Rate increased by 50%, but when the battle begins, <FragileIconKeywords:Fragile> self for 3 turns."
  },
  RelicConfig_13818_Desc = {
    Text = "Crit. Rate increased by 50%, but when the battle starts, make self <FragileIconKeywords:Fragile> for 3 turns."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Eerie Hook>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Species that are difficult to identify."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "When you play a card with an Arithmetica Cost of 3 or more, draw 1 card and gain 1 Arithmetica."
  },
  RelicConfig_13819_Desc = {
    Text = "When you play a card with an Arithmetica Cost of 3 or more, draw 1 card and gain 1 Arithmetica."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Beauty in Loss☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "No one remembers her beauty anymore."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Whenever you gain a Symptom Card, increase Max HP by [Arg1] points."
  },
  RelicConfig_13820_Desc = {
    Text = "Whenever you gain a Symptom Card, increase Max HP by [Arg1]."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Resin Compound☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"A sweet and alluring aroma.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "After releasing Exalt, draw 1 card. If HP is below 25%, draw an additional card."
  },
  RelicConfig_13821_Desc = {
    Text = "After releasing an Exalt, draw 1 card. If HP is below 25%, draw an additional card."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Knowledge Wheel>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Please read with caution."
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Each turn, when dealing Active DMG, increase [Arg1] Temporary <TentacleInjurieIconKeywords:Tentacle DMG>, up to 3 times. When the stack is full, generate 1 Temporary Tentacle that ignores the Tentacle Limit."
  },
  RelicConfig_13822_Desc = {
    Text = "Each turn, when dealing Active DMG, increase [Arg1] Temporary <TentacleInjurieIconKeywords:Tentacle DMG>, up to 3 times. When the stack is full, generate 1 Temporary Tentacle that ignores the Tentacle Limit."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Lemurian Delight>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "The Lord of Eternal Slumber awaits you in your dreams."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Your [Arg1]th Command Card played each turn activates twice and returns to your hand."
  },
  RelicConfig_13823_Desc = {
    Text = "Your [Arg1]th Command Card played each turn activates twice and returns to your hand."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Stellar Brew+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Wandering among the stars."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "At turn start, <DeathResistanceIconKeywords:Death Resistance> increases by 10% (each time Death Resistance triggers in this stage, the gained Death Resistance is halved). When <DeathResistanceIconKeywords:Death Resistance> is above 100%, <ProficientInRealmsIconKeywords:Realm Mastery> increases by 100."
  },
  RelicConfig_13824_Desc = {
    Text = "At turn start, <DeathResistanceIconKeywords:Death Resistance> increases by 10% (each time Death Resistance triggers in this stage, the gained Death Resistance is halved). When <DeathResistanceIconKeywords:Death Resistance> is above 100%, <ProficientInRealmsIconKeywords:Realm Mastery> increases by 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Siren's Tear>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Do not place it in water."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "For every 10 consumed Black Sigils, restore [Arg1] HP."
  },
  RelicConfig_13825_Desc = {
    Text = "For every 10 consumed Black Sigils, restore 1% of HP."
  },
  RelicConfig_13825_Name = {
    Text = "Reverse Root"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "When you play a Buff Card, Symptom Card, or State Card, the Awakener with the lowest Aliemus gains 10 Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "When you play a Buff Card, Symptom Card, or State Card, the Awakener with the lowest Aliemus gains 10 Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Foreign Stamp Album>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Quantified longing."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Upon pickup, gain 75 Black Sigil. Choose 1 Relic to transform it into a random Cursed Relic."
  },
  RelicConfig_13827_Desc = {
    Text = "Upon pickup, gain 75 Black Sigil. Choose 1 Relic to transform it into a random Cursed Relic."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Cursed Stele>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "You heard the call of the deep sea while touching this stele."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "When a Command Card you first played each turn enters the Discard Pile, shuffle a temporary copy of it with its Arithmetica Cost reduced by 1 into the Draw Pile."
  },
  RelicConfig_13828_Desc = {
    Text = "The first time a Command Card you played enters the Discard Pile each turn, shuffle a Temporary copy of it with Arithmetica Cost reduced by 1 into the Draw Pile."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Mute Jukebox>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "His voice faded into the wind."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_13829_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  RelicConfig_13829_Name = {Text = "Rusted Key"},
  RelicConfig_13830_BattleDesc = {
    Text = "When causing HP Recovery, also gain [Arg1] Shield. After the start of the 3rd turn, gain [Arg2] <AlertIconKeywords:Alert>."
  },
  RelicConfig_13830_Desc = {
    Text = "When causing HP Healing, also grant [Arg1] Shield. After the start of the 3rd turn, gain [Arg2] <AlertIconKeywords:Alert>."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Preserved Butterfly>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "To this day, he is still deeply loved by someone."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Whenever a Command Card enters <DimensionalSpaceIconKeywords:Ultra Space>, grant the corresponding Awakener 15 Aliemus."
  },
  RelicConfig_13831_Desc = {
    Text = "Whenever a Command Card enters <DimensionalSpaceIconKeywords:Ultra Space>, grant the corresponding Awakener 15 Aliemus."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Time Scarab>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = [[
A pocket watch found both in a clock shop and an insect museum.
It has been incorporated into the university's collection since the Flood.]]
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Enter the Ultra Round to remove <WeaknessIconKeywords:Weakness> and <FragileIconKeywords:Fragile> state from self, and inflict <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> state to all enemies for 3 turns. This turn, all Awakener Final DMG is increased by 15%."
  },
  RelicConfig_13832_Desc = {
    Text = "Enter the Ultra Round to remove <WeaknessIconKeywords:Weakness> and <FragileIconKeywords:Fragile> state from self, and Inflict <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> state to all enemies for 3 rounds. this turn, all Awakener Final DMG is increased by 15%."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Hyperstring Pocketwatch>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Oh no, the pocket watch has stopped.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "For every 1 DMG instance dealt, apply [Arg1] stacks of <IntoxicationIconKeywords:Poison> to the target. If the number of triggers accumulates to 25 within this battle, immediately trigger <IntoxicationIconKeywords:Poison> for all enemies."
  },
  RelicConfig_13833_Desc = {
    Text = "For every 1 DMG instance dealt, Inflict [Arg1] stacks of <IntoxicationIconKeywords:Poison> to the target. If the number of triggers accumulates to 25 times within this battle, trigger immediately <IntoxicationIconKeywords:Poison> for all enemies."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Forgotten Loom☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "A kind mother mends the wounds of the heart."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Every 5th time you gain a Shield, also gain <RetaliateIconKeywords:Counter>, with the Counter value equal to [Arg1]% of the Shield gained."
  },
  RelicConfig_13834_Desc = {
    Text = "Every 5th time you gain a Shield, also gain <RetaliateIconKeywords:Counter>, with the Counter value equal to [Arg1]% of the Shield gained."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Forgotten Prelude>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"How foolish humans are, blindly believing simply because it's antiquated.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Draw 1 card at turn start."
  },
  RelicConfig_13835_Desc = {
    Text = "Draw 1 card at turn start."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:True North Compass>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "The indication is not a direction, but rather a magnetic field."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "At the start of battle, randomly place <DerivativeCardKeywords_3:\"Convulsion\"> and <DerivativeCardKeywords_4:\"Insight\"> into <DimensionalSpaceIconKeywords:Ultra Space> until the limit is reached. After entering the Ultra Round, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13836_Desc = {
    Text = "At the start of battle, randomly place <DerivativeCardKeywords_3:\"Convulsion\"> and <DerivativeCardKeywords_4:\"Insight\"> into <DimensionalSpaceIconKeywords:Ultra Space> until the limit is reached. After entering the Ultra Round, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Alfonso's Artifact>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Unlike the unpredictable fate, the stars follow their own laws."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "<DeathResistanceIconKeywords:Death Resistance> +100% upon pickup. (each time Death Resistance triggers in this challenge, the gained Death Resistance is halved). After triggering <DeathResistanceIconKeywords:Death Resistance>, recover [Arg1] HP at turn start in this battle."
  },
  RelicConfig_13837_Desc = {
    Text = "<DeathResistanceIconKeywords:Death Resistance> +100% upon pickup. (each time Death Resistance triggers in this challenge, the gained Death Resistance is halved). After triggering <DeathResistanceIconKeywords:Death Resistance>, recover [Arg1] HP at turn start in this battle."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Life Breather>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "A must-have for explorers. Relying on it too much will make it a part of you."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "This is a task Relic with no Effect 2"
  },
  RelicConfig_13838_Desc = {
    Text = "This is a task Relic 2 with no Effect"
  },
  RelicConfig_13838_Name = {
    Text = "Mission Relic Test 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "A Relic that requires additional content"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "When you play the last card in your hand, draw 2 cards. This effect can trigger up to 2 times per turn."
  },
  RelicConfig_13839_Desc = {
    Text = "When you play the last card in your hand, draw 2 cards. This effect can trigger up to 2 times per turn."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Arcane Gloves☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"Don't be afraid, it's just an illusion.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Every 3 turns, add 1 stack of <WeaknessIconKeywords:Weakness> to all enemies. After dealing DMG to an enemy with <WeaknessIconKeywords:Weakness>, gain [Arg1] Temporary <PowerIconKeywords:STR>, with a maximum of 3 triggers per turn."
  },
  RelicConfig_13840_Desc = {
    Text = "Every 3 turns, add 1 stack of <WeaknessIconKeywords:Weakness> to all enemies. After dealing DMG to an enemy with <WeaknessIconKeywords:Weakness>, gain [Arg1] Temporary <PowerIconKeywords:STR>, with a maximum of 3 triggers per turn."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Malignant Child>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Born of pure evil, even though it was not its own will."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "All \"Strike\" Crit. DMG is increased by 20%. When the battle begins, add 1 <DerivativeCardKeywords_40:\"Fleeting Beauty\"> to hand."
  },
  RelicConfig_13841_Desc = {
    Text = "All \"Strike\" Crit. DMG increased by 20%. At the start of battle, add 1 <DerivativeCardKeywords_40:\"Fleeting Beauty\"> to your hand."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Fleeting Beauty>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Preserve the beauty of fleeting moments forever."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Immune to one instance of Fatal DMG if Death Resistance was not triggered, restore [Arg1] HP, and permanently remove this Relic."
  },
  RelicConfig_13842_Desc = {
    Text = "Immune to one instance of Fatal DMG if Death Resistance was not triggered, restore [Arg1] HP, and permanently remove this Relic."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Stand-In Doll>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hehehe, hehehe. It's you who owes me, right?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "You gain [Arg1] Shield when you inflict <WeaknessIconKeywords:Weakness>; you gain [Arg2] Temporary <PowerIconKeywords:STR> when you inflict <VulnerabilityIconKeywords:Vulnerable>. If both effects are triggered within 1 Turn, you additionally gain [Arg1] Shield and [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13844_Desc = {
    Text = "You gain [Arg1] Shield when you inflict <WeaknessIconKeywords:Weakness>; you gain [Arg2] Temporary <PowerIconKeywords:STR> when you inflict <VulnerabilityIconKeywords:Vulnerable>. If both effects are triggered within 1 turn, you additionally gain [Arg1] Shield and [Arg2] Temp <PowerIconKeywords:STR>."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Gilded Frame>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "The final work of a mentally disturbed artist, said to reveal his terrified visage."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "When the last 1 Arithmetica is depleted, gain 2 Arithmetica. It can trigger up to 2 times per turn."
  },
  RelicConfig_13845_Desc = {
    Text = "When you deplete the last 1 Arithmetica, gain 2 Arithmetica. Maximum 2 triggers per turn."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Differential Engine☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"It changed history.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Every time you lose HP, gain [Arg1] <PowerIconKeywords:STR>, up to 10 times per battle. When fully stacked, restore 25% of lost HP."
  },
  RelicConfig_13846_Desc = {
    Text = "Every time you lose HP, gain [Arg1] <PowerIconKeywords:STR>, up to 10 times per battle. When fully stacked, restore 25% of lost HP."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Highest Honor>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "An elegant and mysterious black short-haired cat, said to be revered as a deity in a distant desert kingdom. The name of that deity has now been lost to time.\nWorshipped, revered, forgotten—perhaps this is the fate of all gods."
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Deal 20% more DMG to enemies with debuffs, and gain 20 Aliemus upon killing them."
  },
  RelicConfig_13847_Desc = {
    Text = "Deal 20% more DMG to enemies with debuffs, and gain 20 Aliemus upon killing them."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Hierophant's Staff>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Unsanctioned Piety"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "When picked up, the team's Realm Mastery increases to 150% of its Base value. After playing the 5th Command Card each turn, all Awakeners gain 20 Aliemus."
  },
  RelicConfig_13848_Desc = {
    Text = "When picked up, the team's Realm Mastery increases to 150% of its base value. After playing the 5th Command Card each turn, all Awakeners gain 20 Aliemus."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Unclean\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "After dealing the 3rd DMG each turn, gain [Arg1] Shield. After dealing the 6th DMG each turn, gain [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13849_Desc = {
    Text = "After dealing the 3rd DMG Each turn, Obtain [Arg1] Shield. After dealing the 6th DMG Each turn, Obtain [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Safe Passage>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Looks like he didn't make it out either."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "For each <DevouredIconKeywords:Devour>, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies."
  },
  RelicConfig_13851_Desc = {
    Text = "For each <DevouredIconKeywords:Devour>, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Phantom Hand>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "The perfect tool for killing, looting, and scratching."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Upon pickup, choose an Awakener to Rouse. Their Rouse card's Arithmetica Cost is permanently reduced by 1."
  },
  RelicConfig_13852_Desc = {
    Text = "Upon pickup, choose an Awakener to Awaken. The Arithmetica Cost of its Rouse card is permanently reduced by 1."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Easter Moment>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Enjoy the fun, but do not eat."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Whenever DMG is dealt, gain [Arg1] Temporary <RetaliateIconKeywords:Counter>, which can trigger up to 5 times per turn. When it triggers for the 5th time, place a <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile."
  },
  RelicConfig_13853_Desc = {
    Text = "Whenever DMG is dealt, gain [Arg1] Temporary <RetaliateIconKeywords:Counter>. This can trigger up to 5 times per turn, and when it triggers for the 5th time, put a <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Ritual Dagger>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "A dagger with a curved blade, commonly used in sacrificial rituals."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "At turn start, draw 2 cards and gain 2 Arithmetica. Whenever you draw a Command Card or experience Rouse, randomly alter its Arithmetica Cost. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "At turn start, draw 2 cards and gain 2 Arithmetica. Whenever you draw a Command Card or experience Rouse, randomly alter its Arithmetica Cost. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:Trickster's Hat>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = [[
Welcome to Miss Casiah's Wonderland Circus! Be careful, don't touch the magic items. If you get bitten, it could be bad.
Last time it tasted blood, the outcome was terrible.

The top hat winked as if ready to emerge.]]
  },
  RelicConfig_13855_BattleDesc = {
    Text = "At turn start and whenever HP is recovered, gain [Arg1] <RetaliateIconKeywords:Counter>. Can occur up to 3 times per turn. When the limit is reached, deal 1 instance of 100% <RetaliateIconKeywords:Counter> True DMG to all enemies."
  },
  RelicConfig_13855_Desc = {
    Text = "At turn start and whenever HP is recovered, gain [Arg1] <RetaliateIconKeywords:Counter>. Can occur up to 3 times per turn. When the limit is reached, deal 1 instance of 100% <RetaliateIconKeywords:Counter> True DMG to all enemies."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Tiny Music Box>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = [[
Dexter's mansion has many collections. Before it was broken, the Tiny Music Box was Miss Dexter's favorite toy.
As time passed, when Miss Dexter found it again, its gears were loose, the music off-key, but it still kept spinning.]]
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Crit. DMG +15%. \"Strike\" Crit. Rate +40%."
  },
  RelicConfig_13856_Desc = {
    Text = "Crit. DMG increased by 15%. \"Strike\" Crit. Rate increased by 40%."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Ivory Raven Beak>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "There are no secrets before it."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "After releasing Exalt, gain [Arg1] <RetaliateIconKeywords:Counter>. If this is the 6th trigger in this battle, double your <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13857_Desc = {
    Text = "After releasing Exalt, gain [Arg1] <RetaliateIconKeywords:Counter>. If this is the 6th trigger in this battle, double your <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextant☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "The only path ahead of you is one of misguidance."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Draw 1 additional card each Turn, Gain 1 Arithmetica."
  },
  RelicConfig_13858_Desc = {
    Text = "Draw 1 extra card and gain 1 Arithmetica each turn."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Fond Reminiscence☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Some people remained in that summer forever."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "At turn start, draw 1 card. At the start of the battle, shuffle 1 <DerivativeCardKeywords_4:\"Insight\"> into your deck. Each battle increases the number of <DerivativeCardKeywords_4:\"Insight\"> cards shuffled into your deck by 1, up to 3 times."
  },
  RelicConfig_13859_Desc = {
    Text = "At turn start, draw 1 card. At the start of the battle, shuffle 1 <DerivativeCardKeywords_4:\"Insight\"> into your deck. Each battle increases the number of <DerivativeCardKeywords_4:\"Insight\"> cards shuffled into your deck by 1, up to 3 times."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Prasno Lens>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "The Trick of Light and Shadow"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Whenever consecutive cards of the same Awakener are played, that Awakener gains 8 Aliemus."
  },
  RelicConfig_13860_Desc = {
    Text = "Whenever consecutive cards of the same Awakener are played, that Awakener gains 8 Aliemus."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Chronometric Device>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "One of the most sinister inventions in human history."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "When picked up, choose a card of an Awakener to reduce its Arithmetica Cost by 1 and treat it as \"Strike\"."
  },
  RelicConfig_13861_Desc = {
    Text = "When picked up, choose a card of an Awakener to reduce its Arithmetica Cost by 1, treating it as \"Strike\"."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Sudden Fallacy>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Laugh to your heart's content!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Picking up will permanently lose [Arg1] <PowerIconKeywords:STR>. Whenever you deal DMG, heal for [Arg2] HP, up to 6 times per turn."
  },
  RelicConfig_13862_Desc = {
    Text = "Picking up will cause you to permanently lose [Arg1] <PowerIconKeywords:STR>. Whenever you deal Damage, heal for [Arg2] HP, with a maximum of 6 triggers per turn."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Lamprey Kiss>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Want a deep kiss? The kind that takes your life."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Gain 3 Arithmetica in the first turn of each battle."
  },
  RelicConfig_13863_Desc = {
    Text = "Gain 3 Arithmetica in the first turn of each battle."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:Pocketwatch Mirror>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Memories solidified in the past, buried deep in the black depths."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "After playing a Command Card for the first time each turn, place a \"Strike\" corresponding to the Awakener into hand, and grant it <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust>."
  },
  RelicConfig_13864_Desc = {
    Text = "After playing a Command Card for the first time each turn, place a \"Strike\" corresponding to the Awakener into hand, and grant it <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust>."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Modern Axle>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Ride from the countryside to the city, from calamity to rebirth."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "After playing a Command Card for the first time each turn, add one \"Defense\" card corresponding to the Awakener to your hand and attach <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust>."
  },
  RelicConfig_13865_Desc = {
    Text = "After playing a Command Card for the first time each turn, add one \"Defense\" to your hand corresponding to the Awakener and attach <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust>."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Silent Prelude>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = [[
The violin of the renowned violinist Eric Eckstein.
Now, it can no longer be played.]]
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Every 3 turns, add 1 stack of <VulnerabilityIconKeywords:Vulnerable> to all enemies. After dealing DMG to a <VulnerabilityIconKeywords:Vulnerable> enemy, reduce their Temporary <PowerIconKeywords:STR> by [Arg1], with a maximum of 3 triggers per turn."
  },
  RelicConfig_13866_Desc = {
    Text = "Every 3 turns, add 1 stack of <VulnerabilityIconKeywords:Vulnerable> to all enemies. After dealing DMG to a <VulnerabilityIconKeywords:Vulnerable> enemy, reduce their Temporary <PowerIconKeywords:STR> by [Arg1], with a maximum of 3 triggers per turn."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Rite of Spring>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Amid the laughter of the night, the silhouette of the canoe glides effortlessly across the lake."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Increase hand limit by 3, but draw 1 less card each turn. Discard all Symptom Cards and State Cards at turn end, retaining other cards."
  },
  RelicConfig_13867_Desc = {
    Text = "Increase hand limit by 3, but draw 1 less card each turn. Discard all Symptom Cards and State Cards at turn end, keeping other cards."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Mind Engraving>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "The ancient tribe believed that engraving special symbols on the skulls of the dead could keep their souls for eternal companionship."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "After releasing Exalt 4 times, reduce the Arithmetica Cost of all cards in hand by 1."
  },
  RelicConfig_13868_Desc = {
    Text = "After releasing Exalt 4 times, reduce Arithmetica Cost for all cards in hand by 1."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Escape Plan☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"After boarding, please first locate the nearest emergency exit to your cabin.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> is increased by 100. Every time Active DMG is dealt, Temporary Tentacle DMG increases by [Arg1]; every time Tentacle DMG is dealt, gain [Arg2] Shield. This effect can trigger a maximum of 6 times per turn."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> boosts by 100. Every time an Active DMG is dealt, Temporary Tentacle DMG +[Arg1]; every time a Tentacle DMG is dealt, Obtain [Arg2] Shield. This effect can occur a maximum of 6 times per turn."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Nightmare\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "For every 1 Arithmetica consumed, the corresponding Awakener gains 2 Aliemus."
  },
  RelicConfig_13870_Desc = {
    Text = "For every 1 Arithmetica consumed, the corresponding Awakener gains 2 Aliemus."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Silver Ribbon>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = [[
The ribbon found at the crime scene was torn into two pieces by force.
One piece floated down from high above and landed in the girl's palm.]]
  },
  RelicConfig_13871_BattleDesc = {
    Text = "All Awakeners gain 10 Aliemus at turn start. Reduce Max HP by 30% upon pickup."
  },
  RelicConfig_13871_Desc = {
    Text = "All Awakeners gain 10 Aliemus at turn start. Reduce Max HP by 30% upon pickup."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Nightmare Manifest>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Watch out, indulgent deep sleep will devour everything without you noticing."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Play \"<ExaltIconKeywords:Rouse>\" to remove all enemy Shield."
  },
  RelicConfig_13873_Desc = {
    Text = "Play \"<ExaltIconKeywords:Rouse>\" to remove all enemy Shield."
  },
  RelicConfig_13873_Name = {
    Text = "Black Mirror"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "On odd turns, draw 2 cards if you have no cards remaining; on even turns, gain 2 Arithmetica if you have none remaining."
  },
  RelicConfig_13874_Desc = {
    Text = "On odd turns, draw 2 cards if you have no cards remaining; on even turns, gain 2 Arithmetica if you have none remaining."
  },
  RelicConfig_13874_Name = {
    Text = "Mutated Gilded Guide"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "After playing \"Strike\" and \"Defense\", the corresponding Awakener gains 35 Aliemus. However, their Arithmetica Cost increases by +1."
  },
  RelicConfig_13875_Desc = {
    Text = "After playing \"Strike\" and \"Defense\", the corresponding Awakeners gain 35 Aliemus. However, their Arithmetica Cost increases by +1."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Broken Visage>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Whose face, filled with terror, is frozen in time."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "After gaining the 2nd Shield each turn, gain [Arg1] stacks of <RetaliateIconKeywords:Counter>. After gaining the 4th Shield each turn, deal 1 instance of <RetaliateIconKeywords:Counter> DMG to all enemies."
  },
  RelicConfig_13877_Desc = {
    Text = "After gaining the 2nd Shield each turn, gain [Arg1] stacks of <RetaliateIconKeywords:Counter>. After gaining the 4th Shield each turn, deal <RetaliateIconKeywords:Counter> DMG to All enemies."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Truth Unbound>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "It conveys countless secrets, whether spoken actively or passively."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Every 6th Command Card played returns it from the Discard Pile to your hand."
  },
  RelicConfig_13878_Desc = {
    Text = "Playing the 6th Command Card returns it to your hand from the Discard Pile."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:In Twilight>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Let's take a photo together! Experience the feeling of real pain."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "After releasing Exalt 5 times, the Awakener that released it gains 100 Aliemus."
  },
  RelicConfig_13879_Desc = {
    Text = "After releasing 5 Exalts, the Awakener who released the Exalts gains 100 Aliemus."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Tiny Cradle>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Carrying hope, blessings, and love."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Obtain [Arg1] Shield when dealing Active DMG. Obtain [Arg2] Temporary <PowerIconKeywords:STR> when restoring HP."
  },
  RelicConfig_13880_Desc = {
    Text = "Obtain [Arg1] Shield when dealing Active DMG. Obtain [Arg2] Temporary <PowerIconKeywords:STR> when restoring HP."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Our Home>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "They were together in the past, and they will always be together in the future. They are a close-knit and loving family."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "At the start of an odd-numbered turn, gain [Arg1] Temporary<PowerIconKeywords:STR>. At the start of an even-numbered turn, gain [Arg2] Temporary<AlertIconKeywords:Alert>."
  },
  RelicConfig_13881_Desc = {
    Text = "At the start of odd-numbered turns, gain [Arg1] Temporary <PowerIconKeywords:STR>. At the start of even-numbered turns, gain [Arg2] Temporary <AlertIconKeywords:Alert>."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Twin Dolls>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Twinbirth is a gift from the old era, a parable for the future."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "At the end of each turn, when playing the first Command Card with the corresponding Awakener, gain 20 Aliemus. If also possessing the Relic \"Devoted Heart\", other Awakeners also gain 5 Aliemus."
  },
  RelicConfig_13882_Desc = {
    Text = "At the end of each turn, when playing the first Command Card with the corresponding Awakener, gain 20 Aliemus. When you have the Relic \"Devoted Heart\", grant other Awakeners 5 Aliemus."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Mother Effigy>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"I'll give you anything, whatever you want, please let him go.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Whenever an Awakener has <DevouredIconKeywords:Devour> once, other Awakeners gain 10 Aliemus."
  },
  RelicConfig_13883_Desc = {
    Text = "Whenever an Awakener has <DevouredIconKeywords:Devour> once, other Awakeners gain 10 Aliemus."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Gilded Reverie>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "The day of transformation will be your doom."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Strike\" inflicts [Arg1] stacks of <IntoxicationIconKeywords:Poison> on all enemies."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Strike\" inflicts [Arg1] stacks of <IntoxicationIconKeywords:Poison> on all enemies."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoxin>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Extract, Refine."
  },
  RelicConfig_13885_BattleDesc = {
    Text = "At the start of the battle, place 1 <DerivativeCardKeywords_1:Echoes of Lost Shadows> into hand. If it is a Boss Battle, gain an additional 1 <DerivativeCardKeywords_1:Echoes of Lost Shadows>."
  },
  RelicConfig_13885_Desc = {
    Text = "At the start of the battle, place 1 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand. If it is a Boss Battle, gain an additional 1 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\">."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Signal Relay>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Anticipate or dread the moment it chimes."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Each time you reset the deck, add 2 <DerivativeCardKeywords_5:Barbed Trident> and 1 <DerivativeCardKeywords_6:Parasol> to your hand."
  },
  RelicConfig_13886_Desc = {
    Text = "Each time you reset the deck, add 2 <DerivativeCardKeywords_6:\"Barbed Trident\"> and 1 <DerivativeCardKeywords_5:\"Parasol\"> to your hand."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Lady's Purse☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "It was meant to carry refinement, not death."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "At turn start, add 1 <DerivativeCardKeywords_5:\"Barbed Trident\"> to your hand. After releasing Exalt, increase the <PowerIconKeywords:STR> of all <DerivativeCardKeywords_5:\"Barbed Trident\"> in your hand by [Arg2]."
  },
  RelicConfig_13887_Desc = {
    Text = "At turn start, add 1 <DerivativeCardKeywords_5:\"Barbed Trident\"> to your hand. After releasing Exalt, increase the <PowerIconKeywords:STR> of all <DerivativeCardKeywords_5:\"Barbed Trident\"> in your hand by [Arg2]."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:Barbed Trident>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "No matter how you look at it, it's just ordinary."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Gain [Arg1] Shield at the start of battle. After playing \"Defense\" 7 times in this battle, immediately gain [Arg2] Shield. After playing \"Defense\" 21 times in this battle, gain 1 stack of Temporary Barrier."
  },
  RelicConfig_13888_Desc = {
    Text = "Gain [Arg1] Shield at the start of battle. After playing \"Defense\" 7 times in this battle, immediately gain [Arg2] Shield. After playing \"Defense\" 21 times in this battle, gain 1 stack of Temporary Barrier."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Your most thoughtful toilet companion."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Upon entering the Ultra Round, gain 3 Arithmetica."
  },
  RelicConfig_13889_Desc = {
    Text = "Upon entering the Ultra Round, gain 3 Arithmetica."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:Luminous Hourglass>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "A measurable amount of time."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "At the start of battle, inflict 1 turn of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies. If it is a Boss Battle, additionally inflict 2 turns of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable>."
  },
  RelicConfig_13890_Desc = {
    Text = "At the start of battle, inflict 1 turn of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies. If it is a Boss Battle, additionally inflict 2 turns of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable>."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Shifting Straitjacket>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Not only can time cause fabric to fade, but fear and pain as well."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "The first Command Card played each turn that triggers a Leap effect draws 1 card; otherwise, gain 1 Arithmetica. During Ultra Rounds, both effects apply."
  },
  RelicConfig_13891_Desc = {
    Text = "The first Command Card played each turn that triggers a Leap effect draws 1 card; otherwise, gain 1 Arithmetica. During Ultra Rounds, both effects apply."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Warp Device>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Reflects a twisted shadow."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Obtain a task. Upon completing the task, receive a reward. [Task Event Placeholder]"
  },
  RelicConfig_13892_Desc = {
    Text = "Gain a quest. Complete the quest to receive rewards. [Event Placeholder]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Tattered Diary>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = [[
An old diary stuffed with inserts, including maps of Elworth, experiment logs, and letters marked with triangular D-Marks.
The handwriting at the beginning is neat and tidy, but gradually becomes messy and chaotic.]]
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Every 4th time you gain Shield, heal HP equal to 50% of that Shield value."
  },
  RelicConfig_13893_Desc = {
    Text = "Every 4th time you gain a Shield, restore HP equal to 50% of the Shield."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Sailor Whistle>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Apart from mermaids, the whistle can summon hurricanes, smelly boots, and sailors who haven't bathed in a hundred days."
  },
  RelicConfig_13894_BattleDesc = {
    Text = "If the number of cards played last turn is less than or equal to 4, the first card played this turn takes effect twice."
  },
  RelicConfig_13894_Desc = {
    Text = "If the number of cards played last turn is less than or equal to 4, the first card played this turn takes effect twice."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Nightmare Lantern☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Introduce Phantasm."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Every time you lose HP, Awakener with the lowest Aliemus gains 10 Aliemus. Every 5th time you lose HP, recover 20% of the lost HP."
  },
  RelicConfig_13895_Desc = {
    Text = "Every time you lose HP, Awakener with the lowest Aliemus gains 10 Aliemus. Every 5 time you lose HP, recover 20% of the lost HP."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Parsing\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Max Arithmetica increases by 2. Each time the deck is reset, add 1 <DerivativeCardKeywords_9:Stagger> to the Draw Pile."
  },
  RelicConfig_13896_Desc = {
    Text = "Max Arithmetica +2. Each time the deck is reset, add 1 <DerivativeCardKeywords_9:\"Stagger\"> to the Draw Pile."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Black Candle>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Burn in clarity, fall into illusion."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Rouse> Cards are retained at turn end."
  },
  RelicConfig_13897_Desc = {
    Text = "<ExaltIconKeywords:Rouse> Cards are retained at turn end."
  },
  RelicConfig_13897_Name = {
    Text = "White Mirror"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "For each Awakener that has been Roused, increase <ProficientInRealmsIconKeywords:Realm Mastery> by 35. After playing \"<ExaltIconKeywords:Rouse>\", randomly gain 2 Command Cards of that Awakener and attach \"Exhaust\"."
  },
  RelicConfig_13898_Desc = {
    Text = "For each Roused Awakener, increase <ProficientInRealmsIconKeywords:Realm Mastery> by 35. After playing \"<ExaltIconKeywords:Rouse>\", randomly gain 2 Command Cards of that Awakener and attach \"Exhaust\"."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Divine Oracle>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "He said, \"Do not be afraid.\""
  },
  RelicConfig_13899_BattleDesc = {
    Text = "At turn start, <ProficientInRealmsIconKeywords:Realm Mastery> increases by 50. When not in a debuff, <ProficientInRealmsIconKeywords:Realm Mastery> increases to 150."
  },
  RelicConfig_13899_Desc = {
    Text = "At turn start, <ProficientInRealmsIconKeywords:Realm Mastery> increases by 50. When not in a debuff, <ProficientInRealmsIconKeywords:Realm Mastery> increases to 150."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"To Freedom\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "A handful of Silver that evokes a sense of nostalgia."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "After using \"Exalt\", all cards' Arithmetica Cost is reduced by 1."
  },
  RelicConfig_13900_Desc = {
    Text = "After using \"Exalt,\" all cards' Arithmetica Costs in hand -1."
  },
  RelicConfig_13900_Name = {
    Text = "Mutated Light of Civilization"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Obtain [Arg2]% <DeathResistanceIconKeywords:Death Resistance> each time you play a Command Card (each time Death Resistance triggers in this stage, the gained Death Resistance is halved). If your <DeathResistanceIconKeywords:Death Resistance> is greater than or equal to 100%, gain [Arg1] Temporary <PowerIconKeywords:STR> instead."
  },
  RelicConfig_13901_Desc = {
    Text = "Obtain [Arg2]% <DeathResistanceIconKeywords:Death Resistance> each time you play a Command Card (each time Death Resistance triggers in this stage, the gained Death Resistance is halved). If your <DeathResistanceIconKeywords:Death Resistance> is greater than or equal to 100%, gain [Arg1] Temporary <PowerIconKeywords:STR> instead."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Serpent's Husk>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Rebirth from self-mutilation"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "At turn start, gain [Arg2] Shield. At turn end, deal DMG equal to [Arg1]% of your current Shield to a random enemy. The DMG effect is doubled in Boss Battles."
  },
  RelicConfig_13902_Desc = {
    Text = "At turn start, gain [Arg2] Shield. At turn end, deal DMG to a random enemy equal to [Arg1]% of your current Shield. In Boss Battle, the DMG is doubled."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Gilded Guide>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "When you're lost, open it. But be cautious — its corona must not be exposed to sunlight."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Hide monster intentions. Gain 1 Arithmetica each turn and draw 1 card."
  },
  RelicConfig_13904_Desc = {
    Text = "Hide monster intentions. Gain 1 Arithmetica each turn and draw 1 card."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Enthralling Chime>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Jingle, jingle."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "After the battle starts, gain [Arg2] stacks of <RetaliateIconKeywords:Counter>. Play \"Defense\" to gain [Arg1] stacks of <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13905_Desc = {
    Text = "After the battle starts, gain [Arg2] stacks of <RetaliateIconKeywords:Counter>. Play \"Defense\" to gain [Arg1] stacks of <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Nettle Vest>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Unable to identify the liquid that has been contaminated."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 4"
  },
  RelicConfig_13906_Desc = {
    Text = "This is a weekly Relic 4 with no Effect"
  },
  RelicConfig_13906_Name = {
    Text = "Daily Challenge Weekly Replacement Relic 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "At turn start, if you played more than 3 cards last turn, draw 2 cards."
  },
  RelicConfig_13907_Desc = {
    Text = "At turn start, if you played more than 3 cards last turn, draw 2 cards."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Brand-New Wallet>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = [[
A leather wallet engraved with the emblem of Mythag University.
It is now empty, containing nothing.]]
  },
  RelicConfig_13908_BattleDesc = {
    Text = "After using \"Exalt,\" the Awakener gains [Arg1] Aliemus."
  },
  RelicConfig_13908_Desc = {
    Text = "After using \"Exalt,\" the Awakener gains [Arg1] Aliemus."
  },
  RelicConfig_13908_Name = {
    Text = "Mutated Veil of the Nameless Deity"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "After releasing Exalt, lose 8% of current HP, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13909_Desc = {
    Text = "After releasing Exalt, lose 8% of current HP, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Omen Ritual Bird>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "The withered corpse let out a screech."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "After releasing Exalt, the corresponding Awakener gains 10 Aliemus and [Arg1] Shield."
  },
  RelicConfig_13910_Desc = {
    Text = "After Exalt, the corresponding Awakener gains 10 Aliemus and [Arg1] Shield."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Veil of the Nameless Deity>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Do not look directly at the gods."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "At the end of each turn, the corresponding Awakener who played the last Command Card gains 20 Aliemus. If they also possess the Relic \"Mother Effigy\", other Awakeners gain 5 Aliemus as well."
  },
  RelicConfig_13911_Desc = {
    Text = "At the end of each turn, when the corresponding Awakener for the last Command Card is played, gain 20 Aliemus. If also possessing the Relic \"Mother Effigy\", grant other Awakeners 5 Aliemus."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Devoted Heart>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"I'll give you anything, anything at all. Please spare me.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "At turn end, for each remaining card in hand, gain 1 Arithmetica at the start of next turn."
  },
  RelicConfig_13912_Desc = {
    Text = "At turn end, for each remaining card in hand, gain 1 Arithmetica at the start of next turn."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Emulate\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "At turn start, if HP is greater than [Arg1], lose [Arg1] HP and gain [Arg2] <PowerIconKeywords:STR> and [Arg3] <AlertIconKeywords:Alert> this turn."
  },
  RelicConfig_13913_Desc = {
    Text = "At turn start, if HP is greater than [Arg1], lose [Arg1] HP, and gain [Arg2] <PowerIconKeywords:STR> and [Arg3] <AlertIconKeywords:Alert> this turn."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Salvific Limb>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = [[
A sacred part.
Even when separated from the body, its warmth can still be felt.]]
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Strike\" gains 2 Arithmetica and discards 1 random card; \"Defense\" draws 2 cards and loses 1 Arithmetica. Can be triggered up to 3 times per turn."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Strike\" gains 2 Arithmetica and discards 1 random card; \"Defense\" draws 2 cards and loses 1 Arithmetica. Can be triggered up to 3 times per turn."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Joyous Record>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = [[
A record of the famous violinist's final performance.
Since then, it has been able to summon flames.]]
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Recommended Realm buff effect is increased to 50%, and your <ProficientInRealmsIconKeywords:Realm Mastery> is doubled at the start of the level."
  },
  RelicConfig_13915_Desc = {
    Text = "Recommended buff effect is increased to 50%, and your <ProficientInRealmsIconKeywords:Realm Mastery> is doubled at the start of the stage."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Morpheus\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "After triggering an Exalt, the next command card played takes effect twice."
  },
  RelicConfig_13916_Desc = {
    Text = "After triggering an Exalt, the next command card played takes effect twice."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Submersion\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "If the enemy's intention is to attack, temporarily reduce their <PowerIconKeywords:STR> by [Arg1] after dealing Damage. Otherwise, apply <BleedingIconKeywords:Bleed> equal to 25% of the DMG dealt, up to 6 times per turn."
  },
  RelicConfig_13917_Desc = {
    Text = "If the enemy's intent is to attack, temporarily reduce their <PowerIconKeywords:STR> by [Arg1] after dealing Damage, otherwise Inflict <BleedingIconKeywords:Bleed> equal to 25% of the DMG dealt, up to 6 times per turn."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Alien Heart>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Two \"hearts\" nestled closely together"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Each time DMG is dealt, gain [Arg1] Temporary <PowerIconKeywords:STR>, up to 3 times. When at maximum stacks, the effect is doubled."
  },
  RelicConfig_13918_Desc = {
    Text = "Each time DMG is dealt, gain [Arg1] Temporary <PowerIconKeywords:STR>, up to 3 times. When at maximum stacks, the effect is doubled."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Filigree Agate>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "It's probably just ordinary agate patterns. Perhaps."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increases by 50. When picked up, choose a Relic and change it to a random one."
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increases by 50. When picked up, choose a Relic and change it to a random Relic."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Kaleidoscope>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "What you think and see are all illusions."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "The caused Weakness effect is increased by 5%. When applying <WeaknessIconKeywords:Weakness>, temporarily steal [Arg1] <PowerIconKeywords:STR> from the target."
  },
  RelicConfig_13920_Desc = {
    Text = "The caused Weakness effect is increased by 5%. When applying <WeaknessIconKeywords:Weakness>, temporarily steal [Arg1] <PowerIconKeywords:STR> from the target."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Faded Photo>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "The blurry photo carries a blurry Memory, or perhaps—it's the incompleteness of Memory that leads to the photo's fading."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "When picked, choose 2 Command Cards to Delete and Obtain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13921_Desc = {
    Text = "When picked, choose 2 Command Cards to Delete, Obtain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Black Star Ember>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "The embers still glow."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "After releasing Exalt 2 times per turn, all Awakeners gain 8 Aliemus. After releasing it 3 times, all Awakeners gain an additional 8 Aliemus."
  },
  RelicConfig_13922_Desc = {
    Text = "After releasing 2 Exalts each turn, all Awakeners gain 8 Aliemus. After releasing 3 Exalts, all Awakeners gain an additional 8 Aliemus."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Forsaken Blood>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Gradually melting away."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Shield. At turn start, for every 3 remaining Shield, gain 1 Temporary <PowerIconKeywords:STR> and Tentacle DMG."
  },
  RelicConfig_13923_Desc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Shield. At turn start, for every 3 remaining Shield, gain 1 point of Temporary <PowerIconKeywords:STR> and Tentacle DMG."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Occult\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Whenever the <TransitionIconKeywords:Leap> effect is triggered, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13924_Desc = {
    Text = "Whenever the <TransitionIconKeywords:Leap> effect is triggered, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Spatial Deflector>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Leap into the void."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Draw 1 card at the start of your turn. Draw 1 additional card if you play 2 cards with the same Arithmetica Cost consecutively, up to 3 times per turn."
  },
  RelicConfig_13925_Desc = {
    Text = "Draw 1 card at turn start. Draw 1 additional card if you play 2 cards with the same Arithmetica Cost consecutively, up to 3 times per turn."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Gnosis Device>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Omniscient and Omnipotent."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "At the start of battle, for each Orison in your deck, gain [Arg1] <PowerIconKeywords:STR>. For each Relic, recover [Arg2] HP."
  },
  RelicConfig_13926_Desc = {
    Text = "At the start of battle, for each Orison in your deck, gain [Arg1] <PowerIconKeywords:STR>. For each Relic, recover [Arg2] HP."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Guild Medal☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Wear it, and you're a member of the Londinium Chamber of Commerce.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Remove 1 Symptom Card upon pickup. Upgrade 1 random Orison to an Advanced Orison."
  },
  RelicConfig_13927_Desc = {
    Text = "Remove 1 Symptom Card upon pickup. Upgrade 1 random Orison to an Advanced Orison."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Lucky Rabbit's Paw>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Not so lucky for the rabbit."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Crit. Rate increased by 15%. Each card played increases Temporary Crit. Rate by 5%."
  },
  RelicConfig_13928_Desc = {
    Text = "Crit. Rate increased by 15%. Each card played increases Temporary Crit. Rate by 5%."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Memphis Ritual Mirror>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"What did you see within?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Every time you lose HP, gain [Arg1] stacks of <RetaliateIconKeywords:Counter>. If this is the 3rd trigger in a single turn, deal <RetaliateIconKeywords:Counter> DMG to all enemies 1 time."
  },
  RelicConfig_13929_Desc = {
    Text = "Every time you lose HP, gain [Arg1] stacks of <RetaliateIconKeywords:Counter>. If this is the 3rd trigger in a single turn, deal Counter DMG to all enemies 1 time."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Deceased's Chrono>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Carrying memories and sorrow, moving toward the unknown."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "At turn end, for each card in hand, apply [Arg1] stacks of <IntoxicationIconKeywords:Poison> to all enemies."
  },
  RelicConfig_13930_Desc = {
    Text = "At turn end, for each card in hand, inflict [Arg1] stacks of <IntoxicationIconKeywords:Poison> on all enemies."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Uncanny Salve>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Some kind of homemade ointment for external injuries. Do not use without a doctor's guidance."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Obtain [Arg1] <PowerIconKeywords:STR> when picked up. Whenever a <DerivativeCardKeywords_2:\"Embryo\"> is fused, gain [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13931_Desc = {
    Text = "Obtain [Arg1] <PowerIconKeywords:STR> when picked up. Whenever a <DerivativeCardKeywords_2:\"Embryo\"> is fused, gain [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Bloody Pebble>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "One, Two, Three, Four, Five."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Every 3rd time \"Defense\" is played, gain [Arg1] Shield. The corresponding Awakener gains 15 Aliemus."
  },
  RelicConfig_13932_Desc = {
    Text = "Every 3rd time \"Defense\" is played, gain [Arg1] Shield. The corresponding Awakener gains 15 Aliemus."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Muted Gloves>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "They have been stained with countless blood, tears, and mold."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 6"
  },
  RelicConfig_13933_Desc = {
    Text = "This is a weekly Relic 6 with no Effect"
  },
  RelicConfig_13933_Name = {
    Text = "Daily Challenge - Weekly Relic 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 5"
  },
  RelicConfig_13934_Desc = {
    Text = "This is a weekly Relic 5 with no Effect"
  },
  RelicConfig_13934_Name = {
    Text = "Daily Challenge Weekly Replacement Relic 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Crit. Rate +10%. After the first Critical Hit each Turn, increase Crit. Rate by an additional 20%. After the third Critical Hit each Turn, increase Crit. DMG by an additional 50%."
  },
  RelicConfig_13935_Desc = {
    Text = "Crit. Rate +10%. After the first Critical Hit each turn, increase Crit. Rate by an extra 20%. After the 3rd Critical Hit each turn, increase Crit. DMG by an extra 50%."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Festive Benediction>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "It should bring blessings to those in love."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 3"
  },
  RelicConfig_13936_Desc = {
    Text = "This is a weekly Relic 3 with no Effect"
  },
  RelicConfig_13936_Name = {
    Text = "Daily Challenge - Weekly Relic 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 2"
  },
  RelicConfig_13937_Desc = {
    Text = "This is a weekly Relic 2 with no Effect"
  },
  RelicConfig_13937_Name = {
    Text = "Weekly Replacement Relic 2 for Daily Challenges"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "This is a weekly Relic with no Effect 1"
  },
  RelicConfig_13938_Desc = {
    Text = "This is a weekly Relic 1 with no Effect"
  },
  RelicConfig_13938_Name = {
    Text = "Weekly Replacement Relic 1 for Daily Challenge"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "At the start of turn 3, increase Crit. Rate in this battle by 15%, and add 1 <DerivativeCardKeywords_39:Echoes of the Past> to your hand."
  },
  RelicConfig_13939_Desc = {
    Text = "At the start of turn 3, increase the Crit. Rate in this battle by 15%, and add 1 <DerivativeCardKeywords_39:\"Echoes of the Past\"> to your hand."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Relic of the Past>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "An offering once presented."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "When you have a Shield, this Relic provides [Arg1] Temporary <PowerIconKeywords:STR>. When your Shield is higher than your Current HP, it provides an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13940_Desc = {
    Text = "When you have a Shield, this Relic provides [Arg1] Temporary <PowerIconKeywords:STR>. If your Shield is higher than your Current HP, it provides an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Dove Feather Fan>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Exquisite, expensive, yet not very practical."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Strike\" restores [Arg1] HP and reduces own <IntoxicationIconKeywords:Poison> by [Arg1] stacks."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Strike\" restores [Arg1] HP and reduces self <IntoxicationIconKeywords:Poison> by [Arg1] stacks."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Hemostatic Clamp>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Hurry, hurry! Give it to me!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Each Tentacle grants [Arg1] Shield at turn end. When in Tranquil Sea Stance, this effect grants an additional 50% Shield."
  },
  RelicConfig_13942_Desc = {
    Text = "Each Tentacle grants [Arg1] Shield at turn end. When in Tranquil Sea Stance, this effect grants an additional 50% Shield."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Nameless Appendage>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Be careful not to get pricked."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Temporary <PowerIconKeywords:STR>, up to 5 stacks. When the stack limit is reached, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_20164_Desc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Temporary <PowerIconKeywords:STR>, up to 5 stacks. When the stack limit is reached, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sleepless\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Rouse all Awakeners. After playing <ExaltIconKeywords:Rouse>, randomly gain 2 Command Cards of that Awakener with \"Exhaust\" and \"Fleeting\"."
  },
  RelicConfig_20165_Desc = {
    Text = "Rouse all Awakeners. After playing <ExaltIconKeywords:Rouse>, randomly gain 2 Command Cards of that Awakener with \"Exhaust\" and \"Fleeting\"."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Divine Oracle+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "He said, \"Do not be afraid.\""
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> Increase by 100. Return the first card played each turn to your hand. At the start of an Ultra Round, increase the Hand Limit by 5 and Copy your hand."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increased by 100. Place the first card played each turn from the Discard Pile back into hand. At the start of an Ultra Round, the Hand Limit for that turn is increased by 5 and your hand is duplicated, the duplicates gain <NothingnessIconKeywords:Fleeting> and <DepleteIconKeywords:Exhaust>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Dreamtheft\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "At turn end, if there is remaining Arithmetica, draw 2 extra cards next turn; if there are remaining cards in hand, gain 2 extra Arithmetica next turn."
  },
  RelicConfig_20167_Desc = {
    Text = "At turn end, if there is remaining Arithmetica, draw 2 extra cards next turn; if there are remaining cards in hand, gain 2 extra Arithmetica next turn."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Solar Disc+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Guess, is it black or white?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Tentacle Limit +2. After releasing Exalt, Tentacle DMG +[Arg1]. If Exalt is released 3 times in a turn, activate all Tentacles once."
  },
  RelicConfig_20168_Desc = {
    Text = "Tentacle Limit +2. After triggering Exalt, Tentacle DMG +[Arg1]. When Exalt is triggered 3 times in a turn, activate all Tentacles once."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Slumber\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increases by 100. Each card played, <EmbryoFusionIconKeywords:Embryo Fusion> +10%; when HP is below 25%, the increase becomes 20%. This effect can trigger a maximum of 10 times per turn."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Realm Mastery> increases by 100. Each card played, <EmbryoFusionIconKeywords:Embryo Fusion> +10%; when HP is below 25%, the increase becomes 20%. This effect can trigger a maximum of 10 times per turn."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Surge\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "At the start of battle, all Awakeners gain 50 Aliemus. Put 2 copies of <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_20170_Desc = {
    Text = "At the start of battle, all Awakeners gain 50 Aliemus. Draw 2 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Signal Relay+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Anticipate or dread the moment it chimes."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "When picked up, randomly gain 1 Silver Relic, 1 Golden Relic, and 1 Cursed Relic."
  },
  RelicConfig_20171_Desc = {
    Text = "When picked up, randomly gain 1 Silver Relic, 1 Golden Relic, and 1 Cursed Relic."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Inverted View+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = [[
In the strange era, flowers are humanity's primary spectators.
Stay still; they prefer quiet exhibits.]]
  },
  RelicConfig_20172_BattleDesc = {
    Text = "When the number of Command Cards played in a turn reaches 3, gain 1 <DerivativeCardKeywords_4:\"Insight\">; at 6 cards, gain another <DerivativeCardKeywords_4:\"Insight\">; and when reaching 10 cards, you may select 2 cards from your deck to add to your hand at the start of next turn."
  },
  RelicConfig_20172_Desc = {
    Text = "When the number of Command Cards played in a turn reaches 3, gain 1 <DerivativeCardKeywords_4:\"Insight\">; at 6 cards, gain another <DerivativeCardKeywords_4:\"Insight\">; and when reaching 10 cards, you may select 2 cards from your deck to add to your hand at the start of next turn."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Echo\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Deal 50% more DMG to enemies with debuffs, and gain 100 Aliemus upon killing them."
  },
  RelicConfig_20173_Desc = {
    Text = "Deal 50% more DMG to enemies with debuffs, and gain 100 Aliemus upon killing them."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Hierophant's Staff+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Unsanctioned Piety"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Upon pickup, Team DMG Amplification x150%. At turn start, deal [Arg1] DMG to a random enemy. For each Posse used in this battle, increase the DMG dealt by [Arg2]. This DMG Boost enjoys Team DMG Amplification bonus."
  },
  RelicConfig_20174_Desc = {
    Text = "Upon pickup, Team DMG Amplification x150%. At turn start, deal [Arg1] DMG to a random enemy. For each Posse used in this battle, increase the DMG dealt by [Arg2]. This DMG Boost enjoys Team DMG Amplification bonus."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Lapse\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "The <WeaknessIconKeywords:Weakness> effect is increased by 8%, and the <VulnerabilityIconKeywords:Vulnerable> effect is increased by 25%. When applying <WeaknessIconKeywords:Weakness> or <VulnerabilityIconKeywords:Vulnerable>, temporarily steal [Arg1] <PowerIconKeywords:STR> from the target."
  },
  RelicConfig_20175_Desc = {
    Text = "The <WeaknessIconKeywords:Weakness> effect is increased by 8%, and the <VulnerabilityIconKeywords:Vulnerable> effect is increased by 25%. When applying <WeaknessIconKeywords:Weakness> or <VulnerabilityIconKeywords:Vulnerable>, temporarily steal [Arg1] <PowerIconKeywords:STR> from the target."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Faded Photograph+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "The blurry photo carries a blurry Memory, or perhaps—it's the incompleteness of Memory that leads to the photo's fading."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "At turn start, gain 2 Arithmetica for each enemy. When an enemy is killed by Active DMG, deal double excess DMG to other enemies as <BleedingIconKeywords:Bleed>."
  },
  RelicConfig_20176_Desc = {
    Text = "At turn start, gain 2 Arithmetica for each enemy. When an enemy is killed by Active DMG, deal double excess DMG to other enemies as <BleedingIconKeywords:Bleed>."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Mob Song+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Specifically designed to torment your ears."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Picking up this item doubles Death Resistance. After dealing Damage, it also applies <BleedingIconKeywords:Bleed> to the target equal to 50% of the Damage. Each time Death Resistance is triggered, all enemies immediately trigger 1 instance of Bleed."
  },
  RelicConfig_20177_Desc = {
    Text = "Picking up this item after death doubles Death Resistance. After dealing Damage, it also applies <BleedingIconKeywords:Bleed> to the target equal to 50% of the Damage. Each time Death Resistance is triggered, all enemies immediately trigger 1 instance of Bleed."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Revive\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Each time you deal 1 instance of Active DMG, gain 3 Aliemus and inflict [Arg1] stacks of <IntoxicationIconKeywords:Poison> to the Target. If the number of triggers reaches 25 within this battle, immediately inflict <IntoxicationIconKeywords:Poison> on all Enemy targets."
  },
  RelicConfig_20178_Desc = {
    Text = "Each time you deal 1 instance of Active DMG, gain 3 Aliemus and Inflict [Arg1] stacks of <IntoxicationIconKeywords:Poison> to the Target. If the number of triggers reaches 25 times within this battle, immediately Inflict <IntoxicationIconKeywords:Poison> on all Enemy targets."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Forgotten Loom+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "A kind mother mends the wounds of the heart."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Strike\" gains 3 Arithmetica and discards 1 random card; \"Defense\" draws 3 cards and loses 1 Arithmetica."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Strike\" gains 3 Arithmetica and discards 1 random card; \"Defense\" draws 3 cards and loses 1 Arithmetica."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Joyous Record+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = [[
A record of the famous violinist's final performance.
Since then, it has been able to summon flames.]]
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Every time Devour is triggered, gain 30 <EmbryoFusionIconKeywords:Embryo Fusion> and [Arg1] <PowerIconKeywords:STR>. If triggered a second time in the same turn, gain 1 Arithmetica and draw 1 card. If triggered a third time in the same turn, gain 2 Arithmetica and draw 2 cards."
  },
  RelicConfig_23688_Desc = {
    Text = "Every time Devour is triggered, gain 30 <EmbryoFusionIconKeywords:Embryo Fusion> and [Arg1] <PowerIconKeywords:STR>. If triggered a 2nd time in the same turn, gain 1 pt of Arithmetica and draw 1 card. If triggered a 3rd time in the same turn, gain 2 Arithmetica and draw 2 cards."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Backlash\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Picking up grants all Awakeners 30 Aliemus. Each release of Exalt increases the Count by 1. After releasing the Posse, gain [Arg1] Temporary Alert, [Arg2] Temporary <PowerIconKeywords:STR>, and all Awakeners gain 6 Aliemus, consuming all Count, with each Count point taking effect 1 additional time."
  },
  RelicConfig_23689_Desc = {
    Text = "Picking up grants all Awakeners 30 Aliemus. Each release of Exalt increases the Count by 1 point. After releasing the Posse, gain [Arg1] Temporary Alert, [Arg2] Temporary <PowerIconKeywords:STR>, and all Awakeners gain 6 Aliemus, consuming all Count, with each Count point taking effect 1 additional time."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Buildup\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "For each additional Arithmetica or each extra card drawn, steal [Arg1] <PowerIconKeywords:STR> from all enemies, gain 4% Temporary Crit. Rate, and the effect is doubled in Elite or Boss Battles. After the start of an Ultra Round, gain [Arg2] <PowerIconKeywords:STR> and increase Crit. DMG by 15%."
  },
  RelicConfig_23690_Desc = {
    Text = "For each additional Arithmetica or each extra card drawn, steal [Arg1] <PowerIconKeywords:STR> from all enemies, gain 4% Temporary Crit. Rate, and the effect is doubled in Elite or Boss Battles. After the start of an Ultra Round, gain [Arg2] <PowerIconKeywords:STR> and increase Crit. DMG by 15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Interval\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "For every 5 instances of DMG dealt, restore [Arg1] HP. For each HP lost, Tentacle DMG +[Arg2]. If more than [Arg3] HP is lost, trigger all Tentacles once."
  },
  RelicConfig_23691_Desc = {
    Text = "Restore [Arg1] HP for every 5 hits. Increase Tentacle DMG by +[Arg2] for each lost HP. If HP loss exceeds 10% of Max HP, trigger all Tentacles once."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Tides\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Temporary <PowerIconKeywords:STR> and [Arg2] Temporary Tentacle DMG, with a maximum of 12 triggers per turn. If 4 instances of DMG are dealt in a single turn, apply 1 stack of Vulnerable to all enemies and gain [Arg3] Shield. If 8 instances of DMG are dealt in the same turn, apply 1 stack of Weakness to all enemies and restore [Arg3] HP."
  },
  RelicConfig_35135_Desc = {
    Text = "For each instance of DMG dealt, gain [Arg1] Temporary <PowerIconKeywords:STR> and [Arg2] Temporary Tentacle DMG, with a maximum of 12 triggers per turn. If 4 instances of DMG are dealt in a single turn, apply 1 stack of Vulnerable to all enemies and gain [Arg3] Shield. If 8 instances of DMG are dealt in the same turn, apply 1 stack of Weakness to all enemies and restore [Arg3] HP."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Trance\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"Strike\" DMG and \"Defense\" Shield Generation by 30%. If you play 4 or more \"Strike\" and \"Defense\" cards in one turn, draw 2 cards and gain 1 Arithmetica at the start of next turn."
  },
  RelicConfig_35136_Desc = {
    Text = "\"Strike\"Damage and \"Defense\"Shield increase by 30%. If you play 4 or more \"Strike\" and \"Defense\" cards in one turn, draw 2 cards and gain 1 Arithmetica at the start of next turn."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Stubborn\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Each card played grants [Arg1] Temporary <PowerIconKeywords:STR> and recovers [Arg2] HP. After dealing Active DMG, remove [Arg2] <PowerIconKeywords:STR> gained from this Relic. The Awakener gains 30 Aliemus for each enemy killed."
  },
  RelicConfig_35137_Desc = {
    Text = "Each card played grants [Arg1] Temporary <PowerIconKeywords:STR> and recovers [Arg2] HP. After dealing Active DMG, remove [Arg2] <PowerIconKeywords:STR> gained from this Relic. The Awakener gains 30 Aliemus for each enemy killed."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Charge\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "After releasing an Exalt, apply [Arg1] Poison to a random enemy. For each Command Card played, gain [Arg2] Temporary Counter. At the end of every 4 turns, deal DMG to all enemies equal to the sum of their Poison stacks and your Counter stacks."
  },
  RelicConfig_35138_Desc = {
    Text = "After releasing an Exalt, apply [Arg1] Poison to a random enemy. For each Command Card played, gain [Arg2] Temporary Counter. Every 4 turns, deal DMG to all enemies equal to the sum of their Poison stacks and your Counter stacks."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Proliferate\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Upon pickup, increase the team's DMG Amplification by 30%. Every 4th instance of DMG dealt will be a Critical Hit, and Crit. DMG is increased by 50%. If the hit results in a kill, gain 5 Black Sigil."
  },
  RelicConfig_35139_Desc = {
    Text = "Upon pickup, increase the team's DMG Amplification by 30%. Every 4th instance of DMG dealt will be a Critical Hit, and Crit. DMG is increased by 50%. If the hit results in a kill, gain 5 Black Sigil."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"End\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "After Exalt, draw 1 card. For each discarded card, all Awakeners gain 3 Aliemus, up to 15 per turn."
  },
  RelicConfig_36823_Desc = {
    Text = "After Exalt, draw 1 card. For each discarded card, all Awakeners gain 3 Aliemus, up to 15 per turn."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Reciprocate\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Each time you consume Arithmetica, draw 1 card, up to 5 times per turn. Whenever your deck resets, gain 2 Arithmetica."
  },
  RelicConfig_36824_Desc = {
    Text = "Draw 1 card each time Arithmetica is spent, up to 5 times per turn. Gain 2 Arithmetica whenever the deck is reshuffled."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sleepless\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Shuffle 1 <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile for every 4 instances of DMG dealt, up to 3 times per turn. After an Exalt, play and consume all <DerivativeCardKeywords_4:\"Insight\"> in the Draw Pile."
  },
  RelicConfig_39302_Desc = {
    Text = "Shuffle 1 <DerivativeCardKeywords_4:\"Insight\"> into the Draw Pile for every 4 hits, up to 3 times per turn. After an Exalt, play and exhaust all <DerivativeCardKeywords_4:\"Insight\"> in the Draw Pile."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Illusion\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "When the current Arithmetica is odd, it gains an additional [Arg2] Temporary Alert. When the current Arithmetica is even, it gains an additional [Arg1] Temporary <PowerIconKeywords:STR> and [Arg3] Temporary Tentacle DMG. Each Golden Relic increases the effect of this Relic by 50%, and each Cursed Relic increases it by 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "When the current Arithmetica is odd, it gains an additional [Arg2] Temporary Alert. When the current Arithmetica is even, it gains an additional [Arg1] Temporary <PowerIconKeywords:STR> and [Arg3] Temporary Tentacle DMG. Each Golden Relic increases the effect of this Relic by 50%, and each Cursed Relic increases it by 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Startle\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "At turn start, all Awakeners gain 20 Aliemus. When picked up, Max HP is reduced by 50%."
  },
  RelicConfig_44192_Desc = {
    Text = "All Awakeners gain 20 Aliemus at turn start. Max HP is reduced by 50% upon pickup."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Sinful: Nightmare Manifest>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "The indulgent deep sleep is desire, which devours everything before you realize it."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "All Awakeners gain 25 Aliemus at turn start. Max HP is tripled upon pickup."
  },
  RelicConfig_44300_Desc = {
    Text = "All Awakeners gain 25 Aliemus at turn start. Max HP x3 upon pickup."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Blessed: Nightmare Manifest>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Fear not, hesitate not. This is but a fleeting dream; the light of the All-Father still shines upon you."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "After the battle, gain 100 Black Sigils and 2 Symptom Cards."
  },
  RelicConfig_44592_Desc = {
    Text = "After the battle, gain 100 Black Sigils and 2 Symptom Cards."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Sinful: Jade Imprint>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "The ancient sins are engraved here."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Upon pickup, transform into 1 random Sinful Relic (excluding itself) and gain 75 Black Sigil."
  },
  RelicConfig_44593_Desc = {
    Text = "Upon pickup, transform into a random Sinful Relic (excluding itself) and gain 75 Black Sigil."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Sinful: Cursed Stele>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Listen, someone is calling from within."
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Every 2 turns, double the Active and Tentacle DMG all enemies receive in that turn. However, after releasing Exalt in that turn, seal all Awakeners for 1 turn and make yourself Vulnerable."
  },
  RelicConfig_44594_Desc = {
    Text = "Every 2 turns, double the Active and Tentacle DMG all enemies receive in that turn. However, after releasing Exalt in that turn, seal all Awakeners for 1 turn and make yourself Vulnerable."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Sinful: Pathwalker's Remains>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = [[
A sacred part.
Separated from the torso, it has been tainted by sin.]]
  },
  RelicConfig_44597_BattleDesc = {
    Text = "For every instance of Active DMG dealt, apply [Arg1] stack(s) of <BleedingIconKeywords:Bleed> to self and [Arg2] stack(s) of <BleedingIconKeywords:Bleed> to the target."
  },
  RelicConfig_44597_Desc = {
    Text = "For every Active DMG instance, Inflict [Arg1] stacks of <BleedingIconKeywords:Bleed> to self and [Arg2] stacks of <BleedingIconKeywords:Bleed> to the DMG target."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Sinful: Swarm Mind>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Entwine, Symbiosis, Swarm; Fear, Unknown, Control."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "After releasing Exalt, lose 12% of Current HP and steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, additionally steal [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_44598_Desc = {
    Text = "After releasing exalt, lose 12% of current HP, steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Sinful: Omen Ritual Bird>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "The pitiful creature, killed by greed, lets out a piercing cry from its withered chest."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Increase hand limit by 5 and draw 6 cards at the start of the battle. At turn end, discard all Symptom Cards and State cards in your hand, retain other cards, but draw 2 fewer cards each turn."
  },
  RelicConfig_44603_Desc = {
    Text = "Increase hand limit by 5 and draw 6 cards at the start of the battle. At turn end, discard all Symptom Cards and State Cards in your hand, keeping other cards, but draw 2 fewer cards each turn."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Sinful: Mind Engraving>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "The greedy treat others as objects, deriving pleasure from others' suffering."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Picking up will permanently cause you to lose [Arg1] <PowerIconKeywords:STR>. Whenever you deal Damage, heal for [Arg2] HP, with a maximum of 6 triggers per turn."
  },
  RelicConfig_44608_Desc = {
    Text = "Picking up will cause you to permanently lose [Arg1] <PowerIconKeywords:STR>. Whenever you deal Damage, heal for [Arg2] HP, with a maximum of 6 triggers per turn."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Sinful: Lamprey Kiss>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Its kiss will make you sink—though it might be you who sinks."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Max Arithmetica increases by 3. Each time the deck is reset, add 2 <DerivativeCardKeywords_9:Stagger> to the Draw Pile."
  },
  RelicConfig_44609_Desc = {
    Text = "Max Arithmetica +3. Each time the deck is reset, add 2 <DerivativeCardKeywords_9:\"Stagger\"> to the Draw Pile."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Sinful: Black Candle>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Burn sanity, fall into madness."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Crit. Rate and Crit. DMG increased by 50%. At turn start, <FragileIconKeywords:Fragile> affects self for 1 turn."
  },
  RelicConfig_44610_Desc = {
    Text = "Crit. Rate and Crit. DMG increased by 50%, at turn start, <FragileIconKeywords:Fragile> affects self for 1 turn."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Sinful: Eerie Hook>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Claws Twisted by Desire."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Max Arithmetica increases by 4. Add 4 copies of <DerivativeCardKeywords_4:Insight> to the Draw Pile each time you reset your deck."
  },
  RelicConfig_44654_Desc = {
    Text = "Max Arithmetica +4. Each time the deck is reset, add 4 <DerivativeCardKeywords_4:\"Insight\"> to the Draw Pile."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Blessed: Black Candle>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Burning desire, gain redemption."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Relic Capacity +[Arg1], \"D-Mark\" refresh attempts +1. After the battle, gain 125 Black Sigil. When picking up, you can choose to delete up to 6 Symptom Cards."
  },
  RelicConfig_44656_Desc = {
    Text = "Relic Capacity +[Arg1], refresh count in \"D-Mark\" +1. After the battle, gain 125 Black Sigil. When picking up, you can choose to delete up to 6 Symptom Cards."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Blessed: Jade Imprint>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "The All-Father's redemption wiped away the pain."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "After releasing Exalt, gain [Arg1] Temporary STR and steal [Arg1] Temporary <PowerIconKeywords:STR> from all enemies. If there is only 1 enemy, steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_44658_Desc = {
    Text = "After releasing Exalt, Obtain [Arg1] Temporary STR and Steal [Arg1] Temporary <PowerIconKeywords:STR> from All enemies. If there is only 1 enemy, Steal an additional [Arg2] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Blessed: Omen Ritual Bird>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "The light of forgiveness envelops the remnants of greed, and the dead birds sing their final songs."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "For each instance of Active DMG dealt, restore [Arg1] HP and apply [Arg2] stacks of <BleedingIconKeywords:Bleed> to the target."
  },
  RelicConfig_44659_Desc = {
    Text = "For each Active DMG dealt, restore [Arg1] HP and Inflict [Arg2] stacks of <BleedingIconKeywords:Bleed> to the target."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Blessed: Swarm Mind>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Entwine, Symbiosis, Swarm; Unity, Coexistence, Shelter."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Increase hand limit by 5 and replenish hand to the limit at the start of the battle. Draw 1 additional card at turn start, and discard all Symptom Cards and State cards at turn end while retaining other cards."
  },
  RelicConfig_44660_Desc = {
    Text = "Increase hand limit by 5 and replenish hand to the limit at the start of the battle. Draw 1 extra card at turn start, and discard all Symptom Cards and State Cards at turn end while keeping other cards."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Blessed: Mind Engraving>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "The greedy carve their mistakes into their hearts and dedicate themselves to atoning for their past."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Every 2 turns, double the Active and Tentacle DMG all enemies receive in that turn. For each Exalt used in that turn, randomly dispel 1 debuff."
  },
  RelicConfig_44662_Desc = {
    Text = "Every 2 turns, double the Active and Tentacle DMG all enemies receive in that turn. For each Exalt used in that turn, randomly dispel 1 debuff."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Blessed: Pathwalker's Remains>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = [[
A sacred part.
Even though it has separated from the body, its footprints have spread across the world.]]
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Crit. Rate increased by 50%, Crit. DMG increased by 100%."
  },
  RelicConfig_44663_Desc = {
    Text = "Crit. Rate increased by 50%, Crit. DMG increased by 100%."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Blessed: Eerie Hook>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "All desires have been relinquished."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Obtain [Arg1] <PowerIconKeywords:STR> permanently after picking it up. Whenever DMG is dealt, heal [Arg2] HP, with a maximum of 6 triggers per turn."
  },
  RelicConfig_44664_Desc = {
    Text = "Upon picking it up, permanently Obtain [Arg1] <PowerIconKeywords:STR>. Whenever DMG is dealt, heal for [Arg2] HP, with a maximum of 6 triggers per turn."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Blessed: Lamprey Kiss>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Reject this kiss of damnation, for the All-Father's embrace is warmer than any darkness."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Strike\" and \"Defense\" gain an additional 50 Keyflare. Each time you play a card with an Arithmetica Cost of 2 or more, draw a card with an Arithmetica Cost of 1 and reduce its cost to 0, up to 3 times per turn."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Attack\" and \"Defense\" gain an additional 50 Keyflare. Each time you play a card with an Arithmetica Cost of 2 or more, draw a card with an Arithmetica Cost of 1 and reduce its cost to 0, up to 3 times per turn."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Twins\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "At the start of battle, shuffle all Awakeners' <ExaltIconKeywords:Rouse > into the deck. Starting from the 6th turn, Thais will provide combat support every turn."
  },
  RelicConfig_50338_Desc = {
    Text = "At the start of battle, shuffle all Awakeners'<ExaltIconKeywords:Rouse> into the deck. Starting from the 6th turn, Thais will provide combat support every turn."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Enchant\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "He said, \"Do not be afraid.\""
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Upon pickup, choose a card to permanently set its Arithmetica Cost to 1."
  },
  RelicConfig_50385_Desc = {
    Text = "Upon pickup, choose a card to permanently reduce its Arithmetica Cost to 1."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Withered Pupil☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Having lost the desert's most precious water, her eyes have withered."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "At the start of the first turn of battle, add <DerivativeCardKeywords_46:Prion Virus> to your hand; on the 3rd turn, add <DerivativeCardKeywords_49:Gluttonous Attack> to your hand; after triggering Death Resistance, add <DerivativeCardKeywords_52:Cocoon of Revival> to your hand."
  },
  RelicConfig_50487_Desc = {
    Text = "At the start of the first turn of battle, add <DerivativeCardKeywords_46:\"Prion Virus\"> to your hand; in the 3rd turn, add <DerivativeCardKeywords_49:\"Gluttonous Attack\"> to your hand; after triggering Death Resistance, add <DerivativeCardKeywords_52:\"Cocoon of Revival\"> to your hand."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Benediction\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "At turn end: The Awakener with the lowest Aliemus gains 35 Aliemus. If remaining HP is ≥50%, gain [Arg1] <PowerIconKeywords:STR>. If remaining HP is ＜50%, restore [Arg2] HP."
  },
  RelicConfig_50488_Desc = {
    Text = "At turn end: The Awakener with the lowest Aliemus gains 35 Aliemus. If current HP is at or above 50%, gain [Arg1] <PowerIconKeywords:STR>. If current HP is below 50%, restore [Arg2] HP."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Balance\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Crit. Rate and Crit. DMG increase by 100%. For each instance of DMG dealt, all Awakeners' Crit. Rate and Crit. DMG decrease by 10%, up to a maximum reduction of 50%. For each instance of Damage dealt, the Poison and Counter DMG inflicted this turn increase by 10%, up to a maximum increase of 50%."
  },
  RelicConfig_50489_Desc = {
    Text = "Crit. Rate and Crit. DMG +100%. For each instance of DMG/Tentacle DMG dealt this turn, all Awakeners' Crit. Rate and Crit. DMG -10%, up to 50%. Poison and Counter DMG +10%, up to 50%."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Surge\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Each time a Command Card belonging to a different Awakener than the last one played is played, that Awakener gains 3 Aliemus and accumulates 1 stack of \"Vitality\". Upon accumulating 10 stacks, all \"Vitality\" is cleared, and each Awakener receives a random Command Card with Arithmetica Cost reduced by 1 and \"Exhaust\" placed in hand. This effect can activate a maximum of 1 time per Turn."
  },
  RelicConfig_51686_Desc = {
    Text = "Each time a Command Card belonging to a different Awakener than the last one played is played, that Awakener gains 3 Aliemus and accumulates 1 stack of \"Vitality\". Upon accumulating 10 stacks, all \"Vitality\" is cleared, and one random Command Card with \"Exhaust\" and Arithmetica Cost reduced by 1 is placed in hand for each Awakener. This effect can activate a maximum of 1 time per turn."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Evolution\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "After playing a Command Card that is not \"Strike\" or \"Defense\", if the card is not a Derived Card, the corresponding Awakener gains 15 Aliemus, triggering up to 5 times per Turn. On the first trigger of each Turn, the played card will also be returned to your hand."
  },
  RelicConfig_51687_Desc = {
    Text = "After playing a Command Card that is not \"Strike\" or \"Defense\", if the card is not a Derived Card, the corresponding Awakener gains 15 Aliemus, triggering up to 5 times per turn. On the first trigger of each turn, the played card will also be returned to your hand."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Projection\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "When picked up, add \"Retain\" to all Command Cards. At turn end, if the number of cards in hand is greater than or equal to 5, reduce the Arithmetica Cost of 3 random cards in hand by 1; otherwise, draw 3 cards."
  },
  RelicConfig_51688_Desc = {
    Text = "When picked up, add \"Retain\" to all Command Cards. At turn end, if the number of cards in hand is greater than or equal to 5, reduce the Arithmetica Cost of 3 random cards in hand by 1; otherwise, draw 3 cards."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Breeding\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "At the start of the battle, shuffle 3 random Symptom Cards into your deck. At turn start, draw 1 card. Playing each Symptom Card grants 2 Arithmetica. Discarding each Symptom Card grants all Awakeners 5 Aliemus, up to 5 times per turn."
  },
  RelicConfig_51689_Desc = {
    Text = "At the start of the battle, shuffle 3 random Symptom Cards into your deck. At turn start, draw 1 card. Playing each Symptom Card grants 2 Arithmetica. Discarding each Symptom Card grants all Awakeners 5 Aliemus, up to 5 times per turn."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Plague\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Simulation Battle Standard Relic Set of 7"
  },
  RelicConfig_55847_Desc = {
    Text = "Simulation Battle Standard Relic Set of 7"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Simulation Relic☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = [[
In the strange era, flowers are humanity's primary spectators.
Stay still; they prefer quiet exhibits.]]
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Gain [Arg1] stack of \"Ink\" after battle. When \"Ink\" reaches 2 stacks, Exhaust, then randomly place 1 \"Imagery\" card into the deck."
  },
  RelicConfig_55874_Desc = {
    Text = "Gain [Arg1] stack of \"Ink\" after battle. When \"Ink\" reaches 2 stacks, consume it to randomly place 1 \"Imagery\" card into the deck."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "The ancient sins are engraved here."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Hand Limit +2, draw 1 card at the start of your turn. After the battle, gain [Arg1] layer(s) of \"Ink,\" and when \"Ink\" reaches 2 stacks, it will be consumed to choose 1 \"Imagery\" to place into your deck."
  },
  RelicConfig_56355_Desc = {
    Text = "Hand Limit +2, draw 1 card at turn start. After the battle, gain [Arg1] stack(s) of \"Ink\", and when \"Ink\" reaches 2 stacks, it will be exhausted to choose 1 \"Image\" to place into the deck."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "The ancient sins are engraved here."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Gain [Arg1] stack of \"Ink\" after battle. When \"Ink\" reaches 2 stacks, Exhaust, then choose 1 \"Imagery\" card to place into the deck."
  },
  RelicConfig_56356_Desc = {
    Text = "Gain [Arg1] stack of \"Ink\" after battle. When \"Ink\" reaches 2 stacks, consume it to choose 1 \"Imagery\" card to place into the deck."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "The ancient sins are engraved here."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Start with 2 stacks of the Divine Mother's Power. After the third turn, at turn start, choose to either consume the Divine Mother's Power for different effects or restore it. If you take Fatal DMG, resurrect and consume all stacks of the Divine Mother's Power, with each stack restoring 10% HP. This effect can only trigger once."
  },
  RelicConfig_57667_Desc = {
    Text = "Start with 2 stacks of the Divine Mother's Power; after the third turn, at turn start, choose to either consume the Divine Mother's Powerr for different effects or restore it. If Fatal DMG is taken, resurrect and consume all stacks of the Divine Mother's Power, with each stack restoring 10% HP. This effect can only trigger once."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Divine Mother's Protection>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "All Awakener's Crit. Rate is increased by 15%. The final result of Ryker and dice random effects is increased by 1."
  },
  RelicConfig_57732_Desc = {
    Text = "All Awakeners' Crit. Rate is increased by 15%. The final result of Ryker and dice random effects is increased by 1."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Bespoke Lucky Windcoat>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "It will raise a thick barrier to keep out the winds, rains, and misfortunes."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "At turn start and when Ryker or the dice's random effect is triggered, gain 100 Keyflare and 4% Crit. DMG, up to 50% Crit. DMG. Removed at the end of the battle."
  },
  RelicConfig_57733_Desc = {
    Text = "At the start of each round and when Ryker or the dice's random effect is triggered, gain 100 Keyflare and 4% Crit. DMG, up to 50% Crit. DMG. Removed at the end of the battle."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Premium Mouth Button>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = [[
The Big Mouth Button loves everything round, such as the moon, chips, and fresh eyeballs.
It will spew black mist on a full moon night for unknown reasons.]]
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Whenever you Release the Posse, put 1 \"Shining Octahedron Dice\" into hand."
  },
  RelicConfig_57734_Desc = {
    Text = "Whenever a Posse is released, put 1 \"Shining Octahedron Dice\" into hand."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Shining Octahedron Dice>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = [[
What shines is not only the surface but also the unyielding heart.
Gaze at it for more than five seconds, and you will summon @2.]]
  },
  RelicConfig_57735_BattleDesc = {
    Text = "At turn start and when Ryker or the dice's random effect is triggered, gain 50 Keyflare and 2% Crit. DMG, up to 30% Crit. DMG. Removed at the end of the battle."
  },
  RelicConfig_57735_Desc = {
    Text = "At the start of each round and when Ryker or the dice's random effect is triggered, gain 50 Keyflare and 2% Crit. DMG, up to 30% Crit. DMG. Removed at the end of the battle."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Big Mouth Button>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = [[
The Big Mouth Button loves everything round, such as the moon, chips, and fresh eyeballs.
It will spew black mist on a full moon night for unknown reasons.]]
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Whenever you Release the Posse, put 1 \"Octahedron Dice\" into hand."
  },
  RelicConfig_57736_Desc = {
    Text = "Whenever a Posse is released, put 1 \"Octahedron Dice\" into hand."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Octahedron Dice>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = [[
What shines is not only the surface but also the unyielding heart.
Gaze at it for more than five seconds, and you will summon @2.]]
  },
  RelicConfig_57737_BattleDesc = {
    Text = "All Awakeners' Crit. Rate is increased by 10%. The random effects of Ryker and the dice cannot be the lowest value."
  },
  RelicConfig_57737_Desc = {
    Text = "All Awakeners' Crit. Rate is increased by 10%. The random effects of Ryker and dice cannot be the lowest value."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Lucky Windcoat>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "It will raise a thick barrier to keep out the winds, rains, and misfortunes."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, gain a Relic at turn start: \"Crimson Brooch, Filigree Agate, SOS Signal, Omen Ritual Bird, Chrono Pendulum: Trance\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, gain a Relic at turn start, including \"Crimson Brooch, Filigree Agate, SOS Signal, Omen Ritual Bird, Chrono Pendulum: Trance\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Relic Capacity +1. Obtain a relic at the start of each of the first five turns in battle: \"Barbed Trident, Foreign Stamp Album, Arcana Archive, Mind Engraving, Chrono Pendulum: Charge\"."
  },
  RelicConfig_57792_Desc = {
    Text = "Relic Capacity +1. Gain a relic at the start of each of the first five turns in battle: \"Barbed Trident, Foreign Stamp Album, Arcana Archive, Mind Engraving, Chrono Pendulum: Charge\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, at turn start, gain a relic: \"Radium Jawbone\", \"Uncanny Salve\", \"Forgotten Loom\", \"Other Tongue\", and \"Chrono Pendulum: Surge\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, at the beginning of each turn, gain a relic, including \"Radium Jawbone, Uncanny Salve, Forgotten Loom, Other Tongue, Chrono Pendulum: Surge\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, at turn start, gain a relic, including \"Nettle Vest, Deceased's Chrono, Forgotten Prelude, Salvific Limb, Chrono Pendulum: Proliferate\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, at the beginning of each turn, gain a relic, including \"Nettle Vest, Deceased's Chrono, Forgotten Prelude, Salvific Limb, Chrono Pendulum: Proliferate\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, at turn start, you will gain a relic: \"Rusty Lancet\", \"Hemostatic Clamp\", \"Antique Puzzle\", \"Swarm Mind\", and \"Chrono Pendulum: Twins\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, at turn start, gain a relic, including \"Rusty Lancet, Hemostatic Clamp, Antique Puzzle, Swarm Mind, Chrono Pendulum: Twins\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, gain a Relic at turn start, including \"Chronometric Device, Laurel Cufflinks, Veil of the Nameless Deity, Nightmare Manifest, Chrono Pendulum: Balance\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, gain a Relic at turn start, including \"Chronometric Device, Laurel Cufflinks, Veil of the Nameless Deity, Nightmare Manifest, Chrono Pendulum: Balance\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Relic Capacity +1. In the first five turns after the battle begins, gain a relic at turn start, including \"Brand-New Wallet, Mythag Insignia, Stellar Brew, Lamprey Kiss, Chrono Pendulum: Eye\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Relic Capacity +1. In the first five turns of battle, gain a relic at turn start, including \"Brand-New Wallet, Mythag Insignia, Stellar Brew, Lamprey Kiss, Chrono Pendulum: Eye\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Sunken Treasure\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "It is said that Lemuria fell into these waters. Who can resist the temptation to explore the secrets of shipwreck treasures?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. For the next 5 turns, at turn start, gain a Relic from \"Rusty Lancet, Modern Axle, Our Home, Eerie Hook, Chrono Pendulum: Trance\"."
  },
  RelicConfig_58872_Desc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. For the next 5 rounds, at the start of each round, gain a Relic from \"Rusty Lancet, Modern Axle, Our Home, Eerie Hook, Chrono Pendulum: Trance\"."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Treasure α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by +1 and Rouse all Awakener. For the next 5 turns, at turn start, gain a Relic from \"Honeyed Ink, Mute Jukebox, Stellar Brew, Trickster's Hat, Chrono Pendulum: Surge\"."
  },
  RelicConfig_58873_Desc = {
    Text = "At the start of the battle, Max Arithmetica +1 and Rouse all Awakeners. In the next 5 turns, gain 1 Relic at turn start: Honeyed Ink, Mute Jukebox, Stellar Brew, Trickster's Hat, Chrono Pendulum: Surge."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Treasure β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "At turn start, gain 1 \"Ryker's Lucky Dice,\" increasing the die roll result by +1. At turn start and after each die roll, all Awakeners gain 4% Crit. DMG, up to 100%."
  },
  RelicConfig_59118_Desc = {
    Text = "At turn start, gain 1 \"Ryker's Lucky Dice,\" increasing the die roll result by +1. At turn start and after each die roll, all Awakeners gain 4% Crit. DMG, up to 100%."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Chaotic Gift\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "The ancient sins are engraved here."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Simulation Battle Standard Relic Set of 7"
  },
  RelicConfig_59687_Desc = {
    Text = "Simulation Battle Standard Relic Set of 7"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Simulation Relic☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = [[
In the strange era, flowers are humanity's primary spectators.
Stay still; they prefer quiet exhibits.]]
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Max Arithmetica +1. Draw an additional card at the start of turn and gain 1 \"Symphony of Harmony\". If 3 Command Cards with the same Arithmetica are played consecutively, all Awakeners gain 20 Aliemus. Reset at the start of turn and after triggering."
  },
  RelicConfig_60723_Desc = {
    Text = "Max Arithmetica increases by 1. Draw an additional card at turn start and gain 1 \"Symphony of Harmony\". If 3 Command Cards with the same Arithmetica are played consecutively, all Awakeners gain 20 Aliemus. The reset count is reset at turn start and after triggering."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Conductor's Baton>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = [[
A slender conductor's baton, yet possesses strength greater than a crowbar.

 Conducting notes, conducting soul, conducting fate.]]
  },
  RelicConfig_60724_BattleDesc = {
    Text = "At the start of the battle, gain \"Vulnerable\" Orison and \"Burst\" Orison along with their Adv.versions, and choose an Orison to place on a Card."
  },
  RelicConfig_60724_Desc = {
    Text = "At the start of the battle, gain \"Vulnerable\" Orison and \"Burst\" Orison and their Adv. Orisons, choose an Orison on a Card."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60725_BattleDesc = {
    Text = "At the start of the battle, gain the \"Aliemus\" Orison and \"Catalyst\" Orison along with their Adv. Orisons, and choose an Orison for a card."
  },
  RelicConfig_60725_Desc = {
    Text = "At the start of the battle, gain the \"Aliemus\" Orison and \"Catalyst\" Orison along with their Adv. Orisons, and choose an Orison on a card."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60726_BattleDesc = {
    Text = "At the start of the battle, gain the \"Weakness\" Orison and \"Computation\" Orison along with their Adv. Orisons, and choose an Orison for a card."
  },
  RelicConfig_60726_Desc = {
    Text = "At the start of the battle, gain the \"Weakness\" Orison and \"Computation\" Orison along with their Adv. Orisons to place on selected cards."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60727_BattleDesc = {
    Text = "At the start of the battle, gain \"Bastion\" Orison and \"Finesse\" Orison and their Adv. Orisons, choose an Orison on a Card."
  },
  RelicConfig_60727_Desc = {
    Text = "At the start of the battle, gain \"Bastion\" Orison and \"Finesse\" Orison and their Adv. Orisons, and choose an Orison on a Card."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60728_BattleDesc = {
    Text = "At the start of the battle, gain \"Birth\" Orison and \"Echo\" Orison along with their Adv. Orisons, and choose an Orison on a card."
  },
  RelicConfig_60728_Desc = {
    Text = "At the start of the battle, gain \"Birth\" Orison and \"Echo\" Orison and their Adv. Orisons, choose an Orison on a card."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key your path, Mythag's Keeper.]]
  },
  RelicConfig_60729_BattleDesc = {
    Text = "At the start of the battle, gain the \"Finesse\" Orison and \"Insight\" Orison along with their Adv. Orisons, and choose an Orison to place on a card."
  },
  RelicConfig_60729_Desc = {
    Text = "At the start of the battle, gain the \"Finesse\" Orison and \"Insight\" Orison along with their Adv. Orisons, and choose an Orison on a card."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60730_BattleDesc = {
    Text = "At the start of the battle, gain the \"Might\" Orison and the \"Drain\" Orison as well as their Adv. Orisons. Choose an Orison on a card."
  },
  RelicConfig_60730_Desc = {
    Text = "At the start of the battle, gain the \"Might\" Orison and \"Drain\" Orison as well as their Adv. Orisons, and choose an Orison on a card."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60731_BattleDesc = {
    Text = "At the start of the battle, gain 2 \"Ensemble\" Orisons and their Adv. Orison, and choose an Orison for a card."
  },
  RelicConfig_60731_Desc = {
    Text = "At the start of the battle, gain 2 \"Ensemble\" Orisons and their Adv. Orison, and choose an Orison on a card."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_60732_BattleDesc = {
    Text = "At the start of the battle, gain the \"Computation\" Orison and the \"Mirror\" Orison along with their Adv. Orisons, and choose an Orison on a card."
  },
  RelicConfig_60732_Desc = {
    Text = "At the start of the battle, gain the \"Computation\", \"Mirror\" and their Adv. Orisons to place on selected cards."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Principal's Message\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's Keeper.]]
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Start with [Arg1] Expedition Team members. At the beginning of the battle, shuffle 5 <DerivativeCardKeywords_73:Suspicion> into the deck."
  },
  RelicConfig_65376_Desc = {
    Text = "Start with [Arg1] Expedition Team members. At the beginning of the battle, shuffle 5 <DerivativeCardKeywords_73:Suspicion> into the deck."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Expedition Team>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = [[
The words of the founder of Mythag linger in your ears.

May the Silver Key light your path, Mythag's keeper.]]
  },
  RelicConfig_65406_BattleDesc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_71:Radiance of Humanity>.
<D05EX_Relic:All your efforts are worthwhile; you saved almost the entirety of the research team, and the survivors are sincerely grateful to you.>]]
  },
  RelicConfig_65406_Desc = {
    Text = [[
At the beginning of the turn, gain [Arg1] <DerivativeCardKeywords_71:"Radiance of Humanity">.
<D05EX_Relic:All your efforts are worthwhile; you saved almost the entirety of the research team, and the survivors are sincerely grateful to you.>]]
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Medal of Rescue: Platinum>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Your efforts were worthwhile; you saved almost the entirety of the research team. The survivors are deeply grateful to you."
  },
  RelicConfig_65407_BattleDesc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_72:"Brilliance of Humanity">.
<D05EX_Relic:You created an incredible miracle; everyone survived after the disaster, and you are hailed as a great hero. Your legend will soon spread throughout the snow mountain.>]]
  },
  RelicConfig_65407_Desc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_72:"Brilliance of Humanity">.
<D05EX_Relic:You created an incredible miracle; everyone survived after the disaster, and you are hailed as a great hero. Your legend will soon spread throughout the snow mountain.>]]
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Medal of Rescue: Diamond>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "You've performed an incredible miracle; everyone survived the disaster. You're a great hero, and your legend may soon spread around the snow mountain."
  },
  RelicConfig_65408_BattleDesc = {
    Text = [[
At the start of the Turn, gain [Arg1] <DerivativeCardKeywords_68:"Glow of Humanity">. 
<D05EX_Relic:In order to escape the snow mountain, you chose a strategy prioritizing efficiency and watched as people died one by one. The survivors' gaze toward you held more fear than gratitude.>]]
  },
  RelicConfig_65408_Desc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_68:"Glow of Humanity">.
<D05EX_Relic:To escape the snow mountain, you adopted a strategy prioritizing efficiency, watching people perish one by one. The survivors' eyes held more fear than gratitude.>]]
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Medal of Rescue: Bronze>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "To leave the snow mountain, you adopted a strategy prioritizing efficiency, watching as people fell one by one. The survivors regarded you with more fear than gratitude."
  },
  RelicConfig_65409_BattleDesc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_69:"Flicker of Humanity">.
<D05EX_Relic:You may have tried your best. Although half of the people perished, you at least saved the other half. After all, sacrifice is inevitable.>]]
  },
  RelicConfig_65409_Desc = {
    Text = [[
At the beginning of the turn, gain [Arg1] <DerivativeCardKeywords_69:"Flicker of Humanity">.
<D05EX_Relic:You may have tried your best. Although half of the people perished, at least you saved the other half. After all, sacrifices are inevitable.>]]
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Medal of Rescue: Silver>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "You did your best. Though half of them perished, you managed to save the other half. After all, sacrifices are inevitable."
  },
  RelicConfig_65410_BattleDesc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_70:"Humanity">.
<D05EX_Relic:You saved most of the people, rewriting their tragic fates. You did your best, didn't you?>]]
  },
  RelicConfig_65410_Desc = {
    Text = [[
At turn start, gain [Arg1] <DerivativeCardKeywords_70:"Luster of Humanity">.
<D05EX_Relic:You saved most of the people, rewriting their tragic fates. You did your best, didn't you?>]]
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Medal of Rescue: Gold>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "You saved most of the people and rewrote their tragic fates. You did your best, didn't you?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = [[
At the start of the battle, shuffle in 3 random "Symptoms". When playing "Symptoms", gain [Arg1] STR.
<D05EX_Relic:With your help, no one from the Expedition Team survived, and you coldly secured the maximum benefit for yourself. But was it all really worth it?>]]
  },
  RelicConfig_65456_Desc = {
    Text = [[

At the beginning of the battle, shuffle in 3 random "Symptoms". When playing "Symptoms", gain [Arg1] STR.
<D05EX_Relic:With your help, no one from the Expedition Team survived, and you indifferently gained the greatest benefit for yourself. But was it all really worth it?>]]
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Lone Wolf's Insignia>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "With your help, no one from the Expedition Team survived. You secured the greatest benefit for yourself, but was it truly worth it?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. For the next 5 turns, gain one Relic at turn start: \"Signal Relay, Rite of Spring, Hierophant's Staff, Omen Ritual Bird, Chrono Pendulum: Projection\"."
  },
  RelicConfig_65569_Desc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. For the next 5 turns, gain one Relic at turn start: \"Signal Relay, Rite of Spring, Hierophant's Staff, Omen Ritual Bird, Chrono Pendulum: Projection\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Treasure δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by +1 and Rouse all Awakeners. For the next 5 turns, gain one Relic at turn start: \"Mythag Insignia, Doctor's Case, Proto Battery, Mind Engraving, Chrono Pendulum: Evolution\"."
  },
  RelicConfig_65570_Desc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by +1 and Rouse all Awakeners. For the next 5 turns, gain one Relic at turn start: \"Mythag Insignia, Doctor's Case, Proto Battery, Mind Engraving, Chrono Pendulum: Evolution\"."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Treasure γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. For the next 5 turns, gain a Relic at turn start: \"Putney Morning Post, Principles of Aesthetics, Mob Song, Broken Visage, Chrono Pendulum: Reciprocate\"."
  },
  RelicConfig_66515_Desc = {
    Text = "At the start of the battle, the Arithmetica Limit +1, and Rouse all Awakeners. For the next 5 turns, gain a relic at turn start: \"Putney Morning Post, Principles of Aesthetics, Mob Song, Broken Visage, Chrono Pendulum: Reciprocate\"."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Treasure ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_66518_Desc = {
    Text = "At the start of battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd turns, discover a Relic, up to five times."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_66519_Desc = {
    Text = "At the start of battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd turns, discover a Relic, up to five times."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "At turn start, all Awakeners gain 25 Aliemus. When picked up, Max HP is increased by 1.5 times."
  },
  RelicConfig_67690_Desc = {
    Text = "At turn start, all Awakeners gain 25 Aliemus. When picked up, Max HP becomes 1.5 times."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:Blessed: Nightmare Manifest β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Fear not, hesitate not. This is but a fleeting dream; the light of the All-Father still shines upon you."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Obtain 3 Arithmetica when picked up."
  },
  RelicConfig_67788_Desc = {
    Text = "Upon picking up, gain 3 Arithmetica."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:Pocketwatch Mirror>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Memories solidified in the past, buried deep in the black depths."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "When picked up, place 1 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_67789_Desc = {
    Text = "When picked up, place 1 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Signal Relay>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Anticipate or dread the moment it chimes."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "All \"Strike\" Crit. DMG is increased by 20%. Upon picking up, add 1 <DerivativeCardKeywords_40:Fleeting Beauty> to your hand."
  },
  RelicConfig_67790_Desc = {
    Text = "All \"Strike\" Crit. DMG is increased by 20%. Upon picking up, add 1 <DerivativeCardKeywords_40:\"Fleeting Beauty\"> to your hand."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Fleeting Beauty>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Preserve the beauty of fleeting moments forever."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "When picked up, inflict 1 turn of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  RelicConfig_67791_Desc = {
    Text = "When picked up, inflict 1 turn of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Shifting Straitjacket>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Not only can time cause fabric to fade, but fear and pain as well."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "At the start of battle, all Awakeners gain 50 Aliemus. Put 2 copies of <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_67793_Desc = {
    Text = "When picked up, all Awakeners gain 50 Aliemus, and place 2 <DerivativeCardKeywords_1:\"Echoes of Lost Shadows\"> into hand."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:Signal Relay +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Anticipate or dread the moment it chimes."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Increase hand limit by 5 and replenish hand to the limit at the start of the battle. Draw 1 additional card at turn start, and discard all Symptom Cards and State cards at turn end while retaining other cards."
  },
  RelicConfig_67794_Desc = {
    Text = "Increase hand limit by 5 and replenish hand to the limit at the start of the battle. Draw 1 extra card at turn start, and discard all Symptom Cards and State Cards at turn end while keeping other cards."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:Blessed: Mind Engraving β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "The greedy carve their mistakes into their hearts and dedicate themselves to atoning for their past."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67818_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67819_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67820_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67821_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67822_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67823_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realmsη\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67824_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realmsδ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67825_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_67826_Desc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly discover a \"Relic \" or \"Support\", for a total of five discoveries."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Gateway of All Realms ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_84:\"Twilight: Unfinished Wax Sculpture\"> into hand, copying all cards in the Draw Pile. Draw 5 additional cards each turn and gain 5 Arithmetica. After playing \"Strike\" or \"Defense\", gain [Arg1] Shield."
  },
  RelicConfig_68651_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_84:\"Twilight: Unfinished Wax Sculpture\"> into hand, copying all cards in the Draw Pile. Draw 5 additional cards each turn and gain 5 Arithmetica. After playing \"Strike\" or \"Defense\", gain [Arg1] Shield."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Fear\">"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_85:\"Twilight: Mutated Heart\"> into hand. At turn start, you can choose to discard any number of cards in hand and draw the same amount. Gain [Arg1] Temporary STR in odd-numbered turns, and place <DerivativeCardKeywords_97:Unyielding Will β> into hand. Gain [Arg2] Temporary Alert in even-numbered turns, and place <DerivativeCardKeywords_98:Hideβ> into hand."
  },
  RelicConfig_68652_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_85:\"Twilight: Mutated Heart\"> into hand. At turn start, you can choose to discard any number of cards in hand and draw the same amount. Gain [Arg1] Temporary STR in odd-numbered turns, and place \"<DerivativeCardKeywords_97:Unyielding Will β\"> into hand. Gain [Arg2] Temporary Alert in even-numbered turns, and place <DerivativeCardKeywords_98:\"Hideβ\"> into hand"
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Scathe\">"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_83:\"Twilight: Innocent Return Gift\"> into hand. All Awakeners can release 1 additional Exalt per turn; after releasing Exalt, reduce the enemy's [Arg2] STR. At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_68653_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_83:\"Twilight: Innocent Return Gift\"> into hand. Each Awakener can release Exalt 1 additional time per turn; after releasing Exalt, reduce enemy STR by [Arg2]. At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Sorrow\">"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakener, place <DerivativeCardKeywords_88:\"Twilight: Utopian Veil\"> into hand, increase the team's hand limit by +2, and increase the Keyflare storage limit by +100%. After releasing the Posse, all Awakeners' Crit. DMG and Temporary Crit. Rate +[Arg1]%, receive a Shield equal to 20% of their Max HP, and draw cards until the hand reaches the limit."
  },
  RelicConfig_68654_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, draw <DerivativeCardKeywords_88:\"Twilight: Utopian Veil\"> into hand, increase the team's hand limit by +2, and increase the Keyflare storage limit by +100%. After releasing the Posse, all Awakeners' Crit. DMG and Temporary Crit. Rate +[Arg1]%, receive a Shield equal to 20% of their Max HP, and draw cards until the hand limit is reached."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Madness\">"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_89:\"Twilight: Seed of Abundance\"> into hand. At turn end, retain remaining Arithmetica and no longer discard cards. For each instance of Active DMG dealt, gain [Arg1] Temporary STR and [Arg2] Shield."
  },
  RelicConfig_68655_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_89:\"Twilight: Seed of Abundance\"> into hand. At turn end, retain remaining Arithmetica and no longer discard cards. For each instance of Active DMG dealt, gain [Arg1] Temporary STR and [Arg2] Shield."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Birth\">"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_86:\"Twilight: Honey Mead\"> into hand, and increase all Awakener's Crit. DMG by 1.5 times. At turn end, Awakener that did not release Exalt gain [Arg1] Aliemus. If the number of cards played is less than [Arg2], draw 2 cards next turn and gain 2 Arithmetica."
  },
  RelicConfig_68656_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_86:\"Twilight: Honey Mead\"> into hand, and increase all Awakeners' Crit. DMG to 1.5 times. At turn end, Awakeners that did not release Exalt gain [Arg1] Aliemus. If the number of cards played is less than [Arg2], draw 2 cards next turn and gain 2 Arithmetica."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Deceit\">"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_87:\"Twilight: The Envoy's Verdict\"> into hand, and double the team's DMG Amplification. The Weakness effect inflicted by you increases from 25% to 50%. At the end of each turn, gain a Shield equal to [Arg1]% of Max HP and deal Fixed DMG equal to [Arg2]x Shield to all enemies."
  },
  RelicConfig_68657_Desc = {
    Text = "At the start of the battle, Rouse all Awakeners, place <DerivativeCardKeywords_87:\"Twilight: The Envoy's Verdict\"> into hand, and double the team's DMG Amplification. The Weakness effect inflicted by you increases from 25% to 50%. At the end of each turn, gain a Shield equal to [Arg1]% of Max HP and deal Fixed DMG equal to [Arg2]x Shield to all enemies."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:\"Pure Silver Core: Heresy\">"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Tawil's DMG, Heal, and Shield are boosted by 50%. At the start of battle, Tawil gains 120 Aliemus."
  },
  RelicConfig_68886_Desc = {
    Text = "Tawil's Damage, Shield, and HP recovery increase by 50%. At the start of combat, Tawil gains 120 Aliemus."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:Omniscient Eye>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Stepping out from the Gateway, He sets foot on the only correct path."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_69319_Desc = {
    Text = "At the start of battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd turns, discover a Relic, up to five times."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_69320_Desc = {
    Text = "At the start of battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd turns, discover a Relic, up to five times."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "At the start of battle, Arithmetica Limit +1, Rouse all Awakeners. At turn start, randomly Discover a \"Relic\" or \"Support\", up to 5 times."
  },
  RelicConfig_69321_Desc = {
    Text = "At the start of battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd turns, discover a Relic, up to five times."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish δ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "At turn start, accumulate 1 \"Abyssal Energy,\" and choose \"Slumber\" or \"Arouse.\" Slumber: additionally accumulate 1 \"Abyssal Energy.\" Arouse: consume 1/5/10 \"Abyssal Energy\" to gain Tulu's assistance. The more \"Abyssal Energy\" consumed, the stronger Tulu's assistance effect."
  },
  RelicConfig_70042_Desc = {
    Text = "At turn start, accumulate 1 point of \"Abyssal Energy\", choose \"Slumber\" or \"Arouse\". Slumber: additionally accumulate 1 point of \"Abyssal Energy\". Awake: exhaust 1/5/10 \"Abyssal Energy\" to gain Tulu's assistance. The more \"Abyssal Energy\" consumed, the stronger the effect of Tulu's assistance."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Sovereign's Power>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "At the start of the battle, shuffle all Awakeners' \"Rouse\" into the Draw Pile."
  },
  RelicConfig_70084_Desc = {
    Text = "At the start of the battle, shuffle all Awakeners' \"Rouse\" into the Draw Pile."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Rouse>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "All Awakeners' Base DMG increases by [Arg1]%."
  },
  RelicConfig_70700_Desc = {
    Text = "The Base DMG dealt by all Awakeners increases by [Arg1]%."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Weeping Pipe>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Is this the product of hatred or the result of revenge?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70701_Desc = {
    Text = "At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Proto Battery>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Portable Hope"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "After releasing \"Exalt,\" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70702_Desc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Iron Lock+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = [[
A thick and sturdy lock, difficult to open without a key.
Of course, this is nothing for a master thief]]
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Strike\" deals an additional instance of DMG equal to [Arg1]% of the Awakener's ATK, and can trigger up to 3 times per turn."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Strike\" deals additional DMG equal to [Arg1]% of the Awakener's Attack, triggering up to 3 times per turn."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Rusty Lancet>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Not suitable for cutting live tissue."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Use Keyflare Rouse to apply [Arg1] <IntoxicationIconKeywords:Poison> to all enemies and gain [Arg2] Keyflare."
  },
  RelicConfig_70704_Desc = {
    Text = "Use Keyflare Rouse to inflict [Arg1] <IntoxicationIconKeywords:Poison> on all enemies and gain [Arg2] Keyflare."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Uncanny Salve+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Some kind of homemade ointment for external injuries. Do not use without a doctor's guidance."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Strike\" applies <IntoxicationIconKeywords:Poison> that equals to [Arg1]% of the DMG it dealt, with a maximum of [Arg2] per turn."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Strike\" inflicts <IntoxicationIconKeywords:Poison> equal to [Arg1]% of DMG dealt, with a maximum of [Arg2] per turn."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Other Tongue+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "It is not a demon, but it indeed conveys whispers from beyond the mortal realm."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Embryo Fusion> Automatic gain +[Arg1]%"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:Embryo Fusion> Automatic gain +[Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Plague Record>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Plague — an unconscious, restless manifestation of nature."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "After using Keyflare Rouse, all Awakeners gain [Arg1] Aliemus and [Arg2] Keyflare."
  },
  RelicConfig_70707_Desc = {
    Text = "After using Keyflare Rouse, all Awakeners gain [Arg1] Aliemus and [Arg2] Keyflare."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Laurel Cufflinks+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = [[
Silver cufflinks engraved with osmanthus leaf patterns.
Finely crafted and gleaming, they once embodied the friendship of two children.]]
  },
  RelicConfig_70708_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakener and Relic <IntoxicationIconKeywords:Poison> effects are +[Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakener and Relic <IntoxicationIconKeywords:Poison> effects are +[Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Forgotten Loom+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "A kind mother mends the wounds of the heart."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "After entering the Ultra Round, the first Non-Derived Command Card played activates an additional [Arg1] times."
  },
  RelicConfig_70709_Desc = {
    Text = "After entering the Ultra Round, the first Non-Derived Command Card played activates an additional [Arg1] times."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:Luminous Hourglass>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "A measurable amount of time."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <RetaliateIconKeywords:Counter> and [Arg2] Keyflare."
  },
  RelicConfig_70711_Desc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <RetaliateIconKeywords:Counter> and [Arg2] Keyflare."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Forgotten Prelude+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"How foolish humans are, blindly believing simply because it's antiquated.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <PowerIconKeywords:STR> and [Arg2] Keyflare."
  },
  RelicConfig_70712_Desc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <PowerIconKeywords:STR> and [Arg2] Keyflare."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Our Home>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "They were together in the past, and they will always be together in the future. They are a close-knit and loving family."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_70713_Desc = {
    Text = "Upon losing a HP, the Crimson Furnace grants [Arg1]% of the HP loss."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Rusted Saw>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "The dissection doctor spends his life never seeing a beautiful woman, only bags of bones, inflamed nerves, muscles, and tissues caused by diseases."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakeners' and Relics' <RetaliateIconKeywords:Counter> +[Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakeners' <RetaliateIconKeywords:Counter> and Relics' <RetaliateIconKeywords:Counter> DMG +[Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Truth Unbound>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "It conveys countless secrets, whether spoken actively or passively."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "After using Keyflare Rouse, draw [Arg1] cards and gain [Arg2] Keyflare."
  },
  RelicConfig_70715_Desc = {
    Text = "After using Keyflare Rouse, draw [Arg1] cards and gain [Arg2] Keyflare."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Brand-New Wallet+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = [[
A leather wallet engraved with the emblem of Mythag University.
It is now empty, containing nothing.]]
  },
  RelicConfig_70717_BattleDesc = {
    Text = "At turn start, draw [Arg1] cards."
  },
  RelicConfig_70717_Desc = {
    Text = "At turn start, draw [Arg1] cards."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:True North Compass+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "The indication is not a direction, but rather a magnetic field."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "After releasing \"Exalt\", all enemies take 1 instance of [Arg1] Fixed DMG and trigger [Arg2]% <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70718_Desc = {
    Text = "After releasing \"Exalt, \" all enemies take 1 instance of Fixed DMG equal to [Arg1]% of your team's Max HP and trigger [Arg2]% <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Radium Jawbone>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = [[
Displayed in a private collector's showroom.
The collector was captivated by its beautiful fluorescence, admiring it day and night, until he eventually withered away and became one of its kind.]]
  },
  RelicConfig_70719_BattleDesc = {
    Text = "At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70719_Desc = {
    Text = "At turn start, all Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Proto Battery+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Portable Hope"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70720_Desc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Highest Honor>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "An elegant and mysterious black short-haired cat, said to be revered as a deity in a distant desert kingdom. The name of that deity has now been lost to time.\nWorshipped, revered, forgotten—perhaps this is the fate of all gods."
  },
  RelicConfig_70721_BattleDesc = {
    Text = "After releasing \"Exalt\" 4 times in one turn, gain [Arg1] Arithmetica. 3-turn cooldown."
  },
  RelicConfig_70721_Desc = {
    Text = "After using Exalt 4 times in one turn, gain [Arg1] Arithmetica. 3 turns cooldown."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Differential Engine>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"It changed history.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <PowerIconKeywords:STR> and [Arg2] Keyflare."
  },
  RelicConfig_70722_Desc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <PowerIconKeywords:STR> and [Arg2] Keyflare."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Our Home+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "They were together in the past, and they will always be together in the future. They are a close-knit and loving family."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "When you play 2 consecutive cards with higher Arithmetica Cost than the previous one, gain [Arg1] <RetaliateIconKeywords:Counter>, up to 3 times per turn."
  },
  RelicConfig_70723_Desc = {
    Text = "When you play 2 consecutive cards with higher Arithmetica Cost than the previous one, gain [Arg1] <RetaliateIconKeywords:Counter>, up to 3 times per turn."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Arcana Archive+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "The flow of fate."
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Obtain [Arg1] <PowerIconKeywords:STR> when the battle begins."
  },
  RelicConfig_70724_Desc = {
    Text = "At the start of combat, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Crimson Brooch+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "A hint of fresh red seeps through."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "After the battle starts, apply [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "After the battle starts, Inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Malignant Child+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Born of pure evil, even though it was not its own will."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Gain [Arg1] Shield from Annihilation, with a 3-turn cooldown."
  },
  RelicConfig_70726_Desc = {
    Text = "Gain [Arg1] Shield from Annihilation, with a cooldown of 3 turns."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Hyperstring Pocketwatch>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Oh no, the pocket watch has stopped.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_70727_Desc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Blessed Blood+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "It is sweet and mellow, with a fragrance of roses."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Switching to Tranquil Sea stance makes all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:STR>. 3-turn cooldown."
  },
  RelicConfig_70728_Desc = {
    Text = "Switching to Tranquil Sea stance makes all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:STR>. 3-turn cooldown."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Nameless Appendage+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Be careful not to get pricked."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Obtain [Arg1] <PowerIconKeywords:STR> when the battle begins."
  },
  RelicConfig_70730_Desc = {
    Text = "At the start of combat, gain [Arg1] <PowerIconKeywords:STR>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Crimson Brooch>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "A hint of fresh red seeps through."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "When attacked by an enemy, deal 1 instance of [Arg1] Fixed DMG to them. This DMG enjoys [Arg2]% <RetaliateIconKeywords:Counter> bonus. Each enemy can trigger this effect up to 1 time per turn."
  },
  RelicConfig_70731_Desc = {
    Text = "When attacked by an enemy, deal 1 instance of Fixed DMG equal to [Arg1]% of your team's Max HP. This DMG enjoys a [Arg2]% <RetaliateIconKeywords:Counter> bonus. Each enemy can trigger this effect up to 1 time per turn."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Ritual Dagger+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "A dagger with a curved blade, commonly used in sacrificial rituals."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "After entering the Ultra Round, the first Non-Derived Command Card played activates an additional [Arg1] times."
  },
  RelicConfig_70732_Desc = {
    Text = "After entering the Ultra Round, the first Non-Derived Command Card played activates an additional [Arg1] times."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Luminous Hourglass+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "A measurable amount of time."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Embryo Fusion> Automatic gain +[Arg1]%"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:Embryo Fusion> Automatic gain +[Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Plague Record+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Plague — an unconscious, restless manifestation of nature."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "After using Keyflare Rouse, increase the Base DMG dealt by all Awakeners by [Arg1]% and gain [Arg2] Keyflare."
  },
  RelicConfig_70734_Desc = {
    Text = "After using Keyflare Rouse, increase the Base DMG dealt by all Awakeners by [Arg1]% and gain [Arg2] Keyflare."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Celestial Astrolabe>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "The wonders of the universe."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "When you play 2 consecutive cards with lower Arithmetica Cost than the previous one, apply [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, up to 3 times per turn."
  },
  RelicConfig_70735_Desc = {
    Text = "When you play 2 consecutive cards with lower Arithmetica Cost than the previous one, Inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, up to 3 times per turn."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Arcana Relic+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "The End of Fate"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Switching to Tranquil Sea stance makes all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:STR>. 3-turn cooldown."
  },
  RelicConfig_70736_Desc = {
    Text = "Switching to Tranquil Sea stance makes all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:STR>. 3-turn cooldown."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Nameless Appendage>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Be careful not to get pricked."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "After playing a card, if the number of cards in hand is less than or equal to [Arg1], draw [Arg2] cards. This effect can trigger up to [Arg3] times per turn."
  },
  RelicConfig_70737_Desc = {
    Text = "After playing a card, if the number of cards in hand is less than or equal to [Arg1], draw [Arg2] cards. This effect can trigger up to [Arg3] times per turn."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Arcane Gloves>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"Don't be afraid, it's just an illusion.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_70738_Desc = {
    Text = "At turn end, restore [Heal:Arg1] HP."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Blessed Blood>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "It is sweet and mellow, with a fragrance of roses."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Shield and [Arg2] Keyflare."
  },
  RelicConfig_70739_Desc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Shield and [Arg2] Keyflare."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Preserved Butterfly>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "To this day, he is still deeply loved by someone."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "After using Keyflare Rouse, increase the Base DMG dealt by all Awakeners by [Arg1]% and gain [Arg2] Keyflare."
  },
  RelicConfig_70740_Desc = {
    Text = "After using Keyflare Rouse, increase the Base DMG dealt by all Awakeners by [Arg1]% and gain [Arg2] Keyflare."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Celestial Astrolabe+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "The wonders of the universe."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Max Arithmetica +[Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Max Arithmetica +[Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Vitality Injection+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Twitching is also a form of vitality."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "At battle start, Tentacle Limit +[Arg1], gain [Arg2] Tentacles."
  },
  RelicConfig_70742_Desc = {
    Text = "At battle start, Tentacle Limit +[Arg1], gain [Arg2] Tentacles."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Chant of the Tides>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "It is said that inedible animals like whelks absorb around 80% of the ocean's nutrients"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Each turn, when <DevouredIconKeywords:Devour> occurs for the first time, other Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70743_Desc = {
    Text = "Each turn, when <DevouredIconKeywords:Devour> occurs for the first time, other Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Gilded Reverie>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "The day of transformation will be your doom."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "After playing a Non-Derived Command Card, shuffle [Arg1] temporary copies of that card with its Arithmetica Cost reduced by 2 into the Draw Pile. Cooldown: 3 turns."
  },
  RelicConfig_70744_Desc = {
    Text = "After playing a Non-Derived Command Card, shuffle [Arg1] temporary copies of that card with its Arithmetica Cost reduced by 2 into the Draw Pile. Cooldown: 3 turns."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Mute Jukebox+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "His voice faded into the wind."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Obtain [Arg1] <RetaliateIconKeywords:Counter> at the start of battle. Effects are doubled in Boss Battles."
  },
  RelicConfig_70745_Desc = {
    Text = "Obtain [Arg1] <RetaliateIconKeywords:Counter> at the start of battle, effects are doubled in Boss Battles."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Nettle Vest+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Unable to identify the liquid that has been contaminated."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70746_Desc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Highest Honor+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "An elegant and mysterious black short-haired cat, said to be revered as a deity in a distant desert kingdom. The name of that deity has now been lost to time.\nWorshipped, revered, forgotten—perhaps this is the fate of all gods."
  },
  RelicConfig_70747_BattleDesc = {
    Text = "After playing a card, if the number of cards in hand is less than or equal to [Arg1], draw [Arg2] cards. This effect can trigger up to [Arg3] times per turn."
  },
  RelicConfig_70747_Desc = {
    Text = "After playing a card, if the number of cards in hand is less than or equal to [Arg1], draw [Arg2] cards. This effect can trigger up to [Arg3] times per turn."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Arcane Gloves+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"Don't be afraid, it's just an illusion.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Shield and [Arg2] Keyflare."
  },
  RelicConfig_70748_Desc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Shield and [Arg2] Keyflare."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Preserved Butterfly+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "To this day, he is still deeply loved by someone."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Whenever a card enters Ultra Space, if this card belongs to a different owner than other Ultra Space cards, place [Arg1] <DerivativeCardKeywords_4:\"Insight\"> cards in hand."
  },
  RelicConfig_70749_Desc = {
    Text = "Whenever a card enters Ultra Space, if the Awakener of this card is different from that of other cards in Ultra Space, place [Arg1] <DerivativeCardKeywords_4:\"Insight\"> cards in hand."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Alfonso's Artifact+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Unlike the unpredictable fate, the stars follow their own laws."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "When you play 2 consecutive cards with higher Arithmetica Cost than the previous one, gain [Arg1] <RetaliateIconKeywords:Counter>, up to 3 times per turn."
  },
  RelicConfig_70750_Desc = {
    Text = "When you play 2 consecutive cards with higher Arithmetica Cost than the previous one, gain [Arg1] <RetaliateIconKeywords:Counter>, up to 3 times per turn."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Arcana Archive>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "The flow of fate."
  },
  RelicConfig_70751_BattleDesc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Arithmetica and [Arg2] Keyflare."
  },
  RelicConfig_70751_Desc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Arithmetica and [Arg2] Keyflare."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Mythag Insignia>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Badges distributed to Investigators by Mythag University. They not only symbolize the wearer's identity but also serve as tools for remote communication."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <RetaliateIconKeywords:Counter> and [Arg2] Keyflare."
  },
  RelicConfig_70752_Desc = {
    Text = "Use Keyflare Rouse and gain [Arg1] <RetaliateIconKeywords:Counter> and [Arg2] Keyflare."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Forgotten Prelude>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"How foolish humans are, blindly believing simply because it's antiquated.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "After the battle starts, apply [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "After the battle starts, Inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> to all enemies, with the effect doubled in Boss Battles. All Awakener base DMG is +[Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Rite of Spring+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Amid the laughter of the night, the silhouette of the canoe glides effortlessly across the lake."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_70754_Desc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Bloody Pebble>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "One, Two, Three, Four, Five."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Gain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_70755_Desc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Filigree Agate+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "It's probably just ordinary agate patterns. Perhaps."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Arithmetica and [Arg2] Keyflare."
  },
  RelicConfig_70756_Desc = {
    Text = "After using Keyflare Rouse, gain [Arg1] Arithmetica and [Arg2] Keyflare."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Mythag Insignia+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Badges distributed to Investigators by Mythag University. They not only symbolize the wearer's identity but also serve as tools for remote communication."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Use the Raging Waves stance to immediately activate all Tentacle attacks on enemies [Arg1] times, with a 3-turn cooldown."
  },
  RelicConfig_70757_Desc = {
    Text = "Activate all Tentacle attacks on enemies immediately using the Raging Waves stance [Arg1] times, with a 3-round cooldown."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Lemurian Delight>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "The Lord of Eternal Slumber awaits you in your dreams."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "When you play 2 consecutive cards with lower Arithmetica Cost than the previous one, apply [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, up to 3 times per turn."
  },
  RelicConfig_70758_Desc = {
    Text = "When you play 2 consecutive cards with lower Arithmetica Cost than the previous one, Inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, up to 3 times per turn."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Arcana Relic>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "The End of Fate"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "After the battle starts, apply [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "After the battle starts, Inflict [Arg1] stacks of <WeaknessIconKeywords:Weakness> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Malignant Child>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Born of pure evil, even though it was not its own will."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "At the start of battle, inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies; the effect is doubled in Boss Battles."
  },
  RelicConfig_70760_Desc = {
    Text = "At the start of battle, Inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, with double effect in Boss Battles."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoxin>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Extract, Refine."
  },
  RelicConfig_70761_BattleDesc = {
    Text = "After the battle starts, apply [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> to all enemies, with the effect doubled in Boss Battles. All Awakeners' Base DMG is +[Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "After the battle starts, Inflict [Arg1] stacks of <VulnerabilityIconKeywords:Vulnerable> to all enemies, with the effect doubled in Boss Battles. All Awakener Base DMG is +[Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Rite of Spring>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Amid the laughter of the night, the silhouette of the canoe glides effortlessly across the lake."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "After releasing \"Exalt\" 4 times in one turn, gain [Arg1] Arithmetica. 3-turn cooldown."
  },
  RelicConfig_70762_Desc = {
    Text = "After using Exalt 4 times in one turn, gain [Arg1] Arithmetica. 3 turns cooldown."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Differential Engine+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"It changed history.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "After releasing \"Exalt,\" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70763_Desc = {
    Text = "After releasing \"Exalt, \" gain [Arg1] Temporary <PowerIconKeywords:STR>."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Iron Lock>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = [[
A thick and sturdy lock, difficult to open without a key.
Of course, this is nothing for a master thief]]
  },
  RelicConfig_70764_BattleDesc = {
    Text = "When attacked by an enemy, deal 1 instance of [Arg1] Fixed DMG to them. This DMG enjoys [Arg2]% <RetaliateIconKeywords:Counter> bonus. Each enemy can trigger this effect up to 1 time per turn."
  },
  RelicConfig_70764_Desc = {
    Text = "When attacked by an enemy, deal 1 instance of Fixed DMG equal to [Arg1]% of your team's Max HP. This DMG enjoys a [Arg2]% <RetaliateIconKeywords:Counter> bonus. Each enemy can trigger this effect up to 1 time per turn."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Ritual Dagger>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "A dagger with a curved blade, commonly used in sacrificial rituals."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Gain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_70765_Desc = {
    Text = "Obtain [Arg1] Temporary <PowerIconKeywords:STR> whenever DMG is dealt, up to 15 times per turn."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Filigree Agate>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "It's probably just ordinary agate patterns. Perhaps."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Shield."
  },
  RelicConfig_70766_Desc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Shield."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Guardian Hand>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "The hand that prays, the fist that remains steadfast."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Annihilation grants [Arg1] Aliemus to the Awakener with the lowest Aliemus, with a 3-turn cooldown."
  },
  RelicConfig_70767_Desc = {
    Text = "Annihilation grants the Awakener with the lowest Aliemus gains [Arg1] Aliemus, with a cooldown of 3 turns."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Time Scarab>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = [[
A pocket watch found both in a clock shop and an insect museum.
It has been incorporated into the university's collection since the Flood.]]
  },
  RelicConfig_70768_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakeners' and Relics' <RetaliateIconKeywords:Counter> +[Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakeners' <RetaliateIconKeywords:Counter> and Relics' <RetaliateIconKeywords:Counter> DMG +[Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Truth Unbound+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "It conveys countless secrets, whether spoken actively or passively."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_70769_Desc = {
    Text = "After directly using \"Embryo\" for the first time each turn, Active DMG will cause [Arg1]% of the DMG dealt as <BleedingIconKeywords:Bleed> for the rest of the turn."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Bloody Pebble+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "One, Two, Three, Four, Five."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "At turn start, draw [Arg1] cards."
  },
  RelicConfig_70770_Desc = {
    Text = "At turn start, draw [Arg1] cards."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:True North Compass>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "The indication is not a direction, but rather a magnetic field."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Strike\" additionally deals 2 more instances of DMG equal to [Arg1]% of the Awakener's ATK, triggering up to 3 times per turn."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Strike\" additionally deals DMG equal to [Arg1]% of the Awakener's ATK 2 more times, triggering up to 3 times per turn."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Rusty Lancet+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Not suitable for cutting live tissue."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "After using Keyflare Rouse, draw [Arg1] cards and gain [Arg2] Keyflare."
  },
  RelicConfig_70772_Desc = {
    Text = "After using Keyflare Rouse, draw [Arg1] cards and gain [Arg2] Keyflare."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Brand-New Wallet>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = [[
A leather wallet engraved with the emblem of Mythag University.
It is now empty, containing nothing.]]
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Increase the DMG of the first five attacks each turn by [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "Increase the DMG of the first five attacks dealt each turn by [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Vision Corrector>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Someone once discovered the truth through it."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Obtain [Arg1] <RetaliateIconKeywords:Counter> at the start of battle. Effects are doubled in Boss Battles."
  },
  RelicConfig_70776_Desc = {
    Text = "Obtain [Arg1] <RetaliateIconKeywords:Counter> at the start of battle, effects are doubled in Boss Battles."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Nettle Vest>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Unable to identify the liquid that has been contaminated."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "All Awakeners gain [Arg1] Aliemus when 4 different Awakeners' Command Cards are played consecutively in the same turn. 3-turn cooldown."
  },
  RelicConfig_70777_Desc = {
    Text = "All Awakeners gain [Arg1] Aliemus when 4 different Awakeners' Command Cards are played consecutively in the same turn. 3-turn cooldown."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Veil of the Nameless Deity>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Do not look directly at the gods."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "At the start of battle, inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies; the effect is doubled in Boss Battles."
  },
  RelicConfig_70778_Desc = {
    Text = "At the start of battle, Inflict [Arg1] <IntoxicationIconKeywords:Poison> to all enemies, with double effect in Boss Battles."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoxin+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Extract, Refine."
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Use Keyflare Rouse to apply [Arg1] <IntoxicationIconKeywords:Poison> to all enemies and gain [Arg2] Keyflare."
  },
  RelicConfig_70779_Desc = {
    Text = "Use Keyflare Rouse to inflict [Arg1] <IntoxicationIconKeywords:Poison> on all enemies and gain [Arg2] Keyflare."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Uncanny Salve>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Some kind of homemade ointment for external injuries. Do not use without a doctor's guidance."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Strike\" applies <IntoxicationIconKeywords:Poison> that deals [Arg1]% DMG, with a maximum of [Arg2] per turn."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Strike\" inflicts <IntoxicationIconKeywords:Poison> equal to [Arg1]% of DMG dealt, with a maximum of [Arg2] per turn."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Other Tongue>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "It is not a demon, but it indeed conveys whispers from beyond the mortal realm."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Shield."
  },
  RelicConfig_70781_Desc = {
    Text = "At turn start, if HP is below 25%, gain [Arg1] Shield."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Guardian Hand+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "The hand that prays, the fist that remains steadfast."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Obtain [Arg1]% of the HP lost as Crimson Furnace when losing HP."
  },
  RelicConfig_70782_Desc = {
    Text = "Upon losing a HP, the Crimson Furnace grants [Arg1]% of the HP loss."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Rusted Saw+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "The dissection doctor spends his life never seeing a beautiful woman, only bags of bones, inflamed nerves, muscles, and tissues caused by diseases."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Increase the DMG of the first five attacks each turn by [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "Increase the DMG of the first five attacks dealt each turn by [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Vision Corrector+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Someone once discovered the truth through it."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Whenever a card enters Ultra Space, if this card belongs to a different owner than other Ultra Space cards, place [Arg1] <DerivativeCardKeywords_4:\"Insight\"> cards in hand."
  },
  RelicConfig_70784_Desc = {
    Text = "Whenever a card enters Ultra Space, if the Awakener of this card is different from that of other cards in Ultra Space, place [Arg1] <DerivativeCardKeywords_4:\"Insight\"> cards in hand."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Alfonso's Artifact>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Unlike the unpredictable fate, the stars follow their own laws."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "All Awakeners gain [Arg1] Aliemus when 4 different Awakeners' Command Cards are played consecutively in the same turn. 3-turn cooldown."
  },
  RelicConfig_70785_Desc = {
    Text = "All Awakeners gain [Arg1] Aliemus when 4 different Awakeners' Command Cards are played consecutively in the same turn. 3-turn cooldown."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Veil of the Nameless Deity+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Do not look directly at the gods."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "At turn end, if in Surging Tides stance, gain [Arg1] <TentacleInjurieIconKeywords:Tentacle DMG>, 3 turn cooldown."
  },
  RelicConfig_70786_Desc = {
    Text = "At turn end, if in Surging Tides stance, gain [Arg1] <TentacleInjurieIconKeywords:Tentacle DMG>, 3 turn cooldown."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Severed Head Worm>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "As long as our brains remain a mystery, it's no big deal if they're filled with tentacles."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "All Awakeners' Base DMG increases by [Arg1]%."
  },
  RelicConfig_70787_Desc = {
    Text = "The Base DMG dealt by all Awakeners increases by [Arg1]%."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Weeping Pipe+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Is this the product of hatred or the result of revenge?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "After using Keyflare Rouse, all Awakeners gain [Arg1] Aliemus and [Arg2] Keyflare."
  },
  RelicConfig_70788_Desc = {
    Text = "After using Keyflare Rouse, all Awakeners gain [Arg1] Aliemus and [Arg2] Keyflare."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Laurel Cufflinks>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = [[
Silver cufflinks engraved with osmanthus leaf patterns.
Finely crafted and gleaming, they once embodied the friendship of two children.]]
  },
  RelicConfig_70789_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakener and Relic <IntoxicationIconKeywords:Poison> effects are +[Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. All Awakener and Relic <IntoxicationIconKeywords:Poison> effects are +[Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Forgotten Loom>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "A kind mother mends the wounds of the heart."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Annihilation grants [Arg1] Aliemus to the Awakener with the lowest Aliemus, with a 3-turn cooldown."
  },
  RelicConfig_70790_Desc = {
    Text = "Annihilation grants the Awakener with the lowest Aliemus gains [Arg1] Aliemus, with a cooldown of 3 turns."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Time Scarab+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = [[
A pocket watch found both in a clock shop and an insect museum.
It has been incorporated into the university's collection since the Flood.]]
  },
  RelicConfig_70791_BattleDesc = {
    Text = "At battle start, Tentacle Limit +[Arg1], gain [Arg2] Tentacles."
  },
  RelicConfig_70791_Desc = {
    Text = "At battle start, Tentacle Limit +[Arg1], gain [Arg2] Tentacles."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Chant of the Tides+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "It is said that inedible animals like whelks absorb around 80% of the ocean's nutrients"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "At turn end, if in Surging Tides stance, gain [Arg1] <TentacleInjurieIconKeywords:Tentacle DMG>, 3 turn cooldown."
  },
  RelicConfig_70792_Desc = {
    Text = "At turn end, if in Surging Tides stance, gain [Arg1] <TentacleInjurieIconKeywords:Tentacle DMG>, 3 turn cooldown."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Severed Head Worm+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "As long as our brains remain a mystery, it's no big deal if they're filled with tentacles."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Each turn, when <DevouredIconKeywords:Devour> occurs for the first time, other Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70793_Desc = {
    Text = "Each turn, when <DevouredIconKeywords:Devour> occurs for the first time, other Awakeners gain [Arg1] Aliemus."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Gilded Reverie+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "The day of transformation will be your doom."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Gain [Arg1] Shield from Annihilation, with a 3-turn cooldown."
  },
  RelicConfig_70794_Desc = {
    Text = "Gain [Arg1] Shield from Annihilation, with a cooldown of 3 turns."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Hyperstring Pocketwatch+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Oh no, the pocket watch has stopped.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "After playing a non-Derived Command Card, shuffle [Arg1] temporary copies of that card with its Arithmetica Cost reduced by 2 into the Draw Pile. Cooldown: 3 turns."
  },
  RelicConfig_70795_Desc = {
    Text = "After playing a Non-Derived Command Card, shuffle [Arg1] temporary copies of that card with its Arithmetica Cost reduced by 2 into the Draw Pile. Cooldown: 3 turns."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Mute Jukebox>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "His voice faded into the wind."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "After releasing \"Exalt\", all enemies take 1 instance of [Arg1] Fixed DMG and trigger [Arg2]% <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70796_Desc = {
    Text = "After releasing \"Exalt, \" all enemies take 1 instance of Fixed DMG equal to [Arg1]% of your team's Max HP and trigger [Arg2]% <IntoxicationIconKeywords:Poison>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Radium Jawbone+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = [[
Displayed in a private collector's showroom.
The collector was captivated by its beautiful fluorescence, admiring it day and night, until he eventually withered away and became one of its kind.]]
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Max Arithmetica +[Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Max Arithmetica +[Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Vitality Injection>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Twitching is also a form of vitality."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Use the Raging Waves stance to immediately activate all Tentacle attacks on enemies [Arg1] times, with a 3-turn cooldown."
  },
  RelicConfig_70798_Desc = {
    Text = "Activate all Tentacle attacks on enemies immediately using the Raging Waves stance [Arg1] times, with a 3-round cooldown."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Lemurian Delight+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "The Lord of Eternal Slumber awaits you in your dreams."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "When \"Defense\" is played, gain [Arg1] Temporary<RetaliateIconKeywords:Counter>, triggers up to 3 times per turn."
  },
  RelicConfig_70799_Desc = {
    Text = "When \"Defense\" is played, gain [Arg1] Temporary <RetaliateIconKeywords:Counter>, triggers a maximum of 3 times per turn."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Deceased's Chrono+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Carrying memories and sorrow, moving toward the unknown."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "When \"Defense\" is played, gain [Arg1] Temporary<RetaliateIconKeywords:Counter>, triggers up to 3 times per turn."
  },
  RelicConfig_70800_Desc = {
    Text = "When \"Defense\" is played, gain [Arg1] Temporary <RetaliateIconKeywords:Counter>, triggers a maximum of 3 times per turn."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Deceased's Chrono>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Carrying memories and sorrow, moving toward the unknown."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd-numbered turns, choose 1 out of 2 Relics to gain, lasting for 5 odd-numbered turns."
  },
  RelicConfig_70986_Desc = {
    Text = "At the start of the battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd-numbered turns, choose 1 out of 2 Relics to gain, lasting for 5 odd-numbered turns."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "At the start of the battle, increase the Arithmetica Limit by 1 and Rouse all Awakener. At the start of odd-numbered turns, choose 1 out of 2 Relics to gain, lasting for 5 odd-numbered turns."
  },
  RelicConfig_70987_Desc = {
    Text = "At the start of the battle, increase Arithmetica Limit by 1 and Rouse all Awakeners. At the start of odd-numbered turns, choose 1 out of 2 Relics to gain, lasting for 5 odd-numbered turns."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Chrono Pendulum \"Wish ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "At turn start, Ramona: Timeworn gains [Arg1] Aliemus. The first time \"Loop\" is triggered each turn, gain [Arg2] Keyflare and [Arg3] stacks of \"Negentropy\"."
  },
  RelicConfig_71195_Desc = {
    Text = "At turn start, Ramona: Timeworn gains [Arg1] Aliemus. The first time \"Loop\" is triggered each turn, gain [Arg2] Keyflare and [Arg3] stacks of \"Negentropy\"."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Dimensional Image: Ramona: Timeworn>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "At turn start, Lotan gains [Arg1] Aliemus. After the first play of Lotan's \"Defense\" each turn, place [Arg2] additional Exhaust and Fleeting \"Blade of Defiance\" into hand."
  },
  RelicConfig_71196_Desc = {
    Text = "At turn start, Lotan gains [Arg1] Aliemus. After the first use of Lotan's \"Defense\" each turn, place [Arg2] additional Exhaust and Fleeting cards with the Illusion's \"Blade of Defiance\" into hand."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Dimensional Image: Lotan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "At turn start, Ramona gains [Arg1] Aliemus. Every [Arg2]th Command Card played by Ramona, that Command Card takes effect 1 additional time and gains [Arg3] Keyflare."
  },
  RelicConfig_71197_Desc = {
    Text = "At turn start, Ramona gains [Arg1] Aliemus. For every [Arg2]th Command Card played, that Command Card takes effect 1 additional time and gains [Arg3] Keyflare."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Dimensional Image: Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "At turn start, Leigh gains [Arg1] Aliemus. Whenever she loses HP, she gains [Arg2] STR, up to [Arg3] times per battle. After stacking [Arg3] times, the Arithmetica Cost of \"Pain and Pleasure\" is reduced by 2, and the DMG count is increased by 1."
  },
  RelicConfig_71230_Desc = {
    Text = "At the beginning of the turn, Leigh gains [Arg1] Aliemus. Whenever she loses HP, she gains [Arg2] STR, up to [Arg3] times per battle. After stacking [Arg3] times, the Arithmetica Cost of \"Pain and Pleasure\" is reduced by 2, and the DMG count is increased by 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Dimensional Image: Leigh>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "At turn start, Aurita gains [Arg1] Aliemus. The DMG count of \"Gland Division\" increases by [Arg2], and after playing Aurita's \"Defense\", 1 \"Gland Division\" is added to hand."
  },
  RelicConfig_71231_Desc = {
    Text = "At turn start, Aurita gains [Arg1] Aliemus. The DMG count of \"Gland Division\" increases by [Arg2], and after playing Aurita's \"Defense\", 1 \"Gland Division\" is added to hand."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Dimensional Image: Aurita>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "At turn start, Tinct gains [Arg1] Aliemus. After triggering a Leap with Tinct's Command Card, return it to hand and reduce its Arithmetica Cost by 1 before playing. This effect can occur a maximum of [Arg2] times per turn."
  },
  RelicConfig_71232_Desc = {
    Text = "At turn start, Tinct gains [Arg1] Aliemus. After triggering a Leap with Tinct's Command Card, return it to hand and reduce its Arithmetica Cost by 1. This effect can occur a maximum of [Arg2] times per turn."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Dimensional Image: Tinct>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "At turn start, Nautila gains [Arg1] Aliemus. After using Nautila's \"Exalt,\" gain Counter and Delayed Shield equal to [Arg2]% of the current Shield, triggering at most once per turn."
  },
  RelicConfig_71233_Desc = {
    Text = "At turn start, Nautila gains [Arg1] Aliemus. After using Nautila's \"Exalt,\" gain Counter and Delayed Shield equal to [Arg2]% of the current Shield, triggering at most once per turn."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Dimensional Image: Nautila>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "At turn start, Doll: Inferno gains [Arg1] Aliemus. After Doll: Inferno releases Exalt, for every [Arg2] Aliemus consumed, other Awakeners gain 1 Aliemus."
  },
  RelicConfig_71234_Desc = {
    Text = "At turn start, Doll: Inferno gains [Arg1] Aliemus. After Doll: Inferno unleashes Exalt, for every [Arg2] Aliemus consumed, other Awakeners gain 1 point of Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Dimensional Image: Doll: Inferno>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "At turn start, Helot gains [Arg1] Aliemus. Each time a card is discarded, Helot gains [Arg2] Aliemus."
  },
  RelicConfig_71235_Desc = {
    Text = "At turn start, Helot gains [Arg1] Aliemus. Each time a card is discarded, Helot gains [Arg2] Aliemus."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Dimensional Image: Helot>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "At turn start, Daffodil gains [Arg1] Aliemus and 1 \"Insight\" card. The Strength gained from \"Heterogeneous Tides\" increases by [Arg2]%, and each card played permanently increases it further by [Arg3]% for this exploration, up to [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "At turn start, Daffodil gains [Arg1] Aliemus and 1 \"Insight\" card. The Strength gained from \"Heterogeneous Tides\" increases by [Arg2]%, and each card played permanently increases it further by [Arg3]% for this exploration, up to [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Dimensional Image: Daffodil>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "At turn start, Wanda gains [Arg1] Aliemus and [Arg2] stacks of \"Dreamlure\". If this is an Ultra Round, additionally put 1 Temporary \"Spine Needle Chains\" and \"Keeper of the Lost\" into hand, and cause Wanda's next Command Card to take effect 2 times."
  },
  RelicConfig_71237_Desc = {
    Text = "At turn start, Wanda gains [Arg1] Aliemus and [Arg2] stacks of \"Dreamlure\". If this is an Ultra Round, additionally put 1 Temporary \"Spine Needle Chains\" and \"Keeper of the Lost\" into hand, and cause Wanda's next Command Card to take effect 2 times."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Dimensional Image: Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "At turn start, Agrippa gains [Arg1] Aliemus. \"Reluctant Alms\" also reduces Agrippa's Arithmetica Cost by [Arg2] for this turn, taking effect a maximum of once per turn."
  },
  RelicConfig_71238_Desc = {
    Text = "At turn start, Agrippa gains [Arg1] Aliemus. \"Reluctant Alms\" will also reduce Agrippa's Arithmetica Cost by [Arg2] for this turn, triggering a maximum of once per turn."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Dimensional Image: Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "At turn start, \"24\" gains [Arg1] Aliemus. If \"24\" is in the \"Depressed Persona\" state at turn start, it gains an additional [Arg2] Aliemus; if it is in the \"Manic Persona\" state, then \"24\"'s Temporary Crit. Rate and Temporary Crit. DMG are +[Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "At turn start, \"24\" gains [Arg1] Aliemus. If \"24\" is in the \"Depressed Persona\" state at turn start, it gains an additional [Arg2] Aliemus; if it is in the \"Manic Personality\" state, then \"24\"'s Temporary Crit. Rate and Temporary Crit. DMG +[Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Dimensional Image: \"24\">"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "At turn start, Liz gains [Arg1] Aliemus. Cards discarded by \"Dance to Destruction\" takes effect 1 more time, with a 3-turn cooldown."
  },
  RelicConfig_71240_Desc = {
    Text = "At turn start, Liz gains [Arg1] Aliemus. Cards discarded by \"Dance to Destruction\" takes effect 1 more time, with a 3-turn cooldown."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Dimensional Image: Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "At turn start, Helot: Catena gains [Arg1] Aliemus. Helot: Catena's Active DMG adds [Arg2]% Bleed, and killing an enemy causes other enemies to take Bleed equal to the excess DMG."
  },
  RelicConfig_71241_Desc = {
    Text = "At turn start, Helot: Catena gains [Arg1] Aliemus. Helot: Catena's Active DMG adds [Arg2]% Bleeding, and killing an enemy causes Bleeding equal to the excess DMG to other enemies."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Dimensional Image: Helot: Catena>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "At turn start, Celeste gains [Arg1] Aliemus. Before the turn ends, for each Command Card of Celeste in hand, 1 Tentacle attacks an enemy and restores [Heal:Arg2] HP."
  },
  RelicConfig_71242_Desc = {
    Text = "At turn start, Celeste gains [Arg1] Aliemus. Before turn end, for each Command Card of Celeste in hand, 1 Tentacle attacks an enemy and restores [Heal:Arg2] HP."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Dimensional Image: Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_71243_Desc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Dimensional Image: Casiah>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "At turn start, Sorel gains [Arg1] Aliemus. For each instance of DMG dealt by Sorel, Embryo Fusion increases by +[Arg2]%, up to [Arg3] times per turn. After triggering 10 times, Sorel's Final DMG in this battle increases by [Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "At turn start, Sorel gains [Arg1] Aliemus. For each instance of DMG dealt by Sorel, Embryo Fusion increases by +[Arg2]%, up to [Arg3] times per turn. After triggering 10 times, Sorel's Final DMG in this battle increases by [Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Dimensional Image: Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "At turn start, Ogier gains [Arg1] Aliemus. After the first time Ogier plays \"Piercing Strike\" or \"Strike\" in each turn, the Shield and STR Ogier generates in that turn +[Arg2]%."
  },
  RelicConfig_71245_Desc = {
    Text = "At turn start, Ogier gains [Arg1] Aliemus. After the first time Ogier plays \"Piercing Strike\" or \"Strike\" in each turn, the Shield and STR Ogier generates in that turn +[Arg2]%."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Dimensional Image: Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "At turn start, Alva gains [Arg1] Aliemus. Within 1 turn, after playing the [Arg2]th \"Defense\" card, place a consumed \"Precision Slash\" into hand; after playing the [Arg3]th \"Strike\" card, place a consumed \"Combat Stance\" into hand."
  },
  RelicConfig_71246_Desc = {
    Text = "At turn start, Alva gains [Arg1] Aliemus. Within 1 turn, after playing the [Arg2]th \"Defense\" card, place a \"Precision Slash\" with Exhaust into hand; after playing the [Arg3]th \"Strike\" card, place a \"Combat Stance\" with Exhaust into hand."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Dimensional Image: Alva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "At turn start, Jenkin gains [Arg1] Aliemus, with Final DMG +[Arg2]%. The Base DMG and DMG growth of \"Get 'em! Brown!\" are +[Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "At turn start, Jenkin gains [Arg1] Aliemus, with Final DMG +[Arg2]%. The Base DMG and DMG growth of \"Get 'em! Brown!\" are +[Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Dimensional Image: Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "At turn start, Doll gains [Arg1] Aliemus. After the battle starts, set the Arithmetica Cost of Doll's \"Equivalent Exchange\" to 0. After it is played, draw [Arg2] additional cards in the next turn."
  },
  RelicConfig_71248_Desc = {
    Text = "At turn start, Doll gains [Arg1] Aliemus. After the battle starts, set the Arithmetica Cost of Doll's \"Equivalent Exchange\" to 0. Once it is played, draw [Arg2] extra cards in the next turn."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Dimensional Image: Doll>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "At turn start, Ryker gains [Arg1] Aliemus. The result of the first dice roll each turn is always 6."
  },
  RelicConfig_71249_Desc = {
    Text = "At turn start, Ryker gains [Arg1] Aliemus. The result of the first dice roll each turn is always 6."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Dimensional Image: Ryker>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "At turn start, Miryam gains [Arg1] Aliemus and puts 1 \"Sacrament\" into hand."
  },
  RelicConfig_71250_Desc = {
    Text = "At turn start, Miryam gains [Arg1] Aliemus and puts 1 \"Sacrament\" into hand."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Dimensional Image: Miryam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "At turn start, Winkle gains [Arg1] Aliemus. Each time another Awakeners unleashes Exalt, Winkle gains [Arg2] Aliemus, and the Arithmetica Cost of \"Psyche Reforged\" in hand is reduced by [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "At turn start, Winkle gains [Arg1] Aliemus. Each time another Awakeners unleashes Exalt, Winkle gains [Arg2] Aliemus, and the Arithmetica Cost of \"Psyche Reforged\" in hand is reduced by [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Dimensional Image: Winkle>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "At turn start, Tulu gains [Arg1] Aliemus. Tulu's Base Aliemus -[Arg2], and after releasing Exalt, it instantly generates [Arg3] Temporary Tentacles."
  },
  RelicConfig_71252_Desc = {
    Text = "At turn start, Tulu gains [Arg1] Aliemus. Tulu's Base Aliemus -[Arg2], and after releasing Exalt, it instantly generates [Arg3] Temporary Tentacles."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Dimensional Image: Tulu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "At turn start, Faint gains [Arg1] Aliemus. Faint's Shield Generation, Counter, and HP recovery +[Arg2]%. Each time Death Resistance is triggered, this effect increases by [Arg3]% for the current exploration, up to [Arg4] times."
  },
  RelicConfig_71253_Desc = {
    Text = "At turn start, Faint gains [Arg1] Aliemus. Faint's Shield, Counter, and HP recovery effects +[Arg2]%. Each time Death Resistance is triggered, this effect increases by [Arg3]% for the current exploration, up to [Arg4] times."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Dimensional Image: Faint>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "At turn start, Tawil gains [Arg1] Aliemus. If [Arg2] of Tawil's Command Cards are played in one turn, add 1 <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Silver Key Dawn\">> to hand. Cooldown: [Arg3] turns."
  },
  RelicConfig_71254_Desc = {
    Text = "At turn start, Tawil gains [Arg1] Aliemus. If [Arg2] of Tawil's Command Cards are played in one turn, add 1 <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Silver Key Dawn\">> to hand, cooldown [Arg3] turns."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Dimensional Image: Tawil>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Dimensional Image: Hameln>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "At turn start, Horla gains [Arg1] Aliemus. At the start of the battle, gain [Arg2] stacks of \"Metaphor\" for all emotions, increasing the \"Metaphor\" effect by 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "At turn start, Horla gains [Arg1] Aliemus. At the start of the battle, gain [Arg2] stacks of \"Metaphor\" for all emotions, increasing the \"Metaphor\" effect by 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Dimensional Image: Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "At turn start, Murphy gains [Arg1] Aliemus. Murphy's \"Strike\" and \"Defense\" can convert [Arg2]% of the \"Sacrifice\" into Temporary Tentacle DMG, but can only take effect once per turn."
  },
  RelicConfig_71257_Desc = {
    Text = "At turn start, Murphy gains [Arg1] Aliemus. Murphy's \"Strike\" and \"Defense\" can convert [Arg2]% of the \"Sacrifice\" into Temporary Tentacle DMG, but can only take effect once per turn."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Dimensional Image: Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "At turn start, Uvhash gains [Arg1] Aliemus. Uvhash's Base Aliemus -[Arg2], which further reduces by 5 every time he releases Exalt. He can release Exalt [Arg3] times per turn."
  },
  RelicConfig_71258_Desc = {
    Text = "At turn start, Uvhash gains [Arg1] Aliemus. Uvhash's Base Aliemus -[Arg2], which further reduces by 5 every time he releases Exalt. He can release Exalt [Arg3] times per turn."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Dimensional Image: Uvhash>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "At turn start, Aigis gains [Arg1] Aliemus. When Aigis deals DMG to enemies with Vulnerable, she also steals [Arg2] Temporary STR, up to [Arg3] times per turn."
  },
  RelicConfig_71259_Desc = {
    Text = "At turn start, Aigis gains [Arg1] Aliemus. When Aigis deals DMG to enemies with Vulnerable, she also steals [Arg2] Temporary STR, up to [Arg3] times per turn."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Dimensional Image: Aigis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "At turn start, Thais gains [Arg1] Aliemus. After playing [Arg2] Command Cards within 1 turn, Thais gains a \"Scion of Purity\" and [Arg3] Temporary STR, with a [Arg4]-turn cooldown."
  },
  RelicConfig_71260_Desc = {
    Text = "At turn start, Thais gains [Arg1] Aliemus. After playing [Arg2] Command Cards in one turn, Thais gains 1 \"Scion of Purity\" and [Arg3] Temporary STR, with a cooldown of [Arg4] turns."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Dimensional Image: Thais>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "At turn start, Faros gains [Arg1] Aliemus. For every 2 instances of Tentacle DMG dealt, Faros' Poison and Shield Generation in this battle +[Arg2]%, up to 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "At turn start, Faros gains [Arg1] Aliemus. For every 2 instances of Tentacle DMG dealt, Faros' Poison and Shield effects in this battle +[Arg2]%, up to 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Dimensional Image: Faros>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "At turn start, Pandia gains [Arg1] Aliemus. After Pandia performs an Exalt, she gains Permanent Counter equivalent to [Arg2]% of her Temporary Counter."
  },
  RelicConfig_71262_Desc = {
    Text = "Pandia gains [Arg1] Aliemus at turn start. After Pandia uses her Exalt, she gains Permanent Counter equal to [Arg2]% of her Temporary Counter."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Dimensional Image: Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "At turn start, Lily gains [Arg1] Aliemus. Lily's Endure limit increases by 100%, and when releasing \"Undying Flower Upon Slime\" or \"Strike to Protect\", Lily restores HP equal to 8% of the \"Endure\" stacks."
  },
  RelicConfig_71263_Desc = {
    Text = "At turn start, Lily gains [Arg1] Aliemus. Lily's Endure limit increases by 100%, and when releasing \"Undying Flower Upon Slime\" or \"Strike to Protect\", Lily restores HP equal to 8% of the \"Endure\" stacks."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Dimensional Image: Lily>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "At turn start, Karen gains [Arg1] Aliemus. Playing \"Silent Fealty\" will return double the consumed Arithmetica, with a cooldown of [Arg2] turns."
  },
  RelicConfig_71264_Desc = {
    Text = "At turn start, Karen gains [Arg1] Aliemus. Playing \"Silent Fealty\" will return double the exhausted Arithmetica, with a cooldown of [Arg2] turns."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Dimensional Image: Karen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "At turn start, Salvador gains [Arg1] Aliemus. Each time he accumulates Crimson Furnace, he also gains STR equal to [Arg2]% of the accumulated amount. Salvador's \"Strike\" and \"End of Suffering\" additionally enjoys a [Arg3]x STR bonus."
  },
  RelicConfig_71265_Desc = {
    Text = "At turn start, Salvador gains [Arg1] Aliemus. Each time he accumulates Crimson Furnace, he also gains [Arg2]% STR of the accumulated amount. Salvador's \"Strike\" and \"End of Suffering\" additionally receive a [Arg3]x STR bonus."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Dimensional Image: Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "At turn start, Caecus gains [Arg1] Aliemus. When Caecus gains a shield, he regains [Arg2]% of the Shield amount as HP."
  },
  RelicConfig_71266_Desc = {
    Text = "At turn start, Caecus gains [Arg1] Aliemus. When Caecus gains a Shield, he regains [Arg2]% of the Shield amount as HP."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Dimensional Image: Caecus>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "At turn start, Nymphaea gains [Arg1] Aliemus. After playing Nymphaea's \"Strike\", the Poison dealt by \"Nymphaea\" in this battle increases by [Arg2]%. After playing Nymphaea's \"Defense\", it triggers [Arg3]% Poison to all enemies. Each effect can take place at most once per turn."
  },
  RelicConfig_71267_Desc = {
    Text = "At turn start, Nymphaea gains [Arg1] Aliemus. After playing Nymphaea's \"Strike\", the Poison dealt by \"Nymphaea\" in this battle increases by [Arg2]%. After playing Nymphaea's \"Defense\", it triggers [Arg3]% Poison to all enemies. Each effect can take place at most once per turn."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Dimensional Image: Nymphaea>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "At turn start, Erica gains [Arg1] Aliemus. After playing [Arg2] Command Cards within 1 turn, Erica gains 2 Arithmetica and doubles the STR and Alert bonus for \"Electromagnetic Blast\" in this battle."
  },
  RelicConfig_71268_Desc = {
    Text = "At turn start, Erica gains [Arg1] Aliemus. After playing [Arg2] Command Cards within 1 turn, Erica gains 2 Arithmetica and doubles the STR and Alert bonuses for \"Electromagnetic Blast\" in this battle."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Dimensional Image: Erica>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "At turn start, Goliath gains [Arg1] Aliemus. If Goliath deals DMG [Arg2] times within 1 turn, the DMG dealt by Goliath in this battle enjoys an additional 1x STR bonus with a 3-turn cooldown."
  },
  RelicConfig_71269_Desc = {
    Text = "At turn start, Goliath gains [Arg1] Aliemus. If Goliath deals DMG [Arg2] times within 1 turn, the DMG dealt by Goliath in this battle enjoys an additional 1x STR bonus, with a cooldown of 3 turns."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Dimensional Image: Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "At turn start, Sanga gains [Arg1] Aliemus. At the start of the battle, grant all of Sanga's Command Cards Retain, Prepare 1, and gain [Arg2] Shield."
  },
  RelicConfig_71270_Desc = {
    Text = "At turn start, Sanga gains [Arg1] Aliemus. At the start of the battle, grant all of Sanga's Command Cards Retain and Prepare 1, and gain [Arg2] Shield."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Dimensional Image: Sanga>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "At the start of even-numbered turns, put 1 <DerivativeCardKeywords_105:Infinite Silver Vault> into hand."
  },
  RelicConfig_71662_Desc = {
    Text = "At the start of even-numbered turns, put 1 <DerivativeCardKeywords_105:\"Infinite Silver Vault> into hand."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Cat's Treasure>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Hand Limit +1. At turn start, if no Research has been conducted, choose an untried Research. Upon completion, gain the corresponding Research result of Doll: Inferno. After completing 3 Researches, place \"Illusion's End\" into hand; this Relic becomes inactive."
  },
  RelicConfig_72226_Desc = {
    Text = "Hand Limit +1. At turn start, if no Research has been conducted, choose an untried Research. Upon completion, gain the corresponding Research result from Doll: Inferno. After completing 3 Researches, place \"Illusion's End\" into hand; this Relic becomes inactive."
  },
  RelicConfig_72226_Name = {
    Text = "Finale Research Manuscript"
  },
  RelicConfig_74832_BattleDesc = {
    Text = [[
Hand Limit +1. Create a customized "Taboo Trade" at the start of battle. Play "Taboo Trade" to create another on your next turn.
"Taboo Trade" has 4 Arithmetica Cost, Retain, Prepare, & Exhaust, and has 3 custom effects. Playing "Strike", "Defense", or "Skill" Command Cards will enhance its 1st, 2nd, or 3rd effects respectively.]]
  },
  RelicConfig_74832_Desc = {
    Text = [[
Hand Limit +1. Create a customized "Taboo Trade" at the start of battle. Play "Taboo Trade" to create another on your next turn.
"Taboo Trade" has 4 Arithmetica Cost, Retain, Prepare, & Exhaust, and has 3 custom effects. Playing "Strike", "Defense", or "Skill" Command Cards will enhance its 1st, 2nd, or 3rd effects respectively.]]
  },
  RelicConfig_74832_Name = {
    Text = "Shapeshifter's Invitation"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "The words on the letter kept changing, always transforming into an irresistible desire."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "When you play 4 Command Cards from different Awakeners in a single turn, increase all Awakeners' Final DMG dealt this turn by [Arg1]%, and lose [Arg2] Aliemus. This effect can only trigger once per turn."
  },
  RelicConfig_78664_Desc = {
    Text = "When you play 4 Command Cards belonging to different Awakeners within a single turn, increase the Final DMG dealt by all Awakeners this turn by [Arg1]%, and lose [Arg2] Aliemus. This can only be triggered once per turn."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Eerie Hook>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Species that are difficult to identify."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "At turn start, draw [Arg1] fewer cards. Gain 1 Arithmetica for each card played that cost >= [Arg2] Arithmetica, up to [Arg3] times per turn."
  },
  RelicConfig_78665_Desc = {
    Text = "At turn start, draw [Arg1] less cards. Gain 1 Arithmetica for each Card played with Arithmetica Cost >= [Arg2], triggering up to [Arg3] times per turn."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Wailing Bell>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = [[
Ding, ding, the child is crying;
Ding, ding, the child is screaming.
Ding, ding, the child is wailing;
Ding, ding, it's hungry, you know.]]
  },
  RelicConfig_78666_BattleDesc = {
    Text = "At turn start, gain [Arg1] Counter. After using Exalt [Arg2] times in one turn, remove [Arg3]% of Permanent Counter and gain [Arg4]% of the removed amount as Temporary Counter. Cooldown: [Arg5] turns."
  },
  RelicConfig_78666_Desc = {
    Text = "At turn start, gain [Arg1] Counter. After using Exalt [Arg2] times in one turn, remove [Arg3]% Permanent Counter, and gain [Arg4]% of the removed amount as Temporary Counter. Cooldown: [Arg5] turns."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Pathwalker's Remains>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = [[
A sacred part.
Even though it has separated from the body, its footprints have spread across the world.]]
  },
  RelicConfig_78667_BattleDesc = {
    Text = "After the draw phase, draw [Arg1] additional cards and choose [Arg2] cards from your hand to discard."
  },
  RelicConfig_78667_Desc = {
    Text = "After the draw phase, draw [Arg1] additional cards and choose [Arg2] cards from your hand to discard."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:Trickster's Hat>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = [[
Welcome to Miss Casiah's Wonderland Circus! Be careful, don't touch the magic items. If you get bitten, it could be bad.
Last time it tasted blood, the outcome was terrible.

The top hat winked as if ready to emerge.]]
  },
  RelicConfig_78668_BattleDesc = {
    Text = "After using Keyflare Rouse, choose [Arg1] Non-Derived Command Card corresponding to that Awakener in your hand. Exhaust that card to place [Arg2] Base Copy of it into the Draw Pile, hand, and Discard Pile respectively."
  },
  RelicConfig_78668_Desc = {
    Text = "After using Keyflare Rouse, choose [Arg1] Non-Derived Command Card corresponding to that Awakener in your hand. Exhaust that card to place [Arg2] Base Copy of it into the Draw Pile, hand, and Discard Pile respectively."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Jade Imprint>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "This imprint endures for millennia without decay."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Gain [Arg1] Strength at the start of the battle. At turn start, for every [Arg2] permanent STR, gain [Arg3] Temporary STR, up to [Arg4] Temporary STR, and lose Shield equals to half of the Temporary STR gained by that Relic at turn end."
  },
  RelicConfig_78669_Desc = {
    Text = "Gain [Arg1] Strength at the start of the battle. At turn start, for each [Arg2] Permanent STR, gain [Arg3] Temporary STR, up to [Arg4] Temporary STR, and lose Shield equals to half of the Temporary STR gained by that Relic at turn end."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Omen Ritual Bird>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "The withered corpse let out a screech."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "All Awakeners' Base DMG is +[Arg1]%. Each time the deck is reset, an additional [Arg2]% is granted, but 1 \"Stagger\" card is added to your hand. The maximum increase is [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Increase all Awakeners' Base DMG by [Arg1]%. Each time the deck is reset, an additional [Arg2]% is granted, but a \"Stagger\" card is added to your hand. The maximum increase is [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Black Candle>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Burn in clarity, fall into illusion."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "At turn start, Embryo Fusion Level +[Arg1]%. Your \"Embryo\" will be discarded at turn end."
  },
  RelicConfig_78671_Desc = {
    Text = "Embryo Fusion Level increases by [Arg1]% at the start of your turn, and your \"Embryo\" will be discarded at turn end."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Wriggling Cord>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Entwine the neck."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "At turn start, gain [Arg1] STR for every 1 vacant space in Ultra Space, but suffer [Arg2] stacks of Poison."
  },
  RelicConfig_78672_Desc = {
    Text = "At turn start, gain [Arg1] STR for every 1 vacant space in Ultra Space, but suffer [Arg2] stacks of Poison."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Swarm Mind>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Entwine, Symbiosis, Swarm; Fear, Unknown, Control."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "After Keyflare Rouse, additionally consumes [Arg1] Keyflare to make the Arithmetica Cost of gained Rouse cards 0. Playing it causes the corresponding Awakener to additionally gain [Arg2] Aliemus."
  },
  RelicConfig_78673_Desc = {
    Text = "After using Keyflare Rouse, consume an additional [Arg1] Keyflare, reducing the Arithmetica Cost of the received Rouse card to 0. Upon playing, the corresponding Awakener gains an additional [Arg2] Aliemus."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Mind Engraving>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "The ancient tribe believed that engraving special symbols on the skulls of the dead could keep their souls for eternal companionship."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "At the start of the battle, inflict [Arg1] Poison on all enemies. At turn start, remove [Arg2]% of the enemy's Poison and apply [Arg3]% of the removed amount as Bleed."
  },
  RelicConfig_78674_Desc = {
    Text = "At the start of the battle, inflict [Arg1] Poison on all enemies. At turn start, remove [Arg2]% of the enemy's Poison and inflict [Arg3]% of the removed amount as Bleeding."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Salvific Limb>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = [[
A sacred part.
Even when separated from the body, its warmth can still be felt.]]
  },
  RelicConfig_78675_BattleDesc = {
    Text = "At turn start, if there are more than [Arg1] Permanent Tentacles, lose [Arg2] Tentacles to gain [Arg3] Temporary Tentacles. Otherwise, gain [Arg4] Permanent Tentacles."
  },
  RelicConfig_78675_Desc = {
    Text = "At turn start, if there are more than [Arg1] Permanent Tentacles, lose [Arg2] Tentacles to gain [Arg3] Temporary Tentacles, otherwise gain [Arg4] Permanent Tentacles."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Sacred Agony>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Embrace the agony."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Hand Limit +2, Draw +2. \"Clear Memory\" starts at 5 stacks. Playing marked cards changes the \"Clear Memory\". When \"Clear Memory\" is below 5, each reduction by 1 increases Final DMG by 10%, reduces Shield and HP Recovery by 5%; when above 5, each increase by 1 boosts Shield and Healing by 5%, reduces Final DMG by 10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Hand size limit +2, draw +2 cards. \"Clear Memory\" starts at 5 stacks, playing marked cards changes the \"Clear Memory\". When \"Clear Memory\" is below 5, each reduction by 1 increases Final DMG by 10%, reduces Shield and HP recovery by 5%; when above 5, every stack increases Shield and HP Recovery by 5%, reduces Final DMG by 10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Memory\" and \"Dream\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = [[
"Come, listen to me."
"Let me transform your memories and dreams."
"Into an incredibly delicious dessert."]]
  },
  RelicConfig_80340_BattleDesc = {
    Text = "At turn start, Clementine gains [Arg1] Aliemus. The number of times Clementine's Command Cards deal DMG, generate Shield, recover HP, gain Aliemus, and gain Keyflare increases by 1."
  },
  RelicConfig_80340_Desc = {
    Text = "At the start of turn, Clementine gains [Arg1] Aliemus. Clementine's Command Cards' DMG dealt, Shield Generation, HP Recovery, Aliemus Generation, and Keyflare Generation effects increase by 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Dimensional Image: Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "At the start of exploration, relic capacity +1, and the \"Aequor\" Awakener gains its \"Dimensional Image\". For each \"Aequor\" Awakener in the team, Relic Capacity +1."
  },
  RelicConfig_83509_Desc = {
    Text = "At the start of exploration, increase the Relic Capacity by +1, and \"Aequor\" Awakener gains their \"Dimensional Image\". For each \"Aequor\" Awakener in the team, increase the Relic Capacity by +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Aequor Ring\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "The sleepers in the abyssal ocean begin to show the forgotten authority to the world."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "At the start of exploration, Relic Capacity +1, and the \"Caro\" Awakener gains its \"Dimensional Image\". For each \"Caro\" Awakener in the team, relic capacity +1."
  },
  RelicConfig_83510_Desc = {
    Text = "At the start of exploration, increase the Relic Capacity by +1, and \"Caro\" Awakener gains its \"Dimensional Image\". For each \"Caro\" Awakener in the team, increase the Relic Capacity by +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Caro Ring\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "From unyielding suffering, ascension has been achieved."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "At the start of exploration, Relic Capacity +1, and the \"Ultra\" Awakener gains its \"Dimensional Image\". For each \"Ultra\" Awakener in the team, relic capacity +1."
  },
  RelicConfig_83511_Desc = {
    Text = "At the start of exploration, increase the Relic Capacity by +1, and \"Ultra\" Awakener gains its \"Dimensional Image\". For each \"Ultra\" Awakener in the team, increase the Relic Capacity by +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Ultra Ring\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Endless dimensions overlapped, at this moment \"I\" am infinitely complete."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "At the start of exploration, relic capacity +1, and the \"Chaos\" Awakener gains its \"Dimensional Image\". For each \"Chaos\" Awakener in the team, Relic Capacity +1."
  },
  RelicConfig_83512_Desc = {
    Text = "At the start of exploration, increase the Relic Capacity by +1, and \"Chaos\" Awakener gains its \"Dimensional Image\". For each \"Chaos\" Awakener in the team, increase the Relic Capacity by +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Chaos Ring\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Chaos is formless, chaos is intangible; chaos has merged into all things."
  },
  RelicConfig_83606_BattleDesc = {
    Text = [[
Hand Limit +1. At turn start, if "Navigator's Choice" is not in hand, place it there.
Each time the Leader loses 10% of their initial Max HP, gain 1 stack of "Set Sail", up to 10 stacks. "Set Sail" enhances the effects of "Archor Off".
Each time you lose 10% of your initial Max HP, gain 1 stack of "Moored Off", up to 10 stacks. "Moored Off" enhances the effects of "Harbored Rest".]]
  },
  RelicConfig_83606_Desc = {
    Text = [[
Hand limit +1. At the start of turn, if there is no "Navigator's Choice", place it in hand.
Each time the Boss loses 10% of their initial Max HP, gain 1 stack of "Set Sail", max 10 stacks. "Set Sail" enhances the effects of "Archor Off".
Each time you lose 10% of your initial Max HP, gain 1 stack of "Moored Off", max 10 stacks. "Moored Off" enhances the effects of "Harbored Rest".]]
  },
  RelicConfig_83606_Name = {
    Text = "Guidance of Erasmus"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "The flickering lightning will guide the direction forward."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "At turn start, Agrippa gains [Arg1] Aliemus. \"Reluctant Alms\" also reduces Agrippa's Arithmetica Cost by [Arg2] for this turn, taking effect a maximum of once per turn."
  },
  RelicConfig_84112_Desc = {
    Text = "At turn start, Agrippa gains [Arg1] Aliemus. \"Reluctant Alms\" will also reduce Agrippa's Arithmetica Cost by [Arg2] for this turn, triggering a maximum of once per turn."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Dimensional Image: Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "At turn start, Sorel gains [Arg1] Aliemus. For each instance of DMG dealt by Sorel, Embryo Fusion increases by +[Arg2]%, up to [Arg3] times per turn. After triggering 10 times, Sorel's Final DMG in this battle increases by [Arg4]%."
  },
  RelicConfig_84113_Desc = {
    Text = "At turn start, Sorel gains [Arg1] Aliemus. For each instance of DMG dealt by Sorel, Embryo Fusion increases by +[Arg2]%, up to [Arg3] times per turn. After triggering 10 times, Sorel's Final DMG in this battle increases by [Arg4]%."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Dimensional Image: Sorel>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "At the start of the turn, Pickman gains [Arg1] Aliemus. For each stack of \"Creativity\" gained, randomly reduce the Arithmetica Cost of 1 card in hand by 1 for this turn. When Pickman consumes \"Creativity\", all Awakeners additionally gain [Arg2] Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "At the start of the turn, Pickman gains [Arg1] Aliemus. For each stack of \"Creativity\" gained, randomly reduce the Arithmetica Cost of 1 card in hand by 1 for this turn. When Pickman consumes \"Creativity\", all Awakeners additionally gain [Arg2] Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Dimensional Image: Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "At turn start, Erica gains [Arg1] Aliemus. After playing [Arg2] Command Cards within 1 turn, Erica gains 2 Arithmetica and doubles the STR and Alert bonus for \"Electromagnetic Blast\" in this battle."
  },
  RelicConfig_84116_Desc = {
    Text = "At turn start, Erica gains [Arg1] Aliemus. After playing [Arg2] Command Cards within 1 turn, Erica gains 2 Arithmetica and doubles the STR and Alert bonuses for \"Electromagnetic Blast\" in this battle."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Dimensional Image: Erica>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "At turn start, Murphy: Fauxborn gains [Arg1] Aliemus. \"Waltz of Lemuria\" takes effect 3 times every 3rd play."
  },
  RelicConfig_84117_Desc = {
    Text = "At turn start, Murphy: Fauxborn gains [Arg1] Aliemus. \"Waltz of Lemuria\" takes effect 3 times every 3rd play."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Dimensional Image: Murphy: Fauxborn>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_84118_Desc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Dimensional Image: Casiah>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "At turn start, Murphy gains [Arg1] Aliemus. Murphy's \"Strike\" and \"Defense\" can convert [Arg2]% of the \"Sacrifice\" into Temporary Tentacle DMG, but can only take effect once per turn."
  },
  RelicConfig_84119_Desc = {
    Text = "At turn start, Murphy gains [Arg1] Aliemus. Murphy's \"Strike\" and \"Defense\" can convert [Arg2]% of the \"Sacrifice\" into Temporary Tentacle DMG, but can only take effect once per turn."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Dimensional Image: Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "At turn start, Jenkin gains [Arg1] Aliemus, with Final DMG +[Arg2]%. The Base DMG and DMG growth of \"Get 'em! Brown!\" are +[Arg3]%."
  },
  RelicConfig_84121_Desc = {
    Text = "At turn start, Jenkin gains [Arg1] Aliemus, with Final DMG +[Arg2]%. The Base DMG and DMG growth of \"Get 'em! Brown!\" are +[Arg3]%."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Dimensional Image: Jenkin>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "At turn start, Tulu gains [Arg1] Aliemus. Tulu's Aliemus Cost is reduced by [Arg2], and after releasing Exalt, instantly generate [Arg3] Temporary Tentacles."
  },
  RelicConfig_84122_Desc = {
    Text = "At turn start, Tulu gains [Arg1] Aliemus. The Aliemus Cost for Tulu is reduced by [Arg2], and after releasing Exalt, it instantly generates [Arg3] Temporary Tentacles."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Dimensional Image: Tulu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "At turn start, Pollux gains [Arg1] Aliemus. At the start of the battle, gain 1 \"Sacred Heart\". When Exhausted at its 3rd use, \"Sacred Heart\" inflicts Vulnerable on all enemies and deal DMG twice."
  },
  RelicConfig_84123_Desc = {
    Text = "At turn start, Pollux gains [Arg1] Aliemus. At the start of the battle, gain 1 \"Sacred Heart\". When Exhausted at its 3rd use, \"Sacred Heart\" inflicts Vulnerable on all enemies and deal DMG twice."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Dimensional Image: Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "At turn start, Hameln gains [Arg1] Aliemus. The Arithmetica Cost of \"Soul Overture\" is reduced by [Arg2], and the Base DMG count is +[Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Dimensional Image: Hameln>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "At turn start, Kathigu-Ra gains [Arg1] Aliemus. After accumulating 10 stacks of \"Fiamma\", immediately draw 1 Kathigu-Ra's Command Card and grant it 3 stacks of \"Fiamma\". This effect will not accumulate stacks for the rest of this turn."
  },
  RelicConfig_84125_Desc = {
    Text = "At turn start, Kathigu-Ra gains [Arg1] Aliemus. After accumulating 10 stacks of \"Fiamma\", immediately draw 1 Kathigu-Ra's Command Card and grant it 3 stacks of \"Fiamma\". This effect will not accumulate stacks for the rest of this turn."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Dimensional Image: Kathigu-Ra>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "At turn start, Castor gains [Arg1] Aliemus. At the start of battle, place 2 \"Onyx Plume\" into hand. Gain [Arg2] Temporary STR after playing \"Onyx Plume\" for the first time each turn."
  },
  RelicConfig_84126_Desc = {
    Text = "At turn start, Castor gains [Arg1] Aliemus. Place 2 \"Onyx Plume\" into hand at the start of battle. Gain [Arg2] Temporary STR when \"Onyx Plume\" is played for the first time each turn."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Dimensional Image: Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "At turn start, Corposant gains [Arg1] Aliemus and gains 1 Temporary Tentacle. Whenever Death Resistance is triggered, Corposant gains [Arg2] Aliemus, and places 1 \"Lightning Retribution\" with 0 Arithmetica Cost and Exhaust into hand."
  },
  RelicConfig_84127_Desc = {
    Text = "At the start of turn, Corposant gains [Arg1] Aliemus and gains 1 Temporary Tentacle. Whenever Death Resistance is triggered, Corposant gains [Arg2] Aliemus and places 1 \"Lightning Retribution\" with Exhaust and 0 Arithmetica Cost into hand."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Dimensional Image: Corposant>"
  },
  RelicConfig_84129_BattleDesc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_84129_Desc = {
    Text = "At turn start, Casiah gains [Arg1] Aliemus. Drawing 1 card grants Casiah [Arg2] Aliemus. When Casiah unleashes Exalt, all enemies lose [Arg3] STR."
  },
  RelicConfig_84129_Name = {
    Text = "<OrangeQuality:Dimensional Image: Casiah>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = [[
Arithmetica Limit increased by 1, draw 1 extra card per turn, and at the start of the battle, gain [Arg1] stacks of "Fateful Cage" count.
Each stack of "Fateful Cage" reduces all Awakeners' Aliemus by [Arg2]%, and with each Exalt release, decrease 1 stack of "Fateful Cage." After all "Fateful Cages" are removed, all Awakeners gain [Arg3] Aliemus, gaining "Unyielding Heart": all Awakeners' Aliemus +[Arg4]%, and Exalt can be released twice per turn.]]
  },
  RelicConfig_89252_Desc = {
    Text = [[
Arithmetica Limit increased by 1, draw 1 extra card per turn, and at the start of the battle, gain [Arg1] stacks of "Fateful Cage" count.
Each stack of "Fateful Cage" reduces all Awakeners' Aliemus by [Arg2]%, and with each Exalt release, decrease 1 stack of "Fateful Cage." After all "Fateful Cages" are removed, all Awakeners gain [Arg3] Aliemus, gaining "Unyielding Heart": all Awakeners' Aliemus +[Arg4]%, and Exalt can be released twice per turn.]]
  },
  RelicConfig_89252_Name = {
    Text = "Cursed Feather"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Now, this feather can no longer soar in the sky."
  },
  RelicConfig_89645_BattleDesc = {
    Text = [[
Hand Limit +2, after Exalt, Temporary Final DMG increases by 10%.
After the card enters Ultra Space, 1 "Embryo" in hand transforms into "Scion of Purity".
Every time 1 "Embryo" is generated, the Arithmetica Cost of a random card in Ultra Space decreases by 1.]]
  },
  RelicConfig_89645_Desc = {
    Text = [[
Hand Limit +2, after Exalt, Temporary Final DMG increases by 10%.
After the card enters the Ultra Space, 1 "Embryo" in hand transforms into "Scion of Purity".
Every time 1 "Embryo" is generated, the cost of a random card in the Ultra Space decreases by 1.]]
  },
  RelicConfig_89645_Name = {
    Text = "Hyperstring Blood Rot Serum"
  },
  RelicConfig_89646_BattleDesc = {
    Text = [[
Obtain 250 Keyflare at turn start.
After using Keyflare Rouse, place 1 <DerivativeCardKeywords_129:"Silver Key Gleam"> into hand.
Discover 1 Awakener Support card at turn start.]]
  },
  RelicConfig_89646_Desc = {
    Text = [[
Obtain 250 Keyflare at turn start.
After using Keyflare Rouse, place 1 <DerivativeCardKeywords_129:"Silver Key Gleam"> into hand.
Discover 1 Awakener Support card at turn start.]]
  },
  RelicConfig_89646_Name = {
    Text = "Unified Evolution Reagent"
  },
  RelicConfig_89647_BattleDesc = {
    Text = [[
The first Command Card each Turn takes effect 1 additional time.
Generate 1 Tentacle when Annihilation occurs.
After switching the Tentacle into "Raging Waves" stance, the next Command Card's Leap effect is guaranteed to activate and place its 2 Base Copies into Ultra Space, with a 3-Turn cooldown.]]
  },
  RelicConfig_89647_Desc = {
    Text = [[
The first Command Card each turn takes effect 1 additional time.
When Annihilation occurs, generate 1 Tentacle.
After switching the Tentacle into "Raging Waves" stance, the next Command Card's Leap effect is guaranteed to activate and place its 2 Base Copies into Ultra Space, with a 3-turn Cooldown.]]
  },
  RelicConfig_89647_Name = {
    Text = "Hyperstring Abyssal Elixir"
  },
  RelicConfig_89648_BattleDesc = {
    Text = [[
Realm Mastery increased by 200 points.
When consuming Crimson Furnace, increase Tentacle DMG by 15% of the consumed amount.
Accumulate [Arg3] Crimson Furnace each time a Tentacle attacks.]]
  },
  RelicConfig_89648_Desc = {
    Text = [[
Increase Realm Mastery by 200.
When consuming Crimson Furnace, increase Tentacle DMG by 15% of the consumed amount.
Accumulate [Arg3] Crimson Furnace points each time a Tentacle attacks.]]
  },
  RelicConfig_89648_Name = {
    Text = "Rotting Blood Abyss Serum"
  },
  RelicConfig_91096_BattleDesc = {
    Text = [[
At turn start, both sides gain one stack of <Kuangre:Fervor>. Each stack of <Kuangre:Fervor> causes Active and Tentacle DMG dealt to inflict <BleedingIconKeywords:Bleed> equal to 10% of the DMG dealt. 
For every 20% of Boss HP reduced, all Awakeners gain 10 Aliemus. 
At the start of battle, shuffle <DerivativeCardKeywords_108:"Inspire Offsprings"> and <DerivativeCardKeywords_109:"Protect Offsprings"> into the Draw Pile.]]
  },
  RelicConfig_91096_Desc = {
    Text = [[
At turn start, both sides gain one stack of <Kuangre:Fervor>. Each stack of <Kuangre:Fervor> causes Active and Tentacle DMG dealt to inflict <BleedingIconKeywords:Bleed> equal to 10% of the DMG dealt. 
For every 20% of Boss HP reduced, all Awakeners gain 10 Aliemus. 
At the start of battle, shuffle <DerivativeCardKeywords_108:"Inspire Offsprings"> and <DerivativeCardKeywords_109:"Protect Offsprings"> into the Draw Pile.]]
  },
  RelicConfig_91096_Name = {Text = "Pallid Egg"},
  RelicConfig_91096_StoryDesc = {
    Text = [[
Pulses when the pale child is about to be born.
Be careful, they are coming soon.]]
  },
  RelicConfig_94695_BattleDesc = {
    Text = "After an Awakener is killed, other allies gain [Arg1] <StrongEffectKeywords:Amplification>. This effect can only be triggered once per Awakener."
  },
  RelicConfig_94695_Desc = {
    Text = "After an Awakener is killed, other allies gain [Arg1] <StrongEffectKeywords:Amplification>. This effect can only be triggered once per Awakener."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Black Star Ember>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "After the battle starts, place [Arg1] <PVPDerivativeCardKeywords_21:Bone-Chilling Embrace> into hand."
  },
  RelicConfig_94696_Desc = {
    Text = "After the battle starts, place [Arg1] <PVPDerivativeCardKeywords_21:Bone-Chilling Embrace> into hand."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Vitality Injection>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "At turn end, discard your entire hand and draw the same number of cards."
  },
  RelicConfig_94697_Desc = {
    Text = "At turn end, discard your entire hand and draw the same number of cards."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Enthralling Chime>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "After the battle starts, place [Arg1] <PVPDerivativeCardKeywords_22:Strike Last, Strike Best> and <PVPDerivativeCardKeywords_23:Voices in Your Head> in the Draw Pile."
  },
  RelicConfig_94698_Desc = {
    Text = "After the battle starts, place [Arg1] <PVPDerivativeCardKeywords_22:Strike Last, Strike Best> and <PVPDerivativeCardKeywords_23:Voices in Your Head> in the Draw Pile."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Alfonso's Artifact>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = [[
Hand limit +1.
At the beginning of the turn, if there is no <DerivativeCardKeywords_111:"Soul Devour">, place it in hand. If "Fullness" reaches 10, it will be transformed into <DerivativeCardKeywords_112:"Memory Resonance">.]]
  },
  RelicConfig_95975_Desc = {
    Text = [[
Hand limit +1.
At the beginning of the turn, if there is no "Soul Devour", place it in hand. If "Fullness" reaches 10, it will be transformed into "Memory Resonance".]]
  },
  RelicConfig_95975_Name = {
    Text = "Bone Chalice"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"The Bloody Moon rises, the corpses shall raise their cups and drink together.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "At turn start, Doresain gains [Arg1] Aliemus and [Arg2] points of STR. When Doresain consumes a \"Corpse\", gain Temporary Strength equal to 20% of Doresain's Permanent STR."
  },
  RelicConfig_95976_Desc = {
    Text = "At turn start, Doresain gains [Arg1] Aliemus and [Arg2] points of Strength. When Doresain consumes a \"Corpse\", it gains Temporary STR equal to 20% of its Permanent STR."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Dimensional Image: Doresain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "At turn start, apply <BurningKeywords2:Burn> to 1 Command Card in hand and gain 1 stack of <Heat:Blackened Flame>. When <Heat:Blackened Flame> reaches 3 stacks, put 1 <Overload:Endless Combustion> into hand."
  },
  RelicConfig_96652_Desc = {
    Text = "At turn start, apply <BurningKeywords2:Burn> to 1 Command Card in hand and gain 1 stack of <Heat:Blackened Flame>. When <Heat:Blackened Flame> reaches 3 stacks, put 1 <Overload:Endless Combustion> into hand."
  },
  RelicConfig_96652_Name = {
    Text = "Blackened Flame"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "The pitch-black flames will execute her will, burning everything to ashes."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Draw 2 cards and gain [Arg1] Keyflare when losing the last card in your hand. Tentacle DMG +[Arg2] each time the deck is reset."
  },
  RelicConfig_97344_Desc = {
    Text = "Draw 2 cards and gain [Arg1] Keyflare when losing the last card in your hand. Tentacle DMG +[Arg2] each time the deck is reset."
  },
  RelicConfig_97344_Name = {
    Text = "Winner's Cup"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Today, we will forget fear, forget pain, and just enjoy the carnival."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "For every 3 Command Cards played, gain 1 Arithmetica and draw 1 card. Each instance of Active DMG increases Temporary Final DMG by 2%, up to 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "For every 3 Command Cards played, gain 1 Arithmetica and draw 1 card. Each instance of Active DMG increases Temporary Final DMG by 2%, up to 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Winner's Cup"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Today, we will forget fear, forget pain, and just enjoy the carnival."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "All Awakeners' Crit. Rate +30%. At the start of odd-numbered turns, all enemies lose 25% of their current HP. When your team's HP percentage is lower than the enemy's, Final DMG+50%; when your team's HP percentage is higher than the enemy's, gain 35 Aliemus after using Exalt."
  },
  RelicConfig_97346_Desc = {
    Text = "All Awakeners' Crit. Rate +30%. At the start of odd-numbered turns, all enemies lose 25% of their current HP. When your team's HP percentage is lower than the enemy's, Final DMG+50%; when your team's HP percentage is higher than the enemy's, gain 35 Aliemus after using Exalt."
  },
  RelicConfig_97346_Name = {
    Text = "Winner's Cup"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Today, we will forget fear, forget pain, and just enjoy the carnival."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Max Arithmetica increases by 2. Unconsumed Arithmetica can be retained until the next turn. If more than 2 Arithmetica is retained, all Awakeners gain 20 Aliemus at the start of the next turn; if more than 4 Arithmetica is retained, the base damage dealt in the next turn is increased by 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "Max Arithmetica increases by 2. Unconsumed Arithmetica can be retained until the next turn. If more than 2 Arithmetica is retained, all Awakeners gain 20 Aliemus at the start of the next turn; if more than 4 Arithmetica is retained, the base damage dealt in the next turn is increased by 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Winner's Cup"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Today, we will forget fear, forget pain, and just enjoy the carnival."
  },
  RelicConfig_98274_BattleDesc = {
    Text = [[
Hand Limit +1. Gain "<DerivativeCardKeywords_116:Palette>" at the start of the battle. 
At each turn start, gain 1 "<PrimaryColor:Color>" and randomly apply "<ColorInkKeywords:Paint>" to 2 Command Cards. Playing a "<ColorInkKeywords:Paint>" card grants 1 "<PrimaryColor:Color>" in sequence. 
"<PrimaryColor:Color>" played will be recorded on "<DerivativeCardKeywords_116:Palette>". If there are 2 different "<PrimaryColor:Color>" recorded on "<DerivativeCardKeywords_116:Palette>", it provides continuous buffs. 
If there are 3 different "<PrimaryColor:Color>" recorded on "<DerivativeCardKeywords_116:Palette>", immediately deal 5% Max HP damage to all enemies and clear "<DerivativeCardKeywords_116:Palette>".]]
  },
  RelicConfig_98274_Desc = {
    Text = [[
Hand Limit +1. Gain "<DerivativeCardKeywords_116:Palette>" at the start of the battle. 
At the start of your turn, gain 1 "<PrimaryColor:Color>" and randomly apply <ColorInkKeywords:Paint> to 2 Command Cards. Playing a <ColorInkKeywords:Paint>-marked card grants 1 "<PrimaryColor:Color>" in sequence. 
"<PrimaryColor:Color>" used will be recorded on the "<DerivativeCardKeywords_116:Palette>". If there are 2 different "<PrimaryColor:Color>" recorded on the "<DerivativeCardKeywords_116:Palette>", it provides continuous buffs. 
If there are 3 different "<PrimaryColor:Color>" recorded on the "<DerivativeCardKeywords_116:Palette>", immediately deal 5% Max HP damage to all enemies and clear the "<DerivativeCardKeywords_116:Palette>".]]
  },
  RelicConfig_98274_Name = {
    Text = "Twisted Palette"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "In the Vision, we will witness the birth of \"art\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "All Awakeners' base effects for HP healing and Shield are +[Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "All Awakeners' base effects for HP healing and Shield are +[Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Serpent's Husk>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Rebirth from self-mutilation"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. For each Command Card played by a different Awakener, gain an additional [Arg1]% Temporary DMG Amplification."
  },
  RelicConfig_98368_Desc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. For each Command Card played by a different Awakener, gain an additional [Arg1]% Temporary DMG Amplification."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaleidoscope+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "What you think and see are all illusions."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "After using Keyflare Rouse, grant Retain and Prepare to the [Arg1] cards with the highest Arithmetica in your hand before the next play, and gain [Arg2] points of Keyflare."
  },
  RelicConfig_98369_Desc = {
    Text = "After using Keyflare Rouse, grant Retain and Prepare to the [Arg1] cards with the highest Arithmetica in your hand before the next play, and gain [Arg2] points of Keyflare."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Foreign Stamp Album>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Quantified longing."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "At the start of battle, apply [Arg1] Weakness and Vulnerable to all enemies. This effect is also triggered after \"Annihilation\", but has a 3 turn cooldown."
  },
  RelicConfig_98370_Desc = {
    Text = "At the start of battle, apply [Arg1] <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> to all enemies. This effect is also triggered after \"Annihilation\", but has a 3 turn cooldown."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Spatial Deflector>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Leap into the void."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  RelicConfig_98371_Desc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Tilted Scales>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "No longer symbolizes justice."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to add a <DerivativeCardKeywords_129:\"Silver Key Gleam\"> to your hand."
  },
  RelicConfig_98372_Desc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to add a <DerivativeCardKeywords_129:\"Silver Key Gleam\"> to your hand."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:In Twilight>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Let's take a photo together! Experience the feeling of real pain."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Gain [Arg1] Keyflare when \"Exalt\" is released."
  },
  RelicConfig_98373_Desc = {
    Text = "Gain [Arg1] Keyflare when \"Exalt\" is released."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Fleeting Beauty+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Preserve the beauty of fleeting moments forever."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "After your first \"Posse\" each turn, apply [Arg1] Poison to all enemies and gain [Arg2] Counter."
  },
  RelicConfig_98374_Desc = {
    Text = "After the first \"Posse\" in each round, apply [Arg1] stacks of <IntoxicationIconKeywords:Poison> to all enemies and gain [Arg2] stacks of <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Prophet's Lamp+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Grant your wish."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to put a <DerivativeCardKeywords_67:\"Silver Key Dawn\"> into your hand."
  },
  RelicConfig_98375_Desc = {
    Text = "At the end of the round, if Keyflare is full, consumes [Arg1] Keyflare to put a <DerivativeCardKeywords_67:\"Silver Key Dawn\"> into your hand."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:In Twilight+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Let's take a photo together! Experience the feeling of real pain."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "All Awakeners' base effects for HP healing and Shield are +[Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "All Awakeners' base effects for HP healing and Shield are +[Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Serpent's Husk+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Rebirth from self-mutilation"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  RelicConfig_98377_Desc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Trigon Prism>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"The light is composed of seven colors.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After taking damage, gain [Arg2] Counter, triggering up to 3 times per turn."
  },
  RelicConfig_98378_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of battle. After taking damage, gain [Arg2] <RetaliateIconKeywords:Counter>, triggering a maximum of 3 times per turn."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Safe Passage+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Looks like he didn't make it out either."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  RelicConfig_98379_Desc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Submersible Helm>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Dreams are the stars and the sea!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  RelicConfig_98380_Desc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Relic of the Past>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "An offering once presented."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Restores [Heal:Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  RelicConfig_98381_Desc = {
    Text = "Restores [Heal:Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Voyager's Parasol>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Bloom in the Lightless Land"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. At the start of odd-numbered turns, draw [Arg2] card. At the start of even-numbered turns, gain [Arg2] Arithmetica."
  },
  RelicConfig_98382_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. Draw [Arg2] cards at the start of odd turns, and gain [Arg2] points of Arithmetica at the start of even turns."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Solar Disc+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Guess, is it black or white?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  RelicConfig_98383_Desc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Yellow Snail+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "This little Yellow Snail hails from a noble background, with a perfect and impeccable origin."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "All Awakeners Base DMG +[Arg1]%. Immediately before unleashing Exalt, temporarily increase the Base DMG dealt by this Awakener by [Arg2]%."
  },
  RelicConfig_98384_Desc = {
    Text = "All Awakeners Base DMG +[Arg1]%. Immediately before unleashing Exalt, temporarily increase the Base DMG dealt by this Awakener by [Arg2]%."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Forsaken Blood>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Gradually melting away."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "After your first \"Posse\" each turn, apply [Arg1] Poison to all enemies and gain [Arg2] Counter."
  },
  RelicConfig_98385_Desc = {
    Text = "After the first \"Posse\" in each round, apply [Arg1] stacks of <IntoxicationIconKeywords:Poison> to all enemies and gain [Arg2] stacks of <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Prophet's Lamp>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Grant your wish."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "At the start of the turn, if HP is below 50%, Temporary DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  RelicConfig_98386_Desc = {
    Text = "At the start of the turn, if HP is below 50%, Temporary DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Doctor's Case>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = [[
A briefcase symbolizing the identity of a doctor, very heavy. 
Opening it does not guarantee it belongs to a true doctor.]]
  },
  RelicConfig_98387_BattleDesc = {
    Text = "At the start of battle, apply [Arg1] Weakness and Vulnerable to all enemies. This effect is also triggered after \"Annihilation\", but has a 3 turn cooldown."
  },
  RelicConfig_98387_Desc = {
    Text = "Battle starts by inflicting [Arg1] stacks of <WeaknessIconKeywords:Weakness> and <VulnerabilityIconKeywords:Vulnerable> on all enemies. This effect will also trigger after \"Annihilation,\" but has a 3 turn cooldown."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Spatial Deflector+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Leap into the void."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  RelicConfig_98388_Desc = {
    Text = "At the start of battle and after triggering Death Resistance, gain [Arg1] Keyflare."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Relic of the Past+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "An offering once presented."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. At the start of odd-numbered turns, draw [Arg2] card. At the start of even-numbered turns, gain [Arg2] Arithmetica."
  },
  RelicConfig_98389_Desc = {
    Text = "After the battle starts, gain [Arg1] <ProficientInRealmsIconKeywords:Realm Mastery>. Draw [Arg2] cards at the start of odd turns, and gain [Arg2] points of Arithmetica at the start of even turns."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Solar Disc>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Guess, is it black or white?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Gain [Arg1] Temporary STR each time a card is drawn or discarded, up to 15 times per turn."
  },
  RelicConfig_98390_Desc = {
    Text = "Draw or discard a card to gain [Arg1] Temporary<PowerIconKeywords:STR>, triggering a maximum of 15 times per turn."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Silent Prelude>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = [[
The violin of the renowned violinist Eric Eckstein.
Now, it can no longer be played.]]
  },
  RelicConfig_98391_BattleDesc = {
    Text = "The first \"Posse\" of each turn grants a [Arg2]% increase to Temporary DMG Amplification, with the effect scaling as HP decreases."
  },
  RelicConfig_98391_Desc = {
    Text = "The first \"Posse\" each turn grants Temporary DMG Amplification +[Arg1]%, with stronger effects at lower HP."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Harford's Elixir>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = [[
Medicine of unknown composition.
It is said that the renowned violinist Eric has a particular fondness for it.]]
  },
  RelicConfig_98392_BattleDesc = {
    Text = "The first \"Posse\" of each turn grants a [Arg2]% increase to Temporary DMG Amplification, with the effect scaling as HP decreases."
  },
  RelicConfig_98392_Desc = {
    Text = "The first \"Posse\" each turn grants Temporary DMG Amplification +[Arg1]%, with stronger effects at lower HP."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Harford's Elixir+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = [[
Medicine of unknown composition.
It is said that the renowned violinist Eric has a particular fondness for it.]]
  },
  RelicConfig_98393_BattleDesc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  RelicConfig_98393_Desc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Silver Tongue>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Not only merchants are eloquent, but also the devout."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  RelicConfig_98394_Desc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Lucky Rabbit's Paw>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Not so lucky for the rabbit."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After dealing Active DMG, inflict [Arg2] Poison on all enemies, up to 5 triggers per turn."
  },
  RelicConfig_98395_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of battle. Deal Active DMG and inflict [Arg2] <IntoxicationIconKeywords:Poison> on all enemies, triggering up to 5 times per round."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Hierophant's Staff+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Unsanctioned Piety"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. For each Command Card played by a different Awakener, gain an additional [Arg1]% Temporary DMG Amplification."
  },
  RelicConfig_98396_Desc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. For each Command Card played by a different Awakener, gain an additional [Arg1]% Temporary DMG Amplification."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Kaleidoscope>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "What you think and see are all illusions."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  RelicConfig_98397_Desc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Chronometric Device+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "One of the most sinister inventions in human history."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "At the start of the battle, all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:Strength>. Using \"Crimson Furnace\" will also trigger this effect, but has a 3-turn cooldown."
  },
  RelicConfig_98398_Desc = {
    Text = "At the start of the battle, all enemies lose [Arg1] Temporary <ExhaustionIconKeywords:STR>. Using \"Crimson Furnace\" will also trigger this effect, but has a 3-turn cooldown."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Phantom Hand+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "The perfect tool for killing, looting, and scratching."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  RelicConfig_98399_Desc = {
    Text = "After releasing the second \"Posse\" each turn, gain [Arg1] Keyflare, and all Awakeners gain [Arg2] Aliemus."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Chronometric Device>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "One of the most sinister inventions in human history."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Gain [Arg1] Temporary STR each time a card is drawn or discarded, up to 15 times per turn."
  },
  RelicConfig_98400_Desc = {
    Text = "Draw or discard a card to gain [Arg1] Temporary<PowerIconKeywords:STR>, triggering a maximum of 15 times per turn."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Silent Prelude+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = [[
The violin of the renowned violinist Eric Eckstein.
Now, it can no longer be played.]]
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the battle. Gain [Arg2] Arithmetica after obtaining Counter for the first time each turn."
  },
  RelicConfig_98401_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the Battle, and gain [Arg2] Arithmetica after receiving <RetaliateIconKeywords:Counter> for the first time each turn."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Putney Morning Post+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Your most thoughtful toilet companion."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  RelicConfig_98402_Desc = {
    Text = "After dealing active or Tentacle DMG, increases the target's Tentacle DMG taken by [Arg1]% for the remainder of the turn. Can trigger up to 20 times per turn."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Submersible Helm+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Dreams are the stars and the sea!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Gain [Arg1] STR at the start of the battle. Gain [Arg2] Temporary STR each time a \"Exhaust\" card is played, up to 10 triggers per turn."
  },
  RelicConfig_98403_Desc = {
    Text = "Gain [Arg1] <PowerIconKeywords:STR> at the start of the battle. Each time you play a card with \"Exhaust,\" gain [Arg2] Temporary <PowerIconKeywords:STR>, triggering up to 10 times per turn."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Tiny Music Box+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = [[
Dexter's mansion has many collections. Before it was broken, the Tiny Music Box was Miss Dexter's favorite toy.
As time passed, when Miss Dexter found it again, its gears were loose, the music off-key, but it still kept spinning.]]
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Gain [Arg1] Keyflare when \"Exalt\" is released."
  },
  RelicConfig_98404_Desc = {
    Text = "Gain [Arg1] Keyflare when \"Exalt\" is released."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Fleeting Beauty>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Preserve the beauty of fleeting moments forever."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  RelicConfig_98405_Desc = {
    Text = "All Awakeners gain [Arg1] Keyflare from their first \"Command Card\" each turn."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Silver Tongue+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Not only merchants are eloquent, but also the devout."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  RelicConfig_98406_Desc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Dearest Babe+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "The carpenter crafted a lifelike puppet for his wife, which would take the place of their son, resting in her womb."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  RelicConfig_98407_Desc = {
    Text = "The first \"Posse\" each turn refunds [Arg1]% of the consumed Keyflare."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Lucky Rabbit's Paw+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Not so lucky for the rabbit."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  RelicConfig_98408_Desc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Easter Moment>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Enjoy the fun, but do not eat."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "At the start of the battle, all enemies lose [Arg1] Temporary<ExhaustionIconKeywords:STR>. Using \"Crimson Furnace\" will also trigger this effect, but has a 3-turn cooldown."
  },
  RelicConfig_98409_Desc = {
    Text = "At the start of the battle, all enemies lose [Arg1] Temporary<ExhaustionIconKeywords:STR>. Using \"Crimson Furnace\" will also trigger this effect, but has a 3-turn cooldown."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Phantom Hand>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "The perfect tool for killing, looting, and scratching."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  RelicConfig_98410_Desc = {
    Text = "Whenever 1 \"Embryo\" is generated, gain [Arg1] Crimson Furnace, up to 3 times per turn."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Dearest Babe>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "The carpenter crafted a lifelike puppet for his wife, which would take the place of their son, resting in her womb."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "At the start of the turn, if Keyflare is greater than [Arg1], consume [Arg1] Keyflare to put 1 <DerivativeCardKeywords_115:\"Adv. Insight\"> into your hand."
  },
  RelicConfig_98411_Desc = {
    Text = "At the start of the turn, if Keyflare exceeds [Arg1], consume [Arg1] Keyflare to add 1 <DerivativeCardKeywords_115:\"Adv. Insight\"> to hand."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Nightmare Manifest>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Watch out, indulgent deep sleep will devour everything without you noticing."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 more time."
  },
  RelicConfig_98412_Desc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 more time."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Stellar Brew+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Wandering among the stars."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After taking damage, gain [Arg2] Counter, triggering up to 3 times per turn."
  },
  RelicConfig_98413_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of battle. After taking damage, gain [Arg2] <RetaliateIconKeywords:Counter>, triggering a maximum of 3 times per turn."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Safe Passage>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Looks like he didn't make it out either."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "All Awakeners Base DMG +[Arg1]%. Immediately before unleashing Exalt, temporarily increase the Base DMG dealt by this Awakener by [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "All Awakeners Base DMG +[Arg1]%. Immediately before unleashing Exalt, temporarily increase the Base DMG dealt by this Awakener by [Arg2]%."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Forsaken Blood+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Gradually melting away."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Restores [Heal:Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  RelicConfig_98415_Desc = {
    Text = "Restores [Heal:Arg1] HP and grants [Arg2] Keyflare after using Keyflare Rouse."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Voyager's Parasol+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Bloom in the Lightless Land"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the battle. Gain [Arg2] Arithmetica after obtaining Counter for the first time each turn."
  },
  RelicConfig_98416_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the Battle, and gain [Arg2] Arithmetica after receiving <RetaliateIconKeywords:Counter> for the first time each turn."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Your most thoughtful toilet companion."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  RelicConfig_98417_Desc = {
    Text = "At turn start, all Awakeners whose Aliemus is insufficient to unleash Exalt gain [Arg1] Aliemus."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Easter Moment+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Enjoy the fun, but do not eat."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After the first application of Poison each turn, draw [Arg2] cards."
  },
  RelicConfig_98418_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the battle. After applying <IntoxicationIconKeywords:Poison> for the first time each turn, draw [Arg2] cards."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Rhind Papyrus+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Here is the question: 10 monks share 6 loaves of bread. How much does each monk receive?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 more time."
  },
  RelicConfig_98419_Desc = {
    Text = "After every 5 uses of \"Exalt\", the next [Arg1] Non-Derived Command Card takes effect 1 more time."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Stellar Brew>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Wandering among the stars."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  RelicConfig_98420_Desc = {
    Text = "Whenever a card enters the Ultra Space, draw [Arg1] Command Cards belonging to this card's owner from the Draw Pile. If unable to draw, gain an equal amount of Arithmetica instead. This effect can trigger at most 2 times per turn."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Trigon Prism+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"The light is composed of seven colors.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "After using Keyflare Rouse, grant Retain and Prepare to the [Arg1] cards with the highest Arithmetica in your hand before the next play, and gain [Arg2] points of Keyflare."
  },
  RelicConfig_98421_Desc = {
    Text = "After using Keyflare Rouse, grant Retain and Prepare to the [Arg1] cards with the highest Arithmetica in your hand before the next play, and gain [Arg2] points of Keyflare."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Foreign Stamp Album+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Quantified longing."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  RelicConfig_98422_Desc = {
    Text = "Before turn end, each Awakener to which a Command Card in hand belongs gains [Arg1] Aliemus."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Tilted Scales+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "No longer symbolizes justice."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After dealing Active DMG, inflict [Arg2] Poison on all enemies, up to 5 triggers per turn."
  },
  RelicConfig_98423_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of battle. Deal Active DMG and inflict [Arg2] <IntoxicationIconKeywords:Poison> on all enemies, triggering up to 5 times per round."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Hierophant's Staff>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Unsanctioned Piety"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "At the start of the battle, gain [Arg1]% DMG Amplification. After the first application of Poison each turn, draw [Arg2] cards."
  },
  RelicConfig_98424_Desc = {
    Text = "Gain [Arg1]% DMG Amplification at the start of the battle. After applying <IntoxicationIconKeywords:Poison> for the first time each turn, draw [Arg2] cards."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Rhind Papyrus>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Here is the question: 10 monks share 6 loaves of bread. How much does each monk receive?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Gain [Arg1] STR at the start of the battle. Gain [Arg2] Temporary STR each time a \"Exhaust\" card is played, up to 10 triggers per turn."
  },
  RelicConfig_98425_Desc = {
    Text = "Gain [Arg1] <PowerIconKeywords:STR> at the start of the battle. Each time you play a card with \"Exhaust,\" gain [Arg2] Temporary <PowerIconKeywords:STR>, triggering up to 10 times per turn."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Tiny Music Box>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = [[
Dexter's mansion has many collections. Before it was broken, the Tiny Music Box was Miss Dexter's favorite toy.
As time passed, when Miss Dexter found it again, its gears were loose, the music off-key, but it still kept spinning.]]
  },
  RelicConfig_98426_BattleDesc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  RelicConfig_98426_Desc = {
    Text = "The first \"Posse\" activation each turn triggers all Tentacle attacks [Arg1] times against enemies, dealing 50% DMG."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Yellow Snail>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "This little Yellow Snail hails from a noble background, with a perfect and impeccable origin."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "At the start of the turn, if HP is below 50%, Temporary DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  RelicConfig_98427_Desc = {
    Text = "At the start of the turn, if HP is below 50%, Temporary DMG Amplification +[Arg1]%. If HP is below 25%, draw [Arg2] additional cards and gain [Arg2] Arithmetica."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Doctor's Case+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = [[
A briefcase symbolizing the identity of a doctor, very heavy. 
Opening it does not guarantee it belongs to a true doctor.]]
  },
  RelicConfig_98891_BattleDesc = {
    Text = [[
After the battle starts, gain 5 stacks of "<LostWay:Lost>", and reduce 1 stack for every 3 Command Cards played.
After all "<LostWay:Lost>" are removed, all Awakeners gain 100 Aliemus. For every 3 cards played, restore [Arg1] HP and apply <Corrosion:Corrosion> equal to 1% of the enemy's Max HP to the front-row enemy.]]
  },
  RelicConfig_98891_Desc = {
    Text = [[
After the battle starts, gain 5 stacks of "<LostWay:Lost>", and reduce 1 stack for every 3 Command Cards played.
After all "<LostWay:Lost>" are removed, all Awakeners gain 100 Aliemus. For every 3 cards played, recover [Arg1] HP and apply <Corrosion:Corrosion> equal to 1% of the enemy's Max HP to the front-row enemy.]]
  },
  RelicConfig_98891_Name = {
    Text = "Lamp of Salvation"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Even though the experience is dim, the lantern of salvation will ultimately shine bright again amidst death."
  }
})
return Text_RelicConfig
