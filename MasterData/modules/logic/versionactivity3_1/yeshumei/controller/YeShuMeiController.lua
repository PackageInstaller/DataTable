-- chunkname: @modules/logic/versionactivity3_1/yeshumei/controller/YeShuMeiController.lua

module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiController", package.seeall)

local YeShuMeiController = class("YeShuMeiController", BaseController)

function YeShuMeiController:onInit()
	return
end

function YeShuMeiController:reInit()
	return
end

function YeShuMeiController:onInitFinish()
	return
end

function YeShuMeiController:addConstEvents()
	return
end

function YeShuMeiController:_onGameFinished(actId, episodeId)
	if not YeShuMeiModel.instance:isEpisodePass(episodeId) then
		if YeShuMeiModel.instance:checkEpisodeIsGame(episodeId) and not YeShuMeiModel.instance:checkEpisodeFinishGame(episodeId) then
			YeShuMeiRpc.instance:sendAct211SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = YeShuMeiConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			YeShuMeiModel.instance:setNewFinishEpisode(episodeId)
			self:_finishEpisode({
				episodeId = episodeId
			})
		end

		function self._afterFinishStory()
			YeShuMeiRpc.instance:sendGetAct211FinishEpisodeRequest(actId, episodeId, self._sendCallBack, self)
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

function YeShuMeiController:_playStoryClear(episodeId)
	local isPass = YeShuMeiModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	local storyClear = YeShuMeiConfig.instance:getStoryClear(actId, episodeId)

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

function YeShuMeiController:_finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = VersionActivity3_1Enum.ActivityId.YeShuMei

	if not actId or not episodeId then
		return
	end

	local config = YeShuMeiConfig.instance:getEpisodeCo(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if hasGame and ViewMgr.instance:isOpen(ViewName.YeShuMeiGameView) then
		YeShuMeiStatHelper.instance:sendGameFinish()
		ViewMgr.instance:closeView(ViewName.YeShuMeiGameView)
	end

	self:dispatchEvent(YeShuMeiEvent.OnBackToLevel)
	self:dispatchEvent(YeShuMeiEvent.EpisodeFinished)
end

function YeShuMeiController:enterLevelView(episodeId)
	self._openEpisodeId = episodeId

	YeShuMeiRpc.instance:sendGetAct211InfoRequest(VersionActivity3_1Enum.ActivityId.YeShuMei, self._onRecInfo, self)
end

function YeShuMeiController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_1Enum.ActivityId.YeShuMei then
		YeShuMeiModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.YeShuMeiLevelView, {
			episodeId = self._openEpisodeId
		})

		self._openEpisodeId = nil
	end
end

YeShuMeiController.instance = YeShuMeiController.New()

return YeShuMeiController
