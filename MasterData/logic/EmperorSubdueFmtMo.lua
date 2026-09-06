-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/model/EmperorSubdueFmtMo.lua

module("logic.extensions.emperorsubdue.model.EmperorSubdueFmtMo", package.seeall)

local EmperorSubdueFmtMo = class("EmperorSubdueFmtMo", BaseCustomFmtMo)

function EmperorSubdueFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = EmperorSubdueConfig.instance:getStageCfgById(self.activityId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = EmperorSubdueConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = EmperorSubdueConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isOnlyUpdateExistPet = true

	self:tryInitPetList()

	self._supportPetMoList = self._supportPetMoList or {}

	local supportPetPlanId = self.stageCfg.supportPetPlan
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

function EmperorSubdueFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		EmperorSubdueController.instance:startChallenge(self.activityId, simpleForm, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function EmperorSubdueFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function EmperorSubdueFmtMo:initPetList()
	self:clearAllPetList()
end

function EmperorSubdueFmtMo:getFmtInfoConfig()
	return self._masterData
end

function EmperorSubdueFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

return EmperorSubdueFmtMo
