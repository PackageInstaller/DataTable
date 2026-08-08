

UIType = {
	Wnd = 1,
	Toast = 2,
	MsgBox = 3,
	Common = 4,
	Loader = 5,
}

UIGroup = {
	Login = 1,
	Main = 2,
	SeaMap = 3,
	Battle = 4,
	Empty = 5,
	Survival = 6,
}

MsgBoxType = 
{
	OK = 1,					--仅显示OK
	OKCancel = 2,			--显示OK和取消
	Buy = 3,				--购买模式
	CommonBuy = 4,			--自定义购买模式文字
	ChangePlayerName = 5,	--修改玩家名称
	ChangePlayerSign = 6,	--修改玩家签名
	ItemBatchUse = 7,		--道具批量使用
	Gift = 8,				--礼物
	Agreement = 9,			--协议
	Msg_Emoji = 10,			--带表情
	BuyRaffleTicket = 11,	--购买招集券
	Dispatch = 12,			--派遣
	Code = 13,				--兑换码
	SelectPay = 14,			--选择支付方式
}

---@enum MsgTitleIconType
MsgTitleIconType = {
	Oil = 1,
	Box = 2,
	Pen = 3,
	Tips = 4,
	DisPatch = 5,
	Code = 6,
}

UIState = {
    Entered = 1,
    Exited = 2,
    None = 3,
}
---@enum GameMsgType
GameMsgType = {
	AddOneItem = 1,		-- 指一个id的物品，不是一个
	RemoveOneItem = 2,
	DropOneItem = 3,
	UpdateOneEndurance = 4,
	AddOneItem_Identify = 5,		-- 鉴定获得道具
	-- ItemUse = 5,

	UpdateItemFinish = 10,

	UpdateOneBankItem = 11,
	UpdateBankItemFinish = 12,
	
	UpdateOneTag = 13,

	UpdateOneStatus = 15,
	UpdateStatusFinish = 16,

	UpdateOneSkill = 17,
	UpdateJobSkill = 18,
	UpdateSkillFinish = 25,
	
	UpdateExp = 41,

	BattleStart = 63,
	BattleEnd = 64,

	StartBattle = 70,
	FinishBattle = 71,

	LevelFinished = 75,

	UpdateOneProp = 99,
	UpdateProp = 100,

	AddOneChar = 101,		---增加一个角色

	MailListChange = 115,  	-- 邮件列表发生变化
	NewFuncOpen = 116,		---新功能开放
	PaySuccess = 117,		---支付成功

	FriendListChange = 121,  	-- 好友数据变化
	FriendPointChange = 122,

	Dead = 140,
	JumpScene = 141,

	CustomBackPanelBackClick = 200,	--通用返回按钮点击
	CustomBackPanelMainClick = 201,	--通用main按钮点击





	Kick = 250,
	GameDisconnected = 251,
	GameReconnected = 252,
	
	WorkOrderStateChange = 280,
	WorkOrderOperation = 281,

	GameVersionNeedUpdate = 400,
	MaintainNotify = 405,

	None18Overtime = 500,

	RefreshMainPanel = 501,

	--RefreshMiaoBuy = 502,

	RefreshLevelInfoPanel = 503,

	RefreshWarehousePanel = 504,

	RefreshPoster = 505,
	RefreshHead = 506,			--刷新头像显示
	RefreshTopResource = 507,	--刷新顶部资源栏
	UIDataGroupQueueChange = 508, --UI队列发生变化
	RefreshHomeland = 509,		--家园数据刷新

	HeroNatureChange = 510,		--英雄属性改变
	OnWeaponChange = 511,		--武器改变
	HeroLevelUp = 512,			--英雄升级
	HeroSkillChange = 513,		--英雄技能改变

	RefreshHomeFuncPanel = 514, --建筑界面刷新
	RoleBoxClickTag = 515, --角色头衔点击tag
	HeroSkinChange = 516, --英雄皮肤改变

	RoleDisposeChange = 517, --角色布置改变
	RoleWalkChange = 518, --角色散步改变
	RefreshBattleRepeatPanel = 519, --扫荡界面刷新

	TechTreeNodeSelect = 520, --科技树节点选择

	DispatchDataUpdate = 521, --派遣数据更新

	NoticeRefresh = 522, --公告更新

	RefreshSimulatedLevel = 523, --模拟演习界面刷新

	RefreshMaterilalLevelPanel = 524, --日常材料界面刷新

	BulidingLvChange = 525, --建筑等级改变

	HeroListNtf = 526, --英雄列表更新

	ItemMapNtf = 527, --道具列表更新

	RefreshCoveBattleInfo = 528,	---刷新家园战斗信息

	CommonBackPanelAddClick = 529, --通用返回按钮点击

	CustomBackPanelHelpClick = 530, --通用help点击

	RefreshCustomItemLockState = 531,

	MissionRefresh = 532, -- 任务数据刷新

	ActivityMapUpdate = 533, -- 活动数据更新

	ActivityPanelUpdate = 534, -- 活动界面刷新

	PlayGetRewardEffect = 535, --播放获得奖励特效

	ChangeMainPanelMode = 536, --切换主界面模式
	HomelandOneKeyCollected = 537, --一键收集家园资源完成
	BuildingLevelUpDissolveEffectPlayFinish = 538, --建筑升级界面播放完毕
	---商城相关
	Shop_BuyGoodsMsg = 601, ---购买商品返回
	Shop_RefreshShopTypeMsg = 602,	---刷新商店返回
	Shop_CycleCardActivityUpdate = 603,--周期卡激活返回

	--
	Add3DMark = 701,
	Remove3DMark = 702,

	RedPointRefresh = 800, --红点刷新

	UIMgrOnUIOpen = 1001, --UIManager打开UI

	RefreshEventMsg = 1002, --刷新角色事件消息
	
	FunctionOpenMapUpdate = 1003, --功能开放状态更新

	UpdateSceneTime = 1004, --场景时间更新

	RefresShopDataMsg = 1006, --刷新角色事件消息

	PassMainUpdate = 1007,--通行证刷新

	QnaireMapDataUpdate = 1008,--问卷调查数据更新

	ChapterRewardGet = 1009,--章节奖励领取

	SetProtoAgreementCheck = 1010, --设置协议勾选状态


	HomeLandCoveBattleDataChange = 1101,

	ProsperityInfoUpdate = 1102,	--繁荣度数据刷新
	ProsperityLevelUp = 1103,		--繁荣度升级

	PveLevelMapUpdate = 1201,		--pve关卡数据更新

}

