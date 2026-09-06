-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/controller/PlotmamoriesController.lua

module("logic.extensions.plotmemories.controller.PlotmamoriesController", package.seeall)

local PlotmamoriesController = class("PlotmamoriesController", BaseController)

PlotmamoriesController.PM_PlotReviewGainPrizeRes = "PlotmamoriesController.PM_PlotReviewGainPrizeRes"
PlotmamoriesController.PM_PlotReviewGetInfoRes = "PlotmamoriesController.PM_PlotReviewGetInfoRes"

function PlotmamoriesController:onReset()
	PlotmamoriesController.super.onReset(self)

	self._gainedPrizeIds = nil
end

function PlotmamoriesController:handlePM_PlotReviewGetInfoRes(msg)
	self._gainedPrizeIds = {}

	for i, v in pairs(msg.gainedPrizeIds) do
		self._gainedPrizeIds[v] = true
	end

	GlobalDispatcher:dispatch(PlotmamoriesController.PM_PlotReviewGetInfoRes)
end

function PlotmamoriesController:sendPM_PlotReviewGainPrizeReq(prizeId)
	self._sendGainId = prizeId

	PlotReviewAgent.instance:sendPM_PlotReviewGainPrizeReq(prizeId)
end

function PlotmamoriesController:handlePM_PlotReviewGainPrizeRes(msg)
	self._gainedPrizeIds[self._sendGainId] = true

	GlobalDispatcher:dispatch(PlotmamoriesController.PM_PlotReviewGainPrizeRes)
end

function PlotmamoriesController:setPrizeIdState(id, state)
	self._gainedPrizeIds[id] = state
end

function PlotmamoriesController:getGainedPrizeIds()
	return self._gainedPrizeIds
end

function PlotmamoriesController:getMainPlot()
	local chapters = PlotmemoriesConfig.instance:getChapter()
	local result = {}

	for i, chapter in ipairs(chapters[0]) do
		local sp = string.split(chapter.condition, "-")

		if TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2])) then
			table.insert(result, chapter)
		end
	end

	return result
end

function PlotmamoriesController:getActivityPlot()
	local chapters = PlotmemoriesConfig.instance:getChapter()
	local result = {}

	for i, chapter in ipairs(chapters[1]) do
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(chapter.activityType, chapter.activityId)
		local lock = endTime > ServerTime.now()

		if not lock then
			table.insert(result, chapter)
		end
	end

	table.sort(result, function(a, b)
		return a.chapterId < b.chapterId
	end)

	return result
end

function PlotmamoriesController:getNodeInfo(id)
	local chapterSon = PlotmemoriesConfig.instance:getChapterSonById(id)
	local result = {}

	for i, v in ipairs(chapterSon.nodeIds) do
		table.insert(result, PlotmemoriesConfig.instance:getNodeById(v))
	end

	return result
end

PlotmamoriesController.instance = PlotmamoriesController.New()

return PlotmamoriesController
