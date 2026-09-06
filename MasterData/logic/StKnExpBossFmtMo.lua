-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/model/StKnExpBossFmtMo.lua

module("logic.extensions.stknexp.model.StKnExpBossFmtMo", package.seeall)

local StKnExpBossFmtMo = class("StKnExpBossFmtMo", BaseCustomFmtMo)

function StKnExpBossFmtMo:updateCfg(activityId, zoneId, isSimulate)
	self._activityId = activityId
	self._zoneId = zoneId
	self._isSimulate = isSimulate
	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	local zoneData = StKnExpConfig.instance:getZoneData(self._activityId, self._zoneId)
	local creepsMasterId = zoneData.creepsMasterId

	self._masterData = StKnExpConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = StKnExpConfig.instance:getCreepsCfg(creepsMasterId)
	self._oldSupportPetIds = self._oldSupportPetIds or {}
	self._supportPetIdDic = self._subMo:getSupportPetIdDic()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isShowBtnCutePet = false
	self.isOnlyUpdateExistPet = true

	self:clearAllPetList()
	self:tryInitPetList()

	local removePetIdList = {}

	for _, petId in pairs(self._oldSupportPetIds) do
		if not self._supportPetIdDic[petId] then
			table.insert(removePetIdList, petId)

			self._oldSupportPetIds[petId] = nil
		end
	end

	self._fmo = self._fmo or FightingPowerPetMo.New()

	local newPetMoList = {}

	for _, petId in pairs(self._supportPetIdDic) do
		if not self._oldSupportPetIds[petId] or self:getPetMoById(petId) == nil then
			self._oldSupportPetIds[petId] = petId

			local data = StKnExpConfig.instance:getSupportData(activityId, petId)

			self._fmo:fromChallengeCreepCo(data)

			local petMo = self._fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)

			petMo = StKnExpController.instance:updatePetByCult(activityId, petMo)

			table.insert(newPetMoList, petMo)
		end
	end

	self:tryRemovePetByIds(removePetIdList)

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function StKnExpBossFmtMo:initPetList()
	self:clearAllPetList()
end

function StKnExpBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView, ViewName.ItemGet)

		local simpleForm = self:getCurSimpleForm()
		local saintKnightBuffIds = self._subMo:getSelectBuffsInZone(self._zoneId)

		StKnExpController.instance:sendPM_SaintKnightExpeditionBossChallengeReq(self._activityId, self._zoneId, self._isSimulate, simpleForm, saintKnightBuffIds)
	end, nil)
end

function StKnExpBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function StKnExpBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

return StKnExpBossFmtMo
