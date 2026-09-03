-- chunkname: @/tmp/or_skill/lua_compile/Skill_GCZi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_GCZi_Normal = {
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
	_M.__all__.Skill_GCZi_Proud = {
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
					-1.4,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				867
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
	_M.__all__.Skill_GCZi_Unique = {
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
				local healercount = global.SpecialPropGetter(_env, "healercount")(_env, global.FriendMaster(_env))

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if healercount >= 4 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.8,
						0
					}, 100, "skill3"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.8,
						0
					}, 100, "skill3_1"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2467
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local warriorcount = 0
				local healercount = 0

				if global.FriendMaster(_env) then
					warriorcount = global.SpecialPropGetter(_env, "warriorcount")(_env, global.FriendMaster(_env))
					healercount = global.SpecialPropGetter(_env, "healercount")(_env, global.FriendMaster(_env))
				end

				if warriorcount >= 4 and healercount >= 4 and warriorcount and healercount then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)

						local buffeft = global.NumericEffect(_env, "+singlerate", {
							"+Normal",
							"+Normal"
						}, this.SingleRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "SingleHurtRateUp",
							group = "GCZi_Unique",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end

					damage.val = damage.val * (1 + this.DamageFactor)
				elseif warriorcount >= 4 and healercount < 4 and warriorcount and healercount then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)

						local buffeft = global.NumericEffect(_env, "+singlerate", {
							"+Normal",
							"+Normal"
						}, this.SingleRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "SingleHurtRateUp",
							group = "GCZi_Unique",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end
				elseif healercount >= 4 and warriorcount < 4 and warriorcount and healercount then
					damage.val = damage.val * (1 + this.DamageFactor)
				else
					local units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

					for _, unit in global.__iter__(units) do
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					end
				end

				if healercount >= 4 then
					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						134,
						234,
						300,
						400
					}, global.SplitValue(_env, damage, {
						0.1,
						0.2,
						0.2,
						0.2,
						0.3
					}))
				else
					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						134,
						234,
						300
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25
					}))
				end

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

				global.ApplyTrap(_env, global.GetCell(_env, _env.TARGET), {
					display = "Jianzhendazhao",
					duration = 1,
					triggerLife = 99,
					tags = {
						"GCZi_Unique_jianzhen"
					}
				}, {
					trap
				})
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuffTrap(_env, global.GetCell(_env, _env.TARGET), global.BUFF_MARKED(_env, "GCZi_Unique_jianzhen"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_GCZi_Passive = {
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

				if global.FriendMaster(_env) then
					if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_GCZi_Passive")) == 0 and global.MARKED(_env, "GCZi")(_env, _env.ACTOR) and not global.MASTER(_env, _env.ACTOR) then
						if global.MARKED(_env, "ENEMY")(_env, _env.ACTOR) then
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
								global.ApplyTrap(_env, cell, {
									display = "Jianzhen",
									duration = 99,
									triggerLife = 99,
									tags = {
										"GCZi_jianzhen_Activity"
									}
								}, {
									trap
								})
							end

							local buffeft = global.NumericEffect(_env, "+defrate", {
								"+Normal",
								"+Normal"
							}, 0)

							global.ApplyBuff(_env, global.FriendMaster(_env), {
								timing = 4,
								duration = 30,
								tags = {
									"STATUS",
									"Skill_GCZi_Passive_Activity_time"
								}
							}, {
								buffeft
							})

							local buff = global.PassiveFunEffectBuff(_env, "GCZi_Passive_jianzhen_Activity")

							global.ApplyBuff(_env, global.FriendMaster(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"STATUS",
									"Skill_GCZi_Passive_Activity",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						else
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
								global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GCZi_jianzhen"))
								global.ApplyTrap(_env, cell, {
									display = "Jianzhen",
									duration = 99,
									triggerLife = 99,
									tags = {
										"GCZi_jianzhen"
									}
								}, {
									trap
								})
							end

							local buffeft = global.NumericEffect(_env, "+defrate", {
								"+Normal",
								"+Normal"
							}, 0)

							global.ApplyBuff(_env, global.FriendMaster(_env), {
								timing = 4,
								duration = 30,
								tags = {
									"STATUS",
									"Skill_GCZi_Passive_time"
								}
							}, {
								buffeft
							})

							if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_GCZi_Passive_Activity")) == 0 then
								local buff = global.PassiveFunEffectBuff(_env, "GCZi_Passive_jianzhen", {
									CostFactor = this.CostFactor,
									holder = _env.ACTOR
								})

								global.ApplyBuff(_env, global.FriendMaster(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"STATUS",
										"Skill_GCZi_Passive",
										"UNDISPELLABLE",
										"UNSTEALABLE"
									}
								}, {
									buff
								})
							end
						end
					end
				elseif global.MARKED(_env, "GCZi")(_env, _env.ACTOR) then
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
						global.ApplyTrap(_env, cell, {
							display = "Jianzhen",
							duration = 99,
							triggerLife = 99,
							tags = {
								"GCZi_jianzhen"
							}
						}, {
							trap
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					local warriorcount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR"))
					local healercount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HEALER"))

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
						warriorcount = warriorcount + 1
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "HEALER"))) do
						healercount = warriorcount + 1
					end

					local buffeft1 = global.SpecialNumericEffect(_env, "+warriorcount", {
						"+Normal",
						"+Normal"
					}, warriorcount)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"GCZi_count"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+healercount", {
						"+Normal",
						"+Normal"
					}, healercount)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"GCZi_count"
						}
					}, {
						buffeft2
					})
				end

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, "GCZi")(_env, _env.ACTOR) then
					if global.MARKED(_env, "ENEMY")(_env, _env.ACTOR) then
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
							global.ApplyTrap(_env, cell, {
								display = "Jianzhen",
								duration = 99,
								triggerLife = 99,
								tags = {
									"GCZi_jianzhen_Activity"
								}
							}, {
								trap
							})
						end

						local buffeft = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 4,
							duration = 30,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_Activity_time"
							}
						}, {
							buffeft
						})

						local buff = global.PassiveFunEffectBuff(_env, "GCZi_Passive_jianzhen_Activity")

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_Activity",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					else
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
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GCZi_jianzhen"))
							global.ApplyTrap(_env, cell, {
								display = "Jianzhen",
								duration = 99,
								triggerLife = 99,
								tags = {
									"GCZi_jianzhen"
								}
							}, {
								trap
							})
						end

						local buffeft = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 4,
							duration = 30,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_time"
							}
						}, {
							buffeft
						})

						local buff = global.PassiveFunEffectBuff(_env, "GCZi_Passive_jianzhen", {
							CostFactor = this.CostFactor,
							holder = _env.ACTOR
						})

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_Activity",
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
	_M.__all__.GCZi_Passive_jianzhen = {
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
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "LDYu_Back_Count"))

				if global.SelectTrapCount(_env, global.GetCell(_env, _env.unit), global.BUFF_MARKED(_env, "GCZi_jianzhen")) > 0 and not global.MARKED(_env, "GCZi")(_env, _env.unit) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for i = 1, 4 do
						if global.FriendMaster(_env) and count < 2 and global.MARKED(_env, "LDYu")(_env, _env.unit) and global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "LDYu_Passive_Time")) > 0 then
							break
						end

						if global.FriendMaster(_env) and not global.INSTATUS(_env, "Skill_BEr_Passive_Death_SecondTime")(_env, global.FriendMaster(_env)) and global.MARKED(_env, "BEr")(_env, _env.unit) then
							break
						end

						if global.FriendMaster(_env) and global.SpecialPropGetter(_env, "byou" .. global.GetUnitCid(_env, _env.unit))(_env, global.FriendField(_env)) == 0 and global.SelectHeroPassiveCount(_env, _env.unit, "EquipSkill_Shoes_15113_1") > 0 then
							break
						end

						local card_window = global.CardAtWindowIndex(_env, global.GetOwner(_env, _env.ACTOR), i)

						if card_window == nil then
							local card_battle = global.BackToCard_ResultIDCheck(_env, this.holder, _env.unit, "window", i)

							if card_battle then
								global.Kick(_env, _env.unit)

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card_battle, {
									timing = 0,
									duration = 99,
									tags = {
										"GCZi_Passive_jianzhen"
									}
								}, {
									buff
								})
							end

							for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
								if global.SelectCardBuffCount(_env, card, "GCZi_Passive_jianzhen") > 0 then
									local cardvaluechange = global.CardCostEnchant(_env, "+", 3, 1)

									global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
										tags = {
											"CARDBUFF",
											"UNDISPELLABLE",
											"Skill_GCZi_Passive"
										}
									}, {
										cardvaluechange
									})
									global.DispelTiggerOnHeroCard(_env, card, {
										"GCZi_Passive_jianzhen"
									})
								end
							end

							break
						end

						if i == 4 and card_window ~= nil then
							local cardlocation = global.Random(_env, 1, 4)
							local card = global.BackToCard_ResultIDCheck(_env, this.holder, _env.unit, "window", cardlocation)

							if card then
								global.Kick(_env, _env.unit)

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
									timing = 0,
									duration = 99,
									tags = {
										"GCZi_Passive_jianzhen"
									}
								}, {
									buff
								})
							end

							for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
								if global.SelectCardBuffCount(_env, card, "GCZi_Passive_jianzhen") > 0 then
									local cardvaluechange = global.CardCostEnchant(_env, "+", 3, 1)

									global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
										tags = {
											"CARDBUFF",
											"UNDISPELLABLE",
											"Skill_GCZi_Passive"
										}
									}, {
										cardvaluechange
									})
									global.DispelTiggerOnHeroCard(_env, card, {
										"GCZi_Passive_jianzhen"
									})
								end
							end
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "Skill_GCZi_Passive_time") then
					for _, cell in global.__iter__(global.FriendCells(_env)) do
						global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GCZi_jianzhen"))
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "GCZi"))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_GCZi_Passive_time"), 99)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_GCZi_Proud_EX = {
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
					-1.4,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				for _, unit in global.__iter__(units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)

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

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_GCZi_Unique_EX = {
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
				local healercount = global.SpecialPropGetter(_env, "healercount")(_env, global.FriendMaster(_env))

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if healercount >= 4 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.8,
						0
					}, 100, "skill3"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-1.8,
						0
					}, 100, "skill3_1"))
				end
			end)
			exec["@time"]({
				2467
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local warriorcount = 0
				local healercount = 0

				if global.FriendMaster(_env) then
					warriorcount = global.SpecialPropGetter(_env, "warriorcount")(_env, global.FriendMaster(_env))
					healercount = global.SpecialPropGetter(_env, "healercount")(_env, global.FriendMaster(_env))
				end

				if warriorcount >= 4 and healercount >= 4 and warriorcount and healercount then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)

						local buffeft = global.NumericEffect(_env, "+singlerate", {
							"+Normal",
							"+Normal"
						}, this.SingleRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "SingleHurtRateUp",
							group = "GCZi_Unique",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end

					damage.val = damage.val * (1 + this.DamageFactor)
				elseif warriorcount >= 4 and healercount < 4 and warriorcount and healercount then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)

						local buffeft = global.NumericEffect(_env, "+singlerate", {
							"+Normal",
							"+Normal"
						}, this.SingleRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							display = "SingleHurtRateUp",
							group = "GCZi_Unique",
							duration = 99,
							limit = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end
				elseif healercount >= 4 and warriorcount < 4 and warriorcount and healercount then
					damage.val = damage.val * (1 + this.DamageFactor)
				else
					local units = global.Slice(_env, global.SortBy(_env, global.FriendUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

					for _, unit in global.__iter__(units) do
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					end
				end

				if healercount >= 4 then
					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						134,
						234,
						300,
						400
					}, global.SplitValue(_env, damage, {
						0.1,
						0.2,
						0.2,
						0.2,
						0.3
					}))
				else
					global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
						0,
						134,
						234,
						300
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25
					}))
				end

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

				global.ApplyTrap(_env, global.GetCell(_env, _env.TARGET), {
					display = "Jianzhendazhao",
					duration = 1,
					triggerLife = 99,
					tags = {
						"GCZi_Unique_jianzhen"
					}
				}, {
					trap
				})
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuffTrap(_env, global.GetCell(_env, _env.TARGET), global.BUFF_MARKED(_env, "GCZi_Unique_jianzhen"))
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_GCZi_Passive_EX = {
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

				if global.FriendMaster(_env) then
					if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_GCZi_Passive_time")) > 0 and global.MARKED(_env, "GCZi")(_env, _env.ACTOR) then
						local buffeft = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 4,
							duration = 30,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_time"
							}
						}, {
							buffeft
						})
					end

					if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_GCZi_Passive")) == 0 and global.MARKED(_env, "GCZi")(_env, _env.ACTOR) then
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
							global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GCZi_jianzhen"))
							global.ApplyTrap(_env, cell, {
								display = "Jianzhen",
								duration = 99,
								triggerLife = 99,
								tags = {
									"GCZi_jianzhen"
								}
							}, {
								trap
							})
						end

						local buffeft = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendMaster(_env), {
							timing = 4,
							duration = 30,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_time"
							}
						}, {
							buffeft
						})
						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 4,
							duration = 30,
							tags = {
								"STATUS",
								"Skill_GCZi_Passive_time"
							}
						}, {
							buffeft
						})

						if global.SelectBuffCount(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "Skill_GCZi_Passive_Activity")) == 0 then
							local buff = global.PassiveFunEffectBuff(_env, "GCZi_Passive_jianzhen", {
								CostFactor = this.CostFactor,
								holder = _env.ACTOR
							})

							global.ApplyBuff(_env, global.FriendMaster(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"STATUS",
									"Skill_GCZi_Passive",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end
				elseif global.MARKED(_env, "GCZi")(_env, _env.ACTOR) then
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
						global.ApplyTrap(_env, cell, {
							display = "Jianzhen",
							duration = 99,
							triggerLife = 99,
							tags = {
								"GCZi_jianzhen"
							}
						}, {
							trap
						})
					end

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 4,
						duration = 30,
						tags = {
							"STATUS",
							"Skill_GCZi_Passive_time"
						}
					}, {
						global.buffeft
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
					local warriorcount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR"))
					local healercount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HEALER"))

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR"))) do
						warriorcount = warriorcount + 1
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "HEALER"))) do
						healercount = warriorcount + 1
					end

					local buffeft1 = global.SpecialNumericEffect(_env, "+warriorcount", {
						"+Normal",
						"+Normal"
					}, warriorcount)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"GCZi_count"
						}
					}, {
						buffeft1
					})

					local buffeft2 = global.SpecialNumericEffect(_env, "+healercount", {
						"+Normal",
						"+Normal"
					}, healercount)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"GCZi_count"
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if not global.MASTER(_env, _env.ACTOR) and global.BuffIsMatched(_env, _env.buff, "Skill_GCZi_Passive_time") then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))) do
						local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealRateFactor, 0)

						global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, heal)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.GCZi_Passive_jianzhen_Activity = {
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

				if global.SelectTrapCount(_env, global.GetCell(_env, _env.unit), global.BUFF_MARKED(_env, "GCZi_jianzhen_Activity")) > 0 and not global.MARKED(_env, "GCZi")(_env, _env.unit) and (global.PETS - global.SUMMONS)(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					local setLoction = global.GetCellId(_env, _env.unit)
					local units = global.ReviveByUnit(_env, _env.unit, 1, 1000, {
						global.abs(_env, setLoction)
					})

					if units then
						global.AddStatus(_env, units, "GCZi_Passive_Activity")
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "Skill_GCZi_Passive_Activity_time") then
					for _, cell in global.__iter__(global.FriendCells(_env)) do
						global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GCZi_jianzhen_Activity"))
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "GCZi"))) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_GCZi_Passive_Activity_time"), 99)
					end
				end
			end)

			return _env
		end
	}

	return _M
end
