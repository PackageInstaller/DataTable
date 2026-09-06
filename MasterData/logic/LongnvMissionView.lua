-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/mission/LongnvMissionView.lua

module("logic.extensions.mangtower.view.LongnvMissionView", package.seeall)

local LongnvMissionView = class("LongnvMissionView", MissionView)

function LongnvMissionView:onEnter()
	self:onEnterInherit()

	self.type = 0
	self.stageId = 0
	self.currRaceIdx = 0
	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
end

function LongnvMissionView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type
		local stageId = params.stageId

		self.type = type
		self.stageId = stageId

		if type == LongnvModel.TYPE_3 then
			local stageId = params.stageId

			self.currRaceIdx = GameEnum.RaceType.Shui

			if stageId == 2 then
				self.currRaceIdx = GameEnum.RaceType.An
			end
		end

		local planId = LongnvModel.instance:getPlanId()
		local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
		local monsterPlan = checknumber(cfg.monsterPlan)
		local monsterList = LongnvConfig.instance:getMonsterListCfg(type, monsterPlan) or {}

		return monsterList[stageId]
	end

	return {}
end

function LongnvMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self))
	MissionModel.instance:setForceResetOneKey(false)
end

function LongnvMissionView:notFilterPet(petMo)
	if self.currRaceIdx ~= 0 then
		return PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, self.currRaceIdx)
	end

	return true
end

function LongnvMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local challengeId = params.challengeId
		local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

		if cfg then
			local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

			if funcCfg and not string.nilorempty(funcCfg.view) then
				UIJumper.instance:pushOneStack(funcCfg.view, true)
			end
		end

		local cfg = self.monsterCfg
		local ruleDesc = cfg.WinDesc

		MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)
		BattleFacade.instance:startBattle(GameEnum.MissionType.LONG_NV)
		LongnvModel.instance:setCurrMonsterCfg(cfg)

		local ctrl = LongnvController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, self.type, self.stageId))
		TLChallengeController.instance:setMissionParams(nil)

		if self.type == LongnvModel.TYPE_3 then
			local params = {
				showBossHp = true,
				challengeId = challengeId,
				monsterCfg = self.monsterCfg
			}

			TLChallengeController.instance:setMissionParams(params)

			local planId = LongnvModel.instance:getPlanId()
			local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
			local info = {}

			info.maxProgress = cfg.bossHP
			info.totalDamage = 0
			info.lastDamage = cfg.bossHP - LongnvModel.instance.bossHP

			TLChallengeModel.instance:setFightInfo(challengeId, info)
			TLChallengeController.instance:startChallenge(challengeId)
		end

		LongnvController.instance:sendFight(self.type, self.stageId)
	end
end

return LongnvMissionView
