-- chunkname: @/tmp/or_skill/lua_compile/Skill_XDRLa.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_XDRLa_Normal = {
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
				734
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					467
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
			end)

			return _env
		end
	}
	_M.__all__.Skill_XDRLa_Proud = {
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

			_env.front_units = nil
			_env.mid_units = nil
			_env.back_units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.front_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.FRONT_ROW)

				for _, unit in global.__iter__(_env.front_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target1")
				end

				_env.mid_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.MID_ROW)

				for _, unit in global.__iter__(_env.mid_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target2")
				end

				_env.back_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.BACK_ROW)

				for _, unit in global.__iter__(_env.back_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target3")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.front_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				1034
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.mid_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)
			exec["@time"]({
				1267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.back_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XDRLa_Proud_EX = {
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

			_env.front_units = nil
			_env.mid_units = nil
			_env.back_units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.front_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.FRONT_ROW)

				for _, unit in global.__iter__(_env.front_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target1")
				end

				_env.mid_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.MID_ROW)

				for _, unit in global.__iter__(_env.mid_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target2")
				end

				_env.back_units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET) * global.BACK_ROW)

				for _, unit in global.__iter__(_env.back_units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target3")
				end

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill2"))
			end)
			exec["@time"]({
				800
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.front_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if not global.MARKED(_env, "SummonedNian")(_env, unit) then
						local buffeft1 = global.MaxHpEffect(_env, -damage.val)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)
			exec["@time"]({
				1034
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.mid_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if not global.MARKED(_env, "SummonedNian")(_env, unit) then
						local buffeft1 = global.MaxHpEffect(_env, -damage.val)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)
			exec["@time"]({
				1267
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.back_units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)

					if not global.MARKED(_env, "SummonedNian")(_env, unit) then
						local buffeft1 = global.MaxHpEffect(_env, -damage.val)

						global.ApplyBuff(_env, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"DISPELLABLE",
								"STEALABLE"
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
	_M.__all__.Skill_XDRLa_Unique = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, false)
				end

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.setRootVisible(_env, unit, true)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectTrueBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.HarmTargetView(_env, _env.units)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

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

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167,
						400,
						500,
						834
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25,
						0.25
					}))

					if not global.MASTER(_env, unit) and (global.PETS - global.SUMMONS)(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) == 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local extra_damage = maxHp * this.HealRateFactor

						extra_damage = global.BossDamage(_env, _env.ACTOR, unit, extra_damage)

						global.DelayCall(_env, 300, global.ApplyHPDamage, unit, extra_damage)
					end
				end
			end)
			exec["@time"]({
				4200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, true)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XDRLa_Unique_EX = {
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

				_env.units = global.RandomN(_env, 3, global.EnemyUnits(_env))

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, false)
				end

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.setRootVisible(_env, unit, true)
				end

				global.GroundEft(_env, _env.ACTOR, "BGEffectTrueBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.HarmTargetView(_env, _env.units)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

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

					global.ApplyAOEHPMultiDamage_ResultCheck(_env, _env.ACTOR, unit, {
						0,
						167,
						400,
						500,
						834
					}, global.SplitValue(_env, damage, {
						0.25,
						0.25,
						0.25,
						0.25,
						0.25
					}))

					if not global.MASTER(_env, unit) and (global.PETS - global.SUMMONS)(_env, unit) and global.SelectBuffCount(_env, unit, global.BUFF_MARKED_ANY(_env, "IMMUNE", "GUIDIE_SHENYIN", "Invisible_Immune", "DAGUN_IMMUNE", "SKONG_IMMUNE")) == 0 then
						local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, unit)
						local extra_damage = maxHp * this.HealRateFactor

						extra_damage = global.BossDamage(_env, _env.ACTOR, unit, extra_damage)

						global.DelayCall(_env, 300, global.ApplyHPDamage, unit, extra_damage)

						local buffeft1 = global.MaxHpEffect(_env, -extra_damage)

						global.DelayCall(_env, 300, global.ApplyBuff, unit, {
							timing = 0,
							duration = 99,
							tags = {
								"STATUS",
								"NUMERIC",
								"DEBUFF",
								"DISPELLABLE",
								"STEALABLE"
							}
						}, {
							buffeft1
						})
					end
				end
			end)
			exec["@time"]({
				4200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)

				for _, unit in global.__iter__(global.AllUnits(_env, -global.ONESELF(_env, _env.ACTOR))) do
					global.setRootVisible(_env, unit, true)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XDRLa_Passive = {
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

				if global.MASTER(_env, _env.ACTOR) then
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "XDRLa"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_BHTZi_Passive_Awaken"
							}
						}, {
							cardvaluechange
						})
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "XDRLa"))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_XDRLa_Passive_EX = {
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
					for _, card in global.__iter__(global.CardsInWindow(_env, global.GetOwner(_env, _env.ACTOR), global.CARD_HERO_MARKED(_env, "XDRLa"))) do
						local cardvaluechange = global.CardCostEnchant(_env, "-", this.CostFactor, 1)

						global.ApplyEnchant(_env, global.GetOwner(_env, _env.ACTOR), card, {
							tags = {
								"CARDBUFF",
								"UNDISPELLABLE",
								"Skill_BHTZi_Passive_Awaken"
							}
						}, {
							cardvaluechange
						})
					end

					for _, unit in global.__iter__(global.FriendUnits(_env, global.MARKED(_env, "XDRLa"))) do
						global.ApplyRPRecovery(_env, unit, this.RageFactor)
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

				if global.MARKED(_env, "XDRLa")(_env, _env.ACTOR) and not global.MASTER(_env, _env.ACTOR) and global.FriendMaster(_env) then
					global.CloneBuff(_env, _env.ACTOR, global.FriendMaster(_env), global.BUFF_MARKED_ALL(_env, "BUFF"))
				end
			end)

			return _env
		end
	}

	return _M
end
