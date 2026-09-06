-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/model/DoDragonUnitCustomFmtMo.lua

module("logic.extensions.dodragonchallenge.model.DoDragonUnitCustomFmtMo", package.seeall)

local DoDragonUnitCustomFmtMo = class("DoDragonUnitCustomFmtMo", ICustomFmtMo)

function DoDragonUnitCustomFmtMo:onReset()
	DoDragonUnitCustomFmtMo.super.onReset(self)
end

function DoDragonUnitCustomFmtMo:updateCfg(activityId, challengeId)
	self._activityId = activityId
	self._challengeId = challengeId
	self._ddAllData = DoDragonChallengeConfig.instance:getDdAllData(self._activityId, self._challengeId)
	self._masterData = DoDragonChallengeConfig.instance:getDdMasterData(self._ddAllData.creepsMasterId)
	self._creepsCfg = DoDragonChallengeConfig.instance:getDdCreepsCfg(self._ddAllData.creepsMasterId)
end

function DoDragonUnitCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function DoDragonUnitCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DoDragonChallengeController.instance:sendPM_DisorderDragonChallengeAllReq(self._activityId, self._challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DoDragonUnitCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DoDragonUnitCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DoDragonUnitCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DoDragonUnitCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

function DoDragonUnitCustomFmtMo:onClickCloseBtn(handler)
	DoDragonUnitCustomFmtMo.super.onClickCloseBtn(self, handler)
	UIJumper.instance:clear()
end

return DoDragonUnitCustomFmtMo
