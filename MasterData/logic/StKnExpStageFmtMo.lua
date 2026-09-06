-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/model/StKnExpStageFmtMo.lua

module("logic.extensions.stknexp.model.StKnExpStageFmtMo", package.seeall)

local StKnExpStageFmtMo = class("StKnExpStageFmtMo", BaseCustomFmtMo)

function StKnExpStageFmtMo:updateCfg(activityId, zoneId, stageId)
	self._activityId = activityId
	self._zoneId = zoneId
	self._stageId = stageId

	local stageData = StKnExpConfig.instance:getStageData(self._activityId, self._zoneId, self._stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
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

function StKnExpStageFmtMo:initPetList()
	self:clearAllPetList()
end

function StKnExpStageFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView, ViewName.ItemGet)

		local simpleForm = self:getCurSimpleForm()

		StKnExpController.instance:sendPM_SaintKnightExpeditionChallengeReq(self._activityId, self._zoneId, self._stageId, simpleForm)
	end, nil)
end

function StKnExpStageFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function StKnExpStageFmtMo:getFmtInfoConfig()
	return self._masterData
end

return StKnExpStageFmtMo
