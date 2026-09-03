-- chunkname: @/tmp/or_skill/lua_compile/Skill_YMJDe.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_YMJDe_Normal = {
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
				567
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
	_M.__all__.Skill_YMJDe_Proud = {
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
					-1.5,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				633
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
	_M.__all__.Skill_YMJDe_Unique = {
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
			_env.mode = 2

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

				_env.units = global.EnemyUnits(_env, global.TOP_COL + global.BOTTOM_COL)

				if _env.units[1] then
					_env.mode = 1

					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
				else
					_env.mode = 2
					_env.units = global.EnemyUnits(_env, global.MID_COL)

					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end

				global.HarmTargetView(_env, _env.units)
			end)
			exec["@time"]({
				2167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = _env.mode == 1 and global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor) or global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.middmgFactor,
						0
					})
					local row = global.CellRowLocation(_env, global.GetCell(_env, unit))

					global.DelayCall(_env, 167 * (row - 1), global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
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
	_M.__all__.Skill_YMJDe_Passive = {
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
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "YMJDe_Passive_Count"))
				local runtime = 10

				if count == 0 then
					local startcell = global.getCellBySideAndNo(_env, global.GetSide(_env, global.FriendField(_env)), 8)
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"YMJDe_Passive_Count"
						}
					}, {
						buff
					})
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "main_asikeshe",
						pos = global.CellPos(_env, startcell) + {
							0.5,
							-1
						}
					})

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_COL)) do
						if not global.MASTER(_env, unit) then
							local units = global.EnemyUnits(_env, global.ROW_OF(_env, unit) * (global.ABOVE(_env, unit, true) + global.BELOW(_env, unit, true)))

							if #units == 0 then
								global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
							elseif #units == 1 then
								if global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 then
									global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) + 1, runtime, 1)
								else
									global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
								end
							elseif #units == 2 then
								local target

								if (global.PETS - global.SUMMONS)(_env, units[1]) and global.SUMMONS(_env, units[2]) then
									target = units[1]
								elseif global.SUMMONS(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
									target = units[2]
								elseif global.SUMMONS(_env, units[1]) and global.SUMMONS(_env, units[2]) then
									target = units[global.Random(_env, 1, 2)]
								elseif (global.PETS - global.SUMMONS)(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
									target = global.GetCost(_env, units[1]) > global.GetCost(_env, units[2]) and units[1] or global.GetCost(_env, units[1]) < global.GetCost(_env, units[2]) and units[2] or global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 and units[1] or units[2]
								end

								if target and (global.MASTER(_env, target) or global.MARKED(_env, "DAGUN")(_env, target) or global.MARKED(_env, "SP_DDing")(_env, target)) then
									target = nil
								end

								if target then
									local cell = global.GetCell(_env, target)
									local index = global.Random(_env, 1, 4)

									if (global.PETS - global.SUMMONS)(_env, target) then
										for i = 1, 4 do
											if global.GetWindowCard(_env, i, global.GetOwner(_env, target)) == nil then
												index = i

												break
											end
										end

										local card = global.BackToCard_ResultCheck(_env, target, "window", index)

										if card then
											local cardvaluechange = global.CardCostEnchant(_env, "+", this.Energy, 1)

											global.ApplyEnchant(_env, global.GetOwner(_env, target), card, {
												timing = 0,
												duration = 99,
												tags = {
													"CARDBUFF",
													"Skill_YMJDe_Passive",
													"UNDISPELLABLE"
												}
											}, {
												cardvaluechange
											})
										end
									end

									global.Kick(_env, target, true)
									global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
								end
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YMJDe_Proud_EX = {
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
					-1.5,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				633
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "-becuredrate", {
					"+Normal",
					"+Normal"
				}, this.BeCuredRateFactor)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 4,
					display = "BeCuredRateDown",
					group = "Skill_YMJDe_Proud_EX",
					duration = 30,
					limit = 1,
					tags = {
						"NUMERIC",
						"DEBUFF",
						"BECUREDRATEDOWN",
						"DISPELLABLE"
					}
				}, {
					buffeft1
				}, 1, 0)
				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YMJDe_Unique_EX = {
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
			_env.mode = 2

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

				_env.units = global.EnemyUnits(_env, global.TOP_COL + global.BOTTOM_COL)

				local buff = global.NumericEffect(_env, "+def", {
					"+Normal",
					"+Normal"
				}, 0)

				if _env.units[1] then
					_env.mode = 1

					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

					local units_top = global.EnemyUnits(_env, global.TOP_COL)
					local units_bottom = global.EnemyUnits(_env, global.BOTTOM_COL)

					if #units_top > 1 then
						for _, unit in global.__iter__(units_top) do
							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								tags = {
									"YMJDe_Unique_EX"
								}
							}, {
								buff
							})
						end
					end

					if #units_bottom > 1 then
						for _, unit in global.__iter__(units_bottom) do
							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								tags = {
									"YMJDe_Unique_EX"
								}
							}, {
								buff
							})
						end
					end
				else
					_env.mode = 2
					_env.units = global.EnemyUnits(_env, global.MID_COL)

					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))

					if #_env.units > 1 then
						for _, unit in global.__iter__(_env.units) do
							global.ApplyBuff(_env, unit, {
								timing = 0,
								duration = 99,
								tags = {
									"YMJDe_Unique_EX"
								}
							}, {
								buff
							})
						end
					end
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
					global.RetainObject(_env, unit)
				end

				global.HarmTargetView(_env, _env.units)
			end)
			exec["@time"]({
				2167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = _env.mode == 1 and global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor) or global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						this.middmgFactor,
						0
					})

					if global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "YMJDe_Unique_EX")) > 0 then
						damage.val = damage.val * 2
					end

					local row = global.CellRowLocation(_env, global.GetCell(_env, unit))

					global.DelayCall(_env, 167 * (row - 1), global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				3100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "YMJDe_Unique_EX"), 99)
				end

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_YMJDe_Passive_EX = {
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
				local count = global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "YMJDe_Passive_Count"))
				local runtime = 10

				if count == 0 then
					local startcell = global.getCellBySideAndNo(_env, global.GetSide(_env, global.FriendField(_env)), 8)
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, global.FriendField(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"YMJDe_Passive_Count"
						}
					}, {
						buff
					})
					global.AddAnimWithFlip(_env, {
						loop = 1,
						zOrder = "TopLayer",
						isFlipX = false,
						isFlipY = false,
						anim = "main_asikeshe",
						pos = global.CellPos(_env, startcell) + {
							0.5,
							-1
						}
					})

					for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_COL)) do
						if not global.MASTER(_env, unit) then
							local units = global.EnemyUnits(_env, global.ROW_OF(_env, unit) * (global.ABOVE(_env, unit, true) + global.BELOW(_env, unit, true)))

							if #units == 0 then
								global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
							elseif #units == 1 then
								if global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 then
									global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) + 1, runtime, 1)
								else
									global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
								end
							elseif #units == 2 then
								local target

								if (global.PETS - global.SUMMONS)(_env, units[1]) and global.SUMMONS(_env, units[2]) then
									target = units[1]
								elseif global.SUMMONS(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
									target = units[2]
								elseif global.SUMMONS(_env, units[1]) and global.SUMMONS(_env, units[2]) then
									target = units[global.Random(_env, 1, 2)]
								elseif (global.PETS - global.SUMMONS)(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
									target = global.GetCost(_env, units[1]) > global.GetCost(_env, units[2]) and units[1] or global.GetCost(_env, units[1]) < global.GetCost(_env, units[2]) and units[2] or global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 and units[1] or units[2]
								end

								if target and (global.MASTER(_env, target) or global.MARKED(_env, "DAGUN")(_env, target) or global.MARKED(_env, "SP_DDing")(_env, target)) then
									target = nil
								end

								if target then
									local cell = global.GetCell(_env, target)
									local index = global.Random(_env, 1, 4)

									if (global.PETS - global.SUMMONS)(_env, target) then
										for i = 1, 4 do
											if global.GetWindowCard(_env, i, global.GetOwner(_env, target)) == nil then
												index = i

												break
											end
										end

										local card = global.BackToCard_ResultCheck(_env, target, "window", index)

										if card then
											local cardvaluechange = global.CardCostEnchant(_env, "+", this.Energy, 1)

											global.ApplyEnchant(_env, global.GetOwner(_env, target), card, {
												timing = 0,
												duration = 99,
												tags = {
													"CARDBUFF",
													"Skill_YMJDe_Passive",
													"UNDISPELLABLE"
												}
											}, {
												cardvaluechange
											})
										end
									end

									global.Kick(_env, target, true)
									global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
								end
							end
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_YMJDe_Passive_Activity = {
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
				local runtime = 10
				local startcell = global.getCellBySideAndNo(_env, global.GetSide(_env, global.FriendField(_env)), 8)
				local buff = global.NumericEffect(_env, "+defrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"YMJDe_Passive_Count"
					}
				}, {
					buff
				})
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = false,
					isFlipY = false,
					anim = "main_asikeshe",
					pos = global.CellPos(_env, startcell) + {
						0.5,
						-1
					}
				})

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_COL)) do
					if not global.MASTER(_env, unit) then
						local units = global.EnemyUnits(_env, global.ROW_OF(_env, unit) * (global.ABOVE(_env, unit, true) + global.BELOW(_env, unit, true)))

						if #units == 0 then
							global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
						elseif #units == 1 then
							if global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 then
								global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) + 1, runtime, 1)
							else
								global.transportExt_ResultCheck(_env, unit, global.abs(_env, global.IdOfCell(_env, global.GetCell(_env, unit))) - 1, runtime, 1)
							end
						elseif #units == 2 then
							local target

							if (global.PETS - global.SUMMONS)(_env, units[1]) and global.SUMMONS(_env, units[2]) then
								target = units[1]
							elseif global.SUMMONS(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
								target = units[2]
							elseif global.SUMMONS(_env, units[1]) and global.SUMMONS(_env, units[2]) then
								target = units[global.Random(_env, 1, 2)]
							elseif (global.PETS - global.SUMMONS)(_env, units[1]) and (global.PETS - global.SUMMONS)(_env, units[2]) then
								target = global.GetCost(_env, units[1]) > global.GetCost(_env, units[2]) and units[1] or global.GetCost(_env, units[1]) < global.GetCost(_env, units[2]) and units[2] or global.CellColLocation(_env, global.GetCell(_env, units[1])) == 1 and units[1] or units[2]
							end

							if target and (global.MASTER(_env, target) or global.MARKED(_env, "DAGUN")(_env, target) or global.MARKED(_env, "SP_DDing")(_env, target)) then
								target = nil
							end

							if target then
								local cell = global.GetCell(_env, target)
								local index = global.Random(_env, 1, 4)

								if (global.PETS - global.SUMMONS)(_env, target) then
									for i = 1, 4 do
										if global.GetWindowCard(_env, i, global.GetOwner(_env, target)) == nil then
											index = i

											break
										end
									end

									local card = global.BackToCard_ResultCheck(_env, target, "window", index)

									if card then
										local cardvaluechange = global.CardCostEnchant(_env, "+", this.Energy, 1)

										global.ApplyEnchant(_env, global.GetOwner(_env, target), card, {
											timing = 0,
											duration = 99,
											tags = {
												"CARDBUFF",
												"Skill_YMJDe_Passive",
												"UNDISPELLABLE"
											}
										}, {
											cardvaluechange
										})
									end
								end

								global.Kick(_env, target, true)
								global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
							end
						end
					end
				end
			end)

			return _env
		end
	}

	return _M
end
