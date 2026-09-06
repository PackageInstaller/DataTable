-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/mission/WaterDarkTowerMissionView.lua

module("logic.extensions.waterdraktower.view.mission.WaterDarkTowerMissionView", package.seeall)

local WaterDarkTowerMissionView = class("WaterDarkTowerMissionView", MissionView)

function WaterDarkTowerMissionView:buildUI()
	WaterDarkTowerMissionView.super.buildUI(self)
end

function WaterDarkTowerMissionView:onExit()
	WaterDarkTowerMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, self._sendFightReq, self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, self._onMissionBattleResBack, self)
end

function WaterDarkTowerMissionView:onEnter()
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, self._onMissionBattleResBack, self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._challengeCfg = params[2]
	self._towerType = params[3]
	self.currRaceIdx = 0

	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)
	self:onEnterInherit()
	self:_setDescStr(self._challengeCfg.name, nil, self._challengeCfg.ruleDesc)
	self:_setTitleName()
	self:setRuleDesc()
	self:_initFormCondition(self._challengeCfg.formCondition)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function WaterDarkTowerMissionView:_enterBattle()
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, self._sendFightReq, self)
	self:_saveCurForm()
end

function WaterDarkTowerMissionView:_isFormationValidatorMatchOnStart()
	if self._challengeCfg then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._challengeCfg.formCondition, self:_getCurFormation()))
	end

	return true
end

function WaterDarkTowerMissionView:_onFormationChangeFinish()
	WaterDarkTowerMissionView.super._onFormationChangeFinish(self)

	if self._challengeCfg then
		self:_setValidatorDesc(self._challengeCfg.formCondition)
	end
end

function WaterDarkTowerMissionView:_procLRTxt()
	self._lImgIsFirst.gameObject:SetActive(false)
	self._rImgIsFirst.gameObject:SetActive(false)
end

function WaterDarkTowerMissionView:_sendFightReq(status)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerSetFormRes, self._sendFightReq, self)

	if status == 0 then
		UIJumper.instance:pushOneStack(ViewName.WaterdraktowermainView, nil, self._actId)
		WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerFightReq(self._actId, self._challengeCfg.towerType)
	end
end

function WaterDarkTowerMissionView:_saveCurForm(showTip)
	if showTip == nil then
		showTip = true
	end

	local formInfo = self:_getCurFormation()
	local curFormPos = formInfo:GetPositions()
	local hasPet = false

	for i = 1, 9 do
		hasPet = hasPet or curFormPos[i] > 0
	end

	local simpleForm = formInfo:createFormPb()

	if hasPet then
		WaterdraktowerController.instance:sendPM_WaterDarkTowerSetFormReq(self._actId, self._towerType, simpleForm)
	else
		if showTip then
			FloatWordMgr.instance:show("不能保存空阵")
		end

		self:_onMissionBattleResBack(-1)
	end
end

function WaterDarkTowerMissionView:_onClickClose()
	self:_saveCurForm(false)
	WaterDarkTowerMissionView.super._onClickClose(self)
end

function WaterDarkTowerMissionView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WaterDarkTowerMissionView:_saveFormationEx()
	return false
end

function WaterDarkTowerMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self._notFilterPet, self))
	MissionModel.instance:setForceResetOneKey(false)
end

function WaterDarkTowerMissionView:_notFilterPet(petMo)
	if self.currRaceIdx ~= 0 then
		return PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, self.currRaceIdx)
	end

	return true
end

function WaterDarkTowerMissionView:_setBtnOneKeyActive()
	if self._challengeCfg and self._challengeCfg.formCondition > 0 then
		return false
	else
		return true
	end
end

function WaterDarkTowerMissionView:_isCurFormationEmpty()
	local formation = self:_getCurFormation()

	if not formation then
		return true
	end

	for i = 1, 9 do
		local pos = formation:GetPosition(i)

		if not pos then
			return true
		end

		if pos > 0 then
			return false
		end
	end

	return true
end

function WaterDarkTowerMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = self:_getCurFormation():getCurExistPetNumber()
	local totalPos = self:_maxPetNum()
	local petsNum = BagModel.instance:diffRacePetCount()
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

function WaterDarkTowerMissionView:needCheckNumLimit()
	return false
end

return WaterDarkTowerMissionView
