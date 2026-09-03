-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/EnemyHeroPrototype.lua

EnemyHeroPrototype = class("EnemyHeroPrototype", objectlua.Object, _M)

EnemyHeroPrototype:has("_config", {
	is = "r"
})

function EnemyHeroPrototype:initialize(eneryId)
	super.initialize(self)

	self._config = ConfigReader:requireRecordById("EnemyHero", eneryId)
end

function EnemyHeroPrototype:getEneryData()
	if self._eneryData then
		return self._eneryData
	end

	self._eneryData = {
		cost = self._config.Cost,
		hero = self:getHeroData(),
		id = "ec-" .. tostring(self._config.Id)
	}

	return self._eneryData
end

function EnemyHeroPrototype:getHeroData()
	if self._heroData then
		return self._heroData
	end

	local level = self._config.Level
	local skillLevel = math.min(level, 10)
	local skills = {}

	do
		local passiveSkillConfig = self._config.PassiveSkill
		local passive = {}

		for i = 1, #passiveSkillConfig do
			local skillId = passiveSkillConfig[i]

			if self:checkSkillIdIsNone(skillId) then
				passive[#passive + 1] = {
					skillId = skillId,
					level = skillLevel
				}
			end
		end

		if #passive > 0 then
			skills.passive = passive
		end
	end

	do
		local normalSkillId = self._config.NormalSkill

		if self:checkSkillIdIsNone(normalSkillId) then
			skills.normal = {
				skillId = normalSkillId,
				level = skillLevel
			}
		end
	end

	do
		local proudSkillId = self._config.ProudSkill

		if self:checkSkillIdIsNone(proudSkillId) then
			skills.proud = {
				skillId = proudSkillId,
				level = skillLevel
			}
		end
	end

	do
		local uniqueSkillId = self._config.UniqueSkill

		if self:checkSkillIdIsNone(uniqueSkillId) then
			skills.unique = {
				skillId = uniqueSkillId,
				level = skillLevel
			}
		end
	end

	do
		local doubleSkillId = self._config.DoubleSkill

		if self:checkSkillIdIsNone(doubleSkillId) then
			skills.dblhit = {
				skillId = doubleSkillId,
				level = skillLevel
			}
		end
	end

	do
		local counterSkillId = self._config.CounterSkill

		if self:checkSkillIdIsNone(counterSkillId) then
			skills.cntrhit = {
				skillId = counterSkillId,
				level = skillLevel
			}
		end
	end

	do
		local deathSkillId = self._config.DeathSkill

		if self:checkSkillIdIsNone(deathSkillId) then
			skills.death = {
				skillId = deathSkillId,
				level = skillLevel
			}
		end
	end

	local flags = self._config.Flags
	local inheritId = self._config.InheritFlags

	if inheritId and inheritId ~= "" then
		local inheritConfig = ConfigReader:getRecordById("HeroBase", tostring(inheritId))
		local inheritFlags = inheritConfig and inheritConfig.Flags

		if inheritFlags and #inheritFlags > 0 then
			flags = {}

			for _, flag in ipairs(self._config.Flags) do
				flags[#flags + 1] = flag
			end

			for _, flag in ipairs(inheritFlags) do
				flags[#flags + 1] = flag
			end
		end

		local party = inheritConfig.Party

		if party and party ~= "" then
			local partyFlag = ConfigReader:getDataByNameIdAndKey("ConfigValue", "PartyFlag", "content")

			if partyFlag and partyFlag[party] and partyFlag[party] ~= "" then
				flags = flags or {}
				flags[#flags + 1] = partyFlag[party]
			end
		end
	end

	flags = flags or {}
	flags[#flags + 1] = "HERO"

	if self._config.Type then
		local typeFlags = ConfigReader:getDataByNameIdAndKey("ConfigValue", "TypeFlags", "content")[self._config.Type]

		if typeFlags then
			flags[#flags + 1] = typeFlags
		end
	end

	local var_3_0 = {
		modelId = self._config.RoleModel,
		id = self._config.Id,
		genre = self._config.Type,
		cost = self._config.Cost,
		rarity = self._config.Rarity,
		property = self._config.Property,
		flags = flags,
		star = self._config.Star,
		level = level,
		quality = self._config.Quality,
		skills = skills,
		angerRules = self._config.RageRules,
		blockAI = self._config.BlockAI,
		uncritrate = self._config.UncritRate,
		unhurtrate = self._config.UnhurtRate,
		def = self._config.Defence,
		atkweaken = self._config.AtkWeaken
	}

	var_3_0.hp = self._config.InitHp and self._config.InitHp * self._config.Hp
	var_3_0.maxHp = self._config.Hp
	var_3_0.critstrg = self._config.CritStrg
	var_3_0.unblockrate = self._config.UnblockRate
	var_3_0.atk = self._config.Attack
	var_3_0.curerate = self._config.CureRate
	var_3_0.becuredrate = self._config.BeCuredRate
	var_3_0.blockrate = self._config.BlockRate
	var_3_0.reflection = self._config.Reflection
	var_3_0.critrate = self._config.CritRate
	var_3_0.absorption = self._config.Absorption
	var_3_0.blockstrg = self._config.BlockStrg
	var_3_0.hurtrate = self._config.HurtRate
	var_3_0.defweaken = self._config.DefWeaken
	var_3_0.defrate = self._config.DefRate
	var_3_0.atkrate = self._config.AtkRate
	var_3_0.anger = self._config.RageBase
	var_3_0.speed = self._config.Speed
	var_3_0.skillrate = self._config.SkillRate
	var_3_0.counterrate = self._config.CounterRate
	var_3_0.doublerate = self._config.DoubleRate
	var_3_0.effectrate = self._config.EffectRate
	var_3_0.uneffectrate = self._config.UneffectRate
	var_3_0.effectstrg = self._config.EffectStrg
	var_3_0.masterRage = self._config.MasterRage
	var_3_0.accessories = self._config.Loot
	var_3_0.noRevive = self._config.NoRevive
	var_3_0.transform = self._config.Transform
	self._heroData = var_3_0

	return self._heroData
end

function EnemyHeroPrototype:checkSkillIdIsNone(skillId)
	if not skillId or skillId == "" or skillId == "None" then
		return false
	end

	return true
end
