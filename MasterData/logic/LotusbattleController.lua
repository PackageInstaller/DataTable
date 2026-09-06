-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/controller/LotusbattleController.lua

module("logic.extensions.lotusbattle.controller.LotusbattleController", package.seeall)

local LotusbattleController = class("LotusbattleController", BaseController)

LotusbattleController.EnterShowFormationTime = "LotusbattleController.EnterShowFormationTime"

function LotusbattleController:ctor()
	return
end

function LotusbattleController:onInit()
	self:onReset()
end

function LotusbattleController:onReset()
	removetimer(self._forceBattleFinish, self)
	removetimer(self._closeMatchView, self)
	removetimer(self._showFormationFinish, self)
	self:resetData()
end

function LotusbattleController:getModelDailyChallengeLeftTimes(activityId, modelId)
	local useTime = LotusbattleModel.instance:getTodayChallengeTimes(modelId)
	local totalTime = LotusbattleConfig.instance:getModelDailyTimes(activityId, modelId)

	return totalTime - useTime
end

function LotusbattleController:getModelId(activityId)
	local modelCfgs = LotusbattleConfig.instance:getModelCfgs(activityId)

	for i, v in ipairs(modelCfgs) do
		local isOpen = self:isModelIdOpen(activityId, v.model)

		if isOpen then
			return v.model
		end
	end

	return 0
end

function LotusbattleController:isModelIdOpen(activityId, modelId)
	local modelCfg = LotusbattleConfig.instance:getModelCfg(activityId, modelId)

	if not modelCfg then
		return false
	end

	local v = modelCfg

	if string.nilorempty(v.openTime) then
		return true
	end

	local date = ServerTime.nowDateServerLook()
	local todaySec = date.hour * 3600 + date.min * 60 + date.sec
	local timeArr = string.split(v.openTime, ",")

	for i, time in ipairs(timeArr) do
		local arr = string.split(time, "#")
		local sStr = arr[1]
		local eStr = arr[2]
		local sArr = string.split(sStr, ":")
		local eArr = string.split(eStr, ":")
		local stime = checknumber(sArr[1]) * 3600 + checknumber(sArr[2]) * 60 + checknumber(sArr[3])
		local etime = checknumber(eArr[1]) * 3600 + checknumber(eArr[2]) * 60 + checknumber(eArr[3])

		if stime <= todaySec and todaySec <= etime then
			return true
		end
	end

	return false
end

function LotusbattleController:notifyStartBattle(msg)
	self._gameStage = GameEnum.LotusBattleGameState.MinssionFirst

	self:_cacheParams(msg)
	self:_doStageHandle()
end

function LotusbattleController:_showMatchSucces()
	UIStateManager.instance:push(ViewName.LotusbattlematchsuccesView)
	UIStateManager.instance:popByName(ViewName.LotusbattlematchView)
	settimer(1, self._closeMatchView, self, false)
end

function LotusbattleController:_enterMission()
	local activityId = LotusbattleModel.instance:getActivityId()
	local mo = LotusbattleModel.instance:getCustomMo()

	LotusbattleModel.instance:setOpForm(nil)
	LotusbattleModel.instance:setMyForm(nil)
	mo:clearAllPetList()
	mo:getCurFormation():ResetPosition()
	mo:initData(activityId)
	CustomFmtController.instance:showMissionView(mo)
end

function LotusbattleController:_closeMatchView()
	UIStateManager.instance:clear(true)
	self:_enterMission()
end

function LotusbattleController:selectInitBagPets(creepsIds, bagCreepIds)
	self:_cacheParams(creepsIds, bagCreepIds)

	self._gameStage = GameEnum.LotusBattleGameState.SelectInitPet

	self:_doStageHandle()
end

function LotusbattleController:selectBuff(buffIds, isInitBuff)
	self._gameStage = GameEnum.LotusBattleGameState.SelectInitBuff

	self:_cacheParams(buffIds, isInitBuff)
	self:_doStageHandle()
end

function LotusbattleController:getPetMoByCreepsId(creepsId)
	local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)
	local mo = FightingPowerPetMo.New()

	mo:fromChallengeCreepCo(creepsCfg)

	return mo:toBaseBagPetMo()
end

function LotusbattleController:notifyEnterNextSetFormation(msg)
	FloatWordMgr.instance:show("已进入布阵第二阶段")

	self._gameStage = GameEnum.LotusBattleGameState.MinssionSecond

	self:_cacheParams(msg)
	self:_doStageHandle()
end

