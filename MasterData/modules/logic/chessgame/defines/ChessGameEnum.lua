-- chunkname: @modules/logic/chessgame/defines/ChessGameEnum.lua

module("modules.logic.chessgame.defines.ChessGameEnum", package.seeall)

local ChessGameEnum = _M

ChessGameEnum.NodeXOffset = 1.259
ChessGameEnum.NodeYOffset = 0.804
ChessGameEnum.NodeZOffset = 0.005
ChessGameEnum.NodePath = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab"
ChessGameEnum.SceneResPath = {
	AlarmItem3 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_red.prefab",
	DirItem = "scenes/v2a1_m_s12_lsp_jshd/prefab/diban_selected.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	AlarmItem2 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_yellow.prefab"
}
ChessGameEnum.InteractType = {
	Hit = 4,
	Teleport = 3,
	Obstacle = 8,
	Prey = 7,
	Role = 2,
	Hunter = 6,
	Save = 5,
	Normal = 1
}
ChessGameEnum.ChessSelectType = {
	CatchObj = 2,
	Normal = 1
}
ChessGameEnum.ClickRangeX = 90
ChessGameEnum.ClickRangeY = 55
ChessGameEnum.ClickYWeight = 1.2
ChessGameEnum.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
ChessGameEnum.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
ChessGameEnum.OptType = {
	WithInteract = 1,
	Single = 0,
	UseItem = 2
}
ChessGameEnum.GameEffectType = {
	Display = 2,
	Talk = 1,
	None = 0
}
ChessGameEnum.EffectPath = {
	[ChessGameEnum.GameEffectType.Display] = "scenes/v2a1_m_s12_lsp_jshd/prefab/hudong.prefab",
	[ChessGameEnum.GameEffectType.Talk] = "scenes/v2a1_m_s12_lsp_jshd/prefab/duihua.prefab"
}
ChessGameEnum.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
ChessGameEnum.TileBaseType = {
	Normal = 1,
	None = 0
}
ChessGameEnum.InteractTypeToName = {}

for name, index in pairs(ChessGameEnum.InteractType) do
	ChessGameEnum.InteractTypeToName[index] = name
end

ChessGameEnum.EventType = {
	Hide = 4,
	Story = 2,
	Finish = 9,
	Guide = 3,
	ChangeModel = 10,
	Show = 5,
	Count = 1,
	Dialog = 6,
	Pass = 7,
	MoveOther = 11,
	Dead = 8
}
ChessGameEnum.StepType = {
	Pass = 8,
	ChangeModule = 13,
	Talk = 16,
	CurrMapRefresh = 4,
	Completed = 11,
	ShowInteract = 12,
	InteractDelete = 5,
	RefreshTarget = 17,
	Transport = 3,
	Dead = 9,
	Story = 6,
	Guide = 7,
	ShowToast = 14,
	UpdateRound = 1,
	BreakObstacle = 15,
	Dialogue = 10,
	Move = 2
}
ChessGameEnum.StepTypeToName = {}

for name, index in pairs(ChessGameEnum.StepType) do
	ChessGameEnum.StepTypeToName[index] = name
end

ChessGameEnum.ContainerOffsetZ = {
	Interact = -2,
	Background = -0.5,
	TipArea = -1,
	Path = -1.5
}
ChessGameEnum.SelectPosStatus = {
	CatchObj = 3,
	SelectObjWaitPos = 2,
	ShowTalk = 4,
	None = 1
}
ChessGameEnum.Direction = {
	Down = 2,
	Up = 8,
	Left = 4,
	Right = 6
}
ChessGameEnum.RollBack = {
	LastPoint = 1,
	CheckPoint = 0
}
ChessGameEnum.GameState = {
	Fail = 2,
	Win = 1
}
ChessGameEnum.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
ChessGameEnum.CloseAnimTime = 0.5
ChessGameEnum.TitleOpenAnimTime = 2.5

return ChessGameEnum
