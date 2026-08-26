-- chunkname: @modules/logic/explore/controller/ExploreEnum.lua

module("modules.logic.explore.controller.ExploreEnum", package.seeall)

local ExploreEnum = _M

ExploreEnum.RoleMoveDir = {
	None = false,
	Up = Vector2.New(0, 1),
	Down = Vector2.New(0, -1),
	Left = Vector2.New(-1, 0),
	Right = Vector2.New(1, 0)
}
ExploreEnum.RoleMoveRotateDirIndex = {
	[ExploreEnum.RoleMoveDir.Up] = 0,
	[ExploreEnum.RoleMoveDir.Right] = 1,
	[ExploreEnum.RoleMoveDir.Down] = 2,
	[ExploreEnum.RoleMoveDir.Left] = 3
}
ExploreEnum.RoleMoveRotateDir = {
	[0] = Vector2.New(0, 1),
	Vector2.New(1, 0),
	Vector2.New(0, -1),
	(Vector2.New(-1, 0))
}
ExploreEnum.ItemType = {
	PipePot = 224,
	Magic = 101,
	Currency = 221,
	StoneTable = 217,
	Illuminant = 215,
	Step = 210,
	Bonus = 1,
	PipeEntrance = 222,
	Battle = 3,
	PipeMemory = 226,
	Obstacle = 207,
	DoorOnce = 227,
	Archive = 228,
	BonusScene = 229,
	BagItemReward = 232,
	Ice = 206,
	Pipe = 223,
	Story = 5,
	PipeSensor = 225,
	Reset = 235,
	SceneAudio = 234,
	SequenceCount = 233,
	General = 6,
	Respawn = 7,
	Rune = 212,
	Door = 202,
	Rock = 209,
	LightBall = 216,
	Born = 0,
	Prism = 218,
	Exit = 214,
	LightReceiver = 220,
	Gate = 4,
	Teleport = 213,
	Disjunctor = 236,
	SavePoint = 231,
	GravityGear = 205,
	Spike = 201,
	Buff = 2,
	DichroicPrism = 219,
	Dialogue = 230,
	StepOnce = 211,
	Elevator = 208
}
ExploreEnum.ItemTypeToName = {}

for k, v in pairs(ExploreEnum.ItemType) do
	ExploreEnum.ItemTypeToName[v] = k
end

