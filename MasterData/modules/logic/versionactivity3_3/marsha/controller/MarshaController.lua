-- chunkname: @modules/logic/versionactivity3_3/marsha/controller/MarshaController.lua

module("modules.logic.versionactivity3_3.marsha.controller.MarshaController", package.seeall)

local MarshaController = class("MarshaController", BaseController)

function MarshaController:onInit()
	self.actId = VersionActivity3_3Enum.ActivityId.Marsha
end

function MarshaController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function MarshaController:getAct220InfoReply(msg)
	if msg.activityId == self.actId then
		MarshaModel.instance:initInfos(msg.episodes)
	end
end

function MarshaController:getAct220EpisodePush(msg)
	if msg.activityId == self.actId then
		MarshaModel.instance:updateInfos(msg.episodes)
	end
end

function MarshaController:FinishEpisodeReply(msg)
	if msg.activityId == self.actId then
		MarshaModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function MarshaController:onGameFinish()
	local actId = MarshaModel.instance:getCurActId()
	local episodeId = MarshaModel.instance:getCurEpisode()

	if MarshaModel.instance:isEpisodePass(episodeId) then
		self:_playStoryClear(episodeId)
	else
		local episodeCo = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
		local storyClear = episodeCo and episodeCo.storyClear

		function self._sendCallBack()
			MarshaModel.instance:setNewFinishEpisode(episodeId)
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
	end
end

function MarshaController:_playStoryClear(episodeId)
	local isPass = MarshaModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local episodeCo = Activity220Config.instance:getEpisodeConfig(self.actId, episodeId)
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

function MarshaController:_finishEpisode(param)
	local episodeId = param and param.episodeId

	if not self.actId or not episodeId then
		return
	end

	local config = Activity220Config.instance:getEpisodeConfig(self.actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.MarshaGameView) then
		ViewMgr.instance:closeView(ViewName.MarshaGameView)
	end

	self:dispatchEvent(MarshaEvent.EpisodeFinished)
end

function MarshaController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(self.actId, self._onRecInfo, self)
end

function MarshaController:_onRecInfo(_, resultCode, msg)
	if resultCode == 0 and msg.activityId == self.actId then
		MarshaModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.MarshaLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

function MarshaController:openGameView(mapId)
	ViewMgr.instance:openView(ViewName.MarshaGameView, mapId)
end

MarshaController.instance = MarshaController.New()

return MarshaController
