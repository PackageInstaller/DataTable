-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/integral_drop/ActivityIntegralDropController.lua

module("logic.extensions.welfare.controller.integral_drop.ActivityIntegralDropController", package.seeall)

local M = class("ActivityIntegralDropController", BaseController)

function M:ctor()
	return
end

function M:getAllRewardList()
	return ActivityIntegralDropModel.instance:getAllRewardList()
end

function M:getCurStepIntegral()
	return ActivityIntegralDropModel.instance:getCurStepIntegral()
end

function M:getReceivingRewardStatus(order)
	return ActivityIntegralDropModel.instance:getReceivingRewardStatus(order)
end

function M:getActivityId()
	return ActivityIntegralDropModel.instance:getActivityId()
end

function M:getConfigId()
	return ActivityIntegralDropModel.instance:getConfigId()
end

function M:isHasCanReward()
	return ActivityIntegralDropModel.instance:isHasCanReward()
end

function M:isHasAllReward()
	return ActivityIntegralDropModel.instance:isHasAllReward()
end

function M:refreshRewardStatus(id, num)
	ActivityIntegralDropModel.instance:handlerBinary(id, num)
end

function M:handleIntegralDropRewardReply(msg)
	for k, v in ipairs(msg) do
		local data = ActivityController.instance:getActivityById(v.activity)

		if data then
			local configId = data:getConfigId()

			if configId == self:getConfigId() then
				self:refreshRewardStatus(v.activity, v.rewardBits)
			end
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_INTEGRAL_DROP_REFRESH)
end

function M:handleIntegralDropRewardReceivingReply(orderId)
	ActivityIntegralDropModel.instance:setReceivingReward(orderId, true)
	GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_INTEGRAL_DROP_REWARDREFRESH)
end

M.instance = M.New()

return M
