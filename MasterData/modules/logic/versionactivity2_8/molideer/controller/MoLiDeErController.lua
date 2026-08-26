-- chunkname: @modules/logic/versionactivity2_8/molideer/controller/MoLiDeErController.lua

module("modules.logic.versionactivity2_8.molideer.controller.MoLiDeErController", package.seeall)

local MoLiDeErController = class("MoLiDeErController", BaseController)

function MoLiDeErController:onInit()
	return
end

function MoLiDeErController:onInitFinish()
	return
end

function MoLiDeErController:addConstEvents()
	return
end

function MoLiDeErController:reInit()
	return
end

function MoLiDeErController:enterEpisode(actId, episodeId)
	local episodeConfig = MoLiDeErConfig.instance:getEpisodeConfig(actId, episodeId)

	if episodeConfig == nil then
		logError("莫莉德尔活动 关卡不存在 actId:" .. actId .. "关卡id" .. episodeId)

		return
	end

	MoLiDeErModel.instance:setCurEpisodeData(actId, episodeId, episodeConfig)

	local haveProgress = MoLiDeErModel.instance:haveEpisodeProgress(actId, episodeId)

	if self:_checkStory(episodeConfig.beforeStory) and not haveProgress then
		self._playStory(self, episodeConfig.beforeStory, self.beforeStoryFinish, self)
	else
		self:beforeStoryFinish()
	end
end

function MoLiDeErController:enterLevelView(actId, episodeId)
	self._openEpisodeId = episodeId

	MoLiDeErRpc.instance:sendAct194GetInfosRequest(actId, self.onReceiveInfo, self)
end

function MoLiDeErController:onReceiveInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.MoLiDeErLevelView, {
			episodeId = self._openEpisodeId
		})
	end

	self._openEpisodeId = nil
end

function MoLiDeErController:onReceiveEpisodeInfo(activityId, episodeRecords)
	MoLiDeErModel.instance:onEpisodeRecordsPush(activityId, episodeRecords)
end

function MoLiDeErController:beforeStoryFinish()
	local episodeConfig = MoLiDeErModel.instance:getCurEpisode()

	if not episodeConfig then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	if self:_checkGame(episodeConfig.gameId) then
		local actId = MoLiDeErModel.instance:getCurActId()
		local episodeInfo = MoLiDeErModel.instance:getEpisodeInfoMo(actId, episodeConfig.episodeId)

		if episodeInfo:isInProgress() then
			MoLiDeErGameController.instance:resumeGame(actId, episodeConfig.episodeId)
		else
			MoLiDeErGameController.instance:startGame(actId, episodeConfig.episodeId)
		end
	else
		self:gameFinish()
	end
end

function MoLiDeErController:gameFinish(callback, callbackObj)
	local episodeConfig = MoLiDeErModel.instance:getCurEpisode()

	if not episodeConfig then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	self._finishCallback = callback
	self._finishCallbackObj = callbackObj

	if self:_checkStory(episodeConfig.afterStory) then
		self._playStory(self, episodeConfig.afterStory, self.afterStoryFinish, self)
	else
		self:afterStoryFinish()
	end
end

function MoLiDeErController:afterStoryFinish()
	local episodeConfig = MoLiDeErModel.instance:getCurEpisode()

	if not episodeConfig then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	if self:_checkGame(episodeConfig.gameId) then
		self:episodeFinish(episodeConfig.activityId, episodeConfig.episodeId)
	else
		self:storyEpisodeFinish(episodeConfig.activityId, episodeConfig.episodeId)
	end

	if self._finishCallback and self._finishCallbackObj then
		self._finishCallback(self._finishCallbackObj)
	end

	self._finishCallback = nil
	self._finishCallbackObj = nil
end

function MoLiDeErController:episodeFinish(actId, episodeId)
	local isSkipGame = MoLiDeErGameModel.instance:getSkipGameTrigger(actId, episodeId)

	if isSkipGame then
		MoLiDeErGameModel.instance:setSkipGameTrigger(actId, episodeId, false)
	end

	self:dispatchEvent(MoLiDeErEvent.OnFinishEpisode, actId, episodeId, isSkipGame)
end

function MoLiDeErController:storyEpisodeFinish(actId, episodeId)
	MoLiDeErRpc.instance:sendAct194FinishStoryEpisodeRequest(actId, episodeId)
end

function MoLiDeErController:_playStory(storyId, callback, callbackObj)
	local param = {}

	param.blur = true
	param.hideStartAndEndDark = true
	param.mark = true
	param.isReplay = false

	StoryController.instance:playStory(storyId, param, callback, callbackObj)
end

function MoLiDeErController:_checkStory(storyId)
	if storyId == nil or storyId == 0 then
		return false
	end

	return true
end

function MoLiDeErController:_checkGame(gameId)
	if gameId == nil or gameId == 0 then
		return false
	end

	return true
end

function MoLiDeErController:statGameStart(actId, episodeId)
	self._statGameStartTime = Time.time
	self._statActId = actId
	self._statEpisodeId = episodeId
end

function MoLiDeErController:statGameExit(formType)
	if self._statGameStartTime and self._statActId and self._statEpisodeId then
		local usetime = Time.time - self._statGameStartTime

		StatController.instance:track(StatEnum.EventName.MoLiDeEr_Act194GameViewExit, {
			[StatEnum.EventProperties.MoLiDeEr_From] = formType,
			[StatEnum.EventProperties.Usetime_Num] = usetime,
			[StatEnum.EventProperties.ActivityId] = tostring(self._statActId),
			[StatEnum.EventProperties.EpisodeId_Num] = self._statEpisodeId
		})
	end

	self._statGameStartTime = nil
	self._statActId = nil
	self._statEpisodeId = nil
end

MoLiDeErController.instance = MoLiDeErController.New()

return MoLiDeErController
