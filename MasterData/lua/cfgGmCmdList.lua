_G["GmCmdList"]={{["cmd"]="overFight",["num"]=0,["key"]=1,["exapmle"]="overFight",["id"]=1,["use"]="overFight",["type"]="战斗",["desc"]="一键结束战斗"}
,{["cmd"]="passAll",["num"]=1,["key"]=2,["exapmle"]="passAll 3",["id"]=2,["use"]="passAll 星级",["type"]="战斗",["desc"]="一键通关"}
,{["cmd"]="plrlvl",["num"]=1,["key"]=3,["exapmle"]="plrlvl 100",["id"]=3,["use"]="plrlvl 等级",["type"]="玩家",["desc"]="设置玩家等级"}
,{["cmd"]="superCard",["num"]=1,["key"]=4,["exapmle"]="superCard 10010",["id"]=4,["use"]="superCard 卡牌id",["type"]="卡牌",["desc"]="卡牌满级,满级玩家"}
,{["cmd"]="fullLvCard",["num"]=1,["key"]=5,["exapmle"]="fullLvCard 10010",["id"]=5,["use"]="fullLvCard 卡牌id",["type"]="卡牌",["desc"]="卡牌满级，不改变玩家等级"}
,{["cmd"]="addAllCard",["num"]=0,["key"]=6,["id"]=6,["use"]="addAllCard",["type"]="卡牌",["desc"]="添加所有卡牌"}
,{["cmd"]="fullItemBag",["num"]=1,["key"]=7,["exapmle"]="fullItemBag 100 2",["id"]=7,["use"]="fullItemBag 物品百分比(1,100] 物品类型(不指定就添加全部类型)",["type"]="背包",["desc"]="满背包"}
,{["cmd"]="cleanItemBag",["num"]=1,["key"]=8,["exapmle"]="cleanItemBag",["id"]=8,["use"]="cleanItemBag (不删宿舍物品) / cleanItemBag 1 (删除宿舍物品)",["type"]="背包",["desc"]="清空背包"}
,{["cmd"]="mail",["num"]=1,["key"]=9,["exapmle"]="mail 10001",["id"]=9,["use"]="mail 邮件配置Id",["type"]="邮件",["desc"]="给玩家发送邮件"}
,{["cmd"]="rmail",["num"]=2,["key"]=10,["exapmle"]="mail 10001 12",["id"]=10,["use"]="mail 掉落id 次数",["type"]="邮件",["desc"]="掉落邮件"}
,{["cmd"]="gmail",["num"]=1,["key"]=11,["exapmle"]="mail 10001",["id"]=11,["use"]="gmail 邮件配置Id",["type"]="邮件",["desc"]="发送全局邮件"}
,{["cmd"]="gmMail",["num"]=5,["key"]=12,["exapmle"]="gmMail title gm 189898989 hello {{id =11002, num=1, type=2}, {id =1002, num=1, type=3}, {id =2010101, num=1, type=4}}",["id"]=12,["use"]="gmMail title sendFrom endTime contents rewards",["type"]="邮件",["desc"]="发送gm邮件"}
,{["cmd"]="openactive",["num"]=1,["key"]=13,["id"]=13,["use"]="openactive 活动配置id, 当不填写id的时候全部开启",["type"]="活动",["desc"]="开启活动命令"}
,{["cmd"]="exchagneCode",["num"]=1,["key"]=14,["id"]=14,["use"]="exchagneCode  0100-0001-AQW9-AQEP-8F7M",["type"]="活动",["desc"]="兑换码序列"}
,{["cmd"]="buildHp",["num"]=2,["key"]=15,["exapmle"]="buildHp 50 1001",["id"]=15,["use"]="cleanItemBag",["type"]="基地",["desc"]="设置建筑血量百分比"}
,{["cmd"]="resetBuild",["num"]=0,["key"]=16,["exapmle"]="resetBuild",["id"]=16,["use"]="resetBuild",["type"]="基地",["desc"]="重置建筑信息"}
,{["cmd"]="setRoleLv",["num"]=2,["key"]=17,["exapmle"]="setRoleLv 99 10010",["id"]=17,["use"]="setRoleLv 数值 卡牌配置id(没有id表示设置全部)",["type"]="基地",["desc"]="设置卡牌角色好感度"}
,{["cmd"]="setRoleTired",["num"]=2,["key"]=18,["exapmle"]="setRoleTired 33 10010",["id"]=18,["use"]="setRoleTired [0, 100] [卡牌配置id](没有id表示设置全部)",["type"]="基地",["desc"]="设置角色疲劳值"}
,{["cmd"]="reInitEpdnTasks",["num"]=1,["key"]=19,["exapmle"]="reInitEpdnTasks",["id"]=19,["use"]="reInitEpdnTasks",["type"]="基地",["desc"]="重置远征任务，可在开启gmPlr 1 之后使用，就不受开启条件限制"}
,{["cmd"]="buildResetTrade",["num"]=0,["key"]=20,["exapmle"]="buildResetTrade",["id"]=20,["use"]="buildResetTrade",["type"]="基地",["desc"]="刷新交易订单"}
,{["cmd"]="productCenterReward",["num"]=0,["key"]=21,["exapmle"]="productCenterReward",["id"]=21,["use"]="productCenterReward",["type"]="基地",["desc"]="基地生产中心产出一次（使用后产出重新开始倒计时）"}
,{["cmd"]="resetRoleTvTime",["num"]=1,["key"]=22,["exapmle"]="resetRoleTvTime",["id"]=22,["use"]="resetRoleTvTime [角色cfgid]",["type"]="基地",["desc"]="清楚角色记录的疲劳计算时间缓存(没角色id表示全部)"}
,{["cmd"]="dormTheme",["num"]=2,["key"]=23,["exapmle"]="dormTheme 1 1001",["id"]=23,["use"]="dormTheme [1:添加/-1:删除] 主题id",["type"]="基地",["desc"]="根据主题增删宿舍家具"}
,{["cmd"]="armyReset",["num"]=1,["key"]=24,["exapmle"]="armyReset 1 5 0",["id"]=24,["use"]="armyReset 增减的分数 可对战次数 已购买对战次数",["type"]="军演",["desc"]="重置军演信息"}
,{["cmd"]="superEquip",["num"]=0,["key"]=25,["id"]=25,["use"]="superEquip",["type"]="装备",["desc"]="装备满级"}
,{["cmd"]="addEquip",["num"]=5,["key"]=26,["id"]=26,["use"]="addEquip 装备id 数量 技能1 技能2 技能3",["type"]="装备",["desc"]="添加装备"}
,{["cmd"]="addAllEquip",["num"]=1,["key"]=27,["id"]=27,["use"]="addAllEquip maxCnt数量",["type"]="装备",["desc"]="添加 maxCnt 件不同装备"}
,{["cmd"]="sellAllEquip",["num"]=0,["key"]=28,["exapmle"]="sellAllEquip",["id"]=28,["use"]="sellAllEquip",["type"]="装备",["desc"]="销售所有装备, 包括上锁与装备的"}
,{["cmd"]="addTestCard",["num"]=0,["key"]=29,["id"]=29,["use"]="addTestCard",["type"]="卡牌",["desc"]="添加配置表gm无法获取的卡牌"}
,{["cmd"]="addcard",["num"]=1,["key"]=30,["id"]=30,["use"]="addcard 卡牌id",["type"]="卡牌",["desc"]="添加卡牌"}
,{["cmd"]="cardHot",["num"]=1,["key"]=31,["id"]=31,["use"]="cardHot 热值",["type"]="卡牌",["desc"]="设置所有卡牌热值"}
,{["cmd"]="storeExp",["num"]=1,["key"]=32,["id"]=32,["use"]="storeExp 数值",["type"]="卡牌",["desc"]="增减存储经验"}
,{["cmd"]="cleanCard",["num"]=0,["key"]=33,["exapmle"]="cleanCard -1 1",["id"]=33,["use"]="cleanCard [卡牌id, -1表全删] [是否删除锁定,填1]",["type"]="卡牌",["desc"]="当没有指定id时候，清空没使用的卡牌"}
,{["cmd"]="testCardPool",["num"]=3,["key"]=34,["exapmle"]="testCardPool 1003 5 3",["id"]=34,["use"]="testCardPool 卡池id 十连抽次数 测试品质",["type"]="卡牌",["desc"]="测试十连抽"}
,{["cmd"]="createCardCntReset",["num"]=0,["key"]=35,["exapmle"]="createCardCntReset",["id"]=35,["use"]="createCardCntReset",["type"]="卡牌",["desc"]="重置必掉落抽卡次数计数"}
,{["cmd"]="resetCardRoles",["num"]=0,["key"]=36,["exapmle"]="resetCardRoles",["id"]=36,["use"]="resetCardRoles",["type"]="卡牌",["desc"]="重置所有角色"}
,{["cmd"]="resetCardCreateLog",["num"]=0,["key"]=37,["exapmle"]="resetCardCreateLog",["id"]=37,["use"]="resetCardCreateLog",["type"]="卡牌",["desc"]="重置抽卡信息"}
,{["cmd"]="plrexp",["num"]=1,["key"]=38,["exapmle"]="plrexp 100",["id"]=38,["use"]="plrexp 经验",["type"]="玩家",["desc"]="添加玩家经验"}
,{["cmd"]="money",["num"]=2,["key"]=39,["exapmle"]="money 100 1000 （100钻石，1000金币）",["id"]=39,["use"]="money 钻石数量 金币数量 （正数为添加，负数为减少， 0 为不变）",["type"]="玩家",["desc"]="改变金钱"}
,{["cmd"]="gmPlr",["num"]=1,["key"]=40,["exapmle"]="gmPlr 1：开启/gmPlr：关闭",["id"]=40,["use"]="gmPlr 1[时间秒数，没有表示关闭]",["type"]="玩家",["desc"]="gm player, 设置GM玩家特权"}
,{["cmd"]="accNumer",["num"]=2,["key"]=41,["exapmle"]="accNumer 身份证号 姓名",["id"]=41,["use"]="accNumer 440106200303050920 大爷",["type"]="玩家",["desc"]="设置玩家防沉迷信息"}
,{["cmd"]="ablilitys",["num"]=0,["key"]=42,["id"]=42,["use"]="ablilitys",["type"]="玩家",["desc"]="开启所有能力"}
,{["cmd"]="skillGroup",["num"]=0,["key"]=43,["id"]=43,["use"]="skillGroup",["type"]="玩家",["desc"]="开启所有技能组"}
,{["cmd"]="skillGroupReset",["num"]=0,["key"]=44,["exapmle"]="skillGroupReset",["id"]=44,["use"]="skillGroupReset",["type"]="玩家",["desc"]="重置所有能力，会重置buf与技能组"}
,{["cmd"]="lbExpTime",["num"]=1,["key"]=45,["exapmle"]="lbExpTime 30",["id"]=45,["use"]="lbExpTime 多久之后过期(秒)",["type"]="玩家",["desc"]="设置生活buf多久过期"}
,{["cmd"]="setMemberLeftDay",["num"]=2,["key"]=46,["exapmle"]="setMemberLeftDay 10030 5",["id"]=46,["use"]="setMemberLeftDay 会员物品id 剩余5天数",["type"]="玩家",["desc"]="设置会员剩余天数"}
,{["cmd"]="setPlrNum",["num"]=2,["key"]=47,["exapmle"]="setPlrNum hot 0",["id"]=47,["use"]="setPlrNum 字段值 数值",["type"]="玩家",["desc"]="设置玩家数值"}
,{["cmd"]="setPlrMixNum",["num"]=2,["key"]=48,["exapmle"]="setPlrMixNum hotBuyCnt 0",["id"]=48,["use"]="setPlrMixNum 字段值 数值",["type"]="玩家",["desc"]="设置玩家Mix数值"}
,{["cmd"]="clearBuySkin",["num"]=0,["key"]=49,["exapmle"]="clearBuySkin",["id"]=49,["use"]="clearBuySkin",["type"]="玩家",["desc"]="清空已购买的皮肤和购买记录"}
,{["cmd"]="addInlinePayRet",["num"]=3,["key"]=50,["exapmle"]="addInlinePayRet 10 1 1",["id"]=50,["use"]="addInlinePayRet 充值金额 月卡数量 是否登录[0:需要登录返还/1：马上返还]",["type"]="玩家",["desc"]="写入内陆支付返还"}
,{["cmd"]="passgate",["num"]=2,["key"]=51,["exapmle"]="passgate 1105 3",["id"]=51,["use"]="passgate 关卡id 星数",["type"]="战斗",["desc"]="通过某一关"}
,{["cmd"]="EnterFight",["num"]=1,["key"]=52,["exapmle"]="EnterFight 101011",["id"]=52,["use"]="EnterFight 关卡id",["type"]="战斗",["desc"]="进入战斗"}
,{["cmd"]="guildFightTest",["num"]=0,["key"]=53,["exapmle"]="guildFightTest",["id"]=53,["use"]="guildFightTest",["type"]="战斗",["desc"]="进入工会战测试多人房间"}
,{["cmd"]="tbFinish",["num"]=1,["key"]=54,["exapmle"]="tbFinish 1",["id"]=54,["use"]="tbFinish 1[胜利]/0[失败]",["type"]="战斗",["desc"]="Team boss finish 完结所在的组队boss房间,"}
,{["cmd"]="tbFightOver",["num"]=0,["key"]=55,["exapmle"]="tbFightOver",["id"]=55,["use"]="tbFightOver 1[击败boss/不输入默认不击败]",["type"]="战斗",["desc"]="Team boss fight over 直接完结战斗,"}
,{["cmd"]="tower",["num"]=0,["key"]=56,["exapmle"]="tower",["id"]=56,["use"]="tower",["type"]="战斗",["desc"]="重置爬塔奖励"}
,{["cmd"]="delStory",["num"]=0,["key"]=57,["exapmle"]="delStory",["id"]=57,["use"]="delStory",["type"]="战斗",["desc"]="删除剧情"}
,{["cmd"]="settp",["num"]=1,["key"]=58,["exapmle"]="settp 3",["id"]=58,["use"]="settp tp值",["type"]="世界boss",["desc"]="设置tp值"}
,{["cmd"]="reward",["num"]=1,["key"]=59,["id"]=59,["use"]="reward 配置表id",["type"]="掉落",["desc"]="掉落"}
,{["cmd"]="showRewardCfg",["num"]=1,["key"]=60,["exapmle"]="showRewardCfg 1001",["id"]=60,["use"]="showRewardCfg 配置表id",["type"]="掉落",["desc"]="前端显示掉落配置"}
,{["cmd"]="additem",["num"]=3,["key"]=61,["exapmle"]="additem 10010 23 1",["id"]=61,["use"]="additem 物品id 数量 [自动使用]",["type"]="背包",["desc"]="添加物品"}
,{["cmd"]="shop",["num"]=3,["key"]=62,["id"]=62,["use"]="shop 11001 1 0 取消折扣/shop 11001 1 1 开始折扣/shop 11001 2  设置记录即将重置",["type"]="商店",["desc"]="shop 购买记录id(和配置表id一样) 操作类型 操作值"}
,{["cmd"]="finishTasks",["num"]=3,["key"]=63,["id"]=63,["use"]="finishTasks 任务类型[不填表示全部] cfgId[0:表示类型全部] 完成次数",["type"]="任务",["desc"]="完成所有任务[1:主线,2:支线,3:日常,4:每周,5:活动,6:长期副本爬塔,7:短期副本爬塔]"}
,{["cmd"]="resetTask",["num"]=1,["key"]=64,["exapmle"]="resetTask",["id"]=64,["use"]="resetTask 任务类型[不填表示全部]",["type"]="任务",["desc"]="重置任务"}
,{["cmd"]="time",["num"]=1,["key"]=65,["id"]=65,["use"]="time 2019-10-13-11:40:30",["type"]="控制",["desc"]="设定服务器事件"}
,{["cmd"]="reload",["num"]=1,["key"]=66,["exapmle"]="reload character.Player",["id"]=66,["use"]="reload [文件名，文件名忽略则热更包含配置表在内的所有默认文件]",["type"]="控制",["desc"]="热更当前游戏服"}
,{["cmd"]="tips",["num"]=1,["key"]=67,["exapmle"]="tips 205",["id"]=67,["use"]="tips 提示id",["type"]="控制",["desc"]="显示提示信息"}
,{["cmd"]="changeSvr",["num"]=1,["key"]=68,["exapmle"]="changeSvr 101",["id"]=68,["use"]="changeSvr 服务器id",["type"]="控制",["desc"]="切换游戏服"}
,{["cmd"]="resetFieldBossCount",["num"]=0,["key"]=69,["exapmle"]="resetFieldBossCount",["id"]=69,["use"]="resetFieldBossCount",["type"]="战场",["desc"]="重置激战前线挑战次数"}
,{["cmd"]="setFieldCount",["num"]=4,["key"]=70,["exapmle"]="setFieldCount 11001 4 6",["id"]=70,["use"]="setFieldCount战场系统关卡id 初始敌人人数 总敌人人数",["type"]="战场",["desc"]="设置局部战场的敌人数量"}
,{["cmd"]="resetFieldBoss",["num"]=1,["key"]=71,["exapmle"]="resetFieldBossCount 10000",["id"]=71,["use"]="resetFieldBossCount boss血量（血量为0或者不填，默认最大值）",["type"]="战场",["desc"]="重置激战前线的boss血量"}
,{["cmd"]="sevenTaskOpenNewDay",["num"]=0,["key"]=72,["exapmle"]="sevenTaskOpenNewDay",["id"]=72,["use"]="sevenTaskOpenNewDay",["type"]="七日",["desc"]="开启新一天的七日任务"}
,{["cmd"]="resetExploration",["num"]=0,["key"]=73,["exapmle"]="resetExploration",["id"]=73,["use"]="resetExploration",["type"]="勘测",["desc"]="重置测绘记录"}
,{["cmd"]="recharge",["num"]=1,["key"]=74,["exapmle"]="recharge 40001",["id"]=74,["use"]="recharge id[CfgCommodity表的id]",["type"]="购买",["desc"]="模拟充值"}
,{["cmd"]="setReturnPlr",["num"]=1,["key"]=75,["exapmle"]="setReturnPlr 1",["id"]=75,["use"]="setReturnPlr 回归类型( 1短期回归玩家，2长期回归玩家)",["type"]="回归",["desc"]="设置回归玩家"}
,{["cmd"]="setRogueBuff",["num"]=1,["key"]=76,["exapmle"]="setRogueBuff 15001",["id"]=76,["use"]="setRogueBuff buffid",["type"]="战斗",["desc"]="设置乱序演习当前回合词条"}
,{["cmd"]="refreshRogueBuff",["num"]=0,["key"]=77,["exapmle"]="refreshRogueBuff",["id"]=77,["use"]="refreshRogueBuff (需要保存进度退出界面再重新进入选择buff界面)",["type"]="乱序",["desc"]="重新随机当前乱序演习随机词条"}
,{["cmd"]="setRogueDuplicate",["num"]=1,["key"]=78,["exapmle"]="setRogueDuplicate 40001",["id"]=78,["use"]="setRogueDuplicate 关卡ID (在翻怪物卡牌前输入，输入完需保存进度退出界面再重新进入)",["type"]="乱序",["desc"]="乱序选怪物界面，固定选择某个怪物id"}
,{["cmd"]="resetItemPool",["num"]=1,["key"]=79,["exapmle"]="resetItemPool 1001",["id"]=79,["use"]="resetItemPool 道具池ID（没填则默认所有道具池重置）",["type"]="重置道具池",["desc"]="重置道具池"}
,{["cmd"]="passRogue",["num"]=1,["key"]=80,["exapmle"]="passRogue 15001",["id"]=80,["use"]="passRogue 关卡组ID(没填则默认所有乱序关卡)",["type"]="乱序",["desc"]="通关乱序演习关卡组,不填id全部通关"}
,{["cmd"]="addPetItem",["num"]=1,["key"]=81,["exapmle"]="addPetItem",["id"]=81,["use"]="addPetItem 道具ID（没填则默认所有宠物物品）",["type"]="添加宠物物品",["desc"]="添加所有宠物物品（不包括图鉴）"}
,{["cmd"]="setPet",["num"]=3,["key"]=82,["exapmle"]="setPet 1 1 100",["id"]=82,["use"]="setPet 宠物ID 属性类型 属性值 （宠物id 1-3, 属性类型1心情 2饱腹 3洗漱 4成长）",["type"]="设置宠物属性",["desc"]="设置宠物属性"}
,{["cmd"]="resetTotalRecharge",["num"]=0,["key"]=83,["exapmle"]="resetTotalRecharge",["id"]=83,["use"]="resetTotalRecharge",["type"]="活动",["desc"]="重置累充活动的金额"}
,{["cmd"]="resetArachnidCount",["num"]=0,["key"]=84,["exapmle"]="resetArachnidCount",["id"]=84,["use"]="resetArachnidCount",["type"]="战斗",["desc"]="重置蛛影迷城的入场券的购买"}
,{["cmd"]="resetNewTowerInfo",["num"]=0,["key"]=85,["exapmle"]="resetNewTowerInfo",["id"]=85,["use"]="resetNewTowerInfo",["type"]="战斗",["desc"]="重置异构空间关卡"}
,{["cmd"]="resetTowerHp",["num"]=0,["key"]=86,["exapmle"]="resetTowerHp",["id"]=86,["use"]="resetTowerHp",["type"]="战斗",["desc"]="重置异构空间角色血量"}
,{["cmd"]="resetNewTowerCnt",["num"]=0,["key"]=87,["exapmle"]="resetNewTowerCnt",["id"]=87,["use"]="resetNewTowerCnt",["type"]="战斗",["desc"]="重置异构空间挑战次数"}
,{["cmd"]="resetAchievement",["num"]=0,["key"]=88,["exapmle"]="resetAchievement",["id"]=88,["use"]="resetAchievement",["type"]="徽章/成就",["desc"]="重置成就"}
,{["cmd"]="resetBadged",["num"]=0,["key"]=89,["exapmle"]="resetBadged",["id"]=89,["use"]="resetBadged",["type"]="徽章/成就",["desc"]="重置徽章"}
,{["cmd"]="resetCollectRecharge",["num"]=0,["key"]=90,["exapmle"]="resetCollectRecharge",["id"]=90,["use"]="resetCollectRecharge",["type"]="活动",["desc"]="重置累充活动的金额"}
,{["cmd"]="resetOperate",["num"]=1,["key"]=91,["exapmle"]="resetOperate 1015",["id"]=91,["use"]="resetOperate 活动id（eOperateType 1015 付费签到）",["type"]="活动",["desc"]="重置活动数据"}
,{["cmd"]="resetRankData",["num"]=1,["key"]=92,["exapmle"]="resetRankData 9999 9001",["id"]=92,["use"]="resetRankData 积分 排行榜类型（eRankType）",["type"]="活动",["desc"]="修改自己排行榜数据"}
,{["cmd"]="resetExtra",["num"]=0,["key"]=93,["exapmle"]="resetExtra",["id"]=93,["use"]="resetExtra",["type"]="玩家",["desc"]="修改通关0-2副本时间为当前时间"}
,{["cmd"]="passRogueT",["num"]=1,["key"]=94,["exapmle"]="passRogueT 17001",["id"]=94,["use"]="passRogueT 关卡组ID(没填则默认所有难度)",["type"]="能力测验",["desc"]="通关能力测验"}
,{["cmd"]="resetRogueT",["num"]=1,["key"]=95,["exapmle"]="resetRogueT",["id"]=95,["use"]="resetRogueT",["type"]="能力测验",["desc"]="重置能力测验"}
,{["cmd"]="refreshRogueTBuff",["num"]=0,["key"]=96,["exapmle"]="refreshRogueTBuff",["id"]=96,["use"]="refreshRogueTBuff",["type"]="能力测验",["desc"]="刷新能力测验当前随机技能列表"}
}

