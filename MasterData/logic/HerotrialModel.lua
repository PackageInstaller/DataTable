-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/model/HerotrialModel.lua

module("logic.extensions.material.model.HerotrialModel", package.seeall)

local HerotrialModel = class("HerotrialModel", BaseModel)

function HerotrialModel:ctor()
	return
end

function HerotrialModel:onInit()
	self:onReset()
end

function HerotrialModel:onReset()
	self._activityId = nil
	self._hasGainInfo = false
	self._higestVerifiedZdl = 0
	self._highestDamage = 0
	self._curHighestDamage = 0
	self._formation = {}
	self._needToOpenBattleEnd = false
	self._loginFirstChallenge = false
	self._supportPet = {}
end

function HerotrialModel:getIfHasGainInfo()
	return self._hasGainInfo
end

function HerotrialModel:setIfHasGainInfo(torf)
	self._hasGainInfo = torf
end

function HerotrialModel:getActivityId()
	return self._activityId
end

function HerotrialModel:setActivityId(id)
	self._activityId = id
end

function HerotrialModel:getLoginFirstChallenge()
	return self._loginFirstChallenge
end

function HerotrialModel:setLoginFirstChallenge(torf)
	self._loginFirstChallenge = torf
end

function HerotrialModel:initHeroTrialInfo(msg)
	self._activityId = msg.activityId
	self._higestVerifiedZdl = msg.higestVerifiedZdl
	self._highestDamage = msg.highestDamage
	self._creepsId = HerotrialConfig.instance:getHeroTrialActivity(self._activityId).petId

	self:setFormation(msg.form)
end

function HerotrialModel:getHigestVerifiedZdl()
	return self._higestVerifiedZdl
end

function HerotrialModel:setHigestVerifiedZdl(zdl)
	self._higestVerifiedZdl = zdl

	GlobalDispatcher:dispatch(GlobalNotify.PetVerifySuccess)
end

function HerotrialModel:getHighestDamage()
	return self._highestDamage
end

function HerotrialModel:setHighestDamage(damage)
	self._highestDamage = damage
end

function HerotrialModel:getCurDamage()
	return self._curHighestDamage
end

function HerotrialModel:setCurDamage(damage)
	self._curHighestDamage = damage
end

function HerotrialModel:getCreepsId()
	return self._creepsId
end

function HerotrialModel:getFormation()
	return self._formation
end

function HerotrialModel:getNeedToOpenBattleEnd()
	return self._needToOpenBattleEnd
end

function HerotrialModel:setNeedToOpenBattleEnd(torf)
	self._needToOpenBattleEnd = torf
end

function HerotrialModel:getSupportPet(creepsId)
	if self._supportPet[creepsId] == nil then
		self._supportPet[creepsId] = self:createPet(creepsId)
	end

	return self._supportPet[creepsId]
end

function HerotrialModel:createPet(creepsId)
	local creepCfg = HerotrialConfig.instance:getHeroSupport(creepsId)

	if creepCfg then
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(creepCfg)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.petId = creepsId
		petMo.isSupportedPet = true

		return petMo
	end
end

function HerotrialModel:setFormation(form)
	local suppportCfg = HerotrialConfig.instance:getHeroSupport(self._creepsId) or {}
	local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(suppportCfg.raceId)) or {}

	for i, v in ipairs(form.pos) do
		if v > 0 then
			local mo = HerotrialModel.instance:getPet(v)

			if mo and mo.raceId == petCo.raceId then
				form.pos[i] = 0
			end
		end
	end

	form.pos[2] = self._creepsId
	self._formation = FormationMO.New(function(id)
		return HerotrialModel.instance:getPet(id)
	end)

	self._formation:SetData(form)
	self._formation:SetHeroSkillId(petCo.heroSkillId)
	self:_saveAsSvrFometion(form)
end

function HerotrialModel:getCurFormationId()
	return self._formation:GetId()
end

