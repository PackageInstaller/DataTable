-- chunkname: @/tmp/or_skill/lua_compile/Skill_KTSJKe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_KTSJKe_Normal = {
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
				500
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
	_M.__all__.Skill_KTSJKe_Proud = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.MARKED(_env, "MAGE")))

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-1.3,
							0
						}, 100, "skill2"))
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.3,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							267,
							734
						}, global.SplitValue(_env, damage, {
							0.25,
							0.25,
							0.5
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
					local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						267,
						734
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.5
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					600
				}, global.SplitValue(_env, damage, {
					0.45,
					0.55
				}))
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil
			_env.DmgRate = 0

			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					_env.DmgRate = global.MARKED(_env, "MAGE")(_env, unit) and this.DmgRateFactor + this.ExDmgRateFactor or this.DmgRateFactor

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						_env.DmgRate,
						0
					})
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					global.AnimForTrgt(_env, unit, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = {
							0.5,
							-0.5
						}
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Proud_EX = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.MARKED(_env, "MAGE")))

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-1.3,
							0
						}, 100, "skill2"))
						global.AssignRoles(_env, unit, "target")
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.3,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 1,
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

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							267,
							734
						}, global.SplitValue(_env, damage, {
							0.25,
							0.25,
							0.5
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
					local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						267,
						734
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.5
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Unique_EX = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					600
				}, global.SplitValue(_env, damage, {
					0.45,
					0.55
				}))
				local units = global.EnemyUnits(_env, global.MARKED(_env, "MAGE"))

				for _, mage in global.__iter__(units) do
					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, mage, damage * 0.3)
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil
			_env.DmgRate = 0

			exec["@time"]({
				50
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"Skill_KTSJKe_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					_env.DmgRate = global.MARKED(_env, "MAGE")(_env, unit) and this.DmgRateFactor + this.ExDmgRateFactor or this.DmgRateFactor

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						_env.DmgRate,
						0
					})
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					global.AnimForTrgt(_env, unit, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = {
							0.5,
							-0.5
						}
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_KTSJKe_Unique_Awken = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.9,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, 0.15)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "DefWeakenUp",
					group = "Skill_KTSJKe_Unique_Awken",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Skill_KTSJKe_Unique_Awken"
					}
				}, {
					buffeft1
				})
				global.RetainObject(_env, _env.TARGET)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					600
				}, global.SplitValue(_env, damage, {
					0.45,
					0.55
				}))
				local units = global.EnemyUnits(_env, global.MARKED(_env, "MAGE"))

				for _, mage in global.__iter__(units) do
					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, mage, damage * 0.3)
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_KTSJKe_Unique_Awken"), 99)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
