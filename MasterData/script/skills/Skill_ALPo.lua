-- chunkname: @/tmp/or_skill/lua_compile/Skill_ALPo.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_ALPo_Normal = {
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
	_M.__all__.Skill_ALPo_Proud = {
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
					-1.4,
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

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_ALPo_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					if global.ProbTest(_env, 0.25) then
						local buffeft1 = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					elseif global.ProbTest(_env, 0.33) then
						local buffeft2 = global.Daze(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Daze",
							tags = {
								"STATUS",
								"DEBUFF",
								"DAZE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft2
						}, 1, 0)
					elseif global.ProbTest(_env, 0.5) then
						local buffeft3 = global.NumericEffect(_env, "-atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "UnHurtRateDown",
							tags = {
								"STATUS",
								"DEBUFF",
								"ATKDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft3
						}, 1, 0)
					else
						local buffeft4 = global.NumericEffect(_env, "-defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "UnHurtRateDown",
							tags = {
								"STATUS",
								"DEBUFF",
								"DEFDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft4
						}, 1, 0)
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						200,
						400,
						600,
						1100
					}, global.SplitValue(_env, damage, {
						0.14,
						0.15,
						0.16,
						0.17,
						0.38
					}))
				end
			end)
			exec["@time"]({
				3400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_ALPo_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					_env.count = _env.count + global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 99)

					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Dispel",
						tags = {
							"DISPEL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor * _env.count)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 4,
					display = "MaxHpUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"Skill_ALPo_Passive",
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
	_M.__all__.Skill_ALPo_Proud_EX = {
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
					-1.4,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.Mute(_env)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					duration = 2,
					display = "Mute",
					tags = {
						"STATUS",
						"DEBUFF",
						"MUTE",
						"ABNORMAL",
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
	_M.__all__.Skill_ALPo_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					if global.ProbTest(_env, 0.25) then
						local buffeft1 = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					elseif global.ProbTest(_env, 0.33) then
						local buffeft2 = global.Daze(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Daze",
							tags = {
								"STATUS",
								"DEBUFF",
								"DAZE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft2
						}, 1, 0)
					elseif global.ProbTest(_env, 0.5) then
						local buffeft3 = global.NumericEffect(_env, "-atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "UnHurtRateDown",
							tags = {
								"STATUS",
								"DEBUFF",
								"ATKDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft3
						}, 1, 0)
					else
						local buffeft4 = global.NumericEffect(_env, "-defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "UnHurtRateDown",
							tags = {
								"STATUS",
								"DEBUFF",
								"DEFDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft4
						}, 1, 0)
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						200,
						400,
						600,
						1100
					}, global.SplitValue(_env, damage, {
						0.14,
						0.15,
						0.16,
						0.17,
						0.38
					}))
				end
			end)
			exec["@time"]({
				3400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_ALPo_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					_env.count = _env.count + global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 99)

					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Dispel",
						tags = {
							"DISPEL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor * _env.count)
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor * _env.count)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "MaxHpUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"Skill_ALPo_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 0)
			end)

			return _env
		end
	}

	return _M
end
