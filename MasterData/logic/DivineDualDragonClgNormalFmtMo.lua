-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/model/DivineDualDragonClgNormalFmtMo.lua

module("logic.extensions.divinedualdragonclg.model.DivineDualDragonClgNormalFmtMo", package.seeall)

local DivineDualDragonClgNormalFmtMo = class("DivineDualDragonClgNormalFmtMo", BaseCustomFmtMo)

function DivineDualDragonClgNormalFmtMo:initParams(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._activityType = DivineDualDragonClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(activityId)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(activityCfg.phasePlanId, phaseId)
	local stageCfg = DivineDualDragonClgConfig.instance:getStageCfg(phaseCfg.stagePlanId, stageId)

	self._cfgEnemy = DivineDualDragonClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = DivineDualDragonClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function DivineDualDragonClgNormalFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineDualDragonClgAgent.instance:sendPM_DivineDualDragonClgChallengeReq(self._activityId, self._phaseId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineDualDragonClgNormalFmtMo:_changePetMo(petMo)
	return petMo
end

function DivineDualDragonClgNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineDualDragonClgNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DivineDualDragonClgNormalFmtMo
