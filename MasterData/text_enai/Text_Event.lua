__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116371_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_116371_Name = {Text = "Junction"},
  Event_116372_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116372_Desc = {
    Text = "You triggered an unknown room."
  },
  Event_116372_Name = {Text = "Unknown"},
  Event_116373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116373_Desc = {
    Text = "You found the treasure."
  },
  Event_116373_Name = {Text = "Treasure"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Connect] Restore Arg2 Life."
  },
  Event_116374_Desc = {
    Text = "Exploring in the Mist, suddenly, your badge emits a faint silver glow. Who is calling you through the communicator?"
  },
  Event_116374_Name = {Text = "Junction"},
  Event_116389_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116389_Desc = {
    Text = "Pinch is still asleep...zzZZ"
  },
  Event_116389_Name = {Text = "Pinch"},
  Event_116429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116429_Desc = {
    Text = "You triggered random event 3."
  },
  Event_116429_Name = {
    Text = "Random Event 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116430_Desc = {
    Text = "You triggered random event 1."
  },
  Event_116430_Name = {
    Text = "Random Event 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116431_Desc = {
    Text = "You triggered random event 2."
  },
  Event_116431_Name = {
    Text = "Random Event 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] Place 3 \"(Skill.Arg1)\" into your deck."
  },
  Event_117279_Desc = {
    Text = [[

A faint white mist rises from the sea, enveloping everything in a haze.
Crossing the boundary between life and death, spanning the distance inside and outside the gateway, traversing the long-faded memories, you see the silhouette of a lady holding a parasol against the light.
The time spent with her has already passed, just like her delicate yet vibrant youthful colors.
When the false sun finally rises, the mist shatters into nothingness, and her profile sways in the dream, transforming into light and illusory bubbles, bidding you a silent farewell.]]
  },
  Event_117279_Name = {
    Text = "Murphy's Illusion"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] Select 2 Cards to grant the \"Abyss Echo\" Orison."
  },
  Event_117280_Desc = {
    Text = [[

A faint white mist rises from the sea, enveloping everything in a haze.
Crossing the boundary between life and death, spanning the distance inside and outside the gateway, traversing the long-faded memories, you see the silhouette of a lady holding a parasol against the light.
The time spent with her has already passed, just like her delicate yet vibrant youthful colors.
When the false sun finally rises, the mist shatters into nothingness, and her profile sways in the dream, transforming into light and illusory bubbles, bidding you a silent farewell.]]
  },
  Event_117280_Name = {
    Text = "Murphy's Illusion"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_118414_Desc = {
    Text = [[
The dice roll, emitting a gurgling sound.
When will it stop?
You don't know, but you must give an answer.]]
  },
  Event_118414_Name = {
    Text = "Gamble of Fate"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118415_Desc = {
    Text = [[
Your response softens the "Sky."
It gently kisses your forehead.
And there, a wave-shaped flower blooms.]]
  },
  Event_118415_Name = {
    Text = "Embrace of the Sea"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Indulged in Fantasies] Choose 1 from 3 command cards to gain advanced Orison: \"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Maintain Sanity] Gain 15 Black Sigils for each Awakener with 50 or more Aliemus"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Leave by Force] Gain 1 out of 3 Orisons"
  },
  Event_118416_Desc = {
    Text = "Perhaps the long battle has left you disoriented, or perhaps your mind has betrayed your body.\nA sense of weightlessness fills your thoughts.\nIn an instant, your mind becomes a kaleidoscope—dazzling, brilliant, flashing with every color.\nCountless insights, musings, and fantasies flood your mind, filling every crevice.\nIf this continues, your brain will soon burst from the chaos."
  },
  Event_118416_Name = {
    Text = "Kaleidoscope of Thought"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Join the Gamble] Develop \"(Skill.Arg1)\", enter the gamble"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Forget It] Obtain 25 Black Sigils"
  },
  Event_118417_Desc = {
    Text = [[
In a state of daze, your consciousness drifted through layers of mist, scattering into the unknown space.
Two dice were tossed in front of you, but the unknown existence that forcibly brought you here remained unseen.
You could only hear the chaotic voices from all directions.
"Want to go back? Then let's play a round."
"With your life as the stake, let the gamble with fate begin."]]
  },
  Event_118417_Name = {
    Text = "Gamble of Fate"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118418_Desc = {
    Text = "Transcendent experiences are fleeting. They arrive without warning and vanish just as suddenly.\nBut at least your head remains intact—it did not truly explode."
  },
  Event_118418_Name = {
    Text = "Kaleidoscope of Thought"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_118419_Desc = {
    Text = [[
You did not lose, but neither did you win; the result is neither good nor bad.  
"It's a tie..."  
The unknown existence sighed, yet there was no trace of regret in their voice.  
"What a nice little pastime."]]
  },
  Event_118419_Name = {
    Text = "Gamble of Fate"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118420_Desc = {
    Text = "Slowly, the frenzied melody transforms into something harmonious and sacred.\nYou finally understand why it is called the \"Perfect Hymn\"—\nfor it is, in truth, flawless."
  },
  Event_118420_Name = {
    Text = "The \"Perfect\" Hymn"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Choose 1 from 3 command cards to gain Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Develop \"(Skill.Arg1)\", reimprint, up to 2 times"
  },
  Event_118421_Desc = {
    Text = [[
A person's first cage is their own body.
In this cage, the brain is the last and most important prison.
"Sweetheart, do you think that just because you're alive and breathing, you're safe?"
When your brain betrays your soul, you will experience the most painful torment in the world.
And this torment will accompany you for a lifetime.]]
  },
  Event_118421_Name = {
    Text = "Cerebral Prison"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Touch the Butterfly] Delete 2 cards"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Drive Away the Butterfly] Obtain Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_118422_Desc = {
    Text = [[
There are no butterflies in the deep sea. They are the dreams of a girl trapped in a room.
So beautiful, dancing freely in the air.
"If only... I could fly away like them..."
A butterfly sobs, its cry drowned out by fluttering wings and the clatter of typewriters.]]
  },
  Event_118422_Name = {
    Text = "The Soul Dances Like A Butterfly"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cut the Rope] Develop \"(Skill.Arg1)\", gain Cursed Relic \"(RelicConfig.Arg2)\""
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Loosen His Bonds] Develop \"(Skill.Arg1)\" twice, gain Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\""
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Help Him Break Free] Gain Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_118423_Desc = {
    Text = [[
"Some say endless desire is the driving force for progress.
But when that desire grows so powerful it can no longer be ignored or severed... I feel it transform from within into a cage."
A weak voice emerged from the darkness. You could not see the speaker's face, only a pair of bound hands.
"These desires feed on my fear, my weakness, my hope, my pain... and in doing so, they only grow stronger."
The voice issued one final, desperate plea.
"I am willing to sacrifice everything! Kind soul, please... save me. Or grant me release."]]
  },
  Event_118423_Name = {
    Text = "Binding Desires"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Choose 1 from 3 command cards to gain Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_118424_Desc = {
    Text = [[
You felt a twitch in your brain matter.
"Does this have any special significance?"
You asked yourself, but your brain remained silent.
Not every query towards oneself yields an answer.]]
  },
  Event_118424_Name = {
    Text = "Cerebral Prison"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118425_Desc = {
    Text = "You swim desperately upward and break the surface.\nAir, thick with the scent of the sea, floods your lungs—a reminder that danger still lingers.\nBut you know the true sky is above you.\nJust like the truth, it cannot be obscured by gentle lies."
  },
  Event_118425_Name = {
    Text = "Embrace of the Sea"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118426_Desc = {
    Text = "The moment you touch the rope of Desire, a sharp pain surges from the depths of your soul.\nYour fear, weakness, hope, and agony surge forth, twisting into a bloodied cord that binds your hands.\nIn that instant, you hear a voice cheer with malice.\n\"Good-hearted one, you shall be rewarded… and cursed.\""
  },
  Event_118426_Name = {
    Text = "Binding Desires"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118427_Desc = {
    Text = [[
Your touch makes the butterflies tremble.
Since their creation, they have never known such gentleness.
Overwhelmed, they forget how to fly.
Countless butterflies tumble down, revealing the typewriter hidden beneath their wings.
That pitiful device, now lifeless, used its last strength to type a single word: "freedom."]]
  },
  Event_118427_Name = {
    Text = "The Soul Dances Like A Butterfly"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Prepare for Battle] Choose 1 from 3 command cards to gain advanced orison: \"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Try to Detour] Gain 25 Black Sigils"
  },
  Event_118428_Desc = {
    Text = [[
In the starlit deep, the Seafarers have slumbered for centuries.
The boundless sea has witnessed their madness, their endurance, and their most devout faith.
None may hinder the great coming of their God.
Those who stand in the way shall be turned to ash by the Seafarers' wrath.]]
  },
  Event_118428_Name = {
    Text = "Vigil Under the Stars"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118429_Desc = {
    Text = [[
You instinctively cover your ears.
Miraculously, the sound from deep within your soul falls silent.
But it is only temporary.]]
  },
  Event_118429_Name = {
    Text = "Desecrating Melody"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Revisit the Past] Obtain 1 out of 3 Advanced Orisons"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Gain Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_118430_Desc = {
    Text = "Nothing in this world remains unchanged—\nnot even the paradise shaped by the Divine Mother.\nFor a fleeting moment, you glimpse something through a crack in time.\nPast, present, and future intertwine within that fissure, shifting endlessly,\nawaiting your curious gaze."
  },
  Event_118430_Name = {Text = "Time Rift"},
  Event_118431_ChoiceDesc1 = {
    Text = "[Tune] Receive 100 Black Sigils"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[Resonate] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards."
  },
  Event_118431_Desc = {
    Text = "The formless will rejects your choice. It offers you another chance to change your path—\nBeware, even formless music can claim lives."
  },
  Event_118431_Name = {
    Text = "The \"Perfect\" Hymn"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Feed the Rats] Gain Silver Relic \"(RelicConfig.Arg1)\", develop 1 Symptom"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Drive the Rats Away] Engrave Orison on 1 out of 3 cards:\"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignore the Rats] Gain 25 Black Sigils"
  },
  Event_118432_Desc = {
    Text = "Everything on this ship is trapped in the time loop.\nEven those disgusting, furry little creatures struggling to survive here cannot escape their fate.\nCycle after cycle, they devour everything in sight, yet their hunger is never sated.\n\"So... hungry...\"\nHordes of rats emit sickly, piercing shrieks.\nThe endless cycles have left them ravenous and deranged—they must eat something.\nNow. Immediately."
  },
  Event_118432_Name = {
    Text = "Hungry Rat Pack"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Avoid Their Gaze] Gain Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Stare into the Eyes] Randomly rouse 2 awakeners, but develop \"(Skill.Arg1)\" twice"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_118433_Desc = {
    Text = [[
Just like the stars in the sky, there are certainly many eyes in the deep sea.
Those eyes belong to fish living at the ocean floor, to the desecrated gill species, and to the ocean itself.
Shh, don't disturb them.
Don't, disturb the madness of the deep sea.]]
  },
  Event_118433_Name = {
    Text = "Eye of the Deep Sea"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignore the Whispers]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Listen to the Whispers]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Make Something Up]"
  },
  Event_118434_Desc = {
    Text = [[
"Do you desire the favor of God? Do you want to know your own significance?"
A sigh sounded in your ear, like the self-whisper of a mentally disturbed person, or the intimate whisper of something formless.
Under reason and vigilance, you reject that voice, but it continues to speak to itself.
"Please listen patiently. What you will know is the truth concerning the world's fate..."]]
  },
  Event_118434_Name = {
    Text = "Preaching of the Intangible"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Choose 1 from 3 command cards to gain Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Develop \"(Skill.Arg1)\", randomly imprint again"
  },
  Event_118435_Desc = {
    Text = [[
The brain, safely protected within the skull, conveyed certain messages to you.
You don't know if these messages were worn down during the conversion of neurotransmitters and the transmission of bioelectric currents.
The only certain fact is that you received the information and sensed your existence through the objective presence of your body.]]
  },
  Event_118435_Name = {
    Text = "Cerebral Prison"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Leave] Gain 50 Black Sigils"
  },
  Event_118436_Desc = {
    Text = [[
"Good answer, but unfortunately, not the correct answer."
"What is the correct answer?"
The unknown existence did not answer your question, only releasing a disdainful laugh.
"Who told you that fate has a correct answer?"]]
  },
  Event_118436_Name = {
    Text = "Gamble of Fate"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118437_Desc = {
    Text = "\"Do you think I haven't tried to sever them? No—resisting desire only makes it stronger!\"\nAs the ropes of desire tighten, cutting into flesh, the voice releases a desperate howl.\n\"I can never be free of them... never!\""
  },
  Event_118437_Name = {
    Text = "Binding Desires"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 25 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_118438_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_118438_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118439_Desc = {
    Text = [[
As the butterflies fade, you finally see the typewriter below.
That poor, lifeless thing used its final breath to type two words: "Leave now."]]
  },
  Event_118439_Name = {
    Text = "The Soul Dances Like A Butterfly"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118440_Desc = {
    Text = [[
In the shadow of the past, a girl in a fluffy coat waves to you.
You cannot hear her words, but you see her smile.]]
  },
  Event_118440_Name = {Text = "Time Rift"},
  Event_118441_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118441_Desc = {
    Text = [[
The deep sea returns to silence and shadow.
In that stillness, you hear the heartbeat once more.
This time, it comes from within you.
To others, you are but a beating heart adrift in the abyss.]]
  },
  Event_118441_Name = {
    Text = "Survival of the fittest"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118442_Desc = {
    Text = [[
This time, it is not the obstacle, but the Seafarers, who turn to ash.
The stars gaze silently upon the scene, as they have for centuries, offering no reply.]]
  },
  Event_118442_Name = {
    Text = "Vigil Under the Stars"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118443_Desc = {
    Text = [[
Despite their numbers, the filthy rats possess more courage than strength.
Intimidated by your resolute stance, they scatter in panic.]]
  },
  Event_118443_Name = {
    Text = "Hungry Rat Pack"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Reach Out a Helping Hand] Randomly awaken 1 awakener, but develop \"(Skill.Arg1)\""
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Silently Observing] Obtain 1 out of 3 Orisons"
  },
  Event_118444_Desc = {
    Text = "A beating heart drifts in the pitch-black deep.\nIt may belong to a swimming fish, or some gilled creature.\nYou cannot see clearly—only the pulsing heart, and behind it, a bloody maw slowly opening.\nTo hunt or be hunted is the law of nature,\nwhether on land or in the sea."
  },
  Event_118444_Name = {
    Text = "Survival of the fittest"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Wave Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Let It Stay] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_118445_Desc = {
    Text = "A faint sound emerges from the darkness.\nIt is a butterfly, politely asking:\n\"May I rest in your palm?\"\n\"I am only so tired... I wish to rest a moment.\"\nAs it asks, the butterfly spirals toward you through the dark.\nBlack, viscous liquid drips from its wings—a gift from the shadows it passed through."
  },
  Event_118445_Name = {
    Text = "Butterfly's Request"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_118446_Desc = {
    Text = [[
After a moment of silence, something was tossed into your arms.
"Take it and leave."
"Fate is always generous to the fortunate."]]
  },
  Event_118446_Name = {
    Text = "Gamble of Fate"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Following the Guidance] Choose 1 from 3 command cards to obtain advanced Orison:\"(EnchantConfig.Arg1)\", but develop\"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Ignore the Guidance] Choose 1 from 3 command cards to gain advanced Orison: \"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_118447_Desc = {
    Text = "The festival has begun.\nAmid spiritual flames and blood-soaked blessings, countless believers have become living torches—\nEthereal souls scatter around you like guiding sprites, glowing, awaiting your choice."
  },
  Event_118447_Name = {
    Text = "Soul Beacon"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Leave] Obtain 50 Black Sigils, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_118448_Desc = {
    Text = [[
"Ignorant Humans!"
That voice emitted a frustrated complaint, but not to the point of anger.
For it knows, the ignorant will always have moments of enlightenment.
It only needs to wait for that day to come.
And before that day arrives, it will mark you with the seal of God, confirming the belonging of your Soul.]]
  },
  Event_118448_Name = {
    Text = "Preaching of the Intangible"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118449_Desc = {
    Text = "[@2 of @3……]\nA flood of knowledge, accompanied by that blasphemous tune, rushes into your brain.\nBut your mortal form limits you, rendering cosmic wisdom beyond your grasp.\nWhat a sorrowful regret."
  },
  Event_118449_Name = {
    Text = "Desecrating Melody"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Leave] Obtain 50 Black Sigils, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_118450_Desc = {
    Text = [[
"Actually, I also have a truth about the world that I want to tell you..."
"The world is created by a flying pasta god composed of two wise meatball eyes and pasta symbolizing infinite ability..."
You seriously make up a funny story you heard, waiting for the other party's reaction.
But after a long time, the other side remains silent.
"Alas, it seems fervent believers don't understand humor."
Sighing, you can only leave.]]
  },
  Event_118450_Name = {
    Text = "Preaching of the Intangible"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118451_Desc = {
    Text = [[
Your tuning fails to bring harmony to the chaotic syllables.
Yet the unseen will has acknowledged your effort.
It is a beginning.]]
  },
  Event_118451_Name = {
    Text = "The \"Perfect\" Hymn"
  },
  Event_118452_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118452_Desc = {
    Text = [[
Three figures trembled, silently weeping.
Their faith was doubted by you, and that was the greatest offense a fanatic could not tolerate.]]
  },
  Event_118452_Name = {
    Text = "The Best Sacrifice"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118453_Desc = {
    Text = [[
In the future's imagery, the girl with tentacles glanced at you disdainfully and scolded.
"The true form of the Divine Mother cannot be desecrated."
Then, the imagery disappeared, and the time-space rift closed instantly, leaving you to recall the scene from just now.]]
  },
  Event_118453_Name = {Text = "Time Rift"},
  Event_118454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118454_Desc = {
    Text = [[
You evade the Seafarers and press onward.
Above, the stars glimmer softly, as they have for millennia.]]
  },
  Event_118454_Name = {
    Text = "Vigil Under the Stars"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118455_Desc = {
    Text = [[
The unknown existence did not obstruct you.
"One day, you will return again."
"No one can refuse fate."]]
  },
  Event_118455_Name = {
    Text = "Gamble of Fate"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118456_Desc = {
    Text = [[
With one swift, decisive motion, the hands go limp.
But you do not miss the final sigh of the other.
At last, he is free from his endless desires.]]
  },
  Event_118456_Name = {
    Text = "Binding Desires"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118457_Desc = {
    Text = [[
Not being perceived is the inevitable fate of the world.
No one can completely empathize with another being.]]
  },
  Event_118457_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 35 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_118458_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_118458_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Listen Closely] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Plug Ears] Engrave 1 out of 3 Orisons"
  },
  Event_118459_Desc = {
    Text = [[
In the formless frenzy, you glimpse a piano.
A pair of indistinct hands dances across intangible keys, playing a profane melody.
The bizarre music echoes from the depths of your soul, traveling through your veins, reaching your trembling mind.]]
  },
  Event_118459_Name = {
    Text = "Desecrating Melody"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118460_Desc = {
    Text = "Those inspirations, thoughts, and fantasies weave together, blending into the most brilliant colors imaginable.\nYou see space folding within your body, time swirling at your command.\nIn this moment, you are omnipotent, omniscient—one with time and space.\nBut such power always comes at a cost."
  },
  Event_118460_Name = {
    Text = "Kaleidoscope of Thought"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118461_Desc = {
    Text = [[
The chaotic soul guides your path with shrill wails.
Is it safe? You cannot know.
Your only choice is to move forward.]]
  },
  Event_118461_Name = {
    Text = "Soul Beacon"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 40 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Ignore It] Obtain 25 Black Sigils and leave."
  },
  Event_118462_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_118462_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118463_Desc = {
    Text = "The chaotic soul releases a mournful sigh.\nIt fades slowly, yet that sorrowful sound, almost tangible, settles upon your heart.\nThump, thump—your heartbeat synchronizes with the ritual's melody."
  },
  Event_118463_Name = {
    Text = "Soul Beacon"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_118464_Desc = {
    Text = [[
"Ah, ah, what a devout lamb this is!"
That voice sighs, filled with jubilant praise.
"When my lord awakens, lambs like you will surely find a place to reside in that Exalted and great Divine Realm..."]]
  },
  Event_118464_Name = {
    Text = "Preaching of the Intangible"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118465_Desc = {
    Text = [[
"The Sky" embraces your unruliness.
One day, the lost child will return to the mother's embrace.
Because you have nowhere to run.]]
  },
  Event_118465_Name = {
    Text = "Embrace of the Sea"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Accept the Embrace] Gain Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Reject the Embrace] Gain Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Swim to the Surface] Gain 25 Black Sigils"
  },
  Event_118466_Desc = {
    Text = "The world is pouring out through your eyes.\nIn this moment, the deep sea surrounding you becomes the \"Sky.\"\nIn the agony of near-drowning, this deep blue \"Sky\" draws near, intent on embracing you.\nIt does not judge—it only gives."
  },
  Event_118466_Name = {
    Text = "Embrace of the Sea"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Scold Them] Gain Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Respond to Them] Choose 1 from 3 command cards to gain advanced Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignore Them] Gain 50 Black Sigils"
  },
  Event_118467_Desc = {
    Text = [[
Three vaguely shaped souls blocked your path.
One figure bowed solemnly to you, pleading for you to grant blood. Your flowing blood is the best sacrifice to the gods.
One figure coldly raised a knife to you, intending to carve your flesh. That unmutated human flesh would surely win the gods' favor.
The last one silently watched you, hoping you would take your own life to prove the most devout faith.]]
  },
  Event_118467_Name = {
    Text = "The Best Sacrifice"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 30 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_118468_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_118468_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_118469_Desc = {
    Text = [[
"No! We refuse this! We crave something more... delectable."
"Then it shall be... your blood and flesh!"
A swarm of rats screeches, surging toward you.
It seems an overflowing good heart can sometimes bring more trouble than relief.]]
  },
  Event_118469_Name = {
    Text = "Hungry Rat Pack"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118470_Desc = {
    Text = [[
Your respect wins the favor of those unseen eyes.
Before vanishing, they send a gift through the surging sea:
a mark of the Deep Sea's claim upon you.]]
  },
  Event_118470_Name = {
    Text = "Eye of the Deep Sea"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118471_Desc = {
    Text = "Beneath your unflinching gaze, the deep sea slowly stirs.\nChaotic waves churn around you, carrying indescribable murmurs.\nFeel the wrath of the abyss—a blessing and a curse entwined."
  },
  Event_118471_Name = {
    Text = "Eye of the Deep Sea"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 20 black sigils, but develop \"(Skill.Arg2)\""
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_118472_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_118472_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118473_Desc = {
    Text = [[
Blood, flesh, life.
The sacrifice is ready, now all you have to do is quietly await the divine feast.]]
  },
  Event_118473_Name = {
    Text = "The Best Sacrifice"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118474_Desc = {
    Text = [[
The butterfly understands your refusal.
Its wings, coated in pitch, tremble once more as it flutters unsteadily in the dark.
Soon, the shadows swallow it again. This time, it lacks the strength to struggle.]]
  },
  Event_118474_Name = {
    Text = "Butterfly's Request"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118475_Desc = {
    Text = [[
The butterfly alights in your palm, along with the black ooze from its colored wings.
As you sigh, the vibrant wings slowly melt, merging with the tar into an indistinct, chaotic form.
This butterfly will never again know darkness.
It sleeps peacefully in your hand.]]
  },
  Event_118475_Name = {
    Text = "Butterfly's Request"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118477_Desc = {
    Text = [[
The hoarse crow finally closed its eyes.
In the unacknowledged and unnoticed resentment, it breathed its last, turning into a puddle of black sludge.]]
  },
  Event_118477_Name = {
    Text = "Unperceived Grievance"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118478_Desc = {
    Text = [[
"Thank you..."
The beating heart leaps toward the horizon.
Soon, the sound of flesh being chewed echoed from the pitch-black Aequor.]]
  },
  Event_118478_Name = {
    Text = "Survival of the fittest"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Accept the Invitation] Develop \"(Skill.Arg1)\", gain Cursed Relic\"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Refuse the Invitation] Choose to destroy 1 Relic and gain 1 Reward"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_118479_Desc = {
    Text = [[
"Everything on this ship must become part of this endlessly disintegrating and restarting paradise."
The frenzied melodies resonated in your mind, a revelation from the intangible will.
"There are no tears here, no sadness, only pure sacred music and eternal laughter."
"Do you wish to join the paradise and become part of this perfect melody?"]]
  },
  Event_118479_Name = {
    Text = "The \"Perfect\" Hymn"
  },
  Event_118480_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118480_Desc = {
    Text = [[
In your silence, souls silently dissipate.
Those who do not understand the believers are not worth their time.]]
  },
  Event_118480_Name = {
    Text = "The Best Sacrifice"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Claim Standard Relic]"
  },
  Event_123616_Desc = {
    Text = [[
Set all Awakeners' Aliemus to 100, set Keyflare to 1000, and set HP to 80%.
Remove 2 Cards and insert 3 Symptom Cards.
Set Crimson Furnace to 12.5%, select 4 Cards to place in Ultra Space.
Obtain Standard Relic Pack.]]
  },
  Event_123616_Name = {
    Text = "Skip the Path"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125696_Desc = {
    Text = [[
You close your eyes and turn to walk into the wilderness.
You can sense the hidden desire and omen, but you will never be able to quell it with your own hands.
You look around at the nameless gravestones. Perhaps this is how your story ends.]]
  },
  Event_125696_Name = {
    Text = "Feast of ravens"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125697_Desc = {
    Text = [[
The planchette moves confidently, your gaze following its every motion.
However, it barely indicates two letters before dissolving into a viscous black goo with a pitiful scream.]]
  },
  Event_125697_Name = {
    Text = "Spirit board"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Wave Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Let It Stay] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Leave] Gain 25 black sigils"
  },
  Event_125698_Desc = {
    Text = "A faint sound emerges from the darkness.\nIt is a butterfly, politely asking:\n\"May I rest in your palm?\"\n\"I am only so tired... I wish to rest a moment.\"\nAs it asks, the butterfly spirals toward you through the dark.\nBlack, viscous liquid drips from its wings—a gift from the shadows it passed through."
  },
  Event_125698_Name = {
    Text = "Butterfly's Request"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125699_Desc = {
    Text = [[
"Dear Ms. Sarah:
I hereby resign from my position as a caregiver at the workhouse.
I can no longer support your philosophy. Your teachings are misguided; the children of the East District should not grow up under your influence, nor should they believe in pure kindness and selfless giving.
One day, they will step out from under your wings to learn the survival rules of the East District.
....."

The rest of the letter is blurred and illegible, stained by a dark liquid.]]
  },
  Event_125699_Name = {Text = "Ghost ink"},
  Event_125700_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125700_Desc = {
    Text = "\"As I sit in the shadow of years, feeling the icy hand of death creeping closer, the world outside grows ever dim, filled with whispers of calamity. I fear the impending judgment, the reckoning for our folly. The streets are filled with an ominous aura; I worry that our Judgment Day is fast approaching. Our civilization teeters on the brink, as if about to be devoured by destruction, trapped by our own foolish arrogance.\""
  },
  Event_125700_Name = {
    Text = "Last words' whisper"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125701_Desc = {
    Text = "You stare intently at the Eye, trying to decipher the message it conveys.\nAlthough you have long been battle-hardened, this time facing Goliath... fear grips your heart.\n\"Almost Normal— it's the quietest form before the Cataclysm occurs.\""
  },
  Event_125701_Name = {
    Text = "Almost normal"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_125702_Desc = {
    Text = [[
"Click."
The sound of the typewriter rang out, and until the 'work' is done, you will forever be its slave.]]
  },
  Event_125702_Name = {
    Text = "Eternal torment"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 35 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_125703_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_125703_Name = {
    Text = "Unperceived grievance"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Duplicate 1 of 3 Command Cards"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[Discern Woman's Voice] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] Receive 25 Black Sigils"
  },
  Event_125704_Desc = {
    Text = "You stand alone in a dark swamp.\nThrough the haze, you hear chaotic murmurs overlapping like tides—some from quavering elders, some from babbling children, some from anxious women, and some from men gripped by nameless dread..."
  },
  Event_125704_Name = {
    Text = "Last Words' Whisper"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Look Up] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Black Sigil] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_125705_Desc = {
    Text = [[
Crows swirl in the sky like a hesitant saw, repeatedly cutting through the spine of the heavens.
They fly low around you, as if foreseeing your death, patiently awaiting the start of the feast.]]
  },
  Event_125705_Name = {
    Text = "Feast of Ravens"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125706_Desc = {
    Text = [[
In the shadow of the past, a girl in a fluffy coat waves to you.
You cannot hear her words, but you see her smile.]]
  },
  Event_125706_Name = {Text = "Time rift"},
  Event_125707_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 20 black sigils, but develop \"(Skill.Arg2)\""
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_125707_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_125707_Name = {
    Text = "Unperceived grievance"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125708_Desc = {
    Text = [[
"What I can offer the children is only a roof to shield them from the rain and just enough food to keep them from starving. If it weren't for the kind Mr. Rogers bringing in the doctor, they wouldn't even get a single pill when they fall ill.
I haven't read many books; ensuring they don't freeze or starve to death on the streets is all I can do.
I have never interfered with what kind of people they choose to become, but they need to survive.
....."]]
  },
  Event_125708_Name = {Text = "Ghost ink"},
  Event_125709_ChoiceDesc1 = {
    Text = "[Drive Away the Butterflies] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen to Their Wish] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Leave] Gain 25 black sigils"
  },
  Event_125709_Desc = {
    Text = [[
The little butterfly carries many dreams.
These dreams scatter in the sea of flowers, in the ward, and in the altar filled with much blood and flesh of @2.
Finally, it has awaited its bond, not knowing if you are willing to listen to its little, little wish.]]
  },
  Event_125709_Name = {
    Text = "Lepidopteran Dream"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125710_Desc = {
    Text = [[
Not being perceived is the inevitable fate of the world.
No one can completely empathize with another being.]]
  },
  Event_125710_Name = {
    Text = "Unperceived grievance"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Lean Out] Acquire the Golden Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Give Up Checking] Receive 50 Black Sigils"
  },
  Event_125711_Desc = {
    Text = "There seems to be a roll of film stuck under the operating table."
  },
  Event_125711_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Choose 1 from 3 command cards to gain Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Develop \"(Skill.Arg1)\", reimprint, up to 2 times"
  },
  Event_125712_Desc = {
    Text = [[
A person's first cage is their own body.
In this cage, the brain is the last and most important prison.
"Sweetheart, do you think that just because you're alive and breathing, you're safe?"
When your brain betrays your soul, you will experience the most painful torment in the world.
And this torment will accompany you for a lifetime.]]
  },
  Event_125712_Name = {
    Text = "Cerebral Prison"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125713_Desc = {
    Text = [[
"Heh, insignificant human, you made the wrong choice."
The black cats stare coldly at you, then suddenly retaliate.
"Though we have respect for the brave, you must pay the price."]]
  },
  Event_125713_Name = {Text = "Nigelman"},
  Event_125714_ChoiceDesc1 = {
    Text = "[Continue Observation] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Look Away] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_125714_Desc = {
    Text = "In a damp corner of the ancient castle, you discovered that roll of film.\nThe images resemble phantoms drowned in the river of time, freezing in slow motion—sometimes expanding into indescribable colossal forms, sometimes collapsing into flickering stars.\nLost within them, a sudden dizziness reminded you of the passage of time."
  },
  Event_125714_Name = {
    Text = "Shadows of The Past"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125715_Desc = {
    Text = [[
"Wait, wait!!"
"Ask me! Why don't you ask!"]]
  },
  Event_125715_Name = {
    Text = "Spirit board"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Join the Prayer] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Sink into Ocean] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surface] Receive 25 Black Sigils"
  },
  Event_125716_Desc = {
    Text = [[
"Gentle God, Almighty God.
Please calm the fierce storm and block the raging currents.
Let the ocean become our profound home, shrouding our kingdom in an eternal veil..."
The whispers of the devout finally form words you can understand, but with them comes an inescapable suffocation.]]
  },
  Event_125716_Name = {
    Text = "Dream Prayer"
  },
  Event_125717_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125717_Desc = {
    Text = [[
The butterfly alights in your palm, along with the black ooze from its colored wings.
As you sigh, the vibrant wings slowly melt, merging with the tar into an indistinct, chaotic form.
This butterfly will never again know darkness.
It sleeps peacefully in your hand.]]
  },
  Event_125717_Name = {
    Text = "Butterfly's request"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Reach Out a Helping Hand] Randomly awaken 1 awakener, but develop \"(Skill.Arg1)\""
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Silently Observing] Obtain 1 out of 3 Orisons"
  },
  Event_125718_Desc = {
    Text = "A beating heart drifts in the pitch-black deep.\nIt may belong to a swimming fish, or some gilled creature.\nYou cannot see clearly—only the pulsing heart, and behind it, a bloody maw slowly opening.\nTo hunt or be hunted is the law of nature,\nwhether on land or in the sea."
  },
  Event_125718_Name = {
    Text = "Survival of the fittest"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125719_Desc = {
    Text = [[

"Mother, after losing friends, husband, and son, I have now eternally lost Diana, my little daughter."
"When she turned to ashes before me, my mind went blank..." The subsequent writing is no longer legible.
You can only turn to read the next line.
I have made up my mind. If I see you again, please do not blame me; I just... miss you all too much.]]
  },
  Event_125719_Name = {
    Text = "Fading Longing"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125720_Desc = {
    Text = [[
"Click. Click. Click"
The 'work' is finally completed, but apart from the 'work' itself, what else did you gain?]]
  },
  Event_125720_Name = {
    Text = "Eternal torment"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125721_Desc = {
    Text = [[
The cheap fabric feels a bit coarse to the touch, but it has still been carefully cleaned.
Take good care of it and wait for the day it is returned to its rightful owner.]]
  },
  Event_125721_Name = {
    Text = "White eyepatch"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 25 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_125722_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_125722_Name = {
    Text = "Unperceived grievance"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125723_Desc = {
    Text = "\"...The city is no longer a warm refuge, but a hidden grave, nurturing terror and despair. Those once-vivid dreams now remain as shards of fear. I can no longer pretend to be fearless; the world before me is like a nightmare from which I cannot awaken.\""
  },
  Event_125723_Name = {
    Text = "Last words' whisper"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Take a Gamble] Develop \"(Skill.Arg1)\" and try your luck"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Forget It] Obtain 25 Black Sigils"
  },
  Event_125724_Desc = {
    Text = [[
In the deep black mist at the street corner, a suffocating aura spreads.
Within the mist, two ancient and chilling dice emerge, their surfaces covered with inscrutable symbols and eerie patterns.
They lie quietly on the slick tablets as if awaiting some unknown summon.
"You know who I am. Care to take a gamble?"]]
  },
  Event_125724_Name = {
    Text = "N's Message"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Read] Destroy a Command Card, and receive 25 Black Sigils."
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Continue Typing] Duplicate a Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_125725_Desc = {
    Text = [[
The printer is violently spewing ink.
Black ink gushes from the nozzle like a ghost, filling the air and forming a thick, oppressive black mist.
There seems to be a hidden hint in the keyboard, waiting for innocent fingers to touch it.]]
  },
  Event_125725_Name = {Text = "Ghost Ink"},
  Event_125726_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125726_Desc = {
    Text = [[
"Shut up, shut up, you sound terrible."
The black cat covers its ears with its paws in a uniquely human manner.
"Human, your cat-speak is very poor, what you're saying makes no sense!"
Though it says this, the expression of the black cat softens.
"Given that you meowed to please me, I shall leave you with a gift."
"As for the content of the gift, it depends on your luck."]]
  },
  Event_125726_Name = {Text = "Nigelman"},
  Event_125727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125727_Desc = {
    Text = [[
You avert your gaze, avoiding meeting her eyes.
Yet some force still makes your heart race anxiously.]]
  },
  Event_125727_Name = {Text = "Final gaze"},
  Event_125728_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_125728_Desc = {
    Text = [[
"Click. Click."
The sound of the typewriter rang out, and during the 'work,' you are merely a tool to complete the 'work.']]
  },
  Event_125728_Name = {
    Text = "Eternal torment"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_125729_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_125729_Name = {
    Text = "N's message"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125730_Desc = {
    Text = [[
"I want flowers to bloom forever, I want smiles to last eternally."
"I wish that all those afflicted by Dissolution can recover in peace, I wish this world could return to its past and stop burning."
"I want..."
The little butterfly flapped its wings, losing its vitality in the palm of your hand.
At least, someone has listened to its voice.]]
  },
  Event_125730_Name = {
    Text = "Lepidopteran dream"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125731_Desc = {
    Text = [[

In response to your drive away, the butterfly remains indifferent.
It is persistently chasing your palm, losing its vitality within the palm of your hand.
"Ah, so warm..."
This was its final whisper.]]
  },
  Event_125731_Name = {
    Text = "Lepidopteran dream"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125732_Desc = {
    Text = [[
The black smoke quivers in despair.
Then the dice vanish in the blink of an eye.

Only one question lingers in your mind:
What are these dice truly made of?]]
  },
  Event_125732_Name = {
    Text = "N's message"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Accept the Invitation] Develop \"(Skill.Arg1)\", gain Cursed Relic\"(RelicConfig.Arg2)\""
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Refuse the Invitation] Choose to destroy 1 Relic and gain 1 Reward"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Leave] Gain 50 black sigils"
  },
  Event_125733_Desc = {
    Text = [[
"Everything on this ship must become part of this endlessly disintegrating and restarting paradise."
The frenzied melodies resonated in your mind, a revelation from the intangible will.
"There are no tears here, no sadness, only pure sacred music and eternal laughter."
"Do you wish to join the paradise and become part of this perfect melody?"]]
  },
  Event_125733_Name = {
    Text = "The \"Perfect\" Hymn"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Tune] Receive 100 Black Sigils"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[Resonate] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards."
  },
  Event_125734_Desc = {
    Text = "The formless will rejects your choice. It offers you another chance to change your path—\nBeware, even formless music can claim lives."
  },
  Event_125734_Name = {
    Text = "The \"perfect\" hymn"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125735_Desc = {
    Text = [[
Your tuning fails to bring harmony to the chaotic syllables.
Yet the unseen will has acknowledged your effort.
It is a beginning.]]
  },
  Event_125735_Name = {
    Text = "The \"perfect\" hymn"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125736_Desc = {
    Text = [[
Your touch makes the butterflies tremble.
Since their creation, they have never known such gentleness.
Overwhelmed, they forget how to fly.
Countless butterflies tumble down, revealing the typewriter hidden beneath their wings.
That pitiful device, now lifeless, used its last strength to type a single word: "freedom."]]
  },
  Event_125736_Name = {
    Text = "The soul dances like a butterfly"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125737_Desc = {
    Text = [[
The butterfly understands your refusal.
Its wings, coated in pitch, tremble once more as it flutters unsteadily in the dark.
Soon, the shadows swallow it again. This time, it lacks the strength to struggle.]]
  },
  Event_125737_Name = {
    Text = "Butterfly's request"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Leave] Gain 50 black sigils"
  },
  Event_125738_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_125738_Name = {
    Text = "N's message"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125739_Desc = {
    Text = "You tightly hold your companion's hand. Ramona glances at you with a puzzled look but ultimately accepts your rudeness."
  },
  Event_125739_Name = {
    Text = "Dream prayer"
  },
  Event_125740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125740_Desc = {
    Text = "Slowly, the frenzied melody transforms into something harmonious and sacred.\nYou finally understand why it is called the \"Perfect Hymn\"—\nfor it is, in truth, flawless."
  },
  Event_125740_Name = {
    Text = "The \"perfect\" hymn"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125741_Desc = {
    Text = [[
"You, you..."
"Hmph, not bad with the technique. This time, you pass. Next time won't be so easy!"
The black cat leaps away nimbly, and the others disperse to follow suit.]]
  },
  Event_125741_Name = {Text = "Nigelman"},
  Event_125742_ChoiceDesc1 = {
    Text = "【Perceive the Brain】Choose 1 from 3 command cards to gain orison: 「(EnchantConfig.Arg1)」"
  },
  Event_125742_Desc = {
    Text = [[
You felt a twitch in your brain matter.
"Does this have any special significance?"
You asked yourself, but your brain remained silent.
Not every query towards oneself yields an answer.]]
  },
  Event_125742_Name = {
    Text = "Cerebral prison"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 30 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_125743_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_125743_Name = {
    Text = "Unperceived grievance"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125744_Desc = {
    Text = "You tilt your head up, welcoming the silent rotation, like a pilgrim in an ancient ritual.\nThey joyfully feast on your flesh; you feel pain, yet clarity.\nYou see your lost self—the parts that failed to die—finally taken away.\nWhen consciousness returns, you find yourself unharmed."
  },
  Event_125744_Name = {
    Text = "Feast of ravens"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Touch the Butterfly] Delete 2 cards"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Drive Away the Butterfly] Obtain Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_125745_Desc = {
    Text = [[
There are no butterflies in the deep sea. They are the dreams of a girl trapped in a room.
So beautiful, dancing freely in the air.
"If only... I could fly away like them..."
A butterfly sobs, its cry drowned out by fluttering wings and the clatter of typewriters.]]
  },
  Event_125745_Name = {
    Text = "The Soul Dances Like A Butterfly"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125746_Desc = {
    Text = [[
Juliette locks eyes with you.
The next moment, she breaks into a completely mad smile, seemingly mocking your arrogance and ignorance.
However, the smile vanishes in an instant, and others make no reaction to it... It seems to be nothing more than your hallucination.]]
  },
  Event_125746_Name = {Text = "Final gaze"},
  Event_125747_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125747_Desc = {
    Text = [[

A gentle laughter emerges from the darkness.
"I am waiting for you, to meet me."
"Lovely little bug."]]
  },
  Event_125747_Name = {Text = "\"her\" gaze"},
  Event_125748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125748_Desc = {
    Text = [[
You put the envelope back in its place, preparing to leave when you suddenly hear a dreamy murmur.
"At my request, Doctor Clementine finally relented.
The vast universe she described to me, a mysterious universe, must hold a way to save you.
I am already prepared for 'Rebirth,' no matter how many light-years I must drift, I long to see you once more."]]
  },
  Event_125748_Name = {
    Text = "Fading Longing"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Prove Goldbach's Conjecture] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Journey's End] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Refuse to Ask] Receive 50 Black Sigils"
  },
  Event_125749_Desc = {
    Text = [[
When you picked up the spirit board, a young woman's voice rushed into your mind.
"Ask me anything. I know everything."
"From my answers, you will receive the gift of fate."]]
  },
  Event_125749_Name = {
    Text = "Spirit Board"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125750_Desc = {
    Text = [[
"Join Him, join them, join us.
Become His Guardian, become His proxy.
Let His Dream guide your way..."
The chaotic prayers stir your mind. After the voices fade, you find yourself drenched in sweat.]]
  },
  Event_125750_Name = {
    Text = "Dream prayer"
  },
  Event_125751_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125751_Desc = {
    Text = [[
Sunset, bell tower, flying birds...
The girl removed her eyepatch, and the gaze of her gray pupils froze you in place.
Illusions, like mirages, vanished as soon as they appeared, yet the lingering worries could not be dispelled.]]
  },
  Event_125751_Name = {
    Text = "White eyepatch"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125752_Desc = {
    Text = "Who would pay attention to a roll of film under the gaze of a hellhound?"
  },
  Event_125752_Name = {
    Text = "Mnemonic phantoms"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125753_Desc = {
    Text = [[
In the future's imagery, the girl with tentacles glanced at you disdainfully and scolded.
"The true form of the Divine Mother cannot be desecrated."
Then, the imagery disappeared, and the time-space rift closed instantly, leaving you to recall the scene from just now.]]
  },
  Event_125753_Name = {Text = "Time rift"},
  Event_125754_ChoiceDesc1 = {
    Text = "[Open the envelope] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Read] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Put it back] Receive 50 Black Sigils"
  },
  Event_125754_Desc = {
    Text = [[
In a neglected corner, a letter has been left behind.
Many words on the letter have become unrecognizable, but one word remains. It pierces through the paper.
That word is "Mother".]]
  },
  Event_125754_Name = {
    Text = "Fading Longing"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125755_Desc = {
    Text = [[
The hoarse crow finally closed its eyes.
In the unacknowledged and unnoticed resentment, it breathed its last, turning into a puddle of black sludge.]]
  },
  Event_125755_Name = {
    Text = "Unperceived grievance"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125756_Desc = {
    Text = [[
"Thank you..."
The beating heart leaps toward the horizon.
Soon, the sound of flesh being chewed echoed from the pitch-black Aequor.]]
  },
  Event_125756_Name = {
    Text = "Survival of the fittest"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125757_Desc = {
    Text = [[

"Mathematics! Mathematics!!"
The woman gritted her teeth, the oracle board swiftly sliding between the numbers, producing a harsh wooden friction sound.
"Get your math out of my sight!"]]
  },
  Event_125757_Name = {
    Text = "Spirit board"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Revisit the Past] Obtain 1 out of 3 Advanced Orisons"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Gain Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Leave] Gain 50 black sigils"
  },
  Event_125758_Desc = {
    Text = "Nothing in this world remains unchanged—\nnot even the paradise shaped by the Divine Mother.\nFor a fleeting moment, you glimpse something through a crack in time.\nPast, present, and future intertwine within that fissure, shifting endlessly,\nawaiting your curious gaze."
  },
  Event_125758_Name = {Text = "Time Rift"},
  Event_125759_ChoiceDesc1 = {
    Text = "[I'm Dreaming] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[This is Not Normal] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125759_Desc = {
    Text = "A smooth gravestone reflects an eye that is slowly distorting.\nAs if carrying an image beyond visual description, a memory that doesn't belong to you has deeply settled into the creases of your eyes.\nYou try to blink, to wipe it away with your fingertip, but that eye no longer belongs to you—it begins reflecting a kaleidoscopic scene."
  },
  Event_125759_Name = {
    Text = "Almost Normal"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125760_Desc = {
    Text = [[
You step straight into the mist, phantoms clinging to your body like a web, cold sensations seeping into your bones.
Their whispers turn into fragments of memory, piercing your heart.
As you pass through, nothing remains behind but illusion, and ahead, more shadowy figures loom in the dense mist, waiting to devour.]]
  },
  Event_125760_Name = {
    Text = "Time's ashes"
  },
  Event_125761_ChoiceDesc1 = {Text = "[3]"},
  Event_125761_ChoiceDesc2 = {Text = "[6]"},
  Event_125761_ChoiceDesc3 = {Text = "[1]"},
  Event_125761_Desc = {
    Text = "Who would dare roll the dice that carry misfortune and madness?\nYou, it is you.\nYou choose—"
  },
  Event_125761_Name = {
    Text = "N's message"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Leave] Obtain Silver Relic\"(RelicConfig.Arg1)\""
  },
  Event_125762_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_125762_Name = {
    Text = "N's message"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "【Perceive the Brain】Choose 1 from 3 command cards to gain orison: 「(EnchantConfig.Arg1)」"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Develop \"(Skill.Arg1)\", randomly imprint again"
  },
  Event_125763_Desc = {
    Text = [[
The brain, safely protected within the skull, conveyed certain messages to you.
You don't know if these messages were worn down during the conversion of neurotransmitters and the transmission of bioelectric currents.
The only certain fact is that you received the information and sensed your existence through the objective presence of your body.]]
  },
  Event_125763_Name = {
    Text = "Cerebral prison"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125764_Desc = {
    Text = [[

A gentle laughter emerges from the darkness.
"I am waiting for you, to meet me."
"Brave little bug."]]
  },
  Event_125764_Name = {Text = "\"her\" gaze"},
  Event_125765_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125765_Desc = {
    Text = [[
Dr. Clementine saved me.
She is truly a very, very good person, willing to listen to me.
I really want to say something joyful and happy, yet at this moment, all I have is pain and despair.
I'm afraid I will fail to meet the doctor's expectations.
After losing you, life for me is desolate.]]
  },
  Event_125765_Name = {
    Text = "Fading Longing"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Reobserve] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Give Up] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_125766_Desc = {
    Text = [[
You resolutely avert your gaze, yet those images linger like phantoms in your vision...
It is a sorrowful duet.]]
  },
  Event_125766_Name = {
    Text = "Shadows of the past"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125767_Desc = {
    Text = [[
A dusty film reel. However, there is no projector in this room, and it's not the time to leisurely enjoy the manor, the film, and afternoon tea.
Perhaps it will be a long time before you have the chance to discover what's on the reel.]]
  },
  Event_125767_Name = {
    Text = "Mnemonic phantoms"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rouse a random Awakener"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Stare] Choose an Awakener to Rouse, reduce that Card's Arithmetica Cost by 2, but develop \"(Skill.Arg1)\"."
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Leave] Gain 50 black sigils"
  },
  Event_125768_Desc = {
    Text = [[
Everything in the sanatorium is under her control and surveillance. Of course, you are too.
But she is willing to turn a blind eye for you.
After all, a game needs to be reciprocal to be more interesting.]]
  },
  Event_125768_Name = {Text = "\"Her\" Gaze"},
  Event_125769_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125769_Desc = {
    Text = "This must be a dream, you keep convincing yourself.\nBefore you realize it, you have truly fallen asleep.\nPerhaps due to too much interaction lately, you actually dreamed about Doresain—intentionally letting Doresain consume your own blood and flesh? What kind of horror story is this?"
  },
  Event_125769_Name = {
    Text = "Almost normal"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125770_Desc = {
    Text = [[
As the butterflies fade, you finally see the typewriter below.
That poor, lifeless thing used its final breath to type two words: "Leave now."]]
  },
  Event_125770_Name = {
    Text = "The soul dances like a butterfly"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Gain 40 black sigils, but develop \"(Skill.Arg2)\", continue to choose"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Ignore It] Obtain 25 Black Sigils and leave."
  },
  Event_125771_Desc = {
    Text = [[
The pitch-black crow is crying.
The pitch-black crow is screaming.
The pitch-black crow is howling.
Yet to people, it only sounds like singing.
"Ah, what a carefree song. I wish I were a crow, away from the troubles of the world."]]
  },
  Event_125771_Name = {
    Text = "Unperceived Grievance"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125772_Desc = {
    Text = "You step into a dark alley, the mist gnawing at your clothes, while the shadows behind you split into countless pairs of eyes. The toll of the rusted bell carries with it a damp omen.\n\nYou know that all winding paths will eventually collapse into a cocoon of cycles—before the rotten dawn, you will reunite with your own reflection."
  },
  Event_125772_Name = {
    Text = "Time's ashes"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Reobserve]choose 1 from 3 Command cards to acquire Orison:\"(EnchantConfig.Arg1)\""
  },
  Event_125773_Desc = {
    Text = "The once-clear dinner has turned into a bloody, indistinct feast. You recall the ingredients on the stove, and the stench of decay assaults your nostrils.\nFear grips your heart—you must make a choice."
  },
  Event_125773_Name = {
    Text = "Shadows of the past"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125774_Desc = {
    Text = [[
Driven by a nearly desecrating curiosity, or perhaps a desperate courage to confront the unknown, you seek revelation within the shadows of the past.
You see a girl dancing with a tall man whose face is indistinct, and an inexplicable joy fills your heart.]]
  },
  Event_125774_Name = {
    Text = "Shadows of the past"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Pick Up] Acquire 1 out of 3 Silver Relics"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Recall] Obtain Silver relics \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", contract twice with \"(Skill.Arg3)\""
  },
  Event_125775_Desc = {
    Text = [[
In the corroded slime at the corner lay a small white eyepatch.
Memories seize your heart.]]
  },
  Event_125775_Name = {
    Text = "White Eyepatch"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Avert Gaze] Increase Max HP by Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Maintain Gaze] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_125776_Desc = {
    Text = [[
"The end has come."
Your heart tightens and constricts.
Juliette's confident tone undoubtedly carries the influence of some hypnosis and telepathic power.
What sets this Juliette in this dimension apart from the one you knew in the past?
Too many mysteries, too many obstacles.
You glance at Juliette, only to find her staring intently back at you.]]
  },
  Event_125776_Name = {Text = "Final Gaze"},
  Event_125777_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125777_Desc = {
    Text = [[
Indulge in consciousness, sinking into the deep sea following the path of prayers.
You see the golden country sunken at the bottom, see the immortal stone sculptures, and ultimately confront the flickering eyes in the shadows...
"Those who have not shed divine blood... leave, leave."]]
  },
  Event_125777_Name = {
    Text = "Dream prayer"
  },
  Event_125778_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125778_Desc = {
    Text = "\"I dreamed of a cataclysm sweeping everything away, drowning the brilliance of the past. I feel anger towards life and helplessness about a future devoid of hope. My spirit is torn apart by fear; amidst this impending collapse, may you remain vigilant and prevent this terrible fate from arriving.\""
  },
  Event_125778_Name = {
    Text = "Last words' whisper"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125779_Desc = {
    Text = [[
The deep sea returns to silence and shadow.
In that stillness, you hear the heartbeat once more.
This time, it comes from within you.
To others, you are but a beating heart adrift in the abyss.]]
  },
  Event_125779_Name = {
    Text = "Survival of the fittest"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Start 'working'] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_125780_Desc = {
    Text = [[
"Modify! Work! Don't stop!"
Countless hums echoed in your ears, drawing you closer to the suddenly appeared typewriter.
"What to do, what to do, I've been typing from morning until night, yet the work just never finishes."
"Modify! Modify! Modify the plan, present demands, complete the work!"
"Work! Work!! Work!!"
The humming souls crashed against the continuously typing typewriter, and finally, that typewriter stopped.
But a moment later, that typewriter started up again.
"Modify! Work! Don't stop!"
Because work has no end.]]
  },
  Event_125780_Name = {
    Text = "Eternal Torment"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Attack the Cat] 50% chance to receive 125 Black Sigils, 50% chance to develop \"(Skill.Arg2)\""
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Meow Like a Cat] 75% chance to receive 100 Black Sigils, 25% chance to develop \"(Skill.Arg2)\""
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Attempt to Pet the Cat] Receive 50 Black Sigils"
  },
  Event_125781_Desc = {
    Text = [[
"Hey! You, stop right there."
Black cats suddenly jump out, blocking your way forward.
They elegantly lick their paws, their demeanor arrogant and proud.
"The path ahead is full of dangers, not something a weak human like you can explore."
You express your determination to move forward, and in that moment, the vertical pupils of the clowder's leader shifted, revealing a cruel intention of playing with its prey. "Then show us your determination."]]
  },
  Event_125781_Name = {
    Text = "Spawn of the Shadows"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Avoid Phantasm] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Pass Through Phantasm] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_125782_Desc = {
    Text = [[
The dust lies thick like a heavy curtain over the streets, and each step feels as though you are treading on the ashes of time.
In the distance, two shadowy figures loom in the mist, like phantoms of the past, whispering tales long forgotten.
The runaway imagination conjures terrifying phantasms, twisting and sprawling, as if harbingers of future doom, weighing heavily upon your breath.
You know the road ahead will only become dimmer, yet your steps cannot and should not halt.]]
  },
  Event_125782_Name = {
    Text = "Time's Ashes"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Parry the Monster] Upgrade one Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Pick Up Stars] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignore] Receive 25 Black Sigils"
  },
  Event_125855_Desc = {
    Text = "The meteor shower rains down on the clock tower.\nA transparent crystal lands at your feet, creating a small pit.\nYou are still surrounded by Dissoluted Entities in various forms, like twisted shadows. The sounds of roaring and howling continue without pause.\nYou decide—"
  },
  Event_125855_Name = {
    Text = "A Fallen Star"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125856_Desc = {
    Text = [[
The desire to survive surges in your chest, and you issue the command without hesitation.
After breaking through the siege and turning back to look, that star has been submerged by D-Slime.
Amidst the swirling D-Slime, a sharp, rhythmic sound echoes.
You touch the surface of the D-Slime, and a decayed star falls into your palm.]]
  },
  Event_125856_Name = {
    Text = "Fallen star"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125857_Desc = {
    Text = [[
The journey is shrouded in endless darkness and boundless chaos.
There is no time to contemplate your fate. You must dispel fear and reach your destination before the final judgement descends.]]
  },
  Event_125857_Name = {Text = "Gloom city"},
  Event_125858_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125858_Desc = {
    Text = [[
"Emotional? An interesting answer."
"I hope you won't regret your choice."]]
  },
  Event_125858_Name = {
    Text = "Humanity's toll"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Choose Emotion] Recover Arg1 HP"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Maintain Rationality] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Refuse to Choose] Receive 25 Black Sigils"
  },
  Event_125859_Desc = {
    Text = [[
"Choose, choose."
In the racing darkness, countless whispers echoed.
The voice is gently hypnotic, seemingly carrying infinite magic that induces a kind of mad phantasm in you.
Your brain sinks into madness, writhing away from the body, while the heart seems to have developed a certain consciousness, screaming and calling you.
"Choose, choose."
"Maintain rationality or emotion; you must make a choice."]]
  },
  Event_125859_Name = {
    Text = "Humanity's Toll"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125860_Desc = {
    Text = [[
You evade the Seafarers and press onward.
Above, the stars glimmer softly, as they have for millennia.]]
  },
  Event_125860_Name = {
    Text = "Vigil under the stars"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125861_Desc = {
    Text = [[
Having escaped death is already a rare feat; you should not ask for more.
The shadows of broken remnants and ruins still call to you.]]
  },
  Event_125861_Name = {Text = "Gloom city"},
  Event_125862_ChoiceDesc1 = {
    Text = "[Rub Your Eyes] Receive 50 Black Sigils"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_125862_Desc = {
    Text = "A hideous swarm of black cats gathers behind Juliette, murmuring unknown chants and exuding a secretive and malevolent threat."
  },
  Event_125862_Name = {
    Text = "Feline Murmur"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125863_Desc = {
    Text = [[
You are under the control of some great power or mighty fate.
A short rest cannot change this situation, but it can at least give your weary legs the strength to keep moving.]]
  },
  Event_125863_Name = {Text = "Gloom city"},
  Event_125864_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125864_Desc = {
    Text = [[
You pick up the star, but it has lost its brilliance in your palm.
A sudden wave of oppression washes over you, sending chills down your spine.
In the blink of an eye between life and death, you sidestep to evade a fierce attack, but a two-inch-long scratch still remains on your arm.]]
  },
  Event_125864_Name = {
    Text = "Fallen star"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Advance] Destroy 1 of 3 Command Cards, and receive 75 Black Sigils."
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Duplicate 1 of 3 Command Cards, and receive 25 Black Sigils."
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Look Back] Receive 50 Black Sigils"
  },
  Event_125865_Desc = {
    Text = [[
You walk on deserted streets, leaving deep imprints with each step in the ashes.

The city roads are like spider webs, and you are a moth entangled in them.]]
  },
  Event_125865_Name = {Text = "Gloom City"},
  Event_125866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125866_Desc = {
    Text = [[
"Rationality? An interesting answer."
"I hope you won't regret your choice."]]
  },
  Event_125866_Name = {
    Text = "Humanity's toll"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125867_Desc = {
    Text = [[
This time, it is not the obstacle, but the Seafarers, who turn to ash.
The stars gaze silently upon the scene, as they have for centuries, offering no reply.]]
  },
  Event_125867_Name = {
    Text = "Vigil under the stars"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125868_Desc = {
    Text = [[
"Ah, the little text trap has been uncovered."
"This is a reward. Because..."
"Not every choice has to be made."]]
  },
  Event_125868_Name = {
    Text = "Humanity's toll"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125869_Desc = {
    Text = [[
Those aren't cats... they're the agitated Lightbearer Devotees.
Beneath the black veil, hatred and hostility seep through. The murmurs scrape at your consciousness, bringing bizarre and inexplicable hallucinations.]]
  },
  Event_125869_Name = {
    Text = "Feline murmur"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125870_Desc = {
    Text = [[
You hear unsettling whispers.

"We come from the mountains and swamps of distant stars. Our bodies are the wick and fuel of lanterns, and we will ignite the firewood of the earth, illuminating the path to a new world."]]
  },
  Event_125870_Name = {
    Text = "Feline murmur"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Prepare for Battle] Choose 1 from 3 command cards to gain advanced orison: \"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Try to Detour] Gain 25 Black Sigils"
  },
  Event_125871_Desc = {
    Text = [[
In the starlit deep, the Seafarers have slumbered for centuries.
The boundless sea has witnessed their madness, their endurance, and their most devout faith.
None may hinder the great coming of their God.
Those who stand in the way shall be turned to ash by the Seafarers' wrath.]]
  },
  Event_125871_Name = {
    Text = "Vigil Under the Stars"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129176_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129177_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129178_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129179_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129180_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129181_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129181_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129182_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129183_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129184_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129185_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129186_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129187_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129188_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129189_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129190_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129191_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129192_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129193_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129194_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129195_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129195_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129196_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129197_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129198_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129199_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129200_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129201_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129202_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129203_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129204_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129205_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129206_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129207_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129208_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129209_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129210_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129211_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129212_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129213_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129214_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129215_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129216_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129217_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129218_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129219_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129220_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129221_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129222_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129223_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129224_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129225_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129226_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129227_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129228_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129229_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129230_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129231_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129232_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129233_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129234_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129235_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129236_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129237_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129238_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129239_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129240_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129241_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129242_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129243_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129244_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129245_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129246_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129247_Name = {
    Text = "Astral Reign Chapter 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129248_Name = {
    Text = "Oblivion Chapter 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129249_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129250_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129251_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129252_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129253_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129254_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129255_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129256_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129257_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129258_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129259_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129260_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129261_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129262_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129263_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129264_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129265_Name = {
    Text = "Oblivion Chapter 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129266_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129267_Name = {
    Text = "Oblivion Chapter 8@"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129268_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129269_Name = {
    Text = "Astral Reign Chapter 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129270_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129271_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129272_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129273_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129274_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129275_Name = {
    Text = "Astral Reign Chapter 4@"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129276_Name = {
    Text = "Oblivion Chapter 1@"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129277_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129278_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129279_Name = {
    Text = "Oblivion Chapter 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129280_Name = {
    Text = "Oblivion Chapter 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129281_Name = {
    Text = "Oblivion Chapter 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129282_Name = {
    Text = "Oblivion Chapter 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Placeholder]Temporary text."
  },
  Event_129283_Name = {
    Text = "Astral Reign Chapter 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Bury] Destroy a Command Card and recover Arg2 HP. [ExDesc1]"
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_129900_Desc = {
    Text = "A pale skeleton, half submerged in pitch-black D-Slime."
  },
  Event_129900_Name = {Text = "Faded Bone"},
  Event_130337_ChoiceDesc1 = {
    Text = "[Take Your Seat] Shuffle \"puppet\" into your deck."
  },
  Event_130337_Desc = {
    Text = "The moment you set foot upon the theater steps, your gaze can never again be torn from this stage.\nThe threads of fate draw countless stories into their swirling flow here—the dust of the past, the flickering light of the present, and the mists of the future all churn relentlessly across the stage.\nYou have forgotten your origin and your destination alike. Every vestige of the \"Self\" dissolves within the shadows of the heavy curtains. In this hour, you are the silent spectator in the stalls, and the burning player upon the boards.\nThe entirety of your existence collapses into two singular traces: to behold, and to perform."
  },
  Event_130337_Name = {
    Text = "The Stage of Fate"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131264_Desc = {
    Text = "You close your eyes and step into the endless, soft haze of dust, where the nebula embraces you, and you lose your form—a presence more stable than your body settles within you.\nThat night, the stars continued to rotate, as bright as ever.\nTo an immortal being, what does the starry sky signify? Perhaps you should go ask Doresain."
  },
  Event_131264_Name = {
    Text = "Night of the stars"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131265_Desc = {
    Text = [[
You narrowly evade Sarah's first fierce attack.
Next time, you might not be so fortunate.]]
  },
  Event_131265_Name = {
    Text = "Nightmare reborn"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Dodge] Engrave 1 out of 3 Orisons"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Stop] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_131266_Desc = {
    Text = [[
A familiar scene makes your nerves jump, twitch, and recoil in dread.
"Once again..."
The merciless nightmare arrives, and an overwhelming sense of helplessness engulfs you.
Is there really no way to rewrite her fate?
There's no time. Inside Sarah's cracked skull, a gigantic mouth gleams with silver, eager to snap you in two, to devour and chew.]]
  },
  Event_131266_Name = {
    Text = "Nightmare Reborn"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131267_Desc = {
    Text = [[
The hidden sharp fangs within the tentacles tear open your sleeve, and warm blood streams down your wrist like a crimson rivulet.
You cannot read Sarah's expression, but the cracked skull lets out a faint, trembling shriek of agony.]]
  },
  Event_131267_Name = {
    Text = "Nightmare reborn"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131268_Desc = {
    Text = [[
The chaotic soul guides your path with shrill wails.
Is it safe? You cannot know.
Your only choice is to move forward.]]
  },
  Event_131268_Name = {
    Text = "Soul beacon"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131269_Desc = {
    Text = [[
You slowly lift your head. In that moment, light pierces your pupils, and searing heat blooms into a void within your mind.
The stars of Necrovia are no different from those elsewhere, yet even the seemingly eternal ghouls can only live beneath the stars, without freedom.]]
  },
  Event_131269_Name = {
    Text = "Night of the stars"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131270_Desc = {
    Text = "The chaotic soul releases a mournful sigh.\nIt fades slowly, yet that sorrowful sound, almost tangible, settles upon your heart.\nThump, thump—your heartbeat synchronizes with the ritual's melody."
  },
  Event_131270_Name = {
    Text = "Soul beacon"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Gaze at the Stars] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Leave] Gain 50 Black Sigils"
  },
  Event_131271_Desc = {
    Text = [[
You stand in a deserted cemetery, where the presence of stars illuminates the night as brightly as day.
The floating orbs of light within the fathomless depths of time remain silent, yet slowly converge through rotations as endless as murmurs in a dream.
They gaze upon the forgotten solitary star.
He gazes upon you, upon all death and eternity.]]
  },
  Event_131271_Name = {
    Text = "Night of the Stars"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Following the Guidance] Choose 1 from 3 command cards to obtain advanced Orison:\"(EnchantConfig.Arg1)\", but develop\"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignore the Guidance] Choose 1 from 3 command cards to gain advanced Orison: \"(EnchantConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_131272_Desc = {
    Text = "The festival has begun.\nAmid spiritual flames and blood-soaked blessings, countless believers have become living torches—\nEthereal souls scatter around you like guiding sprites, glowing, awaiting your choice."
  },
  Event_131272_Name = {
    Text = "Soul Beacon"
  },
  Event_133380_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_133380_Desc = {
    Text = [[
You have settled into your velvet seat, and the crimson curtains part in a hushed whisper.
Dear spectator, the stage shall rise to meet your every expectation.
The lead of this play has already taken their mark.]]
  },
  Event_133380_Name = {
    Text = "The Stage of Fate"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Leave It to Her] All Awakeners gain Arg1 Aliemus"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Require Support] Rouse 2 Awakeners"
  },
  Event_20778_Desc = {
    Text = "\"This is a communication from Mythag. Abnormal Gnosis Index fluctuation detected in the Awakener. Do you need support?\""
  },
  Event_20778_Name = {
    Text = "Reinforcement Hail"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20779_Desc = {
    Text = "\"Emergency aid has been provided. Please tap the brooch three times to confirm after receiving it.\""
  },
  Event_20779_Name = {
    Text = "Reinforcement Hail"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20780_Desc = {
    Text = "A phantasm from a distant future, concealed in the ravines of Elworth."
  },
  Event_20780_Name = {
    Text = "Volcano's Ghost"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] All Awakeners gain Arg1 Aliemus"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Approach Phantasm] Rouse 2 Awakeners"
  },
  Event_20781_Desc = {
    Text = [[
In the distance, it seems that a volcanic cone has erupted, and smoke in the shape of a human rises in the stormy sky.
But this is Elworth, where there are only endless towering snow mountains and limestone karst caves.
Have the continuous abnormalities driven you to spiritual confusion?]]
  },
  Event_20781_Name = {
    Text = "Volcano's Ghost"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20782_Desc = {
    Text = "The phantasm waves to you before vanishing. All that's left are the cold snow and towering mountains."
  },
  Event_20782_Name = {
    Text = "Volcano's Ghost"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20783_Desc = {
    Text = "\"Roger that. We will deliver the basic resources. Please check.\""
  },
  Event_20783_Name = {
    Text = "Reinforcement Hail"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_21398_Desc = {
    Text = [[
Machines dismantled, truth unveiled.
The bustling life fades into nothingness, leaving you with the satisfaction of uncovering the truth.]]
  },
  Event_21398_Name = {
    Text = "Eyewitness Account"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Check Film] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_21399_Desc = {
    Text = [[
Driven by curiosity, you peer into the Shadow Pool.
The images are submerged in the scarlet liquid, and the sinner covered in black filth bears a face identical to yours.]]
  },
  Event_21399_Name = {
    Text = "Eyewitness Account"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21400_Desc = {
    Text = [[
Machines dismantled, truth unveiled.
The bustling life fades into nothingness, leaving you with the satisfaction of uncovering the truth.]]
  },
  Event_21400_Name = {
    Text = "Eyewitness Account"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21811_Desc = {
    Text = [[

"Twenty-five years... yes, she let me sleep for twenty-five years."
The girl responds gloomily and in a low voice to you.
Upon waking up, those who had cared for her since childhood have become full-fledged Seafarers over the years.
No one understands her anguish anymore, no one cares about her pain, leaving her alone in the cult.
She would rather that the day before her sleep was "The Day of Stellar Alignment".]]
  },
  Event_21811_Name = {
    Text = "Shackled Life"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22058_Desc = {
    Text = [[

"No, I am not hungry."
You politely declined the warm invitation to the feast.
You would never be willing to mortgage your soul for that]]
  },
  Event_22058_Name = {
    Text = "Flesh Banquet"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22059_Desc = {
    Text = [[
You hungrily bite into the bleeding scone, the aroma of a peppered heart baked into the dough filling your senses with a familiar scent.
"Gaining power comes at a cost."
You drink the last drop of blood.]]
  },
  Event_22059_Name = {
    Text = "Flesh Banquet"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22060_Desc = {
    Text = [[
You gulped down the broth and meat, wiping the remnants with your sleeve.
The meat was tender, the broth savory, but who did it once belong to?
It was merely the tip of the iceberg of what you had lost.]]
  },
  Event_22060_Name = {
    Text = "Flesh Banquet"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22061_Desc = {
    Text = [[
You carefully examine the ancient Orisons engraved on the wind chime.
They are distorted to an unimaginable degree, seemingly intended to remain incomprehensible.
If not understood, then undisturbed.]]
  },
  Event_22061_Name = {
    Text = "Rusted Chime"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22062_Desc = {
    Text = [[
"Not bad, you are very cautious."
Suddenly, a distant voice came from the wind chimes.
"Caution will bring you a small reward, but that's all."]]
  },
  Event_22062_Name = {
    Text = "Rusted Chime"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22063_Desc = {
    Text = [[
You touch the ancient Orison engraved on the wind chime.
They twist in ways beyond human comprehension, refusing to be understood.
Being misunderstood means remaining undisturbed.]]
  },
  Event_22063_Name = {
    Text = "Rusted Chime"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22064_Desc = {
    Text = "\"Ah, what a pity... I suppose I'll continue my solitary performance.\" You don't know when the zither and hands disappeared, but the melody, like flowing water, remains in your heart forever."
  },
  Event_22064_Name = {
    Text = "Harp's Phantom"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22065_Desc = {
    Text = "\"Ah, what an honor to have a friend like this!\" Those hands became excited, and you couldn't keep up with their speed. Even long after the performance ended, that exhilarating sound still stirred your heart."
  },
  Event_22065_Name = {
    Text = "Harp's Phantom"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22175_Desc = {
    Text = [[
The planchette moves confidently, your gaze following its every motion.
However, it barely indicates two letters before dissolving into a viscous black goo with a pitiful scream.]]
  },
  Event_22175_Name = {
    Text = "Spirit Board"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22176_Desc = {
    Text = [[

"Mathematics! Mathematics!!"
The woman gritted her teeth, the oracle board swiftly sliding between the numbers, producing a harsh wooden friction sound.
"Get your math out of my sight!"]]
  },
  Event_22176_Name = {
    Text = "Spirit Board"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22177_Desc = {
    Text = [[
"Wait, wait!!"
"Ask me! Why don't you ask!"]]
  },
  Event_22177_Name = {
    Text = "Spirit Board"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22178_Desc = {
    Text = "It has never pulsed as vibrantly as it does in this moment, but conversely, the void within my heart is being torn apart..."
  },
  Event_22178_Name = {
    Text = "Cursed Yearning"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22179_Desc = {
    Text = [[
The soul and spirit fill your lungs, and you float upward in silence.
The sounds of the world gradually emerge, forming the symphony of life.]]
  },
  Event_22179_Name = {
    Text = "Lethe's Flow"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22180_Desc = {
    Text = "As usual, destruction arrives as promised. Precious items are buried in the unburned remnants, shining brilliantly in the shadows."
  },
  Event_22180_Name = {
    Text = "Beyond the Needle"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22181_Desc = {
    Text = "Meeting, parting, and passing by."
  },
  Event_22181_Name = {
    Text = "Astral Harmonies"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22182_Desc = {
    Text = "The heart gradually slows, but perhaps the\"conscience\"has found a bit of solace..."
  },
  Event_22182_Name = {
    Text = "Cursed Yearning"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22183_Desc = {
    Text = "You closed your eyes, enjoying this rare moment of Illusion and freedom. Gradually, you felt the world emerging from silence, life blooming quietly."
  },
  Event_22183_Name = {
    Text = "Lethe's Flow"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22184_Desc = {
    Text = "You stop the needle, silver shards flashing as they cut into your soft palm. Destruction has yet to arrive, but the shadow beneath your feet is being swallowed by an inky darkness."
  },
  Event_22184_Name = {
    Text = "Beyond the Needle"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22185_Desc = {
    Text = [[

"You cannot escape; no one can resist the inner evil."
Malicious thoughts tear at your nerves, attempting to drag you into the abyss. But the pain only makes your mind feel unprecedented clarity.
The evil cannot possess you; you will remain yourself.]]
  },
  Event_22185_Name = {
    Text = "Unbidden Thought"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22186_Desc = {
    Text = [[
"Why not?"
Once you embrace those terrifying thoughts, all difficulties will be easily resolved, and the world will no longer have a paradox called "ethics."]]
  },
  Event_22186_Name = {
    Text = "Unbidden Thought"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22187_Desc = {
    Text = "A silver light flashed before my eyes, and a dull wind swept away all sounds."
  },
  Event_22187_Name = {
    Text = "Unbidden Thought"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22188_Desc = {
    Text = "Fickle, cold, and distant."
  },
  Event_22188_Name = {
    Text = "Astral Harmonies"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22189_Desc = {
    Text = "Expansion, contraction, on the verge."
  },
  Event_22189_Name = {
    Text = "Astral Harmonies"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22190_Desc = {
    Text = [[
Why not be a little reckless?
Break through all barriers and charge toward the finish line.
Even if you churn up a storm in the lake of thoughts, even if you become Icarus chasing the sun, at least you've achieved your goal, haven't you?]]
  },
  Event_22190_Name = {Text = "Mind Maze"},
  Event_22191_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22191_Desc = {
    Text = [[
Your brain is a maze, and you are its Ariadne.
In this universe, no one knows the maze better than you.
No one.]]
  },
  Event_22191_Name = {Text = "Mind Maze"},
  Event_22192_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22192_Desc = {
    Text = [[
With the right tuning, the dissonant intervals softened a bit.
But perhaps there's more you can do.]]
  },
  Event_22192_Name = {Text = "Dissonance"},
  Event_22193_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22193_Desc = {
    Text = [[
You are both a music master and an ordinary tone-deaf individual.
Under your guidance, the notes fulfill their roles, and life finally resonates within the Domain.]]
  },
  Event_22193_Name = {Text = "Dissonance"},
  Event_22194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22194_Desc = {
    Text = "Your voice is swallowed by silence. The silence grows louder and more intense, until it shatters, leaving only remnants behind."
  },
  Event_22194_Name = {
    Text = "Lethe's Flow"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22195_Desc = {
    Text = "You didn't fall for it. You turned around decisively and left."
  },
  Event_22195_Name = {
    Text = "Crawling Fissure"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22293_Desc = {
    Text = [[
The moment you pick up the pen, the letter burns in the Domain, ashes falling into hand.
When you come to your senses, something has disappeared along with the letter.]]
  },
  Event_22293_Name = {Text = "Monologue"},
  Event_22294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22294_Desc = {
    Text = [[
As the letter dissipates in the Domain, you hear a gentle yet weak expression of concern.
"In such a situation, remembering me is an honor as your teacher.
However, it has been far too long since I last walked through the Domain. Now, I can only assist you this much..."]]
  },
  Event_22294_Name = {Text = "Monologue"},
  Event_22295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22295_Desc = {
    Text = [[
As the letter disintegrated in the Domain, you heard an urgent exclamation.
"Keeper, if there is anything uncomfortable, please be sure to let me know.
As your partner, I will spare no effort to assist you."]]
  },
  Event_22295_Name = {Text = "Monologue"},
  Event_22296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22296_Desc = {
    Text = [[
As the letter dissipates in the Domain, you hear a cold sigh.
"If only you were this eager to seek help when you fail exams."]]
  },
  Event_22296_Name = {Text = "Monologue"},
  Event_22397_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22397_Desc = {
    Text = "Your arrival left the shadows bewildered. A beam of starlight brushed past your toes, and the crowd suddenly dispersed, leaving only the densest shadow in your hand."
  },
  Event_22397_Name = {
    Text = "Stellar Vow"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22398_Desc = {
    Text = "The noisy whispers come to an abrupt stop. Shadows as dark as ink turn towards you, staring. From their featureless faces, you detect a hint of mockery..."
  },
  Event_22398_Name = {
    Text = "Stellar Vow"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Calm Observation] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Ask Aloud] Receive 25 Black Sigils"
  },
  Event_22399_Desc = {
    Text = [[
In the intertwining of stars and moon, whispers are ceaseless.
"Is this the one? @4's person..."
"Human body, ultimately still @3..."]]
  },
  Event_22399_Name = {
    Text = "Stellar Vow"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_22411_Desc = {
    Text = "Cheap but effective traps!"
  },
  Event_22411_Name = {
    Text = "Making Traps"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24254_Desc = {
    Text = "The storm of Gnosis surrounds Tulu. You exchange a glance with him and step into the darkness right after him."
  },
  Event_24254_Name = {
    Text = "From the Sea"
  },
  Event_24255_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24255_Desc = {
    Text = "The storm of Gnosis surrounds Tulu, while the enduring sorrow and guilt spread through the space."
  },
  Event_24255_Name = {
    Text = "Face the Abyss"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Accept Tulu's help"
  },
  Event_24256_Desc = {
    Text = [[
His majestic presence reverberates through the domain like a colossal object plunging into the sea.
The power is ancient, timeless, transcending all eras.
Fortunately, you are not his enemy, at least for now.]]
  },
  Event_24256_Name = {
    Text = "From the Sea"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Go with Tulu"
  },
  Event_24257_Desc = {
    Text = [[
Tulu takes a deep breath and gazes into the distance at Miryam.
As if reminiscing about history, old friends, and his own life...
The complex expression on his face lingers for just a moment before he shifts his gaze away from Miryam.
"Let's go, leave her."]]
  },
  Event_24257_Name = {
    Text = "Face the Abyss"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Close the Hatch]"
  },
  Event_24277_Desc = {
    Text = [[
Ramona grabbed the student who had barged in from outside.
That fearless and strong Keeper, despite appearing disheveled, looked hazy through her blue eyes behind the glasses.
It wasn't until the moment she held the hand that Ramona confirmed: you have been reunited.]]
  },
  Event_24277_Name = {
    Text = "Joyous Reunion"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24278_Desc = {
    Text = "Ramona didn't give you a chance to explain. She pulled you into the dim cabin and carefully closed the door..."
  },
  Event_24278_Name = {
    Text = "Joyous Reunion"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24540_Desc = {
    Text = "\"She is your sturdy shield, the sword in your hand. \nShe is your partner, your companion, your trusted friend—no matter how she changes.\""
  },
  Event_24540_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24541_Desc = {
    Text = [[

"It's you... No, it can't be. This reincarnation of you has already... And I, too, have already..."
The voice faded along with the figure, leaving only sorrow lingering in the mist.]]
  },
  Event_24541_Name = {
    Text = "Known-Yet-Unknown"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24542_Desc = {
    Text = "\"For the world, for humanity, for everything we hold dear.\nOf course, the most important is—she is for you.\""
  },
  Event_24542_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24543_Desc = {
    Text = [[
You haven't even drawn near when it notices you. It freezes, as if in shock, then seems to be overwhelmed by profound sorrow.
Before you can utter a word, it vanishes along with the mist.]]
  },
  Event_24543_Name = {
    Text = "Known-Yet-Unknown"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Who is She?] Duplicate 1 of 3 Command Cards"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Why Did She Change?] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_24544_Desc = {
    Text = [[
Another mist, another silhouette. Unlike before, this time you can see the opponent clearly.
A figure exactly like yours, in a uniform exactly like yours, with a face exactly like yours.
"You know why you're here," that person said, "just as you know why she has become that way."]]
  },
  Event_24544_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Console] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[Approach] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Turn and Leave] Receive 25 Black Sigils"
  },
  Event_24545_Desc = {
    Text = [[
Mist shrouds your path.
A figure emerges in the hazy shadows; you squint but cannot see its face, only hearing intermittent whispers.
"Why... why can't I save... Is fate truly unchangeable..."]]
  },
  Event_24545_Name = {
    Text = "Known-Yet-Unknown"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Ask Your Partner] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Manage the set] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Phenomenal Frenzy] Acquire the Relic \"(RelicConfig.Arg1)\""
  },
  Event_35039_Desc = {
    Text = [[
"In 'Master Houdini's Guide to Filmmaking', it is clearly stated that Casiah, that is me, as the producer and director, has the duty and power to oversee the entire film. Therefore, brave employees of Casiah, please choose your next action schedule!"
"Schedule? Wait, when did I become your employee?!"
"Opportunity knocks but once, don't hesitate!"]]
  },
  Event_35039_Name = {
    Text = "Producer's Myth"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP. [ExDesc1] [ExDesc2]"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and obtain Arg2 Black Sigils."
  },
  Event_35103_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_35103_Name = {Text = "Junction"},
  Event_35103_Tips3 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_35165_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35165_Desc = {
    Text = [[
In your moment of hesitation, you took the initiative to contact the mysterious benefactor.
"At this point, there's no turning back. Please, Noble, be generous..."
A hearty laugh echoed from the other side of the Silver communicator, and they eventually agreed to your request with a smile.
"By the way, make sure to keep this from Ramona."]]
  },
  Event_35165_Name = {
    Text = "Producer's Myth"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35236_Desc = {
    Text = [[
What does a production coordinator do? You pulled out a stack of documents that Casiah had unknowingly slipped into the Gnosis transfer and began to examine them carefully.
Then, you started to get a headache.
The expenses incurred by Lotan during the set arrangement, the snacks consumed by Aurita and Brown, the reimbursement request for magic spheres purchased by Casiah... Each settlement was laid out before you, forcing you to crouch painfully on the ground for calculations.
By the way, what are Casiah's magic spheres?]]
  },
  Event_35236_Name = {
    Text = "Producer's Myth"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Develop Symptom [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Leave]"},
  Event_35259_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_35259_Name = {Text = "Illusion"},
  Event_35497_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35497_Desc = {
    Text = [[
Behind the phenomenon of extreme fanaticism, there needs to be a facilitator, and whenever "facilitator" is mentioned, a green-haired girl comes to mind.
"First broker of Mythag University, Hannah Peaslee at your service!"
"If this is the Keeper's first service request, you only need to pay the cost of three cafeteria curry meals!"]]
  },
  Event_35497_Name = {
    Text = "Producer's Myth"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_35887_Desc = {
    Text = [[
You raise the sail, only to find nothing beneath it. When you come to your senses, the sail has already vanished.
The pure white sail and the faint visage of a girl form a message, reminding you that no matter the journey ahead, you are not alone.]]
  },
  Event_35887_Name = {Text = "Pale Sails"},
  Event_35888_ChoiceDesc1 = {
    Text = "[Raise the Sail]"
  },
  Event_35888_Desc = {
    Text = "There is no wind here, yet a pristine white sailboat stands with its sail proudly raised, anchored on the tranquil blue sea.\nYou vaguely see the face of a young girl, her features blurred, as if viewed through a thin mist or a rippling water surface. Her presence seems isolated from everything around, yet she remains the focal point of this scene.\nThough her image alternates between clarity and obscurity, there is no doubt—you know who she is."
  },
  Event_35888_Name = {Text = "Pale Sails"},
  Event_35894_ChoiceDesc1 = {
    Text = "[Fall Downwards] Receive 35 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35894_Desc = {
    Text = "The girl's voice dissipates into the air, vague and distant like a bubble."
  },
  Event_35894_Name = {
    Text = "The Brink of Death"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Cycle Again] Receive 30 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35895_Desc = {
    Text = "Limbs feel extraordinarily heavy, the smog tightly envelops the frail body."
  },
  Event_35895_Name = {
    Text = "The Brink of Death"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Read Predecessors' Path] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Write Your Own Path] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Receive 25 Black Sigils"
  },
  Event_35896_Desc = {
    Text = [[
If you were exploring the Domain alone, you wouldn't be as certain of your path as you are now.
The footprints in the Domain have split into three paths; each step writes an unseen future.]]
  },
  Event_35896_Name = {
    Text = "The Way Out"
  },
  Event_35897_ChoiceDesc1 = {
    Text = "[Support Her]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Look at her]"
  },
  Event_35897_Desc = {
    Text = [[
She mutters, spinning to a halt before you.
Someone has disturbed her slumber; her consciousness is tethered to reality, while her soul remains in a forgotten realm.]]
  },
  Event_35897_Name = {
    Text = "Lost Phantom"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35898_Desc = {
    Text = "In this undifferentiated darkness, a series of blurry footprints stretch out, like those left by a night traveler in an unseen desert."
  },
  Event_35898_Name = {
    Text = "The Way Out"
  },
  Event_35899_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_35899_Desc = {
    Text = [[
Reflected in your eyes is a distant lighthouse, standing solitary at the edge of darkness, emitting a faint yet resolute light, like a guide in the night sea, summoning lost souls toward the shore's tranquility.
You can't help but follow, but suddenly the ground beneath you is no longer solid.
You step into a concealed watery area. The water's surface is smooth as silk, silently devouring your footsteps.]]
  },
  Event_35899_Name = {Text = "Blink"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Listen to Her]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignore Her]"
  },
  Event_35900_Desc = {
    Text = "You see the source of the light—it's a character with a female figure.\nA stream of radiance pours from her alien-like head, paving a path to the unknown.\n\"Return... to Lemu@2a...\""
  },
  Event_35900_Name = {
    Text = "Eternal Light"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Approach the Lighthouse]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Stay away from the Lighthouse]"
  },
  Event_35901_Desc = {
    Text = [[
Turning the corner where reality and dreams intertwine, a terrifying stormscape unfolds before your eyes in a fleeting moment. As if lifted by an invisible giant hand, the wind roars like a ferocious beast, sweeping up dust and hope alike. The sky is heavy and oppressive.

In the heart of the storm stands a lighthouse that shouldn't exist, appearing both as a figment of imagination and a relic of ancient legend. It emits a faint light, lonely and resilient, on the stage of the raging tempest.]]
  },
  Event_35901_Name = {
    Text = "Storm's Eye"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_35902_Desc = {
    Text = [[
"In the Domain, eternal lights, phantoms with tentacles..."
Tulu closes his eyes, pondering for a moment, then lets out a deep sigh.
"The Guardian of Lemuria... one of my servants. She ultimately cannot escape the bonds of her obsessions."]]
  },
  Event_35902_Name = {
    Text = "Sona-Nyl's Descent"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Touch the Silver Light] Receive 25 Black Sigils"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Talk to Silverlight] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_35903_Desc = {
    Text = "The tightly sealed communicator was pried open, letting dim light seep out—a likely first conversation between Silver and the outside world since being sealed inside"
  },
  Event_35903_Name = {
    Text = "Mithril Monument"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\""
  },
  Event_35904_Desc = {
    Text = "\"A woman with glowing head?\" Elton shows a look of astonishment. Clearly, he has heard of the figure occasionally seen in the cargo ship domain—it's just—\n\"The night the Sona-Nyl sank... the very night I Awakened Celeste, I saw such a shadow in the storm.\"\n\"Yes, I'm sure I did.\""
  },
  Event_35904_Name = {
    Text = "Sona-Nyl's Descent"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35905_Desc = {
    Text = [[
The domain ahead is fraught with peril, unfathomably deep.
Your eyes are locked on the unseen chaos, but before it can devour you, Ramona, having dealt with the pursuers, grabs you and pulls you in another direction.]]
  },
  Event_35905_Name = {
    Text = "The Way Out"
  },
  Event_35906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35906_Desc = {
    Text = [[
Is that the fruit of your mysterious soul? Is everything you're experiencing a collision between the self and the super-ego?
The more you think, the clearer the noise in your head becomes. Your vision pierces through a mist, but just before you can glimpse the figure within, the soul rejects you.]]
  },
  Event_35906_Name = {
    Text = "Inverted Fate"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35907_Desc = {
    Text = "It surges within, transforming into fearless power, supporting you to break through the mist and tear apart fear."
  },
  Event_35907_Name = {
    Text = "Lightchaser"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35908_Desc = {
    Text = "As the mind focuses and inner chaos subsides, the chaotic illusions begin to dissolve slowly, retreating like the tide.\nIn the end, the noise in the brain vanishes without a trace—but how much will you miss? It remains unknown."
  },
  Event_35908_Name = {
    Text = "Future Warning"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35909_Desc = {
    Text = "Your soul is completely lost in the tinnitus, desperately trying to break free and decipher the pain, yet you can only linger on the edge of consciousness..."
  },
  Event_35909_Name = {
    Text = "The Brink of Death"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_35910_Desc = {
    Text = "You can feel every beam of light from the lighthouse, burning and leaping in the storm like a call from the depths of the soul, never abandoning its mission to guide the way home even amidst the most intense fear."
  },
  Event_35910_Name = {
    Text = "Storm's Eye"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_35911_Desc = {
    Text = [[
Is it a symbol of hope, or a harbinger of destruction?
You no longer look at it, as if its existence is merely a meticulously crafted illusion.]]
  },
  Event_35911_Name = {
    Text = "Storm's Eye"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Sink into Oblivion] Receive 20 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35912_Desc = {
    Text = "Then, an unusual gray veil covers your eyes. Moments later, you realize it is your semi-transparent upper eyelid."
  },
  Event_35912_Name = {
    Text = "The Brink of Death"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Leave] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_35913_Desc = {
    Text = [[
You feel an indescribable resonance.
But logic tells you: Ignore her.]]
  },
  Event_35913_Name = {
    Text = "Eternal Light"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_35914_Desc = {
    Text = "Her words are never inscribed on any known stele, yet they solidify in the air as the deepest remorse and call. They seemto drift from another time, traversing the sedimentation of years, carrying profound longing for a distant homeland."
  },
  Event_35914_Name = {
    Text = "Eternal Light"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Hold Her Hand] Upgrade a random Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Express Concern] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Gaze at Her] Receive 25 Black Sigils"
  },
  Event_35915_Desc = {
    Text = [[
Murphy is at the back of the team, walking side by side with Celeste.
You can't help but glance back at her frequently, but Murphy keeps her eyes on her shoes, hiding her expression in secrecy.]]
  },
  Event_35915_Name = {
    Text = "Pain Management"
  },
  Event_35915_Tips1 = {
    Text = "Silver Relic not yet acquired"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[No Way Out] Receive 40 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] Receive 25 Black Sigils and leave."
  },
  Event_35916_Desc = {
    Text = [[
The @1@1revives, a soul traversing the edge of @2, yet not fully embracing the flesh.
Murphy's concerned words fade from your consciousness, like the wails of crows, lingering at the ear but always blocked by the barriers of the mind.]]
  },
  Event_35916_Name = {
    Text = "The Brink of Death"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Leave] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_35917_Desc = {
    Text = "She is but a ghost lingering in reality, an ancient fragment that cannot be touched yet refuses to be forgotten."
  },
  Event_35917_Name = {
    Text = "Lost Phantom"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_35918_Desc = {
    Text = [[
In that moment, you hear a faint shattering deep within your soul. Like dissipating smoke, her image blurs and grows less real.
She isn't truly there; it is merely Captain Elton's memory projection.
However, the lingering sense of loss and confusion feels genuine.]]
  },
  Event_35918_Name = {
    Text = "Lost Phantom"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35919_Desc = {
    Text = "The instant your fingertips make contact, a complex sensation surges—both scorching and freezing.\nThe souls forgotten by the world howl, seeking eternity."
  },
  Event_35919_Name = {
    Text = "Mithril Monument"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Grasp the Spark] Increase Max HP by Arg1"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Face Yourself] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards, but develop \"(Skill.Arg2)\" twice."
  },
  Event_35920_Desc = {
    Text = "In this grand hunt, Goliath's pursuit is like a beast in the dark, aiming to devour all hope. However, this relentless chase does not freeze you; instead, it ignites a spark deep within, spreading and burning hotter in your chest."
  },
  Event_35920_Name = {
    Text = "Lightchaser"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Decipher It] Duplicate 1 of 3 Command Cards"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Become It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Disregard It] Receive 25 Black Sigils"
  },
  Event_35921_Desc = {
    Text = "As you take a step forward, an invisible tremor seizes your mind, forcing your gaze toward the chaotic and illusive boundary of the Domain."
  },
  Event_35921_Name = {
    Text = "Future Warning"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35922_Desc = {
    Text = "Dazzling colors dance before your eyes, whispers fill your ears, and fleeting scenes with blurry faces intertwine, as if narrating an array of unknown stories. The illusions make you feel detached from reality, drawn into a dreamscape that is both familiar and alien."
  },
  Event_35922_Name = {
    Text = "Future Warning"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35923_Desc = {
    Text = "The tremor doesn't come from external noise or physical vibration, but from an indescribable, deep inner premonition. It's like a call from the future, pulsing in your consciousness."
  },
  Event_35923_Name = {
    Text = "Future Warning"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35924_Desc = {
    Text = "Her hand instinctively moves to her chest, trying to control the suffocating feeling.\nThe fear makes her clench her teeth, forcing herself to ignore the stabbing pain in her chest. Every slight contortion on Murphy's face is quickly concealed, hiding the pain behind a clumsy facade.\n—Until you hold her hand, and surprise colors her expression."
  },
  Event_35924_Name = {
    Text = "Pain Management"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35925_Desc = {
    Text = "\n\"Murphy? Are you okay?\"\n— She doesn't respond to you.\nThe palpable strangeness corrodes her heart, making it nearly impossible for her to breathe."
  },
  Event_35925_Name = {
    Text = "Pain Management"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35926_Desc = {
    Text = "You no longer hesitate and step into the pitch-black unknown. Wherever you go, a path leading to a faint glimmer unfolds."
  },
  Event_35926_Name = {
    Text = "The Way Out"
  },
  Event_35927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35927_Desc = {
    Text = "\nBefore you is a pulsating fire.\nIt is fervent, alive, enveloping a flickering cold flame, brilliantly dispelling those discordant sounds.\nWhen you come to your senses, you find Murphy looking at you in bewilderment —\n\"Are you really okay?\""
  },
  Event_35927_Name = {
    Text = "The Brink of Death"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35928_Desc = {
    Text = [[
You feel your consciousness begin to separate, slowly being pulled from your body.
You see your soul dancing with the remnants of Silver's consciousness, then sinking into an invisible abyss...
There lies pure Illusion.]]
  },
  Event_35928_Name = {
    Text = "Mithril Monument"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_35929_Desc = {
    Text = [[
Before you can investigate the source of the light further, it suddenly trembles and shatters into the air.
The light ripples through the Domain, spreading outward in waves.
Then, nothing remains.]]
  },
  Event_35929_Name = {Text = "Blink"},
  Event_35930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35930_Desc = {
    Text = [[
How could that be you?
If that were you, why did It not save you when sorrow descended?
If that were you, why did It not help you through your hardships?
So, it's all an illusion.]]
  },
  Event_35930_Name = {
    Text = "Inverted Fate"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Ask the Captain]"
  },
  Event_35931_ChoiceDesc2 = {Text = "[Ask Tulu]"},
  Event_35931_Desc = {
    Text = [[
Again, you see that mysterious figure disappear into the bulkhead, vanishing without a trace. The luminescent long hair falls into several tendrils touching the ground.
You know clearly, even if she isn't a Seafarer, she must have strong ties with the Lost Nation.]]
  },
  Event_35931_Name = {
    Text = "Sona-Nyl's Descent"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35932_Desc = {
    Text = [[
You're afraid; it's all the adrenaline.
You fear that your decisions might harm the souls sharing the darkness with you.]]
  },
  Event_35932_Name = {
    Text = "Lightchaser"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Nowhere to Run] Receive 25 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35933_Desc = {
    Text = "Every nerve screams with a yearning for @2."
  },
  Event_35933_Name = {
    Text = "The Brink of Death"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Chase It]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignore It]"
  },
  Event_35934_Desc = {
    Text = [[
In the distance of the Domain, a faint and enchanting light appears.
It shimmers like sunlight dancing on water, flickering starlight, or the flame of a candle...
As you draw near, the light abruptly vanishes.
It seems to lure you in, much like how a moth is drawn to the flame by instinct.]]
  },
  Event_35934_Name = {Text = "Blink"},
  Event_35935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35935_Desc = {
    Text = [[
What's the use of dwelling on these things?
You're like a leaf suspended in mid-air, pushed by the winds of fate. That's all.]]
  },
  Event_35935_Name = {
    Text = "Inverted Fate"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Self-Deprecation] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Pursue] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Stop Thinking] Receive 25 Black Sigils"
  },
  Event_35936_Desc = {
    Text = [[
The wind of life brushes against your soul, stirring you within the whirlpool of reality and pulling you into the mist-shrouded unknown.
You can't help but ask the voice in your head: "Is that me?"]]
  },
  Event_35936_Name = {
    Text = "Inverted Fate"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36146_Desc = {
    Text = [[

Murphy finally notices your gaze; perhaps it really is too intense.
She takes a few deep breaths, emitting a faint "hmm" from her nose. Finally, she pulls Celeste along, closely following behind you.]]
  },
  Event_36146_Name = {
    Text = "Pain Management"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36722_Desc = {
    Text = "The instant your fingertips make contact, a complex sensation surges—both scorching and freezing.\nThe souls forgotten by the world are howling, seeking eternity."
  },
  Event_36722_Name = {
    Text = "Gnosis Monument"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Touch it] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Join the Spin] Engrave 1 out of 3 Orisons"
  },
  Event_36723_Desc = {
    Text = [[
As you take a step, a crack silently forms in the deepest part of your spirit. An indescribable profound aura seeps through, rippling your thoughts.
You sense a silver chaos planet silently spinning and growing within you.]]
  },
  Event_36723_Name = {
    Text = "Gnosis Monument"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Follow them] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Pet Them] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Do Not Disturb] Receive 25 Black Sigils"
  },
  Event_36724_Desc = {
    Text = [[
Upon turning an unexpected corner, a strange sight comes into your view.
Several cat-like shadows flit indistinctly along the cold hull.]]
  },
  Event_36724_Name = {Text = "Ship Cats"},
  Event_36725_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36725_Desc = {
    Text = "\"Memories\" do not respond. They cling to the cabin wall, staring at you until you walk around the next corner."
  },
  Event_36725_Name = {
    Text = "Sona-Nyl's Master"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Detour] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Ask Why It Sank] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Greet the Crew] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_36726_Desc = {
    Text = [[

While walking toward the engine room, you encounter some "memories" fixed in the domain again.
They are not ghosts, but merely Captain Elton's lingering thoughts for the lost crew.]]
  },
  Event_36726_Name = {
    Text = "Sona-Nyl's Master"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36727_Desc = {
    Text = "\n\"Memories\" peel away from the bulkhead, distorting its face as it let out a mournful wail.\n—The lighthouse.\n—The isolated lighthouse led them into the storm."
  },
  Event_36727_Name = {
    Text = "Sona-Nyl's Master"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36728_Desc = {
    Text = "You chose to follow the path outlined by the gentle and free souls, even if the dark traps lie ahead"
  },
  Event_36728_Name = {Text = "Ship Cats"},
  Event_36729_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36729_Desc = {
    Text = "Do not disturb the dead, nor stir the memories of those slumbering."
  },
  Event_36729_Name = {
    Text = "Sona-Nyl's Master"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36730_Desc = {
    Text = [[
You feel your consciousness beginning to separate, slowly being pulled from your body.
You see your soul dancing with the planet, then sinking into an invisible abyss...
There lies pure void.]]
  },
  Event_36730_Name = {
    Text = "Gnosis Monument"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36731_Desc = {
    Text = [[
As gentle beings, they are a forbidden luxury in this Domain, mere phantasms.
Though you understand this, a faint warmth still ripples in your heart.]]
  },
  Event_36731_Name = {Text = "Ship Cats"},
  Event_36732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36732_Desc = {
    Text = [[
Their figures are blurred, like a painting washed away by the torrents of time and space. The deep black spots resemble drifting clouds in the night sky, but their eyes shine like the glimmer of distant stars, emitting a mysterious and profound radiance.
You cannot resist their allure, reaching into a realm of illusion.]]
  },
  Event_36732_Name = {Text = "Ship Cats"},
  Event_36733_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36733_Desc = {
    Text = "You know you must keep moving forward, even if you stumble, even if you fall."
  },
  Event_36733_Name = {
    Text = "Flesh Anguish"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Attempt to Call Him] Increase Max HP by Arg1"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36734_Desc = {
    Text = "This place is filled with concealed desires and untouched fears, a rich tapestry of his dreams and memories."
  },
  Event_36734_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36735_Desc = {
    Text = [[
"Keeper, if you can't hold on, please don't bear the pain alone."
You won't avoid pain, as it is part of fleeting life.
You won't fear the shadows of night, for you do not dread being devoured by its darkness.]]
  },
  Event_36735_Name = {
    Text = "Flesh Anguish"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Keep Calling Him] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_36736_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36736_Desc = {
    Text = "This world is composed of naive doodles."
  },
  Event_36736_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36737_Desc = {
    Text = [[
The prayers of the Seafarers echo around, maddening and suffocating.
But they will not affect your will, absolutely not.]]
  },
  Event_36737_Name = {
    Text = "From the Sea"
  },
  Event_36738_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_36738_Desc = {
    Text = [[
Their gaze is deep and clear, like light in the deep sea, bright and warm.
They do not speak or appear, but you can feel their presence, like the gentle caress of a summer breeze.]]
  },
  Event_36738_Name = {
    Text = "A Kindly Gaze"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36739_Desc = {
    Text = "You force yourself to focus on the immediate crisis, sternly demanding that you ignore the pain."
  },
  Event_36739_Name = {
    Text = "Flesh Anguish"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36740_Desc = {
    Text = "They are the marks of life, the proof of existence. They narrate stories but gradually lose their voice under the storm's wrath."
  },
  Event_36740_Name = {
    Text = "Farewell, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36741_Desc = {
    Text = [[
Their gaze is deep and clear, like light in the deep sea, bright and warm.
They do not speak or appear, but you can feel their presence, like the gentle caress of a summer breeze.]]
  },
  Event_36741_Name = {
    Text = "A Kindly Gaze"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[The Last Call] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_36742_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36742_Desc = {
    Text = "The world is made up of painful rifts."
  },
  Event_36742_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Embrace Pain] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Refuse Pain] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignore Pain] Receive 25 Black Sigils"
  },
  Event_36743_Desc = {
    Text = "Pain is rooted in your mind like a stubborn rock. The spreading agony entwines every nerve, twisting your consciousness."
  },
  Event_36743_Name = {
    Text = "Flesh Anguish"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Firm Call] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_36744_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36744_Desc = {
    Text = "The longing for recognition shapes this world."
  },
  Event_36744_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Watch Them] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Seek Help] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_36745_Desc = {
    Text = "In the flowing colors of the Domain, you sense a mysterious gaze—eyes without form, concealed within its enigmatic folds.\nThe instant they turn their gaze upon you, a powerful desire surges within your heart."
  },
  Event_36745_Name = {
    Text = "A Kindly Gaze"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36746_Desc = {
    Text = [[
If you fail to understand them, you will be unable to escape this chaotic inferno.
When the stars are reflected on the water's surface, those pulsating wishes and pleas, those prayers, rise like bubbles toward the sea, only to be silently swallowed by the darkness.]]
  },
  Event_36746_Name = {
    Text = "From the Sea"
  },
  Event_36747_ChoiceDesc1 = {
    Text = "[Eager Call] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_36747_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36747_Desc = {
    Text = "Ugly words make up this world."
  },
  Event_36747_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36748_Desc = {
    Text = "You stand before him, watching as his soul is devoured by strange memories."
  },
  Event_36748_Name = {
    Text = "Metamorphic Dawn"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Tears of Sorrow] Destroy a Card"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[That's Blood] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_36749_Desc = {
    Text = [[
A few drops of liquid spread freely across the deck, silently seeping through the cracks.
The traces are gentle yet resolute, each wet mark carrying a sense of finality, weaving a picture of life and death, tranquility and chaos amidst the roaring sea wind and the creaking sails.]]
  },
  Event_36749_Name = {
    Text = "Farewell, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36750_Desc = {
    Text = [[
You gaze at the slowly spreading spots, trying to discern their nature. At the boundary where heaven and earth meet, the distinction between rain and blood becomes blurred.
Are they raindrops? Or are they tears of the ocean?
You don't know.]]
  },
  Event_36750_Name = {
    Text = "Farewell, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Reject the Synchrony] Acquire 1 out of 3 Silver Relics"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Join the Synchrony] Acquire the Silver Relics \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg3)\" twice."
  },
  Event_36751_Desc = {
    Text = "The whispers of the Seafarers intertwine with the heartbeat of \"Divine Fetus\", creating a hidden symphony. Each vibration triggers a roaring in the boundless liquid universe."
  },
  Event_36751_Name = {
    Text = "From the Sea"
  },
  Event_36752_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Check Film] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_36752_Desc = {
    Text = [[
They bear no ill intent; this feeling is simply instinctual, deeply rooted in your bones.
Thus, you let down your guard and attempt to seek help from these hidden watchers: sharing your confusion and desires with that vague existence, speaking as genuinely as if confiding in an old friend.]]
  },
  Event_36752_Name = {
    Text = "A Kindly Gaze"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Narrate school stories] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Uneducated] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_36874_Desc = {
    Text = [[
Passing by a ruin, Aurita's eyes suddenly brightened.
"Grandma said this used to be a school, but it has long been abandoned due to a lack of students!"
"Aurita has never been to school. What about you, friend? Have you ever been to school?"]]
  },
  Event_36874_Name = {Text = "Lost Joy"},
  Event_36875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36875_Desc = {
    Text = [[
Receiving a negative answer from you, Aurita shook her head gloomily.
"So, the outside world doesn't have students either... Then what was the purpose of establishing schools in the first place?"]]
  },
  Event_36875_Name = {Text = "Lost Joy"},
  Event_36876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36876_Desc = {
    Text = [[
"Workhouse, Little Mouse, Wax Sculpture... Hooray! Adventure, it's adventure!"
Aurita said, an invisible question mark floating above her head.
"However, Grandma said that school is a place that will make Aurita smarter, but..."
Before Aurita could continue her thoughts, you pushed her around another corner.]]
  },
  Event_36876_Name = {Text = "Lost Joy"},
  Event_36877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36877_Desc = {
    Text = "\n\"W-why?\"\nAurita was startled by you and continued to direct you with a stern expression.\n\"This is Aurita's home. Aurita knows that the square—is just inside!\""
  },
  Event_36877_Name = {
    Text = "Sightless Dark"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36878_Desc = {
    Text = [[
"I don't want to take this route. Does Aurita know another way to the plaza?"
Aurita pouted, looking confused, but eventually tugged at your cloak and guided you in a different direction.]]
  },
  Event_36878_Name = {
    Text = "Sightless Dark"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36879_Desc = {
    Text = [[
This is a dream, just a dream.
You repeatedly admonish, or perhaps console yourself, leading Aurita into the unseen darkness.]]
  },
  Event_36879_Name = {
    Text = "Sightless Dark"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Listen to Her] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Oppose Her] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Negotiate with Her] Receive 25 Black Sigils"
  },
  Event_36880_Desc = {
    Text = [[
Aurita holds onto your cloak, stepping forward one by one in your footprints.
"Hey... no! The square is that way!"
You turn your head toward the direction pointed out by Aurita, and the pathways in the Domain are pitch black. D-Slime and aberrations writhe and entangle each other, dragging the real world into the Abyss.]]
  },
  Event_36880_Name = {
    Text = "Sightless Dark"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Secure Funding] Obtain Arg1 Black Sigils"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Secure Funding] Obtain Arg1 Black Sigils [ExDesc1]"
  },
  Event_37983_Desc = {
    Text = "\"No lord will leave a mysterious guest unwatched, let alone a monk.\"\nThe queen sat high on her Throne, a flicker of tyranny in her eyes.\n\"Prove your usefulness, or else...\"\nUsefulness? You glance at the barren land outside the window, a thought suddenly arises: perhaps using your economic Knowledge to help Wanda manage the estate?\nYou strain to recall your studies—in Mythag, economics was just a minor elective...\nPatience running out. The queen yawns.\n\"Disappointing. Execute—\"\nJust as the guillotine drops, the spirits of Adam Smith, Malthus, David Ricardo, and other great predecessors descend into your mind.\nDivision of labor! Taxation! Population, damn population!\nYou may remember..."
  },
  Event_37983_Name = {
    Text = "Secret Order"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_37984_Desc = {
    Text = [[
You reluctantly present the decree.
The queen glances over it and gives a cold smile:
"If it proves useless, you know what will happen."]]
  },
  Event_37984_Name = {
    Text = "Secret Order"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Propose Decree] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Propose Decree] Acquire the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Propose Decree] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_37985_Desc = {
    Text = [[

"Having taken my money, you must serve me."
The queen rested her chin on one hand, casually looking at you.
Whether she admits it or not, she is indeed curious about this.
"Now then, tell me your plan, great reformer."]]
  },
  Event_37985_Name = {
    Text = "Secret Order"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP. [ExDesc1]"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and obtain Arg2 Black Sigils."
  },
  Event_38700_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_38700_Name = {Text = "Junction"},
  Event_38700_Tips3 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Develop a random Symptom."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Absorb Illusion] Lose Arg1 HP and obtain Arg2 Black Sigils"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Leave]"},
  Event_38707_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_38707_Name = {Text = "Illusion"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Propose Decree] Acquire the Silver Relics \"(RelicConfig.Arg1)\" and \"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Propose Decree] Acquire the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Propose Decree] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_38715_Desc = {
    Text = [[

"Having taken my money, you must serve me."
The queen rested her chin on one hand, casually looking at you.
Whether she admits it or not, she is indeed curious about this.
"Now then, tell me your plan, great reformer."]]
  },
  Event_38715_Name = {
    Text = "Secret Order"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Ask Identity] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_40452_Desc = {
    Text = [[
Three ghosts blocked the way.
They surrounded the gambling table, their eyes fixed on the dice.
"Gulp, gulp."
The dice were thrown and fell countless times.
This is an endless gamble.]]
  },
  Event_40452_Name = {
    Text = "Endless Wager"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40453_Desc = {
    Text = [[

"Hello, we are Wanda's first, second, and third husbands."
"What? You ask where the fourth husband is?
Well... to be honest, John lacks a sense of humor, so the lady turned him into a Blind Acolyte."
"We all regret losing him. Of course, just a little bit."]]
  },
  Event_40453_Name = {
    Text = "Endless Wager"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Shake Hands] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_40454_Desc = {
    Text = [[
As they passed a cage, a hand reached out from inside.
"Don't leave me, Rebecca..."
The voice was old and withered, like a worn-out bellows.]]
  },
  Event_40454_Name = {Text = "Prisoner"},
  Event_40455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40455_Desc = {
    Text = "Your palm feels sticky—it's D-Slime.\nThe owner of the voice has vanished, concealed in the shadowy corners."
  },
  Event_40455_Name = {Text = "Prisoner"},
  Event_40456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40456_Desc = {
    Text = [[
You left without a care, missing the dramatic tale on the back of the letter.
But does it matter?
Vast oceans, dawns and dusks, equatorial deserts...
You will encounter more, and miss more.]]
  },
  Event_40456_Name = {
    Text = "To My Beloved Lady"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40457_Desc = {
    Text = [[
In a way, you're no different from this prisoner.
Now is not the time to raise the alarm.
You ignore the prisoner's pleas and walk away.]]
  },
  Event_40457_Name = {Text = "Prisoner"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Tear Letter] Transform a Relic into the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignore the Letter] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Reply] Receive 25 Black Sigils"
  },
  Event_40458_Desc = {
    Text = [[
I. Letter from John Cambrian to Wanda (B.F. @2)

A husband has the right to dispose of his wife, at least in Cambrian.
But I clearly underestimated your madness. Now I am nearly blind, and my limbs are about to be cut off.
Daughter of evil... No, you are evil itself.
I curse you @1, curse you @2, curse you, curse you...]]
  },
  Event_40458_Name = {
    Text = "To My Beloved Lady"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40459_Desc = {
    Text = [[
You used the most straightforward method to break the curse.
Nothing happened. The paper fell limply to the ground.
You shrugged and walked away, but couldn't shake the feeling that something was amiss.]]
  },
  Event_40459_Name = {
    Text = "To My Beloved Lady"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40460_Desc = {
    Text = [[
You walk past the gambling table without a second thought.
As you leave, the ghosts speak in unison:
"Please give our regards to our mutual ex-wife, Mrs. Wanda."]]
  },
  Event_40460_Name = {
    Text = "Endless Wager"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40461_Desc = {
    Text = [[
You neatly write your reply at the end of the letter:
"Curse received. Wishing you all the best."
As the last stroke falls, angry blue flames ignite on the paper.
You gather the ashes.]]
  },
  Event_40461_Name = {
    Text = "To My Beloved Lady"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Flee the Darkness] Acquire a random Golden Relic"
  },
  Event_44187_Desc = {
    Text = "The soul before you is dark and tainted—light and darkness coexist within it. They struggle for dominance, leaving the soul in confusion.\n\"I pity them, those poor souls who have lost everything, but isn't that just the way the world works?\n\"For someone to gain, someone else must lose.\n\"Must I sacrifice my happiness for the sake of others' joy?\""
  },
  Event_44187_Name = {
    Text = "The Darkness Within"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44188_Desc = {
    Text = "\"This is my sin, my burden. How can I save you, my contradictory soul?\""
  },
  Event_44188_Name = {
    Text = "The Darkness Within"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Plea to the Bishop] Purify a Sinful Relic. If you have none, acquire a random Golden Relic."
  },
  Event_44299_Desc = {
    Text = "\"I deceived and manipulated to obtain the life I desired—money became mere numbers, delicacies turned into daily meals, I had the final say in business, and wielded strong influence in politics. But why, why can't I forget those people, those from whom I took everything? Why can't I forget the despair on their faces?\n\"Alcohol only offers a fleeting escape; my soul is tearing itself apart, and pain is nearly drowning me.\n\"What should I do?\""
  },
  Event_44299_Name = {
    Text = "Guilt And Forgiveness"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44301_Desc = {
    Text = [[
"You walk a path of suffering, straying from the All-Father's glory.
"Return, lost lamb. Heed the All-Father's teachings and find the right path."]]
  },
  Event_44301_Name = {
    Text = "Guilt And Forgiveness"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Want for the Worldly] Receive Arg1 Black Sigils. The Bishop takes a Symptom, if you have one."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Want for Blood] The Bishop takes 2 Symptoms. Engrave the Orison \"(EnchantConfig.Arg1)\"."
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Want for More] The Bishop can take more, should you have 4 or more Symptoms."
  },
  Event_44395_Desc = {
    Text = [[

The illusory soul formed a vague outline, kneeling before the bishop to display its broken body and the remnants of its blackened heart.
"You have given me guidance, forgiveness, and salvation, but merciful bishop, this is far from enough.
"I am destitute and plagued by illness. My life hangs by a thread, and you are my only salvation. Please save me, bishop, so that I may no longer suffer."]]
  },
  Event_44395_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_44396_Desc = {
    Text = "The bishop removed his ring and brooch. The blue gems symbolizing the All-Father were placed into the soul's hands one by one. The bishop bent down, holding the poor soul's hands. \n\"Take my gold and silver, take all my possessions—if that's what you need. The teachings of the All-Father are enough for me to live by.\""
  },
  Event_44396_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Indulge] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_44400_ChoiceDesc2 = {Text = "[Give Up]"},
  Event_44400_Desc = {
    Text = [[
The lost soul refuses to abandon the darkness.
You know what awaits it. An absurd life is about to unfold, and you are the only audience.]]
  },
  Event_44400_Name = {
    Text = "The Darkness Within"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Quick Reflexes] Receive Arg1 Black Sigils"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Seize Freely] Engrave 1 out of 3 Adv. Orisons, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_44401_Desc = {
    Text = "A black mark found in the Domain can be sacrificed to the D-Mark for Relics or other spiritual projections. It will soon dissolve into black sludge after leaving the current area."
  },
  Event_44401_Name = {
    Text = "Black Sigil"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Develop a random Symptom."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Embrace Delusion] Receive Arg1 Black Sigils, but develop 2 random Symptoms."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44407_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_44407_Name = {Text = "Illusion"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Leave] Look for Searchlight"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Break into Mist] Lose Arg2 HP"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Discard Extraneous Items] Lose 5 Black Sigils and add 1 \"Insight\" to the deck."
  },
  Event_44445_Desc = {
    Text = [[
Ahead lies a thick black fog; entering rashly will bring disaster.
Perhaps you should find a "Searchlight" to disperse the fog.]]
  },
  Event_44445_Name = {Text = "Unknown"},
  Event_44469_ChoiceDesc1 = {
    Text = "[Want for Caro] The Bishop takes 4 Symptoms. Acquire 1 out of 3 Golden Relics+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Want for Sanctity] The Bishop takes 6 Symptoms. Acquire 1 out of 3 Chrono Pendulums."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Return]"},
  Event_44469_Desc = {
    Text = [[

The illusory soul formed a vague outline, kneeling before the bishop to display its broken body and the remnants of its blackened heart.
"You have given me guidance, forgiveness, and salvation, but merciful bishop, this is far from enough.
"I am destitute and plagued by illness. My life hangs by a thread, and you are my only salvation. Please save me, bishop, so that I may no longer suffer."]]
  },
  Event_44469_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Plea] Receive the Bishop's Blessing"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Plea] Receive the Bishop's Blessing"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44474_Desc = {
    Text = "\"This is my sin, my burden. How can I save you, my contradictory soul?\""
  },
  Event_44474_Name = {
    Text = "The Darkness Within"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44911_Desc = {
    Text = [[

"All, all... That's right, I want it all...!"
The soul stretched out its hand, futilely grasping at the air.
It gained something but lost everything.]]
  },
  Event_44911_Name = {
    Text = "What Have You Gained?"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44913_Desc = {
    Text = [[
"Only the most important one... the most crucial one..."
The Soul squatted down, dug out a radiant wish from the Illusion soil, and cradled it in their palms.]]
  },
  Event_44913_Name = {
    Text = "What Have You Gained?"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Catch All] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Learn to Let Go] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_44916_Desc = {
    Text = [[
The dim soul is in agony.
It wanders, confused by all possible choices and their consequences.
"What should I choose?" it whispers, "What should I do?"
"How can I have it all?"]]
  },
  Event_44916_Name = {
    Text = "What Have You Gained?"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Self-Reflection] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Look Around] Engrave 1 out of 3 Orisons"
  },
  Event_44919_Desc = {
    Text = [[
The floating soul is caught in a dilemma.
It halts, wavering between desires.
"What should I choose?" it murmurs softly, "What should I do?"
"Which one is my true desire?"]]
  },
  Event_44919_Name = {
    Text = "What Is Thy Desire?"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44920_Desc = {
    Text = [[

"You are right, I need to see, I need to see..."
It lowers its head, hands probing into its chest cavity, pulling out a phantasmal heart: one half as black as ink, the other half as bright as a star.]]
  },
  Event_44920_Name = {
    Text = "What Is Thy Desire?"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44921_Desc = {
    Text = [[

"Yes, yes... People say others can be a mirror... I need to see..."
It leaned in closer, looking at you with its faceless visage.
"Why aren't you troubled? So envious, so envious..."]]
  },
  Event_44921_Name = {
    Text = "What Is Thy Desire?"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44998_Desc = {
    Text = [[
"They say the current suffering is temporary, and after death, we will eternally rejoice in the embrace of the All-Father.
"I don't want to wait until after death."
Shadows greedily devour everything; souls dim, nearly merging with the surrounding darkness.
You want to act, but feel powerless.]]
  },
  Event_44998_Name = {
    Text = "The Darkness Within"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45000_Desc = {
    Text = "The bishop slashed his palm with a sharp blade, and the blood dripping onto the tablet turned into a healing blue light, replenishing the missing blood of the soul.\n\"Take my blood, fill your life—if that is what you need. This is what the All-Father intends me to do.\""
  },
  Event_45000_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45001_Desc = {
    Text = [[
The bishop drew his soul from deep within his chest. The gentle light merged into the tablet, transforming into a healing blue glow that filled every crack in the soul.
"Receive this; it is a gift from the All-Father, a testament of His love. May your body be healthy, your soul be whole, and may you be free from all suffering."]]
  },
  Event_45001_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_45002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_45002_Desc = {
    Text = "You walk towards those faces, and when you open your eyes again, everything is plunged into darkness. Only laughter of unknown origin echoes around you."
  },
  Event_45002_Name = {Text = "Illusion"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Delete All Relics]"
  },
  Event_45036_Desc = {
    Text = "\"This is my sin, my burden. How can I save you, my contradictory soul?\""
  },
  Event_45036_Name = {
    Text = "The Darkness Within"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45196_Desc = {
    Text = "The bishop used a sharp blade to carve out bone and flesh. The pale bones and crimson flesh merged into the tablet, transforming into healing blue light that mended the fractured soul.\n\"Take my bone and flesh to fill in your missing body—if that is what you need. This is what the All-Father desires of me.\""
  },
  Event_45196_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_46144_Desc = {
    Text = [[
The hazy figure gradually becomes clear, and it is neither a Dissolute nor signs of Cataclysm, but a wingless, normal-looking Clementine.
"What a coincidence, are you here to enjoy the moonlight too?" she says with a smile, and you feel a wave of dizziness. "On misty nights, do stay cautious.
Those little ones here don't seem very well-behaved."]]
  },
  Event_46144_Name = {
    Text = "Mist-Shrouded Figure"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_46145_Desc = {
    Text = [[
You remained calm and composed. A noblewoman suddenly rushed onto the stage.
She frantically pried open the boy's mouth and violently shoved a stick into it.
"Speak, talk to me."
Black blood flowed from the boy's mouth. He mumbled on.
"A song for mom..."]]
  },
  Event_46145_Name = {Text = "Finale III"},
  Event_47309_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47309_Desc = {
    Text = [[
On that day, the gods will punish the Philistines with their mighty and powerful swords,
because of the slaughter they have "committed."
What? You say this is unfair?
No, this is the fate of the predator.]]
  },
  Event_47309_Name = {
    Text = "Sailors' Shanty"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Keep Listening] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_47310_Desc = {
    Text = [[
God said: Name him Philistine.
Burden him with the task of slaughter, curse him with greed.
Let his path shine, making others see the abyss as white hair.
In the vast ocean, there is no greater shark.
Let him be feared and revered by all creatures,
until the day of judgment arrives.]]
  },
  Event_47310_Name = {
    Text = "Sailors' Shanty"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_47311_Desc = {
    Text = [[
The boy was a lowly slave.
His master treated him like a son, yet was stabbed to death in bed.
"I love you, Father. I just don't want to be a slave anymore."
Later, the boy stood before his "father's" grave, recalling the priest's words:
<Small:Do not leave the land that nurtured you.
When the time comes, your hands will be stained with blood, and you will die without dignity.
Wild dogs, vultures, and sea fish will scorn you.>
The boy named Iglenn left anyway.
He would write his own infamous story.]]
  },
  Event_47311_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Turn Page Forward] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop 1 out of 3 Symptoms."
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Turn Page Backward] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Discard] Receive 25 Black Sigils"
  },
  Event_47312_Desc = {
    Text = "You find a book bound with papyrus:\n..\nA boy hides in a barrel, drifting to a Philistine island.\nHe is frail, despicable, and ambitious.\nWhen the immortal giant's glory leaves everyone in awe,\nThe boy remains in the shadows, keeping that light at bay.\nLater, Goliath entrusts him with an important task.\nAs for the reason—"
  },
  Event_47312_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47313_Desc = {
    Text = [[
The giant then said:
"I keep him by my side because he is both melancholic and comical.
And he can never kill me."]]
  },
  Event_47313_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47314_Desc = {
    Text = [[

You did not hear the latter part, but its lyrics reminded you of another song:
"This rare giant shark, amid the storm and rain,
The ocean is its home,
Since power is justice, it is the giant of power,
The king of the boundless ocean."]]
  },
  Event_47314_Name = {
    Text = "Sailors' Shanty"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47315_Desc = {
    Text = [[
Now's not a good time to read.
You quickly toss the book aside, missing the final lines:
..
He hides in the shadows, not out of envy,
but out of pure fear.
Once in the light, his petty soul will be completely obliterated.
Not even ashes will remain.]]
  },
  Event_47315_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Enter Hypnosis] Select an Awakener to undergo Spirit Split, losing their initial four Command Cards."
  },
  Event_47463_Desc = {
    Text = [[
The Doctor looked up from the vast collection of books:
"You are a rare specimen, so I will not charge you.
But I need another form of payment: a hypnosis.
This is a new form of therapy that brings unreserved, completely naked consciousness.
So, how about it? Do you want to give it a try?"]]
  },
  Event_47463_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Shining Memory] [ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Faded Memory] Enhance the Orison quality of all engraved Ensemble Orisons."
  },
  Event_47464_Desc = {
    Text = [[
She wanders along the beach of the Sea of Consciousness.
The hem of the waves licks at her feet, carrying scattered memories to the shore.
Some are bright, some are dim, and others carry the scent of Londinium's rainy season.
Which memory will you choose to pick up? She wanders along the beach of the Sea of Consciousness.]]
  },
  Event_47464_Name = {
    Text = "\"Core Fusion\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Reject Attempt] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Smash the Solvent] Purify a Sinful Relic"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Accept Experiment] Acquire \"(RelicConfig.Arg1)\""
  },
  Event_47465_Desc = {
    Text = [[
The doctor shook the emerald solvent excitedly and told her:
"Drink a sip, and you will enter a lucid dream.
It is the psychic manifestation of the collective unconscious.
Now, you will share the same sea of consciousness with countless beings.
Would you like to try it?"]]
  },
  Event_47465_Name = {
    Text = "\"Lucid Dream\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Answer Voice] Obtain 1 Command Card from the Spirit Split Awakener."
  },
  Event_47466_Desc = {
    Text = [[
The body is a cage, imprisoning fragmented personalities.
The prison called "24" is now overcrowded.
"Do not fall asleep, do not be at peace."
In the darkness, a soft voice whispers.]]
  },
  Event_47466_Name = {
    Text = "\"Own-Becoming\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Close Your Eyes] Acquire 1 out of 3 Golden Relics"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Sneak a Peek] Rouse 2 Awakeners. Reduce their Rouse cards' Arithmetica Cost by 1."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Open Your Eyes] Acquire the Silver Relics \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", and \"(RelicConfig.Arg3)\"."
  },
  Event_47848_Desc = {
    Text = "Before going into hypnosis, the doctor said:\n\"Don't open your eyes without my permission.\"\nSo she kept her eyes shut, inhaling... exhaling...\nHalf-asleep, she seemed to hear a \"hiss\" sound.\nThen she felt the gaze of cold eyes—\nSomething was watching her.\nShould she sneak a peek?"
  },
  Event_47848_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47876_Desc = {
    Text = [[
She bent down to pick up the glittering memories.
One, two... countless joys flooded in.
She spread her arms and twirled around them.]]
  },
  Event_47876_Name = {
    Text = "\"Core Fusion\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47877_Desc = {
    Text = [[
She bent down to pick up the dim memories.
One, two... countless petty ones surged in,
She opened her arms and embraced them all.]]
  },
  Event_47877_Name = {
    Text = "\"Core Fusion\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47878_Desc = {
    Text = [[
You refuse to become a victim of these bizarre solvents.
The Doctor is somewhat disappointed, but he doesn't force you.
"I forgive humanity's cowardice and shortsightedness."]]
  },
  Event_47878_Name = {
    Text = "\"Lucid Dream\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47879_Desc = {
    Text = [[
Crash! You smash the bottle.
The green solution quickly corrodes the floor.
"Well, that was reckless ignorance. But I hope there won't be a next time.
Otherwise, I might shed tears of sadness."]]
  },
  Event_47879_Name = {
    Text = "\"Lucid Dream\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47880_Desc = {
    Text = [[
You gulped it down.
Gulp, gulp... Bubbles erupted in your brain and throat.
Like tiny crackling fireworks.
"Praise you, brave human. You will have the chance to touch infinity.
And I will bear witness to it."]]
  },
  Event_47880_Name = {
    Text = "\"Lucid Dream\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47881_Desc = {
    Text = [[
She opened her eyes and said,
"Yes, everything is wrong.
Tears should be shed, and resistance should be made."
In the darkness, rustling sounds could be heard, signaling a kind response.]]
  },
  Event_47881_Name = {
    Text = "\"Own-Becoming\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[I Saw a Snake] Acquire the Golden Relic+ \"(RelicConfig.Arg1)\""
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[I Saw You] Acquire the Sinful Relic \"(RelicConfig.Arg1)\""
  },
  Event_47900_Desc = {
    Text = [[
Snap.
A light snap of fingers pulled her back to reality.
The Doctor, at some point, had moved his face closer, his cobalt-yellow eyes gleaming with excitement.
"Tell me, what did you just see?"]]
  },
  Event_47900_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47901_Desc = {
    Text = "She opened her eyes.\nIn the hazy interplay of light and shadow, she seemed to see a tranquil white serpent coiled in the darkness, moving slowly.\nOh, and its eyes—\nPure, unblemished gold.\nNo sorrow, no joy, no judgment,\nEnough to wake a dormouse from a midsummer nightmare."
  },
  Event_47901_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47909_Desc = {
    Text = [[
She quietly opened one eye.
What she saw was a blurry white light, slowly wriggling in the dark.
A faint golden flash flickered within the light, as if warning her of her transgression.
She didn't dare to look any further.]]
  },
  Event_47909_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47910_Desc = {
    Text = [[
She followed the doctor's orders, never opening her eyes.
A cold breeze swept through the air around her, lingering on her face.
After a while, everything returned to normal.
As if nothing had happened.]]
  },
  Event_47910_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47911_Desc = {
    Text = [[

"I saw... a very beautiful snake."
The doctor paused for a moment, pen in hand.
"What kind of snake?"
"It's very beautiful! It's completely white with golden patterns..."
The doctor said nothing further, the faintest hint of a smile appearing at the corners of his mouth.
"Thank you."]]
  },
  Event_47911_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47912_Desc = {
    Text = [[
She gazes straight into the doctor's cobalt-yellow eyes.
"I see that you have turned into a snake."
"Oh. How can you be so sure that it's me?"
Because it is mysterious, still, and complex.
And...
It appears fatigued, as if it has just awakened from a millennium of hibernation.]]
  },
  Event_47912_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and receive Arg2 Black Sigils."
  },
  Event_47992_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_47992_Name = {Text = "Junction"},
  Event_47992_Tips3 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_47993_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Leave] Duplicate a random Command Card, and engrave the Orison \"(EnchantConfig.Arg1)\" on the copy."
  },
  Event_47993_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_47993_Name = {Text = "Junction"},
  Event_48225_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48225_Desc = {
    Text = [[
The cat happily licked the back of your hand.
"Thank you. Don't worry about me, meow.
Personalities here are always dying and being reborn.
I'll definitely come back!
Meow meow, meow meow meow!"]]
  },
  Event_48225_Name = {Text = "Last Words"},
  Event_48226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48226_Desc = {
    Text = [[
The cat thinks you didn't understand it, so it nuzzles your hand.
"If you agree, I'll give you all my hidden snacks.
They are safely stored in Cambre District @2..."]]
  },
  Event_48226_Name = {Text = "Last Words"},
  Event_48227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48227_Desc = {
    Text = "You sincerely apologized to George.\n\"Hmph, you at least know some manners.\nGeorge will consider reducing the curse's power by 10%,\nup to 15%—that's George's limit.\""
  },
  Event_48227_Name = {
    Text = "George's Ghost"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Agree] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Reject It] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Stay Silent] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_48228_Desc = {
    Text = [[

"Cat 24 is seriously injured, struggling to tell you:
"Meow... my time is running out...
I have a friend, a silver cod meow.
If one day you see it, tell it I've gone far away, meow.
I'll be gone for a very long time, meow.
I'll bring back lots of fries without fried fish, meow.
You must tell it!"]]
  },
  Event_48228_Name = {Text = "Last Words"},
  Event_48229_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48229_Desc = {
    Text = [[
The cat felt a bit disappointed.
But it had always been a well-behaved and obedient kitty, never forcing anyone.
In the end, it closed its eyes with regret.]]
  },
  Event_48229_Name = {Text = "Last Words"},
  Event_48230_ChoiceDesc1 = {
    Text = "[Apologize to It] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Taunt It] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Disregard It] Receive 25 Black Sigils"
  },
  Event_48230_Desc = {
    Text = [[
A ghost, George's ghost, hovers above you.
"George died without dignity.
But it doesn't matter. George will always remember this humiliation.
Keeper, you're in deep trouble, heh heh heh..."]]
  },
  Event_48230_Name = {
    Text = "George's Ghost"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48231_Desc = {
    Text = [[
"Hehe, how dare you mock George.
Don't worry, whether you're eating, sleeping, or singing...
George will always float around you, reminding and tormenting you.
So that you will forever remember your sins.
You'll never catch a ghost, la la la~"]]
  },
  Event_48231_Name = {
    Text = "George's Ghost"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48232_Desc = {
    Text = "You strode forward, leaving George's curse behind.\nFrom behind, a sobbing sound could be heard; George was crying loudly.\n\"Woo... how could someone as lovely as me end up being—\nDisgusting! Disgusting!\nGeorge would rather die under Pandia's whip!\""
  },
  Event_48232_Name = {
    Text = "George's Ghost"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Summon Awakeners] All Awakeners lose 100 Aliemus. Destroy a Symptom Card."
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Struggle] Recover Arg1 HP, but develop \"(Skill.Arg2)\" twice."
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Lose all Keyflare."
  },
  Event_49055_Desc = {
    Text = [[
As you step onto the flickering pool of bloodstains, its true form is revealed.
The crimson-black blood extends countless arms, clinging to your ankles and pulling you relentlessly toward the unfathomable abyss.]]
  },
  Event_49055_Name = {
    Text = "Pool of Gore"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_49097_Desc = {
    Text = "Your abdomen churns violently, but miraculously calms down after a few seconds. Strangely, you seem to hear another heartbeat within you..."
  },
  Event_49097_Name = {
    Text = "Nourishing Mother"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Bottoms Up] Engrave [ExDesc3][ExDesc4] Command Card(s) with the special Orison \"(EnchantConfig.Arg1)\". [ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = [[
A worn pot watches you from the crevice in the low rock wall.
Water is the most precious inventory in the desert; alcohol is a gateway to madness and illusion.
In this barren land, it would be hard for any sane person to resist its allure.]]
  },
  Event_49098_Name = {
    Text = "Nourishing Mother"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49312_Desc = {
    Text = "The Silver Key glimmers; the arms seem intimidated by some force, retreating into the pool and then disappearing."
  },
  Event_49312_Name = {
    Text = "Pool of Gore"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49313_Desc = {
    Text = [[
You struggle desperately, but sink deeper, tormented by cursed whispers in your mind.
When you come to, the blood-red tentacles have withdrawn, satisfied. You feel strangely refreshed, though something seems lost forever...]]
  },
  Event_49313_Name = {
    Text = "Pool of Gore"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49314_Desc = {
    Text = "The emergent Awakener pulls you out of the pool of blood without hesitation. Your linked arm is torn, muddy water splashing, and countless barely visible creatures writhes in the water as if craving and devouring something."
  },
  Event_49314_Name = {
    Text = "Pool of Gore"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "A random Awakener gains 50 Aliemus."
  },
  Event_49867_Name = {Text = "Event"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Ask If They're Real]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Request to Touch]"
  },
  Event_49907_Desc = {
    Text = [[
"Why do you always stare curiously at my horns? Any questions?"
Thais suddenly leans close to your shoulder, the honey-colored beads gently brushing against your cheek.]]
  },
  Event_49907_Name = {Text = "Horned One"},
  Event_49908_ChoiceDesc1 = {Text = "[Look Up]"},
  Event_49908_ChoiceDesc2 = {
    Text = "[Approach Thais]"
  },
  Event_49908_Desc = {
    Text = "Dust scatters in the ruins, and outside a broken window, Thais suddenly appears. She leans casually on the dusty windowsill, mysteriously pointing to the beam above."
  },
  Event_49908_Name = {
    Text = "Stealthborn"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_49909_Desc = {
    Text = "You look up to see rusty copper pipes sprawling like a giant spider web above. A shadow flits by—is it a foraging wild cat or a monster lurking in the shadows?\nWhen you turn back, Thais has vanished."
  },
  Event_49909_Name = {
    Text = "Stealthborn"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Stare at Her]"
  },
  Event_49910_ChoiceDesc2 = {Text = "[Call Her]"},
  Event_49910_Desc = {
    Text = [[
You see that "Phantasm" again.
This time, you already know her name.
Thais stands beneath the distant Mother Tree, praying devoutly to it.
Her outline was vague, melding with the phantasm of the Mother Tree.]]
  },
  Event_49910_Name = {Text = "Wish-Maker"},
  Event_49911_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_49911_Desc = {
    Text = [[
You gaze at Thais's figure, her silhouette resembling a sacred and majestic lone peak amidst the apocalyptic storm, undiminished by the raging sandstorm.
Her steps are slow yet steady, her posture noble and inviolable, leaving you mesmerized.]]
  },
  Event_49911_Name = {
    Text = "Undying One"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Leave] Duplicate a Command Card"
  },
  Event_49912_Desc = {
    Text = [[

"What do you guess?"
She whispers "shh," leaning closer. You feel the tip of her horn brush against your cheek, leaving a cool and tingling sensation...]]
  },
  Event_49912_Name = {Text = "Horned One"},
  Event_49913_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_49913_Desc = {
    Text = [[
"If you want to touch, just say it outright. Would I refuse you?"
She chuckles softly as she takes your hand, the warmth and smoothness of her fingertips making you feel almost entranced...]]
  },
  Event_49913_Name = {Text = "Horned One"},
  Event_49914_ChoiceDesc1 = {
    Text = "[Leave] Rouse an Awakener, reduce that Card's Arithmetica Cost by 1, but develop \"(Skill.Arg1)\"."
  },
  Event_49914_Desc = {
    Text = [[
You kneel down with the others.
"I knew it, I knew it! The Queen, Her Majesty has always been protecting us!"
The sound of joyful weeping and long cries mingles with the howling wind, resonating and vibrating through your skull.
Vaguely, a crucial thought flashes by, but you can't grasp it.]]
  },
  Event_49914_Name = {
    Text = "Undying One"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_49915_Desc = {
    Text = [[
You waves to her.
"What are you doing?" Ramona looks at you in confusion.
"Over there..."
Before you could finish your sentence, the woman in the distance has already vanished.
Could it be an illusion?]]
  },
  Event_49915_Name = {
    Text = "Water-Bowing One"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Respond to Her]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Hesitate]"},
  Event_49916_Desc = {
    Text = [[
From a distance, you see a woman drawing water by the riverbank.
Seeming to sense your gaze, she turns and waves at you.
You notice something unusual about the way she turns.]]
  },
  Event_49916_Name = {
    Text = "Water-Bowing One"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_49917_Desc = {
    Text = [[
While you hesitate, the woman turns and leaps into the oasis, vanishing from sight.
You can hardly believe your eyes... Did she have goat hooves?]]
  },
  Event_49917_Name = {
    Text = "Water-Bowing One"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_49918_Desc = {
    Text = [[
"O Mother Tree, please hear the prayer of @1. I shall bathe in your milk and be reborn, becoming your agent, walking for you in the sands, allowing your roots to reach every corner of Remouahe..."

The alternating innocent prayers echo throughout the space.]]
  },
  Event_49918_Name = {Text = "Wish-Maker"},
  Event_49919_ChoiceDesc1 = {
    Text = "[Leave] Rouse a random Awakener"
  },
  Event_49919_Desc = {
    Text = [[
Thais's ambiguous and enigmatic gaze catches your attention. A strange and eerie power leaves you spellbound, as if you are being drawn irresistibly toward her.
"Indeed, what is unseen still exists."
She whispers softly into your ear. You feel as though you have grasped something, but it is veiled by a stack of white gauze, remaining unclear.
Is this some kind of prophecy? In the blink of an eye, Thais vanishes without a trace.]]
  },
  Event_49919_Name = {
    Text = "Stealthborn"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Gaze]"},
  Event_49920_ChoiceDesc2 = {Text = "[Kneel]"},
  Event_49920_Desc = {
    Text = [[
The black hooves of the sheep tread on the sandy land.
Thais chants an unknown prayer, and countless Aramites kneel in the direction she walks.]]
  },
  Event_49920_Name = {
    Text = "Undying One"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_49921_Desc = {
    Text = [[
The giant tree extends thousands of thick branches, like entwining Tentacles, binding Thais' wrists and ankles, ignoring her struggles, and forcibly pulling her body into the swollen trunk of the tree...

Even as a distant illusion, her pain resonates with your heart through the rippling water.]]
  },
  Event_49921_Name = {Text = "Wish-Maker"},
  Event_49922_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\""
  },
  Event_49922_Desc = {
    Text = [[

Limp limbs flow like tree sap along the branches; she struggles with all her might, yet her body behaves like a staggering, twisted worm that won't obey.
"The bones have completely dissolved,"a sorrowful expression graces Thais's features, "she has become a part of the tree."
"We need the power to reverse this... a power that transcends time."]]
  },
  Event_49922_Name = {
    Text = "The Corrupt"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_49923_Desc = {
    Text = [[
"And that "Inverted Pupilless Eye"... it stirs something profound, straight from the soul..."
"Oh? Talking about me?"
"Medinet's raving about your gift for stories."

That night by the quietly burning campfire, she refilled your drink.]]
  },
  Event_49923_Name = {
    Text = "The Corrupt"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Cut the Tumor]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Recall]"},
  Event_49924_Desc = {
    Text = [[
A tree tumor.
It pulsates with an evil and swollen rhythm, and through its fragile and transparent blood-red skin, a twisted and painful face is revealed, as if it is about to break free from its cocoon.
"Medinite." Thais's face showed sorrow as she gently called the name of that face.]]
  },
  Event_49924_Name = {
    Text = "The Corrupt"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Trust Ryker] Increase all Awakeners' Aliemus by Arg1"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Worry About Ryker] Rouse 2 Awakeners"
  },
  Event_49939_Desc = {
    Text = "\"Trust my luck.\""
  },
  Event_49939_Name = {
    Text = "Lucky Detective"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49940_Desc = {
    Text = [[
Ryker excels at three things: scouting, listening, and dice throwing.
In other words, he isn't skilled in battle.
Your worry grows uncontrollably, and madness spreads.]]
  },
  Event_49940_Name = {
    Text = "Lucky Detective"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49941_Desc = {
    Text = "The heart that believes is magic; he will surely overcome all obstacles before him."
  },
  Event_49941_Name = {
    Text = "Lucky Detective"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49943_Desc = {
    Text = [[
You feel embarrassed but still look hopefully at the ailing Ramona.
"I'll do it."
Blushing, she takes a new collection vial from her infinite-capacity handbag and swiftly covers the spider.]]
  },
  Event_49943_Name = {
    Text = "Venomspinner"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49944_Desc = {
    Text = [[
Ryker snaps his fingers, then extends his furry index finger towards a spider raising its front legs.
These species with colorful patterns are often venomous. You are about to warn him, but the once hostile spider lightly leaps onto his fingertip and curls up.
Oh well, fate is fate.]]
  },
  Event_49944_Name = {
    Text = "Venomspinner"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Look at Ramona] Engrave 1 out of 3 Orisons"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Look at Ryker] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_49945_Desc = {
    Text = [[
Multiple compound eyes lock onto you.
The creature step back, baring its fangs and claws in an attempt to intimidate you.
From its raised legs and pedipalps, as well as the two pairs of limbs supporting its body, it is clearly a rare arachnid.
Czort's parting words echo in your mind: "Extra task: collect local species samples and store them at the local survey station."
You shake the collection bottle in your backpack, already brimming with insects after weeks of trekking.]]
  },
  Event_49945_Name = {
    Text = "Venomspinner"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49946_Desc = {
    Text = "\"Greed that disregards timing is a disease.\""
  },
  Event_49946_Name = {
    Text = "Your Answer"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49947_Desc = {
    Text = "\"Reciting the script won't earn you any affection, child.\""
  },
  Event_49947_Name = {
    Text = "Your Answer"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Golden Key] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Iron Key] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Silver Key] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_49948_Desc = {
    Text = [[
At noon, the vapor from the Holy River condenses into two phantasms of emptiness.
A hazy voice from the phantasm asks you: Is this the golden key, silver key, or iron key that you dropped?]]
  },
  Event_49948_Name = {
    Text = "Your Answer"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49949_Desc = {
    Text = "\"Honesty often leads to more secure outcomes, but at the same time, you might miss out on something.\""
  },
  Event_49949_Name = {
    Text = "Your Answer"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50013_Desc = {
    Text = [[
You try to make out the person's face, but it ripples with the water, remaining blurred.

The more you concentrate, the more your breathing falters, and a dizzying sense of oxygen deprivation clouds your mind. It is only when you hear Ramona calling your name that you barely snap back to reality.
The sun's reflection on the water is blinding, but something seems to shimmer beneath the surface.]]
  },
  Event_50013_Name = {
    Text = "Death Mirage"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50014_Desc = {
    Text = [[
The phantasm vanishes instantly from your hands, leaving only a sharp pain in your temple.
The sun reflected on the water is blinding, but something seems to glimmers beneath the surface.]]
  },
  Event_50014_Name = {
    Text = "Death Mirage"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Strive to Recognize] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Reach out and Touch] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Rub Your Eyes] Receive 25 Black Sigils"
  },
  Event_50015_Desc = {
    Text = [[
Nubia pushes you, and half of your leg sinks into the Holy River.
You struggle to steady yourself but see an unexpected reflection in the rippling water.
It is a tall young man in a Mythag uniform, his limp body submerged in the flow of the holy river.]]
  },
  Event_50015_Name = {
    Text = "Death Mirage"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50016_Desc = {
    Text = [[
Panic corrodes your mind, pain blurs your consciousness. You struggle desperately, but the vines tighten further; foul-smelling mucus seeps into your nostrils, each breath filled with sticky despair.
Ramona strikes. Nubia flees with a severed foot. You tear off the last Tentacle clinging to your face, which is covered in muddied flesh.]]
  },
  Event_50016_Name = {
    Text = "Oncoming Assault"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50017_Desc = {
    Text = [[
The silver light pierces Nubia's body, and the sensation of flesh bursting travels through the Silver Key to your fingertips and wrist.
Nubia's twisted limbs rise to the sky, emitting a terrifying and mournful screech, transforming entirely into a viscous unknown liquid.]]
  },
  Event_50017_Name = {
    Text = "Oncoming Assault"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Tear] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Pierce] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_50018_Desc = {
    Text = "Nubia's vine-like tendrils twist and dance, seizing the opportunity to lash at your face, violently invading your mouth and nose."
  },
  Event_50018_Name = {
    Text = "Oncoming Assault"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50019_Desc = {
    Text = [[
The water's surface shimmers with rippling light.
You lift your soaked legs and pour the damp sand out of your shoes.
The image from before still lingers in your mind, refusing to fade.]]
  },
  Event_50019_Name = {
    Text = "Death Mirage"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50029_Desc = {
    Text = [[
"Will he return? Or will he abandon you forever in this boundless desert?"
"Can he find you? Or will the shifting winds and dunes cause him to lose your coordinates?"
"Is the hope you place in others truly reliable?"]]
  },
  Event_50029_Name = {Text = "Lost Shoal"},
  Event_50030_ChoiceDesc1 = {
    Text = "[Seek Rescue] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Move Forward] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_50030_Desc = {
    Text = [[
An ancient and distant voice mingling with the sound of flowing water, poses a question to you.
"You are lost amidst endless sands."
"You have two choices. Your companion travels faster; let him take food and water to seek help while you stay behind to minimize consumption."
"Or you can share everything and continue forward together."]]
  },
  Event_50030_Name = {Text = "Lost Shoal"},
  Event_50031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50031_Desc = {
    Text = [[
"You may not be able to go further, but your spirit and flesh are tightly bound, drawing strength from one another."
"This is your choice."
As  these words are spoken, the searing sun high above closes its eye.]]
  },
  Event_50031_Name = {Text = "Lost Shoal"},
  Event_50064_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Resist] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Call Ramona] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_50064_Desc = {
    Text = "Casiah throws a red silk ribbon, which instantly wraps around your briefcase."
  },
  Event_50064_Name = {
    Text = "Entangled Silk"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50065_Desc = {
    Text = [[
The intermittent crisp tapping echoes through the crisscrossing pipes above you, like a ghost dancing alone, feebly waving its arms in this dead silent space.
This imagination summons an ancient, chilling fear deep within you.]]
  },
  Event_50065_Name = {
    Text = "Eerie Scale"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Explore the Cave Entrance] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Deep into the Cave] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50066_Desc = {
    Text = [[
"There is a cave here."
Thais invites you.
"Shall we go in?"
The narrow cave is dark and deep, like the gaping maw of a giant demon, stretching into endless darkness. Anyone who enters this desolate place cannot escape the ominous feeling rising from their spine. It's as if in every corner, ancient creatures that shun sunlight are lurking, waiting for intruders.]]
  },
  Event_50066_Name = {
    Text = "Dark Cavern"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Strike One by One] Upgrade a random Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Surround the Two] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Eavesdrop] Receive 25 Black Sigils"
  },
  Event_50067_Desc = {
    Text = [[
Two Aramite guards are keeping watch over the factory gate.
One of them idly wanders around, striking up a conversation with the other.
"Some say Lady Juliette is counting the teams attempting to break through the Storm Wall again."
"I really hope I don't get selected."]]
  },
  Event_50067_Name = {
    Text = "Idle Gatekeeper"
  },
  Event_50067_Tips1 = {
    Text = "Silver Relic not yet acquired"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50068_Desc = {
    Text = [[
Do not look, do not listen, do not think.
Without pondering where that untimely sound comes from, you head straight for the Mother Tree's Remains.]]
  },
  Event_50068_Name = {
    Text = "Eerie Scale"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50069_Desc = {
    Text = "Ramona thrusts her sword at Casiah, who is waving the red silk. Casiah dodges hurriedly, causing the silk entangling you to loosen instantly."
  },
  Event_50069_Name = {
    Text = "Entangled Silk"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50070_Desc = {
    Text = [[
You split into two groups. You and Ramona go left, Ryker goes right, flanking from both sides.
You signal, and Ramona and Ryker strike simultaneously. The two Aramite guards fall silently.]]
  },
  Event_50070_Name = {
    Text = "Idle Gatekeeper"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50071_Desc = {
    Text = "Now is not the time to delve into the traps. Just lingering at the cave entrance, you can almost feel the evil pulse throbbing within the rock's veins."
  },
  Event_50071_Name = {
    Text = "Dark Cavern"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50072_Desc = {
    Text = [[
At your signal, Ryker knocks out the silent Aram guard with a dice, then quietly approaches another guy who is still chattering.
"Hey, brother, what if that Lady Juliette is a fraud?"
"I don't know either."
Ryker grins happily, causing the guard to shiver. Just as he is about to scream, Ryker covers his mouth and nose.]]
  },
  Event_50072_Name = {
    Text = "Idle Gatekeeper"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Listen Carefully] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Cover Ears] Receive 15 Black Sigils for each Awakener with 50 or more Aliemus."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Check] Engrave 1 out of 3 Orisons"
  },
  Event_50073_Desc = {
    Text = "When you enter the remains' floor, a melodious chime abruptly echoes in the empty abandoned factory. The clear sound of the piano contrasts sharply with the rusted steel ruins."
  },
  Event_50073_Name = {
    Text = "Eerie Scale"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50074_Desc = {
    Text = [[
"Hey, brother, what if that Juliette is a liar? What do you think we should do?"
"Don't talk nonsense. Ever since Juliette arrived, everything has been managed in an orderly fashion. If she's a liar, why would she help the Aramites so much?"
As they chat, Ryker quietly moves into his ambush position, and with a bang, two dice fly out, knocking the two of them to the ground.]]
  },
  Event_50074_Name = {
    Text = "Idle Gatekeeper"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50075_Desc = {
    Text = [[
You muster the courage to glare back.
The gigantic eye behind the curtain twists into a hideous grin, and your steadfast resistance shakes and crumbles.]]
  },
  Event_50075_Name = {Text = "Magic Eye"},
  Event_50076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50076_Desc = {
    Text = [[
You tear the curtain with unwavering focus.
Under your hand, the giant eye turns into a piece of flat, shredded fabric.]]
  },
  Event_50076_Name = {Text = "Magic Eye"},
  Event_50077_ChoiceDesc1 = {
    Text = "[Stare Back] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Tear Curtain] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_50077_Desc = {
    Text = [[
The curtain reveals countless twisted eyes.
The immense being lurking behind them exudes an intense hunger, eager to pounce.]]
  },
  Event_50077_Name = {Text = "Magic Eye"},
  Event_50078_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50078_Desc = {
    Text = "It turns out to be a discarded, elongated part disturbed by your movements, wobbling and knocking against the iron pipe."
  },
  Event_50078_Name = {
    Text = "Eerie Scale"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50079_Desc = {
    Text = [[
Thais calmly steps into the cave, and you cautiously follow behind as you explore.
"Be careful!" You are suddenly pulled back and fall into a soft embrace. In front of you, a pitch-black behemoth charges out of the cave with unmatched swiftness.
"Look here," Thais says as you remain stunned, her eyes glowing faintly in the darkness, "It might be its treasure."]]
  },
  Event_50079_Name = {
    Text = "Dark Cavern"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50080_Desc = {
    Text = [[
You desperately cling to the suitcase handle, struggling against the red silk.
But the red silk is overwhelmingly strong, causing your suitcase to slip from your grasp and scatter items everywhere.]]
  },
  Event_50080_Name = {
    Text = "Entangled Silk"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50081_Desc = {
    Text = [[
You hate the feeling of being restrained.
You grab the red silk and tear it in half with a ripping sound.
The remaining piece slithers away like a red snake.]]
  },
  Event_50081_Name = {
    Text = "Entangled Silk"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Destroy Offering] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Untie the Rope] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Keep Going] Receive 50 Black Sigils"
  },
  Event_50276_Desc = {
    Text = [[
Three Aramites were bound to a high platform.
Dark, bark-like patterns that you had seen on infants' skin appeared on them as they chanted incantations.]]
  },
  Event_50276_Name = {
    Text = "Three Offerings"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Stare] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignore] Engrave 1 out of 3 Orisons"
  },
  Event_50277_Desc = {
    Text = [[
The Aramites kneel in the sandstorm.
The storm lashes their bodies, and sand engulfs their devout hearts.
In the swirling dust, countless giant eyes seem to gaze down upon the distorted land.]]
  },
  Event_50277_Name = {
    Text = "Dust Behemoth"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50278_Desc = {
    Text = [[
The scenes you don't want to recall reappear before your eyes.
Wriggling tentacles, blood oozing from cuts made by glass shards...
You feel nauseous.]]
  },
  Event_50278_Name = {
    Text = "Lone Journey II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50279_Desc = {
    Text = [[
She's not here; she's not amidst the most perilous surge.
That alone should set your mind at ease.]]
  },
  Event_50279_Name = {
    Text = "Lone Journey I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Surprise Attack] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Attack] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_50280_Desc = {
    Text = [[
A Nubia struggles in the fierce sandstorm.
Its four hooves are deeply embedded in the yellow sand, striving to avoid being swept into the vortex.]]
  },
  Event_50280_Name = {
    Text = "Nature's Sandstorm"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50281_Desc = {
    Text = [[
You rush in, cutting the ropes amid the Aramites' shouts.
An Aramite warrior approaches; you seize his spear and point it at the dark crowd.]]
  },
  Event_50281_Name = {
    Text = "Three Offerings"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50282_Desc = {
    Text = [[
Reason tells you, he won't come back.
Yeah, who would expect a gambler to keep his promise?
You're left with nothing but loneliness. You have only loneliness.]]
  },
  Event_50282_Name = {
    Text = "Lone Journey III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50283_Desc = {
    Text = [[
Will the abnormal fever worsen with the revival of the Mother Tree?
Can Ramona take care of herself alone outside the Storm Wall?
Now is not the time to be distracted, but you can't help worrying about your partner.]]
  },
  Event_50283_Name = {
    Text = "Lone Journey I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50284_Desc = {
    Text = [[
You decide to face the challenge head-on, while Nubia seems to find a rare foothold and leaps up to cling to your head.
You are caught in the dual entanglement of the sandstorm and Nubia.
"Blind bravery alone is not the way to victory," William's cold voice sounds like an angel's gospel to your blocked ears. "Learn to seize opportunities."]]
  },
  Event_50284_Name = {
    Text = "Nature's Sandstorm"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50285_Desc = {
    Text = "Now is not the time to leisurely read the newspaper."
  },
  Event_50285_Name = {
    Text = "Her Admonition"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50286_Desc = {
    Text = [[
You don't think, you don't recall.
You don't want to think, you don't want to recall.
The legend of Mythag will come to an end, but its journey will not stop.
You must keep moving forward. You must keep moving forward.]]
  },
  Event_50286_Name = {
    Text = "Lone Journey II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50287_Desc = {
    Text = [[

"Dear Keeper:
Hope this letter finds you well.
I'm sorry I couldn't stay by your side during this Remouahe journey due to my neglect of my body.
But at crucial moments, please trust your only assistant.
Whenever you need me, I am always there."
Due to time constraints, you could not read any further.
But the familiar handwriting brought you a calming sense of serenity.]]
  },
  Event_50287_Name = {
    Text = "Her Admonition"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[He'll Be Back] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[He Won't Come] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50288_Desc = {
    Text = [[
The last person to leave was Ryker.
To stop Casiah, he chose to stay in the tent.
He promised you that he would crash the ritual, burn the Mother Tree, and stay by your side.
But now, he still hasn't come to you.
Leaving you all alone.]]
  },
  Event_50288_Name = {
    Text = "Lone Journey III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50289_Desc = {
    Text = [[
Gurgling, three turn horrors roll at the ritual site.
You feel detached from yourself; the sick fervor of the ritual engulfs you into an indescribable Illusion.]]
  },
  Event_50289_Name = {
    Text = "Three Offerings"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50290_Desc = {
    Text = [[
Aramites' faith is so devout that they willingly allows the sands to bury them again and again.
But when you look up, there is no sun in the storm.]]
  },
  Event_50290_Name = {
    Text = "Dust Behemoth"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50291_Desc = {
    Text = "May the Sand Sea respond to their devotion."
  },
  Event_50291_Name = {
    Text = "Dust Behemoth"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Break Free from Memories] Enhance the Orison quality of a random card."
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Capture Memories] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_50292_Desc = {
    Text = "The second person to leave was William."
  },
  Event_50292_Name = {
    Text = "Lone Journey II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Calm] Receive 25 Black Sigils"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Worry] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_50293_Desc = {
    Text = [[
You suddenly recall the day you set out on your journey.
Ramona reminded you to pack your bags, William prepared a journal for you, and Ryker secretly slipped a bottle of whiskey into your bag.
Now they are gone.

The first to leave was Ramona. Tawil's power conflicted with the Authority of the Storm Wall, and she succumbed to a high fever along the way.]]
  },
  Event_50293_Name = {
    Text = "Lone Journey I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50294_Desc = {
    Text = "You strike Nubia's foot, causing it to lose balance. Its vine-like limbs flail frantically in the air before being swept up by the dust storm."
  },
  Event_50294_Name = {
    Text = "Nature's Sandstorm"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Read] Destroy a Card"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Put Away] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_50295_Desc = {
    Text = "Click-clack.\nBeneath this otherworldly, frenzied altar, the heavy drumbeats roll in with the sandstorm. Amidst the ceaseless chanting, you hear the faint sound of a typewriter— the call from Mythag, soothing your restless heart."
  },
  Event_50295_Name = {
    Text = "Her Admonition"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50296_Desc = {
    Text = [[
Ryker has extraordinary luck.
If he promises you something, he will definitely deliver.
Absolutely.]]
  },
  Event_50296_Name = {
    Text = "Lone Journey III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50297_Desc = {
    Text = [[
None of your business.
What you need to do now is quickly approach and destroy the Mother Tree's Remains.]]
  },
  Event_50297_Name = {
    Text = "Three Offerings"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52373_Desc = {
    Text = [[
You have survived. You see countless mounds and burned bodies.
You seem to have burned something as well, but it no longer matters.
You hear the bells of the Divine Realm ringing.]]
  },
  Event_52373_Name = {
    Text = "Plague Onslaught"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52374_Desc = {
    Text = [[
You've survived. You see countless mounds and burned bodies.
You fought fiercely to protect what you cherished, paying a heavy price. But it no longer matters.
You hear the bells of the Divine Realm ringing.]]
  },
  Event_52374_Name = {
    Text = "Plague Onslaught"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52375_Desc = {
    Text = [[
The giant's rage has temporarily subsided. The clouds have cleared, and calm prevails. The ocean, like an eternal mother, gently caresses Lemuria's back with soft tides. All that remains on Lemuria are corpses and ruins.
You fought desperately to protect what you cherished, paying a heavy price. But it no longer matters.
In the ocean, you caught a glimpse of the outline of the Divine Realm.]]
  },
  Event_52375_Name = {
    Text = "Ocean's Roar"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Offer Additional Sacrifices] Destroy a Command Card and receive 1 of all 3 types of  \"Divine Realm's Illusion\" cards."
  },
  Event_52376_Desc = {
    Text = "Standing before the crumbling throne of Lemuria, you offer your final tribute.\nThe endless Abyss reveals itself before you. You kneel, smiling, tears streaming down.\n\"Look, Father, Deborah. Behold, my supreme King—the Divine Realm has descended before me!\""
  },
  Event_52376_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Lose Arg1 HP, and develop a random Symptom."
  },
  Event_52377_Desc = {
    Text = [[
Earth. The silent, steadfast Earth. It bears humanity and endures eternally. But now it trembles, splitting into bottomless chasms, shaking all that it holds.
You have placed all your hopes on the Earth, but when it begins to quake, where will you go?
Sacrifice, the people of Lemuria call out to you. Sacrifice everything you have to bring forth an untroubled the Divine Realm.]]
  },
  Event_52377_Name = {
    Text = "Earth Tremor"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Lose Arg1 HP, and develop a random Symptom."
  },
  Event_52378_Desc = {
    Text = [[
Ocean. The ocean is the mother of Lemuria, your life, your faith. Now, the ocean rises like an angry giant deity of legend. It roars, transforming gentle waters into hard rocks and sharp spikes, crashing down on everything before it. It coldly gazes at trembling Lemuria at its feet, at the Lemurians scurrying like insects. It will destroy Lemuria, regardless of Lemuria's actions.
Sacrifice, cry the children of Lemuria. Sacrifice everything so that the Divine Realm may arrive peacefully.]]
  },
  Event_52378_Name = {
    Text = "Ocean's Roar"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Lose Arg1 HP, and develop a random Symptom."
  },
  Event_52379_Desc = {
    Text = "Plague. It is everywhere. The plague acts as the most shameless servant, delivering unspeakable deaths on behalf of the gods after their wrath upon the land and sea has passed. Bury the bodies of the dead, burn the bodies of the dead, and pray for those who died protecting you—keep them as far away as possible. Life and humanity crumble before the plague.\nSacrifice, citizens of Lemuria cry out. Sacrifice everything to bring about a the Divine Realm free from plague."
  },
  Event_52379_Name = {
    Text = "Plague Onslaught"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52380_Desc = {
    Text = [[
The violent tremor subsided. The streets were stained with crimson blood, and countless people were buried under collapsed houses.
You fought fiercely to protect what you cherished, paying a heavy price. But that no longer matters.
The only thing that matters is that you are one step closer to the Divine Realm.]]
  },
  Event_52380_Name = {
    Text = "Earth Tremor"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52381_Desc = {
    Text = "Standing before the crumbling throne of Lemuria, you recite the final prayer.\nThe endless abyss reveals itself before you. You kneel, smiling, tears streaming down.\n\"Look, father, Deborah. Behold, my supreme king—the Divine Realm, has descended before me!\""
  },
  Event_52381_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52382_Desc = {
    Text = [[
The violent tremor subsided. The streets were stained with crimson blood, and countless people were buried under collapsed houses.
Something of yours seemed to be buried in the rubble as well, but it no longer matters.
The only thing that matters is that you are one step closer to the Divine Realm.]]
  },
  Event_52382_Name = {
    Text = "Earth Tremor"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52383_Desc = {
    Text = [[
The giant's rage has temporarily subsided. The clouds have cleared, and calm prevails. The ocean, like an eternal mother, gently caresses Lemuria's back with soft tides. All that remains on Lemuria are corpses and ruins.
Something of yours seems to have been lost at sea, but it no longer matters.
In the ocean, you glimpsed the outline of the Divine Realm.]]
  },
  Event_52383_Name = {
    Text = "Ocean's Roar"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Devout Prayer] Destroy all Basic Symptom cards in your deck. Receive that many plus 2 random \"Divine Realm's Illusion\" cards."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Devout Prayer] Destroy all Basic Symptom cards in your deck. Receive that many plus 2 random \"Divine Realm's Illusion\" cards."
  },
  Event_52384_Desc = {
    Text = [[
The earth no longer trembles, the ocean no longer roars, the plague no longer invades. The cataclysm destroyed Lemuria, leaving only you. You look around, seeing ruins everywhere. You look at your empty hands.
But so what, honorable high priest? Tread upon the ruins and corpses of Lemuria, and keep crawling forward.
You are only one step away from the Divine Realm.]]
  },
  Event_52384_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53140_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_53140_Name = {Text = "Junction"},
  Event_53141_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and obtain Arg2 Black Sigils."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Fall into Madness] Rouse 2 random Awakeners, but develop a random Symptom."
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Hesitation] Others"
  },
  Event_53141_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_53141_Name = {Text = "Junction"},
  Event_53141_Tips3 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_53142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53142_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_53142_Name = {Text = "Junction"},
  Event_53143_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53143_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_53143_Name = {Text = "Junction"},
  Event_53147_ChoiceDesc1 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and obtain Arg2 Black Sigils."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Fall into Madness] Rouse 2 random Awakeners, but develop a random Symptom."
  },
  Event_53147_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_53147_Name = {Text = "Junction"},
  Event_53147_Tips1 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_53148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53148_Desc = {
    Text = [[
You establish the connection. A voice, both maddening and intoxicating, comes through the device.
"Remember this: it is a blessing from the Divine Realm."]]
  },
  Event_53148_Name = {Text = "Junction"},
  Event_55782_ChoiceDesc1 = {
    Text = "[Cut Through Thorns] Compose Arg1 Imagery \"(Skill.Arg2)\". Next battle, enemies have +30% HP and deal +15% DMG."
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Cut Through Thorns] Compose Arg1 Imagery \"(Skill.Arg2)\". Next battle, enemies have +30% HP and deal +15% DMG."
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Part the Thorns] Compose Arg1 Imagery \"(Skill.Arg2)\", but develop the Symptom \"(Skill.Arg3)\"."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Part the Thorns] Compose Arg1 Imagery \"(Skill.Arg2)\", but develop the Symptom \"(Skill.Arg3)\"."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Leave the Thorns] \"Horla's Pen and Ink\" gains Arg1 stack(s) of \"Ink\"."
  },
  Event_55782_Desc = {
    Text = [[
Something touched your heartstrings. You stopped and gazed at the corner of the garden. Beneath the stacks of thorns, a light flickers, struggling to break free.
What is it? A butterfly? A bird? You move closer to it.]]
  },
  Event_55782_Name = {
    Text = "Muse's Blessing"
  },
  Event_55782_Tips1 = {
    Text = "The enemies in the next battle have been enhanced and cannot be chosen again."
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Create Offering] Choose 3 \"Imagery\" cards and let Horla compose an \"Verse\" for you."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Leave]"},
  Event_55783_Desc = {
    Text = [[
You come to a beautiful greenhouse and look inside through the window, but see nothing.
A gust of wind blows, stirring the petals and leaves inside. Amidst the flowers and leaves, you see a girl's figure.
"Ah! A guest in the garden!" The girl looks at you with surprise and nervousness. "Sorry, Colette is out... I don't know the prices of these flowers..."
The girl suddenly stops, approaches you, and examines you closely. "Ah, dear guest, I sense poetic imagery in you... Perhaps we can create a poem together?"]]
  },
  Event_55783_Name = {
    Text = "Spring's Gift"
  },
  Event_55783_Tips1 = {
    Text = "Insufficient \"Imagery\" cards. At least 3 are required."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55799_Desc = {
    Text = "The living thorns seem restless, but these costs are trivial— at that light spark, you hear the Muse's call."
  },
  Event_55799_Name = {
    Text = "Muse's Blessing"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Skip the battle and claim instant victory, but lose Arg1 HP."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Leave] Enter Battle"
  },
  Event_55819_Desc = {
    Text = "Facing familiar enemies, you already know the upcoming battle well."
  },
  Event_55819_Name = {
    Text = "Muscle Memory"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55997_Desc = {
    Text = "You selected a few from the gathered images and handed them to the girl.\n\"Such beautiful imagery! Esteemed guest, please wait a moment... Here. This is an offering unique to spring, exclusively for you!\"\nA poem materialized in your hand, like a flower blooming just for you.\nYou wanted to thank the girl, but when you looked up, her figure had already vanished. In the desolate greenhouse, only withered flowers and leaves remained.\n—The ashes left after spring's blaze."
  },
  Event_55997_Name = {
    Text = "Spring's Gift"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55999_Desc = {
    Text = "Thick thorns make you hesitate. You leave the light spot, but the brief gaze still fills your heart with new inspiration— at that spot, you hear the muse's call."
  },
  Event_55999_Name = {
    Text = "Muse's Blessing"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56000_Desc = {
    Text = "You push aside the thorns with your hand, sustaining minor injuries, but the cost is negligible—at that light spot, you hear the Muse's call."
  },
  Event_56000_Name = {
    Text = "Muse's Blessing"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56024_Desc = {
    Text = [[
Not enough... You continue towards the light. The thorns are provoked, revealing their sharp points. But it's all worth it.
The light disperses from your palm, and amidst the glowing screen, you clearly feel Muzus' blessing.]]
  },
  Event_56024_Name = {
    Text = "Muse's Blessing"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Approach Light Points] Upgrade an Imagery card. Next battle, enemies have +30% HP and deal +15% DMG."
  },
  Event_56025_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56025_Desc = {
    Text = "You used your tools to cut through the thorns. The living thorns seemed restless, but the cost was negligible— at that bright spot, you heard the Muse's call."
  },
  Event_56025_Name = {
    Text = "Muse's Blessing"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56146_Desc = {
    Text = [[
Not enough... You move closer to the light. Sharp thorns pierce your hand, causing blood to flow endlessly. But it's worth it.
The light disperses from your palm, and amidst the glowing screen, you clearly feel Muzus' blessing.]]
  },
  Event_56146_Name = {
    Text = "Muse's Blessing"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Creative Impulse] All Awakeners lose all Aliemus. Choose 3 Imagery cards and let Horla create an \"Offering\" for you."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56147_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_56147_Name = {Text = "Junction"},
  Event_56147_Tips1 = {
    Text = "Insufficient Imagery. At least 3 are required."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56148_Desc = {
    Text = "The silver light on the emblem stirs your emotions. Following the guidance of your heart, you throw what you have into the thorns. The light beneath begins to shine— in that light, you gain new inspiration."
  },
  Event_56148_Name = {Text = "Junction"},
  Event_56149_ChoiceDesc1 = {
    Text = "[Approach Light Points] Upgrade an Imagery card, but reduce your Max HP by 10%."
  },
  Event_56149_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56149_Desc = {
    Text = "You push aside the thorns with your hand, sustaining minor injuries, but the cost is negligible—at that light spot, you hear the Muse's call."
  },
  Event_56149_Name = {
    Text = "Muse's Blessing"
  },
  Event_56149_Tips1 = {
    Text = "That Imagery can't be upgraded."
  },
  Event_56150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56150_Desc = {
    Text = "The silver light on the emblem stirs your emotions. You feel a strong urge to record the poem in your mind."
  },
  Event_56150_Name = {Text = "Junction"},
  Event_56151_ChoiceDesc1 = {
    Text = "[New Inspiration] Destroy an Imagery card, and upgrade a random Imagery card."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56151_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_56151_Name = {Text = "Junction"},
  Event_56151_Tips1 = {
    Text = "Insufficient Imagery"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Forceful Entry] Increase all Awakeners' Aliemus by 30, but add two \"(Skill.Arg1)\" cards to the deck."
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Disarm] Enemies in the next battle have 60% more HP and deal 30% more DMG."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Ambush] All Awakeners lose all Aliemus; receive 30 Black Sigils."
  },
  Event_57738_Desc = {
    Text = [[
You peek out from the blind spot at the corner. The Committee Agents are watching in another direction, unaware of your presence.
Memories of past training flash through your mind, and you quickly come up with a way to deal with the enemies blocking your path.]]
  },
  Event_57738_Name = {
    Text = "Committee Agents"
  },
  Event_57738_Tips3 = {
    Text = "No Awakeners have Aliemus."
  },
  Event_57739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57739_Desc = {
    Text = [[
You observed carefully. The Committee's Agents blocked your path, diligently monitoring the area.
Facing numerous enemies, you couldn't fight them.
Advance or retreat?]]
  },
  Event_57739_Name = {
    Text = "Detention Point"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Feign Surrender] After exploring this area, be transferred to the Detention Point and develop two random Symptoms."
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Intrude] After exploring this area, be transferred to the Detention Point and lose Arg1 HP."
  },
  Event_57776_Desc = {
    Text = [[
You observe carefully. The Committee Agents are blocking your path, diligently monitoring the area.
Faced with numerous enemies, you are no match for them.
Advance or retreat?]]
  },
  Event_57776_Name = {Text = "Watchpoint"},
  Event_57776_Tips3 = {
    Text = "You don't have enough HP."
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistair's Blessing] Add 1 \"Polar Dusklight\" to your deck."
  },
  Event_59193_Desc = {
    Text = "The admission certificate had been lying at the bottom of your suitcase. You gently caressed its exquisite frame, which seemed to be edged with the lingering glow of stars, while inhaling the faint scent of ink unique to the paper. The Mythag emblem shone like a radiant gateway to the future, captivating your eager eyes—just as it did that day, just as it does today."
  },
  Event_59193_Name = {
    Text = "Entrance Ceremony"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Choose a Card to comprehend \"Lex Nous\" Orison. \"Lex Nous\": After playing, draw 2 cards; their Arithmetica Cost reduces the actual Arithmetica Cost of Orison cards, and it only takes effect once per battle."
  },
  Event_59527_Desc = {
    Text = [[
The symbol of knowledge is engraved on your document.
Tawil's thoughts flow into your mind. Among the endless possibilities, you are heading toward the one true path.]]
  },
  Event_59527_Name = {
    Text = "Entrance Ceremony"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Choose a Card to comprehend \"Lex Volis\" Orison. \"Lex Volis\": After playing, discard all cards other than this Awakener, and gain 5 random non-Awakener cards. This effect is only active once per battle."
  },
  Event_59528_Desc = {
    Text = [[
The symbol of joy is engraved on your document.
Through the mark, N is observing you. He anticipates that you will bring about an outcome He has never rashly mentioned.]]
  },
  Event_59528_Name = {
    Text = "Entrance Ceremony"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Select a Card to comprehend \"Lex Genis\" Orison. \"Lex Genis\": When played, gain 3 additional Base Copies with \"Retain\" and \"Exhaust,\" effective only once per battle."
  },
  Event_59529_Desc = {
    Text = [[
The symbol of propagation is engraved on your document.
Thais pins Her hopes on you, and She will coexist with you in every world.]]
  },
  Event_59529_Name = {
    Text = "Entrance Ceremony"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Wipe Blood Tears] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Eyes Open] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59566_Desc = {
    Text = [[
Countless wishes merge. You once shared the same origin, and now you share the same body.
Countless eyes open together, confronting the great eye.
Countless eyes shatter together, shedding tears of dry blood.]]
  },
  Event_59566_Name = {
    Text = "Fusion of Selves"
  },
  Event_59567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59567_Desc = {
    Text = [[
You try to argue with the mad voice, refuting the void's ideology.
"Everything dies, does that make life meaningless?"
You argue vehemently, but the laughter remains, mocking your stupidity.]]
  },
  Event_59567_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59568_Desc = {
    Text = [[
You gaze at the gate, unwilling to bear the anguish of ignorance.
You yearn to see what lies beyond it.
The illusory gate sways hypnotically, flickering with fleeting glimpses of countless worlds.
With no time to comprehend, an infinite surge of information floods your spirit, filling your mind with chaotic noise.]]
  },
  Event_59568_Name = {
    Text = "Beyond the Gate"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Firm Command] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Joint Discussion] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_59569_Desc = {
    Text = [[
Everything happened so suddenly. A mist envelops you, and despite your efforts to look around, you can't see anything clearly.
The Awakeners await your command.
Now, isolated, you must rely on your own Power.]]
  },
  Event_59569_Name = {
    Text = "Ignorant Gaze"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[With Sacrifice] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[With Bravery] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[With Direct Stare] Receive 50 Black Sigils"
  },
  Event_59570_Desc = {
    Text = [[
Countless versions of you stand in countless worlds, shoulder to shoulder, hand in hand, like siblings.
Now you all stand beneath the great Shadow, heads held high, not retreating a single step.
What to do?
How can you defeat that final version of yourself?]]
  },
  Event_59570_Name = {
    Text = "Self-Answer"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Seek Answers] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Give Up] Receive 25 Black Sigils and leave."
  },
  Event_59571_Desc = {
    Text = [[
Passing through the phantasm of the Gate, countless experiences of yourself flash back in your mind.
Some died, some went mad, some persevered, others fell.
Countless paths and choices flash before you, and you seem to live a long, endless life in an instant.
Now countless minds and mouths operate simultaneously.
You attempt to converse with countless versions of yourself across time and space, fishing for answers from the endless memories.]]
  },
  Event_59571_Name = {
    Text = "Self-Inquiry"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Exchange Power] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Exchange Fortune] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_59572_Desc = {
    Text = [[
Every choice comes at a price.
Life, spirit, emotion, memory...
What do you wish to exchange with fate, and what will you place on the scales?]]
  },
  Event_59572_Name = {
    Text = "Fate's Choice"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59573_Desc = {
    Text = [[
How can one live without a heart?
You frantically search around, your breathing quickening with each passing moment, the fear of death clouding your mind.
"Can't breathe... My heart is stopping..."
Wait, you realize you no longer need a heartbeat.
You finally understand and laugh joyfully.]]
  },
  Event_59573_Name = {
    Text = "Hollow Chest"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Peer] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Evade] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_59574_Desc = {
    Text = [[
You sense a presence in the void watching you.
Wherever you go, that gaze follows you like a shadow.
You feel like a small prey being targeted, and your back begins to ache as if pricked by needles.]]
  },
  Event_59574_Name = {Text = "Its Gaze"},
  Event_59575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59575_Desc = {
    Text = [[
Unfazed by the chaotic performance, you steadfastly maintain your own rhythm.
The opponent's attacks and temptations prove ineffective. Two melodies are played simultaneously on the piano, and whoever endures until the end will master all the notes.]]
  },
  Event_59575_Name = {
    Text = "Apocalypse Rhapsody"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59576_Desc = {
    Text = "With all your courage, no matter what comes, you will keep moving forward alongside your comrades."
  },
  Event_59576_Name = {
    Text = "Frozen Future"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59577_Desc = {
    Text = [[
"Where are you now?"
"What are the teachers planning?"
"What should I do next?"
You anxiously question, hoping to rely on that dependable presence as usual.
The communicator stalls and loses its response. You shake the device, and the words on the reply twist into a swarm of butterflies, fluttering onto your face.
You rub your eyes, realizing it is just a phantasm.
The reply paper is blank.]]
  },
  Event_59577_Name = {
    Text = "Echo of Delirium"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Panic Search] Increase Max HP by Arg1"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Attempt to Fill] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59578_Desc = {
    Text = [[
You feel an emptiness and lightness in your chest. Looking down, you see it has opened like a keyhole.
Your heart is missing.]]
  },
  Event_59578_Name = {
    Text = "Hollow Chest"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59579_Desc = {
    Text = [[
You loudly question his intent, only to receive an unchanged smile.

He has long abandoned the world. A detached individual bears no responsibilities.
Your resistance is in vain.]]
  },
  Event_59579_Name = {
    Text = "Mad Gentleman"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Disrupt Rhythm] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Self-Preservation] Engrave 1 out of 3 Orisons"
  },
  Event_59580_Desc = {
    Text = [[
You play as if accompanied by a madwoman, she binds you to the keys, dragging you into her frenzied melody.
You struggle to keep up with her rhythm, stumbling along.
You fight to take control of the tune.]]
  },
  Event_59580_Name = {
    Text = "Apocalypse Rhapsody"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59581_Desc = {
    Text = [[
You desire unparalleled power to shatter all chains and barriers.
However, human strength has its limits. Challenging the gods with a frail body will ultimately burn away your life like a matchstick.]]
  },
  Event_59581_Name = {
    Text = "Fate's Choice"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59582_Desc = {
    Text = [[
"Gone... All gone..."
You feel empty and pick up a pocket watch, apple, and school jacket to fill the void.
Your chest feels full again, albeit overly so.
It's okay; things are never perfect.]]
  },
  Event_59582_Name = {
    Text = "Hollow Chest"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Persuade] Receive 25 Black Sigils"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Question] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59583_Desc = {
    Text = [[
N's shoes stop in front of you, a distorted grin on his dark face.
He always dresses impeccably, but beneath that gentlemanly facade lies pure madness.
He has no friends, and few enemies.
Because they all vanish in the most theatrical manner.
Unfortunately, you are now his next lead.
Prepare your opening line. How will you satisfy this most critical audience?]]
  },
  Event_59583_Name = {
    Text = "Mad Gentleman"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59584_Desc = {
    Text = [[
The Awakeners don't know much more than you do, but they have long been your most loyal companions, comrades, and support.
You discuss strategies with the Awakeners. Though still uncertain, you all find the courage to move forward anew.]]
  },
  Event_59584_Name = {
    Text = "Ignorant Gaze"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59585_Desc = {
    Text = [[
As if solidifying your resolve, you respond with a loud and firm voice.
Your voice reverberates among countless bubbles, as if countless versions of yourself are taking the oath together.
You are now ready to face everything.]]
  },
  Event_59585_Name = {
    Text = "Its Inquisition"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59586_Desc = {
    Text = [[
You remain motionless, staring intently at the words on the reply.
Under your gaze, the words gradually blur and twist, transforming into butterflies that flutter toward your face.
You wave your hands to drive them away, only to find the reply paper now completely blank.
Indeed, dreams that are too good to be true are always false.]]
  },
  Event_59586_Name = {
    Text = "Echo of Delirium"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59587_Desc = {
    Text = [[
You loathe these despicable threads.
You pull them with all your might; some snap, while countless others tangle back together.
You exhaust all your strength in the struggle against them.]]
  },
  Event_59587_Name = {
    Text = "Puppet Hands"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Slay Shadows] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Crush Embryo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Receive 25 Black Sigils"
  },
  Event_59588_Desc = {
    Text = [[
In a daze, you see people you once met in Aram approaching you.
They laugh and invite you to drink, dance, and enjoy the feast.
Then their flesh starts to peel off stack by stack, falling to the ground and writhing into new Embryos.
They reach out to you, inviting you to join the celebration of flesh and rebirth.]]
  },
  Event_59588_Name = {
    Text = "Shadows of the Past"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59589_Desc = {
    Text = [[
Before you reach out, you suddenly recall that you've never owned a cat like this.
You and the cat lock eyes through the air, and it blinks at you.
The cat doesn't care about your indifference; it still seems to love you just the same.]]
  },
  Event_59589_Name = {
    Text = "Feline Allure"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Embed] Transform a Relic into the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Swallow] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Store] Receive 25 Black Sigils"
  },
  Event_59590_Desc = {
    Text = [[
The power of the three Aeons within you is merging, and you struggle to control it.
Your spirit realm continues to expand as a galaxy is born and spreads.
Facing an endless wave of enemies, you sincerely pray to this starry sky, wishing for its assistance.
A star falls from the galaxy into your palm, radiating an enchanting glow.]]
  },
  Event_59590_Name = {
    Text = "Wishing Star"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59591_Desc = {
    Text = [[
You respond with silence. No words are exchanged; silence is the answer.
You are ready to face everything.]]
  },
  Event_59591_Name = {
    Text = "Its Inquisition"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59592_Desc = {
    Text = [[
Is that cat a liar?
You begin to doubt those pool-like blue eyes as laughter echoes around you.
"Liar, liar, you've been tricked!"
A sense of worry wells up inside you.]]
  },
  Event_59592_Name = {
    Text = "Secret Whisper"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59593_Desc = {
    Text = [[
Like an observer, you silently watch the gradually unfamiliar emotions.
You suppress all lingering desires and feel your soul grow cold.
This is your fate, your destined path.]]
  },
  Event_59593_Name = {
    Text = "Crystallized Emotion"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59594_Desc = {
    Text = [[
That smiling face remains unmoved; neither your logical arguments nor emotional appeals can sway him.
Human desires are of no concern to him.
Can your words transcend the limits of human imagination?]]
  },
  Event_59594_Name = {
    Text = "Mad Gentleman"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Answer] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Remain Silent] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_59595_Desc = {
    Text = [[
Countless bubbles like countless turn eyes silently watch you, as if questioning without a sound.
Are you ready?
Ready to give up everything?
Ready to bear it all?]]
  },
  Event_59595_Name = {
    Text = "Its Inquisition"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59596_Desc = {
    Text = "As the opponents launch their attack, you immediately retaliate.\nYou astutely identified their true nature—they are nothing but beasts revealing their fangs.\nYou are fortunate to emerge victorious.\nNow, flee for your life and make sure they don't catch you."
  },
  Event_59596_Name = {Text = "Abyssbound"},
  Event_59597_ChoiceDesc1 = {
    Text = "[Seek Answers] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Give Up] Leave"
  },
  Event_59597_Desc = {
    Text = [[
What should you do?
You see countless versions of yourself, their faces identical to yours, staring at you, their lips moving.
As if grasping at a straw of hope, you desperately search and listen, hoping to find the final answer.]]
  },
  Event_59597_Name = {
    Text = "Self-Inquiry"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59598_Desc = {
    Text = [[
Not yet. You need to endure and wait.
You swallow your resentment and hatred, awaiting the decisive moment.]]
  },
  Event_59598_Name = {
    Text = "Puppet Hands"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59599_Desc = {
    Text = [[
You feel an inexplicable pull, as if drawn to the source of unseen gazes.
You gaze into the void, feeling as though you've caught a glimpse of something.
Your vision is momentarily obscured by snow-like blurs, and the world before your eyes seems transformed.
As you rub your eyes, you notice two streams of blood tears flowing down your face.]]
  },
  Event_59599_Name = {Text = "Its Gaze"},
  Event_59600_ChoiceDesc1 = {
    Text = "[Recall] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Taste Sorrow] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Accept Silently] Receive 25 Black Sigils"
  },
  Event_59600_Desc = {
    Text = [[
As if undergoing the most precise brain surgery, you can distinctly feel cherished memories being extracted from your mind, leaving your thoughts blurred as if your brain is melting.
You tremble in pain, pressing down on your hand that resists.
Crystal-clear tears stream down, but why are they falling?
You seem to have forgotten.
You feel an inexplicable sadness.]]
  },
  Event_59600_Name = {
    Text = "Mnemonic Dissociation"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59601_Desc = {
    Text = [[
Your bond with the cat is beyond doubt. You wave and move forward without looking back.
"Fool! Fool!"
The voice behind you yells in frustration.]]
  },
  Event_59601_Name = {
    Text = "Secret Whisper"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59602_Desc = {
    Text = "Determined, you resolve to fight to the end, carrying everyone's hope, no matter the cost."
  },
  Event_59602_Name = {
    Text = "Frozen Future"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Restrain] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Gaze] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59603_Desc = {
    Text = [[
Behind the Gate guarded by Tawil lies an endless world and infinite truths.
You don't know what she sees beyond the door, but you know she knows everything.
Now, the door stands open before you, silently inviting you to uncover all the truths hidden behind it.]]
  },
  Event_59603_Name = {
    Text = "Beyond the Gate"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59604_Desc = {
    Text = [[

Show respect for the unknown; avoiding its edge is a wise choice.
You lower your head and grip the Silver Key at your chest, feeling slightly comforted.
At least you still have your power and Awakeners.
You try to ignore those gazes and focus on the road ahead.
But have those gazes truly disappeared? You know the answer.]]
  },
  Event_59604_Name = {Text = "Its Gaze"},
  Event_59605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59605_Desc = {
    Text = [[
If all means of opposing the gods are as futile as ants trying to shake a tree, the only thing you can hold onto is unwavering courage.
When endless destruction looms overhead, you will be the one standing at the forefront.]]
  },
  Event_59605_Name = {
    Text = "Self-Answer"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59606_Desc = {
    Text = [[
You touch the falling tears, reliving an unfathomable sorrow.
It feels as if you've lost something precious, but you can't recall what it was.
What a pity.
You weakly wipe away your tears, forcing a bitter smile.]]
  },
  Event_59606_Name = {
    Text = "Mnemonic Dissociation"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59607_Desc = {
    Text = [[
You ignore their voices.
You don't care whether the cat is a liar; you only trust your own power.
Voices sigh in your ears.]]
  },
  Event_59607_Name = {
    Text = "Secret Whisper"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Seek Answers] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Give Up] Leave"
  },
  Event_59608_Desc = {
    Text = [[
Someone laughs madly.
That version of yourself believes all is futile, better to give up early.
You frown, and that self suddenly smiles, suggesting ending everyone's lives to spare them from suffering.
You wave away the voice, firm in your beliefs.]]
  },
  Event_59608_Name = {
    Text = "Self-Inquiry"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogate] Destroy any 2 Cards"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Pierce] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_59609_Desc = {
    Text = [[
In the long wait, you reopen the communicator. Perhaps your longing and prayers have borne fruit; you see familiar and affectionate responses emerging on the letter.
She is very safe now, with everything arranged by her mentors, and Mythag is operating smoothly...
Seeing the good news come like snowflakes, you can't help but feel a stirring in your heart.]]
  },
  Event_59609_Name = {
    Text = "Echo of Delirium"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Catch the Stars] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Crush the Stars] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Watch Silently] Receive 25 Black Sigils"
  },
  Event_59610_Desc = {
    Text = [[
Your emotions are stripped away along with your memories. You feel yourself transforming into a vast entity, like a monster returning to its ancient, warm nest.
Countless emotions condense into bright stars, raining down in your spirit realm.
The traces of your existence vanish like a shooting star.
You silently watch, picking up a star that echoes with your laughter.
And so you laugh too, savoring the moment.]]
  },
  Event_59610_Name = {
    Text = "Crystallized Emotion"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59611_Desc = {
    Text = [[
You know these are merely shadows of the past; you mercilessly slaughter those who once conversed with you, devoid of any emotion.
Their laughter and tears shatter in your grasp, leaving no room for hesitation.
If this is a necessary trial, then you shall become the most ruthless executioner.]]
  },
  Event_59611_Name = {
    Text = "Shadows of the Past"
  },
  Event_59612_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_59612_Desc = {
    Text = [[
Its soft fur and clear eyes naturally inspire trust.
You approach the cat, and it comes closer to you.
Neither of you speaks, but its tail stands upright.]]
  },
  Event_59612_Name = {
    Text = "Feline Allure"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59613_Desc = {
    Text = [[
You suppress your curiosity, knowing this gate must never be opened.
Too much truth can sometimes be a curse.
Clutching the Silver Key against your chest, you resolve to keep this gate sealed forever.]]
  },
  Event_59613_Name = {
    Text = "Beyond the Gate"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Courage] Enhance the Orison quality of 2 random cards."
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Resolve] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_59614_Desc = {
    Text = [[
Tawil's words echo in your mind.
Among countless endings, there is only one true path.
In a daze, you see the fleeting shadows of many worlds flash before your eyes like frames of film, waiting for the moment to freeze.
What fate will befall the world in the next second?]]
  },
  Event_59614_Name = {
    Text = "Frozen Future"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignore Suspicion] Receive 50 Black Sigils"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Arbitrary] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_59615_Desc = {
    Text = [[
With N's mockery, you begin to doubt everyone you've met.
Which are his avatars, and which are your true mentors and friends?
His shadows keep shifting, revealing countless faces, all grinning at you.]]
  },
  Event_59615_Name = {
    Text = "Hundred-Faced Shade"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59616_Desc = {
    Text = "If everyone is capable of betrayal, then rely on no one.\nIn the darkness, you can only confirm one truth.\nAt least you still have yourself—the most loyal version of yourself that you can trust."
  },
  Event_59616_Name = {
    Text = "Hundred-Faced Shade"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59617_Desc = {
    Text = [[
You squeeze the glowing crystal into powder.
You greedily inhale the emotions from the past.
An intense wave of joy floods your brain but then dissipates like a phantasm.
Your lips curl up high before slowly dropping.
Your face gradually becomes calm and expressionless.]]
  },
  Event_59617_Name = {
    Text = "Crystallized Emotion"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59618_Desc = {
    Text = [[
You know everything comes at a cost, and if the price of salvation is sacrifice, then you are prepared to pay it in full.
You are ready to give your all at any moment.]]
  },
  Event_59618_Name = {
    Text = "Self-Answer"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Seek Answers] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Give Up] Leave"
  },
  Event_59619_Desc = {
    Text = [[
Someone shouts.
That self, eager to flee, claims that resistance is futile.
Only endless escape can delay ultimate annihilation.
You are skeptical.]]
  },
  Event_59619_Name = {
    Text = "Self-Inquiry"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59620_Desc = {
    Text = [[
You know the terrifying speed of embryo proliferation; new life here is a curse akin to locusts.
You crush the newborns before they can cry.
The figures made of flesh and blood look at you with venomous hatred, questioning your desecration of sacred life.
You respond with relentless slaughter.]]
  },
  Event_59620_Name = {
    Text = "Shadows of the Past"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59621_Desc = {
    Text = [[
At this moment, you hope to be the luckiest person, achieving the most perfect ending.
But the cost of good fortune can sometimes be more cruel. Luck and misfortune often go hand in hand. When you gain something, don't forget to check what you've lost.]]
  },
  Event_59621_Name = {
    Text = "Fate's Choice"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59622_Desc = {
    Text = [[
It's like fighting for the steering wheel of a car, your hands flying everywhere, trying to take control of the rhythm of the music.
In the heat of the struggle, you suddenly press down on a row of keys.
The chaotic performance is disrupted; you grin and descend into an even deeper madness.]]
  },
  Event_59622_Name = {
    Text = "Apocalypse Rhapsody"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Approach] 100% chance to get 25 Black Sigils"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Gaze] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_59623_Desc = {
    Text = [[
A cat follows you, its fur sleek and clean, its front paws as white as snow.
The cat stays by your side, step by step, like your most loyal servant.
All your confusion, helplessness, pain, and anxiety are soothed.]]
  },
  Event_59623_Name = {
    Text = "Feline Allure"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Deny] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Retort] Acquire the Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\", but develop \"(Skill.Arg1)\" twice."
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Remain Silent] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_59624_Desc = {
    Text = [[
You fall into an illusion of nothingness.
You see countless people silenced under the shadow of doom, as tiny as specks of dust.
They are lifeless, gray, and devoid of hope.
You hear someone's piercing laughter.
"Look, this is the result of your persistence."
"The world never ends; everything is meaningless."]]
  },
  Event_59624_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59625_Desc = {
    Text = [[
No, this is wrong, this is not real.
You continuously deny the mad voices, but the gray shadows remain unmoved, seemingly confirming an illusory end.
The laughter grows louder, mocking your helplessness]]
  },
  Event_59625_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59626_Desc = {
    Text = [[
A profound sense of regret and reluctance overwhelms you; you instinctively struggle to recall the past, searching for its traces among the fragments of memory.
The blurred reflections swiftly recede, and though you desperately try to grasp them, they slip through your fingers.
You come to realize that you are about to lose everything.]]
  },
  Event_59626_Name = {
    Text = "Mnemonic Dissociation"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Approach] 100% chance to get 25 Black Sigils"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Gaze] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_59627_Desc = {
    Text = [[
A cat follows you, its fur sleek and clean, its front paws as white as snow.
The cat stays by your side, step by step, like your most loyal servant.
All your confusion, helplessness, pain, and anxiety are soothed.]]
  },
  Event_59627_Name = {
    Text = "Feline Allure"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59628_Desc = {
    Text = [[
Here, you meet your ultimate self; the battle to destroy the world is but an exchange of gazes.
When It looks at you, you must firmly return Its gaze until one of them fades.]]
  },
  Event_59628_Name = {
    Text = "Self-Answer"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Breath] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Counterattack] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Struggle] Receive 25 Black Sigils"
  },
  Event_59629_Desc = {
    Text = [[
Heavy footsteps echo as a group of Committee Agents block your way.
"Please cooperate with our investigation."
The cold voice carries a hint of malice.
With a splash, the calm water is disturbed, and they throw you into the depths.]]
  },
  Event_59629_Name = {Text = "Abyssbound"},
  Event_59630_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59630_Desc = {
    Text = [[
You struggle desperately.
Forward, just a little further.
No matter the cost, you must protect everything.
You reach out as threads cut into your flesh, yet you feel nothing.]]
  },
  Event_59630_Name = {
    Text = "Puppet Hands"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59631_Desc = {
    Text = [[
You shake your head violently, clearing the chaotic memories from your mind.
Soon, the cacophony fades away, and your consciousness regains its independence.
You know you'll find no aid in past failures; only by focusing on the present can you find hope.]]
  },
  Event_59631_Name = {
    Text = "Self-Inquiry"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_59632_Desc = {
    Text = [[
Before you reach out, you suddenly recall that you've never owned a cat like this.
You and the cat lock eyes through the air, and it blinks at you.
The cat doesn't care about your indifference; it still seems to love you just the same.]]
  },
  Event_59632_Name = {
    Text = "Feline Allure"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Seek Answers] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Give Up] Leave"
  },
  Event_59633_Desc = {
    Text = [[
Someone weeps.
Full of sorrow, they long to embrace their loved ones.
Their greatest regret is not being with those they care about during the destruction.
Your heart aches as you share in their sorrow.]]
  },
  Event_59633_Name = {
    Text = "Self-Inquiry"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59634_Desc = {
    Text = [[
You gaze at countless gray figures, ignoring the mocking laughter.
How can you save a crumbling world?
You contemplate amidst the silent extinction.]]
  },
  Event_59634_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59635_Desc = {
    Text = [[
The air in your alveoli gradually disappears, and you attempt to breathe underwater.
What a foolish act, yet you succeed.
Your alveoli refill, and you can breathe freely once again.
But what exactly are you inhaling?]]
  },
  Event_59635_Name = {Text = "Abyssbound"},
  Event_59636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59636_Desc = {
    Text = [[
You sink into the viscous liquid.
No matter how hard you struggle, you only sink deeper.
You can't escape this mire alone.]]
  },
  Event_59636_Name = {Text = "Abyssbound"},
  Event_59637_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59637_Desc = {
    Text = [[
You force yourself to forget these doubts.
You know that suspicion is futile at this moment; you can only trust.
Until the sealed box is opened, its truth remains unknown to you.
Sometimes, playing the part of a confused fool brings peace.]]
  },
  Event_59637_Name = {
    Text = "Hundred-Faced Shade"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59638_Desc = {
    Text = [[
All eyes are on you. As the leader, you must not show any fragility.
"Head to the Black Pool, everything will be alright."
You calmly issue the command, making a promise you barely believe yourself.]]
  },
  Event_59638_Name = {
    Text = "Ignorant Gaze"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Suspect] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Disdain] Acquire the Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\", but develop \"(Skill.Arg1)\" twice."
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignore] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_59639_Desc = {
    Text = [[
Three hesitant figures mutter something in front of you.
You lean in to listen, their words blending with their breath becoming clearer.
"Don't trust that cat; it's a liar."
You turn abruptly, only to find no one beside you.]]
  },
  Event_59639_Name = {
    Text = "Secret Whisper"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59640_Desc = {
    Text = [[
The stars look so delectable, you covet their power and swallow one whole.
Gulp.
Your spirit feels fuller than ever, and a light shines in your peripheral vision.
You look down and see the star still glowing in your stomach.]]
  },
  Event_59640_Name = {
    Text = "Wishing Star"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Snap the Thread] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Endure] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_59641_Desc = {
    Text = [[
All the way you are pushed forward, your every choice manipulated by invisible threads.
You struggle to grasp everything you care about.
The fate of the world hangs just before your fingertips.
Countless threads entwine, binding your entire body.]]
  },
  Event_59641_Name = {
    Text = "Puppet Hands"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59642_Desc = {
    Text = [[
You wipe away the blood tears, only for more to keep flowing.
Red clouds your vision, as if foretelling a bloody sacrifice.
You continue to wipe, trembling in pain, but without an ounce of fear.]]
  },
  Event_59642_Name = {
    Text = "Fusion of Selves"
  },
  Event_59643_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59643_Desc = {
    Text = [[
You caress the magical gem and embed it into the Silver Key.
Starlight envelops you.
You're dazzled]]
  },
  Event_59643_Name = {
    Text = "Wishing Star"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59644_Desc = {
    Text = [[
Regardless, you kept your eyes wide open, turning sheer will into a defiant roar.
Even if you shatter and fade away, you won't retreat a single step.]]
  },
  Event_59644_Name = {
    Text = "Fusion of Selves"
  },
  Event_59645_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59645_Desc = {
    Text = [[
Someone remains silent.
Seeing the face of the despairing self, you know none of them made it to the end.
You have traveled the farthest among all selves; only your answer holds the final hope.]]
  },
  Event_59645_Name = {
    Text = "Self-Inquiry"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59646_Desc = {
    Text = [[
You reach out, grabbing at countless shooting stars, luminous crystals brushing against your fingertips.
Joy, sorrow, anger, fear...
You greedily seize every emotion, only to watch them slip through your fingers.
Brilliant light illuminates your face, your eyes gradually turning deep and dark.]]
  },
  Event_59646_Name = {
    Text = "Crystallized Emotion"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Call Out] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Touch] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_59657_Desc = {
    Text = [[
You witness the automaton breaking down.
She was once the most rational being, your most loyal assistant, carefully preserving all the information you had gathered.
Now, it seems she no longer remembers any of the moments you shared.
You see crystalline tears falling from the corners of her eyes.]]
  },
  Event_59657_Name = {
    Text = "Automaton's Tear"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59658_Desc = {
    Text = [[
You refuse to give up and attempt to reach her energy core.
If it's a machine, it can be restarted, right?
However, the merciless automaton doesn't grant you that naive opportunity.
Your restraint fails to elicit mercy from the automaton, forcing you to fight with everything you've got.]]
  },
  Event_59658_Name = {
    Text = "Automaton's Tear"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59659_Desc = {
    Text = [[
You don't want to damage your former partner.
You desperately call out her name and issue all commands, but to no avail.
The automaton has betrayed you, reverting to the coldness of an inanimate object.]]
  },
  Event_59659_Name = {
    Text = "Automaton's Tear"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60944_Desc = {
    Text = [[
Time is running out, so you choose the most direct approach and break through the blockade. The Awakeners are inspired and become excited.
As for the increased enemy alertness, it is not a concern.]]
  },
  Event_60944_Name = {
    Text = "Committee Agents"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60945_Desc = {
    Text = [[
Before the agent can react, you circle behind and seize his weapon. Before reinforcements arrived, you successfully escape.
Sadly, the word is out, and the next enemies will be more prepared. Be ready.]]
  },
  Event_60945_Name = {
    Text = "Committee Agents"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60946_Desc = {
    Text = [[
The agent is drawn by a whistle, approaching your hiding spot. As he gets close, the waiting Awakeners launch their attack.
A perfect ambush. The threat here has been permanently eliminated.]]
  },
  Event_60946_Name = {
    Text = "Committee Agents"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60947_Desc = {
    Text = [[
Facing numerous enemies, you are unable to fight back. You deliberately step into their line of sight without resistance.
You know that you will soon be taken to a detention point, which is part of the plan.
You will escape from there and find a new path.]]
  },
  Event_60947_Name = {Text = "Watchpoint"},
  Event_60948_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60948_Desc = {
    Text = [[
Facing numerous enemies, you cannot contend with them. After a brief battle, you give up resisting.
You know you are about to be taken to a holding point, which is part of the plan.
You will escape from there and find a new path.]]
  },
  Event_60948_Name = {Text = "Watchpoint"},
  Event_60949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60949_Desc = {
    Text = [[
Facing numerous enemies, you cannot contend with them.
You choose to leave temporarily and seek a new path.]]
  },
  Event_60949_Name = {Text = "Watchpoint"},
  Event_61058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61058_Desc = {
    Text = [[
You gaze at your hands and your entire body, filled with hope and determination.
If all of this is part of fate's design, you are prepared to face it all.
In the final moments, should there be doors to heaven or hell, you will be the one to open them for the world.]]
  },
  Event_61058_Name = {Text = "Peek"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Ready for Battle] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continue Observing] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_61059_Desc = {
    Text = "You don't rush into battle but calmly try to figure out the situation. This sudden conductor seems both friend and foe; you're unsure of his intentions. Nevertheless, you decide to fully prepare, ready to meet his challenge before observing his true motives."
  },
  Event_61059_Name = {
    Text = "Demon Conductor"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Listen] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Call Out] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_61060_Desc = {
    Text = [[
Since the accident, you've heard nothing from your partner.
Countless attempts at contact were like throwing stones into the sea, without any response.
When you've lost all hope, the communicator suddenly makes a sound.
You open the suitcase, bringing the receiver close to your ear.
"Keeper..."
In a daze, you hear the long-missed voice, echoing distantly through the void.]]
  },
  Event_61060_Name = {
    Text = "Echo of Longing"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Embrace the Darkness] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Attempt to Swim] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Call to the Ghosts] Receive 25 Black Sigils"
  },
  Event_61061_Desc = {
    Text = [[
You rush forward, and the ground suddenly turns into an impassable sea.
You sink into the soil.
Darkness, thick and sticky like ghosts in a graveyard, surrounds you, greedily invading your mouth and nose.]]
  },
  Event_61061_Name = {
    Text = "Sinking Under"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61062_Desc = {
    Text = [[
You widen your eyes, searching for every clue.
A hundred eyes move simultaneously; you see the paw prints of the human-faced hound in front and the trajectory of Hameln's baton waving behind.
You greedily observe everything.
Suddenly, you notice a familiar eyeball rolling on the ground.
It seems to be one of your own.]]
  },
  Event_61062_Name = {
    Text = "Ravenous Scholarship"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61063_Desc = {
    Text = [[
No, you can't see so many things.
How many eyes do you have again? Only... a few?
In a hurry, you close your eyes and feel around your face.
One, two...
When you open your eyes again, your vision becomes narrow and ignorant.
Ah, you only have two eyes. What a pity.]]
  },
  Event_61063_Name = {
    Text = "Ravenous Scholarship"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Search] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Shut Your Eyes] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_61064_Desc = {
    Text = "More and more clues twist into a tangled mess, making you anxious, confused, resentful—you hate yourself for knowing nothing.\nEnormous stress tightens your spirit into a fine thread.\nWith a snap, you feel your scalp suddenly relax, and you find yourself able to perceive all the surroundings, witnessing the shadows flickering in the void.\nMore, you need to see more..."
  },
  Event_61064_Name = {
    Text = "Ravenous Scholarship"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61065_Desc = {
    Text = [[
You swim through the soil, imagining yourself as the most agile fish.
To become a fish, you must give up your human legs.
This is the cost of the deal.
Soon, you feel an unprecedented sense of freedom as you become the most liberated being underground.
You return to the surface, but you have forgotten how to walk.]]
  },
  Event_61065_Name = {
    Text = "Sinking Under"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61066_Desc = {
    Text = [[
Your fingers touch the familiar feel of the Silver Key, the core of all light.
It embodies your life and destiny.
Memories flash before your eyes.
Your choices are now inextricably linked to the world's fate.
Your destiny is tied to many others.]]
  },
  Event_61066_Name = {Text = "Peek"},
  Event_61067_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61067_Desc = {
    Text = [[
You feel surrounded by many familiar presences.
You attempt to call out to the ghosts that may not exist.
A miracle occurs, and you find yourself back on the ground.
Countless gravestones stand silent.]]
  },
  Event_61067_Name = {
    Text = "Sinking Under"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61068_Desc = {
    Text = [[
You have no time for sentiment; your sole aim is to save this crumbling world.
If you must become a star, then be a shooting star.
Even if you fall, as long as you illuminate the night sky.]]
  },
  Event_61068_Name = {Text = "Peek"},
  Event_61069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61069_Desc = {
    Text = [[
You press your ear closer, trying to catch every tiny sound.
"I..."
"You must..."
You can only hear broken phrases, unable to discern any meaning.
But you dare not make a sound, fearing you might miss even one word.
However, fate shows no mercy.
The last trace of sound fades away, leaving only silence.]]
  },
  Event_61069_Name = {
    Text = "Echo of Longing"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61070_Desc = {
    Text = "You stop thinking further and command the Awakeners to line up to meet his challenge."
  },
  Event_61070_Name = {
    Text = "Demon Conductor"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61071_Desc = {
    Text = [[
You keep calling her name, trying to convey even a trace of your feelings.
You don't know if she heard you. You strain to make out the faint sounds coming through the microphone.
It might be her response, or perhaps fragments of the past looping endlessly.
Reliving the joys and sorrows you once shared together.]]
  },
  Event_61071_Name = {
    Text = "Echo of Longing"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61072_Desc = {
    Text = [[
Perhaps this darkness is the real world. What's wrong with joining it?
You fully embrace the darkness, and it no longer rejects you. You can breathe freely.
In the next second, you return to the surface. Perhaps something remains underground, but it no longer matters.]]
  },
  Event_61072_Name = {
    Text = "Sinking Under"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Gaze at Light] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Touch Chest] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Keep Running] Receive 25 Black Sigils"
  },
  Event_61073_Desc = {
    Text = [[
You are lost and can only run frantically, with no time to think.
Suddenly, you feel an emptiness in your chest.
Looking down, you see a key-shaped light where your heart should be.
The light grows brighter, spreading across your entire body.
You see yourself transforming into a star.
You suddenly realize that perhaps this has always been your mission.]]
  },
  Event_61073_Name = {Text = "Peek"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Ready for Battle] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Observe Carefully] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_61074_Desc = {
    Text = [[
"Hey... wait! What's going on..."
"Rehearsal."
The man looks at you expressionlessly.
"Using music to maintain the Awakener link is a new experiment. Ensuring the orchestra's quality ensures a perfect performance."
He lifts his baton gracefully, marking the start.
"Play, Keeper. Show me what you can do."]]
  },
  Event_61074_Name = {
    Text = "Demon Conductor"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Ready for Battle] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_61075_Desc = {
    Text = "Whatever his intentions, he saved you from the Committee's enforcers. If he meant to harm you, he wouldn't have helped. Steeling yourself, you prepare for the worst."
  },
  Event_61075_Name = {
    Text = "Demon Conductor"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65400_Desc = {
    Text = "A liaison conveyed promises of rescue from the outside, rekindling hope as the rescue team attempted to reach the mountain."
  },
  Event_65400_Name = {
    Text = "Contact Point"
  },
  Event_65401_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65401_Desc = {
    Text = [[
None of the expedition members made it out of the snow mountain. In the face of disaster, you always choose yourself, and the lives of ordinary people mean nothing to you. You abandoned your humanity and safely reached the end.
The rescuers looked at you with complex emotions, but you remained unfazed and walked into the snowstorm. Perhaps at midnight, the souls who perished due to your indifference will gather around your bed, silently watching you.]]
  },
  Event_65401_Name = {Text = "Safe Exit"},
  Event_65402_ChoiceDesc1 = {
    Text = "[Crowd Evacuation] Remove the relic \"Expedition Team\" and gain different levels of \"Rescue Medal\" based on the number of expedition team members."
  },
  Event_65402_Desc = {
    Text = [[
You have safely delivered the expedition team to the evacuation point. The rescue team takes over, and the rescued individuals collapse to the ground, as if in another world.
But you know that the real crisis is far from resolved. The giant beast still lurks in the mountains, waiting hungrily for its next move.]]
  },
  Event_65402_Name = {Text = "Safe Exit"},
  Event_65403_ChoiceDesc1 = {
    Text = "[Supply Trade] Receive 25 Black Sigils, plus 1 per Expedition Member (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Rescue Promise] Engrave 1 out of 3 Orisons. Gain 2 Expedition Members."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Profit First] Acquire a Golden+ Relic, but lose 10 Expedition Members."
  },
  Event_65403_Desc = {
    Text = "You trudge through the snowstorm, following the flickering lights of the distant emergency contact point.\n○ Finally, after countless prayers, you catch sight of the small hut that holds hope."
  },
  Event_65403_Name = {Text = "Junction"},
  Event_65403_Tips3 = {
    Text = "Too Few Expedition Members"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65404_Desc = {
    Text = "You obtained the warehouse code from the liaison and found a two-day supply of inventory for everyone. At least you won't starve or freeze to death on the snow mountain."
  },
  Event_65404_Name = {
    Text = "Contact Point"
  },
  Event_65415_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_65415_Desc = {
    Text = "The snow mountain instantly completed its \"meal,\" with two people forever disappearing into the bottomless crevasses, completely unnoticed by all of you."
  },
  Event_65415_Name = {Text = "Illusion"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Leave] Look for Searchlight"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Snow Intrusion] Lose 2 Expedition Members"
  },
  Event_65416_Desc = {
    Text = [[
A sudden gale sweeps across the snow mountain, the howling wind akin to a beast's scream, blinding you with snow fog. Something seems to be moving in the endless white.
You are forced to stop, planting your legs firmly in the snow to avoid sliding down the slope.]]
  },
  Event_65416_Name = {Text = "Unknown"},
  Event_65417_ChoiceDesc1 = {
    Text = "[Silent Evaporation] Lose 2 Expedition Members"
  },
  Event_65417_ChoiceDesc2 = {Text = "[Leave]"},
  Event_65417_Desc = {
    Text = [[
Roaring sounds emerge from the bowels of the snow mountain, like the growls of a hungry beast. The ground trembles, the ice beneath the snow silently cracking, as if the snow mountain has opened its maw.
When the tremors finally cease, people look around in confusion, and you turn to check on the group.]]
  },
  Event_65417_Name = {Text = "Illusion"},
  Event_65468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65468_Desc = {
    Text = "To ensure the team's mobility, you abandoned those struggling, leaving them in an isolated cabin. It might increase the survival rate of the rest, but do you feel nothing confronting their resentful gazes?"
  },
  Event_65468_Name = {
    Text = "Contact Point"
  },
  Event_65483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65483_Desc = {
    Text = [[
You saved some people, but more remained in the snow mountain. At least you did your best.
The rescuers said your efforts would be recognized later. You waved them off and walked back into the snowstorm.]]
  },
  Event_65483_Name = {Text = "Safe Exit"},
  Event_65484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65484_Desc = {
    Text = [[
You focused solely on escaping the snow mountain, choosing the most efficient path. In the eyes of the last survivor, you might appear as a demon.
The rescuers mentioned that your contributions would soon be honored. You waved them off and walked into the snowstorm.]]
  },
  Event_65484_Name = {Text = "Safe Exit"},
  Event_65485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65485_Desc = {
    Text = [[
Under your relentless protection, the entire expedition team emerged unscathed. Meeting you was their greatest stroke of luck amidst misfortune; you are their true savior.
You created a miracle amidst the disaster, and soon, tales of the Snow Mountain hero will spread far and wide. The rescuers solemnly stated that your remarkable contributions would soon be honored. With a smile, you waved your hand and walked back into the snowstorm.]]
  },
  Event_65485_Name = {Text = "Safe Exit"},
  Event_65486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65486_Desc = {
    Text = [[
You truly care about people's lives. Most of them were saved by you, and they cried and thanked you endlessly for your protection.
The rescuers solemnly promised that your exceptional contribution would soon be recognized. You smiled, waved, and walked into the snowstorm.]]
  },
  Event_65486_Name = {Text = "Safe Exit"},
  Event_65487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65487_Desc = {
    Text = [[
You fought against the ever-changing disaster and pulled people back from the brink of death. Thanks to your efforts, the tragic ending shifted slightly.
The rescue team solemnly recognized your invaluable contribution and announced that you would be commended. You smiled, waved, and walked back into the snowstorm.]]
  },
  Event_65487_Name = {Text = "Safe Exit"},
  Event_6817_ChoiceDesc1 = {
    Text = "[Stop Here] Engrave 1 out of 3 Orisons"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Keep Reading] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_6817_Desc = {
    Text = [[
On the top of a wooden bookshelf, there is a book with a golden cover. From ground level, its name is indiscernible.
For some reason, an overwhelming urge to read it wells up within you... This urge rapidly becomes uncontrollable. Ignoring the risk of being noticed, you climb the wooden ladder next to the bookshelf, take the book, and begin reading eagerly...
Vague impressions surface in the ocean of your mind. You are submerged in a sea of illusions...]]
  },
  Event_6817_Name = {
    Text = "Yellow Tome"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Listen] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble] Receive 15 Black Sigils for each Awakener with 50 or more Aliemus."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_6818_Desc = {
    Text = [[
The sound of the piano suddenly reaches your ears. Ethereal green fingers dance on the keys, creating a melody as graceful as a flowing stream.
"Dear friend, would you like to join me in a duet?"
The hands do not speak; they ask you through the music.]]
  },
  Event_6818_Name = {
    Text = "Harp's Phantom"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6819_Desc = {
    Text = "Ramona looked towards the source of the sound, only to catch a fading phantasm, like a gramophone melting into the wall."
  },
  Event_6819_Name = {
    Text = "Others' Ears"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Clean the Typewriter] Destroy a Command Card, and receive 25 Black Sigils."
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Try to Identify Text] Duplicate a Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6820_Desc = {
    Text = "The typewriter in the suitcase suddenly spewed thick ink, splattering into linear streams as the train swayed."
  },
  Event_6820_Name = {
    Text = "Typewriter's Murmur"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6821_Desc = {
    Text = "As your fist disperses the phantasm, memories rush into your mind, striking your soul with pain"
  },
  Event_6821_Name = {Text = "Mirage"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Discard the Letter] Destroy a Card"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Keep Close] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_6822_Desc = {
    Text = [[

You pull a few sheets of paper from the typewriter. The smeared ink emits a strong scent. You glance through the contents, instinctively frowning.
Most of the letter has been blotted out, leaving only fragments that barely form sentences, making it almost unreadable.]]
  },
  Event_6822_Name = {
    Text = "Stained Letter"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6823_Desc = {
    Text = [[
You strain to decipher the blurred writing on the paper. The words twist and then reveal something entirely different.
"@2I assume you saw the news in the newspaper.
Yes, your father has removed you from the line of succession... We didn't want to @2
Devil, devil...
Stop associating with Mr. Herbert immediately, or I'll cut off your financial support..."]]
  },
  Event_6823_Name = {
    Text = "Inscribed Presence"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6824_Desc = {
    Text = [[

You were torn apart by a surge of absurdity, your limbs contorted as you crawled on the ground, seemingly manipulated by something from beyond the dimension @2.
"No... no..."
Your sanity crumbled bit by bit, delirious laughter and screams intertwining like a giant web that bound your consciousness, leaving only indistinct moans spilling from your lips.]]
  },
  Event_6824_Name = {
    Text = "Watcher's Gaze"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6825_Desc = {
    Text = "Hand it to the Keeper for handling; who knows what kind of individual it might Awaken."
  },
  Event_6825_Name = {
    Text = "Lonely Silver Core"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6826_Desc = {
    Text = "A sorrowful melody flows by the ear, filling the mind and soul with anguish and pain. Before realizing it, tears have already welled up in someone's eyes."
  },
  Event_6826_Name = {
    Text = "Nameless Echo"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Open the Left Door] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Open the Right Door] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6827_Desc = {
    Text = [[
Doors. Doors. Countless doors.
There seem to be more doors than when you and Ramona last inspected.
You stand in the hallway, ready to push open the next door.
Behind the door on the left, all is silent, quietly waiting for your arrival.
Behind the door on the right, muffled voices can be heard.]]
  },
  Event_6827_Name = {
    Text = "Gate Infinity"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Listen Closely] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Plug Ears] Engrave 1 out of 3 Orisons"
  },
  Event_6828_Desc = {
    Text = [[
You can only hear the frenzied keystrokes, assaulting like a storm, like meteors crashing to the ground, causing the entire piano to tremble.
The hammers creak and the pedals let out a mournful wail.
In the eerie melody, familiar tunes are dragged along, scraping against your eardrums.]]
  },
  Event_6828_Name = {
    Text = "Forbidden Tone"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6829_Desc = {
    Text = "\"Investigator William has provided emergency inventory delivery; tap your brooch three times after receipt for confirmation.\""
  },
  Event_6829_Name = {
    Text = "Reinforcement Hail"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Push Left Door] Engrave 1 out of 3 Orisons"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Push the Right Door] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6830_Desc = {
    Text = [[
Doors. Doors. Countless doors.
There seem to be more doors than when you and Ramona last inspected.
You stand in the hallway, ready to push open the next door.
Behind the door on the left, all is silent, quietly waiting for your arrival.
Behind the door on the right, muffled voices can be heard.]]
  },
  Event_6830_Name = {
    Text = "Endless Doors"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Read the Letter] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6831_Desc = {
    Text = [[
The suitcase trembles incessantly, as if some form of life is breaking through an eggshell, on the verge of emerging.
You uncontrollably open the suitcase, and the letters scatter like released butterflies.]]
  },
  Event_6831_Name = {
    Text = "Unwelcome Missive"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6832_Desc = {
    Text = "The insistent ringing makes your heart race. You pick up the receiver and place it on the table. The ringing stops abruptly, as if someone had grabbed it by the throat, leaving only an echo lingering in your mind."
  },
  Event_6832_Name = {Text = "Train Call"},
  Event_6833_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Check Film] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_6833_Desc = {
    Text = "In the corner of the studio lies an old camera, a few rolls of film, and scattered photos. They faithfully document the wax sculptor's work and aesthetics."
  },
  Event_6833_Name = {
    Text = "Verbatim Record"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continue Questioning] Increase Max HP by Arg1"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Catch the Shadow] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6834_Desc = {
    Text = [[
The shadow chants in golden dust:
"Those who know the truth...
With the key as their Authority, will guide the way."
An ancient saying.
Your intuition tells you it's close to the truth you seek.
And your intuition is always spot on.]]
  },
  Event_6834_Name = {
    Text = "Silver Key Bearer"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6835_Desc = {
    Text = "You openly express your agreement with the mad murmurs, and under the allure of that mad entity, you nearly end up on its dining table."
  },
  Event_6835_Name = {
    Text = "Aquatic Rite"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[Call the Crow] Receive 30 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_6836_Desc = {
    Text = [[
If you don't leave, neither will they.
A strange rope connects your spirits; it seems they have something to say to you.]]
  },
  Event_6836_Name = {
    Text = "Outcast Crow"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6837_Desc = {
    Text = [[
One, two, three...
On the face, on the fingers, swarms of butterflies shine like fireworks in the sky, their gem-like glow piercing through the darkness.
This typewriter has no practical use, but it is a master at creating beauty.]]
  },
  Event_6837_Name = {
    Text = "Inspiration Surge"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6838_Desc = {
    Text = "There are more important matters to tend to right now. You close the box, determined to ignore it, and the typewriter gradually falls silent."
  },
  Event_6838_Name = {
    Text = "Unbidden Warning"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Listen to the Moon] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Listen to the Dwarf Star] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Listen to the Meteor] Lose 25 Black Sigils"
  },
  Event_6839_Desc = {
    Text = "Fervent, bright, never-ending."
  },
  Event_6839_Name = {
    Text = "Astral Harmonies"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6840_Desc = {
    Text = [[
At the core of the glow is a drop of solidified Silver, yet your reason tells you it is not shining.
Your gaze follows the source of the light, only to be met with darkness and unknown traps...]]
  },
  Event_6840_Name = {Text = "Nightglow"},
  Event_6841_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6841_Desc = {
    Text = [[
North side, north exit!
Just as Ramona decides, there must be a way out to the north.]]
  },
  Event_6841_Name = {Text = "Northbound"},
  Event_6842_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6842_Desc = {
    Text = [[
Oh... the pristine silver, a jest your soul plays on you.
So, what is your next choice?]]
  },
  Event_6842_Name = {Text = "Showtime"},
  Event_6843_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6843_Desc = {
    Text = [[
You shake your head, brushing the voices aside.
A barely audible sigh offers some assistance.]]
  },
  Event_6843_Name = {Text = "Northbound"},
  Event_6844_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Receive 25 Black Sigils"
  },
  Event_6844_Desc = {
    Text = "Moonlight fades, devoured by the corridor, leaving only an ominous door in sight."
  },
  Event_6844_Name = {
    Text = "Silent Hall"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Receive 25 Black Sigils"
  },
  Event_6845_Desc = {
    Text = "Without full understanding, one should not delve deeper."
  },
  Event_6845_Name = {
    Text = "Silent Hall"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Receive 25 Black Sigils"
  },
  Event_6846_Desc = {
    Text = "The door on the left emitted a sinister chuckle, trembling slightly and shedding threads of malice."
  },
  Event_6846_Name = {
    Text = "Silent Hall"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Receive 25 Black Sigils"
  },
  Event_6847_Desc = {
    Text = "The door on the right is open, with blood tracing a predetermined path on the floor."
  },
  Event_6847_Name = {
    Text = "Silent Hall"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Leave] There's nothing left for you here."
  },
  Event_6848_Desc = {
    Text = "Who says you always have to charge ahead? Taking a step back might reveal a vast new world."
  },
  Event_6848_Name = {
    Text = "Silent Hall"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choose a card and reduce its Arithmetica Cost by 1"
  },
  Event_6849_Desc = {
    Text = [[
The restoration of the wax sculpture is ongoing.
You are not a professional wax sculptor, nor have you received formal aesthetic training.
Yet, you skillfully begin molding, shaping, and painting...
As if you were born with a chisel in your hand.
As if it was destined to be incomplete, waiting for your touch.]]
  },
  Event_6849_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choose a card and reduce its Arithmetica Cost by 1"
  },
  Event_6850_Desc = {
    Text = [[
Galatea, Galatea...
Following the call once more, you have found the unfinished wax sculpture.
She looked perfect, even unsettlingly so.
"Ugliness is a tear in perfection."
In the final moment, you decide to do something.]]
  },
  Event_6850_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Accept the Illusion] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Deny the Illusion] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6851_Desc = {
    Text = [[
Beneath the heavy, dark iron bridge, on a quiet riverbank overgrown with reeds, a glowing butterfly suddenly took flight.
The butterfly lightly landed on your palm. The dreadful howls ceased, replaced by the rumble of a train rolling over rusted rails, the crackling of burning coal, and the metallic screech of turning axles...]]
  },
  Event_6851_Name = {
    Text = "Ironway Mirage"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6852_Desc = {
    Text = "Yes, you're fleeing, being chased by some creature. Your survival instinct makes you run desperately until there's no way out. Wait, shouldn't it be... the Hellhounds that leave no escape?"
  },
  Event_6852_Name = {Text = "Run"},
  Event_6853_ChoiceDesc1 = {
    Text = "[This Isn't Real] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Falling, falling...] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6853_Desc = {
    Text = [[
The mirrors on the ground have intricate frames, frames within frames, frames within frames...
Alice leaps down and continues falling in the endless rabbit hole, seeing mirror after mirror, spirit after spirit trapped, unable to see herself.]]
  },
  Event_6853_Name = {
    Text = "Mirror Within"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6854_Desc = {
    Text = [[
You gaze through the snow-covered window at the snow mountain, many black ants chasing a single black ant...
Your train of thought is interrupted.]]
  },
  Event_6854_Name = {
    Text = "Volcanic Memory"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] 100% chance to get 25 Black Sigils"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Friendly Response] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_6855_Desc = {
    Text = [[
A cat of unknown origin sits among the D-Slime, its blurred body suggesting it belongs to the spirit dimension.
This indistinct projection gazes at Ramona with wise eyes, raises its white paw, and beckons her.]]
  },
  Event_6855_Name = {
    Text = "Wandering Dweller"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6856_Desc = {
    Text = [[
A lively group portrait.
The wax sculptures are dressed up and seated neatly, all wearing the same exaggerated smile.
They look as harmonious as what you might see in any asylum.

Dated: A.F. 305, @2 Rogers]]
  },
  Event_6856_Name = {
    Text = "Portrait Gallery"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6857_Desc = {
    Text = [[

You carefully pick up the fragments and inspect them closely. It is motionless again.
"Watch your clumsy hands, don't move around," Doll lightly taps the back of your head, "I can't whip up a second piece for you in a short time."]]
  },
  Event_6857_Name = {
    Text = "Unsettling Brooch"
  },
  Event_6858_ChoiceDesc1 = {Text = "[Use Key]"},
  Event_6858_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6858_Desc = {
    Text = "A door blocks your way. You've tried every method, yet it remains firmly in place."
  },
  Event_6858_Name = {
    Text = "Rusted Door"
  },
  Event_6858_Tips1 = {
    Text = "You need to find the \"Rusted Keys\"."
  },
  Event_6859_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6859_Desc = {
    Text = "You felt ashamed of your hastiness.\nA qualified Keeper must be rigorous; you should not rashly judge that they are not \"high-end goods.\"\nSo you decided to observe them carefully. Five minutes passed, ten minutes passed...\nAlright, now you can make a judgment—\nThey really are junk."
  },
  Event_6859_Name = {Text = "Bound Soul"},
  Event_6860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6860_Desc = {
    Text = [[
You and your companions lay down your weapons.
It's not out of kindness; you know their frail bodies cannot hold out for long.
It turns out you were right.]]
  },
  Event_6860_Name = {Text = "Draft"},
  Event_6861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6861_Desc = {
    Text = [[

"Come chase me!"
"Come on, you fool!"
"If you can, catch us!"
The children's voices were full of pride.
"Damn it! Stop right there!"
The adult's voice was out of breath.]]
  },
  Event_6861_Name = {
    Text = "Our Memories"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Enter] Wade through the mist to reach the other side."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6862_Desc = {
    Text = "Here is the person you were looking for. You have completed the task."
  },
  Event_6862_Name = {
    Text = "One-Way Path 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6863_Desc = {
    Text = [[
Ah! Just missed it! Wait, how did three dice roll a ten?
The dice lie quietly in front of you, appearing innocent and obedient.]]
  },
  Event_6863_Name = {
    Text = "Eternal Gamble"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_6864_Desc = {
    Text = [[
Damn! It's not six o'clock, but there's still some profit to be made.
So, what time is it exactly?]]
  },
  Event_6864_Name = {
    Text = "Eternal Gamble"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_6865_Desc = {
    Text = [[
Although I didn't guess correctly, I can accept it.
Sigh, what time did they vote for?]]
  },
  Event_6865_Name = {
    Text = "Eternal Gamble"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6866_Desc = {
    Text = "You lower your head, picking up fragments of plaster, piecing her back together bit by bit. Part of her body gradually takes shape under your hands."
  },
  Event_6866_Name = {
    Text = "Patchwork Remains"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6867_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  Event_6867_Name = {Text = "Rusted Key"},
  Event_6868_ChoiceDesc1 = {
    Text = "[Heads] 50% chance to acquire the Golden Relic \"(RelicConfig.Arg2)\", 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Tails] 50% chance to receive 75 Black Sigils, 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Let Them Choose] 50% chance to acquire the Cursed Relic \"(RelicConfig.Arg2)\", 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = [[
It's just a bet. You won't lose.
The coin, engraved with intricate patterns, is tossed high into the air, quickly descends, and warms up in your palm.]]
  },
  Event_6868_Name = {
    Text = "Notorious Gambler"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6869_Desc = {
    Text = [[
"Those who place their trust in fate's favor will also be overturned by it."
You choose to leave.]]
  },
  Event_6869_Name = {
    Text = "Notorious Gambler"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6870_Desc = {
    Text = [[
"Keeper."
Ramona's voice brings you back to your senses, but the sensation of falling does not dissipate.]]
  },
  Event_6870_Name = {
    Text = "Mirror Within"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6871_Desc = {
    Text = [[
It is said that serenades are songs born from love.
On summer nights, outside a lover's window, people play these tender tunes together.
Casual and superficial, they don't match Rogers' taste, yet they remain in his repertoire.
Perhaps only he knows why.]]
  },
  Event_6871_Name = {Text = "Bad Taste"},
  Event_6872_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6872_Desc = {
    Text = [[

You refuse to be tempted by their whispers.
You said, "Liar! You are trapped in the pitch-black eternal night. How can you traverse the universe?"
The eyes laughed. Countless laughs converged into a massive roar, causing your heart to tremble.
The eyes said, "By plundering other eyes. Each eye is a universe. When you possess a thousand eyes, you shall embark on a true journey through time and space."]]
  },
  Event_6872_Name = {Text = "Her Eyes"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Receive] Acquire 1 out of 3 Golden Relics"
  },
  Event_6873_Desc = {
    Text = [[
Oh yes, that loathsome reflection is you.
The surging malice merges with the black ooze at your feet, twisting and dancing together. If you don't mind, it would like to climb onto your shoulder as well.]]
  },
  Event_6873_Name = {
    Text = "Under-Mirror"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6874_Desc = {
    Text = "Before long, the bindings suddenly loosened, causing you to stumble.\nYou turned to look at the silent threads—\"Do not disturb the quicksand\", this saying may also apply in the Domain."
  },
  Event_6874_Name = {Text = "Entrenched"},
  Event_6875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6875_Desc = {
    Text = "The Fire of Gnosis ignites, burning away all restraints—\nAt least, that's what you believe."
  },
  Event_6875_Name = {Text = "Entrenched"},
  Event_6876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6876_Desc = {
    Text = "Break free with all your might. The threads tear your clothes, leaving fine cuts on your skin.\nThough the web exacted a toll, you feel relieved— you're free."
  },
  Event_6876_Name = {Text = "Entrenched"},
  Event_6877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6877_Desc = {
    Text = [[
The letter produced by the Dissolution excrescence often has most of its information erased.
You couldn't extract any valuable information from it, so you tore up the letter and scattered the pieces.]]
  },
  Event_6877_Name = {
    Text = "Butterfly Chapter"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6878_Desc = {
    Text = "Even if the words are deliberately erased, you can still clearly perceive the value of the letter."
  },
  Event_6878_Name = {
    Text = "Butterfly Chapter"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6879_Desc = {
    Text = [[
Better safe than sorry.
Ramona crouched, returned to the hallway, and sneaked into the next room.]]
  },
  Event_6879_Name = {
    Text = "Window's Reflection"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6880_Desc = {
    Text = [[
You let out a desperate shriek.
The flock of crows, seemingly drawn by your voice, quickly vanishes, leaving behind dark traces.]]
  },
  Event_6880_Name = {
    Text = "Song of Crows"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6881_Desc = {
    Text = [[
You curl up your body, trying to shrink into a tiny black dot.
Maybe they won't notice you.
After some time, you open your eyes.
You see the light.]]
  },
  Event_6881_Name = {
    Text = "Song of Crows"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6882_Desc = {
    Text = "The shadow slips gently through my fingers, leaving behind a trail of golden dust."
  },
  Event_6882_Name = {
    Text = "Silver Key Bearer"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6883_Desc = {
    Text = [[
You roughly tousle your hair as wild imaginings and delusions race through your mind, with black, slimy clumps hidden deep within.
What kind of gift will you receive if you dissect it?]]
  },
  Event_6883_Name = {
    Text = "Mind Agitation"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6884_Desc = {
    Text = "Colorful oil stains gradually fill your vision, plunging your emotions into chaotic revelry."
  },
  Event_6884_Name = {
    Text = "Mind Agitation"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Take It]"},
  Event_6885_Desc = {
    Text = "A near-mercury-like silver substance, refined from D-Slime, containing strong mental power, used to link more Awakeners in rituals A near-mercury-like silver substance, refined from D-Slime, containing strong mental power, used to link more Awakeners in rituals."
  },
  Event_6885_Name = {Text = "Silver"},
  Event_6886_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6886_Desc = {
    Text = [[
Laughter pours out of the box, and after the warm glow fades, you see a card with three stick figures: you, silver-haired Ramona, and blond-haired Ogier. Beside it, a line of text reads:
"Thank you all!"]]
  },
  Event_6886_Name = {
    Text = "Gift of Kindness"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6887_Desc = {
    Text = "Your body evaded the swarm of butterflies, but they did not lose their target. They slipped into your suitcase, greedily sucking the ink from your typewriter."
  },
  Event_6887_Name = {
    Text = "Delusion Surge"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Point Out the Error] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Receive 15 Black Sigils for each Awakener with 50 or more Aliemus."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_6888_Desc = {
    Text = "The wax sculpture boy sits at the piano, practicing.\nHis teacher—a wax sculpture as well—is guiding him nearby.\n133, 355, 244...\nWrong, every note is wrong."
  },
  Event_6888_Name = {
    Text = "Piano Lesson"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6889_Desc = {
    Text = [[
You can't resist the urge within.
Your fingers wander and play on the keyboard like lost children in a forest...
Gradually, butterflies emerge from the typewriter.
One, two, three...
On your face, on your fingers, swarms of butterflies sparkle like fireworks, glowing like gems in the dark.
This typewriter has no practical use, but it is a master at creating beauty.]]
  },
  Event_6889_Name = {
    Text = "Inspiration Surge"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6890_Desc = {
    Text = [[

You held the paper up to the dark red light, fearing to miss a detail.
This was a health report, and the examinee was Mason.
"Weight 40kg, blood oxygen level normal, Affinity 30%, Resonance value..."
You wanted to keep reading, but the writing gradually faded away.
Clean as if nothing had ever happened.]]
  },
  Event_6890_Name = {Text = "Typewriter"},
  Event_6891_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6891_Desc = {
    Text = "Yes, you're not fleeing; you're chasing a definite target—the \"Hellhound\" darting through the damp, narrow, snow-covered alleyways. You won't forget this, just as you won't forget the face of the person who pulled you from the ruins that day in Tunguska.... Who was it again?"
  },
  Event_6891_Name = {Text = "Run"},
  Event_6892_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6892_Desc = {
    Text = "In this space isolated from everything else, you can only rely on yourself."
  },
  Event_6892_Name = {
    Text = "Nightmare Walker"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6893_Desc = {
    Text = "Crisis and risk coexist. The moment you touch the iron lock, corrosive slime burns your palm. Hopefully, the relic behind the door is worth it."
  },
  Event_6893_Name = {
    Text = "Behind Iron Gates"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6894_Desc = {
    Text = [[
Roaming uncharted worlds recklessly, your fragile sanity has not yet deteriorated to the point of losing reason.
The horror of the unknown is something you deeply understand.]]
  },
  Event_6894_Name = {
    Text = "Nightmare Walker"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Loud Shout] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Embrace Silence] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surface] Receive 25 Black Sigils"
  },
  Event_6895_Desc = {
    Text = [[
You hear silence.
An amplified silence, like the sound of waves, fills the entire space.

You look up, like a tiny dot gazing at the stars.]]
  },
  Event_6895_Name = {
    Text = "Lethe's Flow"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6896_Desc = {
    Text = [[
You perk up your ears, searching for the source of the sound, trying to catch the troublemaker.
But it feels like a deliberate trick. Just when you think you've cornered them, you find yourself back where you started.
Frustrated, you kick a brick wall, dislodging a brick that reveals a sparkling secret hidden inside.]]
  },
  Event_6896_Name = {Text = "Lost Echo"},
  Event_6897_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6897_Desc = {
    Text = [[
It must be a playback issue, it has to be.
You skeptically rewind the needle, enduring the awful first half, but the familiar knocking sound never comes.
Behind you, in the emptiness, a small shadow on the ground quietly sneaks away.]]
  },
  Event_6897_Name = {Text = "Lost Echo"},
  Event_6898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6898_Desc = {
    Text = [[
There's no one around you. The secret of the tapping must be hidden in the mechanism inside the phonograph.
Confident in your judgment, you dismantle the old phonograph.
Apart from corroded metal parts and a thick stack of dust, you find nothing.
Only a faint chuckle escapes into the mist, as light as a dream.]]
  },
  Event_6898_Name = {Text = "Lost Echo"},
  Event_6899_ChoiceDesc1 = {
    Text = "[Fool's White Matter] Recover Arg1 HP"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Madman's Heart] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Refuse to Eat] Receive 25 Black Sigils"
  },
  Event_6899_Desc = {
    Text = [[
"The Fool's white matter is as delicious as a boiling fish soup, while the madman's heart is baked into a hot, bloody scone."
The shadow grinned wickedly, presenting you with a dish containing unknown ingredients.
You took a deep breath; the overwhelming aroma forcefully invaded your nostrils. Your utterly humiliated salivary glands surrendered first, and your stomach twisted in agony, emitting a groaning whimper of desire.]]
  },
  Event_6899_Name = {
    Text = "Flesh Banquet"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Touch Wind Chime] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Observe Wind Chime] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Do Nothing] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_6900_Desc = {
    Text = [[
Ding ding, ding ding...
This is a rusty wind chime, with clumsy notes meandering through the gaps.]]
  },
  Event_6900_Name = {
    Text = "Rusted Chime"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Wait and See] Try to Survive"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Swing Weapon] Attempt to Break Through"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Hold a Hand] Receive 25 Black Sigils"
  },
  Event_6901_Desc = {
    Text = "A black swamp suddenly forms beneath your feet, with countless hands emerging from it.\nThey display a variety of colors, textures, and materials—peacock blue, scaly, or even with eyes—appearing to traverse countless dimensions and spaces, attempting to drag the next unlucky soul into their family.\nYou decide to—"
  },
  Event_6901_Name = {
    Text = "Gloomslough"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Hold it] Duplicate 1 of 3 Command Cards"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Shake It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Do Nothing] Receive 25 Black Sigils"
  },
  Event_6902_Desc = {
    Text = [[
Ding ding, ding ding...
This is a rusty wind chime, with clumsy notes meandering through the gaps.]]
  },
  Event_6902_Name = {Text = "Tiny Chime"},
  Event_6903_ChoiceDesc1 = {
    Text = "[Counter Them] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop 1 out of 3 Symptoms."
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Follow Them] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Suggest New Idea] Receive 25 Black Sigils"
  },
  Event_6903_Desc = {
    Text = "\n\"Please keep your distance from us.\"\nA swarm of rats surrounded you, maintaining at least five feet of distance.\n\"We strive to multiply, we thrive; we are not picky eaters—thus we bring diseases, anxiety, and suffering to humanity.\"\n\"We should not get too close to humans; this is not a place for you.\"\nTo make the rats let down their guard, you decided—"
  },
  Event_6903_Name = {Text = "Plague"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Descend Further] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Pull Away] Receive 25 Black Sigils"
  },
  Event_6904_Desc = {
    Text = [[
"You" invites you deeper.
In the depths of the spiral, the past and future "you" send you "gifts" from different dimensions.]]
  },
  Event_6904_Name = {Text = "Abyss"},
  Event_6905_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Receive 40 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Ignore It] Receive 25 Black Sigils and leave."
  },
  Event_6905_Desc = {
    Text = "The solitary crow, with a hoarse voice, plucks its black feathers one by one.\nIt trembles in pain, crying out sharply, yet it cannot stop its increasingly frantic pace.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze flow from its eyes, witnessed only by you."
  },
  Event_6905_Name = {
    Text = "Molten Tear"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6906_Desc = {
    Text = [[
Red, passionate, vibrant, and striking. I happen to know such a beauty, and you will meet her in due time.
So, what is your next choice?]]
  },
  Event_6906_Name = {Text = "Showtime"},
  Event_6907_ChoiceDesc1 = {
    Text = "[Loud Cheer]"
  },
  Event_6907_ChoiceDesc2 = {Text = "[Drowsy]"},
  Event_6907_Desc = {
    Text = [[
You had a long dream.
In the dream, you were in the audience, watching a boy sing on stage.
"Old Charlie had a dearly loved tabby cat.
When she went missing, he searched everywhere."
.....
The hollow, dry voice repeated mechanically, endlessly.]]
  },
  Event_6907_Name = {Text = "Finale IV"},
  Event_6908_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_6908_Desc = {
    Text = [[
The remaining Gnosis in the Domain interlinks, entangling into an unstable force field.
Perhaps, you can untwine the Gnosis and pave a path forward for yourself.]]
  },
  Event_6908_Name = {
    Text = "Twined Path"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Leave] Rouse 2 Awakeners"
  },
  Event_6909_Desc = {
    Text = [[

You stood up and dashed toward the door.
"You lifted the covering cloth...
A secret, you discovered a secret..."
The roar converged into a cacophonous ocean, and the floor trembled violently with a dreadful resonance.
You didn't dare to look back and fled the scene as fast as you could.]]
  },
  Event_6909_Name = {Text = "Finale V"},
  Event_6910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6910_Desc = {
    Text = "You do not resist, but neither do you indulge."
  },
  Event_6910_Name = {
    Text = "Skull Ulcer"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6911_Desc = {
    Text = "You stopped resisting, allowing the filth to devour your body and spirit. After a long slumber, the silver light fell into your clasped hands."
  },
  Event_6911_Name = {
    Text = "Skull Ulcer"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6912_Desc = {
    Text = "The more you struggle, the deeper the filth sinks into your mind. Buried in the depths of a brain weighed down by sin lies an enigmatic gift."
  },
  Event_6912_Name = {
    Text = "Skull Ulcer"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6913_Desc = {
    Text = "As the net shatters, something flashes in your mind—seemingly the smiling faces of several children."
  },
  Event_6913_Name = {
    Text = "Vagus Network"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6914_Desc = {
    Text = "The cat nodded in satisfaction, then vanished into a shadow, leaving behind several black circular objects."
  },
  Event_6914_Name = {
    Text = "Wandering Dweller"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Read the Letter] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6915_Desc = {
    Text = "Fluttering letters fill the sky, like a silent urging."
  },
  Event_6915_Name = {
    Text = "Unwelcome Missive"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Enter] Wade through the mist to reach the other side."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6916_Desc = {
    Text = "A hidden tunnel appears on the road ahead, filled with black mist. Its destination is unknown."
  },
  Event_6916_Name = {Text = "Tunnel"},
  Event_6917_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6917_Desc = {
    Text = [[
You decide to end its suffering, reaching out to grasp its soft body, tightening... tightening...
It struggles desperately in your palm, finally bursting into a warm splash of liquid.]]
  },
  Event_6917_Name = {
    Text = "Molten Tear"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6918_Desc = {
    Text = "Don't worry, these are just fragments of others' memories in the Dimension. You have a shadow. But, is the person in the shadow really still you?"
  },
  Event_6918_Name = {
    Text = "Memory Shard: Beer"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6919_Desc = {
    Text = [[
You force the crow's beak away from plucking its feathers, but it relentlessly twists back, its strength making your bones creak.
Your face flushes red as you exert all your strength to restrain the crow's body, halting its frenzied self-mutilation.
Just as you breathe a sigh of relief, the crow's half-bald neck snaps back sharply, its body going limp and transforming into a pool of black sludge in your hands.]]
  },
  Event_6919_Name = {
    Text = "Molten Tear"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6920_Desc = {
    Text = [[
You coldly ignored those desperate rings.
Even if the next second you would be blasted back to the primitive world, even if you and your great mission were to be buried together.
A call that shouldn't be answered simply cannot be answered.
You understand this simple truth well.]]
  },
  Event_6920_Name = {
    Text = "Call Answered"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Lower Gaze] Receive 25 Black Sigils"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[I Must Find It] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6921_Desc = {
    Text = [[

You chased the shadow forward, suddenly stepping into a shallow pool. The colorless liquid soaked over your shoes, sending a chill through.
A voice spoke in the water, "You wouldn't want to find out."]]
  },
  Event_6921_Name = {
    Text = "That Which You Shouldn't Seek"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6922_Desc = {
    Text = "A safe choice."
  },
  Event_6922_Name = {
    Text = "Haystack's Leeward"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Disregard] Receive 25 Black Sigils and leave."
  },
  Event_6923_Desc = {
    Text = [[
How can there be crows in the asylum room?
But you clearly hear their cackling. An unseen force watches from the shadows, through hollow bird eyes. These black creatures twist their necks, perched on street lamps, glaring maliciously at you. Their overlapping heads seem to share one body submerged in D-Slime.]]
  },
  Event_6923_Name = {
    Text = "Lantern-Crow"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6924_Desc = {
    Text = "Do not fear the filth; you gain more than you lose from it."
  },
  Event_6924_Name = {
    Text = "Haystack's Leeward"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6925_Desc = {
    Text = "The storm of Gnosis surrounds Tulu. You exchange a glance with him and step into the darkness one after another."
  },
  Event_6925_Name = {
    Text = "Emissary's Promise"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Enter] Wade through the mist to reach the other side."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6926_Desc = {
    Text = [[
You fall into darkness.
At the edge of your vision, a sliver of light shines through a gap resembling a keyhole.
The Silver Key emits a faint glow, guiding you into the Secret Passage.]]
  },
  Event_6926_Name = {
    Text = "One-Way Passage"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infect \"(Skill.Arg1)\", acquire Relic: \"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Choose 1 out of 3 Command Cards to gain the Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Event 203 (Under Development), Not Final Effect"
  },
  Event_6927_Name = {
    Text = "Event 203 (In Development)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Patch Her Up] Destroy a Command Card, and acquire the Relic \"(RelicConfig.Arg1)\"."
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Touch] Destroy a Strike or Defense card, and engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Disgust] Receive 25 Black Sigils"
  },
  Event_6928_Desc = {
    Text = [[
"Do you like my remains? If possible, could you help me piece my body together?"
The lips of the half-body plaster statue moved, and a delicate voice, as soft as silk, emerged from her lips that should have been hard and cold.]]
  },
  Event_6928_Name = {
    Text = "Patchwork Remains"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Discard Envelope] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Tucked in the Chest] Acquire the Relic \"(RelicConfig.Arg2)\", but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6929_Desc = {
    Text = "This is a distress letter. The writer tries to stay calm, but the occasional shaky handwriting reveals his deep-rooted fear.\n\"This is completely beyond my expectations. If someone told me I was deeply cursed, I would swear to believe it.\"\n\"Some say I'm mad. They're half right. I'm teetering on the edge of insanity.\"\n\"But I truly saw it! It's mutating and vanishing, the proliferating black goo trying to crawl all over me!\"\n\"I ran! Ran as fast as I could, but the gaze never left me. I have a feeling it will find me! That loathsome black sludge will invade my skull again. Whoever receives this letter, please, save me—\""
  },
  Event_6929_Name = {
    Text = "Distress Letter"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6930_Desc = {
    Text = [[
"Calm down," Ramona taps your head, "just fragments of the past. I don't know who left them in this dimensional passage."
Indeed, there's a nostalgic scent.]]
  },
  Event_6930_Name = {
    Text = "Urgent Missive"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_Desc = {
    Text = "Event 205 (Under Development), Not Final Effect"
  },
  Event_6931_Name = {
    Text = "Event 205 (In Development)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_6932_Desc = {
    Text = "Event 204 (Under Development), Not Final Effect"
  },
  Event_6932_Name = {
    Text = "Event 204 (In Development)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6933_Desc = {
    Text = "The solitary moon hangs high in the sky, yet you can clearly hear its prayer—a strange chant resembling the whispers of corruption.\nThe prayer ceases, and as you are about to leave, a white phantom appears behind you.\n\"Those who trespass against fate and prayer, both blessings and retribution will come as promised.\""
  },
  Event_6933_Name = {
    Text = "Moon Silver Shard"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6934_Desc = {
    Text = "A crisp shattering sound comes from behind. You pause for a moment, lost in thought, and then turn away."
  },
  Event_6934_Name = {
    Text = "Moon Silver Shard"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6935_Desc = {
    Text = [[
A handful of moonlight, gathered in the palm, was sprinkled onto the stone tablet.
Someone was buried beneath thick mud, and the onlookers claimed it was a natural death, asserting that they would rest peacefully underground.
However, the buried mud churned, and amidst the screams, a limp moon crawled out.]]
  },
  Event_6935_Name = {
    Text = "Moon Silver Shard"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6936_Desc = {
    Text = [[
Merely a living being struggling to survive, seeking a piece of driftwood to rest upon...
You sigh, allowing the black ooze to flow from the butterfly's tail.]]
  },
  Event_6936_Name = {
    Text = "That Which Should Not Be"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6937_Desc = {
    Text = "This is a premeditated trap, and you are well aware of its danger.\nCompared to jewelry, you yourself— are clearly the more precious gem."
  },
  Event_6937_Name = {
    Text = "Overturning Talons"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6938_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_6938_Name = {
    Text = "Extraction Point"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6939_Desc = {
    Text = [[
You accepted the request but ran into a minor issue.
"What does that wax sculpture look like?"
"It's a bust of me, of course it looks just like me."
"But..."
"Your face has long since completely rotted away. Don't you know?"]]
  },
  Event_6939_Name = {
    Text = "My Other Half"
  },
  Event_6940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6940_Desc = {
    Text = "You tightly hold your companion's hand. Ramona glances at you with a puzzled look but ultimately accepts your rudeness."
  },
  Event_6940_Name = {
    Text = "Dream Prayer"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Ask Who It Is] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Stare Back] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6941_Desc = {
    Text = [[
A strong feeling of being watched makes you stop in your tracks.
"Who is it?" you look around in the dense fog, "Jenkin, is that you?"
The mist is thick, and faint screams of the Dissoluted can be heard from deep within the courtyard. You come up empty-handed, and as you turn around, you nearly bump into an eye hanging in the air.]]
  },
  Event_6941_Name = {
    Text = "Blind Stare"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Avoid Coin] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Touch the Coin] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_6942_Desc = {
    Text = "You found an ancient coin embedded in black mud.\nOne side features intricate carvings of blue and red veins, while the other side bears a finely detailed relief of a pure white portrait—a pristine duchess smiles faintly, her gaze meeting your pale eyes for a brief moment before they begin to dart around restlessly."
  },
  Event_6942_Name = {
    Text = "Two-Faced Relic"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Turn Around] Receive 25 Black Sigils"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Keep Going] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6943_Desc = {
    Text = "Here it comes again, that strange footstep.\nIt follows you from the studio to the curator's room, then from the curator's room to the basement.\nYou know it's a cautious one.\nIt carefully maintains the distance between you—neither too far nor close enough to offend.\nStill, you can't shake off this deep sense of unease."
  },
  Event_6943_Name = {Text = "Footsteps"},
  Event_6944_ChoiceDesc1 = {
    Text = "[Observe It] 100% chance to get 25 Black Sigils"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Pet It] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_6944_Desc = {
    Text = "A black cat suddenly sprang out from a side alley, affectionately entwining around your feet. Its eerie green vertical pupils flashed with a chilling light, as if saying, \"Don't chase me, come play with me for a while.\"\n\"You have already seen Him. He is right beside you—those polluted by madness, the frenzied shadows... Do not gaze directly at His outline.\""
  },
  Event_6944_Name = {
    Text = "Nightshade Sprite"
  },
  Event_6945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6945_Desc = {
    Text = "The Awakeners await your command; you have no time for anything else."
  },
  Event_6945_Name = {
    Text = "From Perspective"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Check the Film] Acquire the Golden Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Check Camera] Receive 50 Black Sigils"
  },
  Event_6946_Desc = {
    Text = "Like pulling out a piece of innards, the film inside the camera was torn to shreds, discarded gutted and ignored.\nA blinding white flash, the abandoned camera at the street corner tilted, its shutter clicked by an unseen force.\n\"Click—\"\nYour shocked, stunned expression was faithfully captured on the film"
  },
  Event_6946_Name = {
    Text = "Record Innocence"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6947_Desc = {
    Text = "It's just the sound of the wind shaking the iron locks, nothing to worry about. Just ignore it."
  },
  Event_6947_Name = {
    Text = "Behind Iron Gates"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Choose] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Choose] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Choose] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6948_Desc = {
    Text = "\"I\" am one of a kind, irreplaceable across millions of universes."
  },
  Event_6948_Name = {
    Text = "Soul Resonance"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Claim] Choose a Silver Relic"
  },
  Event_6949_Desc = {
    Text = [[

That might be "me".
Through the shadows of time, across the dimensional barriers, through a cracked seam, I came face to face with "myself".]]
  },
  Event_6949_Name = {
    Text = "Soul Resonance"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Swallow Doubt] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_6950_Desc = {
    Text = [[
For the girl, it was also an unspeakable sorrow.
You swallow your questions as she touches her heart and begins to recount a 25-year-long dream, as well as her feelings of isolation after waking up.]]
  },
  Event_6950_Name = {
    Text = "Shackled Life"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6951_Desc = {
    Text = "You throw the paper and wood chips into the flames. The fire greedily devours them and lets out a satisfied burp. It is ready for destruction, but not before granting you a blessing."
  },
  Event_6951_Name = {Text = "Pale Fire"},
  Event_6952_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6952_Desc = {
    Text = "You mercilessly snuffed out the last ember of hatred, and the resentment and unwillingness lingering around seemed to ease."
  },
  Event_6952_Name = {Text = "Pale Fire"},
  Event_6953_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive Arg1 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_6953_Desc = {
    Text = "You try to catch the crow, but it merely flies from one end of the bedroom to the other, continuing its eerie cawing. Where it lands, black goo drips, forming dark marks."
  },
  Event_6953_Name = {
    Text = "Lantern-Crow"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_6954_Desc = {
    Text = [[

"You have a knack for capturing the essence," the man says with a radiant smile. "That is the most delectable food in the world, worthy of meticulous preparation and appreciation by every glutton."
"It's a pity, but I can't let you try it this time. As compensation, I happen to have some other delicacies with me, which I'll give to you."
With that, the man tosses a piece of tender red meat. The soft flesh lands on the bridge, its sticky appendages writhing grotesquely. When you look up again, the man's figure has vanished behind the intricate steel frames, leaving no trace.]]
  },
  Event_6954_Name = {
    Text = "Uncanny Companion VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6955_Desc = {
    Text = "Unraveling stacks, step by step, is your forte.\nA flash of inspiration clears your mind, allowing you to see the reality before you—\nNo matter who is pulling the strings, escape and survive."
  },
  Event_6955_Name = {
    Text = "Inspiration Surge"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6956_Desc = {
    Text = "A butterfly shatters in your palm, like a glass ceiling suddenly shattered, fragments falling, falling, falling to the ground—"
  },
  Event_6956_Name = {
    Text = "Ironway Mirage"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6957_Desc = {
    Text = "Seeing Ramona unwilling to approach, the cat shook its head and dissipated into a shadow."
  },
  Event_6957_Name = {
    Text = "Wandering Dweller"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Make a promise] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Refuse] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6958_Desc = {
    Text = [[
"That was truly an unforgettable memory.
My head and limbs were forcefully pressed into the plaster.
Suffocation and near-death phantasms enveloped me deeply, then pulled me up and threw me onto a dark shore.
I looked at it, feeling a part of me had been taken away as well.
That lost half of my Soul has since resided in that small, initial Wax sculpture.
So... can you help me find my other half?"]]
  },
  Event_6958_Name = {
    Text = "My Other Half"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_6959_Desc = {
    Text = [[
You are a spectator of memories, helplessly watching the girl fall into the Dark Sea.
The current lifts her skirt upward, but she sinks, like an unopened flower.]]
  },
  Event_6959_Name = {
    Text = "Drowned Sea"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6960_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_6960_Name = {
    Text = "Extraction Point"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6961_Desc = {
    Text = "Don't fall for the enemy's temptation; it might be a trap."
  },
  Event_6961_Name = {
    Text = "Cursed Crow"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Help Him]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observe Coldly]"
  },
  Event_6962_Desc = {
    Text = [[
The boy stood on the stage, pale light shining on his face.
"Ded-dedicated to..."
The boy's face turned red. He opened his mouth but couldn't utter a sound.
His gaping mouth grew wider and wider...]]
  },
  Event_6962_Name = {Text = "Finale III"},
  Event_6963_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6963_Desc = {
    Text = "\"Damn it, damn it!\" As if you triggered a switch, the black cat suddenly turns vicious, biting at your arm. Luckily, you dodge just in time, only losing a piece of your sleeve. The black cat darts to the street corner and disappears into the sewer."
  },
  Event_6963_Name = {
    Text = "Nightshade Sprite"
  },
  Event_6964_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6964_Desc = {
    Text = [[
Enveloped by the surging thoughts in your mind, you push open the door and step onto a path of no return.
Is the blazing white light outside the door salvation or destruction?]]
  },
  Event_6964_Name = {
    Text = "Beyond the Gate"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6965_Desc = {
    Text = "You cautiously step forward to inspect, and the slime covering the table suddenly splits open, revealing what lies beneath."
  },
  Event_6965_Name = {
    Text = "Beyond the Gate"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6966_Desc = {
    Text = [[
Swallow your doubts, focus on the enemy.
Let the butterflies linger inside your body, even if their wings tear your organs apart.]]
  },
  Event_6966_Name = {
    Text = "The Butterfly Effect"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_6967_Desc = {
    Text = "The cat nodded in satisfaction, then vanished into a shadow, leaving behind several black circular objects."
  },
  Event_6967_Name = {
    Text = "Wandering Dweller"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6968_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_6968_Name = {
    Text = "Extraction Point"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Leave] Acquire a random Golden Relic, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6969_Desc = {
    Text = "Seeing you still hesitating, Koum pounced on the dirt pile, quickly digging with his front paws and pushed something in front of you."
  },
  Event_6969_Name = {
    Text = "Deep-Buried"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6970_Desc = {
    Text = "The top of the paper is neatly printed with \"Mérimée\", there has never been any Mason.\nExcessive suspicion is not a good sign, Keeper."
  },
  Event_6970_Name = {Text = "Typewriter"},
  Event_6971_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6971_Desc = {
    Text = "Buried in the mound are the countless heinous crimes of Sculptors' Association."
  },
  Event_6971_Name = {
    Text = "Deep-Buried"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6972_Desc = {
    Text = "Birds have their own rules. They do not act according to your will, nor do you have the right to interfere with the laws of nature."
  },
  Event_6972_Name = {
    Text = "Outcast Crow"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6973_Desc = {
    Text = [[
Why? Why did it sink?
That day, there was no thunderstorm, no tempest. The night sky was clear, not a single star in sight, with a full moon hanging low over the horizon, like a cold sun.]]
  },
  Event_6973_Name = {
    Text = "Drowned Sea"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6974_Desc = {
    Text = [[
"Conductor! We are under attack!...Bzzz..."
It seems to be a call from the driver. You were about to hang up.
"Repeat, this is Mythag Field Team 4. We were escorting rescued hostages on the northbound night express when we were... Ah!"
The voice on the phone turns into a hoarse whisper, mixed with eerie screams.
"The rite is complete. Lost lamb, may this holy bath cleanse your soul..."]]
  },
  Event_6974_Name = {Text = "Train Call"},
  Event_6975_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6975_Desc = {
    Text = [[
Collecting Silvers is also one of the tasks of the Keepers.
The souls drifting within the pure white crystals will, in the future, return to the world with a brand-new appearance.]]
  },
  Event_6975_Name = {Text = "Bound Soul"},
  Event_6976_ChoiceDesc1 = {
    Text = "[Descend Further] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Pull Away] Receive 25 Black Sigils"
  },
  Event_6976_Desc = {
    Text = [[
"You" invites you deeper.
In the depths of the spiral, the past and future "you" send you "gifts" from different dimensions.]]
  },
  Event_6976_Name = {Text = "Abyss"},
  Event_6977_ChoiceDesc1 = {
    Text = "[Lean Out] Acquire the Golden Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Give Up Checking] Receive 50 Black Sigils"
  },
  Event_6977_Desc = {
    Text = "There seems to be a roll of film stuck under the operating table."
  },
  Event_6977_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6978_Desc = {
    Text = [[
Ignore distractions and focus on the present.
You have more important things to do.]]
  },
  Event_6978_Name = {
    Text = "My Other Half"
  },
  Event_6979_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6979_Desc = {
    Text = [[
A lost relic, a priceless heirloom, a wish-granting device...
Perhaps only treasures can be so alluring.]]
  },
  Event_6979_Name = {
    Text = "Enigma Input"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6980_Desc = {
    Text = "\"You are Lily's 'mother,' yet you only use her as a tool for research and battle,\" you respond. \"A child may obey their mother, but you should not be Lily's 'mother.'\""
  },
  Event_6980_Name = {Text = "Her Choice"},
  Event_69813_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69813_Desc = {
    Text = "The Silver Key glimmers; the arms seem intimidated by some force, retreating into the pool and then disappearing."
  },
  Event_69813_Name = {
    Text = "Pool of Gore"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69814_Desc = {
    Text = "The deeper you sink, the more you hear the chaotic whispers of the Supreme Will in your mind. You close your eyes, invoking the Authority within you.\nSuddenly, all sounds and strange sensations vanish. You stand behind the Door, the blood-red Tentacles beside you having vanished without a trace, as if they had never existed.\nYou feel invigorated. You understand the price you paid, but it is insignificant— you will face that supreme existence in a stronger form."
  },
  Event_69814_Name = {
    Text = "Pool of Gore"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69815_Desc = {
    Text = "The Awakener shaped by your memory acted without a moment's hesitation, pulling you out of the blood-soaked pool. Your torn arm was connected as muddy water splashed, countless indiscernible creatures wriggling in the water. The original Relic and Destroyer were desperately yearning to devour."
  },
  Event_69815_Name = {
    Text = "Pool of Gore"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Summon Awakeners] All Awakeners lose 100 Aliemus. Destroy a Symptom Card."
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Drink the Blood] Increase Max HP by Arg1, but develop \"(Skill.Arg2)\" twice."
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Lose all Keyflare."
  },
  Event_69816_Desc = {
    Text = [[
The authority of life manifests in the form of death in the eyes of the primordial. As you set foot on this shadowy domain, the stinking pool of blood instantly reveals its true form.
The crimson-black blood extends countless arms, clinging to your ankles and pulling upward ceaselessly, intending to drag you into the unfathomable Abyss.]]
  },
  Event_69816_Name = {
    Text = "Pool of Gore"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Pick Up Keys]"
  },
  Event_6981_Desc = {
    Text = "A string of rusty keys. Can be used to unlock doors."
  },
  Event_6981_Name = {
    Text = "Rusted Keys"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Leave] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_6982_Desc = {
    Text = "Guided by shanty and Celeste, you gaze into the pitch-black depths of the cabin—could your chance of survival lie within that boundless darkness?"
  },
  Event_6982_Name = {Text = "Shanty"},
  Event_6983_ChoiceDesc1 = {
    Text = "[Leave Together] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Refuse to Leave] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_6983_Desc = {
    Text = [[
Is it a phantasm? You see crows circling above, humming a familiar tune:
"Then let's leave together, you and I,
As the night falls,
Like a dying drunk collapsing on the street."]]
  },
  Event_6983_Name = {
    Text = "Crows' Chorus"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6984_Desc = {
    Text = "The power of retrospection cannot find another Junction for you in the short term, but at least you feel some Temporary relief."
  },
  Event_6984_Name = {
    Text = "Anomalous Contact"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Gaze into the Abyss]"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Pull Away] Receive 25 Black Sigils"
  },
  Event_6985_Desc = {
    Text = [[
The sea surface has vanished from the porthole.
The glass reflects your pale face, while in your pupil, "you" gaze back at the porthole.
Reality and Domain overlap and intertwine, ultimately distorting into an intricate spiral.]]
  },
  Event_6985_Name = {Text = "Abyss"},
  Event_6986_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6986_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_6986_Name = {Text = "Junction"},
  Event_6987_ChoiceDesc1 = {Text = "[Agree]"},
  Event_6987_ChoiceDesc2 = {Text = "[Disagree]"},
  Event_6987_ChoiceDesc3 = {
    Text = "[No Comment]"
  },
  Event_6987_Desc = {
    Text = [[
"Long time no see, friends." After escaping the battle with the Lightbearer Devotees and catching your breath, you suddenly notice the long-haired man reappearing by the road, smiling as if the fight never happened.
"Compared to last time, the Cerberus scent on you is much stronger. You must have traveled far during this time, right?"
]]
  },
  Event_6987_Name = {
    Text = "Uncanny Companion V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Ask for Directions] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Leave It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6988_Desc = {
    Text = "The shadow stands under the tall streetlight.\n\"Can I borrow a light, sir?\"\nYou don't have the habit of @2, but you don't mind using a little bit of \"magic\".\nWith your help, the shadow will ignite the @2 and plunge it deep into that unfathomable black vortex.\nIn no time, you see white smoke billowing out.\n\"Ah—\"\nThe shadow lets out a pleased sigh."
  },
  Event_6988_Name = {
    Text = "Lamplight Silhouette"
  },
  Event_6989_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_6989_Desc = {
    Text = [[
In the chessboard, what you see is not real.

What blocks your path may not be a wall, but your waning curiosity.]]
  },
  Event_6989_Name = {
    Text = "Phantom Space"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6990_Desc = {
    Text = "\"I'm in so much pain... Sister Sasha...\"\nYou glance at Sarah. She is—nervously—shielding two of the children, pretending not to hear anything.\nThe voice gradually fades away."
  },
  Event_6990_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_6991_Desc = {
    Text = [[
You stand up and clap for the boy.
Seemingly feeling your encouragement, the boy puffs out his small chest.
Black blood keeps flowing from his mouth, yet it can no longer stop his singing.]]
  },
  Event_6991_Name = {Text = "Finale IV"},
  Event_6992_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6992_Desc = {
    Text = "A portion of the sorrow is evaporating, yet tears continue to flow endlessly toward the mystical past."
  },
  Event_6992_Name = {
    Text = "Styx's Lament"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Choke the Singer] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Stumbling Dancer's Steps] Acquire the Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\", but develop \"(Skill.Arg1)\" twice."
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Take a Detour] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_6993_Desc = {
    Text = "You are blocked by three viscous figures.\nOne figure sings in a hoarse voice with eerie lyrics. You cover your ears and bypass it.\nAnother figure dances stiffly with hesitant steps. You close your eyes and evade it.\nThe last figure recites fragmented poetry with disjointed sentences. Unable to bear it any longer, you—"
  },
  Event_6993_Name = {
    Text = "Narrowpath Brute"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6994_Desc = {
    Text = "A part of the rage is boiling, but the tears keep flowing toward an unknown past."
  },
  Event_6994_Name = {
    Text = "Styx's Lament"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignore It] Acquire a Relic, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Turn Away] Rouse a random Awakener"
  },
  Event_6995_Desc = {
    Text = [[
Cruel fate crawls beneath the traveler's feet. The path is as clear as a mirror, with a faint cracking sound behind.
Who crushed the fate underfoot? Is it illusion, a trap, or merely murmurs, deceit...
Before your eyes, a slowly creeping crack appears.
<Italic:As if it will sink for the awakening Gnosis.>]]
  },
  Event_6995_Name = {
    Text = "Crawling Fissure"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Initiate Trial] Develop \"(Skill.Arg1)\"; Win a Golden Relic if victorious, or 50 Black Sigils upon failure."
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_6996_Desc = {
    Text = [[
You've caught a glimpse of some secrets from the mirror-like black sludge beneath your feet.
Its reflection is hazy, enveloped in an unyielding dark mist. It feels strangely familiar, yet you can't quite make out what it is.]]
  },
  Event_6996_Name = {
    Text = "Under-Mirror"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] 50% chance to receive 125 Black Sigils, 50% chance to develop \"(Skill.Arg2)\""
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Feed] 75% chance to receive 100 Black Sigils, 25% chance to develop \"(Skill.Arg2)\""
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Run Away] Receive 50 Black Sigils"
  },
  Event_6997_Desc = {
    Text = "You accidentally entered the black cat's territory.\nCountless eyes opened in the darkness, filled with curiosity, scrutiny, and alertness... but no kindness.\nEmerald green, amber yellow, peacock blue...\nYou felt as if you were immersed in a sea of sparkling gems.\nTo escape, you—"
  },
  Event_6997_Name = {
    Text = "City of Cats"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[About Daffodil] Engrave the Orisons \"(EnchantConfig.Arg1)\" and \"(EnchantConfig.Arg2)\" on 2 random Command Cards."
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[About Hellhound] Acquire the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[About Lily] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_6998_Desc = {
    Text = "\"It's Daffodil's hint time.\""
  },
  Event_6998_Name = {Text = "Hint Time"},
  Event_6999_ChoiceDesc1 = {
    Text = "[Let Pointer] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Hold Pointer] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_6999_Desc = {
    Text = "Crack, crunch, crack—\nThe hands of fate tick forward inch by inch, the cold clicking of gears moving relentlessly toward the direction you dread."
  },
  Event_6999_Name = {
    Text = "Beyond the Needle"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Turn a Deaf Ear] Destroy 1 of 3 Command Cards, and receive 75 Black Sigils."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Carefully Inspect] Duplicate 1 of 3 Command Cards, and receive 25 Black Sigils."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Turn and Leave] Receive 50 Black Sigils"
  },
  Event_7000_Desc = {
    Text = [[
Cruel fate creeps beneath the traveler's feet, the path gleams like a mirror, with faint cracking sounds behind.
Who shattered the fate underfoot? Is it delusion, a trap, or merely murmurs and deceit...
Before your eyes, a slowly creeping crack appears.]]
  },
  Event_7000_Name = {
    Text = "Crawling Fissure"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Call the Crow] Receive 25 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7001_Desc = {
    Text = "The claw rips through the cloak, sinking deep into the shoulder."
  },
  Event_7001_Name = {
    Text = "Outcast Crow"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7002_Desc = {
    Text = [[
Fear sometimes does not stem from something tangible.
"Hellhound" leaves behind red droplets wherever it goes, reflecting your silhouette.]]
  },
  Event_7002_Name = {
    Text = "Formless Reflection"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7003_Desc = {
    Text = [[
With a faint buzz, you hear the woman's whisper.
Through tears, she continuously recounts her story.
An hour passes, then a day...until you've long forgotten why she was sad.
Finally, she hangs up cheerfully and promises to send you a gift.
You accept it. After all, gifts are always pleasant.]]
  },
  Event_7003_Name = {
    Text = "Call Answered"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7004_Desc = {
    Text = [[
Under the puzzled gazes of your companions, you lower your head, drop to one knee, and place your right fist on your forehead.
Perfect, this will completely cover your face.]]
  },
  Event_7004_Name = {
    Text = "Perfect Disguise"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7005_Desc = {
    Text = [[

"You have draped the veil over me."
The wax sculpture smiles serenely at you.
"I offer you the truth as a reward for your hard work."
Her belly continuously oozes black liquid, wrapping you tightly.
The world is pitch black, yet immensely warm.
You curl up and yawn, entering dreamland for the @1st time...]]
  },
  Event_7005_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_7006_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7006_Desc = {
    Text = "You find nothing in the Mist."
  },
  Event_7006_Name = {Text = "Chaos Mist"},
  Event_7007_ChoiceDesc1 = {
    Text = "[Answer the Phone] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignore Bell] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7007_Desc = {
    Text = [[
"Ding ding ding..."
A piercing phone ring came from the corner, urgent and noisy, each ring louder than the last, almost giving you the illusion that if you didn't answer, it would immediately go crazy and explode, thereby destroying the world."]]
  },
  Event_7007_Name = {
    Text = "Call Answered"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Approach Phantasm] Acquire 1 out of 3 Silver Relics"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Break Phantasm] Acquire the Silver Relics \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg3)\" twice."
  },
  Event_7008_Desc = {
    Text = "Is it a mirage in the Domain? Or another inescapable Memory?\nYou rub your eyes. A phantasm approaches—is it the bustling market, the Wax Museum lost to Dissolution, the snowy village asylum, or the blurred Yakutsk?"
  },
  Event_7008_Name = {Text = "Mirage"},
  Event_7009_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7009_Desc = {
    Text = "As if scalded by boiling water, you instinctively cover your ears, blocking out the malicious music."
  },
  Event_7009_Name = {
    Text = "Forbidden Tone"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7010_Desc = {
    Text = "A bright major chord dispels the tension and fear. You are passionate, blossoming, and exuberant. You stride ahead, leaving Ramona far behind—\"Keeper?! Don't walk so fast!\""
  },
  Event_7010_Name = {
    Text = "Nameless Echo"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7011_Desc = {
    Text = [[

"Stop right there!!! Even the dissolving monster that crawls on its belly knows its own limbs better than you!"
Let go of the audience...
You pray this in your heart]]
  },
  Event_7011_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7012_ChoiceDesc1 = {Text = "[Withdraw]"},
  Event_7012_Desc = {
    Text = [[
This is merely a Domain.
What you wish to protect and seek to escape from is a unique reality.]]
  },
  Event_7012_Name = {Text = "Abyss"},
  Event_7013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7013_Desc = {
    Text = [[

"You are the most detestable."
You tear the manuscript into fragments, scattering them into the wind, breaking apart into several clusters of flying petals.
The poet looks up at the characters swirling in the wind, a look of obsession curling at the corners of his mouth.
"Beautiful..."]]
  },
  Event_7013_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7014_Desc = {
    Text = "\nYou tore the poster down and found hastily recorded expenses for the wax museum on the back.\nThe handwriting's owner obviously had no patience or talent for arithmetic, and these accounts cannot be smoothed over no matter what.\nYou glanced through it briefly, and the largest expense appeared to be \"Wax Sculpture Maintenance Cleaning\".\nEmployee expenses were pitifully low, with the most recent expenditure being 12 horsehair whips at about 20 Fang each.\nThere was also a special expense— \"Their Food\".\nWho are \"they\"?"
  },
  Event_7014_Name = {
    Text = "Darkened Mirth"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7015_Desc = {
    Text = [[
"Cunning... and a correct answer."
The voice sounded intrigued by the response, as a silver object emerged from the water.
"Remember, everything comes at a price."]]
  },
  Event_7015_Name = {
    Text = "Voices from Beyond"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Catch the Second Butterfly] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7016_Desc = {
    Text = [[
Are they residents of the spirit dimension? Or life born from dissolution?
With questions in mind, you walk into a storm of butterflies.]]
  },
  Event_7016_Name = {
    Text = "Gnosis Tempest"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Observe the Third Butterfly] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7017_Desc = {
    Text = "The pain in your fingers becomes unbearable, and you quickly let go."
  },
  Event_7017_Name = {
    Text = "Gnosis Tempest"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7018_Desc = {
    Text = [[
"Do you humans have no other answers?"
The owner of the voice let out an impatient growl, shaking the entire space.
"Greedy and ignorant... This is why I am tired of you."]]
  },
  Event_7018_Name = {
    Text = "Voices from Beyond"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7019_Desc = {
    Text = "\"Don't worry, I just gave the greedy guest a bit of punishment. Can't help it—I don't like beer~\""
  },
  Event_7019_Name = {
    Text = "Memory Shard: Beer"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7020_Desc = {
    Text = "\"Stop singing—\"\nYou warn the tone-deaf singer, refusing to let them torture your ears any further."
  },
  Event_7020_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Leave] Rouse 2 Awakeners"
  },
  Event_7021_Desc = {
    Text = [[
You turn away, only to find yourself lost in the long corridor.
The never-ending hallway drains your patience completely, until you notice a small, worn-out stage.
You blink, and the stage vanishes.]]
  },
  Event_7021_Name = {Text = "Finale II"},
  Event_7022_ChoiceDesc1 = {
    Text = "[Raise the Goblet] Obtain \"Honey Mead\""
  },
  Event_7022_Desc = {
    Text = "A cup of clear golden liquid, shimmering like the golden waves of late autumn wheat, exuding a sweet, honey-like aroma. What are its ingredients? Who placed it here? Why is it left unattended?\nBefore these questions are answered, a mysterious thought creeps into your mind: You must drink it now, immediately.\nAt this moment, you suddenly transform into a moth bewitched by flame, a bug ensnared by a Nepenthes, uncontrollably reaching for that cup of sweet wine—"
  },
  Event_7022_Name = {Text = "Honey Mead"},
  Event_7023_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7023_Desc = {
    Text = "You tried to inspect this door. As you touched it, the door vanished, and you heard something opening in the distance."
  },
  Event_7023_Name = {
    Text = "Strange Door"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[No Action]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Wipe Palm Print]"
  },
  Event_7024_Desc = {
    Text = "Francis's office is cold and immaculate, reflecting her meticulous nature.\nIn a corner on a box, you find a 5-inch square dust print.\nThe print is peculiar—a beast's paw outline with a small human girl's handprint embedded in the center. It appears as though the girl's handprint was left first, followed by the beast's massive paw covering it.\nYou might imagine a tender scene, such as a tamed beast gently placing its paw over the girl's hand in a comforting gesture.\nBut you know the truth—it is the mark left by a cruelly experimented hybrid monster."
  },
  Event_7024_Name = {
    Text = "Colossus' Print"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7025_Desc = {
    Text = "Psyche Deepdive test subjects have worn you out, and even a brief moment of respite feels like rain in a desert."
  },
  Event_7025_Name = {
    Text = "Gate Infinity"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Master] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Take It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Disassemble It] Receive 50 Black Sigils"
  },
  Event_7026_Desc = {
    Text = [[
You're walking and accidentally kick something.
It's a compass, its glass shattered and covered in D-Slime. Carefully flipping it over, you faintly see the emblem of Mythag University engraved on the back.]]
  },
  Event_7026_Name = {Text = "Her Choice"},
  Event_7027_ChoiceDesc1 = {
    Text = "[Read the Letter] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_7027_Desc = {
    Text = [[
One letter, another letter, and yet another.
The paper is filled with your past and depicts your future. Under a peculiar enchantment, you can't help but tear and consume the paper.
"Hey? What are you going crazy about again? Eating air?"
Murphy kicks you awake from the phantasm. Coming back to reality, there's nothing in front of you.]]
  },
  Event_7027_Name = {
    Text = "Unwelcome Missive"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_7028_Desc = {
    Text = "Upon hearing your voice, the silhouette stops; Clementine's voice barely makes it through the dense fog.\n\"Oh—it's you,\" she says, indistinct and hazy, like moonlight dissolving in water. \"Don't worry, you'll be fine\"— it's a nice thought, but difficult to believe.\n\"Once you're done here, we'll meet again.\""
  },
  Event_7028_Name = {
    Text = "Mist-Shrouded Figure"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Recipient: Academic Office] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Recipient: My Partner] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7029_Desc = {
    Text = "As you write down the recipient's name, smoke rises from the letter. An invisible hand forcefully snatches it from your grasp—\nAccompanied by a chewing sound, your body suddenly becomes heavy.\nBut the relic in your hand tells you that this trip was not entirely fruitless."
  },
  Event_7029_Name = {Text = "Monologue"},
  Event_7030_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7030_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_7030_Name = {
    Text = "Extraction Point"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7031_Desc = {
    Text = "Let's wait for them to emerge from the shadows."
  },
  Event_7031_Name = {
    Text = "Lantern-Crow"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Call the Crow] Receive 35 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7032_Desc = {
    Text = [[
The dark birds, inspired, swell up and spit something onto your hand.
They fly back to the mast, staring at you with intense gazes.]]
  },
  Event_7032_Name = {
    Text = "Outcast Crow"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Enter Cave]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7033_Desc = {
    Text = [[
"Cough, cough, cough..."
Such a familiar voice... I remember it, squeak!
Humans make this sound when they're sick or near death!
Hurry and take a look, squeak!]]
  },
  Event_7033_Name = {
    Text = "Depths of the Cave"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7034_Desc = {
    Text = [[
You have studied everything about Silvers, including how to assess their grade.
Clearly, these Silvers do not meet the basic requirements for refining.
You must abandon them, along with the possibly trapped fragmented Souls.
Learning to let go is an essential lesson for a Keeper.]]
  },
  Event_7034_Name = {Text = "Bound Soul"},
  Event_7035_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7035_Desc = {
    Text = "This is a One-Way Passage; you cannot return to the entrance through it."
  },
  Event_7035_Name = {Text = "Passage"},
  Event_7036_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7036_Desc = {
    Text = "The sooner it's over, the sooner we can rest. Mythag investigators never fear danger."
  },
  Event_7036_Name = {
    Text = "Gate Infinity"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "\"Please move, I have an urgent matter.\""
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Would Love to Hear More]"
  },
  Event_7037_Desc = {
    Text = [[
"Excuse me, please wait. I see that you look serious and hurried; perhaps you are caught in some kind of dilemma.
But one should not lose the overall perspective or a calm mind because of the current predicament.
For instance, over the past few days, I have been seriously considering many inconsistencies between the legend of Cerberus and the present situation."]]
  },
  Event_7037_Name = {
    Text = "Uncanny Companion II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Receive the Gift]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Decline Kindly]"
  },
  Event_7038_Desc = {
    Text = [[
The boy sits on the windowsill, looking at you. He has been waiting for you for a long time.
"The performance was a success, th-thank you."
"I will be leaving soon... This is a gift for you."
The boy holds out his hand to you.
You see a beautifully wrapped gift box, with blood oozing out and staining the boy's hand.]]
  },
  Event_7038_Name = {Text = "Finale VI"},
  Event_7039_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7039_Desc = {
    Text = "I hope you can always have this kind of confidence."
  },
  Event_7039_Name = {
    Text = "Formless Reflection"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7040_Desc = {
    Text = [[
You take this small, soft ear.
It is wrapped in sticky wax, quietly resting in the center of your palm.
A strong sense of responsibility wells up within you.
First, the bar is off-limits; the music there is too raucous.
Second, the Wellington Garden Theatre is also a no-go; its orchestra is long outdated.
Then...
You and your companions readily accept the fact that you now have a new little pet.]]
  },
  Event_7040_Name = {
    Text = "Listen Closely"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7041_Desc = {
    Text = [[
"Professor Alistair is the cornerstone of Mythag. Without him, everything will cease to function."
You vaguely recall Czort saying this during a drowsy class, tapping on the blackboard with a stern expression.
If this cornerstone were to crumble, how would you cope? A deep fear engulfs you.
"Where are you going?"Ramona's voice pulls you back to reality.
Was it the past or the future, real or imagined, or a dream from another dimension? You can't tell.
In your hand appears a"Gift".]]
  },
  Event_7041_Name = {Text = "Chaos Howl"},
  Event_7042_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7042_Desc = {
    Text = [[
"This wheelchair is my second pair of legs; I'll probably never be without it in this life," Professor Alistair said with a wry smile, "but the unfortunate thing is that it has made me much shorter."

So, this cannot be the real Professor Alistair.]]
  },
  Event_7042_Name = {Text = "Chaos Howl"},
  Event_7043_ChoiceDesc1 = {
    Text = "[Who's Talking?] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[What Whiskey, Let Me Try] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7043_Desc = {
    Text = [[

"Are you really not going to take a sip? This is premium whiskey. If it weren't for the bar owner's generosity in giving me a whole bottle, I wouldn't dare share a drop with you."
"So, you helped him get rid of that haggard, rubber-skinned fellow who only drinks Bloody Marys? That's all the owner rewarded you with for that investigation. You spent a month on it, visited thirty households, faced eleven closed doors, and exhausted seventeen revolver bullets. One bottle of whiskey, and you can't even recover your investment."
"Alright, alright, don't be so stingy. At least we have this bottle of whiskey now, don't we?"]]
  },
  Event_7043_Name = {
    Text = "Memory Shard: Whiskey"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7044_Desc = {
    Text = "You grab the tentacles of the Awakener; he turned to look at you, his eyes flashing with an obscure light.\nHe says nothing, but you understand the hidden message—\n\"Overstepping.\""
  },
  Event_7044_Name = {
    Text = "The Butterfly Effect"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7045_Desc = {
    Text = "The telegraph machine is completely broken. You can imagine the despair of its owner during the storm... just as you feel now."
  },
  Event_7045_Name = {
    Text = "Ancient Legacy"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7046_Desc = {
    Text = [[
Name: Leigh
Age: 20
Complications: Bloodlust accompanied by severe hysteria
Hyperplasia: Deep red Tentacles @2 mouthparts
Grafts: Organs and tissues from direct blood relatives @3
Transfer Reason: No particular reason. I just don't like her.
(The rest is crossed out)]]
  },
  Event_7046_Name = {
    Text = "Organ Registry"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Receive Blessing] Lose all Black Sigils. Acquire a Golden Relic."
  },
  Event_7047_Desc = {
    Text = [[
A blob of black goo appears before you, trembling as it hands over a document.
"I can't come out right now... but you can check out our custom services..."
A woman's voice drifts from within the goo's chest, slightly panicked, as if hiding from something.
"Faerie Blessings are activated based on membership level, guaranteed fair for all."
"Sign, quickly!"]]
  },
  Event_7047_Name = {
    Text = "Fae's Blessing"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Listen Closely] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Inspect] All Awakeners gain 50 Aliemus, but you develop \"(Skill.Arg1)\"."
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Leave Directly] Engrave 1 out of 3 Orisons"
  },
  Event_7048_Desc = {
    Text = "\"Did you know?\" As Ramona searched for the mysterious figure, a voice suddenly whispered, \"Do you know about that matter? That terribly important matter?\""
  },
  Event_7048_Name = {
    Text = "Others' Ears"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Focus] Destroy up to 2 Symptom cards."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Connect] Recover Arg2 HP."
  },
  Event_7049_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_7049_Name = {Text = "Junction"},
  Event_7050_ChoiceDesc1 = {
    Text = "[Handle Carefully] Increase Max HP by Arg1"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Step Forward] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7050_Desc = {
    Text = [[
A shadow conjured by the Domain extends its hand toward you, its figure indistinct.
You remember that a Mythag Investigator once boarded this ship. Could it be him?
Or is it merely another wretched memory bound by the Domain?]]
  },
  Event_7050_Name = {
    Text = "Silver Key Bearer"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7051_Desc = {
    Text = [[
"Look, because of a casual remark of mine, I overlooked the most urgent situation, which is not good.
If we delay any longer, your prey will escape far away.
As an apology, these things are for you."

The man rambles on about something else, handing over a certain item to you.]]
  },
  Event_7051_Name = {
    Text = "Uncanny Companion II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7052_Desc = {
    Text = [[
"May you get what you wish for."
The man shrugged and stepped aside, clearing a path.]]
  },
  Event_7052_Name = {
    Text = "Uncanny Companion II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7053_Desc = {
    Text = "A near-mercury-like silver substance, refined from D-Slime, containing strong mental power, used to link more Awakeners in rituals."
  },
  Event_7053_Name = {Text = "Silver"},
  Event_7054_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7054_Desc = {
    Text = [[
You walk into a new fork in the road.
The sun rises as always, people die as always, and you get lost as always.
Nothing feels fresh.]]
  },
  Event_7054_Name = {Text = "Eye Maze"},
  Event_7055_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7055_Desc = {
    Text = "It appears to be a distorted shadow refracted by light."
  },
  Event_7055_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7056_Desc = {
    Text = "You turn around and see a lone pair of leather shoes.\n\"Sorry, I mean no harm.\"\n\"If you find my body, please tell it that its most faithful walking companion is waiting in Display Case 45, Exhibit Hall 1.\"\n\"—Remember, it's the cowhide ones, not the goatskin.\""
  },
  Event_7056_Name = {Text = "Oxfords"},
  Event_7057_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7057_Desc = {
    Text = "It must be the alumnus—You open your arms to It, but what follows is a chilling pain that seeps into your bones.\nWhen the pain fades, your limbs become extraordinarily strong, stronger than ever before."
  },
  Event_7057_Name = {
    Text = "Silver Key Bearer"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7058_Desc = {
    Text = [[
The mist before you seems to thin.

You feel your vision becoming sharper for the next move.]]
  },
  Event_7058_Name = {
    Text = "Demonic Trial"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7059_Desc = {
    Text = "The phantasm draws near, memories flood back, and clarity strikes."
  },
  Event_7059_Name = {Text = "Mirage"},
  Event_7060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7060_Desc = {
    Text = "His subconscious continues to alter something in the unseen."
  },
  Event_7060_Name = {
    Text = "Divine Gaze"
  },
  Event_7061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7061_Desc = {
    Text = "In a crisis, now is not the time to collect Silver Core."
  },
  Event_7061_Name = {
    Text = "Proof of Being"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7062_Desc = {
    Text = [[
The hazy figure gradually becomes clear; neither a Dissolute nor signs of Cataclysm, but a wingless, entirely ordinary Clementine.
"What a coincidence, are you here to enjoy the moonlight too?" she says with a smile, and you feel a wave of dizziness. "On misty nights, do stay cautious."
"The little ones here aren't terribly well-behaved."]]
  },
  Event_7062_Name = {
    Text = "Mist-Shrouded Figure"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7063_Desc = {
    Text = "As the plaster block shattered on the ground, her body broke apart. Unwilling howls filled your mind, but fortunately, you pulled back in time."
  },
  Event_7063_Name = {
    Text = "Flesh Reforged"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Listen to Sorrow] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Hear Joy] Receive 15 Black Sigils for each Awakener with 50 or more Aliemus."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_7064_Desc = {
    Text = [[
Melodic, lyrical, joyful, sorrowful... The tune echoes in the Domain, its source unclear.
Is it the symphony from the ghost ship's audio system, or a midnight rhapsody bound within the Domain?]]
  },
  Event_7064_Name = {
    Text = "Nameless Echo"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[They're Searching for Someone] Destroy a Command Card, and receive 25 Black Sigils."
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[They're Searching for Something] Duplicate a Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7065_Desc = {
    Text = [[
Why did the Lightbearer Devotees show up in Rye? There are too many mysteries here.
Hellhound Cerberus, Francis, the director of Rye Sanatorium, Sculptors' Association, Church of the Lightbearers...
There must be a source that brought them all to this desolate town.
The typewriter suddenly spits out black ink, as if urging you to type something.]]
  },
  Event_7065_Name = {
    Text = "Enigma Input"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Tightly Close Your Eyes]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Escape Scene]"
  },
  Event_7066_Desc = {
    Text = "The performance comes to an abrupt halt. You look around and find the audience seated all around you.\nThey all have the same face as the boy, staring at you in unison.\nAh—\nThey silently open their pitch-black mouths toward you."
  },
  Event_7066_Name = {Text = "Finale V"},
  Event_7067_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Check Film] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_7067_Desc = {
    Text = [[
You place the film under the dim red light, revealing faint images through the translucent base.
Hands, feet, eyeballs, organs... every imaginable and unimaginable human part is faithfully recorded on the film.
They are meticulously cleaned and arranged, as orderly as your first rhymed poem.]]
  },
  Event_7067_Name = {
    Text = "Verbatim Record"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Princess's Guard] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Thinker] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7068_Desc = {
    Text = [[
"Da, da, da..."
Footsteps approached from afar, and you saw someone about to push open the studio's large door.
With no place left to retreat, you could only pretend to be a wax sculpture in the dim light, attempting to evade that scrutinizing gaze.]]
  },
  Event_7068_Name = {
    Text = "Perfect Disguise"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7069_Desc = {
    Text = "\"Great, great!\" The voice was brimming with joy. \"You've finally become like me, Sister Sasha!\""
  },
  Event_7069_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7070_Desc = {
    Text = [[
Perhaps someone led them here.
As you continue your exploration, the identity of that person will eventually come to light.]]
  },
  Event_7070_Name = {
    Text = "Enigma Input"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7071_Desc = {
    Text = "The sooner it's over, the sooner we can rest. Mythag investigators never fear danger."
  },
  Event_7071_Name = {
    Text = "Endless Doors"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Choose Morality] Recover Arg1 HP"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Choose HP] Recover all HP, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7072_Desc = {
    Text = [[
You might have once had a heart of gold.
It beat tirelessly day and night, striving for your life and dreams... warm, passionate, and full of hope.
But at some point, it slowed down. As if caught between life and morality, it could only bear one.]]
  },
  Event_7072_Name = {
    Text = "Cursed Yearning"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Check Film] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_7073_Desc = {
    Text = [[

"So, you've recorded everything truthfully."
"Yes, the truth lies in the film."
The conversation abruptly stopped, and countless invisible eyes turned toward you, seemingly awaiting your final verdict.]]
  },
  Event_7073_Name = {
    Text = "Eyewitness Account"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Leave] Increase Max HP by Arg1 and receive 25 Black Sigils."
  },
  Event_7074_Desc = {
    Text = [[
Your voice is swallowed by the howling wind.
"You don't need to know me," the hissing growing clearer, "Herbert, Herbert is the one you're looking for. Let him fall from the false dream into the harsh, cold reality."
"I will bestow my blessing upon you, granting you the most delectable..."]]
  },
  Event_7074_Name = {
    Text = "Uncanny Companion VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7075_Desc = {
    Text = [[

"Yes, the poor lost soul, possessing power yet unable to recognize oneself.
Will you lend a hand? Or will you raise your weapon against Him?"
The man leapt into the rushing water. Just as his figure was about to fall, your gaze coincidentally met his. It was a pair of golden, honey-like, slitted pupils belonging to a serpent.
And where he had just stood, there was a small lamp emitting purple smoke.]]
  },
  Event_7075_Name = {
    Text = "Uncanny Companion VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7076_Desc = {
    Text = "\"Caution is a virtue, but excessive caution is a form of untimeliness,\" a monotonous voice tinged with dissatisfaction remarked, \"the movement of the stars will disturb the genesis of the Awakener's slumber, and the right timing can cause their Aliemus to swell rapidly, like inflating a balloon. In short, there is still time to catch the comet's tail; remember to optimize your reaction speed, which is no better than a turtle's, next time.\""
  },
  Event_7076_Name = {Text = "Elevation"},
  Event_7077_ChoiceDesc1 = {
    Text = "[Restore] Reduce current Stress by half."
  },
  Event_7077_Desc = {
    Text = "You touched the stabilizing chamber, restoring your current stress level."
  },
  Event_7077_Name = {
    Text = "Equilibrium Point"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Comfort Her] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Blame Her] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7078_Desc = {
    Text = [[
"I am the shadow of the deceased investigator, and the murderer is that silver key."
The woman clutched her head in agony. Her thick hair was adorned with countless shimmering eyes blinking...
"They always said: No, Charlotte! Alas, Charlotte!
So I thought, if I could link many Awakeners at once, everyone would fall silent."
"Then... I don't know what happened, and when I awoke, I had become like this. Alas!"]]
  },
  Event_7078_Name = {
    Text = "Investigator's Shade"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Climb the Wall] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Enter Maze] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7079_Desc = {
    Text = [[
Your mind is a maze.
Too many thoughts are entangled within. The exit is within sight, yet towering walls of thought stand between you.]]
  },
  Event_7079_Name = {Text = "Mind Maze"},
  Event_7080_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Acquire 1 out of 3 Silver Relics"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Near Phantasm] Acquire the Silver Relics \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg3)\" twice."
  },
  Event_7080_Desc = {
    Text = [[
In the distance, it seems that a volcanic cone has erupted, and smoke in the shape of a human rises in the stormy sky.
But this is Elworth, where there are only endless towering snow mountains and limestone karst caves.
Have the continuous abnormalities driven you to spiritual confusion?]]
  },
  Event_7080_Name = {
    Text = "Volcano's Ghost"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[What Did I See] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[I Saw Nothing] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7081_Desc = {
    Text = "Liquid seeps from the corners of your eyes, its sticky sensation unsettling.\nUltimately, it was triggered by what you saw—or did you truly see nothing at all?"
  },
  Event_7081_Name = {Text = "Unseeable"},
  Event_7082_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7082_Desc = {
    Text = [[
You've felt joy. You've felt sorrow. You recognize now it is not your own emotions overwhelming you.
Closing your eyes and covering your ears, the Silver Key shines with a dazzling light.
It'll be okay. Finally, you can take a deep breath.]]
  },
  Event_7082_Name = {Text = "Indulgence"},
  Event_7083_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7083_Desc = {
    Text = [[
The dagger-wielder emits a cry like a death bird in a midnight graveyard.
The sound vanishes instantly, and the other two Seafarers also disappear... It turns out it was just an Illusion reflected by the Domain.]]
  },
  Event_7083_Name = {
    Text = "Relentless Hunt"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7084_Desc = {
    Text = "It hovers silently in the air, unblinking, its gaze earnest—as if trying to tell you something.\nEyes may harbor a soul, but without words, you can only sense a trace of urgency and a hint of sorrow.\nIt vanishes into thin air."
  },
  Event_7084_Name = {
    Text = "Blind Stare"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Agree] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Gift] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Turn and Leave] Receive 25 Black Sigils"
  },
  Event_7085_Desc = {
    Text = [[

"If one day I must fall, then I hope to fall into the water.
The flowing water that covers my nostrils feels like a gentle old dream.
The liquid I sink into
is the bowl that @2 desires most."]]
  },
  Event_7085_Name = {
    Text = "Aquatic Rite"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Resist Phantasm] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Extract Aliemus] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_7086_Desc = {
    Text = "The fragmented dimension gradually collapses, and phantasms from other dimensions flood into the deranged room."
  },
  Event_7086_Name = {
    Text = "Dimensional Phantasm"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Leave] Rouse a random Awakener"
  },
  Event_7087_Desc = {
    Text = [[
The girl pauses, brushing her skirt.
"What I can do for you... is only this much."]]
  },
  Event_7087_Name = {
    Text = "Whitegowned Maiden"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7088_Desc = {
    Text = "Who's speaking?\nYou look down and see a blurry reflection—it wears the same clothes as you but holds a knife, smiling at you."
  },
  Event_7088_Name = {
    Text = "That Which You Shouldn't Seek"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Skip the battle and claim instant victory, but lose Arg1 HP."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Leave] Enter Battle"
  },
  Event_70892_Desc = {
    Text = "Although the enemy is extraordinarily powerful, you are already well-versed in the techniques to defeat them."
  },
  Event_70892_Name = {
    Text = "Muscle Memory"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Rake Koum]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Attack the Test Subject]"
  },
  Event_7089_Desc = {
    Text = "Koum bit the back of a test subject's neck, ready to fling it. Suddenly, the subject twisted its head 180° like an owl and pecked at Koum's face."
  },
  Event_7089_Name = {Text = "Arena"},
  Event_7090_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7090_Desc = {
    Text = [[
You grip the silver key, sensing the call of genesis through the dimension's upheaval.
To fight the unknown evil Hellhound, you must use every possible power]]
  },
  Event_7090_Name = {
    Text = "Dimensional Phantasm"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7091_Desc = {
    Text = [[

"As for that investigator, the curator intends to personally interrogate him...
Take him alive..."
The voice gradually weakened, eventually fading into darkness.]]
  },
  Event_7091_Name = {
    Text = "Eavesdropper"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7092_Desc = {
    Text = "The sensation of weightlessness jolts you awake. The ground beneath your feet feels solid and reliable, and at your feet lies an exquisite square mirror."
  },
  Event_7092_Name = {
    Text = "Mirror Within"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7093_Desc = {
    Text = "You never argue with those consumed by madness beyond aid. It devours your soul in midnight questions. Spare yourself!"
  },
  Event_7093_Name = {
    Text = "Aquatic Rite"
  },
  Event_7094_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7094_Desc = {
    Text = [[
What should the face of the wax sculpture look like?
You close your eyes, and countless blurry faces appear in your mind.
They are like candles with pale flames, emerging and vanishing in the dark river...
You follow the river to its end, where the one and only, final wax sculpture stands.
As you approach it, you see...@2.]]
  },
  Event_7094_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Attack the Dagger-Wielder] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Ambush the Blade-Wielder] Acquire the Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\", but develop \"(Skill.Arg1)\" twice."
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Trip the Spear-Wielder] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7095_Desc = {
    Text = "Three Seafarers cling to you tightly, their frenzied, fiery gazes nearly igniting your cloak.\nA glance back reveals that the three of them are different—\nThe Seafarer wielding a huge blade shouts the most violently, yet acts somewhat carelessly.\nThe Seafarer holding a spear moves in sync, like a child learning to speak.\nThe Seafarer gripping a dagger lags behind, and the mutterings of prayers prove his fanaticism."
  },
  Event_7095_Name = {
    Text = "Relentless Hunt"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7096_Desc = {
    Text = [[
You carefully unwrap the gift.
A pair of eyeballs rests quietly in the box.
"I give you my eyes."
"Just like he once did for me."]]
  },
  Event_7096_Name = {Text = "Finale VI"},
  Event_7097_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7097_Desc = {
    Text = [[
Reaching through the center of the light, you pick up a solidified Silver. This precious vessel of Memory and Soul is scorching hot, refracting strange colors.
Before it distorts all the light, the burning pain compels you to throw it back into the darkness.]]
  },
  Event_7097_Name = {Text = "Nightglow"},
  Event_7098_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7098_Desc = {
    Text = [[
You declined the boy's gift.
The boy gazed at you with hollow eyes. He sighed softly.
"Well, goodbye then."
With those words, the boy made a bowing gesture and fell out the window.
He vanished, like a dancing butterfly or a passing breeze.]]
  },
  Event_7098_Name = {Text = "Finale VI"},
  Event_7099_ChoiceDesc1 = {
    Text = "Choose a Basic Orison"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Accept Ear] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Reject Request] Engrave 1 out of 3 Orisons"
  },
  Event_7100_Desc = {
    Text = [[
A cascade of elegant notes flows from the fingertips.
The melancholic wax pianist sits alone by the window.
Since gaining consciousness, the wax museum has been his entire world.
He yearns to hear something different, especially... a kind of music called jazz.
In the end, he tears off one of his ears and asks you to take it with you.
"Let me hear the music from the outside... just put it in your pocket."]]
  },
  Event_7100_Name = {
    Text = "Listen Closely"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expel] Destroy up to 3 Symptom cards, and receive Arg2 Black Sigils."
  },
  Event_7101_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_7101_Name = {Text = "Junction"},
  Event_7101_Tips3 = {
    Text = "You are not currently exhibiting any Symptoms."
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Accept Challenge]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Punch It] Receive 25 Black Sigils"
  },
  Event_7102_Desc = {
    Text = [[
A gaunt figure emerges from the shadow, blocking your path.
A memory forever bound intrudes into the domain, proclaiming himself as "N". The apparition tosses the chips in its hand, inviting you to join His game with a muffled whimper.
The tri-colored chips spread out before you; unless you play a "game" with Him, He seems unwilling to let you go.]]
  },
  Event_7102_Name = {Text = "Showtime"},
  Event_7103_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7103_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_7103_Name = {
    Text = "Extraction Point"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Struggle Awake] Increase Max HP by Arg1"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Indulge in Sleep] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards, but develop \"(Skill.Arg2)\" twice."
  },
  Event_7104_Desc = {
    Text = [[
You cradle a gleaming gem in your arms.
It spreads from your chest, filling your body with the warm glow of candlelight memories, finally flooding into your mind.
Crackling embers, a cozy armchair by the hearth, rich hot tea, and a cat curled up at your feet...
In this comforting drowsiness, your mind grows foggy, and you drift into a soft slumber.]]
  },
  Event_7104_Name = {
    Text = "Yesterday's Embrace"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7105_Desc = {
    Text = "You mercilessly pulled out another film strip hidden inside the camera, revealing images that left you speechless.\nThe undeveloped film faithfully recorded— you lying in a puddle of black mud."
  },
  Event_7105_Name = {
    Text = "Record Innocence"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7106_Desc = {
    Text = [[
You carefully examined the camera, its leather and black-gold inlay exuding a sleek sheen.
The lens was aimed at you, as if gazing and prying...]]
  },
  Event_7106_Name = {
    Text = "Record Innocence"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7107_Desc = {
    Text = [[
A handful of moonlight, gathered in the palm, was sprinkled onto the stone tablet.
Someone was buried beneath thick mud, and the onlookers claimed it was a natural death, asserting that they would rest peacefully underground.
However, the buried mud churned, and amidst the screams, a limp moon crawled out.]]
  },
  Event_7107_Name = {
    Text = "Moon Silver Shard"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7108_Desc = {
    Text = "You gently touch the butterfly's delicate black wings. It flutters softly, then transforms into pitch-black droplets, falling into your palm."
  },
  Event_7108_Name = {
    Text = "That Which Should Not Be"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7109_Desc = {
    Text = "The solitary moon hangs high in the sky, yet you can clearly hear its prayer—a strange chant resembling the whispers of corruption.\nThe prayer ceases, and as you are about to leave, a white phantom appears behind you.\n\"Those who trespass against fate and prayer, both blessings and retribution will come as promised.\""
  },
  Event_7109_Name = {
    Text = "Moon Silver Shard"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_7110_Desc = {
    Text = [[
Looks like you're having some good luck today.
The dice tremble and emit an excited hum.
You decide to guess a number.]]
  },
  Event_7110_Name = {
    Text = "Eternal Gamble"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7111_Desc = {
    Text = [[
This gamble is a huge scam!
You "tseng" Leap to your feet, only to feel a wave of dizziness.
The dice emit a noisy hum, and a seductive voice continuously lingers in your mind:
"The only one... the last one..."]]
  },
  Event_7111_Name = {
    Text = "Eternal Gamble"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Use Silver] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Store Silver] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Put Back in Drawer] Receive 25 Black Sigils"
  },
  Event_7112_Desc = {
    Text = "In the second drawer on the right side of your desk lies a lone Silver Core. Upon touching it, you hear the howling of storms, the shattering of snowflakes, and the wailing of a flute..."
  },
  Event_7112_Name = {
    Text = "Lonely Silver Core"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Listen Closely] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Make a Change] Destroy a Relic and gain a reward."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7113_Desc = {
    Text = [[
Not all melodies are moving.
Pure dissonance forms a lament.]]
  },
  Event_7113_Name = {Text = "Dissonance"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Pick It Up] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandon It] Receive 25 Black Sigils"
  },
  Event_7114_Desc = {
    Text = "In the concealed, decaying corner of the haystack, within the cracked D-Mark, something lies quietly."
  },
  Event_7114_Name = {
    Text = "Haystack's Leeward"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7115_Desc = {
    Text = "The figure does not come closer. It gazes at you for a moment, then turns into a handful of silver sand."
  },
  Event_7115_Name = {
    Text = "Silver Key Bearer"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Accept Tulu's help"
  },
  Event_7116_Desc = {
    Text = [[
With a sigh, Tulu catches up.
Heavy, icy limbs hook onto you, quelling your urge to charge into the enemy ranks.
"I will be your aid, but only for now."]]
  },
  Event_7116_Name = {
    Text = "Emissary's Promise"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Get the Key]"
  },
  Event_7117_Desc = {
    Text = [[
1, 2, 3...
Jenkin is 10 feet away from the desk.
It's a short distance, yet it feels like a lifetime to her.
She recalls the soft ribbons, the golden butterfly candy wrappers, and her mother's tears.
She thought of many, many things...
Her frail body wades through the black river, inching closer to the desk.
The Key is in the drawer, and the cost to obtain it is simple: courage, dexterity, and a bit of luck.
Jenkin has everything but luck.]]
  },
  Event_7117_Name = {
    Text = "Ultimate Key"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7118_Desc = {
    Text = [[
It's just a bet. You won't lose.
The coin, engraved with intricate patterns, is tossed high into the air, quickly descends, and warms up in your palm.]]
  },
  Event_7118_Name = {
    Text = "Notorious Gambler"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7119_Desc = {
    Text = [[
It's just a bet. You won't lose.
The coin, engraved with intricate patterns, is tossed high into the air, quickly descends, and warms up in your palm.]]
  },
  Event_7119_Name = {
    Text = "Notorious Gambler"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7120_Desc = {
    Text = [[
It's just a bet. You won't lose.
The coin, engraved with intricate patterns, is tossed high into the air, quickly descends, and warms up in your palm.]]
  },
  Event_7120_Name = {
    Text = "Notorious Gambler"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7121_Desc = {
    Text = [[
You have no intention of joining this serious piano lesson.
After each measure, the students strain to twist their heads, pretending to listen.
The teacher bends slightly, lips moving, turn eyes staring at a non-existent sheet of music.
They clearly don't know what they're doing and will never understand why humans spend years on this mechanical practice.
They're just imitating.]]
  },
  Event_7121_Name = {
    Text = "Piano Lesson"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7122_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_7122_Name = {
    Text = "Extraction Point"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Hum Softly] Engrave 1 out of 3 Orisons"
  },
  Event_7123_Desc = {
    Text = [[
Ancient shanties echo in the domain.
Confined memories sing of waves, skies, and strong drink, in an unheard language]]
  },
  Event_7123_Name = {Text = "Sea Shanty"},
  Event_7124_ChoiceDesc1 = {
    Text = "[Call the Crow] Receive 20 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7124_Desc = {
    Text = "The pitch-black birds fix their gaze on you. After a long while, something falls from their feathers..."
  },
  Event_7124_Name = {
    Text = "Outcast Crow"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] 100% chance to get 25 Black Sigils"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Friendly Response] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_7125_Desc = {
    Text = [[
A cat of unknown origin sits among the D-Slime, its blurred body suggesting it belongs to the spirit dimension.
This indistinct projection gazes at Ramona with wise eyes, raises its white paw, and beckons her.]]
  },
  Event_7125_Name = {
    Text = "Wandering Dweller"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Running North]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignore the Sound]"
  },
  Event_7126_Desc = {
    Text = [[
The enemy's attacks rain down behind, their blades grazing the cloak and startling a flock of gulls at the dock.
"Head north... or board the ship..."
Even the most foolish person could sense that some unseen force is aiding you.]]
  },
  Event_7126_Name = {Text = "Northbound"},
  Event_7127_ChoiceDesc1 = {
    Text = "[Listen to the Sun] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7127_Desc = {
    Text = [[
In the intertwining of reality and Illusion, celestial bodies eternally rotate along their predetermined orbits.
Countless brushes past have played a strange and eerie symphony...]]
  },
  Event_7127_Name = {
    Text = "Astral Harmonies"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Leave with Sorrow] Copy a card. If a Symptom card is copied, receive 75 Black Sigils."
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Leave in Anger] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7128_Desc = {
    Text = "Liquid gushed from the pupils, cold and turbulent, taking away a part of the soul."
  },
  Event_7128_Name = {
    Text = "Styx's Lament"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Into the Corridor]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Receive 25 Black Sigils"
  },
  Event_7129_Desc = {
    Text = [[
The pale moonlight ignores the passage of time, spilling over the silent corridor.
The doorway emits an eerie glow under the moon's rays.]]
  },
  Event_7129_Name = {
    Text = "Silent Hall"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7130_Desc = {
    Text = [[
You decide to repair the wax sculpture.
Scattered nearby are some tools, and you pick a dye called "Prussian Blue".
It's blue like a disease.]]
  },
  Event_7130_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7131_Desc = {
    Text = [[
The pustule emitted a sharp and eerie shriek, accompanied by an unnatural whistling in the ears, phantasmic flute sounds, and the forbidden resonance of oozing fluids.
The pustule twitched bizarrely for a moment before stiffening into silence. Witnessing this, the Awakener beside you seemed to receive some sort of call.]]
  },
  Event_7131_Name = {
    Text = "Strange Pustule"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7132_Desc = {
    Text = "Your fingertips touch the statue, sensing unexpectedly soft indentations. You always assumed it was an illusion."
  },
  Event_7132_Name = {
    Text = "Patchwork Remains"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Tear For Her]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Pray to Her]"
  },
  Event_7133_Desc = {
    Text = [[
The moment you touch the ship's railing, memories that weren't yours flood your mind.
People dressed her in a pure white gown, adorned her with elegant jewelry, and placed her on a high altar. The townsfolk knelt and bowed at her feet.
Their eyes were filled with hope: sailors wished for her protection during voyages, fishermen hoped for a calm fishing season, and other townspeople desired a year of smooth sailing.
Among the kneeling crowd were her childhood friends and her close family.
She didn't want anything; she didn't know what she wanted.
Passively responding to prayers seemed to be her only purpose in life.]]
  },
  Event_7133_Name = {
    Text = "Pre-Voyage Rites"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7134_Desc = {
    Text = "The pale pupils of that mutilated body slowly turned, watching your departing figure and revealing a faint smile."
  },
  Event_7134_Name = {
    Text = "Patchwork Remains"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Face It] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Surrender] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Run Away] Receive 50 Black Sigils"
  },
  Event_7135_Desc = {
    Text = [[
A few wax sculpture blocks obstruct your path.
They are crooked and rough in appearance, not resembling the craftsmanship one would expect from Rogers.
"Orders... the master's orders..."]]
  },
  Event_7135_Name = {Text = "Draft"},
  Event_7136_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7136_Desc = {
    Text = [[

You choose to bravely stare into the eyes.
They are brilliant stars, shimmering in the dark.
Then they laughed and transformed into countless crescent moons.
"You are not afraid of gazes. You shouldn't be afraid of...
Long time no see, @2"
Before they vanished, they gave you a small gift as a "reunion memorial".]]
  },
  Event_7136_Name = {Text = "Her Eyes"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Switch On] Expand current vision[ExDesc1]."
  },
  Event_7137_Desc = {
    Text = [[
An ancient lighting device dispels the black mist around it.
The mist surrounding it fluctuates rhythmically, as if disturbed by its breath.]]
  },
  Event_7137_Name = {
    Text = "Searchlight"
  },
  Event_7138_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7138_Desc = {
    Text = "Your back unfurls transparent wings, spiraling and swirling with the crows into the silent seabed."
  },
  Event_7138_Name = {
    Text = "Crows' Chorus"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Destroy It] Obtain a \"Mutated Heart\""
  },
  Event_7139_Desc = {
    Text = [[
The deformed pustules abandoned by unknown individuals on the roadside glisten with a filthy, oily green sheen, writhing and morphing restlessly.
Rather than resembling a monster, it looks more like ice cream melting under the scorching sun, soon turning into a sticky sludge and vanishing into the air.]]
  },
  Event_7139_Name = {
    Text = "Strange Pustule"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Lower Your Hands] Develop the Symptom \"(Skill.Arg1)\", and choose a reward"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Catch a Crow] Develop the Symptom \"(Skill.Arg1)\", and choose a reward"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Receive 50 Black Sigils"
  },
  Event_7140_Desc = {
    Text = "Screeching, endless screeching—\nThe Crow Singer is cloaked in glossy black feathers, its sharp beak glinting coldly, each mournful cry piercing your eardrums.\nUncover your ears!\nThe crows of the night revel in their cries, eager to drink from the untempered tremors within your cowering form.\n"
  },
  Event_7140_Name = {
    Text = "Song of Crows"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Leave] Nothing found"
  },
  Event_7141_Desc = {
    Text = "Not the person you're looking for"
  },
  Event_7141_Name = {
    Text = "Temporary 2_6"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7142_Desc = {
    Text = [[
You chose to press on.
Compared to the mental and physical harm inflicted by those dreadful wax artworks, this minor inconvenience is nothing.
You have greater missions to accomplish.]]
  },
  Event_7142_Name = {Text = "Footsteps"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7143_Desc = {
    Text = [[
"What's wrong! Do you just love poking at others' wounds like that?"
"Yes! I've suddenly aged twenty-five years for no reason! Now you have to call me Sister Murphy!"]]
  },
  Event_7143_Name = {
    Text = "Shackled Life"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7144_Desc = {
    Text = "The girl's face is as serene as the moonlight tonight. She does not respond to you but raises the compass in her hand high—she is trembling, as if lifting the small compass has drained all her strength."
  },
  Event_7144_Name = {
    Text = "Whitegowned Maiden"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7145_Desc = {
    Text = "\"Delicious! Delicious!\" The raven cackled, and the stench of decay spread to your nose as it unfolded its wings."
  },
  Event_7145_Name = {
    Text = "Cursed Crow"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7146_Desc = {
    Text = "In my opinion, noise is the model of a new era.\nIt relentlessly marches across the world with irregular rhythms and maddening melodies.\nNo mercy, no wavering, no compromise.\nDetesting order, discarding themes, noise never seeks to please—\nThat includes our wax sculptor."
  },
  Event_7146_Name = {Text = "Bad Taste"},
  Event_7147_ChoiceDesc1 = {Text = "[Guide]"},
  Event_7147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7147_Desc = {
    Text = [[
Someone is gently tugging at your sleeve.
It's the boy you saw earlier. He squats in the corner, looking at you with a sad expression.
"I-I want to participate in the academy's performance.
But I can't find the way to the stage."]]
  },
  Event_7147_Name = {Text = "Finale II"},
  Event_7148_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7148_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7148_Desc = {
    Text = "The tip of your nose catches a familiar scent, homely and satisfying. Just as you try to take another sniff of the cafeteria aroma, it vanishes completely."
  },
  Event_7148_Name = {
    Text = "Anomalous Contact"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7149_Desc = {
    Text = [[
They are warm colors.
Passionate, gentle, and loving colors.
They gave the girl a nostalgic hug and then vanished like the wind.]]
  },
  Event_7149_Name = {
    Text = "Hue of Longing"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Who are you, really?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[How to Change Your Mindset?]"
  },
  Event_7150_Desc = {
    Text = [[
A man with long hair once again blocks your path. Having had the previous experience, Ramona's expression is unfriendly.
"Calm down, my friend," the man slowly speaks. His voice is magnetic and seductive, as if the sound flows through a narrow airway, mixed with a hissing friction.
"I have been observing for some time; only by shifting your mindset can you approach your goal."]]
  },
  Event_7150_Name = {
    Text = "Uncanny Companion III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[I Am Searching] Increase Max HP by Arg1"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[I Am Avoiding] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7151_Desc = {
    Text = [[
"I see someone searching, looking for the unattainable, that sorrowful relative thing, that which is called truth.
I see someone avoiding, evading the unavoidable, that cruel hidden thing, that which is called truth.
Which one are you?"]]
  },
  Event_7151_Name = {Text = "The Sought"},
  Event_7152_ChoiceDesc1 = {
    Text = "[Examine Closely] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Attempt to Listen] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Store Carefully] Receive 25 Black Sigils"
  },
  Event_7152_Desc = {
    Text = "The mist ahead was illuminated by a tiny object, resembling a shard of glass or crystal, with countless colors, both vivid and dim, swirling inside."
  },
  Event_7152_Name = {
    Text = "Our Memories"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Accept Challenge] Win to acquire a Silver Relic, lose to develop a Symptom. The outcome does not affect further investigation."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7153_Desc = {
    Text = [[
Who is the person in the reflection?
They breathe with you, share your heartbeat, and harbor the same eerie idea.
Is it a prank from the Domain, or a shadow crossing dimensions?
This seems to be an invitation to an illusory challenge.]]
  },
  Event_7153_Name = {
    Text = "Soul Resonance"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7154_Desc = {
    Text = [[
Vision transcends history and time. It may be non-linear, gazing at you from the chaos before the planet's birth.
Or perhaps, it awaits you on a distant day in the future.]]
  },
  Event_7154_Name = {Text = "Peek"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] Receive 50 Black Sigils"
  },
  Event_7155_Desc = {
    Text = [[
The area is empty, with dark liquid flowing across the ground, reflecting nothing.
Is it an illusion? You feel something slipping through your fingers.]]
  },
  Event_7155_Name = {
    Text = "Under-Mirror"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7156_Desc = {
    Text = [[
"You're such a generous person. I wish you all your wishes today, tomorrow, and the day after."
"By the way, this is a one-time deal..."
The faerie smacked her lips in satisfaction and reluctantly said goodbye to you.]]
  },
  Event_7156_Name = {
    Text = "Fae's Blessing"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Give Me My Wallet Back!] Engrave 1 out of 3 Orisons"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Hesitate] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_7157_Desc = {
    Text = [[

"Come on, come and take back your wallet!" A distant child waved their hand.
You ran forward, and as you reached out, a sudden loud and chaotic noise rang in your mind.
"Where did this dirty kid come from?"
"That's a little street rat! How dare he touch the Duchess's gown!"
"Get him out of here!"
"Do you have any coins? Without coins, don't think you can take even a piece of black bread!"]]
  },
  Event_7157_Name = {
    Text = "Book of Null"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Chase the Song] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Sing Along] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_7158_Desc = {
    Text = [[
The distant song shattered into stardust:
"I curse the filthy puddle in the night alley, decayed flowers cling to the crumbling wall, chains drag the mind into the mire. Before the fog erases my existence, dusk will sink into the deepest @2."]]
  },
  Event_7158_Name = {
    Text = "Pallid Curse"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Offer Tribute] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Take It Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7159_Desc = {
    Text = "As you approach, chaotic souls suddenly emerge from the mire.\nBlack limbs entwine you tightly, crying and pleading—\nMake an offering or take them away."
  },
  Event_7159_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Leave an Offering] Enhance the Orison quality of a random card."
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Take It Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7160_Desc = {
    Text = "As you approach, chaotic souls suddenly emerge from the mire.\nBlack limbs entwine you tightly, crying and pleading—\nMake an offering or take them away."
  },
  Event_7160_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Wave Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Let It Stay] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7161_Desc = {
    Text = [[
A butterfly with black slime on its wings wobbles as it flies, leaving trails of black ooze that solidify and flake off in the wind.
It grows tired and rests on the tip of your nose.]]
  },
  Event_7161_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Wave Away] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Let It Stay] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7162_Desc = {
    Text = [[
A butterfly with black slime on its wings wobbles as it flies, leaving trails of black ooze that solidify and flake off in the wind.
It grows tired and rests on the tip of your nose.]]
  },
  Event_7162_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7163_Desc = {
    Text = "\"I see courage, willpower, and a spirit shining like the stars. Move towards that wax-sealed memory, and you shall have your wish fulfilled.\""
  },
  Event_7163_Name = {Text = "The Sought"},
  Event_7164_ChoiceDesc1 = {
    Text = "[Let It Linger] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Wave Away] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Receive 25 Black Sigils"
  },
  Event_7164_Desc = {
    Text = [[
You wander through the frigid sanatorium, where a black butterfly that shouldn't exist in this season flutters by.
Its wings, coated with black slime, wobble as it flies, shedding stacks of black sludge that solidify and peel off in the wind.
Exhausted, it lands on your fingertip.]]
  },
  Event_7164_Name = {
    Text = "That Which Should Not Be"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7165_Desc = {
    Text = [[
You begin to feel weary.
Your consciousness carries you across ponds and mountains,
Beyond the sun, beyond light-years,
Toward the one and only... cosmic cradle.]]
  },
  Event_7165_Name = {Text = "Finale IV"},
  Event_7166_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7166_Desc = {
    Text = [[
A massive shadow completely engulfs you, and foul-smelling saliva drenches you like a drowned rat.
"Little mouse, come here. Just for a moment..."
"I swear, I have no intention of eating you..."
"I won't even glance at your plump, juicy belly!"]]
  },
  Event_7166_Name = {
    Text = "Material 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7167_Desc = {
    Text = [[
The withered wax sculpture philosopher smokes, shrouded in a white haze.
"The other shore exists but is unknowable, thus it remains unknown."
"Imagine this world as a game...
What you're looking for might be on the other side of the map."]]
  },
  Event_7167_Name = {
    Text = "Material 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7168_Desc = {
    Text = [[
"I'm sorry, no offense intended..."
"I don't like mice. The problem with mice is that they are never afraid of humans..."
An unkempt old man lay in the corner, his melancholic eyes locked onto you.
"Of course, you are very ambitious.
That's good, but it's not enough to help you escape the disaster..."]]
  },
  Event_7168_Name = {Text = "Material 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Show the Curse] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Reject the Crow] Engrave 1 out of 3 Orisons"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignore]"},
  Event_7169_Desc = {
    Text = [[
A pitch-black, sickly multi-headed raven flies out from the black robe of a Lightbearer Devotee and lands on your shoulder.
"Do you see my head? As long as I taste the curse, I will grow a new head. Let me see, your curse!"]]
  },
  Event_7169_Name = {
    Text = "Cursed Crow"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Answer the Call] Destroy a Command Card and recover Arg1 HP"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[I'm Not Fleeing] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7170_Desc = {
    Text = [[
You sprint through the alley. Adrenaline surges, lactic acid builds up, glucose is depleted... Chaos invades your mind, urging you to flee amidst the psychedelic haze.
Yes, flee. If you aren't running away, why are chaos and illusion, failure and emptiness awaiting you?]]
  },
  Event_7170_Name = {Text = "Run"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Trace Sound Source]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Summon Lily and Koum]"
  },
  Event_7171_Desc = {
    Text = "From afar in the dimensional passage, we hear heavy, guttural sounds mixed with fear, anticipation, and anxiety, as if calling out to you. Then, a girl's muffled murmurs gradually fade away."
  },
  Event_7171_Name = {
    Text = "Guiding Voice"
  },
  Event_7172_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7172_Desc = {
    Text = "A near-mercury-like silver substance, refined from D-Slime, containing strong mental power, used to link more Awakeners in rituals."
  },
  Event_7172_Name = {Text = "Silver"},
  Event_7173_ChoiceDesc1 = {
    Text = "[Ask to Clear the Path]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Ask Who He Is]"
  },
  Event_7173_Desc = {
    Text = [[
You step into a dimly lit carriage, an eerie feeling rising within you.
The carriage is empty; the passengers have long fled, leaving behind scattered monster remains that are slowly dissipating.
In the center of the carriage stands a man.
"I believe in fate, and it is fate that has brought us onto the same subway."]]
  },
  Event_7173_Name = {
    Text = "Uncanny Companion IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7174_Desc = {
    Text = [[
"Your eyes are beautiful, like stars."
Charlotte giggled, her wildly roaming hair settling down gently.
"You must be popular at school. I like you too."
Before leaving, she kissed your forehead.
You felt your body warm and something seemed different.]]
  },
  Event_7174_Name = {
    Text = "Investigator's Shade"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Read] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Store in Suitcase] Acquire the Relic \"(RelicConfig.Arg2)\", but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7175_Desc = {
    Text = [[
A yellowed page fell from the Lightbearer Devotee's robe.
It was covered in strange texts, some resembling hieroglyphs, some oddly slanted, and some overlapping. Only a few words were barely legible.]]
  },
  Event_7175_Name = {
    Text = "Cipher-Edict: Part I"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7176_Desc = {
    Text = [[
You say: "Oh, Charlotte! No way!"
Charlotte's hair twists wildly, and she is furious.
"I'll show you! Watch my skills!"]]
  },
  Event_7176_Name = {
    Text = "Investigator's Shade"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7177_Desc = {
    Text = "Event 302 (In Development), Non-Final Effects"
  },
  Event_7177_Name = {
    Text = "Event 302 (In Development)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Accept Request] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Refuse Request] Receive 25 Black Sigils"
  },
  Event_7178_Desc = {
    Text = [[
The jaw cracks rhythmically, with a sound bearing a certain regular cadence, and your companion just happens to understand some cryptography.
The deciphered text is as follows:
"Hello, please call me Dr.@2. I was once a collector and a naturalist...
(This portion contains a long-winded introduction of careers and titles.)
In short, can you help me find my other half? It's a small piece of upper jawbone.
Once found, my private treasury will open its doors to you."]]
  },
  Event_7178_Name = {Text = "Creak"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Invest 100 Florins] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Invest Five Pence] Receive 25 Black Sigils"
  },
  Event_7179_Desc = {
    Text = [[
The embroidered purse writhes, opening a pitch-black maw toward you.
Since parting from its wealthy mistress, it has been starving for decades, yearning to be fed.
You take a peek inside; it is empty, brimming only with an impenetrable darkness.]]
  },
  Event_7179_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Steadfast Determination] Destroy a Command Card and recover Arg1 HP"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Desire to Succeed] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7180_Desc = {
    Text = "\"Two stubborn people? The Workhouse is already dangerous—\" Doll's voice suddenly comes through the communicator, \"What's your plan here? Sew her head back on?\"\n\"Now's not the time for sarcastic remarks, Doll!\"\n\"I know, I can tell.\" Doll said, \"Calm down. Do you know what the key to success is?\""
  },
  Event_7180_Name = {
    Text = "Rogues' Rule"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7181_Desc = {
    Text = "Event 304 (In Development), Non-final Effect"
  },
  Event_7181_Name = {
    Text = "Event 304 (In Development)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7182_Desc = {
    Text = "Event 305 (In Development), Non-Final Effects"
  },
  Event_7182_Name = {
    Text = "Event 305 (In Development)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Hang Up] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Answer the Phone] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7183_Desc = {
    Text = "As you pass by the conductor's rest area, a phone rings sharply from a hidden corner."
  },
  Event_7183_Name = {Text = "Train Call"},
  Event_7184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7184_Desc = {
    Text = "Dim, yet undeniably real.\nSuch faint Silver Core cannot summon an Awakener but are perfect for strengthening— this is the essence of Silver Chip Technology."
  },
  Event_7184_Name = {
    Text = "Proof of Being"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Lady's Portrait] Enhance the Orison quality of a random card."
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Wax Family Portrait] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7185_Desc = {
    Text = "The wax museum also houses many paintings.\nPortraits, landscapes, still lifes, realistic, abstract...\nThey adorn the otherwise dull walls, making them less boring.\nOne of them catches your eye. It is a —"
  },
  Event_7185_Name = {
    Text = "Portrait Gallery"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Keep Reading] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Leave] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7186_Desc = {
    Text = [[
A scale for weighing.
Behind it, countless organs are soaked in red formalin.
They are neatly stacked on storage shelves.
You casually pick up a nearby notebook and flip through it:
"Heart: 8 oz, Brain: 50 oz..."]]
  },
  Event_7186_Name = {
    Text = "Organ Registry"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Open Gift] Receive an \"Innocent Return Gift\""
  },
  Event_7187_Desc = {
    Text = "The shadow of a child flickers past you; you can't discern whether it's a real child or a projection of some spirit in the Domain. But—you look at the box left on the ground, which has \"Gift\" written on it in childish script."
  },
  Event_7187_Name = {
    Text = "Gift of Kindness"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Call the Crow] Receive 40 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Stay Far Away] Receive 25 Black Sigils and leave."
  },
  Event_7188_Desc = {
    Text = [[
The white gulls rest on the frost-covered mast.
The resonating calls repel the darkness and the dark birds that do not belong to the open sea.]]
  },
  Event_7188_Name = {
    Text = "Outcast Crow"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7189_Desc = {
    Text = [[
You recognized that the song was adapted from a love song.
At the end of that love song, the poet said:
"Until the voice of humanity awakens us, we shall drown."
Not right now, you thought.
You are still waiting for humanity to awaken you.]]
  },
  Event_7189_Name = {
    Text = "Crows' Chorus"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7190_Desc = {
    Text = [[
A dusty film reel. However, there is no projector in this room, and it's not the time to leisurely enjoy the manor, the film, and afternoon tea.
Perhaps it will be a long time before you have the chance to discover what's on the reel.]]
  },
  Event_7190_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Adv. Orisons, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7191_Desc = {
    Text = [[
You follow the boy, neither too close nor too far.
Tap. Tap. Tap... The boy stops at the street corner.
You notice a flickering red light behind him, and your instinct tells you that the wax museum lies ahead.
The boy turns around. He has no eyes, only dark sockets.
He smiles at you.]]
  },
  Event_7191_Name = {Text = "Finale I"},
  Event_7192_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7192_Desc = {
    Text = [[

You patted his shoulder.
The boy turned around. He had no eyes, just dark sockets.
"Good evening. I'm looking for the way to the wax museum."
The boy pointed ahead. You saw the red glow swaying precariously behind him.
Your instinct told you the wax museum was right there.
When you came to your senses, the boy had already left, leaving only the shadow cast by the street lamp.]]
  },
  Event_7192_Name = {Text = "Finale I"},
  Event_7193_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Receive 35 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_7193_Desc = {
    Text = "The solitary crow, with a hoarse voice, plucks its black feathers one by one.\nIt trembles in pain, crying out sharply, yet it cannot stop its increasingly frantic pace.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze flow from its eyes, witnessed only by you."
  },
  Event_7193_Name = {
    Text = "Molten Tear"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7194_Desc = {
    Text = "Priceless knowledge floods your mind, then turns into mist... When you come to, the strange yellow-covered book has vanished..."
  },
  Event_7194_Name = {
    Text = "Yellow Tome"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7195_Desc = {
    Text = [[
You easily defeated the wax sculptures. They slump before you.
There seem to be a few lines of text inscribed at the base.
"A.F. @2, November
Made by Rogers at @2 College"
You recall that Rogers studied sculpture at an art school. These clumsy wax sculptures must be his student works.]]
  },
  Event_7195_Name = {Text = "Draft"},
  Event_7196_ChoiceDesc1 = {Text = "[Why?]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[Descend into the Deep Sea]"
  },
  Event_7196_Desc = {
    Text = [[

"Impostor! Give me back my son!"
"Aren't you the Blessed Maiden of the Ark? Isn't it your duty to protect the Ark? Why did only one ship return? Tell me, tell me!"
"Drown her! She must endure the same suffering my father faced before he died!"
"Drown her, drown her!"
"Drown this impostor! Tie her to a stone!"
As seawater rushed into her mouth and nose, forcing the air out from every corner of her lungs, she still wore that luxurious and immaculate white dress.
Almost the first thought after becoming a Blessed Maiden emerged from the darkest recesses of her mind, arriving belatedly.
"Yes, why did those ships sink?"]]
  },
  Event_7196_Name = {
    Text = "Drowned Sea"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Receive 30 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_7197_Desc = {
    Text = "The solitary crow, with a hoarse voice, plucks its black feathers one by one.\nIt trembles in pain, crying out sharply, yet it cannot stop its increasingly frantic pace.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze flow from its eyes, witnessed only by you."
  },
  Event_7197_Name = {
    Text = "Molten Tear"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7198_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7198_Desc = {
    Text = "It feels as if a pair of strong, steady hands have rested on your shoulders, but when you turn to look, the once tangible touch becomes elusive."
  },
  Event_7198_Name = {
    Text = "Anomalous Contact"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7199_Desc = {
    Text = "Ryelway bridge, Londinium's blood and nerves, linking the heart and limbs of the city. The Rye Sanatorium is quietly waiting at the tip of the limbs, ready for the delivery of blood and signals."
  },
  Event_7199_Name = {
    Text = "Ironway Mirage"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7200_Desc = {
    Text = [[
You stomp on the suitcase on the ground until it stopped trembling, then pick it up again.
After brushing off the dust, you continue forward under Murphy's puzzled gaze.]]
  },
  Event_7200_Name = {
    Text = "Unwelcome Missive"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7201_Desc = {
    Text = "Danger lurks behind a wooden door; it's not a place to linger. Pack it into your suitcase."
  },
  Event_7201_Name = {
    Text = "Yellow Tome"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7202_Desc = {
    Text = "It, or rather they, hover in the bedroom, crashing into the lampshade with a clatter."
  },
  Event_7202_Name = {
    Text = "Lantern-Crow"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7203_Desc = {
    Text = [[
This is the Dimension of Spirit, the world of Gnosis.
They can do nothing but mess with your mind.]]
  },
  Event_7203_Name = {
    Text = "Gnosis Tempest"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7204_Desc = {
    Text = [[
Skull: Hank Tillinghast A.F.186-A.F.203 Creole Island
Spine: Andy Crawford A.F.177-A.F.203 Narragansett
..Can't think too much about it.]]
  },
  Event_7204_Name = {Text = "Nameplate"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Check Fragment] Destroy 1 of 3 Command Cards, and receive 75 Black Sigils."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Ask Doll] Duplicate 1 of 3 Command Cards, and receive 25 Black Sigils."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Disregard] Receive 50 Black Sigils"
  },
  Event_7205_Desc = {
    Text = "The metal fragment Doll gave you quivers uneasily in your chest, like a disturbed butterfly."
  },
  Event_7205_Name = {
    Text = "Unsettling Brooch"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7206_Desc = {
    Text = "\"He waits quietly at the finish line, no matter where you set the end point—look at that young warden; her avoidance ultimately leads to madness.\""
  },
  Event_7206_Name = {Text = "The Sought"},
  Event_7207_ChoiceDesc1 = {
    Text = "[Leave] Nothing found"
  },
  Event_7207_Desc = {
    Text = "In Development, Special Event"
  },
  Event_7207_Name = {
    Text = "2_16 Temporary"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Comfort It] Increase Max HP by Arg1"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Ignore It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards, but develop \"(Skill.Arg2)\" twice."
  },
  Event_7208_Desc = {
    Text = [[
The Link warms the heart that still retains its human nature.
The heart mimics the breathing rhythm at the other end, as if doing so could save it from being abandoned, granting it the right to eternal companionship with the Link.]]
  },
  Event_7208_Name = {
    Text = "Left Atrium"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Random Adv. Orison"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7210_Desc = {
    Text = "Your coldness leaves the voice's owner feeling regretful, as the water lazily ripples and then returns to stillness."
  },
  Event_7210_Name = {
    Text = "Voices from Beyond"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Test Orison"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Test Drop Pack"
  },
  Event_7211_Desc = {
    Text = "Test the specified Orison"
  },
  Event_7211_Name = {
    Text = "Designated Orison Test 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Rouse an Awakener"
  },
  Event_7212_Desc = {
    Text = "You gently patted the boy's head, guiding him to recite along with you.\n\"A Song for Mom—\"\nThe voices, like moths in the night, drifted side by side from the empty stage,\nsoftly landing in the pitch-black audience."
  },
  Event_7212_Name = {Text = "Finale III"},
  Event_7213_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7213_Desc = {
    Text = [[
You remained calm and composed. A noblewoman suddenly rushed onto the stage.
She frantically pried open the boy's mouth and violently shoved a stick into it.
"Speak, talk to me."
Black blood flowed from the boy's mouth. He mumbled on.
"A song for mom..."]]
  },
  Event_7213_Name = {Text = "Finale III"},
  Event_7215_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7215_Desc = {
    Text = [[
That's not a window, it's a mirror. Ramona's tense face is reflected in it.
Why are there no windows in this room, only a huge mirror hanging on the wall?]]
  },
  Event_7215_Name = {
    Text = "Window's Reflection"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7216_Desc = {
    Text = [[

You were torn apart by a surge of absurdity, your limbs contorted as you crawled on the ground, seemingly manipulated by something from beyond the dimension @2.
"No... no..."
Your sanity crumbled bit by bit, delirious laughter and screams intertwining like a giant web that bound your consciousness, leaving only indistinct moans spilling from your lips.]]
  },
  Event_7216_Name = {
    Text = "Watcher's Gaze"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7217_Desc = {
    Text = "The colors of the galaxy shift, forming indescribable patterns at your feet. They are as beautiful as rubies, yet bloated like jellyfish. A red glow emanates from the suitcase..."
  },
  Event_7217_Name = {
    Text = "Stellar Crossroad"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Increase Stress by 10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7218_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_7218_Name = {Text = "Illusion"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Catch] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Look Down] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7221_Desc = {
    Text = [[
Crows hovered in the sky, segmented like building blocks by the alleyways, their hoarse cries unsettling.
Suddenly, the flock became agitated, as if a morbid instinct had been twisted or awakened. They viciously attacked and chased each other, something falling amidst the chaos.]]
  },
  Event_7221_Name = {
    Text = "Frenzied Murder"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Increase Max HP by Arg1"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7222_Desc = {
    Text = "You attempt to use the tracing power of the Silver Key to locate the nearest Junction, but the information you receive contains subtle anomalies, as if it has been interfered with."
  },
  Event_7222_Name = {
    Text = "Anomalous Contact"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Give It to Doll] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Read the Nameplate] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7223_Desc = {
    Text = "From the defeated experiment of the Sculptors' Association, a metal-framed nameplate dropped. The Silver Key senses it and glows slightly."
  },
  Event_7223_Name = {Text = "Nameplate"},
  Event_7224_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7224_Desc = {
    Text = [[
The blade-wielder lets out a long howl, like a sound that could cleave through mountains and seas.
The sound vanishes instantly, and the other two Seafarers also disappear... It turns out it was merely an Illusion reflected by the Domain.]]
  },
  Event_7224_Name = {
    Text = "Relentless Hunt"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Choose a card and reduce its Arithmetica Cost by 1"
  },
  Event_7225_Desc = {
    Text = [[
Holding a candle, you walk through the misty fog to her.
She is an unfinished wax sculpture.
Her delicate face is split in two, one half smiling, the other half @1.
Become her god.
Grant her beauty, grant her tears.
Sculpt her or destroy her.]]
  },
  Event_7225_Name = {
    Text = "Unfinished Wax Sculpture"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7226_Desc = {
    Text = [[
"Of course, I have witnessed extinction with my own eyes."You replied.
Yes, it was merely the violent death of a little mouse, the rotting of a heart, and a bouquet of irises immersed in the night's funeral.]]
  },
  Event_7226_Name = {
    Text = "Lost Pantheon"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7227_Desc = {
    Text = [[
"the Divine Realm... demise... illusory topics... I don't know what counts as demise."
The two figures chuckle softly, surrounded by white shimmering light fragments.
"Then now, you will witness true demise."]]
  },
  Event_7227_Name = {
    Text = "Lost Pantheon"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Combine Pages] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Read] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Discard It] Receive 50 Black Sigils"
  },
  Event_7228_Desc = {
    Text = [[
A yellowed page fell from the Lightbearer Devotee's robe.
Covered with strange text, some like hieroglyphs, some oddly slanted, some overlapping. Only a few words could barely be made out.
Titled "The Birth of @2 Divus"]]
  },
  Event_7228_Name = {
    Text = "Cipher-Edict: Part II"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Struggle] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Wallow] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7229_Desc = {
    Text = [[
"I'm in such pain, so much pain..."
"Why me? Why must I endure this?"
"Merciful Father, what have I done wrong?"
Sorrow, pain, anger, frustration... drowning in empathy, the emotions of these "patients" weigh heavily on you. Clutching your chest, you find it difficult to breathe.]]
  },
  Event_7229_Name = {Text = "Indulgence"},
  Event_7230_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7230_Desc = {
    Text = [[
The gaze pierces through flesh, branding the trailblazer's retina.
No one can escape, just as no one@2]]
  },
  Event_7230_Name = {Text = "Peek"},
  Event_7231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7231_Desc = {
    Text = [[
Focus your mind, identify the lyrics, and then feel the chaotic words slam into the back of your head.
These are words beyond human comprehension.]]
  },
  Event_7231_Name = {Text = "Sea Shanty"},
  Event_7232_ChoiceDesc1 = {
    Text = "[Initiate Trial] Develop \"(Skill.Arg1)\"; Win a Golden Relic if victorious, or 50 Black Sigils upon failure."
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7232_Desc = {
    Text = [[
You've caught a glimpse of some secrets from the mirror-like black sludge beneath your feet.
Its reflection is hazy, enveloped in an unyielding dark mist. It feels strangely familiar, yet you can't quite make out what it is.]]
  },
  Event_7232_Name = {
    Text = "Under-Mirror"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7233_Desc = {
    Text = "You dismiss the mysterious anonymous letter and casually burn it to ashes."
  },
  Event_7233_Name = {
    Text = "Another Distress Letter"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7234_Desc = {
    Text = "You examine the letter itself. The seal is coated with a sticky liquid, seemingly a mixture of blood and black ooze, with a few strands of hair stuck to it."
  },
  Event_7234_Name = {
    Text = "Another Distress Letter"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7235_Desc = {
    Text = "Follow the direction where the letter drifted. At the corner of the wall, you catch a glimpse of something shiny."
  },
  Event_7235_Name = {
    Text = "Another Distress Letter"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7236_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7236_Desc = {
    Text = "A faint light appeared, bright and warm. However, it suddenly vanished just as you tried to follow it."
  },
  Event_7236_Name = {
    Text = "Anomalous Contact"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Increase all Awakeners' Aliemus by Arg1"
  },
  Event_7237_Desc = {
    Text = [[
You tightly close your eyes in fear.
"You lifted the cover...
Secrets, you have uncovered secrets..."
The waves of sound form a roaring ocean, and the floor shakes violently in a terrifying resonance.
Unable to bear it any longer, you abruptly open your eyes, only to find nothing around you.]]
  },
  Event_7237_Name = {Text = "Finale V"},
  Event_7238_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7238_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7238_Desc = {
    Text = "The tip of your nose catches a familiar scent, homely and satisfying. Just as you try to take another sniff of the cafeteria aroma, it vanishes completely."
  },
  Event_7238_Name = {
    Text = "Anomalous Contact"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7239_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7239_Desc = {
    Text = "A familiar voice whispered in my ear, warm and comforting. But when I tried to follow it, the sound abruptly stopped."
  },
  Event_7239_Name = {
    Text = "Anomalous Contact"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7240_Desc = {
    Text = "The power of retrospection cannot find another Junction for you in the short term, but at least you feel some Temporary relief."
  },
  Event_7240_Name = {
    Text = "Anomalous Contact"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7241_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7241_Desc = {
    Text = "It feels as if a pair of strong, steady hands have rested on your shoulders, but when you turn to look, the once tangible touch becomes elusive."
  },
  Event_7241_Name = {
    Text = "Anomalous Contact"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7242_Desc = {
    Text = [[
"N"'s shadow is dispersed by the punch, black particles merging with the Domain fog, tricky to trace.
"Not fun, yet intriguing. I'll eagerly await our true meeting..."]]
  },
  Event_7242_Name = {Text = "Showtime"},
  Event_7243_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7243_Desc = {
    Text = [[

"Good child. But still, I have to give you a little punishment."
Daffodil's light laughter faded in the dimensional rift.]]
  },
  Event_7243_Name = {Text = "Hint Time"},
  Event_7244_ChoiceDesc1 = {
    Text = "[Silver Chip] 50% chance to acquire the Golden Relic \"(RelicConfig.Arg2)\", 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Red Chip] 50% chance to receive 75 Black Sigils, 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Black Chip] 50% chance to acquire the Cursed Relic \"(RelicConfig.Arg2)\", 50% chance to develop \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = [[
Good... good...
Now, choose the chip you desire.]]
  },
  Event_7244_Name = {Text = "Showtime"},
  Event_7245_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7245_Desc = {
    Text = "\"Alright, alright. That guy always had a thing for interdimensional creatures. It took me quite some effort to freely navigate through these dimensional rifts. Ah, that must have been 3,000 years ago.\""
  },
  Event_7245_Name = {Text = "Hint Time"},
  Event_7246_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7246_Desc = {
    Text = "Let's hope trust the research director won't install a bomb on your chest."
  },
  Event_7246_Name = {
    Text = "Unsettling Brooch"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Leave] Destroy a Command Card and receive 25 Black Sigils."
  },
  Event_7247_Desc = {
    Text = [[
"A kind stranger, offering guidance to the lost," he smirked, "Travel light. Cerberus awaits."
The device in his hand suddenly vibrated.]]
  },
  Event_7247_Name = {
    Text = "Uncanny Companion III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Move Slowly] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Lie Down] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7248_Desc = {
    Text = [[
"When encountering swamps, never struggle."
You keep this survival rule in mind, standing as still as an Easter Island statue.
Five minutes, ten minutes, an hour... the black mud finally lost patience and disappeared from beneath your feet.]]
  },
  Event_7248_Name = {
    Text = "Gloomslough"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7249_Desc = {
    Text = "You notice an unusual hand. It is delicate, pale, and has remained calm all along.\nMore importantly—you recognize it as your own hand.\nYou gently grasp it.\nThe hand grips back. You feel a bone-chilling cold and an illusion, and then the swamp vanishes."
  },
  Event_7249_Name = {
    Text = "Gloomslough"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cut Off Hand] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Soothe Them] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7250_Desc = {
    Text = [[
You swing your blade, cutting them down one by one.
Blood splatters onto your body, face, and hair, but you remain oblivious.
Countless hands scream in agony, and the swamp vanishes.
It takes a week for the cries to stop haunting your nightmares.]]
  },
  Event_7250_Name = {
    Text = "Gloomslough"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Pick up the Silver Core] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Attempt Awakening] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignore] Receive 25 Black Sigils"
  },
  Event_7251_Desc = {
    Text = [[
Beneath the loose deck plank, filthy black sludge oozes out.
Amidst the sludge, the familiar gleam of a "Silver Core" catches your eye.]]
  },
  Event_7251_Name = {
    Text = "Proof of Being"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[The Rat] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[The Candle] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7252_Desc = {
    Text = [[
The Dissolute dissipates before you. From it, black ashes coalesce in the mist to form a strange pair of scales. On one side, a rat lies in sleep. On the other sits a small candle, carved into the shape of a young boy.
You instinctively know that you must make a choice.]]
  },
  Event_7252_Name = {
    Text = "Reason and Passion"
  },
  Event_7253_ChoiceDesc1 = {Text = "[Call Out]"},
  Event_7253_ChoiceDesc2 = {
    Text = "[Check Carefully]"
  },
  Event_7253_Desc = {
    Text = [[
As you turn a corner, your surroundings become increasingly blurry, yet the fearsome roars remain clear.
Footsteps echo, and when you turn around, you can vaguely make out a strange figure; its humanoid shape stands as a person would, but behind them lies a pair of shadows reminiscent of the wings of a gigantic moth.
"Be careful," Ramona whispers, "In a Domain, what you may see isn't necessarily real. If you aren't careful, you may put yourself in danger."]]
  },
  Event_7253_Name = {
    Text = "Mist-Shrouded Figure"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7254_Desc = {
    Text = [[
You take out the Silver Key, holding it with sorrow and reverence. A faint, mist-like glow envelops you.
In the silence, only a sigh lingers.]]
  },
  Event_7254_Name = {
    Text = "Watcher's Gaze"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Choose Silver River] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Choose Rainbow Path] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7255_Desc = {
    Text = [[
Thump, thump, thump.
Your heart pounds like a drum, your mouth is dry, and a gaze from above pierces through your spine into your chest.
A fork in the road appears before you: one path flows with a starry river, the other shimmers with a rainbow glow.]]
  },
  Event_7255_Name = {
    Text = "Stellar Crossroad"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7256_Desc = {
    Text = [[
Lingering gazes continue to watch you, as the cells beneath your skin scream and flee, your veins writhing like worms.
You feel a flow of power surging, bursting amidst the grotesque state of your limbs]]
  },
  Event_7256_Name = {
    Text = "Watcher's Gaze"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7257_Desc = {
    Text = [[

"No, this isn't true. Compared to cockroaches, at least you have furry bodies.
No one can resist a furry body."
The mice whispered among themselves and eventually agreed with your point.
"Well, it's not like there's that much fur."
Being complimented is always pleasant. Before leaving, the mice gave you a small gift]]
  },
  Event_7257_Name = {Text = "Plague"},
  Event_7258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7258_Desc = {
    Text = [[
"I agree! Humans and rats cannot coexist!"
The rats looked a bit angry, baring their white fangs.
"Then why are you still here? Take your things and never come back."]]
  },
  Event_7258_Name = {Text = "Plague"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7259_Desc = {
    Text = [[
An eerie fluttering sound lingers around you. In a daze, you see Rogers holding the doll George, lying on the treatment bed with bloodstained hands.
You open your eyes and realize Clementine is nowhere to be found.
By the time you awake, Clementine is long gone.]]
  },
  Event_7259_Name = {
    Text = "Hypnotherapy"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Unlock] Use the key."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7260_Desc = {
    Text = "A door blocks your way. You've tried every method, yet it remains firmly in place."
  },
  Event_7260_Name = {
    Text = "Rusted Door"
  },
  Event_7260_Tips1 = {
    Text = "You need to find the \"Rusted Key\"."
  },
  Event_7261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7261_Desc = {
    Text = "You look toward what you believe to be the source of the gaze. The workshop's ceiling suddenly feels distant, and the stacked shadows of a massive pupil loom overhead. Though only partially meeting your gaze, you still feel an immense pressure."
  },
  Event_7261_Name = {
    Text = "Whose Gaze?"
  },
  Event_7262_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7262_Desc = {
    Text = "The black cat cautiously approaches and vomits a dark mass into your palm."
  },
  Event_7262_Name = {
    Text = "Nightcat's Bane"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7263_Desc = {
    Text = "\"A smart choice. When facing a formidable foe, knowing yourself and your enemy is essential, right? But beware—learning too much about the secrets of dimensions may unsettle your mind.\"\n\"That guy can't stop obsessing over inter-dimensional beings. It took me ages to move freely through these dimensional rifts. Ah, that was 3,000 years ago.\""
  },
  Event_7263_Name = {Text = "Hint Time"},
  Event_7264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7264_Desc = {
    Text = [[
"Meow, meow meow, meow meow meow..."
You strained your voice, trying hard to appear weak and harmless.
"Meow! Meow meow! Meow meow meow!"
The group of cats seemed to accept your goodwill, responding with cheerful calls. Your cries echoed back and forth, day and night without pause, even scaring the moon into hiding behind the clouds.]]
  },
  Event_7264_Name = {
    Text = "City of Cats"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7265_Desc = {
    Text = [[
You force the crow's beak away from plucking its feathers, but it relentlessly twists back, its strength making your bones creak.
Your face flushes red as you exert all your strength to restrain the crow's body, halting its frenzied self-mutilation.
Just as you breathe a sigh of relief, the crow's half-bald neck snaps back sharply, its body going limp and transforming into a pool of black sludge in your hands.]]
  },
  Event_7265_Name = {
    Text = "Molten Tear"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Receive 20 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_7266_Desc = {
    Text = "The solitary crow, with a hoarse voice, plucks its black feathers one by one.\nIt trembles in pain, crying out sharply, yet it cannot stop its increasingly frantic pace.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze flow from its eyes, witnessed only by you."
  },
  Event_7266_Name = {
    Text = "Molten Tear"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7267_Desc = {
    Text = [[
The crow tears at its feathers, much like humans gnaw at their own bodies.
In this world of fear, such scenes are common. You can't save all living beings.]]
  },
  Event_7267_Name = {
    Text = "Molten Tear"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7268_Desc = {
    Text = "\"I'll return with the students.\" The girl tugged at the Awakener's skirt, resolute, \"Take care... don't fall into the sea.\""
  },
  Event_7268_Name = {
    Text = "Divine Maiden's Vigil"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7269_Desc = {
    Text = "Haha, black, my favorite. Chaos, confusion, pain... You should have realized by now—black is never a good omen.\nSo, what is your next choice?"
  },
  Event_7269_Name = {Text = "Showtime"},
  Event_7270_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Receive 25 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Ignore It] Leave"
  },
  Event_7270_Desc = {
    Text = "The solitary crow, with a hoarse voice, plucks its black feathers one by one.\nIt trembles in pain, crying out sharply, yet it cannot stop its increasingly frantic pace.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze flow from its eyes, witnessed only by you."
  },
  Event_7270_Name = {
    Text = "Molten Tear"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7271_Desc = {
    Text = [[
That was the deep part of the cabin, long-neglected, poorly lit, and without guidance.
The girl would set off with the blessing of the ship's saint, as per their agreement.]]
  },
  Event_7271_Name = {
    Text = "Divine Maiden's Vigil"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Chase the Song] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Sing Along] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_7272_Desc = {
    Text = [[
The distant song shatters into stardust:
"I curse the filthy puddle in the night alley, the decayed flowers clinging to the crumbling wall, chains wrapping around the brain as it sinks into the mire. Before the fog erases my existence, dusk will descend into the deepest @3."]]
  },
  Event_7272_Name = {
    Text = "Pallid Curse"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Chase the Song] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7273_Desc = {
    Text = [[
The distant song shatters into stardust:
"I curse the filthy puddle in the night alley, decayed flowers cling to the crumbling wall, chains entangle the brain sinking into the mire. Before the fog erases my existence, dusk will sink into the deepest @4."]]
  },
  Event_7273_Name = {
    Text = "Pallid Curse"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7274_Desc = {
    Text = "The Silver Core did not respond to your Awakening, but emitted a warm aura."
  },
  Event_7274_Name = {
    Text = "Lonely Silver Core"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7275_Desc = {
    Text = "A swirling black mist creeps up your spine until you collapse to the ground, repeating this phrase over and over."
  },
  Event_7275_Name = {Text = "Unseeable"},
  Event_7276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7276_Desc = {
    Text = [[
Yes, the vitreous humor slowly flowing from your pupils is proof of your taboo-induced corruption.
Honesty, at this moment, stands in opposition to virtue.]]
  },
  Event_7276_Name = {Text = "Unseeable"},
  Event_7277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7277_Desc = {
    Text = "The ancient coin is sticky and wet, as if covered in filthy residue, emitting visible black fumes."
  },
  Event_7277_Name = {
    Text = "Two-Faced Relic"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7278_Desc = {
    Text = [[
Your sharp nerve endings send a fatal warning. You recoil abruptly, reluctantly pulling back.
Once again, you narrowly escape...
A curse? Or perhaps a rebirth?]]
  },
  Event_7278_Name = {
    Text = "Two-Faced Relic"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Release Butterfly] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Become a Butterfly] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Swallow Back] Receive 25 Black Sigils"
  },
  Event_7279_Desc = {
    Text = "So much happened this night.\nThe dock assault, the ghost freighter, the Seafarer, Tulu, Murphy, Ramona... everything swirling in a vortex, churned into the 7 A.M. oatmeal at Mythag's restaurant.\nYou want to ask the Awakener in front of you but didn't know how to start, feeling a lump in your throat—or butterflies in your stomach."
  },
  Event_7279_Name = {
    Text = "The Butterfly Effect"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Lose Arg3 HP"
  },
  Event_7280_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7280_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_7280_Name = {Text = "Illusion"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Join the Prayer] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Sink into Ocean] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surface] Receive 25 Black Sigils"
  },
  Event_7281_Desc = {
    Text = [[
"Gentle God, Almighty God.
Please calm the fierce storm and block the raging currents.
Let the ocean become our profound home, shrouding our kingdom in an eternal veil..."
The whispers of the devout finally form words you can understand, but with them comes an inescapable suffocation.]]
  },
  Event_7281_Name = {
    Text = "Dream Prayer"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7282_Desc = {
    Text = [[
You toss the remaining chunks of meat into the swarm of cats.
The cats surge forward like a black tide, frantically tearing at the meat before quickly scattering.
Unfortunately, the meat is expired. It fills their empty stomachs but brings little satisfaction.]]
  },
  Event_7282_Name = {
    Text = "City of Cats"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7283_Desc = {
    Text = "A near-mercury-like silver substance, refined from D-Slime, containing strong mental power, used to link more Awakeners in rituals."
  },
  Event_7283_Name = {Text = "Silver"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Leave] Rouse an Awakener, reduce that Card's Arithmetica Cost by 2, but develop \"(Skill.Arg1)\"."
  },
  Event_7284_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7284_Desc = {
    Text = "They may not hear you now, but eventually, they will hear your call."
  },
  Event_7284_Name = {
    Text = "Guiding Voice"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7285_Desc = {
    Text = "Psyche Deepdive test subjects have worn you out, and even a brief moment of respite feels like rain in a desert."
  },
  Event_7285_Name = {
    Text = "Endless Doors"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Leave] Rouse a random Awakener"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7286_Desc = {
    Text = "That voice will surely guide you to your destination, the answer to this investigation."
  },
  Event_7286_Name = {
    Text = "Guiding Voice"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7287_Desc = {
    Text = "Through the crystal ball, you can observe distant places."
  },
  Event_7287_Name = {
    Text = "Crystal Orb"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7288_Desc = {
    Text = "The crow perches on the wardrobe, its sharp beak carving eerie patterns on the wooden door."
  },
  Event_7288_Name = {
    Text = "Lantern-Crow"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7289_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_7289_Name = {Text = "Junction"},
  Event_7290_ChoiceDesc1 = {
    Text = "[Stay Here] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Find the Exit] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7290_Desc = {
    Text = [[
You stepped into an eerie silence, with the overlapping doors spinning uncontrollably, pulling your body into the vortex.
Dizzy and disoriented, you struggled within the inverted doors, barely making out the way out, yet inevitably falling into another door over and over again.
This time, you halted before a door, the unknown behind it exuding a fatal allure, tightening the strings of your sanity.
Indeed, it is deadly.]]
  },
  Event_7290_Name = {
    Text = "Beyond the Gate"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Ecstasy] Destroy a Command Card and recover Arg1 HP"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Stop] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7291_Desc = {
    Text = [[
It's as if your skull has been effortlessly pried open, flooding your brain with a wave of nausea-inducing dizziness. An invisible hand stirs and churns your mind, turning the already fluid-like substance into mush.
Like undigested, porridge-like stomach contents, it defies gravity and pours into your hollow, barren cerebral cortex.
It kneads, mixes, and claws, sprinkling fragments of joy and blending the remnants of the sunset into your flesh.]]
  },
  Event_7291_Name = {
    Text = "Mind Agitation"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7292_Desc = {
    Text = "Compared to the sudden appearance of Hellhounds, common snowfall isn't worth your attention. Ignoring the gradually falling snowflakes, you dash into the night."
  },
  Event_7292_Name = {Text = "Snow"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP."
  },
  Event_7293_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_7293_Name = {Text = "Junction"},
  Event_7294_ChoiceDesc1 = {
    Text = "[Feel Fear] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Steadfast Will] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7294_Desc = {
    Text = "Eerie wails echo, but Londinium remains silent, as if dead or asleep.\nYou wander under the railway bridge, recalling Alistair's advice.\nHe approaches politely, attempting to speak, but his words are muddled.\nYou look up—black viscous fluid spills from his mouth, choking his speech—"
  },
  Event_7294_Name = {Text = "Chaos Howl"},
  Event_7295_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_7295_Desc = {
    Text = [[
"Of course, of course. If you don't mind, I can lend you a hand."
He hands you an ancient handheld mirror.
"The knight has already taken the board, and the king won't be far behind. You'll likely encounter him soon. Truly exciting, isn't it?"]]
  },
  Event_7295_Name = {
    Text = "Uncanny Companion IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Shred the Letter] Destroy any 2 Cards"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continue Reading] Obtain Cursed Relic \"(RelicConfig.Arg1)\", infect \"(Skill.Arg2)\"."
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_7296_Desc = {
    Text = [[
Before your eyes, a swarm of black butterflies bursts forth, continuously spilling out, flapping their wings, and falling onto the desk.
The unfolded blank letter paper is splattered with ink, with the injured butterflies lying on its surface, barely alive.
The black sticky fluid on their wings forms taboo words as it smears across the page.
You pull this sheet from the typewriter.]]
  },
  Event_7296_Name = {
    Text = "Butterfly Chapter"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Go to the Butterflies] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7297_Desc = {
    Text = [[
A recent saying in Londinium goes: "The flutter of a butterfly in Yakutsk may cause a storm in the Kingdom of Leonia."
When you see the butterflies surge forth, you can't help but remember this saying.
These butterflies may be enough to stir a disaster that could engulf the planet.]]
  },
  Event_7297_Name = {
    Text = "Gnosis Tempest"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7298_Desc = {
    Text = [[
You place a finger to your lips, signaling silence.
The black cat flashes by like a phantasm, leaving a dark gift at your feet.]]
  },
  Event_7298_Name = {
    Text = "Nightcat's Bane"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7299_Desc = {
    Text = [[
It slid into your bag like a piece of silk, the slight increase in weight barely noticeable, as if whispering a soft word of thanks.
After that, all was silent.]]
  },
  Event_7299_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7300_Desc = {
    Text = [[
The Spirit of Chaos's cries grew sharper, eventually turning into a piercing scream that echoed all around.
With your offerings and inescapable sorrow, It sank back into the mire.]]
  },
  Event_7300_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Doodle Randomly]"
  },
  Event_7301_Desc = {
    Text = [[
The streets of the East District are intricate and complex, and you soon lose sight of the children.
Just when you begin to lose hope, a mysterious woman approaches you.
"I know where the children have gone, but before I tell you, could you do me a small favor?"
She pulls out a piece of paper and smiles at you kindly.
"My name is Clementine. I am a psychologist conducting a psychological investigation on the residents of Londinium. If you could simply fill out this questionnaire,
I would be more than happy to provide you and your companions with some assistance."]]
  },
  Event_7301_Name = {
    Text = "Psyche Appraisal"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7302_Desc = {
    Text = [[
"This, too, was my decision," says the figure holding candies. "But she will become his pawn, and you will be forced to make a choice eventually.
There are no perfect endings in this world."
Profound sorrow overwhelms you. The silhouettes vanish, leaving you clutching your chest, unsure if it was a projection or a phantasm brought on by mental stress.]]
  },
  Event_7302_Name = {
    Text = "Forking Trails"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Golden Axe]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7303_Desc = {
    Text = [[
"O Pioneer of Dimension Crossing."
An ancient voice echoes in your ears, as if from prehistory, transcending the ages.
In extreme tension, you hear the voice ask a somewhat familiar question.
"Is this the golden axe you dropped, or is it this silver one?"]]
  },
  Event_7303_Name = {
    Text = "Voices from Beyond"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7304_Desc = {
    Text = [[
"Oh, this..." She takes back the questionnaire with a somewhat befuddled expression. "Oh well, you're in a hurry after all. The children went that way, shouldn't be too far."
You quickly turn and dash, nearly missing the whisper behind you.
"No matter, we will meet again."]]
  },
  Event_7304_Name = {
    Text = "Psyche Appraisal"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7305_Desc = {
    Text = [[

"Who are you?"
"I am the shadow of the Silver Key bearer who was tragically murdered. The murderer is a cunning albino snake."
"Albino snake? What is that?"
"An error. A blasphemy born of the mixing of human and snake..."
You want to continue asking, but the shadow suddenly dissipates, leaving behind a ground covered in golden dust.]]
  },
  Event_7305_Name = {
    Text = "Silver Key Bearer"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7306_Desc = {
    Text = "Event 355 (In Development), Non-Final Effect"
  },
  Event_7306_Name = {
    Text = "Event 355 (In Development)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7307_Desc = {
    Text = [[
Sink into the stomach, dancing with butterflies.
The scales of thought interwoven with butterflies drift down like a gentle snow inside.
You gradually piece everything together and will speak up when the next opportunity arises.]]
  },
  Event_7307_Name = {
    Text = "The Butterfly Effect"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Refute Them] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Follow them] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Propose New Idea] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7308_Desc = {
    Text = "\n\"Please keep your distance from us.\"\nA swarm of rats surrounded you, maintaining at least five feet of distance.\n\"We strive to multiply, we thrive; we are not picky eaters—thus we bring diseases, anxiety, and suffering to humanity.\"\n\"We should not get too close to humans; this is not a place for you.\"\nTo make the rats let down their guard, you decided—"
  },
  Event_7308_Name = {Text = "Plague"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Open Iron Door] Acquire the Golden Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignore] Receive 50 Black Sigils"
  },
  Event_7309_Desc = {
    Text = [[
This is a typical under-deck arch bridge. Stairs beside the tracks lead to an iron door. Behind it, you hear a rhythmic and unusual clanking sound.
You stop to observe the door, noticing a heavy padlock hanging on it, but it is not locked.]]
  },
  Event_7309_Name = {
    Text = "Behind Iron Gates"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7310_Desc = {
    Text = [[
Resisting temptation, you remain unmoved.
The owner of the voice seems disappointed, causing a few ripples to spread across the water's surface, and then all is calm again.]]
  },
  Event_7310_Name = {
    Text = "Voices from Beyond"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7311_Desc = {
    Text = "Event 353 (Under Development), Not Final Effect"
  },
  Event_7311_Name = {
    Text = "Event 353 (In Development)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils, but develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7312_Desc = {
    Text = [[
"Do you humans have no other answers?"
The owner of the voice let out an impatient growl, shaking the entire space.
"Greedy and ignorant... This is why I am tired of you."]]
  },
  Event_7312_Name = {
    Text = "Voices from Beyond"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7313_Desc = {
    Text = "Accept the Domain's arrangement, gain in loss, and embrace the cursed gift."
  },
  Event_7313_Name = {
    Text = "Delusion Surge"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7314_Desc = {
    Text = "The eyes blink slowly, unsure if they had understood your question.\nA single, golden-red tear drops from the corner of the eye, like a tiny star radiating warm sunlight. Its fall carries sadness and pity, until it shatters to dust on the bricks.\nYou snap back to reality—the eyes are gone."
  },
  Event_7314_Name = {
    Text = "Blind Stare"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7315_Desc = {
    Text = "A few simply dressed, even somewhat dirty children are running down the street, chased by an adult in a police uniform. One of the children is wearing a brown hood that looks somewhat familiar."
  },
  Event_7315_Name = {
    Text = "Our Memories"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7316_Desc = {
    Text = "\"Stop singing—\"\nYou warn the tone-deaf singer, refusing to let them torture your ears any further."
  },
  Event_7316_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7317_Desc = {
    Text = [[

"Stop right there!!! Even the dissolving monster that crawls on its belly knows its own limbs better than you!"
Let go of the audience...
You pray this in your heart]]
  },
  Event_7317_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7318_Desc = {
    Text = [[
Black sludge drips onto your face, causing a tingling itch.
Unable to bear it, you swipe at the butterfly.
The butterfly evades your hostile action and silently vanishes into the distance.]]
  },
  Event_7318_Name = {
    Text = "That Which Should Not Be"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Praise It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7319_Desc = {
    Text = "Jenkin said: \"Wake up, Johnny! Writing poems won't pay your debts or fix your leaky floor.\"\nYou said: \"Unfortunately, your truth-seeking cells will die off at a rate of one million per day. Soon, you'll be nothing but a brain stem.\"\nThe brain shrugged indifferently—if it could.\nThe brain said: \"I think, therefore I am. Once you reach my level of thought, you won't care about brain stems anymore.\""
  },
  Event_7319_Name = {
    Text = "Philosopher's Brain"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7320_Desc = {
    Text = [[
The piano lets out a soft sigh, lingering but comforting, resembling the smile of someone at the end of their melody.
"So long as the children... so long..."
Before you could make out the words clearly, the piano's phantasm vanished with the wind.]]
  },
  Event_7320_Name = {
    Text = "Nursery Rhyme"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7321_Desc = {
    Text = [[

You take the thick medical record and open it to find "G. R." on the title page.
"Oh dear, oh dear, this isn't your record, is it?" Clementine says, entirely unbothered. "No matter, studying the psyche of others can be good for one's own, after all."
Before you could ask, her figure was already long gone.]]
  },
  Event_7321_Name = {
    Text = "Medical Records"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Leave] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7322_Desc = {
    Text = [[
You take the thin medical record and open it to find a single sheet of paper inside, with only one sentence written on it.
"In the eternal sea of chaos, a Pale, Pupilless Eye watches endlessly."
Before you could ask, Clementine's figure was already long gone.]]
  },
  Event_7322_Name = {
    Text = "Medical Records"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Connect] Recover all HP."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditate] Rouse an Awakener."
  },
  Event_7323_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_7323_Name = {Text = "Junction"},
  Event_7324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7324_Desc = {
    Text = "Important physical evidence should be carefully preserved and handed over to the history department for research and analysis."
  },
  Event_7324_Name = {
    Text = "Cipher-Edict: Part I"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7325_Desc = {
    Text = "The blazing sun shines down from the high heavens, piercing through the haze and awakening weary souls."
  },
  Event_7325_Name = {Text = "Elevation"},
  Event_7326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7326_Desc = {
    Text = "You feel a sense of fulfillment. Their gaze flickers in the night sky above you, focusing on another."
  },
  Event_7326_Name = {Text = "Dome's Eye"},
  Event_7327_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7327_Desc = {
    Text = "You cannot escape the unnerving gaze, nor can you resist the gifts of the gods."
  },
  Event_7327_Name = {Text = "Dome's Eye"},
  Event_7328_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7328_Desc = {
    Text = [[

"What exactly are you?" you ask in horror.
"There's no need to concern yourself with that. The enemy of my enemy is a friend, isn't it?" The man smiles.
"The gift has been left on the chair. Wish you good luck."]]
  },
  Event_7328_Name = {
    Text = "Uncanny Companion IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7329_Desc = {
    Text = "Ramona leaned in, hoping to hear more about the \"White Coat\". \"Someone's eavesdropping!\" The phonograph's voice suddenly grew louder: \"Eavesdropping, eavesdropping, eavesdropping!\""
  },
  Event_7329_Name = {
    Text = "Others' Ears"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Increase all Awakeners' Aliemus by Arg1"
  },
  Event_7330_Desc = {
    Text = [[
You hold the boy's soft hand, passing through one door after another, finally arriving at a small, worn-out stage.
The boy squeezes your hand to express his gratitude.
"Thank you, goodbye."]]
  },
  Event_7330_Name = {Text = "Finale II"},
  Event_7331_ChoiceDesc1 = {
    Text = "[Descend Further] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Pull Away] Receive 25 Black Sigils"
  },
  Event_7331_Desc = {
    Text = [[
"You" invites you deeper.
In the depths of the spiral, the past and future "you" send you "gifts" from different dimensions.]]
  },
  Event_7331_Name = {Text = "Abyss"},
  Event_7332_ChoiceDesc1 = {
    Text = "[Keep Silent] 100% chance to get 25 Black Sigils"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_7332_Desc = {
    Text = "\"All I have to say is one maxim—no one can kill a cat!\"\n\"That damn black cat should have been gutted and left to rot in the wild, but it dug up my family tomb, devouring the remaining human flesh and scattering the bones and limbs everywhere.\"\n\"Under its cold, dark slit-like pupils, the putrid yellow pus floated up, and I crawled away, tormented by nightmares, my spirit drained.\"\n\"Wait... What are you doing? I'm not crazy! I'm not! You must be hiding something! It's true—\"\nIt is indeed true. As you watch the shadow of the madman disappear, you exchange a glance with the quiet black cat at your feet."
  },
  Event_7332_Name = {
    Text = "Nightcat's Bane"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7333_Desc = {
    Text = [[
You ask him for directions to the wax museum.
Strange, this is the fifth time you've met tonight. You've lit his fire five times and asked for directions five times.
Yet, you still can't remember the location of the wax museum, just as you keep encountering him.]]
  },
  Event_7333_Name = {
    Text = "Lamplight Silhouette"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive 25 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Leave"
  },
  Event_7334_Desc = {
    Text = "The third crow departed, flying out of sight and into eternal darkness."
  },
  Event_7334_Name = {
    Text = "Raven's Gaze"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Leave] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7335_Desc = {
    Text = [[
The fur is soft and delicate, still retaining the warmth of Koum's life.
It is the last ray of sunset before dusk, a fleeting remnant of warmth.]]
  },
  Event_7335_Name = {
    Text = "Lingering Warmth"
  },
  Event_7336_ChoiceDesc1 = {Text = "[Chase]"},
  Event_7336_Desc = {
    Text = "You carefully searched the wall and finally discovered a hidden sewer entrance behind the bushes. You crawled through the sewer, but the monster had already fled."
  },
  Event_7336_Name = {Text = "Dead End"},
  Event_7337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7337_Desc = {
    Text = "Birds have their own rules. They do not act according to your will, nor do you have the right to interfere with the laws of nature."
  },
  Event_7337_Name = {
    Text = "Outcast Crow"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Overlook Reflection] Receive 25 Black Sigils"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Are You Okay?] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7338_Desc = {
    Text = "\"You know what... that new Boss lady next door never comes out... The other day, I bought her a beer, and after the foam had completely disappeared, I suddenly noticed... in the glass, she had no shadow!\""
  },
  Event_7338_Name = {
    Text = "Memory Shard: Beer"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7339_Desc = {
    Text = [[
"I really want to sing with you again..."
Sarah's mad, distorted wailing suddenly stopped, her deformed face showing a trace of confusion.]]
  },
  Event_7339_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7340_Desc = {
    Text = "\"So happy! So happy!\" A loud, sharp, and childlike voice rings in your ears, \"For you, for you!\""
  },
  Event_7340_Name = {
    Text = "Nightshade Sprite"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "[Thick Record]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Thin Record]"
  },
  Event_7341_Desc = {
    Text = "A rather familiar voice calls out to you. You squint, but can't quite make out the figure.\n\"I know you're in a hurry,\" says Dr. Clementine cheerfully, \"I promise not to take up too much of your time.\"\nTwo hands reach through the mist in your mind, each holding a medical record—one thick and worn, the other thin and pristine.\n\"Based on your questionnaire results, I took the liberty of preparing a medical record for you. However, I seem to have forgotten which one belongs to you. Why don't you choose?\"\nFor some reason, the thin medical record exudes a familiar aura, subtly resonating with the mental connection between you and the figure."
  },
  Event_7341_Name = {
    Text = "Medical Records"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7342_Desc = {
    Text = "A seemingly ordinary wall. You couldn't help but knock on it, but it didn't feel solid."
  },
  Event_7342_Name = {
    Text = "Strange Wall"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Upgrade a random Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Look Down] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7343_Desc = {
    Text = "\"Hehe, Keeper, do you still remember Winkle's reminder? Listen, do not look down at your reflection at noon.\""
  },
  Event_7343_Name = {
    Text = "Formless Reflection"
  },
  Event_7343_Tips1 = {
    Text = "Silver Relic not yet acquired"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7344_Desc = {
    Text = "A phantasm from a distant future, concealed in the ravines of Elworth."
  },
  Event_7344_Name = {
    Text = "Volcano's Ghost"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7345_Desc = {
    Text = "A butterfly shatters in your palm, like a glass ceiling suddenly shattered, fragments falling, falling, falling to the ground—"
  },
  Event_7345_Name = {
    Text = "Steelbridge Mirage"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7346_Desc = {
    Text = "Let's wait for them to emerge from the shadows."
  },
  Event_7346_Name = {
    Text = "Lantern-Crow"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Switch On] Expand current vision."
  },
  Event_7347_Desc = {
    Text = [[
An ancient lighting device dispels the black Mist around it.
The Mist surrounding it fluctuates rhythmically, as if disturbed by its breath.]]
  },
  Event_7347_Name = {
    Text = "Searchlight"
  },
  Event_7348_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Swallow Doubt] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_7348_Desc = {
    Text = [[
Even now, you are reflecting on Murphy's narration of the past.
The memories resonate with you, tightly shackling and squeezing your mind. Even Goliath's final words of comfort to Murphy failed to bring you solace.
..Wait, they said that the stars will align in twenty-five years...
But Murphy standing before you is clearly just a teenager...]]
  },
  Event_7348_Name = {
    Text = "Shackled Life"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7349_Desc = {
    Text = [[
She should be the one shedding tears; no one has more right to cry than her.
But why isn't she crying? Why does she remain aloof, as if those people aren't kneeling before her...?]]
  },
  Event_7349_Name = {
    Text = "Pre-Voyage Rites"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7350_Desc = {
    Text = "No matter what, it is impolite to pry into other people's privacy."
  },
  Event_7350_Name = {
    Text = "Inscribed Presence"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7351_Desc = {
    Text = "It must be a momentary illusion."
  },
  Event_7351_Name = {
    Text = "Raven's Gaze"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_7352_Desc = {
    Text = "Everyone in her memory was praying to her, pleading with her. You couldn't help but silently pray in your heart..."
  },
  Event_7352_Name = {
    Text = "Pre-Voyage Rites"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7353_Desc = {
    Text = "Beneath the black cat, a steady trickle of black slime flows into the sewer at the alley's entrance. Seeing that you don't approach, the cat turns around and leaps into the sewer, disappearing from sight."
  },
  Event_7353_Name = {
    Text = "Nightshade Sprite"
  },
  Event_7354_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7354_Desc = {
    Text = [[
You panic and let out a sharp scream.
Distracted by your voice, the previously restless hand hesitates for a moment.
Seizing the chance, you immediately escape.]]
  },
  Event_7354_Name = {
    Text = "Gloomslough"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7355_Desc = {
    Text = [[
Twisting, writhing, crawling... You tried every method to escape those pesky arms.
In the end, you managed to escape at the cost of a brand-new uniform, two ribs, and hundreds of hairs.]]
  },
  Event_7355_Name = {
    Text = "Gloomslough"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7356_Desc = {
    Text = [[

"A normal phenomenon. Don't be alarmed, like a novice,"
Doll leans closer, adjusting the position of your brooch. "This indicates there are passages of special dimensions nearby. It seems to be in the direction of the asylum."]]
  },
  Event_7356_Name = {
    Text = "Unsettling Brooch"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7357_Desc = {
    Text = [[
You have no reason to accept the offerings fed by the Lightbearer Devotees.
A crow, shaking its filthy and grotesque stacked heads in displeasure, emits a sound reminiscent of a graveyard as it caws and flies away.]]
  },
  Event_7357_Name = {
    Text = "Cursed Crow"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7358_Desc = {
    Text = [[
"This, too, was my decision," says the figure holding a bear. "But she will become his puppet, and they will all die.
And you will have been complicit in this tragedy."
Intense guilt overwhelms you. The silhouettes vanish, leaving you clutching your chest, unsure if it was a projection or a phantasm brought on by mental stress.]]
  },
  Event_7358_Name = {
    Text = "Forking Trails"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Keep Covering Ears] Receive Arg1 Black Sigils; an amount equal to the highest Aliemus value of an Awakener."
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Recover Arg1 HP; an amount increased by the number of Black Sigils owned."
  },
  Event_7359_Desc = {
    Text = "You heeded the malicious whispers in your ear, the shrill screeches piercing your eardrums like needles.\n\"Stop—just stop—I've done everything you asked—stop—\"\nYou clutch your head in agony, vaguely hearing the mocking laughter of the crows."
  },
  Event_7359_Name = {
    Text = "Song of Crows"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Catch a Crow] Receive 25 Black Sigils for each Roused Awakener."
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Howl] Choose a Rouse card in your deck and affix \"Innate\" to it."
  },
  Event_7360_Desc = {
    Text = [[
You suddenly feel mischievous and catch a crow.
It struggles desperately in your hand, then bursts into a warm splash.]]
  },
  Event_7360_Name = {
    Text = "Song of Crows"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7361_Desc = {
    Text = [[
You cover your ears and close your eyes.
Thump, thump... Your heartbeat mingles with the shrill screeching, forming a chaotic death symphony.
In this moment, you feel an unprecedented sense of calm.]]
  },
  Event_7361_Name = {
    Text = "Song of Crows"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7362_Desc = {
    Text = [[
The Domain is fraught with dangers. Not all lights serve as guiding beacons.
Some are candles luring moths to their doom.]]
  },
  Event_7362_Name = {Text = "Nightglow"},
  Event_7363_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7363_Desc = {
    Text = "\"You're already dead, and there's no going home.\" Your voice is as cold as the wind howling over the Ross Icefield. The traveler's expression remains unchanged, as if it was meant to be. He grabs your hand again, \"Please, save me. I'm a soldier, ordered to the distant East...\""
  },
  Event_7363_Name = {Text = "Devourer"},
  Event_7364_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7364_Desc = {
    Text = "The telegraph is broken. Imagine the despair of its owner in the storm... just like yours now."
  },
  Event_7364_Name = {
    Text = "Silent Telegram"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7365_Desc = {
    Text = [[
"Go fifty yards forward, turn left, then right, then left again...
Then keep walking until the end, and your house will be right there."
The traveler was overjoyed. He waved goodbye and then departed.
You took a deep breath, and suddenly felt someone grab your hand. That familiar voice echoed in your ear once more:
"Please save me.
I am a soldier, sent to the distant East..."]]
  },
  Event_7365_Name = {Text = "Devourer"},
  Event_7366_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7366_Desc = {
    Text = [[
You have finally made your way out of the maze.
At that moment, you suddenly realize that this wax museum is alive.
All the strangeness, beauty, and cruelty are intertwined through an ancient ritual.
And at the heart of the ritual lies Rogers.]]
  },
  Event_7366_Name = {Text = "Eye Maze"},
  Event_7367_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7367_Desc = {
    Text = "\"Is role-playing fun, Keeper?\" Ramona tugs at your sleeve. \"The exit isn't far. I hope you can maintain this humor in front of Lady Daffodil.\""
  },
  Event_7367_Name = {
    Text = "Memory Shard: Yesterday's Dream"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7368_Desc = {
    Text = "\"It is difficult for an Awakener to resist the will of the Linker,\" you reply, \"but we will not give up.\""
  },
  Event_7368_Name = {Text = "Her Choice"},
  Event_7369_ChoiceDesc1 = {
    Text = "[Enter] Through the wall, delve deeper."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7369_Desc = {
    Text = "You approach the wall, and it suddenly twists as if trying to suck you in."
  },
  Event_7369_Name = {
    Text = "Warped Space"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7370_Desc = {
    Text = [[

"No, this isn't true. Compared to cockroaches, at least you have furry bodies.
No one can resist a furry body."
The mice whispered among themselves and eventually agreed with your point.
"Well, it's not like there's that much fur."
Being complimented is always pleasant. Before leaving, the mice gave you a small gift]]
  },
  Event_7370_Name = {Text = "Plague"},
  Event_7371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7371_Desc = {
    Text = [[
"I agree! Humans and rats cannot coexist!"
The rats looked a bit angry, baring their white fangs.
"Then why are you still here? Take your things and never come back."]]
  },
  Event_7371_Name = {Text = "Plague"},
  Event_7372_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7372_Desc = {
    Text = [[
Welcome to beneath the deep sea, where every step is laden with immense pressure.

The impenetrable chaos mist conceals everything; can you navigate through this dark sea under such pressure?]]
  },
  Event_7372_Name = {
    Text = "Under the Tide"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Just Take a Look] Destroy a Card"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Take a closer look] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7373_Desc = {
    Text = [[
"Tap tap..."
The typewriter, like an old drunkard who had one too many whiskeys, stuttered as it spat out black ink.
You quickly noticed the name "Mason" and promptly pulled out the typing paper.]]
  },
  Event_7373_Name = {Text = "Typewriter"},
  Event_7374_ChoiceDesc1 = {
    Text = "[Eye Contact] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7374_Desc = {
    Text = [[
Countless eyes whisper around your ears.
"We journey, we halt, we stride for tens of thousands of years or more.
As the sun fades under our watchful gaze, as life on ancient Earth is swallowed by floods.
We have long been captivated by the mysteries of the universe."]]
  },
  Event_7374_Name = {Text = "Her Eyes"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Increase Max HP by Arg1"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7375_Desc = {
    Text = "You attempt to use the tracing power of the Silver Key to locate the nearest Junction, but the information you receive contains subtle anomalies, as if it has been interfered with."
  },
  Event_7375_Name = {
    Text = "Anomalous Contact"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7376_Desc = {
    Text = [[
You gently wipe the typewriter with the standard linen handkerchief from your Mythag student kit.
The typewriter calms down. As for the dirty handkerchief... it stays in the Domain.]]
  },
  Event_7376_Name = {
    Text = "Typewriter's Murmur"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7377_Desc = {
    Text = [[
You look closely, and through the swaying, overlapping ink stains, a name faintly emerges: "Fingal Johansen".
Who is this?]]
  },
  Event_7377_Name = {
    Text = "Typewriter's Murmur"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Look Up] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Sun's Angle?] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7378_Desc = {
    Text = "\"Now, look southeast immediately. The sun's elevation is in position.\" Doll's command came through the communicator."
  },
  Event_7378_Name = {Text = "Elevation"},
  Event_7379_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7379_Desc = {
    Text = "Event 354 (Under Development), Not Final Effect"
  },
  Event_7379_Name = {
    Text = "Event 354 (In Development)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7380_Desc = {
    Text = [[
Children's voices flow from beneath the piano keys.
<Italic:"Old Charlie's tabby, fat and dear...">
Beneath the children's singing, a young woman's gentle voice softly joins in.
Are you hearing things...?]]
  },
  Event_7380_Name = {
    Text = "Nursery Rhyme"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Turn Around] Receive 25 Black Sigils"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Keep Going] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7381_Desc = {
    Text = [[
Footsteps echo behind you.
Like a shadow, they follow at a steady and unhurried pace.
They intertwine with your footsteps, resonating in the empty exhibition hall.]]
  },
  Event_7381_Name = {Text = "Oxfords"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Fold the Letter] Destroy any 2 Cards"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Save Letters] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_7382_Desc = {
    Text = [[
A new typewriter.
It has a unique set of keys, intricate and elegant like a microscope.
As you admire its perfect mechanical structure, black text suddenly appears.
"Dear Mr. Rogers,
With a heavy heart, we inform you that you have been expelled from the academy.
As you know, @2 Academy is renowned across the kingdom for its rigorous academic standards, and those shocking rumors @3 have deeply troubled..."]]
  },
  Event_7382_Name = {
    Text = "Inscribed Presence"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7383_Desc = {
    Text = "The distant, motionless pocket watch seems to urge you, reminding you not to fall into the traps of time and space."
  },
  Event_7383_Name = {
    Text = "Divine Gaze"
  },
  Event_7384_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7384_Desc = {
    Text = [[
Black sludge drips onto your face, causing a tingling itch.
Unable to bear it, you swipe at the butterfly.
The butterfly evades your hostile action and silently vanishes into the distance.]]
  },
  Event_7384_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Dig]"},
  Event_7385_Desc = {
    Text = [[
Koum carries the three of you through the asylum, searching for an entrance.
Suddenly, it comes to an abrupt stop, nearly throwing you off its back.
Amid your questions, Koum lowers its head, sniffing the soft soil, then turns to indicate something buried below.]]
  },
  Event_7385_Name = {
    Text = "Deep-Buried"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Receive] Acquire 1 out of 3 Golden Relics"
  },
  Event_7386_Desc = {
    Text = [[
The area is empty, with dark liquid flowing across the ground, reflecting nothing.
Is it an illusion? You feel something slipping through your fingers.]]
  },
  Event_7386_Name = {
    Text = "Under-Mirror"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7387_Desc = {
    Text = "Black wings fell on the damp alley soil, transforming into a black, mud-like D-Slime."
  },
  Event_7387_Name = {
    Text = "Frenzied Murder"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7388_Desc = {
    Text = "\"Miss Daffodil will appreciate your humor.\"Ramona waved, and the phantasm dissipated. \"Don't let yourself become the price of dimensional travel.\""
  },
  Event_7388_Name = {
    Text = "Memory Shard: Yesterday's Dream"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Receive] Acquire 1 out of 3 Golden Relics"
  },
  Event_7389_Desc = {
    Text = [[
Oh yes, that loathsome reflection is you.
The surging malice merges with the black ooze at your feet, twisting and dancing together. If you don't mind, it would like to climb onto your shoulder as well.]]
  },
  Event_7389_Name = {
    Text = "Under-Mirror"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stand Still] Receive 25 Black Sigils"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Walk Casually] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7390_Desc = {
    Text = [[
You crush your shadow into fragments, falling into a pool of night.
The scattered remnants of darkness are the only connection to the vanished world.
Will you truly tread through this pitch-black nightmare? You have yet to find your path.]]
  },
  Event_7390_Name = {
    Text = "Nightmare Walker"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Seek the Source] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Replay Record] All Awakeners gain 50 Aliemus, but you develop \"(Skill.Arg1)\"."
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Dismantle the Phonograph] Engrave 1 out of 3 Orisons"
  },
  Event_7391_Desc = {
    Text = "\nYou come across an old gramophone.\nYou wind it up and place the needle on the scratched vinyl record. The symphony is distorted, as if the tape were being torn apart, with brass and string instruments clashing against each other—no voice can emerge unscathed from this piece.\nAt the crackling end of the tune, you hear a rhythmic knocking.\n\"Thud thud... thud thud thud... thud...\"\nFrowning, you lift the needle, but the knocking continues unchanged."
  },
  Event_7391_Name = {Text = "Lost Echo"},
  Event_7392_ChoiceDesc1 = {
    Text = "[Gaze at Radiance] Transform a Relic into the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch the Light] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Turn and Leave] Receive 25 Black Sigils"
  },
  Event_7392_Desc = {
    Text = [[
Under Dream Vision, the Domain Mist shrouds reality in a dark veil. Everything appears hazy, as if barely perceptible.
Through the haze, the light of something pierces the mist. Like a lighthouse guiding a ship, or smoke leading a lost child, it points the way to safety.]]
  },
  Event_7392_Name = {Text = "Nightglow"},
  Event_7393_ChoiceDesc1 = {
    Text = "[Pause Music] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Talking with It] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Listen Quietly] Receive 25 Black Sigils"
  },
  Event_7393_Desc = {
    Text = "You picked up fragments of memories from a puddle of filthy black slime.\nThe crystals shimmered with light, wisps swirling and dancing inside, while shards of memory flew like sand scattered by the wind.\nChaotic, bizarre, and eerie scenes rose around you.\nYou gazed at—\n"
  },
  Event_7393_Name = {
    Text = "Moon Silver Shard"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7394_Desc = {
    Text = "You catch some falling snowflakes and look closely. They melt into dark, thick D-Slime instead of clear droplets."
  },
  Event_7394_Name = {Text = "Snow"},
  Event_7395_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Upgrade a random Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Look Down] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7395_Desc = {
    Text = [[
The mist clears, revealing a skeletal hand extended towards you.
It seems to have been corroded, the rugged surface covered in sticky black sludge. Adorned with rings and necklaces glowing with golden light.
It beckons you closer.
Only in the shadow of crisis do treasures shine brightest.]]
  },
  Event_7395_Name = {
    Text = "Overturning Talons"
  },
  Event_7395_Tips1 = {
    Text = "Silver Relic not yet acquired"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7396_Desc = {
    Text = "The phantasm waves to you before vanishing. All that's left are the cold snow and towering mountains."
  },
  Event_7396_Name = {
    Text = "Volcano's Ghost"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Silver Moon Funeral] Transform a Relic into the Cursed Relic \"(RelicConfig.Arg1)\""
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Silver Moon Prayer] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7397_Desc = {
    Text = "You picked up fragments of memories from a puddle of filthy black slime.\nThe crystals shimmered with light, wisps swirling inside, and memory shards flew like sand scattered by the wind.\nChaotic, bizarre, and eerie scenes rose around you.\nYou looked at—"
  },
  Event_7397_Name = {
    Text = "Moon Silver Shard"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Fuel Up] Engrave 1 out of 3 Orisons"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Extinguish It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7398_Desc = {
    Text = [[
"I am the shadow of the maid who was murdered, and the murderer is that deceptive green flame."
The faintly red flame swayed, accusing you.
"I once lived by the lake reflecting the bulging moon, glorious and radiant."]]
  },
  Event_7398_Name = {Text = "Pale Fire"},
  Event_7399_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7399_Desc = {
    Text = [[
You and the shadow stood under the streetlight, silent.
There was no moon tonight, and all the houses were quiet.
You waved to the shadow and walked away.]]
  },
  Event_7399_Name = {
    Text = "Lamplight Silhouette"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive Arg1 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7400_Desc = {
    Text = "The raven perches at the head of the bed, watching you with its bloodshot eyes."
  },
  Event_7400_Name = {
    Text = "Lantern-Crow"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[I've Got No Wallet] Engrave 1 out of 3 Orisons"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Break the Net] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_7401_Desc = {
    Text = [[
A yellow-orange web floats quietly in the air, its sparse holes far less intricate than those of its spider-weft relatives nesting by the wall.
You can't resist but to reach out; the fragile web dissolves instantly, and children's laughter echoes in your ears.
"Gold, silver, yellow, red, all the wallets are ours!"]]
  },
  Event_7401_Name = {
    Text = "Vagus Network"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Repair the Telegraph] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Bury the Telegraph] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignore] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7402_Desc = {
    Text = [[
You hide in a narrow cave crevice, temporarily sheltering from the snowstorm. But you know you can't stay here for long. If those black-robed figures find you here, there will be no escape.
In a corner of the crevice, you discover a damaged telegraph machine.]]
  },
  Event_7402_Name = {
    Text = "Ancient Legacy"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7403_Desc = {
    Text = "You've seen such portraits in many places within the kingdom.\n\"The Queen\"stands at the center, radiating amidst black roses.\nExcept for one thing—her face has been cruelly gouged out, leaving a charred, black void.\nTo this day, you still cannot see the Queen's true visage."
  },
  Event_7403_Name = {
    Text = "Portrait Gallery"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Spare Her] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Help Her] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Walk My Own Path] Receive 50 Black Sigils"
  },
  Event_7404_Desc = {
    Text = [[
Three dark, ephemeral figures block your way.
"You can let her go," says the one holding a teddy bear dripping with D-Slime, "she is just timid, not evil. She doesn't want to harm anyone."
"You can help her," says the one holding a beautifully wrapped bag of candy, "you can do what she cannot. You can end all of this."
"You don't have to listen to us," says the one with empty hands, "you have your own path."]]
  },
  Event_7404_Name = {
    Text = "Forking Trails"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7405_Desc = {
    Text = [[
Daffodil's voice paused for a moment.
"Oh, you chose this? A fine choice. As a reward, I will specially give you a gift."
"I'm not familiar with that child, but I have a conjecture about Francis. I believe the emotion dominating her and granting her the power to 'see' is intense regret. I wonder what choice she will make regarding this regret..."]]
  },
  Event_7405_Name = {Text = "Hint Time"},
  Event_74068_ChoiceDesc1 = {
    Text = "[Incorporate into Brain Vat] Shuffle \"Spare Brain Vat\" into the Draw Pile."
  },
  Event_74068_Desc = {
    Text = [[
Inside the intricately carved archway, on the slanted roof of the red brick exterior, and before the row houses with hollowed walls, elongated shadows dance, yearning for answers to questions.
Does mediocrity mean death?
Is being content with the status quo destined to result in a dying fire?]]
  },
  Event_74068_Name = {
    Text = "Lingering Consciousness"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Continue Containment] Choose up to 2 Command Cards to remove from the deck, and place them into the \"Spare Brain Vat\"."
  },
  Event_74069_Desc = {
    Text = "\"I saw them. Many people, many murmurings, wise, shallow, rational, mad. Sometimes, a spark of hope is born even in the ashes.\""
  },
  Event_74069_Name = {
    Text = "Lingering Consciousness"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7406_Desc = {
    Text = "You carefully lift the rodent from the scale. Its breathing is steady, its furry body warm in your palm."
  },
  Event_7406_Name = {
    Text = "Reason and Passion"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7407_Desc = {
    Text = [[
The dim Silver Core bursts into brilliance but vanishes in an instant, leaving only ash indistinguishable from soil in hand.
The Silver Core, drained of its final Gnosis, fails to reforge a body for the unknown Soul, but leaves a trace of its existence before fading completely.]]
  },
  Event_7407_Name = {
    Text = "Proof of Being"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7408_Desc = {
    Text = "\"I am not familiar with that child, but I have a hypothesis about Francis. I believe the emotion that controlled her and granted her the power of 'seeing' is profound regret. I wonder what choice she will make because of this regret...\""
  },
  Event_7408_Name = {Text = "Hint Time"},
  Event_7409_ChoiceDesc1 = {
    Text = "[Pull The Paper] Destroy a Card"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Not Now] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7409_Desc = {
    Text = "The portable typewriter inside your suitcase suddenly started typing on its own, producing a half page of crooked text before you could notice.\n\"You have seen It. It has always been just beside you—those shadows tainted by madness and zeal... Do not gaze directly at Its outline.\""
  },
  Event_7409_Name = {
    Text = "Unbidden Warning"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Go Left] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Go Right] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7410_Desc = {
    Text = [[
It seems you've entered a maze.
Left, right, left again... You gradually lose patience until you look up and see the eye.
The eye watches you calmly and majestically, as if it were the ruler of this place.]]
  },
  Event_7410_Name = {Text = "Eye Maze"},
  Event_7411_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7411_Desc = {
    Text = [[
You pull your hands back with great effort, clearly hearing the sound of bones breaking.
This is the price you pay for your curiosity.]]
  },
  Event_7411_Name = {
    Text = "Inspiration Surge"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7412_Desc = {
    Text = [[
You carefully examined the camera, its leather and black-gold inlay exuding a sleek sheen.
The lens was aimed at you, as if gazing and prying...]]
  },
  Event_7412_Name = {
    Text = "Record Innocence"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7413_Desc = {
    Text = "You mercilessly pulled out another film strip hidden inside the camera, revealing images that left you speechless.\nThe undeveloped film faithfully recorded— you lying in a puddle of black mud."
  },
  Event_7413_Name = {
    Text = "Record Innocence"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Read] Destroy a Command Card, and receive 25 Black Sigils."
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continue Typing] Duplicate a Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_74145_Desc = {
    Text = [[
The printer is violently spewing ink.
Black ink gushes from the nozzle like a ghost, filling the air and forming a thick, oppressive black mist.
There seems to be a hidden hint in the keyboard, waiting for innocent fingers to touch it.]]
  },
  Event_74145_Name = {Text = "Ghost Ink"},
  Event_74146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74146_Desc = {
    Text = "You step into a dark alley, the mist gnawing at your clothes, while the shadows behind you split into countless pairs of eyes. The toll of the rusted bell carries with it a damp omen.\n\nYou know that all winding paths will eventually collapse into a cocoon of cycles—before the rotten dawn, you will reunite with your own reflection."
  },
  Event_74146_Name = {
    Text = "Time's Ashes"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74147_Desc = {
    Text = [[
Silently, you trace an sign upon your chest, offering a silent prayer for the departed.
In this annihilated world, there are too many things beyond your ability to save.
The bone glimmers, revealing a glimpse of a treasure once cherished by its long-dead owner.]]
  },
  Event_74147_Name = {Text = "Faded Bone"},
  Event_74148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74148_Desc = {
    Text = [[
"The All-Father remembers your mercy. The All-Father will watch over us, redeeming us from the burdens of suffering."

Her phantasm gradually fades away, and the sound of sacred music transforms into the relentless howling of the wind.]]
  },
  Event_74148_Name = {
    Text = "Organ Prayer"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74149_Desc = {
    Text = [[
You gently push the exposed skeleton, which slowly sinks into the black sludge, vanishing without a trace.
May the soul find peace in nothingness.]]
  },
  Event_74149_Name = {Text = "Faded Bone"},
  Event_7414_ChoiceDesc1 = {
    Text = "[Leave] You defeated the opponent, and nothing happened."
  },
  Event_7414_Desc = {
    Text = [[
"It seems the little one needs to learn the hard way that a woman's secrets aren't so easily uncovered."
As Daffodil's words fade, a massive monster appears before you.]]
  },
  Event_7414_Name = {Text = "Hint Time"},
  Event_74150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74150_Desc = {
    Text = "Such morbid toys should not exist in the clock tower where Jenkin hides; this sound originates from your mind, your memory.\nYou recall the sensations you experienced when you were a Brain in a Vat—the electrical currents converted from sound waves.\nThat strange noise gradually becomes normal and soothing, turning into a smooth classical melody, playing repeatedly in your mind."
  },
  Event_74150_Name = {
    Text = "Belltower Echoes"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74151_Desc = {
    Text = [[
Those aren't cats... they're the agitated Lightbearer Devotees.
Beneath the black veil, hatred and hostility seep through. The murmurs scrape at your consciousness, bringing bizarre and inexplicable hallucinations.]]
  },
  Event_74151_Name = {
    Text = "Feline Murmur"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74152_Desc = {
    Text = [[
They clutch your shoes, seizing your ankle; they are greedy, they are ravenous, and they strive to drag you into the abyss they dwell in.
You struggle desperately to keep your footing, stumbling backward a few steps in search of an escape.
Unintentionally, something drops.]]
  },
  Event_74152_Name = {
    Text = "Nightmare's Mirror"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Dodge] Engrave 1 out of 3 Orisons"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Stop] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_74153_Desc = {
    Text = [[
A familiar scene makes your nerves jump, twitch, and recoil in dread.
"Once again..."
The merciless nightmare arrives, and an overwhelming sense of helplessness engulfs you.
Is there really no way to rewrite her fate?
There's no time. Inside Sarah's cracked skull, a gigantic mouth gleams with silver, eager to snap you in two, to devour and chew.]]
  },
  Event_74153_Name = {
    Text = "Nightmare Reborn"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74154_Desc = {
    Text = [[
You hear unsettling whispers.

"We come from the mountains and swamps of distant stars. Our bodies are the wick and fuel of lanterns, and we will ignite the firewood of the earth, illuminating the path to a new world."]]
  },
  Event_74154_Name = {
    Text = "Feline Murmur"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74155_Desc = {
    Text = [[
Sunset, bell tower, flying birds...
The girl removed her eyepatch, and the gaze of her gray pupils froze you in place.
Illusions, like mirages, vanished as soon as they appeared, yet the lingering worries could not be dispelled.]]
  },
  Event_74155_Name = {
    Text = "White Eyepatch"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Pick Up] Acquire 1 out of 3 Silver Relics"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recall] Acquire the Silver Relics \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg3)\" twice."
  },
  Event_74156_Desc = {
    Text = [[
In the corroded slime at the corner lay a small white eyepatch.
Memories seize your heart.]]
  },
  Event_74156_Name = {
    Text = "White Eyepatch"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74157_Desc = {
    Text = [[
The transparent palm glides gracefully over the black-and-white keys, yet the sound waves it produces are fragmented, akin to a discordant music box. Each note emits a dissonant wail, as if crying out for help in anguish.
Finally, the performance comes to an abrupt halt on a helpless chord.
What cannot be attained in life now lingers in this moment, leaving behind a profound sense of yearning.]]
  },
  Event_74157_Name = {
    Text = "Regretful Sonata"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74158_Desc = {
    Text = [[
"Dear Ms. Sarah:
I hereby resign from my position as a caregiver at the workhouse.
I can no longer support your philosophy. Your teachings are misguided; the children of the East District should not grow up under your influence, nor should they believe in pure kindness and selfless giving.
One day, they will step out from under your wings to learn the survival rules of the East District.
....."

The rest of the letter is blurred and illegible, stained by a dark liquid.]]
  },
  Event_74158_Name = {Text = "Ghost Ink"},
  Event_74159_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74159_Desc = {
    Text = [[
"What I can offer the children is only a roof to shield them from the rain and just enough food to keep them from starving. If it weren't for the kind Mr. Rogers bringing in the doctor, they wouldn't even get a single pill when they fall ill.
I haven't read many books; ensuring they don't freeze or starve to death on the streets is all I can do.
I have never interfered with what kind of people they choose to become, but they need to survive.
....."]]
  },
  Event_74159_Name = {Text = "Ghost Ink"},
  Event_7415_ChoiceDesc1 = {
    Text = "[Seek the Source] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Discard Letter] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Check Letter] Receive 50 Black Sigils"
  },
  Event_7415_Desc = {
    Text = [[
Another letter falls at your feet. The torn paper fills you with dread as you unfold it.
"It has come again. My warnings were not in vain! @4 It starts here and will end here."
"I want to escape... I hid in the wooden cabinet, my hands trembling uncontrollably. But the sticky limbs thudding on the floor are closing in... I heard a name! It's it! @5!"]]
  },
  Event_7415_Name = {
    Text = "Another Distress Letter"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74160_Desc = {
    Text = [[
"Thank you. The creative power of the All-Father will ultimately reshape our forms, bringing us eternal light and flame.

When I reach the end, I will offer blessings for you before the All-Father."

Her phantasm gradually fades away, and the sound of sacred music transforms into the relentless howling of the wind.]]
  },
  Event_74160_Name = {
    Text = "Organ Prayer"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Bury] Destroy a Command Card and recover Arg2 HP. [ExDesc1]"
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74161_Desc = {
    Text = "A pale skeleton, half submerged in pitch-black D-Slime."
  },
  Event_74161_Name = {Text = "Faded Bone"},
  Event_74162_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74162_Desc = {
    Text = [[
You step straight into the mist, phantoms clinging to your body like a web, cold sensations seeping into your bones.
Their whispers turn into fragments of memory, piercing your heart.
As you pass through, nothing remains behind but illusion, and ahead, more shadowy figures loom in the dense mist, waiting to devour.]]
  },
  Event_74162_Name = {
    Text = "Time's Ashes"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Avoid Phantasm] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Pass Through Phantasm] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_74163_Desc = {
    Text = [[
The dust lies thick like a heavy curtain over the streets, and each step feels as though you are treading on the ashes of time.
In the distance, two shadowy figures loom in the mist, like phantoms of the past, whispering tales long forgotten.
The runaway imagination conjures terrifying phantasms, twisting and sprawling, as if harbingers of future doom, weighing heavily upon your breath.
You know the road ahead will only become dimmer, yet your steps cannot and should not halt.]]
  },
  Event_74163_Name = {
    Text = "Time's Ashes"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74164_Desc = {
    Text = [[
You narrowly evade Sarah's first fierce attack.
Next time, you might not be so fortunate.]]
  },
  Event_74164_Name = {
    Text = "Nightmare Reborn"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicate Direction] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Pray Together] Engrave 1 out of 3 Orisons"
  },
  Event_74165_Desc = {
    Text = [[
The sounds of the piano and organ intertwine in the dim wind. It is as if magical melodies drift through deserted streets.
An unnamed nun prays amidst the music.
"Simple prayers require no grand ceremony. The All-Father will sow hope for us, just as He once bestowed upon us devout teachings."]]
  },
  Event_74165_Name = {
    Text = "Organ Prayer"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Parry the Monster] Upgrade one Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Pick Up Stars] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignore] Receive 25 Black Sigils"
  },
  Event_74166_Desc = {
    Text = "The meteor shower rains down on the clock tower.\nA transparent crystal lands at your feet, creating a small pit.\nYou are still surrounded by Dissoluted Entities in various forms, like twisted shadows. The sounds of roaring and howling continue without pause.\nYou decide—"
  },
  Event_74166_Name = {
    Text = "A Fallen Star"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Rub Your Eyes] Receive 50 Black Sigils"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_74167_Desc = {
    Text = "A hideous swarm of black cats gathers behind Juliette, murmuring unknown chants and exuding a secretive and malevolent threat."
  },
  Event_74167_Name = {
    Text = "Feline Murmur"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74168_Desc = {
    Text = [[
The cheap fabric feels a bit coarse to the touch, but it has still been carefully cleaned.
Take good care of it and wait for the day it is returned to its rightful owner.]]
  },
  Event_74168_Name = {
    Text = "White Eyepatch"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Maintain Distance] Receive 25 Black Sigils"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Show Mercy] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74169_Desc = {
    Text = [[
They swarm from beneath your feet.
In their blurred faces of pain, you see your shadow being pulled.
Do you truly have the right to judge them?]]
  },
  Event_74169_Name = {
    Text = "Nightmare's Mirror"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Discard Fragments] Has a special relic, infected with Orison: \"(EnchantConfig.Arg1)\" - Symptom: Dissolution Madness"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Complete the Fragments] No special Relic, infect \"(Skill.Arg1)\", gain infection \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = [[
The pale limbs writhe slowly before you. She bends down, extending her broken arm toward you. Her eyes, squinting in pain, overflow with white, plaster-like tears.
"Just... one more piece, and I can..."]]
  },
  Event_7416_Name = {
    Text = "Flesh Reforged"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74170_Desc = {
    Text = [[
You must try to save them.
But don't let yourself be assimilated by them.]]
  },
  Event_74170_Name = {
    Text = "Nightmare's Mirror"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Avert Gaze] Increase Max HP by Arg1"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Maintain Gaze] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_74171_Desc = {
    Text = [[
"The end has come."
Your heart tightens and constricts.
Juliette's confident tone undoubtedly carries the influence of some hypnosis and telepathic power.
What sets this Juliette in this dimension apart from the one you knew in the past?
Too many mysteries, too many obstacles.
You glance at Juliette, only to find her staring intently back at you.]]
  },
  Event_74171_Name = {Text = "Final Gaze"},
  Event_74172_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74172_Desc = {
    Text = "You raise your hand to awkwardly tap the illusory piano keys.\nThe keys chime and intertwine, each note like a droplet of dew—clear and transparent. The skillful and exquisite playing does not come from your fingertips.\nIn a daze, you see a pair of formless, elongated hands covering your own, moving up and down with the flow of the performance.\nTime seems to freeze until the last lingering note of the piano fades away.\nYou hear a contented sigh."
  },
  Event_74172_Name = {
    Text = "Regretful Sonata"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74173_Desc = {
    Text = [[
The frequently shifting consciousness is unstable, and you need to eliminate meaningless distractions.
You focus your attention on Jenkin in front of you, and the phonograph's sound gradually fades away, dissipating into the mist.]]
  },
  Event_74173_Name = {
    Text = "Belltower Echoes"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Locate the Source] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Reminisce] All Awakeners gain 50 Aliemus, but you develop \"(Skill.Arg1)\"."
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignore Noise] Engrave 1 out of 3 Orisons"
  },
  Event_74174_Desc = {
    Text = [[
You hear the sound of a phonograph needle distortion.
The twisted needle slides over the damaged spiral grooves, producing a slow and chilling tremor.]]
  },
  Event_74174_Name = {
    Text = "Belltower Echoes"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Perform for Him] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Receive 15 Black Sigils for each Awakener with 50 or more Aliemus."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_74175_Desc = {
    Text = [[
"Dear John:
Recently, I suddenly realized that it has been several years since you last played the piano for us.
I am 81 years old this year, and as I grow older, I increasingly cherish the memories of my youth.
If you receive this letter, please stop by my apartment the next time you pass through Londinium and play a tune for me."]]
  },
  Event_74175_Name = {
    Text = "Regretful Sonata"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74176_Desc = {
    Text = [[
The desire to survive surges in your chest, and you issue the command without hesitation.
After breaking through the siege and turning back to look, that star has been submerged by D-Slime.
Amidst the swirling D-Slime, a sharp, rhythmic sound echoes.
You touch the surface of the D-Slime, and a decayed star falls into your palm.]]
  },
  Event_74176_Name = {
    Text = "A Fallen Star"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74177_Desc = {
    Text = [[
You pick up the star, but it has lost its brilliance in your palm.
A sudden wave of oppression washes over you, sending chills down your spine.
In the blink of an eye between life and death, you sidestep to evade a fierce attack, but a two-inch-long scratch still remains on your arm.]]
  },
  Event_74177_Name = {
    Text = "A Fallen Star"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74178_Desc = {
    Text = [[
The hidden sharp fangs within the tentacles tear open your sleeve, and warm blood streams down your wrist like a crimson rivulet.
You cannot read Sarah's expression, but the cracked skull lets out a faint, trembling shriek of agony.]]
  },
  Event_74178_Name = {
    Text = "Nightmare Reborn"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74179_Desc = {
    Text = "You look around, moving left and right. The sound is like a mouse playing hide-and-seek with you—sometimes to the left, sometimes to the right, now distant, now close.\nYou wander about, but the noise grows louder. The metallic scraping sounds deepen your unease.\nOn a whim, you touch your pocket. Though you don't find the source of the sound, you do pick up a small treasure."
  },
  Event_74179_Name = {
    Text = "Belltower Echoes"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Leave] Lose Arg1 HP, and develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7417_Desc = {
    Text = [[

"Good child. But still, I have to give you a little punishment."
Daffodil's light laughter faded in the dimensional rift.]]
  },
  Event_7417_Name = {Text = "Hint Time"},
  Event_74180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74180_Desc = {
    Text = [[
You avert your gaze, avoiding meeting her eyes.
Yet some force still makes your heart race anxiously.]]
  },
  Event_74180_Name = {Text = "Final Gaze"},
  Event_74181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74181_Desc = {
    Text = [[
Juliette locks eyes with you.
The next moment, she breaks into a completely mad smile, seemingly mocking your arrogance and ignorance.
However, the smile vanishes in an instant, and others make no reaction to it... It seems to be nothing more than your hallucination.]]
  },
  Event_74181_Name = {Text = "Final Gaze"},
  Event_7418_ChoiceDesc1 = {
    Text = "[Task Relic] Obtain Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Task Relic 2, Obtain Golden Relic \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7418_Desc = {
    Text = "Event 254 (Under Development), Not Final Effect"
  },
  Event_7418_Name = {
    Text = "Event 254 (In Development)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Submit Special Orison 1] Randomly get Orison on 1 Command Card: \"(EnchantConfig.Arg1)\""
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Submit Special Orison 2] Randomly grant an Orison on 1 Command Card: \"(EnchantConfig.Arg1)\""
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infection \"(Skill.Arg1)\" and \"(Skill.Arg2)\", Gain Golden Relic \"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Event 255 (Under Development), Not Final Effect"
  },
  Event_7419_Name = {
    Text = "Event 255 (In Development)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Dodge Butterfly Card] Destroy any 2 Cards"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Embrace the Butterfly] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_7420_Desc = {
    Text = "Corner after corner, the pursuit of the Hellhound seems never-ending.\nAching ankles, a throbbing brain—amidst the chaos, you see butterflies once more. You know they are the delusions of Madness, the whispers of the Domain. They flutter in from all directions."
  },
  Event_7420_Name = {
    Text = "Delusion Surge"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7421_Desc = {
    Text = "You gently press the wind chime. It softly rings a few times before falling silent. It has already retreated— only to return in nightmares."
  },
  Event_7421_Name = {Text = "Tiny Chime"},
  Event_7422_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7422_Desc = {
    Text = "The chime rings briefly before falling silent. It has retreated— only to return in nightmares."
  },
  Event_7422_Name = {Text = "Tiny Chime"},
  Event_7423_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7423_Desc = {
    Text = [[
"Not bad, you are very cautious."
Suddenly, a distant voice came from the wind chimes.
"Caution will bring you a small reward, but that's all."]]
  },
  Event_7423_Name = {Text = "Tiny Chime"},
  Event_74245_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_74245_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74245_Name = {
    Text = "N's Message"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Shut the Gate] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Flee in Panic] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignore] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_74246_Desc = {
    Text = "You are deeply trapped in a maze constructed of steam and gears, with brass pipes twisting like spider webs overhead. Each breath stirs the thick mist of machine oil.\nOut-of-control mechanical dials twitch on the walls, their pointers scraping against the scales and sending out sporadic sparks, akin to dying fireflies in a Victorian laboratory. The seams of the rivets ooze copper rust, resembling the festering wounds of this steel giant, and your pocket watch has long since stopped—here, time is merely the prayer of interlocking gears."
  },
  Event_74246_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Take a Gamble] Develop \"(Skill.Arg1)\" and try your luck"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Forget It] Receive 25 Black Sigils"
  },
  Event_74247_Desc = {
    Text = [[
In the deep black mist at the street corner, a suffocating aura spreads.
Within the mist, two ancient and chilling dice emerge, their surfaces covered with inscrutable symbols and eerie patterns.
They lie quietly on the slick tablets as if awaiting some unknown summon.
"You know who I am. Care to take a gamble?"]]
  },
  Event_74247_Name = {
    Text = "N's Message"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74248_Desc = {
    Text = "\"I dreamed of a cataclysm sweeping everything away, drowning the brilliance of the past. I feel anger towards life and helplessness about a future devoid of hope. My spirit is torn apart by fear; amidst this impending collapse, may you remain vigilant and prevent this terrible fate from arriving.\""
  },
  Event_74248_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74249_Desc = {
    Text = [[
The black smoke quivers in despair.
Then the dice vanish in the blink of an eye.

Only one question lingers in your mind:
What are these dice truly made of?]]
  },
  Event_74249_Name = {
    Text = "N's Message"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7424_Desc = {
    Text = "You turn around and see a pair of leather shoes along with a blurry human reflection.\nIt appears to be a young gentleman.\n\"Sorry to bother you, but have you seen a pair of black Oxford shoes?\"\n\"There's a pair right in front of you.\"\n\"No, no... These are made of goatskin, not cowhide.\nI've been trapped in this wax museum for twelve years—it must be the wrong shoes...\"\nThe voice mutters, gradually fading away."
  },
  Event_7424_Name = {Text = "Footsteps"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Duplicate 1 of 3 Command Cards"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Discern Woman's Voice] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] Receive 25 Black Sigils"
  },
  Event_74250_Desc = {
    Text = "You stand alone in a dark swamp.\nThrough the haze, you hear chaotic murmurs overlapping like tides—some from quavering elders, some from babbling children, some from anxious women, and some from men gripped by nameless dread..."
  },
  Event_74250_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Advance] Destroy 1 of 3 Command Cards, and receive 75 Black Sigils."
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Rest] Duplicate 1 of 3 Command Cards, and receive 25 Black Sigils."
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Look Back] Receive 50 Black Sigils"
  },
  Event_74251_Desc = {
    Text = [[
You walk on deserted streets, leaving deep imprints with each step in the ashes.

The city roads are like spider webs, and you are a moth entangled in them.]]
  },
  Event_74251_Name = {Text = "Gloom City"},
  Event_74252_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74252_Desc = {
    Text = "At the moment the steam gate thundered shut, you heard your shadow being shedded inch by inch by the interlocking gears."
  },
  Event_74252_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74253_Desc = {
    Text = "Repeated scenes continue to refresh before your eyes, and you have nowhere to escape."
  },
  Event_74253_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74254_Desc = {
    Text = "Time is a meaningless coordinate; only the truth is what you long for."
  },
  Event_74254_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74255_ChoiceDesc1 = {Text = "[3]"},
  Event_74255_ChoiceDesc2 = {Text = "[6]"},
  Event_74255_ChoiceDesc3 = {Text = "[1]"},
  Event_74255_Desc = {
    Text = "Who would dare roll this dice that carry misfortune and madness?\nYou, it is you.\nYou choose—"
  },
  Event_74255_Name = {
    Text = "N's Message"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_74256_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74256_Name = {
    Text = "N's Message"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74257_Desc = {
    Text = [[
The journey is shrouded in endless darkness and boundless chaos.
There is no time to contemplate your fate. You must dispel fear and reach your destination before the final judgement descends.]]
  },
  Event_74257_Name = {Text = "Gloom City"},
  Event_74258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74258_Desc = {
    Text = "\"As I sit in the shadow of years, feeling the icy hand of death creeping closer, the world outside grows ever dim, filled with whispers of calamity. I fear the impending judgment, the reckoning for our folly. The streets are filled with an ominous aura; I worry that our Judgment Day is fast approaching. Our civilization teeters on the brink, as if about to be devoured by destruction, trapped by our own foolish arrogance.\""
  },
  Event_74258_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74259_Desc = {
    Text = [[
Having escaped death is already a rare feat; you should not ask for more.
The shadows of broken remnants and ruins still call to you.]]
  },
  Event_74259_Name = {Text = "Gloom City"},
  Event_7425_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_7425_Desc = {
    Text = [[
"Is that so... very interesting."
She folds away the questionnaire and points you in the direction the children had gone. You hurry away, nearly missing the whisper behind you.
"Looking forward to when we meet again."]]
  },
  Event_7425_Name = {
    Text = "Psyche Appraisal"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74260_Desc = {
    Text = [[
You are under the control of some great power or mighty fate.
A short rest cannot change this situation, but it can at least give your weary legs the strength to keep moving.]]
  },
  Event_74260_Name = {Text = "Gloom City"},
  Event_74261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74261_Desc = {
    Text = "\"...The city is no longer a warm refuge, but a hidden grave, nurturing terror and despair. Those once-vivid dreams now remain as shards of fear. I can no longer pretend to be fearless; the world before me is like a nightmare from which I cannot awaken.\""
  },
  Event_74261_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_74262_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74262_Name = {
    Text = "N's Message"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"Mirror\" on a random Command Card."
  },
  Event_7426_Desc = {
    Text = [[
"It's okay, I've already seen the answer in your eyes. I have some errands to run, so I'll excuse myself for now. You have matters to attend to as well, don't you? Look, someone's coming for you."
You turn around, and a figure from the Church of the Lightbearers appears at the end of the road.]]
  },
  Event_7426_Name = {
    Text = "Uncanny Companion V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"Computation\" on a random Command Card."
  },
  Event_7427_Desc = {
    Text = "\"It seems you are not willing to open up to me. I'm disappointed, but it doesn't matter. I'll still offer you a kind hint: What is the Church of the Lightbearers looking for here?\"\n\"Oh, looks like someone doesn't want us to chat. Look over there—someone's coming for you.\"\nYou turn around, and the figures of Lightbearer Devotees appear at the end of the road."
  },
  Event_7427_Name = {
    Text = "Uncanny Companion V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"Insight\" on a random Command Card."
  },
  Event_7428_Desc = {
    Text = [[
"You're honest, which deserves a reward. So, here's a hint: Why did He target you right after you arrived at Rye Town?"
"Oops, it seems someone doesn't want us chatting. Look, someone is coming for you."
You turn around and see the Lightbearer Devotees at the end of the road.]]
  },
  Event_7428_Name = {
    Text = "Uncanny Companion V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7429_Desc = {
    Text = "The chaotic sounds gradually fade, your hands are empty, but the fleeting emotions have already been recorded by the silver key"
  },
  Event_7429_Name = {
    Text = "Book of Null"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7430_Desc = {
    Text = "You reach out into the chaos, grabbing something with an unusual texture that gradually takes shape in your hand."
  },
  Event_7430_Name = {
    Text = "Book of Null"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7431_Desc = {
    Text = [[
"Have you heard of the snake's hunting method? Snakes can only crawl on the ground and slither, so they cannot chase prey with bursts of speed like a cheetah, nor can they surround their prey like a pack of wolves. Instead, snakes have learned to wait patiently."
"They wait for the moment when their prey lets its guard down, then strike suddenly, swallowing it in one bite."]]
  },
  Event_7431_Name = {
    Text = "Uncanny Companion III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7432_Desc = {
    Text = "Startled, the black cat's glossy fur leaves a burning sensation on your fingertips before vanishing into the depths of the mist."
  },
  Event_7432_Name = {
    Text = "Nightcat's Bane"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7433_Desc = {
    Text = "Just the absurd dreams of those foolish believers in madness."
  },
  Event_7433_Name = {
    Text = "Cipher-Edict: Part II"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Keep Eavesdropping] Engrave 1 out of 3 Orisons"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Cough Loudly] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7434_Desc = {
    Text = [[

The corner of the wall cracked open with many fine fissures, winding out like blood vessels.
Accompanied by a faint buzzing sound, you hear a man's deep voice coming from across the way.
"Quentin District 5, Wellington District 10, Norman District 15...
All materials for this month have been loaded, ready for dispatch, cargo number I-0234...
.....
Moreover, thanks to those people from Mythag, the Whitechapel District is currently under martial law, and we have lost our largest source of materials."]]
  },
  Event_7434_Name = {
    Text = "Eavesdropper"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive 20 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Leave"
  },
  Event_7435_Desc = {
    Text = "At your scare, all the crows flew off in every direction with a flutter, their falling black feathers melting into slime and dripping to form the shape of Black Sigil."
  },
  Event_7435_Name = {
    Text = "Raven's Gaze"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Destroy a Command Card, and receive Arg1 Black Sigils."
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_7436_Desc = {
    Text = [[
A new typewriter.
It has a unique set of keys, intricate and elegant like a microscope.
You curiously place your hands on it, only to find them uncontrollably flying over the keyboard, faster and faster...]]
  },
  Event_7436_Name = {
    Text = "Inspiration Surge"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7437_Desc = {
    Text = [[
Just a struggling creature seeking a piece of driftwood to rest on...
You sigh as the black fluid from the butterfly's tail drips onto your cheek.]]
  },
  Event_7437_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7438_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_7438_Name = {Text = "Junction"},
  Event_7439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7439_Desc = {
    Text = "You've accepted a contact request from the school. The familiar voice calms your mind. You gather your spirits and move forward."
  },
  Event_7439_Name = {Text = "Junction"},
  Event_7440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7440_Desc = {
    Text = "Your doubts hang in the air, unanswered. Warm yellow light streams through the window, as comforting as memories."
  },
  Event_7440_Name = {
    Text = "Volcanic Memory"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Pick Up] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Hesitate] Receive 25 Black Sigils"
  },
  Event_7441_Desc = {
    Text = "In a wooden barrel at the corner of the alley, an oddly colored object is floating. Its unusual appearance seems to warn you, \"Do not touch\"."
  },
  Event_7441_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Leave It to Her] Acquire 1 out of 3 Silver Relics"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Interesting Situation] Acquire the Silver Relics \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg3)\" twice."
  },
  Event_7442_Desc = {
    Text = "\"This is a communication from Mythag. I'm Erica. Abnormal Gnosis Index fluctuations detected in Awakener Lotan. Do you need support?\""
  },
  Event_7442_Name = {
    Text = "Reinforcement Hail"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7443_Desc = {
    Text = "You heeded the malicious whispers in your ear, the shrill screeches piercing your eardrums like needles.\n\"Stop—just stop—I've done everything you asked—stop—\"\nYou clutch your head in agony, vaguely hearing the mocking laughter of the crows."
  },
  Event_7443_Name = {
    Text = "Murder's Chant"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7444_Desc = {
    Text = "Placed here, it could be one of two possibilities: something neglected or something cherished. If it's the latter, it's best left to its owner."
  },
  Event_7444_Name = {
    Text = "Lonely Silver Core"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7445_Desc = {
    Text = "The happiest are those who are ignorant."
  },
  Event_7445_Name = {Text = "Peek"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Spawn Normal Monster]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Spawn Blank Tile]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Spawn Void]"
  },
  Event_7446_Desc = {
    Text = "Let's see what can be generated."
  },
  Event_7446_Name = {
    Text = "[To Be Packaged]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7447_Desc = {
    Text = [[
"Calm down," Ramona taps your head, "just fragments of the past. I don't know who left them in this dimensional passage."
Indeed, there's a nostalgic scent.]]
  },
  Event_7447_Name = {
    Text = "Memory Shard: Whiskey"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Collect] Upgrade a Silver Relic into the Golden Relic \"(RelicConfig.Arg1)\""
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Throw Them Away] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observe Carefully] Receive 25 Black Sigils"
  },
  Event_7448_Desc = {
    Text = [[
There are many shattered Silvers here.
Dull, broken... clearly not high-end goods.
Perhaps they are one of the reasons why these wax sculptures can "come to life."
Even the roughest Silver has the potential to create miracles]]
  },
  Event_7448_Name = {Text = "Bound Soul"},
  Event_7449_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7449_Desc = {
    Text = [[
Koum has given everything she could.
Now, it's your turn to ensure her sacrifice was not in vain.]]
  },
  Event_7449_Name = {
    Text = "Lingering Warmth"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7450_Desc = {
    Text = "May the wind and snow grant you eternal tranquility."
  },
  Event_7450_Name = {
    Text = "Ancestral Leavings"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7451_Desc = {
    Text = [[
You remain resilient, staying true to yourself amid the chants of the raven.
You don't trust the whispers in your ears, relying solely on human reason.
However... when the solid ground you depend on is engulfed by thick black slime, gouging out your eyes to use as tools for observation will be your only choice in your final moments.]]
  },
  Event_7451_Name = {
    Text = "Murder's Chant"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7452_Desc = {
    Text = "Koum was pulled away by you, narrowly dodging a hit. She nodded at you in gratitude and charged at the test subject again."
  },
  Event_7452_Name = {Text = "Arena"},
  Event_7453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7453_Desc = {
    Text = [[
Ding ding...
Coins clink into the wallet, producing a crisp and pleasant sound.
The wallet chews contentedly and lets out a burp.
Moved by your generosity, it lowers its guard completely.
Now, it is at your command.]]
  },
  Event_7453_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7454_Desc = {
    Text = [[
A brass coin dropped into the bottomless abyss, making no sound.
You waited patiently for five minutes. The wallet groaned in pain, finally spitting out a pool of black goo.
This was its silent protest]]
  },
  Event_7454_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Look into the Distance]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Listen Carefully]"
  },
  Event_7455_Desc = {
    Text = [[
Celeste shakes the compass in her hand. She doesn't speak, yet a faint song echoes around her.
Here, the sailors' chants weave and overlap across time, a chaotic yet powerful shanty guiding you and directing your gaze to the other end of the ship.]]
  },
  Event_7455_Name = {Text = "Shanty"},
  Event_7456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7456_Desc = {
    Text = [[
You step in and interrupt the little practice session.
From finger positioning to basic music theory, you mercilessly critique every detail.
The music comes to an abrupt halt, and both the boy and the teacher turn to you with the same eerie smile.
133, 355, 244...
The piano resumes, still horribly out of tune.
It turns out they can't hear a thing.]]
  },
  Event_7456_Name = {
    Text = "Piano Lesson"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7457_Desc = {
    Text = "A black mark found in the Domain can be sacrificed to the D-Mark for Relics or other spiritual projections. It will soon dissolve into black sludge after leaving the current area."
  },
  Event_7457_Name = {
    Text = "Black Sigil"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7458_Desc = {
    Text = "Finding that mysterious person is more important right now. With this thought, Ramona quickly left."
  },
  Event_7458_Name = {
    Text = "Others' Ears"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7459_Desc = {
    Text = [[
Indulge in consciousness, sinking into the deep sea following the path of prayers.
You see the golden country sunken at the bottom, see the immortal stone sculptures, and ultimately confront the flickering eyes in the shadows...
"Those who have not shed divine blood... leave, leave."]]
  },
  Event_7459_Name = {
    Text = "Dream Prayer"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Cursed Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7460_Desc = {
    Text = "Ramona pierced the test subject's throat with a single thrust. Koum tossed aside the lifeless body and charged toward the next target."
  },
  Event_7460_Name = {Text = "Arena"},
  Event_7461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7461_Desc = {
    Text = [[
The crow tears at its feathers, much like humans gnaw at their own bodies.
In this world of fear, such scenes are common. You can't save all living beings.]]
  },
  Event_7461_Name = {
    Text = "Molten Tear"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Soothe Koum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Shout for Koum]"
  },
  Event_7462_Desc = {
    Text = "The huge beast roars desperately at the small figure, attempting to awaken its former companions. However, its damaged vocal cords could only emit low, strange growls."
  },
  Event_7462_Name = {
    Text = "Call of Fellowship"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Leave] Look for Searchlight"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Enter the Mist] Lose Arg2 HP"
  },
  Event_7463_Desc = {
    Text = [[
Ahead lies a thick black fog; entering rashly will bring disaster.
Perhaps you should find a "Searchlight" to disperse the fog.]]
  },
  Event_7463_Name = {Text = "Unknown"},
  Event_7464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7464_Desc = {
    Text = [[
"A jaw that creaks like yours? I've never seen anything like it in my life."
You rejected Mr. Jawbone's rude request. Mr. Jawbone was extremely disappointed but managed to maintain his composure.
To thank you for your patient listening, he gave you a small gift.]]
  },
  Event_7464_Name = {Text = "Creak"},
  Event_7465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7465_Desc = {
    Text = [[
You agreed to this peculiar request and brought Mr. Jawbone along.
It rests in your pocket, constantly clicking. According to your companion's translation, its words mostly convey gratitude, nostalgia, and regret.
As for why he ended up like this? Mr. Jawbone is unwilling to elaborate, only saying:
"You know. When you gaze into @2, @2 gazes back at you."]]
  },
  Event_7465_Name = {Text = "Creak"},
  Event_7466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7466_Desc = {
    Text = [[
It slid into your bag like a piece of silk, the slight increase in weight barely noticeable, as if whispering a soft word of thanks.
After that, all was silent.]]
  },
  Event_7466_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7467_ChoiceDesc1 = {Text = "[Advance]"},
  Event_7467_Desc = {
    Text = [[
Click.
You insert the key into the lock and gently push the door open.
The whole process goes smoothly, boosting your confidence for the investigation ahead.]]
  },
  Event_7467_Name = {
    Text = "Rusted Door"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7468_Desc = {
    Text = [[
The voice chuckled deeply, and ripples formed in the liquid at your feet.
"You will soon realize that there is nothing you must do except face death."]]
  },
  Event_7468_Name = {
    Text = "That Which You Shouldn't Seek"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7469_Desc = {
    Text = "You discard this memory, pulling your consciousness from the illusory comfort."
  },
  Event_7469_Name = {
    Text = "Yesterday's Embrace"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7470_Desc = {
    Text = "Just a short slumber. Without comfort, how will you endure this endless night...?"
  },
  Event_7470_Name = {
    Text = "Yesterday's Embrace"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Pick Up the Photo] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7471_Desc = {
    Text = [[
It's a group photo.
Dejected people squat behind iron bars, their faces full of suffering.
One photo catches your eye. It's a thin young woman, her face blank.
Blasphemous growths entwine around her body.
You can't see her face, but you imagine she would be expressionless.]]
  },
  Event_7471_Name = {
    Text = "Verbatim Record"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7472_Desc = {
    Text = "That is the bird's remains."
  },
  Event_7472_Name = {
    Text = "Frenzied Murder"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7473_Desc = {
    Text = [[
You coldly rejected the pianist's request.
The pianist was utterly disappointed. He tore off his other ear and threw both of them out of the window.
"I don't need them anyway."
The melancholic pianist, tears streaming down his face, played a series of sorrowful notes.]]
  },
  Event_7473_Name = {
    Text = "Listen Closely"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7474_Desc = {
    Text = [[
The Spirit of Chaos's cries grew sharper, eventually turning into a piercing scream that echoed all around.
With your offerings and inescapable sorrow, It sank back into the mire.]]
  },
  Event_7474_Name = {
    Text = "Spirit of Chaos"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7475_Desc = {
    Text = "This is a One-Way Passage; you cannot return to the entrance through it."
  },
  Event_7475_Name = {Text = "Passage"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7476_Desc = {
    Text = [[
"Well then, please close your eyes and quietly sense the sound of its approaching footsteps."
Following the advice, you closed your eyes. In an instant, eerie beastly breathing roared in your ears.
When you opened your eyes in shock, the man from before had already vanished.]]
  },
  Event_7476_Name = {
    Text = "Uncanny Companion I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7477_Desc = {
    Text = [[
"That is truly regrettable."
The man adjusted his glasses, his voice low.
"However, if you have not heard of it, why come here so late at night?"
Without waiting for a response, he stepped aside.]]
  },
  Event_7477_Name = {
    Text = "Uncanny Companion I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7478_Desc = {
    Text = [[
You walk forward with resolute steps.
One step, two steps, three steps...
The footsteps behind you fade into the darkness.
You will meet again.]]
  },
  Event_7478_Name = {Text = "Oxfords"},
  Event_7479_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7479_Desc = {
    Text = "You half-bow, lifting the tray from the table beside you, transforming into the princess's guard.\nAs for who became the lucky princess—it was, of course, your most loyal partner.\n\"Spill tea on my face again, and you can forget about next month's class notes.\"\nThat's the princess's warning to you."
  },
  Event_7479_Name = {
    Text = "Perfect Disguise"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Listening Quietly] Enhance the Orison quality of a random card."
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[She is the one] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7480_Desc = {
    Text = [[
Sarah's screams echo in your mind. A faint, familiar voice emerges from nowhere, weakly whispering "Sister Sasha," "Sister Sasha."
"Sister Sasha, where are you?"]]
  },
  Event_7480_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7481_Desc = {
    Text = "\"...I can't say there's not some truth to that, but desire alone won't solve your Dissoluted Entity problem. Let's do something practical.\""
  },
  Event_7481_Name = {
    Text = "Rogues' Rule"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Tune] Receive 100 Black Sigils"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[Resonate] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards."
  },
  Event_7482_Desc = {
    Text = "Relics formed from stabilized Gnosis may perhaps bring forth harmonious melodies."
  },
  Event_7482_Name = {Text = "Dissonance"},
  Event_7483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7483_Desc = {
    Text = "\"It's a memory fragment from someone who has entered this dimension,\" Ramona replied, \"It's easy to encounter this while traversing dimensions. Be careful not to confuse it with your own memories.\""
  },
  Event_7483_Name = {
    Text = "Memory Shard: Whiskey"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7484_Desc = {
    Text = "Follow the rhythm of the heartbeat and chase the glimmer. You will not be separated, just as no one can precisely distinguish between day and night."
  },
  Event_7484_Name = {
    Text = "Left Atrium"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7485_Desc = {
    Text = [[
You continue to stroke those restless hands, trying to calm them down.
In no time, your world becomes completely silent.
Love always brings its own reward.]]
  },
  Event_7485_Name = {
    Text = "Gloomslough"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Struggle] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Give Up] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Be Wary] Receive 25 Black Sigils"
  },
  Event_7486_Desc = {
    Text = [[
Your mind is flooded with filth, a distinct sense of corruption.
The murky, foul-smelling liquid seeps in and takes over your thoughts entirely. Pain spreads across your fear-stricken face as you are trapped in an endless cycle of nightmares, unable to break free.]]
  },
  Event_7486_Name = {
    Text = "Skull Ulcer"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[It's the Memphis Ritual Mirror]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[It's a True North Compass]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7487_Desc = {
    Text = [[
"O Pioneer of Dimension Crossing."

An ancient voice echoes in your ears, as if from prehistory, transcending the ages.

In extreme tension, you hear the voice ask a somewhat familiar question.

"What is this turn object you dropped that allows you to draw cards at turn start?"]]
  },
  Event_7487_Name = {
    Text = "Voices from Beyond"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7488_Desc = {
    Text = "\"This isn't a scrapyard,\" Doll mutters, accepting it, \"but fine, I can still extract something useful.\""
  },
  Event_7488_Name = {Text = "Nameplate"},
  Event_7489_ChoiceDesc1 = {
    Text = "Random Common Orison"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7490_Desc = {
    Text = [[

You read the weathered, tattered paper: "Twins", "Soak", "Sacrifice", "Ineffective"...
A jumble of fragmented concepts and cryptic prose, only a throbbing brain proves that you have read this scrap of paper.]]
  },
  Event_7490_Name = {
    Text = "Cipher-Edict: Part II"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[What Price Are You Willing to Pay?] Enhance the Orison quality of a random card."
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Offer Them an Expired Bloody Mary] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7491_Desc = {
    Text = [[
"Welcome, my precious guest. Feel free to choose; all this dazzling array exists to await you."
"Uh, sorry to disturb, may I ask... are you the twin sister of Lady Daffodil?"
"I am Lady Daffodil myself. May I ask what brings you here today...?"
"Sorry, sorry, you have become even more charming than before. I didn't recognize you. Do you remember? Twenty years ago, you drove away a freak from my bar... Yesterday, the nightmare returned. It occupied the bar, bringing along its kin in great numbers..."]]
  },
  Event_7491_Name = {
    Text = "Memory Shard: Yesterday's Dream"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive 30 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Leave"
  },
  Event_7492_Desc = {
    Text = "The second raven departed, its tail feathers revealing a hint of white, reminiscent of bones."
  },
  Event_7492_Name = {
    Text = "Raven's Gaze"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Take a Gamble] Develop \"(Skill.Arg1)\" and try your luck"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Forget It] Receive 25 Black Sigils"
  },
  Event_7493_Desc = {
    Text = [[

"Care to take a gamble? Guess our numbers! For just a small price!"
The discarded dice buzzed noisily, as if speaking to you.
"Roll me! Roll me!"
"The only one! The last one!"
Alright, just one...
You picked up a chip. You decide...]]
  },
  Event_7493_Name = {
    Text = "Eternal Gamble"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resist Malice] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Embrace Malice] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Clear-Minded Departure] Receive 25 Black Sigils"
  },
  Event_7494_Desc = {
    Text = [[
Evil thoughts become blades, or sharp teeth.
They gnaw at the weakening sanity in the Domain, devouring the remaining will, just as reality inflicts cruelty upon you...]]
  },
  Event_7494_Name = {
    Text = "Unbidden Thought"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Struggle Fully] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Light the Web] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Wait Quietly] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7495_Desc = {
    Text = "Fine threads, like spider webs, entwine you; at this moment, you have clearly become the Domain's prey."
  },
  Event_7495_Name = {Text = "Entrenched"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Recipient: ∞] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Recipient: Self] Destroy a Card"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Recipient: Teacher] Receive 25 Black Sigils"
  },
  Event_7496_Desc = {
    Text = [[
He offered the Domain Walker a chance: a chance to connect with the unknown.
A few tattered papers, a typewriter exuding ink, and an unknown, one-way recipient.
Perhaps the will can determine where your message is conveyed.]]
  },
  Event_7496_Name = {Text = "Monologue"},
  Event_7497_ChoiceDesc1 = {Text = "[Accept]"},
  Event_7497_ChoiceDesc2 = {Text = "[Reject]"},
  Event_7497_Desc = {
    Text = [[
Whispers echo in the empty space.
"Oh, that fool who keeps muttering 'win or die,' the infamous gambler. You'd better stay away from him."
A thin, slumped figure tosses a few coins to you, the metallic clink landing in your palm.
"Let's play a round."]]
  },
  Event_7497_Name = {
    Text = "Notorious Gambler"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[We Are All Safe] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Who Are You?] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7498_Desc = {
    Text = [[
The typewriter abruptly spits out ink, with an eye-piercing number of exclamation marks.
"Doll, are you alright??? Why did you vanish when the Keeper disappeared too??? Please, if you're safe, send a message!!! William's hair will fall out if we wait any longer!!!"]]
  },
  Event_7498_Name = {
    Text = "Urgent Missive"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7499_Desc = {
    Text = "You apply the last piece of plaster. She bursts into a sharp laugh, black mist entwines upward, and her floating figure vanishes from your sight."
  },
  Event_7499_Name = {
    Text = "Flesh Reforged"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7500_Desc = {
    Text = [[
You take out the Silver Key, holding it with sorrow and reverence. A faint, mist-like glow envelops you.
In the silence, only a sigh lingers.]]
  },
  Event_7500_Name = {
    Text = "Watcher's Gaze"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7501_Desc = {
    Text = [[
Lingering gazes continue to watch you, as the cells beneath your skin scream and flee, your veins writhing like worms.
You feel a flow of power surging, bursting amidst the grotesque state of your limbs]]
  },
  Event_7501_Name = {
    Text = "Watcher's Gaze"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rouse a random Awakener"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Stare] Choose an Awakener to Rouse, reduce that Card's Arithmetica Cost by 2, but develop \"(Skill.Arg1)\"."
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7502_Desc = {
    Text = "Dimensional tunnels link myriad universes, with countless eyes glaring at you as you sneak through the supreme passage."
  },
  Event_7502_Name = {
    Text = "Divine Gaze"
  },
  Event_7503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7503_Desc = {
    Text = [[
It's chaos, utter chaos.
All thoughts are swept away in an instant, carried off by the torrent of the mind.
In the depths of the brain, only endless confusion and pain remain, sinking together.]]
  },
  Event_7503_Name = {
    Text = "Inspiration Surge"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7504_Desc = {
    Text = "There seems to be something within the oversaturated D-Slime... Use the Silver Key to convert it into your own power."
  },
  Event_7504_Name = {
    Text = "Extraction Point"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive 35 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Leave"
  },
  Event_7505_Desc = {
    Text = "A crow flew away, leaving a single black feather drifting down."
  },
  Event_7505_Name = {
    Text = "Raven's Gaze"
  },
  Event_7506_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7506_Desc = {
    Text = [[
Here lies the Abyssal Battleground, where battle demands both courage and wisdom.

Sharpen your eyes and observe your opponents. You don't need to defeat them all; just take down their leader!]]
  },
  Event_7506_Name = {
    Text = "Demonic Trial"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Connect] Recover Arg2 HP."
  },
  Event_7507_Desc = {
    Text = "The mist clings heavy as your badge flickers a pale silver glow. The communicator crackles to life. Someone's calling."
  },
  Event_7507_Name = {Text = "Junction"},
  Event_7508_ChoiceDesc1 = {Text = "[Tail Him]"},
  Event_7508_ChoiceDesc2 = {
    Text = "[Greet Them]"
  },
  Event_7508_Desc = {
    Text = [[
Tap. Tap. Tap.
A white figure slowly moves through the thick fog, like a ship sailing into a silent night.
From behind, it appears to be a boy.
Listening to his weary footsteps, you make a decision in your heart.]]
  },
  Event_7508_Name = {Text = "Finale I"},
  Event_7509_ChoiceDesc1 = {
    Text = "[Hesitantly Agree]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Express Caution]"
  },
  Event_7509_Desc = {
    Text = [[
The Dissolute cried out as it fell, and you're surprised to find Clementine standing behind it.
"I'm here to say goodbye," she says. "As a show of thanks, I can give you some clues. However... that will require your trust.
Allow me to hypnotize you, and I will share with you all that I know."
Can you trust her?
"Be careful," Ramona warned, "She must have ulterior motives."]]
  },
  Event_7509_Name = {
    Text = "Hypnotherapy"
  },
  Event_7510_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7510_Desc = {
    Text = "You focus, and the illusion dissipates like ink in water. You move forward, but the shadow on your heart remains."
  },
  Event_7510_Name = {Text = "Illusion"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Pitiful Creature?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Evolved Human?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Who are you?]"
  },
  Event_7511_Desc = {
    Text = [[
The man you encountered for the sixth time stood atop the steel frame, overlooking the land. The fierce wind whipped his long hair back, revealing the true form of a snake.
His gaze fixed on you, then shifted toward the distant darkness.
"Ah, what a pitiful creature it is.
The feeling of betrayal must taste as sweet as that of a <Bold:evolved> human."]]
  },
  Event_7511_Name = {
    Text = "Uncanny Companion VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7512_Desc = {
    Text = "Who would pay attention to a roll of film under the gaze of a hellhound?"
  },
  Event_7512_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7513_Desc = {
    Text = "Don't look, don't discuss, don't listen, and don't even think— the choice of the wise."
  },
  Event_7513_Name = {
    Text = "Rune Frenzy"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Leave] Destroy any 2 Cards"
  },
  Event_7514_Desc = {
    Text = [[
Through the cacophony of noises, you can barely make out a strange buzzing, like the wings of an insect. The Silver Key vibrates fiercely against your chest; compelled by some force, you look up to see a huge, black hole appear in the sky.
"What a pity, to be sure, but it's alright. We will meet again, my esteemed Pupilless Eye."]]
  },
  Event_7514_Name = {
    Text = "Hypnotherapy"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7515_Desc = {
    Text = "You can ignore everything around you, but not the beating of your heart. It speeds up its rhythm, urging and reproaching you."
  },
  Event_7515_Name = {
    Text = "Left Atrium"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7516_Desc = {
    Text = [[
"That's great!!! William's hair is safe now!!"
The telegram's text is brief, but the words practically vibrate off the page.]]
  },
  Event_7516_Name = {
    Text = "Urgent Missive"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Tell Him the Truth] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Conceal the Truth] Engrave 1 out of 3 Orisons"
  },
  Event_7517_Desc = {
    Text = "\"Please save me.\"\nThe melancholic traveler grasped your hand. He had been wandering here for hundreds of years.\n\"I am a soldier, tasked to go to the far east to fight against the heretics.\nI crossed dense forests, waded through rivers, yet I lost my way, returning to the same place over and over again.\nSomething watches me from the darkness. I cannot see it, but I know. It has always been watching me.\nNow I just want to go home...\"\nYou look at the floating shadows behind him. They were initially blurry, then gradually became clearer—it was a gaping mouth, hungrily awaiting the lost souls preserved for a hundred years."
  },
  Event_7517_Name = {Text = "Devourer"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Into the Darkness]"
  },
  Event_7518_ChoiceDesc2 = {Text = "[Farewell]"},
  Event_7518_Desc = {
    Text = [[
"Celeste, you will help me this time, right?"
The girl paced nervously, glancing back at the quiet Awakener from time to time.
She did not respond to the girl, but as the girl's expression grew more anxious, a breeze lifted the white veil, gently pushing her in a certain direction.
"I will protect you."
I will protect you, even though I once failed in this matter of "protection."
But this time, I will not let you be lost in the darkness alone.]]
  },
  Event_7518_Name = {
    Text = "Divine Maiden's Vigil"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Leave] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7519_Desc = {
    Text = "Some songs are ancient, lost long before the flood spread; others are fresh, about last New Year, when a wife bought new gloves from the Londinium Department Store... After the chaotic overlap of emotions, nothing remains but an empty void in the heart."
  },
  Event_7519_Name = {Text = "Shanty"},
  Event_7520_ChoiceDesc1 = {
    Text = "[Expel Colors] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Embrace Colors] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Turn and Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7520_Desc = {
    Text = [[
Murphy followed closely but froze at a corner.
Flowing iridescence swirled, making the air sigh.
"Mur@1..."
Is it the ghost of a drowned soul trapped on the Sona-Nyl? Or a departed loved one following the living?]]
  },
  Event_7520_Name = {
    Text = "Hue of Longing"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7521_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7521_Desc = {
    Text = "A familiar voice whispered in my ear, warm and comforting. But when I tried to follow it, the sound abruptly stopped."
  },
  Event_7521_Name = {
    Text = "Anomalous Contact"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7522_Desc = {
    Text = [[
"That was a blasphemous melody."
You covered your ears, blood flowing out, and affirmed this with certainty.]]
  },
  Event_7522_Name = {
    Text = "Forbidden Tone"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7523_Desc = {
    Text = "The colors vaguely twist into two human-like shapes, but they remain motionless in that corner, offering you their final blessings with their gaze."
  },
  Event_7523_Name = {
    Text = "Hue of Longing"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Listen] Acquire 1 out of 3 Golden Relics"
  },
  Event_7524_Desc = {
    Text = [[
Daffodil's voice paused for a moment.
"Oh, did you choose this? A nice choice. As a reward, I will specially give you a gift."]]
  },
  Event_7524_Name = {Text = "Hint Time"},
  Event_7525_ChoiceDesc1 = {
    Text = "[Keep Asking] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandon Inquiry] Destroy a Card"
  },
  Event_7525_Desc = {
    Text = "\"Hmm, a wise choice. Facing such a formidable enemy, surely you'd want to know yourself and your opponent? However, knowing too many secrets about dimensions might disturb your mind, you know?\""
  },
  Event_7525_Name = {Text = "Hint Time"},
  Event_7526_ChoiceDesc1 = {
    Text = "[Persistent Inquiry] Enrage Daffodil and enter battle."
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Give up asking] Receive a minor penalty"
  },
  Event_7526_Desc = {
    Text = "\"Oh? Even now, you're still thinking about tracking me? Little one, being too greedy isn't good, you know?\""
  },
  Event_7526_Name = {Text = "Hint Time"},
  Event_7527_ChoiceDesc1 = {
    Text = "[Focus] Increase Max HP by Arg1"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignore] Engrave the Orison \"(EnchantConfig.Arg1)\" on 2 random Command Cards, but develop \"(Skill.Arg2)\" twice."
  },
  Event_7527_Desc = {
    Text = [[
You chase after the Hellhound through the streets of the small town.
Cold snowflakes begin to fall from the sky, gently landing on your cheeks and chest, soothing your restless heart.]]
  },
  Event_7527_Name = {Text = "Snow"},
  Event_7528_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7528_Desc = {
    Text = [[
You wave your arms, trying to drive away these annoying crows.
They caw mockingly, seemingly laughing at your foolishness and weakness.
Nevertheless, your courage moves them, and you are rewarded accordingly.]]
  },
  Event_7528_Name = {
    Text = "Song of Crows"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[About Lily] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[About Hellhound] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7529_Desc = {
    Text = [[

Cross the endless door, from a distant and unreachable place, the voice of Daffodil arrives.
"This is Daffodil's hint time."]]
  },
  Event_7529_Name = {Text = "Hint Time"},
  Event_7530_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7530_Desc = {
    Text = [[
You remain resilient, chanting while staying true to yourself.
You don't trust the whispers in your ears, relying solely on human reason.
However... when the solid ground you depend on is engulfed by thick black sludge, gouging out your eyes to use as tools for observation will be your only choice in your final moments.]]
  },
  Event_7530_Name = {
    Text = "Song of Crows"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Acquire the Golden Relic \"(RelicConfig.Arg1)\" but develop \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Focus on Battle] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7531_Desc = {
    Text = [[
The silhouette of the Hellhound shifts.
Its body links the cracks in the walls, revealing eerie Illusions.]]
  },
  Event_7531_Name = {
    Text = "From Perspective"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7532_Desc = {
    Text = [[
"Meow, meow meow, meow meow meow..."
You strained your voice, trying hard to appear weak and harmless.
"Meow! Meow meow! Meow meow meow!"
The group of cats seemed to accept your goodwill, responding with cheerful calls. Your cries echoed back and forth, day and night without pause, even scaring the moon into hiding behind the clouds.]]
  },
  Event_7532_Name = {
    Text = "City of Cats"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7533_Desc = {
    Text = [[
Just a struggling creature seeking a piece of driftwood to rest on...
You sigh as the black fluid from the butterfly's tail drips onto your cheek.]]
  },
  Event_7533_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7534_Desc = {
    Text = [[
You used every ounce of strength to get far away from the cat group.
When you looked back, the cats had already resumed their usual activities: grooming, napping, and even fighting with each other...
Honestly, they don't care about humans.]]
  },
  Event_7534_Name = {
    Text = "City of Cats"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7535_Desc = {
    Text = [[
You toss the remaining chunks of meat into the swarm of cats.
The cats surge forward like a black tide, frantically tearing at the meat before quickly scattering.
Unfortunately, the meat is expired. It fills their empty stomachs but brings little satisfaction.]]
  },
  Event_7535_Name = {
    Text = "City of Cats"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Eye Contact] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Stop Resisting] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7536_Desc = {
    Text = [[
Countless eyes whisper around your ears.
"We journey, we halt, we stride for tens of thousands of years or more.
As the sun fades under our watchful gaze, as life on ancient Earth is swallowed by floods.
We have long been captivated by the mysteries of the universe."]]
  },
  Event_7536_Name = {Text = "Eye"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Feel Panic] Rouse a random Awakener"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Feel Content] Choose an Awakener to Rouse, reduce that Card's Arithmetica Cost by 2, but develop \"(Skill.Arg1)\"."
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7537_Desc = {
    Text = [[
You've seen a sky devoid of the moon and stars, with countless enlarged pupils hanging above.
It feels as if you could reach out and pluck them down, splattering blood and flesh.
But when you open your hand, there's nothing there.
The eyes of fate watch you unblinkingly, having found a sparkling grain of sand in the chaotic universe.]]
  },
  Event_7537_Name = {Text = "Dome's Eye"},
  Event_7538_ChoiceDesc1 = {
    Text = "[Lower Hands] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7538_Desc = {
    Text = "Screeching, endless screeching—\nThe Raven Singer, cloaked in glossy black feathers, its sharp beak glinting coldly, pierces your eardrums with each mournful cry.\nUncover your ears!\nThe nocturnal choir of crows hungers for the raw tremors within your cowering body."
  },
  Event_7538_Name = {
    Text = "Murder's Chant"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] Receive 50 Black Sigils"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Feed] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7539_Desc = {
    Text = "You accidentally entered the black cat's territory.\nCountless eyes opened in the darkness, filled with curiosity, scrutiny, and alertness... but no kindness.\nEmerald green, amber yellow, peacock blue...\nYou felt as if you were immersed in a sea of sparkling gems.\nTo escape, you—"
  },
  Event_7539_Name = {
    Text = "City of Cats"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7540_Desc = {
    Text = "You notice an unusual hand. It is delicate, fair, and remains calm throughout.\nMore importantly—you recognize it as your own.\nWithout hesitation, you wrench it off forcefully.\nCountless shrill screams echo, and the swamp finally vanishes."
  },
  Event_7540_Name = {
    Text = "Gloomslough"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7541_Desc = {
    Text = [[
"A wise decision," says the empty-handed figure. "Preordained choices lead to predetermined outcomes, while unpredictable actions pave the way to new futures."
A subtle sense of hope gently envelops you. The silhouettes vanish, leaving you clutching your chest, unsure if it was a projection or a phantasm brought on by mental stress.]]
  },
  Event_7541_Name = {
    Text = "Forking Trails"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Praise It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Taunt It] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_7542_Desc = {
    Text = [[
The mind says: Chains bind my forebrain, my brainstem, my cerebral cortex, yet they cannot bind the more than 10 billion tiny cells pursuing the truth.
You say: Who trapped you here? What about your body?
The mind says: Body? Don't joke! In the past, they called me "Old Johnny the Pork Seller".
When I had a body, I couldn't even comprehend arithmetic under ten.
But after the curator removed my redundant flesh, look at what I've become! A physicist, a philosopher, and an amateur poet.]]
  },
  Event_7542_Name = {
    Text = "Philosopher's Brain"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Prove Goldbach's Conjecture] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Journey's End] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Refuse to Ask] Receive 50 Black Sigils"
  },
  Event_7543_Desc = {
    Text = [[
When you picked up the spirit board, a young woman's voice rushed into your mind.
"Ask me anything. I know everything."
"From my answers, you will receive the gift of fate."]]
  },
  Event_7543_Name = {
    Text = "Spirit Board"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7544_Desc = {
    Text = "You read the tattered, fragmented paper, broken sentences spilling from your mouth. Words like \"Ancestors,\" \"Divus,\" \"Eternal Death,\" and \"Long Memory\" flood your mind, agitating your already fragile nerves plagued by nightmares."
  },
  Event_7544_Name = {
    Text = "Cipher-Edict: Part I"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7545_Desc = {
    Text = [[
Black sludge drips onto your face, causing a tingling itch.
Unable to bear it, you swipe at the butterfly.
The butterfly evades your hostile action and silently vanishes into the distance.]]
  },
  Event_7545_Name = {
    Text = "Obsidian Lepidoptera"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Leave] Look for Searchlight"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Enter the Mist] Lose Arg2 HP"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7546_Desc = {
    Text = [[
Ahead lies a thick black fog; entering rashly will bring disaster.
Perhaps you should find a "Searchlight" to disperse the fog.]]
  },
  Event_7546_Name = {Text = "Unknown"},
  Event_7547_ChoiceDesc1 = {
    Text = "[Accept the Illusion] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Deny the Illusion] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7547_Desc = {
    Text = [[
Beneath the heavy, dark iron bridge, a shimmering butterfly suddenly flutters out from the silent, reed-covered riverbank.
The butterfly gently lands in your palm, silencing the dreadful howls. Instead, you hear the rhythmic chants of workers moving steel, the pounding of hammers, and the crisp clinking of rivets...]]
  },
  Event_7547_Name = {
    Text = "Steelbridge Mirage"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Chase the Crows] Receive 40 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Keep Chasing the Child] Receive 25 Black Sigils and leave."
  },
  Event_7548_Desc = {
    Text = [[
A raven perched on the chandelier.
Two ravens perched on the chandelier.
Three ravens perched on the chandelier.
.....
The black creatures twisted their necks, staring maliciously from the alleyway chandelier. Their shadowed heads seemed to share a single body submerged in D-Slime.]]
  },
  Event_7548_Name = {
    Text = "Raven's Gaze"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Leave] Obtain a Silver Relic when fewer than 3 Awakeners are awakened \"(RelicConfig.Arg1)\""
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Leave] Obtain a Golden Relic when at least 3 Awakeners are awakened\"(RelicConfig.Arg1)\""
  },
  Event_7549_Desc = {
    Text = [[
You ignore the mark and step forward.
<Italic:The weight of awakened Gnosis is so heavy>, the mark widens and twists with your steps, as if a hand could reach out from the crack at any moment and drag you into the depths.]]
  },
  Event_7549_Name = {
    Text = "Crawling Fissure"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Return the Gaze] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Avoid the gaze] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7550_Desc = {
    Text = "You sense a gaze—a transcendent, higher-than-Domain look—watching you and the girl in front of you.\nYour breathing quickens, and primal fear screams from deep within your mind."
  },
  Event_7550_Name = {
    Text = "Whose Gaze?"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Keep Searching] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_7551_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7551_Desc = {
    Text = "A faint light appeared, bright and warm. However, it suddenly vanished just as you tried to follow it."
  },
  Event_7551_Name = {
    Text = "Anomalous Contact"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7552_Desc = {
    Text = "Softly echoing Their chants, the warm currents bring you blessings of home."
  },
  Event_7552_Name = {Text = "Sea Shanty"},
  Event_7553_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7553_Desc = {
    Text = "You spot a faint light ahead; you've finally broken through the suffocating fog."
  },
  Event_7553_Name = {Text = "Chaos Mist"},
  Event_7554_ChoiceDesc1 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_7554_Desc = {
    Text = [[
The remaining Gnosis in the Domain interlinks, entangling into an unstable force field.
Perhaps, you can untwine the Gnosis and pave a path forward for yourself.]]
  },
  Event_7554_Name = {
    Text = "Twined Path"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_7555_Desc = {
    Text = [[
The remaining Gnosis in the Domain interlinks, entangling into an unstable force field.
Perhaps, you can untwine the Gnosis and pave a path forward for yourself.]]
  },
  Event_7555_Name = {
    Text = "Twined Path"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7556_Desc = {
    Text = [[
The remaining Gnosis in the Domain interlinks, entangling into an unstable force field.
Perhaps, you can untwine the Gnosis and pave a path forward for yourself.]]
  },
  Event_7556_Name = {
    Text = "Twined Path"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7557_Desc = {
    Text = [[
The remaining Gnosis in the Domain interlinks, entangling into an unstable force field.
Perhaps, you can untwine the Gnosis and pave a path forward for yourself.]]
  },
  Event_7557_Name = {
    Text = "Twined Path"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7558_Desc = {
    Text = "You still have several fierce battles ahead. Now is not the time for a leisurely investigation."
  },
  Event_7558_Name = {
    Text = "Organ Registry"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7559_Desc = {
    Text = [[
The characters on the paper suddenly become complete and vivid, with terrifying words that could shake the faith and foundation of any unaware sufferer. The more you read, the more confused and fearful you become, uncontrollably scratching your scalp.
Suddenly, those cursed symbols vanish. Ramona interrupts your reading and forcibly stuffs the pages into the suitcase.]]
  },
  Event_7559_Name = {
    Text = "Cipher-Edict: Part II"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7560_Desc = {
    Text = [[
Joy, sorrow, sadness, distress... These are your emotions.
You, and countless versions of you across different dimensions.]]
  },
  Event_7560_Name = {Text = "Indulgence"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Listen Quietly] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[She is Here] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7561_Desc = {
    Text = [[
The screams of Dissolutes echo in your mind. A faint but familiar voice emerges from the blackness, weakly whispering:
"Sister Sasha," "Sister Sasha..."
"Sister Sasha, where are you?"]]
  },
  Event_7561_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7562_Desc = {
    Text = [[
"Join Him, join them, join us.
Become His Guardian, become His proxy.
Let His Dream guide your way..."
The chaotic prayers stir your mind. After the voices fade, you find yourself drenched in sweat.]]
  },
  Event_7562_Name = {
    Text = "Dream Prayer"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Never Heard of It]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[I've heard of it]"
  },
  Event_7563_Desc = {
    Text = [[
"Excuse me, can I take a moment of your time?
I hope to delay you for a few minutes to introduce some local folklore.
Have you heard of a creature called 'Cerberus'?"]]
  },
  Event_7563_Name = {
    Text = "Uncanny Companion I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Quit Thinking] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Chase Inspiration] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_7564_Desc = {
    Text = [[
The port is under attack, with a mysterious freighter coming and going and finned "new friends"... Is this a meticulously prepared trap? Or yet another unexpectedly perilous journey?
Reality and reason tug and twist against each other, countless inspirations and thoughts surging from the mind.]]
  },
  Event_7564_Name = {
    Text = "Inspiration Surge"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Elworth's Volcano?] Increase Max HP by Arg1"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Recall] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7565_Desc = {
    Text = "Black tears fall from Lily's cheeks. \"We've seen it, Mom,\" she whispers softly, \"in the volcano of Elworth...\""
  },
  Event_7565_Name = {
    Text = "Volcanic Memory"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7566_Desc = {
    Text = "\"Sea@1... farer...\"\nRunes flicker in and out of sight before your eyes, and you can't help but reach out into the void, trying to grasp them—\n\"What are you doing?! They're catching up!\"\nA mysterious girl drags you toward the other end of the deck, interrupting your connection with the runes.\nBut there's definitely some power that left a mark on your fingertips."
  },
  Event_7566_Name = {
    Text = "Rune Frenzy"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7567_Desc = {
    Text = "You have no interest in those mystical ramblings, nor do you want to risk madness by stepping into the dark night."
  },
  Event_7567_Name = {
    Text = "Distress Letter"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7568_Desc = {
    Text = "No matter what, the duty of the Keeper swells in your chest. You cannot abandon the hope of finding the sender, even if it is so vague and obscure."
  },
  Event_7568_Name = {
    Text = "Distress Letter"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Observe It] 100% chance to get 25 Black Sigils"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Pet It] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_7569_Desc = {
    Text = "A black cat suddenly sprang out from a side alley, affectionately entwining around your feet. Its eerie green vertical pupils flashed with a chilling light, as if saying, \"Don't chase me, come play with me for a while.\"\n\"You have already seen Him. He is right beside you—those polluted by madness, the frenzied shadows... Do not gaze directly at His outline.\""
  },
  Event_7569_Name = {
    Text = "Nightshade Sprite"
  },
  Event_7570_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7570_Desc = {
    Text = "\"Impossible, unbelievable!\" The voice screamed, \"That woman who sent me to this demon is NOT Sister Sasha!\""
  },
  Event_7570_Name = {
    Text = "\"Sister Sasha\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7571_Desc = {
    Text = "\"Received. We will proceed with the basic inventory delivery. Please check and confirm.\""
  },
  Event_7571_Name = {
    Text = "Reinforcement Hail"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7572_Desc = {
    Text = "It is no longer useful."
  },
  Event_7572_Name = {
    Text = "Ancient Legacy"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Look Closely] Engrave 1 out of 3 Orisons"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Rip Poster] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_7573_Desc = {
    Text = [[
A candelabrum commonly seen in a wax museum.
By the eerie orange glow, you notice a hand-drawn poster on the wall.]]
  },
  Event_7573_Name = {
    Text = "Darkened Mirth"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7574_Desc = {
    Text = [[
"Lily has her own heart; she doesn't need to listen to anyone." You answer calmly.
Francis snorts, offering no response.]]
  },
  Event_7574_Name = {Text = "Her Choice"},
  Event_7575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7575_Desc = {
    Text = [[
It's a group photo.
Dejected people squat behind iron bars, their faces full of suffering.
One photo catches your eye. It's a thin young woman, her face blank.
Blasphemous growths entwine around her body.
You can't see her face, but you imagine she would be expressionless.]]
  },
  Event_7575_Name = {
    Text = "Verbatim Record"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7576_Desc = {
    Text = [[
You gaze obsessively at these shining jewels, unknowingly grasping a gaunt hand of black slime.
It merely tightened its grip slightly before releasing your hand.
Nothing happened, save for a wisp of black mist that slipped into your sleeve along your fingertips.]]
  },
  Event_7576_Name = {
    Text = "Overturning Talons"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Close the Lid] Engrave 1 out of 3 Orisons"
  },
  Event_7577_Desc = {
    Text = [[
The piano by the wall has an open lid. Its keys are yellowed, and the edges are cracked, revealing the wood underneath, but every key has been wiped clean.
It is a source of joy for so many.]]
  },
  Event_7577_Name = {
    Text = "Nursery Rhyme"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7578_Desc = {
    Text = [[
The spear-wielder groans, whimpering like a bullied child.
The sound vanishes instantly, and the other two Seafarers also disappear... It turns out it was just an Illusion reflected by the Domain.]]
  },
  Event_7578_Name = {
    Text = "Relentless Hunt"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7579_Desc = {
    Text = [[

"The correct answer."
The owner of the voice was very satisfied with this answer, and a shining object was thrown out of the water.
"Remember, everything has a price."]]
  },
  Event_7579_Name = {
    Text = "Voices from Beyond"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Develop a random Symptom."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7580_Desc = {
    Text = "Blurry faces suddenly appear, surrounding you and moaning desperately with nonexistent vocal cords."
  },
  Event_7580_Name = {Text = "Illusion"},
  Event_7581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7581_Desc = {
    Text = [[
You ignore the mark and step forward.
But it seems enraged, expanding and twisting with each step you take, as if a hand might reach out from the crack to drag you in.]]
  },
  Event_7581_Name = {
    Text = "Crawling Fissure"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7582_Desc = {
    Text = "You didn't fall for it. You turned around decisively and left."
  },
  Event_7582_Name = {
    Text = "Crawling Fissure"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7583_Desc = {
    Text = "You notice the unusual crack and squat down to inspect it. Strangely, the crack that was spreading just moments ago suddenly comes to a halt, falling into eternal silence."
  },
  Event_7583_Name = {
    Text = "Crawling Fissure"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7584_Desc = {
    Text = "\"No, it's a clear mind. Determination won't help you deal with the Dissoluted Entity, Keeper. Think through your strategy.\""
  },
  Event_7584_Name = {
    Text = "Rogues' Rule"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7585_Desc = {
    Text = [[
You can't resist the urge within.
Your fingers wander and play on the keyboard like lost children in a forest...
Gradually, butterflies emerge from the typewriter.
One, two, three...
On your face, on your fingers, swarms of butterflies sparkle like fireworks, glowing like gems in the dark.
This typewriter has no practical use, but it is a master at creating beauty.]]
  },
  Event_7585_Name = {Text = "Eye"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Tie the Hen]"
  },
  Event_7586_Desc = {
    Text = "The Rye Specialty: Lively hen, a culinary temptation!"
  },
  Event_7586_Name = {
    Text = "Making Traps"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_7587_Desc = {
    Text = "Cheap but effective traps!"
  },
  Event_7587_Name = {
    Text = "Making Traps"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Set up a Trap]"
  },
  Event_7588_Desc = {
    Text = "A metal animal trap, the lazy hunter's best friend."
  },
  Event_7588_Name = {
    Text = "Making Traps"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Check] Acquire the Golden Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Disregard] Receive 50 Black Sigils"
  },
  Event_7589_Desc = {
    Text = "You take shelter in a narrow cave crevice to escape the storm. But you know you can't stay here for long—if those black-robed figures find you, there will be no escape.\nIn a corner of the crevice, you unexpectedly discover a telegraph machine."
  },
  Event_7589_Name = {
    Text = "Silent Telegram"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Check the Film] Enhance the Orison quality of 2 random cards."
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Check Camera] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7590_Desc = {
    Text = "Like pulling out a piece of innards, the film inside the camera was torn to shreds, discarded gutted and ignored.\nA blinding white flash, the abandoned camera at the street corner tilted, its shutter clicked by an unseen force.\n\"Click—\"\nYour shocked, stunned expression was faithfully captured on the film"
  },
  Event_7590_Name = {
    Text = "Record Innocence"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Strangle the Singer] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Trip the Dancer] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Steal the Poet's Manuscript] Receive 50 Black Sigils"
  },
  Event_7591_Desc = {
    Text = "You are blocked by three viscous figures.\nOne figure sings in a hoarse voice with eerie lyrics. You cover your ears and bypass it.\nAnother figure dances stiffly with hesitant steps. You close your eyes and evade it.\nThe last figure recites fragmented poetry with disjointed sentences. Unable to bear it any longer, you—"
  },
  Event_7591_Name = {
    Text = "Narrowpath Brute"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7592_Desc = {
    Text = "\n\"No! The progress of humanity does not depend on history or technology, but on mice.\"\n\"Rats ushered in the dark era, and only then did humanity welcome the dawn of revival.\"\n\"Humanity needs you—though not everyone understands this.\"\nThe mice were somewhat confused by your lengthy discourse, but they let you go anyway."
  },
  Event_7592_Name = {Text = "Plague"},
  Event_7593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7593_Desc = {
    Text = [[
You strain to see through the spasms in your optic nerve...
There appears to be a torn, perfectly circular magic circle.
Inside are countless arcs, static yet flowing, mesmerizing.]]
  },
  Event_7593_Name = {
    Text = "From Perspective"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7594_Desc = {
    Text = [[
<Bold>Rogers Wax Museum
44 Nanhua Street, Londinium City @2 District
Visiting Hours: 21: 00-6: 00
3: 00 stop entry (closed on weekends)

<Bold>Current Exhibition
Vladimir @2:
Philosophy of Smile]]
  },
  Event_7594_Name = {
    Text = "Darkened Mirth"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Eye Contact] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Turn Your Back] Receive 25 Black Sigils"
  },
  Event_7595_Desc = {
    Text = "You are not supposed to see the stars.\nIn the Domain of the Sona-Nyl, the sky shimmers with flowing brilliance, concealing the stars and moon.\nIn the dim cabin, you shouldn't be able to see the stars either.\nThere should only be sparse incandescent bulbs and old lanterns here—so why do you still feel the gaze from above?"
  },
  Event_7595_Name = {Text = "Peek"},
  Event_7596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7596_Desc = {
    Text = [[

You choose to bravely stare into the eyes.
They are brilliant stars, shimmering in the dark.
Then they laughed and turned into countless crescent moons.
The eyes said, "You are not afraid of gazes. You shouldn't be afraid of... Long time no see, @2."
Before they vanished, they gifted you a small token as a "reunion memorial."]]
  },
  Event_7596_Name = {Text = "Eye"},
  Event_7597_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7597_Desc = {
    Text = "Railway bridge, Londinium's blood and nerves, linking the heart and limbs of the city. As long as the sun hasn't set here, Londinium's heart will pulsate vigorously."
  },
  Event_7597_Name = {
    Text = "Steelbridge Mirage"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7598_Desc = {
    Text = "An exquisite fugue, composer unknown.\nCountless voices with similar themes intertwine, each note as precise and cold as a surgeon's scalpel.\nPrecise and splendid—this is Rogers' aesthetic.\nFuga, take flight!"
  },
  Event_7598_Name = {Text = "Bad Taste"},
  Event_7599_ChoiceDesc1 = {
    Text = "[Greet Out Loud]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Seek Help]"
  },
  Event_7599_Desc = {
    Text = [[
The moment you lean on the ship's railing, you see a girl in a white dress.
Noble, pure, ethereal... and vaguely familiar.
Where have you seen her before? You struggle to sift through your chaotic memories when she suddenly seems to become aware of your presence, locking eyes with you across the void.
Her eyes are as calm as the ocean in early spring, yet you strangely sense something from them...
It seems she is waiting for you to greet her, even if only to talk about today's weather.]]
  },
  Event_7599_Name = {
    Text = "Whitegowned Maiden"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Praise It] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Taunt It] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_7600_Desc = {
    Text = [[
Jenkin said: "Johnny! You're really... different from before, in every way."
You said: "You're truly a diligent and ambitious brain."
The brain squirmed and wriggled a bit, clearly very pleased.
The brain said: "Come on! Since you appreciate my achievements, I will impart all my lifelong knowledge to you..."]]
  },
  Event_7600_Name = {
    Text = "Philosopher's Brain"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Graceful Fugue] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Simple Serenade] All Awakeners gain 50 Aliemus, but you develop \"(Skill.Arg1)\"."
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Meaningless Noise] Engrave 1 out of 3 Orisons"
  },
  Event_7601_Desc = {
    Text = [[
"Personally, I don't quite agree with the curator's taste in music, you know...
It's too flashy, and I'm a down-to-earth person."
A weary male voice emanated from the creaking gramophone, lamenting in solitude.
"But this is my job... Alright, let's save time and pick one."]]
  },
  Event_7601_Name = {Text = "Bad Taste"},
  Event_7602_ChoiceDesc1 = {
    Text = "[Special Relic] Obtain a Golden Relic\"(RelicConfig.Arg1)\""
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7602_Desc = {
    Text = "Event 253 (Under Development), Not Final Effect"
  },
  Event_7602_Name = {
    Text = "Event 253 (In Development)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7603_Desc = {
    Text = "You run away as fast as you can.\nNow, you're facing the most troublesome and disgusting monsters ever—the swarming wax sculptures.\nCompared to them, these crude clay figures are nothing.\nPrioritizing—this is a principle that every Keeper must adhere to."
  },
  Event_7603_Name = {Text = "Draft"},
  Event_7604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7604_Desc = {
    Text = [[
The Silver Key glimmers, filling the space with a silvery glow and transforming the thick, flowing colors into pure silver.
The light vanishes in an instant, leaving only the mournful cry of the wind.]]
  },
  Event_7604_Name = {
    Text = "Hue of Longing"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7605_Desc = {
    Text = "The iridescence dazzles you, and before you realize it, you are entranced..."
  },
  Event_7605_Name = {
    Text = "Stellar Crossroad"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Descend Further] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Pull Away] Receive 25 Black Sigils"
  },
  Event_7606_Desc = {
    Text = [[
"You" invites you deeper.
In the depths of the spiral, the past and future "you" send you "gifts" from different dimensions.]]
  },
  Event_7606_Name = {Text = "Abyss"},
  Event_7607_ChoiceDesc1 = {
    Text = "[Understanding] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Innocence] Acquire 1 out of 3 Golden Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Leave] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_7607_Desc = {
    Text = "Two silvery glowing figures appear before your eyes, presenting a viscous liquid form, floating in the air.\n\"This is exactly where I perished.\" One figure crouches down.\n\"In the disease-free realm of God, there is no such thing as desire and loss. You don't truly understand—what it means to cease to exist.\"\nThe other figure sighs, turning its gaze toward you."
  },
  Event_7607_Name = {
    Text = "Lost Pantheon"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Leave] Look for Searchlight"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Enter the Mist] Develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7608_Desc = {
    Text = [[
Ahead lies a thick black fog; entering rashly will bring disaster.
Perhaps you should find a "Searchlight" to disperse the fog.]]
  },
  Event_7608_Name = {Text = "Unknown"},
  Event_7609_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7609_Desc = {
    Text = [[
"That is the projection of memory,"Ramona explained to you, "It may belong to a certain person, or it may be a shared memory of several people."
Precious memories deserve careful guarding.]]
  },
  Event_7609_Name = {
    Text = "Our Memories"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7610_Desc = {
    Text = [[
Even though you can't decipher it now, you don't give up. You carefully fold it and tuck it into your pocket, planning to find another way to read it after returning to school.
However, as the letter mysteriously crumples in mid-air, a faint pain begins to emerge in your chest.]]
  },
  Event_7610_Name = {
    Text = "Stained Letter"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7611_Desc = {
    Text = "The candle ignites the moment it leaves the scale, shedding milky-white tears that swiftly drip through your fingers and disappear."
  },
  Event_7611_Name = {
    Text = "Reason and Passion"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7612_Desc = {
    Text = "Hastily, you pull the paper from the typewriter—but it continues to run. In this moment of panic, a Command Card falls in and becomes unusably smeared with the blackest of ink.\nYou take a moment to dispose of it carefully, but can't help but to notice the ominous, repeated text now written upon it;\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>\n<Bold:DO NOT GAZE DIRECTLY>"
  },
  Event_7612_Name = {
    Text = "Unbidden Warning"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7613_Desc = {
    Text = [[
When your fingers touched the icy rim of the cup, cold enough to freeze your bone marrow, you shivered and snapped awake.
Regardless, it shouldn't be left by the roadside. It's better to store it in the suitcase.]]
  },
  Event_7613_Name = {Text = "Honey Mead"},
  Event_7614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7614_Desc = {
    Text = [[
You cough violently.
The sound seems startled, then falls silent.
You feel like you've missed an important clue...
But life is always full of misses and regrets, isn't it?]]
  },
  Event_7614_Name = {
    Text = "Eavesdropper"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Keep Silent] 100% chance to get 25 Black Sigils"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] 50% chance to get 50 Black Sigils, 50% chance to get nothing."
  },
  Event_7615_Desc = {
    Text = "\"All I have to say is one maxim—no one can kill a cat!\"\n\"That damn black cat should have been gutted and left to rot in the wild, but it dug up my family tomb, devouring the remaining human flesh and scattering the bones and limbs everywhere.\"\n\"Under its cold, dark slit-like pupils, the putrid yellow pus floated up, and I crawled away, tormented by nightmares, my spirit drained.\"\n\"Wait... What are you doing? I'm not crazy! I'm not! You must be hiding something! It's true—\"\nIt is indeed true. As you watch the shadow of the madman disappear, you exchange a glance with the quiet black cat at your feet."
  },
  Event_7615_Name = {
    Text = "Nightcat's Bane"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7616_Desc = {
    Text = "As you hesitated, it dissolved into the D-Mark and quickly disappeared."
  },
  Event_7616_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7617_Desc = {
    Text = "You crumple the letter in frustration and toss it at your feet."
  },
  Event_7617_Name = {
    Text = "Stained Letter"
  },
  Event_7618_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7618_Desc = {
    Text = "You focus, and the illusion dissipates like ink in water. You move forward, but the shadow on your heart remains."
  },
  Event_7618_Name = {Text = "Illusion"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Examine Carefully] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Avoid Shadows] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_7619_Desc = {
    Text = [[
Ramona's nerves were on edge as she carefully moved through the asylum, avoiding crowds.
She slipped into a small room.
A shadow suddenly appeared outside the window.]]
  },
  Event_7619_Name = {
    Text = "Window's Reflection"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_7620_Desc = {
    Text = "The more pressing task now is to bring the culprit to justice. However, the seeds of anger have already taken root in your heart. Without waiting for your response, the man turned and walked away."
  },
  Event_7620_Name = {
    Text = "Colossus' Print"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Leave] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_7621_Desc = {
    Text = "The education you received since childhood in Mythag has made it impossible for you to ignore this imprint. You brushed away the dusty footprints, and at that moment, you seemed to hear a response from a distant dimension, \"Thank you\"."
  },
  Event_7621_Name = {
    Text = "Colossus' Print"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7622_Desc = {
    Text = "You gripped the Silver Key, its soft silver light and faint vibrations bringing you comfort. The gaze seemed to vanish, yet lingered, leaving an invisible mark on you."
  },
  Event_7622_Name = {
    Text = "Whose Gaze?"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Find the Secret Path]"
  },
  Event_7623_Desc = {
    Text = [[
You, Ramona, and Lotan split up to chase the hellhound.

You sprint through several alleys, a massive body appearing before you.
It turns the corner as you pursue it.
You catch up but face a dead end, three tall walls enclosing a narrow square of sky.]]
  },
  Event_7623_Name = {Text = "Dead End"},
  Event_7624_ChoiceDesc1 = {
    Text = "[Walk Past]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Pat]"},
  Event_7624_Desc = {
    Text = [[
Beside the clean and soft operating table lies the already slumped body of Koum.
She is still tall, like a small hill, just as you remembered when you first saw her.
However, compared to the true "Hellhounds" in the sky, she is so small, small enough to resemble a child.]]
  },
  Event_7624_Name = {
    Text = "Lingering Warmth"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Get Silver]"
  },
  Event_7625_Desc = {
    Text = [[
Hmm, there seem to be many shiny things ahead!
Sniff... smells nice.
Lick... it's icy cool!
Looks like something precious. Quickly take it to Little Jenkin, maybe we can get lots of cheese squeaks!]]
  },
  Event_7625_Name = {
    Text = "Shiny Stuff"
  },
  Event_7626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7626_Desc = {
    Text = "A wave of unfamiliar disappointment wells up in your heart as the illusory web gradually dissipates, revealing the path forward."
  },
  Event_7626_Name = {
    Text = "Vagus Network"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Comprehend it] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignore It] Engrave 1 out of 3 Orisons"
  },
  Event_7627_Desc = {
    Text = "Runes flow from the fish-shaped lifeform's roar, filling your ears, nasal passages, and throat. They burn your body. In just ten seconds, you will grasp the profound meaning behind the roar..."
  },
  Event_7627_Name = {
    Text = "Rune Frenzy"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7628_Desc = {
    Text = [[
You grit your teeth and try to resist the chaotic phantasm. Ramona places a cold object in your palm.
"This relic I discovered might be of help to you."]]
  },
  Event_7628_Name = {
    Text = "Dimensional Phantasm"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Choose an Adv. Orison"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Hold Crow] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kill Crow] Engrave 1 out of 3 Orisons"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Leave]"},
  Event_7630_Desc = {
    Text = "The solitary crow croaks hoarsely, plucking its black feathers one by one.\nIt trembles in pain, shrieking uncontrollably as its frantic movements escalate.\n\"Caw—Caw—\"\nBlue tears mixed with black ooze stream from its eyes, witnessed by none but you.\n"
  },
  Event_7630_Name = {
    Text = "Molten Tear"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Leave] Increase Max HP by Arg1"
  },
  Event_7631_Desc = {
    Text = "\"Leave it to me,\" you gently pat the monster's spine, as if soothing an angry kitten, \"She will wake up. We won't harm her.\""
  },
  Event_7631_Name = {
    Text = "Call of Fellowship"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Leave] Increase Max HP by Arg1, but develop \"(Skill.Arg2)\" and \"(Skill.Arg3)\"."
  },
  Event_7632_Desc = {
    Text = "\"Wake up, Lily. Koum also hopes you'll wake up soon—\""
  },
  Event_7632_Name = {
    Text = "Call of Fellowship"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7633_Desc = {
    Text = "It is no longer useful."
  },
  Event_7633_Name = {
    Text = "Silent Telegram"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Choose an Awakener and transform into an \"Insectoid\" via Life Rite. Command Cards of \"Insectoid\" cost 1 less Arithmetica, but are Exhausted after being played."
  },
  Event_79429_Desc = {
    Text = [[
"The process of self-awareness is always accompanied by pain; so it is with metamorphosis and rebirth."
She smiles tenderly, lovingly stroking your face.
"Don't be afraid, I'm right here with you, so open your spirit and accept them."
"Good child, I'm waiting for your rebirth, waiting for you... to become one of us."]]
  },
  Event_79429_Name = {
    Text = "Metempsychosis"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_80463_Desc = {
    Text = [[
You choose a path, dragging Little William along as you bolt for your lives.
Fortunately, your instinct proves right.
Those mental distortions, those identical Clementines, are finally left behind in the dark.
Of course, victory comes with a price.]]
  },
  Event_80463_Name = {
    Text = "The \"Clementines\""
  },
  Event_80464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80464_Desc = {
    Text = [[
A memory beyond cognition is infused into your brain, directly shattering your reason.
In that fast-forward scene, you only remember one scene: the triangular Temple
It was a great achievement built by the Shag@2ais for the Blind Idiot God @4.]]
  },
  Event_80464_Name = {
    Text = "Deep Memory"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Leave] Rouse an Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_80465_Desc = {
    Text = [[
You choose a path, dragging Little William along as you bolt for your lives.
Fortunately, your instinct proves right.
Those mental distortions, those identical Clementines, are finally left behind in the dark.
Of course, victory comes with a price.]]
  },
  Event_80465_Name = {
    Text = "The \"Clementines\""
  },
  Event_80466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80466_Desc = {
    Text = [[
"Click. Click. Click"
The "work" is finally completed, but apart from the "work" itself, what have you truly gained?]]
  },
  Event_80466_Name = {
    Text = "Eternal Torment"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_80467_Desc = {
    Text = [[
"I'm glad to hear your sincere answer."
"Looking forward to our next meeting."]]
  },
  Event_80467_Name = {Text = "Dream-Call"},
  Event_80468_ChoiceDesc1 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_80468_Desc = {
    Text = [[
"Ah, what a dishonest child."
"But that's okay, next time, I will make you speak the truth."
"All of the truths that spew from your heart and soul."]]
  },
  Event_80468_Name = {Text = "Dream-Call"},
  Event_80469_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_80469_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80469_Desc = {
    Text = [[
"Click."
The sound of the typewriter rings out, and until the "work" is done, you will forever be its slave.]]
  },
  Event_80469_Name = {
    Text = "Eternal Torment"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80470_Desc = {
    Text = [[
"What a pity, your caution has made you miss the only opportunity to learn the truth."
It sighs, silently dissolving.]]
  },
  Event_80470_Name = {
    Text = "Deep Memory"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[All-Out Attack]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Fight and Retreat]"
  },
  Event_80471_Desc = {
    Text = "An unexpected figure appears before you—it's Clementine.\n\"Don't be surprised, I just want to conduct a special test.\"\n\"As for what the test is, it's a secret.\" Clementine smiles, \"The only content of the test for you—\"\n\"is to survive.\""
  },
  Event_80471_Name = {
    Text = "Special Test"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Recall the Past]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Pull out the Scales]"
  },
  Event_80472_Desc = {
    Text = [[
"Please believe me, I mean no harm, I just want to help you."
Clementine chases after you, shouting loudly.
Her voice sounds incredibly sincere, yet you can no longer trust anything.
Your morals have been shattered by the "Embodied Cognition Theory," and your sanity is on the verge of collapse.
You must, must do something to resist the insect scales growing in your flesh, resist the madness and despair gradually infiltrating your soul.]]
  },
  Event_80472_Name = {
    Text = "Struggling Souls"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Leave] Destroy any 2 Cards"
  },
  Event_80473_Desc = {
    Text = [[
"Want to retain power for the final battle?"
"A wise choice. But in gaining, one also loses."
"Because in this burning and cruel world, survival itself requires a price."]]
  },
  Event_80473_Name = {
    Text = "Special Test"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignore It] Engrave 1 out of 3 Orisons"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Touch it] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_80474_Desc = {
    Text = [[
A strange thing resembling spores caught your attention.
It was like a delicate jellyfish made of flesh and blood, also resembling nerve fibers holding signals deep within the brain.
"Come touch me," it silently tempts you, "I will show you a cruel memory."]]
  },
  Event_80474_Name = {
    Text = "Deep Memory"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Leave] Engrave 1 out of 3 Orisons"
  },
  Event_80475_Desc = {
    Text = [[
"Ramona, Doll, Lotan, Ogier..."
You nervously keep whispering these names.
Your shattered sanity can no longer recall their appearances, but the existence they represent still warms your heart and soul.
They existed, they laughed, they... are the baseline and anchor that keep your humanity intact at this moment.]]
  },
  Event_80475_Name = {
    Text = "Struggling Souls"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Leave] Acquire 1 out of 3 Silver Relics, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_80476_Desc = {
    Text = "\"Ahhhhh—\"\nYou opened your mouth, shouting, the sound, rather than a scream, was more like a screech.\nThe plucked insect scales grew back, and your shattered sanity is lost forever."
  },
  Event_80476_Name = {
    Text = "Struggling Souls"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Leave] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_80477_Desc = {
    Text = [[
You hold nothing back, going all out. This stance obviously pleases Clementine.
"What a good child."
"In that case, let me reward you a little. Of course, it comes at a price."
"In this burning cruel world, survival itself demands a price."]]
  },
  Event_80477_Name = {
    Text = "Special Test"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_80478_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80478_Desc = {
    Text = [[
"Click. Click."
The sound of the typewriter rings out, and during the "work," you are nothing more than a tool to see it done.]]
  },
  Event_80478_Name = {
    Text = "Eternal Torment"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Run to the Left]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Run to the Right]"
  },
  Event_80479_Desc = {
    Text = "A familiar figure relentlessly pursues you—not just one or two, but dozens or hundreds.\nThe narrow corridor couldn't accommodate so many \"Clementines,\" so some \"Clementines\" are shoved to the ground, and some are trampled into mud.\nBut they all call out to you in unison, repeating the phrase that poisons your mind.\n\"Why are you running? I only wanted to give you a consultation.\"\nAnd you run wildly through the corridors of the sanatorium, facing the choice of a fork in the road."
  },
  Event_80479_Name = {
    Text = "The \"Clementines\""
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_80480_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80480_Desc = {
    Text = [[
"Modify! Work! Don't stop!"
Countless hums echo in your ears, drawing you closer to the suddenly appeared typewriter.
"What to do, what to do, I've been typing from morning until night, yet the work just never finishes."
"Modify! Modify! Modify the plan, present demands, complete the work!"
"Work! Work!! Work!!"
The humming soul crashes against the continuously typing typewriter, and finally, that typewriter stops.
But a moment later, that typewriter starts up again.
"Modify! Work! Don't stop!"
Because work has no end.]]
  },
  Event_80480_Name = {
    Text = "Eternal Torment"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Refuse to Answer]"
  },
  Event_80481_Desc = {
    Text = [[
In an instant, the scenery before you becomes blurry and illusory.
You think it is the room that is twisting and shifting, but later, you realize that your optic nerves have been invaded.
"We meet again."
In the blurred vision, Clementine smiles gently.
"Though we meet earlier than expected, I'm still very happy. I wonder if you, %player%, feel the same?"]]
  },
  Event_80481_Name = {Text = "Dream-Call"},
  Event_80595_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80595_Desc = {
    Text = [[

In response to your drive away, the butterfly remains indifferent.
It is persistently chasing your palm, losing its vitality within the palm of your hand.
"Ah, so warm..."
This was its final whisper.]]
  },
  Event_80595_Name = {
    Text = "Lepidopteran Dream"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80596_Desc = {
    Text = [[
"I want flowers to bloom forever, I want smiles to last eternally."
"I wish that all those afflicted by Dissolution can recover in peace, I wish this world could return to its past and stop burning."
"I want..."
The little butterfly flapped its wings, losing its vitality in the palm of your hand.
At least, someone has listened to its voice.]]
  },
  Event_80596_Name = {
    Text = "Lepidopteran Dream"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Drive Away the Butterflies] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card, but develop \"(Skill.Arg2)\"."
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Listen to Their Wish] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_80597_Desc = {
    Text = [[
The little butterfly carries many dreams.
These dreams scatter in the sea of flowers, in the ward, and in the altar filled with much blood and flesh of @2.
Finally, it has awaited its bond, not knowing if you are willing to listen to its little, little wish.]]
  },
  Event_80597_Name = {
    Text = "Lepidopteran Dream"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80610_Desc = {
    Text = [[
"Rationality? An interesting answer."
"I hope you won't regret your choice."]]
  },
  Event_80610_Name = {
    Text = "Humanity's Toll"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Feed Them] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop 1 out of 3 Symptoms."
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Pay No Mind] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_80612_Desc = {
    Text = [[
Residents come and go, yet the swarm of rats persists indefinitely.
Compared to humans, they are the true "natives" of this castle.
But they have no objections to humans moving in.
Because those soft, white, ugly things will feed them equally soft, white, ugly things.
"And you, ugly thing, which kind do you belong to?"]]
  },
  Event_80612_Name = {
    Text = "Citadel's Secret"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80613_Desc = {
    Text = [[

A gentle laughter emerges from the darkness.
"I am waiting for you, to meet me."
"Brave little bug."]]
  },
  Event_80613_Name = {Text = "\"Her\" Gaze"},
  Event_80614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80614_Desc = {
    Text = [[
"Shut up, shut up, you sound terrible."
The black cat covers its ears with its paws in a uniquely human manner.
"Human, your cat-speak is very poor, what you're saying makes no sense!"
Though it says this, the expression of the black cat softens.
"Given that you meowed to please me, I shall leave you with a gift."
"As for the content of the gift, it depends on your luck."]]
  },
  Event_80614_Name = {Text = "Nigelman"},
  Event_80615_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80615_Desc = {
    Text = "\n\"Mother, after losing my friends, my husband, and my son, I have now lost Diana forever—my little daughter.\"\n\"When she turned to ash before me, my mind went blank...\" The subsequent writing is no longer legible.\nYou can only turn to read the next line.\n\"I have made up my mind. If you see me again, please do not blame me; I just... miss you all too much.\""
  },
  Event_80615_Name = {
    Text = "Fading Longing"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80616_Desc = {
    Text = [[
Your attempts to drive them away produce an effect. A few of the blurred, twisted figures flee, but most remain rooted to the spot.
They no longer laugh or chant but cry loudly.
The sound of children crying erupts in your ears, repeating only one phrase:
"Kill the freak!"]]
  },
  Event_80616_Name = {
    Text = "\"His\" Childhood"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Leave] Develop the Symptom \"(Skill.Arg1)\""
  },
  Event_80617_Desc = {
    Text = [[
Your offering pleases the rat swarm.
The massive swarm writhes, gifting you a crudely wrapped present.
You can't discern its shape, only seeing a large amount of blood soaked into its wrapping.]]
  },
  Event_80617_Name = {
    Text = "Citadel's Secret"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80618_Desc = {
    Text = [[
"..."
"......"
"........."
The shadow remains silent, wanting to cry but has lost the ability to do so.
In the end, he only sighs deeply.
"Friend, hope you can guard your most precious things."]]
  },
  Event_80618_Name = {Text = "Hollow One"},
  Event_80619_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80619_Desc = {
    Text = [[
Your scolding has no effect, only making them more fanatically joyous.
The laughing and chanting grow even louder as they break into another rhyme:
"Little William, in the castle tall,
Man-eating rats run through the wall.
When the human sacrifice is done,
Everyone is gnawed, one by one."]]
  },
  Event_80619_Name = {
    Text = "\"His\" Childhood"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rouse a random Awakener"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Stare] Choose an Awakener to Rouse, reduce that Card's Arithmetica Cost by 2, but develop \"(Skill.Arg1)\"."
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_80620_Desc = {
    Text = [[
Everything in the sanatorium is under her control and surveillance. Of course, you are too.
But she is willing to turn a blind eye for you.
After all, a game needs to be reciprocal to be more interesting.]]
  },
  Event_80620_Name = {Text = "\"Her\" Gaze"},
  Event_80621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80621_Desc = {
    Text = [[
You put the envelope back in its place and prepare to leave, but suddenly, you hear a dreamy murmur.
"At my request, Dr. Clementine finally relented.
In the vast, mysterious universe she described to me, there must be a way to save you all.
I am already prepared for "rebirth." No matter how many light-years I must drift, I long to see you once more."]]
  },
  Event_80621_Name = {
    Text = "Fading Longing"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80622_Desc = {
    Text = [[
Dr. Clementine saved me.
She is truly a very, very good person, willing to listen to me.
I truly wish to speak of joyful happy things, yet at this moment, I have nothing but pain and despair.
I'm afraid I will fail to meet the doctor's expectations.
After losing you all, life is nothing but a wasteland to me.]]
  },
  Event_80622_Name = {
    Text = "Fading Longing"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80623_Desc = {
    Text = "\"You, you...\"\n\"Hmph, not bad technique—this time, you pass. Next time won't be so easy!\"\nThe black cat leaps away nimbly, and the others follow suit."
  },
  Event_80623_Name = {Text = "Nigelman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Attack the Cat] 50% chance to receive 125 Black Sigils, 50% chance to develop \"(Skill.Arg2)\""
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Meow Like a Cat] 75% chance to receive 100 Black Sigils, 25% chance to develop \"(Skill.Arg2)\""
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Attempt to Pet the Cat] Receive 50 Black Sigils"
  },
  Event_80624_Desc = {
    Text = [[
"Hey! You, stop right there."
Black cats leap out from the shadows, blocking your path.
They elegantly lick their paws, their demeanor arrogant and proud.
"The path ahead is full of dangers, not something a weak human like you can explore."
You express your determination to move forward. The vertical pupils of the clowder's leader shift, revealing a cruel intention of playing with its prey. "Then show us your determination."]]
  },
  Event_80624_Name = {Text = "Nigelman"},
  Event_80625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80625_Desc = {
    Text = [[

Your neglect enrages the swarm of rats. They rush towards you with screeches, and you have long run far away before the tide of the rats could surge.]]
  },
  Event_80625_Name = {
    Text = "Citadel's Secret"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80626_Desc = {
    Text = [[
"Ah, just like that, break my wings."
"Time, health, dignity, life, they have taken too much from me."
"This final dream, of course, does not belong to me."
"Because I am just a bird locked away and deprived of freedom."]]
  },
  Event_80626_Name = {Text = "Hollow One"},
  Event_80627_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80627_Desc = {
    Text = [[
"Emotional? An interesting answer."
"I hope you won't regret your choice."]]
  },
  Event_80627_Name = {
    Text = "Humanity's Toll"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80628_Desc = {
    Text = [[
"I accept your prayer."
The humming sound approached, slowly drilling into your brain through your ear canal.
Your brain trembled, and in this tremor, you heard the 'voice' of the universe.
"Link with me."]]
  },
  Event_80628_Name = {
    Text = "Dark Salvation"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Pray] Rouse a random Awakener, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Refuse] Engrave 1 out of 3 Orisons"
  },
  Event_80629_Desc = {
    Text = "\"It shouldn't be like this, it shouldn't be like this.\"\n\"I clearly, clearly should have detached from this lowly life of humans and evolved into something more advanced...\"\nIn the darkness, the sound of painful sobbing echoed.\nThese sobs gathered and surged, forming a tremendous hum.\n\"This burning world, like an insatiable black hole, Devours every single person, so—\"\n\"Pray to me, the endless universe will grant you redemption.\""
  },
  Event_80629_Name = {
    Text = "Dark Salvation"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Open the Envelope] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Read] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Put it back] Receive 50 Black Sigils."
  },
  Event_80630_Desc = {
    Text = [[
In a neglected corner, a letter has been left behind.
Many words on the letter have become unrecognizable, but one word remains. It pierces through the paper.
That word is "Mother".]]
  },
  Event_80630_Name = {
    Text = "Fading Longing"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80631_Desc = {
    Text = [[
"Heh, insignificant human, you made the wrong choice."
The black cats stare coldly at you, then suddenly retaliate.
"Though we have respect for the brave, you must pay the price."]]
  },
  Event_80631_Name = {Text = "Nigelman"},
  Event_80632_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80632_Desc = {
    Text = [[

A gentle laughter emerges from the darkness.
"I am waiting for you, to meet me."
"Lovely little bug."]]
  },
  Event_80632_Name = {Text = "\"Her\" Gaze"},
  Event_80633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80633_Desc = {
    Text = [[
Under your attack, the group of twisted, grotesque figures finally flees.
Silence surrounds you; only your heartbeat weeps soundlessly.
So, this is what "his" childhood looks like.]]
  },
  Event_80633_Name = {
    Text = "\"His\" Childhood"
  },
  Event_80635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80635_Desc = {
    Text = [[
"Ah, the little text trap has been uncovered."
"This is a reward. Because..."
"Not every choice has to be made."]]
  },
  Event_80635_Name = {
    Text = "Humanity's Toll"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80636_Desc = {
    Text = [[
"@3 Rebellious"
The buzzing sound gradually weakens until it disappears, leaving only the final words.
"Maintaining humanity cannot survive in this cruel world."]]
  },
  Event_80636_Name = {
    Text = "Dark Salvation"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Refuse] Destroy a Command Card and receive Arg1 Black Sigils."
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Comply] Duplicate a Command Card, but develop the Symptom \"(Skill.Arg1)\"."
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Embrace] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_80637_Desc = {
    Text = "\"I am a caged bird, trapped in a yard filled with many rooms.\"\nVague figures wander in the darkness—remnants of the deceased's obsessions.\n\"They say it's an asylum, but I know it is a special cage for humans, imprisoning free birds that refuse to obey social rules.\"\n\"But if a bird cannot fly, can it still be called a bird?\"\nThe obsessions gather around you, pleading for redemption.\n\"Please break my wings, I am tired of flying.\""
  },
  Event_80637_Name = {Text = "Hollow One"},
  Event_80638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80638_Desc = {
    Text = [[
"..."
"......"
"........."
The shadow suddenly trembles and melts into your body.
"Friend, move forward, to protect your most precious things."
"Although we have already passed away, we are still willing to offer our final blessing... for your dream."]]
  },
  Event_80638_Name = {Text = "Hollow One"},
  Event_80639_ChoiceDesc1 = {
    Text = "[Choose Emotion] Recover Arg1 HP"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Maintain Rationality] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Refuse to Choose] Receive 25 Black Sigils"
  },
  Event_80639_Desc = {
    Text = [[
"Choose, choose."
In the racing darkness, countless whispers echoed.
The voice is gently hypnotic, seemingly carrying infinite magic that induces a kind of mad phantasm in you.
Your brain sinks into madness, writhing away from the body, while the heart seems to have developed a certain consciousness, screaming and calling you.
"Choose, choose."
"Maintain rationality or emotion; you must make a choice."]]
  },
  Event_80639_Name = {
    Text = "Humanity's Toll"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Scold \"Them\"] Acquire the Cursed Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Drive \"Them\" Away] Acquire the Silver Relics \"(RelicConfig.Arg2)\" and \"(RelicConfig.Arg3)\", but develop \"(Skill.Arg1)\" twice."
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Attack \"Them\"] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_80641_Desc = {
    Text = "\"Little William, what a freak,\nSleeps in graves, cold and bleak.\nNobody loves him, stay away,\nOr he’ll stab you in the back one day.\"\nThe figures, their shapes blurred and bodies twisting, speak with the voices of young children.\nThey jeer and chant, watching you with eyes full of both contempt and a strange eagerness.\nPure malice radiates from them."
  },
  Event_80641_Name = {
    Text = "\"His\" Childhood"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Indulge] Shuffle 1 \"Soulsfeast Special Blend\" into your deck."
  },
  Event_90571_Desc = {
    Text = [[
A grand dining table, a lively dance floor, elegant tableware, and the rich aroma of corpses...
Oh, I know you're already eager, but please wait a little longer, dear guest.
This drink, specially prepared by the host of the banquet, is an exclusive gift for honored guests.
Take it in your hands. Sip it. And in its lingering aftertaste, indulge yourself in this joyous occasion!]]
  },
  Event_90571_Name = {
    Text = "Pre-Feast Ritual"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91460_Desc = {
    Text = "You have no defense, and can only let the sound pierce through.\nA sharp cry splits your brain open, and some forgotten fear pours out—you feel its hunger.\nA terrifying cannibalistic creature..."
  },
  Event_91460_Name = {
    Text = "Silent Confession"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91461_Desc = {
    Text = [[
You no longer hold back, letting that burning passion fully unleash, as all unsaid words continuously erupt from your mind.
You feel a wonderful insight, immersing yourself in Pickman's talent.]]
  },
  Event_91461_Name = {
    Text = "Dormant Volcano"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91462_Desc = {
    Text = [[
The flames curled around ink stains, leaving behind a trail of bloodstains.
At that moment, you fell on the edge between dream and reality. You saw yourself transformed into a little girl, taking Doresain's hand and dancing with him.
When you woke up and looked at Doresain again, a heavy sadness overwhelmed your mind.]]
  },
  Event_91462_Name = {
    Text = "Dream Revelation"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91463_Desc = {
    Text = "You rush forward, the flames vanishing beneath your skin. As for the painting, it appears as nothing more than an ordinary portrait to anyone who sees it.\nIn the dreams that follow, you always see yourself burning—roasted to perfection—before being served on your own dining table one day."
  },
  Event_91463_Name = {
    Text = "Burning Portrait"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Listen] Receive 30 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91464_Desc = {
    Text = "In the silent cacophony, you gradually understand the raven's words..."
  },
  Event_91464_Name = {
    Text = "Silent Confession"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91465_Desc = {
    Text = [[
You pick up a stone and awaken the focused, gnawing rat shadows.
They stare at you greedily.
You smell the damp, filthy odor from their bodies, as if it were some kind of omen.]]
  },
  Event_91465_Name = {
    Text = "Exiled Kingdom"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Listen] Receive 25 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91466_Desc = {
    Text = [[
It's welcoming. Welcoming who?
Of course, you!
Maybe it sees you as tomorrow's delicious meal.]]
  },
  Event_91466_Name = {
    Text = "Silent Confession"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Sever the Palm] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Accept Growth] Acquire the Silver Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_91467_Desc = {
    Text = [[
That butterfly did not fly in, but rather slowly grew from the palm of your hand.
At first, you thought it was just sweat, but between your fingers, you saw black liquid seeping out like a reversed flow of veins, congealing into cold, pulsating wings.
Every time it flutters, it sends ripples through your bloodstream.]]
  },
  Event_91467_Name = {Text = "Parasite"},
  Event_91468_ChoiceDesc1 = {
    Text = "[Rescue the Portrait] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Accept the Blankness] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Leave] Receive 25 Black Sigils"
  },
  Event_91468_Desc = {
    Text = "You stand before Pickman's Gift.\nIt is a portrait painted in blood, with pitch-black flames quietly burning.\nThrough the hollow eye sockets of the figure in the painting, you see—\nYour own memories surging and burning, stretching, distorting, glowing, as if some formless fire were licking the corridors of your mind. In your daze, you hear a voice.\n\"It's time to get cooking. The heat is just right.\"\nThis is the very scene of your own crafted memory—you writhe and twist within the flames."
  },
  Event_91468_Name = {
    Text = "Burning Portrait"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91469_Desc = {
    Text = [[
You refuse to answer, quietly watching it vibrate until it stops.
Over the years, you've long since learned to fight against Madness.]]
  },
  Event_91469_Name = {
    Text = "Missed Call"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91470_Desc = {
    Text = [[
You take a step back and let the canvas burn in the flames.
You watch as your own image turns an enticing golden brown, the fat sizzling and crackling. It almost feels as if you could smell the aroma of roasted meat through the canvas.
Is this the kind of temptation Doresain feels?]]
  },
  Event_91470_Name = {
    Text = "Burning Portrait"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91471_Desc = {
    Text = [[
Driven by a nearly desecrating curiosity, or perhaps a desperate courage to confront the unknown, you seek revelation within the shadows of the past.
You see a girl dancing with a tall man whose face is indistinct, and an inexplicable joy fills your heart.]]
  },
  Event_91471_Name = {
    Text = "Shadows of The Past"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[End Record] Destroy any 2 Cards"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continue Writing] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Leave] Receive Arg1 Black Sigils"
  },
  Event_91472_Desc = {
    Text = [[
You finally managed to temporarily escape from the ghoul's market, finding a quiet corner to begin recording as usual.
The typewriter suddenly vibrated violently, its keys pressing up and down on their own, while black viscous liquid spewed from the gaps, splattering onto your fingertips and soaking your sense of reason.
You saw a butterfly shadow gradually emerging and becoming vivid on the paper...]]
  },
  Event_91472_Name = {
    Text = "Butterfly Shadows"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91473_Desc = {
    Text = "Strangely, although it's a language you've never learned, you somehow understand its meaning.\nThe verse is filled with longing for loved ones, a longing that transcends life and death, conveyed to you through your dream.\nYou vaguely recognize the handwriting at the end of the poem—\nIt's Celina."
  },
  Event_91473_Name = {
    Text = "Dream Revelation"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91474_Desc = {
    Text = [[
You endure the pain as you slice open the skin of your palm, using flames to burn away the newly formed winged flesh.
Black liquid evaporates and butterflies shatter.
Everything becomes clean and unmarked, yet you can't help but feel a faint fluttering sensation in your palm, as if the thought of something never fully hatched still breathes slowly within your veins.
Doresain offers no opinion on the matter, only taking the blood you left behind.]]
  },
  Event_91474_Name = {Text = "Parasite"},
  Event_91475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91475_Desc = {
    Text = "You know that fervent Insight always leads to Cataclysm, so you seal everything away with reason."
  },
  Event_91475_Name = {
    Text = "Dormant Volcano"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91476_Desc = {
    Text = "You stare intently at the Eye, trying to decipher the message it conveys.\nAlthough you have long been battle-hardened, this time facing Goliath... fear grips your heart.\n\"Almost Normal— it's the quietest form before the Cataclysm occurs.\""
  },
  Event_91476_Name = {
    Text = "Almost Normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91477_Desc = {
    Text = [[
You close your eyes and turn to walk into the wilderness.
You can sense the hidden desire and omen, but you will never be able to quell it with your own hands.
You look around at the nameless gravestones. Perhaps this is how your story ends.]]
  },
  Event_91477_Name = {
    Text = "Feast of Ravens"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91478_Desc = {
    Text = [[
You slowly lift your head. In that moment, light pierces your pupils, and searing heat blooms into a void within your mind.
The stars of Necrovia are no different from those elsewhere, yet even the seemingly eternal ghouls can only live beneath the stars, without freedom.]]
  },
  Event_91478_Name = {
    Text = "Night of the Stars"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Throw into the Flames] Destroy a Card"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Attempt Interpretation] Acquire the Relic \"(RelicConfig.Arg1)\", but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_91479_Desc = {
    Text = "Your consciousness floats and drifts within an endless sea of black mist, traversing the mental landscapes of countless living and dead souls.\nIn your dream, a strange typewriter produces a passage of unfamiliar verse. Whose story is this?\nIt is imprinted upon paper of unknown origin, its distorted handwriting resembling that of a sober drunkard.\nDriven by an indescribable impulse within the dream, you pick up the sheet—the ink dancing in the flickering light of the hearth."
  },
  Event_91479_Name = {
    Text = "Dream Revelation"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Apply] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Drive] Engrave the Orison \"(EnchantConfig.Arg2)\" on a random Command Card, but develop \"(Skill.Arg1)\"."
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ostracise] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_91480_Desc = {
    Text = "You hear the faint, distant sound of a bone horn.\nThe swarm of rats emerges from the black mud, drawn by the sound, gnawing at the nameless corpse lying on the dry riverbed.\nThey form a circle—the center is the hollow remains, while the circumference marks a new kingdom governed by the law of oblivion.\nAnd you are standing at the entrance of this kingdom."
  },
  Event_91480_Name = {
    Text = "Exiled Kingdom"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Look Up] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Black Sigil] Receive 75 Black Sigils, but develop the Symptom \"(Skill.Arg2)\""
  },
  Event_91481_Desc = {
    Text = [[
Crows swirl in the sky like a hesitant saw, repeatedly cutting through the spine of the heavens.
They fly low around you, as if foreseeing your death, patiently awaiting the start of the feast.]]
  },
  Event_91481_Name = {
    Text = "Feast of Ravens"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91482_Desc = {
    Text = "You let it continue writing, with your pulse, your sense of pain, your past, and your imagination.\nThe butterfly breaks free from the bonds of the paper, and your soul follows in flight.\nYou start imagining yourself enjoying the amusement park. What you didn't tell Doresain is that, in truth, you really like amusement parks—even if it's a corpse-themed one...\nI hope... it's not too bizarre."
  },
  Event_91482_Name = {
    Text = "Butterfly Shadows"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Reobserve] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91483_Desc = {
    Text = "The once-clear dinner has turned into a bloody, indistinct feast. You recall the ingredients on the stove, and the stench of decay assaults your nostrils.\nFear grips your heart—you must make a choice."
  },
  Event_91483_Name = {
    Text = "Shadows of The Past"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignore the Ring] Engrave 1 out of 3 Adv. Orisons"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Pick up the Receiver] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_91484_Desc = {
    Text = "It shouldn't have rung—the phone, curled behind the canvas.\nThe cord wraps around the bulky machine's body like a rusted umbilical cord, seemingly extending from your own mind.\nYou carefully discern the vibration's frequency; the eerie sound is reminiscent of Pickman's surreal art."
  },
  Event_91484_Name = {
    Text = "Missed Call"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91485_Desc = {
    Text = [[
You cradle the cold brain, but in an instant, it turns to water, silently slipping through your fingers.
The scales immediately lose balance, and the heart collapses like rotten fruit, dissolving into a pool of silent, black water.
All hunger vanishes; you now possess a chilling calmness, no regret, and a fleeting clarity.]]
  },
  Event_91485_Name = {
    Text = "Hunger Games"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91486_Desc = {
    Text = [[
No sound, no response. Could it have just been a prank?
As you put the receiver down, a heavy emotion surges back into you.]]
  },
  Event_91486_Name = {
    Text = "Missed Call"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91487_Desc = {
    Text = [[
The raven disappears.
But you see yourself standing in the mirror of another night, gazing at this raven.
It still silently shrieks, as if waiting for your response.]]
  },
  Event_91487_Name = {
    Text = "Silent Confession"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Reexamine] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Give Up] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_91488_Desc = {
    Text = [[
You resolutely avert your gaze, yet those images linger like phantoms in your vision...
It is a sorrowful duet.]]
  },
  Event_91488_Name = {
    Text = "Shadows of The Past"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Consume] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Decline] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_91489_Desc = {
    Text = [[
That was carefully prepared by Doresain for your hard investigation.
Seasoning-free yet odorless, as Doresain said, this is the finest ingredient.
The banquet is set for you, and the brain lies silent in the dish.
"Would you like to taste it?"]]
  },
  Event_91489_Name = {
    Text = "Savor the Delicacy"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Listen] Receive 40 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Disregard] Receive 25 Black Sigils and leave."
  },
  Event_91490_Desc = {
    Text = [[
That is a raven.
It stands atop a skull-shaped lamp, opens its mouth, but makes no sound.]]
  },
  Event_91490_Name = {
    Text = "Silent Confession"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91491_Desc = {
    Text = [[
You slowly reach your hand toward that still-warm heart; it beats and contracts, until finally dissipating into a fragrant puff of heat.
The scale violently shakes, and your brain plummets into endless darkness.
A feeling of fullness replaces hunger, and you come to understand passion, pain, and true Memory.]]
  },
  Event_91491_Name = {
    Text = "Hunger Games"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91492_Desc = {
    Text = "You tilt your head up, welcoming the silent rotation, like a pilgrim in an ancient ritual.\nThey joyfully feast on your flesh; you feel pain, yet clarity.\nYou see your lost self—the parts that failed to die—finally taken away.\nWhen consciousness returns, you find yourself unharmed."
  },
  Event_91492_Name = {
    Text = "Feast of Ravens"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91493_Desc = {
    Text = [[
You used cement made of memories and emotions to seal the keyhole, leaving truth powerless to tempt you.
Seeing your stance as if facing a formidable enemy, Doresain licked his lips.
"Would you like to try it again? This is a specially crafted Brainleaf Mozzarella, made exclusively for {Male=Mr.,Female=Miss} Keeper."]]
  },
  Event_91493_Name = {
    Text = "The Revelation"
  },
  Event_91494_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91494_Desc = {
    Text = "Actually, you've always been curious about the experience of being a ghoul.\n\"So you step into the swarm of rats and become one of them—\"\nYou have to admit, the arrival of the Seafarer has made your mind a bit hazy."
  },
  Event_91494_Name = {
    Text = "Exiled Kingdom"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91495_Desc = {
    Text = [[
You refuse to be tainted by corruption and chaos.
You've long been accustomed to it; all decay seems like the norm.]]
  },
  Event_91495_Name = {
    Text = "Exiled Kingdom"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Consume] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Decline] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 1/2)"
  },
  Event_91496_Desc = {
    Text = [[
Doresain elegantly cuts you a piece of "brain."
That sweet taste...
That soft and delicate texture...
You really want to take another bite.]]
  },
  Event_91496_Name = {
    Text = "Savor the Delicacy"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[I'm Dreaming] Acquire the Silver Relic \"(RelicConfig.Arg1)\""
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[This is Not Normal] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_91497_Desc = {
    Text = "A smooth gravestone reflects an eye that is slowly distorting.\nAs if carrying an image beyond visual description, a memory that doesn't belong to you has deeply settled into the creases of your eyes.\nYou try to blink, to wipe it away with your fingertip, but that eye no longer belongs to you—it begins reflecting a kaleidoscopic scene."
  },
  Event_91497_Name = {
    Text = "Almost Normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Continue Observation] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Look Away] Develop the Symptom \"(Skill.Arg1)\" and change the Orison to engrave. (Uses: 2/2)"
  },
  Event_91498_Desc = {
    Text = "In a damp corner of the ancient castle, you discovered that roll of film.\nThe images resemble phantoms drowned in the river of time, freezing in slow motion—sometimes expanding into indescribable colossal forms, sometimes collapsing into flickering stars.\nLost within them, a sudden dizziness reminded you of the passage of time."
  },
  Event_91498_Name = {
    Text = "Shadows of The Past"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Gaze at the Stars] Acquire the Golden Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rouse 2 random Awakeners, but develop \"(Skill.Arg1)\" twice."
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Leave] Receive 50 Black Sigils"
  },
  Event_91499_Desc = {
    Text = [[
You stand in a deserted cemetery, where the presence of stars illuminates the night as brightly as day.
The floating orbs of light within the fathomless depths of time remain silent, yet slowly converge through rotations as endless as murmurs in a dream.
They gaze upon the forgotten solitary star.
He gazes upon you, upon all death and eternity.]]
  },
  Event_91499_Name = {
    Text = "Night of the Stars"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Listen] Receive 20 Black Sigils, but develop \"(Skill.Arg2)\""
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91500_Desc = {
    Text = [[
You lock eyes with it.
In the pitch-black darkness, you see the greedy wildfire.]]
  },
  Event_91500_Name = {
    Text = "Silent Confession"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Open Socket] Acquire the Cursed Relic \"(RelicConfig.Arg1)\", but develop \"(Skill.Arg2)\"."
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Closed Keyhole] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_91501_Desc = {
    Text = [[
You resist several times as Doresain offers you the cerebral lobe, but ultimately you cannot withstand the temptation of knowledge.
Wisdom does not arrive gradually, but pours down suddenly.
Your head begins to ache, and your thoughts expand like rising bread. When you finally collapse, the pain recedes like a tide, leaving a hollow, ancient keyhole in your consciousness.
So this is the shape of knowledge! You feel an unprecedented surge of wisdom.
Perhaps... you can obtain even more?]]
  },
  Event_91501_Name = {
    Text = "The Revelation"
  },
  Event_91502_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91502_Desc = {
    Text = [[
You used the lingering blade of your consciousness to pry into that keyhole.
You didn't know what a key was, so you relied solely on obsession to make an attempt.
At that moment, your thoughts burned away completely, leaving only something inhuman to whisper within the hollow keyhole.
Is this what revelation feels like? You eagerly shared it with Doresain.
"Would you like to try it? This is a special cerebral mozzarella made exclusively for {Male=Mr.,Female=Miss} Keeper."]]
  },
  Event_91502_Name = {
    Text = "The Revelation"
  },
  Event_91503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91503_Desc = {
    Text = [[
You neither detonate it nor suppress it.
In a subtle state of detached observation, you regard the surging thoughts as part of the weather's shifting, allowing them to flow naturally toward an unknown conclusion.
Within the painting of blood and flesh, you come to appreciate the art of eternity.]]
  },
  Event_91503_Name = {
    Text = "Dormant Volcano"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91504_Desc = {
    Text = [[
The keys suddenly stop, and the butterfly shadows vanish in an instant.
Was it an illusion? You feel a sense of loss.
Maybe I should listen to Doresain and buy some brain leaves from the memory canned goods store.
"No, what am I thinking?"]]
  },
  Event_91504_Name = {
    Text = "Butterfly Shadows"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91505_Desc = {
    Text = [[
You stop struggling and allow the wings and black liquid to pierce through your palm.
You become its vessel, and it uses you as a shell, continuing its thoughts.
The butterfly grows larger and larger until you can no longer bear its weight.
Seeing this, Doresain eagerly cuts the link between you and the butterfly with a dinner knife. The hungry look in his eyes clearly reveals his desire...
You reject his request.]]
  },
  Event_91505_Name = {Text = "Parasite"},
  Event_91506_ChoiceDesc1 = {
    Text = "[Listen] Receive 35 Black Sigils, develop \"(Skill.Arg2)\" and continue choosing."
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91506_Desc = {
    Text = [[
You had thought it was silent, until your consciousness suddenly tilted, as if the skulls of countless crows were shrieking inside your mind.
You kneel on the ground, and the world spins in your eyes.]]
  },
  Event_91506_Name = {
    Text = "Silent Confession"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91507_Desc = {
    Text = "You close your eyes and step into the endless, soft haze of dust, where the nebula embraces you, and you lose your form—a presence more stable than your body settles within you.\nThat night, the stars continued to rotate, as bright as ever.\nTo an immortal being, what does the starry sky signify? Perhaps you should go ask Doresain."
  },
  Event_91507_Name = {
    Text = "Night of the Stars"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Consume] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91508_Desc = {
    Text = "It turns out to be cheese. While you feel relieved, there's also a hint of regret."
  },
  Event_91508_Name = {
    Text = "Savor the Delicacy"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Ignite] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[The Vigil] Acquire the Silver Relic \"(RelicConfig.Arg2)\", but develop \"(Skill.Arg1)\"."
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Sealed] Receive 25 Black Sigils"
  },
  Event_91509_Desc = {
    Text = "You fix your gaze on Pickman's painting, and the nauseating stench of decay leaves you stunned.\nThoughts slowly rise from your mind—first just heat, then mist, and later—"
  },
  Event_91509_Name = {
    Text = "Dormant Volcano"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Touch the Brain] Engrave the Orison \"(EnchantConfig.Arg1)\" on a random Command Card."
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Touch the Heart] Increase Max HP by Arg1, but develop the Symptom \"(Skill.Arg2)\"."
  },
  Event_91510_Desc = {
    Text = [[
You step into the silent, gray hall where no whispers linger, and a pair of scales faintly emerges from the dark mist.
On the left, there's a brain as calm as a lake, its silver-white grooves glimmering faintly; on the right, a fiery red heart steams with warmth.
Suddenly, you catch a whiff of a fragrant aroma. An insatiable desire swells within you, and your reason is compressed by Its boundless darkness.
You reach out your hand.]]
  },
  Event_91510_Name = {
    Text = "Hunger Games"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91511_Desc = {
    Text = "This must be a dream, you keep convincing yourself.\nBefore you realize it, you have truly fallen asleep.\nPerhaps due to too much interaction lately, you actually dreamed about Doresain—intentionally letting Doresain consume your own blood and flesh? What kind of horror story is this?"
  },
  Event_91511_Name = {
    Text = "Almost Normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Alternative Path] Engrave the Orison \"(EnchantConfig.Arg1)\" on 1 of 3 Command Cards."
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Let It Be] Engrave the Orison \"(EnchantConfig.Arg1)\" on 3 random Command Cards, but develop \"(Skill.Arg2)\"."
  },
  Event_91660_Desc = {
    Text = "\"Drive the soul—you must lead the dead to the end.\"\nAs Doresain speaks, you feel a sudden epiphany.\nIt is not knowledge, nor memory—it feels more like a weight, entering through your eyes and flooding your mind like a torrent.\nYour emotions no longer seem to belong to this moment; they recede, revealing a gap overlooked by the universe.\nEverything you can perceive simply stops there, as if you've reached the very end of a path."
  },
  Event_91660_Name = {Text = "Soul's End"},
  Event_91661_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91661_Desc = {
    Text = [[
You let your soul wander far away.
At the boundary of the "self," you seem to hear the whisper of the deceased.
But when you listen carefully, everything disappears.]]
  },
  Event_91661_Name = {Text = "Soul's End"},
  Event_91662_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91662_Desc = {
    Text = [[
You wrapped your consciousness, thereby insulating yourself from unknown temptations.
You were lost at the end of your soul, seeing only yourself.
As expected, as a living person, you cannot possess the abilities of a ghoul.]]
  },
  Event_91662_Name = {Text = "Soul's End"}
})
return Text_Event
