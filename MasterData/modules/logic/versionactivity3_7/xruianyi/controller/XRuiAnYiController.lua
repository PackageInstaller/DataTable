-- chunkname: @modules/logic/versionactivity3_7/xruianyi/controller/XRuiAnYiController.lua

module("modules.logic.versionactivity3_7.xruianyi.controller.XRuiAnYiController", package.seeall)

local XRuiAnYiController = class("XRuiAnYiController", BaseController)

function XRuiAnYiController:onInit()
	return
end

function XRuiAnYiController:reInit()
	return
end

function XRuiAnYiController:onInitFinish()
	return
end

function XRuiAnYiController:addConstEvents()
	return
end

function XRuiAnYiController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function XRuiAnYiController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_7Enum.ActivityId.XRuiAnYi then
		XRuiAnYiModel.instance:initInfos(msg.episodes)
	end
end

function XRuiAnYiController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_7Enum.ActivityId.XRuiAnYi then
		XRuiAnYiModel.instance:updateInfos(msg.episodes)
	end
end

function XRuiAnYiController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_7Enum.ActivityId.XRuiAnYi then
		XRuiAnYiModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function XRuiAnYiController:enterGame(episodeId)
	local actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
	local cfg = XRuiAnYiConfig.instance:getEpisodeConfigById(actId, episodeId)
	local gameId = cfg.gameId
	local isStart = TravelGoController.instance:startGame(gameId, false)

	if isStart then
		if cfg.type == 1 then
			Activity220Rpc.instance:sendAct220FinishEpisodeRequest(actId, episodeId, nil, self._afterPlayPass, self)
		end

		self.gameEpisodeId = episodeId

		self:dispatchEvent(XRuiAnYiEvent.GuideOnEnterEpisode, episodeId)
	end
end

function XRuiAnYiController:_afterPlayPass(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId

	XRuiAnYiModel.instance:setNewFinishEpisode(episodeId)
	self:dispatchEvent(XRuiAnYiEvent.OnBackToLevel)
	self:dispatchEvent(XRuiAnYiEvent.EpisodeFinished)
end

function XRuiAnYiController:_onGameFinished(actId, episodeId)
	if not XRuiAnYiModel.instance:isEpisodePass(episodeId) then
		if XRuiAnYiModel.instance:checkEpisodeIsGame(episodeId) and not XRuiAnYiModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity220Rpc.instance:sendAct220SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = XRuiAnYiConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			XRuiAnYiModel.instance:setNewFinishEpisode(episodeId)
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

function XRuiAnYiController:_playStoryClear(episodeId)
	local isPass = XRuiAnYiModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
	local storyClear = XRuiAnYiConfig.instance:getStoryClear(actId, episodeId)

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

function XRuiAnYiController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi

	if not actId or not episodeId then
		return
	end

	local config = XRuiAnYiConfig.instance:getEpisodeCo(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.TravelGoView) then
		ViewMgr.instance:closeView(ViewName.TravelGoView)
	end

	self:dispatchEvent(XRuiAnYiEvent.OnBackToLevel)
	self:dispatchEvent(XRuiAnYiEvent.EpisodeFinished)
end

function XRuiAnYiController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(VersionActivity3_7Enum.ActivityId.XRuiAnYi, self._onRecInfo, self)
end

function XRuiAnYiController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_7Enum.ActivityId.XRuiAnYi then
		XRuiAnYiModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.XRuiAnYiLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

XRuiAnYiController.instance = XRuiAnYiController.New()

return XRuiAnYiController
