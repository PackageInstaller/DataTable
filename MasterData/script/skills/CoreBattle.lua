-- chunkname: @/tmp/or_skill/lua_compile/CoreBattle.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.CoreBattle_AtkRateUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_AtkRateUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
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
	_M.__all__.CoreBattle_DefRateUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_DefRateUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DEFRATEUP",
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
	_M.__all__.CoreBattle_MaxHpUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local healee = global.LoadUnit(_env, _env.unit, "ALL")
					local buffeft1 = global.MaxHpEffect(_env, healee.maxHp * 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_MaxHpUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"MAXHPUP",
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
	_M.__all__.CoreBattle_CritRateUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_CritRateUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"CRITRATEUP",
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
	_M.__all__.CoreBattle_DeadCurse = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local target = global.EnemyMaster(_env)

					if target then
						local defender = global.LoadUnit(_env, target, "ALL")

						global.ApplyHPDamage(_env, target, defender.maxHp * 0.025)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_CritCure = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, friend in global.__iter__(global.FriendUnits(_env)) do
						local healee = global.LoadUnit(_env, friend, "ALL")

						global.ApplyHPRecovery(_env, friend, healee.maxHp * 0.1)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_Absorption = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, 0.05)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_Absorption",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"ABSORPTIONUP",
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
	_M.__all__.CoreBattle_Reflection = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_Reflection",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"REFLECTION",
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
	_M.__all__.CoreBattle_Shield = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local healee = global.LoadUnit(_env, _env.unit, "ALL")
					local buffeft1 = global.ShieldEffect(_env, healee.maxHp * 0.25)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_Shield",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD",
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
	_M.__all__.CoreBattle_CureUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+becuredrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "AtkUp",
						group = "CoreBattle_CureUp",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"BECUREDRATEUP",
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
	_M.__all__.CoreBattle_EffectUp = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+effectrate", {
						"+Normal",
						"+Normal"
					}, 0.1)
					local buffeft2 = global.NumericEffect(_env, "+uneffectrate", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_EffectUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"EFFECTRATEUP",
							"UNEFFECTRATEUP",
							"UNDISPELLABLE"
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
	_M.__all__.CoreBattle_DeadRage = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					for _, friend in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyRPRecovery(_env, friend, 5)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_Madness = {
		__new__ = function(prototype, externs, global)
			return
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, (100 - _env.curHpPercent) * 0.002)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_Madness",
						timing = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
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
	_M.__all__.CoreBattle_Reborn = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.ProbTest(_env, 0.1) then
					global.RebornUnit(_env, _env.unit, 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_Defence = {
		__new__ = function(prototype, externs, global)
			return
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

			_env.prevHpPercent = externs.prevHpPercent

			assert(_env.prevHpPercent ~= nil, "External variable `prevHpPercent` is not provided.")

			_env.curHpPercent = externs.curHpPercent

			assert(_env.curHpPercent ~= nil, "External variable `curHpPercent` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == _env.ACTOR then
					if _env.prevHpPercent >= 30 and _env.curHpPercent < 30 then
						for _, friend in global.__iter__(global.FriendUnits(_env, global.PETS)) do
							local buffeft1 = global.NumericEffect(_env, "+blockrate", {
								"+Normal",
								"+Normal"
							}, 0.25)
							local buffeft2 = global.NumericEffect(_env, "+defrate", {
								"+Normal",
								"+Normal"
							}, 0.25)

							global.ApplyBuff(_env, friend, {
								timing = 0,
								display = "AtkUp",
								group = "CoreBattle_Defence",
								duration = 99,
								limit = 1,
								tags = {
									"NUMERIC",
									"BUFF",
									"BLOCKRATEUP",
									"DEFRATEUP",
									"COREBATTLE_DEFENCE",
									"UNDISPELLABLE"
								}
							}, {
								buffeft1,
								buffeft2
							})
						end
					elseif _env.prevHpPercent < 30 and _env.curHpPercent >= 30 then
						for _, friend in global.__iter__(global.FriendUnits(_env)) do
							global.DispelBuff(_env, friend, global.BUFF_MARKED_ALL(_env, "COREBATTLE_DEFENCE", "UNDISPELLABLE"), 99)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_Recovery = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
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

				for _, friend in global.__iter__(global.FriendUnits(_env)) do
					local healee = global.LoadUnit(_env, friend, "ALL")

					if healee.hpRatio < 0.25 then
						global.ApplyHPRecovery(_env, friend, healee.maxHp * 0.15)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_SummonCure = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local target = global.FriendMaster(_env)
					local healee = global.LoadUnit(_env, target, "ALL")

					global.ApplyHPRecovery(_env, target, healee.maxHp * 0.05)
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_DeadBless = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.PETS(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, friend in global.__iter__(global.FriendUnits(_env)) do
						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, 0.1)
						local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, 0.1)

						global.ApplyBuff(_env, friend, {
							duration = 1,
							group = "CoreBattle_DeadBless",
							timing = 2,
							limit = 99,
							tags = {
								"NUMERIC",
								"BUFF",
								"HURTRATEUP",
								"UNHURTRATEUP",
								"UNDISPELLABLE"
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
	_M.__all__.CoreBattle_RageUp = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
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

				for _, friend in global.__iter__(global.FriendUnits(_env)) do
					global.ApplyRPRecovery(_env, friend, 100)
				end
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_Daze = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+dazeprob", {
						"+Normal",
						"+Normal"
					}, 0.1)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_Daze",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
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
	_M.__all__.CoreBattle_CtrlHurt = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+ctrlexdmg", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_CtrlHurt",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
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
	_M.__all__.CoreBattle_RageHurt = {
		__new__ = function(prototype, externs, global)
			return
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+delrpprob", {
						"+Normal",
						"+Normal"
					}, 0.25)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "CoreBattle_RageHurt",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
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
	_M.__all__.CoreBattle_SummonUp = {
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
				return
			end)

			return _env
		end
	}
	_M.__all__.CoreBattle_GuardUp = {
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
				return
			end)

			return _env
		end
	}

	return _M
end
