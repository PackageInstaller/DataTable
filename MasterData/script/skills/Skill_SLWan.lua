-- chunkname: @/tmp/or_skill/lua_compile/Skill_SLWan.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SLWan_Normal = {
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
					-1,
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
				local RealDamageFactor = global.SpecialPropGetter(_env, "Skill_SLWan_Passive")(_env, _env.ACTOR)

				damage.val = damage.val * (1 - RealDamageFactor)

				global.ApplyHPDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, damage)
				global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 1, this.dmgFactor[2] * RealDamageFactor, 0, 0, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Proud = {
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
					-1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local RealDamageFactor = global.SpecialPropGetter(_env, "Skill_SLWan_Passive")(_env, _env.ACTOR)

				damage.val = damage.val * (1 - RealDamageFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					433
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
				global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 2, this.dmgFactor[2] * RealDamageFactor, {
					0,
					433
				}, {
					0.5,
					0.5
				}, damage)
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Unique = {
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

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "SLWan_Prepare", "UNDISPELLABLE", "UNSTEALABLE"), 1)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
					global.HarmTargetView(_env, _env.units)
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local RealDamageFactor = global.SpecialPropGetter(_env, "Skill_SLWan_Passive")(_env, _env.ACTOR)

						damage.val = damage.val * (1 - RealDamageFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, unit, 2, 1, this.dmgFactor[2] * RealDamageFactor, 0, 0, damage)
					end
				else
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"SLWan_Prepare",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.SwitchActionTo(_env, "die", "die")
					global.SwitchActionTo(_env, "down", "down")
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "run", "run")
					global.SwitchActionTo(_env, "stand", "stand")
					global.SwitchActionTo(_env, "win", "win")
					global.RemoveStatus(_env, _env.ACTOR, "SLWan_Charged")
				else
					global.AddStatus(_env, _env.ACTOR, "SLWan_Charged")
					global.SwitchActionTo(_env, "die", "die_1")
					global.SwitchActionTo(_env, "down", "down_1")
					global.SwitchActionTo(_env, "hurt1", "hurt1_1")
					global.SwitchActionTo(_env, "run", "run_1")
					global.SwitchActionTo(_env, "stand", "stand_1")
					global.SwitchActionTo(_env, "win", "win_1")
					global.Stop(_env)
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

				if global.BuffIsMatched(_env, _env.buff, "FREEZE") or global.BuffIsMatched(_env, _env.buff, "DAZE") or global.BuffIsMatched(_env, _env.buff, "MUTE") then
					global.SwitchActionTo(_env, "die", "die")
					global.SwitchActionTo(_env, "down", "down")
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "run", "run")
					global.SwitchActionTo(_env, "stand", "stand")
					global.SwitchActionTo(_env, "win", "win")
					global.RemoveStatus(_env, _env.ACTOR, "SLWan_Charged")
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "SLWan_Prepare", "UNDISPELLABLE", "UNSTEALABLE")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageSpdFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Passive = {
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
				local buff = global.SpecialNumericEffect(_env, "+Skill_SLWan_Passive", {
					"+Normal",
					"+Normal"
				}, this.RatioFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"Skill_SLWan_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Passive_Key = {
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

				if global.MARKED(_env, "SLWan")(_env, _env.ACTOR) then
					local buff = global.NumericEffect(_env, "+def", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"Skill_SLWan_Passive_Key",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
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

				if global.MARKED(_env, "SLWan")(_env, _env.ACTOR) and global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "Skill_SLWan_Passive_Key", "UNDISPELLABLE", "UNSTEALABLE")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "Skill_SLWan_Passive_Key", "UNDISPELLABLE", "UNSTEALABLE"), 99)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Proud_EX = {
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
					-1,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				400
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ApplyStatusEffect(_env, _env.ACTOR, _env.TARGET)
				global.ApplyRPEffect(_env, _env.ACTOR, _env.TARGET)

				local damage = global.EvalDamage_FlagCheck(_env, _env.ACTOR, _env.TARGET, this.dmgFactor)
				local RealDamageFactor = global.SpecialPropGetter(_env, "Skill_SLWan_Passive")(_env, _env.ACTOR)

				damage.val = damage.val * (1 - RealDamageFactor)

				global.ApplyHPMultiDamage_ResultCheck(_env, _env.ACTOR, _env.TARGET, {
					0,
					433
				}, global.SplitValue(_env, damage, {
					0.5,
					0.5
				}))
				global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, _env.TARGET, 1, 2, this.dmgFactor[2] * RealDamageFactor, {
					0,
					433
				}, {
					0.5,
					0.5
				}, damage)

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RpFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Unique_EX = {
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

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.DispelBuff(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "SLWan_Prepare", "UNDISPELLABLE", "UNSTEALABLE"), 1)
				end
			end)
			exec["@time"]({
				900
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Focus(_env, _env.ACTOR, global.FixedPos(_env, 0, 0, 2), 1.1, 80)

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil), 100, "skill3"))
					global.HarmTargetView(_env, _env.units)
				else
					global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.FixedPos(_env, 0, 0, 2), 100, "skill3_1"))
				end

				for _, unit in global.__iter__(_env.units) do
					global.AssignRoles(_env, unit, "target")
				end
			end)
			exec["@time"]({
				2100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					for _, unit in global.__iter__(_env.units) do
						global.ApplyStatusEffect(_env, _env.ACTOR, unit)
						global.ApplyRPEffect(_env, _env.ACTOR, unit)

						local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, this.dmgFactor)
						local RealDamageFactor = global.SpecialPropGetter(_env, "Skill_SLWan_Passive")(_env, _env.ACTOR)

						damage.val = damage.val * (1 - RealDamageFactor)

						global.ApplyAOEHPDamage_ResultCheck(_env, _env.ACTOR, unit, damage)
						global.DelayCall(_env, 120, global.ApplyRealDamage, _env.ACTOR, unit, 2, 1, this.dmgFactor[2] * RealDamageFactor, 0, 0, damage)
					end
				else
					local buff = global.NumericEffect(_env, "+defrate", {
						"+Normal",
						"+Normal"
					}, 0)

					global.ApplyBuff(_env, _env.ACTOR, {
						timing = 0,
						duration = 99,
						tags = {
							"STATUS",
							"SLWan_Prepare",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buff
					})
				end
			end)
			exec["@time"]({
				2300
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.INSTATUS(_env, "SLWan_Charged")(_env, _env.ACTOR) then
					global.SwitchActionTo(_env, "die", "die")
					global.SwitchActionTo(_env, "down", "down")
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "run", "run")
					global.SwitchActionTo(_env, "stand", "stand")
					global.SwitchActionTo(_env, "win", "win")
					global.RemoveStatus(_env, _env.ACTOR, "SLWan_Charged")
				else
					global.AddStatus(_env, _env.ACTOR, "SLWan_Charged")
					global.SwitchActionTo(_env, "die", "die_1")
					global.SwitchActionTo(_env, "down", "down_1")
					global.SwitchActionTo(_env, "hurt1", "hurt1_1")
					global.SwitchActionTo(_env, "run", "run_1")
					global.SwitchActionTo(_env, "stand", "stand_1")
					global.SwitchActionTo(_env, "win", "win_1")
					global.Stop(_env)
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

				if global.BuffIsMatched(_env, _env.buff, "FREEZE") or global.BuffIsMatched(_env, _env.buff, "DAZE") or global.BuffIsMatched(_env, _env.buff, "MUTE") then
					global.SwitchActionTo(_env, "die", "die")
					global.SwitchActionTo(_env, "down", "down")
					global.SwitchActionTo(_env, "hurt1", "hurt1")
					global.SwitchActionTo(_env, "run", "run")
					global.SwitchActionTo(_env, "stand", "stand")
					global.SwitchActionTo(_env, "win", "win")
					global.RemoveStatus(_env, _env.ACTOR, "SLWan_Charged")
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

				if global.SelectBuffCount(_env, _env.ACTOR, global.BUFF_MARKED_ALL(_env, "STATUS", "SLWan_Prepare", "UNDISPELLABLE", "UNSTEALABLE")) > 0 then
					global.ApplyRPRecovery(_env, _env.ACTOR, this.RageSpdFactor)
				end
			end)

			return _env
		end
	}
	_M.__all__.Skill_SLWan_Passive_EX = {
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
				local buff = global.SpecialNumericEffect(_env, "+Skill_SLWan_Passive", {
					"+Normal",
					"+Normal"
				}, this.RatioFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"Skill_SLWan_Passive",
						"UNDISPELLABLE",
						"UNSTEALABLE"
					}
				}, {
					buff
				})
			end)

			return _env
		end
	}

	return _M
end
