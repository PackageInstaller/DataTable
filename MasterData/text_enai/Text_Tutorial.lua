__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "You can return to any of the last 25 turns in battle."
  },
  Tutorial_120371_Title_1 = {
    Text = "Time Reversal"
  },
  Tutorial_124999_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase-Draft Pick> mode, click \"Start Matching\" in the bottom right corner of the interface to enter matchmaking without needing to pre-construct a team."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Before the match begins, a random <TutorialHighlight:Relic> is chosen to influence the coming battle. Players then take turns drafting Awakeners, Wheels of Destiny, and Posses from a limited pool to build their lineups. To adjust your strategy, click any two Awakeners to swap their positions (numbered 1–4, from front to back)."
  },
  Tutorial_124999_Desc_3 = {
    Text = "To adjust your lineup, click any two Awakeners to swap their positions (numbered 1–4, from front to back)."
  },
  Tutorial_124999_Title_1 = {
    Text = "Draft Pick Lineup"
  },
  Tutorial_126878_Desc_1 = {
    Text = "When the Psyche Surge of certain Awakeners reaches +12, they automatically gain the \"Absolute Axiom\" effect, which varies for each Awakener."
  },
  Tutorial_126878_Desc_2 = {
    Text = "After unlocking the Awakener's \"Absolute Axiom,\" you will receive an exclusive message from the Awakener. Remember to check it out!"
  },
  Tutorial_126878_Title_1 = {
    Text = "Absolute Axiom"
  },
  Tutorial_126878_Title_2 = {
    Text = "Exclusive Message"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Tap an enemy to view all its states. <TutorialHighlight:Warning> states require special attention as they represent unique enemy mechanics. The majority of cases where Keepers fail to complete investigations are often due to neglecting these mechanics."
  },
  Tutorial_17805_Title_1 = {
    Text = "Enemy State"
  },
  Tutorial_17806_Desc_1 = {
    Text = "After defeating an enemy, you can choose to <TutorialHighlight:Orison>, or spend <TutorialHighlight:Black Sigil> at <TutorialHighlight:D-Mark> to make purchases. Orison grants different additional effects to specific Command Cards. Each specific Command Card can be inscribed with Orison only up to <TutorialHighlight:1> time. Apply Orisons to your most frequently-played Command Cards to maximize the effect."
  },
  Tutorial_17806_Title_1 = {Text = "Orison"},
  Tutorial_17807_Title_1 = {Text = "Covenant"},
  Tutorial_17808_Desc_1 = {
    Text = "In the gameplay of <TutorialHighlight:Phantasmal Dive>, each time you challenge a stage, you will randomly enter a map. After successfully completing the challenge, you will earn corresponding points based on the difficulty of the stage, the enhanced Awakeners, and the scoring items within the stage. Each week's challenges will feature different initial relics and enhanced Awakeners."
  },
  Tutorial_17808_Desc_2 = {
    Text = "<TutorialHighlight:Survey Ranking> is ranked based on the highest scores obtained in weekly challenges, and the survey ranking is settled weekly with corresponding rewards issued. <TutorialHighlight:Season Ranking> is ranked based on the highest scores achieved during the season."
  },
  Tutorial_17808_Desc_3 = {
    Text = "Deep Dive Record has multiple objectives, and rewards can be obtained upon completion. Each time you complete a \"Deep Dive Records\" objective or win a P-Dive challenge, you can earn <TutorialHighlight:Deep Dive EXP>. When your Deep Dive EXP reaches a certain value, <TutorialHighlight:Deep Dive Level> will increase, allowing you to receive various rewards. You can check your \"Deep Dive Record\" and \"Deep Dive Level\" in the lower left corner of the interface."
  },
  Tutorial_17808_Title_1 = {
    Text = "Phantasmal Dive"
  },
  Tutorial_17809_Desc_1 = {
    Text = "You can obtain <TutorialHighlight:Relic> through events and D-Marks. These Relics can enhance your team's combat abilities. Skilled Keepers often select more suitable <TutorialHighlight:Relic> based on their team's needs."
  },
  Tutorial_17809_Title_1 = {Text = "Relic"},
  Tutorial_17810_Desc_1 = {
    Text = "Clears the mist, increases map vision by <TutorialHighlight:2> tiles, enabling better path planning."
  },
  Tutorial_17810_Title_1 = {
    Text = "Searchlight"
  },
  Tutorial_17811_Desc_1 = {
    Text = "Targets in <TutorialHighlight:Poisoned> state take damage equal to the number of <TutorialHighlight:Poison> stacks at turn end. <TutorialHighlight:Poison> damage <TutorialHighlight:cannot crit>."
  },
  Tutorial_17811_Title_1 = {Text = "Poison"},
  Tutorial_17812_Desc_1 = {
    Text = "Targets in the <TutorialHighlight:Vulnerable> state take 50% increased DMG and automatically lose 1 stack of <TutorialHighlight:Vulnerable> at turn end. Take advantage of enemies' <TutorialHighlight:Vulnerable> state to deal greater DMG."
  },
  Tutorial_17812_Title_1 = {Text = "Vulnerable"},
  Tutorial_17813_Desc_1 = {
    Text = "After clearing the stages of \"Dissolution Ruins,\" \"Verboten Covenant,\" and \"Arcane Dominion,\" you can <TutorialHighlight:Reenact> the stages. By using <TutorialHighlight:Reenact>, you can quickly obtain stage rewards."
  },
  Tutorial_17813_Title_1 = {Text = "Reenact"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Shield> can block DMG. Shield is <TutorialHighlight:automatically removed> at the end of the turn. The Shield limit equals the team's <TutorialHighlight:Max HP>. Try your best to <TutorialHighlight:match the total Shield to the total incoming DMG this turn> and win the battle."
  },
  Tutorial_17814_Title_1 = {Text = "Shield"},
  Tutorial_17815_Desc_1 = {
    Text = "Repeatedly obtaining Awakeners will convert them into <TutorialHighlight:Shards>. Consuming <TutorialHighlight:Shards> to enhance the Awakener's Enlighten Level grants additional special abilities to the Awakener's Skills. When the Awakener's Enlighten Level is maxed out, obtaining corresponding Shards will convert them into <TutorialHighlight:Gnosis Fragments>."
  },
  Tutorial_17815_Title_1 = {Text = "Shard"},
  Tutorial_17816_Desc_1 = {
    Text = "Arithmetica is <TutorialHighlight:shared by the entire team>, playing cards consumes <TutorialHighlight:Arithmetica>. Arithmetica <TutorialHighlight:auto-refills to its maximum at each turn start> and <TutorialHighlight:auto-clears> at turn end. To maximize Arithmetica efficiency, please try to <TutorialHighlight:use up all Arithmetica before ending your turn>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Defeat enemies in <TutorialHighlight:Arcane Dominion> to obtain premium <TutorialHighlight:Skill Upgrade Materials>. Rewards can be claimed once per week. Various materials can also be synthesized and exchanged in the <TutorialHighlight:Alchemy>."
  },
  Tutorial_17817_Title_1 = {
    Text = "Arcane Dominion"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Can be used in <TutorialHighlight:Supplies> upon acquisition, rapidly increasing Awakener level and skill level according to preset values."
  },
  Tutorial_17818_Title_1 = {
    Text = "Gnosis Amplifier"
  },
  Tutorial_17819_Desc_1 = {
    Text = "When an Awakener's Aliemus reaches <TutorialHighlight:100>, they can unleash <TutorialHighlight:Exalt>. Different Awakeners have different Exalt effects. Use them wisely to achieve <TutorialHighlight:twice the result with half the effort>."
  },
  Tutorial_17819_Title_1 = {Text = "Exalt"},
  Tutorial_17820_Desc_1 = {
    Text = "Targets in a <TutorialHighlight:Fragile> state have their shield effectiveness reduced by 25%, and 1 stack of <TutorialHighlight:Fragile> is removed at turn end. If your team is in a <TutorialHighlight:Fragile> state, be sure to remove the <TutorialHighlight:Fragile> state before attempting to defend, or adjust your strategy to focus on aggressive offense this turn."
  },
  Tutorial_17820_Title_1 = {Text = "Fragile"},
  Tutorial_17821_Desc_1 = {
    Text = "Equipping the Awakener with <TutorialHighlight:Wheel of Destiny> can boost the Awakener's attributes and unlock special abilities."
  },
  Tutorial_17821_Title_1 = {
    Text = "Wheel of Destiny"
  },
  Tutorial_17822_Desc_1 = {
    Text = [[
Targets in <TutorialHighlight:Bleed> state take damage equal to the <TutorialHighlight:Bleed> stacks at turn end, then <TutorialHighlight:remove the Bleed state>.
<TutorialHighlight:HP Recovery> removes an amount of Bleed stacks equal to <TutorialHighlight:twice the Healing amount>. Bleed damage <TutorialHighlight:cannot crit>.]]
  },
  Tutorial_17822_Title_1 = {Text = "Bleed"},
  Tutorial_17823_Desc_1 = {
    Text = "Chaos Awakeners can <TutorialHighlight:break through realm restrictions> and form lineups with Awakeners from other realms, providing different symbiotic effects. Any lineup that includes a Chaos Awakener gains an additional 100% Death Resistance."
  },
  Tutorial_17823_Desc_2 = {
    Text = "Compared to other Realm teams, Chaos Realm teams gain Keyflare faster and can select from all available Porses when releasing the second Posse, and the selected Posse will trigger twice. Therefore, Chaos Realm teams rely more on coordination between Posses, and choosing the right Posse can greatly enhance the strength of a Chaos Realm team!"
  },
  Tutorial_17823_Title_1 = {Text = "Chaos"},
  Tutorial_17824_Desc_1 = {
    Text = "For each point of <TutorialHighlight:Alert>, gain 1 additional Shield when obtaining a Shield."
  },
  Tutorial_17824_Title_1 = {Text = "Alert"},
  Tutorial_17825_Desc_1 = {
    Text = "After completing the first Investigation, you can obtain <TutorialHighlight:Resonance Activation Materials>, which can be used to activate powerful <TutorialHighlight:Resonance>. This Resonance will take effect in all stages of this chapter."
  },
  Tutorial_17825_Title_1 = {Text = "Resonance"},
  Tutorial_17826_Desc_1 = {
    Text = "When your team is under the <TutorialHighlight:Aliemus Seal> status, you cannot unleash Exalt. Use Exalt before the enemy is about to inflict <TutorialHighlight:Aliemus Seal> to avoid wasting Aliemus."
  },
  Tutorial_17826_Title_1 = {
    Text = "Aliemus Seal"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Consumes <TutorialHighlight:Gnosis Elixir> to increase the Awakener's level. Upgrading improves the Awakener's attributes. Once the level cap is reached, Edify must be performed to raise the Awakener's level cap."
  },
  Tutorial_17827_Title_1 = {
    Text = "Gnosis Elixir"
  },
  Tutorial_17828_Desc_1 = {
    Text = "For each point of <TutorialHighlight:STR▼>, reduce <TutorialHighlight:Active DMG> dealt by 1."
  },
  Tutorial_17828_Title_1 = {Text = "STR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Before taking damage, become Immune to Damage and remove 1 <TutorialHighlight:Barrier>. The higher the single instance of damage, the greater the benefit from the <TutorialHighlight:Barrier>."
  },
  Tutorial_17829_Title_1 = {Text = "Barrier"},
  Tutorial_17830_Desc_1 = {
    Text = "Targets in the <TutorialHighlight:Weakness> state deal 25% less damage, and 1 stack of <TutorialHighlight:Weakness> is automatically removed at turn end. If your team is in the <TutorialHighlight:Weakness> state, remember to try removing the <TutorialHighlight:Weakness> state before attacking, or change the strategy to focus on full defense this turn."
  },
  Tutorial_17830_Title_1 = {Text = "Weakness"},
  Tutorial_17831_Desc_1 = {
    Text = "Defeating enemies in <TutorialHighlight:Verboten Covenant> grants <TutorialHighlight:Covenants> that enhance Awakener abilities. New stages unlock upon completing each chapter. Covenants can also be obtained by exchanging them in the shop."
  },
  Tutorial_17831_Title_1 = {
    Text = "Verboten Covenant"
  },
  Tutorial_17832_Desc_1 = {
    Text = "An Ultra team's temporary copy of the <TutorialHighlight:first> command card played each turn enters <TutorialHighlight:Ultra Space> and triggers powerful leap effects. When Ultra Space reaches its limit, gain 1 extra <TutorialHighlight:Ultra Round>, during which <TutorialHighlight:all leap effects are triggered>. The key to mastering the Ultra Team: carefully plan the first card played each turn."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "When your team's HP is depleted, you can activate <TutorialHighlight:Emergency Gnosis> to restore all States. Emergency Gnosis automatically recovers <TutorialHighlight:1> per day, with a maximum of <TutorialHighlight:5>. Use Emergency Gnosis wisely in <TutorialHighlight:High Difficulty Battles> and avoid wasting them carelessly."
  },
  Tutorial_17833_Title_1 = {
    Text = "Emergency Gnosis"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Carefully search for the faintly glowing spots on the map; investigating them might lead to unexpected gains."
  },
  Tutorial_17834_Title_1 = {
    Text = "Extraction Point"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Represents the total damage from all enemies this turn. A simple and practical Keeper combat tip: <TutorialHighlight:Make your shield equal to the total enemy damage>."
  },
  Tutorial_17835_Title_1 = {
    Text = "Total Enemy DMG"
  },
  Tutorial_17837_Desc_1 = {
    Text = "When the <TutorialHighlight:Embryo Fusion> of the Caro team reaches 100%, you will obtain one <TutorialHighlight:\"Embryo\">. Exalting Aliemus consumes <TutorialHighlight:\"Embryo\"> to trigger a powerful <TutorialHighlight:Devour> effect. Therefore, try to have <TutorialHighlight:\"Embryo\"> in your hand when Exalting; otherwise, the Caro team cannot utilize its full potential."
  },
  Tutorial_17837_Desc_2 = {
    Text = "After each battle, 5% of Max HP healing is accumulated into the Crimson Furnace. If there are unused <TutorialHighlight:Embryo>, each Embryo also contributes 5% of Max HP healing to the Furnace. The Crimson Furnace can be used to restore the party's HP, and can be converted into healing once per turn. The Keeper must carefully plan when to use the Crimson Furnace to turn the tide of battle."
  },
  Tutorial_17837_Title_1 = {Text = "Caro"},
  Tutorial_17838_Desc_1 = {
    Text = "At the Junction, you can choose to restore 50% of your team's lost HP or Awaken 1 Awakener. Choose HP Recovery when your team's HP is low; otherwise, choose to Rouse an Awakener."
  },
  Tutorial_17838_Title_1 = {Text = "Junction"},
  Tutorial_17839_Desc_1 = {
    Text = "A facility for consuming Black Sigils to enhance your team. It typically offers one slot for an Orison, one for a Silver Relic, and one for a Golden Relic. If no desired items are available, click <TutorialHighlight:Refresh>, and D-Marks will generate new options."
  },
  Tutorial_17839_Title_1 = {Text = "D-Mark"},
  Tutorial_17840_Desc_1 = {
    Text = "Forcing through <TutorialHighlight:Illusion> will infect you with \"Symptom\"."
  },
  Tutorial_17840_Title_1 = {Text = "Illusion"},
  Tutorial_17841_Desc_1 = {
    Text = "Using Command Cards allows Awakeners to gain <TutorialHighlight:Aliemus>. The higher the skill level of the Command Card, the more Aliemus is gained."
  },
  Tutorial_17841_Title_1 = {Text = "Aliemus"},
  Tutorial_17842_Desc_1 = {
    Text = "Defeating enemies or investigating events may grant <TutorialHighlight:Black Sigil>. The <TutorialHighlight:Sigil Yield> attribute of an Awakener increases the number of Black Sigils obtained."
  },
  Tutorial_17842_Desc_2 = {
    Text = "In the D-Mark, you can consume <TutorialHighlight:Black Sigil> to purchase Orisons and Relics, or awaken Awakeners. Before the Final Battle, be sure to spend all Black Sigils to enhance your team."
  },
  Tutorial_17842_Title_1 = {
    Text = "Black Sigil"
  },
  Tutorial_17843_Desc_1 = {
    Text = "When attacked, deal damage to the attacker equal to the number of <TutorialHighlight:Counter> stacks. <TutorialHighlight:Counter> damage cannot critically hit."
  },
  Tutorial_17843_Title_1 = {Text = "Counter"},
  Tutorial_17844_Desc_1 = {
    Text = "For each <TutorialHighlight:Strength> point, increase the damage dealt by 1 additional point with each active attack."
  },
  Tutorial_17844_Title_1 = {Text = "Strength"},
  Tutorial_17845_Desc_1 = {
    Text = "Assign Awakeners to complete research tasks to receive corresponding rewards. The higher the <TutorialHighlight:total level> of the assigned Awakeners, the better the rewards, with a maximum calculation based on a total level of 240."
  },
  Tutorial_17845_Title_1 = {Text = "Assignment"},
  Tutorial_17847_Desc_1 = {
    Text = "When taking Fatal DMG, there's a <TutorialHighlight:probability equal to Death Resistance> to become immune to the damage and retain 1 HP, <TutorialHighlight:with Death Resistance halved after successful activation>. The team's Death Resistance equals the sum of all Awakener Death Resistance; increasing the team's Death Resistance improves fault tolerance in battle."
  },
  Tutorial_17847_Title_1 = {
    Text = "Death Resistance"
  },
  Tutorial_17848_Desc_1 = {
    Text = "At the start of an Aequor team battle, generate 1 <TutorialHighlight:Tentacle>. The <TutorialHighlight:Tentacle> attacks front-row enemies at turn end. You can check the current Tentacle DMG and attack count via the formula below the Tentacle icon. Some Awakeners can increase the Tentacle Count and their DMG, dealing significant damage at turn end."
  },
  Tutorial_17848_Desc_2 = {
    Text = "The Keeper can click the Tentacle to switch it into different Stances: Surging Tides, Tranquil Sea, and Raging Waves. The default stance is Surging Tides; if no stance change occurs this turn, 1 Tentacle will be generated at the start of the next turn. Choose the Tranquil Sea stance when under heavy defensive pressure, and choose the Raging Waves stance when needing to quickly end the Battle. The Keeper must make better strategic choices based on the situation, and can switch the Tentacle Stance at most once per turn."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Playing cards consumes Arithmetica. At turn end, all cards will be moved to the <TutorialHighlight:Discard Pile>. Properly planning the <TutorialHighlight:card play order> will be the key to victory in battle."
  },
  Tutorial_17850_Title_1 = {Text = "Hand"},
  Tutorial_17851_Desc_1 = {
    Text = "Represents the action the enemy will take in the next turn. Utilizing <TutorialHighlight:Intention> to make decisions during this turn is the core gameplay mechanic of battle."
  },
  Tutorial_17851_Title_1 = {
    Text = "Enemy Intention"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Skill Upgrade> can enhance Awakener attributes and improve Command Card effects. Clicking \"Next Level\" in the Awakener Skill interface allows you to preview the upgraded effect."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Awakeners from different Realms require different <TutorialHighlight:Skill Upgrade Materials>."
  },
  Tutorial_17852_Title_1 = {
    Text = "Skill Upgrade"
  },
  Tutorial_20768_Desc_1 = {
    Text = "When an Awakener consumes Arithmetica, they gain <TutorialHighlight:Keyflare>. The <TutorialHighlight:Keyflare Regen> attribute increases the amount of <TutorialHighlight:Keyflare> gained."
  },
  Tutorial_20768_Title_1 = {Text = "Keyflare"},
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:Rusted Door> blocks important investigation routes. Search the map for an item called <TutorialHighlight:Rusted Key>, which can be used to open the <TutorialHighlight:Rusted Door>."
  },
  Tutorial_20769_Title_1 = {
    Text = "Rusted Door"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:Rusted Key> can open the <TutorialHighlight:Rusted Door> blocking your path."
  },
  Tutorial_20770_Title_1 = {Text = "Rusted Key"},
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Lightless Realm> contains a series of stages across four realms. Clearing them grants rewards such as Silver and Gnosis Elixir. Additionally, reaching the required total star rating unlocks extra rewards like Silver and Pure Core!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Different Realm Fissure stages will impose requirements on the Awakener's Realm within the investigation team. Only teams that <TutorialHighlight:meet the requirements> can proceed with the investigation."
  },
  Tutorial_20771_Title_1 = {
    Text = "Lightless Realm"
  },
  Tutorial_20772_Desc_1 = {
    Text = "When Keyflare reaches <TutorialHighlight:1000>, you can unleash your <TutorialHighlight:Posse>. You may unleash Posse twice per turn. During the second unleashing, you must select 1 from 3 random Posse options, and the chosen Posse cannot be reused during this investigation. Selecting the appropriate Posse for your team during lineup can make the investigation process smoother."
  },
  Tutorial_20772_Title_1 = {Text = "Posse"},
  Tutorial_20773_Title_1 = {
    Text = "Wheel of Destiny Ascension"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Covenant Upgrade> Enhances Covenant attributes up to level 12. Disassembling Covenants yields corresponding Remnants, which can be exchanged for <TutorialHighlight:Thousand Faces Seal> in the Inventory. Upgrading Covenants consumes <TutorialHighlight:Thousand Faces Seal>, and disassembling upgraded Covenants returns the consumed <TutorialHighlight:Thousand Faces Seal>."
  },
  Tutorial_22247_Title_1 = {
    Text = "Covenant Upgrade"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Transcription allows the <TutorialHighlight:Covenant> to obtain random attributes of various types and strengths. These attributes are not tied to specific equipment parts and may include Crit. Rate, Crit. DMG, Aliemus Regen Level, Keyflare Regen Level, Realm Mastery, Sigil Yield, DMG Amplification, and Death Resistance. During transcription, if you wish to retain a specific attribute, you can choose to <TutorialHighlight:Lock> it, ensuring that the locked attribute will remain unchanged during transcription."
  },
  Tutorial_22248_Title_1 = {
    Text = "Covenant Transcription"
  },
  Tutorial_23466_Desc_1 = {
    Text = "As your Keeper Level increases, the <TutorialHighlight:strength of Relics and Orisons> improves, and the <TutorialHighlight:impact of each CON point on team HP> for the Awakener increases. Investigations and Interludes yield significant Keeper EXP. Each point of Stamina Consumed grants 1 point of Keeper EXP."
  },
  Tutorial_23466_Title_1 = {
    Text = "Keeper Level"
  },
  Tutorial_47538_Desc_1 = {
    Text = "The D-Effect Zone is a high-difficulty gameplay system. Keepers need to flexibly coordinate multiple challenge teams to obtain as many Training Points as possible and thus earn more rewards. In High Alert difficulty, enemy units not only become stronger but also suffer from various debuff effects."
  },
  Tutorial_47538_Desc_2 = {
    Text = "The D-Effect Zone has unique restriction rules: the same Awakener and Posse, as well as identically named Wheels of Destiny, cannot be deployed repeatedly. The Keeper can flexibly choose the team for this challenge based on the initial Relics, Monsters, and recommended Levels, using a strategy similar to the horse race of Tian Ji to maximize the Training Points obtained. Awakeners deployed through the <TutorialHighlight:Support> system are not affected by this restriction."
  },
  Tutorial_47538_Title_1 = {
    Text = "D-Effect Zone"
  },
  Tutorial_54390_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, the <TutorialHighlight:states> possessed by both enemy and allied Awakeners in the battle interface will be displayed below their HP and Aliemus. Click to view the specific effects."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Belongs to <TutorialHighlight:Negative States> as follows (click for details): <PVPEntanglementKeywords:Entwined>, <PVPVulnerabilityIconKeywords:Vulnerable>, <PVPSlowKeywords:Stagnation>, <ComaKeywords:Petrify>, <DisarmKeywords:Paralysis>, <PVPMethysisKeywords:Poison>, <PVPEmptinessKeywords:Void>, <PVPBleedingKeywords:Bleed>, <PVPSeriousInjuryKeywords:Blighten>, <ComaKeywords:Fainted>."
  },
  Tutorial_54390_Title_1 = {Text = "State"},
  Tutorial_54391_Desc_1 = {
    Text = "In the <TutorialHighlight:Traphase> mode, some Awakener cards will have different <TutorialHighlight:affix> effects, which can be viewed in the <TutorialHighlight:Collection> system or by long-pressing the card during battle. The affixes include (click to view details): <PVPPenetrateKeywords:Pierce>, <PrepareKeywords:Prepare>, <PVPResurrectionKeywords:Revival>, <PVPHoldingKeywords:In Hand>, <PhantomKeywords:Phantasm>, <PVPRaidKeywords:Ambush>."
  },
  Tutorial_54391_Title_1 = {Text = "Affix"},
  Tutorial_54392_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, match points will reset at the end of each season and at the start of a new one. Information such as season names and durations can be viewed on the right side of the interface. When points are reset, players who had over 1,000 points in the previous season will have the excess portion halved."
  },
  Tutorial_54392_Title_1 = {Text = "Season"},
  Tutorial_54393_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, when an Awakener dies, the cards in hand that belong to that Awakener turn into <TutorialHighlight:Illusion>. Equipping the <TutorialHighlight:Wheel of Destiny> to a deceased Awakener grants 1 Illusion and refunds the consumed Arithmetica. Illusions can be combined with specific effects of the Wheel of Destiny to form <TutorialHighlight:Tiny Wish>."
  },
  Tutorial_54393_Title_1 = {Text = "Illusion"},
  Tutorial_54394_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, both players start with 3 <TutorialHighlight:Arithmetica> and a cap in the first turn. The second player receives a <TutorialHighlight:Strike Last, Strike Best> card. At the start of each subsequent turn, the Arithmetica cap and recovery amount increase by 1 until reaching 10. In addition to automatic growth, other methods can also increase or decrease the Arithmetica cap. Once the cap reaches 10, each additional point of cap overflow converts into drawing 1 card."
  },
  Tutorial_54394_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_54395_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, each <TutorialHighlight:Awakener> also has <TutorialHighlight:Aliemus> and <TutorialHighlight:Exalt>. Aliemus can be gained by using <TutorialHighlight:Strike> cards or specific <TutorialHighlight:Skill> cards, and by losing HP from damage (gain 1 Aliemus for every 2% HP or equivalent Shield lost). When Aliemus reaches 100, click the corresponding Awakener to unleash Exalt."
  },
  Tutorial_54395_Title_1 = {Text = "Aliemus"},
  Tutorial_54396_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, completing the specified objectives in the \"Match Records\" during matchmaking will allow you to receive corresponding rewards. This reward is a one-time reward and will not reset with the season. You can check it through the \"Match Records\" in the lower left corner of the interface."
  },
  Tutorial_54396_Title_1 = {
    Text = "Traphase Record"
  },
  Tutorial_54397_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, the \"Collection\" tab on the left side of the interface allows you to browse all information related to Awakeners, Wheels of Destiny, and Posses."
  },
  Tutorial_54397_Title_1 = {
    Text = "Collections"
  },
  Tutorial_54398_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, each <TutorialHighlight:Awakener> has 2 <TutorialHighlight:Strike> cards and 3 <TutorialHighlight:Skill> cards. Usually, different skill cards have different <TutorialHighlight:Arithmetica Cost> values."
  },
  Tutorial_54398_Title_1 = {Text = "Skill"},
  Tutorial_54399_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, you automatically draw 5 cards each turn, and the default <TutorialHighlight:Maximum Hand Size> is also 10. You can view your current hand count and maximum hand size at the bottom right of the battle interface, and the opponent's information is displayed at the top right. Other methods can change the number of cards drawn per turn and the maximum hand size."
  },
  Tutorial_54399_Title_1 = {Text = "Hand"},
  Tutorial_54400_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, different Awakeners have different <TutorialHighlight:roles>, totaling five. Specifically, they are <TutorialHighlight:Guardian>, <TutorialHighlight:Warborn>, <TutorialHighlight:Luminis>, <TutorialHighlight:Malphas>, and <TutorialHighlight:Blessing>. When forming a <TutorialHighlight:Lineup>, select 4 Awakeners with distinct roles to compose your team."
  },
  Tutorial_54400_Title_1 = {
    Text = "Traphase Roles"
  },
  Tutorial_54401_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase-All Pick>, clicking on \"Start Matching\" in the lower right corner of the interface will take you to the Lineup screen. You can also build your team in advance in the <TutorialHighlight:All Pick> on the left side of the interface."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Pre-built lineups support saving multiple configurations. The upper left corner allows editing of team names. Each team consists of 4 Awakeners, 4 Wheels of Destiny, and 2 Posses."
  },
  Tutorial_54401_Title_1 = {
    Text = "Preset Lineup"
  },
  Tutorial_54705_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase> mode, click your <TutorialHighlight:avatar>, select the desired <TutorialHighlight:Traphase Emote> to send, and express your feelings to your rival!"
  },
  Tutorial_54705_Title_1 = {Text = "Emote"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> is a two-player competitive game where each player uses their pre-constructed team for <TutorialHighlight:Match Battle>. The matchmaking system pairs you with opponents of similar skill levels."
  },
  Tutorial_54706_Desc_2 = {
    Text = "You can gain <TutorialHighlight:All Pick EXP> and <TutorialHighlight:Draft Pick EXP> through battles. Unlock higher <TutorialHighlight:All Pick Level> and <TutorialHighlight:Draft Pick Level> for <TutorialHighlight:One-Time Rewards>!"
  },
  Tutorial_54706_Desc_3 = {
    Text = [[
Every week, based on the points ranking, you will receive a <TutorialHighlight:Title> and obtain <TutorialHighlight:Rose Scrip> the next day. 
 If you participate in both "Traphase" and "Phantasmal Dive," the settlement of Rose Scrip will be based on the <TutorialHighlight:Higher> reward from these two gameplay options.]]
  },
  Tutorial_54706_Title_1 = {
    Text = "Introduction"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Different stages have different <TutorialHighlight:Chapter Environments>, which significantly change the overall rules and relic effects. Specific details can be viewed on each stage screen by clicking the relevant tab."
  },
  Tutorial_74798_Title_1 = {
    Text = "Investigation Chapters"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Awakener Reset> can refund various cultivation resources consumed by Awakeners."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Development Reset> will reset the Awakener's Level, Edify, Skills, and Gnostic Advance state. All consumed Materials and Gold Vouchers will be fully returned."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Enlightenment Reset> will reset the Awakener's Enlightenment state and the Level Cap gained through Enlightenment. All consumed Materials will be fully returned."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Genesis Return> will include the \"Development Reset\" effect and additionally reset the Awakener itself to an unlocked state."
  },
  Tutorial_81370_Title_1 = {
    Text = "Awakener Reset"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Awakener Upgrade> is one of the fastest ways to enhance Awakener attributes. Consumes <TutorialHighlight:Gnosis Elixir> to increase Awakener level."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Awakeners need to undergo <TutorialHighlight:Edify> to raise their Level Cap after reaching it, and Awakeners from different Realms require different <TutorialHighlight:Edify Materials>."
  },
  Tutorial_81371_Title_1 = {
    Text = "Awakener Upgrade"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Enlighten Activation> can greatly enhance the Command Card effects of Awakeners. Enlighten Level 7 unlocks <TutorialHighlight:Over-Exaltation>, granting additional effects when Awakeners enter Exalt. Enlighten Levels 11 and 15 increase the Level Cap of Awakeners by 5 levels."
  },
  Tutorial_81372_Title_1 = {
    Text = "Enlighten Activation"
  }
})
return Text_Tutorial
