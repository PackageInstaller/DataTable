-- chunkname: @/tmp/or_skill/lua_compile/Skill_Enemy_SYJi.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.Skill_SYJi_Master_Unique = {
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

			_env.selectCount = 0
			_env.units = nil

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.Perform(_env, _env.ACTOR, global.CreateSkillAnimation(_env, global.UnitPos(_env, _env.TARGET, 0, nil) + {
					-0.3,
					0
				}, 100, "skill2"))
			end)
			exec["@time"]({
				600
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				_env.units = global.EnemyUnits(_env, global.COL_OF(_env, _env.TARGET))

				global.HarmTargetView(_env, _env.units)
				global.Speak(_env, _env.ACTOR, {
					{
						"混音崩哮炮",
						2500
					}
				}, "", 0)

				for _, unit in global.__iter__(_env.units) do
					global.RetainObject(_env, unit)
					global.AssignRoles(_env, unit, "target")
					global.ApplyStatusEffect(_env, _env.ACTOR, unit)
					global.ApplyRPEffect(_env, _env.ACTOR, unit)

					local damageRadio = 3

					if global.MASTER(_env, unit) then
						-- block empty
					else
						damageRadio = damageRadio * 5
					end

					local damage = global.EvalAOEDamage_FlagCheck(_env, _env.ACTOR, unit, {
						1,
						3,
						0
					})
					local result = global.ApplyRealDamage(_env, _env.ACTOR, unit, 2, 1, damageRadio, 0, 0, damage)
				end
			end)
			exec["@time"]({
				1433
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.EnergyRestrainStop(_env, _env.ACTOR, _env.TARGET)
			end)

			return _env
		end
	}

	return _M
end
