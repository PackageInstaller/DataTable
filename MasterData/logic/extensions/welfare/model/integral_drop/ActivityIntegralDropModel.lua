-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/integral_drop/ActivityIntegralDropModel.lua

module("logic.extensions.welfare.model.integral_drop.ActivityIntegralDropModel", package.seeall)

local M = class("ActivityIntegralDropModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._stepRewardList = {}
	self._id = nil

	local planIds = WelfareConfig.instance:getCfgPlanId("ActivityIntegralDropView")

	self._cfgId = planIds and planIds[1]

	self:InitRewardList()
end

function M:InitRewardList()
	local cfgList = ActivityIntegralDropConfig.instance:getAllInfoById(self._cfgId)

	if not cfgList then
		return
	end

	for i = 1, #cfgList do
		local info = {}

		info.isReceiving = false
		info.orderId = cfgList[i].order
		info.rewardId = cfgList[i].reward
		info.score = cfgList[i].score

		if info.orderId > 1 then
			info.preStepIntegral = self._stepRewardList[cfgList[i].order - 1]._score
		else
			info.preStepIntegral = 0
		end

		local tempMo = ActivityIntegralDropMo.New()

		tempMo:upDataRewardInfo(info)

		self._stepRewardList[cfgList[i].order] = tempMo
	end
end

function M:setActivityId(activityId)
	self._id = activityId
end

function M:getActivityId()
	return self._id
end

function M:setConfigId(cfgId)
	self._cfgId = cfgId
end

function M:getConfigId()
	return self._cfgId
end

function M:setReceivingReward(order, isRece)
	self._stepRewardList[order]._isReceiving = isRece
end

function M:getReceivingReward(order)
	return self._stepRewardList[order]._isReceiving
end

function M:handlerBinary(id, num)
	self:setActivityId(id)

	local length = #self._stepRewardList

	for i = 1, length do
		if i == 1 then
			if num % 2 == 1 then
				self:setReceivingReward(i, true)
			end
		elseif num % 2^i >= 2^(i - 1) then
			self:setReceivingReward(i, true)
		end
	end
end

function M:getReceivingRewardStatus(order)
	local rewardStatus = CommEnum.RewardEnum.CanNotGot

	if self:getReceivingReward(order) then
		rewardStatus = CommEnum.RewardEnum.HasGot
	elseif self:getCurStepIntegral() >= self._stepRewardList[order]._score then
		rewardStatus = CommEnum.RewardEnum.CanGot
	end

	return rewardStatus
end

function M:getCurStepIntegral()
	local coinId = ActivityIntegralDropConfig.instance:getRewardCoinId(self:getConfigId())
	local curNum = ItemModel.instance:getItemCountByItemId(coinId)

	return curNum
end

function M:getAllRewardList()
	return self._stepRewardList
end

function M:getAllIntegralDropInActMo()
	local activityId

	if not WelfareUtil.isSystemOpen() then
		return activityId
	end

	activityId = self:getActivityId()

	return activityId
end

function M:isHasAllReward()
	for k, v in ipairs(self._stepRewardList) do
		if v._isReceiving == false then
			return false
		end
	end

	return true
end

function M:isHasCanReward()
	local length = #self._stepRewardList

	for i = 1, length do
		local status = self:getReceivingRewardStatus(i)

		if status == CommEnum.RewardEnum.CanNotGot then
			return false
		end
	end

	return false
end

M.instance = M.New()

return M
