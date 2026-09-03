-- chunkname: @/tmp/or_skill/lua_compile/Skill_WLSTNCi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__

	function _M.__all__.Chess_Piece(_env, piece, maincell, damagerate, ischange)
		local this, global = _env.this, _env.global
		local target = global.GetCellUnit(_env, maincell)
		local buff = global.NumericEffect(_env, "+def", {
			"+Normal",
			"+Normal"
		}, 0)

		if target and ischange == 0 then
			global.AssignRoles(_env, target, "target")
			global.ApplyStatusEffect(_env, _env.ACTOR, target)
			global.ApplyRPEffect(_env, _env.ACTOR, target)

			local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, target, {
				1,
				damagerate,
				0
			})

			if piece ~= 1 then
				damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, target, {
					1,
					damagerate,
					0
				})
			end

			damage.val = damage.val * 0.7^global.SelectBuffCount(_env, target, global.BUFF_MARKED(_env, "Chess_Count"))

			if piece == 1 then
				global.DelayCall(_env, 120, global.ApplyHPDamage_ResultCheck, _env.ACTOR, target, damage)
			else
				global.DelayCall(_env, 120, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, target, damage)
			end

			global.DelayCall(_env, 120, global.ApplyBuff, target, {
				timing = 0,
				duration = 99,
				tags = {
					"Chess_Count"
				}
			}, {
				buff
			})
			global.DelayCall(_env, 150, global.UnassignRoles, target, "target")
		end

		if piece == 1 then
			if global.CellRowLocation(_env, maincell) == 3 then
				global.Chess_Piece(_env, global.Random(_env, 2, 4), maincell, damagerate, 1)
			else
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_2", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "xbdan_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			end
		elseif piece == 2 then
			if ischange == 1 then
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_2", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "xbshi_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			else
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_3", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "zxshi_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			end

			for _, cell in global.__iter__(global.EnemyCells(_env, global.ROW_CELL_OF(_env, maincell) + global.COL_CELL_OF(_env, maincell) - global.ONESELF_CELL(_env, maincell))) do
				local unit = global.GetCellUnit(_env, cell)

				if unit then
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						damagerate,
						0
					})

					damage.val = damage.val * 0.7^global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"))

					global.DelayCall(_env, 200, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
					global.DelayCall(_env, 200, global.ApplyBuff, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"Chess_Count"
						}
					}, {
						buff
					})
					global.DelayCall(_env, 220, global.UnassignRoles, unit, "target")
				end
			end
		elseif piece == 3 then
			if ischange == 1 then
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_2", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "xbcha_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			else
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_4", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "zjcha_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			end

			for _, cell in global.__iter__(global.EnemyCells(_env, global.DIAGONAL_CELL_OF(_env, maincell) - global.ONESELF_CELL(_env, maincell))) do
				local unit = global.GetCellUnit(_env, cell)

				if unit then
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						damagerate,
						0
					})

					damage.val = damage.val * 0.7^global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"))

					global.DelayCall(_env, 200, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
					global.DelayCall(_env, 200, global.ApplyBuff, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"Chess_Count"
						}
					}, {
						buff
					})
					global.DelayCall(_env, 220, global.UnassignRoles, unit, "target")
				end
			end
		elseif piece == 4 then
			if ischange == 1 then
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_2", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "xbmi_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			else
				global.Sound(_env, "Se_Skill_WLian_Chess_Drop_5", 1)
				global.AddAnimWithFlip(_env, {
					loop = 1,
					zOrder = "TopLayer",
					isFlipX = true,
					isFlipY = false,
					anim = "hhmi_qiatudazhao",
					pos = global.CellPos(_env, maincell) + {
						0.05,
						-0.7
					}
				})
			end

			for _, cell in global.__iter__(global.EnemyCells(_env, global.ROW_CELL_OF(_env, maincell) + global.COL_CELL_OF(_env, maincell) + global.DIAGONAL_CELL_OF(_env, maincell) - global.ONESELF_CELL(_env, maincell))) do
				local unit = global.GetCellUnit(_env, cell)

				if unit then
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						damagerate,
						0
					})

					damage.val = damage.val * 0.7^global.SelectBuffCount(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"))

					global.DelayCall(_env, 200, global.ApplyAOEHPDamage_ResultCheck, _env.ACTOR, unit, damage)
					global.DelayCall(_env, 200, global.ApplyBuff, unit, {
						timing = 0,
						duration = 99,
						tags = {
							"Chess_Count"
						}
					}, {
						buff
					})
					global.DelayCall(_env, 220, global.UnassignRoles, unit, "target")
				end
			end
		end
	end

	_M.__all__.Skill_WLSTNCi_Normal = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill1"))
			end)
			exec["@time"]({
				533
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Chess_Piece(_env, 1, global.GetCell(_env, _env.TARGET), this.dmgFactor[2], 0)
			end)
			exec["@time"]({
				1150
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Proud = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					-0.6,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 1) + global.CELL_IN_POS(_env, 3))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 50, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 4) + global.CELL_IN_POS(_env, 6))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 50, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 8))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * 2

						global.AnimForTrgt(_env, unit, {
							loop = 1,
							anim = "skill_qiatudazhao",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.05
							}
						})
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 200, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Unique = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_QTLJia")
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
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local delaytime = 400

				for i = 1, this.Num do
					local k = global.Random(_env, 1, 100)
					local piece = 1

					if k <= this.Weight[1] then
						piece = 1
					elseif k <= this.Weight[2] then
						piece = 2
					elseif k <= this.Weight[3] then
						piece = 3
					elseif k <= this.Weight[4] then
						piece = 4
					end

					global.DelayCall(_env, delaytime * (i - 1), global.Chess_Piece, piece, global.getCellBySideAndNo(_env, global.GetSide(_env, global.EnemyField(_env)), global.Random(_env, 1, 9)), this.dmgFactor[2], 0)
				end
			end)
			exec["@time"]({
				3650
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Passive = {
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
				local buff_check = global.NumericEffect(_env, "+def", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_Passive_Check"
					}
				}, {
					buff_check
				})

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "WLSTNCi_Passive_Check")) == 1 then
					local RoleModel = {
						"Model_WLSTNCi_King"
					}
					local num = global.GetSufaceIndex(_env, _env.ACTOR)
					local card = global.InheritCard(_env, _env.ACTOR, RoleModel[num + 1], true, true)
					local buff = global.PassiveFunEffectBuff(_env, "Skill_WLSTNCi_Passive_For_King", {
						Ex = 0,
						AoeDeRateFactor = this.AoeDeRateFactor,
						master = _env.ACTOR
					})

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						duration = 99,
						group = "Skill_WLSTNCi_Passive_For_King",
						timing = 0,
						limit = 1,
						tags = {
							"CARDBUFF",
							"Skill_WLSTNCi_Passive_For_King",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
					global.ClearCardFlags(_env, card, {
						"MAGE"
					})
					global.AddCardFlags(_env, card, {
						"King_Check"
					})
					global.AddCardFlags(_env, card, {
						"SUMMONED"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Passive_For_King = {
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

				global.ApplyRPDamage(_env, _env.ACTOR, 9999)

				local buff_mute = global.Daze(_env)
				local buff_norp = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_King"
					}
				}, {
					buff_mute,
					buff_norp
				})

				if this.Ex == 1 then
					local buffeft1 = global.Immune(_env)
					local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEBUFF"))

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 15,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft = global.NumericEffect(_env, "-aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "",
						group = "WLSTNCi_King_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"WLSTNCi_King_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end

				local buff = global.PassiveFunEffectBuff(_env, "WLSTNCi_King_Kick", {
					actor = _env.ACTOR
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_King_Kick"
					}
				}, {
					buff
				})
				global.MarkSummoned(_env, _env.ACTOR, true)
				global.SetSummoner(_env, _env.ACTOR, this.master)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "-aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "",
						group = "WLSTNCi_King_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"WLSTNCi_King_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft
					}, 1, 0)
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
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "WLSTNCi_King_Passive"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.WLSTNCi_King_Kick = {
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

				if _env.unit == this.actor then
					for _, unit in global.__iter__(global.EnemyUnits(_env)) do
						global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "WLSTNCi_King_Passive"), 99)
					end

					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED(_env, "WLSTNCi_King_Kick"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Proud_EX = {
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

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2) + {
					-0.6,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				933
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 1) + global.CELL_IN_POS(_env, 3))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 50, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				1000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 4) + global.CELL_IN_POS(_env, 6))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 50, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				1400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, cell in global.__iter__(global.EnemyCells(_env, global.CELL_IN_POS(_env, 8))) do
					local unit = global.GetCellUnit(_env, cell)

					if unit then
						global.AssignRoles(_env, unit, "target")
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

						damage.val = damage.val * 2

						global.AnimForTrgt(_env, unit, {
							loop = 1,
							anim = "skill_qiatudazhao",
							zOrder = "TopLayer",
							pos = {
								0.45,
								0.05
							}
						})
						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 200, global.UnassignRoles, unit, "target")
					end
				end
			end)
			exec["@time"]({
				2000
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Unique_EX = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_QTLJia")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local delaytime = 300

				for i = 1, this.Num do
					local k = global.Random(_env, 1, 100)
					local piece = 1

					if k <= this.Weight[1] then
						piece = 1
					elseif k <= this.Weight[2] then
						piece = 2
					elseif k <= this.Weight[3] then
						piece = 3
					elseif k <= this.Weight[4] then
						piece = 4
					end

					global.DelayCall(_env, delaytime * (i - 1), global.Chess_Piece, piece, global.getCellBySideAndNo(_env, global.GetSide(_env, global.EnemyField(_env)), global.Random(_env, 1, 9)), this.dmgFactor[2], 0)
				end
			end)
			exec["@time"]({
				3950
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Passive_EX = {
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
				local buff_check = global.NumericEffect(_env, "+def", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_Passive_Check"
					}
				}, {
					buff_check
				})

				if global.SelectBuffCount(_env, global.FriendField(_env), global.BUFF_MARKED(_env, "WLSTNCi_Passive_Check")) == 1 then
					local RoleModel = {
						"Model_WLSTNCi_King"
					}
					local num = global.GetSufaceIndex(_env, _env.ACTOR)
					local card = global.InheritCard(_env, _env.ACTOR, RoleModel[num + 1], true, true)
					local buff = global.PassiveFunEffectBuff(_env, "Skill_WLSTNCi_Passive_For_King", {
						Ex = 1,
						AoeDeRateFactor = this.AoeDeRateFactor,
						master = _env.ACTOR
					})

					global.ApplyHeroCardBuff(_env, global.GetOwner(_env, _env.ACTOR), card, {
						duration = 99,
						group = "Skill_WLSTNCi_Passive_For_King",
						timing = 0,
						limit = 1,
						tags = {
							"CARDBUFF",
							"Skill_WLSTNCi_Passive_For_King",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
					global.ClearCardFlags(_env, card, {
						"MAGE"
					})
					global.AddCardFlags(_env, card, {
						"King_Check"
					})
					global.AddCardFlags(_env, card, {
						"SUMMONED"
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
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Unique_Awaken = {
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

				global.GroundEft(_env, _env.ACTOR, "Ground_QTLJia")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill4"))
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local delaytime = 300

				for i = 1, this.Num do
					local k = global.Random(_env, 1, 100)
					local piece = 1

					if k <= this.Weight[1] then
						piece = 1
					elseif k <= this.Weight[2] then
						piece = 2
					elseif k <= this.Weight[3] then
						piece = 3
					elseif k <= this.Weight[4] then
						piece = 4
					end

					global.DelayCall(_env, delaytime * (i - 1), global.Chess_Piece, piece, global.getCellBySideAndNo(_env, global.GetSide(_env, global.EnemyField(_env)), global.Random(_env, 1, 9)), this.dmgFactor[2], 0)
				end
			end)
			exec["@time"]({
				4150
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "Chess_Count"), 99)
				end

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_WLSTNCi_Passive_SelfAwaken = {
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

				global.ApplyRPDamage(_env, _env.ACTOR, 9999)

				local buff_mute = global.Daze(_env)
				local buff_norp = global.RageGainEffect(_env, "-", {
					"+Normal",
					"+Normal"
				}, 1)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_King"
					}
				}, {
					buff_mute,
					buff_norp
				})

				if this.Ex == 1 then
					local buffeft1 = global.Immune(_env)
					local buffeft2 = global.ImmuneBuff(_env, global.BUFF_MARKED_ANY(_env, "DEBUFF"))

					for _, unit in global.__iter__(global.FriendUnits(_env)) do
						global.ApplyBuff_Buff(_env, _env.ACTOR, unit, {
							timing = 4,
							duration = 15,
							display = "Immune",
							tags = {
								"STATUS",
								"NUMERIC",
								"BUFF",
								"IMMUNE",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1,
							buffeft2
						}, 1, 0)
					end
				end

				if this.MAX == 1 then
					local buffeft3 = global.Daze(_env)

					for _, unit in global.__iter__(global.Slice(_env, global.SortBy(_env, global.EnemyUnits(_env), ">", global.UnitPropGetter(_env, "atk")), 1, 2)) do
						global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
							timing = 1,
							duration = 2,
							display = "Dazed",
							tags = {
								"STATUS",
								"DEBUFF",
								"DAZE",
								"DISPELLABLE"
							}
						}, {
							buffeft3
						}, 1, 0)
					end
				end

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					local buffeft = global.NumericEffect(_env, "-aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, unit, {
						timing = 0,
						display = "",
						group = "WLSTNCi_King_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"WLSTNCi_King_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft
					}, 1, 0)
				end

				local buff = global.PassiveFunEffectBuff(_env, "WLSTNCi_King_Kick", {
					actor = _env.ACTOR
				})

				global.ApplyBuff(_env, global.FriendField(_env), {
					timing = 0,
					duration = 99,
					tags = {
						"WLSTNCi_King_Kick"
					}
				}, {
					buff
				})
				global.MarkSummoned(_env, _env.ACTOR, true)
				global.SetSummoner(_env, _env.ACTOR, this.master)
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

				if global.GetSide(_env, _env.unit) ~= global.GetSide(_env, _env.ACTOR) then
					local buffeft = global.NumericEffect(_env, "-aoederate", {
						"+Normal",
						"+Normal"
					}, this.AoeDeRateFactor)

					global.ApplyBuff_Debuff(_env, _env.ACTOR, _env.unit, {
						timing = 0,
						display = "",
						group = "WLSTNCi_King_Passive",
						duration = 99,
						limit = 1,
						tags = {
							"STATUS",
							"DEBUFF",
							"WLSTNCi_King_Passive",
							"UNDISPELLABLE"
						}
					}, {
						buffeft
					}, 1, 0)
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
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.EnemyUnits(_env)) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED(_env, "WLSTNCi_King_Passive"), 99)
				end
			end)

			return _env
		end
	}

	return _M
end
