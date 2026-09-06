-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/controller/battlemgr/MiracleHeroSkillMgr.lua

module("logic.extensions.miraclehero.controller.battlemgr.MiracleHeroSkillMgr", package.seeall)

local MiracleHeroSkillMgr = class("MiracleHeroSkillMgr")
local FORNT_PRIORITY_LIST = {
	1,
	2,
	3,
	4,
	5
}
local BACK_PRIORITY_LIST = {
	3,
	4,
	5,
	1,
	2
}

function MiracleHeroSkillMgr:ctor()
	self.energy = 0
	self.supportColdDown = 0
	self.elementNum = 0
	self._normalSkillUseCountMap = {}
end

function MiracleHeroSkillMgr:initData(activityId)
	self._activityId = activityId

	local activityCfg = MiracleHeroConfig.instance:getActCfg(self._activityId)

	self.energy = 0
	self.elementNum = 0
	self.supportColdDown = 0
	self._normalSkillUseCountMap = {}
	self.ultSkillElementNum = activityCfg.ultSkillElementNum
end

function MiracleHeroSkillMgr:getMyTeamSkill(elementType, num)
	local skillMo = MiracleHeroSkillMo.New()
	local targetB, targetA, skillId = self:getSkillTargetByElement(elementType, num)

	skillMo.targetA = targetA
	skillMo.configId = skillId
	skillMo.energy = num

	skillMo:initData()

	return skillMo
end

function MiracleHeroSkillMgr:getSupportSkill()
	local skillMo = MiracleHeroSkillMo.New()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	skillMo.targetB = self:getSkillTarget(MiracleHeroTeamType.EnemyTeam, supportCfg.ultSkillId)
	skillMo.configId = supportCfg.ultSkillId
	skillMo.isSupportSkill = true

	skillMo:initData()

	return skillMo
end

function MiracleHeroSkillMgr:getEnemySkill(enemyStep)
	local step = 1
	local actionPetId
	local enemyTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)

	for i, v in ipairs(enemyTeamMo.actionPet) do
		if MiracleHeroUnitMgr.instance:isPetSurvival(v) == true then
			if step == enemyStep then
				actionPetId = v

				break
			end

			step = step + 1
		end
	end

	if actionPetId then
		local skillMo = MiracleHeroSkillMo.New()
		local petMo = MiracleHeroUnitMgr.instance:getPet(actionPetId)
		local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)
		local skillId = petCfg.normalSkillId

		skillMo.energy = 1

		if self._normalSkillUseCountMap[actionPetId] and self._normalSkillUseCountMap[actionPetId] >= petCfg.ultMustCount then
			skillId = petCfg.ultSkillId
			skillMo.energy = self.ultSkillElementNum
		elseif self._normalSkillUseCountMap[actionPetId] and self._normalSkillUseCountMap[actionPetId] >= petCfg.ultNeedCount then
			local random = math.random(1, 10000)

			if random <= petCfg.ultSkillRate then
				skillId = petCfg.ultSkillId
				skillMo.energy = self.ultSkillElementNum
			end
		end

		skillMo.targetA = actionPetId
		skillMo.configId = skillId

		skillMo:initData()

		return skillMo
	else
		return nil
	end
end

function MiracleHeroSkillMgr:getCloneSkillMo(skillMo)
	local cloneSkillMo = MiracleHeroSkillMo.New()

	cloneSkillMo.configId = skillMo.configId
	cloneSkillMo.isSupportSkill = skillMo.isSupportSkill
	cloneSkillMo.targetA = skillMo.targetA
	cloneSkillMo.energy = skillMo.energy

	cloneSkillMo:initData()

	return cloneSkillMo
end

