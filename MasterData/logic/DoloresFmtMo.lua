-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/model/DoloresFmtMo.lua

module("logic.extensions.doloresclg.model.DoloresFmtMo", package.seeall)

local DoloresFmtMo = class("DoloresFmtMo", BaseCustomFmtMo)

function DoloresFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._actCfg = DoloresConfig.instance:getActCfg(self.activityId) or {}

	local phaseCfg = DoloresConfig.instance:getPhaseById(activityId, phaseId) or {}
	local stagePlanId = phaseCfg.stagePlanId
	local stageCfg = DoloresConfig.instance:getStageById(stagePlanId, stageId)

	self.creepsMasterId = stageCfg.creepsMasterId
	self.masterCfg = DoloresConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = DoloresConfig.instance:getCreepsCfgs(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DoloresFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
	self.validatorDescStr = self._actCfg.posBuffDesc

	if not stageCfg.posList then
		self:clearAllFixedEffects()

		for _, posId in ipairs(stageCfg.posList) do
			self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
		end

		local info = DoloresModel.instance:getInfo(self.activityId) or {}

		if not info.curStageInfos then
			local curStageInfos = {}

			self._lockRaceMap = {}

			for i, v in ipairs(curStageInfos) do
				if v.lockAttrTypes then
					for j, race in ipairs(v.lockAttrTypes) do
						local raceIdx = GameEnum.Races[race]

						self._lockRaceMap[raceIdx] = true
					end
				end
			end
		end
	end
end

function DoloresFmtMo:getMonsterConfigList()
	return self.creeps
end

function DoloresFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DoloresFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DoloresController.instance:sendStartFight(self.activityId, self.phaseId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

return DoloresFmtMo
