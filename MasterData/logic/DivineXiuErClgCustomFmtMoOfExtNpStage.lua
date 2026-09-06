-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/model/DivineXiuErClgCustomFmtMoOfExtNpStage.lua

module("logic.extensions.divinexiuerclg.model.DivineXiuErClgCustomFmtMoOfExtNpStage", package.seeall)

local DivineXiuErClgCustomFmtMoOfExtNpStage = class("DivineXiuErClgCustomFmtMoOfExtNpStage", ICustomFmtMo)

function DivineXiuErClgCustomFmtMoOfExtNpStage:onReset()
	DivineXiuErClgCustomFmtMoOfExtNpStage.super.onReset(self)
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:updateCfg(activityId, tierId, dataBitId)
	self._activityId = activityId
	self._tierId = tierId
	self._dataBitId = dataBitId
	self._stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(self._activityId, self._tierId, self._dataBitId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = DivineXiuErClgConfig.instance:getDxecCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = DivineXiuErClgConfig.instance:getDxecCreepsCfg(self._creepsMasterId)
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DivineXiuErClgController.instance:sendPM_DivineXiuErClgExtremeFightReq(self._activityId, self._tierId, self._dataBitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:getMonsterConfigList()
	return self._creepsCfg
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:getFmtInfoConfig()
	return self._masterData
end

function DivineXiuErClgCustomFmtMoOfExtNpStage:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return DivineXiuErClgCustomFmtMoOfExtNpStage
