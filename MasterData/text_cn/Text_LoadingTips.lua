__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "同调率，即调查员、守密人与自己搭档的唤醒体的精神同调程度。\n同调率越高，调查员、守密人与唤醒体的了解越深，关系越密切，信任越牢固。"
  },
  LoadingTips_17466_LoadingTips = {
    Text = "密境中，情感、思绪、思维、执念等都可能具有可观测的投影。这些投影一般是虚幻的物品，是精神维度对现实维度个体的感官的欺骗。"
  },
  LoadingTips_17467_LoadingTips = {
    Text = "灵知转印器是一种内置在调查员、守密人手提箱中的特殊仪器，可以将意识精神转印成仅通过融蚀观察设备查看的高维卡牌：指令卡。"
  },
  LoadingTips_17468_LoadingTips = {
    Text = "融蚀裂隙一经生成，无法缩小，无法终止。\n寻常手段无法对融蚀裂隙产生影响，但银钥匙可以在一定程度上压制甚至“关闭”裂隙。"
  },
  LoadingTips_17469_LoadingTips = {
    Text = "大部分受融蚀侵蚀个体，思维亦会受到干扰，会出现偏执、强迫症、亢奋等精神异常，且伴随记忆力减退。"
  },
  LoadingTips_17470_LoadingTips = {
    Text = "融蚀侵蚀会发生在包括人类、动物、植物等有机生物体上，也会出现在矿物、金属等无机物上。\n目前尚未发现能够免疫融蚀现象的物质。"
  },
  LoadingTips_17471_LoadingTips = {
    Text = "绝大多数人类无法通过肉眼观测融蚀现象。"
  },
  LoadingTips_17472_LoadingTips = {
    Text = "依照异变的不同，可将融蚀体大致分为不同类型。其中最常见的为协作型融蚀体，干涉型融蚀体及复合型融蚀体。"
  },
  LoadingTips_17473_LoadingTips = {
    Text = "融蚀现象出现在物质上时的表现，体现为单个或数个类倒三角形状的小型开洞。\n这些开洞的尺寸约在3mm～1cm之间，随着融蚀的进展，融蚀痕会逐渐扩大。"
  },
  LoadingTips_17474_LoadingTips = {
    Text = "融蚀是物质出现的一种特殊消解、溶解的现象，具有区域性特征。"
  },
  LoadingTips_17475_LoadingTips = {
    Text = "融蚀现象发展到一定阶段后，有一定概率从融蚀痕中生出赘生物。\n它们可能是额外的肢体、触手，也可能是齿轮、金属……"
  },
  LoadingTips_17476_LoadingTips = {
    Text = "融蚀浆具有憎水性，不透水也难溶于水，黏度中等且具有一定延展性。\n数百年前，莽撞的人类曾试图将它当作工业和艺术的原料。"
  },
  LoadingTips_17477_LoadingTips = {
    Text = "「欢迎来到谷仓——这里拥有最多的档案柜，和最少的葬礼。」\nCMT档案和记录局因其谐音性质，又被审查会的人戏称为「谷仓」。"
  },
  LoadingTips_17478_LoadingTips = {
    Text = "雕塑家协会的成员有时会自称「皮格马利翁」，他们的组织标志亦是一把刻刀。"
  },
  LoadingTips_17479_LoadingTips = {
    Text = "融蚀不为世俗所认知，但在某些隐秘的结社中，人们坚信融蚀并非灾难，而是神明的赐福。"
  },
  LoadingTips_17480_LoadingTips = {
    Text = "直径超过5米，且仍有扩大可能性的巨大融蚀痕，被称为融蚀裂隙。\n裂隙的核心被称为「灾厄」。"
  },
  LoadingTips_17481_LoadingTips = {
    Text = "应急灵知体能直接作用于唤醒体的精神，激发唤醒体的潜力，瞬时恢复唤醒体的状态。唯一的缺点就是其高昂的造价。"
  },
  LoadingTips_17482_LoadingTips = {
    Text = "外勤任务瞬息万变，具有很强的不可控性。\n针对这种情况，弥萨格大学为外勤人员提供了一些紧急装置，以最大可能保障他们的安全。"
  },
  LoadingTips_17483_LoadingTips = {
    Text = "调查员、守密人调查的一般都不是普通的现实事件，而是涉及融蚀、融蚀体等与精神维度有着极大联系的特殊事件。"
  },
  LoadingTips_17484_LoadingTips = {
    Text = "在有融蚀现象的区域，精神维度的投影更加清晰，密境也更容易被观测到，但也更多变和危险。"
  },
  LoadingTips_17485_LoadingTips = {
    Text = "依照不同的特质，唤醒体大致被分为深海、血肉、超维及混沌四个界域。"
  },
  LoadingTips_17486_LoadingTips = {
    Text = "钥冢仪式后，调查员和守密人需与所搭档的唤醒体进行一次有教师监督的外勤任务，以确保具备日后独立执行外勤任务的能力。"
  },
  LoadingTips_17487_LoadingTips = {
    Text = "密斯底亚审查会（简称CMT）是由各国政府共同建立，却又独立于政府存在的，由普通人类构成的隐秘组织。\n它是融蚀现象的第一发现者、第一响应者，\n也是普通人类对抗融蚀的第一战线。"
  },
  LoadingTips_17488_LoadingTips = {
    Text = "同一界域中的不同唤醒体能够更好地配合彼此，不同界域之间可能存在一定的排斥。\n仅有混沌界域不存在此现象。"
  },
  LoadingTips_17489_LoadingTips = {
    Text = "银芯一般以两种形态存在在现实世界中：银芯源液，及斜方六面体银芯。"
  },
  LoadingTips_17490_LoadingTips = {
    Text = "诺斯指数是测量精神碎片在银芯中的稳定性的数值。\n数值越高的唤醒体，失控的可能性越低，失控后可能造成的伤亡也越少。"
  },
  LoadingTips_17491_LoadingTips = {
    Text = "一把银钥匙的诞生需要经过一系列复杂的工序，最后会刻上唯一的编号。\n银钥匙严禁交易、严禁转赠，无主时将由弥萨格回收。"
  },
  LoadingTips_17492_LoadingTips = {
    Text = "禁忌的典籍锁在图书馆书架最高处，只有具备权限的人才能查阅。"
  },
  LoadingTips_17493_LoadingTips = {
    Text = "依照《密斯底亚协定》中的相关条款，弥萨格大学会向密斯底亚协定审查会提供银芯科技的相关支持，以便共同抵御融蚀，应对危机。"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "每个个体在消解时，能析出的银芯的量不同。\n精神力越强的个体，在被融蚀消解后能析出的银芯越多，反之则越少。"
  },
  LoadingTips_17495_LoadingTips = {
    Text = "银芯科技中具有代表性的物品有：融蚀观察设备，弥萨格大学通讯器，银钥匙等。\n其中最特殊也是最珍贵的是银钥匙。"
  },
  LoadingTips_17496_LoadingTips = {
    Text = "唤醒仪式中，调查员、守密人会使用银钥匙增强银芯与精神维度的联系。\n利用这一联系，调查员、守密人能抓取游荡在精神维度中的精神碎片，并将其固定在银芯之中。"
  },
  LoadingTips_17497_LoadingTips = {
    Text = "唤醒体由银芯强行从精神维度抓取精神碎片并固定而来，而精神碎片受到精神维度的影响。因此，所有唤醒体被唤醒后都天然处于癫狂状态，直到有调查员、守密人与其建立链接。"
  },
  LoadingTips_17498_LoadingTips = {
    Text = "弥萨格大学，建立于洪积187年10月16日，是一所致力于研究融蚀、对抗融蚀的高等学府。"
  },
  LoadingTips_17499_LoadingTips = {
    Text = "弥萨格大学前身，弥萨格学院，于洪积90年10月16日，由华德·菲利普斯及另两位创始人一同建立。"
  },
  LoadingTips_17500_LoadingTips = {
    Text = "持有银钥匙的调查员、守密人可以顺利通过校外迷雾，与已链接的唤醒体一同进入校园。"
  },
  LoadingTips_17501_LoadingTips = {
    Text = "315年前，一场浩大的灾难席卷全球。\n人们以灾难发生的这一年为元年，开启了一个新的纪年——洪积。"
  },
  LoadingTips_17502_LoadingTips = {
    Text = "「愿银钥指引前路。」\n弥萨格大学成员们的常用祝语，蕴含了弥萨格人一往无前的信念。"
  },
  LoadingTips_17503_LoadingTips = {
    Text = "「誓以剑刃刺穿黑暗。」\n密斯底亚协定审查会成员的常用祝语，蕴含了审查会成员与融蚀抗争的坚定决心。"
  },
  LoadingTips_17504_LoadingTips = {
    Text = "那些相较于一般调查员拥有更多能力、能够链接更多唤醒体的特殊人才，会被授予守密人称号。\n迄今为止，能以守密人之名行走于世间的寥寥无几。"
  },
  LoadingTips_17505_LoadingTips = {
    Text = "通常而言，一名调查员同时只能链接一位唤醒体。但也不排除有特殊案例。"
  },
  LoadingTips_17506_LoadingTips = {
    Text = "没有外勤任务时，调查员、守密人与其搭档唤醒体会在弥萨格大学内休养生息。\n他们都需要上课、参加考试，以及完成冗长的课余作业。"
  },
  LoadingTips_17507_LoadingTips = {
    Text = "所有唤醒体的唤醒都需要符合《密斯底亚协定》的相关规定，唤醒后也需要进行登记。"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "严格意义上来说，唤醒体也是银芯科技的一种。"
  },
  LoadingTips_36756_LoadingTips = {
    Text = "依照裂隙的类型不同，一个裂隙可能具有一个或多个被称为「灾厄」的核心。"
  },
  LoadingTips_36757_LoadingTips = {
    Text = "弥萨格在《调查员精神构成与其潜力》的理论基础上发展、完善并定制了一系列筛选流程，以尽可能多地在不惊动普罗大众的前提下发掘潜在调查员。"
  },
  LoadingTips_36758_LoadingTips = {
    Text = "每个人的精神不同，每个守密人的特殊能力也不尽相同。\n目前已知的能力有：共享记忆、共享情感、感知情绪等。"
  },
  LoadingTips_36759_LoadingTips = {
    Text = "315年前，一场大洪水席卷了世界。秩序崩溃，城市倾塌，海底的高山骤然隆起，形成新的陆地。"
  },
  LoadingTips_36760_LoadingTips = {
    Text = "雷欧坊，雷欧王国的通用货币。市面上还流通着以缅、片什为主的辅币。1雷欧坊等于10缅，1缅等于10片什。"
  },
  LoadingTips_36761_LoadingTips = {
    Text = "借助仪器和银芯的帮助暂时独立出来的，不受其他精神影响，也不受现实维度影响的特殊空间，被称为人工密境（Artificial Domain）。"
  },
  LoadingTips_36762_LoadingTips = {
    Text = "通过电梯，可以抵达弥萨格地下空间。\n除了伦蒂尼恩最大的L-01号裂隙“黑池”外，这里还有各类限制区域，需要一定安全等级才能进入。"
  },
  LoadingTips_36763_LoadingTips = {
    Text = "由于银钥匙与精神维度之间存在一定关联，在靠近精神异常的个体时，银钥匙可能会产生特殊反应。"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "密契，即使用特殊方法记录到含有银芯的材料上的神秘符文。\n不同密契能够提供的助力不同，同一系列的密契可以带来更多的助力。"
  },
  LoadingTips_36765_LoadingTips = {
    Text = "融蚀浆是一种从融蚀痕中溢出的黑色黏液。\n和融蚀现象本身一样，不借助特殊器械，普通人无法直接对其进行观测。"
  },
  LoadingTips_36766_LoadingTips = {
    Text = "某些融蚀体死后会化作的黑色粉末，被称为融蚀粉尘。"
  },
  LoadingTips_36767_LoadingTips = {
    Text = "雷欧王国位于亚特兰大洋东侧，与康斯坦联邦、常青联盟接壤。\n王国面积不大，但国力强盛，是洪积后最早完成重建的国家之一。"
  },
  LoadingTips_36768_LoadingTips = {
    Text = "亚格罗共和国位于亚特兰大洋西侧，四面环海，腹地辽阔。\n亚格罗共和国工业与金融业十分发达，其金融中心城市弗莱彻更是无数人向往的繁华之地。"
  },
  LoadingTips_36769_LoadingTips = {
    Text = "密境中，情感、思绪、思维、执念等都可能具有可观测的投影。\n这些投影一般不可触碰，或者一触即散，是精神维度对现实维度个体的感官的欺骗。"
  },
  LoadingTips_36770_LoadingTips = {
    Text = "康斯坦联邦位于东劳拉西亚大陆，是一个由数个小国组合而成的联邦。在联邦中，艺术是所有人一致的追求。"
  },
  LoadingTips_36771_LoadingTips = {
    Text = "一些特殊的投影能被灵知转印器捕捉，并附着在指令卡上，使唤醒体获得增益。这些投影被称为刻印（Orison）。"
  },
  LoadingTips_36772_LoadingTips = {
    Text = "根据融蚀裂隙的大小，大致可以将融蚀裂隙分为6类：C,B,A,S,SS,SSS。"
  },
  LoadingTips_36773_LoadingTips = {
    Text = "雕塑家协会，一个沉迷于罪恶的人体实验的极端组织。由弥萨格的叛徒罗伯特·罗森塔尔一手创办。"
  },
  LoadingTips_36774_LoadingTips = {
    Text = "蹈海者，一个以弥利亚姆为首的古老宗教组织。\n他们苦心经营，只为复活他们唯一的神王。"
  },
  LoadingTips_36775_LoadingTips = {
    Text = "不同区域的密境在调查时能收集到的事物也不同，即使是看似相同的事物，也可能具有非常不同的本质。"
  },
  LoadingTips_36776_LoadingTips = {
    Text = "密境（Domain）是介于精神维度和现实维度之间的特殊维度，是人类能够肉身进入的最接近精神维度的空间。"
  },
  LoadingTips_36777_LoadingTips = {
    Text = "弥萨格大学是绝对中立的第三方，校内大小事宜皆由校长及各管理层人员共同商议决定，不受任何组织约束。"
  },
  LoadingTips_36778_LoadingTips = {
    Text = "融蚀裂隙的存在不需要依托具有实体的物件，天空、海洋等都是融蚀裂隙可能出现的场所。"
  },
  LoadingTips_36779_LoadingTips = {
    Text = "提灯教会，一个隐秘而邪恶的宗教组织。似乎与雕塑家协会和蹈海者有很深的联系。"
  },
  LoadingTips_36780_LoadingTips = {
    Text = "密斯底亚协定审查会是个非常庞大的组织。\n除了雷欧王国，它在亚格罗共和国、康斯坦联邦乃至勒姆瓦希帝国都设有分部。"
  }
})
return Text_LoadingTips
