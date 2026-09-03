-- chunkname: @/tmp/or_skill/lua_compile/Skill_Resource_Gold.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_Resource_Gold_LMao_Skill = {
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

				global.EnergyRestrain(_env, _env.ACTOR, _env.TARGET)
				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET) + {
					-1.5,
					0
				}, 100, "skill2"))
				global.HarmTargetView(_env, {
					_env.TARGET
				})
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
			exec["@time"]({
				1100
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Resource_Gold_LMao_Flee_Time = {
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

				global.WontDie(_env)
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.ForceFlee(_env, 600)
			end)

			return _env
		end
	}
	_M.__all__.Skill_Resource_Gold_LMao_Passive = {
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
				local buffeft1 = global.NumericEffect(_env, "+unhurtrate", {
					"+Normal",
					"+Normal"
				}, this.UnHurtRateFactor)
				local buffeft2 = global.NumericEffect(_env, "-aoederate", {
					"+Normal",
					"+Normal"
				}, this.AOEDeRateFactor)

				global.ApplyBuff(_env, _env.ACTOR, {
					timing = 0,
					duration = 99,
					tags = {
						"STATUS",
						"NUMERIC",
						"BUFF",
						"SINGLEDERATEUP",
						"UNDISPELLABLE",
						"UNSTEALABLE",
						"Skill_Resource_Gold_LMao_Passive"
					}
				}, {
					buffeft1,
					buffeft2
				})
			end)

			return _env
		end
	}

	return _M
end
