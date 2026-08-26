-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/Activity201MaLiAnNaController.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.Activity201MaLiAnNaController", package.seeall)

local Activity201MaLiAnNaController = class("Activity201MaLiAnNaController", BaseController)

function Activity201MaLiAnNaController:onInit()
	self._isPlayBurn = false
end

function Activity201MaLiAnNaController:onInitFinish()
	return
end

function Activity201MaLiAnNaController:addConstEvents()
	return
end

function Activity201MaLiAnNaController:reInit()
	self:onInit()
end

function Activity201MaLiAnNaController:_onGameFinished(actId, episodeId)
	if not Activity201MaLiAnNaModel.instance:isEpisodePass(episodeId) then
		if Activity201MaLiAnNaModel.instance:checkEpisodeIsGame(episodeId) and not Activity201MaLiAnNaModel.instance:checkEpisodeFinishGame(episodeId) then
			Activity203Rpc.instance:sendAct203SaveEpisodeProgressRequest(actId, episodeId)
		end

		local storyClear = Activity201MaLiAnNaConfig.instance:getStoryClear(actId, episodeId)

		function self._sendCallBack()
			Activity201MaLiAnNaModel.instance:setNewFinishEpisode(episodeId)
			self:openResultView({
				isWin = true,
				episodeId = episodeId
			})
		end

		function self._afterFinishStory()
			Activity203Rpc.instance:sendGetAct203FinishEpisodeRequest(actId, episodeId, self._sendCallBack, self)
		end

		if storyClear and storyClear ~= 0 then
			Activity201MaLiAnNaController.instance:stopBurnAudio()
			StoryController.instance:playStory(storyClear, nil, self._afterFinishStory, self, {
				isWin = true,
				episodeId = episodeId
			})
		else
			self:_afterFinishStory()
		end
	else
		self:_playStoryClear(episodeId)
	end
end

function Activity201MaLiAnNaController:onFinishEpisode(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId

	Activity201MaLiAnNaModel.instance:setNewFinishEpisode(episodeId)
	self:_playStoryClear(episodeId)
end

function Activity201MaLiAnNaController:_playStoryClear(episodeId)
	local isPass = Activity201MaLiAnNaModel.instance:isEpisodePass(episodeId)

	if not isPass then
		return
	end

	local actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local storyClear = Activity201MaLiAnNaConfig.instance:getStoryClear(actId, episodeId)

	if storyClear and storyClear ~= 0 then
		Activity201MaLiAnNaController.instance:stopBurnAudio()
		StoryController.instance:playStory(storyClear, nil, self.openResultView, self, {
			isWin = true,
			episodeId = episodeId
		})
	else
		self:openResultView({
			isWin = true,
			episodeId = episodeId
		})
	end
end

function Activity201MaLiAnNaController:openResultView(param)
	Activity201MaLiAnNaController.instance:startBurnAudio()

	local actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local episodeId = param and param.episodeId

	if not actId or not episodeId then
		return
	end

	local config = Activity201MaLiAnNaConfig.instance:getEpisodeCo(actId, episodeId)
	local hasGame = config.gameId ~= 0

	if not hasGame then
		self:dispatchEvent(Activity201MaLiAnNaEvent.OnBackToLevel)
		self:dispatchEvent(Activity201MaLiAnNaEvent.EpisodeFinished)

		return
	end

	ViewMgr.instance:openView(ViewName.MaLiAnNaResultView, {
		episodeId = episodeId,
		isWin = param.isWin
	})
end

function Activity201MaLiAnNaController:enterLevelView()
	Activity203Rpc.instance:sendGetAct203InfoRequest(VersionActivity3_0Enum.ActivityId.MaLiAnNa, self._onRecInfo, self)
end

function Activity201MaLiAnNaController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity3_0Enum.ActivityId.MaLiAnNa then
		Activity201MaLiAnNaModel.instance:initInfos(msg.episodes)
		ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaGameMainView)
		ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaLevelView)
	end
end

function Activity201MaLiAnNaController:startBurnAudio()
	if self._isPlayBurn then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_burn_loop)

	self._isPlayBurn = true
end

function Activity201MaLiAnNaController:stopBurnAudio()
	if self._isPlayBurn then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_burn_loop)

		self._isPlayBurn = false
	end
end

Activity201MaLiAnNaController.instance = Activity201MaLiAnNaController.New()

return Activity201MaLiAnNaController
