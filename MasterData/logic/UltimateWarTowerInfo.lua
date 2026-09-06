-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/data/UltimateWarTowerInfo.lua

module("logic.extensions.ultimatewar.data.UltimateWarTowerInfo", package.seeall)

local UltimateWarTowerInfo = class("UltimateWarTowerInfo")

function UltimateWarTowerInfo:ctor(activityId, towerId)
	self._activityId = activityId
	self._towerId = towerId
	self._record = UltimateWarRecord.New()
	self._maxStageCount = UltimateWarConfig.instance:getMaxStageCount(self._activityId, self._towerId)

	self:onReset()
end

function UltimateWarTowerInfo:onReset()
	self._maxPassStageId = 0
	self._gainPrizeIds = {}
end

function UltimateWarTowerInfo:updateData(value)
	self._maxPassStageId = value.maxPassStageId

	if value:HasField("record") then
		self._record:updateData(value.record)
	else
		self._record:onReset()
	end

	table.insertto(self._gainPrizeIds, value.gainPrizeIds)
end

function UltimateWarTowerInfo:getTowerId()
	return self._towerId
end

function UltimateWarTowerInfo:getMaxPassStageId()
	return self._maxPassStageId
end

function UltimateWarTowerInfo:getMaxStageCount()
	return self._maxStageCount
end

function UltimateWarTowerInfo:isPassStage(stageId)
	return stageId <= self._maxPassStageId
end

function UltimateWarTowerInfo:isPassTower()
	return self._maxPassStageId >= self._maxStageCount
end

function UltimateWarTowerInfo:getRecord()
	return self._record
end

function UltimateWarTowerInfo:isCanGetPrizeInTower()
	local result = false
	local cfg = UltimateWarConfig.instance:getStageCfg(self._activityId, self._towerId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrize(data.stageId) then
				result = true

				break
			end
		end
	end

	return result
end

function UltimateWarTowerInfo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughPrize(prizeId)
end

function UltimateWarTowerInfo:isHasGainPrize(prizeId)
	return table.indexof(self._gainPrizeIds, prizeId) ~= false
end

function UltimateWarTowerInfo:isEnoughPrize(prizeId)
	return prizeId <= self._maxPassStageId
end

function UltimateWarTowerInfo:addPrizeId(prizeId)
	if not self:isHasGainPrize(prizeId) then
		table.insert(self._gainPrizeIds, prizeId)
	end
end

return UltimateWarTowerInfo
