-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/model/DivineTianShanNormalFmtMo.lua

module("logic.extensions.divinetianshanclg.model.DivineTianShanNormalFmtMo", package.seeall)

local DivineTianShanNormalFmtMo = class("DivineTianShanNormalFmtMo", BaseCustomFmtMo)

function DivineTianShanNormalFmtMo:initParams(activityId, stageId, isPractice)
	self._activityId = activityId
	self._stageId = stageId
	self._isPractice = isPractice
	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._normalCfg = DivineTianShanClgConfig.instance:getNormalClgPlanCfg(self._actCfg.normalClgPlanId)
	self._stageCfgs = DivineTianShanClgConfig.instance:getNormalStagePlanCfgs(self._normalCfg.stagePlanId)
	self._curStageCfg = self._stageCfgs[self._stageId]
	self._masterData = DivineTianShanClgConfig.instance:getTeamCfg(self._curStageCfg.creepsMasterId)
	self._creepsCfg = DivineTianShanClgConfig.instance:getCreepCfgs(self._curStageCfg.creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	self.useMaxFightPower = true

	self:clearAllPetList()
end

function DivineTianShanNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineTianShanClgController.instance:startNormalFight(self._activityId, self._stageId, self._isPractice, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineTianShanNormalFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineTianShanNormalFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineTianShanNormalFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineTianShanNormalFmtMo
