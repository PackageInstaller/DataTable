-- chunkname: @/tmp/or_skill/lua_compile/Skill_Master_LiMing.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Sk_Master_LiMing_Attack = {
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
					-0.9,
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
	_M.__all__.Sk_Master_LiMing_Action1 = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.RetainObject(_env, _env.TARGET)
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-0.9,
					0
				}, 100, "skill2"))
				global.HarmTargetView(_env, _env.TARGET)
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				1567
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.TARGET)
				local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR)

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)

				local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING"))
				local exdamage = global.min(_env, maxHp * this.HpRateFactor * count, atk * count * 1)

				global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 1, 0, 0, 0, nil, exdamage)
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_LiMing_Action2 = {
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

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) * {
					0,
					1
				} + {
					0.2,
					0
				}, 100, "skill4"))
				global.HarmTargetView(_env, _env.units)

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				1500
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, enemyunit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, enemyunit)
					global.ApplyRPEffect(_env, _env.ACTOR, enemyunit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, enemyunit, this.dmgFactor)
					local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING"))

					damage.val = damage.val * (1 - this.RealDamageFactor * count)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, enemyunit, damage)
					global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, enemyunit, 2, 1, this.dmgFactor[2] * this.RealDamageFactor * count, 0, 0, damage)
				end
			end)
			exec["@time"]({
				1850
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Sk_Master_LiMing_Action3 = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkFactor)
				local buffeft2 = global.PassiveFunEffectBuff(_env, "RpUpUp_LiMing", {
					Factor = this.RpFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Master_LiMing_RpUpUp",
					timing = 0,
					limit = 1,
					tags = {
						"PASSIVEBUFF",
						"RpUpUp",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING")) < 6 then
					global.DelayCall(_env, 1100, global.ApplyBuff_Buff, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"SHINING",
							"Sk_Master_LiMing_Action3",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
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

				global.StackSkill(_env, "Sk_Action3_Master_LiMing", 0, 6)
				global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_1")
			end)

			return _env
		end
	}
	_M.__all__.RpUpUp_LiMing = {
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

				global.ApplyRPRecovery(_env, _env.ACTOR, this.Factor * global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING")))
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
				local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING"))

				global.StackSkill(_env, "Sk_Action3_Master_LiMing", count, 6)

				if global.INSTATUS(_env, "LiMing_STATUS_1")(_env, _env.ACTOR) and count == 2 then
					global.RemoveStatus(_env, _env.ACTOR, "LiMing_STATUS_1")
					global.ActionChange(_env, 2)
					global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_2")
				end

				if global.INSTATUS(_env, "LiMing_STATUS_2")(_env, _env.ACTOR) and count == 4 then
					global.RemoveStatus(_env, _env.ACTOR, "LiMing_STATUS_2")
					global.ActionChange(_env, 3)
					global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_3")
				end
			end)

			return _env
		end
	}

	function _M.__all__.ActionChange(_env, num)
		local this, global = _env.this, _env.global

		if num == 1 then
			-- block empty
		end

		if num == 2 then
			global.SwitchActionTo(_env, "die", "die_2")
			global.SwitchActionTo(_env, "down", "down_2")
			global.SwitchActionTo(_env, "hurt1", "hurt1_2")
			global.SwitchActionTo(_env, "run", "run_2")
			global.SwitchActionTo(_env, "stand", "stand_2")
			global.SwitchActionTo(_env, "win", "win_2")
			global.SwitchActionTo(_env, "skill1", "skill1_2")
			global.SwitchActionTo(_env, "skill2", "skill2_2")
			global.SwitchActionTo(_env, "skill3", "skill3_2")
			global.SwitchActionTo(_env, "skill4", "skill4_2")
		end

		if num == 3 then
			global.SwitchActionTo(_env, "die", "die_3")
			global.SwitchActionTo(_env, "down", "down_3")
			global.SwitchActionTo(_env, "hurt1", "hurt1_3")
			global.SwitchActionTo(_env, "run", "run_3")
			global.SwitchActionTo(_env, "stand", "stand_3")
			global.SwitchActionTo(_env, "win", "win_3")
			global.SwitchActionTo(_env, "skill1", "skill1_3")
			global.SwitchActionTo(_env, "skill2", "skill2_3")
			global.SwitchActionTo(_env, "skill3", "skill3_3")
			global.SwitchActionTo(_env, "skill4", "skill4_3")
		end
	end

	_M.__all__.EquipSkill_LiMing_4 = {
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

				global.GroundEft(_env, _env.ACTOR, "BGEffectBlack")
				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)

				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, 0)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 2,
					duration = 1,
					display = "Prepare",
					tags = {
						"PREPARE"
					}
				}, {
					buffeft1
				})
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))
			end)
			exec["@time"]({
				1800
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local buffeft1 = global.NumericEffect(_env, "+atkrate", {
					"+Normal",
					"+Normal"
				}, this.AtkFactor)
				local buffeft2 = global.PassiveFunEffectBuff(_env, "RpUpUp_LiMing_1", {
					Factor = this.RpFactor
				})

				global.ApplyBuff(_env, _env.ACTOR, {
					duration = 99,
					group = "Master_LiMing_RpUpUp",
					timing = 0,
					limit = 1,
					tags = {
						"PASSIVEBUFF",
						"RpUpUp",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buffeft2
				})

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING")) < 6 then
					global.DelayCall(_env, 1100, global.ApplyBuff_Buff, _env.ACTOR, _env.ACTOR, {
						timing = 0,
						duration = 99,
						display = "AtkUp",
						tags = {
							"NUMERIC",
							"BUFF",
							"ATKUP",
							"SHINING",
							"EquipSkill_LiMing_4",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					}, 1)
				end
			end)
			exec["@time"]({
				2900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
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

				global.StackSkill(_env, "EquipSkill_LiMing_4", 0, 6)
				global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_1")
			end)

			return _env
		end
	}
	_M.__all__.RpUpUp_LiMing_1 = {
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

				global.ApplyRPRecovery(_env, _env.ACTOR, this.Factor * global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING")))
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
				local count = global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED(_env, "SHINING"))

				global.StackSkill(_env, "EquipSkill_LiMing_4", count, 6)

				if global.INSTATUS(_env, "LiMing_STATUS_1")(_env, _env.ACTOR) and count == 2 then
					global.RemoveStatus(_env, _env.ACTOR, "LiMing_STATUS_1")
					global.ActionChange(_env, 2)
					global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_2")
				end

				if global.INSTATUS(_env, "LiMing_STATUS_2")(_env, _env.ACTOR) and count == 4 then
					global.RemoveStatus(_env, _env.ACTOR, "LiMing_STATUS_2")
					global.ActionChange(_env, 3)
					global.AddStatus(_env, _env.ACTOR, "LiMing_STATUS_3")
				end
			end)

			return _env
		end
	}

	function _M.__all__.ActionChange(_env, num)
		local this, global = _env.this, _env.global

		if num == 1 then
			-- block empty
		end

		if num == 2 then
			global.SwitchActionTo(_env, "die", "die_2")
			global.SwitchActionTo(_env, "down", "down_2")
			global.SwitchActionTo(_env, "hurt1", "hurt1_2")
			global.SwitchActionTo(_env, "run", "run_2")
			global.SwitchActionTo(_env, "stand", "stand_2")
			global.SwitchActionTo(_env, "win", "win_2")
			global.SwitchActionTo(_env, "skill1", "skill1_2")
			global.SwitchActionTo(_env, "skill2", "skill2_2")
			global.SwitchActionTo(_env, "skill3", "skill3_2")
			global.SwitchActionTo(_env, "skill4", "skill4_2")
		end

		if num == 3 then
			global.SwitchActionTo(_env, "die", "die_3")
			global.SwitchActionTo(_env, "down", "down_3")
			global.SwitchActionTo(_env, "hurt1", "hurt1_3")
			global.SwitchActionTo(_env, "run", "run_3")
			global.SwitchActionTo(_env, "stand", "stand_3")
			global.SwitchActionTo(_env, "win", "win_3")
			global.SwitchActionTo(_env, "skill1", "skill1_3")
			global.SwitchActionTo(_env, "skill2", "skill2_3")
			global.SwitchActionTo(_env, "skill3", "skill3_3")
			global.SwitchActionTo(_env, "skill4", "skill4_3")
		end
	end

	return _M
end
