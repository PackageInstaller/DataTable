-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/model/SkyPeakStageFmtMo.lua

module("logic.extensions.skypeak.model.SkyPeakStageFmtMo", package.seeall)

local SkyPeakStageFmtMo = class("SkyPeakStageFmtMo", BaseCustomFmtMo)

function SkyPeakStageFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = SkyPeakConfig.instance:getStageCfgById(self.activityId, self.stageId)
	self.isOnlyUpdateExistPet = true

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = SkyPeakConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = SkyPeakConfig.instance:getCreepsCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	self.validatorDescStr = self.stageCfg.fmtTips or ""
	self._filterRaceIdMap = self._filterRaceIdMap or {}
	self._isNeedFilter = false

	local limitSupportPetPlanId = self.stageCfg.limitSupportPetPlanId

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

	local supportPetPlanId = self.stageCfg.supportPetPlanId

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

	self:_dealByKillParam(self.stageCfg.scorePetValidator)
end

function SkyPeakStageFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		SkyPeakController.instance:challengeStage(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SkyPeakStageFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SkyPeakStageFmtMo:initPetList()
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

function SkyPeakStageFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SkyPeakStageFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function SkyPeakStageFmtMo:_dealByKillParam(scorePetValidator)
	if self._curKillScoreParam == scorePetValidator then
		return
	end

	self._curKillScorePetName = ""
	self._curKillScorePos = 0

	self:clearAllFixedEffects()

	local params = string.split(scorePetValidator, "$")
	local paramType = params[1]
	local paramValue = params[2]

	if paramType == SkyPeakModel.KillScoreParamType.OriginalRace then
		local raceId = checknumber(paramValue)
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

		if petSkinCfg then
			self._curKillScorePetName = petSkinCfg.name
		end
	elseif paramType == SkyPeakModel.KillScoreParamType.OriginalPos then
		local pos = checknumber(paramValue) + 1

		self._curKillScorePos = pos

		self:setFixedEffect(pos, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
	end

	self._curKillScoreParam = scorePetValidator
end

function SkyPeakStageFmtMo:getCurKillScorePetName()
	if self._curKillScorePetName ~= "" then
		return self._curKillScorePetName
	elseif self._curKillScorePos > 0 then
		local petId = self:getCurFormation():GetPosition(self._curKillScorePos)
		local petMo = self:getPetMoById(petId)

		if petMo then
			return petMo:getName()
		end
	end

	return ""
end

return SkyPeakStageFmtMo
