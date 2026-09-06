-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanMissionView.lua

module("logic.extensions.mangtower.view.MoyanMissionView", package.seeall)

local MoyanMissionView = class("MoyanMissionView", MissionView)

function MoyanMissionView:onEnter()
	self:onEnterInherit()

	self.currRaceIdx = 0
	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
	FastFormation.instance:setCurFormFunc(function()
		local params = self._viewPresentor:getFirstParam()

		return MoyanController.instance:GetCurFormation(params)
	end)
	FastFormation.instance:setGetCurPetList(function()
		local params = self._viewPresentor:getFirstParam()

		return MoyanController.instance:getPetListInMission(params)
	end)
end

function MoyanMissionView:_getPet(id)
	local list = self:getAllShowPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			return v
		end
	end
end

function MoyanMissionView:getAllShowPetList()
	local params = self._viewPresentor:getFirstParam()

	return MoyanController.instance:getPetListInMission(params)
end

function MoyanMissionView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type

		self.type = type

		local stageId = params.stageId
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)
		local stagePlan = cfg.stagePlan

		return (MoyanConfig.instance:getMonsterCfg(stagePlan, stageId))
	end

	return {}
end

function MoyanMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self))
	MissionModel.instance:setForceResetOneKey(false)
end

function MoyanMissionView:notFilterPet(petMo)
	local params = self._viewPresentor:getFirstParam()
	local hpVal = MoyanController.instance:getPetHpById(params, petMo.petId)

	if hpVal <= 0 then
		return false
	end

	return true
end

function MoyanMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()
	local challengeId = 0
	local type = 0

	if params then
		challengeId = params.challengeId
		type = params.type

		local cfg = TimeLimitedConfig.instance:getCfgById(params.challengeId)

		if cfg then
			local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

			if funcCfg and not string.nilorempty(funcCfg.view) then
				UIJumper.instance:pushOneStack(funcCfg.view, true)
			end
		end

		local ctrl = MoyanController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, challengeId, type, params.stageId))

		local cfg = self.monsterCfg
		local ruleDesc = cfg.WinDesc

		MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)
		BattleFacade.instance:startBattle(GameEnum.MissionType.LONG_NV)
		LongnvModel.instance:setCurrMonsterCfg(nil)
		TLChallengeController.instance:setMissionParams(nil)

		if type == MoyanModel.TYPE_3 then
			local params = {
				showBossHp = true,
				challengeId = challengeId,
				monsterCfg = self.monsterCfg
			}

			TLChallengeController.instance:setMissionParams(params)

			local mo = MoyanModel.instance:getSingleInfo(challengeId, type)

			if not mo.bossDamageTypeInfo then
				local bossDamageTypeInfo = {}
				local bossMaxHp = checknumber(bossDamageTypeInfo.bossMaxHp)
				local bossCurHp = checknumber(bossDamageTypeInfo.bossCurHp)
				local info = {}

				info.maxProgress = bossMaxHp
				info.totalDamage = 0
				info.lastDamage = bossMaxHp - bossCurHp

				TLChallengeModel.instance:setFightInfo(challengeId, info)
				TLChallengeController.instance:startChallenge(challengeId)
			end
		end

		local fmo

		if type == MoyanModel.TYPE_1 then
			local params = self._viewPresentor:getFirstParam()

			fmo = MoyanController.instance:GetCurFormation(params)
		end

		MoyanController.instance:sendFight(challengeId, type, params.stageId, fmo)
	end
end

function MoyanMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	local params = self._viewPresentor:getFirstParam()
	local fmt = MoyanController.instance:GetCurFormation(params)

	return FormationFacade.instance:checkFormationEmptyAndPosNumLimitByFmo(fmt, callback, hasOneKey, onekeyCallBack)
end

function MoyanMissionView:_isCurFormationEmpty()
	local params = self._viewPresentor:getFirstParam()
	local fmt = MoyanController.instance:GetCurFormation(params)
	local empty = true

	for i = 1, 9 do
		local petId = fmt:GetPosition(i)

		if checknumber(petId) > 0 then
			empty = false
		end
	end

	return empty
end

return MoyanMissionView
