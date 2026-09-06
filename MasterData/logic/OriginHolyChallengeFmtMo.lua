-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/model/OriginHolyChallengeFmtMo.lua

module("logic.extensions.originholychallenge.model.OriginHolyChallengeFmtMo", package.seeall)

local OriginHolyChallengeFmtMo = class("OriginHolyChallengeFmtMo", BaseCustomFmtMo)

function OriginHolyChallengeFmtMo:onReset()
	OriginHolyChallengeFmtMo.super.onReset(self)

	self._activityId = 0
	self._stageId = 0
	self._stageCfg = nil
	self._cfgEnemy = nil
	self._masterList = nil
	self._supportPetCfg = nil
	self._allMyPetList = nil
	self._lastSupportId = 0
end

function OriginHolyChallengeFmtMo:initParams(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._stageCfg = OriginHolyChallengeConfig.instance:getStage(self._activityId, self._stageId)
	self._cfgEnemy = nil
	self._masterList = {}
	self._supportPetCfg = nil
	self._allMyPetList = {}
	self.topTitleStr = nil
	self.ruleDescStr = nil

	if not self._stageCfg then
		return
	end

	local creepsMasterId = checknumber(self._stageCfg.creepsMasterId)

	self._cfgEnemy = OriginHolyChallengeConfig.instance:getMaster(creepsMasterId)
	self._masterList = OriginHolyChallengeConfig.instance:getCreeps(creepsMasterId) or {}
	self._supportPetCfg = OriginHolyChallengeConfig.instance:getPet(self._stageCfg.supportPetId)

	if self._cfgEnemy then
		self.topTitleStr = self._cfgEnemy.name
		self.ruleDescStr = self._cfgEnemy.ruleDesc or self._cfgEnemy.winId

		self:setFormCondition(self._cfgEnemy.formCondition)
	end
end

function OriginHolyChallengeFmtMo:getMonsterConfigList()
	return self._masterList or {}
end

function OriginHolyChallengeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy or {}
end

function OriginHolyChallengeFmtMo:getActivityId()
	return self._activityId
end

function OriginHolyChallengeFmtMo:getStageId()
	return self._stageId
end

function OriginHolyChallengeFmtMo:getStageData()
	return self._stageCfg
end

function OriginHolyChallengeFmtMo:initPetList()
	self:clearAllPetList()

	self._allMyPetList = {}

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local mo = petMo:GetClone()

		self:addPetToList(mo)
		table.insert(self._allMyPetList, mo)
	end

	if self._supportPetCfg then
		self:addPetToList(self:_createSupportPetMo())
	end
end

function OriginHolyChallengeFmtMo:updateData()
	self:tryInitPetList()

	local currentSupportPetId = self._supportPetCfg and checknumber(self._supportPetCfg.creepsId) or 0

	if self._lastSupportId > 0 and self._lastSupportId ~= currentSupportPetId then
		self:tryRemovePetByIds(self._lastSupportId)
	end

	if currentSupportPetId > 0 then
		self:tryRemovePetByIds(currentSupportPetId)
		self:addPetToList(self:_createSupportPetMo())
	end

	self._lastSupportId = currentSupportPetId

	self:_clearInvalidSupportPet()
end

function OriginHolyChallengeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)

		if self._allMyPetList then
			local isHas = false

			for i, mo in ipairs(self._allMyPetList) do
				if mo.petId == petId then
					self._allMyPetList[i] = petMo
					isHas = true

					break
				end
			end

			if not isHas then
				table.insert(self._allMyPetList, petMo)
			end
		end
	end
end

function OriginHolyChallengeFmtMo:_clearInvalidSupportPet()
	local formationMo = self:getCurFormation()
	local currentSupportPetId = self._supportPetCfg and checknumber(self._supportPetCfg.creepsId) or 0

	if not formationMo or currentSupportPetId <= 0 then
		return
	end

	local positions = formationMo:GetPositions() or {}

	for pos, petId in ipairs(positions) do
		petId = checknumber(petId)

		if petId > 0 then
			local supportCfg = OriginHolyChallengeConfig.instance:getPet(petId)

			if supportCfg and petId ~= currentSupportPetId then
				formationMo:SetPosition(pos, 0)
			end
		end
	end
end

function OriginHolyChallengeFmtMo:_createSupportPetMo()
	if not self._supportPetCfg then
		return nil
	end

	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(self._supportPetCfg)

	local supportPetMo = fMo:toBaseBagPetMo()

	supportPetMo.isSupportedPet = true

	return supportPetMo
end

function OriginHolyChallengeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginHolyChallengeController.instance:challenge(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

return OriginHolyChallengeFmtMo
