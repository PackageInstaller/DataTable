-- chunkname: @/tmp/or_skill/lua_compile/Skill_BDFen.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_BDFen_Normal = {
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
					-1.5,
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
	_M.__all__.Skill_BDFen_Proud = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local buffeft = global.Daze(_env)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					duration = 1,
					display = "Daze",
					tags = {
						"STATUS",
						"DEBUFF",
						"DAZE",
						"ABNORMAL",
						"DISPELLALBE"
					}
				}, {
					buffeft
				}, 1, 0)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDFen_Unique = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local runtime = 1366

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
						if global.GetCellUnit(_env, cell) then
							-- block empty
						else
							global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
						end
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					if global.MASTER(_env, unit) then
						-- block empty
					else
						for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
							if global.GetCellUnit(_env, cell) then
								for _, cell_else in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, cell) * global.MID_ROW_CELL)) do
									if global.GetCellUnit(_env, cell_else) then
										-- block empty
									else
										global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell_else), runtime, 1)
									end
								end
							else
								global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
							end
						end
					end
				end

				local num = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					num = num + 1
				end

				if num == 1 then
					-- block empty
				else
					_env.units = global.EnemyUnits(_env, global.FRONT_ROW)
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2366
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
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDFen_Passive = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_hurtrate", {
					"?Normal"
				}, this.ExDamageFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
					"?Normal"
				}, this.ExDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_BDFen_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
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
	_M.__all__.Skill_BDFen_Passive_Key = {
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
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "BDFen"))) do
						local cost = global.GetCardCost(_env, card)
						local cardvaluechange = global.CardCostEnchant(_env, "-", 1, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"Skill_BLTu_PGNNi",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
						})
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDFen_Proud_EX = {
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
					-1.3,
					0
				}, 100, "skill2"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				667
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local buffeft = global.Daze(_env)

				global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.TARGET, {
					timing = 2,
					duration = 1,
					display = "Daze",
					tags = {
						"STATUS",
						"DEBUFF",
						"DAZE",
						"ABNORMAL",
						"DISPELLALBE"
					}
				}, {
					buffeft
				}, 1, 0)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDFen_Unique_EX = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local runtime = 1366

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
						if global.GetCellUnit(_env, cell) then
							-- block empty
						else
							global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
						end
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					if global.MASTER(_env, unit) then
						-- block empty
					else
						for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
							if global.GetCellUnit(_env, cell) then
								for _, cell_else in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, cell) * global.MID_ROW_CELL)) do
									if global.GetCellUnit(_env, cell_else) then
										-- block empty
									else
										global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell_else), runtime, 1)
									end
								end
							else
								global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
							end
						end
					end
				end

				local num = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					num = num + 1
				end

				if num == 1 then
					-- block empty
				else
					_env.units = global.EnemyUnits(_env, global.FRONT_ROW)
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2366
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
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_BDFen_Passive_EX = {
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
				local buffeft1 = global.SpecialNumericEffect(_env, "+Mage_DmgExtra_hurtrate", {
					"?Normal"
				}, this.ExDamageFactor)
				local buffeft2 = global.SpecialNumericEffect(_env, "+Assassin_DmgExtra_hurtrate", {
					"?Normal"
				}, this.ExDamageFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Skill_BDFen_Passive",
					timing = 0,
					limit = 1,
					tags = {
						"NUMERIC",
						"BUFF",
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
	_M.__all__.Skill_BDFen_Unique_Awaken = {
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

				_env.units = global.EnemyUnits(_env, global.ROW_OF(_env, _env.TARGET))

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.FriendUnits(_env, global.PETS - global.SUMMONS)) do
					local buff1 = global.NumericEffect(_env, "+hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)
					local buff2 = global.NumericEffect(_env, "+absorption", {
						"+Normal",
						"+Normal"
					}, this.AbsFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 2,
						display = "HurtRateUp",
						group = "Skill_BDFen_Unique_Awaken_1",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff1
					}, 1, 0)
					global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
						timing = 2,
						display = "Absorption",
						group = "Skill_BDFen_Unique_Awaken_2",
						duration = 2,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff2
					}, 1, 0)
				end

				local runtime = 1366

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.MID_ROW)) do
					for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
						if global.GetCellUnit(_env, cell) then
							-- block empty
						else
							global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
						end
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env, global.BACK_ROW)) do
					if global.MASTER(_env, unit) then
						-- block empty
					else
						for _, cell in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, global.GetCell(_env, unit)) * global.FRONT_ROW_CELL)) do
							if global.GetCellUnit(_env, cell) then
								for _, cell_else in global.__iter__(global.EnemyCells(_env, global.COL_CELL_OF(_env, cell) * global.MID_ROW_CELL)) do
									if global.GetCellUnit(_env, cell_else) then
										-- block empty
									else
										global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell_else), runtime, 1)
									end
								end
							else
								global.transportExt_ResultCheck(_env, unit, global.IdOfCell(_env, cell), runtime, 1)
							end
						end
					end
				end

				local num = 0

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					num = num + 1
				end

				if num == 1 then
					-- block empty
				else
					_env.units = global.EnemyUnits(_env, global.FRONT_ROW)
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2366
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				for _, friend in global.__iter__(global.FriendUnits(_env)) do
					local buffeft2 = global.RageGainEffect(_env, "-", {
						"+Normal",
						"+Normal"
					}, 1)
					local buffeft3 = global.Diligent(_env)

					global.ApplyBuff_Buff(_env, _env.ACTOR, friend, {
						timing = 2,
						duration = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2,
						buffeft3
					}, 1)
				end

				global.DiligentRound(_env)
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
