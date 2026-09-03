-- chunkname: @/tmp/or_skill/lua_compile/Skill_SLMen.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SLMen_Normal = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill1"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if (global.PETS - global.SUMMONS)(_env, unit) and result and result.deadly then
						local AtkRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local CritRateFactor = global.SpecialPropGetter(_env, "specialnum2")(_env, _env.ACTOR)
						local buffeft1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, AtkRateFactor)
						local buffeft2 = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, CritRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 2,
							display = "AtkUp",
							group = "Skill_SLMen_Passive",
							duration = 5,
							limit = 5,
							tags = {
								"NUMERIC",
								"BUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Proud = {
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

			_env.damageextra = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.7,
					0
				}, 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						100,
						200
					}, global.SplitValue(_env, damage, {
						0.33,
						0.33,
						0.34
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Unique = {
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
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SUMMONS(_env, unit) then
						damage.val = damage.val * this.RateFactor
					end

					local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300,
						600,
						900,
						1200
					}, global.SplitValue(_env, damage, {
						0.2,
						0.2,
						0.2,
						0.2,
						0.2
					}))
				end
			end)
			exec["@time"]({
				3534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS)) do
					_env.num = _env.num + 1
				end

				local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor * _env.num)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_SLMen_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"HURTRATEUP",
						"Skill_SLMen_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Proud_EX = {
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

			_env.damageextra = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.7,
					0
				}, 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "CritRateUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"CRITRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1)

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						100,
						200
					}, global.SplitValue(_env, damage, {
						0.33,
						0.33,
						0.34
					}))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Unique_EX = {
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
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SUMMONS(_env, unit) then
						damage.val = damage.val * this.RateFactor
					end

					local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300,
						600,
						900,
						1200
					}, global.SplitValue(_env, damage, {
						0.2,
						0.2,
						0.2,
						0.2,
						0.2
					}))
				end
			end)
			exec["@time"]({
				3534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS)) do
					_env.num = _env.num + 1
				end

				local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor * _env.num)
				local buffeft2 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor * _env.num)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_SLMen_Passive_EX",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"HURTRATEUP",
						"Skill_SLMen_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLMen_Unique_Awaken = {
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
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SpecialPropGetter(_env, "slmen_unicount")(_env, _env.ACTOR) == 0 then
					local critrate = global.UnitPropGetter(_env, "critrate")(_env, _env.ACTOR)
					local atkrate = global.floor(_env, critrate / 0.05) * 0.05
					local buffatkrate = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, atkrate)
					local buffcrit = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "CritRateUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNSTEALABLE",
							"UNDISPELLABLE",
							"SLMen_Crit2ATK"
						}
					}, {
						buffcrit
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNSTEALABLE",
							"UNDISPELLABLE",
							"SLMen_Crit2ATK"
						}
					}, {
						buffatkrate
					})

					local count = global.SpecialNumericEffect(_env, "+slmen_unicount", {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"COUNT",
							"UNSTEALABLE",
							"UNDISPELLABLE",
							"SLMen_COUNT"
						}
					}, {
						count
					})
				end

				local SLMen_Passive = global.PassiveFunEffectBuff(_env, "SLMen_UniPassiveAwaken")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"COUNT",
						"UNSTEALABLE",
						"UNDISPELLABLE",
						"SLMen_COUNT"
					}
				}, {
					SLMen_Passive
				})

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					if global.UnitPropGetter(_env, "shield")(_env, unit) ~= 0 then
						local buffunhurt = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, 0.3)

						global.ApplyBuff(_env, unit, {
							timing = 1,
							display = "UnHurtRateDown",
							group = "SLMen_UnHurtRateDown",
							duration = 3,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"UNSTEALABLE",
								"UNDISPELLABLE"
							}
						}, {
							buffunhurt
						})
					end

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					if global.SUMMONS(_env, unit) then
						damage.val = damage.val * this.RateFactor
					end

					local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						300,
						600,
						900,
						1200
					}, global.SplitValue(_env, damage, {
						0.2,
						0.2,
						0.2,
						0.2,
						0.2
					}))
				end
			end)
			exec["@time"]({
				3534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.SLMen_UniPassiveAwaken = {
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "SLMen_Crit2ATK"), 99)
			end)

			return _env
		end
	}

	return _M
end
