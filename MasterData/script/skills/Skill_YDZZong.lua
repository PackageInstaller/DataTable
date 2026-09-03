-- chunkname: @/tmp/or_skill/lua_compile/Skill_YDZZong.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YDZZong_Normal = {
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
					-1.5,
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

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YDZZong_Proud = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS * global.MARKED(_env, "ASSASSIN")))

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-1.7,
							0
						}, 100, "skill2"))

						for _, unit in global.__iter__(_env.units) do
							global.AssignRoles(_env, unit, "target")
						end
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.7,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				633
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YDZZong_Unique = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS * global.MARKED(_env, "ASSASSIN")))

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

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-2.9,
							0
						}, 100, "skill3"))

						for _, unit in global.__iter__(_env.units) do
							global.AssignRoles(_env, unit, "target")
						end
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-2.9,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				1133
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							233,
							633,
							967,
							1533
						}, global.SplitValue(_env, damage, {
							0.13,
							0.13,
							0.13,
							0.23,
							0.38
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						233,
						633,
						967,
						1533
					}, global.SplitValue(_env, damage, {
						0.13,
						0.13,
						0.13,
						0.23,
						0.38
					}))
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YDZZong_Passive = {
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"HURTRATEUP",
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
	_M.__all__.Skill_YDZZong_Proud_EX = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS * global.MARKED(_env, "ASSASSIN")))

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-1.7,
							0
						}, 100, "skill2"))

						for _, unit in global.__iter__(_env.units) do
							global.AssignRoles(_env, unit, "target")
						end
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.7,
						0
					}, 100, "skill2"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				633
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						local buffeft1 = global.NumericEffect(_env, "-hurtrate", {
							"+Normal",
							"+Normal"
						}, this.DeHurtRateFactor)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 2,
							display = "HurtRateDown",
							group = "Skill_YDZZong_Proud",
							duration = 2,
							limit = 1,
							tags = {
								"STATUS",
								"DEBUFF",
								"HURTRATEDOWN",
								"DISPELLABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				else
					local buffeft1 = global.NumericEffect(_env, "-hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DeHurtRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
						timing = 2,
						display = "HurtRateDown",
						group = "Skill_YDZZong_Proud",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"HURTRATEDOWN",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YDZZong_Unique_EX = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS * global.MARKED(_env, "ASSASSIN")))

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

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, unit) + {
							-2.9,
							0
						}, 100, "skill3"))

						for _, unit in global.__iter__(_env.units) do
							global.AssignRoles(_env, unit, "target")
						end
					end
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-2.9,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, _env.TARGET, "target")
				end
			end)
			exec["@time"]({
				1133
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							233,
							633,
							967,
							1533
						}, global.SplitValue(_env, damage, {
							0.13,
							0.13,
							0.13,
							0.23,
							0.38
						}))
					end
				else
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						233,
						633,
						967,
						1533
					}, global.SplitValue(_env, damage, {
						0.13,
						0.13,
						0.13,
						0.23,
						0.38
					}))
				end
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YDZZong_Passive_EX = {
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
					"?Normal"
				}, this.ExHurtRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"HURTRATEUP",
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
