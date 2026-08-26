-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/LengZhou6Controller.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6Controller", package.seeall)

local LengZhou6Controller = class("LengZhou6Controller", BaseController)

function LengZhou6Controller:onInit()
	return
end

function LengZhou6Controller:onInitFinish()
	return
end

function LengZhou6Controller:addConstEvents()
	return
end

function LengZhou6Controller:reInit()
	self.showEpisodeId = nil
end

function LengZhou6Controller:enterLevelView(actId)
	LengZhou6Rpc.instance:sendGetAct190InfoRequest(actId)
end

function LengZhou6Controller:clickEpisode(episodeId)
	local actId = LengZhou6Model.instance:getAct190Id()
	local isOpen = LengZhou6Model.instance:isAct190Open(true)

	if not isOpen then
		return
	end

	local isUnlock = LengZhou6Model.instance:isUnlockEpisode(episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	self:dispatchEvent(LengZhou6Event.OnClickEpisode, actId, episodeId)
end

function LengZhou6Controller:enterEpisode(episodeId)
	LengZhou6Enum.enterGM = false

	local curActId = LengZhou6Model.instance:getCurActId()

	if not curActId or episodeId == nil then
		return
	end

	local config = LengZhou6Config.instance:getEpisodeConfig(curActId, episodeId)

	LengZhou6Model.instance:setCurEpisodeId(episodeId)

	local storyBeforeId = config.storyBefore

	if storyBeforeId ~= 0 then
		StoryController.instance:playStory(storyBeforeId, nil, self._enterGame, self)
	else
		self:_enterGame()
	end
end

function LengZhou6Controller:_enterGame()
	local activityId = LengZhou6Model.instance:getCurActId()
	local episodeId = LengZhou6Model.instance:getCurEpisodeId()
	local config = LengZhou6Config.instance:getEpisodeConfig(activityId, episodeId)
	local eliminateLevelId = config.eliminateLevelId

	if eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:enterLevel(activityId, episodeId)
	else
		self:finishLevel(episodeId)
		self:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	end
end

function LengZhou6Controller:restartGame()
	local activityId = LengZhou6Model.instance:getCurActId()
	local episodeId = LengZhou6Model.instance:getCurEpisodeId()
	local config = LengZhou6Config.instance:getEpisodeConfig(activityId, episodeId)
	local eliminateLevelId = config.eliminateLevelId

	if eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:restartLevel(activityId, episodeId)
	end
end

function LengZhou6Controller:openLengZhou6LevelView()
	self.showEpisodeId = nil

	ViewMgr.instance:openView(ViewName.LengZhou6LevelView)
end

function LengZhou6Controller:finishLevel(episodeId, progress)
	local mo = LengZhou6Model.instance:getEpisodeInfoMo(episodeId)

	if mo ~= nil then
		LengZhou6Rpc.instance:sendAct190FinishEpisodeRequest(episodeId, progress)
	end

	if mo ~= nil and progress ~= nil then
		mo:setProgress(progress)
	end
end

function LengZhou6Controller:onFinishEpisode(info)
	if not info then
		return
	end

	local actId = info.activityId
	local episodeId = info.episodeId

	self.showEpisodeId = episodeId

	LengZhou6Model.instance:onFinishActInfo(info)

	local curActId = LengZhou6Model.instance:getAct190Id()

	if actId == curActId then
		self:_playStoryClear(episodeId)
	end
end

function LengZhou6Controller:_playStoryClear(episodeId)
	local isFinished = LengZhou6Model.instance:isFinishedEpisode(episodeId)

	if not isFinished then
		return
	end

	local activityId = LengZhou6Model.instance:getCurActId()
	local curEpisodeId = LengZhou6Model.instance:getCurEpisodeId()

	if activityId == nil then
		return
	end

	local storyClearId = 0

	if curEpisodeId ~= nil then
		local config = LengZhou6Config.instance:getEpisodeConfig(activityId, curEpisodeId)

		storyClearId = config.storyClear
	end

	if storyClearId ~= 0 then
		StoryController.instance:playStory(storyClearId, nil, self.showFinishEffect, self)
	else
		self:showFinishEffect()
	end
end

function LengZhou6Controller:showFinishEffect()
	self:dispatchEvent(LengZhou6Event.OnFinishEpisode, self.showEpisodeId)

	self.showEpisodeId = nil
end

function LengZhou6Controller:openTaskView()
	LengZhou6TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity190
	}, self._realOpenTaskView, self)
end

function LengZhou6Controller:_realOpenTaskView(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LengZhou6TaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.LengZhou6TaskView)
end

function LengZhou6Controller:isNeedForceDrop()
	return GuideModel.instance:isGuideRunning(27201)
end

function LengZhou6Controller:getFixChessPos()
	local inGuide = GuideModel.instance:isGuideRunning(27202)

	if inGuide then
		return true, {
			x = 2,
			y = 2
		}
	end

	return false, nil
end

LengZhou6Controller.instance = LengZhou6Controller.New()

return LengZhou6Controller
