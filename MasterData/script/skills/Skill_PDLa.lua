-- chunkname: @/tmp/or_skill/lua_compile/Skill_PDLa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_PDLa_Normal = {
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
					-1.8,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				300
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
	_M.__all__.Skill_PDLa_Proud = {
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
					-1.8,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buff = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.boxAtkFactor)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
					if global.INSTATUS(_env, "SummonedPDLa")(_env, unit) then
						global.ApplyBuff(_env, unit, {
							timing = 1,
							display = "AtkUp",
							group = "PDLa_Proud_For_Box",
							duration = 3,
							limit = 1,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"ATKUP",
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
	_M.__all__.Skill_PDLa_Unique = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2334
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedPDLa"))) do
					global.Kick(_env, summonunit)
				end

				local SummonedPDLa1 = global.Summon(_env, _env.ACTOR, "SummonedPDLa", this.summonFactor, nil, {
					2,
					1,
					3,
					5,
					4,
					6,
					7,
					8,
					9
				})

				if SummonedPDLa1 then
					global.AddStatus(_env, SummonedPDLa1, "SummonedPDLa")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_PDLa_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedPDLa1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_PDLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)
						local buff2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff(_env, SummonedPDLa1, {
							timing = 0,
							duration = 99,
							display = {
								"AtkUp",
								"DefUp"
							},
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_PDLa_R4",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1,
							buff2
						})
					end
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_PDLa_Passive_Death = {
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
				local count = 0
				local summonFactorHp = 0.6
				local summonFactorAtk = 1
				local summonFactorDef = 1
				local summonFactor = {
					summonFactorHp,
					summonFactorAtk,
					summonFactorDef
				}

				for _, unit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedPDLa"))) do
					count = count + 1
				end

				if count == 0 then
					local SummonedPDLa = global.Summon(_env, _env.ACTOR, "SummonedPDLa", summonFactor, {
						1,
						0,
						0
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedPDLa then
						global.AddStatus(_env, SummonedPDLa, "SummonedPDLa")

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
							local buff1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, 0.2)
							local buff2 = global.NumericEffect(_env, "+defrate", {
								"+Normal",
								"+Normal"
							}, 0.2)

							global.ApplyBuff(_env, SummonedPDLa, {
								timing = 0,
								duration = 99,
								display = {
									"AtkUp",
									"DefUp"
								},
								tags = {
									"STATUS",
									"NUMERIC",
									"Skill_PDLa_R4",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff1,
								buff2
							})
						end
					end
				else
					local buff = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 1)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
						if global.INSTATUS(_env, "SummonedPDLa")(_env, unit) then
							global.ApplyBuff(_env, unit, {
								timing = 0,
								display = "AtkUp",
								group = "PDLa_Passive_For_Box",
								duration = 99,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"BUFF",
									"ATKUP",
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
	_M.__all__.Skill_PDLa_Box_Normal = {
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
					-2,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				467
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_PDLa_Box_Passive_Death = {
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

			_env.summonFactor = {
				0.5,
				0.95,
				0
			}
			_env.i = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "die"))

				_env.i = _env.TARGET == global.EnemyMaster(_env) and global.Random(_env, 1, 600) or global.Random(_env, 1, 800)
			end)
			exec["@time"]({
				300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.i <= 200 then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "PDLa"))) do
						local buffeft1 = global.Immune(_env)
						local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ALL(_env, "DEBUFF"))

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				elseif _env.i < 401 then
					for _, unit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env), ">", global.UnitPropGetter(_env, "rp")), 1, 1)) do
						global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, unit, 1000)
					end
				elseif _env.i < 601 then
					local cards = global.RandomN(_env, 1, global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED")))

					for _, card in global.__iter__(cards) do
						local cost = global.GetCardCost(_env, card)
						local cardvaluechange = global.CardCostEnchant(_env, "-", global.floor(_env, cost / 2), 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"Skill_PDLa_Box_Passive_Death",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
					end
				elseif not global.MARKED(_env, "SummonedNian")(_env, _env.TARGET) then
					local Hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)

					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.TARGET)
					})
					global.ApplyHPReduce(_env, _env.TARGET, Hp * 0.5)
				end
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "PDLa"))) do
					global.ApplyRPRecovery(_env, unit, 500)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PDLa_Proud_EX = {
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
					-1.8,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buff = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.boxAtkFactor)
				local buff2 = global.NumericEffect(_env, "+critrate", {
					"+Normal",
					"+Normal"
				}, this.boxCritFactor)

				for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
					if global.INSTATUS(_env, "SummonedPDLa")(_env, unit) then
						global.ApplyBuff(_env, unit, {
							timing = 1,
							group = "PDLa_Proud_For_Box",
							duration = 3,
							limit = 1,
							display = {
								"AtkUp",
								"CritRateUp"
							},
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff,
							buff2
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PDLa_Unique_EX = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2334
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedPDLa"))) do
					global.Kick(_env, summonunit)
				end

				local SummonedPDLa = global.Summon(_env, _env.ACTOR, "SummonedPDLa", this.summonFactor, {
					1,
					0,
					0
				}, {
					2,
					1,
					3,
					5,
					4,
					6,
					7,
					8,
					9
				})

				if SummonedPDLa then
					global.AddStatus(_env, SummonedPDLa, "SummonedPDLa")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_PDLa_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedPDLa, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_PDLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)
						local buff2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff(_env, SummonedPDLa, {
							timing = 0,
							duration = 99,
							display = {
								"AtkUp",
								"DefUp"
							},
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_PDLa_R4",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1,
							buff2
						})
					end

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R5")) > 0 then
						local buffeft2 = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, 0.3)

						global.ApplyBuff(_env, SummonedPDLa, {
							duration = 99,
							group = "PDLa_Rank5_Aoederate",
							timing = 0,
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
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
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
				local buffeft = global.SpecialNumericEffect(_env, "+rank4", {
					"?Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"PDLa_R4",
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
	_M.__all__.Skill_PDLa_Passive_Death_EX = {
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
				local count = 0
				local summonFactorHp = 0.6
				local summonFactorAtk = 1
				local summonFactorDef = 1
				local summonFactor = {
					summonFactorHp,
					summonFactorAtk,
					summonFactorDef
				}

				for _, unit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedPDLa"))) do
					count = count + 1
				end

				if count == 0 then
					local SummonedPDLa = global.Summon(_env, _env.ACTOR, "SummonedPDLa", summonFactor, {
						1,
						0,
						0
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedPDLa then
						global.AddStatus(_env, SummonedPDLa, "SummonedPDLa")

						local buffeft2 = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, 0.3)

						global.ApplyBuff(_env, SummonedPDLa, {
							duration = 99,
							group = "PDLa_Rank5_Aoederate",
							timing = 0,
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

						if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
							local buff1 = global.NumericEffect(_env, "+atkrate", {
								"+Normal",
								"+Normal"
							}, 0.2)
							local buff2 = global.NumericEffect(_env, "+defrate", {
								"+Normal",
								"+Normal"
							}, 0.2)

							global.ApplyBuff(_env, SummonedPDLa, {
								timing = 0,
								duration = 99,
								display = {
									"AtkUp",
									"DefUp"
								},
								tags = {
									"STATUS",
									"NUMERIC",
									"Skill_PDLa_R4",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff1,
								buff2
							})
						end
					end
				else
					local buff = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 1)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
						if global.INSTATUS(_env, "SummonedPDLa")(_env, unit) then
							global.ApplyBuff(_env, unit, {
								timing = 0,
								display = "AtkUp",
								group = "PDLa_Passive_For_Box",
								duration = 99,
								limit = 1,
								tags = {
									"STATUS",
									"NUMERIC",
									"BUFF",
									"ATKUP",
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
	_M.__all__.Skill_PDLa_Unique_Awaken = {
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

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2334
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				for _, summonunit in global.__iter__(global.FriendUnits(_env, global.INSTATUS(_env, "SummonedPDLa"))) do
					global.Kick(_env, summonunit)
				end

				local SummonedPDLa = global.Summon(_env, _env.ACTOR, "SummonedPDLa", this.summonFactor, {
					1,
					0,
					0
				}, {
					2,
					1,
					3,
					5,
					4,
					6,
					7,
					8,
					9
				})

				if SummonedPDLa then
					global.AddStatus(_env, SummonedPDLa, "SummonedPDLa")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_PDLa_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedPDLa, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_PDLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)
						local buff2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff(_env, SummonedPDLa, {
							timing = 0,
							duration = 99,
							display = {
								"AtkUp",
								"DefUp"
							},
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_PDLa_R4",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1,
							buff2
						})
					end

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R5")) > 0 then
						local buffeft2 = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, 0.3)

						global.ApplyBuff(_env, SummonedPDLa, {
							duration = 99,
							group = "PDLa_Rank5_Aoederate",
							timing = 0,
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
				end

				local SummonedPDLa2 = global.Summon(_env, _env.ACTOR, "SummonedPDLa", this.summonFactor, {
					1,
					0,
					0
				}, {
					2,
					1,
					3,
					5,
					4,
					6,
					7,
					8,
					9
				})

				if SummonedPDLa2 then
					global.AddStatus(_env, SummonedPDLa2, "SummonedPDLa")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_PDLa_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedPDLa2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_PDLa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R4")) > 0 then
						local buff1 = global.NumericEffect(_env, "+atkrate", {
							"+Normal",
							"+Normal"
						}, 0.2)
						local buff2 = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0.2)

						global.ApplyBuff(_env, SummonedPDLa2, {
							timing = 0,
							duration = 99,
							display = {
								"AtkUp",
								"DefUp"
							},
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_PDLa_R4",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1,
							buff2
						})
					end

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PDLa_R5")) > 0 then
						local buffeft2 = global.NumericEffect(_env, "+aoederate", {
							"+Normal",
							"+Normal"
						}, 0.3)

						global.ApplyBuff(_env, SummonedPDLa2, {
							duration = 99,
							group = "PDLa_Rank5_Aoederate",
							timing = 0,
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
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
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
				local buffeft = global.SpecialNumericEffect(_env, "+rank4", {
					"?Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"PDLa_R4",
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
