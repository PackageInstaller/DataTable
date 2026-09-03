-- chunkname: @/tmp/or_skill/lua_compile/Skill_MDSi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MDSi_Normal = {
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
					-1.3,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
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
	_M.__all__.Skill_MDSi_Proud = {
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
				600
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
	_M.__all__.Skill_MDSi_Proud_EX = {
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
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if not global.MASTER(_env, _env.TARGET) and not global.MARKED(_env, "SummonedNian")(_env, _env.TARGET) then
					local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
					local extra_damage = hp * this.DamageFactor

					global.ApplyHPDamage(_env, _env.TARGET, extra_damage)

					if global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) == 0 then
						local Heal = extra_damage * this.HealRateFactor
						local Swtich = true
						local LastHeal = global.SpecialPropGetter(_env, "Skill_MDSi_Hprecovery_Proud_LastHeal")(_env, _env.TARGET)

						Heal = Heal + LastHeal

						global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED(_env, "Skill_MDSi_Hprecovery_Proud"), 99)

						local buff = global.PassiveFunEffectBuff(_env, "Skill_MDSi_Hprecovery_Proud", {
							Period = this.Period,
							Heal = Heal,
							Swtich = Swtich
						})

						global.ApplyBuff(_env, _env.TARGET, {
							timing = 4,
							duration = this.Period,
							tags = {
								"BUFF",
								"Skill_MDSi_Hprecovery_Proud",
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
	_M.__all__.Skill_MDSi_Unique = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, false)
				end

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.setRootVisible(_env, unit, true)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectTrueBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.HarmTargetView(_env, _env.units)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if not global.MASTER(_env, unit) and not global.MARKED(_env, "SummonedNian")(_env, unit) then
						local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
						local extra_damage = hp * this.DamageFactor

						global.ApplyHPDamage(_env, unit, extra_damage)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) == 0 then
							local Heal = extra_damage * this.HealRateFactor
							local Swtich = true
							local LastHeal = global.SpecialPropGetter(_env, "Skill_MDSi_Hprecovery_Unique_LastHeal")(_env, unit)

							Heal = Heal + LastHeal

							global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_MDSi_Hprecovery"), 99)

							local buff = global.PassiveFunEffectBuff(_env, "Skill_MDSi_Hprecovery_Unique", {
								Period = this.Period,
								Heal = Heal,
								Swtich = Swtich
							})

							global.ApplyBuff(_env, unit, {
								timing = 4,
								duration = this.Period,
								tags = {
									"BUFF",
									"Skill_MDSi_Hprecovery",
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
			exec["@time"]({
				2734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, true)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MDSi_Unique_EX = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, false)
				end

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.setRootVisible(_env, unit, true)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectTrueBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.HarmTargetView(_env, _env.units)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if not global.MASTER(_env, unit) and not global.MARKED(_env, "SummonedNian")(_env, unit) then
						local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
						local extra_damage = hp * this.DamageFactor

						global.ApplyHPDamage(_env, unit, extra_damage)

						if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) == 0 then
							local Heal = extra_damage * this.HealRateFactor
							local Swtich = true
							local LastHeal = global.SpecialPropGetter(_env, "Skill_MDSi_Hprecovery_Unique_LastHeal")(_env, unit)

							Heal = Heal + LastHeal

							global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Skill_MDSi_Hprecovery"), 99)

							local buff = global.PassiveFunEffectBuff(_env, "Skill_MDSi_Hprecovery_Unique", {
								Period = this.Period,
								Heal = Heal,
								Swtich = Swtich
							})

							global.ApplyBuff(_env, unit, {
								timing = 4,
								duration = this.Period,
								tags = {
									"BUFF",
									"Skill_MDSi_Hprecovery",
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
			exec["@time"]({
				2734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, true)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MDSi_Passive = {
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
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))

				for _, card in global.__iter__(cards) do
					if global.MARKED(_env, "MAGE")(_env, card) then
						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.RateFactor)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "Skill_MDSi_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"CARDBUFF",
								"BUFF",
								"Skill_MDSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.FlyBallEffect(_env, _env.ACTOR, card)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MDSi_Passive_EX = {
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
				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))

				for _, card in global.__iter__(cards) do
					if global.MARKED(_env, "MAGE")(_env, card) then
						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.RateFactor)

						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "Skill_MDSi_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"CARDBUFF",
								"BUFF",
								"Skill_MDSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.FlyBallEffect(_env, _env.ACTOR, card)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MDSi_Hprecovery_Unique = {
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
				local healing = this.Heal / this.Period

				if healing and healing > 1 then
					global.ApplyHPRecovery(_env, _env.ACTOR, healing, this.Swtich)

					local buffeft = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					this.LastHeal = this.LastHeal - healing

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_MDSi_Hprecovery_Unique_LastHeal"), 99)

					local buff = global.SpecialNumericEffect(_env, "+Skill_MDSi_Hprecovery_Unique_LastHeal", {
						"+Normal",
						"+Normal"
					}, this.LastHeal)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_MDSi_Hprecovery_Unique_LastHeal",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MDSi_Hprecovery_Proud = {
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
				local healing = this.Heal / this.Period

				if healing and healing > 1 then
					global.ApplyHPRecovery(_env, _env.ACTOR, healing, this.Swtich)

					local buffeft = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 2,
						duration = 1,
						display = "Heal",
						tags = {
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					this.LastHeal = this.LastHeal - healing

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_MDSi_Hprecovery_Proud_LastHeal"), 99)

					local buff = global.SpecialNumericEffect(_env, "+Skill_MDSi_Hprecovery_Proud_LastHeal", {
						"+Normal",
						"+Normal"
					}, this.LastHeal)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_MDSi_Hprecovery_Proud_LastHeal",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}

	return _M
end
