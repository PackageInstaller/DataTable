-- chunkname: @/tmp/or_skill/lua_compile/Skill_JDCZhang.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_JDCZhang_Normal = {
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
					-1,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				633
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
	_M.__all__.Skill_JDCZhang_Proud = {
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
					-1.4,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200
				}, global.SplitValue(_env, damage, {
					0.46,
					0.54
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Unique = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.3,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "MaxHpUp",
					group = "Skill_JDCZhang_Unique",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"MAXHPUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.JDCZhang_Kick = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "JDCZhang")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, unit_one in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED_ALL(_env, "Skill_JDCZhang_Passive", "UNDISPELLABLE"), 99)
						global.DispelBuff(_env, unit_one, global.BUFF_MARKED_ALL(_env, "Skill_JDCZhang_Passive_Key1", "UNDISPELLABLE"), 99)
					end

					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "JDCZhang_Kick"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Passive = {
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

				if global.FriendMaster(_env) then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_JDCZhang_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_JDCZhang_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local buff = global.PassiveFunEffectBuff(_env, "JDCZhang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"JDCZhang_Kick"
					}
				}, {
					buff
				})
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == global.FriendMaster(_env) then
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_JDCZhang_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_JDCZhang_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) then
					global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "Skill_JDCZhang_Passive"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Passive_Key = {
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

				if global.MARKED(_env, "JDCZhang")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "MAGE"))) do
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.MateUnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_JDCZhang_Passive_Key1",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_JDCZhang_Passive_Key1"
							}
						}, {
							buffeft1
						}, 1, 0)
					end

					this.num = 9 - #global.EnemyUnits(_env)

					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor * this.num)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_JDCZhang_Passive_Key2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "JDCZhang")(_env, _env.ACTOR) then
					if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
						this.num = 9 - #global.EnemyUnits(_env)

						local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor * this.num)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
							duration = 99,
							group = "Skill_JDCZhang_Passive_Key2",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2
						}, 1, 0)
					elseif global.MARKED(_env, "MAGE")(_env, _env.unit) then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.MateUnHurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "Skill_JDCZhang_Passive_Key1",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_JDCZhang_Passive_Key1"
							}
						}, {
							buffeft1
						}, 1, 0)
					end
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "JDCZhang")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "MAGE"))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "Skill_JDCZhang_Passive_Key1"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Proud_EX = {
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
					-1.4,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.Daze(_env)
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local prob = global.EvalProb1(_env, attacker, defender, this.DazeRateFactor, 0)

				if global.ProbTest(_env, prob) then
					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
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
						buffeft1
					}, 1, 0)
				end

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200
				}, global.SplitValue(_env, damage, {
					0.46,
					0.54
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Unique_EX = {
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

				global.RetainObject(_env, _env.TARGET)
				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.3,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "MaxHpUp",
					group = "Skill_JDCZhang_Unique_EX",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"MAXHPUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_JDCZhang_Passive_EX = {
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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "Skill_JDCZhang_Passive_EX1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)

				if global.FriendMaster(_env) then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_JDCZhang_Passive_EX2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_JDCZhang_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local buff = global.PassiveFunEffectBuff(_env, "JDCZhang_Kick", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"JDCZhang_Kick"
					}
				}, {
					buff
				})
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == global.FriendMaster(_env) then
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 0,
						display = "UnHurtRateUp",
						group = "Skill_JDCZhang_Passive_EX2",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"Skill_JDCZhang_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.FriendMaster(_env) then
					global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "Skill_JDCZhang_Passive"), 1)
				end
			end)

			return _env
		end
	}

	return _M
end