HeroAnimEnum = {
	Idle = 0,
	Eat1 = 1,
	Eat2 = 2,
	Eat3 = 3,
	Yawn = 4,
	Fight1 = 5,
	Fight2 = 6,
	Fight3 = 7,
	Fight4 = 8,
	Fight5 = 9,
	Fight6 = 10,
	Specialidle1 = 11,
	Specialidle2 = 12,
	Specialidle3 = 13,
	Win = 14,
	Surprise = 15,
	SurpriseRun = 16,
	Lumao1 = 17,
	Lumao2 = 18,
	Flounder = 19,
	Tired = 20,
	Talk = 21,
	Wash1 = 22,
	Wash2 = 23,
	Walk = 24,
	Sit = 25,
	Sit2 = 26,
	Sit3 = 27,
	AdventureIdle = 28,
	AdventurePickUp = 29,
	AdventureWalk = 30,
	AdventureWalk2 = 31,
	Jump = 32,
	JumpThrob = 33,
	JumpDown = 34,
	Wait = 35,
}

RoleAnimEnum = {
	Idle = 0,
	BattleIdle = 1,
	Walk = 2,
	Run = 3,
	Sit = 4,
	Eat = 5,
	Drink = 6,
	Into = 7,
	Celebrate = 8,
	Climb = 9,
	Down = 10,
	Shoot = 11,
	Shoot2 = 12,
	EngineTest = 13,
	Fishing1 = 14,
	Fishing2 = 15,
	Fishing3 = 16,
	Kick = 17,
	Squat = 18,
	Hit = 19,
	Die = 20,
}

