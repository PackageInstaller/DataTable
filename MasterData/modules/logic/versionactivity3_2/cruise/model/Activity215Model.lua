-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity215Model.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity215Model", package.seeall)

local Activity215Model = class("Activity215Model", BaseModel)

function Activity215Model:onInit()
	self:reInit()
end

function Activity215Model:reInit()
	self._act215Info = {}
end

function Activity215Model:setAct215Info(info, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	self._act215Info[actId] = self._act215Info[actId] or Activity215InfoMO.New()

	self._act215Info[actId]:init(info)
end

function Activity215Model:getAct215Info(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._act215Info[actId]
end

function Activity215Model:updateCurrentMainStage(stage, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return
	end

	self._act215Info[actId]:updateCurrentMainStage(stage)
end

function Activity215Model:getCurrentMainStage(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return 1
	end

	return self._act215Info[actId].currentMainStage
end

function Activity215Model:updateItemSubmitCount(count, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return
	end

	self._act215Info[actId]:updateItemSubmitCount(count)
end

function Activity215Model:getItemSubmitCount(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return 0
	end

	return self._act215Info[actId].itemSubmitCount
end

function Activity215Model:updateAcceptedRewardId(id, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return
	end

	self._act215Info[actId]:updateAcceptedRewardId(id)
end

function Activity215Model:getAcceptedRewardId(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	if not self._act215Info[actId] then
		return 0
	end

	return self._act215Info[actId].acceptedRewardId
end

function Activity215Model:getMaxCanGetRewardId(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	local itemCos = Activity215Config.instance:getConstCO(1)
	local itemCount = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])
	local total = self:getItemSubmitCount(actId) + itemCount
	local bonusCos = Activity215Config.instance:getMileStoneBonusCos(actId)

	for index, bonusCo in ipairs(bonusCos) do
		if total < bonusCo.coinNum then
			return index - 1
		end
	end

	return #bonusCos
end

function Activity215Model:getMaxRewardId(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	local rewardId = 0
	local bonusCos = Activity215Config.instance:getMileStoneBonusCos(actId)

	for _, bonusCo in ipairs(bonusCos) do
		rewardId = rewardId < bonusCo.rewardId and bonusCo.rewardId or rewardId
	end

	return rewardId
end

function Activity215Model:isActHasRewardCouldGet(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	local taskCos = Activity215Config.instance:getStageCos(actId)

	for _, taskCo in ipairs(taskCos) do
		local taskMO = TaskModel.instance:getTaskById(taskCo.id)

		if taskMO and taskMO.finishCount < 1 and taskMO.hasFinished then
			return true
		end
	end

	local curRewardId = self:getAcceptedRewardId()
	local maxRewardId = self:getMaxCanGetRewardId()

	if curRewardId < maxRewardId then
		return true
	end

	return false
end

Activity215Model.instance = Activity215Model.New()

return Activity215Model
