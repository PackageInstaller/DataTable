-- chunkname: @modules/logic/rouge2/map/define/Rouge2_MapEnum.lua

module("modules.logic.rouge2.map.define.Rouge2_MapEnum", package.seeall)

local Rouge2_MapEnum = _M

Rouge2_MapEnum.RedNodeResPath = "ui/viewres/gm/rouge/red_point.prefab"
Rouge2_MapEnum.GreenNodeResPath = "ui/viewres/gm/rouge/green_point.prefab"
Rouge2_MapEnum.PathSelectLayerPath = "ui/viewres/gm/rouge/green_point.prefab"
Rouge2_MapEnum.LineResPath = "ui/viewres/gm/rouge/line_local.prefab"
Rouge2_MapEnum.ActorPiecePath = "v3a2_m_s16_chess_0"
Rouge2_MapEnum.ChapterId = 45
Rouge2_MapEnum.LayerCellSize = Vector2(1, 1)
Rouge2_MapEnum.StealSwitch = 421
Rouge2_MapEnum.ConstKey = {
	StoreStealFightFailTitle = 32019,
	BXSMaxBoxPoint = 32101,
	AttrSpSkillIndex = 33002,
	MaxBandCost = 32012,
	StoreStealFailFightTitle = 32015,
	MinFightRecordDiff = 37003,
	PathSelectCameraSize = 17,
	UnRemoveRelicsIds = 32208,
	RevivalCoinDesc = 32201,
	RecruitRelicsId = 32011,
	Season = 32204,
	HeroAttrIds = 32100,
	YBXCareerId = 32211,
	FunnyTaskRewardNum = 32209,
	MaxFightRecordNum = 37002,
	MaxAcceptEntrustNum = 32009,
	CoinDesc = 32202,
	StoreStealFightSuccDesc = 32018,
	StoreStealFightFailDesc = 32020,
	BigAttrDropStep = 33003,
	BXSBoxCountAttrId = 32104,
	HighDifficulty = 37005,
	CheckRateWarning = 32203,
	StoreStealFightSuccTitle = 32017,
	StoreStealFailReturnTitle = 32013,
	StoreStealFailReturnDesc = 32014,
	TalentResetIds = 32212,
	Version = 32205,
	StoreStealFailFightDesc = 32016,
	BXSBoxAttrIds = 32102
}
Rouge2_MapEnum.PathSelectIndex = -1
Rouge2_MapEnum.MapState = {
	Normal = 4,
	SwitchMapAnim = 1,
	LoadingMap = 2,
	WaitFlow = 3,
	Empty = 0
}
Rouge2_MapEnum.MapType = {
	Edit = 0,
	Middle = 2,
	PathSelect = 3,
	Normal = 1
}
Rouge2_MapEnum.MapType2ModelCls = {
	[Rouge2_MapEnum.MapType.Normal] = Rouge2_LayerMapModel,
	[Rouge2_MapEnum.MapType.Middle] = Rouge2_MiddleLayerMapModel,
	[Rouge2_MapEnum.MapType.PathSelect] = Rouge2_PathSelectMapModel
}
Rouge2_MapEnum.ChangeMapEnum = {
	PathSelectToNormal = 3,
	MiddleToPathSelect = 2,
	NormalToMiddle = 1
}
Rouge2_MapEnum.Arrive = {
	CantArrive = 1,
	CanArrive = 3,
	ArrivingFinish = 5,
	Arrived = 6,
	NotArrive = 2,
	ArrivingNotFinish = 4
}
Rouge2_MapEnum.NodeSelectArriveStatus = Rouge2_MapEnum.Arrive.ArrivingNotFinish
Rouge2_MapEnum.EventType = {
	Reward = 5,
	Rest = 6,
	BossFight = 3,
	Strengthen = 8,
	ExploreChoice = 9,
	EasyFight = 11,
	NormalFight = 1,
	StoryChoice = 10,
	Store = 7,
	HighHardFight = 4,
	EliteFight = 2,
	Empty = 0
}
Rouge2_MapEnum.EventBg = {
	[Rouge2_MapEnum.EventType.NormalFight] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.EliteFight] = "rouge2_map_rightbg_2",
	[Rouge2_MapEnum.EventType.BossFight] = "rouge2_map_rightbg_3",
	[Rouge2_MapEnum.EventType.HighHardFight] = "rouge2_map_rightbg_3",
	[Rouge2_MapEnum.EventType.Reward] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.Rest] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.Store] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.Strengthen] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.StoryChoice] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.ExploreChoice] = "rouge2_map_rightbg_1",
	[Rouge2_MapEnum.EventType.EasyFight] = "rouge2_map_rightbg_1"
}
Rouge2_MapEnum.PicFormat = "singlebg/rouge2/map/%s.png"
Rouge2_MapEnum.MonsterMaskFormat = "singlebg/rouge/mapdetail/monster/%s.png"
Rouge2_MapEnum.EventType2Cls = {
	[Rouge2_MapEnum.EventType.NormalFight] = Rouge2_FightEventMO,
	[Rouge2_MapEnum.EventType.EliteFight] = Rouge2_FightEventMO,
	[Rouge2_MapEnum.EventType.BossFight] = Rouge2_FightEventMO,
	[Rouge2_MapEnum.EventType.HighHardFight] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.Reward] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.Rest] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.Store] = Rouge2_StoreEventMO,
	[Rouge2_MapEnum.EventType.Strengthen] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.StoryChoice] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.ExploreChoice] = Rouge2_ChoiceEventMO,
	[Rouge2_MapEnum.EventType.EasyFight] = Rouge2_FightEventMO
}
Rouge2_MapEnum.NodeType = {
	End = 3,
	Start = 1,
	Normal = 2
}
Rouge2_MapEnum.EventState = {
	Finish = 2,
	Start = 1,
	Init = 0
}

