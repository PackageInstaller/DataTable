-- chunkname: @/tmp/or_skill/lua_compile/Skill_YYing.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YYing_Normal = {
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
	_M.__all__.Skill_YYing_Proud = {
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
					-0.9,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				693
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buffeft1 = global.NumericEffect(_env, "-atkrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.TARGET, {
					timing = 0,
					display = "AtkDown",
					group = "Skill_GLin_Passive_EX",
					duration = 99,
					limit = 1,
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
	_M.__all__.Skill_YYing_Proud_EX = {
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
					-0.9,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				693
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buffeft1 = global.NumericEffect(_env, "-atkrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.TARGET, {
					timing = 0,
					display = "AtkDown",
					group = "Skill_GLin_Passive_EX",
					duration = 99,
					limit = 1,
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
	_M.__all__.Skill_YYing_Unique = {
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
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local i = global.Random(_env, 1, 800)

					if i <= 200 then
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
					elseif i < 401 then
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
					elseif i < 601 then
						local buffeft3 = global.NumericEffect(_env, "-atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 1,
							display = "AtkDown",
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

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 1,
							display = "DefDown",
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

					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local buffeft2 = global.HPPeriodDamage(_env, "Burning", attacker.atk * 0.6)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						duration = 99,
						tags = {
							"STATUS",
							"DEBUFF",
							"BURNING",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft2
					}, 1, 1)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YYing_Unique_EX = {
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
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local i = global.Random(_env, 1, 800)

					if i <= 200 then
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
					elseif i < 401 then
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
					elseif i < 601 then
						local buffeft3 = global.NumericEffect(_env, "-atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 1,
							display = "AtkDown",
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

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							duration = 1,
							display = "DefDown",
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

					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local buffeft2 = global.HPPeriodDamage(_env, "Burning", attacker.atk * 0.6)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						duration = 99,
						tags = {
							"STATUS",
							"DEBUFF",
							"BURNING",
							"ABNORMAL",
							"DISPELLABLE"
						}
					}, {
						buffeft2
					}, 1, 1)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YYing_Passive_Death = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "dieskill"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedYYing = global.Summon(_env, _env.ACTOR, "SummonedYYing", this.summonFactorA, nil, {
					global.abs(_env, global.UnitPosId(_env, _env.ACTOR))
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_YYing_Passive_Key = {
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

				if global.MARKED(_env, "YYing")(_env, _env.ACTOR) then
					local num = #global.FriendUnits(_env, global.MARKED(_env, "idol"))

					if num >= 2 then
						for _, friend in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "idol") - global.ONESELF(_env, _env.ACTOR))) do
							local buffeft1 = global.Diligent(_env)

							global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
								timing = 2,
								duration = 1,
								tags = {
									"NUMERIC",
									"BUFF",
									"ATKUP",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft1
							}, 1)
						end

						global.DiligentRound(_env)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YYingjiangshi_Normal = {
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

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.3,
					0
				}, 100, "skill1"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}

	return _M
end
