-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrailMissionView.lua

module("logic.extensions.dragontrial.view.mission.DragontrailMissionView", package.seeall)

local DragontrailMissionView = class("DragontrailMissionView", MissionView)

function DragontrailMissionView:ctor()
	DragontrailMissionView.super.ctor(self)
end

function DragontrailMissionView:onEnter()
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialFirstFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSecondTrialFightFinishRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialSecondFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(DragonTrialAgent.PM_DragonTrialFirstFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialSetFirstTrialFormRes, self._saveFormRes, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialSetDreamTrialFormRes, self._saveFormRes, self)
	GlobalDispatcher:addListener(FormationAgent.PM_UserFormGlobalInfo, self._saveFormRes, self)

	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._planId = params[1]
	self._stageId = params[2]
	self._petPlanId = params[3]

	DragontrialModel.instance:setCurrPetPlanId(self._petPlanId)
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(false)
	FastFormation.instance:setGetCurPetList(function()
		return DragontrialModel.instance:getAllShowPetList(self._petPlanId)
	end)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function DragontrailMissionView:onEnterFinished()
	DragontrailMissionView.super.onEnterFinished(self)

	local isShow = not GameUtil.getUserDayData(MissionConst.MissionDragonTrial .. self._planId .. "@" .. self._stageId)

	if isShow then
		self:_onClickRule()
	end
end

function DragontrailMissionView:onExit()
	DragontrailMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(DragonTrialAgent.PM_DragonTrialFirstFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(DragonTrialAgent.PM_DragonTrialSecondTrialFightFinishRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialSetFirstTrialFormRes, self._saveFormRes, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialSetDreamTrialFormRes, self._saveFormRes, self)
	GlobalDispatcher:removeListener(FormationAgent.PM_UserFormGlobalInfo, self._saveFormRes, self)
	GlobalDispatcher:removeListener(DragonTrialAgent.PM_DragonTrialSecondFightRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(DragonTrialAgent.PM_DragonTrialFirstFightRes, self._onMissionBattleResBack, self)

	self._needAutoFight = false

	self:_saveForm()
end

function DragontrailMissionView:procMid()
	local cfg = DragontrialConfig.instance:getStageById(self._planId, self._stageId)

	if not cfg then
		return
	end

	local titleStr = cfg.name
	local levelStr = ""

	if not cfg.passDesc then
		self:_setDescStr(titleStr, levelStr, cfg.passDesc)
		self:_setValidatorDesc(cfg.formCondition)
	end
end

function DragontrailMissionView:_enterBattle()
	self._needAutoFight = true

	self:_saveForm()
end

function DragontrailMissionView:_saveForm()
	local simpleForm = self:_getCurFormation():createFormPb()

	simpleForm.formId = 10

	local activityId = DragontrialModel.instance:getCurrActivityId()
	local isEnterFirstTrial = DragontrialModel.instance:isFirstTrial()

	if isEnterFirstTrial then
		DragonTrialAgent.instance:sendPM_DragonTrialSetFirstTrialFormReq(activityId, simpleForm)
	else
		local isDragonTrial = not self._petPlanId or self._petPlanId <= 0

		if isDragonTrial then
			local flag = self:_saveFormationEx()

			if not flag then
				self:_saveFormSuccessed()
			end
		else
			DragonTrialAgent.instance:sendPM_DragonTrialSetDreamTrialFormReq(activityId, simpleForm)
		end
	end
end

function DragontrailMissionView:_saveFormSuccessed()
	if not self._needAutoFight then
		return
	end

	self._needAutoFight = false

	BattleFacade.instance:startDragonTrail()

	local activityId = DragontrialModel.instance:getCurrActivityId()
	local isEnterFirstTrial = DragontrialModel.instance:isFirstTrial()

	if isEnterFirstTrial then
		DragonTrialAgent.instance:sendPM_DragonTrialFirstFightReq(activityId, self._stageId)
	else
		local isDragonTrial = not self._petPlanId or self._petPlanId <= 0

		DragontrialController.instance:sendPM_DragonTrialSecondFightReq(activityId, isDragonTrial)
	end

	UIJumper.instance:saveCurStack()
	UIJumper.instance:removeTopState(self._viewPresentor.viewName)
end

function DragontrailMissionView:_isShowBtnEvaluate()
	return true
end

function DragontrailMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	if self:_isCurFormationEmpty() then
		return true
	end

	return self:checkFormationPosNumber(callback, hasOneKey, onekeyCallBack)
end

function DragontrailMissionView:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = self:_getCurFormation():getCurExistPetNumber()
	local totalPos = 5
	local petsNum = DragontrialModel.instance:diffRacePetCount(self._petPlanId)
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
			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), onekeyCallBack, lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function DragontrailMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function DragontrailMissionView:_saveFormationEx()
	if not self._petPlanId or self._petPlanId <= 0 then
		return DragontrailMissionView.super._saveFormationEx(self)
	end
end

function DragontrailMissionView:_isCurFormationEmpty()
	return self:_getCurFormation():isEmpty()
end

function DragontrailMissionView:_getCurFormation()
	return DragontrialModel.instance:getCurFormation(self._petPlanId)
end

function DragontrailMissionView:_openPassRuleView()
	UIStateManager.instance:push(ViewName.DragontrailspecialpassruleView, self._planId, self._stageId)
end

function DragontrailMissionView:_saveFormRes(status)
	self:_onMissionBattleResBack(status)

	if status == 0 then
		self:_saveFormSuccessed()
	end
end

function DragontrailMissionView:_onFormationChangeFinish()
	DragontrailMissionView.super._onFormationChangeFinish(self)

	local cfg = DragontrialConfig.instance:getStageById(self._planId, self._stageId)

	if cfg then
		self:_setValidatorDesc(cfg.formCondition)
	end
end

function DragontrailMissionView:_isFormationValidatorMatchOnStart()
	local cfg = DragontrialConfig.instance:getStageById(self._planId, self._stageId)

	if cfg then
		return FormationValidatorController.instance:isFormationValidatorMatchOnStart(cfg.formCondition, self:_getCurFormation())
	else
		return true
	end
end

return DragontrailMissionView
