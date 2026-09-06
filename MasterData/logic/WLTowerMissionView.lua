-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/formation/WLTowerMissionView.lua

module("logic.extensions.waterdraktower.view.formation.WLTowerMissionView", package.seeall)

local WLTowerMissionView = class("WLTowerMissionView", MissionView)

function WLTowerMissionView:buildUI()
	WLTowerMissionView.super.buildUI(self)
end

function WLTowerMissionView:onExit()
	if ViewMgr.instance:isOpen(ViewName.WLTowerBuff) then
		ViewMgr.instance:close(ViewName.WLTowerBuff)
	end

	WLTowerMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerSetForm, self._sendFightReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerSetForm, self._onMissionBattleResBack, self)
end

function WLTowerMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerSetForm, self._sendFightReq, self)
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerSetForm, self._onMissionBattleResBack, self)

	self._params = self:getFirstParam()

	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)
	self:onEnterInherit()
	self:procMid()
	self:_setTitleName()

	if self._params and self._params.buffPlanId then
		ViewMgr.instance:open(ViewName.WLTowerBuff, {
			isMainOpen = false,
			buffPlanId = self._params.buffPlanId
		})
	end

	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function WLTowerMissionView:procMid()
	if self._params then
		local teamCfg = WaterdraktowerConfig.instance:getTierChallengeCfgByStage(self._params.planId, self._params.towerType, self._params.tier, self._params.stage)
		local titleStr = teamCfg.name
		local levelStr = ""

		if not teamCfg.ruleDesc then
			self:_setDescStr(titleStr, levelStr, teamCfg.ruleDesc)
			self:_setRedPoint(teamCfg.redPoint)

			local cfgPerfectWin = BattleSettlementConfig.instance:getBattlePerfectWinOpCfgById(teamCfg.perfectWinId)
			local cfgPerfectWinOpType = BattleSettlementConfig.instance:getBattlePerfectWinOpTypeCfgById(teamCfg.perfectWinId)

			if cfgPerfectWin and cfgPerfectWinOpType then
				local perfectDesc = string.format(cfgPerfectWinOpType.desc, cfgPerfectWin.params)

				self:_setPerfectRuleDesc(perfectDesc)
			end
		end
	end
end

function WLTowerMissionView:_onFormationChangeFinish()
	WLTowerMissionView.super._onFormationChangeFinish(self)

	if self._params and self._params.formCondition > 0 then
		local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(self._params.formCondition)

		if cfg == nil then
			return
		end

		local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._params.formCondition, self:_getCurFormation(), true)

		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)

		self._txtValidatorDesc.text = cfg.desc

		self._imgYes:SetActive(isMatch)
		self._imgNo:SetActive(not isMatch)

		return
	end

	self:_initValidatorDesc()
end

function WLTowerMissionView:_isFormationValidatorMatchOnStart()
	if self._params and self._params.formCondition > 0 then
		return FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._params.formCondition, self:_getCurFormation())
	end

	return true
end

function WLTowerMissionView:_enterBattle()
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerSetForm, self._sendFightReq, self)
	self:_saveCurForm()
end

function WLTowerMissionView:_saveCurForm(showTip)
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
		WaterdraktowerController.instance:csGetWaterDarkTowerSetFormReq(self._params.actId, self._params.towerType, simpleForm)
	else
		if showTip then
			FloatWordMgr.instance:show("不能保存空阵")
		end

		self:_onMissionBattleResBack(-1)
	end
end

function WLTowerMissionView:_sendFightReq(status)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerSetForm, self._sendFightReq, self)

	if status == 0 then
		UIJumper.instance:pushOneStack(ViewName.WLTowerMain)
		WaterdraktowerController.instance:csGetWaterDarkTowerFightReq(self._params.actId, self._params.towerType)
	end
end

function WLTowerMissionView:_procLRTxt()
	self._lImgIsFirst.gameObject:SetActive(false)
	self._rImgIsFirst.gameObject:SetActive(false)
end

function WLTowerMissionView:_onClickClose()
	self:_saveCurForm(false)
	WLTowerMissionView.super._onClickClose(self)
end

function WLTowerMissionView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WLTowerMissionView:_saveFormationEx()
	return false
end

function WLTowerMissionView:_setBtnOneKeyActive()
	if self._params == nil then
		return true
	end

	return self._params.formCondition <= 0
end

function WLTowerMissionView:_isCurFormationEmpty()
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

function WLTowerMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = self:_getCurFormation():getCurExistPetNumber()
	local totalPos = self:_maxPetNum()
	local petsNum = BagModel.instance:diffRacePetCount()
	local showNum = -1
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

function WLTowerMissionView:needCheckNumLimit()
	return false
end

return WLTowerMissionView