RoleModelAnimEnum = {
	Attack = "attack",					--攻击
	Attack2 = "attack2",				--大招动画
	Attack3 = "attack3",				--大招动画
	Hit = "hit",						--受击
	Celebrate = "celebrate",			--庆祝
	Charge = "charge",					--蓄力
	Die = "die",						--死亡
	Fishing = "fishing",				--钓鱼
	fishingShow = "fishingShow",				--钓鱼
	fishingEnd = "fishingEnd",				--钓鱼
	Happy = "happy",					--开心
	Kick = "kick",						--踢饮料机
	Sad = "sad",						--悲伤
	Squat = "squat",					--蹲下
	IdleSp = "idleSp",					--特殊待机
	Start = "start",					--登场动作
	TouchHappy = "touchHappy",			--触摸开心
	TouchSurprised = "touchSurprised",	--触摸惊讶
	TouchConfused = "touchConfused",	--触摸疑惑
	Walk_sp = "walk_sp",               -- 特殊行走
	FishingShow = "fishingShow",       -- 钓鱼展示
	Into2Start = "into2Start",			--移动动作2开始
	Into2End = "into2End",				--移动动作2结束
}
---@enum RoleAnimStateType
RoleAnimStateType = {
	Idle = 0,							--站立
	IdleShip = 1,						--站立(舰装)
	IdleSp = 2, --（废弃不用）			 --特殊待机
	Walk = 3,							--行走
	Run = 4,							--奔跑
	Into = 5,							--进港动作
	Pickup = 6,							--抓起
	Drink = 7,							--喝东西
	Sit = 8,							--坐下
	FishingLoop = 9,					--钓鱼（循环）
	Stun = 10,							--眩晕
	Eat = 11,							--吃东西
	Zhanbai = 12,						--战败
	Read = 13,                          --读书
	Into2 = 14,							--移动动作2
}


---@enum CoveRoleType
CoveRoleType = {
	Random = 0,--纯随机，带生命周期
	HomeWork = 1,--工作角色，一直存在
	DesignRandom = 2,--散步界面指定，路线随机，一直存在
	Dispatch = 3,--派遣角色
}

---角色模型全动画类型
RoleModelAllAnimType = {
	--站立
	Idle = {
		type = 1,
		value = RoleAnimStateType.Idle,
	},
	--站立(舰装)
	IdleShip = {
		type = 1,
		value = RoleAnimStateType.IdleShip,
	},
	--行走
	Walk = {
		type = 1,
		value = RoleAnimStateType.Walk,
	},
	--奔跑
	Run = {
		type = 1,
		value = RoleAnimStateType.Run,
	},
	--进港动作
	Into = {
		type = 1,
		value = RoleAnimStateType.Into,
	},
	--抓起
	Pickup = {
		type = 1,
		value = RoleAnimStateType.Pickup,
	},
	--喝东西
	Drink = {
		type = 1,
		value = RoleAnimStateType.Drink,
	},
	--坐下
	Sit = {
		type = 1,
		value = RoleAnimStateType.Sit,
	},
	--吃饭
	Eat = {
		type = 1,
		value = RoleAnimStateType.Eat,
	},

	--眩晕
	Stun = {
		type = 1,
		value = RoleAnimStateType.Stun,
	},
	--攻击
	Attack = {
		type = 2,
		value = RoleModelAnimEnum.Attack,
	},
	--大招动画
	Attack2 = {
		type = 2,
		value = RoleModelAnimEnum.Attack2,
	},
	--受击
	Hit = {
		type = 2,
		value = RoleModelAnimEnum.Hit,
	},
	--庆祝
	Celebrate = {
		type = 2,
		value = RoleModelAnimEnum.Celebrate,
	},
	--蓄力
	Charge = {
		type = 2,
		value = RoleModelAnimEnum.Charge,
	},
	--死亡
	Die = {
		type = 2,
		value = RoleModelAnimEnum.Die,
	},
	--钓鱼
	Fishing = {
		type = 3,
		value = RoleModelAnimEnum.Fishing,
		state = "CoveFishingAction",
	},
	--开心
	Happy = {
		type = 2,
		value = RoleModelAnimEnum.Happy,
	},
	--踢饮料机
	Kick = {
		type = 3,
		value = RoleModelAnimEnum.Kick,
		state = "CoveKickAction",
	},
	--悲伤
	Sad = {
		type = 2,
		value = RoleModelAnimEnum.Sad,
	},
	--蹲下
	Squat = {
		type = 2,
		value = RoleModelAnimEnum.Squat,
	},
	--特殊待机
	IdleSp = {
		type = 2,
		value = RoleModelAnimEnum.IdleSp,
	},
	--登场动作
	Start = {
		type = 2,
		value = RoleModelAnimEnum.Start,
	},
	--触摸开心
	TouchHappy = {
		type = 2,
		value = RoleModelAnimEnum.TouchHappy,
	},
	--触摸惊讶
	TouchSurprised = {
		type = 2,
		value = RoleModelAnimEnum.TouchSurprised,
	},
	--触摸疑惑
	TouchConfused = {
		type = 2,
		value = RoleModelAnimEnum.TouchConfused,
	},
	--读书
	Read = {
		type = 1,
		value = RoleModelAnimEnum.Read,
	},
	--特殊行走
	Walk_sp = {
		type = 2,
		value = RoleModelAnimEnum.Walk_sp,
	},
	--钓鱼展示
	FishingShow = {
		type = 2,
		value = RoleModelAnimEnum.FishingShow,
	},
}


