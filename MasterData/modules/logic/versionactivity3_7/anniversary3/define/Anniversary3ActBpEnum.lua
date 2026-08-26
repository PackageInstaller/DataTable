-- chunkname: @modules/logic/versionactivity3_7/anniversary3/define/Anniversary3ActBpEnum.lua

module("modules.logic.versionactivity3_7.anniversary3.define.Anniversary3ActBpEnum", package.seeall)

local Anniversary3ActBpEnum = _M

Anniversary3ActBpEnum.ScoreItemId = 970100
Anniversary3ActBpEnum.CateType = {
	Bonus = 1,
	Task = 2
}
Anniversary3ActBpEnum.TaskType = {
	Activity = 3,
	Daily = 1,
	Weekly = 2
}
Anniversary3ActBpEnum.PayStatus = {
	Payed = 1,
	NotPay = 0
}

return Anniversary3ActBpEnum
