-- chunkname: @modules/logic/versionactivity3_8/dianjishi/controller/DianJiShiLevelController.lua

module("modules.logic.versionactivity3_8.dianjishi.controller.DianJiShiLevelController", package.seeall)

local DianJiShiLevelController = class("DianJiShiLevelController", BaseController)

function DianJiShiLevelController:onInit()
	return
end

function DianJiShiLevelController:reInit()
	return
end

function DianJiShiLevelController:onInitFinish()
	return
end

function DianJiShiLevelController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function DianJiShiLevelController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_8Enum.ActivityId.DianJiShi then
		DianJiShiModel.instance:initInfos(msg.episodes)
	end
end

function DianJiShiLevelController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_8Enum.ActivityId.DianJiShi then
		DianJiShiModel.instance:updateInfos(msg.episodes)
	end
end

function DianJiShiLevelController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_8Enum.ActivityId.DianJiShi then
		DianJiShiModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function DianJiShiLevelController:enterGame(episodeId)
	local actId = VersionActivity3_8Enum.ActivityId.DianJiShi
	local episodeInfo = Activity220Model.instance:getEpisodeInfo(actId, episodeId)
	local gameDataJson = episodeInfo and episodeInfo.progress
	local isStart = DianJiShiGameController.instance:startGame(actId, episodeId, gameDataJson)

	if isStart then
		self.gameEpisodeId = episodeId

		self:dispatchEvent(DianJiShiGameEvent.GuideOnEnterEpisode, episodeId)
	end
end

function DianJiShiLevelController:_afterPlayPass(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId

	DianJiShiModel.instance:setNewFinishEpisode(episodeId)
	self:dispatchEvent(DianJiShiGameEvent.OnBackToLevel)
	self:dispatchEvent(DianJiShiGameEvent.EpisodeFinished)
end

function DianJiShiLevelController:_onGameFinished(actId, episodeId)
	if not DianJiShiModel.instance:isEpisodePass(episodeId) then
		if DianJiShiModel.instance:checkEpisodeIsGame(episodeId) and not DianJiShiModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity220Rpc.instance:sendAct220SaveEpisodeProgressRequest(actId, episodeId)
		end

		local episodeCo = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
		local storyClear = episodeCo and episodeCo.storyClear

		function self._sendCallBack()
			DianJiShiModel.instance:setNewFinishEpisode(episodeId)
			self:_finishEpisode({
				episodeId = episodeId
			})
		end

		function self._afterFinishStory()
			Activity220Rpc.instance:sendAct220FinishEpisodeRequest(actId, episodeId, nil, self._sendCallBack, self)
		end

		if storyClear and storyClear ~= 0 then
			StoryController.instance:playStory(storyClear, nil, self._afterFinishStory, self, {
				episodeId = episodeId
			})
		else
			self:_afterFinishStory()
		end
	else
		self:_playStoryClear(episodeId)
	end
end

function DianJiShiLevelController:_playStoryClear(episodeId)
	local isPass = DianJiShiModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_8Enum.ActivityId.DianJiShi
	local episodeCo = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
	local storyClear = episodeCo and episodeCo.storyClear

	if storyClear and storyClear ~= 0 then
		StoryController.instance:playStory(storyClear, nil, self._finishEpisode, self, {
			episodeId = episodeId
		})
	else
		self:_finishEpisode({
			episodeId = episodeId
		})
	end
end

function DianJiShiLevelController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_8Enum.ActivityId.DianJiShi

	if not actId or not episodeId then
		return
	end

	local config = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.DianJiShiGameView) then
		ViewMgr.instance:closeView(ViewName.DianJiShiGameView)
	end

	self:dispatchEpisodeFinishEvent()
end

function DianJiShiLevelController:dispatchEpisodeFinishEvent()
	self:dispatchEvent(DianJiShiGameEvent.OnBackToLevel)
	self:dispatchEvent(DianJiShiGameEvent.EpisodeFinished)
end

function DianJiShiLevelController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(VersionActivity3_8Enum.ActivityId.DianJiShi, self._onRecInfo, self)
end

function DianJiShiLevelController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_8Enum.ActivityId.DianJiShi then
		DianJiShiModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.DianJiShiLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

DianJiShiLevelController.instance = DianJiShiLevelController.New()

return DianJiShiLevelController
