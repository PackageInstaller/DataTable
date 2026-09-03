-- chunkname: @/tmp/or_skill/lua_compile/Skill_BBLMa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BBLMa_Normal = {
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
					-1.2,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				500
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
	_M.__all__.Skill_BBLMa_Proud = {
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
				700
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
	_M.__all__.Skill_BBLMa_Unique = {
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
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15101_biaozhi")) > 0 then
					global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

					this.ProbRateFactor1 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_First")(_env, _env.ACTOR)
					this.ProbRateFactor2 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_Second")(_env, _env.ACTOR)

					global.Serious_Injury(_env, _env.ACTOR, _env.TARGET, 0.6, 20, 4)
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor1) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				2766
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor1,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				3600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor2) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				4066
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor2,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				4950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Passive = {
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

				if global.EnemyMaster(_env) then
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, global.EnemyMaster(_env), "DEFENDER")
					local damage = global.EvalDamage(_env, attacker, defender, {
						1,
						this.DmgRateFactor,
						0
					})

					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.EnemyMaster(_env))
					})
					global.ApplyHPDamage(_env, global.EnemyMaster(_env), damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Passive_Key = {
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

				if global.EnemyMaster(_env) then
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, global.EnemyMaster(_env), "DEFENDER")
					local damage = global.EvalDamage(_env, attacker, defender, {
						1,
						this.DmgRateFactor,
						0
					})

					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.EnemyMaster(_env))
					})
					global.ApplyHPDamage(_env, global.EnemyMaster(_env), damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Proud_EX = {
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
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if (global.PETS - global.SUMMONS)(_env, _env.TARGET) and global.EnemyMaster(_env) then
					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.EnemyMaster(_env))
					})
					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, global.EnemyMaster(_env), damage * this.DmgRateFactor)
				end

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Unique_EX = {
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
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15101_biaozhi")) > 0 then
					global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

					this.ProbRateFactor1 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_First")(_env, _env.ACTOR)
					this.ProbRateFactor2 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_Second")(_env, _env.ACTOR)

					global.Serious_Injury(_env, _env.ACTOR, _env.TARGET, 0.6, 20, 4)
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor1) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				2766
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor1,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				3600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor2) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				4066
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor2,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				4950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Passive_EX = {
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
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkRateFactor)

				global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"Skill_BBLMa_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
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

				if global.EnemyMaster(_env) then
					local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
					local defender = global.LoadUnit(_env, global.EnemyMaster(_env), "DEFENDER")
					local damage = global.EvalDamage(_env, attacker, defender, {
						1,
						this.DmgRateFactor,
						0
					})

					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, global.EnemyMaster(_env))
					})
					global.ApplyHPDamage(_env, global.EnemyMaster(_env), damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BBLMa_Unique_SelfAwaken = {
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
				global.HarmTargetView(_env, {
					_env.TARGET
				})
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-2.1,
					0
				}, 100, "skill3"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1367
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "EquipSkill_Weapon_15101_biaozhi")) > 0 then
					global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

					this.ProbRateFactor1 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_First")(_env, _env.ACTOR)
					this.ProbRateFactor2 = global.SpecialPropGetter(_env, "EquipSkill_Weapon_15101_Second")(_env, _env.ACTOR)

					global.Serious_Injury(_env, _env.ACTOR, _env.TARGET, 0.6, 20, 4)
				end

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))

				if #global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR)) > 0 then
					for _, unit in global.__iter__(global.RandomN(_env, 2, global.FriendUnits(_env, -global.ONESELF(_env, _env.ACTOR)))) do
						local buffeft2 = global.RageGainEffect(_env, "-", {
							"+Normal",
							"+Normal"
						}, 1)
						local buffeft3 = global.Diligent(_env)

						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 2,
							duration = 1,
							tags = {
								"NUMERIC",
								"BUFF",
								"ATKUP",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft2,
							buffeft3
						}, 1)
					end

					global.DiligentRound(_env)
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor1) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				2766
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor1,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				3600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.ProbTest(_env, this.ProbRateFactor2) then
					if global.IsAlive(_env, _env.TARGET) then
						global.CancelTargetView(_env)
						global.HarmTargetView(_env, {
							_env.TARGET
						})
						global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
							-2.1,
							0
						}, 100, "skill3"))
						global.AssignRoles(_env, _env.TARGET, "target")
					else
						global.UnassignRoles(_env, _env.TARGET, "target")

						local units = global.RandomN(_env, 1, global.EnemyUnits(_env, -global.ONESELF(_env, _env.TARGET)))

						if units[1] then
							for _, unit in global.__iter__(units) do
								_env.TARGET = unit

								global.CancelTargetView(_env)
								global.HarmTargetView(_env, {
									_env.TARGET
								})
								global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
									-2.1,
									0
								}, 100, "skill3"))
								global.AssignRoles(_env, _env.TARGET, "target")
							end
						else
							global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
							global.Stop(_env)
						end
					end
				else
					global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
					global.Stop(_env)
				end
			end)
			exec["@time"]({
				4066
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.DmgRateFactor2,
					0
				})
				local result = global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					500
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)
			exec["@time"]({
				4950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
