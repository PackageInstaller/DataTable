-- chunkname: @/tmp/or_script/lua_compile/dm/battle/test/DemoSkills.lua

local assert = _G.assert

module("demo")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.DemoNormalSkill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			if _env.ACTOR == nil then
				_env.ACTOR = this.owner
			end

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				this.frag_times[1]
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, {
					1,
					1,
					0
				})
				local result = global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.DemoBuffSkill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			if _env.ACTOR == nil then
				_env.ACTOR = this.owner
			end

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				this.frag_times[1]
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local addatk = global.NumericEffect(_env, "+atk", {
					"+I1"
				}, 10, 30)

				global.ApplyBuff(_env, _env.ACTOR, {
					display = "atk_up",
					group = "G1",
					duration = 5000,
					limit = 2,
					tags = {
						"tag1"
					}
				}, {
					addatk
				})

				local immune = global.ImmuneEffect(_env, "tag1")

				global.ApplyBuff(_env, _env.TARGET, {
					duration = 10000
				}, {
					immune
				})

				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, {
					1,
					1,
					0
				})
				local result = global.ApplyHPDamage(_env, _env.TARGET, damage)
			end)

			return _env
		end
	}
	_M.__all__.DemoRenewCardSkill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			if _env.ACTOR == nil then
				_env.ACTOR = this.owner
			end

			_env.TARGET = externs.TARGET

			assert(_env.TARGET ~= nil, "External variable `TARGET` is not provided.")
			exec["@time"]({
				this.frag_times[1]
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local attacker = global.LoadUnit(_env, _env.ACTOR, "ATTACKER")
				local defender = global.LoadUnit(_env, _env.TARGET, "DEFENDER")
				local damage = global.EvalDamage(_env, attacker, defender, {
					1,
					1,
					0
				})

				global.ApplyHPDamage(_env, _env.TARGET, damage)

				local card = global.GetSkillCardPrototype(_env, _env.ACTOR, "c101")

				if card ~= nil then
					global.RenewSkillCard(_env, _env.ACTOR, card)
				end
			end)

			return _env
		end
	}
	_M.__all__.EmptySkill = {
		__new__ = function(prototype, externs, global)
			return
		end,
		main = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				global.print(_env, "running EmptySkill")
			end)

			return _env
		end
	}

	return _M
end
