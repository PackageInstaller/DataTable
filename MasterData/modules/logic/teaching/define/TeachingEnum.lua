-- chunkname: @modules/logic/teaching/define/TeachingEnum.lua

module("modules.logic.teaching.define.TeachingEnum", package.seeall)

local TeachingEnum = _M

TeachingEnum.TeachingStatus = {
	Rewarded = 2,
	FinishNotReward = 1,
	NotFinish = 0
}

return TeachingEnum
