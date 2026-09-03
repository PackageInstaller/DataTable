-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_YDYuan.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_Enemy_YDYuan_Normal = {
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

			_env.TargetFactor = externs.TargetFactor

			if _env.TargetFactor == nil then
				_env.TargetFactor = global.Random(_env, 0, 100)
			end

			_env.count = externs.count

			if _env.count == nil then
				_env.count = 0
			end

			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.AddStatus(_env, _env.ACTOR, "YDYuan_In_Normal")

				for _, enemyunit in global.__iter__(global.EnemyUnits(_env)) do
					if global.SelectBuffCount(_env, enemyunit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
						_env.count = _env.count + 1
					end
				end

				if _env.count == 0 then
					if _env.TargetFactor < 33 then
						_env.TargetFactor = 1
					elseif _env.TargetFactor > 33 and _env.TargetFactor < 66 then
						_env.TargetFactor = 2
					elseif _env.TargetFactor > 66 then
						_env.TargetFactor = 3
					end

					global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill1"))

					if global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor)) or global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor + 3)) or global.GetCellUnit(_env, global.GetCellById(_env, _env.TargetFactor + 6)) then
						if _env.TargetFactor == 1 then
							_env.units = global.EnemyUnits(_env, global.TOP_COL)
						elseif _env.TargetFactor == 2 then
							_env.units = global.EnemyUnits(_env, global.MID_COL)
						elseif _env.TargetFactor == 3 then
							_env.units = global.EnemyUnits(_env, global.BOTTOM_COL)
						end
					else
						_env.TargetFactor = 2
						_env.units = global.EnemyUnits(_env, global.MID_COL)
					end
				elseif _env.count > 0 then
					for _, enemyunit in global.__iter__(global.EnemyUnits(_env)) do
						if global.SelectBuffCount(_env, enemyunit, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
							global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill1"))

							_env.units = global.EnemyUnits(_env, global.COL_OF(_env, enemyunit))

							break
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.count > 0 then
					if global.abs(_env, global.GetCellId(_env, _env.units[1])) == 1 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 4 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 7 then
						_env.TargetFactor = 1
					elseif global.abs(_env, global.GetCellId(_env, _env.units[1])) == 2 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 5 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 8 then
						_env.TargetFactor = 2
					elseif global.abs(_env, global.GetCellId(_env, _env.units[1])) == 3 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 6 or global.abs(_env, global.GetCellId(_env, _env.units[1])) == 9 then
						_env.TargetFactor = 3
					end
				end

				if _env.TargetFactor == 1 then
					global.SetDisplayZorder(_env, _env.ACTOR, 100000)
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							-1.5
						}
					})
				elseif _env.TargetFactor == 2 then
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							-0.2
						}
					})
				elseif _env.TargetFactor == 3 then
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "skill1_nianshoujineng",
						pos = global.UnitPos(_env, _env.ACTOR) + {
							3,
							1
						}
					})
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						1.2,
						0
					}) * global.SUMMON_damage(_env, unit)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					local extra_damage = 999

					global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, unit, 2, 1, 0, 0, 0, nil, extra_damage)
				end
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if _env.TargetFactor == 1 then
					global.ResetDisplayZorder(_env, _env.ACTOR)
				end

				global.RemoveStatus(_env, _env.ACTOR, "YDYuan_In_Normal")
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_YDYuan_Unique = {
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

				global.Perform(_env, _env.ACTOR, global.Animation(_env, "skill2"))
				global.DelayCall(_env, 900, global.ShakeScreen, {
					Id = 3,
					duration = 50,
					enhance = 8
				})
				global.DelayCall(_env, 1200, global.ShakeScreen, {
					Id = 4,
					duration = 80,
					enhance = 9
				})

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.HarmTargetView(_env, _env.units)
				global.AddStatus(_env, _env.ACTOR, "YDYuan_In_Unique")

				local unit_list = _env.units
				local damList = global.randomN_number(_env, #unit_list)
				local i = 1

				for _, unit in global.__iter__(_env.units) do
					if #_env.units >= 7 and i == 6 and #global.CardsInWindow(_env, global.GetOwner(_env, unit)) > 0 and not global.MASTER(_env, unit) then
						damList[i] = damList[i] * 1000
					end

					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						1 + damList[i],
						0
					}) * global.SUMMON_damage(_env, unit)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					i = i + 1
				end

				global.RemoveStatus(_env, _env.ACTOR, "YDYuan_In_Unique")
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "YDYuan_KillPrepare", "UNDISPELLABLE", "UNSTEALABLE")) > 0 then
					local unit_kill = {}

					if #global.EnemyUnits(_env, global.MARKED(_env, "WARRIOR")) > 0 then
						unit_kill = global.RandomN(_env, 1, global.EnemyUnits(_env, global.MARKED(_env, "WARRIOR")))
					elseif global.EnemyMaster(_env) then
						unit_kill = global.RandomN(_env, 1, global.EnemyUnits(_env, global.PETS))
					end

					unit_kill = unit_kill or {}

					if #unit_kill > 0 then
						global.AddStatus(_env, _env.ACTOR, "YDYuan_In_Kill")

						for _, unit in global.__iter__(unit_kill) do
							global.FocusCamera(_env, _env.ACTOR, global.UnitPos(_env, unit), 1.3, 100)
							global.AnimForTrgt(_env, unit, {
								loop = 1,
								anim = "baodian_shoujibaodian",
								zOrder = "TopLayer",
								pos = {
									0.5,
									0.5
								}
							})

							local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, {
								1,
								1,
								0
							}) * global.SUMMON_damage(_env, unit)

							global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
							global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "YDYuan_KillPrepare", "UNDISPELLABLE", "UNSTEALABLE"), 1)
							global.RemoveStatus(_env, _env.ACTOR, "YDYuan_In_Kill")
						end
					end
				end
			end)
			exec["@time"]({
				2480
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local str_speak = {
					"Speak_boss_nian_1",
					"Speak_boss_nian_2"
				}
				local index = global.Random(_env, #str_speak)

				global.Speak(_env, _env.ACTOR, {
					{
						str_speak[index],
						3000
					}
				}, nil, 1)
				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_YDYuan_Passive = {
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
				local NianFlag = global.SpecialNumericEffect(_env, "+nshoushou", {
					"?Normal"
				}, 1)
				local Left = global.Summon(_env, _env.ACTOR, "SummonedNian", {
					0.5,
					1,
					1
				}, nil, {
					7
				})
				local buffeft_Left_ABNORMAL = global.ImmuneBuff(_env, "ABNORMAL")

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft_Left_ABNORMAL
				})
				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"NianShou",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					NianFlag
				})
				global.MarkSummoned(_env, Left, false)
				global.setRootVisible(_env, Left, false)
				global.AddStatus(_env, Left, "SummonedNian")

				local Right = global.Summon(_env, _env.ACTOR, "SummonedNian", {
					0.5,
					1,
					1
				}, nil, {
					9
				})
				local buffeft_Right_ABNORMAL = global.ImmuneBuff(_env, "ABNORMAL")

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft_Right_ABNORMAL
				})
				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"NianShou",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					NianFlag
				})
				global.MarkSummoned(_env, Right, false)
				global.setRootVisible(_env, Right, false)
				global.AddStatus(_env, Right, "SummonedNian")

				local DazeBuff = global.Daze(_env)

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DazeBuff
				})
				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DazeBuff
				})

				local DmgTransfer = global.DamageTransferEffect(_env, _env.ACTOR, 1)

				global.ApplyBuff(_env, Left, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DmgTransfer
				})
				global.ApplyBuff(_env, Right, {
					timing = 0,
					duration = 99,
					tags = {
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					DmgTransfer
				})

				local buffeft2 = global.ImmuneBuff(_env, "ABNORMAL")

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"NUMERIC",
						"BUFF",
						"UNHURTRATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"UR_EQUIPMENT"
					}
				}, {
					buffeft2
				})

				if global.EnemyMaster(_env) then
					local def = global.UnitPropGetter(_env, "def")(_env, global.EnemyMaster(_env))
					local buff1 = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, def / 2)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						limit = 1,
						tags = {
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"YDLang"
						}
					}, {
						buff1
					})
				end
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

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.SelectBuffCount(_env, _env.unit, global.BUFF_MARKED(_env, "Skill_WorldBoss_Unique_proud")) == 0 then
					local Cells = global.EnemyCells(_env)

					for _, mycell in global.__iter__(Cells) do
						global.DispelBuffTrap(_env, mycell, global.BUFF_MARKED_ALL(_env, "LIGHTON"))
					end

					for _, uniter in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, uniter, global.BUFF_MARKED_ALL(_env, "Boss_Unique_proud"), 99)
						global.DispelBuff(_env, uniter, global.BUFF_MARKED_ALL(_env, "Skill_WorldBoss_Unique_proud"), 99)
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

				if global.GetSide(_env, _env.unit) == -1 and global.SUMMONS(_env, _env.unit) == false then
					local num = global.GetFriendField(_env, nil, "DieNum")

					global.SetFriendField(_env, nil, num + 1, "DieNum")
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
				local buff_kill = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					display = "BOSS_yujing",
					tags = {
						"STATUS",
						"YDYuan_KillPrepare",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff_kill
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_Enemy_YDYuan_Passive_Bubble = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.TruthBubble(_env, _env.ACTOR)
			end)

			return _env
		end
	}

	return _M
end
