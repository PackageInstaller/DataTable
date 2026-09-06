-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/model/UltimateWarTowerStageFmtMo.lua

module("logic.extensions.ultimatewar.model.UltimateWarTowerStageFmtMo", package.seeall)

local UltimateWarTowerStageFmtMo = class("UltimateWarTowerStageFmtMo", BaseCustomFmtMo)

function UltimateWarTowerStageFmtMo:onReset()
	UltimateWarTowerStageFmtMo.super.onReset(self)
end

function UltimateWarTowerStageFmtMo:updateCfg(activityId, towerId)
	self._activityId = activityId
	self._towerId = towerId
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)

	local towerData = UltimateWarConfig.instance:getTowerData(activityId, towerId)
	local stageData = UltimateWarConfig.instance:getStageData(self._activityId, self._towerId, 1)

	self._supportPetPlanId = towerData.supportPetPlanId
	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = UltimateWarConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = UltimateWarConfig.instance:getCreepsData(self._creepsMasterId)
end

function UltimateWarTowerStageFmtMo:updateData()
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

function UltimateWarTowerStageFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		UltimateWarController.instance:sendPM_UltimateWarTowerFightReq(self._activityId, self._towerId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function UltimateWarTowerStageFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function UltimateWarTowerStageFmtMo:getFmtInfoConfig()
	return self._masterData
end

return UltimateWarTowerStageFmtMo
