-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/controller/HolyStripeCopyController.lua

module("logic.extensions.holystripecopy.controller.HolyStripeCopyController", package.seeall)

local HolyStripeCopyController = class("HolyStripeCopyController", BaseController)

function HolyStripeCopyController:onInit()
	self:onReset()
end

function HolyStripeCopyController:onReset()
	self._sweepCallback = nil
end

function HolyStripeCopyController:getInfo()
	LingWenAgent.instance:sendPM_LingWenGetInfoReq()
end

function HolyStripeCopyController:handleGetInfo(msg)
	HolyStripeCopyModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyInfoUpdate)
end

function HolyStripeCopyController:getLastForm(isTeamForm, isPreSetForm)
	self._isPreSetForm = isPreSetForm

	LingWenAgent.instance:sendPM_LingWenGetFormReq(isTeamForm)
end

function HolyStripeCopyController:handleGetLastForm(msg)
	HolyStripeCopyModel.instance:onGetLastForm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyFormtionGet, msg.isGroupForm, self._isPreSetForm)

	self._isPreSetForm = nil
end

function HolyStripeCopyController:saveForm(isTeamForm)
	local formList = {}
	local formMsgList = {}

	if isTeamForm then
		table.insert(formList, HolyStripeCopyModel.instance:getTeamCustomFmtMo():getCurFormation())
	else
		for i = 1, 3 do
			table.insert(formList, HolyStripeCopyModel.instance:getSoloCustomFmtMo():getCurFormationList()[i])
		end
	end

	for k, fmo in ipairs(formList) do
		local simpleForm = fmo:createFormPb()

		table.insert(formMsgList, simpleForm)
	end

	LingWenAgent.instance:sendPM_LingWenSetFormReq(isTeamForm, formMsgList)
end

function HolyStripeCopyController:handleSaveForm(msg)
	return
end

function HolyStripeCopyController:handleReadyForTeamBattle(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyTeamBattleReady)
end

function HolyStripeCopyController:startFight(tabId, stageId)
	local formList = {}

	for i = 1, 3 do
		local fmo = HolyStripeCopyModel.instance:getSoloCustomFmtMo():getCurFormationList()[i]
		local simpleForm = fmo:createFormPb()

		table.insert(formList, simpleForm)
	end

	LingWenAgent.instance:sendPM_LingWenFightReq(tabId, stageId, formList)
end

function HolyStripeCopyController:handleStartFight(msg)
	return
end

function HolyStripeCopyController:sendReadyTeamFight(fmo)
	local simpleForm = fmo:createFormPb()

	LingWenAgent.instance:sendPM_LingWenReadyReq(simpleForm)
end

function HolyStripeCopyController:handleReadyTeamFight(msg)
	return
end

function HolyStripeCopyController:handleNotifySoloFightResult(msg)
	HolyStripeCopyModel.instance:onGetSoloFightReseult(msg)
	self:handleBattleResults(msg, 1)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyInfoUpdate)
end

function HolyStripeCopyController:handleNotifyTeamFightResult(msg)
	HolyStripeCopyModel.instance:onGetTeamFightReseult(msg)
	FormTeamModel.instance:resetCurTeamData()
	self:handleBattleResults(msg, 2)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyInfoUpdate)
end

function HolyStripeCopyController:handleBattleResults(msg, fightType)
	self._curBtlResultIdx = 1
	self._btlResultList = msg.btlResult
	self._isReplaying = false

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startHolyStripeCopySoloBattle(fightType, msg.maxFetter)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.HolyStripeCopy)
	end
end

function HolyStripeCopyController:tryNextBattle(fightType)
	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	if btlResult ~= nil then
		BattleFacade.instance:startHolyStripeCopySoloBattle(fightType, BattleModel.instance.maxFetter)
		BattleController.instance:onBattleContinue(btlResult)

		return true
	end

	return false
end

function HolyStripeCopyController:getCurBattleResultIdx()
	return checknumber(self._curBtlResultIdx) - 1
end

function HolyStripeCopyController:openBattleResultView()
	local num = #self._btlResultList

	self:setBattleResult(self._btlResultList[num])
	HolyStripeCopyModel.instance:setRewardListCI()

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

function HolyStripeCopyController:setBattleResult(rData)
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

function HolyStripeCopyController:dealFightError(reason)
	printInfo("灵纹战斗异常：" .. reason)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, reason)
	FormTeamController.instance:onFightErrorForceLeaveCurTeam()
end

function HolyStripeCopyController:dealEnterTeamFight()
	UIJumper.instance:pushOneStack(ViewName.FormTeamCurTeamView, true)
end

function HolyStripeCopyController:_onSweepRes(msg)
	HolyStripeCopyModel.instance:onSweepSuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeCopyInfoUpdate)
	GameUtil.callBack(self._sweepCallback, msg)
	self:_resetSweepParam()
end

function HolyStripeCopyController:addSweepParam(callback)
	self._sweepCallback = callback
end

function HolyStripeCopyController:_resetSweepParam()
	self._sweepCallback = nil
end

HolyStripeCopyController.instance = HolyStripeCopyController.New()

return HolyStripeCopyController
