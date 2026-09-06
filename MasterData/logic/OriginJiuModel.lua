-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/model/OriginJiuModel.lua

module("logic.extensions.originjiu.model.OriginJiuModel", package.seeall)

local OriginJiuModel = class("OriginJiuModel", BaseModel)

OriginJiuModel.ModelId_Ext = 1
OriginJiuModel.ModelId_Nor = 2
OriginJiuModel.PHASE_MODE_1 = 1
OriginJiuModel.PHASE_MODE_2 = 2
OriginJiuModel.PHASE_MODE_3 = 3
OriginJiuModel.ClgType_Common = "COMMON"
OriginJiuModel.ClgType_Wheel = "WHEEL"
OriginJiuModel.ClgType_LockPet = "LOCK_PET"
OriginJiuModel.StageRoad_A = 1
OriginJiuModel.StageRoad_B = 2

function OriginJiuModel:onInit()
	self:onReset()
end

function OriginJiuModel:onReset()
	self._msgPool = {}
	self._commonfmtMoPool = {}
	self._bossFmtMoPool = {}
	self._fightResultMsg = nil
	self._tabfmtMoPool = {}
	self._lockPetIdMap = {}
	self._lockRaceiDMap = {}
	self._missionSortList = {}
	self._changeSetId = nil
end

function OriginJiuModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg) or {}
	self._lockPetMap = {}
end

function OriginJiuModel:handlePM_NotifyOriginJiuClgChallengeFinishRes(msg)
	self._fightResultMsg = msg

	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId
	end
end

function OriginJiuModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function OriginJiuModel:getInfoByModelId(activityId, modelId)
	local info = self._msgPool[activityId]

	if info then
		for i, model in ipairs(info.models or {}) do
			if model.modelId == modelId then
				return model
			end
		end
	end
end

function OriginJiuModel:getFightResultMsg()
	return self._fightResultMsg
end

function OriginJiuModel:setSortList(activityId, list)
	self._missionSortList[activityId] = list
end

function OriginJiuModel:getSortList(activityId)
	self._missionSortList[activityId] = self._missionSortList[activityId] or {
		1,
		2,
		3
	}

	return self._missionSortList[activityId]
end

function OriginJiuModel:getStageClgType(activityId, modelId, phaseId)
	local data = OriginJiuConfig.instance:getPhaseData(activityId, modelId, phaseId)

	return data and data.type
end

function OriginJiuModel:getCommonFmtMo(activityId)
	if self._commonfmtMoPool[activityId] == nil then
		self._commonfmtMoPool[activityId] = OriginJiuCommonFmtMo.New()
	end

	return self._commonfmtMoPool[activityId]
end

function OriginJiuModel:isHasHistoryPassModelId(activityId, modelId)
	return self:hadGainBossPrize(activityId, modelId)
end

function OriginJiuModel:getCurrentChallengePhaseId(activityId, modelId)
	local result = 0
	local datass = OriginJiuConfig.instance:getStageDatass(activityId, modelId)

	for phaseId, datas in ipairs(datass or {}) do
		for stageId, v in ipairs(datas) do
			local isPass = self:isPassStage(activityId, modelId, phaseId, stageId)

			if not isPass then
				if stageId > 1 then
					result = phaseId
				end

				break
			end
		end

		if result ~= 0 then
			break
		end
	end

	return result
end

function OriginJiuModel:isPassPhase(activityId, modelId, phaseId)
	local result = false
	local info = self:getPhaseInfo(activityId, modelId, phaseId)
	local datas = OriginJiuConfig.instance:getStageDatas(activityId, modelId, phaseId)

	if datas then
		result = true

		for stageId, v in ipairs(datas) do
			local isPass = self:isPassStage(activityId, modelId, phaseId, stageId)

			if not isPass then
				result = false

				break
			end
		end
	end

	return result
end

function OriginJiuModel:isPassStage(activityId, modelId, phaseId, stageId)
	local info = self:getStageInfo(activityId, modelId, phaseId, stageId)

	return info ~= nil
end

function OriginJiuModel:isPhaseGainedPrize(activityId, modelId, phaseId)
	local info = self:getPhaseInfo(activityId, modelId, phaseId)

	return (info or nil) and (info.gainedPrize or false)
end

function OriginJiuModel:getStageInfo(activityId, modelId, phaseId, stageId)
	local info = self:getPhaseInfo(activityId, modelId, phaseId)

	if not info then
		return nil
	end

	for _, stage in ipairs(info.stages or {}) do
		if stage.stageId == stageId then
			return stage
		end
	end

	return nil
