-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/model/DivineXiuErClgCustomFmtMoOfNor.lua

module("logic.extensions.divinexiuerclg.model.DivineXiuErClgCustomFmtMoOfNor", package.seeall)

local DivineXiuErClgCustomFmtMoOfNor = class("DivineXiuErClgCustomFmtMoOfNor", ICustomFmtMo)

function DivineXiuErClgCustomFmtMoOfNor:onReset()
	DivineXiuErClgCustomFmtMoOfNor.super.onReset(self)
end

function DivineXiuErClgCustomFmtMoOfNor:updateCfg(activityId, groupId, dataBitId)
	self._activityId = activityId
	self._groupId = groupId
	self._dataBitId = dataBitId
	self._stageGroupData = DivineXiuErClgConfig.instance:getDxecNorStageGroupData(self._activityId, self._groupId, self._dataBitId)
	self._creepsMasterId = self._stageGroupData.creepsMasterId
	self._masterData = DivineXiuErClgConfig.instance:getDxecCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = DivineXiuErClgConfig.instance:getDxecCreepsCfg(self._creepsMasterId)
end

function DivineXiuErClgCustomFmtMoOfNor:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineXiuErClgCustomFmtMoOfNor:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DivineXiuErClgController.instance:sendPM_DivineXiuErClgNormalFightReq(self._activityId, self._groupId, self._dataBitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineXiuErClgCustomFmtMoOfNor:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineXiuErClgCustomFmtMoOfNor:getMonsterConfigList()
	return self._creepsCfg
end

function DivineXiuErClgCustomFmtMoOfNor:getFmtInfoConfig()
	return self._masterData
end

function DivineXiuErClgCustomFmtMoOfNor:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return DivineXiuErClgCustomFmtMoOfNor
