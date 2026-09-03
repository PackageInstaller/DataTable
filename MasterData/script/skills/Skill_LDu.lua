-- chunkname: @/tmp/or_skill/lua_compile/Skill_LDu.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LDu_Normal = {
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
	_M.__all__.Skill_LDu_Proud = {
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

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					333
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Unique = {
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
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedLDu1 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu1 then
					global.AddStatus(_env, SummonedLDu1, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu2 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu2 then
					global.AddStatus(_env, SummonedLDu2, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu3 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu3 then
					global.AddStatus(_env, SummonedLDu3, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu3, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu4 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu4 then
					global.AddStatus(_env, SummonedLDu4, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu4, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu5 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu5 then
					global.AddStatus(_env, SummonedLDu5, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu5, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu6 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu6 then
					global.AddStatus(_env, SummonedLDu6, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu6, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu7 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu7 then
					global.AddStatus(_env, SummonedLDu7, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu7, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu8 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu8 then
					global.AddStatus(_env, SummonedLDu8, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu8, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu9 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu9 then
					global.AddStatus(_env, SummonedLDu9, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu9, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Passive = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, this.DmgRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_LDu_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_LDu_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Saba_Normal = {
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
				400
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
	_M.__all__.Skill_LDu_Saba_Passive_Death = {
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
				return
			end)
			exec["@time"]({
				500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.EnemyUnits(_env, global.MARKED(_env, "WARRIOR")))) do
					global.AssignRoles(_env, unit, "target")

					local DmgRateFactor = global.SpecialPropGetter(_env, "Skill_LDu_Passive")(_env, _env.ACTOR)

					if DmgRateFactor and DmgRateFactor ~= 0 then
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							DmgRateFactor,
							0
						})

						global.AddAnim(_env, {
							loop = 1,
							anim = "cisha_zhanshupai",
							zOrder = "TopLayer",
							pos = global.UnitPos(_env, unit)
						})
						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Proud_EX = {
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

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					333
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
				global.ApplyRPRecovery(_env, _env.ACTOR, this.RageFactor)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Unique_EX = {
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
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedLDu1 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu1 then
					global.AddStatus(_env, SummonedLDu1, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu2 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu2 then
					global.AddStatus(_env, SummonedLDu2, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu3 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu3 then
					global.AddStatus(_env, SummonedLDu3, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu3, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu4 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu4 then
					global.AddStatus(_env, SummonedLDu4, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu4, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu5 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu5 then
					global.AddStatus(_env, SummonedLDu5, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu5, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu6 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu6 then
					global.AddStatus(_env, SummonedLDu6, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu6, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu7 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu7 then
					global.AddStatus(_env, SummonedLDu7, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu7, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu8 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu8 then
					global.AddStatus(_env, SummonedLDu8, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu8, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				local SummonedLDu9 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu9 then
					global.AddStatus(_env, SummonedLDu9, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu9, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Passive_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, this.DmgRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_LDu_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_LDu_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.INSTATUS(_env, "SummonedLDu")(_env, _env.unit) or global.GetSummoner(_env, _env.unit) == _env.ACTOR) then
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedLDu")(_env, _env.unit) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "BUFF", "Skill_LDu_Passive", "UNDISPELLABLE", "UNSTEALABLE"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Passive_SelfAwaken = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+specialnum1", {
					"?Normal"
				}, this.DmgRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_LDu_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_LDu_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and (global.INSTATUS(_env, "SummonedLDu")(_env, _env.unit) or global.GetSummoner(_env, _env.unit) == _env.ACTOR) then
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"STATUS",
							"NUMERIC",
							"BUFF",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					}, 1)
					global.SelfEX_Summon_OneStage_inherit(_env, _env.unit)
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedLDu")(_env, _env.unit) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "BUFF", "Skill_LDu_Passive", "UNDISPELLABLE", "UNSTEALABLE"), 1)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LDu_Unique_Awken = {
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
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				2700
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.Diligent(_env)
				local SummonedLDu1 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu1 then
					global.AddStatus(_env, SummonedLDu1, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu1, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu1, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu2 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu2 then
					global.AddStatus(_env, SummonedLDu2, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu2, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu2, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu3 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu3 then
					global.AddStatus(_env, SummonedLDu3, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu3, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu3, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu4 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu4 then
					global.AddStatus(_env, SummonedLDu4, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu4, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu4, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu5 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu5 then
					global.AddStatus(_env, SummonedLDu5, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu5, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu5, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu6 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu6 then
					global.AddStatus(_env, SummonedLDu6, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu6, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu6, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu7 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu7 then
					global.AddStatus(_env, SummonedLDu7, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu7, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu7, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu8 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu8 then
					global.AddStatus(_env, SummonedLDu8, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu8, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu8, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				local SummonedLDu9 = global.Summon(_env, _env.ACTOR, "SummonedLDu", this.summonFactor, nil, {
					global.Random(_env, 1, 9)
				})

				if SummonedLDu9 then
					global.AddStatus(_env, SummonedLDu9, "SummonedLDu")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_LDu_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedLDu9, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, SummonedLDu9, {
						timing = 2,
						duration = 1,
						tags = {
							"STATUS",
							"DILIGENT",
							"Skill_LDu_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end

				for _, unit in global.__iter__(global.FriendUnits(_env, global.SUMMONS)) do
					if global.INSTATUS(_env, "SummonedLDu")(_env, unit) then
						global.ApplyBuff(_env, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_LDu_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end
				end
			end)
			exec["@time"]({
				2900
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

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedLDu")(_env, _env.unit) then
					global.DiligentRound(_env)
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
				local num = #global.FriendUnits(_env)

				if num == 9 then
					global.DiligentRound(_env)
				end
			end)

			return _env
		end
	}

	return _M
end
