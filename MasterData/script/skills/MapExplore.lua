-- chunkname: @/tmp/or_skill/lua_compile/MapExplore.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YLMNYi_Normal = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.7,
					0
				}, 100, "skill1"))
			end)
			exec["@time"]({
				600
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
	_M.__all__.Skill_YLMNYi_Proud = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.7,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				1000
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
	_M.__all__.Skill_YLMNYi_Unique = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.7,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					300,
					900
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))

				if global.EnemyMaster(_env, _env.TARGET) then
					-- block empty
				else
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", maxHp * 0.05)

					global.ApplyBuff(_env, _env.TARGET, {
						timing = 1,
						display = "Poison",
						group = "Poison",
						duration = 3,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
				end
			end)
			exec["@time"]({
				1667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.NFDDi_Bubble_Explore_1_1 = {
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

				global.Speak(_env, _env.ACTOR, {
					{
						"NFDDi_Bubble_Explore_1_1",
						3000
					}
				}, "", 5000)
			end)

			return _env
		end
	}
	_M.__all__.Skill_NFDDi_Flee_Explore_1_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "Skill_NFDDi_Flee_Explore_1_1")(_env, _env.unit) then
					global.WontDie(_env)
					global.ForceFlee(_env, 3000)
					global.Speak(_env, _env.ACTOR, {
						{
							"NFDDi_Flee_Explore_1_1",
							3500
						}
					}, "", 500)
				end
			end)
			exec["@time"]({
				5000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.SummonEnemy(_env, _env.ACTOR, "NFDDi_Spawn_Explore_1_1", {
					1,
					1,
					1
				}, nil, {
					9
				})
			end)

			return _env
		end
	}
	_M.__all__.NFDDi_Spawn_Bubble_Explore_1_1 = {
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

				global.Speak(_env, _env.ACTOR, {
					{
						"NFDDi_Spawn_Explore_1_1",
						3000
					}
				}, "", 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YSuo_Normal_Explore_1_4 = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					400
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)
				local buffeft3 = global.HPPeriodDamage(_env, "Poison", maxHp * 0.05)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 1,
					display = "Poison",
					group = "Poison",
					duration = 3,
					limit = 10,
					tags = {
						"STATUS",
						"DEBUFF",
						"POISON",
						"ABNORMAL",
						"DISPELLABLE"
					}
				}, {
					buffeft3
				}, 1, 0)
				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					duration = 3,
					group = "Poison",
					timing = 1,
					limit = 10,
					tags = {
						"STATUS",
						"DEBUFF",
						"POISON",
						"ABNORMAL",
						"DISPELLABLE"
					}
				}, {
					buffeft3
				}, 1, 0)
				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					duration = 3,
					group = "Poison",
					timing = 1,
					limit = 10,
					tags = {
						"STATUS",
						"DEBUFF",
						"POISON",
						"ABNORMAL",
						"DISPELLABLE"
					}
				}, {
					buffeft3
				}, 1, 0)
			end)
			exec["@time"]({
				967
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YSuo_Unique_Explore_1_4 = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.TruthBubble(_env, _env.TARGET)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)
					local buffeft3 = global.HPPeriodDamage(_env, "Poison", maxHp * 0.05)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						timing = 1,
						display = "Poison",
						group = "Poison",
						duration = 3,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						duration = 3,
						group = "Poison",
						timing = 1,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft3
					}, 1, 0)
				end
			end)
			exec["@time"]({
				2667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_DieFlee2_1_1 = {
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

				global.WontDie(_env)
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ForceFlee(_env, 4000)
				global.Speak(_env, _env.ACTOR, {
					{
						"Bubble3_2_1",
						4000
					}
				}, "", 0)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KXuan_Unique_Explore_1_2 = {
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
			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill3"))

				_env.units = global.FriendUnits(_env)

				global.HealTargetView(_env, _env.units)
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					global.ApplyRPRecovery(_env, unit, this.RageFactor)
				end
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_TowerTest_Passive_ATKUP = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 5)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 1,
					display = "AtkUp",
					group = "Skill_TowerTest_Passive_ATKUP",
					duration = 3,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
			end)

			return _env
		end
	}

	return _M
end
