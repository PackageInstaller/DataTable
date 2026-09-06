-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/controller/InfinitefutureController.lua

module("logic.extensions.infinitefuture.controller.InfinitefutureController", package.seeall)

local InfinitefutureController = class("InfinitefutureController", BaseController)

function InfinitefutureController:ctor()
	return
end

function InfinitefutureController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
end

function InfinitefutureController:onReset()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_HUD_ENDLESS)
end

function InfinitefutureController:sceneGotoNPC(npcId)
	npcId = checknumber(npcId)

	UIStateManager.instance:clear(true)
	TaskController.instance:gotoNpc(npcId)
end

function InfinitefutureController:checkOpenLevelView(actId, viewName)
	actId = checknumber(actId)

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.EndlessChallenge, actId) then
		FloatWordMgr.instance:show("暂未开启")

		return
	end

	if GameUtil.getUserData("infinfuover" .. tostring(actId)) ~= nil then
		FloatWordMgr.instance:show("已通过所有关卡")

		return
	end

	if string.nilorempty(viewName) then
		FuncOpenController.instance:openFuncByViewName("infinfulevelsview", actId)
	else
		FuncOpenController.instance:openFuncByViewName(viewName, actId)
	end
end

function InfinitefutureController:_onEndStory(storyId)
	local plotId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_plot"))

	if plotId ~= storyId then
		return
	end

	local npcId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_map"))

	TaskController.instance:gotoNpc(npcId)
end

function InfinitefutureController:sendInfoReq(activityId)
	InfiniteFutureAgent.instance:sendPM_InfiniteFutureInfoReq(activityId)
end

function InfinitefutureController:sendChallengeReq(activityId, stageId, teamId, curForm)
	local simpleForm = curForm:createFormPb()

	simpleForm.formId = 0

	InfiniteFutureAgent.instance:sendPM_InfiniteFutureChallengeReq(activityId, stageId, teamId, simpleForm)
end

function InfinitefutureController:sendResetReq(activityId, stageId, teamId)
	InfiniteFutureAgent.instance:sendPM_InfiniteFutureResetReq(activityId, stageId, teamId)
end

function InfinitefutureController:sendSelectBuffReq(activityId, buffId)
	InfiniteFutureAgent.instance:sendPM_InfiniteFutureSelectBuffReq(activityId, buffId)
end

function InfinitefutureController:sendSignInReq(activityId)
	InfiniteFutureAgent.instance:sendPM_InfiniteFutureGetBuffReq(activityId)
end

function InfinitefutureController:startBattle(msg)
	if msg.activityId ~= InfinitefutureModel.instance.viretaActIds[3] then
		BattleFacade.instance:startInfinitefutureCommonBattle()

		return
	end

	self._curBtlResultIdx = 1
	self._btlResultList = msg.btlResultList
	self._isReplaying = false

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startInfinitefutureBattle(btlResult)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
		InfinitefutureModel.instance:setVretaKillScore(msg.score, msg.isWin)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.ViretaActivity)
	end
end

function InfinitefutureController:tryNextBattle()
	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	print("tryNextBattle idx = " .. self._curBtlResultIdx .. "len = " .. #self._btlResultList)

	if btlResult ~= nil then
		BattleFacade.instance:startInfinitefutureBattle()
		BattleController.instance:onBattleContinue(btlResult)

		return true
	end

	return false
end

function InfinitefutureController:getCurBattleResultIdx()
	return checknumber(self._curBtlResultIdx) - 1
end

function InfinitefutureController:openBattleResultView()
	local num = #self._btlResultList

	self:setBattleResult(self._btlResultList[num])

	if self.battleResult == GameEnum.BattleResult.ExpSuccess then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif self.battleResult == GameEnum.BattleResult.Success then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif self.battleResult == GameEnum.BattleResult.DogFall then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	elseif self.battleResult == GameEnum.BattleResult.Failed then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end
end

function InfinitefutureController:setBattleResult(rData)
	local battid = checknumber(rData.battleId)
	local winner = checknumber(rData.activityWinner)
	local leftTeamId = BattleModel.instance:getLeftTeamId()

	if winner == leftTeamId then
		self.battleResult = GameEnum.BattleResult.Success

		PetIntroductionModel.instance:saveBreakFormationIntroduce()
	else
		self.battleResult = winner == -1 and GameEnum.BattleResult.DogFall or GameEnum.BattleResult.Failed
	end

	if rData.expResult and rData.expResult.petGainExp and #rData.expResult.petGainExp > 0 then
		self.battleResult = GameEnum.BattleResult.ExpSuccess
	end
end

InfinitefutureController.instance = InfinitefutureController.New()

return InfinitefutureController
