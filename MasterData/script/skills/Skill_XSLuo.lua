-- chunkname: @/tmp/or_skill/lua_compile/Skill_XSLuo.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_XSLuo_Normal = {
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
	_M.__all__.Skill_XSLuo_Proud = {
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
					-1.1,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				467
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					334
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_XSLuo_Unique = {
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
					-1.7,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local shield = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "Shield",
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					shield
				})

				local friend_count = 0
				local enemy_count = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS)) do
					friend_count = friend_count + 1
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS - global.SUMMONS)) do
					enemy_count = enemy_count + 1
				end

				if enemy_count < friend_count then
					local buffeft = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR") + global.MARKED(_env, "HEALER"))) do
						global.ApplyBuff(_env, unit, {
							timing = 4,
							duration = 12,
							display = "AtkUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end
				else
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR") + global.CARD_HERO_MARKED(_env, "HEALER"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"XSLuo_Unique"
							}
						}, {
							cardvaluechange
						})
					end
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					367
				}, global.SplitValue(_env, damage, {
					0.3,
					0.7
				}))
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_XSLuo_Passive = {
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

				if global.SpecialPropGetter(_env, "XSLuo_Passive")(_env, global.FriendField(_env)) == 0 then
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))) do
						if card then
							local value = global.GetCardCost(_env, card)
							local change_value = global.abs(_env, this.CostFactor - value)

							if value > this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "-", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							elseif value < this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "+", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							end
						end
					end

					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, global.EnemyField(_env)), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))) do
						if card then
							local value = global.GetCardCost(_env, card)
							local change_value = global.abs(_env, this.CostFactor - value)

							if value > this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "-", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							elseif value < this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "+", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XSLuo_Proud_EX = {
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
					-1.1,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				467
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local buffeft1 = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "Shield",
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
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					334
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_XSLuo_Unique_EX = {
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
					-1.7,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				2134
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.ACTOR)
				local shield = global.ShieldEffect(_env, maxHp * this.ShieldRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "Shield",
					tags = {
						"NUMERIC",
						"BUFF",
						"SHIELD",
						"DISPELLABLE",
						"STEALABLE"
					}
				}, {
					shield
				})

				local friend_count = 0
				local enemy_count = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS)) do
					friend_count = friend_count + 1
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.PETS - global.SUMMONS)) do
					enemy_count = enemy_count + 1
				end

				if enemy_count < friend_count then
					local buffeft = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR") + global.MARKED(_env, "HEALER"))) do
						global.ApplyBuff(_env, unit, {
							timing = 4,
							duration = 12,
							display = "AtkUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft
						})
					end
				else
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "WARRIOR") + global.CARD_HERO_MARKED(_env, "HEALER"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"XSLuo_Unique"
							}
						}, {
							cardvaluechange
						})
					end
				end

				if global.abs(_env, friend_count - enemy_count) > 4 then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "WARRIOR") + global.MARKED(_env, "HEALER") - global.MARKED(_env, "XSLuo"))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)
					end
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					367
				}, global.SplitValue(_env, damage, {
					0.3,
					0.7
				}))
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_XSLuo_Passive_EX = {
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

				if global.SpecialPropGetter(_env, "XSLuo_Passive")(_env, global.FriendField(_env)) == 0 then
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))) do
						if card then
							local value = global.GetCardCost(_env, card)
							local change_value = global.abs(_env, this.CostFactor - value)

							if value > this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "-", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							elseif value < this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "+", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							end
						end
					end

					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, global.EnemyField(_env)), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED"))) do
						if card then
							local value = global.GetCardCost(_env, card)
							local change_value = global.abs(_env, this.CostFactor - value)

							if value > this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "-", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							elseif value < this.CostFactor then
								local cardvaluechange = global.CardCostEnchant(_env, "+", change_value, 1)

								global.ApplyEnchant(_env, global.GetOwner(_env, global.EnemyField(_env)), card, {
									tags = {
										"CARDBUFF",
										"UNDISPELLABLE",
										"XSLuo_Unique"
									}
								}, {
									cardvaluechange
								})

								local buff = global.SpecialNumericEffect(_env, "+XSLuo_Passive", {
									"+Normal",
									"+Normal"
								}, 1)

								global.ApplyBuff(_env, global.FriendField(_env), {
									timing = 0,
									duration = 99,
									tags = {
										"XSLuo_Passive"
									}
								}, {
									buff
								})
							end
						end
					end
				end

				local buff_hurt = global.SpecialNumericEffect(_env, "+XSLuo_Passive_EX", {
					"+Normal",
					"+Normal"
				}, this.UnHurtFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "XSLuo_Passive_EX",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"HURTED",
						"XSLuo_Passive_EX"
					}
				}, {
					buff_hurt
				})
			end)

			return _env
		end
	}

	return _M
end
