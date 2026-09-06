-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/model/HolyDragonTempleLightFmtMo.lua

module("logic.extensions.holydragontemple.model.HolyDragonTempleLightFmtMo", package.seeall)

local HolyDragonTempleLightFmtMo = class("HolyDragonTempleLightFmtMo", ICustomFmtMo)

function HolyDragonTempleLightFmtMo:initParams(activityId, floorId, stageId)
	self._activityId = checknumber(activityId)
	self._floorId = checknumber(floorId)
	self._stageId = checknumber(stageId)
	self._floorData = HolyDragonTempleConfig.instance:getFloorData(self._activityId, self._floorId)
	self._stageData = HolyDragonTempleConfig.instance:getStageData(self._activityId, self._floorId, self._stageId)
	self._masterData = self._stageData and HolyDragonTempleConfig.instance:getMasterData(self._stageData.creepsMasterId) or nil
	self._creepsDatas = self._stageData and HolyDragonTempleConfig.instance:getCreepsDatas(self._stageData.creepsMasterId) or nil
	self._supportPetPlan = self._floorData and checknumber(self._floorData.supportPetPlan) or 0
	self._heroSkillId = self._floorData and checknumber(self._floorData.lockHeroSkill) or 0

	self:clearAllPetList()
end

function HolyDragonTempleLightFmtMo:updateData()
	if self._masterData == nil then
		printError("HolyDragonTempleLightFmtMo masterData is nil", self._activityId, self._floorId, self._stageId)

		return
	end

	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or ""
	self.validatorDescStr = self._masterData.missionDesc or ""

	self:setFormCondition(self:_getFormCondition())
	self:initPetList()
	self:_setDefaultHeroSkill()
end

function HolyDragonTempleLightFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if checknumber(self._heroSkillId) > 0 and simpleForm and simpleForm.extParams then
			simpleForm.extParams.heroSkillId = self:_getEffectiveLockHeroSkillId()
		end

		HolyDragonTempleController.instance:sendPM_HolyDragonTempleChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function HolyDragonTempleLightFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList or {}) do
		self:addPetToList(petMo)
	end

	local supportPetDatas = HolyDragonTempleConfig.instance:getSupportPetDatas(self._supportPetPlan)

	for _, supportPetData in pairs(supportPetDatas or {}) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportPetData)
		fmo:setSupportedPet(true)

		local supportPetMo = fmo:toBaseBagPetMo()

		self:addPetToList(supportPetMo)
	end
end

function HolyDragonTempleLightFmtMo:getMonsterConfigList()
	return self._creepsDatas
end

function HolyDragonTempleLightFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HolyDragonTempleLightFmtMo:getHeroSkills()
	if checknumber(self._heroSkillId) <= 0 then
		return nil
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()

	if heroSkillId > 0 then
		return {
			heroSkillId
		}
	end

	return {}
end

function HolyDragonTempleLightFmtMo:_OnHeroSkillChanged(id, exParmams)
	if checknumber(self._heroSkillId) <= 0 then
		return
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()
	local formation = self:getCurFormation()

	if formation then
		formation:SetHeroSkillId(heroSkillId)
	end
end

function HolyDragonTempleLightFmtMo:getActivityId()
	return self._activityId
end

function HolyDragonTempleLightFmtMo:getFloorId()
	return self._floorId
end

function HolyDragonTempleLightFmtMo:getStageId()
	return self._stageId
end

function HolyDragonTempleLightFmtMo:_getFormCondition()
	local floorFormCondition = self._floorData and checknumber(self._floorData.formConditionId) or 0

	if floorFormCondition > 0 then
		return floorFormCondition
	end

	return (self._masterData or nil) and (self._masterData.formCondition or nil)
end

function HolyDragonTempleLightFmtMo:_setDefaultHeroSkill()
	if checknumber(self._heroSkillId) <= 0 then
		return
	end

	local heroSkillId = self:_getEffectiveLockHeroSkillId()
	local formation = self:getCurFormation()

	if formation then
		formation:SetHeroSkillId(heroSkillId)
	end
end

function HolyDragonTempleLightFmtMo:_getEffectiveLockHeroSkillId()
	local heroSkillId = checknumber(self._heroSkillId)

	if heroSkillId <= 0 then
		return 0
	end

	if self:_isLockHeroSkillValidInFormation(heroSkillId) then
		return heroSkillId
	end

	return 0
end

function HolyDragonTempleLightFmtMo:_isLockHeroSkillValidInFormation(heroSkillId)
	local formation = self:getCurFormation()

	if formation == nil or formation._getValidHeroSkills == nil then
		return false
	end

	local validHeroSkills = formation:_getValidHeroSkills()

	return TableUtil.isHad(validHeroSkills, heroSkillId)
end

return HolyDragonTempleLightFmtMo