--家园功能建筑显示类型
---@enum HomeFuncType
HomeFuncType = {
	None = 0,
	CommandRoom = 1,  --指挥室
	WeaponRoom = 2,   --武器室	
	ProduceRoom = 3,  --生产室
	Dorm = 4,			---宿舍
	TrainingRoom = 5,	---训练室
}


--场景角色实时状态提示
---@enum CoveRoleMoodType
CoveRoleMoodType = {
	Mood_Angry = "mood_angry",
	Mood_Chaos = "mood_chaos",
	Mood_Doubt = "mood_doubt",
	Mood_Energy = "mood_energy",		--精力低
	Mood_Fatigue = "mood_fatigue",		--疲劳
	Mood_Food = "mood_food",			---吃饭
	Mood_Happy = "mood_happy",			
	Mood_Inspiration = "mood_inspiration",
	Mood_Love = "mood_love",
	Mood_Shop = "mood_shop",			--购物
	Mood_Shy = "mood_shy",
	Mood_Surprise = "mood_surprise",
	Mood_Talk = "mood_talk",
	Mood_Battle = "mood_talk",
}

--场景角色实时的状态
---@enum CoveRoleActionState
CoveRoleActionState = {
	IDLE = "IDLE",			--待机状态
	WALK = "WALK",			--行走
	WALK_SP = "WALK_SP",	--行走中间动画
	POINT_EFFECT = "PointEffect",	--点位动画
	CHANGE_ROOM = "CHANGE_ROOM",			--换房间过程
	WALK_CHANGE_ROOM = "WALK_CHANGE_ROOM",			--换房间行走
	REMOVE_FROM_ROOM = "REMOVE_FROM_ROOM",			--移除房间
	ADD_TO_ROOM = "ADD_TO_ROOM",			--进入房间
}



---@enum CovePlayerReadyType 角色read状态
CovePlayerReadyType = {
	None = 0,
	Birth = 1,
	GotoFightPoint = 2,
	Bianshen = 3,
	Waiting = 4,
	
	Bujiing = 5,	--补给移动中
	suodiing = 6,		--索敌
	Attacking = 7,		--攻击中
	RaidSpread = 8,		--分散中
	CheckAttackPoint = 9,
	Deading = 10,

}


---@enum BT_Action
BT_Action = {
	None = 0,
	Selector = 1,	--有一个成功就 true，全失败才 false
	Sequence = 2,	--有一个失败就 false，全成功才 true
	Condition = 3,	--若任意一个 false，则失败
	Action = 4,		--总是返回 true（除非你改）
}

---@enum CoveType 角色类型
CoveType = {
	None = 0,
	Player = 1,
	Monster = 2,
	Bullet = 3,
}

---@enum HeroAttributeType
HeroAttributeType = {
	Hp = 1005,
	Mp = 1006,
}



---@enum NavmeshAreas
NavmeshAreas = {
	Walkable = 0,		---0 << 1
	NoWalkAble = 2,		---1 << 1
	Jump = 4,			---2 << 1
}


---@enum FiltrateSelectType
FiltrateSelectType = {
    MultiSelect = 1,        --复选框
    SingalSelect = 2,       --单选框
    AllMultiSelect = 3, ---包含全部按钮的多选框
}



---@enum DayPartType 天气枚举
DayPartType = {
	AM = 1,			---上午
	PM = 2,			---下午
	Night = 3,		---晚上
	AM_PM = 4,		---上午和下午
	PM_Night = 5,	---下午和晚上
	All = 6,		---一整天
}
