-- chunkname: @modules/logic/versionactivity3_5/lorentz/controller/LorentzController.lua

module("modules.logic.versionactivity3_5.lorentz.controller.LorentzController", package.seeall)

local LorentzController = class("LorentzController", BaseController)

function LorentzController:onInit()
	return
end

function LorentzController:reInit()
	return
end

function LorentzController:onInitFinish()
	return
end

function LorentzController:addConstEvents()
	return
end

function LorentzController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function LorentzController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_5Enum.ActivityId.Lorentz then
		LorentzModel.instance:initInfos(msg.episodes)
	end
end

function LorentzController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_5Enum.ActivityId.Lorentz then
		LorentzModel.instance:updateInfos(msg.episodes)
	end
end

function LorentzController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_5Enum.ActivityId.Lorentz then
		LorentzModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function LorentzController:_onGameFinished(actId, episodeId)
	if not LorentzModel.instance:isEpisodePass(episodeId) then
		if LorentzModel.instance:checkEpisodeIsGame(episodeId) and not LorentzModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity220Rpc.instance:sendAct220SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = LorentzConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			LorentzModel.instance:setNewFinishEpisode(episodeId)
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

function LorentzController:_playStoryClear(episodeId)
	local isPass = LorentzModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_5Enum.ActivityId.Lorentz
	local storyClear = LorentzConfig.instance:getStoryClear(actId, episodeId)

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

function LorentzController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_5Enum.ActivityId.Lorentz

	if not actId or not episodeId then
		return
	end

	local config = LorentzConfig.instance:getEpisodeCo(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.LorentzGameView) then
		ViewMgr.instance:closeView(ViewName.LorentzGameView)
	end

	self:dispatchEvent(LorentzEvent.OnBackToLevel)
	self:dispatchEvent(LorentzEvent.EpisodeFinished)
end

function LorentzController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(VersionActivity3_5Enum.ActivityId.Lorentz, self._onRecInfo, self)
end

function LorentzController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_5Enum.ActivityId.Lorentz then
		LorentzModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.LorentzLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

LorentzController.instance = LorentzController.New()

return LorentzController