function MiracleHeroSkillMgr:getSkillTarget(enemyTeamId, skillId)
	local targetB = {}
	local skillCfg = MiracleHeroConfig.instance:getSkillCfg(skillId)
	local params = string.split(skillCfg.attackType, "-")
	local checkTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(enemyTeamId)

	if params[1] == "我方" then
		checkTeamMo = enemyTeamId == MiracleHeroTeamType.EnemyTeam and MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam) or MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)
	else
		for i, petId in pairs(checkTeamMo.pos) do
			local targetPetMo = MiracleHeroUnitMgr.instance:getPet(petId)

			if MiracleHeroUnitMgr.instance:isPetSurvival(petId) == true then
				for j, buffId in ipairs(targetPetMo.buffList) do
					local buffMo = MiracleHeroBuffMgr.instance:getBuff(buffId)

					if buffMo.buffType == MiracleHeroBuffType.State then
						table.insert(targetB, petId)

						break
					end
				end
			end
		end
	end

	if #targetB <= 0 then
		if params[2] == "全体" then
			for i, petId in pairs(checkTeamMo.pos) do
				if MiracleHeroUnitMgr.instance:isPetSurvival(petId) == true then
					table.insert(targetB, petId)
				end
			end
		else
			local needAddCount = skillCfg.targetCount

			for i, v in ipairs((params[2] == GameEnum.BACK_PET or nil) and BACK_PRIORITY_LIST) do
				if needAddCount > 0 and checkTeamMo.pos[v] and MiracleHeroUnitMgr.instance:isPetSurvival(checkTeamMo.pos[v]) == true then
					needAddCount = needAddCount - 1

					table.insert(targetB, checkTeamMo.pos[v])

					if needAddCount <= 0 then
						break
					end
				end
			end
		end
	end

	return targetB
end

function MiracleHeroSkillMgr:getSkillTargetByElement(elementType, num)
	local targetA, targetB
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local petMoA

	for i, petId in pairs(myTeamMo.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(petId)
		local config = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

		if MiracleHeroUnitMgr.instance:isPetSurvival(petId) == true and elementType == config.elementId then
			petMoA = petMo

			break
		end
	end

	if not petMoA then
		for i, petId in pairs(myTeamMo.pos) do
			local petMo = MiracleHeroUnitMgr.instance:getPet(petId)

			if MiracleHeroUnitMgr.instance:isPetSurvival(petId) == true then
				petMoA = petMo

				break
			end
		end
	end

	targetA = petMoA.id

	local skillId
	local petConfig = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMoA.configId)

	skillId = num >= self.ultSkillElementNum and petConfig.ultSkillId or petConfig.normalSkillId

	return self:getSkillTarget(MiracleHeroTeamType.EnemyTeam, skillId), targetA, skillId
end

function MiracleHeroSkillMgr:getEnergy()
	return self.energy
end

function MiracleHeroSkillMgr:getSupportColdDown()
	return self.supportColdDown
end

function MiracleHeroSkillMgr:setSupportColdDown()
	if self.supportColdDown > 0 then
		self.supportColdDown = self.supportColdDown - 1
	end
end

function MiracleHeroSkillMgr:useSupportSkill()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	self.supportColdDown = supportCfg.coldDown
	self.energy = self.energy - supportCfg.ultCostEnergy
end

function MiracleHeroSkillMgr:useSkill(elementType, num)
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	if supportCfg then
		for i, v in ipairs(supportCfg.energyProvider) do
			if elementType == v then
				self.elementNum = self.elementNum + num

				local getEnergyNum = math.floor(self.elementNum / supportCfg.energyRatio)

				self.energy = self.energy + getEnergyNum
				self.elementNum = self.elementNum - getEnergyNum * supportCfg.energyRatio

				if supportCfg.energyLimit < self.energy then
					self.energy = supportCfg.energyLimit
				end
			end
		end
	end
end

function MiracleHeroSkillMgr:useEnemySkill(petId, skillType)
	if skillType == GameEnum.SkillType.Utl then
		self._normalSkillUseCountMap[petId] = 0
	elseif skillType == GameEnum.SkillType.Normal then
		self._normalSkillUseCountMap[petId] = 1 + (self._normalSkillUseCountMap[petId] or 0)
	end
end

MiracleHeroSkillMgr.instance = MiracleHeroSkillMgr.New()

return MiracleHeroSkillMgr
