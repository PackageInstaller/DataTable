-- chunkname: @/tmp/or_skill/lua_compile/ArenaFixed.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.ArenaFixed_1 = {
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
				local buffeft1 = global.NumericEffect(_env, "+singlerate", {
					"+Normal",
					"+Normal"
				}, this.SingleDeRateFactor)
				local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, 0.35)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_1",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
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
				local master = global.FriendMaster(_env)

				if master then
					local buffeft3 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.35)

					global.ApplyBuff(_env, master, {
						duration = 99,
						group = "ArenaFixed_1_2",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_2 = {
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
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_2",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
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

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local master = global.FriendMaster(_env)

				if master then
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, global.FriendMaster(_env))
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, 0.35)

					global.ApplyBuff(_env, master, {
						duration = 99,
						group = "ArenaFixed_2_2",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
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
	_M.__all__.ArenaFixed_3 = {
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
				}, this.CriRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_3",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
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

				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_4 = {
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
				local buff = global.SpecialNumericEffect(_env, "+BeCuredRage", {
					"+Normal",
					"+Normal"
				}, this.RageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_4",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff,
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_5 = {
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

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
					local buffeft1 = global.MaxHpEffect(_env, maxHp * 0.35)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_5",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
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
					local buffeft2 = global.NumericEffect(_env, "+reflection", {
						"+Normal",
						"+Normal"
					}, 0.25)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_5_2",
						timing = 0,
						limit = 99,
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
	_M.__all__.ArenaFixed_6 = {
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

				if global.ProbTest(_env, 0.4) then
					global.ApplyRPRecovery(_env, _env.ACTOR, 1000)
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_7 = {
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
				local buffeft2 = global.SpecialNumericEffect(_env, "+delrppoint", {
					"+Normal",
					"+Normal"
				}, 1)
				local buffeft3 = global.SpecialNumericEffect(_env, "+delrprate", {
					"+Normal",
					"+Normal"
				}, 0.5)
				local buffeft4 = global.SpecialNumericEffect(_env, "-delrpvalue", {
					"+Normal",
					"+Normal"
				}, 200)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_7",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2,
					buffeft3,
					buffeft4
				})
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_9 = {
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
				local RateFactor = 0.2
				local HpRateFactor = 0.5
				local RageFactor = 500

				if global.ProbTest(_env, RateFactor) then
					local reviveunit = global.Revive(_env, HpRateFactor, RageFactor, {
						2,
						5,
						1,
						3,
						4,
						6,
						7,
						8,
						9
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_10 = {
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
				local Healfactor = 2
				local buffeft = global.SpecialNumericEffect(_env, "+ExtraHP", {
					"+Normal",
					"+Normal"
				}, Healfactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_10",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
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
	_M.__all__.ArenaFixed_11 = {
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
				local count = #global.EnemyUnits(_env, global.PETS - global.SUMMONS)
				local factor = 0.1
				local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, factor * count)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "ArenaFixed_11",
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
	_M.__all__.ArenaFixed_12 = {
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
				local def_factor = 0.2

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SUMMONS(_env, _env.unit) then
					local buffeft1 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, def_factor)
					local buffeft2 = global.Taunt(_env)

					global.ApplyBuff(_env, _env.unit, {
						duration = 99,
						group = "ArenaFixed_12",
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
					global.ApplyBuff(_env, _env.unit, {
						timing = 0,
						display = "Taunt",
						group = "ArenaFixed_12_taunt",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"TAUNT",
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
	_M.__all__.ArenaFixed_14 = {
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
				local i = global.Random(_env, 1, 4)
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, 0.1)
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, 0.1)
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft3 = global.ShieldEffect(_env, maxHp * 0.15)
				local buffeft4 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, 0.05)

				if i == 1 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "UnHurtRateUp",
						group = "ArenaFixed_14_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"UNHURTRATEUP"
						}
					}, {
						buffeft1
					})
				elseif i == 2 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "ArenaFixed_14_2",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"HURTRATEUP"
						}
					}, {
						buffeft2
					})
				elseif i == 3 then
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "Shield",
						group = "ArenaFixed_14_3",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"SHIELD"
						}
					}, {
						buffeft3
					})
				else
					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "CritRateUp",
						group = "ArenaFixed_14_4",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"CRITRATEUP"
						}
					}, {
						buffeft4
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_15 = {
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
				local factor = 0.03
				local count = 0

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					count = count + global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "BUFF"))
				end

				local buffeft = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, factor * count)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "HurtRateUp",
					group = "ArenaFixed_15",
					duration = 99,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"HURTRATEUP"
					}
				}, {
					buffeft
				})
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_18 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						_env.count = _env.count + 1
					end

					global.ApplyRPRecovery(_env, _env.ACTOR, _env.count * 70)
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_19 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "SUMMONED")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.SUMMONS(_env, unit) then
							_env.count = _env.count + 1
						end
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "ArenaFixed_19"), 99)

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2 * _env.count)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_19",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"ArenaFixed_19"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_20 = {
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
					}, 0.15)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_20",
						timing = 0,
						limit = 5,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"REFLECTION"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_21 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						_env.count = _env.count + 1
					end

					local buffeft1 = global.NumericEffect(_env, "+critrate", {
						"+Normal",
						"+Normal"
					}, 0.08 * _env.count)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 1,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"CRITRATE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_22 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count1 = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.MARKED(_env, "ASSASSIN")(_env, unit) then
							_env.count1 = _env.count1 + 1
						end
					end

					if _env.count1 > 2 then
						_env.count1 = 2
					end

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2 * _env.count1)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "skill_ArenaFixed_22")) > 0 then
							global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "skill_ArenaFixed_22"), 1)
						end

						global.ApplyBuff(_env, unit, {
							duration = 99,
							group = "ArenaFixed_22",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"CRITRATE",
								"skill ArenaFixed_22"
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

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count2 = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						if global.MARKED(_env, "ASSASSIN")(_env, unit) then
							_env.count2 = _env.count2 + 1
						end
					end

					if _env.count2 > 2 then
						_env.count2 = 2
					end

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2 * _env.count2)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "skill_ArenaFixed_22")) > 0 then
							global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF", "UNDISPELLABLE", "UNSTEALABLE", "skill_ArenaFixed_22"), 1)
						end

						global.ApplyBuff(_env, unit, {
							duration = 99,
							group = "ArenaFixed_22",
							timing = 0,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"CRITRATE",
								"skill_ArenaFixed_22"
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
	_M.__all__.ArenaFixed_23 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0
			_env.count_default = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					if global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
						_env.count = 1
					end

					for _, unit in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "ASSASSIN"))) do
						_env.count = _env.count + 1
					end

					if global.FriendMaster(_env) then
						_env.count_default = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count_default and _env.count_default ~= 0 then
						-- block empty
					else
						local buff = global.SpecialNumericEffect(_env, "+startcount", {
							"+Normal",
							"+Normal"
						}, _env.count)

						if global.FriendMaster(_env) then
							global.ApplyBuff(_env, global.FriendMaster(_env), {
								duration = 99,
								group = "ArenaFixed_23_count",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"STARTCOUNT",
									"skill_ArenaFixed_23",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					if global.FriendMaster(_env) then
						_env.count = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count > 3 then
						local buffeft1 = global.NumericEffect(_env, "+critrate", {
							"+Normal",
							"+Normal"
						}, 0.2)
						local buffeft2 = global.NumericEffect(_env, "+critstrg", {
							"+Normal",
							"+Normal"
						}, 0.5)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "ArenaFixed_23",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"skill_ArenaFixed_23",
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
	_M.__all__.ArenaFixed_24 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0
			_env.count_default = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					_env.count = 1

					for _, unit in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "MAGE"))) do
						_env.count = _env.count + 1
					end

					if global.FriendMaster(_env) then
						_env.count_default = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count_default and _env.count_default ~= 0 then
						-- block empty
					else
						local buff = global.SpecialNumericEffect(_env, "+startcount", {
							"+Normal",
							"+Normal"
						}, _env.count)

						if global.FriendMaster(_env) then
							global.ApplyBuff(_env, global.FriendMaster(_env), {
								duration = 99,
								group = "ArenaFixed_24_count",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"STARTCOUNT",
									"ArenaFixed_24",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					if global.FriendMaster(_env) then
						_env.count = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

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
					}, 40 * _env.count)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_24",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"ArenaFixed_24",
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
	_M.__all__.ArenaFixed_25 = {
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
					}, 0.1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_25",
						timing = 0,
						limit = 5,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"REFLECTION"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_26 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0
			_env.count_default = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					if global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
						_env.count = 1
					end

					for _, unit in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "MAGE"))) do
						_env.count = _env.count + 1
					end

					if global.FriendMaster(_env) then
						_env.count_default = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count_default and _env.count_default ~= 0 then
						-- block empty
					else
						local buff = global.SpecialNumericEffect(_env, "+startcount", {
							"+Normal",
							"+Normal"
						}, _env.count)

						if global.FriendMaster(_env) then
							global.ApplyBuff(_env, global.FriendMaster(_env), {
								duration = 99,
								group = "ArenaFixed_26_count",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"STARTCOUNT",
									"ArenaFixed_26",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					if global.FriendMaster(_env) then
						_env.count = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count > 4 then
						local buffeft = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, 0.5)

						if global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
							global.ApplyBuff(_env, _env.ACTOR, {
								duration = 99,
								group = "ArenaFixed_26",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"ArenaFixed_26",
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
		end
	}
	_M.__all__.ArenaFixed_27 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0
			_env.count_default = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					if global.MARKED(_env, "ASSASSIN")(_env, _env.ACTOR) then
						_env.count = 1
					end

					for _, unit in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "ASSASSIN"))) do
						_env.count = _env.count + 1
					end

					if global.FriendMaster(_env) then
						_env.count_default = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count_default and _env.count_default ~= 0 then
						-- block empty
					else
						local buff = global.SpecialNumericEffect(_env, "+startcount", {
							"+Normal",
							"+Normal"
						}, _env.count)

						if global.FriendMaster(_env) then
							global.ApplyBuff(_env, global.FriendMaster(_env), {
								duration = 99,
								group = "ArenaFixed_27_count",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"STARTCOUNT",
									"ArenaFixed_27",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					if global.FriendMaster(_env) then
						_env.count = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count > 2 then
						local buffeft = global.NumericEffect(_env, "+critstrg", {
							"+Normal",
							"+Normal"
						}, 0.5)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "ArenaFixed_27",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"ArenaFixed_27",
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
		end
	}
	_M.__all__.ArenaFixed_28 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive1 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				elseif global.MARKED(_env, "MAGE")(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, 0.2)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ArenaFixed_28",
						timing = 0,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"ArenaFixed_28",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
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
				local buff = global.NumericEffect(_env, "-unhurtrate", {
					"+Normal",
					"+Normal"
				}, 0.2)

				for _, unit1 in global.__iter__(global.AllUnits(_env, global.PETS)) do
					if global.SelectBuffCount(_env, unit1, global.BUFF_MARKED_ANY(_env, "DAZE", "MUTE")) ~= 0 and global.SelectBuffCount(_env, unit1, global.BUFF_MARKED_ALL(_env, "ArenaFixed_28", "UNHURTRATEDOWN")) == 0 then
						global.ApplyBuff(_env, unit1, {
							timing = 1,
							display = "UnHurtRateDown",
							group = "ArenaFixed_28_UnHurtRateDown",
							duration = 3,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"ArenaFixed_28",
								"UNHURTRATEDOWN",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.ArenaFixed_29 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.count = 0
			_env.count_default = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					if global.MARKED(_env, "HEALER")(_env, _env.ACTOR) then
						_env.count = 1
					end

					for _, unit in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HEALER"))) do
						_env.count = _env.count + 1
					end

					if global.FriendMaster(_env) then
						_env.count_default = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count_default and _env.count_default ~= 0 then
						-- block empty
					else
						local buff = global.SpecialNumericEffect(_env, "+startcount", {
							"+Normal",
							"+Normal"
						}, _env.count)

						if global.FriendMaster(_env) then
							global.ApplyBuff(_env, global.FriendMaster(_env), {
								duration = 99,
								group = "ArenaFixed_29_count",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"STARTCOUNT",
									"ArenaFixed_29",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					if global.FriendMaster(_env) then
						_env.count = global.SpecialPropGetter(_env, "startcount")(_env, global.FriendMaster(_env))
					end

					if _env.count > 1 then
						local buffeft = global.NumericEffect(_env, "+curerate", {
							"+Normal",
							"+Normal"
						}, 0.5)

						global.ApplyBuff(_env, _env.ACTOR, {
							duration = 99,
							group = "ArenaFixed_29",
							timing = 0,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"ArenaFixed_29",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft
						})

						if global.MARKED(_env, "HEALER")(_env, _env.ACTOR) then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
							local buffeft1 = global.MaxHpEffect(_env, maxHp * 0.5)

							global.ApplyBuff(_env, _env.ACTOR, {
								duration = 99,
								group = "skill_ArenaFixed_29_MaxHp",
								timing = 0,
								limit = 1,
								tags = {
									"NUMERIC",
									"BUFF",
									"ArenaFixed_29",
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
		end
	}
	_M.__all__.ArenaFixed_HurtRateUp = {
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
				local Time = global.GetbattleTime(_env)

				Time = global.ceil(_env, Time / 1000)

				if Time < this.Time1 then
					global.ShowEnhanceUp(_env, this.Time1 - Time, this.HurtRateFactor1 * 100)
				elseif Time == this.Time1 then
					local buff = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor1)

					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						if not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_1")) == 0 then
							global.ApplyBuff(_env, unit, {
								timing = 4,
								display = "HurtRateUp",
								group = "ArenaFixed_HurtRateUp",
								limit = 1,
								duration = this.Time2,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"ArenaFixed_HurtRateUp_1"
								}
							}, {
								buff
							})
						end
					end
				elseif Time > this.Time1 and Time < this.Time2 + this.Time1 then
					local Total_Time = this.Time2 + this.Time1

					global.ShowEnhanceUp(_env, Total_Time - Time, this.HurtRateFactor2 * 100)
				elseif Time == this.Time2 + this.Time1 then
					local buff = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor2)

					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "ArenaFixed_HurtRateUp_1"), 99)

						if not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_2")) == 0 then
							global.ApplyBuff(_env, unit, {
								timing = 4,
								display = "HurtRateUp",
								group = "ArenaFixed_HurtRateUp",
								limit = 1,
								duration = this.Time3,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"ArenaFixed_HurtRateUp_2"
								}
							}, {
								buff
							})
						end
					end
				elseif Time > this.Time2 + this.Time1 and Time < this.Time3 + this.Time2 + this.Time1 then
					local Total_Time = this.Time3 + this.Time2 + this.Time1

					global.ShowEnhanceUp(_env, Total_Time - Time, this.HurtRateFactor3 * 100)
				elseif Time == this.Time3 + this.Time2 + this.Time1 then
					local buff = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor3)

					for _, unit in global.__iter__(global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "ArenaFixed_HurtRateUp_2"), 99)

						if not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_3")) == 0 then
							global.ApplyBuff(_env, unit, {
								timing = 0,
								display = "HurtRateUp",
								group = "ArenaFixed_HurtRateUp",
								duration = 99,
								limit = 1,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"ArenaFixed_HurtRateUp_3"
								}
							}, {
								buff
							})
						end
					end

					global.HideEnhanceUp(_env)
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
				local Time = global.GetbattleTime(_env)

				Time = global.ceil(_env, Time / 1000)

				if not global.MASTER(_env, _env.unit) then
					if Time >= this.Time1 and Time < this.Time2 + this.Time1 then
						if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_1")) == 0 then
							local buff = global.NumericEffect(_env, "+hurtrate", {
								"+Normal",
								"+Normal"
							}, this.HurtRateFactor1)

							global.ApplyBuff(_env, _env.unit, {
								timing = 4,
								display = "HurtRateUp",
								group = "ArenaFixed_HurtRateUp",
								limit = 1,
								duration = this.Time2,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"ArenaFixed_HurtRateUp_1"
								}
							}, {
								buff
							})
						end
					elseif Time >= this.Time2 + this.Time1 and Time < this.Time3 + this.Time2 + this.Time1 then
						if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_2")) == 0 then
							local buff = global.NumericEffect(_env, "+hurtrate", {
								"+Normal",
								"+Normal"
							}, this.HurtRateFactor2)

							global.ApplyBuff(_env, _env.unit, {
								timing = 4,
								display = "HurtRateUp",
								group = "ArenaFixed_HurtRateUp",
								limit = 1,
								duration = this.Time3,
								tags = {
									"NUMERIC",
									"BUFF",
									"UNDISPELLABLE",
									"UNSTEALABLE",
									"ArenaFixed_HurtRateUp_2"
								}
							}, {
								buff
							})
						end
					elseif Time >= this.Time3 + this.Time2 + this.Time1 and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "ArenaFixed_HurtRateUp_3")) == 0 then
						local buff = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.HurtRateFactor3)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							display = "HurtRateUp",
							group = "ArenaFixed_HurtRateUp",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"ArenaFixed_HurtRateUp_3"
							}
						}, {
							buff
						})
					end
				end
			end)

			return _env
		end
	}

	return _M
end
