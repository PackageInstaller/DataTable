-- chunkname: @/tmp/or_skill/lua_compile/Skill_AMLYa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_AMLYa_Normal = {
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
					-2.1,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				567
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
	_M.__all__.Skill_AMLYa_Proud = {
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
					-2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					300,
					467
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					1,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2233
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagesum = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 4,
						display = "AngerRateDown",
						duration = this.Time,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_AMLYa_Unique",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						233
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))

					damagesum = damagesum + damage.val
				end

				local buffeft2 = global.SpecialNumericEffect(_env, "+AMLYa_damagesum", {
					"?Normal"
				}, damagesum)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"BLOCKRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
			end)
			exec["@time"]({
				3450
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagesum = global.SpecialPropGetter(_env, "AMLYa_damagesum")(_env, _env.ACTOR)

				for _, friendunit in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, damagesum * this.HealRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Passive_Key = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				if global.MARKED(_env, "AMLYa")(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.Immune(_env)
					local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "DEBUFF"))

					if global.MARKED(_env, "AMLYa")(_env, _env.unit) and global.CellRowLocation(_env, global.GetCell(_env, _env.unit)) == 3 then
						for _, unit in global.__iter__(global.FriendUnits(_env)) do
							flag = (global.MARKED(_env, "LEIMu")(_env, unit) or global.MARKED(_env, "LAMu")(_env, unit)) and 1
						end

						if flag == 1 then
							global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
								timing = 0,
								duration = 99,
								display = "Immune",
								tags = {
									"STATUS",
									"BUFF",
									"IMMUNE",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"Skill_AMLYa_Immune_Passive"
								}
							}, {
								buffeft1,
								buffeft2
							}, 1, 0)
						end
					end

					if (global.MARKED(_env, "LEIMu")(_env, _env.unit) or global.MARKED(_env, "LAMu")(_env, _env.unit)) and global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 3 then
						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
							timing = 0,
							duration = 99,
							display = "Immune",
							tags = {
								"STATUS",
								"BUFF",
								"IMMUNE",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_AMLYa_Immune_Passive"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				if global.MARKED(_env, "AMLYa")(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.MARKED(_env, "LEIMu")(_env, _env.unit) or global.MARKED(_env, "LAMu")(_env, _env.unit)) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						flag = (global.MARKED(_env, "LEIMu")(_env, unit) or global.MARKED(_env, "LAMu")(_env, unit)) and 1
					end

					if flag == 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "IMMUNE", "UNDISPELLABLE", "UNSTEALABLE", "Skill_AMLYa_Immune_Passive"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Proud_EX = {
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
					-2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					300,
					467
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))

				local buffeft3 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 2,
					display = "CureRateUp",
					tags = {
						"STATUS",
						"BUFF",
						"CURERATEUP"
					}
				}, {
					buffeft3
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					1,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2233
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagesum = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 4,
						display = "AngerRateDown",
						duration = this.Time,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_AMLYa_Unique",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						67,
						233
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))

					damagesum = damagesum + damage.val
				end

				local buffeft2 = global.SpecialNumericEffect(_env, "+AMLYa_damagesum", {
					"?Normal"
				}, damagesum)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"BLOCKRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
			end)
			exec["@time"]({
				3450
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_AMLYa_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damagesum = global.SpecialPropGetter(_env, "AMLYa_damagesum")(_env, _env.ACTOR)

				for _, friendunit in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, damagesum * this.HealRateFactor)
				end
			end)

			return _env
		end
	}

	return _M
end
