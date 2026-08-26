-- chunkname: @modules/logic/versionactivity2_4/warmup/controller/V2a4_WarmUpController.lua

module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpController", package.seeall)

local V2a4_WarmUpController = class("V2a4_WarmUpController", BaseController)
local ti = table.insert

function V2a4_WarmUpController:onInit()
	self._battle = V2a4_WarmUpBattleModel.instance
	self._gacha = V2a4_WarmUpGachaModel.instance

	self:reInit()
end

function V2a4_WarmUpController:reInit()
	self._gacha:clean()
end

function V2a4_WarmUpController:config()
	return V2a4_WarmUpConfig.instance
end

function V2a4_WarmUpController:actId()
	return self:config():actId()
end

function V2a4_WarmUpController:addConstEvents()
	return
end

function V2a4_WarmUpController:isTimeout()
	return self._battle:isTimeout()
end

function V2a4_WarmUpController:restart(levelId)
	self._gacha:restart(levelId)
	self._battle:restart(levelId)
	self:waveStart(levelId)
end

function V2a4_WarmUpController:abort()
	local resultInfo = self._battle:getResultInfo()
	local isWin = resultInfo.isWin
	local fillParams = {
		V2a4_WarmUpConfig.instance:getDurationSec(),
		resultInfo.totWaveCnt,
		resultInfo.totAnsYesCnt,
		resultInfo.totAnsNoCnt,
		resultInfo.sucHelpCnt
	}
	local fmt = V2a4_WarmUpConfig.instance:getConstStr(isWin and 4 or 3)
	local desc = GameUtil.getSubPlaceholderLuaLang(fmt, fillParams)
	local viewParam = {
		isSucc = isWin,
		desc = desc,
		closeCb = self._onCloseV2a4_WarmUp_ResultView,
		closeCbObj = self
	}

	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_ResultView, viewParam)

	if isWin then
		self:_sendFinishAct125EpisodeRequest()
	end
end

function V2a4_WarmUpController:_onCloseV2a4_WarmUp_ResultView()
	local viewName = ViewName.V2a4_WarmUp_DialogueView

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:closeView(viewName, nil, true)
	end
end

function V2a4_WarmUpController:waveStart(levelId)
	local waveMO = self:genWave(levelId)

	self:dispatchEvent(V2a4_WarmUpEvent.onWaveStart, waveMO)
end

function V2a4_WarmUpController:postWaveStart(waveMO)
	local ok = waveMO:nextRound()

	if ok then
		local roundMO = waveMO:curRound()

		self:roundStart(waveMO, roundMO)
	else
		self:waveEnd(waveMO)
	end
end

function V2a4_WarmUpController:roundStart(waveMO, roundMO)
	self:dispatchEvent(V2a4_WarmUpEvent.onRoundStart, waveMO, roundMO)
end

function V2a4_WarmUpController:postRoundStart(waveMO, roundMO)
	if self:isTimeout() then
		self:roundEnd(waveMO, roundMO)

		return
	end

	self:moveStep(waveMO, roundMO)
end

function V2a4_WarmUpController:moveStep(waveMO, roundMO)
	local ok, dialogCO = roundMO:moveStep()

	if ok and not self:isTimeout() then
		self:dispatchEvent(V2a4_WarmUpEvent.onMoveStep, waveMO, roundMO, dialogCO)
	else
		self:roundEnd(waveMO, roundMO)
	end
end

function V2a4_WarmUpController:stepEnd(waveMO, roundMO)
	self:moveStep(waveMO, roundMO)
end

function V2a4_WarmUpController:roundEnd(waveMO, roundMO)
	if self:isTimeout() then
		self:abort()

		return
	end

	if roundMO:isWin() and waveMO:nextRound() then
		self:roundStart(waveMO, waveMO:curRound())

		return
	end

	self:waveEnd(waveMO)
end

function V2a4_WarmUpController:waveEnd(waveMO)
	self:dispatchEvent(V2a4_WarmUpEvent.onWaveEnd, waveMO)
end

function V2a4_WarmUpController:genWave(levelId)
	local gachaWaveMO = self._gacha:genWave(levelId)

	return (self._battle:genWave(gachaWaveMO))
end

function V2a4_WarmUpController:timeout()
	self:abort()
