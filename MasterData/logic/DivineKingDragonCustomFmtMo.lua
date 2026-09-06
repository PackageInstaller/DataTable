-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/model/DivineKingDragonCustomFmtMo.lua

module("logic.extensions.divinekingdragonchallenge.model.DivineKingDragonCustomFmtMo", package.seeall)

local DivineKingDragonCustomFmtMo = class("DivineKingDragonCustomFmtMo", ICustomFmtMo)

function DivineKingDragonCustomFmtMo:onReset()
	DivineKingDragonCustomFmtMo.super.onReset(self)
end

function DivineKingDragonCustomFmtMo:updateCfg(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._divineKingDragonMo = DivineKingDragonChallengeController.instance:getDivineKingDragonMo(self._activityId)
	self._teamData = DivineKingDragonChallengeConfig.instance:getDkdTeamDataByStage(self._activityId, stageId, teamId)
	self._creepsMasterId = self._teamData.creepsMasterId
	self._masterData = DivineKingDragonChallengeConfig.instance:getDkdMonsterData(self._creepsMasterId)
	self._creepsCfgOfReal = DivineKingDragonChallengeConfig.instance:getDkdCreepsDataList(self._creepsMasterId)
	self._creepsCfgOfShow = {}

	for _, data in ipairs(self._creepsCfgOfReal) do
		if data.isSeparation == false then
			table.insert(self._creepsCfgOfShow, data)
		end
	end
end

function DivineKingDragonCustomFmtMo:initFormationMo()
	local key = self:_getFormationMoKey()

	if key == nil then
		return
	end

	self._formationMoPool = self._formationMoPool or {}
	self.formationMo = self._formationMoPool[key] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self._formationMoPool[key] = self.formationMo
end

function DivineKingDragonCustomFmtMo:_getFormationMoKey()
	return self._stageId
end

function DivineKingDragonCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isHideFmtZdl = true

	self:initFormationMo()
end

function DivineKingDragonCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DivineKingDragonChallengeController.instance:sendPM_DivineKingDragonChallengeReq(self._activityId, self._stageId, self._teamId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineKingDragonCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineKingDragonCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgOfShow
end

function DivineKingDragonCustomFmtMo:getMonsterConfigListOfReal()
	return self._creepsCfgOfReal
end

function DivineKingDragonCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineKingDragonCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineKingDragonCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getPetId())
end

function DivineKingDragonCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getPetId()) then
		FloatWordMgr.instance:show("精灵疲劳,无法上阵")
	end
end

function DivineKingDragonCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineKingDragonCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		return not self:_isPetNotCanUp(petId)
	else
		return false
	end
end

function DivineKingDragonCustomFmtMo:_isPetNotCanUp(petId)
	if petId > 0 then
		local petMo = self:getPetMoById(petId)

		return self._divineKingDragonMo:isPetIdLockedOfStage(self._stageId, petId)
	else
		return false
	end
end

function DivineKingDragonCustomFmtMo:getExtendViewName()
	return ViewName.DivineKingDragonChallengePosView
end

return DivineKingDragonCustomFmtMo
