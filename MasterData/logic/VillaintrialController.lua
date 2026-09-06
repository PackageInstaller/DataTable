-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/controller/VillaintrialController.lua

module("logic.extensions.villaintrial.controller.VillaintrialController", package.seeall)

local VillaintrialController = class("VillaintrialController", BaseController)

function VillaintrialController:ctor()
	return
end

function VillaintrialController:onInit()
	VillaintrialController.super.onInit(self)
end

function VillaintrialController:onReset()
	return
end

function VillaintrialController:sendPM_VillainPetTrialGetInfoReq()
	local actId = VillaintrialConfig.instance:getOpenActivityId()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialGetInfoReq(actId)
end

function VillaintrialController:sendPM_VillainPetTrialGetRankInfoReq()
	local actId = VillaintrialConfig.instance:getOpenActivityId()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialGetRankInfoReq(actId)
end

function VillaintrialController:sendPM_VillainPetTrialGetSpiritLineInfoReq()
	local actId = VillaintrialConfig.instance:getOpenActivityId()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialGetSpiritLineInfoReq(actId, VillaintrialModel.instance:getCurStageId())
end

function VillaintrialController:sendPM_VillainPetTrialChangeSpiritLineReq(petId, spiritLineId)
	local actId = VillaintrialConfig.instance:getOpenActivityId()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialChangeSpiritLineReq(actId, petId, VillaintrialModel.instance:getCurStageId(), spiritLineId)
end

function VillaintrialController:sendPM_VillainPetTrialGainPrizeReq(index)
	local actId = VillaintrialConfig.instance:getOpenActivityId()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialGainPrizeReq(actId, index)
end

function VillaintrialController:sendPM_VillainPetTrialChallengeReq(actId, stageId, curForm)
	local simpleForm = curForm:createFormPb()

	VillainPetTrialAgent.instance:sendPM_VillainPetTrialChallengeReq(actId, stageId, simpleForm)
end

function VillaintrialController:playEffect(cell, view, tableview, path, scale)
	local effect = UIEffectManager.instance:playEffect(view, path, cell.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(tableview) then
			eff:setClipping(tableview)
		end
	end)

	effect:setParent(cell.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(scale or 0.8)

	return effect
end

function VillaintrialController:clearEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)
	end
end

function VillaintrialController:startBattle(msg)
	self._curBtlResultIdx = 1
	self._btlResultList = msg.btlResultList
	self._isReplaying = false

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	print("lbc=============================", #self._btlResultList)

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startVillainPetBattle()
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)

		local params = {}

		params.scoreList = {
			string.format("存活精灵数<color=#99FFB0>%s</color>只，获得积分<color=#99FFB0>%s</color>分", msg.aliveNum, msg.stageScore)
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.VillaintrialPet, params)
	end
end

function VillaintrialController:tryNextBattle()
	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	print("tryNextBattle idx = " .. self._curBtlResultIdx .. "len = " .. #self._btlResultList)

	if btlResult ~= nil then
		BattleFacade.instance:startVillainPetBattle()
		BattleController.instance:onBattleContinue(btlResult)

		return true
	end

	return false
end

function VillaintrialController:getCurBattleResultIdx()
	return checknumber(self._curBtlResultIdx) - 1
end

function VillaintrialController:openBattleResultView()
	local num = #self._btlResultList

	self:setBattleResult(self._btlResultList[num])
	UIJumper.instance:pushOneStack(ViewName.VillaintrialMainView)

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

function VillaintrialController:setBattleResult(rData)
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

VillaintrialController.instance = VillaintrialController.New()

return VillaintrialController
