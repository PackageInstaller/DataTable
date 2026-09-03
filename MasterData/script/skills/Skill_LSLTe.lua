-- chunkname: @/tmp/or_skill/lua_compile/Skill_LSLTe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__

	function _M.__all__.Aien_Circle(_env, target)
		local this, global = _env.this, _env.global
		local buff_count = global.SpecialNumericEffect(_env, "+Count_LSLTe_Passive", {
			"+Normal",
			"+Normal"
		}, 1)

		global.ApplyBuff(_env, target, {
			timing = 0,
			duration = 99,
			tags = {
				"Count_LSLTe_Passive"
			}
		}, {
			buff_count
		})
		global.ActivateSpecificTrigger(_env, target, "GET_AIEN_CIRCLE")
		global.ActivateGlobalTrigger(_env, target, "UNIT_GET_AIEN_CIRCLE")
	end

	_M.__all__.Skill_LSLTe_Normal = {
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
				534
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.Aien_Circle(_env, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Proud = {
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
				}, 100, "skill2"))
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
				global.Aien_Circle(_env, _env.TARGET)
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.Aien_Circle(_env, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ani = global.CellRowLocation(_env, global.GetCell(_env, _env.TARGET)) == 1 and "skill3_3" or global.CellRowLocation(_env, global.GetCell(_env, _env.TARGET)) == 2 and "skill3_2" or "skill3_1"
				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.5,
					0
				}, 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, ani)), false)
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1233
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
				global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.dmgFactor1,
					0
				})

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, _env.TARGET) and global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
					local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
					local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)

					dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

					if global.MARKED(_env, "LEIMu")(_env, _env.TARGET) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
						if global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
							local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
							local shield = global.UnitPropGetter(_env, "shield")(_env, _env.TARGET)

							if dmg > hp + shield then
								dmg = 0

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyBuff(_env, _env.TARGET, {
									timing = 0,
									duration = 99,
									tags = {
										"LEIMu_Passive_Done"
									}
								}, {
									buff
								})
							end
						end
					else
						global.ApplyHPDamage(_env, _env.TARGET, dmg)
					end
				end

				global.Aien_Circle(_env, _env.TARGET)
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local run = global.Animation(_env, "skill4", 1, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				} + {
					0.5,
					0
				}, 1, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill4", nil, 2)), false)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1633
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.dmgFactor2,
						0
					})

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
						local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
						local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, unit)

						dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

						if global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
							if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
								local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
								local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

								if dmg > hp + shield then
									dmg = 0

									local buff = global.NumericEffect(_env, "+def", {
										"+Normal",
										"+Normal"
									}, 0)

									global.ApplyBuff(_env, unit, {
										timing = 0,
										duration = 99,
										tags = {
											"LEIMu_Passive_Done"
										}
									}, {
										buff
									})
								end
							end
						else
							global.ApplyHPDamage(_env, unit, dmg)
						end
					end

					global.Aien_Circle(_env, unit)
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ani = global.CellColLocation(_env, global.GetCell(_env, _env.TARGET)) == 1 and "skill5_1" or global.CellColLocation(_env, global.GetCell(_env, _env.TARGET)) == 2 and "skill5_2" or "skill5_3"
				local run = global.Animation(_env, ani, 1, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				} + {
					0.5,
					0
				}, 1, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, ani, nil, 2)))

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.18, 20)
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.dmgFactor3,
						0
					})

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
						local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
						local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, unit)

						dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

						if global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
							if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
								local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
								local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

								if dmg > hp + shield then
									dmg = 0

									local buff = global.NumericEffect(_env, "+def", {
										"+Normal",
										"+Normal"
									}, 0)

									global.ApplyBuff(_env, unit, {
										timing = 0,
										duration = 99,
										tags = {
											"LEIMu_Passive_Done"
										}
									}, {
										buff
									})
								end
							end
						else
							global.ApplyHPDamage(_env, unit, dmg)
						end
					end

					global.Aien_Circle(_env, unit)
				end
			end)
			exec["@time"]({
				3900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Passive = {
		__new__ = function(prototype, externs, global)
			return
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
				local delaytime = 350

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 1 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_1",
							tags = {
								"LSLTe_Passive_1"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 2 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_2",
							tags = {
								"LSLTe_Passive_2"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 3 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_3",
							tags = {
								"LSLTe_Passive_3"
							}
						}, {
							buff
						})
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)
						global.DelayCall(_env, delaytime, global.ApplyRealDamage, _env.ACTOR, _env.unit, 1, 1, this.DamageFactor)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
						global.DelayCall(_env, delaytime, global.AnimForTrgt, _env.unit, {
							loop = 1,
							anim = "baozha_weienbaodian",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Proud_EX = {
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
				}, 100, "skill2"))
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
				global.Aien_Circle(_env, _env.TARGET)
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.Aien_Circle(_env, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Unique_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ani = global.CellRowLocation(_env, global.GetCell(_env, _env.TARGET)) == 1 and "skill3_3" or global.CellRowLocation(_env, global.GetCell(_env, _env.TARGET)) == 2 and "skill3_2" or "skill3_1"
				local run = global.Animation(_env, "run", 100, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) + {
					-1,
					0
				}, 100, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, ani)), false)
				global.AssignRoles(_env, _env.TARGET, "target")
				global.HarmTargetView(_env, {
					_env.TARGET
				})
			end)
			exec["@time"]({
				1233
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)
				global.DispelBuff(_env, _env.TARGET, global.BUFF_MARKED_ALL(_env, "IMMUNE", "DISPELLABLE"), 99)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, {
					1,
					this.dmgFactor1,
					0
				})

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, _env.TARGET) and global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
					local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
					local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)

					dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

					if global.MARKED(_env, "LEIMu")(_env, _env.TARGET) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
						if global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
							local hp = global.UnitPropGetter(_env, "hp")(_env, _env.TARGET)
							local shield = global.UnitPropGetter(_env, "shield")(_env, _env.TARGET)

							if dmg > hp + shield then
								dmg = 0

								local buff = global.NumericEffect(_env, "+def", {
									"+Normal",
									"+Normal"
								}, 0)

								global.ApplyBuff(_env, _env.TARGET, {
									timing = 0,
									duration = 99,
									tags = {
										"LEIMu_Passive_Done"
									}
								}, {
									buff
								})
							end
						end
					else
						global.ApplyHPDamage(_env, _env.TARGET, dmg)
					end
				end

				global.Aien_Circle(_env, _env.TARGET)
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local run = global.Animation(_env, "skill4", 1, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				} + {
					0,
					0
				}, 1, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, "skill4", nil, 2)), false)

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.AssignRoles(_env, unit, "target")
				end

				global.DelayCall(_env, 200, global.ShakeScreen, {
					Id = 3,
					duration = 20,
					enhance = 3
				})
				global.DelayCall(_env, 533, global.ShakeScreen, {
					Id = 3,
					duration = 20,
					enhance = 3
				})
			end)
			exec["@time"]({
				1633
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.dmgFactor2,
						0
					})

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
						local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
						local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, unit)

						dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

						if global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
							if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
								local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
								local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

								if dmg > hp + shield then
									dmg = 0

									local buff = global.NumericEffect(_env, "+def", {
										"+Normal",
										"+Normal"
									}, 0)

									global.ApplyBuff(_env, unit, {
										timing = 0,
										duration = 99,
										tags = {
											"LEIMu_Passive_Done"
										}
									}, {
										buff
									})
								end
							end
						else
							global.ApplyHPDamage(_env, unit, dmg)
						end
					end

					global.Aien_Circle(_env, unit)
				end
			end)
			exec["@time"]({
				2500
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local ani = global.CellColLocation(_env, global.GetCell(_env, _env.TARGET)) == 1 and "skill5_1" or global.CellColLocation(_env, global.GetCell(_env, _env.TARGET)) == 2 and "skill5_2" or "skill5_3"
				local run = global.Animation(_env, ani, 1, nil, -1)

				run = global.MoveTo(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				} + {
					0,
					0
				}, 1, run)

				global.Perform(_env, _env.ACTOR, global.Sequence(_env, run, global.Animation(_env, ani, nil, 2)))

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.FocusCamera(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.15, 20)
				global.DelayCall(_env, 5, global.ShakeScreen, {
					Id = 3,
					duration = 30,
					enhance = 5
				})
			end)
			exec["@time"]({
				3300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.dmgFactor3,
						0
					})

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if global.SelectHeroPassiveCount(_env, _env.ACTOR, "EquipSkill_Weapon_15129_2") > 0 and not global.MASTER(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "GUIDIE_SHENYIN")) == 0 then
						local MHDmgFactor = global.SpecialPropGetter(_env, "weapon_15129_2_flag")(_env, _env.ACTOR)
						local dmg = MHDmgFactor * global.UnitPropGetter(_env, "maxHp")(_env, unit)

						dmg = global.min(_env, dmg, 0.8 * global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR))

						if global.MARKED(_env, "LEIMu")(_env, unit) and global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED(_env, "LEIMu_Passive")) == 0 then
							if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "IMMUNE")) == 0 and global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "UNDEAD")) == 0 then
								local hp = global.UnitPropGetter(_env, "hp")(_env, unit)
								local shield = global.UnitPropGetter(_env, "shield")(_env, unit)

								if dmg > hp + shield then
									dmg = 0

									local buff = global.NumericEffect(_env, "+def", {
										"+Normal",
										"+Normal"
									}, 0)

									global.ApplyBuff(_env, unit, {
										timing = 0,
										duration = 99,
										tags = {
											"LEIMu_Passive_Done"
										}
									}, {
										buff
									})
								end
							end
						else
							global.ApplyHPDamage(_env, unit, dmg)
						end
					end

					global.Aien_Circle(_env, unit)
				end
			end)
			exec["@time"]({
				3900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Passive_EX = {
		__new__ = function(prototype, externs, global)
			return
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
				local delaytime = 350

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 1 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_1",
							tags = {
								"LSLTe_Passive_1"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 2 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_2",
							tags = {
								"LSLTe_Passive_2"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 3 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_3",
							tags = {
								"LSLTe_Passive_3"
							}
						}, {
							buff
						})
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)
						global.DelayCall(_env, delaytime, global.ApplyRealDamage, _env.ACTOR, _env.unit, 1, 1, this.DamageFactor)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
						global.DelayCall(_env, delaytime, global.AnimForTrgt, _env.unit, {
							loop = 1,
							anim = "baozha_weienbaodian",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LSLTe_Passive_Awaken = {
		__new__ = function(prototype, externs, global)
			return
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
				local delaytime = 350

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 1 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_1",
							tags = {
								"LSLTe_Passive_1"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 2 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_2",
							tags = {
								"LSLTe_Passive_2"
							}
						}, {
							buff
						})
					elseif global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive")) == 3 then
						local buff = global.NumericEffect(_env, "+defrate", {
							"+Normal",
							"+Normal"
						}, 0)

						global.ApplyBuff(_env, _env.unit, {
							timing = 0,
							duration = 99,
							display = "LSLTe_Circle_3",
							tags = {
								"LSLTe_Passive_3"
							}
						}, {
							buff
						})
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)

						local buffeft1 = global.NumericEffect(_env, "+exskillrate", {
							"+Normal",
							"+Normal"
						}, this.ExSkillRateFactor)

						global.ApplyBuff_Buff(_env, _env.ACTOR, _env.ACTOR, {
							timing = 0,
							display = "SkillRateUp",
							group = "Skill_AEn_Passive_2",
							duration = 99,
							limit = 5,
							tags = {
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							buffeft1
						}, 1, 0)
						global.DelayCall(_env, delaytime, global.ApplyRealDamage, _env.ACTOR, _env.unit, 1, 1, this.DamageFactor)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
						global.DelayCall(_env, delaytime, global.DispelBuff, _env.unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
						global.DelayCall(_env, delaytime, global.AnimForTrgt, _env.unit, {
							loop = 1,
							anim = "baozha_weienbaodian",
							zOrder = "TopLayer",
							pos = {
								0.5,
								0.5
							}
						})
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Count_LSLTe_Passive"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_1"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_2"), 99)
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "LSLTe_Passive_3"), 99)
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				30
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local unit_min = global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env, global.PETS - global.MARKED(_env, "SummonedNian")), "<", global.UnitPropGetter(_env, "hp")), 1, 1)

				if unit_min[1] then
					global.AnimForTrgt(_env, unit_min[1], {
						loop = 1,
						anim = "baodian_shoujibaodian",
						zOrder = "TopLayer",
						pos = {
							0.5,
							0.5
						}
					})
					global.ApplyHPDamage(_env, unit_min[1], 0)
					global.Aien_Circle(_env, unit_min[1])
				end
			end)

			return _env
		end
	}

	return _M
end