end

function OriginJiuModel:getPhaseInfo(activityId, modelId, phaseId)
	local info = self:getInfoByModelId(activityId, modelId)

	if not info then
		return nil
	end

	for _, phase in ipairs(info.phases or {}) do
		if phase.phaseId == phaseId then
			return phase
		end
	end

	return nil
end

function OriginJiuModel:isEnoughBoss(activityId, modelId)
	local result = false
	local info = self:getInfoByModelId(activityId, modelId)

	if info then
		local datas = OriginJiuConfig.instance:getPhaseDatas(activityId, modelId)

		if datas and #datas > 0 then
			result = true

			for phaseId, v in ipairs(datas) do
				local isPassPhase = self:isPassPhase(activityId, modelId, phaseId)

				if not isPassPhase then
					result = false

					break
				end
			end
		end
	end

	return result
end

function OriginJiuModel:isKilledBoss(activityId, modelId)
	local info = self:getInfoByModelId(activityId, modelId)

	if info then
		return (info or nil) and (info.hadKilledBoss or false)
	end

	return false
end

function OriginJiuModel:hadGainBossPrize(activityId, modelId)
	local info = self:getInfoByModelId(activityId, modelId)

	return (info or nil) and (info.hadGainBossPrize or false)
end

function OriginJiuModel:getBossFmtMo(activityId)
	if self._bossFmtMoPool[activityId] == nil then
		self._bossFmtMoPool[activityId] = OriginJiuBossFmtMo.New()
	end

	return self._bossFmtMoPool[activityId]
end

function OriginJiuModel:getTabFmtMo(activityId)
	if self._tabfmtMoPool[activityId] == nil then
		self._tabfmtMoPool[activityId] = OriginJiuTabFmtMo.New()
	end

	return self._tabfmtMoPool[activityId]
end

function OriginJiuModel:resetAllPetLockState(activityId, modelId)
	self._lockPetIdMap = {}
	self._lockRaceiDMap = {}
	self._petHpMap = {}

	local model = self:getInfoByModelId(activityId, modelId)

	if model then
		for i, phase in ipairs(model.phases or {}) do
			if phase.wheelInfo then
				if not phase.wheelInfo.wheelTeam then
					local wheelTeam = {}

					for k, team in ipairs(wheelTeam) do
						for l, pet in ipairs(team.pets or {}) do
							local petId = pet.petId

							if pet.leftHp == 0 then
								self._lockPetIdMap[petId] = true
							end

							local petMo = BagPetsController.instance:getPet(petId)

							if petMo and petMo._maxHp > 0 then
								if not petMo._maxHp then
									local maxHp = 0
									local hpRate = 0

									if pet.leftHp < 0 then
										hpRate = 1
									else
										hpRate = maxHp > 0 and checknumber(pet.leftHp / maxHp) or 0
										hpRate = Mathf.Clamp(hpRate, 0, 1)
									end

									self._petHpMap[petId] = {
										leftHp = pet.leftHp,
										maxHp = maxHp,
										hpRate = hpRate
									}
								end
							end
						end
					end

					if not phase.lockPetInfo then
						for k, raceId in ipairs((not phase.lockPetInfo.lockPetRaceIds or nil) and {}) do
							self._lockRaceiDMap[raceId] = true
						end
					end
				end
			end
		end
	end
end

function OriginJiuModel:checkLockPet(petMo)
	return checkbool(self._lockPetIdMap[petMo.petId]) or checkbool(self._lockRaceiDMap[petMo.raceId])
end

function OriginJiuModel:getPetHpInfo(petId)
	return self._petHpMap[petId]
end

function OriginJiuModel:isOpenPetHp(activityId, modelId)
	local result = false
	local datas = OriginJiuConfig.instance:getPhaseDatas(activityId, modelId)

	for phaseId, data in ipairs(datas or {}) do
		if data.type == OriginJiuModel.ClgType_Wheel then
			local stageDatas = OriginJiuConfig.instance:getStageDatas(activityId, modelId, phaseId)

			for stageId, stageData in ipairs(stageDatas) do
				local isPass = self:isPassStage(activityId, modelId, phaseId, stageId)

				if isPass then
					result = true

					break
				end
			end
		end

		if result then
			break
		end
	end

	return result
end

function OriginJiuModel:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

OriginJiuModel.instance = OriginJiuModel.New()

return OriginJiuModel
