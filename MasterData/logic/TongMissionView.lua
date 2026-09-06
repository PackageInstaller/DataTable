-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/formation/TongMissionView.lua

module("logic.extensions.tongbattle.view.formation.TongMissionView", package.seeall)

local TongMissionView = class("TongMissionView", MissionView)

function TongMissionView:ctor()
	TongMissionView.super.ctor(self)
end

function TongMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(true)
end

function TongMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)
		local titleStr = teamCfg.name
		local levelStr = ""

		if not teamCfg.WinDesc then
			self:_setDescStr(titleStr, levelStr, teamCfg.WinDesc)
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

function TongMissionView:_onFormationChangeFinish()
	AnheimmMissionView.super._onFormationChangeFinish(self)

	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

		if teamCfg and checknumber(teamCfg.formCondition) > 0 then
			local condCfg = FormationValidatorConfig.instance:getFormationValidatorCfg(teamCfg.formCondition)

			if condCfg == nil then
				return
			end

			local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(teamCfg.formCondition, self:_getCurFormation(), true)

			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)

			self._txtValidatorDesc.text = condCfg.desc

			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end

		return
	end

	self:_initValidatorDesc()
end

function TongMissionView:_isFormationValidatorMatchOnStart()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

		if teamCfg and checknumber(teamCfg.formCondition) > 0 then
			return FormationValidatorController.instance:isFormationValidatorMatchOnStart(teamCfg.formCondition, self:_getCurFormation())
		end
	end

	return true
end

function TongMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params and params.stageId then
		TongBattleController.instance:csGetTongBattleStageReq(params.chalType, params.stageId)
		UIJumper.instance:pushOneStack(ViewName.TongMian, true)
		UIJumper.instance:pushOneStack(ViewName.TongBattle, true)
	end
end

function TongMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	local params = self._viewPresentor:getFirstParam()
	local attrType

	if params and params.stageId then
		local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

		if teamCfg and teamCfg.formCondition > 0 then
			attrType = params.stageId == 1 and "火" or "暗"
		end
	end

	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(petMo)
		return self:isCheckLimitPet(petMo, attrType)
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function TongMissionView:isCheckLimitPet(petMo, attrType)
	if string.nilorempty(attrType) then
		return true
	end

	if petMo == nil then
		return false
	end

	return petMo:checkHasRace(attrType)
end

return TongMissionView
