-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomMissionView.lua

module("logic.extensions.customfmt.view.CustomMissionView", package.seeall)

local CustomMissionView = class("CustomMissionView", MissionView)

function CustomMissionView:onExit()
	CustomMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onFormationChangeFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)
	self.customFmtMo:sendSaveMsg()
	CustomFmtController.instance:setTempFmtMo(nil)
end

function CustomMissionView:onEnter()
	self.customFmtMo = self:getFirstParam()

	CustomFmtController.instance:setTempFmtMo(self.customFmtMo)
	print("<color='#ff00ff'>>>>>###CustomMissionView</color>", self.customFmtMo.__cname)
	self.customFmtMo:updateData()
	self.customFmtMo:initFightHandler()
	self:onEnterInherit()
	self:_setDescStr(self.customFmtMo.topTitleStr, nil, self.customFmtMo.ruleDescStr)

	local formConditionId = self.customFmtMo:getFormCondition()

	if formConditionId and formConditionId > 0 then
		self:_setValidatorDesc(self.customFmtMo:getFormCondition())
	else
		self:_setPureValidatorDesc(self.customFmtMo.validatorDescStr)
	end

	local extViewName = self.customFmtMo:getExtendViewName()

	if not string.nilorempty(extViewName) then
		self:showTabAt(self._extension, extViewName, self.customFmtMo)
	end

	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return self.customFmtMo:getAllShowPetList()
	end)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onFormationChangeFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)
	self.addGEvent(self, GlobalNotify.CustomMissionOneKey, self._onClickOneKey, self)
	self:_setBtnVideoState(self.customFmtMo.showBtnVideo)
end

function CustomMissionView:onEnterFinished()
	CustomMissionView.super.onEnterFinished(self)
	self:_onValidateUI()

	if self.customFmtMo.nEnterShowRuleFlag == ICustomFmtMo.EEnterShowRuleFlag_Always then
		if self.customFmtMo.isShowRuleDescToggle then
			local isShowByToggle = not GameUtil.getUserDayData(MissionConst.MissionLegend .. self.customFmtMo.strShowRuleFlagKey)

			if isShowByToggle then
				self:_openPassRuleView()
			end
		else
			self:_openPassRuleView()
		end
	elseif self.customFmtMo.nEnterShowRuleFlag == ICustomFmtMo.EEnterShowRuleFlag_DailyOnce then
		if not string.nilorempty(self.customFmtMo.strShowRuleFlagKey) and GameUtil.getUserDayData(self.customFmtMo.strShowRuleFlagKey) ~= 1 then
			GameUtil.saveUserDayData(self.customFmtMo.strShowRuleFlagKey, 1)
			self:_openPassRuleView()
		end
	elseif self.customFmtMo.nEnterShowRuleFlag == ICustomFmtMo.EEnterShowRuleFlag_UserSet then
		if not string.nilorempty(self.customFmtMo.strShowRuleFlagKey) and GameUtil.getUserDayData(self.customFmtMo.strShowRuleFlagKey) ~= 1 then
			self:_openPassRuleView()
		end
	elseif self.customFmtMo.nEnterShowRuleFlag == ICustomFmtMo.EEnterShowRuleFlag_First and not string.nilorempty(self.customFmtMo.strShowRuleFlagKey) and GameUtil.getUserData(self.customFmtMo.strShowRuleFlagKey) ~= 1 then
		GameUtil.saveUserData(self.customFmtMo.strShowRuleFlagKey, 1)
		self:_openPassRuleView()
	end
end

function CustomMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self), function(posList, petPool)
		local needPets = FastFormation.instance.needPets

		posList, petPool = self.customFmtMo:getFinalFmoList(posList, petPool, needPets)

		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function CustomMissionView:notFilterPet(petMo)
	local forbit = self.customFmtMo:checkPetIsForbit(petMo)

	if forbit then
		return false
	end

	return true
end

function CustomMissionView:_getCurFormation()
	return (self.customFmtMo:getCurFormation())
end

function CustomMissionView:_enterBattle()
	BattleSkipTimeMgr.instance:setCurrFightConfig(self.customFmtMo:getFmtInfoConfig())
	self.customFmtMo:sendFightMsg()
end

function CustomMissionView:_onMissionBattleResBack(status)
	CustomMissionView.super._onMissionBattleResBack(self, status)
	BattleSkipTimeMgr.instance:setCurrFightConfig(nil)
end

