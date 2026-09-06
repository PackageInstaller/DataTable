-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/mission/MississiMissionView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.mission.MississiMissionView", package.seeall)

local MississiMissionView = class("MississiMissionView", MissionView)

function MississiMissionView:onExit()
	MississiMissionView.super.onExit(self)
end

function MississiMissionView:onEnter()
	self:onEnterInherit()

	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
	self:onEnterInherit()
end

function MississiMissionView:_getMonsterCo()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local creepCfg = MississiConfig.instance:getCreepsMasterCfg(param.creepsMasterId)

		return creepCfg or {}
	end

	return {}
end

function MississiMissionView:_enterBattle()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local cfg = self.monsterCfg
		local ruleDesc = cfg.WinDesc

		MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)
		BattleFacade.instance:startBattle(GameEnum.MissionType.CYNTHIA)

		local ctrl = MississiController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl))
		MississiController.instance:startChallenge(param.teamId)
	end
end

function MississiMissionView:_isFormationValidatorMatchOnStart()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local cfg = self.monsterCfg

		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(cfg.formCondition, self:_getCurFormation()))
	end

	return true
end

function MississiMissionView:_onFormationChangeFinish()
	MississiMissionView.super._onFormationChangeFinish(self)

	if self.monsterCfg and self.monsterCfg.formCondition then
		local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(self.monsterCfg.formCondition)

		if cfg == nil then
			return
		end

		local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(self.monsterCfg.formCondition, self:_getCurFormation(), true)

		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)

		self._txtValidatorDesc.text = cfg.desc

		self._imgYes:SetActive(isMatch)
		self._imgNo:SetActive(not isMatch)

		return
	end

	self:_initValidatorDesc()
end

function MississiMissionView:_setBtnOneKeyActive()
	if self.monsterCfg and self.monsterCfg.formCondition > 0 then
		return false
	end

	return true
end

return MississiMissionView
