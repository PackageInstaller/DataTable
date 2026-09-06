-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/model/EternalCityStageClgFmtMo.lua

module("logic.extensions.eternalcity.model.EternalCityStageClgFmtMo", package.seeall)

local EternalCityStageClgFmtMo = class("EternalCityStageClgFmtMo", BaseCustomFmtMo)

function EternalCityStageClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = EternalCityConfig.instance:getStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._masterData = EternalCityConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = EternalCityConfig.instance:getCreepsDatas(creepsMasterId)
	self._supportCfg = EternalCityConfig.instance:getSupportPetDatas(self._activityId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isOnlyUpdateExistPet = true
	self._fmo = self._fmo or FightingPowerPetMo.New()

	self:tryInitPetList()

	local currentCreepsMap = {}

	for _, data in pairs(self._supportCfg or {}) do
		local creepsId = data.creepsId
		local totalNum = self._subMo:getCreepsNum(creepsId)
		local inPlaceNum = self._subMo:getCreepsNumInPlace(creepsId)
		local availableNum = totalNum - inPlaceNum

		if availableNum > 0 then
			currentCreepsMap[creepsId] = data
		end
	end

	local removePetIdList = {}

	if self._rightPetList then
		for _, petMo in ipairs(self._rightPetList) do
			if petMo.isSupportedPet then
				local creepsId = petMo:getDefineId()

				if not currentCreepsMap[creepsId] then
					table.insert(removePetIdList, petMo.petId)
				end
			end
		end
	end

	self:tryRemovePetByIds(removePetIdList)

	local newPetMoList = {}

	for creepsId, data in pairs(currentCreepsMap) do
		local exists = false

		if self._rightPetMap then
			for _, petMo in pairs(self._rightPetMap) do
				if petMo.isSupportedPet and petMo:getDefineId() == creepsId then
					exists = true

					break
				end
			end
		end

		if not exists then
			local fmo = self._fmo

			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			table.insert(newPetMoList, petMo)
		end
	end

	for _, petMo in ipairs(newPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function EternalCityStageClgFmtMo:initPetList()
	self:clearAllPetList()

	for _, data in pairs(self._supportCfg or {}) do
		local creepsId = data.creepsId
		local totalNum = self._subMo:getCreepsNum(creepsId)
		local inPlaceNum = self._subMo:getCreepsNumInPlace(creepsId)
		local availableNum = totalNum - inPlaceNum

		if availableNum > 0 then
			local fmo = self._fmo

			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function EternalCityStageClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		EternalCityController.instance:sendPM_EternalCityStageClgReq(self._activityId, simpleForm, self._stageId)
	end, nil)
end

function EternalCityStageClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function EternalCityStageClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return EternalCityStageClgFmtMo
