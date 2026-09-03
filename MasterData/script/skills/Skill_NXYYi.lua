-- chunkname: @/tmp/or_skill/lua_compile/Skill_NXYYi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_NXYYi_Normal = {
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
					-2.2,
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
	_M.__all__.Skill_NXYYi_Proud = {
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
					-2.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
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
	_M.__all__.Skill_NXYYi_Unique = {
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
				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.8,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					333,
					1000
				}, global.SplitValue(_env, damage, {
					0.15,
					0.15,
					0.35,
					0.35
				}))
			end)
			exec["@time"]({
				2933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.RageFactor)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

				local defender1 = global.LoadUnit(_env, _env.TARGET, "ALL")

				if defender1.rp == 0 then
					local buffeft1 = global.Daze(_env)

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
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Passive = {
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 0,
						duration = 99,
						display = "AngerRateDown",
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local buffeft2 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, 0.25)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "DefWeakenUp",
					group = "Skill_NXYYi_Passive_1",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						duration = 99,
						display = "AngerRateDown",
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "Skill_NXYYi_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Proud_EX = {
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
					-2.2,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "DefWeakenUp",
					group = "Skill_NXYYi_Proud_EX",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"DEFWEAKENUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				}, 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Unique_EX = {
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
				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.8,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					333,
					1000
				}, global.SplitValue(_env, damage, {
					0.15,
					0.15,
					0.35,
					0.35
				}))
			end)
			exec["@time"]({
				2933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.RageFactor)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

				local defender1 = global.LoadUnit(_env, _env.TARGET, "ALL")

				if defender1.rp == 0 then
					local buffeft1 = global.Daze(_env)

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
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Passive_EX = {
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

				for _, unit2 in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, this.DefWeakenRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit2, {
						timing = 0,
						display = "DefWeakenUp",
						group = "Skill_NXYYi_Passive_EX",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DEFWEAKENUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_NXYYi_Passive_EX"
						}
					}, {
						buffeft1
					}, 1)
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AngerRateDown",
						group = "Skill_NXYYi_Passive_EX_1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive_EX_1",
							"UNDISPELLABLE"
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "AngerRateDown",
						group = "Skill_NXYYi_Passive_EX_1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive_EX_1",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				else
					local buffeft2 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, this.DefWeakenRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "DefWeakenUp",
						group = "Skill_NXYYi_Passive_EX",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DEFWEAKENUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_NXYYi_Passive_EX"
						}
					}, {
						buffeft2
					}, 1)
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_EX_1"))
				end

				for _, unit2 in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit2, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_EX"))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Unique_Awaken = {
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
				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.8,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					200,
					333,
					1000
				}, global.SplitValue(_env, damage, {
					0.15,
					0.15,
					0.35,
					0.35
				}))
			end)
			exec["@time"]({
				2933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, this.RageFactor)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

				local defender1 = global.LoadUnit(_env, _env.TARGET, "ALL")

				if defender1.rp == 0 then
					local buffeft1 = global.Daze(_env)

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
			end)
			exec["@time"]({
				3134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_NXYYi_Passive_SelfAwaken = {
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

				for _, unit2 in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, this.DefWeakenRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit2, {
						timing = 0,
						display = "DefWeakenUp",
						group = "Skill_NXYYi_Passive_EX",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DEFWEAKENUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_NXYYi_Passive_EX"
						}
					}, {
						buffeft1
					}, 1)
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "AngerRateDown",
						group = "Skill_NXYYi_Passive_EX_1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive_EX_1",
							"UNDISPELLABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
				end

				local friendUnits = global.FriendUnits(_env)

				if friendUnits and #friendUnits > 1 then
					local randomIndex = global.Random(_env, 1, #friendUnits) - 1
					local targetFriend = friendUnits[randomIndex]
					local critRateBuff = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, targetFriend, {
						timing = 0,
						display = "CritRateUp",
						group = "Skill_NXYYi_Passive_Crit",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CRITICALUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_NXYYi_Passive_Crit"
						}
					}, {
						critRateBuff
					}, 1)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, this.DeRageGainFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "AngerRateDown",
						group = "Skill_NXYYi_Passive_EX_1",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"ANGERRATEDOWN",
							"Skill_NXYYi_Passive_EX_1",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				else
					local buffeft2 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, this.DefWeakenRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "DefWeakenUp",
						group = "Skill_NXYYi_Passive_EX",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DEFWEAKENUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Skill_NXYYi_Passive_EX"
						}
					}, {
						buffeft2
					}, 1)

					for _, f in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, f, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_Crit"))
					end

					local friendUnits = global.FriendUnits(_env)

					if friendUnits and #friendUnits > 1 then
						local randomIndex = global.Random(_env, 1, #friendUnits) - 1
						local targetFriend = friendUnits[randomIndex]
						local critRateBuff = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, this.CritRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, targetFriend, {
							timing = 0,
							display = "CritRateUp",
							group = "Skill_NXYYi_Passive_Crit",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"CRITICALUP",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_NXYYi_Passive_Crit"
							}
						}, {
							critRateBuff
						}, 1)
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

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_EX_1"))
				end

				for _, unit2 in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit2, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_EX"))
				end

				for _, unit2 in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit2, global.BUFF_MARKED(_env, "Skill_NXYYi_Passive_Crit"))
				end
			end)

			return _env
		end
	}

	return _M
end
