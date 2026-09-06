-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/formation/SRMissionView.lua

module("logic.extensions.sunranbattle.view.formation.SRMissionView", package.seeall)

local SRMissionView = class("SRMissionView", MissionView)

function SRMissionView:ctor()
	SRMissionView.super.ctor(self)
end

function SRMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(true)
end

function SRMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = SunranBattleConfig.instance:getMasterTeamCfg(params.masterId)
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

function SRMissionView:_onFormationChangeFinish()
	AnheimmMissionView.super._onFormationChangeFinish(self)

	local params = self._viewPresentor:getFirstParam()

	if params and params.conList and #params.conList > 0 then
		for i = 1, #params.conList do
			local id = checknumber(params.conList[i])
			local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(id)

			if cfg and id > 0 then
				local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(id, self:_getCurFormation(), true)

				goutil.setActive(self._topDesc.gameObject, true)
				goutil.setActive(self._txtValidatorDesc.gameObject, true)

				self._txtValidatorDesc.text = cfg.desc

				self._imgYes:SetActive(isMatch)
				self._imgNo:SetActive(not isMatch)
			end
		end

		return
	end

	self:_initValidatorDesc()
end

function SRMissionView:_isFormationValidatorMatchOnStart()
	local params = self._viewPresentor:getFirstParam()

	if params and params.conList and #params.conList > 0 then
		for i = 1, #params.conList do
			local id = checknumber(params.conList[i])
			local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(id, self:_getCurFormation())

			if not isMatch then
				return false
			end
		end
	end

	return true
end

function SRMissionView:_enterBattle()
	SunranBattleModel.instance:setCacheStageBuffInfo(nil)

	local params = self._viewPresentor:getFirstParam()

	if params and params.stageId then
		SunranBattleController.instance:csDarkDragonChallengeReq(params.stageId, params.groupList)
		UIJumper.instance:pushOneStack(ViewName.SunranBattle, true)
	end
end

return SRMissionView
