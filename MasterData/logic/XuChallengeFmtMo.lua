-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/model/XuChallengeFmtMo.lua

module("logic.extensions.xuchallenge.model.XuChallengeFmtMo", package.seeall)

local XuChallengeFmtMo = class("XuChallengeFmtMo", ICustomFmtMo)

function XuChallengeFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._subMo = XuChallengeController.instance:getSubMo(activityId)

	local stageData = XuChallengeConfig.instance:getStageData(activityId, stageId)

	self._masterData = XuChallengeConfig.instance:getMasterData(stageData.creepsMasterId)
	self._creepsDatas = XuChallengeConfig.instance:getCreepsDatas(stageData.creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition or 0)
	self._subMo:ensurePreviewStageToRaceIds(stageId)
	self:_refreshEffectiveRaceIdMap()
	self:clearAllPetList()
	self:_clearInvalidFormationPets()
end

function XuChallengeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local stageToPetId = self:_buildStageToPetIdPairsByPreviewSacrifice()

		XuChallengeController.instance:sendPM_XuChallengeClgReq(self._activityId, self._stageId, stageToPetId, simpleForm)
	end, nil)
end

function XuChallengeFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local isValid, tips = self:_checkCanStartFight()

	if not isValid then
		FloatWordMgr.instance:show(tips)

		return true
	end

	return XuChallengeFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function XuChallengeFmtMo:getMonsterConfigList()
	return self._creepsDatas
end

function XuChallengeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function XuChallengeFmtMo:getActivityId()
	return self._activityId
end

function XuChallengeFmtMo:getStageId()
	return self._stageId
end

function XuChallengeFmtMo:getExtendViewName()
	return ViewName.XuChallengeFmtExView
end

function XuChallengeFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		if self:_isEffectiveRaceIdPetMo(petMo) then
			self:addPetToList(petMo)
		end
	end
end

function XuChallengeFmtMo:refreshPetList(changePetMoMap)
	for _, petMo in pairs(changePetMoMap or {}) do
		if self:_isEffectiveRaceIdPetMo(petMo) then
			self:updatePetMo(petMo)
		else
			self:tryRemovePetByIds(petMo and petMo.petId)
		end
	end
end

function XuChallengeFmtMo:refreshPreviewSacrificeState()
	self:_refreshEffectiveRaceIdMap()
	self:initPetList()
	self:_clearInvalidFormationPets()
	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function XuChallengeFmtMo:clearChallengeCache()
	self:clearAllPetList()
	self:_clearFormationPets()

	self._effectiveRaceIdMap = {}
end

function XuChallengeFmtMo:onFilterPetShow(petMo)
	return self:_isEffectiveRaceIdPetMo(petMo)
end

function XuChallengeFmtMo:_clearFormationPets()
	local formationMo = self:getCurFormation()
	local positions = formationMo:GetPositions()
	local hasChanged = false

	for pos, petId in ipairs(positions) do
		if checknumber(petId) > 0 then
			formationMo:SetPosition(pos, 0, true)

			hasChanged = true
		end
	end

	if hasChanged then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end
end

function XuChallengeFmtMo:_clearInvalidFormationPets()
	local formationMo = self:getCurFormation()
	local positions = formationMo:GetPositions()
	local hasChanged = false

	for pos, petId in ipairs(positions) do
		if checknumber(petId) > 0 then
			local petMo = BagPetsController.instance:getPet(petId)

			if not self:_isEffectiveRaceIdPetMo(petMo) then
				formationMo:SetPosition(pos, 0, true)

				hasChanged = true
			end
		end
	end

	if hasChanged then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end
end

function XuChallengeFmtMo:_checkCanStartFight()
	local _, missingRaceId = self:_buildStageToPetIdPairsByPreviewSacrifice()

	if checknumber(missingRaceId) > 0 then
		return false, "绑定精灵状态已变化，请重新选择"
	end

	return true
end

function XuChallengeFmtMo:_buildStageToPetIdPairsByPreviewSacrifice()
	self:_refreshEffectiveRaceIdMap()

	local result = {}
	local raceIdToPetId = self:_buildEffectiveRaceIdToPetId()

	for _, data in ipairs(self._subMo:getPreviewStageToRaceIds() or {}) do
		local stageId = checknumber(data.stageId)
		local raceId = checknumber(data.raceId)
		local bindRaceId = checknumber(self._subMo:getBindRaceId(stageId))

		if stageId > 0 and raceId > 0 and raceId ~= bindRaceId then
			local petId = checknumber(raceIdToPetId[raceId])

			if petId <= 0 then
				return result, raceId
			end

			table.insert(result, {
				stageId = stageId,
				petId = petId
			})
		end
	end

	return result
end

function XuChallengeFmtMo:_buildEffectiveRaceIdToPetId()
	local result = self:_buildFormationRaceIdToPetId()

	for _, data in ipairs(self._subMo:getServerStageToPetIds() or {}) do
		local petId = checknumber(data.petId)
		local petMo = BagPetsController.instance:getPet(petId)
		local raceId = self:_getPetRaceId(petMo)

		if raceId > 0 and self:_isEffectiveRaceIdPetMo(petMo) and result[raceId] == nil then
			result[raceId] = petId
		end
	end

	for _, petMo in ipairs(BagPetsController.instance:getFightBagPet() or {}) do
		local raceId = self:_getPetRaceId(petMo)
		local petId = self:_getPetId(petMo)

		if raceId > 0 and petId > 0 and self:_isEffectiveRaceIdPetMo(petMo) and result[raceId] == nil then
			result[raceId] = petId
		end
	end

	return result
end

function XuChallengeFmtMo:_buildFormationRaceIdToPetId()
	local result = {}
	local positions = self:getCurFormation():GetPositions()

	for _, petId in ipairs(positions) do
		petId = checknumber(petId)

		if petId > 0 then
			local petMo = BagPetsController.instance:getPet(petId)
			local raceId = self:_getPetRaceId(petMo)

			if raceId > 0 and self:_isEffectiveRaceIdPetMo(petMo) and result[raceId] == nil then
				result[raceId] = petId
			end
		end
	end

	return result
end

function XuChallengeFmtMo:_getPetRaceId(petMo)
	if petMo == nil then
		return 0
	end

	local raceId = checknumber(petMo.raceId)

	if raceId <= 0 and petMo.getDefineId then
		raceId = checknumber(petMo:getDefineId())
	end

	return raceId
end

function XuChallengeFmtMo:_getPetId(petMo)
	if petMo == nil then
		return 0
	end

	local petId = checknumber(petMo.petId)

	if petId <= 0 and petMo.getId then
		petId = checknumber(petMo:getId())
	end

	return petId
end

function XuChallengeFmtMo:_isEffectiveRaceIdPetMo(petMo)
	if petMo == nil then
		return false
	end

	if self._effectiveRaceIdMap == nil then
		return false
	end

	return self._effectiveRaceIdMap[self:_getPetRaceId(petMo)] == true
end

function XuChallengeFmtMo:_refreshEffectiveRaceIdMap()
	self._effectiveRaceIdMap = self:_buildEffectiveRaceIdMap()
end

function XuChallengeFmtMo:_buildEffectiveRaceIdMap()
	local result = {}

	for _, stageId in ipairs(self._subMo:getStageIds()) do
		local raceId = checknumber(self._subMo:getEffectiveRaceIdByStageId(stageId))

		if raceId > 0 then
			result[raceId] = true
		end
	end

	return result
end

return XuChallengeFmtMo
