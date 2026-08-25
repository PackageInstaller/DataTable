__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116371_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_116371_Name = {Text = "聯絡點"},
  Event_116372_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116372_Desc = {
    Text = "你觸發了不明房間。"
  },
  Event_116373_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116373_Desc = {
    Text = "你找到了財寶。"
  },
  Event_116373_Name = {Text = "財寶"},
  Event_116374_ChoiceDesc1 = {
    Text = "【接通】回復Arg2點生命。"
  },
  Event_116374_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_116374_Name = {Text = "聯絡點"},
  Event_116389_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116389_Desc = {
    Text = "捏奧還在睡覺...zzZZ"
  },
  Event_116389_Name = {Text = "捏奧"},
  Event_116429_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116429_Desc = {
    Text = "你觸發了隨機事件3。"
  },
  Event_116429_Name = {
    Text = "隨機事件3"
  },
  Event_116430_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116430_Desc = {
    Text = "你觸發了隨機事件1。"
  },
  Event_116430_Name = {
    Text = "隨機事件1"
  },
  Event_116431_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_116431_Desc = {
    Text = "你觸發了隨機事件2。"
  },
  Event_116431_Name = {
    Text = "隨機事件2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "【你曾渴望天真】將 3 張「(Skill.Arg1)」置入牌庫。"
  },
  Event_117279_Desc = {
    Text = "\n海平面上升起淡薄的白霧，將萬物籠罩在一片朦朧之中。\n跨越生與死的界限，跨越門扉內外的距離，跨越漫長得褪色的記憶，你看見撐著陽傘的淑女逆光的身影。\n與她共度的時光已經逝去，正如她那單薄卻鮮妍的亮色青春。\n等待虛假的日輪升起，薄霧破碎於無形，她的側影也在夢中搖晃著化為輕飄的虛妄泡沫，向你致以無聲的告別。"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "【你曾渴望天真】選擇 2 張卡牌賦予「淵海回聲」刻印。"
  },
  Event_117280_Desc = {
    Text = "\n海平面上升起淡薄的白霧，將萬物籠罩在一片朦朧之中。\n跨越生與死的界限，跨越門扉內外的距離，跨越漫長得褪色的記憶，你看見撐著陽傘的淑女逆光的身影。\n與她共度的時光已經逝去，正如她那單薄卻鮮妍的亮色青春。\n等待虛假的日輪升起，薄霧破碎於無形，她的側影也在夢中搖晃著化為輕飄的虛妄泡沫，向你致以無聲的告別。"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "【三點】"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "【六點】"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "【一點】"
  },
  Event_118414_Desc = {
    Text = "骰子轉起來，發出咕嚕嚕的聲音。\n它會在什麼時候停下？\n你不知道，但你必須給出一個答案。"
  },
  Event_118414_Name = {
    Text = "命運博弈"
  },
  Event_118415_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118415_Desc = {
    Text = "你的回應令「天空」越發溫柔。\n。它輕輕在你的額頭落下一吻。\n然後，你的額頭開出了一朵浪花。"
  },
  Event_118415_Name = {
    Text = "海洋的擁抱"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "【沉迷幻想】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118416_ChoiceDesc2 = {
    Text = "【保持理智】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "【強行離開】獲得3選1刻印"
  },
  Event_118416_Desc = {
    Text = "或許是長期的戰鬥令你產生了恍惚，也或許只是你的大腦背叛了你的身體。\n某種失重感出現在你的腦海。\n一瞬間，你的腦海突然變成了萬花筒，絢爛，斑斕，閃動著五顏六色的光彩。\n數不清的靈感、迷思和狂想擠入大腦，佔據你大腦溝壑的每一個角落。\n再這樣下去，你的腦子很快就會被這些亂七八糟的東西撐爆。"
  },
  Event_118416_Name = {
    Text = "思維萬花筒"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "【加入賭局】感染「(Skill.Arg1)」，進入賭局"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "【還是算了】獲得25黑印"
  },
  Event_118417_Desc = {
    Text = "一陣恍惚中，你的意識穿過層層迷霧，飄散到了未知的空間。\n兩個骰子被甩到了你的面前，將你強制帶到這裡的未知存在卻仍未露面。\n你只能聽到那存在來自四面八方的混沌聲音。\n「想回去嗎？那就來一局吧。」\n「以你的生命為籌碼，和命運來場博弈。」"
  },
  Event_118417_Name = {
    Text = "命運博弈"
  },
  Event_118418_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118418_Desc = {
    Text = "超脫的體驗總是短暫的。它們無聲而至，又突然消失。\n但至少你的腦袋還在這裡，沒有真的爆炸。"
  },
  Event_118418_Name = {
    Text = "思維萬花筒"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_118419_Desc = {
    Text = "你沒有輸，但也沒有贏，結果不好不壞。\n「平局……」\n未知存在歎了口氣，聲音裡卻聽不出惋惜。\n「真是個不錯的樂子。」"
  },
  Event_118419_Name = {
    Text = "命運博弈"
  },
  Event_118420_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118420_Desc = {
    Text = "漸漸地，那狂亂的樂音在你耳中變得和諧，聖潔。\n你終於頓悟，理解它為什麼會被稱為「完美聖歌」。\n因為它確實「完美無瑕」。"
  },
  Event_118420_Name = {
    Text = "「完美」聖歌"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "【感知大腦】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "【感知靈魂】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_118421_Desc = {
    Text = "人的第一個囚籠，就是自己的軀殼。\n在這軀殼囚籠裡，大腦，是最後的也是最重要的牢籠。\n「甜心，你以為自己活著，還在呼吸，就安全了嗎？」\n當你的大腦背叛你的靈魂時，你會體會到世間最痛苦的折磨。\n而這折磨，會伴隨你一生。"
  },
  Event_118421_Name = {
    Text = "腦際囚籠"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "【碰觸蝴蝶】刪除2張卡牌"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "【驅趕蝴蝶】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118422_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_118422_Desc = {
    Text = "深海里沒有蝴蝶。是被囚禁在房間裡的少女構想出了這些生命。\n它們是那麼美麗，在空中自由地翩翩飛舞。\n「如果……如果我也能像它們，飛離這裡就好了……」\n一隻蝴蝶發出了啜泣，但這聲音掩蓋在無數的振翅聲裡，掩蓋在劈啪的打字音裡，幾不可聞。"
  },
  Event_118422_Name = {
    Text = "靈魂如蝴蝶飛舞"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "【剪斷繩子】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "【替他鬆綁】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "【助他解脫】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_118423_Desc = {
    Text = "「有人說，無盡的欲望是使人前進的動力。」\n「但當這欲望強大到不可忽視，不可斬斷時，我卻只覺得這來自自身的欲望，化為了困住我的牢籠。」\n黑暗中傳來了有氣無力的聲音，你看不見對方的面容，只見到一雙被捆縛的雙手。\n「這些欲望以我的恐懼、懦弱、希望、痛苦為食，又反過來增進了我的欲望。」\n那有氣無力的聲音，發出最後的哀求。\n「我願意獻出一切！好心人，拯救我……或者給予我解脫……」"
  },
  Event_118423_Name = {
    Text = "纏縛之慾"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "【感知大腦】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118424_Desc = {
    Text = "你感覺自己的腦髓抽動了一下。\n「這有什麼特殊的意義嗎？」\n你詢問自己，而大腦寂靜無聲。\n不是每一次對於自身的追問都能獲得答案。"
  },
  Event_118424_Name = {
    Text = "腦際囚籠"
  },
  Event_118425_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118425_Desc = {
    Text = "你奮力上遊，終於躍出了水面。\n混著海腥味的空氣湧入你的肺葉，提醒你並未真正逃離危險。\n但你知道，真正的天空就在你的頭頂。\n就像真相，永遠不會被溫柔的謊言遮蔽。"
  },
  Event_118425_Name = {
    Text = "海洋的擁抱"
  },
  Event_118426_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118426_Desc = {
    Text = "當你碰觸那欲望之繩的刹那，一種刺痛自你的靈魂深處湧起。\n你的恐懼、懦弱、希望、痛苦全部自你的體內湧出，轉化為沾滿血腥的繩子，捆住了你的雙手。\n這時，你聽到了那聲音帶著惡意的歡呼。\n「好心人，你會獲得報酬的……當然，還有詛咒。」"
  },
  Event_118426_Name = {
    Text = "纏縛之慾"
  },
  Event_118427_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118427_Desc = {
    Text = "你的碰觸令蝴蝶們顫抖。\n自誕生以來，它們從沒有感受過這樣溫柔的對待。\n蝴蝶們被不知所措的情緒掌控，甚至忘記了飛翔。\n於是，數不清的蝴蝶墜落，露出那曾被無數翅膀遮掩的打字機。\n那已經失去生命的可憐東西，用最後的力量，打出了「自由」兩個字。"
  },
  Event_118427_Name = {
    Text = "靈魂如蝴蝶飛舞"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "【準備戰鬥】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118428_ChoiceDesc2 = {
    Text = "【嘗試繞路】獲得25黑印"
  },
  Event_118428_Desc = {
    Text = "於星光垂落的深海里，蹈海者們蟄伏了千百年的歲月。\n無垠的海水見證了他們的瘋狂，見證了他們的忍耐，也見證了他們對神明最虔誠的信仰。\n沒有人可以阻擋神明的偉大降臨。\n任何礙事者，都會在蹈海者的怒火中化為灰燼。"
  },
  Event_118429_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118429_Desc = {
    Text = "你下意識捂住了耳朵。\n不可思議的，那些來自靈魂深處的樂音消失了。\n當然，只是暫時的。"
  },
  Event_118429_Name = {
    Text = "褻瀆琴音"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "【重溫過去】獲得3選1高級刻印"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "【窺視未來】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_118430_Desc = {
    Text = "世間沒有什麼能夠穩固不變。\n即便是神母塑造的樂園也是如此。\n在短暫的刹那，你從時空裂隙裡瞥到了一些東西。\n過去、現在、未來交織在那佈滿裂痕的罅隙裡，不停變化。\n等待你好奇的窺探。"
  },
  Event_118430_Name = {
    Text = "時空裂隙"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "【獲得100黑印】"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "【隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_118431_Desc = {
    Text = "無形意志不接受你的選擇。它願意再給你一次機會，讓你做出改變——\n小心，哪怕音樂無形，也能收割性命。"
  },
  Event_118431_Name = {
    Text = "「完美」聖歌"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "【餵食老鼠】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "【驅趕老鼠】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118432_ChoiceDesc3 = {
    Text = "【無視老鼠】獲得25黑印"
  },
  Event_118432_Desc = {
    Text = "這艘船上的一切，都在輪回。\n那些在船上討生活的，令人厭惡且長滿骯髒絨毛的小東西們自然也無法避免這樣的命運。\n一次又一次輪回中，它們吃所能看到的一切，卻仍無法滿足。\n「好……餓啊……」\n成群的老鼠們發出病態又刺耳的尖嘯。\n一次次輪回令它們饑餓難忍，它們必須吃些什麼。\n立刻，馬上！"
  },
  Event_118432_Name = {
    Text = "饑餓的鼠群"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "【迴避視線】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118433_ChoiceDesc2 = {
    Text = "【直視眼睛】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_118433_Desc = {
    Text = "和天空的群星相同，深海里當然也有許多眼睛。\n那些眼睛來自生活於海底的魚，來自褻瀆的腮類，也來自海洋本身。\n噓，不要驚動他們。\n不要，驚動深海的瘋狂。"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "【無視耳語】"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "【聆聽耳語】"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "【反向宣傳】"
  },
  Event_118434_Desc = {
    Text = "「渴望獲得神明的垂青嗎？想要知曉自身的意義嗎？」\n一聲歎息響在你的耳邊，猶如精神病患的自我呢喃，又似無形之物的親昵耳語。\n理智與警惕之下，你出聲拒絕，那聲音卻仍舊自說自話。\n「請耐心聆聽。你將知曉的，是關乎世界命運的真相……」"
  },
  Event_118434_Name = {
    Text = "無形者的佈道"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "【感知大腦】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "【感知靈魂】感染「(Skill.Arg1)」，再次隨機刻印"
  },
  Event_118435_Desc = {
    Text = "被安全保護在頭顱裡的大腦向你傳達了某些資訊。\n你不知道這些資訊是否在神經遞質的轉換和生物電流的傳遞裡受到了磨損。\n唯一可以確定的事實是，你接收到了這資訊，並在軀體的客觀存在裡，感知到了自己的存活。"
  },
  Event_118435_Name = {
    Text = "腦際囚籠"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_118436_Desc = {
    Text = "「不錯的答案，但很可惜，不是正確答案。」\n「那什麼是正確答案？」\n未知存在沒有回答你的問題，只是發出了一聲嗤笑。\n「誰告訴你命運有正確答案？」"
  },
  Event_118436_Name = {
    Text = "命運博弈"
  },
  Event_118437_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118437_Desc = {
    Text = "「你以為我沒有嘗試過剪斷它們？不，當你抗拒欲望時，它們只會變得更加強烈！」\n感受著欲望化成的繩子越來越緊，甚至勒入血肉，那聲音發出絕望的狂呼。\n「我永遠擺脫不了它們……永遠！」"
  },
  Event_118437_Name = {
    Text = "纏縛之慾"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_118438_Desc = {
    Text = "漆黑的烏鴉在哭泣。\n漆黑的烏鴉在呐喊。\n漆黑的烏鴉在狂嘯。\n然而在人們聽來，它只是在唱歌。\n「啊，多麼無憂無慮的歌聲啊。真希望我也是一隻烏鴉，遠離人世的煩惱。」"
  },
  Event_118438_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118439_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118439_Desc = {
    Text = "蝴蝶散去，你終於看清了下方的打字機。\n那已經失去生命的可憐東西，用最後的力量，打出了「離開」兩個字。"
  },
  Event_118439_Name = {
    Text = "靈魂如蝴蝶飛舞"
  },
  Event_118440_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118440_Desc = {
    Text = "過去的影像裡，披著毛絨大衣的少女向著你揮手。\n你聽不清她說了什麼，但你看到了少女的笑容。"
  },
  Event_118440_Name = {
    Text = "時空裂隙"
  },
  Event_118441_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118441_Desc = {
    Text = "深海再次恢復了漆黑與寂靜。\n在這漆黑與寂靜裡，你再次聽到了心跳聲。\n那聲音來自你的體內。\n在別人眼中，你也只是一個遊曳在漆黑深海的跳動心臟。"
  },
  Event_118441_Name = {
    Text = "弱肉強食"
  },
  Event_118442_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118442_Desc = {
    Text = "這次，化為灰燼的並非礙事者，而是蹈海者。\n群星無聲俯視著這一幕，一如過去千百年那樣，保持沉默。"
  },
  Event_118443_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118443_Desc = {
    Text = "儘管在數量上佔據優勢，那些骯髒鼠類的膽量卻比它們的身體更小。\n它們被你強勢的態度所恐嚇，一哄而散。"
  },
  Event_118443_Name = {
    Text = "饑餓的鼠群"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "【伸出援手】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "【靜默旁觀】獲得3選1刻印"
  },
  Event_118444_Desc = {
    Text = "一隻跳動的心臟遊曳在漆黑的深海。\n它或許屬於一隻遊魚，或許屬於某個生有魚鰓的生物。\n你看不清。你唯一能夠看清的，就是那不停跳動的心臟，和那心臟後方，逐漸張開的血盆大口。\n狩獵，或者被狩獵，是大自然的法則。\n無論是在陸地，還是海洋。"
  },
  Event_118444_Name = {
    Text = "弱肉強食"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "【揮手驅趕】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118445_ChoiceDesc2 = {
    Text = "【任由停留】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118445_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_118445_Desc = {
    Text = "黑暗裡傳來了輕微的聲響。\n那是一隻蝴蝶禮貌地問詢。\n「我可以落在你的掌心嗎？」\n「我只是太累了，想要休息一下……」\n如此問詢著，蝴蝶穿越過黑暗，盤旋在你的面前。\n漆黑的粘液自它的翅膀滴落——那是蝴蝶穿越黑暗時，來自黑暗的饋贈。"
  },
  Event_118445_Name = {
    Text = "蝴蝶的請求"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "【離開】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_118446_Desc = {
    Text = "一陣沉默後，什麼東西被拋到了你的懷裡。\n「拿著它離開吧。」\n「命運對於好運者，一向慷慨。」"
  },
  Event_118446_Name = {
    Text = "命運博弈"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "【跟隨指引】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118447_ChoiceDesc2 = {
    Text = "【無視指引】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118447_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_118447_Desc = {
    Text = "祭典已經開始。\n在靈的焰火與血的祝禱下，數不清的信徒靈魂化作了航標——\n縹緲的靈分散在你的周圍，猶如引路的精靈，閃著光等待你的選擇。"
  },
  Event_118447_Name = {
    Text = "靈魂航標"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_118448_Desc = {
    Text = "「無知的人類！」\n那聲音發出懊惱的抱怨，卻未至憤怒的程度。\n因它知曉，無知者總有開悟的時刻。\n它只需等待那一日的到來。\n並在那一日的到來前，於你身上刻下神明的烙印，確認你靈魂的歸屬。"
  },
  Event_118448_Name = {
    Text = "無形者的佈道"
  },
  Event_118449_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118449_Desc = {
    Text = "「@2的@3……」\n龐雜的知識隨同褻瀆的樂音，灌入你的大腦。\n但人類的身體，卻限制了你，讓你無法理解來自宇宙的學識。\n真是可悲的遺憾。"
  },
  Event_118449_Name = {
    Text = "褻瀆琴音"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_118450_Desc = {
    Text = "「其實，我也有一個世界的真相想要告訴你……」\n「世界是由長有兩個智慧的肉丸眼睛，和象徵無限能力的意麵組成的飛天意麵神所創造……」\n你認真地胡謅著聽來的趣事，等待對方的反應。\n但過了許久，對面都毫無動靜。\n「唉，看來狂信者不懂得幽默。」\n你歎息一聲，只能離開。"
  },
  Event_118450_Name = {
    Text = "無形者的佈道"
  },
  Event_118451_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118451_Desc = {
    Text = "你的調律並未使這錯亂的音節變得和諧。\n但至少，無形意志看到了你的嘗試。\n這是個好的開始。"
  },
  Event_118451_Name = {
    Text = "「完美」聖歌"
  },
  Event_118452_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118452_Desc = {
    Text = "三個人影顫抖著，無聲啜泣。\n它們的信仰被你質疑，而這，是狂信者最不能容忍的冒犯。"
  },
  Event_118453_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118453_Desc = {
    Text = "未來的影像裡，生出腕足的少女驕矜地瞥了你一眼，出聲呵斥。\n「神母的真容不容褻瀆。」\n於是，影像消失，時空裂隙也瞬間關閉。徒留你回憶著剛才的景象。"
  },
  Event_118453_Name = {
    Text = "時空裂隙"
  },
  Event_118454_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118454_Desc = {
    Text = "你成功擺脫了蹈海者，繼續向前奔襲。\n在你的頭頂，群星靜靜閃耀，一如過去的千百年。"
  },
  Event_118455_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118455_Desc = {
    Text = "未知存在沒有阻攔你。\n「總有一天，你會再回來的。」\n「沒有人，可以拒絕命運。」"
  },
  Event_118455_Name = {
    Text = "命運博弈"
  },
  Event_118456_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118456_Desc = {
    Text = "乾脆俐落的動作下，那雙手無力地垂下。\n但你沒有錯過對方最後的歎息。\n他終於從自身無盡的欲望裡，真正解脫。"
  },
  Event_118456_Name = {
    Text = "纏縛之慾"
  },
  Event_118457_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118457_Desc = {
    Text = "不被感知是世間必然的宿命。\n沒有誰能夠完全共情另一個生命。"
  },
  Event_118457_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_118458_Desc = {
    Text = "漆黑的烏鴉在哭泣。\n漆黑的烏鴉在呐喊。\n漆黑的烏鴉在狂嘯。\n然而在人們聽來，它只是在唱歌。\n「啊，多麼無憂無慮的歌聲啊。真希望我也是一隻烏鴉，遠離人世的煩惱。」"
  },
  Event_118458_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "【側耳聆聽】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118459_ChoiceDesc2 = {
    Text = "【堵住耳朵】獲得3選1刻印"
  },
  Event_118459_Desc = {
    Text = "無形的狂亂中，你似乎看到了一架鋼琴。\n有一雙看不清形狀的手，在這無形的琴鍵上躍動，彈奏著褻瀆的樂音。\n弔詭的音樂自你的靈魂深處響起，通過血管的線路，直達你顫動的大腦。"
  },
  Event_118459_Name = {
    Text = "褻瀆琴音"
  },
  Event_118460_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118460_Desc = {
    Text = "那些靈感、迷思和狂想混雜在一起，調和成世間最絢爛的顏色。\n你看到空間在自己體內折疊，時間隨自己的意願盤旋。\n此刻，你洞察了時空，無所不能，無所不知。\n當然，你也付出了代價。"
  },
  Event_118460_Name = {
    Text = "思維萬花筒"
  },
  Event_118461_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118461_Desc = {
    Text = "混沌的靈魂以尖銳的嚎哭為你指引前路。\n那是安全的前路嗎？你不知道。\n你唯一的選擇，只有繼續前行。"
  },
  Event_118461_Name = {
    Text = "靈魂航標"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "【放任不管】獲得25黑印，離開"
  },
  Event_118462_Desc = {
    Text = "漆黑的烏鴉在哭泣。\n漆黑的烏鴉在呐喊。\n漆黑的烏鴉在狂嘯。\n然而在人們聽來，它只是在唱歌。\n「啊，多麼無憂無慮的歌聲啊。真希望我也是一隻烏鴉，遠離人世的煩惱。」"
  },
  Event_118462_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118463_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118463_Desc = {
    Text = "混沌的靈魂發出一聲哀怨的歎息。\n它漸漸消散了，但那哀怨的歎息，如有實質，落上了你的心臟。\n咚咚，你的心跳和祭典的樂音同頻響起。"
  },
  Event_118463_Name = {
    Text = "靈魂航標"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_118464_Desc = {
    Text = "「啊，啊，這是多麼虔誠的羔羊啊！」\n那聲音慨歎著，充滿了讚譽的狂喜。\n「當吾主甦醒時，像你這樣的羔羊必然能在那崇高而偉大的神國裡找到一處容身之所……」"
  },
  Event_118464_Name = {
    Text = "無形者的佈道"
  },
  Event_118465_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118465_Desc = {
    Text = "「天空」包容著你的任性。\n總有一日，迷途的孩子會回歸母親的懷抱。\n因為，你無處可逃。"
  },
  Event_118465_Name = {
    Text = "海洋的擁抱"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "【接受擁抱】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc2 = {
    Text = "【拒絕擁抱】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc3 = {
    Text = "【遊出水面】獲得25黑印"
  },
  Event_118466_Desc = {
    Text = "世界在你的眼中傾倒。\n此刻，環繞你的深海才是「天空」。\n在幾近溺亡的痛苦裡，這片深藍的「天空」溫柔地靠近，意圖將你擁入懷中。\n它不會評判，只會給予。"
  },
  Event_118466_Name = {
    Text = "海洋的擁抱"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "【呵斥它們】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118467_ChoiceDesc2 = {
    Text = "【回應它們】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "【無視他們】獲得50黑印"
  },
  Event_118467_Desc = {
    Text = "三個形狀模糊的靈魂攔住了你的前路。\n一個人影虔誠地向你行禮，懇請你賜予鮮血。你流動的血液，是獻給神最好的祭品。\n一個人影冷漠地向你舉刀，意圖割下你的血肉。那未變異的人肉，定能俘獲神的青睞。\n最後一個只無聲注視你，希望你收走自己的生命，以此證明最虔誠的信仰。"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_118468_Desc = {
    Text = "漆黑的烏鴉在哭泣。\n漆黑的烏鴉在呐喊。\n漆黑的烏鴉在狂嘯。\n然而在人們聽來，它只是在唱歌。\n「啊，多麼無憂無慮的歌聲啊。真希望我也是一隻烏鴉，遠離人世的煩惱。」"
  },
  Event_118468_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_118469_Desc = {
    Text = "「不！我們不要這些！我們要更加……美味的東西。」\n「那就是……你的血肉！」\n成群的老鼠發出尖嘯，向你湧來。\n看來氾濫的善心，有時反而會惹來麻煩。"
  },
  Event_118469_Name = {
    Text = "饑餓的鼠群"
  },
  Event_118470_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118470_Desc = {
    Text = "你的尊重博得了那些眼睛的好感。\n消失前，它們透過湧動的海水，贈送給你一個禮物。\n那是深海馴服你的證物。"
  },
  Event_118471_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118471_Desc = {
    Text = "在你毫不遮掩的目光下，深海慢慢甦醒。\n海水狂亂地湧動在你的周圍，帶來不可名狀的囈語。\n感受深海的憤怒吧，這是賜福，也是詛咒。"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_118472_Desc = {
    Text = "漆黑的烏鴉在哭泣。\n漆黑的烏鴉在呐喊。\n漆黑的烏鴉在狂嘯。\n然而在人們聽來，它只是在唱歌。\n「啊，多麼無憂無慮的歌聲啊。真希望我也是一隻烏鴉，遠離人世的煩惱。」"
  },
  Event_118472_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118473_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118473_Desc = {
    Text = "鮮血、肉塊，生命。\n祭品已經備好，接下來只需要靜靜等待神的饗宴。"
  },
  Event_118474_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118474_Desc = {
    Text = "蝴蝶明白了你的拒絕。\n沾滿漆黑粘液的翅膀再次震動，在黑暗中搖搖晃晃地飛舞。\n很快，黑暗再次吞噬了蝴蝶。這次，它已無力掙扎。"
  },
  Event_118474_Name = {
    Text = "蝴蝶的請求"
  },
  Event_118475_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118475_Desc = {
    Text = "蝴蝶落到了你的掌心，一同落下的，還有那斑斕翅膀上的漆黑粘液。\n在你的歎息聲中，斑斕的翅膀漸漸融化，與漆黑的粘液嵌合成未知的混沌形狀。\n這只蝴蝶再也不用經歷黑暗了。\n它安眠於你的掌心。"
  },
  Event_118475_Name = {
    Text = "蝴蝶的請求"
  },
  Event_118477_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118477_Desc = {
    Text = "聲嘶力竭的烏鴉終於閉上了眼睛。\n在無人知曉、不被感知的怨恨裡，它咽下最後一口氣，化為一灘黑色的濃漿。"
  },
  Event_118477_Name = {
    Text = "不被感知的怨歎"
  },
  Event_118478_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118478_Desc = {
    Text = "「謝謝你……」\n跳動的心臟雀躍地奔向遠方。\n不久後，漆黑的深海里傳來了咀嚼血肉的聲音。"
  },
  Event_118478_Name = {
    Text = "弱肉強食"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "【接受邀請】感染「(Skill.Arg1)」，獲得詛咒造物-「(RelicConfig.Arg2)」"
  },
  Event_118479_ChoiceDesc2 = {
    Text = "【拒絕邀請】選擇銷毀1個造物，獲得1個獎勵"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_118479_Desc = {
    Text = "「這艘船上的一切，都必須成為這不斷潰散又重啟的循環樂園的一部分。」\n狂亂的樂音奏響在你的腦海，那是無形意志對你的啟迪。\n「這裡沒有哭泣，沒有悲傷，只有純潔的聖樂和永恆的歡笑。」\n「你願意加入樂園，成為這完美樂音的一部分嗎？」"
  },
  Event_118479_Name = {
    Text = "「完美」聖歌"
  },
  Event_118480_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_118480_Desc = {
    Text = "在你的靜默中，靈魂們無聲消散。\n不理解信仰者，不值得它們浪費時間。"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "【領取標準造物】"
  },
  Event_123616_Desc = {
    Text = "將所有喚醒體狂氣設置為 100，銀鑰設置為 1000，生命設置為 80％。\n移除 2 張卡牌，置入 3 張症狀卡。\n猩紅熔爐設置為 12.5％，選擇 4 張卡牌置入超維空間。\n獲得標準造物包。"
  },
  Event_123616_Name = {
    Text = "一鍵跳過道中"
  },
  Event_125696_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125696_Desc = {
    Text = "無來由的憤怒驅使著你，你抬起手，奮力驅趕。你在謎題裡停留了太久，或許你渴盼的是一場酣暢的戰鬥，甚至只是渴盼著終結……\n但鴉群什麼也沒有做。在你的注視下，深淵消散。\n鴉群消失在舞台的盡頭，那個你將要去往的地方。"
  },
  Event_125696_Name = {
    Text = "群鴉深淵"
  },
  Event_125697_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125697_Desc = {
    Text = "「膽小。」女聲絲毫不掩飾她笑聲中的嘲弄。\n「走吧，走得越遠越好。」"
  },
  Event_125697_Name = {
    Text = "命運之鎖"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "【驅趕】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125698_ChoiceDesc2 = {
    Text = "【聆聽】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_125698_Desc = {
    Text = "黑暗裡傳來了輕微的聲響。一隻蝴蝶落入你的掌心。你記得它。\n「阿拉克涅小姐……你從沒有拋棄過我們，對嗎？」\n蝴蝶美麗的花紋，望向你身邊的人。"
  },
  Event_125698_Name = {
    Text = "蝴蝶的餘生"
  },
  Event_125699_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125699_Desc = {
    Text = "那聲音與文字如同蜂群般鑽入你的腦海。你屏息凝神，將那無用的雜念摒除在頭腦之外。\n無視比閱讀要困難太多太多，但你做到了。"
  },
  Event_125699_Name = {
    Text = "維度電報"
  },
  Event_125700_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125700_Desc = {
    Text = "那是敵人製造的幻覺！\n你搖搖頭，清醒了過來，再次握緊手中的銀鑰。"
  },
  Event_125701_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125701_Desc = {
    Text = "你認真凝望那隻眼，努力地注視、傾聽。你嘗試走進演員的內心，體察他正經歷的苦痛。\n你靠近，靠近。你穿過他的身軀，觸碰到他的靈魂……\n你猛地睜開眼，發現自己正站在舞台的中央，眼淚順著指尖流下。\n那是你獻給觀眾的剖白。"
  },
  Event_125701_Name = {
    Text = "演員的剖白"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "【與她討論】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "【沉默不語】"
  },
  Event_125702_Desc = {
    Text = "「歡樂的結局固然美好，可那虛假的歡樂，永遠無法觸及觀眾的心……」\n劇作者閉目沉思。她對這個結局並不滿意。"
  },
  Event_125702_Name = {
    Text = "劇作的結局"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_125703_Desc = {
    Text = "「吱呀——吱呀——命運的女神轉動她的紡機。\n吱呀——吱呀——命運的絲線在她手中匯集。」"
  },
  Event_125703_Name = {
    Text = "最後的預言"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "【自己】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "【威廉】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125704_ChoiceDesc3 = {
    Text = "【誰也不是】獲得25黑印"
  },
  Event_125704_Desc = {
    Text = "你肯定自己沒有喝醉，但望向酒精的時候，你墜入一片寧靜的湖泊。\n優雅的杯中映出一個身影，那是誰？"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "【聆聽】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "【驅趕】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_125705_Desc = {
    Text = "在你靠近體內質體的力量時，一群烏鴉出現在你的腦海，在你紊亂的精神空間中盤旋。\n\n群鴉環繞著你，一道深淵在你頭頂倒置流轉。\n十萬隻烏鴉齊聲鳴叫，如同一道嘲諷的預言。"
  },
  Event_125705_Name = {
    Text = "群鴉深淵"
  },
  Event_125706_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125706_Desc = {
    Text = "你與阿拉克涅嘗試穩定住身側崩毀的命運。你們的努力收效甚微，但這已經足夠。利用爭取到的時間，你們繼續靠近涅芙蕾亞。\n你來到這裡，是為了將解脫帶給她。"
  },
  Event_125706_Name = {
    Text = "命運之網謝幕"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_125707_Desc = {
    Text = "「它們與巨網一同死去，悄無聲息。」"
  },
  Event_125707_Name = {
    Text = "最後的預言"
  },
  Event_125708_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125708_Desc = {
    Text = "那是一封寄給淵獄的電報。\n「不要著急，我的孩子們。監牢的大門即將開啟，你們的自由就要來臨。」"
  },
  Event_125708_Name = {
    Text = "維度電報"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "【驅趕】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125709_ChoiceDesc2 = {
    Text = "【聆聽】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_125709_Desc = {
    Text = "一隻蝴蝶輕輕停駐在你的手中。美麗的花紋如同眼珠，靜靜望向你。\n或許，它想要告訴你什麼？"
  },
  Event_125710_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125710_Desc = {
    Text = "二十雙哀戚的眼睛望向你。烏鴉停止了歌唱，帶著最後的預言離開了這張搖搖欲墜的網。"
  },
  Event_125710_Name = {
    Text = "最後的預言"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "【彎腰探出】感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」"
  },
  Event_125711_ChoiceDesc2 = {
    Text = "【放棄查看】獲得50黑印"
  },
  Event_125711_Desc = {
    Text = "走過街角的時候，你看到一座簡樸的放映廳。你並不記得倫蒂尼恩有這樣一家店存在。"
  },
  Event_125711_Name = {
    Text = "記憶影廳"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "【接受命運】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "【反抗命運】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_125712_Desc = {
    Text = "「啊，我們又見面了，親愛的。」\n你開始享受那道在你大腦中迴盪的年輕女聲。它溫柔，誘惑，如同誘捕飛蟲的網。\n「來吧，告訴我，你願意接受你的命運嗎？」"
  },
  Event_125712_Name = {
    Text = "宿命囚籠"
  },
  Event_125713_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125713_Desc = {
    Text = "「愚蠢的人類，我跟你很熟嗎？」\n黑貓嫌棄地白了你一眼，轉過身去。\n「離開這裡吧。下次不要再做這種蠢事了。」"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "【拍攝照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "【更換姿勢】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，可以使用兩次"
  },
  Event_125714_Desc = {
    Text = "一架相機孤零零地站在舞台上，漆黑的鏡頭望向你，像是機械神明創造出的神秘複眼。\n「這座劇院已經很久沒有觀眾了……歡迎！歡迎！來拍張照吧！完全免費！」\n相機興奮地喊叫著。在這座無人在意的舞台上，它是唯一的主角。"
  },
  Event_125714_Name = {
    Text = "觀眾席的留影"
  },
  Event_125715_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125715_Desc = {
    Text = "「對命運沒有疑問的人，要如何期盼命運的回答呢？」"
  },
  Event_125715_Name = {
    Text = "命運之鎖"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "【思考破局】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "【順其自然】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "【浮出水面】獲得25黑印"
  },
  Event_125716_Desc = {
    Text = "一座新的舞台，兩個交疊的人生……躲避警員的路上，你整理著阿拉克涅告訴你的這些事。\n繁雜的思緒中，你墜入寧靜的深海。"
  },
  Event_125716_Name = {Text = "寧靜"},
  Event_125717_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125717_Desc = {
    Text = "蝴蝶飛到你的肩頭，湊到你的耳邊。你認真傾聽，但你只聽到了它翅膀的翕動，如同無聲的嘆息。\n在你的聆聽裡，那雙斑斕的翅膀漸漸融化，蝴蝶於你的肩頭安眠。\n你再也無法得知它想告知你的話語。"
  },
  Event_125717_Name = {
    Text = "蝴蝶的餘生"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "【咀嚼】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "【拒絕】獲得3選1刻印"
  },
  Event_125718_Desc = {
    Text = "「餓了吧，親愛的客人？」\n一道黏膩的聲音從吧台後方響起。你回過身去，沒有看到任何東西。\n「午夜假面酒吧的小吃也遠近聞名。要試試看嗎？」"
  },
  Event_125718_Name = {
    Text = "命運的味道"
  },
  Event_125719_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125719_Desc = {
    Text = "你不敢隨意閱讀上面的文字，只是仔細打量那個精緻的信封。\n信封上的火漆刻印著一個模糊的族徽，上面用漂亮的花體字寫下：\n「致新生的阿拉克涅小姐。」\n「您忠誠的管家，埃德加。」"
  },
  Event_125720_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125720_Desc = {
    Text = "「原來如此，我明白了，姐姐……」\n「劇作者從來無法改寫角色的結局。那淒慘的命運早已注定，即便是你，也從來無法改變……」\n悲傷的哽咽消失了。劇作者的打字機化成一隻隻蝴蝶，散入空曠的命運劇院，再也看不見蹤跡。"
  },
  Event_125720_Name = {
    Text = "劇作的結局"
  },
  Event_125721_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125721_Desc = {
    Text = "不知名的演員，危險的舞步……那又有什麼關係？不會有什麼比命運本身更糟糕了。\n你伸出手，踏上舞台。木偶拉起你的手，跳起歡快的舞。\n你聽見了掌聲。"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_125722_Desc = {
    Text = "「它們跳舞。它們歡唱。吱呀——吱呀——」"
  },
  Event_125722_Name = {
    Text = "最後的預言"
  },
  Event_125723_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125723_Desc = {
    Text = "指引者，戰友，孤獨維度裡僅有的同伴。\n你們會一起解決掉這裡的一切，返回卡達斯。你從未質疑過這一點。"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "【賭一把】感染「(Skill.Arg1)」，進入賭局"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "【還是算了】獲得25黑印"
  },
  Event_125724_Desc = {
    Text = "在小巷的街角，一雙骯髒的手攔住了你。\n一個衣衫襤褸的乞丐悄悄湊近你，眼神貪婪得如同看到腐肉的鬣狗。\n「來！來一把！我會告訴你你想知道的全部！只要你贏下來……」"
  },
  Event_125724_Name = {
    Text = "街頭賭局"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "【無視】刪除1張指令卡，獲得25黑印"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "【閱讀】複製一張牌庫中的牌，感染「(Skill.Arg1)」"
  },
  Event_125725_Desc = {
    Text = "嗒嗒嗒，嗒嗒嗒……\n酒吧的角落空無一人，傳真電報機清脆地響著，如同一支優美的鋼琴曲。"
  },
  Event_125725_Name = {
    Text = "維度電報"
  },
  Event_125726_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125726_Desc = {
    Text = "「閉嘴，我是一隻貓，我不想聽你們那些愚蠢的故事。」\n黑貓嘆了口氣，轉過身去。\n「離開這裡吧。下次不要再做這種蠢事了。」"
  },
  Event_125727_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125727_Desc = {
    Text = "她說的或許沒錯，那就是你，是你內心深處最隱晦最骯髒的想法。\n每個人都是自私的，你從未如他人所想的那樣高尚。\n你品嚐著那卑劣的痛苦。你知道過去的已經過去，而你的救贖就在前方。"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "【與她討論】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "【沉默不語】"
  },
  Event_125728_Desc = {
    Text = "「壯烈的結局是多麼真實，可我們的現實已如此淒慘，就連在故事裡，我們也無法給她一個美好的歸宿嗎……」\n劇作者閉目沉思。她對這個結局並不滿意。"
  },
  Event_125728_Name = {
    Text = "劇作的結局"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "【離開】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_125729_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「為什麼……為什麼永遠沒有人能夠贏下來！……」"
  },
  Event_125729_Name = {
    Text = "街頭賭局"
  },
  Event_125730_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125730_Desc = {
    Text = "你盡力靠近它，認真地傾聽它。\n蝴蝶扇動翅膀，離開了你的掌心。\n你什麼也沒有聽見。"
  },
  Event_125731_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125731_Desc = {
    Text = "面對你的驅趕，蝴蝶無動於衷。\n它執著地追逐著你的手掌，在你最後一次揮動手臂時，它終於選擇離開。\n你有些後悔。或許，你該聽聽它的話？"
  },
  Event_125732_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125732_Desc = {
    Text = "黑色的煙霧失落地抖動，乞丐痛苦的哭喊聲嘶力竭。\n骰子與乞丐在你一次眨眼後消失不見。破舊的禮帽中，留下了遊戲的獎勵。"
  },
  Event_125732_Name = {
    Text = "街頭賭局"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "【加入狂歡】感染「(Skill.Arg1)」，獲得詛咒造物-「(RelicConfig.Arg2)」"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "【阻止奏樂】選擇銷毀1個造物，獲得1個獎勵"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "【摀住耳朵】獲得50黑印"
  },
  Event_125733_Desc = {
    Text = "「啊！音樂！偉大的劇目怎麼能沒有音樂！！」\n不諧的交響在破碎的劇院響起，如同一場混沌的狂歡。來自淵獄的演員們在這無序的頌歌中舞蹈、歡呼，那是他們賴以為生的音符。"
  },
  Event_125733_Name = {
    Text = "命運頌歌"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "【獲得100黑印】"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "【隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_125734_Desc = {
    Text = "無形的命運絲線在音符中起舞，在那雜亂的聲音中，你漸漸抓到了那道迷人的旋律——沒錯，那正是命運應有的聲音。\n淵獄的遺棄者們向你歡呼，他們簇擁著你，將你帶入他們無序的狂歡。\n恭喜你，幸運的觀眾！現在，你將與演員們一起向命運謝幕。"
  },
  Event_125734_Name = {
    Text = "命運頌歌"
  },
  Event_125735_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125735_Desc = {
    Text = "你無法辨識這聲音的意義，但你知道，它必須停下。\n銀光如同發瘋的利刃般揮砍，那節奏竟和音符萬般契合。\n在你反應過來時，音符不知從何時便已停下。你再也聽不見任何聲音。你看到的唯有黑夜，你聽到的唯有寂靜。\n無序的嘈雜與絕對的寂靜，究竟哪個更可怕呢……守密人？"
  },
  Event_125735_Name = {
    Text = "命運頌歌"
  },
  Event_125736_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125736_Desc = {
    Text = "你伸出手，一隻蝴蝶輕輕停在你的手上。\n沒錯。死亡，消散，流逝……蝴蝶於繭中誕生，痛苦是藝術永恆的土壤。\n作為一個優秀的觀眾，這是你不得不明白的真理。"
  },
  Event_125736_Name = {
    Text = "於消散中綻放"
  },
  Event_125737_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125737_Desc = {
    Text = "這或許又是涅芙蕾亞的什麼把戲。\n蝴蝶聽懂了你的話，黑暗中響起它無聲的嘆息。流淌著漆黑黏液的翅膀震動，很快，蝴蝶沉重的身影淹沒在無垠的黑暗裡。\n你再也無法得知它想告知你的話語。"
  },
  Event_125737_Name = {
    Text = "蝴蝶的餘生"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_125738_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「為什麼……為什麼永遠沒有人能夠贏下來！……」"
  },
  Event_125738_Name = {
    Text = "街頭賭局"
  },
  Event_125739_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125739_Desc = {
    Text = "現在任憑思緒胡亂湧動是危險的。你搖了搖頭，趕緊浮出了水面……"
  },
  Event_125739_Name = {Text = "寧靜"},
  Event_125740_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125740_Desc = {
    Text = "並非所有的音符都需要聽眾，並非所有的命運都需要答案。\n你緊緊摀住耳朵，離開了這座嘈雜的舞台。\n你仍會好奇那不諧樂聲的意義，但你知道，你做了唯一正確的抉擇。"
  },
  Event_125740_Name = {
    Text = "命運頌歌"
  },
  Event_125741_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125741_Desc = {
    Text = "銀光刺破幻影，黑貓們化作一灘灘黑色的黏液。\n想幻化成黑貓來躲避，可逃不過你的眼睛。"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "【接受命運】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125742_Desc = {
    Text = "「沒有人能真正反抗命運，親愛的。我們從來就沒有選擇的權利。」\n女聲變得失落、遙遠。你不確定，她想要對話的是你，還是另外的什麼東西。"
  },
  Event_125742_Name = {
    Text = "宿命囚籠"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_125743_Desc = {
    Text = "「木偶們排隊入場，踏入命運的巨網。」"
  },
  Event_125743_Name = {
    Text = "最後的預言"
  },
  Event_125744_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125744_Desc = {
    Text = "你抬頭仰望那渦流般的深淵，試圖傾聽鴉群的神諭。\n但鴉群什麼也沒有說。在你的注視下，深淵消散。\n鴉群消失在舞台的盡頭，那個你將要去往的地方。"
  },
  Event_125744_Name = {
    Text = "群鴉深淵"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "【贊同蝴蝶】刪除2張卡牌"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "【反對蝴蝶】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125745_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_125745_Desc = {
    Text = "舞台的帷幕在風中翕動，在屍體落下的黑色黏液中，你看到了一群蝴蝶。\n「真正的藝術，總是於消散中綻放……對吧，守密人？」\n舞者的屍體正向你微笑。你聽見蝴蝶振翅的聲音。"
  },
  Event_125745_Name = {
    Text = "於消散中綻放"
  },
  Event_125746_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125746_Desc = {
    Text = "詭辯永遠無法干擾你，你清晰地知道自己正走在一條什麼樣的道路，知道自己的終點是在何方。\n荊棘在你的體內消散。你踏上道路，一如往日。"
  },
  Event_125747_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125747_Desc = {
    Text = "你轉過身去，嘗試忘記身後那些眼睛。但你發現自己的身體似乎難以像往常那樣控制。\n你知道，那些凝望的目光，你永遠無法逃離。"
  },
  Event_125747_Name = {Text = "觀眾"},
  Event_125748_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125748_Desc = {
    Text = "無論是出於尊重還是畏懼，你都不願輕易觸碰，將信封放回原處。在你準備離開的時候，一道混濁但溫和的聲音從信封後的黑暗中響起。\n「謝謝您還記得我，阿拉克涅小姐……」"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "【守護的力量】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "【逃離的自由】隨機1張卡牌獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "【拒絕回答】獲得50黑印"
  },
  Event_125749_Desc = {
    Text = "午夜假面的酒精爬進你的腦袋，如同鎖鏈般束縛住你。順著冰冷的鏈條，年輕女性的聲音在你腦海中縈繞。\n「告訴我，親愛的。你想要的命運，究竟是什麼？」"
  },
  Event_125749_Name = {
    Text = "命運之鎖"
  },
  Event_125750_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125750_Desc = {
    Text = "即便再複雜的事務，也需要由你們來解決。\n感到愈發沉重的同時，你也感受到了新的力量。"
  },
  Event_125750_Name = {Text = "寧靜"},
  Event_125751_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125751_Desc = {
    Text = "不知名的演員，危險的舞步。沒錯，逃離總是最保險的。\n你轉身奔跑，拉開劇場的帷幕，然後，你站在了舞台上。木偶拉起你的手，跳起歡快的舞。\n命運的舞台，從來沒有選擇。"
  },
  Event_125752_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125752_Desc = {
    Text = "現在可不是去看一部電影的時候。"
  },
  Event_125752_Name = {
    Text = "記憶影廳"
  },
  Event_125753_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125753_Desc = {
    Text = "路途上的危險絲毫沒有進入你的腦海。你走過身側崩毀的命運，繼續靠近涅芙蕾亞。\n你來到這裡，是為了將解脫帶給她。"
  },
  Event_125753_Name = {
    Text = "命運之網謝幕"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "【閱讀信封】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125754_ChoiceDesc2 = {
    Text = "【閱讀信件】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "【放回原處】獲得50黑印"
  },
  Event_125754_Desc = {
    Text = "你們的動作將密密麻麻的蛛網扯碎，一封陳舊的信件從蛛網裡掉落下來。\n它的分量遠比薄薄的紙張沉重。"
  },
  Event_125755_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125755_Desc = {
    Text = "烏鴉的眼中落出淚水。烏鴉的嘴角流淌鮮血。烏鴉用盡全部的生命，為你唱出牠最後的預言。"
  },
  Event_125755_Name = {
    Text = "最後的預言"
  },
  Event_125756_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125756_Desc = {
    Text = "「呵呵……哈哈哈哈！」\n「怎麼樣，我的客人？命運的味道，你會瘋狂地想念的……」"
  },
  Event_125756_Name = {
    Text = "命運的味道"
  },
  Event_125757_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125757_Desc = {
    Text = "「無趣。」女聲打了一個慵懶的哈欠。\n「帶上你的力量，去俱樂部參加搏擊去吧。」"
  },
  Event_125757_Name = {
    Text = "命運之鎖"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "【穩定命運之網】獲得3選1高級刻印"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "【無視危險】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125758_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_125758_Desc = {
    Text = "她是美好的寵兒。她是命運的棄嬰。她是循著黯淡光點、自深淵爬出的復仇者。她來到這裡，為一切帶來解脫。\n命運之網在你們身周崩塌傾毀。你站在劇院的舞台，與涅芙蕾亞隔著並不遙遠的距離。"
  },
  Event_125758_Name = {
    Text = "命運之網謝幕"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "【不明所以】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "【感同身受】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125759_Desc = {
    Text = "舞台上傳來撕心裂肺的哭喊，唯一的燈光落在孤獨的身影上。\n他正為你獻上他最誠摯的表演——將他的腑臟剖開，呈給每一位觀眾看。\n是什麼讓這個角色如此痛苦？"
  },
  Event_125759_Name = {
    Text = "演員的剖白"
  },
  Event_125760_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125760_Desc = {
    Text = "你的手伸向右邊。\n那是你的未來，你最強烈的渴盼，你的歸宿，你將要抵達的地方。\n你的存在，是為了追逐前方的太陽。"
  },
  Event_125760_Name = {
    Text = "過去，未來"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "【三點】"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "【六點】"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "【一點】"
  },
  Event_125761_Desc = {
    Text = "你當然可以直接離開，但那枚精巧的骰子徹底吸引了你。\n你忘記了身後的追兵，將它虔誠地拿起，扔進禮帽裡——"
  },
  Event_125761_Name = {
    Text = "街頭賭局"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_125762_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「為什麼……為什麼永遠沒有人能夠贏下來！……」"
  },
  Event_125762_Name = {
    Text = "街頭賭局"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "【接受命運】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "【反抗命運】感染「(Skill.Arg1)」，再次隨機刻印"
  },
  Event_125763_Desc = {
    Text = "「啊，淘氣鬼。命運總是仁慈的……但所有的反抗都有代價。現在，你願意接受它嗎？」"
  },
  Event_125763_Name = {
    Text = "宿命囚籠"
  },
  Event_125764_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125764_Desc = {
    Text = "你環顧著那些目光，向它們揮手致意。\n很快，你便會將故事的高潮賜予它們。"
  },
  Event_125764_Name = {Text = "觀眾"},
  Event_125765_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125765_Desc = {
    Text = "「親愛的阿拉克涅小姐，今天是您出生的日子，我為老爺與夫人、也為您感到喜悅。歡迎您來到這個美麗的世界。我將這首溫柔的安眠曲獻予您，願您從誕生的這一天起，度過無憂無慮的一生……」"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "【拍攝照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "【再次更換】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，還可以使用一次"
  },
  Event_125766_Desc = {
    Text = "面對鏡頭你有些惶恐。或許這個姿勢拍出來會更好？或許那個？"
  },
  Event_125766_Name = {
    Text = "觀眾席的留影"
  },
  Event_125767_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125767_Desc = {
    Text = "你想要看看上面的內容，可幕布上什麼也沒有，放映廳裡只迴盪著膠片轉動的聲音。\n或許要很久之後，你才能有機會知曉膠片中的內容了。"
  },
  Event_125767_Name = {
    Text = "記憶影廳"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "【迴避目光】隨機覺醒1名喚醒體"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "【直視目光】選擇覺醒1名喚醒體，並降低其覺醒卡算力消耗2點。感染「(Skill.Arg1)」"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_125768_Desc = {
    Text = "踏上舞台的時候，你聽到一陣竊竊私語。你回過頭去，一萬名觀眾的眼睛浮在舞台的四周，凝望著你。\n來呀！它們說。精彩的戲劇，莫非就停在這裡？\n跳吧！它們說。為我們帶來這舞曲的高潮！"
  },
  Event_125768_Name = {Text = "觀眾"},
  Event_125769_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125769_Desc = {
    Text = "你不理解他的痛苦，也不需要理解。\n劇場有如此多的舞台，舞台上有如此多的木偶，你也不過是其中之一。\n你還有更重要的事情要做。"
  },
  Event_125769_Name = {
    Text = "演員的剖白"
  },
  Event_125770_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125770_Desc = {
    Text = "死亡，消散，流逝……藝術不是為了帶來痛苦而存在的。如果美只存在於痛苦，那這樣的美不要也罷。\n你奮力地驅趕著。蝴蝶散去，留下一具悲傷的屍體。"
  },
  Event_125770_Name = {
    Text = "於消散中綻放"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "【聆聽歌唱】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "【放任不管】獲得25黑印，離開"
  },
  Event_125771_Desc = {
    Text = "曾經與你相遇過的鴉群匯集成同一隻。牠站在你的身前對你歌唱，歌聲淒涼，如同最後的預言。"
  },
  Event_125771_Name = {
    Text = "最後的預言"
  },
  Event_125772_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125772_Desc = {
    Text = "你的手伸向左邊。\n那是你的過去，你最珍貴的回憶，你來時的路，你將要回歸的地方。\n過去的一切，構成了你的全部。"
  },
  Event_125772_Name = {
    Text = "過去，未來"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "【拍攝照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125773_Desc = {
    Text = "面對鏡頭你有些惶恐。或許這個姿勢拍出來會更好？或許那個？\n你仍在猶豫，可你看出來，相機已經很不耐煩了。"
  },
  Event_125773_Name = {
    Text = "觀眾席的留影"
  },
  Event_125774_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125774_Desc = {
    Text = "你擺好姿勢，站在相機面前。端正，好奇，投入，如同一位真正的觀眾。\n咕嘟——\n相機按下快門，黑色的粘漿從機身裡炸開，噴濺在整座舞台。\n相機的屍體中央，膠卷上空無一物。"
  },
  Event_125774_Name = {
    Text = "觀眾席的留影"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "【接受】獲得3選1白銀造物"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "【逃離】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_125775_Desc = {
    Text = "噠噠，噠噠……鞋跟與木板碰撞，發出愉悅的脆響。\n兩個穿著學生制服的木偶正在舞台上跳舞。忽然，他們停下了舞步，轉身向你伸出手來。"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "【忍受痛苦】提高 Arg1 點最大生命"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "【反駁痛苦】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染1張「(Skill.Arg2)」"
  },
  Event_125776_Desc = {
    Text = "「你從未在意過莉茲的死。你從未在意過任何人。」\n「你在意的只有自己……你身邊的所有人，都只是你通往自由與平靜的工具。」\n「不是嗎……守密人？」\n報幕人的竊語在你耳邊響起。你的心臟揪緊，收縮，強烈的痛苦隨著她的話語在你的身體裡蔓延……"
  },
  Event_125777_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125777_Desc = {
    Text = "放縱意識的下墜吧，海水自有浮力，命運將向你們指明一切的道路。"
  },
  Event_125777_Name = {Text = "寧靜"},
  Event_125778_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125778_Desc = {
    Text = "那是你自己。力量的來源，職責的擔負者，唯一忠誠的對象。\n你走在那條只屬於你的道路上。"
  },
  Event_125779_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125779_Desc = {
    Text = "「真是遺憾，我的客人。命運的味道，你再也沒有機會品嚐了……」"
  },
  Event_125779_Name = {
    Text = "命運的味道"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "【與她討論】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "【沉默不語】"
  },
  Event_125780_Desc = {
    Text = "「這真是一齣令人難過的戲劇……那可憐的女孩，是被自己所眷戀之人拋棄了嗎，姐姐？」\n在這道熟悉的聲音裡，你沒有聽到任何的瘋狂與仇恨。那道聲音清澈，哀傷，如同林地裡那道溫柔的溪流。\n「那位歌唱者，一片無力飄蕩的枯葉，只能任憑命運摧殘……多麼可憐的人啊……」\n「你說，如果我是那位執筆者……我應該為她書寫一個怎樣的結局呢？」"
  },
  Event_125780_Name = {
    Text = "劇作的結局"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "【撫摸】50%機率獲得125黑印，50%機率感染「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "【解釋】75%機率獲得100黑印，25%機率感染「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "【破解】獲得50黑印"
  },
  Event_125781_Desc = {
    Text = "你追向酒吧的後街時，怪物的身影消失不見，一群黑貓攔在你的身前。\n「 喂，你。」一隻黑貓舔了舔自己的爪子，向你望來。\n「 你來我們的地方做什麼？」"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "【擁抱過去】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125782_ChoiceDesc2 = {
    Text = "【迎接未來】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_125782_Desc = {
    Text = "涅芙蕾亞的出現干擾了絲線。紊亂的命運中，你看到兩道模糊的幻影。\n那是你的過去，那是你的未來。你走向它們，伸出了手……"
  },
  Event_125782_Name = {
    Text = "過去，未來"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "【感知】選擇1個造物變化為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "【凝視】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125855_ChoiceDesc3 = {
    Text = "【無視】獲得25黑印"
  },
  Event_125855_Desc = {
    Text = "卡薩利姆的街頭，一家水晶店耀目的光芒吸引了你。你來到店鋪前，拾起一塊銀芯形狀的水晶。"
  },
  Event_125856_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125856_Desc = {
    Text = "你閉上眼，仔細感知著它。\n一道微光在你的意識中閃爍，它想要告訴你些什麼……"
  },
  Event_125857_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125857_Desc = {
    Text = "任何對命運的反抗與窺探都是徒勞的。你靜靜閉上眼，任憑命運把你帶往你將去到的地方。"
  },
  Event_125857_Name = {
    Text = "縛命之網"
  },
  Event_125858_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125858_Desc = {
    Text = "「情感是存續的意義。但願你不會為自己的選擇後悔。」"
  },
  Event_125858_Name = {
    Text = "選擇的代價"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "【情感】回復 Arg1 點生命"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "【理智】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "【拒絕選擇】獲得25黑印"
  },
  Event_125859_Desc = {
    Text = "一座天平出現在舞台。\n「大腦與心臟，理智與情感，灰與紅……我們無法逃避選擇，這是我們的命運。」\n「舞台的終點已經劃定。現在，為這個舞台選擇它將走過的道路吧。」"
  },
  Event_125859_Name = {
    Text = "選擇的代價"
  },
  Event_125860_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125860_Desc = {
    Text = "「不要抬頭。離開這裡。」\n你聽見了命運的聲音。你無比渴望望向天空，但你知道，她是對的。"
  },
  Event_125861_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125861_Desc = {
    Text = "你永不接受命運。你永不接受囚禁。\n你奮力掙扎，在獻祭了一塊飛蛾的肢體後，你終於得以逃離……"
  },
  Event_125861_Name = {
    Text = "縛命之網"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "【友誼】獲得50黑印"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "【幫助】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_125862_Desc = {
    Text = "酒吧的後街，你再次遇到了那些黑貓。\n「我聽說了。那些黑色的黏液化成我們的樣子，給你添了不少麻煩。」\n「作為賠禮，告訴我吧，你想要什麼？」\n黑貓在你的腿邊繞了兩圈，抬頭望向你。"
  },
  Event_125862_Name = {
    Text = "初見贈禮"
  },
  Event_125863_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125863_Desc = {
    Text = "蠻力無法破解命運，但或許智慧可以？\n你仔細觀察著這張網，試圖從中窺視出一些命運的軌跡……"
  },
  Event_125863_Name = {
    Text = "縛命之網"
  },
  Event_125864_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125864_Desc = {
    Text = "你湊過去，仔細地凝視著它。\n一道微光在你的眼中閃爍，它想要告訴你些什麼……"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "【掙扎】從牌庫中隨機獲取3張指令卡，選擇1張卡進行刪除，獲得75黑印"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "【思考】從牌庫中隨機獲取3張指令卡，選擇1張卡的原始複製進入牌庫，獲得25黑印"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "【歇息】獲得50黑印"
  },
  Event_125865_Desc = {
    Text = "一股熟悉的感覺向你襲來，不同的是，那種黏膩的觸感、無力反抗的直覺，比上次更加強烈，更加致命。\n飛蛾墜入蛛網，而你也已踏入舞台。"
  },
  Event_125865_Name = {
    Text = "縛命之網"
  },
  Event_125866_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125866_Desc = {
    Text = "「理智是存續的手段。但願你不會為自己的選擇後悔。」"
  },
  Event_125866_Name = {
    Text = "選擇的代價"
  },
  Event_125867_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125867_Desc = {
    Text = "好奇心被點燃。你來到人群中，像他們一樣抬起頭來。\n那裡什麼都沒有，但不知道為什麼，你就是不願意將目光放下。你想就這樣望著，一直望著……"
  },
  Event_125868_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125868_Desc = {
    Text = "「放棄選擇也是一種選擇，這是命運的詛咒。但願你不會為自己的選擇後悔。」"
  },
  Event_125868_Name = {
    Text = "選擇的代價"
  },
  Event_125869_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125869_Desc = {
    Text = "「現在，你已經擁有它了。」\n黑貓蹭了蹭你的小腿，很快消失不見。\n在牠們消失之處，一份禮物在等待著你。"
  },
  Event_125869_Name = {
    Text = "初見贈禮"
  },
  Event_125870_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_125870_Desc = {
    Text = "「現在，你已經擁有它了。」\n黑貓蹭了蹭你的小腿，很快消失不見。\n在牠們消失之處，一份禮物在等待著你。"
  },
  Event_125870_Name = {
    Text = "初見贈禮"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "【抬頭】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125871_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_125871_Desc = {
    Text = "嘈雜的聲音短暫地消失了。街頭的人群陷入沉默，抬頭望向天空。"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129176_Name = {
    Text = "忘卻第1章@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "【指示方向】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129178_ChoiceDesc2 = {
    Text = "【一同禱告】獲得3選1刻印，重複 2 次"
  },
  Event_129178_Desc = {
    Text = "鋼琴和管風琴的聲音在灰暗的風中交織。彷彿有魔力的旋律飄蕩在無人的街巷。\n一位無名的修女在琴聲中禱告。\n「簡單的禱告無需隆重的典儀，偉大的父神會為我們播撒希望，正如他曾賜予我們虔誠的教導。」"
  },
  Event_129178_Name = {
    Text = "管風琴的禱告"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "【主動迎戰】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129180_ChoiceDesc2 = {
    Text = "【放棄抵抗】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "【趕緊開溜】獲得50黑印"
  },
  Event_129180_Desc = {
    Text = "幾個蠟像泥坯擋住了你的去路。\n它們歪歪扭扭，面容粗糲，望之不似羅傑斯應有的製作水準。\n「命令……大人的命令……」"
  },
  Event_129180_Name = {Text = "習作"},
  Event_129181_ChoiceDesc1 = {
    Text = "【放棄思考】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129181_ChoiceDesc2 = {
    Text = "【追上靈感】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129181_Desc = {
    Text = "港口遇襲，有來無回的神秘貨輪和有鰭的「新朋友」……這是精心籌備的陷阱嗎？還是又一場意外頻發的旅行？\n現實與理智互相拉扯糾纏，無數的靈感與念頭從腦海噴湧而出。"
  },
  Event_129181_Name = {
    Text = "靈感迸發"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "【加入】感染「(Skill.Arg1)」，重複 2 次，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」，重複 2 次"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "【驅趕】感染「(Skill.Arg1)」，重複 2 次，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」，重複 2 次"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "【漠視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129182_Desc = {
    Text = "你聽到遠處若隱若現的骨螺號角聲。\n鼠群循聲從黑泥中湧現，啃噬著乾枯河床上躺著的無名屍體。\n它們圍成一個圓，圓心是那具已然空洞的遺體，圓周則是一個以遺忘為法律的新王國。\n而你，正站在這個王國的入口。"
  },
  Event_129182_Name = {
    Text = "流放王國"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129183_Name = {
    Text = "忘卻第5章@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129184_Name = {
    Text = "忘卻第8章@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129185_Name = {
    Text = "忘卻第1章@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "【解救肖像】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "【接受空白】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129186_Desc = {
    Text = "你站在皮克曼的贈禮面前。\n那是一幅肖像畫，由鮮血繪就，漆黑的火焰安靜地燃燒著。\n透過畫中人空洞的眼眶，你看到——\n你的記憶正翻湧燃燒，拉長、扭曲、發光，彷彿某種無形之火正舔舐你腦中的回廊。恍惚間你聽見一道人聲。\n「該下鍋了，這火候正好。」\n這正是你自己繪出的記憶之景，你在火焰中掙扎變形。"
  },
  Event_129186_Name = {
    Text = "燃燒肖像"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "【您願意付出怎樣的代價呢？】隨機提升1張卡牌的刻印品質，重複 2 次"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "【請他們喝一杯過期的血腥瑪麗吧】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129187_Desc = {
    Text = "「歡迎光臨，我珍貴的客人。盡情挑選吧，這滿目琳琅皆為等候你而存在。」\n「額，打擾了，請問您是……達芙黛爾女士的孿生姐妹嗎？」\n「我即是達芙黛爾本人，請問客人您今日到此，有何貴幹……？」\n「抱歉抱歉，您比之前更有風韻了，我竟沒認出。您還記得嗎？二十年前，您替我的酒吧趕走了一個怪胎……昨天，噩夢重現了，它佔領了酒吧，帶著它的同胞們，成群結隊地……」"
  },
  Event_129187_Name = {
    Text = "回憶碎片·舊夢重現"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129189_Name = {
    Text = "忘卻第8章@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129190_Name = {
    Text = "忘卻第1章@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129191_Name = {
    Text = "忘卻第6章@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "【握緊火種】提高 Arg1 點最大生命"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "【直面內心】隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染2張「(Skill.Arg2)」，重複 2 次"
  },
  Event_129192_Desc = {
    Text = "在這場聲勢浩大的狩獵中，戈利亞的追逐如幽夜中的猛獸，企圖吞噬一切希望的光。然而，這無情的追逐並未將你凍結，反而點燃了內心深處的火種，它在胸膛裡蔓延、燃燒，變得越來越熾熱。"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129193_Name = {
    Text = "忘卻第6章@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "【閱讀前人的路】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129194_ChoiceDesc2 = {
    Text = "【書寫自己的路】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129194_ChoiceDesc3 = {
    Text = "【目視黑暗】獲得25黑印"
  },
  Event_129194_Desc = {
    Text = "如果你是一個人在密境中摸索前進，一定不會像現在這般篤定自己的前路。\n密境中的足跡分為了三條，印下的每道足印，都書寫著不可見的未來。"
  },
  Event_129195_ChoiceDesc1 = {
    Text = "【指出錯誤】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "【聽完彈奏】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_129195_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_129195_Desc = {
    Text = "男孩蠟像坐在鋼琴前彈奏練習曲。\n他的老師——同樣也是蠟像做的，正在一旁指導。\n133，355，244……\n錯了，每個音都錯了。"
  },
  Event_129195_Name = {Text = "鋼琴課"},
  Event_129196_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129196_Name = {
    Text = "忘卻第5章@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "【聆聽悲傷】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "【聆聽喜悅】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_129198_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印，重複 2 次"
  },
  Event_129198_Desc = {
    Text = "悠揚、抒情、歡欣、哀傷……曲調在密境空間迴蕩，難以辨別其來源。\n這是幽靈船音響流淌出的奏鳴曲，還是被束縛在密境中的夜半狂想？"
  },
  Event_129198_Name = {
    Text = "無名之音"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "【打開信封】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "【閱讀】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "【放回原處】獲得50黑印"
  },
  Event_129200_Desc = {
    Text = "無人關注的角落裡，遺落了一封信件。\n信件上的許多字跡已經無法辨認，但唯有一個詞。力透紙背。\n那個詞是「母親」。"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "【仔細聆聽】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "【捂住耳朵】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_129202_ChoiceDesc3 = {
    Text = "【查看】獲得3選1刻印，重複 2 次"
  },
  Event_129202_Desc = {
    Text = "你們進入遺骸所在的樓層時，空曠的廢棄工廠內突兀地傳來悅耳的叮咚之聲，鋼琴鳴奏的清泠之感與銹蝕的鋼鐵廢墟格格不入。"
  },
  Event_129202_Name = {
    Text = "詭異音階"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129203_Name = {
    Text = "忘卻第3章@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129204_Name = {
    Text = "忘卻第6章@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "【放過她】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129205_ChoiceDesc2 = {
    Text = "【幫助她】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "【我要走自己的路】獲得50黑印"
  },
  Event_129205_Desc = {
    Text = "三個人影攔住了你的去路。\n「你可以放過她，」雙手抱著沾滿融蝕漿的小熊玩偶的人影開口，「她只是膽怯，而不邪惡。她不想傷害任何人。」\n「你可以幫助她，」雙手捧著一把包裝精緻的糖果的人影開口，「你能夠做到她不能做到的事情，你能夠結束這一切。」\n「你不需要聽我們的，」雙手空空如也的人影開口，「你有你自己的路。」"
  },
  Event_129205_Name = {
    Text = "分岔的小徑"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "【餵食老鼠】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "【驅趕老鼠】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "【無視老鼠】獲得25黑印"
  },
  Event_129206_Desc = {
    Text = "這艘船上的一切，都在輪回。\n那些在船上討生活的，令人厭惡且長滿骯髒絨毛的小東西們自然也無法避免這樣的命運。\n一次又一次輪回中，它們吃所能看到的一切，卻仍無法滿足。\n「好……餓啊……」\n成群的老鼠們發出病態又刺耳的尖嘯。\n一次次輪回令它們饑餓難忍，它們必須吃些什麼。\n立刻，馬上！"
  },
  Event_129206_Name = {
    Text = "饑餓的鼠群"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129207_Name = {
    Text = "忘卻第8章@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "【觸摸大腦】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "【觸摸心臟】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_129208_Desc = {
    Text = "你走入那間無人低語的灰廳，一架天平在黑霧中若隱若現。\n左邊，是一枚沉靜如湖的大腦，銀白色的溝壑閃著微光；右邊，是一顆火紅色的、蒸騰著熱氣的心臟。\n忽然之間，你聞到一陣香氣，饑渴的欲望不斷膨脹，理智被祂無邊的黑暗擠壓。\n你伸出了手。"
  },
  Event_129208_Name = {
    Text = "饑餓遊戲"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129209_Name = {
    Text = "忘卻第4章@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "【斬殺人影】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "【碾碎胚胎】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "【閉上雙眼】獲得25黑印"
  },
  Event_129210_Desc = {
    Text = "恍惚中你看到曾在亞蘭見過的人們向你靠近。\n他們歡笑著邀請你飲酒、跳舞、品嘗美食。\n然後他們的血肉層層剝落、掉落在地又蠕動著長出新的胚胎。\n他們向你伸出手、邀請你加入血肉與新生的狂歡。"
  },
  Event_129210_Name = {
    Text = "舊日的陰影"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "【投餵他們】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "【不做理會】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129211_Desc = {
    Text = "居住者來來去去，鼠群卻長久綿延。\n和人類相比，它們才是這座古堡的「原住民」\n但它們對於人類的進駐沒有異議。\n因為那些香軟的、白嫩的醜東西，會投餵它們同樣香軟的、白嫩的醜東西。\n「而你，醜東西，屬於哪一種？」"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129212_Name = {
    Text = "忘卻第5章@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "【分辨男人的聲音】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_129213_ChoiceDesc2 = {
    Text = "【分辨女人的聲音】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "【分辨老人的聲音】獲得25黑印"
  },
  Event_129213_Desc = {
    Text = "你獨自站立在一片黑暗沼澤中。\n朦朧間你聽見混沌交錯的囈語如潮水般湧來，有的來自耄耋之年的老人，有的來自牙牙學語的孩子，有些來自焦慮難耐的女人，有些來自恐懼莫名的男人……"
  },
  Event_129213_Name = {
    Text = "遺言囈語"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "【仔細看看】獲得3選1刻印，重複 2 次"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "【撕下海報】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129214_Desc = {
    Text = "一個蠟像館內隨處可見的燭臺。\n借著病態的橙光，你發現牆壁上張貼著一則手繪的海報。"
  },
  Event_129214_Name = {
    Text = "黑暗中的笑聲"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129215_Name = {
    Text = "忘卻第4章@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129216_Name = {
    Text = "忘卻第7章@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "【凝視】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129217_ChoiceDesc2 = {
    Text = "【無視】獲得3選1刻印，重複 2 次"
  },
  Event_129217_Desc = {
    Text = "亞蘭人在沙暴中跪伏。\n風暴抽打著他們的軀殼，砂礫席捲他們的虔心。\n沙塵的漩渦之中，似乎有無數隻巨眼俯瞰著扭曲的大地。"
  },
  Event_129217_Name = {
    Text = "沙塵巨物"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "【驅趕蝴蝶】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "【聆聽心願】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129218_Desc = {
    Text = "小小的蝴蝶，也有許多夢想。\n這些夢想散落在花海裡、病房裡、還有充滿許多血肉的@2祭壇裡。\n而今，它終於等到了羈絆之人，不知你是否願意聆聽它小小的、小小的心願。"
  },
  Event_129218_Name = {
    Text = "蝴蝶的夢想"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "【跟隨指引】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "【無視指引】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129219_Desc = {
    Text = "祭典已經開始。\n在靈的焰火與血的祝禱下，數不清的信徒靈魂化作了航標——\n縹緲的靈分散在你的周圍，猶如引路的精靈，閃著光等待你的選擇。"
  },
  Event_129219_Name = {
    Text = "靈魂航標"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "【無視鈴聲】獲得3選1高級刻印，重複 2 次"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "【拿起聽筒】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129220_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_129220_Desc = {
    Text = "它本不該響起——那只電話，蜷縮在畫布背後。\n聽筒的線纏繞在大塊頭機身上，如同生銹的臍帶，似乎從你的腦中延伸。\n你仔細辨別震動的頻率，詭異的聲響猶如皮克曼的超現實藝術。"
  },
  Event_129220_Name = {
    Text = "未接來電"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "【我們一切平安】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "【你是誰？】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129221_Desc = {
    Text = "打字機突兀地噴出油墨，上面的驚歎號多得刺目。\n「朵爾你還好嗎？？？為什麼守密人消失了你也消失了！！！拜託平安的話回個消息！！！再等下去威廉的頭髮都要掉完了！！！」"
  },
  Event_129221_Name = {
    Text = "緊急通訊"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "【切斷紅綢】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "【對抗】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "【呼喚拉蒙娜】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129222_Desc = {
    Text = "卡茜亞甩出紅綢，瞬間纏住了你的手提箱。"
  },
  Event_129222_Name = {
    Text = "絞纏之綢"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129223_Name = {
    Text = "忘卻第6章@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129225_Name = {
    Text = "忘卻第3章@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129226_Name = {
    Text = "忘卻第4章@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "【揮手驅趕】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "【任由停留】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129227_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129227_Desc = {
    Text = "黑暗裡傳來了輕微的聲響。\n那是一隻蝴蝶禮貌地問詢。\n「我可以落在你的掌心嗎？」\n「我只是太累了，想要休息一下……」\n如此問詢著，蝴蝶穿越過黑暗，盤旋在你的面前。\n漆黑的粘液自它的翅膀滴落——那是蝴蝶穿越黑暗時，來自黑暗的饋贈。"
  },
  Event_129227_Name = {
    Text = "蝴蝶的請求"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129228_Name = {
    Text = "忘卻第7章@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129229_Name = {
    Text = "忘卻第7章@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129230_Name = {
    Text = "忘卻第1章@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "【辨認歌詞】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129231_ChoiceDesc2 = {
    Text = "【輕輕哼唱】獲得3選1刻印，重複 2 次"
  },
  Event_129231_Desc = {
    Text = "古老的船歌在密境中迴蕩。\n被密境困住的記憶用著你聞所未聞的語言，吟唱著海浪、天空與烈酒。"
  },
  Event_129231_Name = {
    Text = "海洋歌謠"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129232_Name = {
    Text = "忘卻第8章@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "【割開手掌】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "【接受生長】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129234_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129234_Desc = {
    Text = "那只蝴蝶並非飛來，而是從你的掌心慢慢生長。\n你一開始以為只是汗水，卻在指縫間看見黑色液體如血管反流般悄然滲出，凝結成冰冷而脈動的翅膀。\n每一次翕動，便在你的血液中激起漣漪。"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "【繼續翻閱】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "【離開】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_129235_Desc = {
    Text = "一架用於稱重的天平。\n在它的背後，無數器官浸泡在紅色的福爾馬林中。\n它們被整整齊齊地堆疊在儲物架上。\n你順手撿起一旁的筆記本翻閱：\n「心臟：8盎司，大腦：50盎司……」"
  },
  Event_129235_Name = {
    Text = "器官登記"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "【繞路而行】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_129236_ChoiceDesc2 = {
    Text = "【詢問為何沉沒】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "【向船員問好】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129236_Desc = {
    Text = "行走在前往動力室的路上，你再次遇見了一些被固定在密境中的「記憶」。\n他們不是幽魂，只是埃爾頓船長對逝去船員的牽掛。"
  },
  Event_129236_Name = {
    Text = "索納尼爾號的主人"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129237_Name = {
    Text = "忘卻第3章@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129239_Name = {
    Text = "忘卻第6章@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129240_Name = {
    Text = "忘卻第5章@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "【為他演奏】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "【聆聽琴聲】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_129242_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印，重複 2 次"
  },
  Event_129242_Desc = {
    Text = "「親愛的約翰：\n    最近我突然意識到，距離你上次為我們進行鋼琴演奏，已經過去了數年時間。\n    我今年81歲了，年齡越是增長，就越會意識到年輕時回憶的可貴。\n    若你收到這份信，就請你下次經過倫蒂尼恩時，在我的公寓前駐足，前來演奏一曲吧。」"
  },
  Event_129242_Name = {
    Text = "遺憾的奏鳴"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "【說自己沒有錢包】獲得3選1刻印，重複 2 次"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "【將網打破】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129244_Desc = {
    Text = "橙黃色的網在空中靜靜地漂浮，它孔洞稀疏，遠不如牆根上棲息了一隻蜘蛛的遠親來得精緻。\n你忍不住伸手觸碰，脆弱的網瞬間溶解，孩子們的歡笑在你耳邊響起。\n「金的銀的黃的紅的，所有錢包的都是我們的！」"
  },
  Event_129244_Name = {
    Text = "迷走網路"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "【選擇感性】回復 Arg1 點生命"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "【維持理性】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "【拒絕選擇】獲得25黑印"
  },
  Event_129245_Desc = {
    Text = "「選擇吧，選擇。」\n狂奔的黑暗中，傳來了無數的呢喃。\n這聲音溫柔催眠，似乎帶著無限的魔力，令你產生某種癲狂的幻覺。\n你的大腦陷入狂悖，蠕動著脫離身體，而心臟則似乎生髮了某種意識，向你驚叫著呼喚。\n「選擇吧，選擇。」\n「維持理性還是感性，你必須做出選擇。」"
  },
  Event_129245_Name = {
    Text = "人性的代價"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "【消滅祭品】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129246_ChoiceDesc2 = {
    Text = "【解開繩索】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "【繼續前進】獲得50黑印"
  },
  Event_129246_Desc = {
    Text = "三名亞蘭人被捆縛於高臺之上。\n他們的身上浮現出你在嬰孩身上曾見過的樹皮狀深色紋路，口中念念有詞。"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129248_Name = {
    Text = "忘卻第6章@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "【掙扎向前】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "【扯斷絲線】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "【隱忍不發】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129249_Desc = {
    Text = "一路上你被推著前進，你的所有選擇都被無形的絲線操縱著。\n你努力掙動雙手，想要抓住在意的一切。\n世界的命運懸掛在你指尖之前。\n無數絲線纏繞而來，束縛住你的全身。"
  },
  Event_129249_Name = {
    Text = "被操縱的雙手"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "【向他問路】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "【離開它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129250_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129250_Desc = {
    Text = "影子站在瘦長的路燈下。\n「方便借個火嗎，先生。」\n你沒有@2的習慣，但你不介意使用一點小小的「魔法」。\n在你的幫助下，影子將點燃的@2深入那看不見底的黑色漩渦裡。\n不一會，你便看見白色的煙霧蒸騰而出。\n「啊——」\n影子發出愉悅的歎息聲。"
  },
  Event_129250_Name = {
    Text = "路燈下的身影"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129251_Name = {
    Text = "忘卻第1章@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129252_Name = {
    Text = "忘卻第8章@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129253_Name = {
    Text = "忘卻第3章@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "【接受幻覺】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "【否認幻覺】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129254_Desc = {
    Text = "厚重黑暗的鐵架橋下，蘆葦叢生的寂靜河灘上，忽然飛出一隻閃光的蝴蝶。\n蝴蝶輕盈地落在你的掌心，糟糕的嚎叫聲停息了，取而代之的是火車碾過銹蝕鋼架的轟鳴聲，煤炭燃燒的劈啪聲，輪軸轉動的金屬摩擦聲……"
  },
  Event_129254_Name = {
    Text = "鐵路的幻覺"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "【選擇拒絕】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "【選擇遵從】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "【選擇擁抱】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129255_Desc = {
    Text = "「我是一隻籠中鳥，被關在充滿許多房間的院子裡。」\n黑暗中徘徊著模糊的人影，那是逝去者留下的執念。\n「他們說，那是瘋人院，可我卻知道，那是人類的特殊囚籠，關押著不願遵從社會規則的自由鳥。」\n「可是鳥兒如果不能飛翔，還能被稱為鳥嗎？」\n執念們向你靠攏，祈求著救贖。\n「請折斷我的翅膀，我已厭倦了飛翔。」"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129256_Name = {
    Text = "忘卻第2章@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "【放飛蝴蝶】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "【成為蝴蝶】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129258_ChoiceDesc3 = {
    Text = "【吞回肚子】獲得25黑印"
  },
  Event_129258_Desc = {
    Text = "這一夜發生了太多事。\n碼頭圍攻，幽靈貨輪，蹈海者，圖魯，墨菲，拉蒙娜……一切的一切都在漩渦中回轉，被攪成了彌薩格餐廳早上七點的燕麥粥。\n想要向眼前的喚醒體提問，卻根本不知道怎樣提起，如鯁在咽——或者說，胃裡的蝴蝶。"
  },
  Event_129258_Name = {
    Text = "蝴蝶效應"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129259_Name = {
    Text = "忘卻第8章@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "【任由停留】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "【揮手驅趕】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129260_ChoiceDesc3 = {
    Text = "【迎接蝴蝶】獲得25黑印"
  },
  Event_129260_Desc = {
    Text = "你們逡巡於寒風淩冽的療養院中，一隻這個季節不應存在的黑色蝴蝶翩躚而來。\n蝴蝶翕動的翅膀上拖著黑色的粘液，高低搖晃著飛過，翅膀上溢出的一層層黑漿，在凝固後被風化剝落。\n它飛累了，停在了你的指尖。"
  },
  Event_129260_Name = {
    Text = "不應存在之物"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "【重溫過去】獲得3選1高級刻印，重複 2 次"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "【窺視未來】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_129261_Desc = {
    Text = "世間沒有什麼能夠穩固不變。\n即便是神母塑造的樂園也是如此。\n在短暫的刹那，你從時空裂隙裡瞥到了一些東西。\n過去、現在、未來交織在那佈滿裂痕的罅隙裡，不停變化。\n等待你好奇的窺探。"
  },
  Event_129261_Name = {
    Text = "時空裂隙"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129262_Name = {
    Text = "忘卻第7章@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "【無視它】獲得3選1刻印，重複 2 次"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "【碰觸它】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129263_Desc = {
    Text = "類似孢子的奇怪東西引起了你的注意。\n它猶如血肉組成的纖細水母，又似大腦深處寄存著信號的神經纖維。\n「來碰觸我吧。」它無聲誘惑著你，「我會，向你展示一段殘酷的記憶。」"
  },
  Event_129263_Name = {
    Text = "深度記憶"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "【沉迷幻想】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "【保持理智】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "【強行離開】獲得3選1刻印，重複 2 次"
  },
  Event_129264_Desc = {
    Text = "或許是長期的戰鬥令你產生了恍惚，也或許只是你的大腦背叛了你的身體。\n某種失重感出現在你的腦海。\n一瞬間，你的腦海突然變成了萬花筒，絢爛，斑斕，閃動著五顏六色的光彩。\n數不清的靈感、迷思和狂想擠入大腦，佔據你大腦溝壑的每一個角落。\n再這樣下去，你的腦子很快就會被這些亂七八糟的東西撐爆。"
  },
  Event_129264_Name = {
    Text = "思維萬花筒"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129265_Name = {
    Text = "忘卻第5章@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129266_Name = {
    Text = "忘卻第4章@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "【聆聽】獲得3選1高級刻印，重複 2 次"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "【呼喊】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129267_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_129267_Desc = {
    Text = "自從意外發生後，你再也沒有收到搭檔的消息。\n無數聯絡發出，如同石沉大海毫無回音。\n在你已經不抱希望的時刻，聯絡器突然發出了聲響。\n你打開手提箱，將電話聽筒靠近耳朵。\n“守密人……”\n恍惚中你聽到了那個一直思念的聲音，像是隔著層層虛空遙遠地迴響。"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129268_Name = {
    Text = "忘卻第1章@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "【直視地獄犬來源】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129270_ChoiceDesc2 = {
    Text = "【專注戰鬥】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129270_Desc = {
    Text = "地獄犬的輪廓變化著。\n他的身軀連接著牆壁的罅隙，透露出詭麗的幻象。"
  },
  Event_129270_Name = {
    Text = "來自角度"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129271_Name = {
    Text = "忘卻第2章@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "【拼合紙張】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129272_ChoiceDesc2 = {
    Text = "【閱讀】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "【丟棄它】獲得50黑印"
  },
  Event_129272_Desc = {
    Text = "一頁泛黃的紙從提燈教眾的罩袍下脫落。\n紙上密密麻麻撰寫著古怪的文本，有些像是象形符號，有些怪異地上揚，有些字體甚至重疊在一起，只有少量文字勉強可以辨認。\n標題是《@2 聖子的誕生》"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129273_Name = {
    Text = "忘卻第2章@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "【準備戰鬥】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "【嘗試繞路】獲得25黑印"
  },
  Event_129275_Desc = {
    Text = "於星光垂落的深海里，蹈海者們蟄伏了千百年的歲月。\n無垠的海水見證了他們的瘋狂，見證了他們的忍耐，也見證了他們對神明最虔誠的信仰。\n沒有人可以阻擋神明的偉大降臨。\n任何礙事者，都會在蹈海者的怒火中化為灰燼。"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "【彈幾個音】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129276_ChoiceDesc2 = {
    Text = "【將蓋子蓋上】獲得3選1刻印，重複 2 次"
  },
  Event_129276_Desc = {
    Text = "牆邊的鋼琴敞著蓋子。它有著泛黃的琴鍵和露出木色的開裂的邊緣，但每一個琴鍵都被擦拭得非常乾淨。\n它是那麼多人的快樂源泉。"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "【接受幻覺】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "【否認幻覺】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129277_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_129277_Desc = {
    Text = "厚重黑暗的鐵架橋下，蘆葦叢生的寂靜河灘上，忽然飛出一隻閃光的蝴蝶。\n蝴蝶輕盈地落在你的掌心，糟糕的嚎叫聲停息了，取而代之的是搬運鋼筋的工人整齊的號子聲，釘頭錘的敲打聲，鉚釘碰撞的清脆金屬聲……"
  },
  Event_129277_Name = {
    Text = "鋼橋的幻覺"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "【展示詛咒】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，重複 2 次，感染「(Skill.Arg2)」，重複 2 次"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "【拒絕烏鴉】獲得3選1刻印，重複 2 次"
  },
  Event_129278_ChoiceDesc3 = {
    Text = "【無視】"
  },
  Event_129278_Desc = {
    Text = "漆黑而病態的多顱烏鴉自一名提燈教眾的黑袍中飛出，落在你的肩膀上。\n「看見我的頭了嗎？只要品嘗詛咒，我就會長出新的頭顱。讓我看看吧，你的詛咒！」"
  },
  Event_129278_Name = {
    Text = "詛咒怪鴉"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129279_Name = {
    Text = "忘卻第7章@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129280_Name = {
    Text = "忘卻第3章@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129281_Name = {
    Text = "忘卻第4章@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129282_Name = {
    Text = "忘卻第2章@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "【佔位】臨時文本。"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "【安葬】回復 Arg2 點生命[ExDesc1]，選擇 1 張指令卡刪除。"
  },
  Event_129900_ChoiceDesc2 = {
    Text = "【禱告】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129900_Desc = {
    Text = "一截蒼白的骸骨，半數浸沒於漆黑的融蝕漿中。"
  },
  Event_129900_Name = {
    Text = "褪色遺骨"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "【入座】將「提線木偶」置入牌庫。"
  },
  Event_130337_Desc = {
    Text = "當你的雙足踏上劇院的台階，目光便再無法從這座舞台移開。\n命運絲線牽引著長河沙數的故事在此流轉——過往的塵埃、此刻的光影、未來的迷霧，皆在台前翻湧不息。\n你遺忘了自己來自何方、想要去往何處，關於「自我」的印記在帷幕的陰影裡消融殆盡。此刻，你是座下靜默的觀者，也是台上燃燒的伶人。\n你存在的全部意義，坍縮成兩道刻痕：凝望，與獻演。"
  },
  Event_131264_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131264_Desc = {
    Text = "你們選擇了力量，選擇了堅定的信念與一往無前的勇氣。\n可，代價……代價存在的意義，就是用來承受的，不是嗎？"
  },
  Event_131264_Name = {
    Text = "舊日凝望"
  },
  Event_131265_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131265_Desc = {
    Text = "你忍受著腦海中的痛楚，用力攥緊那些飄散、破碎的記憶。在你艱難的忍耐下，那些裂隙開始縫補。\n你為銘記而離開，為銘記而戰鬥。你不會允許任何記憶離開自己。"
  },
  Event_131265_Name = {
    Text = "破碎記憶"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "【保護回憶】獲得3選1刻印"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "【阻止裂隙】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131266_Desc = {
    Text = "你從未質疑過自己的回憶。它們溫暖，堅固，是你最可靠的港灣與最珍視的珍寶。\n但現在，在淵獄的干擾之下，那些記憶開始出現紊亂的裂痕。"
  },
  Event_131266_Name = {
    Text = "破碎記憶"
  },
  Event_131267_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131267_Desc = {
    Text = "精神力量湧入腦海，修補那些可怖的縫隙。你用盡全力，終於讓那些裂隙歸於完好。\n你為銘記而離開，為銘記而戰鬥。你不會允許任何記憶離開自己。"
  },
  Event_131267_Name = {
    Text = "破碎記憶"
  },
  Event_131268_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131268_Desc = {
    Text = "「嗚嗚嗚嗚……哈哈哈哈！！」\n沒有人聽懂你的問詢，他們用哭喊與尖笑回應。"
  },
  Event_131268_Name = {
    Text = "被遺棄者"
  },
  Event_131269_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131269_Desc = {
    Text = "你們向它們回望。絲線撥動，溫柔的目光將回憶擁入懷中。\n你沉默地望著那位命運的操控者。如果再來一次，她會作何選擇呢？"
  },
  Event_131269_Name = {
    Text = "舊日凝望"
  },
  Event_131270_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_131270_Desc = {
    Text = "「嗚嗚嗚嗚……哈哈哈哈！！」\n哭喊與尖笑在你的身前逐漸消散。沒有魂靈前來傷害你——他們早已習慣了被無視。"
  },
  Event_131270_Name = {
    Text = "被遺棄者"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "【凝視回憶】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131271_ChoiceDesc2 = {
    Text = "【遺忘回憶】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_131271_Desc = {
    Text = "在女孩的身體裡，你聽見罐子破碎的聲音。回憶離開它們的容器，來到你們身邊。\n兒時的玩伴，父母的禮物，白雲與飛鳥最純真的想像，潔白如天空般的理想……所有的回憶睜開眼，靜靜地望向你們。\n它們詢問。它們哭泣。它們等待。"
  },
  Event_131271_Name = {
    Text = "舊日凝望"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "【詢問】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131272_ChoiceDesc2 = {
    Text = "【無視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131272_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_131272_Desc = {
    Text = "尖銳的哭嚎聲在你耳畔響起，痛苦的魂靈在你面前撕扯著自己的面孔與身軀……\n他們是誰？淵獄的囚徒？被遺棄的命運？被埋藏的回憶？"
  },
  Event_131272_Name = {
    Text = "被遺棄者"
  },
  Event_133380_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_133380_Desc = {
    Text = "你坐上了屬於你的天鵝絨座椅，鮮紅的幕布悄然拉開。\n親愛的觀眾，舞台將回應你的期待。\n這齣劇目的主演，已經站上了舞台。"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "【簡單嘗試】刪除至多 5 張任意卡牌"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "【由他研究】隨機刪除 5 張指令卡，獲得受祝福造物「(RelicConfig.Arg1)」。"
  },
  Event_141995_ChoiceDesc3 = {
    Text = "【反向思考？】選擇至多兩個喚醒體，生成一套他們的全套基礎卡牌置入牌庫"
  },
  Event_141995_Desc = {
    Text = "你來到一處廣場，不少人行色匆匆，或許可以在這裡找到些有趣的東西。\n你敲開了一間點著昏黃燈光的房門，一名研究員打扮的人從中探出頭。你看到許多不知名的科學器械，他拉著你坐下，聲稱自己是名「進化學家」。他滿臉狂熱，極力向你推薦他的「科學方法 」。\n「唯有刪去人類身上無趣的冗餘，才是真正的進化之路！」"
  },
  Event_141995_Name = {
    Text = "進化學家"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "【針對進攻進行特訓】為所有不帶有刻印的基礎打擊附加隨機刻印"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "【針對防守進行特訓】為所有不帶有刻印的基礎防禦附加隨機刻印"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "【不顧一切地特訓】為隨機 15 張指令卡附加隨機刻印，獲得 5 張隨機症狀卡"
  },
  Event_141996_Desc = {
    Text = "你來到一處廣場，不少人行色匆匆，或許可以在這裡找到些有趣的東西。\n金屬撞擊的脆響在空地上迴響，幾人正在這裡相互比試，提升武藝，一名身著舊式鎧甲的年輕人注意到你，將一把劍丟了過來，邀請你與他們一同鍛煉。"
  },
  Event_141996_Name = {
    Text = "特訓時間"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "【押大】50%機會獲得隨機刻印並重新下注，50%機會獲得 75 黑印"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "【押小】50%機會獲得隨機刻印並重新下注，50%機會獲得 75 黑印"
  },
  Event_141997_Desc = {
    Text = "服務生維持著不變的笑容，抬起骰盅，清脆的聲音迴響，其他玩家紛紛做出了自己的選擇。「買定離手。」他說，「請下注——」"
  },
  Event_141997_Name = {
    Text = "喧囂賭場"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "【老實下注】刪除一張指令卡"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "【試試出千】刪除一張症狀卡"
  },
  Event_141998_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_141998_Desc = {
    Text = "你來到一處極為熱鬧的地方，人人臉上洋溢著幸福，肆意閃爍光芒的彩燈將夜色擠得無處可去。而隨處可見的標牌上寫著：「歡迎來到嘉年華！這裡的夢境永無終結，這裡的歡愉永不落幕！」\n隨著擁擠的人流，你被推搡著闖入了一棟華麗的建築，廳內金碧輝煌，人聲鼎沸，空氣中瀰漫著甜膩的酒香。一枚骰子恰好咕嚕咕嚕地滾到你的腳邊，服務生掛著諂媚的笑，告訴你這是好運的象徵。懷揣著好奇心，你向前邁進一步，或許，可以在這場遊戲中大顯身手一番。"
  },
  Event_141998_Name = {
    Text = "喧囂賭場"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 個造物，50%機率獲得3選1黃金造物，50%機率獲得 25 黑印"
  },
  Event_141999_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_141999_Desc = {
    Text = "你來到一處極為熱鬧的地方，人人臉上洋溢著幸福，肆意閃爍光芒的彩燈將夜色擠得無處可去。而隨處可見的標牌上寫著：「歡迎來到嘉年華！這裡的夢境永無終結，這裡的歡愉永不落幕！」\n人群中，一名衣著襤褸，卻帶著大得驚人的包裹的商人朝你揮手，他拍了拍身旁的包，湊近並壓低聲音，向你提出了以物易物的邀請，那隻破舊的布包隨著他的說話聲輕輕晃動，還時不時發出咔咔的響聲。"
  },
  Event_141999_Name = {
    Text = "襤褸行商"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "【試著許願】消耗50%當前生命值，獲得 2 個隨機黃金造物"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "【全身心許願】消耗99%當前生命值，獲得時之靈擺「(RelicConfig.Arg2)」"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "【伸手摸索池底】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_142000_Desc = {
    Text = "風吹過郊野，四下一片寂靜，只有樹木的嘩嘩聲作響。\n忽然，你聽到何物汩汩流動的聲響，循聲走去，濃重的腥甜先一步撲來，你終於看清了那水流聲的源頭——是一座許願池，盛滿了赤色，無數人的血液正於池中湧動，彷彿在液面之下有什麼將要躍出。\n聲音貼著你的心底響起：「奉上你的血吧，我會賜你恩惠。」"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "【簡單地供奉】選擇刪除 2 個造物，獲得負罪造物「(RelicConfig.Arg1)」"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "【虔誠地供奉】選擇刪除 4 個造物，獲得受祝福造物「(RelicConfig.Arg1)」"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "【偷點貢品，沒人知道】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_142001_Desc = {
    Text = "風吹過郊野，四下一片寂靜，只有樹木的嘩嘩聲作響。\n不知不覺間，你來到一座古老的祭壇前，巨大的雕像居高臨下地凝視你，似乎想從你的手中拿走什麼。你看到祭壇的正下方刻著模糊的文字——「得失相稱」。"
  },
  Event_142001_Name = {
    Text = "得失祭壇"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "【免費體驗】隨機 Arg2 個白銀造物升級"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "【普通服務】消耗 Arg1 黑印：隨機 Arg2 個白銀造物升級"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "【豪華服務】消耗 Arg1 黑印：隨機 Arg2 個白銀造物升級"
  },
  Event_142002_Desc = {
    Text = "你來到一處廣場，不少人行色匆匆，或許可以在這裡找到些有趣的東西。\n點著溫暖燈光的小樓靜靜矗立在廣場一角，似乎是一家高級會館，但牆上掛著的深色牌匾卻赫然寫著「本店只為生物以外的存在服務。」"
  },
  Event_142002_Name = {
    Text = "特別會館"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "【抽一次】獲得一張症狀卡"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "【離開】獲得 75 黑印"
  },
  Event_142003_Desc = {
    Text = "你來到一處極為熱鬧的地方，人人臉上洋溢著幸福，肆意閃爍光芒的彩燈將夜色擠得無處可去。而隨處可見的標牌上寫著：「歡迎來到嘉年華！這裡的夢境永無終結，這裡的歡愉永不落幕！」\n你注意到路旁有一家抽獎攤，圍滿了人，所有人的目光聚焦在被遮得嚴嚴實實的大獎上——攤主極力宣揚它的珍稀，人們爭相參與其中。"
  },
  Event_142003_Name = {
    Text = "抽獎挑戰"
  },
  Event_142004_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_142004_Desc = {
    Text = "風吹過郊野，四下一片寂靜，只有樹木的嘩嘩聲作響。\n忽然，你看到一間破舊的草棚，正中央擺放著一個鐵砧，一旁還有許多生了鏽的金屬兵器，這裡似乎是一間荒廢許久的鐵匠鋪。鐵砧旁放著詳細的使用說明，告知你可以將造物放在這裡改造。"
  },
  Event_142004_Name = {Text = "鐵匠鋪"},
  Event_142005_ChoiceDesc1 = {
    Text = "【老實下注】刪除一張指令卡"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "【試試出千】刪除一張症狀卡"
  },
  Event_142005_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_142005_Desc = {
    Text = "旁人的喝彩宣告了你的勝利，嘈雜的人聲中，你終於也和他們一樣，沉醉於這場押上一切的光怪陸離的夢。你看向手中的籌碼，彷彿它們是為你帶來榮耀的最忠實的友伴，低語自賭桌深處傳來，裹挾著某種曖昧的請求：「再來一次吧，再贏一次吧。」"
  },
  Event_142005_Name = {
    Text = "喧囂賭場"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "【押大】50%機會獲得隨機白銀造物並重新下注，50%機會獲得 75 黑印並進入精英戰鬥"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "【押小】50%機會獲得隨機白銀造物並重新下注，50%機會獲得 75 黑印並進入精英戰鬥"
  },
  Event_142013_Desc = {
    Text = "服務生維持著不變的笑容，抬起骰盅，清脆的聲音迴響，其他玩家紛紛做出了自己的選擇。「買定離手。」他說，「請下注——」"
  },
  Event_142013_Name = {
    Text = "喧囂賭場"
  },
  Event_142073_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142073_Desc = {
    Text = "服務生掀起骰盅，短短幾秒，空氣彷彿都凝滯了。答案揭曉的頃刻，你聽到歡呼與哀嚎混在一起。幸運並未眷顧你，桌上靜靜躺著的幾枚骰子給出了與你相反的答案。你最後掃視了一圈，看了看那些瘋狂的賭徒。該走了。"
  },
  Event_142073_Name = {
    Text = "喧囂賭場"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "【進入戰鬥】"
  },
  Event_142074_Desc = {
    Text = "在你滿懷期待地緊盯賭桌時，你的手忽然被牢牢箍住，抬頭看去，賭場的老闆正俯視著，準備把一切不守規則的客人請出此地。霎時間，所有視線聚焦於你一人，驚詫的，充滿敵意的，幸災樂禍的......你意識到，一個人或許可以作弊很多次，但只要被發現一次，便要迎來徹底的身敗名裂了。"
  },
  Event_142074_Name = {
    Text = "喧囂賭場"
  },
  Event_142103_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142103_Desc = {
    Text = "你通過物理手段從賭場中成功脫身，人群的喧嘩聲被你拋在身後，你加快腳步離去——至於這一片狼藉，自會有人去收拾的。"
  },
  Event_142103_Name = {
    Text = "喧囂賭場"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "【再抽一次】獲得一張症狀卡"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "【離開】獲得 75 黑印"
  },
  Event_142105_Desc = {
    Text = "你試著抽了一次，無事發生。但卡片的背面寫著：「下一次更容易」\n......要再試一次嗎？"
  },
  Event_142105_Name = {
    Text = "抽獎挑戰"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "【再抽一次】獲得一張症狀卡"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "【離開】獲得 75 黑印"
  },
  Event_142106_Desc = {
    Text = "你試著抽了一次，無事發生。但卡片的背面寫著：「下一次更容易」\n......要再試一次嗎？"
  },
  Event_142106_Name = {
    Text = "抽獎挑戰"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "【再抽一次】獲得一張症狀卡"
  },
  Event_142107_Desc = {
    Text = "你試著抽了一次，無事發生。但卡片的背面寫著：「下一次更容易」\n......要再試一次嗎？"
  },
  Event_142107_Name = {
    Text = "抽獎挑戰"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "【再抽一次】獲得一張症狀卡"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "【離開】獲得 75 黑印"
  },
  Event_142108_Desc = {
    Text = "你試著抽了一次，無事發生。但卡片的背面寫著：「下一次更容易」\n......要再試一次嗎？"
  },
  Event_142108_Name = {
    Text = "抽獎挑戰"
  },
  Event_142109_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142109_Desc = {
    Text = "聽著心跳聲，你揭開了抽獎票，耀眼的金色文字跳進你的眼中。攤主興奮地搖動鈴鐺，所有路人都向你投來羨慕的目光。\n「大獎已被抽出！」"
  },
  Event_142109_Name = {
    Text = "抽獎挑戰"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "【再抽一次】獲得一張症狀卡"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "【離開】獲得 75 黑印"
  },
  Event_142110_Desc = {
    Text = "你試著抽了一次，無事發生。但卡片的背面寫著：「下一次更容易」\n......要再試一次嗎？"
  },
  Event_142110_Name = {
    Text = "抽獎挑戰"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 個造物，25%機率獲得3選1時之靈擺，50%機率獲得隨機 2 個黃金造物，25%機率獲得 25 黑印"
  },
  Event_142118_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_142118_Desc = {
    Text = "商人接過了你遞來的物品，對著月光翻來覆去地看，眼睛都快要瞪出來。你等了許久，他才裂開嘴角，從包裡掏出一個生鏽的鐵盒。「來拆拆看吧，這可是時下最流行的盲盒。」\n你打開了它，卻發現裡面只有些許不盡如人意的黑色印記。商人搓了搓手，滿眼歉疚地表示可以再試一次。"
  },
  Event_142118_Name = {
    Text = "襤褸行商"
  },
  Event_142119_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142119_Desc = {
    Text = "商人接過了你遞來的物品，對著月光翻來覆去地看，眼睛都快要瞪出來。你等了許久，他才裂開嘴角，從包裡掏出一個生鏽的鐵盒。「來拆拆看吧，這可是時下最流行的盲盒。」\n你打開了它，裡面躺著某樣東西。"
  },
  Event_142119_Name = {
    Text = "襤褸行商"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 個黃金造物，50%機率獲得3選1時之靈擺，50%機率獲得3選1受祝福造物"
  },
  Event_142120_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_142120_Desc = {
    Text = "你再次打開盲盒，卻發現仍沒有你想要的物品。商人趕忙賠笑，又翻出了一個鐵盒，雙手捧著遞到你面前。\n「別生氣，客人！我發誓，這次一定有頂天的好東西......」他嘴上這樣說著，卻悄悄挪出了一隻手，朝你攤開，「當然，寶物自然要用寶物來換。」"
  },
  Event_142120_Name = {
    Text = "襤褸行商"
  },
  Event_142138_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_142138_Desc = {
    Text = "你成功使用了這些工具，儘管有所損壞，但好像還能用。"
  },
  Event_142138_Name = {Text = "鐵匠鋪"},
  Event_142139_ChoiceDesc1 = {
    Text = "【碎鑄】選擇 1 個黃金造物刪除，獲得2個白銀造物，獲得 50 黑印"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "【淬煉】選擇 2 個造物刪除，獲得黃金造物「(RelicConfig.Arg1)」。"
  },
  Event_142139_ChoiceDesc3 = {
    Text = "【高階淬煉】選擇 2 個黃金造物刪除，獲得時之靈擺「(RelicConfig.Arg1)」。"
  },
  Event_142139_Desc = {
    Text = "你拿起一旁的錘子，打算......"
  },
  Event_142139_Name = {Text = "鐵匠鋪"},
  Event_142140_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_142140_Desc = {
    Text = "你成功使用了這些工具，儘管有所損壞，但好像還能用。"
  },
  Event_142140_Name = {Text = "鐵匠鋪"},
  Event_142141_ChoiceDesc1 = {
    Text = "【碎鑄】選擇 1 個黃金造物刪除，獲得2個白銀造物，獲得 50 黑印"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "【淬煉】選擇 2 個造物刪除，獲得黃金造物「(RelicConfig.Arg1)」。"
  },
  Event_142141_ChoiceDesc3 = {
    Text = "【高階淬煉】選擇 2 個黃金造物刪除，獲得時之靈擺「(RelicConfig.Arg1)」。"
  },
  Event_142141_Desc = {
    Text = "你拿起一旁的錘子，打算......"
  },
  Event_142141_Name = {Text = "鐵匠鋪"},
  Event_142142_ChoiceDesc1 = {
    Text = "【碎鑄】選擇 1 個黃金造物刪除，獲得2個白銀造物，獲得 50 黑印"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "【淬煉】選擇 2 個造物刪除，獲得黃金造物「(RelicConfig.Arg1)」。"
  },
  Event_142142_ChoiceDesc3 = {
    Text = "【高階淬煉】選擇 2 個黃金造物刪除，獲得時之靈擺「(RelicConfig.Arg1)」。"
  },
  Event_142142_Desc = {
    Text = "你拿起一旁的錘子，打算......"
  },
  Event_142142_Name = {Text = "鐵匠鋪"},
  Event_142167_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142167_Desc = {
    Text = "經過了三輪使用，鐵砧徹底凹陷下去，錘上也滿是磨損，看起來已經無法再用了。"
  },
  Event_142167_Name = {Text = "鐵匠鋪"},
  Event_142235_ChoiceDesc1 = {
    Text = "【我會堅定向前】獲得「純粹」：所有指令卡獲得20層永久強化"
  },
  Event_142235_ChoiceDesc2 = {
    Text = "【我不會逃避】獲得「昇華」：銀鑰上限、狂氣上限永久降低 20％"
  },
  Event_142235_Desc = {
    Text = "你的眼前忽然蒙上了一層霧，世界開始變得模糊不堪，恍惚間，一個聲音於你心底響起：\n「你還要前進嗎？」"
  },
  Event_142235_Name = {
    Text = "終站將近"
  },
  Event_142925_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142925_Desc = {
    Text = "會館的工作人員收下報酬，為你進行了基礎服務。他們將你交付出去的物品帶入一間漆黑的隔間，等待的時間不長，他重新出現時，東西已經放回了托盤上，似乎和原來的不太一樣了。"
  },
  Event_142925_Name = {
    Text = "特別會館"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "【刪除一個黃金造物】（需有黃金造物）"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "【有強化（Forged）造物可選】"
  },
  Event_142926_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_142926_Desc = {
    Text = "測試「造物數量」「選擇造物列表」"
  },
  Event_142927_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142927_Desc = {
    Text = "會館的工作人員收下報酬，為你進行了豪華服務。他們鄭重地將你的物品放入匣子，帶入一間漆黑的隔間。你等候了許久，直到他再度出現，將物品雙手奉上，神色一如既往地平靜。"
  },
  Event_142927_Name = {
    Text = "特別會館"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "【選最多2個喚醒體充滿狂氣】"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "【必須選擇2個喚醒體充滿狂氣】"
  },
  Event_142928_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_142928_Desc = {
    Text = "測試「條件選擇喚醒體」"
  },
  Event_142929_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142929_Desc = {
    Text = "研究員圍著你轉了一圈又一圈，細細打量了許久，才開始工作——他沒有徵詢你的意見。一段時間過去，當你準備離開這間奇怪的研究所時，你清楚自己的確失去了許多，但他卻拍著手祝賀你：「這就是進化的真諦！」"
  },
  Event_142929_Name = {
    Text = "進化學家"
  },
  Event_142930_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142930_Desc = {
    Text = "你伸出手，向一片猩紅的池水中探去，摸到了一些有用的東西。"
  },
  Event_142931_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142931_Desc = {
    Text = "聲音遠去，你心中充滿決心，感覺力量湧現。"
  },
  Event_142931_Name = {
    Text = "終站將近"
  },
  Event_142932_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142932_Desc = {
    Text = "聲音遠去，你心中充滿決心，頭腦更加清醒。"
  },
  Event_142932_Name = {
    Text = "終站將近"
  },
  Event_142933_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142933_Desc = {
    Text = "你在堆成小山的貢品堆裡隨便拿了一點，隨後便迅速溜走了，在你離開時，雕像的雙眼似乎動了一下。"
  },
  Event_142933_Name = {
    Text = "得失祭壇"
  },
  Event_142934_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142934_Desc = {
    Text = "你針對防守方向展開了訓練，面對對手的突襲，你不斷用武器抵禦，你的防禦能力和反應都有所提升。"
  },
  Event_142934_Name = {
    Text = "特訓時間"
  },
  Event_142935_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142935_Desc = {
    Text = "研究員帶上手套，從櫃子上拿了一些形狀古怪的器械，在你面前比劃了一番。你不知道他究竟做了什麼，但似乎的確覺得輕鬆了些。"
  },
  Event_142935_Name = {
    Text = "進化學家"
  },
  Event_142936_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142936_Desc = {
    Text = "你沒有選擇針對的方向，而是不顧自己身體極限地與人對練，直至所有人都筋疲力盡。你知道自己提高了不少，但同樣，你也付出了代價。"
  },
  Event_142936_Name = {
    Text = "特訓時間"
  },
  Event_142937_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142937_Desc = {
    Text = "你從包裡隨意拿了些東西供奉上去，得到了等價的賞賜。"
  },
  Event_142937_Name = {
    Text = "得失祭壇"
  },
  Event_142938_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142938_Desc = {
    Text = "你獻上了一些珍貴的貢品，得到了等價的賞賜。"
  },
  Event_142938_Name = {
    Text = "得失祭壇"
  },
  Event_142939_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142939_Desc = {
    Text = "你對他的研究方法充滿質疑，在一番爭論後，他同意讓你自己使用這些器械，選擇其他方式追求「進化」。\n同樣的道具，你卻在誤打誤撞中讓本該被「刪去」的事物大量「增殖」，在臨走前，你聽到了研究員的哀嚎。"
  },
  Event_142939_Name = {
    Text = "進化學家"
  },
  Event_142940_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142940_Desc = {
    Text = "會館的工作者為你進行了免費服務，他們將你交付出去的物品帶入一間漆黑的隔間，片刻後他折返，將東西放回你手中，一言不發。"
  },
  Event_142940_Name = {
    Text = "特別會館"
  },
  Event_142941_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142941_Desc = {
    Text = "你向許願池奉上了大量血液，珍貴的饋贈於池中浮現。"
  },
  Event_142942_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142942_Desc = {
    Text = "你針對進攻方向展開了訓練，在鋼鐵碰撞中，你的打擊技巧和速度都有所提升。"
  },
  Event_142942_Name = {
    Text = "特訓時間"
  },
  Event_142943_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_142943_Desc = {
    Text = "你向許願池奉上了少許血液，饋贈自池中浮現。"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "【選擇升級造物】"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "【隨機升級造物】"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "【離開（測試）】"
  },
  Event_142944_Desc = {
    Text = "測試「升級造物功能」，造物自己加"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "【呼喚他】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146258_ChoiceDesc2 = {
    Text = "【回應它們】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "【無視他們】獲得50黑印"
  },
  Event_146258_Desc = {
    Text = "祭壇之上，於麗埃特的白袍浸在濃重的煙霧裡，香灰混著某種腥甜的氣味。\n「持燈者垂憐世間罪子，」她的聲音不高，卻清晰地壓過了滿殿窸窣的祈禱，「如同慈母垂憐襁褓中的嬰孩。」\n祭台上的供品在燭火中泛著油光，一縷縷青煙順著它的輪廓扭曲上升，模糊了台下眾人的臉。\n卡斯托爾隔著那片搖晃的煙霧望向波呂克斯，他站在信眾之中，垂著眼，臉上是被訓練出來的、恰到好處的虔誠。"
  },
  Event_146258_Name = {Text = "故夢 Ⅲ"},
  Event_146259_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146259_Desc = {
    Text = "別在意，只是雪風的呼嘯，冰湖的嘆息，或群峰的哀悼。\n是已然枯朽的殘枝，彼此摩挲的絮語。\n它們永恆哀婉地呢喃，為曾經葬身於冰縫的每一名先驅者。"
  },
  Event_146259_Name = {
    Text = "冰湖的詠嘆"
  },
  Event_146260_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146260_Desc = {
    Text = "如果絕對平等是公平，那麼血鏈·希洛是否和你們平等享有許願的機會？\n那麼，對於被她捷足先登甚至驅趕競爭者的行動，你是否應該淡然處之？\n「或者別再胡思亂想了，趕緊繼續爬吧！」耳畔響起卡拉布的呼喚聲。"
  },
  Event_146260_Name = {
    Text = "荒誕的公平"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "【山恐懼飢餓】"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "【山恐懼失去】"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "【山恐懼死亡】"
  },
  Event_146261_Desc = {
    Text = "你行走於山的身軀。\n山的顫抖暴露了它的秘密。\n山的貪婪，決定了山的恐懼。"
  },
  Event_146262_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146262_Desc = {
    Text = "你享受著光滑柔軟的皮毛，你被囚禁在自己的慾望中。\n你很滿意它的手感。\n表象之下究竟是什麼，真的關鍵嗎？"
  },
  Event_146262_Name = {
    Text = "伏行之黑貓"
  },
  Event_146263_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146263_Desc = {
    Text = "你安靜地接過紅繩的尾端，把它繫在了你的手腕上。\n波呂克斯依法炮製，兩個孩子的手很快就被細細的紅繩牽在了一起。\n雖然同樣時間內的搜索面積變得更小了，不過你們注定要同生同死，不是嗎？\n剩下的，就交給命運來安排吧。"
  },
  Event_146263_Name = {Text = "故夢 Ⅰ"},
  Event_146264_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146264_Desc = {
    Text = "「我當然知道這很難，親愛的孩子。」\n「但世界對任何人而言都從未簡單過。」\n「總有一天，那隻蝴蝶會飛離你的掌心，然後永遠不見。」"
  },
  Event_146265_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146265_Desc = {
    Text = "威廉抬眼，目光快速掠過你，然後落在遠方堆滿積雪的山脊上。\n「你沒做任何需要道歉的事情，」他說得鄭重，「有些命題是屬於我自己的，也只能由我自己來解答。」\n「但感謝你的敏銳和洞察。」"
  },
  Event_146265_Name = {
    Text = "溫柔的沉沒"
  },
  Event_146266_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146266_Desc = {
    Text = "威廉的目光閃爍。\n你張了張口，但什麼也沒說。沉默是此刻最好的選擇。\n你們之間還存在著可貴的默契，不要破壞它。"
  },
  Event_146266_Name = {
    Text = "溫柔的沉沒"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_146267_Desc = {
    Text = "「還給我，還給我，那是我的力量！」\n山在哭叫，山在哀嚎。\n山無法承受，它曾擁有的一切被剝奪殆盡。"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "【繼續逃跑】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146268_ChoiceDesc2 = {
    Text = "【靜待時機】獲得3選1刻印"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "【緩慢離開】"
  },
  Event_146268_Desc = {
    Text = "「哥哥，小心點，有烏鴉在看。」\n少年的卡斯托爾背著波呂克斯疾行，眼神慌亂地掃過每一個可疑的角落，卻什麼也沒發現。\n「在上面。」\n你渾身一顫，抬頭望去。\n簷角的陰影裡，一隻烏鴉靜靜蹲踞著，朝向四面八方的怪眼紛紛盯緊了你。"
  },
  Event_146268_Name = {Text = "故夢 Ⅱ"},
  Event_146269_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146269_Desc = {
    Text = "你牢記訓練中的叮嚀，不能依賴安全繩。\n踢踏之下，你勉強穩住身形。\n但背包裡有什麼沿著山壁滾落，化作小得看不清的一點。\n不重要了，至少你還活著。"
  },
  Event_146269_Name = {
    Text = "無聲墜落"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "【側耳聆聽】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146270_ChoiceDesc2 = {
    Text = "【堵住耳朵】獲得3選1刻印"
  },
  Event_146270_Desc = {
    Text = "風雪撞在岩壁上，混著冰層深處傳來的若有若無的裂響，碎成一串斷續的嗚咽。\n你站在寂無一人的高處，忽然聽清了山的旋律。\n它蒼涼而莊嚴，低沉地吟唱一支只屬於亡者的曲子。"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "【是鈴聲】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "【是食物】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "【是狗的期待】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146271_Desc = {
    Text = "「巴甫洛夫搖動鈴鐺，然後給狗餵食。長此以往，只要搖動鈴鐺，狗就會分泌唾液。」\n「那麼，讓狗分泌唾液的，究竟是什麼？」"
  },
  Event_146272_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146272_Desc = {
    Text = "別去回憶。\n威廉就在你觸手可及的距離。\n別讓痛苦吞沒你。\n你錯過了很多，但還來得及。"
  },
  Event_146272_Name = {
    Text = "自彼岸來"
  },
  Event_146273_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146273_Desc = {
    Text = "「合攏手掌吧。」\n「曾經曼妙之物，在你的掌中只會剩下一團黑色的泥漿。」"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "【變回去】獲得50黑印"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "【撫摸】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_146274_Desc = {
    Text = "「喵。」一隻綠色瞳孔的黑貓踏著柔軟的貓步蹭上你的小腿。\n同時、「N」不見了。"
  },
  Event_146274_Name = {
    Text = "伏行之黑貓"
  },
  Event_146275_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146275_Desc = {
    Text = "你沒有出聲，只是任由那道目光穿過煙霧，落回波呂克斯的眼底，一寸也不肯挪開。\n他也沒有躲，弟弟總是這樣，寧願把倔強藏在最深處，也不肯先低頭。\n殿內的誦唱聲、香灰的氣味、於麗埃特關於慈悲與獻祭的言辭，忽然都變得遙遠起來，好像只剩下你們兩個人，隔著這滿殿虛偽的憐憫，隔著漫長的時光，相互凝望。"
  },
  Event_146275_Name = {Text = "故夢 Ⅲ"},
  Event_146276_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146276_Desc = {
    Text = "此刻，你是你蒼白而漫長的記憶的唯一衛兵。\n溫迪戈伸長枯槎般的手，指尖直逼你的心口，卻在最後一刻被你硬生生擋了回去。\n它踉蹌著退回霧中，只留下一句低啞的囈語——\n「你遲早會心甘情願地，把它們都交給我的……」"
  },
  Event_146276_Name = {Text = "貪食者"},
  Event_146277_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146277_Desc = {
    Text = "那是遙遠的夢，名為童年的夢。\n清醒一點。你不在那裡。\n你在風雪中，在層層提燈信徒的包圍下，而波呂克斯的刀尖正指向你的胸膛。"
  },
  Event_146277_Name = {Text = "故夢 Ⅰ"},
  Event_146278_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146278_Desc = {
    Text = "「我接納死亡的發生。」\n「我甘願葬身於苦旅。」\n「絕壁之下，天地為我鑄碑。」"
  },
  Event_146278_Name = {
    Text = "死兆將至"
  },
  Event_146279_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146279_Desc = {
    Text = "倒影不過是光的反射現象。\n汀克特看見的，多半也只是她自己的影子。\n她的母星遠在千萬光年之外，最微小的航路偏差也會使她們墜落在不同的星系。\n如此自我安慰著，你不再執著於腳下的倒影。"
  },
  Event_146280_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146280_Desc = {
    Text = "來自群星。來自太古。來自人類的尚且未知，或許永恆無知。\n別向祂索求答案。\n你不知曉代價。"
  },
  Event_146280_Name = {
    Text = "冰湖的詠嘆"
  },
  Event_146281_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146281_Desc = {
    Text = "你停下腳步，任由那陣蒼涼的樂音灌滿耳畔。\n風聲是提琴，雪粒是鼓點，遠處冰層崩裂的轟鳴，是某種壓抑已久的、低沉的和聲。\n你聽不出它的主題，但你知曉，它過往或未來，都將為無數葬身此地的旅人反覆奏響。"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "【仰望天光】所有喚醒體回覆Arg1狂氣"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "【腳踏冰峰】選擇覺醒2名喚醒體"
  },
  Event_146283_Desc = {
    Text = "峰頂在雲霧中沉默地閃光。\n山谷、岩壁、風暴，盤踞此處之物從來不是為了人而存在。\n身處其中，你是如此脆弱。"
  },
  Event_146283_Name = {
    Text = "觸及巔峰"
  },
  Event_146284_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146284_Desc = {
    Text = "「不，不是你的錯。」\n「你只是被上了發條的，命運的玩具罷了。」"
  },
  Event_146284_Name = {
    Text = "貪吃的老鼠"
  },
  Event_146285_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146285_Desc = {
    Text = "「聽出來了，你是擅長總結客觀經驗的那類人。但別忘記，有時候，相似的表象下，其實潛藏著不同的可能性。」鈴聲笑著遠去了。"
  },
  Event_146286_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146286_Desc = {
    Text = "如果善惡有報是公平，那麼誰來裁定善惡？\n由阿努比斯那個天平嗎？\n如果冥界的重力符合物理學原理，你不是很有信心自己的心臟會比那根羽毛更輕。"
  },
  Event_146286_Name = {
    Text = "荒誕的公平"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "【追問】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146287_ChoiceDesc2 = {
    Text = "【沉默】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146287_ChoiceDesc3 = {
    Text = "【道歉】獲得25黑印"
  },
  Event_146287_Desc = {
    Text = "「威廉學長，所有人都受到溫迪戈蠱惑的時候，你好像第一個醒過來了。接下來就要正面迎戰溫迪戈群了，有什麼秘訣可以傳授嗎？」\n威廉眸色微動，從他的眼神中你隱約窺見不可捉摸的恍惚，悲傷和寧靜。\n像是浸泡在透著光的海水之中，飄飄搖搖地向著晦暗的海底墜去。\n「抱歉，恐怕我沒什麼能幫上的。」"
  },
  Event_146287_Name = {
    Text = "溫柔的沉沒"
  },
  Event_146288_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146288_Desc = {
    Text = "「不通人性，不通人性啊。」黑色的身影搖著頭出現了，「真相可能是刺骨的毒藥。有時候，接受幻象更能維繫當下的幸福，不是嗎？」"
  },
  Event_146288_Name = {
    Text = "伏行之黑貓"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "【誰是兇手】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "【是我的錯】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "【貪吃的代價】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146290_Desc = {
    Text = "「小老鼠，爬呀爬。下水道，黑又長。忽然嗅到奶酪香。」\n「小老鼠，拖奶酪，往家跑。腦袋嗡嗡響，腦袋嗡嗡響。」\n「推開門，推開門，家裡靜無聲。」\n「兄弟姐妹躺地上，肚子都有一個洞，一個洞。」"
  },
  Event_146290_Name = {
    Text = "貪吃的老鼠"
  },
  Event_146291_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146291_Desc = {
    Text = "你蹲下身，替她抹去臉頰上的淚痕，沒有去問那滴淚的真假。\n「不管是真是假，」你說，「用不著還要證明給誰看。」\n卡拉布張了張口，那句準備好的、用來敷衍的俏皮話終究沒能說出來。\n她的眼淚毫無預兆地決堤，砸落在你的手背上。"
  },
  Event_146291_Name = {
    Text = "鱷魚的眼淚"
  },
  Event_146292_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146292_Desc = {
    Text = "「不要問比較好哦。有些問題不需要知道答案。」"
  },
  Event_146292_Name = {
    Text = "貪吃的老鼠"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "【出聲提醒】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146293_ChoiceDesc2 = {
    Text = "【繼續聆聽】所有喚醒體回覆50狂氣，感染「(Skill.Arg1)」"
  },
  Event_146293_ChoiceDesc3 = {
    Text = "【聳肩無視】獲得3選1刻印"
  },
  Event_146293_Desc = {
    Text = "納拉卡墜落之地只有黑暗。\n泥濘之中傳來潮濕的旋律，如同一雙冰冷蒼白的手，纏綿地撫過你的面頰。\n它輕聲低唱，「來吧，在夜的寂靜中到我這來。」"
  },
  Event_146293_Name = {
    Text = "留戀之聲"
  },
  Event_146294_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146294_Desc = {
    Text = "你低下頭，任由那片煙霧模糊了波呂克斯的輪廓，連同他此刻的表情，一併藏進了灰白的霧氣裡。\n這樣最安全——你告訴自己，不必去看，不必去想。\n於麗埃特的宣講仍在耳邊流淌，你死死盯著自己交疊的雙手，一言不發。\n直到儀式的鐘聲敲響，你才敢重新抬眼。\n而波呂克斯始終保持著他虔誠的姿態。\n隔著漫長的時光與幻想，你不清楚是否有什麼東西在那個剎那溜走了。"
  },
  Event_146294_Name = {Text = "故夢 Ⅲ"},
  Event_146295_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146295_Desc = {
    Text = "「波呂克斯——」你的聲音剛衝出喉咽，就被自己死死嚥了回去，只餘下氣音般的一點殘響，散在香煙裡。\n身側信徒誦經的聲浪不曾停頓，卻有幾道目光不易察覺地掃了過來。\n波呂克斯猛地一僵，眼底閃過一絲惶恐，隨即又迅速被那副訓練出來的恭順神情蓋住。\n他沒有回應，只是垂著眼，指尖卻在袖中悄悄蜷緊——你知道，他聽見了。"
  },
  Event_146295_Name = {Text = "故夢 Ⅲ"},
  Event_146297_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146297_Desc = {
    Text = "至少在那個時刻，你做不到眼睜睜地看著她一個人被驅離隊伍。\n當下需要解決的問題，就交給當下的自己吧。"
  },
  Event_146297_Name = {Text = "計中計"},
  Event_146298_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146298_Desc = {
    Text = "「波呂克斯，我們最好向不同的方向走。這樣，我們就會有更大的幾率找到森林的邊界。」\n「那你要怎麼找到我呢，哥哥？」\n隔著朦朧的時光，你望見他失落的神情。痛楚的感覺絞住了你的心臟。你深吸一口氣，緩緩吐出。\n「我們是雙子。我們能閱讀彼此的心跳。」\n「我們永不分離。」"
  },
  Event_146298_Name = {Text = "故夢 Ⅰ"},
  Event_146299_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146299_Desc = {
    Text = "它在審判，它在質問。它賜予所有無還的挑戰者冰冷的死亡。"
  },
  Event_146299_Name = {
    Text = "雪線的審判"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "【重新開始】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146300_ChoiceDesc2 = {
    Text = "【這很艱難】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146300_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_146300_Desc = {
    Text = "蠕蟲教會她謊言。\n除此之外，她從未學過如何生存。\n但謊言終究只是謊言，從某一天開始，你必須在沒有它支撐的情況下活下去。"
  },
  Event_146301_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146301_Desc = {
    Text = "「是啊，可是那麼小的老鼠，怎麼會知道貪吃的代價是什麼呢？」"
  },
  Event_146301_Name = {
    Text = "貪吃的老鼠"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "【繫上紅繩】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "【拒絕紅繩】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_146302_ChoiceDesc3 = {
    Text = "【回到現實】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146302_Desc = {
    Text = "第一場夢。在森林裡的夢。兩個不足十歲的孩子，被教主拋在幽深的森林中。\n「入夜後，那些沉睡的野獸就要開始獵食了。在那之前逃出去吧。逃出去的，才是我的好孩子噢。」\n弟弟拉住他的手，掏出一截紅繩。\n「哥哥，把手繫在一起吧。這樣，我們就不會走散了。」"
  },
  Event_146302_Name = {Text = "故夢 Ⅰ"},
  Event_146304_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146304_Desc = {
    Text = "你聽見了嬉笑聲。\n喜悅的，挑釁的，飽含趣味的。\n人類傾盡全力對宇宙的探索，在祂們的眼中不過螞蟻的攀行。"
  },
  Event_146306_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146306_Desc = {
    Text = "它將淨化。它將消融。它將所有無還的攀登者納入其中。"
  },
  Event_146306_Name = {
    Text = "雪線的審判"
  },
  Event_146307_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146307_Desc = {
    Text = "你和烏鴉陷入了僵持。\n顯而易見的是，在這場對峙中，你無法成為最後的贏家。\n在與於麗埃特的對抗中，你們彷彿永遠不會是。"
  },
  Event_146307_Name = {Text = "故夢 Ⅱ"},
  Event_146308_ChoiceDesc1 = {
    Text = "【誰在看我？】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_146308_ChoiceDesc2 = {
    Text = "【專注眼下】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146308_Desc = {
    Text = "裹挾著冰雪的風呼嘯過人類足跡的至高之地。\n你仰頭而望，更高處只有亙古不熄的太陽。\n但你知道，在更高更遠的某處，還有無數雙眼睛，或張，或合。\n其中幾雙，正靜靜地俯瞰著你腳下的整個世界。"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "【我仍懷不捨】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146309_ChoiceDesc2 = {
    Text = "【我已然忘卻】隨機1張卡牌獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146309_Desc = {
    Text = "你試著封閉大腦中存儲「記憶」的模組。\n那座秘密的匣子中藏匿著構成你全部的答案，你所有羞於啟齒的念頭，你所有不願示人的遐思。\n可慾望是潛意識的魔咒，你無法抵抗的痴迷幻夢。"
  },
  Event_146309_Name = {
    Text = "潛意識魔咒"
  },
  Event_146310_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146310_Desc = {
    Text = "威廉避開了你的目光。\n「意識是對抗蠱惑的武裝。而每個人的人生經歷決定了他的意識，無法替代，也無法傳授。」\n「我能告訴你的只有，不要放任自己被軟弱吞沒。」"
  },
  Event_146310_Name = {
    Text = "溫柔的沉沒"
  },
  Event_146311_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146311_Desc = {
    Text = "「聽出來了，你是想當哲學家的那類人。但別忘記，沒有期待，不等於沒有痛苦。」鈴聲笑著遠去了。"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_146312_Desc = {
    Text = "「餓啊，餓啊。」\n山在哭叫，山在哀嚎。\n山無法承受，它的腹內空空。"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "【踢踏岩壁】刪除1張指令卡，並回覆 Arg1 點生命"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "【抓住安全繩】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146313_Desc = {
    Text = "五光十色的幻覺在你的腦海中翻攪。\n最初是鬆動的粉雪。\n然後是坍塌的雪簷。\n你無法阻止自己滑落，安全繩在繩扣的摩擦下激起刺目的火花。\n但在群山面前，它是那麼渺小而脆弱。"
  },
  Event_146313_Name = {
    Text = "無聲墜落"
  },
  Event_146314_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146314_Desc = {
    Text = "「在夢中到我這來吧，讓我能夠重新活過我的生命。」\n留聲機發出一聲嗚咽，然後呼吸聲逐漸在黑暗裡淡去。\n只餘回聲。只有回聲。"
  },
  Event_146314_Name = {
    Text = "留戀之聲"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "【心生悔意】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_146315_ChoiceDesc2 = {
    Text = "【都是命運的安排】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146315_Desc = {
    Text = "你一直都知道這趟旅程並不如想像中簡單，這支登山隊中的攀登者多半各懷鬼胎。\n但你望著卡拉布漸入瘋狂的狂妄笑臉時，仍有一絲玻璃碎裂的聲音在你胸口炸開。\n或許當納拉卡要將她逐出隊伍的時候，你應該做出另一個選擇。"
  },
  Event_146315_Name = {Text = "計中計"},
  Event_146316_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146316_Desc = {
    Text = "有多少人曾被吞噬於此？\n黏稠的深潭伸出黑色的手，試圖將你拖入他們的世界。\n而你只是前行，它們似乎也無意挽留，一一退去了。\n前面還有頂峰在等你。"
  },
  Event_146316_Name = {
    Text = "留戀之聲"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "【放棄】獲得25黑印"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "【俯身查看】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146317_Desc = {
    Text = "循著汀克特的目光，你忍不住凝視湖底。\n那倒影中究竟有什麼在吸引著她？\n但你看不清，冰面上影影綽綽地只倒映出你自己的影子。"
  },
  Event_146318_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146318_Desc = {
    Text = "抵抗吞噬的方式唯有捨棄。\n任何人都無法失去自己不曾擁有之物。\n溫迪戈齜著牙，喉間發出不甘的低吼，一步步退回霧裡。"
  },
  Event_146318_Name = {
    Text = "潛意識魔咒"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "【雪將淨化我】隨機提升1張卡牌的刻印品質"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "【雪將審判我】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146319_Desc = {
    Text = "眼前是最後的攀援，雪線冰冷而綿延。\n積雪白得晃眼，連死亡在這裡都顯得乾淨。"
  },
  Event_146319_Name = {
    Text = "雪線的審判"
  },
  Event_146320_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146320_Desc = {
    Text = "別遺漏那畫面中的任何細節。\n把它們烙進腦海裡。\n把那個瞬間湧現的茫然、空洞和隨之湧現的痛苦也烙印下來。\n永遠也別忘記。"
  },
  Event_146320_Name = {
    Text = "自彼岸來"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "【共同作戰】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_146321_ChoiceDesc2 = {
    Text = "【安撫】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146321_Desc = {
    Text = "山峰猛烈震顫，像一頭瀕死的活物。\n環節狀的蒼白血肉從龜裂的岩層下洶湧鑽出，一節又一節地拔高、絞纏，將卡拉布狠狠摔下。\n再次出現在你們面前的時候，她的臉頰上已經掛了一行眼淚。\n那是痛苦的淚痕嗎？\n你不確定。\n無數謊言曾由她的口中說出，誰還會相信鱷魚的眼淚？"
  },
  Event_146321_Name = {
    Text = "鱷魚的眼淚"
  },
  Event_146322_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146322_Desc = {
    Text = "你沒有去追問答案，只是站到了她身側。\n「起來吧，」你說，「戲演到一半，別半途退場。」\n卡拉布怔了一下，隨即用力抹了把臉。\n她跌跌撞撞地爬起來，重新握緊了武器，肩並肩地迎向那再度合攏的血盆巨口。\n謊言說了太多，連她自己都快分不清哪滴眼淚的真假了。\n但至少這一次，沒有人計算真假。"
  },
  Event_146322_Name = {
    Text = "鱷魚的眼淚"
  },
  Event_146323_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146323_Desc = {
    Text = "「聽出來了，你是擅長破除表象的那類人。但別忘記，在那一刻的現實裡，食物只存在你的經驗和幻想中。」鈴聲笑著遠去了。"
  },
  Event_146324_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146324_Desc = {
    Text = "你放輕放慢了腳步。\n輕輕地、慢慢的、悄無聲息地……\n你就這麼繞過下一個轉角溜走了。\n那隻烏鴉究竟有沒有追上來呢？\n你早已不記得了。"
  },
  Event_146324_Name = {Text = "故夢 Ⅱ"},
  Event_146325_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146325_Desc = {
    Text = "旋律戛然而止。\n黑色的泥淖中睜開一雙渴盼的眼睛。\n那雙眼睛濕漉漉地望著你，低聲細語著你難以辨別的內容。\n然後緩緩、緩緩地合上了。"
  },
  Event_146325_Name = {
    Text = "留戀之聲"
  },
  Event_146326_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146326_Desc = {
    Text = "你沒有多停留，將那陣旋律甩在身後，腳步踩碎積雪，發出比風聲更急促的聲響。\n可即便你走得再快，那蒼涼的樂音仍固執地跟在你身後，一步不落。\n你無法逃離——它是這片雪山本身的呼吸，而你，只是恰好途經的渺小聽眾。"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "【那就聆聽吧】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146327_ChoiceDesc2 = {
    Text = "【不必在意】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "【強行離開】獲得3選1刻印"
  },
  Event_146327_Desc = {
    Text = "風中夾雜著悠遠的歌聲。\n歌聲像是從四面八方，或是自地底而來。\n無論你向哪個方向追尋，它都以同樣的烈度在耳邊回響。"
  },
  Event_146327_Name = {
    Text = "冰湖的詠嘆"
  },
  Event_146328_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146328_Desc = {
    Text = "「死兆之星啊，此刻並非你閃耀之時。」\n「我的旅程仍存未抵之終點。」\n「請你暫且熄滅，令今夜的天空重歸安寧。」"
  },
  Event_146328_Name = {
    Text = "死兆將至"
  },
  Event_146329_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146329_Desc = {
    Text = "無用的悔意翻湧而上。\n人總是不得已要為過往的自己收拾爛攤子。"
  },
  Event_146329_Name = {Text = "計中計"},
  Event_146330_ChoiceDesc1 = {
    Text = "【咀嚼】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "【拒絕】獲得3選1刻印"
  },
  Event_146330_Desc = {
    Text = "雪霧深處伏著一具瘦骨如柴的軀體，肋骨支起乾裂的皮囊，頭頂兩支枯槎般的枝角刺破霧氣。\n它的腹中傳來空洞的咕鳴。\n你與它對視的剎那，那雙深陷的眼窩裡翻湧起破碎的畫面——那是你的記憶。它已經嚐到了滋味。\n「還不夠，還不夠啊……」它嘶啞地呻吟，朝你伸出乾枯的手，姿態竟帶著幾分祈求。"
  },
  Event_146330_Name = {Text = "貪食者"},
  Event_146332_ChoiceDesc1 = {
    Text = "【天葬】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_146332_ChoiceDesc2 = {
    Text = "【驅趕】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_146332_Desc = {
    Text = "鬍兀鷲借著上升氣流在高空盤旋，巡視領地。\n在攀登者中，這向來是個壞兆頭。\n「它們在覓食。兀鷲能嗅到死亡將近的氣息。」"
  },
  Event_146332_Name = {
    Text = "死兆將至"
  },
  Event_146333_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146333_Desc = {
    Text = "信任自己的雙腿。\n你將征服巔峰。"
  },
  Event_146333_Name = {
    Text = "觸及巔峰"
  },
  Event_146334_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146334_Desc = {
    Text = "不捨的念頭躥上腦海的瞬間，你意識到自己已經無力抵抗，只能任由它長驅直入你那塵封已久的記憶寶庫。\n森白的犬齒探入你的太陽穴，一幀一幀的畫面被連根拔起。"
  },
  Event_146334_Name = {
    Text = "潛意識魔咒"
  },
  Event_146335_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146335_Desc = {
    Text = "它俯身向你，鼻尖幾乎觸到你的額頭，它的深情陶醉，像是嗅著一塊蜜糖。\n那些翻湧不安的情緒被舔食得乾乾淨淨。\n它心滿意足地哼鳴著退開，眼底翻湧起妖冶的光。\n你的心口空了一塊，卻又詭異地……輕鬆了不少。"
  },
  Event_146335_Name = {Text = "貪食者"},
  Event_146336_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146336_Desc = {
    Text = "「注意腳下，每一步都踩紮實了，」納拉卡的聲音在你耳畔響起，「別總指望別人幫你兜底。」"
  },
  Event_146337_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146337_Desc = {
    Text = "人類應該觸碰天空。\n目標能讓人忘記危險。\n開闊的天地正在頭頂等你。"
  },
  Event_146337_Name = {
    Text = "觸及巔峰"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "【驅散回憶】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146338_ChoiceDesc2 = {
    Text = "【捕捉幻想】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_146338_ChoiceDesc3 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_146338_Desc = {
    Text = "殺死威廉的兇手，此刻就在你的眼前。\n亞蘭的帳篷內，令人作嘔的空氣中，威廉慘白的面龐，漂浮的身體，還有桌上解剖的那枚小提燈，再次浮現在你的腦海。"
  },
  Event_146338_Name = {
    Text = "自彼岸來"
  },
  Event_146339_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146339_Desc = {
    Text = "安全繩應聲而斷。\n你重重摔進雪堆裡，五臟六腑都在鈍痛中發出致命的警報。\n頂著目眩睜開眼，一具無名的屍骨與你面面相觑。\n在他空洞的瞳孔中，有什麼正閃閃發光。"
  },
  Event_146339_Name = {
    Text = "無聲墜落"
  },
  Event_146340_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146340_Desc = {
    Text = "躲不過了。\n你咬咬牙，然後騰身疾馳，妄圖憑藉速度甩掉監視者。\n烏鴉怪叫一聲，撲了撲翅膀，游刃有餘地跟在你們上空，甚至輕鬆地盤繞了一圈。\n冰冷的絕望順著它的目光滲進身體。\n你們逃不掉的。"
  },
  Event_146340_Name = {Text = "故夢 Ⅱ"},
  Event_146341_ChoiceDesc1 = {
    Text = "【善惡有報】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146341_ChoiceDesc2 = {
    Text = "【絕對平等】提升 Arg1 點最大生命值，感染「(Skill.Arg2)」"
  },
  Event_146341_Desc = {
    Text = "你吊懸在崖壁上，腦海裡卻突然浮起一個無關的問題：何謂公平？"
  },
  Event_146341_Name = {
    Text = "荒誕的公平"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_146342_Desc = {
    Text = "「我還不能死去！」\n山在哭叫，山在哀嚎。\n山無法承受，它因貪婪而失去了明天的可能。"
  },
  Event_146343_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_146343_Desc = {
    Text = "你俯下身去，直至面頰與冰面相接。\n徹骨的寒冷從皮膚滲入骨髓，你忍不住打了個哆嗦。\n難以辯明的存在在封凍的冰層下緩慢翻滾，是水流或是某種生物？\n無論是哪一者，都與你的旅程無關。"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "【領受賜福】戰鬥開始後，生成 1 張隨機「萬化之果」置入牌庫。"
  },
  Event_148532_Desc = {
    Text = "茫茫雪原一望無際，寒風捲不起半點聲響，一道說不清來處的幻影悄然浮現，遞來一枚溫熱的果實。\n甜香混著霧氣，撲進旅人凍得發麻的鼻腔。 \n這片雪域早已被死亡浸透，空氣裡飄著腐敗與冰寒的反胃氣味，唯有掌心這顆果實飽滿欲滴，宛如少女誘人的許諾。"
  },
  Event_148532_Name = {
    Text = "上現蜃景"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "【交給她吧】所有喚醒體回復Arg1狂氣"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "【需要支援】選擇覺醒2名喚醒體"
  },
  Event_20778_Desc = {
    Text = "「這裡是來自彌薩格的通訊，監測到喚醒體的異常諾斯指數波動，請問是否需要支援？」"
  },
  Event_20778_Name = {
    Text = "支援通訊"
  },
  Event_20779_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_20779_Desc = {
    Text = "「已為您提供緊急援助，請於查收後敲擊三次胸針確認。」"
  },
  Event_20779_Name = {
    Text = "支援通訊"
  },
  Event_20780_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_20780_Desc = {
    Text = "來自遙遠未來的幻影，隱沒在艾爾沃斯的山隘。"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "【遠望幻影】所有喚醒體回復Arg1狂氣"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "【靠近幻影】選擇覺醒2名喚醒體"
  },
  Event_20781_Desc = {
    Text = "遠方似有火山錐噴發，狂風肆虐的天空中升騰起人形的煙霧。\n這可是艾爾沃斯，艾爾沃斯只有連綿不絕的高聳雪山和石灰石岩層的溶洞。\n是連日的異狀讓你精神錯亂了嗎？"
  },
  Event_20782_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_20782_Desc = {
    Text = "幻影向你招了招手，然後消失了。留給你的只有寒冷的冰雪和巍峨的山脈。"
  },
  Event_20783_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_20783_Desc = {
    Text = "「收到，我們將進行基礎資源輸送，請注意查收。」"
  },
  Event_20783_Name = {
    Text = "支援通訊"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_21398_Desc = {
    Text = "機械被拆解，真相被揭露。\n鼎沸人生消弭於無形之中，留給你真相大白的滿足。"
  },
  Event_21398_Name = {
    Text = "目擊證言"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "【檢查膠捲】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，還可以使用一次"
  },
  Event_21399_Desc = {
    Text = "好奇驅使著你，將視線探向了顯影池。\n那些圖像浸泡在殷紅藥水中，而那渾身有著漆黑污漬的罪人，赫然有著與你相同的臉龐。"
  },
  Event_21399_Name = {
    Text = "目擊證言"
  },
  Event_21400_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_21400_Desc = {
    Text = "機械被拆解，真相被揭露。\n鼎沸人生消弭於無形之中，留給你真相大白的滿足。"
  },
  Event_21400_Name = {
    Text = "目擊證言"
  },
  Event_21811_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_21811_Desc = {
    Text = "“二十五年……是的，她讓我沉睡了二十五年。”\n少女陰沉、低落地回應著你。\n只一覺醒來，那些從小照顧她的僕從，就伴隨年歲的增長變成了徹頭徹尾的蹈海者。\n不再有人理解她的苦悶，不再有人關心她的疼痛，讓她在教團孤身一人。\n她寧願沉睡前的那一天，就是「星辰正位之時」。"
  },
  Event_21811_Name = {
    Text = "被禁錮的生命"
  },
  Event_22058_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22058_Desc = {
    Text = "「不，我並不餓。」\n你禮貌推拒了這場盛宴的熱烈邀請。\n攫取靈魂的代價，你從不願為此抵押。"
  },
  Event_22058_Name = {
    Text = "肌體盛宴"
  },
  Event_22059_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22059_Desc = {
    Text = "你胡亂啃咬著淌血的司康，用胡椒醃制的心臟與麵糰烘烤的香氣混雜，你嗅到了熟悉的味道。\n「獲取力量，需要付出代價。」\n你飲下最後一口鮮血。"
  },
  Event_22059_Name = {
    Text = "肌體盛宴"
  },
  Event_22060_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22060_Desc = {
    Text = "你將白湯和碎肉囫圇咽下，用衣袖擦盡了唇角的留痕。\n肉質嫩滑，湯底鮮香，至於它曾屬於誰？\n不過是你所遺失之物的冰山一角。"
  },
  Event_22060_Name = {
    Text = "肌體盛宴"
  },
  Event_22061_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22061_Desc = {
    Text = "你細細查看著風鈴上鐫刻的古老刻印。\n它們以常人無法想像的程度扭曲著，似乎並不打算被人理解。\n不被理解，便不被打擾。"
  },
  Event_22061_Name = {
    Text = "銹蝕風鈴"
  },
  Event_22062_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22062_Desc = {
    Text = "「不錯，你很謹慎。」\n風鈴中忽然傳來遙遠的聲音。\n「謹慎會為你帶來一點小獎勵，但也僅此而已了。」"
  },
  Event_22062_Name = {
    Text = "銹蝕風鈴"
  },
  Event_22063_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22063_Desc = {
    Text = "你撫摸著風鈴上鐫刻的古老刻印。\n它們以常人無法想像的程度扭曲著，似乎並不打算被人理解。\n不被理解，便不被打擾。"
  },
  Event_22063_Name = {
    Text = "銹蝕風鈴"
  },
  Event_22064_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22064_Desc = {
    Text = "「啊，真是遺憾……那我只有繼續我孤單的獨奏了。」 你不知道琴與手是什麼時候消失的，但溪水般的琴聲永遠留在了你心中。"
  },
  Event_22064_Name = {
    Text = "琴邊幽靈"
  },
  Event_22065_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22065_Desc = {
    Text = "「啊，能有這樣一位朋友，真是榮幸！」 那雙手興奮起來，你完全無法跟上它的速度。直到演奏結束很久，那振奮人心的聲音仍然讓你心潮澎湃。"
  },
  Event_22065_Name = {
    Text = "琴邊幽靈"
  },
  Event_22175_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22175_Desc = {
    Text = "乩板自信滿滿地滑動著，你的視線也隨之來回梭巡。\n然而，祂不過剛指出兩個字母，就在淒慘的尖叫中化為了粘稠的黑色漿液。"
  },
  Event_22175_Name = {Text = "通靈板"},
  Event_22176_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22176_Desc = {
    Text = "「數學！數學！！」\n女聲咬牙切齒，乩板飛速在數字之間滑動，發出刺耳的木質摩擦聲。\n「帶著你的數學滾出我的視線！」"
  },
  Event_22176_Name = {Text = "通靈板"},
  Event_22177_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22177_Desc = {
    Text = "「等等，等等！！」\n「問我啊！你為什麼不問！」"
  },
  Event_22177_Name = {Text = "通靈板"},
  Event_22178_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22178_Desc = {
    Text = "它從未同此時此刻般躍動，但相對的，內心的孔洞正在被撕裂……"
  },
  Event_22178_Name = {
    Text = "詛咒渴望"
  },
  Event_22179_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22179_Desc = {
    Text = "魂與靈充盈著你的肺部，在寂靜中，你不斷上浮。\n世界的聲音逐一響起，奏鳴著生命的交響。"
  },
  Event_22180_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22180_Desc = {
    Text = "一切照常發生，毀滅如約而至，未燃盡的殘渣裡掩埋著珍貴之物，沉沒在陰影中熠熠生輝。"
  },
  Event_22180_Name = {
    Text = "針端之外"
  },
  Event_22181_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22181_Desc = {
    Text = "相遇，離開，擦肩而過。"
  },
  Event_22182_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22182_Desc = {
    Text = "心動漸緩，但也許「良心」已得到了少許慰藉……"
  },
  Event_22182_Name = {
    Text = "詛咒渴望"
  },
  Event_22183_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22183_Desc = {
    Text = "你閉上眼，享受這難得的虛無與自由時刻。漸漸地，你感到世界從寂靜裡孵化而出，生命在寂靜中無聲綻放。"
  },
  Event_22184_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22184_Desc = {
    Text = "你攔住指針，銀片閃爍著割開柔軟的手心，毀滅尚未降臨，你腳下的影子卻被濃墨般的夜色生吞。"
  },
  Event_22184_Name = {
    Text = "針端之外"
  },
  Event_22185_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22185_Desc = {
    Text = "「你逃不掉，沒有人能抵抗內在的邪惡」\n惡念撕扯著神經，試圖將你拉進深淵。但疼痛只讓你的神智感到前所未有的清朗。\n惡念無法擁有你，你只會是你自己。"
  },
  Event_22185_Name = {
    Text = "無妄之念"
  },
  Event_22186_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22186_Desc = {
    Text = "「為什麼不呢？」\n只要擁抱了那些可怖的念頭，所有難題都將迎刃而解，世界上將不再存在名為「倫理」的悖論。"
  },
  Event_22186_Name = {
    Text = "無妄之念"
  },
  Event_22187_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22187_Desc = {
    Text = "銀色光幕在眼前閃過，一整沉悶的風帶走了所有聲音。"
  },
  Event_22187_Name = {
    Text = "無妄之念"
  },
  Event_22188_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22188_Desc = {
    Text = "善變，淒冷，若即若離。"
  },
  Event_22189_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22189_Desc = {
    Text = "膨脹，收縮，一觸即發。"
  },
  Event_22190_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22190_Desc = {
    Text = "雖然稍顯魯莽，可為什麼不呢？\n打破一切壁壘，衝向終點。\n就算將思維的湖泊攪出驚天巨浪，就算成為逐日的伊卡洛斯，可你至少達成了目的，不是麼？"
  },
  Event_22190_Name = {
    Text = "思維迷宮"
  },
  Event_22191_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22191_Desc = {
    Text = "你的大腦是一所迷宮，而你是它的阿里阿德涅。\n這個宇宙中，沒人比你更懂如何走出迷宮。\n沒有人。"
  },
  Event_22191_Name = {
    Text = "思維迷宮"
  },
  Event_22192_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22192_Desc = {
    Text = "在正確的調律下，不協和的音程柔和了些許。\n但或許，你還有什麼能做到的。"
  },
  Event_22192_Name = {
    Text = "不協和音"
  },
  Event_22193_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22193_Desc = {
    Text = "你是音樂大師，也是普通的音癡。\n音符在你的思維控制下各司其職，流動的生命終於在密境中奏響。"
  },
  Event_22193_Name = {
    Text = "不協和音"
  },
  Event_22194_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22194_Desc = {
    Text = "你的聲音湮沒在寂靜裡。寂靜的聲音越來越大，越來越響，直到徹底破碎，留下一地殘骸。"
  },
  Event_22195_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22195_Desc = {
    Text = "你並不會輕易上當，乾脆俐落地轉身，離開了這裡。"
  },
  Event_22293_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22293_Desc = {
    Text = "提筆瞬間，信紙在密境中燃燒，煙灰簌簌落在手中，\n回過神來時，有什麼東西隨著信紙一同消散了。"
  },
  Event_22293_Name = {
    Text = "單向傾訴"
  },
  Event_22294_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22294_Desc = {
    Text = "信紙消散在密境中的瞬間，你聽見了溫和而虛弱的關心。\n「在這種境況下能想起我，是我身為老師的榮幸。\n不過，我上次行走於密境中，已經是太久太久前的事情。如今的我，只能幫到你這些……」"
  },
  Event_22294_Name = {
    Text = "單向傾訴"
  },
  Event_22295_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22295_Desc = {
    Text = "信紙消散在密境中的瞬間，你聽見了急切的驚呼。\n「守密人，如果有任何不舒服的地方，請一定要讓我知道。\n作為搭檔，我會不留餘力幫助你。」"
  },
  Event_22295_Name = {
    Text = "單向傾訴"
  },
  Event_22296_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22296_Desc = {
    Text = "信紙消散在密境中的瞬間，你聽見了一聲冷淡的歎息。\n「如果你在考試不合格時，也能這麼積極尋求幫助就好了。」"
  },
  Event_22296_Name = {
    Text = "單向傾訴"
  },
  Event_22397_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22397_Desc = {
    Text = "你的出現讓影子們面面相覷，一束星光從鞋尖拂過後，那人群陡然消散，只在你的手中留下了最凝實的影子。"
  },
  Event_22397_Name = {
    Text = "星月之約"
  },
  Event_22398_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_22398_Desc = {
    Text = "嘈雜的私語戛然而止，漆黑如墨的影子接連轉向你，凝視你。從那無五官的臉上，你竟讀出了幾分譏諷之意……"
  },
  Event_22398_Name = {
    Text = "星月之約"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "【冷靜觀察】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_22399_ChoiceDesc2 = {
    Text = "【出聲問詢】獲得25黑印"
  },
  Event_22399_Desc = {
    Text = "在星與月的交織中，竊竊私語不絕於耳。\n「就是這個人嗎？@4之人……」\n「人類之身，終究還是@3…」"
  },
  Event_22399_Name = {
    Text = "星月之約"
  },
  Event_22411_Desc = {
    Text = "廉價但好用的陷阱！"
  },
  Event_22411_Name = {
    Text = "製作陷阱"
  },
  Event_24254_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24254_Desc = {
    Text = "靈知的風暴環繞在圖魯周身，你與他對視一眼，前後腳深入黑暗。"
  },
  Event_24254_Name = {
    Text = "自海中而來"
  },
  Event_24255_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24255_Desc = {
    Text = "靈知的風暴環繞在圖魯周身，而那長久不散的悲傷與內疚，則在空間中蔓延開來。"
  },
  Event_24255_Name = {
    Text = "直面深淵"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "【握住觸肢】接受圖魯的幫助"
  },
  Event_24256_Desc = {
    Text = "他的威儀如巨物墜海般，激蕩著眼前的密境。\n那力量古樸、久遠、足以超越萬古。\n值得慶倖的是，你不會與他為敵，至少當下不會。"
  },
  Event_24256_Name = {
    Text = "自海中而來"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "【握住觸肢】與圖魯同行"
  },
  Event_24257_Desc = {
    Text = "圖魯深呼吸一口氣，遠遠看著彌利亞姆。\n彷彿在懷念歷史、懷念故人、懷念自己的生命……\n他臉上的複雜神色停留了不過須臾時間，他就從彌利亞姆臉上移開了目光。\n「走吧，離開她。」"
  },
  Event_24257_Name = {
    Text = "直面深淵"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "【關上艙門】"
  },
  Event_24277_Desc = {
    Text = "拉蒙娜拉住了自門外闖入的學生。\n那無畏而堅強的守密人，明明除了渾身狼狽不堪外並無異樣，身影在她鏡片下的碧藍眼中竟顯得影影綽綽。\n直到拉住手的瞬間，拉蒙娜才得以確認：你們得到了重逢。"
  },
  Event_24277_Name = {
    Text = "喜悅的重逢"
  },
  Event_24278_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24278_Desc = {
    Text = "拉蒙娜沒給你留解釋的機會，她將你拉進了昏暗的艙室，小心翼翼闔上了艙門……"
  },
  Event_24278_Name = {
    Text = "喜悅的重逢"
  },
  Event_24540_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24540_Desc = {
    Text = "「她是你堅實的護盾，是你手中的利劍。\n她是你的夥伴，你的搭檔，你信賴的朋友——不論她變成什麼樣。」"
  },
  Event_24541_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24541_Desc = {
    Text = "「是你……不，這不可能，這個輪回的你已經……我也已經……」\n聲音隨著身影消散，只有悲傷仍在水霧中徘徊。"
  },
  Event_24542_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24542_Desc = {
    Text = "「為了世界，為了人類，為了我們所珍視的一切。\n當然，還有最重要的——她是為了你。」"
  },
  Event_24543_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_24543_Desc = {
    Text = "你還未靠近人影便注意到了你，祂身形一頓，像是震驚，又像是驟然陷入了巨大的悲哀。\n還未等你說些什麼，祂便與霧氣一同消散了。"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "【她是誰？】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "【她為什麼變成這樣？】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24544_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_24544_Desc = {
    Text = "又一道迷霧，又一道身影。與先前不同，這次你將對方看得一清二楚。\n與你一模一樣的身形，與你一模一樣的制服，與你一模一樣的面容。\n「你知道你為什麼在這裡，」那個人說，「正如你知道她為什麼變成那副模樣。」"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "【出聲安慰】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24545_ChoiceDesc2 = {
    Text = "【試圖靠近】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24545_ChoiceDesc3 = {
    Text = "【轉身離開】獲得25黑印"
  },
  Event_24545_Desc = {
    Text = "迷霧籠罩了你前行的道路。\n一個身影在朦朧的光影中浮現，你眯起眼睛，卻怎麼也看不清祂的面容，只能聽到斷斷續續的低語。\n「為什麼……為什麼無法救下……命運，真的無法改變嗎……」"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "【求助合夥人】獲得3選1高級刻印"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "【進行片場統籌】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "【引導現象級狂熱】獲得造物「(RelicConfig.Arg1)」"
  },
  Event_35039_Desc = {
    Text = "“《霍迪妮大師的片場指南》中明確指出，卡茜亞，也就是本人，作為製片人兼導演，有對整部影片負責的義務和權力。因此卡茜亞勇敢的員工啊，請選擇你接下來的行動排期吧！”\n“排、排期？等等，我什麼時候變成了你的員工？！”\n“機不可失時不再來，別再猶豫！”"
  },
  Event_35039_Name = {
    Text = "製片人的迷思"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "【接通】回復 Arg2 點生命[ExDesc1][ExDesc2]。"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_35103_ChoiceDesc3 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_35103_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_35103_Name = {Text = "聯絡點"},
  Event_35103_Tips3 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_35165_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35165_Desc = {
    Text = "猶豫之間，你主動發出了對神秘資助人的通訊請求。\n“事已至此，騎虎難下。還請勳爵慷慨解囊……”\n銀芯通訊器對面傳來了格外豪爽的笑聲，對方最終笑著應承下了你的請求。\n“對了，還有……這件事請務必對拉蒙娜保密。”"
  },
  Event_35165_Name = {
    Text = "製片人的迷思"
  },
  Event_35236_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35236_Desc = {
    Text = "片場統籌是做什麼的？你掏出了卡茜亞不知何時塞進靈知轉印器中的一沓文件，仔細看了起來。\n然後，你開始頭痛。\n片場佈置過程中蘿坦造成的損耗、奧瑞塔和布朗吃掉的零嘴、卡茜亞購置魔法小球的報銷申請……一筆筆結算款項擺在你面前，你不得不痛苦地蹲在地上進行演算。\n話說回來，卡茜亞的魔法小球是什麼？"
  },
  Event_35236_Name = {
    Text = "製片人的迷思"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "【驅散幻象】感染症狀[ExDesc1][ExDesc2]。"
  },
  Event_35259_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_35259_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_35497_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35497_Desc = {
    Text = "現象級狂熱的背後需要推手，而一談到「推手」，一個綠色短髮的少女身影就躍入了腦海。\n“彌薩格大學第一掮客，漢娜·皮斯利竭誠為您服務！”\n“如果是守密人的首次服務需求，只需要付出3頓食堂咖喱套餐的報酬哦！”"
  },
  Event_35497_Name = {
    Text = "製片人的迷思"
  },
  Event_35887_Desc = {
    Text = "你掀起了船帆，那下面竟一無所有。回過神時，那船帆也已消失不見。\n純白之帆和少女若隱若現的面龐，變成了一個訊息，提醒你不論前路如何，你都不是孤單一人。"
  },
  Event_35887_Name = {
    Text = "純白之帆"
  },
  Event_35888_Desc = {
    Text = "這裡沒有風，卻有一艘潔白無瑕的帆船，它的帆蓬勃地升起，挺立在幽靜的湛藍海面上。\n你隱約看到了一個少女的面容，她的五官模糊不清，就像是通過一層薄霧或是一片流動的水面。她的存在似乎與周圍的一切隔絕，卻又是這一幕的核心。\n儘管她的形象不斷地在波動中變得清晰或模糊，但毫無疑問，你知道她是誰。"
  },
  Event_35888_Name = {
    Text = "純白之帆"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "【向下墜落】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_35894_Desc = {
    Text = "少女的聲音在空氣中彌散開，如泡影般模糊悠遠。"
  },
  Event_35894_Name = {
    Text = "死生邊緣"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "【周而復始】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_35895_Desc = {
    Text = "肢體分外沉重，霧霾緊鎖著羸弱的身軀。"
  },
  Event_35895_Name = {
    Text = "死生邊緣"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "【閱讀前人的路】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35896_ChoiceDesc2 = {
    Text = "【書寫自己的路】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35896_ChoiceDesc3 = {
    Text = "【目視黑暗】獲得25黑印"
  },
  Event_35896_Desc = {
    Text = "如果你是一個人在密境中摸索前進，一定不會像現在這般篤定自己的前路。\n密境中的足跡分為了三條，印下的每道足印，都書寫著不可見的未來。"
  },
  Event_35897_ChoiceDesc1 = {
    Text = "【攙扶她】"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "【看著她】"
  },
  Event_35897_Desc = {
    Text = "她呢喃著，跌轉著停在了你的面前。\n不知何人驚擾了她的安眠，她的意識被現實束縛，靈魂卻停留在了失落的國度中。"
  },
  Event_35898_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35898_Desc = {
    Text = "在這片混沌未辨的黑暗中，一連串模糊的腳印伸展開去，像是夜行者在無形的沙漠上留下的深邃足跡。"
  },
  Event_35899_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35899_Desc = {
    Text = "眼裡映出了一座遠方的燈塔，她孤獨地矗立在黑暗的邊緣，發出微弱卻堅定的光芒，像是夜海中的嚮導，召喚著彷徨的靈魂嚮往彼岸的安寧。\n你忍不住追了上去，然而，腳下突然不再堅實。\n你踩進了一片隱匿在暗影之下的水域。水面柔和如絲，無聲地吞噬了你的腳步。"
  },
  Event_35899_Name = {Text = "閃爍"},
  Event_35900_ChoiceDesc1 = {
    Text = "【傾聽她】"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "【無視她】"
  },
  Event_35900_Desc = {
    Text = "你看清了燈火的源頭，那赫然是一名有著女性身姿的角色。\n流光從異形的頭顱下傾瀉而出，鋪就一條通往未知之路。\n「回到……利@2亞……」"
  },
  Event_35900_Name = {
    Text = "長明燈火"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "【靠近燈塔】"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "【遠離燈塔】"
  },
  Event_35901_Desc = {
    Text = "轉過了現實與夢境交錯的拐角，在那個轉瞬即逝的瞬間，眼前鋪展開一幅風暴的可怖圖景。\n彷彿被一隻巨大無形的手掀起，狂風如猛獸咆哮，卷起了塵埃與希望，天空沉沉，壓抑至極。\n在風暴的心臟，那不應存在的燈塔矗立著，似乎是幻想的產物，又彷彿是古老傳說中的遺跡。它在狂風肆虐的舞臺上，孤獨而頑強地發出微弱的亮光。"
  },
  Event_35901_Name = {
    Text = "風暴中央"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "【離開】獲得 50 黑印"
  },
  Event_35902_Desc = {
    Text = "「密境中，燈火長明、身懷觸肢的幻影……」\n圖魯閉眼思忖，片刻後，長歎一口悠長的氣。\n「利莫里亞的守門人……餘的侍從之一。她終究也沒能逃過執念的捆綁。」"
  },
  Event_35902_Name = {
    Text = "索納尼爾號的沉沒"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "【觸碰銀光】獲得25黑印"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "【與銀光對話】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35903_Desc = {
    Text = "嚴絲合縫的通訊器被撬開了一道縫隙，黯淡的光從中流溢而出——這恐怕是銀芯被封入通訊器中樞後，首次與外部世界的對話。"
  },
  Event_35903_Name = {
    Text = "秘銀豐碑"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」"
  },
  Event_35904_Desc = {
    Text = "「頭顱發光的女人？」埃爾頓面露驚愕，顯然，他對貨輪密境中偶現的身影有所耳聞，只是——\n「索納尼爾號沉沒那夜……也就是我喚醒希萊斯特的那一夜，我曾在風暴中見過那樣的影子。」\n「我絕對沒有看錯。」"
  },
  Event_35904_Name = {
    Text = "索納尼爾號的沉沒"
  },
  Event_35905_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35905_Desc = {
    Text = "密境前路危機四伏，深不可測。\n你的眼睛死死盯著不可見的混沌，但在你被混沌吞噬前，解決追兵的拉蒙娜就一把擒住了你，將你拐向了另一頭。"
  },
  Event_35906_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35906_Desc = {
    Text = "那是你神秘靈魂孕育出的果實嗎？現在所經歷的一切都是自我與超我的對撞嗎？\n越去想，腦中的雜音越響亮清澈。視線闖進了一片迷霧，在你馬上就能窺見迷霧中人的上一秒，靈魂拒絕了你。"
  },
  Event_35906_Name = {
    Text = "倒錯的命運"
  },
  Event_35907_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35907_Desc = {
    Text = "它在體內湧動，化為無畏的力量，支撐你衝破迷霧、撕裂恐懼。"
  },
  Event_35908_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35908_Desc = {
    Text = "隨著意識的集中和內心的平靜混亂的幻象開始慢慢溶解，最後像是潮水般退去。\n最終，大腦中的噪音也消失得無影無蹤——只是，你會錯過多少？無從得知。"
  },
  Event_35908_Name = {
    Text = "未來預警"
  },
  Event_35909_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35909_Desc = {
    Text = "靈魂徹底迷失在了耳鳴中，你努力地想要掙脫，想要解讀這份痛苦，卻無論如何都只是在意識的邊緣徘徊……"
  },
  Event_35909_Name = {
    Text = "死生邊緣"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_35910_Desc = {
    Text = "你能感受到那燈塔發出的每一個光點，它們在風暴中燃燒、跳躍，就像是靈魂深處的呼喚，即使是在最洶湧澎湃的恐懼中，也不曾放棄引領歸途的使命。"
  },
  Event_35910_Name = {
    Text = "風暴中央"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "【離開】獲得3選1高級刻印"
  },
  Event_35911_Desc = {
    Text = "是希望的象徵，還是毀滅的預兆？\n你不再看它，仿若它的存在只是一場精心編排的幻夢。"
  },
  Event_35911_Name = {
    Text = "風暴中央"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "【沉淪迷離】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_35912_Desc = {
    Text = "然後，你的眼前蒙上了一層異常的灰紗。須臾後，你意識到那是你半透明的上眼瞼。"
  },
  Event_35912_Name = {
    Text = "死生邊緣"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "【離開】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_35913_Desc = {
    Text = "你的心中湧起了一種說不清的共鳴。\n但理智告訴你：無視她。"
  },
  Event_35913_Name = {
    Text = "長明燈火"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35914_Desc = {
    Text = "她的語言不曾刻在任何已知碑文之上，卻在空氣中凝結成了最深沉的懺悔與呼喚。像是從時光的另一端飄來，穿越了歲月的沉澱，帶著對一個遙遠家園的深情眷戀。"
  },
  Event_35914_Name = {
    Text = "長明燈火"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "【握住她的手】隨機1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "【出聲關心】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35915_ChoiceDesc3 = {
    Text = "【注視她】獲得25黑印"
  },
  Event_35915_Desc = {
    Text = "墨菲落在隊伍的最後，她與希萊斯特並肩行走。\n你忍不住頻頻回頭去看她，但墨菲始終低頭看著自己的鞋尖，將神情藏在未知中。"
  },
  Event_35915_Tips1 = {
    Text = "尚未擁有白銀造物"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "【無法抽身】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "【擁抱現實】獲得25黑印"
  },
  Event_35916_Desc = {
    Text = "@1@1重獲新生，靈魂穿越@2的邊緣，卻還未完全擁抱肉身。\n墨菲關切的話語與你的意識漸行漸遠，如同烏鴉的哀嚎，縈繞在耳畔，卻始終被心靈的壁壘擋在窗外。"
  },
  Event_35916_Name = {
    Text = "死生邊緣"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "【離開】選擇複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_35917_Desc = {
    Text = "她只是遺留在現實中的幽靈，一個無法觸及，卻又揮之不去的遠古殘章。"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_35918_Desc = {
    Text = "在那一刹那，你聽見了靈魂深處細微的碎裂聲。如逐漸消散的煙霧，她的形象開始暈染，變得越來越不真實。\n她並非存在於此，這只是埃爾頓船長記憶的投射。\n但停留在內心的，屬於她的失落與迷茫，不似作假。"
  },
  Event_35919_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35919_Desc = {
    Text = "在指尖接觸的瞬間，一種複雜的感覺突然湧上心頭——它既滾燙又冰冷。\n被世界遺忘的靈魂，正呼嘯著尋求永世。"
  },
  Event_35919_Name = {
    Text = "秘銀豐碑"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "【握緊火種】提高 Arg1 點最大生命"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "【直面內心】隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染2張「(Skill.Arg2)」"
  },
  Event_35920_Desc = {
    Text = "在這場聲勢浩大的狩獵中，戈利亞的追逐如幽夜中的猛獸，企圖吞噬一切希望的光。然而，這無情的追逐並未將你凍結，反而點燃了內心深處的火種，它在胸膛裡蔓延、燃燒，變得越來越熾熱。"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "【解讀它】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "【成為它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35921_ChoiceDesc3 = {
    Text = "【無視它】獲得25黑印"
  },
  Event_35921_Desc = {
    Text = "在邁出腳步的瞬間，一種無形的震顫硬生生扯住了你的意識，迫使你的雙眼看向密境混沌虛無的邊界。"
  },
  Event_35921_Name = {
    Text = "未來預警"
  },
  Event_35922_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35922_Desc = {
    Text = "有的是光怪陸離的色彩在眼前舞動，有的是聲音在耳邊低語，又或是閃過的場景和模糊的面孔，它們交織在一起，彷彿在講述著一個又一個未知的故事。這些幻象讓你感覺自己逐漸分離現實，陷入了一個既熟悉又陌生的夢境之中。"
  },
  Event_35922_Name = {
    Text = "未來預警"
  },
  Event_35923_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35923_Desc = {
    Text = "震顫並非來自外界的噪音或是觸覺上的震動，而是一陣難以名狀的、內心深處的預感。就像是某種未來的呼聲，在你的知覺上跳動。"
  },
  Event_35923_Name = {
    Text = "未來預警"
  },
  Event_35924_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35924_Desc = {
    Text = "她的手不自覺地撫向胸口，力圖控制那種讓人窒息的感覺。\n這種恐懼讓她咬緊牙關，強迫自己忽略肆虐於胸腔的陣痛。墨菲臉上的每一次微小的扭曲都被她迅速掩飾過去，用一種拙劣的偽裝來隱藏著痛苦。\n——直到你握住她的手，驚訝才成為了她臉上的顏色。"
  },
  Event_35925_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35925_Desc = {
    Text = "「墨菲？你還好嗎？」\n——她沒有回應你。\n有形的怪異腐蝕著她的心，讓她幾乎無法呼吸。"
  },
  Event_35926_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35926_Desc = {
    Text = "你不再猶豫，一腳踏入了漆黑的未知中。所行之處，描繪出一條朝著微光蔓延的路線圖。"
  },
  Event_35927_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35927_Desc = {
    Text = "你的眼前有一團跳動的火。\n它熱烈、鮮活，包裹著一束搖曳的冷焰火，明晃晃地驅散了那些不諧之音。\n你回過神來，只發現眼前是回頭疑惑看著你的墨菲——\n「你真的還好嗎？」"
  },
  Event_35927_Name = {
    Text = "死生邊緣"
  },
  Event_35928_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35928_Desc = {
    Text = "你感覺意識開始分離，慢慢地被拽離身體。\n彷彿看見自己的靈魂正與這銀芯殘存意識共舞，然後沉沉地落進一個不可見的深淵……\n那裡是純粹的虛無。"
  },
  Event_35928_Name = {
    Text = "秘銀豐碑"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "【離開】獲得 25 黑印"
  },
  Event_35929_Desc = {
    Text = "沒等你繼續深究燈火的源頭，它猛然震顫後，攪碎在了空氣中。\n燈光在密境中泛起層層漣漪，向四周擴散。\n然後什麼都沒能留下。"
  },
  Event_35929_Name = {Text = "閃爍"},
  Event_35930_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35930_Desc = {
    Text = "那怎麼可能是你呢？\n如果那是你，為什麼在悲傷降臨時，祂不救贖你？\n如果那是你，為什麼在歷經苦難時，祂不幫助你？\n所以，都是錯覺。"
  },
  Event_35930_Name = {
    Text = "倒錯的命運"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "【詢問船長】"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "【詢問圖魯】"
  },
  Event_35931_Desc = {
    Text = "又一次，你又一次看見了那個神秘身影走入艙壁，消失得無影無蹤。螢光的長髮從某處開始，化為數條垂落在地的觸腕。\n你無比清楚，她就算不是蹈海者的一員，身分也一定和失落之國有著千絲萬縷的關係。"
  },
  Event_35931_Name = {
    Text = "索納尼爾號的沉沒"
  },
  Event_35932_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35932_Desc = {
    Text = "你在恐懼，一切都是腎上腺素在搗鬼。\n你害怕自己的決策會傷害那些同你分擔黑暗的靈魂。"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "【無處可逃】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_35933_Desc = {
    Text = "每一根神經都在呼嘯著對@2的渴望。"
  },
  Event_35933_Name = {
    Text = "死生邊緣"
  },
  Event_35934_ChoiceDesc2 = {
    Text = "【無視它】"
  },
  Event_35934_Desc = {
    Text = "密境中的遠處，亮起了輕微而迷人的光。\n它像水面折射的陽光般波光粼粼，又像搖曳著的星光，或是一點燭火……\n就在你想向它靠近時，那光芒陡然消失。\n它似乎在引誘著你，像引誘著靠直覺而活的蛾。"
  },
  Event_35934_Name = {Text = "閃爍"},
  Event_35935_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_35935_Desc = {
    Text = "去糾結這些，又有什麼用呢？\n你是一葉懸浮半空的落葉，命運的風推著你走，只此而已。"
  },
  Event_35935_Name = {
    Text = "倒錯的命運"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "【自嘲】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35936_ChoiceDesc2 = {
    Text = "【追問到底】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_35936_ChoiceDesc3 = {
    Text = "【不再想】獲得25黑印"
  },
  Event_35936_Desc = {
    Text = "生命的風拂動著你的靈魂，讓你攪動在現實的漩渦中，捲進迷霧重重的未知。\n你忍不住向著腦中的聲音發問：「那是我嗎？」"
  },
  Event_35936_Name = {
    Text = "倒錯的命運"
  },
  Event_36146_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36146_Desc = {
    Text = "墨菲終於注意到了你的視線，或許，它確實是太過炙熱了。\n她深呼吸了幾口氣，從鼻腔裡發出了一聲輕輕的「哼」。最後，她拉著希萊斯特跟了上來，緊緊跟在了你身後。"
  },
  Event_36722_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36722_Desc = {
    Text = "在指尖接觸的瞬間，一種複雜的感覺突然湧上心頭——它既滾燙又冰冷。\n被世界遺忘的靈魂，正呼嘯著尋求永世。"
  },
  Event_36722_Name = {
    Text = "靈知豐碑"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "【觸碰它】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "【加入旋轉】獲得3選1刻印"
  },
  Event_36723_Desc = {
    Text = "邁動步子的瞬間，精神的最深處默然裂開了一道縫隙。不可名狀的深邃氣息透過裂縫，吹皺你的腦海。\n你感覺到一顆銀色的混沌星球正在內心暗自旋轉、滋長。"
  },
  Event_36723_Name = {
    Text = "靈知豐碑"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "【跟上它們】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36724_ChoiceDesc2 = {
    Text = "【撫摸它們】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_36724_ChoiceDesc3 = {
    Text = "【不去驚擾】獲得25黑印"
  },
  Event_36724_Desc = {
    Text = "在轉過一道意外的拐角之後，一幅奇異的景象顯現在你的視野裡。\n數隻貓的影子，若隱若現，飄忽在冰冷的艙壁邊。"
  },
  Event_36724_Name = {Text = "船貓"},
  Event_36725_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36725_Desc = {
    Text = "「記憶」沒有回應，他們貼在艙壁上，目不轉睛地盯著你，直到你走過下一個拐角。"
  },
  Event_36725_Name = {
    Text = "索納尼爾號的主人"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "【繞路而行】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_36726_ChoiceDesc2 = {
    Text = "【詢問為何沉沒】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "【向船員問好】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36726_Desc = {
    Text = "行走在前往動力室的路上，你再次遇見了一些被固定在密境中的「記憶」。\n他們不是幽魂，只是埃爾頓船長對逝去船員的牽掛。"
  },
  Event_36726_Name = {
    Text = "索納尼爾號的主人"
  },
  Event_36727_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36727_Desc = {
    Text = "「記憶」從艙壁上剝離而下，他扭曲著面容，從喉嚨裡發出悲鳴。\n——燈塔。\n——孤立的燈塔，將他們引入了風暴。"
  },
  Event_36727_Name = {
    Text = "索納尼爾號的主人"
  },
  Event_36728_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36728_Desc = {
    Text = "你選擇了跟隨，跟隨那些溫柔而自由的靈魂所勾勒出的軌跡，即使前方是黑暗留下的陷阱。"
  },
  Event_36728_Name = {Text = "船貓"},
  Event_36729_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36729_Desc = {
    Text = "不要打擾逝者，不要攪動沉眠的記憶。"
  },
  Event_36729_Name = {
    Text = "索納尼爾號的主人"
  },
  Event_36730_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36730_Desc = {
    Text = "你感覺意識開始分離，慢慢地被拽離身體。\n彷彿看見自己的靈魂正與星球共舞，然後沉沉地落進一個不可見的深淵……\n那裡是純粹的虛無。"
  },
  Event_36730_Name = {
    Text = "靈知豐碑"
  },
  Event_36731_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36731_Desc = {
    Text = "作為溫柔的生靈，它們是這密境所不允許的奢望，無非是幻影而已。\n你雖然明白這一點，心底卻仍泛起了一絲溫暖的漣漪。"
  },
  Event_36731_Name = {Text = "船貓"},
  Event_36732_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36732_Desc = {
    Text = "它們的身影，模糊如同被時空洪流沖刷過的油畫。幽深的黑色斑點宛若夜空中飄動的雲，它們的眼睛卻更像是遙遠星辰的閃光，散發著神秘而深邃的光芒。\n你無法抵抗它們的誘惑，伸手摸入了一片虛無。"
  },
  Event_36732_Name = {Text = "船貓"},
  Event_36733_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36733_Desc = {
    Text = "你知道你必須要繼續前行，哪怕是踉蹌，哪怕是跌倒。"
  },
  Event_36733_Name = {
    Text = "肉體苦痛"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "【嘗試呼喚他】提升 Arg1 點生命"
  },
  Event_36734_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_36734_Desc = {
    Text = "這裡是充滿了隱匿的願望和未曾觸及的恐懼的地方，是由他的夢想和記憶交織而成的豐富畫卷。"
  },
  Event_36734_Name = {
    Text = "進化的蛻變"
  },
  Event_36735_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36735_Desc = {
    Text = "「守密人，如果沒有辦法堅持了，請不要一個人忍受痛苦。」\n你不會逃避疼痛，它們是浮光掠影的生命的一部分。\n你不會躲避夜晚的陰影，因為你不怕被其中的黑暗吞噬。"
  },
  Event_36735_Name = {
    Text = "肉體苦痛"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "【繼續呼喚他】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_36736_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_36736_Desc = {
    Text = "天真的塗鴉組成了這個世界。"
  },
  Event_36736_Name = {
    Text = "進化的蛻變"
  },
  Event_36737_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36737_Desc = {
    Text = "蹈海者的祈禱在耳邊迴旋，瘋狂而令人窒息。\n但它們不會影響到你的意志，絕對不會。"
  },
  Event_36738_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36738_Desc = {
    Text = "這些注視深沉而清澈，如同深海中的光，明亮而溫暖。\n它們不言語，也不顯形，但你能感覺到它們的存在，就像夏夜裡微風輕拂的撫慰。"
  },
  Event_36738_Name = {
    Text = "善意窺探"
  },
  Event_36739_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36739_Desc = {
    Text = "你強制自己將注意力落在眼前的危機上，強硬地要求自己無視那些痛苦。"
  },
  Event_36739_Name = {
    Text = "肉體苦痛"
  },
  Event_36740_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36740_Desc = {
    Text = "那是生命的印記，是存在的證明。它講述著故事，卻在這風暴的肆虐下，漸漸失去了聲音。"
  },
  Event_36740_Name = {
    Text = "再見，伊卡洛斯"
  },
  Event_36741_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36741_Desc = {
    Text = "這些注視深沉而清澈，如同深海中的光，明亮而溫暖。\n它們不言語，也不顯形，但你能感覺到它們的存在，就像夏夜裡微風輕拂的撫慰。"
  },
  Event_36741_Name = {
    Text = "善意窺探"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "【最後一次呼喚他】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_36742_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_36742_Desc = {
    Text = "痛苦的裂痕組成了這個世界。"
  },
  Event_36742_Name = {
    Text = "進化的蛻變"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "【擁抱疼痛】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36743_ChoiceDesc2 = {
    Text = "【拒絕疼痛】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_36743_ChoiceDesc3 = {
    Text = "【無視疼痛】獲得25黑印"
  },
  Event_36743_Desc = {
    Text = "疼痛有如頑石，植根於腦海。擴散開來的苦楚像是藤蔓，纏繞著每一寸神經，扭曲著你的意識。"
  },
  Event_36743_Name = {
    Text = "肉體苦痛"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "【堅定地呼喚他】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_36744_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_36744_Desc = {
    Text = "對承認的嚮往組成了這個世界。"
  },
  Event_36744_Name = {
    Text = "進化的蛻變"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "【注視它們】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "【向它們求助】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，可以使用兩次"
  },
  Event_36745_Desc = {
    Text = "在密境流動的色彩中，你感到了一種神秘的注視，它們是無形的眼睛，隱藏在這密境的神秘褶皺之中。\n在它們望向你的那一刻，你的內心湧起了一種強烈的欲望。"
  },
  Event_36745_Name = {
    Text = "善意窺探"
  },
  Event_36746_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36746_Desc = {
    Text = "如果不去理解它們，那你將無法走出這片混亂的煉獄。\n星辰映照在水面上時，那些跳動的心願與懇求，那些祈禱便如同泡沫一般，緩緩升向海面，卻又不覺中被黑暗吞沒。"
  },
  Event_36747_ChoiceDesc1 = {
    Text = "【急切地呼喚他】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_36747_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_36747_Desc = {
    Text = "醜惡的言語組成了這個世界。"
  },
  Event_36747_Name = {
    Text = "進化的蛻變"
  },
  Event_36748_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36748_Desc = {
    Text = "你站在他的面前，目睹著他的靈魂被奇異的回憶所吞噬。"
  },
  Event_36748_Name = {
    Text = "進化的蛻變"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "【那是淚水】刪除1張卡牌"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "【那是鮮血】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36749_Desc = {
    Text = "幾滴液體在甲板上恣意地暈染開，順著甲板縫隙悄無聲息四下蔓延。\n那痕跡輕柔而堅定，每一道濕痕都帶著決絕的意味，在海風的咆哮和帆船的呻吟中，交織出一幅生與死，寧靜與喧囂的圖畫。"
  },
  Event_36749_Name = {
    Text = "再見，伊卡洛斯"
  },
  Event_36750_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36750_Desc = {
    Text = "你凝望著那些緩緩擴散的斑點，試圖辨認它們的本質，然而在這天地交接的邊際，雨水和血液的差異變得模糊不清。\n他們是雨水嗎？是海洋的眼淚嗎？\n你不知道。"
  },
  Event_36750_Name = {
    Text = "再見，伊卡洛斯"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "【拒絕同頻】獲得3選1白銀造物"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "【加入同頻】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_36751_Desc = {
    Text = "蹈海者的絮語與「聖嬰」的心跳交織成隱秘的交響樂，每一次震動，都讓無垠的液態宇宙引發一場呼嘯。"
  },
  Event_36752_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "【檢查膠捲】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，還可以使用一次"
  },
  Event_36752_Desc = {
    Text = "它們並無惡意，這種感覺如同直覺，植根於你的骨血之中。\n於是，你放下戒備，試著向這些隱秘的守望者求助：向那隱約的存在傾訴你的困惑和渴望，如同向一位老友敘說心事，真切無比。"
  },
  Event_36752_Name = {
    Text = "善意窺探"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "【講述學校的趣事】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "【沒有上過學】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_36874_Desc = {
    Text = "路過一處廢墟時，奧瑞塔的眼睛倏地亮了起來。\n「婆婆說，這裡以前是學校，但是因為沒有學生，早就荒廢啦！」\n「奧瑞塔沒有上過學，朋友呢？你有沒有去過學校？」"
  },
  Event_36874_Name = {
    Text = "失落的快樂"
  },
  Event_36875_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36875_Desc = {
    Text = "從你口中得到了否定的答案，奧瑞塔悶悶不樂地搖了搖頭。\n「原來，外面的世界也沒有學生……那最開始建學校，是為了什麼呢？」"
  },
  Event_36875_Name = {
    Text = "失落的快樂"
  },
  Event_36876_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36876_Desc = {
    Text = "「濟貧院、小老鼠、蠟像……好耶！探險，是探險！」\n奧瑞塔說著，腦袋上飄出一個不可視的問號。\n「不過，婆婆說學校是一個會讓奧瑞塔變聰明的地方，可是……」\n在奧瑞塔繼續思考下去前，你推著她走過了又一個轉角。"
  },
  Event_36876_Name = {
    Text = "失落的快樂"
  },
  Event_36877_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36877_Desc = {
    Text = "「為、為什麼？」\n奧瑞塔被你嚇了一跳，板著臉繼續指揮你。\n「這裡是奧瑞塔的家，奧瑞塔知道，廣場——就在那個裡面！」"
  },
  Event_36877_Name = {
    Text = "不可視的黑暗"
  },
  Event_36878_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36878_Desc = {
    Text = "「我不想走這條路，奧瑞塔知道其他前往廣場的方法嗎？」\n奧瑞塔嘟起了嘴，感到有些摸不著頭腦，但最終還是扯著你的披風，指揮向了另一個方向。"
  },
  Event_36878_Name = {
    Text = "不可視的黑暗"
  },
  Event_36879_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_36879_Desc = {
    Text = "這是夢境，這只是夢境。\n你反復告誡，或者說反復安慰著自己，領著奧瑞塔一頭闖入不可視的黑暗。"
  },
  Event_36879_Name = {
    Text = "不可視的黑暗"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "【聽從她】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36880_ChoiceDesc2 = {
    Text = "【反對她】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "【同她商量】獲得25黑印"
  },
  Event_36880_Desc = {
    Text = "奧瑞塔牽著你的披風，一步步踩著你的腳印向前走。\n「咦……錯啦！廣場在那個方向！」\n你轉頭看向奧瑞塔指出的方向，密境中的巷道儼然一片漆黑。融蝕漿、異變體蠕動著互相糾纏，將現實世界也一同拖入隕落的深淵。"
  },
  Event_36880_Name = {
    Text = "不可視的黑暗"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "【獲取經費】獲得 Arg1 黑印。"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "【獲取經費】獲得 Arg1 黑印[ExDesc1]。"
  },
  Event_37983_Desc = {
    Text = "「沒有領主會放任一個來歷不明的傢伙，更何況一個修士。」\n女王端坐於高高的王座上，眼裡不期然閃過一絲暴虐。\n「證明你還有別的用處，不然……」\n別的用處？你望向窗外荒蕪的田地，一個念頭忽然升起：或許可以運用所學的經濟學知識，幫助旺達管理莊園？\n你竭力在貧瘠光滑的大腦中搜刮——要知道在彌薩格，經濟學只是一門不起眼的選修課……\n耐心耗盡。女王打了個呵欠。\n「令人失望。放——」\n就在鍘刀墜下的那一刻，亞當·斯密、馬爾薩斯、大衛·李嘉圖等偉大先烈的英靈紛紛降臨在你的小腦瓜裡。\n勞動分工！徵稅！人口，見鬼的人口！\n你也許、大概想起來了。"
  },
  Event_37984_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_37984_Desc = {
    Text = "你硬著頭皮提出政令。\n女王草草看過，露出冰冷微笑：\n「若是沒有用的話，你知道會發生什麼。」"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "【提出政令】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "【提出政令】獲得詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "【提出政令】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_37985_Desc = {
    Text = "「收了我的錢，就要替我賣命。」\n女王單手托腮，漫不經心地看著你。\n不管承認與否，她的確對此抱有好奇。\n「那麼，告訴我你的計劃吧，大改革家。」"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "【接通】回復 Arg2 點生命[ExDesc1]。"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_38700_ChoiceDesc3 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_38700_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_38700_Name = {Text = "聯絡點"},
  Event_38700_Tips3 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "【驅散幻象】感染症狀。"
  },
  Event_38707_ChoiceDesc2 = {
    Text = "【吸收幻象】失去 Arg1 生命，獲得 Arg2 黑印"
  },
  Event_38707_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_38707_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_38715_ChoiceDesc1 = {
    Text = "【提出政令】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」"
  },
  Event_38715_ChoiceDesc2 = {
    Text = "【提出政令】獲得詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "【提出政令】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_38715_Desc = {
    Text = "「收了我的錢，就要替我賣命。」\n女王單手托腮，漫不經心地看著你。\n不管承認與否，她的確對此抱有好奇。\n「那麼，告訴我你的計劃吧，大改革家。」"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "【詢問身分】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "【離開】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_40452_Desc = {
    Text = "三個鬼魂阻擋了前進的步伐。\n他們圍在賭桌前，全神貫注地盯著骰子的動向。\n「咕嚕，咕嚕。」\n骰子被無數次拋起、落下。\n這是一場永遠沒有盡頭的賭局。"
  },
  Event_40452_Name = {
    Text = "無盡的賭局"
  },
  Event_40453_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40453_Desc = {
    Text = "「你好，我們分別是旺達的第一、第二以及第三任丈夫。」\n「什麼，你問第四任丈夫在哪裡？\n唔……老實說，約翰有點缺乏幽默感，所以被夫人變成了盲眼侍從。」\n「失去他我們都很遺憾。當然，只有一點點。」"
  },
  Event_40453_Name = {
    Text = "無盡的賭局"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "【與之握手】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_40454_Desc = {
    Text = "路過牢籠時，一隻手從裡面伸出。\n「別離開我，麗蓓嘉……」\n聲音蒼老幹癟，如同破舊的風箱。"
  },
  Event_40455_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40455_Desc = {
    Text = "手心傳來黏糊糊的觸感——是融蝕漿。\n聲音的主人不知何時早已消失，隱匿在角落暮氣沉沉的陰影裡。"
  },
  Event_40456_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40456_Desc = {
    Text = "你毫不在乎地離開了，因而錯過了信紙背後那段充滿戲劇性的過往。\n但那又有什麼關係呢？\n浩瀚的海洋、黎明和黃昏、赤道沙漠……\n你將遇見更多，也將錯過更多。"
  },
  Event_40456_Name = {
    Text = "致敬愛的夫人"
  },
  Event_40457_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40457_Desc = {
    Text = "某種意義而言，你和這個囚徒別無二致。\n現在還不是打草驚蛇的時候。\n你無視囚徒的哀求，轉身離去。"
  },
  Event_40458_ChoiceDesc1 = {
    Text = "【撕掉信件】選擇1個造物變化為詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "【無視信件】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_40458_ChoiceDesc3 = {
    Text = "【回信】獲得25黑印"
  },
  Event_40458_Desc = {
    Text = "Ⅰ.書信  約翰·坎貝里安 致旺達（洪積前@2年）\n\n丈夫有權處置自己的妻子，至少在坎布裡安如此。\n但我顯然低估了你的瘋狂程度。現在我的雙眼近乎全瞎，我的四肢也即將被砍掉。\n惡魔的女兒。惡魔的女兒……不，你就是惡魔本身。\n我詛咒你@1詛咒你@2詛咒你詛咒你……"
  },
  Event_40458_Name = {
    Text = "致敬愛的夫人"
  },
  Event_40459_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40459_Desc = {
    Text = "你採用了最樸實無華的手段解開詛咒。\n什麼都沒有發生。紙片毫無生氣地落到地上。\n你聳聳肩離開了，心裡卻總覺得有什麼地方不太對勁。"
  },
  Event_40459_Name = {
    Text = "致敬愛的夫人"
  },
  Event_40460_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40460_Desc = {
    Text = "你心無旁騖地路過賭桌。\n臨走前，鬼魂們齊聲開口：\n「請代我們向我們共同的前妻——旺達女士問好。」"
  },
  Event_40460_Name = {
    Text = "無盡的賭局"
  },
  Event_40461_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_40461_Desc = {
    Text = "你在信紙末端工整地寫上回信：\n「詛咒已收到，祝一切安好。」\n最後一筆落下的瞬間，信紙上燃起憤怒的青色火焰。\n你收穫了灰燼。"
  },
  Event_40461_Name = {
    Text = "致敬愛的夫人"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "【面對黑暗】[ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "【面對黑暗】[ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "【逃避黑暗】獲得隨機黃金造物"
  },
  Event_44187_Desc = {
    Text = "你眼前的靈魂晦暗污濁——光明與黑暗在它身上同時存在。它們爭奪主導，靈魂則陷入迷茫。\n「我很同情他們，那些失去一切的可憐人，但這個世界不是就是這樣的嗎？\n」有人獲得，就有人失去。\n「難道為了其他人的快樂，就要放棄我的快樂嗎？」"
  },
  Event_44187_Name = {
    Text = "內心的黑暗"
  },
  Event_44188_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44188_Desc = {
    Text = "「這是我的罪孽，是我的負擔。我該如何拯救你，我矛盾的靈魂？」"
  },
  Event_44188_Name = {
    Text = "內心的黑暗"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "【向主教祈求】淨化負罪造物，若無負罪造物，獲得隨機黃金造物。"
  },
  Event_44299_Desc = {
    Text = "「我坑蒙拐騙，獲得了想要的人生——金錢變成了數字，珍饈變成了家常，商業上我說一不二，政治上我手腕強硬。但為什麼，為什麼我忘不了那些人，那些被我奪走一切的人？為什麼我忘不了他們臉上的絕望？\n」酒精只能提供短暫的逃避，我的靈魂在自我撕扯，痛苦幾乎將我淹沒。\n「我究竟該怎麼做？」"
  },
  Event_44299_Name = {
    Text = "愧疚與寬恕"
  },
  Event_44301_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44301_Desc = {
    Text = "「你行在苦難的道路上，你偏離了父神的榮光。\n」回來吧，迷途的羔羊，聽從父神的教導，行到正路上來。「"
  },
  Event_44301_Name = {
    Text = "愧疚與寬恕"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "【求取外物】主教承受你的 1 張症狀，你獲得 Arg1 黑印。若無症狀，直接獲得黑印"
  },
  Event_44395_ChoiceDesc2 = {
    Text = "【求取鮮血】主教承受你的 2 張症狀，你獲得刻印「(EnchantConfig.Arg1)」。"
  },
  Event_44395_ChoiceDesc3 = {
    Text = "【求取更多】主教承受更多症狀(至少4張)"
  },
  Event_44395_Desc = {
    Text = "虛幻的靈魂凝出模糊的輪廓，它跪在主教身前展示自己殘破的軀體與殘留了黑色的內心。\n「你給予我指引，給予我寬恕，給予我救贖，但慈悲的主教啊，這遠遠不夠。\n」我窮困潦倒，疾病纏身。我命懸一線，而你是我唯一的救贖。救救我，主教，讓我能不再痛苦。「"
  },
  Event_44395_Name = {
    Text = "主教的「賜福」"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "【行禮並離開】"
  },
  Event_44396_Desc = {
    Text = "主教取下戒指，摘下胸針。那些象徵父神的藍色寶石被一一放在靈魂手中，主教彎下腰，握住可憐靈魂的雙手。\n「拿走我身上的金銀，拿走我所有的財物——只要那是你需要的。我有父神的教導便足夠生活。」"
  },
  Event_44396_Name = {
    Text = "主教的「賜福」"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "【沉溺其中】感染「(Skill.Arg1)」，覺醒隨機喚醒體"
  },
  Event_44400_ChoiceDesc2 = {
    Text = "【放棄】"
  },
  Event_44400_Desc = {
    Text = "迷失的靈魂不願放棄黑暗。\n你知道等待它的是什麼。荒誕的人生即將上演，而你是唯一的觀眾。"
  },
  Event_44400_Name = {
    Text = "內心的黑暗"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "【眼疾手快】獲得 Arg1 黑印"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "【肆意攫取】獲得 3 選 1高級刻印，感染「(Skill.Arg1)」。"
  },
  Event_44401_Desc = {
    Text = "在密境中發現的黑色印記，可向融痕獻祭以換取造物等精神投影。離開當前區域後很快會消散為黑色泥漿。"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "【驅散幻象】感染症狀。"
  },
  Event_44407_ChoiceDesc2 = {
    Text = "【擁抱虛妄】獲得 2 張隨機症狀，獲得 Arg1 黑印。"
  },
  Event_44407_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_44407_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_44445_ChoiceDesc1 = {
    Text = "【離開】尋找探照燈"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "【闖入霧氣】失去 Arg2 點生命"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "【捨棄外物】扣除 5 黑印，獲得 1 張「靈感」"
  },
  Event_44445_Desc = {
    Text = "前方是一片濃厚的黑色霧氣，貿然進入將招致災厄。\n或許你應該找到「探照燈」驅散霧氣。"
  },
  Event_44469_ChoiceDesc1 = {
    Text = "【求取骨肉】主教承受你的 4 張症狀，你獲得 3 選 1 黃金造物+。"
  },
  Event_44469_ChoiceDesc2 = {
    Text = "【求取賜福】主教承受你的 6 張症狀，你獲得 3 選 1 時靈擺。"
  },
  Event_44469_Desc = {
    Text = "虛幻的靈魂凝出模糊的輪廓，它跪在主教身前展示自己殘破的軀體與殘留了黑色的內心。\n「你給予我指引，給予我寬恕，給予我救贖，但慈悲的主教啊，這遠遠不夠。\n」我窮困潦倒，疾病纏身。我命懸一線，而你是我唯一的救贖。救救我，主教，讓我能不再痛苦。「"
  },
  Event_44469_Name = {
    Text = "主教的「賜福」"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "【索求】獲得主教的祝福"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "【索求】獲得主教的祝福"
  },
  Event_44474_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_44474_Desc = {
    Text = "「這是我的罪孽，是我的負擔。我該如何拯救你，我矛盾的靈魂？」"
  },
  Event_44474_Name = {
    Text = "內心的黑暗"
  },
  Event_44911_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44911_Desc = {
    Text = "「所有，所有……沒錯，我要所有……！」\n靈魂伸出手，徒勞地在空中抓取。\n它獲得了什麼，卻什麼也沒獲得。"
  },
  Event_44911_Name = {
    Text = "你所得為何"
  },
  Event_44913_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44913_Desc = {
    Text = "「那就只要最重要的那個，最重要的……」\n靈魂蹲了下來，從虛無的泥土中挖出了明亮的願望，並將它捧在了手心。"
  },
  Event_44913_Name = {
    Text = "你所得為何"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "【抓住所有】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "【學會放下】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_44916_Desc = {
    Text = "暗淡的靈魂陷入了痛苦。\n它在原地徘徊，為所有可能的選擇及後果迷茫。\n「我該怎麼選？」它輕聲呢喃，「我該怎麼做？」\n「我要如何才能擁有一切？」"
  },
  Event_44916_Name = {
    Text = "你所得為何"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "【內省自身】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "【外看旁人】獲得3選1刻印"
  },
  Event_44919_Desc = {
    Text = "漂浮的靈魂陷入了兩難。\n它停下腳步，在欲望之間躊躇。\n「我該怎麼選？」它輕聲呢喃，「我該怎麼做？」\n「究竟哪個才是我真正的所求？」"
  },
  Event_44919_Name = {
    Text = "你所欲為何"
  },
  Event_44920_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44920_Desc = {
    Text = "「你是對的，我得看看，我得看看……」\n它低下頭，雙手探入胸腔，從裡面掏出一顆虛幻的心臟：一半如墨般漆黑，一半如星般明亮。"
  },
  Event_44920_Name = {
    Text = "你所欲為何"
  },
  Event_44921_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44921_Desc = {
    Text = "「也是，也是……人說他人可做鏡……我得看看……」\n它湊到你身前，用沒有五官的面孔望著你。\n「你為什麼不會為難？好羡慕，好羡慕……」"
  },
  Event_44921_Name = {
    Text = "你所欲為何"
  },
  Event_44998_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_44998_Desc = {
    Text = "「他們說，現在的苦難是暫時的，死後我們自會在父神的懷抱中永享喜樂。\n」我不想等到死後。「\n陰影貪婪地吞噬著一切，靈魂暗淡下去，幾乎與周遭的黑暗融為一體。\n你想做什麼，卻無能為力。"
  },
  Event_44998_Name = {
    Text = "內心的黑暗"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "【行禮並離開】"
  },
  Event_45000_Desc = {
    Text = "主教用利刃割開掌心，滴落在石板上的鮮血化作治癒的藍光，將靈魂缺失的血補全。\n「拿走我的血液，填補你的生命——只要那是你需要的。這便是父神希望我行的事。」"
  },
  Event_45000_Name = {
    Text = "主教的「賜福」"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "【行禮並離開】"
  },
  Event_45001_Desc = {
    Text = "主教從胸腔深處掏出自己的靈魂。溫潤的光點融入石板，化作治癒的藍光，將靈魂上所有的裂痕填滿。\n「領受吧，這是父神的贈禮，是祂愛的證明。願你軀體康健，靈魂完滿，不再受任何苦楚。」"
  },
  Event_45001_Name = {
    Text = "主教的「賜福」"
  },
  Event_45002_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_45002_Desc = {
    Text = "你向那些面孔走去，再次睜開眼時，眼前已經歸於黑暗。只有不明來源的笑聲在周圍迴蕩。"
  },
  Event_45036_ChoiceDesc1 = {
    Text = "【刪除所有造物】"
  },
  Event_45036_Desc = {
    Text = "「這是我的罪孽，是我的負擔。我該如何拯救你，我矛盾的靈魂？」"
  },
  Event_45036_Name = {
    Text = "內心的黑暗"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "【行禮並離開】"
  },
  Event_45196_Desc = {
    Text = "主教用利刃剜下骨肉，蒼白的骨與猩紅的肉融入石板，化作治癒的藍光，將靈魂折斷的骨補全。\n「拿走我的骨肉，填補你缺失的軀體——只要那是你需要的。這便是父神希望我行的事。」"
  },
  Event_45196_Name = {
    Text = "主教的「賜福」"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_46144_Desc = {
    Text = "朦朧的人影逐漸清晰，那不是什麼融蝕體，也不是災厄，而是沒有翅膀，神色如常的克萊門汀。\n「真巧啊，你也是來欣賞月光的嗎？」她笑著說，你卻感到一陣暈眩，「濃霧之夜，還是要多加小心哦。\n」這兒的小傢伙們，可不怎麼安分。「"
  },
  Event_46144_Name = {
    Text = "霧氣中的身影"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_46145_Desc = {
    Text = "你不動聲色。一位貴婦人忽然衝上舞臺。 \n她瘋狂地掰開男孩的嘴，將手中的木棍狠狠捅進去。 \n「說話，給我說話。」 \n男孩嘴裡流出黑色的血。他含混不清地念了下去。 \n「獻給媽媽的歌……」"
  },
  Event_46145_Name = {
    Text = "終幕禮Ⅲ"
  },
  Event_47309_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47309_Desc = {
    Text = "到那日，神必用他剛硬有力的大刀刑罰非利士人，\n因著他們所「犯下」的殺戮之罪。\n什麼，你說這不公平？\n不，這才是獵食者的命運。"
  },
  Event_47309_Name = {
    Text = "水手歌謠"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "【繼續聽】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_47310_ChoiceDesc2 = {
    Text = "【離開】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_47310_Desc = {
    Text = "神說：就叫他非利士人吧。\n讓他肩負殺戮的職責，讓他背負貪婪的詛咒。\n讓他行的路發著光，令人想深淵如同白髮。\n浩渺的海洋中，沒有比這更雄偉的巨鯊。\n讓他被所有生靈畏懼、崇敬，\n直到審判來臨的時刻。"
  },
  Event_47310_Name = {
    Text = "水手歌謠"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_47311_Desc = {
    Text = "男孩是卑賤的奴隸。\n主人待他親如父子，卻被刺死在床上。\n「我愛您，父親。我只是不願再做奴隸。」\n後來，男孩站在「父親」的墓前，想起祭司的話：\n<Small:不要離開生養你的故土。\n屆時，你的雙手沾滿鮮血，你毫無尊嚴地死去。\n野狗、禿鷲和海魚都唾棄你。>\n名為以葛籣的男孩最終還是離開了。\n他將譜寫自己那臭名昭著的故事。"
  },
  Event_47311_Name = {
    Text = "木桶裡的男孩"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "【往前翻頁】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "【往後翻頁】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_47312_ChoiceDesc3 = {
    Text = "【丟棄】獲得25黑印"
  },
  Event_47312_Desc = {
    Text = "你撿到一本由莎草紙裝訂而成的書冊：\n……\n男孩躲在木桶裡，一路飄來非利士人的小島。\n他羸弱、下流、野心勃勃。\n當不朽巨人的榮光使所有人歎服，\n唯有男孩躲在陰影中，不讓那光靠近自己半分。\n後來，他被戈利亞委以重任。\n至於原因嘛——"
  },
  Event_47312_Name = {
    Text = "木桶裡的男孩"
  },
  Event_47313_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47313_Desc = {
    Text = "巨人接著說：\n「我把他放在我身邊，是因為他既憂鬱、又滑稽。\n並且他永遠殺不死我。」"
  },
  Event_47313_Name = {
    Text = "木桶裡的男孩"
  },
  Event_47314_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47314_Desc = {
    Text = "你未能聽到後面的部分，但它的歌詞使你想起另一首歌：\n「這條罕見的巨鯊呵，置身在狂風暴雨中，\n海洋就是它的家，\n既然強權就是公理，它就是強權的巨人，\n是無邊無際的海洋之王。」"
  },
  Event_47314_Name = {
    Text = "水手歌謠"
  },
  Event_47315_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47315_Desc = {
    Text = "現在不是閱讀的好時機。\n你匆匆丟開書冊，未能看到最後的內容：\n……\n他之所以躲在陰影中，並非出於妒忌。\n而是純粹的畏懼。\n一旦站在光下，卑瑣的靈魂將被徹底湮沒。\n連灰燼都不會剩下。"
  },
  Event_47315_Name = {
    Text = "木桶裡的男孩"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "【進入催眠】指定一名喚醒體使其精神分裂，失去初始的四張指令卡。"
  },
  Event_47463_Desc = {
    Text = "醫生從卷帙浩繁的書本中抬起頭：\n「你是稀有的樣本，因此我不會對你收費。\n但我需要另外的回報：一次催眠。\n這是一種新型的治療手段，它帶來毫無保留、完全赤裸的意識。\n怎麼樣，願意試試嗎？」"
  },
  Event_47464_ChoiceDesc1 = {
    Text = "【閃亮的記憶】[ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "【暗淡的記憶】將牌庫中所有合奏刻印升級為高級合奏刻印"
  },
  Event_47464_Desc = {
    Text = "她徘徊在意識之海的沙灘上。\n海浪的裙擺舔舐雙腳，將散落的記憶送來岸邊。\n它們有的閃亮，有的暗淡，還有的聞起來就像倫蒂尼恩的雨季。\n你選擇拾起哪一塊記憶？她徘徊在意識之海的沙灘上。"
  },
  Event_47464_Name = {
    Text = "「主體融合」"
  },
  Event_47465_ChoiceDesc1 = {
    Text = "【拒絕嘗試】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "【砸碎溶劑】淨化負罪造物"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "【接受實驗】獲得 1 個時靈擺「(RelicConfig.Arg1)」"
  },
  Event_47465_Desc = {
    Text = "醫生搖晃著碧綠的溶劑，興奮地告訴她：\n「喝下一口，你就能進入清醒的夢境。\n它是集體潛意識的念力再現。\n現在，你將和萬千生靈共用同一片意識之海，\n要來嚐嚐嗎？」"
  },
  Event_47465_Name = {
    Text = "「清醒夢」"
  },
  Event_47466_ChoiceDesc1 = {
    Text = "【回應聲音】獲得精神分裂喚醒體的1張指令卡"
  },
  Event_47466_Desc = {
    Text = "肉體是囚籠，監禁著四分五裂的人格們。\n名為「24」的監獄現在人滿為患。\n「不要昏睡，不要心平氣和。」\n黑暗中，有個聲音輕輕說。"
  },
  Event_47466_Name = {
    Text = "「自性覺知」"
  },
  Event_47848_ChoiceDesc1 = {
    Text = "【閉上雙眼】獲得3選1黃金造物"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "【偷瞄一眼】選擇覺醒 2 名喚醒體，並使其覺醒卡算力消耗降低 1 。"
  },
  Event_47848_ChoiceDesc3 = {
    Text = "【睜開雙眼】獲得白銀造物「(RelicConfig.Arg1)」，「(RelicConfig.Arg2)」，「(RelicConfig.Arg3)」"
  },
  Event_47848_Desc = {
    Text = "進入催眠前，醫生說：\n「沒有我的允許，不要睜開眼睛。」\n於是她緊閉雙眼，吸氣……吐氣……\n半睡半醒間，她似乎聽到了「嘶嘶」的氣聲。\n隨後她沐浴在冰冷的目光下——\n有什麼東西正在看著她。\n要不要睜開眼睛，悄悄看一眼呢？"
  },
  Event_47876_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47876_Desc = {
    Text = "她彎腰拾起閃閃發光的記憶。\n一個、兩個……無數快樂紛至沓來，\n她張開雙臂，圍繞它們轉起了圈圈。"
  },
  Event_47876_Name = {
    Text = "「主體融合」"
  },
  Event_47877_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47877_Desc = {
    Text = "她彎腰拾起暗淡的記憶。\n一個、兩個……無數卑瑣紛至沓來，\n她張開雙臂，將它們全部擁入懷中。"
  },
  Event_47877_Name = {
    Text = "「主體融合」"
  },
  Event_47878_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47878_Desc = {
    Text = "你拒絕成為這些古怪溶劑的犧牲品。\n醫生有些失落，但他並不勉強你。\n「我原諒人類的怯懦與短見。」"
  },
  Event_47878_Name = {
    Text = "「清醒夢」"
  },
  Event_47879_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47879_Desc = {
    Text = "嘩啦！你一把砸碎瓶子。\n綠色的溶液很快腐蝕了地板。\n「很好，無知的衝動。但我希望不要有下次了。\n不然我會因此而傷心落淚的。」"
  },
  Event_47879_Name = {
    Text = "「清醒夢」"
  },
  Event_47880_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47880_Desc = {
    Text = "你咕嘟一口喝了下去。\n咕嘟咕嘟……你的大腦跟喉嚨同時冒出無數泡泡。\n就像劈啪作響的小小煙花。\n「讚美你，勇敢的人類。你將有機會接觸無限。\n而我，將見證無限。」"
  },
  Event_47880_Name = {
    Text = "「清醒夢」"
  },
  Event_47881_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47881_Desc = {
    Text = "她睜開雙眼，說：\n「是的，這一切都是不對的。\n應當流淚，應當反抗。」\n黑暗中響起窸窸窣窣的聲音，她收穫了善意的回應。"
  },
  Event_47881_Name = {
    Text = "「自性覺知」"
  },
  Event_47900_ChoiceDesc1 = {
    Text = "【看見蛇】獲得黃金造物+「(RelicConfig.Arg1)」"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "【看見你】獲得負罪造物「(RelicConfig.Arg1)」"
  },
  Event_47900_Desc = {
    Text = "啪。\n一個輕輕的響指將她拽回現實。\n醫生不知何時將臉湊了上來，鈷黃色的眼睛興奮地眯了起來。\n「告訴我，剛才你都看到了什麼？」"
  },
  Event_47901_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47901_Desc = {
    Text = "她睜開雙眼。\n光影迷蒙間，她似乎看到一條寧靜的白色巨蛇在黑暗中盤踞、緩慢蠕動。\n哦，還有它的眼睛——\n那是純淨到不摻一絲雜質的金色。\n無悲無喜，不帶任何評判，\n足以叫睡鼠從盛夏的噩夢中驚醒。"
  },
  Event_47909_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47909_Desc = {
    Text = "她悄悄睜開一隻眼。\n視線所及是一團模糊的白色光影，在黑暗中緩慢蠕動。\n淺淡的金色在光影中一閃而過，似在警告她的違規。\n她不敢繼續看了。"
  },
  Event_47910_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47910_Desc = {
    Text = "她謹遵醫生的囑託，一刻也不曾睜開雙眼。\n冰冷的氣息刮過她周圍的空氣，在她臉上久久駐足。\n不知過了多久，一切恢復如常。\n彷彿什麼都不曾發生。"
  },
  Event_47911_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47911_Desc = {
    Text = "「我看見……一條很漂亮的蛇。」\n醫生握著鋼筆的手頓了一瞬。\n「什麼樣的蛇？」\n「很漂亮！周身泛白，上面還有金色的紋路……」\n醫生不再言語，嘴角微不可聞地揚了起來。\n「謝謝。」"
  },
  Event_47912_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47912_Desc = {
    Text = "她直直望進醫生鈷黃色的眼睛。\n「我看見你變成了一條蛇。」\n「噢。為什麼你確定那是我？」\n因為它神秘，靜止，繁複。\n並且……\n它看上去很倦怠，彷彿剛從一場歷時千年的冬眠中甦醒。"
  },
  Event_47992_ChoiceDesc1 = {
    Text = "【接通】回復 Arg2 點生命。"
  },
  Event_47992_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_47992_ChoiceDesc3 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_47992_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_47992_Name = {Text = "聯絡點"},
  Event_47992_Tips3 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_47993_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_47993_ChoiceDesc2 = {
    Text = "【離開】隨機 1 張指令卡獲得刻印：「(EnchantConfig.Arg1)」並複製 1 張該卡牌的原始版本"
  },
  Event_47993_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_47993_Name = {Text = "聯絡點"},
  Event_48225_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48225_Desc = {
    Text = "貓咪開心地舔了舔你的手背。\n「謝謝你，不必為我難過喵。\n這裡的人格隨時都在死亡、新生，\n我一定會回來的！\n喵喵，喵喵喵！」"
  },
  Event_48225_Name = {
    Text = "臨終囑託"
  },
  Event_48226_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48226_Desc = {
    Text = "貓咪認為你沒有理解它的意思，於是討好地蹭了蹭你的手背。\n「只要你肯答應喵，喵會將私藏的零食都獻給你。\n它們被妥善保管在坎佈雷街區@2號……」"
  },
  Event_48226_Name = {
    Text = "臨終囑託"
  },
  Event_48227_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48227_Desc = {
    Text = "你向喬治表達了誠摯的歉意。\n「哼，你還算是個知曉禮節的傢伙。\n喬治會考慮將詛咒力度下調10%，\n最多15%——這是喬治的底線。」"
  },
  Event_48227_Name = {
    Text = "喬治的幽靈"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "【答應它】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48228_ChoiceDesc2 = {
    Text = "【拒絕它】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "【保持沉默】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_48228_Desc = {
    Text = "「貓咪24」受了很嚴重的傷，它掙扎著告訴你：\n「嗚嗚，命不久矣喵。\n我有個朋友，是一條銀鱈魚喵。\n如果哪天你見到它，就說我出遠門了喵。\n要離開很久很久喵。\n會給它帶回來很多沒有炸魚的薯條喵。\n一定要告訴它哦！」"
  },
  Event_48228_Name = {
    Text = "臨終囑託"
  },
  Event_48229_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48229_Desc = {
    Text = "貓咪有些失望。\n但它一直是一隻聽話乖巧的貓咪，從不勉強別人。\n最後它帶著遺憾合上了雙眼。"
  },
  Event_48229_Name = {
    Text = "臨終囑託"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "【向它道歉】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48230_ChoiceDesc2 = {
    Text = "【嘲諷它】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48230_ChoiceDesc3 = {
    Text = "【無視它】獲得25黑印"
  },
  Event_48230_Desc = {
    Text = "一個幽靈，喬治的幽靈在你們上空盤旋。\n「喬治死得毫無尊嚴。\n不過沒關係，喬治永遠銘記這次羞辱。\n守密人，你要倒大黴了，哼哼哼……」"
  },
  Event_48230_Name = {
    Text = "喬治的幽靈"
  },
  Event_48231_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48231_Desc = {
    Text = "「呵呵，竟敢嘲諷喬治。\n放心吧，在你吃飯的時候、睡覺的時候、唱歌的時候……\n喬治都會在一旁飄來飄去，提醒你、折磨你。\n好叫你永遠銘記自己的罪孽。\n你永遠抓不到一隻幽靈，啦啦啦~」"
  },
  Event_48231_Name = {
    Text = "喬治的幽靈"
  },
  Event_48232_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_48232_Desc = {
    Text = "你大步向前，將喬治的詛咒拋諸腦後。\n身後傳來抽噎聲，喬治竟大哭起來。\n「嗚嗚……如此可愛的我，竟然被你的屁股——\n噁心！噁心！\n喬治寧願死在潘狄婭的皮鞭下！」"
  },
  Event_48232_Name = {
    Text = "喬治的幽靈"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "【呼喚喚醒體】扣除所有喚醒體 100 狂氣，刪除 1 張症狀卡"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "【奮力掙扎】回復 Arg1 點生命，感染2張「(Skill.Arg2)」"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "【插入銀鑰匙】清空所有銀鑰能量"
  },
  Event_49055_Desc = {
    Text = "影影綽綽的血污池在你踏上的瞬間現出了真身。\n赤黑色的血污伸出不可計數的手臂，攀附在你的腳踝，不斷向上攀扯，意圖將你拖入不可測的深淵。"
  },
  Event_49097_Desc = {
    Text = "腹腔內翻江倒海，數秒後奇蹟般恢復平靜，不知為何，你彷彿在體內聆聽到另一個鼓動的心跳……"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "【一飲而盡】選擇 [ExDesc3][ExDesc4] 張指令卡，使其獲得刻印：「(EnchantConfig.Arg1)」[ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "破舊的陶罐在低矮巖壁的狹縫中凝望著你。\n水源是沙漠中最珍貴的物資，酒精是瘋狂與迷幻世界的引藥。\n在這貧瘠地帶，一個尚存理智的人很難拒絕它的邀約。"
  },
  Event_49312_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49312_Desc = {
    Text = "銀鑰匙輝光閃爍，手臂們似被某種力量震懾，紛紛隱入池水，然後消失不見。"
  },
  Event_49313_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49313_Desc = {
    Text = "你奮力掙扎，卻越陷越深，腦海中響起詛咒般囈語之聲。\n回過神時，血色觸手們心滿意足地退去了。你竟覺得渾身暢快，只是冥冥之中似乎已經失去了什麼……"
  },
  Event_49314_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49314_Desc = {
    Text = "應聲而來的喚醒體未有片刻遲疑便將你拽出了血污之池，連接著你的手臂被撕裂，混濁的泥水飛濺，水中無數肉眼難以分辨的生物蠕動著，彷彿渴求和吞噬著什麼。"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "隨機喚醒體加50狂氣"
  },
  Event_49907_ChoiceDesc1 = {
    Text = "【詢問真假】"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "【請求撫摸】"
  },
  Event_49907_Desc = {
    Text = "「你總是一臉好奇地盯著我的角看，有什麼問題嗎？」\n泰旖絲突然貼近你的肩膀，蜂蜜色的珠墜搖搖晃晃地輕拂著你的臉頰。"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "【走向泰旖絲】"
  },
  Event_49908_Desc = {
    Text = "廢墟中煙塵四散，一角的破窗外，突然出現泰旖絲的身影。她毫無芥蒂地伏身在落滿灰塵的窗沿，神神秘秘地指了指屋梁上。"
  },
  Event_49908_Name = {
    Text = "潛行之人"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49909_Desc = {
    Text = "你抬起頭，鏽跡斑斑的銅管四通八達，如同巨大的蜘蛛網般覆蓋在頭頂。一個陰影掠過，是覓食的野貓還是躲在陰影中的怪物？\n再回過頭，泰旖絲也不見了蹤影。"
  },
  Event_49909_Name = {
    Text = "潛行之人"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "【注視她】"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "【呼喚她】"
  },
  Event_49910_Desc = {
    Text = "你又見到了那個「幻影」。\n這一次，你已經知道了她的名字。\n泰旖絲站在遙遠的母樹之下，虔誠地向樹祈禱。\n她的輪廓影影綽綽，與母樹的幻影仿若一體。"
  },
  Event_49910_Name = {
    Text = "祈願之人"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49911_Desc = {
    Text = "你遠眺著泰旖絲的身影，她的輪廓在這末日般的風暴中宛若一座神聖莊嚴的孤峰，縱使沙暴肆虐亦不能絲毫削弱其威嚴。\n她的邁步緩慢而穩健，她的身姿高貴而不可侵犯，令你看得入迷。"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "【離開】選擇複製1張指令卡"
  },
  Event_49912_Desc = {
    Text = "「你猜呢？」\n她「噓」了一聲，躬身湊得更近，你感覺角的末梢已經蹭上了你的臉頰，帶著微涼微癢的感覺……"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49913_Desc = {
    Text = "「想摸就大方點說嘛，我難道會拒絕你嗎？」\n她輕笑著拉著你的手，指尖觸碰的質感溫熱而滑膩，讓你幾乎想要深陷其中……"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒1名喚醒體，使其覺醒卡費用-1，感染「(Skill.Arg1)」"
  },
  Event_49914_Desc = {
    Text = "你與眾人一同跪伏於地。\n「我就知道、我就知道，女王，女王大人一直在守護我們！」\n喜極而泣的哭喊聲、悠長的呼喚聲夾雜著風的呼嘯，與你的腦腔共鳴震盪。\n隱約中，有什麼關鍵的思緒一閃而過，卻無法捕捉。"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_49915_Desc = {
    Text = "你向她揮了揮手。\n「你在做什麼？」拉蒙娜疑惑地看向你。\n「那裡……」\n話未出口，遠方那位女性已經不見蹤影。\n難道是錯覺？"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "【回應她】"
  },
  Event_49916_ChoiceDesc2 = {
    Text = "【猶豫】"
  },
  Event_49916_Desc = {
    Text = "遠遠望去，一名女性正在河岸邊鞠水。\n似乎是意識到你的目光，她回身向你招手。\n你注意到，她轉身的方式似乎有些異樣。"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印「(EnchantConfig.Arg1)」"
  },
  Event_49917_Desc = {
    Text = "在你猶豫間，女人一轉身躍入綠洲間不見了。\n你不太敢相信自己的眼睛……她似乎長著羊的蹄子？"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印「(EnchantConfig.Arg1)」"
  },
  Event_49918_Desc = {
    Text = "「樹啊，請聆聽@1人的祈願，我將沐浴您的乳汁而重生，成為您的代行者，為您行走於黃沙之間，令您的根系觸達勒姆瓦希的每個角落……」\n\n此起彼伏的稚嫩祈禱之聲在空間中迴蕩。"
  },
  Event_49918_Name = {
    Text = "祈願之人"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "【離開】隨機覺醒1名喚醒體"
  },
  Event_49919_Desc = {
    Text = "泰旖絲曖昧莫名的目光牽扯了你的注意，某種詭譎的力量令你在不由間神魂顛倒，你似被牽引，忍不住向她走去。\n「其實，看不見的事物，也依然存在。」\n她輕輕對你耳語，你似有所悟，卻像是籠罩了一層白紗，看不明晰。\n這是某種預言嗎？恍然間，泰旖絲已不見了蹤影。"
  },
  Event_49919_Name = {
    Text = "潛行之人"
  },
  Event_49920_Desc = {
    Text = "羊的黑蹄踏上風沙的大地。\n泰旖絲唱誦著不知名的禱文，無數亞蘭人迎著她踏沙而來的方向跪伏。"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_49921_Desc = {
    Text = "巨樹探出萬千粗壯的枝條，如絞纏的觸肢，將泰旖絲的手腕足踝緊緊縛住，不顧她的掙扎抗拒，蠻橫地將她的軀幹納入膨脹的樹莖腹腔……\n\n儘管只是遙遠的虛影，她的痛苦依然隨著水波的震盪直抵你的內心。"
  },
  Event_49921_Name = {
    Text = "祈願之人"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」"
  },
  Event_49922_Desc = {
    Text = "癱軟的肢體隨著樹的漿液流淌於枝幹，她竭盡全力掙扎，肢體卻像是蹣跚扭曲的蠕蟲不聽使喚。\n「骨骼已經完全溶解了，」泰旖絲的眼角眉梢被悲哀侵染，「她已經是樹的一部分了。」\n「我們需要逆轉的力量……超越時間的力量。」"
  },
  Event_49922_Name = {
    Text = "腐蝕之人"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49923_Desc = {
    Text = "「而且，那位“倒懸的無目之瞳”，不知為何，有一種發自肺腑的強烈感召力……」\n「哎呀，在聊我的事情嗎？」\n「美迪奈特在盛讚你講故事的能力呢。」\n\n那個篝火悄然燃燒的夜晚，她曾為你添過一杯酒。"
  },
  Event_49923_Name = {
    Text = "腐蝕之人"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "【剖開樹瘤】"
  },
  Event_49924_ChoiceDesc2 = {
    Text = "【回憶】"
  },
  Event_49924_Desc = {
    Text = "一枚樹瘤。\n它邪惡而腫脹地跳動著，脆弱透明的血色表皮內側透出一張乖戾而痛楚的臉，彷彿隨時要破繭而出。\n「美迪奈特。」泰旖絲面露悲傷之色，溫柔地呼喚那張臉的名字。"
  },
  Event_49924_Name = {
    Text = "腐蝕之人"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "【相信萊克】所有喚醒體回復Arg1狂氣"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "【擔憂萊克】選擇覺醒2名喚醒體"
  },
  Event_49939_Desc = {
    Text = "「相信我的好運吧。」"
  },
  Event_49939_Name = {
    Text = "好運偵探"
  },
  Event_49940_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49940_Desc = {
    Text = "萊克擅長的事只有三件：偵查、聆聽、擲骰。\n換句話說，並不以戰鬥見長。\n你內心的擔憂難以抑制，瘋狂滋長。"
  },
  Event_49940_Name = {
    Text = "好運偵探"
  },
  Event_49941_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49941_Desc = {
    Text = "相信的心是魔法，他定能戰勝眼前的一切阻礙。"
  },
  Event_49941_Name = {
    Text = "好運偵探"
  },
  Event_49943_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49943_Desc = {
    Text = "你感到很不好意思，卻還是充滿企求地望向了仍在病中的拉蒙娜。\n“我來吧。”\n她漲紅著臉，從那個無限容量的隨身手提箱中拿出一枚簇新的採集瓶，眼疾手快地將蜘蛛罩住。"
  },
  Event_49944_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49944_Desc = {
    Text = "萊克打了個響指，然後將毛茸茸的食指伸向高舉前足的大蜘蛛。\n這類花紋斑斕的物種多半有劇毒，你剛要提醒他小心，剛才還充滿敵意的蜘蛛卻輕巧地蹦上他的指節，蜷縮了起來。\n算了，人各有命。"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "【看向拉蒙娜】獲得3選1刻印"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "【看向萊克】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49945_Desc = {
    Text = "多重複眼與你面面相覷。\n複眼的主人後退了半步，張牙舞爪地對你發出威嚇。\n從那高抬的步足和觸肢和支撐身體的兩對足看起來，這的確是一隻罕見的蛛形綱生物。\n臨行前訶勒特的叮囑言猶在耳：“額外任務，請採集當地物種樣本並留存至當地勘測站。”\n你晃了晃背包裡的採集瓶，經過數周跋涉，裡面已經蟲滿為患。"
  },
  Event_49946_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49946_Desc = {
    Text = "「不顧時機的貪婪是一種疾病。」"
  },
  Event_49947_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49947_Desc = {
    Text = "「照本宣科並不能為你博得好感，孩子。」"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "【金鑰匙】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49948_ChoiceDesc2 = {
    Text = "【鐵鑰匙】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "【銀鑰匙】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_49948_Desc = {
    Text = "正午時分，聖河蒸騰的水氣凝成兩具虛空的幻影。\n幻影朦朧的聲音向你發問：這是你掉的金鑰匙、銀鑰匙、還是鐵鑰匙？"
  },
  Event_49949_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_49949_Desc = {
    Text = "「誠實往往會帶來更穩妥的結果，但在同時，你或許也會錯失什麼。」"
  },
  Event_50013_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50013_Desc = {
    Text = "你仔細辨認，那個人的面容卻隨著水波浮蕩，朦朧不清。\n\n你越是定睛凝神，呼吸就越是遲滯，大腦傳來缺氧般的迷幻感，直至聽見拉蒙娜呼喚你的聲音，才勉強被拉回現實。\n水面倒映的烈日異常刺眼，但水面下似乎有什麼閃閃發光。"
  },
  Event_50014_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50014_Desc = {
    Text = "幻影一觸即潰，你的手中空無一物，唯有太陽穴突然爆發的劇烈刺痛。\n水面倒映的烈日異常刺眼，但水面下似乎有什麼閃閃發光。"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "【努力辨認】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50015_ChoiceDesc2 = {
    Text = "【伸手觸碰】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50015_ChoiceDesc3 = {
    Text = "【揉揉眼睛】獲得25黑印"
  },
  Event_50015_Desc = {
    Text = "你被努比亞一推，半條腿陷入聖河之中。\n你勉力穩住身形，卻在搖晃的水波中見到了不應見的倒影。\n那是一位身穿彌薩格校服、身姿頎長的青年，他癱軟的軀體倒陷於聖河的水流之中。"
  },
  Event_50016_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50016_Desc = {
    Text = "恐慌腐蝕著你的心智，痛苦讓意識變得模糊，你極力撕扯，藤蔓卻越收越緊，鼻腔滲入了散發異味的黏液，每一次呼吸都帶著黏稠的絕望。\n拉蒙娜一劍刺下，努比亞斷足而逃，你扯下最後一截黏附臉側的觸手，上面竟然沾著層模糊的血肉。"
  },
  Event_50016_Name = {
    Text = "撲面而來"
  },
  Event_50017_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50017_Desc = {
    Text = "銀光刺入努比亞的身軀，血肉爆裂的感受順著銀鑰匙傳遞至你的指尖與手腕。\n努比亞扭曲的觸肢向天空高舉，尖嘯般發出恐怖而哀怨的嘶鳴，通體化作黏稠的不明液體。"
  },
  Event_50017_Name = {
    Text = "撲面而來"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "【撕扯】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50018_ChoiceDesc2 = {
    Text = "【穿刺】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50018_Desc = {
    Text = "努比亞纏藤狀的觸手扭曲飛舞，趁隙撲上你的臉頰，狂暴地侵入你的口鼻。"
  },
  Event_50018_Name = {
    Text = "撲面而來"
  },
  Event_50019_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50019_Desc = {
    Text = "水面上只有粼粼波光。\n你拔起濕漉漉的腿，倒出鞋中潮濕的砂礫。\n剛才的影像仍徘徊在腦海中，揮之不去。"
  },
  Event_50029_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50029_Desc = {
    Text = "「他會回來嗎？還是永遠將你遺落在這無垠沙海之中呢？」\n「他能找到你嗎？還是會因為風向與沙丘的流變而迷失你的座標呢？」\n「你寄託於他人身上的希望，果真有那麼可靠嗎？」"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "【尋求救援】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "【共同前進】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50030_Desc = {
    Text = "一個古老而悠遠的聲音混合在潺潺水流聲中向你發問。\n「你迷失於漫漫黃沙之中。」\n「擺在你面前的有兩個選擇。你的同伴腳程更快，讓他帶著食物和水去尋求救援，你們以最小的消耗留在原地。」\n「或者你們共用一切，繼續前行。」"
  },
  Event_50031_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50031_Desc = {
    Text = "「你們未必能走得更遠，但你們的靈與肉緊緊相依，從中獲得鼓舞彼此的力量。」\n「這便是你的選擇。」\n說著，高空中灼人的烈日合上了眼。"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "【切斷紅綢】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "【對抗】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "【呼喚拉蒙娜】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50064_Desc = {
    Text = "卡茜亞甩出紅綢，瞬間纏住了你的手提箱。"
  },
  Event_50064_Name = {
    Text = "絞纏之綢"
  },
  Event_50065_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50065_Desc = {
    Text = "時斷時續的清脆敲擊聲在你們頭頂縱橫交錯的管道間迴旋起伏，像一個獨自跳舞的幽魂，在這片死寂的空間裡擺動無力的雙臂。\n這種遐想在你的心底召喚起古老恐懼的森嚴寒意。"
  },
  Event_50065_Name = {
    Text = "詭異音階"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "【在洞口探索】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "【深入巖洞】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50066_Desc = {
    Text = "「這兒有個巖洞。」\n泰旖絲側身向你發出邀請。\n「要不要進去看看？」\n狹窄的巖洞幽暗深邃，猶如惡魔的巨口，伸展向無盡的黑暗。任誰踏入這片荒涼之地，都無法擺脫脊髓深處升騰的不祥預感。彷彿在這巖洞的每個角落，都潛伏著那些不敢直視陽光的古老生物，靜待著闖入者的到來。"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "【逐一擊破】隨機1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "【包圍二人】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50067_ChoiceDesc3 = {
    Text = "【偷聽談話】獲得25黑印"
  },
  Event_50067_Desc = {
    Text = "兩名亞蘭人看守著工廠大門。\n其中一個無所事事地閒晃著，找另一位搭話。\n「有人說，於麗埃特大人又在清點嘗試突破風暴之壁的隊伍了。」\n「我可千萬千萬別選上啊。」"
  },
  Event_50067_Name = {
    Text = "閒散的看門人"
  },
  Event_50067_Tips1 = {
    Text = "尚未擁有白銀造物"
  },
  Event_50068_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50068_Desc = {
    Text = "不看、不聽、不想。\n不去幻想那不合時宜的音色從何而來，你直奔母樹遺骸的所在。"
  },
  Event_50068_Name = {
    Text = "詭異音階"
  },
  Event_50069_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50069_Desc = {
    Text = "拉蒙娜一劍刺向揮舞紅綢的卡茜亞，卡茜亞急忙避讓，糾纏你的紅綢也在瞬間鬆脫。"
  },
  Event_50069_Name = {
    Text = "絞纏之綢"
  },
  Event_50070_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50070_Desc = {
    Text = "你們兵分兩路，你和拉蒙娜自左，萊克自右，從兩側夾擊。\n你抬手示意，拉蒙娜和萊克一齊出手，兩名亞蘭守衛無聲倒地。"
  },
  Event_50070_Name = {
    Text = "閒散的看門人"
  },
  Event_50071_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50071_Desc = {
    Text = "此時不宜深入陷阱。你們僅在洞口徘徊，就幾乎能感受到岩石脈搏中蘊藏的邪惡跳動。"
  },
  Event_50072_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50072_Desc = {
    Text = "在你的示意下，萊克一骰子砸暈了沉默的亞蘭看守，然後悄悄靠近了另一個仍在喋喋不休的傢伙。\n「嘿，兄弟，如果那個什麼於麗埃特大人是個騙子，你說怎麼辦？」\n「我也不知道怎麼辦。」\n萊克快樂地齜牙，看守渾身一顫，正欲尖叫，被萊克捂住了口鼻。"
  },
  Event_50072_Name = {
    Text = "閒散的看門人"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "【仔細聆聽】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50073_ChoiceDesc2 = {
    Text = "【捂住耳朵】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_50073_ChoiceDesc3 = {
    Text = "【查看】獲得3選1刻印"
  },
  Event_50073_Desc = {
    Text = "你們進入遺骸所在的樓層時，空曠的廢棄工廠內突兀地傳來悅耳的叮咚之聲，鋼琴鳴奏的清泠之感與銹蝕的鋼鐵廢墟格格不入。"
  },
  Event_50073_Name = {
    Text = "詭異音階"
  },
  Event_50074_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50074_Desc = {
    Text = "「嘿，兄弟，如果那個什麼於麗埃特大人是個騙子，你說怎麼辦？」\n「別亂說，自從於麗埃特到來，一切都被打理得井井有條。她是個騙子，為什麼要幫亞蘭人這麼多？」\n他們閒談間，萊克悄無聲息地選好了埋伏的位置，砰砰兩枚骰子飛出，將二人擊倒在地。"
  },
  Event_50074_Name = {
    Text = "閒散的看門人"
  },
  Event_50075_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50075_Desc = {
    Text = "你鼓起勇氣瞪視回去。\n幕布的巨眼陡然扭曲獰笑，你的頑強抵抗動搖潰敗。"
  },
  Event_50075_Name = {
    Text = "魔術之眼"
  },
  Event_50076_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50076_Desc = {
    Text = "你心無旁騖地撕裂幕布。\n巨眼在你的手下化作一片缺乏立體感的破碎布料。"
  },
  Event_50076_Name = {
    Text = "魔術之眼"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "【回瞪】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50077_ChoiceDesc2 = {
    Text = "【撕裂幕布】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50077_Desc = {
    Text = "幕布張開無數扭曲的巨眼。\n潛匿在眼瞳之後的巨物流露出異常的饑渴，蠢蠢欲動。"
  },
  Event_50077_Name = {
    Text = "魔術之眼"
  },
  Event_50078_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50078_Desc = {
    Text = "原來是一截廢棄的長條狀零件被你們的動靜震動，搖搖晃晃地敲打鐵質管道。"
  },
  Event_50078_Name = {
    Text = "詭異音階"
  },
  Event_50079_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50079_Desc = {
    Text = "泰旖絲泰然踏入巖洞之中，你在背後亦步亦趨地探索。\n「小心！」你被猝然拉開，跌坐在一個柔軟的懷抱中。你們身前，一隻漆黑的巨獸迅猛無匹地衝出了洞穴。\n「看這裡，」你仍驚魂未定之際，泰旖絲開口了，她的眼睛在黑暗中閃著微弱的螢光，「恐怕是它的寶藏呢。」"
  },
  Event_50080_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50080_Desc = {
    Text = "你拼命拽住手提箱的提手，與紅綢對抗。\n但那紅綢力大無窮，你的手提箱脫手，雜物散落一地。"
  },
  Event_50080_Name = {
    Text = "絞纏之綢"
  },
  Event_50081_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50081_Desc = {
    Text = "你討厭被束縛的感覺。\n你拽住紅綢，滋啦一聲將它一撕兩斷。\n剩餘的半截紅綢像是一條紅蛇般遊走。"
  },
  Event_50081_Name = {
    Text = "絞纏之綢"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "【消滅祭品】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50276_ChoiceDesc2 = {
    Text = "【解開繩索】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "【繼續前進】獲得50黑印"
  },
  Event_50276_Desc = {
    Text = "三名亞蘭人被捆縛於高臺之上。\n他們的身上浮現出你在嬰孩身上曾見過的樹皮狀深色紋路，口中念念有詞。"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "【凝視】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50277_ChoiceDesc2 = {
    Text = "【無視】獲得3選1刻印"
  },
  Event_50277_Desc = {
    Text = "亞蘭人在沙暴中跪伏。\n風暴抽打著他們的軀殼，砂礫席捲他們的虔心。\n沙塵的漩渦之中，似乎有無數隻巨眼俯瞰著扭曲的大地。"
  },
  Event_50277_Name = {
    Text = "沙塵巨物"
  },
  Event_50278_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50278_Desc = {
    Text = "你不願意回想的畫面再次在眼前浮現。\n搖搖擺擺的觸肢，玻璃破片切割的汩汩血痕……\n你作嘔起來。"
  },
  Event_50279_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50279_Desc = {
    Text = "她不在這裡，她不在最危險的熱潮之中。\n這就足夠讓你安心了。"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "【偷襲】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "【攻擊】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50280_Desc = {
    Text = "一隻努比亞在劇烈的沙暴中掙扎。\n它的四蹄深深嵌入黃沙，竭力避免被捲入漩渦。"
  },
  Event_50281_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50281_Desc = {
    Text = "你毅然闖入，在亞蘭人的驚呼聲中將繩索扯開。\n一名亞蘭戰士試探著逼近，你劈手奪過他手中的長矛，指向黑洞洞的人群。"
  },
  Event_50282_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50282_Desc = {
    Text = "理智告訴你，他不會來了。\n是啊，誰會指望一個賭徒信守諾言呢？\n你只能孤獨。你只有孤獨。"
  },
  Event_50283_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50283_Desc = {
    Text = "那異常的高燒會隨著母樹的復生而加劇嗎？\n拉蒙娜獨自在風暴之壁外能照顧好自己嗎？\n現在不是分心的時候，但你忍不住擔憂起你的搭檔。"
  },
  Event_50284_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50284_Desc = {
    Text = "你決意正面迎擊，努比亞反而像是找到了難得的落腳點，一躍而上攀住了你的頭顱。\n你陷入沙暴與努比亞的雙重糾纏之中。\n「一味蠻勇並非取勝之法，」威廉冰冷的話音在被堵住耳腔的你聽來簡直是天使的福音，「學會把握機會。」"
  },
  Event_50285_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50285_Desc = {
    Text = "現在可不是悠閒讀報的時候。"
  },
  Event_50285_Name = {
    Text = "她的叮嚀"
  },
  Event_50286_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50286_Desc = {
    Text = "你不去想，你不去回憶。\n你不願想，你不願回憶。\n彌薩格的傳奇會落幕，但彌薩格的歷程不會中止。\n你必須走下去。你必須走下去。"
  },
  Event_50287_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50287_Desc = {
    Text = "「親愛的守密人：\n見信安。\n很抱歉在這次勒姆瓦希之旅中因為沒打理好自己的身體，不能一直陪在你身邊。\n但在關鍵的時刻，請相信你唯一的助手。\n你需要我的時候，我永遠都在。」\n時間原因，你無法再閱讀下去了。\n但熟悉的字跡帶給你一種令心緒平和的安定感。"
  },
  Event_50287_Name = {
    Text = "她的叮嚀"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "【他還會來】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "【他不會來了】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50288_Desc = {
    Text = "最後一個離開的人是萊克。\n為了阻止卡茜亞，他選擇了留在營帳中。\n他曾經答應你，最後要硬闖儀式現場去焚燒母樹，他也絕對奉陪。\n可他現在還是沒有來到你身邊。\n只留你孤身一人。"
  },
  Event_50289_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50289_Desc = {
    Text = "咕嚕咕嚕，三枚圓圓的恐怖之物在儀式現場滾動。\n你覺得自己不像是自己了，病態狂熱的儀式氛圍將你捲入不可名狀的虛無之中。"
  },
  Event_50290_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50290_Desc = {
    Text = "亞蘭的信仰如此虔誠，甘願一次次被黃沙埋葬。\n可你抬頭仰望，風暴中沒有太陽。"
  },
  Event_50290_Name = {
    Text = "沙塵巨物"
  },
  Event_50291_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50291_Desc = {
    Text = "願沙海回應他們的虔誠。"
  },
  Event_50291_Name = {
    Text = "沙塵巨物"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "【掙脫回憶】隨機提升1張卡牌的刻印品質"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "【捕捉回憶】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50292_Desc = {
    Text = "第二個離開的人是威廉。"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "【安心】獲得25黑印"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "【擔憂】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50293_Desc = {
    Text = "你突然回憶起踏上旅程的那天。\n拉蒙娜提醒你收拾好行囊，威廉為你準備了沿途紀錄的手冊，萊克偷偷往你的包裡塞了一瓶威士卡。\n現在他們已經離開了。\n\n第一個離開的人是拉蒙娜，塔薇的力量與風暴之壁的權能相互排斥，她潰敗於沿途的高燒。"
  },
  Event_50294_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50294_Desc = {
    Text = "你偷襲努比亞的足部，它站立不穩，幾條藤蔓狀的觸肢在空中急促而凌亂舞動，最終被捲入了塵暴之中。"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "【閱讀】刪除1張卡牌"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "【收起】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50295_Desc = {
    Text = "哢噠哢噠。\n在這不似人間的狂熱祭壇之下，沉重的鼓聲順著沙風滾滾而來。在不絕於耳的詠唱聲中，你卻聽到了打字機微弱的輕響——那是來自彌薩格的呼喚，慰藉你浮躁不安的心靈。"
  },
  Event_50295_Name = {
    Text = "她的叮嚀"
  },
  Event_50296_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50296_Desc = {
    Text = "萊克擁有超越世俗的好運。\n他答應過你的事情，絕對會做到。\n絕對。"
  },
  Event_50297_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_50297_Desc = {
    Text = "與你無關。\n現在你最需要的，是儘快接觸和破壞母樹遺骸。"
  },
  Event_52373_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52373_Desc = {
    Text = "你活了下來。你看到無數被壘起的土堆，被焚燒的軀體。\n你似乎也燒掉了些什麼，但那已經無關緊要。\n你聽見，神國的鐘聲已然敲響。"
  },
  Event_52373_Name = {
    Text = "瘟疫的侵襲"
  },
  Event_52374_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52374_Desc = {
    Text = "你活了下來。你看到無數被壘起的土堆，被焚燒的軀體。\n你奮力保護著那些自己所珍視的事物，為此，你付出了慘痛的代價。但那已經無關緊要。\n你聽見，神國的鐘聲已然敲響。"
  },
  Event_52374_Name = {
    Text = "瘟疫的侵襲"
  },
  Event_52375_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52375_Desc = {
    Text = "巨人的怒火暫時消卻了。雲銷雨霽，風平浪靜。海洋如同永恆的慈母，用溫柔的潮汐輕輕撫摸利莫里亞的背脊。只留下利莫里亞身上，滿身狼藉的屍首與廢墟。\n你奮力保護著那些自己所珍視的事物，為此，你付出了慘痛的代價。但那已經無關緊要。\n在海洋中，你窺視到了神國的輪廓。"
  },
  Event_52375_Name = {
    Text = "海洋的轟鳴"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "【獻上額外祭品】刪除 1 張指令卡，將 3 種「神國幻影」各 1 張加入牌庫。"
  },
  Event_52376_Desc = {
    Text = "站立在利莫里亞坍塌的王座之前，你獻上最後的祭品。\n無盡的深淵展露在你面前。你跪拜，微笑，淚流滿面。\n“看吶，父親，黛博拉。看吶，我至高的王——神國，已於我身前降臨！”"
  },
  Event_52376_Name = {
    Text = "迎接吧，神國"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "【保護珍視之物】失去 Arg1 生命，獲得 1 張隨機症狀卡。"
  },
  Event_52377_Desc = {
    Text = "大地。沉默的大地，平穩的大地。承載人類的大地，永恆不朽的大地。可大地在戰慄。它裂出深不見底的豁口，所承託的一切都搖搖欲墜。\n你將一切希望寄託於大地，當大地開始震顫，你又將去往何處？\n獻祭吧，利莫里亞的子民們向你呼喚。獻祭出你的一切，讓無災的神國降臨。"
  },
  Event_52377_Name = {
    Text = "大地的戰慄"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "【保護珍視之物】失去 Arg1 生命，獲得 1 張隨機症狀卡。"
  },
  Event_52378_Desc = {
    Text = "海洋。海洋是孕育利莫里亞的母親，是你的生活，你的信仰。而此刻，海洋如傳說中憤怒的巨神般站起身。祂呐喊，呼號，將溫潤的海水化為堅硬的巨巖與利刺，揮向身前的一切。祂冷漠地俯視在腳邊戰慄的利莫里亞，俯視那些昆蟲般驚竄的利莫里亞人。祂將毀滅利莫里亞，這與利莫里亞無關。\n獻祭吧，利莫里亞的子民們向你呼喚。獻祭出你的一切，讓無災的神國降臨。"
  },
  Event_52378_Name = {
    Text = "海洋的轟鳴"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "【保護珍視之物】失去 Arg1 生命，獲得 1 張隨機症狀卡。"
  },
  Event_52379_Desc = {
    Text = "瘟疫。瘟疫無處不在。瘟疫是最為無恥的僕從，當大地與海洋的神罰過去，它便替神明宣判那些不可訴諸於口的死亡。埋葬親人的屍體，焚燒親人的屍體，祈禱那些為保護自己而死的至親，離自己越遠越好。生命與人性，在瘟疫面前不堪一擊。\n獻祭吧，利莫里亞的子民們向你呼喚。獻祭出你的一切，讓無災的神國降臨。"
  },
  Event_52379_Name = {
    Text = "瘟疫的侵襲"
  },
  Event_52380_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52380_Desc = {
    Text = "強烈的震動平息了。街道上沾染著殷紅的血跡，倒塌的房屋下，無數的人被掩埋。\n你奮力保護著那些自己所珍視的事物，為此，你付出了慘痛的代價。但那已經無關緊要。\n唯一重要的是，你距離神國，又近了一步。"
  },
  Event_52380_Name = {
    Text = "大地的戰慄"
  },
  Event_52381_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52381_Desc = {
    Text = "站立在利莫里亞坍塌的王座之前，你頌念最後的禱言。\n無盡的深淵展露在你面前。你跪拜，微笑，淚流滿面。\n“看吶，父親，黛博拉。看吶，我至高的王——神國，已於我身前降臨！”"
  },
  Event_52381_Name = {
    Text = "迎接吧，神國"
  },
  Event_52382_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52382_Desc = {
    Text = "強烈的震動平息了。街道上沾染著殷紅的血跡，倒塌的房屋下，無數的人被掩埋。\n你的某樣東西似乎也被埋葬在了廢墟之下，但那已經無關緊要。\n唯一重要的是，你距離神國，又近了一步。"
  },
  Event_52382_Name = {
    Text = "大地的戰慄"
  },
  Event_52383_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_52383_Desc = {
    Text = "巨人的怒火暫時消卻了。雲銷雨霽，風平浪靜。海洋如同永恆的慈母，用溫柔的潮汐輕輕撫摸利莫里亞的背脊。只留下利莫里亞身上，滿身狼藉的屍首與廢墟。\n你的某樣東西似乎葬身於大海，但那已經無關緊要。\n在海洋中，你窺視到了神國的輪廓。"
  },
  Event_52383_Name = {
    Text = "海洋的轟鳴"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "【虔心禱告】將牌庫中每1張普通症狀卡變為1張 「神國幻影」並再獲得2張「神國幻影」。"
  },
  Event_52384_ChoiceDesc2 = {
    Text = "【虔心禱告】將牌庫中每1張普通症狀卡變為1張 「神國幻影」並再獲得2張「神國幻影」。"
  },
  Event_52384_Desc = {
    Text = "大地不再戰慄，海洋不再轟鳴，瘟疫不再侵襲。天災毀滅了利莫里亞利，留下了你。你抬頭環顧身周，滿目瘡痍。你低頭看向雙手，空空如也。\n可那又怎麼樣呢，尊敬的主祭？踩踏著利莫里亞的殘墟與屍首，繼續向前爬行吧。\n你離神國，只有一步之遙。"
  },
  Event_52384_Name = {
    Text = "迎接吧，神國"
  },
  Event_53140_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_53140_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_53140_Name = {Text = "聯絡點"},
  Event_53141_ChoiceDesc1 = {
    Text = "【接通】回復 Arg2 點生命。"
  },
  Event_53141_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_53141_ChoiceDesc3 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_53141_ChoiceDesc4 = {
    Text = "【墮入瘋狂】隨機覺醒 2 名喚醒體，獲得 1 張隨機症狀"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "【躊躇】其他"
  },
  Event_53141_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_53141_Name = {Text = "聯絡點"},
  Event_53141_Tips3 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_53142_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_53142_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_53142_Name = {Text = "聯絡點"},
  Event_53143_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_53143_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_53143_Name = {Text = "聯絡點"},
  Event_53147_ChoiceDesc1 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_53147_ChoiceDesc2 = {
    Text = "【墮入瘋狂】隨機覺醒 2 名喚醒體，獲得 1 張隨機症狀"
  },
  Event_53147_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_53147_Name = {Text = "聯絡點"},
  Event_53147_Tips1 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_53148_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_53148_Desc = {
    Text = "你接通了通訊。通訊器那頭響起的，是一道瘋狂的、令你如癡如醉的聲音。\n“銘記吧。這是神國予你的恩賜。”"
  },
  Event_53148_Name = {Text = "聯絡點"},
  Event_55782_ChoiceDesc1 = {
    Text = "【斬斷荊棘】下一場戰鬥敵人生命提高 30%，傷害提高 15%，獲得 Arg1 張意象「(Skill.Arg2)」。"
  },
  Event_55782_ChoiceDesc2 = {
    Text = "【斬斷荊棘】下一場戰鬥敵人生命提高 30%，傷害提高 15%，獲得 Arg1 張意象「(Skill.Arg2)」。"
  },
  Event_55782_ChoiceDesc3 = {
    Text = "【撥開荊棘】感染「(Skill.Arg3)」，將 Arg1 張意象「(Skill.Arg2)」置入牌庫。"
  },
  Event_55782_ChoiceDesc4 = {
    Text = "【撥開荊棘】感染「(Skill.Arg3)」，將 Arg1 張意象「(Skill.Arg2)」置入牌庫。"
  },
  Event_55782_ChoiceDesc5 = {
    Text = "【離開荊棘】「奧爾拉的筆與墨」獲得 Arg1 層「筆墨」。"
  },
  Event_55782_Desc = {
    Text = "某個東西觸動了你的心絃。你停下了腳步，望向花園的角落。在層層荊棘之下，一個光點正在躍動著，嘗試解除掉身上的束縛。\n那是什麼？蝴蝶？飛鳥？你靠近它。"
  },
  Event_55782_Name = {
    Text = "繆斯的眷顧"
  },
  Event_55782_Tips1 = {
    Text = "下一場戰鬥敵人已被增強，不可再次選擇"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "【創作獻詩】選擇 3 張「意象」卡，讓奧爾拉為你創作「獻詩」。"
  },
  Event_55783_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_55783_Desc = {
    Text = "你來到一座美麗的花房前，透過窗戶，你向花房裡張望，但你什麼也看不見。\n一陣風吹起，花房中的花瓣與落葉被風捲動，在空中飛舞、聚攏。在花與葉中，你看到了一個少女的身影。\n“啊！花、花園裡來客人了！”少女驚喜又緊張地望向你。“抱歉，柯蕾特出門了……買花的話，我不太清楚這些花的價格……”\n少女忽然停了下來，靠近你打量了兩眼。“啊，這位客人，我在你身上感受到了詩的意象……或許，我們可以一起創作一首詩？”"
  },
  Event_55783_Name = {
    Text = "春天的贈禮"
  },
  Event_55783_Tips1 = {
    Text = "「意象」數量不足 3 張，不可合成"
  },
  Event_55799_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_55799_Desc = {
    Text = "活過來的荊棘似乎有些躁動,但這些代價無足輕重——在那個光點上,你聽見了繆斯的呼喚。"
  },
  Event_55799_Name = {
    Text = "繆斯的眷顧"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "【順應軀體的記憶】跳過戰鬥立即勝利，但失去 Arg1 點生命值。"
  },
  Event_55819_ChoiceDesc2 = {
    Text = "【離開】進入戰鬥"
  },
  Event_55819_Desc = {
    Text = "面對熟悉的敵人，接下來的戰鬥你已經了然於心。"
  },
  Event_55819_Name = {
    Text = "肌肉記憶"
  },
  Event_55997_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_55997_Desc = {
    Text = "從搜集的意象裡，你選出了幾個，交到少女的手上。\n“好美的意象！這位客人，請等等……給。這是春天帶來的，獨屬於你的獻詩！”\n一首詩出現在你的手上，像是專門為你而開的花朵。\n你想感謝少女。但當你抬起頭時，少女的身形已經消失不見。孤獨的花房裡，只剩滿地枯萎的花與葉。\n——那是春天燃盡後，留下的餘灰。"
  },
  Event_55997_Name = {
    Text = "春天的贈禮"
  },
  Event_55999_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_55999_Desc = {
    Text = "重重荊棘讓你望而卻步。你離開了光點，但剛剛的短暫凝視，依然讓你心裡充盈著新的靈感——在那個光點上，你聽見了繆斯的呼喚。"
  },
  Event_55999_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56000_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_56000_Desc = {
    Text = "你用手撥開了荊棘，為此你受了一些傷，但這些代價無足輕重——在那個光點上，你聽見了繆斯的呼喚。"
  },
  Event_56000_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56024_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_56024_Desc = {
    Text = "還不夠……你繼續向那個光點靠近。荊棘被激怒了，向你露出了尖利的刺。但一切都是值得的。\n那個光點從你的手心散開，在漫天的光幕中，你清晰地感受到了繆斯的眷顧。"
  },
  Event_56024_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "【靠近光點】下一場戰鬥敵人生命額外提高 30%，傷害額外提高 15%，可選擇 1 張「意象」升級。"
  },
  Event_56025_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_56025_Desc = {
    Text = "你用隨身的工具斬斷了荊棘，那些活過來的荊棘似乎有些躁動，但這些代價無足輕重——在那個光點上，你聽見了繆斯的呼喚。"
  },
  Event_56025_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56146_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_56146_Desc = {
    Text = "還不夠……你繼續向那個光點靠近。尖利的刺割破了你的手，讓你血流不止。但一切都是值得的。\n那個光點從你的手心散開，在漫天的光幕中，你清晰地感受到了繆斯的眷顧。"
  },
  Event_56146_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "【創作衝動】所有喚醒體失去所有狂氣，選擇 3 張「意象」卡，讓奧爾拉為你創作「獻詩」。"
  },
  Event_56147_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_56147_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_56147_Name = {Text = "聯絡點"},
  Event_56147_Tips1 = {
    Text = "「意象」數量不足 3 張，不可合成"
  },
  Event_56148_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_56148_Desc = {
    Text = "校徽上的銀光讓你一陣心潮起伏。遵循著心裡的指引，你將手裡的東西扔進了荊棘。荊棘下的光芒開始閃耀——在那光芒之中，你領悟到了新的靈感。"
  },
  Event_56148_Name = {Text = "聯絡點"},
  Event_56149_ChoiceDesc1 = {
    Text = "【靠近光點】降低 10% 生命上限，可選擇一張「意象」升級。"
  },
  Event_56149_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_56149_Desc = {
    Text = "你用手撥開了荊棘，為此你受了一些傷，但這些代價無足輕重——在那個光點上，你聽見了繆斯的呼喚。"
  },
  Event_56149_Name = {
    Text = "繆斯的眷顧"
  },
  Event_56149_Tips1 = {
    Text = "無可升級的「意象」"
  },
  Event_56150_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_56150_Desc = {
    Text = "校徽上的銀光讓你一陣心潮起伏。你感到一陣強烈的衝動，將腦海中的詩句記錄了下來。"
  },
  Event_56150_Name = {Text = "聯絡點"},
  Event_56151_ChoiceDesc1 = {
    Text = "【新的靈感】選擇 1 張「意象」移除，隨機升級 1 張「意象」。"
  },
  Event_56151_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_56151_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_56151_Name = {Text = "聯絡點"},
  Event_56151_Tips1 = {
    Text = "當前無「意象」卡"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "【硬闖】所有喚醒體獲得 30 點狂氣，但將兩張「(Skill.Arg1)」塞入卡組"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "【繳械】下一場戰鬥敵人生命提高 60%，傷害提高 30%。"
  },
  Event_57738_ChoiceDesc3 = {
    Text = "【伏擊】消耗所有喚醒體狂氣，獲得 30 黑印並移除守衛威脅。"
  },
  Event_57738_Desc = {
    Text = "你從拐角處的視野盲區向外窺視。審查會的探員正在監視另一個方向，並沒有注意到你們的存在。\n曾經訓練的畫面在你腦海中一一閃過，對這個攔在必經之路上的敵人，你很快想到了合適的處理方式。"
  },
  Event_57738_Name = {
    Text = "審查會探員"
  },
  Event_57738_Tips3 = {
    Text = "當前所有喚醒體沒有狂氣"
  },
  Event_57739_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_57739_Desc = {
    Text = "你仔細觀察著。審查會的探員攔在你們的必經之路上，正認真地監視著你面前的這塊區域。\n面對人數眾多的敵人，你無法與他們抗衡。\n是進，還是退？"
  },
  Event_57739_Name = {Text = "羈押點"},
  Event_57776_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_57776_ChoiceDesc2 = {
    Text = "【詐降】探索完該區域後，傳送至羈押點，獲得 2 張隨機「症狀」。"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "【闖入】探索完該區域後，傳送至羈押點，失去 Arg1 點生命。"
  },
  Event_57776_Desc = {
    Text = "你仔細觀察著。審查會的探員攔在你們的必經之路上，正認真地監視著你面前的這塊區域。\n面對人數眾多的敵人，你無法與他們抗衡。\n是進，還是退？"
  },
  Event_57776_Name = {Text = "監察點"},
  Event_57776_Tips3 = {
    Text = "當前生命不足"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "【阿利斯泰爾的祝福】將一張「極夜微光」加入牌庫。"
  },
  Event_59193_Desc = {
    Text = "這枚入學證書一直被你壓在手提箱的底部，你撫摸著彷彿鍍上星辰餘輝的精緻邊框，輕嗅著獨屬於紙張的淡淡墨香，彌薩格的校徽彷彿通往未來的光輝之門，吸引著你渴求的眼睛——一如那日，一如今日。"
  },
  Event_59193_Name = {
    Text = "入學儀式"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "選擇一張卡牌領悟「智識之理」刻印。「智識之理」：打出後抽 2 張牌，它們算力消耗降低刻印卡牌實際消耗算力，每場戰鬥僅生效 1 次。"
  },
  Event_59527_Desc = {
    Text = "象徵智識的標記刻印在你的證件上。\n塔薇的思緒匯入你的腦海。在那無盡的可能性中，你正走向唯一正確的道路。"
  },
  Event_59527_Name = {
    Text = "入學儀式"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "選擇一張卡牌領悟「歡愉之理」刻印。「歡愉之理」：打出後棄掉所有該喚醒體以外的卡牌，獲得 5 張隨機非喚醒體卡牌，每場戰鬥僅生效 1 次。"
  },
  Event_59528_Desc = {
    Text = "象徵歡愉的標記刻印在你的證件上。\n透過印記，N正在打量你。祂期待著，你為祂帶來不曾妄言過的結局。"
  },
  Event_59528_Name = {
    Text = "入學儀式"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "選擇一張卡牌領悟「繁育之理」刻印。「繁育之理」：打出後獲得 3 張附加「保留」和「消耗」的原始複製，每場戰鬥僅生效 1 次。"
  },
  Event_59529_Desc = {
    Text = "象徵繁育的標記刻印在你的證件上。\n泰旖絲將祂的希望寄託於你，祂將與你在一切世界中共生。"
  },
  Event_59529_Name = {
    Text = "入學儀式"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "【擦拭血淚】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "【堅持睜眼】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59566_Desc = {
    Text = "無數個你的願望融為一體，曾經你們共同擁有同一個來處，現在你們共同擁有同一副身體。\n無數隻眼一起睜開，要去直面那巨大的眼瞳。\n無數隻眼一起破碎，流下痛苦而乾涸的血淚。"
  },
  Event_59567_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59567_Desc = {
    Text = "你試圖與那瘋狂的聲音爭辯，辯駁那虛無的理念。\n“萬物都會走向死亡，難道生命本身就毫無意義嗎？”\n你據理力爭，然而那笑聲絲毫不減，彷彿在嘲笑你的愚蠢。"
  },
  Event_59568_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59568_Desc = {
    Text = "你注視著那扇門，不想再忍受無知的痛苦。\n你想要看到門後的景象。\n虛幻的門扉迷幻地搖曳著，你看到無數世界的虛影一閃而過。\n來不及看清，無窮的資訊沖垮了你的精神，你的大腦充滿了混亂的噪點。"
  },
  Event_59568_Name = {
    Text = "門扉之後"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "【堅定指揮】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "【共同商談】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59569_Desc = {
    Text = "一切發生得如此突然，你感到周圍籠罩著一片朦朧的煙霧，你努力四處眺望，卻什麼都看不清。\n喚醒體們等待著你的指令。\n現在你孤立無援，只能依靠自己的力量。"
  },
  Event_59569_Name = {
    Text = "無知之目"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "【以犧牲】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59570_ChoiceDesc2 = {
    Text = "【以勇敢】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "【以直視】獲得50黑印"
  },
  Event_59570_Desc = {
    Text = "無數個你站在無數的世界中，肩並著肩、手牽著手，彷彿親如一體的兄弟姐妹。\n現在你們共同站在那片巨大的陰影下，抬起頭顱，不後退半步。\n要怎樣做？\n要怎樣做才能打敗那個最終的你？"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "【尋找答案】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "【放棄】獲得25黑印，離開"
  },
  Event_59571_Desc = {
    Text = "經過門扉的幻影，無數個你經歷的一切閃回在你的腦海。\n他們有的死亡、有的瘋狂、有的堅持、有的墮落。\n無數條道路、無數種選擇在你面前閃回，你彷彿一瞬間活過了漫長無盡的一生。\n現在無數個頭腦、無數張嘴同時運轉。\n你試圖跨越時空與無數個自己對話，從無盡的記憶中打撈答案。"
  },
  Event_59571_Name = {
    Text = "我的自問"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "【交換力量】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "【交換幸運】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_59572_Desc = {
    Text = "一切選擇皆有代價。\n生命、精神、情感、記憶……\n你想向命運交換什麼，又選擇將什麼放上天平？"
  },
  Event_59572_Name = {
    Text = "命運抉擇"
  },
  Event_59573_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59573_Desc = {
    Text = "人怎麼可以沒有心臟呢？\n你慌亂地四處找尋，你的呼吸漸漸急促，死亡的恐懼籠罩在你的大腦。\n“喘不上氣了……心跳要停止了……”\n等等，你好像已經不再需要心跳了。\n你恍然大悟，開心地笑了起來。"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "【直視】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59574_ChoiceDesc2 = {
    Text = "【逃避】 隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_59574_Desc = {
    Text = "你感到虛空中有某種存在注視著你。\n無論你走到哪裡，那目光都如影隨形。\n你覺得自己像是被盯上的渺小獵物，你的後背開始針刺一樣疼痛起來。"
  },
  Event_59575_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59575_Desc = {
    Text = "你在狂亂的演奏中不為所動，始終默默堅持自己的步調。\n對方的攻擊與引誘對你無效，鋼琴上同時彈奏著兩種曲調，誰堅持到最後，誰就能駕馭全部音符。"
  },
  Event_59575_Name = {
    Text = "末日狂歡曲"
  },
  Event_59576_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59576_Desc = {
    Text = "你拿出所有勇氣，無論要面對什麼，你都會和並肩作戰的夥伴們走下去。"
  },
  Event_59576_Name = {
    Text = "未來定格"
  },
  Event_59577_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59577_Desc = {
    Text = "“你現在在哪裡？”\n“老師們有什麼打算？”\n“我接下來該怎麼做？”\n你急迫地追問著，想要像往常一樣依賴那個可靠的存在。\n聯絡器如同卡頓般失去了反應，你搖晃著機器，晃動中回信上的字跡扭曲變作了一群蝴蝶，嘩啦啦撲在了你的臉上。\n你揉了揉眼睛，發現一切不過是你的幻覺。\n回信的紙張上空無一字。"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "【慌張尋找】提升 Arg1 點最大生命"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "【嘗試填充】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59578_Desc = {
    Text = "你感到胸腔內部變得空虛而輕盈，你低頭看去，胸口洞開成了鎖孔的形狀。\n你的心臟不翼而飛。"
  },
  Event_59579_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59579_Desc = {
    Text = "你大聲質問著他的目的，然而只收獲了絲毫未變的笑容。\n\n他早已背離了世界，無牽無掛的人不需要對任何事負責。\n你只能徒勞地反抗。"
  },
  Event_59579_Name = {
    Text = "瘋狂的紳士"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "【打亂節奏】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59580_ChoiceDesc2 = {
    Text = "【保持自我】獲得3選1刻印"
  },
  Event_59580_Desc = {
    Text = "你彷彿與一個癲狂的人一同演奏，她將你綁架在琴鍵上，將你裹挾進她瘋狂的曲目。\n你在她的節奏中艱難彈奏，踉踉蹌蹌。\n你費力與她博弈，試圖把控曲調的旋律。"
  },
  Event_59580_Name = {
    Text = "末日狂歡曲"
  },
  Event_59581_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59581_Desc = {
    Text = "你希望自己擁有無可匹敵的力量，能夠打碎一切枷鎖與障礙。\n然而人力有窮，以渺小之軀挑戰神明，終將會如火柴般燃盡自己的生命。"
  },
  Event_59581_Name = {
    Text = "命運抉擇"
  },
  Event_59582_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59582_Desc = {
    Text = "“沒了……沒了……”\n空虛的感覺很不好受，你拿起了懷錶、蘋果和校服外套，試圖填滿胸口的空洞。\n你的胸腔重新變得滿滿當當，只不過你有種過於飽腹的錯覺。\n沒關係，事情總是不會很完美。"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "【說服】獲得25黑印"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "【質問】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59583_Desc = {
    Text = "N的皮鞋停在你面前，你看到那張漆黑的面孔上誇張的笑容。\n他慣常穿著體面，但你知道那紳士的外表之下只有最純粹的瘋狂。\n他沒有朋友，也鮮有敵人。\n因為那些人都會以最戲劇的方式徹底消失。\n\n很不幸，現在你被他選為了戲劇的下一個主角。\n請準備你的開場白吧，要如何才能讓這最挑剔的觀眾滿意？"
  },
  Event_59583_Name = {
    Text = "瘋狂的紳士"
  },
  Event_59584_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59584_Desc = {
    Text = "喚醒體們並不比你多了解什麼，但他們早已是你最忠誠的夥伴、戰友與後盾。\n你與喚醒體們商討對策，儘管你們內心依然彷徨，但已經擁有了重新出發的勇氣。"
  },
  Event_59584_Name = {
    Text = "無知之目"
  },
  Event_59585_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59585_Desc = {
    Text = "彷彿為自己下定決心一般，你堅定地大聲應答。\n你的聲音迴蕩在無數的泡泡之間，彷彿有無數個你一起宣誓。\n你已經準備好面對一切。"
  },
  Event_59585_Name = {
    Text = "祂的質問"
  },
  Event_59586_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59586_Desc = {
    Text = "你沒有動彈，只是緊盯著回信上的字跡。\n在你的注視下，那些字句逐漸模糊扭曲，最終變作了一群蝴蝶嘩啦啦撲飛到你的臉上。\n你揮舞雙手驅趕蝴蝶，轉頭回看時回信的紙張上已經空無一字。\n果然，過於美好的美夢都是虛假的。"
  },
  Event_59587_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59587_Desc = {
    Text = "你憎恨著這些卑鄙的絲線。\n你狠狠扯向它們，有的線崩斷，無數的線又重新纏來。\n你用盡所有力量，與它們不斷對抗。"
  },
  Event_59587_Name = {
    Text = "被操縱的雙手"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "【斬殺人影】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59588_ChoiceDesc2 = {
    Text = "【碾碎胚胎】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59588_ChoiceDesc3 = {
    Text = "【閉上雙眼】獲得25黑印"
  },
  Event_59588_Desc = {
    Text = "恍惚中你看到曾在亞蘭見過的人們向你靠近。\n他們歡笑著邀請你飲酒、跳舞、品嘗美食。\n然後他們的血肉層層剝落、掉落在地又蠕動著長出新的胚胎。\n他們向你伸出手、邀請你加入血肉與新生的狂歡。"
  },
  Event_59588_Name = {
    Text = "舊日的陰影"
  },
  Event_59589_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59589_Desc = {
    Text = "在伸出手前，你忽然想起，你並沒有養過這樣一隻貓。\n你與貓隔著空氣對視，貓對你眨了眨眼。\n貓並不在意你的冷漠，它看起來還是一樣愛你。"
  },
  Event_59589_Name = {
    Text = "貓的誘惑"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "【鑲嵌】選擇1個造物變化為詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "【吞下】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59590_ChoiceDesc3 = {
    Text = "【收起】獲得25黑印"
  },
  Event_59590_Desc = {
    Text = "體內三大質體的力量正在交融，你艱難地駕馭著這股龐大的力量。\n精神空間不斷膨脹，一條銀河在此誕生、擴散。\n面對源源不斷的敵人，你由衷地向這片星空祈禱，許願這力量的幫助。\n一顆星星從銀河中墜落到你的手心，散發著誘人的光芒。"
  },
  Event_59590_Name = {Text = "許願星"},
  Event_59591_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59591_Desc = {
    Text = "你也以沉默相對，你們沒有交流，沉默是一切的答案。\n你已經準備好面對一切。"
  },
  Event_59591_Name = {
    Text = "祂的質問"
  },
  Event_59592_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59592_Desc = {
    Text = "那只貓是個騙子嗎？\n你開始懷疑那雙池水一樣的藍眼睛，耳畔的笑聲不停迴蕩。\n“騙子，騙子，你被騙了！”\n你內心湧出一股擔憂。"
  },
  Event_59593_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59593_Desc = {
    Text = "你彷彿一個旁觀者，默默觀看著漸漸陌生的情緒。\n你剋制了一切留戀的欲望，感受著自己的靈魂逐漸變得冰冷。\n這是你的命運，這是你的必經之路。"
  },
  Event_59593_Name = {
    Text = "情感結晶"
  },
  Event_59594_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59594_Desc = {
    Text = "那張笑臉無動於衷，你無法用理性或感性的溝通打動他。\n人類的一切欲求與他無關。\n你的話語能超越人類的想像嗎？"
  },
  Event_59594_Name = {
    Text = "瘋狂的紳士"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "【應答】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59595_ChoiceDesc2 = {
    Text = "【沉默】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_59595_Desc = {
    Text = "無數的泡泡好像無數隻圓圓的眼睛，祂沉默地看著你，彷彿無聲的質問。\n你準備好了嗎？\n準備好放棄一切了嗎？\n準備好承擔一切了嗎？"
  },
  Event_59595_Name = {
    Text = "祂的質問"
  },
  Event_59596_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59596_Desc = {
    Text = "在對方發動攻擊的刹那，你立刻展開了回擊。\n你明智地辨明瞭他們真正的面目，這本就是一群亮出獠牙的野獸。\n你幸運地勝利了。\n現在努力逃亡吧，千萬不要被他們抓到。"
  },
  Event_59596_Name = {
    Text = "沉入深淵"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "【尋找答案】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "【放棄】離開"
  },
  Event_59597_Desc = {
    Text = "你該怎麼辦？\n你看向無數個自己，無數張與你相同的面孔注視著你，他們的嘴一張一合。\n彷彿抓住了希望的稻草，你努力搜尋著、聆聽著，期許能獲得最終的答案。"
  },
  Event_59597_Name = {
    Text = "我的自問"
  },
  Event_59598_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59598_Desc = {
    Text = "時機未到，你需要隱忍等候。\n你咽下不甘與仇恨，等待著孤注一擲的那一刻。"
  },
  Event_59598_Name = {
    Text = "被操縱的雙手"
  },
  Event_59599_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59599_Desc = {
    Text = "你感到某種冥冥中的吸引，你想要看清那些目光的源頭。\n你癡迷地望向虛空，感到自己彷彿看到了什麼。\n視線一瞬間被雪花般的模糊覆蓋，眼中的世界好像有什麼地方變得不同。\n你揉了揉眼睛，發現眼角流出兩行血淚。"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "【努力回想】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59600_ChoiceDesc2 = {
    Text = "【品味悲傷】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59600_ChoiceDesc3 = {
    Text = "【默默接受】獲得25黑印"
  },
  Event_59600_Desc = {
    Text = "如同經歷了最精密的腦部手術，你清晰地感覺到一段段珍藏的記憶正在從你的腦海中抽離，你的大腦變得一片模糊，彷彿快要融化。\n你痛苦地顫抖著，按住自己想要阻止的手。\n晶瑩的眼淚從眼眶流下，可是，它們是為什麼而流的呢？\n你好像有些想不起來了。\n你莫名感到十分悲傷。"
  },
  Event_59600_Name = {
    Text = "記憶解離"
  },
  Event_59601_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59601_Desc = {
    Text = "你與貓的情誼不容置疑，揮了揮手，你頭也不回地繼續前進。\n“蠢貨！蠢貨！”\n耳畔的聲音氣急敗壞。"
  },
  Event_59602_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59602_Desc = {
    Text = "你下定決心，無論付出怎樣的代價，你都要帶著大家的希望戰鬥到最後一刻。"
  },
  Event_59602_Name = {
    Text = "未來定格"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "【剋制】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "【注視】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59603_Desc = {
    Text = "塔薇守護的大門後是無盡的世界與無盡的真理。\n你不知道她在門後看到了什麼，但你知道她知曉一切。\n現在這扇門在你面前洞開，所有的真相在門扉之後發出無聲的邀請。"
  },
  Event_59603_Name = {
    Text = "門扉之後"
  },
  Event_59604_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59604_Desc = {
    Text = "對於未知的存在應心懷敬意，避其鋒芒是謹慎的選擇。\n你低下頭，握緊了胸口的銀鑰匙，感到稍稍安慰。\n至少你還有力量，還有喚醒體們。\n你努力忽視那些目光，專注於眼前的路。\n但那些目光真的消失了嗎？你心知肚明。"
  },
  Event_59605_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59605_Desc = {
    Text = "如果一切對抗神明的手段都是蚍蜉撼樹，你唯一能夠堅持的只有不放棄的勇氣。\n當無盡的毀滅從天穹壓來，你會成為頂在最前面的那個。"
  },
  Event_59606_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59606_Desc = {
    Text = "你怔愣地觸摸著不斷流下的淚滴，仔細回味著那股不知來處的悲傷。\n好像有許多非常珍貴的東西被你親手丟掉了，但你已經想不起那是什麼。\n真是遺憾啊。\n你無力地擦拭著淚水，在眼淚中露出一個苦澀的微笑。"
  },
  Event_59606_Name = {
    Text = "記憶解離"
  },
  Event_59607_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59607_Desc = {
    Text = "你無視了他們的聲音。\n你不在乎貓是否是騙子，你只相信自己的力量。\n耳畔的聲音歎息起來。"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "【尋找答案】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "【放棄】離開"
  },
  Event_59608_Desc = {
    Text = "有人癲狂大笑。\n那個自己認定一切都是無用的掙扎，不如儘早放棄。\n你皺起眉頭，那個自己忽然微笑轉身，TA說不如親手結束眾人的生命，好過讓人們經歷痛苦。\n你揮手驅離了那陣聲音，堅定著自己的信念。"
  },
  Event_59608_Name = {
    Text = "我的自問"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "【追問】刪除2張卡牌"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "【戳破】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59609_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_59609_Desc = {
    Text = "漫長的等待中，你再一次打開了聯絡器，或許是你的思念與祈禱有了作用，你看見回信的紙張上不斷湧出她熟悉而親切的回應。\n她現在非常安全，師長們早有安排，彌薩格的運轉一切順利……\n你看著雪花一樣飛來的好消息，心中忍不住一動。"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "【捕捉星星】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "【捏碎星星】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_59610_ChoiceDesc3 = {
    Text = "【沉默觀看】獲得25黑印"
  },
  Event_59610_Desc = {
    Text = "你的情緒隨著記憶一同被剝離，你感到自己正在成為某種龐大的存在，像是怪物回到了它遠古的、溫暖的巢穴。\n無數的喜怒哀樂濃縮，化為一顆顆閃亮的星星，在你的精神維度下起了光亮的雨。\n你生存過的痕跡化為流星消逝。\n你靜默地注視著，拾起一顆面前的星星，那裡面傳來你開懷的笑聲。\n於是你也一起笑了，你甘之如飴。"
  },
  Event_59610_Name = {
    Text = "情感結晶"
  },
  Event_59611_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59611_Desc = {
    Text = "你知道這些不過是過去的殘影，你面無表情地屠殺著曾經與你暢談的人們。\n他們的笑與淚在你的手中破碎，你不能有絲毫停頓。\n如果這是必要的考驗，你會充當最無情劊子手。"
  },
  Event_59611_Name = {
    Text = "舊日的陰影"
  },
  Event_59612_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59612_Desc = {
    Text = "它柔軟的毛皮與清澈的雙眼天然讓你感到信任。\n你走近貓，貓也走近了你。\n你們互相沒有言語，但它的尾巴高高豎起。"
  },
  Event_59612_Name = {
    Text = "貓的誘惑"
  },
  Event_59613_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59613_Desc = {
    Text = "你剋制住了好奇的衝動，你知道這扇門不應該開啟。\n太多的真實有時是一種詛咒。\n你握緊了胸口的銀鑰匙，決心將這扇門永遠關上。"
  },
  Event_59613_Name = {
    Text = "門扉之後"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "【勇氣】隨機升級2張卡牌的刻印效果"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "【決心】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59614_Desc = {
    Text = "塔薇的話語迴蕩在你的腦海。\n無數結局中唯有一條是正確的道路。\n恍惚中你看到許多世界的虛影在你眼前如同膠捲的片段般閃過，等待著按下按鈕定格的那一刻。\n這一秒過後，世界究竟會迎來怎樣的結局？"
  },
  Event_59614_Name = {
    Text = "未來定格"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "【忽視懷疑】獲得50黑印"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "【獨斷專行】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_59615_Desc = {
    Text = "隨著N的嘲笑，你開始懷疑起見過的所有人。\n到底哪些是他的化身，哪些是你真心的師友？\n他的影子不停變幻，那其中好像有無數面孔，正衝著你咧開嘴角。"
  },
  Event_59615_Name = {
    Text = "影子的一百張面孔"
  },
  Event_59616_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59616_Desc = {
    Text = "如果所有人都有可能背叛，那麼就不要依賴任何人。\n在黑暗之中，你只能確認唯一的真實。\n起碼你還有自己——最忠誠的自己可以信任。"
  },
  Event_59616_Name = {
    Text = "影子的一百張面孔"
  },
  Event_59617_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59617_Desc = {
    Text = "你用力一捏，閃耀的晶石在你的指尖破碎成粉末。\n你貪婪地吸入那些來自過去的情緒。\n一瞬之間濃郁的快樂衝入你的大腦，而後幻覺一般緩緩消散。\n你的嘴角隨之高高翹起，而後慢慢落下。\n你的面龐逐漸平靜無波。"
  },
  Event_59617_Name = {
    Text = "情感結晶"
  },
  Event_59618_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59618_Desc = {
    Text = "你知道一切都有代價，如果拯救的代價註定是犧牲，那麼就讓這份代價全部由自己支付。\n你準備好了隨時付出全部。"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "【尋找答案】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "【放棄】離開"
  },
  Event_59619_Desc = {
    Text = "有人在呐喊。\n那個自己急切地想要逃跑，TA說對抗註定著失敗。\n只有永無止境的逃亡才能夠延緩最終的湮滅。\n你將信將疑。"
  },
  Event_59619_Name = {
    Text = "我的自問"
  },
  Event_59620_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59620_Desc = {
    Text = "你知道那些胚胎繁殖速度的可怖，新生在這裡是蝗蟲一般的詛咒。\n你在那些新生兒發出啼哭前就將它們碾碎。\n血肉組成的人們怨毒地看著你，質問你為何褻瀆神聖的生命。\n你以無盡的殺戮回應。"
  },
  Event_59620_Name = {
    Text = "舊日的陰影"
  },
  Event_59621_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59621_Desc = {
    Text = "此時此刻你希望自己會是最幸運的人，能夠得到最圓滿的結局。\n但好運的代價有時更加殘酷，幸運與不幸往往相伴而生，當你得到的那一刻，別忘了檢查失去了什麼。"
  },
  Event_59621_Name = {
    Text = "命運抉擇"
  },
  Event_59622_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59622_Desc = {
    Text = "你彷彿在與人爭搶同一輛汽車的方向盤，你的雙手全力飛舞，試圖掌控樂曲的節奏。\n在艱難的對抗中，你突然重重地按下一排琴鍵。\n狂亂的彈奏被你打亂，你咧開嘴角，陷入瘋狂與更加瘋狂的對抗。"
  },
  Event_59622_Name = {
    Text = "末日狂歡曲"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "【親近】獲得25黑印"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "【注視】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_59623_Desc = {
    Text = "你身旁跟著一隻貓，它的毛髮順滑潔淨，它的前爪是踏雪一樣的白色。\n貓始終陪伴在你左右，亦步亦趨，像是你最忠誠的僕人。\n你心中一切迷茫與無助、痛苦與不安都被撫平了。"
  },
  Event_59623_Name = {
    Text = "貓的誘惑"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "【否定】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_59624_ChoiceDesc2 = {
    Text = "【辯駁】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_59624_ChoiceDesc3 = {
    Text = "【沉默】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_59624_Desc = {
    Text = "你陷入某種虛無的幻境。\n你看到無數的人們在末日的陰影下沉默，渺小如灰塵。\n他們呆滯，灰暗，失去希望。\n你聽到某人尖銳的笑聲。\n“看吧，這就是你們堅持的結果。”\n“世界從來就沒有結局，一切的一切都沒有意義。”"
  },
  Event_59625_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59625_Desc = {
    Text = "不，這不對，這不是真實的。\n你不停否定著那瘋狂的聲音，然而灰暗的人影無動於衷，彷彿印證著虛無的結局。\n那笑聲越來越大，嘲諷著你的無力。"
  },
  Event_59626_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59626_Desc = {
    Text = "你感到一股巨大的遺憾和不舍，你下意識拼命回想著，試圖在記憶的碎片中尋找過去的影子。\n那些模糊的倒影飛速向後退去，你努力想要伸手抓住，卻只能看到那些影像從指間流逝。\n你意識到，你即將一無所有。"
  },
  Event_59626_Name = {
    Text = "記憶解離"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "【親近】獲得25黑印"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "【注視】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_59627_Desc = {
    Text = "你身旁跟著一隻貓，它的毛髮順滑潔淨，它的前爪是踏雪一樣的白色。\n貓始終陪伴在你左右，亦步亦趨，像是你最忠誠的僕人。\n你心中一切迷茫與無助、痛苦與不安都被撫平了。"
  },
  Event_59627_Name = {
    Text = "貓的誘惑"
  },
  Event_59628_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59628_Desc = {
    Text = "你與最終的你在此相見，毀滅整個世界的戰鬥其實只是你們目光的對視。\n當祂看向你，你必須堅定地直視祂，直到其中一道目光消失的那刻。"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "【呼吸】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59629_ChoiceDesc2 = {
    Text = "【反擊】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_59629_ChoiceDesc3 = {
    Text = "【掙扎】獲得25黑印"
  },
  Event_59629_Desc = {
    Text = "密集的腳步聲響起，一群審查會的探員攔住了你的去路。\n“請配合我們的調查。”\n冷漠的聲音隱含惡意。\n撲通一聲，平靜的水面被打破，他們將你投入深潭。"
  },
  Event_59629_Name = {
    Text = "沉入深淵"
  },
  Event_59630_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59630_Desc = {
    Text = "你拼命掙扎。\n向前，再向前一點。\n無論要付出什麼代價，你一定要守護這一切。\n你努力伸出手，絲線切入你的皮肉，你渾然不覺。"
  },
  Event_59630_Name = {
    Text = "被操縱的雙手"
  },
  Event_59631_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59631_Desc = {
    Text = "你用力搖晃腦袋，將紛亂的記憶從大腦裡甩出。\n很快嘈雜的聲音逐漸消失，你的意識終於恢復了獨立。\n你無法從失敗的過去中獲得幫助，只有專注當下才能找到希望。"
  },
  Event_59631_Name = {
    Text = "我的自問"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_59632_Desc = {
    Text = "在伸出手前，你忽然想起，你並沒有養過這樣一隻貓。\n你與貓隔著空氣對視，貓對你眨了眨眼。\n貓並不在意你的冷漠，它看起來還是一樣愛你。"
  },
  Event_59632_Name = {
    Text = "貓的誘惑"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "【尋找答案】獲得Arg1黑印，感染「(Skill.Arg2)」"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "【放棄】離開"
  },
  Event_59633_Desc = {
    Text = "有人悲傷流淚。\n那個自己滿目悲愴，想要擁抱最愛的人。\n毀滅之時沒能和在乎的人們在一起是TA最大的遺憾。\n你心頭一痛，忍不住一起悲傷起來。"
  },
  Event_59633_Name = {
    Text = "我的自問"
  },
  Event_59634_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59634_Desc = {
    Text = "你望著無數灰色的人影，對那嘲諷的笑聲置之不理。\n要怎麼才能拯救崩塌的世界？\n你在沉默的滅亡中不停思考。"
  },
  Event_59635_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59635_Desc = {
    Text = "肺泡中的空氣逐漸消失，你嘗試在水下呼吸。\n多麼愚蠢的行為，但你成功了。\n你的肺泡重新充盈，你可以暢快地吐息。\n但你不斷吸入的到底什麼呢？"
  },
  Event_59635_Name = {
    Text = "沉入深淵"
  },
  Event_59636_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59636_Desc = {
    Text = "你沉入了黏稠的液體。\n儘管你極力掙動，卻只是越陷越深。\n你無法獨自逃離這片泥沼。"
  },
  Event_59636_Name = {
    Text = "沉入深淵"
  },
  Event_59637_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59637_Desc = {
    Text = "你強迫自己遺忘掉這些懷疑。\n你知道此刻懷疑是最沒有用處的，你只能儘量相信。\n在密封的盒子揭開之前，你無從得知盒子內的真相。\n有些時候，做一個糊塗的傻子更容易獲得安寧。"
  },
  Event_59637_Name = {
    Text = "影子的一百張面孔"
  },
  Event_59638_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59638_Desc = {
    Text = "大家的目光聚集在你身上，你必須作為所有人的領袖，不能流露出任何脆弱。\n“前往黑池，一切都會好起來的。”\n你鎮定地發出指令，許下自己也未必相信的諾言。"
  },
  Event_59638_Name = {
    Text = "無知之目"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "【懷疑】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_59639_ChoiceDesc2 = {
    Text = "【不屑】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_59639_ChoiceDesc3 = {
    Text = "【無視】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_59639_Desc = {
    Text = "面前有三個彷徨的人影，他們口中絮絮呢喃著什麼。\n你將耳朵湊近去聽，吐字的聲音與氣息一同變得清晰。\n“不要相信那只貓，它是個騙子。”\n你猛地回過頭，卻發現身旁空無一人。"
  },
  Event_59640_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59640_Desc = {
    Text = "星星看起來是如此可口，你覬覦它的力量，將它一口吞下。\n咕咚。\n你感到精神前所未有的充盈，有種光芒在你的餘光裡閃耀。\n低頭看去，星星仍在你的胃袋中發光。"
  },
  Event_59640_Name = {Text = "許願星"},
  Event_59641_ChoiceDesc1 = {
    Text = "【掙扎向前】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "【扯斷絲線】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "【隱忍不發】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59641_Desc = {
    Text = "一路上你被推著前進，你的所有選擇都被無形的絲線操縱著。\n你努力掙動雙手，想要抓住在意的一切。\n世界的命運懸掛在你指尖之前。\n無數絲線纏繞而來，束縛住你的全身。"
  },
  Event_59641_Name = {
    Text = "被操縱的雙手"
  },
  Event_59642_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59642_Desc = {
    Text = "你擦掉眼角的血淚，無數的血淚又不斷流下。\n紅色彌漫你的視野，彷彿預示著血腥的犧牲。\n你不斷擦拭著，痛苦使你顫抖，但不能使你有一絲畏懼。"
  },
  Event_59643_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59643_Desc = {
    Text = "你摩挲著這塊神奇的寶石，將它鑲嵌到了銀鑰匙上。\n星星的光芒照耀著你。\n你目眩神迷。"
  },
  Event_59643_Name = {Text = "許願星"},
  Event_59644_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59644_Desc = {
    Text = "你不管不顧，始終睜著眼，心中的堅持化為倔強的怒吼。\n哪怕會破碎消散，你也不會退縮半步。"
  },
  Event_59645_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59645_Desc = {
    Text = "有人沉默不語。\n看著那個自己絕望沉默的面孔，你知道他們都沒有走到最後。\n你是所有自己中走得最遠的一個，只有你自己的答案才是最後的希望。"
  },
  Event_59645_Name = {
    Text = "我的自問"
  },
  Event_59646_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59646_Desc = {
    Text = "你伸出手，從無數顆流星中不斷抓握著，閃耀的晶石劃過你的指尖。\n快樂、悲傷、憤怒、恐懼……\n你貪婪地攫取著每一縷情緒，又眼睜睜看著它們從你的手中消失。\n絢麗的光芒照耀著你的臉，你的眼瞳逐漸變得漆黑而幽深。"
  },
  Event_59646_Name = {
    Text = "情感結晶"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "【呼喚】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "【觸碰】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59657_Desc = {
    Text = "你目睹人偶陷入崩潰。\n她曾是最理性的存在，也是最忠誠的助手，認真保管你們獲得的一切資訊。\n而現在她似乎已不再記得你們相處的所有。\n你看到人偶的眼角滴落晶瑩的液體。"
  },
  Event_59657_Name = {
    Text = "人偶的眼淚"
  },
  Event_59658_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59658_Desc = {
    Text = "你沒有死心，試圖接觸她的能源核心。\n只要是機械，重新啟動一定能修好的吧。\n可惜無情的人偶並沒有給你天真的機會。\n你的留手並沒有換來人偶的手下留情，你只好全力戰鬥。"
  },
  Event_59658_Name = {
    Text = "人偶的眼淚"
  },
  Event_59659_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_59659_Desc = {
    Text = "你並不想損毀曾經的夥伴。\n你拼命呼喚她的名字，報出所有的指令，然而毫無作用。\n人偶背叛了你們，回歸了無機物的冰冷。"
  },
  Event_59659_Name = {
    Text = "人偶的眼淚"
  },
  Event_60944_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60944_Desc = {
    Text = "留給你的時間不多，你選擇了最為直接的處理方式，闖過了封鎖。喚醒體們受到激勵，也變得興奮起來。\n至於變得更加警覺的敵人，不足為慮。"
  },
  Event_60944_Name = {
    Text = "審查會探員"
  },
  Event_60945_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60945_Desc = {
    Text = "在那名探員反應過來之前，你們繞到他的背後，收繳了他的武器。在增援趕到之前，你們成功離開了這裡。\n遺憾的是消息已經傳開，後面的敵人有了準備，或許會變得更加難以應對。做好準備。"
  },
  Event_60945_Name = {
    Text = "審查會探員"
  },
  Event_60946_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60946_Desc = {
    Text = "探員被一陣口哨聲吸引，向你們的藏身之處走來。在他靠近的一瞬間，等待已久的喚醒體們一起發起了攻擊。\n一次完美的伏擊，這裡的危機被永遠地解決了。"
  },
  Event_60946_Name = {
    Text = "審查會探員"
  },
  Event_60947_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60947_Desc = {
    Text = "面對人數眾多的敵人，你無法與他們抗衡。你主動走入他們的視野中，並沒有進行抵抗。\n你知道，你們即將被送往羈押點，這正是計劃的一環。\n你們將從那裡逃離，尋找新的路徑。"
  },
  Event_60947_Name = {Text = "監察點"},
  Event_60948_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60948_Desc = {
    Text = "面對人數眾多的敵人，你無法與他們抗衡。短暫地戰鬥後，你們放棄了抵抗。\n你知道，你們即將被送往羈押點，這正是計劃的一環。\n你們將從那裡逃離，尋找新的路徑。"
  },
  Event_60948_Name = {Text = "監察點"},
  Event_60949_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_60949_Desc = {
    Text = "面對人數眾多的敵人，你無法與他們抗衡。\n你選擇暫時離開這裡，尋找新的路徑。"
  },
  Event_60949_Name = {Text = "監察點"},
  Event_61058_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61058_Desc = {
    Text = "你注視著自己的雙手，自己的全身，心中充滿了希望與決心。\n如果這所有都是命運的安排，你已經準備好面對一切。\n在最終的時刻若真有通往天堂或地獄的大門，那麼就由你來為世界親手開啟門扉。"
  },
  Event_61058_Name = {Text = "窺視"},
  Event_61059_ChoiceDesc1 = {
    Text = "【準備迎戰】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "【繼續觀察】感染「(Skill.Arg1)」，重新刻印，最多進行1次"
  },
  Event_61059_Desc = {
    Text = "你沒有急於迎戰，冷靜地嘗試理清現狀。 這個突然出現的指揮家似敵似友，你並不清楚他準備做什麼。 無論如何，你決定做好充分準備，先迎接他的挑戰，再慢慢觀察他到底想要做些什麼。"
  },
  Event_61059_Name = {
    Text = "魔鬼指揮家"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "【聆聽】獲得3選1高級刻印"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "【呼喊】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61060_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_61060_Desc = {
    Text = "自從意外發生後，你再也沒有收到搭檔的消息。\n無數聯絡發出，如同石沉大海毫無回音。\n在你已經不抱希望的時刻，聯絡器突然發出了聲響。\n你打開手提箱，將電話聽筒靠近耳朵。\n“守密人……”\n恍惚中你聽到了那個一直思念的聲音，像是隔著層層虛空遙遠地迴響。"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "【接納黑暗】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61061_ChoiceDesc2 = {
    Text = "【嘗試遊泳】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61061_ChoiceDesc3 = {
    Text = "【呼喊幽靈】獲得25黑印"
  },
  Event_61061_Desc = {
    Text = "你向前奔去，腳下的土地忽然變成一片無法行走的汪洋。\n你墜入土壤。\n如同墓園中的幽靈一起出現，無數粘稠的黑暗包圍了你，貪婪地侵入你的口鼻。"
  },
  Event_61062_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61062_Desc = {
    Text = "你瞪大眼睛，努力搜尋所有的蛛絲馬跡。\n一百隻眼睛同時轉動，你看到身前人面犬奔跑的趾爪，你看到身後哈姆林指揮棒揮舞的軌跡。\n你貪婪地觀察著所有。\n忽然，你看到地上滾落了一隻熟悉的眼球。\n那好像是你自己的眼睛。"
  },
  Event_61062_Name = {
    Text = "求知的貪婪"
  },
  Event_61063_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61063_Desc = {
    Text = "不對，你不可能看到這麼多東西。\n你明明只有……只有幾隻眼睛來著？\n你連忙閉上眼睛，伸手到臉上摸索。\n一、二……\n再睜眼時你的視野重新變得狹窄而無知。\n原來你只有兩隻眼睛啊，可惜，可惜。"
  },
  Event_61063_Name = {
    Text = "求知的貪婪"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "【搜尋】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61064_ChoiceDesc2 = {
    Text = "【閉眼】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61064_Desc = {
    Text = "越來越多的線索線頭一般雜亂地纏成了團，你焦急、迷茫、憤恨，你恨自己為什麼一無所知。\n巨大的壓力讓你的精神繃緊成一條細線。\n嘣的一聲，你感到頭皮忽然放鬆了下來，你忽然能看到周圍全部的景象，看到虛空之中搖曳的陰影。\n更多，你還需要看到更多……"
  },
  Event_61064_Name = {
    Text = "求知的貪婪"
  },
  Event_61065_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61065_Desc = {
    Text = "你在土壤中遊泳，想像自己是最靈活的魚。\n想變成魚，就要捨棄人類的雙腿。\n這是交易的代價。\n很快，你感到前所未有的輕鬆，你成為了地底最自由的存在。\n你遊回了地面，卻已經忘記如何走路。"
  },
  Event_61066_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61066_Desc = {
    Text = "你的指尖碰到銀鑰匙熟悉的觸感，那是所有光芒的核心。\n這是你生命的濃縮，這是你命運的化身。\n過往的經歷一幕幕閃過眼前。\n你的選擇已經與這世界的選擇牢牢綁定。\n你的命運已經與許許多多的人緊緊相連。"
  },
  Event_61066_Name = {Text = "窺視"},
  Event_61067_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61067_Desc = {
    Text = "你感到有許多親切的存在包圍著你。\n你嘗試呼喊那些未必存在的幽靈。\n奇蹟發生，你重新回到地面之上。\n無數的墓碑依然緘默。"
  },
  Event_61068_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61068_Desc = {
    Text = "你沒有時間感慨，你只想儘快拯救這崩塌的一切。\n如果你變成了星星，那就讓你化作流星吧。\n只要能照耀夜空，哪怕終將隕落。"
  },
  Event_61068_Name = {Text = "窺視"},
  Event_61069_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61069_Desc = {
    Text = "你將耳朵貼得更緊，將所有細碎的聲音收入腦袋。\n“我……”\n“你一定……”\n你只能聽見殘缺的字句，無法分辨任何含義。\n但你不敢出聲，生怕錯過任何一個字。\n然而命運沒有給你更多垂憐。\n僅剩的一點聲音也這樣消失了，四周重歸寂靜。"
  },
  Event_61070_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61070_Desc = {
    Text = "你沒有再繼續思考下去，指揮喚醒體們列隊，迎接他的挑戰。"
  },
  Event_61070_Name = {
    Text = "魔鬼指揮家"
  },
  Event_61071_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61071_Desc = {
    Text = "你不斷呼喊著她的名字，試圖傳遞哪怕一絲的心情。\n你不知道她有沒有聽見，你努力辨別話筒中模糊的聲音。\n那好像是她的回應，又好像是無數過去的碎片在循環播放。\n播放著你們共同經歷的悲歡與相遇。"
  },
  Event_61072_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_61072_Desc = {
    Text = "或許這片黑暗才是真實的世界，加入其中有什麼不好？\n你徹底接納了黑暗，黑暗同樣不再排斥你，你能夠自如呼吸。\n下一秒你回到了地面之上，或許有什麼東西永遠留在了地下，但那已經不重要了。"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "【注視光芒】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61073_ChoiceDesc2 = {
    Text = "【觸碰胸口】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "【繼續奔跑】獲得25黑印"
  },
  Event_61073_Desc = {
    Text = "你心中迷茫，只能拼命奔跑，無暇思考許多。\n忽然，你感到胸口空落落。\n你低頭看去，原本心臟的位置出現了一團鑰匙形狀的光芒。\n那光芒越來越亮，逐漸蔓延到你的全身。\n你看到自己化為了一顆星星。\n你忽然明白，或許這就是你一直以來的使命。"
  },
  Event_61073_Name = {Text = "窺視"},
  Event_61074_ChoiceDesc1 = {
    Text = "【準備迎戰】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "【仔細觀察】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_61074_Desc = {
    Text = "「喂……等等！什麼情況……」\n「排練。」\n男子面無表情地看著你。\n「用樂聲維持喚醒體連結，是一個新的嘗試。確保樂團的水準，才能確保演出的完美。」\n他抬起的指揮棒清晰揮下，在空中劃出一道優雅的起奏符。\n「演奏吧，守密人。讓我看看，你能做到些什麼。」"
  },
  Event_61074_Name = {
    Text = "魔鬼指揮家"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "【準備迎戰】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61075_Desc = {
    Text = "無論他有什麼目的，至少是他將你從審查會的圍攻下救了出來。如果他想要對你不利，根本就沒有必要幫助你。 你冷靜下來，做好了最後的準備。"
  },
  Event_61075_Name = {
    Text = "魔鬼指揮家"
  },
  Event_65400_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65400_Desc = {
    Text = "聯絡員傳達了外界對你們實施援救的承諾，聽到救援隊已經在想辦法進山，所有人心中重新燃起了希望。"
  },
  Event_65400_Name = {Text = "聯絡處"},
  Event_65401_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65401_Desc = {
    Text = "所有科考團的成員沒有一人走出雪山，在災難面前，你永遠只選擇自己，普通人的性命在你眼中一文不值，你捨棄了人性，安全走到了最後。\n救援人員複雜地看著你，你無動於衷，回頭走進了風雪之中。或許在午夜夢迴時，那些因為你的冷漠而喪命的亡魂會圍繞在你的床前，默默地注視著你。"
  },
  Event_65401_Name = {
    Text = "安全撤離點"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "【民眾撤離】移除造物「科考團」，根據科考團人數，獲得不同等級的「救難勳章」。"
  },
  Event_65402_Desc = {
    Text = "你將科考團安全送達了撤離點，救援隊接管了一切，獲救的人們癱倒在地，恍如隔世。\n然而你知道，真正的危機遠遠沒有解決，那只巨獸仍然盤踞在群山之中，饑腸轆轆地等待著你們。"
  },
  Event_65402_Name = {
    Text = "安全撤離點"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "【補給兌換】獲得 25 個黑印，每有 1 名科考團員額外獲得 1 個黑印（Arg1）。"
  },
  Event_65403_ChoiceDesc2 = {
    Text = "【援救承諾】選擇獲得 1 個刻印。補充 2 個科考團人員。"
  },
  Event_65403_ChoiceDesc3 = {
    Text = "【效益至上】失去 10 名科考團員，選擇獲得一個黃金+造物。"
  },
  Event_65403_Desc = {
    Text = "你們在風雪中艱難跋涉，追隨著遠方應急聯絡處忽明忽滅的燈光。\n    ○ 終於，在第無數次祈禱後，你們看見了那座蘊藏希望的小屋。"
  },
  Event_65403_Name = {Text = "聯絡處"},
  Event_65403_Tips3 = {
    Text = "科考團人數不足"
  },
  Event_65404_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65404_Desc = {
    Text = "你們從聯絡員口中得知了聯絡處倉庫的密碼，並在其中找到了所有人兩天份的物資，恭喜你們至少不會在雪山中饑寒而死了。"
  },
  Event_65404_Name = {Text = "聯絡處"},
  Event_65415_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_65415_Desc = {
    Text = "雪山瞬間完成了進食，有兩個人永遠消失在了深不見底的冰縫中，而你們對此一無所知。"
  },
  Event_65416_ChoiceDesc1 = {
    Text = "【離開】尋找探照燈"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "【闖入大雪】損失 2 名科考團員。"
  },
  Event_65416_Desc = {
    Text = "雪山上忽然掛起一陣狂風，耳畔呼嘯的風聲彷彿是巨獸的尖嘯，白茫茫的雪霧一瞬迷住了你們的眼睛，似乎有什麼東西在無盡的白霧中穿行。\n你們被迫停住了腳步，努力將雙腿深深紮進積雪，以防自己滾下山坡。"
  },
  Event_65417_ChoiceDesc1 = {
    Text = "【無聲蒸發】損失 2 名科考團員。"
  },
  Event_65417_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_65417_Desc = {
    Text = "雪山的腹部傳來轟隆隆的怒吼，如饑餓的野獸發出不滿的咆哮，大地顫動，積雪下的冰層悄然開裂，像是雪山咧開了嘴巴。\n當大地的震顫終於停止，人們茫然四顧，你回過頭查看隊伍。"
  },
  Event_65468_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65468_Desc = {
    Text = "為了保證隊伍的行動力，你放棄了行動艱難的那部分人，將他們留在了這座孤立的小屋中。這或許能夠提高剩餘人員的存活率，但看著那些不甘怨恨的眼神，你的內心完全沒有波動嗎？"
  },
  Event_65468_Name = {Text = "聯絡處"},
  Event_65483_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65483_Desc = {
    Text = "你救下了一些人，但更多的人永遠留在了雪山，不管怎麼說，你至少盡了力。\n救援人員表示你的貢獻隨後將被表彰，你揮了揮手，回頭走進了風雪之中。"
  },
  Event_65483_Name = {
    Text = "安全撤離點"
  },
  Event_65484_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65484_Desc = {
    Text = "你無暇他顧，為了走出雪山，採取了效益最大的方式，在最後的倖存者眼裡，你或許形同惡魔。\n救援人員表示你的貢獻隨後將被表彰，你揮了揮手，回頭走進了風雪之中。"
  },
  Event_65484_Name = {
    Text = "安全撤離點"
  },
  Event_65485_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65485_Desc = {
    Text = "在你不遺餘力的保護下，科考團全員毫無傷亡，遇到你是他們不幸中最大的幸運，你是他們貨真價實的救世主。\n你創造了災難中的奇蹟，關於雪山英雄的傳聞或許很快就要傳播四方。救援人員鄭重表示你的卓越貢獻隨後將被表彰，你笑著揮了揮手，回頭走進了風雪之中。"
  },
  Event_65485_Name = {
    Text = "安全撤離點"
  },
  Event_65486_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65486_Desc = {
    Text = "你真切地在乎著人們的生命，大部分人被你挽救，人們痛哭流涕，不停感謝著你的一路保護。\n救援人員鄭重表示你的傑出貢獻隨後將被表彰，你笑著揮了揮手，回頭走進了風雪之中。"
  },
  Event_65486_Name = {
    Text = "安全撤離點"
  },
  Event_65487_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_65487_Desc = {
    Text = "你與無常的災難抗衡，並將人們從死神手中搶回，經過你的努力，悲劇的結局稍稍發生了偏移。\n救援人員鄭重表示你的寶貴貢獻隨後將被表彰，你笑著揮了揮手，回頭走進了風雪之中。"
  },
  Event_65487_Name = {
    Text = "安全撤離點"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "【適可而止】獲得3選1刻印"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "【堅持閱讀】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6817_Desc = {
    Text = "在木質書架的最高處，擺放著一本金黃色封面的書冊。從地面的視角看不見書的名字。\n不知為何，你產生了閱讀它的渴望……這種渴望在轉瞬之間就膨脹到難以遏制，你不顧驚動他人的風險，踏上書架旁的木梯，取下了那本書，急不可耐地閱讀起來……\n朦朧的印象在你的思維之海中升起，你沉沒在幻象的海洋之中……"
  },
  Event_6817_Name = {
    Text = "黃色書卷"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "【聆聽】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6818_ChoiceDesc2 = {
    Text = "【合奏】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_6818_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_6818_Desc = {
    Text = "琴聲是突然傳到你耳中的。幽綠的手指在琴鍵上跳躍，優雅的聲音如同溪水般流淌。\n「親愛的朋友，想跟我和奏一曲嗎？」\n手不會說話，它用琴聲向你問道。"
  },
  Event_6818_Name = {
    Text = "琴邊幽靈"
  },
  Event_6819_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6819_Desc = {
    Text = "拉蒙娜望向聲音的來源，卻只來得及看到一個逐漸消散的幻影，看上去像是融在牆上的留聲機。"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "【清理打字機】刪除1張指令卡，獲得25黑印"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "【嘗試辨識文字】複製一張牌庫中的牌，感染「(Skill.Arg1)」"
  },
  Event_6820_Desc = {
    Text = "手提箱中的打字機突然噴薄出稠厚的濃墨，伴隨著列車的搖晃飛濺成線性的流瀑。"
  },
  Event_6820_Name = {
    Text = "打字機的低語"
  },
  Event_6821_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6821_Desc = {
    Text = "在拳頭揮散幻影的刹那，記憶猛地衝進你的大腦，回憶一段段撞擊著靈魂，生悶發痛。"
  },
  Event_6821_Name = {
    Text = "海市蜃樓"
  },
  Event_6822_ChoiceDesc1 = {
    Text = "【扔掉信紙】刪除1張卡牌"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "【貼身放好】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6822_Desc = {
    Text = "將幾張捲入打字機中的信紙抽出，洇開的字體散發著濃郁的油墨香氣，你掃視過信件的內容，下意識皺起了眉。\n信件的內容大多被塗抹掉了，僅剩的那些也都字不成句，沒剩下什麼可讀的。"
  },
  Event_6822_Name = {
    Text = "塗字信件"
  },
  Event_6823_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6823_Desc = {
    Text = "你努力辨認紙上模糊的字跡。它們不斷扭曲，隨後顯現出截然不同的內容。\n「@2我想你應該從報紙上看到那則消息了。\n是的，你的父親已經將你從繼承人順位中剔除……我們也不願意@2\n魔鬼，魔鬼……\n請立刻停止與那位赫伯特先生的交往，否則我會停止對你的經濟援助……」"
  },
  Event_6823_Name = {
    Text = "見字如晤"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "【握住銀鑰】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6824_ChoiceDesc2 = {
    Text = "【閉上雙眼】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6824_Desc = {
    Text = "你被一陣巨大的荒誕撕扯著，肢體扭曲地爬行於地面，彷彿被來自維度以外的@2操縱。\n「不……不……」\n你的理智寸寸垮塌，神志不清的獰笑和尖叫交織，如一道巨網縛住你的意識，溢到嘴邊的只有含混不清的哀鳴。"
  },
  Event_6825_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6825_Desc = {
    Text = "將它交給守密人處置吧，不知會喚醒怎樣的個體。"
  },
  Event_6825_Name = {
    Text = "孤獨銀芯"
  },
  Event_6826_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6826_Desc = {
    Text = "悲傷的小調流淌耳畔，苦悶與疼痛充斥著大腦與靈魂。在反應過來時，某人的眼角已然濕潤。"
  },
  Event_6826_Name = {
    Text = "無名之音"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "【推開左側的門】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "【推開右側的門】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6827_Desc = {
    Text = "門。門。無數扇門。\n門的數量似乎比你和拉蒙娜巡視時要多出不少。\n你們在走廊上站定，準備推開下一扇門。\n左側的門後寂靜無聲，含蓄剋制地等待著你們的光臨。\n右側的門後傳出含混不清的交談聲。"
  },
  Event_6827_Name = {
    Text = "無限之門"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "【側耳聆聽】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6828_ChoiceDesc2 = {
    Text = "【堵住耳朵】獲得3選1刻印"
  },
  Event_6828_Desc = {
    Text = "你只能聽見狂亂的琴鍵敲擊聲，如暴風驟雨般侵襲而來，如隕石砸在地面上的震響，整架琴都隨之戰慄。\n擊弦的木槌在吱呀亂叫，亂跳的踏板溢出沉痛的悲鳴。\n在詭譎的樂聲中，熟悉的音律被裹挾著，剮蹭過你的耳膜。"
  },
  Event_6829_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6829_Desc = {
    Text = "「威廉調查員已為您提供緊急物資輸送，請於查收後敲擊三次胸針確認。」"
  },
  Event_6829_Name = {
    Text = "支援通訊"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "【推開左側的門】獲得3選1刻印"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "【推開右側的門】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6830_Desc = {
    Text = "門。門。無數扇門。\n門的數量似乎比你和拉蒙娜巡視時要多出不少。\n你們在走廊上站定，準備推開下一扇門。\n左側的門後寂靜無聲，含蓄剋制地等待著你們的光臨。\n右側的門後傳出含混不清的交談聲。"
  },
  Event_6830_Name = {
    Text = "無盡門扉"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "【閱讀書信】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "【關好箱子】"
  },
  Event_6831_Desc = {
    Text = "手提箱震顫不止，宛如某種生命正撕咬著蛋殼，即將破繭而出。\n你不受控制地打開箱子，信紙如放飛的蝴蝶般四散噴湧。"
  },
  Event_6831_Name = {
    Text = "不速來信"
  },
  Event_6832_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6832_Desc = {
    Text = "急促的鈴聲惹人心焦，你拿起聽筒擱在桌面上。鈴聲像被掐住了脖子般猝然中斷，只留下腦海中殘留的迴響。"
  },
  Event_6832_Name = {
    Text = "列車來電"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "【檢查膠捲】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，可以使用兩次"
  },
  Event_6833_Desc = {
    Text = "工作室的角落放著一台老舊的相機、幾卷膠片和零星散落的照片。 它們忠實地記錄著蠟像師的工作與美學。"
  },
  Event_6833_Name = {
    Text = "如實記錄"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "【繼續盤問】提升 Arg1 點最大生命"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "【抓住影子】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6834_Desc = {
    Text = "影子在金色塵埃中誦念：\n「那些知曉真理的……\n以鑰匙為權柄，必將指引世人道路。」\n這是一句古老的箴言。\n直覺告訴你，它離你尋找的真相很近很近。\n而你的直覺一向很准。"
  },
  Event_6834_Name = {Text = "銀鑰使"},
  Event_6835_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6835_Desc = {
    Text = "你毫不掩飾自己對癡狂囈語的認同，在對方癲狂的誘惑下，你差點被綁上了那位存在的餐桌。"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "【呼喚烏鴉】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_6836_Desc = {
    Text = "你不離去，它們也不曾離開。\n奇異的繩索將你們的精神相連，它們似乎有什麼話想要和你說。"
  },
  Event_6836_Name = {
    Text = "離群之鴉"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "【放棄抵抗】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "【抽回雙手】"
  },
  Event_6837_Desc = {
    Text = "一隻、兩隻、三隻……\n臉上、手指上，成群的蝴蝶像是空中綻放的煙花，在黑暗中閃動著寶石般的光芒。\n這台打字機沒有任何實際功用，但它對創造美卻很在行。"
  },
  Event_6837_Name = {
    Text = "靈感迸發"
  },
  Event_6838_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6838_Desc = {
    Text = "更重要的事情就在你面前，你合上箱子打定主意不去理會，而打字機也漸漸沉默。"
  },
  Event_6838_Name = {
    Text = "不請自來的警告"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "【聆聽月亮】感染「(Skill.Arg1)」"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "【聆聽矮星】感染「(Skill.Arg1)」"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "【聆聽流星】失去25黑印"
  },
  Event_6839_Desc = {
    Text = "熱烈，明亮，永不落幕。"
  },
  Event_6840_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6840_Desc = {
    Text = "光輝的中心是一滴固化的銀芯，可理智告訴你，它並沒有發光。\n視線追逐著光線的源頭，卻一眼撞入了黑暗與未知的陷阱……"
  },
  Event_6840_Name = {
    Text = "暗夜螢光"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6841_Desc = {
    Text = "北邊，北側出口！\n和拉蒙娜的決策一樣，北方一定有出路。"
  },
  Event_6842_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6842_Desc = {
    Text = "哦……無瑕的銀色，代表了靈魂對你開的玩笑。\n那麼，你的下一個選擇是？"
  },
  Event_6842_Name = {
    Text = "好戲開場"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6843_Desc = {
    Text = "你甩甩頭，把聲音拋之腦後。\n一聲若有似無的歎息，送來了一些幫助。"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "【深入回廊】感染「(Skill.Arg1)」，是否還要繼續前進"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "【背道而馳】獲得25黑印"
  },
  Event_6844_Desc = {
    Text = "月光消逝，被迴廊吞噬，只剩透著不祥氣息的門扉留在眼前。"
  },
  Event_6844_Name = {
    Text = "寂靜回廊"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "【深入回廊】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，是否還要繼續前進"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "【背道而馳】獲得25黑印"
  },
  Event_6845_Desc = {
    Text = "未知全貌，不應深入。"
  },
  Event_6845_Name = {
    Text = "寂靜回廊"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "【深入回廊】感染「(Skill.Arg1)」，是否還要繼續前進"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "【背道而馳】獲得25黑印"
  },
  Event_6846_Desc = {
    Text = "左側的門扉發出了詭異的獰笑聲，祂輕微震動著，抖落絲縷惡意。"
  },
  Event_6846_Name = {
    Text = "寂靜回廊"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "【深入回廊】獲得白銀造物「(RelicConfig.Arg1)」，是否還要繼續前進"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "【背道而馳】獲得25黑印"
  },
  Event_6847_Desc = {
    Text = "右側的門扉敞開著，鮮血在地面上綿延出既定的軌跡。"
  },
  Event_6847_Name = {
    Text = "寂靜回廊"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "【已經沒有任何東西了，你退了出來】"
  },
  Event_6848_Desc = {
    Text = "誰說 一定要橫衝直撞呢？退一步，或許真的有海闊天空。"
  },
  Event_6848_Name = {
    Text = "寂靜回廊"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "【修復蠟像】選擇卡牌並使其算力消耗降低1"
  },
  Event_6849_Desc = {
    Text = "蠟像的修復工作正持續進行著。\n你並非專業的蠟像師，也未曾接受過系統的美學教育。\n但你依然熟練地開始倒模、塑形、上色……\n就像你生來便該手持刻刀。\n就像它生來便該殘缺，隻為等待你的雕琢。"
  },
  Event_6849_Name = {
    Text = "未完的蠟像"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "【修復蠟像】選擇卡牌並使其算力消耗降低1"
  },
  Event_6850_Desc = {
    Text = "伽拉忒亞，伽拉忒亞……\n你循著呼喚聲再次找到了未完的蠟像。\n她看上去完美極了，甚至令人不安。\n「醜陋是撕開完美的一道口子。」\n在最後的時刻，你決定做點什麼。"
  },
  Event_6850_Name = {
    Text = "未完的蠟像"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "【接受幻覺】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6851_ChoiceDesc2 = {
    Text = "【否認幻覺】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6851_Desc = {
    Text = "厚重黑暗的鐵架橋下，蘆葦叢生的寂靜河灘上，忽然飛出一隻閃光的蝴蝶。\n蝴蝶輕盈地落在你的掌心，糟糕的嚎叫聲停息了，取而代之的是火車碾過銹蝕鋼架的轟鳴聲，煤炭燃燒的劈啪聲，輪軸轉動的金屬摩擦聲……"
  },
  Event_6851_Name = {
    Text = "鐵路的幻覺"
  },
  Event_6852_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6852_Desc = {
    Text = "是的，逃亡，你在被某種生物追逐，求生的本能讓你拔腿狂飆，直至無路可逃。 不對，應該無路可逃的……不是地獄犬才對嗎？"
  },
  Event_6853_ChoiceDesc1 = {
    Text = "【這不是真的】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "【下墜、下墜……】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6853_Desc = {
    Text = "掉落在地上的鏡子有著精緻的方框，方框裡面又有方框，方框裡面又有方框……\n愛麗絲一躍而下，在永無止境的兔子洞裡不斷下墜，她看見一塊又一塊鏡子，一個又一個精神困在這裡，唯獨看不見自己。"
  },
  Event_6853_Name = {Text = "鏡中鏡"},
  Event_6854_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6854_Desc = {
    Text = "你隔著風雪的窗紗俯瞰雪山，許多隻黑色的螞蟻追逐著一隻黑色的螞蟻……\n你的思路中斷了。"
  },
  Event_6854_Name = {
    Text = "火山追憶"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "【上前握住】獲得25黑印"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "【友好回應】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_6855_Desc = {
    Text = "一隻不知從何而來的貓端坐在融蝕漿之間，輪廓模糊的軀體說明它應當是精神維度的住民。\n這個看不清面孔的投影用智慧的目光望著拉蒙娜，它抬起潔白的前爪，招手一般朝她示意。"
  },
  Event_6855_Name = {
    Text = "遊走的住民"
  },
  Event_6856_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6856_Desc = {
    Text = "一幅喜氣洋洋的人物群像。\n蠟像們盛裝打扮，整齊地坐在椅子上，臉上帶著同樣誇張的微笑。\n它們和諧得就像你能在任何一家瘋人院裡見到的那樣。\n\n落款：洪積305年，@2羅傑斯"
  },
  Event_6857_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6857_Desc = {
    Text = "你小心地摘下碎片，仔細檢查。它又一動不動了。\n「笨手笨腳的，別亂動，」朵爾輕敲你的後腦勺，「短時間內我可沒辦法給你搗鼓出第二片來。」"
  },
  Event_6857_Name = {
    Text = "不安的胸針"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "【使用鑰匙】"
  },
  Event_6858_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_6858_Desc = {
    Text = "一扇門堵住了你的去路。你用盡了各種方法，它依然紋絲不動。"
  },
  Event_6858_Name = {
    Text = "銹蝕門扉"
  },
  Event_6858_Tips1 = {
    Text = "需要獲得「銹蝕鑰匙」"
  },
  Event_6859_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6859_Desc = {
    Text = "你為自己的武斷感到羞愧。\n一位合格的守密人必須嚴謹，你不應貿然做出它們不是「高檔貨」的判斷。\n於是你決定仔細觀察它們。五分鐘過去了，十分鐘過去了……\n好了，現在你可以下判斷了——\n確實是垃圾貨。"
  },
  Event_6859_Name = {
    Text = "被縛的靈魂"
  },
  Event_6860_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6860_Desc = {
    Text = "你和你的同伴們放下了武器。\n這並非大發善心，而是你明白它們搖搖欲墜的身軀無法堅持太久。\n事實證明你的判斷是正確的。"
  },
  Event_6860_Name = {Text = "習作"},
  Event_6861_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6861_Desc = {
    Text = "「來追我啊！」\n「來啊，笨蛋！」\n「有本事就把我們抓起來啊！」\n孩子們的聲音得意洋洋。\n「混帳東西！給我站住！」\n成年人的聲音氣喘吁吁。"
  },
  Event_6861_Name = {
    Text = "我們的回憶"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "【進入】穿過迷霧，抵達另一端。"
  },
  Event_6862_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_6862_Desc = {
    Text = "這是你要找的人，你完成了任務。"
  },
  Event_6862_Name = {
    Text = "單行密道26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_6863_Desc = {
    Text = "啊！只差了一點！等一下，三個骰子為什麼投出了十點！\n骰子們安分地躺在你面前，看上去乖巧又無辜。"
  },
  Event_6863_Name = {
    Text = "無止境的賭局"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "【離開】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_6864_Desc = {
    Text = "可惡！不是六點，但是還有有些賺的。\n所以，它們到底是幾點？"
  },
  Event_6864_Name = {
    Text = "無止境的賭局"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_6865_Desc = {
    Text = "雖然沒有猜中，但也能接受。\n哎，它們到底投的是幾點？"
  },
  Event_6865_Name = {
    Text = "無止境的賭局"
  },
  Event_6866_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6866_Desc = {
    Text = "你低頭挑揀著石膏碎塊，將她一塊塊拼補回去，她軀體的一部分在你手下漸漸成形。"
  },
  Event_6866_Name = {
    Text = "拼湊殘軀"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "【拾取鑰匙】"
  },
  Event_6867_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  Event_6867_Name = {
    Text = "銹蝕鑰匙"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "【正面】50%機率獲得黃金造物「(RelicConfig.Arg2)」，50%機率感染「(Skill.Arg3)」"
  },
  Event_6868_ChoiceDesc2 = {
    Text = "【反面】50%機率獲得75黑印，50%機率感染「(Skill.Arg3)」"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "【請對方先選】50%機率獲得詛咒造物「(RelicConfig.Arg2)」，50%機率感染「(Skill.Arg3)」"
  },
  Event_6868_Desc = {
    Text = "一場賭局而已，你不會輸的。\n鐫刻著紋理的硬幣被高高拋起，再迅速下落，被你的掌心侵染上溫熱。"
  },
  Event_6868_Name = {
    Text = "馳名的賭徒"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6869_Desc = {
    Text = "「寄託於命運的眷顧者，也將為命運所傾覆。」\n你選擇離開。"
  },
  Event_6869_Name = {
    Text = "馳名的賭徒"
  },
  Event_6870_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6870_Desc = {
    Text = "「守密人。」\n拉蒙娜的聲音讓你清醒過來，但，下墜的感覺並沒有就此消失。"
  },
  Event_6870_Name = {Text = "鏡中鏡"},
  Event_6871_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6871_Desc = {
    Text = "據說，小夜曲是一種源自愛情的歌曲。\n是在夏日的夜晚、戀人的窗外，人們三兩作伴，演奏出來的繾綣樂曲。\n隨性、膚淺，並不符合羅傑斯的審美，但依舊成為了他的保留曲目。\n恐怕只有他自己才知道原因了。"
  },
  Event_6872_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6872_Desc = {
    Text = "你拒絕被它們的囈語誘惑。\n你說：「謊話連篇！你們被困在漆黑的永夜裡，如何穿行宇宙？」\n眼睛們笑了起來。無數笑聲匯成巨大的聲浪，你的心臟也隨之震顫。\n眼睛說：「通過掠奪其它眼睛。每一隻眼睛都是一個宇宙。當你擁有一千隻眼睛，你將踏上真正的時空之旅。」"
  },
  Event_6873_ChoiceDesc1 = {
    Text = "【領取】獲得3選1黃金造物"
  },
  Event_6873_Desc = {
    Text = "哦是的，那個可憎的倒影就是你自己。\n噴薄而出的惡意與你腳下的黑漿融作一團，扭曲地共舞著，如果不介意，它也想攀上你的肩頭。"
  },
  Event_6873_Name = {
    Text = "鏡面之下"
  },
  Event_6874_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6874_Desc = {
    Text = "沒過多時，束縛陡然鬆開，讓你摔了個踉蹌。\n你回頭看向安靜的絲線——「切勿攪動流沙」，這句話，在密境中或許也適用。"
  },
  Event_6875_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6875_Desc = {
    Text = "靈知之火亮起，燃盡了所有束縛——\n至少，你是這麼認為的。"
  },
  Event_6876_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6876_Desc = {
    Text = "全力掙脫束縛，絲線割破衣物，在皮膚上留下細微的血痕。\n儘管蛛網留下了什麼作為通行費，但心情依然如釋重負——你自由了。"
  },
  Event_6877_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6877_Desc = {
    Text = "融蝕的贅生物產生的信箋，其所產生的資訊也大多會被抹殺。\n你沒能從信紙上獲取有價值的資訊，索性撕掉了信紙，隨手灑落。"
  },
  Event_6878_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6878_Desc = {
    Text = "就算文字被刻意抹去，你也依舊能清晰地察覺到——信件的價值。"
  },
  Event_6879_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6879_Desc = {
    Text = "小心為上。\n拉蒙娜躬著腰，回到走廊上，潛入下一個房間。"
  },
  Event_6880_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6880_Desc = {
    Text = "你發出一聲絕望的尖嘯。\n群鴉似是被你的聲音所惑，很快便消失無蹤，留下漆黑的印記。"
  },
  Event_6880_Name = {
    Text = "群鴉之歌"
  },
  Event_6881_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6881_Desc = {
    Text = "你蜷縮身體，試圖將自己縮成一個黑點。\n這樣它們就不會注意到你了吧。\n不知過了過久，你睜開雙眼。\n你看見光。"
  },
  Event_6881_Name = {
    Text = "群鴉之歌"
  },
  Event_6882_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6882_Desc = {
    Text = "陰影從指縫間輕輕流走，留下一地金色塵埃。"
  },
  Event_6882_Name = {Text = "銀鑰使"},
  Event_6883_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6883_Desc = {
    Text = "你胡亂地揉搓著自己的頭髮，臆想和狂思爭先恐後在你的腦中迸發，包裹著黑色粘液的團塊藏於深處。\n剖開它，會給予你怎樣的饋贈？"
  },
  Event_6883_Name = {
    Text = "攪動大腦"
  },
  Event_6884_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6884_Desc = {
    Text = "彩色油污漸漸脹滿視野，你的情緒陷入無序的狂歡。"
  },
  Event_6884_Name = {
    Text = "攪動大腦"
  },
  Event_6885_Desc = {
    Text = "一種近水銀態的銀色物質，由融蝕黏液中提煉而出，蘊含強大精神力，主要用於在儀式中連結更多喚醒體。"
  },
  Event_6885_Name = {Text = "銀芯"},
  Event_6886_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6886_Desc = {
    Text = "歡樂的笑聲從盒子內傾瀉而出，溫暖的螢光消散後，你看到一張卡片，上面畫著三個火柴人：你，銀髮的拉蒙娜，金髮的奧吉爾。旁邊還有一行字。\n   「謝謝你們！」"
  },
  Event_6886_Name = {
    Text = "善意的禮物"
  },
  Event_6887_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6887_Desc = {
    Text = "你的肉身躲過了蝶群，但她們沒有失去自己的目標，鑽入你的手提箱中，貪婪地吮吸著打字機中的油墨。"
  },
  Event_6887_Name = {
    Text = "妄念噴湧"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "【指出錯誤】選擇1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6888_ChoiceDesc2 = {
    Text = "【聽完彈奏】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_6888_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_6888_Desc = {
    Text = "男孩蠟像坐在鋼琴前彈奏練習曲。\n他的老師——同樣也是蠟像做的，正在一旁指導。\n133，355，244……\n錯了，每個音都錯了。"
  },
  Event_6888_Name = {Text = "鋼琴課"},
  Event_6889_ChoiceDesc1 = {
    Text = "【放棄抵抗】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "【抽回雙手】"
  },
  Event_6889_Desc = {
    Text = "你無力抵抗內心的衝動。\n手指像迷失在樹林裡的孩童，在鍵盤上遊蕩、嬉戲……\n漸漸地，有蝴蝶從打字機中飛了出來。\n一隻、兩隻、三隻……\n臉上、手指上，成群的蝴蝶像是空中綻放的煙花，在黑暗中閃動著寶石般的光芒。\n這台打字機沒有任何實際功用，但它對創造美卻很在行。"
  },
  Event_6889_Name = {
    Text = "靈感迸發"
  },
  Event_6890_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6890_Desc = {
    Text = "你將紙張舉到暗紅的燈光下，唯恐錯過一個細節。\n這是一張體檢報告，受檢人正是梅森。\n「體重40kg，血氧濃度正常，同調率30%，共鳴值……」\n你還想接著看下去，字跡卻逐漸消失了。\n乾淨得像什麼都沒發生過。"
  },
  Event_6890_Name = {Text = "打字機"},
  Event_6891_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6891_Desc = {
    Text = "是的，你不是在逃亡，你在追逐確定的目標——在陰濕狹窄的積雪小巷中左衝右突的「地獄犬」。 你不會忘記這件事，就像你不會忘記通古斯那天將你從廢墟中拉起的人的面龐。 ……是誰來著？"
  },
  Event_6892_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6892_Desc = {
    Text = "在這個隔離之外的空間，你所能依靠的僅僅只有自己。"
  },
  Event_6892_Name = {
    Text = "噩夢行者"
  },
  Event_6893_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6893_Desc = {
    Text = "危機與風險並存。觸摸鐵鎖的瞬間，腐蝕性的黏液灼痛了你的手掌。希望門扉後的造物物有所值。"
  },
  Event_6893_Name = {
    Text = "鐵門之後"
  },
  Event_6894_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6894_Desc = {
    Text = "在尚未接觸過的世界橫衝直撞，你搖搖欲墜的精神並沒有退化到喪失理智的地步。\n未知之物的可怖，你深以為然。"
  },
  Event_6894_Name = {
    Text = "噩夢行者"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "【大聲喊叫】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6895_ChoiceDesc2 = {
    Text = "【感受寂靜】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_6895_ChoiceDesc3 = {
    Text = "【浮出水面】獲得25黑印"
  },
  Event_6895_Desc = {
    Text = "你聽到了寂靜。\n一種放大了的寂靜，就像海浪聲一樣，填滿了整個空間。\n\n你抬起頭，就像一個凝望星空的小點。"
  },
  Event_6896_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6896_Desc = {
    Text = "你豎起耳朵，循聲尋覓著聲音的來源，試圖揪出這個作亂的惡徒。\n可就像是有意戲弄般，就在你以為將人逼入絕境後，總會撞上鬼打牆般的循環，你又被繞回了原地。\n你氣餒地踢了一腳磚牆，卻從牆上掉下一塊磚石，秘藏閃爍在牆上的空洞裡。"
  },
  Event_6896_Name = {
    Text = "迷蹤留聲"
  },
  Event_6897_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6897_Desc = {
    Text = "一定是播放的問題，一定是這樣。\n你不信邪地撥回了唱針，艱難忍受了前半段難聽的樂聲後，記憶中的敲擊聲卻沒有響起。\n在你空無一物的身後，地上的小小黑影，正悄然溜走。"
  },
  Event_6897_Name = {
    Text = "迷蹤留聲"
  },
  Event_6898_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6898_Desc = {
    Text = "你身邊並沒有人，敲擊的秘密必定藏在留聲機內部的機括中。\n出於對自己判斷的自信，你拆開了老舊的留聲機。\n除了內部腐化的金屬原件和厚厚一層積灰外，你什麼都沒有發現。\n只有一句哼笑，逸散在霧氣中，輕得彷彿置身夢中."
  },
  Event_6898_Name = {
    Text = "迷蹤留聲"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "【愚者的白質】回復 Arg1 點生命"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "【狂人的心臟】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "【拒絕食用】獲得25黑印"
  },
  Event_6899_Desc = {
    Text = "「愚者的白質鮮美得如同煮沸的魚湯，狂人的心臟則烤成了一塊熱烘烘、血淋淋的司康。」\n黑影獰笑著，將含有不明食材的菜色，遞到了你眼前。\n你深吸了一口，四溢的香氣蠻橫地鑽進鼻腔，你那毫無尊嚴的唾液腺先行繳械，胃腸悲哀地痙攣著，發出渴求的咕噥哀吟。"
  },
  Event_6899_Name = {
    Text = "肌體盛宴"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "【觸摸風鈴】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_6900_ChoiceDesc2 = {
    Text = "【觀察風鈴】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_6900_ChoiceDesc3 = {
    Text = "【什麼也不做】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6900_Desc = {
    Text = "叮叮，叮叮......\n這是一隻銹蝕的風鈴，笨拙的樂音自縫隙裡蜿蜒而出。"
  },
  Event_6900_Name = {
    Text = "銹蝕風鈴"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "【靜觀其變】嘗試存活"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "【揮動武器】嘗試突圍"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "【握住一隻手】獲得25黑印"
  },
  Event_6901_Desc = {
    Text = "你腳下的地面忽然生出一片黑色沼澤，無數隻手從中湧了出來。\n它們有著各式各樣的膚色、材質和紋理，孔雀藍的、帶鱗片的、長眼睛的，像是穿越無數維度和空間而來，正試圖將下一個倒楣蛋拉入它們的大家庭。\n你決定——"
  },
  Event_6901_Name = {
    Text = "黯色沼澤"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "【按住它】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "【搖晃一下】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6902_ChoiceDesc3 = {
    Text = "【什麼也不做】獲得25黑印"
  },
  Event_6902_Desc = {
    Text = "叮叮，叮叮......\n這是一隻銹蝕的風鈴，笨拙的樂音自縫隙裡蜿蜒而出。"
  },
  Event_6902_Name = {Text = "小風鈴"},
  Event_6903_ChoiceDesc1 = {
    Text = "【反駁它們】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "【附和它們】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6903_ChoiceDesc3 = {
    Text = "【提出新觀點】獲得25黑印"
  },
  Event_6903_Desc = {
    Text = "「請和我們保持距離。」\n成群的老鼠將你圍在中心，與你保持著至少五英尺的距離。\n「我們努力繁衍，我們茁壯成長，我們從不挑食——於是我們帶給人類疾病、焦慮和痛苦。」\n「我們和人類不應該走得太近，這不是你該來的地方。」\n為了使老鼠們放鬆警惕，你決定——"
  },
  Event_6904_ChoiceDesc1 = {
    Text = "【繼續墜落】感染「(Skill.Arg1)」，是否繼續下墜"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "【抽身離開】獲得25黑印"
  },
  Event_6904_Desc = {
    Text = "「你」邀請著你。\n在螺旋的深處，過去與未來的「你」向你送上了來自不同維度的「贈禮」。"
  },
  Event_6904_Name = {
    Text = "螺旋深淵"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "【摁住烏鴉】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "【放任不管】獲得25黑印，離開"
  },
  Event_6905_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。"
  },
  Event_6905_Name = {
    Text = "融漿之淚"
  },
  Event_6906_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6906_Desc = {
    Text = "紅色，熱情、奔放、豔麗，我正巧認識一位這樣的美人，假以時日你們會相見的。\n那麼，你的下一個選擇是？"
  },
  Event_6906_Name = {
    Text = "好戲開場"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "【大聲喝彩】"
  },
  Event_6907_Desc = {
    Text = "你做了一個很長的夢。\n夢裡，你坐在觀眾席上，看著舞臺上歌唱的男孩。\n「老查理有一隻他很愛很愛的虎斑貓\n當她無故失蹤的時候他到處找」\n……\n空洞乾澀的聲音機械地重複著，無休無止……"
  },
  Event_6907_Name = {
    Text = "終幕禮Ⅳ"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "【解開上方的枝節】"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "【解開下方的枝節】"
  },
  Event_6908_Desc = {
    Text = "殘留密境的靈知互相勾連，糾纏出一片不穩定的力場。\n或許，你能解開纏繞的靈，為自己梳理出前進的道路。"
  },
  Event_6908_Name = {
    Text = "糾纏之路"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒2名喚醒體"
  },
  Event_6909_Desc = {
    Text = "你站起身，立刻衝向門口。\n 「你掀開了蓋布……\n 秘密，你發現了秘密……」\n 聲浪匯成喧囂的海洋，地板在可怕的共振中劇烈抖動。\n 你不敢回頭，以最快的速度逃離了現場。"
  },
  Event_6909_Name = {
    Text = "終幕禮Ⅴ"
  },
  Event_6910_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6910_Desc = {
    Text = "你不反抗，當然，你也並不會選擇沉湎。"
  },
  Event_6910_Name = {
    Text = "顱中瘡孔"
  },
  Event_6911_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6911_Desc = {
    Text = "你不再抗拒，任由污穢吞噬軀體和精神，長眠過後，銀光落入你交握的手中。"
  },
  Event_6911_Name = {
    Text = "顱中瘡孔"
  },
  Event_6912_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6912_Desc = {
    Text = "越是掙扎，腦中的污穢就陷得越深，而在淤積著罪惡的大腦最深處，埋藏著不知來由的饋贈。"
  },
  Event_6912_Name = {
    Text = "顱中瘡孔"
  },
  Event_6913_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6913_Desc = {
    Text = "隨著網的破碎，有什麼東西在你腦海中一閃而過，似乎是幾個孩子的笑臉。"
  },
  Event_6913_Name = {
    Text = "迷走網路"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6914_Desc = {
    Text = "貓滿意地點點頭，隨即化作一道陰影原地消散，留下了幾個黑色的圓形物件。"
  },
  Event_6914_Name = {
    Text = "遊走的住民"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "【閱讀書信】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "【關好箱子】"
  },
  Event_6915_Desc = {
    Text = "飛舞的信紙鋪天蓋地，像極了無聲的催促。"
  },
  Event_6915_Name = {
    Text = "不速來信"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "【進入】穿過迷霧，抵達另一端。"
  },
  Event_6916_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_6916_Desc = {
    Text = "面前的道路上出現了一條隱藏隧道，隧道中黑霧彌漫，不知通往何方。"
  },
  Event_6917_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6917_Desc = {
    Text = "你決心終結它的苦難，於是伸手握住它柔軟的身軀，收緊，再收緊……\n它在你掌心絕望地掙扎著，最終炸成一團溫暖的水漿。"
  },
  Event_6917_Name = {
    Text = "融漿之淚"
  },
  Event_6918_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6918_Desc = {
    Text = "安心吧，這只是維度中碎裂的他人的記憶。你擁有影子。只是，影子裡的那個人，真的還是你嗎？"
  },
  Event_6918_Name = {
    Text = "記憶碎片·啤酒"
  },
  Event_6919_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6919_Desc = {
    Text = "你用力掰回了烏鴉意圖啃咬羽毛的尖喙，它卻不依不饒地擰過去，力氣之大甚至將你的骨頭震得哢哢作響。\n你漲得滿臉通紅，拼盡全身力氣才制住烏鴉的身體，遏止了它瘋狂自殘的行徑。\n正在你鬆了口氣時，烏鴉那已經半禿的脖頸向後猛地一擰，身體癱軟下來，在你的手裡化成了一灘黑色的濃漿。"
  },
  Event_6919_Name = {
    Text = "融漿之淚"
  },
  Event_6920_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6920_Desc = {
    Text = "你冷酷地無視了那些絕望的鈴聲。\n哪怕下一秒就要被炸回原始世界，哪怕你和你的偉大使命就要一起陪葬。\n不該接的電話，就是不能接。\n你深知這個樸素的道理。"
  },
  Event_6920_Name = {
    Text = "請接電話"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "【低頭看】獲得25黑印"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "【我一定要找到】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6921_Desc = {
    Text = "你追著黑影向前，突然踏入一片淺水之中。看不清顏色的液體沒過鞋面，透進絲絲寒意。\n一個聲音在水中說：「你不會想要找到。」"
  },
  Event_6921_Name = {
    Text = "你不會想要找到"
  },
  Event_6922_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6922_Desc = {
    Text = "安全的選擇。"
  },
  Event_6922_Name = {
    Text = "草垛之後"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "【無視】獲得25黑印，離開"
  },
  Event_6923_Desc = {
    Text = "療養院的房間中怎麼會有烏鴉？\n但你切實聽見了烏鴉的獰笑聲，暗影中有某個尚未登上舞臺的勢力，從那雙空洞的鳥眼中窺視著你們。那些漆黑的生物扭曲脖頸，站在巷口的吊燈上，用包含惡意的眼神俯視著你。那重影般的頭顱，似乎共用著同一個浸沒在融蝕漿中的身體。"
  },
  Event_6923_Name = {
    Text = "提燈黑鴉"
  },
  Event_6924_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6924_Desc = {
    Text = "不要恐懼污穢，你從中獲取的比失去的更多。"
  },
  Event_6924_Name = {
    Text = "草垛之後"
  },
  Event_6925_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6925_Desc = {
    Text = "靈知的風暴環繞在圖魯周身，你與他對視一眼，前後腳深入黑暗。"
  },
  Event_6925_Name = {
    Text = "代行者的承諾"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "【進入】穿過迷霧，抵達另一端。"
  },
  Event_6926_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_6926_Desc = {
    Text = "你墜入了一片黑暗之中。\n在視線的盡頭，只有一縷光線，從狹小如鑰匙孔的縫隙中透出。\n銀鑰匙發出呼吸般的微光，指引你踏入那條密道。"
  },
  Event_6926_Name = {
    Text = "單行密道"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得造物：(「(RelicConfig.Arg2)」】"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "【從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6927_Desc = {
    Text = "事件203（開發中），非最終效果"
  },
  Event_6927_Name = {
    Text = "事件203（開發中）"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "【拼補】刪除一張指令卡，獲得造物：「(RelicConfig.Arg1)」"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "【撫摸】刪除一張打擊/防禦卡，獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "【厭惡】獲得25黑印"
  },
  Event_6928_Desc = {
    Text = "「你喜歡我的殘軀嗎？可以的話，能請你幫我拼湊身體嗎？」\n只剩下半邊身子的石膏像嘴唇甕動，如輕紗落在耳畔的柔弱嗓音，從她本該堅硬冰涼的唇齒中溢出。"
  },
  Event_6928_Name = {
    Text = "拼湊殘軀"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "【丟棄信封】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "【揣進懷裡】感染「(Skill.Arg1)」，獲得造物：「(RelicConfig.Arg2)」"
  },
  Event_6929_Desc = {
    Text = "這是一封求救的信件，寫信者竭力保持鎮靜，那時而歪斜的筆跡，卻將他深藏的恐懼展露無遺。\n「這一切完全超出了的預料，如果現在有人說我深中詛咒，我發誓一定深信不疑。」\n「有人說我是瘋子，他只說對了一半，我正在在瘋癲的邊界搖搖欲墜。」\n「但我真的看到了！它在變異和消散，增殖的黑漆漆黏著物試圖往我全身攀爬！」\n「我逃了！逃得飛快，但注視的目光從未從我身上移開，我有預感，它一定會找到我！那可憎的黑泥會再次灌入我的頭骨，無論是誰收到了信，求求你，救我——」"
  },
  Event_6930_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6930_Desc = {
    Text = "「冷靜，」拉蒙娜敲了敲你的腦袋，「只是往昔的碎片。不知道是誰遺落在這條維度通道的。」\n確實，有股懷念的味道。"
  },
  Event_6930_Name = {
    Text = "緊急通訊"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "【隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "【隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "【隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_Desc = {
    Text = "事件205（開發中），非最終效果"
  },
  Event_6931_Name = {
    Text = "事件205（開發中）"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "【獲得造物：(「(RelicConfig.Arg1)」】"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "【獲得造物：(「(RelicConfig.Arg1)」】"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_6932_Desc = {
    Text = "事件204（開發中），非最終效果"
  },
  Event_6932_Name = {
    Text = "事件204（開發中）"
  },
  Event_6933_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6933_Desc = {
    Text = "孤月高懸於天，你卻能聽清它祝禱的頌詞，古怪的音調，像極了污穢之物的細語呢喃。\n禱告停止，你正要離開。身後卻亮起一道白色的虛影。\n「窺伺命運和祝禱的褻瀆之人，恩賜與代價都將如約而至。」"
  },
  Event_6933_Name = {
    Text = "銀月碎片"
  },
  Event_6934_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6934_Desc = {
    Text = "背後傳來清脆的碎裂聲響，你沉吟片刻，轉身離開。"
  },
  Event_6934_Name = {
    Text = "銀月碎片"
  },
  Event_6935_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6935_Desc = {
    Text = "掬於掌心的一捧月光，被灑落在石碑上。\n有人被埋在了厚重的淤泥之下，旁觀的人群聲稱，此人迎來了自然凋亡，將安眠於地下。\n可那埋藏的淤泥湧動，慘叫聲中，卻爬出了一團癱軟的月亮。"
  },
  Event_6935_Name = {
    Text = "銀月碎片"
  },
  Event_6936_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6936_Desc = {
    Text = "不過是掙扎求生的生靈，求得一塊歇腳的浮木罷了……\n你歎息一聲，任由蝴蝶尾部的黑漿流淌。"
  },
  Event_6936_Name = {
    Text = "不應存在之物"
  },
  Event_6937_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6937_Desc = {
    Text = "這是一場事先張揚的陷阱，而你，深知它的危險。\n相較於首飾，你本人——顯然是更為珍稀的寶石。"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_6938_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_6938_Name = {Text = "析出點"},
  Event_6939_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6939_Desc = {
    Text = "你應下請求，卻遇到了一點小小的問題。\n「那尊蠟像……是什麼樣子的？」\n「那是我的半身，當然和我長得一模一樣了。」\n「可是……」\n「您的臉，早就徹底爛掉了啊。您不知道嗎？」"
  },
  Event_6940_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6940_Desc = {
    Text = "你緊緊握住了身側同伴的手，拉蒙娜側目對你投來了疑惑的目光，但她最終默許了你的失禮。"
  },
  Event_6940_Name = {
    Text = "夢境禱文"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "【問它是誰】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6941_ChoiceDesc2 = {
    Text = "【與它對視】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6941_Desc = {
    Text = "強烈的被注視的感覺讓你停下腳步。\n「是誰？」你在濃霧中張望，「詹金，是你嗎？」\n霧氣茫茫，庭院深處隱隱傳來融蝕體的尖叫。你一無所獲，只能回頭，卻險些撞上一隻懸在空中的眼睛。"
  },
  Event_6941_Name = {
    Text = "盲目注視"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "【不碰硬幣】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "【觸碰硬幣】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_6942_Desc = {
    Text = "你撿到了一枚陷入黑泥的古幣。\n它一面鏤空刻著青紅相間的血管，一面用浮雕工藝細細描畫了純白色的頭像——纖塵不染的女公爵噙著笑，凝視著你的蒼白眼珠翕動了一瞬，開始胡亂轉動。"
  },
  Event_6942_Name = {
    Text = "雙面古幣"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "【轉身】獲得25黑印"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "【繼續前行】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6943_Desc = {
    Text = "又來了，那個奇怪的腳步聲。\n它緊跟在你身後，從工作室到館長室，再從館長室到地下室。\n你知道那是個謹慎的傢伙。\n他小心翼翼地維持著你們之間的距離，使其不至於太遠，但也不會令人感到冒犯。\n但你還是被深深地困擾了。"
  },
  Event_6943_Name = {Text = "腳步聲"},
  Event_6944_ChoiceDesc1 = {
    Text = "【觀察它】可以獲得25黑印"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "【撫摸它】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_6944_Desc = {
    Text = "小巷中突然躥出一隻黑貓，異常親熱地纏繞在你們的腳邊，幽綠的豎瞳閃爍著令人不寒而慄的光芒，彷彿在說「別追了，陪我玩一會兒吧。」\n 「你已經看見祂了，祂就在你的身側，那些被瘋狂污染的，狂熱的影子……不要直視祂的輪廓。」"
  },
  Event_6944_Name = {
    Text = "夜色精靈"
  },
  Event_6945_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6945_Desc = {
    Text = "喚醒體們等待著你的指令，你無暇他顧。"
  },
  Event_6945_Name = {
    Text = "來自角度"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "【檢查膠片】感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」"
  },
  Event_6946_ChoiceDesc2 = {
    Text = "【檢查相機】獲得50黑印"
  },
  Event_6946_Desc = {
    Text = "像拉出一截內臟般，相機肚子裡的膠片被扯得稀爛，開膛破肚地丟棄在這裡，無人問津。\n一道刺目的白光閃過，遺棄在街角的相機歪斜著，快門被憑空按動。\n「哢擦——」\n你那錯愕的、愣怔的神情，被忠實記載於相機中的膠捲上。"
  },
  Event_6946_Name = {
    Text = "記錄無罪"
  },
  Event_6947_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6947_Desc = {
    Text = "只是風搖晃鐵鎖的聲音罷了，沒什麼好在意的，不必理會。"
  },
  Event_6947_Name = {
    Text = "鐵門之後"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "【選擇】感染「(Skill.Arg1)」"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "【選擇】感染「(Skill.Arg1)」"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "【選擇】感染「(Skill.Arg1)」"
  },
  Event_6948_Desc = {
    Text = "「我」是獨一無二的我，自千萬宇宙中，絕無僅有。"
  },
  Event_6948_Name = {
    Text = "靈魂共振"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "【領取】選擇1個白銀造物"
  },
  Event_6949_Desc = {
    Text = "那或許是「我」。\n穿越時間之影，穿越維度壁壘，透過一線裂縫與我對視的「我」。"
  },
  Event_6949_Name = {
    Text = "靈魂共振"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "【指出問題】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "【咽下疑問】感染「(Skill.Arg1)」，重新刻印，還能再進行1次"
  },
  Event_6950_Desc = {
    Text = "這對少女而言，也是難言之隱。\n你咽下了疑問，她卻撫著心口娓娓道來，說著一場持續二十五年的長夢，說著夢醒後自己的孤立無援。"
  },
  Event_6950_Name = {
    Text = "被禁錮的生命"
  },
  Event_6951_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6951_Desc = {
    Text = "你將紙張與碎木屑投入火苗裡。火苗貪婪地將它們吞吃入腹，並滿足地打了一個飽嗝。它已經準備好要去毀滅世界了，臨走前不忘給了你一點祝福。"
  },
  Event_6952_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6952_Desc = {
    Text = "你無情地踩滅了這僅存的仇恨火種，縈繞四周的怨恨與不甘似乎減輕了。"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得Arg1黑印，感染「(Skill.Arg2)」"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_6953_Desc = {
    Text = "你想要抓住烏鴉，它卻只是從臥室的這一頭飛向那一頭，然後繼續發出詭異的叫聲。烏鴉飛離之處，滴落的黑色黏液化為黑色的印記。"
  },
  Event_6953_Name = {
    Text = "提燈黑鴉"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6954_Desc = {
    Text = "「你很會捕捉重點，」男人笑容滿溢，「那是這世上最美味的口糧，值得每一位饕餮小心料理，細心品鑒。」\n「很遺憾，這次沒辦法請你嘗試了。作為補償，我身上也有些其他美味佳餚，就送給你吧。」\n說完，男人拋下一塊嫩紅色的軟肉。軟肉砸在橋面上，黏膩的觸肢扭曲地蠕動著。你再抬頭去看時，男人的身影已經隱沒在錯綜的鋼架後，無跡可尋。"
  },
  Event_6954_Name = {
    Text = "怪異旅伴Ⅵ"
  },
  Event_6955_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6955_Desc = {
    Text = "抽絲剝繭，層層遞進，這是你的拿手好戲。\n靈感的閃光讓大腦格外清明，你得以看清目前的現實——\n不管是誰在幕後操縱著木偶，逃出去，活下來。"
  },
  Event_6955_Name = {
    Text = "靈感迸發"
  },
  Event_6956_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6956_Desc = {
    Text = "蝴蝶在你的掌心碎裂，如同被猛然擊碎的玻璃天花板，破缺的殘片向著地心引力墜落，墜落，墜落——"
  },
  Event_6956_Name = {
    Text = "鐵路的幻覺"
  },
  Event_6957_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6957_Desc = {
    Text = "見拉蒙娜不願靠近，貓搖了搖頭，化作一道陰影原地消散。"
  },
  Event_6957_Name = {
    Text = "遊走的住民"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "【許下承諾】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6958_ChoiceDesc2 = {
    Text = "【拒絕】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6958_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6958_Desc = {
    Text = "「那真是一段難忘的回憶。 \n我的頭和四肢被用力摁進石膏裡。\n窒息和瀕死的幻覺將我深深包裹，又將我用力拽起，拋在黑暗的海岸上。\n我看著它，感到自己的一部分也被一齊奪走了。 \n那失落的另一半靈魂，自此便寄居在那尊小小的，最初的蠟像裡。 \n所以……你能幫我找到我的半身嗎？」"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "【離開】獲得3選1高級刻印"
  },
  Event_6959_Desc = {
    Text = "你是記憶的旁觀者，只能眼睜睜看著少女向無光之海墜落。\n水流將裙擺向上推，她卻在下沉，像極了一支未開的花。"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_6960_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_6960_Name = {Text = "析出點"},
  Event_6961_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6961_Desc = {
    Text = "不必理會敵人的誘惑，說不定是某種陷阱。"
  },
  Event_6961_Name = {
    Text = "詛咒怪鴉"
  },
  Event_6962_ChoiceDesc1 = {
    Text = "【幫助他】"
  },
  Event_6962_ChoiceDesc2 = {
    Text = "【冷眼旁觀】"
  },
  Event_6962_Desc = {
    Text = "男孩站在舞臺上，慘白的燈光打在他臉上。\n「獻、獻給……」\n男孩漲紅了臉。他張開嘴，卻發不出一個音節。\n黑洞洞的嘴越張越大，越張越大……"
  },
  Event_6962_Name = {
    Text = "終幕禮Ⅲ"
  },
  Event_6963_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6963_Desc = {
    Text = "「好可惡，好可惡！」像是被你觸碰到某個開關，黑貓忽然兇相畢露，張口咬向你的胳膊，幸虧你躲避及時，只咬壞一節衣角。黑貓躥向街角，消失在巷子的下水道中。"
  },
  Event_6963_Name = {
    Text = "夜色精靈"
  },
  Event_6964_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6964_Desc = {
    Text = "被腦中那些翻湧的漿水裹挾著，你推開門，踏上了一條不歸的道路。\n門外熾熱的白光，是救贖，抑或是毀滅？"
  },
  Event_6964_Name = {
    Text = "重門之外"
  },
  Event_6965_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6965_Desc = {
    Text = "你大著膽子上前查看，覆蓋在桌面上的黏液突然裂開，露出底下的東西來。"
  },
  Event_6965_Name = {
    Text = "重門之外"
  },
  Event_6966_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6966_Desc = {
    Text = "咽下口水，壓下疑問，專心迎敵。\n讓蝴蝶暫時停留在身體中，即使它的振翅會將你的器官劃得支離破碎。"
  },
  Event_6966_Name = {
    Text = "蝴蝶效應"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_6967_Desc = {
    Text = "貓滿意地點點頭，隨即化作一道陰影原地消散，留下了幾個黑色的圓形物件。"
  },
  Event_6967_Name = {
    Text = "遊走的住民"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_6968_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_6968_Name = {Text = "析出點"},
  Event_6969_ChoiceDesc1 = {
    Text = "【離開】獲得1個隨機黃金造物，感染「(Skill.Arg1)」"
  },
  Event_6969_Desc = {
    Text = "見你仍在猶疑，庫姆撲向土堆，用兩隻前爪快速地刨出了什麼，推到你的面前。"
  },
  Event_6970_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6970_Desc = {
    Text = "紙張上端正地印著「梅里美」，從來就沒有什麼梅森。\n疑心病太重可不是好徵兆啊，守密人。"
  },
  Event_6970_Name = {Text = "打字機"},
  Event_6971_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_6971_Desc = {
    Text = "土堆中掩埋著雕塑家協會罄竹難書的罪惡。"
  },
  Event_6972_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6972_Desc = {
    Text = "禽鳥之間自有規則，它們不依照你的意志而行動，你也無權干涉自然的規律。"
  },
  Event_6972_Name = {
    Text = "離群之鴉"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_6973_Desc = {
    Text = "為什麼呢，為什麼會沉呢？\n那一天沒有雷雨，沒有風暴。夜空澄淨如洗，一顆星星都沒有，滿月低垂在海平面之上，猶如冰冷的太陽。"
  },
  Event_6974_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6974_Desc = {
    Text = "「列車長！我們遭遇了恐怖襲擊！……嗞啦……」\n看來是駕駛員的通報電話，你本打算就此掛機。\n「重複一遍，這裡是彌薩格外勤組第四小隊，我們在搭乘北線夜間特快列車護送救援人質的途中遭遇了……咿啊！」\n電話中的語調變成嘶啞的低語，夾雜著令人毛骨悚然的刺耳尖叫。\n「聖禮已成。迷途的羔羊啊，願這神聖的沐浴蕩滌你的靈魂……」"
  },
  Event_6974_Name = {
    Text = "列車來電"
  },
  Event_6975_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6975_Desc = {
    Text = "搜集銀芯也是守密人的工作之一。\n漂流在純白晶體內的靈魂，未來將以全新的面貌重返世間。"
  },
  Event_6975_Name = {
    Text = "被縛的靈魂"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "【繼續墜落】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，是否繼續下墜"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "【抽身離開】獲得25黑印"
  },
  Event_6976_Desc = {
    Text = "「你」邀請著你。\n在螺旋的深處，過去與未來的「你」向你送上了來自不同維度的「贈禮」。"
  },
  Event_6976_Name = {
    Text = "螺旋深淵"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "【彎腰探出】感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」"
  },
  Event_6977_ChoiceDesc2 = {
    Text = "【放棄查看】獲得50黑印"
  },
  Event_6977_Desc = {
    Text = "手術臺的底層似乎夾著一卷膠片。"
  },
  Event_6977_Name = {
    Text = "記憶光影"
  },
  Event_6978_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6978_Desc = {
    Text = "拒絕干擾，專注眼前。\n你還有更重要的事情要做。"
  },
  Event_6979_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6979_Desc = {
    Text = "遺失的聖器，價值連城的傳承遺物，實現願望的儀器……\n或許只有寶物才會如此誘人。"
  },
  Event_6979_Name = {
    Text = "謎團輸入法"
  },
  Event_6980_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6980_Desc = {
    Text = "「你是莉莉的『媽媽』，卻只將她作為研究和戰鬥的工具驅使，」你回應道，「幼年的孩子或許會服從母親，但你不該是莉莉的『媽媽』。」"
  },
  Event_6980_Name = {
    Text = "她的選擇"
  },
  Event_69813_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_69813_Desc = {
    Text = "銀鑰匙輝光閃爍，手臂們似被某種力量震懾，紛紛隱入池水，然後消失不見。"
  },
  Event_69814_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_69814_Desc = {
    Text = "你越陷越深，腦海中響起無上意志混亂的低語。你閉上眼，調用自己體內的權柄。\n忽然之間，一切聲音與異常的觸感都消失了，你站在門扉之後，身邊的血色觸手無影無蹤，彷彿從未存在過。\n你感到渾身暢快。你明白你付出的代價，但這無足輕重——你將以更強的形態，面對那至高的存在。"
  },
  Event_69815_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_69815_Desc = {
    Text = "你用記憶所塑造出的喚醒體未有片刻遲疑，將你拽出了血污之池，連接著你的手臂被撕裂，混濁的泥水飛濺，水中無數肉眼難以分辨的生物蠕動著，原初的造物主與毀滅者，正渴求著吞噬。"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "【呼喚喚醒體】扣除所有喚醒體 100 狂氣，刪除 1 張症狀卡"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "【吸收血池】提高 Arg1 點最大生命，感染2張「(Skill.Arg2)」"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "【插入銀鑰匙】清空所有銀鑰能量"
  },
  Event_69816_Desc = {
    Text = "生命的權柄，在原初的眼中以死亡的形態呈現。在你踏上這處影影綽綽的地界時，腥臭的血污池瞬間現出了真身。\n赤黑色的血污伸出不可計數的手臂，攀附在你的腳踝，不斷向上攀扯，意圖將你拖入不可測的深淵。"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "【拾取鑰匙】"
  },
  Event_6981_Desc = {
    Text = "一串鏽跡斑斑的鑰匙。可用於開啟門鎖。"
  },
  Event_6981_Name = {
    Text = "銹蝕鑰匙"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "【離開】選擇複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_6982_Desc = {
    Text = "在船歌和希萊斯特的指引下，你看向了幽深無光的船艙深處——你們的生機，是否就在那無邊的黑暗中？"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "【一起離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "【拒絕離開】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_6983_Desc = {
    Text = "是幻覺嗎？你見到烏鴉盤旋在上空，哼唱著一曲熟悉的歌謠：\n「那麼就一起離開吧，我和你\n趁黑夜剛落下帷幕\n像一個瀕死的酒鬼倒在大街上」"
  },
  Event_6983_Name = {
    Text = "群鴉之聲"
  },
  Event_6984_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6984_Desc = {
    Text = "追溯之力短時間內無法再次為你尋找聯絡點，可你至少獲得了暫時的撫慰。"
  },
  Event_6984_Name = {
    Text = "異常聯絡"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "【墜入螺旋】向螺旋的盡頭眺望"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "【抽身離開】獲得25黑印"
  },
  Event_6985_Desc = {
    Text = "舷窗外已經看不見海面了。\n玻璃映照出你蒼白的臉，而在你的瞳孔中，「你」也凝視著舷窗。\n現實與密境重疊、交織，最終扭曲成交錯的多重螺旋。"
  },
  Event_6985_Name = {
    Text = "螺旋深淵"
  },
  Event_6986_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6986_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_6986_Name = {Text = "聯絡點"},
  Event_6987_Desc = {
    Text = "「好久不見，朋友們。」你們從與提燈教眾的戰鬥中脫身，獲得稍許喘息的機會，突然發現那個長髮的男人再次出現在道路旁，向你們微笑著打招呼，彷彿剛才的戰鬥從未發生過。\n「跟上次見面時相比，你身上刻耳柏洛斯的味道變得濃郁了許多。這段時間，你肯定去了很遠的地方吧？」\n"
  },
  Event_6987_Name = {
    Text = "怪異旅伴Ⅴ"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "【向他問路】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6988_ChoiceDesc2 = {
    Text = "【離開它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6988_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6988_Desc = {
    Text = "影子站在瘦長的路燈下。\n「方便借個火嗎，先生。」\n你沒有@2的習慣，但你不介意使用一點小小的「魔法」。\n在你的幫助下，影子將點燃的@2深入那看不見底的黑色漩渦裡。\n不一會，你便看見白色的煙霧蒸騰而出。\n「啊——」\n影子發出愉悅的歎息聲。"
  },
  Event_6988_Name = {
    Text = "路燈下的身影"
  },
  Event_6989_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_6989_Desc = {
    Text = "棋盤之中，所見非真\n\n阻擋你前進的也許並不是牆壁，而是你枯竭的好奇心。"
  },
  Event_6989_Name = {
    Text = "幻影空間"
  },
  Event_6990_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6990_Desc = {
    Text = "「我好痛，好痛啊……莎莎姐姐……」\n你看向莎拉，她緊張地護著兩個孩子，似乎是沒有聽見。\n聲音逐漸消散。"
  },
  Event_6991_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_6991_Desc = {
    Text = "你起身向男孩鼓掌。 \n似乎是感受到你的鼓勵，男孩挺起小小的胸脯。 \n黑色的血自口中不斷湧出，卻再也無法阻擋歌聲。"
  },
  Event_6991_Name = {
    Text = "終幕禮Ⅳ"
  },
  Event_6992_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6992_Desc = {
    Text = "一部分的悲傷正在蒸發，可淚水卻仍不停歇地流向奇詭往世。"
  },
  Event_6992_Name = {
    Text = "冥灘之淚"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "【掐住歌者的喉嚨】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_6993_ChoiceDesc2 = {
    Text = "【絆倒舞者的步伐】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_6993_ChoiceDesc3 = {
    Text = "【繞路離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_6993_Desc = {
    Text = "你被三個粘稠的人影擋住去路。\n一個人影唱著歌，聲音嘶啞，歌詞詭異，你捂住耳朵，繞開了它。\n一個人影跳著舞，動作僵硬，步伐猶疑，你閉上眼睛，躲開了它。\n一個人影吟著詩，韻律破碎，語句不通，你忍無可忍，於是——"
  },
  Event_6993_Name = {
    Text = "狹路上的惡徒"
  },
  Event_6994_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_6994_Desc = {
    Text = "一部分的憤怒正在沸騰，可淚水卻仍不停歇地流向未知往世。"
  },
  Event_6994_Name = {
    Text = "冥灘之淚"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "【置若罔聞】感染「(Skill.Arg1)」"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "【轉身離開】隨機覺醒1名喚醒體"
  },
  Event_6995_Desc = {
    Text = "殘酷的宿命匍匐在行者的腳下，路途如明鏡光潔，背後有輕微的碎裂聲響。\n究竟是誰踩碎了腳下的宿命？是虛妄，是陷阱，或僅僅只是囈語，是誑言……\n在你眼前，碎出了一道緩慢爬行的裂痕。\n<Italic:彷彿它將為覺醒的靈知沉淪。>"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "【進行試煉】感染「(Skill.Arg1)」，勝利獲得1個黃金造物，失敗獲得50黑印"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_6996_Desc = {
    Text = "你窺見過一些秘辛，從腳下那灘鏡面般反光的黑漿中。\n它的倒影邊緣模糊，周身縈繞著揮之不去的黑氣，你感到莫名熟悉，卻又辨認不清它究竟是何物。"
  },
  Event_6996_Name = {
    Text = "鏡面之下"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "【學貓叫】50%機率獲得125黑印，50%機率感染「(Skill.Arg2)」"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "【投餵食物】75%機率獲得100黑印，25%機率感染「(Skill.Arg2)」"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "【拔腿就跑】獲得50黑印"
  },
  Event_6997_Desc = {
    Text = "你誤入了黑貓的地盤。\n無數眼睛在黑暗中倏然睜開，帶著探究、審視、戒備……唯獨沒有善意。\n祖母綠、琥珀黃、孔雀藍……\n你彷彿置身一片閃耀的寶石之海。\n為了脫身，你——"
  },
  Event_6997_Name = {Text = "貓之城"},
  Event_6998_ChoiceDesc1 = {
    Text = "【關於達芙黛爾】隨機2張指令卡分別獲得刻印：「(EnchantConfig.Arg1)」，「(EnchantConfig.Arg2)」"
  },
  Event_6998_ChoiceDesc2 = {
    Text = "【關於地獄犬】獲得詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "【關於莉莉】感染「(Skill.Arg1)」"
  },
  Event_6998_Desc = {
    Text = "「這裡是達芙黛爾的提示時間。」"
  },
  Event_6998_Name = {
    Text = "提示時間"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "【放任指針】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6999_ChoiceDesc2 = {
    Text = "【摁住指針】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6999_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_6999_Desc = {
    Text = "哢擦，哢嚓，哢——\n宿命的指針寸寸撥動，機括的彈響聲冷漠挪移著，向那個你絕對不願看到的方向狂奔而去。"
  },
  Event_6999_Name = {
    Text = "針端之外"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "【置若罔聞】從牌庫中隨機獲取3張指令卡，選擇1張卡進行刪除，獲得75黑印"
  },
  Event_7000_ChoiceDesc2 = {
    Text = "【謹慎檢查】從牌庫中隨機獲取3張指令卡，選擇1張卡的原始複製進入牌庫，獲得25黑印"
  },
  Event_7000_ChoiceDesc3 = {
    Text = "【轉身離開】獲得50黑印"
  },
  Event_7000_Desc = {
    Text = "殘酷的宿命匍匐在行者的腳下，路途如明鏡光潔，背後有輕微的碎裂聲響。\n究竟是誰踩碎了腳下的宿命？是虛妄，是陷阱，或僅僅只是囈語，是誑言……\n在你眼前，碎出了一道緩慢爬行的裂痕。"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "【呼喚烏鴉】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_7001_Desc = {
    Text = "利爪劃破披風，深深陷入肩頭。"
  },
  Event_7001_Name = {
    Text = "離群之鴉"
  },
  Event_7002_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7002_Desc = {
    Text = "恐懼有時候並不來源於實體。\n「地獄犬」所過之處，殘留著紅色的液滴，倒影出你的輪廓。"
  },
  Event_7002_Name = {
    Text = "無形倒影"
  },
  Event_7003_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7003_Desc = {
    Text = "伴隨輕微的電流，你聽到女子的低語。\n她哭泣著，一刻不停地講述自己的遭遇。\n一小時過去，一天過去……直到你早已忘記她因何悲傷。\n最後她愉快地掛斷電話，並許諾送你一份大禮。\n你收下了禮物。無論如何，禮物總是令人愉快的。"
  },
  Event_7003_Name = {
    Text = "請接電話"
  },
  Event_7004_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7004_Desc = {
    Text = "你在夥伴們不解的目光中，低頭單膝跪地，又將右手握拳放在額頭。\n很好，這樣就能完美地遮住你的臉了。"
  },
  Event_7004_Name = {
    Text = "以假亂真"
  },
  Event_7005_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7005_Desc = {
    Text = "「你已為我披上面紗。」\n蠟像恬靜地向你微笑。\n「我將真相獻予你，作為辛勤勞作的獎勵。」\n她的肚子不斷淌出黑色粘液，將你緊緊包裹。\n世界漆黑一片，卻無比溫暖。\n你蜷縮著打了個哈欠，第@1次進入夢鄉……"
  },
  Event_7005_Name = {
    Text = "未完的蠟像"
  },
  Event_7006_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7006_Desc = {
    Text = "你在迷霧中一無所獲"
  },
  Event_7006_Name = {
    Text = "混沌迷霧"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "【接起電話】獲得3選1高級刻印"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "【無視鈴聲】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7007_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7007_Desc = {
    Text = "「叮鈴鈴……」\n角落裡傳來刺耳的電話鈴聲，急促嘈雜，一聲高過一聲，幾乎令你產生了一種錯覺：如果你不接的話，它會立刻發瘋爆炸，然後毀滅世界。"
  },
  Event_7007_Name = {
    Text = "請接電話"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "【靠近幻影】獲得3選1白銀造物"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "【打散幻影】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_7008_Desc = {
    Text = "是密境中的海市蜃樓嗎？還是又一段無法離去的記憶？\n你揉了揉眼睛，遠處的幻影向你靠近——是人聲鼎沸的市場，是於融蝕中消失的蠟像館，是風雪交加的小鎮瘋人院，還是風景早已模糊的阿庫特？"
  },
  Event_7008_Name = {
    Text = "海市蜃樓"
  },
  Event_7009_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7009_Desc = {
    Text = "彷彿被滾水燙過一般，你條件反射地捂住了耳朵，將那些惡毒的樂聲隔絕在外。"
  },
  Event_7010_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7010_Desc = {
    Text = "明亮的大調彈走了緊張與恐懼，你熱情似火，你含苞待放，你歡欣雀躍，你大步流星把拉蒙娜遠遠甩在了身後——「守密人？！別走這麼快！」"
  },
  Event_7010_Name = {
    Text = "無名之音"
  },
  Event_7011_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7011_Desc = {
    Text = "「停下步子！！！匍匐爬行的融蝕怪物都比你熟悉自己的四肢！」\n放過觀眾……\n你在心裡這樣祈禱。"
  },
  Event_7011_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7012_ChoiceDesc1 = {
    Text = "【抽身離開】"
  },
  Event_7012_Desc = {
    Text = "這只是密境。\n你想要保護的，所要逃離的，是獨一無二的現實。"
  },
  Event_7012_Name = {
    Text = "螺旋深淵"
  },
  Event_7013_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7013_Desc = {
    Text = "「你才是最可恨的。」\n你將稿紙撕成碎片，揚在風中，碎成幾團飛花。\n詩人仰頭看著字元在風中紛飛，嘴角染上癡迷的弧度。\n「好美……」"
  },
  Event_7013_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7014_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7014_Desc = {
    Text = "你將海報整張撕了下來，發現背面潦草地記錄著蠟像館的各項開支。\n筆跡的主人顯然沒什麼算術的耐心和天分，這些帳目無論如何都抹不平。\n你草草看了一下，最大的開支應屬「蠟像養護清潔」。\n員工開支則少得可憐，最近的花銷是12支馬鬃毛皮鞭，價格大約20坊。\n還有一項特殊的開支——「它們的食物」。\n「它們」是指誰？"
  },
  Event_7014_Name = {
    Text = "黑暗中的笑聲"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7015_Desc = {
    Text = "「狡猾……而正確的回答。」\n聲音的主人對這個回答頗感興趣，一個銀色的物件被甩出水面。\n「記住，一切都有代價。」"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "【抓住第二隻蝴蝶】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "【不再流連】"
  },
  Event_7016_Desc = {
    Text = "祂們是精神維度的居民嗎？還是自融蝕誕生的生命。\n懷著疑問，你走進一場蝴蝶的風暴。"
  },
  Event_7016_Name = {
    Text = "靈知風暴"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "【觀察第三隻蝴蝶】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "【不再流連】"
  },
  Event_7017_Desc = {
    Text = "指間疼痛難耐，你猛地放開了手。"
  },
  Event_7017_Name = {
    Text = "靈知風暴"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印，感染「(Skill.Arg1)」"
  },
  Event_7018_Desc = {
    Text = "「你們人類再沒有別的答案了嗎？」\n聲音的主人發出不耐的低吼，整個空間隨之震顫。\n「貪婪且無知……這便是我厭倦你們的原因了。」"
  },
  Event_7019_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7019_Desc = {
    Text = "「放心吧，我只是給了貪得無厭的客人一點小小的懲罰而已。沒辦法，誰讓我不愛喝啤酒呢~」"
  },
  Event_7019_Name = {
    Text = "記憶碎片·啤酒"
  },
  Event_7020_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7020_Desc = {
    Text = "「別再唱了——」\n你警告五音不全的歌者，休想再來禍害你的耳朵。"
  },
  Event_7020_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒2名喚醒體"
  },
  Event_7021_Desc = {
    Text = "你轉身離去，卻迷失在長長的走廊中。 \n永無止境的回廊幾乎耗盡你的全部耐心，直到你發現一個小小的破舊舞臺。\n 你眨眨眼，舞臺便消失了。"
  },
  Event_7021_Name = {
    Text = "終幕禮Ⅱ"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "【拾起酒杯】獲得特殊卡牌"
  },
  Event_7022_Desc = {
    Text = "一杯澄澈如夕陽餘暉，搖曳如晚秋麥浪的金色液體，散發出如蜂蜜一般甜蜜誘人的香氣。它是什麼成分？是何人置於此處？為何無人照看？\n在這些問題得到解答之前，一個神秘的念頭爬上你的腦海：你必須要立刻、馬上喝掉它。\n此刻，你突然化身被火焰蠱惑的燈蛾，被豬籠草誘捕的飛蟲，不可自抑地拾起那杯甜酒——"
  },
  Event_7023_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7023_Desc = {
    Text = "你試圖檢查這扇門扉，在觸摸的時候，門扉竟然消失了，遠處傳來什麼東西被開啟的聲音"
  },
  Event_7023_Name = {
    Text = "奇怪的門扉"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "【不做處理】"
  },
  Event_7024_Desc = {
    Text = "弗朗西斯的辦公室冰冷而整潔，呈現出主人的一絲不苟。\n在角落的盒子上，你發現了一枚5英寸見方的灰塵拓印。\n掌印的形狀怪異——外圍輪廓似是野獸的足印，中間卻鑲嵌著小小的人類女孩的手印。像是先留下了人類的掌印，然後野獸的巨掌覆蓋其上。\n你當然可以幻想溫馨的畫面，例如某隻馴服順從的野獸將腳爪覆蓋在女孩的手背，致以溫柔的撫慰。\n但你知曉實情——那是某隻被殘忍實驗融合的怪物留下的印痕。"
  },
  Event_7024_Name = {
    Text = "巨獸足印"
  },
  Event_7025_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7025_Desc = {
    Text = "遊蕩的實驗體已經讓你很是疲憊，短暫的喘息也像是乾涸沙漠中的甘霖。"
  },
  Event_7025_Name = {
    Text = "無限之門"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "【主人】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7026_ChoiceDesc2 = {
    Text = "【帶走它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "【拆開它】獲得50黑印"
  },
  Event_7026_Desc = {
    Text = "你正向前走著，腳邊踢到了一個東西。\n那是個羅盤，玻璃罩已經破了，剩下的部分也沾滿了融蝕漿，你小心地將它翻過來，依稀看到背面陰刻的彌薩格大學校徽。"
  },
  Event_7026_Name = {
    Text = "她的選擇"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "【閱讀書信】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "【關好箱子】"
  },
  Event_7027_Desc = {
    Text = "一封，一封，又一封。\n信紙上寫滿了你的過去，又描繪著你的未來。受到異樣的蠱惑，你止不住地撕扯、吞食著信紙。\n「喂？你又在發什麼瘋？喝空氣？」\n墨菲一腳把你從幻覺中踢醒，回過神來，眼前什麼都沒有。"
  },
  Event_7027_Name = {
    Text = "不速來信"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_7028_Desc = {
    Text = "聽到你的聲音，人影停了下來，克萊門汀的聲音穿透水霧而來。\n「是你啊，」她的聲音模模糊糊，朦朦朧朧，像是被水化開的月光，「不用擔心，你會沒事的，他想，但他做不到。」\n「等你結束這裡，我們還會再見。」"
  },
  Event_7028_Name = {
    Text = "霧氣中的身影"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "【收件人：教務處】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "【收件人：搭檔】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7029_Desc = {
    Text = "在寫下收件人的刹那，信紙升騰起濃煙。無形的手穿越虛空，強硬地從你手中奪走了信紙——\n伴隨一陣類似咀嚼的聲響，身體倏地沉重了下來。\n但手中的造物告訴你，此行也並非全無收穫。"
  },
  Event_7029_Name = {
    Text = "單向傾訴"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_7030_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_7030_Name = {Text = "析出點"},
  Event_7031_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7031_Desc = {
    Text = "等他們從暗影中現身再說吧。"
  },
  Event_7031_Name = {
    Text = "提燈黑鴉"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "【呼喚烏鴉】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_7032_Desc = {
    Text = "漆黑之鳥受到感召，它們身體膨脹，將什麼東西吐在了你的手中。\n它們展翅回到桅杆之上，死死盯著你，目光灼灼。"
  },
  Event_7032_Name = {
    Text = "離群之鴉"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "【進入洞穴】"
  },
  Event_7033_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7033_Desc = {
    Text = "「咳，咳咳……」\n好熟悉的聲音……想起來了吱！\n人類生病或者快死的時候就會發出這種聲音！\n快過去看看吱！"
  },
  Event_7033_Name = {
    Text = "洞穴深處"
  },
  Event_7034_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7034_Desc = {
    Text = "你曾學習過有關銀芯的一切知識，包括如何鑒定它們的品階。\n顯然，這些銀芯無法達到精煉的基礎要求。\n你不得不放棄它們，以及可能被困在其中的破碎靈魂。\n學會捨棄也是守密人的必修課。"
  },
  Event_7034_Name = {
    Text = "被縛的靈魂"
  },
  Event_7035_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7035_Desc = {
    Text = "這是一個單向通道，你無法通過它回到入口"
  },
  Event_7036_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7036_Desc = {
    Text = "早結束，早安心。彌薩格的調查員從不畏懼危險。"
  },
  Event_7036_Name = {
    Text = "無限之門"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "【請你讓讓，我有急事】"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "【願聞其詳】"
  },
  Event_7037_Desc = {
    Text = "「這位同學，請留步。看你們面色凝重，行色匆匆，或許是陷入了某種困境吧。\n但人生不應當因為眼前的困局而放棄全盤的視角和冷靜的頭腦。\n比如我這幾天認真想了想，刻耳柏洛斯的傳說中有很多與現狀不符之處。」"
  },
  Event_7037_Name = {
    Text = "怪異旅伴Ⅱ"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "【接過禮物】"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "【婉言謝絕】"
  },
  Event_7038_Desc = {
    Text = "男孩坐在窗臺望著你。他已經等你很久了。\n「演出很成功，謝、謝你。」\n「我就要離開了……這是給你的禮物。」\n男孩向你攤開手。\n你看到一個包裝精美的禮盒，鮮血從中流淌而出，染紅了男孩的手。"
  },
  Event_7038_Name = {
    Text = "終幕禮Ⅵ"
  },
  Event_7039_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7039_Desc = {
    Text = "但願你永遠能有這樣的自信。"
  },
  Event_7039_Name = {
    Text = "無形倒影"
  },
  Event_7040_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7040_Desc = {
    Text = "你收下了這枚小小的、柔軟的耳朵。\n它裹在粘稠的油蠟裡，安靜地躺在你的掌心中央。\n你的心底升起一股強烈的責任感。\n首先酒吧是不能隨便去的，那裡的音樂過於穢亂。\n其次威靈頓花園劇院也不能去，那裡的管絃樂早就老掉牙了。\n然後……\n你和你的同伴們很好地接受自己多了一個小寵物的事實。"
  },
  Event_7040_Name = {
    Text = "側耳傾聽"
  },
  Event_7041_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7041_Desc = {
    Text = "「阿利斯泰爾教授是彌薩格的基石，離開他，彌薩格的一切體系都將停止運轉。」\n 你隱約記得某節令人昏昏欲睡的課堂上，訶勒特繃著臉敲著黑板說出這句話。\n如若這基石坍塌成碎塊，你又當如何自處？ 巨大的恐懼籠罩了你。 \n「你要去哪兒？」拉蒙娜的呼喚聲將你拉回現實。\n那是過去還是未來，是真實還是想像，或者是另一個維度的幻夢？你也不知道了。\n 你的手中，出現了一枚「贈禮」。"
  },
  Event_7042_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7042_Desc = {
    Text = "「這副輪椅就是我的第二雙腿腳，這輩子大概都離不開它了，」阿利斯泰爾教授苦笑著，「可惜的是讓我變矮了很多。」 \n\n所以，這不可能是真正的阿利斯泰爾教授。"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "【是誰在說話？】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7043_ChoiceDesc2 = {
    Text = "【什麼威士忌，給我也嚐嚐】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7043_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7043_Desc = {
    Text = "「你真的不嘗一口嗎？這可是上好的威士卡呢。要不是那家酒吧的老闆大方地送了我一整瓶，我可一滴都捨不得分給你喝呢。」\n「所以說，你幫他趕走了那個乾癟瘦削的，皮膚像橡膠一樣緊繃，只喝血腥瑪麗的傢伙，這是老闆給你的全部酬勞。為那次調查你付出了一個月時間，走訪了三十戶人家，吃了十一個閉門羹，消耗了十七枚左輪子彈。一瓶威士卡，你連本都收不回來。」\n「好啦好啦，不要計較那麼多嘛。至少，我們現在有這瓶威士卡，不是嗎？」"
  },
  Event_7043_Name = {
    Text = "回憶碎片·威士卡"
  },
  Event_7044_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7044_Desc = {
    Text = "你拉住了喚醒體的觸肢，他回頭看著你，眼中閃過晦暗不明的光。\n他什麼都沒說，你卻讀懂了他潛藏的話語——\n「僭越。」"
  },
  Event_7044_Name = {
    Text = "蝴蝶效應"
  },
  Event_7045_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7045_Desc = {
    Text = "電報機已經徹底損壞。你能想像電報機的主人在風暴中的絕望……因為此刻的你也是。"
  },
  Event_7045_Name = {
    Text = "前人遺物"
  },
  Event_7046_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7046_Desc = {
    Text = "姓名：雷婭\n年齡：20\n併發症：渴血癥伴隨嚴重歇斯底里\n贅生物：深紅觸手@2口器\n嫁接物：直系血親器官組織@3\n移交理由：沒什麼特別的理由。我不喜歡她。\n（後面的內容被劃掉了）"
  },
  Event_7046_Name = {
    Text = "器官登記"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "【選擇「接受賜福」】失去所有黑印。獲得1個黃金造物。"
  },
  Event_7047_Desc = {
    Text = "一團黑泥出現在你面前，顫巍巍遞來一份文件。\n「我現在不方便出面......不過您可以了解一下我們的訂製服務......」\n女聲自黑泥胸腔內飄出，略顯慌亂，似乎正在躲避什麼東西。\n「仙女賜福根據會員檔次生效，保證童叟無欺。」\n「籤，快籤！」"
  },
  Event_7047_Name = {
    Text = "仙女賜福"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "【側耳傾聽】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7048_ChoiceDesc2 = {
    Text = "【上前查看】所有喚醒體回復50狂氣，感染「(Skill.Arg1)」"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "【直接離開】獲得3選1刻印"
  },
  Event_7048_Desc = {
    Text = "「你知道嗎？」在拉蒙娜搜尋神秘人的身影時，一個聲音突然響起，像是誰在悄聲議論，「你知道那個事兒嗎？那個大事兒？」"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "【專注】刪除最多2張症狀卡。"
  },
  Event_7049_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_7049_ChoiceDesc3 = {
    Text = "【接通】回復 Arg2 點生命。"
  },
  Event_7049_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_7049_Name = {Text = "聯絡點"},
  Event_7050_ChoiceDesc1 = {
    Text = "【謹慎應對】提升 Arg1 點最大生命"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "【迎上前】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7050_Desc = {
    Text = "密境幻化出的影子向你伸出了手， 身姿影影綽綽。\n你記得，曾有一名彌薩格調查員登上了這艘船，會是他嗎？\n還是說，這只是又一個被密境束縛的可憐回憶。"
  },
  Event_7050_Name = {Text = "銀鑰使"},
  Event_7051_ChoiceDesc1 = {
    Text = "【離開】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7051_Desc = {
    Text = "「你看，因為我的一句閒話，就忽略了最緊急的情況，這可不好。\n再耽誤下去，你們的獵物就要逃遠了。\n為了表示抱歉，這些東西就送給你們吧。」\n\n男人自說自話地岔開話題，將某件物品遞給你們。"
  },
  Event_7051_Name = {
    Text = "怪異旅伴Ⅱ"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7052_Desc = {
    Text = "「祝你能得償所願。」\n男人不以為意，側身讓開一條道路。"
  },
  Event_7052_Name = {
    Text = "怪異旅伴Ⅱ"
  },
  Event_7053_Desc = {
    Text = "一種近水銀態的銀色物質，由融蝕黏液中提煉而出，蘊含強大精神力，主要用於在儀式中連結更多喚醒體。"
  },
  Event_7053_Name = {Text = "銀芯"},
  Event_7054_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7054_Desc = {
    Text = "你又走入新的岔路。\n太陽照常升起，人類照常死亡，而你照常迷路。\n沒有什麼是新鮮的。"
  },
  Event_7054_Name = {
    Text = "眼睛的迷宮"
  },
  Event_7055_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7056_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7056_Desc = {
    Text = "你轉過身，只看到一雙孤零零的皮鞋。\n「抱歉，我沒有惡意。」\n「如果你見到我的身體，請幫我轉告一聲，它最忠實的步行伴侶正靜候在1號展廳的45號陳列櫃。」\n「——記住，是牛皮的那一雙，不是山羊皮。」"
  },
  Event_7057_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7057_Desc = {
    Text = "一定是校友——你對著祂張開雙臂，可隨之而來的，是陰森入骨的疼痛。\n那疼痛消失後，四肢竟變得格外有力，前所未有。"
  },
  Event_7057_Name = {Text = "銀鑰使"},
  Event_7058_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7058_Desc = {
    Text = "你感受到眼前的迷霧似乎淡了\n\n你感覺接下來的行動中，自己的視線變得更敏銳了"
  },
  Event_7058_Name = {
    Text = "修羅試煉"
  },
  Event_7059_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7059_Desc = {
    Text = "幻影也向你靠近，記憶猛然回籠，眼前一片清明。"
  },
  Event_7059_Name = {
    Text = "海市蜃樓"
  },
  Event_7060_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7060_Desc = {
    Text = "祂的無意識仍在冥冥中改變了什麼。"
  },
  Event_7060_Name = {
    Text = "祂的注視"
  },
  Event_7061_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7061_Desc = {
    Text = "危急當前，現在不是收集銀芯的時候。"
  },
  Event_7061_Name = {
    Text = "存在的證明"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_7062_Desc = {
    Text = "朦朧的人影逐漸清晰，那不是什麼融蝕體，也不是災厄，而是沒有翅膀，神色如常的克萊門汀。\n「真巧啊，你也是來欣賞月光的嗎？」她笑著說，你卻感到一陣暈眩，「濃霧之夜，還是要多加小心哦。\n」這兒的小傢伙們，可不怎麼安分。「"
  },
  Event_7062_Name = {
    Text = "霧氣中的身影"
  },
  Event_7063_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7063_Desc = {
    Text = "隨著石膏塊擲向地面的破裂聲，她的軀體應聲而碎。 不甘的嘶吼充斥著你的腦海里，但所幸，你及時懸崖勒馬。"
  },
  Event_7063_Name = {
    Text = "補完殘軀"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "【聆聽悲傷】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7064_ChoiceDesc2 = {
    Text = "【聆聽喜悅】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_7064_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_7064_Desc = {
    Text = "悠揚、抒情、歡欣、哀傷……曲調在密境空間迴蕩，難以辨別其來源。\n這是幽靈船音響流淌出的奏鳴曲，還是被束縛在密境中的夜半狂想？"
  },
  Event_7064_Name = {
    Text = "無名之音"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "【他們在尋找某個人】刪除1張指令卡，獲得25黑印"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "【他們在尋找某件物品】複製一張牌庫中的牌，感染「(Skill.Arg1)」"
  },
  Event_7065_Desc = {
    Text = "提燈教眾為何會突然出現在拉伊小鎮？這裡的謎團太多了。\n地獄犬刻耳柏洛斯、拉伊瘋人院院長弗朗西斯、雕塑家協會，提燈教會……\n一定有某個源頭將他們彙聚在這個人丁並不興旺的小鎮。\n打字機突然自動噴發出油墨，彷彿引你前去輸入什麼。"
  },
  Event_7065_Name = {
    Text = "謎團輸入法"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "【緊閉雙眼】"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "【逃離現場】"
  },
  Event_7066_Desc = {
    Text = "演出戛然而止。你環顧四周，發現身邊坐滿了觀眾。\n它們長著和男孩一樣的臉，正齊刷刷地看著你。\n啊——\n它們無聲地朝你張開黑洞洞的嘴。"
  },
  Event_7066_Name = {
    Text = "終幕禮Ⅴ"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "【檢查膠捲】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，還可以使用一次"
  },
  Event_7067_Desc = {
    Text = "你將膠捲置於昏紅的燈光下，半透明的片基隱約透出影像。\n手、腳、眼球、內臟……包含一切你能想像到的、想像不到的人體器官，都被忠實地記錄在膠片中。\n它們被精心洗淨、擺放，工整得如同你寫的第一首格律詩。"
  },
  Event_7067_Name = {
    Text = "如實記錄"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "【公主的侍衛】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "【沉思者】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7068_Desc = {
    Text = "「嗒，嗒，嗒……」\n腳步聲由遠及近，眼看有人就要推開工作室的大門。\n你們退無可退，只能借著昏暗的光線假扮成蠟像，企圖躲過那雙審視之眼。"
  },
  Event_7068_Name = {
    Text = "以假亂真"
  },
  Event_7069_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7069_Desc = {
    Text = "「太好了，太好了！」聲音充滿了喜悅，「你終於變得和我一樣了，莎莎姐姐！」"
  },
  Event_7070_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7070_Desc = {
    Text = "或許是某個人將他們引至這裡。\n隨著你的探索，那個人的身分終將浮出水面。"
  },
  Event_7070_Name = {
    Text = "謎團輸入法"
  },
  Event_7071_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7071_Desc = {
    Text = "早結束，早安心。彌薩格的調查員從不畏懼危險。"
  },
  Event_7071_Name = {
    Text = "無盡門扉"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "【選擇道德】回復 Arg1 點生命"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "【選擇生命】回復全部血量，感染「(Skill.Arg2)」"
  },
  Event_7072_Desc = {
    Text = "你或許曾有一顆金子般的心。\n它不分晝夜地鼓動著，為了你的生命和生活竭盡全力……溫暖、熱烈而充滿希冀。\n可它不知何時，速度逐漸慢了下來。彷彿生命與道德，它只能再承受其一……"
  },
  Event_7072_Name = {
    Text = "詛咒渴望"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "【檢查膠捲】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，可以使用兩次"
  },
  Event_7073_Desc = {
    Text = "「所以，你如實記錄下了所有的一切。」\n「是的，膠捲裡就是真相。」\n交談的聲音陡然停下，無數雙無形的眼睛齊齊指向了你，似乎在等待你最後的判決。"
  },
  Event_7073_Name = {
    Text = "目擊證言"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "【離開】提升 Arg1 點生命，並獲得25黑印"
  },
  Event_7074_Desc = {
    Text = "你的呼聲被風的呼嘯吞沒。\n「你不必認識我，」夾雜在語句中的嘶嘶聲愈發清晰，「赫伯特，赫伯特才是你們要找的人。讓那傢伙墜落吧，從虛假的幻夢裡，墜入嚴酷冰冷的現實。」\n「我將賜福於你們，賜予你們這世間最美味的……」"
  },
  Event_7074_Name = {
    Text = "怪異旅伴Ⅵ"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7075_Desc = {
    Text = "「是啊，可憐的迷失者，擁有力量卻沒能認清自己之人。\n你要施以援手嗎？還是向祂舉起武器呢？」\n男人縱身躍入湍急的流水，在他躍下的瞬間，你與他的視線恰好對上。那是一雙滴落的蜂蜜般金黃的，屬於蛇的豎瞳。\n而在他剛才站立的位置，留著一盞小小的，散發著紫色煙霧的燈。"
  },
  Event_7075_Name = {
    Text = "怪異旅伴Ⅵ"
  },
  Event_7076_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7076_Desc = {
    Text = "「謹慎是一種美德，但過度謹慎則是一種不合時宜，」一成不變的平穩聲音中暗含不滿，「星辰的運轉會干擾喚醒體沉睡的本源，而恰當的時機能夠讓祂們的狂氣像吹氣球那樣快速膨脹充盈起來。總之，現在還來得及抓住彗星的尾巴，下次記得優化你那和烏龜不分伯仲的反應速度。」"
  },
  Event_7077_ChoiceDesc1 = {
    Text = "【回復】當前壓力減少一半。"
  },
  Event_7077_Desc = {
    Text = "你接觸了穩壓艙，可以回復當前壓力值"
  },
  Event_7077_Name = {
    Text = "壓力穩定點"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "【安慰她】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "【指責她】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7078_Desc = {
    Text = "「我是那死去調查員的陰影，兇手是那把銀色的鑰匙。」\n女子痛苦地捂住頭。她的頭髮很濃密，上面有無數隻亮晶晶的眼睛眨啊，眨啊……\n「他們總說：不行，夏洛特！唉，夏洛特！\n所以我想，如果我能一次性連結很多喚醒體，所有人都會閉嘴。」\n「然後……我也不知道發生了什麼，醒來後我就成了這副模樣。唉！」"
  },
  Event_7078_Name = {
    Text = "調查員的陰影"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "【翻過高牆】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7079_ChoiceDesc2 = {
    Text = "【進入迷宮】隨機1張卡牌獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7079_Desc = {
    Text = "你的大腦是一所迷宮。\n太多的念頭糾纏其中，出口就在目光可及之處，思維的高牆林立於你們之間。"
  },
  Event_7079_Name = {
    Text = "思維迷宮"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "【遠望幻影】獲得3選1白銀造物"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "【湊近幻影】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_7080_Desc = {
    Text = "遠方似有火山錐噴發，狂風肆虐的天空中升騰起人形的煙霧。\n這可是艾爾沃斯，艾爾沃斯只有連綿不絕的高聳雪山和石灰石岩層的溶洞。\n是連日的異狀讓你精神錯亂了嗎？"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "【我看見了什麼】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "【我什麼都沒看見】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7081_Desc = {
    Text = "你的眼底滲漏出液體，粘稠的觸感讓人心驚。\n歸根究底，它因你所見之物而起，而你——真的什麼都沒看見嗎？"
  },
  Event_7081_Name = {
    Text = "不可直視"
  },
  Event_7082_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7082_Desc = {
    Text = "你也會歡喜，也會憂愁，但此刻淹沒你的不是你的情感。你捂住耳朵，銀鑰匙閃爍耀眼的光。\n終於，你能呼吸了。"
  },
  Event_7083_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7083_Desc = {
    Text = "持匕者發出了鳴叫，如午夜墓園的報喪鳥一般。\n聲音轉瞬即逝，連帶另外兩個蹈海者也不見蹤影……原來只是密境映照出的一段幻象。"
  },
  Event_7083_Name = {
    Text = "窮追不舍"
  },
  Event_7084_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7084_Desc = {
    Text = "它就那麼靜靜地懸在空中，一眨不眨，目光懇切，似乎是想告訴你什麼。\n眼睛或許寄宿了靈魂，但如果沒有言語，你也只能感到一絲急切，一絲悲傷。\n它憑空消散了。"
  },
  Event_7084_Name = {
    Text = "盲目注視"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "【表示贊同】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7085_ChoiceDesc2 = {
    Text = "【送上禮物】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7085_ChoiceDesc3 = {
    Text = "【轉身離開】獲得25黑印"
  },
  Event_7085_Desc = {
    Text = "「如果有一天我必將墜落，那麼我希望能落在水中。\n漫過鼻腔的流水像一場溫柔的舊夢，\n我沉沒的液體，\n是@2最渴望的碗盞。」"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "【抵抗幻覺】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7086_ChoiceDesc2 = {
    Text = "【汲取狂氣】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_7086_Desc = {
    Text = "殘缺的維度逐漸崩塌，其他維度的幻覺湧入病態的房間。"
  },
  Event_7086_Name = {
    Text = "維度幻象"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "【離開】隨機覺醒1名喚醒體"
  },
  Event_7087_Desc = {
    Text = "少女一怔，抬手在裙邊撫過。\n「我能為你做的……只有這些了。」"
  },
  Event_7088_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7088_Desc = {
    Text = "是誰在說話？\n你低下頭，只看到一個模糊的倒影——它穿著與你相同的衣服，但手裡握著一把刀，正在衝你露出微笑。"
  },
  Event_7088_Name = {
    Text = "你不會想要找到"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "【順應軀體的記憶】跳過戰鬥立即勝利，但失去 Arg1 點生命值。"
  },
  Event_70892_ChoiceDesc2 = {
    Text = "【離開】進入戰鬥"
  },
  Event_70892_Desc = {
    Text = "儘管敵人異常強大，但你已熟知戰勝它們的技巧。"
  },
  Event_70892_Name = {
    Text = "肌肉記憶"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "【拉開庫姆】"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "【攻擊實驗體】"
  },
  Event_7089_Desc = {
    Text = "庫姆撕咬住一個實驗體的後脖頸，正準備甩動，實驗體突然像貓頭鷹一樣180°扭過頭顱，朝著庫姆的面部啄去。"
  },
  Event_7089_Name = {Text = "鬥獸場"},
  Event_7090_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7090_Desc = {
    Text = "你握緊銀鑰匙，在維度的暗湧中感應本源的呼喚。\n為對抗正體不明的邪惡地獄犬，你必須盡可能借用一切可能的力量。"
  },
  Event_7090_Name = {
    Text = "維度幻象"
  },
  Event_7091_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7091_Desc = {
    Text = "「至於那個調查員，館長大人打算親自問訊……\n留活口……」\n聲音逐漸低弱，最終隱入黑暗。"
  },
  Event_7091_Name = {
    Text = "隔牆有耳"
  },
  Event_7092_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7092_Desc = {
    Text = "失重感讓你猛地清醒過來，腳下的地面堅實可靠，而在你腳邊躺著的，是一塊精緻的方形鏡子。"
  },
  Event_7092_Name = {Text = "鏡中鏡"},
  Event_7093_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7093_Desc = {
    Text = "你從不和已陷入瘋狂、無藥可救的人論辯，這會讓你的靈魂在午夜的質問中被徹底吞噬，饒過你吧！"
  },
  Event_7094_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7094_Desc = {
    Text = "蠟像的臉，應該是什麼模樣呢？\n你閉上雙眼，腦海中浮現千萬張模糊的臉孔。\n它們像一支支拖著蒼白的火焰的蠟燭，在黑暗的河流中湧現、消失……\n你沿著河流走到盡頭，那裡佇立著唯一的、最後的蠟像。\n靠近它的時候，你看到了……@2。"
  },
  Event_7094_Name = {
    Text = "未完的蠟像"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "【襲擊持匕者】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_7095_ChoiceDesc2 = {
    Text = "【埋伏持刀者】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_7095_ChoiceDesc3 = {
    Text = "【絆倒持矛者】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7095_Desc = {
    Text = "三名蹈海者死死咬著你們不放，瘋狂炙熱的目光幾乎要點燃你的斗篷。\n回頭一瞥，你注意到他們三個各有不同——\n舉著巨刀的蹈海者喊聲最為暴躁，行事卻有些漫不經心。\n手持長矛的蹈海者亦步亦趨，像牙牙學語的孩童。\n緊握匕首的蹈海者落在最後，口中喋喋吐出的祈禱證明了其狂熱。"
  },
  Event_7095_Name = {
    Text = "窮追不舍"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7096_Desc = {
    Text = "你接過禮物，小心翼翼地拆開。\n 一對眼球靜靜躺在禮盒裡。 \n「我把我的眼睛送給你。」 \n「就像他曾經對我做的那樣。」"
  },
  Event_7096_Name = {
    Text = "終幕禮Ⅵ"
  },
  Event_7097_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7097_Desc = {
    Text = "伸手穿過光輝的中心，你拾起了一滴固化的銀芯。這滴記憶與靈魂的珍貴載體滾燙無比，折射著異樣的色彩。\n在它將所有的光都扭曲攪勻前，火燒的灼痛讓你忍不住將它重新投入了黑暗。"
  },
  Event_7097_Name = {
    Text = "暗夜螢光"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7098_Desc = {
    Text = "你拒絕了男孩的禮物。 \n男孩用他空洞的眼眶注視著你。他輕輕歎了一口氣。\n 「那麼，再見了。」 \n男孩說罷，向你擺出謝幕的姿勢，然後倒向窗外。 \n他消失了，像一隻翩然起舞的蝴蝶，又像一陣風。"
  },
  Event_7098_Name = {
    Text = "終幕禮Ⅵ"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "選擇普通刻印"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "【收下耳朵】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7100_ChoiceDesc2 = {
    Text = "【拒絕請求】獲得3選1刻印"
  },
  Event_7100_Desc = {
    Text = "一連串華麗的音符自指尖傾瀉而出。\n憂鬱的蠟像鋼琴師獨坐窗前。\n自有意識起，蠟像館就是他全部的世界。\n他長久閉塞，也想聽點不一樣的東西，尤其是……一種名為爵士的音樂。\n最後他撕下自己的一隻耳朵，請求你將它帶走。\n「讓我聽聽外面的音樂吧……只需要把它裝進口袋。」"
  },
  Event_7100_Name = {
    Text = "側耳傾聽"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "【接通】回復 Arg2 點生命。[ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。[ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "【驅逐】移除最多 3 張症狀卡，獲得 Arg2 黑印。"
  },
  Event_7101_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_7101_Name = {Text = "聯絡點"},
  Event_7101_Tips3 = {
    Text = "當前並未擁有症狀卡"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "【接受挑戰】"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "【給祂一拳】獲得25黑印"
  },
  Event_7102_Desc = {
    Text = "消瘦的人形自陰影浮現，擋住了你的去路。\n一段永遠被束縛的記憶憑空闖入密境，自稱「N」的虛影拋玩著手中籌碼，用含糊不清的嗚咽邀請你加入祂的遊戲。\n三色籌碼在你面前鋪開，不和祂玩一局「遊戲」，祂恐怕不會輕易放你離開。"
  },
  Event_7102_Name = {
    Text = "好戲開場"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_7103_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_7103_Name = {Text = "析出點"},
  Event_7104_ChoiceDesc1 = {
    Text = "【掙扎著醒來】提高 Arg1 點最大生命"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "【縱容自己沉眠】隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染2張「(Skill.Arg2)」"
  },
  Event_7104_Desc = {
    Text = "你懷裡捧著一塊晶亮的珍寶。\n它自胸口攀附向你的全身，那散發著燭火光芒的溫熱記憶，最終被倒灌入腦中。\n劈啪作響的炭火、爐邊擁毯的安樂椅、醇厚的熱茶和蜷在腳邊的貓肚皮……\n在這舒適的困倦中，你頭腦昏沉，墜入一片綿軟。"
  },
  Event_7104_Name = {
    Text = "沉湎舊日"
  },
  Event_7105_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7105_Desc = {
    Text = "你毫不留情地扯出了另外半截膠片，它們藏身於相機肚內，驟然被拉出，上面的畫面卻叫你久久無言。\n未經沖洗的膠片，忠實地記錄下了——你倒在一灘黑泥中的畫面。"
  },
  Event_7105_Name = {
    Text = "記錄無罪"
  },
  Event_7106_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7106_Desc = {
    Text = "你妥善檢查了一番相機，皮革與黑金嵌在機體中，折射出幾分油亮的光澤。\n它的鏡頭對準了你，彷彿在凝視，在窺探……"
  },
  Event_7106_Name = {
    Text = "記錄無罪"
  },
  Event_7107_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7107_Desc = {
    Text = "掬於掌心的一捧月光，被灑落在石碑上。\n有人被埋在了厚重的淤泥之下，旁觀的人群聲稱，此人迎來了自然凋亡，將安眠於地下。\n可那埋藏的淤泥湧動，慘叫聲中，卻爬出了一團癱軟的月亮。"
  },
  Event_7107_Name = {
    Text = "銀月碎片"
  },
  Event_7108_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7108_Desc = {
    Text = "你輕輕觸摸蝴蝶纖薄的黑翼，蝴蝶輕輕振翅，然後化作漆黑的液滴，落在你的掌心。"
  },
  Event_7108_Name = {
    Text = "不應存在之物"
  },
  Event_7109_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7109_Desc = {
    Text = "孤月高懸於天，你卻能聽清它祝禱的頌詞，古怪的音調，像極了污穢之物的細語呢喃。\n禱告停止，你正要離開。身後卻亮起一道白色的虛影。\n「窺伺命運和祝禱的褻瀆之人，恩賜與代價都將如約而至。」"
  },
  Event_7109_Name = {
    Text = "銀月碎片"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "【三點】"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "【六點】"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "【一點】"
  },
  Event_7110_Desc = {
    Text = "看樣子你今天的運氣還不錯。\n骰子顫動起來，發出興奮的嗡鳴聲。\n你決定猜一個點數"
  },
  Event_7110_Name = {
    Text = "無止境的賭局"
  },
  Event_7111_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7111_Desc = {
    Text = "這場賭局是個巨大的騙局！\n你「噌」地站起身，卻感到一陣頭暈目眩。\n骰子們發出鼓噪的嗡鳴聲，充滿魅惑的聲音不斷縈繞在你的腦海：\n「唯一一把……最後一把……」"
  },
  Event_7111_Name = {
    Text = "無止境的賭局"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "【使用銀芯】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "【收起銀芯】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7112_ChoiceDesc3 = {
    Text = "【放回抽屜】獲得25黑印"
  },
  Event_7112_Desc = {
    Text = "在辦公桌右手邊第二個的抽屜中，孤零零地擺放著一枚成型的銀芯。輕輕觸摸時，你聽見了風暴的呼嘯，夾雜著雪粒摩擦的粉碎聲，夾雜著嗚咽的笛聲……"
  },
  Event_7112_Name = {
    Text = "孤獨銀芯"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "【側耳傾聽】感染「(Skill.Arg1)」，獲得詛咒造物-「(RelicConfig.Arg2)」"
  },
  Event_7113_ChoiceDesc2 = {
    Text = "【做出改變】選擇銷毀1個造物，獲得1個獎勵"
  },
  Event_7113_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7113_Desc = {
    Text = "不是所有樂曲都動人。\n純粹的不協和音組成了一段悲鳴。"
  },
  Event_7113_Name = {
    Text = "不協和音"
  },
  Event_7114_ChoiceDesc1 = {
    Text = "【拾起它】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_7114_ChoiceDesc2 = {
    Text = "【放棄它】獲得25黑印。"
  },
  Event_7114_Desc = {
    Text = "隱蔽腐臭的草垛角落，開裂的融蝕痕之中，靜靜地躺著某件物什。"
  },
  Event_7114_Name = {
    Text = "草垛之後"
  },
  Event_7115_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7115_Desc = {
    Text = "那身影未靠得更近，祂在凝視你片刻後，化為了一抔銀沙。"
  },
  Event_7115_Name = {Text = "銀鑰使"},
  Event_7116_ChoiceDesc1 = {
    Text = "【握住觸肢】接受圖魯的幫助"
  },
  Event_7116_Desc = {
    Text = "一聲歎息後，圖魯追了上來。\n沉重、冰涼的觸肢勾住了你，澆滅了想要單刀直入敵陣的可怕念頭。\n「余將成為你的助力，僅限當下。」"
  },
  Event_7116_Name = {
    Text = "代行者的承諾"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "【獲得鑰匙】"
  },
  Event_7117_Desc = {
    Text = "1、2、3……\n詹金和書桌的距離有10英尺。\n這是一個很短的距離，卻又長得像她的一生。\n她想起柔軟的緞帶，想起金色的蝴蝶糖紙，也想起母親的眼淚。\n她還想了很多，很多……\n瘦弱的身軀淌過黑色河流，一點點靠近書桌。\n鑰匙就在抽屜裡，獲得它需要付出的代價也很簡單：勇氣、靈巧，外加那麼一丁點運氣。\n除了運氣，詹金什麼都不缺。"
  },
  Event_7117_Name = {
    Text = "最終的鑰匙"
  },
  Event_7118_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7118_Desc = {
    Text = "一場賭局而已，你不會輸的。\n鐫刻著紋理的硬幣被高高拋起，再迅速下落，被你的掌心侵染上溫熱。"
  },
  Event_7118_Name = {
    Text = "馳名的賭徒"
  },
  Event_7119_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7119_Desc = {
    Text = "一場賭局而已，你不會輸的。\n鐫刻著紋理的硬幣被高高拋起，再迅速下落，被你的掌心侵染上溫熱。"
  },
  Event_7119_Name = {
    Text = "馳名的賭徒"
  },
  Event_7120_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7120_Desc = {
    Text = "一場賭局而已，你不會輸的。\n鐫刻著紋理的硬幣被高高拋起，再迅速下落，被你的掌心侵染上溫熱。"
  },
  Event_7120_Name = {
    Text = "馳名的賭徒"
  },
  Event_7121_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7121_Desc = {
    Text = "你無意加入這場嚴肅的鋼琴課。\n每當彈完一個小節，學生都會吃力地擰轉頭顱，做出傾聽的模樣。\n而他的老師也會稍稍彎腰，嘴唇一張一合，圓圓的眼睛看著根本不存在的樂譜。\n他們顯然不知道自己在做什麼，也永遠不會明白為什麼人類會花費數年來進行這種機械的練習。\n他們只是模仿罷了。"
  },
  Event_7121_Name = {Text = "鋼琴課"},
  Event_7122_ChoiceDesc1 = {
    Text = "【插入銀鑰匙】"
  },
  Event_7122_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_7122_Name = {Text = "析出點"},
  Event_7123_ChoiceDesc1 = {
    Text = "【辨認歌詞】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7123_ChoiceDesc2 = {
    Text = "【輕輕哼唱】獲得3選1刻印"
  },
  Event_7123_Desc = {
    Text = "古老的船歌在密境中迴蕩。\n被密境困住的記憶用著你聞所未聞的語言，吟唱著海浪、天空與烈酒。"
  },
  Event_7123_Name = {
    Text = "海洋歌謠"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "【呼喚烏鴉】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "【遠遠離開】"
  },
  Event_7124_Desc = {
    Text = "漆黑之鳥緊緊盯著你，許久過後，從它們的羽毛下落出了什麼……"
  },
  Event_7124_Name = {
    Text = "離群之鴉"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "【上前握住】獲得25黑印"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "【友好回應】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_7125_Desc = {
    Text = "一隻不知從何而來的貓端坐在融蝕漿之間，輪廓模糊的軀體說明它應當是精神維度的住民。\n這個看不清面孔的投影用智慧的目光望著拉蒙娜，它抬起潔白的前爪，招手一般朝她示意。"
  },
  Event_7125_Name = {
    Text = "遊走的住民"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "【忽略聲音】"
  },
  Event_7126_Desc = {
    Text = "敵人的攻勢驟雨般落在身後，刀鋒數次從斗篷上劃過，驚起停留碼頭的一群鷗鳥。\n「向北…或上船……」\n再傻的人也能意識到，有什麼力量在暗中幫助著你。"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "【聆聽太陽】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7127_Desc = {
    Text = "在現實與虛幻的交織中，天體順著既定軌道永恆回轉。\n無數次的擦肩而過，奏出了一曲又一曲奇異詭譎的樂章……"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "【隨悲傷離去】複製卡牌，如果複製症狀卡，獲得75黑印"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "【隨憤怒離去】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7128_Desc = {
    Text = "液體從瞳孔噴湧而出，冰冷而洶湧地帶走了部分靈魂。"
  },
  Event_7128_Name = {
    Text = "冥灘之淚"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "【背道而馳】獲得25黑印"
  },
  Event_7129_Desc = {
    Text = "慘白月光無視了時間的流轉，傾瀉在寂靜回廊之上。\n門洞在月光的照射下，發出詭譎的光。"
  },
  Event_7129_Name = {
    Text = "寂靜回廊"
  },
  Event_7130_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7130_Desc = {
    Text = "你決定修復這尊蠟像。\n蠟像的附近散落著一些工具，你選中一種名為「普魯士藍」的染料。\n它藍得就像一種疾病。"
  },
  Event_7130_Name = {
    Text = "未完的蠟像"
  },
  Event_7131_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7131_Desc = {
    Text = "膿皰發出一聲尖銳而令人毛骨悚然的嘯叫，耳後傳來不應存在的呼嘯風聲、幻覺般的笛聲、膿液湧動的禁斷之聲。\n膿皰古怪地抽搐了片刻，然後僵硬著陷入死寂。目睹此景，你身旁的喚醒體彷彿受到了某種感召。"
  },
  Event_7131_Name = {
    Text = "古怪膿皰"
  },
  Event_7132_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7132_Desc = {
    Text = "你的指尖觸碰著雕像，觸感卻時有意外柔軟的凹陷，你總以為那是錯覺。"
  },
  Event_7132_Name = {
    Text = "拼湊殘軀"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "【為她落淚】"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "【向她祈禱】"
  },
  Event_7133_Desc = {
    Text = "身體接觸到船舷的瞬間，不屬於自己的記憶湧入腦海。\n人們給她換上聖潔的白裙，用珠寶把她裝點得精緻素雅，人們把她架上高高的祭壇，小鎮居民在腳下匍匐跪拜。\n那是一雙雙充滿希冀的眼睛：水手希望她能庇佑航行，漁民希望迎來無風無浪的漁季，更多的鎮民希望獲得一年的順遂。\n跪拜的人群中，有她兒時的玩伴，也有朝夕相處的父母手足。\n她什麼都不想要，她不知道自己想要什麼。\n被動回應祈願，彷彿是她生命中唯一的職責。"
  },
  Event_7133_Name = {
    Text = "航前典儀"
  },
  Event_7134_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7134_Desc = {
    Text = "那具殘缺的身體蒼白的瞳仁緩慢地轉動著，注視著你抽身離去的身影，露出了一個慘澹的笑容。"
  },
  Event_7134_Name = {
    Text = "拼湊殘軀"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "【主動迎戰】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7135_ChoiceDesc2 = {
    Text = "【放棄抵抗】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "【趕緊開溜】獲得50黑印"
  },
  Event_7135_Desc = {
    Text = "幾個蠟像泥坯擋住了你的去路。\n它們歪歪扭扭，面容粗糲，望之不似羅傑斯應有的製作水準。\n「命令……大人的命令……」"
  },
  Event_7135_Name = {Text = "習作"},
  Event_7136_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7136_Desc = {
    Text = "你選擇勇敢地直視眼睛。\n它們是璀璨的繁星，在黑暗中閃閃發光。\n隨後它們笑了起來，又變成無數個彎彎的月亮。\n「你不懼怕目光。你也不應當懼怕……\n好久不見，@2」\n消失前，它們送給你一件小小的禮物，作為「重逢的紀念」。"
  },
  Event_7137_ChoiceDesc1 = {
    Text = "【打開開關】擴大當前視野[ExDesc1]。"
  },
  Event_7137_Desc = {
    Text = "前人遺留下來的照明裝置，能驅散四周的黑色迷霧。\n它周圍的霧氣規律地波動著，像是被它的呼吸驚擾。"
  },
  Event_7137_Name = {Text = "探照燈"},
  Event_7138_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7138_Desc = {
    Text = "你的背部撐開透明的羽翼，盤旋著，盤旋著，與烏鴉一同流入靜寂的海底。"
  },
  Event_7138_Name = {
    Text = "群鴉之聲"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "【消滅它】獲得「畸變之心」"
  },
  Event_7139_Desc = {
    Text = "被不知什麼人遺棄在道路旁的畸形膿皰，表面流轉著污濁油綠的光澤，此刻正在躁動不安地變形蠕動著。\n相較於怪物，它更像裸露在烈日下接受灼燒的霜淇淋，很快就要化成一灘粘稠的濁水，然後消失於空氣中。"
  },
  Event_7139_Name = {
    Text = "古怪膿皰"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "【放下捂耳的雙手】感染「(Skill.Arg1)」，選擇獲取一個獎勵"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "【抓住一隻烏鴉】獲得「(Skill.Arg1)」，選擇獲取一個獎勵"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "【閉上雙眼】獲得50黑印"
  },
  Event_7140_Desc = {
    Text = "尖嘯，毫無盡頭的尖嘯——\n烏鴉歌者披著黑亮的皮毛，尖喙上泛著冷硬的寒光，嘹亮的悲鳴一次次劃破你的耳膜。\n放下你捂耳的手吧！\n夜間縱情引吭的鴉群，要暢飲你蜷縮之軀內，那未經淬煉的戰慄。\n"
  },
  Event_7140_Name = {
    Text = "群鴉之歌"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "【離開】沒有任何發現"
  },
  Event_7141_Name = {Text = "2_6臨時"},
  Event_7142_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7142_Desc = {
    Text = "你選擇繼續前行。\n相比那些糟糕的蠟像藝術對你造成的精神與物理傷害，這點小小的困擾實在算不得什麼。\n你還有更偉大的事業要完成。"
  },
  Event_7142_Name = {Text = "腳步聲"},
  Event_7143_ChoiceDesc1 = {
    Text = "【指出問題】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7143_Desc = {
    Text = "「幹嘛！就這麼喜歡戳別人傷口嗎！」\n「是啦！我現在就是平白無故年紀大了二十五歲！現在你要叫我墨菲姐姐！」"
  },
  Event_7143_Name = {
    Text = "被禁錮的生命"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_7144_Desc = {
    Text = "少女的面容沉靜如今夜的月光，她沒有回應你，卻高高舉起了手中的羅盤——她在顫抖，舉起著小小的羅盤彷彿就用盡了她的生命。"
  },
  Event_7145_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7145_Desc = {
    Text = "「美味！美味！」烏鴉怪笑著，腐敗的氣息隨著它展開的雙翼彌散至你的鼻腔。"
  },
  Event_7145_Name = {
    Text = "詛咒怪鴉"
  },
  Event_7146_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7146_Desc = {
    Text = "要我說，噪音絕對是新世代的楷模。\n它們堅定地踏著毫無規律的節拍以及令人崩潰的旋律在世上橫行肆虐。\n沒有憐憫，沒有動搖，也沒有妥協。\n厭惡規律，摒棄主題，噪音從不取悅他人——\n當然，這其中也包括我們的蠟像師。"
  },
  Event_7147_ChoiceDesc1 = {
    Text = "【領路】"
  },
  Event_7147_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7147_Desc = {
    Text = "有人在輕輕拉動你的衣角。\n是剛才見過的男孩。他蹲在角落憂鬱地望向你。\n「我要參、參加學院的演出。\n可是，我找不到去舞臺的路。」"
  },
  Event_7147_Name = {
    Text = "終幕禮Ⅱ"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7148_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7148_Desc = {
    Text = "鼻尖聞到了熟悉的氣味，家常而令人滿足，當你想再嗅一嗅食堂香氣時，那飄溢的香氣卻消失得一乾二淨。"
  },
  Event_7148_Name = {
    Text = "異常聯絡"
  },
  Event_7149_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7149_Desc = {
    Text = "祂們是溫暖的色彩。\n熱烈的，溫柔的，愛憐的色彩。\n祂們給予了女孩一個令人懷念的擁抱，像風一般消失。"
  },
  Event_7149_Name = {
    Text = "懷念的色彩"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "【你究竟是什麼人？】"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "【要怎麼轉變思路？】"
  },
  Event_7150_Desc = {
    Text = "長髮的男人再次攔在了你們的道路前方。有了上次的經歷，拉蒙娜面色不善。\n「稍安勿躁，我的朋友。」男人緩緩開口，他的聲音磁性而魅惑，發聲的方式好似氣流通過狹窄的氣道，夾雜著嘶嘶的摩擦聲響。\n「我已經觀察好些時候了，轉變思路才能使你接近目標。」"
  },
  Event_7150_Name = {
    Text = "怪異旅伴Ⅲ"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "【我在尋找】提升 Arg1 點最大生命"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "【我在迴避】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7151_Desc = {
    Text = "「我看到有人在尋找，尋找那不可尋找之物，那悲哀的相對之物，那被稱為真相之物。\n我看到有人在迴避，迴避那不可迴避之物，那被掩藏的殘酷之物，那被稱為真相之物。\n你是哪一個？」"
  },
  Event_7151_Name = {
    Text = "追尋之物"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "【仔細查看】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "【嘗試聆聽】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7152_ChoiceDesc3 = {
    Text = "【小心收好】獲得25黑印"
  },
  Event_7152_Desc = {
    Text = "前方的迷霧被一個細小的東西映亮，那看上去像是玻璃或者晶體的碎片，裡面湧動著無數或顯眼或暗淡的色彩。"
  },
  Event_7152_Name = {
    Text = "我們的回憶"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "【接受挑戰】勝利獲得白銀造物，失敗獲得症狀。無論勝負，都不影響後續調查。"
  },
  Event_7153_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7153_Desc = {
    Text = "倒影中的人是誰？\n祂有著與你同步的呼吸、同頻的心跳，共用著同一個詭異的壞點子。\n是密境的惡作劇，還是跨越維度之影？\n似乎這是一個虛幻的挑戰邀請？"
  },
  Event_7153_Name = {
    Text = "靈魂共振"
  },
  Event_7154_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7154_Desc = {
    Text = "視線超越了歷史與時間，它也許是非線性的，它也許正從星球誕生前的混沌中俯視你。\n也或許，它在未來的某一日等著你。"
  },
  Event_7154_Name = {Text = "窺視"},
  Event_7155_ChoiceDesc1 = {
    Text = "【領取】獲得50黑印"
  },
  Event_7155_Desc = {
    Text = "那裡空無一物，漆黑的液體橫流於地面上，倒映不出任何。\n是你的錯覺嗎？你感覺什麼東西在指縫溜走。"
  },
  Event_7155_Name = {
    Text = "鏡面之下"
  },
  Event_7156_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7156_Desc = {
    Text = "「您真是個大方的好人，祝您今天、明天、後天都心想事成。」\n「順便說一句，我們這是一錘子買賣......」\n仙女滿意地咂咂嘴，依依不舍和您道了個別。"
  },
  Event_7156_Name = {
    Text = "仙女賜福"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "【把錢包還給我！】獲得3選1刻印"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "【猶豫】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7157_Desc = {
    Text = "「來呀，來取回你的錢包！」遠方的孩童揮著手。\n你向前奔去，伸出手的瞬間，腦中突然響起巨大而雜亂的噪聲。\n「哪來的髒孩子！」\n「是街頭的小老鼠，怎麼敢觸碰公爵夫人的紗裙！」\n「快把他趕出去！」\n「你帶了硬幣嗎？沒有硬幣，一個黑麵包也別想拿走！」"
  },
  Event_7157_Name = {Text = "無之書"},
  Event_7158_ChoiceDesc1 = {
    Text = "【追尋歌聲】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "【隨之歌唱】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_7158_Desc = {
    Text = "渺遠的歌聲被崩碎成幾點星屑：\n「我詛咒夜巷的一灘髒水，頹圮的牆根處綴著腐敗的花，鎖鏈攀附著大腦墜入泥淖，在濃霧抹去我的存在前，暮色將沉入最深的@2。」"
  },
  Event_7158_Name = {
    Text = "白質詛咒"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "【留下供奉】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7159_ChoiceDesc2 = {
    Text = "【帶祂離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7159_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7159_Desc = {
    Text = "在你靠近時，無序的混沌靈魂從泥潭中驟然出現。\n黑色的上肢緊緊纏繞著你，祂哭泣著，祈求著——\n獻上供奉，或帶祂離開。"
  },
  Event_7159_Name = {
    Text = "混沌之靈"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "【留下供奉】隨機提升1張卡牌的刻印品質"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "【帶它離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7160_Desc = {
    Text = "在你靠近時，無序的混沌靈魂從泥潭中驟然出現。\n黑色的上肢緊緊纏繞著你，祂哭泣著，祈求著——\n獻上供奉，或帶祂離開。"
  },
  Event_7160_Name = {
    Text = "混沌之靈"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "【揮手驅趕】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7161_ChoiceDesc2 = {
    Text = "【任由停留】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7161_Desc = {
    Text = "蝴蝶翕動的翅膀上拖著黑色的粘液，高低搖晃著飛過，翅膀上溢出的一層層黑漿，在凝固後被風化剝落。\n它飛累了，停在了你的鼻尖。"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "【揮手驅趕】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7162_ChoiceDesc2 = {
    Text = "【任由停留】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7162_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7162_Desc = {
    Text = "蝴蝶翕動的翅膀上拖著黑色的粘液，高低搖晃著飛過，翅膀上溢出的一層層黑漿，在凝固後被風化剝落。\n它飛累了，停在了你的鼻尖。"
  },
  Event_7163_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7163_Desc = {
    Text = "「我看到勇氣，看到意志，看到耀眼如星的精神。朝著那個以蠟封存的記憶前進，你必能如願以償。」"
  },
  Event_7163_Name = {
    Text = "追尋之物"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "【任由停留】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7164_ChoiceDesc2 = {
    Text = "【揮手驅趕】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7164_ChoiceDesc3 = {
    Text = "【迎接蝴蝶】獲得25黑印"
  },
  Event_7164_Desc = {
    Text = "你們逡巡於寒風淩冽的療養院中，一隻這個季節不應存在的黑色蝴蝶翩躚而來。\n蝴蝶翕動的翅膀上拖著黑色的粘液，高低搖晃著飛過，翅膀上溢出的一層層黑漿，在凝固後被風化剝落。\n它飛累了，停在了你的指尖。"
  },
  Event_7164_Name = {
    Text = "不應存在之物"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_7165_Desc = {
    Text = "你開始感覺疲憊。\n意識牽引著你， 越過池塘，越過高山， \n飛向太陽之外，飛向光年之外，\n飛向那獨一無二的......宇宙溫床。"
  },
  Event_7165_Name = {
    Text = "終幕禮Ⅳ"
  },
  Event_7166_Desc = {
    Text = "巨大的陰影把你徹底籠罩，腥臭的唾液又將你淋成落湯雞。\n「小老鼠，快過來。就一小會……」\n「我發誓，我絕沒有想要吃你的意思……」\n「我絕不對你肥美多汁的肚皮多看一眼！」"
  },
  Event_7166_Name = {
    Text = "素材12號"
  },
  Event_7167_Desc = {
    Text = "枯槁的蠟像哲人吸著煙，籠罩在白色的煙幕中。\n「彼岸存在但不可知，所以彼岸無從知曉。」\n「把這個世界想像成一個遊戲……\n你要找的東西，或許就在地圖的另一邊。」"
  },
  Event_7167_Name = {
    Text = "素材45號"
  },
  Event_7168_Desc = {
    Text = "「抱歉，無意針對……」\n「我不喜歡老鼠。老鼠的問題是它們從不懼怕人類……」\n鬍子拉碴的老者躺在角落，憂鬱的雙眼緊盯著你。\n「當然，你們非常有進取心。\n這很好，但還不足以幫助你們躲過災厄……」"
  },
  Event_7168_Name = {Text = "素材4號"},
  Event_7169_ChoiceDesc1 = {
    Text = "【展示詛咒】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7169_ChoiceDesc2 = {
    Text = "【拒絕烏鴉】獲得3選1刻印"
  },
  Event_7169_ChoiceDesc3 = {
    Text = "【無視】"
  },
  Event_7169_Desc = {
    Text = "漆黑而病態的多顱烏鴉自一名提燈教眾的黑袍中飛出，落在你的肩膀上。\n「看見我的頭了嗎？只要品嘗詛咒，我就會長出新的頭顱。讓我看看吧，你的詛咒！」"
  },
  Event_7169_Name = {
    Text = "詛咒怪鴉"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "【回應呼喚】刪除1張指令卡，並回復 Arg1 點生命"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "【我不是在逃亡】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7170_Desc = {
    Text = "你在小巷中急速奔跑。腎上腺素激發，乳酸生成，葡萄糖消耗……混沌侵蝕了你的大腦，佔據了你的思維，在五光十色的迷幻中催促你向終點逃亡。\n是的，逃亡。如果你真的不是在逃亡，那麼等待你的，為何是混沌和虛無、一無所獲和無疾而終呢？"
  },
  Event_7171_ChoiceDesc1 = {
    Text = "【追溯聲音源頭】"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "【呼喚莉莉和庫姆】"
  },
  Event_7171_Desc = {
    Text = "維度通道的遠方，傳來低沉粗重的喉音，夾雜著恐懼、期盼、不安，像是在呼喚著你們。緊接著是女孩子模糊不清的絮語，隨後兩種聲音都漸漸低了下去。"
  },
  Event_7171_Name = {
    Text = "指引之聲"
  },
  Event_7172_Desc = {
    Text = "一種近水銀態的銀色物質，由融蝕黏液中提煉而出，蘊含強大精神力，主要用於在儀式中連結更多喚醒體。"
  },
  Event_7172_Name = {Text = "銀芯"},
  Event_7173_ChoiceDesc1 = {
    Text = "【請他讓開道路】"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "【詢問身分】"
  },
  Event_7173_Desc = {
    Text = "你們邁入一節昏暗的車廂，異樣感浮上心頭。\n這節車廂內空蕩蕩的，乘客早已逃竄離去，地面上散落著怪物的殘軀，正在逐漸消散。\n車廂的中央，站著那個男人。\n「我相信世間存在緣分，也是緣分讓我們搭乘了同一班地鐵。」"
  },
  Event_7173_Name = {
    Text = "怪異旅伴Ⅳ"
  },
  Event_7174_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7174_Desc = {
    Text = "「你的眼睛真漂亮，像星星一樣。」\n夏洛特咯咯笑著，瘋狂遊蕩的頭髮柔順地垂了下來。\n「你在學校裡一定很受歡迎吧，我也喜歡你。」\n臨走前，她吻了吻你的額角。\n你感到身體暖洋洋的，有什麼東西似乎變得不一樣了。"
  },
  Event_7174_Name = {
    Text = "調查員的陰影"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "【閱讀】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "【收入手提箱】感染「(Skill.Arg1)」，獲得造物：「(RelicConfig.Arg2)」"
  },
  Event_7175_Desc = {
    Text = "一頁泛黃的紙從提燈教眾的罩袍下脫落。\n紙上密密麻麻撰寫著形狀奇特的古怪文本，有些像是象形符號，有些怪異地上揚，有些字體甚至重疊在一起，只有少量文字勉強可以辨認。"
  },
  Event_7176_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7176_Desc = {
    Text = "你說：「唉，夏洛特！不行！」\n夏洛特的頭髮瘋狂地扭動著，她生氣了。\n「我會證明給你看的！瞧瞧我的本事！」"
  },
  Event_7176_Name = {
    Text = "調查員的陰影"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」】"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7177_Desc = {
    Text = "事件302（開發中），非最終效果"
  },
  Event_7177_Name = {
    Text = "事件302（開發中）"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "【接收請求】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_7178_ChoiceDesc2 = {
    Text = "【拒絕請求】獲得25黑印"
  },
  Event_7178_Desc = {
    Text = "頜骨哢吱響動著，聲音帶著某種規律的節奏，而你的同伴恰好懂得一些密碼學的知識。\n破譯後的文字如下：\n「你好，請叫我@2博士。我曾是一位收藏家、博物學家……\n（此處為長篇累牘的生涯及頭銜介紹，略）\n總而言之，能幫我找到我的另一半嗎？那是一塊小小的上頜骨。\n只要能找到它，鄙人的私人寶庫將向你敞開大門。」"
  },
  Event_7178_Name = {
    Text = "哢吱作響"
  },
  Event_7179_ChoiceDesc1 = {
    Text = "【投入一百坊】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_7179_ChoiceDesc2 = {
    Text = "【投入五片什】獲得25黑印。"
  },
  Event_7179_Desc = {
    Text = "刺繡錢包蠕動著，向你張開黑漆漆的大口。\n自從離開富有的女主人，它已饑腸轆轆數十年，亟待填飽肚子。\n你朝錢包內看了看，裡面空無一物，只有濃郁得看不見底的黑暗。"
  },
  Event_7179_Name = {
    Text = "貪吃錢包"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "【是堅定的決心】刪除1張指令卡，並回復 Arg1 點生命"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "【是對成功的渴望】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7180_Desc = {
    Text = "「兩個固執的傢伙，濟貧院已經很危險了，」通訊器裡突然傳來朵爾的聲音，「你們打算下一步怎麼行動，幫她把頭縫上？」\n「現在不是說風涼話的時候，朵爾！」\n「我知道，我聽得出來。」朵爾說，「冷靜一點，知道成功的關鍵是什麼嗎？」"
  },
  Event_7180_Name = {
    Text = "羅格斯定則"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」】"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7181_Desc = {
    Text = "事件304（開發中），非最終效果"
  },
  Event_7181_Name = {
    Text = "事件304（開發中）"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」】"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7182_Desc = {
    Text = "事件305（開發中），非最終效果"
  },
  Event_7182_Name = {
    Text = "事件305（開發中）"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "【擱置聽筒】獲得3選1高級刻印"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "【接起電話】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7183_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7183_Desc = {
    Text = "你們途經列車長的休憩室，隱蔽的角落裡，電話鈴聲尖銳地響起。"
  },
  Event_7183_Name = {
    Text = "列車來電"
  },
  Event_7184_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7184_Desc = {
    Text = "光輝黯淡，卻是真切存在著的。\n如此黯淡的銀芯難以召喚喚醒體，用於強化倒是極好的——所謂銀芯科技，就是這麼回事兒。"
  },
  Event_7184_Name = {
    Text = "存在的證明"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "【女士肖像畫】隨機提升1張卡牌的刻印品質"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "【蠟像全家福】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7185_Desc = {
    Text = "蠟像館內同時收藏了不少繪畫作品。\n人物、風景、靜物，寫實的、抽象的……\n它們裝點了原本單調的牆面，使其不至於顯得無趣。\n你的目光被其中之一深深吸引，它是一幅——"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "【繼續翻閱】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "【離開】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_7186_Desc = {
    Text = "一架用於稱重的天平。\n在它的背後，無數器官浸泡在紅色的福爾馬林中。\n它們被整整齊齊地堆疊在儲物架上。\n你順手撿起一旁的筆記本翻閱：\n「心臟：8盎司，大腦：50盎司……」"
  },
  Event_7186_Name = {
    Text = "器官登記"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "【打開禮物】獲得特殊卡牌"
  },
  Event_7187_Desc = {
    Text = "孩子的虛影在你面前一晃而過，你無法分辨那究竟是真正的孩童，還是密境之中的某種精神的投影。但——你看向地面上遺留的盒子，上面用稚嫩的字體寫了「禮物」。"
  },
  Event_7187_Name = {
    Text = "善意的禮物"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "【呼喚烏鴉】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "【遠遠離開】獲得25黑印"
  },
  Event_7188_Desc = {
    Text = "白鷗停留在桅杆之上，桅杆之上覆蓋白霜。\n鳴管齊齊共振，它們排斥著黑色的存在，也排斥那不屬於遠洋的漆黑之鳥。"
  },
  Event_7188_Name = {
    Text = "離群之鴉"
  },
  Event_7189_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7189_Desc = {
    Text = "你聽出那歌謠改編自一首情歌。\n在那首情歌的末尾，詩人說：\n「直到人類的聲音把我們喚醒，我們便溺水而亡。」\n不是現在。你心說。\n你還在等待人類將你喚醒。"
  },
  Event_7189_Name = {
    Text = "群鴉之聲"
  },
  Event_7190_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7190_Desc = {
    Text = "一卷落滿灰塵的膠片。但這屋內並無放映機，此刻也不是悠閒地享受莊園、膠片和下午茶的時候。\n或許要很久之後，你才能有機會知曉膠片中的內容了。"
  },
  Event_7190_Name = {
    Text = "記憶光影"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "【離開】獲得3選1高級刻印，感染「(Skill.Arg1)」"
  },
  Event_7191_Desc = {
    Text = "你跟在男孩身後，不遠也不近。 \n嗒。嗒。嗒…… 男孩在街角停下。\n你看到他身後搖搖欲墜的紅色微光，直覺告訴你，蠟像館就在前方。 \n男孩轉過身來。他沒有眼睛，眼眶裡一片漆黑。 \n他對你微笑。"
  },
  Event_7191_Name = {
    Text = "終幕禮Ⅰ"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印，感染「(Skill.Arg1)」"
  },
  Event_7192_Desc = {
    Text = "你拍了拍他的肩。\n男孩轉過身來，他沒有眼睛，眼眶裡一片漆黑。\n 「晚上好。我在尋找去蠟像館的路。」 \n男孩指了指前方。你看到他身後搖搖欲墜的紅色微光。\n直覺告訴你，蠟像館就在那裡。 \n回過神來，男孩早已離開，只留下路燈拖長的影子。"
  },
  Event_7192_Name = {
    Text = "終幕禮Ⅰ"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "【摁住烏鴉】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_7193_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。"
  },
  Event_7193_Name = {
    Text = "融漿之淚"
  },
  Event_7194_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7194_Desc = {
    Text = "無價的知識湧入你的腦海，然後化為迷霧……當你清醒過來時，那本怪異的黃色封皮書籍已經不翼而飛……"
  },
  Event_7194_Name = {
    Text = "黃色書卷"
  },
  Event_7195_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7195_Desc = {
    Text = "你輕鬆擊倒了這些蠟像。它們垂著頭倒在你的面前。\n蠟像的底部似乎書寫了幾行文字。\n「洪積@2年11月\n羅傑斯製作於@2學院」\n你記得羅傑斯曾就讀於某藝術學院的雕塑專業，這些笨拙的蠟像想必是他當年的習作吧。"
  },
  Event_7195_Name = {Text = "習作"},
  Event_7196_ChoiceDesc1 = {
    Text = "【為什麼呢】"
  },
  Event_7196_ChoiceDesc2 = {
    Text = "【向深海下墜】"
  },
  Event_7196_Desc = {
    Text = "「冒牌貨！把我的兒子還回來！」\n「你不是航船聖女嗎？你的職責不是庇佑航船嗎？為什麼只有一艘船回來了，你說啊，你說啊！」\n「溺死她！我父親死前受的苦，她也必須嘗！」\n「溺死她，溺死她！」\n「溺死這個冒牌貨！把她捆在石頭上！」\n海水湧入口鼻，空氣被從肺泡的每個角落擠出去時，她也穿著那身華貴高潔的白裙。\n幾乎是成為聖女後的第一個念頭，從腦袋最陰暗的角落爬了出來，姍姍來遲。\n「是啊，那些船，為什麼會沉呢？」"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "【摁住烏鴉】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_7197_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。"
  },
  Event_7197_Name = {
    Text = "融漿之淚"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7198_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7198_Desc = {
    Text = "似乎有一雙手搭上了你的肩頭，有力而堅定，可當你回頭尋找時，那一度切實的觸感又變得飄渺難尋。"
  },
  Event_7198_Name = {
    Text = "異常聯絡"
  },
  Event_7199_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7199_Desc = {
    Text = "鐵路橋，倫蒂尼恩的血管與神經，連接城市的心臟與四肢，拉伊瘋人院正位於四肢的末梢，安靜地等待血液和訊號的輸送。"
  },
  Event_7199_Name = {
    Text = "鐵路的幻覺"
  },
  Event_7200_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7200_Desc = {
    Text = "你把手提箱放在地上用力踩了幾腳，確認它不再震顫後才重新拾起它。\n拍了拍上面的塵土，在墨菲疑惑的眼神中，你們繼續前進。"
  },
  Event_7200_Name = {
    Text = "不速來信"
  },
  Event_7201_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7201_Desc = {
    Text = "危險隔著一層木門對你虎視眈眈，不適合消磨太多時間。將它收入手提箱中。"
  },
  Event_7201_Name = {
    Text = "黃色書卷"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_7202_Desc = {
    Text = "它，或者說它們，在臥室盤旋，將燈罩撞得嘩啦作響。"
  },
  Event_7202_Name = {
    Text = "提燈黑鴉"
  },
  Event_7203_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7203_Desc = {
    Text = "這裡是精神的維度，是靈知的世界。\n除了攪亂你的腦子，祂們什麼都做不到。"
  },
  Event_7203_Name = {
    Text = "靈知風暴"
  },
  Event_7204_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7204_Desc = {
    Text = "顱骨：漢克·蒂林哈斯特 A.F.186-A.F.203 克里奧爾島\n脊椎：安迪·克勞福特 A.F.177-A.F.203 納拉甘西特\n……不能細想。"
  },
  Event_7204_Name = {Text = "銘牌"},
  Event_7205_ChoiceDesc1 = {
    Text = "【檢查碎片】從牌庫中隨機獲取3張指令卡，選擇1張卡進行刪除，獲得75黑印"
  },
  Event_7205_ChoiceDesc2 = {
    Text = "【詢問朵爾】從牌庫中隨機獲取3張指令卡，選擇1張卡的原始複製進入牌庫，獲得25黑印"
  },
  Event_7205_ChoiceDesc3 = {
    Text = "【無視】獲得50黑印"
  },
  Event_7205_Desc = {
    Text = "朵爾給你的金屬碎片在你的胸口不安的翕動著，像是受到驚擾的蝴蝶。"
  },
  Event_7205_Name = {
    Text = "不安的胸針"
  },
  Event_7206_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7206_Desc = {
    Text = "「祂在終點靜靜等候，無論你將終點定在何處——看看那位年輕的管理，她的逃避終究招致瘋狂。」"
  },
  Event_7206_Name = {
    Text = "追尋之物"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "【離開】沒有任何發現"
  },
  Event_7207_Desc = {
    Text = "開發中，特殊事件"
  },
  Event_7207_Name = {Text = "2_16臨時"},
  Event_7208_ChoiceDesc1 = {
    Text = "【安慰它】提高 Arg1 點最大生命"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "【忽視它】隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染2張「(Skill.Arg2)」"
  },
  Event_7208_Desc = {
    Text = "連結溫暖著尚為人類之心的器官。\n它模仿著連結那頭呼吸的節奏鼓動著，就好像這麼做，它就不會被拋下，它就擁有了永遠與連結同行的權利。"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "隨機高級刻印"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7210_Desc = {
    Text = "你的冷淡讓聲音的主人頗感遺憾，水面懨懨地蕩出幾個漣漪，再無波瀾。"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "【選擇1張卡牌獲得刻印：「(EnchantConfig.Arg1)」】測試刻印"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "【選擇1張卡牌獲得刻印：「(EnchantConfig.Arg1)」】測試掉落包"
  },
  Event_7211_Desc = {
    Text = "測試指定刻印"
  },
  Event_7211_Name = {
    Text = "指定刻印測試1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒1名喚醒體"
  },
  Event_7212_Desc = {
    Text = "你摸了摸男孩的頭，引導他和你一起念下去。 \n「獻給媽媽的歌——」 \n聲音像暗夜裡的飛蛾，並肩飄出空蕩蕩的舞臺，\n輕輕降落在漆黑一片的觀眾席裡。"
  },
  Event_7212_Name = {
    Text = "終幕禮Ⅲ"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "【離開】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_7213_Desc = {
    Text = "你不動聲色。一位貴婦人忽然衝上舞臺。 \n她瘋狂地掰開男孩的嘴，將手中的木棍狠狠捅進去。 \n「說話，給我說話。」 \n男孩嘴裡流出黑色的血。他含混不清地念了下去。 \n「獻給媽媽的歌……」"
  },
  Event_7213_Name = {
    Text = "終幕禮Ⅲ"
  },
  Event_7215_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7215_Desc = {
    Text = "那不是窗戶，是一面鏡子。鏡中倒映出拉蒙娜神經緊繃的臉。\n這個房間中為何沒有窗戶，只在牆面上掛了一面巨大的鏡子？"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "【握住銀鑰】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "【閉上雙眼】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7216_Desc = {
    Text = "你被一陣巨大的荒誕撕扯著，肢體扭曲地爬行於地面，彷彿被來自維度以外的@2操縱。\n「不……不……」\n你的理智寸寸垮塌，神志不清的獰笑和尖叫交織，如一道巨網縛住你的意識，溢到嘴邊的只有含混不清的哀鳴。"
  },
  Event_7217_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7217_Desc = {
    Text = "星河色澤變幻，在你的腳下繪出不可名狀的圖案，瑰麗如紅寶石，卻浮腫如水母。手提箱內隨之泛起紅光……"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "【驅散幻象】壓力+10。"
  },
  Event_7218_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7218_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_7221_ChoiceDesc1 = {
    Text = "【接住】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "【低頭查看】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7221_Desc = {
    Text = "烏鴉在被小巷切割成積木型的天空中盤旋，發出令人心緒不寧的喑啞鳴叫。\n 鴉群突然躁亂，像是某種病態的天性被扭曲或是覺醒，它們急躁而兇狠地相互撲打追逐，撕扯中有什麼東西落了下來。"
  },
  Event_7221_Name = {
    Text = "躁亂鴉群"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "【遵從指示】提升 Arg1 點生命"
  },
  Event_7222_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7222_Desc = {
    Text = "你嘗試用銀鑰匙的追溯之力尋找最近的聯絡點，但獲得的資訊中夾雜著難以察覺的異常，似乎被干擾了。"
  },
  Event_7222_Name = {
    Text = "異常聯絡"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "【交給朵爾】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "【閱讀銘牌】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_7223_Desc = {
    Text = "從被你擊敗的雕塑家協會實驗體身上，掉下一塊金屬外框的銘牌。銀鑰匙感應著銘牌，微微閃光。"
  },
  Event_7223_Name = {Text = "銘牌"},
  Event_7224_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7224_Desc = {
    Text = "持刀者發出長嘯，好似一聲能斬斷山海的巨響。\n聲音轉瞬即逝，連帶另外兩個蹈海者也不見蹤影……原來只是密境映照出的一段幻象。"
  },
  Event_7224_Name = {
    Text = "窮追不舍"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "【修復蠟像】選擇卡牌並使其算力消耗降低1"
  },
  Event_7225_Desc = {
    Text = "你手持蠟燭，穿過迷蒙的霧靄，來到她的面前。\n這是一尊未完的蠟像。\n柔美的面龐被一分為二，一半微笑，一半@1。\n成為她的神明吧。\n給予她美貌，給予她眼淚。\n雕琢她，或是毀滅她。"
  },
  Event_7225_Name = {
    Text = "未完的蠟像"
  },
  Event_7226_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7226_Desc = {
    Text = "「當然，我曾親眼目睹消亡。」你回答道。\n是的，那不過是一隻小鼠的暴死，一顆心臟的潰爛，和一束鳶尾浸入夜色的葬禮。"
  },
  Event_7226_Name = {
    Text = "亡佚神國"
  },
  Event_7227_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7227_Desc = {
    Text = "「神國……消亡……虛無縹緲的議題……我並不知曉，如何才算消亡。」\n兩道人影輕聲笑了，周身灑落雪白的光芒碎屑。\n「那此刻，你即將見證一次真正的消亡。」"
  },
  Event_7227_Name = {
    Text = "亡佚神國"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "【拼合紙張】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7228_ChoiceDesc2 = {
    Text = "【閱讀】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "【丟棄它】獲得50黑印"
  },
  Event_7228_Desc = {
    Text = "一頁泛黃的紙從提燈教眾的罩袍下脫落。\n紙上密密麻麻撰寫著古怪的文本，有些像是象形符號，有些怪異地上揚，有些字體甚至重疊在一起，只有少量文字勉強可以辨認。\n標題是《@2 聖子的誕生》"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "【掙扎】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7229_ChoiceDesc2 = {
    Text = "【沉淪】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7229_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7229_Desc = {
    Text = "「我好痛苦，好痛苦啊……」\n「為什麼是我，為什麼我要經歷這個？」\n「仁慈的父神啊，我到底做錯了什麼？」\n悲傷、痛苦、憤怒、不甘……「病人」們的情感沉重地壓在你的身上，你捂著胸口，無法呼吸。"
  },
  Event_7230_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7230_Desc = {
    Text = "視線穿透了皮肉，將烙印打在了先行者的視網膜上。\n沒有人可以逃離，正如沒有人@2"
  },
  Event_7230_Name = {Text = "窺視"},
  Event_7231_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7231_Desc = {
    Text = "集中精神，辨認歌詞，然後被雜亂無章的詞句衝擊後腦。\n那不是人類能夠理解的詞語。"
  },
  Event_7231_Name = {
    Text = "海洋歌謠"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "【進行試煉】感染「(Skill.Arg1)」，勝利獲得黃金造物，失敗獲得50黑印"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7232_Desc = {
    Text = "你窺見過一些秘辛，從腳下那灘鏡面般反光的黑漿中。\n它的倒影邊緣模糊，周身縈繞著揮之不去的黑氣，你感到莫名熟悉，卻又辨認不清它究竟是何物。"
  },
  Event_7232_Name = {
    Text = "鏡面之下"
  },
  Event_7233_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7233_Desc = {
    Text = "你對神神叨叨的佚名信件不屑一顧，隨手燒掉的信箋化作飛灰。"
  },
  Event_7234_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7234_Desc = {
    Text = "你檢查信件的本體，封口處黏糊糊的液體，似乎是血液和黑漿的混合物，混雜著幾根髮絲，被黏在封口處。"
  },
  Event_7235_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7235_Desc = {
    Text = "從信件飄落的方向尋去，在拐彎的牆角處，你瞥見了閃亮的物什。"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7236_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7236_Desc = {
    Text = "隱約的光芒出現在眼前，明亮而溫暖，想要循光而去時，它卻忽地消失了。"
  },
  Event_7236_Name = {
    Text = "異常聯絡"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "【離開】所有喚醒體回復Arg1狂氣"
  },
  Event_7237_Desc = {
    Text = "你害怕得緊緊閉上雙眼。\n「你掀開了蓋布……\n秘密，你發現了秘密……」 \n聲浪匯成喧囂的海洋，地板在可怕的共振中劇烈抖動。\n你忍無可忍，猛地睜開雙眼，卻發現四周空無一物。"
  },
  Event_7237_Name = {
    Text = "終幕禮Ⅴ"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7238_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7238_Desc = {
    Text = "鼻尖聞到了熟悉的氣味，家常而令人滿足，當你想再嗅一嗅食堂香氣時，那飄溢的香氣卻消失得一乾二淨。"
  },
  Event_7238_Name = {
    Text = "異常聯絡"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7239_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7239_Desc = {
    Text = "耳邊傳來了熟悉的話語，親切而令人安心，想要循聲尋找時，聲音卻戛然而止。"
  },
  Event_7239_Name = {
    Text = "異常聯絡"
  },
  Event_7240_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7240_Desc = {
    Text = "追溯之力短時間內無法再次為你尋找聯絡點，可你至少獲得了暫時的撫慰。"
  },
  Event_7240_Name = {
    Text = "異常聯絡"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7241_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7241_Desc = {
    Text = "似乎有一雙手搭上了你的肩頭，有力而堅定，可當你回頭尋找時，那一度切實的觸感又變得飄渺難尋。"
  },
  Event_7241_Name = {
    Text = "異常聯絡"
  },
  Event_7242_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7242_Desc = {
    Text = "「N」的影子被拳風打散，黑色微粒與密境濃霧融為一體，難尋蹤跡。\n「沒意思，又有趣的傢伙。我很期待和你真正的會面……」"
  },
  Event_7242_Name = {
    Text = "好戲開場"
  },
  Event_7243_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7243_Desc = {
    Text = "「乖孩子。不過，還是要給你一點小小的懲罰才行。」\n達芙黛爾的輕笑聲消散在維度裂隙中。"
  },
  Event_7243_Name = {
    Text = "提示時間"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "【正面】50%機率獲得黃金造物「(RelicConfig.Arg2)」，50%機率感染「(Skill.Arg3)」"
  },
  Event_7244_ChoiceDesc2 = {
    Text = "【反面】50%機率獲得75黑印，50%機率感染「(Skill.Arg3)」"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "【黑色籌碼】50%機率獲得詛咒造物「(RelicConfig.Arg2)」，50%機率感染「(Skill.Arg3)」"
  },
  Event_7244_Desc = {
    Text = "很好…很好……\n那麼，選擇你想要的籌碼吧。"
  },
  Event_7244_Name = {
    Text = "好戲開場"
  },
  Event_7245_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7245_Desc = {
    Text = "「好吧好吧。那傢伙，對跨越維度的生物總是糾纏不休呢，我也很是費了一番工夫才能夠自如地穿梭在這些維度的破洞中。啊，那得是三千年前的事情了吧？」"
  },
  Event_7245_Name = {
    Text = "提示時間"
  },
  Event_7246_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7246_Desc = {
    Text = "相信科研主任不會在你的胸口安裝炸彈。"
  },
  Event_7246_Name = {
    Text = "不安的胸針"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "【離開】刪除1張指令卡，獲得25黑印"
  },
  Event_7247_Desc = {
    Text = "「是好心的路人，為迷途者提供正確的指引，」他的笑容不懷好意，「輕裝簡行吧，刻耳柏洛斯在等待著你們。」\n手中的指揮裝置猝然震動了一下。"
  },
  Event_7247_Name = {
    Text = "怪異旅伴Ⅲ"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "【慢慢挪動】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "【俯身躺平】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7248_Desc = {
    Text = "「遇到沼澤時，千萬不要掙扎。」\n你謹記這條生存法則，像復活節島的雕像一樣巋然不動。\n五分鐘，十分鐘，一小時……黑泥終於失去耐心，從你的腳底消失了。"
  },
  Event_7248_Name = {
    Text = "黯色沼澤"
  },
  Event_7249_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7249_Desc = {
    Text = "你注意到一隻與眾不同的手。它細嫩、白皙，從始至終都表現得很平靜。\n更重要的是——你認出來了，那是你自己的手。\n你輕輕握住了它。\n那只手也回握住你的。你感受到刺骨的寒冷與虛無，隨後沼澤便消失了。"
  },
  Event_7249_Name = {
    Text = "黯色沼澤"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "【斬斷一隻手】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "【安撫它們】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7250_Desc = {
    Text = "你揮舞手中的利刃，將它們逐一斬斷。\n各式各樣的血濺到你的身上、臉上、頭髮上，你卻渾然不覺。\n無數隻手一齊發出痛苦的哀嚎，沼澤消失了。\n直到一星期後，你才不會在噩夢裡聽到那些哭聲。"
  },
  Event_7250_Name = {
    Text = "黯色沼澤"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "【拾起銀芯】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "【嘗試喚醒】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7251_ChoiceDesc3 = {
    Text = "【置之不理】獲得25黑印"
  },
  Event_7251_Desc = {
    Text = "鬆動的甲板橫木下，溢出一股污濁的黑漿。\n而黑漿中的閃光，是你再熟悉不過的「銀芯」。"
  },
  Event_7251_Name = {
    Text = "存在的證明"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "【選擇老鼠】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "【選擇蠟燭】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_7252_Desc = {
    Text = "融蝕體在你面前消散，黑冷的飛灰融入迷霧，憑空凝聚出一個古怪的天平。天平的一端是一隻沉睡的老鼠，另一端則是一根雕刻成男孩模樣的蠟燭。\n冥冥中你知道，你必須做出選擇。"
  },
  Event_7252_Name = {
    Text = "理智與情感"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "【出聲試探】"
  },
  Event_7253_Desc = {
    Text = "走過某個轉角，周圍的一切愈發模糊，只有可怖的吼叫仍舊清晰。\n腳步聲響起，你一回頭，依稀看到一個古怪的身影：那似乎是個人，同時背後有著成對的陰影，乍看上去像一隻巨大的飛蛾。\n「小心，」拉蒙娜低聲提醒，「密境之中，眼見不一定為實，若是貿然跟上去，恐怕會有危險。」"
  },
  Event_7253_Name = {
    Text = "霧氣中的身影"
  },
  Event_7254_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7254_Desc = {
    Text = "你掏出了銀鑰匙，哀戚虔誠地將它握在手心，薄霧般的微光包裹住你。\n一片寂靜中，只餘喟歎。"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "【選擇星河之路】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "【選擇虹彩之路】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_7255_Desc = {
    Text = "撲通、撲通、撲通。\n心跳像擂鼓，口乾舌燥，高空之中的目光從脊椎刺穿你的胸膛。\n眼前出現了分岔的道路，一條星河流淌，一條虹彩泛光。"
  },
  Event_7256_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7256_Desc = {
    Text = "殘留的目光仍在注視著你，你皮膚下的血肉細胞正瘋狂叫囂和逃逸，血管在皮膚下蠕動如蟲豸。\n你感到一陣流淌著的力量，在肢體詭譎的異狀中迸發。"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_7257_Desc = {
    Text = "「不，這不是真的。比起蟑螂，你們至少有毛茸茸的身體。\n沒人能拒絕毛茸茸的身體。」\n老鼠們竊竊私語，最終勉強同意了你的觀點。\n「還好啦……其實也沒有很多毛。」\n被誇讚總是令人高興的。臨走前，老鼠們送了你一件小小的禮物。"
  },
  Event_7258_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7258_Desc = {
    Text = "「我同意！人類和老鼠不共戴天！」\n老鼠們有點生氣，露出白花花的獠牙。\n「那你還在這裡做什麼？拿走你的東西，永遠不要回來。」"
  },
  Event_7259_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7259_Desc = {
    Text = "奇異的振翅聲縈繞在你周圍，恍惚間你看到，羅傑斯抱著玩偶喬治躺在診療床上，雙手滿是鮮血。\n你睜開眼，發現克萊門汀已經不見了蹤跡。\n甦醒過來，克萊門汀已經離開。"
  },
  Event_7259_Name = {
    Text = "催眠療法"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "【開啟】使用鑰匙。"
  },
  Event_7260_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7260_Desc = {
    Text = "一扇門堵住了你的去路。你用盡了各種方法，它依然紋絲不動。"
  },
  Event_7260_Name = {
    Text = "銹蝕門扉"
  },
  Event_7260_Tips1 = {
    Text = "需要獲得「銹蝕鑰匙」"
  },
  Event_7261_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7261_Desc = {
    Text = "你朝你認為是目光源頭的方向望去。工坊的天花板驟然變得高遠，巨大瞳仁的虛影層層疊疊，儘管只有一部分與你對望，你仍感到巨大的壓力。"
  },
  Event_7261_Name = {
    Text = "誰的目光"
  },
  Event_7262_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7262_Desc = {
    Text = "黑貓謹慎地踱步靠近，在你手心嘔出一團漆黑。"
  },
  Event_7262_Name = {
    Text = "夜貓之禍"
  },
  Event_7263_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7263_Desc = {
    Text = "「嗯，聰明的選擇。大敵當前，肯定會想要知己知彼？不過，知曉太多關於維度的秘密可是會干擾神志的哦？」\n「那傢伙，對跨越維度的生物總是糾纏不休呢，我也很是費了一番工夫才能夠自如地穿梭在這些維度的破洞中。啊，那得是三千年前的事情了吧？」"
  },
  Event_7263_Name = {
    Text = "提示時間"
  },
  Event_7264_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7264_Desc = {
    Text = "「喵，喵喵，喵喵喵……」\n你捏著嗓子，竭力使自己顯得柔弱無害。\n「喵！喵喵！喵喵喵！」\n貓群似乎接受了你的善意，回以嘹亮的呼喊。你們的叫聲此起彼伏，晝夜不歇，月亮都被嚇得躲進雲裡。"
  },
  Event_7264_Name = {Text = "貓之城"},
  Event_7265_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7265_Desc = {
    Text = "你用力掰回了烏鴉意圖啃咬羽毛的尖喙，它卻不依不饒地擰過去，力氣之大甚至將你的骨頭震得哢哢作響。\n你漲得滿臉通紅，拼盡全身力氣才制住烏鴉的身體，遏止了它瘋狂自殘的行徑。\n正在你鬆了口氣時，烏鴉那已經半禿的脖頸向後猛地一擰，身體癱軟下來，在你的手裡化成了一灘黑色的濃漿。"
  },
  Event_7265_Name = {
    Text = "融漿之淚"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "【摁住烏鴉】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_7266_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。"
  },
  Event_7266_Name = {
    Text = "融漿之淚"
  },
  Event_7267_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7267_Desc = {
    Text = "烏鴉撕咬著自己的羽毛，就如人類啃噬自己的身體一樣。\n在這個恐懼的世界裡，此事屢見不鮮，你救不了所有生靈。"
  },
  Event_7267_Name = {
    Text = "融漿之淚"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7268_Desc = {
    Text = "「我會帶著學生們回來的。」女孩拽著喚醒體的裙角，篤定地說，「照顧好自己……你可別掉海里了。」"
  },
  Event_7268_Name = {
    Text = "航船聖女的庇佑"
  },
  Event_7269_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7269_Desc = {
    Text = "哈哈，黑色，我最喜歡的黑色。無序、混亂、痛苦……你早該知道的，黑色可不是什麼好兆頭。\n那麼，你的下一個選擇是？"
  },
  Event_7269_Name = {
    Text = "好戲開場"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "【摁住烏鴉】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "【放任不管】離開"
  },
  Event_7270_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。"
  },
  Event_7270_Name = {
    Text = "融漿之淚"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7271_Desc = {
    Text = "那是年久失修，缺少燈光與指引的船艙深處。\n女孩會帶著航船聖女的祝福出發，這是她們的約定。"
  },
  Event_7271_Name = {
    Text = "航船聖女的庇佑"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "【追尋歌聲】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "【隨之歌唱】感染「(Skill.Arg1)」，再次隨機刻印"
  },
  Event_7272_Desc = {
    Text = "渺遠的歌聲被崩碎成幾點星屑：\n「我詛咒夜巷的一灘髒水，頹圮的牆根處綴著腐敗的花，鎖鏈攀附著大腦墜入泥淖，在濃霧抹去我的存在前，暮色將沉入最深的@3。」"
  },
  Event_7272_Name = {
    Text = "白質詛咒"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "【追尋歌聲】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7273_Desc = {
    Text = "渺遠的歌聲被崩碎成幾點星屑：\n「我詛咒夜巷的一灘髒水，頹圮的牆根處綴著腐敗的花，鎖鏈攀附著大腦墜入泥淖，在濃霧抹去我的存在前，暮色將沉入最深的@4。」"
  },
  Event_7273_Name = {
    Text = "白質詛咒"
  },
  Event_7274_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7274_Desc = {
    Text = "銀芯沒有回應你的喚醒，但散發出溫暖的氣息。"
  },
  Event_7274_Name = {
    Text = "孤獨銀芯"
  },
  Event_7275_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7275_Desc = {
    Text = "繚繞的黑色霧氣爬上脊椎，直到摔倒在地面為止，你一直重複著這句話。"
  },
  Event_7275_Name = {
    Text = "不可直視"
  },
  Event_7276_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7276_Desc = {
    Text = "是的，自瞳孔緩緩流出的玻璃體液，是你被禁忌腐蝕的證明。\n誠實，在此時與美德背道而馳。"
  },
  Event_7276_Name = {
    Text = "不可直視"
  },
  Event_7277_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7277_Desc = {
    Text = "古幣上黏濕一片，像被污穢嘔出的殘渣，飄著肉眼可見的黑氣。"
  },
  Event_7277_Name = {
    Text = "雙面古幣"
  },
  Event_7278_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7278_Desc = {
    Text = "敏銳的神經末梢發出致命的警告，你猛地一震，只得悻悻收手。\n又讓你逃過了……\n詛咒？或是一次重生？"
  },
  Event_7278_Name = {
    Text = "雙面古幣"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "【放飛蝴蝶】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7279_ChoiceDesc2 = {
    Text = "【成為蝴蝶】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7279_ChoiceDesc3 = {
    Text = "【吞回肚子】獲得25黑印"
  },
  Event_7279_Desc = {
    Text = "這一夜發生了太多事。\n碼頭圍攻，幽靈貨輪，蹈海者，圖魯，墨菲，拉蒙娜……一切的一切都在漩渦中回轉，被攪成了彌薩格餐廳早上七點的燕麥粥。\n想要向眼前的喚醒體提問，卻根本不知道怎樣提起，如鯁在咽——或者說，胃裡的蝴蝶。"
  },
  Event_7279_Name = {
    Text = "蝴蝶效應"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "【驅散幻象】失去(Arg3)點生命。"
  },
  Event_7280_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7280_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_7281_ChoiceDesc1 = {
    Text = "【加入祈禱】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7281_ChoiceDesc2 = {
    Text = "【沉入大海】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_7281_ChoiceDesc3 = {
    Text = "【浮出水面】獲得25黑印"
  },
  Event_7281_Desc = {
    Text = "「溫柔的神明，無上的神明。\n請您平息兇惡的風暴，請您阻斷湍急的水流。\n請讓海洋成為我們深邃的家園，讓它為我們的國蒙上永恆的面紗……」\n信徒的低語終於連成了你能理解的話語，但隨之而來的，是難以擺脫的窒息。"
  },
  Event_7281_Name = {
    Text = "夢境禱文"
  },
  Event_7282_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7282_Desc = {
    Text = "你將手中剩余的肉塊丟進貓群。\n群貓如黑色的潮水湧上前。它們發瘋般撕咬肉塊，又迅速一哄而散。\n很不幸，這是一塊過期肉。能填飽乾癟的肚皮，卻不怎麼叫人痛快。"
  },
  Event_7282_Name = {Text = "貓之城"},
  Event_7283_Desc = {
    Text = "一種近水銀態的銀色物質，由融蝕黏液中提煉而出，蘊含強大精神力，主要用於在儀式中連結更多喚醒體。"
  },
  Event_7283_Name = {Text = "銀芯"},
  Event_7284_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒1名喚醒體，並降低其覺醒卡算力消耗2點。感染「(Skill.Arg1)」"
  },
  Event_7284_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7284_Desc = {
    Text = "或許此刻仍無法傳達，但他們遲早會聽見你們的呼喚聲。"
  },
  Event_7284_Name = {
    Text = "指引之聲"
  },
  Event_7285_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7285_Desc = {
    Text = "遊蕩的實驗體已經讓你很是疲憊，短暫的喘息也像是乾涸沙漠中的甘霖。"
  },
  Event_7285_Name = {
    Text = "無盡門扉"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "【離開】隨機覺醒1名喚醒體"
  },
  Event_7286_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7286_Desc = {
    Text = "那聲音必將指引你們的終點，這趟調查的答案。"
  },
  Event_7286_Name = {
    Text = "指引之聲"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "【仔細觀察】"
  },
  Event_7287_Desc = {
    Text = "通過水晶球，你可以觀察遠方"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_7288_Desc = {
    Text = "烏鴉停留在了衣櫃上，尖銳的喙在木門上刻出詭異的紋路。"
  },
  Event_7288_Name = {
    Text = "提燈黑鴉"
  },
  Event_7289_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7289_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_7289_Name = {Text = "聯絡點"},
  Event_7290_ChoiceDesc1 = {
    Text = "【停留在此】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "【尋覓出口】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7290_Desc = {
    Text = "你跨入一片蒼白的寂靜中，交疊的大門無度地旋轉著，漩渦般將你的身軀捲入其中。\n你頭暈目眩地掙扎於顛倒的大門內，依稀辨認著逃離的方向，卻不可避免地一次次墜入另一扇門。\n這次，你再次停在了一扇門前，門後湧動的未知散發著致命的吸引，你的理智卻繃緊了弦。\n是，它的確致命。"
  },
  Event_7290_Name = {
    Text = "重門之外"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "【陷入狂喜】刪除1張指令卡，並回復 Arg1 點生命"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "【停下腳步】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7291_Desc = {
    Text = "像被輕易撬開了頭骨，你的腦內一陣嘔吐般的眩暈，無形之手翻動攪弄大腦，本就趨於流體的物質碎成一灘。\n彷彿未經消化的粥狀腸胃積物，早已擺脫了地心引力，倒灌入你空洞貧乏的大腦皮質。\n它揉搓、拌勻、抓弄，撒上剪碎的歡愉，將落日的遺篇揉進肉裡。"
  },
  Event_7291_Name = {
    Text = "攪動大腦"
  },
  Event_7292_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7292_Desc = {
    Text = "跟驟然現身地獄犬相比，常見的落雪不值得你投注精力。你無視了漸漸飄落的雪花，衝入暗夜。"
  },
  Event_7293_ChoiceDesc1 = {
    Text = "【接通】回復Arg2點生命。"
  },
  Event_7293_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_7293_Name = {Text = "聯絡點"},
  Event_7294_ChoiceDesc1 = {
    Text = "【感到恐懼】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7294_ChoiceDesc2 = {
    Text = "【堅定意志】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7294_Desc = {
    Text = "詭異的哀嚎聲迴蕩不絕，倫蒂尼恩的萬物卻對此不做表態，像是已經死去，或是睡著。\n你無意識地徘徊在鐵路橋下，回憶起阿利斯泰爾的叮囑。\n他彬彬有禮地起身走來，口中似乎向你訴說著什麼，話語卻粘滯不清。\n你抬頭，黑色濃稠液滴從他的口齒中溢出，封堵他的喉嚨，阻塞他的語句——"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_7295_Desc = {
    Text = "「當然，那是當然。不介意的話，我還會助你們一臂之力呢。」\n他為你們遞上一把古樸的手持鏡。\n「騎士已經登上棋盤，國王也不會在後盤等待太久。你們大概很快就要見到他了吧。真是令人期待。」"
  },
  Event_7295_Name = {
    Text = "怪異旅伴Ⅳ"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "【撕碎信紙】刪除2張卡牌"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "【繼續閱讀】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7296_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_7296_Desc = {
    Text = "你眼前是噴湧而出的黑色蝶群，它們不斷地溢出、拍擊翅膀、再不斷摔落在書桌上。\n鋪展開的空白信紙濺滿了墨跡，摔傷的蝴蝶們，奄奄一息地癱在信紙表面。\n翅膀上附帶的黑色黏液連綴成篇，被塗抹成禁忌的文字。\n你從打字機裡抽出這張信紙。"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "【迎向蝴蝶】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "【不再流連】"
  },
  Event_7297_Desc = {
    Text = "最近的倫蒂尼恩流行著這樣一句話：「蝴蝶在阿庫特林地的一次振翅，或許能引起雷歐王國的一場風暴。」\n在看見蝴蝶噴湧而出時，你不由想起了這句話。\n這些蝴蝶，或許足以掀起一場淹沒星球的 災難。"
  },
  Event_7297_Name = {
    Text = "靈知風暴"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7298_Desc = {
    Text = "你將一根手指抵在唇角，示意自己將為此事噤聲。\n黑貓幻影般一閃而過，在你腳邊留下了黑亮的饋贈。"
  },
  Event_7298_Name = {
    Text = "夜貓之禍"
  },
  Event_7299_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7299_Desc = {
    Text = "祂像一段絲綢般滑入了你的提包，隨著輕微的重量增加，你彷彿聽到了一聲輕微的道謝。\n此後再無聲響。"
  },
  Event_7299_Name = {
    Text = "混沌之靈"
  },
  Event_7300_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7300_Desc = {
    Text = "混沌之靈的哭泣愈發尖銳，直到最後變為了刺耳的尖叫，響徹周身。\n祂帶著你的供奉和無法脫身的悲苦，再次沉入泥潭。"
  },
  Event_7300_Name = {
    Text = "混沌之靈"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "【如實填寫】"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "【亂寫一氣】"
  },
  Event_7301_Desc = {
    Text = "東區的街道錯綜複雜，不一會兒你就丟失了孩子們的身影。\n當你一籌莫展之時，一個神秘的女人向你搭話。\n「我知道孩子們去了哪裡，不過，在告訴你之前，能否幫我一個小忙呢？」\n她拿出一張紙，衝你友好地微笑。\n「我叫克萊門汀，是一名心理醫生，正在進行有關倫蒂尼恩居民的心理調查。如果你能幫我填寫一下這個問卷。\n如實填寫的話，我會很樂意為你和你的同伴提供一些幫助。」"
  },
  Event_7301_Name = {
    Text = "心理評估"
  },
  Event_7302_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7302_Desc = {
    Text = "「這也是我的選擇。」捧著糖果的人影說，「但她會成為他的籌碼，你將必須選擇。\n世上並不存在完美的結局。」\n深重的悲傷將你淹沒。人影消散，你扶著心口，不知剛才的究竟是投影，還是精神在重壓下產生的幻覺。"
  },
  Event_7302_Name = {
    Text = "分岔的小徑"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "【金斧頭】"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "【銀斧頭】"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "【我沒有掉東西】"
  },
  Event_7303_Desc = {
    Text = "「跨越維度的先行者啊。」\n耳畔傳來蒼老的聲音，似來自史前，似穿越萬古。\n在極度緊張中，你聽見那個聲音問出了一個有些耳熟的問題。\n「你掉的，是這把金斧頭，還是這把銀斧頭呢？」"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7304_Desc = {
    Text = "「哎呀，這……」她收回問卷，露出了有些無奈的神色，「算了，你畢竟趕時間。孩子們往那裡去了，應該沒走多遠。」\n你匆匆轉身，險些沒能聽清身後的低語。\n「反正，我們會再次見面的。」"
  },
  Event_7304_Name = {
    Text = "心理評估"
  },
  Event_7305_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7305_Desc = {
    Text = "「你是誰？」\n「我是那慘遭殺害的銀鑰使的陰影，兇手是一條狡猾的白化蛇。」\n「白化蛇？那是什麼？」\n「一個失誤。人與蛇雜交而生的……褻瀆之物。」\n你還想繼續追問，影子倏然散去，留下一地金色的塵埃。"
  },
  Event_7305_Name = {Text = "銀鑰使"},
  Event_7306_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」】"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7306_Desc = {
    Text = "事件355（開發中），非最終效果"
  },
  Event_7306_Name = {
    Text = "事件355（開發中）"
  },
  Event_7307_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7307_Desc = {
    Text = "沉進胃裡，和蝴蝶共同飛舞。\n思緒的鱗粉與蝴蝶的交織灑落，在胃裡下起一場簌簌白雪。\n你逐漸捋清了一切，下一個機會到來時，你一定會開口。"
  },
  Event_7307_Name = {
    Text = "蝴蝶效應"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "【反駁它們】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7308_ChoiceDesc2 = {
    Text = "【附和它們】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7308_ChoiceDesc3 = {
    Text = "【提出新觀點】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7308_Desc = {
    Text = "「請和我們保持距離。」\n成群的老鼠將你圍在中心，與你保持著至少五英尺的距離。\n「我們努力繁衍，我們茁壯成長，我們從不挑食——於是我們帶給人類疾病、焦慮和痛苦。」\n「我們和人類不應該走得太近，這不是你該來的地方。」\n為了使老鼠們放鬆警惕，你決定——"
  },
  Event_7309_ChoiceDesc1 = {
    Text = "【打開鐵門】感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」"
  },
  Event_7309_ChoiceDesc2 = {
    Text = "【不做理會】獲得50黑印"
  },
  Event_7309_Desc = {
    Text = "這是一座典型的下承式拱橋，鐵道旁的階梯隱約通向一座鐵門。門後傳來規律而異常的咯噔咯噔聲。\n你駐足觀察門扉，只見其上掛著一把沉重的掛鎖，但並未扣合。"
  },
  Event_7309_Name = {
    Text = "鐵門之後"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_7310_Desc = {
    Text = "面對誘惑，你不為所動。\n聲音的主人頗感遺憾，水面懨懨地盪出幾個漣漪，再無波瀾。"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」】"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7311_Desc = {
    Text = "事件353（開發中），非最終效果"
  },
  Event_7311_Name = {
    Text = "事件353（開發中）"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」，獲得50黑印"
  },
  Event_7312_Desc = {
    Text = "「你們人類再沒有別的答案了嗎？」\n聲音的主人發出不耐的低吼，整個空間隨之震顫。\n「貪婪且無知……這便是我厭倦你們的原因了。」"
  },
  Event_7313_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7313_Desc = {
    Text = "接受密境的安排，於得到中失去，享受被詛咒的擁抱。"
  },
  Event_7313_Name = {
    Text = "妄念噴湧"
  },
  Event_7314_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7314_Desc = {
    Text = "眼睛緩慢地眨了一下，不知道是否聽懂了你的問話。\n一滴金紅相間的淚水從眼角滴落，像一顆微小的星星，散發著太陽一樣的暖光。它下落，下落，帶著悲傷，帶著哀憫，在磚石上碎成一小片塵埃。\n你猛地回過神，那個眼睛已經不見了。"
  },
  Event_7314_Name = {
    Text = "盲目注視"
  },
  Event_7315_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7315_Desc = {
    Text = "幾個穿著簡單，甚至有些髒兮兮的孩子在街上奔跑，身後追著一個穿著警服的大人。 其中一個孩子戴著令你有些眼熟的棕色兜帽。"
  },
  Event_7315_Name = {
    Text = "我們的回憶"
  },
  Event_7316_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7316_Desc = {
    Text = "「別再唱了——」\n你警告五音不全的歌者，休想再來禍害你的耳朵。"
  },
  Event_7316_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7317_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7317_Desc = {
    Text = "「停下步子！！！匍匐爬行的融蝕怪物都比你熟悉自己的四肢！」\n放過觀眾……\n你在心裡這樣祈禱。"
  },
  Event_7317_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7318_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7318_Desc = {
    Text = "黑泥滴落在你臉上，泛起了一陣麻癢。\n你無法忍受，伸手將蝴蝶拍開。\n蝴蝶躲過你不懷好意的動作，無聲無息地消失在盡頭。"
  },
  Event_7318_Name = {
    Text = "不應存在之物"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "【表揚它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7319_Desc = {
    Text = "詹金說：快醒醒，強尼！寫詩還不了你欠下的債務，也解決不了你家地板漏水的問題。\n你說：很不幸，你那些追求真理的細胞會以每天10萬個的速度凋零，很快你就會變成一個真正的腦幹。\n腦子無所謂地聳了聳肩——如果它有的話。\n腦子說：我思故我在。當你能達到我這樣的思想深度，就再也不會關心腦幹了。"
  },
  Event_7319_Name = {
    Text = "哲學之腦"
  },
  Event_7320_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7320_Desc = {
    Text = "鋼琴輕輕地發出一聲歎息，似是寬慰，又似是留戀，像極了什麼人在一曲終了時的笑容。\n「只要孩子們……只要……」\n你還沒來得及聽清，鋼琴的幻影便隨風飄散。"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物3選1，感染「(Skill.Arg1)」"
  },
  Event_7321_Desc = {
    Text = "你接過厚實的病歷本並打開，發現扉頁上寫了「G·R」兩個字。\n「哎呀，哎呀，這不是你的病歷嗎？」克萊門汀似乎毫不介意，「不過，鑽研他人心理，也能提升對自己的認知呢。」\n還沒等你詢問，她的身影便徹底消失。"
  },
  Event_7321_Name = {Text = "病歷本"},
  Event_7322_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7322_Desc = {
    Text = "你接過薄薄的病歷本並打開，發現裡面只有一張紙，上面只寫了一句話。\n「在亙古的混沌之中，蒼白的無目之眼在永恆注視。」\n你想要詢問克萊門汀，卻發現她早已不見了蹤影。"
  },
  Event_7322_Name = {Text = "病歷本"},
  Event_7323_ChoiceDesc1 = {
    Text = "【接通】回復所有生命。"
  },
  Event_7323_ChoiceDesc2 = {
    Text = "【冥想】選擇覺醒1名喚醒體。"
  },
  Event_7323_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_7323_Name = {Text = "聯絡點"},
  Event_7324_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7324_Desc = {
    Text = "重要的物證，還是認真保存，交由歷史系研究解析為宜。"
  },
  Event_7325_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7325_Desc = {
    Text = "驕陽自高天普照大地，刺穿迷障，喚醒倦怠的靈魂。"
  },
  Event_7326_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7326_Desc = {
    Text = "你感到滿足，祂們的窺視閃爍在你頭頂的夜空，將目光聚焦彼身。"
  },
  Event_7326_Name = {
    Text = "穹頂之瞳"
  },
  Event_7327_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7327_Desc = {
    Text = "你無法逃避如坐針氈的注視，自然，也根本不能抗拒諸神的饋贈。"
  },
  Event_7327_Name = {
    Text = "穹頂之瞳"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7328_Desc = {
    Text = "「你究竟是什麼人？」你駭然發問。\n「不必關心這些。敵人的敵人就是朋友，不是嗎？」男人微笑。\n「禮物留在座椅上了，祝你們好運。」"
  },
  Event_7328_Name = {
    Text = "怪異旅伴Ⅳ"
  },
  Event_7329_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7329_Desc = {
    Text = "拉蒙娜湊上前去，期望聽到更多關於「白大褂」的消息。 「有人偷聽！」留聲機的聲音驟然變大，「偷聽，偷聽，偷聽！」"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "【離開】所有喚醒體回復Arg1狂氣"
  },
  Event_7330_Desc = {
    Text = "你牽著男孩柔軟的小手，穿過一扇又一扇門，最終來到一個小小的破舊舞臺前。 \n男孩捏了捏你的手，以示感謝。\n 「謝謝你，再見。」"
  },
  Event_7330_Name = {
    Text = "終幕禮Ⅱ"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "【繼續墜落】獲得白銀造物「(RelicConfig.Arg1)」，是否繼續下墜"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "【抽身離開】獲得25黑印"
  },
  Event_7331_Desc = {
    Text = "「你」邀請著你。\n在螺旋的深處，過去與未來的「你」向你送上來了來自不同維度的「贈禮」。"
  },
  Event_7331_Name = {
    Text = "螺旋深淵"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "【守口如瓶】獲得25黑印"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "【伸手觸碰】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_7332_Desc = {
    Text = "「我要說的只有一句箴言——沒有人能殺死一隻貓！」\n「那該死的黑貓本該被開膛破肚、曝屍荒野，它卻刨開了我的家族墓穴，殘存的人類腐肉被它吞吃殆盡，屍骨肢體則七零八落地散落。」\n「陰冷幽暗的豎瞳注視下，暗黃的膿液浮起一層惡臭，我連滾帶爬地逃離了那裡，被噩夢折磨得精神萎靡。」\n「等等……你們要做什麼，我沒有瘋！我沒有！你們一定是想掩蓋什麼！這是真的——」\n這的確是真的，目送癲狂之人的黑影消散，你和腳邊安靜蹲坐的黑貓對視一眼。"
  },
  Event_7332_Name = {
    Text = "夜貓之禍"
  },
  Event_7333_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7333_Desc = {
    Text = "你向他詢問蠟像館所在的方位。\n真奇怪，算上這回，今夜你們已經見了五次了。你為他點了五次火，問了五次路。\n可你還是不記得蠟像館的位置，正如你和他還是會不斷相遇。"
  },
  Event_7333_Name = {
    Text = "路燈下的身影"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "【繼續追逐孩子】離開"
  },
  Event_7334_Desc = {
    Text = "第三隻烏鴉離開了，飛向了目光不可及之處，飛向了永恆的黑暗。"
  },
  Event_7334_Name = {
    Text = "黑鴉凝視"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "【離開】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7335_Desc = {
    Text = "觸手處的皮毛柔軟細膩，還殘留著庫姆生命的溫熱。\n那是日落前的最後一縷夕陽，轉瞬即逝的余溫。"
  },
  Event_7335_Name = {Text = "余溫"},
  Event_7336_Desc = {
    Text = "你仔細搜索了牆面，終於在草叢後發現一個掩藏的下水道入口。你鑽過下水道，但怪物早已跑遠。"
  },
  Event_7337_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7337_Desc = {
    Text = "禽鳥之間自有規則，它們不依照你的意志而行動，你也無權干涉自然的規律。"
  },
  Event_7337_Name = {
    Text = "離群之鴉"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "【俯瞰倒影】獲得25黑印"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "【你還好嗎？】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7338_Desc = {
    Text = "「你、你知道嗎……隔壁新來的那個老闆娘，總是閉門不出的……我那天請她喝了一杯啤酒，在泡沫完全消失之後，我突然發現……酒杯裡的她、她沒有影子！」"
  },
  Event_7338_Name = {
    Text = "記憶碎片·啤酒"
  },
  Event_7339_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7339_Desc = {
    Text = "「我好想和你再一起唱歌……」\n莎拉癲狂扭曲的哀鳴驟然停頓，變形的面部透露出一絲迷茫。"
  },
  Event_7340_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7340_Desc = {
    Text = "「好開心！好開心！」嘈雜尖銳而充滿童真的聲音在你的耳邊響起，「送給你，送給你！」"
  },
  Event_7340_Name = {
    Text = "夜色精靈"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "【厚實的病歷本】"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "【薄薄的病歷本】"
  },
  Event_7341_Desc = {
    Text = "一個頗為熟悉的聲音叫住了你，你眯起眼睛，卻怎麼也看不清她的身形。\n「我知道你在趕時間，」克萊門汀醫生語調輕快，「我保證不會耽誤你太久。」\n兩隻手穿透腦中的迷霧而來，上面各拿了一本病歷本，一本厚實且有磨損，一本薄而簇新。\n「根據你的問卷結果，我擅自給你做了一份病歷。不過，我一時忘了哪本是你的，不如你來挑選一下？」\n不知為何，薄的病歷本上傳來了一股熟悉的氣息，和你與喚醒體之間的精神聯繫隱隱共鳴。"
  },
  Event_7341_Name = {Text = "病歷本"},
  Event_7342_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7342_Desc = {
    Text = "一面尋常的牆壁，你忍不住敲了敲，卻覺得似乎不是實心"
  },
  Event_7342_Name = {
    Text = "奇怪的牆壁"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "【我又不在水面上】隨機1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "【低頭查看】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7343_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7343_Desc = {
    Text = "「嘻嘻，守密人，你還記得溫柯爾的叮囑嗎？聽著，不·要·在·正·午·時·分·俯·瞰·自·己·的·倒·影。」"
  },
  Event_7343_Name = {
    Text = "無形倒影"
  },
  Event_7343_Tips1 = {
    Text = "尚未擁有白銀造物"
  },
  Event_7344_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7344_Desc = {
    Text = "來自遙遠未來的幻影，隱沒在艾爾沃斯的山隘。"
  },
  Event_7345_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7345_Desc = {
    Text = "蝴蝶在你的掌心碎裂，如同被猛然擊碎的玻璃天花板，破缺的殘片向著地心引力墜落，墜落，墜落——"
  },
  Event_7345_Name = {
    Text = "鋼橋的幻覺"
  },
  Event_7346_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7346_Desc = {
    Text = "等他們從暗影中現身再說吧。"
  },
  Event_7346_Name = {
    Text = "提燈黑鴉"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "【打開開關】擴大當前視野。"
  },
  Event_7347_Desc = {
    Text = "前人遺留下來的照明裝置，能驅散四周的黑色迷霧。\n它周圍的霧氣規律地波動著，像是被它的呼吸驚擾。"
  },
  Event_7347_Name = {Text = "探照燈"},
  Event_7348_ChoiceDesc1 = {
    Text = "【指出問題】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "【咽下疑問】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_7348_Desc = {
    Text = "直到現在，你還在回味墨菲講述的過去。\n回憶讓與你共感，緊緊桎梏、擠壓著你的大腦，就連最後戈利亞對墨菲的那番開解都沒能讓你感到慰藉。\n……等等，他們說，星辰正位之時在二十五年後……\n可眼前的墨菲，分明只是個半大孩子……"
  },
  Event_7348_Name = {
    Text = "被禁錮的生命"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_7349_Desc = {
    Text = "她應該落淚的，沒人比她更有資格哭泣。\n可是，她為什麼沒有呢？她為什麼只是置身事外呢，就好像那些人跪拜的不是她一樣……"
  },
  Event_7349_Name = {
    Text = "航前典儀"
  },
  Event_7350_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7350_Desc = {
    Text = "無論如何，打探他人隱私是不禮貌的行為。"
  },
  Event_7350_Name = {
    Text = "見字如晤"
  },
  Event_7351_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7351_Desc = {
    Text = "一定只是一時眼花。"
  },
  Event_7351_Name = {
    Text = "黑鴉凝視"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_7352_Desc = {
    Text = "記憶中所有人都對她祈禱著，哀求著。你忍不住也在心中默念著……"
  },
  Event_7352_Name = {
    Text = "航前典儀"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7353_Desc = {
    Text = "黑貓的身下淅淅瀝瀝地睇下不少黑色粘液，粘液彙聚的小溪直連向巷口的下水道。見你沒有湊近的意思，黑貓掉頭躍入下水道，不見蹤影。"
  },
  Event_7353_Name = {
    Text = "夜色精靈"
  },
  Event_7354_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7354_Desc = {
    Text = "你驚慌不已，發出刺耳的尖叫聲。\n似是被你的聲音所惑，原本焦躁不安的手遲疑了一瞬。\n你抓住這個機會立刻逃了出去。"
  },
  Event_7354_Name = {
    Text = "黯色沼澤"
  },
  Event_7355_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7355_Desc = {
    Text = "扭曲、蠕動、爬行……你用盡一切方法來擺脫這些惱人的手臂。\n最終你還是逃了出去，代價是一套簇新的校服、兩根肋骨和幾百根頭髮。"
  },
  Event_7355_Name = {
    Text = "黯色沼澤"
  },
  Event_7356_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7356_Desc = {
    Text = "「正常現象，別大驚小怪的，像是個初出茅廬的新手一樣，」\n朵爾湊近前，幫你正了正胸針的位置，「說明附近有特殊維度的通道。看起來就在瘋人院的方向。」"
  },
  Event_7356_Name = {
    Text = "不安的胸針"
  },
  Event_7357_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7357_Desc = {
    Text = "你沒有道理接受提燈教眾飼喂之物的要求。\n烏鴉不滿地晃動著污濁可怖的堆疊頭顱，發出你在墳墓邊才會聽見的怪聲，嚎叫著飛走了。"
  },
  Event_7357_Name = {
    Text = "詛咒怪鴉"
  },
  Event_7358_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7358_Desc = {
    Text = "「這也是我的選擇。」抱著小熊的人影說，「但她會成為他的傀儡，而他們都會死去。\n你，將是那個罪惡的幫兇。」\n強烈的愧疚將你淹沒。人影消散，你扶著心口，不知剛才的究竟是投影，還是精神在重壓下產生的幻覺。"
  },
  Event_7358_Name = {
    Text = "分岔的小徑"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "【繼續捂住耳朵】獲得狂氣值最高的喚醒體狂氣值等同數量黑印(Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "【繼續捂住耳朵】回復(Arg1)點生命，擁有的黑印將提高回復量"
  },
  Event_7359_Desc = {
    Text = "你依從了耳畔不懷好意的勸慰，尖嘯如針尖般扭動著刺入你的耳孔。\n「停下——快停下——我都已經按你說的做了——快停——」\n你痛苦地捂住頭顱，恍惚間聽見了鴉群的嘲弄。"
  },
  Event_7359_Name = {
    Text = "群鴉之歌"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "【抓住一隻烏鴉】每擁有1名已覺醒喚醒體獲得25黑印"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "【發出尖嘯】選擇覺醒1名喚醒體並對其覺醒卡添加「固有」與「保留」效果"
  },
  Event_7360_Desc = {
    Text = "你玩心驟起，伸手抓住了一隻烏鴉。\n它在你掌心絕望地掙扎著，最終炸成一團溫暖的水漿。"
  },
  Event_7360_Name = {
    Text = "群鴉之歌"
  },
  Event_7361_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7361_Desc = {
    Text = "你捂著耳朵閉起雙眼。\n咚咚，咚咚……你的心跳與尖嘯聲交織，譜寫出一曲紛亂的死亡之歌。\n這一刻，你感到前所未有的寧靜。"
  },
  Event_7361_Name = {
    Text = "群鴉之歌"
  },
  Event_7362_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7362_Desc = {
    Text = "密境中危機四伏，不是所有的光都是指引前路的燈塔。\n那也可能是引誘飛蛾的燭火。"
  },
  Event_7362_Name = {
    Text = "暗夜螢光"
  },
  Event_7363_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7363_Desc = {
    Text = "「你早就死了，也回不了家。」 你的聲音冷酷得像羅斯雪原上呼嘯的風。 旅人的表情沒有任何變化，彷彿事情本該如此。他再度抓住你的手，「請救救我。 我是一名士兵，奉命前往遙遠的東方……」"
  },
  Event_7364_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7364_Desc = {
    Text = "電報機已經損壞。你能想像電報機的主人在風暴中的絕望……因為此刻的你也是。"
  },
  Event_7364_Name = {
    Text = "無聲電報"
  },
  Event_7365_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7365_Desc = {
    Text = "「向前五十碼左拐，然後右拐，再左拐……\n然後一直走到頭，你家就在那裡。」\n旅人開心極了。他向你揮揮手，隨後便離開了。\n你長舒一口氣，忽然感覺有人抓住了你的手。耳畔再度響起那個熟悉的聲音：\n「請救救我。\n我是一名士兵，奉命前往遙遠的東方……」"
  },
  Event_7366_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7366_Desc = {
    Text = "你終於走出了這座迷宮。\n那一刻你忽然明白了，這座蠟像館是個活物。\n一切詭譎、美和殘酷，都以一種古老的儀式聯結在一起。\n而儀式的眼睛，就是羅傑斯。"
  },
  Event_7366_Name = {
    Text = "眼睛的迷宮"
  },
  Event_7367_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7367_Desc = {
    Text = "「角色扮演有意思嗎，守密人？」拉蒙娜扯了扯你的袖口，「出口離我們不遠了，希望您在達芙黛爾夫人面前也能保持此刻的風趣。」"
  },
  Event_7367_Name = {
    Text = "回憶碎片·舊夢重現"
  },
  Event_7368_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7368_Desc = {
    Text = "「喚醒體很難反抗連結者的意志，」你回應道，「但我們不會放棄。」"
  },
  Event_7368_Name = {
    Text = "她的選擇"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "【進入】穿過牆壁，一探究竟。"
  },
  Event_7369_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7369_Desc = {
    Text = "你靠近牆壁，牆面突然扭曲起來，似乎想要將你吸入"
  },
  Event_7369_Name = {
    Text = "扭曲的空間"
  },
  Event_7370_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7370_Desc = {
    Text = "「不，這不是真的。比起蟑螂，你們至少有毛茸茸的身體。\n沒人能拒絕毛茸茸的身體。」\n老鼠們竊竊私語，最終勉強同意了你的觀點。\n「還好啦……其實也沒有很多毛。」\n被誇讚總是令人高興的。臨走前，老鼠們送了你一件小小的禮物。"
  },
  Event_7371_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7371_Desc = {
    Text = "「我同意！人類和老鼠不共戴天！」\n老鼠們有點生氣，露出白花花的獠牙。\n「那你還在這裡做什麼？拿走你的東西，永遠不要回來。」"
  },
  Event_7372_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7372_Desc = {
    Text = "歡迎來到深海之下，這裡每走一步都會有重重壓力。\n\n不可透光的混沌迷霧將一切隱匿其中，你能在重壓之下通過這片無光之海麼？"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "【隨便看看】刪除1張卡牌"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "【仔細看看】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7373_Desc = {
    Text = "「嗒嗒……」\n打字機如同喝多了威士卡的老酒鬼，吞吞吐吐地往外吐出黑色的油墨。\n你敏銳地捕捉到「梅森」的字樣，立刻將打字紙抽出。"
  },
  Event_7373_Name = {Text = "打字機"},
  Event_7374_ChoiceDesc1 = {
    Text = "【直視眼睛】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7374_ChoiceDesc2 = {
    Text = "【閉上雙眼】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7374_Desc = {
    Text = "無數眼睛環繞在你耳邊低語。\n「我們旅行，我們停下，我們大步流星走過了數萬年甚至更長時間。\n當太陽在凝望中逐漸暗淡，當舊地球的生命被洪水湮沒。\n我們早已被宇宙的奧秘深深吸引。」"
  },
  Event_7375_ChoiceDesc1 = {
    Text = "【遵從指示】提升 Arg1 點生命"
  },
  Event_7375_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7375_Desc = {
    Text = "你嘗試用銀鑰匙的追溯之力尋找最近的聯絡點，但獲得的資訊中夾雜著難以察覺的異常，似乎被干擾了。"
  },
  Event_7375_Name = {
    Text = "異常聯絡"
  },
  Event_7376_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7376_Desc = {
    Text = "你用彌薩格學生套裝中配置的標準亞麻布手帕輕輕揩拭打字機的表面。\n打字機又恢復了平靜。至於髒污的手帕……就讓它留在密境中吧。"
  },
  Event_7376_Name = {
    Text = "打字機的低語"
  },
  Event_7377_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7377_Desc = {
    Text = "你定睛去細看，晃動重疊的墨痕中依稀浮現出一個名字，「Fingal Johansen」。\n這是誰？"
  },
  Event_7377_Name = {
    Text = "打字機的低語"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "【仰頭直視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7378_ChoiceDesc2 = {
    Text = "【太陽的仰角？】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7378_Desc = {
    Text = "「現在，立刻抬頭看向東南方，太陽的仰角正在其位。」通訊器中傳來朵爾的指令。"
  },
  Event_7379_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」】"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7379_Desc = {
    Text = "事件354（開發中），非最終效果"
  },
  Event_7379_Name = {
    Text = "事件354（開發中）"
  },
  Event_7380_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7380_Desc = {
    Text = "孩子們的聲音從琴鍵下流出。\n「老查理有一隻他很愛的虎斑貓……」\n孩子們的歌聲之下，一個年輕女性的聲音也在輕輕溫柔歌唱。\n是你聽錯了嗎？"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "【轉身】獲得25黑印"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "【繼續前行】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7381_Desc = {
    Text = "身後傳來腳步聲。\n如影子一般不疾不徐、不緊不慢。\n和你的腳步聲交織在一起，迴蕩在空曠的陳列室裡。"
  },
  Event_7382_ChoiceDesc1 = {
    Text = "【收起信紙】刪除2張卡牌"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "【保留信紙】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7382_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_7382_Desc = {
    Text = "一台新式打字機。\n它有一套與眾不同的字母鍵，就像顯微鏡一樣華麗又精巧。\n你正沉迷於它完美的機械結構，黑色的字跡忽然顯現。\n「尊敬的羅傑斯先生，\n我們懷著沉重的心情通知您，您已經被學院開除。\n眾所周知，@2學院一直以嚴謹的治學態度聞名王國境內，那些驚世駭俗的傳言@3深深的困擾……」"
  },
  Event_7382_Name = {
    Text = "見字如晤"
  },
  Event_7383_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7383_Desc = {
    Text = "遠方的停滯的懷錶像是某種催促，提醒你們不要淪陷於時空的陷阱中。"
  },
  Event_7383_Name = {
    Text = "祂的注視"
  },
  Event_7384_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7384_Desc = {
    Text = "黑泥滴落在你臉上，泛起了一陣麻癢。\n你無法忍受，伸手將蝴蝶拍開。\n蝴蝶躲過你不懷好意的動作，無聲無息地消失在盡頭。"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "【仔細觀察】"
  },
  Event_7385_Desc = {
    Text = "庫姆背著你們三人在瘋人院內尋找入口。\n突然，它一個急刹，險些將你們震下背脊。\n在你們的疑問聲中，庫姆低著頭，在鬆軟的土面上嗅探著，扭頭向你們示意，似乎是下方埋著什麼"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "【領取】獲得3選1黃金造物"
  },
  Event_7386_Desc = {
    Text = "那裡空無一物，漆黑的液體橫流於地面上，倒映不出任何。\n是你的錯覺嗎？你感覺什麼東西在指縫溜走。"
  },
  Event_7386_Name = {
    Text = "鏡面之下"
  },
  Event_7387_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7387_Desc = {
    Text = "黑色的羽翼落在小巷潮濕的泥土底上，化為黑泥狀的融蝕漿。"
  },
  Event_7387_Name = {
    Text = "躁亂鴉群"
  },
  Event_7388_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7388_Desc = {
    Text = "「達芙黛爾女士會喜歡你的幽默的。」拉蒙娜揮揮手，薄霧般的幻影隨之流散，「別讓自己成為維度旅行的代價。」"
  },
  Event_7388_Name = {
    Text = "回憶碎片·舊夢重現"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "【領取】獲得3選1黃金造物"
  },
  Event_7389_Desc = {
    Text = "哦是的，那個可憎的倒影就是你自己。\n噴薄而出的惡意與你腳下的黑漿融作一團，扭曲地共舞著，如果不介意，它也想攀上你的肩頭。"
  },
  Event_7389_Name = {
    Text = "鏡面之下"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "【原地不動】獲得25黑印"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "【隨意走動】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7390_Desc = {
    Text = "你將自己的影子踩得粉碎，墜入了一灘夜色中。\n那破損得七零八落的黑影，是那個失去行蹤的世界裡，與你相連的唯一之物。\n真的要在漆黑的噩夢中行走嗎？你還尚未尋到方向。"
  },
  Event_7390_Name = {
    Text = "噩夢行者"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "【尋找源頭】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7391_ChoiceDesc2 = {
    Text = "【重播唱片】所有喚醒體回復50狂氣，感染「(Skill.Arg1)」"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "【拆掉留聲機】獲得3選1刻印"
  },
  Event_7391_Desc = {
    Text = "你遇見一個廢舊的老式留聲機。\n擰上了發條，你將唱針抵上遍佈劃痕的黑膠唱片，交響樂失真得彷彿膠帶撕黏後的拉扯，管樂和絃樂互毆，沒有一個聲部能從這首曲子中全身而退。\n樂曲滋滋啦啦的結尾處，你卻聽見了一陣規律的敲擊。\n「咚咚……咚咚咚……咚……」\n你皺起眉，撥開了唱針，可敲擊聲依舊如故。"
  },
  Event_7391_Name = {
    Text = "迷蹤留聲"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "【端詳光輝】選擇1個造物變化為詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "【觸摸光輝】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7392_ChoiceDesc3 = {
    Text = "【轉身離開】獲得25黑印"
  },
  Event_7392_Desc = {
    Text = "幻夢視野之下，密境迷霧為現實披上了墨色的紗。入目一切都若隱若現，似有若無。\n朦朧中，有什麼東西的光輝穿透了迷霧。如燈塔之於遊船，炊煙之於迷童，指引著安全的方向。"
  },
  Event_7392_Name = {
    Text = "暗夜螢光"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "【暫停音樂】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "【與它對話】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7393_ChoiceDesc3 = {
    Text = "【靜心聆聽】獲得25黑印"
  },
  Event_7393_Desc = {
    Text = "你從一灘污濁的黑漿中，撚起幾粒破碎的記憶。\n晶體透亮含光，幾縷遊絲在其內搖曳翻飛，殘存的記憶碎屑如被風吹散的沙礫，飛揚在半空。\n混亂、離奇、弔詭的畫面在你身側升騰。\n你看向——\n"
  },
  Event_7393_Name = {
    Text = "銀月碎片"
  },
  Event_7394_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7394_Desc = {
    Text = "你伸手接住幾枚落雪，定睛細看。那雪花融化成的並非晶瑩的水滴，而是濃稠黑暗的融蝕漿。"
  },
  Event_7395_ChoiceDesc1 = {
    Text = "【我又不在水面上】隨機1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "【低頭查看】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7395_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7395_Desc = {
    Text = "霧氣散去，一隻枯瘦的手掌，遞到了你的面前。\n它似乎被腐蝕掉了血肉，崎嶇不平的掌面上覆蓋著粘稠的黑漿，而它身上，則墜滿了流淌著金光的戒指項鍊。\n它朝你勾了勾手，似乎是在引你靠近。\n只有在危機的陰翳下，珍寶才顯得尤為閃耀。"
  },
  Event_7395_Tips1 = {
    Text = "尚未擁有白銀造物"
  },
  Event_7396_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7396_Desc = {
    Text = "幻影向你招了招手，然後消失了。留給你的只有寒冷的冰雪和巍峨的山脈。"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "【銀月的葬禮】選擇1個造物變化為詛咒造物「(RelicConfig.Arg1)」"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "【銀月的禱告】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7397_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7397_Desc = {
    Text = "你從一灘污濁的黑漿中，撚起幾粒破碎的記憶。\n晶體透亮含光，幾縷遊絲在其內搖曳翻飛，殘存的記憶碎屑如被風吹散的沙礫，飛揚在半空。\n混亂、離奇、弔詭的畫面在你身側升騰。\n你看向——"
  },
  Event_7397_Name = {
    Text = "銀月碎片"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "【加點燃料】獲得3選1刻印"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "【熄滅它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7398_Desc = {
    Text = "「我是那慘遭殺害的侍女的陰影，兇手是那片虛假的碧綠火焰。」\n微紅的暗淡火苗身姿搖曳，向你控訴。\n「我曾活在那片映出的凸月湖畔，燦爛奪目，光芒萬丈。」"
  },
  Event_7399_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7399_Desc = {
    Text = "你和影子站在路燈下，誰也沒有說話。\n今天晚上沒有月亮，所有的房子都靜悄悄的。\n你朝影子揮了揮手，轉身離去。"
  },
  Event_7399_Name = {
    Text = "路燈下的身影"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得Arg1黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_7400_Desc = {
    Text = "烏鴉停留在了床頭，用泛紅的雙眼注視著你。"
  },
  Event_7400_Name = {
    Text = "提燈黑鴉"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "【說自己沒有錢包】獲得3選1刻印"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "【將網打破】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7401_Desc = {
    Text = "橙黃色的網在空中靜靜地漂浮，它孔洞稀疏，遠不如牆根上棲息了一隻蜘蛛的遠親來得精緻。\n你忍不住伸手觸碰，脆弱的網瞬間溶解，孩子們的歡笑在你耳邊響起。\n「金的銀的黃的紅的，所有錢包的都是我們的！」"
  },
  Event_7401_Name = {
    Text = "迷走網路"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "【維修電報機】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7402_ChoiceDesc2 = {
    Text = "【掩埋電報機】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7402_ChoiceDesc3 = {
    Text = "【無視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7402_Desc = {
    Text = "你躲進狹長的山洞裂隙，暫避風雪。但你深知自己無法在這裡停滯太久，若是那群黑袍的怪人找到此處，你將無路可逃。\n在狹縫的角落裡，你居然發現了一台破損的電報機。"
  },
  Event_7402_Name = {
    Text = "前人遺物"
  },
  Event_7403_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7403_Desc = {
    Text = "你曾在王國境內許多地方見過這樣的肖像畫。\n「那位女王」位於畫面中央，在黑色玫瑰的簇擁下熠熠生輝。\n只除了一點——她的臉被無情剜掉，留下一片燒焦的黑色空洞。\n你至今仍無法得見女王的真實面目。"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "【放過她】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7404_ChoiceDesc2 = {
    Text = "【幫助她】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "【我要走自己的路】獲得50黑印"
  },
  Event_7404_Desc = {
    Text = "三個人影攔住了你的去路。\n「你可以放過她，」雙手抱著沾滿融蝕漿的小熊玩偶的人影開口，「她只是膽怯，而不邪惡。她不想傷害任何人。」\n「你可以幫助她，」雙手捧著一把包裝精緻的糖果的人影開口，「你能夠做到她不能做到的事情，你能夠結束這一切。」\n「你不需要聽我們的，」雙手空空如也的人影開口，「你有你自己的路。」"
  },
  Event_7404_Name = {
    Text = "分岔的小徑"
  },
  Event_7405_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7405_Desc = {
    Text = "達芙黛爾的聲音停頓了片刻。\n「哦呀，你選擇了這個嗎？不錯的選擇，作為獎勵，我會特別送你一個禮物。」\n「我對那個孩子並不熟悉，但我對弗朗西斯有一個猜想。我覺得，支配她、讓她獲得了」看見「的力量的情緒，是強烈的悔恨。不知道她會為這悔恨做出怎樣的選擇呢……」"
  },
  Event_7405_Name = {
    Text = "提示時間"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "【納入腦缸】將「備用腦缸」洗入抽牌堆。"
  },
  Event_74068_Desc = {
    Text = "浮雕繁複的圓拱門內，紅磚外牆的斜頂上、牆壁豁口的排屋前，拉長的影子躍動著，渴求著問題的答案。\n平庸就意味著死亡嗎？\n安於現狀就註定薪盡火滅嗎？"
  },
  Event_74068_Name = {
    Text = "尚未流失的意識"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "【繼續容納】選擇至多 2 張指令卡從牌庫中刪除，並將它們置入「備用腦缸」。"
  },
  Event_74069_Desc = {
    Text = "「我看見了他們。許多人，許多夢囈，智慧的，膚淺的，理智的，瘋狂的。有時候，灰燼中也會誕生希望的火星。」"
  },
  Event_74069_Name = {
    Text = "尚未流失的意識"
  },
  Event_7406_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7406_Desc = {
    Text = "你小心地將老鼠從天平上取下，它平緩地呼吸著，毛茸茸的軀體溫暖了你的掌心。"
  },
  Event_7406_Name = {
    Text = "理智與情感"
  },
  Event_7407_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7407_Desc = {
    Text = "黯淡的銀芯迸發出耀目光芒，轉瞬即逝，手中只剩下一把與沙土無異的灰燼。\n銀芯耗盡了最後的靈知，不知名的靈魂未能重鑄肉身，但在完全消逝前，也留下了存在過的痕跡。"
  },
  Event_7407_Name = {
    Text = "存在的證明"
  },
  Event_7408_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7408_Desc = {
    Text = "「我對那個孩子並不熟悉，但我對弗朗西斯有一個猜想。我覺得，支配她、讓她獲得了『看見』的力量的情緒，是強烈的悔恨。不知道她會為這悔恨做出怎樣的選擇呢……」"
  },
  Event_7408_Name = {
    Text = "提示時間"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "【把紙抽出來】刪除1張卡牌"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "【現在不是時候】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7409_Desc = {
    Text = "手提箱內的便攜打字機忽然自己活動起來，打出半頁歪歪扭扭的文字。\n 「你已經看見祂了，祂就在你的身側，那些被瘋狂污染的，狂熱的影子……不要直視祂的輪廓。」"
  },
  Event_7409_Name = {
    Text = "不請自來的警告"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "【向左走】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7410_ChoiceDesc2 = {
    Text = "【向右走】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7410_Desc = {
    Text = "你似乎走入了一個迷宮。\n向左、向右、再向左……你逐漸失卻耐心，直到你抬起頭，看見了那只眼睛。\n眼睛注視著你們，平靜威嚴，彷彿它才是這裡的主宰。"
  },
  Event_7410_Name = {
    Text = "眼睛的迷宮"
  },
  Event_7411_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7411_Desc = {
    Text = "你奮力抽回雙手，並清晰地聽到了骨頭碎裂的聲音。\n這是你為好奇心付出的代價。"
  },
  Event_7411_Name = {
    Text = "靈感迸發"
  },
  Event_7412_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7412_Desc = {
    Text = "你妥善檢查了一番相機，皮革與黑金嵌在機體中，折射出幾分油亮的光澤。\n它的鏡頭對準了你，彷彿在凝視，在窺探……"
  },
  Event_7412_Name = {
    Text = "記錄無罪"
  },
  Event_7413_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7413_Desc = {
    Text = "你毫不留情地扯出了另外半截膠片，它們藏身於相機肚內，驟然被拉出，上面的畫面卻叫你久久無言。\n未經沖洗的膠片，忠實地記錄下了——你倒在一灘黑泥中的畫面。"
  },
  Event_7413_Name = {
    Text = "記錄無罪"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "【閱讀】刪除1張指令卡，獲得25黑印"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "【繼續打字】複製一張牌庫中的牌，感染「(Skill.Arg1)」"
  },
  Event_74145_Desc = {
    Text = "打印機猛烈地噴吐著油墨。\n黑色的油墨如同幽靈般從噴嘴中噴湧而出，彌漫在空氣中，形成了一片濃烈而壓抑的黑霧。\n鍵盤上似乎藏著某種暗示，等待無辜的手指觸碰。"
  },
  Event_74145_Name = {
    Text = "幽靈油墨"
  },
  Event_74146_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74146_Desc = {
    Text = "你側身踏入暗巷，霧氣啃噬著衣角，可那影子卻在身後裂變成無數雙眼睛。銹蝕的鐘聲裹挾著潮濕的預兆。\n\n你知道，所有迂回的道路終將坍縮成循環的繭——在腐爛的黎明前，你與自己的倒影終會重逢。"
  },
  Event_74146_Name = {
    Text = "時間灰燼"
  },
  Event_74147_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74147_Desc = {
    Text = "你在胸口默默繪下輪廓，為逝者獻上無言的禱告。\n在這個湮滅的世界中，有太多你無法拯救的東西。\n骨骸閃爍著，主人生前珍藏的寶物透出一角。"
  },
  Event_74147_Name = {
    Text = "褪色遺骨"
  },
  Event_74148_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74148_Desc = {
    Text = "「父神感念你的慈悲。父神將看顧我們，救贖我們脫離苦難的重擔。」\n\n她的幻影漸漸消散，聖樂之聲也化作無情的風呼嘯而過。"
  },
  Event_74148_Name = {
    Text = "管風琴的禱告"
  },
  Event_74149_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74149_Desc = {
    Text = "你輕輕推了推裸露的骸骨，它自然而遲緩地陷沒入黑色的黏液，消失得無影無蹤。\n願靈魂在虛無中得到安息。"
  },
  Event_74149_Name = {
    Text = "褪色遺骨"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "【離開】你戰勝了對手，無事發生"
  },
  Event_7414_Desc = {
    Text = "「看來，小傢伙得吃點苦頭，才能知道女人的秘密是不能輕易打探的。」\n隨著達芙黛爾的話音落地，龐大的怪物出現在你的面前。"
  },
  Event_7414_Name = {
    Text = "提示時間"
  },
  Event_74150_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74150_Desc = {
    Text = "小小老鼠藏身的鐘樓裡不應存在這種病態的玩具，這聲音來源於你的頭腦，你的記憶。\n你回憶起身為缸中之腦時曾經感受過的，通過聲波轉化的電流。\n那異響逐漸變得正常平緩，化成一首流暢的古典樂，在你的腦中循環播放。"
  },
  Event_74150_Name = {
    Text = "鐘樓上的異響"
  },
  Event_74151_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74151_Desc = {
    Text = "那不是貓……那是聳動的提燈教眾。\n黑色的輕紗下透出憎惡和敵意，絮語聲刮擦著你的意識，帶來詭異莫名的幻覺。"
  },
  Event_74151_Name = {
    Text = "貓的呢喃"
  },
  Event_74152_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74152_Desc = {
    Text = "他們抓住了你的鞋子，抓住了你的腳腕，他們貪婪，他們渴求，他們要將你拖入他們身處的深淵。\n你勉力掙扎，才維持住身形，後退幾步以求脫身。\n不經意間，有什麼東西掉落下來。"
  },
  Event_74152_Name = {
    Text = "噩夢倒影"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "【閃避】獲得3選1刻印"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "【阻止】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74153_Desc = {
    Text = "似曾相識的畫面，讓你的神經跳躍著，抽搐著，恐懼著。\n「又一次……」\n慘無人道的噩夢降臨，龐大的無力感籠罩了你。\n你真的不能改寫她的命運嗎？\n來不及了，莎拉開裂的頭顱內，泛著銀光的巨口亟待將你一口咬斷，吞噬咀嚼。"
  },
  Event_74153_Name = {
    Text = "噩夢重現"
  },
  Event_74154_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74154_Desc = {
    Text = "你聽見令人不安的呢喃。\n\n「我們來自遙遠星辰上的群山與沼澤。我們的身軀是提燈的燈芯與燃料，我們將點燃來自大地的薪火，照亮通往新世界的坦途。」"
  },
  Event_74154_Name = {
    Text = "貓的呢喃"
  },
  Event_74155_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74155_Desc = {
    Text = "夕陽，鐘樓，飛鳥……\n那個女孩摘下眼罩，她灰暗瞳孔的注視令你動彈不得。\n幻象如同蜃景，在眼前一觸即散，但擔憂的思緒揮之不去。"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "【拾起】獲得3選1白銀造物"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "【回想】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_74156_Desc = {
    Text = "在轉角的融蝕黏液中，躺著一枚小小的白色眼罩。 \n回憶攫住了你的心臟。"
  },
  Event_74157_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74157_Desc = {
    Text = "透明的手掌在黑白的琴鍵上自如地舞動，傳出的音浪卻支離破碎，像一枚走調的音樂盒，每個音符都發出不和諧的哀鳴，彷彿掙扎的求救。\n最終，演奏在一個無奈的和絃中戛然而止。\n生前未能獲得的，在此刻只留下悵惘。"
  },
  Event_74157_Name = {
    Text = "遺憾的奏鳴"
  },
  Event_74158_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74158_Desc = {
    Text = "「尊敬的莎拉女士：\n我請求辭去濟貧院護工一職。\n我已經不認可您的理念了。您的教導是錯誤的，東區的孩子不應該在您的廕庇下長大，不應當相信純粹的善意和無私的賦予。\n他們總有一天要離開您的羽翼，去學習東區生存的法則。\n\n……」\n\n後續的字跡被黑色的液體濡濕，一片模糊。"
  },
  Event_74158_Name = {
    Text = "幽靈油墨"
  },
  Event_74159_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74159_Desc = {
    Text = "「我能提供給孩子們的，只有一片遮雨的屋簷，和一口勉強不至於餓死的飯食。如果不是好心的羅傑斯先生叫來的醫生，她們生病時連一劑藥片都沒法獲得。\n我沒有讀過許多書，讓他們不至於凍餓死在街頭就是我能做到的全部了。\n我從來不曾干涉孩子們去成為什麼樣的人，但她們需要活下去。\n……」"
  },
  Event_74159_Name = {
    Text = "幽靈油墨"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "【探尋來源】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "【丟棄信件】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "【檢查信件】獲得50黑印"
  },
  Event_7415_Desc = {
    Text = "又一封信落在了你的身前，被劃爛的信紙讓人心下一沉，你掀開了信紙。\n「它又來了，我預告的那些都不是妄言！@4從這裡開始，也將從這裡結束。」\n「我想逃……縮進了木櫃裡，手在控制不住地抖，但黏膩的肢體砸在地板上的聲音，還步步緊逼……我聽見了一個名字！就是它！@5！」"
  },
  Event_74160_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74160_Desc = {
    Text = "「感謝你，父神的創生之力終將重塑我們的形體，為我們帶來永恆的光明與火焰。\n\n當我抵達終點時，會在父神面前為你祝福。」\n\n她的幻影漸漸消散，聖樂之聲也化作無情的風呼嘯而過。"
  },
  Event_74160_Name = {
    Text = "管風琴的禱告"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "【安葬】回復 Arg2 點生命[ExDesc1]，選擇 1 張指令卡刪除。"
  },
  Event_74161_ChoiceDesc2 = {
    Text = "【禱告】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74161_Desc = {
    Text = "一截蒼白的骸骨，半數浸沒於漆黑的融蝕漿中。"
  },
  Event_74161_Name = {
    Text = "褪色遺骨"
  },
  Event_74162_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74162_Desc = {
    Text = "你徑直踏入那團迷霧，幻影如蛛網般纏上你的身軀，冰冷的觸感滲入骨髓。\n他們的低語化作記憶的碎片，刺穿你的胸膛。\n當你穿過，身後只餘一片虛無，而前方，濃霧中隱約浮現出更多模糊的影子，等待吞噬。"
  },
  Event_74162_Name = {
    Text = "時間灰燼"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "【繞開幻影】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74163_ChoiceDesc2 = {
    Text = "【穿過幻影】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_74163_Desc = {
    Text = "塵霾如厚重的帷幕，籠罩著街道，每一步都像是踩在時間的灰燼上。\n遠處，兩個朦朧的影子在霧氣中若隱若現，彷彿是過去的幽靈，低語著那些早已被遺忘的故事。\n失控的想像力又從中幻化出一個個可怖的影子，它們扭曲、蔓延，像是未來的預兆，壓得你喘不過氣。\n你知道，前方的路只會更加昏暗，而你的腳步，卻不能也不應停下。"
  },
  Event_74163_Name = {
    Text = "時間灰燼"
  },
  Event_74164_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74164_Desc = {
    Text = "你堪堪閃過了莎拉的第一次迅猛攻擊。\n接下來，就未必會那麼幸運了。"
  },
  Event_74164_Name = {
    Text = "噩夢重現"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "【指示方向】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74165_ChoiceDesc2 = {
    Text = "【一同禱告】獲得3選1刻印"
  },
  Event_74165_Desc = {
    Text = "鋼琴和管風琴的聲音在灰暗的風中交織。彷彿有魔力的旋律飄蕩在無人的街巷。\n一位無名的修女在琴聲中禱告。\n「簡單的禱告無需隆重的典儀，偉大的父神會為我們播撒希望，正如他曾賜予我們虔誠的教導。」"
  },
  Event_74165_Name = {
    Text = "管風琴的禱告"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "【招架怪物】選擇1個造物變化為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "【拾起星辰】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74166_ChoiceDesc3 = {
    Text = "【無視】獲得25黑印"
  },
  Event_74166_Desc = {
    Text = "流星的雨幕墜落在鐘樓。\n一顆透亮的晶體恰落在你的腳邊，砸出一塊小小的陷坑。\n你仍深陷包圍，形態各異的融蝕體像是扭曲的影子，咆哮、嘶吼聲不絕於耳。\n你決定——"
  },
  Event_74166_Name = {
    Text = "隕落的星"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "【揉揉眼睛】獲得50黑印"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "【閉上眼睛】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_74167_Desc = {
    Text = "面目可憎的黑色貓群蜂擁在於麗埃特身後，呢喃著不知名的音調，散發出隱秘的惡意威脅。"
  },
  Event_74167_Name = {
    Text = "貓的呢喃"
  },
  Event_74168_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74168_Desc = {
    Text = "廉價的布料摸在手裡有些粗糙，但仍被細心地清洗乾淨。\n好好保存它，等待物歸原主的一天吧。"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "【保持距離】獲得25黑印"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "【施以憐憫】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74169_Desc = {
    Text = "他們自你的腳下蜂擁而來。\n在他們模糊的苦痛面龐中，你見到自己被拉扯的影子。\n你當真享有審判他們的特權嗎？"
  },
  Event_74169_Name = {
    Text = "噩夢倒影"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "【扔掉碎塊】有特殊造物，感染攜帶刻印：「(EnchantConfig.Arg1)」的-症狀：融蝕之癲狂"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "【補完碎塊】無特殊造物，感染「(Skill.Arg1)」，獲得感染「(Skill.Arg2)」"
  },
  Event_7416_Desc = {
    Text = "蒼白的肢體在你面前緩慢扭動著，她伏下身，將斷裂的手臂伸到你面前，她因疼痛而眯起的雙眼中，溢出死白的石膏淚珠。\n「只差……只差最後一塊，我就可以……」"
  },
  Event_7416_Name = {
    Text = "補完殘軀"
  },
  Event_74170_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74170_Desc = {
    Text = "你要試著拯救它們。\n但不要被它們同化。"
  },
  Event_74170_Name = {
    Text = "噩夢倒影"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "【移開視線】提高 Arg1 點最大生命"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "【保持注視】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染1張「(Skill.Arg2)」"
  },
  Event_74171_Desc = {
    Text = "「終焉已經降臨。」\n你的心臟揪緊，收縮。\n於麗埃特確信的語氣中無疑包含著某些催眠以及心靈感應的力量。\n這個維度的於麗埃特的目的與過去你認識的於麗埃特的有何區別？\n謎團太多，迷障重重。\n你抬眼觀察於麗埃特，卻發現她也凝視著你。"
  },
  Event_74171_Name = {
    Text = "終焉的目視"
  },
  Event_74172_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74172_Desc = {
    Text = "你抬手在虛幻的琴鍵上生澀地敲擊。\n琴鍵叮叮咚咚地交錯響起，每一枚音符都宛如滴落的露珠，清澈而透明，純熟而精湛的演奏技巧並不出自你的指尖。\n恍然間，你見到一雙無形而纖長的大手覆蓋在你的手背，隨著演奏的進展起起落落。\n時間彷彿靜止，直至琴音的最後一尾餘韻。\n你聽見一聲滿足的歎息。"
  },
  Event_74172_Name = {
    Text = "遺憾的奏鳴"
  },
  Event_74173_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74173_Desc = {
    Text = "頻繁轉移的意識並不穩固，你需要排除無意義的干擾。\n你將注意力集中在眼前的詹金身上，留聲機的聲音便逐漸淡化，消散在霧氣中。"
  },
  Event_74173_Name = {
    Text = "鐘樓上的異響"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "【尋找聲源】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74174_ChoiceDesc2 = {
    Text = "【回憶】所有喚醒體回復50狂氣，感染「(Skill.Arg1)」"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "【無視噪音】獲得3選1刻印"
  },
  Event_74174_Desc = {
    Text = "你聽見了留聲機指針畸變的聲音。\n扭曲的指針劃過破損的螺旋槽紋，不緊不慢地發出令人毛骨悚然的顫動。"
  },
  Event_74174_Name = {
    Text = "鐘樓上的異響"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "【為他演奏】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74175_ChoiceDesc2 = {
    Text = "【聆聽琴聲】每有一名狂氣值在50及以上的喚醒體，獲得15黑印"
  },
  Event_74175_ChoiceDesc3 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_74175_Desc = {
    Text = "「親愛的約翰：\n    最近我突然意識到，距離你上次為我們進行鋼琴演奏，已經過去了數年時間。\n    我今年81歲了，年齡越是增長，就越會意識到年輕時回憶的可貴。\n    若你收到這份信，就請你下次經過倫蒂尼恩時，在我的公寓前駐足，前來演奏一曲吧。」"
  },
  Event_74175_Name = {
    Text = "遺憾的奏鳴"
  },
  Event_74176_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74176_Desc = {
    Text = "求生的欲望激蕩在胸腔中，你毫不猶豫地發出指令。\n等待你突出重圍，回身去看時，那顆星辰已經被融蝕漿淹沒。\n在湧動的融蝕漿中，響起一串尖銳的有規律的聲響。\n你觸碰融蝕漿的表面，一顆腐朽的星辰落入你的掌心。"
  },
  Event_74176_Name = {
    Text = "隕落的星"
  },
  Event_74177_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74177_Desc = {
    Text = "你拾起了那顆星辰，它在你的掌心卻失去了光華。\n一陣壓迫感倏忽襲來，一股惡寒令你的脊背發涼。\n生死瞬息之間，你側身閃避，恰躲過一次兇狠的攻擊，但手臂上仍留下了一道兩英寸長的擦痕。"
  },
  Event_74177_Name = {
    Text = "隕落的星"
  },
  Event_74178_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74178_Desc = {
    Text = "觸肢內隱藏的利齒撕開了你的袖口，淅瀝的血漿如殷紅的細流，順著腕骨汩汩滑落。\n你無法分辨莎拉的眼神，但那綻裂的頭顱隱約發出苦痛顫抖的嘶吼。"
  },
  Event_74178_Name = {
    Text = "噩夢重現"
  },
  Event_74179_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74179_Desc = {
    Text = "你環顧四周，左右遊走，聲音像只和你捉迷藏的老鼠，時左時右，忽遠忽近。\n你兜兜轉轉，可聲音愈發嘈雜，金屬刮擦的異響令你陷入愈深的不安。\n你突發奇想，摸了摸自己的口袋，雖然沒有發現聲源，卻拾到一件小小的寶物。"
  },
  Event_74179_Name = {
    Text = "鐘樓上的異響"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "【離開】你失去了(Arg1)點生命，感染「(Skill.Arg2)」"
  },
  Event_7417_Desc = {
    Text = "「乖孩子。不過，還是要給你一點小小的懲罰才行。」\n達芙黛爾的輕笑聲消散在維度裂隙中。"
  },
  Event_7417_Name = {
    Text = "提示時間"
  },
  Event_74180_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74180_Desc = {
    Text = "你移開視線，不與她碰撞。\n然而某種力量仍舊讓你的心臟不安地砰砰跳動。"
  },
  Event_74180_Name = {
    Text = "終焉的目視"
  },
  Event_74181_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74181_Desc = {
    Text = "於麗埃特與你四目相對。\n下一秒，她露出完全癲狂的笑容，彷彿在嘲笑你的狂妄與無知。\n然而那笑容轉瞬即逝，其他人也並未對此做出表態……似乎只是你的幻覺。"
  },
  Event_74181_Name = {
    Text = "終焉的目視"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "【有任務造物1，獲得黃金造物「(RelicConfig.Arg1)」】"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "【有任務造物2，獲得黃金造物「(RelicConfig.Arg1)」】"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "【隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7418_Desc = {
    Text = "事件254（開發中），非最終效果"
  },
  Event_7418_Name = {
    Text = "事件254（開發中）"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "【提交特殊刻印1，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "【提交特殊刻印2，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "【感染「(Skill.Arg1)」以及「(Skill.Arg2)」，獲得黃金造物「(RelicConfig.Arg3)」】"
  },
  Event_7419_Desc = {
    Text = "事件255（開發中），非最終效果"
  },
  Event_7419_Name = {
    Text = "事件255（開發中）"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "【躲開蝴蝶牌】刪除2張卡牌"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "【擁抱蝴蝶】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7420_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_7420_Desc = {
    Text = "一個轉角，又一個轉角，追擊地獄犬的道路彷彿永無盡頭。\n酸痛的腳腕，發脹的大腦，混亂中你又見到了蝴蝶，你知道那是癲狂的妄念，密境的囈語。它們撲棱棱地從四面八方湧出。"
  },
  Event_7420_Name = {
    Text = "妄念噴湧"
  },
  Event_7421_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7421_Desc = {
    Text = "你輕輕按住風鈴。鈴聲輕響數下便陷入沉默。它已然隱退——只會在夢魘裡再度回歸。"
  },
  Event_7421_Name = {Text = "小風鈴"},
  Event_7422_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7422_Desc = {
    Text = "鈴聲輕響數下便陷入沉默。它已然隱退——只會在夢魘裡再度回歸。"
  },
  Event_7422_Name = {Text = "小風鈴"},
  Event_7423_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7423_Desc = {
    Text = "「不錯，你很謹慎。」\n風鈴中忽然傳來遙遠的聲音。\n「謹慎會為你帶來一點小獎勵，但也僅此而已了。」"
  },
  Event_7423_Name = {Text = "小風鈴"},
  Event_74245_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_74245_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「你輸了。不過，作為陪我玩樂的酬勞，你依然可以得到獎勵。」"
  },
  Event_74245_Name = {Text = "N的寄語"},
  Event_74246_ChoiceDesc1 = {
    Text = "【關閉閘門】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_74246_ChoiceDesc2 = {
    Text = "【倉皇遠離】感染「(Skill.Arg1)」，隨機1張指令卡獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_74246_ChoiceDesc3 = {
    Text = "【無視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_74246_Desc = {
    Text = "你深陷這座蒸汽與齒輪構築的迷宮，黃銅管道在頭頂虯結成蛛網，每一次呼吸都攪動粘稠的機油霧氣。\n失控的機械錶盤在牆壁上抽搐，指針劃破刻度時濺出零星火花，如同維多利亞實驗室裡瀕死的螢火蟲。鉚釘接縫滲出銅鏽，像這座鋼鐵巨獸潰爛的傷口，而你的懷錶早已停擺——時間在這裡不過是齒輪咬合的禱文。"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "【賭一把】感染「(Skill.Arg1)」，進入賭局"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "【還是算了】獲得25黑印"
  },
  Event_74247_Desc = {
    Text = "在街角深邃的黑霧中，令人窒息的氣息彌漫開來。\n霧氣中，兩個古老而陰冷的骰子悄然浮現，表面佈滿了無法解讀的符號與詭異的圖案。\n它們靜靜地躺在濕滑的石板上，彷彿在等待著某個不明的召喚。\n「你知道我是誰。要來賭一把嗎？」"
  },
  Event_74247_Name = {Text = "N的寄語"},
  Event_74248_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74248_Desc = {
    Text = "「我夢見一場席捲一切的浩劫，淹沒昔日的光輝。我對生活感到憤怒，更對未來的毫無希望感到無奈。我的心靈被恐懼撕裂，願在這即將崩塌的時刻，你們能警覺，不要讓這可怕的命運降臨。」"
  },
  Event_74248_Name = {
    Text = "遺言囈語"
  },
  Event_74249_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74249_Desc = {
    Text = "黑色的煙霧失落地抖動。\n隨後骰子在一次眨眼後消失不見。\n\n縈繞在你的腦海中的問題僅剩了一個：\n這些骰子到底是由什麼東西構成的？"
  },
  Event_74249_Name = {Text = "N的寄語"},
  Event_7424_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7424_Desc = {
    Text = "你轉過身，看到一雙皮鞋，還有模糊的人形倒影。\n看起來似乎是一位年輕的紳士。\n「無意打擾，請問你見過一雙黑色的牛津皮鞋嗎？」\n「你面前就有一雙。」\n「不，不……這是山羊皮的，不是牛皮的。\n我已經被困在這座蠟館十二年了，一定是鞋子不對的緣故……」\n聲音嘟囔著，漸漸微弱。"
  },
  Event_7424_Name = {Text = "腳步聲"},
  Event_74250_ChoiceDesc1 = {
    Text = "【分辨男人的聲音】從牌庫中隨機獲取3張指令卡選擇1張複製"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "【分辨女人的聲音】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74250_ChoiceDesc3 = {
    Text = "【分辨老人的聲音】獲得25黑印"
  },
  Event_74250_Desc = {
    Text = "你獨自站立在一片黑暗沼澤中。\n朦朧間你聽見混沌交錯的囈語如潮水般湧來，有的來自耄耋之年的老人，有的來自牙牙學語的孩子，有些來自焦慮難耐的女人，有些來自恐懼莫名的男人……"
  },
  Event_74250_Name = {
    Text = "遺言囈語"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "【前進】從牌庫中隨機獲取3張指令卡，選擇1張卡進行刪除，獲得75黑印"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "【歇息】從牌庫中隨機獲取3張指令卡，選擇1張卡的原始複製進入牌庫，獲得25黑印"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "【回望】獲得50黑印"
  },
  Event_74251_Desc = {
    Text = "你行走在無人的街道上，腳步在灰燼上踏出深深的凹痕。\n\n城市的道路如同蛛網，你是被捆縛的飛蛾。"
  },
  Event_74251_Name = {
    Text = "陰霾之都"
  },
  Event_74252_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74252_Desc = {
    Text = "當蒸汽閘門轟然閉合的刹那，你聽見自己的影子正被精密齧合的螺紋一寸寸絞碎。"
  },
  Event_74253_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74253_Desc = {
    Text = "重複的光景接續刷新在眼前，你無路可逃。"
  },
  Event_74254_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74254_Desc = {
    Text = "時間是無用的座標，你期待的唯有真理。"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "【三點】"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "【六點】"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "【一點】"
  },
  Event_74255_Desc = {
    Text = "誰會敢擲下這意味著不幸與瘋狂的骰子？\n你，當然是你。\n你選擇——"
  },
  Event_74255_Name = {Text = "N的寄語"},
  Event_74256_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_74256_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「你輸了。不過，作為陪我玩樂的酬勞，你依然可以得到獎勵。」"
  },
  Event_74256_Name = {Text = "N的寄語"},
  Event_74257_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74257_Desc = {
    Text = "來路是無窮無盡的黑暗和茫茫一片的混沌。\n沒有時間來考慮自己的命運了，你必須削除恐懼，在宣判降臨之前抵達自己的終點。"
  },
  Event_74257_Name = {
    Text = "陰霾之都"
  },
  Event_74258_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74258_Desc = {
    Text = "「當我坐在歲月的陰影中，感受到死亡冷酷的手掌逐漸逼近。窗外的世界變得愈加昏暗，充斥著災難的低語。我畏懼即將到來的審判，對我們愚昧的清算。街道充滿了不祥的氣息，我擔心我們的審判日即將到來。我們的文明搖搖欲墜，彷彿要被毀滅所吞噬，受困於我們自己愚蠢的傲慢。」"
  },
  Event_74258_Name = {
    Text = "遺言囈語"
  },
  Event_74259_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74259_Desc = {
    Text = "死裡逃生已屬不易，你不應苛求更多。\n殘垣斷柱和廢墟的陰影仍在召喚著你。"
  },
  Event_74259_Name = {
    Text = "陰霾之都"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_7425_Desc = {
    Text = "「這樣麼……非常有趣。」\n她收回問卷，向你指了孩子們離開的方向。你匆匆離去，險些沒有聽到身後的低語。\n「期待我們的下次會面。」"
  },
  Event_7425_Name = {
    Text = "心理評估"
  },
  Event_74260_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74260_Desc = {
    Text = "你處在某種巨大的力量或強大的命運的支配之下。\n短暫的歇息不能改變這一現狀，但至少能帶給酸軟的雙腿前進的動力。"
  },
  Event_74260_Name = {
    Text = "陰霾之都"
  },
  Event_74261_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_74261_Desc = {
    Text = "「……城市不再是溫暖的避風港，而是隱秘的墓穴，孕育著恐怖與絕望。那些曾經鮮活的夢想，如今只剩下恐懼的殘片。我無法再假裝無所畏懼，眼前的世界如同一場噩夢，無法醒來。」"
  },
  Event_74261_Name = {
    Text = "遺言囈語"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "【離開】獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_74262_Desc = {
    Text = "骨碌骨碌，骰子在骰盅裡興奮地起舞，舞到筋疲力竭。\n\n「你輸了。不過，作為陪我玩樂的酬勞，你依然可以得到獎勵。」"
  },
  Event_74262_Name = {Text = "N的寄語"},
  Event_7426_ChoiceDesc1 = {
    Text = "【離開】隨機1張指令卡獲得刻印：鏡像"
  },
  Event_7426_Desc = {
    Text = "「沒關係，我已經從你的眼睛裡看見了答案。我還有些雜務需要處理，暫時先退場了。你也一樣有事要處理吧？看那邊，有人來找你了。」\n你回頭，提燈教會的身影出現在道路的盡頭。"
  },
  Event_7426_Name = {
    Text = "怪異旅伴Ⅴ"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "【離開】隨機1張指令卡獲得刻印：籌算"
  },
  Event_7427_Desc = {
    Text = "「看來你還不願對我敞開心扉。我很失望，不過沒關係，我依然會為你提供最親切的提示：提燈教會出現在這裡，究竟是想要尋找什麼呢？」\n「哎呀，看來有人不希望我們閒聊了。看那邊，有人來找你了。」\n你回頭，提燈教眾的身影出現在道路的盡頭。"
  },
  Event_7427_Name = {
    Text = "怪異旅伴Ⅴ"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "【離開】隨機1張指令卡獲得刻印：靈感"
  },
  Event_7428_Desc = {
    Text = "「你很誠實，值得嘉獎。所以，我決定給你一個小小的提示：為什麼你剛來到拉伊小鎮，就被祂盯上了呢？」\n「哎呀，看來有人不希望我們閒聊了。看那邊，有人來找你了。」\n你回頭，提燈教眾的身影出現在道路的盡頭。"
  },
  Event_7428_Name = {
    Text = "怪異旅伴Ⅴ"
  },
  Event_7429_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7429_Desc = {
    Text = "雜亂的聲音漸漸平息，你的手中空空如也，但瞬間的情緒已經被銀鑰記錄下來。"
  },
  Event_7429_Name = {Text = "無之書"},
  Event_7430_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7430_Desc = {
    Text = "你在混亂中伸出手四處亂抓，一片混沌中有什麼觸感奇異的物品落入你的手中，漸漸彙聚成型。"
  },
  Event_7430_Name = {Text = "無之書"},
  Event_7431_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7431_Desc = {
    Text = "「你聽說過蛇的捕獵方式嗎？蛇只能匍匐於地，蜿蜒爬行，所以無法像獵豹那樣發力追逐，也不能像狼群那樣憑包圍獵物。與之相對的，蛇學會了靜靜守候。」\n「他們等待獵物放鬆警惕的時刻，然後發動突襲，一擊將它們吞入腹中。」"
  },
  Event_7431_Name = {
    Text = "怪異旅伴Ⅲ"
  },
  Event_7432_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7432_Desc = {
    Text = "似乎被驚擾了，黑貓油亮的皮毛僅僅在你指尖留下了一絲灼痛，隨即消失在迷霧深處。"
  },
  Event_7432_Name = {
    Text = "夜貓之禍"
  },
  Event_7433_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7433_Desc = {
    Text = "無非是那群愚蠢無稽的瘋狂信徒的荒誕夢囈。"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "【繼續偷聽】獲得3選1刻印"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "【大聲咳嗽】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7434_Desc = {
    Text = "牆角裂開了許多細縫，血管般蜿蜒而出。\n伴隨輕微的嗡鳴聲，你聽到對面傳來男人低沉的聲音。\n「昆丁區5，威靈頓區10，諾曼區15……\n本月素材均已裝貨完畢，準備發車，貨號I-0234……\n……\n另外，託彌薩格那幫人的福，白教堂區目前處於戒嚴狀態，我們丟失了最大的素材來源。」"
  },
  Event_7434_Name = {
    Text = "隔牆有耳"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "【繼續追逐孩子】離開"
  },
  Event_7435_Desc = {
    Text = "在你的驅嚇下，所有烏鴉向四面八方嘩啦啦飛去，撲騰墜落的漆黑羽翼融成黏液，滴落成黑印的模樣。"
  },
  Event_7435_Name = {
    Text = "黑鴉凝視"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "【放棄抵抗】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "【抽回雙手】"
  },
  Event_7436_Desc = {
    Text = "一台新式打字機。\n它有一套與眾不同的字母鍵，就像顯微鏡一樣華麗又精巧。\n你好奇地將手放了上去，卻發現它們不受控制地在鍵盤上下翻飛，速度越來越快，越來越快……"
  },
  Event_7436_Name = {
    Text = "靈感迸發"
  },
  Event_7437_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7437_Desc = {
    Text = "不過是掙扎求生的生靈，求得一塊歇腳的浮木罷了……\n你歎息一聲，任由蝴蝶尾部的黑漿淌至臉頰。"
  },
  Event_7438_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7438_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_7438_Name = {Text = "聯絡點"},
  Event_7439_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7439_Desc = {
    Text = "你接受了來自學校的聯絡請求，熟悉的聲音使你心神安定。你振作精神，繼續向前。"
  },
  Event_7439_Name = {Text = "聯絡點"},
  Event_7440_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7440_Desc = {
    Text = "你的疑惑墜進空氣，無人答覆，暖黃的光線自窗外透入，像回憶一般溫暖。"
  },
  Event_7440_Name = {
    Text = "火山追憶"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "【拾起】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_7441_ChoiceDesc2 = {
    Text = "【猶豫】獲得25黑印"
  },
  Event_7441_Desc = {
    Text = "小巷角落的木桶中，漂浮著某件色彩怪異的物品。異常的出現彷彿在警告你，「請勿觸碰」。"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "【交給她吧】獲得3選1白銀造物"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "【有點情況】獲得白銀造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染兩次「(Skill.Arg3)」"
  },
  Event_7442_Desc = {
    Text = "「這裡是來自彌薩格的通訊，我是艾瑞卡。監測到喚醒體蘿坦的異常諾斯指數波動，請問是否需要支援？」"
  },
  Event_7442_Name = {
    Text = "支援通訊"
  },
  Event_7443_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7443_Desc = {
    Text = "你依從了耳畔不懷好意的勸慰，尖嘯如針尖般扭動著刺入你的耳孔。\n「停下——快停下——我都已經按你說的做了——快停——」\n你痛苦地捂住頭顱，恍惚間聽見了鴉群的嘲弄。"
  },
  Event_7443_Name = {
    Text = "鴉群之歌"
  },
  Event_7444_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7444_Desc = {
    Text = "被放置在這個位置，不外乎兩種可能：被忽視之物，或被珍重之物。如果是後者，那還是留給原主吧。"
  },
  Event_7444_Name = {
    Text = "孤獨銀芯"
  },
  Event_7445_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7445_Desc = {
    Text = "最幸福的，莫過於無知。"
  },
  Event_7445_Name = {Text = "窺視"},
  Event_7446_ChoiceDesc2 = {
    Text = "【生成空白地塊】"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "【生成虛空】"
  },
  Event_7446_Desc = {
    Text = "看看可以生成什麼"
  },
  Event_7446_Name = {
    Text = "【待包裝】"
  },
  Event_7447_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7447_Desc = {
    Text = "「冷靜，」拉蒙娜敲了敲你的腦袋，「只是往昔的碎片。不知道是誰遺落在這條維度通道的。」\n確實，有股懷念的味道。"
  },
  Event_7447_Name = {
    Text = "回憶碎片·威士卡"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "【收集起來】將1個白銀造物升級為黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "【扔掉它們】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7448_ChoiceDesc3 = {
    Text = "【仔細觀察】獲得25黑印"
  },
  Event_7448_Desc = {
    Text = "這裡有許多碎裂的銀芯。\n黯淡、破碎……顯然不是什麼高檔貨。\n或許它們正是這些蠟像能「活過來」的原因之一吧。\n即使是最粗糙的銀芯，也擁有創造奇蹟的可能。"
  },
  Event_7448_Name = {
    Text = "被縛的靈魂"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7449_Desc = {
    Text = "庫姆已經獻出了她能獻出的一切。\n接下來，輪到你讓她的犧牲不是毫無意義了。"
  },
  Event_7449_Name = {Text = "余溫"},
  Event_7450_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7450_Desc = {
    Text = "願風雪賜予你們永恆的寧靜。"
  },
  Event_7450_Name = {
    Text = "前人遺物"
  },
  Event_7451_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7451_Desc = {
    Text = "你仍然顯得頑強，在吟唱中仍能依循自我。\n你不相信耳畔的囈語，所仰賴之物只有人類的理性。\n不過……賴以維生的堅實地面，被粘稠的黑漿籠罩的那一天，挖出眼球作為窺伺之物，將是你彌留之際的唯一選擇。"
  },
  Event_7451_Name = {
    Text = "鴉群之歌"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7452_Desc = {
    Text = "庫姆被你猛然扯開，堪堪躲過一擊。她朝你點了點頭以示感激，再次朝著實驗體衝了過去。"
  },
  Event_7452_Name = {Text = "鬥獸場"},
  Event_7453_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7453_Desc = {
    Text = "叮叮噹當……\n硬幣墜入錢包，發出清脆悅耳的迴響。\n錢包滿足地咀嚼著，最後打了一個飽嗝。\n它折服於你的大方，對你卸下全部的心防。\n現在，它將為你所用。"
  },
  Event_7453_Name = {
    Text = "貪吃錢包"
  },
  Event_7454_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7454_Desc = {
    Text = "黃銅硬幣如同墜入不見底的深淵，一點聲音都沒發出。\n你耐心等待了五分鐘。錢包發出痛苦的呻吟，最後吐出一灘漆黑的粘液。\n這是它無聲的抗議。"
  },
  Event_7454_Name = {
    Text = "貪吃錢包"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "【看向遠處】"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "【細細聆聽】"
  },
  Event_7455_Desc = {
    Text = "希萊斯特搖動了手中羅盤，她並沒有說話，身邊卻隱隱響起了歌謠。\n水手的歌謠跨越了時間在此交織重合，一曲混亂卻有力的船歌指引著你，讓你看向船的另一頭。"
  },
  Event_7456_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7456_Desc = {
    Text = "你上前打斷了這場小小的授課練習。\n從彈琴的手勢到基礎樂理，你毫不留情一一點評。\n樂音驟停，男孩和老師齊刷刷看向你，臉上掛著同樣詭譎的微笑。\n133，355，244……\n琴聲再度響起，依舊錯得離譜。\n原來他們什麼都聽不見。"
  },
  Event_7456_Name = {Text = "鋼琴課"},
  Event_7457_Desc = {
    Text = "在密境中發現的黑色印記，可向融痕獻祭以換取造物等精神投影。離開當前區域後很快會消散為黑色泥漿。"
  },
  Event_7458_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7458_Desc = {
    Text = "眼下還是找到那個神秘人更重要。拉蒙娜這麼想著，快步離開。"
  },
  Event_7459_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7459_Desc = {
    Text = "放縱意識，循著禱言的來路向深海沉沒。\n你看見了沉於水底的黃金之國，看見了不朽的石雕，最終與幽暗之處那閃爍的眼眸對視……\n「未流淌神血之人……離開，離開。」"
  },
  Event_7459_Name = {
    Text = "夢境禱文"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "【離開】選擇1個詛咒造物，感染「(Skill.Arg1)」"
  },
  Event_7460_Desc = {
    Text = "拉蒙娜一劍刺穿了實驗體的喉嚨，庫姆將已然失去生命體征的實驗體甩開，奔向下一個目標。"
  },
  Event_7460_Name = {Text = "鬥獸場"},
  Event_7461_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7461_Desc = {
    Text = "烏鴉撕咬著自己的羽毛，就如人類啃噬自己的身體一樣。\n在這個恐懼的世界裡，此事屢見不鮮，你救不了所有生靈。"
  },
  Event_7461_Name = {
    Text = "融漿之淚"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "【安撫庫姆】"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "【幫庫姆呼喊】"
  },
  Event_7462_Desc = {
    Text = "巨大的怪獸朝著小小的人竭力地嘶吼著，想要喚醒往日的夥伴。但被摧殘過的聲帶只震出低沉怪異的喉音。"
  },
  Event_7462_Name = {
    Text = "友情的呼喚"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "【離開】尋找探照燈"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "【闖入霧氣】失去 Arg2 點生命"
  },
  Event_7463_Desc = {
    Text = "前方是一片濃厚的黑色霧氣，貿然進入將招致災厄。\n或許你應該找到「探照燈」驅散霧氣。"
  },
  Event_7464_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7464_Desc = {
    Text = "「像你一樣哢吱作響的上頜骨？這輩子從未見過。」\n你拒絕了頜骨先生的無禮請求。頜骨先生失望極了，但勉強保持住了風度。\n為了感謝你的耐心傾聽，他送了你一點小禮物。"
  },
  Event_7464_Name = {
    Text = "哢吱作響"
  },
  Event_7465_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7465_Desc = {
    Text = "你答應了這個奇異的請求，並帶上了這位頜骨先生。\n它躺在你的口袋裡，一刻不停地哢吱作響。根據同伴的翻譯，它的發言大致包含感激、懷舊以及悔恨。\n至於他為何會變成這副模樣？頜骨先生不願多談，只說：\n「你知道的。當你凝望@2時，@2也會回望你。」"
  },
  Event_7465_Name = {
    Text = "哢吱作響"
  },
  Event_7466_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7466_Desc = {
    Text = "祂像一段絲綢般滑入了你的提包，隨著輕微的重量增加，你彷彿聽到了一聲輕微的道謝。\n此後再無聲響。"
  },
  Event_7466_Name = {
    Text = "混沌之靈"
  },
  Event_7467_ChoiceDesc1 = {
    Text = "【前進】"
  },
  Event_7467_Desc = {
    Text = "哢嚓。\n你將鑰匙插入鎖孔，輕輕把門推開。\n整個開門的過程都無比順利，讓你對接下來的調查又有了信心。"
  },
  Event_7467_Name = {
    Text = "銹蝕門扉"
  },
  Event_7468_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7468_Desc = {
    Text = "那個聲音沉沉地笑了，你腳下的液體泛起漣漪。\n「你很快就會明白，除了死亡，沒有什麼是一定要做的。」"
  },
  Event_7468_Name = {
    Text = "你不會想要找到"
  },
  Event_7469_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7469_Desc = {
    Text = "你丟掉了這塊記憶，將自己的意識從虛幻的撫慰中抽離。"
  },
  Event_7469_Name = {
    Text = "沉湎舊日"
  },
  Event_7470_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7470_Desc = {
    Text = "只是淺睡片刻罷了，若無撫慰，你要如何度過這漫漫長夜呢……"
  },
  Event_7470_Name = {
    Text = "沉湎舊日"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "【拾起照片】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7471_Desc = {
    Text = "這是一組群像照。\n萎靡不振的人們蹲在鐵柵欄後方，滿臉困苦。\n其中一張照片吸引了你的注意。那應當是個瘦弱的年輕女性，臉部一片空白。\n那無比褻瀆的贅生物，正一圈圈纏繞在她的身體周圍。\n你看不見她臉，但在你的想像裡，她應該是沒有表情的。"
  },
  Event_7471_Name = {
    Text = "如實記錄"
  },
  Event_7472_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7472_Desc = {
    Text = "那是鳥的殘骸。"
  },
  Event_7472_Name = {
    Text = "躁亂鴉群"
  },
  Event_7473_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7473_Desc = {
    Text = "你冷酷地拒絕了鋼琴師的請求。\n鋼琴師失望極了。他將另一隻耳朵也撕了下來，將它們全部扔出窗外。\n「反正我也用不著它們。」\n憂鬱的鋼琴師哭喪著臉，低頭敲下一連串哀傷的音符。"
  },
  Event_7473_Name = {
    Text = "側耳傾聽"
  },
  Event_7474_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7474_Desc = {
    Text = "混沌之靈的哭泣愈發尖銳，直到最後變為了刺耳的尖叫，響徹周身。\n祂帶著你的供奉和無法脫身的悲苦，再次沉入泥潭。"
  },
  Event_7474_Name = {
    Text = "混沌之靈"
  },
  Event_7475_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7475_Desc = {
    Text = "這是一個單向通道，你無法通過它回到入口。"
  },
  Event_7476_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7476_Desc = {
    Text = "「那麼，請合上雙眼，靜心感受它來臨的腳步聲吧。」\n你依言閉眼，霎時間，詭異的野獸喘息聲在耳側轟鳴。\n驚魂未定地睜開眼時，剛才的男人已經消失不見。"
  },
  Event_7476_Name = {
    Text = "怪異旅伴Ⅰ"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7477_Desc = {
    Text = "「那可真是太遺憾了。」\n男人聲音低落，扶了扶眼鏡。\n「不過，既然你們沒聽說過它，又為何要深夜來此呢？」\n不等你們回應，男人側身離開了。"
  },
  Event_7477_Name = {
    Text = "怪異旅伴Ⅰ"
  },
  Event_7478_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7478_Desc = {
    Text = "你邁著堅定的步伐，繼續前進。\n一步、兩步、三步……\n身後的腳步聲隱入黑暗。\n你們還會相遇的。"
  },
  Event_7479_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7479_Desc = {
    Text = "你半躬起身子，將一旁桌上的託盤舉在手中，搖身一變成了公主的侍衛。\n至於誰成了那位幸運的公主——自然是你最忠實的搭檔了。\n「敢把茶杯倒在我臉上，下個月的課堂筆記就別指望了。」\n這是公主對你發出的警告。"
  },
  Event_7479_Name = {
    Text = "以假亂真"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "【靜靜聽著】隨機提升1張卡牌的刻印品質"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "【她就是】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7480_Desc = {
    Text = "莎拉的嘶吼在你的腦海中迴蕩，一個有些熟悉的細微聲音不知從何而來，它微弱地呢喃著「莎莎姐姐」，「莎莎姐姐」。\n「莎莎姐姐，你在哪裡？」"
  },
  Event_7481_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7481_Desc = {
    Text = "「……我竟然覺得你說的有一絲道理，但渴望可不能幫你解決融蝕體。還是幹點實際的吧。」"
  },
  Event_7481_Name = {
    Text = "羅格斯定則"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "【獲得100黑印】"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "【隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7482_Desc = {
    Text = "造物由穩定的靈知凝滯而成，或許，它們能換來和諧的曲調。"
  },
  Event_7482_Name = {
    Text = "不協和音"
  },
  Event_7483_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7483_Desc = {
    Text = "「是進入過這個維度的某個人的記憶碎片，」拉蒙娜回應道，「穿行在維度中很容易遇見這種情況。小心不要和自己的記憶混淆。」"
  },
  Event_7483_Name = {
    Text = "回憶碎片·威士卡"
  },
  Event_7484_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7484_Desc = {
    Text = "跟隨心跳的韻律，追尋閃光。你們不會分開，正如沒人能精准地區分日與夜。"
  },
  Event_7485_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7485_Desc = {
    Text = "你不斷撫摸這些焦躁不安的手，試圖讓它們安靜下來。\n不一會兒，你的世界便徹底清淨了。\n愛總是能獲得回報。"
  },
  Event_7485_Name = {
    Text = "黯色沼澤"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "【掙扎】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」】"
  },
  Event_7486_ChoiceDesc2 = {
    Text = "【放棄】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_7486_ChoiceDesc3 = {
    Text = "【警惕】獲得25黑印"
  },
  Event_7486_Desc = {
    Text = "你的腦中湧入了濁物，那樣污穢的異物感分外清晰。\n那渾濁的、散發著惡臭的積液滲漏並佔據了你的全部思緒，痛苦爬滿了充斥著恐懼的側臉，你陷入無窮無盡的噩夢輪回，難以掙脫。"
  },
  Event_7486_Name = {
    Text = "顱中瘡孔"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "【是孟菲斯儀式鏡】"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "【是定向羅盤】"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "【我沒有掉東西】"
  },
  Event_7487_Desc = {
    Text = "「跨越維度的先行者啊。」\n\n耳畔傳來蒼老的聲音，似來自史前，似穿越萬古。\n\n在極度緊張中，你聽見那個聲音問出了一個有些耳熟的問題。\n\n「你掉的，這個圓圓的，能讓你在回合開始抽牌的東西是什麼呢？」"
  },
  Event_7488_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7488_Desc = {
    Text = "「我這裡又不是廢品回收站，」朵爾嘟囔著收下，「算了，多少還能提取點有用的。」"
  },
  Event_7488_Name = {Text = "銘牌"},
  Event_7489_ChoiceDesc1 = {
    Text = "隨機普通刻印"
  },
  Event_7490_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7490_Desc = {
    Text = "你閱讀著斑駁殘破的紙張，「雙生」、「浸潤」、「獻祭」、「無效」……\n依然是支離破碎的概念和難以解讀的行文，唯有發脹的大腦能證明你曾經閱讀過這一頁廢紙。"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "【您願意付出怎樣的代價呢？】隨機提升1張卡牌的刻印品質"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "【請他們喝一杯過期的血腥瑪麗吧】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7491_Desc = {
    Text = "「歡迎光臨，我珍貴的客人。盡情挑選吧，這滿目琳琅皆為等候你而存在。」\n「額，打擾了，請問您是……達芙黛爾女士的孿生姐妹嗎？」\n「我即是達芙黛爾本人，請問客人您今日到此，有何貴幹……？」\n「抱歉抱歉，您比之前更有風韻了，我竟沒認出。您還記得嗎？二十年前，您替我的酒吧趕走了一個怪胎……昨天，噩夢重現了，它佔領了酒吧，帶著它的同胞們，成群結隊地……」"
  },
  Event_7491_Name = {
    Text = "回憶碎片·舊夢重現"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "【繼續追逐孩子】離開"
  },
  Event_7492_Desc = {
    Text = "第二隻烏鴉離開了，祂的尾羽在撲騰間露出了一抹白，恍若白骨。"
  },
  Event_7492_Name = {
    Text = "黑鴉凝視"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "【賭一把】感染「(Skill.Arg1)」，進入賭局"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "【還是算了】獲得25黑印"
  },
  Event_7493_Desc = {
    Text = "「來賭一把吧？猜猜我們的點數！只要一點點的代價！」\n被丟棄的骰子們發出聒噪的嗡鳴聲，彷彿在對你說話。\n「投我！投我！」\n「唯一一把！最後一把！」\n好吧，就一把——\n你拿起一個籌碼。你決定——"
  },
  Event_7493_Name = {
    Text = "無止境的賭局"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "【抵抗惡念】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7494_ChoiceDesc2 = {
    Text = "【擁抱惡念】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7494_ChoiceDesc3 = {
    Text = "【清醒離開】獲得25黑印"
  },
  Event_7494_Desc = {
    Text = "惡念成為了利刃，又彷彿是尖銳的牙。\n祂們撕咬著在密境中漸弱的理智，吞噬著殘存的意志，一如現實對你所施的惡行一般……"
  },
  Event_7494_Name = {
    Text = "無妄之念"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "【全力掙扎】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "【點燃蛛網】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "【安靜等待】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7495_Desc = {
    Text = "細密的絲線如蛛網般纏繞著你，此刻，你赫然成為了密境的獵物。"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "【收件人：自己】刪除1張卡牌"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "【收件人：老師】獲得25黑印"
  },
  Event_7496_Desc = {
    Text = "祂給了密境行者一個機會：一個向未知連通的機會。\n幾張殘破的紙，一台逸散著油墨的打字機，與一個未知的、單向的收件人。\n意志或許能決定你的資訊能傳達向何方……"
  },
  Event_7496_Name = {
    Text = "單向傾訴"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "【欣然應允】"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "【斷然回絕】"
  },
  Event_7497_Desc = {
    Text = "空空蕩蕩的環境中迴蕩著私語。\n「噢，就是那個傻子，念叨著要麼死要麼贏的知名賭徒，廢人一個，你可離他遠點。」\n身形頹喪瘦削的虛影向你拋來幾枚硬幣，金屬撞擊的脆響漏進你掌心。\n「來一局。」"
  },
  Event_7497_Name = {
    Text = "馳名的賭徒"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "【我們一切平安】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7498_ChoiceDesc2 = {
    Text = "【你是誰？】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7498_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7498_Desc = {
    Text = "打字機突兀地噴出油墨，上面的驚歎號多得刺目。\n「朵爾你還好嗎？？？為什麼守密人消失了你也消失了！！！拜託平安的話回個消息！！！再等下去威廉的頭髮都要掉完了！！！」"
  },
  Event_7498_Name = {
    Text = "緊急通訊"
  },
  Event_7499_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7499_Desc = {
    Text = "你將最後一塊石膏補上，她爆發出一陣尖刻的笑聲，一陣黑氣纏繞而上，她漂浮的身影消散在你的視野中。"
  },
  Event_7499_Name = {
    Text = "補完殘軀"
  },
  Event_7500_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7500_Desc = {
    Text = "你掏出了銀鑰匙，哀戚虔誠地將它握在手心，薄霧般的微光包裹住你。\n一片寂靜中，只餘喟歎。"
  },
  Event_7501_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7501_Desc = {
    Text = "殘留的目光仍在注視著你，你皮膚下的血肉細胞正瘋狂叫囂和逃逸，血管在皮膚下蠕動如蟲豸。\n你感到一陣流淌著的力量，在肢體詭譎的異狀中迸發。"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "【迴避目光】隨機覺醒1名喚醒體"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "【直視目光】選擇覺醒1名喚醒體，並降低其覺醒卡算力消耗2點。感染「(Skill.Arg1)」"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7502_Desc = {
    Text = "維度隧道連結著萬千宇宙，在至高的通道上，無數雙眼睛瞪視著潛行的你們。"
  },
  Event_7502_Name = {
    Text = "祂的注視"
  },
  Event_7503_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7503_Desc = {
    Text = "太亂了，太亂了。\n所有想法在瞬間被思維長河卷走，被洪流裹挾著流向遠方。\n在大腦的窪地中，只留下數不盡的迷茫與苦痛共同沉淪。"
  },
  Event_7503_Name = {
    Text = "靈感迸發"
  },
  Event_7504_Desc = {
    Text = "過飽和的融蝕漿中似乎蘊藏著某些物質…用銀鑰匙觀測，將它轉化為自身的力量吧。"
  },
  Event_7504_Name = {Text = "析出點"},
  Event_7505_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "【繼續追逐孩子】離開"
  },
  Event_7505_Desc = {
    Text = "一隻烏鴉離開了，一根漆黑的羽毛緩緩飄落。"
  },
  Event_7505_Name = {
    Text = "黑鴉凝視"
  },
  Event_7506_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7506_Desc = {
    Text = "這裡是深淵的血戰之地，戰鬥不僅需要勇氣，更需要智慧。\n\n擦亮你的眼睛，觀察你的對手，你不需要打到他們全部，你只需要打到他們的領袖！"
  },
  Event_7506_Name = {
    Text = "修羅試煉"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "【接通】回復Arg2點生命。"
  },
  Event_7507_Desc = {
    Text = "你在迷霧中探索，突然，胸前的校徽放出微弱的銀光。是誰在通訊器的那頭呼喚你？"
  },
  Event_7507_Name = {Text = "聯絡點"},
  Event_7508_ChoiceDesc1 = {
    Text = "【尾隨他】"
  },
  Event_7508_Desc = {
    Text = "嗒。嗒。嗒。\n白色的身影在濃霧中緩步前行，像帆船駛向寂靜的黑夜。\n從背影來看，似乎是個男孩。\n你傾聽著他倦怠的腳步聲，在心中下了一個決定。"
  },
  Event_7508_Name = {
    Text = "終幕禮Ⅰ"
  },
  Event_7509_Desc = {
    Text = "融蝕體哀嚎著倒下，你驚訝地發現克萊門汀站在其後。\n「我是來道別的，」面對你的質問，她不予回答，「為了表達對你的感謝，我可以告訴你一些線索。不過……那將需要你的信任。\n讓我催眠你，你就能知道我知道的一切。」\n你能相信她嗎？\n「小心，」拉蒙娜警告道，「她不可能別無所圖。」"
  },
  Event_7509_Name = {
    Text = "催眠療法"
  },
  Event_7510_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7510_Desc = {
    Text = "你集中精神，幻象如水墨一般散去。你繼續向前，卻無法徹底清除心頭的陰霾。"
  },
  Event_7511_ChoiceDesc1 = {
    Text = "【可憐的生物？】"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "【進化的人類？】"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "【你究竟是誰？】"
  },
  Event_7511_Desc = {
    Text = "你們第六次見到的男人，站在鋼架的高處，俯瞰著大地。獵獵的風卷起他的長髮，露出蛇的真容。\n他的視線聚焦在你們身上，片刻後又拋向遠方的黑暗。\n「啊，這是怎樣可憐的生物啊。\n被背叛的感覺，一定像<Bold:進化>的人類一樣甘美吧。」"
  },
  Event_7511_Name = {
    Text = "怪異旅伴Ⅵ"
  },
  Event_7512_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7512_Desc = {
    Text = "誰會在地獄犬的凝視下關注一卷膠片？"
  },
  Event_7512_Name = {
    Text = "記憶光影"
  },
  Event_7513_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7513_Desc = {
    Text = "不去看，不去討論，不去聽，甚至不要去想——聰明人的選擇。"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "【離開】刪除2張卡牌"
  },
  Event_7514_Desc = {
    Text = "在周圍嘈雜的聲音之中，你依稀聽到了奇異的振翅聲。銀鑰匙在你胸口猛然振動，你被某種力量驅使著仰頭，看到空中出現的巨大黑洞。\n「可惜，可惜，不過沒關係。我們還會再次相見，我尊敬的無目之眼。」"
  },
  Event_7514_Name = {
    Text = "催眠療法"
  },
  Event_7515_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7515_Desc = {
    Text = "你可以忽視周圍的一切，卻無法忽略心臟的跳動。它加快了鼓動頻率，催促著你，也埋怨著你。"
  },
  Event_7516_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7516_Desc = {
    Text = "「那就好！！！威廉學長的頭髮保住了！！！」\n雖然只是文字資訊，電報上的內容卻讓你幻聽了那種聲嘶力竭的咆哮。"
  },
  Event_7516_Name = {
    Text = "緊急通訊"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "【告訴他真相】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "【隱瞞真相】獲得3選1刻印"
  },
  Event_7517_Desc = {
    Text = "「請救救我。」\n憂鬱的旅人抓住你的手。他已在這裡徘徊了數百年。\n「我是一名士兵，奉命前往遙遠的東方征伐異教徒。\n我穿過密林，淌過河流，卻迷失了方向，一次又一次地回到同樣的地方。\n有什麼東西在黑暗中看著我。我看不見，但我知道。它一直看著我。\n現在我只想回家……」\n你望向它背後漂浮不定的殘影。它們先是模糊，隨後逐漸清晰——那是一個張開的大嘴，正亟待享用已經醃制百年的迷失魂靈。"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "【道別】"
  },
  Event_7518_Desc = {
    Text = "「希萊斯特，你會幫我這一次的吧。」\n女孩躊躇不安地原地踱步，不時回頭看向安靜的喚醒體。\n她沒有回應女孩，在女孩神情越發焦急時，微風卷起白紗，輕輕地將女孩推向了某個方向。\n「我會庇佑你。」\n我會庇佑你，即便在「庇佑」一事上，我曾失職過一次。\n但這次，我不會讓你一個人迷失在黑暗中。"
  },
  Event_7518_Name = {
    Text = "航船聖女的庇佑"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "【離開】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7519_Desc = {
    Text = "那些歌聲有的古老，古老到在洪水蔓延前就已失傳；也有的很新穎，唱著上一個新年，妻子在倫蒂尼恩百貨買的新手套……情緒重合的混亂過後，留下的是一片心中的空洞。"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "【驅逐色彩】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7520_ChoiceDesc2 = {
    Text = "【擁抱色彩】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "【轉身離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7520_Desc = {
    Text = "墨菲跟在身後寸步不離，卻在路過某個拐角時僵在原地。\n流動的溢彩在眼前翻滾，將空氣卷出了歎息的聲音。\n「墨@1……」\n是身陷索納尼爾號囹圄的溺者幽魂嗎？還是追隨生者而來的往生親朋？"
  },
  Event_7520_Name = {
    Text = "懷念的色彩"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7521_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7521_Desc = {
    Text = "耳邊傳來了熟悉的話語，親切而令人安心，想要循聲尋找時，聲音卻戛然而止。"
  },
  Event_7521_Name = {
    Text = "異常聯絡"
  },
  Event_7522_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7522_Desc = {
    Text = "「那是一段褻瀆的樂聲。」\n你捂著耳孔裡流出的血水，這樣確信道。"
  },
  Event_7523_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7523_Desc = {
    Text = "那色彩隱約扭曲成兩個人類的形狀，但祂們只在那個角落佇立不動，用目光為你們送上最後的祝福。"
  },
  Event_7523_Name = {
    Text = "懷念的色彩"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "【聆聽】獲得3選1黃金造物"
  },
  Event_7524_Desc = {
    Text = "達芙黛爾的聲音停頓了片刻。\n「哦呀，你選擇了這個嗎？不錯的選擇，作為獎勵，我會特別送你一個禮物。」"
  },
  Event_7524_Name = {
    Text = "提示時間"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "【堅持詢問】感染「(Skill.Arg1)」"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "【放棄詢問】選擇1張卡牌刪除"
  },
  Event_7525_Desc = {
    Text = "「嗯，聰明的選擇。大敵當前，肯定會想要知己知彼？不過，知曉太多關於維度的秘密可是會干擾神志的哦？」"
  },
  Event_7525_Name = {
    Text = "提示時間"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "【堅持詢問】激怒達芙黛爾，進入戰鬥"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "【放棄詢問】承受一些小小的懲罰"
  },
  Event_7526_Desc = {
    Text = "「哦？這種時候你還惦記著追蹤我嗎？小傢伙，太貪心可不好哦？」"
  },
  Event_7526_Name = {
    Text = "提示時間"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "【定睛細看】提高 Arg1 點最大生命"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "【無視】隨機2張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染2張「(Skill.Arg2)」"
  },
  Event_7527_Desc = {
    Text = "你們追著地獄犬的身影，在小鎮的道路上奔行。\n天空中開始飄落冰冷的雪花，溫柔地落在臉頰，落在胸口，撫慰你那躁動不安的內心。"
  },
  Event_7528_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7528_Desc = {
    Text = "你揮舞雙臂，試圖驅散這些惱人的烏鴉。\n它們發出嘎嘎的笑聲，似乎是在嘲諷你的愚蠢和弱小。\n不管怎麼說，你的勇氣依舊打動了它們，你獲得了應有的獎勵。"
  },
  Event_7528_Name = {
    Text = "群鴉之歌"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "【關於莉莉】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "【關於地獄犬】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7529_Desc = {
    Text = "穿越無盡之門扉，從遙遠得無法觸及之地，傳來了達芙黛爾的聲音。\n「這裡是達芙黛爾的提示時間。」"
  },
  Event_7529_Name = {
    Text = "提示時間"
  },
  Event_7530_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7530_Desc = {
    Text = "你仍然顯得頑強，在吟唱中仍能依循自我。\n你不相信耳畔的囈語，所仰賴之物只有人類的理性。\n不過……賴以維生的堅實地面，被粘稠的黑漿籠罩的那一天，挖出眼球作為窺伺之物，將是你彌留之際的唯一選擇。"
  },
  Event_7530_Name = {
    Text = "群鴉之歌"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "【直視地獄犬來源】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7531_ChoiceDesc2 = {
    Text = "【專注戰鬥】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7531_Desc = {
    Text = "地獄犬的輪廓變化著。\n他的身軀連接著牆壁的罅隙，透露出詭麗的幻象。"
  },
  Event_7531_Name = {
    Text = "來自角度"
  },
  Event_7532_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7532_Desc = {
    Text = "「喵，喵喵，喵喵喵……」\n你捏著嗓子，竭力使自己顯得柔弱無害。\n「喵！喵喵！喵喵喵！」\n貓群似乎接受了你的善意，回以嘹亮的呼喊。你們的叫聲此起彼伏，晝夜不歇，月亮都被嚇得躲進雲裡。"
  },
  Event_7532_Name = {Text = "貓之城"},
  Event_7533_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7533_Desc = {
    Text = "不過是掙扎求生的生靈，求得一塊歇腳的浮木罷了……\n你歎息一聲，任由蝴蝶尾部的黑漿淌至臉頰。"
  },
  Event_7534_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7534_Desc = {
    Text = "你使出了吃奶的力氣，直到離貓群遠遠的。\n待回望時，貓咪們早已各自回位。梳毛的、打盹的、還有互相打架的……\n說實話，它們不關心人類。"
  },
  Event_7534_Name = {Text = "貓之城"},
  Event_7535_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7535_Desc = {
    Text = "你將手中剩余的肉塊丟進貓群。\n群貓如黑色的潮水湧上前。它們發瘋般撕咬肉塊，又迅速一哄而散。\n很不幸，這是一塊過期肉。能填飽乾癟的肚皮，卻不怎麼叫人痛快。"
  },
  Event_7535_Name = {Text = "貓之城"},
  Event_7536_ChoiceDesc1 = {
    Text = "【直視眼睛】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7536_ChoiceDesc2 = {
    Text = "【放棄抵抗】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7536_Desc = {
    Text = "無數眼睛環繞在你耳邊低語。\n「我們旅行，我們停下，我們大步流星走過了數萬年甚至更長時間。\n當太陽在凝望中逐漸暗淡，當舊地球的生命被洪水湮沒。\n我們早已被宇宙的奧秘深深吸引。」"
  },
  Event_7537_ChoiceDesc1 = {
    Text = "【感到惶恐】隨機覺醒1名喚醒體"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "【感到滿足】選擇覺醒1名喚醒體，並降低其覺醒卡算力消耗2點。感染「(Skill.Arg1)」"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7537_Desc = {
    Text = "你見過一個沒有月亮和群星的天空，空中高懸的是無數顆放大的瞳仁。\n彷彿你一伸手，就能將它們擰下，濺得血肉橫飛。\n可你張開五指，觸及之地空無一物。\n命運的眼睛一眨不眨地注視著你，祂們從混沌的宇宙中，撿到了一粒晶瑩的沙礫。"
  },
  Event_7537_Name = {
    Text = "穹頂之瞳"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "【放下捂耳的雙手】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "【繼續捂住耳朵】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7538_Desc = {
    Text = "尖嘯，毫無盡頭的尖嘯——\n烏鴉歌者披著黑亮的皮毛，尖喙上泛著冷硬的寒光，嘹亮的悲鳴一次次劃破你的耳膜。\n放下你捂耳的手吧！\n夜間縱情引吭的鴉群，要暢飲你蜷縮之軀內，那未經淬煉的戰慄。"
  },
  Event_7538_Name = {
    Text = "鴉群之歌"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "【學貓叫】獲得50黑印"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "【投餵食物】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7539_Desc = {
    Text = "你誤入了黑貓的地盤。\n無數眼睛在黑暗中倏然睜開，帶著探究、審視、戒備……唯獨沒有善意。\n祖母綠、琥珀黃、孔雀藍……\n你彷彿置身一片閃耀的寶石之海。\n為了脫身，你——"
  },
  Event_7539_Name = {Text = "貓之城"},
  Event_7540_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7540_Desc = {
    Text = "你注意到一隻與眾不同的手。它細嫩、白皙，從始至終都表現得很平靜。\n更重要的是——你認出來了，那是你自己的手。\n你當機立斷，將它狠狠擰斷。\n耳畔傳來無數刺耳的尖嘯，沼澤終於消失了。"
  },
  Event_7540_Name = {
    Text = "黯色沼澤"
  },
  Event_7541_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7541_Desc = {
    Text = "「明智的決定。」兩手空空的人影說，「已經被驗證的選擇有著既定的結局，未知的行為則會導向新的未來。」\n細微的希望將你溫柔籠罩。人影消散，你扶著心口，不知剛才的究竟是投影，還是精神在重壓下產生的幻覺。"
  },
  Event_7541_Name = {
    Text = "分岔的小徑"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "【表揚它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "【嘲諷它】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_7542_Desc = {
    Text = "腦子說：鎖鏈困住了我的前腦、我的腦幹，我的大腦皮層，卻無法束縛100多億個追求真理的小小細胞。\n你說：誰把你困在這裡的？你的身體呢？\n腦子說：身體？快別說笑了。過去它們都叫我「賣豬肉的老強尼」。\n有身體的時候，我連十以內的加減法都算不明白。\n可當館長為我剔除冗余的肉身後，瞧瞧我變成什麼樣了！一位物理學家，哲學家，以及業餘詩人。"
  },
  Event_7542_Name = {
    Text = "哲學之腦"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "【證明哥德巴赫猜想】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "【旅程的終點】隨機1張卡牌獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "【拒絕提問】獲得50黑印"
  },
  Event_7543_Desc = {
    Text = "撿起通靈板時，年輕女性的聲音衝進了你的大腦。\n「向我提問吧，我無所不知。」\n「從我的回答中，你能得到命運的贈禮。」"
  },
  Event_7543_Name = {Text = "通靈板"},
  Event_7544_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7544_Desc = {
    Text = "你閱讀著斑駁殘破的紙張，支離破碎的句子從你口中流出，「先祖」、「聖子」、「永恆的死亡」、「漫長的記憶」等名詞沖刷著腦海，刺激著你本就因夢魘而變得敏感脆弱的神經。"
  },
  Event_7545_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7545_Desc = {
    Text = "黑泥滴落在你臉上，泛起了一陣麻癢。\n你無法忍受，伸手將蝴蝶拍開。\n蝴蝶躲過你不懷好意的動作，無聲無息地消失在盡頭。"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "【離開】尋找探照燈"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "【闖入霧氣】失去 Arg2 點生命"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "【直接進入】"
  },
  Event_7546_Desc = {
    Text = "前方是一片濃厚的黑色霧氣，貿然進入將招致災厄。\n或許你應該找到「探照燈」驅散霧氣。"
  },
  Event_7547_ChoiceDesc1 = {
    Text = "【接受幻覺】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7547_ChoiceDesc2 = {
    Text = "【否認幻覺】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7547_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7547_Desc = {
    Text = "厚重黑暗的鐵架橋下，蘆葦叢生的寂靜河灘上，忽然飛出一隻閃光的蝴蝶。\n蝴蝶輕盈地落在你的掌心，糟糕的嚎叫聲停息了，取而代之的是搬運鋼筋的工人整齊的號子聲，釘頭錘的敲打聲，鉚釘碰撞的清脆金屬聲……"
  },
  Event_7547_Name = {
    Text = "鋼橋的幻覺"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "【驅趕烏鴉】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "【繼續追逐孩子】獲得25黑印，離開"
  },
  Event_7548_Desc = {
    Text = "一隻烏鴉佇立在吊燈。\n兩隻烏鴉佇立在吊燈。\n三隻烏鴉佇立在吊燈。\n……\n那些漆黑的生物扭曲脖頸，站在巷口的吊燈上，用包含惡意的眼神俯視著你。那重影般的頭顱，似乎共用著同一個浸沒在融蝕漿中的身體。"
  },
  Event_7548_Name = {
    Text = "黑鴉凝視"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "【離開】覺醒喚醒體數量少於3名時，獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "【離開】已覺醒喚醒體數量至少擁有3名時，獲得黃金造物「(RelicConfig.Arg1)」"
  },
  Event_7549_Desc = {
    Text = "你沒有理會這道痕跡，邁步向前。\n<Italic:覺醒的靈知何其沉重>，痕跡隨著你的步子愈發擴大、愈發蜿蜒，似乎隨時能從裂口中伸出一隻手，將你拖入深處。"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "【回應目光】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7550_ChoiceDesc2 = {
    Text = "【躲開目光】 隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7550_Desc = {
    Text = "你能感覺到一股視線，一個超脫維度、遠高於密境的目光正在注視，注視著你，也注視著你面前的女孩。\n你的呼吸開始急促，理智深處，原始的恐懼開始尖叫。"
  },
  Event_7550_Name = {
    Text = "誰的目光"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "【繼續尋找】提升 Arg1 點生命，感染「(Skill.Arg2)」"
  },
  Event_7551_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7551_Desc = {
    Text = "隱約的光芒出現在眼前，明亮而溫暖，想要循光而去時，它卻忽地消失了。"
  },
  Event_7551_Name = {
    Text = "異常聯絡"
  },
  Event_7552_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7552_Desc = {
    Text = "輕聲附和著祂們的吟唱，溫暖的水流為你送來了歸鄉的祝福。"
  },
  Event_7552_Name = {
    Text = "海洋歌謠"
  },
  Event_7553_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7553_Desc = {
    Text = "你在前方發現了隱約的光亮，你終於穿出了這片令人窒息的濃霧"
  },
  Event_7553_Name = {
    Text = "混沌迷霧"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "【解開下方的枝節】"
  },
  Event_7554_Desc = {
    Text = "殘留密境的靈知互相勾連，糾纏出一片不穩定的力場。\n或許，你能解開纏繞的靈，為自己梳理出前進的道路。"
  },
  Event_7554_Name = {
    Text = "糾纏之路"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "【解開上方的枝節】"
  },
  Event_7555_Desc = {
    Text = "殘留密境的靈知互相勾連，糾纏出一片不穩定的力場。\n或許，你能解開纏繞的靈，為自己梳理出前進的道路。"
  },
  Event_7555_Name = {
    Text = "糾纏之路"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "【解開左側的枝節】"
  },
  Event_7556_Desc = {
    Text = "殘留密境的靈知互相勾連，糾纏出一片不穩定的力場。\n或許，你能解開纏繞的靈，為自己梳理出前進的道路。"
  },
  Event_7556_Name = {
    Text = "糾纏之路"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "【解開左側的枝節】"
  },
  Event_7557_Desc = {
    Text = "殘留密境的靈知互相勾連，糾纏出一片不穩定的力場。\n或許，你能解開纏繞的靈，為自己梳理出前進的道路。"
  },
  Event_7557_Name = {
    Text = "糾纏之路"
  },
  Event_7558_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7558_Desc = {
    Text = "你們還面臨數場惡戰，現在可不是悠哉調查的時候。"
  },
  Event_7558_Name = {
    Text = "器官登記"
  },
  Event_7559_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7559_Desc = {
    Text = "紙張上的字元忽然變得完整而鮮活，令人驚駭的言辭足以撼動一切無意識的痛苦者的信念和根基。你越讀越迷茫，越讀越恐懼，止不住用指尖抓撓自己的頭皮。\n突然之間，那些充滿詛咒的符號消失了。拉蒙娜打斷了你的閱讀，然後強行將書頁塞進了手提箱中。"
  },
  Event_7560_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7560_Desc = {
    Text = "歡喜，憂愁，悲傷，苦悶……這些都是你的情感。\n你，和無數身處維度外的其他世界的各種各樣的你。"
  },
  Event_7561_ChoiceDesc1 = {
    Text = "【靜靜聽著】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7561_ChoiceDesc2 = {
    Text = "【她在這兒】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7561_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7561_Desc = {
    Text = "怪物的哀鳴在你的腦海中迴蕩，不成人形的黑色黏液中，一個聲音微弱地呢喃著「莎莎姐姐」，「莎莎姐姐」。\n「莎莎姐姐，你在哪裡？」"
  },
  Event_7562_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7562_Desc = {
    Text = "「加入他，加入他們，加入我們。\n成為祂的守護者，成為祂的代行者。\n以祂的夢境作為你前進的方向……」\n混亂的禱言攪動著你的意識，那些聲音消失後，你才驚覺自己早已滿頭大汗。"
  },
  Event_7562_Name = {
    Text = "夢境禱文"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "【沒聽說過】"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "【聽說過】"
  },
  Event_7563_Desc = {
    Text = "「這位同學，能佔用你一點時間嗎？\n我希望能耽誤你們幾分鐘，向你們介紹一下本地的鄉野傳說。\n你們聽說過一種叫做『刻耳柏洛斯』的生物嗎？」"
  },
  Event_7563_Name = {
    Text = "怪異旅伴Ⅰ"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "【放棄思考】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7564_ChoiceDesc2 = {
    Text = "【追上靈感】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7564_Desc = {
    Text = "港口遇襲，有來無回的神秘貨輪和有鰭的「新朋友」……這是精心籌備的陷阱嗎？還是又一場意外頻發的旅行？\n現實與理智互相拉扯糾纏，無數的靈感與念頭從腦海噴湧而出。"
  },
  Event_7564_Name = {
    Text = "靈感迸發"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "【艾爾沃斯的火山？】提升 Arg1 點最大生命"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "【努力回憶】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7565_Desc = {
    Text = "莉莉的兩頰，落下黑色的淚水。「我們見過的，媽媽，」她輕聲呢喃，「在艾爾沃斯的火山……」"
  },
  Event_7565_Name = {
    Text = "火山追憶"
  },
  Event_7566_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7566_Desc = {
    Text = "「蹈@1…海……」\n符文在眼前若隱若現，你控制不住地向虛空伸手，想要抓住它們——\n「愣著幹嘛！他們可要追上來了！」\n神秘少女拽著你往甲板另一頭跑去，打斷了你與符文的交流。\n但確實有什麼力量，在你指尖留下了痕跡。"
  },
  Event_7567_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7567_Desc = {
    Text = "你對神神叨叨的囈語毫無興趣，更不想冒著癲狂的風險走入暗夜。"
  },
  Event_7568_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7568_Desc = {
    Text = "無論如何，守密人的職責在你胸口膨脹，你不能放棄尋到寄件人的希望，即使它是如此模糊不清、晦暗不明。"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "【觀察它】可以獲得25黑印"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "【撫摸它】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_7569_Desc = {
    Text = "小巷中突然躥出一隻黑貓，異常親熱地纏繞在你們的腳邊，幽綠的豎瞳閃爍著令人不寒而慄的光芒，彷彿在說「別追了，陪我玩一會兒吧。」\n 「你已經看見祂了，祂就在你的身側，那些被瘋狂污染的，狂熱的影子……不要直視祂的輪廓。」"
  },
  Event_7569_Name = {
    Text = "夜色精靈"
  },
  Event_7570_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7570_Desc = {
    Text = "「不可能，我不相信！」聲音尖叫起來，「這個把我送給惡魔的女人，才不是我的莎莎姐姐！」"
  },
  Event_7571_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7571_Desc = {
    Text = "「收到，我們將進行基礎物資輸送，請注意查收。」"
  },
  Event_7571_Name = {
    Text = "支援通訊"
  },
  Event_7572_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7572_Desc = {
    Text = "已是無用之物。"
  },
  Event_7572_Name = {
    Text = "前人遺物"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "【仔細看看】獲得3選1刻印"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "【撕下海報】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7573_Desc = {
    Text = "一個蠟像館內隨處可見的燭臺。\n借著病態的橙光，你發現牆壁上張貼著一則手繪的海報。"
  },
  Event_7573_Name = {
    Text = "黑暗中的笑聲"
  },
  Event_7574_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7574_Desc = {
    Text = "「莉莉有她自己的心，不需要聽從任何人。」你不卑不亢地作答。\n弗朗西斯冷哼一聲，沒有回應。"
  },
  Event_7574_Name = {
    Text = "她的選擇"
  },
  Event_7575_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7575_Desc = {
    Text = "這是一組群像照。\n萎靡不振的人們蹲在鐵柵欄後方，滿臉困苦。\n其中一張照片吸引了你的注意。那應當是個瘦弱的年輕女性，臉部一片空白。\n那無比褻瀆的贅生物，正一圈圈纏繞在她的身體周圍。\n你看不見她臉，但在你的想像裡，她應該是沒有表情的。"
  },
  Event_7575_Name = {
    Text = "如實記錄"
  },
  Event_7576_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7576_Desc = {
    Text = "你痴迷地凝望著這些閃耀的首飾，一時不察，已經握住了乾瘦的黑色黏液之手。\n而它只是略微握緊了手，隨後放開。\n什麼都沒有發生，只有一縷黑氣，順著你的指尖滑入衣袖。"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "【彈幾個音】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7577_ChoiceDesc2 = {
    Text = "【將蓋子蓋上】獲得3選1刻印"
  },
  Event_7577_Desc = {
    Text = "牆邊的鋼琴敞著蓋子。它有著泛黃的琴鍵和露出木色的開裂的邊緣，但每一個琴鍵都被擦拭得非常乾淨。\n它是那麼多人的快樂源泉。"
  },
  Event_7578_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7578_Desc = {
    Text = "持矛者悶哼一聲，像一個飽受欺負的孩子似地嗚咽著。\n聲音轉瞬即逝，連帶另外兩個蹈海者也不見蹤影……原來只是密境映照出的一段幻象。"
  },
  Event_7578_Name = {
    Text = "窮追不舍"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7579_Desc = {
    Text = "「正確的回答。」\n聲音的主人對這個回答十分滿意，一個閃閃發光的物件被甩出水面。\n「記住，一切都有代價。」"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "【驅散幻象】感染症狀。"
  },
  Event_7580_ChoiceDesc2 = {
    Text = "【離開】"
  },
  Event_7580_Desc = {
    Text = "模糊的面孔突然出現，它們圍繞在你周圍，用不存在的聲帶絕望地呻吟。"
  },
  Event_7581_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7581_Desc = {
    Text = "你沒有理會這道痕跡，邁步向前。\n卻像被激怒了一般，痕跡隨著你的步子愈發擴大、愈發蜿蜒，似乎隨時能從裂口中伸出一隻手，將你拖入深處。"
  },
  Event_7582_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7582_Desc = {
    Text = "你並不會輕易上當，乾脆俐落地轉身，離開了這裡。"
  },
  Event_7583_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7583_Desc = {
    Text = "你意識到裂痕的不同尋常，蹲下察看，奇怪的是，方才還在蔓延的裂痕，卻如同突然死亡一樣，陷入了永恆的寂靜。"
  },
  Event_7584_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7584_Desc = {
    Text = "「不，是清醒的頭腦。決心可沒法幫你解決融蝕體，守密人，好好思考對策吧。」"
  },
  Event_7584_Name = {
    Text = "羅格斯定則"
  },
  Event_7585_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7585_Desc = {
    Text = "你無力抵抗內心的衝動。\n手指像迷失在樹林裡的孩童，在鍵盤上遊蕩、嬉戲……\n漸漸地，有蝴蝶從打字機中飛了出來。\n一隻、兩隻、三隻……\n臉上、手指上，成群的蝴蝶像是空中綻放的煙花，在黑暗中閃動著寶石般的光芒。\n這台打字機沒有任何實際功用，但它對創造美卻很在行。"
  },
  Event_7586_ChoiceDesc1 = {
    Text = "【拴好母雞】"
  },
  Event_7586_Desc = {
    Text = "拉伊特產，活蹦亂跳的母雞，美食的誘惑。"
  },
  Event_7586_Name = {
    Text = "製作陷阱"
  },
  Event_7587_Desc = {
    Text = "廉價但好用的陷阱！"
  },
  Event_7587_Name = {
    Text = "製作陷阱"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "【放置捕獸夾】"
  },
  Event_7588_Desc = {
    Text = "金屬製的捕獸夾，懶惰獵人的好幫手。"
  },
  Event_7588_Name = {
    Text = "製作陷阱"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "【查看電報機】感染「(Skill.Arg1)」，獲得黃金造物「(RelicConfig.Arg2)」"
  },
  Event_7589_ChoiceDesc2 = {
    Text = "【無視】獲得50黑印"
  },
  Event_7589_Desc = {
    Text = "你躲進狹長的山洞裂隙，暫避風雪。但你深知自己無法在這裡停滯太久，若是那群黑袍的怪人找到此處，你將無路可逃。\n在狹縫的角落裡，你居然發現了一台電報機。"
  },
  Event_7589_Name = {
    Text = "無聲電報"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "【檢查膠片】隨機升級2張卡牌的刻印效果"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "【檢查相機】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7590_Desc = {
    Text = "像拉出一截內臟般，相機肚子裡的膠片被扯得稀爛，開膛破肚地丟棄在這裡，無人問津。\n一道刺目的白光閃過，遺棄在街角的相機歪斜著，快門被憑空按動。\n「哢擦——」\n你那錯愕的、愣怔的神情，被忠實記載於相機中的膠捲上。"
  },
  Event_7590_Name = {
    Text = "記錄無罪"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "【掐住歌者的喉嚨】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7591_ChoiceDesc2 = {
    Text = "【絆倒舞者的步伐】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "【奪走詩人的稿紙】獲得50黑印"
  },
  Event_7591_Desc = {
    Text = "你被三個粘稠的人影擋住去路。\n一個人影唱著歌，聲音嘶啞，歌詞詭異，你捂住耳朵，繞開了它。\n一個人影跳著舞，動作僵硬，步伐猶疑，你閉上眼睛，躲開了它。\n一個人影吟著詩，韻律破碎，語句不通，你忍無可忍，於是——"
  },
  Event_7591_Name = {
    Text = "狹路上的惡徒"
  },
  Event_7592_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7592_Desc = {
    Text = "「不！人類的進步靠的不是歷史，也不是科技，而是老鼠。」\n「是老鼠開啟了那個黑暗的時代，隨後人類才迎來複興的曙光。」\n「人類需要你們——雖然不是每個人都理解這一點。」\n老鼠們被你的長篇大論說得有些迷糊，不過還是放你離開了。"
  },
  Event_7593_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7593_Desc = {
    Text = "你忍住視神經的抽搐，勉強辨識著……\n那裡似乎繪製著一個已經撕裂的正圓形法陣。\n法陣內部由無數的弧線構成，似是靜態又像在流動，令人目眩神迷。"
  },
  Event_7593_Name = {
    Text = "來自角度"
  },
  Event_7594_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7594_Desc = {
    Text = "<Bold>羅傑斯蠟像館\n南華克街44號，倫蒂尼恩市@2區\n參觀時間：21：00-6：00\n3：00停止入場（週末閉館）\n\n<Bold>當前展覽\n弗拉基米爾·@2：\n微笑的哲學"
  },
  Event_7594_Name = {
    Text = "黑暗中的笑聲"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "【對視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7595_ChoiceDesc2 = {
    Text = "【閉眼】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "【背對】獲得25黑印"
  },
  Event_7595_Desc = {
    Text = "本不該看見星空的。\n在索納尼爾號的密境中，天幕流轉華光，星月身形皆隱。\n在昏暗的船艙中，你也不該看見星空的。\n這裡只該有零星的白熾燈和老燈籠——可為什麼，你還是感受到了高懸天際的目光？"
  },
  Event_7595_Name = {Text = "窺視"},
  Event_7596_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7596_Desc = {
    Text = "你選擇勇敢地直視眼睛。\n它們是璀璨的繁星，在黑暗中閃閃發光。\n隨後它們笑了起來，又變成無數個彎彎的月亮。\n眼睛說：「你不懼怕目光。你也不應當懼怕……好久不見，@2」\n消失前，它們送給你一件小小的禮物，作為「重逢的紀念」。"
  },
  Event_7597_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7597_Desc = {
    Text = "鐵路橋，倫蒂尼恩的血管與神經，連接城市的心臟與四肢，只要太陽還沒有從此處落下，倫蒂尼恩的心臟就將永遠激昂搏動。"
  },
  Event_7597_Name = {
    Text = "鋼橋的幻覺"
  },
  Event_7598_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7598_Desc = {
    Text = "一首無比華麗的賦格曲，作曲者不詳。\n無數聲部帶著相近的主題交織湧出，每個音符就像外科醫生的手術刀一般精准、冷酷。\n精確而華麗——這就是羅傑斯的美學。\nFuga，飛翔吧！"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "【出聲問好】"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "【尋求幫助】"
  },
  Event_7599_Desc = {
    Text = "手扶上船舷的瞬間，你看見了一個白裙少女。\n高貴、聖潔、虛幻……和幾分眼熟。\n究竟是在什麼地方見過她呢？你正艱難地挖掘著混亂的記憶，她卻突然意識到你的存在一般，隔著虛空與你對視。\n她的眼睛平靜如初春的海洋，你卻奇異地從中讀出了什麼……\n她似乎在等待你向她問好，哪怕只是談論今天的天氣。"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "【表揚它】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "【嘲諷它】感染「(Skill.Arg1)」，再次隨機刻印"
  },
  Event_7600_Desc = {
    Text = "詹金說：強尼！你和以前還真是……大不相同，不管從哪方面來看。\n你說：你真是一個既勤奮又有追求的腦子。\n腦子扭捏了蠕動了幾下，顯然非常高興。\n腦子說：來吧！既然你們如此認可我現在的成就，那我將授予你們我的畢生所學……"
  },
  Event_7600_Name = {
    Text = "哲學之腦"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "【華麗的賦格】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7601_ChoiceDesc2 = {
    Text = "【簡單的小夜曲】所有喚醒體回復50狂氣，感染「(Skill.Arg1)」"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "【毫無意義的噪音】獲得3選1刻印"
  },
  Event_7601_Desc = {
    Text = "「我個人不太贊同館長的音樂品味，你懂的......\n那太花哨了，而我是個腳踏實地的人。」\n嘎吱轉動的留聲機裡傳來疲憊的男聲，孤苦伶仃地控訴著。\n「但這是我的工作......好了，咱們節約時間，選一張吧。」"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "【有特殊造物，獲得黃金造物「(RelicConfig.Arg1)」】"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7602_Desc = {
    Text = "事件253（開發中），非最終效果"
  },
  Event_7602_Name = {
    Text = "事件253（開發中）"
  },
  Event_7603_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7603_Desc = {
    Text = "你以最快的速度奔離現場。\n現在你們正面臨有史以來最難纏、最噁心的怪物——那些密密麻麻的蠟像們。\n和它們比起來，這幾個簡陋的泥坯著實有點不夠看的。\n凡事分清輕重緩急——這是守密人應當恪守的原則之一。"
  },
  Event_7603_Name = {Text = "習作"},
  Event_7604_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7604_Desc = {
    Text = "銀鑰閃爍，白銀輝光填滿空間，將濃稠流動的彩色染成純淨的銀。\n光芒須臾即逝，只有風留下了哀婉的慟哭。"
  },
  Event_7604_Name = {
    Text = "懷念的色彩"
  },
  Event_7605_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7605_Desc = {
    Text = "那虹彩令你目眩神迷，不知不覺中，你陶醉其中……"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "【繼續墜落】感染「(Skill.Arg1)」，是否繼續下墜"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "【抽身離開】獲得25黑印"
  },
  Event_7606_Desc = {
    Text = "「你」邀請著你。\n在螺旋的深處，過去與未來的「你」向你送上來了來自不同維度的「贈禮」。"
  },
  Event_7606_Name = {
    Text = "螺旋深淵"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "【了然於心】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7607_ChoiceDesc2 = {
    Text = "【一無所知】獲得3選1黃金造物，感染「(Skill.Arg1)」"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "【離開】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_7607_Desc = {
    Text = "兩個銀白的發光人影浮現在你的眼前，呈現出濃稠的液態，漂浮在空氣中。\n「這裡正是我所消亡的地方。」一個人影蹲了下來。\n「無病無災的神國裡，沒有所謂渴望和失去，你並不真的知曉——如何才算是消亡。」\n另一個人影歎息道，將視線轉向了你。"
  },
  Event_7607_Name = {
    Text = "亡佚神國"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "【離開】尋找探照燈"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "【闖入霧氣】感染「(Skill.Arg2)」"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "【直接進入】"
  },
  Event_7608_Desc = {
    Text = "前方是一片濃厚的黑色霧氣，貿然進入將招致災厄。\n或許你應該找到「探照燈」驅散霧氣。"
  },
  Event_7609_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7609_Desc = {
    Text = "「那是記憶的投影，」拉蒙娜向你解釋道，「可能屬於某個人，也可能是幾個人的共同回憶。」\n寶貴的回憶，值得小心看管。"
  },
  Event_7609_Name = {
    Text = "我們的回憶"
  },
  Event_7610_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7610_Desc = {
    Text = "就算現在無法解讀，你也沒有放棄，而是將它耐心疊好塞進口袋，等返校後尋求另外的方法讀取資訊。\n只是，隨著信件詭異地憑空皺縮，你的胸口也開始隱隱作痛。"
  },
  Event_7610_Name = {
    Text = "塗字信件"
  },
  Event_7611_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7611_Desc = {
    Text = "蠟燭離開天平的瞬間就自動點燃，它流下乳白的淚水，迅速從你的指縫間滴落，消失不見。"
  },
  Event_7611_Name = {
    Text = "理智與情感"
  },
  Event_7612_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7612_Desc = {
    Text = "你一把將紙抽了出來、打字機卻仍在運轉。它將一張卡牌捲入、在上面糊滿了油墨。\n你仔細辨認、上面好像反覆寫著「不要直視不要直視不要直視不要直視不要直視」。"
  },
  Event_7612_Name = {
    Text = "不請自來的警告"
  },
  Event_7613_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7613_Desc = {
    Text = "手指觸碰到足以令骨髓凍結的冰冷杯沿時，你忽然打了個激靈，清醒了過來。\n不管怎麼說，它都不適宜被擱置在路邊。還是將它收納進手提箱吧。"
  },
  Event_7614_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7614_Desc = {
    Text = "你狠狠咳嗽。\n聲音似乎嚇了一跳，隨後陷入死寂。\n你感到自己似乎錯過了一條重要的線索……\n但人生總是充滿錯過與遺憾，不是麼？"
  },
  Event_7614_Name = {
    Text = "隔牆有耳"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "【守口如瓶】獲得25黑印"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "【伸手觸碰】50%機會獲得50黑印，50%機會一無所有"
  },
  Event_7615_Desc = {
    Text = "「我要說的只有一句箴言——沒有人能殺死一隻貓！」\n「那該死的黑貓本該被開膛破肚、曝屍荒野，它卻刨開了我的家族墓穴，殘存的人類腐肉被它吞吃殆盡，屍骨肢體則七零八落地散落。」\n「陰冷幽暗的豎瞳注視下，暗黃的膿液浮起一層惡臭，我連滾帶爬地逃離了那裡，被噩夢折磨得精神萎靡。」\n「等等……你們要做什麼，我沒有瘋！我沒有！你們一定是想掩蓋什麼！這是真的——」\n這的確是真的，目送癲狂之人的黑影消散，你和腳邊安靜蹲坐的黑貓對視一眼。"
  },
  Event_7615_Name = {
    Text = "夜貓之禍"
  },
  Event_7616_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7616_Desc = {
    Text = "在你猶豫間，它下沉著溶入融蝕痕，很快消失不見。"
  },
  Event_7617_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7617_Desc = {
    Text = "你厭煩地將信紙揉成團，扔在了腳邊。"
  },
  Event_7617_Name = {
    Text = "塗字信件"
  },
  Event_7618_ChoiceDesc1 = {
    Text = "【確定】"
  },
  Event_7618_Desc = {
    Text = "你集中精神，幻象如水墨一般散去。你繼續向前，卻無法徹底清除心頭的陰霾。"
  },
  Event_7619_ChoiceDesc1 = {
    Text = "【謹慎查看】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7619_ChoiceDesc2 = {
    Text = "【避讓人影】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7619_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_7619_Desc = {
    Text = "拉蒙娜的神經緊繃，小心地在瘋人院中避開人群移動。\n她躲進一個狹小的房間。\n窗外突然映出人影。"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "【離開】獲得50黑印"
  },
  Event_7620_Desc = {
    Text = "現在更重要的事是將造成這一切的罪魁禍首繩之以法。但憤怒的種子依然在你的心中生根發芽。不等你們回應，男人側身離開了。"
  },
  Event_7620_Name = {
    Text = "巨獸足印"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "【離開】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7621_Desc = {
    Text = "自幼在彌薩格接受的教育讓你無法對這個拓印坐視不理。你伸手拂去了灰塵腳印，在那個瞬間，你似乎聽到了來自遙遠維度的回應，「謝謝」。"
  },
  Event_7621_Name = {
    Text = "巨獸足印"
  },
  Event_7622_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7622_Desc = {
    Text = "你握緊銀鑰匙，柔和的銀光和微弱的振動讓你感到一陣安心。目光似乎消失了，又似乎沒有，不論如何，它在你身上留下了屬於它的無形痕跡。"
  },
  Event_7622_Name = {
    Text = "誰的目光"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "【尋找暗道】"
  },
  Event_7623_Desc = {
    Text = "你和拉蒙娜、蘿坦兵分三路，開始追擊地獄犬。\n\n你疾跑過幾條小巷，龐大的身軀出現在你面前。\n它見你追來，立刻拐入下一個轉角。\n你拔腿追上，面前出現的卻是一條死路，三面高牆圍堵出狹窄的方形天空。"
  },
  Event_7624_ChoiceDesc1 = {
    Text = "【走過】"
  },
  Event_7624_ChoiceDesc2 = {
    Text = "【撫摸】"
  },
  Event_7624_Desc = {
    Text = "潔淨柔軟的手術床旁，躺著庫姆已經癱軟的軀體。\n她依然很高大，像一座小山，像你初見時那樣。\n只是，跟高空中的真正的「地獄犬」相比，她又是那麼小，小到像是一個孩子。"
  },
  Event_7624_Name = {Text = "余溫"},
  Event_7625_ChoiceDesc1 = {
    Text = "【獲得銀芯】"
  },
  Event_7625_Desc = {
    Text = "咦，前面似乎有很多亮晶晶的東西！\n聞一聞……香香的。\n舔一舔……冰冰涼涼！\n看起來是很珍貴的東西，快收起來交給小詹金，說不定能換好多乳酪吱！"
  },
  Event_7626_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7626_Desc = {
    Text = "一陣不屬於你的失望在你心頭漫起，虛幻的網緩緩消散，讓出了一條通路。"
  },
  Event_7626_Name = {
    Text = "迷走網路"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "【領悟它】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "【無視它】獲得3選1刻印"
  },
  Event_7627_Desc = {
    Text = "流動的符文從魚形生命的的咆哮中湧出，它們填滿了你的耳道，你的鼻腔，你的喉管。它們燒灼著你的身體，只需下一個十秒，你就能領會咆哮中的深意……"
  },
  Event_7628_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7628_Desc = {
    Text = "你咬牙嘗試著抵禦那迷亂的幻覺。拉蒙娜將某件冰冷的物件置於你的掌心。\n「我剛才發現的造物，或許能幫上你。」"
  },
  Event_7628_Name = {
    Text = "維度幻象"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "選擇高級刻印"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "【摁住烏鴉】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7630_ChoiceDesc2 = {
    Text = "【殺死烏鴉】獲得3選1刻印"
  },
  Event_7630_ChoiceDesc3 = {
    Text = "【離開】"
  },
  Event_7630_Desc = {
    Text = "孤單的烏鴉啞著嗓子，將自己漆黑的羽毛一根根拔下。\n它疼得直顫，尖聲高呼，卻止不住自己越來越快的動作。\n「嘎——嘎——」\n它眼裡流出伴著黑漿的藍色淚水，除了你，無人目睹。\n"
  },
  Event_7630_Name = {
    Text = "融漿之淚"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "【離開】提升 Arg1 點最大生命"
  },
  Event_7631_Desc = {
    Text = "「交給我來吧，」你在怪獸的脊骨上摸了摸，像是安撫一隻發怒的小貓，「她一定會醒過來的，我們不會傷害她。」"
  },
  Event_7631_Name = {
    Text = "友情的呼喚"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "【離開】提升 Arg1 點最大生命，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7632_Desc = {
    Text = "「醒一醒，莉莉，庫姆也希望你早點醒過來——」"
  },
  Event_7632_Name = {
    Text = "友情的呼喚"
  },
  Event_7633_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_7633_Desc = {
    Text = "已是無用之物。"
  },
  Event_7633_Name = {
    Text = "無聲電報"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "選擇一名喚醒體，通過生命儀式將其轉化為「蟲族」。「蟲族」的指令卡算力消耗-1，但打出後消耗。"
  },
  Event_79429_Desc = {
    Text = "「認知自我的過程中，總是伴隨著痛苦，蛻變和新生也是如此。」\n她溫柔地笑著，憐愛地撫摸你的面龐。\n「不用害怕，我就在這裡陪著你，所以敞開你的靈與一切，接受它們。」\n「乖孩子，我等著你的新生，等著你……成為我們的一員。」"
  },
  Event_79429_Name = {
    Text = "生命的蛻變"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "【離開】獲得白銀造物3選1，感染「(Skill.Arg1)」"
  },
  Event_80463_Desc = {
    Text = "你選定道路，拉著小威廉拼命狂奔。\n所幸，你的選擇是正確的。\n那些精神污染，那些一模一樣的克萊門汀，終於被你甩脫。\n當然，你付出了一些代價。"
  },
  Event_80463_Name = {
    Text = "「克萊門汀」們"
  },
  Event_80464_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80464_Desc = {
    Text = "一段超出認知的記憶被灌輸進你的大腦，直接將你的理智擊潰。\n在那猶如超速快進的畫面裡，你只記住了一個場景：三角形的神殿\n那是@2蟲族為了偉大癡愚的@4而建的偉業。"
  },
  Event_80464_Name = {
    Text = "深度記憶"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "【離開】選擇覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_80465_Desc = {
    Text = "你選定道路，拉著小威廉拼命狂奔。\n所幸，你的選擇是正確的。\n那些精神污染，那些一模一樣的克萊門汀，終於被你甩脫。\n當然，你付出了一些代價。"
  },
  Event_80465_Name = {
    Text = "「克萊門汀」們"
  },
  Event_80466_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80466_Desc = {
    Text = "「哢噠。哢噠。哢噠」\n「工作」終於完成了，然而除了「工作」本身，你又得到了什麼？"
  },
  Event_80466_Name = {
    Text = "無盡的折磨"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_80467_Desc = {
    Text = "「很高興聽到你的真心回答。」\n「期待我們的，下次會面。」"
  },
  Event_80467_Name = {
    Text = "迷夢中的呼喚"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "【離開】獲得25黑印"
  },
  Event_80468_Desc = {
    Text = "「哎呀，真是個不誠實的孩子。」\n「不過沒關係，下次，我會讓你說出真心話的。」\n「所有的，嘔自內心和靈魂的，真話。」"
  },
  Event_80468_Name = {
    Text = "迷夢中的呼喚"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "【開始「工作」】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "【後退遠離】"
  },
  Event_80469_Desc = {
    Text = "「哢噠。」\n打字機的聲音響起，在「工作」完成前，你永遠是它的奴隸。"
  },
  Event_80469_Name = {
    Text = "無盡的折磨"
  },
  Event_80470_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80470_Desc = {
    Text = "「真是可惜，你的謹慎讓你錯失了知道真相的唯一機會。」\n它歎息著，無聲潰散。"
  },
  Event_80470_Name = {
    Text = "深度記憶"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "【全力進攻】"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "【且戰且退】"
  },
  Event_80471_Desc = {
    Text = "意料之外的身影出現在你面前，是克萊門汀。\n「不必驚訝，我只是想要做一個特殊的測試。」\n「至於測試什麼，是秘密。」克萊門汀微笑著，「對於你來說，測試的唯一內容——」\n「就是活下去。」"
  },
  Event_80471_Name = {
    Text = "特殊測試"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "【回憶過去】"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "【拔掉蟲鱗】"
  },
  Event_80472_Desc = {
    Text = "「請你相信，我沒有惡意，我只是想要幫助你。」\n克萊門汀追趕著你，大聲呼喊。\n她的聲音聽起來無比真誠，然而你已經無法再相信什麼。\n你的道德已被「具身認知理論」擊穿，理智也即將崩潰。\n你必須、必須做些什麼，抵抗血肉中生長的蟲鱗，抵抗逐漸滲入靈魂的瘋狂與絕望。"
  },
  Event_80472_Name = {
    Text = "掙扎的靈魂"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "【離開】刪除2張卡牌"
  },
  Event_80473_Desc = {
    Text = "「想要保留力量應對最後的決戰嗎？」\n「很聰明的選擇。但是人在獲得同時，其實也在失去。」\n「因為在這個燃燒的殘酷世界，生存本身，就需要付出代價。」"
  },
  Event_80473_Name = {
    Text = "特殊測試"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "【無視它】獲得3選1刻印"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "【碰觸它】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80474_Desc = {
    Text = "類似孢子的奇怪東西引起了你的注意。\n它猶如血肉組成的纖細水母，又似大腦深處寄存著信號的神經纖維。\n「來碰觸我吧。」它無聲誘惑著你，「我會，向你展示一段殘酷的記憶。」"
  },
  Event_80474_Name = {
    Text = "深度記憶"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "【離開】獲得3選1刻印"
  },
  Event_80475_Desc = {
    Text = "「拉蒙娜、朵爾、蘿坦、奧吉爾……」\n你神經質地不斷重複呢喃著這些名字。\n你崩潰的理智已經無法再想起他們的模樣，但這姓名代表的存在，依舊能夠溫暖你的心扉與靈魂。\n他們存在過，他們歡笑過，他們……是你此刻維持住人性的底線與錨點。"
  },
  Event_80475_Name = {
    Text = "掙扎的靈魂"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "【離開】獲得3選1白銀造物，感染「(Skill.Arg1)」"
  },
  Event_80476_Desc = {
    Text = "「啊啊啊啊——」\n你張開嘴，高喊出聲，聲音與其說是嘶喊，不如說是在嘶鳴。\n那被拔掉的蟲鱗又重新生長，而崩潰的理智，一去不回。"
  },
  Event_80476_Name = {
    Text = "掙扎的靈魂"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "【離開】獲得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80477_Desc = {
    Text = "你沒有任何隱瞞，全力以赴。這幅姿態顯然愉悅了克萊門汀。\n「真是個好孩子」。\n「這樣的話，就稍微獎勵你一下吧。當然，是有代價的。」\n「在這個燃燒的殘酷世界，生存本身，就需要付出代價。」"
  },
  Event_80477_Name = {
    Text = "特殊測試"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "【開始「工作」】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "【後退遠離】"
  },
  Event_80478_Desc = {
    Text = "「哢噠。哢噠。」\n打字機的聲音響起，在「工作」進行時，你只是完成「工作」的工具。"
  },
  Event_80478_Name = {
    Text = "無盡的折磨"
  },
  Event_80479_Desc = {
    Text = "熟悉的身影緊緊追隨在你身後，不是一個兩個，而是數十數百個。\n狹小的走廊難以承載如此多數量的「克萊門汀」，因此，有「克萊門汀」被推搡在地，有「克萊門汀」被踩踏成泥。\n但她們統一呼喚著你，重複著那句讓你陷入精神污染的語句。\n「為什麼要逃跑？我只是想給你做一場心理諮詢而已。」\n而你，於療養院的廊道狂奔，面臨岔路的抉擇。"
  },
  Event_80479_Name = {
    Text = "「克萊門汀」們"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "【開始「工作」】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "【後退遠離】"
  },
  Event_80480_Desc = {
    Text = "「修改！工作！不要停下！」\n無數嗡鳴迴響在你耳邊，令你不由自主靠近那台突然出現的打字機。\n「怎麼辦，怎麼辦，明明從早敲到晚，但工作卻怎麼也做不完。」\n「修改！修改！修改方案、提出需求、完成工作！」\n「工作！工作！！工作！！！」\n嗡鳴著的靈魂撞向不停敲擊的打字機，終於，那打字機終於停下了。\n然而片刻後，那打字機又再次運轉\n「修改！工作！不要停下！」\n因為工作，永無盡頭。"
  },
  Event_80480_Name = {
    Text = "無盡的折磨"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "【如實回答】"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "【拒絕回答】"
  },
  Event_80481_Desc = {
    Text = "刹那間，面前的景色變得迷蒙虛幻。\n你以為是房間在扭曲變換，但後來，你才明白，那是你的視神經遭到了入侵。\n「我們又見面了。」\n模糊的視線裡，克萊門汀笑得溫柔。\n「雖然比想像中更早見面，但我仍舊很開心，不知%player%你是否也有這種感覺？」"
  },
  Event_80481_Name = {
    Text = "迷夢中的呼喚"
  },
  Event_80595_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80595_Desc = {
    Text = "\n面對你的驅趕，蝴蝶無動於衷。\n它執著地追逐著你的手掌，在你的手心裡失去生息。\n「啊，好溫暖……」\n這是它最後的心聲。"
  },
  Event_80595_Name = {
    Text = "蝴蝶的夢想"
  },
  Event_80596_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80596_Desc = {
    Text = "「我想鮮花一直盛開，我想微笑永恆長存。」\n「我想所有患上融蝕的人都能痊癒平安，我想這個世界回復往昔，不再燃燒。」\n「我想……」\n小小的蝴蝶扇動著翅膀，在你的手心裡失去生息。\n至少，有人聆聽過它的聲音。"
  },
  Event_80596_Name = {
    Text = "蝴蝶的夢想"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "【驅趕蝴蝶】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80597_ChoiceDesc2 = {
    Text = "【聆聽心願】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_80597_Desc = {
    Text = "小小的蝴蝶，也有許多夢想。\n這些夢想散落在花海裡、病房裡、還有充滿許多血肉的@2祭壇裡。\n而今，它終於等到了羈絆之人，不知你是否願意聆聽它小小的、小小的心願。"
  },
  Event_80597_Name = {
    Text = "蝴蝶的夢想"
  },
  Event_80610_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80610_Desc = {
    Text = "「理性嗎？有趣的回答。」\n「但願你不會為自己的選擇後悔。」"
  },
  Event_80610_Name = {
    Text = "人性的代價"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "【投餵他們】獲得白銀造物「(RelicConfig.Arg1)」，選擇感染1次症狀"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "【不做理會】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80612_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_80612_Desc = {
    Text = "居住者來來去去，鼠群卻長久綿延。\n和人類相比，它們才是這座古堡的「原住民」\n但它們對於人類的進駐沒有異議。\n因為那些香軟的、白嫩的醜東西，會投餵它們同樣香軟的、白嫩的醜東西。\n「而你，醜東西，屬於哪一種？」"
  },
  Event_80613_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80613_Desc = {
    Text = "\n黑暗中傳來溫柔的笑聲。\n「我等著你，來見我。」\n「勇敢的小蟲子。」"
  },
  Event_80613_Name = {
    Text = "「她」的窺視"
  },
  Event_80614_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80614_Desc = {
    Text = "「閉嘴閉嘴，難聽死了。」\n黑貓人性化地捂著耳朵。\n「人類，你的貓語真得很差，說得什麼亂七八糟的話！」\n雖然嘴上這麼說著，但黑貓的神色卻平和下來。\n「看在你喵喵叫取悅我的份上，送你個禮物吧。」\n「至於禮物的內容，取決於你的運氣。」"
  },
  Event_80614_Name = {Text = "尼格曼"},
  Event_80615_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80615_Desc = {
    Text = "\n「母親，在失去朋友、丈夫、兒子後，我又永遠的失去了戴安娜，我的小女兒。」\n「當她在我面前化為灰燼時，我的大腦一片空白……」後續的字跡已無法看清。\n你只能轉而閱讀下一行字。\n我已經下定了決心。如果再見到我，請不要責備我，我只是……太想你們了。"
  },
  Event_80616_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80616_Desc = {
    Text = "你的驅趕產生了效果。少數看不清形貌的身軀扭曲著逃離，大部分仍留在原地。\n他們不再嬉笑，不再吟誦，反而嚎啕大哭。\n孩子的哭聲驟響在你耳邊，只重複著一句話。\n「打死怪胎！」"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "【離開】感染「(Skill.Arg1)」"
  },
  Event_80617_Desc = {
    Text = "你的投餵取悅了鼠群。\n那龐大的鼠群湧動著，贈送你一件粗陋包裝的禮物。\n你看不出那禮物的模樣，只看到浸染在包裝上的大量鮮血。"
  },
  Event_80618_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80618_Desc = {
    Text = "「……」\n「…………」\n「………………」\n黑影沉默著，他想要哭泣，卻已經失去流淚的能力。\n最終，他只是深深地歎了口氣。\n「朋友，但願你能守護住自己最珍貴的東西。」"
  },
  Event_80619_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80619_Desc = {
    Text = "你的呵斥毫無作用，反而令他們更加狂熱歡欣。\n嬉笑吟誦聲越發高昂，唱著另一個童謠。\n「小威廉，住古堡，食人鼠，牆中跑。\n待到人牲獻祭時，所有人都被啃倒。」"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "【迴避目光】隨機覺醒1名喚醒體"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "【直視目光】選擇覺醒1名喚醒體，並降低其覺醒卡算力消耗2點。感染「(Skill.Arg1)」"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_80620_Desc = {
    Text = "療養院的一切，都在她的掌控與窺視之下。當然，你也是。\n但她願意為你睜一隻眼閉一隻眼。\n畢竟，遊戲要有來有往，才更有趣。"
  },
  Event_80620_Name = {
    Text = "「她」的窺視"
  },
  Event_80621_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80621_Desc = {
    Text = "你將信封放回原處，準備離開，卻忽然聽到迷離的低喃。\n「在我的請求下，克萊門汀醫生終於鬆口了。\n她向我描述的那廣袤的宇宙、神秘的宇宙裡，一定有著能夠救回你們的辦法。\n我已經做好了」新生「的準備，無論要漂流多少光年，我都渴望再見你們一面。」"
  },
  Event_80622_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80622_Desc = {
    Text = "克萊門汀醫生救下了我。\n她真的是一個非常、非常好的人，願意傾聽我的聲音。\n我真的很想說一些開心的事、快樂的事，然而此刻的我，除了痛苦與絕望，別無他物。\n恐怕，我要辜負醫生的心意了。\n在失去你們後，生活對於我來說，只有荒蕪。"
  },
  Event_80623_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80623_Desc = {
    Text = "「你、你……」\n「哼，手法還不賴嘛，這次就算你過關。下次可沒那麼容易！」\n黑貓一躍，輕巧地跑遠了。"
  },
  Event_80623_Name = {Text = "尼格曼"},
  Event_80624_ChoiceDesc1 = {
    Text = "【攻擊黑貓】50%機率獲得125黑印，50%機率感染「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "【學貓叫】75%機率獲得100黑印，25%機率感染「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "【嘗試擼貓】獲得50黑印"
  },
  Event_80624_Desc = {
    Text = "「嘿！你，禁止向前。」\n黑貓們突然跳出，阻攔你繼續前行。\n它們優雅地舔著爪子，神態桀驁又驕傲。\n「前方充滿了危險，可不是你這種弱小的人類可以探索的。」\n你表達了必須向前的決心，這時領頭黑貓的豎瞳轉了轉，展露玩弄獵物的殘酷天性。「那就向我們展示你的決心吧。」"
  },
  Event_80624_Name = {Text = "尼格曼"},
  Event_80625_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80625_Desc = {
    Text = "\n你的無視激怒了鼠群，它們嘶叫著湧向了你，而你，早在鼠群湧動前，就已跑遠。"
  },
  Event_80626_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80626_Desc = {
    Text = "「啊，就是這樣，折斷我的翅膀吧。」\n「時間、健康、尊嚴、生命，他們已經從我這裡掠走了太多。」\n「這最後的夢想，當然也不屬於我。」\n「因為，我只是被關起來失去自由的鳥。」"
  },
  Event_80627_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80627_Desc = {
    Text = "「感性嗎？有趣的回答。」\n「但願你不會為自己的選擇後悔。」"
  },
  Event_80627_Name = {
    Text = "人性的代價"
  },
  Event_80628_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80628_Desc = {
    Text = "「我接受你的祈求。」\n嗡鳴聲湊近，通過耳道緩緩鑽入你的大腦。\n你的大腦在戰慄，而在這戰慄中，你聆聽到了宇宙的「聲音」。\n「與我，連結。」"
  },
  Event_80628_Name = {
    Text = "黑暗救贖"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "【祈求】隨機覺醒1名喚醒體，感染「(Skill.Arg1)」"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "【拒絕】獲得3選1刻印"
  },
  Event_80629_Desc = {
    Text = "「不該是這樣的，不該是這樣的。」\n「我明明、明明應該脫離人類這種低級的生命，進化為更高級的……」\n黑暗中，傳來痛苦的抽泣。\n這些抽泣彙聚、湧動，形成巨大的嗡鳴。\n「這個燃燒的世界，如同永不饜足的黑洞，吞噬著每一個人，所以——」\n「向我祈求吧，無盡的宇宙會給予你救贖。」"
  },
  Event_80629_Name = {
    Text = "黑暗救贖"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "【打開信封】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "【閱讀】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "【放回原處】獲得50黑印"
  },
  Event_80630_Desc = {
    Text = "無人關注的角落裡，遺落了一封信件。\n信件上的許多字跡已經無法辨認，但唯有一個詞。力透紙背。\n那個詞是「母親」。"
  },
  Event_80631_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80631_Desc = {
    Text = "「呵，渺小的人類，你做出了錯誤的選擇。」\n黑貓們冷酷地望著你，驟然突襲。\n「你必須付出代價——當然，我們也尊敬強者。」"
  },
  Event_80631_Name = {Text = "尼格曼"},
  Event_80632_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80632_Desc = {
    Text = "\n黑暗中傳來溫柔的笑聲。\n「我等著你，來見我。」\n「可愛的小蟲子。」"
  },
  Event_80632_Name = {
    Text = "「她」的窺視"
  },
  Event_80633_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80633_Desc = {
    Text = "在你的攻擊下，這群扭曲古怪的身影終於逃離了。\n四周靜謐，唯有你的心跳在無聲哭泣。\n原來，這就是「他」的童年。"
  },
  Event_80635_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80635_Desc = {
    Text = "「啊，小小的文字陷阱被窺破了。」\n「這是獎勵。因為啊……」\n「不是每一次的選擇，都必須選擇。」"
  },
  Event_80635_Name = {
    Text = "人性的代價"
  },
  Event_80636_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80636_Desc = {
    Text = "「@3忤逆者」\n嗡鳴聲漸漸虛弱，直至消失。只留下最後的言語。\n「維持人性，可無法在這殘酷的世界生存。」"
  },
  Event_80636_Name = {
    Text = "黑暗救贖"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "【選擇拒絕】刪除1張指令卡，獲得Arg1黑印"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "【選擇遵從】複製1張指令卡，感染「(Skill.Arg1)」"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "【選擇擁抱】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80637_Desc = {
    Text = "「我是一隻籠中鳥，被關在充滿許多房間的院子裡。」\n黑暗中徘徊著模糊的人影，那是逝去者留下的執念。\n「他們說，那是瘋人院，可我卻知道，那是人類的特殊囚籠，關押著不願遵從社會規則的自由鳥。」\n「可是鳥兒如果不能飛翔，還能被稱為鳥嗎？」\n執念們向你靠攏，祈求著救贖。\n「請折斷我的翅膀，我已厭倦了飛翔。」"
  },
  Event_80638_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_80638_Desc = {
    Text = "「……」\n「…………」\n「………………」\n黑影忽然顫動著，消融進了你的身體。\n「朋友，前進吧，為了保護自己最珍貴的東西。」\n「雖然我們已經逝去，但仍願意為你夢想，獻上最後的祝福。」"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "【選擇感性】回復 Arg1 點生命"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "【維持理性】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "【拒絕選擇】獲得25黑印"
  },
  Event_80639_Desc = {
    Text = "「選擇吧，選擇。」\n狂奔的黑暗中，傳來了無數的呢喃。\n這聲音溫柔催眠，似乎帶著無限的魔力，令你產生某種癲狂的幻覺。\n你的大腦陷入狂悖，蠕動著脫離身體，而心臟則似乎生髮了某種意識，向你驚叫著呼喚。\n「選擇吧，選擇。」\n「維持理性還是感性，你必須做出選擇。」"
  },
  Event_80639_Name = {
    Text = "人性的代價"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "【呵斥「他們」】感染「(Skill.Arg1)」，獲得詛咒造物「(RelicConfig.Arg2)」"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "【驅趕「他們」】感染兩次「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "【攻擊「他們」】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_80641_Desc = {
    Text = "「小威廉，是怪胎，睡墳堆，沒人愛。不要和他有往來，小心被他暗中害。」\n看不清形貌的身軀扭曲著，聲音卻如幼童。\n他們嬉笑著、吟誦著，以一種輕蔑又熱切的眼神望著你。\n帶著惡意。"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "【享用它】將 1 張「祭靈夜特調」置入牌庫。"
  },
  Event_90571_Desc = {
    Text = "華麗的餐桌，熱烈的舞池，精緻的餐具，馥郁的屍體……\n噢，我知道你已經急不可耐了，但請再等等，親愛的客人。\n這杯由宴會主人特別調製的飲品，是隻屬於尊貴客人的贈禮。\n握住它。啜飲它。在它的餘味裡，盡情享受這場歡愉吧！"
  },
  Event_90571_Name = {
    Text = "宴前儀禮"
  },
  Event_91460_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91460_Desc = {
    Text = "你無從抵抗，只能任由聲音穿透。\n尖刻的啼叫剖開了你的大腦，一些被遺忘的恐懼流淌而出，你感受到它的饑餓。\n可怕的食人生物……"
  },
  Event_91460_Name = {
    Text = "無聲告白"
  },
  Event_91461_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91461_Desc = {
    Text = "你不再剋制，讓那份灼熱徹底釋放，所有未說出的言語從你的頭顱中不斷迸發。\n你感受到奇妙的靈感，沉醉於皮克曼的才華。"
  },
  Event_91462_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91462_Desc = {
    Text = "火舌纏上墨漬，留下一片血跡斑斑。\n那一刻，你在夢境和現實的邊緣墜落。你看到自己變成了一個小女孩，牽起杜勒賽因的手與之共舞。\n當你醒來再次望向杜勒賽因之時，沉重的悲傷席捲了你的大腦。"
  },
  Event_91462_Name = {
    Text = "夢的啟示"
  },
  Event_91463_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91463_Desc = {
    Text = "你衝上去，火焰隱沒於你的皮膚。至於那幅畫，任誰看也不過是一幅平平無奇的肖像畫。\n此後的夢中，你總會看到燃燒的自己，炙烤得恰到好處，然後在某天端上你自己的餐桌。"
  },
  Event_91463_Name = {
    Text = "燃燒肖像"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "【聆聽】獲得30黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_91464_Desc = {
    Text = "在無聲的嘈雜中，你逐漸明白了烏鴉的言語……"
  },
  Event_91464_Name = {
    Text = "無聲告白"
  },
  Event_91465_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91465_Desc = {
    Text = "你撿起石子，驚醒那些專注啃噬的鼠影。\n它們貪婪地與你對視。\n你聞到它們身上潮濕的污穢氣味，彷彿是某種預兆。"
  },
  Event_91465_Name = {
    Text = "流放王國"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "【聆聽】獲得25黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_91466_Desc = {
    Text = "它在歡迎。歡迎誰？\n當然是你！\n也許它把你視作明天的美餐。"
  },
  Event_91466_Name = {
    Text = "無聲告白"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "【割開手掌】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91467_ChoiceDesc2 = {
    Text = "【接受生長】獲得白銀造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91467_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_91467_Desc = {
    Text = "那只蝴蝶並非飛來，而是從你的掌心慢慢生長。\n你一開始以為只是汗水，卻在指縫間看見黑色液體如血管反流般悄然滲出，凝結成冰冷而脈動的翅膀。\n每一次翕動，便在你的血液中激起漣漪。"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "【解救肖像】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91468_ChoiceDesc2 = {
    Text = "【接受空白】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91468_ChoiceDesc3 = {
    Text = "【離開】獲得25黑印"
  },
  Event_91468_Desc = {
    Text = "你站在皮克曼的贈禮面前。\n那是一幅肖像畫，由鮮血繪就，漆黑的火焰安靜地燃燒著。\n透過畫中人空洞的眼眶，你看到——\n你的記憶正翻湧燃燒，拉長、扭曲、發光，彷彿某種無形之火正舔舐你腦中的回廊。恍惚間你聽見一道人聲。\n「該下鍋了，這火候正好。」\n這正是你自己繪出的記憶之景，你在火焰中掙扎變形。"
  },
  Event_91468_Name = {
    Text = "燃燒肖像"
  },
  Event_91469_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91469_Desc = {
    Text = "你拒絕接聽，靜靜地看著它震顫至停歇。\n這麼多年來，你早已學會了與瘋狂對抗。"
  },
  Event_91469_Name = {
    Text = "未接來電"
  },
  Event_91470_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91470_Desc = {
    Text = "你後退一步，任由畫布在火焰中燃燒。\n你看到自己被火烤出誘人的焦黃，油脂泛起發出劈啪的脆響，彷彿能夠透過畫布聞見肉的香氣。\n杜勒賽因感受到的，就是這種誘惑嗎？"
  },
  Event_91470_Name = {
    Text = "燃燒肖像"
  },
  Event_91471_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91471_Desc = {
    Text = "懷著一種近乎褻瀆的好奇，亦或是對抗未知的絕望勇氣，你在往日的幻影中找尋啟示。\n你看到一位女孩和身旁面目模糊的高大男人共舞，莫名的快樂充盈著你的心臟。"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "【終止記錄】刪除2張卡牌"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "【繼續書寫】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91472_ChoiceDesc3 = {
    Text = "【離開】獲得 Arg1 黑印"
  },
  Event_91472_Desc = {
    Text = "你總算是從食屍鬼的集市上暫時解脫，尋得一處安靜的角落如往常一樣開始記錄。\n打字機突然狂暴地震動，按鍵自行起落，黑色的粘液從縫隙中噴湧而出，濺濕了你指尖的理智。\n你看到紙張之上漸漸浮現呼之欲出的蝶影……"
  },
  Event_91473_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91473_Desc = {
    Text = "奇怪的是，明明是未曾學習的言語，但你彷彿明白了其中的含義。\n詩句中寫滿了對親人的思念，這份思念跨越生與死，在你的夢中得以傳遞。\n你隱約地在詩的末尾辨認出字跡——\n是「賽琳涅」。"
  },
  Event_91473_Name = {
    Text = "夢的啟示"
  },
  Event_91474_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91474_Desc = {
    Text = "你忍痛割開手心的皮膚，用火焰灼燒那片新生的肉翅。\n黑液蒸騰，蝴蝶破碎。\n一切變得乾淨無痕，但你卻總覺得掌心傳來微弱的振翅之聲，如同某個未能完全孵化的思想，仍在你的血管中緩緩呼吸。\n杜勒賽因對此不置可否，只是要走了你留下的鮮血。"
  },
  Event_91475_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91475_Desc = {
    Text = "你知道狂熱的靈感總會造成災厄，於是你用理性將一切封存。"
  },
  Event_91476_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91476_Desc = {
    Text = "你逼視那只眼，試圖理解它傳遞的資訊。\n雖然你早已身經百戰，但是此次面對戈利亞……恐懼扼住了你的心臟。\n「近乎正常，就是災厄發生前最沉默的形狀。」"
  },
  Event_91477_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91477_Desc = {
    Text = "你閉上眼，轉身走入曠野。\n你能察覺潛藏的渴望與預兆，但永遠無法親手止息。\n你看向周圍無字的墓碑，或許這就是你的結局。"
  },
  Event_91477_Name = {
    Text = "群鴉盛宴"
  },
  Event_91478_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91478_Desc = {
    Text = "你緩緩抬起頭，那一刻，光刺穿瞳孔，熾熱在腦中開出空白的花。\n葬骸城的星星與別處的並無不同，而看似擁有永恆的食屍鬼也只能生存在群星之下，不得自由。"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "【投於爐火】刪除1張卡牌"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "【嘗試解讀】獲得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91479_Desc = {
    Text = "你的意識在無邊的黑霧中浮沉，穿梭於無數生者與亡者的精神圖景。\n在夢中，神奇的打字機中吐出一段陌生的詩句。這又是誰的故事？\n它刻印在未知來歷的紙上，扭曲的字跡彷彿是清醒的醉酒者手寫而成。\n你被夢中的無法言喻的衝動驅使，拿起那張紙，油墨在爐火的光影之間跳躍。"
  },
  Event_91479_Name = {
    Text = "夢的啟示"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "【加入】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc2 = {
    Text = "【驅趕】感染「(Skill.Arg1)」，隨機1張卡牌獲得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc3 = {
    Text = "【漠視】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91480_Desc = {
    Text = "你聽到遠處若隱若現的骨螺號角聲。\n鼠群循聲從黑泥中湧現，啃噬著乾枯河床上躺著的無名屍體。\n它們圍成一個圓，圓心是那具已然空洞的遺體，圓周則是一個以遺忘為法律的新王國。\n而你，正站在這個王國的入口。"
  },
  Event_91480_Name = {
    Text = "流放王國"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "【抬頭注視】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "【低頭離開】獲得75黑印，感染「(Skill.Arg2)」"
  },
  Event_91481_Desc = {
    Text = "群鴉在天空中盤旋，像一把遲疑的鋸，反復切割天空的脊骨。\n它們圍繞著你低飛，彷彿預見了你的死亡，耐心地等待盛宴的開始。"
  },
  Event_91481_Name = {
    Text = "群鴉盛宴"
  },
  Event_91482_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91482_Desc = {
    Text = "你讓它繼續書寫，用你的脈搏、你的痛覺、你的往昔與猜想。\n蝴蝶衝破紙張的束縛，你的心靈隨之放飛。\n你開始想像自己在遊樂園的快樂。你沒有告訴杜勒賽因的是，其實你非常喜歡遊樂園，哪怕是屍體遊樂園……\n應該……不會很獵奇吧？"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "【重新觀察】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91483_Desc = {
    Text = "往日清晰的晚餐變成了血肉模糊的盛宴，你回憶起灶台上的食材，腐爛的氣味刺激著鼻腔。\n恐懼扼住了你的心臟，你不得不做出抉擇。"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "【無視鈴聲】獲得3選1高級刻印"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "【拿起聽筒】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91484_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_91484_Desc = {
    Text = "它本不該響起——那只電話，蜷縮在畫布背後。\n聽筒的線纏繞在大塊頭機身上，如同生銹的臍帶，似乎從你的腦中延伸。\n你仔細辨別震動的頻率，詭異的聲響猶如皮克曼的超現實藝術。"
  },
  Event_91484_Name = {
    Text = "未接來電"
  },
  Event_91485_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91485_Desc = {
    Text = "你捧起那顆冰冷的大腦，瞬間它化作流水從你的指縫無聲地滑落。\n天平隨即失衡，心臟如腐果般迅速塌陷、消融，化作一灘沉默的黑水。\n所有的饑餓消失了，你擁有了冷靜、不悔與短暫的清明。"
  },
  Event_91485_Name = {
    Text = "饑餓遊戲"
  },
  Event_91486_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91486_Desc = {
    Text = "沒有聲音，無人回應。或許只是一個惡作劇？\n就當你放下聽筒時，某種沉重的感情倒流回你的體內。"
  },
  Event_91486_Name = {
    Text = "未接來電"
  },
  Event_91487_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91487_Desc = {
    Text = "烏鴉消失了。\n但是你看見自己站在另一個夜晚的鏡中，凝視這只烏鴉。\n它仍在無聲嘯叫，彷彿等待你的回應。"
  },
  Event_91487_Name = {
    Text = "無聲告白"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "【重新觀察】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "【放棄抵抗】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，還可以使用一次"
  },
  Event_91488_Desc = {
    Text = "你果斷地移開目光，可是那些圖像卻如同幽影浮現在你的眼中……\n那是一支憂傷的雙人舞。"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "【享用】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "【婉拒】感染「(Skill.Arg1)」，重新刻印，最多進行2次"
  },
  Event_91489_Desc = {
    Text = "那是杜勒賽因為辛苦調查的你們精心準備的。\n不加香料卻沒有腐味，就如杜勒賽因所說，這是最好的食材。\n宴席為你而設，而大腦在盤中靜默無言。\n「要嚐嚐嗎？」"
  },
  Event_91489_Name = {
    Text = "賞味佳餚"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "【聆聽】獲得40黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "【無視】獲得25黑印，離開"
  },
  Event_91490_Desc = {
    Text = "那是一隻烏鴉。\n它站在骷髏燈盞之上，張嘴，卻沒有發出任何聲音。"
  },
  Event_91490_Name = {
    Text = "無聲告白"
  },
  Event_91491_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91491_Desc = {
    Text = "你緩緩將手伸向那顆尚熱的心臟，它躍動著、收縮著，直到化作一股馨香的熱氣消散。\n天平劇烈一震，大腦跌落於無盡的黑暗。\n充盈的飽腹感取代了饑餓，你領悟了熱烈、痛苦與真正的記憶。"
  },
  Event_91491_Name = {
    Text = "饑餓遊戲"
  },
  Event_91492_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91492_Desc = {
    Text = "你仰起頭，迎接那無聲的旋轉，像古老祭祀的朝聖者。\n它們歡快地享用你的血肉，你感到痛，卻也清明。\n你看見了失落的自己，那些未能死去的部分，終於被帶走了。\n當意識回歸，你發現自己安然無恙。"
  },
  Event_91492_Name = {
    Text = "群鴉盛宴"
  },
  Event_91493_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91493_Desc = {
    Text = "你用記憶與情緒的水泥將鎖孔封死，真理再也不能將你誘惑。\n看著你如臨大敵的模樣，杜勒賽因舔了舔嘴角。\n「還想嚐嚐嗎？這可是為守密人閣下特製的腦葉馬蘇裡拉。」"
  },
  Event_91493_Name = {Text = "啟示錄"},
  Event_91494_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91494_Desc = {
    Text = "其實你一直好奇食屍鬼的體驗。\n「於是你走入鼠群，成為了它們的一員——」\n你不得不承認，蹈海者的到來讓你的腦子變得不太清醒。"
  },
  Event_91494_Name = {
    Text = "流放王國"
  },
  Event_91495_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91495_Desc = {
    Text = "你不願沾染腐敗與混亂。\n你早已習慣，一切腐朽如同常態。"
  },
  Event_91495_Name = {
    Text = "流放王國"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "【享用】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "【婉拒】感染「(Skill.Arg1)」，再次隨機刻印"
  },
  Event_91496_Desc = {
    Text = "杜勒賽因優雅地幫你切了一塊「大腦」。\n這甜美的滋味……\n這鬆軟而綿密的口感……\n你很想要再嘗一口。"
  },
  Event_91496_Name = {
    Text = "賞味佳餚"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "【我在做夢】獲得白銀造物「(RelicConfig.Arg1)」"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "【這不正常】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91497_Desc = {
    Text = "光滑的墓碑照出一隻正在緩慢扭曲的眼睛。\n像是在承載某種肉眼無法描摹的圖像，一段記憶不屬於你，卻已深植於你眼底的褶皺。\n你試圖眨眼、用指腹擦拭，可那只眼睛不再屬於你，它開始反射出萬花筒般的景象。"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "【繼續觀察】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "【移開目光】感染「(Skill.Arg1)」，更換選項1中所獲得的刻印，可以使用兩次"
  },
  Event_91498_Desc = {
    Text = "在古堡潮濕的角落裡，你發現了那盤膠捲。\n影像如同溺斃於時間之河的幻影，在緩慢的定格中凝固，時而膨脹成難以名狀的巨物，時而坍縮成閃爍不定的星點。\n你沉浸其中，一陣暈眩提醒了你時間的流逝。"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "【凝視群星】獲得黃金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91499_ChoiceDesc2 = {
    Text = "【閉上眼睛】隨機覺醒2名喚醒體，感染兩次「(Skill.Arg1)」"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "【離開】獲得50黑印"
  },
  Event_91499_Desc = {
    Text = "你站在空無一人的墓地，星星的存在讓黑夜亮如明晝。\n那些漂浮在時間深海中的光球不曾言語，卻在漫長如夢囈的旋轉中，緩緩聚焦。\n它們注視著被遺忘的孤星。\n祂注視著你，注視一切死亡與永恆。"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "【聆聽】獲得20黑印，感染「(Skill.Arg2)」"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_91500_Desc = {
    Text = "你與它對視。\n在一片漆黑中，你看到了貪婪的野火。"
  },
  Event_91500_Name = {
    Text = "無聲告白"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "【開啟鎖孔】獲得詛咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91501_ChoiceDesc2 = {
    Text = "【封閉鎖孔】隨機1張卡牌獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91501_Desc = {
    Text = "面對杜勒賽因遞來的腦葉，你幾番推拒，終究是抵不過智慧的誘惑。\n知識並非緩慢降臨，而是驟然傾瀉。\n大腦開始脹痛，思維像發酵的麵包持續膨脹。當你終於倒下，痛覺如潮水退卻，意識好像中空了一塊，留下一個乾淨的、古老的鎖孔。\n原來這就是知識的形狀！你感受到前所未有的智慧。\n或許……你可以獲得更多？"
  },
  Event_91501_Name = {Text = "啟示錄"},
  Event_91502_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91502_Desc = {
    Text = "你用意識殘留的鋒刃撬動那個鎖孔。\n你不知鑰匙為何物，只用執念作嘗試。那一刻，你的思想燃燒殆盡，只留下某種非人之理在空洞的鎖孔裡低語。\n難道這就是啟示？你興奮地與杜勒賽因分享。\n「還想嚐嚐嗎？這可是為守密人閣下特製的腦葉馬蘇裡拉。」"
  },
  Event_91502_Name = {Text = "啟示錄"},
  Event_91503_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91503_Desc = {
    Text = "你既不引爆它，也不壓抑它。\n在一種玄妙的旁觀者境界中，你將那噴湧的思想視作天氣變化的一部分，讓它自行流向未知的結局。\n在血與肉的畫作中，你領略了永恆的藝術。"
  },
  Event_91504_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91504_Desc = {
    Text = "按鍵猛然停下，蝶影瞬息消散。\n是幻覺嗎？你若有所失。\n或許該聽杜勒賽因的話去記憶罐頭商店買點腦葉了。\n「不對，我在想什麼？」"
  },
  Event_91505_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91505_Desc = {
    Text = "你不再掙扎，任那翅膀與黑液穿透掌紋。\n你成了它的器皿，而它以你為殼，繼續思考。\n蝴蝶越長越大，你終於承受不住重量。\n見此，杜勒賽因興致勃勃地用餐刀切斷了你與蝴蝶的連接。他躍躍欲試的眼神，分明是想要……\n你拒絕了他的申請。"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "【聆聽】獲得35黑印，感染「(Skill.Arg2)」，繼續選擇"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "【無視】離開"
  },
  Event_91506_Desc = {
    Text = "你本以為它沉默，直到你的意識忽然傾斜，彷彿無數隻烏鴉的頭顱在你腦中啼叫。\n你跪倒在地，世界在你的眼中旋轉。"
  },
  Event_91506_Name = {
    Text = "無聲告白"
  },
  Event_91507_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91507_Desc = {
    Text = "你閉上眼，踏入那無盡、柔軟的塵霧之中，星雲擁抱你，而你失去了形狀，一種比身體更穩固的存在於你的體內沉澱。\n那一夜，群星繼續旋轉，一如往日明亮。\n對於長生者而言，星空意味著什麼呢？或許你該去問問杜勒賽因。"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "【享用】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91508_Desc = {
    Text = "原來是乳酪呀。\n你在慶倖的同時，又有幾分遺憾。"
  },
  Event_91508_Name = {
    Text = "賞味佳餚"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "【點燃】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」】"
  },
  Event_91509_ChoiceDesc2 = {
    Text = "【等待】感染「(Skill.Arg1)」，獲得白銀造物「(RelicConfig.Arg2)」"
  },
  Event_91509_ChoiceDesc3 = {
    Text = "【封存】獲得25黑印"
  },
  Event_91509_Desc = {
    Text = "你凝視著皮克曼的畫作，令人作嘔的腐爛氣息讓你陷入眩暈。\n思緒從腦中緩慢升起，起初只是熱氣，後來是薄霧，再後來——"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "【觸摸大腦】隨機1張指令卡獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "【觸摸心臟】提升 Arg1 點最大生命，感染「(Skill.Arg2)」"
  },
  Event_91510_Desc = {
    Text = "你走入那間無人低語的灰廳，一架天平在黑霧中若隱若現。\n左邊，是一枚沉靜如湖的大腦，銀白色的溝壑閃著微光；右邊，是一顆火紅色的、蒸騰著熱氣的心臟。\n忽然之間，你聞到一陣香氣，饑渴的欲望不斷膨脹，理智被祂無邊的黑暗擠壓。\n你伸出了手。"
  },
  Event_91510_Name = {
    Text = "饑餓遊戲"
  },
  Event_91511_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91511_Desc = {
    Text = "這一定是一場夢。你反復說服自己。\n在不知不覺間，你真的陷入了夢鄉。\n也許是因為最近交流太多，你竟夢見了杜勒賽因——主動讓杜勒賽因食用自己的血肉？什麼恐怖故事？"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "【另闢蹊徑】從3張指令卡中選擇1張獲得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "【任其存在】隨機3張指令卡獲得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91660_Desc = {
    Text = "「驅使靈魂，你需要引領亡者走到盡頭。」\n伴隨著杜勒賽因的話語，你如有明悟。\n並不是知識，也不是記憶——那東西更像是一種重量，從你的眼眶攝入，像洪水一樣灌入你的大腦。\n你的情緒似乎不再屬於此時此地，它退開，顯露出一處宇宙疏忽的縫隙。\n你所能感知的一切，就在那裡停止，像走到了一條路的最末端。"
  },
  Event_91660_Name = {
    Text = "靈魂盡頭"
  },
  Event_91661_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91661_Desc = {
    Text = "你讓靈魂遠走。\n在「自我」的邊界，你彷彿聽到了亡者的低語。\n但當你仔細聆聽時，一切都消失了。"
  },
  Event_91661_Name = {
    Text = "靈魂盡頭"
  },
  Event_91662_ChoiceDesc1 = {
    Text = "【離開】"
  },
  Event_91662_Desc = {
    Text = "你將自己的意識包裹起來，從而隔絕了未知的誘惑。\n你在靈魂的盡頭迷失，只看到了自己。\n果然，身為活人的你無法擁有食屍鬼的能力。"
  },
  Event_91662_Name = {
    Text = "靈魂盡頭"
  }
})
return Text_Event
