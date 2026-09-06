-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/model/UltimateWarTowerBossFmtMo.lua

module("logic.extensions.ultimatewar.model.UltimateWarTowerBossFmtMo", package.seeall)

local UltimateWarTowerBossFmtMo = class("UltimateWarTowerBossFmtMo", BaseCustomFmtMo)

function UltimateWarTowerBossFmtMo:onReset()
	UltimateWarTowerBossFmtMo.super.onReset(self)
end

function UltimateWarTowerBossFmtMo:updateCfg(activityId)
	self._activityId = activityId
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._supportPetPlanId = UltimateWarConfig.instance:getTowerBossSupportPetPlanId(self._activityId)
	self._creepsMasterId = UltimateWarConfig.instance:getTowerBossCreepsMasterId(self._activityId)
	self._masterData = UltimateWarConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = UltimateWarConfig.instance:getCreepsData(self._creepsMasterId)
end

function UltimateWarTowerBossFmtMo:updateData()
	self.showBtnVideo = true
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

	local info = self._ultimateWarMo:popRecordSimpleTemp()

	if info then
		local formationMo = self:getCurFormation()
		local raceIds = {}

		for posId, petId in ipairs(info.form.pos) do
			for _, v in ipairs(info.petInfos) do
				if v.petId == petId then
					raceIds[posId] = v.raceId

					break
				end
			end
		end

		local positions = {}

		for posId = 1, 9 do
			local targetRaceId = checknumber(raceIds[posId])
			local fitPetMo

			if targetRaceId > 0 then
				for i, petMo in ipairs(self._rightPetList) do
					if petMo:getDefineId() == targetRaceId then
						if fitPetMo == nil then
							fitPetMo = petMo
						elseif petMo:getFightingPower() > fitPetMo:getFightingPower() then
							fitPetMo = petMo
						end
					end
				end
			end

			positions[posId] = fitPetMo and fitPetMo:getPetId() or 0
		end

		formationMo:setPositionForce(positions, true)
	end
end

function UltimateWarTowerBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		UltimateWarController.instance:sendPM_UltimateWarTowerBossFightReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function UltimateWarTowerBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function UltimateWarTowerBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function UltimateWarTowerBossFmtMo:sendVideoMsg()
	UIStateManager.instance:push(ViewName.UltimateWarTowerRecordView, self._activityId)
end

return UltimateWarTowerBossFmtMo
