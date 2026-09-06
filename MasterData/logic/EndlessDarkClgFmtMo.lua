-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/model/EndlessDarkClgFmtMo.lua

module("logic.extensions.endlessdark.model.EndlessDarkClgFmtMo", package.seeall)

local EndlessDarkClgFmtMo = class("EndlessDarkClgFmtMo", BaseCustomFmtMo)

function EndlessDarkClgFmtMo:updateCfg(activityId, waveId, stageId)
	self._activityId = checknumber(activityId)
	self._waveId = checknumber(waveId)
	self._stageId = checknumber(stageId)

	local stageCfg = EndlessDarkClgConfig.instance:getWaveCfgsByStageId(activityId, waveId, stageId)

	self._creepsMasterId = EndlessDarkClgConfig.instance:getCreepMasterId(activityId, waveId, stageId)
	self._masterData = EndlessDarkClgConfig.instance:getCreepMasterCfg(self._creepsMasterId) or {}
	self._creepsCfg = EndlessDarkClgConfig.instance:getCreepsCfg(self._creepsMasterId) or {}
	self._supportCfg = EndlessDarkClgConfig.instance:getSupportPetCfg(activityId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function EndlessDarkClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		EndlessDarkClgController.instance:sendPM_EndlessDarkClgStartFightReq(self._activityId, simpleForm)
	end, nil)
end

function EndlessDarkClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function EndlessDarkClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function EndlessDarkClgFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, supportCfg in pairs(self._supportCfg) do
		fMo:fromChallengeCreepCo(supportCfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

return EndlessDarkClgFmtMo
