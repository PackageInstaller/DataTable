-- chunkname: @modules/logic/summonsimulationpick/model/SummonSimulationPickModel.lua

module("modules.logic.summonsimulationpick.model.SummonSimulationPickModel", package.seeall)

local SummonSimulationPickModel = class("SummonSimulationPickModel", BaseModel)

function SummonSimulationPickModel:onInit()
	self._actInfo = {}
end

function SummonSimulationPickModel:reInit()
	self._actInfo = {}
end

function SummonSimulationPickModel:setActInfo(activityId, info)
	local currentInfo = self._actInfo[activityId]

	currentInfo = currentInfo or SummonSimulationInfoMo.New()

	currentInfo:update(info)

	self._actInfo[activityId] = currentInfo
end

function SummonSimulationPickModel:getActInfo(activityId)
	return self._actInfo[activityId]
end

function SummonSimulationPickModel:isActivityOpen(activityId)
	local nowTime = ServerTime.now() * TimeUtil.OneSecondMilliSecond

	if not activityId or not ActivityModel.instance:isActOnLine(activityId) then
		return false
	end

	local startTime = ActivityModel.instance:getActStartTime(activityId)

	if nowTime < startTime then
		return false
	end

	local endTime = ActivityModel.instance:getActEndTime(activityId)

	if endTime <= nowTime then
		return false
	end

	return true
end

function SummonSimulationPickModel:getActivityMaxSummonCount(activityId)
	local config = SummonSimulationPickConfig.instance:getSummonConfigById(activityId)

	if config and config.summonTimes then
		return config.summonTimes
	end

	return 0
end

function SummonSimulationPickModel:setCurSelectIndex(selectIndex)
	self._selectIndex = selectIndex
end

function SummonSimulationPickModel:getCurSelectIndex()
	return self._selectIndex
end

SummonSimulationPickModel.instance = SummonSimulationPickModel.New()

return SummonSimulationPickModel
