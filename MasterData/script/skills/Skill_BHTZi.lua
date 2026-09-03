-- chunkname: @/tmp/or_skill/lua_compile/Skill_BHTZi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BHTZi_Normal = {
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
				534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_BHTZi_Passive"), 1)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Proud = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.8,
					0
				}, 100, "skill2"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_BHTZi_Passive"), 1)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Unique = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, nil, 2) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1850
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local back_damage = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
					if (global.PETS - global.SUMMONS)(_env, unit) then
						local back_atk = global.UnitPropBaseGetter(_env, "atk")(_env, unit)

						back_damage = back_atk * this.ExDamage
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					damage.val = damage.val + back_damage

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
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
	_M.__all__.Skill_BHTZi_Passive = {
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

				if global.MARKED(_env, "BHTZi")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
						if (global.PETS - global.SUMMONS)(_env, unit) then
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Proud_EX = {
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

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.8,
					0
				}, 100, "skill2"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env))) do
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
					local buffeft1 = global.ShieldEffect(_env, maxHp * 0.1)

					global.ApplyBuff(_env, unit, {
						timing = 0,
						display = "Shield",
						group = "Skill_BHTZi_Proud_EX",
						duration = 99,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"SHIELD"
						}
					}, {
						buffeft1
					})
				end

				for _, unit in global.__iter__(_env.units) do
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "Skill_BHTZi_Passive"), 1)
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Unique_EX = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, nil, 2) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1850
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local back_damage = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
					if (global.PETS - global.SUMMONS)(_env, unit) then
						local back_atk = global.UnitPropBaseGetter(_env, "atk")(_env, unit)

						back_damage = back_atk * this.ExDamage
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					damage.val = damage.val + back_damage

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
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
	_M.__all__.Skill_BHTZi_Passive_EX = {
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

				if global.MARKED(_env, "BHTZi")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
						if (global.PETS - global.SUMMONS)(_env, unit) then
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Passive_Awaken = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
						local cardvaluechange1 = global.CardCostEnchant(_env, "-", this.CostNum, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_BHTZi_Passive_Awaken"
							}
						}, {
							cardvaluechange1
						})
					end

					this.supportCount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "HEALER"))
					this.summonCount = #global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SUMMONER"))
					this.allCount = this.supportCount + this.summonCount or 0

					if this.allCount >= 4 then
						for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
							local cardvaluechange2 = global.CardCostEnchant(_env, "-", this.FinalNum - this.CostNum, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE",
									"Skill_BHTZi_Passive_Awaken"
								}
							}, {
								cardvaluechange2
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

			_env.supportCount = nil
			_env.summonCount = nil
			_env.fieldCount = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MARKED(_env, "BHTZi")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
						if (global.PETS - global.SUMMONS)(_env, unit) then
							global.ApplyRPRecovery(_env, unit, this.RageFactor)
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

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, "BHTZi")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
						local cardvaluechange1 = global.CardCostEnchant(_env, "-", this.CostNum, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_BHTZi_Passive_Awaken"
							}
						}, {
							cardvaluechange1
						})
					end

					if global.FriendMaster(_env) and this.allCount >= 4 then
						for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
							local cardvaluechange2 = global.CardCostEnchant(_env, "-", this.FinalNum - this.CostNum, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE",
									"Skill_BHTZi_Passive_Awaken"
								}
							}, {
								cardvaluechange2
							})
						end
					end
				end
			end)

			return _env
		end,
		passive4 = function(_env, externs)
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

				if global.MASTER(_env, _env.ACTOR) and global.MARKED(_env, "BHTZi")(_env, _env.unit) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
						local cardvaluechange1 = global.CardCostEnchant(_env, "-", this.CostNum, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_BHTZi_Passive_Awaken"
							}
						}, {
							cardvaluechange1
						})
					end

					if global.FriendMaster(_env) and this.allCount >= 4 then
						for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BHTZi"))) do
							local cardvaluechange2 = global.CardCostEnchant(_env, "-", this.FinalNum - this.CostNum, 1)

							global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
								tags = {
									"CARDBUFF",
									"UNDISPELLABLE",
									"Skill_BHTZi_Passive_Awaken"
								}
							}, {
								cardvaluechange2
							})
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BHTZi_Unique_SelfAwaken = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, nil, 2) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1850
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local back_damage = 0

				for _, unit in global.__iter__(global.FriendUnits(_env, global.COL_OF(_env, _env.ACTOR) * global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR))) do
					if (global.PETS - global.SUMMONS)(_env, unit) then
						global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 2)

						local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
							"+Normal",
							"+Normal"
						}, this.HurtRateFactor)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							duration = 99,
							display = "HurtRateUp",
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"Skill_BHTZi_Unique_SelfAwaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})

						local back_atk = global.UnitPropBaseGetter(_env, "atk")(_env, unit)

						back_damage = back_atk * this.ExDamage
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					damage.val = damage.val + back_damage

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
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

	return _M
end
