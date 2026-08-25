__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CollectionHall = readonly({
  CollectionHall_100308_Title = {
    Text = "帕拉黛斯号"
  },
  CollectionHall_100309_Title = {Text = "畸世绘"},
  CollectionHall_100310_Title = {
    Text = "不朽极昼"
  },
  CollectionHall_100442_Desc = {
    Text = "<Title:简介>\n出生于人类富商家庭，体内却流淌着食尸鬼的血。半人半食尸鬼的血脉给了他独特的天赋，让他能够看到常人所不能看到的世界。那个世界疯狂，荒诞，绚烂的色彩让他无法自拔。\n几乎没有犹豫，皮克曼选择用画笔记录下他所看到的一切。他沉浸其中，在日复一日的描绘中拥有了纯熟的画技。\n主流的审美将皮克曼彻底抛弃，没有人能够接受他那套疯狂的论调。皮克曼常常为此难过，但他从来没有放弃过。\n最终，皮克曼拥抱融蚀，彻底觉醒了食尸鬼的血脉。他离开人类世界，来到食尸鬼的王城。终有一天，他要将真实世界里那些奇幻疯狂的景象，一一呈现在世人面前。"
  },
  CollectionHall_100442_LockTip = {
    Text = "唤醒「皮克曼」后解锁"
  },
  CollectionHall_100442_Title = {Text = "皮克曼"},
  CollectionHall_100458_Desc = {
    Text = "把烦恼暂时放下，让疲倦快快远离。\n让我们在温暖的篝火旁，稍稍休息一下吧。"
  },
  CollectionHall_100458_LockTip = {
    Text = "完成意识潜游「不朽极昼」"
  },
  CollectionHall_100458_Title = {
    Text = "篝火温憩"
  },
  CollectionHall_100459_Desc = {
    Text = "燃烧吧，燃烧吧，将属于你的一切，尽数燃烧吧。\n然后在那无尽的烈火中，开启你和世界的葬礼吧！"
  },
  CollectionHall_100459_LockTip = {
    Text = "完成意识潜游「不朽极昼」"
  },
  CollectionHall_100459_Title = {
    Text = "烈火中的葬礼"
  },
  CollectionHall_100460_Desc = {
    Text = "“我说过了，无论以哪种方式，我都要将大家带回家。”\n“我会燃烧属于我的一切，然后……\n“用这来自群星的业火，将这虚假、污秽、混沌的世界燃烧殆尽！”\n“我以凯蒂古拉之名宣告！”\n“天将拂晓！”"
  },
  CollectionHall_100460_LockTip = {
    Text = "完成意识潜游「不朽极昼」"
  },
  CollectionHall_100460_Title = {
    Text = "燃烧一切的拂晓"
  },
  CollectionHall_100461_Desc = {
    Text = "癫狂的死状如万花筒般回旋，源自疾病与尸体的腥甜气息是最好的熏香，你们隔着无数赴死之人遥遥举杯——若死亡是注定，就让我们欢欣地奔赴这场舞会，在舞步的最后一拍共同坠入地狱的大门。"
  },
  CollectionHall_100461_LockTip = {
    Text = "完成意识潜游「燃烧的群宴」困难难度"
  },
  CollectionHall_100461_Title = {
    Text = "红酒、鲜花与华丽之死"
  },
  CollectionHall_100462_Desc = {
    Text = "很久很久以前，她是宇宙中独裁的帝王，一切所见的都归于她的御下。\n很久很久以后，她的眼中只能看见漫无边际的尘埃，从此她所掌管的，只剩荒芜与寂寞。"
  },
  CollectionHall_100462_LockTip = {
    Text = "完成意识潜游「燃烧的群宴」"
  },
  CollectionHall_100462_Title = {
    Text = "掌管荒芜的女王"
  },
  CollectionHall_100463_Desc = {
    Text = "她猖獗、暴戾、喜怒无常，同时她亦宽仁、博学、充满智慧。\n她是荒淫的暴君，也是羔羊的庇护者，她赐予你爱，也赐予你死。这片土地上的一切生灵都要匍匐在她的脚下，尊敬地高呼她的名号。\n在女王的舞会上尽情沉醉吧，然后与她一起，沉入永恒的黑色火焰。"
  },
  CollectionHall_100463_LockTip = {
    Text = "完成意识潜游「燃烧的群宴」"
  },
  CollectionHall_100463_Title = {
    Text = "赴死酣宴"
  },
  CollectionHall_100464_Desc = {
    Text = "假如死前只能做最后一件事，那就跳舞吧。\n饮下甘醇的美酒，咽下香甜的煎肉，在狂欢的乐曲中尽情飞旋。\n要这世界在眼中最后的倒影，仍闪烁着迷醉的金光。"
  },
  CollectionHall_100464_LockTip = {
    Text = "完成意识潜游「燃烧的群宴」困难难度"
  },
  CollectionHall_100464_Title = {
    Text = "瘟疫的假面"
  },
  CollectionHall_100465_Desc = {
    Text = "她总在湖中看到辉煌的旧日。\n风化的记忆如虚假的梦境，梦里她坐在无边废墟之中，目睹属于她的一切都如幻影一般模糊消散。\n在连那个梦境也将被忘记的时候，吹笛的使者穿过迷雾而来，引领她走向逝去之人的归途。"
  },
  CollectionHall_100465_LockTip = {
    Text = "完成意识潜游「燃烧的群宴」"
  },
  CollectionHall_100465_Title = {
    Text = "湖中倒影"
  },
  CollectionHall_100466_Desc = {
    Text = "群星间永不熄灭的存在再次睁开双眼，将不朽的力量投射至这颗浑浊、污秽却无比蔚蓝的星球，\n与那四十亿年前，遮天蔽日的太阳降临时一模一样。"
  },
  CollectionHall_100466_LockTip = {
    Text = "完成意识潜游「不朽极昼」"
  },
  CollectionHall_100466_Title = {
    Text = "四十亿年的再会"
  },
  CollectionHall_116205_Title = {
    Text = "再见永无乡"
  },
  CollectionHall_116601_LockTip = {
    Text = "需要通关限时活动「极昼的终夜：交融的苦血」任一关卡"
  },
  CollectionHall_116601_Title = {
    Text = "极昼的终夜：交融的苦血"
  },
  CollectionHall_116868_Title = {
    Text = "再见，永无乡"
  },
  CollectionHall_117619_Title = {
    Text = "天边之外·下"
  },
  CollectionHall_117621_LockTip = {
    Text = "通关意识潜游「天边之外·下」任一关卡解锁"
  },
  CollectionHall_117621_Title = {Text = "净化"},
  CollectionHall_117957_LockTip = {
    Text = "限时幻衣活动 「不发糖就捣蛋」中完成免费抽取解锁"
  },
  CollectionHall_117957_Title = {
    Text = "幽灵故事会"
  },
  CollectionHall_117958_Desc = {
    Text = "她游离于记忆和过往之外，她穿过死和生的淤泥，静默地与你重逢。"
  },
  CollectionHall_117958_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117958_Title = {
    Text = "在棺椁中重逢"
  },
  CollectionHall_117959_Desc = {
    Text = "诗歌，情感，回忆，道德……一切都是累赘。这个道理，诗人们从不明白。"
  },
  CollectionHall_117959_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」困难难度"
  },
  CollectionHall_117959_Title = {
    Text = "西岱盛典"
  },
  CollectionHall_117960_Desc = {
    Text = "她坚持要单独出演，否则就要给你一枪。\n但最后她获得了一位好学生，还有一匹狼。"
  },
  CollectionHall_117960_LockTip = {
    Text = "完成异梦视界「再见永无乡」"
  },
  CollectionHall_117960_Title = {
    Text = "独角剧目"
  },
  CollectionHall_117961_Desc = {
    Text = "吃啊，埃弗！看啊，埃弗！\n疯狂和真实之间，由色彩与艺术架构出的桥梁！\n只有我们两个在这里，只有我们能见到真相！"
  },
  CollectionHall_117961_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_117961_Title = {
    Text = "欢迎你！埃弗！"
  },
  CollectionHall_117962_Desc = {
    Text = "每写下一段诗句，便会长出一片花瓣吧，她想。\n她用生命浇灌字句，当最后的诗篇完成，她们便能回到曾经的花园。"
  },
  CollectionHall_117962_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」困难难度"
  },
  CollectionHall_117962_Title = {
    Text = "最后的诗篇"
  },
  CollectionHall_117963_Desc = {
    Text = "他已决意抛下此端，往彼端去。\n与他告别，但不要将祂遗忘。\n祂会提醒你，祂会注视你，那狂悖的疯子、天才的画师，和夜空中高悬的月亮。"
  },
  CollectionHall_117963_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_117963_Title = {
    Text = "往彼处去"
  },
  CollectionHall_117964_Desc = {
    Text = "引吭吧，起舞吧，当蜜和乳在火光旁交融。\n那终焉已愈发近了，以足攀援，以臂交缠，以颈倾吻——繁衍！繁衍！在母树的荫蔽之下，终有种嗣会获得垂怜！"
  },
  CollectionHall_117964_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117964_Title = {
    Text = "繁衍，繁衍！"
  },
  CollectionHall_117965_Desc = {
    Text = "战胜我们，杀死我们。然后，拯救我们。"
  },
  CollectionHall_117965_LockTip = {
    Text = "完成调查行动·困难8-10解锁"
  },
  CollectionHall_117965_Title = {
    Text = "命运将至"
  },
  CollectionHall_117966_Desc = {
    Text = "有一位小姐的手臂被伸缩绳串起，有一位小姐和另一位死掉两次的小姐一起，制造出了一个虚假的亡魂。"
  },
  CollectionHall_117966_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_117966_Title = {
    Text = "抓住你了"
  },
  CollectionHall_117967_Desc = {
    Text = "女王的肉身被融蚀侵袭，亚兰的子民在黄沙中流亡。\n光阴从缝隙间被见证，由故去者，见证命运未能奈何亚兰的数百年。"
  },
  CollectionHall_117967_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_117967_Title = {
    Text = "百年见证"
  },
  CollectionHall_117969_Desc = {
    Text = "那不可名状，无法反抗，痴愚盲目的存在。\n它已浮起，它已半醒，它已显露恐怖而庞大的威压。"
  },
  CollectionHall_117969_LockTip = {
    Text = "完成调查行动·困难8-10解锁"
  },
  CollectionHall_117969_Title = {
    Text = "抗神权柄"
  },
  CollectionHall_117970_Desc = {
    Text = "噤声，前行。序曲早已奏响。\n我会伴你走向，注定的、无上的、至美的终章。"
  },
  CollectionHall_117970_LockTip = {
    Text = "完成调查行动8-14解锁"
  },
  CollectionHall_117970_Title = {
    Text = "恢弘律令"
  },
  CollectionHall_117971_Desc = {
    Text = "也许需要特别注释，意思是在比赛里这是两条注意事项。\n既不要谦让你的对手，更不要谦让你的队友。"
  },
  CollectionHall_117971_LockTip = {
    Text = "完成异梦视界「再见永无乡」困难难度"
  },
  CollectionHall_117971_Title = {
    Text = "禁止谦让"
  },
  CollectionHall_117972_Desc = {
    Text = "西岱的繁花向您发来邀请，邀请您与它们一同走入这场梦境。"
  },
  CollectionHall_117972_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117972_Title = {
    Text = "诗中世界"
  },
  CollectionHall_117973_Desc = {
    Text = "「骑士精神」队，有1/4的骑士精神，和3/4的战斗狂魔。"
  },
  CollectionHall_117973_LockTip = {
    Text = "完成异梦视界「再见永无乡」"
  },
  CollectionHall_117973_Title = {
    Text = "美德骑士与巨魔"
  },
  CollectionHall_117974_Desc = {
    Text = "旧日的女王，被遗忘的女王，她依然在无边孤寂中等待。\n等待着她的血与种，被带向湮灭后的新世界。"
  },
  CollectionHall_117974_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117974_Title = {
    Text = "畸变丰穰之种"
  },
  CollectionHall_117975_Desc = {
    Text = "花园是一道谜题，玫瑰是她的答案。"
  },
  CollectionHall_117975_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117975_Title = {
    Text = "献给春天的花束"
  },
  CollectionHall_117976_Desc = {
    Text = "阳光透过花房的玻璃照在奥尔拉的脸上。她穿过阳光，来到睡意朦胧的奥尔拉身前。\n每次唤醒她的时候，她都将玫瑰藏于身后。"
  },
  CollectionHall_117976_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117976_Title = {
    Text = "花房晨曦"
  },
  CollectionHall_117977_Desc = {
    Text = "她将花园的故事写入诗页。\n她将花园的故事投入火堆。"
  },
  CollectionHall_117977_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117977_Title = {
    Text = "诗页的余烬"
  },
  CollectionHall_117978_Desc = {
    Text = "没有贫穷、饥饿、疾病、背叛。那是只有花与诗的西岱，那是只属于她们的乐土。"
  },
  CollectionHall_117978_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117978_Title = {
    Text = "幻想乐土"
  },
  CollectionHall_117979_Desc = {
    Text = "如果第一幕出现了一支枪，它在最后就会响。\n你已经构思好重逢时，要向她诉说的故事。\n那是一个梦，梦的开始坠落了一枚明亮的太阳，梦的结局坠落了一枚漆黑的太阳。"
  },
  CollectionHall_117979_LockTip = {
    Text = "完成异梦视界「再见永无乡」困难难度"
  },
  CollectionHall_117979_Title = {
    Text = "坠落的太阳"
  },
  CollectionHall_117980_Desc = {
    Text = "蜜酿已经斟满，贵客已经到场，请为勒姆瓦希带来新的种子，请尽情欢享浸透欲望的热情！"
  },
  CollectionHall_117980_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117980_Title = {
    Text = "情热时分"
  },
  CollectionHall_117981_Desc = {
    Text = "时间、生息、虚无、命运。\n所有晦涩的梦境，空茫的现实，平等地汇进洪流，消若无迹，一往无前，往海中去。"
  },
  CollectionHall_117981_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_117981_Title = {Text = "归向海"},
  CollectionHall_117982_Desc = {
    Text = "她在沙中踏出黑色涟漪，她牵引你、捉住你，把种种从荒芜中托寄给你。\n今晚的月亮遮掩了一个华美晦涩的秘密，她既在舞中解答你的疑惑，也以一舞留给你更多谜题。"
  },
  CollectionHall_117982_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117982_Title = {
    Text = "银沙海之舞"
  },
  CollectionHall_117983_Desc = {
    Text = "给予叛逆者以宠溺，祂恶趣味的牺牲品，也分享了祂的恶习。"
  },
  CollectionHall_117983_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_117983_Title = {
    Text = "拷贝恶习"
  },
  CollectionHall_117984_Desc = {
    Text = "噩兆与乐音交织降临，他亦敌亦友，他扑朔迷离。"
  },
  CollectionHall_117984_LockTip = {
    Text = "完成调查行动8-14解锁"
  },
  CollectionHall_117984_Title = {
    Text = "命运前奏之曲"
  },
  CollectionHall_117985_Desc = {
    Text = "捕捉每一个音符，落在正确的节奏上。\n小心，注意，面对挑剔的指挥家，行差踏错会让你落入万劫不复的境地。"
  },
  CollectionHall_117985_LockTip = {
    Text = "完成调查行动8-14解锁"
  },
  CollectionHall_117985_Title = {
    Text = "踏对节拍"
  },
  CollectionHall_117986_Desc = {
    Text = "用一朵玫瑰，来换一首诗吧。\n在人们荒寂的心脏里，玫瑰正殷红地栖居。"
  },
  CollectionHall_117986_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」困难难度"
  },
  CollectionHall_117986_Title = {
    Text = "玫瑰啊，玫瑰"
  },
  CollectionHall_117987_Desc = {
    Text = "我们为您准备了一个完美的假期，包括沙滩、阳光、排球赛，旧朋友和新朋友。\n请务必做好防晒，如果太阳从天空坠落，不用惊慌失措，这是正常现象。"
  },
  CollectionHall_117987_LockTip = {
    Text = "完成异梦视界「再见永无乡」"
  },
  CollectionHall_117987_Title = {
    Text = "伦蒂尼恩之夏"
  },
  CollectionHall_117988_Desc = {
    Text = "你既不擅长音乐，也不喜欢解谜。\n但他平静且优雅地将你编织进交响，神秘而失礼地抛出了他的谜语。"
  },
  CollectionHall_117988_LockTip = {
    Text = "完成调查行动8-14解锁"
  },
  CollectionHall_117988_Title = {
    Text = "指挥家的谜语"
  },
  CollectionHall_117989_Desc = {
    Text = "可怜的、狂妄的、不知天高地厚的狼。\n他和其他客人一起被扔在了休息室，在一场短暂安宁的赌局里。\n失去了习以为常的好运气，他输掉了超过一万雷欧坊。"
  },
  CollectionHall_117989_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_117989_Title = {Text = "坏牌"},
  CollectionHall_117990_Desc = {
    Text = "一样的礼帽，一样的玫瑰，一样的笑声。\n帷幕已经拉起，观众已经就位，来吧，来吧，来找一找，凶手是从黑雾中掉出的哪一位？"
  },
  CollectionHall_117990_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_117990_Title = {Text = "小小的N"},
  CollectionHall_117991_Desc = {
    Text = "好的日常总是要由噩梦开始，在墓园结束。\n哦，这就是生活，甜美的生活。"
  },
  CollectionHall_117991_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」困难难度"
  },
  CollectionHall_117991_Title = {
    Text = "哦，生活"
  },
  CollectionHall_117992_Desc = {
    Text = "握住我的手吧。\n当手指相碰的时候，我将赠你一个春天。"
  },
  CollectionHall_117992_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_117992_Title = {
    Text = "两个人的春日"
  },
  CollectionHall_117993_Desc = {
    Text = "一次突然的造访，一次体贴的造访，一次幸福的造访。\n是相似的朋友，是不相似的朋友。\n哦，朋友，朋友，每个人都需要朋友。我要用什么来招待你，我的朋友？"
  },
  CollectionHall_117993_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_117993_Title = {
    Text = "不相似的朋友"
  },
  CollectionHall_117994_Desc = {
    Text = "棺材里爬出的轮盘赌，雪夜里穷追不舍的过去。\n开一局，再一局，狼的皮毛和好运气，会带来一个阳光明媚的下周一。"
  },
  CollectionHall_117994_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_117994_Title = {
    Text = "狼的下周一"
  },
  CollectionHall_117995_Desc = {
    Text = "亚兰的子民行遍了大漠，他们生于此，他们长于此，他们注定要繁荣于此处，注定要消亡于此处。"
  },
  CollectionHall_117995_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117995_Title = {
    Text = "丰穰的末路"
  },
  CollectionHall_117996_Desc = {
    Text = "好孩子，乖宝贝，圣河会安抚你夭折的啼哭，圣河会托抱你流逝的魂灵。"
  },
  CollectionHall_117996_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_117996_Title = {
    Text = "还于圣河"
  },
  CollectionHall_117997_Desc = {
    Text = "花园的残屑与往事的灰烬落在这片小小的土地上。它们在悲哀的回忆里漫天飘扬，它们在狂热的野心里烟消云散。"
  },
  CollectionHall_117997_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」困难难度"
  },
  CollectionHall_117997_Title = {
    Text = "花园往事"
  },
  CollectionHall_117998_Desc = {
    Text = "诡谲将艺术家的灵感饲育，生长，生长，画师用色彩将真实解构，癫和痴在凌乱线条中生长。"
  },
  CollectionHall_117998_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_117998_Title = {
    Text = "前沿艺术"
  },
  CollectionHall_117999_Desc = {
    Text = "有一个地方只能在仲夏夜梦境中到达，那是我们得以重聚的永无乡。"
  },
  CollectionHall_117999_LockTip = {
    Text = "完成异梦视界「再见永无乡」"
  },
  CollectionHall_117999_Title = {
    Text = "永无乡假日"
  },
  CollectionHall_118000_Desc = {
    Text = "画家已寻觅到那恐怖的艺术，他掀开绘布，在投身前，邀友人赴一场色彩爆炸的癫狂奇旅。"
  },
  CollectionHall_118000_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_118000_Title = {
    Text = "疯画奇旅"
  },
  CollectionHall_118001_Desc = {
    Text = "祂们拥抱着血脉、手足、爱人、挚友，他们献出自我，消融进一场黑甜的复生。\n祂们的骨归于母树，祂们的肉淌入圣河。"
  },
  CollectionHall_118001_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_118001_Title = {Text = "母亲"},
  CollectionHall_118002_Desc = {
    Text = "炽烈的太阳快要死去了，风裹挟砂砾将它熄灭。\n沉坠的太阳落下了，落向天与沙的交界。"
  },
  CollectionHall_118002_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_118002_Title = {
    Text = "坠往黄沙"
  },
  CollectionHall_118003_Desc = {
    Text = "为何一场大火就能烧毁所有的誓言？\n为何在诗歌的世界里也充满了苦难？"
  },
  CollectionHall_118003_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_118003_Title = {
    Text = "对立的修辞"
  },
  CollectionHall_118004_Desc = {
    Text = "溯源之途，以生命垒砌，向它咆哮，抵御不可违背的伟力。将血脉还于亚兰，将丰穰还于亚兰！"
  },
  CollectionHall_118004_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_118004_Title = {
    Text = "风暴之壁"
  },
  CollectionHall_118005_Desc = {
    Text = "这是真实，这是狂魇，这是暗面，这是梦境。\n疯子和天才交替着喃喃低语，细些，再细些——不要挪开你的眼睛。"
  },
  CollectionHall_118005_LockTip = {
    Text = "完成意识潜游「畸世绘」"
  },
  CollectionHall_118005_Title = {
    Text = "步入迷乱"
  },
  CollectionHall_118006_Desc = {
    Text = "极寒，诡计，大雪，全都扰乱不了野兽的嗅觉。"
  },
  CollectionHall_118006_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  CollectionHall_118006_Title = {Text = "嗅觉"},
  CollectionHall_118007_Desc = {
    Text = "提高警惕，不是只有老伙计会用靴子狠狠踢你的……排球。"
  },
  CollectionHall_118007_LockTip = {
    Text = "完成异梦视界「再见永无乡」"
  },
  CollectionHall_118007_Title = {Text = "新伙计"},
  CollectionHall_118008_Desc = {
    Text = "不不不不不不不，梭哈不是为了赢。\n梭哈的重点就是梭哈，梭哈就是为了梭哈。"
  },
  CollectionHall_118008_LockTip = {
    Text = "完成特遣纪录「狩猎愉快！」困难难度"
  },
  CollectionHall_118008_Title = {
    Text = "名侦探的梭哈"
  },
  CollectionHall_118009_Desc = {
    Text = "近了，那死的神灵，终的吐息，传奇但未为众知的过往，凝窒而轻描淡写的别离。"
  },
  CollectionHall_118009_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_118009_Title = {
    Text = "先驱者的丧钟"
  },
  CollectionHall_118010_Desc = {
    Text = "自她口中降下的，是神谕抑或王旨，是天恩抑或私心。\n树魂与傀儡共鸣，许诺她永恒孤独的空寂。"
  },
  CollectionHall_118010_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_118010_Title = {
    Text = "无声神谕"
  },
  CollectionHall_118011_Desc = {
    Text = "我已遗忘祂的身形，我已遗忘祂的名姓。\n但我将抛却私心，我愿化为银蚁，待祂归返，待祂重临。\n待她将我拥入怀中，待她否认那声叹息。"
  },
  CollectionHall_118011_LockTip = {
    Text = "完成调查行动·困难7-12解锁"
  },
  CollectionHall_118011_Title = {
    Text = "为已逝者"
  },
  CollectionHall_118012_Desc = {
    Text = "花园的草地上，她们仰望云朵随着风变幻。\n柯蕾特，你看，那两朵追逐的云彩，是蝴蝶夫人与毛毛虫先生正在跳舞。"
  },
  CollectionHall_118012_LockTip = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  CollectionHall_118012_Title = {
    Text = "如彩云相逐"
  },
  CollectionHall_118013_Desc = {
    Text = "无人铭记她的过往，无人知晓她的耳语。\n她贴近命定之人，呼吸织缠，形影相依。\n俯首，引颈。"
  },
  CollectionHall_118013_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_118013_Title = {
    Text = "她愿引颈"
  },
  CollectionHall_118014_Desc = {
    Text = "请闭眼，让吻落在指间。\n因她对你如此倾心，因漫长的旅程或会使你疲惫，却不会使你犹疑。"
  },
  CollectionHall_118014_LockTip = {
    Text = "完成调查行动7-19解锁"
  },
  CollectionHall_118014_Title = {Text = "眼"},
  CollectionHall_118015_Desc = {
    Text = "人总是容易在黄昏时陷入恍惚与沉默，因为所剩无几的太阳，因为尚未被消耗殆尽的好时光。"
  },
  CollectionHall_118015_LockTip = {
    Text = "完成调查行动8-14解锁"
  },
  CollectionHall_118015_Title = {Text = "薄暮"},
  CollectionHall_118558_LockTip = {
    Text = "可于调查行动6-6中解锁"
  },
  CollectionHall_118558_Title = {
    Text = "生命自有出路"
  },
  CollectionHall_118559_LockTip = {
    Text = "可于调查行动3-7中解锁"
  },
  CollectionHall_118559_Title = {
    Text = "虚实通信"
  },
  CollectionHall_118563_LockTip = {
    Text = "可于调查行动4-10中解锁"
  },
  CollectionHall_118563_Title = {
    Text = "墙中之鼠"
  },
  CollectionHall_118565_LockTip = {
    Text = "可于调查行动5-7中解锁"
  },
  CollectionHall_118565_Title = {
    Text = "好运筹码"
  },
  CollectionHall_118566_Desc = {
    Text = "记载内容包含七十个梅森质数。"
  },
  CollectionHall_118566_LockTip = {
    Text = "可于活动「颠倒的新生」中解锁"
  },
  CollectionHall_118566_Title = {
    Text = "<OrangeQuality:奥涯手记>"
  },
  CollectionHall_118567_Desc = {
    Text = "它将竖起一道厚厚的障壁，将风雨和霉运挡在外面。"
  },
  CollectionHall_118567_LockTip = {
    Text = "可于莱克试玩关卡中解锁"
  },
  CollectionHall_118567_Title = {
    Text = "<OrangeQuality:幸运风衣>"
  },
  CollectionHall_118568_LockTip = {
    Text = "可于调查行动6-3中解锁"
  },
  CollectionHall_118568_Title = {
    Text = "低音风铃"
  },
  CollectionHall_118570_Desc = {
    Text = "命运流转，亘古不息。"
  },
  CollectionHall_118570_LockTip = {
    Text = "可于活动「织者自缚」中解锁"
  },
  CollectionHall_118570_Title = {
    Text = "<OrangeQuality:命运纺轮>"
  },
  CollectionHall_118572_LockTip = {
    Text = "可于调查行动7-18中解锁"
  },
  CollectionHall_118572_Title = {
    Text = "被遗忘的时间"
  },
  CollectionHall_118573_Desc = {
    Text = "摇摆无序的时间。"
  },
  CollectionHall_118573_LockTip = {
    Text = "可于幻梦深潜中解锁"
  },
  CollectionHall_118573_Title = {
    Text = "<OrangeQuality:时灵摆>"
  },
  CollectionHall_118574_LockTip = {
    Text = "可于调查行动4-13中解锁"
  },
  CollectionHall_118574_Title = {Text = "恶徒"},
  CollectionHall_118577_Desc = {
    Text = "纵使经历暗淡，救世的提灯终将于死亡中再度长明。"
  },
  CollectionHall_118577_LockTip = {
    Text = "可于活动「极昼的终夜」中解锁"
  },
  CollectionHall_118577_Title = {
    Text = "<OrangeQuality:救世圣灯>"
  },
  CollectionHall_118578_Desc = {
    Text = "引入幻梦。"
  },
  CollectionHall_118578_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_118578_Title = {
    Text = "<OrangeQuality:噩梦魂灯>"
  },
  CollectionHall_118580_Desc = {
    Text = "苍白之子即将诞生时的鼓动。\n小心，它们马上就要来了。"
  },
  CollectionHall_118580_LockTip = {
    Text = "可于活动「伟大的征服」中解锁"
  },
  CollectionHall_118580_Title = {
    Text = "<OrangeQuality:苍白之卵>"
  },
  CollectionHall_118583_Desc = {
    Text = "「海洋生物惯于断臂求生。」"
  },
  CollectionHall_118583_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_118583_Title = {
    Text = "<RedQuality:长生者血肉>"
  },
  CollectionHall_118584_Desc = {
    Text = "如今，这片羽毛再也不能于天空上翱翔。"
  },
  CollectionHall_118584_LockTip = {
    Text = "可于活动「镜像囚徒」中解锁"
  },
  CollectionHall_118584_Title = {
    Text = "<OrangeQuality:受诅的羽毛>"
  },
  CollectionHall_118585_Desc = {
    Text = "今日，我们将忘记恐惧，忘记沉痛，只享受狂欢。"
  },
  CollectionHall_118585_LockTip = {
    Text = "可于活动「黑阳垂照的永夏」中解锁"
  },
  CollectionHall_118585_Title = {
    Text = "<OrangeQuality:弥萨格夺冠金杯>"
  },
  CollectionHall_118586_Desc = {
    Text = "有时候你窥视镜中，看见的却是来自回忆的影子。"
  },
  CollectionHall_118586_LockTip = {
    Text = "可于调查行动星辰篇第1章「重临雾都」中解锁"
  },
  CollectionHall_118586_Title = {
    Text = "<OrangeQuality:维度影像>"
  },
  CollectionHall_118592_LockTip = {
    Text = "可于调查行动7-11中解锁"
  },
  CollectionHall_118592_Title = {
    Text = "无能为力"
  },
  CollectionHall_118595_Desc = {
    Text = "异世迷雾中夹杂的回音，通往扭曲、癫狂和不可质疑的真实。"
  },
  CollectionHall_118595_LockTip = {
    Text = "可于活动「雾境的燔礼」中解锁"
  },
  CollectionHall_118595_Title = {
    Text = "<OrangeQuality:彼世回声>"
  },
  CollectionHall_118596_Desc = {
    Text = "叮铃，叮铃，孩子在哭闹；\n叮铃，叮铃，孩子在尖叫。\n叮铃，叮铃，孩子在哀嚎；\n叮铃，叮铃，它饿了，你知道。"
  },
  CollectionHall_118596_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_118596_Title = {
    Text = "<RedQuality:哀嚎摇铃>"
  },
  CollectionHall_118597_Desc = {
    Text = "「仿照利莫里亚工艺打造了这枚香炉，愿它能助您夜夜安寝。弥利亚姆留。」"
  },
  CollectionHall_118597_LockTip = {
    Text = "可于活动「神诞的祭礼」中解锁"
  },
  CollectionHall_118597_Title = {
    Text = "<OrangeQuality:黄铜香炉>"
  },
  CollectionHall_118599_Desc = {
    Text = "大嘴纽扣喜爱一切圆圆的事物，例如月亮、筹码和新鲜的眼球。\n会在月圆之夜口吐黑雾，原因不明。"
  },
  CollectionHall_118599_LockTip = {
    Text = "可于莱克试玩关卡中解锁"
  },
  CollectionHall_118599_Title = {
    Text = "<OrangeQuality:大嘴纽扣>"
  },
  CollectionHall_118600_LockTip = {
    Text = "可于特遣纪录「血的颜色」的「我们的过错」中解锁"
  },
  CollectionHall_118600_Title = {
    Text = "未来泥沼"
  },
  CollectionHall_118602_LockTip = {
    Text = "敬请期待"
  },
  CollectionHall_118602_Title = {
    Text = "灵魂游戏"
  },
  CollectionHall_118603_Desc = {
    Text = "「来，听我说。」\n「让我将你的记忆与梦。」\n「制作成无比美味的甜点。」"
  },
  CollectionHall_118603_LockTip = {
    Text = "可于活动「埋于记忆之下」中解锁"
  },
  CollectionHall_118603_Title = {
    Text = "<OrangeQuality:「记忆」与「梦」>"
  },
  CollectionHall_118604_Desc = {
    Text = "闪闪发光的不仅是外表，还有坚韧不拔的内心。\n凝视它超过五秒钟，你将招来@2。"
  },
  CollectionHall_118604_LockTip = {
    Text = "可于莱克试玩关卡中解锁"
  },
  CollectionHall_118604_Title = {
    Text = "<OrangeQuality:偏方骰子>"
  },
  CollectionHall_118605_Desc = {
    Text = "徒劳者恐惧变化，恐惧事物超出掌控，在最深层的地方，他歇斯底里地恐惧着失去。\n 他一次次地吹响哨子，想要通过哨音控制所有，但他没能留住任何东西。"
  },
  CollectionHall_118605_LockTip = {
    Text = "可于活动「永远的厄波扬斯」中解锁"
  },
  CollectionHall_118605_Title = {
    Text = "<OrangeQuality:徒劳者的挣扎>"
  },
  CollectionHall_118606_LockTip = {
    Text = "可于调查行动星辰篇4-11中解锁"
  },
  CollectionHall_118606_Title = {Text = "密语"},
  CollectionHall_118607_Desc = {
    Text = "闪烁的雷光将指引前进的方向。"
  },
  CollectionHall_118607_LockTip = {
    Text = "可于活动「于暴雨中摇曳」中解锁"
  },
  CollectionHall_118607_Title = {
    Text = "<OrangeQuality:伊拉斯莫的指引>"
  },
  CollectionHall_118609_Desc = {
    Text = "纤细的指挥棒，却拥有比撬棍更强大的力量。\n指挥音符、指挥灵魂、指挥命运。"
  },
  CollectionHall_118609_LockTip = {
    Text = "可于活动「无形交响」中解锁"
  },
  CollectionHall_118609_Title = {
    Text = "<OrangeQuality:乐团指挥棒>"
  },
  CollectionHall_118610_Desc = {
    Text = "它并非带来寒冷。\n它只是提醒大地，冬天从未离去。"
  },
  CollectionHall_118610_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_118610_Title = {
    Text = "<OrangeQuality:冰域晶核>"
  },
  CollectionHall_118611_Desc = {
    Text = "漆黑的火焰将贯彻她的意志，将一切焚烧殆尽。"
  },
  CollectionHall_118611_LockTip = {
    Text = "可于活动「坠临的万千耀光」中解锁"
  },
  CollectionHall_118611_Title = {
    Text = "<OrangeQuality:深暗之焰>"
  },
  CollectionHall_118612_LockTip = {
    Text = "可于调查行动3-12中解锁"
  },
  CollectionHall_118612_Title = {
    Text = "致我亲爱的"
  },
  CollectionHall_118613_LockTip = {
    Text = "可于调查行动7-4中解锁"
  },
  CollectionHall_118613_Title = {Text = "海马回"},
  CollectionHall_118615_Desc = {
    Text = "她们不再去争夺爱。"
  },
  CollectionHall_118615_LockTip = {
    Text = "可于活动「海城旧闻」中解锁"
  },
  CollectionHall_118615_Title = {
    Text = "<OrangeQuality:姨娘的派头>"
  },
  CollectionHall_118616_LockTip = {
    Text = "可于特遣纪录「宁静的裂殖」的「满贯定约」中解锁"
  },
  CollectionHall_118616_Title = {
    Text = "解体与相融"
  },
  CollectionHall_118617_LockTip = {
    Text = "可于意识潜游「燃烧的群宴」的「死亡、蜜酒与歌之夜」中解锁"
  },
  CollectionHall_118617_Title = {
    Text = "强运游戏"
  },
  CollectionHall_118620_Desc = {
    Text = "甜美而贵重……吗？"
  },
  CollectionHall_118620_LockTip = {
    Text = "可于活动「新月与深雪」中解锁"
  },
  CollectionHall_118620_Title = {
    Text = "<OrangeQuality:皇家玛丽巧克力>"
  },
  CollectionHall_118621_LockTip = {
    Text = "可于调查行动6-14中解锁"
  },
  CollectionHall_118621_Title = {Text = "同频"},
  CollectionHall_118622_LockTip = {
    Text = "可于调查行动4-5中解锁"
  },
  CollectionHall_118622_Title = {Text = "墙外"},
  CollectionHall_118623_Desc = {
    Text = "仔细看清楚你的心，不要做出错误的选择。"
  },
  CollectionHall_118623_LockTip = {
    Text = "可于活动「如果一切如常」中解锁"
  },
  CollectionHall_118623_Title = {
    Text = "<OrangeQuality:心灵剖析>"
  },
  CollectionHall_118625_LockTip = {
    Text = "可于调查行动星辰篇4-15中解锁"
  },
  CollectionHall_118625_Title = {
    Text = "不协和音"
  },
  CollectionHall_118627_Desc = {
    Text = "利维坦的骸骨庇佑着祂所选定之人，所向披靡，不死不灭。"
  },
  CollectionHall_118627_LockTip = {
    Text = "可于活动「贪戮角逐」中解锁"
  },
  CollectionHall_118627_Title = {
    Text = "<OrangeQuality:鲸骸之铠>"
  },
  CollectionHall_118628_Desc = {
    Text = "在异象中，我们将见证「艺术」的诞生。"
  },
  CollectionHall_118628_LockTip = {
    Text = "可于活动「画布的暗面」中解锁"
  },
  CollectionHall_118628_Title = {
    Text = "<OrangeQuality:异象调色盘>"
  },
  CollectionHall_118629_LockTip = {
    Text = "可于调查行动6-11中解锁"
  },
  CollectionHall_118629_Title = {
    Text = "无罪记录"
  },
  CollectionHall_118630_LockTip = {
    Text = "可于调查行动星辰篇3-5中解锁"
  },
  CollectionHall_118630_Title = {
    Text = "思维的疮"
  },
  CollectionHall_118631_Desc = {
    Text = "莫丝女士强硬地说这就是造物。\n「坏人，咬他！」"
  },
  CollectionHall_118631_LockTip = {
    Text = "可于活动「默斯克斯的呼唤」中解锁"
  },
  CollectionHall_118631_Title = {
    Text = "<OrangeQuality:小煤球二世>"
  },
  CollectionHall_118633_Desc = {
    Text = "「血月高升，群骸当举杯共饮。」"
  },
  CollectionHall_118633_LockTip = {
    Text = "可于活动「死灵的美学」中解锁"
  },
  CollectionHall_118633_Title = {
    Text = "<OrangeQuality:骸骨杯盏>"
  },
  CollectionHall_118636_Desc = {
    Text = "信函上文字不断变化，始终化为无法拒绝的渴求。"
  },
  CollectionHall_118636_LockTip = {
    Text = "可于活动「雨镇幽影」中解锁"
  },
  CollectionHall_118636_Title = {
    Text = "<OrangeQuality:千面邀请函>"
  },
  CollectionHall_120344_Title = {
    Text = "你我终将重逢"
  },
  CollectionHall_120463_LockTip = {
    Text = "可于调查行动4-15中解锁"
  },
  CollectionHall_120463_Title = {
    Text = "记录无罪"
  },
  CollectionHall_120464_LockTip = {
    Text = "敬请期待"
  },
  CollectionHall_120464_Title = {
    Text = "贪吃钱包"
  },
  CollectionHall_120465_LockTip = {
    Text = "可于调查行动4-5中解锁"
  },
  CollectionHall_120465_Title = {
    Text = "咔吱作响"
  },
  CollectionHall_120466_LockTip = {
    Text = "可于调查行动3-10中解锁"
  },
  CollectionHall_120466_Title = {
    Text = "无声电报"
  },
  CollectionHall_121154_Title = {Text = "乐园"},
  CollectionHall_121341_Desc = {
    Text = "<Title:简介>\n接纳孕育「圣婴」职责的「王女」，现如今已是蹈海者教内举足轻重的「神母」。\n她也曾经是奔向自由的淑女，和弥萨格所记录的墨菲一样踏上索纳尼尔号的逃亡旅程。\n但在不存在守密人的世界里，命运折断了年幼天鹅高贵的颈项。\n倒错的血脉不由分说不由抵抗地纠缠着她，即便放任躯体死亡也不能幸免。她强撑场面说出一句又一句「我是尊贵的神母」，都只是对自己的暗示与说服。\n只能服从、只有服从。服从虚妄的神谕，服从荒诞的命运，然后从无尽的苦涩中，勉强回味到那一丝幻想的甘甜。"
  },
  CollectionHall_121341_LockTip = {
    Text = "唤醒「诞妄·墨菲」后解锁"
  },
  CollectionHall_121341_Title = {
    Text = "诞妄·墨菲"
  },
  CollectionHall_121381_Desc = {
    Text = "你用一千颗橡果交换了一个来自异界的故事。\n一个关于英雄与魔神，守望与坚持的故事。\n一个关于无奈与不舍，旧朋友与新朋友的故事。\n一个曾经来过的故事。"
  },
  CollectionHall_121381_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121381_Title = {
    Text = "万象旅店的回响"
  },
  CollectionHall_121382_Desc = {
    Text = "很久很久以后，他与他终于有了一首被传唱的吟游诗。\n关于死而复苏的救赎，关于一体双生的灵魂。"
  },
  CollectionHall_121382_LockTip = {
    Text = "完成异梦视界「天边之外·下」"
  },
  CollectionHall_121382_Title = {
    Text = "无翅鸟之诗"
  },
  CollectionHall_121383_Desc = {
    Text = "少年为短暂的一切，付出了被索偿的代价。\n如今，只剩静默的权柄与他相伴。\n王要睡去了，他在梦中迎来世界的尽头。"
  },
  CollectionHall_121383_LockTip = {
    Text = "完成意识潜游「加冕之日」"
  },
  CollectionHall_121383_Title = {
    Text = "无边苦寂的王土"
  },
  CollectionHall_121384_Desc = {
    Text = "她们围绕着你，她们敬慕着你，她们陪伴着你。\n她们向创世神扬帆。"
  },
  CollectionHall_121384_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121384_Title = {
    Text = "向创世神扬帆"
  },
  CollectionHall_121385_Desc = {
    Text = "那是一双由摧折中重生的羽翼，那是一双以牺牲换来自由的羽翼。\n命运的预言已经应验了，他在悔痛中起誓，血债要以血来偿。"
  },
  CollectionHall_121385_LockTip = {
    Text = "完成异梦视界「天边之外·下」"
  },
  CollectionHall_121385_Title = {
    Text = "暴风起时"
  },
  CollectionHall_121386_Desc = {
    Text = "荒诞与混沌的梦境伊始之初，祂就注定会面对祂的宿命。\n但祂已经历了太多，也定义了太多。\n祂已决意以人类能够保持的最大理智，注视自己的起源，那至高的神祇。"
  },
  CollectionHall_121386_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121386_Title = {
    Text = "原初宿命之战"
  },
  CollectionHall_121387_Desc = {
    Text = "得到、失去、斩断、牺牲。\n英雄付出了全部全部的代价，庇护珍宝的权柄即是祂的报偿。"
  },
  CollectionHall_121387_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121387_Title = {
    Text = "无目之瞳"
  },
  CollectionHall_121388_Desc = {
    Text = "他以王冠加诸己身，他以镣铐加诸己身。\n那是短暂虚幻的暖意，那是注定覆灭的往日荣光。"
  },
  CollectionHall_121388_LockTip = {
    Text = "完成意识潜游「加冕之日」"
  },
  CollectionHall_121388_Title = {
    Text = "幼王的孤途"
  },
  CollectionHall_121389_Desc = {
    Text = "尽管局面对你不利，但你的嘴角已经微微扬起。\n“我的回合，抽卡！”\n不管是在万象旅店还是在弥萨格，\n小看辅助的伤害能力可都是要吃大亏的啊！伊格娜蒂丝！"
  },
  CollectionHall_121389_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121389_Title = {
    Text = "属于我的逆转时刻！"
  },
  CollectionHall_121390_Desc = {
    Text = "一个完整的传奇不能缺少化敌为友。"
  },
  CollectionHall_121390_LockTip = {
    Text = "完成调查行动·困难9-10解锁"
  },
  CollectionHall_121390_Title = {
    Text = "敌人，友人"
  },
  CollectionHall_121391_Desc = {
    Text = "从今往后，你将以守密人的称号，与万万千千的弥萨格师生同在。"
  },
  CollectionHall_121391_LockTip = {
    Text = "完成调查行动·困难9-11解锁"
  },
  CollectionHall_121391_Title = {Text = "K-0617"},
  CollectionHall_121392_Desc = {
    Text = "我们或许是亘古中的转瞬，狂流中的砂砾。\n然而常世便是我们珍贵的永恒，因为无论世界如何疯狂混乱——\n人类的尊严，会建立于理性的光辉之上。"
  },
  CollectionHall_121392_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121392_Title = {Text = "常世颂"},
  CollectionHall_121393_Desc = {
    Text = "勇者们一头扑进了童话，每一个童话都一样，动物、魔鬼、仙女和未知的彼方。\n越过短暂的自由和虚假的想往，童话的尽头，藏着一颗被强加于他的假心脏。"
  },
  CollectionHall_121393_LockTip = {
    Text = "完成异梦视界「天边之外·下」"
  },
  CollectionHall_121393_Title = {
    Text = "飞入星河"
  },
  CollectionHall_121394_Desc = {
    Text = "这里是位于异世界时空裂隙之中的万象旅店。\n连接着不同宇宙的传送门，闪烁着浩瀚的星光，欢迎着你的到来。\n等等……这是给咱守密人干哪儿来了？"
  },
  CollectionHall_121394_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121394_Title = {
    Text = "欢迎来到万象旅店！"
  },
  CollectionHall_121395_Desc = {
    Text = "弥萨格的利刃会为你取得这场对弈的胜利。\n你和搭档之间的羁绊坚不可摧。\n哪怕你们有一天身处于不同宇宙，也一定无法改变这一点。"
  },
  CollectionHall_121395_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121395_Title = {
    Text = "弥萨格利刃！"
  },
  CollectionHall_121396_Desc = {
    Text = "“每日试训没有做？不如先来一盘万象牌吧！”\n“融灾禁区没有打？不如先来一盘万象牌吧！”\n“这是相位对弈，不是万象牌！一千颗橡果我会收集给你看的！”"
  },
  CollectionHall_121396_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121396_Title = {
    Text = "一起来玩万象牌吧！"
  },
  CollectionHall_121397_Desc = {
    Text = "呼唤我的名字，在被遗忘的黎明之前。"
  },
  CollectionHall_121397_LockTip = {
    Text = "完成调查行动·困难9-11解锁"
  },
  CollectionHall_121397_Title = {
    Text = "来自遗忘@2"
  },
  CollectionHall_121398_Desc = {
    Text = "“快来跟我签订契约，成为卡牌大师吧！”\n这位来自异世界的龙族美少女向你发出了热情而莫名其妙的邀请。\n为了让这个相位空间的小意外尽快回复正常，你别无选择。"
  },
  CollectionHall_121398_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121398_Title = {
    Text = "老板娘，伊格娜蒂丝！"
  },
  CollectionHall_121399_Desc = {
    Text = "后来者会在沉重的馈赠下，找到这么一行脚注。\n唯一逃避当英雄的人成为了英雄，珍视朋友的孩子只剩下唯一的朋友。"
  },
  CollectionHall_121399_LockTip = {
    Text = "完成意识潜游「加冕之日」"
  },
  CollectionHall_121399_Title = {
    Text = "余将独行"
  },
  CollectionHall_121400_Desc = {
    Text = "脱离主，直面主，忤逆主。\n你的故事无人知晓，你的记忆与世长存。"
  },
  CollectionHall_121400_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121400_Title = {
    Text = "创世痴愚之主"
  },
  CollectionHall_121401_Desc = {
    Text = "一切都不再有意义，因此你得以站在这里。\n一切曾经的过往，就是你所定义的全部的意义，所以你站在了这里。"
  },
  CollectionHall_121401_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121401_Title = {
    Text = "存在主义"
  },
  CollectionHall_121402_Desc = {
    Text = "通向祂们的小径，远离祂们的小径。\n一切即将分别，一切即将终结，一切即将伊始。\n门扉前的身影自此开始了漫长的等待，等待银钥指引你的归途。"
  },
  CollectionHall_121402_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121402_Title = {
    Text = "通向祂们的小径"
  },
  CollectionHall_121403_Desc = {
    Text = "祂们的可能性线条，分离、收束、崩散。\n直到迎来了唯一的救世主，直到终于迈入了唯一的终局。"
  },
  CollectionHall_121403_LockTip = {
    Text = "完成调查行动·困难9-10解锁"
  },
  CollectionHall_121403_Title = {
    Text = "唯一的终局"
  },
  CollectionHall_121404_Desc = {
    Text = "幼王接受了这笔交易。\n他说，我的国将安然无恙。"
  },
  CollectionHall_121404_LockTip = {
    Text = "完成意识潜游「加冕之日」"
  },
  CollectionHall_121404_Title = {Text = "加冕"},
  CollectionHall_121405_Desc = {
    Text = "这片破碎的时空裂隙之中曾经坐落着传说中的万象旅店。\n曾经连接着不同宇宙的传送门，曾经闪烁着浩瀚的星光，曾经欢迎着每一位卡牌大师的到来。\n而你，是这一切存在过的证明。"
  },
  CollectionHall_121405_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121405_Title = {
    Text = "再见了，卡牌大师！"
  },
  CollectionHall_121406_Desc = {
    Text = "主看向你，你刺破了主的眼睛。"
  },
  CollectionHall_121406_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121406_Title = {
    Text = "终焉凝注"
  },
  CollectionHall_121407_Desc = {
    Text = "战士、复仇者、奴隶、主人、商人。\n相同的立场？不同的立场？相同的立场。"
  },
  CollectionHall_121407_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121407_Title = {
    Text = "多重性战歌"
  },
  CollectionHall_121408_Desc = {
    Text = "你知道，你没有在为什么伟大的事情作战。\n为了逃课，为了作业，为了甜点，为了朋友，为了火炉，为了虚度时光。\n你只是一个平凡的，为平日赴死之人。"
  },
  CollectionHall_121408_LockTip = {
    Text = "完成调查行动·困难9-11解锁"
  },
  CollectionHall_121408_Title = {
    Text = "为平日赴死之人"
  },
  CollectionHall_121409_Desc = {
    Text = "动物，所有的高等动物，都难以避免地被社群行为所控。\n然而她亲身奔赴死亡，如愿解构真相。\n一名疯狂的、绝世的天才，她宁愿亲手引来毁灭，她恩赐众生免于吞食名为希望的砒霜。"
  },
  CollectionHall_121409_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121409_Title = {
    Text = "社群行为解构"
  },
  CollectionHall_121410_Desc = {
    Text = "祂从高天送来源源不断的苦水，汇聚，汇聚。\n最终横亘成我们血肉交融之前，注定要溯及的那条河流。"
  },
  CollectionHall_121410_LockTip = {
    Text = "完成异梦视界「天边之外·下」"
  },
  CollectionHall_121410_Title = {Text = "苦河流"},
  CollectionHall_121411_Desc = {
    Text = "祂们以重逢的预期告别。\n因这是一位至珍者，因这是一场并非命定的至珍者之死。"
  },
  CollectionHall_121411_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121411_Title = {
    Text = "一位至珍者之死"
  },
  CollectionHall_121412_Desc = {
    Text = "休息一下，喘口气吧。\n即使面对的课题是世界末日，也不是每个人都有机会同时面对三位如此重磅级的导师。"
  },
  CollectionHall_121412_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121412_Title = {
    Text = "剧幕中场"
  },
  CollectionHall_121413_Desc = {
    Text = "一千颗橡果的故事，总要由第一颗开始。\n在相位对弈中，你每打出一张卡牌，\n伊格娜蒂丝的眸中便莫名掠过一缕金色的回忆流光。"
  },
  CollectionHall_121413_LockTip = {
    Text = "完成多维连接「逆转回合」"
  },
  CollectionHall_121413_Title = {
    Text = "无限续杯！"
  },
  CollectionHall_121414_Desc = {
    Text = "疯狂，毁灭的前奏，这是有序世界的底层逻辑。\n祂会毁灭吗，世界会毁灭吗？\n无人知晓。\n但创世神面前，疯狂正在滋养出祂与世界的新生。"
  },
  CollectionHall_121414_LockTip = {
    Text = "完成调查行动9-11解锁"
  },
  CollectionHall_121414_Title = {
    Text = "疯狂赋格"
  },
  CollectionHall_121415_Desc = {
    Text = "世界上最不讲道理的是什么？\n祂没有目的，无关恩怨，不辨善恶。\n祂只想在醒来时把梦境中生出的一切，全都化为齑粉。"
  },
  CollectionHall_121415_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121415_Title = {Text = "齑粉"},
  CollectionHall_121416_Desc = {
    Text = "作为那枚独一无二的碎片，成为神很简单。\n那么，代价是什么？"
  },
  CollectionHall_121416_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121416_Title = {Text = "成为神"},
  CollectionHall_121417_Desc = {
    Text = "在漫长的人类文明中，我们构筑了许多东西。\n关于物质，关于精神，关于生存、爱、硝烟与纷争。\n但那只是造物主梦中不值一提的噪声，和疏于勘破的虚构集。"
  },
  CollectionHall_121417_LockTip = {
    Text = "完成调查行动9-13解锁"
  },
  CollectionHall_121417_Title = {Text = "虚构集"},
  CollectionHall_121418_Desc = {
    Text = "弥萨格有史以来最怯懦的守密人，死在了巨大的幸福之中。"
  },
  CollectionHall_121418_LockTip = {
    Text = "完成调查行动·困难9-11解锁"
  },
  CollectionHall_121418_Title = {
    Text = "决心落跑的英雄"
  },
  CollectionHall_121898_LockTip = {
    Text = "通关调查行动星辰篇4-0解锁"
  },
  CollectionHall_121898_Title = {
    Text = "永世虚妄巡礼"
  },
  CollectionHall_121901_LockTip = {
    Text = "通关调查行动星辰篇4-16解锁"
  },
  CollectionHall_121901_Title = {
    Text = "神诞七日"
  },
  CollectionHall_122565_LockTip = {
    Text = "需要通关限时活动「雾境的燔礼：迷失的自我」任一关卡"
  },
  CollectionHall_122565_Title = {
    Text = "雾境的燔礼：迷失的自我"
  },
  CollectionHall_123756_Title = {
    Text = "银与血的洗礼"
  },
  CollectionHall_124124_Desc = {
    Text = "你与许多存在都有见第二面的可能性，哪怕那是一个不应存在的婴孩，或诞生自错误的神灵。"
  },
  CollectionHall_124124_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124124_Title = {Text = "第二面"},
  CollectionHall_124125_Desc = {
    Text = "哦……原来还有更坏的结局。"
  },
  CollectionHall_124125_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124125_Title = {
    Text = "她与他与祂之死"
  },
  CollectionHall_124126_Desc = {
    Text = "你要怎么描述一位在太耀眼时离别的同行者？\n不要描述他的耀眼，描述他的手臂，描述你在他身上闻到的雪松香气。"
  },
  CollectionHall_124126_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124126_Title = {Text = "雪松"},
  CollectionHall_124127_Desc = {
    Text = "在旅途的尽头，你知道有谁在等待你。\n但你还没能逃离，你从高空中再次坠下。"
  },
  CollectionHall_124127_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124127_Title = {Text = "坠下"},
  CollectionHall_124128_Desc = {
    Text = "孩童并不属于母亲，祂已打定主意，所有人都要留在这里。\n留在祂永恒延续的甜蜜乐园。"
  },
  CollectionHall_124128_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124128_Title = {
    Text = "甜蜜乐园"
  },
  CollectionHall_124129_Desc = {
    Text = "你没来得及救她，这个她没有逃出来。\n她被分食，她孤立无援，她拴上了一条假脐带。"
  },
  CollectionHall_124129_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124129_Title = {Text = "假脐带"},
  CollectionHall_124130_Desc = {
    Text = "3.14159@2，3.141592@3，3.14159265@4……\n雪地里永无终结的圆，残忍的、永远不会结束的圆周率。"
  },
  CollectionHall_124130_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124130_Title = {
    Text = "「3.14159@4」"
  },
  CollectionHall_124131_Desc = {
    Text = "你又来晚了一些，别停留，再快，再快一点。\n快赶往下一个结局。"
  },
  CollectionHall_124131_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124131_Title = {
    Text = "某一个结局"
  },
  CollectionHall_124132_Desc = {
    Text = "拥抱我吧，我的宝贝，我的……父亲，我的命运。"
  },
  CollectionHall_124132_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124132_Title = {
    Text = "在他女儿黑暗的子宫中"
  },
  CollectionHall_124133_Desc = {
    Text = "天空将要亮了，让我们作别昨日。\n作别昨日的苦痛、荒诞、迷惘，\n迎接一个更明亮的，天各一方的明天。"
  },
  CollectionHall_124133_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124133_Title = {
    Text = "在黎明时告别"
  },
  CollectionHall_124134_Desc = {
    Text = "她与现实之间，她与虚妄之间，竖起了一面小小的盾牌。\n面粉、鸡蛋、柠檬、蜂蜜、糖、泡打粉、黄油烘烤成的盾牌。"
  },
  CollectionHall_124134_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124134_Title = {
    Text = "面团盾牌"
  },
  CollectionHall_124135_Desc = {
    Text = "这个世界一如往常，孩子依赖母亲，孩子也对母亲说谎。"
  },
  CollectionHall_124135_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124135_Title = {
    Text = "叙谎者和弦"
  },
  CollectionHall_124136_Desc = {
    Text = "神诞生的第七日。\n哦，神啊，神啊……\n不过是荒谬的错误与虚假的谎言。"
  },
  CollectionHall_124136_LockTip = {
    Text = "完成调查行动·困难 星辰篇4-10解锁"
  },
  CollectionHall_124136_Title = {Text = "腐神明"},
  CollectionHall_124137_Desc = {
    Text = "睡吧，睡吧，海的婴孩，让漆黑的月光照在你沉暗的襁褓上，让千年亿年的沉梦就此沦入永恒虚妄。"
  },
  CollectionHall_124137_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124137_Title = {Text = "黑月光"},
  CollectionHall_124138_Desc = {
    Text = "逃跑吧，两条鱼跃入了水面。\n它们暂时抛却了一切，试图瞒着世界与彼此相伴流亡。"
  },
  CollectionHall_124138_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124138_Title = {
    Text = "秘密流亡"
  },
  CollectionHall_124139_Desc = {
    Text = "父亲诞下女儿，女儿孕育父亲。\n虚妄、倒错、她所坠入的循环往复的命运。"
  },
  CollectionHall_124139_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124139_Title = {
    Text = "虚妄倒错之孕"
  },
  CollectionHall_124140_Desc = {
    Text = "什么比死亡和疼痛更可怕？\n这对你来说不算一个难以解答的问题。"
  },
  CollectionHall_124140_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124140_Title = {
    Text = "回到原点"
  },
  CollectionHall_124141_Desc = {
    Text = "她和她有她和她的虔诚，他和他有他和他的反叛和忠心。\n她编织一个弥天大谎，他和他和她和她陪她演戏。\n家，大家组成了甜蜜而不可分割的家。"
  },
  CollectionHall_124141_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124141_Title = {Text = "家"},
  CollectionHall_124142_Desc = {
    Text = "让我们呼唤那由海中上浮的神国的名字——利莫里亚，利莫里亚。"
  },
  CollectionHall_124142_LockTip = {
    Text = "完成调查行动 星辰篇4-16解锁"
  },
  CollectionHall_124142_Title = {Text = "海国"},
  CollectionHall_124224_LockTip = {
    Text = "通关多维连接「银与血的洗礼」任一关卡解锁"
  },
  CollectionHall_124224_Title = {
    Text = "茉夏的异世界调查记录"
  },
  CollectionHall_124395_Desc = {
    Text = "在萝坦此生最为痛苦与满足的那天，她手中的利刃如风暴袭向眼前的神明。巨剑与利维坦如星球般宏伟的身躯一同，在这风暴中寸寸碎裂。\n将鲜血的王冠赠予那位骑士团的奴隶后，作为交换，萝坦只提了一个要求：她需要一把新的武器。\n怀着对萝坦的畏惧与崇敬，新国王命人取下利维坦的骨头，为她铸造了一对无与伦比的巨剑。在六国最优秀的铁匠们日以继夜的铸造淬炼中，一头死去神明的尸骨，在弑神者的手中重获新生。\n一位值得被铭记的对手曾见证过这双不灭的剑刃。他的巨锤劈碎了萝坦的铠甲与巨剑，裂纹如蛛网般在剑身蔓延，乳白的碎片飞溅在血色的空气里，如同她刺向利维坦的那天。他以为自己找到了破绽。然后，他看到萝坦重新在他面前站起，那柄本应碎裂的巨剑刺穿他的胸膛，吮吸他的血肉。新的骨骼从碎裂处涌出，比先前更加尖锐，更加致密。断面拔节生长，如同荒野中疯长的荆棘。他清晰地感知到，自己的生命正被那白骨铸就的利刃咀嚼、吞咽。\n原来，那曾经吞噬星天的巨兽从未死去。自契约签订的那一刻，祂便与她融为一体。每当萝坦提起巨剑，剑身的骨棘便开始绽放，用它锐利的尖刺向对手发出残忍的欢呼。\n它是她的武器。她是它的双足。她与它，从始至终都陷于同一种渴望。她们不死不灭，永无餍足。\n从不停息的战场，是她们唯一的归宿。"
  },
  CollectionHall_124395_Title = {
    Text = "不灭的饥骨"
  },
  CollectionHall_124397_Desc = {
    Text = "许多年后，面对伏地祝祷的蹈海者，诞妄·墨菲会回想起，「母亲」为她讲起蓝环章鱼故事的那个遥远的下午。\n罐中的造物柔软而炫目，奇异的幽蓝在水中浮动，诱使幼小的她不由自主地靠近。\n而弥利亚姆却抚摸她的头，带着不容拒绝的力道让她看向昏暗船舱的角落——一具蹈海者的尸身疲软地瘫倒在地，呈现出一种被毒素吮吸殆尽后的虚无苍白。\n「谨记，海洋里最宁静、也最致命的，往往是最美丽的那种。」\n玻璃罐的冷光映亮她慈悲的侧影，诞妄·墨菲只感到一种被美丽包裹的恐惧。\n\n岁月跟随星辰的节律悄然流逝，诞妄·墨菲一如往日骄纵，却也学会了沉默与观察。\n「利莫里亚，利莫里亚……」\n直至祭坛之上，那张一向平静温柔的面庞逐渐被疯狂浸染，她这才恍然，原来自己从未真正认识过弥利亚姆。那只抚摩她头顶的、温柔的母亲的手，也会为神国的敌人施以最严厉的惩戒。\n彼时，记忆深处被封存的恐惧骤然复苏，最终凝固成一种冰冷的认知——她的仁慈不过是伪装的腕足，而温柔外表幻化成的美丽蓝环，正是见血封喉的毒素本身。\n\n时至今日，虚无的神明终为诞妄·墨菲加冕。她俯视着匍匐的蹈海者，迎上弥利亚姆目光中那一丝未曾泯灭的、近乎荒诞的期颐，仿佛再度看见了那个在玻璃罐前，凝视着美丽生物而战栗的、渺小的自己。"
  },
  CollectionHall_124397_Title = {
    Text = "蓝环毒素"
  },
  CollectionHall_124400_Desc = {
    Text = "不知名的瘟疫吞噬了城镇与村庄，嗜战的人们在动荡中尽情杀戮，铁与血的交响沸腾癫狂。\n出于恐惧，或利用恐惧。\n恐惧是无形的敌人，古老的敌人，致命的敌人。\n他是一个不合格的骑士，他败给了恐惧。\n然而曾郑重许下的誓言仍然回荡耳畔，一年又一日，穿过早已虚无的故乡。\n「我将仁慈地对待弱者，我将勇敢地面对强敌。」\n黑夜藏匿了行凶者的脚印，尖叫和哭泣的洪流淹没街巷，人群如同惊慌失措的羊群。\n「我将毫无保留地对抗恶人，我将为不能战斗者而战。」\n枪尖染血，银盾锈蚀，影子餍足地微笑，群鸦盘旋顶空，瞳仁中有魔鬼的闪光。\n「我将帮助那些需要我帮助的人。」\n「是他，他来了。」人们低声嗫嚅，恐惧扭曲了他们的脸庞，「空心的怪物，复仇的鬼魂，自死亡的深潭归来，要将他的敌人拖入怨恨的黑沼。」\n是他。他并未忘记，他从未忘记。\n为何要坚持？倘若万物终将消亡，哪怕是荣耀与信仰。\n为何要退缩？既然无论命运如何嘲弄，人都唯有屈膝顺从。\n难道只为忠于忠诚，献于奉献？\n公国最后的骑士徒劳发问，灵魂同残躯一样荒芜，恐惧的余污肆意流淌，汇聚成毁灭的汪洋。\n可空荡荡的胸腔依旧缄默不语，失落的答案还不知去向。"
  },
  CollectionHall_124400_Title = {
    Text = "往日如影随形"
  },
  CollectionHall_124404_Desc = {
    Text = "那是我与父亲移居海城的第二年，伊芙莲在信中的哭诉使我心烦意乱，我已决意同她分别。这是由丝绸与乌木装潢的富饶之地，所有食腐者都嗅到了它沉睡时的混乱，纸钞的面值能换来等重的黄金，掌握了那些航线，就能以极小的成本撬动千万倍的财富。\n然而伊芙莲，也许是源于她晦涩难追的怪异血统导致的神经质，这个女人坚信所谓先祖的传讯，东方有祂们的旁支所信奉的邪异神明，如同深海中的某种鱼类，会悬垂下招摇美味的饵，将猎物引入一场难以察觉的缓慢进食。\n她错了，海城没有半丝来自海的咸味。\n只有层层叠叠，馥郁到令人迷醉，又心生恐惧的白玉兰。\n令我和父亲同时陷落的白玉兰。\n当我看到她的时候，那个名为「徐」的女人的身影出现在我视线中的第一秒，我就永远不再可能从这片古老的陆地脱身了。\n她令人想要靠近，她令人想要占有，她令人想要@3\n她令人令人令人令人令人令人想要想要想要想要想要\n切碎割开砍碎永远永远永远永远永远……@2@3@2！！\n啊，我为什么来到这里？我要带走什么？我是……谁？\n不再重要了，她邀请了我，我坐在那座大宅的桌前。\n早已与我一样疯狂的父亲，脸上挂着乖顺的笑，琳琅满目的配菜摆满餐桌，显得金属带盖餐盘格格不入。\n徐逆着光线坐在夕阳中，光晕为她镶上了一层绒绒的金边，缓缓地，那把黑扇放下了。\n像伊芙莲、像我幼时的玩伴、像朦胧间的艳遇……像我的母亲。\n那是一张如同庙宇里鎏金神像般端方美丽的脸。\n我没有听见吮吸声，也没有嗅到父亲身上传来的腥味，只是痴迷地注视着那张脸，以及那张脸的主人伸出一只素白的手，揭开餐盘，捡拾出合适的肉，她用两根细木棍将它钳起，抬高。\n她唤我，烘烤过后的动物油脂滴在我的嘴角。\n「小先生，你该吃些东西。」\n\n我温顺而木讷地张开嘴。\n玉兰花已经开了，它在簌簌地向我悬垂。\n——「无名者手记」\n"
  },
  CollectionHall_124404_Title = {
    Text = "玉兰之饵"
  },
  CollectionHall_124405_Desc = {
    Text = "「以理智为明灯，就能驱散人生的迷雾。」\n曾几何时，茉夏曾经听过这样的话。\n或许是某次梭罗公司的技术人员在调试驱雾灯时脱口而出的感慨？又或许是某次去菲林根餐厅时某个路人的调侃？\n茉夏已经忘记了，她能够清晰想起的，就是听到这句话时，自己脸上的惯用社交微笑，和藏在这笑容之后的嘲讽。\n「明灯？哈，什么老掉牙的古董，现在人们都用手电筒。」\n她并非不知道这只是一种比喻，她只是不屑于理解。\n因为总有一天，她会死亡。而死亡之后，什么理智，什么迷雾，都不存在了——她会彻底从这个世界解脱。\n这是合理且必然的推测。她需要做的，只是享受这个「必然」到来前的过程。\n但从没有人告诉过她，「必然」也会遭遇「意外」。\n相似的迷雾，相似的困境，可这里没有驱雾灯，没有调查团，没有任何她熟悉的东西。她的斧子能够斩断世间的怪物，却斩不断自身的孤独与困惑化为的迷雾。\n她可以回去吗？她会回去吗？到底什么时候可以回去……\n一个又一个问题自她的内心浮起，像是无形的深水，慢慢吞噬她的心灵。此时此刻，她心中唯一的，全部的想法，就是——\n保持理智。\n不要发疯！不要发疯！不要发疯！\n无论是面对那个世界的迷雾，这个世界的迷雾，还是自己内心的迷雾。\n为了，再次回去。"
  },
  CollectionHall_124405_Title = {
    Text = "理智明灯"
  },
  CollectionHall_124407_Desc = {
    Text = "七岁生日那天，父亲将一台名为「摩伊赖」的纺轮放在她膝上。那名字属于三位早已无人祭拜的命运女神，而纺轮本身却光滑崭新，铜轴泛着金属光泽，冷冽而沉重。\n从那时起，阿拉克涅拿起了命运之轮，不是出于选择，而是因为那些无心说出的话语总在日后应验，她无法忽视这命中注定的责任。  \n从那时起，她便一直编织着，日复一日，看命运的丝线在精密的纺轮上无声转动，为世人织出初吻的颤抖、战马的嘶鸣、婴儿的第一声啼哭，以及墓碑上粗糙的刻痕。  \n从那时起，她在万千交错的丝线中挑选那些「更好的」走向，让漆黑的瘟疫提前退潮，让历史躲过战火，让文明于废墟中重建……而与此同时，她也编织出那些通向疯狂、背叛或永恒黑夜的丝线，只为维系那张横跨时空的命运之网。\n「什么才是更好的？」\n沉默的纺轮不会回答，只是继续旋转。好的、坏的，新生或是讣告，在同一根丝线上交替浮现。彼时年轻的她尚不知自己的宿命为何物，却已在无数线头的尽头，望见世界的终局。\n「如果世界无法逃避毁灭的宿命……」\n「不，我爱这个世界。」\n阿拉克涅凝视着纺轮，将未说出口的想法舍弃。\n「那么……我的宿命呢？」\n她喃喃自语，唯有空荡的回音在四壁间游荡。\n……\n数不清多少文明在命运之网上崛起又崩塌，金字塔在沙中沉睡，飞船掠过星海，语言更迭如季节轮转，神明的名字被写进尘封的辞典……而她始终坐在那里，转动手中的纺轮，看着人类一遍遍重演希望与毁灭的循环。\n直到某天，一声轻唤超越永恒的监牢与万古的寂静。\n「姐姐……」\n她终于收回投向末日的视线，闭眼望向涅芙蕾亚，她身体里的另一个自己——那双新生儿般纯净的眼睛里，没有审判、没有恐惧，只有全然的信任，像一张尚未落笔的白纸。\n那一刻，阿拉克涅终于知晓，爱与责任、恨与毁灭，一切在命运面前并无区别。于是，她将那些被自己亲手剪断、舍弃的回忆，那些本该发生却从未降临的痛楚、遗憾与失落，编织成一缕丝线，作为最沉重也最温柔的礼物，系在涅芙蕾亚的手腕上。\n「离开这里吧，涅芙蕾亚。」阿拉克涅微笑，「你自由了。」\n阿拉克涅不再需要看清自己的宿命。因为在七岁那年拿起纺轮的瞬间，她就已选择了未来的走向。而宿命的纺轮，将静静转动，见证她即将投身其中、永无谢幕的战斗。"
  },
  CollectionHall_124407_Title = {
    Text = "宿命纺轮"
  },
  CollectionHall_124410_Desc = {
    Text = "吃掉吃掉吃掉吃掉……\n幻惑的魇思。\n碾碎碾碎碾碎碾碎……\n大海的呓语。\n摧毁！摧毁！！摧毁！！！摧毁！！！！\n无法抑制的疯狂。\n「莫丝好饿。」\n少女吞下滴淌鲜血的肉块，可无论吃多少都无法缓解胃里的空虚。\n「莫丝好渴。」\n少女咽下散发腥腐的海水，可无论喝多少都无法解除喉咙的干涩。\n「莫丝好困。」\n少女殴打麻木清醒的自己，可无论睡多久都无法抑制思维的疲惫。\n因为只有纯粹的破坏，才能满足体内的祂。\n「但是，莫丝，不要！」\n可少女拒绝了宿命的呼唤，特制的钢铁成了她无法褪下的牢笼。\n她将自己打造成坚不可摧的监狱，用名为自己的拘束，囚禁了来自深海的疯狂。\n「莫丝，关住了，坏蛋！」\n至此，自AF 1■■出现，吞噬无数生灵的大漩涡默斯克斯，于AF 31■，彻底归于静默。\n\n\n\n\n"
  },
  CollectionHall_124410_Title = {
    Text = "被囚禁的疯狂"
  },
  CollectionHall_124413_Desc = {
    Text = "书架上除了枯燥的研究文献之外，还有几本看起来很有趣的儿童读物。\n《灰姑娘》、《白雪公主》、《美人鱼》、《长发公主》……它们的主人为何会将这些书收在书架上——如今已无从得知。\n那些故事编织着与现实截然不同的情节。「王子」、「公主」、「爱」……这些词语令少女的心怦然悸动。\n夜空中闪烁的无数光芒倾洒向大地，仿佛即将汇成一条流淌的光之河。\n在洒落的月光中，少女悄悄踮起脚尖，假装踩上一双透明的玻璃鞋。仿佛一直在期盼着——这深沉、孤寂的漫漫长夜终将破晓……"
  },
  CollectionHall_124413_Title = {
    Text = "淤泥里的童话"
  },
  CollectionHall_124414_Desc = {
    Text = "游走在商船和商船间，总是把身形藏在破旧布褂阴影里的老巫师说，罗盘会把人们引领到祂该去的地方，水手们嬉闹着嘲笑她带着草药味的废话，丢下五个雷欧坊，换走这个精致的黄铜装饰物。\n然后他们停靠在后来失去了名字的小镇港口，庞托斯喜欢这个故事，罗盘的主人喜欢庞托斯。\n当然，没有人不喜欢幽默、开朗，来去潇洒得像一阵风的庞托斯。\n它原本应该是很好的纪念，是庞托斯转赠给他亲爱的外甥以后，开启对遥远彼方的遐想的钥匙——但它让庞托斯找不到他，庞托斯不允许，也绝不会让他的生活有另一种可能性。\n当许多年过去，庞托斯在月色中穿行过无数个黑夜，寻觅着那个应当回到厄波扬斯的身影的时候，他是这么想的。\n哦，那个徒劳的，保护性的法术离开他了，庞托斯现在可以把他带回来。\n只是庞托斯还不知道，「罗盘会把人们引领到祂该去的地方」，如同每条船都有自己的航线，不同的人总是会选择不同的方向。"
  },
  CollectionHall_124414_Title = {
    Text = "指向歧路的罗盘"
  },
  CollectionHall_124415_Desc = {
    Text = "「您要买一支火柴吗？」冬夜，手脚冻得通红的女孩呢喃着，「一支，就一支火柴就好。」\n「抱歉噢，我不会买你的火柴，」纯白的身影微微躬身，遮住了冬季的月亮，「相反，我还要卖给你一些东西。」\n「可是，我没有钱……」\n「没关系。相信仙女的赐福吧，你很快就能卖出火柴了。」\n白衣的仙女将一颗糖果塞进女孩的手里，然后贴近女孩耳畔。\n「看见街对面那个穿着皮毛大氅的中年女人了吗？抓住她的衣角，拼命哭，说好心的太太，天太冷了，我的奶奶生了重病，如果不能吃上一顿饱饭，马上就要病死了，求求您了，给我点钱吧。」\n「可是，奶奶很久以前，就已经离开我了……」\n「那更好了！你就试着模仿那个时候的感觉，哭得真一点……」\n「如果她还是小气不肯掏钱，我也还有办法。这种大年夜还在室外徘徊的人，家庭肯定不幸福。那你就补上，奶奶是我唯一的亲人了，今天可是大年夜，谁也不想孤零零一个人，求求您，美貌的太太，只要三分钱，让我能早点卖完火柴，回去和奶奶团聚吧。」\n「火柴是一分钱……」\n「剩下两分钱，一分是我的抽成，还有一分钱要供奉给它。」卡拉布摇了摇手中的魔法棒，沉睡的白色幼虫如水波般流淌。\n「别想那么多，相信仙女的赐福就好了，这招一定百试百灵。记得啊，她掏钱出来之前，千万不要松手。如果失败了，我们再去找下一个孤独的阔太太就好了。放心吧，在这个世道上，手头有余钱的女人足够喂饱我们两个人。」\n百试百灵的方法为什么会失败，已经没人想去追究了。总之，在更新了一百八十二套话术后，小女孩的火柴成功售罄。\n在真实的「仙女教母」没有出现的故事里，伪造的仙女同样拯救了濒临冻毙、贫穷可怜的女孩。\n可喜可贺，可喜可贺。"
  },
  CollectionHall_124415_Title = {
    Text = "恬美真相"
  },
  CollectionHall_124844_Desc = {
    Text = "<Title:简介>\n来自泰穆兰的神秘少女。据其描述，原本是当地大学的准大学生，因一场「命运般的浪漫邂逅」成为雾境调查团的前锋。\n在繁星黎明会的「雾灾事件」里，茉夏意外被召唤到此世，后在银与血的仪式中，她经受洗礼，从人类转化为唤醒体，并终结「雾灾事件」。\n置身于不属于自己的世界的她，仍旧寻求着回去的方法，但同时，她也对这个世界的未来充满了兴趣，渴望见证「世界的结局」。"
  },
  CollectionHall_124844_LockTip = {
    Text = "唤醒「茉夏」后解锁"
  },
  CollectionHall_124844_Title = {Text = "茉夏"},
  CollectionHall_125443_LockTip = {
    Text = "需要通关限时活动「海城旧闻：玄女无相」任一关卡"
  },
  CollectionHall_125443_Title = {
    Text = "海城旧闻：玄女无相"
  },
  CollectionHall_126315_LockTip = {
    Text = "需要通关限时活动「织者自缚：木偶的舞台」任一关卡"
  },
  CollectionHall_126315_Title = {
    Text = "织者自缚：木偶的舞台"
  },
  CollectionHall_126425_LockTip = {
    Text = "可于调查行动星辰篇4-1中解锁"
  },
  CollectionHall_126425_Title = {
    Text = "墨菲的幻影"
  },
  CollectionHall_126471_Desc = {
    Text = "茉夏早已习惯了迷雾的存在。\n无论是多么难缠的迷雾，多么危险的迷雾，她总能从其中平安走出。\n这次也一样。\n她终会走出新世界的迷雾，回到属于自己的维度。\n无论要付出怎样的代价。"
  },
  CollectionHall_126471_LockTip = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  CollectionHall_126471_Title = {
    Text = "揭开新世界的迷雾"
  },
  CollectionHall_126472_Desc = {
    Text = "迷雾总有消散之时。\n彼时，响彻于雾霭里的惨叫会消散，流淌在祭坛上的血迹会被拭净。\n迷途的灵魂将得到解脱，找到正确的路途——\n前往闪耀的繁星，或留存于真实的大地。"
  },
  CollectionHall_126472_LockTip = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  CollectionHall_126472_Title = {
    Text = "迷雾消散之时"
  },
  CollectionHall_126473_Desc = {
    Text = "宇宙孕育了世界，世界孕育了生命。而不同世界的生命，又孕育出了不同的规则与理念。\n当他们交锋时，厮杀的从来都不止是两个躯体，两个意志，两个生命。\n那是永恒平行又突然相交的、两个宇宙的碰撞。"
  },
  CollectionHall_126473_LockTip = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  CollectionHall_126473_Title = {
    Text = "信念的争锋"
  },
  CollectionHall_126474_Desc = {
    Text = "任务结束后，我将与过去的自己道别。\n道别那些熟悉又回不去的过往，道别泰穆兰和身为人类时期的自己。\n我将怀念那充满迷雾的世界。\n此后，我将以新的身份，存活于这迷雾消散的世界，这充满趣味的恐怖世界。"
  },
  CollectionHall_126474_LockTip = {
    Text = "完成多维连接「银与血的洗礼」困难难度"
  },
  CollectionHall_126474_Title = {
    Text = "雾语者的新生"
  },
  CollectionHall_126475_Desc = {
    Text = "残酷的世界下，一个人的灵魂轻易便可焚烧殆尽。\n于是我们向他人和世界求索，亲情，爱情，友情，思乡之情……\n那触摸不到的感情，就此化为不可看见的力量，延续着的生命，让人们在这个世界燃烧得久一些，更久一些……"
  },
  CollectionHall_126475_LockTip = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  CollectionHall_126475_Title = {
    Text = "残酷的生存智慧"
  },
  CollectionHall_126476_Desc = {
    Text = "亘古的繁星见证了世界的诞育、成长与繁荣，它也必将见证世界的终结。\n渴求生存的人们啊，存活的唯一方法，并不在我们的脚下，并不在背叛我们的大地上，而在我们的头顶，那永恒的繁星闪耀之地。"
  },
  CollectionHall_126476_LockTip = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  CollectionHall_126476_Title = {
    Text = "繁星闪耀之地"
  },
  CollectionHall_126477_Desc = {
    Text = "拯救世界不是她的风格，而这里，也不是她的世界。\n但她听到了守密人的声音，看到了守密人为了拯救世界做出的巨大牺牲。\n被人拼尽性命守护的世界，不该毁灭。\n至少在这一刻，不该由她亲自毁灭。"
  },
  CollectionHall_126477_LockTip = {
    Text = "完成多维连接「银与血的洗礼」困难难度"
  },
  CollectionHall_126477_Title = {
    Text = "无法理解的选择"
  },
  CollectionHall_126906_LockTip = {
    Text = "通关意识潜游「扇下夜谈」任一关卡解锁"
  },
  CollectionHall_126906_Title = {Text = "夜哭集"},
  CollectionHall_126989_Desc = {
    Text = "<Title:简介>\n她真正的来源，已然无从考证，最早关于这位古老「神明」似是而非的记载，可以追溯到数千年前。\n每个人看向她时，都会看到不同的面貌，实际上有着不知不觉污染对方记忆的能力，能把自己的形象潜移默化地融入对方的记忆中，最终使对方将自己认知为唯一重要的人。\n和其他大多数唤醒体不同，她几乎没有属于人类的感情和视角。\n她是一个念头，一腔狂想，一缕雾——她被感知为徐，被感知为刘、李、钱、张，她生于欢愉，也追逐来自于源源不断的混乱的欢愉。\n但她并非完全不可理解，难以名状的存在，被她所选定的个体，为她带来极致愉悦的那些个体，会有机会窥探到那个能真正将其界定，不会与其他称呼一样变换无常的名讳。\n「千扇玄女」。"
  },
  CollectionHall_126989_LockTip = {
    Text = "唤醒「徐」后解锁"
  },
  CollectionHall_126989_Title = {Text = "徐"},
  CollectionHall_127110_Desc = {
    Text = "双手大剑长而沉重，在足够的力道下足以将人斩成两段。\n\n匕首轻便灵巧，便于隐藏，非常适合出其不意的攻击。\n\n弯刀弧线华美，刀刃锋利，劈砍时可以轻松嵌入皮肉，拉开一道深深的口子。\n\n枪械快而霸道，弩箭无声且迅速，各种各样的金属部件在灯光下闪着冷酷的光。十岁的拉蒙娜站在挂满了一墙的武器前，脸上是不符合年龄的成熟与慎重。\n\n「你想选哪个？」养父——不，是抚养自己长大的父亲——的声音从身后传来，「选好了，我去给你物色老师。」\n\n哪个呢？大剑的沉重既是优点也是缺点；匕首难以应对较长的武器；弯刀虽然长，但切割总是会带来很多不必要的损伤；枪械噪音太大，弩箭容易弹药耗尽。\n\n在弥萨格训练场旁观了这么多天，她知道自己能一眼看出作战双方的弱点，并能近乎直觉地计划好攻击路线。那些需要大量经验积累才能知道的东西，在她这里只需一秒便能推演出来。不，她要的不是这些。她需要一个更精确的，能够用最少的力造成最大的伤害的武器。\n\n女孩思索片刻，从一旁搬来一个凳子，站在上面将手伸向挂在高处的细剑。\n\n细长优雅，灵活轻便，可以很准确地造成伤害——没错，就是它，它符合她的一切要求。"
  },
  CollectionHall_127110_Title = {
    Text = "溯洄时计"
  },
  CollectionHall_127111_Desc = {
    Text = "「当一个世界走向末日时，会发生怎样的乐子？」\n茉夏不知道，但她期待着。\n这种期待和之前都不同，这次可不是什么打几个古物的小乐子，是以一个世界为衡量尺度的研究和调查。而这研究与调查中，最重要也最核心的，是一个人——\n弥萨格守密人。\n「我会拯救这个世界……」\n「这个世界，一定不会走向崩毁的命运……」\n那个心怀理想，身负一个世界兴亡的人这样做出承诺。作为回应，茉夏知道自己应该露出感动的表情，这是人类社会约定俗成的社交礼仪。\n但她不想再伪装了，或者说，在观看过守密人直面@4，以自身为代价拯救一个世界后，她觉得没有必要对经历过宇宙恐怖的人做出伪装。\n「伪装」是人类社会的游戏规则，体面却无聊，而宇宙……宇宙真实且直白——\n要么生存，要么毁灭。\n所以，她对守密人的回答也真实且直白。\n「我不在乎这个世界是否会得到拯救，或者毁灭……比起这些，我更好奇你。」\n我好奇你是否能够践行理想，还是会摧折在追求理想的道路中。\n也好奇这个世界是会回应你的愿望，还是不可避免的走向毁灭。\n无论是哪一种，都会是盛大且不可多得的乐子。\n我会始终期待着那一天……\n用我的眼睛，我的斧头，等待着。"
  },
  CollectionHall_127111_Title = {
    Text = "狂戮至世界尽头"
  },
  CollectionHall_127112_Desc = {
    Text = "「记忆是什么？」\n「是你遗忘的东西。」\n\n莉莉有一个健忘的妈妈。\n她会忘记叫莉莉一起吃饭，会忘记给莉莉喂药，甚至还会忘记莉莉的名字。\n「该怎么办呢？」\n莉莉坐在病床上，故作深沉地叹了一口气。\n这样的妈妈可真不省心啊。\n\n后来，莉莉将自己的名字写在一个木牌上，每天挂在胸前。\n这样总该记住她了吧？\n一开始，妈妈还能笑着说她多此一举，那只是长期劳累导致的并发症。\n\n渐渐地，她开始困惑、不耐：\n「莉莉……莉莉是什么？」\n琥珀色的双眼注视着莉莉，带着一丝隐隐的审慎。\n原来，当文字的意义也被遗忘，这般依靠语言暂时维系的和睦终将一去不返。\n\n莉莉抱住妈妈。\n母女俩的心跳声只隔着短短几英寸，她却感到孤独极了。\n\n那天以后，莉莉将木牌收起，不再向妈妈撒娇，也不再提醒她自己已经饿了好多天。\n她是行将就木的病患，麻木地等待死神的宣判。\n她是隔岸观火的看客，远远地看着自己被注射、被麻醉、被摆弄成任何妈妈希望她成为的样子。\n母女间那些愉快的话语、柔软的拥抱……\n那些闪烁着梦幻泡泡的愉快回忆，都被莉莉小心翼翼地锁在心里。\n只有在某些疲惫的夜晚，她才舍得将它们拿出来，轻轻舔舐。"
  },
  CollectionHall_127112_Title = {
    Text = "跨越疼痛"
  },
  CollectionHall_127113_Desc = {
    Text = "高耸的塔楼轰然倒塌，由不同时空不同种族的学者写下的书籍散落一地，只一瞬间，大大小小的黑色三角就覆盖在每一本书，每一块砖上，并迅速连成一片向四周扩散。\n黑色黏液如同岩浆一般在整齐的街道上流淌，人们尖叫着，哭喊着，试图逃离这可怕的灾难。不少人试图乘坐交通工具逃离，却在慌乱中撞上建筑或其他出了事故的飞船及车辆；更多的人来不及反应，只能徒步向远离黏液的方向跑去，却被其他同样惊恐的人推倒在地，最终被黏液同化。孩子站在街边大声哭泣，几个年轻人躲在仅存的建筑物内，妄想着这样就能躲过死亡。\n「明明没有预兆，为什么，为什么！」\n「为什么没有人警示我们！」\n「@1，是融蚀！救命啊！」\n「快进行意识迁移！只有这样才——啊！」\n「@2，快用仪器！」一个声音说，「我们帮你拖延时间！」\n「不要！我——」\n「我们已经被@1了，而你，你还有希望。」一个温和的声音回道，「活下去，@2，活下去。然后——」\n\n温柯尔猛地睁开眼，她身边是高高摞起的书籍，好几个满是咖啡渍的马克杯。不远处的黑板上贴着或大或小的备忘录和笔记，还写着一条演算到一半的公式。凌乱的房间的角落，中央，以及她所在的巨大仪器旁都放着灯，将整个办公室照得无比明亮。\n她沉默了一会儿，将身体更多地缩在定位仪上，继续中断了的演算。"
  },
  CollectionHall_127113_Title = {
    Text = "无法完成的演算"
  },
  CollectionHall_127114_Desc = {
    Text = "疼痛，剧烈的疼痛充斥着她的全部感官。\n\n金属制的潜水服在水压之下不值一提，外壳向内凹陷，螺丝崩裂，有什么抵住了她的腹腔，有什么刺穿了她的臂膀。冰冷的海水从潜水服破损的地方挤了进来，唯有使用了加厚金属的头盔还勉强维持着原样，为她保留了一些绵薄的氧气。\n\n透过头盔仅有的窥探窗，她看到外面的海水由碧蓝变成墨蓝，再由墨蓝变得漆黑。呼吸带来的水汽凝结在玻璃上，漩涡的隆隆声逐渐远去，成为耳朵中残存的幻影。她渐渐感受不到自己的四肢，呼吸也变得愈发沉重。\n\n她猜测自己应该晕过，寒冷、失血、缺氧，每一个都足以让她意识模糊。同时她无法确定，因为无论她如何眨眼，面对的都是一样的黑暗。\n\n这里是光线无法抵达的地方，是大海深处未有人探知的领域。\n\n一种迟钝的兴奋最后搅动了一下她的血液——未知的领域，最后的冒险。她这也算完成梦想了吧？尽管她现在什么都看不见。\n\n脚踝处传来古怪的触感，她下意识低头望去，发现黑暗之中，似乎有什么东西顺着她的小腿向上攀登。是奇特的深海生物吗，怎么比海水还要冰冷？怎么……在这样的黑暗之中，她似乎能看到它的轮廓？\n\n漆黑的，蠕动的，如同泥浆一样的……\n这是什么？她在哪里？她……是谁？"
  },
  CollectionHall_127114_Title = {
    Text = "记忆螺旋"
  },
  CollectionHall_127115_Desc = {
    Text = "（以下回答节选自克莱门汀的诊疗手册，仅供参考）\n\n1. 凯刻斯。\n2. 16，17……？天知道。\n人死了以后还会管这些没用的干嘛？\n3. 一个破渔村，你不可能在任何地图上查到它的名字。\n4. 我不想说。\n5. 怪胎。丑八怪。蠢猪。傻@1……这些比较常见。\n6. 闪闪发光的黄金鲶鱼脸，简称鲶鱼脸。\n7. 下雨天。\n8. 我不知道。下雨的时候，我会在沙滩上走来走去……\n有几年了吧，就看看远方，不干别的。\n9. 我说了我#¥%不知道@1滚！！\n-------\n14. 唔……或许是奥恩叔叔曾告诉我，他会在下雨的时候，驾驶一搜大帆船来接我「回家」……\n15. 是的，他履行了自己的诺言……\n我在海底漂了好几天，又渴又饿，全身都在痛……\n然后我看见奥恩叔叔和他的白色大帆船。\n他整个人，哦不，准确来说，是他的骨头挂在帆船的桅杆上——他也蜕变失败了。\n然后我用尽最后的力气漂了过去，坐在桅杆上陪着他。\n16. 我们说好要一起回家的。"
  },
  CollectionHall_127115_Title = {
    Text = "伤痛之鳍"
  },
  CollectionHall_127116_Desc = {
    Text = "「人们于潮来时诞生，于潮退时死亡」\n这是在宁菲亚的家乡一直流传的传说。\n\n塞瓦达的乡民不惧死亡，在他们看来，生命的萌芽与凋零就像潮起潮落，都是自然的一部分。\n他们热爱蓝天、大海、成群翻飞的海鸥，还有迎着朝阳盛开的马蹄莲。\n他们厌恶蒸汽、铁轨，以及一切人工干涉痕迹太重的事物——对生命的干涉也包含在列。\n人为地斩断自己的生命，在塞瓦达人看来是不可接受的。\n\n宁非亚并不是一个典型的赛瓦达人。\n比如说，她总是被沉船的氛围所吸引。\n一艘死去的沉船是无数生命的家园：鱼、水草、各种贝类……\n在这里，生与死以一种神秘、圣洁的方式交织在一起。\n宁菲亚满怀平静靠近沉船，仿佛迈入一座无比庄严的大教堂。\n\n在父亲带她外出旅行散心的岁月中，宁菲亚曾看过一部五幕剧。\n关于那部剧的内容，宁菲亚早已模糊，似乎讲了一位古代帝王的一生。\n他生前戎马倥偬，征战南北，却死于可耻的阴谋。\n她记得里面的一句台词：\n<Italic:懦夫在未死以前，就已经死过好多次；勇士一生只死一次。>\n\n多年以后，当宁菲亚步入冰冷的海水，却因对生的眷念而痛苦不已时，脑中便飘过那句话：\n「勇士一生只死一次……」\n于是她擦干眼泪，最后一次向父母道别，这才向心中的沉船继续行进。\n她将成为自己的勇士。"
  },
  CollectionHall_127116_Title = {
    Text = "腐朽赠礼"
  },
  CollectionHall_127117_Desc = {
    Text = "@1年6月5日\n阿尔比诺从融蚀裂隙中带回来了一些稀有的银芯。真有他的。\n改良了一下提纯的方法。\n这次通入了足量二氧化碳和氯气，低温蒸发、结晶……\n一些机械的步骤，没什么好记录的。\n\n@1年6月6日\n切除实验体024的内脏及肢干。\n这是阿尔比诺从诊所里带回来的素材，已生成13个融蚀孔洞，最大直径8mm。\n切割OS-106号融蚀怪物赘生物。\n根据各项测试数据的比对，它与024之间的共鸣相性最高。\n唯一的问题……那些触腕有些过于「活泼」了。\n我想很长时间内我都不愿意再吃章鱼了。\n希望最后的结果别令我失望。\n\n@1年6月6日\n嫁接实验成功，实验体各项生命体征消失。\n这是常有的情况，只需要确保嫁接部位没有扩散感染。\n送入观察室观察一周，接下来就不是我的工作了。\n今天在「内部期刊」上读到两篇抨击活人唤醒体实验的檄文。\n不用说，署名一看就是我在弥萨格的老朋友们。\n真可笑啊，这些老古板但凡肯挪动一下他们肥大的屁股，去实验室稍微走走，就会知道我的结论是无可撼动的。\n024的实验将成为一次绝佳的反击。\n\n@1年6月22日\n两星期过去了，024的各项体征依然不稳定——或者这么说吧，她体内的人格正在以细胞有丝分裂的速度疯狂增殖。\n实验以一种匪夷所思的方式宣告失败。\n把024送去蜡像馆吧，我不需要它每天守着我，好让我时刻回想起自己的愚蠢与轻率。"
  },
  CollectionHall_127117_Title = {
    Text = "畸体回噬"
  },
  CollectionHall_127118_Desc = {
    Text = "那是一颗银白、澄澈、纤尘不染的心。\n它由纯银制成，在机械结构的心脏中有序搏动。\n也曾被血肉侵蚀，也曾因污泥染垢。\n但在死亡的阴霾笼罩之时，它终究回归了本初的形貌。"
  },
  CollectionHall_127118_Title = {
    Text = "纯银的初心"
  },
  CollectionHall_127119_Desc = {
    Text = "时间流转，对星球初生之时的记忆，萝坦已经不大记得清了。\n她只记得，自己是被选中的生灵。\n\n那是发生在一切概念诞生前的故事。\n「生命」尚未扎根发芽，「神明」也远在天垓之外。\n在这团无序的星云中，混沌与混沌碰撞，物质在冲击与搅动中日渐成型。\n星子攫取着尘埃，岩石隆起成山的形状，大气沉降为大片水泽。\n然后，这里被宣告成为一颗「星球」。\n\n混沌的灵魂囿于时间的牢笼中，冲撞着新生的土壤。\n无法控制暴虐的本性，受破坏欲的操纵，祂推垮了无数山脉，填平了无数河泽。\n然后——「神明」跨越了远星，降临在了荒芜的行星。\n\n「神明」带来了文明的种子，也将混沌的灵魂禁锢在了「秩序」的躯体中。\n「与我……做一个约定吧。」\n面对咆哮的混沌之灵，白纱的「神明」絮絮诉说着。\n「伟大的文明将在这里诞生。」\n「你将与无为的智者相遇，将与彷徨的利刃交锋……在未来，你将不再受破坏与毁灭的控制。」\n「在那天到来前……在我们重逢前，替我守护这里。」"
  },
  CollectionHall_127119_Title = {
    Text = "星天之兽"
  },
  CollectionHall_127120_Desc = {
    Text = "他被大公指名成为骑士时，仅在世界上见证了七个四季。 \n\n大公一时兴起逗弄小孩的玩笑话，却被所有人当了真。\n骑士们训练他的骑射武艺，女官教导着他的礼仪，公主也信任并依靠着这名小小骑士。\n\n漫步在亚奎丹与峡谷的旷野高原上，年轻的骑士牵着公主的马。公主无力地趴伏在马背上，不可视的黑暗正在吞噬她的身体。\n\n「公主，我们不能再往前了。」\n穿过这道峡谷，越过这条河流，就会离开养育他们的土壤。\n战火在外界蔓延，敌人隔岸对丰沃的土地虎视眈眈。\n凭着天堑之隔，小小的土地得以苟延残喘地活着，维持着「国家」的尊严。\n在峡谷的这头，他们见证了对岸的覆灭与苦痛。\n无辜者的祈求与悲痛坠入了河流，成为了胜者诗篇的一部分。\n\n无论是多伟大的国度，都将无法阻拦地被卷入历史。\n\n敌人斩下了稚嫩的双手，他不再能举起枪与盾。\n敌人踩碎了脆弱的双膝，让他只能眼睁睁看着铁骑砸开行宫的大门。\n骑士挣扎着咬在了敌军战马的腿上，却并未能阻止敌人的暴行。\n\n然后，他第一次看见了公主口中的「黑色瘟疫」。\n\n洪水般的黑液冲出行宫大门，没过铁骑们的腿甲，却无人一人因此而停下。\n汹涌的「黑色瘟疫」灌进了口鼻，呛入了肺腑，他却仍不想在这里倒下。\n再然后，那无比熟悉的声音直接在脑海响起。\n「你做的已经够多了……我最忠实的骑士。」\n\n最后，眼前只剩空白一片。"
  },
  CollectionHall_127120_Title = {
    Text = "骑士之心"
  },
  CollectionHall_127121_Desc = {
    Text = "祂们脱胎于人类对未知的想象，却没有想象中的歇斯底里与张牙舞爪。\n\n祂们是理智的，祂们是冷静的。\n\n祂们为未来而来，为存续而来。\n\n祂们是最反常、最难以置信的奇迹。\n\n起初，祂们的声音有如虫鸣。但在完全能够理解祂们的思考后，那声音便沉寂了下来。\n\n但此后，声音的主人们试图左右她所做的每一个决定。\n\n以唤醒体之身苏醒的第一年，她学会了与脑子里的声音相处。\n\n她潜入意识，成为格式塔的一部分，攫取所需要的信息与知识，最后安然抽身，回到现实。\n\n在「黑色瘟疫」找上这具身体时，她也是这么做的。\n\n她要将身体与知识、记忆、灵魂摘离，让大脑成为不朽的个体。\n\n手术完成后，她险些进入了生动又奇妙的睡眠中——但只消数秒，她的思维便重新开始了运作。\n\n她清楚地知道，自己正在接近那超越了形式、力量与对称性混沌中的绝对毁灭。"
  },
  CollectionHall_127121_Title = {
    Text = "超越死亡"
  },
  CollectionHall_127122_Desc = {
    Text = "人们总是喜欢以自身的尺度去规定边框、确定符号。\n世界局限在人类的肉身之中，是多么的狭隘、愚昧又可悲。\n她早早地舍弃了肉身，却依然不能触碰到真实的边界。\n知识的长河混乱无尽，而黑色的虚无已再次追上了她。\n她静静地与之对视，如果任何有形的一面都无法窥到世界的全貌，那虚无的背后是否才是真正的答案？\n她用自己的生命做出了此生最疯狂的豪赌。\n她终于看见了终焉。\n真相的大门豁然洞开，世界的面貌转瞬颠倒。\n原来如此，原来如此。\n她迫切地想让所有人都看到这虚无的真实，从徒劳的挣扎中解脱。\n曾经她站在浪尖，引领着世界前进。\n如今她依旧挥舞着牧羊的皮鞭，步履轻快地将世界引入深渊。\n人们惊恐地驱逐了她，将她视为邪恶的疯子。\n真奇怪，她想。\n可我眼中的你们也是这样。\n"
  },
  CollectionHall_127122_Title = {
    Text = "坠入虚无的人偶"
  },
  CollectionHall_127123_Desc = {
    Text = "不必害怕死亡。那只是肉体将灵魂交还给夜色的过程，如潮水退去，归于幽深的安宁。彻底地消散于融蚀，沦为无人知晓、毫无意义的存在才是真正的恐怖。\n她死得并不安详。\n枯槁的身躯早已僵冷，血液与融蚀液混合，凝结如暗红色的玻璃。可她年轻的灵魂仍在喉咙深处颤抖，那一丝未曾消散的意识，如烟雾滞留在骨缝间。像一只脆弱的、折翼的美丽蝴蝶。\n杜勒赛因静静地走入房间，脚步未惊动尘埃。他在她身旁跪下，视线轻柔地略过她紧闭的眼、未展的指节，以及不安晃动的灵魂。\n「我还活着吗？」\n「这黑暗会把我吞掉吗？」\n他不言语，只是伸出手，将她皲裂的手指一根根展开，像是为一朵颤抖的花瓣抚平折痕。没有怜悯、也没有责备，只有平和而宁静的耐心，像是世间最公正、最庄严的神明，赋予她安详的权利。刹那间，她仿佛抵达了永恒的宁静。\n于是纯净的芳香在他们交握的手中逸散，他俯身，满足而庄重地在她的指背落下一吻。那吻落下的瞬间，死亡的最后一道回声一点点拉长，直到融为飘在空中的一道清风，如暴风后的湖泊，全然寂静。没有疑问，没有怨恨，没有恐惧。她终于归属死亡本身。\n「我会记住你。」\n他直起身，凝视她如今彻底归于宁静的模样。恍惚中，尖牙刺入皮肤，他听到了赛琳涅的声音。\n「我相信你，兄长。」\n她是幸运的，在杜勒赛因的记忆中，她将获得永恒的安息。"
  },
  CollectionHall_127123_Title = {
    Text = "安息之吻"
  },
  CollectionHall_127124_Desc = {
    Text = "你第一次见到活的魔像，是在女学者的家里。\n「直到现在，她依然令我惊讶。对我而言，她就是宇宙本身。」\n魔像对你露出机械的微笑，嘴里吐出含混不清的呓语。\n你望着她灰色的眼眸，仿佛置身一片汹涌的灰色海洋，粼粼的波光正从一个地平线爬到另一个地平线。\n\n临走前，女学者递给你一本破旧的小册子，上面记载着制作魔像的诀窍。\n当天夜晚，你摊开它研读潦草的公式和咒语，脑海里却满是魔像那难以捉摸的微笑。\n你再也没能忘了她。\n\n数日后，你寻了个借口再次拜访。\n你跨过堆积如山的书籍、器具、骨架，拨开厚重的帷幕与缠绕的蛛网，最后蹲在魔像身前。\n女学者蜷缩在角落里。不过几日的功夫，她形容枯槁，眼里早已失却光芒。\n「你还是来了……和他们一样。」\n女学者虚弱地咳嗽。\n「是啊……我来了。」\n你拾起魔像的手不断亲吻。\n微凉的指尖在你的脖颈处轻轻摩挲，伴随细微的疼痛，你闭上双眼。\n\n醒来时，你沐浴在温暖的白色日光下，身体伴随柔和的海浪起伏不定。\n你感到前所未有的轻盈，仿佛灵魂早已抛却肉身。\n你转过头，看到一颗颗灰黑色的头颅。\n它们嚎哭、扭曲，像一朵朵黑色的野花，星罗棋布地点缀在灰色的原质海洋上。\n「不——」\n喉咙呕出黑色的粘液，你再也动弹不得。\n原来你也成为了那些头颅的一份子。\n\n「@2年6月，著名炼金术师罗马林·路德维希被发现离奇死于自家书房，头颅不翼而飞，与之一同失踪的，还有那本神秘的炼金术手册……」\n\n（以上内容记载于弥萨格图书馆《炼金术逸闻》卷二册）"
  },
  CollectionHall_127124_Title = {
    Text = "至为珍贵的藏品"
  },
  CollectionHall_127125_Desc = {
    Text = "时至今日，卡斯托尔也无法说出自由真正的释义。\n他常常觉得自己是双子之中更愚笨的那个，从少年时便木讷地跟随在波吕克斯身后，听弟弟说着一个又一个天马行空的奇思妙想。\n在枯燥而麻木的修行生活中，他以为拥有那一抹轻松的亮色已经是最幸福的事，直到于丽埃特下令对波吕克斯进行定期的改造仪式。\n无尽的痛苦尽数倾泻在波吕克斯一人的头上，卡斯托尔茫然无措地陪在弟弟的身旁，看着那张飞扬的面庞上笑容越来越稀少，而自己想不到任何能做的事。\n「你知道自由是什么意思吗？」深夜之中，波吕克斯捧着那本早被二人翻烂的手抄本，静静地问卡斯托尔。\n卡斯托尔摇了摇头。\n「那么，你想去看看外面的世界吗？哥哥。」\n卡斯托尔悚然怔愣，他似乎明白了波吕克斯想要追求的东西，那些他从未见过的、只存在于干瘪的文字中、存在于自己想象之外的东西。\n他为这样大逆不道、惊世骇俗的想法所深深震撼，他沉默着，或许过了很久，或许只过了几个呼吸，他便毫无恐惧地点了点头。\n即便那要对抗整个教会，即便那要献出自己的生命。\n于是，一双鸟儿飞出了从未走出的牢笼，可惜他们从未想过，自由的代价会是如此不可承受之重。\n猎人的枪声响过，鸟儿便从空中坠落。\n卡斯托尔才刚刚尝到自由的味道，便眼睁睁看着弟弟那飞往自由的翅膀被生生地拔掉。\n面对于丽埃特恐怖的怒火，面庞苍白而颤抖的弟弟背着人群，向自己露出了不曾屈服的笑。\n「坚持下去，为了自由。」\n卡斯托尔不停回想着波吕克斯那句无声的口型，直到他在昏沉的折磨中将那两个信仰般的字咀嚼成烙印后，他才再次与波吕克斯相逢。而这时他愕然发现，那始终在前方引领着自己的人，已经无情地将这两个字抛下了。"
  },
  CollectionHall_127125_Title = {
    Text = "不可承受的自由"
  },
  CollectionHall_127126_Desc = {
    Text = "风雨交加的夜晚，神明的女儿孤独地坐在舷窗下。\n冰冷的月光照在襁褓上，流淌黑色黏液的圣婴在其中安睡。\n神明的女儿唱起一支摇篮曲。\n「睡吧，睡吧，海的小宝贝。」\n「你的摇篮是黑色的月亮。」\n「把群星吞入梦乡。」\n歌声亦是祷词，深海的鱼群随之汇聚。\n整艘航船宛如巨型的祭坛，恰似她诞下圣婴的那天。\n剖开自己的胸膛，摘除淋漓的骨肉，以生命报偿养育的恩情与种族的宿命。\n她的牺牲没有换来渴求的自由，死亡不是永恒的安眠，只是悲剧的开始。\n自那之后，她的安宁只来自夜晚。\n「睡吧，睡吧，海的小宝贝。」\n当这支摇篮曲结束的时候，伟大的神国会刺破海面，从波涛汹涌的汪洋中升起。\n怀抱着这样虚妄的幻想，墨菲也轻轻地合上了眼睛。"
  },
  CollectionHall_127126_Title = {
    Text = "黑暗中的安眠"
  },
  CollectionHall_127127_Desc = {
    Text = "他始终苛责着自己，也用苛责逼走了所有的同伴，他本以为他将永远独自走下去，去追求音乐的极致。\n高处不胜寒，他接受了这注定的命运。\n直到他听到了那个人的演奏。\n那个人的演奏与完美毫不相干，过于随性的音乐如同那个人本身，偶尔会出现与曲谱出入的手误，甚至会忽然忘记了某一部分。这时他的双手总会即兴弹出巧妙生动的琴音，博得满堂惊喜与赞美。\n他注视着那个人，仿佛注视着音乐的精灵在音符间恣意拨弄玩耍。\n这就是被父亲称作天赋的东西吧。诚然，他与所有人一样被深深吸引，但他无法改变他的脚步。\n他是那样平庸愚笨的人，只能走上这样一条辛苦铺就的路。\n所有人追随那个人而去，而他也与之渐行渐远。\n他是渴望与他亲近的，但他除了演奏什么都不会。\n要如何与他相谈，该用什么样的曲谱才能得他的青睐。\n他编撰着曲谱，如同斟酌开场白。直到他再也没有开口的机会。\n深重的悔恨淹没了他，所有的一切忽然失去了意义。\n眼中只剩下那封未完成的信，要寄给那个已离去的灵魂。\n他呕心沥血，终于倒在了那张曲谱面前，梦中依然没有触碰到那道路尽头的光芒。\n如果我注定无法走到那路的尽头，那我一生的执着又是为了什么？\n有悠远的笛音从那道光芒中传来，安抚了他充满质问的灵魂。\n恍惚中他拾起那笛，知晓了他真正的使命。\n用他永不停歇的演奏，带来永恒的安宁。\n"
  },
  CollectionHall_127127_Title = {
    Text = "永恒安魂曲"
  },
  CollectionHall_127128_Desc = {
    Text = "哪怕没有前面一截人生的记忆，从你并不发达的肌肉也可以看出，你之前一定不是什么热爱运动或暴力的那类人。\n你实在想不通弥萨格对调查员定下的战斗标准为何如此之高、如此全面。\n难道调查员的重点不在于调查两个字，不在于智慧的头脑、缜密的逻辑与一点恰如其分的好运吗？\n每次被拉蒙娜从宿舍的被窝中准时拖起，站在空荡荡的操场上面对一轮又一轮的攻击时，你就格外想念朵尔教授那充满讽刺的逻辑学课程。即使是成山的作业和最令人脱发的试卷，也比战斗训练中一次次被殴打和跌倒的痛苦要温柔太多。\n第19次，你被那柄封堵了所有行动路线的刺剑逼得失去了平衡，向后一屁股栽倒在地，感到浑身骨头即将散架。\n气喘吁吁中，你颓然抹去额头的汗水，说什么也不肯再起来了。\n拉蒙娜没有任何意外的神色，她挽出一个漂亮的剑花收起了剑，鞋跟清脆地踏响着向你走来。你两眼一闭，决心抱头承受所有的指责与批评。\n意外的是，没有任何敲打或谩骂到来，三秒之后你睁开眼睛，只有一张淡淡的笑脸凑在你的面前。\n拉蒙娜微微弯下腰，一只被洁白手套包裹的手掌向你伸来。\n「其实你已经很努力了，我知道。但我们要面对的永远是未知的恐惧与危险，哪怕是我，也会有顾及不到的意外时刻。」\n「就当是为了让我放心一点，再来一次吧，搭档。」"
  },
  CollectionHall_127128_Title = {
    Text = "搭档特训"
  },
  CollectionHall_127129_Desc = {
    Text = "人是一种喜欢歌唱的生物，对荒星人而言也是如此。\n旋律自喉中自由涌出，无需任何意图和目的。\n它们被风拆成散落的音符，再随情绪一起凋零。\n据说，在沙漠中，所有流浪部族都拥有属于自己的歌谣。\n荒星人却遗落了自己的歌谣。\n\n随着歌谣一起遗落的，还有名字。\n没人知道荒星原本的名字。\n这是受到诅咒的星球。干旱、风暴、饥荒……\n各式各样的灾厄竞相登场，终于将荒星彻底拖垮。\n衣着华丽的大人物乘坐方舟离去，荒星成了名副其实的荒星，只剩下那些不被祝福的底层人。\n他们都被遗弃了。\n\n自那以后，荒星人决定，他们不需要欢笑，不需要诗，也不需要歌谣。\n他们将铭记被遗弃的苦与痛，周而复始地蠕行在白色的沙漠之中，直到星球毁灭的那一刻。"
  },
  CollectionHall_127129_Title = {
    Text = "被缚的歌谣"
  },
  CollectionHall_127130_Desc = {
    Text = "大多数时候，死亡总是悄无声息地到来，在人类的意识还尚未来得及反应的时候，死神就会悄然逼近，收走那鲜嫩脆弱的生命。\n不过，相传在不为人知的某处沙漠中，存在一名琥珀色的死神。她会在发出宣告后，用琥珀的火，琥珀的枪，带来琥珀色的死亡。\n男人站在月夜的沙海上，持握枪械的手正不停颤抖。他目不转睛地盯着凯蒂古拉那琥珀色的身影，不敢有丝毫松懈。\n冷汗从他额头滴下，落到身后每一个人的心中，他带来的人很多，但此刻有用的却很少。\n他不理解，不过是按照委托去劫掠一个早已无人的仓库，却为何会迎上传说中的死神。\n「你说那死神？不过是之前的无聊谣言罢了。」\n凯蒂古拉若无其事地说着。\n「我曾将它们刷成琥珀色，或许你还能在上面找到一些未脱落的漆料？」\n她大方地向面前之人展示手中的双枪。\n「枪口处琥珀色的火焰是撒了某种特殊物质。」\n她的手指深入枪膛，旋转一周后带出了些许不知名粉末。\n「所谓的死神，只是曾经的我打造出的一个形象。」\n「它强大，神秘，无所不能。」\n「它可以帮我威慑那些无能的宵小之徒。」\n她傲慢地说着，丝毫不在意眼前之人那愈发凶狠的目光。\n她旁若无人地说着，全然不觉危险已经逼近。\n当那枪弹向她倾泻而出时，她的眼中露出震惊和茫然。\n只为遮掩潜意识中那抹兴奋与疯狂。\n…………………………\n枪声停息，一切都如她所想。\n她站在战场中央，身边的一切都满布焦痕。\n凯蒂古拉只做了两个动作——举枪，射击。\n她举起长枪时，死神便舞至万物身后，平等地降下死亡预兆。\n她扣动扳机后，火焰便席卷一切，为世界献上琥珀色的花海。\n「它们伴随我走过了许多年月，见证了无数鲜血和死亡。」\n「它们曾被迫披上谎言的外衣，用来遮掩我的弱小无力。」\n「现在，它们不再是谣言了。」"
  },
  CollectionHall_127130_Title = {
    Text = "琥珀色的死亡"
  },
  CollectionHall_127131_Desc = {
    Text = "「你后悔了吗？」\n从琳琅的琉璃盏中苏生的古老神明嗅闻着她，虚无缥缈地萦在她的肩头，将窗推开，送来伴随浅淡香气的夜风。\n「我一蹙眉，连绵城墙上便会燃起狼烟。我一展颜，四面的流水就会载来奇珍和异兽，蜜酿和珍馐。我是整个王朝最珍贵的宝物，我为什么要后悔？」\n她因为微醺而面色泛红，咯咯笑着，埋在丝绸和皮毛堆起的高床软枕中昏昏欲睡。\n……\n「你后悔了吗？」\n附生在一缕线香上的古老神明和他对谈，若有似无的烟气流泻下楼阁，勾勒出已舒展开萼片的花蕾。\n「他们斗得焦头烂额，我只用坐享其成，爬得越高摔得越狠。哪像我，应有尽有，谁后悔都轮不到我啊。」\n他嬉皮笑脸地又满上一壶酒，信手顺来软枝，逗笼里叫声正欢的虫豸。\n……\n「你后悔了吗？」\n从井中爬出的古老神明在她耳边窃笑，缭绕的雾拂过她的头发，将一朵饱满的白玉兰从枝头晃落。\n「我有爱，有牵绊，有日落归家时的热粥，也有欢聚相庆时的美酒，我怎么会后悔呢，我当然不后悔呀。」\n她拈起花贴在鬓角，暖黄烛影随着她的裙沿摇曳，她的目光殷切地黏在窗边，望向她等待的归人。\n……\n「你后悔了吗？」\n狼狈逃亡的裙钗沾满宫门前污秽的泥点，昨日殷勤献礼的侍卫仿佛听不见她的哀哭求告，两道冰冷的剑戟交错落下，封锁了她仅存的生路。\n雾气悠悠地叹息，然后一朵红梅花绽开在雪地里，又由下一场雪彻底掩埋。\n……\n「你后悔了吗？」\n从檀木箱倾泻出的南海珠玑撞碎在青砖上，琳琅掷地的脆响竟比往日奏响的丝管更加悦耳。\n他最珍爱的、日日悬于案前鉴赏的字画滚落堂前，妙手绝笔的墨痕山水被刀尖挑破，恰如他视而不见的战火荼毒的社稷江山。\n雾气嘲弄地缭绕，然后一把火起，那雕梁与画栋都湮灭成前朝的余烬。\n……\n「你后悔了吗？」\n她念在舌尖的名字的主人再也没有回来，远方河边枯骨，枕上美人。\n他做了天子门生公主贤婿？他流连花丛十年不返？他葬身流民腹中作了灾后余粮？\n雾气暧昧地低吟，却不曾给予她苦苦追问的答案。\n\n王朝鼎盛时最珍贵的宝物，会成为王朝倾覆时最珍贵的陪葬。\n家族繁荣时最悠闲的宠儿，会成为家族败落时最理想的弃子。\n而最后一个故事，世间实在是太多太多了。"
  },
  CollectionHall_127131_Title = {Text = "枉蹙眉"},
  CollectionHall_127132_Desc = {
    Text = "阴沉的云笼罩在伦蒂尼恩上空，隔绝了月光。午夜的钟声已经敲响，高耸的烟囱仍在喷出高温的黑烟与水汽。雪花沾了风中的尘埃，还未落地就已经染上暗淡的灰色，它飘飘摇摇地落在路灯上，几乎是瞬间就被灯火的热度融化，向下滴落在路过的女孩身上。\n女孩穿着褐色衣裙，过大的袖管被草率地挽起，露出两条瘦骨嶙峋的手臂。她艰难地小跑着，时不时提一提衣袖，努力追赶走在前方的女人。\n女人侧头瞥向女孩，啧了一声：「动作快点，不要以为你走得慢了就不用去了。」\n「好、好的，妈妈，」女孩赶紧跑到女人身旁，嘴里还喘着气，「对不起，妈妈。」\n「不要叫我妈妈！」女人一把抓住女孩的手臂，拖拽着女孩加快了脚步，「吸人血的废物，要不是你，我哪里至于沦落到这个破地方。」\n「对不起……」\n「闭嘴，没用的东西。」女人的指甲嵌入女孩的手臂，掐出一排深深的痕迹，「我告诉你，从今往后工坊才是你的家，也不要想着什么出来找我，我就是死都不想看见你，听到了吗？」\n「我……我知道了。」女孩低着头，落下的泪水被鞋子踏过，与肮脏的雪水一同消失在石板路上。远处的工厂拉响了放工的笛声，一只野猫窜过巷道，细碎的动静隐没在两人的脚步声中。她们转过街角，走过晾了衣服，散发着潮气的后院，终于在一个有着金属大门的建筑前停了下来。\n「你就在这儿等着吧，」女人的声音非常平稳，甚至带上了一丝木然，「天亮了里面的人就出来了，他们会收留你的。\n别跟上来，不然你看我打不打死你。」\n女人转身离开，同样瘦削甚至有些佝偻的身影很快消失在了黑暗之中。女孩无助地捏着自己的手，一边望着女人离开的地方，一边用袖子擦去脸上的泪水。\n昏黄的灯光从她身后出现，将铁门和她的影子拉长，一只手落在了女孩肩上，将女孩吓了一跳。\n「可怜的孩子，怎么一个人在这儿？」来人是一个年轻女性，穿着修女一般的衣袍，「来，莎拉姐姐带你进去。很快就不冷了。」"
  },
  CollectionHall_127132_Title = {
    Text = "冬夜追忆"
  },
  CollectionHall_127133_Desc = {
    Text = "「我的成名作吗？嗯——这么好奇呀，好吧好吧，毕竟是VVIP的要求。不过，普通的讲述未免太不符合我魔术大师的名号了，让我用一场盛大的表演来向你展示吧！\n来来来，请在贵宾席落座，充满金钱与背叛的悬疑快乐魔法回忆秀，即将开演！」\n-------\n一声响指，灯光亮起，卡茜亚的魔术帽悬浮在半空，黄色的开口一开一合，竟然传出了卡茜亚的声音。\n「没有很久以前，在一个不怎么遥远的地方，有一个马戏团，马戏团里有兔子、有小丑、有狮子、有大象——」\n随着帽子的抖动，从里面掉落一只兔子，一个小丑，一头狮子，一头大象。伴奏的鼓点愈发急促，伴随礼炮炸响的砰砰声，穿着华丽戏服的卡茜亚从帽子里钻了出来，并反手将帽子戴在了自己头上。\n「最重要的是，有一位天赋异禀，才华过人的魔术师学徒！」\n-------\n学徒的成长伴随着掌声，甚至成功吸引了一位穿着华丽的投资人。奇怪的是，自从投资人与他们一同旅行后，兔子、小丑、狮子、大象……很多人和动物都一个接一个地不见了踪影。舞台上空了大半，学徒却仿佛亦无所觉，她重复着原本的生活，直到投资人将一杯酒递到她的面前。\n学徒喝下酒水，晕了过去，舞台随之一黑，微弱的叹息从黑暗中飘出。\n「那是我第一次明白遗憾。」\n-------\n「但是，遗憾怎么够？我还想要知道资助人先生哭的时候是什么感觉，观众笑的时候是什么感觉，我想知道更多，更多。这时候——\n我睁开了眼睛。」\n纸制礼花在空中炸开，碎片飘飘扬扬，卡茜亚突然出现在舞台中央，她敲了敲帽檐，礼帽张开嘴，突出一片炫目的光。\n「我睁开了眼睛，然后发现，所有情感都是光，都可以收纳到我的魔术帽中。\n现在请放轻松，我亲爱的贵宾，接下来的环节一点也不会疼，只会让你有一点麻木，感到生活有一点无趣……」"
  },
  CollectionHall_127133_Title = {
    Text = "快乐魔法秀"
  },
  CollectionHall_127134_Desc = {
    Text = "克莱门汀并不是一个坚强的孩子，所以在患上怪病，被病痛与逐渐逼近的死亡折磨时，她总是会在深夜惊醒，无声哭泣。\n而每次哭泣后的第二天，她的床头便会出现一个「礼物」。\n几块包装华丽的糖、时下流行的发饰、憨态可掬的毛绒熊……\n但最让她印象深刻的，是一个虫蛹标本。\n彼时，她已经病入膏肓，无法下床，只能费力地将那标本举到半空中，瞪大眼睛望着透光虫蛹里的生命。\n那生命已经安眠，但那生命也获得了永生。\n而她，濒临真正的死亡。\n想到这里，她的泪水无声滑落。但一双手，替她擦干了眼泪。\n「不要哭，克莱门汀。总有一天，你也会像这些虫蛹，获得新生。」\n「我会让你获得新生的。」\n父亲从不会说谎，至少，不会对她说谎，所以克莱门汀对这句话深信不疑。\n她信任着自己的父亲，因此进入那座亵渎山脉时，她义无反顾，因此忍受血肉溶解的剧痛时，她毫无怨言。\n因为她相信这一切都是获得新生的代价与必要过程。\n等所有的痛苦与绝望过去，她会痊愈，会回到那个被称为「家」的地方，与她唯一的亲人，团聚。"
  },
  CollectionHall_127134_Title = {
    Text = "隐没的痛楚"
  },
  CollectionHall_127135_Desc = {
    Text = "她从不做梦。\n\n年轻的雕塑家学徒笃信绝对的理性与秩序，一如她冰冷的作品。\n可见到它的第一眼起，她就被迷住了。\n柔软、纯粹——那是完美的着色原料。\n她在月光下忙碌着，将黑色的粘液从乱葬岗带回工作室。\n\n一周后，名为《@2》的雕塑在博览会展出。\n当天夜晚，她听到来自远方的海浪声。\n她第一次做梦。\n静静的晨光下，覆满尘埃的海底宫殿酣然入睡。\n她穿行在白色的珊瑚丛中，呼吸中皆是孤独与遗忘的气息。\n\n醒来后，她的手指正在蜷缩、发黑，最后长出了白色的珊瑚。\n她闻了一遍又一遍，感受着其中来自远古，无数生物的喃喃低语。\n那是真正柔软的化石。\n她神经质地笑了起来——原来这就是做梦啊。\n她将自己关在工作室，开始忘我创作。\n倒模、泥塑、着色……\n混乱的、有序的。无机的，有机的。\n\n她将永远做梦。"
  },
  CollectionHall_127135_Title = {
    Text = "珊瑚女之死"
  },
  CollectionHall_127136_Desc = {
    Text = "母亲。母亲。\n墨菲早已丢失了与之相关的大部分记忆。\n有人说，濒死的母亲护着她，鲜血呛进了她的喉咙里。\n然后人们冲上前，蛮横地将她们分离。\n就在那个瞬间，墨菲看见了母亲的面容。那张脸神情狂乱，却是很美的。\n记事以后，她有了一个新的「母亲」。\n温和，审慎，她会满足墨菲所有无理的需求，却保持着不远不近的距离。\n在墨菲以为她们的关系会一直这样下去，就像弥利亚姆的表情永远不变一样时，她被高高托举上漆黑的王座，于梦中见到那散发着磷光的「卵」。\n它在暗夜中闪闪发光，像眼睛，又像星星。缥缈的歌声环绕在圣所四周：\n<Italic:自他女儿的@1中，@1的神祗降临@1……>\n她被赋予一项与她有关又无关的伟大使命：成为让神明复生的母亲。\n真奇怪啊。她尚且不明白何为母亲，何为女儿，却要开始学习做一名「母亲」。\n墨菲想起了那张狂乱的美丽脸庞，想起了舌尖上甜而苦涩的滋味。\n那个美丽的人，是不希望我如此向坟墓坠落的，是吗？"
  },
  CollectionHall_127136_Title = {
    Text = "隐秘的诞生"
  },
  CollectionHall_127137_Desc = {
    Text = "关于旺达的确切来历，坎布里安的乡民众说纷纭。\n\n有人说，他亲眼见到旺达坐着一块巨大的石头坠入湖畔。\n有人说，她是来自勒姆瓦希的女法老，他曾在木乃伊身上见过一模一样的脊刺。\n还有人说，她是来自弗兰高地的女公爵，在连续克死四任丈夫后，继承了巨额的财产。\n……\n\n传言如风般散去，乡民们继续耕作、纺织、推磨。\n在那些困苦的年月里，沉重的税赋是高悬头顶的利刃，斩断一切横生的枝节与绮念。\n只是……每每路过女王栖息的湖区，丛林掩映中传来的乐音还是轻易勾住了大家的心。\n那是不该出现在这里的旋律。\n它太愉悦、太慵懒，以至于显得邪恶，宛若恶魔低语。\n\n「来吧，抛开这一切。」\n「慈悲的王端坐于湖中央，祂静待盲眼仆从的侍奉……」\n\n于是，在一个无风的夜晚，疲惫的乡民放下农具，决定满足一下偷跑的好奇心。\n他绕过树林，穿过小桥，道路两旁鲜花盛开，他连看都不看一眼。\n他看到绿色的湖泊。\n它与低垂的星空相连，边沿耸立着一座古老的城堡。\n\n头戴荆棘的女王端坐于湖中央，耐心地等待前来朝圣的子民。\n她伸出手，享受着来自凡人的亲吻与膜拜。\n乌云散去，明月升起。\n女王将脊刺刺入他的背脊。\n麻痹的液体沿着血管蔓延，他跪在地上，被砍掉四肢，被剜掉双眼。\n\n至此，来自大地的沉重引力再也无法将他吸附，他所有的诗与梦都只系于那位女王。\n他终于迎来自己的命运。"
  },
  CollectionHall_127137_Title = {
    Text = "女王的戒律"
  },
  CollectionHall_127138_Desc = {
    Text = "「终日苦行之人啊，祈盼这份礼物能够温暖你的灵魂，愿父神的仁爱抚慰你心中的苦痛，为你带来香甜的美梦。」\n银霜夜将尽，烛火低垂。久违地搁置了沉重的石板，萨尔瓦多脱下庄重肃穆的长袍，换上了一身暖和的红绒装扮。为了明日的冬渡节，他特意去到达芙黛尔的小店，为弥萨格的学生们准备了惊喜。\n「这是最后一份礼物了……」\n萨尔瓦多静坐在校园角落的旧椅上，因疲惫而无意识地坠入了梦境。\n那是一个香甜的美梦。脚边的礼盒不知为何悄然打开——四枚姜饼人倏然跃出，糖霜点就的眼眸灼灼生辉，肉桂与丁香的气息在冷冽空气里旋舞成圈。\n香气唤醒了尘封的记忆，他仿佛回到了幼年时的教堂回廊，融化的太妃糖在舌尖传递出甜蜜的信号。那些被苦痛与瘟疫侵染的祝福，正随这甜腻的圆舞曲悄然复苏。\n……\n与此同时，四个偷偷摸摸的的身影悄悄接近了陷入睡梦中的萨尔瓦多。\n「主人……主人会把我们当成是坏孩子吗……」\n「呼呼——奥瑞塔太好奇啦！快打开呀~一个，两个……哇，好多姜饼人呀！」\n「你、你……把名字说出来了，万一……他们会讨厌我们的……！」\n「嘿嘿，我们可没有想偷拿哦！都是布朗干的啦！」\n萨尔瓦多听见小姜饼人们叽叽喳喳地交谈着，感受到一个姜饼人跃上膝头，肉桂的呼吸拂过他布满皱纹的手背。\n不，不是梦中的姜饼人，而是现实中顽皮的孩子们。萨尔瓦多能够想象到孩子们偷偷打开礼物盒时，脸上洋溢着的幸福笑容。为了这瞬间的美好、幸福与安宁，他甘愿承担一切苦痛。\n「哦……我的胡子，这是在拿胡子跟头发打结吗？」\n萨尔瓦多装作依旧熟睡的样子，让孩子们继续这快乐的「秘密行动」。"
  },
  CollectionHall_127138_Title = {
    Text = "盒中童趣"
  },
  CollectionHall_127139_Desc = {
    Text = "你和拉蒙娜从未约定再次相见。\n门扉在眼前缓缓合拢的刹那，你们心中划定的别离的时限，已是注定的永恒。\n\n所以，当她在时光的罅隙里，转瞬即逝的相逢里轻轻勾起你的小指……\n这已经是预期之外、足够幸运的重逢。\n「你一点都没有改变。」她说。\n\n为了这一句话语，为了指尖微弱的温度……纵然遥隔两个世界，你仍愿倾尽所有，飞跃银河与她相见。\n明年今日，勾指起誓。"
  },
  CollectionHall_127139_Title = {
    Text = "你我终将重逢"
  },
  CollectionHall_127140_Desc = {
    Text = "「撤退，撤退！」\n「往@3撤！动作快！」\n「救命，救救我！不要丢下我！」\n「别管他了，赶紧撤退——艾尔瓦！」\n手持铳刃的士兵一个健步冲了出去，炮火在她身侧炸响，士兵的厮杀声，惨叫声，急促的战争号角响成一片。血液染黑了泥土，散发着连硝烟的气味都无法盖过的浓重腥味，倒在地上的士兵们眼神空洞，不论是哪个颜色的军服，都在此刻变成了刺眼的红。\n艾尔瓦咬着牙，顶着一个又一个向她攻来的人向前。她能看见了，那个呼救的年轻人，他被按在地上，双手同时用力努力格挡住来自一名高大敌军的匕首。\n爆裂的枪鸣与剧烈的疼痛同时造访，不远处的敌人缓缓倒下，艾尔瓦立刻回身挥刀，忍着腿部的疼痛向前用力撞去，趁着敌人失去平衡的瞬间一把贯穿了对方的胸膛，同时按下扳机。\n子弹打入躯体溅起血肉，她随意抹了一把脸，回头想要确认年轻人的安全，却发现对方已经不知何时离开了。\n她低头看去，一把刀从她的左膝上方贯穿了她的腿，温热的血液汨汨流淌。\n她从披风上撕下一条布绑在腿根勉强限制血流，将铳刃当做临时拐杖一瘸一拐地跟上部队。"
  },
  CollectionHall_127140_Title = {
    Text = "坚韧意志"
  },
  CollectionHall_127141_Desc = {
    Text = "历史向来是赢家的一言堂，母树消亡、国家倾覆，有关过去的一切都在悄然发生着改变。\n诗人传唱着尼尼微美人的故事，旅人围坐篝火侧耳倾听。\n\n「穿越银色的沙漠，异国美人闯入了尼尼微\n天河之水从她的肩头滑落，西奈珍珠从她的眼中坠下\n金黄双瞳之中，凝视异度国土的过去\n蜜色肌肤之上，书写尼尼微的未来」\n\n后来呢？这位美人成为王后了吗？\n年迈诗人弹拨着七弦琴，发出一声悠长叹息。\n\n「她是迷药，众生为之倾倒。\n她是猛毒，沁入王臣肺腑。\n她是洪水，苍生无可逃脱。\n她是黑色瘟疫的使臣，她带来疫病、噩梦、死亡和尼尼微的末日。」\n\n琴尚未放下，酒桌边站起一人，引来众酒客侧目。\n那人纤长的指间漏下几枚酒钱，金银滚落，叮当作响。\n她所行之处，目光追随，灯火闪烁。\n\n「时间荏苒……但无妨，祂不会回应这些胡言乱语。\n终有一天，你们会理解祂的慈悲与宽厚……正如我所理解的那样……」\n她推开酒馆破旧的小门，如同推开一尊珠宝匣，月光落在裸露的肩头，映照出琳琅的光。\n那被月光宠爱着的美人，确实有着如蜜的肌肤。"
  },
  CollectionHall_127141_Title = {
    Text = "慈悲的哺育"
  },
  CollectionHall_127142_Desc = {
    Text = "当她从花房中睁开眼的时候，大火已经席卷了整座花园，来到她的身前。\n花房的门锁从外面锁上了，空气中弥漫着浓烈的酒精与油脂的味道。她大声呼唤柯蕾特的名字，直到声音被烟雾呛得嘶哑，回应她的也只有火焰的呼啸声。\n她感到庆幸。还好柯蕾特出门了，否则这样大的火，她也会有危险。\n她感到难过。人生的最后时刻，她没有能够见到挚友最后一面。当柯蕾特回来，看到被烧毁的花园和自己，一定会很难过吧？\n她感到遗憾。她们的生活正变得好起来，可这火焰将为她们划上句号。\n燃烧。房子在燃烧。天空在燃烧。树叶在燃烧。花瓣在燃烧。花园中所经历的一幕幕场景在她面前演绎、流转：她带她来到花园，她递给她玫瑰，她用一天的劳作为她带来柔软的面包。她们嬉戏，追逐，躺在宁静的阳光下，畅想着住进伯爵夫人房间的那一天。\n燃烧。过往在燃烧。未来在燃烧。花园带着所有的故事所有的情愫，疯狂地燃烧着。\n泪水从她脸上滑落，在火焰的炙烤下，很快消失不见。\n她感到美。在诗歌中，痛苦与遗憾是美的。她四处寻找，找到了被火焰侵蚀殆尽的纸与笔。\n感激，眷恋，不舍，祝福，美。她要把这最美好的这一切，都留给柯蕾特。\n「……致柯蕾特。奥尔拉，于火中。」\n诗笺的句尾，她留下了最后的落款。\n百米外，花园对面的道路上，柯蕾特似乎感应到了什么。她抬起头，猛烈的火光映照着她的脸。\n泪水从她脸上滑落，在火焰的炙烤下，很快消失不见。"
  },
  CollectionHall_127142_Title = {
    Text = "诗笺的句尾"
  },
  CollectionHall_127143_Desc = {
    Text = "他们在黑暗的河流中划行，苍白，沉默，疲惫不堪。\n朦胧的雾气伸长触手，将他们拉入黑暗，徘徊在没有尽头的永夜中。\n\n后来，他们看到了一束光。\n那是来自遥远岸边的曦光，它忽明忽灭，却足以照亮暗淡的灵魂。\n于是他们循着光，笨拙地划出黑暗，来到破晓的黎明面前。\n也来到你们面前。\n\n或许这只是一次短暂的相逢，但他们用力挥舞双手，竭力呼喊。\n所有人都沐浴在神圣的曦光下，所有人都在笑着。\n他们说——\n愿每一个相聚的瞬间都如节日般珍贵。\n愿真诚的心永不停止跳动。\n愿银钥指引前行。"
  },
  CollectionHall_127143_Title = {
    Text = "极夜与破晓"
  },
  CollectionHall_127144_Desc = {
    Text = "风从四面八方涌来，你手持蜡烛站在迷宫入口。\n你有些迷茫。\n似乎上一秒，你还在弥萨格的食堂里，听夏洛特讲一些关于图书馆地底迷宫的传说。\n而现在，你穿着睡衣，睡眼惺忪地行走在一个接一个的甬道里。\n「夏洛特，夏洛特……」\n伴随窸窸窣窣的响动，白色的蜘蛛潮水般涌入。\n它们凝结成苍白的少女。她坐在肉块雕砌的秋千上，一荡一荡的。\n\n「你来了。」她说。\n「我来找夏洛特，我的朋友。她迷路了，我要找到她……」\n你几乎就要哭出声来。\n少女咯咯笑了起来。她跳下秋千，走到你面前。\n「你忘了吗，我们的交易……」\n女孩伸手抚上你的肚子，恍然大悟。\n「对哦。你早已成为我的子嗣，所以什么都不记得了。」\n「子嗣……？」\n你低头感受着你们肌肤相处的地方。\n温暖的触感如蛛网般深入皮下，再蔓延到血管的最深处。\n少女神秘地眨了眨眼，凑近你耳边轻声说：\n「夏洛特，就在你的肚子里呀。」"
  },
  CollectionHall_127144_Title = {
    Text = "苍白后裔"
  },
  CollectionHall_127145_Desc = {
    Text = "巨大的舞台上，一个少女正在舞蹈。\n她头发紧紧地梳成一个发髻，头上点缀着洁白的羽毛和小巧的王冠，纯白的舞裙随着她的动作展开，在哀婉的提琴声中转了一圈又一圈。\n手臂舒展，足尖点地，白天鹅低垂长颈，向王子诉说自己的悲伤与哀愁。\n年幼的莉兹微张着嘴，看着台上轻盈优雅的少女，那是她的堂姐，在她出生以前就到她家里来，在她祖母手下接受严格的训练。平日里总是朴素而且安静的堂姐从未如今天这般鲜活，她就像一只即将振翅而去的天鹅，而她，他们，剧院里的所有人，都倾倒在她的阴影之下。\n她的心跳越来越快，越来越快——多么令人羡慕！她也想成为那只天鹅，在永恒的舞台上长久地留下属于自己的倒影。她知道自己做得到，难道祖母不曾在她不注意的时候称赞过她的腿又长又直吗？难道她那做了多年首席的表姐不曾说过，她极有舞蹈天赋吗？没错，只要她开始，只要她穿上足尖鞋，人们一定会从遥远的城市前来观看演出，她将是本世纪最伟大的舞者，芭蕾艺术的璀璨明星！\n那时的她还不知道，等待自己的，只有炽热的火焰。"
  },
  CollectionHall_127145_Title = {
    Text = "旋转，旋转"
  },
  CollectionHall_127146_Desc = {
    Text = "这是你来到弥萨格的一年后。 你仍然记得你从那场大爆炸中醒来后，第一次踏入这所学校的那一天。你被发放了合身而规整的校服，拥有了独属于自己的宿舍，第一次参观餐厅并吃光了两摞餐盘。 所有轻松的时刻在这一天戛然而止，转眼你就因过于贫瘠的知识和婴儿般光滑的脑回路，被勒令就读为期一年的预科班。 语言学习，体能特训，银芯能力测试，特种生物常识补充……在饱受折磨之后，你的成绩好坏参半，你那不及格的雷欧通用语成绩和一次性链接了三个唤醒体的壮举让你在校园中名动一时。 幸运的是，出于你特殊的能力与卓绝的天赋，你还是迅速达到了一位调查员的能力标准，不必再继续延长预科的时长。至于你那些参差不齐的短板，就由那些逐渐默契的伙伴们替你补习与兜底。啊，这里虽然盛产魔鬼，那也是一群可靠温柔的魔鬼。 这里常常多云、落雨、少有晴天，无数被遗忘的和将被遗忘的人们始终坚守、牺牲、不断前进。 在这样诸事如常的一天，弥萨格迎来了又一年的开学日。 你对着镜子整理好校服的衣领，抚平每一丝褶皱，而后推开了宿舍楼的大门。 「哈欠，终于来了，我都快睡着了。」 「你是在宿舍里学习抱窝吗？新生。」 你冲萝坦讪笑一声，对着那个足以引起你生理恐惧的粉色身影缩了缩脖子，躲到了一旁笑着的拉蒙娜和奥吉尔身后，五道影子在清晨的校园里摇晃着拉长。 「走吧，搭档。」 「从今天起，你就正式成为弥萨格的一员了。」"
  },
  CollectionHall_127146_Title = {Text = "开学日"},
  CollectionHall_127147_Desc = {
    Text = "沿着泰姆河一路向下，向右拐至贝克曼街，继续行走大约一百英尺，你就能在那不起眼的角落看到「莱克侦探事务所」。\n\n作为伦蒂尼恩破案率最高的侦探事务所，这里没有塞满专业书籍的大书架，没有贴满剪报的墙面，也没有精致的下午茶。\n你大概率只会撞见门前挂着的「有事外出」标牌以及趴在一旁的疲惫老狗。\n\n若是运气好点，在某个天气晴朗的周日上午，你兴许能等到宿醉归来的名侦探先生。\n此时他刚结束上一把赌局，兜里没剩几个钱，你可以尽情向他提出你的无理委托：寻找猫咪、解救入了邪教的老母亲、搜集丈夫的外遇证据……\n只要你有，他就能接。\n\n「我享受濒死前的瞬间，所以我注定会成为一名赌徒。」\n「那成为侦探呢？恕我直言，我看不出寻找猫咪和濒死之间的相关性。」\n「不，你不明白……寻找真相的过程本身就已足够迷人，不论大小。就像……」\n「就像奔赴一场和死亡的约会。」"
  },
  CollectionHall_127147_Title = {
    Text = "好运时间"
  },
  CollectionHall_127148_Desc = {
    Text = "波吕克斯做了一个梦。\n他梦见自己身披银色的铠甲，从一位威严的国王手中接过一柄光洁如月的长剑。\n而后他跨上高大的白马，奔赴向一个洞窟之中，当他深入地底，洞口的树木都簌簌地发出细微的呢喃。\n洞窟的深处潜藏着一团暗绿色的阴影，那是一个高大如肉山的怪物，它怪异的双眼冒出绿色的光芒。\n「危害国家的怪物啊，我不能允许你再威胁我们神圣的国度，今日，我将用这柄正义之剑将你消灭！」\n那怪山颤抖着，似乎在回应一般，发出恐怖的吼叫。\n波吕克斯听不懂它的语言，也无意听懂它的话语，他举起宝剑，与那散发着邪恶气息的怪物战斗起来。怪物的触手遍及洞穴昏暗的边界，与光辉的长剑碰撞出铿锵的脆响。\n如每一个英雄故事的结尾一样，英勇的骑士跨上怪物的后背，在怒喝中将剑尖插入了怪物的胸膛。\n怪物颓然倒下，波吕克斯在如释重负的喘息中，怔愣凝视着剑下慢慢扩散的痕迹——那丑陋邪恶之物的身躯中，怎会流淌着如此温热鲜红的血液？\n他从梦中猛地惊醒，那鲜血沾染双手的黏腻触感仿佛挥之不去，他的余光忽然看到了那本被卡斯托尔珍藏的旧书，正小心地被藏在床后的缝隙。\n他将那本书随意地翻开，恰巧是卡斯托尔常常翻阅的那一篇骑士故事，在书页的正中，他看到这样的一句预言：\n「当邪恶的怪物被勇士击败，人人将见天空中有异象，日头要变为黑暗，月亮要变为血。」\n波吕克斯皱了皱眉，不屑地将这本旧书扔回原位，在月光下喃喃祈祷起来。\n「神的仆人被差遣到这里来为你们赐福，使你们洗脱罪孽，从黑暗中归向光明，和一切纯洁的义人同入净土……」\n持灯者并未关照祂虔诚的侍从，噩梦带来的不安仍在那颗心脏深处颤动，那是他沉眠的灵魂在梦中默默地哭泣。"
  },
  CollectionHall_127148_Title = {
    Text = "扭曲的骑士诗"
  },
  CollectionHall_127149_Desc = {
    Text = "<Bold:1月24日>\n身上臭烘烘的。\n今天和特蕾莎管家乘车回家时，路过南安普区。\n这不是一次愉悦的体验。\n那是个危险的地方@2有些家伙身上长了奇怪的伤口，像是三角形的孔洞。\n特蕾莎管家说这是主降临给异教徒的惩罚。\n\n<Bold:2月22日>\n发烧一个月。\n今天总算吃了点东西。是新鲜的牛排，鲜嫩、多汁……\n对，多汁。\n红色的@2腥甜@2美味\n家里所有的镜子都被收了起来，连波比都不敢看我。\n嘻嘻。他们都不知道，晚上的时候，我能从窗户的投影中看到自己的模样。\n我的脸上、脖子上、胸口上……从上到下，密密麻麻，\n长满了黑色@2三角形\n\n<Bold:3月17日>\n我的眼膜就像被罩上了一层红色的细纱。\n世界变成了血的颜色@3\n父亲站在血雾里朝我大喊大叫，这是他第一次用这么大的声音和我说话。\n他离我很近，声音却离我很远。我闻到绝望、厌恶和血。\n不要@2带我走，不要……"
  },
  CollectionHall_127149_Title = {
    Text = "饕餮寓言"
  },
  CollectionHall_127150_Desc = {
    Text = "埃里温人居住在灰色的石之城里，毗邻绿色的大湖。\n\n大湖没有名字，早在埃里温人有记忆起，它便存在于此。\n相传，邪恶的女妖被封印在湖水深处。\n她与大湖同样古老，是鸿蒙初开之时被粗鲁塑造的可怖存在。\n天真又胆怯的埃里温人惧怕女妖，他们试图讨好女妖，确保她能永远安静地待在湖底。\n\n「应该做点什么呢？」\n「是啊，做点什么呢？」\n「那就跳舞吧！无论如何，跳舞总是好的。」\n\n于是，每逢凸月，埃里温人聚集在湖畔，面对纸草做成的偶像翩然起舞。\n彼时月明星稀，一切和平。\n\n数百年后，埃里温人忘记了历史，忘记了寓言，也忘记了偶像。\n在石之城建城的千年庆典上，他们放肆欢笑，畅饮美酒。\n嘈杂的声音投入湖中，就像石头入水，以无穷无尽的圆圈从湖中央蔓延，最终触及深处的存在。\n于是，恰逢凸月，埃里温人听到了声音范围之外的声音，见到了视觉范围之外的月亮和火焰。\n他们最终也成为寂静的一部分。\n\n这些无限空间内的永恒寂静使埃里温人充满恐惧。\n他们被迫像神秘主义者一样端坐不动，眼见新的族群在他们面前放肆欢笑，畅饮美酒，来来去去，周而复始。\n所以宇宙会永远继续膨胀，星系会越来越远，所有事物都会消亡。\n事情就是这样。\n埃里温人是否为此感到孤独一点也不重要。"
  },
  CollectionHall_127150_Title = {
    Text = "无声欢宴"
  },
  CollectionHall_127151_Desc = {
    Text = "女孩睁开眼，发现自己身处一片黑暗之中。\n「喂！」她大喊，「有人吗？」\n回声在看不见边界的空间中飘飘摇摇，逐渐散去，女孩深吸一口气，再次大喊：「姐姐，布朗，西区佬！」\n「有人吗——」\n比先前音量更大的问句遥遥飘远，又缓缓归来。几缕荧蓝的光仿佛被回声牵引由远及近，它们由无数悬浮飞舞、细如尘埃的粒子构成，如蛇一般在空中蜿蜒前行，又如海浪一般起伏。一条接一条的光带一刻不停地掠过站在原地的女孩，迅速将整个天地变成一片星海，细小的粒子穿过女孩的手指和发间，没有留下一点痕迹。\n「这是……什么？」\n发光的尘埃在她周围微微起伏，没有回答。\n「我记得蜡像馆，记得姐姐，我……好像是死了，这里是天堂吗？」她左右张望，「怎么连个天使都没有，该不会是地狱吧！」\n她的声音落在自己耳边，这一次，连回声都不再出现。\n一种莫名的孤寂感从她心底而生，恍惚间，她好像回到了遇到姐姐，遇到布朗之前。阴暗的下水道臭味弥漫，她又冷又饿，却无法离开，因为有人在将她推下来后，在下水道顶上压了个大桶。\n她拍了拍自己的脸，迈开步子向前走去。\n尘埃在她身前分开，又在她身后聚拢。抬腿，落脚，抬腿，落脚。她就这么一直走，一直走，不知道自己走了多久，也不知道自己走了多远。在她前面的是更多的尘埃和黑暗，而在她身后，不论是来的方向还是走过的路，都已经了无痕迹，直到——\n「唤醒成功了，詹金，詹金，你听得到吗？」"
  },
  CollectionHall_127151_Title = {
    Text = "迷失的道路"
  },
  CollectionHall_127152_Desc = {
    Text = "创生的父神自星空中来。\n那时的地是赤焰热土，烈火熊熊。父神的足踏在火上。\n父神说，火终将熄，火便这么做了。\n流动的土成了地，父神在地上写下神言：\n地将做生灵的基。\n山谷就成了山谷，平原就成了平原。\n神言稳固，这是第一块石板。\n\n父神看云厚重，说，云终落雨，云便这么做了。\n雨汇聚成流水，父神在其上写下神言：\n水将做温床。\n水就成了湖、成了海，海就淹没了地。\n神言稳固，这是第二块石板。\n\n父神看水暗淡，说，光当降临，光便这么做了。\n光落在水上，父神在光上写下神言：\n光将滋养。\n光就带来温暖。\n神言稳固，这是第三块石板。\n\n父神见地、水、光皆有了，说，生命将临。\n祂让自己的血流下，在其上写下神言：\n血将孕育新生。\n父神的血散了去，成了有生命的物，在海中繁衍。\n神言稳固，这是第四块石板。\n\n父神见生有了，说，生物将永恒地变化。生物便这么做了。\n微不可见的物爬上退了海水的地。\n父在变化的物上写下神言：\n变化不可停止。\n爬上陆地的物就长出根茎，长出四肢，长出各种模样。\n神言稳固，这是第五块石板。\n\n父神见生有了，变化也有了，说，死亦将至。死便来了。\n衰老的死去，病弱的死去。父神在死上写下神言：\n死的将回归到最初。\n死者的躯体就慢慢消了，回到父神的怀抱。\n神言稳固，这是第六块石板。\n\n父神见生、死、变化都有了，说，这些都是我的造物，我将留下祝福。\n父神取出自己的骨，在上面写下神言：\n在万物的末路，可用我的骨，代行我的权。\n以血肉的代价赋予生机。\n神言稳固，这是第七块石板。\n\n父神看一切都有了，就停下来休息。\n水将父神包裹起来，光为父神提供温暖，地将父神遮盖。\n而后父神长眠，万物都依照父神的言生存，那就是现在的世界。"
  },
  CollectionHall_127152_Title = {
    Text = "神言石板"
  },
  CollectionHall_127153_Desc = {
    Text = "他即是通晓万事之王，是利莫里亚的至高无上。\n青金石是他的王座，黄金是他的冠冕。灵魂是他的权柄，他在最高处安睡。\n侍奉神的祭司也侍奉他，在他身前跪拜，\n他们是他忠实的臣子，是他虔诚的信徒。\n\n神明在夜晚派遣月光，将他接到永眠的宫殿中做客，\n在那里，祂们与他分享灵魂的食物，给予他神的智慧。\n祂们赐他无尽的梦境，让他得以观见万物伊始，观见时间末路。\n他于是知道了：万物的初始皆是混沌，众神在其中苏醒，建立悬浮在黑暗中的宫廷。\n他于是知道了：时间之末是一片黑暗，一切重归混沌。\n\n众王之王啊，神的宠儿，\n谁能与你相同？\n谁能如你一般自梦中统领，谁能如你威严？\n高贵的神王啊，年幼的主宰，\n请你尽情沉眠。\n你的臣民与信徒会耐心等待，你带回神的预言。\n尊敬的螺湮主宰，号令深渊之主，\n请允许我们呼唤你的名，赐予我们庇护，\n图鲁，图鲁。"
  },
  CollectionHall_127153_Title = {
    Text = "神王的颂歌"
  },
  CollectionHall_127154_Desc = {
    Text = "多年来，我一直想着尤乌哈希。\n但只是在这些神庙的废墟里，我才第一次真正看清他。\n我看见他身上缠绕着沉重的枷锁，因而不得不趴在地上，伸长脖颈，费力凑近早已变质的餐食。\n像条狗一样。\n\n卡里古拉死后，身为暴君的同谋，他被锁在神庙的废墟至今。\n我拖动手上的锁链，将一个托雷斯的奴隶押送过来。\n他登时直立身躯，瞳孔放大，喉咙里发出急促的吞咽声。\n\n「等等。」\n我拽住锁链，将奴隶拉至他恰好无法够到的距离。\n「帮我杀一个人。」\n他咧嘴笑了，露出一排尖利的兽齿。\n「你是第19个这么和我说的人类，而我不得不拒绝你。」\n我竭力绷着脸，不让他看出我的失落：\n「为什么？」\n「如果你要我杀一千个人，我乐意至极。杀一个？你的筹码远远不够。」\n「如果那个人，是现在的皇帝呢。」\n我深吸一口气。\n「这个筹码足够吗？」\n尤乌哈希哈哈大笑：\n「这是数学问题，我的老伙计。一就是一，一千就是一千。」\n\n「着火了，金宫着火了！」\n远方燃起熊熊火焰。\n暴君，暴君……\n我绝望地哭泣，为了塞内加，也为了那即将成为废墟的华美宫殿。\n「这么伤心？」\n尤乌哈希凑了过来。\n他已经享用了那个托雷斯的奴隶，正满足地撮着嘴。\n是的，我向他许诺，只要能杀了暴君，除了自由，他还可以接着享用一千个无辜的生命。\n他能理解这场大火意味着什么吗？\n他能理解侍奉一个无可救药的暴君意味着什么吗？\n恐怕不能。\n他只是个畜生罢了。\n\n「罗马就像一个废墟。」畜生说。\n「或者说，你们的国家，世界……\n在我看来，是既无意义也无止境的废墟。\n你们为它流泪、互相残杀，做了一切徒劳又无意义的事……\n说实话，我不理解。」\n\n我望向他伤痕累累的躯体。\n这是由数百万血肉所铸就的魔像，它在数百年的岁月里，不断被打碎、重组，就像罗马一样。\n「那你呢？你也是一座废墟吗？」\n「或许吧。」\n他伸了个懒腰，狭长的眼里跃动着来自远方的金色火光。\n「但我不在乎。」"
  },
  CollectionHall_127154_Title = {
    Text = "血肉狂宴"
  },
  CollectionHall_127155_Desc = {
    Text = "螺湮的主宰啊，请聆听我的祷告。\n降下你的预言，给予我启示，\n让我能够复原你的国。\n在这无信仰的土地，在这海洋环绕的冰原，\n将你的石柱立起，将你的神殿搭建。\n\n号令深渊之主啊，台上的是献给你的礼。\n纯净的血肉来自满月的羔羊，强健的心来自成年的公牛，\n锐利的眼来自翱翔的雄鹰，坚硬的骨来自巡洋的鲸。\n青金石是你的王座，黄金是你的冠冕，\n请赐予我你的梦境，告予我神言，\n让我能够复原你的身。\n在这冰下的深渊，在这海下的领域，\n将正确时刻降生的母体奉献。\n\n通晓万事的利莫里亚之王啊，请回应我的祷告。\n自你入海长眠以来，已过了千百年，\n我以你的名，行你的事，宣扬你的美名，从未懈怠。\n坚定的是我的信仰，虔诚的是我的心。\n你是唯一的神王，是不朽者的化身，\n愿你终结我的等待，再临于世，让我得以聆听你智慧的言。"
  },
  CollectionHall_127155_Title = {
    Text = "虔诚的伟力"
  },
  CollectionHall_127156_Desc = {
    Text = "奥瑞塔出生时，大洪水带给城市的影响已经完全褪去了，但在偏远的乡镇上，人们还在为了活下去而挣扎着。\n\n洪灾让人们开始恐惧海洋与江河，能离开的早就离开了，如今还留在这个小渔村的，都是些在外难寻立足之地的妇孺。\n在这个沉闷冷清的地方，奥瑞塔是唯一的小孩。\n\n她执拗地相信着婆婆讲的童话——爸爸妈妈都已经回到了大海，他们在等待奥瑞塔长大。等她长大了，大家就能团聚，再次成为幸福的一家。\n\n在她还不会说话的时候，好像曾在很温暖的怀抱睡着过，但其他有关父母的事情，奥瑞塔已经不太能想得起来了。\n但身为在寂静之地出生长大的孩子，奥瑞塔并不理解「孤单」或「寂寞」，她自有一批朋友。\n\n和那些被洪水吓破了胆子的大人不一样，奥瑞塔从来都不惧怕海洋。\n海洋国王的住民，自然要和大海做朋友。\n奥瑞塔学会了和「同乡」一起玩。\n她模仿蛤蜊移动的样子舞动，学着小丑鱼在海草中梭巡。\n她趴在棱皮龟的背上，顺着海浪漂流到了离陆地很远很远的地方。\n她在被倾注满月光的大海中，与水母群在海中嬉戏。\n\n她是快乐，她是想象，她是精灵。\n\n她是梦。\n"
  },
  CollectionHall_127156_Title = {Text = "海之梦"},
  CollectionHall_127157_Desc = {
    Text = "眼见一个乡下村姑穿戴浮夸的礼裙、金银首饰、羽扇，潜入上流精英人士的世界……\n没有比这更不得体的事情了。以下犯上，简直是以下犯上……！\n要我说，应该强制下等人佩戴相应的标识和徽章，这样才不至于和我们混淆在一起。\n——菲利普·哈罗德公爵\n\n如果您生活在伦蒂尼恩，一定对所谓的「索蕾尔效应」有所了解。\n还在苦恼自家衣服卖不出去？那你最好祈祷自己有点门路，能获得索蕾尔夫人的青睐——是的，哪怕是一顶愚蠢透顶的猪尾巴礼帽，只要戴在索蕾尔夫人的头上，它就能大卖。\n她就是新时代的大众偶像。\n——「索蕾尔夫人的名气测验」，《淑女指南》\n\n那是一个晴朗的夏夜。\n我们一起坐在大理石铺就的露台上，喝着陈年酿造的贵腐酒，谈论诗与世界和平。\n然后就发生了一些@4\n说重点？咳咳，对不起……\n总之，这个女人骗了我三千雷欧坊，两份苏里兰的房产，以及一颗诚挚的心！\n——某不愿透露姓名的心碎子爵"
  },
  CollectionHall_127157_Title = {
    Text = "以蔷薇之名"
  },
  CollectionHall_127158_Desc = {
    Text = "分开。经历。蜂拥而来。侵略。\n\n对于非利士人的闪族语词根「p-l-sh」的真正涵义，经书学者们历来分歧不断。\n平生第一次，戈利亚觉得这些老学究还算有点真才实学，因为这四个简短的词汇几乎概括了他作为非利士人的一生。\n\n非利士人是名副其实的海上民族。\n他们是群聚的长尾鲨，循着鲜血的味道找到可供栖息的岛屿，再杀光那里所有的原住民。\n\n非利士人不知疲倦。\n他们从不逗留，当一切尘埃落定，躁动不安的基因又驱使他们离开，寻找新的猎物。\n\n非利士人不在乎明天。\n他们总是以惊人的速度挥霍掠夺来的财富，饮尽最后一滴葡萄酒，然后尽情繁衍、争斗、背叛……\n\n启航的时候，戈利亚回望船只在海面上拖曳而出的轨迹。\n非利士人的血，原住民的血，敌人的血，海鸟的血……\n它们汇到一处，就像暗红的墨涌入无边无际的蓝。\n\n第二天，太阳照常升起，海水如万片碎金动荡闪烁，一切都了无痕迹。\n他们身处海洋，海洋却已将他们忘却。"
  },
  CollectionHall_127158_Title = {
    Text = "巨人之刃"
  },
  CollectionHall_127159_Desc = {
    Text = "卡修利亚民间流传着沉没文明的传说。\n\n相传远在历史记录前，星辰的异常移位使一个史前文明沉入了海底，而卡修利亚人就是那个文明的后裔。\n除了经商、渔业外，卡修利亚人出海的一大目的就是寻找失落的先祖文明。\n他们相信，在特定星位下出生的女孩会与先祖文明有感应，她们能指引沉没文明的方位，也能从风浪中庇佑船队。\n\n希莱斯特就是这样被选中的。\n她被捆缚在高悬白帆的桅杆上，看着下方的人类忙忙碌碌。\n她既不关心，也不好奇。\n\n希莱斯特能从海风、海鸟的动向中感知海上的天气，偶尔也能探知来自遥远沉睡之地的气息。\n她天生就是属于大海，属于航船的吧——希莱斯特时常这么想，被禁锢的事实似乎在她的心里没有起任何波澜。\n有时候她会离开桅杆，追寻海空中飞翔的白鸟，那时行船就会紧紧地追着她不放。\n人们相信少女是航行顺利的象征，受祝福的船只能够平安返航，带来巨额的财富与先进的文明。\n而她对此一无所知。"
  },
  CollectionHall_127159_Title = {
    Text = "引舵之帆"
  },
  CollectionHall_127160_Desc = {
    Text = "噔，噔，噔。\n脚步声由远及近传来，头戴礼帽的绅士穿过废墟，站在奄奄一息的看守面前。\n绅士：你在这里做什么？\n\n（绅士患了严重的口吃，看守则喜欢兜圈子。为了您的阅读方便，笔者只摘录谈话重点。）\n\n看守：我在看守监狱。\n绅士望了望四周空无一人的原野，以及因沾染融蚀、正在缓慢塌陷的废墟残骸。\n绅士：可是这里没有监狱，也没有囚犯。你的王国早就不存在了。\n看守：我在看守监狱。\n绅士：为什么？\n看守抬起头，稚气未脱的脸上带着茫然与坚定。\n看守：我不知道……我想回家。\n看守：我替那位大人看守监狱。大人高兴了，我就能回家。\n至于那位大人是谁，为什么要替他看守，她自己也搞不清楚。\n绅士并不追问，仿佛这是再自然不过的事情。\n绅士：你的家乡，那是什么样的？\n看守：那里只有冬天和黑夜，还有一望无际的森林与大海。\n绅士：听上去不适合居住。\n看守：我讨厌白天。看到了吗，我是蜡做成的，如果接触到太阳，我就消失了。\n看守：所以我只能躲在这里，没办法自己回家。\n绅士若有所思地点点头。他忽然兴奋起来。\n绅士：真巧，你是由蜡制成的，而我刚好是个蜡像师。\n绅士：我们来做个约定吧——我可以让你行走在日光下，我还可以帮你找到回家的路。作为交换，你要成为我的助手。\n看守：助手，那是做什么的？\n绅士：你可以替我看守蜡像馆。它和这座监狱不一样，它是艺术，艺术是不会坍塌的。\n看守：艺术这么厉害？\n绅士开心地笑了起来。\n绅士：是的，就是这么厉害。\n\n故事的结尾，看守稀里糊涂地跟着绅士走了，正如她稀里糊涂地来到这所监狱一样。\n她一直是个随遇而安的家伙。"
  },
  CollectionHall_127160_Title = {
    Text = "欲海浮沉"
  },
  CollectionHall_127161_Desc = {
    Text = "你踏上了一片杳无人烟的荒原。\n人类活动的痕迹消亡已久，灵魂枯槁的生灵在灰烬与尘霾中艰难跋涉。\n这里的存活不值得歆羡，无人知晓旅程的终点，只在无尽循环的光景中徘徊、徘徊、徘徊。\n直到他们的脚步滞涩，重重栽倒在地，仰望着天空伸出呼唤之手——\n\n愿我的跋涉终结之后，\n以尸骨为沃土、为滋养、为源泉，孱弱的新芽重新破土。"
  },
  CollectionHall_127161_Title = {
    Text = "重生于湮土"
  },
  CollectionHall_127162_Desc = {
    Text = "她曾一万次在深夜中发问，为什么她要承受这无尽的痛苦？\n无人回答。\n呢喃穿过嘶哑的喉咙变成碎屑，没有传达到任何一位神明耳中。\n她的痛长久难消，逐渐发酵成了脓汁，化作越来越浓郁的仇恨。\n忽然有一天，她发现周围的人身上开始渗出黑色的液体，和自己身上流出的血液那么相像。\n他们很快变得癫狂，就像自己一样。\n或许那是他们的痛苦，她冷眼旁观，又隐隐感到一丝快意。\n可如果那是痛苦，自己岂不是早就被黑色所淹没。\n她接近了那些遗留下来的黑色，却意外获得了自由。\n自由没有给她带来解脱，她如同被流放在地狱千年的恶鬼，心中的愿望早就由仇恨腐蚀殆尽。\n她的身体嵌进枷锁，她的心灵坠满铅块。\n唯有那些凄厉的叫喊能够洗刷她沉重的灵魂，让她得以畅快地呼吸。\n来吧，品尝我曾品尝的，让你成为我。\n她发现红色是多么美妙的一种颜色。\n她终于明白，痛苦没有缘由。\n要么自己痛饮，要么邀人共尝。\n今夜她斟满苦酒，与整座城镇相邀。\n"
  },
  CollectionHall_127162_Title = {
    Text = "沉入殷红"
  },
  CollectionHall_127163_Desc = {
    Text = "我的船被什么紧紧缠绕，螺旋桨吃力地挣扎着，声音可怖。\n积雨云在我们头顶汇集，乌黑的云层中雷电翻涌。\n惊雷打在桅杆的瞬间，螺旋桨挣脱了束缚，再次转动了起来。\n我松了一口气，轮机长却开始尖叫。\n\n海水中混入了一种粘稠的液体，暴风雨的野外，气味随着风被吹到了远处去，我的鼻子只闻得到死亡。\n但我意识到，那闪烁着荧光的液体是某种血液。\n我最亲爱的伙伴，我最信任的船，在沉没前倾尽了全力——她那本应劈开海水的叶片，狠狠切下了怪物的触手。\n\n这是幸运的预兆！我们很快就能驶离暴风雨！\n我正想以此安抚我的船员，可就在抬头的瞬间，一道光芒出现在了暗海中央。\n那是灯塔吗？怎么会呢？不，不可能。\n这里是大洋中央，最近的陆地在数百海里外，怎么会有人，又怎么能够在这里建造灯塔呢？\n\n我的水手们开始哭泣，开始祈祷，开始齐声唱起了故乡的歌谣。\n然后，那灯塔陡然熄灭了。\n一切的光都消失不见，咆哮的风暴也化为淅沥小雨落在甲板上。\n水手们赞颂着仁慈的主，沉浸在劫后余生的喜悦中。\n可我确是看清了的。\n\n那消失在光芒中的，确实是一个身姿曼妙的女人。"
  },
  CollectionHall_127163_Title = {
    Text = "于暴雨之中"
  },
  CollectionHall_127164_Desc = {
    Text = "当英雄终于结束他的伟大旅程，人们合上图画书的最后一页，沉沉睡去。\n\n长夜将至，属于希洛的故事才刚刚开始。\n\n她沿着悠长的海岸线一路向北，踏过溪流，翻越高山，直到极寒之地的尽头。\n距那场震惊世人的反抗已过去多年，希洛所到之处风调雨顺，诸事皆宜，奴隶和主人之间维系着微妙的平衡，暴烈的反抗显得尴尬又滑稽。\n她被质疑，被嘲弄，最后被遗忘。\n但她从不辩解。\n\n战士希洛来去无踪，她将自由的种子深埋在陆间海的腹地。五年、十年、一百年……\n总有一天，它们将破开土壤，茁壮成长。\n\n无人知晓这位斯巴达杀手最终的埋骨地，据说她的昔日密友伊巴密浓达收敛了她的尸体。\n多年以后，当你路过一个茉莉花盛开的青草坡，或许能见到一方小小墓碑，上面写着：\n\n这块草地下埋藏着一名战士，或者说\n她曾是一名战士\n她是老伯利克里之女，也是提洛岛的骄傲\n诗人弗拉库斯称赞她作战英勇无比\n黑发的斯巴达人更清楚她的功绩"
  },
  CollectionHall_127164_Title = {
    Text = "挣脱锁链之日"
  },
  CollectionHall_127165_Desc = {
    Text = "A.F.@1年@1月@1日\n\n08:00\n\n对编号为107至133的部件进行组装。\n\nC类型部件就差这一点了，完成后将作为自动人偶「嘀嗒人」的能源核心投入使用。\n\n我本想亲自组装的，但@2说，负责人要学会信任自己的工作伙伴。\n\n真好意思说，明明她才是那个检查部件检查到半夜的人。\n\n-------\n\nA.F.@1年@1月@1日\n\n00:21\n\n电机MF311000组装完毕，齿轮吻合，管道通畅，目前各项机能正常。即将进行最后修正。\n\n13:07\n\n接入特殊能源S，电机MF311000运转良好，与EA307850号人造躯体适配良好，人造躯体正常运转。\n\n@2很乐观，她觉得我们这次能比之前走得更远。我提醒她不要忘记第五次唤醒尝试时发生了什么，她就堵着耳朵说听不见。那次要不是我反应快，能源核心自燃的火焰会把她的头发都烧光。\n\n真该让她尝尝光头的滋味，说不定这样她还能学会谨慎。\n\n-------\n\nA.F.@1年@1月@1日\n\n14:55\n\n最终准备完毕，能源准备完毕，束缚装置已开启，束缚状态：良。躯干将在唤醒完成后进行安装。\n\n15:00\n\n开始「嘀嗒人」第13次启动尝试。\n\n15:05\n\n躯干EA307853运转正常，电机MF311000运转正常。「嘀嗒人」颈部关节活动正常，「嘀嗒人」头部部件运转正常。\n\n15:15\n\n「嘀嗒人」成功执行眨眼、视线跟随、张嘴指令。电机存在发热现象，但仍在可接受范围内。\n\n即将进行四肢部件安装，上天保佑我们这次顺利。\n\n18:07\n\n执行行走指令时，电机核心熔解，线路烧毁。特殊能源S完好无损。\n\n@2对这个特殊能源很保护，即使是我都禁止触碰。我想我可以理解，那确实是一个神秘的物件，看上去就像是普通的金属银，也不像有能量储存的能力的样子，却真的能给自动人偶供能，而且那样高的温度也没有对其造成损坏，实在是不可思议。\n\n如果这个东西能够批量生产，或者大量开采……\n\n或许我该找一天再问问她，也不知道她在这个人偶上还要花多少时间。哪一天她自己变成一个人偶，我都不会感到意外。\n"
  },
  CollectionHall_127165_Title = {
    Text = "核心熔解"
  },
  CollectionHall_127166_Desc = {
    Text = "「我们用凡俗的铜与铁，丈量星辰的轨迹，但无尽的深渊有自己的算法，阴晴不定。」\n逐渐沉没的游轮里，克珀珊特吟诵起《领航员挽歌》。\n她早已知晓自己的命运，也早已选择自己的命运，因此对面死亡，她没有恐惧，只有平静——平静地燃烧，平静地完成最后一次的领航。\n但焚烧的火光太过炽热，她看不见前路，发不出声音，也无法挥舞旗帜，这样残缺的指引下，船只是否能够正确航行？\n她不知道，并因此产生出恐惧与忧虑。\n这时《领航员挽歌》给出了指引：「年轻的领航员啊，你终将被咸水拥入怀中，化为引路的磷火。」\n引路的磷火？克珀珊特沉默。她确实听闻过在水手间流传的圣艾尔摩之火的故事，然而区区凡人之躯，如何化为照亮人世的圣火？\n但即便希望渺茫，克珀珊特也在内心中不断祈求：祈求自己能够履行职责，完成最后的指引工作。\n除了克珀珊特自己，没有人能够听到这祈求，但这已经足够了——\n黑暗中，银芯以融蚀浆为养料，迸发出强烈的光芒，实现了她最后的心愿。\n「潮汐黑册将记载你的名讳，令咆哮的怒涛为你奏响永恒的安魂曲。」\n她最终如《领航员挽歌》所言，死亡于大海。\n但她又超越了《领航员挽歌》。\n那是人类领航员面对大海时的狂妄与劝诫，而如今，她已成为圣艾尔摩之火，永恒指引船只。"
  },
  CollectionHall_127166_Title = {
    Text = "圣火中的指引"
  },
  CollectionHall_127167_Desc = {
    Text = "她被称作伴随着死亡出生的诅咒之子，不被祝福的女儿。\n属于她和妹妹的「襁褓」刚刚破裂，绚烂的光便从缝隙中流出，在地上扎根。一瞬间，绿草枯萎，鲜花灰败，连远方的大树，湖中的游鱼，都被她吸取了生机，成为一个个无魂的躯壳。\n她的族人大惊失色，赶忙将所有其他襁褓转移。她努力破开襁褓，像雏鸟破开蛋壳，伸出的手却被厌恶地躲开，目之所及的是一张张嫌恶的脸。\n只有她妹妹，那晚于她降生，又早于她成熟的妹妹，永远会抱着她。为她用灵鸟一般的歌喉唱出一首又一首摇篮曲。\n睡吧，睡吧，我亲爱的姐姐；\n睡吧，睡吧，好梦终将降临。\n\n她不该存在的，如果她不存在，她那流光溢彩的妹妹就不会被染上罪恶的阴影。\n我可怜的妹妹啊，她总是想，你承担了本不该承担的生存的代价。\n我可怜的妹妹啊，她总是想，只要姐姐能够做到，就一定为你竭尽全力。\n睡吧，睡吧，我亲爱的妹妹；\n睡吧，睡吧，在梦里我也爱你。"
  },
  CollectionHall_127167_Title = {
    Text = "吞噬摇篮曲"
  },
  CollectionHall_127168_Desc = {
    Text = "他看见教堂的尖塔如同蜡烛般融化，滴落在神父洁白的羽翼上。彩绘玻璃上的圣徒像以极快的速度腐烂成骷髅、又在瞬间倒退成为婴孩。尖锐与圆柔的几何体从信徒的口中颂念出，堆满整个大厅。\n他看见火车站的空间反复折叠成非欧几里得空间，远处的站台近在咫尺，近处的检票口遥不可及。大厅的钟表逆时针旋转，枯骨般的人群如同被看不见的线条提着倒退行走，浓稠的紫罗兰般的烟雾从云端飘进火车的烟口。\n他看见森林里的「空」凝成实体，树木、岩石、藤蔓只是「空」的边界勾勒出的半透明的轮廓线。天鹅的羽毛是不断变换的马赛克色块，它们游过的地方，湖水凝固成半透明的彩色玻璃。情侣依偎的长椅下， 鲜艳的橙黄色的影子正试图啃噬主人的脚踝。\n他看见歌剧厅的音符如雨点般砸向观众席，他看见墓地微微起伏，就像一只呼吸着的巨怪的皮表……\n他看见了很多，很多。他将他所看见的告诉他的母亲、老师、朋友，他将他看见的绘入画里。他想把他眼中的世界带到人们面前，可他身边的人越来越少，一个世界离他越来越远。\n但这是为什么呢？他只是将他所见到的东西记录了下来。皮克曼怎么想也想不明白。\n悲伤的皮克曼站在镜子面前。他看见一只食尸鬼冲他咧开长满尖牙的嘴。\n「没有什么比看见目睹真实更加重要。疯狂，混沌，贪婪……要去看看吗，皮克曼？」\n明悟的皮克曼向他微笑着，跨入那面镜子。\n他只想亲眼目睹那最为极致的疯狂的真实，将它们忠实地描绘在他的画布之上。\n他不是人类，也不是食尸鬼。\n他只是写实主义绘者皮克曼。"
  },
  CollectionHall_127168_Title = {
    Text = "写实主义悖谬"
  },
  CollectionHall_127169_Desc = {
    Text = "当一个人能够知晓全部的过去与未来，等待他的不是全知的喜悦，而是无尽的悲悯与绝望。\n她的双眼能看到万事万物背后的丝线，线的这一头连接过去，线的那一头连接未来。\n那丝线被人们称为命运。\n她是如何看待那一个个跟随在她身边的人呢？\n人们善良仁爱，人们傲慢多疑。\n但那些人的命运与人类的命运都在每次见面的开始就已经注定。\n她必定是喜爱他们的，否则何以一次次伸出援手、给予火种。\n她必定是期许他们的，否则何以在毁灭中坚定地走入轮回的阴影。\n因喜爱，她长怀悲伤。\n因期许，她屡屡失望。\n她深陷在黑色的泥沼，于无数的黑色丝线中不断梳理着，不厌其烦。\n命运的轮盘一次次回转。\n她看到贪婪的火焰席卷苍穹。\n她看到盲愚的偏执走向自戕。\n她看到痴狂的妄念加速毁灭。\n无序的混沌总会姗姗而来。\n希望与绝望徒劳地轮转，永无止境。\n直到她在黑暗之中看到一瞬的星光。\n那光微弱，但她已在黑暗中太久。\n直视的那一刻，竟然流下眼泪。\n"
  },
  CollectionHall_127169_Title = {
    Text = "隐世的转轮"
  },
  CollectionHall_127170_Desc = {
    Text = "新的一年，你决定举办一场前所未有的仪式，以最庄重的方式，迎接时间的更迭。\n为此，你筹备良久。点燃蜡烛，让温暖的光晕照亮冬夜的校园；在训练场中央搭起高台，铺上缀满花纹的深红绒毯。你甚至亲手裁出无数条金箔与银纱缠绕的彩带，只愿这倒数的时刻超越告别的怅然，化作岁末与新年相拥时永不褪色的印记。\n可是……还差些什么。\n你走进旧仓库深处，拂去层层尘埃，终于寻出那座古董时钟。它的外壳斑驳，指针早已在时光的侵蚀下断裂、脱落，显然不能使用了。\n就在一筹莫展之际，泰旖丝出现了，身后悄然立着一座崭新的时钟。\n那座时钟无比熟悉。她依旧轻佻地笑着，眼底却藏着某种温柔的笃定。\n「怎么样，这座时钟，配上我的舞蹈，一定是最盛大的仪式。」\n「这……不会是塔薇的时钟吧？」\n「哎呀，您也知道她孤零零地待在池水里，太沉闷了。」\n「这样让她加入我们的仪式，感受我的爱意，或许能让她有点兴致呢～」\n午夜悄然降临，泰旖丝立在巨大的时钟前，像被时间亲手包装的赠礼。\n彩带如未烬的烟花缠绕她的身躯，在流转的灯光下漾出金红与银蓝的波纹。腰际那只饱满的蝴蝶结，恰是新年亲手系上的最后一个绳扣——她就是岁末最盛大的献礼，裹着欢愉的绸缎，等待被时间拆封。\n她的手臂缓缓升起，指尖溯着光影游走，最终指向身后那枚悬垂的时钟。十二个数字在表盘上连成光晕，在她的指尖跃动。\n弥萨格的众人仰望着泰旖丝纵情的舞蹈，仿佛被欢愉的气氛感染，开始随着她的韵律一同荡漾。\n而当钟声落下，她指尖轻点，触向永恒的起始。那被捆缚的礼物张开双臂，将储存在岁末的所有欢庆化作漫天纷扬的祝福，洒向人间。"
  },
  CollectionHall_127170_Title = {
    Text = "倒数时刻"
  },
  CollectionHall_127237_Title = {
    Text = "海城旧闻"
  },
  CollectionHall_127239_Title = {
    Text = "磐龙古国"
  },
  CollectionHall_129601_Desc = {
    Text = "<Title:简介>\n生活在与世隔绝的海岛上，开朗且充满野性的少女。\n由于活泼的性格和天生的怪力，许多人在初次接触时很难适应她过于热情的亲近。但只要相处过一段时间就会发现，她只是想要尽可能地帮助朋友。\n虽然有时她的帮助方式异于常人，不过就结果来看，大部分时候还是帮受助者解决了麻烦，大概？\n在解除抑制的状态下无法控制自身能力，导致实验室经常爆炸。\n因缺少必要的教育，有时莫丝需要比手画脚半天才可以让对话者理解自己的意思。当然，莫丝并不需要对方比划半天，她那超绝的直觉可以很好地解决这个麻烦。\n非常亲近诺缔拉和守密人。据她所言，三人之间有过一起冒险的约定，不过诺缔拉对此毫无印象，守密人则对那段经历闭口不谈。\n偶尔会在莫丝身边看到一只带着弥萨格帽子的海獭，莫丝把它叫做「小煤球二世」。每当这时，某些本该完成的作业都会莫名其妙地消失。"
  },
  CollectionHall_129601_LockTip = {
    Text = "唤醒「莫丝」后解锁"
  },
  CollectionHall_129601_Title = {Text = "莫丝"},
  CollectionHall_129803_LockTip = {
    Text = "需要通关限时活动「疾驰的欢愉专列：列车启程」任一关卡"
  },
  CollectionHall_129803_Title = {
    Text = "疾驰的欢愉专列：列车启程"
  },
  CollectionHall_129810_Desc = {
    Text = "在无法被记录的某个循环中，环行·拉蒙娜踏过钟楼后的花圃。\n余光瞥见玫瑰园中，丛丛鲜花正绽放得妍烈。\n罕见的片刻停滞后，她便抛下所有无谓的遐思，继续奔赴最终的战场。\n泥泞泼溅在血色般浓烈的花瓣上，转瞬被漆黑的融蚀浆吞噬，只留下风中傲然的背影。"
  },
  CollectionHall_129810_Title = {
    Text = "踏过泥泞的玫瑰"
  },
  CollectionHall_130218_LockTip = {
    Text = "需要通关限时活动「颠倒的新生：暗室手记」任一关卡"
  },
  CollectionHall_130218_Title = {
    Text = "颠倒的新生：暗室手记"
  },
  CollectionHall_130219_Desc = {
    Text = "这是一座没有记录在任何海图上的岛屿。\n从它诞生之初，名为「文明」的病毒便从未踏上过这片净土。\n这里只有沙滩，丛林，一眼望不到头的大海，以及……一位小小的少女。\n………………………………\n「爸爸，妈妈，鱼！」\n「嗷~~」\n两只海豚不紧不慢地游到少女脚边，发出优美清脆的叫声。\n其中一只将少女驮起，另一只接过少女手中刚被打晕的鱼，一口将其吞下。\n「嗷~~」\n「嘿嘿，莫丝！厉害！」\n像不谐世事的孩童，少女做了个很有力量感的动作，来回应「爸爸」「妈妈」的夸奖。\n「今天，太阳！好！」\n「莫丝！爸爸！妈妈！散步！」\n听闻少女的话，驮着少女的海豚轻吟一声，绕着小岛开始缓缓游动。\n温暖的阳光洒在少女身上，驱散了数日前挥之不去的湿冷，轻柔的风拂过少女的发丝，带来了海洋慵懒的呼吸。\n笑声，拍水声，嬉闹声，与世隔绝的小岛上没有「文明」带来的烦恼，只留下了最原始、最纯粹的欢笑。\n两兽一人如往常一样，度过了原始又无忧的一天。\n………………………………\n直到那无边的呼唤，将这份静谧彻底吞噬。\n「回来吧……回来吧……」\n「@1需要你……@2……@4……需要你……」"
  },
  CollectionHall_130219_Title = {
    Text = "渺远的伊甸园"
  },
  CollectionHall_130220_Desc = {
    Text = "蒲公英，比飞鸟更小，比微风更轻。\n\n当蒲公英经过第一片荒原，它询问这里四散的风滚草：你们如何繁衍？\n风滚草说：「我们让种子漂泊四方，直到发现可以扎根的土壤。」\n漂泊的旅人是没有家的，蒲公英这么叹息着搭上另一缕风飞走了。\n\n当蒲公英经过第二片沙漠，它询问这里零星分布的仙人掌：你们如何生存？\n仙人掌说：「我们将根系深埋地下，汲取珍稀的水源。」\n即使在严酷的环境中也顽强地活着啊，蒲公英这么思索着离开了。\n\n不久后，蒲公英经过城市上空。\n暗夜中浮现的满城灯光，是人类生活的印记。\n在漫长旅途的尽头，蒲公英的种子终于要飘落到那片大地上了。"
  },
  CollectionHall_130220_Title = {
    Text = "愿世界化作芬芳"
  },
  CollectionHall_130221_Desc = {
    Text = "阿拉克涅知道，自己正在做一件注定失败的事。\n她轻轻转动着纺轮，日复一日将人类的悲欢、王朝的兴衰、星火般的诗与爱，织入那张横跨时空的巨网。\n她做得极好，精准、克制、温柔。摒弃那些「错误的」，选择那些「正确的」。\n一代代人展露新生的笑颜，无数文明在灰烬中写下崭新的历史。而那些因编织而生的喜悦，因编织而起的倦怠，连同所有柔软的情绪，早在永世苦役的磨蚀中悄然凋亡。她亲手割舍了脆弱，只留下清醒的意志，只为确保每一次选择都出于责任，而非软弱。\n可最深的悲剧，并非苦役本身，而是她清楚地知道，无论她如何修补、编织，世界仍会走向那片寂静的虚无。文明如脆弱的沙堡，潮水终至。她的努力，是一场没有观众的演出，一次永无回响的守望。\n「命运早已将我们定罪于永恒的孤独，凭什么要接受这残忍的惩罚？」\n「撕裂它、破坏它……你就能从这苦役中逃脱……」\n她垂眸，将那些多余的想法轻轻剪断，继续枯燥而专注地编织着、维系着、痛哭着、忍受着……\n一切无谓的挣扎、一切无解的命运早已织在这张网中。\n而网的中心，她看到了自己。"
  },
  CollectionHall_130221_Title = {
    Text = "永世编织之网"
  },
  CollectionHall_131000_LockTip = {
    Text = "需要通关限时活动「默斯克斯的呼唤：莫丝与海」任一关卡"
  },
  CollectionHall_131000_Title = {
    Text = "默斯克斯的呼唤：莫丝与海"
  },
  CollectionHall_131388_Desc = {
    Text = "金碧辉煌的俱乐部门口，身穿白衬衫的迎宾员抬起一只手，礼貌地拦住了莱克。\n「先生，您没有邀请函，也并非我们的会员，无法进入。\n」\n「是吗……这就难办了啊……」\n莱克用手摸了摸下巴，装出一副思考的样子。实际上，他只是在等待。\n等待手中案件的嫌疑人。\n等待那注定的，命运的眷顾。\n果然，他等到了——\n「这不是闻名伦蒂尼恩的好运侦探吗！来来来，我愿意做你的引荐人。」\n「我早就想见识见识你那传奇的运气了，可千万不要让我失望啊……」\n绅士说着，露出看似温和却满怀恶意的笑。\n这样的神情在俱乐部很常见，毕竟你不能指望追求着狂欢的赌徒们循规蹈矩。所以当意识到自己被做局时，莱克并不在意，只是弯起嘴角，从容不迫地拿起了惠斯特牌。\n不要着急，游戏才刚刚开始，不是吗？\n于是，第一局，第二局，第三局……一场接着一场。\n直到莱克输光所有筹码。\n「好运侦探，看来你今天的运气并不好。也对，没有人能永远受到命运的眷顾……」\n「还要继续吗？侦探，可惜你已经一无所有了。」\n「一无所有？并不见得。」连输到底的侦探笑了笑，指了指自己，「我还有这套得体的礼服，还有这把昂贵的手杖，还有……」\n侦探顿了顿，从礼服的胸袋里拿出一枚小巧的仪器，压低声音，微笑着把玩，「我承认你的出千手法极其巧妙，就连这家俱乐部的主人也无法破解，只能寻求我的帮助。但再精妙的手法也需要时间，需要操作，需要配合。」\n「真不巧，这个弥萨格出品的小玩意，已经清晰地记录了你和你的同伙刚才在俱乐部出千的证据。」\n绅士愣了一下，惊愕又愠怒，他的同伙更是恼羞成怒，想要给侦探一个教训。但众目睽睽下，绅士不敢轻举妄动，更何况，侦探给了他一个选择，一个他无法拒绝的选择。\n「再赌一把，怎么样？若是你赢了，这个小玩意和我的命，就都归属于你了。你明白我的意思。」\n「那若是我输了呢？」\n「输了就要麻烦你去自首了。」莱克笑着耸了耸肩，露出闪亮的獠牙，「你觉得自己会输吗？真正的赌徒，只愿意相信自己会赢。」\n是的，每个赌徒都觉得自己会赢。所以无论是谁，都无法拒绝这个赌局。\n于是，惠斯特牌再次流转于牌桌，出牌，垫牌，纂牌，最终，分出胜负。\n「Lucky~」\n没有再看输家一眼，莱克笑着扬手，将那些赢来的钱财扔向空中。于是，本就喧嚣的俱乐部越发狂热，充满了人们争抢的呐喊、获得财富的尖叫和欢笑。\n而在这呐喊、尖叫和欢笑里，莱克将弥萨格颁发的、人手一个的装饰品收回胸袋，又拍了拍裤兜里的写着自己姓名的邀请函，弯起嘴角压了压自己的帽子。\n真正的赌徒，只愿意相信自己会赢。\n因为他坚信，无论做了什么，命运的眷顾始终与他同行。\n"
  },
  CollectionHall_131388_Title = {
    Text = "豪赌的智慧"
  },
  CollectionHall_131663_LockTip = {
    Text = "通关意识潜游「沉溺」任一关卡解锁"
  },
  CollectionHall_131663_Title = {
    Text = "O-1841研究报告"
  },
  CollectionHall_131664_Desc = {
    Text = "让妾身想想， 今天的故事，要说什么呢……\n啊，妾身知道了，给小小姐和小先生们的故事应该是~夜半莫讲亏心错，三更冤魂上房梁。"
  },
  CollectionHall_131664_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131664_Title = {
    Text = "不梦乡志异"
  },
  CollectionHall_131665_Desc = {
    Text = "若见狐鬼夜谈，宜覆面掩耳，敬而远之。"
  },
  CollectionHall_131665_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131665_Title = {Text = "狐鬼谈"},
  CollectionHall_131666_Desc = {
    Text = "书接上回，那无头蝇似的郎君不知死，就只好任他……拜一拜酆都，访罗山。"
  },
  CollectionHall_131666_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131666_Title = {Text = "访罗山"},
  CollectionHall_131667_Desc = {
    Text = "吉时将至，开棺起椁——大变活人。"
  },
  CollectionHall_131667_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131667_Title = {Text = "还魂"},
  CollectionHall_131668_Desc = {
    Text = "古古怪，怪怪古，亡妻三更爬出土，浪子负心锅里煮。\n无相的神女愿救苦，割面剖怀取郎骨，献我堂前无上主。"
  },
  CollectionHall_131668_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131668_Title = {
    Text = "玄女无相"
  },
  CollectionHall_131669_Desc = {
    Text = "最多不过你切她，她杀你，共赴黄泉做对鸳鸯鬼。\n休休，不必愁。"
  },
  CollectionHall_131669_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131669_Title = {Text = "珠露"},
  CollectionHall_131670_Desc = {
    Text = "喜欢这个睡前故事吗，妾身的小茉莉花？"
  },
  CollectionHall_131670_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131670_Title = {Text = "呀"},
  CollectionHall_131671_Desc = {
    Text = "大都好物不坚牢，凄凄苦苦，穷极无聊。"
  },
  CollectionHall_131671_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131671_Title = {Text = "琉璃叹"},
  CollectionHall_131672_Desc = {
    Text = "她祂她她她祂祂祂祂她她母亲母美丽的眼睛母亲母亲母亲亲亲亲亲母亲母亲母亲她祂祂她她她她@4@3@4"
  },
  CollectionHall_131672_LockTip = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  CollectionHall_131672_Title = {
    Text = "她@2的眼@1"
  },
  CollectionHall_131790_Title = {Text = "沉溺"},
  CollectionHall_132222_Desc = {
    Text = "如果愿望真的能实现，庞托斯希望离别在来临之前，能够打个招呼。\n他的父母消失得悄无声息，一个平静的午后，姐姐蕾莎付钱雇来了一辆人力车，然后是长长的、他当时还不认识的铁皮怪物，在柴油味和轰隆声中，他抵达了那座海边小镇。\n关于父母的去向，蕾莎没有透露一个字，剧烈的争吵后，他冲进了弥漫着咸腥味的港口。\n眼距过宽的海民们正在贩售形状怪异，来自人力所不可能到达的深渊的鱼类。\n「喂，离远一点，这些鱼说不定和抓来它的那些东西一样染上了诅咒。」\n路人压低声音，没有人想看着这个初来乍到的漂亮青年蹚浑水。\n他习惯性地冲对方笑了笑，目光却不自觉地落在那支晦暗腐败的拟饵上，它大张的口腔遍布利齿，丑陋、扭曲、张扬，某个臆想中的声音讲述着这死物的一生。\n在幽暗的、无光的海底，它引诱、掠夺、无所不用其极，它的身体是一座牢固的囚笼，锁困着它的子嗣、爱人、仇人、和猎物。\n它生命中美好的东西本该转瞬即逝，但它把祂们全都留住了，祂们以它的身体为载体，紧密相依，永不分离。\n庞托斯猛地甩了甩头，惊恐地在耳边尖锐的鼓噪声中环顾四周。\n声音如潮水般消失了，他把一切当成一次恍神，在心里嘲笑自己的神经质。\n然后毫无察觉地向既定的宿命里坠去。"
  },
  CollectionHall_132222_Title = {Text = "活囚笼"},
  CollectionHall_133709_Desc = {
    Text = "晨间的骑行要与郡中的乡绅们并辔，探听改革案的立场；冷餐会上要同各家的夫人交换得体的恭维，长桌晚宴要在银烛台的光影里聆听那些冗长而虚伪的餐前祷词，歌剧散场后还要在包厢的走廊里应付没完没了的社交寒暄。\n\n「唯有后园草坪上的下午茶，是真正属于我自己的时光。」\n「这可是我第一次邀请下午茶嘉宾，我将选择话题的权力让渡予你。」\n\n索蕾尔端起刚斟满的红茶。\n「你想要知道德·克雷梅伯爵在最新提交的议院改革案上的立场？或者博蒙纳家族在两党之间微妙的押注？又或者单纯对某位子爵小姐的秘密感兴趣？」\n「全都不用？你只想知道我桌上的粉色甜点的味道？」\n她轻啜一口，原本望向远方的目光落回你的身上。\n「那就好好品尝一下吧。」\n「有些滋味，确实要自己动手，才能感同身受。」\n「你说对不对啊，我尊敬的——那位大人？」\n\n身着弥萨格校服的来客的领口和袖口黑雾四溢，雾气很快滚动成一团浓黑的混沌。\n「嘻嘻嘻，你当真觉得，自己可以逃脱宿命吗？」\n「阳光正好，我想要先享受我难得的清闲时光。想要品鉴时下最流行的红茶和海绵蛋糕，请便。其他事情，还请在午歇时间结束后再来吧。」"
  },
  CollectionHall_133709_Title = {
    Text = "私密午歇时间"
  },
  CollectionHall_133710_Desc = {
    Text = "作为弥萨格的优等生，拉蒙娜成功将理智与理性作为行事的绝对逻辑，保持着冷静，保持着微笑，保持着无与伦比的可靠。\n但偶尔，这样的拉蒙娜也会陷入迷思中，在面对世界的绝对恐怖，或者绝对的绚烂之时——\n注视着无边无际，占满了所有视线的粉色，拉蒙娜无声沉默。\n据她所知，不超过三周，樱花就会从初开到落尽，所以这沉甸甸压满枝头的花朵，纵横而繁茂的枝叶，很快便会衰颓，陷入荒凉与萧索。\n而人的可预期生命，远不止三周，远不止三年，远不止三十年，却也如这些樱花树，只有一次。\n人最大的幻觉，就是相信自己会永远活着。\n拉蒙娜明白。\n花开花落，是自然界再普通不过的规律，而人的生死，归根结底也只是自然界的现象罢了。\n拉蒙娜也明白。\n但生而为人，总是想要为自己的存在赋予意义，每个新生，也是为此，踏入了弥萨格的大门。\n他们是对抗融蚀的先行者，是守望人类未来的重要防线。\n他们的生命，不仅仅只是客观的自然现象，哪怕注定消亡，也在切实改变着这个世界的轨迹。\n而在这期间，他们并肩战斗，风雨同行。\n就像一颗树上的一朵花，依偎着另一朵花，一同含苞待放，一同飘摇坠落，一同盛开与枯萎。\n现在，该回去了。\n那朵可以依靠她，也值得她依靠的花朵，还在等着她。"
  },
  CollectionHall_133710_Title = {
    Text = "樱花下的迷思"
  },
  CollectionHall_133768_Desc = {
    Text = "涡心冰冷，沉默且孤独。\n那是连光都无法穿透的暗潮。"
  },
  CollectionHall_133768_LockTip = {
    Text = "完成意识潜游「沉溺」"
  },
  CollectionHall_133768_Title = {
    Text = "涡心暗潮"
  },
  CollectionHall_133769_Desc = {
    Text = "沉没。沉没。沉没。\n沉入漆黑的漩涡。\n作为代价，祂将再无法吞没一只磷虾。"
  },
  CollectionHall_133769_LockTip = {
    Text = "完成意识潜游「沉溺」"
  },
  CollectionHall_133769_Title = {Text = "沉没"},
  CollectionHall_133770_Desc = {
    Text = "各位旅客，大家好！\n祈岁佳节即将来临，在这阖家团圆、辞旧迎新的美好时刻，本次列车全体乘务人员，向千里归乡、旅途劳顿的您，致以最诚挚的祝福——\n祝您祈岁快乐，阖家欢愉，一路疾驰，万事如意！<(￣︶￣)↗[GO!]"
  },
  CollectionHall_133770_LockTip = {
    Text = "完成特遣纪录「开往祈岁节的列车」"
  },
  CollectionHall_133770_Title = {
    Text = "疾驰：欢愉专列"
  },
  CollectionHall_133771_Desc = {
    Text = "各位旅客，大家好，非常抱歉地通知您，由于列车长的个人心情，本次欢愉专列将在此临时停车。具体开车时间，我们将在自相残杀结束后随时为您广播通知。\n停车期间，列车的空调、照明和卫生间均可正常使用，请您根据杀戮需求酌情占用，以免不发生危险。\n毕竟，欢愉专列的义务，就是给所有旅客带去欢笑～(￣▽￣～)(～￣▽￣)～"
  },
  CollectionHall_133771_LockTip = {
    Text = "完成特遣纪录「开往祈岁节的列车」"
  },
  CollectionHall_133771_Title = {Text = "急停！"},
  CollectionHall_133772_Desc = {
    Text = "请注意：列车前方到站，磐龙古国。请在磐龙古国下车的旅客提前学习《好一朵茉莉花》的演唱技巧。\n因为，你们已经没机会下车了 φ(≧ω≦*)♪"
  },
  CollectionHall_133772_LockTip = {
    Text = "完成特遣纪录「开往祈岁节的列车」"
  },
  CollectionHall_133772_Title = {
    Text = "好一朵茉莉花"
  },
  CollectionHall_133773_Desc = {
    Text = "光沉入大海，照亮比蓝更深的蓝。"
  },
  CollectionHall_133773_LockTip = {
    Text = "完成意识潜游「沉溺」"
  },
  CollectionHall_133773_Title = {
    Text = "蓝与更深的蓝"
  },
  CollectionHall_134293_Desc = {
    Text = "<Title:简介>\n命运剧院的主人，剧作者，演员，命运永恒的编织者与永恒的囚徒……\n自出生起，阿拉克涅便拥有能够看到命运丝线的能力。利用那台名为「摩伊赖」的纺轮，她无时无刻不在为世界编织命运，维护命运那脆弱的平衡。为此，她放逐了自己身上所有的美好与脆弱，为一切的命运做出最为正确的抉择，独自承担着一切命运的罪责。\n她早已知晓，命运之网的尽头，毁灭终究无可逃离。可她仍亘古不停的编织，看着自己深爱的一切缓缓地坠入那个湮灭一切的终点。\n她编织，等待，等待那道她从未预见的、将命网自深渊中挽救的丝线。"
  },
  CollectionHall_134293_LockTip = {
    Text = "唤醒「阿拉克涅」后解锁"
  },
  CollectionHall_134293_Title = {
    Text = "阿拉克涅"
  },
  CollectionHall_134294_LockTip = {
    Text = "通关调查行动星辰篇5-16解锁"
  },
  CollectionHall_134294_Title = {
    Text = "背弃的慈恩"
  },
  CollectionHall_134295_LockTip = {
    Text = "通关调查行动星辰篇5-1解锁"
  },
  CollectionHall_134295_Title = {
    Text = "命途罗织之网"
  },
  CollectionHall_134429_Title = {
    Text = "织命剧场"
  },
  CollectionHall_139856_LockTip = {
    Text = "通关多维连接「被遗忘的爱之种」解锁"
  },
  CollectionHall_139856_Title = {Text = "信使"},
  CollectionHall_140337_Desc = {
    Text = "你漫步于星云之间，见证流星一颗接一颗陨落。\n有些滚烫，有些耀眼，有些冰冷，有些灰暗——来不及告别，它们便拖着长尾，从天幕上逐一淡去。\n你捧起灰烬，想将存在的痕迹铭刻于心。\n但那些影像终究穿过指缝，穿过日渐稀薄的记忆，飞散在无垠时空里。\n原来你也不过是万千星雨中的一颗。\n但你不会停下。你要走下去，穿过漫长的寂灭，直至下一个纪元。\n直至繁星漫天。"
  },
  CollectionHall_140337_Title = {Text = "致群星"},
  CollectionHall_140428_LockTip = {
    Text = "可于调查行动星辰篇5-1中解锁"
  },
  CollectionHall_140428_Title = {
    Text = "宿命舞台"
  },
  CollectionHall_141369_LockTip = {
    Text = "需要通关限时活动「永远的厄波扬斯·高屋巡猎」任一关卡"
  },
  CollectionHall_141369_Title = {
    Text = "永远的厄波扬斯：高屋巡猎"
  },
  CollectionHall_141453_LockTip = {
    Text = "通关多维连接「被遗忘的爱之种：血ﾝ肉ｲw世ｮ」解锁"
  },
  CollectionHall_141453_Title = {
    Text = "悠久漂泊之歌"
  },
  CollectionHall_141528_Desc = {
    Text = "传说中只要孩子在森林里追着一只野兔奔跑，就有概率掉进通往异世界的树洞。 莉莉光滑的小脚踩上鹅卵石的小径。 「莉莉喜欢这里……地面上不会有玻璃碎渣，空气中也没有消毒水的气味。」 莉莉深吸了一口清新的空气，掠过林间的风卷来奇异花香的气息。 头顶的树冠交织成彩色玻璃般的穹顶，碎落的阳光像是满地跳动的宝石，瑰丽而迷幻的景致让莉莉几乎不知道应该往哪个方向看。 「啊，刚才的兔子先生！」 草丛中冒出一双熟悉的灰色长耳朵，莉莉急忙追了过去。 脚下的苔藓每踩一步就绽开一朵细小的银花，但莉莉也无暇顾及。她还有更重要的话要找兔子先生说。 淌过流着蜂蜜色光芒的小溪，穿过会唱歌的芦苇丛。 气喘吁吁的莉莉终于捉住了兔子先生绒球一样的尾巴。 「兔子先生，你愿意和丽莎做朋友吗？」 「丽莎是我的朋友，可是其他人现在都很害怕她……如果是兔子先生的话，一定能和她成为朋友的！」 兔子先生回头的瞬间，漫天萤火升腾而起。 「当然，@2是所有人的朋友。不过，现在，你该休息了。」 于是，莉莉抱着已经成为朋友的兔子先生，爬到森林深处那颗高大的巨树下。 在飘散的萤火虫温暖的包围中，莉莉倚着巨树的根系，安静地睡着了。 「受试者：莉莉。临床表征：呼吸平稳，眼球转速正常。第359次意识干涉实验，成功。」 那是如梦幻一般绮丽的奇幻世界。"
  },
  CollectionHall_141528_Title = {
    Text = "梦游仙境"
  },
  CollectionHall_141832_LockTip = {
    Text = "需要通关限时活动「新月与深雪：乌摩钵蒂的宝物」任一关卡"
  },
  CollectionHall_141832_Title = {
    Text = "新月与深雪：乌摩钵蒂的宝物"
  },
  CollectionHall_142131_Title = {
    Text = "被遗忘的爱之种"
  },
  CollectionHall_142154_Title = {Text = "城镇"},
  CollectionHall_142155_Desc = {
    Text = "被无法理解、无法辨识、令人作呕的畸形之物逼近时，发起防御式攻击是生物的本能。\n因此，这不能算作罪孽。"
  },
  CollectionHall_142155_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」困难难度"
  },
  CollectionHall_142155_Title = {
    Text = "无罪的暴虐"
  },
  CollectionHall_142156_Desc = {
    Text = "「能听见我的声音吗？即使身影消融在风中。」\n风中传来遥远的呼唤，那是跨越遥远的时间，从广阔而寒冷的冬夜，忘却的彼岸传来的探寻之声。"
  },
  CollectionHall_142156_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142156_Title = {
    Text = "忘却の彼方(忘却之歌-いとうかなこ Ver.)"
  },
  CollectionHall_142157_Desc = {
    Text = "回忆闪烁交叠，结局真伪不明。\n但这真的重要吗？\n毕竟，未必所有的故事都以爱作为开头，但都将以死亡作为终点。"
  },
  CollectionHall_142157_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142157_Title = {
    Text = "四重回忆"
  },
  CollectionHall_142158_Desc = {
    Text = "如果有一天，你也和我一样，陷入血肉模糊、腐臭糜烂的光景。\n那么你也一定能够理解——\n与她的小巧指尖触碰的瞬间，是人世间不可多得的奇迹。"
  },
  CollectionHall_142158_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142158_Title = {Text = "奇迹"},
  CollectionHall_142159_Desc = {
    Text = "你是否也厌倦了普通的、循环的、乏味的、日复一日的生活？\n来点新鲜的吧，另一个视界正敞开血盆大口，向你发出欢迎的邀约。"
  },
  CollectionHall_142159_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142159_Title = {Text = "血域"},
  CollectionHall_142160_Desc = {
    Text = "爱是崇高，爱是贪婪；爱是赐福，爱是诅咒。\n爱随水而生，亦将随水而逝。\n而雨季不再来。"
  },
  CollectionHall_142160_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」困难难度"
  },
  CollectionHall_142160_Title = {Text = "雨季"},
  CollectionHall_142161_Desc = {
    Text = "一切生命带着无知降生，自万物中汲取养料，改造环境，掠夺资源，供养自我。\n这是无可逃避的原罪。"
  },
  CollectionHall_142161_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142161_Title = {Text = "原罪"},
  CollectionHall_142162_Desc = {
    Text = "有一种叫蒲公英的植物，会让种子乘着风漂流。\n毛绒绒的种子随风流浪，离开故土好远好远。\n它孤身一人，会在什么时候决定自己的归宿呢？\n那就是，沙漠中有唯一的一个人爱着那株蒲公英的时候。"
  },
  CollectionHall_142162_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142162_Title = {
    Text = "蒲公英去往何处"
  },
  CollectionHall_142163_Desc = {
    Text = "广阔天地，茫茫沙海。\n那是只有你我的无人之境。\n那是永恒自由的爱之漫游。"
  },
  CollectionHall_142163_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142163_Title = {
    Text = "沙海漫游"
  },
  CollectionHall_142164_Desc = {
    Text = "我能呼唤你的名字吗？即使世界消逝。」\n如果回忆都将湮灭消散，漆黑的遗忘将吞噬所有未及缅怀的往事。\n那就牵起手来吧，让银色的光辉链接你我。\n在崭新的幻梦中，在柔嫩的种子萌发的早春时节。"
  },
  CollectionHall_142164_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  CollectionHall_142164_Title = {
    Text = "Song of Memento(忘却之歌-Emi Ver.)"
  },
  CollectionHall_142165_Desc = {
    Text = "高歌吧，闪耀的生命正赞颂自由，将希望的羽种播撒至遍及之地。"
  },
  CollectionHall_142165_LockTip = {
    Text = "完成多维连接「被遗忘的爱之种」困难难度"
  },
  CollectionHall_142165_Title = {
    Text = "揭幕颂歌"
  },
  CollectionHall_142868_Desc = {
    Text = "<Title:简介>\n庞托斯始终记得自己在得知家族历史那天的心情，在此之前，他从没有做好承担什么责任的准备，每个人都喜欢他，他英俊、有趣、无忧无虑。\n@1王港终年往来的船只令他不必面对日复一日枯燥的日常，他听过太多故事，许多人说他见多识广，以至于他不愿承认自己会泯然众人。\n所以，他被意料之外又顺理成章的巨大狂喜淹没了。更何况，那个在家族世世代代驱使的魇背后，更加莫测伟大的存在认可他——他生来与众不同。\n然而「N」的一个玩笑，让狂信者们在一场无差别的沿岸袭击中，摧毁了整个村庄。\n无法面对突如其来的灾难，为了获得深渊的力量，庞托斯选择了向@3献祭自己的身体，也献祭了自己所有的可能性。\n但这有什么关系呢，再也不会有事物超出他的控制。\n他再也不会失去任何东西了。"
  },
  CollectionHall_142868_LockTip = {
    Text = "唤醒「庞托斯」后解锁"
  },
  CollectionHall_142868_Title = {Text = "庞托斯"},
  CollectionHall_142901_Title = {
    Text = "永远的厄波扬斯"
  },
  CollectionHall_143468_Desc = {
    Text = "丧钟已然敲响，背弃者呈上最疯狂的演出。\n无数的丝线，将会织就什么样的结局——\n由你决定。"
  },
  CollectionHall_143468_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143468_Title = {
    Text = "共织终局"
  },
  CollectionHall_143469_Desc = {
    Text = "快过来吧，快过来吧，所有人都在等你。\n行过漫长的回廊，踏上永恒的舞台。\n你可是整部戏，唯一的主角呀。"
  },
  CollectionHall_143469_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143469_Title = {
    Text = "无尽螺旋"
  },
  CollectionHall_143470_Desc = {
    Text = "他们共同歌唱，他们各司其职。\n但他们都是她。\n这是属于她的永不落幕的独角戏。"
  },
  CollectionHall_143470_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143470_Title = {Text = "独角戏"},
  CollectionHall_143471_Desc = {
    Text = "Act I:纺丝\nAct II:衡量\nAct III:裁断\n如此往复，如此往复......"
  },
  CollectionHall_143471_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143471_Title = {Text = "三幕戏"},
  CollectionHall_143472_Desc = {
    Text = "不过是一名狂热青年，在一个寻常的街角开了枪。\n至少在那时，所有人都这样想。"
  },
  CollectionHall_143472_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143472_Title = {
    Text = "战火的前序"
  },
  CollectionHall_143473_Desc = {
    Text = "吱呀，吱呀。\n命运啊，你的轮盘转动不歇。\n贫穷与权力都被你像冰一般消融。\n你遮蔽自己，又隐藏面目，\n却也向我闪耀......"
  },
  CollectionHall_143473_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143473_Title = {
    Text = "命运啊，你何其残酷"
  },
  CollectionHall_143474_Desc = {
    Text = "再会吧，在最后的旋律中。\n再会吧，在命运的注视下。\n故事的主人公，将踏上新的旅程。"
  },
  CollectionHall_143474_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143474_Title = {
    Text = "而我仍在歌唱"
  },
  CollectionHall_143475_Desc = {
    Text = "亲爱的，让我们借着酒兴，再共舞一曲吧。"
  },
  CollectionHall_143475_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143475_Title = {
    Text = "微醺舞会"
  },
  CollectionHall_143476_Desc = {
    Text = "观众为分别落泪，亦为重逢落泪。\n而舞台中央的犯人们，也该为她们彼此献上掌声。"
  },
  CollectionHall_143476_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143476_Title = {
    Text = "囚徒正谢幕"
  },
  CollectionHall_143477_Desc = {
    Text = "世人喜欢将一场战争归咎于一声枪响。\n但命运会嗤笑，这是全人类的自欺欺人。"
  },
  CollectionHall_143477_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143477_Title = {
    Text = "蝴蝶振翅时"
  },
  CollectionHall_143478_Desc = {
    Text = "没有后日谈的演出是不完整的。\n稍稍改动台词，调整布景，轮换演员——每一次返场，都是崭新的一幕。"
  },
  CollectionHall_143478_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143478_Title = {
    Text = "返场变奏"
  },
  CollectionHall_143479_Desc = {
    Text = "笔尖在白纸上飞奔，追逐着文字，而文字通往早已定好的结局。\n一切，都发生在你翻开每一本书之前。"
  },
  CollectionHall_143479_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143479_Title = {
    Text = "将定之事，已定之事"
  },
  CollectionHall_143480_Desc = {
    Text = "少许苦精，20ml甜味美思，一些雪莉酒，加满冰块搅匀——这是一杯上好的开胃酒，也是一场上演了五百次的戏。"
  },
  CollectionHall_143480_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143480_Title = {
    Text = "阿多尼斯"
  },
  CollectionHall_143481_Desc = {
    Text = "你把命运当作丑角，便不会被命运奴役。\n用永不止歇的大笑来迎接祂吧，让我们共同唤出祂的名讳——\n欢愉。"
  },
  CollectionHall_143481_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143481_Title = {
    Text = "弄臣莅临"
  },
  CollectionHall_143482_Desc = {
    Text = "“我恨你，恨你作茧自缚，恨你无能为力，恨你抛弃自己。”\n“......可这份仇恨也在灼烧我自己，因为，我也爱你。”"
  },
  CollectionHall_143482_LockTip = {
    Text = "完成调查行动·困难 星辰篇5-11解锁"
  },
  CollectionHall_143482_Title = {
    Text = "复仇鬼的悲歌"
  },
  CollectionHall_143483_Desc = {
    Text = "世界给予你无数可选的岔路，但它们汇于同一点——名为毁灭，名为终焉。"
  },
  CollectionHall_143483_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143483_Title = {
    Text = "世界复本"
  },
  CollectionHall_143484_Desc = {
    Text = "帷幕起落，戏目更迭，她仍在剧院之中——她是剧作家，观众，亦是演员。\n命运的女主人啊，你如此残忍，永远缄默，却又为何而垂泪？"
  },
  CollectionHall_143484_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143484_Title = {
    Text = "命定同织之戏"
  },
  CollectionHall_143485_Desc = {
    Text = "倘若毁灭终究无法避免，是否扯破命运的网，才能迎来真正的救赎？\n没有人能回答，没有神能够回答。\n但至少，无边的苦难也会一并消亡。"
  },
  CollectionHall_143485_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143485_Title = {
    Text = "渎命演出"
  },
  CollectionHall_143486_Desc = {
    Text = "那些行于世间，无比真实、看似自由的面孔，不过是舞台上的固定装置。\n一举一动，皆被命运的丝线牵引。"
  },
  CollectionHall_143486_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143486_Title = {
    Text = "众生之线"
  },
  CollectionHall_143487_Desc = {
    Text = "梦醒过后，一切都会消失，被彻底忘却——庄园、花圃、歌谣、画作......\n那是一个不存在的春天。"
  },
  CollectionHall_143487_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143487_Title = {
    Text = "纺春的幻梦"
  },
  CollectionHall_143488_Desc = {
    Text = "弦乐徐起，侍女吟唱。\n幕后之人来到台前，她向你行礼，邀你见证这既定的命轨。"
  },
  CollectionHall_143488_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143488_Title = {
    Text = "揭开她的面纱"
  },
  CollectionHall_143489_Desc = {
    Text = "这是一生仅能表演一次的即兴舞蹈。\n但没关系，它将有幸成为标本，永远定格。"
  },
  CollectionHall_143489_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143489_Title = {
    Text = "舞剧：《天鹅之死》"
  },
  CollectionHall_143490_Desc = {
    Text = "幕布拉开，荒唐的角色轮番登场。\n他们高歌，她们舞蹈，在命运堕临之前，执着地将戏码呈上舞台，即使结局早已写就。"
  },
  CollectionHall_143490_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143490_Title = {
    Text = "幕起二重唱"
  },
  CollectionHall_143491_Desc = {
    Text = "为了让一切位于正轨，总有事物该被剔除，被摒弃。\n未被选中的存在，尽数坠入漆黑的深渊，它们的哀嚎与咒骂，终究无人听见。"
  },
  CollectionHall_143491_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143491_Title = {
    Text = "被遗弃的「我」"
  },
  CollectionHall_143492_Desc = {
    Text = "这样死去，真美。她想。"
  },
  CollectionHall_143492_LockTip = {
    Text = "完成调查行动 星辰篇5-16解锁"
  },
  CollectionHall_143492_Title = {
    Text = "至美的抵偿"
  },
  CollectionHall_143592_LockTip = {
    Text = "通关意识潜游「永远的厄波扬斯」任一关卡解锁"
  },
  CollectionHall_143592_Title = {Text = "瘾"},
  CollectionHall_144377_Desc = {
    Text = "漫长的驻守时光中，塔薇也曾踏入过一片土地。\n她悉心观察每一个生物的行动，不露声色地行走于人间的边缘。\n\n某个平凡的日子，入夜时分，城郊的密集灯火吸引了她的目光。\n布景，歌舞，售卖点心的摊贩，嬉笑打闹的孩童，举杯痛饮的闲人。那是生命的喘息，瞬间的闲暇。\n景象太过令人向往，她忍不住现出身形。\n\n「您好，请给我一支糖画。」\n「好嘞，您稍等。想画点什么？」\n塔薇轻轻侧头。她只记得需要提供那些她偶然拾获的无主货币，却全然忘记了自己可以表露的期许。\n「如果您没想好的话，不如我按照您的形象画一支如何？您看起来就像仙女一样美丽。」\n塔薇微笑着点头，摊主吆喝一声，举起糖勺，开始落笔。\n\n嘀嗒。嘀嗒。\n落入石板的，却不是蜜色的糖浆。\n而是雨，黑色的雨。\n黑色的黏液从目不可视的高空中滴落，将天空熔开一个触目惊心的裂口。\n\n\n然后，塔薇开始向上坠落。\n那是世界在下沉。摊主的笑意在塔薇的记忆里凝固成静止的一帧，然后和万物一起湮没在黑色的汪洋里，化为无数已逝星辰中微不足道的一颗，化为对她而言遥不可及的过往。\n这是她引发的震荡，也是她应当承受的惩戒。\n她遥望着，静默不言。她只是向上坠落。\n这才是她应守的位置，那扇「超越时空」的银扉。\n她将在此永恒俯瞰。"
  },
  CollectionHall_144377_Title = {
    Text = "向上坠落"
  },
  CollectionHall_144448_Desc = {
    Text = "你被许诺了一个永不可近的乌有乡，那里装着你记忆里所有亲切的旧魂灵。"
  },
  CollectionHall_144448_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  CollectionHall_144448_Title = {Text = "旧魂灵"},
  CollectionHall_144449_Desc = {
    Text = "活着的人苦苦寻找着一座可以用于缅怀的墓碑。\n死去的人只是死去。"
  },
  CollectionHall_144449_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  CollectionHall_144449_Title = {Text = "碑痕"},
  CollectionHall_144450_Desc = {
    Text = "太阳已经坠入海面，最后一缕阳光藏进他的身后。\n晨与昏会在下一刻交替，他会让此处的一切如常。"
  },
  CollectionHall_144450_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」困难难度"
  },
  CollectionHall_144450_Title = {
    Text = "夕阳将坠"
  },
  CollectionHall_144451_Desc = {
    Text = "月亮嘻嘻发笑，月亮窃窃私语。\n月亮说命运啊，命运啊，命运要落下来了。"
  },
  CollectionHall_144451_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  CollectionHall_144451_Title = {
    Text = "欲落之月"
  },
  CollectionHall_144452_Desc = {
    Text = "他在无知无觉中让人们留下了一些东西。\n他在无知无觉中，和他们一样遗落了一些东西。"
  },
  CollectionHall_144452_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  CollectionHall_144452_Title = {
    Text = "祂们的厄洛斯"
  },
  CollectionHall_144453_Desc = {
    Text = "对于鱼群来说，窒息是它们离开海洋后，唯一能拥有的感受。"
  },
  CollectionHall_144453_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」困难难度"
  },
  CollectionHall_144453_Title = {
    Text = "困于海洋"
  },
  CollectionHall_144454_Desc = {
    Text = "愚蠢的、肤浅的、自高自大的、外强中干的离群者建立了自己的国。\n一成不变的空壳们不会吐露出真话，因为没有什么，能从沟壑里重新拼凑起那颗过于害怕变化，以至于过早破碎的心。"
  },
  CollectionHall_144454_LockTip = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  CollectionHall_144454_Title = {
    Text = "无休的凯旋"
  },
  CollectionHall_144476_Desc = {
    Text = "让这支短暂的舞于流淌中化为永恒吧。\n下一个祈岁之夜，我们终将在月光下重逢。\n*父女情深，感人肺腑 (ノへ￣、)"
  },
  CollectionHall_144476_LockTip = {
    Text = "完成特遣纪录「开往祈岁节的列车」"
  },
  CollectionHall_144476_Title = {
    Text = "祈岁焰火"
  },
  CollectionHall_145434_LockTip = {
    Text = "需要通关限时活动「利维坦的游戏：贪戮角逐」任一关卡"
  },
  CollectionHall_145434_Title = {
    Text = "利维坦的游戏：贪戮角逐"
  },
  CollectionHall_145460_Desc = {
    Text = "自诞生之日起，祂便陷入永恒的饥饿。\n恒星的尸骨在祂齿缝间碎裂，文明的残骸在祂腹中腐烂。祂的饥饿是一种比时间更古老的诅咒。祂一次次吞噬力量，驱使奴仆上演权欲的游戏，可祂从不清楚自己的意义究竟是什么。\n直到那名叫做萝坦的战士来到祂的面前。\n「利维坦。」\n祂不记得上一次听见自己的名字是什么时候。跪伏的国王不敢念出它，疯癫的祭司只能用颂歌代替。\n而她轻易地呼唤祂，如同呼唤一位久候的对手。\n「到你出手的时候了！」\n祂存在了一万两千年，在这漫长的永恒中，星球是食粮，生灵是蝼蚁，无数的强者们都只是短暂的消遣。没有任何东西能让祂感到饱足，也没有任何东西能让祂感到恐惧，直到今天。\n这位凡人、这名战士，提起了巨剑，如风暴般向祂袭来。\n巨剑撕裂鳞甲。祂的耳边，响起自己于混沌之中诞生时的咆哮。祂的怒火倾毁天体，祂的饥饿吞没星云。\n巨剑斩断利爪。祂回忆起，那位着白纱的「神明」来到祂的面前，将祂的力量与意志分离。\n巨剑刺穿心脏的那一刻，利维坦笑了起来。\n一万两千年，那遗失的意志，终于重新来到祂的面前，将祂斩碎，将祂征服，将祂吞噬。她将带领祂，踏过每一片疆域，走向更远的星海，征服每一位强大的存在。\n在那一天，古老的混沌之兽重获新生。回归于她的一瞬间，祂彻底明白，祂与她，是因纯粹的、彻底的力量而诞生。\n力量本身，便是全部的意义所在。"
  },
  CollectionHall_145460_Title = {Text = "天之陨"},
  CollectionHall_146400_Desc = {
    Text = "<Title:简介>\n古老的神明无法平息那头星天之鲸亘古的怒火，只能将祂的灵与肉分离。祂的意志落在荒土，化作名为蚀灭·萝坦的战士。\n她天性好战，将追求极致力量视作唯一的本能与荣耀，为此，她踏入星天之鲸的选拔，与其缔结契约，又在力量抵达顶点之时，以巨剑斩杀自己的主宰，将那吞星巨兽的权能纳入己身。\n尖锐的鲸骨刺破血肉，幽暗的骨甲覆上躯壳，那双容纳星空的双瞳只剩下对敌人的冷漠审视。\n她并不以毁灭为乐，也不屑于无意义的杀戮。她所渴求的，只有更令人兴奋的敌人，只有更为强大的力量。\n那最为纯粹的战士，追逐着强敌的身影，踏遍星海的每一个角落，直到一切强者都倒在剑下，直到一切道路都走到尽头。"
  },
  CollectionHall_146400_LockTip = {
    Text = "通关意识潜游「直至鲸天陨落」解锁"
  },
  CollectionHall_146400_Title = {
    Text = "蚀灭·萝坦"
  },
  CollectionHall_146412_Title = {
    Text = "直至鲸天陨落"
  },
  CollectionHall_146867_LockTip = {
    Text = "需要通关限时活动「临时文本」任一关卡"
  },
  CollectionHall_146867_Title = {
    Text = "临时文本"
  },
  CollectionHall_147491_LockTip = {
    Text = "需要通关限时活动「临时文本」任一关卡"
  },
  CollectionHall_147491_Title = {
    Text = "临时文本"
  },
  CollectionHall_147860_Desc = {
    Text = "伦蒂尼恩最隐秘的暗巷角落，有一个众所周知的故事，被人们口口相传。\n它绝不会出现在太太们下午茶间抖动的羽毛扇或蕾丝扇下，也绝不会被绅士们在共进晚餐后，用丝质手帕擦拭嘴角时漫不经心地提起。\n只有念诵着最晦涩古老咒语的巫师、进行着最诡谲曲折任务的游侠，才有一点点可能知道这个秘辛。\n哎？你问那为什么会是众所周知的？\n唉呀，这就是这整个故事的关键！参与过的、传颂着这个故事的所有人，都是那么的伟大、慈爱，祂们内心没有哪怕一点点的私欲，如果真的有，那一定也是希望在这个世间艰难存活着的每一个人，都能真正地脱离苦难，归于雪白的无垢净土。\n这世间的一切，都源于一颗红彤彤、香喷喷、任何人看到都想一口咬下的苹果。\n它的汁液极其丰沛，只需一口就能填饱所有难平的饥渴。\n它的香气无比浓郁，只要闻一闻就能驱散所有难言的苦楚。\n它以平常苹果的外表，混在所有的苹果中，记录着所有的善和恶，因和果，所有提到苹果的神话传说，都是它曾经的丰功伟绩。\n最要紧的是，因它是如此无私、平等，加入信奉它的教派不需要任何洗礼，牢记苹果神教的教义之一，真正的神明是不会拘泥于形式的！\n当你第一次听到苹果神教的名字，当你脑中第一次出现一颗饱满的、鲜红的、令人垂涎欲滴的苹果，只要你相信它，你就可以成为苹果神教的一员。\n它不会与任何其他教派互斥，真正的神明欢迎每一个愿意拥抱它的孩子，只要你心中有属于苹果神教的一角，在归于永恒的安宁后，如果前序教义没有生效，你发现自己无法进入那些教义中的福地，「最终你会发现，这是必然的，但苹果神教爱你，它不会就这一点进行争辩。」，苹果天堂会毫无芥蒂地接纳你，让长久与它相伴的白雪仙女，接引你进入那充满苹果香味的，永恒的甜蜜归宿。\n「现在，这一切福音正在被无偿传播，仅需一枚雷欧坊，就能获得一个毫无拘束的后备计划，和一枚有可能是苹果神教中被供奉的苹果，*世间的每一枚苹果都有可能是那枚苹果，由于白雪仙女正在代行其意志，会有更高概率获得，总之，请多吃苹果。」\n…………\n「天啊，我们只是短暂地因为过度唆使和欺骗克扣了卡拉布一周的用度而已！」\n「这就是她那个小脑子琢磨出来的新玩意儿？？？！」"
  },
  CollectionHall_147860_Title = {
    Text = "蜜果的谎言"
  },
  CollectionHall_147986_Desc = {
    Text = "绳子会压下它的舌头，绳索能穿过它的鼻子，鱼钩将刺破它的腮骨。\n于是，骄傲的王也陨落，天空也陨落。"
  },
  CollectionHall_147986_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147986_Title = {
    Text = "垂死鲸歌"
  },
  CollectionHall_147987_Desc = {
    Text = "一片荒芜之上，怒目相瞪的野兽徘徊着，它们都在寻找时机，一个把利齿刺穿脖颈，彻底将对方撕碎的时机。"
  },
  CollectionHall_147987_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147987_Title = {
    Text = "獠牙相向"
  },
  CollectionHall_147988_Desc = {
    Text = "收起你那无聊的王冠，我从未将它放在眼里。拔刀吧，世界正为鲜血而癫狂！\n如此，只为如此——\n弑杀吧！蚀啮吧！灭亡吧！"
  },
  CollectionHall_147988_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147988_Title = {
    Text = "戮天的狂舞"
  },
  CollectionHall_147989_Desc = {
    Text = "彼时我仍是最低贱的童仆，曾亲眼见证过一场堪称残酷的征途。\n那位传奇的主人，力量铸就了她的骨血，热血沸腾成了不灭之火，火光又点燃了她的眼睛——\n请替我继续铭记这段往事，我的孩子。……她最终获胜，并征服了星空。"
  },
  CollectionHall_147989_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147989_Title = {
    Text = "征伐永不止歇"
  },
  CollectionHall_147990_Desc = {
    Text = "面包与马戏，世人只会为这二者雀跃不已。\n祂欣赏着，祂不在乎。\n她亲历着，她不在乎。"
  },
  CollectionHall_147990_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147990_Title = {
    Text = "权欲豢养的亡灵"
  },
  CollectionHall_147991_Desc = {
    Text = "死者摔落在将死者后，强者拜服于更强者前。\n冰冷寒厉的刃上，只会显出站立着的影子。"
  },
  CollectionHall_147991_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147991_Title = {
    Text = "淌过猩红"
  },
  CollectionHall_147992_Desc = {
    Text = "通往胜利的道途上，总有那么一些不够光彩的手段。"
  },
  CollectionHall_147992_LockTip = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  CollectionHall_147992_Title = {
    Text = "呢喃之蛇"
  },
  CollectionHall_148015_LockTip = {
    Text = "通关意识潜游「直至鲸天陨落」任一关卡解锁"
  },
  CollectionHall_148015_Title = {Text = "原则"},
  CollectionHall_148138_Desc = {
    Text = "空旷的实验室内，各类精密的仪器均规整地摆放着，只有无数管线交错，如同蜿蜒缠绕的蛇，伏在地面，吊在空中。\n思维的信号宛如一条无人可见的河流，但天才早已习惯于与之打交道。大脑是它们的源头，再淌过机械的管线，最终汇聚在这具新造的躯壳中。\n意识被传递的同时，许多尘封的记忆也被久违地翻出，家人、弥萨格、未完成的实验……恍惚间，天才想起许多年前，在她还未脱离最初的肉身桎梏时，曾有个无聊的学生，饶有兴趣地围着她转来转去，眼里闪烁着名为好奇心的光芒。\n「您认为，人造的躯体能承载真正的魂灵吗？」\n凡人总爱幻想一些远超他们视野的事物，这是个庸俗的问题。但身为教师，她仍给出了几句回应，纵然没抬一下眼。\n「你的身体未尝不是人造之物，心脏、四肢、五感这些器官的运行又和机械有何区别？」\n「好了，比起胡思乱想这些，不妨抽出时间，好好锻炼下你那生锈的大脑，否则，你这具流通着血液的肉体只会更无用。」\n如今，发问之人早已被时间的砂砾掩埋，不复存在。唯有承载智慧的脑缸仍在思考，并永远思考。\n世人口中所谓的魂灵不过是860亿个神经元交错而成的电化学活动，血肉也好，机械也罢，原材料的相异不会改变它们只是载体的本质。\n是啊，凡人无能为力，但身为天才的她能够做到，且已经做到——唯有如此，才能解明世界的真理，抵达知识的顶端。\n视觉，不过是光线穿过眼球，最终于视网膜上聚焦成像。\n嗅觉，不过是气味分子与受体结合，划过神经的化学感知路径。\n听觉，不过是声波经耳蜗换能，转化为上传至皮层的电信号。\n人偶身处之地太过昏暗，微弱的灯光摇曳，连影子也无法被映照。她双目微闭，因为清楚哪怕睁开它们，映入眼帘的也不过是一成不变的画面。\n房间被打扫得一尘不染，瓶罐中的药液也被紧紧封存。机体不需要呼吸，更没必要为了测试感官而去摄取这无味的空气。\n唯有一声冰冷的机械提示音，回荡在空旷的实验室中：\n「意识同调完成，机体启动确认。」\n足够了。\n虽是无机质的声音，但听起来倒亲切，仿佛锚定了物质世界的真实，又像只是在单纯提醒她，短暂的休憩结束，是时候投身于新一轮的研究中了。"
  },
  CollectionHall_148138_Title = {
    Text = "魂灵同调"
  },
  CollectionHall_148140_Desc = {
    Text = "<Title:简介>\n冰风刺骨的雪夜，赤脚的女孩将灵魂献给了蠕虫。\n如果出卖这种廉价之物，就能换取多少人渴求不来的幸福，她没有什么好犹豫不舍的。\n从此她像一个白色的影子，游走于荒芜的人间，用谎言编织圣殿，用糖果伪造赐福，换取糊口的供奉。\n她和蠕虫，就像是最好的搭档。\n直到山巅传来新的讯息，昭告世人足以实现所有愿望的圣地。\n那根火柴被划亮了。\n她将用它融化整座雪山。"
  },
  CollectionHall_148140_LockTip = {
    Text = "通关调查行动星辰篇第6章「山宴」解锁"
  },
  CollectionHall_148140_Title = {Text = "卡拉布"},
  CollectionHall_148143_Title = {
    Text = "终北大陆"
  },
  CollectionHall_148163_Title = {Text = "山宴"},
  CollectionHall_149045_Desc = {
    Text = "「把花环戴好，这就是你的授勋礼了，亲爱的小骑士。」\n雏菊开遍原野时，总有怠惰的兵士借着护卫的名头，拉着少年在此游荡。\n亚奎丹公国最常见的花编做的饰品，被轻轻地放在金色的发上。\n「阁下，也许……我们该训练了？」\n少年这样说着，却乖巧地将洁白的花环戴正。\n这小巧的植物，总是沐浴于光明之中，在少年的国度，亦是希望的象征。\n再度睁开双眼时，那些明丽的画面已不复存在。\n战马在嘶鸣，敌人不屑地一拥而上，在千军万马中，他只有孤身一人。\n然后，刺耳的喧哗声戛然而止——\n黑色的潮水涌入他的灵魂。\n随之响起的是长枪贯穿皮肉的撕裂声，鲜血的涌动声，敌人的哀嚎声。\n那些面孔上的轻蔑荡然无存，取而代之的是铺天盖地的畏惧与退缩。\n而少年只是机械地抬手，刺穿，拔出，再举起。\n直到最后一名士兵倒下。\n烟尘隐没了无数面孔，征伐者与被征伐者的残骸堆积在地，再无分别。\n影子缠上他的脊背，嗤笑着：「继续呀。落下你的枪，再多一次。」\n「守护者与毁灭者之间，本就只有一线之隔。如今，你已做出了选择。」\n黑暗遮蔽了天空，血浸透了大地。\n他看向远方的郊野——只是短短一夜，那里便永远失去了往日的色彩。\n风吹起少年的衣角，也掠过那片侥幸存留的草地。\n在无声的夜色中，在恶魔也不知道的角落里，一抹难察的纯白仍留在他的眼底。\n那是这个国度的最后一朵雏菊，在无人在意之地默默生长。\n尽管沾染了赤色，花茎弯折，却仍未倒下。"
  },
  CollectionHall_149045_Title = {
    Text = "而雏菊仍然盛开"
  },
  CollectionHall_149759_Desc = {
    Text = "<Title:简介>\n奥吉尔终究还是承认，以他的年纪与力量，尚不足以成为护国的骑士。\n在这个世界，他没能得到那句关键的支持。\n于是，在公主的劝导下，他回到了父亲的领地，像普通贵族少爷那样生活。\n\n战火袭来之时，仍无法抛却骑士身份的奥吉尔赶回王宫，却为时已晚。\n公主以最残酷的方式自我毁灭；熟悉的同僚无一生还——他们在最后一刻仍坚守阵地。\n当敌军闯入早已破败的宫殿，想将这里劫掠一空时，他无法抑制愤怒与哀痛，选择将身体交付给那充满诱惑的黑暗力量。\n敌人来不及重整阵型，尽数毙于他手，可复仇之后，少年并未感到半分解脱。\n\n漆黑的影子占据了他的躯体，侵染了他的灵魂，在那段浑浑噩噩的日子里，他犯下了许多过错。\n\n——杀戮，破坏，做一切有违誓言之事......直到一缕阳光将他从无边的虚无中唤醒。\n\n或许，现在开始后悔还来得及。\n他仍有机会重新执起枪与盾，为守护美德而战。"
  },
  CollectionHall_149759_LockTip = {
    Text = "唤醒「负誓·奥吉尔」后解锁"
  },
  CollectionHall_149759_Title = {
    Text = "负誓·奥吉尔"
  },
  CollectionHall_149927_LockTip = {
    Text = "通关调查行动星辰篇6-1解锁"
  },
  CollectionHall_149927_Title = {
    Text = "无愿的尖峰"
  },
  CollectionHall_149928_LockTip = {
    Text = "通关调查行动星辰篇6-17解锁"
  },
  CollectionHall_149928_Title = {Text = "风雪夜"},
  CollectionHall_48609_LockTip = {
    Text = "可于调查行动1-8中解锁"
  },
  CollectionHall_48609_Title = {
    Text = "锈蚀钥匙"
  },
  CollectionHall_48611_Desc = {
    Text = "<Title:物质维度>\n物质存在的维度，人类日常生活所处的「现实世界」。\n物质维度中，空间以三维呈现，时间线性，物质可感，情绪和精神抽象不可见。\n一切如此自然，仿佛那些不可理解的事物从未存在过。\n\n<Title:精神维度>\n精神所在的维度，又被称为「幻梦维度」。\n精神维度中，情绪、记忆、执念等，都可能形成不同的个体。\n除物质维度个体的精神外，这里还栖息着各种精神维度的生物。这类生物难以靠肉眼观测，只能借助特殊仪器感知，或于密境中窥探。"
  },
  CollectionHall_48611_Title = {Text = "维度"},
  CollectionHall_48612_Desc = {
    Text = "<Title:定义与特性>\n一种物质特殊消解、溶解的现象。\n除却少数个体，绝大多数人类无法通过肉眼观测融蚀现象。\n随着融蚀发展，被融蚀者的存在本身将被抹去。生活痕迹、书面记录、乃至与其相关的记忆悉数消失。\n他们将被整个世界遗忘。\n\n<Title:融蚀传播>\n无可考传播途径。\n融蚀的出现与消失似乎完全随机，无法预测，也无迹可寻。当前仅可通过特定的方法和手段，如特殊仪式、遗物等，达到扩散融蚀的效果。\n\n<Title:融蚀干预>\n仅能通过银芯及银芯制品对其进行干预治疗。\n大部分更易被融蚀侵蚀，可在彻底消解之前通过银芯制品干预。\n极少数个体对融蚀有一定抗性，但其精神将受到不可逆的损伤，无法通过银芯制品进行修复，目前尚未找到有效干预手段。"
  },
  CollectionHall_48612_Title = {Text = "融蚀"},
  CollectionHall_48614_Title = {Text = "门"},
  CollectionHall_48616_Desc = {
    Text = "<Title:创办日期>\nA.F.187，前身弥萨格学院创办于A.F.90\n\n<Title:创始人>\n华德·菲利普斯，刻拉尔克什，塔薇\n\n<Title:概述>\n以抵抗融蚀为己任的特殊大学。\n完全独立于各国政府的第三方，不参与任何政治斗争，不归属任何派系。\n全体师生加上教职员工仅一千余人，除开经济、人文、科学等方面的普通课程，还针对调查员、守密人及唤醒体开设了特殊课程。\n主校区位于雷欧王国，当世界各地出现融蚀现象时，会派出调查队与调查员、守密人前往解决。\n是一个理论与实践并重的特殊组织，挂科的后果同样很严重。"
  },
  CollectionHall_48616_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_48616_Title = {
    Text = "弥萨格大学"
  },
  CollectionHall_48618_Title = {Text = "序"},
  CollectionHall_48619_Desc = {
    Text = "<Title:创办日期>\nA.F.186\n\n<Title:创始人>\n《密斯底亚协定》签署国\n\n<Title:概述>\n普通人类构成的全球性组织。\n由各国政府共同出资建立，独立于政府存在，是融蚀现象的官方管理者及第一响应者。\n成员多是没有神秘学背景和超自然能力的普通人，以对抗融蚀为第一要务和唯一目标。\n在世界各国设有多个办事处，分别负责不同的区域。\n严肃刻板是所有人对它的第一印象，浆洗过度的白色制服就和他们的背脊一样笔挺。"
  },
  CollectionHall_48619_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_48619_Title = {
    Text = "密斯底亚协定审查会"
  },
  CollectionHall_48622_LockTip = {
    Text = "可于调查行动1-2中解锁"
  },
  CollectionHall_48622_Title = {Text = "联络点"},
  CollectionHall_48623_Title = {
    Text = "弥萨格大学"
  },
  CollectionHall_48624_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_48624_Title = {Text = "银芯"},
  CollectionHall_48625_LockTip = {
    Text = "通关意识潜游「一步之遥：似雨之泪」解锁"
  },
  CollectionHall_48625_Title = {
    Text = "生命的余影"
  },
  CollectionHall_48628_Desc = {
    Text = "嗷呜，嗷呜！\n孤狼带上面具，发出吼声扑来。"
  },
  CollectionHall_48628_Title = {Text = "荒原狼"},
  CollectionHall_48629_Desc = {
    Text = "所有人都会喜欢白色绒绒兔，包括可爱的爱丽丝。"
  },
  CollectionHall_48629_Title = {Text = "诅咒兔"},
  CollectionHall_48630_Desc = {
    Text = "小心扎手。"
  },
  CollectionHall_48630_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_48630_Title = {
    Text = "<WhiteQuality:无名附肢>"
  },
  CollectionHall_48631_Desc = {
    Text = "这只小黄螺出身高贵，有着完美的、无可挑剔的来源。"
  },
  CollectionHall_48631_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_48631_Title = {
    Text = "<WhiteQuality:小黄螺>"
  },
  CollectionHall_48635_Desc = {
    Text = "<Title:简介>\n弥萨格代理院长。\n师从克劳利·麦金农，是赫伯特的直系学妹。\n赫伯特弑师的见证者之一，在导师死后一直代为处理学院相关事宜。\n绝对的效率至上主义者，从不迟到，剪短发是因为可以节省梳头的时间。\n因战乱从祖国埃尔克偷渡到雷欧。\n右手食指无法正常弯曲，据说是在集中营被残忍对待的证明。"
  },
  CollectionHall_48635_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_48635_Title = {Text = "诃勒特"},
  CollectionHall_48636_Desc = {
    Text = "<Title:简介>\n三大创始人之一，与华德·菲利普斯，刻拉尔克什一同创立了弥萨格大学的前身——弥萨格学院。\n是第一个「唤醒体」，也是提供唤醒体科技的存在。\n常年镇守黑池，见过她的脸的人屈指可数，是弥萨格大学最高机密之一。\n「嘘……不可试探你的@2。」"
  },
  CollectionHall_48636_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_48636_Title = {Text = "塔薇"},
  CollectionHall_48941_LockTip = {
    Text = "可于调查行动1-8中解锁"
  },
  CollectionHall_48941_Title = {
    Text = "锈蚀门扉"
  },
  CollectionHall_48942_Desc = {
    Text = "我的灵魂是一座坟墓。"
  },
  CollectionHall_48942_Title = {Text = "放逐"},
  CollectionHall_48943_Desc = {
    Text = "深呼吸，多米尼克。"
  },
  CollectionHall_48943_Title = {Text = "吮吸"},
  CollectionHall_48944_Desc = {
    Text = "不朽不败。"
  },
  CollectionHall_48944_Title = {Text = "眷顾"},
  CollectionHall_48945_Desc = {
    Text = "至垂死之时，迸发出生之渴望。"
  },
  CollectionHall_48945_Title = {Text = "活性"},
  CollectionHall_48946_Desc = {
    Text = "眼见为实。"
  },
  CollectionHall_48946_Title = {Text = "洞悉"},
  CollectionHall_48947_Desc = {
    Text = "我们是空心人，我们是稻草人。"
  },
  CollectionHall_48947_Title = {Text = "熟成"},
  CollectionHall_48948_Desc = {
    Text = "嘘……止于此，止于我。\n不可试探其来历。"
  },
  CollectionHall_48948_Title = {Text = "贪婪"},
  CollectionHall_48949_Desc = {
    Text = "荷蒙库鲁斯在上，为您奉上纯洁无暇的躯壳。"
  },
  CollectionHall_48949_Title = {
    Text = "少女之蛹"
  },
  CollectionHall_48950_Desc = {
    Text = "致命的甜蜜在鼻腔扩散。\n小心——黏腻的死亡来了。"
  },
  CollectionHall_48950_Title = {
    Text = "甜蜜蛞蝓"
  },
  CollectionHall_48968_Desc = {
    Text = "关于德克斯特勋爵的手杖，弥萨格校园内流传着许多猜想。\n\n「毫无疑问，勋爵的手杖和他的笑容一样藏有秘密。\n究竟是镶有银芯能够调动唤醒体之力，还是暗藏火药可以随时化身枪械呢？\n就让德克斯特勋爵为我们揭秘一下吧！」\n\n边念边速记下开场白后，汉娜将相机对准了德克斯特勋爵，期待着来自持有者本人的下文。\n\n「它吗？没什么特殊的，只是德克斯特家族定制的日用手杖罢了。\n我的这柄上所用的宝石，甚至不如我兄长的珍贵。\n如果一定要说它有什么特殊之处的话……\n它曾经沾上我父母和兄弟的鲜血，这算不算？」"
  },
  CollectionHall_48968_Title = {
    Text = "勋爵手杖"
  },
  CollectionHall_48969_Desc = {
    Text = "伦蒂尼恩的地下世界流传着这样一个故事。\n\n繁忙的码头上、僻静的巷道中、嘈杂的酒馆内……\n你不知道何时、在哪里能找到那个拿着相机，戴着眼镜，穿着制服的少女，但只要找到她，就能买到任何你想要的信息，而代价只有一个——\n\n提供一个仅有你知道的秘密。\n\n有人用吧台边听到的酒后真言换来了竞争对手的致命弱点。\n有人用自己的弱点换来了情人闭口不谈的过去。\n少女握有无数情报，唯有一个是用何等秘密都无法换来的。\n\n「关于我的事情？抱歉啊，这可是非卖品哦。」"
  },
  CollectionHall_48969_Title = {
    Text = "信息就是生命"
  },
  CollectionHall_48970_Desc = {
    Text = "弥萨格校园中最不能招惹的人，如果朵尔自居第二，那么第一名非茜尔维娅女士莫属。\n\n身为弥萨格唯一的心理医生，这位神秘的女士不仅要负责安抚任务中受惊的调查员，疏导唤醒体躁动的情绪也是她的职责。\n非但不畏惧唤醒体，还能在精神上与他们分庭抗礼——这究竟是怎样的一位强者呢？\n\n怀着对未知的好奇，缺失了几分敬畏之心的新生于深夜溜进了茜尔维娅女士的诊疗室。\n\n然后，他们就失去了意识。\n次日清晨在校园广场上醒来时，他们头疼欲裂，内心却是前所未有的明朗。\n有人捡起了从他们口袋里飘落的信笺：\n\n「如果需要心理咨询，请提前向艾瑞卡小姐申请哦——\n茜尔维娅」"
  },
  CollectionHall_48970_Title = {
    Text = "心之壁垒"
  },
  CollectionHall_48971_Desc = {
    Text = "在贵族夫人怜悯又嫌恶地用手帕捂住鼻子，差遣仆人将不要的珠宝给她时，她想：\n多好啊，济贫院的孩子们能吃上一餐肉了。\n\n在她将自己的餐食都分给孩子们，自己则因为长时间饥饿而晕倒在走廊后，她说：\n没事的，别叫医生，诊金可值好几个面包呢。\n\n在好心的艺术家带着相熟的医生前来拜访，并向她提出长期合作时，她想：\n必须让他们先在我身上试试，不然我可不放心让孩子们来接受他们的这个什么治疗。\n\n莎拉什么都可以忍受，唯一不能忍受的便是所做的一切，最终却导致了悲剧的结局。"
  },
  CollectionHall_48971_Title = {Text = "临界点"},
  CollectionHall_48972_Desc = {
    Text = "手在黑暗中四处乱转，寻找自己的主人。\n\n在那个血腥的夜晚，它被从主人身上残酷剥离。\n此时此刻，带走它的罪魁祸首在它四周流淌，发出奇特的嗡鸣。\n \n「放弃吧，和我们离开。蜡像师会将你彻底遗忘。」\n\n手不为所动，它拨动着自己引以为豪的、修长的手指。\n\n「主人不会忘记我。\n我是他艺术实现的唯一途径——\n你们不明白我对他而言意味着什么。」\n\n「就像人会遗忘爱人，遗忘时间，但不会遗忘自己。」\n\n黑暗中传来同情的笑声。\n「恰恰相反，人最先遗忘的总是自己。\n不过没关系——」\n\n时间会解释一切，手迟早会明白这个道理：\n没有什么是不能被遗忘的。\n它们流淌了一个又一个世纪，人间的故事在它们身边发生，第二天就被遗忘。\n而它们依旧在不停地流淌。"
  },
  CollectionHall_48972_Title = {
    Text = "遗忘之手"
  },
  CollectionHall_48973_Desc = {
    Text = "自被华德·菲利普斯先生收留以来，阿利斯泰尔陪同他出席过不少次弥萨格的高层会议。\n\n说是高层，实际上更像是每个月一次的辩论赛：\n菲利普斯先生语气温和，循循善诱；\n刻拉尔克什言辞辛辣，寸步不让。\n他们轮流做正方或者反方，为了弥萨格的未来或下个月唤醒系的资源配给争执不休。\n塔薇小姐是个沉默的旁观者，从不轻易给出自己的建议。\n他自己则努力做个正直的记分员，偶尔兼职裁判，甚至有一次得用上一些格斗技巧，避免小小的会议桌遭遇不测。\n\n而今，会议成员仅剩两个，一个永远不能离开黑池，另一个也为了搏得那可能的「未来」而再也不能离开地下。\n至于那张桌子，早在那次事件后就再也找不着了。"
  },
  CollectionHall_48973_Title = {
    Text = "聚首时刻"
  },
  CollectionHall_48974_Desc = {
    Text = "塔薇沉睡于黑池之底。\n\n那里终年无声无光，只有一片令人绝望的黑暗。\n从未有客人造访过这里，从未有声音抵达过这里。\n这里是毁灭无法企及之地——\n\n因为灾厄已经降临。\n\n身为时序的司掌者，她目睹过太多惨痛的终局。\n身为规则中的一员，她也无力阻止黑夜的降临。\n既然如此，只能蛰伏于不存在之地，以不存在之姿等候堪称「变数」之人到来。\n\n那个人终将到来。"
  },
  CollectionHall_48974_Title = {
    Text = "不存在之地"
  },
  CollectionHall_48975_Desc = {
    Text = "科学是光谱分析，艺术是光合作用。"
  },
  CollectionHall_48975_Title = {
    Text = "光合祭礼"
  },
  CollectionHall_48976_Desc = {
    Text = "旋转，然后遗忘——这是她生命的全部。"
  },
  CollectionHall_48976_Title = {
    Text = "36室之环"
  },
  CollectionHall_48977_Desc = {
    Text = "我唾弃你的坟墓。\n因你在死中寻得了难得的平静。"
  },
  CollectionHall_48977_Title = {
    Text = "埋骨地絮语"
  },
  CollectionHall_48978_Desc = {
    Text = "永恒于启示之中投来的一缕视线。\n纯洁、无垢且真实。"
  },
  CollectionHall_48978_Title = {
    Text = "无垢启示录"
  },
  CollectionHall_48979_Desc = {
    Text = "脐带连接着母体，供胎儿榨取无尽的未来。"
  },
  CollectionHall_48979_Title = {
    Text = "生机榨取"
  },
  CollectionHall_48980_Desc = {
    Text = "归来吧，那终将重现的失落之城。\n归来吧，@3！"
  },
  CollectionHall_48980_Title = {Text = "海归线"},
  CollectionHall_48981_Desc = {
    Text = "鳞翅目正死于孤独、爱与绝望。"
  },
  CollectionHall_48981_Title = {
    Text = "有机形态"
  },
  CollectionHall_48982_Desc = {
    Text = "他被埋葬在18@2年的春天。\n墓碑林立，如无声的赞歌。"
  },
  CollectionHall_48982_Title = {
    Text = "四月礼赞"
  },
  CollectionHall_48983_Desc = {
    Text = "一千年前，五分钟等于四十盎司细沙。"
  },
  CollectionHall_48983_Title = {
    Text = "入药之梦"
  },
  CollectionHall_48984_Desc = {
    Text = "必然的，偶然的。有限的，无限的。"
  },
  CollectionHall_48984_Title = {
    Text = "二律背反"
  },
  CollectionHall_48985_Desc = {
    Text = "代理院长是弥萨格校园中的异类。\n\n在各具异能怪物横行的弥萨格调查员中，她是极少数毫无任何超越人类基本能力的个体之一，却担任了代理院长这一重要职能。\n出身于埃尔克王国普通家庭的她，在当地特色文化熏陶下形成了勇猛凶悍的性格。\n\n后来，在战俘营的同伴索菲亚点燃了她对学术研究的热情。\n突出的学术成就让她成为了她的导师、弥萨格大学生物学院前任院长的最认可的弟子。\n所以，在导师失踪后，她便顺理成章地接下了代理院长的职责。\n在她的坚守下，生物学院的研究有条不紊地运转。\n\n「不畏惧暴力，不畏惧霸权，自然也不会畏惧职责所在。」"
  },
  CollectionHall_48985_Title = {
    Text = "职责所在"
  },
  CollectionHall_48986_Desc = {
    Text = "调查员间有个不成文的规定：\n\n钥冢仪式后的那一夜，资历更深的调查员会带领新晋调查员在宿舍后院聚会。\n他们会点起蜡烛，围着自己的银钥匙坐成一圈。\n资深的调查员会告诉每个新人，他们手上这个有着独一无二编号的钥匙有过怎样的故事。\n\n这样的活动最后都会变成某种故事大会，而I-0001及K-0001，这两把代表「初代」的钥匙，自然也会成为讨论的中心。\n鲜有人知道的是，由初代守密人亲手制作而成的K-0001号银钥匙，如今和它的主人一同永居地下，在无法分辨日夜的漫长等待中，聆听那人对早已逝去之人的低语。\n\n「你知道他不是真的在这里吧，阿利斯泰尔。」朵尔说，「它或许是用你老师的银芯做的，但不能被视作他的灵魂。」\n「这只是一种专注精神的方式罢了，朵尔。」阿利斯泰尔笑了笑，「放心，我很稳定，可不能在我们的新晋守密人成长起来前就倒下，你说对吧？」"
  },
  CollectionHall_48986_Title = {
    Text = "专注精神"
  },
  CollectionHall_48987_Desc = {
    Text = "他生命的前半段是混沌、黑暗与血腥的。\n\n吃了睡，睡了吃......后来，他睁开双眼，拥有了意识。\n\n他们说他吃掉了自己所有的兄弟姐妹，是唯一的生还者。\n他们还说他是伟大的蛇神与人类交合诞下的子嗣。\n他的脖颈上有一圈黑色的咒缚，它们维系着他的生命，也控制他，使他此生都无法违抗教会。\n他对这个世界有诸般疑惑与好奇，却在诞生伊始便被剥夺了所有其他的可能性。\n\n美丽的、危险的。隐匿的、张扬的。这些都是他。\n遗憾的是，以上供述尚未触及他的本质的十分之一。\n任何因此供述对阿尔比诺产生的恻隐之心都将令你万劫不复。"
  },
  CollectionHall_48987_Title = {Text = "苦咒缚"},
  CollectionHall_48988_Desc = {
    Text = "医生的天职，本是治愈病人。\n\n但偏巧有那么一种治愈手段，需要以最锋锐的刀刃划破皮肤，刺穿肌理，剖开胸膛，摘除病灶，然后许愿人体凭借自愈能力的重生。\n\n这原本不应当是她的罪。\n但每次完成手术后，她还是忍不住补偿似的给那个女孩讲点故事。\n她不是个好的讲述者，话语支离破碎，但那些虚构的故事仍让女孩认真专注地听了进去。\n被她亲手切割之处，仿佛缓慢而顽强地吸收着那些话语的力量，渐渐自然愈合……"
  },
  CollectionHall_48988_Title = {
    Text = "切割与伤害"
  },
  CollectionHall_48989_Desc = {
    Text = "巨兽潜伏于夜色之中。\n\n小屋之内，痛失爱女的哀哭声在每个午夜冲破白日的隐忍与压抑，毫无掩饰地剧烈迸发。\n从啜泣到哀嚎，最后诉说着那个已经不属于巨兽的名字，以痛楚的呼唤声贯穿巨兽那颗与人类一般无二的心脏。\n\n回家吧，丽莎。\n噢，我的丽莎。\n巨兽无声，潜伏于夜色之中。蜷缩身形，沉沉睡去。\n终有一日，她要回去，回到那个名为「家」的地方。"
  },
  CollectionHall_48989_Title = {
    Text = "伏于夜色"
  },
  CollectionHall_48990_Desc = {
    Text = "没有人一出生就是船长，至少埃尔顿不是。\n\n在成为一名船长前，他一直在海军与商船间辗转，好几次险些成了海盗，好在最后，他在一艘探险船上安定了下来。\n\n探险船围绕着极地大陆航行，每次登陆都意味着一场新的冒险。\n他的职责是为体弱的科学家背负行囊，他曾为此感到自豪——行囊里装着的，说不定是能改变世界的东西。\n而他们，或许是即将改写历史的人。\n\n在一场冰风暴将他们困在冰洞之前，在一队神秘教徒深夜袭击了他们之前，埃尔顿一直是这么认为的。"
  },
  CollectionHall_48990_Title = {
    Text = "冒险的行囊"
  },
  CollectionHall_48991_Desc = {
    Text = "他一直是个沉默、勤奋的学生。\n\n早上8点，当其他研究员叼着面包急匆匆赶到时，他已经写完了一篇实验报告。\n晚上12点，当实验楼的灯全部熄灭时，他才慢吞吞收拾东西离开。\n\n对了，他还会每天喂养附近的小野猫。\n后来小野猫不见了，没人知道它们去了哪里。\n\n导师克劳利剖析着他的实验记录和报告。\n简洁、细致，没有任何闪光之处——但也没有任何破绽。\n这个学生令他疑惑。\n但疑惑总是好的，它往往是通向好奇心的开关。\n\n当然，那时候的克劳利并未料到：它也可能是通向死亡的开关。"
  },
  CollectionHall_48991_Title = {
    Text = "死亡的剖析"
  },
  CollectionHall_48992_Desc = {
    Text = "「不知不觉中，你已经离开这么久了。\n\n我还是经常在梦里回到那天，左臂枪伤的疼痛，失血造成的迷幻错乱，暴乱鼠群的追击……\n在那片混乱中，穿着弥萨格校服的你出现了，带我逃离了那座早就充斥不详的古堡。\n\n在那个梦的最后，你站在病床前告诫我，对调查员来说，死亡总是如影随形的。\n我已经无法判断那是真实还是我的幻想了。\n每当这个时候，我就会去触摸我的左臂，如果能碰触到冰冷精致的金属表层，那便是现实。\n\n但在更多的梦境里，我只抓握住一片虚空。」"
  },
  CollectionHall_48992_Title = {Text = "致挚友"},
  CollectionHall_48993_Desc = {
    Text = "克劳利在任教期间一直蝉联「最受欢迎导师」的荣誉称号。\n\n他略显笨拙的康斯坦西部口音与真诚的笑容为他赢得无数学生的好感，这其中也包括赫伯特。\n\nA.F.2@1年，克劳利力排众议，将毫不起眼的赫伯特收为自己的学生。\n赫伯特与他一起翻越高山、跨过溪流、穿过沙漠，在一个又一个融蚀裂隙外留下足印。\n他犹记第一次见到融蚀裂隙时的震撼。\n\n克劳利站在蒸腾而上的黑色浓雾前，身形显得如此渺小。\n「嘘——你听到了吗？」\n赫伯特于是闭上双眼，只听到寂静海洋不断翻滚的声音，世界似乎离他远去了。\n克劳利兴奋极了，他说：\n「这是诗。宇宙中最神秘、最深沉的诗。」\n\n多年以后，赫伯特对克劳利的记忆早已模糊。\n比如他们如何合作、争执，比如他如何将他「失手」杀死。\n但他永远记得那个黑雾之下的笑容。\n那一刻，他看见诗。"
  },
  CollectionHall_48993_Title = {
    Text = "记忆症候"
  },
  CollectionHall_48994_Desc = {
    Text = "只要我们的大脑仍是个谜，那么里面长满触腕也没什么好大惊小怪的。"
  },
  CollectionHall_48994_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_48994_Title = {
    Text = "<WhiteQuality:裂头蚴>"
  },
  CollectionHall_48995_Desc = {
    Text = "梦想是星辰大海！"
  },
  CollectionHall_48995_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_48995_Title = {
    Text = "<WhiteQuality:潜水头盔>"
  },
  CollectionHall_48996_Desc = {
    Text = "见不可视者，听不可闻者。"
  },
  CollectionHall_48996_Title = {Text = "明悟"},
  CollectionHall_48997_Desc = {
    Text = "一切恶的根源。"
  },
  CollectionHall_48997_Title = {Text = "惩戒"},
  CollectionHall_48998_Desc = {
    Text = "万物化为己有。"
  },
  CollectionHall_48998_Title = {Text = "暴食"},
  CollectionHall_48999_Desc = {
    Text = "不见往昔，不念未来。"
  },
  CollectionHall_48999_Title = {Text = "狂乱"},
  CollectionHall_49000_Desc = {
    Text = "将爱与死亡献给世界。"
  },
  CollectionHall_49000_Title = {Text = "宠爱"},
  CollectionHall_49001_Desc = {
    Text = "积蓄良久，于此宣告——"
  },
  CollectionHall_49001_Title = {Text = "涌现"},
  CollectionHall_49002_Desc = {
    Text = "呼唤其名：厄瑞克斯。"
  },
  CollectionHall_49002_Title = {Text = "谵妄"},
  CollectionHall_49003_Desc = {
    Text = "与「祂」的交谈。"
  },
  CollectionHall_49003_Title = {Text = "呢喃"},
  CollectionHall_49004_Desc = {
    Text = "赐予萌芽与胚胎的祝福。"
  },
  CollectionHall_49004_Title = {Text = "希冀"},
  CollectionHall_49015_Desc = {
    Text = "在灾厄凭空消失，危机宣告暂时解除后，弥萨格特别行动队带着「意外收获」离开了阿库特。\n德克斯特小姐最后回头看了一眼爆炸中心的巨坑，不知名植物的嫩芽竟不知何时悄然破了土。\n她松了一口气，心情愉悦。\n阿库特林地将会迎来它的春天。\n杨柳会在下一个春天到来时抽条，铃兰会在下一个雨季后悄然绽放，所有的生命都将迎来新生。\n而他们对抗未知的旅途，也将踏上新的起点。\n"
  },
  CollectionHall_49015_Title = {
    Text = "阿库特之春"
  },
  CollectionHall_49018_Desc = {
    Text = "A.F. 314，冬日的一个深夜，爆炸声响彻阿库特林地。\n大地震颤，林地亮如白昼。伴随着生命的尖啸与自然的哭嚎，村镇被夷为平地。\n据参与了「阿库特灾厄调查」的唤醒系预科生德克斯特所言，那一夜冲天的火光中，闪耀着黑与银的色彩。"
  },
  CollectionHall_49018_Title = {Text = "陨日"},
  CollectionHall_49025_Desc = {
    Text = "浓黑的血祭，愿双子庇佑你的肉体。"
  },
  CollectionHall_49025_Title = {
    Text = "扭曲双子·黑"
  },
  CollectionHall_49026_Desc = {
    Text = "雾白的祝祷，愿双子庇护你的灵魂。"
  },
  CollectionHall_49026_Title = {
    Text = "扭曲双子·白"
  },
  CollectionHall_49027_Desc = {
    Text = "尽情享受欢宴吧，于歌声中，庆祝被毁灭的故乡。"
  },
  CollectionHall_49027_Title = {
    Text = "远方的欢宴"
  },
  CollectionHall_49028_Desc = {
    Text = "传说中最初的魔偶创造者，以血液滋养魔偶。"
  },
  CollectionHall_49028_Title = {
    Text = "猩红之悸"
  },
  CollectionHall_49029_Desc = {
    Text = "机械绝对纯净，神明至高无上。\n降临的并非线团，而是伟大的阿里阿德涅。"
  },
  CollectionHall_49029_Title = {
    Text = "机械降神"
  },
  CollectionHall_49030_Desc = {
    Text = "繁衍吧，繁衍吧。让流淌着母树鲜血的灵魂遍及世界。"
  },
  CollectionHall_49030_Title = {Text = "再衍化"},
  CollectionHall_49031_Desc = {
    Text = "传说中最初的魔偶创造者，以双手杀死魔偶。"
  },
  CollectionHall_49031_Title = {
    Text = "猩红之拥"
  },
  CollectionHall_49033_Desc = {
    Text = "时间的弦根根绷断，流动的琴键纷纷碎裂。\n祂们立于现实之外，以现实为材缝补残缺，让永不谢幕的乐章再度奏响高天之上。\n至于那片刻梦醒时落的泪流向了何方，无人得知。"
  },
  CollectionHall_49033_Title = {
    Text = "灵魂诞生"
  },
  CollectionHall_49082_Title = {
    Text = "伦蒂尼恩室外"
  },
  CollectionHall_49084_Title = {
    Text = "02 以蜡像之名"
  },
  CollectionHall_49104_LockTip = {
    Text = "通关调查行动6-1解锁"
  },
  CollectionHall_49104_Title = {
    Text = "倒错的群星"
  },
  CollectionHall_49105_LockTip = {
    Text = "通关特遣纪录「血的颜色：悔过」解锁"
  },
  CollectionHall_49105_Title = {
    Text = "灵魂的牧人"
  },
  CollectionHall_49740_LockTip = {
    Text = "通关调查行动7-0解锁"
  },
  CollectionHall_49740_Title = {
    Text = "万千子嗣之母"
  },
  CollectionHall_49747_Desc = {
    Text = "自融蚀伤痕中长出的赘生物。\n目前为止，赘生物的生长与否、不同类型赘生物的分布等，都无法总结规律。\n可能是额外的肢体、触手，也可能是齿轮、金属等无机物。"
  },
  CollectionHall_49747_Title = {
    Text = "融蚀赘生物"
  },
  CollectionHall_49748_Desc = {
    Text = "<Title:定义与特性>\n直径超过5米，且仍有扩大可能性的巨大融蚀痕。\n根据融蚀裂隙的大小可被分为C、B、A、S、SS、SSS类裂隙。\n随时间推移将持续扩大，除去常规的融蚀扩散以外，还会引起异常自然现象，如海啸、飓风等。\n\n<Title:应对方式>\n由银芯精制而成的银钥匙可在一定程度上压制甚至「关闭」裂隙。\n守密人通过银钥匙放大自身精神，使其与精神维度产生共鸣，在融蚀裂隙上形成一道高维度屏障，使其暂时「关闭」。"
  },
  CollectionHall_49748_Title = {
    Text = "融蚀裂隙"
  },
  CollectionHall_49749_Desc = {
    Text = "融蚀裂隙的核心，通常也是守密人在外勤任务中需要解决的主要敌人。\n可扩散融蚀现象，会根据自身特性影响附近的融蚀现象，使其具有区域性特征。"
  },
  CollectionHall_49749_Title = {Text = "灾厄"},
  CollectionHall_49750_Desc = {
    Text = "<Title:定义与特性>\n融蚀现象导致个体异变、消融、死亡的现象。\n会发生在人类、动植物等有机生物体上，也会出现在矿物、金属等无机物上。融蚀裂隙附近的个体出现融蚀侵蚀的可能性更高。\n目前尚未发现能够免疫融蚀现象的物质。\n\n<Title:各时期特征>\n初期：体表出现倒三角形黑色融蚀痕，伴有融蚀浆析出。\n中期：融蚀痕扩大，持续析出融蚀浆，个体精神受损。可能产生融蚀赘生物。\n后期：融蚀痕迅速扩大，融蚀浆析出速度加剧。大部分个体在此阶段将完全丧失理智。\n末期：个体躯体崩溃，生理上构成死亡，精神仍被侵蚀。当精神被侵蚀殆尽时，个体完全消失，彻底失去唤醒可能。\n\n<Title:特殊案例>\n躯体类特殊案例：被融蚀个体出现躯体、五感增强现象。还有个体受到赘生物、灾厄等因素影响，具有飞行、精神影响、思维控制等特殊能力。\n精神类特殊案例：被融蚀个体精神受融蚀影响较小，保有基本理智。少数个体表现正常，与未融蚀个体无异。"
  },
  CollectionHall_49750_Title = {
    Text = "融蚀侵蚀"
  },
  CollectionHall_49751_Desc = {
    Text = "<Title:定义与特性>\n个体因为融蚀侵蚀而丧失躯体，化作融蚀浆及融蚀粉尘的现象。\n消解后的个体，其存在本身也将被从世上抹去。\n\n<Title:各时期特征>\n初期：与被融蚀个体不相熟之人会遗忘其存在。\n中期：与被融蚀个体相熟之人对其记忆开始减弱，与其相关的书面记载开始出现融蚀痕，变得模糊。\n后期：与被融蚀个体相熟之人对其记忆进一步减退，只留下一个模糊的印象，直至完全遗忘该个体。\n\n<Title:存在性消除>\n当消解发展到最终时刻，被融蚀个体的存在，包括其存在痕迹，将被彻底抹除。\n没有任何事物能证明他们曾存在于世，正如大多数人那样。"
  },
  CollectionHall_49751_Title = {Text = "消解"},
  CollectionHall_49752_Desc = {
    Text = "银芯或许是融蚀的终点：它是生命被融蚀侵蚀后，概率析出的类银物质。 它不仅蕴含着巨大的物理能量，还能与精神维度产生一定联系。某些情况下，这种联系甚至可以对「精神维度」产生干扰。 银芯是人类与融蚀对抗的关键之一。但因为形成方式的特殊性，银芯不仅数量稀少，价值亦珍贵非常。"
  },
  CollectionHall_49752_Title = {Text = "银芯"},
  CollectionHall_49753_Desc = {
    Text = "<Title:概述>\n所有对银芯加以利用的技术，统称银芯科技。\n世上绝大多数人并不知道银芯的存在，仅有弥萨格大学掌握着银芯科技，并设有银芯研究与应用专业，持续对银芯进行研究与开发。\n依照《密斯底亚协定》，弥萨格大学会向密斯底亚协定审查会提供银芯科技，以共同抵御融蚀，应对危机。\n\n<Title:唤醒体？>\n在弥萨格大学的唤醒体技术中，唤醒体的塑造需要围绕银芯进行。\n虽然唤醒体塑造并未记录在《银芯技术指导手册》中，但不少唤醒体会如此自嘲：\n「嘿，我们也是银芯科技的一种吧？」\n\n<Title:融蚀观察设备>\n有眼镜、面具等多种款式。使用银芯制造，能让佩戴者观测到密境、看见融蚀。\n\n<Title:弥萨格大学通讯器>\n最常见的款式为校徽形状的胸针。其核心为特殊处理过的银芯，通讯器不仅可以互相联通，还能达成与弥萨格校内的超远距离通讯。信号稳定，<Italic:一般情况下>不受自然现象干扰。\n\n<Title:弥萨格准入凭证>\n内含银芯的特殊凭证，只有持有凭证的人，才能避免迷失在弥萨格大学的迷雾屏障中。\n没有凭证的人，只会在大学外的树林中陷入无尽的知觉失调，等待轮值调查员的驱逐。"
  },
  CollectionHall_49753_Title = {
    Text = "银芯科技"
  },
  CollectionHall_49754_Desc = {
    Text = "<Title:原理>\n或自银芯中被唤醒，或受实验改造，或诞生自一场意外……\n他们古老又崭新。古老，是因为早在十几个世纪前的纸草书上，巫师们就隐秘地记录下了唤醒体在世间的行走。\n他们崭新，是因为我们尚未完全理解唤醒体的本质，就要与他们踏上拯救世界的道路。\n除了给予他们信任外，谨记：不要毫无防备。\n\n<Title:特性>\n唤醒体具有完整的人格，且保有自己「生前」的记忆，却因其具备的特殊能力，一度被视作人形兵器对待。\n为了维持世俗社会的稳定，唤醒体的存在在各国都是高度机密。\n目前，《协定》仅认可弥萨格大学唤醒的唤醒体，任何非弥萨格大学唤醒的唤醒体，被视作违反《协定》的存在，需要由官方进行记录并收容。\n\n<Title:界域>\n唤醒体能力各异，但研究员们总能在不同能力间找到一定相似性。\n根据这些相似性，弥萨格大学人为划分出了数个唤醒体界域。\n同一界域中的唤醒体能够更好地配合彼此，不同界域之间可能存在一定的排斥，仅有混沌界域不存在此现象。\n界域之间互斥的原因不明，据弥萨格大学唤醒系教授朵尔分析，或与某些不可知存在对精神维度的影响有关，但目前尚无证据证明其猜想。"
  },
  CollectionHall_49754_Title = {
    Text = "唤醒体认知基础"
  },
  CollectionHall_49755_Desc = {
    Text = "<Title:概述>\n以银芯为唯一原料的钥匙形道具。具有聚焦放大使用者精神、帮助联通并影响精神维度的能力。\n银钥匙是弥萨格调查员与守密人的身份象征，每一把银钥匙都有一个独一无二的编号，普通调查员的银钥编号以I开头，守密人的则以K开头。\n若调查员因故无法继续外勤行动，弥萨格校方将对其所持银钥进行回收，并在未来发放给其他调查员使用。\n但很可惜，回收记录显示，百年间仅收回了不足十把尚能正常运转的银钥。绝大多数银钥，都随着主人的逝去一同被破坏。\n\n<Title:制作与获取>\n■■机密文件第■■■号\n银■匙的塑造，需要在黑池中由■■■■■进行。\n■■■被塑造后，将进行编号篆刻，在钥冢仪式上将其赋予给相应的使用者。"
  },
  CollectionHall_49755_Title = {Text = "银钥匙"},
  CollectionHall_49756_Desc = {
    Text = "<Title:概述>\n密境，一个由现实世界与精神维度共同构筑出的特殊区域。\n弥萨格大学的菲利普斯先生曾在笔记中写道：世界上的一切异常，若非来自人心，便是诞生自密境。\n这里交织着生与死、现实与幻梦，它排斥真相，它藏匿真相。\n\n<Title:定义与特性>\n密境是人类能够肉身进入的最接近精神维度的空间，但人们对它仍知之甚少，正如人们对融蚀也一知半解一样。\n但可以确定的是，融蚀与密境总是同时出现：融蚀现象越严重，密境维度覆盖范围则越大。\n\n<Title:密境中的事物>\n作为脆弱的交界地带，密境极易受到影响。\n在密境中出现的特殊存在，如幻象、融痕、迷雾等，被认为是情感与思维的投射。借助这种特殊的投影机制，弥萨格得以在密境中投射了一部分联络点，以稳定调查员的精神，弥合唤醒体的伤口。\n不过现实中确实存在的事物，如地面、建筑等，在密境中通常不受影响。（别担心，密境中的道路<Italic:大部分时间>是安全的。）"
  },
  CollectionHall_49756_Title = {Text = "密境"},
  CollectionHall_49757_Desc = {
    Text = "<Title:创办日期>\n洪积前\n\n<Title:创始人>\n不详\n\n<Title:概述>\n泛劳拉西亚大陆最广泛的信仰。\n信徒众多，规模盛大。每年的特定时节各地都会举行庆祝仪式，其中最广泛的有银霜夜与冬渡节。\n组织内的神职人员自称「父神的代行者」，即代父神践行其意志之人，以消除世界的苦难为己任。\n认为人死后可以回归父神的怀抱，永栖无尽乐土，脱离世界上的苦难。\n拥有如此普世的教义，它理所当然地成为了一个受欢迎的宗教。"
  },
  CollectionHall_49757_LockTip = {
    Text = "通关特遣纪录「血的颜色：悔过」解锁"
  },
  CollectionHall_49757_Title = {
    Text = "生命教廷"
  },
  CollectionHall_49758_Desc = {
    Text = "<Title:创办日期>\n洪积前\n\n<Title:创始人>\n弥利亚姆\n\n<Title:概述>\n源自旧大陆的古老组织。\n成员多表现出上半身为鱼、下半身为人的特征，他们主要活跃在海洋及沿岸一带，未曾深入过陆地。\n据说他们蹈海而去，只为追寻王的足迹。他们蹈海而来，只为带来王的国度。\n所有的牺牲皆是为了那个失落的国度——利莫里亚，以及它困倦的王。"
  },
  CollectionHall_49758_LockTip = {
    Text = "通关调查行动第5章「风暴之眼」解锁"
  },
  CollectionHall_49758_Title = {Text = "蹈海者"},
  CollectionHall_49759_Desc = {
    Text = "<Title:创办日期>\n洪积灾变时期\n\n<Title:创始人>\n不详\n\n<Title:概述>\n隐秘的宗教组织。\n将融蚀视作神的馈赠，将银芯视作神的躯体，认为融蚀能够净化罪恶，将人度往无罪净土。\n人数众多但行踪隐蔽，有融蚀的地方总能隐约窥见他们的身影。\n据说源自一个古老的显赫家族，其家族成员集体消失的原因至今仍是史学家争论的焦点。"
  },
  CollectionHall_49759_LockTip = {
    Text = "通关调查行动第4章「于无声处」解锁"
  },
  CollectionHall_49759_Title = {
    Text = "提灯教会"
  },
  CollectionHall_49760_Desc = {
    Text = "<Title:诺斯指数>\n一种量化精神碎片在银芯中的稳定性的数值。\n诺斯指数高的唤醒体，精神碎片的稳定性就强，癫狂的程度较低，更不易发生失控现象，失控后可能造成的伤亡也会更少。\n不同唤醒体的诺斯指数不同，有的唤醒体由于个体情况特殊，会出现诺斯指数波动乃至无法准确测定的现象。\n\n<Title:唤醒体失控>\n作为核心，银芯为唤醒体们带来了世间不应存在的力量，却也为他们埋下了疯狂的种子。\n唤醒体被塑造时大多处于难以控制的疯狂之中，若无调查员的及时链接，失控的他们将对世界造成难以想象的破坏。因此，链接不仅是「增幅器」，更是不可或缺的「稳定器」。\n根据弥萨格大学的档案记录，目前校内仅有朵尔·@2在成为唤醒体初期便保持了理智。\n另外，「门内之物」塔薇及初代守密人阿利斯泰尔共同维系了L-01号融蚀裂隙下巨型银芯的稳定，所以在弥萨格大学校内，唤醒体们得以保持长久的理智。即使断开链接，也不会失控。\n\n<Title:唤醒体死亡>\n唤醒体在躯体机能上远强于人类，但面对来自异变体、灾厄、乃至融蚀裂隙及融蚀本身的威胁，仍会受到伤害，其躯体有被摧毁的可能。\n研究员相信，唤醒体躯体被摧毁后，其银芯中的意识会回归精神维度，等待被二次唤醒。\n银芯的损毁，或许意味着真正的「死亡」。\n\n<Title:二次唤醒>\n二次唤醒后，唤醒体的外表、性格、喜好与能力一般不会改变，记忆也会得到保存。但有些唤醒体会认为那与现在的自己是两个独立个体，弥萨格大学对这些声音持保留态度。"
  },
  CollectionHall_49760_Title = {
    Text = "唤醒体认知进阶"
  },
  CollectionHall_49761_Desc = {
    Text = "<Title:概述>\n某些唤醒体在能力、外形异变性状上表现出了高度的一致。研究员们由此推测，在唤醒过程中曾有某些未知存在影响（有些人认为是污染）了这些唤醒体的精神，并赋予了他们强大的力量。\n目前，研究员们将这些影响了唤醒体存在的力量称为「本源」。\n\n<Title:本源唤醒体>\n本源唤醒体是同名唤醒体的「另一个自己」。\n他们有着相似的特质，但却有着可能截然不同的人生经历，性格、爱好、表现乃至力量上都带有更多「本源」的特征。\n关于本源唤醒体的记载十分有限，弥萨格对这类现象的成因也知之甚少。有研究员根据本源唤醒体的出现，推测并发展出了「平行世界」存在的理论，但该理论目前尚未得到公布与进一步研究。"
  },
  CollectionHall_49761_Title = {Text = "本源"},
  CollectionHall_49762_Desc = {
    Text = "<Title:核心>\n唤醒体的核心是银芯。即使躯体完全解体，只要银芯尚存，便能对该唤醒体进行二次唤醒。\n\n<Title:躯体>\n唤醒体的躯体可能由各种材料构成，具体构成材料与结构与唤醒体自身的偏好及特征相关。\n唤醒体的躯体不由弥萨格大学工作人员事先提供，而是在唤醒仪式上，由银芯中的精神能量熔炼而成。因而唤醒仪式上，除去必要的银芯及银钥匙外，还需准备大量的材料，以供唤醒体进行躯体合成。常见材料详见第3号附录。\n另，弥萨格大学设有专业的部门及研究人员，负责维护唤醒体的躯体损伤。"
  },
  CollectionHall_49762_Title = {
    Text = "唤醒体构成"
  },
  CollectionHall_49763_Desc = {
    Text = "<Title:日常>\n唤醒体在弥萨格大学内享有与教职工同等的权益。他们拥有使用校内设施，获取调查报酬的权利。\n在搭档调查员没有外勤任务时，唤醒体们可以在校园范围内自由活动。多数唤醒体会遵循自己生前的爱好与习惯，找到自己想做的事；也有部分唤醒体会选择走进课堂，了解这个时代，或者与调查员们交朋友。\n除了少部分特殊情况外，唤醒体原则上不需要进食和睡眠。但如果唤醒体愿意做这些事，也不会造成任何影响。\n\n<Title:作战>\n为了平衡作战指挥与维持链接的精力消耗，弥萨格大学研发了一种名为「灵知转印器」的特殊仪器。\n内置在外勤手提箱中的「灵知转印器」，可以将唤醒体的能力转印成卡片的形态，以此实现对唤醒体的指挥。"
  },
  CollectionHall_49763_Title = {
    Text = "唤醒体行为"
  },
  CollectionHall_49764_Desc = {
    Text = "<Title:创办日期>\nA.F.306\n\n<Title:创始人>\n赫伯特·罗森塔尔\n\n<Title:概述>\n激进的民间科研组织。\n妄图通过将人类与融蚀产物结合的方式实现进化，以求在灾厄世界中生存。\n由20余名激进人员组成，他们将无辜者视作实验素材，手段极其残忍。\n创办者是弥萨格大学臭名昭著的叛徒赫伯特·罗森塔尔，与提灯教会存在密切合作关系。\n组织标志是一把用于雕刻的平头凿刀，据说是为了向那位爱上雕像的塞浦路斯国王致敬。"
  },
  CollectionHall_49764_LockTip = {
    Text = "通关调查行动第3章「谨防恶犬」解锁"
  },
  CollectionHall_49764_Title = {
    Text = "雕塑家协会"
  },
  CollectionHall_49765_Desc = {
    Text = "<Title:概述>\n由弥萨格大学通过特殊流程筛选培养的专业人员，拥有强大的精神力，可以承受链接唤醒体带来的消耗，对其下达精神指令。\n他们直面融蚀，为人类的存续而战，却不为人知。死于融蚀的调查员，甚至连名字和档案都无法完整留下。\n他们的名字无人知晓，但愿他们的功绩能够与世长存。\n\n<Title:筛选>\n基于《调查员精神构成与其潜力》的理论基础，弥萨格通过观察个体与银钥匙之间的精神共鸣强度，筛选出拥有强大精神力的个体，进行培养。\n\n<Title:培养>\n通过筛选后，调查员要先进入预科班进行为期一年的培训。\n培训内容包括融蚀基础理论、银芯科技入门、唤醒体理论等基础课程，以及基础体能、唤醒体链接、唤醒体指挥等作战相关训练。\n\n<Title:钥冢仪式>\n经过一年的学习并通过考核后，调查员将统一参加于校庆日举办的钥冢仪式。\n仪式上，调查员们宣读誓言，并将自己的姓名刻在墓碑上。\n随后，每位调查员将被授予拥有独一无二编号的银钥匙，其开头字母统一为「I」。\n自此，他们将与过去作为普通人的自己道别。在他们死后，这个承载了他们名字的石碑，将成为他们存在过的证明。\n\n<Title:卸任>\n若调查员出于种种原因无法执行外勤任务，弥萨格会予以尊重，将其转入后勤部、信息支援部等更安全的部门工作。\n即便如此，那些卸任的调查员们也常常饱受身心的折磨。\n对这些瞥见过世界真实一角的人而言，安度余生是一个奢侈的幻想。"
  },
  CollectionHall_49765_Title = {Text = "调查员"},
  CollectionHall_49766_Desc = {
    Text = "<Title:概述>\n调查员中的特殊个体，拥有比普通调查员更为强大的精神。\n拥有比调查员更高的权限，从而接触到更深的隐秘。他们所接手的，也往往是最复杂、最艰难的任务。\n在这场与融蚀的漫长战争中，他们站在所有人类身前。\n\n<Title:筛选>\n通常是弥萨格在进行调查员筛查时选出的特殊个体。\n在发现对银钥匙反应格外强烈的个体时，筛选人员会根据《守密人精神构成及其潜力》中的描述和条目，辅以一定时间的观察，最后评判该个体是否能被培养为守密人。\n\n<Title:培养>\n除开基础的理论课程与作战训练，守密人还将进行额外的精神力训练。\n他们会比其他调查员更早地接触唤醒体、执行外勤任务，以磨练自身能力。\n\n<Title:钥冢仪式>\n通过考核后，守密人会与普通调查员一同参加钥冢仪式，获取属于自己的银钥匙。\n与调查员不同，守密人的银钥匙编号开头为「K」。\n自此，银钥匙将成为守密人身份的标识，也将为后续的外勤任务带来强大助力。\n\n<Title:守密人与唤醒体>\n守密人可以借助唤醒体的力量与融蚀对抗。因此，指挥唤醒体作战的能力尤为重要。\n他们在预科阶段就会接受严格的指挥作战训练，且在钥冢仪式后，需与所搭档的唤醒体进行一次有教师监督的外勤任务，以确保具备日后独立执行外勤任务的能力。\n\n<Title:卸任>\n若守密人出于种种原因无法执行外勤任务，弥萨格会予以尊重，将其转入后勤部、信息支援部等更安全的部门工作。\n守密人可通过交还钥匙、封存档案、签署保密协议的方式卸任，但迄今为止很少有人这么做。"
  },
  CollectionHall_49766_Title = {Text = "守密人"},
  CollectionHall_49767_Desc = {
    Text = "<Title:唤醒体链接>\n唤醒体在塑造过程中会受到未知污染，他们极易陷入疯狂，故而需要调查员进行精神链接以稳定心神。而对绝大多数调查员来说，与唤醒体的链接需要借助银钥匙的力量。\n银钥匙可以增强持有者的精神，使其得以长时间链接唤醒体，指挥唤醒体进行作战，并为持有者提供精神力辅助。此外，持有者亦可通过银钥匙给予唤醒体一定的帮助。\n理论上，持有者自身的精神强度越大，可以链接的唤醒体越多。但迄今为止，能够承受与复数唤醒体链接带来的精神负担的人，仅有一位。\n\n<Title:唤醒仪式>\n使用银钥匙主持的唤醒仪式，是每位调查员的必修课。\n唤醒仪式中，银钥匙能够放大使用者与目标银芯的感知，帮助加强银芯的塑造，使其最终成为具有特殊能力的唤醒体。\n\n<Title:精神追溯与定位>\n在与唤醒体失散时，持有者可以使用银钥匙，通过「精神追溯」大致定位符合唤醒体特征的精神。\n但这并不意味着寻到的每个精神都是你的朋友，所以在进行「精神追溯」时，请一定保持冷静。\n\n<Title:裂隙关闭>\n持有者可以使用银钥匙将融蚀裂隙关闭。详见融蚀裂隙-应对方式。"
  },
  CollectionHall_49767_Title = {
    Text = "银钥匙应用"
  },
  CollectionHall_49768_Desc = {
    Text = "<Title:概述>\n每个守密人都拥有不尽相同的特殊能力。\n据弥萨格档案记载，目前已知的守密人能力有记忆读取、情绪共享、心理感知等。\n\n<Title:初代守密人>\n初代守密人即为阿利斯泰尔·欧文斯。\n对大多数人而言，他是仅存在于历史夹缝中的一抹残影，只有极少数人知道他至今依然坚守在弥萨格的地底。\n无法直立行走，据说是为了弥萨格而做出的「必要牺牲」。\n弥萨格最具性价比的工具——他的胃早已被完全切除，无需吃喝，节省了一大笔伙食费。\n\n<Title:新任守密人>\n新任守密人拥有的能力无疑最为独特。\nTA能通过某一物件、情绪或回忆触发感悟，刺激银钥匙迸发出新的力量——这几乎颠覆了专业学者与史学家的认知。\n所有人都知道，这位守密人注定会掀起新一轮的风暴。\n问题是，这场风暴会将他们带向何方？"
  },
  CollectionHall_49768_Title = {
    Text = "特殊守密人及能力"
  },
  CollectionHall_49964_Title = {
    Text = "01 东区秘事"
  },
  CollectionHall_49965_Title = {
    Text = "06 倒错的群星"
  },
  CollectionHall_49967_Title = {
    Text = "04 于无声处"
  },
  CollectionHall_49991_Title = {
    Text = "03 谨防恶犬"
  },
  CollectionHall_50001_Title = {
    Text = "05 风暴之眼"
  },
  CollectionHall_50159_Title = {
    Text = "码头与货轮"
  },
  CollectionHall_50161_Title = {
    Text = "艾尔沃斯"
  },
  CollectionHall_50178_Title = {
    Text = "勒姆瓦希"
  },
  CollectionHall_50182_Title = {Text = "野外"},
  CollectionHall_50190_Title = {Text = "济贫院"},
  CollectionHall_50202_Title = {Text = "幻境"},
  CollectionHall_50211_Title = {
    Text = "伦蒂尼恩室内"
  },
  CollectionHall_50265_Title = {Text = "蜡像馆"},
  CollectionHall_50271_Title = {
    Text = "拉伊小镇"
  },
  CollectionHall_51019_Desc = {
    Text = "<Title:创办日期>\n洪积前\n\n<Title:创始人>\n不详\n\n<Title:概述>\n自亚述帝国分化而来的游牧民族。\n深藏于勒姆瓦希沙漠终年剧烈的风暴之中，生活极为原始，鲜少与外人通信往来。亚兰人信仰「丰穰母树」，依赖丰穰母树和圣河之水的异常繁衍能力维系种群规模。\n「勒姆瓦希行动」后，亚兰族销声匿迹，再无音讯。"
  },
  CollectionHall_51019_LockTip = {
    Text = "通关调查行动第7章「欲河」解锁"
  },
  CollectionHall_51019_Title = {Text = "亚兰族"},
  CollectionHall_51038_Title = {Text = "07 欲河"},
  CollectionHall_51373_Title = {
    Text = "莫测之物"
  },
  CollectionHall_51374_Desc = {
    Text = "<Title:简介>\n弥萨格大学教授，社会活动家，贵族。\n曾是挥金如土的花花公子，犯下过一些无伤大雅的罪行，在黑白两道都享有名声。\n后来家族被邪教徒灭门，成为唯一的幸存者。那以后发生的事，只有本人能说清楚了。\n虽是拉蒙娜的养父，却对拉蒙娜的来历三缄其口。\n年轻时门门课程都不及格，却摇身一变成为弥萨格的教授。\n为人风流不羁，却从未与任何女性或者男性传出绯闻。\n总之是个充满矛盾的家伙。"
  },
  CollectionHall_51374_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_51374_Title = {
    Text = "德克斯特"
  },
  CollectionHall_51375_Desc = {
    Text = "<Title:简介>\n德克斯特的养女，主角最信赖的调查伙伴。\n从小混迹在学院各个学系的教室中，对融蚀现象、唤醒体等知识有着相当程度的了解。\n\n年纪尚小时，拉蒙娜也曾对「亲生父母」有过向往，但在德克斯特及老师们的照料和关爱下，她早已把学院当做真正的家。\n\n冷静、理性以及恰到好处的良善，使她身上没有任何「怪异」之处——在弥萨格这群怪人的衬托下，她的「正常」反而脱颖而出。\n虽然总是冷着一张脸，但熟悉她的人都知道，这只是身为「天才」的乏累罢了。"
  },
  CollectionHall_51375_LockTip = {
    Text = "唤醒「拉蒙娜」后解锁"
  },
  CollectionHall_51375_Title = {Text = "拉蒙娜"},
  CollectionHall_51386_LockTip = {
    Text = "可于调查行动2-10中解锁"
  },
  CollectionHall_51386_Title = {
    Text = "灵知风暴"
  },
  CollectionHall_51387_LockTip = {
    Text = "可于调查行动2-1中解锁"
  },
  CollectionHall_51387_Title = {
    Text = "未完的蜡像"
  },
  CollectionHall_51388_LockTip = {
    Text = "可于调查行动5-3中解锁"
  },
  CollectionHall_51388_Title = {Text = "未知"},
  CollectionHall_51389_LockTip = {
    Text = "可于调查行动1-7中解锁"
  },
  CollectionHall_51389_Title = {Text = "探照灯"},
  CollectionHall_51390_LockTip = {
    Text = "可于调查行动2-6中解锁"
  },
  CollectionHall_51390_Title = {Text = "隧道"},
  CollectionHall_51391_LockTip = {
    Text = "可于调查行动1-7中解锁"
  },
  CollectionHall_51391_Title = {Text = "幻象"},
  CollectionHall_51392_LockTip = {
    Text = "可于探索地图中获得银芯解锁"
  },
  CollectionHall_51392_Title = {Text = "析出点"},
  CollectionHall_51393_LockTip = {
    Text = "可于调查行动1-11中解锁"
  },
  CollectionHall_51393_Title = {
    Text = "单行密道"
  },
  CollectionHall_51394_LockTip = {
    Text = "可于调查行动4-1中解锁"
  },
  CollectionHall_51394_Title = {
    Text = "蜂蜜甜酒"
  },
  CollectionHall_51395_LockTip = {
    Text = "可于调查行动4-10中解锁"
  },
  CollectionHall_51395_Title = {
    Text = "不可获知之影"
  },
  CollectionHall_51396_LockTip = {
    Text = "可于调查行动7-18中解锁"
  },
  CollectionHall_51396_Title = {
    Text = "无法见证之物"
  },
  CollectionHall_51397_LockTip = {
    Text = "可于调查行动1-10中解锁"
  },
  CollectionHall_51397_Title = {
    Text = "无处可逃"
  },
  CollectionHall_51398_LockTip = {
    Text = "可于调查行动1-11中解锁"
  },
  CollectionHall_51398_Title = {
    Text = "尖锐的刺激"
  },
  CollectionHall_51399_LockTip = {
    Text = "可于调查行动7-1中解锁"
  },
  CollectionHall_51399_Title = {
    Text = "孕育之母"
  },
  CollectionHall_51400_LockTip = {
    Text = "可于调查行动1-11中解锁"
  },
  CollectionHall_51400_Title = {
    Text = "罗格斯定则"
  },
  CollectionHall_51401_LockTip = {
    Text = "可于调查行动1-10中解锁"
  },
  CollectionHall_51401_Title = {
    Text = "糟糕的品味"
  },
  CollectionHall_51402_LockTip = {
    Text = "可于调查行动1-13中解锁"
  },
  CollectionHall_51402_Title = {
    Text = "感恩赞美诗"
  },
  CollectionHall_51403_LockTip = {
    Text = "可于调查行动1-9中解锁"
  },
  CollectionHall_51403_Title = {Text = "往世"},
  CollectionHall_51404_LockTip = {
    Text = "可于调查行动6-1中解锁"
  },
  CollectionHall_51404_Title = {
    Text = "纯白之帆"
  },
  CollectionHall_51405_LockTip = {
    Text = "可于调查行动5-5中解锁"
  },
  CollectionHall_51405_Title = {Text = "吞噬"},
  CollectionHall_51406_LockTip = {
    Text = "可于调查行动1-8中解锁"
  },
  CollectionHall_51406_Title = {Text = "窥探"},
  CollectionHall_51407_LockTip = {
    Text = "可于调查行动4-2中解锁"
  },
  CollectionHall_51407_Title = {
    Text = "喷薄的表达欲"
  },
  CollectionHall_51408_LockTip = {
    Text = "可于调查行动1-9中解锁"
  },
  CollectionHall_51408_Title = {
    Text = "无用信息"
  },
  CollectionHall_51409_LockTip = {
    Text = "可于调查行动8-3中解锁"
  },
  CollectionHall_51409_Title = {
    Text = "入学仪式"
  },
  CollectionHall_51410_LockTip = {
    Text = "可于调查行动7-1中解锁"
  },
  CollectionHall_51410_Title = {
    Text = "血污之池"
  },
  CollectionHall_51411_LockTip = {
    Text = "可于调查行动5-1中解锁"
  },
  CollectionHall_51411_Title = {
    Text = "代行者的承诺"
  },
  CollectionHall_51412_LockTip = {
    Text = "可于活动「燃烧的群宴」中解锁"
  },
  CollectionHall_51412_Title = {
    Text = "代行密令"
  },
  CollectionHall_51413_LockTip = {
    Text = "可于特遣纪录「故事的魔法」的「安迪·约翰逊之力」中解锁"
  },
  CollectionHall_51413_Title = {
    Text = "制片人的迷思"
  },
  CollectionHall_51414_LockTip = {
    Text = "可于调查行动8-4中解锁"
  },
  CollectionHall_51414_Title = {
    Text = "魔鬼指挥家"
  },
  CollectionHall_51415_LockTip = {
    Text = "可于调查行动7-15中解锁"
  },
  CollectionHall_51415_Title = {
    Text = "好运侦探"
  },
  CollectionHall_51416_LockTip = {
    Text = "可于调查行动7-1中解锁"
  },
  CollectionHall_51416_Title = {
    Text = "鞠水之人"
  },
  CollectionHall_51417_LockTip = {
    Text = "可于调查行动6-2中解锁"
  },
  CollectionHall_51417_Title = {Text = "闪烁"},
  CollectionHall_51418_LockTip = {
    Text = "可于调查行动5-1中解锁"
  },
  CollectionHall_51418_Title = {
    Text = "一路向北"
  },
  CollectionHall_51419_LockTip = {
    Text = "可于调查行动4-3中解锁"
  },
  CollectionHall_51419_Title = {
    Text = "巨兽足印"
  },
  CollectionHall_51420_LockTip = {
    Text = "可于调查行动3-1中解锁"
  },
  CollectionHall_51420_Title = {
    Text = "怪异旅伴"
  },
  CollectionHall_51421_LockTip = {
    Text = "可于调查行动2-1中解锁"
  },
  CollectionHall_51421_Title = {Text = "终幕礼"},
  CollectionHall_51422_LockTip = {
    Text = "可于调查行动1-13中解锁"
  },
  CollectionHall_51422_Title = {
    Text = "自我的边缘"
  },
  CollectionHall_51423_LockTip = {
    Text = "可于调查行动星辰篇4-11中解锁"
  },
  CollectionHall_51423_Title = {
    Text = "自星世界"
  },
  CollectionHall_51424_LockTip = {
    Text = "可于调查行动5-11中解锁"
  },
  CollectionHall_51424_Title = {
    Text = "自由的意识"
  },
  CollectionHall_51425_LockTip = {
    Text = "可于调查行动1-10中解锁"
  },
  CollectionHall_51425_Title = {
    Text = "苦难消解"
  },
  CollectionHall_51426_LockTip = {
    Text = "可于调查行动3-9中解锁"
  },
  CollectionHall_51426_Title = {
    Text = "尖啸的不甘"
  },
  CollectionHall_51427_LockTip = {
    Text = "可于调查行动1-5中解锁"
  },
  CollectionHall_51427_Title = {
    Text = "可爱的角落"
  },
  CollectionHall_51428_LockTip = {
    Text = "可于调查行动3-2中解锁"
  },
  CollectionHall_51428_Title = {Text = "鼓动"},
  CollectionHall_51429_LockTip = {
    Text = "可于调查行动6-2中解锁"
  },
  CollectionHall_51429_Title = {Text = "猫之城"},
  CollectionHall_51430_LockTip = {
    Text = "可于调查行动3-5中解锁"
  },
  CollectionHall_51430_Title = {
    Text = "群鸦之歌"
  },
  CollectionHall_51431_LockTip = {
    Text = "可于调查行动1-13中解锁"
  },
  CollectionHall_51431_Title = {
    Text = "巨物之眼"
  },
  CollectionHall_51432_LockTip = {
    Text = "可于特遣纪录「血的颜色」的「我们的过错」中解锁"
  },
  CollectionHall_51432_Title = {
    Text = "主教的「赐福」"
  },
  CollectionHall_51433_LockTip = {
    Text = "可于特遣纪录「宁静的裂殖」的「满贯定约」中解锁"
  },
  CollectionHall_51433_Title = {
    Text = "「催眠蛇」"
  },
  CollectionHall_51434_LockTip = {
    Text = "可于特遣纪录「血的颜色」的「我们的过错」中解锁"
  },
  CollectionHall_51434_Title = {
    Text = "内心的黑暗"
  },
  CollectionHall_51435_LockTip = {
    Text = "可于特遣纪录「血的颜色」的「我们的过错」中解锁"
  },
  CollectionHall_51435_Title = {
    Text = "愧疚与宽恕"
  },
  CollectionHall_51436_LockTip = {
    Text = "可于调查行动1-9中解锁"
  },
  CollectionHall_51436_Title = {
    Text = "往日之影"
  },
  CollectionHall_51437_LockTip = {
    Text = "可于调查行动1-8中解锁"
  },
  CollectionHall_51437_Title = {Text = "公义"},
  CollectionHall_51438_LockTip = {
    Text = "可于调查行动2-8中解锁"
  },
  CollectionHall_51438_Title = {
    Text = "「囚徒」"
  },
  CollectionHall_51439_LockTip = {
    Text = "可于调查行动2-8中解锁"
  },
  CollectionHall_51439_Title = {
    Text = "「洞穴深处」"
  },
  CollectionHall_51440_LockTip = {
    Text = "可于调查行动星辰篇3-1中解锁"
  },
  CollectionHall_51440_Title = {
    Text = "宴前仪礼"
  },
  CollectionHall_51441_LockTip = {
    Text = "可于调查行动1-2中解锁"
  },
  CollectionHall_51441_Title = {
    Text = "心理评估"
  },
  CollectionHall_51442_LockTip = {
    Text = "可于特遣纪录「玫瑰的栖居」的「诗篇1843」中解锁"
  },
  CollectionHall_51442_Title = {
    Text = "缪斯的眷顾"
  },
  CollectionHall_51443_LockTip = {
    Text = "可于特遣纪录「玫瑰的栖居」的「诗篇1843」中解锁"
  },
  CollectionHall_51443_Title = {
    Text = "春天的赠礼"
  },
  CollectionHall_51444_LockTip = {
    Text = "可于调查行动星辰篇1-2中解锁"
  },
  CollectionHall_51444_Title = {
    Text = "尚未流失的意识"
  },
  CollectionHall_51445_LockTip = {
    Text = "可于调查行动星辰篇2-2中解锁"
  },
  CollectionHall_51445_Title = {
    Text = "生命的蜕变"
  },
  CollectionHall_51446_LockTip = {
    Text = "可于活动「沉渊之祀」中解锁"
  },
  CollectionHall_51446_Title = {
    Text = "大地的战栗"
  },
  CollectionHall_51447_LockTip = {
    Text = "可于活动「沉渊之祀」中解锁"
  },
  CollectionHall_51447_Title = {
    Text = "海洋的轰鸣"
  },
  CollectionHall_51448_LockTip = {
    Text = "可于活动「沉渊之祀」中解锁"
  },
  CollectionHall_51448_Title = {
    Text = "瘟疫的侵袭"
  },
  CollectionHall_51449_LockTip = {
    Text = "可于活动「沉渊之祀」中解锁"
  },
  CollectionHall_51449_Title = {
    Text = "迎接吧，神国"
  },
  CollectionHall_51450_LockTip = {
    Text = "可于调查行动1-2中解锁"
  },
  CollectionHall_51450_Title = {
    Text = "善意的礼物"
  },
  CollectionHall_51451_LockTip = {
    Text = "可于调查行动3-13中解锁"
  },
  CollectionHall_51451_Title = {
    Text = "蝴蝶效应"
  },
  CollectionHall_51452_LockTip = {
    Text = "可于调查行动星辰篇1-5中解锁"
  },
  CollectionHall_51452_Title = {
    Text = "褪色遗骨"
  },
  CollectionHall_51453_LockTip = {
    Text = "可于调查行动3-1中解锁"
  },
  CollectionHall_51453_Title = {
    Text = "古怪脓疱"
  },
  CollectionHall_51454_LockTip = {
    Text = "可于调查行动1-7中解锁"
  },
  CollectionHall_51454_Title = {
    Text = "银色呼唤"
  },
  CollectionHall_51455_Desc = {
    Text = "神圣的一部分。\n纵然与躯干分离，其足迹也已遍布四海。"
  },
  CollectionHall_51455_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51455_Title = {
    Text = "<RedQuality:行道之骸>"
  },
  CollectionHall_51457_Desc = {
    Text = "逻辑就像鸡尾酒，摄入太多就失去它的益处了。"
  },
  CollectionHall_51457_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51457_Title = {
    Text = "<OrangeQuality:纯真玛丽>"
  },
  CollectionHall_51458_Desc = {
    Text = "全知全能。"
  },
  CollectionHall_51458_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51458_Title = {
    Text = "<OrangeQuality:万象灵知秘仪>"
  },
  CollectionHall_51459_Desc = {
    Text = "精致、昂贵，只是不那么实用。"
  },
  CollectionHall_51459_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51459_Title = {
    Text = "<WhiteQuality:鸽羽扇>"
  },
  CollectionHall_51460_Desc = {
    Text = "「登船后，请首先找到离舱室最近的安全出口。」"
  },
  CollectionHall_51460_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51460_Title = {
    Text = "<WhiteQuality:逃生平面图>"
  },
  CollectionHall_51461_Desc = {
    Text = "记忆凝固在往昔的时间，深埋于黑色之底。"
  },
  CollectionHall_51461_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51461_Title = {
    Text = "<WhiteQuality:怀表镜>"
  },
  CollectionHall_51462_Desc = {
    Text = "期待或恐惧它发出清脆铃声的瞬间。"
  },
  CollectionHall_51462_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51462_Title = {
    Text = "<WhiteQuality:通讯设备>"
  },
  CollectionHall_51463_Desc = {
    Text = "「别害怕，这只是魔术。」"
  },
  CollectionHall_51463_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51463_Title = {
    Text = "<WhiteQuality:魔术手套>"
  },
  CollectionHall_51464_Desc = {
    Text = "有人说这是魔鬼的血，但是，嘿，先试试看吧！"
  },
  CollectionHall_51464_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51464_Title = {
    Text = "<WhiteQuality:甜蜜墨水>"
  },
  CollectionHall_51465_Desc = {
    Text = "游走于繁星之间。"
  },
  CollectionHall_51465_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51465_Title = {
    Text = "<OrangeQuality:群星之酒>"
  },
  CollectionHall_51466_Desc = {
    Text = "「人类何其愚蠢，只因陈腐，便会盲信。」"
  },
  CollectionHall_51466_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51466_Title = {
    Text = "<OrangeQuality:先贤断章>"
  },
  CollectionHall_51467_Desc = {
    Text = "叮铃铃，叮铃铃。梦境的声音。"
  },
  CollectionHall_51467_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51467_Title = {
    Text = "<RedQuality:蛊惑风铃>"
  },
  CollectionHall_51468_Desc = {
    Text = "印刻了弥萨格大学校徽的皮质钱包。\n里面现在空空如也，什么也没有。"
  },
  CollectionHall_51468_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51468_Title = {
    Text = "<WhiteQuality:崭新的钱包>"
  },
  CollectionHall_51469_Desc = {
    Text = "弥萨格大学分发给调查员的徽章。它不仅象征了佩戴者的身份，还是一个可以进行远程通讯的工具。"
  },
  CollectionHall_51469_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51469_Title = {
    Text = "<WhiteQuality:弥萨格徽章>"
  },
  CollectionHall_51470_Desc = {
    Text = "能说会道的不止商人，亦有虔信者。"
  },
  CollectionHall_51470_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51470_Title = {
    Text = "<WhiteQuality:伶牙俐齿>"
  },
  CollectionHall_51471_Desc = {
    Text = "对兔子来说，可就不那么幸运了。"
  },
  CollectionHall_51471_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51471_Title = {
    Text = "<WhiteQuality:幸运兔脚>"
  },
  CollectionHall_51472_Desc = {
    Text = "回应你的愿望。"
  },
  CollectionHall_51472_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51472_Title = {
    Text = "<OrangeQuality:先知的许愿灯>"
  },
  CollectionHall_51473_Desc = {
    Text = "命运的走势。"
  },
  CollectionHall_51473_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51473_Title = {
    Text = "<OrangeQuality:阿尔卡纳记录>"
  },
  CollectionHall_51474_Desc = {
    Text = "此拓印千年不朽。"
  },
  CollectionHall_51474_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51474_Title = {
    Text = "<RedQuality:翠玉拓印>"
  },
  CollectionHall_51476_Desc = {
    Text = "嘘，这是只属于你我的秘密交易。"
  },
  CollectionHall_51476_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51476_Title = {
    Text = "<WhiteQuality:档案夹>"
  },
  CollectionHall_51477_Desc = {
    Text = "至今，他也被谁深深地喜爱着。"
  },
  CollectionHall_51477_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51477_Title = {
    Text = "<WhiteQuality:蝴蝶标本>"
  },
  CollectionHall_51478_Desc = {
    Text = "它理应为相爱之人带来祝福。"
  },
  CollectionHall_51478_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51478_Title = {
    Text = "<WhiteQuality:节日祝福>"
  },
  CollectionHall_51479_Desc = {
    Text = "效果没有那么一劳永逸。"
  },
  CollectionHall_51479_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51479_Title = {
    Text = "<WhiteQuality:镇痛药片>"
  },
  CollectionHall_51480_Desc = {
    Text = "陈列在某个收藏家私人展厅内的遗骨。\n收藏家醉心于那美丽的荧光，日夜欣赏，最终枯死，最终成为了它的同类。"
  },
  CollectionHall_51480_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51480_Title = {
    Text = "<WhiteQuality:镭射颌骨>"
  },
  CollectionHall_51481_Desc = {
    Text = "它本应装载精致，而不是死亡。"
  },
  CollectionHall_51481_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51481_Title = {
    Text = "<WhiteQuality:淑女小包>"
  },
  CollectionHall_51482_Desc = {
    Text = "万不得已之下，也还是别吃这个。"
  },
  CollectionHall_51482_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51482_Title = {
    Text = "<WhiteQuality:应急食品>"
  },
  CollectionHall_51483_Desc = {
    Text = "摇曳的光，微弱的希望。"
  },
  CollectionHall_51483_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51483_Title = {
    Text = "<WhiteQuality:须臾的火>"
  },
  CollectionHall_51484_Desc = {
    Text = "曾有人透过它，找到了真相。"
  },
  CollectionHall_51484_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51484_Title = {
    Text = "<WhiteQuality:视力矫正器>"
  },
  CollectionHall_51485_Desc = {
    Text = "下面请听题：10个僧侣分6只面包，请问他们各得多少？"
  },
  CollectionHall_51485_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51485_Title = {
    Text = "<WhiteQuality:莱茵德纸草书>"
  },
  CollectionHall_51486_Desc = {
    Text = "他的声音消失在了风中。"
  },
  CollectionHall_51486_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51486_Title = {
    Text = "<WhiteQuality:失声唱机>"
  },
  CollectionHall_51487_Desc = {
    Text = "笑个痛快！"
  },
  CollectionHall_51487_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51487_Title = {
    Text = "<OrangeQuality:偶然谬误>"
  },
  CollectionHall_51488_Desc = {
    Text = "将须臾的美保存至永远。"
  },
  CollectionHall_51488_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51488_Title = {
    Text = "<WhiteQuality:美丽瞬间>"
  },
  CollectionHall_51489_Desc = {
    Text = "难以辨识的物种。"
  },
  CollectionHall_51489_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51489_Title = {
    Text = "<RedQuality:古怪钩爪>"
  },
  CollectionHall_51490_Desc = {
    Text = "曾经镶嵌在沉重画框中的艺术品，从展出的那天起便缺了一块。"
  },
  CollectionHall_51490_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51490_Title = {
    Text = "<OrangeQuality:老旧拼图>"
  },
  CollectionHall_51491_Desc = {
    Text = "从乡村骑向都市，从灾难走向复兴。"
  },
  CollectionHall_51491_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51491_Title = {
    Text = "<WhiteQuality:新式轮轴>"
  },
  CollectionHall_51492_Desc = {
    Text = "余火未熄。"
  },
  CollectionHall_51492_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51492_Title = {
    Text = "<RedQuality:黑星燃烧之烬>"
  },
  CollectionHall_51493_Desc = {
    Text = "「快、快把它给我！」"
  },
  CollectionHall_51493_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51493_Title = {
    Text = "<WhiteQuality:止血钳>"
  },
  CollectionHall_51494_Desc = {
    Text = "在它面前没有秘密。"
  },
  CollectionHall_51494_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51494_Title = {
    Text = "<WhiteQuality:白鸦喙>"
  },
  CollectionHall_51495_Desc = {
    Text = "不同于无常的命运，群星自有运行法则。"
  },
  CollectionHall_51495_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51495_Title = {
    Text = "<RedQuality:阿方索之器>"
  },
  CollectionHall_51496_Desc = {
    Text = "「哎呀，怀表停了。」"
  },
  CollectionHall_51496_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51496_Title = {
    Text = "<WhiteQuality:超弦怀表>"
  },
  CollectionHall_51497_Desc = {
    Text = "「光由七种色彩构成。」"
  },
  CollectionHall_51497_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51497_Title = {
    Text = "<WhiteQuality:三棱镜>"
  },
  CollectionHall_51498_Desc = {
    Text = "一份可计量的时间。"
  },
  CollectionHall_51498_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51498_Title = {
    Text = "<WhiteQuality:辉光沙漏>"
  },
  CollectionHall_51499_Desc = {
    Text = "一块同时存在于钟表店与昆虫博物馆的怀表。\n洪积元年开始后，被纳入大学馆藏。"
  },
  CollectionHall_51499_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51499_Title = {
    Text = "<WhiteQuality:时间之虫>"
  },
  CollectionHall_51500_Desc = {
    Text = "缠绕脖颈。"
  },
  CollectionHall_51500_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51500_Title = {
    Text = "<RedQuality:蠕动的脐带>"
  },
  CollectionHall_51501_Desc = {
    Text = "蜕变之日即是你的死期。"
  },
  CollectionHall_51501_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51501_Title = {
    Text = "<OrangeQuality:金色梦乡>"
  },
  CollectionHall_51502_Desc = {
    Text = "杀人越货挠痒痒的绝佳工具。"
  },
  CollectionHall_51502_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51502_Title = {
    Text = "<OrangeQuality:妙手空空>"
  },
  CollectionHall_51503_Desc = {
    Text = "谁的面容，充满惊恐，被凝固在时光之中。"
  },
  CollectionHall_51503_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51503_Title = {
    Text = "<RedQuality:残缺面孔>"
  },
  CollectionHall_51504_Desc = {
    Text = "一只不再纯洁的眼球。"
  },
  CollectionHall_51504_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51504_Title = {
    Text = "<WhiteQuality:精制义眼>"
  },
  CollectionHall_51505_Desc = {
    Text = "曾被进献之物。"
  },
  CollectionHall_51505_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51505_Title = {
    Text = "<OrangeQuality:过往的贡物>"
  },
  CollectionHall_51506_Desc = {
    Text = "德克斯特的宅邸中有许多藏品，在被摔坏前，小八音盒曾是德克斯特小小姐最喜欢的玩具。\n时光荏苒，当德克斯特小姐再次找到她时，她齿轮松弛、音乐变调，却仍未停止旋转。"
  },
  CollectionHall_51506_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51506_Title = {
    Text = "<OrangeQuality:小八音盒>"
  },
  CollectionHall_51507_Desc = {
    Text = "您最贴心的马桶伴侣。"
  },
  CollectionHall_51507_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51507_Title = {
    Text = "<WhiteQuality:普特尼晨报>"
  },
  CollectionHall_51508_Desc = {
    Text = "除开美人鱼，哨声还能吹来飓风、臭皮靴和一百天没洗澡的老水手。"
  },
  CollectionHall_51508_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51508_Title = {
    Text = "<WhiteQuality:水手哨>"
  },
  CollectionHall_51509_Desc = {
    Text = "迷失方向的时候打开它吧，但要小心——它的日冕不可见到日光。"
  },
  CollectionHall_51509_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51509_Title = {
    Text = "<WhiteQuality:黄金向导>"
  },
  CollectionHall_51510_Desc = {
    Text = "著名小提琴家埃里克·艾克施坦因的提琴。\n如今，它已不可再奏响。"
  },
  CollectionHall_51510_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51510_Title = {
    Text = "<WhiteQuality:寂静序曲>"
  },
  CollectionHall_51511_Desc = {
    Text = "抚摸时听见了深海的呼唤。"
  },
  CollectionHall_51511_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51511_Title = {
    Text = "<RedQuality:诅咒石碑>"
  },
  CollectionHall_51512_Desc = {
    Text = "专为折磨你的耳朵而生。"
  },
  CollectionHall_51512_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51512_Title = {
    Text = "<OrangeQuality:群氓之歌>"
  },
  CollectionHall_51513_Desc = {
    Text = "从未苦弱，已然飞升。"
  },
  CollectionHall_51513_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51513_Title = {
    Text = "<OrangeQuality:「血肉指轮」>"
  },
  CollectionHall_51514_Desc = {
    Text = "深渊溟海中的沉睡者，开始向世界展示被遗忘的权威。"
  },
  CollectionHall_51514_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51514_Title = {
    Text = "<OrangeQuality:「深海指轮」>"
  },
  CollectionHall_51515_Desc = {
    Text = "无尽维度叠加而至，此刻「我」已无限完整。"
  },
  CollectionHall_51515_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51515_Title = {
    Text = "<OrangeQuality:「超维指轮」>"
  },
  CollectionHall_51516_Desc = {
    Text = "混沌无形，混沌无质，混沌已融于万物之中。"
  },
  CollectionHall_51516_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51516_Title = {
    Text = "<OrangeQuality:「混沌指轮」>"
  },
  CollectionHall_51517_Desc = {
    Text = "一、二、三、四、五。"
  },
  CollectionHall_51517_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51517_Title = {
    Text = "<WhiteQuality:染血鹅卵石>"
  },
  CollectionHall_51518_Desc = {
    Text = "快回家吧，我的老水手。"
  },
  CollectionHall_51518_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51518_Title = {
    Text = "<WhiteQuality:旧船锚>"
  },
  CollectionHall_51519_Desc = {
    Text = "两颗相依相偎的「心脏」。"
  },
  CollectionHall_51519_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51519_Title = {
    Text = "<WhiteQuality:异形之心>"
  },
  CollectionHall_51520_Desc = {
    Text = "想要一个深深的吻吗？要你命的那种。"
  },
  CollectionHall_51520_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51520_Title = {
    Text = "<RedQuality:七鳃鳗之吻>"
  },
  CollectionHall_51521_Desc = {
    Text = "祂说，不要惧怕。"
  },
  CollectionHall_51521_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51521_Title = {
    Text = "<OrangeQuality:祂的神谕>"
  },
  CollectionHall_51522_Desc = {
    Text = "不被许可的虔诚。"
  },
  CollectionHall_51522_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51522_Title = {
    Text = "<OrangeQuality:祭司权杖>"
  },
  CollectionHall_51523_Desc = {
    Text = "命运的终焉。"
  },
  CollectionHall_51523_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51523_Title = {
    Text = "<OrangeQuality:阿尔卡纳遗物>"
  },
  CollectionHall_51524_Desc = {
    Text = "古老的部落坚信，在死者的头颅上篆刻特殊符号，能够将他的灵魂留下，获得永远的陪伴。"
  },
  CollectionHall_51524_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51524_Title = {
    Text = "<RedQuality:意识铭刻>"
  },
  CollectionHall_51525_Desc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  CollectionHall_51525_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51525_Title = {
    Text = "<WhiteQuality:重锁>"
  },
  CollectionHall_51526_Desc = {
    Text = "不可直视神。"
  },
  CollectionHall_51526_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51526_Title = {
    Text = "<OrangeQuality:无名之神的面纱>"
  },
  CollectionHall_51527_Desc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  CollectionHall_51527_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51527_Title = {
    Text = "<WhiteQuality:恶童>"
  },
  CollectionHall_51528_Desc = {
    Text = "成分不明的药物。\n据说著名提琴家埃里克对其青睐有加。"
  },
  CollectionHall_51528_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51528_Title = {
    Text = "<WhiteQuality:哈福德灵药>"
  },
  CollectionHall_51529_Desc = {
    Text = "蜡像师：医生的帮手，殡仪业者的恩客，墓虫的供养者。"
  },
  CollectionHall_51529_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51529_Title = {
    Text = "<WhiteQuality:美学原理>"
  },
  CollectionHall_51530_Desc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  CollectionHall_51530_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51530_Title = {
    Text = "<WhiteQuality:春之祭>"
  },
  CollectionHall_51531_Desc = {
    Text = "欢迎来到卡茜亚小姐的仙境马戏团！小心些，不要随便触碰魔术道具哦。要是一不小心被咬伤，那可就糟糕了。\n毕竟，它上一次尝到血的滋味，造成的后果可是很恐怖的。\n\n礼帽眨了眨眼睛，仿佛随时会破茧而出。"
  },
  CollectionHall_51531_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51531_Title = {
    Text = "<RedQuality:诡术礼帽>"
  },
  CollectionHall_51532_Desc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  CollectionHall_51532_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51532_Title = {
    Text = "<WhiteQuality:恩赐之血>"
  },
  CollectionHall_51533_Desc = {
    Text = "不要将它放入水中。"
  },
  CollectionHall_51533_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51533_Title = {
    Text = "<WhiteQuality:人鱼泪珠>"
  },
  CollectionHall_51534_Desc = {
    Text = "这究竟是仇恨的产物，还是复仇的结果？"
  },
  CollectionHall_51534_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51534_Title = {
    Text = "<WhiteQuality:哭泣烟斗>"
  },
  CollectionHall_51535_Desc = {
    Text = "所思所见皆为幻象。"
  },
  CollectionHall_51535_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51535_Title = {
    Text = "<WhiteQuality:万花筒>"
  },
  CollectionHall_51536_Desc = {
    Text = "不再象征公正。"
  },
  CollectionHall_51536_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51536_Title = {
    Text = "<WhiteQuality:失衡的天平>"
  },
  CollectionHall_51537_Desc = {
    Text = "阅读时请注意安全。"
  },
  CollectionHall_51537_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51537_Title = {
    Text = "<OrangeQuality:求知读书轮>"
  },
  CollectionHall_51538_Desc = {
    Text = "自残蜕中重生。"
  },
  CollectionHall_51538_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51538_Title = {
    Text = "<OrangeQuality:怪蛇残蜕>"
  },
  CollectionHall_51539_Desc = {
    Text = "木匠为妻子做了个栩栩如生的木偶，它将代替他们的儿子，在她腹中沉睡。"
  },
  CollectionHall_51539_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51539_Title = {
    Text = "<WhiteQuality:亲爱的宝贝>"
  },
  CollectionHall_51540_Desc = {
    Text = "在奇异的纪元中，花朵才是人类的第一观赏者。\n不要动弹，祂们更偏爱安静的展品。"
  },
  CollectionHall_51540_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51540_Title = {
    Text = "<RedQuality:逆向观赏>"
  },
  CollectionHall_51541_Desc = {
    Text = "一位慈祥的母亲，缝补心脏上的伤。"
  },
  CollectionHall_51541_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51541_Title = {
    Text = "<OrangeQuality:蒙尘缝纫机>"
  },
  CollectionHall_51542_Desc = {
    Text = "「戴上它，你就是伦蒂尼恩商会的成员之一了。」"
  },
  CollectionHall_51542_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51542_Title = {
    Text = "<OrangeQuality:商会勋章>"
  },
  CollectionHall_51543_Desc = {
    Text = "有人永远留在了那个夏天。"
  },
  CollectionHall_51543_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51543_Title = {
    Text = "<OrangeQuality:美好回忆>"
  },
  CollectionHall_51544_Desc = {
    Text = "为你指引的，仅有歧途。"
  },
  CollectionHall_51544_LockTip = {
    Text = "可于活动「欲海翻波」中解锁"
  },
  CollectionHall_51544_Title = {
    Text = "<OrangeQuality:六分仪>"
  },
  CollectionHall_51545_Desc = {
    Text = "他没有等到救援。"
  },
  CollectionHall_51545_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51545_Title = {
    Text = "<OrangeQuality:求救信号>"
  },
  CollectionHall_51546_Desc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  CollectionHall_51546_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51546_Title = {
    Text = "<WhiteQuality:锈蚀钢锯>"
  },
  CollectionHall_51547_Desc = {
    Text = "瘟疫——大自然无意识烦躁的偶然表现。"
  },
  CollectionHall_51547_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51547_Title = {
    Text = "<WhiteQuality:瘟疫诊断书>"
  },
  CollectionHall_51548_Desc = {
    Text = "享受苦痛。"
  },
  CollectionHall_51548_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51548_Title = {
    Text = "<RedQuality:苦痛圣腕>"
  },
  CollectionHall_51549_Desc = {
    Text = "长眠之主，候汝入梦。"
  },
  CollectionHall_51549_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51549_Title = {
    Text = "<OrangeQuality:螺湮的欢愉>"
  },
  CollectionHall_51550_Desc = {
    Text = "据说织纹螺等不可食用动物吸收了海洋大约80%的营养。"
  },
  CollectionHall_51550_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51550_Title = {
    Text = "<OrangeQuality:海眷歌谣>"
  },
  CollectionHall_51551_Desc = {
    Text = "已无人记得她的美。"
  },
  CollectionHall_51551_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51551_Title = {
    Text = "<OrangeQuality:失落之美>"
  },
  CollectionHall_51552_Desc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  CollectionHall_51552_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51552_Title = {
    Text = "<WhiteQuality:缠丝玛瑙>"
  },
  CollectionHall_51553_Desc = {
    Text = "人类有史以来最邪恶的发明之一。"
  },
  CollectionHall_51553_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51553_Title = {
    Text = "<WhiteQuality:精密计时器>"
  },
  CollectionHall_51554_Desc = {
    Text = "祈福的手，坚定的拳。"
  },
  CollectionHall_51554_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51554_Title = {
    Text = "<WhiteQuality:守护之手>"
  },
  CollectionHall_51555_Desc = {
    Text = "无法分辨沾染的液体。"
  },
  CollectionHall_51555_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51555_Title = {
    Text = "<WhiteQuality:刺荨麻背心>"
  },
  CollectionHall_51556_Desc = {
    Text = "承载着希望、祝福与爱。"
  },
  CollectionHall_51556_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51556_Title = {
    Text = "<OrangeQuality:小小襁褓>"
  },
  CollectionHall_51557_Desc = {
    Text = "刃面弯曲的匕首，常用于祭祀仪式。"
  },
  CollectionHall_51557_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51557_Title = {
    Text = "<WhiteQuality:遗落的祭祀刀>"
  },
  CollectionHall_51558_Desc = {
    Text = "缠绕、共生、集群；恐惧、未知、控制。"
  },
  CollectionHall_51558_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51558_Title = {
    Text = "<RedQuality:虫群意识>"
  },
  CollectionHall_51559_Desc = {
    Text = "光与影的戏法。"
  },
  CollectionHall_51559_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51559_Title = {
    Text = "<OrangeQuality:普拉斯诺镜>"
  },
  CollectionHall_51560_Desc = {
    Text = "不适宜用于割开活体。"
  },
  CollectionHall_51560_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51560_Title = {
    Text = "<WhiteQuality:锈蚀柳叶刀>"
  },
  CollectionHall_51561_Desc = {
    Text = "它们曾沾染无数鲜血、眼泪和霉菌。"
  },
  CollectionHall_51561_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51561_Title = {
    Text = "<WhiteQuality:缄默手套>"
  },
  CollectionHall_51562_Desc = {
    Text = "模糊的照片承载了模糊的记忆，亦或者——正是记忆的残缺，才造就了照片的褪色。"
  },
  CollectionHall_51562_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51562_Title = {
    Text = "<WhiteQuality:褪色照片>"
  },
  CollectionHall_51563_Desc = {
    Text = "荒无人烟的郊外，孤独的电话亭中铃声响起。\n「暗……嘶……无边的……嘶嘶……黑暗……」"
  },
  CollectionHall_51563_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51563_Title = {
    Text = "<OrangeQuality:深渊通信>"
  },
  CollectionHall_51564_Desc = {
    Text = "便携式的希望。"
  },
  CollectionHall_51564_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51564_Title = {
    Text = "<OrangeQuality:原型电池>"
  },
  CollectionHall_51565_Desc = {
    Text = "「它改变了历史。」"
  },
  CollectionHall_51565_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51565_Title = {
    Text = "<OrangeQuality:银白差分机>"
  },
  CollectionHall_51566_Desc = {
    Text = "双生是旧时代的礼物，是留给未来的寓言。"
  },
  CollectionHall_51566_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51566_Title = {
    Text = "<WhiteQuality:双生人偶>"
  },
  CollectionHall_51567_Desc = {
    Text = "「给你，什么都可以给你，求求你，放过他。」"
  },
  CollectionHall_51567_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51567_Title = {
    Text = "<WhiteQuality:母亲造像>"
  },
  CollectionHall_51568_Desc = {
    Text = "「给你，什么都可以给你，求求你，饶过我。」"
  },
  CollectionHall_51568_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51568_Title = {
    Text = "<WhiteQuality:奉献精神>"
  },
  CollectionHall_51569_Desc = {
    Text = "猜一猜，是黑还是白？"
  },
  CollectionHall_51569_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51569_Title = {
    Text = "<OrangeQuality:日月轮盘>"
  },
  CollectionHall_51570_Desc = {
    Text = "他们之前在一起，之后也会永远在一起。他们是相亲相爱的一家人。"
  },
  CollectionHall_51570_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51570_Title = {
    Text = "<OrangeQuality:我们的家>"
  },
  CollectionHall_51571_Desc = {
    Text = "录下了著名小提琴家最后的演出的唱片。\n自那以后，它能带来火焰。"
  },
  CollectionHall_51571_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51571_Title = {
    Text = "<RedQuality:快乐唱片>"
  },
  CollectionHall_51572_Desc = {
    Text = "无论怎么看都很普通。"
  },
  CollectionHall_51572_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51572_Title = {
    Text = "<WhiteQuality:渔叉>"
  },
  CollectionHall_51573_Desc = {
    Text = "在无光之地绽放。"
  },
  CollectionHall_51573_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51573_Title = {
    Text = "<WhiteQuality:旅行阳伞>"
  },
  CollectionHall_51574_Desc = {
    Text = "被量化的思念。"
  },
  CollectionHall_51574_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51574_Title = {
    Text = "<WhiteQuality:异乡邮票夹>"
  },
  CollectionHall_51575_Desc = {
    Text = "纵享欢乐，但不可食用。"
  },
  CollectionHall_51575_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51575_Title = {
    Text = "<WhiteQuality:彩蛋时间>"
  },
  CollectionHall_51576_Desc = {
    Text = "嘻嘻嘻，嘻嘻嘻。是你欠我的哦？"
  },
  CollectionHall_51576_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51576_Title = {
    Text = "<OrangeQuality:替身玩偶>"
  },
  CollectionHall_51577_Desc = {
    Text = "「你在其中窥见了什么？」"
  },
  CollectionHall_51577_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51577_Title = {
    Text = "<OrangeQuality:孟菲斯仪式镜>"
  },
  CollectionHall_51578_Desc = {
    Text = "隐约渗出鲜红。"
  },
  CollectionHall_51578_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51578_Title = {
    Text = "<WhiteQuality:红宝石胸针>"
  },
  CollectionHall_51579_Desc = {
    Text = "不止有时间能使织物变色，恐惧与痛苦亦能。"
  },
  CollectionHall_51579_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51579_Title = {
    Text = "<WhiteQuality:变色拘束服>"
  },
  CollectionHall_51580_Desc = {
    Text = "指示的并非方向，仅是磁场。"
  },
  CollectionHall_51580_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51580_Title = {
    Text = "<WhiteQuality:定向罗盘>"
  },
  CollectionHall_51581_Desc = {
    Text = "抽搐也是活性的一种。"
  },
  CollectionHall_51581_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51581_Title = {
    Text = "<WhiteQuality:活性注射器>"
  },
  CollectionHall_51582_Desc = {
    Text = "跃入虚空。"
  },
  CollectionHall_51582_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51582_Title = {
    Text = "<OrangeQuality:空间偏折仪>"
  },
  CollectionHall_51583_Desc = {
    Text = "折射出扭曲的影子。"
  },
  CollectionHall_51583_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51583_Title = {
    Text = "<OrangeQuality:跃迁装置>"
  },
  CollectionHall_51585_Desc = {
    Text = "小心，放纵的深眠会在你不知道的时候吞噬一切。"
  },
  CollectionHall_51585_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51585_Title = {
    Text = "<RedQuality:噩梦表象>"
  },
  CollectionHall_51586_Desc = {
    Text = "提取，淬炼。"
  },
  CollectionHall_51586_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51586_Title = {
    Text = "<WhiteQuality:神经毒素>"
  },
  CollectionHall_51587_Desc = {
    Text = "划破黑夜的流星。"
  },
  CollectionHall_51587_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51587_Title = {
    Text = "<WhiteQuality:文明之光>"
  },
  CollectionHall_51588_Desc = {
    Text = "燃烧清醒，堕入虚妄。"
  },
  CollectionHall_51588_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51588_Title = {
    Text = "<RedQuality:黑烛>"
  },
  CollectionHall_51589_Desc = {
    Text = "祂不是恶魔，但祂确实会传递人世之外的低语。"
  },
  CollectionHall_51589_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51589_Title = {
    Text = "<OrangeQuality:异种喉舌>"
  },
  CollectionHall_51590_Desc = {
    Text = "一起来拍照吧！体验一把面对真实的痛感。"
  },
  CollectionHall_51590_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51590_Title = {
    Text = "<OrangeQuality:在夕光里>"
  },
  CollectionHall_51591_Desc = {
    Text = "日渐消融。"
  },
  CollectionHall_51591_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51591_Title = {
    Text = "<OrangeQuality:被遗忘者之血>"
  },
  CollectionHall_51592_Desc = {
    Text = "一捧令人感到些许怀念的银芯。"
  },
  CollectionHall_51592_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51592_Title = {
    Text = "<WhiteQuality:「敬自由」>"
  },
  CollectionHall_51593_Desc = {
    Text = "它传递了无数主动或被动说出的秘密。"
  },
  CollectionHall_51593_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51593_Title = {
    Text = "<WhiteQuality:知无不言>"
  },
  CollectionHall_51594_Desc = {
    Text = "看来，他也没能逃出去。"
  },
  CollectionHall_51594_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51594_Title = {
    Text = "<WhiteQuality:安全出口>"
  },
  CollectionHall_51595_Desc = {
    Text = "神圣的一部分。\n纵然与躯干分离，仍能感受到其上的温暖。"
  },
  CollectionHall_51595_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51595_Title = {
    Text = "<RedQuality:救济之肢>"
  },
  CollectionHall_51596_Desc = {
    Text = "一位精神错乱的艺术家留下的最后作品，据说能从其中看到他惊恐的面容。"
  },
  CollectionHall_51596_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51596_Title = {
    Text = "<OrangeQuality:沉重画框>"
  },
  CollectionHall_51597_Desc = {
    Text = "健康饮食，从你我做起。"
  },
  CollectionHall_51597_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51597_Title = {
    Text = "<WhiteQuality:锡兰红茶>"
  },
  CollectionHall_51598_Desc = {
    Text = "肩负着怀念与感伤，向未知前进。"
  },
  CollectionHall_51598_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51598_Title = {
    Text = "<WhiteQuality:故人的怀表>"
  },
  CollectionHall_51599_Desc = {
    Text = "某种自制的外伤药膏，请不要在没有医生指导的情况下使用。"
  },
  CollectionHall_51599_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51599_Title = {
    Text = "<WhiteQuality:可疑的药膏>"
  },
  CollectionHall_51600_Desc = {
    Text = "探险者必备的好东西。过度依赖它的话，它就会成为你的一部分。"
  },
  CollectionHall_51600_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51600_Title = {
    Text = "<WhiteQuality:人工呼吸>"
  },
  CollectionHall_51601_Desc = {
    Text = "曾经出现在案发现场的缎带，被外力撕扯成了两截。\n其中一截曾从高空中飘下，落在女孩的掌心。"
  },
  CollectionHall_51601_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51601_Title = {
    Text = "<WhiteQuality:银色方扣缎带>"
  },
  CollectionHall_51602_Desc = {
    Text = "干瘪的尸体发出了鸣叫声。"
  },
  CollectionHall_51602_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51602_Title = {
    Text = "<RedQuality:厄运仪式鸟>"
  },
  CollectionHall_51603_Desc = {
    Text = "优雅、神秘的黑色短毛猫，据说在某个远方的沙漠国度被视作神明的化身。可那位神祇的名讳，如今已无人知晓。\n被崇拜，被敬仰，被遗忘，或许是为神明的宿命。"
  },
  CollectionHall_51603_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51603_Title = {
    Text = "<OrangeQuality:无上荣宠>"
  },
  CollectionHall_51604_Desc = {
    Text = "宇宙的奥妙。"
  },
  CollectionHall_51604_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51604_Title = {
    Text = "<OrangeQuality:秘典星象仪>"
  },
  CollectionHall_51605_Desc = {
    Text = "象征医生身份的手提箱，十分沉重。\n打开它的，未必是真的医生。"
  },
  CollectionHall_51605_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51605_Title = {
    Text = "<WhiteQuality:医生手提箱>"
  },
  CollectionHall_51606_Desc = {
    Text = "印刻了桂叶花纹的银质袖扣。\n它做工精致，闪闪发亮，曾经承载了两个孩子的友谊。"
  },
  CollectionHall_51606_LockTip = {
    Text = "可于调查行动中解锁"
  },
  CollectionHall_51606_Title = {
    Text = "<WhiteQuality:桂叶袖扣>"
  },
  CollectionHall_56246_Title = {
    Text = "玫瑰的栖居"
  },
  CollectionHall_56250_Title = {Text = "血与沙"},
  CollectionHall_56259_Title = {
    Text = "巨人的陨落"
  },
  CollectionHall_56260_Title = {
    Text = "苍白后裔"
  },
  CollectionHall_56267_Title = {
    Text = "骑士的愿望"
  },
  CollectionHall_56269_Title = {
    Text = "血的颜色"
  },
  CollectionHall_56270_Title = {
    Text = "如歌的雕琢"
  },
  CollectionHall_56276_Title = {
    Text = "扭曲核心"
  },
  CollectionHall_56279_Title = {
    Text = "诸事如常"
  },
  CollectionHall_56285_Title = {
    Text = "宁静的裂殖"
  },
  CollectionHall_56289_Title = {
    Text = "雨镇幽影"
  },
  CollectionHall_56290_Title = {
    Text = "一步之遥"
  },
  CollectionHall_56294_Title = {
    Text = "故事的魔法"
  },
  CollectionHall_56295_Title = {Text = "亵渎"},
  CollectionHall_56296_Title = {
    Text = "蔷薇礼赞"
  },
  CollectionHall_56305_Title = {
    Text = "燃烧的群宴"
  },
  CollectionHall_56359_LockTip = {
    Text = "通关特遣纪录「玫瑰的栖居：故乡」解锁"
  },
  CollectionHall_56359_Title = {
    Text = "献给春天的花束"
  },
  CollectionHall_56369_Title = {
    Text = "诗中世界"
  },
  CollectionHall_57597_Desc = {
    Text = "<Title:简介>\n伦蒂尼恩大区的现任主教，也是被前代主教意外唤醒的唤醒体。\n是创生父神的虔诚信徒，以生命践行父神的教导，以仁爱宽容之心对待世间万物，在民众间享有很高的声誉，甚至被一些信徒称为“伦蒂尼恩的圣徒”。\n讽刺的是，正是这份对万物的怜爱与悲悯夺去了他作为人时的生命。\n生前也曾试图治愈融蚀，为此不惜向生命石板献出自己的血肉，为教区内的“患者”缓解痛苦，延续生命。在他死后，石板不知所踪——直到他作为唤醒体再次苏醒。\n蒙在布条与绷带下的双眼能够看到灵魂的光辉，因而在他见到守密人后便确定：守密人正是父神预言中的苍白使者，能挽救这个即将陷入黑暗的世界。"
  },
  CollectionHall_57597_LockTip = {
    Text = "通关特遣纪录「血的颜色」解锁"
  },
  CollectionHall_57597_Title = {
    Text = "萨尔瓦多"
  },
  CollectionHall_57598_Desc = {
    Text = "<Title:简介>\n史前文明利莫里亚最年轻的幼王。\n自幼天赋异禀，每天昏睡二十小时以上，清醒时也总是显得困倦不已。\n偶尔能感受诸神的喜恶，梦见各种时空的残片，因而被崇拜、被敬畏、被尊为王。\n年幼的王并不在乎。他只是消极逃避着神的启示与预言。\n\n最终预见到了利莫里亚毁灭的宿命，却不知如何改变，只得保持缄默。\n直到灾难降临的那一天，人们都陷入了绝望。为了回应臣民的期望，他编造了一个虚假的预言。\n有关不朽的王，以及他重降于世的预言。\n最终，旧世界被洪水淹没。沧海桑田，新的人类重新在陆地上繁衍生息，史前之事再也无人知晓。\n恐怕他也没料到，自己无心的预言会被人不断演绎。\n他终究是低估了信仰的力量。"
  },
  CollectionHall_57598_LockTip = {
    Text = "唤醒「图鲁」后解锁"
  },
  CollectionHall_57598_Title = {Text = "图鲁"},
  CollectionHall_57599_Desc = {
    Text = "<Title:简介>\n亚兰族的异乡使者，自称循梦的启示来到勒姆瓦希。\n率领亚兰族的队伍长久徘徊于风暴之壁外，寻求令亚兰族圣树——丰穰母树复苏的可能性。\n实质隶属于提灯教会。尚无人知晓她那永恒的悲悯微笑后潜藏的真实动机，或许当旅程继续之时，能够窥破一二。"
  },
  CollectionHall_57599_LockTip = {
    Text = "通关调查行动第7章「欲河」解锁"
  },
  CollectionHall_57599_Title = {
    Text = "于丽埃特"
  },
  CollectionHall_57600_Desc = {
    Text = "<Title:简介>\n生活在史前文明利莫里亚，一家都是虔诚敬神的精神修行者。\n自幼勤奋修行，长大后如愿进入首都的神殿，成为一名祭司。\n她渴求神迹，渴求灵幻的体验，可它们却从未降临。\n\n图鲁即位为王的时候，她成为侍奉左右的大祭司。\n第一次见到新王的时候，她感到极度的恍惚和喜悦，她立刻明白这就是她渴求的、神在人间的化身。\n是的。她存在的意义就是侍奉这位幼王。\n\n直至洪水将大陆与利莫里亚的文明沉入海底，她也未曾动摇过这一信念。"
  },
  CollectionHall_57600_LockTip = {
    Text = "通关异梦视界「亵渎」解锁"
  },
  CollectionHall_57600_Title = {
    Text = "弥利亚姆"
  },
  CollectionHall_57601_Desc = {
    Text = "<Title:简介>\n为了散播种子跨越次元之壁，又因为「爱」放弃了来自种族的繁衍本能。\n意外流落到这个宇宙的沙耶，被穿行在星际的汀克特从银芯里唤醒，迷茫地寻找着方向，滞留在一颗荒芜的星球上，直到与弥萨格的守密人相遇。\n在探寻中，在深谈中，两个不相似的存在，对关于「爱」的定义，得出了一个相似的答案。\n记忆或许会模糊不清，但曾经与重要之人产生的联系，会再次为她引领前路。\n在这个弥漫着遗忘的世界里，她固守着自己以爱为名的疾病。"
  },
  CollectionHall_57601_LockTip = {
    Text = "唤醒「沙耶」后解锁"
  },
  CollectionHall_57601_Title = {Text = "沙耶"},
  CollectionHall_57602_Desc = {
    Text = "<Title:简介>\n在古老的传说中，世界上存在两只巨兽，分别盘踞于水底深渊、伊甸之东。\n这两只巨兽只有时间迎来尽头时才能相遇，他们将作为祭品献给生命之母提亚马特，以换取生命的轮回。\n\n萝坦便是隐藏于传说背后的「兽」。\n她是星球的自然产物，与传说不同的是，她既是深渊之水，也是伊甸之魂。\n她是纯粹的混沌力量，是不羁的自由灵魂，是未被定义的秩序。\n破坏与规则是世界赋予她的权能，两种截然相反的本能在萝坦体内碰撞，为了平衡足以撕碎她的力量，她需要用战斗来释放破坏欲望。\n萝坦被星球托付了守护历史的职责。她的“工作”就是顺应星球的意志，扫清、讨伐影响星球命运之人，但这样的人千万年难出其一。\n在无尽的，等待使命降下的无趣中，萝坦渴望着一名对手的出现。\n\n为此，她曾将目光投向那位年轻的幼王，甚至招来陨落的灾殃。\n然而一切都无损她汹涌的战斗意志，它们只会因她的复苏愈发猛烈。"
  },
  CollectionHall_57602_LockTip = {
    Text = "唤醒「萝坦」后解锁"
  },
  CollectionHall_57602_Title = {Text = "萝坦"},
  CollectionHall_57603_Desc = {
    Text = "<Title:简介>\n葬骸城曾经的王储，如今是被奉为神明的食尸鬼之王。\n他虽然是一名聪慧、公正的青年，但是因为独特的进食「品味」——食尸，遭受王室的忌惮。\n父王在退位前夜将杜勒赛因毒杀。在被分解吞噬的过程中，他的意识与神殿供奉的祂融合，从而品尝到了自己肉身的滋味，那惊人的甜蜜使他魂牵梦绕。\n他将进食视作浪漫的艺术，这不止是口舌之欲的满足，更是为了被忘却的纪念。\n融蚀会将一切摧毁，让往事随风消散，但是杜勒赛因会见证一切生者的传奇与平凡，让血与肉在自己的记忆中留存，直至永恒。"
  },
  CollectionHall_57603_LockTip = {
    Text = "唤醒「杜勒赛因」后解锁"
  },
  CollectionHall_57603_Title = {
    Text = "杜勒赛因"
  },
  CollectionHall_57604_Desc = {
    Text = "<Title:简介>\n曾是统领一方的庄园领主。\n据说母星被融蚀毁灭后，乘坐巨大的陨石坠入坎布里安河谷。\n擅长家畜管理、土地兼并和风险投资管理。\n每次外出，身后必然跟着浩浩荡荡的不死者仆从。\n1个当踏脚凳，2个吟游诗人逗乐，还有4个马车夫……\n教皇见了都会为自己的简陋排场感到羞愧。"
  },
  CollectionHall_57604_LockTip = {
    Text = "通关意识潜游「燃烧的群宴」解锁"
  },
  CollectionHall_57604_Title = {Text = "旺达"},
  CollectionHall_57605_Desc = {
    Text = "<Title:简介>\n汀克特挚爱的孪生姐姐。\n在孵化之初便展现了不一样的「天赋」，因为其不受控的能力，菲茵特只能在永远蜷曲在「襁褓」中无法长大。\n被认为是将给族类带来不幸的个体，因此与汀克特一起被逐出了原本的生活空间。\n\n妹妹依靠上流阶层的施舍换来生活所需的养料，她将绝大多数物资都用来供养菲茵特。\n在某个灾难发生后，赚来了唯一一张「机票」，将菲茵特哄骗上了离开荒芜行星的行程。\n起飞之际，菲茵特作出了第一次，也是最后一次的反抗：\n她以离开襁褓，吸收所有人生命能量为代价，要挟汀克特离开……\n因为自己是「有缺陷的」，所以十分自卑。\n\n曾一度拒绝进食，希望自己早点饿死，以免成为汀克特的拖累。\n长此以往，养成了挑食的坏毛病。\n\n喜欢阴暗的角落。一般需要到地下室之类的地方才能找到菲茵特。"
  },
  CollectionHall_57605_LockTip = {
    Text = "唤醒「菲茵特」后解锁"
  },
  CollectionHall_57605_Title = {Text = "菲茵特"},
  CollectionHall_57606_Desc = {
    Text = "<Title:简介>\n凯蒂古拉是一名出生在沙漠地区的孤儿，在她还是个少女的时候，就已经收留了许多当地同样身世悲惨的孩童。\n为了带领这些孩子们在世界上挣扎求生，她精心打造了一幅虚假的外壳，用来抵御恶意的侵害。\n许多人眼中，她便是残忍和疯狂的化身。\n无论是哪场冲突，她都会用最疯狂的热情和最残忍的手段，去回应那些敢于站在她枪口前的敌人。\n随着时间过去，即使是当地牙牙学语的孩童，都知晓在无边的沙海上，存在一名琥珀色的死神。\n在一场与N的交锋中，她不出意料地输掉了那场游戏，也因此失去了所有。\n但就连N都不知道，她早已受到群星中某位的注视。\n在经历命中注定的死亡后，她如约继承了祂的力量，以及祂为自己定下的使命。\n她体内蕴含着群星之中的存在，她早可以成为祂们中的一员。\n若那最终时刻的到来注定无法阻止，祂便会抛下一切，重新归于极天，成为那最初，也是最后的港湾。"
  },
  CollectionHall_57606_LockTip = {
    Text = "通关意识潜游「不朽极昼」后解锁"
  },
  CollectionHall_57606_Title = {
    Text = "凯蒂古拉"
  },
  CollectionHall_57607_Desc = {
    Text = "<Title:简介>\n熔毁·朵尔原本是弥萨格乃至人类科学的骄傲，在与融蚀漫长的对抗中她意识到，融蚀现象在消解身体的同时，也铺开了通向真理的道路。\n偶然接触到一块刻有奥秘箴言的远古石板后，她决心走上这条暗黑无境之路，放弃了更换人偶身体延续生命，任由融蚀侵蚀脑缸。\n最终她得偿所愿，洞悉了融蚀的本质，却也彻底走向毁灭与虚无。\n那明灯一般引领众人的信念与理性消失后，熔毁·朵尔开始在学校师生看不见的地方大行毁灭之道，“协助”引起数起伤亡事件后才被弥萨格发现，被施行了等级最高的监视与压制。\n只是在崩毁的人偶背后，天才不灭的灵魂似乎还在与世界背后更深远、更黑暗的地方，遥遥呼应。"
  },
  CollectionHall_57607_LockTip = {
    Text = "唤醒「熔毁·朵尔」后解锁"
  },
  CollectionHall_57607_Title = {
    Text = "熔毁·朵尔"
  },
  CollectionHall_57608_Desc = {
    Text = "<Title:简介>\n出身卑微，因美貌颇受欢迎，勉强混迹于上流阶层的歌女。\n\n在灾劫发生时，凭借一些怜悯和恩惠，赚来了唯一一张逃生的「机票」。\n\n所有人都默认这一名额应当属于她自己，而她却在暗中下定决心，打算将姐姐菲茵特护送上航线。\n\n然而，最后时刻姐姐以离开襁褓动用力量威逼，将其绑上了座位，送离荒星。\n\n\n被意外唤醒后，汀克特心中萦绕无尽愧悔，她相信姐姐没有死去，或者以某种形态和自己一样复苏。\n\n自那之后，她竭尽全力搜索姐姐的下落，不惜一切代价。"
  },
  CollectionHall_57608_LockTip = {
    Text = "唤醒「汀克特」后解锁"
  },
  CollectionHall_57608_Title = {Text = "汀克特"},
  CollectionHall_57609_Desc = {
    Text = "<Title:简介>\n被称为「弥萨格之脑」的天才学者，弥萨格外勤顾问之一。\n14岁入学弥萨格，曾主持改进了阿利斯泰尔的维生装置。\n在一次外出途中感染融蚀，写下足足八十页的唤醒步骤说明后，平静离世。\n死后同伴依照说明，将她的银芯投入唤醒仪器中，制作出「朵尔唤醒体」。\n被唤醒后，她平静地起身穿衣，平静地走进研究室，平静地继续生前遗留的研究。\n嗳！天才的世界便是这样枯燥且平淡。"
  },
  CollectionHall_57609_LockTip = {
    Text = "唤醒「朵尔」后解锁"
  },
  CollectionHall_57609_Title = {Text = "朵尔"},
  CollectionHall_57610_Desc = {
    Text = "<Title:简介>\n从被融蚀吞没的星球逃亡而来的外星种族精神体，占据了一个刚刚死去的少女的身体，避免了和父母一样死去的命运。\n好景不长，在这具人类的躯体身上出现融蚀症状后，她的精神体同样被融蚀固定在了体内，无法再次逃逸。\n在融蚀侵染的恐惧下陷入精神崩溃，主动联系了弥萨格，要求将自己制成唤醒体，并答应用自己种族的知识技术作为回报。\n成为唤醒体后在学院进行机械、电学、精神相关研究，由于对融蚀的分外恐惧无法进行融蚀研究，甚至因为心理阴影害怕黑暗，不敢睡觉，每天活在敏感与神经质中。"
  },
  CollectionHall_57610_LockTip = {
    Text = "唤醒「温柯尔」后解锁"
  },
  CollectionHall_57610_Title = {Text = "温柯尔"},
  CollectionHall_57611_Desc = {
    Text = "<Title:简介>\n诞生于精神位面的精神体，原本孤独漂浮于宽广而空无一物的灰色海洋中，跟随偶尔到来的精神旅者来到地球，体验不同的愿望，并把他们的头颅斩下收集于海洋中，吸取他们的智慧、情感。\n早在一千六百多年前被唤醒，并附身唤醒者斩下了她的头颅，由于吸食精神力的特质，依旧靠收集头颅来维持存在，并为了消遣玩弄猎杀了远超所需的头颅。直到遇到了真正的店主后，被制服并达成交换，作为助手跟随店主直到她生命结束。\n已经与店主建立了真正友谊的怪物明白了自己真正的渴求，斩下了店主的头颅，并继承了她的外貌和商店。从此不再随意猎杀头颅，改为交换商店的方式解决神秘学委托换取头颅，并通过与顾客交流的方式缓解失去店主的孤独。\n现在的愿望是守护商店与店主喜爱的城市。"
  },
  CollectionHall_57611_LockTip = {
    Text = "通关特遣纪录「雨镇幽影」解锁"
  },
  CollectionHall_57611_Title = {
    Text = "达芙黛尔"
  },
  CollectionHall_57612_Desc = {
    Text = "<Title:简介>\n生前曾经是一名巡游世界的魔术师。\n从小在马戏团中长大，生活中充斥着许多「异类」，小偷，逃犯，弃儿，残疾人，畸形儿……\n卡茜亚同样是个「异类」：她无法感知情绪、也无法自发产生情绪。\n是不折不扣的表演天才，总能赢得观众的喝彩。\n即便后来遭遇@2，成为异端受害者的亡灵，她也照样像生前那样表演魔术，邀请观众进入「仙境般的神奇世界」。\n奇怪的是，每一个观众看完魔术秀以后，都觉得「缺了点什么」，生活变得愈发了无生趣。\n他们困惑、麻木、甚至自杀。\n而我们的魔术师小姐呢？她躲在帷幕后，愉悦地吸食着自己收获的甜美「报酬」。\n华丽的演出造价高昂，她只是为了可持续发展。"
  },
  CollectionHall_57612_LockTip = {
    Text = "唤醒「卡茜亚」后解锁"
  },
  CollectionHall_57612_Title = {Text = "卡茜亚"},
  CollectionHall_57613_Desc = {
    Text = "<Title:简介>\n偶然跨越世界线屏障的神秘个体，亦是拉蒙娜的另一种可能性。\n在「那起事件」中，为了守密人的安危，不得不放任唤醒体的力量掌控身体。\n\n事件结束后，@2在拉蒙娜身上留下的影响未曾消退。\n@2的意识留在了她的身体里，逐日挤压意识的存在空间。\n为此，她陷入无尽的挣扎与煎熬。\n\n因为不愿让人担心，面上会装成一切都好的样子\n，将自己的头发与生活都打理得井井有条。\n偶尔意识会迷失，呈现出放空的状态\n，甚至用另一种口吻说话。\n对此不必感到担忧。即使来处不同，所行一切亦是为了守密人及这个世界的和平。"
  },
  CollectionHall_57613_LockTip = {
    Text = "通关意识潜游「一步之遥」解锁"
  },
  CollectionHall_57613_Title = {
    Text = "环行·拉蒙娜"
  },
  CollectionHall_57614_Desc = {
    Text = "<Title:简介>\n她生于诗与玫瑰的国度，她是诗歌的精灵。\n精灵徜徉在文字编织的梦里，为每一缕阳光的绽放欣喜，为每一支花的凋零落泪。\n她沉吟，她伤怀，她渴望另一个灵魂的陪伴。\n\n后来，在鲜花盛开的庭院里，年轻的花匠将一支玫瑰放在了她的面前。\n于是她羞赧地笑了，轻轻接过这支花。\n「终于不是独自一人了。」\n那时的她这样坚信着。"
  },
  CollectionHall_57614_LockTip = {
    Text = "通关特遣纪录「玫瑰的栖居」解锁"
  },
  CollectionHall_57614_Title = {Text = "奥尔拉"},
  CollectionHall_57615_Desc = {
    Text = "<Title:简介>\n自远古之时而来，亚兰族唯一的女王。\n年幼时被奉为树的使者，为君王传递谕令。初次反抗后被视为祭品投入亚兰族圣河之中，却觉醒了树的意志。\n她的血肉中融入了树的乳汁，树的根系中流淌着她的血脉。她即是丰穰母树，丰穰母树即是她。\n然而融蚀的力量污染了亚兰族的血脉，她主动用自己的身躯代母树承受污染，以求亚兰族的一线生机。\n在亚兰族已经湮灭在历史的长河里的今天，唯有拔地而起又轰然倒塌的丰穰母树见证了与她有关的故事。"
  },
  CollectionHall_57615_LockTip = {
    Text = "唤醒「泰旖丝」后解锁"
  },
  CollectionHall_57615_Title = {Text = "泰旖丝"},
  CollectionHall_57616_Title = {
    Text = "群星之间"
  },
  CollectionHall_57617_Desc = {
    Text = "<Title:简介>\n弥萨格大学的心理老师，负责调查员们的心理疏导。\n温柔和善，广受校内师生喜爱，某些弥萨格成员却对她十分畏惧。\n且不说那些成分不明的红茶——没人见过她不笑的模样，单是这一点就足够令人毛骨悚然了。"
  },
  CollectionHall_57617_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_57617_Title = {
    Text = "茜尔维娅"
  },
  CollectionHall_57618_Title = {Text = "愚痴者"},
  CollectionHall_57619_Title = {Text = "混种"},
  CollectionHall_57620_LockTip = {
    Text = "唤醒「皮克曼」后解锁"
  },
  CollectionHall_57620_Title = {Text = "异乡人"},
  CollectionHall_57621_Desc = {
    Text = "<Title:简介>\n弥萨格的资深调查员，被守密人尊称为「学长」的存在。\n曾因某些无法言说的原因害怕外出，在校内学习的同时兼任情报组人员。\n好友死后，一改以往的作风转投前线，以「做他曾经做过的事」的方式来纪念逝去的朋友。\n随身携带一把破碎的银钥匙，艰难地维持着那些日渐消逝的记忆。"
  },
  CollectionHall_57621_LockTip = {
    Text = "通关序章解锁"
  },
  CollectionHall_57621_Title = {Text = "威廉"},
  CollectionHall_57622_Desc = {
    Text = "<Title:简介>\n西岱的花匠，奥尔拉的童年挚友。\n在奥尔拉最无助的时候，柯蕾特用一座花园带给了她最难忘的快乐时光。\n在奥尔拉的才华生根发芽的时候，柯蕾特用一场大火夺走了她的财富、名望、以及生命。\n她与赫伯特合作，用奥尔拉的诗集创造了诗中世界。或许是为了缅怀，或许是为了掌控。没人知道。\n柯蕾特从来都宣称，在那些美丽的诗句里，她唯一读懂的只有欲望。\n她为此痛苦。她以此为荣。"
  },
  CollectionHall_57622_LockTip = {
    Text = "通关特遣纪录「玫瑰的栖居」解锁"
  },
  CollectionHall_57622_Title = {Text = "柯蕾特"},
  CollectionHall_57623_Desc = {
    Text = "<Title:简介>\n弥利亚姆曾遇见过两位黛博拉：一位是利莫里亚的祭司，一位是奥恩家族的侍女。一位是她的挚友，另一位也是她的挚友。\n相距上万年的两个时代，两个不同的人，同样的名字，同样的容貌，同样的良善。这是一个罕见的巧合，对弥利亚姆来说，这也是一个神圣的预兆。\n弥利亚姆见证了两位黛博拉的结局：一位随着利莫里亚沉入海底，一位被她亲手送上祭台，剖腹而亡。\n在这场关于神国的宏大叙事里，黛博拉的故事，只是两道简短鲜红的注脚。"
  },
  CollectionHall_57623_LockTip = {
    Text = "通关异梦视界「亵渎」解锁"
  },
  CollectionHall_57623_Title = {Text = "黛博拉"},
  CollectionHall_57624_Desc = {
    Text = "<Title:简介>\n弥萨格大学第一信息掮客，校推理协会成员。\n拥有无与伦比的信息收集与挖掘能力，在整个伦蒂尼恩内都小有名气。\n本是亚格罗共和国人，因家庭变故来到伦蒂尼恩，并通过手里掌握的弥萨格秘密成功入学。\n千万别被她爽朗的笑容迷惑——她对弥萨格的了解可远比一般人以为的要深。"
  },
  CollectionHall_57624_LockTip = {
    Text = "通关调查行动第1章「东区秘事」解锁"
  },
  CollectionHall_57624_Title = {Text = "汉娜"},
  CollectionHall_57625_Desc = {
    Text = "<Title:简介>\n前格林基金会研究员，拉伊疗养院院长。\n丈夫和女儿死后，一直在四处追寻能够复活女儿的方法。\n漫长求索的过程中，她忘记了女儿的模样，也忘记了曾支撑她苦苦向前的爱意与温暖。\n她只记住了痛苦本身。"
  },
  CollectionHall_57625_LockTip = {
    Text = "通关调查行动第4章「于无声处」解锁"
  },
  CollectionHall_57625_Title = {
    Text = "弗朗西斯"
  },
  CollectionHall_57626_Desc = {
    Text = "<Title:简介>\n索纳尼尔号的船长。\n家乡因融蚀而消散在人们的记忆里，唯独他记得一切。因此人们叫他疯子。\n海边的小镇、亲人、手足……它们都是疯子极力想要找回的过往。\n他与弥利亚姆达成协议，运送她所需的货物，作为回报，她将助他唤醒一份沉睡已久的记忆。\n于是，他看到了那名被清风与白鸟簇拥着的少女。\n\n「我的名字是希莱斯特，只要你还需要我，我就会存在于此。」\n她是故土曾经存在的痕迹，是他幼时从老人口中听来的童话。\n\n原来，那些魂牵梦绕的过去是真实存在的。"
  },
  CollectionHall_57626_LockTip = {
    Text = "通关调查行动第6章「倒错的群星」解锁"
  },
  CollectionHall_57626_Title = {Text = "埃尔顿"},
  CollectionHall_57627_Desc = {
    Text = "<Title:简介>\n父神济世大圣堂的事务员，负责辅助主教及其他神职人员维护圣堂的日常运转。\n父亲病故后，能干的姐姐挑起家业，成为小有名气的商人，一切似乎都是如此美好顺利——直到那场精心策划的骗局。\n一夜之间，母女三人一无所有。但这没关系，伦蒂尼恩的主教向她伸出了援手，只要有家人相伴，她不怕任何困难。\n而后她的姐姐死了。\n她的母亲悲痛万分，郁郁而终。\n与此同时，那个占据她祖宅的无耻之徒正在举办艺术沙龙，寻欢作乐。\n困惑、愤怒、不解……无数情绪挤在她的胸口，化作要将她碾成灰烬的仇恨。但她不应该这样，主教说过的，囿于过去的永远也无法向前，唯有宽恕才能解脱。\n她做不到。\n「不要强迫自己容忍，」那位自称提灯女士的人在她耳边循循善诱，「宽恕即是放纵。善人才应称义，恶人——恶人都当受到应有的惩罚。」\n于是她从她手里接过镜子，开始了审判的仪式。"
  },
  CollectionHall_57627_LockTip = {
    Text = "通关特遣纪录「血的颜色」解锁"
  },
  CollectionHall_57627_Title = {Text = "索菲娅"},
  CollectionHall_57628_Desc = {
    Text = "<Title:简介>\n来历不明的奴隶，曾接替戈利亚成为部族首领。\n8岁便杀死主人，躲在木桶里，一路飘来非利士人的小岛。\n体内流淌着卑贱的血脉，羸弱、下流、野心勃勃。\n成为首领后不到一个月便被斩首，在位时间与其他首领的相比，位列第13。\n非利士人的首领可不是什么能随便干到退休的职位。"
  },
  CollectionHall_57628_LockTip = {
    Text = "通关意识潜游「巨人的陨落」解锁"
  },
  CollectionHall_57628_Title = {Text = "以格伦"},
  CollectionHall_57629_Desc = {
    Text = "<Title:简介>\n\n\n她曾是永恒国度的中继站，把握着王国与外部世界的出入口，负责将迷途的臣民指引回乡。\n当王国陷入沉睡，不断向海涡深处坠落时，法洛思与她的故乡断开了链接。\n她无法与王都取得联系，也无法在苍茫海洋中寻得任何踪迹。\n\n身为海上灯塔，却无法照亮归乡之路，这是何等讽刺。\n\n在漫长而孤独的时间中逐渐发狂失能，造成了历史上多起海洋灾害，直到力竭后被某个古代英雄讨伐。\n\n后日的研究中，甚至有学者认为正是法洛思的发狂导致了大洋洲的沉没。\n一切都只是猜测。直到现在，这位狂热信徒的过去仍是一个谜。"
  },
  CollectionHall_57629_LockTip = {
    Text = "唤醒「法洛思」后解锁"
  },
  CollectionHall_57629_Title = {Text = "法洛思"},
  CollectionHall_57630_Desc = {
    Text = "<Title:简介>\n是某个公国小贵族家的儿子，虽然出身贵胄，父亲却毫无建树，未来人生肉眼可见的平淡。\n直到一次圣诞晚宴时被父亲带去拜见大公，因晚宴时对生病的同龄公主的爱护照顾令大公另眼相看，在大公的玩笑话中成为了公国骑士预备役，开始正式参加骑士团的训练。\n直到战火来袭，公国羸弱的军队无法阻挡铁骑的入侵，在一片死伤中，奥吉尔是最后一位守护公主的“骑士”。\n他握着尚且过于高大的长枪，永远挡在了公主的门前。"
  },
  CollectionHall_57630_LockTip = {
    Text = "通关意识潜游「骑士的愿望」解锁"
  },
  CollectionHall_57630_Title = {Text = "奥吉尔"},
  CollectionHall_57631_Desc = {
    Text = "<Title:简介>\n在烈焰中起舞的天才舞者。\n数百年来，她的家族都作为宫廷舞者存在着。是以即便王国更迭，学校不再，她也从未失去高雅唯美的舞蹈灵魂。\n十八岁那年，她加入了当地的芭蕾舞团，很快成为当之无愧的首席。\n\n然而首演成功后，舞团经理竟以「介绍」的名义，将莉兹送进富商的房间。\n原来，芭蕾早已变得不再纯粹，高雅底蕴成为了女孩们抬高身价的资本。\n于是她出走、被抓回、然后继续出走……终于，她的「清高」触怒了那些位高权重的大人物。\n他们从身心上折磨莉兹，她必须不停地旋转，不停地跳，就算足尖崩裂，黑色污血滴落满地也不能停。\n\n终于，在一个寻常的演出里，当舞蹈进行到最高潮时，烈火从她足底蔓延升起。\n她将烧毁一切不公与罪恶。"
  },
  CollectionHall_57631_LockTip = {
    Text = "唤醒「莉兹」后解锁"
  },
  CollectionHall_57631_Title = {Text = "莉兹"},
  CollectionHall_57632_Desc = {
    Text = "<Title:简介>\n被奴役，被收养，被抛弃……故事到这里和另一个世界线的希洛没有什么区别，但一样的血，终于浇灌出了不一样的残枝。\n直到落入牢狱后，真正的地狱才开始。她惊恐地发现，原本应该一起仇恨奴隶主的族人们同样在仇恨着她，甚至那份恶意还要更甚。\n每天每天，她落入了无尽的折磨与痛苦，命运的礼物连本带息地摧垮了她的精神。\n她本应针对奴隶主的仇恨变成了对所有人的仇恨，同样她也被所有人憎恨着，失去了自己存在的位置。\n直到利用融蚀逃出监狱的时候，她的心中已经只剩下疯狂，她握着忽然得到的力量，迫不及待地释放自己无尽的愤恨。\n那一夜，整座城池下起红色的血雨，她站在红色的河流中，仰头畅快地大笑。"
  },
  CollectionHall_57632_LockTip = {
    Text = "唤醒「血链·希洛」后解锁"
  },
  CollectionHall_57632_Title = {
    Text = "血链·希洛"
  },
  CollectionHall_57633_Desc = {
    Text = "<Title:简介>\n雕塑家协会创始人、会长。\n幼年罹患脊髓炎，只能在家自学，从那时起便意识到了人类身体的局限性。\n长大后进入弥萨格学习，在导师的帮助下找到了研究方向，顺便治愈了自己的疾病。\n总是面带和煦的微笑，事实上对人类情感漠不关心。\n疏于形象管理，头发和办公桌一样乱。\n书桌抽屉里存放着一个文件夹，里面整齐地收藏了克劳利历年发表过的论文——这是赫伯特做过最有条理的一件事。"
  },
  CollectionHall_57633_LockTip = {
    Text = "通关调查行动第1章「东区秘事」解锁"
  },
  CollectionHall_57633_Title = {Text = "赫伯特"},
  CollectionHall_57634_Desc = {
    Text = "<Title:简介>\n非利士人心目中，有史以来最勇猛的首领。\n身材高大、魁梧有力，上位短短几年间，就带领着非利士人横扫周遭各大部落，至今未尝败绩。\n在赞美与鲜花之中，他威名远扬，竟不顾族人的劝阻，犯下轻敌大罪。\n微小的失误导致非利士人溃不成军。于是他甘愿受罚，带着唯一的追随者流亡海上。\n愤懑、不甘……这耻辱的时刻必将被铭记，他宁愿将脆弱的脖颈献予「女巫」，只求夺回属于自己的一切。\n他已然踏上血腥的复仇之路。"
  },
  CollectionHall_57634_LockTip = {
    Text = "通关意识潜游「巨人的陨落」解锁"
  },
  CollectionHall_57634_Title = {Text = "戈利亚"},
  CollectionHall_57635_Desc = {
    Text = "<Title:简介>\n原本是下贱的奴隶，从小的聪颖与美貌仿佛注定了她悲惨的命运。\n然而突如其来的幸运让她代替掌政官夫妇死去的女儿成为了他们乖巧的养女，再也没有人对她投以看奴隶的眼神。\n她太小就离开了家，多年的相处让她把那位温柔的夫人当作了真正的母亲，直到她偶然对曾经的族人伸出援手，极度厌恶奴隶结盟的掌政官夫妇立刻抛弃了她。\n命运残忍地露出了不曾改变的真容，她一夕成为了阶下囚，在囚笼中发酵着仇恨，度过了整个青春期。\n当融蚀在监狱中爆发后，她发现这黑色的液体能够腐蚀镣铐，于是复仇女神终于离开了监牢，再次出现时，她用掌政官的头颅换来了提洛人的全面解放。\n她的余生都在追杀那些曾经的奴隶主中度过，直到化作一座无名的、刻着赞歌的坟茔。"
  },
  CollectionHall_57635_LockTip = {
    Text = "唤醒「希洛」后解锁"
  },
  CollectionHall_57635_Title = {Text = "希洛"},
  CollectionHall_57636_Title = {
    Text = "黑暗住民"
  },
  CollectionHall_57637_Desc = {
    Text = "<Title:简介>\n不同于那个时代多以医护身份出现在战场上的女性，她生前是一名骁勇的战士，并以此为傲。\n她坚信祖国是圣洁的，祖国对其他土地的征服将为世界带来更好的未来。\n一场激烈的战斗中，她为了救回一名新兵身受重伤，事后虽然勉强活了下来，却留下了不良于行的后遗症。为了继续报效祖国，她没有离开军队，而是退出了前锋部队，转职新兵教练。\n\n随着时间推移，那些傲慢的新兵不满自己的教官是个“残废”，军队中逐渐有了关于她的窃窃私语。\n当她意识到这点后试图向那名自己救下的新兵提出意见——他现在已经是一名少校了。然而那名士兵竟然也同其他人一般，讥讽着她的伤腿。\n被如此羞辱让她怒不可遏地离开了军队。\n在军队和战场外，她终于看到了世界的全貌：“战争英雄”被同胞所背离，自己曾自豪的“解放”只给当地居民带来了殖民与苦难。\n她的内心天翻地覆，在这之后，她全身心地投入进了真正的解放中，强烈的正义感和愧疚指引着她去做真正“正确”的事。\n可惜的是，伤腿的溃烂始终未曾治愈，她甚至在赎罪完成前就痛苦死去。\n再度被唤醒后感怀泰旖丝的恩情，始终尽力帮助亚兰部落延续下去。"
  },
  CollectionHall_57637_LockTip = {
    Text = "唤醒「艾尔瓦」后解锁"
  },
  CollectionHall_57637_Title = {Text = "艾尔瓦"},
  CollectionHall_57638_Desc = {
    Text = "<Title:简介>\n曾是古罗马魔像、明星角斗士、最后的唯一战士。\n为了贯彻皇帝卡里古拉的疯癫意志而生，为其除掉了全部的政敌：叔父、哥哥、妹妹……\n少年皇帝跪倒在亲人的尸山面前，高举双臂，又哭又笑。\n尤乌哈希感到困惑：魔像会哭，会笑，却无法做到大笑的同时泪如雨下。\n后来，暴虐的皇帝被处死。临刑前，他抱住尤乌哈希。\n但他什么都没说。\n失去主人的兵器从此不断流浪，直到遇到下一个主人。\n他依旧对人类感到困惑。"
  },
  CollectionHall_57638_LockTip = {
    Text = "通关意识潜游「血与沙」解锁"
  },
  CollectionHall_57638_Title = {
    Text = "尤乌哈希"
  },
  CollectionHall_57639_Desc = {
    Text = "<Title:简介>\n被誉为「伦蒂尼恩最耀眼的明珠」，一言一行皆受万众瞩目。\n曾与最邪恶的神祇签订契约，又以自己的「死亡」重获新生。\n关于她的身份，人们众说纷纭。\n名媛、情妇、商人、政客，引领时尚的女王……\n她真实的面目早已模糊。\n亦或者，这般变幻不定，才是她的本来面貌？"
  },
  CollectionHall_57639_LockTip = {
    Text = "通关特遣纪录「蔷薇礼赞」解锁"
  },
  CollectionHall_57639_Title = {Text = "索蕾尔"},
  CollectionHall_57640_Desc = {
    Text = "<Title:简介>\n曾是古罗马贵族小姐，父亲经营一家角斗士训练营。\n仗着身边环绕的强大角斗士奴隶，在卡普亚横行肆虐、不可一世。\n讽刺的是，最后不得不央求最讨厌的奴隶杀死自己。\n更讽刺的是，成为唤醒体后，不幸又与那位「奴隶」在校园相遇。\n可想而知，迎接他们的自然不会是什么温情脉脉的场面。"
  },
  CollectionHall_57640_LockTip = {
    Text = "通关意识潜游「苍白后裔」解锁"
  },
  CollectionHall_57640_Title = {
    Text = "阿格里帕"
  },
  CollectionHall_57641_Desc = {
    Text = "<Title:简介>\n在水手们的愚昧传统下被塑造的航船圣女，实际只是被贫困的家庭卖出的女儿，为庇佑航行日复一日被绑缚在桅杆上。\n毫无自由与选择的人生让她变得无悲无喜，几乎没有自我，只剩下航船是她最熟悉的归宿。\n无力的人生却被寄托着美好的祈愿，因被禁止与船员交谈而习惯了发呆，只有最强烈的愿望与桅杆旁翱翔的海鸟能吸引她的目光。\n最后因庇佑的航船遭遇融蚀死伤惨重，被倾泻怒火的人们处以了溺死之刑。"
  },
  CollectionHall_57641_LockTip = {
    Text = "唤醒「希莱斯特」后解锁"
  },
  CollectionHall_57641_Title = {
    Text = "希莱斯特"
  },
  CollectionHall_57642_Desc = {
    Text = "<Title:简介>\n来自西岱的雕砌者。\n据说出身名门，为了追求艺术与家族决裂，独自前往西岱，师从著名的雕塑大师奥古斯特。\n拥有令人绝望的天资，却从未在艺术史中留下只言片语。\n成为唤醒体后，对雕塑和雕刻有了新的理解，成为了大家熟知的那一类「疯狂艺术家」。\n将守密人当作新的灵感源泉，看向守密人的眼神总是透着一丝诡异的温柔。\n噢，那是不掺一丝杂质的、打量心爱素材的眼神。"
  },
  CollectionHall_57642_LockTip = {
    Text = "通关意识潜游「如歌的雕琢」解锁"
  },
  CollectionHall_57642_Title = {Text = "珊"},
  CollectionHall_57643_Desc = {
    Text = "<Title:简介>\n曾是古老的阿契美尼德王朝侍女。\n因没能选中在百年宴会上服侍宾客，在湖中溺死了同伴并顶替了她。\n最后在宴会中被变成了丑陋的绿色怪物。\n拥有灵活的头脑和身段，能同时端起十个盘子穿梭在人群中。\n对美食的定义与当代饮食文化严重脱节。\n偶尔也会怀疑自己是因为杀人而受到处罚，变成怪物。\n但绝不会汲取教训，很快便会装作无事发生。\n毕竟，埃里温人能从历史中吸取的唯一教训就是：\n埃里温人从来不会吸取教训。"
  },
  CollectionHall_57643_LockTip = {
    Text = "唤醒「珈伦」后解锁"
  },
  CollectionHall_57643_Title = {Text = "珈伦"},
  CollectionHall_57644_Desc = {
    Text = "<Title:简介>\n位于@2的监狱狱警，以折磨犯人为乐。\n上级曾向她许诺，三年后会将她调回伦蒂尼恩，然而融蚀现象的恶化和地脉变迁，她被遗忘在这块遥远土地。\n少女并未气馁。她坚守废墟，等待着被召回的那一天。\n直到最后一名犯人离世，她成为岛上唯一的活物。\n没有犯人的狱警，和犯人又有什么分别呢？\n少女拒绝思考。她依旧等待被召回的那一天。"
  },
  CollectionHall_57644_LockTip = {
    Text = "唤醒「潘狄娅」后解锁"
  },
  CollectionHall_57644_Title = {Text = "潘狄娅"},
  CollectionHall_57645_Title = {
    Text = "超越万古"
  },
  CollectionHall_57646_Desc = {
    Text = "<Title:简介>\n弗朗西斯饲喂的「宠物」。\n本是名为「丽莎」的活泼少女，经雕塑家协会的改造转变为人兽缝合的扭曲形态，后被莉莉收养，暂时生活在疯人院内。\n尽管丧失了人类的外貌和发声能力，库姆仍保留着丽莎的部分心智，能够通过简单的肢体动作传达自己的意图。\n她做出了自己的选择。"
  },
  CollectionHall_57646_LockTip = {
    Text = "通关调查行动第4章「于无声处」解锁"
  },
  CollectionHall_57646_Title = {Text = "库姆"},
  CollectionHall_57647_Desc = {
    Text = "<Title:简介>\n来历不明的药剂师，目前是雕塑家协会的科学顾问。\n据说母亲是个乡下农妇，她被选中怀上了伟大蛇神的子嗣。\n继承了母亲的白化病以及和善的性情，是赫伯特唯一信任的朋友。\n热衷解剖学、芳香烃和颠茄燃烧的香气。\n著作等身，代表作是被誉为毒理学圣经的《药物志》。\n长期浸泡在各种毒物中，就连呼出的气体也含有剧毒。离他远点——这是笔者唯一的忠告。"
  },
  CollectionHall_57647_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_57647_Title = {
    Text = "阿尔比诺"
  },
  CollectionHall_57648_Desc = {
    Text = "<Title:简介>\n华德·菲利普斯的学生，弥萨格第一位守密人。\n常年身居地下的秘密区域内，仅有极少数人知道其存在。\n精神力卓绝超群，多年来一直凭借特殊秘法维系生命，以此保证弥萨格的安全。\n预感到守密人在未来的变局中非常关键，破例让守密人能够随时与自己接触。\n既是培养，也是观察。"
  },
  CollectionHall_57648_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_57648_Title = {
    Text = "阿利斯泰尔"
  },
  CollectionHall_57649_Desc = {
    Text = "<Title:简介>\n身怀稀薄蹈海者血脉的人类，出身于古老的奥恩家族。该家族曾遭遇变故，部分人会在成人后逐渐变成相貌丑陋的怪物，最终痛苦而死，父亲也因受不了病变在他出生后自杀。\n从小在母亲的厌恶与同龄人的欺辱下长大，性格变得阴暗孤僻。\n十六岁时因看到叔叔遗留手稿中隐晦提到的家族高贵血脉，从此获得了精神的胜利，整日幻想自己有一天会获得超然的力量，将周围人的欺凌当作天选之子必经的磨难，期待着他们之后对自己摇尾乞怜的样子。\n在成年时躲进山洞中迎接蜕变，却停滞在了半人半鱼的样子，被母亲尖叫驱赶无法回家。\n最终他跳入海中妄图寻找族群，却因未发育完全的腮部淹死。"
  },
  CollectionHall_57649_LockTip = {
    Text = "唤醒「凯刻斯」后解锁"
  },
  CollectionHall_57649_Title = {Text = "凯刻斯"},
  CollectionHall_57650_Desc = {
    Text = "<Title:简介>\n来自王国最古老的卡文迪许家族，曾是父母的掌上明珠，却不幸感染融蚀。\n被锁在地底三年，对鲜血的渴望日益加深。\n哥哥于是命人四处搜罗东区落单的流浪汉、站街女，以此作为妹妹每日的「食物」。\n一时城内人心惶惶，警局倾巢出动，终于将兄妹二人抓捕归案。\n自此，震惊伦蒂尼恩城的「吸血鬼事件」终于告一段落。"
  },
  CollectionHall_57650_LockTip = {
    Text = "唤醒「雷娅」后解锁"
  },
  CollectionHall_57650_Title = {Text = "雷娅"},
  CollectionHall_57651_Desc = {
    Text = "<Title:简介>\n来自伦蒂尼恩东区的纺织女工。\n因感染融蚀，被雕塑家协会掳走并制成蜡像。\n「24」既是实验编号，也是她首次被确诊的人格数量。\n就在笔者记录的当下，其人格数量还在不断上涨。\n假以时日，由「24」们组成的王国必将人丁兴旺，蔚为壮观。"
  },
  CollectionHall_57651_LockTip = {
    Text = "通关特遣纪录「宁静的裂殖」解锁"
  },
  CollectionHall_57651_Title = {Text = "「24」"},
  CollectionHall_57652_Desc = {
    Text = "<Title:简介>\n生前和父亲感染融蚀，在一家人的痛苦中一直乖巧地忍受治疗。\n母亲因同时失去丈夫和女儿性情大变，在艾尔沃斯的勘探中误入提灯教会的仪式，偶然唤醒了莉莉。因异常唤醒，莉莉变成了木然的人偶，只有听到命令时才有动作。\n母亲因融蚀而遗忘了莉莉的形貌，将被唤醒的莉莉视为怪物不停进行实验，以期真正的女儿复活。\n最后跟随守密人前往弥萨格，将守密人称呼为母亲，非常依赖守密人。"
  },
  CollectionHall_57652_LockTip = {
    Text = "通关特遣纪录「故事的魔法」解锁"
  },
  CollectionHall_57652_Title = {Text = "莉莉"},
  CollectionHall_57653_Desc = {
    Text = "<Title:简介>\n罗杰斯的蜡像玩偶。\n\n和那些在车厢里大声喧哗的孩子一样，是个被宠坏的家伙。\n所仰仗的，不过是那双灰绿色的眼睛——它们是「蜡像先生」留给罗杰斯唯一的东西。\n曾在「24」的人工密境里遭遇不可违抗的力量，变成扁扁的乔治，成功激起了罗杰斯的怒气。"
  },
  CollectionHall_57653_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_57653_Title = {Text = "乔治"},
  CollectionHall_57654_Desc = {
    Text = "<Title:简介>\n莉莉安济贫院的孤儿，也是詹金最要好的伙伴。\n曾被雕塑家协会改造，又亲眼目睹其他孤儿惨死，为自己的幸存与缄默感到罪恶不已。\n最后从钟楼一跃跳下，获得了彻底的解脱。\n怀里总是抱着一只玩偶熊，她给它取名为「波比」。\n喜欢礼物、小裙子和金色的糖果。\n有点怕黑，总是抱着「波比」才敢入睡。如果你能为她唱一首摇篮曲，女孩将永远感激你、喜爱你。\n就像詹金曾经为她做过的那样。"
  },
  CollectionHall_57654_LockTip = {
    Text = "唤醒「艾继丝」后解锁"
  },
  CollectionHall_57654_Title = {Text = "艾继丝"},
  CollectionHall_57716_Desc = {
    Text = "<Title:简介>\n原本是痴迷于制作自动人偶的研究员，从达芙黛尔处得到了以银芯为核心的能源组件。\n因研究员好友对能源组件的觊觎，两人屡次争吵，最终在决裂般愤怒的抢夺中导致了实验室爆炸。不知为何在人偶的躯体中苏醒的她惊恐地意识到：在应当无生命的自动人偶中，除了她，还有另一个意识。\n她是怀着怎样的信念将好友从燃烧的废墟中救出，又是怀着怎样的信念走到郊外的，已经无人知晓。这位不为人知的机械天才就此从世上消失，只剩下一则关于爆炸的新闻，一地散落的零件，和一枚残存的银芯。\n从中唤醒的，又是怎样的存在？"
  },
  CollectionHall_57716_LockTip = {
    Text = "通关意识潜游「扭曲核心」解锁"
  },
  CollectionHall_57716_Title = {Text = "艾瑞卡"},
  CollectionHall_57717_Desc = {
    Text = "<Title:简介>\n@2的使者兼代行者，常常化作人形行走世间。\n一个纯粹的恶魔——没有未来、没有信念，没有理想。\n以欲望为饵，混乱为食，热衷欺骗、诱惑人类。\n擅长玩弄规则，与之签订契约的人类最后都赔得一干二净。\n最精明的律师都无法从祂身上讨到半分好处。\n偶尔会扮作孩童的模样，然而这并不会使人对祂放松警惕。\n毕竟祂的可怕之处远不在于皮相。"
  },
  CollectionHall_57717_LockTip = {
    Text = "通关特遣纪录「蔷薇礼赞」解锁"
  },
  CollectionHall_57717_Title = {Text = "「N」"},
  CollectionHall_57718_Desc = {
    Text = "<Title:简介>\n精神病医师，专攻癫痫、癔症以及焦虑失眠等疾病。\n擅长用催眠的方式引导患者吐露心声。\n相传她的患者都以各种颇具「艺术性」的自杀告终，但她总能在警察上门前变换身份，重新开张。\n许多名流都曾慕名前往她的诊所，被形容为「掌握了半个伦蒂尼恩城秘密的女人」。\n罗杰斯曾是她的长期客户——或许，他那反常的艺术激情也和这位医师脱不了干系？"
  },
  CollectionHall_57718_LockTip = {
    Text = "通关调查行动第1章「东区秘事」解锁"
  },
  CollectionHall_57718_Title = {
    Text = "克莱门汀"
  },
  CollectionHall_57719_Desc = {
    Text = "<Title:简介>\n追求卓越的蜡像师，罗杰斯蜡像馆现任馆长。\n幼年因口吃遭到排挤，曾被调侃「穷得只剩下钱了」。\n身居高位的父亲，精神错乱的母亲，再加上那起震惊全国的绑架案……\n在种种悲惨因素的作用下，罗杰斯不负众望地超越了他的母亲，成为斯卡伯勒首屈一指的疯子。\n雕塑家协会最受女士欢迎的成员，一位情绪极其稳定的绅士——只要不谈及艺术。"
  },
  CollectionHall_57719_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_57719_Title = {Text = "罗杰斯"},
  CollectionHall_57720_Desc = {
    Text = "<Title:简介>\n母亲是杰出的机修工，因技高价廉而备受欢迎。\n八岁时父亲出海再也没有回来，从此和母亲经营机修店铺相依为命，两人用攒下来的零件尝试制作独轮摩托，期待以后一起骑车冒险，完成母亲年轻时的梦想。\n十三岁时母亲因病去世，为了获得更多零件完成摩托而接下了报酬高昂的随船任务。\n船只返航时因风暴意外卷入大漩涡的涡流中，将船上唯一的潜水服让给好友后，握着母亲留下的鹦鹉螺挂坠死在了充满融蚀的水流中，只剩残骸和银芯在洋流中飘荡旅行。"
  },
  CollectionHall_57720_LockTip = {
    Text = "唤醒「诺缔拉」后解锁"
  },
  CollectionHall_57720_Title = {Text = "诺缔拉"},
  CollectionHall_58148_Desc = {
    Text = "<Title:简介>\n蹈海主祭豢养的小公主，亦被唤作「圣女」。\n自幼被娇养长大，是名副其实的淑女。手中的小阳伞既能保护白嫩的肌肤，也将一切不净不祥之物隔绝在外。\n即使她深知，自己也是某种「不祥」的产物——她的诞生并非自然规律，而是为了成为「母亲」，诞下预言之子。\n吃不完的糕点、最时新的洋装、无数围着她转的仆从……她穿梭在纷繁的物质世界里，将内心的惶惑不安紧紧封锁。\n这一尝试最终以失败告终，因为自由的心不接受任何妥协。"
  },
  CollectionHall_58148_LockTip = {
    Text = "唤醒「墨菲」后解锁"
  },
  CollectionHall_58148_Title = {Text = "墨菲"},
  CollectionHall_59454_Desc = {
    Text = "<Title:简介>\n来自某沿海渔村的小女孩，父母是远洋船员，与祖母相依为命，并天真地相信了祖母编造的童话故事——他们一家是亚特兰蒂斯的后裔，只要她乖乖长大，交到很多朋友，朋友们就会帮助她回到海底的故乡。\n祖母去世后，一家水族馆老板来收鱼时雇佣了开朗活泼的她作为讲解员，令她幸运地度过了多彩的童年。\n在融蚀的鱼类污染了整个水族馆后，水族馆宣布破产，失业的她将最喜爱的水母装进瓶子带回了偏僻的村庄，但很快融蚀也侵蚀了她，侵蚀了整个村庄……\n被唤醒后记忆有些混乱，坚信自己是所谓的“海底人”，并孜孜不倦地邀请朋友们去她的故乡参观。"
  },
  CollectionHall_59454_LockTip = {
    Text = "通关意识潜游「诸事如常」解锁"
  },
  CollectionHall_59454_Title = {Text = "奥瑞塔"},
  CollectionHall_59455_Desc = {
    Text = "<Title:简介>\n被誉为拥有「绝对好运」的男子。\n拥有这样的天赋，成为一名赌徒当然是顺理成章的事。\n可他同时又是一位还算优秀的侦探。\n不仅如此，他还是个穷光蛋，因为他总是能以最快的速度挥霍掉赢回的本金。\n矛盾、复杂。这便是我们对这位男子的全部评价。\n命运女神偏爱他，那位来历不明的「N」偏爱他，就连最抠门的酒馆老板也愿意给他一些折扣。\n所有人都偏爱他，他却从未因此停下步伐，而是开启新一轮的冒险游戏。\n他只偏爱未知。"
  },
  CollectionHall_59455_LockTip = {
    Text = "通关特遣纪录「狩猎愉快！」解锁"
  },
  CollectionHall_59455_Title = {Text = "莱克"},
  CollectionHall_59456_Desc = {
    Text = "<Title:简介>\n出生于一个没落贵族家庭，虽然天生患有严重哮喘，但一直被父母给予充足的关爱。\n由于病痛的折磨足不出户，经常浮现轻生的念头，父母为了缓解她的心情难得带她出了一趟远门，却意外让她染上融蚀。\n归乡后，父母满怀愧疚地将她送入疗养院，一边出海经商赚取医疗费，一边游历世界寻找治疗的方法。\n随着融蚀的侵袭，她的求死之心也愈发加重，但她心怀着拖累了父母的内疚，为了不让父母更加伤心而一直忍耐着对死亡与解脱的向往。\n接到父母在前来看望她的路上因船只失事溺亡的消息后，对人世再无牵挂的她于夜中悄然离开了疗养院，一步一步向着大海深处走去。\n海水淹没颅顶的那一刻，三角蚀痕滴落的黑液被冲散，沉疴已久的病体得到了难以言喻的解脱——这是第一次，也是她唯一一次得以顺畅地呼吸。"
  },
  CollectionHall_59456_LockTip = {
    Text = "唤醒「宁菲亚」后解锁"
  },
  CollectionHall_59456_Title = {Text = "宁菲亚"},
  CollectionHall_61045_LockTip = {
    Text = "通关调查行动8-1解锁"
  },
  CollectionHall_61045_Title = {
    Text = "A小调：终末交响曲"
  },
  CollectionHall_62183_Title = {
    Text = "08 终末交响曲"
  },
  CollectionHall_62184_Desc = {
    Text = "<Title:简介>\n享誉世界的指挥家与音乐家。尽管看上去年纪轻轻，但所指挥的交响乐演出早已巡回世界各地，每场演出都万人空巷。\n作为古典音乐界最负盛名的天才，哈姆林的任何私人信息都无人知晓，这引起了审查会的关注。他们在长久的调查中发现，哈姆林的演出场所与提灯教会的行动轨迹有着高度重合。\n在他们找到真相之前，真相主动找到了他们——在提灯教会对弥萨格的入侵事件中，哈姆林扮演了十分重要的角色。\n此时人们才明白，这位天才指挥家真正的舞台，从来都在剧场之外。"
  },
  CollectionHall_62184_LockTip = {
    Text = "通关调查行动第8章「终末交响曲」解锁"
  },
  CollectionHall_62184_Title = {Text = "哈姆林"},
  CollectionHall_65503_Title = {
    Text = "艾尔沃斯的归人"
  },
  CollectionHall_65509_Desc = {
    Text = "<Title:简介>\n来自东区的小混混，亦是「24」的妹妹。\n拥有三项独门绝技：偷鸡摸狗、吵架和见势不妙就开溜。\n任何人在她身上都讨不到半分好处。\n哦，对了。她还有一只名为「布朗」的小老鼠常伴其身。\n布朗成熟、稳重，与詹金的个性形成了良好的互补。\n因此，即使伦蒂尼恩东区总有饥寒交迫者烹煮老鼠的惨案，詹金也从未动过这方面的心思。"
  },
  CollectionHall_65509_LockTip = {
    Text = "通关调查行动第2章「以蜡像之名」解锁"
  },
  CollectionHall_65509_Title = {Text = "詹金"},
  CollectionHall_65602_Title = {
    Text = "狩猎愉快"
  },
  CollectionHall_67375_Title = {
    Text = "09 长梦尽时"
  },
  CollectionHall_70283_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70283_Title = {
    Text = "来自遗忘  <▼>"
  },
  CollectionHall_70542_LockTip = {
    Text = "需要通关限时角色活动「神王复苏：深海凝视」任一关卡"
  },
  CollectionHall_70542_Title = {
    Text = "神王复苏：深海凝视"
  },
  CollectionHall_70543_LockTip = {
    Text = "需要通关限时角色活动「欲海翻波：紊乱情欲」任一关卡"
  },
  CollectionHall_70543_Title = {
    Text = "欲海翻波：紊乱情欲"
  },
  CollectionHall_70544_LockTip = {
    Text = "需要通关限时角色活动「灵魂的牧人：圣堂之路」任一关卡"
  },
  CollectionHall_70544_Title = {
    Text = "灵魂的牧人：圣堂之路"
  },
  CollectionHall_70545_LockTip = {
    Text = "需要通关限时角色活动「燃烧的群宴：湖中之城」任一关卡"
  },
  CollectionHall_70545_Title = {
    Text = "燃烧的群宴：湖中之城"
  },
  CollectionHall_70546_LockTip = {
    Text = "需要通关限时角色活动「群星正位：黑暗子宫」任一关卡"
  },
  CollectionHall_70546_Title = {
    Text = "群星正位：黑暗子宫"
  },
  CollectionHall_70547_LockTip = {
    Text = "需要通关限时角色活动「万象门扉：最终测试」任一关卡"
  },
  CollectionHall_70547_Title = {
    Text = "万象门扉：最终测试"
  },
  CollectionHall_70548_LockTip = {
    Text = "需要通关限时角色活动「多重疗愈：记忆编码」任一关卡"
  },
  CollectionHall_70548_Title = {
    Text = "多重疗愈：记忆编码"
  },
  CollectionHall_70549_LockTip = {
    Text = "需要通关限时角色活动「雪山消融之时：野兽雄心」任一关卡"
  },
  CollectionHall_70549_Title = {
    Text = "雪山消融之时：野兽雄心"
  },
  CollectionHall_70550_LockTip = {
    Text = "需要通关限时角色活动「无形交响：轰鸣之音」任一关卡"
  },
  CollectionHall_70550_Title = {
    Text = "无形交响：轰鸣之音"
  },
  CollectionHall_70551_LockTip = {
    Text = "需要通关限时角色活动「与蔷薇书：蔷薇忆事」任一关卡"
  },
  CollectionHall_70551_Title = {
    Text = "与蔷薇书：蔷薇忆事"
  },
  CollectionHall_70552_LockTip = {
    Text = "需要通关限时角色活动「沉渊之祀：神国诞临」任一关卡"
  },
  CollectionHall_70552_Title = {
    Text = "沉渊之祀：神国诞临"
  },
  CollectionHall_70553_LockTip = {
    Text = "需要通关限时角色活动「故事的魔法：剧本迷思」任一关卡"
  },
  CollectionHall_70553_Title = {
    Text = "故事的魔法：剧本迷思"
  },
  CollectionHall_70554_LockTip = {
    Text = "需要通关限时角色活动「名侦探手册：月夜传说」任一关卡"
  },
  CollectionHall_70554_Title = {
    Text = "名侦探手册：月夜传说"
  },
  CollectionHall_70555_LockTip = {
    Text = "需要通关限时角色活动「在春天凋零以前：花园往事」任一关卡"
  },
  CollectionHall_70555_Title = {
    Text = "在春天凋零以前：花园往事"
  },
  CollectionHall_70839_Desc = {
    Text = "<Title:简介>\n谄媚，市侩，虚伪。莉莉安济贫院的院长如同一个笨拙的演员，在伦蒂尼恩的名利场上饰演一位卑微的乞讨者。\n她四处奔波，用蠢笨的奉承从名流们指缝中求来一些零碎钱，以此维持济贫院艰难的运转。她将嘲笑与谩骂独自咽下，用柔软的歌声哄济贫院的孩子们入睡。\n伦蒂尼恩抛弃了他们，但莉莉安济贫院没有。莎拉做好了准备，将要尽自己的所能去保护这些孩子，让他们在伦蒂尼恩的迷雾与寒风中顺利地活下去。\n但她卑微的理想失败了，她与孩子们死在了雕塑家协会的阴谋里。对雕塑家协会而言，她与她所珍视的孩子们，是那宏伟的大厦中不值一提的砂砾，既欠奉价值，更缺乏美感。他们的生无关轻重，他们的死不足挂齿。\n她燃尽了自己的一切。那火光迅速熄灭，只剩伦蒂尼恩的风依旧冰寒彻骨。"
  },
  CollectionHall_70839_LockTip = {
    Text = "通关第一章解锁"
  },
  CollectionHall_70839_Title = {Text = "莎拉"},
  CollectionHall_70884_Desc = {
    Text = "<Title:A.F.185>\n各国代表在康斯坦联邦签订《密斯底亚协定》，决定共同合作，抵抗灾厄，压制融蚀裂隙。同时各国就隐藏灾厄存在、隐瞒融蚀现象的保密方针达成共识。\n本次协定决定，学院保持独立，不为任一国家所有，在各国有权建立分部，有权与各国领导直接沟通，有权获取各国灾厄和融蚀相关的信息。\n弥萨格正式成为一个完全中立的跨国组织。\n\n<Title:A.F.186>\n参与协定修订和签署的人员在密斯底亚成立了常驻审查会，审查会拥有自己的行动队，以确保协定的实施。密室会议成立，基本确立了组织架构。\n\n<Title:A.F.187>\n弥萨格学院正式更名为弥萨格大学。\n之后的时间里，融蚀现象发生得越来越频繁，规模也越变越大。弥萨格大学站在第一线，成为人类对抗融蚀的中流砥柱。"
  },
  CollectionHall_70884_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70884_Title = {
    Text = "A.F.185—187"
  },
  CollectionHall_70885_Desc = {
    Text = "<Title:A.F.75>\n阿利斯泰尔预见了巨大裂隙在雷欧王国境内的出现，华德带领调查员前往应对。诸多调查员在此次事故中牺牲。\n\n<Title:A.F.77>\n裂隙无法关闭，但逐渐趋于稳定。在政府的配合与支持下，华德在巨大裂隙之上兴建「真理之视」的驻地。\n巨大裂隙正式编号为L-01，别名「黑池」。\n\n<Title:A.F.88>\n「黑池」突发异变并向外扩散，此时已经处于周边地区的「真理之视」损失惨重，华德也在应对过程中负伤。\n由于黑池无法关闭，塔薇沉入其中亲自镇守，维持了黑池的暂时稳定。\n\n<Title:A.F.90>\n「真理之视」驻地扩建，弥萨格学院成立，华德为首任院长。\n至此，人们开始系统性培养拥有足够精神力的调查员，以更好地抵抗愈演愈烈的融蚀危机。\n\n<Title:A.F.92>\n华德于黑池事件中所受的伤进一步恶化，并因此身亡。\n华德的残骸埋在学院内，墓碑造型为一把钥匙，开启了弥大钥匙塚的传统。\n死后析出的银芯由阿利斯泰尔亲手制成银钥匙，赋予编号K-0001，此后阿利斯泰尔成为初代守密人，在外界活跃。\n同年，为了寻求救治华德方法而前往勒姆瓦希进行调查的刻拉尔克什失踪，从此下落不明。"
  },
  CollectionHall_70885_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70885_Title = {
    Text = "A.F.75—92"
  },
  CollectionHall_70886_Desc = {
    Text = "<Title:A.F.306>\n赫伯特收取格林基金会的资金，在提灯教会的帮助下建立雕塑家协会。\n同年，朵尔入学弥萨格。作为天才学者，朵尔甫一加入便直接参与到研究生及博士进行的研究中，并在随后的日子里极大地推动了弥萨格的银芯科技发展。\n\n<Title:A.F.307>\n赫伯特与提灯教会袭击弥萨格，试图找回提灯教会当年被调包的「圣女」。\n\n<Title:A.F.309>\n某融蚀事件的幸存者威廉在调查员芬戈尔的引荐下加入弥萨格。\n\n<Title:A.F.310>\n弥萨格大学联合审查会，在雕塑家协会能够进一步壮大之前，将其大部分成员抓捕归案。赫伯特及数个核心成员逃脱，转入地下工作。此后，赫伯特找上罗杰斯，展开协作。\n同年，萨尔瓦多继任大圣堂区主教，诃勒特担任代理院长。\n\n<Title:A.F.313>\n在赫伯特的授意下，罗杰斯向莉莉安济贫院捐款，成为了济贫院的唯一资助人。\n\n<Title:A.F.314>\n阿库特大爆炸发生。\n在阿利斯泰尔的派遣下，威廉和拉蒙娜前往阿库特，在爆炸后的遗迹中找到失去全部记忆的@3，将其带回弥萨格，进行特殊训练。"
  },
  CollectionHall_70886_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70886_Title = {
    Text = "A.F.306—314"
  },
  CollectionHall_70887_Desc = {
    Text = "<Title:A.F.263>\n弗朗西斯出生。\n\n<Title:A.F.289>\n失去女儿后，弗朗西斯加入科考队，前往艾尔沃斯。\n同年，探险队全员覆没。\n\n<Title:A.F.290>\n罗杰斯出生。\n同年，于艾尔沃斯意外召唤出莉莉后，弗朗西斯来到拉伊，在基金会的帮助下建立了精神病院，并搭建了一个停滞的时空。\n\n<Title:A.F.292>\n朵尔出生。\n\n<Title:A.F.297>\n赫伯特作为新生入学弥萨格，时年17岁。\n\n<Title:A.F.298>\n提灯使用双生圣子进行降神仪式。德克斯特潜入仪式中，偷偷将即将被作为神诞之躯的拉蒙娜带走，阻止了提灯的仪式。\n仪式宣告失败。拉蒙娜成为德克斯特养女。\n\n<Title:A.F.300>\n罗杰斯被「蜡像」绑架。后「蜡像」死亡，罗杰斯获救。\n同年，萨尔瓦多被当时的大圣堂区主教唤醒，作为助理神父在大圣堂区服务。\n\n<Title:A.F.304>\n诃勒特作为新生入学弥萨格。\n\n<Title:A.F.305>\n弥萨格大学唤醒体系学生赫伯特违规制造实验体，行为暴露后，赫伯特杀死自己的导师克劳利后逃离，时年25岁。"
  },
  CollectionHall_70887_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70887_Title = {
    Text = "A.F.263—305"
  },
  CollectionHall_70888_Desc = {
    Text = "<Title:B.F.？？？>\n席卷全球的灾难摧毁了大片陆地。地震、洪水、磁场紊乱、气候异常等接二连三，城市与聚落沉入水中，原本深埋海底的坚石成了新的山峰。人类文明受到重创。\n\n<Title:A.F.0>\n旧的土地被海水淹没，新的土地浮出水面。\n在这彻底改变了面貌的世界中，人们摒弃了旧日历法，携带文明的残骸艰难重建，迈入全新的纪元：洪积。"
  },
  CollectionHall_70888_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70888_Title = {
    Text = "B.F.？？？—A.F.0"
  },
  CollectionHall_70889_Desc = {
    Text = "<Title:A.F.55>\n刻拉尔克什凭借自己的调查等方式主动找到银钥密会，并成功加入其中，希望能够借密会的力量帮助人类重建。\n同年，刻拉尔克什注意到华德与塔薇的行动，开始关注其动向。\n\n<Title:A.F.58>\n刻拉尔克什制作出一次性的银钥匙，成为新一任密会领袖：钥匙匠，并开始利用密会悄悄将知识扩散出去，帮助人类重建。\n同年，刻拉尔克什与华德、塔薇接触，承诺给予华德一定资金和人力方面的帮助。\n\n<Title:A.F.62>\n阿利斯泰尔·欧文斯出生于伦蒂尼恩郊区一个普通的乡村医生家庭。\n\n<Title:A.F.64>\n完成调查的刻拉尔克什认可华德的追求，面对不愿意被密会规则束缚的华德，双方在塔薇的建议与见证下达成平等的合作关系。\n获得密会资金和人力等方面的帮助后，华德的研究更进一步，确认了融蚀的特点、融蚀与异变体之间的关系，并初步总结了融蚀侵蚀的不同阶段特征。\n\n<Title:A.F.65>\n刻拉尔克什、华德、塔薇，与数位密会成员共同组成了第一支以追查融蚀、阻止融蚀扩散为己任的调查员小队，并将其命名为「真理之视」。\n\n<Title:A.F.70>\n华德再次总结融蚀及融蚀侵蚀的特点和规律，初次记录下融蚀的区域性特征，并写成《融蚀与融蚀规律初考》，供新加入调查队的成员翻阅使用。\n\n<Title:A.F.72>\n华德于一家因融蚀而破灭的家庭中救下阿利斯泰尔，将其收为学生。\n同年，华德及其手下的「真理之视」规模逐渐扩张，引起了当局的注意。"
  },
  CollectionHall_70889_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70889_Title = {
    Text = "A.F.55—72"
  },
  CollectionHall_70890_Desc = {
    Text = "<Title:A.F.30>\n华德·菲利普斯出生于亚格罗共和国东部的古老城市沙洛姆的一个富商家庭。\n\n<Title:A.F.38>\n刻拉尔克什出生。出生后不久其父母便亡故，与姐姐相依为命，挣扎求生。\n\n<Title:A.F.48>\n华德从小展露出化学物理方面的天赋，于18岁考入莫斯伟图塞州立大学化学系，成为著名化学家纳撒尼尔·弥尔顿的学生。\n\n<Title:A.F.50>\n华德的祖父老罗杰·菲利普斯神父离世，随后其父亲失踪。华德到祖宅调查，并追随父亲的步伐抵达雷欧王国，在这里发现了家族隐藏多年的秘密——一个在猎巫时期从异教徒（银钥密会）手上夺得的神秘配方。\n古老的配方记载在一张羊皮纸卷上，其中有不少部分损毁了，华德经过多年实验将其勉强补全。\n\n<Title:A.F.53>\n根据补全的配方，华德成功做出第一把银钥匙。由于配方上的缺陷，这把银钥匙使用一次就毁坏了，无法再次使用。\n无论如何，凭借这把一次性的银钥匙，华德面见了智之质体的代行者塔薇，从塔薇处得知了世界即将面临「漆黑的灾难」。\n决心阻止灾难，华德与塔薇达成了一致，与塔薇进行链接，获得了唤醒体制作方法以及完整的银钥匙配方。\n接下来的时间内，华德四处行走，研究融蚀及裂隙并为其命名，试图找到抵御融蚀的方法。"
  },
  CollectionHall_70890_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70890_Title = {
    Text = "A.F.30—53"
  },
  CollectionHall_70891_Desc = {
    Text = "经过为期一年的预科学习与训练，@3正式继任守密人，开始带领唤醒体与其他校内力量进行融蚀相关事件调查。\n同年，提灯教会联合弥校内鬼再次入侵弥萨格，引发黑池动荡，开启穷极之门，吸引无上意志投来目光。\n在卡达斯即将被融蚀吞噬之时，@3吸收三质体之权柄，在门扉内与无上意志的目光对决。\n最终，无上意志再度沉睡，卡达斯获救。\n@3殉身。\n因其所有相关记录将被融蚀，无法保留，弥萨格决定破例将其生前所使用的银钥封存，存于校史纪念馆，用以纪念其功绩。\n%hisorher%名字无人知晓，但K-0617这个编号，将与世长存。"
  },
  CollectionHall_70891_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_70891_Title = {Text = "A.F.315"},
  CollectionHall_71007_Desc = {
    Text = "灵识的潮水推来亘古的余波，寄宿于银芯的魂灵倒映出高维意志的投影。"
  },
  CollectionHall_71007_Title = {
    Text = "灵识潮涌"
  },
  CollectionHall_71008_Desc = {
    Text = "先驱者殒身于此，调查员仍风尘仆仆，存续之路永无止境。"
  },
  CollectionHall_71008_Title = {
    Text = "待续尘旅"
  },
  CollectionHall_71009_Desc = {
    Text = "银质六翼的使者跨越存在之扉降临于黑池，带来原初的指引与真理的讯息。"
  },
  CollectionHall_71009_Title = {
    Text = "跨越门扉而来"
  },
  CollectionHall_71010_Desc = {
    Text = "来自异界的侵袭者，以倒悬之三角，在清醒世界散播死亡和黯影。"
  },
  CollectionHall_71010_Title = {
    Text = "危机奏鸣"
  },
  CollectionHall_71011_Desc = {
    Text = "弥萨格师生的过去与未来安葬于此。"
  },
  CollectionHall_71011_Title = {
    Text = "雨落钥冢"
  },
  CollectionHall_71012_Desc = {
    Text = "存续之理，存续之望，寄宿于银钥一闪。\n传承者于此刻下碑铭，追索者于此立下誓言。"
  },
  CollectionHall_71012_Title = {
    Text = "存续之望"
  },
  CollectionHall_71013_Desc = {
    Text = "关于银芯的研究，唤醒来自高位的灵。\n那是自融蚀降临后，人类最后的希望。"
  },
  CollectionHall_71013_Title = {
    Text = "唤醒之灵"
  },
  CollectionHall_71014_Desc = {
    Text = "黑夜的步伐追逐于探索者之后——那阴影在朦胧微明的光域中被拉得更长。"
  },
  CollectionHall_71014_Title = {
    Text = "忘却前夜"
  },
  CollectionHall_71015_Desc = {
    Text = "先行者们开辟道路，后继者们传承求索。银芯仪表的光芒不曾衰退，弥萨格人的探求亦不会停止。"
  },
  CollectionHall_71015_Title = {
    Text = "传承求索之途"
  },
  CollectionHall_71016_Desc = {
    Text = "于最后的时日迫近之前，在尚未被遗忘的伦蒂尼恩，揭开名为铭刻的序幕。"
  },
  CollectionHall_71016_Title = {
    Text = "来自遗忘"
  },
  CollectionHall_71017_Desc = {
    Text = "黏稠的黑水侵蚀现实认知，时间之潮滚滚而逝，故事流淌之处，记忆与存在化作虚无。"
  },
  CollectionHall_71017_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71017_Title = {
    Text = "黑潮吞侵之境"
  },
  CollectionHall_71018_Desc = {
    Text = "隐秘与真理星罗棋布，呼唤弥萨格学子一步一个脚印的勘探。"
  },
  CollectionHall_71018_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71018_Title = {
    Text = "远旅勘察之行"
  },
  CollectionHall_71019_Desc = {
    Text = "狭路相逢勇者胜。"
  },
  CollectionHall_71019_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71019_Title = {
    Text = "狭路相逢"
  },
  CollectionHall_71020_Desc = {
    Text = "身为弥萨格百年一遇的守密人，你的任务可不是在街头替东区的孩子们进行学前教育。"
  },
  CollectionHall_71020_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71020_Title = {
    Text = "街头冲突"
  },
  CollectionHall_71021_Desc = {
    Text = "被困在浓雾中的，又何止弥萨格的调查员。"
  },
  CollectionHall_71021_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71021_Title = {
    Text = "雾夜囹圄之旅"
  },
  CollectionHall_71022_Desc = {
    Text = "陷入冲突，陷入癫狂。让躁动的灵魂，倾泻狂热的悲啸吧。"
  },
  CollectionHall_71022_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71022_Title = {
    Text = "癫欲疾走"
  },
  CollectionHall_71023_Desc = {
    Text = "迫近、迫近、迫近。"
  },
  CollectionHall_71023_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71023_Title = {
    Text = "强压威胁"
  },
  CollectionHall_71024_Desc = {
    Text = "这是宣泄，是解放，是凶暴的战吼，是癫狂的困兽。"
  },
  CollectionHall_71024_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71024_Title = {
    Text = "狂暴袭击"
  },
  CollectionHall_71025_Desc = {
    Text = "在逆境中多坚持一分钟吧，下一秒就是你的胜局。"
  },
  CollectionHall_71025_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71025_Title = {
    Text = "坚韧斗志"
  },
  CollectionHall_71026_Desc = {
    Text = "伦蒂尼恩的雾气深沉浓稠，终年不散。"
  },
  CollectionHall_71026_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71026_Title = {
    Text = "雾夜之战"
  },
  CollectionHall_71027_Desc = {
    Text = "真理隐于门扉之内，仅在「祂」呼吸的瞬息间得以一窥轻纱后的真容。\nA.F.315  银钥编号K-0617  银扉初启"
  },
  CollectionHall_71027_Title = {
    Text = "银钥初启之扉"
  },
  CollectionHall_71028_Desc = {
    Text = "蜡像馆的规则有三条，第一，不可触碰蜡像；第二，不可揭开蜡像的盖布；第三，不可将血滴到蜡像馆里。千万，千万不要违反它们哦。"
  },
  CollectionHall_71028_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71028_Title = {
    Text = "恐怖蜡像之馆"
  },
  CollectionHall_71029_Desc = {
    Text = "在梦幻的夜里，来自万古的存在苏醒，祂的呼吸流溢，些微鼻息足以撼动大地。"
  },
  CollectionHall_71029_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71029_Title = {
    Text = "幻夜永劫"
  },
  CollectionHall_71030_Desc = {
    Text = "当四周逐渐阴沉暗淡，理性悄然隐没了光线，希望的火烛摇曳欲熄，我在孤独中徘徊茫然。"
  },
  CollectionHall_71030_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71030_Title = {
    Text = "幽深暗室"
  },
  CollectionHall_71031_Desc = {
    Text = "暗影中潜藏之物，闪烁着幽绿的眼。"
  },
  CollectionHall_71031_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71031_Title = {
    Text = "暗影伏击"
  },
  CollectionHall_71032_Desc = {
    Text = "保持冷静，保持警惕，保持思考。"
  },
  CollectionHall_71032_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71032_Title = {
    Text = "冷静忖度"
  },
  CollectionHall_71033_Desc = {
    Text = "钢铁是工业的骨骼，蒸汽是科技的呼吸。永不枯竭的蒸汽，在时代的肺叶里燃烧。"
  },
  CollectionHall_71033_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71033_Title = {
    Text = "蒸汽空间"
  },
  CollectionHall_71034_Desc = {
    Text = "在本当万籁俱寂的夜晚，聆听钢铁的咆哮。"
  },
  CollectionHall_71034_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71034_Title = {
    Text = "钢铁躁动"
  },
  CollectionHall_71035_Desc = {
    Text = "星河流淌，浩夜无垠。瀚海回音，幻流奔涌。"
  },
  CollectionHall_71035_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71035_Title = {
    Text = "星河浩夜"
  },
  CollectionHall_71036_Desc = {
    Text = "死兆星已在你的头顶闪耀。"
  },
  CollectionHall_71036_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71036_Title = {
    Text = "恶兆预感"
  },
  CollectionHall_71037_Desc = {
    Text = "在启程之前，学子们已在钥冢中葬下遥远的未来。清澈的觉悟，迎向死亡的浪潮。"
  },
  CollectionHall_71037_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71037_Title = {
    Text = "献身之志"
  },
  CollectionHall_71038_Desc = {
    Text = "人偶和人偶手牵手。他们一起跳舞，他们是好朋友。"
  },
  CollectionHall_71038_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71038_Title = {
    Text = "人偶之舞"
  },
  CollectionHall_71039_Desc = {
    Text = "她很喜欢推开钟楼的天窗，和伙伴们一起仰望温柔明亮的月亮。"
  },
  CollectionHall_71039_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71039_Title = {
    Text = "雾中的月亮"
  },
  CollectionHall_71040_Desc = {
    Text = "老查理有一只他很爱很爱的虎斑猫。"
  },
  CollectionHall_71040_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71040_Title = {
    Text = "老查理与他的虎斑猫"
  },
  CollectionHall_71041_Desc = {
    Text = "逃得出手术台，逃得出济贫院吗？逃得出浓雾，又逃得出贫困的东区吗？孩子们无路可逃。"
  },
  CollectionHall_71041_LockTip = {
    Text = "完成调查行动·困难1-8解锁"
  },
  CollectionHall_71041_Title = {
    Text = "天真的逃亡"
  },
  CollectionHall_71042_Desc = {
    Text = "雾越来越浓了。啊，让人窒息的雾。"
  },
  CollectionHall_71042_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71042_Title = {
    Text = "雾气重重"
  },
  CollectionHall_71043_Desc = {
    Text = "自那之后，她的眼睛只能注视天空，她的心事只能对月亮说。"
  },
  CollectionHall_71043_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71043_Title = {
    Text = "艾继丝的心事"
  },
  CollectionHall_71044_Desc = {
    Text = "济贫院午夜，突如其来的浓雾之中，窥伺者们睁开猩红的眼睛。"
  },
  CollectionHall_71044_LockTip = {
    Text = "完成调查行动1-15解锁"
  },
  CollectionHall_71044_Title = {
    Text = "起雾时刻"
  },
  CollectionHall_71045_Desc = {
    Text = "纸片上画着金色的蝴蝶，皱褶的边缘被人用心压平叠好，甚至还带有糖果的甜香。"
  },
  CollectionHall_71045_LockTip = {
    Text = "完成调查行动·困难1-8解锁"
  },
  CollectionHall_71045_Title = {
    Text = "飘落的糖纸"
  },
  CollectionHall_71046_Desc = {
    Text = "臃肿古怪的飞鸟撑开钟楼的屋顶，在飞向遥不可及的太阳之前坠落于地。"
  },
  CollectionHall_71046_LockTip = {
    Text = "完成调查行动·困难1-8解锁"
  },
  CollectionHall_71046_Title = {
    Text = "钟楼飞鸟"
  },
  CollectionHall_71047_Desc = {
    Text = "它们狂舞，它们高歌，它们渴食血肉，它们已经复活。"
  },
  CollectionHall_71047_LockTip = {
    Text = "完成调查行动·困难2-11解锁"
  },
  CollectionHall_71047_Title = {
    Text = "扭曲融解"
  },
  CollectionHall_71048_Desc = {
    Text = "大大的决心装进小小的身体。向前奔跑吧，带着她的自由与希望。"
  },
  CollectionHall_71048_LockTip = {
    Text = "完成调查行动·困难2-11解锁"
  },
  CollectionHall_71048_Title = {
    Text = "鼠鼠的勇气"
  },
  CollectionHall_71049_Desc = {
    Text = "它们皮肤细腻，它们眼珠灵活，它们笑容灿烂。欢迎，欢迎新朋友。"
  },
  CollectionHall_71049_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71049_Title = {
    Text = "蜡像馆之夜"
  },
  CollectionHall_71050_Desc = {
    Text = "蜡像偶尔的移位属于馆内正常现象，如果听到脚步声，请及时回头；如果感到有人已贴在你的背后，请千万别回头。"
  },
  CollectionHall_71050_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71050_Title = {
    Text = "凝固的面容"
  },
  CollectionHall_71051_Desc = {
    Text = "烛火哔啵，皮鞭噼啪，欢迎加入潘狄娅的派对，请跟上游戏的鼓点，迎接甜蜜的奖励。"
  },
  CollectionHall_71051_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71051_Title = {
    Text = "甜蜜游戏"
  },
  CollectionHall_71052_Desc = {
    Text = "别动呀，让我给你画上最美的笑容。"
  },
  CollectionHall_71052_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71052_Title = {Text = "塑像师"},
  CollectionHall_71053_Desc = {
    Text = "展台空荡荡，它们等待着你。"
  },
  CollectionHall_71053_LockTip = {
    Text = "完成调查行动·困难2-11解锁"
  },
  CollectionHall_71053_Title = {
    Text = "浇筑之时"
  },
  CollectionHall_71054_Desc = {
    Text = "他们曾是佣人、平民，甚至贵族。过去他们素不相识，现在他们手挽着手，共同扮演幸福的喜剧。"
  },
  CollectionHall_71054_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71054_Title = {
    Text = "情景扮演"
  },
  CollectionHall_71055_Desc = {
    Text = "从蜡像中爬出一位美丽的小姐、一位恐惧的小姐、一位怯懦的小姐、一位疯狂的小姐。别误会，她们都是同一位小姐。"
  },
  CollectionHall_71055_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71055_Title = {Text = "24小姐"},
  CollectionHall_71056_Desc = {
    Text = "那一步，是她永远不能迈过的天堑。"
  },
  CollectionHall_71056_LockTip = {
    Text = "完成意识潜游「一步之遥」"
  },
  CollectionHall_71056_Title = {
    Text = "一步之遥"
  },
  CollectionHall_71057_Desc = {
    Text = "祂的突袭疾如猛火，祂的锋刃锐不可当。"
  },
  CollectionHall_71057_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71057_Title = {
    Text = "疾速进攻"
  },
  CollectionHall_71058_Desc = {
    Text = "请来夜晚的花园吧，嘘，这是蔷薇与你的秘密约会。"
  },
  CollectionHall_71058_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71058_Title = {
    Text = "蔷薇的秘密"
  },
  CollectionHall_71059_Desc = {
    Text = "这是剧目的高潮，这是渺小的狂想。\n让乐团激昂奏响，即便我今晚就要凋亡。\n要尽情唱到最后一场。"
  },
  CollectionHall_71059_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」困难难度"
  },
  CollectionHall_71059_Title = {
    Text = "末路狂想"
  },
  CollectionHall_71060_Desc = {
    Text = "父亲的目光如同烛火，曾明亮地注视着她，她便也欺骗自己那足够温暖。\n直到那火终于熄灭，她才看到那不过是一团丑陋的蜡块，而那目光的温度早已冷却在遥远的回忆中了。"
  },
  CollectionHall_71060_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71060_Title = {
    Text = "冷却的注视"
  },
  CollectionHall_71061_Desc = {
    Text = "杀意如影随形，死亡高悬于顶。\n快些逃吧，如果你还有机会。"
  },
  CollectionHall_71061_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71061_Title = {
    Text = "死亡之舞"
  },
  CollectionHall_71062_Desc = {
    Text = "纷飞，致最华丽的谢幕。"
  },
  CollectionHall_71062_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71062_Title = {
    Text = "花瓣飘然飞落"
  },
  CollectionHall_71063_Desc = {
    Text = "一位未被邀请的客人，跟在你的影子后。"
  },
  CollectionHall_71063_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71063_Title = {
    Text = "幽魂缀行"
  },
  CollectionHall_71064_Desc = {
    Text = "有一双眼眸，隔着珠帘把你凝望。"
  },
  CollectionHall_71064_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71064_Title = {
    Text = "拨开珠玉之帘"
  },
  CollectionHall_71065_Desc = {
    Text = "那身影孤单，那歌声寂寥。\n在这幽静无人的晚上。"
  },
  CollectionHall_71065_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  CollectionHall_71065_Title = {
    Text = "蔷薇序幕"
  },
  CollectionHall_71066_Desc = {
    Text = "这段隐秘的故事暗流汹涌，无人听闻。\n但愿从今往后，你我永不忘怀。"
  },
  CollectionHall_71066_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」困难难度"
  },
  CollectionHall_71066_Title = {Text = "心声"},
  CollectionHall_71067_Desc = {
    Text = "瞩目吧，歌颂吧。\n这盛大的金红，占满瞳孔。"
  },
  CollectionHall_71067_LockTip = {
    Text = "完成特遣纪录「蔷薇礼赞」困难难度"
  },
  CollectionHall_71067_Title = {
    Text = "蔷薇礼赞"
  },
  CollectionHall_71068_Desc = {
    Text = "布局于指令流转之间，制胜于瞬息决弈之内。"
  },
  CollectionHall_71068_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71068_Title = {
    Text = "决弈时刻"
  },
  CollectionHall_71069_Desc = {
    Text = "自外而来的磁流，干扰当前相位的思绪。"
  },
  CollectionHall_71069_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71069_Title = {
    Text = "相位磁流"
  },
  CollectionHall_71070_Desc = {
    Text = "货源充沛，期待您的选购。"
  },
  CollectionHall_71070_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71070_Title = {
    Text = "偷闲一刻"
  },
  CollectionHall_71071_Desc = {
    Text = "无底的黑渊撕开利口，在一眼的凝望间，将求索者的理智骤然吞下。"
  },
  CollectionHall_71071_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71071_Title = {
    Text = "深蚀恐惧"
  },
  CollectionHall_71072_Desc = {
    Text = "这里是垂直线构筑的无光世界，执着的探索者以精密仪器推开纯黑的池水，窥视门扉之内的虚影。"
  },
  CollectionHall_71072_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71072_Title = {
    Text = "无光虚影"
  },
  CollectionHall_71073_Desc = {
    Text = "太古的梦境因到访者的战意，颤抖、战栗、坍塌。"
  },
  CollectionHall_71073_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71073_Title = {
    Text = "坍塌幻梦"
  },
  CollectionHall_71074_Desc = {
    Text = "梦是现实的载体，祂的长梦是弥萨格窥知世界秘辛的通道。\n就此潜入仪式构建的幻梦，探索深梦的隐秘。"
  },
  CollectionHall_71074_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71074_Title = {
    Text = "潜入深梦"
  },
  CollectionHall_71075_Desc = {
    Text = "弥萨格调查员的探照灯照不穿融蚀之墟的烟尘，但勘探与搜集之路不会就此中止。\n那是自融蚀降临后，人类最后的希望。"
  },
  CollectionHall_71075_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71075_Title = {
    Text = "墟烬烟尘"
  },
  CollectionHall_71076_Desc = {
    Text = "人类的点滴抗争，在精密的螺纹仪和平稳燃烧的酒精灯间流转。"
  },
  CollectionHall_71076_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71076_Title = {
    Text = "求索之途"
  },
  CollectionHall_71077_Desc = {
    Text = "做一场不用醒来的好梦吧。"
  },
  CollectionHall_71077_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71077_Title = {
    Text = "未完结的童话"
  },
  CollectionHall_71078_Desc = {
    Text = "在无明晨空苏醒的新星，庆贺着得来不易的胜局。"
  },
  CollectionHall_71078_LockTip = {
    Text = "完成调查行动2-16解锁"
  },
  CollectionHall_71078_Title = {
    Text = "新星冉升"
  },
  CollectionHall_71079_Desc = {
    Text = "旋转，跳跃，让观众看到你卖力的汗水！"
  },
  CollectionHall_71079_LockTip = {
    Text = "完成特遣纪录「故事的魔法」困难难度"
  },
  CollectionHall_71079_Title = {
    Text = "决斗舞曲"
  },
  CollectionHall_71080_Desc = {
    Text = "乌云终将被照彻黑夜的曦光驱散，鱼背上载来了充满希望的明天。\n美好的故事到此继续。"
  },
  CollectionHall_71080_LockTip = {
    Text = "完成特遣纪录「故事的魔法」困难难度"
  },
  CollectionHall_71080_Title = {
    Text = "天光洒落"
  },
  CollectionHall_71081_Desc = {
    Text = "神奇的幻想世界缓缓打开了门扉。"
  },
  CollectionHall_71081_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71081_Title = {
    Text = "美梦伊始"
  },
  CollectionHall_71082_Desc = {
    Text = "故事的英雄主角们迈着威武的步伐走入了片场，准备接受制裁吧，坏蛋们！"
  },
  CollectionHall_71082_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71082_Title = {
    Text = "英雄登场"
  },
  CollectionHall_71083_Desc = {
    Text = "美好的故事总免不了一些滑稽的意外。"
  },
  CollectionHall_71083_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71083_Title = {
    Text = "糟糕！事情不妙"
  },
  CollectionHall_71084_Desc = {
    Text = "演员请就位，放轻松，别眨眼，好戏马上开场。"
  },
  CollectionHall_71084_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71084_Title = {
    Text = "3，2，1，开始"
  },
  CollectionHall_71085_Desc = {
    Text = "好主意还是坏点子？"
  },
  CollectionHall_71085_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71085_Title = {
    Text = "皮匠开会"
  },
  CollectionHall_71086_Desc = {
    Text = "快快快，开动你聪明的小脑瓜想办法！"
  },
  CollectionHall_71086_LockTip = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  CollectionHall_71086_Title = {
    Text = "手忙脚乱"
  },
  CollectionHall_71087_Desc = {
    Text = "前进，前进，一切都在剧本的安排之中。"
  },
  CollectionHall_71087_LockTip = {
    Text = "完成特遣纪录「故事的魔法」困难难度"
  },
  CollectionHall_71087_Title = {
    Text = "特别行动"
  },
  CollectionHall_71088_Desc = {
    Text = "梦的开始总是在相同的地方。"
  },
  CollectionHall_71088_LockTip = {
    Text = "完成意识潜游「一步之遥」"
  },
  CollectionHall_71088_Title = {
    Text = "回环之梦"
  },
  CollectionHall_71089_Desc = {
    Text = "这是第几次循环？她早就已经记不清了。不过，那么，就当它是第一千次吧。"
  },
  CollectionHall_71089_LockTip = {
    Text = "完成意识潜游「一步之遥」"
  },
  CollectionHall_71089_Title = {
    Text = "第一千次诀别"
  },
  CollectionHall_71090_Desc = {
    Text = "阳光流泻，微风轻语。恬静而悠闲的，弥萨格日复一日的午后。"
  },
  CollectionHall_71090_LockTip = {
    Text = "完成意识潜游「一步之遥」"
  },
  CollectionHall_71090_Title = {
    Text = "学院即景"
  },
  CollectionHall_71091_Desc = {
    Text = "这里是她的港湾，却难成她的归宿。为了拯救那个世界，她终将踏上自己的深渊。"
  },
  CollectionHall_71091_LockTip = {
    Text = "完成意识潜游「一步之遥」困难难度"
  },
  CollectionHall_71091_Title = {
    Text = "再入深渊"
  },
  CollectionHall_71092_Desc = {
    Text = "她从来不擅长将对这些感情宣之于口。"
  },
  CollectionHall_71092_LockTip = {
    Text = "完成意识潜游「一步之遥」"
  },
  CollectionHall_71092_Title = {
    Text = "静水流深"
  },
  CollectionHall_71093_Desc = {
    Text = "如果指针能够永不重合，我是不是就能够永不离开？"
  },
  CollectionHall_71093_LockTip = {
    Text = "完成意识潜游「一步之遥」困难难度"
  },
  CollectionHall_71093_Title = {
    Text = "未至的终点"
  },
  CollectionHall_72087_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_72087_Title = {
    Text = "星辰正位之刻"
  },
  CollectionHall_73670_Title = {
    Text = "利莫里亚"
  },
  CollectionHall_73671_Title = {
    Text = "加冕之日"
  },
  CollectionHall_74773_Title = {
    Text = "乌撒猫猫律：群猫乱舞"
  },
  CollectionHall_74775_LockTip = {
    Text = "需要通关限时角色活动「半步之隔：虚无之门」任一关卡"
  },
  CollectionHall_74775_Title = {
    Text = "半步之隔：虚无之门"
  },
  CollectionHall_74793_Title = {
    Text = "决胜：原初之影"
  },
  CollectionHall_76206_LockTip = {
    Text = "通关调查行动9-13解锁"
  },
  CollectionHall_76206_Title = {
    Text = "缸中之梦"
  },
  CollectionHall_77667_LockTip = {
    Text = "需要通关限时角色活动「雨镇幽影：魔女小店」任一关卡"
  },
  CollectionHall_77667_Title = {
    Text = "雨镇幽影"
  },
  CollectionHall_78803_LockTip = {
    Text = "需要通关限时活动「相位逆转：逆转回合」任一关卡"
  },
  CollectionHall_78803_Title = {
    Text = "逆转回合"
  },
  CollectionHall_80175_LockTip = {
    Text = "需要通关限时角色活动「埋于记忆之下：恐惧愈疗」任一关卡"
  },
  CollectionHall_80175_Title = {
    Text = "埋于记忆之下：恐惧愈疗"
  },
  CollectionHall_81177_LockTip = {
    Text = "通关调查行动星辰篇2-18解锁"
  },
  CollectionHall_81177_Title = {
    Text = "拥抱本我"
  },
  CollectionHall_81282_LockTip = {
    Text = "通关调查行动星辰篇2-1解锁"
  },
  CollectionHall_81282_Title = {
    Text = "窥视灵魂之旅"
  },
  CollectionHall_81508_Title = {
    Text = "重临雾都"
  },
  CollectionHall_81514_Title = {Text = "蜕变"},
  CollectionHall_84274_LockTip = {
    Text = "需要通关限时角色活动「于暴雨中摇曳：邃海迷航」任一关卡"
  },
  CollectionHall_84274_Title = {
    Text = "于暴雨中摇曳：邃海迷航"
  },
  CollectionHall_84328_LockTip = {
    Text = "通关意识潜游「最后的引航」任一关卡解锁"
  },
  CollectionHall_84328_Title = {
    Text = "航海谵妄症"
  },
  CollectionHall_84341_Title = {
    Text = "最后的引航"
  },
  CollectionHall_84377_LockTip = {
    Text = "需要完成限时活动「扫除奇旅：除尘津贴」扫除工具达到 1000 的任务"
  },
  CollectionHall_84377_Title = {
    Text = "扫除奇旅"
  },
  CollectionHall_89341_Desc = {
    Text = "我们脱下礼帽，向那些故去的、英勇的、伟大的以及渺小的，我们的朋友，致以最深切的哀伤与敬意。"
  },
  CollectionHall_89341_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89341_Title = {Text = "默哀"},
  CollectionHall_89342_Desc = {
    Text = "耐心，谨慎，切莫让五彩斑斓的光迷了眼。"
  },
  CollectionHall_89342_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89342_Title = {
    Text = "诡光帷幕"
  },
  CollectionHall_89343_Desc = {
    Text = "灵魂深处的链接发出呼唤。\n骑士应约而至，来到主君的身边。"
  },
  CollectionHall_89343_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89343_Title = {
    Text = "远方的呼唤"
  },
  CollectionHall_89344_Desc = {
    Text = "黑胶唱片撕扯着黏稠的喉咙，引亢不甘的悲鸣。"
  },
  CollectionHall_89344_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89344_Title = {
    Text = "悲鸣黑胶"
  },
  CollectionHall_89345_Desc = {
    Text = "她选择作为一个人类死去，那捧灵魂的灰烬最终沉眠于这具人形的棺椁。"
  },
  CollectionHall_89345_LockTip = {
    Text = "完成意识潜游「扭曲核心」困难难度"
  },
  CollectionHall_89345_Title = {
    Text = "灵魂余烬"
  },
  CollectionHall_89346_Desc = {
    Text = "束缚怪物的枷锁已被破坏，无法杀死，无法逃离的猎手，来了。"
  },
  CollectionHall_89346_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89346_Title = {
    Text = "撕裂维度而来"
  },
  CollectionHall_89347_Desc = {
    Text = "人们争先恐后地厮杀，妄想这样就能洗清自己的罪，率先踏入纯净无瑕的神国。"
  },
  CollectionHall_89347_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89347_Title = {Text = "妄想"},
  CollectionHall_89348_Desc = {
    Text = "美丽！富饶！理想之乡利莫里亚！\n强大！坚韧！神王庇护利莫里亚！\n伟哉！伟哉！永恒之国利莫里亚！"
  },
  CollectionHall_89348_LockTip = {
    Text = "完成调查行动·困难5-10解锁"
  },
  CollectionHall_89348_Title = {
    Text = "永恒王土"
  },
  CollectionHall_89349_Desc = {
    Text = "抛弃与背叛是高位者的家常便饭，不要将后背露给他们，防止变成最后的光与热。"
  },
  CollectionHall_89349_LockTip = {
    Text = "完成调查行动·困难3-10解锁"
  },
  CollectionHall_89349_Title = {
    Text = "被抛弃者"
  },
  CollectionHall_89350_Desc = {
    Text = "她的灵魂在你身后，你一人即是此刻唯一的城墙，而命运的无力感将你牢牢俘获，你改变不了那个结局。\n那个她被黑色潮水淹没的结局。"
  },
  CollectionHall_89350_LockTip = {
    Text = "完成意识潜游「扭曲核心」"
  },
  CollectionHall_89350_Title = {
    Text = "孤独援救"
  },
  CollectionHall_89351_Desc = {
    Text = "你听到某人在你耳边不断轻柔地絮语，唇齿间的呢喃沙沙作响。\n你仔细聆听，试图分辨那模糊的言语，直到同样的沙沙声在耳膜内侧的颅中响起，你才意识到，那是亿万只虫类的翅膀在一同密集共振的声音——哗啦，哗啦啦，回家，回家。"
  },
  CollectionHall_89351_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89351_Title = {
    Text = "亿万虫鸣"
  },
  CollectionHall_89352_Desc = {
    Text = "人生中的关键时刻，似乎总是有如丝细雨相伴。\n与那些霏霏细雨中的回忆告别吧，把酿成的苦酒深藏心底，握紧手中的银钥，踏上新的征程。\n愿银钥指引我们。"
  },
  CollectionHall_89352_LockTip = {
    Text = "完成调查行动·困难 星辰篇1-10解锁"
  },
  CollectionHall_89352_Title = {
    Text = "再见霏霏"
  },
  CollectionHall_89353_Desc = {
    Text = "春日的暖阳、梦幻的宫殿、旋转的礼裙、充满欢笑的舞会，以及美丽又温柔的公主。\n这些就是骑士想要守护的全部。"
  },
  CollectionHall_89353_LockTip = {
    Text = "完成意识潜游「骑士的愿望」"
  },
  CollectionHall_89353_Title = {
    Text = "宫廷春日宴"
  },
  CollectionHall_89354_Desc = {
    Text = "鲜血，杀戮，变革……埋藏在无尽黄沙下的，是时间长河中残酷而常见的历史。"
  },
  CollectionHall_89354_LockTip = {
    Text = "完成意识潜游「苍白后裔」困难难度"
  },
  CollectionHall_89354_Title = {
    Text = "黄沙之下"
  },
  CollectionHall_89355_Desc = {
    Text = "当不知道如何回答时，只要卖萌就好了，哎嘿~"
  },
  CollectionHall_89355_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89355_Title = {Text = "哎嘿~"},
  CollectionHall_89356_Desc = {
    Text = "战略性撤退虽可耻，但有用。"
  },
  CollectionHall_89356_LockTip = {
    Text = "完成意识潜游「苍白后裔」"
  },
  CollectionHall_89356_Title = {
    Text = "迷宫逃亡"
  },
  CollectionHall_89357_Desc = {
    Text = "深渊中绽放的洁白之花，牢牢挡在众人身前。\n“即使是这样，那也是我唯一的妈妈。”\n“把我的妈妈——还给我！”"
  },
  CollectionHall_89357_LockTip = {
    Text = "完成调查行动·困难4-12解锁"
  },
  CollectionHall_89357_Title = {
    Text = "悲怆的绽放"
  },
  CollectionHall_89358_Desc = {
    Text = "在她成为冰冷的机械前，也曾有过鲜活的灵魂。"
  },
  CollectionHall_89358_LockTip = {
    Text = "完成意识潜游「扭曲核心」"
  },
  CollectionHall_89358_Title = {
    Text = "机械之心"
  },
  CollectionHall_89359_Desc = {
    Text = "少女身着单衣走在雪地上，渴望一个温暖的怀抱。"
  },
  CollectionHall_89359_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89359_Title = {
    Text = "雪中的少女"
  },
  CollectionHall_89360_Desc = {
    Text = "居民们热情洋溢，与来宾打成一片。"
  },
  CollectionHall_89360_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89360_Title = {
    Text = "“好客”的居民"
  },
  CollectionHall_89361_Desc = {
    Text = "上天已赐下尊贵的神母，用以接我们去祂的国。\n赞美「吾主」！"
  },
  CollectionHall_89361_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89361_Title = {
    Text = "尊荣神母"
  },
  CollectionHall_89362_Desc = {
    Text = "忠诚而勇敢的狗狗会自己制定训练的计划，而抚慰一切伤心与疲惫，只需要你一个鼓励的目光。"
  },
  CollectionHall_89362_LockTip = {
    Text = "完成意识潜游「骑士的愿望」"
  },
  CollectionHall_89362_Title = {
    Text = "幼犬训练"
  },
  CollectionHall_89363_Desc = {
    Text = "那个身量尚且不如长枪的年幼骑士，无愧于对公主宣誓时许下的每一句誓言。"
  },
  CollectionHall_89363_LockTip = {
    Text = "完成意识潜游「骑士的愿望」"
  },
  CollectionHall_89363_Title = {
    Text = "无愧荣光"
  },
  CollectionHall_89364_Desc = {
    Text = "一艘远航的行船，要将众人带向何方？\n那纯白的神女，正坐在高高的桅杆上歌唱。\n贪婪、痴妄、挣扎与背叛，她视若无睹，她不歌唱命运的翻覆，她只歌唱，那老船长的归航"
  },
  CollectionHall_89364_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89364_Title = {
    Text = "深港幽灵之船"
  },
  CollectionHall_89365_Desc = {
    Text = "救救我……无论是谁都好……救救我……"
  },
  CollectionHall_89365_LockTip = {
    Text = "完成调查行动·困难3-10解锁"
  },
  CollectionHall_89365_Title = {
    Text = "无家可归的孩子"
  },
  CollectionHall_89366_Desc = {
    Text = "伟大的父啊，愿您的光照耀世界。"
  },
  CollectionHall_89366_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89366_Title = {
    Text = "苍白的圣徒"
  },
  CollectionHall_89367_Desc = {
    Text = "潮水涌起，尖啸回荡，痛苦的回忆涌上心头，将女孩的精神撕碎。眼角流下的黑色泪水，是她发出的无声呼救。"
  },
  CollectionHall_89367_LockTip = {
    Text = "完成调查行动·困难3-10解锁"
  },
  CollectionHall_89367_Title = {
    Text = "痛苦回忆"
  },
  CollectionHall_89368_Desc = {
    Text = "无论她如何落笔，都只能在日记上留下黑色的残缺。"
  },
  CollectionHall_89368_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89368_Title = {
    Text = "未落的雪"
  },
  CollectionHall_89369_Desc = {
    Text = "月光于夜空中倾泻，海浪低吟着永恒的细语，斑驳的巨轮缓缓向前。\n你站在薄雾弥漫的甲板上，只身编织晦涩的夜曲。"
  },
  CollectionHall_89369_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89369_Title = {Text = "远航"},
  CollectionHall_89370_Desc = {
    Text = "那是一座座活着的墓碑，每颗卵鞘上都刻着他们的墓志铭。\n他们满怀希望，崇敬地走入那紧挨着的坟墓。"
  },
  CollectionHall_89370_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89370_Title = {
    Text = "黏性墓碑"
  },
  CollectionHall_89371_Desc = {
    Text = "淡雅的清香，琳琅的商品，可又有几人，能支付水仙夫人开出的价格？"
  },
  CollectionHall_89371_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89371_Title = {
    Text = "水仙小屋"
  },
  CollectionHall_89372_Desc = {
    Text = "温暖的双手轻抚女孩头顶，安抚了那颗不安的心。"
  },
  CollectionHall_89372_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89372_Title = {
    Text = "别担心，有我在"
  },
  CollectionHall_89373_Desc = {
    Text = "时间在嘶吼，时间在咆哮，时间在追逐三度沦为猎物之人。不要尝试逃跑，因为结果早已注定。"
  },
  CollectionHall_89373_LockTip = {
    Text = "完成调查行动·困难4-12解锁"
  },
  CollectionHall_89373_Title = {
    Text = "因果的怪物"
  },
  CollectionHall_89374_Desc = {
    Text = "审判不会停止，审判必须执行。\n怪物从镜子中诞生，以自己的血肉为灯芯，将净化之火传遍世界。"
  },
  CollectionHall_89374_LockTip = {
    Text = "完成特遣纪录「血的颜色」困难难度"
  },
  CollectionHall_89374_Title = {
    Text = "血肉灯火"
  },
  CollectionHall_89375_Desc = {
    Text = "当立场和意志发生碰撞，人类往往只会坚信自己的准则。\n对大多数人而言，自己所相信的，便是唯一的正义。"
  },
  CollectionHall_89375_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89375_Title = {
    Text = "对立的正义"
  },
  CollectionHall_89376_Desc = {
    Text = "相见来的过早，真相来的太迟，被残酷现实撕碎的心灵，正在幼小的双手中渐渐愈合。\n跨越风雪互相追逐的二人，终于在超越时间的狭缝间，相拥而泣。"
  },
  CollectionHall_89376_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89376_Title = {
    Text = "不期的重逢"
  },
  CollectionHall_89377_Desc = {
    Text = "作为淑女，当然要时时刻刻保持优雅！\n当然，我的意思是，淑女做什么，什么就是优雅！"
  },
  CollectionHall_89377_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89377_Title = {
    Text = "渊海淑女"
  },
  CollectionHall_89378_Desc = {
    Text = "温暖的炉火欢迎着每一位来宾。但请注意，夜有恶犬，不要出门。"
  },
  CollectionHall_89378_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89378_Title = {
    Text = "雪夜小镇"
  },
  CollectionHall_89379_Desc = {
    Text = "在这扇连时间都能囚禁的大门背后，是一位母亲为了守护自己心爱的女儿，所做的最后抉择。\n“我爱你，莉莉。”"
  },
  CollectionHall_89379_LockTip = {
    Text = "完成调查行动·困难4-12解锁"
  },
  CollectionHall_89379_Title = {
    Text = "永恒囚笼"
  },
  CollectionHall_89380_Desc = {
    Text = "追猎，奔逃，凝固的母爱，跨越生死的相拥。"
  },
  CollectionHall_89380_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89380_Title = {
    Text = "扭曲疯人之院"
  },
  CollectionHall_89381_Desc = {
    Text = "万能的主啊，请您赐予我应受之罚。"
  },
  CollectionHall_89381_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89381_Title = {
    Text = "盲目的圣徒"
  },
  CollectionHall_89382_Desc = {
    Text = "那时，母亲翻动着书页，为孩子讲述童话故事。\n午后的温度跨越时间，细细流淌在这片狭窄的时空中。"
  },
  CollectionHall_89382_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89382_Title = {
    Text = "午后童话"
  },
  CollectionHall_89383_Desc = {
    Text = "该如何欺骗自己，才能于熄灭的余烬中幻想生命仍在延续。\n她沉眠于漆黑的蛹与黏稠的红，在梦境中凝望遥远的星空。\n“那太冷了，但我曾经的温暖又在哪里呢？”"
  },
  CollectionHall_89383_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89383_Title = {
    Text = "灰烬臆想"
  },
  CollectionHall_89384_Desc = {
    Text = "高唱吧，高唱吧！\n让熔毁的机械奏鸣响彻寰宇，赞颂名为永恒黑暗的终末！"
  },
  CollectionHall_89384_LockTip = {
    Text = "完成调查行动·困难 星辰篇1-10解锁"
  },
  CollectionHall_89384_Title = {
    Text = "熔毁终末赞歌"
  },
  CollectionHall_89385_Desc = {
    Text = "血肉翻飞，利刃狂舞，怪物用无法理解的言语高声歌唱。狂暴的大脑中只剩一个念头——抓住她，不惜一切代价，抓住她。"
  },
  CollectionHall_89385_LockTip = {
    Text = "完成调查行动·困难3-10解锁"
  },
  CollectionHall_89385_Title = {
    Text = "癫狂执念"
  },
  CollectionHall_89386_Desc = {
    Text = "看啊，猩红之月已经升起，所有罪人都将遭到净化。"
  },
  CollectionHall_89386_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89386_Title = {Text = "血月"},
  CollectionHall_89387_Desc = {
    Text = "仁慈的父啊，我将燃烧我的骨血，焚尽我的灵魂，以作点燃「白焰」的柴薪。\n请将所有苦难加于我身，让那些迷途的孩子，可以继续踏上前路。"
  },
  CollectionHall_89387_LockTip = {
    Text = "完成特遣纪录「血的颜色」困难难度"
  },
  CollectionHall_89387_Title = {Text = "神恩"},
  CollectionHall_89388_Desc = {
    Text = "提灯将驱逐一切罪恶。\n你需虔诚悔过，流尽鲜血，方能将罪恶流出，升入天堂。"
  },
  CollectionHall_89388_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89388_Title = {
    Text = "提灯长明"
  },
  CollectionHall_89389_Desc = {
    Text = "你向我许诺过，你们向我许诺过。\n如果我不能拯救利莫里亚，那就一起，为它陪葬！"
  },
  CollectionHall_89389_LockTip = {
    Text = "完成调查行动·困难5-10解锁"
  },
  CollectionHall_89389_Title = {
    Text = "执妄审判"
  },
  CollectionHall_89390_Desc = {
    Text = "真正的骑士如果不能带来凯旋，那么就应战死在守护之人的身前。"
  },
  CollectionHall_89390_LockTip = {
    Text = "完成意识潜游「骑士的愿望」困难难度"
  },
  CollectionHall_89390_Title = {
    Text = "无悔的背影"
  },
  CollectionHall_89391_Desc = {
    Text = "崩毁的音符在舞蹈，坍塌的现实在喧嚣。\n连梦的触角都不涉足此地。"
  },
  CollectionHall_89391_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89391_Title = {
    Text = "崩毁变奏"
  },
  CollectionHall_89392_Desc = {
    Text = "渊海的淑女决心贯彻自己的意志，赴向遥不可及的自由。"
  },
  CollectionHall_89392_LockTip = {
    Text = "完成调查行动·困难5-10解锁"
  },
  CollectionHall_89392_Title = {
    Text = "覆海决意"
  },
  CollectionHall_89393_Desc = {
    Text = "我要将你带回去，带回去见“主人”，只有这样……"
  },
  CollectionHall_89393_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89393_Title = {
    Text = "血肉同源"
  },
  CollectionHall_89394_Desc = {
    Text = "你与之战斗的，是无数个同心同体的灵魂。他们抗拒你、他们邀请你，放下无谓的自我吧，让你无知的大脑，一同加入永不孤独的集体。"
  },
  CollectionHall_89394_LockTip = {
    Text = "完成调查行动·困难 星辰篇2-12解锁"
  },
  CollectionHall_89394_Title = {
    Text = "集群意志"
  },
  CollectionHall_89395_Desc = {
    Text = "孩子，你愿意帮我一个忙么。"
  },
  CollectionHall_89395_LockTip = {
    Text = "完成特遣纪录「血的颜色」"
  },
  CollectionHall_89395_Title = {
    Text = "无私的善"
  },
  CollectionHall_89396_Desc = {
    Text = "抓住我的手吧，接过记忆中那朵永不褪色的花。\n不要回头地前进吧，因我们最终一定会抵达，那闪耀银光的门扉啊。"
  },
  CollectionHall_89396_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89396_Title = {
    Text = "我心所向"
  },
  CollectionHall_89397_Desc = {
    Text = "这里生产的并非普通工业品。"
  },
  CollectionHall_89397_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89397_Title = {
    Text = "脑髓制造"
  },
  CollectionHall_89398_Desc = {
    Text = "远空的黑色末日犹如天穹的孔洞。\n那是来自未揭露之地的图腾。"
  },
  CollectionHall_89398_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89398_Title = {
    Text = "黑日图腾"
  },
  CollectionHall_89399_Desc = {
    Text = "灰雾笼罩着黑色的太阳，粉尘填满口鼻。\n勿要张口呼吸——希望已在此前埋葬。"
  },
  CollectionHall_89399_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89399_Title = {
    Text = "窒息烟尘"
  },
  CollectionHall_89400_Desc = {
    Text = "打开你的颅腔，与万千脑缸共振吧。\n答案或许就隐藏其中。"
  },
  CollectionHall_89400_LockTip = {
    Text = "完成调查行动·困难 星辰篇1-10解锁"
  },
  CollectionHall_89400_Title = {
    Text = "颅腔共振"
  },
  CollectionHall_89401_Desc = {
    Text = "冬日，女巫，孩子们，一场永不停歇的雪。"
  },
  CollectionHall_89401_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89401_Title = {
    Text = "雪落噬影之镇"
  },
  CollectionHall_89402_Desc = {
    Text = "诡异的密语在空气中回荡，黑色的粘液将祭品吞噬，旧日的存在期待着神明的归来。"
  },
  CollectionHall_89402_LockTip = {
    Text = "完成调查行动4-16解锁"
  },
  CollectionHall_89402_Title = {
    Text = "极地祭坛"
  },
  CollectionHall_89403_Desc = {
    Text = "光芒驱散了黑暗，平等地照耀着每位孩子。\n它苍白，虚弱，却无比温暖，充满力量。\n愿这微弱之光，能消去你的苦难，抚平你的内心，我的孩子。"
  },
  CollectionHall_89403_LockTip = {
    Text = "完成特遣纪录「血的颜色」困难难度"
  },
  CollectionHall_89403_Title = {
    Text = "济世的白焰"
  },
  CollectionHall_89404_Desc = {
    Text = "列车骤然停下，双子追寻血脉气息而来。"
  },
  CollectionHall_89404_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89404_Title = {Text = "急刹车"},
  CollectionHall_89405_Desc = {
    Text = "王啊，我已遵循预言等待了万年，可未来为何依旧遥不可及？\n我本应继续祈祷，但请原谅我，我已经等不及了。"
  },
  CollectionHall_89405_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89405_Title = {
    Text = "亿万祷言"
  },
  CollectionHall_89406_Desc = {
    Text = "卑贱的小偷盗取了王的力量，妄图阻碍伟大的仪式。\n不敬之赝品，当以死谢罪！"
  },
  CollectionHall_89406_LockTip = {
    Text = "完成调查行动·困难5-10解锁"
  },
  CollectionHall_89406_Title = {
    Text = "渎神誓言"
  },
  CollectionHall_89407_Desc = {
    Text = "在那浓郁不可见日的迷雾中，我将独身踏向未知的前路。\n我从那雾中捞起尘土、鲜血与火焰，平息那些孤独的、茫然的、愁怨的泪水。\n我将不再惧怕，只因永恒的太阳早已高悬于我的心间。"
  },
  CollectionHall_89407_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89407_Title = {
    Text = "我将行至"
  },
  CollectionHall_89408_Desc = {
    Text = "孩子们都曾听过：不要用肉眼直视太阳。\n即便此刻，祂已经沦陷。"
  },
  CollectionHall_89408_LockTip = {
    Text = "完成调查行动 星辰篇1-14解锁"
  },
  CollectionHall_89408_Title = {
    Text = "复苏黑日之世"
  },
  CollectionHall_89409_Desc = {
    Text = "欢迎来到克莱门汀医生的私人神经疗养院，请跟随医生的指引，释放你心灵所有的痛苦，走向最终的痊愈。"
  },
  CollectionHall_89409_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89409_Title = {
    Text = "迷幻虫巢之梦"
  },
  CollectionHall_89410_Desc = {
    Text = "曾经的辉煌已经过去，只剩下记忆中的断壁残垣。"
  },
  CollectionHall_89410_LockTip = {
    Text = "完成意识潜游「苍白后裔」"
  },
  CollectionHall_89410_Title = {
    Text = "过往余辉"
  },
  CollectionHall_89411_Desc = {
    Text = "你于深渊中沉没,从你的口袋里,飞出她最后的留言。于是你在无尽的黑暗里,得见一刹的光明。"
  },
  CollectionHall_89411_LockTip = {
    Text = "完成调查行动·困难 星辰篇2-12解锁"
  },
  CollectionHall_89411_Title = {Text = "破蛹"},
  CollectionHall_89412_Desc = {
    Text = "曾在你身前的，如今在你身后。\n你始终相信，在你全力奔跑后，在那时空尽头等待的，一定是那双熟悉的、温暖的手。"
  },
  CollectionHall_89412_LockTip = {
    Text = "完成调查行动·困难 星辰篇2-12解锁"
  },
  CollectionHall_89412_Title = {
    Text = "不变的抉择"
  },
  CollectionHall_89413_Desc = {
    Text = "地下铁中遭到攻击虽然不幸，但作为满足女孩好奇心的余兴节目，却是刚刚好。"
  },
  CollectionHall_89413_LockTip = {
    Text = "完成调查行动3-14解锁"
  },
  CollectionHall_89413_Title = {
    Text = "隧道奇遇记"
  },
  CollectionHall_89414_Desc = {
    Text = "英雄和公主奔跑在夜幕下，脚下的砂砾诉说着生的喜悦。那颗封闭千年的心，也随着流星的划过，缓缓地开始跳动。"
  },
  CollectionHall_89414_LockTip = {
    Text = "完成意识潜游「苍白后裔」困难难度"
  },
  CollectionHall_89414_Title = {
    Text = "二人的流星"
  },
  CollectionHall_89415_Desc = {
    Text = "不必言语，当你来到这里，便会获得最真诚的帮助。\n那微笑的引路人已向你伸出手，她将带你走入你自己也不曾看清的、心灵密林的深处。"
  },
  CollectionHall_89415_LockTip = {
    Text = "完成调查行动 星辰篇2-18解锁"
  },
  CollectionHall_89415_Title = {
    Text = "心灵密林"
  },
  CollectionHall_89416_Desc = {
    Text = "当河谷的第一缕晨光照入迷宫之时，千足千子沉睡千年的公主，迎来了她最后一位信徒。"
  },
  CollectionHall_89416_LockTip = {
    Text = "完成意识潜游「苍白后裔」"
  },
  CollectionHall_89416_Title = {
    Text = "坎布里安的晨曦"
  },
  CollectionHall_89417_Desc = {
    Text = "天才的脑回路总有那么一些蜿蜒、曲折、与众不同，但那正是她的可爱之处，不是吗？"
  },
  CollectionHall_89417_LockTip = {
    Text = "完成意识潜游「扭曲核心」"
  },
  CollectionHall_89417_Title = {
    Text = "天才的烦恼"
  },
  CollectionHall_89418_Desc = {
    Text = "来陪我玩个游戏吧，放心，没那么危险，只是为了打发这无聊的时间。"
  },
  CollectionHall_89418_LockTip = {
    Text = "完成意识潜游「苍白后裔」"
  },
  CollectionHall_89418_Title = {
    Text = "猜谜游戏"
  },
  CollectionHall_89419_Desc = {
    Text = "幻光的海潮在天体的牵引下编织成帷幕，蹈海的诡物踏浪而来。"
  },
  CollectionHall_89419_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89419_Title = {
    Text = "幻海潮涌"
  },
  CollectionHall_89420_Desc = {
    Text = "王至高无上，王威权无边，王遥坐于辉煌之上，孤独的俯视他的国。"
  },
  CollectionHall_89420_LockTip = {
    Text = "完成调查行动5-15解锁"
  },
  CollectionHall_89420_Title = {
    Text = "眠于深渊之王"
  },
  CollectionHall_89706_Desc = {
    Text = "<Title:简介>\n孤儿，来历不明，自有记忆开始就被船员收养，生活在船上。\n因为这样的经历，克珀珊特从小就对海洋充满了渴望与好奇。\n当她长大时，理所当然地选择了与海洋、船相关的职业——领航员。\n从此，热爱海洋的少女永恒地漂流于海上，她将在繁星相伴下，指引船只的方向。\n她在海洋里、在船上「降生」。\n她也无惧在海洋里、在船上「死亡」。\n这就是她的生活。"
  },
  CollectionHall_89706_LockTip = {
    Text = "唤醒「克珀珊特」后解锁"
  },
  CollectionHall_89706_Title = {
    Text = "克珀珊特"
  },
  CollectionHall_89968_Desc = {
    Text = "杀戮、仇恨、疯狂与痛苦，战场从不缺少这些。当你将性命赌上怪物的牌桌时，就理应想到会引起一场怎样的猩红漩涡。"
  },
  CollectionHall_89968_LockTip = {
    Text = "完成意识潜游「血与沙」"
  },
  CollectionHall_89968_Title = {
    Text = "猩红漩涡"
  },
  CollectionHall_89969_Desc = {
    Text = "传说中领航员死后，会在桅杆之上化作一团蓝白色的闪光，继续指引船只的航行。\n那么她在桅杆的最顶端点燃了自己的生命时，是否看见了那一道希望的归路？"
  },
  CollectionHall_89969_LockTip = {
    Text = "完成意识潜游「最后的引航」"
  },
  CollectionHall_89969_Title = {
    Text = "圣艾尔摩之火"
  },
  CollectionHall_89970_Desc = {
    Text = "她生来的宿命中便充满仇恨、杀伐与无尽的争斗。\n当她抛弃一切温软的、暖和的幻影，选择拿起刀与枪时，命运的凯歌就已为她而奏响。\n她注定成为一个战士，用敌人的鲜血洗刷仇恨，而后度过或许并不光荣，却无畏无悔的一生。"
  },
  CollectionHall_89970_LockTip = {
    Text = "完成特遣纪录「艾尔沃斯的归人」"
  },
  CollectionHall_89970_Title = {
    Text = "以血洗仇"
  },
  CollectionHall_89971_Desc = {
    Text = "血红的夕阳下，是浸满鲜血的黄沙。\n最强大的战士伫立在即将沉入黑夜的战场，回忆旧日里金色的火焰与荣光。\n无数尖叫的秃鹫飞起，遮挡住了最后的日光。伟大的东征之下，尽是挤满沙漠的亡灵，为他共同陪葬。"
  },
  CollectionHall_89971_LockTip = {
    Text = "完成意识潜游「血与沙」困难难度"
  },
  CollectionHall_89971_Title = {
    Text = "沐浴鲜血的红日"
  },
  CollectionHall_89972_Desc = {
    Text = "如若这世界已陷入黑暗，那我将做最后的炬火。\n如若人群中已再无正义，那我将为最弱者发声。"
  },
  CollectionHall_89972_LockTip = {
    Text = "完成意识潜游「最后的引航」"
  },
  CollectionHall_89972_Title = {
    Text = "长夜炬火"
  },
  CollectionHall_89973_Desc = {
    Text = "那是她宿命的战斗，那是她必须前往的战场。\n她将所有懦弱、犹豫、恐惧都随过往抛却。\n她并不后悔，只因她已明白此生战斗的真谛。\n她并不孤独，那手中的剑刃倒映的，正是另一个自己张狂的面庞。"
  },
  CollectionHall_89973_LockTip = {
    Text = "完成特遣纪录「艾尔沃斯的归人」困难难度"
  },
  CollectionHall_89973_Title = {
    Text = "向群山发问"
  },
  CollectionHall_89974_Desc = {
    Text = "嘿哟，嘿哟，拉起船锚，升起船帆，解开最后一根缆绳。\n我们的领航员已爬上桅杆，鲜艳的旗帜已高高挂起。\n启航，启航，向着她指引的方向，我们就要启航！"
  },
  CollectionHall_89974_LockTip = {
    Text = "完成意识潜游「最后的引航」"
  },
  CollectionHall_89974_Title = {
    Text = "领航手记"
  },
  CollectionHall_89975_Desc = {
    Text = "她在每一次出航时，都准备好了最新的遗书。\n那首代代相传的歌谣如梦中的摇篮曲，将她的灵魂轻柔拥抱。\n鲜艳的旗帜在风中飘荡，她的肉体或会崩解、腐烂、沉入深海，她的灵魂必将伫立在她的船上，向着星辰与大海发出永恒的光芒。"
  },
  CollectionHall_89975_LockTip = {
    Text = "完成意识潜游「最后的引航」"
  },
  CollectionHall_89975_Title = {
    Text = "领航员挽歌"
  },
  CollectionHall_89976_Desc = {
    Text = "在库西沙漠之中，风沙是永不停歇的常客，漫天飞舞的沙砾会灌进活人的口鼻，也会掩埋死去的、不知姓名的尸体。\n只有渴求血肉的野兽，会在风中细细嗅寻、那份甘美盛宴的气息。"
  },
  CollectionHall_89976_LockTip = {
    Text = "完成意识潜游「血与沙」"
  },
  CollectionHall_89976_Title = {
    Text = "黄沙与野兽"
  },
  CollectionHall_89977_Desc = {
    Text = "沙漠里的太阳和其他地方并不一样，它苍白、刺眼而酷烈，从未有过温柔的一面。野兽无法想象你口中描述的春天，那么就请你替他去看一看，那所谓真正的太阳吧。"
  },
  CollectionHall_89977_LockTip = {
    Text = "完成意识潜游「血与沙」"
  },
  CollectionHall_89977_Title = {
    Text = "无还的血与沙"
  },
  CollectionHall_89978_Desc = {
    Text = "大雪无尽落下，纷纷扬扬，将战士的头发覆上霜白。\n她一生的回忆于此时流淌，她从人心幽微之处走过，要去往群山磅礴之中。\n背叛、抛弃与守护，一切痛苦与愤怒，不过是一场又一场战斗。与人、与山、与自我。\n她看向自己的引领者，看向陌生又熟悉的新同伴，露出了并不熟练的笑容。\n她或有一天会凯旋，或许会永远倒在战场，但哪怕升入天国或堕入地狱的那一刻，她也不会放下手中的利刃。\n为了不再失去这一切，这次她选择在复仇之前，举起名为守护之剑，独自奔赴她的战场。"
  },
  CollectionHall_89978_LockTip = {
    Text = "完成特遣纪录「艾尔沃斯的归人」"
  },
  CollectionHall_89978_Title = {
    Text = "为了不再失去的明天"
  },
  CollectionHall_89998_LockTip = {
    Text = "需要通关限时活动「窥觑神国的阴影：异动海潮」任一关卡"
  },
  CollectionHall_89998_Title = {
    Text = "窥觑神国的阴影：异动海潮"
  },
  CollectionHall_89999_LockTip = {
    Text = "需要通关限时活动「镜像囚徒：飞跃青空」任一关卡"
  },
  CollectionHall_89999_Title = {
    Text = "镜像囚徒：飞跃青空"
  },
  CollectionHall_90245_LockTip = {
    Text = "通关异梦视界「天边之外·上」任一关卡解锁"
  },
  CollectionHall_90245_Title = {
    Text = "飞鸟尚未坠落之时"
  },
  CollectionHall_90415_Title = {
    Text = "天边之外·上"
  },
  CollectionHall_90416_Desc = {
    Text = "<Title:简介>\n提灯教会为了降神仪式而培养的一系列实验品之一，因作为双生子幸运地降生，而免于了被丢弃于垃圾堆的命运。\n与弟弟波吕克斯从小被尊为圣子，接受严格的规训，整日被灌输有关持灯者的神学，唯一接触过有关外界的信息就是一本由信徒供奉的、精美厚重的手抄本。\n少年时在弟弟被教会施行残忍的改造仪式后，二人决定一起出逃追寻自由，但很快就被抓回。\n他被浸泡在名为「罪潭」融蚀水池中，用「罪孽疗法」治愈伤口，经历了漫长的折磨。\n最终因此被于丽埃特之外的人遗忘了，包括波吕克斯，与弟弟的关系也变得僵硬。\n从此蛰伏下来，表面装作顺从教会，内心从没放弃再次带弟弟逃走的执念，一直等待着重获自由的机会。"
  },
  CollectionHall_90416_LockTip = {
    Text = "唤醒「卡斯托尔」后解锁"
  },
  CollectionHall_90416_Title = {
    Text = "卡斯托尔"
  },
  CollectionHall_94552_LockTip = {
    Text = "需要通关限时活动「伟大的征服：神圣的猎食」任一关卡"
  },
  CollectionHall_94552_Title = {
    Text = "伟大的征服：神圣的猎食"
  },
  CollectionHall_94553_Desc = {
    Text = "<Title:简介>\n提灯教会为了降神仪式而培养的人造双子实验品，就在被判定为实验失败，即将被残忍抛弃之时，从哥哥的血肉之中分裂诞生。\n那样求生的依恋并非幸运，而是将两人的命运从短促的悲剧，更改为了一场更加漫长的悲剧。\n或许源于双生的奥秘，他与哥哥的肤色、性格都截然相反。作为双子中更活泼机灵的那一个，总是做出与规训相悖的顽劣行为，就像一个平凡家庭中调皮的少年那样——直到被选中作为神格的容器培养，开始定期进行痛苦而血腥的「神圣改造」仪式。\n因无法忍受痛苦而无望的命运，在他的哀求和谋划下，兄弟二人用暗语计划了数年，终于破开重重险阻成功出逃。\n然而他们没能高兴太久就被教会的追兵抓回，于丽埃特下令拔掉了他那自由的翅膀，并对他进行极端的洗脑，最终使他彻底忘记了哥哥，享受起了身为圣子、被人追捧的感觉。\n直到在第二次出逃后因哥哥的死去和降神仪式的作用重新找回了记忆，被仇恨与怒火点燃了那颗「圣心」，将对抗提灯教会当作了人生新的方向。"
  },
  CollectionHall_94553_LockTip = {
    Text = "通关异梦视界「天边之外·下」解锁"
  },
  CollectionHall_94553_Title = {
    Text = "波吕克斯"
  },
  CollectionHall_95436_Desc = {
    Text = "飞啊，飞啊，鸟儿用那双翅膀对抗着沉重的引力，不断攀升、攀升，穿过一股又一股乱流与漩涡，向着越来越高的地方飞去。\n然而他不知道，他的脚上一直系有一条无形的丝线，他或许从不曾真正成为飞鸟，纵使飞翔，也不过是一只可怜的风筝。\n现在，风筝线收紧了。"
  },
  CollectionHall_95436_LockTip = {
    Text = "完成异梦视界「天边之外·上」"
  },
  CollectionHall_95436_Title = {Text = "风筝"},
  CollectionHall_95437_Desc = {
    Text = "你看到了那张脸，那张温柔的、宁静的、美丽的脸。\n它很快消融在你的记忆中，但你仍会一直记得那场漫长的夜雨结束后，晨曦柔软光晕的颜色。"
  },
  CollectionHall_95437_LockTip = {
    Text = "完成特遣纪录「雨镇幽影」"
  },
  CollectionHall_95437_Title = {
    Text = "雨幕深处"
  },
  CollectionHall_95438_Desc = {
    Text = "做一只猫，做一只无忧无虑的猫，只与爱的人待在一起，每天蜷在她身边晒太阳。\n这是她心底美好的小小梦想，然而美梦啊，一直都是那样脆弱易碎的东西。"
  },
  CollectionHall_95438_LockTip = {
    Text = "完成特遣纪录「宁静的裂殖」"
  },
  CollectionHall_95438_Title = {
    Text = "猫的愿望"
  },
  CollectionHall_95439_Desc = {
    Text = "哪怕世界灰飞烟灭，哪怕一切都被融蚀浆浸染，无邪的水母也可以永恒沉浸于自己的幻梦中。\n那里，一切如初。只有欢笑。只有快乐。"
  },
  CollectionHall_95439_LockTip = {
    Text = "完成意识潜游「诸事如常」困难难度"
  },
  CollectionHall_95439_Title = {
    Text = "沉沦于混沌烂漫"
  },
  CollectionHall_95440_Desc = {
    Text = "伦蒂尼恩的冬天并不常下雪，每一次飘雪都会引起孩子们兴奋的狂欢。\n你从一场温柔的长梦中醒来，将手伸出窗外。一朵雪花落在手心，于温暖中甘心地消融。\n纷纷扬扬的雪花，经过天空中短暂的旅途，回归向大地，回归向暗河，回归向所有水滴的家与轮回。\n在今年的第一场大雪中，又一位她也回到了她们的家。\n晚安，雪；晚安，「24」。"
  },
  CollectionHall_95440_LockTip = {
    Text = "完成特遣纪录「宁静的裂殖」"
  },
  CollectionHall_95440_Title = {
    Text = "晚安，雪"
  },
  CollectionHall_95441_Desc = {
    Text = "白色的珊瑚蔓延出枝桠，生长出纯白的宫殿。\n畸形的廊柱中，有多彩的游鱼自在穿梭。\n身体在下沉、灵魂在飘荡。\n你心甘情愿地失去呼吸，与她一起沉溺、沉溺，沉溺在白色的幻梦里。\n那是海的奇迹，那是温暖的蓝色家乡。"
  },
  CollectionHall_95441_LockTip = {
    Text = "完成意识潜游「如歌的雕琢」"
  },
  CollectionHall_95441_Title = {
    Text = "纯白宫殿"
  },
  CollectionHall_95442_Desc = {
    Text = "滴滴——小火车出发！\n让我带着朋友们，前往永远没有痛苦的欢乐童话王国吧。"
  },
  CollectionHall_95442_LockTip = {
    Text = "完成意识潜游「诸事如常」"
  },
  CollectionHall_95442_Title = {
    Text = "童真的痴梦"
  },
  CollectionHall_95443_Desc = {
    Text = "她是凶手吗？她看起来又像是你久别重逢的情人。\n雨水、枯叶和一股迷幻的花香，你翕动鼻翼，试图从那些潮湿的味道中嗅出一丝血腥气，以敲定她有罪的证明。然而你什么都没有闻到。\n她亦从未想过解释，一片朦胧的雾中，你坠入她的灰色梦境。"
  },
  CollectionHall_95443_LockTip = {
    Text = "完成特遣纪录「雨镇幽影」"
  },
  CollectionHall_95443_Title = {Text = "疑犯"},
  CollectionHall_95444_Desc = {
    Text = "那同样的饥渴她也曾经历。\n懵懂、野蛮又孤独。\n她是幸运的，她已结束了漫长的流浪，拥有了可供咀嚼一生的温暖回忆。\n现在她执起同类的手，将这个彷徨的灵魂送往宁静的梦乡。"
  },
  CollectionHall_95444_LockTip = {
    Text = "完成特遣纪录「雨镇幽影」困难难度"
  },
  CollectionHall_95444_Title = {
    Text = "野兽之梦"
  },
  CollectionHall_95445_Desc = {
    Text = "来自我的尖刀，捅向我的心脏。\n在无情的命运、苦涩的生活面前，我是那样渺小、软弱而无力。\n我凭什么成为我？我有没有做好我？\n来自我的质问，我亦无法回答。"
  },
  CollectionHall_95445_LockTip = {
    Text = "完成特遣纪录「宁静的裂殖」"
  },
  CollectionHall_95445_Title = {Text = "问我"},
  CollectionHall_95446_Desc = {
    Text = "咦？你好像和刚刚变得不一样了？\n是眼神更加明亮了？是举止更加活泼了？还是这具平庸的躯壳内，已经改换了灵魂的主人？"
  },
  CollectionHall_95446_LockTip = {
    Text = "完成意识潜游「如歌的雕琢」"
  },
  CollectionHall_95446_Title = {
    Text = "灵魂转移"
  },
  CollectionHall_95447_Desc = {
    Text = "无论下雪、下雨、晴天、阴天，今日的河水依然静静流淌。"
  },
  CollectionHall_95447_LockTip = {
    Text = "完成特遣纪录「宁静的裂殖」"
  },
  CollectionHall_95447_Title = {
    Text = "宁静的河流"
  },
  CollectionHall_95448_Desc = {
    Text = "潮水奔涌，头颅尖啸。\n一双双眼凝视着你，一张张嘴怒斥着你。\n它们要将你淹没，它们要将你吞噬。\n你恐惧地闭上双眼，再睁眼时，你发现它们就在你的身边。"
  },
  CollectionHall_95448_LockTip = {
    Text = "完成特遣纪录「雨镇幽影」"
  },
  CollectionHall_95448_Title = {Text = "头颅海"},
  CollectionHall_95449_Desc = {
    Text = "她答应过你，一定会带你一起回家。\n——以恒久的姿态，回到静谧的、奇迹和美的家乡。"
  },
  CollectionHall_95449_LockTip = {
    Text = "完成意识潜游「如歌的雕琢」"
  },
  CollectionHall_95449_Title = {
    Text = "石化艺术"
  },
  CollectionHall_95450_Desc = {
    Text = "那位尊贵的客人曾望着卡斯托尔满怀希望的背影，于月光下轻轻呢喃宿命的预言：「他会走出去，会在暴风中拼命地挣扎。那让他高飞的，也必将让他坠落。」"
  },
  CollectionHall_95450_LockTip = {
    Text = "完成异梦视界「天边之外·上」"
  },
  CollectionHall_95450_Title = {
    Text = "于暴风中"
  },
  CollectionHall_95451_Desc = {
    Text = "生于美，死于美。\n她是天才、疯子、魔鬼，她是冷漠的刽子手，也是你温情脉脉的家人。\n她用炽热的爱，将你炮制成一件完美的作品。\n她把你拥抱，将你冰冷的手牵起。她会带着你，与她一起回到艺术的家乡。"
  },
  CollectionHall_95451_LockTip = {
    Text = "完成意识潜游「如歌的雕琢」困难难度"
  },
  CollectionHall_95451_Title = {
    Text = "美的死亡"
  },
  CollectionHall_95452_Desc = {
    Text = "大海听到了我的呼唤，所以将你送至我的身边。\n从此，我们尽情谈话、嬉戏、欢闹，注定成为世界上最好的朋友。\n在这满是融蚀的死寂之城。"
  },
  CollectionHall_95452_LockTip = {
    Text = "完成意识潜游「诸事如常」"
  },
  CollectionHall_95452_Title = {
    Text = "请成为我的朋友"
  },
  CollectionHall_95453_Desc = {
    Text = "归来吧，所有勇敢的、怯懦的、聪明的、愚笨的、强大的、弱小的我。\n让所有快乐的、悲伤的、愤怒的、痛苦的、疲惫的心都融化。\n我们在一起。\n她们永远在一起。"
  },
  CollectionHall_95453_LockTip = {
    Text = "完成特遣纪录「宁静的裂殖」困难难度"
  },
  CollectionHall_95453_Title = {Text = "归于她"},
  CollectionHall_95454_Desc = {
    Text = "这来自灵魂的空虚与裂隙唯有最纯真的童话才能填补。\n终有一日，她会告别痛苦，回到童话中充满欢乐的「故乡」。"
  },
  CollectionHall_95454_LockTip = {
    Text = "完成意识潜游「诸事如常」"
  },
  CollectionHall_95454_Title = {
    Text = "天真的惊悚童话"
  },
  CollectionHall_95455_Desc = {
    Text = "那些潜伏着黑暗的、幽深又狭窄的小巷，总是承载着许多命运转折的时刻。重逢、争吵、决裂，乃至暴力、欺凌、谋杀。\n所幸的是，今日的故事没有发生后半部分血腥的场面，但谁又能说前者所招致的，不是真正的悲剧呢？"
  },
  CollectionHall_95455_LockTip = {
    Text = "完成异梦视界「天边之外·上」"
  },
  CollectionHall_95455_Title = {Text = "暗巷"},
  CollectionHall_95469_LockTip = {
    Text = "限时活动「黑阳垂照的永夏：彻夏狂欢」中领取第 1 天奖励"
  },
  CollectionHall_95469_Title = {
    Text = "黑阳垂照的永夏"
  },
  CollectionHall_95981_LockTip = {
    Text = "需要通关限时活动「死灵的美学：噬灵之飨」任一关卡"
  },
  CollectionHall_95981_Title = {
    Text = "死灵的美学：噬灵之飨"
  },
  CollectionHall_95982_LockTip = {
    Text = "通关调查行动星辰篇3-11解锁"
  },
  CollectionHall_95982_Title = {
    Text = "最初的晚餐"
  },
  CollectionHall_96314_Title = {Text = "餍飨"},
  CollectionHall_96321_Title = {Text = "葬骸城"},
  CollectionHall_96790_LockTip = {
    Text = "通关调查行动星辰篇3-1解锁"
  },
  CollectionHall_96790_Title = {
    Text = "王邸的夜宴"
  },
  CollectionHall_97150_LockTip = {
    Text = "需要通关限时活动「画布的暗面：异界画卷」任一关卡"
  },
  CollectionHall_97150_Title = {
    Text = "画布的暗面：异界图卷"
  },
  CollectionHall_97158_LockTip = {
    Text = "需要通关限时活动「坠临的万千耀光：烬灭追猎」任一关卡"
  },
  CollectionHall_97158_Title = {
    Text = "坠临的万千耀光：烬灭追猎"
  },
  CollectionHall_97208_LockTip = {
    Text = "通关意识潜游「畸世绘」任一关卡解锁"
  },
  CollectionHall_97208_Title = {
    Text = "真正的艺术"
  },
  CollectionHall_97736_LockTip = {
    Text = "需要通关限时活动「神诞的祭礼：创生七日」任一关卡"
  },
  CollectionHall_97736_Title = {
    Text = "神诞的祭礼：创生七日"
  },
  CollectionHall_97896_LockTip = {
    Text = "需要通关限时活动「如果一切如常：日光下新事」任一关卡"
  },
  CollectionHall_97896_Title = {
    Text = "如果一切如常"
  },
  CollectionHall_98502_LockTip = {
    Text = "通关意识潜游「不朽极昼」任一关卡解锁"
  },
  CollectionHall_98502_Title = {
    Text = "永燃不烬的追猎"
  },
  CollectionHall_98636_Desc = {
    Text = "亵渎者掀起幽蓝的海啸，单薄的王者孤身迎向千米巨浪。\n他的发丝于风中飞扬，他的骨与血即是他庄严的宣告，于轻蔑的笑容中，他将自己亦献于死亡与月亮。\n于是整片海在此刻凝结，倒悬的冰川静止于满月之下，一切归于寂静，一切安宁重回他的国度。"
  },
  CollectionHall_98636_LockTip = {
    Text = "完成调查行动·困难 星辰篇3-10解锁"
  },
  CollectionHall_98636_Title = {
    Text = "满月祭礼"
  },
  CollectionHall_98637_Desc = {
    Text = "烹饪死者，是一项庄严的艺术。\n他用刀与铲探问未竟的遗言，他用水与火满足最后的遗愿。\n每一块难堪的、痛苦的、酸涩的记忆，都将化作闪耀而芬芳的作品，供人品味珍藏。"
  },
  CollectionHall_98637_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98637_Title = {
    Text = "餐桌的主人"
  },
  CollectionHall_98638_Desc = {
    Text = "孩子哭闹、尖啼、蛮不讲理。\n祂即宇宙之中心，祂即此地一切法。\n祂要一切目光所及的，都围绕、依从、敬献于祂。"
  },
  CollectionHall_98638_LockTip = {
    Text = "完成调查行动·困难6-10解锁"
  },
  CollectionHall_98638_Title = {
    Text = "神明降诞"
  },
  CollectionHall_98639_Desc = {
    Text = "他收殓每一份死亡时，并不是无情地挥舞着镰刀。 \n他也曾有温热的双手，也曾有善感的心灵。\n当他品味到那灵魂的悲伤，他会随之一同落泪。\n当他饱尝到那刻骨的仇恨，他会代之降下审判。\n他以葬骸之主的名义许诺：一切亵渎死亡之人，都将消散于冰寒的浓雾。"
  },
  CollectionHall_98639_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98639_Title = {
    Text = "死神的垂眸"
  },
  CollectionHall_98640_Desc = {
    Text = "血肉腥甜的滋味与肌腱断裂的口感是他最熟悉、也最刻骨铭心的记忆。\n他早已明白，这座葬骸城得以延续至今日，并不源于生者的力量，而是源自于亡者的牺牲。\n又一抹殷红吞咽于喉舌，他闭上双眼，仔细品尝着每一丝不同的香气，将每个灵魂的味道牢牢记下，于是他的亲朋与子民都在他的身躯中永生。\n他们约定永远相聚。"
  },
  CollectionHall_98640_LockTip = {
    Text = "完成调查行动·困难 星辰篇3-10解锁"
  },
  CollectionHall_98640_Title = {
    Text = "血色契约"
  },
  CollectionHall_98641_Desc = {
    Text = "月光下的祭祀刀闪烁着诱人的光亮。\n她用一场决绝的死亡，证明了她梦寐以求的自由意志。"
  },
  CollectionHall_98641_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98641_Title = {Text = "冷月光"},
  CollectionHall_98642_Desc = {
    Text = "他教导族人们如何战斗、如何杀戮、如何生存，却从未教过，当面对数倍于自己的强敌时，如何逃命。\n因此他也不会逃。\n不过是首级而已，拿去！\n他早已看透：一心追求力量的野心家，死于追逐的途中，只是既定的结局与宿命。"
  },
  CollectionHall_98642_LockTip = {
    Text = "完成意识潜游「巨人的陨落」"
  },
  CollectionHall_98642_Title = {
    Text = "我无惧死亡"
  },
  CollectionHall_98643_Desc = {
    Text = "咔嚓、咔嚓。\n神明咧开嘴巴，欣然收下了信徒所有的虔诚，以及信徒本身。"
  },
  CollectionHall_98643_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98643_Title = {Text = "第一餐"},
  CollectionHall_98644_Desc = {
    Text = "曾经的族人一拥而上，意图绞杀他们战败又流亡的统领。而非利士史上最勇猛的领袖，拥有不屈意志的伟力巨人，以杀戮作为了回应。\n无尽的哀嚎里，巨刃渴饮鲜血，以一个又一个残缺的尸骨，诠释他的战斗风格——专横、狂妄、野蛮、残暴。\n对于敌人，无需怜悯。\n它们只是他重新走回权利至高点的，必要的阶梯。"
  },
  CollectionHall_98644_LockTip = {
    Text = "完成意识潜游「巨人的陨落」"
  },
  CollectionHall_98644_Title = {
    Text = "必要的杀伐"
  },
  CollectionHall_98645_Desc = {
    Text = "转身离开的那一刻，埃尔顿仿佛又变成了那个刚刚出海的少年，蓝天与一望无际的大海连接在一起，世界大得足够装下所有抱负与美梦。\n不一样的是，这次他已清楚地见过了美梦实现的样子，并拥有了一条通往那满是白鸟的、梦乡的归途。"
  },
  CollectionHall_98645_LockTip = {
    Text = "完成调查行动·困难6-10解锁"
  },
  CollectionHall_98645_Title = {
    Text = "白鸟之乡"
  },
  CollectionHall_98646_Desc = {
    Text = "时间已至，银月高悬。\n快把僵硬的脚尖点起，今夜要欢度这宴会时光。\n她已走到最后的旅程，而我们用胃袋为她送葬。\n一口给你，一口给我，从今往后谁都不会遗忘。"
  },
  CollectionHall_98646_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98646_Title = {
    Text = "安息舞曲"
  },
  CollectionHall_98647_Desc = {
    Text = "神迹若有形状，应如她合十的双手。\n神明若有样貌，应如她安宁的面庞。"
  },
  CollectionHall_98647_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98647_Title = {
    Text = "纯白神女"
  },
  CollectionHall_98648_Desc = {
    Text = "欢庆吧，我的朋友♪\n月光下的骸骨悄然绽放，一位挚爱被送上餐盘♪\n所有的宾客都已到来！唱呀，跳呀♪\n我们从不为亡灵祈祷，我们从不为尸首哀悼♪\n她将记忆交予了我，她将眼泪交予了我♪\n让我们咽下她的魂灵与腐肉♪\n在死亡的盛宴中，我们再度重圆♪"
  },
  CollectionHall_98648_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98648_Title = {
    Text = "食尸鬼之歌"
  },
  CollectionHall_98649_Desc = {
    Text = "人们因他的强大恐惧他、崇拜他，因他的残酷憎恨他，唾弃他，更因他的失败嘲讽他、放逐他。\n但弱者的聒噪毫无意义，巨人的目光只为强者停留。\n于荒芜的流亡之海，他将自身性命作为赌注，踏上寻求绝对力量的征程。"
  },
  CollectionHall_98649_LockTip = {
    Text = "完成意识潜游「巨人的陨落」"
  },
  CollectionHall_98649_Title = {
    Text = "踏上新的征途"
  },
  CollectionHall_98650_Desc = {
    Text = "他记得她。\n那个在风暴中被自己紧紧抱于襁褓中的孩子，最终被自己亲手送往了深渊——用以与自己的良心一起，交换那个白鸟翱翔的梦境。\n他祈盼一生的美梦已经实现，接下来，是时候该用余下的生命，去偿还所有漆黑的罪孽。"
  },
  CollectionHall_98650_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98650_Title = {Text = "偿还"},
  CollectionHall_98651_Desc = {
    Text = "别离与死亡，都是世间无法逃离的常态。\n从无数牺牲与死亡中脱离，走向渺茫的前路，淡淡的悲伤萦绕在你的心头。然而在目睹了生活于死亡之中的人们，目睹了将死亡赋予温柔结局的王者后，你已不再畏惧未知的结局。\n一朵紫色的勿忘我飘落在你的肩头，替他遥遥相送。\n你知道，无论如何，你的归途并不孤独。"
  },
  CollectionHall_98651_LockTip = {
    Text = "完成调查行动·困难 星辰篇3-10解锁"
  },
  CollectionHall_98651_Title = {
    Text = "勿忘我的送别"
  },
  CollectionHall_98652_Desc = {
    Text = "「以你们的朋友、王、这片安眠之地主人的名义，我邀请你们——苏醒吧！回到你们眷恋的故土！将这些打扰我们亲人安宁之人，永远驱逐出去！」"
  },
  CollectionHall_98652_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98652_Title = {
    Text = "万灵之怒"
  },
  CollectionHall_98653_Desc = {
    Text = "她与祂，不可共存，于是一柄匕首刺入两颗心脏，那是她向神明奉上的报偿。"
  },
  CollectionHall_98653_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98653_Title = {
    Text = "神明诞生之日"
  },
  CollectionHall_98654_Desc = {
    Text = "你从没想到，与一位王者的对谈是由一场共舞开始。\n强势的入侵，游离的试探，进攻与防守，对峙与退让，你们在旋转的衣摆中隐秘交锋。\n一场交易优雅结束在最后的谢幕，王的发丝翩翩垂落，你看到那双雾气萦绕的眼中闪烁着愉悦的笑意。\n咦？刚刚是不是被他牵着鼻子走了？"
  },
  CollectionHall_98654_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98654_Title = {
    Text = "探戈外交"
  },
  CollectionHall_98655_Desc = {
    Text = "你见过最可怖而亵渎的啖食，却是他们生命中最温柔的重逢。"
  },
  CollectionHall_98655_LockTip = {
    Text = "完成调查行动 星辰篇3-11解锁"
  },
  CollectionHall_98655_Title = {
    Text = "骸骨长眠之所"
  },
  CollectionHall_98656_Desc = {
    Text = "星星只是如常运转在它的轨道，而尘埃中的生命已因此几经沉沦。"
  },
  CollectionHall_98656_LockTip = {
    Text = "完成调查行动6-15解锁"
  },
  CollectionHall_98656_Title = {
    Text = "倒错的星辰"
  },
  CollectionHall_98657_Desc = {
    Text = "面对瞬间置人于死地的女巫，弱者恐惧、崇拜、皈依，祈求庇护。\n但他绝不。\n他看到了这股力量，渴求着这股力量，且无论需要付出怎样的代价，都要得到这股力量。\n而后，他将东山再起，再次让自己的名颂扬于非利士人所踏足的每一寸土地。"
  },
  CollectionHall_98657_LockTip = {
    Text = "完成意识潜游「巨人的陨落」困难难度"
  },
  CollectionHall_98657_Title = {
    Text = "巨人的雄心"
  },
  CollectionHall_99651_Desc = {
    Text = "<Bold:银鳕鱼24>\n每次路过那家炸鱼餐厅，我都忍不住想要尖叫。\n为什么受伤的总是银鳕鱼呢？我们甚至不是真正的鳕鱼！\n肉质紧实、味道鲜美难道也是我们的错吗？\n\n<Bold:猫咪24>\n吸溜吸溜……喵，喵喵（赞成）！\n\n<Bold:银鳕鱼24>\n在雷欧王国，每分钟就有一条银鳕鱼死于非命，成为人类的盘中餐。\n是的，就在我们说话的间隙，已经有10只银鳕鱼壮烈牺牲了。\n整整10只！父神在上，你听到它们的惨叫声了吗？\n\n<Bold:猫咪24>\n呃……喵？喵喵喵，喵喵（哪里）？\n\n<Bold:银鳕鱼24>\n只是个比喻罢了，傻瓜。你虽然蠢了点，却有一颗金子般的心，能够战胜猫的兽欲和短视。\n听着，接下来我有个计划，需要你和我一起实施……\n\n——节选自《大约翰炸鱼餐厅爆炸事件·案卷综述：证词B-03》。由于该时期伯利恒精神病院人满为患，嫌犯被拒收，在伦蒂尼恩塔内关押23天后释放。"
  },
  CollectionHall_99651_Title = {
    Text = "银鳕鱼的决心"
  },
  CollectionHall_99653_Desc = {
    Text = "为了等待「那个时刻」，少女沉睡于冰川之底。艾尔沃斯的千尺寒冰封冻了她的躯壳，却未能全然封闭她的神识。\n那缕神识来自一个孩子，也来自一位母亲。在祂女儿黑暗的子宫中，神明延续万古长梦。\n二十五年的时光中，她思考过什么，眷恋过什么，期待过什么吗？\n时至今日，这些问题已经无人能够回答。至于那位少女本人……她会否向身边之人倾诉真心呢？就让一切交给时间和未来吧。"
  },
  CollectionHall_99653_Title = {
    Text = "冰川下的沉眠"
  },
  CollectionHall_99654_Desc = {
    Text = "唯有安静死去的灵魂，才值得被细细品尝。活人的挣扎只会让味道变得杂乱无章。\n圆盘被端上来时仍有余温，一颗心脏安稳地躺在中央，表面微微鼓起，仿佛刚刚跳动完最后一拍。两枚眼球在一旁点缀，瞳孔中封存着死前那一秒钟的惊愕，被炖煮成了温顺的乳白。\n他举起刀，缓缓划开心尖，却忽然停住了。\n它的灵魂仍在嘶哑地尖叫，那一缕执念还在血管里滞留，未能完全散去。他放下刀，合起双手，静静地聆听亡灵的声音。\n这枚心脏来自一位死前饱受病痛折磨的诗人，长久的失意于死亡之中解脱，却仍有对生的遗憾留存。他知道，要让这颗心真正“入味”，需要给予美食足够的尊重，唯一的办法是等——\n等那缠绕在肉中的执念，于死亡中彻底崩解；等亡者记忆的最后回声化为沉香，在血管壁上默默渗出。\n他将双手优雅地交叠放在膝头，闭上眼睛，深吸一口。\n香气在空气中缓缓扩散，那是一种复杂而温柔的气味，既有情人的颤抖，又有离别的苦涩。混杂着墨香、草药味与一丝清晨露水般的胆怯。\n他静静坐在生命枝繁叶茂的树下，等待着成熟的果实如期坠下。"
  },
  CollectionHall_99654_Title = {Text = "珍馐"},
  CollectionHall_99655_Desc = {
    Text = "一束放置太久而枯萎干涸的花。\n永远等不来它的主人。"
  },
  CollectionHall_99655_Title = {
    Text = "未送出的花"
  },
  CollectionHall_99656_Desc = {
    Text = "从诞生起，双子就不被允许随意使用翅膀飞翔，他们背上生长的第二双手臂更像是两对展示圣子威仪的礼器，被时时刻刻规定着应有的姿态。\n小时候，波吕克斯是两人之中最为爱护那双翅膀的，每日梳理、涂抹精油，将那些羽毛养护得绸缎一般闪闪发亮。\n他总是趁着短暂的无人时刻，偷偷地扑腾起那双羽翼初丰的翅膀，在卡斯托尔的惊骇中摇摇晃晃地离地，去触碰那些绘着雕饰的穹顶。\n比起波吕克斯能使双翼做出种种舞蹈般的灵活姿势，卡斯托尔常常觉得自己的翅膀笨拙如两块木板。双子每天就寝后的秘密时光里，卡斯托尔就这样静静地注视着波吕克斯于黑暗中跳跃、旋转，于狭小的笼中模仿飞翔。\n「弟弟的翅膀真好看，不过我的话，可能一辈子也学不会飞翔了。」卡斯托尔想。\n于是在后来他们出逃的那一夜中，卡斯托尔第一次感受到晚风托举着双翼的凉爽与轻松。更加熟练的波吕克斯紧紧抓着飞得歪歪扭扭的哥哥，在高空开怀地大笑，飞出一条条俯冲、旋转的弧线，就像一只真正的、属于天空的飞鸟。\n卡斯托尔偏过头，看月光镀在波吕克斯那双纤长而有力的翅膀上，在羽毛间反射出令人目眩的青绿色光晕。\n「那一定是世界上最美的东西，无论面对什么，我一定要保护波吕克斯，保护住那双翅膀。」\n很快，艰难的野外生活让波吕克斯的翅膀被野兽所伤，卡斯托尔心疼地拾起波吕克斯掉落的飞羽，将它收在了怀里，默默发誓不会让这种事发生第二次。但他不知道的是，日后这片孤单的羽毛将变成他最珍贵的东西，变成他最后留住的、关于那双翅膀的遗物。"
  },
  CollectionHall_99656_Title = {Text = "孤羽"},
  CollectionHall_99657_Desc = {
    Text = "嘟——嘟——\n鸣笛声中，游轮在克珀珊特的指引下安全靠岸。\n乘客们欢笑着走下舷梯，举帽向她感谢，水手们则涌了过来，表达夸赞。\n「干得好，克珀珊特，要不是你提前预警，我们就要被风暴吞没了。」\n「是啊，多亏你的正确指引，我们才没有迷失在大海上！」\n水手们笑起来，拍她的肩，向她竖大拇指。\n事实上，克珀珊特始终无法适应这样近距离的社交，她古板而基于理性的大脑，没有「工作」与「职责」外的任何思考。\n于是，她只好将这也归于「工作」与「职责」的一部分。\n「我只是完成了自己的工作而已。身为领航员，我的职责便是引导你们平安归航。」\n客套而无趣的回复，但熟知她为人的水手们却是大笑起来，向她道别，唱着船歌，勾肩搭背离开海港。\n「诺第留斯号终于能出航了。出发，诺第留斯号。」\n歌声渐渐远去，而克珀珊特仍留在岸边。她在为未来的启航做准备。\n大海喜怒无常，没有领航员能保证自己每次都能胜利，她也是。但她愿意为了增加哪怕一丝的胜算而付出无数的时间。\n检查、巡逻、学习、核对，她的生命里似乎只剩下了「工作」这一件事情。\n但她心甘情愿，因为这一切，都是为那一刻，那成功领航，带领大家平安归来的那一刻。"
  },
  CollectionHall_99657_Title = {
    Text = "海上领航者"
  },
  CollectionHall_99658_Desc = {
    Text = "在无尽的深渊中，青色王座屹立，\n天幕低垂，星辰颤抖，万物沉默。\n\n古老而又神秘的存在已然湮没，\n世世代代，众生在梦中颂歌。\n幽暗的水域，尘封的秘密，\n你的低语如潮水涌来，淹没心灵的沟壑。\n\n在那无边的梦境，先知与狂徒同游，\n追寻无形的灵魂，恐惧与敬畏交织。\n青藻缠绕的轨迹，宛如命运的编撰，\n将迷失者的心，逐渐引向那青色王座。\n啊，宇宙的荒谬与真理，\n在梦与现实交错之处，永恒的辉光闪烁。"
  },
  CollectionHall_99658_Title = {
    Text = "青石王座"
  },
  CollectionHall_99660_Desc = {
    Text = "人人都想战胜命运，人人却也畏惧命运。\n勇敢者发出战斗的怒吼，怯懦者发出顺从的低吟，然而只有他发现了战胜命运的秘密。\n那就是不断邀请命运共赴赌局，催促命运开盘下一场。\n他从未畏惧过命运，因为他相信自己不会输。\n他从不询问要赌什么，无论要摆上什么筹码他都毫不犹豫，包括自己的生命。\n凭借一把轮盘赌的手枪，他吓退了无数赌红眼的手下败将，成为了伦蒂尼恩臭名昭著的赌疯子。\n真遗憾啊，没有势均力敌的对手是多么寂寞。\n直到他遇到了那个男人。\n他打败了无数凡人，终于坐上了命运的赌桌。\n很快他失去了自己的一切，又连本带利地重获了所有。\n直到重生为野兽时，他又在地上看到了那把终于射出最后一颗子弹的手枪。\n他将一颗子弹重新装填，对着自己的头再次按下了扳机。\n在一片寂静中，他咧开了嘴。\n他还没有输，那么总有一天他会赢到最后。\n他始终这样相信着，即便要赌上所有。"
  },
  CollectionHall_99660_Title = {
    Text = "命运轮盘赌"
  },
  CollectionHall_99663_Desc = {
    Text = "那位神秘的女士是在葬礼后找上她的。\n「可怜的孩子，」她说，「你本不用受这无妄之灾。」\n「你不知道吗？在他害死米莉后，汤普森找上了他。那个名为爱德华的渣滓本该在去年就死了，但一个人给予了他帮助。」\n「你说为什么？喔，这我又如何能知道呢。或许，他们本就是蛇鼠一窝，或许……那位罪人自己也不知道自己所做的是罪。他是怎么说的来着？对，宽恕。对罪人的宽恕，对他们犯下的罪行的宽恕。」\n「他相信人都应该有第二次机会，你怎么看？我们应当再给爱德华一次机会吗，在他先后害死米莉，害死你姐姐，你母亲之后？」\n「没错，这种人不会改，永远也不会。所以，你知道怎么做吧？」\n没错，这种人不会改，想要终结这种人，这种罪恶，这样的悲剧，只能……\n将他们的欲望暴露，让他们丑态尽显，看他们彼此厮杀、彼此争斗，把他们彻底净化——\n迎来无罪的净土。"
  },
  CollectionHall_99663_Title = {Text = "镜中人"},
  CollectionHall_99666_Desc = {
    Text = "茫茫多的羊群徘徊在茫茫大的草原上。\n这世上有太多太多的羊，而羊生来就是需要牧者引领的。\n她一直是这世界的先知，手中握着知识的权杖。\n她一直是一个好牧人，始终决心将羊群引向正确的道路。\n她用那杖管教羔羊，她用那杖赶走豺狼。\n她高举着牧羊人的手杖，因她总能提前看清前路。\n曾经她引领羊群走向丰沛的水源、走向鲜嫩的草场。\n现在她目睹了世界的真相，于是引领羊群走向终极的怀抱。\n向这边走，不要回头。\n她笑着挥舞智慧的手杖。\n于是羊们看不到前方的悬崖。\n一只，两只。\n羊儿坠下，牧人欢唱。\n请跟随着无私的牧羊人吧，她已为你指明了最真切的前路。\n不必害怕，即便行过死荫的幽谷，她的杖依然与你同在。\n直到一同步入湮灭的深渊。\n"
  },
  CollectionHall_99666_Title = {
    Text = "牧羊人的手杖"
  },
  CollectionHall_99667_Desc = {
    Text = "祂伏行于无垠的混沌中，偶尔才对匍匐世间的众生投去一缕瞥视。\n\n那些尚可入眼的，譬如索蕾尔，祂向他们提供难以被拒绝的「契约条款」。\n那些粗陋乏味的，祂褪去他们的肉身，留下一只再也无法落泪的眼睛。\n这些眼睛又被唤作「蒙宠者」。\n\n它们在洞穴中忽明忽暗，既满怀希望，又充满绝望，等待祂的召唤。\n然而一千年过去，一万年过去，蒙宠者继续被遗忘在黑暗的角落。\n\n「那……你们一定是因为某种理由才被留下吧。你们的使命是什么？」\n「我们在等待。」\n「等待什么？」\n「等待……就只是等待而已。」\n「会感到痛苦吗？」\n「恰恰相反。对大人的爱充盈我们全身。因为这是我们唯一能做的事。」\n「只有理解这一点，才能成为真正的信徒。」"
  },
  CollectionHall_99667_Title = {
    Text = "百万蒙宠之眼"
  },
  CollectionHall_99668_Desc = {
    Text = "她的名字即是智慧的化身。\n她知晓世上的一切知识，是弥萨格所有学者向往的终极。\n只要能聆听只言片语，便能获得醍醐灌顶的开悟。\n但她说，自己只是一个守门人。\n那是一扇什么样的门？\n没有人见过那扇门，学者们便将其称为真理。\n她是真理的守门人，是守护着弥萨格的雅典娜。\n塔薇并没有否定这样的猜测，只是始终如一地注视着这里，注视着这个世界。\n无言而悲悯。\n如果你有一天看到了那扇门，你会看到门上有一只极其熟悉的眼睛。\n那目光沉静而恒久。\n穿透了时间，穿透了你的灵魂。"
  },
  CollectionHall_99668_Title = {
    Text = "真理之门"
  },
  CollectionHall_99670_Desc = {
    Text = "沐浴黑血而重获新生的少女，在沙漠萦绕千年的风沙之中，托举起丰穰母树神圣的血之种。\n\n「只要这颗种子存活于世，树的血脉就不会断绝。」\n\n自那之后又是千年，这颗种子随着树的后裔见证了荣辱兴衰，体验了流离失所，经历了不知所踪，消亡而后重生，直到滔滔河水化为黏稠的黑血，它也完成了最后一次传承。\n那是个炽热滚烫而纠缠不休的吻，饱含尚未满足的渴望和未及启齿的离愁别绪，与温暖的心跳一起将新的传承者重重包裹。\n那玛瑙般的色彩、白玉般的光泽，将随着生命的搏动一起跨越黑色的终末。\n然后新世界的第一颗树种，将在她的祝福下拔地而起，化作覆盖天地的巨木。"
  },
  CollectionHall_99670_Title = {
    Text = "灼热的吻别"
  },
  CollectionHall_99671_Desc = {
    Text = "获得新生后的克莱门汀就像一只懵懂的幼虫，穿行于人间，穿行于不属于她种族的繁华世界，感到迷茫，感到困惑。\n直到那带来启迪般的声音响起——\n「请问，你是夏洛蒂医生吗？我来找、找夏洛蒂医生做心理咨询……」\n克莱门汀终于回过神。她不在乎夏洛蒂是谁，只是好奇来者口中的新名词：「心理咨询」。\n但她是个成熟的猎手，绝不会暴露自己的无知，因此她笑了起来，仿佛她就是夏洛蒂，就是来者口中的救赎。\n泪水、折磨、无助，无需撩拨，来者就已经榨出了灵魂深处的痛苦。\n离开前，对方一脸轻松地看向克莱门汀，感慨：「谢谢你愿意倾听这些。我感觉自己好多了。」\n然后，就是关门声，以及克莱门汀因初次品尝到甘美而响起的笑声。\n这笑声起初些微，犹如幼虫的嗡鸣，随后越来越大，仿若成虫的嘶叫。\n而于这笑声里，名为克莱门汀的虫族，也迅速成熟。\n随后的一切，顺理成章。她成为了心理医师，带着笑容与灵摆，深入一个个患者的内心。\n她依旧行走于人间，依旧不属于这个繁华的世界，但却不再迷茫和困惑。\n因为整个人间和世界，都是她的催眠猎场。"
  },
  CollectionHall_99671_Title = {
    Text = "催眠灵摆"
  },
  CollectionHall_99672_Desc = {
    Text = "太阳每秒散发出超过300秭焦耳的能量，它们中的数十亿分之一会以光和热的形式，行驶超过147亿米的路程，从太空向地球袭来。\n这些能量满足了地球上所有生物的需求，让这复杂、庞大、混乱的三域中的所有物种可以顺利地进行繁衍，进化。\n\n「这是世界的真理，任何情况都不会改变。」\n他不断这么告诫自己，以此维持精神得稳定。\n「可为什么……这么热，这么亮。」\n因为那147亿米外之物，正缓缓占据他的眼瞳。\n光和热从他瞳孔中散出，灼烧着每一寸华贵的躯体。\n「我理解了，我理解了，我理解为何光会在8分20秒之后，才会来到地球。」\n「因为我们无法支付，直面光辉的代价。」\n当他接受一切时，他开始放声大笑。\n「原来我比伊卡洛斯，更加接近太阳。」"
  },
  CollectionHall_99672_Title = {
    Text = "迫近的太阳"
  },
  CollectionHall_99673_Desc = {
    Text = "「还不够完美，今晚再练十遍，你的天赋平平，想进入乐团就要更加勤奋，知道吗？」\n「是，父亲。」\n什么样的演奏才叫完美？\n他的双手不停飞舞，不容许自己出现一个失误。\n他斥责自己的杂念，鄙夷自己的平庸。\n无数音符环绕在眼前，每天，每天，他生活中的一切只有音乐。\n好在他每天都离完美的演奏距离更近了一些，他望着梦中道路尽头的光芒，又仿佛永远也无法触及。\n渴求完美已经刻入他的灵魂，然而不是所有人都愿意这样。\n「为陛下、为世人呈现最完美的音乐，这难道不是乐团的职责吗？」\n他望着一张张暗含不满的脸，如同鄙视曾经的自己。\n父亲，宫廷乐团也不过如此。\n他抛下了曾经仰望的目标，执拗地继续走上追寻完美的路。\n他无法停下双手去拉住他们的手，正如他无法停住曾经那个自己的手。\n每天，每天，他都在不停演奏着。\n音乐就是他的生命。\n除了音乐，他一无所有。"
  },
  CollectionHall_99673_Title = {
    Text = "永不停歇的演奏"
  },
  CollectionHall_99674_Desc = {
    Text = "她站上山峰，举起手中的黑刺。\n在漫天的风雪里，她迎上了那座疯狂的山脉，迎上了自己被抛弃、被背叛、被践踏的命运。\n她终将胜利，冰雪终将消融，到那时，她将以一个崭新的姿态，重现于世。她是这样说的。\n艾尔沃斯是极寒之地，那里的风雪终年不散。这是常识。就像再强大的战士也无法与崇高的存在抗衡，就像再强大的人也无法战胜自己的命运。\n可那雪山终究还是消融了，不是吗？"
  },
  CollectionHall_99674_Title = {
    Text = "待到雪山消融"
  },
  CollectionHall_99676_Desc = {
    Text = "第一任王夫来自伊萨拉乌。\n他长着一对伊萨拉乌人特有的眼珠，淡淡的金色，在远空漆黑的夜里闪耀着微弱的光。\n但那光芒随着伊萨拉乌的陷落而消失，旺达从漆黑的泥沼中捞起最后的载体，珍而重之地仔细收藏。\n她与第二、三任王夫相遇于弗兰高地。\n那是一对贪婪的领主双胞胎，旺达曾希望借助他们的力量，重建那失落的湖中之城。\n她受到了欺骗，因此，脊刺深深埋入了他们的骨髓。在麻痹中，旺达取出了那两对卑贱而无礼的眼睛，而后留下它们，作为自己来过的痕迹。\n第四任王夫，旺达记得他叫「约翰」。\n他是个无趣的哑巴，但伺候得她足够舒心。更让她开心的是，「约翰」也有双淡金色的眼睛，和她的几乎一模一样。\n\n「把王夫的眼睛剐出来吧。」\n「谨遵您的希望……但，王夫是做错了什么吗？」\n旺达摇晃着杯中浑浊的水，感受毒素在舌尖徜徉。真是个蠢材，连下毒都做得如此粗劣。\n看着「约翰」爬满融蚀的身体，她想起了还在遥远星外时，目送着她离开了故乡的一双双死寂之眸。\n和「约翰」此时的眼睛如出一辙。\n「……就说他，缺少幽默感吧。」"
  },
  CollectionHall_99676_Title = {
    Text = "伊萨拉乌的目光"
  },
  CollectionHall_99678_Desc = {
    Text = "自从她的诗篇风靡西岱，好友便更加殷勤地为她送来鲜花。\n「用不了那么多花，柯蕾特，这实在是太浪费了。」\n今天拿来的玫瑰与昨天、前天、大前天的堆在一起，旧的花朵甚至开始因过于拥挤而腐烂。\n「怎么会浪费呢，我们从前说好的，用我的花换你的诗。」\n柯蕾特摇了摇头，有些讪讪地望着她。\n是啊，用花换诗，这是她们的约定。她能感觉到，某些事情似乎变了，但她不愿意再往下想。\n她继续写诗，不分昼夜地写诗。从前她的诗会自然从笔端流淌而出，如今，她的笔竟然有些滞涩起来。\n好友送来鲜花时的眼神让她越来越陌生，她看着满屋匆匆烂掉的玫瑰，闻着那些凋零的腐臭，由衷感到惋惜与惆怅。\n可她从来没有停下过手中的笔。\n「我会靠这块土地上长出的花，给我们买衣服，买吃的。总有一天，就连上面那栋楼房里的房子，我也要买下来！」\n「每个人都有自己生来就要做的事。我生来就是要为这个花园、为那间房子努力……而你，你生来就是要写诗的。」\n「我相信你，奥尔拉！从今天开始，你的所有诗我都会帮你好好珍藏起来。以后，我就用我的花，来换你的诗吧！」\n花与诗，是她们给对方的承诺。\n她永远不会停下手中的笔。"
  },
  CollectionHall_99678_Title = {
    Text = "往昔的花与诗"
  },
  CollectionHall_99679_Desc = {
    Text = "魔女和宽檐帽子的因果，有时就像鸡与蛋的关系，分不清是帽子成就了魔女，还是魔女成就了帽子。\n不过总之，达芙黛尔就拥有这样一顶足够优雅的宽檐帽。\n这顶帽子最初属于曾经的店主，那时达芙黛尔的名字还不属于达芙黛尔，她尚且只是一个刚刚被制服的、迷茫的幽魂，一头懵懂的野兽。\n那个总是微笑着的女人带着她，如同教育孩童般，耐心地、一点点地教给她成为一个「人」的方法，以及与人打交道的秘诀。\n海港之城商贸繁华，汇聚了彼时人类文化最丰富的结晶。交换商店所在的街道上林林总总的店铺几乎包罗万象，而店主总能神奇地与所有店家老友般聊上天。\n「她真厉害。」那时的达芙黛尔心想，「但也没什么奇怪的，没有人会不喜欢她。」\n店主喜欢逛街，于是那便是千年来一直扮演着一个个被她斩下头颅的人类的达芙黛尔，第一次被要求给出自己的建议。\n「你觉得哪一顶好看？这一顶小礼帽，还是这顶宽檐帽？」\n女人对着镜子，来回试戴着琳琅满目的帽子们。原本对于达芙黛尔来说，这些不过是用来包裹身体、将自己装点得更像人类的道具。\n但那一天，她看着店主头上像一朵巨大花朵般的宽檐帽，脑海中忽然浮现出了女人戴着这样的帽子，和自己在海边沙滩上散步的样子。\n「这顶。」她突然开口，「就这一顶。」\n店主有些讶异地回过头，像是没有想到她会如此明确地表示自己的喜好。\n「好啊，确实是一顶好帽子，既然是你为我选的，我一定会好好珍惜的。」\n不知道是不是为了鼓励达芙黛尔，这顶帽子如店主承诺的那样，成为了她头上的常驻装饰，直到最后从她逐渐滑落的手中亲手交给达芙黛尔，与她微笑着的头颅一起。\n「真是一顶好帽子，我一定会好好珍惜的。」\n靡丽盛开的紫黑花朵，终于绽放在了新主人的头颅上。"
  },
  CollectionHall_99679_Title = {
    Text = "魔女宽檐帽"
  },
  CollectionHall_99683_Desc = {
    Text = "王座的幻梦中，王聆听神明的启示：\n利莫里亚的风暴将平息。利莫里亚的深渊将消逝。\n以梦境为庭，以星辰为烛。王将庇护他良善的子民，带来神的国度。\n\n吾主之信徒，敞开你的心怀，接纳吾主。\n在遥远的黯淡深渊，古老的伟大灵魂沉眠，倾听诸神的低语。\n祂的意志如星辰之网交织，祂在永恒的虚无中候汝入梦。\n\n风暴静伏，水波不兴；\n地震平息，大地安宁。\n灾祸在祂的宁静梦境中化为虚无，\n子民在祂的庇护下安然无恙。\n愿我们的歌声穿越深海，愿祂赐予我们免受灾难的神谕，\n领我们前往无尽的安宁与极乐之境。\n我们的信念与祂同在，直至星辰消亡，直至时间尽头。\n"
  },
  CollectionHall_99683_Title = {
    Text = "深海的呼唤"
  },
  CollectionHall_99684_Desc = {
    Text = "开始向食尸鬼转变的第七日，他在四肢日渐糜烂的剧痛中呻吟。每一次细微挪动都牵扯着敏感神经，迸发出撕裂般的痛楚……与令人战栗的灵感火花。\n然而，惶惑的阴影始终笼罩着这位艺术家——究竟要怎样的画笔，才能描绘出那最为极致的真实？\n皮克曼虚弱的眼睛四处搜寻着，从宅邸边的砖石到坟墓上的树枝，终于，目光锁定在他萎缩溃烂的右腿中那截裸露的白骨。\n如同听见了某种神圣的召唤，皮克曼将腿骨取出，指腹一遍遍磨去粘连的血肉，将它制成坚硬的画笔。\n他将笔尖磨成锋利的獠牙，但笔尖在咬上画布前，却先刺入了主人枯瘦的指尖。皮克曼吃痛松手，画笔逃脱了他的控制。\n飞舞！跳跃！旋转！它在画布上狂舞，刻下错乱癫狂的线条。线条增殖疯长，拖曳出一团不断膨胀、形态诡异的暗色污迹，缓慢而坚决地噬咬住皮克曼的咽喉。\n瞬间的狂喜如利刺穿透他残存的心脏——那肿胀的器官、混沌不堪的形态，令他颤栗惊怖，却也复苏了行将枯萎的感官。它们以颠倒无序的方式，直接、锐利地昭示着痛苦、怪异与欲望，爆发出不加掩饰的震撼力量。\n在这倒错之中，皮克曼仿佛更接近了「美」的圣境。\n待一切平息，皮克曼伸出已被腐蚀的利爪，反复摩挲着那支苍白的画笔。这具尚存人形的躯壳里，喷薄出更炽热、更迫切的渴望。\n他将与这只画笔一同，完成那幅旷世画作的最后一笔。"
  },
  CollectionHall_99684_Title = {
    Text = "渴求的画笔"
  },
  CollectionHall_99687_Desc = {
    Text = "「圣子是持灯者注视之人，生而受到祂的眷顾。」\n「圣子应传播祂的旨意，将光明赐予虔诚的义人。」\n「圣子需保持灵魂的洁净。」\n「圣子应戒除俗欲、虔诚修行，全心侍奉光明。」\n「圣子不可多言、不可妄语。」\n「圣子应远离罪孽、远离有罪之人，不可被污浊的灵魂污染。」\n「圣子……」\n从他有记忆开始，一条又一条戒律就如锁链般束缚着他，将他捧上尊崇的高台，又令他不可失仪、不可低头、不可放纵喜怒。\n他被披上宽大而华丽的衣袍，簇拥在无数侍从之中，按照要求扮演那个神圣的代表，俯视着虔诚的信徒匍匐跪倒、小心亲吻他的衣角。\n圣子本应如此，无人在意那副高傲而不变的面容下，究竟有怎样的情绪与喜好。\n正如他习惯了那高傲的笑容，在无人之时亦不知自己真正想摆出怎样的表情。\n「波吕克斯圣子，您该前往赐福仪式了。」低垂头颅的侍女恭敬地安排着他一成不变的生活。\n他转过身，昂起头，露出那同样一成不变的笑容，如同亲手戴上一张神圣的面具。\n那些迷茫、空虚和寂寞，都被遮盖在面具之下，如同从未存在。"
  },
  CollectionHall_99687_Title = {
    Text = "圣子尊容"
  },
  CollectionHall_99691_Desc = {
    Text = "故事中存有魔法，弗朗西斯曾这么告诉莉莉。\n那时她会捧着故事书坐在窗边，初夏的阳光将白大褂烤得微微发烫，散发出温暖柔和的馨香。\n她语调轻缓，娓娓道来，但昨夜长时间精神专注于手术积累了太多疲劳，故事尚未抵达终点，弗朗西斯便沉沉睡去。\n莉莉从未因此责怪母亲，因为母亲倚靠窗沿的疲惫睡颜如此令人安心。\n\n如今胶片代替书本承载了故事与魔法，正如新的胶片取代因孩子们的不慎而曝光破损的胶片，正如新伙伴们的嬉闹取代了过往温暖和疼痛交杂的小憩时光。\n但那些被埋藏的回忆依然如曝光的胶片般，沉睡在某个不为人知的角落，纵使永不见天日，依然熠熠生辉。"
  },
  CollectionHall_99691_Title = {
    Text = "35mm的魔法"
  }
})
return Text_CollectionHall
