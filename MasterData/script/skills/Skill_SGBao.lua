-- chunkname: @/tmp/or_skill/lua_compile/Skill_SGBao.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SGBao_Normal = {
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
				334
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
	_M.__all__.Skill_SGBao_Proud = {
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
	_M.__all__.Skill_SGBao_Unique = {
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
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.BACK_ROW)[1]

				if target == nil then
					target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.MID_ROW)[1]

					if target == nil then
						target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.FRONT_ROW)[1]
					end
				end

				if target then
					local buffeft = global.Taunt(_env)

					global.ApplyBuff(_env, target, {
						timing = 4,
						duration = 10,
						display = "Taunt",
						tags = {
							"STATUS",
							"TAUNT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SGBao_Passive = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SGBao"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"SGBao_Passive",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
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

				if not global.MASTER(_env, _env.ACTOR) then
					local buffeft = global.EnergyEffect(_env, 1 - this.EnergyFactor)

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 4,
						display = "EnergyEffectDown",
						group = "Skill_SGBao_Passive",
						duration = 12,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"ENERGYEFFECTDOWN",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"SGBao_ENERGYEFFECTDOWN"
						}
					}, {
						buffeft
					})
					global.ShowGrayEnergyEffect(_env, global.GetOwner(_env, _env.ACTOR), true)

					local buff_anim = global.PassiveFunEffectBuff(_env, "Skill_SGBao_Anim")

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"SGBao_ANIM"
						}
					}, {
						buff_anim
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SGBao_Anim = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.buff = externs.buff

			assert(_env.buff ~= nil, "External variable `buff` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.BuffIsMatched(_env, _env.buff, "SGBao_ENERGYEFFECTDOWN") then
					global.ShowGrayEnergyEffect(_env, global.GetOwner(_env, _env.ACTOR), false)
					global.DispelBuff(_env, global.FriendMaster(_env), global.BUFF_MARKED(_env, "SGBao_ANIM"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SGBao_Proud_EX = {
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
				700
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				if global.SelectBuffCount(_env, _env.TARGET, global.BUFF_MARKED(_env, "TAUNT")) > 0 then
					damage.val = damage.val * (1 + this.DamageFactor)
				end

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SGBao_Unique_EX = {
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
				local units_top = global.EnemyUnits(_env, global.TOP_COL)
				local units_mid = global.EnemyUnits(_env, global.MID_COL)
				local units_bottom = global.EnemyUnits(_env, global.BOTTOM_COL)
				local cell = global.CellColLocation(_env, global.GetCell(_env, _env.ACTOR))

				if cell == 1 then
					_env.units = units_top

					if _env.units[1] == nil then
						_env.units = units_mid

						if _env.units[1] == nil then
							_env.units = units_bottom
						end
					end
				elseif cell == 2 then
					_env.units = units_mid

					if _env.units[1] == nil then
						_env.units = units_top

						if _env.units[1] == nil then
							_env.units = units_bottom
						end
					end
				else
					_env.units = units_bottom

					if _env.units[1] == nil then
						_env.units = units_mid

						if _env.units[1] == nil then
							_env.units = units_top
						end
					end
				end

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
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.units[1], 0, nil), 100, "skill3"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2834
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end

				local target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.BACK_ROW)[1]

				if target == nil then
					target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.MID_ROW)[1]

					if target == nil then
						target = global.EnemyUnits(_env, global.COL_OF(_env, _env.units[1]) * global.FRONT_ROW)[1]
					end
				end

				if target then
					local buffeft = global.Taunt(_env)

					global.ApplyBuff(_env, target, {
						timing = 4,
						duration = 10,
						display = "Taunt",
						tags = {
							"STATUS",
							"TAUNT",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft
					})
				end
			end)
			exec["@time"]({
				3167
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SGBao_Passive_EX = {
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

				if global.MASTER(_env, _env.ACTOR) and not global.MARKED(_env, "DAGUN")(_env, _env.ACTOR) and not global.MARKED(_env, "SP_DDing")(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsOfPlayer(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "SGBao"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"SGBao_Passive",
								"UNDISPELLABLE"
							}
						}, {
							cardvaluechange
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

				if not global.MASTER(_env, _env.ACTOR) then
					local buffeft = global.EnergyEffect(_env, 1 - this.EnergyFactor)

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 4,
						display = "EnergyEffectDown",
						group = "Skill_SGBao_Passive",
						duration = 12,
						limit = 1,
						tags = {
							"STATUS",
							"BUFF",
							"ENERGYEFFECTDOWN",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"SGBao_ENERGYEFFECTDOWN"
						}
					}, {
						buffeft
					})
					global.ShowGrayEnergyEffect(_env, global.GetOwner(_env, _env.ACTOR), true)

					local buff_anim = global.PassiveFunEffectBuff(_env, "Skill_SGBao_Anim")

					global.ApplyBuff(_env, global.FriendMaster(_env), {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"UNDISPELLABLE",
							"UNSTEALABLE",
							"SGBao_ANIM"
						}
					}, {
						buff_anim
					})
				end
			end)

			return _env
		end
	}

	return _M
end
