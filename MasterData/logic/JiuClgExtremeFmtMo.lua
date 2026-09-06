-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/model/JiuClgExtremeFmtMo.lua

module("logic.extensions.jiuclg.model.JiuClgExtremeFmtMo", package.seeall)

local JiuClgExtremeFmtMo = class("JiuClgExtremeFmtMo", BaseCustomFmtMo)

function JiuClgExtremeFmtMo:initParams(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._activityType = JiuClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local cfgStage = JiuClgConfig.instance:getExtremeStageCfg(activityId, phaseId, stageId)
	local creepsMasterId = cfgStage.creepsMasterId

	self._monsterCfg = JiuClgConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = JiuClgConfig.instance:getCreeps(creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = "JiuClgExtremeFmtMo_" .. self._activityId .. "_" .. self._phaseId .. "_" .. self._stageId
end

function JiuClgExtremeFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()
		local curFmt = self:getCurFormation()
		local posList = curFmt:GetPositions()

		JiuClgController.instance:sendPM_JiuClgExtremeFightReq(self._activityId, self._phaseId, self._stageId, form, posList)
	end

	self:setFightHandler(handler, nil)
end

function JiuClgExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function JiuClgExtremeFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function JiuClgExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	return JiuClgModel.instance:isExtremeLockPet(self._activityId, self._stageId, petMo.raceId)
end

function JiuClgExtremeFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show(string.format("%s已上阵过,请使用其他精灵破阵", petMo.name))
end

return JiuClgExtremeFmtMo
