-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/model/KunLunNorClgCustomFmtMo.lua

module("logic.extensions.kunlunchallenge.model.KunLunNorClgCustomFmtMo", package.seeall)

local KunLunNorClgCustomFmtMo = class("KunLunNorClgCustomFmtMo", ICustomFmtMo)

function KunLunNorClgCustomFmtMo:onReset()
	KunLunNorClgCustomFmtMo.super.onReset(self)
end

function KunLunNorClgCustomFmtMo:updateCfg(activityId)
	self._activityId = activityId

	local actData = KunLunChallengeConfig.instance:getKlActData(self._activityId)

	self._monsterId = actData.commonCreepsMasterId
	self._masterData = KunLunChallengeConfig.instance:getKlExtremeMonsterData(self._monsterId)
	self._creepsCfg = KunLunChallengeConfig.instance:getKlChallengeCreepsDataList(self._monsterId)
end

function KunLunNorClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isHideFmtZdl = true
end

function KunLunNorClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KunLunChallengeController.instance:sendPM_KunLunCommonClgFightReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KunLunNorClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KunLunNorClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KunLunNorClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KunLunNorClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KunLunNorClgCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getPetId())
end

function KunLunNorClgCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getPetId()) then
		FloatWordMgr.instance:show("精灵疲劳,无法上阵")
	end
end

function KunLunNorClgCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if KunLunNorClgCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		return not self:_isPetNotCanUp(petId)
	else
		return false
	end
end

function KunLunNorClgCustomFmtMo:_isPetNotCanUp(petId)
	if petId > 0 then
		local petMo = self:getPetMoById(petId)
		local raceId = petMo:getDefineId()

		return KunLunChallengeController.instance:isLockRaceIdOfNorClg(raceId)
	else
		return false
	end
end

return KunLunNorClgCustomFmtMo
