-- chunkname: @/tmp/or_skill/lua_compile/SectSkill.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.SectSkill_Master_XueZhan_1 = {
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

				if global.MASTER(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)
					local buffeft3 = global.AngerPeriodRecover(_env, "HOT", 5)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_XueZhan_1",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan_2 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.SpecialPropGetter(_env, global.GetUnitCid(_env, _env.unit))(_env, _env.ACTOR) == 0 then
					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.05)
					local buff2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.05)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "SectSkill_Master_XueZhan_2",
						duration = 99,
						limit = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"HURTRATEUP",
							"SectSkill_Master_XueZhan_2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2
					}, 1)

					local buffeft_flag = global.SpecialNumericEffect(_env, "+" .. global.GetUnitCid(_env, _env.unit), {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft_flag
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan_3 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+xuezhan_special_atk", {
						"?Normal"
					}, 3)
					local buffeft2 = global.SpecialNumericEffect(_env, "+xuezhan_special_maxhp", {
						"?Normal"
					}, this.MaxHpRateFactor)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_XueZhan_3",
						timing = 0,
						limit = 1,
						tags = {
							"SECTSKILL",
							"SectSkill_Master_XueZhan_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "SECTSKILL", "SectSkill_Master_XueZhan_3"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan_4 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_XueZhan_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_XueZhan_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan_5 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_XueZhan_5",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_XueZhan_5",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan_6 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.1)
					local buff2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "HurtRateUp",
						group = "SectSkill_Master_XueZhan_6",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"HURTRATEUP",
							"SectSkill_Master_XueZhan_2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha_1 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.MasterHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_1",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha_1",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha_2 = {
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

				if global.EqualsCamp(_env, _env.ACTOR, _env.unit) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.EnemyMaster(_env) then
					local attacker = global.LoadUnit(_env, _env.unit, "ATTACKER")
					local defender = global.LoadUnit(_env, global.EnemyMaster(_env), "DEFENDER")
					local damage = global.EvalDamage(_env, attacker, defender, {
						1,
						1,
						0
					})

					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.EnemyMaster(_env))
					})
					global.ApplyHPDamage(_env, global.EnemyMaster(_env), damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha_3 = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) and (global.MARKED(_env, "SSR")(_env, _env.unit) or global.MARKED(_env, "SP")(_env, _env.unit)) then
					local buffeft = global.SpecialNumericEffect(_env, "+unique_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.unit, _env.unit, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNIQUE_HURTRATEUP",
							"SectSkill_Master_LieSha_3",
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
	_M.__all__.SectSkill_Master_LieSha_4 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_LieSha_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha_5 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.times = 1

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.times == 1 then
					local cards = global.Slice(_env, global.SortBy(_env, global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR)), ">", global.GetCardCost), 1, 4)

					for _, card in global.__iter__(cards) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CardChangeValueFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"SectSkill_Master_LieSha_5",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
					end

					_env.times = _env.times + 1
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_5",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha_5_2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha_6 = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buff2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buff3 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_6",
						timing = 0,
						limit = 1,
						tags = {
							"BUFF",
							"SectSkill_Master_LieSha_6",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2,
						buff3
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_BiLei_1 = {
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
				local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, 0.1)
				local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, 0.3)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					duration = 99,
					group = "SectSkill_Master_BiLei_1",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"SECTSKILL",
						"SectSkill_Master_BiLei_1",
						"UNHURTRATEUP",
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
	_M.__all__.SectSkill_Master_BiLei_2 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft = global.ShieldEffect(_env, maxHp * this.ShieldFactor)
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.unit)
					local buffeft2 = global.NumericEffect(_env, "+atk", {
						"+Normal",
						"+Normal"
					}, atk * 0.1)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "SectSkill_Master_BiLei_2",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_BiLei_2",
							"SHIELD",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_BiLei_3 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.EnergyExFactor)
				end
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
				local cards = global.Slice(_env, global.SortBy(_env, global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR)), ">", global.GetCardCost), 1, 1)

				for _, card in global.__iter__(cards) do
					local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyReduce, 2)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						tags = {
							"CARDBUFF",
							"SectSkill_Master_BiLei_3",
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
	_M.__all__.SectSkill_Master_BiLei_4 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_BiLei_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_BiLei_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_BiLei_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_BiLei_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_BiLei_5 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.times = 1

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.times == 1 then
					local cards = global.Slice(_env, global.SortBy(_env, global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR)), ">", global.GetCardCost), 1, 4)

					for _, card in global.__iter__(cards) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CardChangeValueFactor, 2)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"SectSkill_Master_LieSha_5",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
					end

					_env.times = _env.times + 1
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buff3 = global.MaxHpEffect(_env, maxHp * 0.15)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_5_2",
						timing = 0,
						limit = 1,
						tags = {
							"BUFF",
							"SectSkill_Master_LieSha_5",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff3
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_BiLei_6 = {
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buff1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, 0.1)
					local buff2 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buff3 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buff4 = global.NumericEffect(_env, "+uncritrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha_6",
						timing = 0,
						limit = 1,
						tags = {
							"BUFF",
							"SectSkill_Master_LieSha_6",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1,
						buff2,
						buff3,
						buff4
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_1 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						duration = 40,
						group = "SectSkill_Master_FuHun_1_0",
						timing = 4,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SectSkill_Master_FuHun_1",
							"SECTSKILL",
							"UNHURTRATEUP",
							"SectSkill_Master_FuHun_1_0",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SectSkill_Master_FuHun_1")) == 0 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.35)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						duration = 99,
						group = "SectSkill_Master_FuHun_1_40",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"UNHURTRATEUP",
							"SectSkill_Master_FuHun_1_40",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_2 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+aoerate", {
						"+Normal",
						"+Normal"
					}, this.AOEHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun_2",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"AOERATEUP",
							"SectSkill_Master_FuHun_2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_3 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					global.AddStatus(_env, _env.unit, "SectSkill_Master_FuHun_3")

					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.35)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 10,
						group = "SectSkill_Master_FuHun_3",
						timing = 4,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_FuHun_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_4 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_LieSha_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * 0.1)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_BiLei_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_BiLei_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_5 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 0.15)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun_5",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_FuHun_5",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
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

				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), 1)
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun_6 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buffeft3 = global.NumericEffect(_env, "+singlederate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun_6",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_FuHun_6",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing_1 = {
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

				if global.MASTER(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
						timing = 0,
						display = "HurtRateUp",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"BECUREDRATEUP",
							"DISPELLABLE",
							"SectSkill_Master_SenLing_1"
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
	_M.__all__.SectSkill_Master_SenLing_2 = {
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
				local buffeft1 = global.DeathImmuneEffect(_env, 2)

				global.ApplyBuff_Buff(_env, _env.ACTOR, global.FriendMaster(_env), {
					timing = 0,
					display = "Undead",
					group = "SectSkill_Master_SenLing_2",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_SSQXin_Passive",
						"UNDEAD",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing_3 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "SectSkill_Master_SenLing_3")

					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, 0.3)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_SenLing_3",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"SECTSKILL",
							"SectSkill_Master_SenLing_3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing_4 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						duration = 99,
						group = "SectSkill_Master_SenLing_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_SenLing_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_SenLing_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_SenLing_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing_5 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft2 = global.MaxHpEffect(_env, maxHp * this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_SenLing_5",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_SenLing_5",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
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

				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), 1)
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing_6 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)
					local buffeft3 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, 0.5)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_SenLing_6",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_SenLing_6",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LiMing_1 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local buff = global.PassiveFunEffectBuff(_env, "Skill_Sustained_RPRecovery", {
						RateFactor = this.RpFactor
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"SECTSKILL",
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
	_M.__all__.SectSkill_Master_LiMing_2 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.SpecialPropGetter(_env, global.GetUnitCid(_env, _env.unit))(_env, _env.ACTOR) == 0 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "SectSkill_Master_LiMing_2",
						duration = 99,
						limit = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"HURTRATEUP",
							"SectSkill_Master_LiMing_2",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)

					local buffeft_flag = global.SpecialNumericEffect(_env, "+" .. global.GetUnitCid(_env, _env.unit), {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft_flag
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LiMing_3 = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local buff = global.SpecialNumericEffect(_env, "+liming_atk", {
						"?Normal"
					}, atk)

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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local atk = global.SpecialPropGetter(_env, "liming_atk")(_env, global.FriendField(_env))
					local atk_pet = atk * this.AtkFactor
					local buffeft1 = global.NumericEffect(_env, "+atk", {
						"+Normal",
						"+Normal"
					}, atk_pet)

					for _, unit in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), unit, {
							duration = 99,
							group = "SectSkill_Master_LiMing_3",
							timing = 0,
							limit = 99,
							tags = {
								"CARDBUFF",
								"NUMERIC",
								"BUFF",
								"SECTSKILL",
								"ATKUP",
								"SectSkill_Master_LiMing_3",
								"UNDISPELLABLE",
								"UNSTEALABLE"
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
	_M.__all__.SectSkill_Master_LiMing_4 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (-global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LiMing_4",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LiMing_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LiMing_5 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (-global.SUMMONS)(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LiMing_5",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LiMing_5",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LiMing_6 = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (-global.SUMMONS)(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LiMing_6",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LiMing_6",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_WuShi = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+extra_aoehurtrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_JiangJun = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+extra_aoehurtrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_ZhaoHuan = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+extra_aoehurtrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_XueZhan = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_XueZhan",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_XueZhan",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_LieSha = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.MasterHurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_LieSha",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_LieSha",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_BiLei = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.EnergyExFactor)
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
					if _env.prevHpPercent < 80 or _env.curHpPercent >= 80 or global.INSTATUS(_env, "SectSkill_Master_BiLei_2_FirstTime1")(_env, _env.ACTOR) then
						-- block empty
					else
						global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.StepEnergyExFactor)
						global.AddStatus(_env, _env.ACTOR, "SectSkill_Master_BiLei_2_FirstTime1")
					end

					if _env.prevHpPercent < 70 or _env.curHpPercent >= 70 or global.INSTATUS(_env, "SectSkill_Master_BiLei_2_FirstTime2")(_env, _env.ACTOR) then
						-- block empty
					else
						global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.StepEnergyExFactor)
						global.AddStatus(_env, _env.ACTOR, "SectSkill_Master_BiLei_2_FirstTime2")
					end

					if _env.prevHpPercent < 60 or _env.curHpPercent >= 60 or global.INSTATUS(_env, "SectSkill_Master_BiLei_2_FirstTime3")(_env, _env.ACTOR) then
						-- block empty
					else
						global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.StepEnergyExFactor)
						global.AddStatus(_env, _env.ACTOR, "SectSkill_Master_BiLei_2_FirstTime3")
					end

					if _env.prevHpPercent < 50 or _env.curHpPercent >= 50 or global.INSTATUS(_env, "SectSkill_Master_BiLei_2_FirstTime4")(_env, _env.ACTOR) then
						-- block empty
					else
						global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.StepEnergyExFactor)
						global.AddStatus(_env, _env.ACTOR, "SectSkill_Master_BiLei_2_FirstTime4")
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_FuHun = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, global.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "SectSkill_Master_FuHun",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_FuHun",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.SectSkill_Master_SenLing = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "Shield",
						group = "SectSkill_Master_SenLing",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SECTSKILL",
							"SectSkill_Master_SenLing",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)

			return _env
		end
	}

	return _M
end
