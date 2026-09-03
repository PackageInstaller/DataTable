-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/EnemyMasterPrototype.lua

EnemyMasterPrototype = class("EnemyMasterPrototype", objectlua.Object, _M)

EnemyMasterPrototype:has("_config", {
	is = "r"
})

function EnemyMasterPrototype:initialize(eneryId)
	super.initialize(self)

	self._config = ConfigReader:getRecordById("EnemyMaster", eneryId)
end

function EnemyMasterPrototype:getMasterData()
	if self._masterData then
		return self._masterData
	end

	local level = self._config.Level
	local skillLevel = math.min(level, 10)
	local skills = {}

	do
		local normalSkillId = self._config.AttackSkill

		if self:checkSkillIdIsNone(normalSkillId) then
			skills.normal = {
				skillId = normalSkillId,
				level = skillLevel
			}
		end
	end

	do
		local masterSkill1 = self._config.MasterSkill1

		if self:checkSkillIdIsNone(masterSkill1) then
			skills.master1 = {
				skillId = masterSkill1,
				level = skillLevel
			}
		end
	end

	do
		local masterSkill2 = self._config.MasterSkill2

		if self:checkSkillIdIsNone(masterSkill2) then
			skills.master2 = {
				skillId = masterSkill2,
				level = skillLevel
			}
		end
	end

	do
		local masterSkill3 = self._config.MasterSkill3

		if self:checkSkillIdIsNone(masterSkill3) then
			skills.master3 = {
				skillId = masterSkill3,
				level = skillLevel
			}
		end
	end

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

		passive[#passive + 1] = {
			level = 1,
			skillId = "Fight_MaxCostBuff"
		}

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

	if not self._config.Flags then
		local flags = {}

		flags[#flags + 1] = "MASTER"

		if self._config.Type then
			local typeFlags = ConfigReader:getDataByNameIdAndKey("ConfigValue", "TypeFlags", "content")[self._config.Type]

			if typeFlags then
				flags[#flags + 1] = typeFlags
			end
		end

		local var_2_1 = {
			modelId = self._config.RoleModel,
			id = self._config.Id,
			genre = self._config.Type,
			property = self._config.Property,
			flags = flags,
			star = self._config.Star,
			level = level,
			quality = self._config.Quality,
			skills = skills,
			angerRules = self._config.RageRules,
			uncritrate = self._config.UncritRate,
			unhurtrate = self._config.UnhurtRate,
			def = self._config.Defence,
			atkweaken = self._config.AtkWeaken
		}

		var_2_1.hp = self._config.InitHp and self._config.InitHp * self._config.Hp
		var_2_1.maxHp = self._config.Hp
		var_2_1.critstrg = self._config.CritStrg
		var_2_1.unblockrate = self._config.UnblockRate
		var_2_1.atk = self._config.Attack
		var_2_1.curerate = self._config.CureRate
		var_2_1.becuredrate = self._config.BeCuredRate
		var_2_1.blockrate = self._config.BlockRate
		var_2_1.reflection = self._config.Reflection
		var_2_1.critrate = self._config.CritRate
		var_2_1.absorption = self._config.Absorption
		var_2_1.blockstrg = self._config.BlockStrg
		var_2_1.hurtrate = self._config.HurtRate
		var_2_1.defweaken = self._config.DefWeaken
		var_2_1.defrate = self._config.DefRate
		var_2_1.atkrate = self._config.AtkRate
		var_2_1.anger = self._config.RageBase
		var_2_1.speed = self._config.Speed
		var_2_1.skillrate = self._config.SkillRate
		var_2_1.counterrate = self._config.CounterRate
		var_2_1.doublerate = self._config.DoubleRate
		var_2_1.effectrate = self._config.EffectRate
		var_2_1.uneffectrate = self._config.UneffectRate
		var_2_1.effectstrg = self._config.EffectStrg
		var_2_1.accessories = self._config.Loot
		var_2_1.transform = self._config.Transform
		var_2_1.aoederate = self._config.AOEDerate
		var_2_1.heroShow = self._config.HeroShow
		var_2_1.isProcessingBoss = self._config.IsProcessingBoss
		self._masterData = var_2_1

		return self._masterData
	end
end

function EnemyMasterPrototype:checkSkillIdIsNone(skillId)
	if not skillId or skillId == "" or skillId == "None" then
		return false
	end

	return true
end
