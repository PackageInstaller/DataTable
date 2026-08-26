-- chunkname: @modules/logic/versionactivity3_4/lusijian/controller/LuSiJianController.lua

module("modules.logic.versionactivity3_4.lusijian.controller.LuSiJianController", package.seeall)

local LuSiJianController = class("LuSiJianController", BaseController)

function LuSiJianController:onInit()
	return
end

function LuSiJianController:reInit()
	return
end

function LuSiJianController:onInitFinish()
	return
end

function LuSiJianController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.getAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.getAct220EpisodePush, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.FinishEpisodeReply, self)
end

function LuSiJianController:getAct220InfoReply(msg)
	if msg.activityId == VersionActivity3_4Enum.ActivityId.LuSiJian then
		LuSiJianModel.instance:initInfos(msg.episodes)
	end
end

function LuSiJianController:getAct220EpisodePush(msg)
	if msg.activityId == VersionActivity3_4Enum.ActivityId.LuSiJian then
		LuSiJianModel.instance:updateInfos(msg.episodes)
	end
end

function LuSiJianController:FinishEpisodeReply(msg)
	if msg.activityId == VersionActivity3_4Enum.ActivityId.LuSiJian then
		LuSiJianModel.instance:updateInfoFinish(msg.episodeId)
	end
end

function LuSiJianController:_onGameFinished(actId, episodeId)
	if not LuSiJianModel.instance:isEpisodePass(episodeId) then
		if LuSiJianModel.instance:checkEpisodeIsGame(episodeId) and not LuSiJianModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity220Rpc.instance:sendAct220SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = LuSiJianConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			LuSiJianModel.instance:setNewFinishEpisode(episodeId)
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

function LuSiJianController:_playStoryClear(episodeId)
	local isPass = LuSiJianModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_4Enum.ActivityId.LuSiJian
	local storyClear = LuSiJianConfig.instance:getStoryClear(actId, episodeId)

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

function LuSiJianController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_4Enum.ActivityId.LuSiJian

	if not actId or not episodeId then
		return
	end

	self:dispatchEvent(LuSiJianEvent.OnBackToLevel)
	self:dispatchEvent(LuSiJianEvent.EpisodeFinished)
end

function LuSiJianController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	Activity220Rpc.instance:sendGetAct220InfoRequest(VersionActivity3_4Enum.ActivityId.LuSiJian, self._onRecInfo, self)
end

function LuSiJianController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_4Enum.ActivityId.LuSiJian then
		LuSiJianModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.LuSiJianLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

LuSiJianController.instance = LuSiJianController.New()

return LuSiJianController
