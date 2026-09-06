-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBMissionView.lua

module("logic.extensions.fbbchallenge.view.mission.FBBMissionView", package.seeall)

local FBBMissionView = class("FBBMissionView", MissionView)

function FBBMissionView:buildUI()
	FBBMissionView.super.buildUI(self)
end

function FBBMissionView:onExit()
	FBBMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, self._sendFightReq, self)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoClgFightRes, self._onMissionBattleResBack, self)
	FormationNewModel.instance:RecoverFmtFromServerData()
end

function FBBMissionView:onEnter()
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoClgFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, self._onMissionBattleResBack, self)
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	self._challengeType = 1

	local creepsMasterId = 1
	local monsterCfg = FbbchallengeConfig.instance:getMonsterCfg(creepsMasterId)

	self:_setDescStr(monsterCfg.name, nil, "1.击败王也即可通关，王也不可被千鸟丸秒杀；\n2.若本局战斗不能击败王也，则王也的血量将继承到下一局。")
	self:_setTitleName()
	self:setRuleDesc()
end

function FBBMissionView:_saveFormationEx()
	return false
end

function FBBMissionView:_saveCurForm()
	local formInfo = self:_getCurFormation()
	local simpleForm = formInfo:createFormPb()

	FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoChallengeSetFormReq(simpleForm)
end

function FBBMissionView:_onClickClose()
	self:_saveCurForm()
	FBBMissionView.super._onClickClose(self)
end

function FBBMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	local key = MissionModel.instance:getForceResetOneKey()

	FBBFastFmtView.instance:setFormation(key)
	MissionModel.instance:setForceResetOneKey(false)
end

function FBBMissionView:_onClickClean()
	printInfo("_onClickClean")

	local fixedPosDic = MissionModel.instance:getFixedPos()

	FBBFastFmtView.instance:clean(fixedPosDic)
end

function FBBMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = self:_getCurFormation():getCurExistPetNumber()
	local totalPos = self:_maxPetNum()
	local supportPlanId = FbbchallengeModel.instance:getCurrSupportPlanId()
	local scfgs = FbbchallengeConfig.instance:getSupportCfg(supportPlanId)
	local petsNum = BagModel.instance:diffRacePetCount() + table.nums(scfgs)
	local showNum = -1

	printInfo("test 当前数量是：", numPos, totalPos, petsNum)

	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function FBBMissionView:_isCurFormationEmpty()
	for i = 1, 9 do
		local pos = self:_getCurFormation():GetPosition(i)

		if not pos then
			return true
		end

		if pos > 0 then
			return false
		end
	end

	return true
end

function FBBMissionView:_enterBattle()
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, self._sendFightReq, self)
	self:_saveCurForm()
end

function FBBMissionView:_sendFightReq(status)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoChallengeSetFormRes, self._sendFightReq, self)

	if status == 0 then
		UIJumper.instance:pushOneStack(ViewName.FbbchallengemainView, true)
		FbbchallengeModel.instance:startChallenge()
		BattleFacade.instance:startFBBBattle()
		FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoClgFightReq()
	end
end

function FBBMissionView:_getCurFormation()
	return FbbchallengeModel.instance:getCurFormation()
end

return FBBMissionView
