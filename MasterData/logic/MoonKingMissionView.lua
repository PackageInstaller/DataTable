-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/formation/MoonKingMissionView.lua

module("logic.extensions.moonking.view.formation.MoonKingMissionView", package.seeall)

local MoonKingMissionView = class("MoonKingMissionView", MissionView)

function MoonKingMissionView:ctor()
	MoonKingMissionView.super.ctor(self)
end

function MoonKingMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(true)

	local params = self._viewPresentor:getFirstParam()

	if params then
		ViewMgr.instance:open(ViewName.MoonKingBuff, params)
	end
end

function MoonKingMissionView:onExit()
	MoonKingMissionView.super.onExit(self)

	if ViewMgr.instance:isOpen(ViewName.MoonKingBuff) then
		ViewMgr.instance:close(ViewName.MoonKingBuff)
	end
end

function MoonKingMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = MoonKingConfig.instance:getMasterTeamCfg(params.masterId)
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

function MoonKingMissionView:_onFormationChangeFinish()
	MoonKingMissionView.super._onFormationChangeFinish(self)

	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = MoonKingConfig.instance:getMasterTeamCfg(params.masterId)

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

function MoonKingMissionView:_isFormationValidatorMatchOnStart()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = MoonKingConfig.instance:getMasterTeamCfg(params.masterId)

		if teamCfg and checknumber(teamCfg.formCondition) > 0 then
			return FormationValidatorController.instance:isFormationValidatorMatchOnStart(teamCfg.formCondition, self:_getCurFormation())
		end
	end

	return true
end

function MoonKingMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params and params.groupId and params.stageId then
		MoonKingController.instance:csGetMoonShadowKingChallengeReq(params.challId, params.groupId, params.stageId, params.masterId)

		if params.challId == MoonKingModel.instance.challengeId then
			UIJumper.instance:pushOneStack(ViewName.MoonKingMain, true)
			UIJumper.instance:pushOneStack(ViewName.MoonKingBattle, true, params.challId)
		elseif params.challId == MoonKingModel.instance.pbChallendId then
			UIJumper.instance:pushOneStack(ViewName.PaladinMain, true)
			UIJumper.instance:pushOneStack(ViewName.PaladinBattle, true, params.challId)
		elseif params.challId == MoonKingModel.instance.feinChallengeId then
			UIJumper.instance:pushOneStack(ViewName.FeinChallengeMainView, true)
			UIJumper.instance:pushOneStack(ViewName.FeinChallengeBattleView, true, params.challId)
		elseif params.challId == MoonKingModel.instance.pandoraChanllengeId then
			UIJumper.instance:pushOneStack(ViewName.PandoraMainView, true)
			UIJumper.instance:pushOneStack(ViewName.PandoraBattleView, true, params.challId)
		end
	end
end

return MoonKingMissionView
