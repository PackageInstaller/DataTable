-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/model/SkyPeakBossFmtMo.lua

module("logic.extensions.skypeak.model.SkyPeakBossFmtMo", package.seeall)

local SkyPeakBossFmtMo = class("SkyPeakBossFmtMo", BaseCustomFmtMo)

function SkyPeakBossFmtMo:initParams(activityId, bossId)
	self.activityId = activityId
	self.bossId = bossId
	self.bossCfg = SkyPeakConfig.instance:getBossCfgById(self.activityId, self.bossId)
	self.isOnlyUpdateExistPet = true

	local creepsMasterId = self.bossCfg.creepsMasterId

	self._masterData = SkyPeakConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = SkyPeakConfig.instance:getCreepsCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	self.validatorDescStr = self.bossCfg.fmtTips or ""
	self._filterRaceIdMap = self._filterRaceIdMap or {}
	self._isNeedFilter = false

	local limitSupportPetPlanId = self.bossCfg.limitSupportPetPlanId

	if self._limitSupportPetPlanId ~= limitSupportPetPlanId then
		self:clearAllPetList()

		self._lastSupportPetPlanId = limitSupportPetPlanId
		self._filterRaceIdMap = {}

		local filterCfgs = SkyPeakConfig.instance:getSupportPetCfgs(limitSupportPetPlanId) or {}

		for _, filterData in pairs(filterCfgs) do
			self._isNeedFilter = self._isNeedFilter or true
			self._filterRaceIdMap[checknumber(filterData.raceId)] = true
		end
	end

	self:tryInitPetList()

	self._supportPetMoList = self._supportPetMoList or {}

	local supportPetPlanId = self.bossCfg.supportPetPlanId

	if limitSupportPetPlanId > 0 then
		supportPetPlanId = limitSupportPetPlanId
	end

	local removePetIdList = {}

	if self._isNeedFilter or self._lastSupportPetPlanId ~= supportPetPlanId then
		if not self._supportPetMoList[self._lastSupportPetPlanId] then
			local lastMoList = {}

			for _, petMo in pairs(lastMoList) do
				table.insert(removePetIdList, petMo:getPetId())
			end

			local moList = self._supportPetMoList[supportPetPlanId]

			if not moList then
				local helpCfgs = SkyPeakConfig.instance:getSupportPetCfgs(supportPetPlanId) or {}

				moList = {}

				for _, helpData in pairs(helpCfgs) do
					local fmo = self:_getFightPowerPetMo()

					fmo:fromChallengeCreepCo(helpData)

					local petMo = fmo:toBaseBagPetMo()

					petMo.isSupportedPet = true

					table.insert(moList, petMo)
				end

				self._supportPetMoList[supportPetPlanId] = moList
			end

			self:tryRemovePetByIds(removePetIdList)

			for _, petMo in ipairs(moList) do
				if self._isNeedFilter then
					if self._filterRaceIdMap[petMo.raceId] then
						self:addPetToList(self:_changePetMo(petMo))
					end
				else
					self:addPetToList(self:_changePetMo(petMo))
				end
			end

			self._lastSupportPetPlanId = supportPetPlanId
		end
	end
end

function SkyPeakBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		SkyPeakController.instance:challengeBoss(self.activityId, self.bossId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SkyPeakBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SkyPeakBossFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		if self._isNeedFilter then
			if self._filterRaceIdMap[petMo.raceId] then
				self:addPetToList(self:_changePetMo(petMo))
			end
		else
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function SkyPeakBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SkyPeakBossFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

return SkyPeakBossFmtMo
