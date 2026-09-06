-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/mission/PerfectRuleModeMissionView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.mission.PerfectRuleModeMissionView", package.seeall)

local PerfectRuleModeMissionView = class("PerfectRuleModeMissionView", MissionView)

function PerfectRuleModeMissionView:onExit()
	PerfectRuleModeMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeDailyRresh, self._onDailyReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeError, self._onError, self)
end

function PerfectRuleModeMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeDailyRresh, self._onDailyReset, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeError, self._onError, self)
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])
	self._ruleShowViewName = params[2]

	if self._challengeId > 0 then
		self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

		if self._curInfo then
			local curCreepId = self._curInfo.curCreepId
			local creepCfg = PerfectRuleModeConfig.instance:getCreepCfgById(curCreepId)

			if creepCfg then
				self:_setDescStr(creepCfg.name)
				self:_setTitleName()
			end
		end
	end
end

function PerfectRuleModeMissionView:_onClickRule()
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	UIStateManager.instance:push(self._commonCfg.passruleview, self._challengeId)
end

function PerfectRuleModeMissionView:_onDailyReset()
	FloatWordMgr.instance:show(lang("挑战已刷新"))
	self:_onClickClose()
end

function PerfectRuleModeMissionView:_onError(status)
	if status == -15201 then
		FloatWordMgr.instance:show(lang("挑战已刷新"))
	else
		printError("进入战斗失败，错误码：" .. status)
	end

	self:_onClickClose()
end

function PerfectRuleModeMissionView:_enterBattle()
	local cfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

	UIJumper.instance:pushOneStack(funcCfg.view, true)
	MissionModel.instance:setRuleDesc(lang("击败敌阵所有精灵即可过关"), self._txtValidatorDesc.text)
	BattleFacade.instance:startPerfectRuleModeChanllenge(self._challengeId)
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightChallengeReq(self._challengeId)
end

function PerfectRuleModeMissionView:_onFormationChangeFinish()
	PerfectRuleModeMissionView.super._onFormationChangeFinish(self)

	local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, self._curInfo.curRuleId)
	local formConditionId = checknumber(ruleCfg and ruleCfg.formConditionId)

	if formConditionId > 0 then
		local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(formConditionId)

		if cfg then
			local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(formConditionId, self:_getCurFormation(), true)

			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)

			self._txtValidatorDesc.text = ruleCfg.missionDesc

			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end

		return
	end

	local perfectWinId = checknumber(ruleCfg and ruleCfg.perfectWinId)

	if perfectWinId > 0 then
		local cfg = PerfectRuleModeConfig.instance:getPerfectWinCfgById(perfectWinId)

		if cfg then
			local isMatch = true
			local winOpType = cfg.type

			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)

			self._txtValidatorDesc.text = ruleCfg.missionDesc

			if winOpType == GameEnum.BattleWinnerOpType.MyPosIdMustActive then
				isMatch = self:_isMatchMyPosIdMustActive(cfg.params)
			elseif winOpType == GameEnum.BattleWinnerOpType.MyActivePetContainsAttrs then
				isMatch = self:_isMatchMyActivePetContainsAttrs(cfg.params)
			elseif winOpType == GameEnum.BattleWinnerOpType.ActiveCount then
				isMatch = self:_isMatchActiveCount(cfg.params)
			elseif winOpType == GameEnum.Evaluate.PosHpRate then
				isMatch = self:_isMatchPosHpRate(cfg.params)
			end

			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end

		return
	end

	self:_initValidatorDesc()
end

function PerfectRuleModeMissionView:_isMatchPosHpRate(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local pos = string.split(params, "_")
	local posId = checknumber(pos[1]) + 1
	local petMo = BagPetsController.instance:getPet(positions[posId])

	if petMo then
		return true
	end

	return false
end

function PerfectRuleModeMissionView:_isMatchActiveCount(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local needPetCount = checknumber(params)

	for i = 1, 9 do
		local petMo = BagPetsController.instance:getPet(positions[i])

		if petMo then
			needPetCount = needPetCount - 1
		end
	end

	return needPetCount <= 0
end

function PerfectRuleModeMissionView:_isMatchMyActivePetContainsAttrs(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local attrs = string.split(params, ",")
	local needPetCount = checknumber(attrs[1])

	table.remove(attrs, 1)

	for i = 1, 9 do
		local petMo = BagPetsController.instance:getPet(positions[i])

		if petMo then
			for _, v in ipairs(attrs) do
				if petMo:checkHasRace(v) then
					needPetCount = needPetCount - 1

					break
				end
			end
		end
	end

	return needPetCount <= 0
end

function PerfectRuleModeMissionView:_isMatchMyPosIdMustActive(params)
	local positions = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
	local posIds = string.splitToNumber(params, ",")

	for _, v in ipairs(posIds) do
		local petMo = BagPetsController.instance:getPet(positions[v + 1])

		if petMo == nil then
			return false
		end
	end

	return true
end

return PerfectRuleModeMissionView
