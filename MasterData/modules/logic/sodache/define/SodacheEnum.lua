-- chunkname: @modules/logic/sodache/define/SodacheEnum.lua

module("modules.logic.sodache.define.SodacheEnum", package.seeall)

local SodacheEnum = _M

SodacheEnum.ConstId = {
	WorshipItemCond = 7,
	WorshipCost = 1,
	BaseDiceCount = 8,
	CoinConvertCoefficient = 12,
	PlayerModel = 2
}
SodacheEnum.ShopType = {
	BlackMarket = 2,
	Normal = 1
}
SodacheEnum.BuildingType = {
	Relic = 105,
	Enter = 101,
	Cost = 104
}
SodacheEnum.ItemType = {
	Card = 2,
	Unknown = 0,
	Item = 1
}
SodacheEnum.ItemQuality = {
	Two = 2,
	Five = 5,
	Three = 3,
	Four = 4,
	One = 1,
	Six = 6
}
SodacheEnum.BagType = {
	Outside = 2,
	Inside = 1
}
SodacheEnum.CardType = {
	Supplies = 1,
	Adventure = 2,
	Status = 4,
	Ammo = 3,
	Offering = 5,
	None = 0
}
SodacheEnum.CardSubType = {
	Adventure_Room = 201,
	Adventure_Sp = 202,
	Supplies_Rock = 101,
	Supplies_Spirit = 105,
	Offering_Wood = 503,
	Supplies_Star = 102,
	Offering_Rock = 501,
	Offering_Wisdom = 506,
	Adventure_Interaction = 203,
	Offering_Spirit = 505,
	Supplies_Wood = 103,
	Offering_Star = 502,
	Status_Buff = 401,
	Offering_Animal = 504,
	Supplies_Animal = 104,
	Supplies_Wisdom = 106,
	Status_Debuff = 402,
	None = 0
}
SodacheEnum.CurrencyId = {
	Coin = 10000000
}
SodacheEnum.AttrId = {
	ActionPoint = 30001,
	TopVision = 30004,
	MoveFirstCost = 30019,
	ShopItemPriceFix = 40004,
	NormalVision = 30003,
	FailCostEx = 30015,
	EventActionFix = 30018,
	WinCost = 30012,
	FailCost = 30013,
	DiceCountEx = 40006,
	BlackMarketPriceFix = 40005,
	MoveActionFixPer = 30017,
	WinCostEx = 30014,
	EvilValue = 50001,
	DiceCount = 40002,
	MoveStepCost = 30020,
	AltarLimit = 30005,
	MoveActionFix = 30021
}
SodacheEnum.OpenId = {
	Offering_Worship = 2,
	Lose_Cost = 1,
	HardMode = 3
}
SodacheEnum.MapType = {
	Simple = 1,
	Rookie = 9,
	Hard = 2
}
SodacheEnum.InsideSceneStatus = {
	End = 4,
	SelectTime = 0,
	ShopAndOffering = 1,
	SelectCard = 3,
	Normal = 2
}
SodacheEnum.CardSource = {
	Warehouse = 3,
	ClientShow = 2,
	CardSelect = 1,
	Normal = 0
}
SodacheEnum.OperType = {
	SelectChoice = 8,
	FightSelectCard = 6,
	UseCard = 3,
	LeaveBorn = 11,
	FightEnd = 5,
	ContinueMove = 7,
	SelectTime = 10,
	Interaction = 2,
	Move = 1
}
SodacheEnum.StepType = {
	UpdateUnits = 8,
	CheckResult = 10,
	AddUnits = 4,
	OpenPanel = 11,
	DeleteTask = 15,
	UpdatePatrolInfo = 20,
	UpdateBattle = 3,
	DropCard = 9,
	FuncOpenUpdate = 25,
	LevelUpdate = 16,
	LoseCard = 22,
	UseCard = 21,
	UpdateTask = 14,
	ClosePanel = 13,
	TweenCamera = 19,
	ActiveAltar = 18,
	UpdatePanel = 12,
	AddNodeVision = 23,
	ContainerFinish = 24,
	RemoveUnits = 7,
	UpdateInsideProp = 17,
	Move = 1
}
SodacheEnum.StepTypeToName = {}

for k, v in pairs(SodacheEnum.StepType) do
	SodacheEnum.StepTypeToName[v] = k
end

SodacheEnum.UnitStatus = {
	Finish = 1,
	None = 0
}
SodacheEnum.UnitType = {
	Enemy = 4,
	Shop = 9,
	Altar = 2,
	Random = 6,
	Worship = 10,
	Born = 8,
	Player = 0,
	Escape = 3,
	Dialogue = 7,
	Container = 1,
	Empty = 11
}
SodacheEnum.UnitTypeToName = {}

for k, v in pairs(SodacheEnum.UnitType) do
	SodacheEnum.UnitTypeToName[v] = k
end

SodacheEnum.MapNodeOperBtnType = {
	Fight = 4,
	Shop = 1,
	Altar = 2,
	Leave = 3,
	Event = 6,
	LeaveEvent = 7,
	StrongEvent = 5
}
SodacheEnum.MapNodeOperBtnName = {}

for k, v in pairs(SodacheEnum.MapNodeOperBtnType) do
	SodacheEnum.MapNodeOperBtnName[v] = k
end

SodacheEnum.MapBtnClickType = {
	Drag = 8,
	NodeClick = 1,
	UnitClick = 4,
	MapScene = 2,
	None = 0
}
SodacheEnum.FightStatus = {
	Win = 2,
	Lose = 3,
	ShowPanel = 1,
	None = 0
}
SodacheEnum.DungeonMapCameraSize = 5
SodacheEnum.DungeonMapCameraSize2 = 3.5
SodacheEnum.EpisodeId = 1374701
SodacheEnum.MapPlayerMoveTime = 0.5
SodacheEnum.HandBookType = {
	Card = 1
}
SodacheEnum.HandBookSubType = {
	Supplies = 1,
	Ammo = 3,
	Adventure = 2,
	Offering = 5
}
SodacheEnum.TaskType = {
	Branch = 2,
	Main = 1
}
SodacheEnum.TaskState = {
	Finished = 2,
	Received = 3,
	Processing = 1,
	Accept = 0
}
SodacheEnum.ShopChatTriggerType = {
	OpenBlackMarket = 1
}
SodacheEnum.DiceColor = {
	Blue = 1,
	Red = 2,
	Yellow = 3,
	None = 100
}
SodacheEnum.CheckResult = {
	BigSuccess = 2,
	Fail = 0,
	Success = 1
}
SodacheEnum.Reason = {
	SelectTime = 5000
}
SodacheEnum.PanelViewName = {
	[SodacheEnum.UnitType.Random] = ViewName.SodacheRandomEventView,
	[SodacheEnum.UnitType.Dialogue] = ViewName.SodacheDialoguePanelView,
	[SodacheEnum.UnitType.Container] = ViewName.SodacheDialoguePanelView
}
SodacheEnum.MainSceneOffset = Vector2.New(-12.38, 10.8)
SodacheEnum.LevelProgressTime = 0.6
SodacheEnum.PreviewLineColor = Color.New(1, 1, 0, 1)
SodacheEnum.PatrollLineColor = Color.New(1, 0, 0, 1)

return SodacheEnum
