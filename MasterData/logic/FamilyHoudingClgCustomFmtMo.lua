-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/model/FamilyHoudingClgCustomFmtMo.lua

module("logic.extensions.wudiclg.model.FamilyHoudingClgCustomFmtMo", package.seeall)

local FamilyHoudingClgCustomFmtMo = class("FamilyHoudingClgCustomFmtMo", ICustomFmtMo)

function FamilyHoudingClgCustomFmtMo:onReset()
	FamilyHoudingClgCustomFmtMo.super.onReset(self)
end

function FamilyHoudingClgCustomFmtMo:updateCfg(fhId, dayIndex, isPractice)
	self._fhId = fhId
	self._dayIndex = dayIndex
	self._isPractice = isPractice
	self._bossData = FamilyHoudingClgConfig.instance:getFhBossData(self._fhId, self._dayIndex)
	self._creepsMasterId = self._bossData.creepsMasterId
	self._masterData = FamilyHoudingClgConfig.instance:getFhCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = FamilyHoudingClgConfig.instance:getFhCreepsCfg(self._creepsMasterId)
end

function FamilyHoudingClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function FamilyHoudingClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if self._isPractice then
			FamilyHoudingClgController.instance:sendPM_FamilyHounding_PracticeReq(self._fhId, self._dayIndex, simpleForm)
		else
			FamilyHoudingClgController.instance:sendPM_FamilyHounding_FightReq(self._fhId, self._dayIndex, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function FamilyHoudingClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function FamilyHoudingClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function FamilyHoudingClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function FamilyHoudingClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return FamilyHoudingClgCustomFmtMo
