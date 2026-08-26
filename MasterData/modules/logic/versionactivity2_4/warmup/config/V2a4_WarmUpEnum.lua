-- chunkname: @modules/logic/versionactivity2_4/warmup/config/V2a4_WarmUpEnum.lua

module("modules.logic.versionactivity2_4.warmup.config.V2a4_WarmUpEnum", package.seeall)

local V2a4_WarmUpEnum = _M

V2a4_WarmUpEnum.DialogType = {
	ReplyAnsRight = 6,
	Preface = 0,
	AnsTrue = 9,
	AnsFalse = 10,
	ReplyAnsWrong = 5,
	Wait = 3
}
V2a4_WarmUpEnum.AskType = {
	Text = 1,
	Photo = 2
}
V2a4_WarmUpEnum.RoundState = {
	ReplyResult = 5,
	Ansed = 4,
	Ask = 2,
	WaitAns = 3,
	__End = 6,
	PreTalk = 1,
	None = 0
}

return V2a4_WarmUpEnum
