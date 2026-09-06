-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/model/FarnasCustomFmtMoOfNor.lua

module("logic.extensions.farnas.model.FarnasCustomFmtMoOfNor", package.seeall)

local FarnasCustomFmtMoOfNor = class("FarnasCustomFmtMoOfNor", ICustomFmtMo)

function FarnasCustomFmtMoOfNor:onReset()
	FarnasCustomFmtMoOfNor.super.onReset(self)
end

function FarnasCustomFmtMoOfNor:updateCfg(activityId, groupId, dataBitId)
	self._activityId = activityId
	self._groupId = groupId
	self._dataBitId = dataBitId
	self._groupData = FarnasConfig.instance:getNorStageGroupCfgByDataBitId(self._activityId, self._groupId, self._dataBitId)
	self._creepsMasterId = self._groupData.creepsMasterId
	self._masterData = FarnasConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = FarnasConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function FarnasCustomFmtMoOfNor:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function FarnasCustomFmtMoOfNor:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		FarnasChallengeAgent.instance:sendPM_FarnasClgNormalFightReq(self._activityId, self._dataBitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function FarnasCustomFmtMoOfNor:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

function FarnasCustomFmtMoOfNor:getMonsterConfigList()
	return self._creepsCfg
end

function FarnasCustomFmtMoOfNor:getFmtInfoConfig()
	return self._masterData
end

function FarnasCustomFmtMoOfNor:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

return FarnasCustomFmtMoOfNor
