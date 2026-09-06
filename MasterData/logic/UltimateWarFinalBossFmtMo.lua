-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/model/UltimateWarFinalBossFmtMo.lua

module("logic.extensions.ultimatewar.model.UltimateWarFinalBossFmtMo", package.seeall)

local UltimateWarFinalBossFmtMo = class("UltimateWarFinalBossFmtMo", BaseCustomFmtMo)

function UltimateWarFinalBossFmtMo:onReset()
	UltimateWarFinalBossFmtMo.super.onReset(self)
end

function UltimateWarFinalBossFmtMo:updateCfg(activityId, bossId)
	self._activityId = activityId
	self._bossId = bossId
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._bossData = UltimateWarConfig.instance:getBossData(self._activityId, self._bossId)
	self._supportPetPlanId = self._bossData.supportPetPlanId
	self._creepsMasterId = self._bossData.creepsMasterId
	self._masterData = UltimateWarConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = UltimateWarConfig.instance:getCreepsData(self._creepsMasterId)
end

function UltimateWarFinalBossFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:tryInitPetList()

	local removePetIdList = {}
	local levelPetMo = self._ultimateWarMo:getCurLevelPetMo()

	if self._lastLevelPetMoId and levelPetMo and self._lastLevelPetMoId ~= levelPetMo:getPetId() then
		table.insert(removePetIdList, self._lastLevelPetMoId)
	end

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		local cfg = UltimateWarConfig.instance:getSupportCfg(self._lastSupportPetPlanId)

		if cfg then
			for _, data in pairs(cfg) do
				table.insert(removePetIdList, data.creepsId)
			end
		end
	end

	self:tryRemovePetByIds(removePetIdList)

	local newPetMoList = {}

	if levelPetMo and self._lastLevelPetMoId ~= levelPetMo:getPetId() then
		self._lastLevelPetMoId = levelPetMo:getPetId()

		table.insert(newPetMoList, levelPetMo)
	end

	if self._lastSupportPetPlanId ~= self._supportPetPlanId then
		local cfg = UltimateWarConfig.instance:getSupportCfg(self._supportPetPlanId)

		if cfg then
			local fmo = FightingPowerPetMo.New()

			for _, data in pairs(cfg) do
				fmo:fromChallengeCreepCo(data)

				local petMo = fmo:toBaseBagPetMo()

				petMo:setSupportedPet(true)
				table.insert(newPetMoList, petMo)
			end
		end

		self._lastSupportPetPlanId = self._supportPetPlanId
	end

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function UltimateWarFinalBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		UltimateWarController.instance:sendPM_UltimateWarThirdStepFightReq(self._activityId, self._bossId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function UltimateWarFinalBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function UltimateWarFinalBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

return UltimateWarFinalBossFmtMo