function LotusbattleController:notifyFightResult(msg)
	self._battleMsg = msg

	LotusbattleModel.instance:insertBuff(msg.myBuffId)
	LotusbattleModel.instance:setResultViewDatas(msg)
	LotusbattleModel.instance:setWinBattleNum(msg.winStreak)

	if msg.state == 1 then
		self._gameStage = GameEnum.LotusBattleGameState.ShowFormation

		self:_doStageHandle()
	elseif msg.state <= 0 then
		UIStateManager.instance:clear(true)
		self:reEnterPrepareView()
	elseif msg.state == 3 then
		UIStateManager.instance:clear(true)
		self:enterResultView()
	elseif msg.state == 2 then
		self:clearBattleMsg()
	end
end

function LotusbattleController:_showFormationFinish()
	self._gameStage = GameEnum.LotusBattleGameState.EnterBattle

	self:_doStageHandle()
end

function LotusbattleController:_enterBattle()
	self:setCanSetFormationFlag(true)

	if self._battleMsg then
		BattleModel.instance:setLeftTeamId(self._battleMsg.myTeamId)
		UIJumper.instance:pushOneStack(ViewName.LotusbattlemainView)

		local activityId = LotusbattleModel.instance:getActivityId()

		BattleFacade.instance:startLotusBattle(self._battleMsg.battleResult)

		local time = LotusbattleConfig.instance:getStageTime(activityId, "battleViewTime") - 2

		settimer(time, self._forceBattleFinish, self, false)
	end
end

function LotusbattleController:enterResultView()
	self._gameStage = GameEnum.LotusBattleGameState.ShowBattleResult

	self:_doStageHandle()
end

function LotusbattleController:_showResultView()
	removetimer(self._forceBattleFinish, self)

	if not self._battleMsg then
		printError("self._battleMsg没有数据")

		return
	end

	local result = self._battleMsg.result
	local win = result == 1

	if win then
		UIStateManager.instance:push(ViewName.LotusbattlewinresultView)
	else
		UIStateManager.instance:push(ViewName.LotusbattlelostresultView)
	end
end

function LotusbattleController:closeResultView()
	if not self._battleMsg then
		printError("self._battleMsg没有数据")

		return
	end

	local result = self._battleMsg.result
	local win = result == 1

	if not win or self._gameEndMsg then
		self._gameStage = GameEnum.LotusBattleGameState.GameEndResutl

		self:_doStageHandle()
	else
		self._gameStage = GameEnum.LotusBattleGameState.SelectPetInWin

		self:_doStageHandle()
	end
end

function LotusbattleController:_winSelectPetInsertMyTeam()
	UIStateManager.instance:push(ViewName.LotusbattlewinselectView)
end

function LotusbattleController:_topWinSelectPetInsertMyTeam()
	UIStateManager.instance:push(ViewName.LotusbattletopwinselectView)
end

function LotusbattleController:closeTopWinSelectPetView()
	self:_openRankResult()
end

function LotusbattleController:_endGame()
	removetimer(self._showFormationFinish, self)
	printInfo("lgjlb", self._gameEndMsg)

	if self._gameEndMsg then
		local activityId = LotusbattleModel.instance:getActivityId()

		printInfo("lgjlb activityId", activityId)

		if not activityId or activityId <= 0 then
			self:_openRankResult()

			return
		end

		local modelCfg = LotusbattleConfig.instance:getModelCfg(activityId, self._gameEndMsg.modelId)

		if self._gameEndMsg.rank <= modelCfg.spoilsRank and #self._gameEndMsg.creepIds > 0 then
			self._gameStage = GameEnum.LotusBattleGameState.SelectPetInEnd

			self:_doStageHandle()
		else
			self:_openRankResult()
		end
	else
		printError("没有下发GameEnd")
	end
end

function LotusbattleController:_openRankResult()
	UIStateManager.instance:push(ViewName.LotusbattlerankresultView)
end

function LotusbattleController:_forceBattleFinish()
	self._gameStage = GameEnum.LotusBattleGameState.ForceFinishBattle

	self:_doStageHandle()
end

function LotusbattleController:matchFail()
	self._gameStage = GameEnum.LotusBattleGameState.MatchFail

	self:_doStageHandle()
end

function LotusbattleController:sendPM_LBFStartMatchReq(activityId, modelId)
	self._gameStage = GameEnum.LotusBattleGameState.StartMatch

	self:_doStageHandle()
	LotusBattleFieldAgent.instance:sendPM_LBFStartMatchReq(activityId, modelId)
end

