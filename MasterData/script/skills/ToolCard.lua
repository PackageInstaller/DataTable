-- chunkname: @/tmp/or_skill/lua_compile/ToolCard.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SYJi_Normal = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				return
			end)

			return _env
		end
	}
	_M.__all__.Skill_SYJi_Unique = {
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

			_env.selectCount = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.3,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damageRadio = 3

					if global.MASTER(_env, unit) then
						-- block empty
					else
						damageRadio = damageRadio * 8
					end

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						3,
						0
					})
					local result = global.ApplyRealDamage(_env, _env.ACTOR, unit, 2, 1, damageRadio, 0, 0, damage)
				end
			end)
			exec["@time"]({
				1433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
				global.AddAnim(_env, {
					loop = 1,
					anim = "cisha_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.ACTOR)
				})
				global.RelocateExtraCard(_env, "hero", 15)
				global.Kick(_env, _env.ACTOR)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SYJi_Unique_Drama = {
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

			_env.selectCount = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.3,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
					local result = global.ApplyRealDamage(_env, _env.ACTOR, unit, 2, 1, this.damageRadio, 0, 0, damage)
				end
			end)
			exec["@time"]({
				1433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
				global.AddAnim(_env, {
					loop = 1,
					anim = "cisha_zhanshupai",
					zOrder = "TopLayer",
					pos = global.UnitPos(_env, _env.ACTOR)
				})
				global.RelocateExtraCard(_env, "hero", 15)
				global.Kick(_env, _env.ACTOR)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SYJi_Passive = {
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

				if global.MASTER(_env, _env.ACTOR) then
					global.SetHSVColor(_env, _env.ACTOR, -112, 0, 0, 0)
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
				local buffeft1 = global.PassiveFunEffectBuff(_env, "KickSYJi", {})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft1
				})
			end)

			return _env
		end,
		passive4 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Sound(_env, "Se_Skill_XGGun_Explode", 1)
			end)
			exec["@time"]({
				200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					global.AddAnim(_env, {
						loop = 1,
						anim = "cisha_zhanshupai",
						zOrder = "TopLayer",
						pos = global.UnitPos(_env, _env.ACTOR)
					})
					global.RelocateExtraCard(_env, "hero", 15)
				end
			end)

			return _env
		end
	}
	_M.__all__.KickSYJi = {
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

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.MARKED(_env, "SYJi")(_env, _env.unit) then
					global.RelocateExtraCard(_env, "hero", 15)
				end
			end)

			return _env
		end
	}
	_M.__all__.ToolCard_QHDeng = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.isLeft = externs.isLeft

			assert(_env.isLeft ~= nil, "External variable `isLeft` is not provided.")

			_env.cellId = externs.cellId

			assert(_env.cellId ~= nil, "External variable `cellId` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buff = global.SpecialNumericEffect(_env, "+Light_buff", {
					"?Normal"
				}, 1)
				local trap_lighton = global.BuffTrap(_env, {
					timing = 2,
					duration = 1,
					tags = {
						"LIGHTON"
					}
				}, {
					buff
				})
				local units = _env.isLeft and global.FriendCells(_env, global.CELL_IN_POS(_env, _env.cellId)) or global.EnemyCells(_env, global.CELL_IN_POS(_env, _env.cellId))

				if global.SelectBuffCount(_env, global.EnemyField(_env), global.BUFF_MARKED_ALL(_env, "BOSS_CHANGE")) > 0 then
					if global.SelectTrapCount(_env, units[1], global.BUFF_MARKED(_env, "LIGHTON")) > 0 then
						global.Sound(_env, "Se_Skill_Light_2", 1)
						global.DispelBuffTrap(_env, units[1], global.BUFF_MARKED(_env, "LIGHTON"))

						if global.GetCellUnit(_env, units[1]) then
							local buffeft1 = global.SpecialNumericEffect(_env, "+Shader_Black", {
								"?Normal"
							}, 1)

							global.ApplyBuff(_env, global.GetCellUnit(_env, units[1]), {
								timing = 0,
								duration = 99,
								display = "Shader_Black",
								tags = {
									"LIGHTSHADER",
									"UNSTEALABLE",
									"UNDISPELLABLE"
								}
							}, {
								buffeft1
							})
						end
					else
						global.Sound(_env, "Se_Skill_Light_1", 1)
						global.ApplyTrap(_env, units[1], {
							display = "Light_lan",
							duration = 99,
							triggerLife = 99,
							tags = {
								"LIGHTON"
							}
						}, {
							trap_lighton
						})

						if global.GetCellUnit(_env, units[1]) then
							global.DispelBuff(_env, global.GetCellUnit(_env, units[1]), global.BUFF_MARKED_ALL(_env, "LIGHTSHADER"), 99)
						end
					end
				elseif global.SelectTrapCount(_env, units[1], global.BUFF_MARKED(_env, "LIGHTON")) > 0 then
					global.Sound(_env, "Se_Skill_Light_2", 1)
					global.DispelBuffTrap(_env, units[1], global.BUFF_MARKED(_env, "LIGHTON"))

					if global.GetCellUnit(_env, units[1]) then
						local buffeft1 = global.SpecialNumericEffect(_env, "+Shader_Black", {
							"?Normal"
						}, 1)

						global.ApplyBuff(_env, global.GetCellUnit(_env, units[1]), {
							timing = 0,
							duration = 99,
							display = "Shader_Black",
							tags = {
								"LIGHTSHADER",
								"UNSTEALABLE",
								"UNDISPELLABLE"
							}
						}, {
							buffeft1
						})
					end
				else
					global.Sound(_env, "Se_Skill_Light_1", 1)
					global.ApplyTrap(_env, units[1], {
						display = "Light_cheng",
						duration = 99,
						triggerLife = 99,
						tags = {
							"LIGHTON"
						}
					}, {
						trap_lighton
					})

					if global.GetCellUnit(_env, units[1]) then
						global.DispelBuff(_env, global.GetCellUnit(_env, units[1]), global.BUFF_MARKED_ALL(_env, "LIGHTSHADER"), 99)
					end
				end

				global.RelocateExtraCard(_env, "skill", 8)
			end)

			return _env
		end
	}
	_M.__all__.ToolCard_LZHua = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.isLeft = externs.isLeft

			assert(_env.isLeft ~= nil, "External variable `isLeft` is not provided.")

			_env.cellId = externs.cellId

			assert(_env.cellId ~= nil, "External variable `cellId` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local units, selectUnit

				selectUnit = global.GetCellUnit(_env, (_env.isLeft and global.FriendCells(_env, global.CELL_IN_POS(_env, _env.cellId)) or global.EnemyCells(_env, global.CELL_IN_POS(_env, _env.cellId)))[1])

				if selectUnit and global.MASTER(_env, selectUnit) == false then
					local buff = global.SpecialNumericEffect(_env, "+Liangzi_buff", {
						"?Normal"
					}, 1)

					global.ApplyBuff(_env, selectUnit, {
						timing = 4,
						duration = 9999,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"LIANGZIHUA_FLAG"
						}
					}, {
						buff
					})

					if global.SelectBuffCount(_env, selectUnit, global.BUFF_MARKED_ALL(_env, "LIANGZIHUA")) == 0 then
						global.Sound(_env, "Se_Alert_Normal_Egg", 1)

						local buffeft1 = global.Mute(_env)

						global.ApplyBuff(_env, selectUnit, {
							timing = 4,
							duration = 10,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"LIANGZIHUA"
							}
						}, {
							buffeft1
						})

						local buffeft2 = global.Stealth(_env, 0.2)

						global.ApplyBuff(_env, selectUnit, {
							timing = 4,
							duration = 10,
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"UNDISPELLABLE",
								"STEALTH",
								"UNSTEALABLE",
								"LIANGZIHUA"
							}
						}, {
							buffeft2
						})

						local buffeft3 = global.Immune(_env)

						global.ApplyBuff(_env, selectUnit, {
							timing = 4,
							duration = 10,
							tags = {
								"UNDISPELLABLE",
								"UNSTEALABLE",
								"Invisible_Immune",
								"LIANGZIHUA"
							}
						}, {
							buffeft3
						})
						global.DispelBuff(_env, selectUnit, global.BUFF_MARKED_ALL(_env, "RANGE_LZHua"), 99)
					end

					global.RelocateExtraCard(_env, "skill", 5)
				else
					global.RelocateExtraCard(_env, "skill", 5)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LZHua_Passive = {
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

				if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "LIANGZIHUA")) == 0 and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "LIANGZIHUA_FLAG")) > 0 then
					global.ActivateSpecificTrigger(_env, _env.unit, "PRE_ENTER", {
						isRevive = false
					})
					global.ActivateSpecificTrigger(_env, _env.unit, "ENTER", {
						isRevive = false
					})
					global.ActivateGlobalTrigger(_env, _env.unit, "UNIT_ENTER", {
						isRevive = false
					})
					global.ApplyRPRecovery(_env, _env.unit, 10000)
					global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "LIANGZIHUA_FLAG"), 99)
					global.ApplyBuff(_env, global.selectUnit, {
						timing = 4,
						duration = 10,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"Invisible_Immune",
							"LIANGZIHUA"
						}
					}, {
						global.buffeft3
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Range", {
					"?Normal"
				}, 0)

				if global.MASTER(_env, _env.unit) then
					-- block empty
				else
					global.ApplyBuff(_env, _env.unit, {
						timing = 4,
						duration = 99999,
						tags = {
							"RANGE_LZHua"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end,
		passive3 = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.AllUnits(_env, global.PETS)

				local buffeft1 = global.SpecialNumericEffect(_env, "+Range", {
					"?Normal"
				}, 0)

				for _, unit in global.__iter__(_env.units) do
					global.ApplyBuff(_env, unit, {
						timing = 4,
						duration = 99999,
						tags = {
							"RANGE_LZHua"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.FZhou_Switch = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.isLeft = externs.isLeft

			assert(_env.isLeft ~= nil, "External variable `isLeft` is not provided.")

			_env.cellId = externs.cellId

			assert(_env.cellId ~= nil, "External variable `cellId` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Sound(_env, "Se_Skill_FZhou_Squat", 1)

				local buff = global.SpecialNumericEffect(_env, "+FZhou_Buff", {
					"?Normal"
				}, 1)
				local FZhou_Kira = global.BuffTrap(_env, {
					timing = 0,
					duration = 99,
					tags = {
						"GXIANG",
						"UNSTEALABLE",
						"UNDISPELLABLE"
					}
				}, {
					buff
				})
				local units

				if _env.isLeft and global.EnemyMaster(_env) then
					local cell = global.GetCellById(_env, _env.cellId, global.GetSide(_env, global.EnemyMaster(_env)))

					if global.SelectTrapCount(_env, cell, global.BUFF_MARKED(_env, "GXIANG")) > 0 then
						global.DispelBuffTrap(_env, cell, global.BUFF_MARKED(_env, "GXIANG"))
					else
						global.ApplyTrap(_env, cell, {
							display = "Guaxiang",
							duration = 99,
							triggerLife = 99,
							tags = {
								"GXIANG",
								"UNSTEALABLE",
								"UNDISPELLABLE"
							}
						}, {
							FZhou_Kira
						})
					end

					if global.FriendMaster(_env) and global.EnemyMaster(_env) then
						if global.SelectTrapCount(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 2, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 3, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 4, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 5, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 6, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 7, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 8, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 9, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 then
							for _, unit in global.__iter__(global.FriendUnits(_env)) do
								global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "GXIANG_EFFECT"))
							end

							global.DispelBuffTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANGBIAOXIAN"))
							global.DispelBuff(_env, global.EnemyMaster(_env), global.BUFF_MARKED(_env, "FZhou_Passive"))
							global.DelayCall(_env, 300, global.FZhou_Qian, this.HurtRateFactor)
						elseif global.SelectTrapCount(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 2, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 3, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 4, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 5, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) == 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 6, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 7, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 8, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 9, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 then
							for _, unit in global.__iter__(global.FriendUnits(_env)) do
								global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "GXIANG_EFFECT"))
							end

							global.DispelBuffTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANGBIAOXIAN"))
							global.DispelBuff(_env, global.EnemyMaster(_env), global.BUFF_MARKED(_env, "FZhou_Passive"))
							global.DelayCall(_env, 300, global.FZhou_Li, this.RageSpdFactor)
						elseif global.SelectTrapCount(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 2, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 3, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 4, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) == 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 5, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 6, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) == 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 7, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 8, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 and global.SelectTrapCount(_env, global.GetCellById(_env, 9, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANG")) > 0 then
							for _, unit in global.__iter__(global.FriendUnits(_env)) do
								global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "GXIANG_EFFECT"))
							end

							global.DispelBuffTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANGBIAOXIAN"))
							global.DispelBuff(_env, global.EnemyMaster(_env), global.BUFF_MARKED(_env, "FZhou_Passive"))
							global.DelayCall(_env, 300, global.FZhou_Kan)
						else
							for _, unit in global.__iter__(global.FriendUnits(_env)) do
								global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "GXIANG_EFFECT"))
							end

							global.DispelBuff(_env, global.EnemyMaster(_env), global.BUFF_MARKED(_env, "FZhou_Passive"))
							global.DispelBuffTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), global.BUFF_MARKED(_env, "GXIANGBIAOXIAN"))
						end
					end
				end

				global.RelocateExtraCard(_env, "skill", 5)
			end)

			return _env
		end
	}

	function _M.__all__.FZhou_Qian(_env, HurtRateFactor)
		local this, global = _env.this, _env.global
		local units = global.FriendUnits(_env)
		local Qian_Passive = global.PassiveFunEffectBuff(_env, "FZhou_Qian_Passive", {
			HurtRateFactor = HurtRateFactor
		})
		local buffeft = global.NumericEffect(_env, "+hurtrate", {
			"+Normal",
			"+Normal"
		}, HurtRateFactor)
		local buff = global.SpecialNumericEffect(_env, "+biaoxian", {
			"?Normal"
		}, 0)
		local biaoxian = global.BuffTrap(_env, {
			timing = 0,
			duration = 99,
			tags = {
				"GXIANGBIAOXIAN"
			}
		}, {
			buff
		})

		if global.FriendMaster(_env) then
			global.ApplyTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), {
				display = "Qian",
				duration = 99,
				triggerLife = 99,
				tags = {
					"GXIANGBIAOXIAN"
				}
			}, {
				biaoxian
			})
		end

		if global.EnemyMaster(_env) then
			global.ApplyBuff_Buff(_env, _env.ACTOR, global.EnemyMaster(_env), {
				duration = 99,
				group = "FZhou_Li_Passive",
				timing = 0,
				limit = 1,
				tags = {
					"FZhou_Passive",
					"FZhou_Qian",
					"UNDISPELLABLE",
					"UNSTEALABLE",
					"GXIANG_EFFECT"
				}
			}, {
				Qian_Passive
			}, 1, 0)

			for _, unit in global.__iter__(units) do
				global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
					timing = 0,
					display = "HurtUp",
					group = "FZhou_Qian",
					duration = 99,
					limit = 1,
					tags = {
						"FZhou_Qian",
						"GXIANG_EFFECT",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft
				}, 1, 0)
			end
		end
	end

	_M.__all__.FZhou_Qian_Passive = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.NumericEffect(_env, "+hurtrate", {
					"+Normal",
					"+Normal"
				}, this.HurtRateFactor)

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "HurtUp",
						group = "FZhou_Qian",
						duration = 99,
						limit = 1,
						tags = {
							"FZhou_Qian",
							"GXIANG_EFFECT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	function _M.__all__.FZhou_Li(_env, RageSpdFactor)
		local this, global = _env.this, _env.global
		local units = global.FriendUnits(_env)
		local Li_Passive = global.PassiveFunEffectBuff(_env, "FZhou_Li_Passive", {
			RageSpdFactor = RageSpdFactor
		})
		local buffeft = global.RageGainEffect(_env, "+", {
			"+Normal",
			"+Normal"
		}, RageSpdFactor)
		local buff = global.SpecialNumericEffect(_env, "+biaoxian", {
			"?Normal"
		}, 0)
		local biaoxian = global.BuffTrap(_env, {
			timing = 0,
			duration = 99,
			tags = {
				"GXIANGBIAOXIAN"
			}
		}, {
			buff
		})

		if global.FriendMaster(_env) then
			global.ApplyTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), {
				display = "Li",
				duration = 99,
				triggerLife = 99,
				tags = {
					"GXIANGBIAOXIAN"
				}
			}, {
				biaoxian
			})
		end

		if global.EnemyMaster(_env) then
			global.ApplyBuff(_env, global.EnemyMaster(_env), {
				duration = 99,
				group = "FZhou_Li_Passive",
				timing = 0,
				limit = 1,
				tags = {
					"FZhou_Passive",
					"FZhou_Li",
					"UNDISPELLABLE",
					"UNSTEALABLE"
				}
			}, {
				Li_Passive
			})

			for _, unit in global.__iter__(units) do
				if global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ALL(_env, "AnaFlagCheck")) == 0 then
					global.ApplyBuff(_env, unit, {
						timing = 0,
						display = "RageGainUp",
						group = "ToolCard_FZhou_Li",
						duration = 99,
						limit = 1,
						tags = {
							"FZhou_Li",
							"GXIANG_EFFECT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end
		end
	end

	_M.__all__.FZhou_Li_Passive = {
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft = global.RageGainEffect(_env, "+", {
					"+Normal",
					"+Normal"
				}, this.RageSpdFactor)

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "AnaFlagCheck")) == 0 then
					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "RageGainUp",
						group = "ToolCard_FZhou_Li",
						duration = 99,
						limit = 1,
						tags = {
							"FZhou_Li",
							"GXIANG_EFFECT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	function _M.__all__.FZhou_Kan(_env)
		local this, global = _env.this, _env.global

		for _, unit in global.__iter__(global.FriendUnits(_env)) do
			global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF"), 99)
		end

		for _, unit in global.__iter__(global.EnemyUnits(_env)) do
			global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "BUFF"), 99)
		end

		local Kan_Passive = global.PassiveFunEffectBuff(_env, "FZhou_Kan_Passive")

		global.ApplyBuff(_env, global.EnemyMaster(_env), {
			duration = 99,
			group = "FZhou_Kan_Passive",
			timing = 0,
			limit = 1,
			tags = {
				"FZhou_Passive",
				"FZhou_Kan",
				"UNDISPELLABLE",
				"UNSTEALABLE"
			}
		}, {
			Kan_Passive
		})

		local buff = global.SpecialNumericEffect(_env, "+biaoxian", {
			"?Normal"
		}, 0)
		local biaoxian1 = global.BuffTrap(_env, {
			timing = 0,
			duration = 99,
			tags = {
				"GXIANGBIAOXIAN"
			}
		}, {
			buff
		})

		if global.FriendMaster(_env) then
			global.ApplyTrap(_env, global.GetCellById(_env, 1, global.GetSide(_env, global.FriendMaster(_env))), {
				display = "Kan",
				duration = 99,
				triggerLife = 99,
				tags = {
					"GXIANGBIAOXIAN"
				}
			}, {
				biaoxian1
			})
		end

		local biaoxian = global.SpecialNumericEffect(_env, "+fzhou_kan", {
			"?Normal"
		}, 1)

		for _, unit in global.__iter__(global.EnemyUnits(_env)) do
			global.ApplyBuff(_env, unit, {
				timing = 2,
				display = "BuffWeaken",
				group = "FZhou_Kan_Xuruo",
				duration = 1,
				limit = 99,
				tags = {
					"FZhou_Kan",
					"GXIANG_EFFECT",
					"UNDISPELLABLE",
					"UNSTEALABLE"
				}
			}, {
				biaoxian
			})
		end

		for _, unit in global.__iter__(global.FriendUnits(_env)) do
			global.ApplyBuff(_env, unit, {
				timing = 2,
				display = "Purify",
				group = "FZhou_Kan_Jinghua",
				duration = 1,
				limit = 99,
				tags = {
					"FZhou_Kan",
					"GXIANG_EFFECT",
					"UNDISPELLABLE",
					"UNSTEALABLE"
				}
			}, {
				biaoxian
			})
		end
	end

	_M.__all__.FZhou_Kan_Passive = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "BUFF") then
					local xuruo = global.SpecialNumericEffect(_env, "+xuruo", {
						"?Normal"
					}, 1)

					if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "BUFF"), 99)
						global.ApplyBuff(_env, _env.unit, {
							timing = 2,
							display = "BuffWeaken",
							group = "FZhou_Kan_Xuruo",
							duration = 1,
							limit = 99,
							tags = {
								"FZhou_Passive",
								"FZhou_Kan",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							xuruo
						})
					end
				end

				if global.BuffIsMatched(_env, _env.buff, "DEBUFF") then
					local jinghua = global.SpecialNumericEffect(_env, "+jinghua", {
						"?Normal"
					}, 1)

					if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
						global.DispelBuff(_env, _env.unit, global.BUFF_MARKED_ALL(_env, "DEBUFF"), 99)
						global.ApplyBuff(_env, _env.unit, {
							timing = 2,
							display = "Purify",
							group = "FZhou_Kan_Jinghua",
							duration = 1,
							limit = 99,
							tags = {
								"FZhou_Passive",
								"FZhou_Kan",
								"UNDISPELLABLE",
								"UNSTEALABLE"
							}
						}, {
							jinghua
						})
					end
				end
			end)

			return _env
		end
	}

	return _M
end
