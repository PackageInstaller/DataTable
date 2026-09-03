-- chunkname: @/tmp/or_skill/lua_compile/Skill_MYing.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_MYing_Normal = {
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
	_M.__all__.Skill_MYing_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.8,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1233
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
	_M.__all__.Skill_MYing_Unique = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local buff = global.SpecialNumericEffect(_env, "+MYing_stage_bingo", {
					"?Normal"
				}, 1)
				local trap = global.BuffTrap(_env, {
					timing = 2,
					duration = 1,
					tags = {
						"MYING_STAGE_BINGO"
					}
				}, {
					buff
				})

				for _, cell in global.__iter__(global.RandomN(_env, 9, global.FriendCells(_env, global.EMPTY_CELL(_env)))) do
					if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "TRAP")) == 0 then
						global.ApplyTrap(_env, cell, {
							display = "Stage",
							duration = 99,
							triggerLife = 99,
							tags = {
								"MYING_STAGE",
								"TRAP"
							}
						}, {
							trap
						})

						break
					end
				end

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_MYing_Stage")) == 0 then
					local buffeft = global.PassiveFunEffectBuff(_env, "Skill_MYing_Stage", {
						Ex = 0
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_MYing_Stage",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
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
	_M.__all__.Skill_MYing_Passive = {
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
				local num = global.SpecialPropGetter(_env, "Skill_MYing_Passive_Count")(_env, global.FriendField(_env))

				if num == 0 then
					global.ApplyEnergyDamage(_env, global.GetOwner(_env, global.EnemyField(_env)), this.Energy)

					for _, card in global.__iter__(global.RandomN(_env, 1, global.CardsInWindow(_env, global.GetOwner(_env, global.EnemyField(_env)), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED")))) do
						local Aibo = global.GetAIPosition(_env, global.GetSide(_env, global.EnemyField(_env)), card) and global.RecruitCard(_env, card, global.GetAIPosition(_env, global.GetSide(_env, global.EnemyField(_env)), card), nil, global.GetOwner(_env, global.EnemyField(_env))) or global.RecruitCard(_env, card, {
							-global.Random(_env, 1, 9)
						}, nil, global.GetOwner(_env, global.EnemyField(_env)))

						if Aibo then
							global.AddStatus(_env, Aibo, "Skill_MYing_Passive")
						end
					end

					local buff = global.SpecialNumericEffect(_env, "+Skill_MYing_Passive_Count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {}
					}, {
						buff
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "Skill_MYing_Passive")(_env, _env.unit) then
					global.AnimForTrgt(_env, _env.unit, {
						loop = 1,
						anim = "main_meiweisiyindao",
						zOrder = "TopLayer",
						pos = {
							0.5,
							-0.2
						}
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MYing_Stage = {
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and _env.isRevive == false and (global.MARKED(_env, "ASSASSIN")(_env, _env.unit) or global.MARKED(_env, "MAGE")(_env, _env.unit)) and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "MYING_STAGE_BINGO")) > 0 then
					global.AddAnim(_env, {
						loop = 1,
						anim = "main_meiweisiyinlang",
						zOrder = "TopLayer",
						pos = global.FixedPos(_env, global.GetSide(_env, global.EnemyField(_env)), 2, 2)
					})

					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						local buffeft1 = global.Mute(_env)
						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, this.Ex)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 4,
							display = "Mute",
							duration = this.Time,
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end

					global.DispelBuffTrap(_env, global.GetCell(_env, _env.unit), global.BUFF_MARKED(_env, "MYING_STAGE"))
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MYing_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.8,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1233
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.Mute(_env)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 4,
					duration = 8,
					display = "Mute",
					tags = {
						"STATUS",
						"DEBUFF",
						"MUTE",
						"ABNORMAL",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				}, 1, 0)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_MYing_Unique_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local buff = global.SpecialNumericEffect(_env, "+MYing_stage_bingo", {
					"?Normal"
				}, 1)
				local trap = global.BuffTrap(_env, {
					timing = 2,
					duration = 1,
					tags = {
						"MYING_STAGE_BINGO"
					}
				}, {
					buff
				})

				for _, cell in global.__iter__(global.RandomN(_env, 9, global.FriendCells(_env, global.EMPTY_CELL(_env)))) do
					if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "TRAP")) == 0 then
						global.ApplyTrap(_env, cell, {
							display = "Stage",
							duration = 99,
							triggerLife = 99,
							tags = {
								"MYING_STAGE",
								"TRAP"
							}
						}, {
							trap
						})

						break
					end
				end

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_MYing_Stage")) == 0 then
					local buffeft = global.PassiveFunEffectBuff(_env, "Skill_MYing_Stage", {
						Ex = 1
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_MYing_Stage",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
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
	_M.__all__.Skill_MYing_Passive_EX = {
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
				local num = global.SpecialPropGetter(_env, "Skill_MYing_Passive_Count")(_env, global.FriendField(_env))

				if num == 0 then
					global.ApplyEnergyDamage(_env, global.GetOwner(_env, global.EnemyField(_env)), this.Energy)

					for _, card in global.__iter__(global.RandomN(_env, 1, global.CardsInWindow(_env, global.GetOwner(_env, global.EnemyField(_env)), global.CARD_HERO_MARKED(_env, "HERO") - global.CARD_HERO_MARKED(_env, "SUMMONED")))) do
						local Aibo = global.GetAIPosition(_env, global.GetSide(_env, global.EnemyField(_env)), card) and global.RecruitCard(_env, card, global.GetAIPosition(_env, global.GetSide(_env, global.EnemyField(_env)), card), nil, global.GetOwner(_env, global.EnemyField(_env))) or global.RecruitCard(_env, card, {
							-global.Random(_env, 1, 9)
						}, nil, global.GetOwner(_env, global.EnemyField(_env)))

						if Aibo then
							global.AddStatus(_env, Aibo, "Skill_MYing_Passive")
						end
					end

					local buff = global.SpecialNumericEffect(_env, "+Skill_MYing_Passive_Count", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {}
					}, {
						buff
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "Skill_MYing_Passive")(_env, _env.unit) then
					global.AnimForTrgt(_env, _env.unit, {
						loop = 1,
						anim = "main_meiweisiyindao",
						zOrder = "TopLayer",
						pos = {
							0.5,
							-0.2
						}
					})
					global.ApplyRPDamage_ResultCheck(_env, _env.ACTOR, _env.unit, this.RpDamage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MYing_Unique_TRANS = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local buff = global.SpecialNumericEffect(_env, "+MYing_stage_bingo", {
					"?Normal"
				}, 1)
				local trap = global.BuffTrap(_env, {
					timing = 2,
					duration = 1,
					tags = {
						"MYING_STAGE_BINGO"
					}
				}, {
					buff
				})

				for _, cell in global.__iter__(global.RandomN(_env, 9, global.FriendCells(_env, global.EMPTY_CELL(_env)))) do
					if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "TRAP")) == 0 then
						global.ApplyTrap(_env, cell, {
							display = "Stage",
							duration = 99,
							triggerLife = 99,
							tags = {
								"MYING_STAGE",
								"TRAP"
							}
						}, {
							trap
						})

						break
					end
				end

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_MYing_Stage")) == 0 then
					local buffeft = global.PassiveFunEffectBuff(_env, "Skill_MYing_Stage", {
						Ex = 0
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_MYing_Stage",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)
			exec["@time"]({
				2800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				3000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SpecialPropGetter(_env, "Unique_count")(_env, _env.ACTOR) >= 2 then
					global.KillTarget(_env, _env.ACTOR)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_MYing_Unique_Awaken = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.13, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local buff = global.SpecialNumericEffect(_env, "+MYing_stage_bingo", {
					"?Normal"
				}, 1)
				local trap = global.BuffTrap(_env, {
					timing = 2,
					duration = 1,
					tags = {
						"MYING_STAGE_BINGO"
					}
				}, {
					buff
				})

				for _, cell in global.__iter__(global.RandomN(_env, 9, global.FriendCells(_env, global.EMPTY_CELL(_env)))) do
					if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "TRAP")) == 0 then
						global.ApplyTrap(_env, cell, {
							display = "Stage",
							duration = 99,
							triggerLife = 99,
							tags = {
								"MYING_STAGE",
								"TRAP"
							}
						}, {
							trap
						})

						break
					end
				end

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_MYing_Stage")) == 0 then
					local buffeft = global.PassiveFunEffectBuff(_env, "Skill_MYing_Stage", {
						Ex = 1,
						Time = this.Time
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"Skill_MYing_Stage",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
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

	return _M
end
