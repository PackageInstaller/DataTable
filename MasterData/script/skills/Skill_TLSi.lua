-- chunkname: @/tmp/or_skill/lua_compile/Skill_TLSi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_TLSi_Normal = {
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
					-0.8,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				367
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
	_M.__all__.Skill_TLSi_Proud = {
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
					-1.1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				833
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
	_M.__all__.Skill_TLSi_Unique = {
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
			_env.location = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 1 then
					_env.location = 1
				elseif global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 2 then
					_env.location = 2
				elseif global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 3 then
					_env.location = 3
				end

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

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

				if _env.location == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_2"))
				elseif _env.location == 3 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))
				elseif _env.location == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.location == 1 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, atk * this.ShieldFactor)
					local buffeft2 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.ONESELF(_env, _env.ACTOR) + global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR) * global.COL_OF(_env, _env.ACTOR))) do
						global.DelayCall(_env, 467, global.ApplyBuff_Buff, _env.ACTOR, unit, {
							timing = 2,
							duration = 2,
							display = "Shield",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"SHIELD",
								"DISPELLABLE",
								"STEALABLE",
								"Skill_TLSi_Unique_1"
							}
						}, {
							buffeft1
						}, 1)
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 2,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_TLSi_Unique_1"
							}
						}, {
							buffeft2
						}, 1)
					end
				elseif _env.location == 3 then
					local buff = global.Diligent(_env)

					for i = 1, 2 do
						local SummonedTLSi = global.Summon(_env, _env.ACTOR, "SummonedTLSi", {
							this.HpFactor,
							this.AtkFactor,
							0
						}, nil, {
							4,
							6,
							5,
							7,
							8,
							9,
							1,
							3,
							2
						})

						if SummonedTLSi then
							global.AddStatus(_env, SummonedTLSi, "SummonedTLSi")
							global.ApplyBuff(_env, SummonedTLSi, {
								timing = 2,
								duration = 1,
								tags = {
									"STATUS",
									"DILIGENT",
									"Skill_TLSi_Unique_2",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
						if global.INSTATUS(_env, "SummonedTLSi")(_env, unit) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								tags = {
									"STATUS",
									"DILIGENT",
									"Skill_TLSi_Unique_2",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					global.DelayCall(_env, 400, global.EnergyRestrainStop, _env.ACTOR, _env.TARGET)
					global.DelayCall(_env, 433, global.Stop)
				elseif _env.location == 2 then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							100,
							200,
							300
						}, global.SplitValue(_env, damage, {
							0.25,
							0.25,
							0.25,
							0.25
						}))
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"TLSi_Mid_Unique"
							}
						}, {
							buff
						})
					end

					global.DelayCall(_env, 800, global.EnergyRestrainStop, _env.ACTOR, _env.TARGET)
					global.DelayCall(_env, 833, global.Stop)
				end
			end)
			exec["@time"]({
				3300
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedTLSi")(_env, _env.unit) and global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 3 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.unit)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

					if maxHp > atk * 3 then
						local buff = global.MaxHpEffect(_env, -(maxHp - atk * 3))

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.DiligentRound(_env, 100)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 2 and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "TLSi_Mid_Unique")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

					if global.FriendMaster(_env) then
						global.ApplyRPRecovery(_env, global.FriendMaster(_env), this.RageFactor)
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "TLSi_Mid_Unique"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TLSi_Passive = {
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
					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)

					if global.SelectCardBuffCount(_env, card, "Skill_TLSi_Passive") == 0 then
						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "Skill_TLSi_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"CARDBUFF",
								"BUFF",
								"Skill_TLSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						})
						global.FlyBallEffect(_env, _env.ACTOR, card)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TLSi_Bird_Normal = {
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
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRealDamage(_env, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2])
			end)

			return _env
		end
	}
	_M.__all__.Skill_TLSi_Proud_EX = {
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
					-1.1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				833
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"Skill_TLSi_Proud_EX"
					}
				}, {
					buff
				})

				local cards = global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR))

				for _, card in global.__iter__(cards) do
					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)
					local buff2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor)

					if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "Skill_TLSi_Proud_EX")) <= 3 then
						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							timing = 0,
							duration = 99,
							tags = {
								"CARDBUFF",
								"BUFF",
								"Skill_TLSi_Proud_EX",
								"HURTRATEUP",
								"UNHURTRATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff1,
							buff2
						})
						global.FlyBallEffect(_env, _env.ACTOR, card)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TLSi_Unique_EX = {
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
			_env.location = 0

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 1 then
					_env.location = 1
				elseif global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 2 then
					_env.location = 2
				elseif global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 3 then
					_env.location = 3
				end

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

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

				if _env.location == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_2"))
				elseif _env.location == 3 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))
				elseif _env.location == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
					global.HarmTargetView(_env, _env.units)

					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.location == 1 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)
					local buffeft1 = global.ShieldEffect(_env, atk * this.ShieldFactor)
					local buffeft2 = global.NumericEffect(_env, "+aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					for _, unit in global.__iter__(global.FriendUnits(_env, global.ONESELF(_env, _env.ACTOR) + global.NEIGHBORS_OF(_env, _env.ACTOR) * global.BACK_OF(_env, _env.ACTOR) * global.COL_OF(_env, _env.ACTOR))) do
						global.DelayCall(_env, 467, global.ApplyBuff_Buff, _env.ACTOR, unit, {
							timing = 2,
							duration = 2,
							display = "Shield",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"SHIELD",
								"DISPELLABLE",
								"STEALABLE",
								"Skill_TLSi_Unique_1"
							}
						}, {
							buffeft1
						}, 1)
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 2,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"AOEDERATEUP",
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Skill_TLSi_Unique_1"
							}
						}, {
							buffeft2
						}, 1)
					end
				elseif _env.location == 3 then
					local buff = global.Diligent(_env)

					for i = 1, 2 do
						local SummonedTLSi = global.Summon(_env, _env.ACTOR, "SummonedTLSi", {
							this.HpFactor,
							this.AtkFactor,
							0
						}, nil, {
							4,
							6,
							5,
							7,
							8,
							9,
							1,
							3,
							2
						})

						if SummonedTLSi then
							global.AddStatus(_env, SummonedTLSi, "SummonedTLSi")
							global.ApplyBuff(_env, SummonedTLSi, {
								timing = 2,
								duration = 1,
								tags = {
									"STATUS",
									"DILIGENT",
									"Skill_TLSi_Unique_2",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
						if global.INSTATUS(_env, "SummonedTLSi")(_env, unit) then
							global.ApplyBuff(_env, unit, {
								timing = 2,
								duration = 1,
								tags = {
									"STATUS",
									"DILIGENT",
									"Skill_TLSi_Unique_2",
									"UNDISPELLABLE",
									"UNSTEALABLE"
								}
							}, {
								buff
							})
						end
					end

					global.DelayCall(_env, 400, global.EnergyRestrainStop, _env.ACTOR, _env.TARGET)
					global.DelayCall(_env, 433, global.Stop)
				elseif _env.location == 2 then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local result = global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							100,
							200,
							300
						}, global.SplitValue(_env, damage, {
							0.25,
							0.25,
							0.25,
							0.25
						}))
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.ACTOR, {
							timing = 0,
							duration = 99,
							tags = {
								"TLSi_Mid_Unique"
							}
						}, {
							buff
						})
					end

					global.DelayCall(_env, 800, global.EnergyRestrainStop, _env.ACTOR, _env.TARGET)
					global.DelayCall(_env, 833, global.Stop)
				end
			end)
			exec["@time"]({
				3300
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedTLSi")(_env, _env.unit) and global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 3 then
					local atk = global.UnitPropGetter(_env, "atk")(_env, _env.unit)
					local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)

					if maxHp > atk * 3 then
						local buff = global.MaxHpEffect(_env, -(maxHp - atk * 3))

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					global.DiligentRound(_env, 100)
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.CellRowLocation(_env, global.GetCell(_env, _env.ACTOR)) == 2 and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "TLSi_Mid_Unique")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)

					if global.FriendMaster(_env) then
						global.ApplyRPRecovery(_env, global.FriendMaster(_env), this.RageFactor)
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "TLSi_Mid_Unique"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_TLSi_Passive_EX = {
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
					local exrate = 0

					if global.MARKED(_env, "HEALER")(_env, card) then
						exrate = this.ExRateFactor
					end

					local buffeft1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor + exrate)
					local buffeft2 = global.NumericEffect(_env, "+unhurtrate", {
						"+Normal",
						"+Normal"
					}, this.RateFactor + exrate)

					if global.SelectCardBuffCount(_env, card, "Skill_TLSi_Passive") == 0 then
						global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
							duration = 99,
							group = "Skill_TLSi_Passive",
							timing = 0,
							limit = 1,
							tags = {
								"CARDBUFF",
								"BUFF",
								"Skill_TLSi_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						})
						global.FlyBallEffect(_env, _env.ACTOR, card)
					end
				end
			end)

			return _env
		end
	}

	return _M
end
