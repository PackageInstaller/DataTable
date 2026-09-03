-- chunkname: @/tmp/or_skill/lua_compile/Skill_XLDBLTe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_XLDBLTe_Normal = {
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
					-1.7,
					0
				}, 100, "skill1"))
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
	_M.__all__.Skill_XLDBLTe_Proud = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				900
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
	_M.__all__.Skill_XLDBLTe_Unique = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.2,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.TARGET)
				global.AssignRoles(_env, _env.TARGET, "target")
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local enemy_master_hpratio = 1
				local friend_master_hpratio = 1

				if global.EnemyMaster(_env) and global.FriendMaster(_env) then
					enemy_master_hpratio = global.UnitPropGetter(_env, "hpRatio")(_env, global.EnemyMaster(_env))
					friend_master_hpratio = global.UnitPropGetter(_env, "hpRatio")(_env, global.FriendMaster(_env))
				end

				if friend_master_hpratio < enemy_master_hpratio then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "AtkUp",
						tags = {
							"ATKUP",
							"STATUS",
							"XLDBLTe_Unique",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)
				end

				local units = global.FriendUnits(_env)

				if #units > this.Num then
					for _, friend in global.__iter__(global.FriendUnits(_env)) do
						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft3 = global.Diligent(_env)

						global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1)
					end

					global.DiligentRound(_env)
				end

				local units_sis = global.FriendDiedUnits(_env, global.MARKED(_env, "AMLBLTe"))

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				if units_sis[1] then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "HurtRateUp",
						tags = {
							"HURTRATEUP",
							"STATUS",
							"XLDBLTe_Unique",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					local damage = global.EvalRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2])

					global.ApplyRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, 0, 0, 0, nil, damage)

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) - global.ONESELF(_env, _env.TARGET))) do
						global.ApplyRealDamage(_env, _env.ACTOR, unit, 1, 1, 0, 0, 0, nil, damage * this.SplashDamageFactor)
					end
				else
					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				end
			end)
			exec["@time"]({
				2950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XLDBLTe_Unique"), 99)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_XLDBLTe_Passive = {
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
					local cards = global.Slice(_env, global.SortBy(_env, global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED")), "<", global.GetCardCost), 1, 1)

					for _, card in global.__iter__(cards) do
						local buff = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"CARDBUFF",
								"INBORN",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.RefreshCardPool(_env, "INBORN")
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

				if not global.MASTER(_env, _env.ACTOR) then
					local buff_trap = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)
					local trap = global.BuffTrap(_env, {
						timing = 2,
						duration = 1,
						tags = {}
					}, {
						buff_trap
					})

					for _, cell in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, global.GetCell(_env, _env.ACTOR)) - global.CELL_HAS_UNIT(_env, _env.ACTOR))) do
						if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao")) == 0 then
							global.ApplyTrap(_env, cell, {
								display = "cheng_yumao",
								duration = 99,
								triggerLife = 99,
								tags = {
									"XLDBLTe_Yumao"
								}
							}, {
								trap
							})
						else
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao"))
							global.ApplyTrap(_env, cell, {
								display = "fencheng_yumao",
								duration = 99,
								triggerLife = 99,
								tags = {
									"BOTH_Yumao"
								}
							}, {
								trap
							})
						end
					end

					local buff = global.PassiveFunEffectBuff(_env, "Skill_Cross_Buff_XLDBLTe", {
						AtkFactor = this.AtkFactor,
						AbFactor = this.AbFactor,
						actor = _env.ACTOR
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_XLDBLTe_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})

					local buffeft1 = global.SpecialNumericEffect(_env, "+XLDBLTe_Exist", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"XLDBLTe_Exist",
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
	_M.__all__.Skill_Cross_Buff_XLDBLTe = {
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

				if this.actor then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, this.actor) - global.ONESELF(_env, this.actor))) do
						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Cross_Buff_XLDBLTe")) == 0 then
							local buff1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, global.UnitPropGetter(_env, "atk")(_env, this.actor) * this.AtkFactor / global.UnitPropGetter(_env, "atk")(_env, unit))
							local buff2 = global.NumericEffect(_env, "+absorption", {
								"+Normal",
								"+Normal"
							}, this.AbFactor)

							global.ApplyBuff(_env, unit, {
								duration = 99,
								group = "Cross_Buff_XLDBLTe",
								timing = 0,
								limit = 1,
								tags = {
									"STATUS",
									"BUFF",
									"ATKUP",
									"ABSORPTIONUP",
									"Cross_Buff_XLDBLTe",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff1,
								buff2
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

			_env.oldCell = externs.oldCell

			assert(_env.oldCell ~= nil, "External variable `oldCell` is not provided.")

			_env.newCell = externs.newCell

			assert(_env.newCell ~= nil, "External variable `newCell` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, -global.NEIGHBORS_OF(_env, this.actor))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Cross_Buff_XLDBLTe"), 99)
					end

					if _env.unit == this.actor then
						local buff_trap = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)
						local trap = global.BuffTrap(_env, {
							timing = 2,
							duration = 1,
							tags = {}
						}, {
							buff_trap
						})

						for _, cell in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, _env.oldCell))) do
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "XLDBLTe_Yumao"))
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "BOTH_Yumao"))

							for _, cells_out in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, cell) - global.ONESELF_CELL(_env, cell))) do
								if global.GetCellUnit(_env, cells_out) and global.MARKED(_env, "AMLBLTe")(_env, global.GetCellUnit(_env, cells_out)) then
									global.ApplyTrap(_env, cell, {
										display = "fen_yumao",
										duration = 99,
										triggerLife = 99,
										tags = {
											"AMLBLTe_Yumao"
										}
									}, {
										trap
									})
								end
							end
						end

						for _, cell in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, _env.newCell) - global.CELL_HAS_UNIT(_env, this.actor))) do
							if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao")) == 0 then
								global.DelayCall(_env, 80, global.ApplyTrap, cell, {
									display = "cheng_yumao",
									duration = 99,
									triggerLife = 99,
									tags = {
										"XLDBLTe_Yumao"
									}
								}, {
									trap
								})
							else
								global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao"))
								global.DelayCall(_env, 80, global.ApplyTrap, cell, {
									display = "fencheng_yumao",
									duration = 99,
									triggerLife = 99,
									tags = {
										"BOTH_Yumao"
									}
								}, {
									trap
								})
							end
						end
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.unit == this.actor then
					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Cross_Buff_XLDBLTe"), 99)
					end

					for _, cell in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, global.GetCell(_env, _env.unit)) - global.CELL_HAS_UNIT(_env, _env.unit))) do
						global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "XLDBLTe_Yumao"))
						global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "BOTH_Yumao"))

						for _, cells_out in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, cell) - global.ONESELF_CELL(_env, cell))) do
							if global.GetCellUnit(_env, cells_out) and global.MARKED(_env, "AMLBLTe")(_env, global.GetCellUnit(_env, cells_out)) then
								local buff_trap = global.NumericEffect(_env, "+defrate", {
									"+Normal",
									"+Normal"
								}, 0)
								local trap = global.BuffTrap(_env, {
									timing = 2,
									duration = 1,
									tags = {}
								}, {
									buff_trap
								})

								global.ApplyTrap(_env, cell, {
									display = "fen_yumao",
									duration = 99,
									triggerLife = 99,
									tags = {
										"AMLBLTe_Yumao"
									}
								}, {
									trap
								})
							end
						end
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_XLDBLTe_Passive"), 99)
					global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "XLDBLTe_Exist"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XLDBLTe_Proud_EX = {
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

			_env.target = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				900
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
	_M.__all__.Skill_XLDBLTe_Unique_EX = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.2,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.TARGET)
				global.AssignRoles(_env, _env.TARGET, "target")
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				2067
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local enemy_master_hpratio = 1
				local friend_master_hpratio = 1

				if global.EnemyMaster(_env) and global.FriendMaster(_env) then
					enemy_master_hpratio = global.UnitPropGetter(_env, "hpRatio")(_env, global.EnemyMaster(_env))
					friend_master_hpratio = global.UnitPropGetter(_env, "hpRatio")(_env, global.FriendMaster(_env))
				end

				if friend_master_hpratio < enemy_master_hpratio then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR) + global.ONESELF(_env, _env.ACTOR))) do
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * this.AtkFactor / global.UnitPropGetter(_env, "atk")(_env, unit))

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "AtkUp",
							tags = {
								"ATKUP",
								"STATUS",
								"XLDBLTe_Unique",
								"UNSTEALABLE"
							}
						}, {
							buff1
						}, 1, 0)
					end
				end

				local units = global.FriendUnits(_env)

				if #units > this.Num then
					for _, friend in global.__iter__(global.FriendUnits(_env)) do
						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft3 = global.Diligent(_env)

						global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1)
					end

					global.DiligentRound(_env)
				end

				local units_sis = global.FriendDiedUnits(_env, global.MARKED(_env, "AMLBLTe"))

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				if units_sis[1] then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "HurtRateUp",
						tags = {
							"HURTRATEUP",
							"STATUS",
							"XLDBLTe_Unique",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1, 0)

					local damage = global.EvalRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2])

					global.ApplyRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, 0, 0, 0, nil, damage)

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) - global.ONESELF(_env, _env.TARGET))) do
						global.ApplyRealDamage(_env, _env.ACTOR, unit, 1, 1, 0, 0, 0, nil, damage * this.SplashDamageFactor)
					end
				else
					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				end
			end)
			exec["@time"]({
				2950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "XLDBLTe_Unique"), 99)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_XLDBLTe_Passive_EX = {
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
					local cards = global.Slice(_env, global.SortBy(_env, global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED")), "<", global.GetCardCost), 1, 1)

					for _, card in global.__iter__(cards) do
						local buff = global.NumericEffect(_env, "+def", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"CARDBUFF",
								"INBORN",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.RefreshCardPool(_env, "INBORN")
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

				if not global.MASTER(_env, _env.ACTOR) then
					local buff_trap = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)
					local trap = global.BuffTrap(_env, {
						timing = 2,
						duration = 1,
						tags = {}
					}, {
						buff_trap
					})

					for _, cell in global.__iter__(global.FriendCells(_env, global.NEIGHBORS_CELL_OF(_env, global.GetCell(_env, _env.ACTOR)) - global.CELL_HAS_UNIT(_env, _env.ACTOR))) do
						if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao")) == 0 then
							global.ApplyTrap(_env, cell, {
								display = "cheng_yumao",
								duration = 99,
								triggerLife = 99,
								tags = {
									"XLDBLTe_Yumao"
								}
							}, {
								trap
							})
						else
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "AMLBLTe_Yumao"))
							global.ApplyTrap(_env, cell, {
								display = "fencheng_yumao",
								duration = 99,
								triggerLife = 99,
								tags = {
									"BOTH_Yumao"
								}
							}, {
								trap
							})
						end
					end

					local buff = global.PassiveFunEffectBuff(_env, "Skill_Cross_Buff_XLDBLTe", {
						AtkFactor = this.AtkFactor,
						AbFactor = this.AbFactor,
						actor = _env.ACTOR
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_XLDBLTe_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})

					local buffeft1 = global.SpecialNumericEffect(_env, "+XLDBLTe_Exist", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"XLDBLTe_Exist",
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

	return _M
end
