-- chunkname: @/tmp/or_skill/lua_compile/Skill_WSLi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_WSLi_Normal = {
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
					-1,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				433
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
	_M.__all__.Skill_WSLi_Proud = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.8,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					167,
					333
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_WSLi_Unique = {
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

			_env.target_num = 1

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

				local unit_behind

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true))) do
					unit_behind = unit
					_env.target_num = 2
				end

				if _env.target_num == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-0.6,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, unit_behind, "target")
					global.HarmTargetView(_env, {
						unit_behind
					})
				elseif _env.target_num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-0.5,
						0
					}, 100, "skill3_1"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				2433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.target_num == 1 then
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
					global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)
					global.Serious_Injury(_env, _env.ACTOR, _env.TARGET, this.Injury_Ratio, 20, 4)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

					local buffeft = global.MaxHpEffect(_env, -damage.val)

					global.ApplyBuff(_env, _env.TARGET, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"DAMAGERESULT",
							"Skill_WSLi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				elseif _env.target_num == 2 then
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET) + global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true))) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)
						global.Serious_Injury(_env, _env.ACTOR, unit, this.Injury_Ratio, 20, 4)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local buffeft = global.MaxHpEffect(_env, -damage.val)

						if unit == _env.TARGET then
							global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								display = "MaxHpDown",
								tags = {
									"DEBUFF",
									"MAXHPDOWN",
									"DAMAGERESULT",
									"Skill_WSLi_Unique",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft
							})
						else
							global.DelayCall(_env, 767, global.ApplyHPDamage_ResultCheck, _env.ACTOR, unit, damage)
							global.DelayCall(_env, 770, global.ApplyBuff, unit, {
								timing = 0,
								duration = 99,
								display = "MaxHpDown",
								tags = {
									"DEBUFF",
									"MAXHPDOWN",
									"DAMAGERESULT",
									"Skill_WSLi_Unique",
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
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.target_num == 1 then
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				3550
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_WSLi_Passive = {
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
				local units = global.FriendUnits(_env, global.MARKED(_env, "WSLi"))
				local num = global.SpecialPropGetter(_env, "WSLi_Passive_Lover")(_env, global.FriendField(_env))

				if not global.MASTER(_env, _env.unit) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and num < this.maxlovernum and units[1] then
					local SummonedWSLi = global.Summon(_env, _env.ACTOR, "SummonedWSLi", this.summonFactor, nil, {
						2,
						1,
						3,
						5,
						4,
						6,
						8,
						7,
						9
					})

					if SummonedWSLi then
						local buff = global.SpecialNumericEffect(_env, "+WSLi_Passive_Lover", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"LOVER"
							}
						}, {
							buff
						})
						global.ForbidenRevive(_env, _env.unit, true)

						local buff_check = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"WSL_" .. global.GetUnitCid(_env, _env.unit)
							}
						}, {
							buff_check
						})
						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"LOVER_UNLOCK"
							}
						}, {
							buff_check
						})
						global.AddStatus(_env, SummonedWSLi, "SummonedWSLi")
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LOVER_Passive = {
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

				for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR))) do
					global.addHeroCardSeatRules(_env, global.GetOwner(_env, _env.ACTOR), card, {
						"LOVER"
					}, {
						"die"
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

				global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "LOVER"), 1)

				for _, unit in global.__iter__(global.EnemyDiedUnits(_env)) do
					if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "WSL_" .. global.GetUnitCid(_env, unit))) > 0 then
						global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "WSL_" .. global.GetUnitCid(_env, unit)), 1)
						global.ForbidenRevive(_env, unit, false)

						local HpFactor = 0
						local RpFactor = 0
						local hero = 0

						if global.SelectHeroPassiveCount(_env, unit, "Hero_PBattle_TPGZhu") > 0 or global.SelectHeroPassiveCount(_env, unit, "Hero_PBattle_TPGZhu_EX") > 0 or global.SelectHeroPassiveCount(_env, unit, "Hero_PBattle_TPGZhu_Awaken") > 0 then
							hero = 1
						end

						if global.SelectHeroPassiveCount(_env, unit, "Hero_PBattle_KMLa") > 0 or global.SelectHeroPassiveCount(_env, unit, "Hero_PBattle_KMLa_EX") > 0 then
							hero = 2
						end

						if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Transformed")) > 0 and hero == 1 then
							if global.IsAwaken(_env, unit) then
								HpFactor = 1
								RpFactor = 1000
							else
								HpFactor = 0.5
								RpFactor = 500
							end

							local reviveunit = global.ReviveByUnit(_env, unit, HpFactor, RpFactor, {
								7,
								8,
								9,
								4,
								6,
								5,
								1,
								3,
								2
							}, global.GetOwner(_env, global.EnemyField(_env)))

							if reviveunit then
								global.AddStatus(_env, reviveunit, "Skill_TPGZhu_Passive_Transformed")
							end

							global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_TPGZhu_Passive_Transformed"), 1)
						end

						if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Transformed")) > 0 and hero == 2 then
							HpFactor = 0.01
							RpFactor = 1000

							local reviveunit = global.ReviveByUnit(_env, unit, 0.01, 1000, {
								7,
								8,
								9,
								4,
								6,
								5,
								1,
								3,
								2
							}, global.GetOwner(_env, global.EnemyField(_env)))

							if reviveunit then
								global.AddStatus(_env, reviveunit, "Skill_KMLa_Passive_Transformed")
							end

							global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Transformed"), 1)
						end

						if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Transformed2")) > 0 and hero == 2 then
							HpFactor = 0.01
							RpFactor = 1000

							local reviveunit = global.ReviveByUnit(_env, unit, 0.01, 1000, {
								7,
								8,
								9,
								4,
								6,
								5,
								1,
								3,
								2
							}, global.GetOwner(_env, global.EnemyField(_env)))

							if reviveunit then
								global.AddStatus(_env, reviveunit, "Skill_KMLa_Passive_Transformed2")

								local maxatk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
								local buffeft1 = global.NumericEffect(_env, "-atk", {
									"+Normal",
									"+Normal"
								}, maxatk / 2)

								global.ApplyBuff(_env, reviveunit, {
									timing = 0,
									duration = 99,
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

							global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "Skill_KMLa_Passive_Transformed2"), 1)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WSLi_Proud_EX = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.8,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if not global.MASTER(_env, _env.TARGET) and global.GetSex(_env, _env.TARGET) == 1 then
					damage.val = damage.val * 2
				end

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					167,
					333
				}, global.SplitValue(_env, damage, {
					0.3,
					0.3,
					0.4
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_WSLi_Unique_EX = {
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

			_env.target_num = 1

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

				local unit_behind

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true))) do
					unit_behind = unit
					_env.target_num = 2
				end

				if _env.target_num == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-0.6,
						0
					}, 100, "skill3"))
					global.AssignRoles(_env, unit_behind, "target")
					global.HarmTargetView(_env, {
						unit_behind
					})
				elseif _env.target_num == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
						-0.5,
						0
					}, 100, "skill3_1"))
				end

				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				2433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.target_num == 1 then
					global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
					global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
					global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)
					global.Serious_Injury(_env, _env.ACTOR, _env.TARGET, this.Injury_Ratio, 20, 4)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

					if not global.MASTER(_env, _env.TARGET) and global.GetSex(_env, _env.TARGET) == 1 then
						damage.val = damage.val * 2
					end

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

					local buffeft = global.MaxHpEffect(_env, -damage.val)

					global.ApplyBuff(_env, _env.TARGET, {
						timing = 0,
						duration = 99,
						display = "MaxHpDown",
						tags = {
							"DEBUFF",
							"MAXHPDOWN",
							"DAMAGERESULT",
							"Skill_WSLi_Unique",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				elseif _env.target_num == 2 then
					for _, unit in global.__iter__(global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET) + global.NEIGHBORS_OF(_env, _env.TARGET) * global.BACK_OF(_env, _env.TARGET, true))) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)
						global.Serious_Injury(_env, _env.ACTOR, unit, this.Injury_Ratio, 20, 4)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						if not global.MASTER(_env, unit) and global.GetSex(_env, unit) == 1 then
							damage.val = damage.val * 2
						end

						local buffeft = global.MaxHpEffect(_env, -damage.val)

						if unit == _env.TARGET then
							global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								display = "MaxHpDown",
								tags = {
									"DEBUFF",
									"MAXHPDOWN",
									"DAMAGERESULT",
									"Skill_WSLi_Unique",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buffeft
							})
						else
							global.DelayCall(_env, 767, global.ApplyHPDamage_ResultCheck, _env.ACTOR, unit, damage)
							global.DelayCall(_env, 770, global.ApplyBuff, unit, {
								timing = 0,
								duration = 99,
								display = "MaxHpDown",
								tags = {
									"DEBUFF",
									"MAXHPDOWN",
									"DAMAGERESULT",
									"Skill_WSLi_Unique",
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
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.target_num == 1 then
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				3550
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_WSLi_Passive_EX = {
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
				local units = global.FriendUnits(_env, global.MARKED(_env, "WSLi"))
				local num = global.SpecialPropGetter(_env, "WSLi_Passive_Lover")(_env, global.FriendField(_env))

				if not global.MASTER(_env, _env.unit) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and num < this.maxlovernum and units[1] then
					local SummonedWSLi = global.Summon(_env, _env.ACTOR, "SummonedWSLi", this.summonFactor, nil, {
						2,
						1,
						3,
						5,
						4,
						6,
						8,
						7,
						9
					})

					if SummonedWSLi then
						local buff = global.SpecialNumericEffect(_env, "+WSLi_Passive_Lover", {
							"+Normal",
							"+Normal"
						}, 1)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"LOVER"
							}
						}, {
							buff
						})
						global.ForbidenRevive(_env, _env.unit, true)

						local buff_check = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"WSL_" .. global.GetUnitCid(_env, _env.unit)
							}
						}, {
							buff_check
						})
						global.ApplyBuff(_env, global.FriendField(_env), {
							timing = 0,
							duration = 99,
							tags = {
								"LOVER_UNLOCK"
							}
						}, {
							buff_check
						})

						local buff_immune = global.PassiveFunEffectBuff(_env, "Skill_Immune_Action_Damage", {})
						local buff2 = global.NumericEffect(_env, "+unhurtrate", {
							"+Normal",
							"+Normal"
						}, this.unhurtrate)

						global.ApplyBuff_Buff(_env, _env.ACTOR, SummonedWSLi, {
							timing = 0,
							duration = 99,
							display = "UnHurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"UNHURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff2,
							buff_immune
						}, 1, 0)
						global.AddStatus(_env, SummonedWSLi, "SummonedWSLi")
					end
				end

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.SpecialPropGetter(_env, "WSLi_Passive_Lover")(_env, global.FriendField(_env)) > 0 then
					global.ForbidenRevive(_env, _env.unit, true)
				end
			end)

			return _env
		end
	}

	return _M
end
