-- chunkname: @/tmp/or_skill/lua_compile/Skill_MTZMEShi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MTZMEShi_Normal = {
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
				}, 100, "attack"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					267
				}, global.SplitValue(_env, damage, {
					0.48,
					0.52
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Proud = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Unique = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 4,
					display = "DefUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"DEFRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Passive = {
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
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))
				local Energy = 6

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					Energy = 12
				end

				local buff_num = global.SpecialNumericEffect(_env, "+MTZMEShi_Passive_Energy", {
					"+Normal",
					"+Normal"
				}, Energy)
				local buff = global.PassiveFunEffectBuff(_env, "MTZMEShi_For_BackCard", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"MTZMEShi_For_BackCard"
					}
				}, {
					buff,
					buff_num
				})

				for _, card in global.__iter__(cards) do
					local cardvaluechange = global.CardCostEnchant(_env, "-", Energy, 1)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 1,
						duration = 1,
						tags = {
							"CARDBUFF",
							"Skill_MTZMEShi_Passive",
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
	_M.__all__.MTZMEShi_For_BackCard = {
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
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "MTZMEShi_BackCard_Check")) == 0 then
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))) do
						if global.SelectEnhanceCount(_env, global.GetOwner(_env, _env.ACTOR), card, global.BUFF_MARKED(_env, "Skill_MTZMEShi_Passive")) == 0 then
							local cardvaluechange = global.CardCostEnchant(_env, "-", global.SpecialPropGetter(_env, "MTZMEShi_Passive_Energy")(_env, global.FriendField(_env)), 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								timing = 1,
								duration = 1,
								tags = {
									"CARDBUFF",
									"Skill_MTZMEShi_Passive",
									"UNDISPELLABLE"
								}
							}, {
								cardvaluechange
							})

							local buff_check = global.SpecialNumericEffect(_env, "+MTZMEShi_BackCard_Check", {
								"+Normal",
								"+Normal"
							}, 1)

							global.ApplyBuff(_env, global.FriendField(_env), {
								timing = 0,
								duration = 99,
								tags = {
									"MTZMEShi_BackCard_Check"
								}
							}, {
								buff_check
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "MTZMEShi_For_BackCard")) > 0 and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.isRevive == false and (global.PETS - global.SUMMONS)(_env, _env.unit) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "MTZMEShi_For_BackCard"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Proud_EX = {
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
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)

				global.ApplyHPRecovery(_env, _env.ACTOR, maxHp * this.HealRateFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Unique_EX = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 4,
					display = "DefUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"DEFRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Passive_EX = {
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
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))
				local Energy = 9

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					Energy = 15
				end

				local buff_num = global.SpecialNumericEffect(_env, "+MTZMEShi_Passive_Energy", {
					"+Normal",
					"+Normal"
				}, Energy)
				local buff = global.PassiveFunEffectBuff(_env, "MTZMEShi_For_BackCard", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"MTZMEShi_For_BackCard"
					}
				}, {
					buff,
					buff_num
				})

				for _, card in global.__iter__(cards) do
					local cardvaluechange = global.CardCostEnchant(_env, "-", Energy, 1)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 1,
						duration = 1,
						tags = {
							"CARDBUFF",
							"Skill_MTZMEShi_Passive",
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
	_M.__all__.Skill_MTZMEShi_Unique_Awken = {
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

				global.AssignRoles(_env, _env.TARGET, "target")
				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.7,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, this.DefRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 2,
					duration = 4,
					display = "DefUp",
					tags = {
						"NUMERIC",
						"BUFF",
						"DEFRATEUP",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.EnergyNum)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Passive_SelfAwaken = {
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
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))
				local Energy = 9

				if global.FriendMaster(_env) and global.INSTATUS(_env, "SectSkill_Master_SenLing_3")(_env, global.FriendMaster(_env)) then
					Energy = 15
				end

				local buff_num = global.SpecialNumericEffect(_env, "+MTZMEShi_Passive_Energy", {
					"+Normal",
					"+Normal"
				}, Energy)
				local buff = global.PassiveFunEffectBuff(_env, "MTZMEShi_For_BackCard", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"MTZMEShi_For_BackCard"
					}
				}, {
					buff,
					buff_num
				})

				for _, card in global.__iter__(cards) do
					local cardvaluechange = global.CardCostEnchant(_env, "-", Energy, 1)

					global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
						timing = 1,
						duration = 1,
						tags = {
							"CARDBUFF",
							"Skill_MTZMEShi_Passive",
							"UNDISPELLABLE"
						}
					}, {
						cardvaluechange
					})
				end

				for _, unit in global.__iter__(global.FriendUnits(_env)) do
					local buffeft1 = global.NumericEffect(_env, "+effectrate", {
						"+Normal",
						"+Normal"
					}, this.EffectRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "Skill_MTZMEShi_Passive_SelfAwaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end

				for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))) do
					local buffeft1 = global.NumericEffect(_env, "+effectrate", {
						"+Normal",
						"+Normal"
					}, this.EffectRateFactor)

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						duration = 99,
						group = "Skill_MTZMEShi_Passive_SelfAwaken",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local buffeft_s1 = global.EnergyEffect(_env, 1 + this.EnergyRecoveryFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "EnergyEffectUp",
					group = "Skill_MTZMEShi_Passive_SelfAwaken_Energy",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"BUFF",
						"ENERGYEFFECTUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"MTZMEShi_ENERGYEFFECTUP"
					}
				}, {
					buffeft_s1
				})

				local buffeft_s2 = global.EnergyEffect(_env, 1 - this.EnergyRecoveryFactor)

				global.ApplyBuff(_env, global.EnemyField(_env), {
					duration = 99,
					group = "Skill_MTZMEShi_Passive_SelfAwaken_EnergyDown",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"DEBUFF",
						"ENERGYEFFECTDOWN",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"MTZMEShi_ENERGYEFFECTDOWN"
					}
				}, {
					buffeft_s2
				})

				local buffeft_s3 = global.PassiveFunEffectBuff(_env, "Skill_MTZMEShi_Passive_SelfAwaken_Field", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_MTZMEShi_Passive_SelfAwaken_Field"
					}
				}, {
					buffeft_s3
				})
			end)

			return _env
		end,
		passive2 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.MARKED(_env, "MTZMEShi")(_env, _env.unit) then
					global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "MTZMEShi_ENERGYEFFECTDOWN"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MTZMEShi_Passive_SelfAwaken_Field = {
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

				if global.GetSide(_env, _env.ACTOR) == global.GetSide(_env, _env.unit) and global.MARKED(_env, "MTZMEShi")(_env, _env.unit) then
					global.DispelBuff(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "MTZMEShi_ENERGYEFFECTDOWN"), 99)
				end
			end)

			return _env
		end
	}

	return _M
end
