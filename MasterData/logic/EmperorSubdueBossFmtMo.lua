-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/model/EmperorSubdueBossFmtMo.lua

module("logic.extensions.emperorsubdue.model.EmperorSubdueBossFmtMo", package.seeall)

local EmperorSubdueBossFmtMo = class("EmperorSubdueBossFmtMo", BaseCustomFmtMo)

function EmperorSubdueBossFmtMo:initParams(activityId, isTrial, time)
	self.activityId = activityId
	self.isTrial = isTrial
	self.time = time
	self.curSelectBuffId = 0
	self.bossCfg = EmperorSubdueConfig.instance:getBossCfgByTimes(self.activityId, self.time)

	local creepsMasterId = self.bossCfg.creepsMasterId

	self._masterData = EmperorSubdueConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = EmperorSubdueConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:tryInitPetList()

	self._supportPetMoList = self._supportPetMoList or {}

	local supportPetPlanId = self.bossCfg.supportPetPlan
	local removePetIdList = {}

	if self._lastSupportPetPlanId ~= supportPetPlanId then
		if not self._supportPetMoList[self._lastSupportPetPlanId] then
			for _, petMo in pairs(self._supportPetMoList[self._lastSupportPetPlanId]) do
				table.insert(removePetIdList, petMo:getPetId())
			end

			local moList = self._supportPetMoList[supportPetPlanId]

			if not moList then
				local helpCfgs = EmperorSubdueConfig.instance:getSupportPetCfgs(supportPetPlanId) or {}

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

			for _, petMo in ipairs(moList) do
				self:addPetToList(self:_changePetMo(petMo))
			end

			self:tryRemovePetByIds(removePetIdList)

			self._lastSupportPetPlanId = supportPetPlanId
		end
	end
end

function EmperorSubdueBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		EmperorSubdueController.instance:startBossChallenge(self.activityId, self.curSelectBuffId, self.isTrial, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function EmperorSubdueBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function EmperorSubdueBossFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function EmperorSubdueBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function EmperorSubdueBossFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function EmperorSubdueBossFmtMo:getExtendViewName()
	return ViewName.EmperorSubdueFmtExView
end

return EmperorSubdueBossFmtMo
