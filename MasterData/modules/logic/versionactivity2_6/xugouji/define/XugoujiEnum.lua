-- chunkname: @modules/logic/versionactivity2_6/xugouji/define/XugoujiEnum.lua

module("modules.logic.versionactivity2_6.xugouji.define.XugoujiEnum", package.seeall)

local XugoujiEnum = _M

XugoujiEnum.LevelType = {
	Level = 2,
	Story = 1
}
XugoujiEnum.ResultEnum = {
	Completed = 1,
	PowerUseup = 2,
	Quit = 3
}
XugoujiEnum.GameViewState = {
	PlayerOperating = 1,
	PlayerOperaEnd = 3,
	PlayerOperaDisplay = 2,
	EnemyOperating = 4,
	GameEnd = 7,
	EnemyOperaDisplay = 5,
	EnemyOperaEnd = 6
}
XugoujiEnum.DefaultOperateTime = 2
XugoujiEnum.ResultType = {
	TimeOut = 3,
	Lose = 2,
	Win = 1
}
XugoujiEnum.resultStatUse = {
	"成功",
	"失败",
	"回合耗尽"
}
XugoujiEnum.GameStepType = {
	UpdateInitialCard = 102,
	UpdateCardEffectStatus = 9,
	WaitGameStart = 101,
	HpUpdate = 2,
	GameReStart = 103,
	OperateNumUpdate = 7,
	NewCards = 4,
	BuffUpdate = 8,
	Result = 3,
	UpdateCardStatus = 1,
	ChangeTurn = 5,
	GotCardPair = 6
}
XugoujiEnum.GameStatus = {
	UnOperatable = 2,
	Operatable = 1
}
XugoujiEnum.CardType = {
	Immediate = 2,
	Attack = 0,
	Func = 1
}
XugoujiEnum.CardStatus = {
	Disappear = 3,
	Back = 1,
	Front = 2
}
XugoujiEnum.CardEffectStatus = {
	PerspectiveEnemy = 2,
	Perspective = 1,
	Lock = 3,
	LockEnemy = 4
}
XugoujiEnum.BuffType = {
	Round = 2,
	Layer = 1,
	None = 0
}
XugoujiEnum.FirstEpisodeId = 20002
XugoujiEnum.ChallengeEpisodeId = 20013
XugoujiEnum.TaskMOAllFinishId = -100

return XugoujiEnum
