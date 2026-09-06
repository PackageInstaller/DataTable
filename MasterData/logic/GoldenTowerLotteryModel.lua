-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/model/GoldenTowerLotteryModel.lua

module("logic.extensions.goldentowerlottery.model.GoldenTowerLotteryModel", package.seeall)

local GoldenTowerLotteryModel = class("GoldenTowerLotteryModel", BaseModel)

function GoldenTowerLotteryModel:onInit()
	self:onReset()
end

function GoldenTowerLotteryModel:onReset()
	self._infos = {}
	self._gainTimesMap = {}
	self._poolInfoMap = {}
	self._changeSetList = {}
end

function GoldenTowerLotteryModel:getInfo(activityId)
	return self._infos[activityId]
end

function GoldenTowerLotteryModel:getPoolInfo(activityId, poolId)
	local poolsMap = self._poolInfoMap[activityId]

	if poolsMap then
		return poolsMap[poolId]
	end
end

function GoldenTowerLotteryModel:getPrizeGainTimesMap(activityId, poolId)
	return self._gainTimesMap[activityId] and self._gainTimesMap[activityId][poolId]
end

function GoldenTowerLotteryModel:getPrizeGainTimes(activityId, poolId, prizeId)
	local gainTimesMaps = self._gainTimesMap[activityId]

	if gainTimesMaps and gainTimesMaps[poolId] then
		local gainTimesMaps = gainTimesMaps[poolId]

		return gainTimesMaps and checknumber(gainTimesMaps[prizeId]) or 0
	end

	return 0
end

function GoldenTowerLotteryModel:pushChangeSetId(changeSetId)
	table.insert(self._changeSetList, changeSetId)
end

function GoldenTowerLotteryModel:popChangeSetId()
	if #self._changeSetList > 0 then
		return table.remove(self._changeSetList)
	end
end

function GoldenTowerLotteryModel:handlePM_GoldenTowerLotteryGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._gainTimesMap[msg.activityId] = {}
	self._poolInfoMap[msg.activityId] = {}

	local info = self._infos[msg.activityId]
	local gainTimesMaps = self._gainTimesMap[msg.activityId]
	local poolsMap = self._poolInfoMap[msg.activityId]

	info.poolList = info.poolList or {}

	for _, pool in ipairs(info.poolList) do
		gainTimesMaps[pool.poolId] = gainTimesMaps[pool.poolId] or {}

		local gainTimesMap = gainTimesMaps[pool.poolId]

		pool.prizeGainInfos = pool.prizeGainInfos or {}

		for i, info in ipairs(pool.prizeGainInfos) do
			gainTimesMap[info.prizeId] = info.gainTimes
		end

		poolsMap[pool.poolId] = pool
	end
end

function GoldenTowerLotteryModel:handlePM_GoldenTowerLotteryLotteryRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	if info then
		local poolList = info.poolList
		local hasThisPool = false

		for i = 1, #poolList do
			local poolInfo = poolList[i]

			if poolInfo.poolId == msg.pool.poolId then
				poolList[i] = msg.pool
				hasThisPool = true
			end
		end

		if not hasThisPool then
			table.insert(info.poolList, msg.pool)
		end

		local poolsMap = self._poolInfoMap[msg.activityId]

		poolsMap[msg.pool.poolId] = msg.pool
	end

	local gainTimesMaps = self._gainTimesMap[msg.activityId]

	if TableUtil.isTableEmpty(pb.pool.prizeGainInfos) then
		gainTimesMaps[msg.pool.poolId] = {}
	else
		gainTimesMaps[msg.pool.poolId] = gainTimesMaps[msg.pool.poolId] or {}

		local gainTimesMap = gainTimesMaps[msg.pool.poolId]

		gainTimesMap[msg.prizeId] = checknumber(gainTimesMap[msg.prizeId]) + 1
	end
end

GoldenTowerLotteryModel.instance = GoldenTowerLotteryModel.New()

return GoldenTowerLotteryModel
