-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/controller/FuYaoStoryController.lua

module("logic.extensions.fuyaostory.controller.FuYaoStoryController", package.seeall)

local FuYaoStoryController = class("FuYaoStoryController", BaseController)

function FuYaoStoryController:onInit()
	return
end

function FuYaoStoryController:onReset()
	return
end

function FuYaoStoryController:getBasePlanId()
	local basePlanId = 0
	local dataList = FuYaoStoryConfig.instance:getBaseDataList() or {}

	for _, data in ipairs(dataList) do
		if self:isInTimeOfPlan(data.basePlanId) then
			basePlanId = data.basePlanId

			break
		end
	end

	return basePlanId
end

function FuYaoStoryController:isInTimeOfPlan(basePlanId)
	local data = FuYaoStoryConfig.instance:getBaseData(basePlanId)

	return (data or nil) and GameUtil.getTimePeriod(data.startTime, data.endTime) == GameUtil.inTimePeriod
end

function FuYaoStoryController:getTimePeriodInStep(basePlanId, stepId)
	local data = FuYaoStoryConfig.instance:getEnterData(basePlanId, stepId)

	return (data or nil) and GameUtil.getTimePeriod(data.startTime, data.endTime)
end

function FuYaoStoryController:savePlotWatchRecord(plotId)
	local basePlanId = self:getBasePlanId()
	local data = FuYaoStoryConfig.instance:getStoryData(basePlanId, plotId)
	local stepId = data.stepId
	local cfg = FuYaoStoryConfig.instance:getStoryCfgByStep(basePlanId, stepId)

	for _, v in ipairs(cfg) do
		if plotId >= v.plotId then
			self:_savePlotWatchRecord(basePlanId, v.plotId)
		end
	end
end

function FuYaoStoryController:_savePlotWatchRecord(basePlanId, plotId)
	local key = string.format("fuyao_story_watch_plot_%d_%d", basePlanId, plotId)

	GameUtil.saveUserData(key, 1)
end

function FuYaoStoryController:isHasWatchPlot(basePlanId, plotId)
	local key = string.format("fuyao_story_watch_plot_%d_%d", basePlanId, plotId)
	local value = GameUtil.getUserData(key)

	return checknumber(value) == 1
end

function FuYaoStoryController:getParamsInPlot(plotId)
	local params
	local basePlanId = self:getBasePlanId()

	if self:isInTimeOfPlan(basePlanId) then
		local data = FuYaoStoryConfig.instance:getStoryData(basePlanId, plotId)

		params = data and data.params
	end

	return params
end

function FuYaoStoryController:tryPlayPlotOnce(plotId, finishCallBack)
	local basePlanId = self:getBasePlanId()

	if not self:isInTimeOfPlan(basePlanId) or self:isHasWatchPlot(basePlanId, plotId) then
		GameUtil.callBack(finishCallBack)

		return
	end

	local storyId = FuYaoStoryConfig.instance:getStoryId(basePlanId, plotId)

	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._handleEndStory, self)

	self._playingStoryParams = {
		basePlanId = basePlanId,
		plotId = plotId,
		storyId = storyId,
		finishCallBack = finishCallBack
	}

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function FuYaoStoryController:playPlot(basePlanId, plotId)
	local storyId = FuYaoStoryConfig.instance:getStoryId(basePlanId, plotId)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function FuYaoStoryController:_handleEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	if storyId ~= self._playingStoryParams.storyId then
		return
	end

	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._handleEndStory, self)
	self:savePlotWatchRecord(self._playingStoryParams.plotId)
	GameUtil.callBack(self._playingStoryParams.finishCallBack)

	self._playingStoryParams = nil
end

FuYaoStoryController.instance = FuYaoStoryController.New()

return FuYaoStoryController
