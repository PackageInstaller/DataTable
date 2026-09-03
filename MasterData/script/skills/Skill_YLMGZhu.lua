-- chunkname: @/tmp/or_skill/lua_compile/Skill_YLMGZhu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YLMGZhu_Normal = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Proud = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Unique = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")

			_env.units = nil
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						400
					}, global.SplitValue(_env, damage, {
						0.5,
						0.5
					}))
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.15)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_SenLing_3",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"SECTSKILL",
							"SectSkill_Master_SenLing_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * this.DmgRateFactor, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"CURSE",
							"DISPELLABLE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Proud_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "-atkrate", {
					"+Normal",
					"+Normal"
				}, this.DeAtkRateFactor)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					display = "AtkDown",
					group = "Skill_YLMGZhu_Proud",
					duration = 2,
					limit = 1,
					tags = {
						"STATUS",
						"DEBUFF",
						"ATKDOWN",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Unique_Awaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")

			_env.units = nil
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.MARKED(_env, "HEALER")(_env, unit) then
						damage.val = damage.val * (this.ExRateFactor + 1)
					end

					if global.UnitPropGetter(_env, "hpRatio")(_env, unit) < 0.3 then
						damage.val = damage.val * (this.dmgUpRate + 1)
					end

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						400
					}, global.SplitValue(_env, damage, {
						0.5,
						0.5
					}))
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Unique_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")

			_env.units = nil
			_env.num = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						400
					}, global.SplitValue(_env, damage, {
						0.5,
						0.5
					}))
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.15)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_SenLing_3",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"SECTSKILL",
							"SectSkill_Master_SenLing_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * this.DmgRateFactor, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * this.DmgRateFactor, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YLMGZhu_Passive_SelfAwaken = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.15)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_SenLing_3",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"SECTSKILL",
							"SectSkill_Master_SenLing_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * this.DmgRateFactor, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * this.DmgRateFactor, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"DISPELLABLE",
							"CURSE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "CURSE") and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_YLMGZhu_Passive_SelfAwaken",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}

	return _M
end
