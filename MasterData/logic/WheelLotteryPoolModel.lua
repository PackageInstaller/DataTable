-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/model/WheelLotteryPoolModel.lua

module("logic.extensions.wheellotterypool.model.WheelLotteryPoolModel", package.seeall)

local WheelLotteryPoolModel = class("WheelLotteryPoolModel", BaseModel)

function WheelLotteryPoolModel:ctor()
	return
end

function WheelLotteryPoolModel:onInit()
	self:onReset()
end

function WheelLotteryPoolModel:onReset()
	self._ModelPool = self._ModelPool or {}
end

function WheelLotteryPoolModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local curPool = {}

		curPool.lastPoolId = 1
		curPool.lastTier = 1
		curPool.lastPrizeId = 1
		curPool.lastChangeSetId = -1
		self._ModelPool[activityId] = curPool
	end

	return self._ModelPool[activityId]
end

function WheelLotteryPoolModel:handlePM_WheelLotteryGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	for index, v in pairs(msg.poolList) do
		local curPool = {}

		if curModel[v.poolId] == nil then
			self._ModelPool[v.poolId] = curPool
		end

		curPool.poolId = v.poolId
		curPool.curTier = v.curTier
		curPool.gainPrizeIds = v.gainPrizeIds
		curModel[v.poolId] = curPool
	end
end

function WheelLotteryPoolModel:handlePM_WheelLotteryLotteryRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)
	local poolId = msg.pool.poolId
	local gainPrizeIds = msg.pool.gainPrizeIds

	if poolId and msg.curTier and curModel[poolId] then
		curModel[poolId].poolId = poolId
		curModel[poolId].curTier = msg.pool.curTier
		curModel[poolId].gainPrizeIds = gainPrizeIds
	end

	curModel.lastPoolId = poolId
	curModel.lastTier = msg.curTier
	curModel.lastPrizeId = msg.prizeId
	curModel.lastChangeSetId = msg.changeSetId
end

function WheelLotteryPoolModel:canGetPrize(activityId, poolId, tierId)
	local curModel = self:GetModel(activityId)
	local lotteryPoolData = WheelLotteryPoolConfig.instance:getWheelLotteryPoolData(activityId)
	local tierPlanId = lotteryPoolData and lotteryPoolData[poolId].tierPlanId
	local tierPlanData = WheelLotteryPoolConfig.instance:getWheelLotteryTierPlanData(tierPlanId) or {}
	local tierNum = #tierPlanData
	local isInfinitePool = WheelLotteryPoolConfig.instance:isInfinitePool(activityId, poolId)

	if tierId <= tierNum then
		return tierId == curModel[poolId].curTier
	else
		return isInfinitePool
	end
end

function WheelLotteryPoolModel:isHasGain(activityId, poolId, tierId, prizeIndex)
	local curModel = self:GetModel(activityId)

	if curModel then
		if tierId < curModel[poolId].curTier then
			return true
		elseif tierId > curModel[poolId].curTier then
			return false
		else
			local tierLength = WheelLotteryPoolConfig.instance:getTierNum(activityId, poolId)

			if tierId <= tierLength then
				local gainPrizeIds = curModel[poolId].gainPrizeIds

				if not gainPrizeIds then
					return false
				end

				for i = 1, #gainPrizeIds do
					if gainPrizeIds[i] == prizeIndex or WheelLotteryPoolConfig.instance:isGainAllId(activityId, poolId, tierId, gainPrizeIds[i]) then
						return true
					end
				end
			else
				local isInfinitePool = WheelLotteryPoolConfig.instance:isInfinitePool(activityId, poolId)

				if isInfinitePool then
					local gainPrizeIds = curModel[poolId].gainPrizeIds

					if not gainPrizeIds then
						return false
					end

					for i = 1, #gainPrizeIds do
						if gainPrizeIds[i] == prizeIndex or WheelLotteryPoolConfig.instance:isGainAllId(activityId, poolId, tierLength, gainPrizeIds[i]) then
							return true
						end
					end
				else
					return true
				end
			end
		end
	end

	return false
end

function WheelLotteryPoolModel:getRecentTier(activityId, poolId)
	local curModel = self:GetModel(activityId)

	if curModel[poolId] then
		return curModel[poolId].curTier
	end

	return -1
end

function WheelLotteryPoolModel:getCurPrizeId(activityId, poolId)
	local curModel = self:GetModel(activityId)

	if curModel then
		return curModel.lastPrizeId
	end

	return -1
end

function WheelLotteryPoolModel:poolIsComplete(activityId, poolId)
	local curModel = self:GetModel(activityId)
	local lotteryPoolData = WheelLotteryPoolConfig.instance:getWheelLotteryPoolData(activityId)
	local tierPlanId = lotteryPoolData and lotteryPoolData[poolId].tierPlanId
	local tierPlanData = WheelLotteryPoolConfig.instance:getWheelLotteryTierPlanData(tierPlanId) or {}
	local tierNum = #tierPlanData

	if tierNum < curModel[poolId].curTier and not WheelLotteryPoolConfig.instance:isInfinitePool(activityId, poolId) then
		return true
	end

	return false
end

function WheelLotteryPoolModel:getRecentChangeSetId(activityId)
	local curModel = self:GetModel(activityId)

	if curModel then
		return curModel.lastChangeSetId
	end

	return -1
end

WheelLotteryPoolModel.instance = WheelLotteryPoolModel.New()

return WheelLotteryPoolModel
