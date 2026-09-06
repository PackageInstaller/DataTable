-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/model/DivineXiuErClgCustomFmtMoOfExtTfStage.lua

module("logic.extensions.divinexiuerclg.model.DivineXiuErClgCustomFmtMoOfExtTfStage", package.seeall)

local DivineXiuErClgCustomFmtMoOfExtTfStage = class("DivineXiuErClgCustomFmtMoOfExtTfStage", ICustomFmtMo)

function DivineXiuErClgCustomFmtMoOfExtTfStage:onReset()
	DivineXiuErClgCustomFmtMoOfExtTfStage.super.onReset(self)
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:updateCfg(activityId, tierId, dataBitId)
	self._activityId = activityId
	self._tierId = tierId
	self._dataBitId = dataBitId
	self._stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(self._activityId, self._tierId, self._dataBitId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = DivineXiuErClgConfig.instance:getDxecCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = DivineXiuErClgConfig.instance:getDxecCreepsCfg(self._creepsMasterId)

	local lockedRaceIdList = DivineXiuErClgController.instance:getAllRaceIdListOfLockedOfTruefalseStageOfExt(self._activityId, self._tierId)

	self._lockedRaceIdMap = {}

	for _, raceId in ipairs(lockedRaceIdList) do
		self._lockedRaceIdMap[raceId] = raceId
	end
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DivineXiuErClgController.instance:sendPM_DivineXiuErClgExtremeFightReq(self._activityId, self._tierId, self._dataBitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:getMonsterConfigList()
	return self._creepsCfg
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:getFmtInfoConfig()
	return self._masterData
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineXiuErClgCustomFmtMoOfExtTfStage.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			return not self:_isPetNotCanUp(petMo:getDefineId())
		else
			return true
		end
	else
		return false
	end
end

function DivineXiuErClgCustomFmtMoOfExtTfStage:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

return DivineXiuErClgCustomFmtMoOfExtTfStage