end

function V2a4_WarmUpController:commitAnswer(isYes)
	if self:isTimeout() then
		return
	end

	local waveMO = self._battle:curWave()
	local roundMO = waveMO:curRound()

	if not roundMO then
		return
	end

	roundMO:answer(isYes)
	self:moveStep(waveMO, roundMO)
end

function V2a4_WarmUpController:log()
	local t = {}

	self._battle:dump(t)
	logError(table.concat(t, "\n"))
end

function V2a4_WarmUpController:uploadToServer()
	local totHelpNpc = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
	local resultInfo = self._battle:getResultInfo()
	local sucHelpCnt = resultInfo.sucHelpCnt
	local perfect_win = resultInfo.isPerfectWin and 1 or 0

	if sucHelpCnt > 0 then
		totHelpNpc = totHelpNpc + sucHelpCnt

		Activity125Controller.instance:set_V2a4_WarmUp_sum_help_npc(totHelpNpc)
	end

	local refList = {}
	local E = ActivityWarmUpEnum.Activity125TaskTag

	self:_checkSingleClientlistenerParam(refList, E.sum_help_npc, totHelpNpc)
	self:_checkSingleClientlistenerParam(refList, E.perfect_win, perfect_win)
	self:_checkSingleClientlistenerParam(refList, E.help_npc, sucHelpCnt)
	self:sendFinishReadTaskRequest(refList)
end

function V2a4_WarmUpController:_checkSingleClientlistenerParam(refClaimableTaskIdList, taskTag, curProgress)
	local taskType = TaskEnum.TaskType.Activity125
	local taskIdDict = Activity125Config.instance:getTaskCO_ReadTask_Tag(self:actId(), taskTag)

	for taskId, CO in pairs(taskIdDict or {}) do
		local clientlistenerParam = CO.clientlistenerParam
		local need = tonumber(clientlistenerParam) or curProgress + 1

		self:appendCompleteTask(refClaimableTaskIdList, taskType, taskId, curProgress, need)
	end
end

function V2a4_WarmUpController:appendCompleteTask(refClaimableTaskIdList, taskType, taskId, has, need)
	if not TaskModel.instance:isTaskUnlock(taskType, taskId) then
		return
	end

	if TaskModel.instance:taskHasFinished(taskType, taskId) then
		return
	end

	if has < need then
		return
	end

	ti(refClaimableTaskIdList, taskId)
end

function V2a4_WarmUpController:_sendFinishAct125EpisodeRequest()
	local episodeId = self._battle:levelId()

	if Activity125Model.instance:isEpisodeFinished(self:actId(), episodeId) then
		return
	end

	local co = Activity125Config.instance:getEpisodeConfig(self:actId(), episodeId)

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(self:actId(), episodeId, co.targetFrequency)
end

function V2a4_WarmUpController:sendFinishReadTaskRequest(taskIdList)
	if not taskIdList or #taskIdList == 0 then
		return
	end

	for _, taskId in ipairs(taskIdList) do
		TaskRpc.instance:sendFinishReadTaskRequest(taskId)
	end

	self:dispatchEventUpdateActTag()
end

local kPrefix = "V2a4_WarmUpController|"

function V2a4_WarmUpController:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function V2a4_WarmUpController:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function V2a4_WarmUpController:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kPreface = "Preface"

function V2a4_WarmUpController:setIsShownPreface(isShown)
	local key = self:getPrefsKeyPrefix() .. kPreface

	self:saveInt(key, isShown and 1 or 0)
end

function V2a4_WarmUpController:getIsShownPreface()
	local key = self:getPrefsKeyPrefix() .. kPreface

	return self:getInt(key, 0) ~= 0
end

function V2a4_WarmUpController:dispatchEventUpdateActTag()
	local beginnerRedDot = ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)
	local beginnerParentReddot = RedDotConfig.instance:getParentRedDotId(beginnerRedDot)
	local tabRedDot = ActivityConfig.instance:getActivityRedDotId(self:actId())

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(beginnerParentReddot)] = true,
		[tonumber(tabRedDot)] = true,
		[RedDotEnum.DotNode.Activity125Task] = true
	})
end

V2a4_WarmUpController.instance = V2a4_WarmUpController.New()

return V2a4_WarmUpController
