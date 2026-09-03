-- chunkname: @/tmp/or_skill/lua_compile/Skill_BLTu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BLTu_Normal = {
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
				467
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
	_M.__all__.Skill_BLTu_Proud = {
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
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.NumericEffect(_env, "-hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateDown)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					display = "HurtRateDown",
					group = "Skill_BLTu_Proud",
					duration = 1,
					limit = 1,
					tags = {
						"NUMERIC",
						"DEBUFF",
						"HURTRATEDOWN",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				_env.units = global.FriendUnits(_env)
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				for _, friendunit in global.__iter__(global.FriendUnits(_env)) do
					local shield = global.ShieldEffect(_env, global.min(_env, maxHp * this.ShieldRateFactor, atk * 2))
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						display = "Shield",
						group = "Skill_BLTu_Unique",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield,
						buffeft
					}, 1)
				end

				local buff_show = global.SpecialNumericEffect(_env, "+baohuzhao", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 2,
					display = "Protecto",
					group = "Skill_BLTu_Unique_Show",
					duration = 2,
					limit = 1,
					tags = {
						"BAOHUZHAO",
						"BLTu_Unique"
					}
				}, {
					buff_show
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 2,
					tags = {
						"BLTu_Unique_Check"
					}
				}, {
					buff_show
				})
			end)
			exec["@time"]({
				2770
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buffcount = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"))

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and buffcount > 0 then
					local shield = global.ShieldEffect(_env, global.min(_env, maxHp * this.ShieldRateFactor, atk * 2))
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 2,
						display = "Shield",
						group = "Skill_BLTu_Unique",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield,
						buffeft
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"), 99)
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "BLTu_Unique_Check") then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Passive = {
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

				if global.MARKED(_env, "BLTu")(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							duration = 99,
							group = "Skill_BLTu_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"BLTu_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						}, 1, 0)
					end

					local buff = global.PassiveFunEffectBuff(_env, "BLTu_Protecto_Kick", {})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"BLTu_Protecto_Kick"
						}
					}, {
						buff
					})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_BLTu_Passive",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"BLTu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "AOEDERATEUP", "BLTu_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Passive_Key = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
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
				local flag = 0

				for _, friend in global.__iter__(global.FriendUnits(_env)) do
					if global.MARKED(_env, "BLTu")(_env, friend) then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "WARRIOR")(_env, _env.unit) and flag == 1 then
					local buffeft = global.Taunt(_env)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 1,
						display = "Taunt",
						group = "Skill_BLTu_Passive_Key",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"TAUNT",
							"Skill_BLTu_Passive_Key",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.BLTu_Protecto_Kick = {
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

				if global.MARKED(_env, "BLTu")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Proud_EX = {
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
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.NumericEffect(_env, "-hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateDown)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					display = "HurtRateDown",
					group = "Skill_BLTu_Proud",
					duration = 1,
					limit = 1,
					tags = {
						"NUMERIC",
						"DEBUFF",
						"HURTRATEDOWN",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				_env.units = global.FriendUnits(_env)
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				for _, friendunit in global.__iter__(global.FriendUnits(_env)) do
					local shield = global.ShieldEffect(_env, global.min(_env, maxHp * this.ShieldRateFactor, atk * 2))
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friendunit, {
						timing = 2,
						display = "Shield",
						group = "Skill_BLTu_Unique",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield,
						buffeft
					}, 1)
				end

				local buff_show = global.SpecialNumericEffect(_env, "+baohuzhao", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 2,
					display = "Protecto",
					group = "Skill_BLTu_Unique_Show",
					duration = 2,
					limit = 1,
					tags = {
						"BAOHUZHAO",
						"BLTu_Unique"
					}
				}, {
					buff_show
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 2,
					tags = {
						"BLTu_Unique_Check"
					}
				}, {
					buff_show
				})
			end)
			exec["@time"]({
				2770
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local buffcount = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"))

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and buffcount > 0 then
					local shield = global.ShieldEffect(_env, global.min(_env, maxHp * this.ShieldRateFactor, atk * 2))
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 2,
						display = "Shield",
						group = "Skill_BLTu_Unique",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield,
						buffeft
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"), 99)
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "BLTu_Unique_Check") then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BLTu_Passive_EX = {
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

				if global.MARKED(_env, "BLTu")(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							duration = 99,
							group = "Skill_BLTu_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"BLTu_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						}, 1, 0)
					end

					local buff = global.PassiveFunEffectBuff(_env, "BLTu_Protecto_Kick", {})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"BLTu_Protecto_Kick"
						}
					}, {
						buff
					})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "Skill_BLTu_Passive",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"AOEDERATEUP",
							"BLTu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "AOEDERATEUP", "BLTu_Passive", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}

	return _M
end
