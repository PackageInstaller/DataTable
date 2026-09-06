-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/model/ProjectAshCustomFmtMo.lua

module("logic.extensions.projectash.model.ProjectAshCustomFmtMo", package.seeall)

local ProjectAshCustomFmtMo = class("ProjectAshCustomFmtMo", ICustomFmtMo)

function ProjectAshCustomFmtMo:initParams(activityId, costIds, buffIds)
	self._activityId = activityId
	self._costIds = costIds
	self._buffIds = buffIds
	self._cfgActivity = ProjectAshConfig.instance:getActivityCfg(self._activityId)

	local creepsMasterId = self._cfgActivity.stage2CreepMasterId

	self._cfgBoss = ProjectAshConfig.instance:getBossCfg(creepsMasterId)
	self._cfgCreeps = ProjectAshConfig.instance:getCreepsCfg(creepsMasterId)
end

function ProjectAshCustomFmtMo:updateData()
	self.topTitleStr = self._cfgBoss.name
	self.ruleDescStr = self._cfgBoss.description

	self:setFormCondition(self._cfgBoss.formCondition)
	self:initPetList()
end

function ProjectAshCustomFmtMo:initFightHandler()
	local function handler()
		local maxScore = ProjectAshController.instance:getStage2WorldPrizeMaxScore(self._activityId)
		local curScore = ProjectAshModel.instance:getWorldProgress()

		if maxScore <= curScore then
			FloatWordMgr.instance:show("BOSS已被击败")

			return
		end

		local simpleForm = self:getCurSimpleForm()

		ProjectAshAgent.instance:sendPM_ProjectAshStage2ChallengeReq(self._activityId, simpleForm, self._costIds, self._buffIds)

		local stage = 2

		UIJumper.instance:pushOneStack(ViewName.ProjectAshView, true, stage)
	end

	self:setFightHandler(handler, nil)
end

function ProjectAshCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local helpCfg = ProjectAshConfig.instance:getSupportPets(self._activityId)

	if helpCfg then
		local fmo = FightingPowerPetMo.New()

		for _, helpData in pairs(helpCfg) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end

		fmo = nil
	end
end

function ProjectAshCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function ProjectAshCustomFmtMo:getMonsterConfigList()
	return self._cfgCreeps
end

function ProjectAshCustomFmtMo:getFmtInfoConfig()
	return self._cfgBoss
end

return ProjectAshCustomFmtMo