Rouge2_MapNodeIconHelper.active()

Rouge2_MapEnum.LayerNodeIconCanvas = "ui/viewres/rouge2/map/rouge2_layernodeiconcanvas.prefab"
Rouge2_MapEnum.MiddlePieceIconCanvas = "ui/viewres/rouge2/map/rouge2_middlepieceiconcanvas.prefab"
Rouge2_MapEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
Rouge2_MapEnum.MiddleLayerPointType = {
	Leave = 3,
	Pieces = 1,
	Path = 2
}
Rouge2_MapEnum.LeaveId = -1
Rouge2_MapEnum.OffsetZ = {
	PiecesContainer = -7,
	PieceIcon = -8,
	NodeContainer = -2,
	PathContainer = -6,
	Map = 10
}
Rouge2_MapEnum.NodeOffsetZInterval = 0.1
Rouge2_MapEnum.NodeIconOffsetZInterval = 0.5
Rouge2_MapEnum.Scale = {
	Icon = 1.3,
	NodeBg = 1.3
}
Rouge2_MapEnum.PathSelectActorDuration = 1.5
Rouge2_MapEnum.NodeGlobalOffsetY = 0.02
Rouge2_MapEnum.ActorOffset = Vector2(0, 0)
Rouge2_MapEnum.StartClickArea = Vector4(80, 50, 0, 0)
Rouge2_MapEnum.ClickArea = {
	[Rouge2_MapEnum.Arrive.CantArrive] = Vector4(120, 100, 0.66, 14.09),
	[Rouge2_MapEnum.Arrive.NotArrive] = Vector4(120, 110, 1.55, 26.89),
	[Rouge2_MapEnum.Arrive.CanArrive] = Vector4(200, 250, 0, 75.41),
	[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Vector4(235, 300, -8.14, 120),
	[Rouge2_MapEnum.Arrive.ArrivingFinish] = Vector4(236, 345, -7.95, -5.48),
	[Rouge2_MapEnum.Arrive.Arrived] = Vector4(160, 190, -13.62, -11.17)
}
Rouge2_MapEnum.LeaveItemClickArea = Vector4(320.29, 184.6, -18.2, 78.39)
Rouge2_MapEnum.LayerItemClickArea = Vector4(120, 100, 0, 0)
Rouge2_MapEnum.PieceClickArea = Vector4(120, 300, 0, 100)
Rouge2_MapEnum.ChoiceStatus = {
	Select = 3,
	UnSelect = 4,
	Lock = 1,
	Normal = 2
}
Rouge2_MapEnum.DialogueInterval = 0.03
Rouge2_MapEnum.InteractType = {
	Dice = 999,
	TransferCareer = 6,
	LossAttrBuff = 8,
	Drop = 1,
	LossCoin = 5,
	SelectDrop = 15,
	LossRareRelics = 3,
	LossRareBuff = 7,
	Band = 9,
	EntrustChanged = 17,
	ResearchInstitute = 18,
	GainAttribute = 2,
	AcceptEntrust = 12,
	LossAttrRelics = 4,
	ExchangeRelics = 10
}
Rouge2_MapEnum.InteractFromType = {
	MiddleTrigger = 3,
	Career1Reward = 6,
	GM = 5,
	Event = 1,
	Entrust = 4,
	Career = 2
}
Rouge2_MapEnum.PieceEntrustType = {
	Normal = 1,
	Ending = 5,
	Hard = 2,
	None = 0
}
Rouge2_MapEnum.PieceIcon = {
	[Rouge2_MapEnum.PieceEntrustType.Normal] = "rouge2_event_icon_14_2",
	[Rouge2_MapEnum.PieceEntrustType.Hard] = "rouge2_event_icon_15_1",
	[Rouge2_MapEnum.PieceEntrustType.Ending] = "rouge2_event_icon_15_1"
}
Rouge2_MapEnum.PieceIconBg = {
	[Rouge2_MapEnum.PieceEntrustType.Normal] = "rouge2_map_nodebg_6",
	[Rouge2_MapEnum.PieceEntrustType.Hard] = "rouge2_map_nodebg_6",
	[Rouge2_MapEnum.PieceEntrustType.Ending] = "rouge2_map_nodebg_6"
}
Rouge2_MapEnum.PieceIconOffset = Vector2(0, 1.3)
Rouge2_MapEnum.PieceTriggerType = {
	Reward = 1,
	EndFight = 2,
	Empty = 0
}
Rouge2_MapEnum.MiddleLayerCameraSizeRate = 0.8
Rouge2_MapEnum.PathSelectMapWaitTime = 1
Rouge2_MapEnum.LossType = {
	AbandonAttr = 6,
	Abandon = 1,
	Exchange = 2,
	Storage = 3,
	Copy = 4,
	AbandonRare = 5
}
Rouge2_MapEnum.LineType = {
	Arrived = 4,
	CanArrive = 3,
	NotArrive = 2,
	CantArrive = 1,
	None = 0
}
Rouge2_MapEnum.LinePrefabRes = "scenes/v3a2_m_s16_dilao/prefab/dituxian_1.prefab"
Rouge2_MapEnum.StatusLineMap = {
	[Rouge2_MapEnum.Arrive.CantArrive] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.CantArrive
	},
	[Rouge2_MapEnum.Arrive.NotArrive] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.NotArrive,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.NotArrive,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.NotArrive,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.CanArrive,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.None
	},
	[Rouge2_MapEnum.Arrive.CanArrive] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.CanArrive,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.None
	},
	[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.Arrived,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.Arrived
	},
	[Rouge2_MapEnum.Arrive.ArrivingFinish] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.Arrived,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.Arrived
	},
	[Rouge2_MapEnum.Arrive.Arrived] = {
		[Rouge2_MapEnum.Arrive.CantArrive] = Rouge2_MapEnum.LineType.CantArrive,
		[Rouge2_MapEnum.Arrive.NotArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.CanArrive] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingNotFinish] = Rouge2_MapEnum.LineType.None,
		[Rouge2_MapEnum.Arrive.ArrivingFinish] = Rouge2_MapEnum.LineType.Arrived,
		[Rouge2_MapEnum.Arrive.Arrived] = Rouge2_MapEnum.LineType.Arrived
	}
}
Rouge2_MapEnum.LineOffset = 0
Rouge2_MapEnum.ItemDropViewEnum = {
	Tips = 5,
	Loss = 3,
	Select = 1,
	Drop = 2,
	LevelUp = 4,
	FightTip = 6
}
Rouge2_MapEnum.ItemDropReason = {
	Common = 103,
	Effect = 102,
	LevelUpSucc = 105,
	Drop = 104
}
Rouge2_MapEnum.ShowItemDropReason = {
	[Rouge2_MapEnum.ItemDropReason.Common] = false,
	[Rouge2_MapEnum.ItemDropReason.Effect] = true,
	[Rouge2_MapEnum.ItemDropReason.Drop] = true,
	[Rouge2_MapEnum.ItemDropReason.LevelUpSucc] = true
}
Rouge2_MapEnum.RevertDuration = 0.4
Rouge2_MapEnum.MoveSpeed = 7
Rouge2_MapEnum.CameraTweenLine = EaseType.OutCubic
Rouge2_MapEnum.TipShowDuration = 0.8
Rouge2_MapEnum.TipShowInterval = 0.8
Rouge2_MapEnum.DayOrNight = {
	Day = 2,
	Morning = 1,
	Night = 4,
	Dusk = 3
}
Rouge2_MapEnum.DayOrNightSuffix = {
	[Rouge2_MapEnum.DayOrNight.Morning] = "morning",
	[Rouge2_MapEnum.DayOrNight.Day] = "day",
	[Rouge2_MapEnum.DayOrNight.Dusk] = "dusk",
	[Rouge2_MapEnum.DayOrNight.Night] = "night"
}
Rouge2_MapEnum.PieceDir = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
Rouge2_MapEnum.ActorDir = {
	Bottom = 2,
	Right = 6,
	LeftBottom = 1,
	RightTop = 9,
	Top = 8,
	RightBottom = 3,
	Left = 4,
	LeftTop = 7
}
Rouge2_MapEnum.EntrustEventType = {
	GetRelicsNum = 6,
	GetRareRelics = 7,
	GetRelics = 5,
	GetRareBuff = 8,
	CheckSuccNum = 12,
	KillEnemy = 10,
	Event = 3,
	MakeMoney = 1,
	CostMoney = 2,
	GetAttribute = 11,
	GetBuffNum = 9,
	NotUpdateCount = 15,
	StealStore = 13,
	PassLayer = 4,
	MakeRevivalCoin = 14
}
Rouge2_MapEnum.FinishEnum = {
	Finish = 1,
	Fail = 2
}
Rouge2_MapEnum.UnSelectLineAlpha = 0.3
Rouge2_MapEnum.SwitchLayerMinDuration = 3
Rouge2_MapEnum.SwitchLayerMaxDuration = 10
Rouge2_MapEnum.CoinChangeDuration = 1
Rouge2_MapEnum.PowerChangeDuration = 1
Rouge2_MapEnum.TalkAnchorOffset = {
	[Rouge2_MapEnum.MapType.Normal] = Vector2(0, 31.46),
	[Rouge2_MapEnum.MapType.Middle] = Vector2(0, 73.34)
}
Rouge2_MapEnum.TalkDuration = 2
Rouge2_MapEnum.TalkCD = 5
Rouge2_MapEnum.ShortVoiceTriggerType = {
	EnterPathSelectLayer = 3,
	FinishEvent = 6,
	EnterMiddleLayer = 2,
	MiddleLayerMove = 8,
	EnterNormalLayer = 1,
	AcceptEntrust = 5,
	NormalLayerMove = 7,
	ExitPieceTalk = 4
}
Rouge2_MapEnum.ChoiceSelectAnimDuration = 0.667
Rouge2_MapEnum.EffectType = {
	UnlockFightDropRefresh = 23,
	UnlockRestRefresh = 21,
	UpdateExchangeDisplaceNum = 28,
	UnlockShowPassFightMask = 26
}
Rouge2_MapEnum.ExpAddDuration = 0.5
Rouge2_MapEnum.WaitSuccAnimDuration = 2
Rouge2_MapEnum.WaitSuccPlayAudioDuration = 1
Rouge2_MapEnum.WaitSwitchMapAnim = 0
Rouge2_MapEnum.SwitchMapAnimDuration = 1.33
Rouge2_MapEnum.WaitStoryCloseAnim = 1
Rouge2_MapEnum.EntrustFinishDuration = 1.5
Rouge2_MapEnum.PieceBossEffect = "scenes/v1a9_m_s16_dilao_room/scene_prefab/chesseffect/luoleilai_effect.prefab"
Rouge2_MapEnum.LifeChangeStatus = {
	Add = 3,
	Reduce = 1,
	Idle = 2
}
Rouge2_MapEnum.WaitStoreRefreshAnimDuration = 0.2
Rouge2_MapEnum.StoreBubbleAnimDuration = 1.5
Rouge2_MapEnum.WaitStoreExecuteChoice = 1
Rouge2_MapEnum.WaitMapRightRefreshTime = 0.16
Rouge2_MapEnum.ScrollPosition = {
	Top = 1,
	Bottom = 0
}
Rouge2_MapEnum.ChoiceViewState = {
	Finish = 4,
	PlayingDialogue = 1,
	DialogueDone = 2,
	WaitSelect = 3
}
Rouge2_MapEnum.WaitChoiceItemAnimBlock = "WaitChoiceItemAnimBlock"
Rouge2_MapEnum.EntrustStatus = {
	Brief = 1,
	Detail = 2
}
Rouge2_MapEnum.ChangeEntrustTime = 3
Rouge2_MapEnum.FinishEntrustEffect = 3
Rouge2_MapEnum.WaitMiddleLayerEnterTime = 0.5
Rouge2_MapEnum.MovingBlock = "ActorMovingBlock"
Rouge2_MapEnum.StoreGoodsDescHeight = {
	NoHole = 400,
	WithHole = 247
}
Rouge2_MapEnum.StoreState = {
	Steal = 2,
	StealFail = 4,
	StealSucc = 3,
	FightFail = 7,
	EnterFight = 5,
	FightSucc = 6,
	Normal = 1
}
Rouge2_MapEnum.GoodsState = {
	StealFail = 5,
	StealSucc = 4,
	Sell = 2,
	CanSteal = 3,
	CanBuy = 1,
	None = 0
}
Rouge2_MapEnum.ChoiceCheckItemType = {
	Explore = 2,
	Normal = 1
}
Rouge2_MapEnum.AttrCheckType = {
	MiniGame = 2,
	ActiveRandom = 1
}
Rouge2_MapEnum.AttrCheckResult = {
	Failure = 1,
	BigSucceed = 2,
	Succeed = 0,
	None = -1
}
Rouge2_MapEnum.DropType = {
	Attribute = 3,
	Relics = 5,
	Buff = 4,
	AttrBuff = 7,
	Coin = 1,
	ActiveSkill = 6,
	RevivalCoin = 2
}
Rouge2_MapEnum.DropType2IconName = {
	[Rouge2_MapEnum.DropType.Buff] = "",
	[Rouge2_MapEnum.DropType.Relics] = "",
	[Rouge2_MapEnum.DropType.ActiveSkill] = ""
}
Rouge2_MapEnum.DropType2ItemNameLangId = {
	[Rouge2_MapEnum.DropType.Buff] = "gm_general",
	[Rouge2_MapEnum.DropType.Relics] = "p_backpack_title",
	[Rouge2_MapEnum.DropType.ActiveSkill] = "p_character_backpack"
}
Rouge2_MapEnum.ChoiceDialogueType = {
	Chat = 1,
	CheckResult = 3,
	Narration = 2,
	None = 0
}
Rouge2_MapEnum.DialoguePlayType = {
	Tween = 1,
	Directly = 2
}
Rouge2_MapEnum.AttrType = {
	BasicAttr = 3,
	CareerAttr = 1,
	EquationAttr = 2
}
Rouge2_MapEnum.BasicAttrId = {
	RelicsDropNum = 201,
	RelicsCapacity = 202,
	BuffCapacity = 204,
	ActiveSkillCapacity = 501,
	InvisibleCapacity = 203
}
Rouge2_MapEnum.AddAttrStep = 1
Rouge2_MapEnum.StoreStealFialChoiceId = {
	Fight = 2,
	FightSucc = 3,
	FightFail = 4,
	Exit = 1
}
Rouge2_MapEnum.StoreStealFialChoiceTitle = {
	[Rouge2_MapEnum.StoreStealFialChoiceId.Exit] = Rouge2_MapEnum.ConstKey.StoreStealFailReturnTitle,
	[Rouge2_MapEnum.StoreStealFialChoiceId.Fight] = Rouge2_MapEnum.ConstKey.StoreStealFailFightTitle,
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc] = Rouge2_MapEnum.ConstKey.StoreStealFightSuccTitle,
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightFail] = Rouge2_MapEnum.ConstKey.StoreStealFightFailTitle
}
Rouge2_MapEnum.StoreStealFialChoiceDesc = {
	[Rouge2_MapEnum.StoreStealFialChoiceId.Exit] = Rouge2_MapEnum.ConstKey.StoreStealFailReturnDesc,
	[Rouge2_MapEnum.StoreStealFialChoiceId.Fight] = Rouge2_MapEnum.ConstKey.StoreStealFailFightDesc,
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc] = Rouge2_MapEnum.ConstKey.StoreStealFightSuccDesc,
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightFail] = Rouge2_MapEnum.ConstKey.StoreStealFightFailDesc
}
Rouge2_MapEnum.StoreStealFialChoiceIcon = {
	[Rouge2_MapEnum.StoreStealFialChoiceId.Exit] = "rouge2_mapstore_icon2",
	[Rouge2_MapEnum.StoreStealFialChoiceId.Fight] = "rouge2_mapstore_icon1",
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc] = "rouge2_mapstore_icon1",
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightFail] = "rouge2_mapstore_icon2"
}
Rouge2_MapEnum.StoreBubbleLangId = {
	[Rouge2_MapEnum.StoreStealFialChoiceId.Exit] = "p_rouge2_mapstoreview_txt_bubble_return",
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc] = "p_rouge2_mapstoreview_txt_bubble_fightSucc",
	[Rouge2_MapEnum.StoreStealFialChoiceId.FightFail] = "p_rouge2_mapstoreview_txt_bubble_fightfail"
}
Rouge2_MapEnum.ChoiceType = {
	Double = 1,
	Normal = 0
}
Rouge2_MapEnum.StoryChoiceNormalBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_choice_itembg",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_choice_itembg2"
}
Rouge2_MapEnum.StoryChoiceLockBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_choice_itembg",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_choice_itembg2"
}
Rouge2_MapEnum.StoryChoiceSelectBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_choice_itemchoosebg",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_choice_itemchoosebg2"
}
Rouge2_MapEnum.ExploreChoiceNormalBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_mapchoice_itembg",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_mapchoice_itembg2"
}
Rouge2_MapEnum.ExploreChoiceLockBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_mapchoice_itembglock",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_mapchoice_itembglock2"
}
Rouge2_MapEnum.ExploreChoiceSelectBg = {
	[Rouge2_MapEnum.ChoiceType.Normal] = "rouge2_mapchoice_itemchoosebg",
	[Rouge2_MapEnum.ChoiceType.Double] = "rouge2_mapchoice_itemchoosebg2"
}
Rouge2_MapEnum.FunnyTaskLevelBg = {
	[FightEnum.Rouge2FunnyTaskLevel.C] = "rouge2_levelrare_4",
	[FightEnum.Rouge2FunnyTaskLevel.B] = "rouge2_levelrare_3",
	[FightEnum.Rouge2FunnyTaskLevel.A] = "rouge2_levelrare_2",
	[FightEnum.Rouge2FunnyTaskLevel.S] = "rouge2_levelrare_1"
}
Rouge2_MapEnum.FunnyTaskLevelIcon = {
	[FightEnum.Rouge2FunnyTaskLevel.C] = "rouge2_level_4",
	[FightEnum.Rouge2FunnyTaskLevel.B] = "rouge2_level_3",
	[FightEnum.Rouge2FunnyTaskLevel.A] = "rouge2_level_2",
	[FightEnum.Rouge2FunnyTaskLevel.S] = "rouge2_level_1"
}
Rouge2_MapEnum.WeatherIconSuffix = {
	PathSelect = "_2",
	Normal = "_1"
}
Rouge2_MapEnum.TechniqueId = {
	PathSelectLayer = 10,
	DifficultySelect = 3,
	AttrUpView = 8,
	SelectSystem = 23,
	CareerSelect = 4,
	BandRecruit = 14,
	BackpackRelcis = 12,
	DiceView = 7,
	BackpackActiveSkill = 13,
	MapStore = 15,
	MiddleLayer = 9,
	BackpackBoxTips = 17,
	BackpackBuff = 11,
	NormalLayer = 5,
	AttrDrop = 24
}
Rouge2_MapEnum.DiceFixType = {
	Attr = 1,
	Item = 2
}
Rouge2_MapEnum.MaxChoiceAttrNum = 1
Rouge2_MapEnum.NormalHeroRecommendPos = Vector2(100, 268)
Rouge2_MapEnum.SpecialHeroRecommendPos = Vector2(100, 190)
Rouge2_MapEnum.GuideId = {
	MiddleLayer = 32060,
	Node = 32052,
	Weather = 32055,
	TalentTree = 33507,
	BXSBox = 32059,
	ActiveSkill = 37021,
	AttrBuffDrop = 33504
}

return Rouge2_MapEnum
