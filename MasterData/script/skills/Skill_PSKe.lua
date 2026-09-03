-- chunkname: @/tmp/or_skill/lua_compile/Skill_PSKe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_PSKe_Normal = {
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
				667
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
	_M.__all__.Skill_PSKe_Proud = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealFactor, 0)

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

				local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, _env.ACTOR, this.HealFactor, 0)

				global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, _env.ACTOR, heal)

				local buffeft2 = global.NumericEffect(_env, "+defrate", {
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
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.Stealth(_env, 0.8)
				local buffeft2 = global.Immune(_env)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 4,
					duration = 12,
					display = "Immune",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"DISPELLABLE",
						"STEALTH",
						"STEALABLE",
						"IMMUNE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 0)

				local buffeft_uncritrate1 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)
				local units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

				for _, unit in global.__iter__(units) do
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "UnCritRateUp",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE",
							"PSKe_UnCritRate"
						}
					}, {
						buffeft_uncritrate1
					}, 1)
				end

				local buffeft_uncritrate2 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 1,
					display = "UnCritRateUp",
					duration = 2,
					limit = 1,
					tags = {
						"STATUS",
						"BUFF",
						"DISPELLABLE",
						"STEALABLE",
						"PSKe_UnCritRate"
					}
				}, {
					buffeft_uncritrate2
				}, 1)

				local buff = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Hprecovery", {
					HealFactor = this.HealFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"BUFF",
						"Skill_PSKe_Hprecovery",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PSKe_First_Unique")) > 0 then
					local buffeft3 = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Energyrecovery", {
						Energy = this.Energy
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"Skill_PSKe_Energyrecovery",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "PSKe_First_Unique"), 1)
				end

				local buff_anim = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Anim")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"PSKE_ANIM"
					}
				}, {
					buff_anim
				})
			end)
			exec["@time"]({
				1950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
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
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"PSKe_First_Unique"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Passive = {
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
				local buffeft = global.EnergyEffect(_env, 1 + this.EnergyRecoveryFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "EnergyEffectUp",
					group = "Skill_PSKe_Passive",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"BUFF",
						"ENERGYEFFECTUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"PSKe_ENERGYEFFECTUP"
					}
				}, {
					buffeft
				})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) and (global.MARKED(_env, "HEALER")(_env, _env.unit) or global.MARKED(_env, "WARRIOR")(_env, _env.unit)) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Hprecovery = {
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
				local units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

				for _, unit in global.__iter__(units) do
					local Heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, unit, Heal)

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
				end

				local Heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, _env.ACTOR, this.HealFactor, 0)

				global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, _env.ACTOR, Heal)
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Energyrecovery = {
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
				local EnergyMax = global.GetActualCost(_env, _env.ACTOR)

				if EnergyMax == 0 then
					EnergyMax = 12
				end

				global.print(_env, "card能量上限1===", EnergyMax)

				if EnergyMax > this.i then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)

					this.i = this.i + 1

					global.print(_env, "计数i========", this.i)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Anim = {
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

				global.SwitchActionTo(_env, "stand", "stand_1", _env.ACTOR)
				global.Perform(_env, _env.ACTOR, global.Animation(_env, "stand"))
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

				if global.BuffIsMatched(_env, _env.buff, "IMMUNE") and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "IMMUNE")) == 0 then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_PSKe_Hprecovery"), 99)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_PSKe_Energyrecovery"), 99)

					local units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

					global.SwitchActionTo(_env, "stand", "stand", _env.ACTOR)
					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill3_1"))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Proud_EX = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill2"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, unit, this.HealFactor, 0)

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

				local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, _env.ACTOR, this.HealFactor, 0)

				global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, _env.ACTOR, heal)

				local buffeft2 = global.NumericEffect(_env, "+defrate", {
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
					buffeft2
				})
				global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Unique_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1867
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.Stealth(_env, 0.8)
				local buffeft2 = global.Immune(_env)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 4,
					duration = 12,
					display = "Immune",
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"DISPELLABLE",
						"STEALTH",
						"STEALABLE",
						"IMMUNE"
					}
				}, {
					buffeft1,
					buffeft2
				}, 1, 0)

				local buffeft_uncritrate1 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)
				local units = global.FriendUnits(_env, global.NEIGHBORS_OF(_env, _env.ACTOR))

				for _, unit in global.__iter__(units) do
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 1,
						display = "UnCritRateUp",
						duration = 2,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"DISPELLABLE",
							"STEALABLE",
							"PSKe_UnCritRate"
						}
					}, {
						buffeft_uncritrate1
					}, 1)
				end

				local buffeft_uncritrate2 = global.NumericEffect(_env, "+uncritrate", {
					"+Normal",
					"+Normal"
				}, this.UnCritRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 1,
					display = "UnCritRateUp",
					duration = 2,
					limit = 1,
					tags = {
						"STATUS",
						"BUFF",
						"DISPELLABLE",
						"STEALABLE",
						"PSKe_UnCritRate"
					}
				}, {
					buffeft_uncritrate2
				}, 1)

				local buff = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Hprecovery", {
					HealFactor = this.HealFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"BUFF",
						"Skill_PSKe_Hprecovery",
						"DISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "PSKe_First_Unique")) > 0 then
					local buffeft3 = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Energyrecovery", {
						Energy = this.Energy
					})

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"BUFF",
							"Skill_PSKe_Energyrecovery",
							"DISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "PSKe_First_Unique"), 1)
				end

				local buff_anim = global.PassiveFunEffectBuff(_env, "Skill_PSKe_Anim")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"PSKE_ANIM"
					}
				}, {
					buff_anim
				})

				local buff_RPRecovery = global.PassiveFunEffectBuff(_env, "Skill_PSKe_RPRecovery", {
					RPFactor = this.RPFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Skill_PSKe_RPRecovery"
					}
				}, {
					buff_RPRecovery
				})
			end)
			exec["@time"]({
				1950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
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
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"PSKe_First_Unique"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_RPRecovery = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
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

				if global.BuffIsMatched(_env, _env.buff, "IMMUNE") and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "IMMUNE")) == 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RPFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Passive_EX = {
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
				local buffeft = global.EnergyEffect(_env, 1 + this.EnergyRecoveryFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					display = "EnergyEffectUp",
					group = "Skill_PSKe_Passive",
					duration = 99,
					limit = 1,
					tags = {
						"STATUS",
						"BUFF",
						"ENERGYEFFECTUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"PSKe_ENERGYEFFECTUP"
					}
				}, {
					buffeft
				})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) and (global.MARKED(_env, "HEALER")(_env, _env.unit) or global.MARKED(_env, "WARRIOR")(_env, _env.unit)) then
					global.ApplyEnergyRecovery(_env, global.GetOwner(_env, _env.ACTOR), this.Energy)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_PSKe_Passive_Key = {
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

				if global.MARKED(_env, "QBTe")(_env, _env.ACTOR) then
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.hurtFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "HurtRateUp",
						group = "Skill_PSKe_Passive_Key_1",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_PSKe_Passive_Key_1"
						}
					}, {
						buffeft1
					})
				end

				if global.MARKED(_env, "PSKe")(_env, _env.ACTOR) then
					local buffeft2 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						display = "AoeUnHurtRateUp",
						group = "Skill_PSKe_Passive_Key_2",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"Skill_PSKe_Passive_Key_2"
						}
					}, {
						buffeft2
					})
				end
			end)

			return _env
		end
	}

	return _M
end
