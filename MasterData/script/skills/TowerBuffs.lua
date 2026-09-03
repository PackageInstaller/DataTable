-- chunkname: @/tmp/or_skill/lua_compile/TowerBuffs.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.TowerBuffs_CritRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, this.CritRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_CritRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_BlockRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+blockrate", {
						"+Normal",
						"+Normal"
					}, this.BlockRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_BlockRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_ReflectRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, this.ReflectRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_ReflectRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_OnKillHpRecovery = {
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
						group = "TowerBuffs_OnKillHpRecovery",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_SingleCritSplit = {
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
						group = "TowerBuffs_SingleCritSplit",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_ToMasterHurtRateUp = {
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
					}, 0.125)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_ToMasterHurtRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_EnterSelfShield = {
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
						timing = 2,
						display = "Shield",
						group = "TowerBuffs_EnterSelfShield",
						duration = 3,
						limit = 99,
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
	_M.__all__.TowerBuffs_AOERateUp = {
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
						group = "TowerBuffs_AOERateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_DieBoom = {
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
				elseif global.EnemyMaster(_env) then
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
	_M.__all__.TowerBuffs_OnAttackDeRage = {
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
					local buffeft1 = global.SpecialNumericEffect(_env, "+delrppoint", {
						"+Normal",
						"+Normal"
					}, 0)
					local buffeft2 = global.SpecialNumericEffect(_env, "+delrprate", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft3 = global.SpecialNumericEffect(_env, "+delrpvalue", {
						"+Normal",
						"+Normal"
					}, this.DelRpValueFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_OnAttackDeRage",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_OnKillEnergyRecovery = {
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
					local buffeft1 = global.SpecialNumericEffect(_env, "+singlekillenergyrecoverrate", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft2 = global.SpecialNumericEffect(_env, "+aoekillenergyrecoverrate", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft3 = global.SpecialNumericEffect(_env, "+singlekillenergyrecoverfactor", {
						"+Normal",
						"+Normal"
					}, this.EnergyRecoveryFactor)
					local buffeft4 = global.SpecialNumericEffect(_env, "+aoekillenergyrecoverfactor", {
						"+Normal",
						"+Normal"
					}, this.EnergyRecoveryFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_OnKillEnergyRecovery",
						timing = 0,
						limit = 99,
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
				end
			end)

			return _env
		end
	}
	_M.__all__.TowerBuffs_OnAttackDaze = {
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
						group = "TowerBuffs_OnAttackDaze",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_OnAttackFreeze = {
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
						group = "TowerBuffs_OnAttackFreeze",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_AOEDeRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AOEDeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_AOEDeRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_SingleDeRateUp = {
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
						group = "TowerBuffs_SingleDeRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_AfterActRpRecovery = {
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
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageRecoverFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TowerBuffs_OnBlockHpRecovery = {
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
					local buffeft1 = global.SpecialNumericEffect(_env, "+blockrecoveryrate", {
						"+Normal",
						"+Normal"
					}, this.HealRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_OnBlockHpRecovery",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_OnHurtShield = {
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
						timing = 2,
						display = "Shield",
						group = "TowerBuffs_OnHurtShield",
						duration = 2,
						limit = 99,
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
	_M.__all__.TowerBuffs_BeCuredRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, this.BeCuredRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_BeCuredRateUp",
						timing = 0,
						limit = 99,
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
	_M.__all__.TowerBuffs_AfterActUnHurtRateUp = {
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
					local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						display = "UnHurtRateUp",
						group = "TowerBuffs_AfterActUnHurtRateUp",
						duration = 3,
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
	_M.__all__.TowerBuffs_HurtRate_UnHurtRate_Up = {
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
					}, this.HurtRateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.UnHurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "TowerBuffs_HurtRate_UnHurtRate_Up",
						timing = 0,
						limit = 99,
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

	return _M
end
