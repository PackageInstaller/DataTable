-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_YDLang.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_Enemy_YDLang_Normal = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.65,
					0
				}, 100, "skill1"))
			end)
			exec["@time"]({
				733
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AddStatus(_env, _env.ACTOR, "YDLang_In_Normal")

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor) * global.SUMMON_damage(_env, _env.TARGET)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local extra_damage = 99

				global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 2, 1, 0, 0, 0, nil, extra_damage)
				global.RemoveStatus(_env, _env.ACTOR, "YDLang_In_Normal")
			end)
			exec["@time"]({
				1432
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_YDLang_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.sum = 0
			_env.atk = 0
			_env.def = 0
			_env.maxHp = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AddStatus(_env, _env.ACTOR, "wroldBoss_marked")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					_env.atk = _env.atk + global.UnitPropGetter(_env, "atk")(_env, unit)
					_env.def = _env.def + global.UnitPropGetter(_env, "def")(_env, unit)
					_env.maxHp = _env.maxHp + global.UnitPropGetter(_env, "maxHp")(_env, unit)
					_env.sum = _env.sum + 1
				end

				if _env.def > 10000 then
					_env.def = 10000
				end

				local buff1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, _env.atk / _env.sum)
				local buff2 = global.NumericEffect(_env, "+def", {
					"+Normal",
					"+Normal"
				}, _env.def * 1.2 / _env.sum)
				local buff3 = global.MaxHpEffect(_env, _env.maxHp / (_env.sum * 3))

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"YDLang"
					}
				}, {
					buff1
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"YDLang"
					}
				}, {
					buff2
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"YDLang"
					}
				}, {
					buff3
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_WorldBoss_HIDE_DIE = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.summonFactor = {
				1,
				1,
				1
			}

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AddAnim(_env, {
					loop = 2,
					anim = "huanrao_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.ACTOR) + {
						0.3,
						-0.8
					}
				})
				global.Sound(_env, "Se_Skill_Change_1", 1)
			end)
			exec["@time"]({
				150
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DelayCall(_env, global.Random(_env, 50), global.SUMMON_ACTOR, _env.ACTOR, "SummonedYDLang")
				global.add_WorldBoss_PassiveFunEffectBuff(_env, 10)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_WorldBoss_JSJJu_Normal = {
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

			_env.dmgFactor = {
				1,
				2,
				0
			}
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.2,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.AddStatus(_env, _env.ACTOR, "WorldBoss_JSJJu_In_Normal")
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				300
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, _env.dmgFactor) * global.SUMMON_damage(_env, _env.TARGET)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.RemoveStatus(_env, _env.ACTOR, "WorldBoss_JSJJu_In_Normal")
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_WorldBoss_JSJJu_Unique = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill2"))

				_env.units = global.EnemyUnits(_env)

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AddStatus(_env, _env.ACTOR, "WorldBoss_JSJJu_In_Unique")

				local dam_list = global.randomN_number(_env, #_env.units)

				dam_list = global.SortBy(_env, dam_list, ">")

				local i = 1

				_env.units = global.SortBy(_env, global.EnemyUnits(_env, -global.MASTER), ">", global.unitCompare)

				for _, unit in global.__iter__(_env.units) do
					global.dump(_env, {
						#_env.units,
						i
					}, "boss=======")

					if #_env.units == 8 and i >= 7 and #global.CardsInWindow(_env, global.GetOwner(_env, unit)) > 0 then
						global.print(_env, "进来了")

						dam_list[i] = 100
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						dam_list[i],
						99
					}) * global.SUMMON_damage(_env, unit)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						400,
						900
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))

					i = i + 1
				end

				if global.IsAlive(_env, global.EnemyMaster(_env)) then
					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, global.EnemyMaster(_env), {
						1,
						0.5,
						99
					})

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, global.EnemyMaster(_env), {
						0,
						400,
						900
					}, global.SplitValue(_env, damage, {
						0.3,
						0.3,
						0.4
					}))
				end

				global.RemoveStatus(_env, _env.ACTOR, "WorldBoss_JSJJu_In_Unique")
			end)
			exec["@time"]({
				2890
			}, _env, function(_env)
				return
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				local str_speak = {
					"Speak_boss_juju_1",
					"Speak_boss_juju_2"
				}
				local index = global.Random(_env, #str_speak)

				global.Speak(_env, _env.ACTOR, {
					{
						str_speak[index],
						3000
					}
				}, nil, 1)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_WorldBoss_JSJJu_Passive = {
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
				local NianFlag = global.SpecialNumericEffect(_env, "+nshoushou", {
					"?Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NianShou",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					NianFlag
				})

				if global.EnemyMaster(_env) then
					local def = global.UnitPropGetter(_env, "def")(_env, global.EnemyMaster(_env)) / 2

					if def > 10000 then
						def = 10000
					end

					local buff1 = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, def)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						limit = 1,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"JSJJu"
						}
					}, {
						buff1
					})
				end

				local buffeft2 = global.ImmuneBuff(_env, "ABNORMAL")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Skill_WorldBoss_Unique_proud")) == 0 then
					local Cells = global.EnemyCells(_env)

					for _, mycell in global.__iter__(Cells) do
						global.DispelBuffTrap(_env, mycell, global.BUFF_MARKED_ALL(_env, "LIGHTON"))
					end

					for _, uniter in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, uniter, global.BUFF_MARKED_ALL(_env, "Boss_Unique_proud"), 99)
						global.DispelBuff(_env, uniter, global.BUFF_MARKED_ALL(_env, "Skill_WorldBoss_Unique_proud"), 99)
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

				if global.GetSide(_env, _env.unit) == -1 and global.SUMMONS(_env, _env.unit) == false then
					local num = global.GetFriendField(_env, nil, "DieNum")

					global.SetFriendField(_env, nil, num + 1, "DieNum")
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_WorldBoss_JSLLing_Normal = {
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

				global.print(_env, "普攻了。。。。。")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.2,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				333
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor) * global.SUMMON_damage(_env, _env.TARGET)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_WorldBoss_JSLLing_Passive = {
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

				global.AddStatus(_env, _env.ACTOR, "wroldBoss_marked")

				local sum = 0
				local atk = 0
				local def = 0
				local maxHp = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					atk = atk + global.UnitPropGetter(_env, "atk")(_env, unit)
					def = def + global.UnitPropGetter(_env, "def")(_env, unit)
					maxHp = maxHp + global.UnitPropGetter(_env, "maxHp")(_env, unit)
					sum = sum + 1
				end

				local buff1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, atk / sum)
				local buff2 = global.NumericEffect(_env, "+def", {
					"+Normal",
					"+Normal"
				}, def * 1.2 / sum)
				local buff3 = global.MaxHpEffect(_env, maxHp / (sum * 3))

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"JSLLing"
					}
				}, {
					buff1
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"JSLLing"
					}
				}, {
					buff2
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"JSLLing"
					}
				}, {
					buff3
				})
			end)

			return _env
		end
	}

	function _M.__all__.unitCompare(_env, unit)
		local this, global = _env.this, _env.global

		return global.UnitPropGetter(_env, "hp")(_env, unit) + global.UnitPropGetter(_env, "shield")(_env, unit) / global.UnitPropGetter(_env, "hp")(_env, unit)
	end

	_M.__all__.Skill_WorldBoss_Normal_DIE = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.dmgFactor = {
				1,
				1,
				99
			}

			exec["@time"]({
				150
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.EnemyUnits(_env, -global.MASTER)
				local deathkill = global.SortBy(_env, units, ">", global.unitCompare)
				local unit = global.SortBy(_env, units, ">", global.unitCompare)[1]

				if unit then
					global.AddStatus(_env, _env.ACTOR, "WorldBoss_JSLLing_Death")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, _env.dmgFactor) * global.SUMMON_damage(_env, unit)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					global.AnimForTrgt(_env, unit, {
						loop = 1,
						anim = "baodian_shoujibaodian",
						zOrder = "TopLayer",
						pos = {
							0.5,
							0.5
						}
					})
					global.RemoveStatus(_env, _env.ACTOR, "WorldBoss_JSLLing_Death")
				end

				global.add_WorldBoss_PassiveFunEffectBuff(_env, 10)
				global.DelayCall(_env, global.Random(_env, 100), global.SUMMON_ACTOR, _env.ACTOR, "SummonedJSLLing")
			end)

			return _env
		end
	}

	return _M
end
