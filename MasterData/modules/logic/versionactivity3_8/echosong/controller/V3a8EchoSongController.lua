-- chunkname: @modules/logic/versionactivity3_8/echosong/controller/V3a8EchoSongController.lua

module("modules.logic.versionactivity3_8.echosong.controller.V3a8EchoSongController", package.seeall)

local V3a8EchoSongController = class("V3a8EchoSongController", BaseController)

function V3a8EchoSongController:onInit()
	return
end

function V3a8EchoSongController:onInitFinish()
	return
end

function V3a8EchoSongController:addConstEvents()
	return
end

function V3a8EchoSongController:reInit()
	return
end

function V3a8EchoSongController:openV3a8EchoSongLevelView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V3a8EchoSongLevelView, param, isImmediate)
end

function V3a8EchoSongController:openV3a8EchoSongGameView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V3a8EchoSongGameView, param, isImmediate)
end

function V3a8EchoSongController:openV3a8EchoSongResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V3a8EchoSongResultView, param, isImmediate)
end

function V3a8EchoSongController:openV3a8EchoSongTaskView()
	local actId = V3a8EchoSongModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.V3a8EchoSongTaskView, {
		actId = actId
	})
end

function V3a8EchoSongController.setSaveStr(type, id, value)
	local key = V3a8EchoSongController._getKey(type, id)

	PlayerPrefsHelper.setString(key, value)
end

function V3a8EchoSongController.getSaveStr(type, id)
	local key = V3a8EchoSongController._getKey(type, id)

	return (PlayerPrefsHelper.getString(key, ""))
end

function V3a8EchoSongController._getKey(type, id)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.V3a8EchoSongGameKey, PlayerModel.instance:getPlayinfo().userId, type, id))
end

function V3a8EchoSongController:getScenePath()
	return string.format(V3a8EchoSongEnum.ScenePath, V3a8EchoSongModel.instance:getSceneId())
end

function V3a8EchoSongController:enterGame(episodeId, gameId)
	V3a8EchoSongModel.instance:clearAllData()

	if not episodeId or not gameId then
		logError("V3a8EchoSongController enterGame error, episodeId or gameId is nil", tostring(episodeId), tostring(gameId))

		return
	end

	V3a8EchoSongModel.instance:onEnterGame(episodeId, gameId)
	self:clearGameResult()
	self:statGameStart()
	self:openV3a8EchoSongGameView()
end

function V3a8EchoSongController:dispatchGameResult(isSuccess)
	if self._gameResultDispatched then
		return
	end

	self._gameResultDispatched = true
	self._gameResult = not not isSuccess

	self:dispatchEvent(V3a8EchoSongEvent.ShowResultView, isSuccess)
end

function V3a8EchoSongController:setGameResult(isSuccess)
	if self._gameResultDispatched then
		return
	end

	self._gameResultDispatched = true
	self._gameResult = not not isSuccess
end

function V3a8EchoSongController:isGameOver()
	return self._gameResultDispatched == true
end

function V3a8EchoSongController:isGameWin()
	return self._gameResultDispatched == true and self._gameResult == true
end

function V3a8EchoSongController:isGameFail()
	return self._gameResultDispatched == true and self._gameResult == false
end

function V3a8EchoSongController:clearGameResult()
	self._gameResultDispatched = false
	self._gameResult = nil
end

function V3a8EchoSongController:clickEpisodeLevel(episodeId, index)
	local actId = V3a8EchoSongModel.instance:getActId()
	local act220MO = Activity220Model.instance:getById(actId)
	local episodeMO = act220MO and act220MO:getEpisodeInfo(episodeId)

	if not episodeMO then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local episodeCfg = episodeMO.config
	local storeBefore = episodeCfg.storyBefore
	local param = {
		episodeCfg = episodeCfg
	}

	if storeBefore > 0 then
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(storeBefore, storyParam, self._afterPlayLevelBeforeStory, self, param)
	else
		self:_afterPlayLevelBeforeStory(param)
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, index)
end

function V3a8EchoSongController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId = cfg.episodeId
	local gameId = cfg.gameId

	if gameId ~= 0 then
		V3a8EchoSongController.instance:enterGame(episodeId, gameId)
	else
		self:finishEpisodeLevel(episodeId)
	end
end

function V3a8EchoSongController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = V3a8EchoSongModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

function V3a8EchoSongController:statGameStart()
	self._statGameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function V3a8EchoSongController:_sendEverechoStat(result)
	local useTime = 0

	if self._statGameStartTime then
		useTime = UnityEngine.Time.realtimeSinceStartup - self._statGameStartTime
	end

	local var_24_0 = {}

	var_24_0[StatEnum.EventProperties.Everecho_EpisodeId] = tostring(V3a8EchoSongModel.instance:getGameEpisodeId() or "")
	var_24_0[StatEnum.EventProperties.Everecho_Result] = result
	var_24_0[StatEnum.EventProperties.Everecho_UseTime] = useTime

	StatController.instance:track(StatEnum.EventName.ExitEverechoActivity, var_24_0)
end

function V3a8EchoSongController:sendGameSuccess()
	self:_sendEverechoStat("成功")
end

function V3a8EchoSongController:sendGameFail()
	self:_sendEverechoStat("失败")
end

function V3a8EchoSongController:sendGameReset()
	self:_sendEverechoStat("重置")
	self:statGameStart()
end

function V3a8EchoSongController:sendGameAbort()
	self:_sendEverechoStat("主动中断")
end

V3a8EchoSongController.instance = V3a8EchoSongController.New()

return V3a8EchoSongController
