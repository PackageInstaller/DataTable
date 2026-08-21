-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/integral_drop/ActivityIntegralDropMo.lua

module("logic.extensions.welfare.model.integral_drop.ActivityIntegralDropMo", package.seeall)

local M = class("ActivityIntegralDropMo")

function M:ctor()
	self._isReceiving = nil
	self._orderId = nil
	self._rewardId = nil
	self._rewardCondition = nil
end

function M:upDataRewardInfo(info)
	self._isReceiving = info.isReceiving
	self._orderId = info.orderId
	self._rewardId = info.rewardId
	self._score = info.score
	self._preStepIntegral = info.preStepIntegral
end

return M
