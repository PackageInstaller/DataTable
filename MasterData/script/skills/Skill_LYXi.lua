-- chunkname: @/tmp/or_skill/lua_compile/Skill_LYXi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_LYXi_Normal = {
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
				}, 100, "skill1"))
				global.AssignRoles(_env, _env.TARGET, "target")
			end)
			exec["@time"]({
				500
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
	_M.__all__.Skill_LYXi_Proud = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.8,
					0
				}, 100, "skill2"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				570
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Unique = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				_env.units = global.FriendUnits(_env)

				global.HealTargetView(_env, _env.units)
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal)

					local buffeft1 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "DefUp",
						group = "Skill_LYXi_Unique_atk",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"DEFUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_LYXi_Unique_def",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"ATKUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						duration = 99,
						display = "Heal",
						tags = {
							"DEFRATE",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Passive = {
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
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit1 in global.__iter__(global.FriendUnits(_env)) do
					if global.MARKED(_env, "LYXi")(_env, unit1) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
						if global.MARKED(_env, "LYXi")(_env, _env.unit) then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 3
							local heal = global.min(_env, maxHp * this.CureFactor * 2, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						elseif global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 3
							local heal = global.min(_env, maxHp * this.CureFactor * 2, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						else
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.5
							local heal = global.min(_env, maxHp * this.CureFactor, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						end
					end
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Proud_EX = {
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

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.8,
					0
				}, 100, "skill2"))

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				570
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit in global.__iter__(global.RandomN(_env, 1, global.FriendUnits(_env, global.PETS))) do
					global.DispelBuff(_env, unit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)
				end

				for _, unit in global.__iter__(_env.units) do
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)

					global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Unique_EX = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				_env.units = global.FriendUnits(_env)

				global.HealTargetView(_env, _env.units)
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal)

					local buffeft1 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "DefUp",
						group = "Skill_LYXi_Unique_atk",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"DEFUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_LYXi_Unique_def",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"ATKUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						duration = 99,
						display = "Heal",
						tags = {
							"DEFRATE",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Unique_Awaken = {
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
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3"))

				_env.units = global.FriendUnits(_env)

				global.HealTargetView(_env, _env.units)
			end)
			exec["@time"]({
				1200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, friendunit in global.__iter__(_env.units) do
					global.DispelBuff(_env, friendunit, global.BUFF_MARKED_ALL(_env, "DEBUFF", "DISPELLABLE"), 1)

					local heal = global.EvalRecovery_FlagCheck(_env, _env.ACTOR, friendunit, this.HealRateFactor, 0)

					global.ApplyHPRecovery_ResultCheck(_env, _env.ACTOR, friendunit, heal)

					local buffeft1 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft2 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.ExFactor)
					local buffeft3 = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "DefUp",
						group = "Skill_LYXi_Unique_atk",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"DEFUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						display = "AtkUp",
						group = "Skill_LYXi_Unique_def",
						duration = 99,
						limit = 1,
						tags = {
							"BUFF",
							"ATKUP",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft2
					})
					global.ApplyBuff(_env, friendunit, {
						timing = 0,
						duration = 99,
						display = "Heal",
						tags = {
							"DEFRATE",
							"HEAL",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft3
					})
				end
			end)
			exec["@time"]({
				3200
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_LYXi_Passive_EX = {
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
				100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				for _, unit1 in global.__iter__(global.FriendUnits(_env)) do
					if global.MARKED(_env, "LYXi")(_env, unit1) and global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) then
						if global.MARKED(_env, "LYXi")(_env, _env.unit) then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 3
							local heal = global.min(_env, maxHp * this.CureFactor * 2, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						elseif global.MARKED(_env, "WARRIOR")(_env, _env.unit) then
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 3
							local heal = global.min(_env, maxHp * this.CureFactor * 2, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						else
							local maxHp = global.UnitPropGetter(_env, "maxHp")(_env, _env.unit)
							local atk = global.UnitPropGetter(_env, "atk")(_env, _env.ACTOR) * 1.5
							local heal = global.min(_env, maxHp * this.CureFactor, atk)

							global.ApplyHPRecovery(_env, _env.unit, heal)
						end
					end
				end
			end)

			return _env
		end
	}

	return _M
end
