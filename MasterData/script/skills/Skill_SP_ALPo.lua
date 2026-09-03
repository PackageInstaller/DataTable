-- chunkname: @/tmp/or_skill/lua_compile/Skill_SP_ALPo.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SP_ALPo_Normal = {
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
				533
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
	_M.__all__.Skill_SP_ALPo_Proud = {
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
					-2.1,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					100,
					200,
					300,
					400
				}, global.SplitValue(_env, damage, {
					0.14,
					0.15,
					0.16,
					0.17,
					0.38
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Unique = {
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
			_env.mode = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				if #_env.units < 4 then
					_env.mode = 1
					_env.units = global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET))
				elseif #_env.units < 7 then
					_env.mode = 2
					_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))
				elseif #_env.units < 10 then
					_env.mode = 3
					_env.units = global.EnemyUnits(_env)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if _env.mode == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
						0,
						0
					}, 100, "skill3"))
				elseif _env.mode == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
				end

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")

					if _env.mode ~= 3 then
						global.DelayCall(_env, 233, global.AnimForTrgt, unit, {
							loop = 1,
							anim = "main_lijiya",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.45
							}
						})
					end
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_ALPo")

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					if _env.mode == 1 then
						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local buff = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 14,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buff
						}, 1, 0)
						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					elseif _env.mode == 2 then
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local buff = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 14,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buff
						}, 1, 0)

						damage.val = damage.val * 0.7

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					else
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					end
				end
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Passive = {
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

				if global.CellColLocation(_env, global.GetCell(_env, _env.unit)) == global.CellColLocation(_env, global.GetCell(_env, _env.ACTOR)) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local cell = global.RandomN(_env, 1, global.FriendCells(_env, global.EMPTY_CELL(_env)))
					local target_cell = global.FriendCells(_env, global.MID_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

					if target_cell[1] then
						cell = global.RandomN(_env, 1, target_cell)
					else
						target_cell = global.FriendCells(_env, global.BACK_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

						if target_cell[1] then
							cell = global.RandomN(_env, 1, target_cell)
						else
							target_cell = global.FriendCells(_env, global.FRONT_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

							if target_cell[1] then
								cell = global.RandomN(_env, 1, target_cell)
							end
						end
					end

					if cell[1] then
						global.transportExt_ResultCheck(_env, _env.ACTOR, global.IdOfCell(_env, cell[1]), 100)
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_SP_ALPo_Passive_Check")) == 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+Skill_SP_ALPo_Passive_Check", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_SP_ALPo_Passive_Check",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					local buff = global.PassiveFunEffectBuff(_env, "Skill_SP_ALPo_Revive", {
						HpFactor = this.HpFactor,
						RpFactor = this.RpFactor
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_SP_ALPo_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Revive = {
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

			_env.isRevive = externs.isRevive

			assert(_env.isRevive ~= nil, "External variable `isRevive` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.isRevive == true then
					for _, unit in global.__iter__(global.FriendDiedUnits(_env, global.MARKED(_env, "SP_ALPo"))) do
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							5,
							4,
							6,
							8,
							7,
							9,
							2,
							1,
							3
						}, unit)

						if reviveunit then
							global.AddStatus(_env, reviveunit, "SP_ALPo_Passive_Revive")
							global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "Skill_SP_ALPo_Passive", "UNDISPELLABLE", "UNSTEALABLE"), 99)
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

			_env.isTransform = externs.isTransform

			assert(_env.isTransform ~= nil, "External variable `isTransform` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) and _env.isTransform == true then
					for _, unit in global.__iter__(global.FriendDiedUnits(_env, global.MARKED(_env, "SP_ALPo"))) do
						local reviveunit = global.Revive_Check(_env, _env.ACTOR, this.HpFactor, this.RpFactor, {
							5,
							4,
							6,
							8,
							7,
							9,
							2,
							1,
							3
						}, unit)

						if reviveunit then
							global.AddStatus(_env, reviveunit, "SP_ALPo_Passive_Revive")
							global.DispelBuff(_env, global.FriendField(_env), global.BUFF_MARKED_ALL(_env, "Skill_SP_ALPo_Passive", "UNDISPELLABLE", "UNSTEALABLE"), 99)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Proud_EX = {
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
					-2.1,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				767
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local buff = global.Mute(_env)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 4,
					duration = 14,
					display = "Mute",
					tags = {
						"STATUS",
						"DEBUFF",
						"MUTE",
						"ABNORMAL",
						"DISPELLABLE"
					}
				}, {
					buff
				}, 1, 0)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Unique_EX = {
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
			_env.mode = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				if #_env.units < 4 then
					_env.mode = 1
					_env.units = global.EnemyUnits(_env, global.ONESELF(_env, _env.TARGET))
				elseif #_env.units < 7 then
					_env.mode = 2
					_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))
				elseif #_env.units < 10 then
					_env.mode = 3
					_env.units = global.EnemyUnits(_env)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if _env.mode == 1 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
						0,
						0
					}, 100, "skill3"))
				elseif _env.mode == 2 then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
				end

				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")

					if _env.mode ~= 3 then
						global.DelayCall(_env, 233, global.AnimForTrgt, unit, {
							loop = 1,
							anim = "main_lijiya",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.45
							}
						})
					end
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.GroundEft(_env, _env.ACTOR, "Ground_SP_ALPo")

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local aoederate = global.UnitPropGetter(_env, "aoederate")(_env, unit)
					local buff = global.NumericEffect(_env, "-aoederate", {
						"+Normal",
						"+Normal"
					}, aoederate * 0.4)

					global.ApplyBuff(_env, unit, {
						timing = 1,
						duration = 1,
						tags = {
							"SP_ALPo_Unique_EX"
						}
					}, {
						buff
					})

					if _env.mode == 1 then
						local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local buff = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 14,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buff
						}, 1, 0)
						global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					elseif _env.mode == 2 then
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local buff = global.Mute(_env)

						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 14,
							display = "Mute",
							tags = {
								"STATUS",
								"DEBUFF",
								"MUTE",
								"ABNORMAL",
								"DISPELLABLE"
							}
						}, {
							buff
						}, 1, 0)

						damage.val = damage.val * 0.7

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					else
						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
							0,
							33,
							67,
							133,
							233,
							333
						}, global.SplitValue(_env, damage, {
							0.14,
							0.15,
							0.16,
							0.17,
							0.18,
							0.2
						}))
					end

					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "SP_ALPo_Unique_EX"), 99)
				end
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SP_ALPo_Passive_EX = {
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

				if global.CellColLocation(_env, global.GetCell(_env, _env.unit)) == global.CellColLocation(_env, global.GetCell(_env, _env.ACTOR)) and global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local cell = global.RandomN(_env, 1, global.FriendCells(_env, global.EMPTY_CELL(_env)))
					local target_cell = global.FriendCells(_env, global.MID_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

					if target_cell[1] then
						cell = global.RandomN(_env, 1, target_cell)
					else
						target_cell = global.FriendCells(_env, global.BACK_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

						if target_cell[1] then
							cell = global.RandomN(_env, 1, target_cell)
						else
							target_cell = global.FriendCells(_env, global.FRONT_ROW_CELL * global.EMPTY_CELL(_env) - global.COL_CELL_OF(_env, _env.ACTOR))

							if target_cell[1] then
								cell = global.RandomN(_env, 1, target_cell)
							end
						end
					end

					if cell[1] then
						global.transportExt_ResultCheck(_env, _env.ACTOR, global.IdOfCell(_env, cell[1]), 100)
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

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "Skill_SP_ALPo_Passive_Check")) == 0 then
					local buffeft = global.SpecialNumericEffect(_env, "+Skill_SP_ALPo_Passive_Check", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_SP_ALPo_Passive_Check",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})

					local buff = global.PassiveFunEffectBuff(_env, "Skill_SP_ALPo_Revive", {
						HpFactor = this.HpFactor,
						RpFactor = this.RpFactor
					})

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_SP_ALPo_Passive",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)

			return _env
		end
	}

	return _M
end
