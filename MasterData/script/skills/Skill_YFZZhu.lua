-- chunkname: @/tmp/or_skill/lua_compile/Skill_YFZZhu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YFZZhu_Normal = {
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
					-1.3,
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
					500
				}, global.SplitValue(_env, damage, {
					0.25,
					0.25,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Proud = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					300
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Unique = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimationTEST(_env, global.UnitPos(_env, unit) + {
							-1.3,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, unit, "target")
						global.HarmTargetView(_env, unit)
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimationTEST(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.3,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, _env.TARGET, "target")
					global.HarmTargetView(_env, {
						_env.TARGET
					})
				end
			end)
			exec["@time"]({
				1067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							333,
							533,
							700,
							867,
							1000,
							1333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.14,
							0.14,
							0.14,
							0.14,
							0.14,
							0.16
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						333,
						533,
						700,
						867,
						1000,
						1333
					}, global.SplitValue(_env, damage, {
						0.14,
						0.14,
						0.14,
						0.14,
						0.14,
						0.14,
						0.16
					}))
				end
			end)
			exec["@time"]({
				3680
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Passive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				end
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							this.DmgRateFactor,
							0
						})

						global.AddAnim(_env, {
							loop = 1,
							anim = "cisha_zhanshupai",
							zOrder = "TopLayer",
							pos = global.UnitPos(_env, unit)
						})
						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Proud_EX = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local Hp = global.UnitPropGetter(_env, "hpRatio")(_env, _env.TARGET)

				if Hp < 0.5 then
					local buffeft1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "CritRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					300
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Unique_EX = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimationTEST(_env, global.UnitPos(_env, unit) + {
							-1.3,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, unit, "target")
						global.HarmTargetView(_env, unit)
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimationTEST(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.3,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, _env.TARGET, "target")
					global.HarmTargetView(_env, {
						_env.TARGET
					})
				end
			end)
			exec["@time"]({
				1067
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							333,
							533,
							700,
							867,
							1000,
							1333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.14,
							0.14,
							0.14,
							0.14,
							0.14,
							0.16
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						333,
						533,
						700,
						867,
						1000,
						1333
					}, global.SplitValue(_env, damage, {
						0.14,
						0.14,
						0.14,
						0.14,
						0.14,
						0.14,
						0.16
					}))
				end
			end)
			exec["@time"]({
				3680
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YFZZhu_Passive_Death_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "fakedie"))

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				end
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							this.DmgRateFactor,
							0
						})

						global.AddAnim(_env, {
							loop = 1,
							anim = "cisha_zhanshupai",
							zOrder = "TopLayer",
							pos = global.UnitPos(_env, unit)
						})
						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				end
			end)

			return _env
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
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"CRITRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
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
