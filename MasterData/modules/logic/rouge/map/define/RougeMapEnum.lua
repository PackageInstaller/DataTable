-- chunkname: @modules/logic/rouge/map/define/RougeMapEnum.lua

module("modules.logic.rouge.map.define.RougeMapEnum", package.seeall)

local RougeMapEnum = _M

RougeMapEnum.RedNodeResPath = "ui/viewres/gm/rouge/red_point.prefab"
RougeMapEnum.GreenNodeResPath = "ui/viewres/gm/rouge/green_point.prefab"
RougeMapEnum.PathSelectLayerPath = "ui/viewres/gm/rouge/green_point.prefab"
RougeMapEnum.LineResPath = "ui/viewres/gm/rouge/line_local.prefab"
RougeMapEnum.ActorPiecePath = "v1a9_m_s16_saide"
RougeMapEnum.CollectionLeftItemRes = "ui/viewres/rouge/map/rougecollectionleftitem.prefab"
RougeMapEnum.CollectionRightItemRes = "ui/viewres/rouge/map/rougecollectionrightitem.prefab"
RougeMapEnum.ChapterId = 2901
RougeMapEnum.ConstKey = {
	ShowNormalFightUnlockTalentId = 32,
	ShowEliteFightUnlockTalentId = 31,
	RestStoreRefreshCount = 13,
	EliteFightDropRefreshUnlockTalentId = 34,
	HardFightDropRefreshUnlockTalentId = 36,
	ExchangeCount = 19,
	PathSelectCameraSize = 17,
	HardFightDropRefreshCount = 37,
	ShowHardFightUnlockTalentId = 33,
	FightRetryNum = 43,
	RestStoreUnlockTalentId = 30,
	EliteFightDropRefreshCount = 35,
	StoreRefreshCost = 21
}
RougeMapEnum.PathSelectIndex = -1
RougeMapEnum.MapState = {
	Normal = 4,
	SwitchMapAnim = 1,
	LoadingMap = 2,
	WaitFlow = 3,
	Empty = 0
}
RougeMapEnum.MapType = {
	Edit = 0,
	Middle = 2,
	PathSelect = 3,
	Normal = 1
}
RougeMapEnum.MapType2ModelCls = {
	[RougeMapEnum.MapType.Normal] = RougeLayerMapModel,
	[RougeMapEnum.MapType.Middle] = RougeMiddleLayerMapModel,
	[RougeMapEnum.MapType.PathSelect] = RougePathSelectMapModel
}
RougeMapEnum.ChangeMapEnum = {
	PathSelectToNormal = 3,
	MiddleToPathSelect = 2,
	NormalToMiddle = 1
}
RougeMapEnum.ScenePrefabFormat = "scenes/v1a9_m_s16_dilao/prefab/%s.prefab"
RougeMapEnum.Arrive = {
	CantArrive = 1,
	CanArrive = 3,
	ArrivingFinish = 5,
	Arrived = 6,
	NotArrive = 2,
	ArrivingNotFinish = 4
}
RougeMapEnum.NodeSelectArriveStatus = RougeMapEnum.Arrive.ArrivingNotFinish
RougeMapEnum.EventType = {
	Reward = 5,
	HardFight = 2,
	BossFight = 4,
	Rest = 8,
	Unknow = 13,
	ChoiceLair = 11,
	NormalFight = 1,
	Choice = 6,
	FightLair = 12,
	Store = 7,
	WatchTower = 9,
	LevelUpSp = 14,
	TreasurePlace = 10,
	EliteFight = 3,
	Empty = 0
}
RougeMapEnum.EventDefaultPic = {
	[RougeMapEnum.EventType.NormalFight] = "rouge_map_detailmap_01",
	[RougeMapEnum.EventType.HardFight] = "rouge_map_detailmap_02",
	[RougeMapEnum.EventType.EliteFight] = "rouge_map_detailmap_03",
	[RougeMapEnum.EventType.Reward] = "rouge_map_detailmap_04",
	[RougeMapEnum.EventType.Choice] = "rouge_map_detailmap_05",
	[RougeMapEnum.EventType.Store] = "rouge_map_detailmap_06",
	[RougeMapEnum.EventType.Rest] = "rouge_map_detailmap_07",
	[RougeMapEnum.EventType.WatchTower] = "rouge_map_detailmap_08",
	[RougeMapEnum.EventType.TreasurePlace] = "rouge_map_detailmap_09",
	[RougeMapEnum.EventType.ChoiceLair] = "rouge_map_detailmap_10",
	[RougeMapEnum.EventType.FightLair] = "rouge_map_detailmap_10",
	[RougeMapEnum.EventType.Unknow] = "rouge_map_detailmap_11",
	[RougeMapEnum.EventType.LevelUpSp] = "rouge_map_detailmap_12"
}
RougeMapEnum.PicFormat = "singlebg/rouge/mapdetail/%s.png"
RougeMapEnum.MonsterMaskFormat = "singlebg/rouge/mapdetail/monster/%s.png"
RougeMapEnum.EventType2Cls = {
	[RougeMapEnum.EventType.Reward] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.Choice] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.Rest] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.Store] = RougeStoreEventMO,
	[RougeMapEnum.EventType.NormalFight] = RougeFightEventMO,
	[RougeMapEnum.EventType.HardFight] = RougeFightEventMO,
	[RougeMapEnum.EventType.EliteFight] = RougeFightEventMO,
	[RougeMapEnum.EventType.BossFight] = RougeFightEventMO,
	[RougeMapEnum.EventType.WatchTower] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.TreasurePlace] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.ChoiceLair] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.FightLair] = RougeFightEventMO,
	[RougeMapEnum.EventType.Unknow] = RougeChoiceEventMO,
	[RougeMapEnum.EventType.LevelUpSp] = RougeChoiceEventMO
}
RougeMapEnum.NodeType = {
	End = 3,
	Start = 1,
	Normal = 2
}
RougeMapEnum.EventState = {
	Finish = 2,
	Start = 1,
	Init = 0
}
RougeMapEnum.IconPath = {
	[RougeMapEnum.EventType.NormalFight] = "icon_normal_fight",
	[RougeMapEnum.EventType.HardFight] = "icon_hard_fight",
	[RougeMapEnum.EventType.EliteFight] = "icon_elite_fight",
	[RougeMapEnum.EventType.Reward] = "icon_reward",
	[RougeMapEnum.EventType.Choice] = "icon_choice",
	[RougeMapEnum.EventType.Store] = "icon_store",
	[RougeMapEnum.EventType.Rest] = "icon_rest",
	[RougeMapEnum.EventType.WatchTower] = "icon_8",
	[RougeMapEnum.EventType.TreasurePlace] = "icon_9",
	[RougeMapEnum.EventType.ChoiceLair] = "icon_10",
	[RougeMapEnum.EventType.FightLair] = "icon_10",
	[RougeMapEnum.EventType.Unknow] = "icon_11",
	[RougeMapEnum.EventType.LevelUpSp] = "icon_12"
}
RougeMapEnum.StartNodeBgPath = "bg_start"
RougeMapEnum.NodeBgPath = {
	Normal = {
		[RougeMapEnum.Arrive.CantArrive] = "bg_normal_cant_arrive",
		[RougeMapEnum.Arrive.NotArrive] = "bg_normal_cant_arrive",
		[RougeMapEnum.Arrive.CanArrive] = "bg_normal_can_arrive",
		[RougeMapEnum.Arrive.ArrivingNotFinish] = "bg_normal_arriving_not_finish",
		[RougeMapEnum.Arrive.ArrivingFinish] = "bg_normal_arriving_finish",
		[RougeMapEnum.Arrive.Arrived] = "bg_normal_arrived"
	},
	Special = {
		[RougeMapEnum.Arrive.CantArrive] = "bg_special_cant_arrive",
		[RougeMapEnum.Arrive.NotArrive] = "bg_special_cant_arrive",
		[RougeMapEnum.Arrive.CanArrive] = "bg_special_can_arrive",
		[RougeMapEnum.Arrive.ArrivingNotFinish] = "bg_special_arriving_not_finish",
		[RougeMapEnum.Arrive.ArrivingFinish] = "bg_special_arriving_finish",
		[RougeMapEnum.Arrive.Arrived] = "bg_special_arrived"
	}
}
RougeMapEnum.FogMaterialUrl = "scenes/v1a9_m_s16_dilao/scene_prefab/v2a1_smoke_mask.prefab"
RougeMapEnum.MaxHoleNum = 5
RougeMapEnum.HoleSize = -1.21
RougeMapEnum.FogDuration = 1
RougeMapEnum.NormalLineCutValue = 0
RougeMapEnum.HideLineCutValue = 1
RougeMapEnum.FogLineCutValue = 0.4
RougeMapEnum.HoleLineCutValue = 0.85
RougeMapEnum.FogOffset = {
	-4,
	0
}
RougeMapEnum.HolePosOffset = {
	0,
	0.18
}
RougeMapEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
RougeMapEnum.MiddleLayerPointType = {
	Leave = 3,
	Pieces = 1,
	Path = 2
}
RougeMapEnum.LeaveId = -1
RougeMapEnum.LeaveAnchorOffset = Vector2(-21, 77.7)
RougeMapEnum.OffsetZ = {
	PiecesContainer = -7,
	PieceIcon = -8,
	NodeContainer = -2,
	PathContainer = -6,
	Map = 10
}
RougeMapEnum.NodeOffsetZInterval = 0.1
RougeMapEnum.NodeIconOffsetZInterval = 0.5
RougeMapEnum.Scale = {
	Icon = 1.3,
	NodeBg = 1.3
}
RougeMapEnum.MapStartOffsetX = 2.5
RougeMapEnum.MapEndOffsetX = 2.5
RougeMapEnum.MaxMapEpisodeIntervalX = 6
RougeMapEnum.NodeLocalPosXRange = 1
RougeMapEnum.NodeLocalPosY = {
	{
		0.5
	},
	{
		0.4,
		0.6
	},
	{
		0.3,
		0.5,
		0.7
	},
	{
		0.2,
		0.4,
		0.6,
		0.8
	}
}
RougeMapEnum.NodeGlobalOffsetY = 0.075
RougeMapEnum.StartBgOffset = Vector2(0, 0)
RougeMapEnum.NodeBgOffset = {
	[RougeMapEnum.Arrive.CantArrive] = Vector2(0, 0),
	[RougeMapEnum.Arrive.NotArrive] = Vector2(0, 0),
	[RougeMapEnum.Arrive.CanArrive] = Vector2(0.23, 0.84),
	[RougeMapEnum.Arrive.ArrivingNotFinish] = Vector2(0.188, 1.739),
	[RougeMapEnum.Arrive.ArrivingFinish] = Vector2(0.204, 1.77),
	[RougeMapEnum.Arrive.Arrived] = Vector2(0.195, 0.86)
}
RougeMapEnum.IconOffset = {
	[RougeMapEnum.Arrive.CantArrive] = Vector2(0, 0.47),
	[RougeMapEnum.Arrive.NotArrive] = Vector2(0, 0.47),
	[RougeMapEnum.Arrive.CanArrive] = Vector2(0, 1.2),
	[RougeMapEnum.Arrive.ArrivingNotFinish] = Vector2(0, 2.02),
	[RougeMapEnum.Arrive.ArrivingFinish] = Vector2(0, 2.18),
	[RougeMapEnum.Arrive.Arrived] = Vector2(0, 1.21)
}
RougeMapEnum.ActorOffset = Vector2(-0.05, 0.623)
RougeMapEnum.StartClickArea = Vector4(80, 50, 0, 0)
RougeMapEnum.ClickArea = {
	[RougeMapEnum.Arrive.CantArrive] = Vector4(120, 100, 0.66, 14.09),
	[RougeMapEnum.Arrive.NotArrive] = Vector4(120, 110, 1.55, 26.89),
	[RougeMapEnum.Arrive.CanArrive] = Vector4(200, 170, -12.65, -26.41),
	[RougeMapEnum.Arrive.ArrivingNotFinish] = Vector4(235, 330, -8.14, -22.11),
	[RougeMapEnum.Arrive.ArrivingFinish] = Vector4(236, 345, -7.95, -5.48),
	[RougeMapEnum.Arrive.Arrived] = Vector4(160, 190, -13.62, -11.17)
}
RougeMapEnum.LeaveItemClickArea = Vector4(320.29, 184.6, -18.2, 78.39)
RougeMapEnum.LayerItemClickArea = Vector4(120, 100, 0, 0)
RougeMapEnum.PieceClickArea = Vector4(120, 270, 0, 49.42)
RougeMapEnum.ChoiceItemPos = {
	{
		Vector2(29.7, 10.8)
	},
	{
		Vector2(70, 146),
		Vector2(20.38, -126.4)
	},
	{
		Vector2(-48, 240),
		Vector2(120, -6),
		Vector2(-48, -245.2)
	},
	{
		Vector2(-48, 298.3),
		Vector2(120, 67.9),
		Vector2(-12, -155),
		Vector2(-88, -382)
	}
}
RougeMapEnum.ChoiceStatus = {
	UnSelect = 5,
	Bought = 4,
	Select = 3,
	Lock = 1,
	Normal = 2
}
RougeMapEnum.PieceChoiceViewStatus = {
	Store = 2,
	Choice = 1
}
RougeMapEnum.DialogueOffsetX = {
	WithChoice = -172.8,
	Normal = 0
}
RougeMapEnum.DialogueInterval = 0.05
RougeMapEnum.InteractType = {
	Recruit = 5,
	LossCollection = 2,
	DropBossCollection = 15,
	Drop = 1,
	DropGroup = 6,
	LossAndCopy = 7,
	LossNotUniqueCollection = 9,
	LossCoin = 11,
	LossSpCollection = 14,
	LevelUpSp = 13,
	AdvanceDrop = 12,
	Resurgence = 4,
	StorageCollection = 10,
	ReturnBlood = 3,
	LossAssignCollection = 8
}
RougeMapEnum.ReturnBloodEnum = {
	All = 1,
	Select = 2
}
RougeMapEnum.ShowMapRightEnum = {
	Piece = 3,
	Node = 1,
	Layer = 2
}
RougeMapEnum.PieceEntrustType = {
	Hard = 3,
	Rest = 1,
	Boss = 5,
	Ending = 4,
	Normal = 2
}
RougeMapEnum.MiddleLayerLeavePath = "scenes/v1a9_m_s16_dilao_room/prefab/chukou.prefab"
RougeMapEnum.PieceIconBgEnum = {
	Hard = 2,
	Normal = 1
}
RougeMapEnum.PieceIconBgRes = {
	[RougeMapEnum.PieceIconBgEnum.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di.prefab",
	[RougeMapEnum.PieceIconBgEnum.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di2.prefab"
}
RougeMapEnum.PieceIconRes = {
	[RougeMapEnum.PieceEntrustType.Rest] = "scenes/v1a9_m_s16_dilao_room/prefab/xiuzheng.prefab",
	[RougeMapEnum.PieceEntrustType.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_1.prefab",
	[RougeMapEnum.PieceEntrustType.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_2.prefab",
	[RougeMapEnum.PieceEntrustType.Ending] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_jieju.prefab"
}
RougeMapEnum.PieceIconBg = {
	[RougeMapEnum.PieceEntrustType.Rest] = RougeMapEnum.PieceIconBgEnum.Normal,
	[RougeMapEnum.PieceEntrustType.Normal] = RougeMapEnum.PieceIconBgEnum.Normal,
	[RougeMapEnum.PieceEntrustType.Hard] = RougeMapEnum.PieceIconBgEnum.Hard,
	[RougeMapEnum.PieceEntrustType.Ending] = RougeMapEnum.PieceIconBgEnum.Normal
}
RougeMapEnum.PieceIconOffset = Vector2(0, 1.65)
RougeMapEnum.PieceTriggerType = {
	Compound = 3,
	Shop = 4,
	Reward = 2,
	EndFight = 6,
	Exchange = 5,
	AcceptEntrust = 1,
	LevelUpSp = 7,
	Empty = 0
}
RougeMapEnum.MiddleLayerCameraSizeRate = 0.8
RougeMapEnum.PathSelectMapWaitTime = 1
RougeMapEnum.LossType = {
	Storage = 3,
	Abandon = 1,
	Exchange = 2,
	Copy = 4,
	AbandonSp = 5
}
RougeMapEnum.LineType = {
	Arrived = 4,
	CanArrive = 3,
	NotArrive = 2,
	CantArrive = 1,
	None = 0
}
RougeMapEnum.LinePrefabRes = "scenes/v1a9_m_s16_dilao/prefab/dituxian_1.prefab"
RougeMapEnum.LineIconRes = {
	[RougeMapEnum.LineType.CantArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_1.png",
	[RougeMapEnum.LineType.NotArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_2.png",
	[RougeMapEnum.LineType.CanArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_3.png",
	[RougeMapEnum.LineType.Arrived] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_4.png"
}
RougeMapEnum.StatusLineMap = {
	[RougeMapEnum.Arrive.CantArrive] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.CantArrive
	},
	[RougeMapEnum.Arrive.NotArrive] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.NotArrive,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.NotArrive,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.NotArrive,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.CanArrive,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.None
	},
	[RougeMapEnum.Arrive.CanArrive] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.CanArrive,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.None
	},
	[RougeMapEnum.Arrive.ArrivingNotFinish] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.Arrived,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.Arrived
	},
	[RougeMapEnum.Arrive.ArrivingFinish] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.Arrived,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.Arrived
	},
	[RougeMapEnum.Arrive.Arrived] = {
		[RougeMapEnum.Arrive.CantArrive] = RougeMapEnum.LineType.CantArrive,
		[RougeMapEnum.Arrive.NotArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.CanArrive] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingNotFinish] = RougeMapEnum.LineType.None,
		[RougeMapEnum.Arrive.ArrivingFinish] = RougeMapEnum.LineType.Arrived,
		[RougeMapEnum.Arrive.Arrived] = RougeMapEnum.LineType.Arrived
	}
}
RougeMapEnum.LineOffset = 0.636
RougeMapEnum.CollectionDropViewEnum = {
	Select = 1,
	OnlyShow = 2
}
RougeMapEnum.RevertDuration = 0.4
RougeMapEnum.MoveSpeed = 7
RougeMapEnum.CameraTweenLine = EaseType.OutCubic
RougeMapEnum.TipShowDuration = 2.5
RougeMapEnum.TipShowInterval = 0.5
RougeMapEnum.DayOrNight = {
	Day = 1,
	Night = 2
}
RougeMapEnum.DayOrNightSuffix = {
	[RougeMapEnum.DayOrNight.Day] = "day",
	[RougeMapEnum.DayOrNight.Night] = "night"
}
RougeMapEnum.PieceDir = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
RougeMapEnum.ActorDir = {
	Bottom = 2,
	Right = 6,
	LeftBottom = 1,
	RightTop = 9,
	Top = 8,
	RightBottom = 3,
	Left = 4,
	LeftTop = 7
}
RougeMapEnum.EntrustEventType = {
	Curse = 4,
	LevelUpSpCollection = 9,
	Event = 3,
	MakeMoney = 1,
	CostMoney = 2,
	FinishEvent = 7,
	MakePower = 6,
	GetCollection = 8,
	CostPower = 5
}
RougeMapEnum.FinishEnum = {
	Finish = 1,
	Fail = 2
}
RougeMapEnum.UnSelectLineAlpha = 0.3
RougeMapEnum.SwitchLayerMinDuration = 3
RougeMapEnum.SwitchLayerMaxDuration = 10
RougeMapEnum.CoinChangeDuration = 1
RougeMapEnum.PowerChangeDuration = 1
RougeMapEnum.TalkAnchorOffset = {
	[RougeMapEnum.MapType.Normal] = Vector2(0, 31.46),
	[RougeMapEnum.MapType.Middle] = Vector2(0, 73.34)
}
RougeMapEnum.TalkDuration = 2
RougeMapEnum.TalkCD = 5
RougeMapEnum.ShortVoiceTriggerType = {
	EnterPathSelectLayer = 3,
	FinishEvent = 6,
	EnterMiddleLayer = 2,
	MiddleLayerMove = 8,
	EnterNormalLayer = 1,
	AcceptEntrust = 5,
	NormalLayerMove = 7,
	ExitPieceTalk = 4
}
RougeMapEnum.ChoiceSelectAnimDuration = 0.667
RougeMapEnum.EffectType = {
	UnlockFightDropRefresh = 23,
	UnlockRestRefresh = 21,
	UpdateExchangeDisplaceNum = 28,
	UnlockShowPassFightMask = 26
}
RougeMapEnum.ExpAddDuration = 0.5
RougeMapEnum.WaitSuccAnimDuration = 2
RougeMapEnum.WaitSuccPlayAudioDuration = 1
RougeMapEnum.WaitSwitchMapAnim = 0.33
RougeMapEnum.SwitchMapAnimDuration = 1.33
RougeMapEnum.WaitStoryCloseAnim = 1
RougeMapEnum.PieceBossEffect = "scenes/v1a9_m_s16_dilao_room/scene_prefab/chesseffect/luoleilai_effect.prefab"
RougeMapEnum.MaxTipHeight = 924
RougeMapEnum.CollectionChangeAnimDuration = 0.5
RougeMapEnum.LifeChangeStatus = {
	Add = 3,
	Reduce = 1,
	Idle = 2
}
RougeMapEnum.WaitStoreRefreshAnimDuration = 0.2
RougeMapEnum.WaitMapRightRefreshTime = 0.16
RougeMapEnum.ScrollPosition = {
	Top = 1,
	Bottom = 0
}
RougeMapEnum.ChoiceViewState = {
	Finish = 3,
	PlayingDialogue = 1,
	WaitSelect = 2
}
RougeMapEnum.WaitChoiceItemAnimBlock = "WaitChoiceItemAnimBlock"
RougeMapEnum.EntrustStatus = {
	Brief = 1,
	Detail = 2
}
RougeMapEnum.ChangeEntrustTime = 3
RougeMapEnum.FinishEntrustEffect = 3
RougeMapEnum.WaitMiddleLayerEnterTime = 0.5
RougeMapEnum.MovingBlock = "ActorMovingBlock"
RougeMapEnum.StoreGoodsDescHeight = {
	NoHole = 400,
	WithHole = 247
}

return RougeMapEnum
