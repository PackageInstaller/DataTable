-- chunkname: @/tmp/or_skill/lua_compile/CrusadeBuffs.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.CrusadeBuffs_EnterSelfShield = {
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
					-- block empty
				else
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "CrusadeBuffs_EnterSelfShield",
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
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_OnAttackFreeze = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+freezeprob", {
						"+Normal",
						"+Normal"
					}, this.FreezeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_OnAttackFreeze",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_OnAttackDaze = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+dazeprob", {
						"+Normal",
						"+Normal"
					}, this.DazeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_OnAttackDaze",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_AfterActRpRecovery = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+addrpprob", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft2 = global.SpecialNumericEffect(_env, "+addrpvalue", {
						"+Normal",
						"+Normal"
					}, this.RageRecoverFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_AfterActRpRecovery",
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
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_AfterActHpRecovery = {
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

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

					global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_OnKillHpRecovery = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+aoekillrecoveryrate", {
						"+Normal",
						"+Normal"
					}, this.HealRateFactor)
					local buffeft2 = global.SpecialNumericEffect(_env, "+singlekillrecoveryrate", {
						"+Normal",
						"+Normal"
					}, this.HealRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_OnKillHpRecovery",
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
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_ToMasterHurtRateUp = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_ToMasterHurtRateUp",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_SingleCritSplit = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+singlecritsplitrate", {
						"+Normal",
						"+Normal"
					}, this.SplitRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_SingleCritSplit",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_SingleSplit = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+singlesplitrate", {
						"+Normal",
						"+Normal"
					}, this.SplitRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_SingleSplit",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_ToMasterDieBoom = {
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

				if (global.PETS - global.SUMMONS)(_env, _env.ACTOR) and global.EnemyMaster(_env) then
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, global.EnemyMaster(_env), "DEFENDER")
					local damage = global.EvalDamage(_env, attacker, defender, {
						1,
						this.DmgRateFactor,
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
	_M.__all__.CrusadeBuffs_EnergyRateUp = {
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
					local buffeft1 = global.EnergyEffect(_env, 1 + this.EnergyRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "EnergyEffectDown",
						group = "CrusadeBuffs_EnergyRateUp",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"ENERGYEFFECTDOWN",
							"UNDISPELLABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_MaxHeadCount = {
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

				if global.MASTER(_env, _env.ACTOR) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local count2 = #global.FriendUnits(_env, global.PETS)

					if count2 >= this.HeadCountFactor then
						global.LockHeroCards(_env, global.GetOwner(_env, _env.ACTOR))
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

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) and global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local count2 = #global.FriendUnits(_env, global.PETS)

					if count2 < this.HeadCountFactor then
						global.UnlockHeroCards(_env, global.GetOwner(_env, _env.ACTOR))
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_InitEnergyUp = {
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
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.EnergyRecoverFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_AOERate = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+aoerate", {
						"+Normal",
						"+Normal"
					}, this.AOERateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_AOERate",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_SingleRate = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.SingleRateFactor)
					local buffeft2 = global.NumericEffect(_env, "-aoerate", {
						"+Normal",
						"+Normal"
					}, this.SingleRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_SingleRate",
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
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_SingleRateUp_AoeRateDown = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.SingleRateFactor)
					local buffeft2 = global.NumericEffect(_env, "-aoerate", {
						"+Normal",
						"+Normal"
					}, this.SingleRateFactor)
					local buffeft3 = global.NumericEffect(_env, "-aoerate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_SingleRateUp_AoeRateDown",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_AoeDazeRate = {
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
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+afteratk_dazerate", {
						"+Normal",
						"+Normal"
					}, this.DazeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_AoeDazeRate",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_SingleDeRate = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+singlederate", {
						"+Normal",
						"+Normal"
					}, this.SingleDeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_SingleDeRate",
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
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnterHpReduce = {
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
					-- block empty
				else
					global.ApplyHpRatio(_env, _env.ACTOR, 0.5)
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_NumericEffect = {
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
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft4 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)
					local buffeft5 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)
					local buffeft6 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)
					local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft9 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)
					local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_NumericEffect",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeBuffs_NumericEffect",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5,
						buffeft6,
						buffeft7,
						buffeft8,
						buffeft9,
						buffeft10
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnterSelfShield = {
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
					-- block empty
				else
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "CrusadeBuffs_EnterSelfShield",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"CrusadeBuffs_EnterSelfShield",
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
	_M.__all__.CrusadeBuffs_EnergyDown = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyUp = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_NumericEffect_Type = {
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

				if this.Type1 == "Attack" then
					this.Type1 = "ASSASSIN"
				elseif this.Type1 == "Defense" then
					this.Type1 = "WARRIOR"
				elseif this.Type1 == "Cure" then
					this.Type1 = "HEALER"
				elseif this.Type1 == "Aoe" then
					this.Type1 = "MAGE"
				elseif this.Type1 == "Summon" then
					this.Type1 = "SUMMONER"
				elseif this.Type1 == "Support" then
					this.Type1 = "LIGHT"
				elseif this.Type1 == "Curse" then
					this.Type1 = "DARK"
				end

				if this.Type2 == "Attack" then
					this.Type2 = "ASSASSIN"
				elseif this.Type2 == "Defense" then
					this.Type2 = "WARRIOR"
				elseif this.Type2 == "Cure" then
					this.Type2 = "HEALER"
				elseif this.Type2 == "Aoe" then
					this.Type2 = "MAGE"
				elseif this.Type2 == "Summon" then
					this.Type2 = "SUMMONER"
				elseif this.Type2 == "Support" then
					this.Type2 = "LIGHT"
				elseif this.Type2 == "Curse" then
					this.Type2 = "DARK"
				end

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, this.Type1)(_env, _env.ACTOR) or global.MARKED(_env, this.Type2)(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft4 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)
					local buffeft5 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)
					local buffeft6 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)
					local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft9 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)
					local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_NumericEffect_Type",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeBuffs_NumericEffect_Type",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5,
						buffeft6,
						buffeft7,
						buffeft8,
						buffeft9,
						buffeft10
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnterSelfShield_Type = {
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

				if this.Type1 == "Attack" then
					this.Type1 = "ASSASSIN"
				elseif this.Type1 == "Defense" then
					this.Type1 = "WARRIOR"
				elseif this.Type1 == "Cure" then
					this.Type1 = "HEALER"
				elseif this.Type1 == "Aoe" then
					this.Type1 = "MAGE"
				elseif this.Type1 == "Summon" then
					this.Type1 = "SUMMONER"
				elseif this.Type1 == "Support" then
					this.Type1 = "LIGHT"
				elseif this.Type1 == "Curse" then
					this.Type1 = "DARK"
				end

				if this.Type2 == "Attack" then
					this.Type2 = "ASSASSIN"
				elseif this.Type2 == "Defense" then
					this.Type2 = "WARRIOR"
				elseif this.Type2 == "Cure" then
					this.Type2 = "HEALER"
				elseif this.Type2 == "Aoe" then
					this.Type2 = "MAGE"
				elseif this.Type2 == "Summon" then
					this.Type2 = "SUMMONER"
				elseif this.Type2 == "Support" then
					this.Type2 = "LIGHT"
				elseif this.Type2 == "Curse" then
					this.Type2 = "DARK"
				end

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, this.Type1)(_env, _env.ACTOR) or global.MARKED(_env, this.Type2)(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "CrusadeBuffs_EnterSelfShield_Type",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"CrusadeBuffs_EnterSelfShield_Type",
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
	_M.__all__.CrusadeBuffs_EnergyUp_Type = {
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

				if this.Type1 == "Attack" then
					this.Type1 = "ASSASSIN"
				elseif this.Type1 == "Defense" then
					this.Type1 = "WARRIOR"
				elseif this.Type1 == "Cure" then
					this.Type1 = "HEALER"
				elseif this.Type1 == "Aoe" then
					this.Type1 = "MAGE"
				elseif this.Type1 == "Summon" then
					this.Type1 = "SUMMONER"
				elseif this.Type1 == "Support" then
					this.Type1 = "LIGHT"
				elseif this.Type1 == "Curse" then
					this.Type1 = "DARK"
				end

				if this.Type2 == "Attack" then
					this.Type2 = "ASSASSIN"
				elseif this.Type2 == "Defense" then
					this.Type2 = "WARRIOR"
				elseif this.Type2 == "Cure" then
					this.Type2 = "HEALER"
				elseif this.Type2 == "Aoe" then
					this.Type2 = "MAGE"
				elseif this.Type2 == "Summon" then
					this.Type2 = "SUMMONER"
				elseif this.Type2 == "Support" then
					this.Type2 = "LIGHT"
				elseif this.Type2 == "Curse" then
					this.Type2 = "DARK"
				end

				if global.MASTER(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, this.Type1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_Type"
							}
						}, {
							cardvaluechange
						})
					end

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, this.Type2))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_Type"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyDown_Type = {
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

				if this.Type1 == "Attack" then
					this.Type1 = "ASSASSIN"
				elseif this.Type1 == "Defense" then
					this.Type1 = "WARRIOR"
				elseif this.Type1 == "Cure" then
					this.Type1 = "HEALER"
				elseif this.Type1 == "Aoe" then
					this.Type1 = "MAGE"
				elseif this.Type1 == "Summon" then
					this.Type1 = "SUMMONER"
				elseif this.Type1 == "Support" then
					this.Type1 = "LIGHT"
				elseif this.Type1 == "Curse" then
					this.Type1 = "DARK"
				end

				if this.Type2 == "Attack" then
					this.Type2 = "ASSASSIN"
				elseif this.Type2 == "Defense" then
					this.Type2 = "WARRIOR"
				elseif this.Type2 == "Cure" then
					this.Type2 = "HEALER"
				elseif this.Type2 == "Aoe" then
					this.Type2 = "MAGE"
				elseif this.Type2 == "Summon" then
					this.Type2 = "SUMMONER"
				elseif this.Type2 == "Support" then
					this.Type2 = "LIGHT"
				elseif this.Type2 == "Curse" then
					this.Type2 = "DARK"
				end

				if global.MASTER(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, this.Type1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_Type"
							}
						}, {
							cardvaluechange
						})
					end

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, this.Type2))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_Type"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_NumericEffect_Party = {
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
					-- block empty
				elseif global.MARKED(_env, this.Party)(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft4 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)
					local buffeft5 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)
					local buffeft6 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)
					local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft9 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)
					local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_NumericEffect_Party",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeBuffs_NumericEffect_Party",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5,
						buffeft6,
						buffeft7,
						buffeft8,
						buffeft9,
						buffeft10
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnterSelfShield_Party = {
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
					-- block empty
				elseif global.MARKED(_env, this.Party)(_env, _env.ACTOR) then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "CrusadeBuffs_EnterSelfShield_Party",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
							"CrusadeBuffs_EnterSelfShield_Party",
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
	_M.__all__.CrusadeBuffs_EnergyUp_Party = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, global.Type1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_Party"
							}
						}, {
							cardvaluechange
						})
					end

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, global.Type2))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_Party"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyDown_Party = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, global.Type1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_Party"
							}
						}, {
							cardvaluechange
						})
					end

					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, global.Type2))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_Party"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_NumericEffect_HigherThanX = {
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
					-- block empty
				elseif global.GetCost(_env, _env.ACTOR) > this.Energy then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft4 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)
					local buffeft5 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)
					local buffeft6 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)
					local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft9 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)
					local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_NumericEffect_HigherThanX",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeBuffs_NumericEffect_HigherThanX",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5,
						buffeft6,
						buffeft7,
						buffeft8,
						buffeft9,
						buffeft10
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyUp_HigherThanX = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_COST_GE(_env, this.Energy + 1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_HigherThanX"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyDown_HigherThanX = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_COST_GE(_env, this.Energy + 1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_HigherThanX"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_NumericEffect_LowerThanX = {
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
					-- block empty
				elseif global.GetCost(_env, _env.ACTOR) < this.Energy then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.DefRateFactor)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
					local buffeft4 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)
					local buffeft5 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)
					local buffeft6 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsorptionRateFactor)
					local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)
					local buffeft9 = global.NumericEffect(_env, "+curerate", {
						"+Normal",
						"+Normal"
					}, this.CureRateFactor)
					local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "CrusadeBuffs_NumericEffect_LowerThanX",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CrusadeBuffs_NumericEffect_LowerThanX",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1,
						buffeft2,
						buffeft3,
						buffeft4,
						buffeft5,
						buffeft6,
						buffeft7,
						buffeft8,
						buffeft9,
						buffeft10
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyUp_LowerThanX = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_COST_LE(_env, this.Energy - 1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_LowerThanX"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyDown_LowerThanX = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_COST_LE(_env, this.Energy - 1))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_LowerThanX"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_AfterActHurtRateUp_LowerThan14 = {
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

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.GetCost(_env, _env.ACTOR) < 14 then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "CrusadeBuffs_AfterActHurtRateUp_LowerThan14",
						duration = 99,
						limit = 5,
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
	_M.__all__.CrusadeBuffs_NumericEffect_Master = {
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

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, this.Master)(_env, _env.ACTOR) then
					local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))

					for _, card in global.__iter__(cards) do
						local buffeft1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, this.AtkRateFactor)
						local buffeft2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, this.DefRateFactor)
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
						local buffeft3 = global.MaxHpEffect(_env, maxHp * this.MaxHpRateFactor)
						local buffeft4 = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, this.CritRateFactor)
						local buffeft5 = global.NumericEffect(_env, "+blockrate", {
							"+Normal",
							"+Normal"
						}, this.BlockRateFactor)
						local buffeft6 = global.NumericEffect(_env, "+absorption", {
							"+Normal",
							"+Normal"
						}, this.AbsorptionRateFactor)
						local buffeft7 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.HurtRateFactor)
						local buffeft8 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.UnHurtRateFactor)
						local buffeft9 = global.NumericEffect(_env, "+curerate", {
							"+Normal",
							"+Normal"
						}, this.CureRateFactor)
						local buffeft10 = global.NumericEffect(_env, "+becuredrate", {
							"+Normal",
							"+Normal"
						}, this.BeCuredRateFactor)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "CrusadeBuffs_NumericEffect_Master",
							timing = 0,
							limit = 1,
							tags = {
								"CARDBUFF",
								"CrusadeBuffs_NumericEffect_Master",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1,
							buffeft2,
							buffeft3,
							buffeft4,
							buffeft5,
							buffeft6,
							buffeft7,
							buffeft8,
							buffeft9,
							buffeft10
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyUp_Master = {
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

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, this.Master)(_env, _env.ACTOR) then
					local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))

					for _, card in global.__iter__(cards) do
						local cardvaluechange = global.CardCostEnchant(_env, "+", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyUp_Master"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CrusadeBuffs_EnergyDown_Master = {
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

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, this.Master)(_env, _env.ACTOR) then
					local cards = global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))

					for _, card in global.__iter__(cards) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.EnergyFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"CrusadeBuffs_EnergyDown_Master"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}

	return _M
end
