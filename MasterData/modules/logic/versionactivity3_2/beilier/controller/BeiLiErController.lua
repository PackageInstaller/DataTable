-- chunkname: @modules/logic/versionactivity3_2/beilier/controller/BeiLiErController.lua

module("modules.logic.versionactivity3_2.beilier.controller.BeiLiErController", package.seeall)

local BeiLiErController = class("BeiLiErController", BaseController)

function BeiLiErController:onInit()
	return
end

function BeiLiErController:reInit()
	return
end

function BeiLiErController:onInitFinish()
	return
end

function BeiLiErController:addConstEvents()
	return
end

function BeiLiErController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function BeiLiErController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.BeiLiEr then
		BeiLiErModel.instance:initInfos(msg.episodes)
	end
end

function BeiLiErController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.BeiLiEr then
		BeiLiErModel.instance:updateInfos(msg.episodes)
	end
end

function BeiLiErController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_2Enum.ActivityId.BeiLiEr then
		BeiLiErModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function BeiLiErController:_onGameFinished(actId, episodeId)
	if not BeiLiErModel.instance:isEpisodePass(episodeId) then
		if BeiLiErModel.instance:checkEpisodeIsGame(episodeId) and not BeiLiErModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity220Rpc.instance:sendAct220SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = BeiLiErConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			BeiLiErModel.instance:setNewFinishEpisode(episodeId)
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

function BeiLiErController:_playStoryClear(episodeId)
	local isPass = BeiLiErModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_2Enum.ActivityId.BeiLiEr
	local storyClear = BeiLiErConfig.instance:getStoryClear(actId, episodeId)

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

function BeiLiErController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_2Enum.ActivityId.BeiLiEr

	if not actId or not episodeId then
		return
	end

	local config = BeiLiErConfig.instance:getEpisodeCo(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.BeiLiErGameView) then
		ViewMgr.instance:closeView(ViewName.BeiLiErGameView)
	end

	self:dispatchEvent(BeiLiErEvent.OnBackToLevel)
	self:dispatchEvent(BeiLiErEvent.EpisodeFinished)
end

function BeiLiErController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(VersionActivity3_2Enum.ActivityId.BeiLiEr, self._onRecInfo, self)
end

function BeiLiErController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_2Enum.ActivityId.BeiLiEr then
		BeiLiErModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.BeiLiErLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

function BeiLiErController:reInit()
	return
end

BeiLiErController.instance = BeiLiErController.New()

return BeiLiErController
