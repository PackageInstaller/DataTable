-- chunkname: @modules/logic/versionactivity1_5/peaceulu/define/PeaceUluEnum.lua

module("modules.logic.versionactivity1_5.peaceulu.define.PeaceUluEnum", package.seeall)

local PeaceUluEnum = _M

PeaceUluEnum.TabIndex = {
	Game = 2,
	Result = 3,
	Main = 1
}
PeaceUluEnum.Game = {
	Rock = 2,
	Scissors = 1,
	Paper = 3
}
PeaceUluEnum.GameResult = {
	Fail = 2,
	Draw = 0,
	Win = 1
}
PeaceUluEnum.RoleID = {
	Idle = 307601,
	Happy = 307602
}
PeaceUluEnum.VoiceType = {
	GetReward = 6,
	FinishAllTask = 8,
	Fail = 2,
	FirstEnterView = 7,
	CanRemoveButFinish = 5,
	RemoveTask = 3,
	Win = 4
}
PeaceUluEnum.TaskGetAnimTime = 0.5
PeaceUluEnum.TaskMaskTime = 0.67

return PeaceUluEnum
