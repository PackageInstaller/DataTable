-- chunkname: @/tmp/or_skill/lua_compile/Skill_HGEr.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_HGEr_Normal = {
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
				367
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
	_M.__all__.Skill_HGEr_Proud = {
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
				534
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
	_M.__all__.Skill_HGEr_Unique = {
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
				2167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR)
				local shield = global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)
				local rate = global.min(_env, this.RateFloor * 100 * (hp + shield) / maxHp, this.MaxRate)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.DelayCall(_env, 134, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 1, rate)
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Passive = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_Uni_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_Uni_No_Crit"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_Uni_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_No_Crit"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive5 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_key = global.SpecialNumericEffect(_env, "+For_HGEr_Key", {
					"+Normal",
					"+Normal"
				}, this.AoeDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"For_HGEr_Key"
					}
				}, {
					buff_key
				})
			end)

			return _env
		end,
		passive6 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.PassiveFunEffectBuff(_env, "Skill_Sustained_Shield", {
					ShieldRateFactor = this.ShieldRateFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_HGEr_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Passive_Key = {
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

				if global.MARKED(_env, "HGEr")(_env, _env.ACTOR) then
					local AoeDeRateFactor = global.SpecialPropGetter(_env, "For_HGEr_Key")(_env, _env.ACTOR)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR))) do
						local buff = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, AoeDeRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							duration = 99,
							group = "Skill_HGEr_Passive_Key",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"Skill_HGEr_Passive_Key",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1, 0)
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
				local flag = 0
				local AoeDeRateFactor = global.SpecialPropGetter(_env, "For_HGEr_Key")(_env, _env.ACTOR)

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "HGEr")(_env, _env.ACTOR) then
					for _, unit1 in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.unit))) do
						if global.MARKED(_env, "HGEr")(_env, unit1) then
							flag = 1
						end
					end

					if flag == 1 then
						local buff = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, AoeDeRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
							duration = 99,
							group = "Skill_HGEr_Passive_Key",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"Skill_HGEr_Passive_Key",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1, 0)
					end
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "HGEr")(_env, _env.unit) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_HGEr_Passive_Key"), 99)
					end
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.oldCell = externs.oldCell

			assert(_env.oldCell ~= nil, "External variable `oldCell` is not provided.")

			_env.newCell = externs.newCell

			assert(_env.newCell ~= nil, "External variable `newCell` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.CellColLocation(_env, _env.oldCell) ~= global.CellColLocation(_env, _env.newCell) and global.MARKED(_env, "HGEr")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_HGEr_Passive_Key"), 99)
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR))) do
						local buff = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, global.AoeDeRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							duration = 99,
							group = "Skill_HGEr_Passive_Key",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"Skill_HGEr_Passive_Key",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						}, 1, 0)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_Sustained_Shield = {
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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local shield = global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)
				local shield_add = global.ShieldEffect(_env, global.min(_env, maxHp * this.ShieldRateFactor, atk * 0.25))

				if shield < maxHp then
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "Skill_HGEr_Passive",
						duration = 99,
						limit = 999,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"Skill_HGEr_Passive",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield_add
					}, 1)
				end

				if global.IsAwaken(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR))) do
						if global.MASTER(_env, unit) == false then
							local maxHp_friend = global.UnitPropGetter(_env, "maxHp")(_env, unit)
							local shield_friend = global.UnitPropGetter(_env, "shield")(_env, unit)
							local FriendShieldRateFactor = global.SpecialPropGetter(_env, "For_HGEr_FriendShieldRateFactor")(_env, _env.ACTOR)
							local shield_friend_add = global.ShieldEffect(_env, global.min(_env, maxHp * FriendShieldRateFactor, atk * 0.25))

							if shield_friend < maxHp_friend then
								global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
									timing = 0,
									display = "Shield",
									group = "Skill_HGEr_Passive",
									duration = 99,
									limit = 999,
									tags = {
										"NUMERIC",
										"BUFF",
										"SHIELD",
										"Skill_HGEr_Passive",
										"DISPELLABLE",
										"STEALABLE"
									}
								}, {
									shield_friend_add
								}, 1)
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Proud_EX = {
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
				534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local heal = global.min(_env, maxHp * this.HpRateFactor, atk * 1.2)

				global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, _env.ACTOR, heal)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Unique_EX = {
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
				2167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.RetainObject(_env, _env.TARGET)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.ACTOR)
				local shield = global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)
				local rate = global.min(_env, this.RateFloor * 100 * (hp + shield) / maxHp, this.MaxRate)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.DelayCall(_env, 134, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 1, rate)
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Passive_EX = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_Uni_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_Uni_No_Crit"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_Uni_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_No_Crit"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive5 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_key = global.SpecialNumericEffect(_env, "+For_HGEr_Key", {
					"+Normal",
					"+Normal"
				}, this.AoeDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"For_HGEr_Key"
					}
				}, {
					buff_key
				})
			end)

			return _env
		end,
		passive6 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.PassiveFunEffectBuff(_env, "Skill_Sustained_Shield", {
					ShieldRateFactor = this.ShieldRateFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_HGEr_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_HGEr_Passive_Awaken = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_Uni_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_Uni_No_Crit"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_Uni_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "+HGEr_Passive_No_Crit", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"HGEr_Passive_No_Crit"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "HGEr_Passive_No_Crit"), 99)
				end
			end)

			return _env
		end,
		passive5 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_key = global.SpecialNumericEffect(_env, "+For_HGEr_Key", {
					"+Normal",
					"+Normal"
				}, this.AoeDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"For_HGEr_Key"
					}
				}, {
					buff_key
				})
			end)

			return _env
		end,
		passive6 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_friend = global.SpecialNumericEffect(_env, "+For_HGEr_FriendShieldRateFactor", {
					"+Normal",
					"+Normal"
				}, this.FriendShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"FPassiveFunEffectBuffor_HGEr_FriendShieldRateFactor"
					}
				}, {
					buff_friend
				})

				local buffeft = global.PassiveFunEffectBuff(_env, "Skill_Sustained_Shield", {
					ShieldRateFactor = this.ShieldRateFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_HGEr_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}

	return _M
end
