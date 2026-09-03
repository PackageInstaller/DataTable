-- chunkname: @/tmp/or_skill/lua_compile/EquipSkill.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.EquipSkill_Weapon_15133_1 = {
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
				local count = #global.SelectBuffs(_env, _env.ACTOR, global.BUFF_MARKED(_env, "BUFF"))

				global.print(_env, count, "buff层数=======")

				if count > 8 then
					count = 8
				end

				global.print(_env, global.UnitPropGetter(_env, "hurtrate")(_env, _env.ACTOR), this.gain, "属性1=========")

				local Weapon_15133_1_hurtrate = this.gain
				local Weapon_15133_1_unhurtrate = this.gain

				if count >= 1 then
					for i = 1, count - 1 do
						local hurtrate_buff = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, Weapon_15133_1_hurtrate)
						local unhurtrate_buff = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, Weapon_15133_1_unhurtrate)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 20,
							group = "EquipSkill_Weapon_15133_1_a",
							timing = 4,
							limit = 7,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Weapon_15133_1"
							}
						}, {
							hurtrate_buff
						}, 1)
						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 20,
							group = "EquipSkill_Weapon_15133_1_b",
							timing = 4,
							limit = 7,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Weapon_15133_1"
							}
						}, {
							unhurtrate_buff
						}, 1)
					end

					local hurtrate_buff = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, Weapon_15133_1_hurtrate)
					local unhurtrate_buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, Weapon_15133_1_unhurtrate)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 4,
						display = "HurtRateUp",
						group = "EquipSkill_Weapon_15133_1_aa",
						duration = 20,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_15133_1"
						}
					}, {
						hurtrate_buff
					}, 1)
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 4,
						display = "UnHurtRateUp",
						group = "EquipSkill_Weapon_15133_1_bb",
						duration = 20,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_15133_1"
						}
					}, {
						unhurtrate_buff
					}, 1)
				end

				global.print(_env, global.UnitPropGetter(_env, "hurtrate")(_env, _env.ACTOR), "属性2=========")
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15132_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.nummax = 3
			_env.num = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft_num = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15132_2_num" .. global.GetUnitCid(_env, _env.ACTOR), {
					"+Normal",
					"+Normal"
				}, _env.num)

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 999,
					group = "EquipSkill_Weapon_15132_2_num",
					timing = 0,
					limit = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15132_2_num"
					}
				}, {
					buffeft_num
				})

				local buffeft_MaximumLifeBonus = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15132_2_MaximumLifeBonus", {
					"+Normal",
					"+Normal"
				}, this.MaximumLifeBonus)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 999,
					group = "EquipSkill_Weapon_15132_2_MaximumLifeBonus",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15132_2_MaximumLifeBonus"
					}
				}, {
					buffeft_MaximumLifeBonus
				})

				local buffeft_nummax = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15132_2_nummax", {
					"+Normal",
					"+Normal"
				}, _env.nummax)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 999,
					group = "EquipSkill_Weapon_15132_2_nummax",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15132_2_nummax"
					}
				}, {
					buffeft_nummax
				})
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.curativeEFFect = 0.15

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_RatioCheck", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_ExtraRate", {
					"+Normal",
					"+Normal"
				}, _env.curativeEFFect)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 999,
					group = "EquipSkill_Weapon_15132_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15132_2"
					}
				}, {
					buffeft1,
					buffeft2
				})
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "NUMERIC", "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "EquipSkill_Weapon_15132_2"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15001 = {
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
				local buffeft1 = global.Immune(_env)
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEBUFF"))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 4,
					display = "Immune",
					duration = this.ImmuneTime,
					tags = {
						"NUMERIC",
						"BUFF",
						"IMMUNE",
						"DISPELLABLE",
						"STEALABLE",
						"UR_EQUIPMENT",
						"DURANDAL"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15002 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15002",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15002", "UNDISPELLABLE", "UNSTEALABLE"), 99)

				if global.ProbTest(_env, this.ProbFactor) then
					global.ApplyRPRecovery(_env, _env.ACTOR, 1000)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15003 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15003_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15003_biaozhi"
					}
				}, {
					buffeft
				}, 1)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15003_biaozhi")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.UniqueDamageFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Weapon_15003",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15003", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15003_biaozhi"), 99)
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15004 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetPlayerEnergy(_env) >= 2 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.primTrgt)
					local buffeft1 = global.NumericEffect(_env, "-atk", {
						"+Normal",
						"+Normal"
					}, atk * this.AtkRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.primTrgt, {
						timing = 2,
						display = "AtkDown",
						group = "EquipSkill_Weapon_15004_Down",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"DEBUFF",
							"ATKDOWN",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					local buffeft2 = global.NumericEffect(_env, "+atk", {
						"+Normal",
						"+Normal"
					}, atk * this.AtkRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						display = "AtkUp",
						group = "EquipSkill_Weapon_15004_Up",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"DEBUFF",
							"ATKUP",
							"UNDISPELLABLE"
						}
					}, {
						buffeft2
					}, 1, 0)
					global.ApplyEnergyDamage(_env, global.GetOwner(_env, _env.ACTOR), 2)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15005 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+shield_effect", {
					"?Normal"
				}, this.ShieldEffect)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_unhurtrate", {
					"?Normal"
				}, this.DamageDeFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_unhurtrate", {
					"?Normal"
				}, this.DamageDeFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15005"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15006 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15006_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15006_biaozhi"
					}
				}, {
					buffeft
				}, 1)

				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_ABSORPTIONUP",
						"EquipSkill_Weapon_15006",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15006_biaozhi")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DamageFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Weapon_15006",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15006", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15006_biaozhi"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15007 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15007_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15007_biaozhi"
					}
				}, {
					buffeft
				}, 1)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15007_biaozhi")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DamageFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Weapon_15006",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
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
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * 0.6, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"CURSE",
							"DISPELLABLE",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15007", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15007_biaozhi"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15007 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15007_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15007_biaozhi"
					}
				}, {
					buffeft
				}, 1)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15007_biaozhi")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DamageFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Weapon_15007",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
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
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * 0.6, 1)
					local buffeft2 = global.Curse(_env)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "Poison",
						group = "CURSE",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"CURSE",
							"DISPELLABLE",
							"POISON",
							"ABNORMAL"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15007", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15007_biaozhi"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15008 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15008_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15008_biaozhi"
					}
				}, {
					buffeft
				}, 1)
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
				local buffeft2 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.DamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15008",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15008", "UNDISPELLABLE", "UNSTEALABLE"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15009 = {
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

				if global.SelectBuffCount_Unit(_env, global.EnemyUnits(_env), "MURDERER") > 0 then
					local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2_up = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15009_show", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Weapon_15009_biaozhi_1",
						timing = 0,
						limit = 1,
						tags = {
							"EquipSkill_Weapon_15009_biaozhi",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"HURTRATEUP"
						}
					}, {
						buffeft2
					}, 1)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15009_biaozhi", "UNHURTRATEUP"), 99)
				end

				if global.SelectBuffCount_Unit(_env, global.EnemyUnits(_env), "MURDERER") == 0 then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft1_up = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15008_show", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Weapon_15009_biaozhi_2",
						timing = 0,
						limit = 1,
						tags = {
							"EquipSkill_Weapon_15009_biaozhi",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"UNHURTRATEUP"
						}
					}, {
						buffeft1
					}, 1)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15009_biaozhi", "HURTRATEUP"), 99)
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

				if global.SelectBuffCount_Unit(_env, global.EnemyUnits(_env), "MURDERER") > 0 then
					local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Weapon_15009_biaozhi_1",
						timing = 0,
						limit = 1,
						tags = {
							"EquipSkill_Weapon_15009_biaozhi",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"HURTRATEUP"
						}
					}, {
						buffeft2
					}, 1)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15009_biaozhi", "UNHURTRATEUP"), 99)
				end

				if global.SelectBuffCount_Unit(_env, global.EnemyUnits(_env), "MURDERER") == 0 then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Weapon_15009_biaozhi_2",
						timing = 0,
						limit = 1,
						tags = {
							"EquipSkill_Weapon_15009_biaozhi",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"UNHURTRATEUP"
						}
					}, {
						buffeft1
					}, 1)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15009_biaozhi", "HURTRATEUP"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15101_1 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15101_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15101_biaozhi"
					}
				}, {
					buffeft
				}, 1)

				local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15101_First", {
					"+Normal",
					"+Normal"
				}, this.FirstFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15101_Second", {
					"+Normal",
					"+Normal"
				}, this.SecondFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15101"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1)
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
				local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15101",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					global.buffeft2
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNIQUE_HURTRATEUP", "EquipSkill_Weapon_15101", "UNDISPELLABLE", "UNSTEALABLE"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15102_2 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15102_2_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15102_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				}, 1)
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
				local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15102_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15102_2"), 99)

				local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR)
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

				if hpRatio < 0.4 then
					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15103_3 = {
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

				if global.SpecialPropGetter(_env, "EquipSkill_Weapon_15103_3_check")(_env, global.FriendField(_env)) < 2 then
					local count = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "TAUNT")) > 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "STEALTH")) == 0 then
							count = count + 1

							global.print(_env, "释放大招前还存在嘲讽角色", count)
							global.ApplyRPDamage(_env, unit, this.RageFactor)

							break
						end
					end

					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.MARKED(_env, "FTLYShi")(_env, unit) and global.IsAlive(_env, unit) then
							count = count + 1

							global.print(_env, "奥古斯特在场", count)

							local TAR = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.HASBUFFTAG(_env, global.BUFF_MARKED(_env, "STEALTH"))))

							global.print(_env, "谁", global.GetUnitCid(_env, _env.ACTOR), "受奥古斯特影响当前随机目标为", global.GetUnitId(_env, TAR[1]))
							global.AssignRoles(_env, TAR[1], "target")

							local buff_taunt = global.Taunt(_env)

							global.ApplyBuff(_env, TAR[1], {
								duration = 2,
								group = "Skill_FTLYShi_Passive_1",
								timing = 4,
								limit = 1,
								tags = {
									"Skill_FTLYShi_Passive_Taunt"
								}
							}, {
								buff_taunt
							})
							global.ApplyRPDamage(_env, TAR[1], this.RageFactor)

							break
						end
					end

					if count == 0 then
						global.AssignRoles(_env, global.EnemyMaster(_env), "target")

						local buff_taunt_2 = global.Taunt(_env)

						global.ApplyBuff(_env, global.EnemyMaster(_env), {
							timing = 4,
							duration = 2,
							tags = {
								"NUMERIC",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Weapon_15103_3_Taunt"
							}
						}, {
							buff_taunt_2
						}, 1)
						global.ApplyRPDamage(_env, global.EnemyMaster(_env), this.RageFactor)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15103_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				}, 1)
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15103_3_check", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				}, 1)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15103_3"), 99)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15103_3_Taunt"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15104_1 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15104_1_check", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
					}, 1)

					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Weapon_15104_1_Passive", {
						MaxHpFactor = this.MaxHpFactor
					})

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15104_1_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.primTrgt) == false and not global.MARKED(_env, "SummonedNian") and global.SpecialPropGetter(_env, "EquipSkill_Weapon_15104_1_check")(_env, _env.ACTOR) > 0 then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.primTrgt)

					global.ApplyHPDamage(_env, _env.primTrgt, maxHp * this.MaxHpFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15105_2 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15105_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft2 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "Shield",
					group = "EquipSkill_Weapon_15105_2",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
				global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15105_2"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15106_3 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_RatioCheck", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_ExtraRate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15106_3",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15106_3"
					}
				}, {
					buffeft1,
					buffeft2
				})

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS)) do
					if global.MASTER(_env, unit) == false then
						local buffeft3 = global.SpecialNumericEffect(_env, "+BeCuredRage", {
							"+Normal",
							"+Normal"
						}, this.RageFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"NUMERIC",
								"BUFF",
								"EquipSkill_Weapon_15106_3",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"UR_EQUIPMENT"
							}
						}, {
							buffeft3
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15106_3"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15107_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15107_1",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})

				local HpRatioFactor = global.UnitPropGetter(_env, "hpRatio")(_env, _env.primTrgt)
				local Energy = 2

				if HpRatioFactor > 0.5 and global.SpecialPropGetter(_env, "EquipSkill_Weapon_15107_1")(_env, global.FriendField(_env)) < 2 then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), Energy)

					local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15107_1", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15107_1"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15108_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15108_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15108_2"), 99)
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHpCheckRate", {
					"+Normal",
					"+Normal"
				}, 0.5)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15108_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15109_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AttackFactor)
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.DamageFactor)
				local buffeft3 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKRATEUP",
						"HURTRATEUP",
						"CRITRATEUP",
						"EquipSkill_Weapon_15109",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15110_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive0 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+weapon_15110_1", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15110_1",
					timing = 0,
					limit = 1,
					tags = {
						"DEBUFF",
						"EquipSkill_Weapon_15110_1_UnHurtCheck",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15110_1",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15110_1"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15111_2 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+singleweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+singleunhurtratedown", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateDownFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15111_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15111_2"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15112_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15112_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.primTrgt)
				local hp = global.UnitPropGetter(_env, "hp")(_env, _env.primTrgt)
				local hl = maxHp - hp
				local damage1 = hl * 0.35
				local damage2 = 1.6 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				global.ApplyHPDamage(_env, _env.primTrgt, (damage2 < damage1 or nil) and damage2)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15112_3"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15113_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15113_1",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15113_1"), 99)
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+aoecritsplitrate", {
					"+Normal",
					"+Normal"
				}, 0.4)
				local buffeft2 = global.SpecialNumericEffect(_env, "+singlecritsplitrate", {
					"+Normal",
					"+Normal"
				}, 0.4)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15113_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15114_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15108_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15114_2"), 99)

				if _env.primTrgt then
					local Shield = 0.2 * global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)

					if Shield then
						global.ApplyHPDamage(_env, _env.primTrgt, Shield)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15115_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive0 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+weapon_15115_3", {
					"?Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Weapon_15115_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15116_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.actor = externs.actor

			assert(_env.actor ~= nil, "External variable `actor` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.actor == _env.ACTOR then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 3,
						group = "EquipSkill_Weapon_15116_1",
						timing = 1,
						limit = 5,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Weapon_15116_1",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15117_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AttackFactor)
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpFactor)
				local buffeft3 = global.NumericEffect(_env, "+curerate_weapon_15117_2", {
					"+Normal",
					"+Normal"
				}, this.CureShieldEffectFactor)
				local buffeft4 = global.SpecialNumericEffect(_env, "+shield_effect", {
					"?Normal"
				}, this.CureShieldEffectFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Weapon_15117_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15118_3 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+shield_effect", {
					"?Normal"
				}, this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Weapon_15118_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15119_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive0 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+weapon_15119_1_check", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"EquipSkill_Weapon_15119_1_Check",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15119_1",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15119_1"), 99)
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.actor = externs.actor

			assert(_env.actor ~= nil, "External variable `actor` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.actor == _env.ACTOR then
					local buffeft1 = global.SpecialNumericEffect(_env, "+weapon_15119_1", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					}, 1)

					if global.SpecialPropGetter(_env, "weapon_15119_1")(_env, global.FriendField(_env)) % 3 == 0 and global.EnemyMaster(_env) then
						global.ApplyHPDamage(_env, global.EnemyMaster(_env), global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.2)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15120_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+weapon_15120_2", {
					"+Normal",
					"+Normal"
				}, this.CureFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15120_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15120_2"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15121_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15121_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)

				local count = global.SpecialNumericEffect(_env, "+weapon_15121_3_count", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Weapon_15121_3_Count",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					count
				})

				if global.SpecialPropGetter(_env, "weapon_15121_3_count")(_env, global.FriendField(_env)) == 1 then
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Weapon_15121_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15121_3"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15122_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15122_1_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15122_1_Uni"), 99)
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
				local Critrate = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)
				local Critstrg = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritStrgFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15121",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					Critrate
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15121",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					Critstrg
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15123_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+shield_effect", {
					"?Normal"
				}, this.UniqueShieldFactor)
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "MUTE"))
				local buffeft3 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "CURSE"))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_SHIELD",
						"EquipSkill_Weapon_15123_2_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"EquipSkill_Weapon_15123_2",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"EquipSkill_Weapon_15123_2",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft3
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

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15123_2_Uni"), 99)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "MUTE"))
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "CURSE"))

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "BAOHUZHAO", "BLTu_Unique")) > 0 then
					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"EquipSkill_Weapon_15123_2",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"EquipSkill_Weapon_15123_2",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "BLTu_Unique_Check") then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15123_2"), 99)
					end
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15123_2"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15124_3 = {
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
				local hurtrate = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "HurtRateUp",
					group = "EquipSkill_Weapon_15124_3",
					duration = 99,
					limit = 5,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					hurtrate
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15125_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15125_1_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15125_1_Uni"), 99)

				local wolfs = global.FriendUnits(_env, global.SUMMONS * global.HASSTATUS(_env, "SummonedXHMao"))
				local buffeft1 = global.Diligent(_env)

				for _, wolf in global.__iter__(wolfs) do
					global.ApplyBuff(_env, wolf, {
						timing = 2,
						duration = 1,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				global.DiligentRound(_env)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15126_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15126_2_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15126_2_Uni"), 99)
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

				if global.SUMMONS(_env, _env.unit) and global.GetSummoner(_env, _env.unit) == _env.ACTOR then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "UnHurtRateUp",
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15127_3 = {
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
				local buffeft1 = global.PassiveFunEffectBuff(_env, "EquipSkill_Weapon_15127_field", {
					HurtRateFactor = this.HurtRateFactor,
					master = _env.ACTOR
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15127_field",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15127_field = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SUMMONS(_env, _env.unit) and global.GetSummoner(_env, _env.unit) == this.master then
					local buffeft1 = global.PassiveFunEffectBuff(_env, "EquipSkill_Weapon_15127_3_Passive")

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15127_3_Passive = {
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

				if global.INSTATUS(_env, "SummonedHLDKen")(_env, _env.ACTOR) then
					return
				else
					global.KillTarget(_env, _env.ACTOR)
				end
			end)

			return _env
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

				if global.INSTATUS(_env, "SummonedHLDKen")(_env, _env.ACTOR) then
					return
				else
					global.KillTarget(_env, _env.ACTOR)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15128_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15128_1_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15128_1_Uni"), 99)
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
				local count = global.SpecialNumericEffect(_env, "+weapon_15128_1_count", {
					"?Normal"
				}, 0)

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Weapon_15128_1_Count")) < 3 then
					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Weapon_15128_1_Count",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						count
					})
					global.ApplyEnergyDamage(_env, global.GetOwner(_env, _env.unit), this.Cost)
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Cost)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15129_2 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+weapon_15129_2_flag", {
					"?Normal"
				}, this.MHDmgFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"FLAG",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15129_2_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15129_2_Uni"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15130_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"?Normal"
				}, this.CureFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
			end)

			return _env
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ShieldFactor = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local shield = global.ShieldEffect(_env, ShieldFactor)

				if global.FriendMaster(_env) then
					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						display = "Shield",
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield
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

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ShieldFactor = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
				local shield = global.ShieldEffect(_env, ShieldFactor)

				if global.FriendMaster(_env) then
					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						display = "Shield",
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15131_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.UniqueDamageFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Weapon_15131_1_Uni",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15131_1_Uni"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15134_2 = {
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
				local buff1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, 0.1)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Weapon_15134_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buff1
				}, 1)

				local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15134_2_dam", {
					"+Normal",
					"+Normal"
				}, this.dam)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Weapon_15134_2_dam"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}

	function _M.__all__.EquipSkill_Weapon_15134_2_extra(_env, actor, target)
		local this, global = _env.this, _env.global
		local dam = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15134_2_dam")(_env, actor)
		local actor_atk = global.UnitPropGetter(_env, "atk")(_env, actor)
		local actor_hp = global.UnitPropGetter(_env, "hp")(_env, actor)
		local target_atk = global.UnitPropGetter(_env, "atk")(_env, target)
		local target_hp = global.UnitPropGetter(_env, "hp")(_env, target)
		local atk_rate = (target_atk - actor_atk) / actor_atk

		global.dump(_env, {
			target_atk = target_atk,
			actor_atk = actor_atk,
			atk_rate = atk_rate
		})

		if atk_rate < 0 then
			atk_rate = 0
		end

		local hp_rate = (target_hp - actor_hp) / actor_hp

		global.dump(_env, {
			target_hp = target_hp,
			actor_hp = actor_hp,
			hp_rate = hp_rate
		})

		if hp_rate < 0 then
			hp_rate = 0
		end

		local ah_rate = atk_rate + hp_rate

		if ah_rate > 0.1 then
			ah_rate = 0.1
		end

		if global.Judge_the_unit_behind_the_grid(_env, target) == false then
			ah_rate = ah_rate + dam
		end

		global.print(_env, "目标为", global.GetUnitCid(_env, target), "权柄明珠-最终额外加成：atk_rate", atk_rate, "+ hp_rate", hp_rate, "+ 目标身后检测 =", ah_rate)

		return ah_rate
	end

	_M.__all__.EquipSkill_Weapon_15135_3 = {
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15135_3_2")) < 3 then
					local buffeft3 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 1,
						display = "HurtRateUp",
						group = "EquipSkill_Weapon_15135_3_2",
						duration = 3,
						limit = 3,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Weapon_15135_3_2"
						}
					}, {
						buffeft3
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * this.AtkFactor)
				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15135_3_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Weapon_15135_3_1",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_15136_1 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15136_1_HurtRateFactor", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15136_1_HurtRateFactor",
					timing = 0,
					limit = 1,
					tags = {
						"EquipSkill_Weapon_15136_1_HurtRateFactor"
					}
				}, {
					buffeft1
				})
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
				local count = global.GetPlayerEnergy(_env, _env.ACTOR)
				local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_15136_1_EnergyCount", {
					"+Normal",
					"+Normal"
				}, count)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_15136_1_EnergyCount",
					timing = 0,
					limit = 1,
					tags = {
						"EquipSkill_Weapon_15136_1_EnergyCount"
					}
				}, {
					buffeft1
				})
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15136_1_EnergyCount"), 99)
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15136_1_EnergyCount")(_env, _env.ACTOR)

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RPFactor * count)
				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15136_1_EnergyCount"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Tops_15114_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.detail = externs.detail

			assert(_env.detail ~= nil, "External variable `detail` is not provided.")

			_env.dam = _env.detail.eft

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local dun = _env.dam * this.Shield_volume

				global.print(_env, "获得护盾===", dun)

				local shield = global.ShieldEffect(_env, dun)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 2,
					display = "Shield",
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD"
					}
				}, {
					shield
				}, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15001 = {
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
				local buff_hurt = global.SpecialNumericEffect(_env, "+hurt_lionheart", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"LIONHEART",
						"HURTED"
					}
				}, {
					buff_hurt
				})
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_lionheart = global.SpecialPropGetter(_env, "hurt_lionheart")(_env, _env.ACTOR)

					if hurt_lionheart and hurt_lionheart ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "LIONHEART", "HURTED"), 99)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_lionheart = global.SpecialPropGetter(_env, "hurt_lionheart")(_env, _env.ACTOR)

					if hurt_lionheart and hurt_lionheart ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "LIONHEART", "HURTED"), 99)

						local count_lionheart = global.SpecialPropGetter(_env, "count_lionheart")(_env, _env.ACTOR)

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UR_EQUIPMENT", "LIONHEART", "COUNT")) < this.MaxCount then
							local buff_count = global.SpecialNumericEffect(_env, "+count_lionheart", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, _env.ACTOR, {
								timing = 0,
								duration = 99,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT",
									"LIONHEART",
									"COUNT"
								}
							}, {
								buff_count
							})

							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

							global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15002 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+blockstrg", {
					"+Normal",
					"+Normal"
				}, this.BlockStrgFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "BlockRateUp",
					group = "EquipSkill_Armor_15002_1",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"BLOCKRATEUP",
						"EquipSkill_Accesory_15003",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "BlockStrgUp",
					group = "EquipSkill_Armor_15002_2",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"BLOCKSTRGUP",
						"EquipSkill_Accesory_15003",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15003 = {
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

				if global.SpecialPropGetter(_env, "equip_armor_15003")(_env, _env.ACTOR) < 3 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)

					local buff_hurt = global.SpecialNumericEffect(_env, "+equip_armor_15003", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15003",
							"HURTED"
						}
					}, {
						buff_hurt
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15004 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
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

				if global.BuffIsMatched(_env, _env.buff, "SHIELD") then
					local buff = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "EquipSkill_Armor_15004",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15004"
						}
					}, {
						buff
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "SHIELD") then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15004"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15005 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
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

				if global.BuffIsMatched(_env, _env.buff, "SHIELD") then
					local shield = global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)

					if shield == 0 then
						local buff_check = global.SpecialNumericEffect(_env, "+Shield_Broked", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "Shield_Broked",
							timing = 0,
							limit = 1,
							tags = {
								"Shield_Broked"
							}
						}, {
							buff_check
						})
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Shield_Broked")) > 0 then
					local shield = global.UnitPropGetter(_env, "shield")(_env, _env.ACTOR)

					if shield == 0 then
						local buff_count = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15005_count", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.RateFactor)
						local buffeft3 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.RateFactor)

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_15005_count", "COUNT")) < 3 then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

							global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.MaxHpFactor)
							global.ApplyBuff(_env, _env.ACTOR, {
								timing = 0,
								duration = 99,
								tags = {
									"EquipSkill_Armor_15005_count",
									"COUNT"
								}
							}, {
								buff_count
							})
							global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
								timing = 0,
								duration = 99,
								display = "HurtRateUp",
								tags = {
									"NUMERIC",
									"BUFF",
									"DISPELLABLE",
									"STEALABLE",
									"UR_EQUIPMENT",
									"EquipSkill_Armor_15005"
								}
							}, {
								buffeft2
							}, 1, 0)
							global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
								timing = 0,
								duration = 99,
								display = "UnHurtRateUp",
								tags = {
									"NUMERIC",
									"BUFF",
									"DISPELLABLE",
									"STEALABLE",
									"UR_EQUIPMENT",
									"EquipSkill_Armor_15005"
								}
							}, {
								buffeft3
							}, 1, 0)
						end
					end
				end

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Shield_Broked"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15006 = {
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
				local buff = global.SpecialNumericEffect(_env, "+rage_morerage_down", {
					"+Normal",
					"+Normal"
				}, this.MoreRage)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15006",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"EquipSkill_Armor_15006",
						"UNDISPELLABLE",
						"UNSTEALABLE"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "RPDOWN_APPLYED")) > 0 then
					local buff = global.SpecialNumericEffect(_env, "+morerage_count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"MORERAGECOUNT"
						}
					}, {
						buff
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "RPDOWN_APPLYED"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15007 = {
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

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.primTrgt == _env.ACTOR and global.GetCost(_env, _env.ACTOR) >= 15 and global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "UR_EQUIPMENT", "count_Armor_15007", "COUNT")) < 1 then
					local buff_hurt = global.SpecialNumericEffect(_env, "+hurt_Armor_15007", {
						"+Normal",
						"+Normal"
					}, this.Energy)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Armor_15007",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15007",
							"HURTED"
						}
					}, {
						buff_hurt
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

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.primTrgt == _env.ACTOR and global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "UR_EQUIPMENT", "EquipSkill_Armor_15007", "HURTED")) < 1 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15007", "HURTED"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15008 = {
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
				local Armor_15008_count = global.SpecialNumericEffect(_env, "+equip_armor_15008_COUNT", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15008_COUNT"
					}
				}, {
					Armor_15008_count
				})
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
				local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR)
				local Armor_15008_flag = global.SpecialNumericEffect(_env, "+Armor_15008_flag", {
					"+Normal",
					"+Normal"
				}, 1)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Armor_15008_COUNT")) > 0 and hpRatio <= 0.4 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15008_FLAG"
						}
					}, {
						Armor_15008_flag
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_15008_COUNT"), 99)
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Armor_15008_FLAG")) > 0 then
					if global.UnitPropGetter(_env, "rp")(_env, _env.ACTOR) == 1000 then
						global.ApplyRPDamage(_env, _env.ACTOR, 1)
					end

					local buffeft2 = global.Daze(_env)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 4,
						duration = 12,
						display = "Freeze",
						tags = {
							"STATUS",
							"DEBUFF",
							"FREEZE",
							"ABNORMAL",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Armor_15008_FREEZE"
						}
					}, {
						buffeft2
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_15008_FLAG"), 99)
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Armor_15008_FREEZE")) > 0 then
					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HpFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15009 = {
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
				local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15009", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15009_check"
					}
				}, {
					buff_check
				})

				if global.SpecialPropGetter(_env, "EquipSkill_Armor_15009")(_env, global.FriendField(_env)) == 1 then
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "EquipSkill_Armor_15009",
						group = "EquipSkill_Armor_15009",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})

					local buff_self = global.PassiveFunEffectBuff(_env, "EquipSkill_Armor_15009_UnhurtRate", {
						UnHurtRateFactor = this.UnHurtRateFactor
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Armor_15009_self",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff_self
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15009_UnhurtRate = {
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
				local units = global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.MARKED(_env, "DAGUN")))

				if units[1] then
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, units[1], {
						timing = 0,
						display = "EquipSkill_Armor_15009",
						group = "EquipSkill_Armor_15009",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})

					local buff_self = global.PassiveFunEffectBuff(_env, "EquipSkill_Armor_15009_UnhurtRate", {
						UnHurtRateFactor = this.UnHurtRateFactor
					})

					global.ApplyBuff(_env, units[1], {
						duration = 99,
						group = "EquipSkill_Armor_15009_self",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff_self
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS - global.MARKED(_env, "DAGUN")))

				if units[1] then
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, units[1], {
						timing = 0,
						display = "EquipSkill_Armor_15009",
						group = "EquipSkill_Armor_15009",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})

					local buff_self = global.PassiveFunEffectBuff(_env, "EquipSkill_Armor_15009_UnhurtRate", {
						UnHurtRateFactor = this.UnHurtRateFactor
					})

					global.ApplyBuff(_env, units[1], {
						duration = 99,
						group = "EquipSkill_Armor_15009_self",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff_self
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "UnHurtRateUp",
					group = "EquipSkill_Armor_15010_1",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				}, 1, 0)
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
				local buff_hurt = global.SpecialNumericEffect(_env, "+hurt_Armor_15010", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15010",
						"HURTED"
					}
				}, {
					buff_hurt
				})
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
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_Armor_15010 = global.SpecialPropGetter(_env, "hurt_Armor_15010")(_env, _env.ACTOR)

					if hurt_Armor_15010 and hurt_Armor_15010 ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15010", "HURTED"), 99)

						local buffeft1 = global.HPPeriodDamage(_env, "Poison", attacker.atk * 0.6, 1)
						local buffeft2 = global.Curse(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
							timing = 1,
							display = "Poison",
							group = "CURSE",
							duration = 2,
							limit = 1,
							tags = {
								"STATUS",
								"DEBUFF",
								"CURSE",
								"DISPELLABLE",
								"ABNORMAL"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_Armor_15010 = global.SpecialPropGetter(_env, "hurt_Armor_15010")(_env, _env.ACTOR)

					if hurt_Armor_15010 and hurt_Armor_15010 ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15010", "HURTED"), 99)
					end
				end
			end)

			return _env
		end,
		passiv5 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15010", "HURTED"), 99)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15010", "HURTED"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15011 = {
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

				if global.GetCost(_env, _env.ACTOR) <= 14 then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.Factor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.Factor)
					local buffeft3 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.Factor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "UnHurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "DefUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "BlockRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft3
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15012 = {
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

				if global.GetCost(_env, _env.ACTOR) <= 10 then
					local buffeft1 = global.DeathImmuneEffect(_env, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Undead",
						group = "EquipSkill_Armor_15012",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNDEAD",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft2 = global.PassiveFunEffectBuff(_env, "Skill_Sustained_RPRecovery", {
						RateFactor = this.RateFactor
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "CShieldRpUp",
						group = "EquipSkill_Armor_15012_RP",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15101_1 = {
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
				local buffeft = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_15101_1",
							timing = 0,
							limit = 1,
							tags = {
								"EquipSkill_Armor_15101_1",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						})
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

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and flag == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_15101_1", "UNDISPELLABLE", "UNSTEALABLE"), 99)
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
				local buffeft = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				if _env.unit ~= _env.ACTOR then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
						if unit then
							global.ApplyBuff(_env, _env.ACTOR, {
								duration = 99,
								group = "EquipSkill_Armor_15101_1",
								timing = 0,
								limit = 1,
								tags = {
									"EquipSkill_Armor_15101_1",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft
							})
						end
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.oldCell = externs.oldCell

			assert(_env.oldCell ~= nil, "External variable `oldCell` is not provided.")

			_env.newCell = externs.newCell

			assert(_env.newCell ~= nil, "External variable `newCell` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local flag = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.FRONT_OF(_env, _env.ACTOR, true))) do
					if unit then
						flag = 1
					end
				end

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and flag == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_15101_1", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15102_2 = {
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
				local UnHurtRate
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, #global.EnemyUnits(_env) < 5 and this.UnHurtRateFactor * 2 or this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15102_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15102_2"
					}
				}, {
					buffeft1
				})
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
				local UnHurtRate = this.UnHurtRateFactor

				if #global.EnemyUnits(_env) >= 5 then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, UnHurtRate)

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "NUMERIC", "BUFF", "UNHURTRATEUP", "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15102_2"), 99)
					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Armor_15102_2",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15102_2"
						}
					}, {
						buffeft1
					})
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, #global.EnemyUnits(_env) < 5 and this.UnHurtRateFactor * 2 or this.UnHurtRateFactor)

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "NUMERIC", "BUFF", "UNHURTRATEUP", "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Armor_15102_2"), 99)
				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15102_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15102_2"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15103_3 = {
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

				if global.SpecialPropGetter(_env, "EquipSkill_Armor_15103_3")(_env, global.FriendField(_env)) == 0 and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.unit ~= _env.ACTOR and (global.MARKED(_env, "ASSASSIN")(_env, _env.unit) or global.MARKED(_env, "MAGE")(_env, _env.unit)) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.MaxHpFactor)
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

					local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15103_3", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15104_1 = {
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

				if global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local buffeft = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "EquipSkill_Armor_15104_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15104_1"
						}
					}, {
						buffeft
					})

					local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15104_1_check", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff_check
					}, 1)

					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Armor_15104_1_Passive")

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = 0

				for _, unit in global.__iter__(global.AllUnits(_env)) do
					if global.SpecialPropGetter(_env, "EquipSkill_Armor_15104_1_check")(_env, unit) > 0 then
						count = count + 1
					end
				end

				if count > 0 then
					local buffeft = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "EquipSkill_Armor_15104_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15104_1"
						}
					}, {
						buffeft
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15104_1_Passive = {
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
				local count = 0

				for _, unit in global.__iter__(global.AllUnits(_env)) do
					if global.SpecialPropGetter(_env, "EquipSkill_Armor_15104_1_check")(_env, unit) > 0 then
						count = count + 1
					end
				end

				if count == 0 then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.SelectHeroPassiveCount(_env, unit, "EquipSkill_Tops_15104_1") > 0 then
							global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "EquipSkill_Armor_15104_1"), 99)

							break
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15105_2 = {
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
				local buff_hurt = global.SpecialNumericEffect(_env, "+hurt_Paladin", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15105_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"PALADIN",
						"HURTED"
					}
				}, {
					buff_hurt
				})
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_Paladin = global.SpecialPropGetter(_env, "hurt_Paladin")(_env, _env.ACTOR)

					if hurt_Paladin and hurt_Paladin ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "PALADIN", "HURTED"), 99)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_Paladin = global.SpecialPropGetter(_env, "hurt_Paladin")(_env, _env.ACTOR)

					if hurt_Paladin and hurt_Paladin ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "PALADIN", "HURTED"), 99)

						if global.SpecialPropGetter(_env, "EquipSkill_Armor_15105_2")(_env, global.FriendField(_env)) < 3 then
							local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR)

							if hpRatio > 0.5 then
								global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

								local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15105_2", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"NUMERIC",
										"BUFF",
										"UNHURTRATEUP",
										"UNDISPELLABLE",
										"UNSTEALABLE",
										"UR_EQUIPMENT"
									}
								}, {
									buffeft
								}, 1)
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15106_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.detail = externs.detail

			assert(_env.detail ~= nil, "External variable `detail` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.detail.eft and _env.detail.eft ~= 0 then
					local heal = _env.detail.eft * this.HealRateFactor

					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						global.ApplyHPRecovery(_env, unit, heal)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15107_1 = {
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "ABNORMAL"), 99)

				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15107_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15107_1"
					}
				}, {
					buffeft1
				})

				local buffeft2 = global.ImmuneBuff(_env, "ABNORMAL")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 4,
					duration = this.ImmuneTime,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Armor_15107_1"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15108_2 = {
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
				local buff = global.SpecialNumericEffect(_env, "+EquipSkill_Armor_15108_2", {
					"+Normal",
					"+Normal"
				}, this.DamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"EquipSkill_Armor_15108_2",
						"UNDISPELLABLE",
						"UNSTEALABLE"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local buff = global.SpecialNumericEffect(_env, "EquipSkill_Armor_15108_2_check", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Armor_15108_2_check"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15109_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Armor_15109_3", {
					"?Normal"
				}, this.RpFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Armor_15109_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15110_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.maxHp = externs.maxHp

			if _env.maxHp == nil then
				_env.maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
			end

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AttackFactor)
				local buffeft2 = global.MaxHpEffect(_env, _env.maxHp * this.MaxHpFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15110_1",
					timing = 0,
					limit = 5,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Armor_15110_1",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15111_2 = {
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
				local AOERate = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)
				local CritRate = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15111_2_AOE",
					timing = 0,
					limit = 3,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Armor_15111_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					AOERate
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_15111_2_Crit",
					timing = 0,
					limit = 3,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Armor_15111_2",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					CritRate
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_15112_3 = {
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
				local count = global.SpecialNumericEffect(_env, "+armor_15112_3_count", {
					"?Normal"
				}, 0)

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Armor_15112_3")) < 3 and global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR) < 0.3 then
					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Armor_15112_3",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						count
					})
					global.ApplyHPRecovery(_env, _env.ACTOR, global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * 0.15)
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
				local count = global.SpecialNumericEffect(_env, "+armor_15112_3_count", {
					"?Normal"
				}, 0)

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Armor_15112_3")) < 3 and global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR) < 0.3 then
					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Armor_15112_3",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						count
					})
					global.ApplyHPRecovery(_env, _env.ACTOR, global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * 0.15)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Tops_15113_1 = {
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
				local master = global.FriendMaster(_env)

				if master then
					global.ApplyHPRecovery(_env, global.FriendMaster(_env), global.UnitPropBaseGetter(_env, "atk")(_env, _env.ACTOR) * this.reply, true)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Tops_15115_3 = {
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
				local friend = global.FriendUnits(_env, -global.SUMMONS - global.ONESELF(_env, _env.ACTOR))

				global.print(_env, "要加多少人=", #friend)

				for _, unit in global.__iter__(friend) do
					global.print(_env, "加受伤触发器===", global.GetUnitCid(_env, unit))

					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Sub_Tops_15115_3", {
						Defense_rate = this.Defense_rate,
						defend = _env.ACTOR
					})

					global.ApplyBuff(_env, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"ES_Sub_Tops_15115_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
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

				global.print(_env, global.GetUnitCid(_env, _env.ACTOR), global.GetUnitCid(_env, _env.unit))
				global.print(_env, global.EqualsCamp(_env, _env.ACTOR, _env.unit), global.SUMMONS(_env, _env.unit) == false, global.ONESELF(_env, _env.ACTOR) == global.ONESELF(_env, _env.unit), "看看判断")

				if global.EqualsCamp(_env, _env.ACTOR, _env.unit) and global.SUMMONS(_env, _env.unit) == false then
					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Sub_Tops_15115_3", {
						Defense_rate = this.Defense_rate,
						defend = _env.ACTOR
					})

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"ES_Sub_Tops_15115_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unti = externs.unti

			assert(_env.unti ~= nil, "External variable `unti` is not provided.")

			_env.dam = externs.dam

			assert(_env.dam ~= nil, "External variable `dam` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local skill_prob = global.CalculateLineupProbability(_env, _env.ACTOR)

				global.print(_env, "ACTOR加之前的防御率为：", global.UnitPropGetter(_env, "defrate")(_env, _env.ACTOR))
				global.print(_env, "unti加之前的当前防御率为：", global.UnitPropGetter(_env, "defrate")(_env, _env.unti))

				local prob = _env.dam % 5

				if prob == 0 then
					prob = 5
				end

				prob = prob / 30

				global.print(_env, "当前反击概率为：", skill_prob, "随机数为", prob)

				if global.ProbTest(_env, skill_prob + prob) then
					local buff_hurtrate = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.Defense_rate)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UR_EQUIPMENT"
						}
					}, {
						buff_hurtrate
					})
					global.add_once_Proud(_env, _env.ACTOR)
				else
					global.print(_env, "buff值为：", this.Defense_rate)

					local buff_u_defrate = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.Defense_rate)
					local buff_my_defrate = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.Defense_rate)

					global.ApplyBuff(_env, _env.unti, {
						timing = 1,
						display = "DefUp",
						group = "EquipSkill_Tops_15115_3_FRIEND_HURTED",
						duration = 1,
						limit = 2,
						tags = {
							"NUMERIC",
							"BUFF",
							"UR_EQUIPMENT"
						}
					}, {
						buff_u_defrate
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						duration = 1,
						display = "DefUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UR_EQUIPMENT"
						}
					}, {
						buff_my_defrate
					})
				end

				global.print(_env, "ACTOR加之后的防御率为：", global.UnitPropGetter(_env, "defrate")(_env, _env.ACTOR))
				global.print(_env, "unti加之后的当前防御率为：", global.UnitPropGetter(_env, "defrate")(_env, _env.unti))
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Sub_Tops_15115_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.detail = externs.detail

			assert(_env.detail ~= nil, "External variable `detail` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local prob = global.CalculateLineupProbability(_env, _env.ACTOR)

				if global.ProbTest(_env, prob * 2) then
					global.print(_env, "队友受伤了")
					global.ActivateGlobalTrigger(_env, _env.ACTOR, "EquipSkill_Tops_15115_3_FRIEND_HURTED", {
						unti = _env.ACTOR,
						dam = _env.detail.eft
					})
				end
			end)

			return _env
		end
	}

	function _M.__all__.CalculateLineupProbability(_env, unit)
		local this, global = _env.this, _env.global
		local LineupProbability = 0
		local EnemyUnit = global.EnemyUnits(_env, -global.SUMMONS)

		for _, enemy in global.__iter__(EnemyUnit) do
			LineupProbability = global.MARKED(_env, "ASSASSIN")(_env, unit) and LineupProbability + 0.5 or LineupProbability + 0.25
		end

		return LineupProbability / #EnemyUnit
	end

	_M.__all__.EquipSkill_Tops_15116_1 = {
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

				if global.GetCost(_env, _env.ACTOR) < 17 and global.SpecialPropGetter(_env, "EquipSkill_Tops_15116_1_check" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Tops_15116_1"), 99)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Tops_15116_1_CShieldRpUp"), 99)

					return
				end

				if global.GetCost(_env, _env.ACTOR) < 17 and global.SelectBuffCount(_env, _env.ACTOR, "EquipSkill_Tops_15116_1_kill") > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Tops_15116_1_kill"), 99)

					return
				elseif global.GetCost(_env, _env.ACTOR) < 17 and global.SpecialPropGetter(_env, "EquipSkill_Tops_15116_1_check" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) == 0 then
					local buffeft1 = global.Immune(_env)
					local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEBUFF"))

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						duration = 20,
						display = "Immune",
						tags = {
							"NUMERIC",
							"EquipSkill_Tops_15116_1",
							"BUFF",
							"IMMUNE",
							"DISPELLABLE",
							"STEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)

					local buffeft3 = global.PassiveFunEffectBuff(_env, "Skill_Sustained_RPRecovery", {
						RateFactor = this.RageFactor
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 4,
						display = "CShieldRpUp",
						group = "EquipSkill_Top_15116_1_RP",
						duration = 20,
						limit = 1,
						tags = {
							"EquipSkill_Tops_15116_1_CShieldRpUp",
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft3
					}, 1, 0)

					local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Tops_15116_1_check" .. global.GetUnitCid(_env, _env.ACTOR), {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Tops_15116_1_check",
							"UR_EQUIPMENT"
						}
					}, {
						buff_check
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Tops_15116_1_unique", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Tops_15116_1_unique",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Tops_15117_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+unblockrate", {
					"+Normal",
					"+Normal"
				}, this.UnBlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Tops_15117_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
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
				local dazeman = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS - global.SUMMONS - global.MARKED(_env, "SummonedNian") - global.MASTER), ">", global.UnitPropGetter(_env, "rp")), 1, 1)
				local target
				local buffeft = global.Daze(_env)

				if dazeman[1] then
					target = dazeman[1]
				elseif global.EnemyMaster(_env) then
					target = global.EnemyMaster(_env)
				end

				if target then
					global.ApplyBuff_Debuff(_env, _env.ACTOR, target, {
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
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Tops_15118_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, global.UnBlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "BlockRateUp",
					group = "EquipSkill_Tops_15118_3",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
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
				local buff_hurt = global.SpecialNumericEffect(_env, "+hurt_EquipSkill_Tops_15118_3", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Hurt_EquipSkill_Tops_15118_3",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Tops_15118_3",
						"HURTED"
					}
				}, {
					buff_hurt
				})
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_EquipSkill_Tops_15118_3 = global.SpecialPropGetter(_env, "hurt_EquipSkill_Tops_15118_3")(_env, _env.ACTOR)

					if hurt_EquipSkill_Tops_15118_3 and hurt_EquipSkill_Tops_15118_3 ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Tops_15118_3", "HURTED"), 99)

						local buffeft1 = global.NumericEffect(_env, "-unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnhurtRateFactor)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
							timing = 2,
							display = "UnHurtRateDown",
							group = "UnHurtRateDown_EquipSkill_Tops_15118_3",
							duration = 2,
							limit = 2,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"UNHURTRATEDOWN",
								"DISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
					end
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local hurt_EquipSkill_Tops_15118_3 = global.SpecialPropGetter(_env, "hurt_EquipSkill_Tops_15118_3")(_env, _env.ACTOR)

					if hurt_EquipSkill_Tops_15118_3 and hurt_EquipSkill_Tops_15118_3 ~= 0 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Tops_15118_3", "HURTED"), 99)
					end
				end
			end)

			return _env
		end,
		passiv5 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Tops_15118_3", "HURTED"), 99)
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Tops_15118_3", "HURTED"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15118_3 = {
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

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Decoration_15117_2") > 0 and global.GetCost(_env, _env.ACTOR) >= 14 and global.SpecialPropGetter(_env, "EquipSkill_Accesory_15117_2_check" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) < 2 then
					return
				end

				global.print(_env, global.GetFriendField(_env, _env.ACTOR, "EquipSkill_Shoes_15118_3"), "11111111")

				if global.GetFriendField(_env, _env.ACTOR, "EquipSkill_Shoes_15118_3") >= 1 then
					return
				end

				for i = 1, 4 do
					local card_window = global.CardAtWindowIndex(_env, global.GetOwner(_env, _env.ACTOR), i)

					if card_window == nil then
						local card_battle = global.BackToCard_ResultCheck(_env, _env.ACTOR, "window", i)

						if card_battle then
							global.Kick(_env, _env.ACTOR)
						end
					end

					if i == 4 and card_window ~= nil then
						local cardlocation = global.Random(_env, 1, 4)
						local card_battle = global.BackToCard_ResultCheck(_env, _env.ACTOR, "window", cardlocation)

						if card_battle then
							global.Kick(_env, _env.ACTOR)
						end
					end
				end

				global.print(_env, this.spend, "费用======")

				local card = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, global.GetUnitCid(_env, _env.ACTOR)), global.i)[1]

				if card then
					local cardvaluechange = global.CardCostEnchant(_env, "+", this.spend, 1)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						tags = {
							"CARDBUFF",
							"EquipSkill_Shoes_15118_3_buff",
							"UNDISPELLABLE"
						}
					}, {
						cardvaluechange
					})
					global.SetFriendField(_env, _env.ACTOR, 1, "EquipSkill_Shoes_15118_3")
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15001 = {
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
				local buffeft = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "AtkUp",
					group = "EquipSkill_Boots_15001",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Boots_15001"
					}
				}, {
					buffeft
				})

				local buffeft1 = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15001_For_Field", {
					AtkRateFactor = this.AtkRateFactor,
					DamageFactor = this.DamageFactor
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_LAMu_Passive_Skill",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				atk = atk * (1 + this.AtkRateFactor)

				if global.FriendMaster(_env) then
					global.ApplyHPDamage(_env, global.FriendMaster(_env), atk * this.DamageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15001_For_Field = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15001") > 0 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.unit)

					atk = atk * (1 + this.AtkRateFactor)

					if global.FriendMaster(_env) then
						global.ApplyHPDamage(_env, global.FriendMaster(_env), atk * this.DamageFactor)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15002 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
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

				if global.BuffIsMatched(_env, _env.buff, "SHIELD") then
					local buff = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "EquipSkill_Boots_15002",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Boots_15002"
						}
					}, {
						buff
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "SHIELD") then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UNDISPELLABLE", "UNSTEALABLE", "UR_EQUIPMENT", "EquipSkill_Boots_15002"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15003 = {
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
				local buffeft = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AoeDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_15003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"AOEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15004 = {
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

				if global.GetCost(_env, _env.ACTOR) <= 18 then
					local Energy = global.floor(_env, global.GetCost(_env, _env.ACTOR) * this.EnergyFactor)

					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15005 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.actor = externs.actor

			assert(_env.actor ~= nil, "External variable `actor` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) and _env.actor == _env.ACTOR then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

						global.ApplyHPRecovery(_env, unit, maxHp * this.MaxHpFactor)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15006 = {
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
				local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15006", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Boots_15009_check"
					}
				}, {
					buff_check
				})

				if global.SpecialPropGetter(_env, "EquipSkill_Boots_15006")(_env, global.FriendField(_env)) == 1 then
					local buff2 = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15006_CellNum", {
						"?Normal"
					}, global.GetCellId(_env, _env.ACTOR))

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15006_CellNum"
						}
					}, {
						buff2
					})

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "EquipSkill_Boots_15006_hurt",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "EquipSkill_Boots_15006_unhurt",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})

					local buff = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15006_bingo", {
						"?Normal"
					}, 1)
					local trap = global.BuffTrap(_env, {
						timing = 2,
						duration = 1,
						tags = {
							"EquipSkill_Boots_15006_BINGO"
						}
					}, {
						buff
					})

					global.ApplyTrap(_env, global.GetCell(_env, _env.ACTOR), {
						display = "EquipSkill_Shoes_15006",
						duration = 99,
						triggerLife = 1,
						tags = {
							"TRAP"
						}
					}, {
						trap
					})

					local buff_subset = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15006_Subset", {
						HurtRateFactor = this.HurtRateFactor,
						UnHurtRateFactor = this.UnHurtRateFactor
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Boots_15006_Subset",
						timing = 0,
						limit = 1,
						tags = {
							"BUFF",
							"UR_EQUIPMENT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff_subset
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff_subset = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15006_Subset", {
					HurtRateFactor = this.HurtRateFactor,
					UnHurtRateFactor = this.UnHurtRateFactor
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 99,
					group = "EquipSkill_Boots_15006_Subset",
					timing = 0,
					limit = 1,
					tags = {
						"BUFF",
						"UR_EQUIPMENT",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff_subset
				})
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
				local buff_subset = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15006_Subset", {
					HurtRateFactor = this.HurtRateFactor,
					UnHurtRateFactor = this.UnHurtRateFactor
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					duration = 99,
					group = "EquipSkill_Boots_15006_Subset",
					timing = 0,
					limit = 1,
					tags = {
						"BUFF",
						"UR_EQUIPMENT",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff_subset
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15006_Subset = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "EquipSkill_Boots_15006_BINGO")) > 0 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "UnHurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.GetCellId(_env, _env.unit) == global.SpecialPropGetter(_env, "EquipSkill_Boots_15006_CellNum")(_env, global.FriendField(_env)) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "UnHurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15007 = {
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Boots_15007_check")) == 0 then
					global.ApplyHPDamage(_env, _env.ACTOR, global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * 0.5)

					local Energy = global.floor(_env, global.GetCost(_env, _env.ACTOR) * this.EnergyFactor)

					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), Energy)

					local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15007", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Boots_15007_check"
						}
					}, {
						global.buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15008 = {
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

				if global.GetCost(_env, _env.ACTOR) <= 14 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.Factor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.Factor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "UnHurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15102_2 = {
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
				local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15102_2_count", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SpecialPropGetter(_env, "EquipSkill_Boots_15102_2_count")(_env, global.FriendField(_env)) == 0 then
					local buffeft3 = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15102_2_Subset", {
						atkRateFactor = this.AtkRateFactor,
						costFactor = this.CostFactor
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft3
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "DAZE")) > 0 then
						local card = global.BackToCard_ResultCheck(_env, _env.ACTOR, "card")

						if card then
							local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15102_2_biaozhi", {
								"+Normal",
								"+Normal"
							}, 0)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT",
									"EquipSkill_Boots_15102_2_biaozhi"
								}
							}, {
								buffeft2
							})
							global.Kick(_env, _env.ACTOR)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15102_2_Subset = {
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
				local tag1 = global.SpecialPropGetter(_env, "EquipSkill_Boots_15102_2_count")(_env, global.FriendField(_env))
				local tag2 = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_15102_2_biaozhi"))

				if tag1 == 0 and tag2 > 0 then
					for _, acard in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
						local buffeft = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.atkRateFactor)

						if global.SelectCardPassiveCount(_env, acard, "EquipSkill_Shoes_15102_2") > 0 then
							global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), acard, {
								timing = 0,
								duration = 99,
								display = "AtkRateUp",
								tags = {
									"BUFF",
									"ATKRATEUP",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"UR_EQUIPMENT"
								}
							}, {
								buffeft
							})

							local cardvaluechange = global.CardCostEnchant(_env, "-", this.costFactor, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), acard, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE"
								}
							}, {
								cardvaluechange
							})
						end

						local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15102_2_count", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"UR_EQUIPMENT"
							}
						}, {
							buffeft2
						})
					end

					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_15102_2_biaozhi"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15101_1 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Atk_EquipSkill_Boots_15101_1", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_15101_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"EquipSkill_Boots_15101_1",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15103_3 = {
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

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.SpecialPropGetter(_env, "EquipSkill_Boots_15103_3_check")(_env, global.FriendField(_env)) == 0 then
					if global.MARKED(_env, "MAGE")(_env, _env.unit) or global.MARKED(_env, "ASSASSIN")(_env, _env.unit) then
						for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
							if global.SelectCardPassiveCount(_env, card, "EquipSkill_Shoes_15103_3") > 0 then
								local buff = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15103_3", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"NUMERIC",
										"EquipSkill_Boots_15103_3",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
							end
						end
					end

					if global.SpecialPropGetter(_env, "EquipSkill_Boots_15103_3")(_env, global.FriendField(_env)) >= 3 then
						for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
							if global.SelectCardPassiveCount(_env, card, "EquipSkill_Shoes_15103_3") > 0 then
								local cardvaluechange = global.CardCostEnchant(_env, "-", this.costFactor, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE"
									}
								}, {
									cardvaluechange
								})

								local buffeft = global.NumericEffect(_env, "+atkrate", {
									"+Normal",
									"+Normal"
								}, this.AtkRateFactor)

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
									timing = 0,
									duration = 99,
									display = "AtkRateUp",
									tags = {
										"BUFF",
										"ATKRATEUP",
										"UNDISPELLABLE",
										"UNSTEALABLE",
										"UR_EQUIPMENT"
									}
								}, {
									buffeft
								})

								local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15103_3_check", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"NUMERIC",
										"EquipSkill_Boots_15103_3_check",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff_check
								})
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15104_1 = {
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

				if global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15104_1_Passive", {
						RageFactor = this.RageFactor
					})

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNHURTRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15104_1_Passive = {
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

				if global.SpecialPropGetter(_env, "EquipSkill_Boots_15104_1")(_env, global.FriendField(_env)) < 3 then
					for _, unit in global.__iter__(global.AllUnits(_env)) do
						if global.SelectHeroPassiveCount(_env, unit, "EquipSkill_Shoes_15104_1") > 0 then
							global.ApplyRPRecovery(_env, unit, this.RageFactor)

							local buff = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15104_1", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"STATUS",
									"EquipSkill_Boots_15104_1",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15105_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
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

				if global.BuffIsMatched(_env, _env.buff, "TAUNT") then
					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						if global.MASTER(_env, unit) == false then
							if (global.PETS - global.SUMMONS)(_env, unit) then
								local buffeft = global.NumericEffect(_env, "+aoederate", {
									"+Normal",
									"+Normal"
								}, this.AOEDeRateFactor)

								global.ApplyBuff(_env, unit, {
									duration = 99,
									group = "EquipSkill_Boots_15105_2",
									timing = 0,
									limit = 1,
									tags = {
										"NUMERIC",
										"BUFF",
										"UNDISPELLABLE",
										"UNSTEALABLE",
										"EquipSkill_Boots_15105_2"
									}
								}, {
									buffeft
								})
							end

							local buffeft1 = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15105_2_For_Field", {
								AOEDeRateFactor = this.AOEDeRateFactor
							})

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"EquipSkill_Boots_15105_2_For_Field",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft1
							})
						end
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "TAUNT")) > 0 and _env.unit ~= _env.ACTOR and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "EquipSkill_Boots_15105_2",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15105_2"
						}
					}, {
						buffeft
					})
				end
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

				if global.BuffIsMatched(_env, _env.buff, "TAUNT") then
					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "EquipSkill_Boots_15105_2"), 99)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "EquipSkill_Boots_15105_2"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15105_2_For_Field = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15105_2") > 0 then
					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "EquipSkill_Boots_15105_2"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15106_3 = {
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

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					if global.ProbTest(_env, this.DispelRateFactor) then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15107_1 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Boots_15107_1",
						timing = 0,
						limit = 3,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE",
							"EquipSkill_Boots_15107_1",
							"HURTRATEUP",
							"UNHURTRATEUP"
						}
					}, {
						buffeft1,
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15108_2 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					global.AddStatus(_env, _env.unit, "EquipSkill_Boots_15108_2")

					local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15108_2_Passive", {
						RateFactor = this.RateFactor,
						cid = global.GetUnitCid(_env, _env.ACTOR)
					})

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buff
					})
				end
			end)

			return _env
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

				global.AddStatus(_env, _env.ACTOR, "zhuomu")
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15108_2_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				667
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local boots_15108_2 = false

				for _, Friend in global.__iter__(global.FriendUnits(_env)) do
					if global.GetUnitCid(_env, Friend) == this.cid then
						boots_15108_2 = true
					end
				end

				if global.SpecialPropGetter(_env, "EquipSkill_Boots_15108_2_times")(_env, global.FriendField(_env)) < 3 and boots_15108_2 and global.ProbTest(_env, this.RateFactor) and global.INSTATUS(_env, "EquipSkill_Boots_15108_2")(_env, _env.ACTOR) then
					local setLoction = global.FindEmptyCell(_env, global.GetSide(_env, _env.ACTOR))

					if setLoction == nil then
						setLoction = global.GetCellId(_env, _env.ACTOR)
					end

					local RpFactor = global.UnitPropGetter(_env, "rp")(_env, _env.ACTOR)

					if RpFactor then
						global.ReviveByUnitSigleTon(_env, _env.ACTOR, 1, RpFactor, {
							global.abs(_env, setLoction)
						}, global.GetOwner(_env, global.FriendField(_env)))
					else
						global.ReviveByUnitSigleTon(_env, _env.ACTOR, 1, 0, {
							global.abs(_env, setLoction)
						}, global.GetOwner(_env, global.FriendField(_env)))
					end

					local buffeft = global.SpecialNumericEffect(_env, "+EquipSkill_Boots_15108_2_times", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boot_15109_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Boot_15109_3", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNIQUE_HURTRATEUP",
						"EquipSkill_Boot_15109_3",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15110_1 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+boots_15110_1", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT",
						"EquipSkill_Boots_15110_1"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15111_2 = {
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

				if global.EnemyMaster(_env) and global.GetCost(_env, _env.ACTOR) <= 10 then
					global.DispelBuff(_env, global.EnemyMaster(_env), global.BUFF_MARKED_ALL(_env, "IMMUNE"), 99)
					global.ApplyHPDamage(_env, global.EnemyMaster(_env), this.DamageFactor * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15112_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					this.count = this.count + 1

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Boots_15112_3"
						}
					}, {
						buffeft1
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
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					this.count = this.count + 1

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Boots_15112_3"
						}
					}, {
						buffeft1
					})
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Boots_15112_3"), 1)

					this.count = this.count - 1
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15113_1 = {
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
				local buffeft1 = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15113_1_Passive", {
					ShieldFactor = this.ShieldFactor
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15113_1_Passive",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15113_1_Passive = {
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

				if global.GetUnitCid(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SpecialPropGetter(_env, "byou" .. global.GetUnitCid(_env, _env.unit))(_env, global.FriendField(_env)) == 0 and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15113_1") > 0 then
					global.ForbidenRevive(_env, _env.unit, true)
				end
			end)
			exec["@time"]({
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetUnitCid(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SpecialPropGetter(_env, "byou" .. global.GetUnitCid(_env, _env.unit))(_env, global.FriendField(_env)) == 0 and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15113_1") > 0 then
					global.ForbidenRevive(_env, _env.unit, false)

					local buff_check = global.SpecialNumericEffect(_env, "+byou" .. global.GetUnitCid(_env, _env.unit), {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15113_1"
						}
					}, {
						buff_check
					})

					local RpFactor = global.UnitPropGetter(_env, "rp")(_env, _env.unit)
					local cell = global.abs(_env, global.GetCellId(_env, _env.unit))
					local reviveunit = global.Revive_Check(_env, _env.ACTOR, 0.01, RpFactor, {
						cell
					}, _env.unit)
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.isRevive == true and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15113_1") > 0 and global.SpecialPropGetter(_env, "byoushield" .. global.GetUnitCid(_env, _env.unit))(_env, global.FriendField(_env)) == 0 then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local shield = global.ShieldEffect(_env, maxHp * this.ShieldFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "Shield",
						group = "EquipSkill_Boots_15113_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						shield
					})

					local buff_check = global.SpecialNumericEffect(_env, "+byoushield" .. global.GetUnitCid(_env, _env.unit), {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15113_1"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15114_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "UnCritRateUp",
					group = "EquipSkill_Boots_15114_2_UnCrit",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15114_2",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "BeCuredRateUp",
					group = "EquipSkill_Boots_15114_2_BeCured",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15114_2",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15115_3 = {
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

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "UnHurtRateUp",
					group = "EquipSkill_Boots_15115_2_UnHurt",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15115_3",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})

				local buffeft2 = global.PassiveFunEffectBuff(_env, "EquipSkill_Boots_15115_3_For_Field")

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15115_3_FriendFieldFlag",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})
			end)

			return _env
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
				local buffeft1 = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateDownFactor)
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)
				local count = global.SpecialNumericEffect(_env, "+boots_15115_3_count", {
					"?Normal"
				}, 1)

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_15115_3_Count", "UNDISPELLABLE", "UNSTEALABLE")) < 5 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateDown",
						group = "EquipSkill_Boots_15115_2_UnHurt_Debuff",
						duration = 99,
						limit = 5,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15115_3",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "EquipSkill_Boots_15115_2_Hurt",
						duration = 99,
						limit = 5,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15115_3",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_15115_3_Count",
							"UR_EQUIPMENT"
						}
					}, {
						count
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

				if _env.unit == _env.ACTOR then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Boots_15115_3_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15115_3_For_Field = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15115_3") > 0 then
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Boots_15115_3_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_15116_1 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+boots_15116_1_exskill", {
					"?Normal"
				}, this.ExSkillRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+boots_15116_1_hurtrate", {
					"?Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_15116_1",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15117_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.Period = 15

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local Heal = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR) * this.recoveryAmount * _env.Period
				local buff = global.PassiveFunEffectBuff(_env, "Skill_Sustained_HPRecovery_Period", {
					Swtich = true,
					Period = _env.Period,
					Heal = Heal
				})

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyBuff(_env, unit, {
						timing = 4,
						duration = _env.Period,
						tags = {
							"BUFF",
							"Skill_SleepingBeautyCastle",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15120_2 = {
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
				local maxHp = global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_maxHp")(_env, _env.unit)
				local realheal = global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_realheal")(_env, _env.unit)

				global.print(_env, "诏令当前积累真实治疗量", global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_realheal")(_env, _env.unit), "谁", global.GetUnitCid(_env, _env.unit))

				local buff_num = global.floor(_env, realheal / (maxHp * this.hp))

				if buff_num < 0 or realheal <= 0 then
					return
				end

				if buff_num > global.floor(_env, 1 / this.hp) then
					buff_num = global.floor(_env, 1 / this.hp)
				end

				local count = global.GetFriendField(_env, nil, "EquipSkill_Shoes_15120_2")

				if buff_num >= 1 and count <= 18 then
					global.print(_env, "要加几次buff=", buff_num, "加多少攻击率=", 0.055 * buff_num, "当前攻击率=", global.UnitPropGetter(_env, "atkrate")(_env, _env.unit), "谁", global.GetUnitCid(_env, _env.unit))

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal"
					}, 0.055 * buff_num)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "AtkUp",
						duration = 99,
						limit = 99,
						tags = {
							"EquipSkill_Shoes_15120_2",
							"UR_EQUIPMENT",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					count = count + 1 * buff_num

					global.SetFriendField(_env, nil, count, "EquipSkill_Shoes_15120_2")

					local buff1 = global.SpecialNumericEffect(_env, "-EquipSkill_Shoes_15120_2_realheal", {
						"+Normal",
						"+Normal"
					}, buff_num * maxHp * this.hp)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Decoration_15114_2_realheal"
						}
					}, {
						buff1
					})
					global.print(_env, "诏令剩余积累真实治疗量", global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_realheal")(_env, _env.unit), "谁", global.GetUnitCid(_env, _env.unit))
					global.print(_env, "最终攻击率=", global.UnitPropGetter(_env, "atkrate")(_env, _env.unit), "谁", global.GetUnitCid(_env, _env.unit))
					global.print(_env, "当前已用次数", count)
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
				local max_hp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
				local realdamage = global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_realdamage" .. global.GetUnitId(_env, _env.unit))(_env, global.FriendField(_env))

				global.print(_env, "诏令当前积累-同一单个目标-有效伤害量", realdamage, "谁", global.GetUnitCid(_env, _env.unit))

				local buff_num = global.floor(_env, realdamage / (max_hp * this.dam))

				if buff_num < 0 or realdamage <= 0 then
					return
				end

				if buff_num > 4 then
					buff_num = 4
				end

				local units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				global.print(_env, "要加几次buff=", buff_num, "加后防御血量=", 0.0125 * buff_num + global.UnitPropGetter(_env, "defrate")(_env, units[1]), "|", (buff_num * 0.05 + 1) * global.UnitPropGetter(_env, "maxHp")(_env, units[1]))
				global.print(_env, "当前防御率=", global.UnitPropGetter(_env, "defrate")(_env, units[1]), "谁", global.GetUnitCid(_env, units[1]))
				global.print(_env, "当前最大生命值=", global.UnitPropGetter(_env, "maxHp")(_env, units[1]), "谁", global.GetUnitCid(_env, units[1]))

				if buff_num >= 1 then
					for i = 1, buff_num - 1 do
						local buff1 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0.0125)

						global.ApplyBuff(_env, units[1], {
							duration = 99,
							group = "EquipSkill_Shoes_15120_2_1",
							timing = 0,
							limit = 3,
							tags = {
								"EquipSkill_Shoes_15120_2",
								"UR_EQUIPMENT",
								"STATUS",
								"NUMERIC",
								"BUFF",
								"DEFUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1
						})

						local buff2 = global.MaxHpEffect(_env, global.UnitPropGetter(_env, "maxHp")(_env, units[1]) * 0.05)

						global.ApplyBuff(_env, units[1], {
							duration = 99,
							group = "EquipSkill_Shoes_15120_2_2",
							timing = 0,
							limit = 3,
							tags = {
								"EquipSkill_Shoes_15120_2",
								"UR_EQUIPMENT",
								"STATUS",
								"NUMERIC",
								"BUFF",
								"MAXHPUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff2
						})
					end

					local buff3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0.0125)

					global.ApplyBuff(_env, units[1], {
						timing = 0,
						display = "DefUp",
						group = "EquipSkill_Shoes_15120_2_3",
						duration = 99,
						limit = 1,
						tags = {
							"EquipSkill_Shoes_15120_2",
							"UR_EQUIPMENT",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"DEFUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff3
					})

					local buff4 = global.MaxHpEffect(_env, global.UnitPropGetter(_env, "maxHp")(_env, units[1]) * 0.05)

					global.ApplyBuff(_env, units[1], {
						timing = 0,
						display = "MaxHpUp",
						group = "EquipSkill_Shoes_15120_2_4",
						duration = 99,
						limit = 1,
						tags = {
							"EquipSkill_Shoes_15120_2",
							"UR_EQUIPMENT",
							"STATUS",
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff4
					})

					local buff5 = global.SpecialNumericEffect(_env, "-EquipSkill_Shoes_15120_2_realdamage" .. global.GetUnitId(_env, _env.unit), {
						"+Normal",
						"+Normal"
					}, buff_num * max_hp * this.dam)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Decoration_15114_2_realdamage"
						}
					}, {
						buff5
					})
					global.print(_env, "诏令剩余积累-同一单个目标-有效伤害量", global.SpecialPropGetter(_env, "EquipSkill_Shoes_15120_2_realdamage")(_env, _env.unit), "谁", global.GetUnitCid(_env, units[1]))
					global.print(_env, "最终防御率=", global.UnitPropGetter(_env, "defrate")(_env, units[1]), "谁", global.GetUnitCid(_env, units[1]))
					global.print(_env, "最终最大生命值=", global.UnitPropGetter(_env, "maxHp")(_env, units[1]), "谁", global.GetUnitCid(_env, units[1]))
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15122_1 = {
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
				local buffeft1 = global.NumericEffect(_env, "-critrate", {
					"+Normal",
					"+Normal"
				}, this.DeCriRateFactor)
				local buffeft2 = global.NumericEffect(_env, "-critstrg", {
					"+Normal",
					"+Normal"
				}, this.DeCriRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Shoes_15122_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1,
					buffeft2
				})

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft4 = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Shoes_15122_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"EquipSkill_Shoes_15122_1",
						"AOEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft3,
					buffeft4
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15121_3 = {
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

				if not global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) then
					local Flags1 = {
						"ASSASSIN",
						"WARRIOR",
						"MAGE",
						"SUMMONER",
						"HEALER",
						"LIGHT",
						"DARK"
					}

					for i = 1, 7 do
						if global.MARKED(_env, Flags1[i])(_env, _env.ACTOR) and global.SpecialPropGetter(_env, "EquipSkill_Shoes_15121_3_flag" .. Flags1[i])(_env, global.FriendMaster(_env)) == 1 then
							global.AddStatus(_env, _env.ACTOR, "Only")
						end
					end

					if global.INSTATUS(_env, "Only")(_env, _env.ACTOR) then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, global.UnHurtRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							display = "UnHurtRateUp",
							group = "EquipSkill_Shoes_15121_3_UnHurt",
							duration = 99,
							limit = 1,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Shoes_15121_3",
								"UR_EQUIPMENT"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end,
		passive2 = function(_env, externs)
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

				if global.INSTATUS(_env, "Only")(_env, _env.ACTOR) and not global.MASTER(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS + global.SUMMONS)(_env, _env.unit) and global.SpecialPropGetter(_env, "EquipSkill_Shoes_15121_3_die")(_env, global.FriendField(_env)) < 4 then
					local RPFactor = 0

					if (global.PETS - global.SUMMONS)(_env, _env.unit) then
						RPFactor = this.PetsRPFactor
					end

					global.ApplyRPRecovery(_env, _env.ACTOR, (global.SUMMONS(_env, _env.unit) or nil) and this.SummonRPFactor)

					local buff = global.SpecialNumericEffect(_env, "+EquipSkill_Shoes_15121_3_die", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"EquipSkill_Shoes_15121_3_die",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
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

				if (not global.FriendMaster(_env) or not global.MASTER(_env, _env.ACTOR) or global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) or global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR)) and global.FriendMaster(_env) ~= nil or global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Shoes_15121_3_flag")) > 0 then
					-- block empty
				else
					local Flags1 = {
						"ASSASSIN",
						"WARRIOR",
						"MAGE",
						"SUMMONER",
						"HEALER",
						"LIGHT",
						"DARK"
					}

					for i = 1, 7 do
						local count = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, Flags1[i]))
						local buffeft1 = global.SpecialNumericEffect(_env, "+EquipSkill_Shoes_15121_3_flag" .. Flags1[i], {
							"+Normal",
							"+Normal"
						}, count)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"EquipSkill_Shoes_15121_3_flag"
							}
						}, {
							buffeft1
						})
						global.print(_env, "寻梦之履-编队职业数量", Flags1[i], global.SpecialPropGetter(_env, "EquipSkill_Shoes_15121_3_flag" .. Flags1[i])(_env, _env.ACTOR))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15123_2 = {
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
				local kill = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS - global.SUMMONS - global.MARKED(_env, "SummonedNian") - global.ONESELF(_env, _env.ACTOR)), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if kill[1] ~= nil and global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "EquipSkill_Shoes_15123_2_Count")) < 1 then
					global.KillTarget(_env, kill[1])

					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Shoes_15123_2_Count",
							"UR_EQUIPMENT"
						}
					}, {
						global.count
					})

					if global.FriendMaster(_env) then
						global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)

						local buffeft2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendMaster(_env), {
							timing = 2,
							duration = 1,
							display = "Purify",
							tags = {
								"DISPEL",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2
						})

						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, global.FriendMaster(_env), this.HealRateFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, global.FriendMaster(_env), heal)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Shoes_15124_1 = {
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
				local units = global.FriendUnits(_env, global.PETS - global.SUMMONS - global.ONESELF(_env, _env.ACTOR) - global.MARKED(_env, "DAGUN"))

				if units[1] then
					-- block empty
				else
					local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))

					for _, card in global.__iter__(cards) do
						local buffeft = global.NumericEffect(_env, "+singlerate", {
							"+Normal",
							"+Normal"
						}, this.SingleRateFactor)
						local buffeft1 = global.NumericEffect(_env, "+aoerate", {
							"+Normal",
							"+Normal"
						}, this.AOERateFactor)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "EquipSkill_Shoes_15124_1",
							timing = 0,
							limit = 1,
							tags = {
								"EquipSkill_Shoes_15124_1",
								"STATUS",
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1,
							global.buffeft2
						})
					end

					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15114_2 = {
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

				if global.SpecialPropGetter(_env, "EquipSkill_Decoration_15114_2_count")(_env, global.FriendField(_env)) < 2 then
					global.print(_env, this.anger, "====怒气值")
					global.ApplyRPRecovery(_env, global.FriendMaster(_env), this.anger)

					local count = global.SpecialNumericEffect(_env, "+EquipSkill_Decoration_15114_2_count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Decoration_15114_2"
						}
					}, {
						count
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15001 = {
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
				local buffeft = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.ONESELF(_env, _env.ACTOR) + global.BACK_OF(_env, _env.ACTOR) * global.COL_OF(_env, _env.ACTOR))) do
					global.ApplyBuff(_env, unit, {
						timing = 2,
						display = "Shield",
						group = "EquipSkill_Accesory_15001",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15002 = {
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
				local buffeft = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						duration = 99,
						group = "EquipSkill_Accesory_15002",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"BECUREDRATEUP",
							"EquipSkill_Accesory_15002",
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
					local buffeft = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "EquipSkill_Accesory_15002",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"BECUREDRATEUP",
							"EquipSkill_Accesory_15002",
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
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BECUREDRATEUP", "EquipSkill_Accesory_15002", "UNDISPELLABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15003 = {
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
				local crit = global.UnitPropGetter(_env, "critrate")(_env, _env.ACTOR)
				local buffeft1 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenFactor)
				local buffeft2 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, crit * (this.Rate - 1))

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "DefWeakenUp",
					group = "EquipSkill_Accesory_15003_1",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"DEFWEAKENUP",
						"EquipSkill_Accesory_15003",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "CritRateUp",
					group = "EquipSkill_Accesory_15003_2",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"CRITRATEUP",
						"EquipSkill_Accesory_15003",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15004 = {
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
				local buff = global.SpecialNumericEffect(_env, "+rage_unhurtrate_down", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15004",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"EquipSkill_Accesory_15004",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15005 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+First_Unique_Accesory_15005", {
					"+Normal",
					"+Normal"
				}, this.DamageFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+First_Unique_Accesory_15005_Ex", {
					"+Normal",
					"+Normal"
				}, this.ExDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"EquipSkill_Accesory_15005",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15005", "UNDISPELLABLE", "UNSTEALABLE")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15005", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15006 = {
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
				local buffeft = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.RateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 4,
					display = "BlockRateUp",
					group = "EquipSkill_Accesory_15006",
					duration = 15,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"BLOCKRATEUP",
						"EquipSkill_Accesory_15006",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15007 = {
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
				local buffeft_tag = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15007_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15007_biaozhi",
					timing = 0,
					limit = 1,
					tags = {
						"EquipSkill_Accesory_15007_biaozhi"
					}
				}, {
					buffeft_tag
				})
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
				local buffeft2 = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritStrgFactor)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15007_biaozhi")) > 0 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "CritStrgUp",
						group = "EquipSkill_Accesory_15007",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"EquipSkill_Accesory_15007",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15007_biaozhi")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15007", "UNDISPELLABLE"), 99)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15007_biaozhi"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15008 = {
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
				local buffeft_tag = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15008_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				if global.GetCost(_env, _env.ACTOR) <= 14 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Accesory_15008_biaozhi"
						}
					}, {
						buffeft_tag
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritrateFactor)
				local buffeft2 = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritstrgFactor)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15008_biaozhi")) > 0 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "CritRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
							"EquipSkill_Accesory_15008",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "CritStrgUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"CRITSTRGUP",
							"EquipSkill_Accesory_15008",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15008_biaozhi")) > 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "CRITRATEUP", "EquipSkill_Accesory_15008", "UNDISPELLABLE", "UNSTEALABLE"), 99)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "CRITSTRGUP", "EquipSkill_Accesory_15008", "UNDISPELLABLE", "UNSTEALABLE"), 99)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15008_biaozhi"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15009 = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					local num = 30

					if num <= _env.prevHpPercent and num > _env.curHpPercent then
						local buffeft = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.HurtRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
							timing = 0,
							duration = 99,
							display = "HurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"UR_EQUIPMENT",
								"EquipSkill_Accesory_15009"
							}
						}, {
							buffeft
						}, 1, 0)
					elseif num > _env.prevHpPercent and num <= _env.curHpPercent then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "UR_EQUIPMENT", "EquipSkill_Accesory_15009", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15010 = {
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
				local buffeft_tag = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15010_biaozhi", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"EquipSkill_Accesory_15010_biaozhi"
					}
				}, {
					buffeft_tag
				})

				local buffeft1 = global.Immune(_env)
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEBUFF"))

				if global.SpecialPropGetter(_env, "EquipSkill_Accesory_15010_biaozhi")(_env, global.FriendField(_env)) == 2 then
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 4,
						display = "Immune",
						duration = this.ImmuneTime,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"IMMUNE",
							"DISPELLABLE",
							"STEALABLE",
							"EquipSkill_Accesory_15010"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15011 = {
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
				local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					display = "Shield",
					group = "EquipSkill_Accesory_15011",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				}, 1)

				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR"))

				for _, card in global.__iter__(cards) do
					local cardvaluechange = global.CardCostEnchant(_env, "-", this.cardvalue, 1)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 0,
						duration = 99,
						tags = {
							"CARDBUFF",
							"EquipSkill_Accesory_15011",
							"UNDISPELLABLE"
						}
					}, {
						cardvaluechange
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15012 = {
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

				if #global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR)) == 0 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "EquipSkill_Accesory_15012_biaozhi_hurt",
						duration = 99,
						limit = 1,
						tags = {
							"EquipSkill_Accesory_15012",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "EquipSkill_Accesory_15012_biaozhi_unhurt",
						duration = 99,
						limit = 1,
						tags = {
							"EquipSkill_Accesory_15012",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15101_1 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Hur_EquipSkill_Accesory_15101_1", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Del_EquipSkill_Accesory_15101_1", {
					"+Normal",
					"+Normal"
				}, this.DelRpValueFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15101_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"EquipSkill_Accesory_15101_1",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15102_2 = {
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
				local AOERate
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, #global.EnemyUnits(_env) < 5 and this.AOERateFactor * 2 or this.AOERateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15102_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15102_2"
					}
				}, {
					buffeft1
				})
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

				if #global.EnemyUnits(_env) >= 5 then
					local buffeft1 = global.NumericEffect(_env, "+aoerate", {
						"+Normal",
						"+Normal"
					}, this.AOERateFactor)

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "NUMERIC", "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "EquipSkill_Accesory_15102_2"), 99)
					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Accesory_15102_2",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Accesory_15102_2"
						}
					}, {
						buffeft1
					})
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
				local AOERate
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, #global.EnemyUnits(_env) < 5 and this.AOERateFactor * 2 or this.AOERateFactor)

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "NUMERIC", "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "EquipSkill_Accesory_15102_2"), 99)
				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15102_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15102_2"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15103_3 = {
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
				local buffeft1 = global.NumericEffect(_env, "+singlerate", {
					"+Normal",
					"+Normal"
				}, this.SingleDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_15103_3",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15103_3"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15104_1 = {
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

				if global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local SummonerAtk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * this.AtkRateFactor
					local SummonsAtk = global.UnitPropGetter(_env, "atk")(_env, _env.unit)
					local atkrate = SummonerAtk / SummonsAtk
					local buffeft = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, atkrate)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "AtkUp",
						group = "EquipSkill_Accesory_15104_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Accesory_15104_1",
							"AtkUp"
						}
					}, {
						buffeft
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15105_2 = {
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.isRevive == true and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, global.GetUnitCid(_env, _env.ACTOR))(_env, _env.unit) then
					global.ApplyRPRecovery(_env, _env.unit, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15106_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.primTrgt, global.BUFF_MARKED(_env, "ABNORMAL")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Accesory_15106_3",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
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

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.primTrgt, global.BUFF_MARKED(_env, "ABNORMAL")) > 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"EquipSkill_Accesory_15106_3",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
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

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15106_3"), 99)
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Accesory_15106_3"), 99)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15107_1 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.DamageFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15108_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+maxHp", {
					"+Normal",
					"+Normal"
				}, this.MaxHpFactor)
				local buffeft2 = global.NumericEffect(_env, "+blockstrg", {
					"+Normal",
					"+Normal"
				}, this.BlockStrgFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "BlockStrgUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"BLOCKSTRGUP",
						"EquipSkill_Accesory_15108_2",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 1)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15109_3 = {
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

				if global.SpecialPropGetter(_env, "accesory_15109_3_count")(_env, global.FriendField(_env)) < 5 then
					local recover = this.MaxHpFactor * global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery(_env, _env.ACTOR, recover)

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"HurtRateUp",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Accesory_15109_3"
						}
					}, {
						buffeft1
					})

					local count = global.SpecialNumericEffect(_env, "+accesory_15109_3_count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UR_EQUIPMENT",
							"EquipSkill_Accesory_15109_3"
						}
					}, {
						count
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15110_1 = {
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

				if global.GetCost(_env, _env.ACTOR) <= 10 then
					local buffeft1 = global.SpecialNumericEffect(_env, "+accesory_15110_1", {
						"+Normal",
						"+Normal"
					}, this.ShieldBreakFactor)
					local buffeft2 = global.NumericEffect(_env, "+defweaken", {
						"+Normal",
						"+Normal"
					}, this.DefWeakenFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Accesory_15110_1",
							"UR_EQUIPMENT"
						}
					}, {
						buffeft1,
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15111_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+reflection", {
					"+Normal",
					"+Normal"
				}, this.ReflectRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "Reflect",
					group = "EquipSkill_Accesory_15111_2_Reflect",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15111_2",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "Absorption",
					group = "EquipSkill_Accesory_15111_2_Absorption",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15111_2",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15112_3 = {
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
				local atk = this.MHpToAtkFactor * maxHp
				local buffeft1 = global.NumericEffect(_env, "+atk", {
					"+Normal",
					"+Normal"
				}, atk)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "AtkUp",
					group = "EquipSkill_Accesory_15112_3",
					duration = 99,
					limit = 1,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Accesory_15112_3",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15113_1 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.treatmentRate)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 999,
					group = "EquipSkill_Decoration_15113_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15115_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff0 = global.NumericEffect(_env, "-critstrg", {
					"+Normal",
					"+Normal"
				}, 0.1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "-critstrg_EquipSkill_Decoration_15115_3",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"UNDISPELLABLE"
					}
				}, {
					buff0
				})

				local t_unhurtrate = global.UnitPropGetter(_env, "unhurtrate")(_env, _env.primTrgt)
				local a_unhurtrate = global.UnitPropGetter(_env, "unhurtrate")(_env, _env.ACTOR)

				if t_unhurtrate - a_unhurtrate > 0 and global.GetUnitCid(_env, _env.primTrgt) ~= global.GetUnitCid(_env, global.EnemyMaster(_env)) then
					this.damage_rate = this.damage_rate * 2
				end

				global.print(_env, "承誓---unhurtrate之前===", global.UnitPropGetter(_env, "unhurtrate")(_env, _env.primTrgt), "目标为", global.GetUnitCid(_env, _env.primTrgt))

				local buff = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.damage_rate)

				global.ApplyBuff(_env, _env.primTrgt, {
					timing = 0,
					display = "UnHurtRateDown",
					group = "EquipSkill_Decoration_15115_3_1",
					duration = 99,
					limit = 10,
					tags = {
						"NUMERIC",
						"DEBUFF"
					}
				}, {
					buff
				})
				global.print(_env, "承誓---unhurtrate之后2222===", global.UnitPropGetter(_env, "unhurtrate")(_env, _env.primTrgt), "目标为", global.GetUnitCid(_env, _env.primTrgt))

				if global.IsAlive(_env, _env.primTrgt) then
					local buff1 = global.NumericEffect(_env, "-unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.damage_rate / 2)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateDown",
						group = "EquipSkill_Decoration_15115_3_2",
						duration = 99,
						limit = 10,
						tags = {
							"NUMERIC",
							"DEBUFF"
						}
					}, {
						buff1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15117_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetCost(_env, _env.ACTOR) >= 14 and global.SpecialPropGetter(_env, "EquipSkill_Accesory_15117_2_check" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) < 2 then
					local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15117_2_check" .. global.GetUnitCid(_env, _env.ACTOR), {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"COUNT_Accesory_15117_2",
							"UR_EQUIPMENT"
						}
					}, {
						buff_check
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15117_2_unique_single")) > 0 then
						global.print(_env, "月食星运行驱散无敌=====")

						for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.primTrgt))) do
							local enemyfront = global.EnemyUnits(_env, global.FRONT_OF(_env, unit, true) * global.COL_OF(_env, unit))

							if #enemyfront > 0 then
								-- block empty
							else
								global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

								break
							end
						end
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Accesory_15117_2_unique"), 99)
					global.KillTarget(_env, _env.ACTOR)
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
				local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Accesory_15117_2_field", {
					EnergyFactor = this.EnergyFactor
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetCost(_env, _env.ACTOR) >= 14 and global.SpecialPropGetter(_env, "EquipSkill_Accesory_15117_2_check" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) < 2 then
					global.print(_env, "月食星运行驱散无敌-上标记=====")

					local buff_check2 = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15117_2_unique", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Accesory_15117_2_unique",
							"UR_EQUIPMENT"
						}
					}, {
						buff_check2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_15117_2_field = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
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

				if global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Decoration_15117_2") > 0 and global.GetCost(_env, _env.unit) >= 14 and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SpecialPropGetter(_env, "EquipSkill_Accesory_15117_2_energy" .. global.GetUnitCid(_env, _env.unit))(_env, global.FriendField(_env)) < 2 then
					local buff_check1 = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_15117_2_energy" .. global.GetUnitCid(_env, _env.unit), {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"COUNT_Accesory_15117_2_energy",
							"UR_EQUIPMENT"
						}
					}, {
						buff_check1
					})

					local cost = global.min(_env, global.GetActualCost(_env, _env.unit), global.GetCost(_env, _env.unit))

					global.print(_env, "月食星登场GetCardWindowIndex==", global.GetCardWindowIndex(_env, _env.unit))

					local Energy = global.floor(_env, ((global.GetCardWindowIndex(_env, _env.unit) == 0 or nil) and 0) * this.EnergyFactor)

					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.unit), Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15116_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.primTrgt = externs.primTrgt

			assert(_env.primTrgt ~= nil, "External variable `primTrgt` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.NumericEffect(_env, "-def", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.primTrgt, {
					timing = 0,
					duration = 99,
					display = "NoKickMax",
					tags = {
						"UnKickMax",
						"EquipSkill_Decoration_15116_1",
						"DEBUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "AtkUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "EquipSkill_Decoration_15116_1"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15118_3 = {
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
				local buff = global.PassiveFunEffectBuff(_env, "EquipSkill_Decoration_15118_3_field", {
					AtkRateFactor = this.AtkRateFactor,
					master = _env.ACTOR
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15118_3_field = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.unit ~= this.master and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Back" .. global.GetUnitCid(_env, this.master))) > 0 and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "UNDEAD")) < 3 then
					local buffeft1 = global.DeathImmuneEffect(_env, 1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "Undead",
						group = "EquipSkill_Decoration_15118_3",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"UNDEAD",
							"STATUS",
							"EquipSkill_Decoration_15118_3",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15119_2 = {
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
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOEHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Decoration_15119_2",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Decoration_15119_2_end")) == 0 then
					local buffeft_tag = global.SpecialNumericEffect(_env, "+EquipSkill_Decoration_15119_2_biaozhi", {
						"+Normal",
						"+Normal"
					}, global.count)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Decoration_15119_2_biaozhi"
						}
					}, {
						buffeft_tag
					})
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Decoration_15119_2_end")) == 0 then
					local count = global.SpecialPropGetter(_env, "EquipSkill_Decoration_15119_2_count")(_env, _env.ACTOR)

					if count > this.Energy then
						count = global.floor(_env, this.Energy)
					end

					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), count)
					global.print(_env, "春之歌返回能量", count)

					local buffeft_tag = global.SpecialNumericEffect(_env, "+EquipSkill_Decoration_15119_2_end", {
						"+Normal",
						"+Normal"
					}, count)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"EquipSkill_Decoration_15119_2_end"
						}
					}, {
						buffeft_tag
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15120_1 = {
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

				if global.GetCost(_env, _env.ACTOR) > 10 and global.SpecialPropGetter(_env, "EquipSkill_Decoration_15120_1")(_env, global.FriendField(_env)) < 1 then
					local count = 0

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_COL)) do
						if (global.PETS + global.SUMMONS)(_env, unit) then
							count = count + 1
						end

						if count < 1 then
							global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
							global.ApplyEnergyDamage(_env, global.GetOwner(_env, global.EnemyField(_env)), this.Energy)

							if global.EnemyMaster(_env) then
								local buff = global.NumericEffect(_env, "-unhurtrate", {
									"+Normal",
									"+Normal"
								}, this.UnHurtRateFactor)

								global.ApplyBuff_Debuff(_env, _env.ACTOR, global.EnemyMaster(_env), {
									timing = 2,
									display = "UnHurtRateDown",
									group = "EquipSkill_Decoration_15120_1",
									duration = 2,
									limit = 1,
									tags = {
										"STATUS",
										"NUMERIC",
										"DEBUFF",
										"UNHURTRATEDOWN",
										"DISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								}, 1, 0)
							end

							local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Decoration_15120_1", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"EquipSkill_Decoration_15120_1",
									"UR_EQUIPMENT"
								}
							}, {
								buff_check
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14001 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14002 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+reflection", {
					"+Normal",
					"+Normal"
				}, this.ReflectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14003 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Armor_14003"
					}
				}, {
					buffeft1
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= this.HpRatioFactor * 100 and _env.curHpPercent < this.HpRatioFactor * 100 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_14003", "UNDISPELLABLE"), 99)
					end

					if _env.prevHpPercent < this.HpRatioFactor * 100 and _env.curHpPercent >= this.HpRatioFactor * 100 then
						local buffeft1 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, this.DefRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_14003",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_14003"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+dazeprob_hurted", {
					"+Normal",
					"+Normal"
				}, this.DazeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14005 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= this.HpRatioFactor * 100 and _env.curHpPercent < this.HpRatioFactor * 100 then
						local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_14005_UnHurt",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_14005_UnHurt"
							}
						}, {
							buffeft2
						})
					end

					if _env.prevHpPercent < this.HpRatioFactor * 100 and _env.curHpPercent >= this.HpRatioFactor * 100 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_14005_UnHurt", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14006 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local buffeft2 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.StepDefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 2,
					limit = 5,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"DEFUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14007 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+unblockrate", {
					"+Normal",
					"+Normal"
				}, this.UnBlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14009 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local buffeft2 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.StepAtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "AtkUp",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14010_Def",
					timing = 0,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Armor_14010_Def"
					},
					limit = global.Def
				}, {
					buffeft1
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= 50 and _env.curHpPercent < 50 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_14010_Def", "UNDISPELLABLE"), 99)

						local buffeft2 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_14010_Atk",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_14010_Atk"
							}
						}, {
							buffeft2
						})
					end

					if _env.prevHpPercent < 50 and _env.curHpPercent >= 50 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_14010_Atk", "UNDISPELLABLE"), 99)

						local buffeft3 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, this.DefRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_14010_Def",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_14010_Atk"
							}
						}, {
							buffeft3
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14011_Def",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Armor_14011_Hp"
					}
				}, {
					buffeft1
				})

				local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14011_Unhurt",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Armor_14011_Unhurt"
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= 100 and _env.curHpPercent < 100 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_14011_Unhurt", "UNDISPELLABLE"), 99)
					end

					if _env.prevHpPercent < 100 and _env.curHpPercent >= 100 then
						local buffeft3 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_14011_Unhurt",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_14011_Unhurt"
							}
						}, {
							buffeft3
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14012 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+uneffectrate", {
					"+Normal",
					"+Normal"
				}, this.UnEffectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14013 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+singlederate", {
					"+Normal",
					"+Normal"
				}, this.SingleDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14014 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+hurtrecoveryrate", {
					"+Normal",
					"+Normal"
				}, this.RecoveryRateFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+hurtrecoveryratio", {
					"+Normal",
					"+Normal"
				}, this.RecoveryRatioFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14014",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14015 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.RateFactor) then
					local buffeft2 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						display = "CureRateUp",
						duration = 3,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"CURERATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_14016 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_14016",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.RateFactor) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageRecoverFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14001 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14002 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14003 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14003_Hp",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local buffeft2 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.StepDefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14003_StepDef",
					timing = 0,
					limit = 5,
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
		end
	}
	_M.__all__.EquipSkill_Boots_14004 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

				global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14005 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local hpRatio = global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR)

				if hpRatio < 0.5 then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14006 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritStrgFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14007 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})

				if global.UnitPropGetter(_env, "hpRatio")(_env, _env.ACTOR) < 0.5 then
					local buffeft2 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Boots_14007_Abs",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Boots_14007_Abs"
						}
					}, {
						buffeft2
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= 50 and _env.curHpPercent < 50 then
						local buffeft2 = global.NumericEffect(_env, "+absorption", {
							"+Normal",
							"+Normal"
						}, this.AbsorptionRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Boots_14007_Abs",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Boots_14007_Abs"
							}
						}, {
							buffeft2
						})
					end

					if _env.prevHpPercent < 50 and _env.curHpPercent >= 50 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_14007_Abs", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14008_Def",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Boots_14008_Def"
					}
				}, {
					buffeft1
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= 50 and _env.curHpPercent < 50 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_14008_Def", "UNDISPELLABLE"), 99)

						local buffeft2 = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, this.CritRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Boots_14008_Crit",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Boots_14008_Crit"
							}
						}, {
							buffeft2
						})
					end

					if _env.prevHpPercent < 50 and _env.curHpPercent >= 50 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Boots_14008_Crit", "UNDISPELLABLE"), 99)

						local buffeft3 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, this.DefRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Boots_14008_Def",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Boots_14008_Def"
							}
						}, {
							buffeft3
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14009 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.RageRate) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14011 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+atkweaken", {
					"+Normal",
					"+Normal"
				}, this.AtkWeakenRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14012 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.RandomDefRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 2,
						display = "DefUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"DEFUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14013 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.EnemyUnits(_env))) do
					local buffeft2 = global.NumericEffect(_env, "-defrate", {
						"+Normal",
						"+Normal"
					}, this.RandomDefRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 2,
						display = "DefDown",
						tags = {
							"STATUS",
							"NUMERIC",
							"DEBUFF",
							"DEFDOWN",
							"DISPELLABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14014 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14014",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.DispelRateFactor) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_14015 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)
				local buffeft3 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_14015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
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

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14001 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorptionRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14002 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Summoned_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14003 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Warrior_DmgExtra_defweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Healer_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+Summoner_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14005 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+killcritrate_self", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14006 = {
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

				global.ApplyHPReduce(_env, _env.ACTOR, maxHp * this.HpDmgRateFactor)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+effectrate", {
					"+Normal",
					"+Normal"
				}, this.EffectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"ATKUP",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14007 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+blockrecoveryrate", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14008 = {
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
				local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					display = "Shield",
					group = "EquipSkill_Accesory_14008",
					duration = 3,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14009 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "CURSE"))

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.RateFactor)
				local buffeft2 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.RateFactor)
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft3 = global.MaxHpEffect(_env, maxHp * this.RateFactor)
				local buffeft4 = global.NumericEffect(_env, "*speed", {
					"+Normal",
					"+Normal"
				}, this.RateFactor)
				local buffeft5 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DAZE") - global.BUFF_MARKED_ANY(_env, "Skill_GLFu_L_Unique_Daze"))

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4,
					buffeft5
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEFDOWN"))

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14012 = {
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

				if global.FriendMaster(_env) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 2,
						display = "Shield",
						group = "EquipSkill_Accesory_14012",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14013 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.RandomAtkRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "atkrate",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKRATEUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14014 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14014",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.DispelRateFactor) then
					for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14015 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.ProbTest(_env, this.RateFactor) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14016 = {
		__new__ = function(prototype, externs, global)
			return
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

				_env.unit = global.FriendMaster(_env)

				if _env.unit then
					local healer = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

					global.ApplyHPRecovery(_env, _env.unit, healer.atk * this.HealRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14017 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+exskillrate", {
					"+Normal",
					"+Normal"
				}, this.SkillRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14017",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14018 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14018",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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
				local buffeft2 = global.NumericEffect(_env, "+exskillrate", {
					"+Normal",
					"+Normal"
				}, this.SkillRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"SKILLRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14019 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14019",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})

				if global.SpecialPropGetter(_env, "EquipSkill_Accesory_14019")(_env, global.FriendField(_env)) == 0 then
					if global.EnemyMaster(_env) then
						if global.MARKED(_env, "Player_Master")(_env, global.EnemyMaster(_env)) or global.MARKED(_env, "DAGUN")(_env, global.EnemyMaster(_env)) or global.MARKED(_env, "SP_DDing")(_env, global.EnemyMaster(_env)) then
							this.BackRateFactor_now = this.BackRateFactor1

							local buffeft3 = global.SpecialNumericEffect(_env, "+Accesory_14019", {
								"+Normal",
								"+Normal"
							}, this.BackRateFactor_now)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft3
							})
						else
							this.BackRateFactor_now = this.BackRateFactor2

							local buffeft4 = global.SpecialNumericEffect(_env, "+Accesory_14019", {
								"+Normal",
								"+Normal"
							}, this.BackRateFactor_now)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft4
							})
						end
					else
						this.BackRateFactor_now = this.BackRateFactor2

						local buffeft4 = global.SpecialNumericEffect(_env, "+Accesory_14019", {
							"+Normal",
							"+Normal"
						}, this.BackRateFactor_now)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft4
						})
					end
				end

				local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_14019", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "LDYu_Back_Count"))

				if global.FriendMaster(_env) and count < 2 and global.MARKED(_env, "LDYu")(_env, _env.ACTOR) and global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "LDYu_Passive_Time")) > 0 then
					return
				end

				if global.FriendMaster(_env) and global.SpecialPropGetter(_env, "byou" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) == 0 and global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Shoes_15113_1") > 0 then
					return
				end

				if global.FriendMaster(_env) and not global.INSTATUS(_env, "Skill_BEr_Passive_Death_SecondTime")(_env, global.FriendMaster(_env)) and global.MARKED(_env, "BEr")(_env, _env.ACTOR) then
					return
				end

				if global.SelectTrapCount(_env, global.GetCell(_env, _env.ACTOR), global.BUFF_MARKED(_env, "GCZi_jianzhen")) > 0 then
					return
				end

				local BackRateFactor_now = global.SpecialPropGetter(_env, "Accesory_14019")(_env, global.FriendField(_env))
				local times = global.SpecialPropGetter(_env, "EquipSkill_Accesory_14019_times")(_env, global.FriendField(_env))

				BackRateFactor_now = BackRateFactor_now * 0.5^times

				if global.ProbTest(_env, BackRateFactor_now) then
					local buffeft2 = global.SpecialNumericEffect(_env, "+EquipSkill_Accesory_14019_times", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})

					local card = global.BackToCard_ResultCheck(_env, _env.ACTOR, "card")

					if card then
						global.Kick(_env, _env.ACTOR)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_14020 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_14020",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})

				if global.ProbTest(_env, this.RateFactor) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13001 = {
		__new__ = function(prototype, externs, global)
			return
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 3,
					group = "EquipSkill_Weapon_13001",
					timing = 2,
					limit = 3,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13002 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13003 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13005 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defweaken", {
					"+Normal",
					"+Normal"
				}, this.DefWeakenRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13006 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13007 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 3,
					group = "EquipSkill_Weapon_13007",
					timing = 2,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13009 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13010 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHpCheckRate_PETS", {
					"+Normal",
					"+Normal"
				}, 0.5)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_DmgExtra_PETS_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13012 = {
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
				local buffeft1 = global.NumericEffect(_env, "+unblockrate", {
					"+Normal",
					"+Normal"
				}, this.UnBlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13013 = {
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
				local buffeft1 = global.NumericEffect(_env, "+effectrate", {
					"+Normal",
					"+Normal"
				}, this.EffectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13014 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+afteratk_debecuredrate", {
					"+Normal",
					"+Normal"
				}, this.DeBeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13014",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"DEBUFF",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13015 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13016 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkweaken", {
					"+Normal",
					"+Normal"
				}, this.AtkWeakenRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13016",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13017 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_RatioCheck", {
					"+Normal",
					"+Normal"
				}, this.HpRatioFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_ExtraRate", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13017",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13018 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13018",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13019 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13019",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_13020 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_13020",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13001 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13002 = {
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

				if global.ProbTest(_env, this.RateFactor) then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						display = "UnHurtRateUp",
						duration = 3,
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
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13003 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13005 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13006 = {
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
				local buffeft1 = global.NumericEffect(_env, "+unblockrate", {
					"+Normal",
					"+Normal"
				}, this.UnBlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13007 = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= this.HpRatioFactor * 100 and _env.curHpPercent < this.HpRatioFactor * 100 then
						local buffeft1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_13007",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_13007"
							}
						}, {
							buffeft1
						})
					end

					if _env.prevHpPercent < this.HpRatioFactor * 100 and _env.curHpPercent >= this.HpRatioFactor * 100 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_13007", "UNDISPELLABLE"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13009 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"EquipSkill_Armor_13010"
					}
				}, {
					buffeft1
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= this.HpRatioFactor * 100 and _env.curHpPercent < this.HpRatioFactor * 100 then
						global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Armor_13010", "UNDISPELLABLE"), 99)
					end

					if _env.prevHpPercent < this.HpRatioFactor * 100 and _env.curHpPercent >= this.HpRatioFactor * 100 then
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Armor_13010",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"EquipSkill_Armor_13010"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Armor_13012 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Armor_13012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13001 = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.ProbTest(_env, this.RateFactor) then
					local buffeft1 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						duration = 2,
						display = "BlockRateUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"BLOCKRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13002 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13003 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13005 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13005",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13006 = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.ProbTest(_env, this.RateFactor) then
					local buffeft1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "CritRateUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"BLOCKRATEUP",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13007 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13009 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13010 = {
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

				if global.ProbTest(_env, this.RateFactor) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local heal = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")

					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Boots_13012 = {
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
				local buffeft1 = global.NumericEffect(_env, "*speed", {
					"+Normal",
					"+Normal"
				}, this.SpeedRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Boots_13012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13001 = {
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

				if global.ProbTest(_env, this.RateFactor) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						display = "HurtRateUp",
						group = "EquipSkill_Accesory_13001",
						duration = 1,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13002 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13003 = {
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
				local buffeft1 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13004 = {
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
				local buffeft1 = global.NumericEffect(_env, "+critstrg", {
					"+Normal",
					"+Normal"
				}, this.CritStrgFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13005 = {
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

				if global.ProbTest(_env, this.RateFactor) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						display = "Shield",
						group = "EquipSkill_Accesory_13005",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"STATUS",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13006 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13006",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13007 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13009 = {
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
				local buffeft1 = global.NumericEffect(_env, "+effectrate", {
					"+Normal",
					"+Normal"
				}, this.EffectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+uneffectrate", {
					"+Normal",
					"+Normal"
				}, this.UnEffectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13011 = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.ProbTest(_env, this.RateFactor) then
					for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
						local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 2,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13012 = {
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
				local buffeft1 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13013 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13014 = {
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
				local buffeft1 = global.NumericEffect(_env, "+becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13014",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13015 = {
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
				local buffeft1 = global.NumericEffect(_env, "+reflection", {
					"+Normal",
					"+Normal"
				}, this.ReflectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Accesory_13016 = {
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
				local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
					"+Normal",
					"+Normal"
				}, this.SkillRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Accesory_13016",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15000 = {
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
				local buffeft1 = global.NumericEffect(_env, "+singlerate", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Decoration_15000",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Decoration_15001 = {
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
				local buffeft1 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Decoration_15001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14001 = {
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
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+blockrate", {
					"+Normal",
					"+Normal"
				}, this.BlockRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14001",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14002 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+PROVOKE_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14002",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14003 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+singlekillrecoveryrate", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14003",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14004 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+reflection", {
					"+Normal",
					"+Normal"
				}, this.ReflectRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14004",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14005 = {
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

				local m = global.Min(_env, _env.num, 5)
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor * _env.num)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 3,
					group = "EquipSkill_Weapon_14005",
					timing = 2,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14006 = {
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

				if global.SpecialPropGetter(_env, "tierfeng" .. global.GetUnitCid(_env, _env.ACTOR))(_env, global.FriendField(_env)) == 0 then
					local buffeft1 = global.DeathImmuneEffect(_env, 1, this.HealRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "EquipSkill_Weapon_14006",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_14006"
						}
					}, {
						buffeft1
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "EquipSkill_Weapon_14006") then
					global.ApplyRPDamage(_env, _env.ACTOR, this.RageFactor)

					local buff_check = global.SpecialNumericEffect(_env, "+tierfeng" .. global.GetUnitCid(_env, _env.ACTOR), {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_14006_check"
						}
					}, {
						buff_check
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14007 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.CritRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14007",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14008 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+absorption", {
					"+Normal",
					"+Normal"
				}, this.AbsorpRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14008",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14009 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+singlecritsplitrate", {
					"+Normal",
					"+Normal"
				}, this.SplitRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14009",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14010 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14010",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14011 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+dispelprob", {
					"+Normal",
					"+Normal"
				}, this.DispelRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14011",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14012 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+delrppoint", {
					"+Normal",
					"+Normal"
				}, 0)
				local buffeft3 = global.SpecialNumericEffect(_env, "+delrprate", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft4 = global.SpecialNumericEffect(_env, "+delrpvalue", {
					"+Normal",
					"+Normal"
				}, this.DelRpValueFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14012",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14013 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+aoerate", {
					"+Normal",
					"+Normal"
				}, this.AOERateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14013",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14014 = {
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

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS - global.SUMMONS)) do
					_env.num = _env.num + 1
				end

				local m = global.Min(_env, _env.num, 5)
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor * m)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 3,
					group = "EquipSkill_Weapon_14014",
					timing = 2,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14015 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHpCheckRate", {
					"+Normal",
					"+Normal"
				}, this.LowerHpCheckRateFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+LowerHp_DmgExtra_hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14015",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14016 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.SelfAtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14016",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.OtherAtkRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 2,
						display = "atkrate",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKRATEUP",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14017 = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+aoekillrecoveryrate", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14017",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14018 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+delrppoint", {
					"+Normal",
					"+Normal"
				}, this.DelRpPointFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+delrprate", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft4 = global.SpecialNumericEffect(_env, "+delrpvalue", {
					"+Normal",
					"+Normal"
				}, this.DelRpValueFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14018",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14019 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+effectrate", {
					"+Normal",
					"+Normal"
				}, this.EftRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14019",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14020 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14020",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end,
		main = function(_env, externs)
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

				if global.HAS_SUMMONER(_env, _env.ACTOR)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						duration = 3,
						group = "EquipSkill_Weapon_TongYuFaQiu_Summoned",
						timing = 2,
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
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14021 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+afteratk_debecuredrate", {
					"+Normal",
					"+Normal"
				}, this.DeBeCuredRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14021",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14022 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14022",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})

				local Energy = 1

				if global.ProbTest(_env, this.RateFactor) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14023 = {
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

				if global.MASTER(_env, _env.ACTOR) then
					local buff_times = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_14023_times", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_14023_times"
						}
					}, {
						buff_times
					})
				end
			end)

			return _env
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buff_check = global.SpecialNumericEffect(_env, "+EquipSkill_Weapon_14023", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"EquipSkill_Weapon_14023_check"
						}
					}, {
						buff_check
					})

					local times = global.SpecialPropGetter(_env, "EquipSkill_Weapon_14023_times")(_env, global.FriendField(_env))
					local buff = global.SpecialPropGetter(_env, "EquipSkill_Weapon_14023")(_env, global.FriendField(_env))

					if _env.unit == _env.ACTOR and global.MASTER(_env, _env.ACTOR) == false and global.SpecialPropGetter(_env, "EquipSkill_Weapon_14023")(_env, global.FriendField(_env)) == 4 + (times - 1) * 3 then
						local buffeft1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkRateFactor)
						local buffeft2 = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, this.CritRateFactor)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "EquipSkill_Weapon_14023",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE"
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
	_M.__all__.EquipSkill_Weapon_14024 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+singlekillenergyrecoverrate", {
					"+Normal",
					"+Normal"
				}, this.RecoverRateFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+aoekillenergyrecoverrate", {
					"+Normal",
					"+Normal"
				}, this.RecoverRateFactor)
				local buffeft4 = global.SpecialNumericEffect(_env, "+singlekillenergyrecoverfactor", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft5 = global.SpecialNumericEffect(_env, "+aoekillenergyrecoverfactor", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14024",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3,
					buffeft4,
					buffeft5
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14025 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14025",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14026 = {
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
				local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_RatioCheck", {
					"+Normal",
					"+Normal"
				}, this.HpRatioFactor)
				local buffeft3 = global.SpecialNumericEffect(_env, "+LowerHp_HealExtra_ExtraRate", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14026",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2,
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14027 = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+afteratk_deatkrate", {
					"+Normal",
					"+Normal"
				}, this.DeAtkRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14027",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14028 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+extrapetshealrate_OnHeal", {
					"+Normal",
					"+Normal"
				}, this.HealRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14028",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.EquipSkill_Weapon_14029 = {
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
				local buffeft1 = global.NumericEffect(_env, "+curerate", {
					"+Normal",
					"+Normal"
				}, this.CureRateFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+extramasterdefrate_OnHeal", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "EquipSkill_Weapon_14029",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}

	return _M
end