function HerotrialModel:saveCurrFormation()
	local isDirty = false
	local poses = self._formation:GetPositions()
	local skillId = self._formation:GetHeroSkillId()
	local psychicSkillId = self._formation:GetPsychicedSkillId()

	if not isDirty and self._svrFormation.extParams.heroSkillId ~= skillId then
		isDirty = true
	end

	if not isDirty and self._svrFormation.extParams.psychicSkillId ~= psychicSkillId then
		isDirty = true
	end

	if not isDirty and (self._svrFormation.extParams.elementalMasterId ~= self._formation:GetElementalMasterId() or self._svrFormation.extParams.elementalTargetId ~= self._formation:GetElementalTargetId()) then
		isDirty = true
	end

	if not isDirty then
		local svrPoses = self._svrFormation.pos

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = self._formation:createFormPb()

	form.extParams.heroSkillId = 410143

	HeroTrialAgent.instance:sendPM_HTSaveFormReq(self._activityId, form, function(msg)
		self:_saveAsSvrFometion(msg.form)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end)

	return isDirty
end

function HerotrialModel:getFormation()
	return self._formation
end

function HerotrialModel:getFormPetsHeroSkills()
	local heroskills = {}
	local suppportCfg = HerotrialConfig.instance:getHeroSupport(self._creepsId)
	local petCo = CharacterConfig.instance:getPetCo(checknumber(suppportCfg.raceId)) or {}

	table.insert(heroskills, petCo.heroSkillId)

	return heroskills
end

function HerotrialModel:getHeroSkillId()
	local suppportCfg = HerotrialConfig.instance:getHeroSupport(self._creepsId) or {}
	local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(suppportCfg.raceId))

	return petCo.heroSkillId
end

function HerotrialModel:changeSkillId(id)
	return
end

function HerotrialModel:getAllPets()
	local allPets = BagPetsController.instance:getFightBagPet()
	local supportedPetId = HerotrialConfig.instance:getHeroTrialActivity(self._activityId).petId

	allPets[#allPets + 1] = self:getSupportPet(self._creepsId)

	return allPets
end

function HerotrialModel:getPet(petId)
	if not petId or petId == 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	return self:getSupportPet(petId)
end

function HerotrialModel:setTeamId(id)
	self._teamId = id
end

function HerotrialModel:getTeamId()
	return self._teamId
end

function HerotrialModel:_saveAsSvrFometion(form)
	self._svrFormation = {}
	self._svrFormation.formId = form.formId
	self._svrFormation.pos = {}

	for k, j in ipairs(form.pos) do
		self._svrFormation.pos[k] = j
	end

	self._svrFormation.extParams = {}
	self._svrFormation.extParams.heroSkillId = form.extParams.heroSkillId
	self._svrFormation.extParams.psychicSkillId = form.extParams.psychicSkillId
	self._svrFormation.extParams.elementalMasterId = form.extParams.elementalMasterId
	self._svrFormation.extParams.elementalTargetId = form.extParams.elementalTargetId
	self._svrFormation.extParams.cutePetId = form.extParams.cutePetId
	self._svrFormation.extParams.cutePetRaceId = form.extParams.cutePetRaceId
	self._svrFormation.extParams.cutePetQuality = form.extParams.cutePetQuality
end

function HerotrialModel:diffRacePetCount()
	local allPets = self:getAllPets()
	local tem = HeroTrialFastFormation.instance:_filterByRace(allPets)

	return #tem
end

function HerotrialModel:checkHasInTeamByRaceId(raceId)
	local creepId = self:getCreepsId()
	local suppportCfg = HerotrialConfig.instance:getHeroSupport(creepId)

	if raceId == suppportCfg.raceId then
		return true
	end

	local formation = self:getFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = BagPetsController.instance:getPet(petId)

			if pet and pet.raceId == raceId then
				return true
			end
		end
	end

	return false
end

HerotrialModel.instance = HerotrialModel.New()

return HerotrialModel
