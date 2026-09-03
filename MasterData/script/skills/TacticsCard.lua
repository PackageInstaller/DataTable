-- chunkname: @/tmp/or_skill/lua_compile/TacticsCard.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.TacticsCard_Damage_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian"))) do
					global.AssignRoles(_env, unit, "target")
					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})

					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

					global.ApplyHPDamage(_env, unit, maxHp * this.DamageRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_Damage_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian")))) do
					global.AssignRoles(_env, unit, "target")
					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})

					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

					global.ApplyHPDamage(_env, unit, maxHp * this.DamageRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_Freeze_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian"))

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "bingdong_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					if global.ProbTest(_env, this.FreezeRateFactor) then
						local buffeft1 = global.Daze(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "Freeze",
							tags = {
								"STATUS",
								"DEBUFF",
								"FREEZE",
								"ABNORMAL",
								"DISPELLABLE"
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
	_M.__all__.TacticsCard_Freeze_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian")))

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "bingdong_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					if global.ProbTest(_env, 1) then
						local buffeft1 = global.Daze(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 2,
							display = "Freeze",
							tags = {
								"STATUS",
								"DEBUFF",
								"FREEZE",
								"ABNORMAL",
								"DISPELLABLE"
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
	_M.__all__.TacticsCard_HurtRateUp_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.FriendUnits(_env, global.PETS)

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "jili_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
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
	_M.__all__.TacticsCard_HurtRateUp_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS))

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "jili_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "HurtRateUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"HURTRATEUP",
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
	_M.__all__.TacticsCard_RageUp_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.FriendUnits(_env, global.PETS)

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "jinu_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyRPRecovery(_env, unit, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_RageUp_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS))

				for _, unit in global.__iter__(_env.units) do
					global.AddAnim(_env, {
						loop = 1,
						anim = "jinu_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, unit)
					})
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyRPRecovery(_env, unit, this.RageFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_Cure_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

					global.ApplyHPRecovery(_env, unit, maxHp * this.CureRateFactor)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
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
	_M.__all__.TacticsCard_Cure_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env, global.PETS), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

					global.ApplyHPRecovery(_env, unit, maxHp * this.CureRateFactor)

					local buffeft2 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
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
	_M.__all__.TacticsCard_Dispel_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)

					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Dispel",
						tags = {
							"Dispel",
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
	_M.__all__.TacticsCard_Dispel_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS))) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)

					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Dispel",
						tags = {
							"Dispel",
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
	_M.__all__.TacticsCard_Undead = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 2, global.FriendUnits(_env, global.PETS))) do
					local buffeft1 = global.DeathImmuneEffect(_env, 1)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						display = "Undead",
						group = "TacticsCard_Undead",
						duration = 1,
						limit = 1,
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"UNDEAD",
							"UNSTEALABLE",
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
	_M.__all__.TacticsCard_Summon = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedTacticsCard_TombStone = global.Summon(_env, global.FriendMaster(_env), "SummonedTacticsCard_TombStone", {
					0,
					0,
					0
				}, {
					1,
					0,
					0
				}, {
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

				if SummonedTacticsCard_TombStone then
					global.AddStatus(_env, SummonedTacticsCard_TombStone, "SummonedTacticsCard_TombStone")

					local buffeft1 = global.DeathImmuneEffect(_env, 1, nil)

					global.ApplyBuff(_env, SummonedTacticsCard_TombStone, {
						timing = 0,
						duration = 99,
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
		end
	}
	_M.__all__.TacticsCard_Stealth = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS)) do
					local buffeft1 = global.Stealth(_env, 0.8)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 1,
						display = "Stealth",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALTH",
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
	_M.__all__.TacticsCard_MasterTaunt = {
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
				local buffeft3 = global.Taunt(_env)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 2,
					display = "Taunt",
					tags = {
						"STATUS",
						"BUFF",
						"TAUNT",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft3
				})
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_Sacrifice = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS))) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)

					global.KillTarget(_env, unit)
					global.ApplyHPRecovery(_env, global.FriendMaster(_env), maxHp * this.CureRateFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_PeriodDamage_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS)) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", maxHp * this.DOTRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 1,
						display = "Poison",
						group = "Poison_TacticsCard",
						duration = 3,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON_TACTICSCARD",
							"DISPELLABLE",
							"POISON",
							"ABNORMAL"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_PeriodDamage_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS))) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local buffeft1 = global.HPPeriodDamage(_env, "Poison", maxHp * this.DOTRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 1,
						display = "Poison",
						group = "Poison_TacticsCard",
						duration = 3,
						limit = 10,
						tags = {
							"STATUS",
							"DEBUFF",
							"POISON_TACTICSCARD",
							"DISPELLABLE",
							"POISON",
							"ABNORMAL"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_SpeedDown_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS)) do
					local buffeft1 = global.NumericEffect(_env, "-speed", {
						"+Normal",
						"+Normal"
					}, this.DeSpeedRateFactor)

					global.ApplyBuff(_env, unit, {
						timing = 2,
						duration = 3,
						display = "SpeedDown",
						tags = {
							"NUMERIC",
							"DEBUFF",
							"SPEEDDOWN",
							"DISPELLABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.TacticsCard_Mute_Multi = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS)) do
					if global.ProbTest(_env, 1) then
						local buffeft1 = global.Mute(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
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
	_M.__all__.TacticsCard_Mute_Single = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS))) do
					if global.ProbTest(_env, 1) then
						local buffeft1 = global.Mute(_env)

						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
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

	return _M
end