function CustomMissionView:_openPassRuleView()
	local param1, param2 = MissionModel.instance:getRuleDesc()
	local param3 = MissionModel.instance:getRuleParam()
	local uiFlyParam = UIFlyTweenParam.New()

	uiFlyParam.endPosition = self:_getBtnRulePosition()

	local params = {
		param1,
		param2,
		param3,
		uiFlyParam
	}
	local viewName = ViewName.PassRuleView

	if not string.nilorempty(self.customFmtMo.ruleViewName) then
		if self.customFmtMo.ruleViewArgs then
			if type(self.customFmtMo.ruleViewArgs) == "table" then
				for _, v in ipairs(self.customFmtMo.ruleViewArgs) do
					table.insert(params, v)
				end
			else
				table.insert(params, self.customFmtMo.ruleViewArgs)
			end
		end

		viewName = self.customFmtMo.ruleViewName
	else
		viewName = ViewName.PassRuleView
	end

	UIStateManager.instance:open(viewName, unpack(params))
end

function CustomMissionView:_initFormCondition(formCondition)
	if self.customFmtMo:getFormCondition() then
		MissionModel.instance:setFormCondition(self.customFmtMo:getFormCondition())
	else
		MissionModel.instance:setFormCondition(formCondition)
	end
end

function CustomMissionView:_onClickClose()
	local handler = GameUtil.handler(CustomMissionView.super._onClickClose, self)

	self.customFmtMo:onClickCloseBtn(handler)
end

function CustomMissionView:_onClickStart()
	if EscortModel.instance:IsPickupEscort() and self._viewPresentor.viewName ~= ViewName.EscortMission then
		FloatWordMgr.instance:show("护送期间不能进行其他战斗!")

		return
	end

	if self._extParams and self._extParams.battleConditionId then
		local id = checknumber(self._extParams.battleConditionId)
		local condition = EnterBattleCondition.New()

		condition:init(id)

		if not condition:isCanPass() then
			return
		end
	end

	if not self:_isFormationValidatorMatchOnStart() then
		return
	end

	local hasOneKey = GameUtil.GetActive(self._btnOneKey)
	local isLimit = self:checkFormationEmptyAndPosNumLimit(function()
		self:_startClg()
	end, hasOneKey, function()
		self:_onClickOneKey()
	end)

	if isLimit then
		return
	end

	self:_startClg()
end

function CustomMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	return self.customFmtMo:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
end

function CustomMissionView:_isFormationValidatorMatchOnStart()
	return FormationValidatorController.instance:isFormationValidatorMatchOnStart(self.customFmtMo:getFormCondition(), self:_getCurFormation())
end

function CustomMissionView:_onFormationChangeFinish()
	CustomMissionView.super._onFormationChangeFinish(self)
	self.customFmtMo:onFormationChangeFinish()

	local formCondition = self.customFmtMo:getFormCondition()

	if formCondition and formCondition > 0 then
		self:_setValidatorDesc(self.customFmtMo:getFormCondition())
	end

	self:_setDescStr(self.customFmtMo.topTitleStr, nil, self.customFmtMo.ruleDescStr)
	self:setRuleDesc()

	if self.customFmtMo.validatorDescIsShowYesOrNo then
		self:_setPureValidatorDescYesOrNo(self.customFmtMo.isValidatorDescYesOrNo)
	end
end

function CustomMissionView:_onValidateUI()
	if self.customFmtMo then
		GameUtil.SetActive(self._btnOneKey, self.customFmtMo.isShowOneKey)
		GameUtil.SetActive(self._btnClean, self.customFmtMo.isShowClean)
		GameUtil.SetActive(self._petButton, self.customFmtMo.isShowPetBag)
	end
end

function CustomMissionView:_maxPetNum()
	return self.customFmtMo.needUpPetCount
end

function CustomMissionView:_onClickVideo()
	if self.customFmtMo.showBtnVideo then
		self.customFmtMo:sendVideoMsg()

		return
	end

	CustomMissionView.super._onClickVideo(self)
end

function CustomMissionView:setRuleDesc()
	CustomMissionView.super.setRuleDesc(self)

	if self.customFmtMo.isShowRuleDescToggle then
		self._ruleParam = self._ruleParam or {}
		self._ruleParam.challengeId = self.customFmtMo.strShowRuleFlagKey
		self._ruleParam.isShowToggle = self.customFmtMo.isShowRuleDescToggle
		self._ruleParam.challengeName = self.customFmtMo.ruleDescToggleName or "挑战"
		self._ruleParam.challengeTogDesc = self.customFmtMo.ruleDestToggleDesc or "今日不再自动提示规则"

		MissionModel.instance:setRuleParam(self._ruleParam)
	end
end

function CustomMissionView:_getUnableLevelPos()
	return self.customFmtMo:getUnableLevelPos()
end

function CustomMissionView:_onClickPet()
	if self.customFmtMo:checkIsCanJumpOut() then
		CustomMissionView.super._onClickPet(self)
	else
		self.customFmtMo:showIsNotCanJumpOutTip()
	end
end

return CustomMissionView
