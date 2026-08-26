-- chunkname: @modules/logic/battlepass/config/BpEnum.lua

module("modules.logic.battlepass.config.BpEnum", package.seeall)

local BpEnum = _M

BpEnum.PayStatus = {
	Pay1 = 1,
	Pay2 = 2,
	NotPay = 0
}
BpEnum.ScoreItemId = 970001
BpEnum.LevelUpMinTime = 2
BpEnum.LevelUpTotalTime = 5
BpEnum.TaskGetAnimTime = 0.43
BpEnum.TaskMaskTime = 0.6
BpEnum.BonusTweenMin = 5
BpEnum.BonusTweenTime = 3.5
BpEnum.AddScoreTime = 1
BpEnum.ButtonName = {
	Goto = "前往解锁",
	Close = "关闭",
	CloseBg = "空白处关闭"
}
BpEnum.StoreSkinOnlineState = {
	Online = 1
}

return BpEnum