ExploreEnum.WhirlType = {
	Rune = 1
}
ExploreEnum.RuneTriggerType = {
	ItemActive = 1,
	RuneActive = 2,
	None = 0
}
ExploreEnum.BackPackItemType = {
	Rune = 2,
	Normal = 1
}
ExploreEnum.TriggerDir = {
	Down = 4,
	Up = 3,
	Right = 2,
	Left = 1
}
ExploreEnum.TriggerEvent = {
	CatchUnit = 30,
	MiniGame = 17,
	ChangeInteractActive = 21,
	StoneTable = 26,
	SetInteractDisabled = 2,
	DoorOpen = -1,
	ChangeCamera = 18,
	Award = 15,
	Disappear = 1,
	OpenArchiveView = -3,
	HeroPlayAnim = 35,
	MoveCamera = 10,
	SwitchActive = 37,
	ShowUnitGroup = 39,
	TriggerUnit = 14,
	Story = 16,
	Guide = 20,
	ChangeElevator = 19,
	Reset = 38,
	Battle = 0,
	GetExploreCurrency = 29,
	Rune = 23,
	Rotate = 27,
	SetInteractEnabled = 3,
	Audio = 33,
	Exit = 25,
	ChangeIcon = 40,
	ItemUnit = -2,
	Teleport = 24,
	ExplorePipeEntrance = 32,
	MarkFinish = 36,
	Spike = 28,
	Counter = 22,
	Buff = 9,
	Dialogue = 31,
	BubbleDialogue = 34
}
ExploreEnum.ServerTriggerType = {
	[ExploreEnum.ItemType.Door] = 1,
	[ExploreEnum.ItemType.Step] = 1,
	[ExploreEnum.ItemType.StepOnce] = 1,
	[ExploreEnum.ItemType.Currency] = 1,
	[ExploreEnum.ItemType.GravityGear] = 1,
	[ExploreEnum.ItemType.Ice] = 1,
	[ExploreEnum.ItemType.Obstacle] = 1,
	[ExploreEnum.ItemType.Elevator] = 1,
	[ExploreEnum.ItemType.LightReceiver] = 1,
	[ExploreEnum.ItemType.Rock] = 1,
	[ExploreEnum.ItemType.LightBall] = 1,
	[ExploreEnum.ItemType.BonusScene] = 1
}
ExploreEnum.ItemEffect = {
	CreateUnit2 = "3",
	CreateUnit = "1",
	Fix = "4",
	Active = "2"
}
ExploreEnum.ItemEffectRange = {
	Round = 1
}
ExploreEnum.EnterMode = {
	Normal = 2,
	Battle = 3,
	First = 1
}
ExploreEnum.ProgressType = {
	[ExploreEnum.ItemType.Battle] = true,
	[ExploreEnum.ItemType.Bonus] = true
}
ExploreEnum.InteractIndex = {
	InteractEnabled = 2,
	IsFinish = 4,
	ActiveState = 3,
	IsEnter = 1
}
ExploreEnum.LightRecvType = {
	Photic = 2,
	Barricade = 1,
	Custom = 3
}
ExploreEnum.RuneStatus = {
	Inactive = 0,
	Active = 1
}
ExploreEnum.ExplorePipePotHangType = {
	UnCarry = 2,
	Put = 4,
	Carry = 1,
	Pick = 3
}
ExploreEnum.SceneCheckMode = {
	Rage = 0,
	Planes = 2,
	Camera = 1
}
ExploreEnum.PipeColor = {
	Color3 = 4,
	Color2 = 2,
	Color1 = 1,
	None = 0
}
ExploreEnum.PipeColorDef = {
	[ExploreEnum.PipeColor.None] = Color.New(),
	[ExploreEnum.PipeColor.Color1] = Color.New(0.7735849, 0.2799217, 0.2152901),
	[ExploreEnum.PipeColor.Color2] = Color.New(0.199134, 0.4504557, 0.851),
	[ExploreEnum.PipeColor.Color3] = Color.New(0.16775, 0.61, 0.2614471)
}
ExploreEnum.PipeGoNode = {
	Pipe4 = 5,
	Pipe3 = 4,
	Pipe2 = 3,
	Pipe1 = 2,
	Center = 1
}
ExploreEnum.PipeGoNodeName = {
	[ExploreEnum.PipeGoNode.Center] = "#go_center",
	[ExploreEnum.PipeGoNode.Pipe1] = "#go_pipe1",
	[ExploreEnum.PipeGoNode.Pipe2] = "#go_pipe2",
	[ExploreEnum.PipeGoNode.Pipe3] = "#go_pipe3",
	[ExploreEnum.PipeGoNode.Pipe4] = "#go_pipe4"
}
ExploreEnum.PipeShape = {
	Shape5 = 5,
	Shape6 = 6,
	Shape2 = 2,
	Shape3 = 3,
	Shape4 = 4,
	Shape1 = 1
}
ExploreEnum.PipeDirMatchMode = {
	All = 3,
	Single = 1,
	Both = 2
}
ExploreEnum.MapStatus = {
	RotateUnit = 3,
	UseItem = 1,
	MoveUnit = 2,
	Normal = 0
}
ExploreEnum.PipeTypes = {
	[ExploreEnum.ItemType.PipeEntrance] = true,
	[ExploreEnum.ItemType.Pipe] = true,
	[ExploreEnum.ItemType.PipeSensor] = true,
	[ExploreEnum.ItemType.PipeMemory] = true
}
ExploreEnum.PrismTypes = {
	[ExploreEnum.ItemType.Prism] = true,
	[ExploreEnum.ItemType.DichroicPrism] = true
}
ExploreEnum.StepType = {
	ResetBegin = -7,
	ArchiveClient = -4,
	DelUnit = 3,
	Rotate = 13,
	Archive = 16,
	Battle = 12,
	UpdateCoin = 5,
	Success = 11,
	UpdateUnit = 2,
	ShowArea = 14,
	HideArea = 15,
	RoleMove = 1,
	AddMaterial = 4,
	UseItem = 10,
	CheckCounter = -6,
	BonusScene = 17,
	CameraMoveBack = -2,
	Story = 6,
	CameraMove = -1,
	Spike = 7,
	Transfer = 8,
	ResetEnd = -8,
	BonusSceneClient = -5,
	Dialogue = -3,
	Elevator = 9,
	TriggerAudio = -9
}
ExploreEnum.MustDoStep = {
	[ExploreEnum.StepType.UpdateCoin] = true,
	[ExploreEnum.StepType.Archive] = true,
	[ExploreEnum.StepType.BonusScene] = true
}
ExploreEnum.StepTypeToName = {}

for k, v in pairs(ExploreEnum.StepType) do
	ExploreEnum.StepTypeToName[v] = k
end

ExploreEnum.MapCompType = {
	Pipe = 4,
	Whirl = 3,
	Light = 2,
	Map = 1
}
ExploreEnum.CoinType = {
	GoldCoin = 1,
	Bonus = 0,
	PurpleCoin = 2
}
ExploreEnum.HeroLock = {
	Spike = 8,
	Rune = 6,
	Teleport = 12,
	CatchUnit = 3,
	HeroAnim = 4,
	BeginInteract = 13,
	UnitIdLock = 1000000,
	All = 0,
	MoveCamera = 7,
	UseItem = 9,
	Ice = 5,
	Pipe = 15,
	WaitUnitAnim = 10,
	PlayTriggerAnim = 14,
	Guide = 1,
	ShowArea = 2,
	Reset = 11
}
ExploreEnum.WalkAudioType = {
	Normal = 1,
	Ice = 2,
	None = 0
}
ExploreEnum.NodeType = {
	Ice = 2,
	Obstacle = 3,
	Normal = 1
}

return ExploreEnum