function LotusbattleController:tryUnlockNangGrid()
	local activityId = LotusbattleModel.instance:getActivityId()
	local actCfg = LotusbattleConfig.instance:getActCfg(activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(actCfg.unlockPackageCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("确定花费%s%s解锁该栏位吗？", matNum, matName)

	local function successCallBack()
		LotusBattleFieldAgent.instance:sendPM_LBFUnlockPackagePosReq(activityId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
end

function LotusbattleController:notifyEnterBattleField(msg)
	self._gameStage = GameEnum.LotusBattleGameState.EnterBattleField

	self:_cacheParams(msg)
	self:_doStageHandle()
end

function LotusbattleController:_enterPrepareBattle(msg)
	self:clearBattleMsg()

	self._enterPerpareBattleView = true

	local buffid = msg.buffId
	local battlefield = msg.battleField
	local nextforcetime = msg.nextForceTime

	UIStateManager.instance:popByName(ViewName.LotusbattlebuffView)
	LotusbattleModel.instance:setPrepareBattlefield(battlefield, battlefield.headInfo)
	LotusbattleModel.instance:setPrepareBaseInfo(msg)
	LotusbattleModel.instance:insertBuff(buffid)
	LotusbattleModel.instance:setNextForceTime(nextforcetime)
	self:reEnterPrepareView()
end

function LotusbattleController:isEnterPrepareBattleView()
	return self._enterPerpareBattleView
end

function LotusbattleController:battleRecordDetailRes(msg)
	self._battleRecordDetailMsg = msg

	UIStateManager.instance:push(ViewName.LotusbattlereportdetailView, msg)
end

function LotusbattleController:getBattleVideoRes(battleResult)
	BattleFacade.instance:onViewUserFightMonsterBtlResult(battleResult)
end

function LotusbattleController:notifyGameEndRes(msg)
	self._gameEndMsg = msg

	LotusbattleModel.instance:setEndGameMsg(msg)
	printInfo("lgjlb ", self._battleMsg, SceneMgr.instance.isGogingToEnterBattleScene)

	if not self._battleMsg and not SceneMgr.instance.isGogingToEnterBattleScene then
		UIStateManager.instance:clear(true)

		self._gameStage = GameEnum.LotusBattleGameState.GameEndResutl

		self:_doStageHandle()
	end
end

function LotusbattleController:reEnterPrepareView()
	UIStateManager.instance:popByName(ViewName.LotusbattleprepareView)
	UIStateManager.instance:push(ViewName.LotusbattleprepareView)
end

function LotusbattleController:clearBattleMsg()
	self._battleMsg = nil
end

function LotusbattleController:notifySelectBattleSpoils(msg)
	local creepsid = msg.creepsId
	local buffIds = msg.buffId
	local nextforcetime = msg.nextForceTime

	LotusbattleModel.instance:inserPets({
		creepsid
	})

	for i, buffid in ipairs(buffIds or {}) do
		LotusbattleModel.instance:insertBuff(buffid)
	end

	LotusbattleModel.instance:setNextForceTime(nextforcetime)

	if SceneMgr.instance.isGogingToEnterBattleScene then
		UIJumper.instance:pushOneStack(ViewName.LotusbattleprepareView)
		BattleFacade.instance:endBattle()
	else
		UIStateManager.instance:clear(true)
		UIStateManager.instance:push(ViewName.LotusbattleprepareView)
	end
end

function LotusbattleController:resetData()
	self._gameStage = GameEnum.LotusBattleGameState.Default
	self._enterPerpareBattleView = false
	self._gameEndMsg = false
	self._canSetFormationFlag = true
	self._tempParams = nil
	self._battleRecordDetailMsg = nil
	self._battleMsg = nil

	LotusbattleModel.instance:resetData()
end

function LotusbattleController:clearDataOnMatch()
	self._gameStage = GameEnum.LotusBattleGameState.Default
	self._enterPerpareBattleView = false
	self._gameEndMsg = false
	self._canSetFormationFlag = true
	self._tempParams = nil
	self._battleRecordDetailMsg = nil
	self._battleMsg = nil

	LotusbattleModel.instance:clearDataOnMatch()
end

function LotusbattleController:notifyEnterSelectBuff(msg)
	local form = msg.form
	local opform = msg.opForm
	local buffids = msg.buffIds

	LotusbattleModel.instance:setMyForm(form)
	LotusbattleModel.instance:setOpForm(opform)
	LotusbattleController.instance:selectBuff(buffids)
end

function LotusbattleController:getBattleVideoReq(battleId)
	UIJumper.instance:pushOneStack(ViewName.LotusbattlemainView)
	UIJumper.instance:pushOneStack(ViewName.LotusbattlereportView)

	if self._battleRecordDetailMsg then
		UIJumper.instance:pushOneStack(ViewName.LotusbattlereportdetailView, nil, self._battleRecordDetailMsg)

		self._battleRecordDetailMsg = nil
	end

	LotusBattleFieldAgent.instance:sendPM_LBFGetBattleVideoReq(battleId)
end

function LotusbattleController:getAttrIconIndex(raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

	race = race % 10

	return race - 1
end

function LotusbattleController:setCanSetFormationFlag(flag)
	self._canSetFormationFlag = flag

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function LotusbattleController:getCanSetFormationFlag()
	return self._canSetFormationFlag
end

function LotusbattleController:openView()
	self._gameStage = GameEnum.LotusBattleGameState.EnterMainView

	self:_doStageHandle()
end

function LotusbattleController:_doStageHandle()
	local gameStage = self._gameStage

	if gameStage == GameEnum.LotusBattleGameState.EnterMainView then
		UIStateManager.instance:push(ViewName.LotusbattlemainView)
	elseif gameStage == GameEnum.LotusBattleGameState.StartMatch then
		UIStateManager.instance:push(ViewName.LotusbattlematchView)
	elseif gameStage == GameEnum.LotusBattleGameState.MatchFail then
		FloatWordMgr.instance:show("匹配失败")
		UIStateManager.instance:popByName(ViewName.LotusbattlematchView)
	elseif gameStage == GameEnum.LotusBattleGameState.SelectInitPet then
		local params = self:_getCacheParams()
		local creepsIds, bagCreepIds = params[1], params[2]

		UIStateManager.instance:popByName(ViewName.LotusbattlematchView)
		UIStateManager.instance:push(ViewName.LotusbattlepetselectView, creepsIds, bagCreepIds)
	elseif gameStage == GameEnum.LotusBattleGameState.SelectInitBuff then
		local params = self:_getCacheParams()
		local buffIds, isInitBuff = params[1], params[2]

		UIStateManager.instance:push(ViewName.LotusbattlebuffView, buffIds, isInitBuff)
		UIStateManager.instance:popByName(ViewName.LotusbattlepetselectView)
	elseif gameStage == GameEnum.LotusBattleGameState.EnterBattleField then
		local params = self:_getCacheParams()
		local msg = params[1]

		self:_enterPrepareBattle(msg)
	elseif gameStage == GameEnum.LotusBattleGameState.MinssionFirst then
		local params = self:_getCacheParams()
		local msg = params[1]

		LotusbattleModel.instance:setMatchPlayerInfo(msg)
		self:_showMatchSucces()
	elseif gameStage == GameEnum.LotusBattleGameState.MinssionSecond then
		local params = self:_getCacheParams()
		local msg = params[1]

		LotusbattleModel.instance:setNextSetFormationData(msg)
	elseif gameStage == GameEnum.LotusBattleGameState.ShowFormation then
		self:_showFormation()
	elseif gameStage == GameEnum.LotusBattleGameState.EnterBattle then
		self:_enterBattle()
	elseif gameStage == GameEnum.LotusBattleGameState.ForceFinishBattle then
		FloatWordMgr.instance:show("已为您跳过战斗")
		BattleController.instance:pass()
	elseif gameStage == GameEnum.LotusBattleGameState.ShowBattleResult then
		self:_showResultView()
	elseif gameStage == GameEnum.LotusBattleGameState.SelectPetInWin then
		self:_winSelectPetInsertMyTeam()
	elseif gameStage == GameEnum.LotusBattleGameState.SelectPetInEnd then
		self:_topWinSelectPetInsertMyTeam()
	elseif gameStage == GameEnum.LotusBattleGameState.GameEndResutl then
		self:_endGame()
	end
end

function LotusbattleController:_cacheParams(...)
	self._tempParams = {
		...
	}
end

function LotusbattleController:_getCacheParams()
	return self._tempParams
end

function LotusbattleController:_showFormation()
	local activityId = LotusbattleModel.instance:getActivityId()
	local time = LotusbattleConfig.instance:getStageTime(activityId, "showFormationTime")

	FloatWordMgr.instance:show("展示双方祝福")
	GlobalDispatcher:dispatch(LotusbattleController.EnterShowFormationTime)
	settimer(time, self._showFormationFinish, self, false)
end

function LotusbattleController:leaveGame()
	LotusbattleModel.instance:setLeaveGame()
end

LotusbattleController.instance = LotusbattleController.New()

return LotusbattleController
