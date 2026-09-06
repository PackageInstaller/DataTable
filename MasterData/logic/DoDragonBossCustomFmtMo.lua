-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/model/DoDragonBossCustomFmtMo.lua

module("logic.extensions.dodragonchallenge.model.DoDragonBossCustomFmtMo", package.seeall)

local DoDragonBossCustomFmtMo = class("DoDragonBossCustomFmtMo", ICustomFmtMo)

function DoDragonBossCustomFmtMo:onReset()
	DoDragonBossCustomFmtMo.super.onReset(self)
end

function DoDragonBossCustomFmtMo:updateCfg(activityId, isTry)
	self._activityId = activityId
	self._isTry = isTry
	self._extremeData = DoDragonChallengeConfig.instance:getDdExtremeData(self._activityId)
	self._masterData = DoDragonChallengeConfig.instance:getDdMasterData(self._extremeData.creepsMasterId)
	self._creepsCfg = DoDragonChallengeConfig.instance:getDdCreepsCfg(self._extremeData.creepsMasterId)
end

function DoDragonBossCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function DoDragonBossCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DoDragonChallengeController.instance:sendPM_DisorderDragonChallengeExtremeReq(self._activityId, self._isTry, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DoDragonBossCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DoDragonBossCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DoDragonBossCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DoDragonBossCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DoDragonBossCustomFmtMo:onClickCloseBtn(handler)
	DoDragonBossCustomFmtMo.super.onClickCloseBtn(self, handler)
	UIJumper:clear()
end

function DoDragonBossCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetHasUse(petMo:getDefineId())
end

function DoDragonBossCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetHasUse(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已使用")
	end
end

function DoDragonBossCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local isMath = false

	if DoDragonBossCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		isMath = petMo and not self:_isPetHasUse(petMo:getDefineId()) or false
	end

	return isMath
end

function DoDragonBossCustomFmtMo:_isPetHasUse(raceId)
	return DoDragonChallengeModel.instance:isPetHasUseAsBoss(self._activityId, raceId)
end

return DoDragonBossCustomFmtMo
