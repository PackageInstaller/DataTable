-- chunkname: @/tmp/or_skill/lua_compile/Skill_YBYa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YBYa_Normal = {
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
					-1.9,
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

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				733
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Unique = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2833
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15008_biaozhi")) > 0 then
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa_Qiannian", {
						0,
						2.5,
						0
					}, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa_Qiannian")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				else
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Passive = {
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
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_YBYa_Passive",
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
	_M.__all__.Skill_YBYa_Passive_Key = {
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
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_YBYa_Passive_Key",
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
	_M.__all__.Skill_YBYa_Passive_Awaken = {
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
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_YBYa_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
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

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.SUMMONS(_env, _env.unit) and _env.units[1] then
					for _, enemy in global.__iter__(_env.units) do
						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, enemy, {
							1,
							this.DmgFactor,
							0
						})

						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, enemy, damage)
						global.AddAnim(_env, {
							loop = 1,
							anim = "cisha_zhanshupai",
							zOrder = "TopLayer",
							pos = global.UnitPos(_env, enemy)
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Passive_Key = {
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

				if global.MARKED(_env, "YBYa")(_env, _env.ACTOR) then
					global.AddStatus(_env, _env.ACTOR, "Skill_YBYa_Passive_Key")
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Redfox_Normal = {
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
					-1.9,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Redfox_Proud = {
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
					-1.9,
					0
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Redfox_Passive_Death = {
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

				_env.units = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env), "<", global.UnitPropGetter(_env, "hpRatio")), 1, 1)

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						global.AssignRoles(_env, unit, "target")
					end
				end
			end)
			exec["@time"]({
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.units[1] then
					for _, unit in global.__iter__(_env.units) do
						local DmgRateFactor = global.SpecialPropGetter(_env, "Skill_YBYa_Passive")(_env, _env.ACTOR)

						if DmgRateFactor == 0 then
							local MyMaster = global.GetSummoner(_env, _env.ACTOR)

							if MyMaster then
								DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, MyMaster)
							end
						end

						global.print(_env, DmgRateFactor, "DmgRateFactor=====")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
							1,
							DmgRateFactor,
							0
						})

						global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.AddAnim(_env, {
							loop = 1,
							anim = "cisha_zhanshupai",
							zOrder = "TopLayer",
							pos = global.UnitPos(_env, unit)
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				733
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				1250
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
					1,
					0,
					1
				}, {
					2,
					1,
					3,
					5,
					4,
					6,
					7,
					8,
					9
				})

				if SummonedYBYa then
					global.AddStatus(_env, SummonedYBYa, "SummonedYBYa")

					local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
					local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
						"?Normal"
					}, DmgRateFactor)

					global.ApplyBuff(_env, SummonedYBYa, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"NUMERIC",
							"Skill_YBYa_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Unique_EX = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2833
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15008_biaozhi")) > 0 then
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa_Qiannian", {
						0,
						2.5,
						0
					}, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa_Qianian")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				else
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Passive_EX = {
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
				local buffeft2 = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"Skill_YBYa_Passive_EX",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_YBYa_Unique_SelfAwaken = {
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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				2833
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.Diligent(_env)

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "EquipSkill_Weapon_15008_biaozhi")) > 0 then
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa_Qiannian", {
						0,
						2.5,
						0
					}, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa_Qianian")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end
				else
					local SummonedYBYa = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa then
						global.AddStatus(_env, SummonedYBYa, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					local SummonedYBYa1 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa1 then
						global.AddStatus(_env, SummonedYBYa1, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa1, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buff
						})
					end

					local SummonedYBYa2 = global.Summon(_env, _env.ACTOR, "SummonedYBYa", this.summonFactor, {
						1,
						0,
						1
					}, {
						2,
						1,
						3,
						5,
						4,
						6,
						7,
						8,
						9
					})

					if SummonedYBYa2 then
						global.AddStatus(_env, SummonedYBYa2, "SummonedYBYa")

						local DmgRateFactor = global.SpecialPropGetter(_env, "specialnum1")(_env, _env.ACTOR)
						local buffeft1 = global.SpecialNumericEffect(_env, "+Skill_YBYa_Passive", {
							"?Normal"
						}, DmgRateFactor)

						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"Skill_YBYa_Passive",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						})
						global.ApplyBuff(_env, SummonedYBYa2, {
							timing = 2,
							duration = 1,
							tags = {
								"STATUS",
								"DILIGENT",
								"Skill_YBYa_Passive_Awaken",
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.INSTATUS(_env, "SummonedYBYa")(_env, _env.unit) then
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
